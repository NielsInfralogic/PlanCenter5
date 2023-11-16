unit USelectdefinition;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TFormselectdefinition = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ComboBox1: TComboBox;
    CheckBoxSelectAllPlates: TCheckBox;
    CheckBoxApplyToAllPresses: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Formselectdefinition: TFormselectdefinition;

implementation

{$R *.dfm}

end.
