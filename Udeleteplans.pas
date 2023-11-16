unit Udeleteplans;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFormdeletepressplan = class(TForm)
    ListBox1: TListBox;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ListBox2: TListBox;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Formdeletepressplan: TFormdeletepressplan;

implementation

uses Udata, Usettings;

{$R *.dfm}

procedure TFormdeletepressplan.FormActivate(Sender: TObject);
begin
  ListBox1.Items.clear;
  ListBox2.Items.clear;

  datam1.Query1.SQL.clear;
  datam1.Query1.SQL.add('Select PresstemplateID,Name from Presstemplatenames');
  datam1.Query1.SQL.add('order by name');
  datam1.Query1.Open;
  while not datam1.Query1.Eof do
  begin
    ListBox1.Items.Add(datam1.Query1.fields[1].AsString);
    ListBox2.Items.Add(datam1.Query1.fields[0].AsString);
    datam1.Query1.Next;
  End;
  datam1.Query1.Close;
end;

procedure TFormdeletepressplan.BitBtn1Click(Sender: TObject);
Var
  I : Integer;
begin
  for i := 0 to ListBox1.Items.count-1 do
  begin
    if ListBox1.Selected[i] then
    begin
      datam1.Query1.SQL.clear;
      datam1.Query1.SQL.add('delete Presstemplatenames');
      datam1.Query1.SQL.add('where PresstemplateID = ' + ListBox2.items[i]);
      datam1.Query1.ExecSQL(false);
      datam1.Query1.SQL.clear;
      datam1.Query1.SQL.add('delete Presstemplate');
      datam1.Query1.SQL.add('where PresstemplateID = ' + ListBox2.items[i]);
      datam1.Query1.ExecSQL(false);
    end;
  end;
end;

end.
