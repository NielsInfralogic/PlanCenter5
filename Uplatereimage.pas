unit Uplatereimage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, PBExListview, CheckLst;

type
  TFormplatereimage = class(TForm)
    Panel3: TPanel;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    GroupBox1: TGroupBox;
    Panel2: TPanel;
    Button1: TButton;
    EditNcopies: TEdit;
    UpDown1: TUpDown;
    CheckListBoxCopies: TCheckListBox;
    GroupBox2: TGroupBox;
    RadioGroup1: TRadioGroup;
    RadioButtonReimageReason1: TRadioButton;
    RadioButtonReimageReason2: TRadioButton;
    RadioButtonReimageReason3: TRadioButton;
    CheckBox2: TCheckBox;
    CheckBox1: TCheckBox;
    EditReimageReason: TEdit;
    CheckBoxReleaseNow: TCheckBox;
    PBExListviewreimage: TPBExListview;
    procedure PBExListviewreimageClick(Sender: TObject);
    procedure PBExListviewreimageMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure EditNcopiesChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckListBoxCopiesClickCheck(Sender: TObject);
    procedure RadioButtonReimageReason1Clicked(Sender: TObject);
    procedure RadioButtonReimageReason2Clicked(Sender: TObject);
    procedure RadioButtonReimageReason3Clicked(Sender: TObject);

  private
    { Private declarations }
  public
    Andcopiesinstr : String;
    Allactivesel : Boolean;
    procedure Setallcopies;
  end;

var
  Formplatereimage: TFormplatereimage;

implementation
Uses
  umain, Usettings;
{$R *.dfm}

procedure TFormplatereimage.PBExListviewreimageClick(Sender: TObject);
begin
  if PBExListviewreimage.Selected = nil then exit;
  IF PBExListviewreimage.Selected.StateIndex = 0 then
    PBExListviewreimage.Selected.StateIndex := 1
  else
  begin
    checkbox1.Checked := false;
    PBExListviewreimage.Selected.StateIndex := 0;
  end;
end;

procedure TFormplatereimage.PBExListviewreimageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var
  L : Tlistitem;
begin
  L := PBExListviewreimage.GetItemAt(X, Y);
  IF L <> nil then
  begin
    PBExListviewreimage.Selected := L;
  end;
end;

procedure TFormplatereimage.FormActivate(Sender: TObject);
Var
  i : Longint;
begin
  IF Prefs.SelectAllCopiesOnReimage then
  begin
    for i := 0 to CheckListBoxCopies.Items.Count-1 do
      CheckListBoxCopies.Checked[i] := true;
  end;
  for i := 0 to PBExListviewreimage.Items.Count-1 do
  begin
    PBExListviewreimage.Items[i].Checked := false;
    PBExListviewreimage.Items[i].StateIndex := 0;
  end;
  IF Prefs.ReimageAllColors then
  begin
    for i := 0 to PBExListviewreimage.Items.Count-1 do
    begin
      PBExListviewreimage.Items[i].Checked := true;
      PBExListviewreimage.Items[i].StateIndex := 1;
    end;
  end;


  Allactivesel := false;
  EditNcopies.Text := '1';
  CheckBox2.Checked :=  false;
  PBExListviewreimage.Items.BeginUpdate;
  if PBExListviewreimage.Items.Count = 1 then
    PBExListviewreimage.Items[0].StateIndex := 1;
  PBExListviewreimage.Items.endUpdate;
  EditReimageReason.Enabled := false;

end;

procedure TFormplatereimage.CheckBox2Click(Sender: TObject);
Var
  I : Longint;
begin
  For i := 0 to PBExListviewreimage.Items.Count-1 do
    PBExListviewreimage.Items[i].StateIndex := Integer(CheckBox2.Checked);

  if not checkbox2.Checked then
    checkbox1.Checked := false;
end;

procedure TFormplatereimage.EditNcopiesChange(Sender: TObject);
Var
  T : string;
  I,N : longint;
begin
  IF EditNcopies.Text = '' then
    EditNcopies.Text := '1';

  if strtoint(EditNcopies.Text) > UpDown1.Max then
    EditNcopies.Text := inttostr(UpDown1.Max);

  For i := 0 to CheckListBoxCopies.items.Count-1 do
  Begin
    IF CheckListBoxCopies.checked[i] then
      Andcopiesinstr := Andcopiesinstr + ','+CheckListBoxCopies.items[i];
  End;

  For i := 0 to CheckListBoxCopies.items.Count-1 do
  Begin
    CheckListBoxCopies.checked[i] := i+1 <= strtoint(EditNcopies.Text);
  End;

  For i := 0 to CheckListBoxCopies.items.Count-1 do
  Begin
    IF not CheckListBoxCopies.checked[i] then
    begin
      checkbox1.Checked := false;
    end;
  End;

end;

procedure TFormplatereimage.Button1Click(Sender: TObject);
Begin
  Setallcopies;
end;



procedure TFormplatereimage.Setallcopies;
Var
  I : Longint;

begin
  For i := 0 to CheckListBoxCopies.items.Count-1 do
    CheckListBoxCopies.checked[i] := true;
end;

procedure TFormplatereimage.BitBtn1Click(Sender: TObject);
Var
  I : Longint;

begin
  Andcopiesinstr := ' (-1';
  For i := 0 to CheckListBoxCopies.items.Count-1 do
  Begin
    IF CheckListBoxCopies.checked[i] then
      Andcopiesinstr := Andcopiesinstr + ','+CheckListBoxCopies.items[i];
  End;
  Andcopiesinstr := Andcopiesinstr + ')';
end;

procedure TFormplatereimage.BitBtn4Click(Sender: TObject);
Var
  I : Longint;

begin
  Andcopiesinstr := ' (-1';
  For i := 0 to CheckListBoxCopies.items.Count-1 do
  Begin
    IF CheckListBoxCopies.checked[i] then
      Andcopiesinstr := Andcopiesinstr + ','+CheckListBoxCopies.items[i];
  End;
  Andcopiesinstr := Andcopiesinstr + ')';
end;

procedure TFormplatereimage.BitBtn3Click(Sender: TObject);
Var
  I : Longint;
begin
  For i := 0 to CheckListBoxCopies.items.count-1 do
    CheckListBoxCopies.checked[i] := true;
end;

procedure TFormplatereimage.CheckBox1Click(Sender: TObject);
Var
  I : Longint;
begin
  IF CheckBox1.checked then
  begin
//    For i := 0 to PBExListviewreimage.Items.Count-1 do
//      PBExListviewreimage.Items[i].StateIndex := 1;


    Setallcopies;

  end;
end;

procedure TFormplatereimage.CheckListBoxCopiesClickCheck(Sender: TObject);
Var
  i : Longint;
begin
  For i := 0 to CheckListBoxCopies.items.Count-1 do
  Begin
    IF not CheckListBoxCopies.checked[i] then
    begin
      checkbox1.Checked := false;
    end;
  End;

end;

procedure TFormplatereimage.RadioButtonReimageReason1Clicked(
  Sender: TObject);
begin
  EditReimageReason.Enabled := false;
end;

procedure TFormplatereimage.RadioButtonReimageReason2Clicked(
  Sender: TObject);
begin
  EditReimageReason.Enabled := false;
end;

procedure TFormplatereimage.RadioButtonReimageReason3Clicked(
  Sender: TObject);
begin
  EditReimageReason.Enabled := true;

end;

end.
