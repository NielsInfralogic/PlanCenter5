unit Uloadpressplan;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, system.UITypes,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, PBExListview, Vcl.Mask, Menus,
  CheckLst, ULoadPlanSelectSecEdit, ULoadDlls;
type
  TFormloadpressplan = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel3: TPanel;
    Image2: TImage;
    Label7: TLabel;
    Label8: TLabel;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label1: TLabel;
    RadioGroupApproval: TRadioGroup;
    RadioGrouplocked: TRadioGroup;
    ComboBoxpublication: TComboBox;
    ComboBoxtemplate: TComboBox;
    Panel2: TPanel;
    GroupBoxFilter: TGroupBox;
    CheckBoxshowall: TCheckBox;
    ComboBoxpublfilt: TComboBox;
    Label5: TLabel;
    Label10: TLabel;
    GroupBox1: TGroupBox;
    ListBoxpresstemplatename: TListBox;
    ComboBoxNpage: TComboBox;
    Editpriority: TEdit;
    UpDown1: TUpDown;
    Label12: TLabel;
    Button1: TButton;
    Panel4: TPanel;
    PBExListview1: TPBExListview;
    Panel5: TPanel;
    Buttonedit: TButton;
    PopupMenu1: TPopupMenu;
    changesectionname1: TMenuItem;
    Changeeditionname1: TMenuItem;
    ListViewbefore: TListView;
    Button2: TButton;
    Loadfromproduction1: TMenuItem;
    Changeoffset1: TMenuItem;
    CheckBoxoffsetinsreted: TCheckBox;
    CheckBoxusecurprod: TCheckBox;
    CheckBoxignoreplanedition: TCheckBox;
    Splitter1: TSplitter;
    Button3: TButton;
    Panelonlynonepro: TPanel;
    Label6: TLabel;
    Label13: TLabel;
    DateTimePickerdeadtime: TDateTimePicker;
    DateTimePickerdeadlinedate: TDateTimePicker;
    EditCopies: TEdit;
    UpDownCopies: TUpDown;
    CheckBoxAllowunplannedcolors: TCheckBox;
    ComboBoxstackpos: TComboBox;
    CheckBoxChangecopies: TCheckBox;
    GroupBoxRipSetup: TGroupBox;
    ComboBoxRipSetup: TComboBox;
    GroupBoxPreflightsetup: TGroupBox;
    ComboBoxPreflightsetup: TComboBox;
    GroupBoxColorCompsetup: TGroupBox;
    ComboBoxColorCompsetup: TComboBox;
    ListViewplans: TListView;
    CheckBoxApplyonlyplannedcolors: TCheckBox;
    Label2: TLabel;
    Label14: TLabel;
    DateTimePicker1loadplan: TDateTimePicker;
    Editweek: TEdit;
    UpDownweek: TUpDown;
    Label3: TLabel;
    Editplanname: TEdit;
    Label11: TLabel;
    Editcreep: TEdit;
    ComboBoxEditionSelection: TComboBox;
    Label9: TLabel;
    PopupMenuEditPlanName: TPopupMenu;
    PopupEditPlanName: TMenuItem;
    PopupDeletePlan: TMenuItem;
    CheckBoxOnlyShowDefaultPressPublications: TCheckBox;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DateTimePicker1loadplanChange(Sender: TObject);
    procedure ComboBoxpublicationChange(Sender: TObject);
    procedure ComboBoxpresstemplatenameChange(Sender: TObject);
    procedure ListBoxpresstemplatenameClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CheckBoxshowallClick(Sender: TObject);
    procedure ComboBoxpublfiltChange(Sender: TObject);
    procedure ComboBoxNpageChange(Sender: TObject);
    procedure EditcreepExit(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ButtoneditClick(Sender: TObject);
    procedure changesectionname1Click(Sender: TObject);
    procedure Changeeditionname1Click(Sender: TObject);
    procedure EditweekChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckBoxChangecopiesClick(Sender: TObject);
    procedure Changeoffset1Click(Sender: TObject);
    procedure CheckBoxusecurprodClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ComboBoxtemplateChange(Sender: TObject);
    procedure SetEditionCombo;
    procedure ComboBoxEditionSelectionChange(Sender: TObject);
    procedure PopupEditPlanNameClick(Sender: TObject);
    procedure PopupDeletePlanClick(Sender: TObject);
    procedure FillPublicationCombo();
    procedure SetPublicationSpecificTemplate();
    procedure SetPublicationSpecificPriority();
    procedure CheckBoxOnlyShowDefaultPressPublicationsClick(Sender: TObject);
  private
    { Private declarations }
    activated : boolean;
    isFIllingPublicationCombo : boolean;
    Procedure Setdeadl;
    Procedure setlistdata;
    procedure setapplysec;
    procedure setapplyeds;
    Procedure loadAvailplans;
    procedure Checkifready;
    Procedure loadplanlist;
    Procedure setposibletemplates(ShowAll:Boolean);
    Procedure makeplanname;
{    Function DateOfWeek(Year : Word;
                                       Week : Word;
                                       DayOfWeek : Word;
                                       Var Day : Word;
                                       Var Month : Word):Longint;}

  public
    Platetempldbversion : Longint;
    Applingtoplan : Boolean;
    partialoffstart :  longint;
    Itspartial : Boolean;
    UsingProddata : Boolean;
    Partialloadpublication : String;
    NumberOfEditionsInProd : Longint;
    EditionsInProd : Array[1..100] of longint;
    Insertedplan : boolean;
    NEdchanges : Longint;
    Edchanges : array[1..100] of record
                                   fromed : Longint;
                                   toed   : Longint;
                                 end;
    editionlist : String;
    sectionlist : string;
    maxpages : Longint;
    TotalPages : Integer;
    defaultpublid : Longint;
    selectedplanid : Integer;
    selectedpressID : Integer;
    deadline : tdatetime;
    creep : Double;
    Applytopublid : Longint;
    Applytopprodname : String;
    Applytodate : tdatetime;
    Sectionschanged : boolean;
    Editionchanged : boolean;
    Offsetchanged  : Boolean;
    procedure autosetCurrentproddata;
    procedure Autosetifone;
    procedure init;
    { Public declarations }
  end;
var
  Formloadpressplan: TFormloadpressplan;
implementation
{$R *.dfm}
Uses
  utypes,DateUtils,udata,umain, Usettings,UPlanframe, UApplyplan,
  Uprodplan, Unewpubl, Ulogin, Ueditplan, USecbyload, Uhangeednamebyload,
  Ueditplannames, Ueditionorder, Ueditatextcombo, UUtils;

function LeadingZeroes(const aNumber, Length : integer) : string;
begin
  result := SysUtils.Format('%.*d', [Length, aNumber]) ;
end;
procedure TFormloadpressplan.Autosetifone;
Var
  secid,i : Integer;
  Nsecs   : Integer;
  Neds : Integer;
  edid : Integer;
Begin
  Nsecs := 0;
  secid := 0;
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('Select distinct Sectionid from pagetable (nolock) ');
  DataM1.Query1.SQL.Add('where publicationid = ' + IntToStr(tnames1.publicationnametoid(ComboBoxpublication.Text)));
  DataM1.Query1.SQL.Add('and productionid = '+IntToStr(plateframesproductionid));
//  DataM1.Query1.SQL.add(' and '+  DataM1.makedatastr('', ));
  DataM1.Query1.Open;
  while not DataM1.Query1.eof do
  begin
    Inc(Nsecs);
    if (Nsecs = 1) then
      secid := DataM1.Query1.Fields[0].AsInteger;
    DataM1.Query1.Next;
  end;
  DataM1.Query1.Close;
  if Nsecs = 1 then
  Begin
    For i := 0 to PBExListview1.items.count-1 do
    Begin
      PBExListview1.items[i].SubItems[1] := tnames1.sectionIDtoname(secid);
    end;
    Sectionschanged := true;
  end;

  //
  Neds := 0;
  edid := 0;
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('Select distinct Editionid from pagetable (nolock) ');
  DataM1.Query1.SQL.Add('where publicationid = ' + IntToStr(tnames1.publicationnametoid(ComboBoxpublication.Text)));
  DataM1.Query1.SQL.Add('and productionid = '+IntToStr(plateframesproductionid));
//  DataM1.Query1.SQL.add(' and '+  DataM1.makedatastr('', ));
  DataM1.Query1.Open;
  while not DataM1.Query1.eof do
  begin
    Inc(Neds);
    if (Neds = 1) then
      edid := DataM1.Query1.Fields[0].AsInteger;
    DataM1.Query1.Next;
  end;
  DataM1.Query1.Close;
  if Neds = 1 then
  Begin
    For i := 0 to PBExListview1.items.count-1 do
    Begin
      PBExListview1.items[i].SubItems[0] := tnames1.EditionIDtoname(edid);
    end;
    editionchanged := true;
  end;

end;

procedure  TFormloadpressplan.FillPublicationCombo();
begin
  isFIllingPublicationCombo := true;
  ComboBoxpublication.Items.Clear;

  if (CheckBoxOnlyShowDefaultPressPublications.Checked) and (selectedpressID > 0) then
  begin
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('SELECT DISTINCT [Name] FROM PublicationNames WHERE DefaultTemplateID=' + IntToStr(selectedpressID));
    DataM1.Query1.SQL.Add('ORDER BY [Name]');
    DataM1.Query1.Open;
    While not DataM1.Query1.Eof do
    begin
      ComboBoxpublication.Items.Add( DataM1.Query1.Fields[0].AsString);
      DataM1.Query1.Next;
    end;
    DataM1.Query1.Close;
  end
  else
    ComboBoxpublication.Items := tNames1.publicationnames;
  isFIllingPublicationCombo := false;
end;

procedure TFormloadpressplan.Init();
Var
  deadl : Tdatetime;
  Year, Month, Day: Word;
//  i : Longint;
begin
  creep := 0;
  isFIllingPublicationCombo := false;
  DateTimePicker1loadplan.enabled := true;
  ComboBoxpublication.enabled := true;
  editcreep.text := '0';
  CheckBoxOnlyShowDefaultPressPublications.Checked := Prefs.PlanningOnlyShowDefaultPressPublications;
  FillPublicationCombo();
//  ComboBoxpublication.Items.Clear;
//  ComboBoxpublication.Items := tNames1.publicationnames;
  Platetempldbversion := 1;
  Editplanname.enabled := false;
  DateTimePicker1loadplan.Datetime := now;
  DateTimePicker1loadplan.Datetime := IncDay(DateTimePicker1loadplan.Datetime,1);
  if itspartial then
    DateTimePicker1loadplan.Datetime := Applytodate;
  // Set default pubdate from current selection in tree
  if formmain.TreeViewplan.Selected <> nil then
  begin
    if formmain.TreeViewplan.Selected.Level > 1 then
    begin
      DateTimePicker1loadplan.Date := Tplantreedata(formmain.TreeViewplan.Selected.Data^).pubdate;
    end;
  end;
  // Set default publication from current selection in tree (?)
  ComboBoxpublication.Itemindex := ComboBoxpublication.Items.IndexOf(tnames1.publicationIDtoname(defaultpublid));
  if ComboBoxpublication.Itemindex < 0 then
    ComboBoxpublication.Itemindex := 0;
  // Set default deadline to pubdate plus one hour
  DateTimePicker1loadplan.enabled := true;
  deadl := DateTimePicker1loadplan.DateTime;
  DecodeDate(deadl,Year, Month, Day);
  deadl := EncodeDateTime(Year, Month, Day,0,0,0,0);
  deadl := IncHour(deadl,1);
  DateTimePickerdeadlinedate.Date := deadl;
  DateTimePickerdeadtime.Time := deadl;

  // Populate filter on top of press template list..
  ComboBoxpublfilt.Items.Clear;
  ComboBoxpublfilt.Items.Add('*');
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('Select distinct p1.publicationid,pn.name from presstemplate p1, publicationnames pn');
  DataM1.Query1.SQL.Add('where p1.pressid = '+IntToStr(selectedpressID));
  DataM1.Query1.SQL.Add('and p1.publicationid = pn.publicationid');
  DataM1.Query1.SQL.Add('order by pn.name');
  DataM1.Query1.Open;
  While not DataM1.Query1.Eof do
  begin
    ComboBoxpublfilt.Items.Add(DataM1.Query1.Fields[1].AsString);
    DataM1.Query1.Next;
  end;
  DataM1.Query1.Close;
  ComboBoxpublfilt.Itemindex := ComboBoxpublfilt.Items.IndexOf(tnames1.publicationIDtoname(defaultpublid));
  if (ComboBoxpublfilt.ItemIndex < 0)  then
    ComboBoxpublfilt.ItemIndex := 0;
   // New publication button..
  Button1.Enabled := true;
  // Set filter for minumum number of pages filter on top of press template list
  ComboBoxNpage.ItemIndex := 0;
  if formprodplan.EditMode = PLANADDMODE_APPLY then
    ComboBoxNpage.Text := IntToStr(maxpages);
  // if APPLY action - set publication and date from current selected production in plan tree
  ComboBoxEditionSelection.Enabled := true;
  if Applytopublid > -1 then
  Begin
    ComboBoxpublication.Itemindex := ComboBoxpublication.Items.IndexOf(tnames1.publicationIDtoname(Applytopublid));
    //ComboBoxpublication
    DateTimePicker1loadplan.Date := Applytodate;
    DateTimePicker1loadplan.Enabled := false;
    ComboBoxpublication.Enabled := false;
    Button1.Enabled := false;
    Editplanname.Enabled := false;
    Editplanname.Text := Applytopprodname;
    // NAN 20151119 !!!
    //ComboBoxEditionSelection.Enabled := false;
  end;

  // Load press emplate list for press....
  loadplanlist;
  BitBtn1.Enabled := ListBoxpresstemplatename.Items.Count > 0;
  makeplanname;
  if Applytopublid > -1 then
  begin
    Editplanname.Text := Applytopprodname;
    Editplanname.Refresh;
  end;
  if itspartial then
  begin
    ComboBoxpublication.ItemIndex := ComboBoxpublication.Items.IndexOf(tnames1.publicationIDtoname(Applytopublid));
    DateTimePicker1loadplan.Date := Applytodate;
  end;
  setposibletemplates(true);
  SetPublicationSpecificPriority();
  SetPublicationSpecificTemplate();
  // Currently never set...
  if CheckBoxusecurprod.checked  then
  Begin
    autosetCurrentproddata;
  end;
  // Reset to no publication if not APPLY action
  if (Applytopublid = -1) and (itspartial = false) then
    ComboBoxpublication.Itemindex := -1;
  // Fill edition combo
  SetEditionCombo;
  //if (Applytopublid > -1) then
  //begin
 //   ComboBoxEditionSelection.Itemindex := ComboBoxEditionSelection.Items.IndexOf(tnames1.editionIDtoname(Applytoedid));
  //end;
end;

procedure TFormloadpressplan.SetEditionCombo;
var
  publicationID : Longint;
begin
  publicationID := tnames1.publicationnametoid(ComboBoxpublication.Text);
  if ( publicationID > 0) then
  begin
     ComboBoxEditionSelection.Clear;
     DataM1.Query1.SQL.Clear;
     DataM1.Query1.SQL.Add('Select DISTINCT ED.Name FROM EditionNames ED INNER JOIN PublicationEditions PE ON ED.EditionID=PE.EditionID');
     DataM1.Query1.SQL.Add('where publicationid = ' + IntToStr(publicationID));
     DataM1.Query1.SQL.Add('ORDER BY Name');
     DataM1.Query1.open;
     While not DataM1.Query1.eof do
     begin
         ComboBoxEditionSelection.Items.add(DataM1.Query1.fields[0].asstring);
         DataM1.Query1.next;
     end;
  end;
  if (ComboBoxEditionSelection.Items.Count = 0) then
  begin
     DataM1.Query1.SQL.Clear;
     DataM1.Query1.SQL.Add('Select DISTINCT Name FROM EditionNames ORDER BY Name');
     DataM1.Query1.open;
     While not DataM1.Query1.eof do
     begin
         ComboBoxEditionSelection.Items.add(DataM1.Query1.fields[0].asstring);
         DataM1.Query1.next;
     end;
  end;
  if (ComboBoxEditionSelection.Items.Count > 0) then
    ComboBoxEditionSelection.ItemIndex := 0;
     // NAN 20151119 #####
    if (Prefs.PlanningDefaultFirstEdition <> '') then
    begin
      if tnames1.editionnametoid(Prefs.PlanningDefaultFirstEdition) > 0 then
      Begin
        ComboBoxEditionSelection.ItemIndex := ComboBoxEditionSelection.Items.IndexOf(Prefs.PlanningDefaultFirstEdition);
        //ComboBoxEditionSelection.Text := Prefs.PlanningDefaultFirstEdition;
      end;
    end;
end;

procedure TFormloadpressplan.BitBtn1Click(Sender: TObject);
Var
  Year, Month, Day,Hour, Min, Sec, MSec: Word;
begin
  if ComboBoxtemplate.Text = 'No change' then
  begin
    // MessageDlg('Please select a template', mtInformation, [mbOk], 0);
     Exit;
  end
  else
  begin
    if (ComboBoxpublication.ItemIndex = -1) then
    begin
       MessageDlg(formmain.InfraLanguage1.Translate('Please select publication'), mtInformation,[mbOk], 0);
       Exit;
    end;
    plateframesloadedname := ListBoxpresstemplatename.Items[ListBoxpresstemplatename.itemindex];
    creep := strtofloat(editcreep.text);
    FormApplyproduction.Creep :=creep;
    FormApplyproduction.editcreep.text := editcreep.text;
    DecodeDate(DateTimePickerdeadlinedate.Date,Year, Month, Day);
    DecodeTime(DateTimePickerdeadtime.Time,Hour, Min, Sec, MSec);
    FormApplyproduction.CheckBoxAllowunplannedcolors.checked := CheckBoxAllowunplannedcolors.checked;
    deadline := encodedatetime(Year, Month, Day,Hour, Min, Sec, MSec);
    formprodplan.Applyonlyplannedcolors := CheckBoxApplyonlyplannedcolors.checked;
    FormApplyproduction.GroupBoxRipsetup.Visible := (ApletoUseRipSetupNameSetup) and (tnames1.RipSetupnames.Count > 0);
    FormApplyproduction.ComboBoxRIPsetup.items.Clear;
    FormApplyproduction.ComboBoxRipSetup.Items := ComboBoxRipSetup.Items;
    FormApplyproduction.ComboBoxRipSetup.Itemindex := ComboBoxRipSetup.Itemindex;
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('Select distinct p1.presstemplateid from  presstemplatenames p1, presstemplate p2');
    DataM1.Query1.SQL.Add('where p1.presstemplateid = p2.presstemplateid');
    DataM1.Query1.SQL.Add('and p1.name = ' + ''''+ListBoxpresstemplatename.Items[ListBoxpresstemplatename.Itemindex]+'''');
    DataM1.Query1.SQL.Add('and p2.pressid = '+IntToStr(selectedpressID));
    XMLPressID  :=  selectedpressID;
    DataM1.Query1.open;
    if not DataM1.Query1.Eof then
    begin
      selectedplanid := DataM1.Query1.fieldbyname('presstemplateid').AsInteger;
    end;
    DataM1.Query1.close;
    if Applytopublid > -1 then
    begin
      Editplanname.Text := Applytopprodname;
    end;
    plateframesproductionname := Editplanname.text;
  end;
end;

procedure TFormloadpressplan.FormCreate(Sender: TObject);
Var
  I : Longint;
begin
  defaultpublid := 0;
  For i := 0 to 200 do
  begin
    ComboBoxNpage.Items.add(IntToStr(i*2));
  end;
  activated := false;
  DateTimePicker1loadplan.Datetime := now;
  DateTimePicker1loadplan.Time := 0;
end;

procedure TFormloadpressplan.DateTimePicker1loadplanChange(Sender: TObject);
begin
  makeplanname;
  // NAN 20170220 - only set if in week number mode..
  if (Prefs.ShowWeekNumberInTree) then
    Editweek.text := LeadingZeroes(WeekOf(DateTimePicker1loadplan.DateTime), 2)
  else
    Editweek.text := '0';

  if CheckBoxusecurprod.checked then
  Begin
    Sectionschanged := false;
    Editionchanged := false;
    Offsetchanged  := false;
    NEdchanges := 0;
    setlistdata;
    makeplanname;
    autosetCurrentproddata;
  end;
  Setdeadl;
 // UpDownweek.Position := WeekOf(DateTimePicker1.Date);
end;

procedure TFormloadpressplan.SetPublicationSpecificTemplate();
var
  templateName : string;
begin
   templateName := '';
  // Fetch template from publication output defaults
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('SELECT T.TemplateName FROM PublicationTemplates PT (NOLOCK)');
  DataM1.Query1.SQL.Add('INNER JOIN TemplateConfigurations T (NOLOCK) ON T.TemplateID=PT.TemplateID');
  DataM1.Query1.SQL.Add('WHERE PT.PublicationID = ' + IntToStr(tnames1.publicationnametoid(ComboBoxpublication.Text)) );
  DataM1.Query1.SQL.Add('AND PT.PressID= ' + IntToStr(selectedpressID));
  DataM1.Query1.Open;
  if not DataM1.Query1.Eof then
  begin
    templateName := DataM1.Query1.Fields[0].AsString;
  end;
  DataM1.Query1.Close;
  ComboBoxtemplate.ItemIndex := ComboBoxtemplate.Items.IndexOf(templateName);
  if (Prefs.PlanLoadDefaultToNoTemplateChange) or (ComboBoxtemplate.ItemIndex < 0) then
    ComboBoxtemplate.Itemindex := 0;
end;
procedure TFormloadpressplan.SetPublicationSpecificPriority();
begin

  // Fetch priority from publication output defaults
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('Select priority from publicationtemplates (NOLOCK)');
  DataM1.Query1.SQL.Add('where publicationid = ' + IntToStr(tnames1.publicationnametoid(ComboBoxpublication.Text)) );
  DataM1.Query1.SQL.Add('and pressid = ' + IntToStr(selectedpressID));
  DataM1.Query1.Open;
  if not DataM1.Query1.Eof then
  begin
    UpDown1.Position  := DataM1.Query1.Fields[0].AsInteger;
    Editpriority.Text := IntToStr(UpDown1.Position);
  end;
  DataM1.Query1.Close;
end;

procedure TFormloadpressplan.ComboBoxpublicationChange(Sender: TObject);
Var
  i,
  deftmplid : longint;
  hasPubSections : boolean;
  hasPubEditions : boolean;
  hasPromptedForSectionEdition : Boolean;
begin
  if (isFIllingPublicationCombo) then
    exit;
  hasPromptedForSectionEdition := false;
  makeplanname();
  SetPublicationSpecificPriority();
  SetPublicationSpecificTemplate();

  if (CheckBoxusecurprod.checked) then
  Begin
    Sectionschanged := false;
    Editionchanged := false;
    Offsetchanged  := false;
    NEdchanges := 0;
    setlistdata();
    makeplanname();
    autosetCurrentproddata();
  end;
  Checkifready;
   if (Prefs.PlanLoadPromptForSectionEdition) then
   begin
    //Find alle sektioner til produktet
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('Select TOP 1 PublicationID from PublicationSections with (NOLOCK)');
    DataM1.Query1.SQL.Add('where PublicationID = ' + IntToStr(tnames1.publicationnametoid(ComboBoxpublication.Text)) );
    DataM1.Query1.Open;
    hasPubSections :=  not DataM1.Query1.Eof;
    DataM1.Query1.Close;
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('Select TOP 1 PublicationID from PublicationEditions with (NOLOCK)');
    DataM1.Query1.SQL.Add('where PublicationID = ' + IntToStr(tnames1.publicationnametoid(ComboBoxpublication.Text)) );
    DataM1.Query1.Open;
    hasPubEditions :=  not DataM1.Query1.Eof;
    DataM1.Query1.Close;
    FormSelectSecEd.ListBoxSec.Items.Clear;
    DataM1.Query1.SQL.Clear;
    if hasPubSections then
    begin
      DataM1.Query1.SQL.Add('Select DISTINCT SectionID PublicationID from PublicationSections with (NOLOCK)');
      DataM1.Query1.SQL.Add('where PublicationID = ' + IntToStr(tnames1.publicationnametoid(ComboBoxpublication.Text)) );
    end
    else
      DataM1.Query1.SQL.Add('Select DISTINCT SectionID from SectionNames with (NOLOCK)');
    DataM1.Query1.Open;
    while not DataM1.Query1.Eof do
    begin
      FormSelectSecEd.ListBoxSec.Items.Add(tnames1.sectionIDtoname(DataM1.Query1.Fields[0].AsInteger));
      DataM1.Query1.Next;
    end;
    DataM1.Query1.Close;
    FormSelectSecEd.ListBoxSec.ItemIndex := 0;
    FormSelectSecEd.ListBoxEdition.Items.Clear;
    DataM1.Query1.SQL.Clear;
    if hasPubEditions then
    begin
      DataM1.Query1.SQL.Add('Select DISTINCT EditionID PublicationID from PublicationEditions with (NOLOCK)');
      DataM1.Query1.SQL.Add('where PublicationID = ' + IntToStr(tnames1.publicationnametoid(ComboBoxpublication.Text)) );
    end
    else
      DataM1.Query1.SQL.Add('Select DISTINCT EditionID from EditionNames with (NOLOCK)');
    DataM1.Query1.Open;
    while not DataM1.Query1.eof do
    begin
      FormSelectSecEd.ListBoxEdition.Items.Add(tnames1.editionIDtoname(DataM1.Query1.Fields[0].AsInteger));
      DataM1.Query1.next;
    end;
    DataM1.Query1.Close;
    FormSelectSecEd.ListBoxEdition.ItemIndex := 0;
    if PBExListview1.Items.Count > 0 then
    begin
      for i := 0 to PBExListview1.Items.Count - 1 do
      begin
        if (FormSelectSecEd.ListBoxSec.Items.Count > 1) Or (FormSelectSecEd.ListBoxEdition.Items.Count > 1) then
        begin
          FormSelectSecEd.Panel2.Caption := 'Select section(s) and edition(s) for : ' + IntToStr(i + 1);
          FormSelectSecEd.ShowModal;
          PBExListview1.items[i].Caption     := ComboBoxpublication.Text;
          PBExListview1.items[i].SubItems[0] := FormSelectSecEd.ListBoxEdition.Items[FormSelectSecEd.ListBoxEdition.ItemIndex] ;
          PBExListview1.items[i].SubItems[1] := FormSelectSecEd.ListBoxSec.Items[FormSelectSecEd.ListBoxSec.ItemIndex];
          hasPromptedForSectionEdition := true;
        end;
      end;
    end;

    //S� s�tter vi lige col p�nt
    For i := 0 to PBExListview1.Columns.Count - 1 do
      PBExListview1.Columns[i].Width := -2;
  end;
  SetEditionCombo;
  // NAN 20171004 - if we did not prompt for section/edition - make sure edition is adjusted to selected in ComboBoxEditionSelection
  if (not hasPromptedForSectionEdition) then
  begin

    if PBExListview1.Items.Count > 0 then
    begin
      for i := 0 to PBExListview1.Items.Count - 1 do
      begin
        PBExListview1.items[i].SubItems[0] := ComboBoxEditionSelection.Text;
      end;
      Editionchanged := true;
    end;
  end;

end;

{Function TFormloadpressplan.DateOfWeek(Year : Word;
                                       Week : Word;
                                       DayOfWeek : Word;
                                       Var Day : Word;
                                       Var Month : Word):Longint;
Var
  dt : tdatetime;
  Y, M, D : Word;
Begin
  result := 0;
  try
    dt := EncodeDateWeek(Year,Week,DayOfWeek);
    DecodeDate(dt, Y, M, D);
    day := d;
    month := m;
    result := 1;
  except
    result := 0;
  end;
end;
}
procedure TFormloadpressplan.ComboBoxpresstemplatenameChange(
  Sender: TObject);
Var
  id,i : Integer;
begin
  id := 0;
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('Select top 1 p1.publicationid,p1.presstemplateid,p2.presstemplateid,p2.name  from presstemplate p1, presstemplatenames p2');
  DataM1.Query1.SQL.Add('where p1.presstemplateid = p2.presstemplateid');
  DataM1.Query1.SQL.Add('and  p2.name = '+''''+ListBoxpresstemplatename.Items[ListBoxpresstemplatename.Itemindex]+'''');
  DataM1.Query1.open;
  // Adjust publication taken from selected press template
  if not DataM1.Query1.Eof then
  begin
    id := DataM1.Query1.fieldbyname('publicationid').AsInteger;
  end;
  DataM1.Query1.close;
  For i := 0 to ComboBoxpublication.Items.Count-1 do
  begin
    if ComboBoxpublication.Items[i] = tNames1.publicationIDtoname(id) then
    Begin
      ComboBoxpublication.ItemIndex := i;
      makeplanname();
      break;
    end;
  end;
  // Overrule if APPLY action
  if Applytopublid > -1 then
  Begin
    ComboBoxpublication.Itemindex := ComboBoxpublication.Items.IndexOf(tnames1.publicationIDtoname(Applytopublid));
    DateTimePicker1loadplan.Date := Applytodate;
    DateTimePicker1loadplan.enabled := false;
    ComboBoxpublication.enabled := false;
    ComboBoxEditionSelection.Enabled := false;
    SetPublicationSpecificTemplate();
    SetPublicationSpecificPriority();
  end;
end;
Procedure TFormloadpressplan.setposibletemplates(ShowAll:Boolean);
Var
  i,akttemplateid : Longint;
Begin
  akttemplateid := 0;
  try
    ComboBoxtemplate.Items.clear;
    ComboBoxtemplate.Items.Add('No change');
    if (ShowAll) then
    begin
      For I := 1 to NPlatetemplateArray do
          ComboBoxtemplate.Items.add(PlatetemplateArray[I].TemplateName);
      ComboBoxtemplate.Itemindex := 0;
      exit;
    end;
    if ListBoxpresstemplatename.ItemIndex < 0 then exit;
    if ListBoxpresstemplatename.items.count > 0 then
    begin
      DataM1.Query1.SQL.Clear;
      DataM1.Query1.SQL.Add('Select distinct p1.name,p1.presstemplateid,p2.presstemplateid,p2.templateid from presstemplatenames p1, presstemplate p2');
      DataM1.Query1.SQL.Add('where p1.presstemplateid = p2.presstemplateid');
      DataM1.Query1.SQL.Add('and p1.name = ' + ''''+ListBoxpresstemplatename.items[ListBoxpresstemplatename.itemindex]+'''');
      DataM1.Query1.open;
      if not DataM1.Query1.eof then
      begin
        akttemplateid := DataM1.Query1.fields[3].AsInteger;
      end;
      DataM1.Query1.close;
      akttemplateid := inittypes.gettemplatenumberfromID(akttemplateid);
      For I := 1 to NPlatetemplateArray do
      begin
        if (PlatetemplateArray[I].PressID = selectedpressID) and
           ((
           (PlatetemplateArray[I].ISdouble = PlatetemplateArray[akttemplateid].ISdouble) and
           (PlatetemplateArray[I].PagesAcross = PlatetemplateArray[akttemplateid].PagesAcross) and
           (PlatetemplateArray[I].PagesDown = PlatetemplateArray[akttemplateid].PagesDown) and
           ((PlatetemplateArray[I].NupOnplate = 1 ) or
           ((PlatetemplateArray[I].PageRotationList[1] mod 2)= (PlatetemplateArray[akttemplateid].PageRotationList[1] mod 2)))
           ) or (itspartial))
        then
        begin
          ComboBoxtemplate.Items.add(PlatetemplateArray[I].TemplateName);
        end;
      end;
      ComboBoxtemplate.Itemindex := 0;
    end;
  Except
  end;
end;

procedure TFormloadpressplan.ListBoxpresstemplatenameClick(Sender: TObject);
Begin
  Sectionschanged := false;
  Editionchanged  := false;
  Offsetchanged   := false;
  NEdchanges      := 0;
  setlistdata;
  makeplanname;
  if CheckBoxusecurprod.Checked then
    autosetCurrentproddata;
  Autosetifone;
  SetPublicationSpecificTemplate();
  //ComboBoxpublication.Itemindex := 0;
  //if (Applytopublid < 0) then
   // ComboBoxpublication.ItemIndex := -1;
  //ComboBoxpublicationChange(self);
  Checkifready;
end;
Procedure TFormloadpressplan.SetListData;
Var
  l : tlistitem;
  I,i2 : Longint;
  T : string;
  rpsetinpresstemple : Boolean;
begin
  try
    NumberOfEditionsInProd := 1;
    UsingProddata := false;
    Formeditplan.maxpages := 0;
    Platetempldbversion := 1;
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.add('Select distinct p2.name,p1.presstemplateid,p1.publicationid,p1.editionid,p1.sectionid, count(distinct p1.pagename) as antal,p1.inserted from presstemplate p1, presstemplatenames p2');
    DataM1.Query1.SQL.add('where p1.presstemplateid = p2.presstemplateid');
    DataM1.Query1.SQL.add('and p1.pressid = '+IntToStr(selectedpressID));
    DataM1.Query1.SQL.add('and p1.pagetype <> 3');
    DataM1.Query1.SQL.add('and p2.name = ' +''''+ListBoxpresstemplatename.Items[ListBoxpresstemplatename.itemindex] +'''');
    DataM1.Query1.SQL.add('GROUP BY p2.name,p1.presstemplateid,p1.publicationid,p1.editionid,p1.sectionid,p1.inserted');
    DataM1.Query1.open;
    // Main population of sections in selected press template
    PBExListview1.Items.clear;
    While not DataM1.Query1.eof do
    begin
      Insertedplan := DataM1.Query1.fields[6].AsInteger = 1;
      selectedplanid := DataM1.Query1.fields[1].AsInteger;
      l := PBExListview1.Items.add;
      l.Caption := tnames1.publicationIDtoname(DataM1.Query1.fields[2].AsInteger);
      l.SubItems.Add(tnames1.editionIDtoname(DataM1.Query1.fields[3].AsInteger));
      l.SubItems.Add(tnames1.sectionIDtoname(DataM1.Query1.fields[4].AsInteger));
      l.SubItems.Add(DataM1.Query1.fields[5].AsString);
      if dbversion > 1 then
      Begin
        if itspartial then
        Begin
          if Formloadpressplan.partialoffstart = 1 then
            T := '1'
          else
            T := IntToStr(Formloadpressplan.partialoffstart-1);
          l.SubItems.Add(T);
        End
        Else
          l.SubItems.Add('0');
      End
      else
        l.SubItems.Add('0');
      Inc(Formeditplan.maxpages,DataM1.Query1.Fields[5].AsInteger);
      DataM1.Query1.Next;
    end;
    DataM1.Query1.Close;
    if PBExListview1.Items.Count = 1 then
      Insertedplan := true;
    if (PBExListview1.Items.count > 0) AND (not Prefs.SimplePlanLoad) then
      ComboBoxpublication.ItemIndex := ComboBoxpublication.Items.IndexOf(PBExListview1.Items[0].Caption);
    Loadfromproduction1.Enabled := true;
    T := PBExListview1.Items[0].SubItems[0];
    for i := 0 to PBExListview1.Items.Count-1 do
    begin
      if T <> PBExListview1.Items[i].SubItems[0] then
      begin
        Loadfromproduction1.Enabled := false;
      end;
    end;
    if GroupBoxRipSetup.Visible then
    begin
      ComboBoxRipSetup.items.Clear;
      DataM1.Query1.sql.Clear;
      DataM1.Query1.sql.Add('Select name from RipSetupNames');
      DataM1.Query1.sql.Add('Where pressid  < 1 or pressid  = ' + IntToStr(selectedpressID));
      DataM1.Query1.sql.Add('order by name');
      DataM1.Query1.Open;
      while not DataM1.Query1.Eof do
      begin
        ComboBoxRipSetup.Items.Add(DataM1.Query1.Fields[0].AsString);
        DataM1.Query1.Next;
      end;
      DataM1.Query1.Close;
      try
        DataM1.Query1.SQL.Clear;
        DataM1.Query1.SQL.Add('Select top 1 * from presstemplate');
        DataM1.Query1.SQL.Add('where presstemplateid = '+IntToStr(selectedplanid));
        rpsetinpresstemple := false;
        DataM1.Query1.Open;
        for i := 0 to DataM1.Query1.Fields.Count-1 do
        begin
          if UpperCase(DataM1.Query1.Fields[i].FieldName) = 'RIPSETUPID' then
          begin
            rpsetinpresstemple := true;
            break;
          end;
        end;
        DataM1.Query1.Close;
        if rpsetinpresstemple then
        begin
          DataM1.Query1.SQL.Clear;
          DataM1.Query1.SQL.Add('Select distinct RipSetupID from presstemplate');
          DataM1.Query1.SQL.Add('where presstemplateid = '+IntToStr(selectedplanid));
          i := 0;
          DataM1.Query1.Open;
          if not DataM1.Query1.Eof Then
          begin
            ComboBoxRipSetup.ItemIndex := ComboBoxRipSetup.Items.IndexOf(tnames1.ripsetupIDtoname(DataM1.Query1.fields[0].AsInteger));
          end;
          DataM1.Query1.Close;
        end;
      except
      end;
    end;
    CheckBoxusecurprod.Enabled := false;
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('Select distinct editionid from presstemplate');
    DataM1.Query1.SQL.Add('where presstemplateid = '+IntToStr(selectedplanid));
    i := 0;
    DataM1.Query1.Open;
    While not DataM1.Query1.Eof do
    begin
      Inc(i);
      DataM1.Query1.Next;
    end;
    DataM1.Query1.Close;
    CheckBoxusecurprod.Enabled := (i < 2) And (formmain.TreeViewplan.Selected.Level > 1);
    Buttonedit.Enabled := true;
    //PBExListview1.Items.count = 1;
    if Applytopublid > -1 then
    Begin
      ComboBoxpublication.ItemIndex := ComboBoxpublication.Items.IndexOf(tnames1.publicationIDtoname(Applytopublid));
      DateTimePicker1loadplan.Date := Applytodate;
      DateTimePicker1loadplan.Enabled := false;
      ComboBoxpublication.Enabled := false;
      Button1.Enabled := false;
    end;
    if itspartial then
    begin
      For i := 0 to PBExListview1.Items.Count-1 do
      begin
      end;
    end;
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('Select distinct plancreep,copynumber from presstemplate');
    DataM1.Query1.SQL.Add('where presstemplateid = ' +IntToStr(selectedplanid));
    DataM1.Query1.SQL.Add('and pressid = '+IntToStr(selectedpressID));
    DataM1.Query1.Open;
    if not DataM1.Query1.Eof then
    Begin
      UpDownCopies.Position := DataM1.Query1.Fields[1].AsInteger;
      editcreep.Text := DataM1.Query1.Fields[0].AsString;
    end;
    DataM1.Query1.close;
    Buttonedit.Enabled := Insertedplan;


  except
  end;

  setposibletemplates(false);
  if Applytopublid > -1 then
  Begin
    ComboBoxpublication.Itemindex := ComboBoxpublication.Items.IndexOf(tnames1.publicationIDtoname(Applytopublid));
    DateTimePicker1loadplan.Date := Applytodate;
    DateTimePicker1loadplan.Enabled := false;
    ComboBoxpublication.Enabled := false;
  end;
  ListViewbefore.Items.clear;
  for i := 0 to PBExListview1.Items.Count-1 do
  begin
    l := ListViewbefore.Items.Add;
    l.caption := PBExListview1.Items[i].Caption;
    for i2 := 0 to PBExListview1.Items[i].SubItems.Count-1 do
      l.SubItems.Add(PBExListview1.Items[i].SubItems[i2])
  end;
  PBExListview1.Columns[0].Width := 68;
     //(Not itspartial) and
  if (Applingtoplan) then
  begin
    PBExListview1.Columns[0].Width := 1;
    setapplyeds;
    setapplysec;
  end;
  BitBtn1.Enabled := PBExListview1.Items.Count > 0;
  if (Prefs.PlanningClearPubliationsOnLoad) AND (Applytopublid <= -1) then
      ComboBoxpublication.ItemIndex := -1;
end;
procedure TFormloadpressplan.FormActivate(Sender: TObject);
Begin
  isFIllingPublicationCombo := false;
  loadAvailplans;
  PBExListview1.Enabled := true;
  PBExListview1.Items.Clear;
  BitBtn1.Enabled := false;
  CheckBoxOnlyShowDefaultPressPublications.Checked := Prefs.PlanningOnlyShowDefaultPressPublications;
  GroupBoxRipSetup.Visible := (ApletoUseRipSetupNameSetup) and (tnames1.RipSetupnames.Count > 0);
  ComboBoxRipSetup.Items := tnames1.RipSetupnames;

  CheckBoxApplyonlyplannedcolors.Checked := Prefs.ApplyOnlyPlannedColors;
  EditCopies.Enabled := CheckBoxChangecopies.Checked;
  UpDownCopies.Enabled := CheckBoxChangecopies.Checked;
  Setdeadl;
  if (Prefs.Proversion = 2) then
  begin
    CheckBoxoffsetinsreted.Visible := false;
    CheckBoxignoreplanedition.Visible := false;
    Panelonlynonepro.visible := false;
  end
  else
  begin
    Panelonlynonepro.visible := true;
  end;
  // NAN
  Panelonlynonepro.Visible := false;
  Panel5.Visible := false;
  Panel5.Height := 0;
  Button2.Visible := false;
  GroupBoxFilter.Visible := not Prefs.SimplePlanLoad;
  if (Prefs.ShowWeekNumberInTree) then
  begin
    Editweek.Enabled := True;
    Editweek.Text    := LeadingZeroes(WeekOf(Now), 2);
    DateTimePicker1loadplan.Enabled := False;
    EditweekChange(nil);
  end
  else
  begin
    // ### NAN 20170220 Mega-bug...Weeknumber MUST be zero if not used!
    Editweek.Text    := '0'; //LeadingZeroes(WeekOf(Now), 2);
    Editweek.Enabled := False;
    DateTimePicker1loadplan.Enabled := True;
  end;
  CheckBoxOnlyShowDefaultPressPublications.Checked := Prefs.PlanningOnlyShowDefaultPressPublications;
end;

Procedure TFormloadpressplan.loadAvailplans;
Var
  I : Longint;
begin
  try
    NumberOfEditionsInProd := 1;
    UsingProddata := false;
    Sectionschanged := false;
    Editionchanged := false;
    NEdchanges := 0;
    ComboBoxstackpos.Items.Clear;
    for i := 0 to Length(Prefs.StackNamesList)-1 do
      ComboBoxstackpos.Items.Add(Prefs.StackNamesList[i]);
    ComboBoxstackpos.Items.Insert(0,'Planned');
    ComboBoxstackpos.ItemIndex := 0;
    if not activated then
    begin
      CheckBoxAllowunplannedcolors.Checked := Prefs.PlanningAllowUnplannedColors;
      activated := true;
    end;
  Except
  end;
end;

procedure TFormloadpressplan.CheckBoxshowallClick(Sender: TObject);
begin
  loadplanlist;
end;
// Populate press template list  for 'selectedpressID'
Procedure TFormloadpressplan.loadplanlist;

Procedure loadit;
var
  t: string;
//Var
//  l : Tlistitem;
//  aktpress,presses,enkeletdoublet,broadtab,t1,t2,t3 : String;
//  nsec,aktsec,i,i2 : Longint;
{  secs : Array[1..5] of record
                          npages : longint;
                          secname : String;
                        end;               }
begin
  ListViewplans.Items.Clear;
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('Select distinct p1.name,p1.presstemplateid,p2.presstemplateid,p2.pressid from  presstemplatenames p1, presstemplate p2');
  DataM1.Query1.SQL.Add('where p1.presstemplateid = p2.presstemplateid');
  DataM1.Query1.SQL.Add('and p2.pressid = '+IntToStr(selectedpressID));
  if (not CheckBoxshowall.Checked) And ( not itspartial) and (not Prefs.SimplePlanLoad) then
  Begin
    if ComboBoxpublfilt.ItemIndex > 0 then
      DataM1.Query1.SQL.Add('and p2.publicationid = '+IntToStr(tnames1.publicationnametoid(ComboBoxpublfilt.text)   ));
    if ComboBoxNpage.ItemIndex > 0 then
      DataM1.Query1.SQL.Add('and p2.pageindex >= '+ComboBoxNpage.text);
  end;
  if ((not CheckBoxshowall.Checked) and (formprodplan.editmode = PLANADDMODE_APPLY)) And ( not itspartial) then
  Begin
    DataM1.Query1.SQL.Add('and p2.sectionid in '+sectionlist);
    DataM1.Query1.SQL.Add('and p2.editionid in '+editionlist);
    DataM1.Query1.SQL.Add('and exists (select editionid from presstemplate p3');
    DataM1.Query1.SQL.Add('where p2.presstemplateid = p3.presstemplateid');
    DataM1.Query1.SQL.Add('and p2.editionid <> p3.editionid');
    DataM1.Query1.SQL.Add(')');
    DataM1.Query1.SQL.Add('and');
    DataM1.Query1.SQL.Add('not exists (select editionid from presstemplate p4');
    DataM1.Query1.SQL.Add('where p2.presstemplateid = p4.presstemplateid');
    DataM1.Query1.SQL.Add('and not p4.editionid in (1,3)');
    DataM1.Query1.SQL.Add(')');
  end;
  DataM1.Query1.SQL.Add('order by p1.name');
  if Prefs.debug then DataM1.Query1.SQL.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'loadpressplannames.sql');
  DataM1.Query1.open;
  ListBoxpresstemplatename.Items.clear;

  if (Prefs.CustomBuildName = 'STB') and (selectedpressID = 3) then
  begin

     while not DataM1.Query1.Eof do
    begin
      t := DataM1.Query1.fields[0].asstring;
      if Pos('T=', t) > 0 then
      begin
        ListBoxpresstemplatename.items.Add(t);
      end;
      DataM1.Query1.Next;
    end;
    DataM1.Query1.Close;

    DataM1.Query1.Open;

    while not DataM1.Query1.eof do
    begin
      t := DataM1.Query1.fields[0].asstring;
      if Pos('B=', t) > 0 then
      begin
        ListBoxpresstemplatename.items.Add(t);
      end;
      DataM1.Query1.next;
    end;
    DataM1.Query1.close;


  end
  else
  begin
    while not DataM1.Query1.Eof do
    begin
      ListBoxpresstemplatename.Items.Add(DataM1.Query1.fields[0].AsString);
      DataM1.Query1.Next;
    end;
    DataM1.Query1.close;
  end;




(*
    presses := '';
    enkeletdoublet := '';
    T1 := DataM1.Query1.fields[0].AsString;
    nsec := 1;
    broadtab := '';
    try
      l := ListViewplans.Items.add;
      l.Caption := '';
      l.SubItems.add('');
      l.SubItems.add('');
      l.SubItems.add('');
      For i := 1 to length(T1) do
      begin
        if t1[i] = ':' then
        begin
          t2 := t1[i-1];
          aktsec := strtoint(t2)+1;
          if aktsec > nsec then
            nsec := aktsec;
        end;
        if t1[i] = '=' then
        Begin
          if t1[i-1] = 'T' then
            broadtab := 'T';
          if t1[i-1] = 'B' then
            broadtab := 'B';
          t3 := '';
          i2 := i+1;
          repeat
            t3 := t3 +t1[i2];
            inc(i2);
          until (t1[i2] = ',') or (length(t3)>3) ;
          secs[aktsec].npages := strtoint(t3);
        end;

        if t1[i] = 'D' then
          enkeletdoublet := 'D';
        if t1[i] = 'E' then
          enkeletdoublet := 'E';
        if t1[i] = 'P' then
        Begin
          aktpress := t1[i]+t1[i+1];
          if Pos(aktpress,presses) = 0 then
          begin
            if presses <> '' then
              presses := presses + ';';
            presses := presses + aktpress;
          end;
        end;
      end;
      if broadtab = 'B' then
      begin
        for i := 1 to nsec do
        begin
          secs[i].npages := secs[i].npages*2;
        end;
      end;
      for i := 1 to nsec do
      begin
        if i > 1 then
          l.Caption := l.Caption + ',';
        l.Caption := l.Caption + IntToStr(secs[i].npages) ;
      end;
      l.SubItems[0] := broadtab + ' ' +enkeletdoublet ;
      l.SubItems[1] := presses;

    except
    end;
    l.SubItems[2] := T1;
    //ListBoxpresstemplatename.Itemindex := 0;
    *)


end;
Begin
  loadit;
  Sectionschanged := false;
  Editionchanged := false;
  NEdchanges := 0;
  if ListBoxpresstemplatename.Items.Count = 0 then
  begin
    CheckBoxshowall.Checked := true;
    loadit;
  end;
  BitBtn1.Enabled := ListBoxpresstemplatename.Items.Count > 0;
  if ListBoxpresstemplatename.Items.Count > 0 then
  begin
    //ListBoxpresstemplatename.Itemindex := 0;
    //setlistdata;
  end;
end;
procedure TFormloadpressplan.ComboBoxpublfiltChange(Sender: TObject);
begin
  loadplanlist;
end;
procedure TFormloadpressplan.ComboBoxEditionSelectionChange(Sender: TObject);
begin
    PBExListview1.Selected.SubItems[0] := ComboBoxEditionSelection.Text;
    Editionchanged := true;

end;

procedure TFormloadpressplan.ComboBoxNpageChange(Sender: TObject);
begin
  loadplanlist;
end;
procedure TFormloadpressplan.EditcreepExit(Sender: TObject);
Var
  crp : Double;
  res : Boolean;
begin
  res := false;
  try
    if Editcreep.Text = '' then Editcreep.Text := '0';
    crp := StrToFloat(Editcreep.Text);
    res := true;
  except
  end;
  if Not res then
  begin
    MessageDlg(Editcreep.text + ' '+formmain.InfraLanguage1.Translate('is not a valid creep value'), mtError,[mbOk], 0);
    Editcreep.text := '0';
  end;
end;
procedure TFormloadpressplan.Button1Click(Sender: TObject);
Var
//  skaldeklarerespgadll : Longint;
  resulttat : Integer;
  aktpubl : String;
begin
    Runningdll := true;
  try
    try
      resulttat := ReConnectDB(DLLErrormessage);
      resulttat := JobNamesSetup(DLLErrormessage);
     Except
     end;
  finally
    formmain.loadids('Load pressplan OK', false);
    aktpubl := ComboBoxpublication.Text;
    ComboBoxpublication.Items := tnames1.publicationnames;
    ComboBoxpublication.Itemindex := ComboBoxpublication.Items.IndexOf(aktpubl);
    Runningdll := false;
  end;
end;
Procedure TFormloadpressplan.makeplanname;
begin
  if Applytopprodname <> '' then
  begin
    Editplanname.Text := Applytopprodname;
  End
  Else
  begin
    Editplanname.Text := formprodplan.createproductionname(tnames1.publicationnametoid(ComboBoxpublication.Text),
                                                           selectedpressID,DateTimePicker1loadplan.date);
  end;
end;
procedure TFormloadpressplan.PopupDeletePlanClick(Sender: TObject);

var
  PressPlanName : string;
  PressPlanID   : Integer;
begin
  try
    if ListBoxpresstemplatename.ItemIndex < 0 then
    begin
       Showmessage('Please select a name to delete');
       exit;
    end;

    PressPlanName := ListBoxpresstemplatename.Items.Strings[ListBoxpresstemplatename.ItemIndex];

    if (Length(PressPlanName) = 0) then
    begin
      Showmessage('Error. No pressplan with name: ' + PressPlanName);
      exit;
    end;

    PressPlanID := 0;
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('SELECT TOP 1 PressTemplateID FROM PressTemplateNames WITH (NOLOCK)');
    DataM1.Query1.SQL.Add('WHERE [Name] = ''' +  PressPlanName + '''');
    DataM1.Query1.Open;
    if not DataM1.Query1.Eof then
      PressPlanID := DataM1.Query1.Fields[0].AsInteger;
    DataM1.Query1.Close;

    if (PressPlanID > 0) then
    begin
      DataM1.Query1.SQL.Clear;
      DataM1.Query1.SQL.Add('DELETE FROM PressTemplate');
      DataM1.Query1.SQL.Add('WHERE PressTemplateID = ' + IntToStr(PressPlanID));
      if FormMain.trysql(Datam1.Query1) then
      begin
        DataM1.Query1.SQL.Clear;
        DataM1.Query1.SQL.Add('DELETE FROM PressTemplateNames');
        DataM1.Query1.SQL.Add('WHERE PressTemplateID = ' + IntToStr(PressPlanID));
        FormMain.trysql(Datam1.Query1);
        ListBoxpresstemplatename.Items.Delete(ListBoxpresstemplatename.ItemIndex);
      end;
    end;

  finally
    DataM1.Query1.Close;
  end;

end;

procedure TFormloadpressplan.PopupEditPlanNameClick(Sender: TObject);
var
  PressPlanNameOld,
  PressPlanNameNew : String;
begin
  Try
    if ListBoxpresstemplatename.ItemIndex < 0 then
    begin
      Showmessage('Please select a name from the list');
      exit;
    end;

    PressPlanNameOld := ListBoxpresstemplatename.Items.Strings[ListBoxpresstemplatename.ItemIndex];
    PressPlanNameNew := InputBox('Rename Pressplan ' + PressPlanNameOld, 'Edit name: ', PressPlanNameOld);

    if (Length(PressPlanNameNew) = 0) or (POS('''', PressPlanNameNew) <> 0) then
    begin
       Showmessage('Illegal press plan name');
      exit;
    end;

    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('UPDATE Presstemplatenames');
    DataM1.Query1.SQL.Add('SET [Name] = ''' +  PressPlanNameNew + '''');
    DataM1.Query1.SQL.Add('WHERE [Name] = ''' +  PressPlanNameOld + '''');
    if FormMain.trysql(Datam1.Query1) then
      ListBoxpresstemplatename.Items.Strings[ListBoxpresstemplatename.ItemIndex] := PressPlanNameNew
    else
      Showmessage('Error renaming pressplan name.');

  Finally
  End;
end;

procedure TFormloadpressplan.ButtoneditClick(Sender: TObject);
Var
  I,i2 : longint;
  l : tlistitem;
  Nchecked : Integer;
begin
  Sectionschanged := false;
  Formeditplan.PBExListview1.Items.Clear;
  For I := 0 to PBExListview1.Items.Count-1 do
  begin
    l := Formeditplan.PBExListview1.Items.Add;
    l.Checked := true;
    l.Caption := PBExListview1.Items[i].Caption;
    for i2 := 0 to PBExListview1.Items[i].SubItems.Count-1 do
    begin
      l.SubItems.Add(PBExListview1.Items[i].SubItems[i2]);
    end;
  end;
  if Formeditplan.ShowModal = mrok then
  begin
    setlistdata;
    Sectionschanged := false;
    Nchecked := 0;
    For I := 0 to Formeditplan.PBExListview1.Items.Count-1 do
    begin
      if Formeditplan.PBExListview1.Items[i].Checked then
      begin
        Inc(Nchecked);
        if Formeditplan.PBExListview1.Items[i].SubItems[2] <> PBExListview1.Items[0].SubItems[2] then
        begin
          Sectionschanged := true;
          break;
        end;
      end;
    end;
    if Nchecked > 1 then
      Sectionschanged := true;
    if Sectionschanged then
    begin
      PBExListview1.Clear;
      For i := 0 to Formeditplan.PBExListview1.items.count-1 do
      begin
        if Formeditplan.PBExListview1.Items[i].Checked then
        begin
          l := PBExListview1.Items.Add;
          l.Caption := Formeditplan.PBExListview1.Items[i].Caption;
          for i2 := 0 to Formeditplan.PBExListview1.Items[i].SubItems.Count-1 do
          begin
            l.SubItems.Add(Formeditplan.PBExListview1.Items[i].SubItems[i2]);
          end;
        end;
      end;
    end;
  end;
end;
procedure TFormloadpressplan.changesectionname1Click(Sender: TObject);
begin
  if PBExListview1.Selected = nil then exit;
  if FormChangesectionnamebyload.ShowModal = mrok then
  begin
    PBExListview1.Selected.SubItems[1] := FormChangesectionnamebyload.ListBox1.Items[FormChangesectionnamebyload.ListBox1.Itemindex];
    Sectionschanged := true;
  end;
end;
procedure TFormloadpressplan.Changeeditionname1Click(Sender: TObject);
begin
  if Formchednameload.ShowModal = mrok then
  begin
    Inc(NEdchanges);
    Edchanges[NEdchanges].fromed := tnames1.editionnametoid(PBExListview1.Selected.SubItems[0]);
    Edchanges[NEdchanges].toed := tnames1.editionnametoid(Formchednameload.ListBox1.Items[Formchednameload.ListBox1.Itemindex]);
    PBExListview1.Selected.SubItems[0] := Formchednameload.ListBox1.Items[Formchednameload.ListBox1.Itemindex];
    Editionchanged := true;
  end;
end;

procedure TFormloadpressplan.EditweekChange(Sender: TObject);
Var
  curweek,Year, Month, Day: Word;
  adate : tdatetime;
  week : Integer;
begin
  if (not Prefs.ShowWeekNumberInTree) then
    exit;
  IF (editweek.Text = '') OR (editweek.Text = '0') then
    exit;
  week := StrToInt(editweek.Text);
  FormApplyproduction.ApplyweekNumber := week;
  if week < 1 then
    exit;
  if week > 53 then
    exit;
  try
   curweek := WeekOf(now);

   DecodeDate(now,Year, Month, Day);
   if (curweek = 53) AND (year = 2021) then
     year := 2020;

   if (curweek > week) AND (curweek<>52)  then
     Inc(Year);
  if (week = 53) AND (year = 2021) then
     year := 2020;

   adate := EncodeDateWeek(Year, week, Prefs.DayOfWeek + 1);
   DateTimePicker1loadplan.Date := adate;
  except
  end;
end;
procedure TFormloadpressplan.Button2Click(Sender: TObject);
begin
  FormEditplannames.ShowModal;
  loadAvailplans;
  loadplanlist;
end;
procedure TFormloadpressplan.CheckBoxChangecopiesClick(Sender: TObject);
begin
  EditCopies.Enabled := CheckBoxChangecopies.Checked;
  UpDownCopies.Enabled := CheckBoxChangecopies.Checked;
end;
procedure TFormloadpressplan.CheckBoxOnlyShowDefaultPressPublicationsClick(Sender: TObject);
begin
   FillPublicationCombo();
end;

procedure TFormloadpressplan.autosetCurrentproddata;
Var
  L            : Tlistitem;
  T            : string;
  contOK       : boolean;
  i, i2, akted : Longint;
begin
  try
    if ListBoxpresstemplatename.ItemIndex < 0 then exit;
    NumberOfEditionsInProd := 1;
    UsingProddata := true;
    Formeditionorder.listbox1.Items.Clear;
    akted := -1;
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('Select distinct p1.editionid,p1.PressSectionNumber,e.Name from pagetable p1 (NOLOCK), editionnames e (nolock) ');
    DataM1.Query1.SQL.Add('Where p1.productionid = ' + IntToStr(plateframesproductionid));
    DataM1.Query1.SQL.Add('And p1.pressid = ' + IntToStr(plateframespressid));
    DataM1.Query1.SQL.Add('And p1.editionid = e.editionid ');
    DataM1.Query1.SQL.Add('Order by p1.PressSectionNumber,p1.editionid ');
    DataM1.Query1.Open;
    NumberOfEditionsInProd := 0;
    While not DataM1.Query1.Eof do
    Begin
      if akted <> DataM1.Query1.Fields[0].AsInteger then
      begin
        Formeditionorder.listbox1.Items.add(DataM1.Query1.Fields[2].AsString);
        akted := DataM1.Query1.Fields[0].AsInteger;
        Inc(NumberOfEditionsInProd);
      end;
      DataM1.Query1.Next;
    end;
    DataM1.Query1.Close;
    Formeditionorder.Panel3.Visible := false;
    contOK := false;
    if (Prefs.PlanningAutoSetEditionsOnLoad) OR (Formeditionorder.ListBox1.Items.Count = 1) then
      contOK := true
    else
    begin
      if Formeditionorder.ShowModal = mrYes then
      begin
        contOK := true;
      end;
    end;

    if contOK then
    begin
      Formeditionorder.Panel3.Visible := true;
      akted := PBExListview1.Items.Count;
      T := PBExListview1.Items[0].SubItems[0];
      For i := 0 to akted-1 do
      begin
        PBExListview1.Items[i].SubItems[0] := Formeditionorder.ListBox1.Items[0];
      end;
      For i := 0 to akted-1 do
      begin
        For i2 := 1 to Formeditionorder.ListBox1.Items.Count-1 do
        begin
          L := PBExListview1.Items.Add;
          l.Caption := PBExListview1.Items[i].Caption;
          l.SubItems.add(Formeditionorder.ListBox1.Items[i2]);
          l.SubItems.add(PBExListview1.Items[i].SubItems[1]);
          l.SubItems.add(PBExListview1.Items[i].SubItems[2]);
          l.SubItems.add(PBExListview1.Items[i].SubItems[3]);
        end;
      end;
    end;
    Formeditionorder.Panel3.Visible := true;
  except
    Formeditionorder.Panel3.Visible := true;
  end;
end;
procedure TFormloadpressplan.Changeoffset1Click(Sender: TObject);
begin
  Formeditatext.Caption := 'Change page offset';
  Formeditatext.ComboBox1.Items.Clear;
  Formeditatext.ComboBox1.Text := PBExListview1.Selected.SubItems[3];
  if Formeditatext.ShowModal = mrok then
  begin
    Offsetchanged := true;
    PBExListview1.Selected.SubItems[3] := Formeditatext.ComboBox1.Text;
  end;
end;
procedure TFormloadpressplan.CheckBoxusecurprodClick(Sender: TObject);
begin
  if ListBoxpresstemplatename.itemindex < 0 then exit;
  Sectionschanged := false;
  Editionchanged := false;
  Offsetchanged  := false;
  NEdchanges := 0;
  setlistdata;
  makeplanname;
  if CheckBoxusecurprod.checked then
    autosetCurrentproddata;
end;

procedure TFormloadpressplan.setapplyeds;
Var
  I : Longint;
  Npteds : Longint;
  pteds : array[1..100] of longint;
Begin
  NEdchanges := 0;
  Npteds := 0;
  DataM1.Query1.SQL.clear;
  DataM1.Query1.SQL.Add('Select distinct editionid from pagetable (nolock) ');
  DataM1.Query1.SQL.Add('Where productionid = ' + IntToStr(plateframesproductionid));
  DataM1.Query1.open;
  While not DataM1.Query1.eof do
  begin
    Inc(Npteds);
    pteds[Npteds] := DataM1.Query1.fields[0].AsInteger;
    DataM1.Query1.next;
  end;
  DataM1.Query1.close;

  if Npteds = 1 then
  begin
    if pteds[1] <> tnames1.editionnametoid(PBExListview1.items[0].SubItems[0]) then
    begin
      Inc(NEdchanges);
      Edchanges[NEdchanges].fromed := tnames1.editionnametoid(PBExListview1.items[0].SubItems[0]);
      Edchanges[NEdchanges].toed := pteds[1];
      Editionchanged := true;
      PBExListview1.Enabled := false;
      PBExListview1.Columns[0].Width := 1;
      For i := 0 to PBExListview1.items.Count-1 do
        PBExListview1.items[i].SubItems[0] := tnames1.editionIDtoname(pteds[1]);
    end;
  end;
end;

procedure TFormloadpressplan.setapplysec;
var
  asec,Nsec : Integer;
Begin
  Nsec := 0;
  asec := -21;
  if Itspartial then
  begin
    DataM1.Query1.SQL.clear;
    DataM1.Query1.SQL.Add('Select distinct sectionid from pagetable (nolock) ');
    DataM1.Query1.SQL.Add('Where pressrunid = ' + IntToStr(Formprodplan.PartialOrgpressrunid));
    DataM1.Query1.Open;
    While not DataM1.Query1.Eof do
    begin
      if asec <> DataM1.Query1.Fields[0].AsInteger then
      begin
        Inc(Nsec);
        asec := DataM1.Query1.Fields[0].AsInteger;
      end;
      if nsec < 2 then
      begin
        DataM1.Query1.Next;
      end
      else
        break;
    end;
    DataM1.Query1.Close;
    if (PBExListview1.Items.Count = 1) and (nsec = 1) then
    begin
      if tnames1.sectionIDtoname(asec) <> PBExListview1.Items[0].SubItems[1] then
      begin
        PBExListview1.Items[0].SubItems[1] := tnames1.sectionIDtoname(asec);
        Sectionschanged := true;
      end;
    end;
  end;
end;
Procedure TFormloadpressplan.Setdeadl;
var
  a : TDateTime;
Begin
  a := formmain.Getdafaultdeadline(DateTimePicker1loadplan.date,tnames1.publicationnametoid(ComboBoxpublication.text));
  DateTimePickerdeadlinedate.Date := DateOf(a);
  DateTimePickerdeadtime.Time := TimeOf(a);
end;

procedure TFormloadpressplan.Button3Click(Sender: TObject);
begin
  if PBExListview1.Selected = nil then exit;
  if FormChangesectionnamebyload.ShowModal = mrok then
  begin
    PBExListview1.Selected.SubItems[1] := FormChangesectionnamebyload.ListBox1.Items[FormChangesectionnamebyload.ListBox1.Itemindex];
    Sectionschanged := true;
  end;
end;
procedure TFormloadpressplan.ComboBoxtemplateChange(Sender: TObject);
begin
  CheckIfReady;
end;
procedure TFormloadpressplan.CheckIfReady;
begin
   BitBtn1.Enabled := (ListBoxpresstemplatename.Items.Count > 0) and (ComboBoxpublication.ItemIndex >= 0);
end;

end.






