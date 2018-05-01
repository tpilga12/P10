function [out]=init(piping,input,accuracy)
%Pipe(bed slope(Ib),        Ruhedsfaktor(k),
%Delta t(Dt),               Delta x(Dx),
%Diameter(d),               Pipe sections(sections),
%Current time iteration(m), Initial flow (Q_init),
%Input flow (Q_in),         Initial concentrate(C_init),
%Input concentrate(C_in),   finite scheme konstant(Theta))
%length of pipe is Dx*n

% persistent H Q h A C Ie
global Dt
m = 0;

limit = accuracy;

avg = 10;
desired = 0;
while abs(avg-desired) > limit
    m = m + 1;
    for x = 1:length(piping)
        limitvalue = 0.00001; %newton stop iteration value
        Ib = piping(x).Ib;
        d = piping(x).d; %[m] Diameter
        k = piping(x).k; %sandruhed angives typisk i mm der skal bruges m i formler
        Theta = piping(x).Theta;
        Dx = piping(x).Dx; %[m] grid distance
        sections = piping(x).sections; % Number of sections,
        Q_mark = 10; % initial value that makes sure the while loop runs at least once
        epsi = input.Q_init/10;
        g = 9.81; %[m/s^2] gravitational constant
        % Ie(1:n,1:n) = 0.00214;% [.] Resistance Ie = f * v^2/(2*g)*1/R

        for n = 1:sections
            %%%%%%%%%%%%%%%%%%%%%%%% Initialization %%%%%%%%%%%%%%%%%%%%%%%%%%
            if m == 1 && n==1
%                 Ie(1:iterations,1:sections) = Ib; % this is gay and cant be right FIGURE IT OUT!!!!!
                h_init=0:d/1000:d;
                %         Qf = -3.02 * log((0.74*10^(-6))/(d*sqrt(d*Ie(m,n)))+(k/(3.71*d)))*d^2*sqrt(d*Ie(m,n)); %[m^3/s] palles
                Qf = 72*(d/4)^0.635*pi*(d/2)^2*Ib^0.5;% Hennings
                for t = 1:1001
                    Q_initialize(t)=(0.46 - 0.5 *cos(pi*(h_init(t)/d))+0.04*cos(2*pi*(h_init(t)/d)))*Qf;
                end
                data{x}.fitfunc = fit(Q_initialize',h_init','poly9');
                if x == 1
                    data{x}.Q(1,1:sections) = input.Q_init;
                    data{x}.C(1,1:sections) = input.C_init;
                    data{x}.h(1:sections) = data{x}.fitfunc.p1*input.Q_init.^9 +data{x}.fitfunc.p2*input.Q_init.^8 + data{x}.fitfunc.p3*input.Q_init.^7 + data{x}.fitfunc.p4*input.Q_init.^6 + data{x}.fitfunc.p5*input.Q_init.^5 + data{x}.fitfunc.p6*input.Q_init.^4 + data{x}.fitfunc.p7*input.Q_init.^3 + data{x}.fitfunc.p8*input.Q_init^2 + data{x}.fitfunc.p9*input.Q_init +data{x}.fitfunc.p10;
                else
                    if piping(x).lat_inflow == 1
                        data{x}.Q(1,1:sections) = data{x-1}.Q(1,end)+input.lat.Q{x-1};
                        data{x}.C(1,1:sections) = (data{x-1}.C(m,end)*data{x-1}.Q(m,end)+input.lat.C{x-1}*input.lat.Q{x-1})/(data{x-1}.Q(m,end)+input.lat.Q{x-1});
                    else
                        data{x}.Q(1,1:sections) = data{x-1}.Q(1,end);
                        data{x}.C(1,1:sections) = data{x-1}.C(1,end);
                    end
                    if x == 1
                        data{x}.h(1:sections) = data{x}.fitfunc.p1*Q_in.^9 + data{x}.fitfunc.p2*Q_in.^8 + data{x}.fitfunc.p3*Q_in.^7 + data{x}.fitfunc.p4*Q_in.^6 + data{x}.fitfunc.p5*Q_in.^5 + fitfunc.p6*Q_in.^4 + data{x}.fitfunc.p7*Q_in.^3 + data{x}.fitfunc.p8*Q_in^2 + data{x}.fitfunc.p9*Q_in + data{x}.fitfunc.p10;
                    else
                        data{x}.h(1:sections) = data{x}.fitfunc.p1*data{x-1}.Q(1,end).^9 + data{x}.fitfunc.p2*data{x-1}.Q(1,end).^8 + data{x}.fitfunc.p3*data{x-1}.Q(1,end).^7 + data{x}.fitfunc.p4*data{x-1}.Q(1,end).^6 + data{x}.fitfunc.p5*data{x-1}.Q(1,end).^5 + data{x}.fitfunc.p6*data{x-1}.Q(1,end).^4 + data{x}.fitfunc.p7*data{x-1}.Q(1,end).^3 + data{x}.fitfunc.p8*data{x-1}.Q(1,end)^2 + data{x}.fitfunc.p9*data{x-1}.Q(1,end) + data{x}.fitfunc.p10;
                    end
                end
                data{x}.A(1:sections) = d^2/4 * acos(((d/2)-data{x}.h(n))/(d/2))-sqrt(data{x}.h(n)*(d-data{x}.h(n)))*((d/2)-data{x}.h(n));
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Border conditions %%%%%%%%%%%%%%%%%%%%
            elseif m > 1 && n == 1
                if x == 1
                    data{x}.Q(m,n) = input.Q_init;
                    data{x}.C(m,n) = input.C_init;
                    data{x}.h(m,n) = data{x}.fitfunc.p1*input.Q_init.^9 + data{x}.fitfunc.p2*input.Q_init.^8 + data{x}.fitfunc.p3*input.Q_init.^7 + data{x}.fitfunc.p4*input.Q_init.^6 + data{x}.fitfunc.p5*input.Q_init.^5 + data{x}.fitfunc.p6*input.Q_init.^4 + data{x}.fitfunc.p7*input.Q_init.^3 + data{x}.fitfunc.p8*input.Q_init^2 + data{x}.fitfunc.p9*input.Q_init + data{x}.fitfunc.p10;
                else
                    if piping(x-1).lat_inflow == 1
                        data{x}.Q(m,n) = data{x-1}.Q(m,end)+input.lat.Q{x-1};
                        data{x}.C(m,n) = (data{x-1}.C(m,end)*data{x-1}.Q(m,end)+input.lat.C{x-1}*input.lat.Q{x-1})/(data{x-1}.Q(m,end)+input.lat.Q{x-1});
                    else
                        data{x}.Q(m,n) = data{x-1}.Q(m,end);
                        data{x}.C(m,n) = data{x-1}.C(m,end);
                    end
                    data{x}.h(m,n) = data{x}.fitfunc.p1*data{x}.Q(m,n).^9 + data{x}.fitfunc.p2*data{x}.Q(m,n).^8 + data{x}.fitfunc.p3*data{x}.Q(m,n).^7 + data{x}.fitfunc.p4*data{x}.Q(m,n).^6 + data{x}.fitfunc.p5*data{x}.Q(m,n).^5 + data{x}.fitfunc.p6*data{x}.Q(m,n).^4 + data{x}.fitfunc.p7*data{x}.Q(m,n).^3 + data{x}.fitfunc.p8*data{x}.Q(m,n)^2 + data{x}.fitfunc.p9*data{x}.Q(m,n) + data{x}.fitfunc.p10;
                end
                data{x}.A(m,n) = d^2/4 * acos(((d/2)-data{x}.h(m,n))/(d/2))-sqrt(data{x}.h(m,n)*(d-data{x}.h(m,n)))*((d/2)-data{x}.h(m,n));
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Iteration %%%%%%%%%%%%%%%%%%%%%%%%%%%
            elseif m > 1 && n > 1
                H = (2*(1-Theta)*data{x}.Q(m-1,n-1)-2*(1-Theta)*data{x}.Q(m-1,n)+ ...
                    2*Theta*data{x}.Q(m,n-1))*Dt/Dx - ...
                    data{x}.A(m,n-1)+ data{x}.A(m-1,n-1)+ data{x}.A(m-1,n);
                data{x}.h(m,n)=NewtonRoot(@V,@V_dot,data{x}.h(m-1,n-1),limitvalue,50,d,Ib,H,Dt,Dx,Theta,m,n);
                data{x}.A(m,n) = d^2/4 * acos(((d/2)- data{x}.h(m,n))/(d/2))-sqrt(data{x}.h(m,n)*(d-data{x}.h(m,n)))*((d/2)-data{x}.h(m,n));
                data{x}.Q(m,n) = (-1/(Theta*2))*(data{x}.A(m,n)-H)*Dx/Dt;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                % CONCENTRATE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%% euler baglaens %%%%
                %         C(m,n)= (C(m,n-1)*A(m,n))/(A(m,n)+Q(m,n)*(Dt/Dx))+(Q(m,n)*C(m-1,n))/(A(m,n)*(Dx/Dt)+Q(m,n));
                data{x}.C(m,n)= (data{x}.C(m-1,n)*data{x}.A(m,n))/(data{x}.A(m,n)+data{x}.Q(m,n)*(Dt/Dx))+(data{x}.Q(m,n)*data{x}.C(m,n-1))/(data{x}.A(m,n)*(Dx/Dt)+data{x}.Q(m,n));
                %%%%%%%%%%%%%%%%%%%%%%%
                
            end
        end
 end       
        for j = 1:length(piping)
            if piping(j).lat_inflow == 0
                pipe_avg_value{j} =  sum([data{j}.Q(m,:)])/piping(j).sections;
                desired_value{j} = input.Q_init;
            else
                pipe_avg_value{j} =  sum([data{j}.Q(m,:)])/piping(j).sections + input.lat.Q{1,j};
                desired_value{j} = input.Q_init + input.lat.Q{1,j};
            end
        end
        if m > 2
            avg = sum([pipe_avg_value{:}])/j;
            desired = sum([desired_value{:}])/j;
        end
        hej = [avg desired]
    end
    for l = 1:length(piping)
    out_data{l}.Q=data{l}.Q(end,:);
    out_data{l}.A=data{l}.A(end,:);
    out_data{l}.h=data{l}.h(end,:);
    out_data{l}.C=data{l}.C(end,:);
    out_data{l}.Ie(1,1:piping(l).sections) = piping(l).Ib;
    out_data{l}.fitfunc = data{l}.fitfunc;
    end
    out = [out_data];
   init_iterations = m
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%% Functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function f=V(h)%V
    f = -72*(d/4)^0.635 * pi*(d/2)^2*Ib^0.5*(0.46-0.5*cos(pi*(h/d))+ ...
        0.04*cos(2*pi*(h/d)))*(Dt/Dx)-(1/(2*Theta))*(d^2/4 * acos(((d/2)-h)/(d/2))- ...
        sqrt(h*(d-h))*((d/2)-h)-H);
    end
    
    function f=V_dot(h)%Vdot
    f = -72*(d/4)^0.635 * pi*(d/2)^2*Ib^0.5*(0.5*pi*sin(pi*(h/d))- ...
        0.08*pi*sin(2*pi*(h/d)))*Dt/Dx-(d/Theta)*sqrt(-h^2+(d*h));
    end
    
   
    function f = Area_fun(h)
    f = d^2/4 * acos(((d/2)-h)/(d/2))-sqrt(h*(d-h))*((d/2)-h);
    end
    
    
end

