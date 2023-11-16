unit Uinitdata;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.WinXCtrls;
type
  TFormInit = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    procedure FormActivate(Sender: TObject);
  private
    function GetVersion: string;
  public
    { Public declarations }
  end;
var
  FormInit: TFormInit;
  initOK : boolean;
implementation
uses UTypes,Udata, Userver, Umain; (*, USelectserver;*)
{$R *.dfm}
procedure TFormInit.FormActivate(Sender: TObject);
Begin
  IF fileexists(extractfilepath(application.exename)+ 'dealersplash.bmp') then                  // OK!
    Image1.Picture.LoadFromFile(extractfilepath(application.exename)+ 'dealersplash.bmp');      // OK!
    Label1.Caption := GetVersion;
  FormInit.Refresh;
End;
function TFormInit.GetVersion: string;
var
  VerInfoSize: DWORD;
  VerInfo: Pointer;
  VerValueSize: DWORD;
  VerValue: PVSFixedFileInfo;
  Dummy: DWORD;
begin
  Result := '';
  VerInfoSize := GetFileVersionInfoSize(Pchar(ParamStr(0)), Dummy);
  if VerInfoSize = 0 then Exit;
  GetMem(VerInfo, VerInfoSize);
  GetFileVersionInfo(Pchar(ParamStr(0)), 0, VerInfoSize, VerInfo);
  VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
  with VerValue^ do
  begin
    Result := IntToStr(dwFileVersionMS shr 16);
    programminorversion := dwFileVersionMS and $FFFF;
    Result := Result + '.' + IntToStr(programminorversion);
    Result := Result + '.' + IntToStr(dwFileVersionLS shr 16);
    Result := Result + '.' + IntToStr(dwFileVersionLS and $FFFF);
  end;
  FreeMem(VerInfo, VerInfoSize);


end;
end.
