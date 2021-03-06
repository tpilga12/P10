%% Sewer pipe equations
clc
clear all
close all
% Notes %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% H inde i funktionerne skal regnes med de korrekte v?rdier for A, Q osv,
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Constants
global Theta k m Dt Dx Ie H Q h A d 
Theta = 0.6;
k=0.002; %angives typisk i mm der skal bruges m i formler
m=1;
Dt = 1;
Dx = 5;


% Friction part 
Ie =0.05;% [.] Resistance = f * v^2/(2*g)*1/R
 
% Area for a sewer pipe
%A = d^2/4 *acos(((d*2)-h)/(d/2))-sqrt(h*(d-h))*((d/2)-h); % [m^2]
%Initialazation of parameters
d = 1.6;
Qf = -3.02 * log(((0.74*10^(-6))/(d*sqrt(d*Ie)))+(k/(3.71*d)))*d^2*sqrt(d*Ie); %[m^3/s]
n=100;
% A = pi*0.2^2;
% P = acos(1-0.4/0.2)*0.4;
% R = A/P;
% 
r1 = randn(n,1)*0.05;
h_initialQuess = 0.3;
one_vector = (ones(1,n-90));
zero_vector = ones(1,n-10)*0.2;

test = [ one_vector zero_vector];
h_init = test.*ones(1,n)*h_initialQuess ;

for n = 1:n
     
    Q_init(n) = (0.46 - 0.5 *cos(pi*(h_init(n)/d))+0.04*cos(2*pi*(h_init(n)/d)))*Qf; % [m^3/s]
    
end

r2 = randn(n,1)*0.05;
h1_init =ones(n,1).*test' *h_initialQuess;


for n = 1:n
     
    Q1_init(n) = (0.46 - 0.5 *cos(pi*(h1_init(n)/d))+0.04*cos(2*pi*(h1_init(n)/d)))*Qf; % [m^3/s]
end

Q1_init = Q1_init';
Q = zeros(n-1,n);
Q = [Q_init; Q];
Q = [Q1_init Q];
Q(:,n+1)=[];

h = zeros(n-1,n);
h = [h_init; h];
h = [h1_init h];
h(:,n+1)=[];

% Area for distance
for  n= 1:n  
    A_init(n) = d^2/4 * acos(((d/2)-h(n)/(d/2)))-sqrt(h(n)*(d-h(n)))*((d/2)-h(n));
end 
% Area for time
for  n= 1:n   
    A1_init(n) = d^2/4 * acos(((d/2)-h(n)/(d/2)))-sqrt(h(n)*(d-h(n)))*((d/2)-h(n));
end
A1_init = A1_init';
A = zeros(n-1,n);
A = [A_init; A];
A = [A1_init A];
A(:,n+1)=[];



%%
for m = 2:n
    for n = 2:n
        H = (2*(1-Theta)*Q(m-1,n-1)-2*(1-Theta)*Q(m-1,n)+2*Theta*Q(m,n-1))*Dt/Dx - A(m,n-1)+A(m-1,n-1)+A(m-1,n);
        H5(m,n) = (2*(1-Theta)*Q(m-1,n-1)-2*(1-Theta)*Q(m-1,n)+2*Theta*Q(m,n-1))*Dt/Dx - A(m,n-1)+A(m-1,n-1)+A(m-1,n);
        %H= abs(H);
       
        h(m,n)=NewtonRoot(@V1stDer,@V2ndDer,h(m-1,n-1),0.05,50,d);
        %h(m,n)= abs(h(m,n));
         
        A(m,n) = d^2/4 * acos(((d/2)-h(m,n)/(d/2)))-sqrt(h(m,n)*(d-h(m,n)))*((d/2)-h(m,n));
        %A(m,n)= abs(A(m,n));
        
        Q(m,n) = -1/(Theta*2)*(A(m,n)-H)*Dx/Dt;
        %Q(m,n)= abs(Q(m,n));
    end 

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
g = 2;
for n = 1:10
    %%% Flow
    figure(1)
    subplot(5,2,n)
    plot(Q(g,:))
    title(['Timestep', num2str(n)])
    xlabel('distance [m]')
    ylabel('Flow [m^3/s]')
    %ylim([0.5 0.7])
    grid
    
    %%% Area
    figure(2)
    subplot(5,2,n)
    plot(A(:,g))
    title(['Timestep', num2str(n)])
    xlabel('distance [m]')
    ylabel('Area [m^3]')
    %ylim([0.5 0.7])
    grid
    
    
    summa(n) = sum(A(:,g));
    g = g+5;
    
end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f=V1stDer(h)%V
global d Ie H Dt Dx Theta
%  Q1 = 0.03;
%  h1 = 0.25;
%  A1 = d^2/4 * acos(((d/2)-h1/(d/2)))-sqrt(h*(d-h1))*((d/2)-h1); 
% H = (2*(1-Theta)*Q1-2*(1-Theta)*Q1+2*Theta*Q1+2*Theta*Q1)*Dt/Dx - A1+A1+A1;
 
f = -72*(d/4)^0.635 * pi*(d/2)^2*Ie^0.5*(0.46-0.5*cos(pi*h/d)+ ...
0.04*cos(2*pi*h/d))*(Dt/Dx)-1/(2*Theta)*(d^2/4 * acos((d/2)-h/(d/2))- ...
sqrt(h*(d-h))*((d/2)-h)-H);

end 

function f=V2ndDer(h)%Vdot
global d Ie Dt Dx Theta
f = -72*(d/4)^0.635 * pi*(d/2)^2*Ie^0.5*(0.5*pi*sin(pi*h/d)- ...
0.08*pi*sin(2*pi*h/d))*Dt/Dx-(d/Theta)*sqrt(-h^2+(d*h));
end
