clear U1                                                                                                                                                                                                                                                                                                                                                  
clear U2                                                                                                                                                                                                                                                                                                                                                  
HH = findobj(gcf,'Tag','Sec_per_ts');                                                                                                                                                                                                                                                                                                                     
if str2num(get(HH, 'String'))==0                                                                                                                                                                                                                                                                                                                          
   ERRORDLG('The Edit box "Seconds per Timestep" is zero!','Simulation Error')                                                                                                                                                                                                                                                                            
else                                                                                                                                                                                                                                                                                                                                                      
   inputs; %load input from SEWSYS' Main window                                                                                                                                                                                                                                                                                                           
   prep; % load Prep.m                                                                                                                                                                                                                                                                                                                                    
   if stormw==1 %run with stormwater                                                                                                                                                                                                                                                                                                                      
      if K==0                                                                                                                                                                                                                                                                                                                                             
         ERRORDLG('You must first calibrate the Reservoir parameter!','Simulation Error')                                                                                                                                                                                                                                                                 
      else                                                                                                                                                                                                                                                                                                                                                
         if in_yearly_rain==0                                                                                                                                                                                                                                                                                                                             
            ERRORDLG('The rain depth is zero! Must be present in order to calculate wet deposition.','Simulation Error')                                                                                                                                                                                                                                  
         else                                                                                                                                                                                                                                                                                                                                             
            if size(T)==size(U2) %check timesteps against chosen rain                                                                                                                                                                                                                                                                                     
               if sani==0 %run only with stormwater, no sanitary wastewater                                                                                                                                                                                                                                                                               
                  U1=zeros(size(T));                                                                                                                                                                                                                                                                                                                      
                  simulink                                                                                                                                                                                                                                                                                                                                
                  if com==1 %Check which model to open                                                                                                                                                                                                                                                                                                    
                     open_system('SEWSYS_Combined')                                                                                                                                                                                                                                                                                                       
                     set_param('SEWSYS_Combined','Stoptime', 'Q')                                                                                                                                                                                                                                                                                         
                     sim('SEWSYS_Combined')                                                                                                                                                                                                                                                                                                               
                  else                                                                                                                                                                                                                                                                                                                                    
                     open_system('SEWSYS_Duplicate')                                                                                                                                                                                                                                                                                                      
                     set_param('SEWSYS_Duplicate','Stoptime', 'Q')                                                                                                                                                                                                                                                                                        
                     sim('SEWSYS_Duplicate')                                                                                                                                                                                                                                                                                                              
                  end                                                                                                                                                                                                                                                                                                                                     
                  WARNDLG('Simulation is ready, push Results button to see some nice plots!','SEWSYS Message')                                                                                                                                                                                                                                            
               else %stormwater and sanitary wastewater                                                                                                                                                                                                                                                                                                   
                  simulink                                                                                                                                                                                                                                                                                                                                
                  if com==1                                                                                                                                                                                                                                                                                                                               
                     open_system('SEWSYS_Combined')                                                                                                                                                                                                                                                                                                       
                     set_param('SEWSYS_Combined','Stoptime', 'Q')                                                                                                                                                                                                                                                                                         
                     sim('SEWSYS_Combined')                                                                                                                                                                                                                                                                                                               
                  elseif com==0                                                                                                                                                                                                                                                                                                                                   
                     open_system('SEWSYS_Duplicate')                                                                                                                                                                                                                                                                                                      
                     set_param('SEWSYS_Duplicate','Stoptime', 'Q')                                                                                                                                                                                                                                                                                        
                     sim('SEWSYS_Duplicate')
                 else
                     HH = findobj(gcf,'Tag','othersystem');                                                                                                                                                                                                                                            
                     String=get(HH, 'String');
                     open_system(String)                                                                                                                                                                                                                                                                                                      
                     set_param(String,'Stoptime', 'Q')                                                                                                                                                                                                                                                                                        
                     sim(String)
                  end                                                                                                                                                                                                                                                                                                                                     
                  WARNDLG('Simulation is ready, push Results button to see some nice plots!','SEWSYS Message')                                                                                                                                                                                                                                            
               end                                                                                                                                                                                                                                                                                                                                        
            else                                                                                                                                                                                                                                                                                                                                          
               ERRORDLG('Mismatch between number of timesteps and chosen rain!','Simulation Error')                                                                                                                                                                                                                                                       
            end                                                                                                                                                                                                                                                                                                                                           
         end                                                                                                                                                                                                                                                                                                                                              
         simrun=1; %to state that simulation has been made                                                                                                                                                                                                                                                                                                
      end                                                                                                                                                                                                                                                                                                                                                 
   else %run only with sanitary wastewater                                                                                                                                                                                                                                                                                                                
      rain=zeros(size(T));                                                                                                                                                                                                                                                                                                                                
      raininfo;                                                                                                                                                                                                                                                                                                                                           
      yearly_rain=1; %to avoid division with zero                                                                                                                                                                                                                                                                                                         
      simulink                                                                                                                                                                                                                                                                                                                                            
      if com==1 %Check which model to open                                                                                                                                                                                                                                                                                                                
         open_system('SEWSYS_Combined')                                                                                                                                                                                                                                                                                                                   
         set_param('SEWSYS_Combined','Stoptime', 'Q')                                                                                                                                                                                                                                                                                                     
         sim('SEWSYS_Combined')                                                                                                                                                                                                                                                                                                                           
      else                                                                                                                                                                                                                                                                                                                                                
         open_system('SEWSYS_Duplicate')                                                                                                                                                                                                                                                                                                                  
         set_param('SEWSYS_Duplicate','Stoptime', 'Q')                                                                                                                                                                                                                                                                                                    
         sim('SEWSYS_Duplicate')                                                                                                                                                                                                                                                                                                                          
      end                                                                                                                                                                                                                                                                                                                                                 
      simrun=1; %to state that simulation has been made                                                                                                                                                                                                                                                                                                   
      WARNDLG('Simulation is ready, push Results button to see some nice plots!','SEWSYS Message')                                                                                                                                                                                                                                                        
   end                                                                                                                                                                                                                                                                                                                                                    
end             