%This file gives the relative contribution of sources for pollution from
%roads
%Use suffix 2 in the Simulink model for a second catchment
trans=sec_per_ts/1000; %g-kg and s-seconds per timestep
trans1=0.000001; %ug-g
trans2=0.001; %g-kg
w_size=[ 0 30 1024 670 ]; %to define window size

disp('-------------------------')
disp('Road pollution')
disp('Dry dep')
for i=11:14
    if i==11
        disp('Cu')
    else
        if i==12
            disp('Zn')
        else
            if i==13
                disp('Pb')
            else disp('Cd')
            end
        end
    end
   [poll_DrydepRoad2(1,i)
   poll_BrakeRoad2(1,i)
   poll_RoadwearRoad2(1,i)
   poll_TyrewearRoad2(1,i)
   poll_ExhaustRoad2(1,i)
   poll_OilRoad2(1,i)
   poll_ZncorrRoad2(1,i)]
end
for i=1:2
    if i==1
        disp('P')
    else
        disp('N')
    end
    [poll_DrydepRoad2(1,i)
   poll_BrakeRoad2(1,i)
   poll_RoadwearRoad2(1,i)
   poll_TyrewearRoad2(1,i)
   poll_ExhaustRoad2(1,i)
   poll_OilRoad2(1,i)
   poll_ZncorrRoad2(1,i)]
end
disp('PAH')
[poll_DrydepRoad2(1,20)
   poll_BrakeRoad2(1,20)
   poll_RoadwearRoad2(1,20)
   poll_TyrewearRoad2(1,20)
   poll_ExhaustRoad2(1,20)
   poll_OilRoad2(1,20)
   poll_ZncorrRoad2(1,20)]

disp('BOD')
[poll_DrydepRoad2(1,7)
   poll_BrakeRoad2(1,7)
   poll_RoadwearRoad2(1,7)
   poll_TyrewearRoad2(1,7)
   poll_ExhaustRoad2(1,7)
   poll_OilRoad2(1,7)
   poll_ZncorrRoad2(1,7)]