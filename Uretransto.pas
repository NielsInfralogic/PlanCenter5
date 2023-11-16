unit Uretransto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, CheckLst;

type
  TFormretransto = class(TForm)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    CheckListBox1: TCheckListBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
  private
    { Private declarations }
  public
    productionID : Longint;
  end;

var
  Formretransto: TFormretransto;

implementation

{$R *.dfm}

end.
