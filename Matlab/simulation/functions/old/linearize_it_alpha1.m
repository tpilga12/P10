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

slim_matrix = 1e-5;
AF = A/F;
AF2 = AF;
 AF2(abs(AF2) < slim_matrix) = 0;
%  diag_af = diag(AF);
%  for w = 1:length(AF2)
%  AF2(w,w) = diag_af(w);
%  end
BF = inv(F)*B;
BF2 = BF;
 BF2(abs(BF2) < slim_matrix) = 0;

sys = ss(AF,BF,C,0,Dt);
sys2 = ss(AF2,BF2,C,0,Dt);




%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sample = Dt;
h_data_hat=data{1,1}.h(:,1)-data{1,1}.h(1,1);% Data fra den non linear
t = (sample:sample:length(h_data_hat)*sample)-sample;
h_input(1:length(t))=h_data_hat ;%Input height


u=[h_input; h_input];
[Y_hat t1 x1]=lsim(sys,u);
[Y_hat2 t2 x2] = lsim(sys2,u);
h_bar = data{1,1}.h(1,1); % S?t sm? signaler
Y_bar =data{length(pipe_spec)}.h(1,end);

figure(1000)
plot(t/60,data{1,1}.h(:,1))
title('Input height')
xlabel('Time [m]')
ylabel('Input height [m]')
% xlim([0 900])
grid

figure(2000)
plot(t/60,Y_hat+Y_bar,t/60,Y_hat2+Y_bar)
hold on
plot(t/60,data{length(pipe_spec)}.h(:,end))
title('Comparison of Non-linear and linear open channel models')
xlabel('Time [m]')
ylabel('Output height [m]')
% xlim([0 900])
legend('Linear','sys2','Non-linear')
grid
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5










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
