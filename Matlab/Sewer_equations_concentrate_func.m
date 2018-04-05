% %% Sewer pipe equations
% clc
% clear all
% close all
% % Notes %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Theta = 0.65;
% k=0.0015; %angives typisk i mm der skal bruges m i formler
% 
% Dt = 20; %[s] grid time
% Dx = 8; %[m] grid distance
% pipe_length = 50*Dx % has to be multiple of Dx
% d = 0.6; %[m] Diameter
% 
% sections=40; % Number of sections,
% iterations = 150;
% % Friction part 
% 
% 
% Ib = 0.00214;
% C_in= 10; % concentrate input
% C_init = 8; % initial cocentrate in pipe
% Q_in = 0.015;
% Q_init = 0.015;

function [Q(m,:) C(m,:) A(m,:) h(m,:)]=pipe(Ib,k,Dt,Dx,d,sections,m,Q_init,Q_in,C_init,C_in,Theta)
                %Pipe(bed slope(Ib),        Ruhedsfaktor(k),
                %Delta t(Dt),               Delta x(Dx), 
                %Diameter(d),               Pipe sections(sections),
                %Current time iteration(m), Initial flow (Q_init),
                %Input flow (Q_in),         Initial concentrate(C_init),
                %Input concentrate(C_in),   finite scheme konstant(Theta)) 
                %length of pipe is Dx*n

persistent H Q h A C Ie
% Constants
% global Theta k Dt Dx Ie  d u m n
% external variable (input) Theta k Dt Dx d n
% internal variable (some are output) Ie H Q h A C


% global H Q h A C
g = 9.81; %[m/s^2] gravitational constant

% Ie(1:n,1:n) = 0.00214;% [.] Resistance Ie = f * v^2/(2*g)*1/R

% for m = 1:iterations % this is going outside the function when finished
    for n = 1:sections
       %%%%%%%%%%%%%%%%%%%%%%%% Initialization %%%%%%%%%%%%%%%%%%%%%%%%%%
        if m == 1 && n==1 
            Q(1,1:sections) = Q_init;
            C(1,1:sections) = C_init;
            Ie(1:iterations,1:sections) = Ib; % this is gay and cant be right FIGURE IT OUT!!!!!
            Qf = -3.02 * log((0.74*10^(-6))/(d*sqrt(d*Ie(m,n)))+(k/(3.71*d)))*d^2*sqrt(d*Ie(m,n)); %[m^3/s] palles
            Qff = 72*(d/4)^0.635*pi*(d/2)^2*Ie(m,n)^0.5;% Hennings
            % Regression to a plot, to find Q from a function 

            h_test=0.0001:d/100:d;
            for t = 1:100
               Q_test(t)=(0.46 - 0.5 *cos(pi*(h_test(t)/d))+0.04*cos(2*pi*(h_test(t)/d)))*Qf;
            end
            fitfunc = fit(Q_test',h_test','poly3');
            %h(1:sections) =fitfunc.p1*Q_init^3 + fitfunc.p2*Q_init^2 + fitfunc.p3*Q_init + fitfunc.p4;
            h(1:sections) = 0.105;
            A(1:sections) = d^2/4 * acos(((d/2)-h(n))/(d/2))-sqrt(h(n)*(d-h(n)))*((d/2)-h(n));
            u = Q./A;
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        elseif m > 1 && n == 1
            Q(m,n) = Q_in;
%           h(m,n) =fitfunc.p1*Q_in^3 + fitfunc.p2*Q_in^2 + fitfunc.p3*Q_in + fitfunc.p4;
            h(m,n) = 0.105;
            A(m,n) = d^2/4 * acos(((d/2)-h(m,n))/(d/2))-sqrt(h(m,n)*(d-h(m,n)))*((d/2)-h(m,n));
            C(m,n) = C_in;
        elseif m > 1

        
        H = (2*(1-Theta)*Q(m-1,n-1)-2*(1-Theta)*Q(m-1,n)+2*Theta*Q(m,n-1))*Dt/Dx - A(m,n-1)+A(m-1,n-1)+A(m-1,n);

        h(m,n)=NewtonRoot(@V,@V_dot,h(m-1,n-1),0.05,50,d);
        A(m,n) = d^2/4 * acos(((d/2)-h(m,n))/(d/2))-sqrt(h(m,n)*(d-h(m,n)))*((d/2)-h(m,n));
        Q(m,n) = (-1/(Theta*2))*(A(m,n)-H)*Dx/Dt;
        % CONCENTRATE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        C(m,n)= (Q(m,n)/A(m,n))*(Dt/Dx)*(C(m-1,n-1)-C(m-1,n))+C(m-1,n);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        end
    end 
% end
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
function f=V(h)%V
global d Ie H Dt Dx Theta m n 
f = -72*(d/4)^0.635 * pi*(d/2)^2*Ie(m,n)^0.5*(0.46-0.5*cos(pi*(h/d))+ ...
0.04*cos(2*pi*(h/d)))*(Dt/Dx)-(1/(2*Theta))*(d^2/4 * acos(((d/2)-h)/(d/2))- ...
sqrt(h*(d-h))*((d/2)-h)-H);

% f = -3.02*log((0.74*10^-6)/d*sqrt(d*Ie)+(0.0015)/(3.71*d))*d^2*sqrt(d*Ie)*(0.46-0.5*cos(pi*(h/d))+ ...
% 0.04*cos(2*pi*(h/d)))*(Dt/Dx)-1/(2*Theta)*(d^2/4 * acos(((d/2)-h)/(d/2))- ...
% sqrt(h*(d-h))*((d/2)-h)-H);

end 

function f=V_dot(h)%Vdot
global d Ie Dt Dx Theta m n 
f = -72*(d/4)^0.635 * pi*(d/2)^2*Ie(m,n)^0.5*(0.5*pi*sin(pi*(h/d))- ...
0.08*pi*sin(2*pi*(h/d)))*Dt/Dx-(d/Theta)*sqrt(-h^2+(d*h));

% f = -3.02*log((0.74*10^-6)/d*sqrt(d*Ie)+(0.0015)/(3.71*d))*d^2*sqrt(d*Ie)*(0.5*pi*sin(pi*(h/d))- ...
% 0.08*pi*sin(2*pi*(h/d)))*Dt/Dx-(d/Theta)*sqrt(-h^2+(d*h));
end
end
