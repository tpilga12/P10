 function [xstates delta_xstates_old]=collect_heights(data,iteration)
%% Mangler at sætte flag for at sætte de sidste to states i det første stykke til nul

if iteration > 2
    for m = 1:length(data)
        if m == 1
            xstates_old = [data{1,1}.h(iteration-1,:)]
        else
            xstates_old = [xstates_old data{1,m}.h(iteration-1,:)]           
        end
    end
    x_delta_output= data{1,end}.h(iteration,end)-data{1,end}.h(iteration-2,end);
    xstates_old = [xstates_old x_delta_output];
    x_old_output  = data{1,end}.h(iteration-2,end);
    xstates_old = [xstates_old x_old_output];
    
    for m = 1:length(data)
        if m == 1
            xstates = [data{1,1}.h(iteration,:)]
        else
            xstates = [xstates data{1,m}.h(iteration,:)]
        end
    end
    
    x_delta_output= data{1,end}.h(iteration,end)-data{1,end}.h(iteration-1,end);
    xstates = [xstates x_delta_output];
    x_old_output  = data{1,end}.h(iteration-1,end);
    xstates = [xstates x_old_output];
    
    delta_xstates_old = xstates-xstates_old;
end
end