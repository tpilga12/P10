%sum_years = [sum(storm(1:35040,1:21))*900 sum(storm(35041:70176,1:21))*900 sum(storm(70177:105216,1:21))*900 sum(storm(105217:140256,1:21))*900 sum(storm(140257:175296,1:21))*900 sum(storm(175297:210432,1:21))*900 sum(storm(210433:245472,1:21))*900 sum(storm(245473:280512,1:21))*900 sum(storm(280513:315552,1:21))*900]
%sum_years1 = [sum(storm(1:35040,1))*900 sum(storm(35041:70176,1))*900 sum(storm(70177:105216,1))*900 sum(storm(105217:140256,1))*900 sum(storm(140257:175296,1))*900 sum(storm(175297:210432,1))*900 sum(storm(210433:245472,1))*900 sum(storm(245473:280512,1))*900 sum(storm(280513:315552,1))*900]
%sum_years2 = [sum(storm(1:35040,2))*900 sum(storm(35041:70176,2))*900 sum(storm(70177:105216,2))*900 sum(storm(105217:140256,2))*900 sum(storm(140257:175296,2))*900 sum(storm(175297:210432,2))*900 sum(storm(210433:245472,2))*900 sum(storm(245473:280512,2))*900 sum(storm(280513:315552,2))*900]
%sum_years3 = [sum(storm(1:35040,3))*900 sum(storm(35041:70176,3))*900 sum(storm(70177:105216,3))*900 sum(storm(105217:140256,3))*900 sum(storm(140257:175296,3))*900 sum(storm(175297:210432,3))*900 sum(storm(210433:245472,3))*900 sum(storm(245473:280512,3))*900 sum(storm(280513:315552,3))*900]
%sum_years4 = [sum(storm(1:35040,4))*900 sum(storm(35041:70176,4))*900 sum(storm(70177:105216,4))*900 sum(storm(105217:140256,4))*900 sum(storm(140257:175296,4))*900 sum(storm(175297:210432,4))*900 sum(storm(210433:245472,4))*900 sum(storm(245473:280512,4))*900 sum(storm(280513:315552,4))*900]
%sum_years5 = [sum(storm(1:35040,5))*900 sum(storm(35041:70176,5))*900 sum(storm(70177:105216,5))*900 sum(storm(105217:140256,5))*900 sum(storm(140257:175296,5))*900 sum(storm(175297:210432,5))*900 sum(storm(210433:245472,5))*900 sum(storm(245473:280512,5))*900 sum(storm(280513:315552,5))*900]
%sum_years6 = [sum(storm(1:35040,6))*900 sum(storm(35041:70176,6))*900 sum(storm(70177:105216,6))*900 sum(storm(105217:140256,6))*900 sum(storm(140257:175296,6))*900 sum(storm(175297:210432,6))*900 sum(storm(210433:245472,6))*900 sum(storm(245473:280512,6))*900 sum(storm(280513:315552,6))*900]
%sum_years7 = [sum(storm(1:35040,7))*900 sum(storm(35041:70176,7))*900 sum(storm(70177:105216,7))*900 sum(storm(105217:140256,7))*900 sum(storm(140257:175296,7))*900 sum(storm(175297:210432,7))*900 sum(storm(210433:245472,7))*900 sum(storm(245473:280512,7))*900 sum(storm(280513:315552,7))*900]
%sum_years8 = [sum(storm(1:35040,8))*900 sum(storm(35041:70176,8))*900 sum(storm(70177:105216,8))*900 sum(storm(105217:140256,8))*900 sum(storm(140257:175296,8))*900 sum(storm(175297:210432,8))*900 sum(storm(210433:245472,8))*900 sum(storm(245473:280512,8))*900 sum(storm(280513:315552,8))*900]
%sum_years9 = [sum(storm(1:35040,9))*900 sum(storm(35041:70176,9))*900 sum(storm(70177:105216,9))*900 sum(storm(105217:140256,9))*900 sum(storm(140257:175296,9))*900 sum(storm(175297:210432,9))*900 sum(storm(210433:245472,9))*900 sum(storm(245473:280512,9))*900 sum(storm(280513:315552,9))*900]
%sum_year= [sum_years1; sum_years2; sum_years3; sum_years4; sum_years5; sum_years7; sum_years8; sum_years9]

function [sumyear] = sum_years(x)


s=size(x);
m=s(2);
i=0;
j=0;
k=0;
sumyear=zeros(9,21);
sum2=0;
for j=1:m,
    k=1;
    for i=1:35136
        sum2=sum2+x(i,j);
    end
    sumyear(k,j)=sum2*900/1000;
    
    sum2=0;
    k=2;
    for i=35137:70176
        sum2=sum2+x(i,j);
    end
    sumyear(k,j)=sum2*900/1000;
    
    sum2=0;
    k=3;
    for i=70177:105216
        sum2=sum2+x(i,j);
    end
    sumyear(k,j)=sum2*900/1000;
    
    sum2=0;
    k=4;
    for i=105217:140256
        sum2=sum2+x(i,j);
    end  
    sumyear(k,j)=sum2*900/1000;
    
    sum2=0;
    k=5;
    for i=140257:175392
        sum2=sum2+x(i,j);
    end 
    sumyear(k,j)=sum2*900/1000;
    
    sum2=0;
    k=6;
    for i=175393:210432 
        sum2=sum2+x(i,j);
    end  
    sumyear(k,j)=sum2*900/1000;
    
    sum2=0;
    k=7;
    for i=210433:245472
        sum2=sum2+x(i,j);
    end  
    sumyear(k,j)=sum2*900/1000;
    
    sum2=0;
    k=8;
    for i=245473:280512
        sum2=sum2+x(i,j);
    end 
    sumyear(k,j)=sum2*900/1000;
    
    sum2=0;
    k=9;
    for i=280513:315647
        sum2=sum2+x(i,j);
    end  
    sumyear(k,j)=sum2*900/1000;
        
end

    
    
        

        
        
        
        
        
        
        
        
        
        