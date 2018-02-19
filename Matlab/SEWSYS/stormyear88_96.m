R=input('What year?');
if R==1988
dlmwrite('storm1988',storm(1:35136,:),'\t')
elseif R==1989
dlmwrite('storm1989',storm(35137:70176,:),'\t')
elseif R==1990
dlmwrite('storm1990',storm(70177:105216,:),'\t')
elseif R==1991
dlmwrite('storm1991',storm(105217:140256,:),'\t')
elseif R==1992
dlmwrite('storm1992',storm(140257:175392,:),'\t')
elseif R==1993
dlmwrite('storm1993',storm(175393:210432,:),'\t')
elseif R==1994
dlmwrite('storm1994',storm(210433:245472,:),'\t')
elseif R==1995
dlmwrite('storm1995',storm(245473:280512,:),'\t')
else R==1996
dlmwrite('storm1996',storm(280513:315684,:),'\t')         
end