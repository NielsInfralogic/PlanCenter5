unit Udefinitionpagerange;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, ExtCtrls, Spin, system.UITypes;

type
  TFormdefPages = class(TForm)
    Label2: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ComboBox1: TComboBox;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    procedure MaskEdit2Exit(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    firstpage : Integer;
    lastpage : Integer;
  end;

var
  FormdefPages: TFormdefPages;

implementation

uses Umain;

{$R *.dfm}

procedure TFormdefPages.MaskEdit2Exit(Sender: TObject);
begin
  IF spinedit1.Value > 0 then
  begin
    IF (spinedit2.Value > spinedit1.Value) then
    begin
      beep;
      MessageDlg(formmain.InfraLanguage1.Translate('from pagenumber must be lower than to pagenumber'), mtInformation,
        [mbOk], 0);

    end;
  End;
end;

procedure TFormdefPages.BitBtn1Click(Sender: TObject);
Begin
  firstpage := spinedit1.Value;
  lastpage := spinedit2.Value;
End;

procedure TFormdefPages.FormActivate(Sender: TObject);
begin
  ComboBox1.ItemIndex := 0;
end;

procedure TFormdefPages.SpinEdit1Change(Sender: TObject);
begin
  IF spinedit1.Text <> '' then
  Begin
    IF spinedit1.Text = '' then
    begin
      spinedit2.Value := spinedit1.Value;
    end
    else
    begin
      IF spinedit2.Value < spinedit1.Value then
        spinedit2.Value := spinedit1.Value;
    End;
  End;
end;

end.
