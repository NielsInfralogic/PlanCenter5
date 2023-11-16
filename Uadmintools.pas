unit Uadmintools;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, XPStyleActnCtrls, ActnMan, ToolWin, ActnCtrls,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, ImgList, CheckLst;

type
  TFormadmintool = class(TForm)
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    Splitter2: TSplitter;
    Memosql: TMemo;
    MemoSQLlog: TMemo;
    TabSheet3: TTabSheet;
    GroupBox7: TGroupBox;
    Memoproclog: TMemo;
    GroupBox6: TGroupBox;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    GroupBox8: TGroupBox;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    Function Checkfileserverfolders(Var Amessage : string):Longint;
    Function CheckDatabase(Var Amessage : string):Longint;
    Function CheckProductions(Var Amessage : string):Longint;
  public
    { Public declarations }
  end;

var
  Formadmintool: TFormadmintool;

implementation
uses
  udata,
  umain, Usettings;




{$R *.dfm}


Function TFormadmintool.Checkfileserverfolders(Var Amessage : string):Longint;

Begin
End;


Function TFormadmintool.CheckDatabase(Var Amessage : string):Longint;
Begin
End;


Function TFormadmintool.CheckProductions(Var Amessage : string):Longint;
Begin

End;


procedure TFormadmintool.BitBtn2Click(Sender: TObject);
Var
  I : Longint;
  T : String;
begin
(*

PRINT 'PressrunID AND PageTable out of sync?'
SELECT PressRunID FROM PageTable P1 WHERE NOT EXISTS (SELECT PressRunID FROM PressRunID P2 WHERE P1.PressRunID=P2.PressRunID)
SELECT PressRunID FROM PressRunID P1 WHERE NOT EXISTS (SELECT PressRunID FROM PageTable P2 WHERE P1.PressRunID=P2.PressRunID)

PRINT 'ProductionNames AND PageTable out of sync?'
SELECT ProductionID FROM PageTable P1 WHERE NOT EXISTS (SELECT ProductionID FROM ProductionNames P2 WHERE P1.productionid=P2.productionid)
SELECT ProductionID FROM ProductionNames P1 WHERE NOT EXISTS (SELECT ProductionID FROM PageTable P2 WHERE P1.productionid=P2.productionid)

PRINT 'Duplicate unique-pages for masterset (in different pressruns)?'
SELECT P1.MasterCopySeparationSet,PUB.Name,P1.PubDate,P1.ProductionID,P1.PressRunID FROM PageTable P1
INNER JOIN PublicationNames PUB ON PUB.PublicationID=P1.PublicationID
WHERE EXISTS (SELECT MasterCopySeparationSet FROM PageTable P2 WHERE P1.MasterCopySeparationSet=P2.MasterCopySeparationSet AND P1.Uniquepage=1 AND P2.Uniquepage=1 AND P1.PressRunID<>P2.PressRunID)


*)

  Memoproclog.Lines.Clear;
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('SELECT P1.FlatSeparation, PUB.Name,P1.PubDate  ,ed.name,sec.name,p1.pagename,P1.ProductionID,P1.PressRunID FROM PageTable P1');
  DataM1.Query1.SQL.Add('INNER JOIN PublicationNames PUB ON PUB.PublicationID=P1.PublicationID');
  DataM1.Query1.SQL.Add('INNER JOIN editionNames ED ON ED.editionID=P1.editionID');
  DataM1.Query1.SQL.Add('INNER JOIN sectionNames SEC ON SEC.sectionID=P1.sectionID');
  DataM1.Query1.SQL.Add('WHERE EXISTS (SELECT P2.FlatSeparation FROM PageTable P2 WHERE P1.FlatSeparation=P2.FlatSeparation AND P1.PressRunID<>P2.PressRunID)');
  DataM1.Query1.SQL.Add('ORDER BY P1.FlatSeparation');
  DataM1.Query1.Open;
  IF not DataM1.Query1.Eof then
  Begin
    Memoproclog.Lines.Add('FlatSep used in different pressruns');
    Memoproclog.Lines.Add('FlatSeparation, Publication,PubDate,edition,Section,pagename,ProductionID,PressRunID');

  end;
  While not DataM1.Query1.Eof do
  begin
    T := '';
    For i := 0 to DataM1.Query1.Fields.Count-1 do
      T := T + DataM1.Query1.Fields[i].AsString+' , ';

    Memoproclog.Lines.Add(T);
    DataM1.Query1.Next;
  end;
  DataM1.Query1.Close;

  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('SELECT P1.CopySeparationSet,PUB.Name,P1.PubDate,ed.name,sec.name,p1.pagename,P1.ProductionID,P1.PressRunID FROM PageTable P1');
  DataM1.Query1.SQL.Add('INNER JOIN PublicationNames PUB ON PUB.PublicationID=P1.PublicationID');
  DataM1.Query1.SQL.Add('INNER JOIN editionNames ED ON ED.editionID=P1.editionID');
  DataM1.Query1.SQL.Add('INNER JOIN sectionNames SEC ON SEC.sectionID=P1.sectionID');
  DataM1.Query1.SQL.Add('WHERE EXISTS (SELECT P2.CopySeparationSet FROM PageTable P2 WHERE P1.CopySeparationSet=P2.CopySeparationSet AND P1.PressRunID<>P2.PressRunID)');
  DataM1.Query1.SQL.Add('ORDER BY  P1.CopySeparationSet');
  DataM1.Query1.Open;
  IF not DataM1.Query1.Eof then
  Begin
    Memoproclog.Lines.Add('');
    Memoproclog.Lines.Add('CopySep used in different pressruns');
    Memoproclog.Lines.Add('CopySeparationSet,Publication,PubDate,edition,Section,pagename,P1.ProductionID,P1.PressRunID');
  End;
  While not DataM1.Query1.Eof do
  begin
    T := '';
    For i := 0 to DataM1.Query1.Fields.Count-1 do
      T := T + DataM1.Query1.Fields[i].AsString+' , ';

    Memoproclog.Lines.Add(T);
    DataM1.Query1.Next;
  end;
  DataM1.Query1.Close;

  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('SELECT P1.MasterCopySeparationSet,PUB.Name,P1.PubDate,ed.name,sec.name,p1.pagename,P1.ProductionID,P1.PressRunID FROM PageTable P1');
  DataM1.Query1.SQL.Add('INNER JOIN PublicationNames PUB ON PUB.PublicationID=P1.PublicationID');
  DataM1.Query1.SQL.Add('INNER JOIN editionNames ED ON ED.editionID=P1.editionID');
  DataM1.Query1.SQL.Add('INNER JOIN sectionNames SEC ON SEC.sectionID=P1.sectionID');
  DataM1.Query1.SQL.Add('WHERE EXISTS (SELECT P2.MasterCopySeparationSet FROM PageTable P2 WHERE P1.MasterCopySeparationSet=P2.MasterCopySeparationSet AND (P1.PublicationID<>P2.PublicationID OR P1.PubDate<>P2.PubDate))');
  DataM1.Query1.SQL.Add('ORDER BY P1.MasterCopySeparationSet');
  DataM1.Query1.Open;
  IF not DataM1.Query1.Eof then
  Begin
    Memoproclog.Lines.Add('');
    Memoproclog.Lines.Add('Masterset used in different publication/pubdate use ');
    Memoproclog.Lines.Add('MasterCopySeparationSet,publication,PubDate,edition,section,pagename,ProductionID,PressRunID');
  End;
  While not DataM1.Query1.Eof do
  begin
    T := '';
    For i := 0 to DataM1.Query1.Fields.Count-1 do
      T := T + DataM1.Query1.Fields[i].AsString+' , ';

    Memoproclog.Lines.Add(T);
    DataM1.Query1.Next;
  end;
  DataM1.Query1.Close;

  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('SELECT P1.MasterCopySeparationSet,PUB.Name,P1.PubDate,ed.name,sec.name,p1.pagename,P1.ProductionID,P1.PressRunID,p1.copyseparationset FROM PageTable P1');
  DataM1.Query1.SQL.Add('INNER JOIN PublicationNames PUB ON PUB.PublicationID=P1.PublicationID');
  DataM1.Query1.SQL.Add('INNER JOIN editionNames ED ON ED.editionID=P1.editionID');
  DataM1.Query1.SQL.Add('INNER JOIN sectionNames SEC ON SEC.sectionID=P1.sectionID');
  DataM1.Query1.SQL.Add('WHERE (P1.uniquepage <> 1 and p1.copyseparationset <> p1.mastercopyseparationset) and ');
  DataM1.Query1.SQL.Add('not EXISTS (SELECT P2.MasterCopySeparationSet FROM PageTable P2 WHERE P1.MasterCopySeparationSet=P2.MasterCopySeparationSet AND p2.uniquepage = 1 and (P1.PublicationID=P2.PublicationID OR P1.PubDate=P2.PubDate))');
  DataM1.Query1.SQL.Add('ORDER BY P1.MasterCopySeparationSet');
  DataM1.Query1.Open;
  IF not DataM1.Query1.Eof then
  Begin
    Memoproclog.Lines.Add('');
    Memoproclog.Lines.Add('Common pages with nu unique master record');
    Memoproclog.Lines.Add('MasterCopySeparationSet,publication,PubDate,edition,section,pagename,ProductionID,PressRunID,copyseparationset');
  End;
  While not DataM1.Query1.Eof do
  begin
    T := '';
    For i := 0 to DataM1.Query1.Fields.Count-1 do
      T := T + DataM1.Query1.Fields[i].AsString+' , ';

    Memoproclog.Lines.Add(T);
    DataM1.Query1.Next;
  end;
  DataM1.Query1.Close;

end;

procedure TFormadmintool.BitBtn3Click(Sender: TObject);
begin
  if Formmain.Setplanlock(true) then
  begin
   if (Prefs.PlanRepair) then
    begin
      datam1.Query3.SQL.Clear;
      datam1.Query3.SQL.Add('Exec spRepairPageTable @PressSpecificPlan = ' + inttostr(Integer(Prefs.PressSpecific)));
      formmain.trysql(datam1.Query3);
    end;
    Formmain.Setplanlock(false)
  End
  Else
  begin
    MessageDlg(formmain.InfraLanguage1.Translate('Unable to se planlock '), mtInformation,[mbOk], 0);
  end;
end;

procedure TFormadmintool.BitBtn4Click(Sender: TObject);
begin
  Memoproclog.Lines.clear;
  if not Formmain.Setplanlock(true) then
  begin
    Memoproclog.Lines.Add('Unable to set planlock');
  end
  Else
  Begin
    Memoproclog.Lines.Add('planlock have been set');
  end;
  Memoproclog.Lines.Add('');

  datam1.Query3.SQL.Clear;
  datam1.Query3.SQL.Add('Select PlanLock,PlanLockTime,PlanLockClient,PlanLockTimeoutSec From GeneralPreferences');
  datam1.Query3.Open;
  IF Not datam1.Query3.Eof then
  Begin
    Memoproclog.Lines.Add('PlanLock           ' + datam1.Query3.Fields[0].AsString);
    Memoproclog.Lines.Add('Planlocktime       ' + datam1.Query3.Fields[1].AsString);
    Memoproclog.Lines.Add('PlanLockClient     ' + datam1.Query3.Fields[2].AsString);
    Memoproclog.Lines.Add('PlanLockTimeoutSec ' + datam1.Query3.Fields[3].AsString);
  end;
  datam1.Query3.Close;

end;

procedure TFormadmintool.BitBtn5Click(Sender: TObject);
begin
  Memoproclog.Lines.Clear;
  if not Formmain.Setplanlock(false) then
    Memoproclog.Lines.Add('Unable to release planlock')
  else
    Memoproclog.Lines.Add('planlock have been released');
  Memoproclog.Lines.add('');

  datam1.Query3.SQL.Clear;
  datam1.Query3.SQL.Add('Select PlanLock,PlanLockTime,PlanLockClient,PlanLockTimeoutSec From GeneralPreferences');
  datam1.Query3.Open;
  IF Not datam1.Query3.Eof then
  Begin
    Memoproclog.Lines.Add('PlanLock           ' + datam1.Query3.Fields[0].AsString);
    Memoproclog.Lines.Add('Planlocktime       ' + datam1.Query3.Fields[1].AsString);
    Memoproclog.Lines.Add('PlanLockClient     ' + datam1.Query3.Fields[2].AsString);
    Memoproclog.Lines.Add('PlanLockTimeoutSec ' + datam1.Query3.Fields[3].AsString);
  end;
  datam1.Query3.Close;
end;

procedure TFormadmintool.Button1Click(Sender: TObject);
begin

  datam1.Query3.SQL := Memosql.Lines;
  MemoSQLlog.Lines.Clear;
  try
    datam1.Query3.ExecSql;
  except
    on E: Exception do
          Begin
            MemoSQLlog.Lines.Add('Error ' + e.Message);

          End;

  end;

end;

procedure TFormadmintool.Button2Click(Sender: TObject);
Var
  I : Longint;
  T : string;
begin
  datam1.Query3.SQL := Memosql.Lines;
  MemoSQLlog.Lines.Clear;
  try
    datam1.Query3.Open;
    T := '';
    if not datam1.Query3.Eof then
      for i := 0 to datam1.Query3.Fields.Count-1 do
        T := T + datam1.Query3.Fields[i].DisplayName +',';
    MemoSQLlog.Lines.Add(t);
    while not datam1.Query3.Eof do
    begin
      T := '';
      For i := 0 to datam1.Query3.Fields.Count-1 do
        T := T + datam1.Query3.Fields[i].AsString +',';
      datam1.Query3.Next;
      MemoSQLlog.Lines.Add(t);
    end;
    datam1.Query3.Close;

  except
    on E: Exception do
          Begin
            MemoSQLlog.Lines.Add('Error ' + e.Message);
          End;

  end;

end;

end.



