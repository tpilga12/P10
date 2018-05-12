function [output]=pipe(pipe_spec, input, data, pipe_component, m, element, sys_component,new_pipe)
                %Pipe(bed slope(Ib),        Ruhedsfaktor(k),
                %Delta t(Dt),               Delta x(Dx), 
                %Diameter(d),               Pipe sections(sections),
                %Current time iteration(m), Initial flow (Q_init),
                %Input flow (Q_in),         Initial concentrate(C_init),
                %Input concentrate(C_in),   finite scheme konstant(Theta)) 
                %length of pipe is Dx*n

global Dt
newt_iter = 50;
limitvalue = 0.000001; %newton stop iteration value
%         Qf = -3.02 * log((0.74*10^(-6))/(d*sqrt(d*Ie(m,n)))+(k/(3.71*d)))*d^2*sqrt(d*Ie(m,n));

Ib = pipe_spec(pipe_component).Ib; 
d = pipe_spec(pipe_component).d; %[m] Diameter
k = pipe_spec(pipe_component).k; %sandruhed angives typisk i mm der skal bruges m i formler
Theta = pipe_spec(pipe_component).Theta;
Dx = pipe_spec(pipe_component).Dx; %[m] grid distance
sections = pipe_spec(pipe_component).sections; % Number of sections,
Q_mark = 10; % initial value that makes sure the while loop runs at least once
epsi = input.Q_init/1000;
% Ie(1:n,1:n) = 0.00214;% [.] Resistance Ie = f * v^2/(2*g)*1/R
if m > 1
    Q = data{sys_component}.Q;
    A = data{sys_component}.A;
    h = data{sys_component}.h;
    C = data{sys_component}.C;
    Ie = data{sys_component}.Ie;
    fitfunc = data{sys_component}.fitfunc;
end
        
Ie(m,1:sections) = pipe_spec(pipe_component).Ib;

for n = 1:sections

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Border conditions %%%%%%%%%%%%%%%%%%%%
    if n == 1
        
        if new_pipe == 1
            if  pipe_spec(pipe_component).lat_inflow == 1
                Q(m,n) = input.Q_in(m,element)+input.lat.Q{pipe_component};
                C(m,n) = (input.C_in(m,element) * input.Q_in(m,element) + input.lat.C{pipe_component} * input.lat.Q{pipe_component}) / (input.Q_in(m,element) + input.lat.Q{pipe_component-1});
            else
                Q(m,n) = input.Q_in(m,element);
                C(m,n) = input.C_in(m,element);
            end
        else
            if pipe_spec(pipe_component).lat_inflow == 1
                Q(m,n) = data{sys_component-1}.Q(m,end)+input.lat.Q{pipe_component-1};
                C(m,n) = (data{sys_component-1}.C(m,end) * data{sys_component-1}.Q(m,end) + input.lat.C{pipe_component} * input.lat.Q{pipe_component}) / (data{sys_component-1}.Q(m,end) + input.lat.Q{pipe_component});
            else
                Q(m,n) = data{sys_component-1}.Q(m,end);
                C(m,n) = data{sys_component-1}.C(m,end);
            end
        end
        h(m,n) = fitfunc(Q(m,n));
        A(m,n) = d^2/4 * acos(((d/2)-h(m,n))/(d/2))-sqrt(h(m,n)*(d-h(m,n)))*((d/2)-h(m,n));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Iteration %%%%%%%%%%%%%%%%%%%%%%%%%%%
    elseif n > 1
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
    temp.fitfunc2 = data{sys_component}.fitfunc2;
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

