unit UQuickApply;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TSelectDevice = class(TForm)
    Panelsys: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    ComboBoxApplyDevices: TComboBox;
    Label2: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    TemplateID : Integer;
    procedure InitFormData(PressID : Integer);
  end;

var
  SelectDevice: TSelectDevice;

implementation

uses Udata,umain,utypes,dateutils, Usettings, Ulogin, UUtils;
{$R *.dfm}

procedure TSelectDevice.BitBtn1Click(Sender: TObject);
var
  s : string;
begin
  TemplateID := 0;
   s := 'SELECT TemplateID FROM TemplateConfigurations WHERE TemplateName=''' +  ComboBoxApplyDevices.Text + '''';
  Datam1.Query3.SQL.Clear;
  Datam1.Query3.SQL.Add('SELECT TemplateID FROM TemplateConfigurations WHERE TemplateName=''' +  ComboBoxApplyDevices.Text + '''');
  Datam1.Query3.Open;
  if not Datam1.Query3.Eof then
  begin
     TemplateID := Datam1.Query3.Fields[0].AsInteger;
  end;
  Datam1.Query3.Close;


end;

procedure TSelectDevice.BitBtn2Click(Sender: TObject);
begin
   TemplateID := 0;
end;


procedure TSelectDevice.InitFormData(PressID : Integer);
begin
  TemplateID := 0;
  ComboBoxApplyDevices.Items.Clear;
  Datam1.Query3.SQL.Clear;
  Datam1.Query3.SQL.Add('Select TemplateName FROM TemplateConfigurations WHERE PagesAcross=1 AND PagesDown=1 AND PressID = ' + IntToStr(PressID) + ' AND TemplateName<>''Dummy''' );
  Datam1.Query3.Open;
  while not Datam1.Query3.Eof do
  begin
     ComboBoxApplyDevices.Items.Add(Datam1.Query3.Fields[0].AsString);
     Datam1.Query3.Next();
  end;
  Datam1.Query3.Close;

  ComboBoxApplyDevices.Itemindex := ComboBoxApplyDevices.Items.Count-1;

end;

end.
