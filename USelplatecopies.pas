unit USelplatecopies;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls;

type
  TFormSelplatecopies = class(TForm)
    ListView1: TListView;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    Function activationsetup:boolean;
  public
    { Public declarations }

    Copyselstr : String;
    autoall    : Boolean;
    procedure SetCopyselstr;
    Function Doit:Boolean;
    Function InitializeIt:Boolean;
  end;

var
  FormSelplatecopies: TFormSelplatecopies;

implementation
Uses
  UPlateviewframe,Umain,
  Usettings;
{$R *.dfm}

procedure TFormSelplatecopies.BitBtn1Click(Sender: TObject);
Begin
  SetCopyselstr;

end;

procedure TFormSelplatecopies.SetCopyselstr;
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

procedure TFormSelplatecopies.BitBtn3Click(Sender: TObject);
Var
  I : Longint;
begin
  Copyselstr := ' copynumber > -1';
  For i := 0 to ListView1.Items.Count-1 do
    ListView1.Items[i].Checked := true;
end;


Function TFormSelplatecopies.InitializeIt:Boolean;
Var
  I : Longint;
  L : Tlistitem;
  mcopies : Boolean;
  Ancop : Longint;

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

    IF Not mcopies then
    Begin
      ListView1.Items.clear;
      L := ListView1.Items.add;
      L.caption := '1';
      L.checked := true;
      Copyselstr := 'copynumber = 1';

    end;



    IF activationsetup then
      result := true;
  Except
  end;



end;

Function TFormSelplatecopies.activationsetup:Boolean;
Var
  I : Longint;
  L : Tlistitem;
  mcopies : Boolean;
  Ancop : Longint;

Begin
  try
    result := false;
    Ancop := 1;
    For i := 0 to Views[Viewselected].LPV.items.count-1 do
    begin
      IF Views[Viewselected].LPV.items[i].Selected then
      begin
        IF Views[Viewselected].platesData[Views[Viewselected].LPV.Items[i].ImageIndex].Ncopies > ancop then
          ancop := Views[Viewselected].platesData[Views[Viewselected].LPV.Items[i].ImageIndex].Ncopies;
      End;
    End;

    IF ListView1.Items.Count = 0 then
    begin
      For i := 1 to ancop do
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

    if ListView1.Items.Count > ancop then
    begin
      For I := ListView1.Items.Count downto ancop+1 do
      begin
        ListView1.Items[i-1].Delete;
      end;
    end;

    if (Prefs.SelectAllCopiesOnRelease) then
    begin
      For i := 0 to ListView1.Items.Count-1 do
        ListView1.Items[i].Checked := true;
    end
    else
    begin
      For i := 0 to ListView1.Items.Count-1 do
        ListView1.Items[i].Checked := false;
    End;

    ListView1.Items[0].Checked := true;
    result := true;
  except
  end;
End;

Function TFormSelplatecopies.Doit:Boolean;
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
      activationsetup;
      result := FormSelplatecopies.ShowModal = mrok;
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

//DataM1.Query1.SQL.add('and '+FormSelplatecopies.Copyselstr);
//IF not FormSelplatecopies.showmodal = mrok then exit;


procedure TFormSelplatecopies.FormCreate(Sender: TObject);
begin
  autoall := false;
end;

end.
