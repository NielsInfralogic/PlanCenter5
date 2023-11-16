unit URuntemplatedialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  DeviceSetupType  = function(Var Errormessage : Pchar): longint;stdcall;
  PressSetupType  = function(Var Errormessage : Pchar): longint;stdcall;
  TemplateSetupType  = function(Var Errormessage : Pchar): longint;stdcall;

  GeneralSetupType  = function(Var Errormessage : Pchar): longint;stdcall;
  JobNamesSetupType = function(Var Errormessage : Pchar): longint;stdcall;
  ColorSetupType  = function(Var Errormessage : Pchar): longint;stdcall;
  LocationSetupType  = function(Var Errormessage : Pchar): longint;stdcall;
  ReConnectDBType = function(Var Errormessage : Pchar): longint;stdcall;

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Runningdll : boolean;
  DLLErrormessage : Pchar;
  Setupdllhandle : Thandle;
  DeviceSetup   : DeviceSetupType;
  PressSetup    :  PressSetupType;
  TemplateSetup : TemplateSetupType;
  JobNamesSetup : JobNamesSetupType;
  GeneralSetup       : GeneralSetupType;
  ColorSetup         : ColorSetupType;
  LocationSetup      : LocationSetupType;
  ReConnectDB    : ReConnectDBType;
implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  DLLErrormessage := stralloc(1024);
  strpcopy(DLLErrormessage,'Noe error');
  Setupdllhandle := LoadLibrary(pchar(extractfilepath(application.exename)+'TemplateDialogEnt.dll'));

  DeviceSetup := GetProcAddress(Setupdllhandle,'DeviceSetup');
  IF addr(DeviceSetup) = nil then
    MessageDlg('unable to load DeviceSetup from dll', mtInformation,[mbOk], 0);

  PressSetup := GetProcAddress(Setupdllhandle,'PressSetup');
  IF addr(PressSetup) = nil then
    MessageDlg('unable to load PressSetup from dll', mtInformation,[mbOk], 0);

  TemplateSetup := GetProcAddress(Setupdllhandle,'TemplateSetup');
  IF addr(TemplateSetup) = nil then
    MessageDlg('unable to load TemplateSetup from dll', mtInformation,[mbOk], 0);

  JobNamesSetup := GetProcAddress(Setupdllhandle,'JobNamesSetup');
  IF addr(JobNamesSetup) = nil then
    MessageDlg('unable to load JobNamesSetup from dll', mtInformation,[mbOk], 0);

  GeneralSetup := GetProcAddress(Setupdllhandle,'GeneralSetup');
  IF addr(GeneralSetup) = nil then
    MessageDlg('unable to load GeneralSetup from dll', mtInformation,[mbOk], 0);

  ColorSetup := GetProcAddress(Setupdllhandle,'ColorSetup');
  IF addr(ColorSetup) = nil then
    MessageDlg('unable to load ColorSetup from dll', mtInformation,[mbOk], 0);

  LocationSetup := GetProcAddress(Setupdllhandle,'LocationSetup');
  IF addr(LocationSetup) = nil then
    MessageDlg('unable to load LocationSetup from dll', mtInformation,[mbOk], 0);

  ReConnectDB := GetProcAddress(Setupdllhandle,'ReConnectDB');
  IF addr(ReConnectDB) = nil then
    MessageDlg('unable to load ReConnectDB from dll', mtInformation,[mbOk], 0);

end;

procedure TForm1.Button2Click(Sender: TObject);
Var
  skaldeklarerespgadll : Integer;

  resulttat : Integer;

begin

  Runningdll := true;


  resulttat := ReConnectDB(DLLErrormessage);
  
  resulttat := JobNamesSetup(DLLErrormessage);

  Runningdll := false;
end;

end.
