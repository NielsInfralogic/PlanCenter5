unit Uarchive;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, CheckLst, ComCtrls, ExtCtrls;
type
  TFormarchive = class(TForm)
    Panel3: TPanel;
    Image2: TImage;
    Label7: TLabel;
    Label8: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox31: TGroupBox;
    CheckListBoxAFoldername: TCheckListBox;
    GroupBox30: TGroupBox;
    Editmainarchivefolderhighres: TEdit;
    BitBtn5: TBitBtn;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Splitter1: TSplitter;
    GroupBoxpageslocation: TGroupBox;
    ComboBoxpalocation: TComboBox;
    TreeViewThumbs: TTreeView;
    Panel2: TPanel;
    BitBtn3: TBitBtn;
    DateTimePickerthumb: TDateTimePicker;
    BitBtn1: TBitBtn;
    GroupBox2: TGroupBox;
    Editmainarchivefolderlowres: TEdit;
    BitBtn4: TBitBtn;
    GroupBox5: TGroupBox;
    Animate1: TAnimate;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
  private
    Procedure refreshtree;
    { Private declarations }
  public
    { Public declarations }
  end;
var
  Formarchive: TFormarchive;
implementation
uses Usettings, Udata, utypes,umain,inifiles, USelectfolder, UUtils;
{$R *.dfm}
Var
  Stopcopying : boolean;
  nocolor : Boolean;
  renfilename : boolean;
procedure TFormarchive.FormActivate(Sender: TObject);
Var
  I : longint;
begin
  ComboBoxpalocation.align := alclient;
  ComboBoxpalocation.Items := FormMain.ComboBoxpalocationNY.Items;
  ComboBoxpalocation.ItemIndex := FormMain.ComboBoxpalocationNy.ItemIndex;
  Editmainarchivefolderhighres.text := Prefs.MainArchiveFolderHighres;
  Editmainarchivefolderlowres.text := Prefs.MainArchiveFolderLowres;
  For i := 0 to CheckListBoxAFoldername.Items.Count-1 do
  begin
    CheckListBoxAFoldername.Checked[i] := Prefs.ArchiveFolderNameDefinitions[i];
  end;
  refreshtree;
end;
Procedure TFormarchive.refreshtree;
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
    selectstr := selectstr + ' from pagetable WITH (NOLOCK)';
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
    starti := 1;
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
                if (Prefs.Proversion = 0) then
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

procedure TFormarchive.BitBtn3Click(Sender: TObject);
begin
  refreshtree;
end;
procedure TFormarchive.BitBtn2Click(Sender: TObject);
Function makefoldername(basefolder : string):string;
Var
  I : longint;
Begin
  result := includetrailingbackslash(basefolder);
  For i := 0 to CheckListBoxAFoldername.Items.Count-1 do
  begin
    if CheckListBoxAFoldername.checked[i] then
    begin
      Case i of
        //0 : result := result + tnames1.locationIDtoname(datam1.Query1.fields[0].asinteger);
        1 : result := result + formatdatetime('DDMMYYYY',datam1.Query1.fields[0].asdatetime);
        2 : result := result + tnames1.publicationIDtoname(datam1.Query1.fields[1].asinteger);
        3 : result := result + tnames1.editionIDtoname(datam1.Query1.fields[3].asinteger);
        4 : result := result + tnames1.sectionIDtoname(datam1.Query1.fields[4].asinteger);
      end;
      CreateDir(result);
      result := includetrailingbackslash(result);
    end;
  end;
end;

Function makelowfilename(basefolder : string):string;
Var
  I : longint;
  T : string;
Begin
  T := Prefs.ArchiveLowResNameDefinition;
  I := 1;
  result := '';
  repeat
    IF T[i] = '%' then
    begin
      Inc(i);
      Case t[i] of
        'P' : result := result + tnames1.publicationIDtoname(datam1.Query1.fields[1].asinteger);
        'E' : result := result + tnames1.editionIDtoname(datam1.Query1.fields[3].asinteger);
        'S' : result := result + tnames1.sectionIDtoname(datam1.Query1.fields[2].asinteger);
        'D' : result := result + FormatDateTime(Prefs.ArchiveLowResDateDefinition, datam1.Query1.fields[0].asdatetime);
        'N' : result := result + datam1.Query1.fields[6].asstring;
        '#' : result := result + datam1.Query1.fields[7].asstring;
      end;
      Inc(i);
    end
    Else
    begin
      result := result + t[i];
      Inc(i);
    end;
  Until i >= length(T);
end;

Var
  wherestr : string;
  n : ttreenode;
  aktmaster : Longint;
  aktlocation,aktpublication,aktedition,aktsection : longint;
  aktlowresfolder,akthighresfolder : string;
  aktpubdate : tdatetime;
  lp,hp : string;
  akthighname : string;
  aktlowname,astr : string;
  PreviewGUID : String;
  TestPath : String;
begin
  try
    Stopcopying := false;


    wherestr := 'and active = 1 and pagetype < 2 and uniquepage = 1';
    IF TreeViewThumbs.Selected = nil then exit;
    n := TreeViewThumbs.Selected;
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
    datam1.Query1.SQL.Clear;
    datam1.Query1.SQL.Add('Select Distinct pubdate,publicationid,sectionid,editionid,mastercopyseparationset,filename,pagename,pageindex,fileserver from pagetable WITH (NOLOCK)');
    datam1.Query1.SQL.Add('where status > 0 AND Dirty=0 AND UniquePage=1');
    datam1.Query1.SQL.Add(wherestr);
    datam1.Query1.SQL.Add('order by mastercopyseparationset');

    aktmaster := -1;
    aktlocation := -1;
    aktpublication := -1;
    aktedition := -1;
    aktsection := -1;
    aktpubdate := -1;
    GroupBox5.Visible := true;
    Animate1.Active := true;
    Animate1.Refresh;
    datam1.Query1.open;
    While (not datam1.Query1.eof) and (not Stopcopying) do
    begin
      hp := formmain.GetFileServerPath(PATHTYPE_CCFILES, datam1.Query1.fieldbyname('fileserver').asstring);
      lp := formmain.GetFileServerPath(PATHTYPE_CCPREVIEWS, datam1.Query1.fieldbyname('fileserver').asstring);
      aktmaster := datam1.Query1.fieldbyname('mastercopyseparationset').asinteger;
      aktpublication := datam1.Query1.fieldbyname('publicationid').asinteger;
      aktedition := datam1.Query1.fieldbyname('editionid').asinteger;
      aktsection := datam1.Query1.fieldbyname('sectionid').asinteger;
      aktpubdate := datam1.Query1.fieldbyname('pubdate').asdatetime;
      PreviewGUID := inittypes.GeneratePreviewGUID(aktpublication, aktpubdate);

      aktlowname := makelowfilename('');
      aktlowresfolder := makefoldername(Editmainarchivefolderlowres.Text);
      Animate1.repaint;
      application.ProcessMessages;
      testpath := lp + inttostr(aktmaster)+'.jpg';
      if (Prefs.NewPreviewNames) then
      begin
        testpath := lp + PreviewGUID + '====' + inttostr(aktmaster)+'.jpg';
        if NOT FileExists(testpath) then
          testpath := lp + inttostr(aktmaster)+'.jpg';
      end;
      copyfile(pchar(testpath),pchar(aktlowresfolder+aktlowname+'.jpg'),false);
      Animate1.Refresh;
      application.ProcessMessages;
      datam1.Query1.next;
    end;
    datam1.Query1.close;
  Finally
    Animate1.Active := false;
    GroupBox5.Visible := false;
  end;
end;
procedure TFormarchive.BitBtn6Click(Sender: TObject);
begin
  Stopcopying := true;
end;
procedure TFormarchive.BitBtn7Click(Sender: TObject);
Function makefoldername(basefolder : string):string;
Var
  I : longint;
Begin
  result := includetrailingbackslash(basefolder);
  For i := 0 to CheckListBoxAFoldername.Items.Count-1 do
  begin
    if CheckListBoxAFoldername.checked[i] then
    begin
      Case i of
        0 : result := result + tnames1.locationIDtoname(datam1.Query1.fields[0].asinteger);
        1 : result := result + formatdatetime('DDMMYYYY',datam1.Query1.fields[1].asdatetime);
        2 : result := result + tnames1.publicationIDtoname(datam1.Query1.fields[2].asinteger);
        3 : result := result + tnames1.editionIDtoname(datam1.Query1.fields[4].asinteger);
        4 : result := result + tnames1.sectionIDtoname(datam1.Query1.fields[3].asinteger);
      end;
      CreateDir(result);
      result := includetrailingbackslash(result);
    end;
  end;
end;
Function makeHighfilename(basefolder : string):string;
Var
  I : longint;
  T : string;
Begin
//   0          1          2            3           4       5               6               7        8        9
//locationid,pubdate,publicationid,sectionid,editionid,colorid,mastercopyseparationset,filename,pagename,pageindex
  nocolor := true;
  renfilename := false;
  T := Prefs.ArchiveHigresFilenameDefinition;
  I := 1;
  result := '';
  repeat
    IF T[i] = '%' then
    begin
      Inc(i);
      Case t[i] of
        'P' : result := result + tnames1.publicationIDtoname(datam1.Query1.fields[2].asinteger);
        'E' : result := result + tnames1.editionIDtoname(datam1.Query1.fields[3].asinteger);
        'S' : result := result + tnames1.sectionIDtoname(datam1.Query1.fields[3].asinteger);
        'D' : result := result + FormatDateTime(Prefs.ArchiveLowResDateDefinition, datam1.Query1.fields[1].asdatetime);
        'N' : result := result + datam1.Query1.fields[8].asstring;
        '#' : result := result + datam1.Query1.fields[9].asstring;
        'C' : Begin
                result := result + tnames1.ColornameIDtoname(datam1.Query1.fields[5].asInteger);
                nocolor := false;
              end;
        'L' : result := result + tnames1.locationIDtoname(datam1.Query1.fields[0].asInteger);
        'F' : Begin
                result := result + datam1.Query1.fields[7].asstring;
                nocolor := false;
                renfilename := true;
              end;
      end;
      Inc(i);
    end
    Else
    begin
      result := result + t[i];
      Inc(i);
    end;
  Until i >= length(T);
end;

Var
  wherestr : string;
  n : ttreenode;
  aktmaster : Longint;
  aktlocation,aktpublication,aktedition,aktsection : longint;
  aktlowresfolder,akthighresfolder : string;
  aktpubdate : tdatetime;
  lp,hp : string;
  akthighname : string;
  aktlowname,astr : string;
  PreviewGUID : String;
  TestPath : String;
  ColorName : String;
  OrgFileName : String;
begin
  try
    Stopcopying := false;

    wherestr := 'and active = 1 and pagetype < 2 and uniquepage = 1';
    IF TreeViewThumbs.Selected = nil then exit;
    n := TreeViewThumbs.Selected;
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
    datam1.Query1.SQL.Clear;
    datam1.Query1.SQL.Add('Select Distinct locationid,pubdate,publicationid,sectionid,editionid,colorid,mastercopyseparationset,filename,pagename,pageindex,fileserver from pagetable');
    datam1.Query1.SQL.Add('where status > 0 AND Dirty=0 AND UniquePage=1');
    datam1.Query1.SQL.Add(wherestr);
    datam1.Query1.SQL.Add('order by mastercopyseparationset,colorid');

    aktmaster := -1;
    aktlocation := -1;
    aktpublication := -1;
    aktedition := -1;
    aktsection := -1;
    aktpubdate := -1;
    GroupBox5.Visible := true;
    Animate1.Active := true;
    Animate1.Refresh;
    datam1.Query1.open;
    While (not datam1.Query1.eof) and (not Stopcopying) do
    begin
      hp := formmain.GetFileServerPath(PATHTYPE_CCFILES, datam1.Query1.fieldbyname('fileserver').asstring);
      lp := formmain.GetFileServerPath(PATHTYPE_CCPREVIEWS, datam1.Query1.fieldbyname('fileserver').asstring);
      aktmaster := datam1.Query1.fieldbyname('mastercopyseparationset').asinteger;
      aktlocation := datam1.Query1.fieldbyname('locationid').asinteger;
      aktpublication := datam1.Query1.fieldbyname('publicationid').asinteger;
      aktedition := datam1.Query1.fieldbyname('editionid').asinteger;
      aktsection := datam1.Query1.fieldbyname('sectionid').asinteger;
      aktpubdate := datam1.Query1.fieldbyname('pubdate').asdatetime;
      PreviewGUID := inittypes.GeneratePreviewGUID(aktpublication, aktpubdate);
      OrgFileName :=  datam1.Query1.fields[7].asstring;
      ColorName := tnames1.ColornameIDtoname(datam1.Query1.fieldbyname('colorid').asinteger);
      akthighname := makehighfilename('');
      akthighresfolder := makefoldername(Editmainarchivefolderhighres.Text);
      Animate1.repaint;
      application.ProcessMessages;
      Animate1.Refresh;
      application.ProcessMessages;
      testpath := hp + inttostr(aktmaster) + '.' + ColorName;
      if (Prefs.NewPreviewNames) then
      begin
        testpath := hp + OrgFileName + '====' + inttostr(aktmaster) + '.' + ColorName;
        if NOT FileExists(testpath) then
          testpath := hp + inttostr(aktmaster) + '.' + ColorName;
      end;
      IF nocolor then
        copyfile(pchar(testpath), pchar(akthighresfolder+akthighname + '_' + ColorName + '.tif'),false)
      Else
        copyfile(pchar(testpath), pchar(akthighresfolder+akthighname),false);
      Animate1.repaint;
      application.ProcessMessages;
      datam1.Query1.next;
    end;
    datam1.Query1.close;
  Finally
    Animate1.Active := false;
    GroupBox5.Visible := false;
  end;
end;

procedure TFormarchive.BitBtn5Click(Sender: TObject);
begin
  {IF FormSelectfolder.showmodal = mrok then
  begin
    Editmainarchivefolderhighres.Text := FormSelectfolder.ShellTreeView1.Path;
  end;  }
    with TFileOpenDialog.Create(nil) do
        try
          Options := [fdoPickFolders];
          if Execute then
            Editmainarchivefolderhighres.Text  := FileName;
        finally
          Free;
        end;
end;
procedure TFormarchive.BitBtn4Click(Sender: TObject);
begin
 { IF FormSelectfolder.showmodal = mrok then
  begin
    Editmainarchivefolderlowres.Text := FormSelectfolder.ShellTreeView1.Path;
  end;    }
   with TFileOpenDialog.Create(nil) do
        try
          Options := [fdoPickFolders];
          if Execute then
            Editmainarchivefolderlowres.Text  := FileName;
        finally
          Free;
        end;
end;
end.
