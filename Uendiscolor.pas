unit Uendiscolor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, CheckLst, ExtCtrls;

type
  TFormEndiscolors = class(TForm)
    Panel1: TPanel;
    CheckListBoxColors: TCheckListBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure CheckListBoxColorsClick(Sender: TObject);
  private
    { Private declarations }
    ColorIDS : Array[0..200] of Integer;
  public
    { Public declarations }
    Mastercopyseparationset : Integer;
    enabledcolors : string;
    Disabledcolors : string;
    ISmono : Boolean;
  end;

var
  FormEndiscolors: TFormEndiscolors;

implementation
Uses
  udata,umain;
{$R *.dfm}

procedure TFormEndiscolors.FormActivate(Sender: TObject);
var
  i : Integer;
  isPDFPage : boolean;
begin
  isPDFPage := false;
  Datam1.Query1.SQL.Clear;
  Datam1.Query1.SQL.Add('SELECT TOP 1 ColorID FROM PageTable WHERE Dirty=0 AND mastercopyseparationset = ' + IntToStr(Mastercopyseparationset));
  Datam1.Query1.Open;

  if not Datam1.Query1.eof then
  begin
    if (datam1.Query1.fieldbyname('colorid').AsInteger = 5) then
      isPDFPage := true;
  end;
  Datam1.Query1.Close;



  CheckListBoxColors.Items.clear;
  if (isPDFPage) then
  begin
    CheckListBoxColors.Items.Add( tnames1.ColornameIDtoname(5));
    CheckListBoxColors.Checked[0] := true;
    ColorIDS[0] := 5;
  end
  else
  begin
    CheckListBoxColors.Items.add( tnames1.ColornameIDtoname(1));
    CheckListBoxColors.Items.add( tnames1.ColornameIDtoname(2));
    CheckListBoxColors.Items.add( tnames1.ColornameIDtoname(3));
    CheckListBoxColors.Items.add( tnames1.ColornameIDtoname(4));
    ColorIDS[0] := 1;
    ColorIDS[1] := 2;
    ColorIDS[2] := 3;
    ColorIDS[3] := 4;

 (* datam1.Query1.SQL.Clear;
    datam1.Query1.SQL.Add('select distinct colorid from pagetable where mastercopyseparationset = ' + inttostr(Mastercopyseparationset));
    datam1.Query1.SQL.Add('order by colorid');
    datam1.Query1.open;
    While not datam1.Query1.eof do
    begin
      CheckListBoxColors.Items.add( tnames1.ColornameIDtoname(datam1.Query1.fieldbyname('colorid').asinteger));

      ColorIDS[CheckListBoxColors.Items.count-1] := datam1.Query1.fieldbyname('colorid').asinteger;
      datam1.Query1.next;
    end;
    datam1.Query1.close;    *)

    For i := 0 to CheckListBoxColors.Items.Count-1 do
    begin
      datam1.Query1.SQL.Clear;
      datam1.Query1.SQL.Add('SELECT DISTINCT Separation FROM PageTable WHERE MasterCopySeparationSet = ' + IntToStr(Mastercopyseparationset));
      datam1.Query1.SQL.Add('AND ColorID = ' + IntToStr(ColorIDS[i]));
      datam1.Query1.SQL.Add('AND Dirty=0 AND Active = 1');
      datam1.Query1.Open;
      CheckListBoxColors.Checked[i] := not datam1.Query1.eof;
      datam1.Query1.Close;
    end;

  end;
end;

procedure TFormEndiscolors.BitBtn1Click(Sender: TObject);
Var
  i : Integer;
  Ncolors : Integer;
begin
  Ncolors := 0;
  enabledcolors := 'ColorID IN (-999';
  Disabledcolors := 'ColorID IN (-999';

  for i := 0 to CheckListBoxColors.Items.Count-1 do
  begin
    if CheckListBoxColors.Checked[i] then
    begin
      Inc(Ncolors);
      enabledcolors := enabledcolors + ',' + IntToStr(ColorIDS[i]);
    end
    else
    begin
      Disabledcolors := Disabledcolors + ',' + IntToStr(ColorIDS[i]);
    end;

  end;
  Disabledcolors := Disabledcolors + ')';
  enabledcolors := enabledcolors + ')';
  ISmono := (Ncolors = 1);
end;

procedure TFormEndiscolors.CheckListBoxColorsClick(Sender: TObject);
Var
  I : Integer;
begin
  BitBtn1.Enabled := false;
  for i := 0 to CheckListBoxColors.Items.Count-1 do
  begin
    IF CheckListBoxColors.checked[i] then
    begin
      BitBtn1.Enabled := true;
      break;
    end;
  end;
end;

end.
