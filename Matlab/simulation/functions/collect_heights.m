%  function [xstates delta_xstates]=collect_heights(data,iteration)
%% Mangler at s�tte flag for at s�tte de sidste to states i det f�rste stykke til nul
%%
for iteration = 1:20
if iteration > 2
    for m = 1:length(data)
        if m == 1
            xstates_old = [data{1,1}.h(iteration-1,:)];
        else
            xstates_old = [xstates_old data{1,m}.h(iteration-1,:)];        
        end
    end
    x_delta_output= data{1,end}.h(iteration,end)-data{1,end}.h(iteration-2,end);
    xstates_old = [xstates_old x_delta_output];
    x_old_output  = data{1,end}.h(iteration-2,end);
    xstates_old = [xstates_old x_old_output];
    xstates_old =xstates_old- data{1,1}.h(1,1);
    
    for m = 1:length(data)
        if m == 1
            xstates = [data{1,1}.h(iteration,:)];
        else
            xstates = [xstates data{1,m}.h(iteration,:)];
        end
    end
    
    x_delta_output= data{1,end}.h(iteration,end)-data{1,end}.h(iteration-1,end);
    xstates = [xstates x_delta_output];
    x_old_output  = data{1,end}.h(iteration-1,end);
    xstates = [xstates x_old_output];
    xstates =xstates- data{1,1}.h(1,1);
    
    delta_xstates = xstates-xstates_old;
end

end