function varargout = POLLUTOGRAPH_fig(varargin)
% POLLUTOGRAPH_FIG M-file for POLLUTOGRAPH_fig.fig
%      POLLUTOGRAPH_FIG, by itself, creates a new POLLUTOGRAPH_FIG or raises the existing
%      singleton*.
%
%      H = POLLUTOGRAPH_FIG returns the handle to a new POLLUTOGRAPH_FIG or the handle to
%      the existing singleton*.
%
%      POLLUTOGRAPH_FIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in POLLUTOGRAPH_FIG.M with the given input arguments.
%
%      POLLUTOGRAPH_FIG('Property','Value',...) creates a new POLLUTOGRAPH_FIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before POLLUTOGRAPH_fig_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to POLLUTOGRAPH_fig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help POLLUTOGRAPH_fig

% Last Modified by GUIDE v2.5 26-Sep-2004 18:52:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @POLLUTOGRAPH_fig_OpeningFcn, ...
                   'gui_OutputFcn',  @POLLUTOGRAPH_fig_OutputFcn, ...
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


% --- Executes just before POLLUTOGRAPH_fig is made visible.
function POLLUTOGRAPH_fig_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to POLLUTOGRAPH_fig (see VARARGIN)

% Choose default command line output for POLLUTOGRAPH_fig
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes POLLUTOGRAPH_fig wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global v
v=2;

% --- Outputs from this function are returned to the command line.
function varargout = POLLUTOGRAPH_fig_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function first_CreateFcn(hObject, eventdata, handles)
% hObject    handle to first (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function first_Callback(hObject, eventdata, handles)
% hObject    handle to first (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of first as text
%        str2double(get(hObject,'String')) returns contents of first as a double


% --- Executes during object creation, after setting all properties.
function last_CreateFcn(hObject, eventdata, handles)
% hObject    handle to last (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function last_Callback(hObject, eventdata, handles)
% hObject    handle to last (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of last as text
%        str2double(get(hObject,'String')) returns contents of last as a double
global T
HH = findobj(gcf,'Tag','last');
comp=str2num(get(HH, 'String'));
if comp > max(T)
    errordlg('Last timestep is outside the length of rain series!','Simulation error')
    set(HH,'String',num2str(max(T)))
else
end

% --- Executes during object creation, after setting all properties.
function subnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to subnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function subnr_Callback(hObject, eventdata, handles)
% hObject    handle to subnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of subnr as text
%        str2double(get(hObject,'String')) returns contents of subnr as a double
global v
HH=findobj(gcf,'Tag','subnr');
v=str2num(get(HH, 'String'));
assignin('base','v',str2num(get(HH, 'String')));
if v==2
    set(findobj('Tag','subname'), 'String', 'Phosphorus')
elseif v==3
    set(findobj('Tag','subname'), 'String', 'Nitrogen')
elseif v==8
    set(findobj('Tag','subname'), 'String', 'BOD')
elseif v==12
    set(findobj('Tag','subname'), 'String', 'Copper')
elseif v==13
    set(findobj('Tag','subname'), 'String', 'Zinc')
elseif v==14
    set(findobj('Tag','subname'), 'String', 'Lead')
elseif v==15
    set(findobj('Tag','subname'), 'String', 'Cadmium')
elseif v==18
    set(findobj('Tag','subname'), 'String', 'Platinum')
elseif v==19
    set(findobj('Tag','subname'), 'String', 'Palladium')
elseif v==20
    set(findobj('Tag','subname'), 'String', 'Rhodium')
elseif v==21
    set(findobj('Tag','subname'), 'String', 'PAH')
else
    errordlg('No data for this substance!','Simulation error')
end

% --- Executes during object creation, after setting all properties.
function subname_CreateFcn(hObject, eventdata, handles)
% hObject    handle to subname (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function subname_Callback(hObject, eventdata, handles)
% hObject    handle to subname (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of subname as text
%        str2double(get(hObject,'String')) returns contents of subname as a double


% --- Executes on button press in plot.
function plot_Callback(hObject, eventdata, handles)
% hObject    handle to plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global v T storm sec_per_ts
HH=findobj(gcf,'Tag','axes1');
set(gcf,'CurrentAxes',HH)
HH2 = findobj(gcf,'Tag','first');                                                                                                                                                                                         
in_first=str2num(get(HH2, 'String'));
HH3 = findobj(gcf,'Tag','last');                                                                                                                                                                                         
in_last=str2num(get(HH3, 'String'));
plot(T,storm(:,1))
%YLIM([0 max(storm(:,1))])
XLIM([in_first in_last])                                                                                                       
title('Hydrograph: Stormwater flow')                                                                                                          
xlabel('Timesteps')                                                                                                         
ylabel('m3/s')

HH4=findobj(gcf,'Tag','axes2');                                                                                              
set(gcf,'CurrentAxes',HH4)
plot(T,storm(:,v)./storm(:,1),'m')
XLIM([in_first in_last])
HH5 = findobj(gcf,'Tag','subname');
text1=get(HH5, 'String');
fil=sprintf('%s %s %s %s %s %s %s','Pollutograph:',text1);
title(fil)                                                                                                          
xlabel('Timesteps')                                                                                                         
ylabel('mg/L')

vol=sum(storm(:,1))*sec_per_ts;
load=sum(storm(:,v))*sec_per_ts/1000;
emc=load*1000/vol;
HH5=findobj(gcf,'Tag','volume');
set(HH5,'String',round(vol))
HH6=findobj(gcf,'Tag','load');
set(HH6,'String',load)
HH7=findobj(gcf,'Tag','conc');
set(HH7,'String',emc)

% --- Executes on button press in close.
function close_Callback(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global v4
close('Pollutograph')
assignin('base','v4',0);


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function volume_CreateFcn(hObject, eventdata, handles)
% hObject    handle to volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function volume_Callback(hObject, eventdata, handles)
% hObject    handle to volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of volume as text
%        str2double(get(hObject,'String')) returns contents of volume as a double


% --- Executes during object creation, after setting all properties.
function load_CreateFcn(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of load as text
%        str2double(get(hObject,'String')) returns contents of load as a double


% --- Executes during object creation, after setting all properties.
function conc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to conc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function conc_Callback(hObject, eventdata, handles)
% hObject    handle to conc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of conc as text
%        str2double(get(hObject,'String')) returns contents of conc as a double


