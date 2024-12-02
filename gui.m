function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 02-Dec-2024 22:41:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Config slider parameters
set(handles.theta_1_slider, 'Min', -90, 'Max', 90, 'Value', 0, ...
    'SliderStep', [1/180, 1/180]);
set(handles.theta_2_slider, 'Min', -90, 'Max', 90, 'Value', 0, ...
    'SliderStep', [1/180, 1/180]);
set(handles.theta_3_slider, 'Min', -90, 'Max', 90, 'Value', 0, ...
    'SliderStep', [1/180, 1/180]);

% Draw base form of Articulated Arm Robot
axes(handles.robot_axes);
draw_robot_form();

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function theta_1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to theta_1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
slider_1_value = get(hObject, 'Value');
set(handles.theta_1_value, 'String', num2str(slider_1_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function theta_1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta_1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function theta_2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to theta_2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
slider_2_value = get(hObject, 'Value');
set(handles.theta_2_value, 'String', num2str(slider_2_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function theta_2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta_2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function theta_3_slider_Callback(hObject, eventdata, handles)
% hObject    handle to theta_3_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
slider_3_value = get(hObject, 'Value');
set(handles.theta_3_value, 'String', num2str(slider_3_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function theta_3_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta_3_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in forward_button.
function forward_button_Callback(hObject, eventdata, handles)
% hObject    handle to forward_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

theta_1 = deg2rad(get(handles.theta_1_slider, 'Value'));
theta_2 = deg2rad(get(handles.theta_2_slider, 'Value'));
theta_3 = deg2rad(get(handles.theta_3_slider, 'Value'));

for i = 1:20
    step_theta_1 = theta_1 * (i / 20);
    step_theta_2 = theta_2 * (i / 20);
    step_theta_3 = theta_3 * (i / 20);

    set(handles.theta_1_response, 'String', num2str(rad2deg(step_theta_1)));
    set(handles.theta_2_response, 'String', num2str(rad2deg(step_theta_2)));
    set(handles.theta_3_response, 'String', num2str(rad2deg(step_theta_3)));

    draw_robot(step_theta_1, step_theta_2, step_theta_3);
    pause(0.05);
end


function theta_1_value_Callback(hObject, eventdata, handles)
% hObject    handle to theta_1_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta_1_value as text
%        str2double(get(hObject,'String')) returns contents of theta_1_value as a double


% --- Executes during object creation, after setting all properties.
function theta_1_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta_1_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function theta_2_value_Callback(hObject, eventdata, handles)
% hObject    handle to theta_2_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta_2_value as text
%        str2double(get(hObject,'String')) returns contents of theta_2_value as a double


% --- Executes during object creation, after setting all properties.
function theta_2_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta_2_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function theta_3_value_Callback(hObject, eventdata, handles)
% hObject    handle to theta_3_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta_3_value as text
%        str2double(get(hObject,'String')) returns contents of theta_3_value as a double


% --- Executes during object creation, after setting all properties.
function theta_3_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta_3_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x_response_value_Callback(hObject, eventdata, handles)
% hObject    handle to x_response_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x_response_value as text
%        str2double(get(hObject,'String')) returns contents of x_response_value as a double


% --- Executes during object creation, after setting all properties.
function x_response_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_response_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x_setpoint_value_Callback(hObject, eventdata, handles)
% hObject    handle to x_setpoint_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x_setpoint_value as text
%        str2double(get(hObject,'String')) returns contents of x_setpoint_value as a double


% --- Executes during object creation, after setting all properties.
function x_setpoint_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_setpoint_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y_response_value_Callback(hObject, eventdata, handles)
% hObject    handle to y_response_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y_response_value as text
%        str2double(get(hObject,'String')) returns contents of y_response_value as a double


% --- Executes during object creation, after setting all properties.
function y_response_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_response_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y_setpoint_value_Callback(hObject, eventdata, handles)
% hObject    handle to y_setpoint_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y_setpoint_value as text
%        str2double(get(hObject,'String')) returns contents of y_setpoint_value as a double


% --- Executes during object creation, after setting all properties.
function y_setpoint_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_setpoint_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function z_response_value_Callback(hObject, eventdata, handles)
% hObject    handle to z_response_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of z_response_value as text
%        str2double(get(hObject,'String')) returns contents of z_response_value as a double


% --- Executes during object creation, after setting all properties.
function z_response_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to z_response_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function z_setpoint_value_Callback(hObject, eventdata, handles)
% hObject    handle to z_setpoint_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of z_setpoint_value as text
%        str2double(get(hObject,'String')) returns contents of z_setpoint_value as a double


% --- Executes during object creation, after setting all properties.
function z_setpoint_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to z_setpoint_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in inverse_button.
function inverse_button_Callback(hObject, eventdata, handles)
% hObject    handle to inverse_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

x = str2double(get(handles.x_setpoint_value, 'String'));
y = str2double(get(handles.y_setpoint_value, 'String'));
z = str2double(get(handles.z_setpoint_value, 'String'));

if isnan(x) || isnan(y) || isnan(z)
    errordlg('Invalid value', 'Error');
    return;
end

start_x = 1000;
start_y = 0;
start_z = 500;

for i = 1:20
    step_x = start_x + (x - start_x) * (i / 20.0);
    step_y = start_y + (y - start_y) * (i / 20.0);
    step_z = start_z + (z - start_z) * (i / 20.0);

    inverse_kinematics(handles, step_x, step_y, step_z);
    pause(0.05);
end



function theta1_response_value_Callback(hObject, eventdata, handles)
% hObject    handle to theta1_response_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta1_response_value as text
%        str2double(get(hObject,'String')) returns contents of theta1_response_value as a double


% --- Executes during object creation, after setting all properties.
function theta1_response_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta1_response_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function theta2_response_value_Callback(hObject, eventdata, handles)
% hObject    handle to theta2_response_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta2_response_value as text
%        str2double(get(hObject,'String')) returns contents of theta2_response_value as a double


% --- Executes during object creation, after setting all properties.
function theta2_response_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta2_response_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function theta3_response_value_Callback(hObject, eventdata, handles)
% hObject    handle to theta3_response_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta3_response_value as text
%        str2double(get(hObject,'String')) returns contents of theta3_response_value as a double


% --- Executes during object creation, after setting all properties.
function theta3_response_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta3_response_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function theta_1_response_Callback(hObject, eventdata, handles)
% hObject    handle to theta_1_response (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta_1_response as text
%        str2double(get(hObject,'String')) returns contents of theta_1_response as a double


% --- Executes during object creation, after setting all properties.
function theta_1_response_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta_1_response (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function theta_2_response_Callback(hObject, eventdata, handles)
% hObject    handle to theta_2_response (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta_2_response as text
%        str2double(get(hObject,'String')) returns contents of theta_2_response as a double


% --- Executes during object creation, after setting all properties.
function theta_2_response_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta_2_response (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function theta_3_response_Callback(hObject, eventdata, handles)
% hObject    handle to theta_3_response (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta_3_response as text
%        str2double(get(hObject,'String')) returns contents of theta_3_response as a double


% --- Executes during object creation, after setting all properties.
function theta_3_response_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta_3_response (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in view_lspb_effector_button.
function view_lspb_effector_button_Callback(hObject, eventdata, handles)
% hObject    handle to view_lspb_effector_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in view_lspb_joint_1_button.
function view_lspb_joint_1_button_Callback(hObject, eventdata, handles)
% hObject    handle to view_lspb_joint_1_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in view_lspb_joint_2_button.
function view_lspb_joint_2_button_Callback(hObject, eventdata, handles)
% hObject    handle to view_lspb_joint_2_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in view_lspb_joint_3_button.
function view_lspb_joint_3_button_Callback(hObject, eventdata, handles)
% hObject    handle to view_lspb_joint_3_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in inverse_lspb_button.
function inverse_lspb_button_Callback(hObject, eventdata, handles)
% hObject    handle to inverse_lspb_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function lspb_q_max_value_Callback(hObject, eventdata, handles)
% hObject    handle to lspb_q_max_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lspb_q_max_value as text
%        str2double(get(hObject,'String')) returns contents of lspb_q_max_value as a double


% --- Executes during object creation, after setting all properties.
function lspb_q_max_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lspb_q_max_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lspb_v_max_value_Callback(hObject, eventdata, handles)
% hObject    handle to lspb_v_max_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lspb_v_max_value as text
%        str2double(get(hObject,'String')) returns contents of lspb_v_max_value as a double


% --- Executes during object creation, after setting all properties.
function lspb_v_max_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lspb_v_max_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lspb_a_max_value_Callback(hObject, eventdata, handles)
% hObject    handle to lspb_a_max_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lspb_a_max_value as text
%        str2double(get(hObject,'String')) returns contents of lspb_a_max_value as a double


% --- Executes during object creation, after setting all properties.
function lspb_a_max_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lspb_a_max_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
