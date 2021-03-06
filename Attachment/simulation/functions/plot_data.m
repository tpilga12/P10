function [hej]=plot_data(data, nr_tanks, nr_pipes, sys_setup, play_speed, Dt, pipe_spec, tank_spec, sampling, adjust_start)
global pipe_sep_line
fig_nr  = 2000;
time_font_size = 14; % font size of time and iteration
line_thick = 1.2; % adjust vertical line thickness
topplot_adjust = 1.1; %set how much headroom there should be from graph to top, 1.1 = 10% 
botplot_adjust = 0.9; %set how much headroom there should be from bot to graph, 0.9 = 10% 
hours = 0; % initialize hours in plot

    [plot_limits vertical_line pipe_sep_line] = find_plot_limits(pipe_spec, tank_spec, nr_tanks, data, topplot_adjust, botplot_adjust);
    
    flowylim = [plot_limits(1,1) plot_limits(1,2)];
    heightylim = [plot_limits(2,1) plot_limits(2,2)];
    conflowylim = [plot_limits(3,1) plot_limits(3,2)];
    conspeedylim = [plot_limits(4,1) plot_limits(4,2)];
    if nr_tanks ~= 0
        tankheightlim = [plot_limits(5,1) plot_limits(5,2)];
    end
    distlim = [0 pipe_sep_line(end-1)]; 

    
    %%%%% plot!!!%%%%%%%%%%%%
    x_axis = fetch_axis(sys_setup,pipe_spec,tank_spec);
    iter_count = 0;
    v = 1; %Santas little helper
    for r = 1:length(pipe_spec)
        flow(:,v:(pipe_spec(r).sections+v)) = data{pipe_spec(r).data_location}.Q(:,1:end);
        height(:,v:(pipe_spec(r).sections+v)) = data{pipe_spec(r).data_location}.h(:,1:end);
        concentrate(:,v:(pipe_spec(r).sections+v)) = data{pipe_spec(r).data_location}.C(:,1:end);
        v = v+pipe_spec(r).sections+1;
    end
    tank_spotted = 1;
    x_pos = 0;
    if nr_tanks > 0
        for r = 1:(length(sys_setup)-1)
            x_pos = x_pos + sys_setup(r).sections;
            if strcmp(sys_setup(r).type,'Tank')
                tank_x(tank_spotted) = x_pos;
                tank_height(:,tank_spotted) = data{tank_spec(tank_spotted).data_location}.h(1:end,1);
                tank_concentrate(:,tank_spotted) = data{tank_spec(tank_spotted).data_location}.C(1:end,1);
                tank_spotted = tank_spotted + 1;
                x_pos = x_pos - 1;
            end
        end
    end
    
    

for m = (1+adjust_start):sampling:length(data{1}.Q(:,1))
    
    figure(fig_nr)
    clf
    subplot(2,2,1)
    if nr_tanks > 0
        yyaxis right
        plot(pipe_sep_line(tank_x),tank_height(m,1:end),'*')
        ylim(tankheightlim)
        yyaxis left
        plot(x_axis,flow(m,:))
    else
        plot(x_axis,flow(m,:))
    end
    hold on
    for p=1:(length(vertical_line)-1)
        if pipe_spec(p+1).side_inflow == 1
            color_shape = ':b';
        else
            color_shape = ':r';
        end
        plot([vertical_line(p) vertical_line(p)], flowylim, color_shape,'Linewidth',line_thick);
    end
    ylim(flowylim)
    xlim(distlim)
    ylabel('m^3/s')
    xlabel('distance (m)')
     title(['Flow'])
     
    subplot(2,2,2)
 
    if nr_tanks > 0
        yyaxis right
        plot(pipe_sep_line(tank_x),tank_height(m,1:end),'*')
        ylim(tankheightlim)
        yyaxis left
        plot(x_axis,height(m,:))
        
    else
        plot(x_axis,height(m,:))
    end
    hold on
   
    for p=1:(length(vertical_line)-1)
        if pipe_spec(p+1).side_inflow == 1
            color_shape = ':b';
        else
            color_shape = ':r';
        end
        plot([vertical_line(p) vertical_line(p)], heightylim, color_shape,'Linewidth',line_thick);
    end
    ylim(heightylim)
    xlim(distlim)
    ylabel('meter')
    xlabel('distance (m)')
    title(['Height'])
   
    subplot(2,2,3)
    
     if nr_tanks > 0
        yyaxis right
        plot(pipe_sep_line(tank_x),tank_concentrate(m,1:end),'*')
        ylim(conflowylim)
        yyaxis left
        plot(x_axis,concentrate(m,:))

    else
        plot(x_axis,concentrate(m,:))
    end
    hold on
    for p=1:(length(vertical_line)-1)
        if pipe_spec(p+1).side_inflow == 1
            color_shape = ':b';
        else
            color_shape = ':r';
        end
        plot([vertical_line(p) vertical_line(p)], conflowylim, color_shape,'Linewidth',line_thick);
    end
    title(['concentrate'])
    ylabel('g/m^3')
    xlabel('distance (m)')
    ylim(conflowylim)
    xlim(distlim)
    
    subplot(2,2,4)
    plot(x_axis,concentrate(m,:).*flow(m,:))
    hold on
    for p=1:(length(vertical_line)-1)
        if pipe_spec(p+1).side_inflow == 1
            color_shape = ':b';
        else
            color_shape = ':r';
        end
        plot([vertical_line(p) vertical_line(p)], conspeedylim, color_shape,'Linewidth',line_thick);
%         plot([vertical_line(p) vertical_line(p)], conspeedylim, '-r');
    end
    title(['Concentrate flow'])
    ylim(conspeedylim)
    xlim(distlim)
    ylabel('g/s')
    xlabel('distance (m)')
    
    minutes = m*(Dt/60)-(Dt/60);
    if 1 <= minutes/((hours+1)*60)
        hours = hours + 1;
    end
    [ax,h3] = suplabel([num2str(hours,4),' Hours ',num2str(round(minutes-hours*60),2), ' Minutes ',num2str((minutes-floor(minutes))*60,2), ' Seconds ', ' - Iteration ', num2str(iter_count * sampling + adjust_start,5),],'t');
    set(h3,'FontSize',time_font_size);
    pause(play_speed) 
    iter_count = iter_count + 1;
    if m == adjust_start+1
        fprintf('Click on figure to start playback')
        k = waitforbuttonpress;
    end
end
end