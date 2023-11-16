unit Ufileinfo;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls;
type
  TFormFileinfo = class(TForm)
    Panel1: TPanel;
    Panel3: TPanel;
    Image2: TImage;
    Label7: TLabel;
    Label8: TLabel;
    BitBtn1: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Memo1: TMemo;
    Label24: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Editwidth: TEdit;
    Editheight: TEdit;
    Editxres: TEdit;
    Edityres: TEdit;
    EditCompRatio: TEdit;
    RadioGroupunits: TRadioGroup;
    GroupBox2: TGroupBox;
    Edit1: TEdit;
    GroupBox3: TGroupBox;
    Edit2: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure RadioGroupunitsClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Xres      : Single;
    Yres      : Single;
    FWidth     : Single;
    FHeight    : Single;
    CompRatio : single;
    Filename  : string;
    orgfilename : String;
    procedure setvalues;
  end;
var
  FormFileinfo: TFormFileinfo;
implementation
uses
  inifiles,utypes, UUtils, UMain,UPrefs;
{$R *.dfm}
procedure TFormFileinfo.FormActivate(Sender: TObject);
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
procedure TFormFileinfo.setvalues;
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
          editxres.text := makeatext(xres,4);
          edityres.text := makeatext(yres,4);
          editCompRatio.text := makeatext(CompRatio,4);
        end;
    1 : begin {inch to mil.}
          editwidth.text := makeatext(Fwidth*25.4,3);
          editHeight.text := makeatext(FHeight*25.4,3);
          editxres.text := makeatext(xres,3);
          edityres.text := makeatext(yres,3);
          editCompRatio.text := makeatext(CompRatio,3);
        end;
  end;
end;
procedure TFormFileinfo.RadioGroupunitsClick(Sender: TObject);
begin
  setvalues;
end;
procedure TFormFileinfo.FormClose(Sender: TObject;
  var Action: TCloseAction);
Var
  ini : tinifile;
begin
  try
    ini := TIniFile.Create(TUtils.GetPlanCenterIniFilePath(Prefs.PlanCenterConfigFileName));
    ini.writeinteger('system','FormFileinfoUnits',RadioGroupunits.ItemIndex);
    ini.free;
  except

  end;
end;

procedure TFormFileinfo.FormCreate(Sender: TObject);
Var
  ini : tinifile;
begin
  ini := TIniFile.Create(TUtils.GetPlanCenterIniFilePath(Prefs.PlanCenterConfigFileName));
  RadioGroupunits.ItemIndex := ini.readinteger('system','FormFileinfoUnits',1);
  ini.free;
end;
end.
