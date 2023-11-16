unit UPecomImp;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdFTP, StdCtrls, ComCtrls, Menus, IdUDPBase, IdUDPClient, IdTrivialFTP,
  Buttons, ExtCtrls, ActnList, ToolWin, ActnMan, ActnCtrls,
  XPStyleActnCtrls, System.Actions, IdExplicitTLSClientServerBase;
type
  TFormPecomrequest = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Memolisterequest: TMemo;
    GroupBox3: TGroupBox;
    Memoplanreq: TMemo;
    Memo2: TMemo;
    Button2: TButton;
    Button3: TButton;
    Memoread: TMemo;
    Button4: TButton;
    GroupBox4: TGroupBox;
    ListViewplans: TListView;
    IdFTP1: TIdFTP;
    OpenDialog1: TOpenDialog;
    PopupMenu1: TPopupMenu;
    Import1: TMenuItem;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    DateTimePickerfrom: TDateTimePicker;
    DateTimePickerto: TDateTimePicker;
    BitBtn1: TBitBtn;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Edit2: TEdit;
    Panel3: TPanel;
    Image2: TImage;
    Label7: TLabel;
    Panel2: TPanel;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox5: TGroupBox;
    ListViewPagePos: TListView;
    GroupBoxprogress: TGroupBox;
    ProgressBar1: TProgressBar;
    ListVieweditions: TListView;
    Edited: TEdit;
    GroupBox7: TGroupBox;
    Button9: TButton;
    Button10: TButton;
    Editdebug: TEdit;
    PopupMenupecomp: TPopupMenu;
    Selectall1: TMenuItem;
    TabSheet3: TTabSheet;
    ListView1: TListView;
    ActionManagerpecomp: TActionManager;
    Actionrefresh: TAction;
    OpenDialogdebug: TOpenDialog;
    TabSheet4: TTabSheet;
    Editcompfilefolder: TEdit;
    Label3: TLabel;
    EditcompHost: TEdit;
    Label4: TLabel;
    Editport: TEdit;
    Label5: TLabel;
    Editpecompuser: TEdit;
    Label6: TLabel;
    Editpecomppassword: TEdit;
    Label9: TLabel;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    Button8: TButton;
    Button11: TButton;
    TabSheet5: TTabSheet;
    IdFTP2: TIdFTP;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    EditCip3Host: TEdit;
    EditCip3Port: TEdit;
    EditCip3User: TEdit;
    EditCip3password: TEdit;
    Button12: TButton;
    BitBtn4: TBitBtn;
    BitBtn7: TBitBtn;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure ListViewPagePosCompare(Sender: TObject; Item1,
      Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure Selectall1Click(Sender: TObject);
    procedure ActionrefreshExecute(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
  private
    // TOOLS
    Procedure clearCC;
    Function pressnametranslate(ccpressname : string):string;
    Function askAndDoALLPLAN:boolean;
    Function makedatastr(tabledef : string;
                             pubdate : tdatetime):String;
    Function applytoCC:boolean;
    Function lookforAfile(filename : String):String;
    //Produktion list
    Function askforproductlist(Specifik : String):Boolean;
    Procedure readAlistfile(filename : String;
                            Specifik : String);
    // plans
    Function PecompdtToDatetime(Pecomstr : String):Tdatetime;
    Procedure RequestAllPlans;
    Function askforPLAN(plannumber : Longint):boolean;
    Function askAndDoAPLAN(Specifikname : string):boolean;
    Function readAPlanfile(filename : String;
                           planlistNumber : Longint;
                           Pressname : String):Boolean;
    Procedure readAPlanTime(filename : String;
                            planlistNumber : Longint);
  public

    Ied : Longint;
    pressid : longint;
    productionid : Longint;
    pubdate : Tdatetime;
    PublicationId : Longint;
    ResultFolder : String;
    PecomPort,Cip3Port    : Integer;
    PecomHost,Cip3Host    : String;
    PecomUsername,Cip3Username : String;
    PecomPassword,Cip3Password : String;
    Activated : Boolean;{ Public declarations }
    planerrormessage : String;
    NMiscstr,MiscstrI : Longint;
    Miscstr : Array[0..100] of record
                                 misc2 : String;
                                 Editionid : Longint;
                                 FoundAfile : String;
                                 Specifik : String;
                                 Pressid : Longint;
                                 presstime : Tdatetime;
                                 Seqnum  : Longint;
                                 Aktstatus : Longint;
                                 productionid : Longint;
                               End;
    Function initialize:Boolean;
    Function TransLateMiscToprod(CCmisc : String;
                                 Pubdate : Tdatetime):string;  // PPPPP.EE til PPPPPEEYYYYMMDD
    Function connecttopecom:Boolean;
    Function GetpecompUsingProduktionList(Specifik : String):Boolean;
    Function Getpecompdirect(Specifik : String):Boolean;
    Function CheckHLonCC(editionid : Longint):Boolean;
    procedure Loadpecompconfig;
    procedure Savepecompconfig;
  end;
var
  FormPecomrequest: TFormPecomrequest;
implementation
Uses
  dateutils, Udata,inifiles,umain,utypes, USelectfolder, UPrefs, UUtils;

{$R *.dfm}
Var
  Nseled : Longint;
  filenamenumber : Longint;
  Aktprodstart,aktprodend : String;
  AktprodstartDT,aktprodendDT : Tdatetime;

procedure TFormPecomrequest.Button1Click(Sender: TObject);
Begin
  memo2.Lines.CLEAR;
  RequestAllPlans;
end;
Function TFormPecomrequest.TransLateMiscToprod(CCmisc : String;
                                               Pubdate : tdatetime):string;  // PPPPP.EE til PPPPPEEYYYYMMDD
Begin
  result := '';
  delete(CCmisc,pos('.',CCmisc),1);
  CCmisc := CCmisc +FormatDateTime('YYYYMMDD',pubdate);
  result := CCmisc;
End;

Function TFormPecomrequest.makedatastr(tabledef : string;
                             pubdate : tdatetime):String;
Var
  Year, Month, Day: Word;
  SYear, SMonth, SDay: string;
Begin
  DecodeDate(pubdate,Year, Month, Day);
  SYear   := inttostr(Year);
  SMonth  := inttostr(Month);
  SDay    := inttostr(Day);
  result := '(datepart(day,'+tabledef+'pubdate) = ' +SDay+' and datepart(month,'+tabledef+'pubdate) = '+smonth+' and datepart(year,'+tabledef+'pubdate) = '+syear+')';
end;

procedure TFormPecomrequest.FormCreate(Sender: TObject);
begin
  randomize;
  Activated := false;
  filenamenumber := 0;
  GroupBox7.Visible := false;
  IF Prefs.CheatPecom Then
  begin
    GroupBox7.Visible := true;
  end;
  OpenDialogdebug.InitialDir := IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory());
  DateTimePickerto.Date := now;
  DateTimePickerto.Date := IncDay(DateTimePickerto.Date,3);
  DateTimePickerfrom.Date := now;
  DateTimePickerfrom.Date := IncDay(DateTimePickerfrom.Date,-3);
  CreateDir(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'temp');
end;

Function TFormPecomrequest.lookforAfile(filename : String):String;
Var
  sycfilename : string;
  foundfile,nofile : Boolean;
  I,Itries : Longint;
  Fromfile,tofile,Path : String;
Begin
  result := '';
  IF Prefs.CheatPecom then
  begin
    Fromfile := IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'Debug.ppf';
    tofile := IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'temp\' + ExtractFileName(filename);
    CopyFile(pchar(fromfile),pchar(tofile),false);
    result := tofile;
  end
  else
  begin
    path := includetrailingbackslash(ResultFolder);
    filename := Path + filename;
    sycfilename := ChangeFileExt(filename,'.syc');

    foundfile := False;
    nofile := false;
    Itries := 0;
    repeat
      Inc(Itries);
      I := 0;
      repeat
        Sleep(1000);
        inc(I);
        Application.ProcessMessages;
        if FileExists(sycfilename) then
          break;
      until i > 10;
      IF FileExists(sycfilename) then
      begin
        IF FileExists(filename) then
        begin
          Fromfile := filename;
          tofile := IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'temp\'+extractfilename(filename);
          copyfile(pchar(fromfile),pchar(tofile),false);
          deletefile(filename);
          deletefile(sycfilename);

          foundfile := true;
          result := tofile;
        end;
      end;
    Until (foundfile) or (Itries > 60);
  End;

End;

procedure TFormPecomrequest.Button3Click(Sender: TObject);
begin
  OpenDialog1.InitialDir := IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory());
  if OpenDialog1.Execute then
  begin
    readAPlanfile(OpenDialog1.FileName,-1,'');
  end;
end;


Function TFormPecomrequest.askforPLAN(plannumber : Longint):boolean;
Var
  Alist : TStrings;
  tot,I : Longint;
  filename : String;
  targetname : String;
  planname : String;
  Delfile : String;
  Gotthisfile : String;
begin
  IF (connecttopecom) or (Prefs.CheatPecom) then
  begin
    Filename := ListViewplans.Items[plannumber].subitems[4];
    targetname := '      <TargetFileName>'+Filename+'</TargetFileName>'; //linje 9
    Delfile := IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'temp\'+targetname+'.ppf';
    deletefile(Delfile);
    Memoplanreq.Lines[9] := targetname;
    Memoplanreq.Lines[15] := '      <![CDATA['+ListViewplans.Items[plannumber].Caption+']]>';
    Memoplanreq.Lines.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + Filename+'.ppf');
    IdFTP1.Put(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory())+Filename+'.ppf',Filename+'.ppf',false);
    sleep(1000);
    IdFTP1.Put(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory())+'Pii.syc',Filename+'.syc',false);

    Gotthisfile := lookforAfile(Filename+'.ppf');
    IF Gotthisfile <> '' then
    begin
      ListViewplans.Items[plannumber].subitems[5] := 'OK';
      result := true;
    end
    Else
    Begin
      result := false;
    End;
  End;
End;

Function TFormPecomrequest.connecttopecom:Boolean;
Var
  T : String;
  ini : tinifile;
Begin
  result := false;
  try
    IF Prefs.CheatPecom then
    begin
      result := true;
    end
    else
    begin
      result := false;
      If not IdFTP1.Connected then
      begin
        Loadpecompconfig;
        IdFTP1.Port     :=  PecomPort;
        IdFTP1.Host     :=  PecomHost;
        IdFTP1.Password :=  PecomPassword;
        IdFTP1.Username :=  PecomUsername;
        IdFTP1.Connect;
      End;
      If IdFTP1.Connected then
        result := true;
    End;
  except
  end;
end;

procedure TFormPecomrequest.FormClose(Sender: TObject; var Action: TCloseAction);
begin
(*  if IdFTP1.Connected then
    IdFTP1.Disconnect; *)
end;


procedure TFormPecomrequest.FormActivate(Sender: TObject);
Var
  T : String;
  ini : Tinifile;
begin
  ProgressBar1.position := 0;
  ProgressBar1.refresh;
  IF Not Activated then
  begin
(*
    IF Not connecttopecom then
    begin
      MessageDlg('Error connecting to pecom server.', mtError,[mbOk], 0);
      Application.Terminate;
    end;
  *)

    Activated := true;
  end;
  CheckHLonCC(-1);
end;
Procedure TFormPecomrequest.RequestAllPlans;
Var
   i : Longint;
begin
  try
    askforproductlist('ALL');


  Except
    Exit;
  end;
  try
    For i := 0 to ListViewplans.Items.Count-1 do
    begin
      askforPLAN(i);
    end;
  Except
    Exit;
  End;
  try
    For i := 0 to ListViewplans.Items.Count-1 do
    begin
      IF ListViewplans.Items[i].SubItems[5] = 'OK' then
      begin
        readAPlanTime(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'temp\'+ListViewplans.Items[i].SubItems[4]+'.ppf',i);
      end;
    end;
  Except
    Exit;
  end;

end;
Procedure TFormPecomrequest.readAPlanTime(filename : String;
                               planlistNumber : Longint);
Var
  I,startP,Npages : Longint;
  L : Tlistitem;
  Planstarttime,Planstoptime : String;
Begin
  try
    try
      Button1.Enabled := false;
      ListViewPagePos.Items.Clear;
      Memoread.lines.LoadFromFile(filename);
      startP := 0;
      For i := 0 to memoread.Lines.Count-1 do
      begin
        IF pos('<plannedProdBegin>',memoread.lines[i]) > 0 then
        Begin
          Planstarttime := memoread.lines[i+1];
          Planstoptime := memoread.lines[i+4];
          delete(Planstarttime,1,pos('>',Planstarttime));
          delete(Planstarttime,pos('<',Planstarttime), 100);
          delete(Planstoptime,1,pos('>',Planstoptime));
          delete(Planstoptime,pos('<',Planstoptime), 100);
          IF planlistNumber > -1 then
          begin
            Listviewplans.Items[planlistNumber].SubItems[6] := Planstarttime;
            Listviewplans.Items[planlistNumber].SubItems[7] := Planstoptime;
          end;
          break;
        end;
      End;
    Except
    End;
  Finally
    Button1.Enabled := true;
  End;
End;

procedure TFormPecomrequest.Button5Click(Sender: TObject);
Var
  i : Longint;
begin
  try
    For i := 0 to ListViewplans.Items.Count-1 do
    begin
      IF (ListViewplans.Items[i].Selected) AND (ListViewplans.Items[i].subitems[5] = 'OK') then
      begin
        readAPlanfile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'temp\'+ListViewplans.Items[i].SubItems[4]+'.ppf',
                      i, '');
      end;
    End;
  Except
  End;
end;
Function  TFormPecomrequest.askforproductlist(Specifik : String):Boolean;
Var
  Alist : TStrings;
  tot,I : Longint;
  filename : String;
  targetname : String;
  Fromtime,totime,Gotthisfile : String;
begin
  Try
    result := False;
    Inc(filenamenumber);
    IF filenamenumber > 100 then
      filenamenumber := 1;
    //        <DateTime>201106010808</DateTime>     //13,16
    Filename := 'pii_CC_list_'+Inttostr(filenamenumber);
    targetname := '      <TargetFileName>'+Filename+'</TargetFileName>'; //linje 9
    Fromtime := '        <DateTime>'+FormatDateTime('yyyymmdd',DateTimePickerfrom.Date) +'0000'+'</DateTime>';
    totime   := '        <DateTime>'+FormatDateTime('yyyymmdd',DateTimePickerto.Date)+'2359'+'</DateTime>';
    Memolisterequest.Lines[9] := targetname;
    Memolisterequest.Lines[13] := Fromtime;
    Memolisterequest.Lines[16] := totime;
    Memolisterequest.Lines.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + Filename+'.ppf');

  //  Alist := TStringList.Create;
    //IdFTP1.List(alist,'*.*',true);
    If connecttopecom then
    begin
      IdFTP1.Put(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + Filename+'.ppf',Filename+'.ppf',false);
      sleep(5000);
      IdFTP1.Put(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'Pii.syc',Filename+'.syc',false);

      ListViewplans.Items.Clear;
      Gotthisfile := lookforAfile(Filename+'.ppf');
      IF Gotthisfile <> '' then
      begin
        readAlistfile(Gotthisfile,Specifik);
      end;
    End;
    IF ListViewplans.Items.Count > 0 then
    begin
      Result := true;
    end;
  Except
  End;
End;
Procedure TFormPecomrequest.readAlistfile(filename : String;
                                          Specifik : String);
Var
  I : Longint;
  L : Tlistitem;
  plname,CCFormID,T : String;
  CCpubdate : tdatetime;
  pldatetime : String;
  Year, Month, Day : String;
  CCdataOK : Boolean;
  CCpublname,CCedname : String;
Begin
  ListViewplans.Items.Clear;
  Memoread.lines.LoadFromFile(filename);
  For i := 0 to memoread.Lines.Count-1 do
  begin
    IF pos('ProductName><![',memoread.lines[i]) > 0 then
    begin
      plname := memoread.lines[i];             //NMATIV820110611
      delete(plname,1,pos('CDATA[',plname)+5);
      delete(plname,pos(']',plname), 100);
      pldatetime := memoread.lines[i+2];
      delete(pldatetime,1,pos('>',pldatetime));
      delete(pldatetime,pos('<',pldatetime), 100);
      IF (length(plname) >= 15) AND ((UPPERCASE(Specifik) = plname) Or (UPPERCASE(Specifik) ='ALL'))  then
      begin
        CCFormID := Copy(plname,1,7);
        T := Copy(plname,8,8);
        Year := Copy(plname,8,4);
        Month := Copy(plname,12,2);
        Day := Copy(plname,14,2);
        CCpubdate :=  EncodeDate(strtoint(Year), strtoint(Month), strtoint(Day));
        DataM1.Query2.SQL.Clear;
        DataM1.Query2.SQL.add('Select distinct pl.name,ed.name,p.publicationid,p.editionid,p.Miscstring2 from pagetable p, PublicationNames pl, editionnames ed');
        DataM1.Query2.SQL.add('Where p.Miscstring2 = '+''''+CCFormID+''''+' and ed.EditionID = p.EditionID and pl.PublicationID = p.PublicationID');
        DataM1.Query2.SQL.add(' and ' + makedatastr('p.',CCpubdate));
        CCdataOK := false;
        DataM1.Query2.open;
        IF not DataM1.Query2.eof then
        begin
          CCdataOK := true;
          CCpublname := DataM1.Query2.fields[0].asstring;
          CCedname := DataM1.Query2.fields[1].asstring;
        end;
        DataM1.Query2.close;
        IF CCdataOK then
        begin
          L := ListViewplans.Items.Add;
          L.Caption := plname;
          l.SubItems.add(pldatetime);
          l.SubItems.add(datetostr(CCpubdate)); //CCdate
          l.SubItems.add(CCpublname); //CCpublication
          l.SubItems.add(CCedname); //CCedition
          l.SubItems.add('pii_CC_plan_'+Inttostr(ListViewplans.Items.count)); //planfilename
          l.SubItems.add('');
          l.SubItems.add('');
          l.SubItems.add('');
          l.SubItems.add('');
          l.SubItems.add('');
          l.SubItems.add('');
        End;
      End;
      //memo2.Lines.add(plname + '    '+ pldatetime);  bare for doc list
    end;
  end;
end;

procedure TFormPecomrequest.Button7Click(Sender: TObject);
begin
  OpenDialog1.InitialDir := IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory());
  if OpenDialog1.Execute then
  begin
    //REQ askforproductlist(Edit2.Text);
    readAlistfile(OpenDialog1.FileName,Edit2.Text);
    //askforPLAN(i);
  end;
end;
Function TFormPecomrequest.GetpecompUsingProduktionList(Specifik : String):Boolean;
Var
  T : String;
  I : Longint;
Begin
  result := false;
  IF askforproductlist(Specifik) then
  begin
    ProgressBar1.position := 1;
    ProgressBar1.refresh;
    T := Specifik;
    For i := 0 to ListViewplans.Items.count-1 do
    begin
      IF uppercase(Specifik) = uppercase(ListViewplans.Items[i].caption) then
      begin
        askforPLAN(i);
        ProgressBar1.position := 2;
        ProgressBar1.refresh;
        IF ListViewplans.Items[i].SubItems[5] = 'OK' then
        begin
          readAPlanTime(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'temp\'+ListViewplans.Items[i].SubItems[4]+'.ppf',0);
          ProgressBar1.position := 3;
          ProgressBar1.refresh;
          IF ListViewplans.Items[i].SubItems[5] = 'OK' then
          begin
            readAPlanfile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'temp\'+ListViewplans.Items[i].SubItems[4]+'.ppf',i,
                          ListViewplans.Items[i].SubItems[1]);
            ProgressBar1.position := 4;
            ProgressBar1.refresh;
          end;
        End;
        break;
      End;
    End;
  end;
End;

Function TFormPecomrequest.applytoCC:boolean;
Var
  I : Longint;
  aktpag : String;
Begin
  try
    For i := 0 to ListViewPagePos.Items.Count-1 do
    begin
      ListViewPagePos.Items[i].SubItems[4] := '';
    End;

    aktpag := 'l�';
    For i := 0 to ListViewPagePos.Items.Count-1 do
    begin
      IF aktpag <> ListViewPagePos.Items[i].Caption then
      begin
        DataM1.Query1.SQL.clear;
        DataM1.Query1.SQL.add('Select Distinct copyflatseparationset from pagetable ');
        DataM1.Query1.SQL.add('Where productionid =  ' + inttostr(Miscstr[MiscstrI].productionid));
        DataM1.Query1.SQL.add('and editionid = ' + inttostr(Miscstr[MiscstrI].Editionid));
        DataM1.Query1.SQL.add('and Pagination = ' + ListViewPagePos.Items[i].Caption);
        DataM1.Query1.SQL.add('and pressid = ' + inttostr(Miscstr[MiscstrI].Pressid));
        if Prefs.debug then
          DataM1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'setpecom.sql');
        DataM1.Query1.open;
        if not DataM1.Query1.eof then
        begin
          ListViewPagePos.Items[i].SubItems[4] := DataM1.Query1.fields[0].asstring;
        end
        Else
        begin
        end;
        DataM1.Query1.close;
        aktpag := ListViewPagePos.Items[i].Caption;
      end;
    end;

    For i := 0 to ListViewPagePos.Items.Count-1 do
    begin
      IF ListViewPagePos.Items[i].SubItems[4] <> '' then
      begin
        DataM1.Query1.SQL.clear;
        DataM1.Query1.SQL.add('update pagetable set ');
        DataM1.Query1.SQL.add('PressTime = :PressTime');
        DataM1.Query1.SQL.add(',PressTower =  ' + ''''+ListViewPagePos.Items[i].SubItems[1]+ '''');
        DataM1.Query1.SQL.add(',PressZone =  ' + ''''+ListViewPagePos.Items[i].SubItems[2]+ '''');
        IF Uppercase(ListViewPagePos.Items[i].SubItems[3]) = 'TOP' then
        begin
          DataM1.Query1.SQL.add(',PressHighLow =  ' +''''+ '1'+ '''');
        end
        Else
        begin
          DataM1.Query1.SQL.add(',PressHighLow =  ' +''''+ '0'+ '''');
        end;
        AktprodstartDT := PecompdtToDatetime(Aktprodstart);
        DataM1.Query1.SQL.add('Where copyflatseparationset =  ' + ListViewPagePos.Items[i].SubItems[4]);
        DataM1.Query1.ParamByName('PressTime').asdatetime := AktprodstartDT;
        if Prefs.debug then
          DataM1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'setpecom.sql');
        DataM1.Query1.ExecSQL;
      End;
    End;
    result := true;
  Except
  end;
End;
procedure TFormPecomrequest.Button9Click(Sender: TObject);
Var
  I : Longint;
Begin
  MiscstrI := ListVieweditions.Selected.Index;
  applytoCC;
End;
Function TFormPecomrequest.askAndDoAPLAN(Specifikname : string):boolean;
Var
  Alist : TStrings;
  tot,I : Longint;
  filename : String;
  targetname : String;
  Calcplanname : Longint;
  Delfile,Gotthisfile : String;
begin
  try
    result := false;
    IF connecttopecom then
    begin
      edited.text := ListVieweditions.items[miscstrI].Caption;
      edited.refresh;
      Filename := changefileext(Specifikname,'');
      targetname := '      <TargetFileName>'+Filename+'</TargetFileName>'; //linje 9
      Delfile := IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'temp\'+targetname+'.ppf';
      deletefile(Delfile);
      Memoplanreq.Lines[9] := targetname;
      Memoplanreq.Lines[15] := '      <![CDATA['+Specifikname+']]>';
      Memoplanreq.Lines.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + Filename+'.ppf');
      IF Not Prefs.CheatPecom then
      begin
        IdFTP1.Put(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + Filename+'.ppf',Filename+'.ppf',false);
        Sleep(1000);
        IdFTP1.Put(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'Pii.syc', Filename+'.syc',false);
      End;
      Gotthisfile := lookforAfile(Filename+'.ppf');
      IF Gotthisfile <> '' then
      begin
        ProgressBar1.Position := ProgressBar1.Position +1;
        ProgressBar1.Refresh;
        IF readAPlanfile(Gotthisfile,-1,ListVieweditions.items[miscstrI].subitems[1]) then
        begin
          ProgressBar1.Position := ProgressBar1.Position +1;
          ProgressBar1.Refresh;
          IF applytoCC then
          begin
            ProgressBar1.Position := ProgressBar1.Position +1;
            ProgressBar1.Refresh;
            result := true;
          end;
        end;
      end;
    End;
  Except
  End;
  edited.text := '';
End;


Function TFormPecomrequest.readAPlanfile(filename : String;
                                         planlistNumber : Longint;
                                         Pressname : String):Boolean;
Var
  I,startP,Npages : Longint;
  L : Tlistitem;
  pagina,color : String;
  pldatetime : String;
  tower,zone,HighLow : String;
  Planstarttime,Planstoptime : String;
  foundanypage : Boolean;
  Pecompressname : String;
Begin
  try
    result := false;
    foundanypage := false;
    ListViewPagePos.Items.Clear;
    ListViewPagePos.Items.BeginUpdate;
    Memoread.lines.LoadFromFile(filename);
    startP := 0;
    Aktprodstart := '';
    aktprodend := '';
(*    press1name = 'CDATA[PlieuseA]';
  press2name = 'CDATA[PlieuseB]';
  press3name = 'CDATA[PlieuseC]';
  *)
    Pecompressname := pressnametranslate(Pressname);

    For i := 0 to memoread.Lines.Count-1 do
    begin
      IF pos(Pecompressname,memoread.lines[i]) > 0 then
      Begin
        startP := i;
        break;
      end;
    End;
    foundanypage := false;
    IF startP > 0 then
    begin
      For i := startP to memoread.Lines.Count-1 do
      begin
        IF pos('<plannedProdBegin>',memoread.lines[i]) > 0 then
        Begin
          Planstarttime := memoread.lines[i+1];
          Planstoptime := memoread.lines[i+4];
          delete(Planstarttime,1,pos('>',Planstarttime));
          delete(Planstarttime,pos('<',Planstarttime), 100);
          delete(Planstoptime,1,pos('>',Planstoptime));
          delete(Planstoptime,pos('<',Planstoptime), 100);
          Aktprodstart := Planstarttime;
          aktprodend := Planstoptime;
          AktprodstartDT := PecompdtToDatetime(Planstarttime);
          aktprodendDT := PecompdtToDatetime(Planstoptime);
  //        aktprodendDT := Planstoptime;

          break;
        end;
      End;

      For i := startP to memoread.Lines.Count-1 do
      begin
        IF pos('<seqPageNumber',memoread.lines[i]) > 0 then
        begin
          pagina := memoread.lines[i];
          delete(pagina,1,pos('>',pagina));
          delete(pagina,pos('<',pagina), 100);
          color := memoread.lines[i+1];
          delete(color,1,pos('"',color));
          delete(color,pos('"',color), 100);
          Tower := memoread.lines[i+2];
          delete(Tower,1,pos('>',Tower));
          delete(Tower,pos('<',Tower), 100);
          Zone := memoread.lines[i+4];
          delete(Zone,1,pos('>',Zone));
          delete(Zone,pos('<',Zone), 100);
          HighLow := memoread.lines[i+6];
          delete(HighLow,1,pos('"',HighLow));
          delete(HighLow,pos('"',HighLow), 100);
          foundanypage := true;
          L := ListViewPagePos.Items.Add;
          L.Caption := pagina;
          l.SubItems.add(color);
          l.SubItems.add(Tower);
          l.SubItems.add(Zone);
          l.SubItems.add(HighLow);
          l.SubItems.add('');
          l.SubItems.add(inttostr(tnames1.Colornametoid(color)));
        end;
      end;
    End;
    ListViewPagePos.Items.EndUpdate;
//    ListViewPagePos.Items.
    result := true;
    If not foundanypage then
    Begin
      planerrormessage := 'Empty plan or no plan';
      result := false;
    End;

  Except
  end;
end;

Function TFormPecomrequest.Getpecompdirect(Specifik : String):Boolean;
Begin
End;
procedure TFormPecomrequest.BitBtn3Click(Sender: TObject);
Var
  I : LongInt;
begin
  Screen.Cursor := crhourglass;
  try
    planerrormessage := '';
    BitBtn3.Enabled := false;
    Nseled := 0;
    ProgressBar1.Position := 0;
    GroupBoxprogress.visible := true;
    GroupBoxprogress.Refresh;
    ProgressBar1.Refresh;
    ProgressBar1.Max := Nseled * 3;
    ProgressBar1.Refresh;
    askAndDoALLPLAN;
    Edited.Text := '';
  Finally
    Screen.Cursor := crdefault;
  end;
  Screen.Cursor := crdefault;
  ProgressBar1.Position := ProgressBar1.Max;
  ProgressBar1.Refresh;
  Sleep(2000);
  BitBtn3.Enabled := true;
  GroupBoxprogress.visible := false;
end;

(*
Var
  I : LongInt;
begin
  Screen.Cursor := crhourglass;
  try
    planerrormessage := '';
    BitBtn3.Enabled := false;
    Nseled := 0;
    ProgressBar1.Position := 0;
    GroupBoxprogress.visible := true;
    GroupBoxprogress.Refresh;
    ProgressBar1.Refresh;
    For I := 0 to ListVieweditions.items.Count-1 do
    begin
      IF ListVieweditions.items[i].Selected then
      begin
        Inc(Nseled);
      End;
    End;
    Ied := 0;
    ProgressBar1.Max := Nseled * 3;
    ProgressBar1.Refresh;
    For I := 0 to ListVieweditions.items.Count-1 do
    begin
      IF ListVieweditions.items[i].Selected then
      begin
        MiscstrI := i;
        Inc(Ied);
        IF askAndDoAPLAN(Miscstr[MiscstrI].Specifik) then
        begin
          CheckHLonCC(Miscstr[MiscstrI].Editionid);
        end
        else
        begin
          ListVieweditions.items[i].SubItems[0] := planerrormessage;
        end;
      end;
    end;
    Edited.Text := '';
  Finally
    Screen.Cursor := crdefault;
  end;
  Screen.Cursor := crdefault;
  ProgressBar1.Position := ProgressBar1.Max;
  ProgressBar1.Refresh;
  Sleep(2000);
  BitBtn3.Enabled := true;
  GroupBoxprogress.visible := false;
end;
*)
Function TFormPecomrequest.CheckHLonCC(editionid : Longint):Boolean;
Var
  i : Longint;
Begin
  For i := 0 to ListVieweditions.items.Count-1 do
  begin
    IF (Miscstr[i].Editionid = editionid) or (editionid < 0) then
    begin
      DataM1.Query1.SQL.clear;
      DataM1.Query1.SQL.add('select distinct editionid from PageTable where  PressHighLow = '+''''+''+'''');
      DataM1.Query1.SQL.add(' and productionid =  ' + inttostr(Miscstr[i+1].productionid));
      DataM1.Query1.SQL.add(' and editionid = ' + inttostr(Miscstr[i+1].Editionid));
      DataM1.Query1.SQL.add(' and pressid = ' + inttostr(Miscstr[i+1].Pressid));
      DataM1.Query1.open;
      if not DataM1.Query1.eof then
      begin
        ListVieweditions.items[i].SubItems[0] := '';
        Miscstr[i+1].Aktstatus := -1;
      end
      Else
      begin
        ListVieweditions.items[i].SubItems[0] := 'OK';
        Miscstr[i+1].Aktstatus := 1;
      end;
      DataM1.Query1.close;
      DataM1.Query1.SQL.clear;
      DataM1.Query1.SQL.add('Select distinct PressSectionNumber,PressTime,Editionid from pagetable ');
      DataM1.Query1.SQL.add('Where productionid =  ' + inttostr(FormPecomrequest.Miscstr[i+1].productionid));
      DataM1.Query1.SQL.add('and pressid = ' + inttostr(FormPecomrequest.Miscstr[i+1].Pressid));
      DataM1.Query1.SQL.add('and Editionid = ' + inttostr(FormPecomrequest.Miscstr[i+1].Editionid));
      DataM1.Query1.SQL.add('order by PressSectionNumber,PressTime ');
      DataM1.Query1.open;
      While not DataM1.Query1.eof do
      begin
        FormPecomrequest.Miscstr[i+1].Seqnum  := DataM1.Query1.fields[0].asinteger;
        IF  FormPecomrequest.Miscstr[i+1].presstime < DataM1.Query1.fields[1].asdatetime then
          FormPecomrequest.Miscstr[i+1].presstime := DataM1.Query1.fields[1].asdatetime;
        DataM1.Query1.open;
        ListVieweditions.items[i].SubItems[2] := inttostr(FormPecomrequest.Miscstr[i+1].Seqnum);
        IF yearof(FormPecomrequest.Miscstr[i+1].presstime) >  2000 then
          ListVieweditions.items[i].SubItems[3] := datetimetostr(FormPecomrequest.Miscstr[i+1].presstime); ;
        DataM1.Query1.Next;
      End;
      DataM1.Query1.close;

    End;

  end;
End;
procedure TFormPecomrequest.Button10Click(Sender: TObject);
Var
  T : String;
begin
  IF OpenDialogdebug.Execute then
  begin
    T := OpenDialogdebug.FileName;
    readAPlanfile(T,0,'');
  end;
end;
procedure TFormPecomrequest.ListViewPagePosCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
Var
  i1,i2 : Longint;
begin
  i1 := strtoint(Item1.caption);
  i2 := strtoint(Item2.caption);
  Compare := 0;
  if i1 > i2 then
    Compare := 1
  else
    if i1 < i1 then
      Compare := -1;
end;
procedure TFormPecomrequest.Selectall1Click(Sender: TObject);
begin
  ListVieweditions.SelectAll;
end;

Function TFormPecomrequest.PecompdtToDatetime(Pecomstr : String):Tdatetime;
Var
  T,Tyear,Tmonth,Tday,Thour,Tminute,Tsecond : string;
  year,month,day,hour,minute,second : Longint;
Begin
  result := now;
(*
      <DateTime>201106150747</DateTime>
YYYYMMDDHHMM
201106150747
*)
  Try
    T := Pecomstr;
    IF pos('<DateTime>',T) > 0 then
    begin
      delete(t,1,pos('>',t));
    end;
    IF pos('</DateTime>',T) > 0 then
    begin
      delete(t,pos('<',t),200);
    End;

    Tyear := Copy(t,1,4);
    Tmonth := Copy(t,5,2);
    Tday   := Copy(t,7,2);
    Thour  := Copy(t,9,2);
    Tminute := Copy(t,11,2);
    year := strtoint(Tyear);
    month := strtoint(Tmonth);
    day   := strtoint(Tday);
    hour  := strtoint(Thour);
    minute := strtoint(Tminute);
    result := encodedatetime(year,month,day,hour,minute,0,0);
  Except
  end;

End;

procedure TFormPecomrequest.ActionrefreshExecute(Sender: TObject);
begin
  (*DataM1.Query1.SQL.clear;
  DataM1.Query1.SQL.add('select distinct editionid from PageTable where  PressHighLow = '+''''+''+'''');
  DataM1.Query1.SQL.add(' and productionid =  ' + inttostr(productionid));
  DataM1.Query1.SQL.add(' and editionid = ' + inttostr(Miscstr[i].Editionid));
  *)
end;
Function TFormPecomrequest.initialize:Boolean;
Var
  I,i2,aktpressid : longint;
  Specifikdata : String;
  DTstring : String;
  runnode : Ttreenode;
  L : TlistItem;
Begin
  try
    result := false;
    DataM1.Query1.SQL.clear;
    DataM1.Query1.SQL.add('Select distinct p.pressid,p.Editionid,p.Miscstring2,e.name,pr.PressName,p.productionid from pagetable P, editionnames e,PressNames pr');
    DataM1.Query1.SQL.add('Where p.publicationid =  ' + inttostr(FormPecomrequest.publicationid));
    DataM1.Query1.SQL.add(' and '+  DataM1.makedatastr('p.',FormPecomrequest.pubdate));
    //DataM1.Query1.SQL.add('and p.productionid =  ' + inttostr(FormPecomrequest.productionid));
    DataM1.Query1.SQL.add('and p.Miscstring2 <> '+''''+'''');
    DataM1.Query1.SQL.add('and p.editionid = e.editionid');
    DataM1.Query1.SQL.add('and pr.pressid = p.pressid');
    DataM1.Query1.SQL.add('order by e.name,pr.PressName ');
    if Prefs.debug then DataM1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'getpecompinit.sql');
    DataM1.Query1.open;
    FormPecomrequest.NMiscstr := 0;
    FormPecomrequest.ListVieweditions.items.clear;
    While not DataM1.Query1.eof do
    begin
      FormPecomrequest.pressid := DataM1.Query1.fields[0].asinteger;
      Inc(FormPecomrequest.NMiscstr);
      FormPecomrequest.Miscstr[FormPecomrequest.NMiscstr].misc2 := DataM1.Query1.fields[2].asstring;
      FormPecomrequest.Miscstr[FormPecomrequest.NMiscstr].editionid := DataM1.Query1.fields[1].asInteger;
      FormPecomrequest.Miscstr[FormPecomrequest.NMiscstr].Pressid  := DataM1.Query1.fields[0].asInteger;
      FormPecomrequest.Miscstr[FormPecomrequest.NMiscstr].Seqnum  := -1;;
      FormPecomrequest.Miscstr[FormPecomrequest.NMiscstr].Aktstatus := -1;
      FormPecomrequest.Miscstr[FormPecomrequest.NMiscstr].presstime := encodedatetime(1900,1,1,1,1,0,0);
      FormPecomrequest.Miscstr[FormPecomrequest.NMiscstr].productionid := DataM1.Query1.fields[5].asInteger;
      FormPecomrequest.Miscstr[FormPecomrequest.NMiscstr].FoundAfile := '';
      L := FormPecomrequest.ListVieweditions.items.add;
      L.Caption := DataM1.Query1.fields[3].asstring;
      L.SubItems.Add('');   //status
      L.SubItems.Add(DataM1.Query1.fields[4].asstring);   //pressname
      L.SubItems.Add('');   //Sequence
      L.SubItems.Add('');   //time
      L.SubItems.Add('');   //filename
      FormPecomrequest.Miscstr[FormPecomrequest.NMiscstr].Specifik := FormPecomrequest.TransLateMiscToprod(DataM1.Query1.fields[2].asstring,FormPecomrequest.pubdate);
      DataM1.Query1.next;
    end;
    DataM1.Query1.close;
    if FormPecomrequest.NMiscstr > 0 then
      CheckHLonCC(-1);
    result := FormPecomrequest.NMiscstr > 0;

  Except
    result := false;
  end;
End;
Function TFormPecomrequest.pressnametranslate(ccpressname : string):string;
Begin
  IF POS('1',ccpressname) > 0 then
    result := 'CDATA[PlieuseA]';
  IF POS('2',ccpressname) > 0 then
    result := 'CDATA[PlieuseB]';
  IF POS('3',ccpressname) > 0 then
    result := 'CDATA[PlieuseC]';
end;
procedure TFormPecomrequest.Loadpecompconfig;
Var
  ini : tinifile;
Begin
  try
    ini := Tinifile.Create(TUtils.GetPlanCenterIniFilePath(Prefs.PlanCenterConfigFileName));
    ResultFolder := ini.ReadString('Pecom','Resultfiles','\\10.163.0.31\CCMANROLAND\PressPlan');
    PecomHost     := ini.ReadString('Pecom','PecomHost','10.163.0.1');
    PecomPort     := ini.ReadInteger('Pecom','PecomPort',21);
    PecomUsername  := ini.ReadString('Pecom','PecomUsername','pifpii');
    PecomPassword  := ini.ReadString('Pecom','PecomPassword','pii000');
    Cip3Host     := ini.ReadString('Pecom','Cip3Host','10.163.0.1');
    Cip3Port     := ini.ReadInteger('Pecom','Cip3Port',21);
    Cip3Username  := ini.ReadString('Pecom','Cip3Username','pifpii');
    Cip3Password  := ini.ReadString('Pecom','Cip3Password','pii000');
    ini.free;
  except
  end;
  Editcompfilefolder.text := ResultFolder;
  EditcompHost.text := PecomHost;
  Editport.text := inttostr(PecomPort);
  Editpecompuser.text := PecomUsername;
  Editpecomppassword.text := PecomPassword;
  EditCip3Host.text := Cip3Host;
  EditCip3port.text := inttostr(Cip3Port);
  EditCip3user.text := Cip3Username;
  EditCip3password.text := Cip3Password;

end;
procedure TFormPecomrequest.Savepecompconfig;
Var
  T : String;
  ini : tinifile;
Begin
  ResultFolder := Editcompfilefolder.text;
  PecomHost := EditcompHost.text;
  PecomPort := strtoint(Editport.text);
  PecomUsername := Editpecompuser.text;
  PecomPassword := Editpecomppassword.text;
  Cip3Host := EditcompHost.text;
  Cip3Port := strtoint(EditCip3port.text);
  Cip3Username := EditCip3user.text;
  Cip3Password := EditCip3password.text;
  try
    ini := Tinifile.Create(TUtils.GetPlanCenterIniFilePath(Prefs.PlanCenterConfigFileName));
    ini.writeString('Pecom','Resultfiles',ResultFolder);
    ini.writeString('Pecom','PecomHost',PecomHost);
    ini.writeInteger('Pecom','PecomPort',PecomPort);
    ini.writeString('Pecom','PecomUsername',PecomUsername);
    ini.writeString('Pecom','PecomPassword',PecomPassword);
    ini.writeString('Pecom','CIP3Host',CIP3Host);
    ini.writeInteger('Pecom','CIP3Port',CIP3Port);
    ini.writeString('Pecom','CIP3Username',CIP3Username);
    ini.writeString('Pecom','CIP3Password',CIP3Password);
    ini.free;
  except
  end;
end;

procedure TFormPecomrequest.Button8Click(Sender: TObject);
begin
  try
    if IdFTP1.Connected then
      IdFTP1.Disconnect;
    IdFTP1.Port     :=  strtoint(Editport.text);
    IdFTP1.Host     :=  EditcompHost.text;
    IdFTP1.Password :=  Editpecomppassword.text;
    IdFTP1.Username :=  Editpecompuser.text;
    IdFTP1.Connect;
    if IdFTP1.Connected then
      MessageDlg('FTP connection OK', mtInformation,[mbOk], 0)
    else
      MessageDlg('Unable to connect to Pecom ftp server', mtError,[mbOk], 0);

  except
    MessageDlg('Unable to connect to Pecom ftp server', mtError,[mbOk], 0);
  end;
end;
procedure TFormPecomrequest.Button11Click(Sender: TObject);
begin
 { IF FormSelectfolder.showmodal = mrok then
  begin
    Editcompfilefolder.text :=  FormSelectfolder.ShellTreeView1.Path;
  End;  }
   with TFileOpenDialog.Create(nil) do
        try
          Options := [fdoPickFolders];
          if Execute then
            Editcompfilefolder.Text  := FileName;
        finally
          Free;
        end;
end;
procedure TFormPecomrequest.BitBtn5Click(Sender: TObject);
begin
  Savepecompconfig;
end;
procedure TFormPecomrequest.BitBtn6Click(Sender: TObject);
begin
  Loadpecompconfig;
end;

Function TFormPecomrequest.askAndDoALLPLAN:boolean;
Var
  Alist : TStrings;
  tot,I : Longint;
  filename : String;
  targetname : String;
  Calcplanname : Longint;
  Delfile : String;
  Aktedition,Gotthisfile : String;
  aktspecifik : String;
  Fileforspecifik : String;
begin
  try
    result := false;
    IF connecttopecom then
    begin
      ProgressBar1.Position := 0;
      ProgressBar1.max := ListVieweditions.items.Count * 2;
      Aktedition := 'fdfdfdfdfd';
      Gotthisfile := '';
      targetname := 'jsksajska';
      aktspecifik := '';
      GroupBoxprogress.Caption := 'Calling PPM';
      GroupBoxprogress.repaint;
      clearCC;
      For I := 0 to ListVieweditions.items.Count-1 do
      begin
        ProgressBar1.Position := ProgressBar1.Position +1;
        ProgressBar1.Repaint;
        application.ProcessMessages;
        IF Aktedition <> ListVieweditions.items[i].caption then
        begin
          Edited.Text := ListVieweditions.items[i].caption;
          Edited.repaint;
          application.ProcessMessages;
          Gotthisfile := '';
          Aktedition := ListVieweditions.items[i].caption;
          Filename := changefileext(Miscstr[i+1].Specifik,'');
          targetname := '      <TargetFileName>'+Filename+'</TargetFileName>'; //linje 9
          Delfile := IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'temp\'+targetname+'.ppf';
          deletefile(Delfile);
          Memoplanreq.Lines[9] := targetname;
          Memoplanreq.Lines[15] := '      <![CDATA['+Miscstr[i+1].Specifik+']]>';
          Memoplanreq.Lines.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + Filename+'.ppf');
          IF Not Prefs.CheatPecom then
          begin
            IdFTP1.Put(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + Filename+'.ppf',Filename+'.ppf',false);
            sleep(1000);
            IdFTP1.Put(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'Pii.syc',Filename+'.syc',false);
          End;
          Gotthisfile := lookforAfile(Filename+'.ppf');
          IF Gotthisfile <> '' then
          begin
            aktspecifik := Miscstr[i+1].Specifik;
            Miscstr[i+1].foundafile := Gotthisfile;
            ListVieweditions.items[i].Subitems[4] := Gotthisfile;
          End;
        End
        Else
        Begin
          if Miscstr[i+1].Specifik = aktspecifik then
          Begin
            IF Gotthisfile <> '' then
            begin
              ListVieweditions.items[i].Subitems[4] := Gotthisfile;
              Miscstr[i+1].foundafile := Gotthisfile;
            end;
          End;
        End;
      End;
      GroupBoxprogress.Caption := 'Analysing PPM data';
      GroupBoxprogress.repaint;
      For I := 0 to ListVieweditions.items.Count-1 do
      begin
        ProgressBar1.Position := ProgressBar1.Position +1;
        ProgressBar1.Repaint;
        Edited.Text := ListVieweditions.items[i].caption;
        Edited.repaint;
        application.ProcessMessages;
        IF Miscstr[I+1].FoundAfile <> '' then
        begin
          filename := Miscstr[I+1].FoundAfile;
          miscstrI := I+1;
          IF readAPlanfile(filename,-1,ListVieweditions.items[I].subitems[1]) then
          begin
            IF applytoCC then
            begin
              result := true;
            end;
          end;
        End;
      end;
      For I := 0 to ListVieweditions.items.Count-1 do
      begin
        IF Miscstr[I+1].FoundAfile <> '' then
        begin
          deletefile(Miscstr[I+1].FoundAfile);
        End;  
      End;
    End;
  Except
  End;
  edited.text := '';
  CheckHLonCC(-1);
End;

Procedure TFormPecomrequest.clearCC;
Begin
  try
    DataM1.Query1.SQL.clear;
    DataM1.Query1.SQL.add('update PageTable set PressHighLow = '+''''+''+''''+', PressTower = '+''''+''+''''+', PressZone = '+''''+''+''''+', PressTime = '+''''+'1975-01-01 00:00'+'''');
    DataM1.Query1.SQL.add('Where publicationid =  ' + inttostr(FormPecomrequest.publicationid));
    DataM1.Query1.SQL.add(' and '+  DataM1.makedatastr('',FormPecomrequest.pubdate));
    if Prefs.debug then
      DataM1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'CLearccpecomp.sql');
    DataM1.Query1.ExecSQL;
  Except
  end;
End;
procedure TFormPecomrequest.Button12Click(Sender: TObject);
begin
try
    IF IdFTP2.Connected then
      IdFTP2.Disconnect;
    IdFTP2.Port     :=  strtoint(Editcip3port.text);
    IdFTP2.Host     :=  Editcip3Host.text;
    IdFTP2.Password :=  Editcip3password.text;
    IdFTP2.Username :=  Editcip3user.text;
    IdFTP2.Connect;
    IF  IdFTP2.Connected then
      MessageDlg('FTP connection OK', mtInformation,[mbOk], 0)
    Else
      MessageDlg('Unable to connect to Pecom ftp server', mtError,[mbOk], 0);

  Except
    MessageDlg('Unable to connect to Pecom ftp server', mtError,[mbOk], 0);
  end;
end;
end.
