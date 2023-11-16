unit UHSOrder;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls;
type
  TFormColorder = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Timer1: TTimer;
    Panel3: TPanel;
    GroupBox1: TGroupBox;
    ListBox1: TListBox;
    Edit1: TEdit;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure BitBtn2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Edit1Change(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn9MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    procedure MoveTop;
    procedure MoveBottom;
    procedure moveup;
    Procedure movedown;
    { Private declarations }
  public
    { Public declarations }
  end;
var
  FormColorder: TFormColorder;
implementation
{$R *.dfm}
Uses
  utypes,inifiles,umain, Uusercolssaveload, Ulogin, Ueditatextcombo, Udata;
Var
  direction,moving : Integer;
  orgHSorder : array[0..200] of integer;
  orgHS :  array[0..200] of record
                              name : string;
                              field : string;
                              Kind  : Integer; //0 Integer 1 string 2 Yesno 3 date 4 tid 5 status 6 device 7 template 20 external status
                              ColX   : Integer;
                              width : Integer;
                              tag   : Integer;
                              Show  : Boolean;
                              iscaption : boolean;
                              Inorder : Boolean;
                              fieldpos : Longint;
                              Inlist : boolean;
                              Mandatory : Boolean;
                            End;
procedure TFormColorder.FormActivate(Sender: TObject);
Var
  I : Integer;
begin
  direction := 0;
  ListBox1.Items.clear;
  For i := 0 to MAXColsortcount do
  begin
    ListBox1.Items.add(HSCols[HSOrder[i]].name);
    orgHSorder[i] := HSOrder[i];
  end;

  Timer1.Enabled := true;
  Edit1.Text := '';
end;
procedure TFormColorder.moveTop;
Var
  i, x : Integer;
begin
  IF ListBox1.ItemIndex > 0 then
  begin
    x := HSOrder[ListBox1.ItemIndex];
    ListBox1.Items.BeginUpdate;
    for i := ListBox1.ItemIndex downto 1 do
    Begin
      ListBox1.Items.Move(i, i - 1);
      HSOrder[i] := HSOrder[i - 1];
    End;
    HSOrder[0] := x;
    ListBox1.Items.EndUpdate;
    ListBox1.ItemIndex := 0;
    ListBox1.SetFocus;
  end;
end;
procedure TFormColorder.MoveBottom;
Var
  i, x : Integer;
begin
  IF ListBox1.ItemIndex >= 0 then
  begin
    x := HSOrder[ListBox1.ItemIndex];
    ListBox1.Items.BeginUpdate;
    for i := ListBox1.ItemIndex to ListBox1.Items.Count - 2 do
    Begin
      ListBox1.Items.Move(i, i + 1);
      HSOrder[i] := HSOrder[i + 1];
    End;
    HSOrder[ListBox1.Items.Count - 1] := x;
    ListBox1.Items.EndUpdate;
    ListBox1.ItemIndex := 0;
    ListBox1.SetFocus;
  end;
end;

procedure TFormColorder.moveup;
Var
  i,x : INteger;
begin
  IF ListBox1.ItemIndex > 0 then
  begin
    x := HSOrder[ListBox1.ItemIndex];
    HSOrder[ListBox1.ItemIndex] := HSOrder[ListBox1.ItemIndex-1];
    HSOrder[ListBox1.ItemIndex-1] := x;
    I := ListBox1.ItemIndex;
    ListBox1.Items.Move(ListBox1.ItemIndex,ListBox1.ItemIndex-1);
    ListBox1.ItemIndex := i-1;
    ListBox1.SetFocus;
  end;
end;
Procedure TFormColorder.movedown;
Var
  i,x : INteger;
begin
  IF ListBox1.ItemIndex < ListBox1.Items.Count-1 then
  begin
    I := ListBox1.ItemIndex;
    x := HSOrder[ListBox1.ItemIndex];
    HSOrder[ListBox1.ItemIndex] := HSOrder[ListBox1.ItemIndex+1];
    HSOrder[ListBox1.ItemIndex+1] := x;
    ListBox1.Items.Move(ListBox1.ItemIndex,ListBox1.ItemIndex+1);
    ListBox1.ItemIndex := i+1;
    ListBox1.SetFocus;
  end;
end;
procedure TFormColorder.BitBtn1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  moveup;
  direction := 1;
  Timer1.Enabled := true;
end;
procedure TFormColorder.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Timer1.Enabled := false;
end;
procedure TFormColorder.Timer1Timer(Sender: TObject);
begin
  Case direction of
    1 : moveup;
    2 : movedown;
  end;
end;
procedure TFormColorder.BitBtn2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  movedown;
  direction := 2;
  Timer1.Enabled := true;
end;
procedure TFormColorder.BitBtn1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  direction := 0;
  Timer1.Enabled := false;
end;
procedure TFormColorder.BitBtn2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  direction := 0;
  Timer1.Enabled := false;
end;
procedure TFormColorder.Edit1Change(Sender: TObject);
Var
  T : string;
  I : Longint;
begin
  if edit1.text <> '' then
  begin
    for i := 0 to listbox1.Items.Count-1 do
    begin
      t := uppercase(listbox1.Items[i]);
      delete(t,length(edit1.text)+1,length(t));
      if t = uppercase(edit1.text) then
      begin
        listbox1.Itemindex := i;
        break;
      end;
    end;
  end;
end;
procedure TFormColorder.BitBtn4Click(Sender: TObject);
Var
  I : Longint;
begin
  ListBox1.Items.clear;
  For i := 0 to MAXColsortcount do
  begin
    HSOrder[i] := orgHSorder[i];
  end;
  For i := 0 to MAXColsortcount do
  begin
    ListBox1.Items.add(HSCols[HSOrder[i]].name);
  end;
end;
procedure TFormColorder.BitBtn5Click(Sender: TObject);
begin
  FormSaveloadcols.Savemycols(Prefs.username);
  FormColorder.close;
end;
procedure TFormColorder.BitBtn6Click(Sender: TObject);
begin
  Formeditatext.caption := 'Save as';
  Formeditatext.Label1.Caption := 'User';
  Formeditatext.ComboBox1.style := csDropDownList;
  Formeditatext.ComboBox1.items.clear;
  datam1.Query2.SQL.clear;
  datam1.Query2.SQL.add('select Distinct(Username) from usernames');
  datam1.Query2.SQL.add('order by Username');
  datam1.Query2.open;
  While not datam1.Query2.eof do
  begin
    Formeditatext.ComboBox1.items.add(datam1.Query2.fields[0].asstring);
    datam1.Query2.next;
  end;
  Formeditatext.ComboBox1.itemindex := 0;
  IF Formeditatext.ShowModal = mrok then
  begin
    FormSaveloadcols.Savemycols(Formeditatext.ComboBox1.text);
  End;
end;
procedure TFormColorder.BitBtn7Click(Sender: TObject);
Var
  T : string;
  I,fromI : Longint;
begin
  if edit1.text <> '' then
  begin
    IF listbox1.Itemindex > 0 then
    begin
      fromI := listbox1.Itemindex+1;
    end
    else
    begin
      fromI := 0;
    end;
    for i := fromI to listbox1.Items.Count-1 do
    begin
      t := uppercase(listbox1.Items[i]);
      delete(t,length(edit1.text)+1,length(t));
      if t = uppercase(edit1.text) then
      begin
        listbox1.Itemindex := i;
        break;
      end;
    end;
  end;
end;
Procedure TFormColorder.BitBtn8MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  MoveTop;
end;

Procedure TFormColorder.BitBtn9MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  MoveBottom;
end;

End.
