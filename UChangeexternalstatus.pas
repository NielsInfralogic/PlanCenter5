unit UChangeexternalstatus;

interface

uses

  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFormChangeextstatus = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ListBox1: TListBox;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    selectedexternalstatus : Integer;


  end;

var
  FormChangeextstatus: TFormChangeextstatus;

implementation
Uses
  utypes;
{$R *.dfm}

Var
  listnumbers : Array[0..520] of integer;


procedure TFormChangeextstatus.FormActivate(Sender: TObject);
Var
  I : Integer;
  aktindex : Longint;
begin
  aktindex := 0;
  IF listbox1.ItemIndex > -1 then
    aktindex := listbox1.ItemIndex;
  listbox1.Items.Clear;

  for i:= 0 to 200 do
  begin
    if externalstatusarrayex[i].name <> '' then
    begin
      listbox1.Items.add(externalstatusarrayex[i].name);
      listnumbers[listbox1.Items.count-1] := externalstatusarrayex[i].number;
    end;
  end;

(*  For i := 1 to 520 do
  begin
    if externalstatusarray[i].name <> '' then
    begin
      listbox1.Items.add(externalstatusarray[i].name);
      listnumbers[listbox1.Items.count-1] := i;
    end;
  end;
*)
  IF aktindex > ListBox1.Items.Count-1 then
    aktindex := 0;
  ListBox1.Itemindex := aktindex;

end;

procedure TFormChangeextstatus.BitBtn1Click(Sender: TObject);
begin
  selectedexternalstatus := -1;

  IF ListBox1.Itemindex <> -1 then
  begin
    selectedexternalstatus := listnumbers[ListBox1.Itemindex];
  end;

end;

end.
