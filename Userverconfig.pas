unit Userverconfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls;

type
  TFormserverconfig = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label7: TLabel;
    Editservername: TEdit;
    Editdbname: TEdit;
    Editinstance: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Editsaname: TEdit;
    Editsapassword: TEdit;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Editbackupservername: TEdit;
    Editbackupdbname: TEdit;
    Editbackupinstance: TEdit;
    EditBackupsaname: TEdit;
    Editbackupsapassword: TEdit;
    Panel1: TPanel;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    Button1: TButton;
    Label8: TLabel;
    EditDSN: TEdit;
    Label4: TLabel;
    EditBackupDSN: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Formserverconfig: TFormserverconfig;

implementation
Uses
  udata,inifiles, Umain, UUtils;
{$R *.dfm}

procedure TFormserverconfig.FormActivate(Sender: TObject);
begin
  BitBtn7.enabled := true;
end;


procedure TFormserverconfig.Button1Click(Sender: TObject);
Var
  ini : TIniFile;
  anyerror : boolean;
  connFile :  string;
begin
  BitBtn7.enabled := false;
  connFile := IncludeTrailingBackSlash(TUtils.GetTempDirectory()) + 'Connect.ini';
  DeleteFile(connFile);
  ini := TIniFile.Create(connFile);
  IF Editinstance.Text <> '' then
    ini.writestring('CRSQLConnectionplan','HostName',Editservername.text+'\'+Editinstance.Text)
  else
    ini.writestring('CRSQLConnectionplan','HostName',Editservername.text);

  ini.writestring('CRSQLConnectionplan','DataBase',Editdbname.text);
  ini.writestring('CRSQLConnectionplan','User_Name',Editsaname.text);
  ini.writestring('CRSQLConnectionplan','Password',Editsapassword.text);
  ini.writestring('CRSQLConnectionplan','OS Authentication','False');
  ini.Free;
  anyerror := false;
  IF DataM1.CRSQLConnectionplan.connected then
    DataM1.CRSQLConnectionplan.close;
  DataM1.CRSQLConnectionplan.LoadParamsFromIniFile(connFile);
  try
    DataM1.CRSQLConnectionplan.Open;
    MessageDlg(formmain.InfraLanguage1.Translate('Success'), mtInformation,[mbOk], 0);
    DataM1.CRSQLConnectionplan.close;
  Except
    anyerror := true;
    MessageDlg(formmain.InfraLanguage1.Translate('Unable to connect to main server'), mtError,[mbOk], 0);
  end;

  IF Editbackupservername.Text <> '' then
  begin
    ini := tinifile.Create(connFile);
    IF Editbackupinstance.Text <> '' then
      ini.writestring('CRSQLConnectionplan','HostName',Editbackupservername.text+'\'+Editbackupinstance.Text)
    else
      ini.writestring('CRSQLConnectionplan','HostName',Editbackupservername.text);

    ini.writestring('CRSQLConnectionplan','DataBase',Editbackupdbname.text);
    ini.writestring('CRSQLConnectionplan','User_Name',Editbackupsaname.text);
    ini.writestring('CRSQLConnectionplan','Password',Editbackupsapassword.text);
    ini.writestring('CRSQLConnectionplan','OS Authentication','False');
    ini.Free;

    IF DataM1.CRSQLConnectionplan.connected then
      DataM1.CRSQLConnectionplan.close;
    DataM1.CRSQLConnectionplan.LoadParamsFromIniFile(connFile);
    try
      DataM1.CRSQLConnectionplan.Open;
      MessageDlg(formmain.InfraLanguage1.Translate('Success'), mtInformation,[mbOk], 0);
      DataM1.CRSQLConnectionplan.close;
    Except
      anyerror := true;
      MessageDlg(formmain.InfraLanguage1.Translate('Unable to connect to backup server'), mtError,[mbOk], 0);
    end;

  end;



  BitBtn7.enabled := not anyerror;

end;

end.
