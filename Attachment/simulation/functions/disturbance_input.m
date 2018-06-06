function [input] = disturbance_input(m,Dt,const,input,disturbance,brewery_disturbance,pipe_spec) 
    

if m == 1
    for k = 1:length(pipe_spec)
        if pipe_spec(k).side_inflow == 1
            input.side.Q{k} = 0;
        else
            input.side.Q{k} = 0;
        end
        input.side.C{k} = 0;
    end
end

if m > 1
    i(m)= m*Dt-const*86400;
    if i(m) > 86400
        const = const + 1;
        i(m) = i(m)-86400;
    end
    
        % Disturbance input from the different zones
        input.side.Q{3} = disturbance.Zone1_1(i(m))+disturbance.Zone1_2(i(m))+disturbance.Zone1_3(i(m))+disturbance.Industry_1_1(i(m))+disturbance.Industry_1_3(i(m));
        input.side.Q{6} = disturbance.Zone2(i(m));
        input.side.Q{7} = disturbance.Zone3(i(m));
        input.side.Q{8} = disturbance.Zone4_1(i(m))+disturbance.Zone4_2(i(m))+disturbance.Zone4_3(i(m))+disturbance.Industry_4_1(i(m));
        input.side.Q{9} = disturbance.Zone5(i(m));
        input.side.Q{11}= disturbance.Zone6(i(m));
        input.side.Q{13}= disturbance.Zone7(i(m))+disturbance.Industry7_1(i(m));
        input.side.Q{14}=disturbance.Zone8And9(i(m))+disturbance.Industry_8And9(i(m));
        input.side.Q{15}=disturbance.Zone10(i(m));
        input.side.Q{18}= disturbance.Zone11(i(m));
        
                % Disturbance input from the different zones
        Normalized_poop_curve=disturbance.Zone1_1(1:86400)*235;%Used to create a plot where the integral of the poop curve is equalt to one       
        input.side.C{3} = Normalized_poop_curve(m);%(2279*0.2)*Normalized_poop_curve(m);
        input.side.C{6} = Normalized_poop_curve(m);%173*0.2*Normalized_poop_curve(m);
        input.side.C{7} = Normalized_poop_curve(m);%5799*0.2*Normalized_poop_curve(m);
        input.side.C{8} = Normalized_poop_curve(m);%322*0.2*Normalized_poop_curve(m);
        input.side.C{9} = Normalized_poop_curve(m);%356*0.2*Normalized_poop_curve(m);
        input.side.C{11}= Normalized_poop_curve(m);%5874*0.2*Normalized_poop_curve(m);
        input.side.C{13}= Normalized_poop_curve(m);%2067*0.2*Normalized_poop_curve(m);
        input.side.C{14}= Normalized_poop_curve(m);%3916*0.2*Normalized_poop_curve(m);
        input.side.C{15}= Normalized_poop_curve(m);%11748*0.2*Normalized_poop_curve(m);
        input.side.C{18}= Normalized_poop_curve(m);%865*0.2*Normalized_poop_curve(m);
        
        
 
        % Input from the brewery / bottling plant  
        input.Q_in(m,1) = brewery_disturbance(i(m))/1000+0.05;% + sin(m/10)/35 ;%+ sin(m/100)/15;
        input.C_in(m,1) = 0.001;
end 





end