function [input] = disturbance_input(m,Dt,const,input,disturbance,brewery_disturbance) 
    
    i(m)= m*Dt-const*86400;
    if i(m) > 86400
        const = const + 1;
        i(m) = i(m)-86400;
    end
    
        % Disturbance input from the different zones
        input.side.Q(3) = num2cell(disturbance.Zone1_1(i(m))+disturbance.Zone1_2(i(m))+disturbance.Zone1_3(i(m))+disturbance.Industry_1_1(i(m))+disturbance.Industry_1_3(i(m)));
        input.side.Q(6) = num2cell(disturbance.Zone2(i(m)));
        input.side.Q(7) = num2cell(disturbance.Zone3(i(m)));
        input.side.Q(8) = num2cell(disturbance.Zone4_1(i(m))+disturbance.Zone4_2(i(m))+disturbance.Zone4_3(i(m))+disturbance.Industry_4_1(i(m)));
        input.side.Q(9) = num2cell(disturbance.Zone5(i(m)));
        input.side.Q(11)= num2cell(disturbance.Zone6(i(m)));
        input.side.Q(13)= num2cell(disturbance.Zone7(i(m))+disturbance.Industry7_1(i(m)));
        input.side.Q(14)= num2cell(disturbance.Zone8And9(i(m))+disturbance.Industry_8And9(i(m)));
        input.side.Q(15)= num2cell(disturbance.Zone10(i(m)));
        input.side.Q(18)= num2cell(disturbance.Zone11(i(m)));
 
        % Input from the brewery / bottling plant  
        input.Q_in(m,1) = brewery_disturbance(i(m))/1000+0.05;% + sin(m/10)/35 ;%+ sin(m/100)/15;
     





end