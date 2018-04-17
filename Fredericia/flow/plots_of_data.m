%% Load data from Fredericia
clc
clear all
close all

load inFlow_fredericia
flow =  FT1156IndlbsflowMt;

flow(63422:63481,:)=[871];

load Time_fredericia
time = datetime(Tid);
%time = datetime(Tid,'format','DD-MM-yyyy');
%time = [time(:,1), time(:,2), time(:,3), time(:,4), time(:,5), time(:,6)]  

figure(1)
reduce_plot(time,flow)
xlabel('Date and time')
ylabel('Flow [m^3/hr]')
title('Inflow to Fredericia WWTP over a week')
grid 

%%
% for n = 2:9
%     figure(2)
%     subplot(4,2,n-1)
%     plot(time,flow)
%     xlabel('Date and time')
%     ylabel('Flow [m^3/hr]')
%     title(['Inflow to Fredericia WWTP febuary the ', num2str(n+2)])
%     xlim(datetime(2018,[2 2],[n+2 n+3]))
%     grid
% end

