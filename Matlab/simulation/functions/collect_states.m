  function [xstates delta_xstates]= collect_states(data,iteration,lin_sys)

%% Constraints 

%% Hent tank_spec og rør_spec ind, samt antal, data
% Bulifted = zeros(length(B)*Hp,Hp)
xstates_old = ones(1,length(lin_sys.StateName)); % Setup the matrices for states
xstates     = ones(1,length(lin_sys.StateName));
counter = 1;
    if iteration > 2
        for m = 1:20 % Loop to find the states and then take the values from the nonlinear model and insert into the state
            if contains(lin_sys.StateName(counter),'in') ==1
                pipe_states = length(data{1,m}.h(iteration-1,:));
                xstates_old(1,counter:counter-1+pipe_states) = data{1,m}.h(iteration-1,:);
            elseif contains(lin_sys.StateName(counter),'Tank') ==1
                pipe_states = length(data{1,m}.h(iteration-1,:));
                xstates_old(1,counter:counter-1+pipe_states)=data{1,m}.h(iteration-1,:);
            else
                pipe_states = length(data{1,m}.h(iteration-1,2:end));
                xstates_old(1,counter:counter-1+pipe_states) = data{1,m}.h(iteration-1,2:end);
            end
            counter = counter+pipe_states;
        end
        xstates_old =xstates_old- data{1,1}.h(1,1);% sustract small signal
        x_delta_output= data{1,end}.h(iteration-1,end)-data{1,end}.h(iteration-2,end); % state for difference between the last two outputs
        pipe_states=1;
        xstates_old(1,counter:counter-1+pipe_states) = x_delta_output; % state for difference between the last two outputs
        counter = counter+pipe_states;
        pipe_states=1;
        x_old_output  = data{1,end}.h(iteration-2,end)-data{1,1}.h(1,1);% last output
        xstates_old(1,counter:counter-1+pipe_states) = x_old_output; % last output

        counter=1;
        for m = 1:20 % Loop to find the states and then take the values from the nonlinear model and insert into the state
            if contains(lin_sys.StateName(counter),'in') ==1
                pipe_states = length(data{1,m}.h(iteration-1,:));
                xstates(1,counter:counter-1+pipe_states) = data{1,m}.h(iteration,:);
            elseif contains(lin_sys.StateName(counter),'Tank') ==1
                pipe_states = length(data{1,m}.h(iteration-1,:));
                xstates(1,counter:counter-1+pipe_states)=data{1,m}.h(iteration,:);
            else
                pipe_states = length(data{1,m}.h(iteration-1,2:end));
                xstates(1,counter:counter-1+pipe_states) = data{1,m}.h(iteration,2:end);
            end
            counter = counter+pipe_states;
        end
        
        xstates =xstates- data{1,1}.h(1,1);% sustract small signal
        x_delta_output= data{1,end}.h(iteration,end)-data{1,end}.h(iteration-1,end);% state for difference between the last two outputs
        pipe_states=1;
        xstates(1,counter:counter-1+pipe_states) = x_delta_output;% state for difference between the last two outputs
        counter = counter+pipe_states;
        pipe_states=1;
        x_output  = data{1,end}.h(iteration,end)-data{1,1}.h(1,1);% last output
        xstates(1,counter:counter-1+pipe_states) = x_output;% last output
        
        
    end
    delta_xstates = xstates-xstates_old;
end