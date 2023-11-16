unit Umarkgroups;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, CheckLst,utypes;

type
  TFormMarkgroups = class(TForm)
    CheckListBoxmarkgroups: TCheckListBox;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    Procedure initmarks;
    { Private declarations }
  public
    templatelistid : Integer;
    ANmarks : Integer;
    Amarks  : marksarray;
    { Public declarations }
  end;

var
  FormMarkgroups: TFormMarkgroups;

implementation
Uses
  umain,Udata;
{$R *.dfm}

Procedure TFormMarkgroups.initmarks;
Var
  i,i2 : Integer;
Begin
  CheckListBoxmarkgroups.Items.clear;
  IF templatelistid > 0 then
  begin
    for i := 1 to  PlatetemplateArray[templatelistid].Nmarkgroups do
    begin
      for i2 := 1 to nmarks do
      begin
        if marks[i2].markid = PlatetemplateArray[templatelistid].markgroups[i] then
        begin
          CheckListBoxmarkgroups.Items.add(marks[i2].markname);
          break;
        end;
      end;
    end;
  End
  Else
  Begin
  End;
  For i := 0 to CheckListBoxmarkgroups.Items.count-1 do
  begin
    CheckListBoxmarkgroups.Checked[i] := false;
    for i2 := 1 to ANmarks do
    begin
      if uppercase(CheckListBoxmarkgroups.items[i]) = uppercase(inittypes.markIDtoname(amarks[i2])) then
      begin
        CheckListBoxmarkgroups.Checked[i] := true;
        break;
      end;
    end;
  end;
end;

procedure TFormMarkgroups.FormActivate(Sender: TObject);
begin
  initmarks;
end;

procedure TFormMarkgroups.BitBtn1Click(Sender: TObject);
Var
  i : Integer;
begin
  ANmarks := 0;
  For i := 0 to CheckListBoxmarkgroups.Items.count-1 do
  begin
    if CheckListBoxmarkgroups.Checked[i] then
    begin
      Inc(ANmarks);
      Amarks[ANmarks] := inittypes.marknametoid(CheckListBoxmarkgroups.Items[i]);
    end;
  End;
end;

end.
