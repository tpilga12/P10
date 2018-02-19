ts=96; %timesteps per day (96 for 15 min)

figure
SUBPLOT(2,1,1)
plot(T(1:ts*31),storm(1:ts*31,1))
title('Storm Water Discharge - January', 'fontsize', 14)
ylabel('m^3/s', 'fontsize', 12)
XLABEL('Timestep')
XLIM([1 ts*31])


SUBPLOT(2,1,2)
plot(T(ts*(31+1):ts*(31+28)),storm(ts*(31+1):ts*(31+28),1))
title('Storm Water Discharge - February', 'fontsize', 14)
ylabel('m^3/s', 'fontsize', 12)
XLABEL('Timestep')
XLIM([ts*(31+1) ts*(31+28)])
set(gcf,'numbertitle','off')
set(gcf,'name','January, February')
orient landscape
set(gcf,'papertype','A4')
set(gcf,'PaperPositionMode','auto')


figure
SUBPLOT(2,1,1)
plot(T(ts*(31+28+1):ts*(31+28+31)),storm(ts*(31+28+1):ts*(31+28+31),1))
title('Storm Water Discharge - March', 'fontsize', 14)
ylabel('m^3/s', 'fontsize', 12)
XLABEL('Timestep')
XLIM([ts*(31+28+1) ts*(31+28+31)])


SUBPLOT(2,1,2)
plot(T(ts*(31+28+31+1):ts*(31+28+31+30)),storm(ts*(31+28+31+1):ts*(31+28+31+30),1))
title('Storm Water Discharge - April', 'fontsize', 14)
ylabel('m^3/s', 'fontsize', 12)
XLABEL('Timestep')
XLIM([ts*(31+28+31+1) ts*(31+28+31+30)])
set(gcf,'numbertitle','off')
set(gcf,'name','March, April')
orient landscape
set(gcf,'papertype','A4')
set(gcf,'PaperPositionMode','auto')


figure
SUBPLOT(2,1,1)
plot(T(ts*(31+28+31+30+1):ts*(31+28+31+30+31)),storm(ts*(31+28+31+30+1):ts*(31+28+31+30+31),1))
title('Storm Water Discharge - May', 'fontsize', 14)
ylabel('m^3/s', 'fontsize', 12)
XLABEL('Timestep')
XLIM([ts*(31+28+31+30+1) ts*(31+28+31+30+31)])


SUBPLOT(2,1,2)
plot(T(ts*(31+28+31+30+31+1):ts*(31+28+31+30+31+30)),storm(ts*(31+28+31+30+31+1):ts*(31+28+31+30+31+30),1))
title('Storm Water Discharge - June', 'fontsize', 14)
ylabel('m^3/s', 'fontsize', 12)
XLABEL('Timestep')
XLIM([ts*(31+28+31+30+31+1) ts*(31+28+31+30+31+30)])
set(gcf,'numbertitle','off')
set(gcf,'name','May, June')
orient landscape
set(gcf,'papertype','A4')
set(gcf,'PaperPositionMode','auto')


figure
SUBPLOT(2,1,1)
plot(T(ts*(31+28+31+30+31+30+1):ts*(31+28+31+30+31+30+31)),storm(ts*(31+28+31+30+31+30+1):ts*(31+28+31+30+31+30+31),1))
title('Storm Water Discharge - July', 'fontsize', 14)
ylabel('m^3/s', 'fontsize', 12)
XLABEL('Timestep')
XLIM([ts*(31+28+31+30+31+30+1) ts*(31+28+31+30+31+30+31)])

SUBPLOT(2,1,2)
plot(T(ts*(31+28+31+30+31+30+31+1):ts*(31+28+31+30+31+30+31+31)),storm(ts*(31+28+31+30+31+30+31+1):ts*(31+28+31+30+31+30+31+31),1))
title('Storm Water Discharge - August', 'fontsize', 14)
ylabel('m^3/s', 'fontsize', 12)
XLABEL('Timestep')
XLIM([ts*(31+28+31+30+31+30+31+1) ts*(31+28+31+30+31+30+31+31)])
set(gcf,'numbertitle','off')
set(gcf,'name','July, August')
orient landscape
set(gcf,'papertype','A4')
set(gcf,'PaperPositionMode','auto')


figure
SUBPLOT(2,1,1)
plot(T(ts*(31+28+31+30+31+30+31+31+1):ts*(31+28+31+30+31+30+31+31+30)),storm(ts*(31+28+31+30+31+30+31+31+1):ts*(31+28+31+30+31+30+31+31+30),1))
title('Storm Water Discharge - September', 'fontsize', 14)
ylabel('m^3/s', 'fontsize', 12)
XLABEL('Timestep')
XLIM([ts*(31+28+31+30+31+30+31+31+1) ts*(31+28+31+30+31+30+31+31+30)])

SUBPLOT(2,1,2)
plot(T(ts*(31+28+31+30+31+30+31+31+30+1):ts*(31+28+31+30+31+30+31+31+30+31)),storm(ts*(31+28+31+30+31+30+31+31+30+1):ts*(31+28+31+30+31+30+31+31+30+31),1))
title('Storm Water Discharge - October', 'fontsize', 14)
ylabel('m^3/s', 'fontsize', 12)
XLABEL('Timestep')
XLIM([ts*(31+28+31+30+31+30+31+31+30+1) ts*(31+28+31+30+31+30+31+31+30+31)])
set(gcf,'numbertitle','off')
set(gcf,'name','September, October')
orient landscape
set(gcf,'papertype','A4')
set(gcf,'PaperPositionMode','auto')


figure
SUBPLOT(2,1,1)
plot(T(ts*(31+28+31+30+31+30+31+31+30+31+1):ts*(31+28+31+30+31+30+31+31+30+31+30)),storm(ts*(31+28+31+30+31+30+31+31+30+31+1):ts*(31+28+31+30+31+30+31+31+30+31+30),1))
title('Storm Water Discharge - November', 'fontsize', 14)
ylabel('m^3/s', 'fontsize', 12)
XLABEL('Timestep')
XLIM([ts*(31+28+31+30+31+30+31+31+30+31+1) ts*(31+28+31+30+31+30+31+31+30+31+30)])

SUBPLOT(2,1,2)
plot(T(ts*(31+28+31+30+31+30+31+31+30+31+30+1):ts*(31+28+31+30+31+30+31+31+30+31+30+31)),storm(ts*(31+28+31+30+31+30+31+31+30+31+30+1):ts*(31+28+31+30+31+30+31+31+30+31+30+31),1))
title('Storm Water Discharge - December', 'fontsize', 14)
ylabel('m^3/s', 'fontsize', 12)
XLABEL('Timestep')
XLIM([ts*(31+28+31+30+31+30+31+31+30+31+30+1) ts*(31+28+31+30+31+30+31+31+30+31+30+31)])
set(gcf,'numbertitle','off')
set(gcf,'name','November, December')
orient landscape
set(gcf,'papertype','A4')
set(gcf,'PaperPositionMode','auto')

