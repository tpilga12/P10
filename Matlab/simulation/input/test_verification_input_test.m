clear all
clc
global Dt
Dt = 20;
for t = 1:2700
test(t)=test_verification_input(t);
end

 plot((0:1/60:length(test)/60-1/60),test)