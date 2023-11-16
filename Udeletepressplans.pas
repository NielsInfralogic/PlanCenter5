unit Udeletepressplans;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, PBExListview, ExtCtrls;

type
  TFormdelplan = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Splitter1: TSplitter;
    ListBoxpresstemplatename: TListBox;
    PBExListview1: TPBExListview;
    GroupBox2: TGroupBox;
    ComboBoxpress: TComboBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure ComboBoxpressChange(Sender: TObject);
    procedure ListBoxpresstemplatenameClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    Procedure loadplanlist;
    Procedure setlistdata;
  public
    { Public declarations }
  end;

var
  Formdelplan: TFormdelplan;

implementation

Uses
  Umain, Udata;
{$R *.dfm}
Procedure TFormdelplan.loadplanlist;

Begin
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('Select distinct p1.name,p1.presstemplateid,p2.presstemplateid,p2.pressid from presstemplatenames p1, presstemplate p2');
  DataM1.Query1.SQL.Add('where p1.presstemplateid = p2.presstemplateid');
  DataM1.Query1.SQL.Add('and p2.pressid = '+inttostr(tnames1.pressnametoid(ComboBoxpress.Text)));
  DataM1.Query1.SQL.Add('order by p1.name');
  DataM1.Query1.open;
  ListBoxpresstemplatename.Items.clear;
  while not DataM1.Query1.Eof do
  begin
    ListBoxpresstemplatename.Items.add(DataM1.Query1.fields[0].AsString);
    ListBoxpresstemplatename.Itemindex := 0;
    DataM1.Query1.next;
  end;
  DataM1.Query1.close;

  IF ListBoxpresstemplatename.Items.Count > 0 then
  begin
    ListBoxpresstemplatename.Itemindex := 0;
    setlistdata;
  end;

End;

Procedure TFormdelplan.setlistdata;
Var
  l : tlistitem;
begin
  try
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.add('Select distinct p2.name,p1.presstemplateid,p1.publicationid,p1.editionid,p1.sectionid, count(distinct p1.pagename) as antal from presstemplate p1, presstemplatenames p2');
    DataM1.Query1.SQL.add('where p1.presstemplateid = p2.presstemplateid');
    DataM1.Query1.SQL.add('and p2.name = ' +''''+ListBoxpresstemplatename.Items[ListBoxpresstemplatename.itemindex] +'''');
    DataM1.Query1.SQL.add('GROUP BY p2.name,p1.presstemplateid,p1.publicationid,p1.editionid,p1.sectionid');
    DataM1.Query1.open;
    PBExListview1.Items.clear;
    While not DataM1.Query1.eof do
    begin
      l := PBExListview1.Items.add;
      l.Caption := tnames1.publicationIDtoname(DataM1.Query1.fields[2].asinteger);
      l.SubItems.Add(tnames1.editionIDtoname(DataM1.Query1.fields[3].asinteger));
      l.SubItems.Add(tnames1.sectionIDtoname(DataM1.Query1.fields[4].asinteger));
      l.SubItems.Add(DataM1.Query1.fields[5].asstring);
      DataM1.Query1.next;
    end;
    DataM1.Query1.close;
  except
  end;

end;

procedure TFormdelplan.FormActivate(Sender: TObject);
begin
  ComboBoxpress.Items := tnames1.pressnames;
  ComboBoxpress.Itemindex := 0;
  loadplanlist;
end;

procedure TFormdelplan.ComboBoxpressChange(Sender: TObject);
begin
  loadplanlist;
end;

procedure TFormdelplan.ListBoxpresstemplatenameClick(Sender: TObject);
begin
  setlistdata;
end;

procedure TFormdelplan.BitBtn1Click(Sender: TObject);
Var
  I,it : Longint;
begin
  For it := 0 to ListBoxpresstemplatename.Items.count-1 do
  begin
    IF ListBoxpresstemplatename.Selected[it] then
    begin
      DataM1.Query1.SQL.Clear;
      DataM1.Query1.SQL.Add('select p1.presstemplateid from presstemplate p1, presstemplatenames p2');
      DataM1.Query1.SQL.add('where p1.presstemplateid = p2.presstemplateid');
      DataM1.Query1.SQL.add('and p2.name = '+''''+ListBoxpresstemplatename.Items[it]+'''' );
      formmain.Tryopen(DataM1.Query1);
      I := -1;
      if not DataM1.Query1.eof then
        I := DataM1.Query1.fields[0].AsInteger;
      DataM1.Query1.close;

      IF I <> -1 then
      begin
        DataM1.Query1.SQL.Clear;
        DataM1.Query1.SQL.add('delete presstemplate');
        DataM1.Query1.SQL.add('where presstemplateid = '+inttostr(i) );
        Formmain.trysql(DataM1.Query1);

        DataM1.Query1.SQL.Clear;
        DataM1.Query1.SQL.add('delete presstemplatenames');
        DataM1.Query1.SQL.add('where presstemplateid = '+inttostr(i) );
        Formmain.trysql(DataM1.Query1);


      end;

    End;
  end;
  loadplanlist;

end;

end.
