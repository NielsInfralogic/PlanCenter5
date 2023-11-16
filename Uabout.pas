unit Uabout;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls;
type
  TFormAbout = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    LabelApplication: TLabel;
    Labelversion: TLabel;
    Label3: TLabel;
    Image2: TImage;
    GroupBox1: TGroupBox;
    Memo2: TMemo;
    TabSheet3: TTabSheet;
    Label1: TLabel;
    LabelWindowsUserName: TLabel;
    Label2: TLabel;
    LabelWindowsDomain: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    MemoADGroups: TMemo;
    MemoPublications: TMemo;
    Label6: TLabel;
    MemoAdminGroups: TMemo;
    Label7: TLabel;
    Label8: TLabel;
    LabelUserGroup: TLabel;
    Button1: TButton;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    systemsize : Integer; //-1 dont show, 0 standalone, 1 profesionel, 2 interprice
    programversion : string;
    { Public declarations }
  end;
var
  FormAbout: TFormAbout;
implementation
{$R *.dfm}
uses
  System.Types, Winapi.ShellAPI,UUtils;
procedure TFormAbout.Button1Click(Sender: TObject);
var
  cmd : string;
  CreateOK   : boolean;
  buffer: TByteDynArray;
  l : Integer;
   StartInfo  : TStartupInfo;
  ProcInfo   : TProcessInformation;
begin
    FillChar(StartInfo, SizeOf(TStartupInfo),#0);
    FillChar(ProcInfo, SizeOf(TProcessInformation),#0);
    StartInfo.cb := SizeOf(TStartupInfo);
    StartInfo.dwFlags := STARTF_USESHOWWINDOW;
    StartInfo.wShowWindow := SW_SHOW;
    cmd := '"' + ExtractFilePath(Application.ExeName) + 'PlanCenterUpdater.exe" ' + programversion;

      //Copy to writable buffer (including null terminator)
    l := (Length(cmd)+1)*sizeof(Char);
    SetLength(buffer, l);
    Move(cmd[1], buffer[0], l);

    CreateOK := CreateProcess(PChar(nil),
                              @buffer[0], //PChar(WideString(cmd)),
                              nil,
                              nil,
                              false,
                              CREATE_NEW_PROCESS_GROUP+NORMAL_PRIORITY_CLASS,
                              nil,
                              PChar(nil),
                              StartInfo,
                              {var}ProcInfo);
end;

procedure TFormAbout.FormActivate(Sender: TObject);
const
  InfoNum = 10;
  InfoStr: array[1..InfoNum] of string = ('CompanyName', 'FileDescription', 'FileVersion', 'InternalName', 'LegalCopyright', 'LegalTradeMarks', 'OriginalFileName', 'ProductName', 'ProductVersion', 'Comments');
var
  S: string;
  n, Len: DWORD;
  Buf: PChar;
  Value: PChar;
begin
  S := Application.ExeName;  // OK!
  n := GetFileVersionInfoSize(PChar(S), n);
  if n > 0 then
  begin
    Buf := AllocMem(n);
    GetFileVersionInfo(PChar(S), 0, n, Buf);
    IF VerQueryValue(Buf, PChar('StringFileInfo\040904E4\' + InfoStr[2]), Pointer(Value), Len) then
      LabelApplication.Caption := value;
    IF VerQueryValue(Buf, PChar('StringFileInfo\040904E4\' + InfoStr[3]), Pointer(Value), Len) then
    begin
      programversion := value;
      Labelversion.Caption := 'Version ' + value;
    end;
    IF VerQueryValue(Buf, PChar('StringFileInfo\040904E4\' + InfoStr[10]), Pointer(Value), Len) then
    Begin
    End;
    FreeMem(Buf, n);
  end
  Else
  Begin
    LabelApplication.Caption := ExtractFileName(application.exename);
    Labelversion.visible := false;
  end;
  if FileExists(ExtractFilePath(Application.ExeName) + '\PlanCenter revision history since v5.txt', false) then
    Memo2.Lines.LoadFromFile(ExtractFilePath(Application.ExeName) + '\PlanCenter revision history since v5.txt');
end;
procedure TFormAbout.FormCreate(Sender: TObject);
begin
  systemsize := -1;
end;

end.
