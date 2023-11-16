unit Ugenexelsinglerep;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;
type
  TFormsingleexcelrep = class(TForm)
    Panel1: TPanel;
    Image4: TImage;
    Label2: TLabel;
    Labelaktrep: TLabel;
    BitBtn1: TBitBtn;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    BitBtn6: TBitBtn;
    RadioGroup1: TRadioGroup;
    GroupBox3: TGroupBox;
    ReportSaveFolder: TEdit;
    BitBtn4: TBitBtn;
    GroupBox4: TGroupBox;
    Edit1: TEdit;
    GroupBox5: TGroupBox;
    Edit2: TEdit;
    GroupBox6: TGroupBox;
    MailSubject: TEdit;
    GroupBox7: TGroupBox;
    MailTo: TEdit;
    BitBtn2: TBitBtn;
    GroupBox8: TGroupBox;
    BitBtn3: TBitBtn;
    MailCC: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    Aktpublid : Longint;
    AktPubdate : Tdatetime;
    Aktproductionid : Longint;

    { Public declarations }
  end;
var
  Formsingleexcelrep: TFormsingleexcelrep;
implementation
uses UUser, Ulogin, Usettings,inifiles, Udata, UAutotower, UGetUserEmail,umain,
  UFormReportgenrutines, UUtils;
{$R *.dfm}
Var
  ini : Tinifile;
procedure TFormsingleexcelrep.FormActivate(Sender: TObject);
Begin
  Edit1.text := tnames1.publicationIDtoname(Aktpublid);
  Edit2.text := datetostr(AktPubdate);
  RadioGroup1.ItemIndex := 0;
  IF ReportSaveFolder.Text = '' then
  begin
    ReportSaveFolder.Text := Prefs.ReportSaveFolder;
  end;
  IF MailSubject.text = '' then
    MailSubject.text := Prefs.MailSubject;
end;
procedure TFormsingleexcelrep.BitBtn1Click(Sender: TObject);
Var
  resulttat : integer;
  path      : String;
begin
  try
    IF (RadioGroup1.ItemIndex <> 1) AND (ReportSaveFolder.Text = '') then
    Begin
      MessageDlg(formmain.InfraLanguage1.Translate('Please select a output folder.'), mtInformation,[mbOk], 0);
      exit;
    end;
    IF (RadioGroup1.ItemIndex > 0) AND ((MailTo.Text = '')) then
    Begin
      MessageDlg(formmain.InfraLanguage1.Translate('Invalid email address.'), mtInformation,[mbOk], 0);
      exit;
    end;
    Datam1.Query1.Close;
    Datam1.Query1.SQL.Text := 'Insert ReportExportJobs (ProductionID, PressRunID, StatID, EventTime, SaveToFolder, OutputFolder, SendEmail, EmailRecipient, EmailCC, EmailSubject, EmailBody, MiscInt, MiscString)';
    Datam1.Query1.SQL.Add(    'Values (' + IntToStr(Aktproductionid) + ', 0, '' '', getdate(), 1,''' + ReportSaveFolder.Text + ''',' + '''0'',''' + MailTo.text + ''', ''' + MailCC.text + ''',''' + MailSubject.text + ''',' + ''' '',' + '''1'','' '')');
    //Datam1.Query1.sql.savetofile('001.sql');
    Datam1.Query1.execsql;
    ShowMessage('Excel report for: ' + Edit1.Text + ' ' + Edit2.Text + ' generete.' + sLineBreak + 'Located in : ' + ReportSaveFolder.Text);
    //Sleep(1000);
    //Application.ProcessMessages;
    (*if RadioGroup1.ItemIndex = 1 then
      path := ''
    Else *)
    {  path := ReportSaveFolder.Text;

    FormReportgenrutines.GenerateProductionReport(Aktproductionid,0,
                                                  path,
                                                  RadioGroup1.ItemIndex > 0,
                                                  MailTo.text,
                                                  MailCC.text,
                                                  MailSubject.text,true);

    Sleep(1000);
    Application.ProcessMessages; }
  Finally
    screen.Cursor := crdefault;
  end;
end;
procedure TFormsingleexcelrep.BitBtn2Click(Sender: TObject);
begin
  FormGetuserEmail.Publicationid:= Aktpublid;
  FormGetuserEmail.Productionid := Aktproductionid;
  IF FormGetuserEmail.showmodal = mrok then
  begin
    Mailto.text := FormGetuserEmail.listview1.Selected.SubItems[1];
  end;
end;
procedure TFormsingleexcelrep.BitBtn5Click(Sender: TObject);
begin
  FormGetuserEmail.Publicationid:= Aktpublid;
  FormGetuserEmail.Productionid := Aktproductionid;
  IF FormGetuserEmail.showmodal = mrok then
  begin
  end;
end;
procedure TFormsingleexcelrep.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  try
    ini := tinifile.Create(TUtils.GetPlanCenterIniFilePath(Prefs.PlanCenterConfigFileName));
    ini.WriteString('System','ReportSaveFolder',Prefs.ReportSaveFolder);
    ini.writeInteger('system','EmailUsePublicationSpecificMail',Integer(Prefs.EmailUsePublicationSpecificMail));
    ini.writeInteger('system','ReportOnProductionDeleteEmail',Integer(Prefs.ReportOnProductionDeleteSendEmail));
    ini.WriteString('System','MailFrom',Prefs.MailFrom);
    ini.WriteString('System','MailTo',Prefs.MailTo);
    ini.WriteString('System','MailCC',Prefs.MailCC);
    ini.WriteString('System','MailSubject',Prefs.MailSubject);
    ini.free;
  except

  end;
end;
procedure TFormsingleexcelrep.BitBtn3Click(Sender: TObject);
begin
  FormGetuserEmail.Publicationid:= Aktpublid;
  FormGetuserEmail.Productionid := Aktproductionid;
  IF FormGetuserEmail.showmodal = mrok then
  begin
    MailCC.text := FormGetuserEmail.listview1.Selected.SubItems[1];
  end;
end;
end.

