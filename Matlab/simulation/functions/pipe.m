function [output]=pipe(piping,input,data,pipe_component,m,sys_component,pipe_spec)
                %Pipe(bed slope(Ib),        Ruhedsfaktor(k),
                %Delta t(Dt),               Delta x(Dx), 
                %Diameter(d),               Pipe sections(sections),
                %Current time iteration(m), Initial flow (Q_init),
                %Input flow (Q_in),         Initial concentrate(C_init),
                %Input concentrate(C_in),   finite scheme konstant(Theta)) 
                %length of pipe is Dx*n

% persistent H Q h A C Ie
global Dt
newt_iter = 50;
limitvalue = 0.000001; %newton stop iteration value


Ib = piping(pipe_component).Ib; 
d = piping(pipe_component).d; %[m] Diameter
k = piping(pipe_component).k; %sandruhed angives typisk i mm der skal bruges m i formler
Theta = piping(pipe_component).Theta;
Dx = piping(pipe_component).Dx; %[m] grid distance
sections = piping(pipe_component).sections; % Number of sections,
C_in = input.C_in(m); % concentrate input
Q_in = input.Q_in(m);
Q_mark = 10; % initial value that makes sure the while loop runs at least once
epsi = input.Q_init/1000;
g = 9.81; %[m/s^2] gravitational constant
% Ie(1:n,1:n) = 0.00214;% [.] Resistance Ie = f * v^2/(2*g)*1/R
if m > 1
    Q = data{sys_component}.Q;
    A = data{sys_component}.A;
    h = data{sys_component}.h;
    C = data{sys_component}.C;
    Ie = data{sys_component}.Ie;
    fitfunc = data{sys_component}.fitfunc;
end
        

for n = 1:sections
    if m == 1 && n==1
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Border conditions %%%%%%%%%%%%%%%%%%%%
    elseif m > 1 && n == 1
        Ie(m,1:sections) = piping(pipe_component).Ib;
        if sys_component == 1
            Q(m,n) = Q_in;
            C(m,n) = C_in;
            %                         h(m,n) = init_height(epsi,Q_in,Q_mark,0,d);
            h(m,n) = fitfunc(Q_in);
        else
            if pipe_component > 1 && piping(pipe_component-1).lat_inflow == 1
                Q(m,n) = data{sys_component-1}.Q(m,end)+input.lat.Q{pipe_component-1};
                C(m,n) = (data{sys_component-1}.C(m,end) * data{sys_component-1}.Q(m,end) + input.lat.C{pipe_component-1} * input.lat.Q{pipe_component-1}) / (data{sys_component-1}.Q(m,end) + input.lat.Q{pipe_component-1});
            else
                Q(m,n) = data{sys_component-1}.Q(m,end);
                C(m,n) = data{sys_component-1}.C(m,end);
            end
        if pipe_component > 1  % use output height of last pipe section as guess for the new ones, gives smooth simulation  
            fetch = pipe_spec(pipe_component-1).data_location;
            h(m,n) = data{fetch}.h(m,end);
        else    
             h(m,n) = fitfunc(Q(m,n));
        end
            %             h(m,n) = init_height(epsi,Q(1,1),Q_mark,0,d);

        end
        %         Qf = -3.02 * log((0.74*10^(-6))/(d*sqrt(d*Ie(m,n)))+(k/(3.71*d)))*d^2*sqrt(d*Ie(m,n));
        A(m,n) = d^2/4 * acos(((d/2)-h(m,n))/(d/2))-sqrt(h(m,n)*(d-h(m,n)))*((d/2)-h(m,n));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Iteration %%%%%%%%%%%%%%%%%%%%%%%%%%%
    elseif m > 1 && n > 1
        H = (2*(1-Theta)*Q(m-1,n-1)-2*(1-Theta)*Q(m-1,n)+ ...
            2*Theta*Q(m,n-1))*Dt/Dx - ...
            A(m,n-1)+ A(m-1,n-1)+ A(m-1,n);
        h(m,n)=NewtonRoot(@V,@V_dot,h(m-1,n-1),limitvalue,newt_iter,d,Ie,H,Dt,Dx,Theta,m,n);
        A(m,n) = d^2/4 * acos(((d/2)- h(m,n))/(d/2))-sqrt(h(m,n)*(d-h(m,n)))*((d/2)-h(m,n));
        Q(m,n) = (-1/(Theta*2))*(A(m,n)-H)*Dx/Dt;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % CONCENTRATE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%% euler baglaens %%%%
        %         C(m,n)= (C(m,n-1)*A(m,n))/(A(m,n)+Q(m,n)*(Dt/Dx))+(Q(m,n)*C(m-1,n))/(A(m,n)*(Dx/Dt)+Q(m,n));
        C(m,n)= (( C(m-1,n)*A(m,n) ) / ( A(m,n)+Q(m,n)*(Dt/Dx) )) + (( Q(m,n)*C(m,n-1) ) / ( A(m,n)*(Dx/Dt)+Q(m,n) ));
        %%%%%%%%%%%%%%%%%%%%%%%
        
    end
end

if m == 1
    temp = data;
else
    temp.Q = Q;
    temp.A = A;
    temp.h = h;
    temp.C = C;
    temp.Ie = Ie;
    temp.fitfunc = data{sys_component}.fitfunc;
end
data{1,sys_component} = temp;
output = data;
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

