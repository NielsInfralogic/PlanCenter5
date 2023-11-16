unit UEditcolors;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,ComCtrls, Buttons, ExtCtrls, CheckLst;

type
  TFormeditcolors = class(TForm)
    CheckListBoxColors: TCheckListBox;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ListBox1: TListBox;
    ListBox2: TListBox;
    ListBox3: TListBox;
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CheckListBoxColorsClick(Sender: TObject);
  private
    { Private declarations }
  public
  end;

var
  Formeditcolors: TFormeditcolors;

implementation

{$R *.dfm}

procedure TFormeditcolors.BitBtn1Click(Sender: TObject);
Var
  I1,I : Longint;
begin

  listbox2.Items.clear;
  listbox3.Items.clear;

  For i := 0 to CheckListBoxColors.Items.count-1 do
  begin
    i1 := listbox1.Items.IndexOf(CheckListBoxColors.Items[i]);
    IF CheckListBoxColors.checked[i1] then
    begin
      If i1 = -1 then
        listbox2.Items.add(CheckListBoxColors.Items[i]);
    end
    else
    begin
      if i1 <> -1 then
        listbox3.Items.add(CheckListBoxColors.Items[i]);
    end;
  End;
end;

procedure TFormeditcolors.Button1Click(Sender: TObject);
Var
  I1,I : Longint;
begin
  listbox2.Items.clear;
  listbox3.Items.clear;

  For i := 0 to CheckListBoxColors.Items.count-1 do
  begin
    i1 := listbox1.Items.IndexOf(CheckListBoxColors.Items[i]);
    IF CheckListBoxColors.checked[i] then
    begin
      If i1 = -1 then
        listbox2.Items.add(CheckListBoxColors.Items[i]);
    end
    else
    begin
      if i1 <> -1 then
        listbox3.Items.add(CheckListBoxColors.Items[i]);
    end;
  End;
end;

procedure TFormeditcolors.FormActivate(Sender: TObject);
Var
  I : longint;
begin
  listbox1.Items.clear;
  listbox2.Items.clear;
  listbox3.Items.clear;

  For i := 0 to CheckListBoxColors.Items.count-1 do
  begin
    IF CheckListBoxColors.checked[i] then
    Begin
      listbox1.Items.add(CheckListBoxColors.items[i]);
    end;
  End;
end;

procedure TFormeditcolors.CheckListBoxColorsClick(Sender: TObject);
Var
  I : Longint;
begin
  BitBtn1.enabled := false;
  For i := 0 to CheckListBoxColors.Items.count-1 do
  begin
    if CheckListBoxColors.checked[i] then
    begin
      BitBtn1.enabled := true;
      break;
    end;
  end;
end;

end.
