function varargout = SEWSYS_fig(varargin)
% SEWSYS_FIG Application M-file for SEWSYS_fig.fig
%    FIG = SEWSYS_FIG launch SEWSYS_fig GUI.
%    SEWSYS_FIG('callback_name', ...) invoke the named callback.

% Last Modified by GUIDE v2.5 20-Apr-2005 13:07:05

if nargin == 0  % LAUNCH GUI

	fig = openfig(mfilename,'reuse');

% Use system color scheme for figure:
set(fig,'Color',get(0,'DefaultUicontrolBackgroundColor'));

	% Generate a structure of handles to pass to callbacks, and store it. 
	handles = guihandles(fig);
	guidata(fig, handles);

	if nargout > 0
		varargout{1} = fig;
	end

elseif ischar(varargin{1}) % INVOKE NAMED SUBFUNCTION OR CALLBACK

	try
		[varargout{1:nargout}] = feval(varargin{:}); % FEVAL switchyard
	catch
		disp(lasterr);
	end

end


%| ABOUT CALLBACKS:
%| GUIDE automatically appends subfunction prototypes to this file, and 
%| sets objects' callback properties to call them through the FEVAL 
%| switchyard above. This comment describes that mechanism.
%|
%| Each callback subfunction declaration has the following form:
%| <SUBFUNCTION_NAME>(H, EVENTDATA, HANDLES, VARARGIN)
%|
%| The subfunction name is composed using the object's Tag and the 
%| callback type separated by '_', e.g. 'slider2_Callback',
%| 'figure1_CloseRequestFcn', 'axis1_ButtondownFcn'.
%|
%| H is the callback object's handle (obtained using GCBO).
%|
%| EVENTDATA is empty, but reserved for future use.
%|
%| HANDLES is a structure containing handles of components in GUI using
%| tags as fieldnames, e.g. handles.figure1, handles.slider2. This
%| structure is created at GUI startup using GUIHANDLES and stored in
%| the figure's application data using GUIDATA. A copy of the structure
%| is passed to each callback.  You can store additional information in
%| this structure at GUI startup, and you can change the structure
%| during callbacks.  Call guidata(h, handles) after changing your
%| copy to replace the stored original so that subsequent callbacks see
%| the updates. Type "help guihandles" and "help guidata" for more
%| information.
%|
%| VARARGIN contains any extra arguments you have passed to the
%| callback. Specify the extra arguments by editing the callback
%| property in the inspector. By default, GUIDE sets the property to:
%| <MFILENAME>('<SUBFUNCTION_NAME>', gcbo, [], guidata(gcbo))
%| Add any extra arguments after the last argument, before the final
%| closing parenthesis.




% --------------------------------------------------------------------
function varargout = days_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.days.
HH = findobj(gcf,'Tag','days');                                                                                                                                                                                                                                                     
in_days=str2num(get(HH, 'String'));                                                                                                                                                                                                                                                 
HH = findobj(gcf,'Tag','Sec_per_ts');                                                                                                                                                                                                                                               
in_sec_per_ts=str2num(get(HH, 'String'));                                                                                                                                                                                                                                           
                                                                                                                                                                                                                                                                                    
if in_days==0                                                                                                                                                                                                                                                                       
   HH = findobj(gcf,'Tag','timesteps');                                                                                                                                                                                                                                             
   set(HH, 'enable', 'on');                                                                                                                                                                                                                                                         
   HH = findobj(gcf,'Tag','Checkbox1');                                                                                                                                                                                                                                             
   set(HH, 'value', 0);                                                                                                                                                                                                                                                             
   set(HH, 'enable', 'off');                                                                                                                                                                                                                                                        
   assignin('base', 'sani', 0);                                                                                                                                                                                                                                                                          
else                                                                                                                                                                                                                                                                                
   timesteps=in_days*86400/in_sec_per_ts;                                                                                                                                                                                                                                           
   HH= findobj(gcf,'Tag','timesteps');                                                                                                                                                                                                                                              
   set(HH, 'String', num2str(timesteps));                                                                                                                                                                                                                                           
   set(HH, 'enable', 'off');                                                                                                                                                                                                                                                        
   HH = findobj(gcf,'Tag','Checkbox1');                                                                                                                                                                                                                                             
   set(HH, 'enable', 'on');                                                                                                                                                                                                                                                         
   set(HH, 'value', 1);                                                                                                                                                                                                                                                             
   assignin('base', 'sani', 1);                                                                                                                                                                                                                                                                          
end                                                                                                                                                                                                                                                                                 
                                                                                                                                                                                                                                                                                    


% --------------------------------------------------------------------
function varargout = Sec_per_ts_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.Sec_per_ts.
HH = findobj(gcf,'Tag','days');                                                                                                                                                                                                                                                  
in_days=str2num(get(HH, 'String'));                                                                                                                                                                                                                                              
HH = findobj(gcf,'Tag','Sec_per_ts');                                                                                                                                                                                                                                            
in_sec_per_ts=str2num(get(HH, 'String'));                                                                                                                                                                                                                                        
                                                                                                                                                                                                                                                                                 
if in_days~=0                                                                                                                                                                                                                                                                    
   timesteps=in_days*86400/in_sec_per_ts;                                                                                                                                                                                                                                        
   HH= findobj(gcf,'Tag','timesteps');                                                                                                                                                                                                                                           
   set(HH, 'String', num2str(timesteps));                                                                                                                                                                                                                                        
   set(HH, 'enable', 'off');                                                                                                                                                                                                                                                     
end                                                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                                                 




% --------------------------------------------------------------------
function varargout = combined_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.combined.
HH = findobj(gcf,'Tag','combined');    
set(HH, 'value', 1);                   
HH = findobj(gcf,'Tag','duplicate');   
set(HH, 'value', 0);                   
assignin('base', 'com', 1);

% --------------------------------------------------------------------
function varargout = duplicate_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.duplicate.
HH = findobj(gcf,'Tag','combined');    
set(HH, 'value', 0);                   
HH = findobj(gcf,'Tag','duplicate');   
set(HH, 'value', 1);                   
assignin('base', 'com', 0);                                 


% --------------------------------------------------------------------
function varargout = Checkbox1_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.Checkbox1.
global sani
if sani==1                            
   assignin('base', 'sani', 0);                            
   HH = findobj(gcf,'Tag','persons'); 
   set(HH, 'enable', 'off');          
   HH = findobj(gcf,'Tag','drain');   
   set(HH, 'enable', 'off');          
	HH = findobj(gcf,'Tag','ind_flow');  
   set(HH, 'enable', 'off');          
  	HH = findobj(gcf,'Tag','ind_P');   
   set(HH, 'enable', 'off');          
  	HH = findobj(gcf,'Tag','ind_N');   
   set(HH, 'enable', 'off');          
  	HH = findobj(gcf,'Tag','ind_NH4'); 
   set(HH, 'enable', 'off');          
  	HH = findobj(gcf,'Tag','ind_NO3'); 
   set(HH, 'enable', 'off');          
  	HH = findobj(gcf,'Tag','ind_SS');  
   set(HH, 'enable', 'off');          
  	HH = findobj(gcf,'Tag','ind_BOD'); 
   set(HH, 'enable', 'off');          
  	HH = findobj(gcf,'Tag','ind_COD'); 
   set(HH, 'enable', 'off');          
  	HH = findobj(gcf,'Tag','ind_Ctot');
   set(HH, 'enable', 'off');          
  	HH = findobj(gcf,'Tag','ind_Cu');  
   set(HH, 'enable', 'off');          
  	HH = findobj(gcf,'Tag','ind_Zn');  
   set(HH, 'enable', 'off');          
  	HH = findobj(gcf,'Tag','ind_Pb');  
   set(HH, 'enable', 'off');          
  	HH = findobj(gcf,'Tag','ind_Cd');  
   set(HH, 'enable', 'off');          
  	HH = findobj(gcf,'Tag','ind_Hg');  
   set(HH, 'enable', 'off');          
  	HH = findobj(gcf,'Tag','ind_Cr');  
   set(HH, 'enable', 'off');          
else                                  
   assignin('base', 'sani', 1);                            
   HH = findobj(gcf,'Tag','persons'); 
   set(HH, 'enable', 'on');           
   HH = findobj(gcf,'Tag','drain');   
   set(HH, 'enable', 'on');           
	HH = findobj(gcf,'Tag','ind_flow');  
   set(HH, 'enable', 'on');           
	HH = findobj(gcf,'Tag','ind_P');     
   set(HH, 'enable', 'on');           
  	HH = findobj(gcf,'Tag','ind_N');   
   set(HH, 'enable', 'on');           
  	HH = findobj(gcf,'Tag','ind_NH4'); 
   set(HH, 'enable', 'on');           
  	HH = findobj(gcf,'Tag','ind_NO3'); 
   set(HH, 'enable', 'on');           
  	HH = findobj(gcf,'Tag','ind_SS');  
   set(HH, 'enable', 'on');           
  	HH = findobj(gcf,'Tag','ind_BOD'); 
   set(HH, 'enable', 'on');           
  	HH = findobj(gcf,'Tag','ind_COD'); 
   set(HH, 'enable', 'on');           
  	HH = findobj(gcf,'Tag','ind_Ctot');
   set(HH, 'enable', 'on');           
  	HH = findobj(gcf,'Tag','ind_Cu');  
   set(HH, 'enable', 'on');           
  	HH = findobj(gcf,'Tag','ind_Zn');  
   set(HH, 'enable', 'on');           
  	HH = findobj(gcf,'Tag','ind_Pb');  
   set(HH, 'enable', 'on');           
  	HH = findobj(gcf,'Tag','ind_Cd');  
   set(HH, 'enable', 'on');           
  	HH = findobj(gcf,'Tag','ind_Hg');  
   set(HH, 'enable', 'on');           
  	HH = findobj(gcf,'Tag','ind_Cr');  
   set(HH, 'enable', 'on');           
end                                   


% --------------------------------------------------------------------
function varargout = Checkbox2_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.Checkbox2.
global stormw
if stormw==1                                                                 
   assignin('base', 'stormw', 0);                                                                 
   HH = findobj(gcf,'Tag','totarea');                                        
   set(HH, 'enable', 'off');                                                 
   HH = findobj(gcf,'Tag','roads');                                          
   set(HH, 'enable', 'off');                                                 
   HH = findobj(gcf,'Tag','roadZna');                                        
   set(HH, 'enable', 'off');                                                 
   HH = findobj(gcf,'Tag','roofs');                                          
   set(HH, 'enable', 'off');                                                 
   HH = findobj(gcf,'Tag','roofZna');                                        
   set(HH, 'enable', 'off');                                                 
   HH = findobj(gcf,'Tag','roofCua');                                        
   set(HH, 'enable', 'off');                                                 
   HH = findobj(gcf,'Tag','otherarea');                                      
   set(HH, 'enable', 'off');                                                 
   HH = findobj(gcf,'Tag','yearlyrain');                                     
   set(HH, 'enable', 'off');                                                 
   HH = findobj(gcf,'Tag','vehiclekmday');                                   
   set(HH, 'enable', 'off');                                                 
   HH = findobj(gcf,'Tag','heavyvehicles');                                  
   set(HH, 'enable', 'off');                                                 
   HH = findobj(gcf,'Tag','base');                                  
   set(HH, 'enable', 'off');
   HH = findobj(gcf,'Tag','Listbox1');                                       
   set(HH, 'enable', 'off');                                                 
   HH = findobj(gcf,'Tag','Pushbutton2');                                    
   set(HH, 'enable', 'off');                                                 
   HH = findobj(gcf,'Tag','otherrain_choice');                               
   set(HH, 'enable', 'off');                                                 
else                                                                         
   assignin('base', 'stormw', 1);                                                                 
   HH = findobj(gcf,'Tag','totarea');                                        
   set(HH, 'enable', 'on');                                                  
   HH = findobj(gcf,'Tag','roads');                                          
   set(HH, 'enable', 'on');                                                  
   HH = findobj(gcf,'Tag','roadZna');                                        
   set(HH, 'enable', 'on');                                                  
   HH = findobj(gcf,'Tag','roofs');                                          
   set(HH, 'enable', 'on');                                                  
   HH = findobj(gcf,'Tag','roofZna');                                        
   set(HH, 'enable', 'on');                                                  
   HH = findobj(gcf,'Tag','roofCua');                                        
   set(HH, 'enable', 'on');                                                  
   HH = findobj(gcf,'Tag','otherarea');                                      
   set(HH, 'enable', 'on');                                                  
   HH = findobj(gcf,'Tag','yearlyrain');                                     
   set(HH, 'enable', 'on');                                                  
   HH = findobj(gcf,'Tag','vehiclekmday');                                   
   set(HH, 'enable', 'on');                                                  
   HH = findobj(gcf,'Tag','heavyvehicles');                                  
   set(HH, 'enable', 'on');                                                  
   HH = findobj(gcf,'Tag','base');                                  
   set(HH, 'enable', 'on');
   HH = findobj(gcf,'Tag','Listbox1');                                       
   set(HH, 'enable', 'on');                                                  
   HH = findobj(gcf,'Tag','Pushbutton2');                                    
   set(HH, 'enable', 'on');                                                  
   HH = findobj(gcf,'Tag','otherrain_choice');                               
   set(HH, 'enable', 'on');                                                  
end                                                                          


% --------------------------------------------------------------------
function varargout = Checkbox3_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.Checkbox3.
global CSO_choice
if CSO_choice==1                       
   assignin('base', 'CSO_choice', 0);                       
   HH = findobj(gcf,'Tag','CSO_limit');
   set(HH, 'enable', 'off');           
else                                   
   assignin('base', 'CSO_choice', 1);                       
   HH = findobj(gcf,'Tag','CSO_limit');
   set(HH, 'enable', 'on');            
end                                    


% --------------------------------------------------------------------
function varargout = Listbox1_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.Listbox1.
global rain text1
HH = findobj(gcf,'Tag','timesteps');
Value=get(gcbo, 'Value'); %list number                                                                                                                                                                                                                                                 
String=get(gcbo, 'String'); %rain name                                                                                                                                                                                                                                                 
evalin('base',String{Value}); %load rain file
bar(rain, 1, 'r')                                                                                                                                                                                                                                                                      
ylabel('\mum/s')                                                                                                                                                                                                                                                                       
size_rain=size(rain);                                                                                                                                                                                                                                                                  
text1=num2str(size_rain(1,1)); 
assignin('base', 'text1', num2str(size_rain(1,1)));
fil=sprintf('%s %s %s %s %s %s %s','The rain file',String{Value},'has been loaded and plotted.','','The rain file has',text1, 'timesteps.');
warndlg(fil,'SEWSYS Message')

set(HH, 'String', text1);


% --------------------------------------------------------------------
function varargout = otherrain_choice_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.otherrain_choice.
global rain other_rain
if other_rain==0                                                                                                                                                                                                                                                                                                                          
other_rain=1;                                                                                                                                                                                                                                                                                                                             
HH = findobj(gcf,'Tag','Listbox1');                                                                                                                                                                                                                                                                                                       
set(HH, 'enable', 'off');                                                                                                                                                                                                                                                                                                                 
HH = findobj(gcf,'Tag','otherrain');                                                                                                                                                                                                                                                                                                      
set(HH, 'enable', 'on');                                                                                                                                                                                                                                                                                                                  
HH = findobj(gcf,'Tag','Pushbutton4');                                                                                                                                                                                                                                                                                                    
set(HH, 'enable', 'on');                                                                                                                                                                                                                                                                                                                  
rain_0; %used in empty plot                                                                                                                                                                                                                                                                                                                                  
bar(rain, 1, 'r')                                                                                                                                                                                                                                                                                                                         
ylabel('\mum/s')                                                                                                                                                                                                                                                                                                                          
ylim([0 1])                                                                                                                                                                                                                                                                                                                               
c_path=cd;                                                                                                                                                                                                                                                                                                                                
fil=sprintf('%s %s %s %s %s %s %s','Type the name of the rain file in the box below! (for example: rain_long).','','The file must create a column vector called "rain" with rain intensities in um/s.','','The current MATLAB path is: ',c_path);
warndlg(fil,'SEWSYS Message')
else                                                                                                                                                                                                                                                                                                                                      
other_rain=0;                                                                                                                                                                                                                                                                                                                             
HH = findobj(gcf,'Tag','Listbox1');                                                                                                                                                                                                                                                                                                       
set(HH, 'enable', 'on');                                                                                                                                                                                                                                                                                                                  
Value=get(HH, 'Value');                                                                                                                                                                                                                                                                                                                   
String=get(HH, 'String');                                                                                                                                                                                                                                                                                                                 
evalin('base',String{Value});                                                                                                                                                                                                                                                                                                                      
bar(rain, 1, 'r')                                                                                                                                                                                                                                                                                                                         
ylabel('\mum/s')                                                                                                                                                                                                                                                                                                                          
HH = findobj(gcf,'Tag','otherrain');                                                                                                                                                                                                                                                                                                      
set(HH, 'String', '');                                                                                                                                                                                                                                                                                                                    
set(HH, 'enable', 'off');                                                                                                                                                                                                                                                                                                                 
HH = findobj(gcf,'Tag','Pushbutton4');                                                                                                                                                                                                                                                                                                    
set(HH, 'enable', 'off');                                                                                                                                                                                                                                                                                                                 
end                                                                                                                                                                                                                                                                                                                                       
                                                                                                                                                                                                                                                                                                                                          
% --------------------------------------------------------------------
function varargout = Pushbutton4_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.Pushbutton4.
global rain
HH = findobj(gcf,'Tag','otherrain');                                                                                                                                                                                                                                            
String=get(HH, 'String');                                                                                                                                                                                                                                                       
if isempty(String)==1                                                                                                                                                                                                                                                           
 errordlg('No file name is entered!','SEWSYS Error')                                                                                                                                                                                                                            
else                                                                                                                                                                                                                                                                            
evalin('base',String);                                                                                                                                                                                                                                                                   
bar(rain, 1, 'r')                                                                                                                                                                                                                                                               
ylabel('\mum/s')                                                                                                                                                                                                                                                                
size_rain=size(rain);                                                                                                                                                                                                                                                           
text1=num2str(size_rain(1,1));                                                                                                                                                                                                                                                  
fil=sprintf('%s %s %s %s','The rain file',String,'has been loaded and plotted.','','The rain file has',text1, 'timesteps.');
warndlg(fil,'SEWSYS Message')
end                                                                                                                                                                                                                                                                             


% --------------------------------------------------------------------
function varargout = totarea_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.totarea.
HH = findobj(gcf,'Tag','totarea');                                                                                                                                                                                                          
totar=str2num(get(HH, 'String'));                                                                                                                                                                                                           
HH = findobj(gcf,'Tag','roads');                                                                                                                                                                                                            
road=str2num(get(HH, 'String'));                                                                                                                                                                                                            
HH = findobj(gcf,'Tag','roofs');                                                                                                                                                                                                            
roof=str2num(get(HH, 'String'));                                                                                                                                                                                                            
HH = findobj(gcf,'Tag','otherarea');                                                                                                                                                                                                        
otherarea=totar-road-roof;                                                                                                                                                                                                                  
set(HH, 'String',num2str(otherarea) );                                                                                                                                                                                                      


% --------------------------------------------------------------------
function varargout = roads_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.roads.
HH = findobj(gcf,'Tag','totarea');                                                                                                                                                                                            
totar=str2num(get(HH, 'String'));                                                                                                                                                                                             
HH = findobj(gcf,'Tag','roads');                                                                                                                                                                                              
road=str2num(get(HH, 'String'));                                                                                                                                                                                              
HH = findobj(gcf,'Tag','roofs');                                                                                                                                                                                              
roof=str2num(get(HH, 'String'));                                                                                                                                                                                              
HH = findobj(gcf,'Tag','otherarea');                                                                                                                                                                                          
otherarea=totar-road-roof;                                                                                                                                                                                                    
set(HH, 'String',num2str(otherarea) );                                                                                                                                                                                        


% --------------------------------------------------------------------
function varargout = roofs_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.roofs.
HH = findobj(gcf,'Tag','totarea');                                                                                                                                                                                            
totar=str2num(get(HH, 'String'));                                                                                                                                                                                             
HH = findobj(gcf,'Tag','roads');                                                                                                                                                                                              
road=str2num(get(HH, 'String'));                                                                                                                                                                                              
HH = findobj(gcf,'Tag','roofs');                                                                                                                                                                                              
roof=str2num(get(HH, 'String'));                                                                                                                                                                                              
HH = findobj(gcf,'Tag','otherarea');                                                                                                                                                                                          
otherarea=totar-road-roof;                                                                                                                                                                                                    
set(HH, 'String',num2str(otherarea) );                                                                                                                                                                                        


% --------------------------------------------------------------------
function varargout = Pushbutton2_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.Pushbutton2.
HH = findobj(gcf,'Tag','totarea');                                                                                                                                                                                                                                                                        
if str2num(get(HH, 'String'))==0                                                                                                                                                                                                                                                                          
   errordlg('The Edit box "Total Impervious Area" is zero!','Simulation Error')                                                                                                                                                                                                                           
else                                                                                                                                                                                                                                                                                                      
   RUNOFF_fig                                                                                                                                                                                                                                                                                             
end                                                                                                                                                                                                                                                                                                       
                                                                                                                                                                                                                                                                                                          


% --- Executes during object creation, after setting all properties.
function othersystem_CreateFcn(hObject, eventdata, handles)
% hObject    handle to othersystem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function othersystem_Callback(hObject, eventdata, handles)
% hObject    handle to othersystem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of othersystem as text
%        str2double(get(hObject,'String')) returns contents of othersystem as a double


% --- Executes on button press in other_sys.
function other_sys_Callback(hObject, eventdata, handles)
HH = findobj(gcf,'Tag','other_sys');    
set(HH, 'value', 1);                   
HH = findobj(gcf,'Tag','combined');    
set(HH, 'value', 0);                   
HH = findobj(gcf,'Tag','duplicate');   
set(HH, 'value', 0);                   
assignin('base', 'com', 2);

% hObject    handle to other_sys (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of other_sys




% --- Executes on button press in Pushbutton5.
function Pushbutton5_Callback(hObject, eventdata, handles)
global sani stormw CSO_choice rain other_rain K cal_rain T cal sec_per_ts storm in_K com simrun T U2 in_yearly_rain
results_fig
%evalin('base','results');
%results   
% hObject    handle to Pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over other_sys.
function other_sys_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to other_sys (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Pushbutton3.
function Pushbutton3_Callback(hObject, eventdata, handles)
global simrun com 
if simrun==1                                                       
    if com==1
        close_system('SEWSYS_Combined')
    elseif com==0                                                             
        close_system('SEWSYS_Duplicate')
    else
        HH = findobj(gcf,'Tag','othersystem');                                                                                                                                                                                                                                            
        String=get(HH, 'String');
        close_system(String)
    end
end
close_system('SEWSYS_library')
close(gcbf)                                                        
close all                                                          
clear all
% hObject    handle to Pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Pushbutton1.
function Pushbutton1_Callback(hObject, eventdata, handles)
clear U1                                                                                                                                                                                                                                                                                                                                                  
clear U2
global sani rain in_K stormw com inputs in_numberOfPersons in_days K in_sec_per_ts in_yearly_rain T U2 outRecipient inSewageplant
HH = findobj(gcf,'Tag','Sec_per_ts');                                                                                                                                                                                                                                                                                                                     
if str2num(get(HH, 'String'))==0                                                                                                                                                                                                                                                                                                                          
   errordlg('The Edit box "Seconds per Timestep" is zero!','Simulation Error')                                                                                                                                                                                                                                                                            
else                                                                                                                                                                                                                                                                                                                                                      
   evalin('base','inputs');
    %inputs; %load input from SEWSYS' Main window                                                                                                                                                                                                                                                                                                           
   %prep; % load Prep.m
   evalin('base','Prep');
   if stormw==1 %run with stormwater                                                                                                                                                                                                                                                                                                                      
      if K==0                                                                                                                                                                                                                                                                                                                                             
         errordlg('You must first calibrate the Reservoir parameter!','Simulation Error')                                                                                                                                                                                                                                                                 
      else                                                                                                                                                                                                                                                                                                                                                
         if in_yearly_rain==0                                                                                                                                                                                                                                                                                                                             
            errordlg('The rain depth is zero! Must be present in order to calculate wet deposition.','Simulation Error')                                                                                                                                                                                                                                  
         else                                                                                                                                                                                                                                                                                                                                             
            if size(T)==size(U2) %check timesteps against chosen rain                                                                                                                                                                                                                                                                                     
               if sani==0 %run only with stormwater, no sanitary wastewater
                   assignin('base', 'U1', zeros(size(T)));
                  simulink                                                                                                                                                                                                                                                                                                                                
                  if com==1 %Check which model to open                                                                                                                                                                                                                                                                                                    
                     open_system('SEWSYS_Combined')                                                                                                                                                                                                                                                                                                       
                     set_param('SEWSYS_Combined','Stoptime', 'Q')                                                                                                                                                                                                                                                                                         
                     %sim('SEWSYS_Combined')                                                                                                                                                                                                                                                                                                               
                  else                                                                                                                                                                                                                                                                                                                                    
                     open_system('SEWSYS_Duplicate')                                                                                                                                                                                                                                                                                                      
                     set_param('SEWSYS_Duplicate','Stoptime', 'Q')                                                                                                                                                                                                                                                                                        
                     %sim('SEWSYS_Duplicate')                                                                                                                                                                                                                                                                                                              
                  end                                                                                                                                                                                                                                                                                                                                     
                  %warndlg('Simulation is ready, push Results button to see some nice plots!','SEWSYS Message')                                                                                                                                                                                                                                            
               else %stormwater and sanitary wastewater                                                                                                                                                                                                                                                                                                   
                  simulink                                                                                                                                                                                                                                                                                                                                
                  if com==1
                     open_system('SEWSYS_Combined')                                                                                                                                                                                                                                                                                                       
                     set_param('SEWSYS_Combined','Stoptime', 'Q')                                                                                                                                                                                                                                                                                         
                     %sim('SEWSYS_Combined')                                                                                                                                                                                                                                                                                                               
                  elseif com==0                                                                                                                                                                                                                                                                                                                                   
                     open_system('SEWSYS_Duplicate')                                                                                                                                                                                                                                                                                                      
                     set_param('SEWSYS_Duplicate','Stoptime', 'Q')                                                                                                                                                                                                                                                                                        
                     %sim('SEWSYS_Duplicate')
                 else
                     HH = findobj(gcf,'Tag','othersystem');                                                                                                                                                                                                                                            
                     String=get(HH, 'String');
                     open_system(String)                                                                                                                                                                                                                                                                                                      
                     set_param(String,'Stoptime', 'Q')                                                                                                                                                                                                                                                                                        
                     %sim(String)
                 end 
                 warndlg('Start the simulation in Simulink!','SEWSYS Message')                                                                                                                                                                                                                                            
                 %warndlg('Simulation is ready, push Results button to see some nice plots!','SEWSYS Message')                                                                                                                                                                                                                                            
               end                                                                                                                                                                                                                                                                                                                                        
            else                                                                                                                                                                                                                                                                                                                                          
               errordlg('Mismatch between number of timesteps and chosen rain!','Simulation Error')                                                                                                                                                                                                                                                       
            end                                                                                                                                                                                                                                                                                                                                           
         end                                                                                                                                                                                                                                                                                                                                              
         assignin('base', 'simrun', 1); %to state that simulation has been made
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
      warndlg('Simulation is ready, push Results button to see some nice plots!','SEWSYS Message')                                                                                                                                                                                                                                                        
   end                                                                                                                                                                                                                                                                                                                                                    
end             
                     
% hObject    handle to Pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


