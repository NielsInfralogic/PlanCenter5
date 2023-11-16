unit UDebugsql;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, Buttons, FMTBcd, DB, SqlExpr;

type
  TFormdebugsql = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox1: TGroupBox;
    Memo1: TMemo;
    Splitter1: TSplitter;
    GroupBox2: TGroupBox;
    ListView1: TListView;
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Edit3: TEdit;
    Label2: TLabel;
    ListView2: TListView;
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Formdebugsql: TFormdebugsql;

implementation

{$R *.dfm}
Uses
  Udata;
procedure TFormdebugsql.BitBtn1Click(Sender: TObject);

var
  I,w: Integer;
  NewColumn: TListColumn;
  ListItem: TListItem;

begin
  try
    ListView1.items.clear;
    ListView1.Columns.clear;
    ListView1.Align := alNone;
    datam1.Query2.SQL.Clear;
    For i := 0 to Memo1.Lines.Count-1 do
    begin
      datam1.Query2.SQL.Add(Memo1.Lines[i]);
    end;
    datam1.Query2.open;
    IF not datam1.Query2.eof then
    begin
      For i := 0 to datam1.Query2.fields.Count-1 do
      begin
        NewColumn := ListView1.Columns.Add;
        NewColumn.Caption := datam1.Query2.fields[i].FieldName;

        NewColumn.AutoSize := true;
      end;
    end;
    ListView1.Items.BeginUpdate;
    while not datam1.Query2.eof do
    begin


      ListItem := ListView1.Items.Add;
      //ListItem.Caption := inttostr(datam1.Query2.fields[0].AsInteger and 256);
      ListItem.Caption := datam1.Query2.fields[0].AsString;
      For i := 1 to datam1.Query2.fields.Count-1 do
      begin
        ListItem.SubItems.Add(datam1.Query2.fields[i].AsString);
      End;
      datam1.Query2.next;
    End;
    datam1.Query2.close;
    ListView1.Items.EndUpdate;
    ListView1.Align := alClient;
    ListView1.Realign;
    W := Formdebugsql.Width;
    Formdebugsql.Width := w+10;
    ListView1.Realign;
    Formdebugsql.Width := w;
    ListView1.Realign;

  Except
  end;
end;
procedure TFormdebugsql.Button1Click(Sender: TObject);
Var
  H,X : Longint;
  l : Tlistitem;

begin
  ListView2.Items.clear;
  For  x := 1 to strtoint(edit1.Text) do
  begin
    l :=  ListView2.Items.add;
    l.Caption := inttostr(x);
    l.SubItems.Add('HKJHK');
  end;

  H := ListView2.items[1].position.y - ListView2.items[0].position.y;
  edit2.Text := Inttostr((ListView2.items[strtoint(edit1.Text)-1].position.y + h)+10);



(*  x := strtoint(edit1.text);
  x := x and strtoint(edit2.text);
  edit3.text := inttostr(x);
  *)
end;

end.
