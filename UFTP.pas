unit UFTP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdFTP, IdExplicitTLSClientServerBase;

type
  TFormFTP = class(TForm)
    IdFTP1: TIdFTP;
    procedure IdFTP1Connected(Sender: TObject);
    procedure IdFTP1Status(ASender: TObject; const AStatus: TIdStatus;
      const AStatusText: String);
  private
    function checkname(Colorid : string;
                       mastercopyname : string):Boolean;

  public
    { Public declarations }
    connectionok : boolean;
    pathok       : boolean;
    Curstat      : Longint;
    Function Testconnection : boolean;
    Procedure cleanup;
  end;

var
  FormFTP: TFormFTP;

implementation

{$R *.dfm}
Uses
  utypes,
  Umain,
  Udata,
  Usettings;
Function TFormFTP.Testconnection : boolean;
Begin
  result := false;
  connectionok := false;
  pathok       := false;
//  Prefs.ftpservername := 'fdfd.nenere.net';
  IdFTP1.Port     :=  Prefs.ftpport;
  IdFTP1.Host     :=  Prefs.ftpservername;
  IdFTP1.Password :=  Prefs.ftppasword;
  IdFTP1.Username :=  Prefs.ftpusername;

  try
    IdFTP1.Connect;
  Except
    exit;
  end;

  try
    IdFTP1.ChangeDir(Prefs.ftpfolder);
    IdFTP1.ChangeDir('CCpreviews');
    IdFTP1.ChangeDirUp;
    IdFTP1.ChangeDir('CCthumbnails');
    IdFTP1.ChangeDirUp;
    pathok := true;
    result := true;
  Except
    formmain.StatusBar1.Panels[4].Text := 'Webserver ' + 'wrong path';
    pathok := false;
  end;

  try
    IdFTP1.Disconnect;
  Except
    exit;
  end;
end;

procedure TFormFTP.IdFTP1Connected(Sender: TObject);
begin
  connectionok := true;
end;



procedure TFormFTP.IdFTP1Status(ASender: TObject; const AStatus: TIdStatus;
  const AStatusText: String);
begin
  Case AStatus of
    hsResolving : curstat := 0;
    hsConnecting : curstat := 1;
    hsConnected : curstat := 2;
    hsDisconnecting : curstat := 3;
    hsDisconnected : curstat := 4;
    ftpTransfer : curstat := 5;
    ftpReady : curstat := 6;
    ftpAborted : curstat := 7;
    else curstat := 8;
  end;
//  formmain.StatusBar1.Panels[4].Text := 'Webserver ' + AStatusText;
end;

function TFormFTP.checkname(Colorid : string;
                            mastercopyname : string):Boolean;
Var
  I : Longint;

Begin
  try
    result := false;
    I := strtoint(mastercopyname);

    IF Colorid <> '-1' then
      result := true;
  except
  end;
end;

Procedure TFormFTP.cleanup;

procedure RecDelete(AIdFtp: TIdFTP; ADir: string);
var
  sl: TStringList;
  i, n: integer;
  NewDir: string;
begin
  sl := TStringList.Create;

  if Trim(ADir) <> '' then
  begin
    try
      AIdFtp.ChangeDir(ADir);
    except
      AIdFtp.Delete(ADir);
      AIdFtp.MakeDir(ADir);
      AIdFtp.ChangeDir(ADir);
    end;
  end;

  AIdFtp.List(sl, '*.*', True);
  for i := 0 to AIdFtp.DirectoryListing.Count - 1 do
  begin
    AIdFtp.Delete(AIdFtp.DirectoryListing.Items[i].FileName);
  end;

  AIdFtp.List(sl, '*', True);
  if AIdFtp.DirectoryListing.Count = 0 then
    AIdFtp.ChangeDirUp
  else
  begin
    n := 0;
    n := AIdFtp.DirectoryListing.Count - 1;
    i := n;
    while i >= 0 do
    begin
      NewDir := AIdFtp.DirectoryListing.Items[i].FileName;
      RecDelete(AIdFtp, NewDir);
      AIdFtp.RemoveDir(NewDir);
      AIdFtp.List(sl, '*', True);
      i := i - 1;
    end;
    AIdFtp.ChangeDirUp;
  end;
  sl.Free;
end;



Var
  Alist,Blist : TStrings;
  I,i2 : longint;
  colorid,colort,T,mastercopysettodel : string;

begin
  Alist := TStringList.Create;
  Blist := TStringList.Create;

  try
    try
      IdFTP1.Port     :=  Prefs.ftpport;
      IdFTP1.Host     :=  Prefs.ftpservername;
      IdFTP1.Password :=  Prefs.ftppasword;
      IdFTP1.Username :=  Prefs.ftpusername;
      IdFTP1.Connect;

    Except
      exit;
    end;

    IdFTP1.ChangeDir(Prefs.ftpfolder);
    IdFTP1.ChangeDir('CCpreviews');


    IdFTP1.List(Alist, '*.jpg', false);

    For i := 0 to Alist.Count-1 do
    begin
      T := extractfilename(Alist[i]);
      if t <> '' then
      begin
        try
          if pos('_',t) > 0 then
          begin
            mastercopysettodel := copy(t,1,pos('_',t)-1);
          end
          else
          begin
            mastercopysettodel := copy(t,1,pos('.',t)-1);
          end;
          if checkname('1',mastercopysettodel) then
          begin
            DataM1.Query1.SQL.clear;
            DataM1.Query1.SQL.add('Select separation from pagetable');
            DataM1.Query1.SQL.add('where mastercopyseparationset = ' + mastercopysettodel);
            IF pos('_',t) > 0 then
            Begin
              colort := t;
              delete(colort,1,pos('_',t));
              colort := copy(colort,1,pos('.',colort)-1);
              colorid := inttostr(inittypes.getcolorIDfromname(colort));
              DataM1.Query1.SQL.add('and colorid = ' + colorid);
            End;
            DataM1.Query1.SQL.add('and status > 0');
            DataM1.Query1.open;
            if DataM1.Query1.eof then
            begin
              try
                IdFTP1.Delete(Alist[i]);
              except
              end;
            end;
            DataM1.Query1.close;
          End;

        Except
        End;
      end;
    End;


    Alist.Clear;
    IdFTP1.List(Alist, '', false);

    For i := 0 to Alist.count-1 do
    begin
      IF pos('.',Alist[i]) = 0 then
      begin
        try
          IdFTP1.ChangeDir(alist[i]);
          IdFTP1.ChangeDirUp;
          T := extractfilename(Alist[i]);
          if t <> '' then
          begin
            try
              mastercopysettodel := T;
              if pos('_',t) > 0 then
              begin
                mastercopysettodel := copy(t,1,pos('_',t)-1);
              end
              else
              begin
                mastercopysettodel := T;
              end;

              if checkname('1',mastercopysettodel) then
              begin
                DataM1.Query1.SQL.clear;
                DataM1.Query1.SQL.add('Select separation from pagetable');
                DataM1.Query1.SQL.add('where mastercopyseparationset = ' + mastercopysettodel);
                IF pos('_',t) > 0 then
                Begin
                  colort := t;
                  delete(colort,1,pos('_',t));
                  colorid := inttostr(inittypes.getcolorIDfromname(colort));
                  DataM1.Query1.SQL.add('and colorid = ' + colorid);
                End;
                DataM1.Query1.SQL.add('and status > 0');
                DataM1.Query1.open;
                if DataM1.Query1.eof then
                begin


                  IdFTP1.ChangeDir(alist[i]);
                  try
                    IdFTP1.Delete('ImageProperties.xml');
                  except
                  end;
                  IdFTP1.ChangeDir('TileGroup0');
                  IdFTP1.List(Blist, '*.jpg', false);
                  for i2 := 0 to Blist.Count-1 do
                  begin
                    IdFTP1.Delete(Blist[i2]);
                  end;
                  IdFTP1.ChangeDirUp;
                  try
                    IdFTP1.RemoveDir('TileGroup0');
                  except
                  end;
                  IdFTP1.ChangeDirUp;
                  IdFTP1.RemoveDir(alist[i]);

                end;
                DataM1.Query1.close;
              End;
            Except

            end;
          end;
        Except
          sleep(1);
        end;
      End;
    end;

    IdFTP1.ChangeDirUp;
    IdFTP1.ChangeDir('CCthumbnails');
    Alist.Clear;
    IdFTP1.List(Alist, '*.jpg', false);

    For i := 0 to Alist.count-1 do
    begin
      T := extractfilename(Alist[i]);
      if t <> '' then
      begin
        try
          mastercopysettodel := changefileext(t,'');
          if checkname('1',mastercopysettodel) then
          begin
            DataM1.Query1.SQL.clear;
            DataM1.Query1.SQL.add('Select separation from pagetable');
            DataM1.Query1.SQL.add('where status > 0');
            DataM1.Query1.SQL.add('and mastercopyseparationset = ' + mastercopysettodel);
            DataM1.Query1.open;
            if DataM1.Query1.eof then
            begin
              try
                IdFTP1.Delete(Alist[i]);
              except
              end;
            end;
            DataM1.Query1.close;
          End;
        Except

        end;
      End;
    end;



    (*
    DataM1.Query2.SQL.Clear;
    DataM1.Query2.SQL.add('select distinct colorid from pagetable where mastercopyseparationset = ' + inttostr(masterset));
    formmain.Tryopen(DataM1.Query2);

    While not DataM1.Query2.eof do
    begin
      DataM1.Query2.Next;
    end;

    DataM1.Query2.close;
    *)
  Finally
    Alist.Free;
    Blist.Free;
    IdFTP1.Disconnect;


  end;

end;


end.
