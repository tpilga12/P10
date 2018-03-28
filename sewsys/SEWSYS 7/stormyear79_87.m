R=input('What year?');
if R==1979
dlmwrite('storm1979',storm(1:35040,:),'\t')
elseif R==1980
dlmwrite('storm1980',storm(35041:70176,:),'\t')
elseif R==1981
dlmwrite('storm1981',storm(70177:105216,:),'\t')
elseif R==1982
dlmwrite('storm1982',storm(105217:140256,:),'\t')
elseif R==1983
dlmwrite('storm1983',storm(140257:175296,:),'\t')
elseif R==1984
dlmwrite('storm1984',storm(175297:210432,:),'\t')
elseif R==1985
dlmwrite('storm1985',storm(210433:245472,:),'\t')
elseif R==1986
dlmwrite('storm1986',storm(245473:280512,:),'\t')
else R==1987
dlmwrite('storm1987',storm(280513:315552,:),'\t')         
end