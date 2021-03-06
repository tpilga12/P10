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
h_data_hat=data{1,1}.h(2:end,1)-data{1,1}.h(1,1);

t = (sample:sample:length(h_data_hat)*sample)-sample;

h_i(1:length(h_data_hat))=0;%h_data_hat ;%Input height
h_input(1:length(h_data_hat))=0;
h3_input(1:length(t))=0.3;


tank_in = (input.u(2:end,:)-input.u(1,:))';
% tank_in = (input.u(1:end,1))';

%u=[(data{1}.h(:,end)-data{1}.h(1,end))'; (input.u(1:end,1))' ; h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input; h_input]';
u=[h_data_hat'; tank_in(1,:); h_i; h_i; h_i; h_i; h_i; h_i; h_i; h_i; h_i; h_i ]';%

% u=[h_data_hat'; h_i; h_i; h_i; h_i; h_i; h_i; h_i; h_i; h_i; h_i]';
 %%h_input2(1:length(t)) = 0; % Input height, test for at s?tte a = 0

%u = [ u(17:end,:) ; u(end-15:end,:)];

% u = [h_data_hat'; h_input];
% sysT2 = ss(lin_sys.A,lin_sys.B,C_insert,0,lin_sys.Ts);
% x0(1:length(lin_sys.A)) = 0;
% find_umax = find(contains(lin_sys.StateName,'Tank_u_max'));
% ubar_tank = input.tank_height_init(1)*(tank_spec(1).area/Dt)/tank_spec(1).Q_out_max;
% umaxi = x0(:,find_umax)+ubar_tank;
% x0(36)=1;
[Y_hat t1 x1]=lsim(lin_sys,u);
% [Y_hat t1 x1]=lsim(sysT2,u);


%
%  Y_hat = x1(:,226);
% figure(2)
% plot(t./60,Y_hat(:,2))

h_bar = data{1,1}.h(1,1); % S?t sm? signaler
Y_bar =data{1,end}.h(1,end);
Y_lsim = Y_bar + Y_hat;
%%
%  plot_lin = [ 53 55 64 79 95 101 104 135 143 184 200 206 219 221 228 233 249 280];
%  plot_lin = [ 51 52 60 74 89 94 96 126 133 173 188 193 205 206 212 216 231 261];
%  plot_lin = [ 53 54 62 76 91 96 98 128 135 175 190 195 207 208 214 218 233 265];
    plot_lin = [36 37 53 55 63 77 92 97 99 129 136 183 198 203 215 217 223 227 245 283]  
 close all
 for n = 1:length(plot_lin)
     figure(n)
%      figure('units','normalized','outerposition',[0 0 1 1])
     reduce_plot(data{n}.h(:,end))
     hold on
     reduce_plot(Y_hat(1:end,plot_lin(n))+data{n}.h(1,end))
     hold on
  ylabel('Height [m]') 
xlabel('Time [s]')
% xlim([1 8000])
%      plot(t1,x1(1:end,plot_lin(n))+data{n+2}.h(1,end))
%      hold on
%      plot(Y_hat2(1:end,plot_lin(n))+data{n+2}.h(1,end))
%      hold on
%      plot(x2(1:end,plot_lin(n))+data{n+2}.h(1,end))     
     legend('non-linear','linear out','linear states')%,'T out','T states')
%           legend('non-linear','linear out','linear states')
 end
     
%%
close all
figure(1111)
hej = 218;
hej2 = 5;
data_nr = 18;
plot(data{data_nr}.h(1:end,hej2))
hold on
plot(x1(1:end,hej)+data{data_nr}.h(1,hej2))
legend('non-linear','linear')
title('Input height')
xlabel('Time [s]')
ylabel('Tank height [m]')
% xlim([0 900])
grid
%%
figure(1000)
plot(data{1,1}.h(:,1))
title('Input height')
xlabel('Time [s]')
ylabel('Input height [m]')
% xlim([0 900])
grid

figure(2000)
plot(Y_hat(:,1)+Y_bar)
hold on
plot(data{1,end}.h(:,end))
title('Comparison of Non-linear and linear open channel models')
xlabel('Time [s]')
ylabel('Output height [m]')
% xlim([0 900])
legend('Linear','Non-linear')
grid
%%
% figure(22)
% plot(data{1,3}.h(2:end,1))
% hold on
% plot(x1(1:end,plot_piece-1)+data{1,2}.h(1,plot_piece-1))
% 
% legend('Non-Linear','linear')

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
%% 
close all
figure(1000)
reduce_plot(t,data{1,1}.Q(1:499,2))
% title('Input height')
xlabel('Time [s]')
ylabel('Input flow [m^3/s]')
% xlim([0 900])
grid
%%
figure(2000)
plot(Y_hat(:,1)+Y_bar)
hold on
plot(data{1,end}.h(:,end))
title('Comparison of Non-linear and linear open channel models')
xlabel('Time [s]')
ylabel('Output height [m]')
% xlim([0 900])
legend('Linear','Non-linear')
grid
