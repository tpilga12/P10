function [output]=pipe(piping,input,data,x,m)
                %Pipe(bed slope(Ib),        Ruhedsfaktor(k),
                %Delta t(Dt),               Delta x(Dx), 
                %Diameter(d),               Pipe sections(sections),
                %Current time iteration(m), Initial flow (Q_init),
                %Input flow (Q_in),         Initial concentrate(C_init),
                %Input concentrate(C_in),   finite scheme konstant(Theta)) 
                %length of pipe is Dx*n

% persistent H Q h A C Ie
global Dt iterations Q_init C_init 

limitvalue = 0.05; %newton stop iteration value
Ib = piping(x).Ib; 
d = piping(x).d; %[m] Diameter
k = piping(x).k; %sandruhed angives typisk i mm der skal bruges m i formler
Theta = piping(x).Theta;
Dx = piping(x).Dx; %[m] grid distance
sections = piping(x).sections; % Number of sections,
C_in = input.C_in; % concentrate input
Q_in = input.Q_in;
Q_mark = 10; % initial value that makes sure the while loop runs at least once
epsi = Q_init/10;
g = 9.81; %[m/s^2] gravitational constant
% Ie(1:n,1:n) = 0.00214;% [.] Resistance Ie = f * v^2/(2*g)*1/R
if m > 1
    Q = data{x}.Q;
    A = data{x}.A;
    h = data{x}.h;
    C = data{x}.C;
    Ie = data{x}.Ie;
end

    for n = 1:sections
       %%%%%%%%%%%%%%%%%%%%%%%% Initialization %%%%%%%%%%%%%%%%%%%%%%%%%%
        if m == 1 && n==1
%             temp{x+1}= 0;
            if x == 1
                Q(1,1:sections) = Q_init;
                C(1,1:sections) = C_init;
                h(1:sections) = init_height(epsi,Q_init,Q_mark,0,d);
            else
                Q(1,1:sections) = data{x-1}.Q(1,end);
                C(1,1:sections) = data{x-1}.C(1,end);
                h(1:sections) = init_height(epsi,Q(1,1),Q_mark,0,d);
            end
            
            A(1:sections) = d^2/4 * acos(((d/2)-h(n))/(d/2))-sqrt(h(n)*(d-h(n)))*((d/2)-h(n));
            Ie(1:iterations,1:sections) = Ib; % this is gay and cant be right FIGURE IT OUT!!!!!
            Qf = -3.02 * log((0.74*10^(-6))/(d*sqrt(d*Ie(m,n)))+(k/(3.71*d)))*d^2*sqrt(d*Ie(m,n)); %[m^3/s] palles
            Qff = 72*(d/4)^0.635*pi*(d/2)^2*Ie(m,n)^0.5;% Hennings

            % Regression to a plot, to find Q from a function 
            %h_test=0.0001:d/100:d;
            h_init=0:d/100:d;
            for t = 1:101
               Q_initialize(t)=(0.46 - 0.5 *cos(pi*(h_init(t)/d))+0.04*cos(2*pi*(h_init(t)/d)))*Qf;
            end
            fitfunc = fit(Q_initialize',h_init','poly9');
            temp{1}.fitfunc = fitfunc;
 %           h(1:sections) = fitfunc.p1*Q_init.^9 +fitfunc.p2*Q_init.^8 + fitfunc.p3*Q_init.^7 + fitfunc.p4*Q_init.^6 + fitfunc.p5*Q_init.^5 + fitfunc.p6*Q_init.^4 + fitfunc.p7*Q_init.^3 + fitfunc.p8*Q_init^2 + fitfunc.p9*Q_init +fitfunc.p10;

      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Border conditions %%%%%%%%%%%%%%%%%%%%  
        elseif m > 1 && n == 1
            if x == 1
                Q(m,n) = Q_in;
                C(m,n) = C_in;
                h(m,n) = init_height(epsi,Q_in,Q_mark,0,d);
            else
                Q(m,n) = data{x-1}.Q(m,end);
                C(m,n) = data{x-1}.C(m,end);
                h(m,n) = init_height(epsi,Q(x-1,1),Q_mark,0,d);
            end
            Qf = -3.02 * log((0.74*10^(-6))/(d*sqrt(d*Ie(m,n)))+(k/(3.71*d)))*d^2*sqrt(d*Ie(m,n));
%             %h(m,n) = out.fitfunc.p1*Q_in.^9 +out.fitfunc.p2*Q_in.^8 + out.fitfunc.p3*Q_in.^7 + out.fitfunc.p4*Q_in.^6 + out.fitfunc.p5*Q_in.^5 + out.fitfunc.p6*Q_in.^4 + out.fitfunc.p7*Q_in.^3 + out.fitfunc.p8*Q_in^2 + out.fitfunc.p9*Q_in +out.fitfunc.p10;
            A(m,n) = d^2/4 * acos(((d/2)-h(m,n))/(d/2))-sqrt(h(m,n)*(d-h(m,n)))*((d/2)-h(m,n));
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Iteration %%%%%%%%%%%%%%%%%%%%%%%%%%%  
        elseif m > 1 && n > 1
                H = (2*(1-Theta)*Q(m-1,n-1)-2*(1-Theta)*Q(m-1,n)+2*Theta*Q(m,n-1))*Dt/Dx - A(m,n-1)+ A(m-1,n-1)+ A(m-1,n);
                h(m,n)=NewtonRoot(@V,@V_dot,h(m-1,n-1),limitvalue,50,d,Ie,H,Dt,Dx,Theta,m,n);
                A(m,n) = d^2/4 * acos(((d/2)- h(m,n))/(d/2))-sqrt(h(m,n)*(d-h(m,n)))*((d/2)-h(m,n));
                Q(m,n) = (-1/(Theta*2))*(A(m,n)-H)*Dx/Dt;
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % CONCENTRATE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%% euler bagl?ns %%%%
                C(m,n)= (C(m,n-1)*A(m,n))/(A(m,n)+Q(m,n)*(Dt/Dx))+(Q(m,n)*C(m-1,n))/(A(m,n)*(Dx/Dt)+Q(m,n)); 
                %%%%%%%%%%%%%%%%%%%%%%%
                %%%%%%%%%%% explicit from numerical %%%%%%%
%               C(m,n)= (Q(m,n)/A(m,n))*(Dt/Dx)*(C(m-1,n-1)-C(m-1,n))+C(m-1,n);
%               C(m+1,n)=C(m,n) + (Q(m,n)/A(m,n))*(Dt/2*Dx)*(C_in-C(m,n+1));
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        end
%         if n == 1 && n < sections && m < iteration
%             C(m+1,n)=C(m,n) + (Q(m,n)/A(m,n)) *(Dt/(2*Dx)) * (C_in-C(m,n+1));
%         elseif n > 1 && n < sections && m < iteration
%             C(m+1,n)=C(m,n) + (Q(m,n)/A(m,n)) *(Dt/(2*Dx)) * (C(m,n-1)-C(m,n+1));
%         elseif n == sections && m < iteration
%             C(m+1,n)=C(m,n) + (Q(m,n)/A(m,n)) *(Dt/(2*Dx)) * (C(m,n-1)-C(m,n));
%         end
        
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
temp{1}.Q = Q;
temp{1}.Q_out = Q(:,end);
temp{1}.A = A;
temp{1}.h = h;
temp{1}.C = C;
temp{1}.C_out = C(:,end);
temp{1}.Ie = Ie;
if m > 1
temp{1}.fitfunc = data{x}.fitfunc;
end

output = temp;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function f=V(h)%V
    f = -72*(d/4)^0.635 * pi*(d/2)^2*Ie(m,n)^0.5*(0.46-0.5*cos(pi*(h/d))+ ...
    0.04*cos(2*pi*(h/d)))*(Dt/Dx)-(1/(2*Theta))*(d^2/4 * acos(((d/2)-h)/(d/2))- ...
    sqrt(h*(d-h))*((d/2)-h)-H);
    end 

    function f=V_dot(h)%Vdot
    f = -72*(d/4)^0.635 * pi*(d/2)^2*Ie(m,n)^0.5*(0.5*pi*sin(pi*(h/d))- ...
    0.08*pi*sin(2*pi*(h/d)))*Dt/Dx-(d/Theta)*sqrt(-h^2+(d*h));
    end

    function f = Area_fun(h)
        f = d^2/4 * acos(((d/2)-h)/(d/2))-sqrt(h*(d-h))*((d/2)-h);
    end
    function f=hy_perimeter(h)
        f = acos(1-(h/(d/2)))*d;
    end

    function height = init_height(epsi,Q_init,Q_mark,h_min,h_max)
        while epsi < abs(Q_init-Q_mark)
            h_mark=(h_min+h_max)/2;
            area_it = Area_fun(h_mark);
            Q_mark = 72*(area_it/hy_perimeter(h_mark))^(2/3)*Ib^0.5*area_it;
            if Q_mark < Q_init
                h_min = h_mark;
            else
                h_max = h_mark;
            end
        end
        height = h_mark;
    end
end

