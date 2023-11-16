unit UCopyStackerSetup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TFormCopyStackerSetup = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    EditCopyFromName: TEdit;
    ComboBoxToEdition: TComboBox;
    BitBtn3: TBitBtn;
    BitBtn1: TBitBtn;
    CheckBoxApplyToAllPresses: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCopyStackerSetup: TFormCopyStackerSetup;

implementation

{$R *.dfm}

end.
