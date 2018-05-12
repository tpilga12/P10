function [data] = tank(m, data, tank_nr, x, input, tank_spec, init)
%TANK Summary of this function goes here
%   Detailed explanation goes here
global Dt
 
if init == 1
    data.Q(init,1) = input.Q_init(x); % input flow
    data.Q(init,2) = input.u_init(tank_nr)*tank_spec(tank_nr).Q_out_max; % output flow
    data.h(init,1) = input.tank_height_init(tank_nr);
    data.C(init,1) = input.C_init(x); % concentrate in tank

else
    data.Q(m,1) = input.Q_in(m,x);
    data.Q(m,2) = input.u(m,tank_nr)*tank_spec(tank_nr).Q_out_max;
    data.h(m,1) = (1/tank_spec(tank_nr).area)*(data.Q(m,1)-data.Q(m,2))*Dt + data.h(m-1,1);
    data.C(m,1) = input.C_in(m,x);
    if data.h(m,1) <= 0
        data.h(m,1) = 0;
        if data.Q(m,1) <= 0
            data.Q(m,2) = 0;
        elseif data.Q(m,1) < data.Q(m,2)
            data.Q(m,2) = data.Q(m,1);
        else
            data.Q(m,2) = input.u(m,tank_nr)*tank_spec(tank_nr).Q_out_max;
        end
    elseif data.h(m,1) > tank_spec(tank_nr).height
        data.h(m,1) = tank_spec(tank_nr).height;
        fprintf(' Height is above limit in tank at iteration %d\n',m)
    end
end

end

