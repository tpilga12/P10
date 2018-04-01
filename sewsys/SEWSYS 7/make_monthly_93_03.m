%File for making sum matrix for each month
%export flow file [m3/s]
%csvwrite('uppsala_flow96',storm(:,1))

%make volumes and pollution load data; [m3] and [g]
sec_per_ts=600;
monthly_93_03=[
    %1993 
    sum(storm(1:31*24*6,1))*sec_per_ts sum(storm(1:31*24*6,2:3))*sec_per_ts sum(storm(1:31*24*6,12:15))*sec_per_ts
    sum(storm(31*24*6+1:59*24*6,1))*sec_per_ts sum(storm(31*24*6+1:59*24*6,2:3))*sec_per_ts sum(storm(31*24*6+1:59*24*6,12:15))*sec_per_ts
    sum(storm(59*24*6+1:90*24*6,1))*sec_per_ts sum(storm(59*24*6+1:90*24*6,2:3))*sec_per_ts sum(storm(59*24*6+1:90*24*6,12:15))*sec_per_ts
    sum(storm(90*24*6+1:120*24*6,1))*sec_per_ts sum(storm(90*24*6+1:120*24*6,2:3))*sec_per_ts sum(storm(90*24*6+1:120*24*6,12:15))*sec_per_ts
    sum(storm(120*24*6+1:151*24*6,1))*sec_per_ts sum(storm(120*24*6+1:151*24*6,2:3))*sec_per_ts sum(storm(120*24*6+1:151*24*6,12:15))*sec_per_ts
    sum(storm(151*24*6+1:181*24*6,1))*sec_per_ts sum(storm(151*24*6+1:181*24*6,2:3))*sec_per_ts sum(storm(151*24*6+1:181*24*6,12:15))*sec_per_ts
    sum(storm(181*24*6+1:212*24*6,1))*sec_per_ts sum(storm(181*24*6+1:212*24*6,2:3))*sec_per_ts sum(storm(181*24*6+1:212*24*6,12:15))*sec_per_ts
    sum(storm(212*24*6+1:243*24*6,1))*sec_per_ts sum(storm(212*24*6+1:243*24*6,2:3))*sec_per_ts sum(storm(212*24*6+1:243*24*6,12:15))*sec_per_ts
    sum(storm(243*24*6+1:273*24*6,1))*sec_per_ts sum(storm(243*24*6+1:273*24*6,2:3))*sec_per_ts sum(storm(243*24*6+1:273*24*6,12:15))*sec_per_ts
    sum(storm(273*24*6+1:304*24*6,1))*sec_per_ts sum(storm(273*24*6+1:304*24*6,2:3))*sec_per_ts sum(storm(273*24*6+1:304*24*6,12:15))*sec_per_ts
    sum(storm(304*24*6+1:334*24*6,1))*sec_per_ts sum(storm(304*24*6+1:334*24*6,2:3))*sec_per_ts sum(storm(304*24*6+1:334*24*6,12:15))*sec_per_ts
    sum(storm(334*24*6+1:365*24*6,1))*sec_per_ts sum(storm(334*24*6+1:365*24*6,2:3))*sec_per_ts sum(storm(334*24*6+1:365*24*6,12:15))*sec_per_ts
    %1994 (+52560 ts)
    sum(storm(52560+1:52560+31*24*6,1))*sec_per_ts sum(storm(52560+1:52560+31*24*6,2:3))*sec_per_ts sum(storm(52560+1:52560+31*24*6,12:15))*sec_per_ts
    sum(storm(52560+31*24*6+1:52560+59*24*6,1))*sec_per_ts sum(storm(52560+31*24*6+1:52560+59*24*6,2:3))*sec_per_ts sum(storm(52560+31*24*6+1:52560+59*24*6,12:15))*sec_per_ts
    sum(storm(52560+59*24*6+1:52560+90*24*6,1))*sec_per_ts sum(storm(52560+59*24*6+1:52560+90*24*6,2:3))*sec_per_ts sum(storm(52560+59*24*6+1:52560+90*24*6,12:15))*sec_per_ts
    sum(storm(52560+90*24*6+1:52560+120*24*6,1))*sec_per_ts sum(storm(52560+90*24*6+1:52560+120*24*6,2:3))*sec_per_ts sum(storm(52560+90*24*6+1:52560+120*24*6,12:15))*sec_per_ts
    sum(storm(52560+120*24*6+1:52560+151*24*6,1))*sec_per_ts sum(storm(52560+120*24*6+1:52560+151*24*6,2:3))*sec_per_ts sum(storm(52560+120*24*6+1:52560+151*24*6,12:15))*sec_per_ts
    sum(storm(52560+151*24*6+1:52560+181*24*6,1))*sec_per_ts sum(storm(52560+151*24*6+1:52560+181*24*6,2:3))*sec_per_ts sum(storm(52560+151*24*6+1:52560+181*24*6,12:15))*sec_per_ts
    sum(storm(52560+181*24*6+1:52560+212*24*6,1))*sec_per_ts sum(storm(52560+181*24*6+1:52560+212*24*6,2:3))*sec_per_ts sum(storm(52560+181*24*6+1:52560+212*24*6,12:15))*sec_per_ts
    sum(storm(52560+212*24*6+1:52560+243*24*6,1))*sec_per_ts sum(storm(52560+212*24*6+1:52560+243*24*6,2:3))*sec_per_ts sum(storm(52560+212*24*6+1:52560+243*24*6,12:15))*sec_per_ts
    sum(storm(52560+243*24*6+1:52560+273*24*6,1))*sec_per_ts sum(storm(52560+243*24*6+1:52560+273*24*6,2:3))*sec_per_ts sum(storm(52560+243*24*6+1:52560+273*24*6,12:15))*sec_per_ts
    sum(storm(52560+273*24*6+1:52560+304*24*6,1))*sec_per_ts sum(storm(52560+273*24*6+1:52560+304*24*6,2:3))*sec_per_ts sum(storm(52560+273*24*6+1:52560+304*24*6,12:15))*sec_per_ts
    sum(storm(52560+304*24*6+1:52560+334*24*6,1))*sec_per_ts sum(storm(52560+304*24*6+1:52560+334*24*6,2:3))*sec_per_ts sum(storm(52560+304*24*6+1:52560+334*24*6,12:15))*sec_per_ts
    sum(storm(52560+334*24*6+1:52560+365*24*6,1))*sec_per_ts sum(storm(52560+334*24*6+1:52560+365*24*6,2:3))*sec_per_ts sum(storm(52560+334*24*6+1:52560+365*24*6,12:15))*sec_per_ts
    %1995 (+105120 ts)
    sum(storm(105120+1:105120+31*24*6,1))*sec_per_ts sum(storm(105120+1:105120+31*24*6,2:3))*sec_per_ts sum(storm(105120+1:105120+31*24*6,12:15))*sec_per_ts
    sum(storm(105120+31*24*6+1:105120+59*24*6,1))*sec_per_ts sum(storm(105120+31*24*6+1:105120+59*24*6,2:3))*sec_per_ts sum(storm(105120+31*24*6+1:105120+59*24*6,12:15))*sec_per_ts
    sum(storm(105120+59*24*6+1:105120+90*24*6,1))*sec_per_ts sum(storm(105120+59*24*6+1:105120+90*24*6,2:3))*sec_per_ts sum(storm(105120+59*24*6+1:105120+90*24*6,12:15))*sec_per_ts
    sum(storm(105120+90*24*6+1:105120+120*24*6,1))*sec_per_ts sum(storm(105120+90*24*6+1:105120+120*24*6,2:3))*sec_per_ts sum(storm(105120+90*24*6+1:105120+120*24*6,12:15))*sec_per_ts
    sum(storm(105120+120*24*6+1:105120+151*24*6,1))*sec_per_ts sum(storm(105120+120*24*6+1:105120+151*24*6,2:3))*sec_per_ts sum(storm(105120+120*24*6+1:105120+151*24*6,12:15))*sec_per_ts
    sum(storm(105120+151*24*6+1:105120+181*24*6,1))*sec_per_ts sum(storm(105120+151*24*6+1:105120+181*24*6,2:3))*sec_per_ts sum(storm(105120+151*24*6+1:105120+181*24*6,12:15))*sec_per_ts
    sum(storm(105120+181*24*6+1:105120+212*24*6,1))*sec_per_ts sum(storm(105120+181*24*6+1:105120+212*24*6,2:3))*sec_per_ts sum(storm(105120+181*24*6+1:105120+212*24*6,12:15))*sec_per_ts
    sum(storm(105120+212*24*6+1:105120+243*24*6,1))*sec_per_ts sum(storm(105120+212*24*6+1:105120+243*24*6,2:3))*sec_per_ts sum(storm(105120+212*24*6+1:105120+243*24*6,12:15))*sec_per_ts
    sum(storm(105120+243*24*6+1:105120+273*24*6,1))*sec_per_ts sum(storm(105120+243*24*6+1:105120+273*24*6,2:3))*sec_per_ts sum(storm(105120+243*24*6+1:105120+273*24*6,12:15))*sec_per_ts
    sum(storm(105120+273*24*6+1:105120+304*24*6,1))*sec_per_ts sum(storm(105120+273*24*6+1:105120+304*24*6,2:3))*sec_per_ts sum(storm(105120+273*24*6+1:105120+304*24*6,12:15))*sec_per_ts
    sum(storm(105120+304*24*6+1:105120+334*24*6,1))*sec_per_ts sum(storm(105120+304*24*6+1:105120+334*24*6,2:3))*sec_per_ts sum(storm(105120+304*24*6+1:105120+334*24*6,12:15))*sec_per_ts
    sum(storm(105120+334*24*6+1:105120+365*24*6,1))*sec_per_ts sum(storm(105120+334*24*6+1:105120+365*24*6,2:3))*sec_per_ts sum(storm(105120+334*24*6+1:105120+365*24*6,12:15))*sec_per_ts
    %1996, skott�r (+157680 ts)
    sum(storm(157680+1:157680+31*24*6,1))*sec_per_ts sum(storm(157680+1:157680+31*24*6,2:3))*sec_per_ts sum(storm(157680+1:157680+31*24*6,12:15))*sec_per_ts
    sum(storm(157680+31*24*6+1:157680+60*24*6,1))*sec_per_ts sum(storm(157680+31*24*6+1:157680+60*24*6,2:3))*sec_per_ts sum(storm(157680+31*24*6+1:157680+60*24*6,12:15))*sec_per_ts
    sum(storm(157680+60*24*6+1:157680+91*24*6,1))*sec_per_ts sum(storm(157680+60*24*6+1:157680+91*24*6,2:3))*sec_per_ts sum(storm(157680+60*24*6+1:157680+91*24*6,12:15))*sec_per_ts
    sum(storm(157680+91*24*6+1:157680+121*24*6,1))*sec_per_ts sum(storm(157680+91*24*6+1:157680+121*24*6,2:3))*sec_per_ts sum(storm(157680+91*24*6+1:157680+121*24*6,12:15))*sec_per_ts
    sum(storm(157680+121*24*6+1:157680+152*24*6,1))*sec_per_ts sum(storm(157680+121*24*6+1:157680+152*24*6,2:3))*sec_per_ts sum(storm(157680+121*24*6+1:157680+152*24*6,12:15))*sec_per_ts
    sum(storm(157680+152*24*6+1:157680+182*24*6,1))*sec_per_ts sum(storm(157680+152*24*6+1:157680+182*24*6,2:3))*sec_per_ts sum(storm(157680+152*24*6+1:157680+182*24*6,12:15))*sec_per_ts
    sum(storm(157680+182*24*6+1:157680+213*24*6,1))*sec_per_ts sum(storm(157680+182*24*6+1:157680+213*24*6,2:3))*sec_per_ts sum(storm(157680+182*24*6+1:157680+213*24*6,12:15))*sec_per_ts
    sum(storm(157680+213*24*6+1:157680+244*24*6,1))*sec_per_ts sum(storm(157680+213*24*6+1:157680+244*24*6,2:3))*sec_per_ts sum(storm(157680+213*24*6+1:157680+244*24*6,12:15))*sec_per_ts
    sum(storm(157680+244*24*6+1:157680+274*24*6,1))*sec_per_ts sum(storm(157680+244*24*6+1:157680+274*24*6,2:3))*sec_per_ts sum(storm(157680+244*24*6+1:157680+274*24*6,12:15))*sec_per_ts
    sum(storm(157680+274*24*6+1:157680+305*24*6,1))*sec_per_ts sum(storm(157680+274*24*6+1:157680+305*24*6,2:3))*sec_per_ts sum(storm(157680+274*24*6+1:157680+305*24*6,12:15))*sec_per_ts
    sum(storm(157680+305*24*6+1:157680+335*24*6,1))*sec_per_ts sum(storm(157680+305*24*6+1:157680+335*24*6,2:3))*sec_per_ts sum(storm(157680+305*24*6+1:157680+335*24*6,12:15))*sec_per_ts
    sum(storm(157680+335*24*6+1:157680+366*24*6,1))*sec_per_ts sum(storm(157680+335*24*6+1:157680+366*24*6,2:3))*sec_per_ts sum(storm(157680+335*24*6+1:157680+366*24*6,12:15))*sec_per_ts
    %1997 (+210384 ts)
    sum(storm(210384+1:210384+31*24*6,1))*sec_per_ts sum(storm(210384+1:210384+31*24*6,2:3))*sec_per_ts sum(storm(210384+1:210384+31*24*6,12:15))*sec_per_ts
    sum(storm(210384+31*24*6+1:210384+59*24*6,1))*sec_per_ts sum(storm(210384+31*24*6+1:210384+59*24*6,2:3))*sec_per_ts sum(storm(210384+31*24*6+1:210384+59*24*6,12:15))*sec_per_ts
    sum(storm(210384+59*24*6+1:210384+90*24*6,1))*sec_per_ts sum(storm(210384+59*24*6+1:210384+90*24*6,2:3))*sec_per_ts sum(storm(210384+59*24*6+1:210384+90*24*6,12:15))*sec_per_ts
    sum(storm(210384+90*24*6+1:210384+120*24*6,1))*sec_per_ts sum(storm(210384+90*24*6+1:210384+120*24*6,2:3))*sec_per_ts sum(storm(210384+90*24*6+1:210384+120*24*6,12:15))*sec_per_ts
    sum(storm(210384+120*24*6+1:210384+151*24*6,1))*sec_per_ts sum(storm(210384+120*24*6+1:210384+151*24*6,2:3))*sec_per_ts sum(storm(210384+120*24*6+1:210384+151*24*6,12:15))*sec_per_ts
    sum(storm(210384+151*24*6+1:210384+181*24*6,1))*sec_per_ts sum(storm(210384+151*24*6+1:210384+181*24*6,2:3))*sec_per_ts sum(storm(210384+151*24*6+1:210384+181*24*6,12:15))*sec_per_ts
    sum(storm(210384+181*24*6+1:210384+212*24*6,1))*sec_per_ts sum(storm(210384+181*24*6+1:210384+212*24*6,2:3))*sec_per_ts sum(storm(210384+181*24*6+1:210384+212*24*6,12:15))*sec_per_ts
    sum(storm(210384+212*24*6+1:210384+243*24*6,1))*sec_per_ts sum(storm(210384+212*24*6+1:210384+243*24*6,2:3))*sec_per_ts sum(storm(210384+212*24*6+1:210384+243*24*6,12:15))*sec_per_ts
    sum(storm(210384+243*24*6+1:210384+273*24*6,1))*sec_per_ts sum(storm(210384+243*24*6+1:210384+273*24*6,2:3))*sec_per_ts sum(storm(210384+243*24*6+1:210384+273*24*6,12:15))*sec_per_ts
    sum(storm(210384+273*24*6+1:210384+304*24*6,1))*sec_per_ts sum(storm(210384+273*24*6+1:210384+304*24*6,2:3))*sec_per_ts sum(storm(210384+273*24*6+1:210384+304*24*6,12:15))*sec_per_ts
    sum(storm(210384+304*24*6+1:210384+334*24*6,1))*sec_per_ts sum(storm(210384+304*24*6+1:210384+334*24*6,2:3))*sec_per_ts sum(storm(210384+304*24*6+1:210384+334*24*6,12:15))*sec_per_ts
    sum(storm(210384+334*24*6+1:210384+365*24*6,1))*sec_per_ts sum(storm(210384+334*24*6+1:210384+365*24*6,2:3))*sec_per_ts sum(storm(210384+334*24*6+1:210384+365*24*6,12:15))*sec_per_ts
        %1998 (+262944)
    sum(storm(262944+1:262944+31*24*6,1))*sec_per_ts sum(storm(262944+1:262944+31*24*6,2:3))*sec_per_ts sum(storm(262944+1:262944+31*24*6,12:15))*sec_per_ts
    sum(storm(262944+31*24*6+1:262944+59*24*6,1))*sec_per_ts sum(storm(262944+31*24*6+1:262944+59*24*6,2:3))*sec_per_ts sum(storm(262944+31*24*6+1:262944+59*24*6,12:15))*sec_per_ts
    sum(storm(262944+59*24*6+1:262944+90*24*6,1))*sec_per_ts sum(storm(262944+59*24*6+1:262944+90*24*6,2:3))*sec_per_ts sum(storm(262944+59*24*6+1:262944+90*24*6,12:15))*sec_per_ts
    sum(storm(262944+90*24*6+1:262944+120*24*6,1))*sec_per_ts sum(storm(262944+90*24*6+1:262944+120*24*6,2:3))*sec_per_ts sum(storm(262944+90*24*6+1:262944+120*24*6,12:15))*sec_per_ts
    sum(storm(262944+120*24*6+1:262944+151*24*6,1))*sec_per_ts sum(storm(262944+120*24*6+1:262944+151*24*6,2:3))*sec_per_ts sum(storm(262944+120*24*6+1:262944+151*24*6,12:15))*sec_per_ts
    sum(storm(262944+151*24*6+1:262944+181*24*6,1))*sec_per_ts sum(storm(262944+151*24*6+1:262944+181*24*6,2:3))*sec_per_ts sum(storm(262944+151*24*6+1:262944+181*24*6,12:15))*sec_per_ts
    sum(storm(262944+181*24*6+1:262944+212*24*6,1))*sec_per_ts sum(storm(262944+181*24*6+1:262944+212*24*6,2:3))*sec_per_ts sum(storm(262944+181*24*6+1:262944+212*24*6,12:15))*sec_per_ts
    sum(storm(262944+212*24*6+1:262944+243*24*6,1))*sec_per_ts sum(storm(262944+212*24*6+1:262944+243*24*6,2:3))*sec_per_ts sum(storm(262944+212*24*6+1:262944+243*24*6,12:15))*sec_per_ts
    sum(storm(262944+243*24*6+1:262944+273*24*6,1))*sec_per_ts sum(storm(262944+243*24*6+1:262944+273*24*6,2:3))*sec_per_ts sum(storm(262944+243*24*6+1:262944+273*24*6,12:15))*sec_per_ts
    sum(storm(262944+273*24*6+1:262944+304*24*6,1))*sec_per_ts sum(storm(262944+273*24*6+1:262944+304*24*6,2:3))*sec_per_ts sum(storm(262944+273*24*6+1:262944+304*24*6,12:15))*sec_per_ts
    sum(storm(262944+304*24*6+1:262944+334*24*6,1))*sec_per_ts sum(storm(262944+304*24*6+1:262944+334*24*6,2:3))*sec_per_ts sum(storm(262944+304*24*6+1:262944+334*24*6,12:15))*sec_per_ts
    sum(storm(262944+334*24*6+1:262944+365*24*6,1))*sec_per_ts sum(storm(262944+334*24*6+1:262944+365*24*6,2:3))*sec_per_ts sum(storm(262944+334*24*6+1:262944+365*24*6,12:15))*sec_per_ts
    %1999 (+315504 ts)
    sum(storm(315504+1:315504+31*24*6,1))*sec_per_ts sum(storm(315504+1:315504+31*24*6,2:3))*sec_per_ts sum(storm(315504+1:315504+31*24*6,12:15))*sec_per_ts
    sum(storm(315504+31*24*6+1:315504+59*24*6,1))*sec_per_ts sum(storm(315504+31*24*6+1:315504+59*24*6,2:3))*sec_per_ts sum(storm(315504+31*24*6+1:315504+59*24*6,12:15))*sec_per_ts
    sum(storm(315504+59*24*6+1:315504+90*24*6,1))*sec_per_ts sum(storm(315504+59*24*6+1:315504+90*24*6,2:3))*sec_per_ts sum(storm(315504+59*24*6+1:315504+90*24*6,12:15))*sec_per_ts
    sum(storm(315504+90*24*6+1:315504+120*24*6,1))*sec_per_ts sum(storm(315504+90*24*6+1:315504+120*24*6,2:3))*sec_per_ts sum(storm(315504+90*24*6+1:315504+120*24*6,12:15))*sec_per_ts
    sum(storm(315504+120*24*6+1:315504+151*24*6,1))*sec_per_ts sum(storm(315504+120*24*6+1:315504+151*24*6,2:3))*sec_per_ts sum(storm(315504+120*24*6+1:315504+151*24*6,12:15))*sec_per_ts
    sum(storm(315504+151*24*6+1:315504+181*24*6,1))*sec_per_ts sum(storm(315504+151*24*6+1:315504+181*24*6,2:3))*sec_per_ts sum(storm(315504+151*24*6+1:315504+181*24*6,12:15))*sec_per_ts
    sum(storm(315504+181*24*6+1:315504+212*24*6,1))*sec_per_ts sum(storm(315504+181*24*6+1:315504+212*24*6,2:3))*sec_per_ts sum(storm(315504+181*24*6+1:315504+212*24*6,12:15))*sec_per_ts
    sum(storm(315504+212*24*6+1:315504+243*24*6,1))*sec_per_ts sum(storm(315504+212*24*6+1:315504+243*24*6,2:3))*sec_per_ts sum(storm(315504+212*24*6+1:315504+243*24*6,12:15))*sec_per_ts
    sum(storm(315504+243*24*6+1:315504+273*24*6,1))*sec_per_ts sum(storm(315504+243*24*6+1:315504+273*24*6,2:3))*sec_per_ts sum(storm(315504+243*24*6+1:315504+273*24*6,12:15))*sec_per_ts
    sum(storm(315504+273*24*6+1:315504+304*24*6,1))*sec_per_ts sum(storm(315504+273*24*6+1:315504+304*24*6,2:3))*sec_per_ts sum(storm(315504+273*24*6+1:315504+304*24*6,12:15))*sec_per_ts
    sum(storm(315504+304*24*6+1:315504+334*24*6,1))*sec_per_ts sum(storm(315504+304*24*6+1:315504+334*24*6,2:3))*sec_per_ts sum(storm(315504+304*24*6+1:315504+334*24*6,12:15))*sec_per_ts
    sum(storm(315504+334*24*6+1:315504+365*24*6,1))*sec_per_ts sum(storm(315504+334*24*6+1:315504+365*24*6,2:3))*sec_per_ts sum(storm(315504+334*24*6+1:315504+365*24*6,12:15))*sec_per_ts
    %2000, skott�r (+368064 ts)
    sum(storm(368064+1:368064+31*24*6,1))*sec_per_ts sum(storm(368064+1:368064+31*24*6,2:3))*sec_per_ts sum(storm(368064+1:368064+31*24*6,12:15))*sec_per_ts
    sum(storm(368064+31*24*6+1:368064+60*24*6,1))*sec_per_ts sum(storm(368064+31*24*6+1:368064+60*24*6,2:3))*sec_per_ts sum(storm(368064+31*24*6+1:368064+60*24*6,12:15))*sec_per_ts
    sum(storm(368064+60*24*6+1:368064+91*24*6,1))*sec_per_ts sum(storm(368064+60*24*6+1:368064+91*24*6,2:3))*sec_per_ts sum(storm(368064+60*24*6+1:368064+91*24*6,12:15))*sec_per_ts
    sum(storm(368064+91*24*6+1:368064+121*24*6,1))*sec_per_ts sum(storm(368064+91*24*6+1:368064+121*24*6,2:3))*sec_per_ts sum(storm(368064+91*24*6+1:368064+121*24*6,12:15))*sec_per_ts
    sum(storm(368064+121*24*6+1:368064+152*24*6,1))*sec_per_ts sum(storm(368064+121*24*6+1:368064+152*24*6,2:3))*sec_per_ts sum(storm(368064+121*24*6+1:368064+152*24*6,12:15))*sec_per_ts
    sum(storm(368064+152*24*6+1:368064+182*24*6,1))*sec_per_ts sum(storm(368064+152*24*6+1:368064+182*24*6,2:3))*sec_per_ts sum(storm(368064+152*24*6+1:368064+182*24*6,12:15))*sec_per_ts
    sum(storm(368064+182*24*6+1:368064+213*24*6,1))*sec_per_ts sum(storm(368064+182*24*6+1:368064+213*24*6,2:3))*sec_per_ts sum(storm(368064+182*24*6+1:368064+213*24*6,12:15))*sec_per_ts
    sum(storm(368064+213*24*6+1:368064+244*24*6,1))*sec_per_ts sum(storm(368064+213*24*6+1:368064+244*24*6,2:3))*sec_per_ts sum(storm(368064+213*24*6+1:368064+244*24*6,12:15))*sec_per_ts
    sum(storm(368064+244*24*6+1:368064+274*24*6,1))*sec_per_ts sum(storm(368064+244*24*6+1:368064+274*24*6,2:3))*sec_per_ts sum(storm(368064+244*24*6+1:368064+274*24*6,12:15))*sec_per_ts
    sum(storm(368064+274*24*6+1:368064+305*24*6,1))*sec_per_ts sum(storm(368064+274*24*6+1:368064+305*24*6,2:3))*sec_per_ts sum(storm(368064+274*24*6+1:368064+305*24*6,12:15))*sec_per_ts
    sum(storm(368064+305*24*6+1:368064+335*24*6,1))*sec_per_ts sum(storm(368064+305*24*6+1:368064+335*24*6,2:3))*sec_per_ts sum(storm(368064+305*24*6+1:368064+335*24*6,12:15))*sec_per_ts
    sum(storm(368064+335*24*6+1:368064+366*24*6,1))*sec_per_ts sum(storm(368064+335*24*6+1:368064+366*24*6,2:3))*sec_per_ts sum(storm(368064+335*24*6+1:368064+366*24*6,12:15))*sec_per_ts
    %2001 (+420768 ts)
    sum(storm(420768+1:420768+31*24*6,1))*sec_per_ts sum(storm(420768+1:420768+31*24*6,2:3))*sec_per_ts sum(storm(420768+1:420768+31*24*6,12:15))*sec_per_ts
    sum(storm(420768+31*24*6+1:420768+59*24*6,1))*sec_per_ts sum(storm(420768+31*24*6+1:420768+59*24*6,2:3))*sec_per_ts sum(storm(420768+31*24*6+1:420768+59*24*6,12:15))*sec_per_ts
    sum(storm(420768+59*24*6+1:420768+90*24*6,1))*sec_per_ts sum(storm(420768+59*24*6+1:420768+90*24*6,2:3))*sec_per_ts sum(storm(420768+59*24*6+1:420768+90*24*6,12:15))*sec_per_ts
    sum(storm(420768+90*24*6+1:420768+120*24*6,1))*sec_per_ts sum(storm(420768+90*24*6+1:420768+120*24*6,2:3))*sec_per_ts sum(storm(420768+90*24*6+1:420768+120*24*6,12:15))*sec_per_ts
    sum(storm(420768+120*24*6+1:420768+151*24*6,1))*sec_per_ts sum(storm(420768+120*24*6+1:420768+151*24*6,2:3))*sec_per_ts sum(storm(420768+120*24*6+1:420768+151*24*6,12:15))*sec_per_ts
    sum(storm(420768+151*24*6+1:420768+181*24*6,1))*sec_per_ts sum(storm(420768+151*24*6+1:420768+181*24*6,2:3))*sec_per_ts sum(storm(420768+151*24*6+1:420768+181*24*6,12:15))*sec_per_ts
    sum(storm(420768+181*24*6+1:420768+212*24*6,1))*sec_per_ts sum(storm(420768+181*24*6+1:420768+212*24*6,2:3))*sec_per_ts sum(storm(420768+181*24*6+1:420768+212*24*6,12:15))*sec_per_ts
    sum(storm(420768+212*24*6+1:420768+243*24*6,1))*sec_per_ts sum(storm(420768+212*24*6+1:420768+243*24*6,2:3))*sec_per_ts sum(storm(420768+212*24*6+1:420768+243*24*6,12:15))*sec_per_ts
    sum(storm(420768+243*24*6+1:420768+273*24*6,1))*sec_per_ts sum(storm(420768+243*24*6+1:420768+273*24*6,2:3))*sec_per_ts sum(storm(420768+243*24*6+1:420768+273*24*6,12:15))*sec_per_ts
    sum(storm(420768+273*24*6+1:420768+304*24*6,1))*sec_per_ts sum(storm(420768+273*24*6+1:420768+304*24*6,2:3))*sec_per_ts sum(storm(420768+273*24*6+1:420768+304*24*6,12:15))*sec_per_ts
    sum(storm(420768+304*24*6+1:420768+334*24*6,1))*sec_per_ts sum(storm(420768+304*24*6+1:420768+334*24*6,2:3))*sec_per_ts sum(storm(420768+304*24*6+1:420768+334*24*6,12:15))*sec_per_ts
    sum(storm(420768+334*24*6+1:420768+365*24*6,1))*sec_per_ts sum(storm(420768+334*24*6+1:420768+365*24*6,2:3))*sec_per_ts sum(storm(420768+334*24*6+1:420768+365*24*6,12:15))*sec_per_ts
    %2002 (+473328 ts)
    sum(storm(473328+1:473328+31*24*6,1))*sec_per_ts sum(storm(473328+1:473328+31*24*6,2:3))*sec_per_ts sum(storm(473328+1:473328+31*24*6,12:15))*sec_per_ts
    sum(storm(473328+31*24*6+1:473328+59*24*6,1))*sec_per_ts sum(storm(473328+31*24*6+1:473328+59*24*6,2:3))*sec_per_ts sum(storm(473328+31*24*6+1:473328+59*24*6,12:15))*sec_per_ts
    sum(storm(473328+59*24*6+1:473328+90*24*6,1))*sec_per_ts sum(storm(473328+59*24*6+1:473328+90*24*6,2:3))*sec_per_ts sum(storm(473328+59*24*6+1:473328+90*24*6,12:15))*sec_per_ts
    sum(storm(473328+90*24*6+1:473328+120*24*6,1))*sec_per_ts sum(storm(473328+90*24*6+1:473328+120*24*6,2:3))*sec_per_ts sum(storm(473328+90*24*6+1:473328+120*24*6,12:15))*sec_per_ts
    sum(storm(473328+120*24*6+1:473328+151*24*6,1))*sec_per_ts sum(storm(473328+120*24*6+1:473328+151*24*6,2:3))*sec_per_ts sum(storm(473328+120*24*6+1:473328+151*24*6,12:15))*sec_per_ts
    sum(storm(473328+151*24*6+1:473328+181*24*6,1))*sec_per_ts sum(storm(473328+151*24*6+1:473328+181*24*6,2:3))*sec_per_ts sum(storm(473328+151*24*6+1:473328+181*24*6,12:15))*sec_per_ts
    sum(storm(473328+181*24*6+1:473328+212*24*6,1))*sec_per_ts sum(storm(473328+181*24*6+1:473328+212*24*6,2:3))*sec_per_ts sum(storm(473328+181*24*6+1:473328+212*24*6,12:15))*sec_per_ts
    sum(storm(473328+212*24*6+1:473328+243*24*6,1))*sec_per_ts sum(storm(473328+212*24*6+1:473328+243*24*6,2:3))*sec_per_ts sum(storm(473328+212*24*6+1:473328+243*24*6,12:15))*sec_per_ts
    sum(storm(473328+243*24*6+1:473328+273*24*6,1))*sec_per_ts sum(storm(473328+243*24*6+1:473328+273*24*6,2:3))*sec_per_ts sum(storm(473328+243*24*6+1:473328+273*24*6,12:15))*sec_per_ts
    sum(storm(473328+273*24*6+1:473328+304*24*6,1))*sec_per_ts sum(storm(473328+273*24*6+1:473328+304*24*6,2:3))*sec_per_ts sum(storm(473328+273*24*6+1:473328+304*24*6,12:15))*sec_per_ts
    sum(storm(473328+304*24*6+1:473328+334*24*6,1))*sec_per_ts sum(storm(473328+304*24*6+1:473328+334*24*6,2:3))*sec_per_ts sum(storm(473328+304*24*6+1:473328+334*24*6,12:15))*sec_per_ts
    sum(storm(473328+334*24*6+1:473328+365*24*6,1))*sec_per_ts sum(storm(473328+334*24*6+1:473328+365*24*6,2:3))*sec_per_ts sum(storm(473328+334*24*6+1:473328+365*24*6,12:15))*sec_per_ts
    %2003 (+525888 ts)
    sum(storm(525888+1:525888+31*24*6,1))*sec_per_ts sum(storm(525888+1:525888+31*24*6,2:3))*sec_per_ts sum(storm(525888+1:525888+31*24*6,12:15))*sec_per_ts
    sum(storm(525888+31*24*6+1:525888+59*24*6,1))*sec_per_ts sum(storm(525888+31*24*6+1:525888+59*24*6,2:3))*sec_per_ts sum(storm(525888+31*24*6+1:525888+59*24*6,12:15))*sec_per_ts
    sum(storm(525888+59*24*6+1:525888+90*24*6,1))*sec_per_ts sum(storm(525888+59*24*6+1:525888+90*24*6,2:3))*sec_per_ts sum(storm(525888+59*24*6+1:525888+90*24*6,12:15))*sec_per_ts
    sum(storm(525888+90*24*6+1:525888+120*24*6,1))*sec_per_ts sum(storm(525888+90*24*6+1:525888+120*24*6,2:3))*sec_per_ts sum(storm(525888+90*24*6+1:525888+120*24*6,12:15))*sec_per_ts
    sum(storm(525888+120*24*6+1:525888+151*24*6,1))*sec_per_ts sum(storm(525888+120*24*6+1:525888+151*24*6,2:3))*sec_per_ts sum(storm(525888+120*24*6+1:525888+151*24*6,12:15))*sec_per_ts
    sum(storm(525888+151*24*6+1:525888+181*24*6,1))*sec_per_ts sum(storm(525888+151*24*6+1:525888+181*24*6,2:3))*sec_per_ts sum(storm(525888+151*24*6+1:525888+181*24*6,12:15))*sec_per_ts
    sum(storm(525888+181*24*6+1:525888+212*24*6,1))*sec_per_ts sum(storm(525888+181*24*6+1:525888+212*24*6,2:3))*sec_per_ts sum(storm(525888+181*24*6+1:525888+212*24*6,12:15))*sec_per_ts
    sum(storm(525888+212*24*6+1:525888+243*24*6,1))*sec_per_ts sum(storm(525888+212*24*6+1:525888+243*24*6,2:3))*sec_per_ts sum(storm(525888+212*24*6+1:525888+243*24*6,12:15))*sec_per_ts
    sum(storm(525888+243*24*6+1:525888+273*24*6,1))*sec_per_ts sum(storm(525888+243*24*6+1:525888+273*24*6,2:3))*sec_per_ts sum(storm(525888+243*24*6+1:525888+273*24*6,12:15))*sec_per_ts
    sum(storm(525888+273*24*6+1:525888+304*24*6,1))*sec_per_ts sum(storm(525888+273*24*6+1:525888+304*24*6,2:3))*sec_per_ts sum(storm(525888+273*24*6+1:525888+304*24*6,12:15))*sec_per_ts
    sum(storm(525888+304*24*6+1:525888+334*24*6,1))*sec_per_ts sum(storm(525888+304*24*6+1:525888+334*24*6,2:3))*sec_per_ts sum(storm(525888+304*24*6+1:525888+334*24*6,12:15))*sec_per_ts
    sum(storm(525888+334*24*6+1:525888+365*24*6,1))*sec_per_ts sum(storm(525888+334*24*6+1:525888+365*24*6,2:3))*sec_per_ts sum(storm(525888+334*24*6+1:525888+365*24*6,12:15))*sec_per_ts
];