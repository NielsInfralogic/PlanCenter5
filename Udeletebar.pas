unit Udeletebar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls;

type
  TFormfuskdeletebar = class(TForm)
    GroupBox1: TGroupBox;
    ProgressBar1: TProgressBar;
    Timer1: TTimer;
    GroupBox2: TGroupBox;
    Panel1: TPanel;
    GroupBox3: TGroupBox;
    Panel2: TPanel;
    procedure FormActivate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
  public
    { Public declarations }
  end;

var
  Formfuskdeletebar: TFormfuskdeletebar;

implementation
Uses
  Udelpubl,ShellAPI,DateUtils, UUtils;

{$R *.dfm}

Var

  Folderproblems : TStrings;



procedure TFormfuskdeletebar.FormActivate(Sender: TObject);
begin

  ProgressBar1.Position := 0;
  ProgressBar1.Max := 105;
  Timer1.enabled := true;
end;





procedure TFormfuskdeletebar.Timer1Timer(Sender: TObject);


procedure DeleteRecurse( src : String ) ;
var
  sts : Integer ;
  SR: TSearchRec;
begin
  src := includetrailingbackslash(src);
  sts := FindFirst( src + '*.*' , faDirectory , SR ) ; 
  if sts = 0 then 
  begin 
    if ( SR.Name <> '.' ) and ( SR.Name <> '..' ) then 
    begin 
      if SR.Attr = faDirectory then
      begin
          DeleteRecurse( src + SR.Name + '\' ) ; 
          {$I-}RmDir( src + SR.Name ) ;{$I+} 
      end 
      else 
        DeleteFile( src + SR.Name ) ;
    end ; 
    while FindNext( SR ) = 0 do 
    if ( SR.Name <> '.' ) and ( SR.Name <> '..' ) then 
    begin 
      if SR.Attr = faDirectory then 
      begin 
        DeleteRecurse( src + SR.Name + '\' ) ; 
        {$I-}RmDir( src + SR.Name ) ;{$I+} 
      end 
      else 
        DeleteFile( src + SR.Name ) ;
    end ;
    FindClose( SR ) ;
  end ;
end ;

procedure ExecFASTProcess(ProgramName      : String;
                          programparameter : string);
var
  StartInfo  : TStartupInfo;
  ProcInfo   : TProcessInformation;
  CreateOK   : Boolean;
  T : String;
begin

  FillChar(StartInfo,SizeOf(TStartupInfo),#0);
  FillChar(ProcInfo,SizeOf(TProcessInformation),#0);
  StartInfo.cb := SizeOf(TStartupInfo);

  //+programparameter+'"'
  T := '"'+ProgramName+'"' + ' "' +programparameter+'"';


  StartInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartInfo.wShowWindow := SW_HIDE;

  CreateOK := CreateProcess(nil,pchar(T), nil, nil,False,
              CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS ,
              nil, nil, StartInfo, ProcInfo);

  if CreateOK then
    WaitForSingleObject(ProcInfo.hProcess, INFINITE);


end;

Var
  I : longint;
  s : tdatetime;

  Aktpath : String;
  T,F : string;
begin
  try
    s := now;
    Folderproblems.Clear;
    Aktpath := 'dsds';
    Timer1.enabled := false;
    Panel1.Caption := inttostr(Formdelpublication.Delfilelist.Count);
    Panel2.Caption := inttostr(Formdelpublication.DelFolders.Count);
    Formfuskdeletebar.repaint;

    For i :=  0 to Formdelpublication.Delfilelist.Count-1 do
    begin
      ProgressBar1.Position := (I * 100) DIV Formdelpublication.Delfilelist.Count;
      deletefile(Formdelpublication.Delfilelist[i]);

      ProgressBar1.refresh;
      IF I mod 20 = 0 then
        application.ProcessMessages;
    end;

    DeleteFile(IncludeTrailingBackSlash(TUtils.GetTempDirectory()) + 'Delfoldebat.BAT');

    For i :=  0 to Formdelpublication.DelFolders.Count-1 do
    begin
      DeleteRecurse(Formdelpublication.DelFolders[i]);
      if directoryexists(Formdelpublication.DelFolders[i]) then
        {$I-}RMdir(Formdelpublication.DelFolders[i]);{$I+}

    End;
    i := 89;
    For i :=  0 to Formdelpublication.Delfilelist.Count-1 do
    begin
      F := extractfilepath(Formdelpublication.Delfilelist[i]);
      IF Folderproblems.IndexOf(F) < 0 then
      begin
        IF Fileexists(Formdelpublication.Delfilelist[i]) then
        begin
          Folderproblems.add(F);
        end;
      End;
    End;

    For i :=  0 to Formdelpublication.DelFolders.Count-1 do
    begin
      F := Formdelpublication.DelFolders[i];
      IF length(F) > 2 then
      begin
        While F[length(F)] <> '\' do
          delete(F,length(F),1);
      End;
      F := Excludetrailingbackslash(F);
      IF Folderproblems.IndexOf(F) < 0 then
      begin
        IF directoryexists(Formdelpublication.DelFolders[i]) then
        begin
          Folderproblems.add(F);
        end;
      End;
    End;

    Formdelpublication.Delfilelist.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'Delfilelist Done.txt');
    Formdelpublication.DelFolders.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'DelFolders Done.txt');


    Application.ProcessMessages;


    For i :=  0 to 4 do
    begin
      Sleep(1000);
      ProgressBar1.Position := ProgressBar1.Position +1;
      ProgressBar1.repaint;
      application.ProcessMessages;
    End;
    application.ProcessMessages;
  Finally
    Close;
  End;
end;

end.
