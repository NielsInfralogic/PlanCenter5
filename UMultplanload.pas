unit UMultplanload;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, PBExListview, StdCtrls, ExtCtrls;

type
  TFormMultiplanload = class(TForm)
    Panel3: TPanel;
    Image2: TImage;
    Label7: TLabel;
    Label8: TLabel;
    GroupBox1: TGroupBox;
    ComboBox1: TComboBox;
    GroupBox2: TGroupBox;
    PBExListviewPlan: TPBExListview;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure FormActivate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    SelectedplanTemplateid : Integer;
  end;

var
  FormMultiplanload: TFormMultiplanload;

implementation

uses Udata;

{$R *.dfm}

procedure TFormMultiplanload.FormActivate(Sender: TObject);
Var
  Pressid : Longint;
begin
  ComboBox1.Items.clear;
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.add('Select distinct Name from presstemplatenames');
  DataM1.Query1.SQL.add('Order by name');
  DataM1.Query1.open;
  While not DataM1.Query1.eof do
  begin
    ComboBox1.Items.add(DataM1.Query1.fields[0].asstring);
  end;
  DataM1.Query1.close;
  ComboBox1.Itemindex := 0;


end;

procedure TFormMultiplanload.ComboBox1Change(Sender: TObject);

begin
  SelectedplanTemplateid := -1;
  IF ComboBox1.Itemindex > -1 then
  begin
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.add('Select PresstemplateID from presstemplatenames');
    DataM1.Query1.SQL.add('Where name = ' + ComboBox1.Items[ComboBox1.Itemindex]);
    DataM1.Query1.open;

    IF not DataM1.Query1.eof then
    begin
      SelectedplanTemplateid := DataM1.Query1.fields[0].asinteger;
      DataM1.Query1.next;
    end;
    DataM1.Query1.close;
  End;
  IF SelectedplanTemplateid = -1 then exit;
  DataM1.Query1.SQL.Clear;

  DataM1.Query1.SQL.add('Select distinct pr.pressid,pn.pressid,pn.PressName,pn.locationid,l.locationid,l.name from presstemplate pr, pressnames pn,locationnames l');
  DataM1.Query1.SQL.add('Where pr.PresstemplateID = ' + inttostr(SelectedplanTemplateid));
  DataM1.Query1.SQL.add('and pr.pressid=pn.pressid');
  DataM1.Query1.SQL.add('and pn.locationid=l.locationid');
  DataM1.Query1.SQL.add('order by l.name,pn.PressName');
  IF not DataM1.Query1.eof then
  Begin

  End;
  DataM1.Query1.close;
end;

end.
