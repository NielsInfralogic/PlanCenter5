unit USelcolors;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, CheckLst;

type
  TFormSelcolors = class(TForm)
    CheckListBoxColors: TCheckListBox;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSelcolors: TFormSelcolors;

implementation

{$R *.dfm}

end.
