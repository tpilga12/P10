function [input_flow] = test_verification_input(tid)

global Dt
persistent stamp n

time = tid*Dt;
lengths = [14 9 21 13 18.5 10 22.5 11 20 9 100000];
if tid == 1
    n = 1;
    stamp(n) = mm(14)*Dt;
end
if time >= floor(stamp(n))
    stamp(n+1) = stamp(n) + mm(lengths(n+1))*Dt;
    n = n+1;
end


if time < stamp(1)
input_flow = 0;
% stamp = stamp + mm(9);
elseif time < stamp(2)
input_flow = 0.048;
% stamp = stamp + mm(21);
elseif time < stamp(3)
input_flow = 0;
% stamp = stamp + mm(13);    
elseif time < stamp(4)
input_flow = 0.036+(6/7000);
% stamp = stamp + mm(18.5);    
elseif time < stamp(5)
input_flow = 0;
% stamp = stamp + mm(10);    
elseif time < stamp(6)
input_flow = 0.048;
% stamp = stamp + mm(22.5);    
elseif time < stamp(7)
input_flow = 0;
% stamp = stamp + mm(11);    
elseif time < stamp(8)
input_flow = 0.036+(6/7000);
% stamp = stamp + mm(20);    
elseif time < stamp(9)
input_flow = 0;
% stamp = stamp + mm(9);    
elseif time < stamp(10)
input_flow = 0.048;
% stamp = stamp + mm(20);    
elseif time < stamp(11)
input_flow = 0;
% stamp = stamp + 10000;    
end

end

