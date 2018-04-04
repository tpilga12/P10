%% Sewer pipe equations
clc
clear all
close all
% Notes %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Theta = 0.65;
k=0.0015; %angives typisk i mm der skal bruges m i formler

Dt = 20; %[s] grid time
Dx = 8; %[m] grid distance
pipe_length = 50*Dx % has to be multiple of Dx
d = 0.6; %[m] Diameter

n=150; % Number of iterations, 
% Friction part 


Ib = 0.00214;
C_in= 10; % concentrate input
C_init = 8; % initial cocentrate in pipe
Q_in = 0.015;
Q_init = 0.015;

%function [Q C]=pipe(Ib,k,Dt,Dx,d,n,m,Q_init,Q_in,C_init,C_in,Theta)
                %Pipe(bed slope(Ib),        Ruhedsfaktor(k),
                %Delta t(Dt),               Delta x(Dx), 
                %Diameter(d),               Pipe sections(n),
                %Current time iteration(m), Initial flow (Q_init),
                %Input flow (Q_in),         Initial concentrate(C_init),
                %Input concentrate(C_in),   finite scheme konstant(Theta)) 
                %length of pipe is Dx*n


% Constants
global Theta k Dt Dx Ie  d u g m n
% external variable (input) Theta k Dt Dx d n
% internal variable (some are output) Ie H Q h A C
%persistent H Q h A C
global H Q h A C
g = 9.81; %[m/s^2] gravitational constant

Ie(1:n,1:n) = 0.00214;% [.] Resistance Ie = f * v^2/(2*g)*1/R
Ie_init = Ib;
for m = 1:150
    for n = 1:150
if m == 1 && n==1
    Q(1,1:n) = Q_init;
    C(1,1:n) = C_init;
    
    Qf = -3.02 * log((0.74*10^(-6))/(d*sqrt(d*Ie(m,n)))+(k/(3.71*d)))*d^2*sqrt(d*Ie(m,n)); %[m^3/s] palles
    Qff = 72*(d/4)^0.635*pi*(d/2)^2*Ie(m,n)^0.5;% Hennings
    % Regression to a plot, to find Q from a function 

    h_test=0.0001:d/100:d;
    for t = 1:100

       Q_test(t)=(0.46 - 0.5 *cos(pi*(h_test(t)/d))+0.04*cos(2*pi*(h_test(t)/d)))*Qf;
        
    end
    fitfunc = fit(Q_test',h_test','poly3');
    h_init(n) =fitfunc.p1*Q_init(n)^3 + fitfunc.p2*Q_init(n)^2 + fitfunc.p3*Q_init(n) + fitfunc.p4;
else

    
    h_initial = fitfunc.p1*Q_init^3 + fitfunc.p2*Q_init^2 + fitfunc.p3*Q_init + fitfunc.p4; % check hieght




    %
    Q_initial_time = Q_init; % [m^3/s]
    %%Flow for distance
    for n = 1:n
       % Q_init(n) = (0.46 - 0.5 *cos(pi*(h_init(n)/d))+0.04*cos(2*pi*(h_init(n)/d)))*Qf; % [m^3/s]
        Q_init(n)=Q_initial_distance;
    end

    % Area for distance
    for  n= 1:n  
        %  A_init(n) = d^2/4 * acos(((d/2)-h_init(n)/(d/2)))-sqrt(h_init(n)*(d-h_init(n)))*((d/2)-h_init(n));
       h_init(n) =fitfunc.p1*Q_init(n)^3 + fitfunc.p2*Q_init(n)^2 + fitfunc.p3*Q_init(n) + fitfunc.p4;
       A_init(n) = d^2/4 * acos(((d/2)-h_init(n))/(d/2))-sqrt(h_init(n)*(d-h_init(n)))*((d/2)-h_init(n));

    end 


%     Q1_init = Q1_init;
%     Q = zeros(n-1,n);
%     Q = [Q_init; Q];
%     Q = [Q1_init Q];
%     Q(:,n+1)=[];
% 
% 
%     h = zeros(n-1,n);
%     h = [h_init; h];
%     h = [h1_init' h];
%     h(:,n+1)=[];
% 
% 
%     A1_init = A1_init';
%     A = zeros(n-1,n);
%     A = [A_init; A];
%     A = [A1_init A];
%     A(:,n+1)=[];
% 
% 
%     C(1:n,1) = C_in;
%     C(1,2:n) =C_init;


    for m = 1:n 
        for n = 1:n
            u(m,n)= Q(m,n)/A(m,n); 
        end
    end 


    
        if m > 3
            if n > 3
                Ie(m,n) = Ib - (h(m,n-1)-h(m-2,n-1))/(2*Dx)-...
                    2/g*u(n-1,m-1)*(u(m,n-1)-u(m-2,n-1))/(2*Dx)- ...
                    ((u(n-1,m-1))^2)/(g*A(m-1,n-1))*(A(m,n-1)-A(m-2,n-1))/(2*Dx)-...
                    (u(n-1,m-1))/(g*A(m-1,n-1))*(A(m-1,n)-A(m-1,n-2))/(2*Dt)- ...
                    1/g*(u(m-1,n)-u(m-1,n-2))/(2*Dt);
               % Ie(m,n)  = abs(Ie(m,n))
                Ie3(m,n) = Ib - (h(m,n-1)-h(m-2,n-1))/(2*Dx)- ...
                    2/g*u(n-1,m-1)*(u(m,n-1)-u(m-2,n-1))/(2*Dx)- ...
                    ((u(n-1,m-1))^2)/(g*A(m-1,n-1))*(A(m,n-1)-A(m-2,n-1))/(2*Dx)- ...
                    (u(n-1,m-1))/(g*A(m-1,n-1))*(A(m-1,n)-A(m-1,n-2))/(2*Dt)- ...
                    1/g*(u(m-1,n)-u(m-1,n-2))/(2*Dt);
            end
        end
        
        H = (2*(1-Theta)*Q(m-1,n-1)-2*(1-Theta)*Q(m-1,n)+2*Theta*Q(m,n-1))*Dt/Dx - A(m,n-1)+A(m-1,n-1)+A(m-1,n);
      %  H= abs(H);
       
        h(m,n)=NewtonRoot(@V1stDer,@V2ndDer,h(m-1,n-1),0.05,50,d);
%          h(m,n) =BisectionRoot(@V1stDer,0,2,0.01);
%             h(m,n) = BiSectionV2(@V1stDer,0,2);

        A(m,n) = d^2/4 * acos(((d/2)-h(m,n))/(d/2))-sqrt(h(m,n)*(d-h(m,n)))*((d/2)-h(m,n));
    
        Q(m,n) = (-1/(Theta*2))*(A(m,n)-H)*Dx/Dt;

        u(m,n)= Q(m,n)/A(m,n);      
        % CONCENTRATE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        C(m,n)= (Q(m,n)/A(m,n))*(Dt/Dx)*(C(m-1,n-1)-C(m-1,n))+C(m-1,n);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
    end 

end
%         for m =3:n
%             for n = 3:n
%                 Ie(m,n) = Ib - (h(m,n-1)-h(m-2,n-1))/(2*Dx)- ...
%                 2/g*u(n-1,m-1)*(u(m,n-1)-u(m-2,n-1))/(2*Dx)- ...
%                 ((u(n-1,m-1))^2)/(g*A(m-1,n-1))*(A(m,n-1)-A(m-2,n-1))/(2*Dx)- ...
%                 (u(n-1,m-1))/(g*A(m-1,n-1))*(A(m-1,n)-A(m-1,n-2))/(2*Dt)- ...
%                 1/g*(u(m-1,n)-u(m-1,n-2))/(2*Dt);
%             end
%         end
%        
        
        

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f=V1stDer(h)%V
global d Ie H Dt Dx Theta m n 
f = -72*(d/4)^0.635 * pi*(d/2)^2*Ie(m,n)^0.5*(0.46-0.5*cos(pi*(h/d))+ ...
0.04*cos(2*pi*(h/d)))*(Dt/Dx)-(1/(2*Theta))*(d^2/4 * acos(((d/2)-h)/(d/2))- ...
sqrt(h*(d-h))*((d/2)-h)-H);

% f = -3.02*log((0.74*10^-6)/d*sqrt(d*Ie)+(0.0015)/(3.71*d))*d^2*sqrt(d*Ie)*(0.46-0.5*cos(pi*(h/d))+ ...
% 0.04*cos(2*pi*(h/d)))*(Dt/Dx)-1/(2*Theta)*(d^2/4 * acos(((d/2)-h)/(d/2))- ...
% sqrt(h*(d-h))*((d/2)-h)-H);

end 

function f=V2ndDer(h)%Vdot
global d Ie Dt Dx Theta m n 
f = -72*(d/4)^0.635 * pi*(d/2)^2*Ie(m,n)^0.5*(0.5*pi*sin(pi*(h/d))- ...
0.08*pi*sin(2*pi*(h/d)))*Dt/Dx-(d/Theta)*sqrt(-h^2+(d*h));

% f = -3.02*log((0.74*10^-6)/d*sqrt(d*Ie)+(0.0015)/(3.71*d))*d^2*sqrt(d*Ie)*(0.5*pi*sin(pi*(h/d))- ...
% 0.08*pi*sin(2*pi*(h/d)))*Dt/Dx-(d/Theta)*sqrt(-h^2+(d*h));
end
%end