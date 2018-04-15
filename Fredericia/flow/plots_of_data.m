%% Load data from Fredericia
clc
clear all

load inFlow_fredericia
flow =  FT1156IndlbsflowMt;

load Time_fredericia
time = Tid;

figure(1)
plot(time,flow)
xlabel('Date and time')
ylabel('Flow [m^3/hr]')
title('Inflow to Fredericia WWTP over a week')
xtickformat('dd-MMM-yyyy')
grid 


for n = 2:9
    figure(2)
    subplot(4,2,n-1)
    plot(time,flow)
    xlabel('Date and time')
    ylabel('Flow [m^3/hr]')
    title(['Inflow to Fredericia WWTP febuary the ', num2str(n+2)])
    xlim(datetime(2018,[2 2],[n+2 n+3]))
    grid
end

