function [disturbance] = load_disturbance()

% Disturbance function
load brewery_data.mat
load disturbance_from_house_holds_and_small_industry



disturbance = [f1_1; f1_1_indu ; f1_2; f1_3; f1_3_indu; f2;f3;f4_1;f4_1_indu;f4_2;f4_3;f5;f6;f7;f7_indu;f89;f8_9_indu;f10(1,1:86400);f10_1_indu;f11];

end 