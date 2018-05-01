function [hej]=plot_data(data,nr_pipes,play_speed,Dt,pipe_spec)
global afstand
fig_nr  = 2000;
afstand = 0;
for n = 1: length(pipe_spec)
    for g = length(afstand):pipe_spec(n).sections+length(afstand)
        if n == 1 && g == 1
            afstand(g) =  pipe_spec(n).Dx;
        else
            afstand(g) =  pipe_spec(n).Dx + afstand(g-1);
        end
    end
    vertical_line(n) = afstand(g-1);
end
    flowylim = [0 0.35];
    heightylim = [0 2.0];
    conflowylim = [0 25];
    conspeedylim = [0 4.0];
    distlim = [0 afstand(end-1)]; 
    line_thick = 0.8;
    %%%%% plot!!!%%%%%%%%%%%%
    
for m= 1:length(data{1}.Q)
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
%     plot(afstand(1:end-1),[data{1}.Q(m,1:end) data{2}.Q(m,1:end) data{3}.Q(m,1:end)])
    plot(afstand(1:end-1),flow)
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
%     plot(afstand(1:end-1),[data{1}.h(m,1:end) data{2}.h(m,1:end) data{3}.h(m,1:end)])
    plot(afstand(1:end-1),height)
    hold on
    for p=1:(length(vertical_line)-1)
        plot([vertical_line(p) vertical_line(p)], heightylim, 'r');
    end
    ylim(heightylim)
    xlim(distlim)
    ylabel('meter')
    xlabel('distance (m)')
    title(['Height'])
   
    
%     figure(2000)
    subplot(2,2,3)
%     plot(afstand(1:end-1),[data{1}.C(m,1:end) data{2}.C(m,1:end) data{3}.C(m,1:end)])
    plot(afstand(1:end-1),concentrate)
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
%     plot(afstand(1:end-1),[data{1}.C(m,1:end).*data{1}.Q(m,1:end) data{2}.C(m,1:end).*data{2}.Q(m,1:end) data{3}.C(m,1:end).*data{3}.Q(m,1:end)])
    plot(afstand(1:end-1),concentrate.*flow)
    hold on
    for p=1:(length(vertical_line)-1)
        plot([vertical_line(p) vertical_line(p)], conspeedylim, 'r');
    end
    title(['Concentrate flow'])
    ylim(conspeedylim)
    xlim(distlim)
    ylabel('g/s')
    xlabel('distance (m)')
    
%     suptitle(['Minutes ', num2str(m*Dt/60,3)])
    [ax,h3] = suplabel(['Minutes ', num2str(m*(Dt/60),3)],'t');
    set(h3,'FontSize',20);
    pause(play_speed) 
    
end
end