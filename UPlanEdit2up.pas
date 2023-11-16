unit UPlanEdit2up;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TFormEdit2upPlate = class(TForm)
    BitBtnCancel: TBitBtn;
    BitBtnOK: TBitBtn;
    GroupBox1: TGroupBox;
    EditPos1: TEdit;
    GroupBox2: TGroupBox;
    EditPos2: TEdit;
    Label1: TLabel;
    procedure BitBtnOKClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure EditPosChange(Sender: TObject);
  private
    { Private declarations }
   public
    Pages : Array[1..2] of Integer;
  end;

var
  FormEdit2upPlate: TFormEdit2upPlate;

implementation

{$R *.dfm}

procedure TFormEdit2upPlate.BitBtnOKClick(Sender: TObject);
begin
  Pages[1] := StrToInt(EditPos1.Text);
  Pages[2] := StrToInt(EditPos2.Text);
end;


procedure TFormEdit2upPlate.EditPosChange(Sender: TObject);
begin
  if ((Sender as TEdit).Text = '0') then
    (Sender as TEdit).Color := clBtnFace
  else
    (Sender as TEdit).Color := clWindow;
end;

procedure TFormEdit2upPlate.FormActivate(Sender: TObject);
begin
  EditPos1.Text := IntToStr(Pages[1]);
  EditPos2.Text := IntToStr(Pages[2]);
end;

end.
