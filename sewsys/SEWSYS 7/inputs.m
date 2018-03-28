%File inputs.m 
%This file collects the input from SEWSYS' Main Window, runs when "Simulate" button is pushed
%Stefan Ahlman
%2000-02-23

%SEWSYS Main window input

%Timevariables
HH = findobj(gcf,'Tag','days');                                                                                                                                                                                        
in_days=str2num(get(HH, 'String'));                                                                                                                                                                                       
HH = findobj(gcf,'Tag','Sec_per_ts');                                                                                                                                                                                        
in_sec_per_ts=str2num(get(HH, 'String'));                                                                                                                                                                                       
HH = findobj(gcf,'Tag','timesteps');                                                                                                                                                                                         
in_T=str2num(get(HH, 'String'));

%Sanitary wastewater
HH = findobj(gcf,'Tag','persons');                                                                                                                                                                                           
in_numberOfPersons=str2num(get(HH, 'String'));                                                                                                                                                                                  
HH = findobj(gcf,'Tag','drain');                                                                                                                                                                                             
in_DrainageWaterFactor=str2num(get(HH, 'String'));                                                                                                                                                                              

%Industry
HH = findobj(gcf,'Tag','ind_flow');                                                                                                                                                                                          
in_IndustryWater=str2num(get(HH, 'String'));   
HH = findobj(gcf,'Tag','ind_P');                                                                                                                                                                                          
in_P_totIndustry=str2num(get(HH, 'String'));
HH = findobj(gcf,'Tag','ind_N');                                                                                                                                                                                          
in_N_totIndustry=str2num(get(HH, 'String'));
HH = findobj(gcf,'Tag','ind_NH4');                                                                                                                                                                                          
in_N_NH3_NH4_Industry=str2num(get(HH, 'String'));
HH = findobj(gcf,'Tag','ind_NO3');                                                                                                                                                                                          
in_N_NO3_Industry=str2num(get(HH, 'String'));
HH = findobj(gcf,'Tag','ind_SS');                                                                                                                                                                                          
in_SSIndustry=str2num(get(HH, 'String'));
HH = findobj(gcf,'Tag','ind_BOD');                                                                                                                                                                                          
in_BODIndustry=str2num(get(HH, 'String'));
HH = findobj(gcf,'Tag','ind_COD');                                                                                                                                                                                          
in_CODIndustry=str2num(get(HH, 'String'));
HH = findobj(gcf,'Tag','ind_Ctot');                                                                                                                                                                                          
in_C_totIndustry=str2num(get(HH, 'String'));
HH = findobj(gcf,'Tag','ind_Cu');                                                                                                                                                                                          
in_CuIndustry=str2num(get(HH, 'String'));
HH = findobj(gcf,'Tag','ind_Zn');                                                                                                                                                                                          
in_ZnIndustry=str2num(get(HH, 'String'));
HH = findobj(gcf,'Tag','ind_Pb');                                                                                                                                                                                          
in_PbIndustry=str2num(get(HH, 'String'));
HH = findobj(gcf,'Tag','ind_Cd');                                                                                                                                                                                          
in_CdIndustry=str2num(get(HH, 'String'));
HH = findobj(gcf,'Tag','ind_Hg');                                                                                                                                                                                          
in_HgIndustry=str2num(get(HH, 'String'));
HH = findobj(gcf,'Tag','ind_Cr');                                                                                                                                                                                          
in_CrIndustry=str2num(get(HH, 'String'));
HH = findobj(gcf,'Tag','ind_PAH');                                                                                                                                                                                          
in_PAHIndustry=str2num(get(HH, 'String'));

%Storm water
HH = findobj(gcf,'Tag','totarea');                                                                                                                                                                                          
in_tota=str2num(get(HH, 'String'));
if in_tota==0
   in_tota=1;
end
HH = findobj(gcf,'Tag','roads');                                                                                                                                                                                          
in_roads=str2num(get(HH, 'String'));
HH = findobj(gcf,'Tag','roofs');                                                                                                                                                                                          
in_roofs=str2num(get(HH, 'String'));
HH = findobj(gcf,'Tag','otherarea');                                                                                                                                                                                          
in_otherarea=str2num(get(HH, 'String'));
HH = findobj(gcf,'Tag','roadZna');                                                                                                                                                                                          
in_part_roadZna=str2num(get(HH, 'String'));
HH = findobj(gcf,'Tag','roofZna');                                                                                                                                                                                          
in_part_roofZna=str2num(get(HH, 'String'));
HH = findobj(gcf,'Tag','roofCua');                                                                                                                                                                                          
in_part_roofCua=str2num(get(HH, 'String'));
HH = findobj(gcf,'Tag','yearlyrain');
in_yearly_rain=str2num(get(HH, 'String'));
HH = findobj(gcf,'Tag','vehiclekmday');
in_fkmday=str2num(get(HH, 'String'));
HH = findobj(gcf,'Tag','heavyvehicles');
in_nhv=str2num(get(HH, 'String'));
HH = findobj(gcf,'Tag','base');
baseflow=str2num(get(HH, 'String'));

%CSO
HH = findobj(gcf,'Tag','CSO_limit');                                                                                                                                                                                          
in_CSO_limit=str2num(get(HH, 'String'));




