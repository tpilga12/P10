%File raininfo.m
%PARAMETERS FOR RAIN DATA
%this file is a modified version from Engvall's model
%loaded from file: prep.m
%Stefan Ahlman
%2000-02-23

%Rain/yr in area:(mm)
yearly_rain=in_yearly_rain;

%rain data given in um/s, models mm/timestep
U2=rain/1000*sec_per_ts;


