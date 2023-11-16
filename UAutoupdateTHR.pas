unit UAutoupdateTHR;

interface

uses
  Classes;

type
  TAutoUpdateTHR = class(TThread)
  private
    Function Anyfiletoautoupdate:boolean;
    function GetFileLastAccessTime(sFileName : string;
                                   filetimetype : Integer) : TDateTime;

  protected


  Public
    procedure Execute; override;
    Constructor Create;
  end;

Var
  AutoUpdateTHR : TAutoUpdateTHR;
  ThrfoundAnyfiletoautoupdate : Boolean;

  Useautoupdate : Boolean;
  Autoupdatepath : String;
  Lastupdatetime : Tdatetime;
  Autoupdateevery : Longint;


implementation

Uses
  windows,SysUtils,forms;

Constructor TAutoUpdateTHR.Create;
Begin
  inherited create(true);
End;


function TAutoUpdateTHR.GetFileLastAccessTime(sFileName : string;
                                              filetimetype : Integer) : TDateTime;
var
  ffd : TWin32FindData;
  dft : DWord;
  lft : TFileTime;
  h   : THandle;

begin
  result := now;
  try
    h := Windows.FindFirstFile(
           PChar(sFileName), ffd);
    if(INVALID_HANDLE_VALUE <> h)then
    begin

      Windows.FindClose( h );

      Case filetimetype of
        0 : FileTimeToLocalFileTime(ffd.ftCreationTime, lft );
        1 : FileTimeToLocalFileTime(ffd.ftLastAccessTime, lft );
        2 : FileTimeToLocalFileTime(ffd.ftLastWriteTime, lft );
        else
          FileTimeToLocalFileTime(ffd.ftLastAccessTime, lft );
      end;

      FileTimeToDosDateTime(lft,
      LongRec(dft).Hi, LongRec(dft).Lo);
      Result := FileDateToDateTime(dft);
    end;
  Except
  end;
end;

Function TAutoUpdateTHR.Anyfiletoautoupdate:boolean;
Var
  Alist : TStrings;
  r : Longint;
  F: TSearchRec;
  T,frompath,topath : string;
  I : Longint;
  ServerFtime,LocalFtime : tdatetime;
  ServerCtime,LocalCtime : tdatetime;
  dontcopy : boolean;
Begin
  result := false;
  Alist := TStringList.Create;

  try
    IF autoupdatepath <> '' then
    begin
      frompath := Includetrailingbackslash(autoupdatepath);
      topath := extractfilepath(application.ExeName);

      R := FindFirst(frompath+'*.*', faArchive	, f);
      While r = 0 do
      begin
        IF (f.name <> '.') AND (f.name <> '..') then
        begin
          T := uppercase(f.Name);
          dontcopy := false;

          IF extractfileext(T) = '.INI' then
          begin
            IF fileexists(topath+T) then
              dontcopy := true;

          end;
          IF (extractfileext(T) = '.LOG') or (T = 'AUTOUPDATE.EXE') then
            dontcopy := true;

          if not dontcopy then
          begin
            Alist.Add(f.Name);
          end;
        End;
        r := FindNext(f);
        application.ProcessMessages;
      end;

      Findclose(F);
      IF alist.Count > 0 then
      begin
        For i := 0 to alist.Count-1 do
        begin
          application.ProcessMessages;
          R := FindFirst(topath+alist[i], faArchive	, f);
          IF R <> 0 then
          Begin
            result := true;
            Findclose(F);
            break;
          End
          Else
          Begin
            Findclose(F);
            ServerFtime := GetFileLastAccessTime(Frompath+alist[i],2);
            LocalFtime := GetFileLastAccessTime(topath+alist[i],2);
            IF (ServerFtime > LocalFtime)  then
            begin
              result := true;
              break;
            end;
          End;
        End;
      End;
    end;
  Except
  End;
  alist.free;
End;



procedure TAutoUpdateTHR.Execute;
begin
  ThrfoundAnyfiletoautoupdate := Anyfiletoautoupdate;
end;

end.
