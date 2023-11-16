unit USelnexttimedEd;
(*
skab alle regionale editions
add timed editions til alle editions som senere skal låses
sæt to og from edition takket være valg i add

Vælg en edition som skal låses
bær dens egenskaber af unique/common vidre til dens toedition
sæt status 2 mens der arbejdes
sæt state  1 når en edition er blevet den nye der skal bruges
sæt state 10 når der gås vidre f.eks. 1-2-3 når det er ed 3 er 1 og 2 state 10

Nye master størrelser er + 100000

*)
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, CheckLst;

Const
  //nymasteredsize = 100000;
  nymasteredsize = 0;


type
  TFormSelnexttimedEd = class(TForm)
    Panel3: TPanel;
    Image2: TImage;
    Label7: TLabel;
    Label8: TLabel;
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    Label1: TLabel;
    EditSeled: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBoxprg: TGroupBox;
    Progressprg: TProgressBar;
    GroupBox2: TGroupBox;
    TreeVieweds: TTreeView;
    Label2: TLabel;
    Editnext: TEdit;
    Panel2: TPanel;
    Image1: TImage;
    Panel4: TPanel;
    Image3: TImage;
    GroupBox3: TGroupBox;
    CheckListBox1: TCheckListBox;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    Procedure preparefileserverpaths;
  public
    { Public declarations }
    SelEd         : Longint;
    Productionid  : Longint;
    NewEd         : Longint;
    Newpressrunid : Longint;
    procedure Loaddata;
  end;

var
  FormSelnexttimedEd: TFormSelnexttimedEd;

implementation

{$R *.dfm}
Uses
  utypes,umain,Udata,ShellApi, Usettings, UUtils;
Var
  filesfrom,filesto : TStrings;
  Foldersfrom,Foldersto : TStrings;
  

  NFileserverpaths : Longint;
  Fileserverpaths : Array[1..100] of record
                                       Servertype                  : Longint;
                                       Fileservername              : string;
                                       CCfiles                     : string;
                                       CCpreviews                  : string;
                                       CCthumbnails                : string;
                                       CCreadviewpreviews          : string;
                                       CCVersions                  : string;
                                       CCWEBpreviews               : string;
                                       CCWEBthumbnails             : string;
                                       CCWEBreadviewpreviews       : string;
                                       CCPDFfiles                  : String;
                                       CCPdflogs                   : String;
                                       Locationid                  : Longint;
                                     end;


Procedure TFormSelnexttimedEd.preparefileserverpaths;
Var
  I : longint;
  CCRoot : string;
Begin
  NFileserverpaths := 0;
  try
    for i := 1 to 100 do
    begin
      Fileserverpaths[I].CCfiles := '';
      Fileserverpaths[I].CCpreviews := '';
      Fileserverpaths[I].CCthumbnails := '';
      Fileserverpaths[I].CCreadviewpreviews := '';
      Fileserverpaths[I].CCVersions := '';

      Fileserverpaths[I].CCWEBpreviews := '';
      Fileserverpaths[I].CCWEBthumbnails := '';
      Fileserverpaths[I].CCWEBreadviewpreviews := '';
      Fileserverpaths[I].CCPDFfiles := '';
      Fileserverpaths[I].CCPdflogs := '';

      Fileserverpaths[I].Servertype  := -1;
      Fileserverpaths[I].Fileservername  := '';
      Fileserverpaths[I].Locationid      := -1;
    end;




    DataM1.Query1.sql.clear;
    DataM1.Query1.sql.add('Select * from GeneralPreferences');
    DataM1.Query1.open;

    Inc(NFileserverpaths);
    Fileserverpaths[NFileserverpaths].Servertype  := 1;
    Fileserverpaths[NFileserverpaths].Fileservername   := uppercase(DataM1.Query1.fieldbyname('ServerName').asstring);

    Fileserverpaths[NFileserverpaths].CCfiles          := includetrailingbackslash(DataM1.Query1.fieldbyname('ServerFilePath').asstring);
    CCRoot := Uppercase(Fileserverpaths[NFileserverpaths].CCfiles);
    delete(CCRoot,pos('CCFILES',CCRoot),100);
    CCRoot := includetrailingbackslash(CCRoot);
    Fileserverpaths[NFileserverpaths].Locationid       := -1;
    Fileserverpaths[NFileserverpaths].CCpreviews       := includetrailingbackslash(DataM1.Query1.fieldbyname('ServerPreviewPath').asstring);
    Fileserverpaths[NFileserverpaths].CCthumbnails        := includetrailingbackslash(DataM1.Query1.fieldbyname('ServerThumbnailPath').asstring);
    Fileserverpaths[NFileserverpaths].CCreadviewpreviews  := CCRoot + 'CCreadviewpreviews\';
    Fileserverpaths[NFileserverpaths].CCVersions          := CCRoot + 'CCVersions\';
    DataM1.Query1.close;

    DataM1.Query1.sql.clear;
    DataM1.Query1.sql.add('Select * from Fileservers');
    DataM1.Query1.sql.add('order by Servertype ');



    DataM1.Query1.open;
    While not DataM1.Query1.eof do
    begin
      IF DataM1.Query1.fieldbyname('Servertype').asinteger = 1 then
        Dec(NFileserverpaths);

      Inc(NFileserverpaths);
      Fileserverpaths[NFileserverpaths].CCfiles := '';
      Fileserverpaths[NFileserverpaths].CCpreviews := '';
      Fileserverpaths[NFileserverpaths].CCthumbnails := '';
      Fileserverpaths[NFileserverpaths].CCreadviewpreviews := '';
      Fileserverpaths[NFileserverpaths].CCVersions := '';

      Fileserverpaths[NFileserverpaths].CCWEBpreviews := '';
      Fileserverpaths[NFileserverpaths].CCWEBthumbnails := '';
      Fileserverpaths[NFileserverpaths].CCWEBreadviewpreviews := '';
      Fileserverpaths[NFileserverpaths].CCPDFfiles := '';
      Fileserverpaths[NFileserverpaths].CCPdflogs := '';

      Fileserverpaths[NFileserverpaths].Servertype  := DataM1.Query1.fieldbyname('Servertype').asinteger;
      Fileserverpaths[NFileserverpaths].Fileservername  := uppercase(DataM1.Query1.fieldbyname('Name').asstring);
      Fileserverpaths[NFileserverpaths].Locationid              := DataM1.Query1.fieldbyname('Locationid').asinteger;

      IF DataM1.Query1.fieldbyname('Servertype').asinteger IN [1,2,5,7] then
      begin

        IF DataM1.Query1.fieldbyname('IP').asstring <> '' then
        Begin
          CCRoot := '\\'+DataM1.Query1.fieldbyname('IP').asstring + '\'+ includetrailingbackslash(DataM1.Query1.fieldbyname('CCdatashare').asstring);
        End
        else
        Begin
          IF POS(':',DataM1.Query1.fieldbyname('CCdatashare').asstring) > 0 then
            CCRoot :=  includetrailingbackslash(DataM1.Query1.fieldbyname('CCdatashare').asstring)
          else
            CCRoot := '\\'+Fileserverpaths[NFileserverpaths].Fileservername + '\'+ includetrailingbackslash(DataM1.Query1.fieldbyname('CCdatashare').asstring);
        End;


        Case Fileserverpaths[NFileserverpaths].Servertype of
          1..2 : Begin
                   Fileserverpaths[NFileserverpaths].CCfiles          := CCRoot + 'CCfiles\';
                   IF not directoryexists(Fileserverpaths[NFileserverpaths].CCfiles) then
                     Fileserverpaths[NFileserverpaths].CCfiles := '';
                   Fileserverpaths[NFileserverpaths].CCpreviews       := CCRoot + 'CCpreviews\';
                   IF not directoryexists(Fileserverpaths[NFileserverpaths].CCpreviews) then
                     Fileserverpaths[NFileserverpaths].CCpreviews := '';
                   Fileserverpaths[NFileserverpaths].CCthumbnails        := CCRoot + 'CCthumbnails\';
                   IF not directoryexists(Fileserverpaths[NFileserverpaths].CCthumbnails) then
                     Fileserverpaths[NFileserverpaths].CCthumbnails        := '';
                 End;
          5 : Begin
                Fileserverpaths[NFileserverpaths].CCWEBpreviews       := CCRoot + 'CCpreviews\';
                Fileserverpaths[NFileserverpaths].CCWEBthumbnails       := CCRoot + 'CCthumbnails\';
                Fileserverpaths[NFileserverpaths].CCWEBreadviewpreviews   := CCRoot + 'CCreadviewpreviews\';
              End;
          7 : Begin
                Fileserverpaths[NFileserverpaths].CCPDFFiles       := CCRoot + 'CCPDFFiles\';
                Fileserverpaths[NFileserverpaths].CCPDFlogs       := CCRoot + 'CCPDFlogs\';
              End;
        end;

      End;

      DataM1.Query1.next;
    end;
    DataM1.Query1.close;



  Except

  end;
End;

procedure TFormSelnexttimedEd.FormActivate(Sender: TObject);
Var
  t : String;
begin
  try
    GroupBoxprg.visible := false;
    EditSeled.Text := tnames1.editionIDtoname(seled);
    preparefileserverpaths;

  Except
  end;

end;

procedure TFormSelnexttimedEd.BitBtn1Click(Sender: TObject);


Procedure LookforRview(Folder : string;
                       master : string;
                       Var foundfile : String;
                       Var foundfolder : string);



Function makenewreadviewfilename(foundname   : string;
                                 Aktmaster : String;
                                 isleftinname : boolean):String;
Var
  foundext,othermast : String;
  I : Longint;


Function makeNMast:String;

Var
  Iresult : Longint;
Begin
  result := '';
  try
    Iresult := strtoint(foundname);
    IF (Iresult > 0) and (Iresult < nymasteredsize) then
    begin
        Iresult := Iresult + nymasteredsize;
    end;
    result := inttostr(Iresult);
  except
  end;
End;

Begin
  foundext := extractfileext(foundname);
  foundname := changefileext(foundname,'');
  result := '';
  if isleftinname then
  begin
    delete(foundname,1,pos('_',foundname));
    othermast := makeNMast;
    result := inttostr((strtoint(Aktmaster)+nymasteredsize))+ '_'+ othermast+foundext;
  end
  else
  begin
    delete(foundname,pos('_',foundname),100);
    othermast := makeNMast;
    result := othermast + '_'+inttostr((strtoint(Aktmaster)+nymasteredsize))+foundext;
  end;

end;

Var
  I,i2 : Longint;
  F: TSearchRec;
  tofile : String;
Begin
  foundfolder := '';
  foundfile   := '';
  try
    I := FindFirst(Folder+master+'_*',faAnyFile	,F);
    While I = 0 do
    begin
      IF f.Attr = faDirectory	 then
      Begin
        foundfolder := f.name;
        tofile := makenewreadviewfilename(foundfolder,master,true);
        Foldersfrom.add(Folder+foundfolder);
        Foldersto.add(Folder+tofile);
      End
      Else
      Begin
        foundfile := f.name;
        tofile := makenewreadviewfilename(foundfile,master,true);
        filesfrom.add(Folder+foundfolder);
        filesto.add(Folder+tofile);

      End;
      I := findnext(f);
    end;

    Findclose(f);
  Except
  end;
  Try
    I := FindFirst(Folder+'*_'+master+'.*',faAnyFile	,F);
    While I = 0 do
    begin
      IF f.Attr = faDirectory	 then
      Begin
        foundfolder := f.name;
        tofile := makenewreadviewfilename(foundfolder,master,false);
        Foldersfrom.add(Folder+foundfolder);
        Foldersto.add(Folder+tofile);

      End
      Else
      Begin
        foundfile := f.name;
        tofile := makenewreadviewfilename(foundfile,master,false);
        filesfrom.add(Folder+foundfile);
        filesto.add(Folder+tofile);
      End;
      I := findnext(f);
    end;
    Findclose(f);
  Except
  end;
end;


function CopyAWebDir(fromDir, toDir: string): Boolean;
var
  FromTiledir,ToTiledir,ff,tt : String;
  I,i2 : Longint;
  F: TSearchRec;

begin
  FromTiledir := Includetrailingbackslash(fromDir)+'TileGroup0\';
  ToTiledir := Includetrailingbackslash(ToDir)+'TileGroup0\';
  createdir(toDir);
  createdir(ToTiledir);
  toDir := Includetrailingbackslash(toDir);

  try
    I := FindFirst(FromTiledir+'*.*',faAnyFile	,F);
    While I = 0 do
    begin
      IF (f.Attr <> faDirectory) And (f.name <> '.') And (f.name <> '..')	 then
      Begin
        ff := FromTiledir+f.name;
        tt := ToTiledir+f.name;
        copyfile(pchar(ff),pchar(tt),false);
      End;
      I := findnext(f);
    end;
    Findclose(f);
    result := copyfile(pchar(Includetrailingbackslash(fromDir)+'ImageProperties.xml'),
                       pchar(Includetrailingbackslash(ToDir)+'ImageProperties.xml'),false);

  Except
  end;
end;

Procedure copypdffiles(path : string;
                       ext  : String; //eg .pdf .log
                       Master : String);
Var
  I : Longint;
  F: TSearchRec;
  SearchT : String;
  foundfile,tofile : String;
  T1,T2 : String;
  newmast : String;

Begin
  try
    newmast := inttostr( strtoint(Master)+nymasteredsize );
    SearchT := '*_'+Master +ext;
    path := includetrailingbackslash(path);
    foundfile := '';
    I := FindFirst(path+SearchT,faAnyFile	,F);
    While I = 0 do
    begin
      IF (f.Attr <> faDirectory) And (f.name <> '.') And (f.name <> '..')	 then
      Begin
        foundfile := f.Name;
        break;
      end;
      I := findnext(f);
    end;
    Findclose(f);
    IF foundfile <> '' then
    begin
      tofile := foundfile;
      delete(tofile,1+(length(foundfile)-length('_'+Master +ext)),1000);
      tofile := tofile +'_'+newmast+ext;
      copyfile(pchar(path+foundfile),pchar(path+tofile),false);
    end;
  except
  end;
end;

Function copymastfiles(master : Longint;
                       color : string;
                       Mainmaster : Boolean;
                       FileName : string;
                       PreviewGUID : String) : Boolean;

Var
  Ipath : Longint;
  Imast : Longint;

  frommaster,tomaster : String;
  fromfile,tofile : String;

  foundfile,tofoundfile : String;
  foundfolder,tofoundfolder : string;

Begin
(*
1 mainserver
2 localserver al'a norttælje
3 remoteserver dvs outputcenter maskine med workfolder
4 inkserver inkcenter med inkprevies
5 webserver
6 backupserver
7 PDF SERVER
kun hvis der er en type 2 er der tale om et multiserver system ligesom i NT
*)

  frommaster := inttostr(master);
  tomaster := inttostr(master+nymasteredsize);
  for Ipath := 1 to NFileserverpaths do
  begin
    IF Fileserverpaths[Ipath].Servertype <> 6 then
    begin
      IF Fileserverpaths[Ipath].CCfiles <> '' then
      begin
        fromfile := Fileserverpaths[Ipath].CCfiles +FileName+ '====' + frommaster+'.'+color;
        tofile := Fileserverpaths[Ipath].CCfiles +FileName+ '====' + tomaster+'.'+color;
        if ( NOT Fileexists(fromfile)) then
        begin
          fromfile := Fileserverpaths[Ipath].CCfiles + frommaster+'.'+color;
          tofile := Fileserverpaths[Ipath].CCfiles + tomaster+'.'+color;
        end;
        filesfrom.add(fromfile);
        filesto.add(tofile);
      end;

      IF Fileserverpaths[Ipath].CCpreviews <> '' then
      begin

        fromfile := Fileserverpaths[Ipath].CCpreviews + frommaster+'_'+color+'.jpg';
        tofile := Fileserverpaths[Ipath].CCpreviews + tomaster+'_'+color+'.jpg';

        if (Prefs.NewPreviewNames) then
        begin
          fromfile := Fileserverpaths[Ipath].CCpreviews +PreviewGUID+ '===='+ frommaster+'_'+color+'.jpg';
          tofile := Fileserverpaths[Ipath].CCpreviews +PreviewGUID+ '====' + tomaster+'_'+color+'.jpg';

          if ( NOT Fileexists(fromfile)) then
          begin
            fromfile := Fileserverpaths[Ipath].CCpreviews + frommaster+'_'+color+'.jpg';
            tofile := Fileserverpaths[Ipath].CCpreviews + tomaster+'_'+color+'.jpg';
          end;
        end;

        filesfrom.add(fromfile);
        filesto.add(tofile);

        IF Mainmaster Then
        Begin

          fromfile := Fileserverpaths[Ipath].CCpreviews + frommaster+'.jpg';
          tofile := Fileserverpaths[Ipath].CCpreviews + tomaster+'.jpg';
          if (Prefs.NewPreviewNames) then
          begin
            fromfile := Fileserverpaths[Ipath].CCpreviews +PreviewGUID+ '===='+ frommaster+'.jpg';
            tofile := Fileserverpaths[Ipath].CCpreviews +PreviewGUID+ '===='+ tomaster+'.jpg';
            if ( NOT Fileexists(fromfile)) then
            begin
              fromfile := Fileserverpaths[Ipath].CCpreviews + frommaster+'.jpg';
              tofile := Fileserverpaths[Ipath].CCpreviews + tomaster+'.jpg';
            end;
          end;
          filesfrom.add(fromfile);
          filesto.add(tofile);
        end;
      end;

      IF Fileserverpaths[Ipath].CCthumbnails <> '' then
      begin
        IF Mainmaster Then
        Begin
          fromfile := Fileserverpaths[Ipath].CCthumbnails + frommaster+'.jpg';
          tofile := Fileserverpaths[Ipath].CCthumbnails + tomaster+'.jpg';
          if (Prefs.NewPreviewNames) then
          begin
            fromfile := Fileserverpaths[Ipath].CCthumbnails + PreviewGUID+ '===='+ frommaster+'.jpg';
            tofile := Fileserverpaths[Ipath].CCthumbnails + PreviewGUID+ '====' + tomaster+'.jpg';
            if ( NOT Fileexists(fromfile)) then
            begin
              fromfile := Fileserverpaths[Ipath].CCthumbnails + frommaster+'.jpg';
              tofile := Fileserverpaths[Ipath].CCthumbnails + tomaster+'.jpg';
            end;
          end;
          filesfrom.add(fromfile);
          filesto.add(tofile);

        End;
      End;

      IF Fileserverpaths[Ipath].CCWEBpreviews <> '' then
      begin
        fromfile := Fileserverpaths[Ipath].CCWEBpreviews + frommaster+'_'+color+'.jpg';
        tofile := Fileserverpaths[Ipath].CCWEBpreviews + tomaster+'_'+color+'.jpg';
        if (Prefs.NewPreviewNames) then
        begin
          fromfile := Fileserverpaths[Ipath].CCWEBpreviews + PreviewGUID+ '===='+ frommaster+'_'+color+'.jpg';
          tofile := Fileserverpaths[Ipath].CCWEBpreviews + PreviewGUID+ '===='+ tomaster+'_'+color+'.jpg';
          if ( NOT Fileexists(fromfile)) then
          begin
            fromfile := Fileserverpaths[Ipath].CCWEBpreviews + frommaster+'_'+color+'.jpg';
            tofile := Fileserverpaths[Ipath].CCWEBpreviews + tomaster+'_'+color+'.jpg';
          end;
        end;
        filesfrom.add(fromfile);
        filesto.add(tofile);

        Foldersfrom.add(Fileserverpaths[Ipath].CCWEBpreviews + frommaster+'_'+color);
        Foldersto.add(Fileserverpaths[Ipath].CCWEBpreviews + tomaster+'_'+color);
        if (Prefs.NewPreviewNames) then
        begin
          Foldersfrom.add(Fileserverpaths[Ipath].CCWEBpreviews  + PreviewGUID+ '===='+ frommaster+'_'+color);
          Foldersto.add(Fileserverpaths[Ipath].CCWEBpreviews  + PreviewGUID+ '===='+ tomaster+'_'+color);
        end;

        IF Mainmaster Then
        Begin

          fromfile := Fileserverpaths[Ipath].CCWEBpreviews + frommaster+'.jpg';
          tofile := Fileserverpaths[Ipath].CCWEBpreviews + tomaster+'.jpg';
          if (Prefs.NewPreviewNames) then
          begin
            fromfile := Fileserverpaths[Ipath].CCWEBpreviews + PreviewGUID+ '===='+frommaster+'.jpg';
            tofile := Fileserverpaths[Ipath].CCWEBpreviews + PreviewGUID+ '===='+ tomaster+'.jpg';
            if ( NOT Fileexists(fromfile)) then
            begin
              fromfile := Fileserverpaths[Ipath].CCWEBpreviews + frommaster+'.jpg';
              tofile := Fileserverpaths[Ipath].CCWEBpreviews + tomaster+'.jpg';
            end;
          end;
          filesfrom.add(fromfile);
          filesto.add(tofile);


          Foldersfrom.add(Fileserverpaths[Ipath].CCWEBpreviews + frommaster);
          Foldersto.add(Fileserverpaths[Ipath].CCWEBpreviews + tomaster);

          if (Prefs.NewPreviewNames) then
          begin
            Foldersfrom.add(Fileserverpaths[Ipath].CCWEBpreviews + PreviewGUID+ '====' + frommaster);
            Foldersto.add(Fileserverpaths[Ipath].CCWEBpreviews  + PreviewGUID+ '===='+ tomaster);
          end;


        end;
      End;

      IF Fileserverpaths[Ipath].CCWEBthumbnails <> '' then
      begin
        IF Mainmaster Then
        Begin
          fromfile := Fileserverpaths[Ipath].CCWEBthumbnails + frommaster+'.jpg';
          tofile := Fileserverpaths[Ipath].CCWEBthumbnails + tomaster+'.jpg';
          if (Prefs.NewPreviewNames) then
          begin
            fromfile := Fileserverpaths[Ipath].CCWEBthumbnails + PreviewGUID+ '===='+ frommaster+'.jpg';
            tofile := Fileserverpaths[Ipath].CCWEBthumbnails + PreviewGUID+ '===='+ tomaster+'.jpg';
           if ( NOT Fileexists(fromfile)) then
            begin
              fromfile := Fileserverpaths[Ipath].CCWEBthumbnails + frommaster+'.jpg';
              tofile := Fileserverpaths[Ipath].CCWEBthumbnails + tomaster+'.jpg';
            end;
          end;
          filesfrom.add(fromfile);
          filesto.add(tofile);
        End;
      End;

      IF Fileserverpaths[Ipath].CCWEBreadviewpreviews <> '' then
      begin
        IF Mainmaster Then
        Begin
          LookforRview(Fileserverpaths[Ipath].CCWebreadviewpreviews,frommaster,
                       foundfile,foundfolder);

          IF Prefs.UseGeneratedReadViews then
          begin

          end;
        End;
      End;


      IF Fileserverpaths[Ipath].CCPDFfiles <> '' then
      begin
        IF Mainmaster Then
        Begin
          copypdffiles(Fileserverpaths[Ipath].CCPDFfiles,'.pdf',frommaster);
        End;
      end;

      IF Fileserverpaths[Ipath].CCPdflogs <> '' then
      begin
        IF Mainmaster Then
        Begin
          copypdffiles(Fileserverpaths[Ipath].CCPdflogs,'.pdf',frommaster);
        End;
      end;


      //Fileserverpaths[Ipath].CCPDFfiles
    End;

  end;
end;


Procedure Copythefilesandfolders;
Var
  I : Longint;
begin
  Progressprg.Max := filesfrom.count+foldersfrom.count;
  GroupBoxprg.visible := true;
  GroupBoxprg.repaint;
  Progressprg.repaint;

  filesfrom.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory())+'LockEdFrom.txt');
  filesto.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory())+'LockEdTo.txt');
  For i := 0 to filesfrom.count-1 do
  begin
    Progressprg.position := Progressprg.position +1;
    application.ProcessMessages;
    copyfile(pchar(filesfrom[i]),pchar(filesto[i]),false);
  end;

  For i := 0 to foldersfrom.count-1 do
  begin
    Progressprg.position := Progressprg.position +1;
    application.ProcessMessages;
    CopyAWebDir(foldersfrom[i],foldersto[i]);
  end;
end;

Var
  Npressruns : Longint;
  pressruns : Array[1..200] of Longint;

  NewNpressruns : Longint;
  Newpressruns : Array[1..200] of Longint;

  Selpressruns : String;
  NewSelpressruns : String;

  colorname : String;

  fpath : String;
  curmast,aktmaster : Longint;
  I : longint;

  Uniquemasters : String;
  NMasterdevs : Longint;
  Masterdevs : Array[1..1000] of longint;
  FileName : string;
  PreviewGUID : String;
begin

  if MessageDlg('Lock edition'+' '+tnames1.editionIDtoname(seled)+ ' ?',
    mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
      exit;


  try
    filesfrom := Tstringlist.Create;
    filesto   := Tstringlist.Create;
    Foldersfrom := Tstringlist.Create;
    Foldersto   := Tstringlist.Create;
    Progressprg.position := 0;
    GroupBoxprg.visible := true;
  //  Mastersfrom := Tstringlist.Create;
    Uniquemasters := '(-99';
    IF Formmain.Setplanlock(true) then
    begin


      Npressruns := 0;

      datam1.Query1.SQL.Clear;
      datam1.Query1.SQL.Add('Select distinct p.pressrunid,pr.TimedEditionTo from pagetable p (NOLOCK), pressrunid pr (NOLOCK)');
      datam1.Query1.SQL.Add('where p.productionid = ' + inttostr(Productionid) );
      datam1.Query1.SQL.Add('and pr.pressrunid = p.pressrunid');

      datam1.Query1.SQL.Add('and p.editionid = '+inttostr(seled));

      formmain.tryopen(DataM1.Query1);
      Selpressruns := ' IN (-1';
      While not datam1.Query1.eof do
      begin
        Inc(Npressruns);
        NewEd := datam1.Query1.fields[1].asinteger;
        pressruns[Npressruns] := datam1.Query1.fields[0].asinteger;
        Selpressruns := Selpressruns + ',' + datam1.Query1.fields[0].asstring;
        datam1.Query1.next;
      end;
      datam1.Query1.close;
      Selpressruns := Selpressruns + ')';

      NewNpressruns := 0;
      datam1.Query1.SQL.Clear;
      datam1.Query1.SQL.Add('Select distinct pressrunid from pagetable (NOLOCK)');
      datam1.Query1.SQL.Add('where productionid = ' + inttostr(Productionid));
      datam1.Query1.SQL.Add('and editionid = '+inttostr(NewEd));

      formmain.tryopen(DataM1.Query1);
      NewSelpressruns := ' IN (-1';
      While not datam1.Query1.eof do
      begin
        Inc(NewNpressruns);
        Newpressruns[NewNpressruns] := datam1.Query1.fields[0].asinteger;
        NewSelpressruns := NewSelpressruns + ',' + datam1.Query1.fields[0].asstring;
        datam1.Query1.next;
      end;
      datam1.Query1.close;
      NewSelpressruns := NewSelpressruns + ')';


      datam1.Query1.SQL.Clear;
      datam1.Query1.SQL.Add('update pressrunid set TimedEditionState = 2');
      datam1.Query1.SQL.Add('Where pressrunid ' + Selpressruns);
      formmain.trysql(DataM1.Query1);


      datam1.Query1.SQL.Clear;
      datam1.Query1.SQL.Add('Select distinct Mastercopyseparationset,colorid,fileserver,FileName,PublicationID,PubDate from pagetable WITH (NOLOCK)');
      datam1.Query1.SQL.Add('where productionid = ' + inttostr(Productionid) );
      datam1.Query1.SQL.Add('and editionid = '+inttostr(seled));
      datam1.Query1.SQL.Add('and pagetype <> 3 and active = 1');
      datam1.Query1.SQL.Add('and status >= 10');

      datam1.Query1.open;
      curmast := -999;
      While not datam1.Query1.eof do
      begin
        colorname := tnames1.ColornameIDtoname(datam1.Query1.fields[1].asinteger);
        aktmaster := datam1.Query1.fields[0].asinteger;
        FileName  := datam1.Query1.fields[3].AsString;
        PreviewGUID := inittypes.GeneratePreviewGUID(datam1.Query1.fields[4].asinteger, datam1.Query1.fields[5].AsDateTime);
        IF curmast <> aktmaster then
        begin
          curmast := aktmaster;
          copymastfiles(aktmaster,colorname,true,FileName, PreviewGUID);
        end
        else
          copymastfiles(aktmaster,colorname,false,FileName, PreviewGUID);

        datam1.Query1.next;


      end;
      datam1.Query1.close;

      datam1.Query1.SQL.Clear;
      datam1.Query1.SQL.Add('Select distinct Mastercopyseparationset from pagetable WITH (NOLOCK)');
      datam1.Query1.SQL.Add('where productionid = ' + inttostr(Productionid) );
      datam1.Query1.SQL.Add('and editionid = '+inttostr(seled));
      datam1.Query1.SQL.Add('and pagetype <> 3 and active = 1');
      datam1.Query1.SQL.Add('and uniquepage = 1');
      formmain.tryopen(DataM1.Query1);
      While not datam1.Query1.eof do
      begin
        Uniquemasters := Uniquemasters + ','+datam1.Query1.fields[0].asstring;
        datam1.Query1.next;
      End;

      datam1.Query1.close;
      Uniquemasters := Uniquemasters + ')';

      IF nymasteredsize > 10 then
        Copythefilesandfolders;

      if nymasteredsize > 0 then
      begin
        datam1.Query1.SQL.Clear;
        datam1.Query1.SQL.Add('update pagetable set uniquepage = 1, mastercopyseparationset = mastercopyseparationset + '+inttostr(nymasteredsize));
        datam1.Query1.SQL.Add('where productionid = ' + inttostr(Productionid) );
        datam1.Query1.SQL.Add('and editionid = '+inttostr(seled));
        formmain.trysql(DataM1.Query1);
      end;
      datam1.Query1.SQL.Clear;
      datam1.Query1.SQL.Add('update pressrunid set TimedEditionState = 10');
      datam1.Query1.SQL.Add('Where pressrunid ' + Selpressruns);
      formmain.trysql(DataM1.Query1);

      IF nymasteredsize > 0 then
      Begin
        datam1.Query1.SQL.Clear;
        datam1.Query1.SQL.Add('update pagetable set uniquepage = 1');
        datam1.Query1.SQL.Add('where productionid = ' + inttostr(Productionid) );
        datam1.Query1.SQL.Add('and editionid = '+inttostr(NewEd));
        datam1.Query1.SQL.Add('and mastercopyseparationset IN '+Uniquemasters);
      End;

      formmain.trysql(DataM1.Query1);

      datam1.Query1.SQL.Clear;
      datam1.Query1.SQL.Add('update pressrunid set TimedEditionState = 1');
      datam1.Query1.SQL.Add('Where pressrunid ' + NewSelpressruns);
      formmain.trysql(DataM1.Query1);

    End
    Else
    begin

    end;
  Finally
    filesfrom.Free;
    filesto.Free;
    Foldersfrom.Free;
    Foldersto.Free;

    Formmain.Setplanlock(false);

  end;

end;

procedure TFormSelnexttimedEd.Loaddata;
Var
  Aeid : Longint;
  I : Longint;
  Uniquemasters : String;
Begin
  datam1.Query1.SQL.Clear;
  datam1.Query1.SQL.Add('Select distinct p.pressrunid,pr.TimedEditionTo from pagetable p (NOLOCK), pressrunid pr (NOLOCK)');
  datam1.Query1.SQL.Add('where p.productionid = ' + inttostr(Productionid) );
  datam1.Query1.SQL.Add('and pr.pressrunid = p.pressrunid');

  datam1.Query1.SQL.Add('and p.editionid = '+inttostr(seled));

  formmain.tryopen(DataM1.Query1);
//  Selpressruns := ' IN (-1';


  While not datam1.Query1.eof do
  begin
    //Inc(Npressruns);
    NewEd := datam1.Query1.fields[1].asinteger;
(*    pressruns[Npressruns] := datam1.Query1.fields[0].asinteger;
    Selpressruns := Selpressruns + ',' + datam1.Query1.fields[0].asstring;
    *)
    datam1.Query1.next;
  end;
  datam1.Query1.close;

  Editnext.Text := tnames1.editionIDtoname(NewEd);

  Uniquemasters := '(-99';
  datam1.Query1.SQL.Clear;
  datam1.Query1.SQL.Add('Select distinct Mastercopyseparationset from pagetable (NOLOCK) ');
  datam1.Query1.SQL.Add('where productionid = ' + inttostr(Productionid) );
  datam1.Query1.SQL.Add('and editionid = '+inttostr(seled));
  datam1.Query1.SQL.Add('and pagetype <> 3 and active = 1');
  datam1.Query1.SQL.Add('and uniquepage = 1');
  formmain.tryopen(DataM1.Query1);
  While not datam1.Query1.eof do
  begin
    Uniquemasters := Uniquemasters + ','+datam1.Query1.fields[0].asstring;
    datam1.Query1.next;
  End;

  datam1.Query1.close;
  Uniquemasters := Uniquemasters + ')';

  datam1.Query1.SQL.Clear;
  datam1.Query1.SQL.Add('Select distinct Editionid from pagetable (NOLOCK) ');
  datam1.Query1.SQL.Add('where productionid = ' + inttostr(Productionid) );
  datam1.Query1.SQL.Add('and editionid <> '+inttostr(seled));
  datam1.Query1.SQL.Add('and pagetype <> 3 and active = 1');
  datam1.Query1.SQL.Add('and uniquepage <> 1');
  datam1.Query1.SQL.Add('and mastercopyseparationset IN '+Uniquemasters);
  CheckListBox1.Items.Clear;
  formmain.tryopen(DataM1.Query1);
  While not datam1.Query1.eof do
  begin
    CheckListBox1.Items.add( tnames1.editionIDtoname(DataM1.Query1.fields[0].asinteger ) );
    datam1.Query1.next;
  End;

  datam1.Query1.close;

  For i := 0 to CheckListBox1.Items.count-1 do
  begin
    CheckListBox1.checked[i] := true;
  end;
End;


end.
