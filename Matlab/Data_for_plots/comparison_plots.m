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

h_i(1:length(t))=0;%h_data_hat ;%Input height
h2_input(1:length(t))=0.3;
h3_input(1:length(t))=0.3;


tank_in = (input.u(1:end,1)-input.u(1,1))';
% tank_in = (input.u(1:end,1))';
%u=[(data{1}.h(:,end)-data{1}.h(1,end))'; (input.u(1:end,1))' ; h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input]';
u=[h_data_hat'; tank_in ; h_i; h_i; h_i; h_i; h_i; h_i; h_i; h_i; h_i; h_i]';

 %%h_input2(1:length(t)) = 0; % Input height, test for at s?tte a = 0

%u = [ u(17:end,:) ; u(end-15:end,:)];
% u = [h_data_hat'; h_input];
x0(1:length(lin_sys.A)) = 0;
% x0(36)=1;
[Y_hat t1 x1]=lsim(lin_sys,u,t,x0);

%
%  Y_hat = x1(:,226);
% figure(2)
% plot(t./60,Y_hat(:,2))

h_bar = data{1,1}.h(1,1); % S?t sm? signaler
Y_bar =data{1,end}.h(1,end);
Y_lsim = Y_bar + Y_hat;
%%
figure(1111)
plot(data{1}.h(1:end,end))
hold on
plot(x1(2:end,35)+data{1}.h(1,end))
legend('non-linear','linear')
title('Input height')
xlabel('Time [s]')
ylabel('Tank height [m]')
% xlim([0 900])
grid
%%
figure(1000)
plot(t,data{1,1}.Q(:,1))
title('Input height')
xlabel('Time [s]')
ylabel('Input height [m]')
% xlim([0 900])
grid

figure(2000)
plot(t/60,x1(:,261)+Y_bar)
hold on
plot(t/60,data{1,end}.h(:,end))
title('Comparison of Non-linear and linear open channel models')
xlabel('Time [s]')
ylabel('Output height [m]')
% xlim([0 900])
legend('Linear','Non-linear')
grid

figure(22)
plot(data{1,3}.h(2:end,1))
hold on
plot(x1(1:end,plot_piece-1)+data{1,2}.h(1,plot_piece-1))

legend('Non-Linear','linear')
%%
figure(23)

plot_piece = 1;
plot(data{1,1}.h(:,plot_piece))

hold on
plot(x1(2:end,plot_piece)+data{1,1}.h(1,plot_piece))
legend('Non-Linear','linear')
%%
figure(33)
prev_data = 17;
prev_sim = 225-30-15-4-6-1-12-5-15-40-7-30-2-5-15-14-8-1-(10);
plot(t/60,data{1,end-prev_data}.h(:,5))
hold on
plot(t/60,x1(:,prev_sim)+data{1,end-prev_data}.h(1,5))
grid minor
legend('non-lin','lin')
%%
figure(33)
prev_data = 12;
% prev_sim = 225-30-15-4-6-1-12-5-15-40-7-30-2-5-15-14-8-1-(10);
plot(t/60,data{1,end-prev_data}.h(:,1:end))
hold on
plot(t/60,x1(:,39:43)+data{1,end-prev_data}.h(:,1:end))

legend('non-lin','lin')
