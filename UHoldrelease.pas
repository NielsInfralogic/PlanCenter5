unit UHoldrelease;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls, UImages;

type
  TFormHoldrelesepubl = class(TForm)
    Panel3: TPanel;
    Image2: TImage;
    Label7: TLabel;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ListView1: TListView;
    BitBtn3: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure loadlist;
  end;

var
  FormHoldrelesepubl: TFormHoldrelesepubl;

implementation

uses Usettings, Udata, Umain, Ulogin;
Var
  publlist : array[0..1000] of record
                                 publid : Longint;
                                 pubdate : tdatetime;
                               end;

{$R *.dfm}

procedure TFormHoldrelesepubl.FormActivate(Sender: TObject);
begin
  loadlist;
end;
procedure TFormHoldrelesepubl.loadlist;

Var
  l : tlistitem;
Begin
  try
    ListView1.Items.clear;
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('Select distinct p1.pubdate,p1.publicationid,p2.publicationid,p2.name from pagetable p1, PublicationNames p2');
    DataM1.Query1.SQL.Add('where p1.publicationid = p2.publicationid');
    DataM1.Query1.SQL.Add('order by p1.pubdate,p2.name');
    formmain.Tryopen(DataM1.Query1);
    While not DataM1.Query1.eof do
    begin
      l := ListView1.Items.Add;
      l.Caption := '';
      DataM1.Query2.SQL.Clear;
      DataM1.Query2.SQL.Add('Select top 1 Hold from pagetable');
      DataM1.Query2.SQL.Add('where hold = 1 and active = 1 and publicationid = ' + inttostr(DataM1.Query1.fields[1].asinteger));
      DataM1.Query2.SQL.add(' and '+  DataM1.makedatastr('',DataM1.Query1.fields[0].asdatetime));
      DataM1.Query2.open;
      IF Not DataM1.Query2.eof then
        l.ImageIndex := 90
      else
        l.ImageIndex := 91;
      DataM1.Query2.close;

      l.SubItems.Add(datetostr(DataM1.Query1.fields[0].asdatetime));
      l.SubItems.Add(DataM1.Query1.fields[3].asstring);
      publlist[ListView1.Items.count-1].publid := DataM1.Query1.fields[1].asinteger;
      publlist[ListView1.Items.count-1].pubdate := DataM1.Query1.fields[0].asdatetime;
      DataM1.Query1.Next;
    end;
    DataM1.Query1.close;

    if ListView1.Items.count > 0 then
    Begin
      ListView1.Selected := ListView1.Items[0];
      ListView1.SetFocus;
    end;

    BitBtn1.Enabled := ListView1.Selected <> nil;
  Except
  end;

end;


procedure TFormHoldrelesepubl.BitBtn1Click(Sender: TObject);
Var
  publid : Longint;
  pubdate : tdatetime;

  I : Longint;
begin
  For i := 0 to ListView1.Items.count-1 do
  begin
    IF ListView1.Items[i].Selected then
    begin
      publid  := publlist[ListView1.Items[i].Index].publid;
      pubdate := publlist[ListView1.Items[i].Index].pubdate;
      DataM1.Query1.SQL.Clear;
      DataM1.Query1.SQL.add('update pagetable set hold = 0');          // OK
      if (Prefs.SetApproveTimeOnRelease) then
        DataM1.Query1.SQL.add(', approvetime = getdate(),approveuser='+''''+Prefs.username+'''');
      DataM1.Query1.SQL.add('where pagetable.publicationid = '+inttostr(publid));
      DataM1.Query1.SQL.add('and '+  DataM1.makedatastr('pagetable.',pubdate));
      formmain.trysql(DataM1.Query1);

    End;
  End;
  loadlist;
end;

procedure TFormHoldrelesepubl.BitBtn3Click(Sender: TObject);
Var
  publid : Longint;
  pubdate : tdatetime;

  I : Longint;
begin
  For i := 0 to ListView1.Items.count-1 do
  begin
    IF ListView1.Items[i].Selected then
    begin
      publid  := publlist[ListView1.Items[i].Index].publid;
      pubdate := publlist[ListView1.Items[i].Index].pubdate;

      DataM1.Query1.SQL.Clear;
      DataM1.Query1.SQL.add('update pagetable set hold = 1');
      DataM1.Query1.SQL.add('where pagetable.publicationid = '+inttostr(publid));
      DataM1.Query1.SQL.add('and '+  DataM1.makedatastr('pagetable.',pubdate));
      formmain.trysql(DataM1.Query1);

    End;
  End;
  loadlist;
end;


end.
