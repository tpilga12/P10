function [init_val sys sysT] = linearize_it(pipe_spec,nr_tanks, tank_spec,sys_setup,input,data)
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
    
    add_states = 0; % additional states needed to show change in output
    dimension = sys_setup(end).sections+add_states+nr_tanks+1; % Setup matrix dimension for sections of system
    
    A = zeros(dimension);  F = eye(dimension);
    B(1+nr_tanks:dimension,1) = 0; C(1:dimension) = 1; C = diag(C);
    scale_states = eye(dimension);
    StateName = cell(dimension,1);
    
    s_c = 1; %state counter
    section = 1; %keeps track of which cell data should be fetched in data
    pipe_fetch = 1;
    tank_counter = 1;
    new_pipe = 0;
    tank_inserted = 0;
    nr_inputs = 1;
    
    for run = 1:length(sys_setup)-1
        if strcmp(sys_setup(run).type,'Tank') == 1
%             if s_c == 1
%                 B(s_c,s_c) = lin_tank(input.Q_init(1,1), tank_spec(tank_counter), [], 'c');
%                 InputName{s_c,1} = 'Main_input';
%                 nr_inputs = nr_inputs + 1;
%             end
            section = section + 1; % needed here, fetches fitfunc for pipe after tank
           
            B(s_c,nr_inputs) = -lin_tank(input.u_init(1,tank_counter), tank_spec(tank_counter), [], [], 'a'); % change in tank height due to pump
            B(s_c+1,nr_inputs) = lin_tank(input.u_init(1,tank_counter), tank_spec(tank_counter), [], data{section}.fitfunc, 'b'); % height into next pipe
            A(s_c,s_c) = 1; %tank height
            A(s_c,s_c-1) = lin_tank(data{section-2}.h(1,end), tank_spec(tank_counter), [], data{section-2}.fitfunc2, 'c');   %change in tank height from pipe inflow

            %             A(s_c+1,s_c) =  (tank_spec(tank_counter).area/Dt)/tank_spec(tank_counter).Q_out_max;
            %             StateName{s_c+1,1} = ['Tank',num2str(tank_counter),'_u_max'];
            
            InputName{nr_inputs,1} = ['Pump_tank_',num2str(tank_counter)];
            StateName{s_c,1} = ['Tank_',num2str(tank_counter)];

            
%             x0(s_c,1) = data{section-2}.h(1,end);
            x0(s_c,1) = input.tank_height_init(tank_counter);
            u0(nr_inputs,1) = input.u_init(1,tank_counter);
            s_c = s_c + 1;
            nr_inputs = nr_inputs + 1;
            tank_counter = tank_counter +1;
            tank_inserted = 1;
            new_pipe = 1;
        else
              for n = 1:sys_setup(run).component
                k = 2;
                 for m = s_c:(s_c+pipe_spec(pipe_fetch).sections-1)
                    if  s_c == 1
                        F(s_c,s_c) = 1;
                        F(s_c+1,s_c+1)   = lin_pipe(data{section}.h(1,k), pipe_fetch, pipe_spec, 'b');
                        A(s_c+1,s_c+1)   = lin_pipe(data{section}.h(1,k), pipe_fetch, pipe_spec, 'd');
                        A(s_c+1,s_c)     = lin_pipe(data{section}.h(1,k), pipe_fetch, pipe_spec, 'c'); %h^(i+1)
                        B(s_c,s_c) = 1; % h^(i)
                        B(s_c+1,s_c) = -lin_pipe(data{section}.h(1,1), pipe_fetch, pipe_spec, 'a');
                        %B(s_c+1,s_c)=[lin_pipe(data{section}.h(1,1), pipe_fetch, pipe_spec, 'c')-lin_pipe(data{section}.h(1,1), pipe_fetch, pipe_spec, 'a')];
                        
                        InputName{1,1} = ['Pipe_1_1_inflow'];
                        StateName{s_c,1} = ['h_pipe_in_',num2str(pipe_fetch),'_',num2str(k-1)];
                        nr_inputs = nr_inputs + 1;
                        x0(s_c:(s_c+1),1) = data{section}.h(1,k);
                        s_c = s_c + 1;
                    elseif tank_inserted == 1
                        tank_inserted = 0;
%                         new_pipe = 0;
                        
                        A(s_c,s_c) = 0;
                        StateName{s_c,1} = ['h_pipe_',num2str(pipe_fetch),'_in'];
                        
                        F(s_c+1,s_c)     = lin_pipe(data{section}.h(1,k), pipe_fetch, pipe_spec, 'a');
                        F(s_c+1,s_c+1)   = lin_pipe(data{section}.h(1,k), pipe_fetch, pipe_spec, 'b');
                        A(s_c+1,s_c)     = lin_pipe(data{section}.h(1,k), pipe_fetch, pipe_spec, 'c');
                        A(s_c+1,s_c+1)   = lin_pipe(data{section}.h(1,k), pipe_fetch, pipe_spec, 'd');
%                         s_c = s_c + 1;
%                         F(s_c,s_c)   = lin_pipe(data{section}.h(1,k), pipe_fetch, pipe_spec, 'b');
%                         A(s_c,s_c)   = lin_pipe(data{section}.h(1,k), pipe_fetch, pipe_spec, 'd');
                        
                        x0(s_c:(s_c+1),1) = data{section}.h(1,k);
                        s_c = s_c + 1;
                    else
%                         if new_pipe == 1
%                             index = [s_c:(pipe_spec(pipe_fetch).sections-1+s_c)];
%                             scale_states(index,index) = eye(pipe_spec(pipe_fetch).sections)*(differentiate(data{pipe_spec(pipe_fetch).data_location-1}.fitfunc2,data{pipe_spec(pipe_fetch).data_location - 1}.h(1,end)) * ...
%                                                     differentiate(data{pipe_spec(pipe_fetch).data_location}.fitfunc,data{pipe_spec(pipe_fetch).data_location}.Q(1,end)));
%                             new_pipe = 0;
% 
%                         end
                        F(s_c,s_c-1) = lin_pipe(data{section}.h(1,k), pipe_fetch, pipe_spec, 'a');
                        F(s_c,s_c)   = lin_pipe(data{section}.h(1,k), pipe_fetch, pipe_spec, 'b');
                        A(s_c,s_c-1) = lin_pipe(data{section}.h(1,k), pipe_fetch, pipe_spec, 'c');
                        A(s_c,s_c)   = lin_pipe(data{section}.h(1,k), pipe_fetch, pipe_spec, 'd');
                        x0(s_c,1) = data{section}.h(1,k);
                    end
                    
                    StateName{s_c,1} = ['h_pipe_',num2str(pipe_fetch),'_',num2str(k-1)];
                     k = k +1;
                    s_c = s_c+1;
                 end
                new_pipe = 1;
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
%     A = scale_states*A*inv(scale_states);
%     F = scale_states*F*inv(scale_states);
    AF = inv(F)*A;
    AF2 = AF;
    AF2(abs(AF2) < slim_matrix) = 0;
    BF = inv(F)*B;%[inv(F)*B(:,1) inv(F)*B(:,2) B(:,3:end)];
    BF2 = BF;
    BF2(abs(BF2) < slim_matrix) = 0;
    
%     last_pipe_out = find(strcmp(StateName , ['h_pipe_',num2str(length(pipe_spec)),'_',num2str(pipe_spec(end).sections)]));
%     C(1,last_pipe_out) = 1;
%     C(2,dimension-1) = 1;
%     OutputName{1} = 'Output_height';
%     OutputName{2} = 'Output_height_dot';
%     AF(dimension-1,dimension) = -1;
%     AF(dimension-1,last_pipe_out) = 1;
%    
%     StateName{dimension-1,1} = 'h_out_dot';
%     
%     AF(dimension,last_pipe_out) = 1;
%     StateName{dimension,1} = 'h_out_old';
    
    T = scale_states;
    diag_scale = diag(scale_states);
    
%     sys.A = AF; sys.B = BF; sys.C = C; sys.D=zeros(size(B));
%     sys.StateName = StateName; sys.InputName = InputName; sys.OutputName = StateName;
%     sys.Ts = Dt;
%     sys = ss(AF,BF ,C,0,Dt);
%     sys2 = ss(AF2,BF2,C,0,Dt);% hed sys 2 sammen med linje 126
%     
    sys = ss(AF, BF ,C ,0,Dt,'StateName', StateName,'InputName',InputName,'OutputName',StateName);
    %    sys = ss(AF2,BF2,C,0,Dt,'StateName', StateName,'InputName',InputName,'OutputName',StateName);
%     sysT = ss(T*AF*inv(T), T*BF ,C*inv(T) ,0,Dt,'StateName', StateName,'InputName',InputName,'OutputName',StateName);
    sysT = ss(inv(T*F*inv(T))*(T*A*inv(T)), inv(T*F*inv(T))*(T*B) ,C*inv(T) ,0,Dt,'StateName', StateName,'InputName',InputName,'OutputName',StateName);    
    init_val.x0 = x0;
    if nr_tanks > 0
        init_val.u0 = u0;
    end
end
%%%%%%%%%%%%%%%%%%%%%% Linearizing functions %%%%%%%%%%%%%%
function [out] = lin_tank(input, tank_spec, pipe_spec, fitfunc, fetch) % Tank / pump

    if fetch == 'a' 
        out = (1/tank_spec.area)*tank_spec.Q_out_max*Dt; %change in height when pump runs 

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
%          out = ((1/(2*Dt))*(sqrt(h*(h*d))*(h-d/2))) - ((Theta/Dx)*(((1/2)*pi/d*sin(pi*h/d)-0.04*2*pi/d*sin(2*pi*h/d))*Qf));
    elseif fetch == 'b'
        out = ((1/(2*Dt))*(2*sqrt(-h^2+(h*d)))) + ((Theta/Dx)*(((1/2)*pi/d*sin(pi*h/d)-0.04*2*pi/d*sin(2*pi*h/d))*Qf));
%         out = ((1/(2*Dt))*(sqrt(h*(h*d))*(h-d/2))) + ((Theta/Dx)*(((1/2)*pi/d*sin(pi*h/d)-0.04*2*pi/d*sin(2*pi*h/d))*Qf));
    elseif fetch == 'c'
        out = ((1/(2*Dt))*(2*sqrt(-h^2+(h*d)))) + (((1-Theta)/Dx)*(((1/2)*pi/d*sin(pi*h/d)-0.04*2*pi/d*sin(2*pi*h/d))*Qf));
%          out = ((1/(2*Dt))*(sqrt(h*(h*d))*(h-d/2))) + (((1-Theta)/Dx)*(((1/2)*pi/d*sin(pi*h/d)-0.04*2*pi/d*sin(2*pi*h/d))*Qf));
    elseif fetch == 'd'
        out = ((1/(2*Dt))*(2*sqrt(-h^2+(h*d)))) - (((1-Theta)/Dx)*(((1/2)*pi/d*sin(pi*h/d)-0.04*2*pi/d*sin(2*pi*h/d))*Qf));
%         out = ((1/(2*Dt))*(sqrt(h*(h*d))*(h-d/2))) - (((1-Theta)/Dx)*(((1/2)*pi/d*sin(pi*h/d)-0.04*2*pi/d*sin(2*pi*h/d))*Qf));
    else
        printf('Incorrect input (pipe linearization), please enter a, b, c or d');
    end
end
end