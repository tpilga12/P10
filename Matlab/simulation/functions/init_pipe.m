function [out]=init_pipe(piping,input, sys_component, accuracy)
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
limitvalue = 0.0000001; %newton stop iteration value

avg = 10;
desired = 0;
g = 9.81; %[m/s^2] gravitational constant
stop_calc = 0;
while abs(avg-desired) > limit
    m = m + 1;
    for x = 1:length(piping)
        
        Ib = piping(x).Ib;
        d = piping(x).d; %[m] Diameter
        k = piping(x).k; %sandruhed angives typisk i mm der skal bruges m i formler
        Theta = piping(x).Theta;
        Dx = piping(x).Dx; %[m] grid distance
        sections = piping(x).sections+1; % Number of sections,
        
        if stop_calc == 0
            %    Qf = -3.02 * log((0.74*10^(-6))/(d*sqrt(d*Ie(m,n)))+(k/(3.71*d)))*d^2*sqrt(d*Ie(m,n)); %[m^3/s] palles
            Qf = 72*(d/4)^0.635*pi*(d/2)^2*Ib^0.5;% Hennings
            h_init=0:d/1000:d;
            for t = 1:1001
                Q_initialize(t)=(0.46 - 0.5 *cos(pi*(h_init(t)/d))+0.04*cos(2*pi*(h_init(t)/d)))*Qf;
            end
            data{x}.fitfunc = fit(Q_initialize',h_init','poly9');
            data{x}.fitfunc2 = fit(h_init',Q_initialize','poly9');
            if x == length(piping)
                stop_calc = 1;
            end
            
        end
        
        for n = 1:(sections)
            %%%%%%%%%%%%%%%%%%%%%%%% Initialization %%%%%%%%%%%%%%%%%%%%%%%%%%
            if m == 1 && n==1
 
                if x == 1
                    data{x}.Q(1,1:sections) = input.Q_init(sys_component);
                    data{x}.C(1,1:sections) = input.C_init(sys_component);
                    data{x}.h(1:sections) = data{x}.fitfunc(input.Q_init(sys_component));
                else
                    if piping(x).lat_inflow == 1
                        data{x}.Q(1,1:sections) = data{x-1}.Q(1,end)+input.lat.Q{x-1};
                        data{x}.C(1,1:sections) = (data{x-1}.C(m,end)*data{x-1}.Q(m,end)+input.lat.C{x-1}*input.lat.Q{x-1})/(data{x-1}.Q(m,end)+input.lat.Q{x-1});
                        
                        data{x}.h(1:sections) = data{x}.fitfunc(data{x}.Q(1,end));
                    else
                        data{x}.Q(1,1:sections) = data{x-1}.Q(1,end);
                        data{x}.C(1,1:sections) = data{x-1}.C(1,end);
                        
                        data{x}.h(1:sections) = data{x}.fitfunc(data{x}.Q(1,end));
                    end
                    %                     data{x}.h(1:sections) = data{x}.fitfunc(data{x-1}.Q(1,end));
                end
                data{x}.A(1:sections) = d^2/4 * acos(((d/2)-data{x}.h(n))/(d/2))-sqrt(data{x}.h(n)*(d-data{x}.h(n)))*((d/2)-data{x}.h(n));
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Border conditions %%%%%%%%%%%%%%%%%%%%
            elseif m > 1 && n == 1
                if x == 1
                    data{x}.Q(m,n) = input.Q_init(sys_component);
                    data{x}.C(m,n) = input.C_init(sys_component);
                    data{x}.h(m,n) = data{x}.fitfunc(input.Q_init(sys_component));
                else
                    if piping(x-1).lat_inflow == 1
                        data{x}.Q(m,n) = data{x-1}.Q(m,end)+input.lat.Q{x-1};
                        data{x}.C(m,n) = (data{x-1}.C(m,end)*data{x-1}.Q(m,end)+input.lat.C{x-1}*input.lat.Q{x-1})/(data{x-1}.Q(m,end)+input.lat.Q{x-1});
                    else
                        data{x}.Q(m,n) = data{x-1}.Q(m,end);
                        data{x}.C(m,n) = data{x-1}.C(m,end);
                    end

                    data{x}.h(m,n) = data{x}.fitfunc(data{x}.Q(m,n));
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
                %         C(m,n)= (C(m,n-1)*A(m,n))/(A(m,n)+Q(m,n)*(Dt/Dx))+(Q(m,n)*C(m-1,n))/(A(m,n)*(Dx/Dt)+Q(m,n));
                data{x}.C(m,n)= (data{x}.C(m-1,n)*data{x}.A(m,n))/(data{x}.A(m,n)+data{x}.Q(m,n)*(Dt/Dx))+(data{x}.Q(m,n)*data{x}.C(m,n-1))/(data{x}.A(m,n)*(Dx/Dt)+data{x}.Q(m,n));
                %%%%%%%%%%%%%%%%%%%%%%%
                
            end
        end
    end
    for j = 1:length(piping)
        if piping(j).lat_inflow == 0
            pipe_avg_value{j} =  sum([data{j}.Q(m,:)])/(piping(j).sections+1);
            desired_value{j} = input.Q_init(sys_component);
        else
            pipe_avg_value{j} =  sum([data{j}.Q(m,:)])/(piping(j).sections+1) + input.lat.Q{1,j};
            desired_value{j} = input.Q_init(sys_component) + input.lat.Q{1,j};
        end
    end
    if m > 2
        avg = sum([pipe_avg_value{:}])/j;
        desired = sum([desired_value{:}])/j;
    end
           converging_target = [avg desired]
end

for p = 1:length(piping)
    out_data{p}.Q=data{p}.Q(end,:);
    out_data{p}.A=data{p}.A(end,:);
    out_data{p}.h=data{p}.h(end,:);
    out_data{p}.C=data{p}.C(end,:);
    out_data{p}.Ie(1,1:piping(p).sections+1) = piping(p).Ib;
    out_data{p}.fitfunc = data{p}.fitfunc;
    out_data{p}.fitfunc2 = data{p}.fitfunc2;
end
out = [out_data];

%    init_iterations = m
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

