function [data] = tank(m, data, tank_nr, Q_in, C_in, input, tank_spec, init)
%TANK Summary of this function goes here
%   Detailed explanation goes here
global Dt

if init == 1
    data.Q(init,1) = Q_in;
    data.Q(init,2) = input.u_init(tank_nr)*tank_spec(tank_nr).Q_out_max;
    data.h(init,1) = input.tank_height_init(tank_nr);
    data.C(init,1) = C_in;
else
    data.Q(m,1) = Q_in;
    data.Q(m,2) = input.u(tank_nr)*tank_spec(tank_nr).Q_out_max;
    data.h(m,1) = (1/tank_spec(tank_nr).area)*(data.Q(m,1)-data.Q(m,2))*Dt + data.h(m-1,1);
    data.C(m,1) = C_in;
    if data.h(m,1) <= 0
        data.h(m,1) = 0;
        if data.Q(m,1) <= 0
            data.Q(m,2) = 0;
        elseif data.Q(m,1) < data.Q(m,2)
            data.Q(m,2) = data.Q(m,1);
        else
            data.Q(m,2) = input.u(tank_nr)*tank_spec(tank_nr).Q_out_max;
        end
    elseif data.h(m,1) > tank_spec(tank_nr).height
        data.h(m,1) = tank_spec(tank_nr).height;
        fprintf(' Height is above limit in tank %d\n',m)
    end
end














end

