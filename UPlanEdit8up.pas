unit UPlanEdit8up;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TFormEdit8upPlate = class(TForm)
    BitBtnCancel: TBitBtn;
    BitBtnOK: TBitBtn;
    GroupBox1: TGroupBox;
    EditPos1: TEdit;
    GroupBox2: TGroupBox;
    EditPos2: TEdit;
    GroupBox3: TGroupBox;
    EditPos5: TEdit;
    GroupBox4: TGroupBox;
    EditPos6: TEdit;
    Label1: TLabel;
    GroupBox5: TGroupBox;
    EditPos3: TEdit;
    GroupBox6: TGroupBox;
    EditPos4: TEdit;
    GroupBox7: TGroupBox;
    EditPos7: TEdit;
    GroupBox8: TGroupBox;
    EditPos8: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure BitBtnOKClick(Sender: TObject);
    procedure EditPosChange(Sender: TObject);
  private
    { Private declarations }
  public
    Pages : Array[1..8] of Integer;
  end;

var
  FormEdit8upPlate: TFormEdit8upPlate;

implementation

{$R *.dfm}

procedure TFormEdit8upPlate.BitBtnOKClick(Sender: TObject);
begin
  Pages[1] := StrToInt(EditPos1.Text);
  Pages[2] := StrToInt(EditPos2.Text);
  Pages[3] := StrToInt(EditPos3.Text);
  Pages[4] := StrToInt(EditPos4.Text);
  Pages[5] := StrToInt(EditPos5.Text);
  Pages[6] := StrToInt(EditPos6.Text);
  Pages[7] := StrToInt(EditPos7.Text);
  Pages[8] := StrToInt(EditPos8.Text);
end;

procedure TFormEdit8upPlate.EditPosChange(Sender: TObject);
begin
  if ((Sender as TEdit).Text = '0') then
    (Sender as TEdit).Color := clBtnFace
  else
    (Sender as TEdit).Color := clWindow;
end;

procedure TFormEdit8upPlate.FormActivate(Sender: TObject);
begin
  EditPos1.Text := IntToStr(Pages[1]);
  EditPos2.Text := IntToStr(Pages[2]);
  EditPos3.Text := IntToStr(Pages[3]);
  EditPos4.Text := IntToStr(Pages[4]);
  EditPos5.Text := IntToStr(Pages[5]);
  EditPos6.Text := IntToStr(Pages[6]);
  EditPos7.Text := IntToStr(Pages[7]);
  EditPos8.Text := IntToStr(Pages[8]);
end;

end.
