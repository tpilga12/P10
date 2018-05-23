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
end_value = 0;

for n = 1:length(data1.data)
if n >= 1
    subtr =  data1.pipe_spec(n).Dx*start - end_value ;
end
    lngth = length(data1.data{n}.h) + lngth;
x_axis(start:lngth) = ((start:lngth)*data1.pipe_spec(n).Dx) - subtr;
end_value = x_axis(lngth);
start = lngth+1;
pipe_sep(n,1) = x_axis(start-1);
end

qlim = [0.23 0.3];
hlim = [0.345 0.36];

figure(1)
subplot(2,1,1)
plot(x_axis,[data1.data{1}.h data1.data{2}.h])
hold on
plot(x_axis,[data2.data{1}.h data2.data{2}.h])
hold on
plot(x_axis,[data3.data{1}.h data3.data{2}.h])
hold on
plot(x_axis,[data4.data{1}.h data4.data{2}.h])
hold on
    for p = 1:(length(pipe_sep)-1)
        plot([pipe_sep(p,1) pipe_sep(p,1)], hlim, ':r');
    end  
 ylim(hlim)
 title('Curvefit')
  xlabel('Distance [m]')
  ylabel('Height [m]')
legend('Boundary','Iterration 1','Iteration 10','Iteration 22')

subplot(2,1,2)
% figure(2)
plot(x_axis,[data1.data{1}.Q data1.data{2}.Q])
hold on
plot(x_axis,[data2.data{1}.Q data2.data{2}.Q])
hold on
plot(x_axis,[data3.data{1}.Q data3.data{2}.Q])
hold on
plot(x_axis,[data4.data{1}.Q data4.data{2}.Q])
hold on
    for p = 1:(length(pipe_sep)-1)
        plot([pipe_sep(p,1) pipe_sep(p,1)], qlim, ':r');
    end  
 ylim(qlim)
%  title('Curvefit')
  xlabel('Distance [m]')
  ylabel('Flow [m^3/s]')
legend('Boundary','Iterration 1','Iteration 10','Iteration 22')



figure(11)
subplot(2,1,1)
plot(x_axis,[data5.data{1}.h data5.data{2}.h])
hold on
plot(x_axis,[data6.data{1}.h data6.data{2}.h])
hold on
plot(x_axis,[data7.data{1}.h data7.data{2}.h])
hold on
plot(x_axis,[data8.data{1}.h data8.data{2}.h])
hold on
    for p = 1:(length(pipe_sep)-1)
        plot([pipe_sep(p,1) pipe_sep(p,1)], hlim, ':r');
    end  
 ylim(hlim)
 title('Lookup table')
  xlabel('Distance [m]')
  ylabel('Height [m]')
legend('Boundary','Iterration 1','Iteration 10','Iteration 18')

% figure(21)
subplot(2,1,2)
plot(x_axis,[data5.data{1}.Q data5.data{2}.Q])
hold on
plot(x_axis,[data6.data{1}.Q data6.data{2}.Q])
hold on
plot(x_axis,[data7.data{1}.Q data7.data{2}.Q])
hold on
plot(x_axis,[data8.data{1}.Q data8.data{2}.Q])
hold on
    for p = 1:(length(pipe_sep)-1)
        plot([pipe_sep(p,1) pipe_sep(p,1)], qlim, ':r');
    end  
 ylim(qlim)
%  title('Lookup table')
  xlabel('Distance [m]')
  ylabel('Flow [m^3/s]')
legend('Boundary','Iterration 1','Iteration 10','Iteration 18')

figure(3)
plot(data8.data{1}.fitfunc)
hold on
plot(data8.data{1}.lut.Q,data8.data{1}.lut.h)
xlim([-0.05 1])
ylim([-0.05 0.95])
grid
legend('Curve fit','Raw data','Location','northwest')

