function [init_data tank_spec, input] = initialize(input,sys_setup,pipe_spec,tank_spec)
%INTIALIZE Summary of this function goes here
%   Detailed explanation goes here
global error

if length(input.u_init) < length(tank_spec) && length(tank_spec) > 0 
    fprintf('error, initial input is not found for all actuators')
    error = 1;
end

if error == 1
    init_data = 'Not available';
    return
elseif error == 0
tic    
%     start_pipe_sim = 0;
%     m = 1;
%     for n = 1:(length(sys_setup)-1)
%         if strcmp(sys_setup(n).type,'Pipe')
%             start_pipe_sim(m)= sys_setup(n).component;
%             m = m +1;
%         end
%     end
%     if length(tank_spec) > 0 % tank init
%         n = 1;
%         no_tanks = 0;
%         for m = 1:length(sys_setup)-1 % minus one because tank at the end point can not be output limited by a pipe which is not there
%             if strcmp(sys_setup(m).type,'Tank') == 1
%                 tank_spec(n).Q_out_max = pipe_spec(sum([sys_setup(1:m).component])).Qf; % set max tank outflow to max input of next pipe
%                 init_tanks{1,n} =  tank(1,[], n, input.Q_init, input.C_init, input, tank_spec, 1); %initialize tanks
%                 n = n + 1;
%                 no_tanks = no_tanks + 1;
%             end
%         end
%     end
%     
%     
%     m = 1;
%     input.Q_init = init_tanks{1,1}.Q(1,2);
%     for n = 1:length(start_pipe_sim) % pipe init
%         endpoint = sum(start_pipe_sim(1:n));
%         pipespec = pipe_spec(m:endpoint);
%         init_pipes{1,n} = init_pipe(pipespec,input,1e-7);
%         m = start_pipe_sim(n) + m;
%     end
%     
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    
    init = 1; % tank function is used in initiation where this should be set to 1, here it should be 0 
    tank_nr = 1;
    pipe_component = 0;
    sys_component = 1;
    for x = 1:length(sys_setup)-1
        if strcmp(sys_setup(x).type,'Tank') == 1
            
            tank_spec(tank_nr).Q_out_max = pipe_spec(sys_component).Qf; % set max tank outflow to max input of next pipe
            [init_data{1,sys_component} input] = tank(1, [], tank_nr, x, input, tank_spec, init);
            
            input.Q_init(x+1)= init_data{1,sys_component}.Q(1,end);
            input.C_init(x+1)= init_data{1,sys_component}.C(1,end);
            
            tank_nr = tank_nr + 1;
            sys_component = sys_component + 1;
        else
            temp = init_pipe(pipe_spec((pipe_component+1):(sys_setup(x).component + pipe_component)), input, x, 1e-9);
            if x == 1
                init_data = temp;
            else
                init_data = [ init_data temp{:,:}];
            end
            sys_component = sys_component + sys_setup(x).component;
            pipe_component = pipe_component + sys_setup(x).component;
            
            input.Q_init(x+1)= init_data{1,sys_component-1}.Q(1,end);
            input.C_init(x+1)= init_data{1,sys_component-1}.C(1,end);
        end
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
   
    %%%%%%%%%%%%%%%%% Gather pipe and tank initial data
%     count1 = 1;
%     count2 = 1;
%     placement = 1;
%     if no_tanks == 0
%         init_data = init_pipes{1};
%     elseif sys_setup(1).type == 'Tank'
%         for n = (1:length(sys_setup)-1)
%             if sys_setup(n).type == 'Tank'
%                 init_data{placement} = init_tanks{count1};
%                 count1 = count1 + 1;
%                 placement = placement + 1;
%             else
%                 for m = 1:start_pipe_sim(count2)
%                     init_data{placement+m-1} = init_pipes{count2}{m};
%                 end
%                 placement = placement + start_pipe_sim(count2);
%                 count2 = count2 + 1;
%             end
%         end
%     end

 input.Q_init = input.Q_init(1:x);
 input.C_init = input.C_init(1:x);
init_time = toc    
end
end

