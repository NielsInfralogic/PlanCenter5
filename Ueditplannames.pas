unit Ueditplannames;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFormEditplannames = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    ComboBox1: TComboBox;
    BitBtn1: TBitBtn;
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    BitBtn2: TBitBtn;
    ListBox1: TListBox;
    procedure FormActivate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormEditplannames: TFormEditplannames;

implementation

uses Udata, Umain;

{$R *.dfm}

procedure TFormEditplannames.FormActivate(Sender: TObject);
begin
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('Select distinct name,presssystem from presstemplatenames');
  DataM1.Query1.SQL.Add('order by name');
  DataM1.Query1.open;
  ComboBox1.Items.clear;
  ListBox1.Items.clear;
  while not DataM1.Query1.Eof do
  begin
    ComboBox1.Items.add(DataM1.Query1.fields[0].AsString);
    ListBox1.Items.add(DataM1.Query1.fields[1].AsString);
    DataM1.Query1.next;
  end;
  DataM1.Query1.close;
  ComboBox1.Itemindex := 0;
end;

procedure TFormEditplannames.ComboBox1Change(Sender: TObject);
begin
  Edit1.Text := ComboBox1.Text;
  IF (ComboBox1.Itemindex > -1) and  (ComboBox1.Itemindex < listbox1.Items.Count) then
    edit2.Text := listbox1.Items[ComboBox1.Itemindex];
end;

procedure TFormEditplannames.BitBtn2Click(Sender: TObject);

begin
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('update presstemplatenames');
  DataM1.Query1.SQL.Add('set name = '+''''+edit1.Text+''''+',');
  DataM1.Query1.SQL.Add('presssystem = '+''''+edit2.Text+'''');
  DataM1.Query1.SQL.Add('Where name = '+''''+combobox1.Text+'''');
  //formmain.trysql(DataM1.Query1);

  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('Select distinct name,presssystem from presstemplatenames');
  DataM1.Query1.SQL.Add('order by name');
  DataM1.Query1.open;

  ComboBox1.Items.clear;
  ListBox1.Items.clear;
  while not DataM1.Query1.Eof do
  begin
    ComboBox1.Items.add(DataM1.Query1.fields[0].AsString);
    ListBox1.Items.add(DataM1.Query1.fields[1].AsString);
    DataM1.Query1.next;
  end;
  DataM1.Query1.close;
  ComboBox1.Itemindex := 0;


end;

end.
