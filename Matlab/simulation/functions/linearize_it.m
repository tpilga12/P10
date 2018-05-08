function [sys] = linearize_it(pipe_spec,nr_tanks, tank_spec,sys_setup,input,data)
%LINEARIZE_IT Summary of this function goes here
%   Linearization of pipe_setup
%%%% temp stuff so things can be tested
% clear all
% clc
% load('lin_it_test_data2.mat')
% data = init_data;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global Dt

% dimension = sum([pipe_spec(:).sections]); % matrix dimensions for linearized pipes
dimension = sys_setup(end).sections;
add_states = 2; % additional states needed for change in output

A = zeros(dimension+add_states);  F = eye(dimension+add_states); 
B(1+nr_tanks:dimension+add_states,1) = 0; B_2(1:dimension+add_states,1) = 0; Bd(1:dimension+add_states,1) = 0; C(1:dimension+add_states) = 0;
StateName = cell(dimension+add_states,1);
s_c = 1; %state counter
section = 1; %keeps track of which cell data should be fetched in data
pipe_fetch = 1;
tank_counter = 1;
new_pipe_section = 1;
for run = 1:length(sys_setup)-1
    if strcmp(sys_setup(run).type,'Tank') == 1
        section = section + 1;
        F(s_c,s_c) = 1;
        A(s_c,s_c) = 1;
        
        B_2(s_c,1) = 1;
        %Bd(s_c,1) = 1;
        B(s_c,1+tank_counter) = lin_tank(input.u_init(1,tank_counter), tank_spec(tank_counter), data{section}.fitfunc, 'a');
        B(s_c+1,1+tank_counter) = lin_tank(input.u_init(1,tank_counter), tank_spec(tank_counter), data{section}.fitfunc, 'b');
       
        StateName{s_c,1} = ['Tank_',num2str(tank_counter)];
        s_c = s_c + 1;
        new_pipe_section = 1;
        tank_counter = tank_counter +1;
    else
        for n = 1:sys_setup(run).component
            k = 1;
            for m = s_c:(s_c+pipe_spec(pipe_fetch).sections-1)
                if  n == 1 && new_pipe_section == 1
                    new_pipe_section = 0;
                    F(s_c,s_c)   = lin_pipe(data{section}.h(1,k), pipe_fetch, pipe_spec, 'b');
                    A(s_c,s_c)   = lin_pipe(data{section}.h(1,k), pipe_fetch, pipe_spec, 'd');
                    B(s_c,1)=[lin_pipe(data{section}.h(1,1), pipe_fetch, pipe_spec, 'c')-lin_pipe(data{section}.h(1,1), pipe_fetch, pipe_spec, 'a')];
      
                else
                    
                    F(s_c,s_c-1) = lin_pipe(data{section}.h(1,k), pipe_fetch, pipe_spec, 'a');
                    F(s_c,s_c)   = lin_pipe(data{section}.h(1,k), pipe_fetch, pipe_spec, 'b');
                    A(s_c,s_c-1) = lin_pipe(data{section}.h(1,k), pipe_fetch, pipe_spec, 'c');
                    A(s_c,s_c)   = lin_pipe(data{section}.h(1,k), pipe_fetch, pipe_spec, 'd');
                end
               
               StateName{s_c,1} = ['h_pipe_',num2str(pipe_fetch),'_',num2str(k)];
               k = k +1;
               s_c = s_c+1;
            end
            pipe_fetch = pipe_fetch + 1;
            section = section + 1;      
            if pipe_fetch <= length(pipe_spec) && pipe_spec(pipe_fetch).lat_inflow == 1 
                Bd(s_c,1) = 1;
            end
        end
 
    end
    
end

slim_matrix = 1e-6;
AF = A/F;
AF2 = AF;
 AF2(abs(AF2) < slim_matrix) = 0;
BF = inv(F)*B;
BF2 = BF;
 BF2(abs(BF2) < slim_matrix) = 0;

last_pipe_out = find(strcmp(StateName , ['h_pipe_',num2str(length(pipe_spec)),'_',num2str(pipe_spec(end).sections)]));
C(last_pipe_out) = 1;
AF(dimension+add_states-1,dimension+add_states) = -1;
AF(dimension+add_states-1,last_pipe_out) = 1;
%F(dimension+add_states-1,dimension+add_states-1) = 1;
C(dimension+add_states-1) = 1;
StateName{dimension+add_states-1,1} = 'h_out_dot';

AF(dimension+add_states,last_pipe_out) = 1;
%F(dimension+add_states,dimension+add_states) = 1;
StateName{dimension+add_states,1} = 'h_out_old';





sys = ss(AF,[BF Bd],C,0,Dt,'StateName', StateName);
sys2 = ss(AF2,BF2,C,0,Dt,'StateName', StateName);


%%%%%%%%%%%%%%%%%%%%%% Linearizing functions %%%%%%%%%%%%%%
function [out] = lin_tank(input, tank_spec, fitfunc,fetch)

    if fetch == 'a'
        out = -(1/tank_spec.area)*tank_spec.Q_out_max*input*Dt; %change in height when pump runs 
    elseif fetch == 'b'
        out = fitfunc(tank_spec.Q_out_max*input)/Dt; %output of tank to input of pipe or wwtp
    else
        printf('Incorrect input (tank inearization), please enter a or b');
    end
end

function [out] = lin_pipe(h,n,pipe_spec,fetch)

    d = pipe_spec(n).d;
    Dx = pipe_spec(n).Dx;
    Theta = pipe_spec(n).Theta;
    Qf = pipe_spec(n).Qf;
    
    if fetch == 'a'
        out = ((1/(2*Dt))*(2*sqrt(-h^2+(h*d)))) - ((Theta/Dx)*(((1/2)*pi/d*sin(pi*h/d)-0.04*2*pi/d*sin(2*pi*h/d))*Qf));
    elseif fetch == 'b'
        out = ((1/(2*Dt))*(2*sqrt(-h^2+(h*d)))) + ((Theta/Dx)*(((1/2)*pi/d*sin(pi*h/d)-0.04*2*pi/d*sin(2*pi*h/d))*Qf));
    elseif fetch == 'c'
        out = ((1/(2*Dt))*(2*sqrt(-h^2+(h*d)))) + (((1-Theta)/Dx)*(((1/2)*pi/d*sin(pi*h/d)-0.04*2*pi/d*sin(2*pi*h/d))*Qf));
    elseif fetch == 'd'
        out = ((1/(2*Dt))*(2*sqrt(-h^2+(h*d)))) - (((1-Theta)/Dx)*(((1/2)*pi/d*sin(pi*h/d)-0.04*2*pi/d*sin(2*pi*h/d))*Qf));
    else
        printf('Incorrect input (pipe linearization), please enter a, b, c or d');
    end
end
end
