unit Utoolchkdb;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls;

type
  TFormtoolchkdb = class(TForm)
    Panel3: TPanel;
    Image2: TImage;
    Label7: TLabel;
    Panel1: TPanel;
    BitBtn2: TBitBtn;
    Label8: TLabel;
    GroupBox1: TGroupBox;
    ListView1: TListView;
    Splitter1: TSplitter;
    GroupBox2: TGroupBox;
    Panel2: TPanel;
    BitBtnrefresh: TBitBtn;
    BitBtn1: TBitBtn;
    GroupBox3: TGroupBox;
    ListViewpageerrors: TListView;
    Splitter2: TSplitter;
    GroupBox4: TGroupBox;
    ListViewproderrors: TListView;
    BitBtn3: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtnrefreshClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure ListViewproderrorsDblClick(Sender: TObject);
  private
    procedure loadlist;
  public
    procedure setupcustomcheckup;
  end;

var
  Formtoolchkdb: TFormtoolchkdb;

implementation

uses Udata, Umain, Usettings;

{$R *.dfm}

procedure TFormtoolchkdb.FormActivate(Sender: TObject);
Begin

  loadlist;
end;

procedure TFormtoolchkdb.loadlist;
Var
  l : Tlistitem;
begin
  ListView1.Items.clear;
  ListViewpageerrors.items.clear;
  ListViewproderrors.Items.clear;
  try
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('Select distinct p1.pubdate,p1.publicationid,p2.publicationid,p2.name,l.name,pr.PressName,l.locationid,pr.pressid from pagetable p1, PublicationNames p2,LocationNames l,PressNames pr');
    DataM1.Query1.SQL.Add('where p1.publicationid = p2.publicationid');
    DataM1.Query1.SQL.Add('and p1.locationid = l.locationid');
    DataM1.Query1.SQL.Add('and p1.pressid = pr.Pressid');
    DataM1.Query1.SQL.Add('order by l.name,pr.pressname,p1.pubdate,p2.name');
    formmain.Tryopen(DataM1.Query1);
    While not DataM1.Query1.eof do
    begin
      l := ListView1.Items.Add;
      l.Caption := '';
      l.SubItems.Add(DataM1.Query1.fields[4].asstring);
      l.SubItems.Add(DataM1.Query1.fields[5].asstring);
      l.SubItems.Add(datetostr(DataM1.Query1.fields[0].asdatetime));
      l.SubItems.Add(DataM1.Query1.fields[3].asstring);
      l.SubItems.Add(DataM1.Query1.fields[6].asstring);
      l.SubItems.Add(DataM1.Query1.fields[7].asstring);
      l.SubItems.Add(DataM1.Query1.fields[1].asstring);
      l.ImageIndex := -1;
      DataM1.Query1.Next;
    end;
    DataM1.Query1.close;
  Except

  end;

end;

procedure TFormtoolchkdb.BitBtn1Click(Sender: TObject);
Var
  I : Longint;

  l : Tlistitem;
begin
  IF uppercase(Prefs.CustomCheckSystemName) = 'NICE' then
  begin
    try
    ListViewproderrors.Items.clear;
    ListViewpageerrors.items.clear;
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('select distinct p1.pubdate,l.name,e.name,p1.PublicationID,e.editionid');
    DataM1.Query1.SQL.Add('from PageTable p1, PublicationNames l, EditionNames e');
    DataM1.Query1.SQL.Add('where p1.pressid <> 1 and p1.UniquePage = 1 and l.PublicationID = p1.PublicationID and e.EditionID = p1.EditionID');
    DataM1.Query1.SQL.Add('and exists(select p2.pagename from PageTable p2');
    DataM1.Query1.SQL.Add('where p2.PlanPageName = p1.PlanPageName)');
    formmain.Tryopen(DataM1.Query1);
    While not DataM1.Query1.eof do
    begin
      l := ListViewproderrors.items.Add;
      l.Caption := 'Unique page on wrong press';
      l.SubItems.Add(datetostr(DataM1.Query1.fields[0].asdatetime));
      l.SubItems.Add(DataM1.Query1.fields[1].asstring);
      l.SubItems.Add(DataM1.Query1.fields[2].asstring);
      l.SubItems.Add(DataM1.Query1.fields[3].asstring);
      l.SubItems.Add(DataM1.Query1.fields[4].asstring);
      DataM1.Query1.next;
    end;
    DataM1.Query1.close;
    except
    end;




  end;

  (*
  For i := 0 to ListView1.Items.count-1 do
  begin
    IF ListView1.Items[i].selected then
    begin
      r := Formmain.Produktionchk(-1,-1,strtoint(ListView1.Items[i].subitems[6]),
                                  strtodate(ListView1.Items[i].subitems[2]),-1,-1,-1);
      IF R = 0 then
        ListView1.Items[i].imageindex := 259
      else
        ListView1.Items[i].imageindex := 258;
    End;
  End;
  *)
end;

procedure TFormtoolchkdb.BitBtnrefreshClick(Sender: TObject);
begin
  loadlist;
end;


procedure TFormtoolchkdb.setupcustomcheckup;
Begin
    IF uppercase(Prefs.CustomCheckSystemName) = 'NICE' then
    begin
      ListViewproderrors.Columns[0].Caption := 'Error';
      ListViewproderrors.Columns[0].Width := 200;

      ListViewproderrors.Columns[1].Caption := 'Date';
      ListViewproderrors.Columns[1].Width := 100;

      ListViewproderrors.Columns[2].Caption := 'Publication';
      ListViewproderrors.Columns[2].Width := 160;

      ListViewproderrors.Columns[3].Caption := 'Edition';
      ListViewproderrors.Columns[3].Width := 160;
      BitBtn1.Caption := 'chk Unique';
      BitBtn3.caption := 'fix Unique';

      formmain.Actiontoolchkdatabase.Visible := true;
    end;

end;

procedure TFormtoolchkdb.BitBtn3Click(Sender: TObject);
begin
  beep;
end;

procedure TFormtoolchkdb.ListViewproderrorsDblClick(Sender: TObject);
begin
    IF uppercase(Prefs.CustomCheckSystemName) = 'NICE' then
    begin
      IF ListViewproderrors.SelCount > 0 then
      begin


      end;
    End;
end;

end.
