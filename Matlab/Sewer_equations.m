%% Sewer pipe equations
clc
clear all
close all
% Notes %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Constants
global Theta k Dt Dx Ie H Q h A d u g m n 
Theta = 0.5;
k=0.001; %angives typisk i mm der skal bruges m i formler
m=1;
Dt = 20; %[s] grid time
Dx = 24; %[m] gird distance
d = 1.2; %[m] Diameter
g = 9.81; %[m/s^2]
n=20; % Number of iterations, 
% Friction part 
Ie(1:n,1:n) = 0.00214;% [.] Resistance Ie = f * v^2/(2*g)*1/R
Ib = 0.00214;



Qf = -3.02 * log((0.74*10^(-6))/(d*sqrt(d*Ie(m,n)))+(k/(3.71*d)))*d^2*sqrt(d*Ie(m,n)); %[m^3/s] palles
Qff = 72*(d/4)^0.635*pi*(d/2)^2*Ie(m,n)^0.5;% Hennings


%% Regression to a plot, to find Q from a function 
h_test=0.0001:d/100:d;
for t = 1:100
    
    Q_test(t)=(0.46 - 0.5 *cos(pi*(h_test(t)/d))+0.04*cos(2*pi*(h_test(t)/d)))*Qf;
   
end
fitfunc = fit(Q_test',h_test','poly3');
Q_initial=1; % Flow  <----------------------------------------- start flow
h_initial = fitfunc.p1*Q_initial^3 + fitfunc.p2*Q_initial^2 + fitfunc.p3*Q_initial + fitfunc.p4; % check hieght

%% For random start values
a = 0.01;
b = 0.2;
r = (b-a).*rand(20,1) + a;

%% Set  a start height  Not needed 
h_initialQuess = 0.44; % [m]
%one_vector = r'.*(ones(1,n));
one_vector = (ones(1,n-5));
zero_vector = ones(1,n-15);

test = [ one_vector zero_vector];
% test = [ one_vector];
h_init = test.*ones(1,n)*h_initialQuess ;

%% Set a start flow
Q_initial_distance = Q_initial; % [m^3/s]
Q_initial_time = Q_initial; % [m^3/s]
%%Flow for distance
for n = 1:n
   % Q_init(n) = (0.46 - 0.5 *cos(pi*(h_init(n)/d))+0.04*cos(2*pi*(h_init(n)/d)))*Qf; % [m^3/s]
    Q_init(n)=Q_initial_distance;
end

% Area for distance
for  n= 1:n  
    %  A_init(n) = d^2/4 * acos(((d/2)-h_init(n)/(d/2)))-sqrt(h_init(n)*(d-h_init(n)))*((d/2)-h_init(n));
   h_init(n) =fitfunc.p1*Q_init(n)^3 + fitfunc.p2*Q_init(n)^2 + fitfunc.p3*Q_init(n) + fitfunc.p4;
   A_init(n) = d^2/4 * acos(((d/2)-h_init(n)/(d/2)))-sqrt(h_init(n)*(d-h_init(n)))*((d/2)-h_init(n));
 
end 

%h_initialHeight = 1.2;
%h1_init =ones(n,1)*h_initialHeight;
% Flow for Time
for n = 1:n
    % Q1_init(n) = (0.46 - 0.5 *cos(pi*(h1_init(n)/d))+0.04*cos(2*pi*(h1_init(n)/d)))*Qf; % [m^3/s]
     Q1_init(n)=Q_initial_time;
end
%%
% Area for time
for  n= 1:n   
    %A1_init(n) = d^2/4 * acos(((d/2)-h1_init(n)/(d/2)))-sqrt(h1_init(n)*(d-h1_init(n)))*((d/2)-h1_init(n));
    h1_init(n) =fitfunc.p1*Q1_init(n)^3 + fitfunc.p2*Q1_init(n)^2 + fitfunc.p3*Q1_init(n) + fitfunc.p4;
    A1_init(n) = d^2/4 * acos(((d/2)-h1_init(n)/(d/2)))-sqrt(h1_init(n)*(d-h1_init(n)))*((d/2)-h1_init(n));
end

Q1_init = Q1_init';
Q = zeros(n-1,n);
Q = [Q_init; Q];
Q = [Q1_init Q];
Q(:,n+1)=[];
Q = abs(Q);

h = zeros(n-1,n);
h = [h_init; h];
h = [h1_init' h];
h(:,n+1)=[];
h= abs(h);

A1_init = A1_init';
A = zeros(n-1,n);
A = [A_init; A];
A = [A1_init A];
A = abs(A);
A(:,n+1)=[];







for m = 1:n 
    for n = 1:n
        u(m,n)= Q(m,n)/A(m,n); 
    end
end 

for m = 2:n
    for n = 2:n
%         if m > 3
%             if n > 3
%                 Ie(m,n) = Ib - (h(m,n-1)-h(m-2,n-1))/(2*Dx)-2/g*u(n-1,m-1)*(u(m,n-1)-u(m-2,n-1))/(2*Dx)- ...
%                     ((u(n-1,m-1))^2)/(g*A(m-1,n-1))*(A(m,n-1)-A(m-2,n-1))/(2*Dx)-(u(n-1,m-1))/(g*A(m-1,n-1))*(A(m-1,n)- ...
%                     A(m-1,n-2))/(2*Dt)-1/g*(u(m-1,n)-u(m-1,n-2))/(2*Dt);
%                 Ie(m,n)  = abs(Ie(m,n))
%             end
%         end
        
        H = (2*(1-Theta)*Q(m-1,n-1)-2*(1-Theta)*Q(m,n-1)+2*Theta*Q(m-1,n))*Dt/Dx - A(m-1,n)+A(m-1,n-1)+A(m,n-1);
        H5(m,n) = (2*(1-Theta)*Q(m-1,n-1)-2*(1-Theta)*Q(m-1,n)+2*Theta*Q(m,n-1))*Dt/Dx - A(m,n-1)+A(m-1,n-1)+A(m-1,n);
        H= abs(H);
       
        h(m,n)=NewtonRoot(@V1stDer,@V2ndDer,h(m-1,n-1),0.01,50,d);
%          h(m,n) =BisectionRoot(@V1stDer,0,2,0.01);
%             h(m,n) = BiSectionV2(@V1stDer,0,2);
        h(m,n)= abs(h(m,n));
         
        A(m,n) = d^2/4 * acos(((d/2)-h(m,n)/(d/2)))-sqrt(h(m,n)*(d-h(m,n)))*((d/2)-h(m,n));
        A(m,n)= abs(A(m,n));
        
        Q(m,n) = (-1/(Theta*2))*(A(m,n)-H)*Dx/Dt;
        Q(m,n)= abs(Q(m,n));
        u(m,n)= Q(m,n)/A(m,n);      
    end 

end
%         for m =3:n
%             for n = 3:n
%                 Ie(m,n) = Ib - (h(m,n-1)-h(m-2,n-1))/(2*Dx)-2/g*u(n-1,m-1)*(u(m,n-1)-u(m-2,n-1))/(2*Dx)- ...
%                     ((u(n-1,m-1))^2)/(g*A(m-1,n-1))*(A(m,n-1)-A(m-2,n-1))/(2*Dx)-(u(n-1,m-1))/(g*A(m-1,n-1))*(A(m-1,n)- ...
%                     A(m-1,n-2))/(2*Dt)-1/g*(u(m-1,n)-u(m-1,n-2))/(2*Dt);
%             end
%         end
%%% Ie opdatering, Uden inlent flow 
%%% Ie2 = Ie - (h(m,n-1)-h(m-2,n-1))/(2*Dx)-2/g*u(n-1,m-1)*(u(m,n-1)-u(m-2,n-1))/(2*Dx)- ...
%%% ((u(n-1,m-1))^2)/(g*A(m-1,n-1))*(A(m,n-1)-A(m-2,n-1))/(2*Dx)-(u(n-1,m-1))/(g*A(m-1,n-1))*(A(m-1,n)- ...
%%% A(m-1,n-2))/(2*Dt)-1/g*(u(m-1,n)-u(m-1,n-2))/(2*Dt)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t = 1;
for n = 1:10
    %%% Flow
    figure(1)
    subplot(5,2,n)
    plot(Q(t,:))
    title(['Timestep', num2str(n)])
    xlabel('distance [m]')
    ylabel('Flow [m^3/s]')
    %ylim([0.5 0.7])
    grid
%   pause(0.5)  
%     %%% Area
    figure(2)
    subplot(5,2,n)
    plot(h(:,t))
    title(['Timestep', num2str(n)])
    xlabel('distance [m]')
    ylabel('Area [m^3]')
    %ylim([0.5 0.7])
    grid
    
    
    summa(n) = sum(A(:,t));
    t = t+1;
    
end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f=V1stDer(h)%V
global d Ie H Dt Dx Theta m n
f = -72*(d/4)^0.635 * pi*(d/2)^2*Ie(m,n)^0.5*(0.46-0.5*cos(pi*h/d)+ ...
0.04*cos(2*pi*h/d))*(Dt/Dx)-1/(2*Theta)*(d^2/4 * acos((d/2)-h/(d/2))- ...
sqrt(h*(d-h))*((d/2)-h)-H);

end 

function f=V2ndDer(h)%Vdot
global d Ie Dt Dx Theta m n
f = -72*(d/4)^0.635 * pi*(d/2)^2*Ie(m,n)^0.5*(0.5*pi*sin(pi*h/d)- ...
0.08*pi*sin(2*pi*h/d))*Dt/Dx-(d/Theta)*sqrt(-h^2+(d*h));
end
