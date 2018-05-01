function [output]=simulation(Q_init,C_init)

global iterations Dt
persistent data
input.C_in= 10; % concentrate input
input.Q_in = 0.015;


[pipe_spec nr_pipes] = pipe_setup(1);
pieces = nr_pipes + 0; %add other pieces that should be in the simulation
data = 0; temp{1} = 0;
for m = 1:iterations
    for x = 1:pieces
        [data] = pipe(pipe_spec,input,x,temp{x},m);
        temp = data{x};
    end
   
end
output = data;