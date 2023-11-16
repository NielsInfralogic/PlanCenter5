unit UReversePageNumbers;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFormReversePageNumbers = class(TForm)
    Panel1: TPanel;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Label1: TLabel;
     CheckBoxRotateSelectedPages: TCheckBox;
    LabelPageRange: TLabel;
    CheckBoxReprocessNow: TCheckBox;
    procedure CheckBoxRotateSelectedPagesClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  FormReversePageNumbers: TFormReversePageNumbers;

implementation

{$R *.dfm}

procedure TFormReversePageNumbers.CheckBoxRotateSelectedPagesClick(
  Sender: TObject);
begin
  CheckBoxReprocessNow.Enabled :=  CheckBoxRotateSelectedPages.Checked;
end;

procedure TFormReversePageNumbers.FormActivate(Sender: TObject);
begin
   CheckBoxReprocessNow.Enabled := true;
   CheckBoxRotateSelectedPages.Checked := true;
end;

end.
