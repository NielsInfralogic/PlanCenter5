unit UEditplatecopies;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls;

type
  TFormEditplatecopies = class(TForm)
    ListView1: TListView;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure ListView1Change(Sender: TObject; Item: TListItem;
      Change: TItemChange);
  private
    { Private declarations }
  public
    { Public declarations }
    Copyselstr : String;
    maxcopynumber : Longint;
    Function Doit:Boolean;
  end;

var
  FormEditplatecopies: TFormEditplatecopies;

implementation
Uses
  UPlateviewframe,Umain;
{$R *.dfm}

procedure TFormEditplatecopies.BitBtn1Click(Sender: TObject);
Var
  I : Longint;
begin
  Copyselstr := 'copynumber in (-99';
  For i := 0 to ListView1.Items.Count-1 do
  begin
    if ListView1.Items[i].Checked then
      Copyselstr := Copyselstr + ',' + ListView1.Items[i].caption;
  end;
  Copyselstr := Copyselstr + ')';
end;

procedure TFormEditplatecopies.FormActivate(Sender: TObject);
Var
  I : Longint;
  Ancop : Longint;
  L : Tlistitem;

begin

  IF ListView1.Items.Count = 0 then
  begin
    For i := 1 to FormEditplatecopies.maxcopynumber do
    Begin
      L := ListView1.Items.add();
      L.Caption := inttostr(I);
      L.Checked := false;
    end;
  end;

  IF ListView1.Items.Count < ancop then
  begin
    For i := ListView1.Items.Count+1  to ancop do
    begin
      L := ListView1.Items.add();
      L.Caption := inttostr(I);
      L.Checked := false;
    end;
  end;

  IF ListView1.Items.Count > ancop then
  begin
    For I := ListView1.Items.Count downto ancop+1 do
    begin
      ListView1.Items[i-1].Delete;
    end;
  end;

  For i := 0 to ListView1.Items.Count-1 do
    ListView1.Items[i].Checked := false;


  ListView1.Items[0].Checked := true;
end;

procedure TFormEditplatecopies.BitBtn3Click(Sender: TObject);
Var
  I : Longint;
begin
  Copyselstr := ' copynumber > -1';
  For i := 0 to ListView1.Items.Count-1 do
    ListView1.Items[i].Checked := true;
end;

Function TFormEditplatecopies.Doit:Boolean;
Var
  I : Longint;
  L : Tlistitem;
  mcopies : Boolean;
Begin
  result := false;
  try
    mcopies := false;
    For i := 0 to Views[Viewselected].LPV.items.count-1 do
    begin
      IF Views[Viewselected].LPV.items[i].Selected then
      begin
        IF Views[Viewselected].platesData[Views[Viewselected].LPV.Items[i].ImageIndex].Ncopies > 1 then
        begin
          mcopies := true;
          break;
        end;

      End;
    End;

    IF mcopies then
    begin
      result := FormEditplatecopies.ShowModal = mrok;
    end
    else
    Begin
      ListView1.Items.clear;
      L := ListView1.Items.add;
      L.caption := '1';
      L.checked := true;
      Copyselstr := 'copynumber = 1';
      result := true;
    end;
  Except
  end;

end;
//DataM1.Query1.SQL.add('and '+FormEditplatecopies.Copyselstr);
//IF not FormEditplatecopies.showmodal = mrok then exit;


procedure TFormEditplatecopies.ListView1Change(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
  beep;
end;

end.
