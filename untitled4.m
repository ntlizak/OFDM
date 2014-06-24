function varargout = untitled4(varargin)
% UNTITLED4 MATLAB code for untitled4.fig
%      UNTITLED4, by itself, creates a new UNTITLED4 or raises the existing
%      singleton*.
%
%      H = UNTITLED4 returns the handle to a new UNTITLED4 or the handle to
%      the existing singleton*.
%
%      UNTITLED4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED4.M with the given input arguments.
%
%      UNTITLED4('Property','Value',...) creates a new UNTITLED4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled4_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled4

% Last Modified by GUIDE v2.5 23-Jun-2014 22:46:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled4_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled4_OutputFcn, ...
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


% --- Executes just before untitled4 is made visible.
function untitled4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled4 (see VARARGIN)

% Choose default command line output for untitled4
handles.output = hObject;
handles.suwak=20;
set(handles.text1,'String',handles.suwak)
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled4_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Generuj.
function Generuj_Callback(hObject, eventdata, handles)
% hObject    handle to Generuj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.wej1);
cla;

liczba = str2num(handles.edit1);
handles.z=gener(liczba);

il_zn=1:40;
stairs(il_zn,handles.z(1:40));
axis([0 41 -0.1 1.1]);

guidata(hObject, handles);


% --- Executes on button press in BPSK.
function BPSK_Callback(hObject, eventdata, handles)
% hObject    handle to BPSK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes2);
cla;
[I, Q, kwadr, r1, trans, wyjscie]=BPSK(handles.z, handles.suwak);
plot(I,Q,'ro');
axis([-4 4 -4 4]);
grid on;

handles.I=I;
handles.Q=Q;

axes(handles.wyj1);
cla;
%figure(3)
stem(abs(fftshift(fft(kwadr))));
%figure(1)
axes(handles.axes8);
cla;

%TUTAJ TRZEBA ZASZUMIC!
p=handles.suwak;
plot(abs(kwadr));


axes(handles.wyj2);
cla;
%figure(2)
stem(abs(fftshift(fft(r1))));
%figure(1)

axes(handles.axes5);
cla;
plot(trans,'ro');
axis([-4 4 -4 4]);
grid on;

axes(handles.wej2);
cla;
%gotowe=demod2(asd);

il_zn=1:40;
stairs(il_zn,wyjscie(1:40));
axis([0 41 -0.1 1.1]);

wynik = num2str(sum(abs(wyjscie-handles.z)));
set(handles.text3,'String',['ilosc bledow: ' wynik]); 

guidata(hObject, handles);


% --- Executes on button press in QAM.
function QAM_Callback(hObject, eventdata, handles)
% hObject    handle to QAM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




h_selectedRadioButton = get(handles.qamgroup,'SelectedObject');
selectedRadioTag = get(h_selectedRadioButton,'tag');
switch selectedRadioTag;
   case 'qam16';



axes(handles.axes2);
cla;
[I, Q, kwadr, r1, trans, wyjscie]=QAM(handles.z, handles.suwak);
plot(I,Q,'ro');
axis([-4 4 -4 4]);
grid on;

handles.I=I;
handles.Q=Q;

axes(handles.wyj1);
cla;
%figure(3)
stem(abs(fftshift(fft(kwadr))));
%figure(1)
axes(handles.axes8);
cla;

%TUTAJ TRZEBA ZASZUMIC!
plot(abs(kwadr));


axes(handles.wyj2);
cla;
%figure(2)
stem(abs(fftshift(fft(r1))));
%figure(1)

axes(handles.axes5);
cla;
plot(trans,'ro');
axis([-4 4 -4 4]);
grid on;

axes(handles.wej2);
cla;
%gotowe=demod2(asd);

il_zn=1:40;
stairs(il_zn,wyjscie(1:40));
axis([0 41 -0.1 1.1]);

wynik = num2str(sum(abs(wyjscie-handles.z)));
set(handles.text3,'String',['Ilosc bledow: ' wynik]); 
guidata(hObject, handles);



   case 'qam32';



axes(handles.axes2);
cla;
[I, Q, kwadr, r1, trans, wyjscie]=QAM32(handles.z, handles.suwak);
plot(I,Q,'ro');
axis([-6 6 -6 6]);
grid on;

handles.I=I;
handles.Q=Q;

axes(handles.wyj1);
cla;
%figure(3)
stem(abs(fftshift(fft(kwadr))));
%figure(1)
axes(handles.axes8);
cla;

%TUTAJ TRZEBA ZASZUMIC!
plot(abs(kwadr));


axes(handles.wyj2);
cla;
%figure(2)
stem(abs(fftshift(fft(r1))));
%figure(1)

axes(handles.axes5);
cla;
plot(trans,'ro');
axis([-6 6 -6 6]);
grid on;

axes(handles.wej2);
cla;
%gotowe=demod2(asd);

il_zn=1:40;
stairs(il_zn,wyjscie(1:40));
axis([0 41 -0.1 1.1]);

wynik = num2str(sum(abs(wyjscie-handles.z)));
set(handles.text3,'String',['Ilosc bledow: ' wynik]); 
guidata(hObject, handles);

end



guidata(hObject, handles);

% --- Executes on button press in MPSK.
function MPSK_Callback(hObject, eventdata, handles)
% hObject    handle to MPSK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes2);
cla;
[I, Q, kwadr, r1, trans, wyjscie]=MPSK(handles.z, handles.suwak);
plot(I,Q,'ro');
axis([-4 4 -4 4]);
grid on;

handles.I=I;
handles.Q=Q;

axes(handles.wyj1);
cla;
%figure(3)
stem(abs(fftshift(fft(kwadr))));
%figure(1)
axes(handles.axes8);
cla;

%TUTAJ TRZEBA ZASZUMIC!
plot(abs(kwadr));


axes(handles.wyj2);
cla;
%figure(2)
stem(abs(fftshift(fft(r1))));
%figure(1)

axes(handles.axes5);
cla;
plot(trans,'ro');
axis([-4 4 -4 4]);
grid on;

axes(handles.wej2);
cla;
%gotowe=demod2(asd);

il_zn=1:40;
stairs(il_zn,wyjscie(1:40));
axis([0 41 -0.1 1.1]);

wynik = num2str(sum(abs(wyjscie-handles.z)));
set(handles.text3,'String',['ilosc bledow: ' wynik]); 

guidata(hObject, handles);


% --- Executes on slider movement.
function suwak_Callback(hObject, eventdata, handles)
% hObject    handle to suwak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% Choose default command line output for untitled4
handles.suwak = get(hObject,'Value');
set(handles.text1,'String',get(hObject,'Value')); 

% Update handles structure
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function suwak_CreateFcn(hObject, eventdata, handles)
% hObject    handle to suwak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
handles.edit1 = get(hObject,'String');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function reset_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


axes(handles.axes2);
cla;
axes(handles.wyj1);
cla;
axes(handles.axes5);
cla;
axes(handles.axes8);
cla;
axes(handles.wej2);
cla;
axes(handles.wyj2);
cla;
%arrayfun(@cla,findall(0,'type','axes'));
%guidata(hObject, handles);


% --- Executes when selected object is changed in qamgroup.
function qamgroup_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in qamgroup 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
newButton=get(eventdata.NewValue,'tag');
switch newButton;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     case 'qam16';
        
%%%%%%%%%%%%%%%%%%%%%%%%%
     case 'qam32';
         
  
end
