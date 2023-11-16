unit Ucolordetect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ValEdit, StdCtrls, Buttons, ExtCtrls;

type
  TFormColordetectionsetup = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ValueListEditor1: TValueListEditor;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Function Getcolornamefromfile(filename : string;
                                  var colorid  : Longint;
                                  Var restname : string):string;
  end;

var
  FormColordetectionsetup: TFormColordetectionsetup;

implementation
Uses
  inifiles,UTypes, UUtils;
{$R *.dfm}

procedure TFormColordetectionsetup.BitBtn1Click(Sender: TObject);
Var
  INI : tinifile;
  I : Longint;
begin
  INI := tinifile.Create(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory())+'Colordetect.ini');
  INI.writeinteger('System','numberofsets',ValueListEditor1.RowCount-1);
  For i := 1 to ValueListEditor1.RowCount-1 do
  begin
    INI.WriteString(inttostr(I),'Color',ValueListEditor1.Cells[0,i]);
    INI.WriteString(inttostr(I),'Strkey',ValueListEditor1.Cells[1,i]);
  end;
  INI.Free;
end;

procedure TFormColordetectionsetup.FormCreate(Sender: TObject);
Var
  INI : tinifile;
  N,I : Longint;

begin
  INI := tinifile.Create(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory())+'Colordetect.ini');
  N := INI.readinteger('System','numberofsets',ValueListEditor1.RowCount-1);
  For i := 1 to N do
  begin
    IF ValueListEditor1.RowCount-1 < I then
    Begin
      ValueListEditor1.InsertRow('X','X',true);
    End;
    ValueListEditor1.Cells[0,i] := INI.readString(inttostr(I),'Color',ValueListEditor1.Cells[0,i]);
    ValueListEditor1.Cells[1,i] := INI.readString(inttostr(I),'Strkey',ValueListEditor1.Cells[1,i]);
  end;
  INI.Free;
end;

Function TFormColordetectionsetup.Getcolornamefromfile(filename : string;
                                                       var colorid  : Longint;
                                                       Var restname : string):string;
Var
  I,s,e : Longint;
  T : String;

Begin
  result := '?';
  colorid := -1;
  restname := '';
  filename := uppercase(filename);
  for i := 1 to ValueListEditor1.RowCount-1 do
  begin
    T := uppercase(ValueListEditor1.Cells[1,i]);
    s := POS(T,filename);
    IF s > 0 then
    begin
      result := ValueListEditor1.Cells[0,i];
      e := s + length(T);
      restname := copy(filename,1,s-1);// + copy(filename,e,100);
      break;
    end;
  end;
  if result <> '?' then
    Colorid := inittypes.getcolorIDfromname(result);

end;
end.

