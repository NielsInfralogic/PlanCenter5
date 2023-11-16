unit UCopyPlanTopress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFormCopytopress = class(TForm)
    Panel1: TPanel;
    BitBtn3: TBitBtn;
    BitBtn1: TBitBtn;
    Panel2: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Panel3: TPanel;
    GroupBox2: TGroupBox;
    ComboBoxpress: TComboBox;
    GroupBox1: TGroupBox;
    ComboBoxTemplate: TComboBox;
    GroupBox5: TGroupBox;
    ComboBoxlocation: TComboBox;
    GroupBox4: TGroupBox;
    ComboBoxFlatproof: TComboBox;
    GroupBoxRipSetup: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ComboBoxPreflight: TComboBox;
    ComboBoxInksave: TComboBox;
    CheckBoxReprocessPags: TCheckBox;
    ComboBoxRipSetup: TComboBox;
    CheckBoxpressspecifik: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ComboBoxpressChange(Sender: TObject);
    procedure ComboBoxTemplateChange(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure ComboBoxlocationChange(Sender: TObject);
  private
    { Private declarations }
    activated : Boolean;
    procedure setPresses;
    Procedure setTemplates;

  public
    Simplecopy : Boolean;
    ToLocationid : Longint;
    Topressid : Longint;
    Toproductionid : Longint;
    Totemplateid : Longint;
    TotemplateListid : Longint;
    ToFlatproofid : Longint;
    ToFlatproofConfig : Longint;

    fromlocationid : Longint;
    Copypublicationid : Longint;
    Copypubdate : Tdatetime;
    Newplanname : String;
    Frompressid : Longint;
    Fromproductionid : Longint;
    FromNup,toNup : Longint;
    Fromtemplateid : Longint;
    FromtemplateListid : Longint;
    fromFlatproofid : Longint;
    Fromwaitforapproval : Boolean;
    procedure initialize;
    procedure applycopydata;
    procedure setthedefaults;
    procedure setnewtemplateidinplan;

  end;

var
  FormCopytopress: TFormCopytopress;

implementation

uses Usettings, Umain,uprodplan,utypes,uplanframe, Udata, Uflatproof,
  UApplyplan, UUtils;

{$R *.dfm}

procedure TFormCopytopress.FormCreate(Sender: TObject);
begin
  activated := false;
end;

procedure TFormCopytopress.FormActivate(Sender: TObject);
Begin
  initialize;
  activated := true;
End;

procedure TFormCopytopress.initialize;

Var
  I : longint;
  RipSetupID,PreflightID,InksaveID : Longint;
  PreflightName,InksaveName,RipSetupName : string;
begin

  (*IF foxrmsettings.CheckBoxenablespecifiksel.Checked then
  begin
    GroupBoxspecik.Visible := true;
    CheckBoxpressspecifik.Checked := foxrmsettings.CheckBoxpressspecifik.Checked;
  end;  *)

  IF not  activated then
  begin
    activated := true;
  end;
  BitBtn3.enabled := false;

  CheckBoxpressspecifik.Checked := Prefs.EnablePressSpecificSelection;

  ComboBoxripsetup.items.Clear;
  DataM1.Query1.close;
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('Select distinct Name from RipSetupNames Order by name' );
  DataM1.Query1.open;
  While not DataM1.Query1.eof do
  begin
    ComboBoxripsetup.items.add(DataM1.Query1.fields[0].asstring);
    DataM1.Query1.next;
  end;
  DataM1.Query1.close;

  ComboBoxPreflight.Items.clear;
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.add('Select Name from PreflightSetupNames Order by Name');
  DataM1.Query1.open;
  While not DataM1.Query1.eof do
  begin
    ComboBoxPreflight.Items.add(DataM1.Query1.fields[0].asstring);
    DataM1.Query1.next;
  end;
  DataM1.Query1.close;
  ComboBoxPreflight.Itemindex := 0;

  ComboBoxInksave.Items.clear;
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.add('Select Name from InksaveSetupNames Order by Name');
  DataM1.Query1.open;
  While not DataM1.Query1.eof do
  begin
    ComboBoxInksave.Items.add(DataM1.Query1.fields[0].asstring);
    DataM1.Query1.next;
  end;
  DataM1.Query1.close;
  ComboBoxInksave.Itemindex := 0;

  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('Select TOP 1 templateid from pagetable WITH (NOLOCK) ' );
  DataM1.Query1.SQL.Add('where productionid =  ' + inttostr(fromproductionid));
  DataM1.Query1.Open;

  IF not DataM1.Query1.Eof then
    fromtemplateid := DataM1.Query1.fields[0].asinteger;
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
  DataM1.Query1.SQL.Add('Select TOP 1 FlatProofConfigurationID from pagetable WITH (NOLOCK) ' );
  DataM1.Query1.SQL.Add('where productionid =  ' + IntToStr(fromproductionid));
  DataM1.Query1.Open;

  IF not DataM1.Query1.Eof then
  Begin
    ToFlatproofConfig := DataM1.Query1.fields[0].AsInteger;
    fromFlatproofid := DataM1.Query1.fields[0].AsInteger;
    Fromwaitforapproval := fromFlatproofid and 2 = 2;
    fromFlatproofid := fromFlatproofid SHR 8;
  End;
  DataM1.Query1.Close;
  ComboBoxFlatproof.Items.Clear;

  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('Select ProofName from FlatProofConfigurations');
  DataM1.Query1.SQL.Add('Order by ProofName ');
  DataM1.Query1.Open;
  ComboBoxFlatproof.Items.Add('Off');
  While not DataM1.Query1.Eof do
  begin
    ComboBoxFlatproof.Items.Add(DataM1.Query1.Fields[0].AsString);
    DataM1.Query1.Next;
  end;
  DataM1.Query1.Close;

  ComboBoxFlatproof.Itemindex := 0;
  IF fromFlatproofid > 0 then
  begin
    ComboBoxFlatproof.Itemindex := ComboBoxFlatproof.Items.IndexOf(tnames1.FlatProofConfigurationIDtoname(fromFlatproofid));
  end;
  IF ComboBoxFlatproof.Itemindex < 0 then
    ComboBoxFlatproof.Itemindex := 0;

  ComboBoxlocation.Items := tnames1.locationnames;
  ComboBoxlocation.Itemindex := ComboBoxlocation.Items.IndexOf(tnames1.locationIDtoname(fromlocationid));
  setPresses;
  setTemplates;
  IF (Prefs.PlanningUsePublicationDefaults) then
  begin
    setthedefaults;
  end;

  RipSetupID := 0;
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('Select TOP 1 RipSetupID from PageTable WITH (NOLOCK)' );
  DataM1.Query1.SQL.Add('where Productionid =  ' + IntToStr(fromproductionid));
  DataM1.Query1.Open;
  if not DataM1.Query1.Eof then
  begin
    RipSetupID := DataM1.Query1.fields[0].AsInteger;
  end;
  DataM1.Query1.Close;

  InkSaveID := RipSetupID DIV 65536;

  RipSetupID :=  RipSetupID - (InkSaveID*65536);

  PreflightID := RipSetupID DIV 256;
  RipSetupID :=  RipSetupID - (PreflightID*256);


  PreflightName := '';
  if (UTypes.PreflightSetupNamesPossible = true) then
  begin
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('Select Name from PreflightSetupNames WHERE PreflightSetupID='+inttostr(PreflightID));
    DataM1.Query1.Open;
    if not DataM1.Query1.Eof then
      PreflightName := DataM1.Query1.fieldbyname('Name').AsString;
    DataM1.Query1.Close;
  end;

  if (PreflightName <> '') then
    ComboBoxPreflight.Itemindex := ComboBoxPreflight.Items.IndexOf(PreflightName);

  InkSaveName := '';
  if (UTypes.InkSaveSetupNamesPossible = true) then
  begin
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('Select Name from InksaveSetupNames WHERE InksaveSetupID='+inttostr(InkSaveID));
    DataM1.Query1.Open;
    if not DataM1.Query1.Eof then
      InkSaveName := DataM1.Query1.Fields[0].AsString;
    DataM1.Query1.Close;
  end;
  if (InkSaveName <> '') then
    ComboBoxInksave.Itemindex := ComboBoxInksave.Items.IndexOf(InkSaveName);

  RipSetupName := '';
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('Select Name from RipSetupNames WHERE RipSetupID='+IntToStr(RipSetupID));
  DataM1.Query1.Open;
  if not DataM1.Query1.Eof then
    RipSetupName := DataM1.Query1.Fields[0].AsString;
  DataM1.Query1.Close;

  if (RipSetupName <> '') then
    ComboBoxRipSetup.Itemindex := ComboBoxRipSetup.Items.IndexOf(RipSetupName);

  // ## NAN TODO
  // Set RIpSetup from PublicationTemplate defaults

  BitBtn3.enabled :=  (ComboBoxlocation.Itemindex > -1) and (ComboBoxpress.Itemindex > -1) and (ComboBoxTemplate.Itemindex > -1);

end;


procedure TFormCopytopress.ComboBoxpressChange(Sender: TObject);
var
  I : longint;
  pressidch : Longint;
begin
  IF (ComboBoxpress.items.count > 0) and (ComboBoxpress.itemindex > -1) then
  begin
    setTemplates;
  end;
  BitBtn3.enabled :=  (ComboBoxlocation.Itemindex > -1) and (ComboBoxpress.Itemindex > -1) and (ComboBoxTemplate.Itemindex > -1);
end;

procedure TFormCopytopress.ComboBoxTemplateChange(Sender: TObject);
begin
  BitBtn3.enabled :=  (ComboBoxlocation.Itemindex > -1) and (ComboBoxpress.Itemindex > -1) and (ComboBoxTemplate.Itemindex > -1);
end;

procedure TFormCopytopress.setnewtemplateidinplan;
Begin
End;



procedure TFormCopytopress.BitBtn3Click(Sender: TObject);
Begin
  FormCopytopress.applycopydata;
End;

procedure TFormCopytopress.applycopydata;
Var
  i : Longint;
  Swappagepositions : boolean;
begin
  Topressid := tnames1.pressnametoid(ComboBoxpress.text);
  Tolocationid := tnames1.locationnametoid(ComboBoxlocation.text);
  FormApplyproduction.CheckBoxpressspecifik.Checked := CheckBoxpressspecifik.Checked;
  For i := 1 to NPlatetemplateArray do
  begin
    if PlatetemplateArray[i].TemplateName = ComboBoxTemplate.text then
    begin
      Totemplateid := PlatetemplateArray[i].TemplateID;
      TotemplateListid := i;
      toNup := PlatetemplateArray[i].NupOnplate;
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
end;

procedure TFormCopytopress.setPresses;
Var
  I : Longint;
  ntempls : Longint;

Begin
  ComboBoxpress.items.Clear;
  ComboBoxTemplate.enabled := true;

  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('Select distinct PressName from pressnames ' );
  DataM1.Query1.SQL.Add('where pressid <>  ' + inttostr(frompressid));
  DataM1.Query1.SQL.Add('and locationid = ' + inttostr(tnames1.locationnametoid(ComboBoxlocation.text) ));
  DataM1.Query1.SQL.Add('order by PressName');
  DataM1.Query1.open;
  While not DataM1.Query1.eof do
  begin
    ComboBoxpress.items.add(DataM1.Query1.fields[0].asstring);
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


Procedure TFormCopytopress.setTemplates;
Var
  I : Longint;
//  ntempls : Longint;

Begin
  ComboBoxTemplate.items.Clear;
  ComboBoxTemplate.enabled := true;

  FromNup := PlatetemplateArray[FromtemplateListid].NupOnplate;
  For i := 1 to NPlatetemplateArray do
  begin
    if (*(PlatetemplateArray[i].NupOnplate = FromNup) and*)
       (PlatetemplateArray[i].PressID = tnames1.pressnametoid(ComboBoxpress.text)) and
       (i <> FromtemplateListid) then
       ComboBoxTemplate.items.add(PlatetemplateArray[i].TemplateName);
  end;

  if (Prefs.PlanningUsePublicationDefaults) then
  begin
    setthedefaults;
  end;

  IF ComboBoxTemplate.items.count > 0 then
  Begin
    ComboBoxTemplate.itemindex := 0;
    BitBtn3.enabled := true;
  End
  Else
    BitBtn3.enabled := false;

End;

procedure TFormCopytopress.ComboBoxlocationChange(Sender: TObject);
begin
  setPresses;
  setTemplates;
  BitBtn3.enabled :=  (ComboBoxlocation.Itemindex > -1) and (ComboBoxpress.Itemindex > -1) and (ComboBoxTemplate.Itemindex > -1);
end;

procedure TFormCopytopress.setthedefaults;
Var
  I,nyI, pos, pos2 : Longint;
  T,t1, t2,t3 : String;
Begin

  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('Select distinct PT.TemplateID,PT.RipSetup,T.TemplateName from PublicationTemplates PT,TemplateConfigurations T ' );
  DataM1.Query1.SQL.Add('where PT.pressid =  ' + inttostr(tnames1.pressnametoid(ComboBoxpress.text)));
  DataM1.Query1.SQL.Add('and PT.publicationid = ' + inttostr(Copypublicationid));
  DataM1.Query1.SQL.Add('and PT.TemplateID = T.TemplateID');

  IF Prefs.debug then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'getpubloutdef.sql');

  DataM1.Query1.open;

  nyI := -1;
  IF Not DataM1.Query1.eof then
  begin
    t := DataM1.Query1.fields[2].asstring;
    For i := 0 to ComboBoxTemplate.Items.count-1 do
    begin
      IF ComboBoxTemplate.Items[i] = t then
      begin
        totemplateListid := inittypes.gettemplatenumberfromID(DataM1.Query1.fields[0].asinteger);
        ComboBoxTemplate.Itemindex := i;
        break;
      end;
    End;

    t := DataM1.Query1.fields[1].asstring;
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
          ComboBoxripsetup.Itemindex := i;
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
          ComboBoxPreflight.Itemindex := i;
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
          ComboBoxInksave.Itemindex := i;
          break;
        end;
      End;
    end;

  end;
  DataM1.Query1.close;

  BitBtn3.enabled :=  (ComboBoxlocation.Itemindex > -1) and (ComboBoxpress.Itemindex > -1) and (ComboBoxTemplate.Itemindex > -1);

End;

end.
