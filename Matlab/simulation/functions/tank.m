asdfunction [data input] = tank(m, data, tank_nr, x, input, tank_spec, init)
%TANK Summary of this function goes here
%   Detailed explanation goes here
global Dt
 
if init == 1
    data.Q(init,1) = input.Q_init(x); % input flow
    input.u_init(init,tank_nr) = data.Q(init,1)/tank_spec(tank_nr).Q_out_max; % 
    data.Q(init,2) = input.u_init(tank_nr)*tank_spec(tank_nr).Q_out_max; % output flow
    data.h(init,1) = input.tank_height_init(tank_nr); 
    data.C(init,1) = input.C_init(x); % concentrate in tank

else
    data.Q(m,1) = input.Q_in(m,x);
    data.Q(m,2) = input.u(m,tank_nr)*tank_spec(tank_nr).Q_out_max;
    data.h(m,1) = (1/tank_spec(tank_nr).area)*(data.Q(m,1)-data.Q(m,2))*Dt + data.h(m-1,1);
     
    data.C(m,2) = input.C_in(m,x);
    test_val = 1;
    if data.h(m,1) < 0
%     if abs(data.C(m-1,1) - input.C_in(m,x)) < 0.1    

        data.C(m,1) = input.C_in(m,x);
    else
    data.C(m,1) = input.C_in(m,x) *  ((data.Q(m,1)*Dt / tank_spec(tank_nr).area))/(test_val*data.h(m,1)) + data.C(m-1,1) * (1 - ((data.Q(m,1)*Dt / tank_spec(tank_nr).area))/(test_val*data.h(m,1)));
    data.C(m,1) = data.C(m,1)*test_val;
    end
    
    if data.h(m,1) <= 0
        data.h(m,1) = 0;
        if data.Q(m,1) <= 0
            data.Q(m,2) = 0
        elseif data.Q(m,1) < data.Q(m,2)
            data.Q(m,2) = data.Q(m,1);
        end
    elseif data.h(m,1) > tank_spec(tank_nr).height % warn about overflow at iteration m
       % data.h(m,1) = tank_spec(tank_nr).height;
        fprintf(' Height is above limit in tank %d at iteration %d\n',tank_nr,m)
  
    end
end

end

