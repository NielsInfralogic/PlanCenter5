unit UChangepress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFormChangepress = class(TForm)
    ListBox1: TListBox;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    LocationID : longint;
    aktpressID : longint;
    NewpressID : longint;
  end;

var
  FormChangepress: TFormChangepress;

implementation

uses Udata,umain;

{$R *.dfm}


procedure TFormChangepress.FormActivate(Sender: TObject);
begin
  ListBox1.Items.clear;
  datam1.Query1.SQL.Clear;
  datam1.Query1.SQL.Add('select pressname from PressNames');
  datam1.Query1.SQL.Add('where locationid = ' + inttostr(LocationID));
  datam1.Query1.SQL.Add('and pressid <> '+ inttostr(aktpressid));
  datam1.Query1.Open;
  While not datam1.Query1.Eof do
  begin
    ListBox1.Items.add(Datam1.Query1.Fields[0].AsString);
    datam1.Query1.Next;
  end;
  datam1.Query1.Close;

  BitBtn1.Enabled := ListBox1.Items.Count > 0;
  IF ListBox1.Items.Count > 0 then
    ListBox1.Itemindex := 0;
end;

procedure TFormChangepress.BitBtn1Click(Sender: TObject);
begin
  NewpressID := tnames1.pressnametoid(ListBox1.Items[ListBox1.Itemindex]);
end;

end.
