function [plot_limits vertical_line pipe_sep] = find_plot_limits(pipe_spec,data,topplot_adjust,botplot_adjust)
%FIND_PLOT_LIMITS Summary of this function goes here
%   Detailed explanation goes here
if length(pipe_spec) > 1
maxflowlim(1:length(pipe_spec)) = 0; maxheightlim(1:length(pipe_spec)) = 0; maxconflowlim(1:length(pipe_spec)) = 0;
end
pipe_sep = 0;
for n = 1: length(pipe_spec)
    for g = length(pipe_sep):pipe_spec(n).sections+length(pipe_sep)
        if n == 1 && g == 1
            pipe_sep(g) =  pipe_spec(n).Dx;
        else
            pipe_sep(g) =  pipe_spec(n).Dx + pipe_sep(g-1);
        end
    end
    vertical_line(n) = pipe_sep(g-1);
    
    maxflowlim(n) = max(max(data{pipe_spec(n).data_location}.Q));
    minflowlim(n) = min(min(data{pipe_spec(n).data_location}.Q));
    maxheightlim(n) = max(max(data{pipe_spec(n).data_location}.h));
    minheightlim(n) = min(min(data{pipe_spec(n).data_location}.h));
    maxconflowlim(n) = max(max(data{pipe_spec(n).data_location}.C));
    minconflowlim(n) = min(min(data{pipe_spec(n).data_location}.C));
end
    plot_limits(1,1) = min(minflowlim)*botplot_adjust;
    plot_limits(1,2) = max(maxflowlim)*topplot_adjust;
    
    plot_limits(2,1) = min(minheightlim)*botplot_adjust;
    plot_limits(2,2) = max(maxheightlim)*topplot_adjust;
    
    plot_limits(3,1) = min(minconflowlim)*botplot_adjust;
    plot_limits(3,2) = max(maxconflowlim)*topplot_adjust;
    
    plot_limits(4,1) = min(minconflowlim .* minflowlim)*botplot_adjust;
    plot_limits(4,2) = max(maxconflowlim .* maxflowlim)*topplot_adjust;
    
    pipe_sep = pipe_sep - pipe_sep(1,1);
    return
    
end

