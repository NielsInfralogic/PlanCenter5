unit Ucustomtools;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls, Menus;

type
  TFormcustomtools = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    SaveDialog1: TSaveDialog;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    GroupBoxtree: TGroupBox;
    GroupBoxpageslocation: TGroupBox;
    ComboBoxpalocation: TComboBox;
    TreeViewThumbs: TTreeView;
    Panel2: TPanel;
    BitBtn3: TBitBtn;
    DateTimePickerthumb: TDateTimePicker;
    Button1: TButton;
    GroupBox3: TGroupBox;
    Button2: TButton;
    GroupBox4: TGroupBox;
    ListBox1: TListBox;
    GroupBox2: TGroupBox;
    Button3: TButton;
    GroupBox5: TGroupBox;
    ListBox2: TListBox;
    Buttonplateid: TButton;
    ListView1: TListView;
    Panel3: TPanel;
    BitBtn2: TBitBtn;
    Panel4: TPanel;
    ComboBoxpubl: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    ComboBoxproofs: TComboBox;
    Button4: TButton;
    procedure BitBtn3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ButtonplateidClick(Sender: TObject);
    procedure TreeViewThumbsChange(Sender: TObject; Node: TTreeNode);
    procedure ComboBoxpublChange(Sender: TObject);
    procedure ComboBoxproofsChange(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
    Procedure refreshtree;
  public
    { Public declarations }
  end;

var
  Formcustomtools: TFormcustomtools;

implementation

uses Udata, Umain, Utypes, UUtils;

{$R *.dfm}

Procedure TFormcustomtools.refreshtree;
Var
  n,locationnode,productionnode,datenode,publicationnode,issuenode,editionnode,sectionnode : ttreenode;
  locationid,publicationid,issueid,editionid,sectionid : Longint;
  aktpubdate : tdatetime;
  curlev,locationcur,productioncur,publicationcur,issuecur,editioncur,sectioncur : Longint;

  pagedata : Psmallpagedata;
  found : boolean;
  hfound : Longint;
  fnode : ttreenode;
  orderstr,selectstr : string;

  levelkinds : Array[0..7] of integer;//0=all,1=pubdate,2=publication,3=issue,4=edition,5=section
  i,Nlevels,starti    : Integer;
  curnodes : Array[0..7] of ttreenode;
  trdat : PTTreeViewpagestype;

  aktselected : ttreenode;
  Naktseltext : Integer;
  aktseltext : array[0..4] of string;

begin
  try
  starti := 1;
    TreeViewThumbs.Visible := false;
    orderstr := 'order by ';
    selectstr := 'Select distinct ';

    levelkinds[0] := 0;

    Nlevels := 1;

    Inc(Nlevels);
    levelkinds[Nlevels-1] := 1;
    selectstr := selectstr + 'pubdate,';
    orderstr := orderstr + 'pubdate,';

    Inc(Nlevels);
    levelkinds[Nlevels-1] := 2;
    selectstr := selectstr + 'publicationid,';
    orderstr := orderstr + 'publicationid,';


    IF tnames1.editionnames.count > 1 then
    Begin
      Inc(Nlevels);
      levelkinds[Nlevels-1] := 4;
      selectstr := selectstr + 'editionid,';
      orderstr := orderstr + 'editionid,';
    end;

    IF tnames1.sectionnames.count > 1 then
    Begin
      Inc(Nlevels);
      levelkinds[Nlevels-1] := 5;
      selectstr := selectstr + 'sectionid,';
      orderstr := orderstr + 'sectionid,';
    end;

    orderstr[length(orderstr)] := ' ';
    selectstr[length(selectstr)] := ' ';
    selectstr := selectstr + ' from pagetable';

    TreeViewThumbs.Items.Clear;
    aktpubdate := now;

    locationid := -99;
    publicationid := -99;
    issueid := -99;
    editionid := -99;
    sectionid  := -99;

    New(trdat);
    TTreeViewpagestype(trdat^).publicationid := -1;
    TTreeViewpagestype(trdat^).issueid := -1;
    TTreeViewpagestype(trdat^).editionid := -1;
    TTreeViewpagestype(trdat^).sectionid := -1;
    TTreeViewpagestype(trdat^).pubdate := 0;
    TTreeViewpagestype(trdat^).Kind := 0;


    curnodes[0] := TreeViewThumbs.Items.addchildobject(nil,'All',trdat);
    curnodes[0].ImageIndex := 64;
    curnodes[0].SelectedIndex := 64;
    curnodes[0].StateIndex := -1;

    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.add(selectstr);
    datam1.Query1.SQL.Add('Where issueid <> -99 ');
    datam1.Query1.SQL.Add(WeditionStr);

    IF (ComboBoxpalocation.ItemIndex > 0) AND (ComboBoxpalocation.Text <> 'All') then
    begin
      datam1.Query1.SQL.Add('and locationid = ' + inttostr(tnames1.locationnametoid(ComboBoxpalocation.items[ComboBoxpalocation.ItemIndex])));
    end;

    IF DateTimePickerthumb.checked then
    begin
      DataM1.Query1.SQL.add(' and '+  DataM1.makedatastr('',DateTimePickerthumb.Date));
    end;
    DataM1.Query1.SQL.add(orderstr);
    IF Prefs.debug then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'pagetree.sql');
    formmain.tryopen(datam1.Query1);
    While not DataM1.Query1.eof do
    begin
      For i := 1 to Nlevels-1 do
      begin
        Case levelkinds[i] of
          1 : begin
                IF (aktpubdate <> DataM1.Query1.fieldbyname('pubdate').asdatetime) then
                begin
                  starti := i;
                  break;
                end;
              end;
          2 : begin
                IF (publicationid <> DataM1.Query1.fieldbyname('publicationid').asinteger) then
                begin
                  starti := i;
                  break;
                end;
              end;
          3 : begin
                IF issueid <> DataM1.Query1.fieldbyname('issueid').asinteger then
                begin
                  starti := i;
                  break;
                end;
              end;
          4 : begin
                if (Prefs.Proversion < 1) then
                begin
                  IF editionid <> DataM1.Query1.fieldbyname('editionid').asinteger then
                  begin
                    starti := i;
                    break;
                  end;
                End;
              end;
          5 : begin
                IF sectionid <> DataM1.Query1.fieldbyname('sectionid').asinteger then
                begin
                  starti := i;
                  break;
                end;
              end;
        end;
      end;

      For i := starti to Nlevels-1 do
      begin
        New(trdat);
        TTreeViewpagestype(trdat^).publicationid := -1;
        TTreeViewpagestype(trdat^).issueid := -1;
        TTreeViewpagestype(trdat^).editionid := -1;
        TTreeViewpagestype(trdat^).sectionid := -1;
        TTreeViewpagestype(trdat^).pubdate := 0;
        TTreeViewpagestype(trdat^).Kind := levelkinds[i];

        Case levelkinds[i] of
          1 : begin
                aktpubdate := DataM1.Query1.fieldbyname('pubdate').asdatetime;
                curnodes[i] := TreeViewThumbs.Items.addchildobject(curnodes[i-1],datetostr(aktpubdate),trdat);
                curnodes[i].ImageIndex := 40;
                curnodes[i].selectedindex := 40;
                TTreeViewpagestype(curnodes[i].data^) := TTreeViewpagestype(curnodes[i-1].data^);
                TTreeViewpagestype(curnodes[i].data^).pubdate := aktpubdate;
                TTreeViewpagestype(curnodes[i].data^).Kind := levelkinds[i];
              end;
          2 : begin
                publicationid := DataM1.Query1.fieldbyname('publicationid').asinteger;
                curnodes[i] :=  TreeViewThumbs.Items.addchildobject(curnodes[i-1],tnames1.publicationIDtoname(publicationid),trdat);
                curnodes[i].ImageIndex := 16;
                curnodes[i].selectedindex := 16;
                TTreeViewpagestype(curnodes[i].data^) := TTreeViewpagestype(curnodes[i-1].data^);
                TTreeViewpagestype(curnodes[i].data^).publicationid := publicationid;
                TTreeViewpagestype(curnodes[i].data^).Kind := levelkinds[i];
              end;
          3 : begin
                issueid := DataM1.Query1.fieldbyname('issueid').asinteger;
                curnodes[i] :=  TreeViewThumbs.Items.addchildobject(curnodes[i-1],tnames1.issueIDtoname(issueid),trdat);
                curnodes[i].ImageIndex := 23;
                curnodes[i].selectedindex := 23;
                TTreeViewpagestype(curnodes[i].data^) := TTreeViewpagestype(curnodes[i-1].data^);
                TTreeViewpagestype(curnodes[i].data^).issueid := issueid;
                TTreeViewpagestype(curnodes[i].data^).Kind := levelkinds[i];
              end;
          4 : begin
                editionid := DataM1.Query1.fieldbyname('editionid').asinteger;
                curnodes[i] :=  TreeViewThumbs.Items.addchildobject(curnodes[i-1],tnames1.editionIDtoname(editionid),trdat);
                curnodes[i].ImageIndex := 11;
                curnodes[i].selectedindex := 11;
                TTreeViewpagestype(curnodes[i].data^) := TTreeViewpagestype(curnodes[i-1].data^);
                TTreeViewpagestype(curnodes[i].data^).editionid := editionid;
                TTreeViewpagestype(curnodes[i].data^).Kind := levelkinds[i];
              end;
          5 : begin
                sectionid := DataM1.Query1.fieldbyname('sectionid').asinteger;
                curnodes[i] :=  TreeViewThumbs.Items.addchildobject(curnodes[i-1],tnames1.sectionIDtoname(sectionid),trdat);
                curnodes[i].ImageIndex := 0;
                curnodes[i].selectedindex := 0;
                TTreeViewpagestype(curnodes[i].data^) := TTreeViewpagestype(curnodes[i-1].data^);
                TTreeViewpagestype(curnodes[i].data^).sectionid := sectionid;
                TTreeViewpagestype(curnodes[i].data^).Kind := levelkinds[i];
              end;
        end;
      End;

      publicationid := DataM1.Query1.fieldbyname('publicationid').asinteger;
      aktpubdate := DataM1.Query1.fieldbyname('pubdate').asdatetime;
      ReplaceTime(aktpubdate, EncodeTime(0, 0, 0,0));


      IF tnames1.issuenames.count > 1 then
      Begin
        issueid := DataM1.Query1.fieldbyname('issueid').asinteger;
      end;

      IF tnames1.editionnames.count > 1 then
      Begin
        editionid := DataM1.Query1.fieldbyname('editionid').asinteger;
      end;

      IF tnames1.sectionnames.count > 1 then
      Begin
        sectionid := DataM1.Query1.fieldbyname('sectionid').asinteger;
      end;

      DataM1.Query1.next;
    end;
    DataM1.Query1.close;

    (*
    datenode := TreeViewThumbs.Items.GetFirstNode;
    datenode.Expand(false);
    *)

    for i := 0 to TreeViewThumbs.Items.count-1 do
    begin
      if TreeViewThumbs.Items[i].Level < 2 then
        TreeViewThumbs.Items[i].expand(false);
    end;

  Finally

    TreeViewThumbs.Visible := true;

  end;
end;


procedure TFormcustomtools.BitBtn3Click(Sender: TObject);
begin
  refreshtree;
end;

procedure TFormcustomtools.FormActivate(Sender: TObject);
Var
  custommer,i : Integer;
  l : Tlistitem;
begin
  custommer := 0;
  Buttonplateid.Enabled := false;
  ComboBoxpalocation.align := alclient;
  ComboBoxpalocation.Items := formmain.ComboBoxpalocationNY.Items;
  ComboBoxpalocation.Itemindex := 0;

  PageControl1.Pages[0].TabVisible := false;
  PageControl1.Pages[1].TabVisible := false;
  PageControl1.Pages[2].TabVisible := false;


  GroupBoxtree.visible := false;
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.add('Select Distinct publicationid from PublicationNames');
  DataM1.Query1.open;
  While not DataM1.Query1.eof  do
  begin
    IF tnames1.publicationIDtoname(DataM1.Query1.fields[0].asinteger) = 'Nice-Matin' then
    Begin
      custommer := 1;
      Break;
    end;
    DataM1.Query1.next;
  end;
  DataM1.Query1.close;


  if custommer = 0 then
  begin
    for i := 0 to tnames1.locationnames.Count -1 do
    begin
      if uppercase(tnames1.locationnames[i]) = 'BERLIN' then
      begin
        custommer := 2;
        break;
      end;

    end;
  End;
  ComboBoxpubl.Items.Clear;

  Case custommer of
    0 : Begin
          MessageDlg(formmain.InfraLanguage1.Translate('There are no custom tools'), mtInformation,[mbOk], 0);
          close;
        end;
    1 : Begin
          refreshtree;
          PageControl1.Pages[0].TabVisible := true;
          GroupBoxtree.visible := true;
        end;
    2 : begin
          ComboBoxpubl.Items.clear;
          ListView1.Items.Clear;
          DataM1.Query1.SQL.Clear;
          DataM1.Query1.SQL.add('Select Distinct TemplateName,templateid from TemplateConfigurations order by TemplateName');
          DataM1.Query1.open;
          While not DataM1.Query1.eof  do
          begin
            l := ListView1.Items.Add;
            l.Caption := DataM1.Query1.fields[0].asstring;
            l.SubItems.Add('');
            l.SubItems.Add(DataM1.Query1.fields[1].asstring);
            l.Checked := false;
            DataM1.Query1.next;
          end;
          DataM1.Query1.close;


          ComboBoxproofs.Items.clear;
          for i := 0 to tnames1.proofnames.Count -1 do
            ComboBoxproofs.Items.add(tnames1.proofnames[i]);
          ComboBoxproofs.ItemIndex := 0;

          ComboBoxpubl.Items.clear;
          for i := 0 to tnames1.publicationnames.Count -1 do
            ComboBoxpubl.Items.add(tnames1.publicationnames[i]);
          ComboBoxpubl.ItemIndex := 0;
          PageControl1.Pages[1].TabVisible := true;
        end;

  end;

end;

procedure TFormcustomtools.Button1Click(Sender: TObject);
Var
  stackcount : Longint;
  Stackposnames : Array[1..16] of string;
  aktcopynumber,aktflatseparation : longint;
  wherestr : string;
  runnode : ttreenode;
  pressid : longint;
  locationid,pressrunid : Longint;
  i2 : Longint;
  n : ttreenode;
begin
  try
    screen.Cursor := crhourglass;
    IF TreeViewThumbs.Selected = nil then exit;
    n := TreeViewThumbs.Selected;
    wherestr := 'Where active <> -999';
    While n.Level > 0 do
    begin
      Case TTreeViewpagestype(n.data^).Kind of //0=all,1=location,2=publication,pubdate,3=issue,4=edition,5=section
        1 : wherestr := wherestr + ' and '+  DataM1.makedatastr('',TTreeViewpagestype(n.data^).pubdate);
        2 : Begin
              wherestr := wherestr + ' and publicationid = ' + inttostr(TTreeViewpagestype(n.data^).publicationid);
            end;
        3 : Begin
              wherestr := wherestr + ' and issueid = ' + inttostr(TTreeViewpagestype(n.data^).issueid);
            end;
        4 : begin
              wherestr := wherestr + ' and editionid = ' + inttostr(TTreeViewpagestype(n.data^).editionid);
            end;
        5 : begin
              wherestr := wherestr + ' and sectionid = ' + inttostr(TTreeViewpagestype(n.data^).sectionid);
            end;
      end;
      n := n.Parent;
    end;


    try

      aktcopynumber     := -1;
      aktflatseparation := -1;
      stackcount := 1;

      Stackposnames[1] := '1';
      Stackposnames[2] := '2';
      Stackposnames[3] := '3';
      Stackposnames[4] := '4';

      DataM1.Query1.SQL.Clear;
      DataM1.Query1.SQL.add('Select Distinct editionid,flatseparationset,copynumber,((copynumber+1) /2),copyflatseparationset from pagetable');
      DataM1.Query1.sql.add(wherestr);
      DataM1.Query1.sql.add('and active = 1');
      DataM1.Query1.SQL.add('order by editionid,flatseparationset,copynumber');
      DataM1.Query1.open;
      i2 := 0;
      While not DataM1.Query1.eof do
      begin
        IF (aktflatseparation <> DataM1.Query1.fields[1].asinteger)  then
        begin
          aktflatseparation := DataM1.Query1.fields[1].asinteger;
          aktcopynumber := DataM1.Query1.fields[2].asinteger;

          Inc(i2);
          if i2 = 2 then
          begin
            Inc(stackcount);
            IF stackcount > 4 then
              stackcount := 1;
            i2 := 0;
          End;

          DataM1.Query2.sql.Clear;
          DataM1.Query2.sql.add('Update  pagetable');
          DataM1.Query2.sql.add('set sortingposition = '+''''+Stackposnames[stackcount]+'''');
          DataM1.Query2.sql.add('where copyflatseparationset = ' + inttostr(DataM1.Query1.fields[4].asinteger));
          DataM1.Query2.sql.add('and ((copynumber+1) /2) = '+inttostr(aktcopynumber));
          formmain.trysql(DataM1.Query2);

        end;

        DataM1.Query1.next;
      end;
      DataM1.Query1.close;


      DataM1.Query1.SQL.Clear;
      DataM1.Query1.SQL.add('Select Distinct editionid,flatseparationset,copynumber,((copynumber+1) /2),copyflatseparationset from pagetable');
      DataM1.Query1.sql.add(wherestr);
      DataM1.Query1.sql.add('and active = 0');
      DataM1.Query1.SQL.add('order by editionid,flatseparationset,copynumber');


      DataM1.Query1.open;
      i2 := 0;
      While not DataM1.Query1.eof do
      begin
        IF (aktflatseparation <> DataM1.Query1.fields[1].asinteger)  then
        begin
          aktflatseparation := DataM1.Query1.fields[1].asinteger;
          aktcopynumber := DataM1.Query1.fields[2].asinteger;

          Inc(i2);
          if i2 = 2 then
          begin
            Inc(stackcount);
            IF stackcount > 4 then
              stackcount := 1;
            i2 := 0;
          End;

          DataM1.Query2.sql.Clear;
          DataM1.Query2.sql.add('Update  pagetable');
          DataM1.Query2.sql.add('set sortingposition = '+''''+Stackposnames[stackcount]+'''');
          DataM1.Query2.sql.add('where copyflatseparationset = ' + inttostr(DataM1.Query1.fields[4].asinteger));
          DataM1.Query2.sql.add('and ((copynumber+1) /2) = '+inttostr(aktcopynumber));
          formmain.trysql(DataM1.Query2);

        end;

        DataM1.Query1.next;
      end;
      DataM1.Query1.close;


    Except
    end;
  Finally
    screen.Cursor := crdefault;
  end;
end;

procedure TFormcustomtools.Button2Click(Sender: TObject);
begin
  ListBox1.Items.clear;


  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.add('Select Distinct p1.editionid,p1.pagename from pagetable p1 where exists(');
  DataM1.Query1.SQL.add('Select p2.pagename from pagetable p2 where p2.pagename <> p1.pagename and');
  DataM1.Query1.SQL.add('p1.productionid = p2.productionid and');
  DataM1.Query1.SQL.add('p1.planpagename = p2.planpagename)');
  DataM1.Query1.SQL.add('order by p1.editionid,p1.pagename');
  DataM1.Query1.open;
  IF DataM1.Query1.eof then
  begin
    ListBox1.Items.add('All names are ok');
  end;
  while not DataM1.Query1.eof do
  begin
    ListBox1.Items.add(tnames1.editionIDtoname(DataM1.Query1.fields[0].asinteger) +' , ' +  DataM1.Query1.fields[1].asstring);
    DataM1.Query1.next;
  end;

  DataM1.Query1.close;
end;

procedure TFormcustomtools.Button3Click(Sender: TObject);
Begin
  ListBox2.Items.clear;


  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.add('Select distinct p1.editionid,p1.pagename from pagetable p1 where exists(');
  DataM1.Query1.SQL.add('Select p2.pagename from pagetable p2 where p2.pagename <> p1.pagename and');
  DataM1.Query1.SQL.add('p1.productionid = p2.productionid and');
  DataM1.Query1.SQL.add('p1.mastercopyseparationset = p2.mastercopyseparationset)');
  DataM1.Query1.SQL.add('order by p1.editionid,p1.pagename');

  DataM1.Query1.open;
  IF DataM1.Query1.eof then
  begin
    ListBox2.Items.add('All master numbers are ok');
  end;
  while not DataM1.Query1.eof do
  begin
    ListBox2.Items.add(tnames1.editionIDtoname(DataM1.Query1.fields[0].asinteger) +' , ' +  DataM1.Query1.fields[1].asstring);
    DataM1.Query1.next;
  end;

  DataM1.Query1.close;

End;
procedure TFormcustomtools.ButtonplateidClick(Sender: TObject);
Var
  wherestr : string;
  runnode : ttreenode;
  pressid : longint;
  locationid,pressrunid : Longint;
  n : ttreenode;
  Alist : TStrings;

begin
  try
    Alist := TStringList.Create;
    screen.Cursor := crhourglass;
    IF TreeViewThumbs.Selected = nil then exit;
    n := TreeViewThumbs.Selected;
    wherestr := 'Where active <> -999';
    While n.Level > 0 do
    begin
      Case TTreeViewpagestype(n.data^).Kind of //0=all,1=location,2=publication,pubdate,3=issue,4=edition,5=section
        1 : wherestr := wherestr + ' and '+  DataM1.makedatastr('',TTreeViewpagestype(n.data^).pubdate);
        2 : Begin
              wherestr := wherestr + ' and publicationid = ' + inttostr(TTreeViewpagestype(n.data^).publicationid);
            end;
        3 : Begin
              wherestr := wherestr + ' and issueid = ' + inttostr(TTreeViewpagestype(n.data^).issueid);
            end;
        4 : begin
              wherestr := wherestr + ' and editionid = ' + inttostr(TTreeViewpagestype(n.data^).editionid);
            end;
        5 : begin
              wherestr := wherestr + ' and sectionid = ' + inttostr(TTreeViewpagestype(n.data^).sectionid);
            end;
      end;
      n := n.Parent;
    end;


    try

      DataM1.Query1.SQL.Clear;
      DataM1.Query1.SQL.add('Select pagename,copynumber,colorid,flatseparation from pagetable (NOLOCK)');
      DataM1.Query1.sql.add(wherestr);
      DataM1.Query1.sql.add('and active = 1 and dirty=0 ');
      DataM1.Query1.SQL.add('order by pagename,copynumber,colorid');
      DataM1.Query1.open;
      While not DataM1.Query1.eof do
      begin
        Alist.Add(DataM1.Query1.Fields[0].asstring+','+DataM1.Query1.Fields[1].asstring+','+tnames1.ColornameIDtoname(DataM1.Query1.Fields[2].asinteger)+','+DataM1.Query1.Fields[3].asstring);
        DataM1.Query1.next;
      end;

      DataM1.Query1.close;

      SaveDialog1.InitialDir := 'c:\';
      IF SaveDialog1.Execute then
      begin
        Alist.SaveToFile(SaveDialog1.FileName);

      end;


    Except
    end;
  finally
    Alist.free;
    screen.Cursor := crdefault;
  end;
End;


procedure TFormcustomtools.TreeViewThumbsChange(Sender: TObject;
  Node: TTreeNode);
begin
  Buttonplateid.Enabled := node.level > 1;
end;

procedure TFormcustomtools.ComboBoxpublChange(Sender: TObject);
Var
  T : String;
  publid : Longint;
  i : Longint;

begin
  T := ComboBoxpubl.Text;
  publid := tnames1.publicationnametoid(t);

  for i := 0 to listview1.items.Count-1 do
  begin
    listview1.items[i].SubItems[0] := '';

  end;

  for i := 0 to listview1.items.Count-1 do
  begin
//    tmplnum := inittypes.gettemplatelistnumberfromname(listview1.items[i].Caption);
    DataM1.Query1.SQL.Clear;

    DataM1.Query1.SQL.add('Select m.miscint2,p.ProofID,p.ProofName from PublicationMisc m,ProofConfigurations p  (NOLOCK)');
    DataM1.Query1.SQL.add('where m.publicationid = '+inttostr(publid));
    DataM1.Query1.SQL.add('and m.miscint1 =  '+ listview1.items[i].SubItems[1]);
    DataM1.Query1.SQL.add('and p.ProofID = m.miscint2');
    DataM1.Query1.Open;
    IF Not DataM1.Query1.Eof then
    Begin
      listview1.items[i].SubItems[0] := DataM1.Query1.fields[2].AsString;

    end;
    DataM1.Query1.close;
  end;
end;

procedure TFormcustomtools.ComboBoxproofsChange(Sender: TObject);
Var
  i : Longint;
begin
  For i := 0 to listview1.Items.count-1 do
  begin
    IF listview1.Items[i].Selected then
    begin
      listview1.Items[i].SubItems[0] := ComboBoxproofs.Text;

    end;
  end;
end;

procedure TFormcustomtools.BitBtn2Click(Sender: TObject);

Var
  T : String;
  publid : Longint;
  I,proofid : Longint;

begin
  T := ComboBoxpubl.Text;
  publid := tnames1.publicationnametoid(t);
  DataM1.Query1.SQL.clear;
  DataM1.Query1.SQL.add('Delete PublicationMisc ');
  DataM1.Query1.SQL.add('where publicationid = '+inttostr(publid));
  DataM1.Query1.ExecSQL;
  For i := 0 to listview1.Items.count-1 do
  begin
    IF listview1.Items[i].SubItems[0] <> '' then
    begin
      proofid := tnames1.proofnametoid(listview1.Items[i].SubItems[0]);
      DataM1.Query1.SQL.clear;
      DataM1.Query1.SQL.add('Insert PublicationMisc ');
      DataM1.Query1.SQL.add('Values(');
      DataM1.Query1.SQL.add(Inttostr(publid)+','+ListView1.Items[i].subitems[1]+','+inttostr(proofid)+',0,0,');
      DataM1.Query1.SQL.add(''''+''+''''+','+''''+''+''''+','+''''+''+''''+','+''''+''+''''+')');
      DataM1.Query1.ExecSQL;
    end;
  End;

end;

procedure TFormcustomtools.Button4Click(Sender: TObject);
Var
  i : Longint;
begin
  For i := 0 to listview1.Items.count-1 do
    listview1.Items[i].SubItems[0] := '';

end;

end.



