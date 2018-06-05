%%%%%  made with init_setup_verification without tank 
clc
clear all
close all

data1 = load('init_setup_verification_boundary.mat');
data2 = load('init_setup_verification_1_iteration.mat');
data3 = load('init_setup_verification_10_iteration.mat');
data4 = load('init_setup_verification_22_iteration.mat');

data5 = load('init_setup_verification_boundary_lut.mat');
data6 = load('init_setup_verification_1_iteration_lut.mat');
data7 = load('init_setup_verification_10_iteration_lut.mat');
data8 = load('init_setup_verification_18_iteration_lut.mat');

%%%% height plot %%%
lngth = 0;
subtr = 0;
start = 1;
for n = 1:length(data1.data)
    lngth = length(data1.data{n}.h) + lngth;
x_axis(start:lngth) = ((start:lngth)*data1.pipe_spec(n).Dx)-data1.pipe_spec(n).Dx-subtr
start = lngth+1
subtr = data1.pipe_spec(n).Dx ;
end

hlim = [0.34 0.36]
figure(1)
plot(x_axis,[data1.data{1}.h data1.data{2}.h])
hold on
plot(x_axis,[data2.data{1}.h data2.data{2}.h])
hold on
plot(x_axis,[data3.data{1}.h data3.data{2}.h])
hold on
plot(x_axis,[data4.data{1}.h data4.data{2}.h])
ylim(hlim)
legend('Boundary','Iterration 1','Iteration 10','Iteration 22')
%hold on
figure(11)
plot(x_axis,[data5.data{1}.h data5.data{2}.h])
hold on
plot(x_axis,[data6.data{1}.h data6.data{2}.h])
hold on
plot(x_axis,[data7.data{1}.h data7.data{2}.h])
hold on
plot(x_axis,[data8.data{1}.h data8.data{2}.h])
ylim(hlim)
legend('Boundary_{lut}','Iterration_{lut} 1','Iteration_{lut} 10','Iteration_{lut} 18')

qlim = [0.2 0.3];
figure(2)
plot(x_axis,[data1.data{1}.Q data1.data{2}.Q])
hold on
plot(x_axis,[data2.data{1}.Q data2.data{2}.Q])
hold on
plot(x_axis,[data3.data{1}.Q data3.data{2}.Q])
hold on
plot(x_axis,[data4.data{1}.Q data4.data{2}.Q])
ylim(qlim)
legend('Boundary','Iterration 1','Iteration 10','Iteration 22')
% hold on
figure(21)
plot(x_axis,[data5.data{1}.Q data5.data{2}.Q])
hold on
plot(x_axis,[data6.data{1}.Q data6.data{2}.Q])
hold on
plot(x_axis,[data7.data{1}.Q data7.data{2}.Q])
hold on
plot(x_axis,[data8.data{1}.Q data8.data{2}.Q])
ylim(qlim)
legend('Boundary_{lut}','Iterration_{lut} 1','Iteration_{lut} 10','Iteration_{lut} 18')


