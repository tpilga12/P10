%File cal_inputs.m 
%This files collects the parameters needed for the calibration process
%Stefan Ahlman
%2000-02-23

%Timevariables
HH = findobj(gcf,'Tag','raindur');                                                                                                                                                                                         
in_Trd=str2num(get(HH, 'String'));
HH = findobj(gcf,'Tag','tafter');                                                                                                                                                                                         
in_Ta=str2num(get(HH, 'String'));
HH = findobj(gcf,'Tag','Sec_per_ts');                                                                                                                                                                                        
in_sec_per_ts=str2num(get(HH, 'String'));
HH = findobj(gcf,'Tag','rainint');                                                                                                                                                                                        
in_rainint=str2num(get(HH, 'String'));

%Sanitary wastewater
HH = findobj('Tag','persons');                                                                                                                                                                                           
in_numberOfPersons=str2num(get(HH, 'String'));                                                                                                                                                                                  
HH = findobj('Tag','drain');                                                                                                                                                                                             
in_DrainageWaterFactor=str2num(get(HH, 'String'));                                                                                                                                                                              

%Industry
HH = findobj('Tag','ind_flow');                                                                                                                                                                                          
in_IndustryWater=str2num(get(HH, 'String'));   
HH = findobj('Tag','ind_P');                                                                                                                                                                                          
in_P_totIndustry=str2num(get(HH, 'String'));
HH = findobj('Tag','ind_N');                                                                                                                                                                                          
in_N_totIndustry=str2num(get(HH, 'String'));
HH = findobj('Tag','ind_NH4');                                                                                                                                                                                          
in_N_NH3_NH4_Industry=str2num(get(HH, 'String'));
HH = findobj('Tag','ind_NO3');                                                                                                                                                                                          
in_N_NO3_Industry=str2num(get(HH, 'String'));
HH = findobj('Tag','ind_SS');                                                                                                                                                                                          
in_SSIndustry=str2num(get(HH, 'String'));
HH = findobj('Tag','ind_BOD');                                                                                                                                                                                          
in_BODIndustry=str2num(get(HH, 'String'));
HH = findobj('Tag','ind_COD');                                                                                                                                                                                          
in_CODIndustry=str2num(get(HH, 'String'));
HH = findobj('Tag','ind_Ctot');                                                                                                                                                                                          
in_C_totIndustry=str2num(get(HH, 'String'));
HH = findobj('Tag','ind_Cu');                                                                                                                                                                                          
in_CuIndustry=str2num(get(HH, 'String'));
HH = findobj('Tag','ind_Zn');                                                                                                                                                                                          
in_ZnIndustry=str2num(get(HH, 'String'));
HH = findobj('Tag','ind_Pb');                                                                                                                                                                                          
in_PbIndustry=str2num(get(HH, 'String'));
HH = findobj('Tag','ind_Cd');                                                                                                                                                                                          
in_CdIndustry=str2num(get(HH, 'String'));
HH = findobj('Tag','ind_Hg');                                                                                                                                                                                          
in_HgIndustry=str2num(get(HH, 'String'));
HH = findobj('Tag','ind_Cr');                                                                                                                                                                                          
in_CrIndustry=str2num(get(HH, 'String'));
HH = findobj('Tag','ind_Cr');                                                                                                                                                                                          
in_PAHIndustry=str2num(get(HH, 'String'));

%Storm water
HH = findobj('Tag','totarea');                                                                                                                                                                                          
in_tota=str2num(get(HH, 'String'));
if in_tota==0
   in_tota=1;
end
HH = findobj('Tag','roads');                                                                                                                                                                                          
in_roads=str2num(get(HH, 'String'));
HH = findobj('Tag','roofs');                                                                                                                                                                                          
in_roofs=str2num(get(HH, 'String'));
HH = findobj('Tag','otherarea');                                                                                                                                                                                          
in_otherarea=str2num(get(HH, 'String'));
HH = findobj('Tag','roadZna');                                                                                                                                                                                          
in_part_roadZna=str2num(get(HH, 'String'));
HH = findobj('Tag','roofZna');                                                                                                                                                                                          
in_part_roofZna=str2num(get(HH, 'String'));
HH = findobj('Tag','roofCua');                                                                                                                                                                                          
in_part_roofCua=str2num(get(HH, 'String'));
HH = findobj('Tag','yearlyrain');
in_yearly_rain=str2num(get(HH, 'String'));
if in_yearly_rain==0
   in_yearly_rain=1;
end
HH = findobj('Tag','vehiclekmday');
in_fkmday=str2num(get(HH, 'String'));
HH = findobj('Tag','heavyvehicles');
in_nhv=str2num(get(HH, 'String'));
HH = findobj('Tag','base');
baseflow=str2num(get(HH, 'String'));

%CSO
HH = findobj('Tag','CSO_limit');                                                                                                                                                                                          
in_CSO_limit=str2num(get(HH, 'String'));

%Runoff
HH = findobj('Tag','calpar');                                                                                                                                                                                          
in_K=str2num(get(HH, 'String'));




