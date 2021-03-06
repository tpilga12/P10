function [out]=init_pipe(piping,input, sys_component, pipe_nr, accuracy)
%Pipe(bed slope(Sb),        Ruhedsfaktor(k),
%Delta t(Dt),               Delta x(Dx),
%Diameter(d),               Pipe sections(sections),
%Current time iteration(m), Initial flow (Q_init),
%Input flow (Q_in),         Initial concentrate(C_init),
%Input concentrate(C_in),   finite scheme konstant(Theta))
%length of pipe is Dx*n

% persistent H Q h A C Sf
global Dt
m = 0;
limit = accuracy;
limitvalue = 1e-7; %newton stop iteration value

avg = 10;
desired = 0;
g = 9.81; %[m/s^2] gravitational constant
stop_init_calc = 0;
fit_steps = 10000;
% while m < 2
while abs(avg-desired) > limit
    m = m + 1;
    for x = 1:length(piping)
        
        Sb = piping(x).Sb;
        d = piping(x).d; %[m] Diameter
        Theta = piping(x).Theta;
        Dx = piping(x).Dx; %[m] grid distance
        sections = piping(x).sections+1; % Number of sections,
        
        if stop_init_calc == 0
            %    Qf = -3.02 * log((0.74*10^(-6))/(d*sqrt(d*Sf(m,n)))+(k/(3.71*d)))*d^2*sqrt(d*Sf(m,n)); %[m^3/s] palles
            Qf = 72*(d/4)^0.635*pi*(d/2)^2*Sb^0.5;% Hennings
            h_init=0:d/fit_steps:d;
            for t = 1:fit_steps+1
                Q_initialize(t)=(0.46 - 0.5 *cos(pi*(h_init(t)/d))+0.04*cos(2*pi*(h_init(t)/d)))*Qf;
            end
            data{x}.lut.Q = Q_initialize';
            data{x}.lut.h = h_init';
            data{x}.lut.limit = Qf;
           
            data{x}.fitfunc = fit(Q_initialize',h_init','poly9');
%             data{x}.fitfunc = fit(Q_initialize',h_init','smoothingspline');
            
            data{x}.fitfunc2 = fit(h_init',Q_initialize','poly9');
            if x == length(piping)
                stop_init_calc = 1;
            end
        end
        
        for n = 1:(sections)
            %%%%%%%%%%%%%%%%%%%%%%%% Initialization %%%%%%%%%%%%%%%%%%%%%%%%%%
            if m == 1 && n==1
 
                if x == 1
                    data{x}.Q(1,1:sections) = input.Q_init(sys_component);
                    data{x}.C(1,1:sections) = input.C_init(sys_component);
%                     data{x}.h(1:sections) = data{x}.fitfunc(input.Q_init(sys_component));
                    data{x}.h(1:sections) = lut_func(input.Q_init(sys_component),data{x}.lut);
                else
                    if piping(x).side_inflow == 1
                        data{x}.Q(1,1:sections) = data{x-1}.Q(1,end)+input.side.Q{x+pipe_nr};
                        data{x}.C(1,1:sections) = (data{x-1}.C(m,end)*data{x-1}.Q(m,end)+input.side.C{x-1}*input.side.Q{x-1})/(data{x-1}.Q(m,end)+input.side.Q{x-1});
                    else
                        data{x}.Q(1,1:sections) = data{x-1}.Q(1,end);
                        data{x}.C(1,1:sections) = data{x-1}.C(1,end);
                    end
%                      data{x}.h(1:sections) = data{x}.fitfunc(data{x-1}.Q(1,end));
                     data{x}.h(1:sections) = lut_func(data{x}.Q(1,end),data{x}.lut);
                end
               
                data{x}.A(1:sections) = d^2/4 * acos(((d/2)-data{x}.h(n))/(d/2))-sqrt(data{x}.h(n)*(d-data{x}.h(n)))*((d/2)-data{x}.h(n));
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Border conditions %%%%%%%%%%%%%%%%%%%%
            elseif m > 1 && n == 1
                if x == 1
                    data{x}.Q(m,n) = input.Q_init(sys_component);
                    data{x}.C(m,n) = input.C_init(sys_component);
%                     data{x}.h(m,n) = data{x}.fitfunc(input.Q_init(sys_component));
                    data{x}.h(m,n) = lut_func(input.Q_init(sys_component), data{x}.lut);
                else
                    if piping(x).side_inflow == 1
                        data{x}.Q(m,n) = data{x-1}.Q(m,end)+input.side.Q{x+pipe_nr};
                        data{x}.C(m,n) = (data{x-1}.C(m,end)*data{x-1}.Q(m,end)+input.side.C{x-1}*input.side.Q{x-1})/(data{x-1}.Q(m,end)+input.side.Q{x-1});
                    else
                        data{x}.Q(m,n) = data{x-1}.Q(m,end);
                        data{x}.C(m,n) = data{x-1}.C(m,end);
                    end

%                     data{x}.h(m,n) = data{x}.fitfunc(data{x}.Q(m,n));
                    data{x}.h(m,n) = lut_func(data{x}.Q(m,n), data{x}.lut);
                end
                data{x}.A(m,n) = d^2/4 * acos(((d/2)-data{x}.h(m,n))/(d/2))-sqrt(data{x}.h(m,n)*(d-data{x}.h(m,n)))*((d/2)-data{x}.h(m,n));
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Iteration %%%%%%%%%%%%%%%%%%%%%%%%%%%
            elseif m > 1 && n > 1
                H = (2*(1-Theta)*data{x}.Q(m-1,n-1)-2*(1-Theta)*data{x}.Q(m-1,n)+ ...
                    2*Theta*data{x}.Q(m,n-1))*Dt/Dx - ...
                    data{x}.A(m,n-1)+ data{x}.A(m-1,n-1)+ data{x}.A(m-1,n);
                data{x}.h(m,n)=NewtonRoot(@V,@V_dot,data{x}.h(m-1,n-1),limitvalue,100,d,Sb,H,Dt,Dx,Theta,m,n);
                data{x}.A(m,n) = d^2/4 * acos(((d/2)- data{x}.h(m,n))/(d/2))-sqrt(data{x}.h(m,n)*(d-data{x}.h(m,n)))*((d/2)-data{x}.h(m,n));
                data{x}.Q(m,n) = (-1/(Theta*2))*(data{x}.A(m,n)-H)*Dx/Dt;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CONCENTRATE %%%%%%%%%%%%%%%%%%%%%%%%%
                %         C(m,n)= (C(m,n-1)*A(m,n))/(A(m,n)+Q(m,n)*(Dt/Dx))+(Q(m,n)*C(m-1,n))/(A(m,n)*(Dx/Dt)+Q(m,n));
                data{x}.C(m,n)= (data{x}.C(m-1,n)*data{x}.A(m,n))/(data{x}.A(m,n)+data{x}.Q(m,n)*(Dt/Dx))+(data{x}.Q(m,n)*data{x}.C(m,n-1))/(data{x}.A(m,n)*(Dx/Dt)+data{x}.Q(m,n));
                %%%%%%%%%%%%%%%%%%%%%%%
                
            end
        end
    end
    side_add = 0;
    for j = 1:length(piping)
        if piping(j).side_inflow == 0
            pipe_avg_value{j} =  sum([data{j}.Q(m,:)])/(piping(j).sections+1);
            desired_value{j} = input.Q_init(sys_component) + side_add;
        else
            side_add = side_add + input.side.Q{1,j+pipe_nr}; 
            pipe_avg_value{j} =  sum([data{j}.Q(m,:)])/(piping(j).sections+1);
            desired_value{j} = input.Q_init(sys_component) + side_add;
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
    out_data{p}.Sf(1,1:piping(p).sections+1) = piping(p).Sb;
    out_data{p}.fitfunc = data{p}.fitfunc;
    out_data{p}.fitfunc2 = data{p}.fitfunc2;
    out_data{p}.lut=data{p}.lut(end,:);
end
out = [out_data];

    init_iterations = m
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%% Functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function f1=V(h)%V
    f1 = -72*(d/4)^0.635 * pi*(d/2)^2*Sb^0.5*(0.46-0.5*cos(pi*(h/d))+ ...
        0.04*cos(2*pi*(h/d)))*(Dt/Dx)-(1/(2*Theta))*(d^2/4 * acos(((d/2)-h)/(d/2))- ...
        sqrt(h*(d-h))*((d/2)-h)-H);
    end
    
    function f2=V_dot(h)%Vdot
    f2 = -72*(d/4)^0.635 * pi*(d/2)^2*Sb^0.5*(0.5*pi*sin(pi*(h/d))- ...
        0.08*pi*sin(2*pi*(h/d)))*Dt/Dx-(d/Theta)*sqrt(-h^2+(d*h));
    end

    
end

