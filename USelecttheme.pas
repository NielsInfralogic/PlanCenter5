unit USelecttheme;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TFormselecttheme = class(TForm)
    ComboBoxtheme: TComboBox;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Formselecttheme: TFormselecttheme;

implementation

{$R *.dfm}

end.
