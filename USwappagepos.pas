unit USwappagepos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls;

type
  TFormSwappos = class(TForm)
    GroupBox1: TGroupBox;
    ListView1: TListView;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
  private
    { Private declarations }
  public
    Procedure init(numberofpos : Longint);

  end;

var
  FormSwappos: TFormSwappos;

implementation

{$R *.dfm}


Procedure TFormSwappos.init(numberofpos : Longint);
Var
  I : Longint;
  l : Tlistitem;
Begin
  ListView1.items.clear;
  For i := 1 to numberofpos do
  begin
    l := ListView1.items.add;
    l.Caption := inttostr(i);
  end;
end;


end.
