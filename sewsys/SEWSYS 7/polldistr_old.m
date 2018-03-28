
trans=sec_per_ts/1000; %g-kg and s-seconds per timestep
trans1=0.000001; %ug-g
trans2=0.001; %g-kg
w_size=[ 0 30 1024 670 ]; %to define window size

for i=2:21
   i
   j=i-1;
   tot=[sum(storm(:,i))]*trans;
   wetdep1=[sum(s_wetdep(:,i))]*tota*trans1*trans2;
   road=[sum(s_road(:,j))]*trans1*trans2;
   roof=[sum(s_roof(:,j))]*trans1*trans2;
   other=[sum(s_other(:,j))]*trans1*trans2;
   storm_bar=[tot,wetdep1,road,roof, other]'
end
disp('-------------------------')
disp('Road pollution')
disp('Dry dep')
for i=1:20
   i
   poll_DrydepRoad(1,i)
end
disp('-------------------------')
disp('Brake wear')
for i=1:20
   i
   poll_BrakeRoad(1,i)
end
disp('-------------------------')
disp('Road wear')
for i=1:20
   i
   poll_RoadwearRoad(1,i)
end
disp('-------------------------')
disp('Tyre wear')
for i=1:20
   i
   poll_TyrewearRoad(1,i)
end
disp('-------------------------')
disp('Exhausts')
for i=1:20
   i
   poll_ExhaustRoad(1,i)
end
disp('-------------------------')
disp('Oil spillage')
for i=1:20
   i
   poll_OilRoad(1,i)
end
disp('-------------------------')
disp('Zn corr')
for i=1:20
   i
   poll_ZncorrRoad(1,i)
end
disp('-------------------------')
disp('Roof pollution')
disp('Dry dep')
for i=1:20
   i
   poll_DrydepRoof(1,i)
end
disp('-------------------------')
disp('Cu roof')
for i=1:20
   i
   poll_CuRoof(1,i)
end
disp('-------------------------')
disp('Zn roof')
for i=1:20
   i
   poll_ZnRoof(1,i)
end

%figure
%set(gcf,'position',w_size)
%SUBPLOT(2,1,1), plot(T, acc(:,11)*1E-6)
%title('Accumulated Copper', 'fontsize', 14)
%ylabel('g', 'fontsize', 12)
%SUBPLOT(2,1,2), plot(T, s_road(:,11)*1E-6)
%title('Washed off Copper', 'fontsize', 14)
%ylabel('g', 'fontsize', 12)
%XLABEL('Timestep', 'fontsize', 12)
%YLIM([0 1])
%XLIM([1000 2500])
%disp('Copper from roads per timestep (g)')
%roadpoll(1,11)*1E-6