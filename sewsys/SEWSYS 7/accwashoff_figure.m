figure
set(gcf,'position',w_size)
SUBPLOT(2,1,1), plot(T, acc(:,11)*1E-6)
title('Accumulated Copper', 'fontsize', 14)
ylabel('g', 'fontsize', 12)
SUBPLOT(2,1,2), plot(T, s_road(:,11)*1E-6)
title('Washed off Copper', 'fontsize', 14)
ylabel('g', 'fontsize', 12)
XLABEL('Timestep', 'fontsize', 12)
%YLIM([0 1])
%XLIM([1000 2500])
disp('Copper from roads per timestep (g)')
roadpoll(1,11)*1E-6