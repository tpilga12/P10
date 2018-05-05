% function [init_data] = intialize(input,sys_setup,pipe_spec,nr_tanks)
%INTIALIZE Summary of this function goes here
%   Detailed explanation goes here

error = 0;
if length(input.u_init) ~= nr_tanks
    fprintf('error, initial input is not found for all actuators')
    error = 1;
end
if error == 0

start_pipe_sim = 0;
m = 1;
for n = 1:(length(sys_setup)-1)
    if strcmp(sys_setup(n).type,'Pipe')
        start_pipe_sim(m)= sys_setup(n).component;
        m = m +1;
    end
end
m = 1;

for n = 1:length(start_pipe_sim)
    endpoint = sum(start_pipe_sim(1:n));
    pipespec = pipe_spec(m:endpoint);
    
    init_pipes{1,n} = init_pipe(pipespec,input,1e-7);
    m = start_pipe_sim(n) + m;
end


















end
% end

