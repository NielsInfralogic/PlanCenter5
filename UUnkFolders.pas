unit UUnkFolders;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, ExtCtrls, Buttons, UMain;

type
  TFormerrorfolderselect = class(TForm)
    Panel1: TPanel;
    CheckListBox1: TCheckListBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure CheckListBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Formerrorfolderselect: TFormerrorfolderselect;

implementation

{$R *.dfm}

procedure TFormerrorfolderselect.CheckListBox1Click(Sender: TObject);
Var
  I : Longint;
begin

  if CheckListBox1.itemindex = 0 then
  Begin
    For i := 0 to CheckListBox1.items.Count-1 do
      CheckListBox1.checked[i] := false;

    CheckListBox1.checked[0] := true;
  end;

  For i := 1 to CheckListBox1.items.Count-1 do
  Begin
    IF CheckListBox1.checked[i] then
    begin
      CheckListBox1.checked[0] := false;
    end;

  End;
end;



end.
