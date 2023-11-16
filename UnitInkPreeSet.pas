unit UnitInkPreeSet;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Dateutils,
  Vcl.Buttons;

type
  TFormInkPreeSet = class(TForm)
    Panel3: TPanel;
    Image2: TImage;
    Label7: TLabel;
    Label8: TLabel;
    Panel4: TPanel;
    ButtonAdd: TButton;
    ListView1: TListView;
    ComboBoxAllPub: TComboBox;
    Button4: TButton;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    DateTimePicker1: TDateTimePicker;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;

    procedure ButtonAddClick(Sender: TObject);
    procedure ListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormInkPreeSet: TFormInkPreeSet;

implementation

{$R *.dfm}

procedure TFormInkPreeSet.BitBtn1Click(Sender: TObject);
begin
        ModalResult := mrOK;
end;


procedure TFormInkPreeSet.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TFormInkPreeSet.Button4Click(Sender: TObject);
begin
  ListView1.DeleteSelected;
end;

procedure TFormInkPreeSet.ButtonAddClick(Sender: TObject);
Var
  LI : TListItem;
begin
  if ListView1.Selected = Nil then
  Begin
    LI := ListView1.Items.Add;
    LI.Caption :=  ComboBoxAllPub.Text;

    LI.SubItems.Add(formatdatetime('yyyymmdd', DateTimePicker1.Date));
    LI.SubItems.Add(Edit2.Text);
  End else
  Begin
    ListView1.Items[ListView1.Selected.Index].Caption := ComboBoxAllPub.Text;
    ListView1.Items[ListView1.Selected.Index].SubItems[0] := formatdatetime('yyyymmdd', DateTimePicker1.Date);
    ListView1.Items[ListView1.Selected.Index].SubItems[1] := Edit2.Text;
  End;
end;

procedure TFormInkPreeSet.ListView1SelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
Var
  d, m, y : Integer;
begin
  if Selected then
  Begin
    ComboBoxAllPub.Text := ListView1.Items[ListView1.Selected.Index].Caption;
    if Length(ListView1.Items[ListView1.Selected.Index].SubItems[0]) = 8 then
    Begin
      y := StrToInt(Copy(ListView1.Items[ListView1.Selected.Index].SubItems[0], 1, 4));
      m := StrToInt(Copy(ListView1.Items[ListView1.Selected.Index].SubItems[0], 5, 2));
      d := StrToInt(Copy(ListView1.Items[ListView1.Selected.Index].SubItems[0], 7, 2));
      DateTimePicker1.Date := EncodeDate(y, m, d);
    End Else
      DateTimePicker1.Date := Now;
    Edit2.Text := ListView1.Items[ListView1.Selected.Index].SubItems[1];
    ButtonAdd.Caption := 'Append';
  End else
    ButtonAdd.Caption := 'Add';
end;

end.
