unit UNewChpress;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls,utypes;
type
  TFormNewChangepress = class(TForm)
    Panel3: TPanel;
    Image3: TImage;
    Labelcp1: TLabel;
    Labelcp2: TLabel;
    Panel1: TPanel;
    BitBtn3: TBitBtn;
    BitBtn1: TBitBtn;
    GroupBox5: TGroupBox;
    GroupBox2: TGroupBox;
    ComboBoxpress: TComboBox;
    GroupBox1: TGroupBox;
    ComboBoxTemplate: TComboBox;
    GroupBox3: TGroupBox;
    ComboBoxlocation: TComboBox;
    GroupBox4: TGroupBox;
    ComboBoxFlatproof: TComboBox;
    GroupBox6: TGroupBox;
    ListViewapply: TListView;
    Panelpubl: TPanel;
    CheckBoxOnly1copy: TCheckBox;
    GroupBoxRipSetup: TGroupBox;
    Label1: TLabel;
    ComboBoxPreflight: TComboBox;
    ComboBoxInksave: TComboBox;
    Label2: TLabel;
    ComboBoxRipSetup: TComboBox;
    Label4: TLabel;
    CheckBoxReprocessPags: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ComboBoxpressChange(Sender: TObject);
    procedure ComboBoxlocationChange(Sender: TObject);
    procedure ComboBoxTemplateChange(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure ListViewapplyChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
  private
    { Private declarations }
    activated : Boolean;
    procedure setPresses;
    Procedure setTemplates;
    Function Applychanges:Boolean;
    Procedure Resetpaginaandpresssectionnum(aproductionid : Longint;
                                            Apressid      : Longint);
    procedure setokbottun;
  public
    aktdeftemplID : Longint;
    aktdeftemplname : String;
    ToLocationid : Longint;
    Topressid : Longint;
    Totemplateid : Longint;
    TotemplateListid : Longint;
    ToNmarks : Integer;
    Tomarks : marksarray;
    ToFlatproofid : Longint;
    ToFlatproofConfig : Longint;
    orgplantype : Longint;
    Copypublicationid : Longint;
    Copypubdate : Tdatetime;
    Newplanname : String;
    FromLocationID : Longint;
    FromPublicationID : Longint;
    Frompressid : Longint;
    Fromproductionid : Longint;
    FromNup : Longint;
    Fromtemplateid : Longint;
    FromtemplateListid : Longint;
    fromFlatproofid : Longint;
    Fromwaitforapproval : Boolean;
    procedure setnewtemplateidinplan;
    Function Init(pressid : Longint;
                  productionid  : Longint;
                  locationid  : Longint;
                  publicationid  : Longint;
                  pubdate : Tdatetime;
                  inpressruns : String):boolean;
  end;
var
  FormNewChangepress: TFormNewChangepress;
implementation
uses Usettings, Umain,uprodplan,uplanframe, Udata, Uflatproof, UUtils;
{$R *.dfm}
procedure TFormNewChangepress.FormCreate(Sender: TObject);
begin
  activated := false;
end;
procedure TFormNewChangepress.FormActivate(Sender: TObject);
Var
  I : longint;
  RipSetupID : Longint;
  InkSaveID : Longint;
  PreflightID : Longint;
  RipSetupName, InkSaveName,PreflightName : string;
begin
  IF not  activated then
  begin
    activated := true;
  end;
  CheckBoxReprocessPags.Checked := Prefs.PressSpecific;
  CheckBoxOnly1copy.Checked := false;
  BitBtn3.enabled := false;
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('Select TOP 1 templateid from pagetable WITH (NOLOCK)' );
  DataM1.Query1.SQL.Add('where productionid =  ' + IntToStr(fromproductionid));
  DataM1.Query1.Open;
  IF not DataM1.Query1.eof then
    fromtemplateid := DataM1.Query1.Fields[0].AsInteger;
  DataM1.Query1.Close;
  For i := 1 to NPlatetemplateArray do
  begin
    if (PlatetemplateArray[i].TemplateID = fromtemplateid) then
    begin
      FromtemplateListid := i;
      break;
    end;
  End;

  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('Select TOP 1 FlatProofConfigurationID from pagetable WITH (NOLOCK)' );
  DataM1.Query1.SQL.Add('where productionid =  ' + IntToStr(fromproductionid));
  DataM1.Query1.Open;
  IF not DataM1.Query1.eof then
  Begin
    ToFlatproofConfig := DataM1.Query1.fields[0].AsInteger;
    fromFlatproofid := DataM1.Query1.fields[0].AsInteger;
    Fromwaitforapproval := fromFlatproofid and 2 = 2;
    fromFlatproofid := fromFlatproofid SHR 8;
  End;
  DataM1.Query1.close;
  ComboBoxFlatproof.Items.Clear;
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('Select ProofName from FlatProofConfigurations Order by ProofName');
  DataM1.Query1.Open;
  ComboBoxFlatproof.Items.Add('Off');
  While not DataM1.Query1.eof do
  begin
    ComboBoxFlatproof.Items.Add(DataM1.Query1.Fields[0].AsString);
    DataM1.Query1.Next;
  end;
  DataM1.Query1.Close;
  ComboBoxFlatproof.ItemIndex:= 0;
  IF fromFlatproofid > 0 then
  begin
    ComboBoxFlatproof.ItemIndex:= ComboBoxFlatproof.Items.IndexOf(tnames1.FlatProofConfigurationIDtoname(fromFlatproofid));
  end;
  IF ComboBoxFlatproof.ItemIndex< 0 then
    ComboBoxFlatproof.ItemIndex:= 0;
  ComboBoxlocation.Items := tnames1.locationnames;
  if (fromlocationid <= 0) then
    fromlocationid := 1;
  ComboBoxlocation.ItemIndex:= ComboBoxlocation.Items.IndexOf(tnames1.locationIDtoname(fromlocationid));
  if (ComboBoxlocation.ItemIndex<= 0) then
    ComboBoxlocation.ItemIndex:= 0;
  RipSetupID := 0;
  if (UTypes.RipSetupIDInPageTable) then
  begin
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('Select TOP 1 RipSetupID from PageTable WITH (NOLOCK)' );
    DataM1.Query1.SQL.Add('where Productionid =  ' + IntToStr(fromproductionid));
    DataM1.Query1.Open;
    if not DataM1.Query1.eof then
    begin
      RipSetupID := DataM1.Query1.Fields[0].AsInteger;
    end;
    DataM1.Query1.Close;
  end;
  InkSaveID := RipSetupID DIV 65536;
  RipSetupID :=  RipSetupID - (InkSaveID*65536);
  PreflightID := RipSetupID DIV 256;
  RipSetupID :=  RipSetupID - (PreflightID*256);
  ComboBoxPreflight.Items.clear;
  PreflightName := '';
  if (UTypes.PreflightSetupNamesPossible = true) then
  begin
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('SELECT Name FROM PreflightSetupNames ORDER BY Name');
    DataM1.Query1.Open;
    While not DataM1.Query1.eof do
    begin
      ComboBoxPreflight.Items.Add(DataM1.Query1.Fields[0].AsString);
      DataM1.Query1.Next;
    end;
    DataM1.Query1.Close;
    ComboBoxPreflight.ItemIndex:= 0;
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('Select Name from PreflightSetupNames WHERE PreflightSetupID='+IntToStr(PreflightID));
    DataM1.Query1.Open;
    if not DataM1.Query1.eof then
      PreflightName := DataM1.Query1.Fieldbyname('Name').AsString;
    DataM1.Query1.Close;
  end;
  if (PreflightName <> '') then
    ComboBoxPreflight.ItemIndex := ComboBoxPreflight.Items.IndexOf(PreflightName);
  ComboBoxInksave.Items.Clear;
  InkSaveName := '';
  if (UTypes.InkSaveSetupNamesPossible = true) then
  begin
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('Select Name from InksaveSetupNames');
    DataM1.Query1.SQL.Add('Order by Name ');
    DataM1.Query1.Open;
    While not DataM1.Query1.eof do
    begin
      ComboBoxInksave.Items.Add(DataM1.Query1.Fields[0].AsString);
      DataM1.Query1.Next;
    end;
    DataM1.Query1.Close;
    ComboBoxInksave.ItemIndex := 0;
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('Select Name from InksaveSetupNames WHERE InksaveSetupID='+IntToStr(InkSaveID));
    DataM1.Query1.Open;
    if not DataM1.Query1.eof then
      InkSaveName := DataM1.Query1.Fields[0].AsString;
    DataM1.Query1.Close;
    if (InkSaveName <> '') then
      ComboBoxInksave.ItemIndex := ComboBoxInksave.Items.IndexOf(InkSaveName);
  end;
  ComboBoxRipSetup.Items.Clear;
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('Select Name from RipSetupNames Order by Name');
  DataM1.Query1.Open;
  While not DataM1.Query1.eof do
  begin
    ComboBoxRipSetup.Items.Add(DataM1.Query1.Fields[0].AsString);
    DataM1.Query1.Next;
  end;
  DataM1.Query1.Close;
  ComboBoxRipSetup.ItemIndex := 0;
  RipSetupName := '';
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('Select Name from RipSetupNames WHERE RipSetupID='+IntToStr(RipSetupID));
  DataM1.Query1.Open;
  if not DataM1.Query1.eof then
    RipSetupName := DataM1.Query1.Fields[0].AsString;
  DataM1.Query1.Close;
  if (RipSetupName <> '') then
    ComboBoxRipSetup.ItemIndex:= ComboBoxRipSetup.Items.IndexOf(RipSetupName);
  setPresses;
  setTemplates;
  // ## NAN TODO
  // Set RIpSetup from PublicationTemplate defaults

  setokbottun;

end;

procedure TFormNewChangepress.ComboBoxpressChange(Sender: TObject);
Var
  I : longint;
  pressidch : Longint;
begin
  if (ComboBoxpress.Items.Count > 0) and (ComboBoxpress.ItemIndex > -1) then
  begin
    setTemplates;
  end;
  setokbottun;
end;
procedure TFormNewChangepress.setnewtemplateidinplan;
Var
  Iplf,ipl,ip : Longint;
Begin
  for Iplf := 1 to Nplateframes do
  begin
    for ipl := 0 to plateframes[iplf].Nprodplates do
    begin
      plateframesdata[iplf].prodplates[ipl].templatelistid := TotemplateListid;
    end;
  end;
end;
procedure TFormNewChangepress.setPresses;
Var
  I : Longint;
  ntempls : Longint;
begin
  ComboBoxpress.Items.Clear;
  ComboBoxTemplate.Enabled := true;
  if (ComboBoxlocation.Text = '') then
    ComboBoxlocation.ItemIndex := 0;
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('Select distinct PressName from pressnames ' );
  DataM1.Query1.SQL.Add('where pressid <>  ' + IntToStr(frompressid));
  if (ComboBoxlocation.text <> '') then
    DataM1.Query1.SQL.Add('and locationid = ' + IntToStr(tnames1.locationnametoid(ComboBoxlocation.text) ));
  DataM1.Query1.SQL.Add('order by PressName');
  DataM1.Query1.open;
  While not DataM1.Query1.eof do
  begin
    ComboBoxpress.items.Add(DataM1.Query1.fields[0].AsString);
    DataM1.Query1.next;
  end;
  DataM1.Query1.close;

  IF ComboBoxpress.Items.Count > 0 then
    ComboBoxpress.itemindex := 0
  Else
  begin
    ComboBoxpress.itemindex := -1;
  end;
End;
procedure TFormNewChangepress.ComboBoxlocationChange(Sender: TObject);
begin
  setPresses;
  setTemplates;
  setokbottun;
end;

Procedure TFormNewChangepress.setTemplates;
Var
  I,tmpli, pos, pos2 : Longint;
  ntempls,aktpressid : Longint;
   T,t1, t2,t3 : String;
Begin
  ComboBoxTemplate.items.Clear;
  ComboBoxTemplate.enabled := true;
  aktpressid := tnames1.pressnametoid(ComboBoxpress.text);
  aktdeftemplID := 0;
  aktdeftemplname := '';
  ToNmarks := 0;
  t := '';
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('Select distinct Templateid,Markgroups,RipSetup from PublicationTemplates ');
  DataM1.Query1.SQL.Add('Where PublicationID = ' + IntToStr(FromPublicationID) );
  DataM1.Query1.SQL.Add('And PressID = ' + IntToStr(aktpressid) );
  DataM1.Query1.Open;
  IF Not DataM1.Query1.eof then
  begin
    aktdeftemplID := DataM1.Query1.fields[0].AsInteger;
    tmpli := inittypes.gettemplatelistnumberfromdbID(aktdeftemplID);
    aktdeftemplname := PlatetemplateArray[tmpli].TemplateName;
    ToNmarks := PlatetemplateArray[tmpli].Nmarkgroups;
    if ToNmarks > 0 then
    begin
      for i := 1 to ToNmarks do
        Tomarks[i] := PlatetemplateArray[tmpli].markgroups[i];
    end;
     t := DataM1.Query1.fields[1].AsString;
  end;
  DataM1.Query1.close;

  FromNup := PlatetemplateArray[FromtemplateListid].NupOnplate;
  For i := 1 to NPlatetemplateArray do
  begin
    if (PlatetemplateArray[i].NupOnplate = FromNup) and
       (PlatetemplateArray[i].PressID = tnames1.pressnametoid(ComboBoxpress.text)) and
       (i <> FromtemplateListid) then
       ComboBoxTemplate.items.Add(PlatetemplateArray[i].TemplateName);
  end;
  IF ComboBoxTemplate.items.count > 0 then
  Begin
    ComboBoxTemplate.itemindex := 0;
    For i := 0 to ComboBoxTemplate.items.count-1 do
    begin
      if ComboBoxTemplate.items[i] = aktdeftemplname then
      begin
        ComboBoxTemplate.itemindex := i;
        break;
      end;
    end;
    BitBtn3.enabled := true;
  End
  Else
    BitBtn3.enabled := false;

   t1 := t;
    pos := AnsiPos(';',t);
    t2 := '';
    t3 := '';
    if pos >0 then
    begin
      t1 := copy(t, 1,pos-1);
      t := copy(t, pos+1, 100);
      pos2 := AnsiPos(';',t);
      if pos2 >0 then
      begin
         t2 := copy(t, 1, pos2-1);
         t3 := copy(t, pos2+1,100);
      end;
    end;
     if (t1 <> '') then
    begin
      For i := 0 to ComboBoxripsetup.Items.count-1 do
      begin
        IF ComboBoxripsetup.Items[i] = t1 then
        begin
          ComboBoxripsetup.ItemIndex:= i;
          break;
        end;
      End;
    end;
    if (t2 <> '') then
    begin
      For i := 0 to ComboBoxPreflight.Items.count-1 do
      begin
        IF ComboBoxPreflight.Items[i] = t2 then
        begin
          ComboBoxPreflight.ItemIndex:= i;
          break;
        end;
      End;
    end;
    if (t3 <> '') then
    begin
      For i := 0 to ComboBoxInksave.Items.count-1 do
      begin
        IF ComboBoxInksave.Items[i] = t3 then
        begin
          ComboBoxInksave.ItemIndex:= i;
          break;
        end;
      End;
    end;
  setokbottun;
End;

procedure TFormNewChangepress.ComboBoxTemplateChange(Sender: TObject);
begin
  setokbottun;
end;
procedure TFormNewChangepress.BitBtn3Click(Sender: TObject);
Var
  I : Longint;
begin
  ToLocationid := tnames1.locationnametoid(ComboBoxlocation.text);
  Topressid := tnames1.pressnametoid(ComboBoxpress.text);
  For i := 1 to NPlatetemplateArray do
  begin
    if PlatetemplateArray[i].TemplateName = ComboBoxTemplate.text then
    begin
      Totemplateid := PlatetemplateArray[i].TemplateID;
      TotemplateListid := i;
      ToNmarks := PlatetemplateArray[i].Nmarkgroups;
      Tomarks := PlatetemplateArray[i].markgroups;
      break;
    End;
  End;
  IF ComboBoxFlatproof.ItemIndex > 0 then
  Begin
    ToFlatproofid := tnames1.FlatProofConfigurationnametoid(ComboBoxFlatproof.text);
    ToFlatproofConfig := Formflatproof.flatproofconfigcalc(true,Fromwaitforapproval,ToFlatproofid);
  end
  else
  begin
    ToFlatproofid := 0;
    ToFlatproofConfig := 0;
  end;
  Applychanges;
end;

Function TFormNewChangepress.Init(pressid : Longint;
                                  productionid  : Longint;
                                  locationid  : Longint;
                                  publicationid  : Longint;
                                  pubdate : Tdatetime;
                                  inpressruns : String):boolean;
Var
    L : Tlistitem;
    I : Longint;
Begin
  result := False;
  try
    FormNewChangepress.Frompressid := pressid;
    FormNewChangepress.Topressid := -1;
    FormNewChangepress.Fromproductionid := productionid;
    FormNewChangepress.FromLocationID := locationid;
    FormNewChangepress.Copypublicationid := publicationid;
    FormNewChangepress.Copypubdate := pubdate;
    FormProdPlan.Runschanged := false;
    FormNewChangepress.Panelpubl.Caption := tnames1.publicationIDtoname(FormNewChangepress.Copypublicationid)+ '  ' + datetostr(FormNewChangepress.Copypubdate);
    FormNewChangepress.ListViewapply.Clear;

    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('Select TOP 1 plantype from productionnames ');
    DataM1.Query1.SQL.Add('Where productionid = ' + IntToStr(FormNewChangepress.Fromproductionid) );
    DataM1.Query1.Open;
    IF not DataM1.Query1.Eof then
    begin
      orgplantype := DataM1.Query1.fields[0].AsInteger;
      DataM1.Query1.Next;
    end;
    DataM1.Query1.close;
    FromPublicationID := -1;
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('Select TOP 1 publicationid from pagetable (NOLOCK)' );
    DataM1.Query1.SQL.Add('where productionid = ' + IntToStr(FormNewChangepress.Fromproductionid));
    DataM1.Query1.SQL.Add('order by publicationid');
    DataM1.Query1.open;
    IF not DataM1.Query1.eof then
    begin
      FromPublicationID := DataM1.Query1.fields[0].AsInteger;
    End;
    DataM1.Query1.close;
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('Select distinct editionid,sectionid,PressSectionNumber,pressrunid from pagetable  (NOLOCK)' );
    DataM1.Query1.SQL.Add('where productionid = ' + IntToStr(FormNewChangepress.Fromproductionid));
    DataM1.Query1.SQL.Add('order by editionid,PressSectionNumber');
    DataM1.Query1.open;
    While not DataM1.Query1.eof do
    begin
      L := FormNewChangepress.ListViewapply.items.add;
      L.Caption := tnames1.editionIDtoname(DataM1.Query1.fields[0].AsInteger);
      L.Subitems.Add(tnames1.SectionIDtoname(DataM1.Query1.fields[1].AsInteger));
      L.Subitems.Add(IntToStr(DataM1.Query1.fields[2].AsInteger));
      L.Subitems.Add(IntToStr(DataM1.Query1.fields[3].AsInteger));
      L.Checked := false;
      DataM1.Query1.next;
    end;
    DataM1.Query1.close;
    FormNewChangepress.orgplantype := 0;

    IF inpressruns <> '' then
    begin
      DataM1.Query1.SQL.Clear;
      DataM1.Query1.SQL.Add('Select distinct pressrunid from pagetable (NOLOCK)' );
      DataM1.Query1.SQL.Add('where productionid = ' + IntToStr(FormNewChangepress.Fromproductionid));
      DataM1.Query1.SQL.Add('and pressrunid IN ' + inpressruns);
      DataM1.Query1.open;
      While not DataM1.Query1.eof do
      begin
        For i := 0 to FormNewChangepress.ListViewapply.items.count-1 do
        begin
          IF DataM1.Query1.fields[0].AsString = FormNewChangepress.ListViewapply.items[i].SubItems[2] then
          begin
            FormNewChangepress.ListViewapply.items[i].Checked := true;
            break;
          end;
        end;
          DataM1.Query1.next;
      end;
      DataM1.Query1.close;
    end
    else
    begin
      For i := 0 to FormNewChangepress.ListViewapply.items.count-1 do
      begin
        FormNewChangepress.ListViewapply.items[i].Checked := true;
      end;
    end;
    result := true;
  Except
    result := false;
  end;
End;
Function TFormNewChangepress.Applychanges:Boolean;
Var
  newsecids  : String;
  newpagecounts : String;
  gotnewname : Boolean;
  Makenewprodonruns,foundexistingprod : Boolean;
  inpressruns,Planname,movedsectionids,markstr : String;
  I,pressid,newproductionid,Ncopiesinsection,NewrunCopyid : Longint;
  PreflightSetupID, InksaveSetupID, RipSetupID : Longint;
  Swappagepositions : Boolean;
Begin
  try
    try
      foundexistingprod := false;
      Makenewprodonruns := false;
      newproductionid := -1;
      inpressruns := '(-99';
      movedsectionids := '(-99';
      for i := 0 to FormNewChangepress.ListViewapply.Items.Count-1 do
      begin
        if FormNewChangepress.ListViewapply.Items[i].Checked then
        begin
          inpressruns := inpressruns + ',' + FormNewChangepress.ListViewapply.Items[i].SubItems[2];
          movedsectionids := movedsectionids + ',' + IntToStr(Tnames1.sectionnametoid(FormNewChangepress.ListViewapply.Items[i].SubItems[0]));
        end
        else
          Makenewprodonruns := true;
      end;
      inpressruns := inpressruns + ')';
      movedsectionids := movedsectionids + ')';
      pressid := FormNewChangepress.Topressid;
      DataM1.Query1.SQL.Clear;
      DataM1.Query1.SQL.Add('Select TOP 1 productionid from pagetable (NOLOCK) ');
      DataM1.Query1.SQL.Add('where pressid = '+IntToStr(FormNewChangepress.Topressid));
      DataM1.Query1.SQL.Add('and publicationid = ' + IntToStr(FormNewChangepress.Copypublicationid));
      DataM1.Query1.SQL.Add('and '+DataM1.makedatastr('',FormNewChangepress.Copypubdate));
      DataM1.Query1.Open;
      IF Not DataM1.Query1.eof then
      begin
        newproductionid := DataM1.Query1.fields[0].AsInteger;
        foundexistingprod := true;
        DataM1.Query1.Close;
        FormNewChangepress.Newplanname := tnames1.productionrunIDtoname(newproductionid);
        Planname := FormNewChangepress.Newplanname;
      end
      Else
      Begin
        DataM1.Query1.Close;
        FormNewChangepress.Newplanname := Formprodplan.createproductionname(FormNewChangepress.Copypublicationid,FormNewChangepress.Topressid,FormNewChangepress.Copypubdate);
        Planname := formprodplan.createproductionname(FormNewChangepress.Copypublicationid,
                                                    FormNewChangepress.Topressid,FormNewChangepress.Copypubdate);
      End;
      Formprodplan.EditProductionname.text := FormNewChangepress.Newplanname;
      IF Makenewprodonruns then
      begin
        newsecids  := '';
        newpagecounts := '';
        DataM1.Query1.SQL.Clear;
        DataM1.Query1.SQL.Add('Select distinct Sectionid from pagetable (NOLOCK) ');
        DataM1.Query1.SQL.Add('where pressrunid IN ' + inpressruns);
        DataM1.Query1.SQL.Add('and productionid = ' + IntToStr(FormNewChangepress.Fromproductionid));
        IF Prefs.debug then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'CPtopress1.sql');
        DataM1.Query1.Open;
        While not DataM1.Query1.eof do
        begin
          newsecids := newsecids + DataM1.Query1.fields[0].AsString+';';
          DataM1.Query2.SQL.Clear;
          DataM1.Query2.SQL.Add('Select count ( distinct pagename)  from pagetable (NOLOCK) ');
          DataM1.Query2.SQL.Add('where  productionid = ' + IntToStr(FormNewChangepress.Fromproductionid));
          DataM1.Query2.SQL.Add('And pressrunid IN ' + inpressruns);
          DataM1.Query2.SQL.Add('and sectionid = ' + DataM1.Query1.fields[0].AsString);
          IF Prefs.debug then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'CPtopress2.sql');
          DataM1.Query2.open;
          IF not DataM1.Query2.eof then
            newpagecounts := newpagecounts + DataM1.Query2.fields[0].AsString+';';
          DataM1.Query2.close;
          Ncopiesinsection := 1;
          DataM1.Query2.SQL.Clear;
          DataM1.Query2.SQL.Add('Select count ( distinct copynumber)  from pagetable (NOLOCK) ');
          DataM1.Query2.SQL.Add('where  productionid = ' + IntToStr(FormNewChangepress.Fromproductionid));
          DataM1.Query2.SQL.Add('And pressrunid IN ' + inpressruns);
          DataM1.Query2.SQL.Add('and sectionid = ' + DataM1.Query1.fields[0].AsString);
          IF Prefs.debug then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'CPtopress2.sql');
          DataM1.Query2.open;
          IF not DataM1.Query2.eof then
            Ncopiesinsection := DataM1.Query2.fields[0].AsInteger;
          DataM1.Query2.close;
          DataM1.Query1.next;
        end;

(*        IF (Ncopiesinsection = 1) and (CheckBoxOnly1copy.Checked) then
        begin
          MessageDlg('One or more sections only have one copy. Add copy  or move entire section' , mtInformation,[mbOk], 0);
          DataM1.Query1.close;
          result := false;
          Exit;
        end;
        DataM1.Query1.close;
         *)
        gotnewname := false;
        DataM1.Query1.SQL.Clear;
        DataM1.Query1.SQL.Add('Select TOP 1 name from ProductionNames (NOLOCK)');
        DataM1.Query1.SQL.Add('where name = ' +''''+Planname+'''');
        DataM1.Query1.open;
        gotnewname := DataM1.Query1.eof;
        DataM1.Query1.close;
        IF (not gotnewname) And (Not foundexistingprod) then
        begin
          i := 1;
          repeat
            inc(I);
            DataM1.Query1.SQL.Clear;
            DataM1.Query1.SQL.Add('Select TOP 1 name from ProductionNames (NOLOCK)');
            DataM1.Query1.SQL.Add('where name = ' +''''+Planname+ ' _ '+IntToStr(i)+'''');
            DataM1.Query1.open;
            gotnewname := DataM1.Query1.eof;
            DataM1.Query1.close;
          until (gotnewname) or (I > 20);
          Planname := Planname+ ' _ '+IntToStr(i);
        End;
        IF Not foundexistingprod then
        begin
          tNames1.Addname(9,Planname);
          newproductionid := tnames1.productionrunnametoid(Planname);
          DataM1.Query1.SQL.Clear;
        // DataM1.Query1.SQL.Add('Select * from ProductionNames (NOLOCK)');
          DataM1.Query1.SQL.Add('Select ProductionID ');
          DataM1.Query1.SQL.Add(',[Name]' );
          DataM1.Query1.SQL.Add(',[sections]' );
          DataM1.Query1.SQL.Add(',[pages]' );
          DataM1.Query1.SQL.Add(',[combined]' );
          DataM1.Query1.SQL.Add(',[bindingstyle] ' );
          DataM1.Query1.SQL.Add(',[collection]' );
          DataM1.Query1.SQL.Add(',[Plancreep]' );
          DataM1.Query1.SQL.Add(',[PlannedHold]' );
          DataM1.Query1.SQL.Add(',[PlannedApproval]' );
          DataM1.Query1.SQL.Add(',[PlanType]' );
          DataM1.Query1.SQL.Add(',[OrderNumber]' );
          DataM1.Query1.SQL.Add('FROM ProductionNames (NOLOCK)' );
          DataM1.Query1.SQL.Add('WHERE productionid =  ' + IntToStr(FormNewChangepress.Fromproductionid));
          DataM1.Query1.open;
          if not DataM1.Query1.Eof then
          begin
            DataM1.Query2.SQL.Clear;
            DataM1.Query2.SQL.Add('update productionnames  ');
            DataM1.Query2.SQL.Add('Set sections = ' + ''''+newsecids+'''');
            DataM1.Query2.SQL.Add(',pages = ' + ''''+newpagecounts+'''');
            DataM1.Query2.SQL.Add(',combined =  ' + DataM1.Query1.fields[4].AsString);
            DataM1.Query2.SQL.Add(',bindingstyle =  ' + DataM1.Query1.fields[5].AsString);
            DataM1.Query2.SQL.Add(',collection =  ' + DataM1.Query1.fields[6].AsString);
            DataM1.Query2.SQL.Add(',Plancreep =  ' + DataM1.Query1.fields[7].AsString);
            DataM1.Query2.SQL.Add(',PlannedHold =  ' + DataM1.Query1.fields[8].AsString);
            DataM1.Query2.SQL.Add(',PlannedApproval =  ' + DataM1.Query1.fields[9].AsString);
            DataM1.Query2.SQL.Add(',PlanType =  ' + DataM1.Query1.fields[10].AsString);
            DataM1.Query2.SQL.Add(',OrderNumber =  ' + ''''+DataM1.Query1.fields[11].AsString+'''');
            DataM1.Query2.SQL.Add('where productionid =  ' + IntToStr(newproductionid));
            IF Prefs.debug then datam1.Query2.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'CPtopress3.sql');
            DataM1.Query2.execsql;
          End;
          DataM1.Query1.close;
        End;
      end
      else
      begin
        inpressruns := '(-99';
        newproductionid := FormNewChangepress.Fromproductionid;
        DataM1.Query1.SQL.Clear;
        DataM1.Query1.SQL.Add('Select distinct pressrunid from pagetable (NOLOCK)');
        DataM1.Query1.SQL.Add('Where productionid = ' + IntToStr(FormNewChangepress.Fromproductionid) );
        DataM1.Query1.Open;
        While not DataM1.Query1.Eof do
        begin
          inpressruns := inpressruns +','+ DataM1.Query1.fields[0].AsString;
          DataM1.Query1.Next;
        end;
        DataM1.Query1.close;
        inpressruns := inpressruns +')';
      End;

      // NAN 20151013 begin
      // Detect if page positions must be swapped after layout change (2-up function only)
      Swappagepositions := false;
      for i := 1 to NPlatetemplateArray do
      begin
        if (PlatetemplateArray[i].TemplateID = FormNewChangepress.Totemplateid) then
        begin
          TotemplateListid := i;
          break;
        end;
      end;
      if (PlatetemplateArray[FromtemplateListid].NupOnplate = 2) AND (PlatetemplateArray[TotemplateListid].NupOnplate = 2) then
      begin
        if (PlatetemplateArray[TotemplateListid].PageRotationList[1] <> PlatetemplateArray[FromtemplateListid].PageRotationList[1]) and
                (PlatetemplateArray[TotemplateListid].PageRotationList[2] <> PlatetemplateArray[FromtemplateListid].PageRotationList[2]) then
            Swappagepositions := true;
      end;
      // NAN 20151013 end
        markstr := inittypes.marksIDstr(ToNmarks,Tomarks);
        DataM1.Query1.SQL.Clear;
        DataM1.Query1.SQL.Add('UPDATE pagetable SET pressid = ' + IntToStr(FormNewChangepress.Topressid) );
        DataM1.Query1.SQL.Add(',templateid = ' + IntToStr(FormNewChangepress.Totemplateid) );
        DataM1.Query1.SQL.Add(',markgroups = ' + ''''+markstr+'''' );
        DataM1.Query1.SQL.Add(',locationid = ' + IntToStr(FormNewChangepress.ToLocationid) );
        DataM1.Query1.SQL.Add(',deviceid = 0 ' );
        DataM1.Query1.SQL.Add(',productionid = ' + IntToStr(newproductionid));
        DataM1.Query1.SQL.Add(',FlatProofConfigurationID = ' + IntToStr(FormNewChangepress.ToFlatproofConfig) );
        DataM1.Query1.SQL.Add('WHERE productionid = ' + IntToStr(FormNewChangepress.Fromproductionid) );
        DataM1.Query1.SQL.Add('AND sectionid IN ' + movedsectionids);
        DataM1.Query1.SQL.Add('AND pressrunid IN ' + inpressruns);
        DataM1.Query1.SQL.Add('AND pressid = ' + IntToStr(FormNewChangepress.Frompressid)  );
        IF Prefs.debug then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'Moveprod.sql');
        formmain.trysql(DataM1.Query1);

        // NAN 20151013 begin
        if (Swappagepositions) then
        begin
              Datam1.Query1.SQL.Clear;
              Datam1.Query1.SQL.Add('UPDATE PageTable');
              Datam1.Query1.SQL.Add('SET pagepositions=''0'',pageposition=0');
              Datam1.Query1.SQL.Add('WHERE pagepositions=''1''');
              DataM1.Query1.SQL.Add('AND locationid = ' + IntToStr(FormNewChangepress.ToLocationid) );
              DataM1.Query1.SQL.Add('AND sectionid IN ' + movedsectionids);
              DataM1.Query1.SQL.Add('AND pressrunid IN ' + inpressruns);
              Datam1.Query1.SQL.Add('AND productionid = ' + IntToStr(newproductionid));
              Datam1.Query1.SQL.Add('AND pressid = ' + IntToStr(FormNewChangepress.Topressid));
              FormMain.trysql(Datam1.Query1);

              Datam1.Query1.SQL.Clear;
              Datam1.Query1.SQL.Add('UPDATE pagetable');
              Datam1.Query1.SQL.Add('SET pagepositions=''1'',pageposition=1');
              Datam1.Query1.SQL.Add('WHERE pagepositions=''2''');
              DataM1.Query1.SQL.Add('AND locationid = ' + IntToStr(FormNewChangepress.ToLocationid) );
              DataM1.Query1.SQL.Add('AND sectionid IN ' + movedsectionids);
              DataM1.Query1.SQL.Add('AND pressrunid IN ' + inpressruns);
              Datam1.Query1.SQL.Add('AND productionid = ' + IntToStr(newproductionid));
              Datam1.Query1.SQL.Add('AND pressid = ' + IntToStr(FormNewChangepress.Topressid));
              FormMain.trysql(Datam1.Query1);

              Datam1.Query1.SQL.Clear;
              Datam1.Query1.SQL.Add('UPDATE pagetable');
              Datam1.Query1.SQL.Add('SET pagepositions=''2'',pageposition=2');
              Datam1.Query1.SQL.Add('WHERE pagepositions=''0''');
              DataM1.Query1.SQL.Add('AND locationid = ' + IntToStr(FormNewChangepress.ToLocationid) );
              DataM1.Query1.SQL.Add('AND sectionid IN ' + movedsectionids);
              DataM1.Query1.SQL.Add('AND pressrunid IN ' + inpressruns);
              Datam1.Query1.SQL.Add('AND productionid = ' + IntToStr(newproductionid));
              Datam1.Query1.SQL.Add('AND pressid = ' + IntToStr(FormNewChangepress.Topressid));
              FormMain.trysql(Datam1.Query1);
        end;
        // NAN 20151013 end
        IF Not foundexistingprod then
        begin
          DataM1.Query1.SQL.Clear;
          DataM1.Query1.SQL.Add('update productionnames set Name = ' +''''+Planname+'''' );
          DataM1.Query1.SQL.Add('Where productionid = ' + IntToStr(newproductionid) );
          IF Prefs.debug then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'Moveplannameprod.sql');
          formmain.trysql(DataM1.Query1);
        End;
        DataM1.Query1.SQL.Clear;
        DataM1.Query1.SQL.Add('update pressrunid set PlanName = ' +''''+Planname+'''' );
        DataM1.Query1.SQL.Add('Where pressrunid IN ' + inpressruns );
        IF Prefs.debug then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'Moveplannamepresrunid.sql');
        formmain.trysql(DataM1.Query1);
        DataM1.Query1.SQL.Clear;
        IF formmain.differentremotefolder(FormNewChangepress.FromLocationID,FormNewChangepress.ToLocationid) then
          DataM1.Query1.SQL.Add('update pagetable set flatproofstatus = 0, deviceid = 0 , status = 10, InkStatus = 0 where status > 10')
        Else
          DataM1.Query1.SQL.Add('update pagetable set flatproofstatus = 0, deviceid = 0 , status = 30, InkStatus = 0 where status > 30');
        DataM1.Query1.SQL.Add('and productionid = ' + IntToStr(newproductionid));
        DataM1.Query1.SQL.Add('and pressrunid IN ' + inpressruns );
        DataM1.Query1.SQL.Add('and sectionid IN ' + movedsectionids);
        if (Prefs.Debug) then DataM1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'Movestatprod.sql');
        formmain.trysql(DataM1.Query1);
        IF Makenewprodonruns then
        begin
          newsecids  := '';
          newpagecounts := '';
          DataM1.Query1.SQL.Clear;
          DataM1.Query1.SQL.Add('Select distinct Sectionid from pagetable  (NOLOCK)');
          DataM1.Query1.SQL.Add('where productionid = ' + IntToStr(FormNewChangepress.Fromproductionid));
          DataM1.Query1.open;
          While not DataM1.Query1.eof do
          begin
            newsecids := newsecids + DataM1.Query1.fields[0].AsString+';';
            DataM1.Query2.SQL.Clear;
            DataM1.Query2.SQL.Add('Select count ( distinct pagename)  from pagetable  (NOLOCK)');
            DataM1.Query2.SQL.Add('where  productionid = ' + IntToStr(FormNewChangepress.Fromproductionid));
            DataM1.Query2.SQL.Add('and sectionid = ' + DataM1.Query1.fields[0].AsString);
            DataM1.Query2.open;
            IF not DataM1.Query2.eof then
              newpagecounts := newpagecounts + DataM1.Query2.fields[0].AsString+';';
            DataM1.Query2.Close;
            DataM1.Query1.Next;
          end;
          DataM1.Query1.Close;
          DataM1.Query2.SQL.Clear;
          DataM1.Query2.SQL.Add('UPDATE ProductionNames  ');
          DataM1.Query2.SQL.Add('SET Sections = ' + ''''+newsecids+'''');
          DataM1.Query2.SQL.Add(',Pages = ' + ''''+newpagecounts+'''');
          DataM1.Query2.SQL.Add('WHERE ProductionID =  ' + IntToStr(FormNewChangepress.Fromproductionid));
          DataM1.Query2.ExecSQL;
          Resetpaginaandpresssectionnum(FormNewChangepress.Fromproductionid,FormNewChangepress.Frompressid);
          Resetpaginaandpresssectionnum(newproductionid,FormNewChangepress.topressid);
          if (Prefs.ForcePlanToApplied) then
          begin
            DataM1.Query1.SQL.Clear;
            DataM1.Query1.SQL.Add('UPDATE productionnames SET PlanType = 1 WHERE ProductionID = ' + IntToStr(newproductionid) );
            DataM1.Query1.ExecSQL;
          end
          else
          begin
            DataM1.Query1.SQL.Clear;
            DataM1.Query1.SQL.Add('UPDATE productionnames SET PlanType = '+IntToStr(orgplantype)+' WHERE ProductionID = ' + IntToStr(newproductionid) );
            DataM1.Query1.ExecSQL;
          end;
        end;
        PreflightSetupID := 0;
        InksaveSetupID := 0;
        RipSetupID := 0;
        if (ComboBoxRipSetup.Text <> '') and (ComboBoxInksave.Text <> '') and (ComboBoxPreflight.Text <> '') then
        begin
          if (UTypes.PreflightSetupNamesPossible = true) then
          begin
            DataM1.Query1.SQL.Clear;
            DataM1.Query1.SQL.Add('SELECT PreflightSetupID FROM PreflightSetupNames WHERE Name='''+ComboBoxPreflight.Text+'''');
            DataM1.Query1.Open;
            if not DataM1.Query1.eof then
              PreflightSetupID := DataM1.Query1.Fields[0].AsInteger;
            DataM1.Query1.Close;
          end;
          if (UTypes.InksaveSetupNamesPossible = true) then
          begin
            DataM1.Query1.SQL.Clear;
            DataM1.Query1.SQL.Add('SELECT InksaveSetupID FROM InkSaveSetupNames WHERE Name='''+ComboBoxInksave.Text+'''');
            DataM1.Query1.Open;
            if not DataM1.Query1.eof then
            InksaveSetupID := DataM1.Query1.Fields[0].AsInteger;
            DataM1.Query1.Close;
          end;

          DataM1.Query1.SQL.Clear;
          DataM1.Query1.SQL.Add('SELECT RipSetupID FROM RipSetupNames WHERE Name='''+ComboBoxRipSetup.Text+'''');
          DataM1.Query1.open;
          if not DataM1.Query1.eof then
            RipSetupID := DataM1.Query1.Fields[0].AsInteger;
          DataM1.Query1.close;
          RipSetupID := RipSetupID + (PreflightSetupID *256) + (InksaveSetupId*256*256);
          if (UTypes.RipSetupIDInPageTable) then
          begin
            DataM1.Query1.SQL.Clear;
            DataM1.Query1.SQL.Add('UPDATE PageTable SET RipSetupID = '+IntToStr(RipSetupID)+' WHERE ProductionID = ' + IntToStr(newproductionid) );
            DataM1.Query1.ExecSQL;
          end;
          if (UTypes.AutoRetryQueueFileCenterPossible) AND (CheckBoxReprocessPags.Checked) then
          begin
            DataM1.Query1.SQL.Clear;
            DataM1.Query1.SQL.Add('INSERT INTO AutoRetryQueueFileCenter SELECT '+IntToStr(newproductionid)+',0,'''',GETDATE()');
            DataM1.Query1.ExecSQL;
          end;
        end;
        result := true;
      //End;
    Except
      result := false;
    End;
  finally
    formmain.Setplanlock(false);
  End;
End;

Procedure TFormNewChangepress.Resetpaginaandpresssectionnum(aproductionid : Longint;
                                                            Apressid      : Longint);
Var
  Akteditionid : Longint;
  NRuns,i : Longint;
  Lowpresssec,seqnum,lowpag : Longint;
  Runs : Array[1..500] of record
                            Pressrunid : Longint;
                            PressSectionNumber : Longint;
                            editionid : Longint;
                            Sectionid : Longint;
                            Lpagina : Longint;
                            Lplatename : String;
                          end;
begin
  try
    DataM1.Query2.SQL.Clear;
    DataM1.Query2.SQL.Add('Select distinct pressrunid,sectionid,PressSectionNumber,editionid from pagetable (NOLOCK)');
    DataM1.Query2.SQL.Add('where productionid =  ' + IntToStr(aproductionid));
    DataM1.Query2.SQL.Add('And pressid =  ' + IntToStr(Apressid));
    DataM1.Query2.SQL.Add('order by PressSectionNumber');
    nruns := 0;
    DataM1.Query2.Open;
    While not DataM1.Query2.eof do
    begin
      Inc(nruns);
      runs[nruns].Pressrunid := DataM1.Query2.Fields[0].AsInteger;
      runs[nruns].Sectionid := DataM1.Query2.Fields[1].AsInteger;
      runs[nruns].PressSectionNumber := DataM1.Query2.Fields[2].AsInteger;
      runs[nruns].editionid := DataM1.Query2.Fields[3].AsInteger;
      DataM1.Query2.Next;
    end;
    DataM1.Query2.Close;

    for i := 1 to nruns do
    begin
    (*
      DataM1.Query2.SQL.Clear;
      DataM1.Query2.SQL.Add('Select  MIN(pagination) from pagetable (NOLOCK)');
      DataM1.Query2.SQL.Add('where productionid =  ' + IntToStr(aproductionid));
      DataM1.Query2.SQL.Add('And pressrunid =  ' + IntToStr(runs[i].Pressrunid));
      DataM1.Query2.SQL.Add('And Sectionid =  ' + IntToStr(runs[i].Sectionid));
      DataM1.Query2.open;
      IF not DataM1.Query2.eof then
      begin
        runs[i].Lpagina := DataM1.Query2.fields[0].AsInteger;
      End
      Else
        runs[i].Lpagina := 1;
      DataM1.Query2.close;
      *)
      (*
      DataM1.Query2.SQL.Clear;
      DataM1.Query2.SQL.Add('Select  MIN(platename) from pagetable (NOLOCK)');
      DataM1.Query2.SQL.Add('where productionid =  ' + IntToStr(aproductionid));
      DataM1.Query2.SQL.Add('And pressrunid =  ' + IntToStr(runs[i].Pressrunid));
      DataM1.Query2.SQL.Add('And Sectionid =  ' + IntToStr(runs[i].Sectionid));
      DataM1.Query2.open;
      IF not DataM1.Query2.eof then
      begin
        runs[i].Lplatename := DataM1.Query2.fields[0].Asstring;
      End
      Else
        runs[i].Lplatename := '';
      DataM1.Query2.close;
      *)
    end;
    Akteditionid := -1;
    Lowpresssec := 1;
    lowpag := 1;
    seqnum := 0;
    For i := 1 to nruns do
    begin
      Inc(seqnum);
      DataM1.Query2.SQL.Clear;
      DataM1.Query2.SQL.Add('update pagetable set ');
      DataM1.Query2.SQL.Add('PressSectionNumber =  ' + IntToStr(seqnum));
      DataM1.Query2.SQL.Add('where productionid =  ' + IntToStr(aproductionid));
      DataM1.Query2.SQL.Add('And pressrunid =  ' + IntToStr(runs[i].Pressrunid));
      DataM1.Query2.SQL.Add('And Sectionid =  ' + IntToStr(runs[i].Sectionid));
      DataM1.Query2.SQL.Add('And pressid =  ' + IntToStr(Apressid));
      DataM1.Query2.ExecSQL;
      DataM1.Query2.SQL.Clear;
      DataM1.Query2.SQL.Add('update pressrunid set ');
      DataM1.Query2.SQL.Add('SequenceNumber =  ' + IntToStr(seqnum));
      DataM1.Query2.SQL.Add('where pressrunid =  ' + IntToStr(runs[i].Pressrunid));
      DataM1.Query2.ExecSQL;

    End;

  except
  end;
end;

procedure TFormNewChangepress.ListViewapplyChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
  if FormNewChangepress.showing then
  begin
    setokbottun;
  end;
end;

procedure TFormNewChangepress.setokbottun;
Var
  I : Longint;
  ISsel : Boolean;
Begin
  ISsel := false;
  for i := 0 to ListViewapply.items.count-1 do
  begin
    IF ListViewapply.items[i].Checked then
    begin
      iSsel := true;
      break;
    end;
  end;
  (*ToNmarks
  Tomarks
  *)
  BitBtn3.enabled := (iSsel) and (ComboBoxlocation.ItemIndex > -1) and (ComboBoxpress.ItemIndex > -1) and (ComboBoxTemplate.ItemIndex > -1);
End;


end.
