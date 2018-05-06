function [sys] = linearize_it(pipe_spec,tank_spec,sys_setup,data)
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
A = zeros(dimension);  F = A; 
B(1:dimension,1) = 0; C(1:dimension) = 0;

s_c = 1; %state counter
section = 1; %keeps track of where data should be fetched in init_data
pipe_fetch = 1;
hej = 0;
for run = 1:length(sys_setup)-1
    if strcmp(sys_setup(run).type,'Tank') == 1
        section = section + 1;
        F(s_c,s_c) = 1;
        B(s_c,1) = 1;
        
        s_c = s_c + 1;
        
    else
        for n = 1:sys_setup(run).component
            for m = s_c:(s_c+pipe_spec(pipe_fetch).sections-1)
                if  n == 1 && run == 1
                    F(m,m)   = lin_pipe(data{section}.h(1,1), pipe_fetch, pipe_spec, 'b');
                    A(m,m)   = lin_pipe(data{section}.h(1,1), pipe_fetch, pipe_spec, 'd');
                    B(1,1)=[lin_pipe(data{n}.h(1,1), n, pipe_spec, 'c')-lin_pipe(data{n}.h(1,1), n, pipe_spec, 'a')];
                    hej = hej + 1
            
                else
                    
                    F(m,m) = lin_pipe(data{section}.h(1,1), pipe_fetch, pipe_spec, 'a');
                    F(m,m+1)   = lin_pipe(data{section}.h(1,1), pipe_fetch, pipe_spec, 'b');
                    A(m,m) = lin_pipe(data{section}.h(1,1), pipe_fetch, pipe_spec, 'c');
                    A(m,m+1)   = lin_pipe(data{section}.h(1,1), pipe_fetch, pipe_spec, 'd');
                end
               s_c = s_c+1;
            end
            pipe_fetch = pipe_fetch + 1;
            section = section + 1;      
        
        end
 
    end
    
end
% B(1,1)=[lin_pipe(init_data{n}.h(1,1), n, pipe_spec, 'c')-lin_pipe(init_data{n}.h(1,1), n, pipe_spec, 'a')];
C(1,end) = 1;

slim_matrix = 1e-6;
AF = A/F;
AF2 = AF;
 AF2(abs(AF2) < slim_matrix) = 0;
BF = inv(F)*B;
BF2 = BF;
 BF2(abs(BF2) < slim_matrix) = 0;

sys = ss(AF,BF,C,0,Dt);
sys2 = ss(AF2,BF2,C,0,Dt);


%%%%%%%%%%%%%%%%%%%%%% Linearizing functions %%%%%%%%%%%%%%
function [out] = lin_tank(h,A,Q_max,fetch)

    if fetch == 'a'
        out = (1/A)*h; %this expression is bullcrap and is going to be fixed
    elseif fetch == 'b'
        out = (1/A)*Q_max; %this too
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
