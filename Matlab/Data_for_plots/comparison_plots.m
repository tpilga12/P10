%% Script for comparison of nonlinear open channel and ss open channel 
% clc, clear all,
close all
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
% Linearzied model
sample= lin_sys.Ts;
h_data_hat=data{1,1}.h(:,1)-data{1,1}.h(1,1);


t = (sample:sample:length(h_data_hat)*sample)-sample;

h_input(1:length(t))=0;%h_data_hat ;%Input height
h2_input(1:length(t))=0.3;
h3_input(1:length(t))=0.3;
 %%h_input2(1:length(t)) = 0; % Input height, test for at s?tte a = 0

u=[h_input; utank1-utank1(1,1) ; h_input]';

[Y_hat t1 x1]=lsim(lin_sys,u);
Y_hat = x1(:,226);
figure(2)
plot(t,Y_hat)

h_bar = data{1,1}.h(1,1); % S?t sm? signaler
Y_bar =data{1,end}.h(1,end);
Y_lsim = Y_bar + Y_hat;



figure(1000)
plot(t,data{1,1}.h(:,1))
title('Input height')
xlabel('Time [s]')
ylabel('Input height [m]')
% xlim([0 900])
grid

figure(2000)
plot(t/60,Y_hat+Y_bar)
hold on
plot(t/60,data{1,end}.h(:,end))
title('Comparison of Non-linear and linear open channel models')
xlabel('Time [s]')
ylabel('Output height [m]')
% xlim([0 900])
legend('Linear','Non-linear')
grid

figure(22)
plot(data{1,2}.h(:,1))
hold on
plot(x1(2:end,2)+data{1,2}.h(1,1))
legend('Non-Linear','linear')




