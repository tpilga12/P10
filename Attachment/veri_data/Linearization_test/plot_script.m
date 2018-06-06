%% To plot the linearization comparison with nonlinear data. 
t = 1:20:8000;  

plot_lin = [36 37 53 55 63 77 92 97 99 129 136 183 198 203 215 217 223 227 245 283]  
 close all
 for n = 1:length(plot_lin)
     figure(n)

     reduce_plot(t,data{n}.h(1:400,end))
     hold on
     reduce_plot(t,Y_hat(1:400,plot_lin(n))+data{n}.h(1,end))
     hold on
  ylabel('Height [m]') 
xlabel('Time [s]')
    grid
     legend('non-linear','linear out','linear states')%,'T out','T states')

 end