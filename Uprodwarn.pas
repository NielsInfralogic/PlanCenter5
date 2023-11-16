unit Uprodwarn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls;

type
  TFormprodwarn = class(TForm)
    ListViewwarnings: TListView;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    Splitter1: TSplitter;
    ListViewpages: TListView;
    procedure ListViewwarningsDblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Formprodwarn: TFormprodwarn;

implementation

uses Udata,utypes,umain, Usettings, UUtils;

{$R *.dfm}

procedure TFormprodwarn.ListViewwarningsDblClick(Sender: TObject);
Var
  i,akteditid,aktsecid : Longint;
  l : tlistitem;
begin
  try
    ListViewpages.Items.clear;
    ListViewpages.Items.beginupdate;
    akteditid := -1;
    aktsecid := -1;
    for i := 0 to ListViewwarnings.Items.Count-1 do
    begin
      if ListViewwarnings.Items[i].Selected then
      begin
        akteditid := tnames1.editionnametoid(ListViewwarnings.Items[i].caption);
        aktsecid := tnames1.sectionnametoid(ListViewwarnings.Items[i].SubItems[0]);
        break;
      end;
    end;
    if (akteditid <> -1) And (aktsecid <> -1) then
    begin
      datam1.Query2.SQL.Clear;                                                    //,productionid,publicationid,pubdate
      datam1.Query2.SQL.add('select distinct pagename,pageindex,UniquePage from pagetable (NOLOCK)');
      datam1.Query2.SQL.add('where publicationid = ' + inttostr(GSelpubid));
      datam1.Query2.SQL.add('and '+DataM1.makedatastr('',GSelpubdate));
      DataM1.Query2.SQL.add('And active = 1');
      DataM1.Query2.SQL.add('And pagetype <> 3 ');
      datam1.Query2.SQL.add('and editionid = ' + inttostr(akteditid ));
      datam1.Query2.SQL.add('and Sectionid = ' + inttostr(aktsecid ));
      datam1.Query2.SQL.add('and ( (status IN '+statuswarningstr+')  ');
      datam1.Query2.SQL.add('or (ExternalStatus IN '+extstatuswarningstr+') ');
      if (Prefs.WarnIfAnyDisapproved) then
        datam1.Query2.SQL.add('or ( Approved = 2) ');
      datam1.Query2.SQL.add(' ) ');

      datam1.Query2.SQL.add('order by pageindex');

      IF Prefs.debug then datam1.Query2.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'prodGetwarnpagelist.sql');
      datam1.Query2.open;

      While not datam1.Query2.eof do
      begin
        l := ListViewpages.Items.add;
        l.Caption := datam1.Query2.fields[0].asstring;
        l.SubItems.Add(Inttostr(datam1.Query2.fields[2].asinteger));
        datam1.Query2.next;
      end;
      datam1.Query2.close;
    End;
    ListViewpages.Items.endupdate;
  except
  end
end;

procedure TFormprodwarn.FormActivate(Sender: TObject);
Var
  l : tlistitem;
begin
  try
    ListViewwarnings.Items.clear;
    ListViewpages.Items.clear;
    ListViewwarnings.Items.BeginUpdate;

    DataM1.Query2.SQL.Clear;
    DataM1.Query2.SQL.add('update pagetable');

    datam1.Query2.SQL.Clear;                                                    //,productionid,publicationid,pubdate
    datam1.Query2.SQL.add('select distinct editionid,sectionid from pagetable (NOLOCK)');
    datam1.Query2.SQL.add('where publicationid = ' + inttostr(GSelpubid));
    datam1.Query2.SQL.add('and '+DataM1.makedatastr('',GSelpubdate));

    datam1.Query2.SQL.add('and ( (status IN '+statuswarningstr+')  ');
    datam1.Query2.SQL.add('or (ExternalStatus IN '+extstatuswarningstr+') ');

    if (Prefs.WarnIfAnyDisapproved) then
      datam1.Query2.SQL.add('or ( Approved = 2) ');

    datam1.Query2.SQL.add(' ) ');
    datam1.Query2.SQL.add('order by editionid,sectionid');

    IF Prefs.debug then datam1.Query2.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'prodGetwarnlist.sql');
    datam1.Query2.open;

    While not datam1.Query2.eof do
    begin
      l := ListViewwarnings.Items.add;
      l.Caption := tnames1.editionIDtoname(datam1.Query2.fields[0].asinteger);
      l.SubItems.Add(tnames1.sectionIDtoname(datam1.Query2.fields[1].asinteger));
      datam1.Query2.next;
    end;
    datam1.Query2.close;

    ListViewwarnings.Items.EndUpdate;
  Except
  end;





end;

end.
