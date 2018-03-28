function varargout = results_fig(varargin)
% RESULTS_FIG M-file for results_fig.fig
%      RESULTS_FIG, by itself, creates a new RESULTS_FIG or raises the existing
%      singleton*.
%
%      H = RESULTS_FIG returns the handle to a new RESULTS_FIG or the handle to
%      the existing singleton*.
%
%      RESULTS_FIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESULTS_FIG.M with the given input arguments.
%
%      RESULTS_FIG('Property','Value',...) creates a new RESULTS_FIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before results_fig_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to results_fig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help results_fig

% Last Modified by GUIDE v2.5 25-Sep-2004 09:58:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @results_fig_OpeningFcn, ...
                   'gui_OutputFcn',  @results_fig_OutputFcn, ...
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


% --- Executes just before results_fig is made visible.
function results_fig_OpeningFcn(hObject, eventdata, handles, varargin)

% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to results_fig (see VARARGIN)

% Choose default command line output for results_fig
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes results_fig wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = results_fig_OutputFcn(hObject, eventdata, handles)

% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global v1 v2 v3 v4
HH = findobj(gcf,'Tag','checkbox1');
v1=get(HH, 'Value');
HH = findobj(gcf,'Tag','checkbox2');
v2=get(HH, 'Value');
HH = findobj(gcf,'Tag','checkbox3');
v3=get(HH, 'Value');
HH = findobj(gcf,'Tag','checkbox4');
v4=get(HH, 'Value');
if v1==1 & v2==0 & v3==0
    evalin('base','results');
    evalin('base','sanistorm');
    assignin('base','v1',1);
    assignin('base','v2',0);
    assignin('base','v3',0);
elseif v1==0 & v2==1 & v3==0
    evalin('base','sanidistr');
    assignin('base','v1',0);
    assignin('base','v2',1);
    assignin('base','v3',0);
elseif v1==0 & v2==0 & v3==1
    evalin('base','polldistr');
    evalin('base','polldistr_roads');
    evalin('base','polldistr_roofs');
    assignin('base','v1',0);
    assignin('base','v2',0);
    assignin('base','v3',1);
elseif v1==1 & v2==1 & v3==0
    evalin('base','results');
    evalin('base','sanistorm');
    evalin('base','sanidistr');
    assignin('base','v1',1);
    assignin('base','v2',1);
    assignin('base','v3',0);
elseif v1==1 & v2==0 & v3==1
    evalin('base','results');
    evalin('base','sanistorm');
    evalin('base','polldistr');
    evalin('base','polldistr_roads');
    evalin('base','polldistr_roofs');
    assignin('base','v1',1);
    assignin('base','v2',0);
    assignin('base','v3',1);
elseif v1==0 & v2==1 & v3==1
    evalin('base','sanidistr');
    evalin('base','polldistr');
    evalin('base','polldistr_roads');
    evalin('base','polldistr_roofs');
    assignin('base','v1',0);
    assignin('base','v2',1);
    assignin('base','v3',1);
elseif v1==1 & v2==1 & v3==1
    evalin('base','results');
    evalin('base','sanistorm');
    evalin('base','sanidistr');
    evalin('base','polldistr');
    evalin('base','polldistr_roads');
    evalin('base','polldistr_roofs');
    assignin('base','v1',1);
    assignin('base','v2',1);
    assignin('base','v3',1);
elseif v1==0 & v2==0 & v3==0 &v4==1
    POLLUTOGRAPH_fig
    LOADOGRAPH_fig
    assignin('base','v1',0);
    assignin('base','v2',0);
    assignin('base','v3',0);
    assignin('base','v4',1);
else
    ERRORDLG('Make a choice!','SEWSYS Error')
end
        

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global v1 v2 v3 v4

if v1==1 & v2==0 & v3==0
    close ('Massbalance over WWTP')
    close ('Hydrographs')
    close ('Heavy metals')
    close ('Combined Sewer Overflow (1)')
    close ('Combined Sewer Overflow (2)')
    close ('Sources for Copper')
    close ('Sources for Zinc')
    close ('Sources for Phosphorus')
    close ('Total Pollution Load Distribution')
    close ('Results Menu')
elseif v1==0 & v2==1 & v3==0
    close ('Sanitary Wastewater Pollution Load Distribution')
    close ('Results Menu')
elseif v1==0 & v2==0 & v3==1
    close ('Stormwater Pollution Load Distribution 1')
    close ('Stormwater Pollution Load Distribution 2')
    close ('Sources for Road Pollution 1')
    close ('Sources for Road Pollution 2')
    close ('Sources for Roof Pollution 1')
    close ('Sources for Roof Pollution 2')
    close ('Results Menu')
elseif v1==1 & v2==1 & v3==0
    close ('Massbalance over WWTP')
    close ('Hydrographs')
    close ('Heavy metals')
    close ('Combined Sewer Overflow (1)')
    close ('Combined Sewer Overflow (2)')
    close ('Sources for Copper')
    close ('Sources for Zinc')
    close ('Sources for Phosphorus')
    close ('Total Pollution Load Distribution')
    close ('Sanitary Wastewater Pollution Load Distribution')
    close ('Results Menu')
elseif v1==1 & v2==0 & v3==1
    close ('Massbalance over WWTP')
    close ('Hydrographs')
    close ('Heavy metals')
    close ('Combined Sewer Overflow (1)')
    close ('Combined Sewer Overflow (2)')
    close ('Sources for Copper')
    close ('Sources for Zinc')
    close ('Sources for Phosphorus')
    close ('Total Pollution Load Distribution')
    close ('Stormwater Pollution Load Distribution 1')
    close ('Stormwater Pollution Load Distribution 2')
    close ('Sources for Road Pollution 1')
    close ('Sources for Road Pollution 2')
    close ('Sources for Roof Pollution 1')
    close ('Sources for Roof Pollution 2')
    close ('Results Menu')
elseif v1==0 & v2==1 & v3==1
    close ('Sanitary Wastewater Pollution Load Distribution')
    close ('Stormwater Pollution Load Distribution 1')
    close ('Stormwater Pollution Load Distribution 2')
    close ('Sources for Road Pollution 1')
    close ('Sources for Road Pollution 2')
    close ('Sources for Roof Pollution 1')
    close ('Sources for Roof Pollution 2')
    close ('Results Menu')
elseif v1==1 & v2==1 & v3==1
    close ('Massbalance over WWTP')
    close ('Hydrographs')
    close ('Heavy metals')
    close ('Combined Sewer Overflow (1)')
    close ('Combined Sewer Overflow (2)')
    close ('Sources for Copper')
    close ('Sources for Zinc')
    close ('Sources for Phosphorus')
    close ('Total Pollution Load Distribution')
    close ('Stormwater Pollution Load Distribution 1')
    close ('Stormwater Pollution Load Distribution 2')
    close ('Sources for Road Pollution 1')
    close ('Sources for Road Pollution 2')
    close ('Sources for Roof Pollution 1')
    close ('Sources for Roof Pollution 2')
    close ('Sanitary Wastewater Pollution Load Distribution')
    close ('Results Menu')
elseif v4==0
    close('Pollutograph')
    close('Loadograph')
else
    close ('Results Menu')
end
evalin('base','clear v1 v2 v3 v4');


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4


