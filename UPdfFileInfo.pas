unit UPdfFileInfo;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls;
type
  TFormPDFfileInfo = class(TForm)
    Panel3: TPanel;
    Image2: TImage;
    Label7: TLabel;
    Label8: TLabel;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label24: TLabel;
    Label26: TLabel;
    Editwidth: TEdit;
    Editheight: TEdit;
    RadioGroupunits: TRadioGroup;
    GroupBox2: TGroupBox;
    Edit1: TEdit;
    GroupBox3: TGroupBox;
    Edit2: TEdit;
    Memo1: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure RadioGroupunitsClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FWidth     : Single;
    FHeight    : Single;
    Filename  : string;
    orgfilename : String;
    procedure setvalues;
  end;
var
  FormPDFfileInfo: TFormPDFfileInfo;
implementation
{$R *.dfm}
Uses
  inifiles,utypes, UUtils, UMain,UPrefs;
procedure TFormPDFfileInfo.setvalues;
function makeatext(value : Single;
                   Ndeci : Longint):String;
Var
  T : string;
Begin
  result := '';
  try
    IF value = 0 then
      T := '0'
    else
    begin
      T := floattostr(value);
      IF (pos('.',T) > 0) then
        delete(T,pos('.',T)+Ndeci,100);
      IF (pos(',',T) > 0) then
        delete(T,pos(',',T)+Ndeci,100);
    End;
    result := t;
  except
  end;
end;
{Var
  T : String;}
begin
  Case RadioGroupunits.ItemIndex of
    0 : begin
          editwidth.text := makeatext(Fwidth,4);
          editHeight.text := makeatext(FHeight,4);
        end;
    1 : begin {inch to mil.}
          editwidth.text := makeatext(Fwidth*25.4,3);
          editHeight.text := makeatext(FHeight*25.4,3);
        end;
  end;
end;


procedure TFormPDFfileInfo.FormClose(Sender: TObject;
  var Action: TCloseAction);
Var
  ini : tinifile;
begin
  try
    ini := TIniFile.Create(TUtils.GetPlanCenterIniFilePath(Prefs.PlanCenterConfigFileName));
    ini.writeinteger('system','FormFilePDFUnits',RadioGroupunits.ItemIndex);
    ini.free;
  except

  end;
end;
procedure TFormPDFfileInfo.FormCreate(Sender: TObject);
Var
  ini : tinifile;
begin
  try
    ini := TIniFile.Create(TUtils.GetPlanCenterIniFilePath(Prefs.PlanCenterConfigFileName));
    RadioGroupunits.ItemIndex := ini.readinteger('system','FormFilePDFUnits',1);
    ini.free;
  except

  end;
end;
procedure TFormPDFfileInfo.RadioGroupunitsClick(Sender: TObject);
begin
  setvalues;
end;
procedure TFormPDFfileInfo.FormActivate(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
  if not NyFileInfoOK then
  begin
    TabSheet2.visible := false;
  end;
  setvalues;
  edit1.Text := filename;
  edit2.Text := orgfilename;
end;
end.
