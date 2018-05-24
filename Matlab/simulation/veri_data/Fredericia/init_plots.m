%%%%%  made with init_verification and pipe_setup_init_fredericia 
%%%%%  
clc
clear all
close all

data1 = load('init_fredericia_boundary.mat');
data2 = load('init_fredericia_iteration_1.mat');
data3 = load('init_fredericia_iteration_10.mat');
data4 = load('init_fredericia_iteration_206.mat');

data5 = load('init_fredericia_boundary_lut.mat');
data6 = load('init_fredericia_iteration_1_lut.mat');
data7 = load('init_fredericia_iteration_10_lut.mat');
data8 = load('init_fredericia_iteration_189_lut.mat');

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

qlim = [0.24 0.27];
hlim = [0.24 0.5];
lut_legend = {'Boundary','Iterration 1','Iteration 10','Iteration 189'};
curve_legend = {'Boundary','Iterration 1','Iteration 10','Iteration 206'};

figure(1)
subplot(2,1,1)
plot(x_axis,fetch_data(data1,'h'))
hold on
plot(x_axis,fetch_data(data2,'h'))
hold on
plot(x_axis,fetch_data(data3,'h'))
hold on
plot(x_axis,fetch_data(data4,'h'))
hold on
    for p = 1:(length(pipe_sep)-1)
        plot([pipe_sep(p,1) pipe_sep(p,1)], hlim, ':r');
    end  
 ylim(hlim)
 xlim([0 inf])
 title('Curvefit')
  xlabel('Distance [m]')
  ylabel('Height [m]')
 legend(curve_legend)

% figure(2)
subplot(2,1,2)
plot(x_axis,fetch_data(data1,'Q'))
hold on
plot(x_axis,fetch_data(data2,'Q'))
hold on
plot(x_axis,fetch_data(data3,'Q'))
hold on
plot(x_axis,fetch_data(data4,'Q'))
hold on
    for p = 1:(length(pipe_sep)-1)
        plot([pipe_sep(p,1) pipe_sep(p,1)], qlim, ':r');
    end  
 ylim(qlim)
 xlim([0 inf])
%  title('Curvefit')
 xlabel('Distance [m]')
 ylabel('Flow [m^3/s]')
legend(curve_legend) 
 
figure(11)
subplot(2,1,1)
plot(x_axis,fetch_data(data5,'h'))
hold on
plot(x_axis,fetch_data(data6,'h'))
hold on
plot(x_axis,fetch_data(data7,'h'))
hold on
plot(x_axis,fetch_data(data8,'h'))
hold on
    for p = 1:(length(pipe_sep)-1)
        plot([pipe_sep(p,1) pipe_sep(p,1)], hlim, ':r');
    end  
 ylim(hlim)
 xlim([0 inf])
 title('Lookup table')
  xlabel('Distance [m]')
  ylabel('Height [m]')
legend(lut_legend)

% figure(21)
subplot(2,1,2)
plot(x_axis,fetch_data(data5,'Q'))
hold on
plot(x_axis,fetch_data(data6,'Q'))
hold on
plot(x_axis,fetch_data(data7,'Q'))
hold on
plot(x_axis,fetch_data(data8,'Q'))
hold on
    for p = 1:(length(pipe_sep)-1)
        plot([pipe_sep(p,1) pipe_sep(p,1)], qlim, ':r');
    end  
 ylim(qlim)
 xlim([0 inf])
%  title('Lookup table')
  xlabel('Distance [m]')
  ylabel('Flow [m^3/s]')
legend(lut_legend)


