unit UReNumberPlate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.Buttons;

type
  TFormReNumberPlate = class(TForm)
    Panel3: TPanel;
    Image2: TImage;
    Label7: TLabel;
    Label8: TLabel;
    Panel1: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Panel2: TPanel;
    ListView1: TListView;
    CheckBox1: TCheckBox;
    Panel4: TPanel;
    Button3: TButton;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure CheckBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    AFlat : Integer;
    { Public declarations }
  end;

var
  FormReNumberPlate: TFormReNumberPlate;

implementation

{$R *.dfm}

procedure TFormReNumberPlate.Button1Click(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TFormReNumberPlate.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TFormReNumberPlate.Button3Click(Sender: TObject);
Var
  i, x : Integer;
begin
  for i := 0 to ListView1.Items.Count - 2 do
    for x := i + 1 to ListView1.Items.Count - 1 do
      If ListView1.Items[i].Caption = ListView1.Items[x].Caption Then
        ShowMessage('Duplicates detected for plate name ' + ListView1.Items[i].Caption);
end;

procedure TFormReNumberPlate.CheckBox1Click(Sender: TObject);
begin
  Panel2.Visible := CheckBox1.Checked;

  if Panel2.Visible then
    FormReNumberPlate.Height := 420 else
    FormReNumberPlate.Height := 180;

end;

procedure TFormReNumberPlate.FormActivate(Sender: TObject);
begin
  CheckBox1Click(Sender);
end;

end.
