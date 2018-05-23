%%%%%  made with init_setup_verification without tank 
clc
clear all
close all

data1 = load('init_fredericia_boundary.mat');
data2 = load('init_fredericia_iteration_1.mat');
data3 = load('init_fredericia_iteration_10.mat');
data4 = load('init_fredericia_iteration_229.mat');

data5 = load('init_fredericia_boundary_lut.mat');
data6 = load('init_fredericia_iteration_1_lut.mat');
data7 = load('init_fredericia_iteration_10_lut.mat');
data8 = load('init_fredericia_iteration_212_lut.mat');

%%%% height plot %%%
lngth = 0;
subtr = 0;
start = 1;
end_value = 0;
for n = 1:length(data1.data)
if n >= 1
    %subtr = data1.pipe_spec(n).Dx ;
    subtr =  data1.pipe_spec(n).Dx*start - end_value ;
end
    lngth = length(data1.data{n}.h) + lngth;
x_axis(start:lngth) = ((start:lngth)*data1.pipe_spec(n).Dx) - subtr
end_value = x_axis(lngth);
start = lngth+1;

end

hlim = [0.34 0.36]
figure(1)
plot(x_axis,fetch_data(data1,'h'))
hold on
plot(x_axis,fetch_data(data2,'h'))
hold on
plot(x_axis,fetch_data(data3,'h'))
hold on
plot(x_axis,fetch_data(data4,'h'))
% ylim(hlim)
legend('Boundary','Iterration 1','Iteration 10','Iteration 229')
%hold on
figure(11)
plot(x_axis,fetch_data(data5,'h'))
hold on
plot(x_axis,fetch_data(data6,'h'))
hold on
plot(x_axis,fetch_data(data7,'h'))
hold on
plot(x_axis,fetch_data(data8,'h'))
% ylim(hlim)
legend('Boundary_{lut}','Iterration_{lut} 1','Iteration_{lut} 10','Iteration_{lut} 212')

qlim = [0.2 0.3];
figure(2)
plot(x_axis,fetch_data(data1,'Q'))
hold on
plot(x_axis,fetch_data(data2,'Q'))
hold on
plot(x_axis,fetch_data(data3,'Q'))
hold on
plot(x_axis,fetch_data(data4,'Q'))
% ylim(qlim)
legend('Boundary','Iterration 1','Iteration 10','Iteration 229')
% hold on
figure(21)
plot(x_axis,fetch_data(data5,'Q'))
hold on
plot(x_axis,fetch_data(data6,'Q'))
hold on
plot(x_axis,fetch_data(data7,'Q'))
hold on
plot(x_axis,fetch_data(data8,'Q'))
% ylim(qlim)
legend('Boundary_{lut}','Iterration_{lut} 1','Iteration_{lut} 10','Iteration_{lut} 212')


