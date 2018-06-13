function [C_r sugest_Dt] = courant(data, pipe_spec, Dt, row, desired_Cr)

g = 9.81;
for m = 1:length(pipe_spec)

d = pipe_spec(m).d;
%h = sum(data{pipe_spec(m).data_location}.h(row,:)) / length(data{pipe_spec(m).data_location}.h(1,:));
h = mean(data{pipe_spec(m).data_location}.h(row,:));
% h = (data{pipe_spec(m).data_location}.h(end,1)+data{pipe_spec(m).data_location}.h(1,1))/2;
R=hy_perimeter(h,d);
ie = pipe_spec(m).Sb;
n = 0.013;

C_r(m) = sqrt(g*h)*Dt/pipe_spec(m).Dx;
sugest_Dt(m,1) = pipe_spec(m).Dx*desired_Cr/sqrt(g*h);
end


function f = Area_fun(h)
    f = d^2/4 * acos(((d/2)-h)/(d/2))-sqrt(h*(d-h))*((d/2)-h);
end


function f=hy_perimeter(h,d)
    f = acos(1-(h/(d/2)))*d;
end

end