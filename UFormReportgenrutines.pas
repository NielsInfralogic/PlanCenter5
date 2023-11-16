unit UFormReportgenrutines;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Dialogs, Udata, Data.FmtBcd, Data.DB, Data.SqlExpr;

type
  TFormReportgenrutines = class(TForm)
    QueryGenrep: TSQLQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    function GenerateProductionReportWithdefaults(productionID: Longint;  EmailTo: string; defaulttype: Longint): Longint;
    function GenerateProductionReportONDel(productionID: Longint): Longint;
    function GenerateProductionReport(productionID: Longint;
      Pressrunid: Longint; OutputFolder: string; SendMail: Boolean;
      MailTo: string; MailCC: string; MailSubject: string;
      waitforresult: Boolean): Longint;

    function GeneratePressrunReport(productionID: Longint; Pressrunid: Longint): Longint;
  end;

var
  FormReportgenrutines: TFormReportgenrutines;

implementation

uses System.DateUtils, Usettings, Umain;

{$R *.dfm}

function TFormReportgenrutines.GenerateProductionReportWithdefaults
  (productionID: Longint; EmailTo: string; defaulttype: Longint): Longint;
// defaulttype 0=placcenter, 1=publdef,2=both plc and publdef

var
  Mailtopubldef: string;
  publid: Longint;

begin
  result := 0;
  publid := -1;
  QueryGenrep.SQL.Clear;
  QueryGenrep.SQL.add('select distinct publicationid from pagetable WITH (NOLOCK)');
  QueryGenrep.SQL.add('where productionID = ' + inttostr(productionID));
  QueryGenrep.open;
  if not QueryGenrep.eof then
    publid := QueryGenrep.fields[0].AsInteger;
  QueryGenrep.close;

  Mailtopubldef := Prefs.MailTo;

  if publid = 1 then
  begin
    QueryGenrep.SQL.Clear;
    QueryGenrep.SQL.add('select EmailRecipient from PublicationNames WITH (NOLOCK)');
    QueryGenrep.SQL.add('where PublicationID = ' + inttostr(publid));
    QueryGenrep.open;
    if not QueryGenrep.eof then
    begin
      Mailtopubldef := QueryGenrep.fields[0].AsString;
    end;
    QueryGenrep.close;
  end;

  if Mailtopubldef <> '' then
    result := GenerateProductionReport(productionID, 0,
                  Prefs.ReportSaveFolder,
                  Prefs.ReportOnProductionDeleteSendEmail,
                  Prefs.MailTo, Prefs.MailCC,
                  Prefs.MailSubject, false);

end;

function TFormReportgenrutines.GenerateProductionReportONDel
  (productionID: Longint): Longint;

var
  MailTo: string;
  MailCC, Mailtopubldef, mailtofinal, EmailCCfinal, EmailSubjectfinal,
    EmailBody: string;
  publid: Longint;

begin
  try
    Mailtopubldef := Prefs.MailTo;
    EmailCCfinal := Prefs.MailCC;
    EmailSubjectfinal := Prefs.MailSubject;

    publid := -1;
    QueryGenrep.SQL.Clear;
    QueryGenrep.SQL.add('select publicationid from pagetable WITH (NOLOCK)');
    QueryGenrep.SQL.add('where productionID = ' + inttostr(productionID));
    QueryGenrep.open;

    if not QueryGenrep.eof then
    begin
      publid := QueryGenrep.fields[0].AsInteger;
    end;
    QueryGenrep.close;

    if publid > 0 then
    begin
      QueryGenrep.SQL.Clear;
      QueryGenrep.SQL.add('select EmailRecipient,EmailCC,EmailSubject,EmailBody from PublicationNames WITH (NOLOCK)');
      QueryGenrep.SQL.add('where PublicationID = ' + inttostr(publid));
      QueryGenrep.open;
      if not QueryGenrep.eof then
      begin
        Mailtopubldef := QueryGenrep.fields[0].AsString;
        EmailCCfinal := QueryGenrep.fields[1].AsString;
        EmailSubjectfinal := QueryGenrep.fields[2].AsString;
      end;
    end;
    QueryGenrep.close;

    if Mailtopubldef <> '' then
    begin
      result := GenerateProductionReport(productionID, 0,
        Prefs.ReportSaveFolder,
        Prefs.ReportOnProductionDeleteSendEmail, Mailtopubldef,
        EmailCCfinal, EmailSubjectfinal, true);
    end;
  except
  end;

end;

function TFormReportgenrutines.GenerateProductionReport(productionID: Longint;
                  Pressrunid: Longint; OutputFolder: string; SendMail: Boolean; MailTo: string;
                  MailCC: string; MailSubject: string; waitforresult: Boolean): Longint;
var
  Starttime: tdatetime;
  Secstowait, Miscint, Newstatid: Longint;
  ReportName: string;
begin
  result := 0;
  Secstowait := Prefs.ReportTimeOut;
  Newstatid := 1;
  QueryGenrep.SQL.Clear;
  QueryGenrep.SQL.add('Select top 1 statid from ReportExportJobs ');
  QueryGenrep.SQL.add('Order by statid desc ');
  QueryGenrep.open;
  if not QueryGenrep.eof then
  begin
    Newstatid := QueryGenrep.fields[0].AsInteger + 1;
  end;
  QueryGenrep.close;

  if (Pressrunid > 0) then
  begin
    QueryGenrep.SQL.Clear;
    QueryGenrep.SQL.Add('Select TOP 1 PublicationID,PubDate,EditionID,PressID FROM PageTable WITH (NOLOCK) WHERE PressRunID=' + inttostr(Pressrunid));
    QueryGenrep.Open;
    if not QueryGenrep.eof then
    begin
      FormatSettings.ShortDateFormat := 'ddmmyy';
      ReportName := tnames1.publicationIDtoname(QueryGenrep.fields[0].AsInteger) +
                    '-' + DateToStr(QueryGenrep.fields[1].asdatetime) + '-' +
                    tnames1.editionIDtoname(QueryGenrep.fields[2].AsInteger) + '-' +
                    tnames1.pressnameIDtoname(QueryGenrep.fields[3].AsInteger) + '-' + IntToStr(Newstatid) + '.xls';
    end;
    QueryGenrep.Close;
  end
  else
  begin
    QueryGenrep.SQL.Clear;
    QueryGenrep.SQL.Add('Select TOP 1 PublicationID,PubDate,PressID FROM PageTable WITH (NOLOCK) WHERE ProductionID=' + inttostr(productionID));
    QueryGenrep.Open;
    if not QueryGenrep.eof then
    begin
      FormatSettings.ShortDateFormat := 'ddmmyy';
      ReportName := tnames1.publicationIDtoname(QueryGenrep.fields[0].AsInteger)
        + '-' + DateToStr(QueryGenrep.fields[1].asdatetime)
        + '-' +   tnames1.pressnameIDtoname(QueryGenrep.fields[2].AsInteger) + '-' + IntToStr(Newstatid) + '.xls'
    end;
    QueryGenrep.Close;
  end;

  if MailSubject = '' then
    MailSubject := ' Production report ';

  QueryGenrep.SQL.Clear;
  QueryGenrep.SQL.add('INSERT INTO ReportExportJobs (ProductionID,PressRunID, StatID, EventTime, SaveToFolder, OutputFolder, SendEmail, EmailRecipient, EmailCC, EmailSubject, EmailBody, MiscInt,MiscString)');
  QueryGenrep.SQL.add('Values (');
  QueryGenrep.SQL.add(IntToStr(productionID));
  QueryGenrep.SQL.add(', ' + IntToStr(Pressrunid)); // pressrunid
  QueryGenrep.SQL.add(', ' + IntToStr(Newstatid));
  QueryGenrep.SQL.add(', getdate()'); // eventtime
  QueryGenrep.SQL.add(',1'); // savetofolder
  // QueryGenrep.SQL.add(','+''''+OutputFolder+''''); //OutputFolder
  QueryGenrep.SQL.add(',' + '''' + Prefs.DefaultReportFolder + '''');
  // OutputFolder
  QueryGenrep.SQL.add(', ' + IntToStr(Integer(SendMail))); // SendEmail
  QueryGenrep.SQL.add(',' + '''' + MailTo + ''''); // , EmailRecipient,
  QueryGenrep.SQL.add(',' + '''' + MailCC + ''''); // EmailCC,
  QueryGenrep.SQL.add(',' + '''' + MailSubject + ''''); // EmailSubject,
  QueryGenrep.SQL.add(',' + '''' + '' + ''''); // EmailBody,
  QueryGenrep.SQL.add(',1 '); // MiscInt,
  QueryGenrep.SQL.add(',''' + ReportName + ''')'); // MiscString
  QueryGenrep.ExecSQL;
  result := 1;
  Starttime := now;

  if waitforresult then
  begin
    repeat
      Miscint := 0;
      QueryGenrep.SQL.Clear;
      QueryGenrep.SQL.add('Select MiscInt from ReportExportJobs ');
      QueryGenrep.SQL.add('Where statid =  ' + inttostr(Newstatid));
      QueryGenrep.open;
      if not QueryGenrep.eof then
      begin
        Miscint := QueryGenrep.fields[0].AsInteger;
      end;
      QueryGenrep.close;
    until (SecondsBetween(now, Starttime) > Secstowait) or (Miscint <> 1);
  end;

 // ShowMessage('report archive: '+ Prefs.DefaultReportFolder + '  output folder: '+OutputFolder);
 // Sleep(1000);
  if (OutputFolder <> Prefs.DefaultReportFolder) and (Prefs.DefaultReportFolder <> '') then
    CopyFile(PChar(Prefs.DefaultReportFolder + '\' + ReportName), PChar(OutputFolder + '\' + ReportName), false);
end;

function TFormReportgenrutines.GeneratePressrunReport(productionID: Longint;
  Pressrunid: Longint): Longint;
begin

end;

end.
