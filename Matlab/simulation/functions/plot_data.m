function [hej]=plot_data(data,nr_pipes,play_speed,Dt,pipe_spec,sampling)
global pipe_sep_line
fig_nr  = 2000;
decimals_plot = 4; %amount of decimals shown -> "minutes %value"
topplot_adjust = 1.1; %set how much headroom there should be from graph to top, 1.1 = 110% 
botplot_adjust = 0.9; %set how much headroom there should be from bot to graph, 0.9 = 10% 

    [plot_limits vertical_line pipe_sep_line] = find_plot_limits(pipe_spec,data,topplot_adjust,botplot_adjust);
    
    flowylim = [plot_limits(1,1) plot_limits(1,2)];
    heightylim = [plot_limits(2,1) plot_limits(2,2)];
    conflowylim = [plot_limits(3,1) plot_limits(3,2)];
    conspeedylim = [plot_limits(4,1) plot_limits(4,2)];
    distlim = [0 pipe_sep_line(end-1)]; 
    line_thick = 0.8;
    %%%%% plot!!!%%%%%%%%%%%%

    
for m= 1:sampling:length(data{1}.Q(:,1))
    v = 1; %Santas little helper
    for r = 1:length(pipe_spec)
        flow(1,v:(pipe_spec(r).sections+v-1)) = data{r}.Q(m,1:end);
        height(1,v:(pipe_spec(r).sections+v-1)) = data{r}.h(m,1:end);
        concentrate(1,v:(pipe_spec(r).sections+v-1)) = data{r}.C(m,1:end);
        v = v+pipe_spec(r).sections;
    end
    figure(fig_nr)
    clf
    subplot(2,2,1)
    plot(pipe_sep_line(1:end-1),flow)
    hold on
    for p=1:(length(vertical_line)-1)
        plot([vertical_line(p) vertical_line(p)], flowylim, 'r','Linewidth',line_thick);
    end
    ylim(flowylim)
    xlim(distlim)
    ylabel('m^3/s')
    xlabel('distance (m)')
     title(['Flow'])
     
    subplot(2,2,2)
    plot(pipe_sep_line(1:end-1),height)
    hold on
    for p=1:(length(vertical_line)-1)
        plot([vertical_line(p) vertical_line(p)], heightylim, 'r');
    end
    ylim(heightylim)
    xlim(distlim)
    ylabel('meter')
    xlabel('distance (m)')
    title(['Height'])
   
    subplot(2,2,3)
    plot(pipe_sep_line(1:end-1),concentrate)
    hold on
    for p=1:(length(vertical_line)-1)
        plot([vertical_line(p) vertical_line(p)], conflowylim, 'r');
    end
    title(['concentrate'])
    ylabel('g/m^3')
    xlabel('distance (m)')
    ylim(conflowylim)
    xlim(distlim)
    
    subplot(2,2,4)
    plot(pipe_sep_line(1:end-1),concentrate.*flow)
    hold on
    for p=1:(length(vertical_line)-1)
        plot([vertical_line(p) vertical_line(p)], conspeedylim, 'r');
    end
    title(['Concentrate flow'])
    ylim(conspeedylim)
    xlim(distlim)
    ylabel('g/s')
    xlabel('distance (m)')
    
    [ax,h3] = suplabel(['Minutes ', num2str(m*(Dt/60)-(Dt/60),decimals_plot)],'t');
    set(h3,'FontSize',20);
    pause(play_speed) 
    
end
end