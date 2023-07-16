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

% Last Modified by GUIDE v2.5 05-Sep-2022 15:37:06

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



function input_num_Callback(hObject, eventdata, handles)
% hObject    handle to input_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_num as text
%        str2double(get(hObject,'String')) returns contents of input_num as a double
order = str2double(get(hObject,'String'));
output_num = str2double(get(handles.output_num,'String'));

%%%% Generate warning for zero input
if order == 0
    set(handles.logic,'String','The number of inputs cannot be zero!');
    set(handles.logic,'ForegroundColor',[1 0 0]);
    return
end

%%%% Create truth table which traverse all possible input combinations 
input = zeros(2^order, order);
for idx1 = 1:2^order 
    for idx2 = 1:order
        input(idx1,idx2) = rem(ceil(idx1/2^(order-idx2)),2) == 0;
    end
end
input = [input,zeros(2^order,output_num)];
for i = 1:order
    col_name(i) = append('X',string(i));
end
for i = 1:output_num
    col_name(i+order) = append('Y',string(i));
end


col_name = [col_name]
set(handles.truth_table,'data',input);
set(handles.truth_table,'ColumnEditable',[false(1,order) true(1,output_num)])
set(handles.truth_table,'ColumnName',col_name)
set(handles.truth_table,'FontSize',14);
set(handles.tip,'String','Input your desired output with 0(LOW) or 1(HIGH) please. Note that any non-zero input will be treated as a HIGH.');



% --- Executes during object creation, after setting all properties.
function input_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in logic_exp.
function logic_exp_Callback(hObject, eventdata, handles)
% hObject    handle to logic_exp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
truth_data = get(handles.truth_table,'Data')
syms X [1 width(truth_data )-1]
SOP = 0;

    
%%%% Deal with invalid truth table
if 2^(width(truth_data)-1) ~= height(truth_data)
    set(handles.logic,'String','Please input a valid truth table!');
    set(handles.logic,'ForegroundColor',[1 0 0]);
    return
end

%%%% SoP algorithm
for i = 1:height(truth_data)
    if truth_data(i,end) ~= 0
        Product = 1;
        for j = 1:width(truth_data )-1
            if truth_data(i, j) ~= 0
                Product = Product & X(j);
            else
                Product = Product & ~X(j);
            end
        end
        SOP = SOP | Product;
    end
end

%%%% Simplify non-empty SoP
if SOP ~= 0
    SOP = simplify(SOP,'Steps',100);
end



%%%% Check for constant SoP
if SOP == symtrue
    SOP = 1;
end

%%%% Print simplified logic expressions
set(handles.logic,'String',append('Output = ',string(SOP)));
set(handles.logic,'ForegroundColor',[0 0 0]);



function output_num_Callback(hObject, eventdata, handles)
% hObject    handle to output_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of output_num as text
%        str2double(get(hObject,'String')) returns contents of output_num as a double
order = str2double(get(handles.input_num,'String'));
output_num = str2double(get(hObject,'String'));

%%%% Generate warning for zero input
if order == 0
    set(handles.logic,'String','The number of inputs cannot be zero!');
    set(handles.logic,'ForegroundColor',[1 0 0]);
    return
end

%%%% Create truth table which traverse all possible input combinations 
input = zeros(2^order, order);
for idx1 = 1:2^order 
    for idx2 = 1:order
        input(idx1,idx2) = rem(ceil(idx1/2^(order-idx2)),2) == 0;
    end
end
input = [input,zeros(2^order,output_num)];
for i = 1:order
    col_name(i) = append('X',string(i));
end
for i = 1:output_num
    col_name(i+order) = append('Y',string(i));
end


col_name = [col_name]
set(handles.truth_table,'data',input);
set(handles.truth_table,'ColumnEditable',[false(1,order) true(1,output_num)])
set(handles.truth_table,'ColumnName',col_name)
set(handles.truth_table,'FontSize',14);
set(handles.tip,'String','Input your desired output with 0(LOW) or 1(HIGH) please. Note that any non-zero input will be treated as a HIGH.');



% --- Executes during object creation, after setting all properties.
function output_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to output_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
