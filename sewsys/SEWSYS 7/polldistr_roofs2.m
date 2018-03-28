%This file gives the relative contribution of sources for pollution from roofs
%Use suffix 2 in the Simulink model for a second catchment
trans=sec_per_ts/1000; %g-kg and s-seconds per timestep
trans1=0.000001; %ug-g
trans2=0.001; %g-kg
w_size=[ 0 30 1024 670 ]; %to define window size

disp('-------------------------')
disp('Roof pollution')
disp('1. Dry deposition')
disp('2. Copper corrosion')
disp('3. Zinc corrosion')
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
   [poll_DrydepRoof2(1,i)
   poll_CuRoof2(1,i)
   poll_ZnRoof2(1,i)]
end
for i=1:2
    if i==1
        disp('P')
    else
        disp('N')
    end
   [poll_DrydepRoof2(1,i)
   poll_CuRoof2(1,i)
   poll_ZnRoof2(1,i)]
end
disp('PAH')
   [poll_DrydepRoof2(1,20)
   poll_CuRoof2(1,20)
   poll_ZnRoof2(1,20)]

disp('BOD')
   [poll_DrydepRoof2(1,7)
   poll_CuRoof2(1,7)
   poll_ZnRoof2(1,7)]
