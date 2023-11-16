unit UWorkerThreadUnknownFiles;

interface

uses
  System.Classes, System.SysUtils, Vcl.ComCtrls;

type
  TWorkerThreadUnknownFiles = class(TThread)

    protected
      procedure Execute; override;
      procedure UpdateUnknownFilesLamp(SetOff: Boolean);

    public
      terminateThread : Boolean;
      constructor Create;
  end;

implementation

uses
  UMain, Udata, Uprefs, UTypes, Uunknownfiles, UUnkFolders, UReloadingErrorFiles;

{ TWorkerThreadUnknownFiles }
constructor TWorkerThreadUnknownFiles.Create;
begin
  inherited create(false);
  terminateThread := false;
end;

procedure TWorkerThreadUnknownFiles.Execute;
var
  R,Ifolder, w: Integer;
  F: TSearchRec;
  Empty : Boolean;
  Filterstr : String;
  Foldernumber : Integer;
begin

  while (not terminateThread) do
  begin
    if (not StartupDone) OR (not Prefs.CheckForUnknownFilesTimer) then
    begin
      Sleep(1000);
      continue;
    end;

    if FormUknownfiles.Uknownfilter = '' then
      Filterstr := '*.*'
    else
      Filterstr := FormUknownfiles.Uknownfilter;

    Foldernumber := FormUknownfiles.Uknownfolder;

    Empty := true;
   // writeMainlogfile('Errorfiles - scanning');
    if (FormMain.PageControlMain.ActivePageIndex <> VIEW_FILES) then
    begin
      Empty := true;
      for ifolder := 1 to NErrorfolders do
      begin
        if (Foldernumber < 0) or (Formerrorfolderselect.CheckListBox1.checked[ifolder]) then
        begin
          R := FindFirst(IncludeTrailingBackSlash(IncludeTrailingBackSlash(Mainerrorfolder)+IntToStr(Errorfolders[ifolder].InputID))+Filterstr,faAnyFile		,F);
          while (r = 0) and (not Formreloadingerrorfiles.stopit) do
          begin
            if (not(f.Attr in [faDirectory])) AND (f.Name <> '.') AND (f.Name <> '..') then
            begin
              if (extractfileext(f.Name) <> '.log') then
              begin
                Empty := false;
                writeMainlogfile('Errorfile found ' +  f.Name);
                break;
              end;
            end;
            r := findnext(f);
          end;
          findclose(f);
          if not Empty then
            break;
        end;
      end;

      UpdateUnknownFilesLamp(Empty);

    end;
    //writeMainlogfile('Errorfiles - scanning end');
    for w:= 1 to Prefs.CheckForUnknownFilesTimerInterval  do
    begin
      Sleep(1000);
      if (terminateThread) then
        break;
    end;

  end;

end;

procedure TWorkerThreadUnknownFiles.UpdateUnknownFilesLamp(SetOff: Boolean);
begin
  if (SetOff) then
    Synchronize(FormMain.SetUnknownFilesLampOff)
  else
    Synchronize(FormMain.SetUnknownFilesLampOn);

end;



end.
