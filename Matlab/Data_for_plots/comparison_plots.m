%% Script for comparison of nonlinear open channel and ss open channel 
% clc, clear all,
%close all
% 
% % Load data from main test - Run main test, save the following dataset
% % data{1,1}.h(:,end), and data{1,1}.h(:,1) which is the output height and
% % input height. From Opskrevet_paa_normal_form, save Y output data and the
% % time vector t. 
% 
% load h_data.mat
% load h_start_tank.mat
% load output_fra_ss.mat
% load time.mat
% load tank_height_for_ss_model.mat

figure(1000)
plot(t,data{1,1}.h(:,1))
title('Input height')
xlabel('Time [s]')
ylabel('Input height [m]')
xlim([0 4000])
grid

figure(2000)
plot(t,Y_hat+Y_bar)
hold on
plot(t,data{1,1}.h(:,end))
title('Comparison of Non-linear and linear open channel models')
xlabel('Time [s]')
ylabel('Output height [m]')
xlim([0 4000])
legend('Linear','Non-linear')
grid