unit UAutopartialapplyCalc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons, Menus;

type
  TFormCalcAutopart = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    ListViewruns: TListView;
    Panel1: TPanel;
    Label1: TLabel;
    EditNtotpages: TEdit;
    ListViewSections: TListView;
    Panel3: TPanel;
    Image3: TImage;
    Label8: TLabel;
    Label10: TLabel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel4: TPanel;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Edit1: TEdit;
    PopupMenuRuns: TPopupMenu;
    Add1: TMenuItem;
    Delete1: TMenuItem;
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure ListViewSectionsChanging(Sender: TObject; Item: TListItem;
      Change: TItemChange; var AllowChange: Boolean);
    procedure ListViewSectionsChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure Add1Click(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
  private
    { Private declarations }

    Aktproductionid : Longint;
    Inpressruns : String;
    CHbeforechange,ismanual : Boolean;
    procedure RecalcNpages;
  public
    Ntotpages : Longint;
    Procedure initialilze(Productionid : Longint);
    { Public declarations }
  end;

var
  FormCalcAutopart: TFormCalcAutopart;

implementation

{$R *.dfm}
Uses
  utypes,DateUtils,udata,umain, Usettings;

Procedure TFormCalcAutopart.initialilze(Productionid : Longint);
Var
  L : Tlistitem;
  asec : Longint;
Begin
  try
    ismanual := false;
    Aktproductionid := productionid;
    ListViewSections.items.clear;

    ListViewruns.items.clear;

    asec := -99;

    Ntotpages := 0;
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('Select distinct Sectionid,pressrunid,presssectionnumber from pagetable where productionid = ' +inttostr(productionid));
    DataM1.Query1.SQL.Add('order by presssectionnumber,Sectionid');

    DataM1.Query1.open;
    While not DataM1.Query1.eof do
    begin
      IF asec <> DataM1.Query1.fields[0].asinteger then
      begin
        asec := DataM1.Query1.fields[0].asinteger;
        L := ListViewSections.Items.Add;
        L.Caption := tnames1.sectionIDtoname(asec);
        L.Checked := true;
        DataM1.Query2.SQL.Clear;
        DataM1.Query2.SQL.Add('Select COUNT(distinct PageIndex) from pagetable where productionid = ' +inttostr(productionid));
        DataM1.Query2.SQL.Add('And sectionid = ' + inttostr(Asec));
        DataM1.Query2.open;
        If not DataM1.Query2.eof then
        Begin
          L.SubItems.Add(DataM1.Query2.fields[0].asstring);
          L.SubItems.Add('0');
          Ntotpages := Ntotpages + DataM1.Query2.fields[0].asinteger;
        end
        else
          L.SubItems.Add('0');
        DataM1.Query2.close;
      end;
      DataM1.Query1.next;
    end;
    DataM1.Query1.close;
    L := ListViewruns.items.add;
    L.Caption := inttostr(Ntotpages);

    L.SubItems.add('1');
    EditNtotpages.Text := inttostr(Ntotpages);
    ismanual := true;
  Except

  End;

end;


procedure TFormCalcAutopart.BitBtn3Click(Sender: TObject);
Var
  i,x : INteger;
  L : Tlistitem;
  cap : String;
  Nsubs : Longint;
  subs : Array of string;
  ischecked : Boolean;

begin
  IF ListViewSections.Selected <> nil then
  begin
    IF ListViewSections.Selected.Index > 0 then
    begin
      ismanual := false;
      x := ListViewSections.Selected.Index;
      setlength(subs,ListViewSections.items[x].subitems.Count+1);
      ListViewSections.items.BeginUpdate;

      cap := ListViewSections.items[x].Caption;
      Nsubs := ListViewSections.items[x].subitems.Count;
      For i := 0 to ListViewSections.items[x].subitems.Count-1 do
        subs[i] := ListViewSections.items[x].subitems[i];
      ischecked := ListViewSections.items[x].checked;


      ListViewSections.items[x].Delete;

      L := ListViewSections.items.Insert(x-1);
      L.caption := cap;
      l.Checked := Ischecked;
      For i := 0 to nsubs-1 do
        l.SubItems.add(subs[i]);

      ListViewSections.Selected := ListViewSections.items[x-1];
      ListViewSections.items.EndUpdate;

      setlength(subs,1);
      ismanual := true;
    End;
  end;
end;

procedure TFormCalcAutopart.BitBtn4Click(Sender: TObject);
Var
  ischecked : Boolean;
  i,x : INteger;
  L : Tlistitem;
  cap : String;
  Nsubs : Longint;
  subs : Array of string;

begin
  IF ListViewSections.Selected <> nil then
  begin
    IF ListViewSections.Selected.Index < ListViewSections.items.count-1 then
    begin
      ismanual := false;
      x := ListViewSections.Selected.Index;
      setlength(subs,ListViewSections.items[x].subitems.Count+1);
      ListViewSections.items.BeginUpdate;

      cap := ListViewSections.items[x].Caption;
      Nsubs := ListViewSections.items[x].subitems.Count;
      For i := 0 to ListViewSections.items[x].subitems.Count-1 do
        subs[i] := ListViewSections.items[x].subitems[i];

      ischecked := ListViewSections.items[x].checked;
      ListViewSections.items[x].Delete;


      L := ListViewSections.items.Insert(x+1);
      L.caption := cap;
      l.Checked := Ischecked;
      For i := 0 to nsubs-1 do
        l.SubItems.add(subs[i]);

      ListViewSections.Selected := ListViewSections.items[x];
      ListViewSections.items.EndUpdate;

      setlength(subs,1);
      ismanual := true;
    End;
  end;
end;

procedure TFormCalcAutopart.ListViewSectionsChanging(Sender: TObject;
  Item: TListItem; Change: TItemChange; var AllowChange: Boolean);
begin

  CHbeforechange := item.checked;
  AllowChange := true;
end;

procedure TFormCalcAutopart.ListViewSectionsChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
  IF FormCalcAutopart.Visible then
  begin
    IF CHbeforechange <> item.Checked then
      RecalcNpages;
  end;
end;

procedure TFormCalcAutopart.RecalcNpages;
Var
  L : Tlistitem;
  I : Longint;

Begin
  ListViewruns.items.clear;
  Ntotpages := 0;
  For i := 0 to ListViewSections.items.count-1 do
  begin
    if ListViewSections.items[i].Checked then
      Ntotpages := Ntotpages + strtoint(ListViewSections.items[i].SubItems[0]);
  end;
  L := ListViewruns.items.add;
  L.Caption := inttostr(Ntotpages);

  L.SubItems.add('1');
  EditNtotpages.Text := inttostr(Ntotpages);

End;


procedure TFormCalcAutopart.Add1Click(Sender: TObject);
Var
  L : Tlistitem;
begin
  L := ListViewruns.items.add;
  L.Caption := '0';
  L.SubItems.add(inttostr(ListViewruns.items.count));
end;

procedure TFormCalcAutopart.Delete1Click(Sender: TObject);
Var
  i : Longint;
begin
  IF ListViewruns.items.Count = 1 then
  begin
    RecalcNpages;
  end
  else
  begin
    IF ListViewruns.Selected <> nil then
    begin
      ListViewruns.Selected.Delete;
      For i := 0 to ListViewruns.items.Count-1 do
      begin
        ListViewruns.Items[I].SubItems[0] := Inttostr(I+1);
      end;
    End;
  End;
end;

end.
