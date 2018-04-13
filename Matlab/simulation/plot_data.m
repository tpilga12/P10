function [hej]=plot_data(data,nr_pipes,play_speed,Dt,pipe_spec)
afstand = 0;
for n = 1: length(pipe_spec)
%     afstand(length(afstand):length(data{n}.Q(1,:))) = (afstand(:,end)+1:length(data{n}.Q(1,:))+afstand(:,end)).*pipe_spec(n).Dx;
  %  afstand(length(afstand):length(data{n}.Q(1,:))) = ((length(afstand)+1:length(data{n}.Q(1,:)))+afstand(:,end)).*pipe_spec(n).Dx;
end

for m= 1:length(data{1}.Q)
    figure(1000)
    subplot(2,1,1)
    vline(80,'r''pipe1')
    plot([data{1}.Q(m,1:end) data{2}.Q(m,1:end) data{3}.Q(m,1:end)])
    ylim([0.01 0.09])
     title(['Flow at min.', num2str(m*Dt/60)])
     
    subplot(2,1,2)
    plot([data{1}.h(m,1:end) data{2}.h(m,1:end) data{3}.h(m,1:end)])
    title(['Height'])
   
    
    figure(2000)
    subplot(2,1,1)
    plot([data{1}.C(m,1:end) data{2}.C(m,1:end) data{3}.C(m,1:end)])
    title(['concentrate at min.', num2str(m*Dt/60)])
    ylim([5 15])
    
    subplot(2,1,2)
    plot([data{1}.C(m,1:end).*data{1}.Q(m,1:end) data{2}.C(m,1:end).*data{2}.Q(m,1:end) data{3}.C(m,1:end).*data{3}.Q(m,1:end)])
    title(['Concentrate flow'])
    ylim([0.1 0.5])
    
    pause(play_speed) 
end
end