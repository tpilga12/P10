%%%%%  made with init_verification and pipe_setup_init_fredericia 
%%%%%  
clc
clear all
close all

%data1 = load('error_val_1e-2_fredericia_lut.mat');
data1 = load('error_val_1e-3_fredericia_lut.mat');
data2 = load('error_val_1e-4_fredericia_lut.mat');
data3 = load('error_val_1e-5_fredericia_lut.mat');
data4 = load('error_val_1e-6_fredericia_lut.mat');
data5 = load('error_val_1e-7_fredericia_lut.mat');

% data7 = load('error_val_1e-2_fredericia.mat');
data6 = load('error_val_1e-3_fredericia.mat');
data7 = load('error_val_1e-4_fredericia.mat');
data8 = load('error_val_1e-5_fredericia.mat');
data9 = load('error_val_1e-6_fredericia.mat');
data10 = load('error_val_1e-7_fredericia.mat');



%%%% height plot %%%
lngth = 0;
subtr = 0;
start = 1;
end_value = 0;
for n = 1:length(data1.data)
    subtr =  data1.pipe_spec(n).Dx*start - end_value ;

    lngth = length(data1.data{n}.h) + lngth;
x_axis(start:lngth) = ((start:lngth)*data1.pipe_spec(n).Dx) - subtr;
end_value = x_axis(lngth);
start = lngth+1;
pipe_sep(n,1) = x_axis(start-1);
end

qlim = [0.24 0.275];
hlim = [0.23 0.5];
error_legend = {'error value = 1e-3','error value = 1e-4','error value = 1e-5','error value = 1e-6','error value = 1e-7'};


figure(1)
subplot(2,1,1)
plot(x_axis,fetch_data(data1,'Q'))
hold on
plot(x_axis,fetch_data(data2,'Q'))
hold on
plot(x_axis,fetch_data(data3,'Q'))
hold on
plot(x_axis,fetch_data(data4,'Q'))
hold on
plot(x_axis,fetch_data(data5,'Q'))
hold on
% plot(x_axis,fetch_data(data6,'Q'))
% hold on
    for p = 1:(length(pipe_sep)-1)
        plot([pipe_sep(p,1) pipe_sep(p,1)], qlim, ':r');
    end  
 ylim(qlim)
 xlim([0 inf])
 title('Lookup table')
 xlabel('Distance [m]')
 ylabel('Flow [m^3/s]')
legend(error_legend,'Location','northwest') 

subplot(2,1,2)
plot(x_axis,fetch_data(data6,'Q'))
hold on
plot(x_axis,fetch_data(data7,'Q'))
hold on
plot(x_axis,fetch_data(data8,'Q'))
hold on
plot(x_axis,fetch_data(data9,'Q'))
hold on
plot(x_axis,fetch_data(data10,'Q'))
hold on
% plot(x_axis,fetch_data(data12,'Q'))
% hold on
    for p = 1:(length(pipe_sep)-1)
        plot([pipe_sep(p,1) pipe_sep(p,1)], qlim, ':r');
    end  
 ylim(qlim)
 xlim([0 inf])
  title('Curve fitted polynomial')
 xlabel('Distance [m]')
 ylabel('Flow [m^3/s]')
legend(error_legend,'Location','northwest') 
 
 


%% figure 1 zoom height

figure(111)
plot(x_axis,fetch_data(data1,'h'))
% hold on
% plot(x_axis,fetch_data(data2,'h'))
% hold on
% plot(x_axis,fetch_data(data3,'h'))
hold on
plot(x_axis,fetch_data(data4,'h'))
hold on
    for p = 1:(length(pipe_sep)-1)
        plot([pipe_sep(p,1) pipe_sep(p,1)], hlim, ':r');
    end  
 ylim([0.3 0.38])
 xlim([2950 3950])
 title('Curvefit')
  xlabel('Distance [m]')
  ylabel('Height [m]')
 legend(curve_legend{1,1}, curve_legend{1,end})
