%Script to plot data
load two_days_simulation 
close all
time = 1:20:172801;
figure(1)
reduce_plot(time,data{end}.Q(1:end,end))
xlabel('Time [hh:mm]')
ylabel('Flow [m^3/s]')
xticklabels({'00:00','08:00','16:00','00:00','08:00','16:00','00:00'})
set(gca,'xtick',[1:28800:172801])
xlim([1 172801])
ylim([0.03 0.6])
grid
%%
figure(1)
reduce_plot(time,data{end}.C(1:end,end))
xlabel('Time [hh:mm]')
ylabel('Flow [g/m^3]')
xticklabels({'00:00','08:00','16:00','00:00','08:00','16:00','00:00'})
set(gca,'xtick',[1:28800:172801])
grid
xlim([1 172801])
ylim([-0.02 0.40])

%% Script to plot data with large tanks
close all
load two_days_simulation_tank
time = 1:20:172801;
figure(1)
reduce_plot(time,data{end}.Q(1:end,end))
xlabel('Time [hh:mm]')
ylabel('Flow [m^3/s]')
xticklabels({'00:00','08:00','16:00','00:00','08:00','16:00','00:00'})
set(gca,'xtick',[1:28800:172801])
xlim([1 172801])
ylim([0.03 0.6])
grid
%%
figure(1)
reduce_plot(time,data{2}.h(1:end,end))
xlabel('Time [hh:mm]')
ylabel('Height [m]')
xticklabels({'00:00','08:00','16:00','00:00','08:00','16:00','00:00'})
set(gca,'xtick',[1:28800:172801])
grid
xlim([1 172801])
% ylim([-0.02 0.40])

