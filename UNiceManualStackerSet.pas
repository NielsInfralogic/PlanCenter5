unit UNiceManualStackerSet;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TFormNiceManualStackerSet = class(TForm)
    ComboBoxC: TComboBox;
    Label1: TLabel;
    ComboBoxM: TComboBox;
    Label2: TLabel;
    ComboBoxY: TComboBox;
    Label3: TLabel;
    ComboBoxK: TComboBox;
    Label4: TLabel;
    BitBtnOK: TBitBtn;
    BitBtnCancel: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure ComboBoxCChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormNiceManualStackerSet: TFormNiceManualStackerSet;

implementation

{$R *.dfm}

procedure TFormNiceManualStackerSet.ComboBoxCChange(Sender: TObject);
var
  i : Integer;
begin
  i := ComboBoxC.ItemIndex;
  ComboBoxM.ItemIndex := i;
  ComboBoxY.ItemIndex := i+1;
  ComboBoxK.ItemIndex := i+1;
end;

procedure TFormNiceManualStackerSet.FormActivate(Sender: TObject);
begin
  ComboBoxC.ItemIndex := 0;
  ComboBoxM.ItemIndex := 0;
  ComboBoxY.ItemIndex := 1;
  ComboBoxK.ItemIndex := 1;
end;

procedure TFormNiceManualStackerSet.FormCreate(Sender: TObject);
var
  i : Integer;
begin
    for i := 1 to 52 do
    begin
      ComboBoxC.Items.Add(format('%.2d', [i]));
      ComboBoxM.Items.Add(format('%.2d', [i]));
      ComboBoxY.Items.Add(format('%.2d', [i]));
      ComboBoxK.Items.Add(format('%.2d', [i]));
    end;
end;


end.
