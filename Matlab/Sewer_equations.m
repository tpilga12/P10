%% Sewer pipe equations
clc
clear all
close all
% Notes %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% H inde i funktionerne skal regnes med de korrekte værdier for A, Q osv,
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Constants
Theta = 0.5;
k=1;
m=1;
Dt = 10;
Dx = 10;
% Friction part 
 Ie =0.1;% [.] Resistance = f * v^2/(2*g)*1/R
 
% Area for a sewer pipe
%A = d^2/4 *acos(((d*2)-h)/(d/2))-sqrt(h*(d-h))*((d/2)-h); % [m^2]
%Initialazation of parameters
d = 0.4;
Qf = -3.02 * log((0.74*10^(-6))/(d*sqrt(d*Ie))+(k/(3.71*d)))*d^2*sqrt(d*Ie); %[m^3/s]
n=10;
% A = pi*0.2^2;
% P = acos(1-0.4/0.2)*0.4;
% R = A/P;
% 
% Qf_henning = -72*(D/4)^0.635 * pi*(D/2)^2*Ie^0.5;

h_init = ones(1,n)*0.2;
for n = 1:n
     
    Q_init(n) = (0.46 - 0.5 *cos(pi-(d/h_init(n)))+0.04*cos(2*pi*(h_init(n)/d)))*Qf; % [m^3/s]
end

h1_init = ones(n,1)*0.2;
for n = 1:n
     
    Q1_init(n) = (0.46 - 0.5 *cos(pi-(d/h1_init(n)))+0.04*cos(2*pi*(h1_init(n)/d)))*Qf; % [m^3/s]
end




Q1_init = Q1_init';

Q = zeros(9,10);
Q = [Q_init; Q];
Q = [Q1_init Q];
Q(:,11)=[];

h = zeros(9,10);
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
A = zeros(9,10);
A = [A_init; A];
A = [A1_init A];
A(:,n+1)=[];



%%
for m = 2:10
    for n = 2:10
        H = (2*(1-Theta)*Q(m-1,n-1)-2*(1-Theta)*Q(m-1,n)+2*Theta*Q(m,n-1))*Dt/Dx - A(m,n-1)+A(m-1,n-1)+A(m-1,n);
        
        h(m,n)=NewtonRoot(@V1stDer,@V2ndDer,h(m-1,n-1),0.01,50)

        A(m,n) = d^2/4 * acos(((d/2)-h(m,n)/(d/2)))-sqrt(h(m,n)*(d-h(m,n)))*((d/2)-h(m,n))
        Q(m,n) = -1/(Theta*2)*(A(m,n)-H)*Dx/Dt
    end 

end

% b_P * 1/2 * h(m,n) + Dt * Theta * Q(m,n) = q*Dx*Dt-Dx*b_P*1/2* ... 
% (h(m-1,n)-h(m-1,n-1)+h(m,n.1))-Dt*(1-Theta)*(Q(m,n-1)-Q(m-1,n-1))+Theta*Dt*Q(m-1,n);
% 
% m=2
% for n = 2:10   
%     Q(m,n) = Qf*(0.46 - 0.5 *cos(pi-(d/h(m,n)))+0.04*cos(2*pi*(h(m,n)/d)))   
% end


