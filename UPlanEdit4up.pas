unit UPlanEdit4up;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TFormEdit4upPlate = class(TForm)
    BitBtnCancel: TBitBtn;
    BitBtnOK: TBitBtn;
    GroupBox1: TGroupBox;
    EditPos1: TEdit;
    GroupBox2: TGroupBox;
    EditPos2: TEdit;
    GroupBox3: TGroupBox;
    EditPos3: TEdit;
    GroupBox4: TGroupBox;
    EditPos4: TEdit;
    Label1: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure BitBtnOKClick(Sender: TObject);
    procedure EditPosChange(Sender: TObject);
  private
    { Private declarations }
  public
    Pages : Array[1..4] of Integer;
  end;

var
  FormEdit4upPlate: TFormEdit4upPlate;

implementation

{$R *.dfm}

procedure TFormEdit4upPlate.BitBtnOKClick(Sender: TObject);
begin
  Pages[1] := StrToInt(EditPos1.Text);
  Pages[2] := StrToInt(EditPos2.Text);
  Pages[3] := StrToInt(EditPos3.Text);
  Pages[4] := StrToInt(EditPos4.Text);
end;

procedure TFormEdit4upPlate.EditPosChange(Sender: TObject);
begin
  if ((Sender as TEdit).Text = '0') then
    (Sender as TEdit).Color := clBtnFace
  else
    (Sender as TEdit).Color := clWindow;
end;


procedure TFormEdit4upPlate.FormActivate(Sender: TObject);
begin
  EditPos1.Text := IntToStr(Pages[1]);
  EditPos2.Text := IntToStr(Pages[2]);
  EditPos3.Text := IntToStr(Pages[3]);
  EditPos4.Text := IntToStr(Pages[4]);
end;

end.
