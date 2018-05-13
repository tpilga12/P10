function [sys] = linearize_it(pipe_spec,nr_tanks, tank_spec,sys_setup,input,data)
%LINEARIZE_IT Summary of this function goes here
%   Linearization of pipe_setup
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global Dt error
if strcmp(sys_setup(1).type,'Tank') == 1 || strcmp(sys_setup(end).type,'Tank') == 1
    error = 1;
    fprintf('Tank placed at start or end of system')
end

if error == 1
    sys = 'Not available';
else
    dimension = sys_setup(end).sections; % Setup matrix dimension for sections of system
    add_states = 2; % additional states needed for change in output
    
    A = zeros(dimension+add_states);  F = eye(dimension+add_states);
    B(1+nr_tanks:dimension+add_states,1) = 0; C(1:dimension+add_states) = 0;
    StateName = cell(dimension+add_states,1);
    s_c = 1; %state counter
    section = 1; %keeps track of which cell data should be fetched in data
    pipe_fetch = 1;
    tank_counter = 1;
    new_pipe_section = 0;
    nr_inputs = 1;
    for run = 1:length(sys_setup)-1
        if strcmp(sys_setup(run).type,'Tank') == 1
%             if s_c == 1
%                 B(s_c,s_c) = lin_tank(input.Q_init(1,1), tank_spec(tank_counter), [], 'c');
%                 InputName{s_c,1} = 'Main_input';
%                 nr_inputs = nr_inputs + 1;
%             end
            section = section + 1; % needed here, fetches fitfunc for pipe after tank
           
            B(s_c,nr_inputs) = lin_tank(input.u_init(1,tank_counter), tank_spec(tank_counter), [], [], 'a'); % change in tank height due to pump
            B(s_c+1,nr_inputs) = lin_tank(input.u_init(1,tank_counter), tank_spec(tank_counter), [], data{section}.fitfunc, 'b'); % height in to next pipe
            
%             A(s_c,s_c) = (data{section-2}.fitfunc2(data{section-2}.h(1,end))/tank_spec(tank_counter).area)*Dt; %data{section-2}.h(1,end);
%             A(s_c+1,s_c+1) = 1;
%              A(s_c,s_c-1) = lin_tank(data{section-1}.h(end,end), tank_spec, pipe_spec(section-1).d, [], 'c');   %change in tank height from pipe in flow
            A(s_c,s_c) = 1;
            A(s_c,s_c-1) = lin_tank(data{section-2}.h(1,end), tank_spec(tank_counter), [], data{section-2}.fitfunc2, 'c');   %change in tank height from pipe inflow
            
%             (input, tank_spec, pipe_spec, fitfunc, fetch)
            
            InputName{nr_inputs,1} = ['Pump_tank_',num2str(tank_counter)];
            StateName{s_c,1} = ['Tank_',num2str(tank_counter)];
            
            s_c = s_c + 1;
            nr_inputs = nr_inputs + 1;
            tank_counter = tank_counter +1;
            new_pipe_section = 1;
        else
              for n = 1:sys_setup(run).component
                k = 1;
                 for m = s_c:(s_c+pipe_spec(pipe_fetch).sections-1)
                    if  s_c == 1
                        F(s_c,s_c)   = lin_pipe(data{section}.h(1,k), pipe_fetch, pipe_spec, 'b');
                        A(s_c,s_c)   = lin_pipe(data{section}.h(1,k), pipe_fetch, pipe_spec, 'd');
                        B(s_c,s_c)=[lin_pipe(data{section}.h(1,1), pipe_fetch, pipe_spec, 'c')-lin_pipe(data{section}.h(1,1), pipe_fetch, pipe_spec, 'a')];
                        InputName{1,1} = ['Pipe_1_1_inflow'];
                        nr_inputs = nr_inputs + 1;
                    elseif new_pipe_section == 1
                        new_pipe_section = 0;
                        F(s_c,s_c)   = lin_pipe(data{section}.h(1,k), pipe_fetch, pipe_spec, 'b');
                        A(s_c,s_c)   = lin_pipe(data{section}.h(1,k), pipe_fetch, pipe_spec, 'd');
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
             end
            
        end
        
    end
    
    lat_in = find([pipe_spec.lat_inflow]);
    for n = 1:length(lat_in) % Setup lateral inflow
        B(1:end,end+1)= 0;
        B(find(strcmp(StateName , ['h_pipe_',num2str(lat_in(n)),'_',num2str(1)])),end) = 1;
        InputName{end+1,1} = ['lat_h_pipe_',num2str(lat_in(n)),'_',num2str(1)];
    end    
    
    
    slim_matrix = 1e-6;
%     AF = A/F;
    AF = inv(F)*A;
    AF2 = AF;
    AF2(abs(AF2) < slim_matrix) = 0;
    BF = [inv(F)*B(:,1) B(:,2:end)];
    BF2 = BF;
    BF2(abs(BF2) < slim_matrix) = 0;
    
    last_pipe_out = find(strcmp(StateName , ['h_pipe_',num2str(length(pipe_spec)),'_',num2str(pipe_spec(end).sections)]));
    C(1,last_pipe_out) = 1;
    C(2,dimension+add_states-1) = 1;
    OutputName{1} = 'Output_height';
    OutputName{2} = 'Output_height_dot';
    AF(dimension+add_states-1,dimension+add_states) = -1;
    AF(dimension+add_states-1,last_pipe_out) = 1;
   
    StateName{dimension+add_states-1,1} = 'h_out_dot';
    
    AF(dimension+add_states,last_pipe_out) = 1;
    StateName{dimension+add_states,1} = 'h_out_old';
    

%%% temp fix %%%%% 
% temp = inv(F);
% 
%     sys = ss(AF,BF ,C,0,Dt);
%     sys2 = ss(AF2,BF2,C,0,Dt);
%     
    sys = ss(AF,BF ,C,0,Dt,'StateName', StateName,'InputName',InputName,'OutputName',OutputName);
    sys2 = ss(AF2,BF2,C,0,Dt,'StateName', StateName,'InputName',InputName,'OutputName',OutputName);
    
end
%%%%%%%%%%%%%%%%%%%%%% Linearizing functions %%%%%%%%%%%%%%
function [out] = lin_tank(input, tank_spec, pipe_spec, fitfunc, fetch) % Tank / pump

    if fetch == 'a' 
        out = (1/tank_spec.area)*tank_spec.Q_out_max*input*Dt; %change in height when pump runs 
    elseif fetch == 'b' % Q_out_tank 
           out = differentiate(fitfunc,(tank_spec.Q_out_max*input)); % height flow into pipe after tank
    elseif fetch == 'c'% Q_in_tank
%            out = (1/tank_spec.area)*(0.46-0.5*cos(pi*(input/pipe_spec))+0.04*cos(2*pi*(input/pipe_spec)))*Dt; %change in height in tank by inflow        
%            % (1.5708 sin((h ?)/d) - 0.251327 sin((2 h ?)/d))/d 
%            out = -(1/tank_spec.area)*((1.5708*sin((input*pi)/pipe_spec) - 0.251327*sin((2*input*pi)/pipe_spec))/pipe_spec);
           out = (1/tank_spec.area)*differentiate(fitfunc,(input))*Dt;
           
    else
        printf('Incorrect input (tank inearization), please enter a, b or c');
    end
end

function [out] = lin_pipe(h,number,pipe_spec,fetch) % pipe

    d = pipe_spec(number).d;
    Dx = pipe_spec(number).Dx;
    Theta = pipe_spec(number).Theta;
    Qf = pipe_spec(number).Qf;
    
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
