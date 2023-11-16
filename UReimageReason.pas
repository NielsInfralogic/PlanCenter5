unit UReimageReason;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TFormReimageReason = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    RadioGroup1: TRadioGroup;
    RadioButtonReimageReason2: TRadioButton;
    RadioButtonReimageReason1: TRadioButton;
    RadioButtonReimageReason3: TRadioButton;
    EditReimageReason: TEdit;
    CheckBoxReleaseNow: TCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure RadioButtonReimageReason1Click(Sender: TObject);
    procedure RadioButtonReimageReason2Click(Sender: TObject);
    procedure RadioButtonReimageReason3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormReimageReason: TFormReimageReason;

implementation

{$R *.dfm}

procedure TFormReimageReason.FormActivate(Sender: TObject);
begin
  EditReimageReason.Enabled := false;
end;

procedure TFormReimageReason.RadioButtonReimageReason1Click(
  Sender: TObject);
begin
  EditReimageReason.Enabled := false;
end;

procedure TFormReimageReason.RadioButtonReimageReason2Click(
  Sender: TObject);
begin
  EditReimageReason.Enabled := false;
end;

procedure TFormReimageReason.RadioButtonReimageReason3Click(
  Sender: TObject);
begin
  EditReimageReason.Enabled := true;
end;

end.
