function [out]=init_pipe(piping,input,accuracy)
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
limitvalue = 0.00001; %newton stop iteration value

avg = 10;
desired = 0;
Q_mark = 10; % initial value that makes sure the while loop runs at least once
epsi = input.Q_init/10;
g = 9.81; %[m/s^2] gravitational constant

while abs(avg-desired) > limit
    m = m + 1;
    for x = 1:length(piping)
        
        Ib = piping(x).Ib;
        d = piping(x).d; %[m] Diameter
        k = piping(x).k; %sandruhed angives typisk i mm der skal bruges m i formler
        Theta = piping(x).Theta;
        Dx = piping(x).Dx; %[m] grid distance
        sections = piping(x).sections; % Number of sections,

        for n = 1:sections
            %%%%%%%%%%%%%%%%%%%%%%%% Initialization %%%%%%%%%%%%%%%%%%%%%%%%%%
            if m == 1 && n==1
%                 Ie(1:iterations,1:sections) = Ib; % this is gay and cant be right FIGURE IT OUT!!!!!
                %    Qf = -3.02 * log((0.74*10^(-6))/(d*sqrt(d*Ie(m,n)))+(k/(3.71*d)))*d^2*sqrt(d*Ie(m,n)); %[m^3/s] palles
                Qf = 72*(d/4)^0.635*pi*(d/2)^2*Ib^0.5;% Hennings
                h_init=0:d/1000:d;
                for t = 1:1001
                    Q_initialize(t)=(0.46 - 0.5 *cos(pi*(h_init(t)/d))+0.04*cos(2*pi*(h_init(t)/d)))*Qf;
                end
                
                data{x}.fitfunc = fit(Q_initialize',h_init','poly9');
                if x == 1
                    data{x}.Q(1,1:sections) = input.Q_init;
                    data{x}.C(1,1:sections) = input.C_init;
                    data{x}.h(1:sections) = data{x}.fitfunc(input.Q_init)
                else
                    if piping(x).lat_inflow == 1
                        data{x}.Q(1,1:sections) = data{x-1}.Q(1,end)+input.lat.Q{x-1};
                        data{x}.C(1,1:sections) = (data{x-1}.C(m,end)*data{x-1}.Q(m,end)+input.lat.C{x-1}*input.lat.Q{x-1})/(data{x-1}.Q(m,end)+input.lat.Q{x-1});
                    else
                        data{x}.Q(1,1:sections) = data{x-1}.Q(1,end);
                        data{x}.C(1,1:sections) = data{x-1}.C(1,end);
                    end
                    data{x}.h(1:sections) = data{x}.fitfunc(data{x-1}.Q(1,end));
                end
                data{x}.A(1:sections) = d^2/4 * acos(((d/2)-data{x}.h(n))/(d/2))-sqrt(data{x}.h(n)*(d-data{x}.h(n)))*((d/2)-data{x}.h(n));
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Border conditions %%%%%%%%%%%%%%%%%%%%
            elseif m > 1 && n == 1
                if x == 1
                    data{x}.Q(m,n) = input.Q_init;
                    data{x}.C(m,n) = input.C_init;
                    data{x}.h(m,n) = data{x}.fitfunc(input.Q_init);
                else
                    if piping(x-1).lat_inflow == 1
                        data{x}.Q(m,n) = data{x-1}.Q(m,end)+input.lat.Q{x-1};
                        data{x}.C(m,n) = (data{x-1}.C(m,end)*data{x-1}.Q(m,end)+input.lat.C{x-1}*input.lat.Q{x-1})/(data{x-1}.Q(m,end)+input.lat.Q{x-1});
                    else
                        data{x}.Q(m,n) = data{x-1}.Q(m,end);
                        data{x}.C(m,n) = data{x-1}.C(m,end);
                    end
%                     data{x}.h(m,n) = data{x}.fitfunc(Q(m,n);
                    data{x}.h(m,n) = data{x-1}.h(m,end);
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
        converging_target = [avg desired]
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
    function f1=V(h)%V
    f1 = -72*(d/4)^0.635 * pi*(d/2)^2*Ib^0.5*(0.46-0.5*cos(pi*(h/d))+ ...
        0.04*cos(2*pi*(h/d)))*(Dt/Dx)-(1/(2*Theta))*(d^2/4 * acos(((d/2)-h)/(d/2))- ...
        sqrt(h*(d-h))*((d/2)-h)-H);
    end
    
    function f2=V_dot(h)%Vdot
    f2 = -72*(d/4)^0.635 * pi*(d/2)^2*Ib^0.5*(0.5*pi*sin(pi*(h/d))- ...
        0.08*pi*sin(2*pi*(h/d)))*Dt/Dx-(d/Theta)*sqrt(-h^2+(d*h));
    end

    
end

