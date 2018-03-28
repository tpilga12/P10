%File randh.m 
%This function produces random numbers for sanitary runoff variation within the hour
%for use in file: time_var.m
%Stefan Ahlman
%2000-02-23

function [B] = randh(x)

a=1.2; %upper limit
b=0.7; %lower limit
s=1;

if x~=1
   while s >=0.0001
      A=rand(x,1); %generate x rows of random numbers
      B=[A*(a-b)+b]; %random numbers between a and b
      medel=mean(B);
      s=abs(1-medel);
   end
elseif x==1
   B=1;
   s=0;
end

