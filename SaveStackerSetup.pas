unit SaveStackerSetup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TFormSaveStackerSetup = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    LabelNumberOfPages: TLabel;
    LabelProductionType: TLabel;
    Label4: TLabel;
    EditSaveName: TEdit;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    Label5: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSaveStackerSetup: TFormSaveStackerSetup;

implementation

{$R *.dfm}

end.
