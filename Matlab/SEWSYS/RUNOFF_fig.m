function varargout = RUNOFF_fig(varargin)
% RUNOFF_FIG M-file for RUNOFF_fig.fig
%      RUNOFF_FIG, by itself, creates a new RUNOFF_FIG or raises the existing
%      singleton*.
%
%      H = RUNOFF_FIG returns the handle to a new RUNOFF_FIG or the handle to
%      the existing singleton*.
%
%      RUNOFF_FIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RUNOFF_FIG.M with the given input arguments.
%
%      RUNOFF_FIG('Property','Value',...) creates a new RUNOFF_FIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before RUNOFF_fig_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RUNOFF_fig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help RUNOFF_fig

% Last Modified by GUIDE v2.5 20-Jan-2003 17:24:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RUNOFF_fig_OpeningFcn, ...
                   'gui_OutputFcn',  @RUNOFF_fig_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin & isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before RUNOFF_fig is made visible.
function RUNOFF_fig_OpeningFcn(hObject, eventdata, handles, varargin)
global K String
HH = findobj('Tag','respar');                                                                                                                                                                                                                            
String=get(HH, 'String');                                                                                                                                                                                                                                                  
set(findobj('Tag','calpar'), 'String', String);
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to RUNOFF_fig (see VARARGIN)

% Choose default command line output for RUNOFF_fig
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes RUNOFF_fig wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = RUNOFF_fig_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function calpar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to calpar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function calpar_Callback(hObject, eventdata, handles)
global K
HH = findobj('Tag','calpar');                                                                                                                                                                                                                            
assignin('base', 'in_K', str2num(get(HH, 'String')));                                                                                                                                                                                                                         
assignin('base', 'K', str2num(get(HH, 'String')));                                                                                                                                                                                                                                                  
set(findobj('Tag','respar'), 'String', K)  

% hObject    handle to calpar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of calpar as text
%        str2double(get(hObject,'String')) returns contents of calpar as a double


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global cal_rain T sec_per_ts
assignin('base', 'sec_per_ts',str2num(get(findobj(gcf,'Tag','Sec_per_ts'), 'String')));                                                            
evalin('base', 'cal_inputs');                                                                                                                    
evalin('base', 'runoff_cal');                                                                                                                    
if sec_per_ts==0                                                                                                               
   errordlg('Seconds per timestep is zero! Must be the same as for wanted simulation rain.','SEWSYS Error')                    
else                                                                                                                           
   HH=findobj(gcf,'Tag','Axes1');                                                                                              
   set(gcf,'CurrentAxes',HH)                                                                                                   
   bar(T, cal_rain)                                                                                                            
   xlim([0 size(T,1)-1])                                                                                                       
   title('Rain data')                                                                                                          
   xlabel('Timesteps')                                                                                                         
   ylabel('um/s')                                                                                                              
end           
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function raindur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to raindur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function raindur_Callback(hObject, eventdata, handles)
% hObject    handle to raindur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of raindur as text
%        str2double(get(hObject,'String')) returns contents of raindur as a double


% --- Executes during object creation, after setting all properties.
function tafter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tafter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function tafter_Callback(hObject, eventdata, handles)
% hObject    handle to tafter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tafter as text
%        str2double(get(hObject,'String')) returns contents of tafter as a double


% --- Executes during object creation, after setting all properties.
function rainint_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rainint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function rainint_Callback(hObject, eventdata, handles)
% hObject    handle to rainint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rainint as text
%        str2double(get(hObject,'String')) returns contents of rainint as a double


% --- Executes during object creation, after setting all properties.
function Sec_per_ts_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sec_per_ts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function Sec_per_ts_Callback(hObject, eventdata, handles)
% hObject    handle to Sec_per_ts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Sec_per_ts as text
%        str2double(get(hObject,'String')) returns contents of Sec_per_ts as a double


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global cal_rain K T storm
if cal_rain==0                                                                                                                                                                                                                                                              
   errordlg('No typerain is created!','Simulation Error')                                                                                                                                                                                                                   
else                                                                                                                                                                                                                                                                        
   if K==0                                                                                                                                                                                                                                                                  
      errordlg('Set Reservoir parameter!','Simulation Error')                                                                                                                                                                                                               
   else                                                                                                                                                                                                                                                                     
      evalin('base', 'cal_inputs');                                                                                                                                                                                                                                                           
      evalin('base', 'cal_Prep');                                                                                                                                                                                                                                                             
      assignin('base','cal',1);                                                                                                                                                                                                                                                                
      simulink                                                                                                                                                                                                                                                              
      open_system('SEWSYS_Combined')                                                                                                                                                                                                                                        
      set_param('SEWSYS_Combined','Stoptime', 'Q')                                                                                                                                                                                                                          
      sim('SEWSYS_Combined');                                                                                                                                                                                                                                               
      close_system('SEWSYS_Combined')                                                                                                                                                                                                                                       
      warndlg('Calibration simulation is ready, push Plot button to see the Stormwater discharge!','SEWSYS Message')                                                                                                                                                       
   end                                                                                                                                                                                                                                                                      
end            
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
global cal T storm sec_per_ts
if cal==0                                                                                                                                                                                                                                                     
   errordlg('You must first run the calibration!','Simulation error')                                                                                                                                                                                         
else                                                                                                                                                                                                                                                          
   %plot storm water discharge                                                                                                                                                                                                                                
   HH=findobj(gcf,'Tag','Axes2');                                                                                                                                                                                                                             
   set(gcf,'CurrentAxes',HH)                                                                                                                                                                                                                                  
   plot(T, storm(:,1))                                                                                                                                                                                                                                        
   xlim([0 size(T,1)-1])                                                                                                                                                                                                                                      
   title('Storm Water Discharge')                                                                                                                                                                                                                             
   xlabel('Timesteps')                                                                                                                                                                                                                                        
   ylabel('m^3/s')                                                                                                                                                                                                                                            
   %check and display the concentration time (build-up phase)                                                                                                                                                                                                 
   j=0;                                                                                                                                                                                                                                                       
   k=0;                                                                                                                                                                                                                                                       
   sizestorm=size(storm);                                                                                                                                                                                                                                     
   tcstorm=0.97*max(storm(:,1));                                                                                                                                                                                                                              
   maxstorm=max(storm(:,1));                                                                                                                                                                                                                                  
   if maxstorm>=20                                                                                                                                                                                                                                            
      D=0.5;                                                                                                                                                                                                                                                  
   elseif maxstorm>=15 & maxstorm<20                                                                                                                                                                                                                          
      D=0.4;                                                                                                                                                                                                                                                  
   elseif maxstorm>=10 & maxstorm<15                                                                                                                                                                                                                          
      D=0.3;                                                                                                                                                                                                                                                  
   elseif maxstorm>=5 & maxstorm<10                                                                                                                                                                                                                           
      D=0.2;                                                                                                                                                                                                                                                  
   elseif maxstorm>=1 & maxstorm<5                                                                                                                                                                                                                            
      D=0.1;                                                                                                                                                                                                                                                  
   else                                                                                                                                                                                                                                                       
      D=0.01;                                                                                                                                                                                                                                                 
   end                                                                                                                                                                                                                                                        
   %check when build-up phase ends                                                                                                                                                                                                                            
   for i=1:sizestorm(1)-1                                                                                                                                                                                                                                     
      if i<sizestorm(1)                                                                                                                                                                                                                                       
         if abs(storm(i,1)-tcstorm)<D & storm(i+1,1)-storm(i,1)>0                                                                                                                                                                                             
            j=j+1; %# of if loops                                                                                                                                                                                                                             
            k=i;	%current place in storm                                                                                                                                                                                                                      
         end                                                                                                                                                                                                                                                  
      end                                                                                                                                                                                                                                                     
   end                                                                                                                                                                                                                                                        
   l=k-j; %index of first value                                                                                                                                                                                                                               
   maxminutes=(l)*sec_per_ts/60;                                                                                                                                                                                                                              
   text1=num2str(maxminutes);                                                                                                                                                                                                                                 
   text2=num2str(l);                                                                                                                                                                                                                                          
   %fil=sprintf('%s %s %s %s %s %s %s','Concentration time is',text1,'minutes.','',text2,'time steps');
   %fil=sprintf('%s','Concentration time isminutes.time steps');
   %WARNDLG(fil,'SEWSYS Message')
   %WARNDLG(str2mat('Concentration time is',text1,'minutes.','',text2,'time steps'),'SEWSYS Message')                                                                                                                                                          
   clear text1 text2 tcstorm maxminutes j k l sizestorm maxstorm D                                                                                                                                                                                            
end                                                                                                                                                                                                                                                           

% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
close(gcbf)           
assignin('base','cal',0);                
assignin('base','cal_rain',0);           

% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on mouse press over figure background.
function figure1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


