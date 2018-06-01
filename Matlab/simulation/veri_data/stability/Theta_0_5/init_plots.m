%%%%%  made with init_verification and pipe_setup_init_fredericia 
%%%%%  
clc
clear all
close all

data1 = load('035_1_Cr_0_5_1200mm_pipe.mat');
data2 = load('035_1_Cr_1_1200mm_pipe.mat');
data3 = load('035_1_Cr_1_0472_1200mm_pipe.mat');
data4 = load('035_1_Cr_1_5_1200mm_pipe.mat');
data5 = load('035_1_Cr_2_1200mm_pipe.mat');
Dt_times = [data1.Dt data2.Dt data3.Dt data4.Dt data5.Dt];
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

legend1 = {strcat('C_r = 0.5, \Delta t =', num2str( Dt_times(1))), strcat('C_r = 1, \Delta t =', num2str( Dt_times(2))), strcat('C_r = 1.0472, \Delta t =', num2str( Dt_times(3))), strcat('C_r = 1.5, \Delta t =', num2str( Dt_times(4))), strcat('C_r = 2, \Delta t =', num2str( Dt_times(5)))};
xlimit = [0 500];
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
hold on
plot(x_axis+displace(4),fetch_data(data4,'h',row(4)))
hold on
plot(x_axis+displace(5),fetch_data(data5,'h',row(5)))
legend(legend1)
  xlabel('Distance [m]')
  ylabel('Height [m]')
xlim(xlimit)
  grid on

