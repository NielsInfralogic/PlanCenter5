unit Ureloaderrorthr;

interface

uses
  Classes;

type
  Treloaderrorfthread = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  public
    publicationID : longint;
    Constructor Create;
  end;

implementation

uses
  SysUtils,
  Ureloadingerrorfiles,
  udata,
  forms,
  umain;

Constructor Treloaderrorfthread.create;
Begin
  inherited create(true);
  freeonterminate := true;
end;


procedure Treloaderrorfthread.Execute;
Var
  errorfolder : string;
  R,Ifolder : Longint;
  Nfolders : Integer;
  folders : array[1..100] of record
                               InputID           : longint;
                               InputPath         : string;
                               folderbased       : Boolean;
                               ignorefolder      : boolean;
                               DefaultPublicationID : longint;
                             end;
  T : string;
  F: TSearchRec;
  i,aktpublid : Longint;


  IInputabbr,NInputabbr : Longint;
  Inputabbr : Array[1..100] of string;

begin
  try
    try
      Formreloadingerrorfiles.stopit := false;

      application.ProcessMessages;
      i := 0;
      repeat
        Formreloadingerrorfiles.Animate1.Refresh;
        inc(i);
        sleep(1000);

      until (i = 10) or (Formreloadingerrorfiles.stopit);
      aktpublid := publicationID;
      NInputabbr := 1;
      Inputabbr[1] := tnames1.publicationIDtoname(publicationID);

      DataM1.Query1.SQL.Clear;
      DataM1.Query1.SQL.add('Select ShortName from InputAliases');
      DataM1.Query1.SQL.add('Where type = ' + ''''+'Publication'+'''');
      DataM1.Query1.SQL.add('and LongName = ' + ''''+Inputabbr[1]+'''');


      DataM1.Query1.open;
      While not DataM1.Query1.eof do
      begin
        Inc(NInputabbr);
        Inputabbr[NInputabbr] := Uppercase(DataM1.Query1.fields[0].asstring);
        DataM1.Query1.next;
      End;
      DataM1.Query1.close;

      DataM1.Query1.SQL.Clear;
      DataM1.Query1.SQL.add('Select ServerErrorPath from GeneralPreferences');
      DataM1.Query1.open;
      errorfolder := DataM1.Query1.fields[0].asstring;
      DataM1.Query1.close;

      errorfolder := includetrailingbackslash(errorfolder);
      Nfolders  := 0;
      DataM1.Query1.SQL.Clear;
      DataM1.Query1.SQL.add('Select InputID,DefaultPublicationID,NamingMask,InputPath from InputConfigurations');
      DataM1.Query1.open;
      While (not DataM1.Query1.eof) and (not Formreloadingerrorfiles.stopit) do
      begin
        Inc(Nfolders);
        folders[Nfolders].folderbased := false;
        folders[Nfolders].ignorefolder := false;

        T := DataM1.Query1.fields[2].asstring;
        IF (pos('%P',T) = 0) and (pos('%Q',T) = 0) then
        begin
          IF aktpublid = DataM1.Query1.fields[1].asinteger then
            folders[Nfolders].folderbased := true
          Else
            folders[Nfolders].ignorefolder := true;
        end;
        folders[Nfolders].InputID := DataM1.Query1.fields[0].asinteger;
        folders[Nfolders].InputPath := includetrailingbackslash(DataM1.Query1.fields[3].asstring);
        DataM1.Query1.next;
      End;
      DataM1.Query1.close;


      For Ifolder := 1 to nfolders do
      begin
        if Formreloadingerrorfiles.stopit then
        begin
          break;
        end;
        application.ProcessMessages;
        IF not folders[ifolder].ignorefolder then
        begin
          R := FindFirst(errorfolder+inttostr(folders[ifolder].InputID)+'\*.*',faAnyFile		,F);

          While (r = 0) and (not Formreloadingerrorfiles.stopit) do
          begin
            application.ProcessMessages;
            IF  (not(f.Attr in [faDirectory])) and (pos('.log',f.name) = 0) then
            begin
              T := Uppercase(f.name);
              if not folders[ifolder].folderbased then
              begin  // moveen all
                renamefile(errorfolder+inttostr(folders[ifolder].InputID)+'\'+f.Name,folders[ifolder].InputPath+f.Name);
              end
              else
              begin
                For IInputabbr := 1 to NInputabbr do
                begin
                  if Formreloadingerrorfiles.stopit then
                    break;
                  if pos(Inputabbr[IInputabbr],t) > 0 then
                  begin
                    renamefile(errorfolder+inttostr(folders[ifolder].InputID)+'\'+f.Name,folders[ifolder].InputPath+f.Name);
                  end;
                end;
              end;
            End;

            IF (pos('.log',f.name) > 0) then
              deletefile(errorfolder+inttostr(folders[ifolder].InputID)+'\'+f.Name);

            r := findnext(f);
          End;
          findclose(f);
        End;
      end;

    Except
    end;
  finally
    formreloadingerrorfiles.Animate1.Active := false;
    if Formreloadingerrorfiles.Showing then
    begin
      Formreloadingerrorfiles.close;
    end;
  end;
end;

end.
