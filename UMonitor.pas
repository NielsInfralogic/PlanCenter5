unit UMonitor;

interface

uses
  Classes,ComCtrls;

type
  Tmonitor = class(TThread)

  protected
    procedure Execute; override;

  Public
    running : Boolean;
    Stopit  : Boolean;
    Rerun   : Boolean;
    terminateit : Boolean;
    LastConsoletime : Tdatetime;
    messagetime : Longint;
    Constructor Create;

  end;
Var
  monitorThr : Tmonitor;
implementation
Uses
  SysUtils,Usettings, utypes, Udata, UFTP,ShellAPI,umain,forms,uprev2,dateutils;

Constructor Tmonitor.create;
Begin
  inherited create(false);
  running := false;
  Stopit  := false;
  Rerun   := false;
  LastConsoletime := now;
  messagetime := 0;
  terminateit := false;
  freeonterminate := false;
End;

procedure Tmonitor.Execute;
Var
  I : Longint;
begin
  repeat
    Sleep(1000);

    IF (not stopit) and (not terminateit) then
    begin
      running := true;
      consoleview;
      running := false;
    end;
  until terminateit;
end;








end.
