clc
clear all
close all

data1 = load('init_setup_verification_boundary.mat');
data2 = load('init_setup_verification_1_iteration.mat');
data3 = load('init_setup_verification_10_iteration.mat');

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
xlim(hlim)
hold on
plot(x_axis,[data2.data{1}.h data2.data{2}.h])
xlim(hlim)
hold on
plot(x_axis,[data3.data{1}.h data3.data{2}.h])
xlim(hlim)
legend('Boundary','Iterration 1','Itteration 10')

qlim = [0.2 0.4];
figure(2)
plot(x_axis,[data1.data{1}.Q data1.data{2}.Q])
hold on
plot(x_axis,[data2.data{1}.Q data2.data{2}.Q])
hold on
plot(x_axis,[data3.data{1}.Q data3.data{2}.Q])
%xlim(qlim)
legend('Boundary','Iterration 1','Itteration 10')



