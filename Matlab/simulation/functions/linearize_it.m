% function [sys] = linearize_it(pipe_spec,tank_spec,sys_setup,init_data)
%LINEARIZE_IT Summary of this function goes here
%   Detailed explanation goes here
global Dt
dimension = sum([pipe_spec(:).sections]); % matrix dimensions for linearized pipes
A = zeros(dimension);
B(1:dimension,1:2) = 0;
F = A;
C(1:dimension) = 0;
s_c = 1; %state counter

for n = 1:length(pipe_spec)
    for m = s_c:(s_c+pipe_spec(n).sections-1)
        if m == 1
            F(m,m)   = lin_pipe(init_data{n}.h(1,1), n, pipe_spec, 'b');
            A(m,m)   = lin_pipe(init_data{n}.h(1,1), n, pipe_spec, 'd');
        else
            F(m,m-1) = lin_pipe(init_data{n}.h(1,1), n, pipe_spec, 'a');
            F(m,m)   = lin_pipe(init_data{n}.h(1,1), n, pipe_spec, 'b');
            A(m,m-1) = lin_pipe(init_data{n}.h(1,1), n, pipe_spec, 'c');
            A(m,m)   = lin_pipe(init_data{n}.h(1,1), n, pipe_spec, 'd');
        end
    end  
     s_c = s_c+pipe_spec(n).sections;
end
B(1,1:2)=[lin_pipe(init_data{n}.h(1,1), n, pipe_spec, 'c') -lin_pipe(init_data{n}.h(1,1), n, pipe_spec, 'a')];
C(1,end) = 1;

tic
AF = inv(F)*A;
BF = inv(F)*B;
toc

sys =ss(AF,BF,C,0,Dt);










function [out] = lin_tank(h,A,Q_max,fetch)
global Dt
    if fetch == 'a'
        out = (1/A)*h; %this expression is bullcrap and is going to be fixed
    elseif fetch == 'b'
        out = (1/A)*Q_max; %this too
    else
        printf('Incorrect input "fetch", please enter a or b');
    end
end

function [out] = lin_pipe(h,n,pipe_spec,fetch)
global Dt
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
        printf('Incorrect input "fetch", please enter a, b, c or d');
    end
end
% end
