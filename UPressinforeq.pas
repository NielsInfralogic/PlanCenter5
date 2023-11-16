unit UPressinforeq;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ImgList, System.ImageList;
type
  TFormpressinforequest = class(TForm)
    Panel3: TPanel;
    Image2: TImage;
    Label7: TLabel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    ComboBoxdate: TComboBox;
    Label2: TLabel;
    ComboBoxlocation: TComboBox;
    Panel1: TPanel;
    Label3: TLabel;
    BitBtnclose: TBitBtn;
    BitBtnImport: TBitBtn;
    ListViewManual: TListView;
    GroupBoxdelayX: TGroupBox;
    ImagePressdata: TImageList;
    ProgressBardelayX: TProgressBar;
    BitBtnRefresh: TBitBtn;
    procedure ListViewManualSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure BitBtnImportClick(Sender: TObject);
    procedure ComboBoxdateSelect(Sender: TObject);
    procedure ComboBoxlocationSelect(Sender: TObject);
    procedure BitBtncloseClick(Sender: TObject);
    procedure BitBtnRefreshClick(Sender: TObject);
  private
    { Private declarations }
    aktpubdate : Tdatetime;
    Aktpubl : Longint;
    Aktlocation : Longint;

    procedure ManualRefreshCCproductions;
    procedure SetAktfilter;
  public
    procedure Initialize;
    { Public declarations }
  end;
var
  Formpressinforequest: TFormpressinforequest;
implementation
uses Udata,umain,utypes,dateutils, Usettings, Ulogin, UUtils;
{$R *.dfm}
Var
  brkcol : Tcolor;

procedure TFormpressinforequest.ManualRefreshCCproductions;
Var
  l : Tlistitem;
  pd,pupdfilter : Tdatetime;
  publid : Longint;
  addit : Boolean;
  difdate,Difpress,DifPubl,DifEd,Difsec,DifPr : string;
  DifInpress,DifinDate, DifInPubl,DifInEd,difInSec : boolean;
  Pressdatset : Longint;
begin
  try
    Screen.Cursor := crhourglass;
    pd := 0;
    publid :=-99;
    Difpress := '';
    DifPubl := '';
    DifEd := '';
    Difsec := '';
    DifPr := '';
    difdate := '';
    DifInpress := True;
    DifinDate := True;
    DifInPubl := True;
    DifInEd := True;
    difInSec := True;
    If ComboBoxdate.ItemIndex > 0 then
      pupdfilter := strtodate(ComboBoxdate.items[ComboBoxdate.itemindex]);

    ListViewManual.Items.Clear;
    DataM1.Query1.SQL.clear;
                                           //0        1       2       3       4             5             6             7           8             9
    DataM1.Query1.SQL.add('Select Distinct p.pubdate,pl.name,e.name,s.name,pr.PressName,p.publicationid,p.editionid,p.sectionid,p.pressid,p.productionid');
    DataM1.Query1.SQL.add('from pagetable p, PublicationNames pl, editionnames e, sectionnames s  ,PressNames pr ');
    DataM1.Query1.SQL.add('Where pl.publicationid = p.publicationid ');
    DataM1.Query1.SQL.add('and E.editionid = p.editionid ');
    DataM1.Query1.SQL.add('and S.Sectionid = p.Sectionid ');
    DataM1.Query1.SQL.add('and pr.pressid = p.pressid ');
    if ComboBoxdate.ItemIndex > 0 then
    begin
      DataM1.Query1.SQL.add(' and '+ DataM1.makedatastr('p.',pupdfilter));
    end;
    IF Aktlocation > 0 then
      DataM1.Query1.SQL.add('and p.locationid =  ' + inttostr(Aktlocation));

    if (Prefs.PressDataRequestPressSpecific) then
      DataM1.Query1.SQL.add('order by p.pubdate,pl.name, pr.PressName,e.name,s.name ')
    else
      DataM1.Query1.SQL.add('order by p.pubdate, pl.name,e.name,s.name ');
    if Prefs.debug then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'Getpressimportprod.sql');
    DataM1.Query1.open;
    ListViewManual.Items.beginupdate;
    while not DataM1.Query1.eof do
    begin
      addit := false;
      publid := DataM1.Query1.fields[5].AsInteger;
      Pressdatset := 0;
      if (Prefs.PressDataRequestPressSpecific) then
      Begin
        if DifPr <> DataM1.Query1.fields[4].AsString then
        begin
          addit := true;
        end;
      end;
      if difdate <> datetostr(DataM1.Query1.fields[0].AsDateTime) then
      begin
        addit := true;
      end;
      if DifPubl <> DataM1.Query1.fields[1].AsString then
      begin
        addit := true;
      end;
      if (Prefs.PressDataRequestLevel > 1) And (not addit) then
      Begin
        IF (Difed <> DataM1.Query1.fields[2].AsString)  then
        begin
          addit := true;
        end;
        if (Prefs.PressDataRequestLevel > 2) then
        Begin
          if (Difsec <> DataM1.Query1.fields[3].AsString)  then
          begin
            addit := true;
          end;
        End;
      End;
      If addit then
      Begin
        difdate := datetostr(DataM1.Query1.fields[0].AsDateTime);
        DifPubl := DataM1.Query1.fields[1].AsString;
        if (Prefs.PressDataRequestLevel > 1) then
          Difed := DataM1.Query1.fields[2].AsString;
        if (Prefs.PressDataRequestLevel > 2) then
          Difsec := DataM1.Query1.fields[3].AsString;
        if (Prefs.PressDataRequestPressSpecific) then
          DifPr := DataM1.Query1.fields[4].AsString;

        Pressdatset := 1;
        DataM1.Query2.SQL.clear;
        DataM1.Query2.SQL.add('select distinct productionid from pagetable where PressHighLow <> '+''''+''+''''+' and ');
        DataM1.Query2.SQL.add(' publicationid =  ' + DataM1.Query1.fields[5].Asstring);
        DataM1.Query2.SQL.add(' and '+  DataM1.makedatastr('',DataM1.Query1.fields[0].AsDateTime));
        if (Prefs.PressDataRequestLevel > 1) then
          DataM1.Query2.SQL.add('and editionid =  ' + DataM1.Query1.fields[6].Asstring);
        if (Prefs.PressDataRequestLevel > 2) then
          DataM1.Query2.SQL.add('and sectionid =  ' + DataM1.Query1.fields[7].Asstring);
        if (Prefs.PressDataRequestPressSpecific) then
          DataM1.Query2.SQL.add('and pressid =  ' + DataM1.Query1.fields[8].Asstring);
        DataM1.Query2.open;
        IF not DataM1.Query2.eof then
          Pressdatset := 2;
        DataM1.Query2.close;
        L := ListViewManual.Items.add;
        l.Caption := datetostr(DataM1.Query1.fields[0].AsDateTime);
        l.SubItems.Add(DifPubl);
        l.SubItems.Add(Difed);
        l.SubItems.Add(Difsec);
        l.SubItems.Add(DifPr);
        l.SubItems.Add(DataM1.Query1.fields[9].Asstring);
        l.ImageIndex := Pressdatset;
        addit := false;
      end;
      DataM1.Query1.next;
    end;
    ListViewManual.Items.Endupdate;
    DataM1.Query1.close;
  Except
  end;
  Screen.Cursor := crdefault;
end;
procedure TFormpressinforequest.Initialize;
Begin
 // tnames1.Loadnames;
  tnames1.LoadnamesSmall;
  //GroupBoxdelay.visible := false;
  ComboBoxdate.Items.Clear;
  ComboBoxlocation.Items.Clear;
  ComboBoxlocation.Items := tnames1.locationnames;
  ListViewManual.items.clear;
  Formmain.SetAdayselectcombo(ComboBoxdate);
  BitBtnImport.enabled := false;
  SetAktfilter;
  ManualRefreshCCproductions;
end;
procedure TFormpressinforequest.SetAktfilter;
Var
  n : ttreenode;                //TreeViewThumbs,     loadplateview
  T : String;
  i : Longint;
Begin
  Aktpubl := -1;
  aktpubdate := encodedate(1977,1,1);
  Aktlocation := -1;
  try
    Case formmain.PageControlMain.ActivePageIndex of
      VIEW_SEPARATIONS :
          begin
            IF formmain.TreeViewpagelist.Selected <> nil then
            begin
              n := formmain.TreeViewpagelist.Selected;
              While n.Level > 0 do
              begin
                Case TTreeViewpagestype(n.data^).Kind of //0=all,1=location,2=publication,pubdate,3=issue,4=edition,5=section
                  1 : aktpubdate := TTreeViewpagestype(n.data^).pubdate;
                  2 : Aktpubl := TTreeViewpagestype(n.data^).publicationid;
                end;
                n := n.Parent;
              end;
            End;
          end;
      VIEW_THUMBNAILS :
          begin
            IF formmain.TreeViewThumbs.Selected <> nil then
            begin
              n := formmain.TreeViewThumbs.Selected;
              While n.Level > 0 do
              begin
                Case TTreeViewpagestype(n.data^).Kind of //0=all,1=location,2=publication,pubdate,3=issue,4=edition,5=section
                  1 : aktpubdate := TTreeViewpagestype(n.data^).pubdate;
                  2 : Aktpubl := TTreeViewpagestype(n.data^).publicationid;
                end;
                n := n.Parent;
              end;
            End;
          end;
      VIEW_PLATES :
          begin
            Aktlocation := tnames1.locationnametoid(formmain.ComboBoxpalocationNY.text);
            IF formmain.TreeViewPlateview.Selected <> nil then
            begin
              n := formmain.TreeViewPlateview.Selected;
              While n.Level > 0 do
              begin
                Case TTreeViewpagestype(n.data^).Kind of
                  1 : aktpubdate := TTreeViewpagestype(n.data^).pubdate;
                  2 : Aktpubl := TTreeViewpagestype(n.data^).publicationid;
                end;
                n := n.Parent;
              end;
            End;
          end;
    end;
  Except
  end;
  IF yearof(aktpubdate) > 2000 then
  begin
    T := datetostr(aktpubdate);
    I := ComboBoxdate.Items.IndexOf(T);
    IF I > 0 then
      ComboBoxdate.ItemIndex := i
    else
      ComboBoxdate.ItemIndex := 0;
  end
  else
    ComboBoxdate.ItemIndex := 0;
  IF Aktlocation > 0 then
  Begin
    T := tnames1.locationIDtoname(Aktlocation);
    ComboBoxlocation.ItemIndex := ComboBoxlocation.Items.IndexOf(T);
  End;
  IF ComboBoxlocation.ItemIndex < 0 then
    ComboBoxlocation.ItemIndex := 0;
end;

procedure TFormpressinforequest.ListViewManualSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
Var
  I : Longint;
begin
  For i := 0 to ListViewManual.Items.Count-1 do
  begin
    if ListViewManual.Items[i].Selected then
    begin
      BitBtnImport.enabled := true;
      break;
    end;
  end;
end;
procedure TFormpressinforequest.BitBtnImportClick(Sender: TObject);
Var
  I,Publid : Longint;
  PubDTstr : String;
  pubdt : TDatetime;
  FoundN : Longint;
  waitstart : Tdatetime;
  nomorewait,madeAimport  : Boolean;
  MessageI : longint;
begin
  BitBtnImport.Enabled := false;
  BitBtnclose.enabled := false;
  MessageI := -1;
  madeAimport := false;
  //ProgressBardelay.position := 0;
  //GroupBoxdelay.Visible := true;
  //GroupBoxdelay.repaint;
  FoundN := 0;
  try
    For i := 0 to ListViewManual.Items.Count-1 do
    begin
      if ListViewManual.Items[i].Selected then
      begin
        Inc(FoundN);
      End;
    End;
    IF FoundN > 0 then
    begin
      //ProgressBardelay.position := 10;
      For i := 0 to ListViewManual.Items.Count-1 do
      begin
        if ListViewManual.Items[i].Selected then
        begin
          Publid := tnames1.publicationnametoid(ListViewManual.Items[i].subitems[0]);
          pubdt := strtodate(ListViewManual.Items[i].caption);
          DataM1.Query1.SQL.clear;
          DataM1.Query1.SQL.add('Select distinct pubdate from PageTable where productionid = ' + ListViewManual.Items[i].subitems[4]);
          DataM1.Query1.open;
          IF Not DataM1.Query1.Eof then
            pubdt := DataM1.Query1.fields[0].asdatetime;
          DataM1.Query1.close;
          DataM1.Query1.SQL.clear;
          DataM1.Query1.SQL.add('update PageTable set PressHighLow = '+''''+''+''''+', PressTower = '+''''+''+''''+', PressZone = '+''''+''+''''+', PressTime = '+''''+'1975-01-01 00:00'+'''');
          DataM1.Query1.SQL.add('Where publicationid =  ' + inttostr(Publid));
          DataM1.Query1.SQL.add(' and '+  DataM1.makedatastr('',pubdt));
          DataM1.Query1.ExecSQL;
          DataM1.Query1.SQL.clear;
          DataM1.Query1.SQL.add('Delete NicePressImport ');
          DataM1.Query1.SQL.add('Where publicationid =  ' + inttostr(Publid));
          DataM1.Query1.SQL.add(' and '+  DataM1.makedatastr('',pubdt));
          DataM1.Query1.ExecSQL;
          DataM1.Query1.SQL.clear;
          DataM1.Query1.SQL.add('insert NicePressImport ');
          DataM1.Query1.SQL.add('values ( GETDATE(),1,:Pubdate,' + inttostr(Publid) + ', '+''''+Prefs.username+''''+','+''''+Thisdevicename+''''+')');
          DataM1.Query1.Params[0].AsDateTime :=pubdt;
          IF Prefs.debug then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'Setrequest.sql');
          DataM1.Query1.execsql;
          MessageI := i;
          madeAimport := true;
          Break;
        End;
      End;
    end;
  Except

  end;
  IF madeAimport then
  begin
    MessageDlg('Request created for ' + #13+ ListViewManual.Items[MessageI].subitems[0] + ' '+ ListViewManual.Items[MessageI].caption , mtInformation,
      [mbOk], 0);

  end;
  ManualRefreshCCproductions;

  (*
  IF false or foxrmsettings.CheckBoxrecwait.Checked then
  begin
    waitstart := Now;
    //GroupBoxdelay.Repaint;
    //ProgressBardelay.position := 0;
    nomorewait := false;

    repeat
      Sleep(1000);
      ProgressBardelay.position := ProgressBardelay.position +1;
      if ProgressBardelay.position >= ProgressBardelay.max then
        ProgressBardelay.position := 0;
      DataM1.Query1.SQL.clear;
      DataM1.Query1.SQL.add('Select RequestTime from  NicePressImport ');
      DataM1.Query1.SQL.add('Where status < 2 and Username = ' +''''+Formlogin.username+'''');
      DataM1.Query1.open;
      nomorewait := DataM1.Query1.eof;
      DataM1.Query1.close;
      IF Secondsbetween(now,waitstart) > 60 then
      Begin
        nomorewait := true;
      end;
      DataM1.Query1.SQL.clear;
      DataM1.Query1.SQL.add('Delete NicePressImport ');
      DataM1.Query1.SQL.add('Where status > 1 and Username = ' +''''+Formlogin.username+'''');
      DataM1.Query1.ExecSQL;

    until nomorewait;
  end
  Else
  Begin
    IF FoundN > 0 then
    begin
      For i := 1 to 10 do
      begin
        sleep(100);
        application.ProcessMessages;
        ProgressBardelay.position := i;
      end;
    end;
  End;
  *)
  //GroupBoxdelay.Visible := false;
  //ProgressBardelay.position := 0;
  For i := 0 to ListViewManual.Items.Count-1 do
  begin
    if ListViewManual.Items[i].Selected then
    begin
      BitBtnImport.enabled := true;
      break;
    end;
  end;

  //GroupBoxdelay.visible := false;

  BitBtnclose.enabled := true;
end;
procedure TFormpressinforequest.ComboBoxdateSelect(Sender: TObject);
begin
  ManualRefreshCCproductions;
end;
procedure TFormpressinforequest.ComboBoxlocationSelect(Sender: TObject);
begin
  Aktlocation := tnames1.locationnametoid(ComboBoxlocation.text);
  ManualRefreshCCproductions;
end;
procedure TFormpressinforequest.BitBtncloseClick(Sender: TObject);
begin
  //GroupBoxdelay.visible := false;
end;

procedure TFormpressinforequest.BitBtnRefreshClick(Sender: TObject);
begin
  ManualRefreshCCproductions;

end;

end.
