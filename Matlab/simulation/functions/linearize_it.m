% function [sys] = linearize_it(pipe_spec,tank_spec,sys_setup,data)
%LINEARIZE_IT Summary of this function goes here
%   Detailed explanation goes here
global Dt
dimension = sum([pipe_spec(:).sections]) + length(tank_spec); % add other parts here to obtain matrix dimensions
A = eye(dimension);
F = A;
if sys_setup{1} == 'Tank'
    B(1:dimension,1) = 0;
else
    B(1:dimension,1:2) = 0;
end
C(1:dimension) = 0;
pipe_sections = [pipe_spec(:).sections];

for n = 1:length(sys_setup)
  
    

end

function [a b] = lin_tank(h,A,Q_max)
    a = (1/A)*h; %this expression is bullcrap and is going to be fixed
    b = (1/A)*Q_max
end
    function [a b c d] = lin_pipe(h,d,Dx,Theta,Qf)
        a = ((1/(2*Dt))*(2*sqrt(-h^2+(h*d)))) - ((Theta/Dx)*(((1/2)*pi/d*sin(pi*h/d)-0.04*2*pi/d*sin(2*pi*h/d))*Qf));
        b = ((1/(2*Dt))*(2*sqrt(-h^2+(h*d)))) + ((Theta/Dx)*(((1/2)*pi/d*sin(pi*h/d)-0.04*2*pi/d*sin(2*pi*h/d))*Qf));
        c = ((1/(2*Dt))*(2*sqrt(-h^2+(h*d)))) + (((1-Theta)/Dx)*(((1/2)*pi/d*sin(pi*h/d)-0.04*2*pi/d*sin(2*pi*h/d))*Qf));
        d = ((1/(2*Dt))*(2*sqrt(-h^2+(h*d)))) - (((1-Theta)/Dx)*(((1/2)*pi/d*sin(pi*h/d)-0.04*2*pi/d*sin(2*pi*h/d))*Qf));
    end

    function out = Qf(d,Ie)
        out = 72*(d/4)^0.635*pi*(d/2)^2*Ie^0.5;
    end
% end

