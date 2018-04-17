function [hej]=plot_data(data,nr_pipes,play_speed,Dt,pipe_spec)
global afstand
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
    flowylim = [0 0.12];
    heightylim = [0 2.0];
    conflowylim = [0 25];
    conspeedylim = [0 2.0];
    line_thick = 0.8;
for m= 1:length(data{1}.Q)
    figure(1000)

    subplot(2,2,1)
    plot(afstand(1:end-1),[data{1}.Q(m,1:end) data{2}.Q(m,1:end) data{3}.Q(m,1:end)])
    hold on
    for p=1:length(vertical_line)
        plot([vertical_line(p) vertical_line(p)], flowylim,'Linewidth',line_thick);
    end
    ylim(flowylim)
    ylabel('m^3/s')
    xlabel('distance (m)')
     title(['Flow'])
     
    subplot(2,2,2)
    plot(afstand(1:end-1),[data{1}.h(m,1:end) data{2}.h(m,1:end) data{3}.h(m,1:end)])
    hold on
    for p=1:length(vertical_line)
        plot([vertical_line(p) vertical_line(p)], heightylim);
    end
    ylim(heightylim)
    ylabel('meter')
    xlabel('distance (m)')
    title(['Height'])
   
    
%     figure(2000)
    subplot(2,2,3)
    plot(afstand(1:end-1),[data{1}.C(m,1:end) data{2}.C(m,1:end) data{3}.C(m,1:end)])
    hold on
    for p=1:length(vertical_line)
        plot([vertical_line(p) vertical_line(p)], conflowylim);
    end
    title(['concentrate'])
    ylabel('g/m^3')
    xlabel('distance (m)')
    ylim(conflowylim)
    
    subplot(2,2,4)
    plot(afstand(1:end-1),[data{1}.C(m,1:end).*data{1}.Q(m,1:end) data{2}.C(m,1:end).*data{2}.Q(m,1:end) data{3}.C(m,1:end).*data{3}.Q(m,1:end)])
    hold on
    for p=1:length(vertical_line)
        plot([vertical_line(p) vertical_line(p)], conspeedylim);
    end
    title(['Concentrate flow'])
    ylim(conspeedylim)
    ylabel('g/s')
    xlabel('distance (m)')
    
    suptitle(['Minutes ', num2str(m*Dt/60,3)])
    pause(play_speed) 
end
end