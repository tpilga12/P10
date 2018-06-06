%%%%%  made with init_verification and pipe_setup_init_fredericia 
%%%%%  
clc
clear all
close all

data1 = load('035_1_theta_0_5_1200mm_pipe.mat');
data2 = load('035_1_theta_0_65_1200mm_pipe.mat');
data3 = load('035_1_theta_1_00_1200mm_pipe.mat');
Dt_times = [data1.Dt data2.Dt data3.Dt];
%%%% height plot %%%
lngth = 0;
subtr = 0;
start = 1;
end_value = 0;
for n = 1:length(data1.data)
    subtr =  data1.pipe_spec(n).Dx*start - end_value ;

    lngth = length(data1.data{n}.h(1,:)) + lngth;
x_axis(start:lngth) = ((start:lngth)*data1.pipe_spec(n).Dx) - subtr;
end_value = x_axis(lngth);
start = lngth+1;
pipe_sep(n,1) = x_axis(start-1);
end

legend1 = {'Theta = 0.5','Theta = 0.65', 'Theta = 1'};
xlimit = [0 500];
ylimit = [0.35 0.67];
v = 6.623374937323395;
plot_time = 100; 
row = round(plot_time./Dt_times);
%displace = rem(plot_time./Dt_times,1).*Dt_times;
 displace(1:5) = 0;

%%
figure(1)
plot(x_axis+displace(1),fetch_data(data1,'h',row(1)))
hold on
plot(x_axis+displace(2),fetch_data(data2,'h',row(2)))
hold on
plot(x_axis+displace(3),fetch_data(data3,'h',row(3)))

legend(legend1)
  xlabel('Distance [m]')
  ylabel('Height [m]')
xlim(xlimit)
ylim(ylimit)
  grid on

