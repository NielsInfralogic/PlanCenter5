unit ULoadstbplan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, System.UITypes,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, {PBExListview,} Mask, Menus,
  CheckLst;

type
  TFormLoadstbplan = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Button2: TButton;
    Panel3: TPanel;
    Image2: TImage;
    Label7: TLabel;
    Label8: TLabel;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label1: TLabel;
    Label12: TLabel;
    Label2: TLabel;
    Label14: TLabel;
    Label11: TLabel;
    RadioGroupApproval: TRadioGroup;
    RadioGrouplocked: TRadioGroup;
    ComboBoxpublication: TComboBox;
    ComboBoxtemplate: TComboBox;
    Editpriority: TEdit;
    UpDown1: TUpDown;
    Button1: TButton;
    Panelonlynonepro: TPanel;
    Label6: TLabel;
    Label13: TLabel;
    Label3: TLabel;
    Label15: TLabel;
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
    CheckBoxApplyonlyplannedcolors: TCheckBox;
    Editplanname: TEdit;

    DateTimePicker1loadplan: TDateTimePicker;
    Editweek: TEdit;
    UpDownweek: TUpDown;
    Editcreep: TEdit;
    Panel2: TPanel;
    GroupBox4: TGroupBox;
    Label5: TLabel;
    Label10: TLabel;
    CheckBoxshowall: TCheckBox;
    ComboBoxpublfilt: TComboBox;
    ComboBoxNpage: TComboBox;
    CheckBoxusecurprod: TCheckBox;
    GroupBox1: TGroupBox;
    Splitter1: TSplitter;
    ListBoxpresstemplatename: TListBox;
    Panel4: TPanel;
    PBExListview1: TListview;
    Panel5: TPanel;
    Buttonedit: TButton;
    CheckBoxoffsetinsreted: TCheckBox;
    CheckBoxignoreplanedition: TCheckBox;
    Button3: TButton;
    ListViewbefore: TListView;
    ListViewplans: TListView;
    PopupMenu1: TPopupMenu;
    changesectionname1: TMenuItem;
    Changeeditionname1: TMenuItem;
    Loadfromproduction1: TMenuItem;
    Changeoffset1: TMenuItem;
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
    procedure ComboBoxstackposChange(Sender: TObject);
  private
    activated: boolean;
    procedure Setdeadl;
    procedure setlistdata;
    procedure setapplysec;
    procedure setapplyeds;
    procedure loadAvailplans;
    procedure Checkifready;
    procedure loadplanlist;
    procedure setposibletemplates;
    procedure makeplanname;
{    function DateOfWeek(Year: Word; Week: Word; DayOfWeek: Word; var Day: Word;
                                                              var Month: Word): Longint;}

  public
    Platetempldbversion: Longint;
    Applingtoplan: boolean;
    partialoffstart: Longint;
    Itspartial: boolean;
    UsingProddata: boolean;
    Partialloadpublication: string;
    NumberOfEditionsInProd: Longint;
    EditionsInProd: array [1 .. 100] of Longint;
    Insertedplan: boolean;
    NEdchanges: Longint;
    Edchanges: array [1 .. 100] of record fromed: Longint;
    toed: Longint;
end;

editionlist: string;
sectionlist: string;
maxpages: Longint;
defaultpublid: Longint;
selectedplanid: Integer;

selectedpressID: Integer;
deadline: tdatetime;
creep: Double;
Applytopublid: Longint;
Applytopprodname: string;
Applytodate: tdatetime;
Sectionschanged: Boolean;
Editionchanged: Boolean;
Offsetchanged: Boolean;

procedure autosetCurrentproddata;
procedure Autosetifone;
procedure init;

end;

var
  FormLoadstbplan: TFormLoadstbplan;

implementation

{$R *.dfm}

uses
  utypes, DateUtils, udata, umain, Usettings, UPlanframe, UApplyplan,
  Uprodplan, Unewpubl, Ulogin, Ueditplan, USecbyload, Uhangeednamebyload,
  Ueditplannames, Ueditionorder, Ueditatextcombo, ULoadDlls, UUtils;

procedure TFormLoadstbplan.Autosetifone;
var
  secid, i: Integer;
  Nsecs: Integer;

begin
  secid := 0;
  Nsecs := 0;
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('Select distinct Sectionid from pagetable (nolock) ');
  DataM1.Query1.SQL.Add('where publicationid = ' +
    inttostr(tnames1.publicationnametoid(ComboBoxpublication.Text)));
  DataM1.Query1.SQL.Add('and productionid = ' +
    inttostr(plateframesproductionid));
  // DataM1.Query1.SQL.add(' and '+  DataM1.makedatastr('', ));
  DataM1.Query1.open;
  while not DataM1.Query1.eof do
  begin
    Inc(Nsecs);
    secid := DataM1.Query1.fields[0].AsInteger;
    DataM1.Query1.next;
  end;
  DataM1.Query1.close;

  if Nsecs = 1 then
  begin
    for i := 0 to PBExListview1.items.count - 1 do
    begin
      PBExListview1.items[i].SubItems[1] := tnames1.sectionIDtoname(secid);
    end;

    Sectionschanged := true;
  end;

end;

procedure TFormLoadstbplan.init;
var
  deadl: tdatetime;
  Year, Month, Day: Word;
//  i: Longint;

begin
  creep := 0;
  DateTimePicker1loadplan.enabled := true;
  ComboBoxpublication.enabled := true;
  Editcreep.Text := '0';
  ComboBoxpublication.items.Clear;

  ComboBoxpublication.items.Clear;
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('Select longname,type from InkAliases');
  DataM1.Query1.SQL.Add('where type = ' + '''' + 'Publication' + '''');
  DataM1.Query1.SQL.Add('and pressid = 3 ');
  DataM1.Query1.SQL.Add('order by longname');
  DataM1.Query1.Open;
  while not DataM1.Query1.Eof do
  begin
    ComboBoxpublication.items.Add(DataM1.Query1.fields[0].asstring);
    DataM1.Query1.next;
  end;
  DataM1.Query1.close;

  if (ComboBoxpublication.items.Count>15) then
    ComboBoxpublication.DropDownCount :=  15;
  if (ComboBoxpublication.items.Count>30) then
    ComboBoxpublication.DropDownCount :=  30;

  ComboBoxpublication.Itemindex := 0;

  Platetempldbversion := 1;
  Editplanname.enabled := true;
  DateTimePicker1loadplan.Datetime := now;

  DateTimePicker1loadplan.Datetime :=
    IncDay(DateTimePicker1loadplan.Datetime, 1);
  if Itspartial then
    DateTimePicker1loadplan.Datetime := Applytodate;

  if formmain.TreeViewplan.Selected <> nil then
  begin
    if formmain.TreeViewplan.Selected.Level > 1 then
    begin
      DateTimePicker1loadplan.Date :=
        Tplantreedata(formmain.TreeViewplan.Selected.Data^).pubdate;
    end;
  end;
  ComboBoxpublication.Itemindex := 0;

  ComboBoxpublication.Itemindex := ComboBoxpublication.items.IndexOf
    (tnames1.publicationIDtoname(defaultpublid));
  if ComboBoxpublication.Itemindex < 0 then
    ComboBoxpublication.Itemindex := 0;

  DateTimePicker1loadplan.enabled := true;
  deadl := DateTimePicker1loadplan.Datetime;
  DecodeDate(deadl, Year, Month, Day);
  deadl := EncodeDateTime(Year, Month, Day, 0, 0, 0, 0);
  deadl := IncHour(deadl, 1);
  DateTimePickerdeadlinedate.Date := deadl;
  DateTimePickerdeadtime.Time := deadl;

  ComboBoxpublfilt.items.Clear;
  ComboBoxpublfilt.items.Add('*');
  Button1.enabled := true;
  ComboBoxpublfilt.Itemindex := 0;

  ComboBoxNpage.Itemindex := 0;
  if formprodplan.Editmode = PLANADDMODE_APPLY then
    ComboBoxNpage.Text := inttostr(maxpages);

  if Applytopublid > -1 then
  begin
    ComboBoxpublication.Itemindex := ComboBoxpublication.items.IndexOf
      (tnames1.publicationIDtoname(Applytopublid));
    // ComboBoxpublication
    DateTimePicker1loadplan.Date := Applytodate;
    DateTimePicker1loadplan.enabled := false;
    ComboBoxpublication.enabled := false;
    Button1.enabled := false;
    Editplanname.enabled := false;
    Editplanname.Text := Applytopprodname;
  end;

  loadplanlist;

  BitBtn1.enabled := ListBoxpresstemplatename.items.count > 0;

  makeplanname;
  setposibletemplates;

  if Applytopublid > -1 then
  begin
    Editplanname.Text := Applytopprodname;
    Editplanname.refresh;
  end;

  if Itspartial then
  begin
    ComboBoxpublication.Itemindex := ComboBoxpublication.items.IndexOf
      (tnames1.publicationIDtoname(Applytopublid));
    DateTimePicker1loadplan.Date := Applytodate;

  end;

  if (Prefs.PlanningUsePublicationDefaultlPriority) then
  begin
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('Select Priority from publicationtemplates');
    DataM1.Query1.SQL.Add('where PublicationID = ' + IntToStr(tnames1.publicationnametoid(ComboBoxpublication.Text)));
    DataM1.Query1.Open;
    if not DataM1.Query1.Eof then
    begin
      UpDown1.Position := DataM1.Query1.fields[0].AsInteger;
      Editpriority.Text := IntToStr(UpDown1.Position);
    end;

    DataM1.Query1.Close;
  end;
  if CheckBoxusecurprod.checked then
  begin
    autosetCurrentproddata;

  end;
  ComboBoxpublication.Itemindex := 0;

end;

procedure TFormLoadstbplan.BitBtn1Click(Sender: TObject);
var
  Year, Month, Day, Hour, Min, Sec, MSec: Word;
begin
  if ComboBoxtemplate.Text = 'No change' then
  begin
    MessageDlg('Please select a template', mtInformation, [mbOk], 0);

    Exit;

  end
  else
  begin
    plateframesloadedname := ListBoxpresstemplatename.items
      [ListBoxpresstemplatename.Itemindex];
    creep := strtofloat(Editcreep.Text);
    FormApplyproduction.creep := creep;
    FormApplyproduction.Editcreep.Text := Editcreep.Text;
    DecodeDate(DateTimePickerdeadlinedate.Date, Year, Month, Day);
    DecodeTime(DateTimePickerdeadtime.Time, Hour, Min, Sec, MSec);
    FormApplyproduction.CheckBoxAllowunplannedcolors.checked :=
      CheckBoxAllowunplannedcolors.checked;
    deadline := EncodeDateTime(Year, Month, Day, Hour, Min, Sec, MSec);

    formprodplan.Applyonlyplannedcolors :=
      CheckBoxApplyonlyplannedcolors.checked;
    FormApplyproduction.GroupBoxRipSetup.Visible := false; //(ApletoUseRipSetupNameSetup)
//      and (tnames1.RipSetupnames.count > 0);
    FormApplyproduction.ComboBoxRipSetup.items.Clear;
    FormApplyproduction.ComboBoxRipSetup.items := ComboBoxRipSetup.items;
    FormApplyproduction.ComboBoxRipSetup.Itemindex :=
      ComboBoxRipSetup.Itemindex;

    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add
      ('Select distinct p1.presstemplateid from  presstemplatenames p1, presstemplate p2');
    DataM1.Query1.SQL.Add('where p1.presstemplateid = p2.presstemplateid');
    DataM1.Query1.SQL.Add('and p1.name = ' + '''' +
      ListBoxpresstemplatename.items
      [ListBoxpresstemplatename.Itemindex] + '''');
    DataM1.Query1.SQL.Add('and p2.pressid = ' + inttostr(selectedpressID));
    XMLPressID := selectedpressID;
    DataM1.Query1.open;
    if not DataM1.Query1.eof then
    begin
      selectedplanid := DataM1.Query1.fieldbyname('presstemplateid').AsInteger;
    end;
    DataM1.Query1.close;

    if Applytopublid > -1 then
    begin
      Editplanname.Text := Applytopprodname;

    end;
    plateframesproductionname := Editplanname.Text;
  end;
end;

procedure TFormLoadstbplan.FormCreate(Sender: TObject);
var
  i: Longint;
begin
  defaultpublid := 0;
  for i := 0 to 1000 do
  begin
    ComboBoxNpage.items.Add(inttostr(i * 2));
  end;
  activated := false;
  DateTimePicker1loadplan.Datetime := now;
  DateTimePicker1loadplan.Time := 0;
end;

procedure TFormLoadstbplan.DateTimePicker1loadplanChange(Sender: TObject);
begin
  makeplanname;
  if CheckBoxusecurprod.checked then
  begin
    Sectionschanged := false;
    Editionchanged := false;
    Offsetchanged := false;
    NEdchanges := 0;
    setlistdata;
    makeplanname;
    autosetCurrentproddata;
  end;
  Setdeadl;
  // UpDownweek.Position := WeekOf(DateTimePicker1.Date);
end;

procedure TFormLoadstbplan.ComboBoxpublicationChange(Sender: TObject);
var
  deftmplid: Longint;
begin
  makeplanname;
  deftmplid := -1;
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('Select priority,templateid from publicationtemplates');
  DataM1.Query1.SQL.Add('where publicationid = ' +
    inttostr(tnames1.publicationnametoid(ComboBoxpublication.Text)));
  DataM1.Query1.SQL.Add('and pressid = ' + inttostr(selectedpressID));

  DataM1.Query1.open;
  if not DataM1.Query1.eof then
  begin
    UpDown1.Position := DataM1.Query1.fields[0].AsInteger;
    Editpriority.Text := IntToStr(UpDown1.Position);
    deftmplid := DataM1.Query1.Fields[1].AsInteger;
  end;
  if Prefs.debug then
    DataM1.Query1.SQL.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\' + 'loadpressplan1.sql');
  DataM1.Query1.close;

  if deftmplid > -1 then
  begin
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('Select templatename from templateconfigurations');
    DataM1.Query1.SQL.Add('where templateid = ' + inttostr(deftmplid));
    DataM1.Query1.open;
    if not DataM1.Query1.eof then
    begin
      ComboBoxtemplate.Itemindex := ComboBoxtemplate.items.IndexOf(DataM1.Query1.fields[0].asstring);
    end;
    if Prefs.debug then
      DataM1.Query1.SQL.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\' + 'loadpressplan2.sql');
    DataM1.Query1.close;
  end;

  if (Prefs.PlanLoadDefaultToNoTemplateChange) or
    (ComboBoxtemplate.Itemindex < 0) then
    ComboBoxtemplate.Itemindex := 0;
  if CheckBoxusecurprod.checked then
  begin
    Sectionschanged := false;
    Editionchanged := false;
    Offsetchanged := false;
    NEdchanges := 0;
    setlistdata;
    makeplanname;
    autosetCurrentproddata;
  end;
  Checkifready;

end;

procedure TFormLoadstbplan.ComboBoxstackposChange(Sender: TObject);
begin

end;

{function TFormLoadstbplan.DateOfWeek(Year: Word; Week: Word; DayOfWeek: Word;
  var Day: Word; var Month: Word): Longint;
var
  dt: tdatetime;
  Y, M, D: Word;
begin
  result := 0;

  try
    dt := EncodeDateWeek(Year, Week, DayOfWeek);
    DecodeDate(dt, Y, M, D);
    Day := D;
    Month := M;
    result := 1;
  except
    result := 0;
  end;

end;
}
procedure TFormLoadstbplan.ComboBoxpresstemplatenameChange(Sender: TObject);
var
  id, i: Integer;
begin
  id := 0;
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add
    ('Select top 1 p1.publicationid,p1.presstemplateid,p2.presstemplateid,p2.name  from presstemplate p1, presstemplatenames p2');
  DataM1.Query1.SQL.Add('where p1.presstemplateid = p2.presstemplateid');
  DataM1.Query1.SQL.Add('and  p2.name = ' + '''' +
    ListBoxpresstemplatename.items[ListBoxpresstemplatename.Itemindex] + '''');
  DataM1.Query1.open;

  if not DataM1.Query1.eof then
  begin
    id := DataM1.Query1.fieldbyname('publicationid').AsInteger;
  end;
  DataM1.Query1.close;
  for i := 0 to ComboBoxpublication.items.count - 1 do
  begin
    if ComboBoxpublication.items[i] = tnames1.publicationIDtoname(id) then
    begin
      ComboBoxpublication.Itemindex := i;
      makeplanname;
      break;
    end;
  end;
  if Applytopublid > -1 then
  begin
    ComboBoxpublication.Itemindex := ComboBoxpublication.items.IndexOf
      (tnames1.publicationIDtoname(Applytopublid));
    DateTimePicker1loadplan.Date := Applytodate;
    DateTimePicker1loadplan.enabled := false;
    ComboBoxpublication.enabled := false;
  end;

end;

procedure TFormLoadstbplan.setposibletemplates;
var
  i, akttemplateid: Longint;
begin
  akttemplateid := 0;
  try
    if ListBoxpresstemplatename.Itemindex < 0 then
      Exit;

    ComboBoxtemplate.items.Clear;
    ComboBoxtemplate.items.Add('No change');
    if ListBoxpresstemplatename.items.count > 0 then
    begin
      DataM1.Query1.SQL.Clear;
      DataM1.Query1.SQL.Add
        ('Select distinct p1.name,p1.presstemplateid,p2.presstemplateid,p2.templateid from presstemplatenames p1, presstemplate p2');
      DataM1.Query1.SQL.Add('where p1.presstemplateid = p2.presstemplateid');
      DataM1.Query1.SQL.Add('and p1.name = ' + '''' +
        ListBoxpresstemplatename.items
        [ListBoxpresstemplatename.Itemindex] + '''');
      DataM1.Query1.open;
      if not DataM1.Query1.eof then
      begin
        akttemplateid := DataM1.Query1.fields[3].AsInteger;
      end;
      DataM1.Query1.close;
      akttemplateid := inittypes.gettemplatenumberfromID(akttemplateid);
      for i := 1 to NPlatetemplateArray do
      begin
        if (PlatetemplateArray[i].PressID = selectedpressID) and
          (((PlatetemplateArray[i].ISdouble = PlatetemplateArray[akttemplateid]
          .ISdouble) and (PlatetemplateArray[i].PagesAcross = PlatetemplateArray
          [akttemplateid].PagesAcross) and
          (PlatetemplateArray[i].PagesDown = PlatetemplateArray[akttemplateid]
          .PagesDown) and ((PlatetemplateArray[i].NupOnplate = 1) or
          ((PlatetemplateArray[i].PageRotationList[1] mod 2)
          = (PlatetemplateArray[akttemplateid].PageRotationList[1] mod 2)))) or
          (Itspartial)) then
        begin
          ComboBoxtemplate.items.Add(PlatetemplateArray[i].TemplateName);
        end;
      end;
      ComboBoxtemplate.Itemindex := 0;
    end;
  except
  end;
end;

procedure TFormLoadstbplan.ListBoxpresstemplatenameClick(Sender: TObject);

begin
  Sectionschanged := false;
  Editionchanged := false;
  Offsetchanged := false;
  NEdchanges := 0;
  setlistdata;
  makeplanname;

  if CheckBoxusecurprod.checked then
  begin
    autosetCurrentproddata;
    Autosetifone;
  end
  else
  begin
    Autosetifone;

  end;

  ComboBoxpublication.Itemindex := 0;

  ComboBoxpublicationChange(self);
  Checkifready;
end;

procedure TFormLoadstbplan.setlistdata;
var
  l: tlistitem;
  i, i2: Longint;
  T: string;

  rpsetinpresstemple: boolean;
begin
  try
    NumberOfEditionsInProd := 1;
    UsingProddata := false;
    Formeditplan.maxpages := 0;

    Platetempldbversion := 1;

    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('Select distinct p2.name,p1.presstemplateid,p1.publicationid,p1.editionid,p1.sectionid, count(distinct p1.pagename) as antal,p1.inserted from presstemplate p1, presstemplatenames p2');

    DataM1.Query1.SQL.Add('where p1.presstemplateid = p2.presstemplateid');
    DataM1.Query1.SQL.Add('and p1.pressid = ' + inttostr(selectedpressID));
    DataM1.Query1.SQL.Add('and p1.pagetype <> 3');
    DataM1.Query1.SQL.Add('and p2.name = ' + '''' +
      ListBoxpresstemplatename.items
      [ListBoxpresstemplatename.Itemindex] + '''');
      DataM1.Query1.SQL.Add('GROUP BY p2.name,p1.presstemplateid,p1.publicationid,p1.editionid,p1.sectionid,p1.inserted');

    DataM1.Query1.open;
    PBExListview1.items.Clear;
    while not DataM1.Query1.eof do
    begin
      Insertedplan := DataM1.Query1.fields[6].AsInteger = 1;
      selectedplanid := DataM1.Query1.fields[1].AsInteger;
      l := PBExListview1.items.Add;
      l.Caption := tnames1.publicationIDtoname
        (DataM1.Query1.fields[2].AsInteger);
      l.SubItems.Add(tnames1.editionIDtoname(DataM1.Query1.fields[3]
        .AsInteger));
      l.SubItems.Add(tnames1.sectionIDtoname(DataM1.Query1.fields[4]
        .AsInteger));
      l.SubItems.Add(DataM1.Query1.fields[5].asstring);
      if dbversion > 1 then
      begin
        if Itspartial then
        begin
          if FormLoadstbplan.partialoffstart = 1 then
            T := '1'
          else
            T := inttostr(FormLoadstbplan.partialoffstart - 1);
          l.SubItems.Add(T);
        end
        else
          l.SubItems.Add('0');
      end
      else
        l.SubItems.Add('0');

      Inc(Formeditplan.maxpages, DataM1.Query1.fields[5].AsInteger);
      DataM1.Query1.next;
    end;
    DataM1.Query1.close;
    if PBExListview1.items.count = 1 then
      Insertedplan := true;
    if PBExListview1.items.count > 0 then
      ComboBoxpublication.Itemindex := ComboBoxpublication.items.IndexOf
        (PBExListview1.items[0].Caption);

    Loadfromproduction1.enabled := true;
    T := PBExListview1.items[0].SubItems[0];
    for i := 0 to PBExListview1.items.count - 1 do
    begin
      if T <> PBExListview1.items[i].SubItems[0] then
      begin
        Loadfromproduction1.enabled := false;
      end;
    end;
    CheckBoxusecurprod.enabled := false;
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('Select distinct editionid from presstemplate');
    DataM1.Query1.SQL.Add('where presstemplateid = ' +
      inttostr(selectedplanid));
    i := 0;
    DataM1.Query1.open;
    while not DataM1.Query1.eof do
    begin
      Inc(i);
      DataM1.Query1.next;
    end;
    DataM1.Query1.close;

    if GroupBoxRipSetup.Visible then
    begin
      ComboBoxRipSetup.items.Clear;
      DataM1.Query1.SQL.Clear;
      DataM1.Query1.SQL.Add('Select name from RipSetupNames');
      DataM1.Query1.SQL.Add('Where pressid  < 1 or pressid  = ' +
        inttostr(selectedpressID));
      DataM1.Query1.SQL.Add('order by name');
      DataM1.Query1.open;
      while not DataM1.Query1.eof do
      begin
        ComboBoxRipSetup.items.Add(DataM1.Query1.fields[0].asstring);
        DataM1.Query1.next;
      end;
      DataM1.Query1.close;

      try
        DataM1.Query1.SQL.Clear;
        DataM1.Query1.SQL.Add('Select top 1 * from presstemplate');
        DataM1.Query1.SQL.Add('where presstemplateid = ' +
          inttostr(selectedplanid));
        rpsetinpresstemple := false;
        DataM1.Query1.open;
        for i := 0 to DataM1.Query1.fields.count - 1 do
        begin
          if uppercase(DataM1.Query1.fields[i].FieldName) = 'RIPSETUPID' then
          begin
            rpsetinpresstemple := true;
            break;
          end;
        end;
        DataM1.Query1.close;
        if rpsetinpresstemple then
        begin
          DataM1.Query1.SQL.Clear;
          DataM1.Query1.SQL.Add
            ('Select distinct RipSetupID from presstemplate');
          DataM1.Query1.SQL.Add('where presstemplateid = ' +
            inttostr(selectedplanid));
          i := 0;
          DataM1.Query1.open;
          if not DataM1.Query1.eof then
          begin
            ComboBoxRipSetup.Itemindex := ComboBoxRipSetup.items.IndexOf
              (tnames1.ripsetupIDtoname(DataM1.Query1.fields[0].AsInteger));
          end;
          DataM1.Query1.close;
        end;
      except
      end;
    end;

    CheckBoxusecurprod.enabled := (i < 2) and
      (formmain.TreeViewplan.Selected.Level > 1);
    Buttonedit.enabled := true;
    // PBExListview1.Items.count = 1;

    if Applytopublid > -1 then
    begin
      ComboBoxpublication.Itemindex := ComboBoxpublication.items.IndexOf
        (tnames1.publicationIDtoname(Applytopublid));
      DateTimePicker1loadplan.Date := Applytodate;
      DateTimePicker1loadplan.enabled := false;
      ComboBoxpublication.enabled := false;
      Button1.enabled := false;
    end;

    if Itspartial then
    begin
      for i := 0 to PBExListview1.items.count - 1 do
      begin

      end;
    end;

    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add
      ('Select distinct plancreep,copynumber from presstemplate');
    DataM1.Query1.SQL.Add('where presstemplateid = ' +
      inttostr(selectedplanid));
    DataM1.Query1.SQL.Add('and pressid = ' + inttostr(selectedpressID));
    DataM1.Query1.open;
    if not DataM1.Query1.eof then
    begin
      UpDownCopies.Position := DataM1.Query1.fields[1].AsInteger;
      Editcreep.Text := DataM1.Query1.fields[0].asstring;
    end;
    DataM1.Query1.close;

    Buttonedit.enabled := Insertedplan;

  except
  end;

  setposibletemplates;
  if Applytopublid > -1 then
  begin
    ComboBoxpublication.Itemindex := ComboBoxpublication.items.IndexOf
      (tnames1.publicationIDtoname(Applytopublid));
    DateTimePicker1loadplan.Date := Applytodate;
    DateTimePicker1loadplan.enabled := false;
    ComboBoxpublication.enabled := false;
  end;

  ListViewbefore.items.Clear;

  for i := 0 to PBExListview1.items.count - 1 do
  begin
    l := ListViewbefore.items.Add;
    l.Caption := PBExListview1.items[i].Caption;
    for i2 := 0 to PBExListview1.items[i].SubItems.count - 1 do
      l.SubItems.Add(PBExListview1.items[i].SubItems[i2])
  end;

  PBExListview1.Columns[0].Width := 68;
  // (Not itspartial) and
  if (Applingtoplan) then
  begin
    PBExListview1.Columns[0].Width := 1;
    setapplyeds;
    setapplysec;

  end;
  BitBtn1.enabled := PBExListview1.items.count > 0;
  if (Prefs.PlanningClearPubliationsOnLoad) then
    ComboBoxpublication.Itemindex := -1;
end;

procedure TFormLoadstbplan.FormActivate(Sender: TObject);

begin
  loadAvailplans;
  PBExListview1.enabled := true;
  PBExListview1.items.Clear;
  BitBtn1.enabled := false;
  GroupBoxRipSetup.Visible := false; //(ApletoUseRipSetupNameSetup) and
//    (tnames1.RipSetupnames.count > 0);
  ComboBoxRipSetup.items := tnames1.RipSetupnames;

  CheckBoxApplyonlyplannedcolors.Checked := Prefs.ApplyOnlyPlannedColors;

  EditCopies.Enabled := CheckBoxChangecopies.Checked;
  UpDownCopies.Enabled := CheckBoxChangecopies.Checked;
  Setdeadl;

  if (Prefs.Proversion = 2) then
  begin
    CheckBoxoffsetinsreted.Visible := false;
    CheckBoxignoreplanedition.Visible := false;
    Panelonlynonepro.Visible := false;
  end
  else
  begin
    Panelonlynonepro.Visible := true;
  end;

end;

procedure TFormLoadstbplan.loadAvailplans;
var
  i: Longint;
begin
  try
    NumberOfEditionsInProd := 1;
    UsingProddata := false;
    Sectionschanged := false;
    Editionchanged := false;
    NEdchanges := 0;
    ComboBoxstackpos.items.Clear;
    for i := 0 to Length(Prefs.StackNamesList) - 1 do
      ComboBoxstackpos.items.Add(Prefs.StackNamesList[i]);
    ComboBoxstackpos.items.Insert(0, 'Planned');
    ComboBoxstackpos.Itemindex := 0;
    if not activated then
    begin
      CheckBoxAllowunplannedcolors.checked := Prefs.PlanningAllowUnplannedColors;
      activated := true;
    end;

  except
  end;

end;

procedure TFormLoadstbplan.CheckBoxshowallClick(Sender: TObject);
begin
  loadplanlist;
end;

procedure TFormLoadstbplan.loadplanlist;

procedure loadit;
var
//    l: tlistitem;
//    aktpress, presses, enkeletdoublet, broadtab,
   T
   //, t1, t2, t3
   : string;

    //nsec,  aktsec, i, i2: Longint;
//    secs: array [1 .. 5] of record npages: Longint;
    secname: string;

begin
  ListViewplans.items.Clear;
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('Select distinct p1.name,p1.presstemplateid,p2.presstemplateid,p2.pressid from  presstemplatenames p1, presstemplate p2');
  DataM1.Query1.SQL.Add('where p1.presstemplateid = p2.presstemplateid');
  DataM1.Query1.SQL.Add('and p2.pressid = ' + inttostr(selectedpressID));

  ListBoxpresstemplatename.items.Clear;

  DataM1.Query1.SQL.Add('order by p1.name');
  if Prefs.debug then
    DataM1.Query1.SQL.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\' + 'loadpressplannames.sql');

  DataM1.Query1.Open;

  while not DataM1.Query1.Eof do
  begin
    T := DataM1.Query1.fields[0].asstring;
    if Pos('T=', T) > 0 then
    begin
      ListBoxpresstemplatename.items.Add(DataM1.Query1.fields[0].asstring);
    end;
    DataM1.Query1.Next;
  end;
  DataM1.Query1.Close;

  DataM1.Query1.Open;

  while not DataM1.Query1.eof do
  begin
    T := DataM1.Query1.fields[0].asstring;
    if Pos('B=', T) > 0 then
    begin
      ListBoxpresstemplatename.items.Add(DataM1.Query1.fields[0].asstring);
    end;
    DataM1.Query1.next;
  end;
  DataM1.Query1.close;

end;

begin
  loadit;
  Sectionschanged := false;
  Editionchanged := false;
  NEdchanges := 0;
  if ListBoxpresstemplatename.items.count = 0 then
  begin
    CheckBoxshowall.checked := true;
    loadit;
  end;

  BitBtn1.enabled := ListBoxpresstemplatename.items.count > 0;

  if ListBoxpresstemplatename.items.count > 0 then
  begin
    // ListBoxpresstemplatename.Itemindex := 0;
    // setlistdata;
  end;

end;

procedure TFormLoadstbplan.ComboBoxpublfiltChange(Sender: TObject);
begin
  loadplanlist;
end;

procedure TFormLoadstbplan.ComboBoxNpageChange(Sender: TObject);
begin
  loadplanlist;
end;

procedure TFormLoadstbplan.EditcreepExit(Sender: TObject);
var
  crp: Double;
  res: boolean;
begin
  res := false;
  try
    if Editcreep.Text = '' then
      Editcreep.Text := '0';
    crp := strtofloat(Editcreep.Text);
    res := true;

  except

  end;

  if not res then
  begin
    MessageDlg(Editcreep.Text + ' ' + formmain.InfraLanguage1.Translate
      ('is not a valid creep value'), mtError, [mbOk], 0);
    Editcreep.Text := '0';
  end;

end;

procedure TFormLoadstbplan.Button1Click(Sender: TObject);

var
//  skaldeklarerespgadll: Longint;
  resulttat: Integer;

  aktpubl: string;

begin
  Runningdll := true;
  try
    try
      resulttat := ReConnectDB(DLLErrormessage);
      resulttat := JobNamesSetup(DLLErrormessage);
    except
    end;
  finally
    formmain.loadids('Load pressplan OK', false);
    aktpubl := ComboBoxpublication.Text;
    ComboBoxpublication.items := tnames1.publicationnames;
    ComboBoxpublication.Itemindex := ComboBoxpublication.items.IndexOf(aktpubl);

    Runningdll := false;
  end;

end;

procedure TFormLoadstbplan.makeplanname;
begin
  if Applytopprodname <> '' then
  begin
    Editplanname.Text := Applytopprodname;
  end
  else
  begin
    Editplanname.Text := formprodplan.createproductionname
      (tnames1.publicationnametoid(ComboBoxpublication.Text), selectedpressID,
      DateTimePicker1loadplan.Date);
  end;
end;

procedure TFormLoadstbplan.ButtoneditClick(Sender: TObject);
var
  i, i2: Longint;
  l: tlistitem;
  Nchecked: Integer;
begin
  Sectionschanged := false;

  Formeditplan.PBExListview1.items.Clear;
  for i := 0 to PBExListview1.items.count - 1 do
  begin
    l := Formeditplan.PBExListview1.items.Add;
    l.checked := true;
    l.Caption := PBExListview1.items[i].Caption;
    for i2 := 0 to PBExListview1.items[i].SubItems.count - 1 do
    begin
      l.SubItems.Add(PBExListview1.items[i].SubItems[i2]);
    end;
  end;

  if Formeditplan.ShowModal = mrok then
  begin
    setlistdata;
    Sectionschanged := false;
    Nchecked := 0;
    for i := 0 to Formeditplan.PBExListview1.items.count - 1 do
    begin
      if Formeditplan.PBExListview1.items[i].checked then
      begin
        Inc(Nchecked);
        if Formeditplan.PBExListview1.items[i].SubItems[2] <>
          PBExListview1.items[0].SubItems[2] then
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

      for i := 0 to Formeditplan.PBExListview1.items.count - 1 do
      begin
        if Formeditplan.PBExListview1.items[i].checked then
        begin
          l := PBExListview1.items.Add;
          l.Caption := Formeditplan.PBExListview1.items[i].Caption;
          for i2 := 0 to Formeditplan.PBExListview1.items[i].SubItems.count - 1 do
          begin
            l.SubItems.Add(Formeditplan.PBExListview1.items[i].SubItems[i2]);
          end;
        end;
      end;
    end;
  end;
end;

procedure TFormLoadstbplan.changesectionname1Click(Sender: TObject);
begin
  if PBExListview1.Selected = nil then
    Exit;
  if FormChangesectionnamebyload.ShowModal = mrok then
  begin
    PBExListview1.Selected.SubItems[1] :=
      FormChangesectionnamebyload.ListBox1.items
      [FormChangesectionnamebyload.ListBox1.Itemindex];
    Sectionschanged := true;
  end;
end;

procedure TFormLoadstbplan.Changeeditionname1Click(Sender: TObject);
begin
  if Formchednameload.ShowModal = mrok then
  begin
    Inc(NEdchanges);
    Edchanges[NEdchanges].fromed := tnames1.editionnametoid
      (PBExListview1.Selected.SubItems[0]);
    Edchanges[NEdchanges].toed := tnames1.editionnametoid
      (Formchednameload.ListBox1.items[Formchednameload.ListBox1.Itemindex]);
    PBExListview1.Selected.SubItems[0] := Formchednameload.ListBox1.items
      [Formchednameload.ListBox1.Itemindex];
    Editionchanged := true;
  end;

end;

procedure TFormLoadstbplan.EditweekChange(Sender: TObject);
var
  curweek, Year, Month, Day: Word;
  adate: tdatetime;
begin
  if Editweek.Text = '' then
    Exit;
  FormApplyproduction.ApplyweekNumber := strtoint(Editweek.Text);
  if strtoint(Editweek.Text) < 1 then
    Exit;
  if strtoint(Editweek.Text) > 53 then
    Exit;

  try
    curweek := WeekOf(now);
    DecodeDate(now, Year, Month, Day);
    if curweek > strtoint(Editweek.Text) then
      Inc(Year);
    adate := EncodeDateWeek(Year, strtoint(Editweek.Text), Prefs.DayOfWeek + 1);

    DateTimePicker1loadplan.Date := adate;

  except

  end;

end;

procedure TFormLoadstbplan.Button2Click(Sender: TObject);
begin
  FormEditplannames.ShowModal;
  loadAvailplans;
  loadplanlist;
end;

procedure TFormLoadstbplan.CheckBoxChangecopiesClick(Sender: TObject);
begin
  EditCopies.enabled := CheckBoxChangecopies.checked;
  UpDownCopies.enabled := CheckBoxChangecopies.checked;
end;

procedure TFormLoadstbplan.autosetCurrentproddata;
var
  l: tlistitem;
  T: string;
  contOK: boolean;
  i, i2, akted: Longint;
begin
  try
    if ListBoxpresstemplatename.Itemindex < 0 then
      Exit;
    NumberOfEditionsInProd := 1;
    UsingProddata := true;
    Formeditionorder.ListBox1.items.Clear;
    akted := -1;
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('Select distinct p1.editionid,p1.PressSectionNumber,e.Name from pagetable p1 (nolock), editionnames e (nolock) ');
    DataM1.Query1.SQL.Add('Where p1.productionid = ' + inttostr(plateframesproductionid));
    DataM1.Query1.SQL.Add('And p1.pressid = ' + inttostr(plateframespressid));
    DataM1.Query1.SQL.Add('And p1.editionid = e.editionid ');
    DataM1.Query1.SQL.Add('Order by p1.PressSectionNumber,p1.editionid ');
    DataM1.Query1.open;
    NumberOfEditionsInProd := 0;
    while not DataM1.Query1.eof do
    begin
      if akted <> DataM1.Query1.fields[0].AsInteger then
      begin
        Formeditionorder.ListBox1.items.Add(DataM1.Query1.fields[2].asstring);
        akted := DataM1.Query1.fields[0].AsInteger;
        Inc(NumberOfEditionsInProd);
      end;

      DataM1.Query1.next;
    end;

    DataM1.Query1.close;
    Formeditionorder.Panel3.Visible := false;

    contOK := false;

    if (Prefs.PlanningAutoSetEditionsOnLoad) or
      (Formeditionorder.ListBox1.items.count = 1) then
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
      akted := PBExListview1.items.count;
      T := PBExListview1.items[0].SubItems[0];
      for i := 0 to akted - 1 do
      begin
        PBExListview1.items[i].SubItems[0] :=
          Formeditionorder.ListBox1.items[0];
      end;
      for i := 0 to akted - 1 do
      begin
        for i2 := 1 to Formeditionorder.ListBox1.items.count - 1 do
        begin
          l := PBExListview1.items.Add;
          l.Caption := PBExListview1.items[i].Caption;
          l.SubItems.Add(Formeditionorder.ListBox1.items[i2]);
          l.SubItems.Add(PBExListview1.items[i].SubItems[1]);
          l.SubItems.Add(PBExListview1.items[i].SubItems[2]);
          l.SubItems.Add(PBExListview1.items[i].SubItems[3]);
        end;
      end;
    end;
    Formeditionorder.Panel3.Visible := true;

  except
    Formeditionorder.Panel3.Visible := true;

  end;
end;

procedure TFormLoadstbplan.Changeoffset1Click(Sender: TObject);
begin
  Formeditatext.Caption := 'Change page offset';
  Formeditatext.ComboBox1.items.Clear;
  Formeditatext.ComboBox1.Text := PBExListview1.Selected.SubItems[3];

  if Formeditatext.ShowModal = mrok then
  begin
    Offsetchanged := true;
    PBExListview1.Selected.SubItems[3] := Formeditatext.ComboBox1.Text;
  end;

end;

procedure TFormLoadstbplan.CheckBoxusecurprodClick(Sender: TObject);
begin
  if ListBoxpresstemplatename.Itemindex < 0 then
    Exit;
  if CheckBoxusecurprod.checked then
  begin
    Sectionschanged := false;
    Editionchanged := false;
    Offsetchanged := false;
    NEdchanges := 0;
    setlistdata;
    makeplanname;
    autosetCurrentproddata;
  end
  else
  begin
    Sectionschanged := false;
    Editionchanged := false;
    Offsetchanged := false;
    NEdchanges := 0;
    setlistdata;
    makeplanname;

  end;
end;

procedure TFormLoadstbplan.setapplyeds;
var
  i: Longint;
  Npteds: Longint;
  pteds: array [1 .. 100] of Longint;

begin

  NEdchanges := 0;
  Npteds := 0;
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('Select distinct editionid from pagetable (nolock) ');
  DataM1.Query1.SQL.Add('Where productionid = ' + IntToStr(plateframesproductionid));
  DataM1.Query1.open;
  while not DataM1.Query1.eof do
  begin
    Inc(Npteds);
    pteds[Npteds] := DataM1.Query1.fields[0].AsInteger;
    DataM1.Query1.next;
  end;
  DataM1.Query1.close;

  if Npteds = 1 then
  begin
    if pteds[1] <> tnames1.editionnametoid(PBExListview1.items[0].SubItems[0])
    then
    begin
      Inc(NEdchanges);
      Edchanges[NEdchanges].fromed := tnames1.editionnametoid
        (PBExListview1.items[0].SubItems[0]);
      Edchanges[NEdchanges].toed := pteds[1];

      Editionchanged := true;
      PBExListview1.enabled := false;
      PBExListview1.Columns[0].Width := 1;

      for i := 0 to PBExListview1.items.count - 1 do
        PBExListview1.items[i].SubItems[0] := tnames1.editionIDtoname(pteds[1]);
    end;
  end;
end;

procedure TFormLoadstbplan.setapplysec;

var
  asec, nsec: Longint;

begin

  nsec := 0;
  asec := -21;
  if Itspartial then
  begin
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('Select distinct sectionid from pagetable (nolock) ');
    DataM1.Query1.SQL.Add('Where pressrunid = ' +
      inttostr(formprodplan.PartialOrgpressrunid));
    DataM1.Query1.open;
    while not DataM1.Query1.eof do
    begin
      if asec <> DataM1.Query1.fields[0].AsInteger then
      begin
        Inc(nsec);
        asec := DataM1.Query1.fields[0].AsInteger;
      end;

      if nsec < 2 then
      begin
        DataM1.Query1.next;

      end
      else
        break;

    end;
    DataM1.Query1.close;

    if (PBExListview1.items.count = 1) and (nsec = 1) then
    begin
      if tnames1.sectionIDtoname(asec) <> PBExListview1.items[0].SubItems[1]
      then
      begin
        PBExListview1.items[0].SubItems[1] := tnames1.sectionIDtoname(asec);
        Sectionschanged := true;
      end;
    end;
  end;

end;

procedure TFormLoadstbplan.Setdeadl;
var
  a: tdatetime;
begin
  a := formmain.Getdafaultdeadline(DateTimePicker1loadplan.Date,
    tnames1.publicationnametoid(ComboBoxpublication.Text));
  DateTimePickerdeadlinedate.Date := dateof(a);
  DateTimePickerdeadtime.Time := timeof(a);
end;

procedure TFormLoadstbplan.Button3Click(Sender: TObject);
begin
  if PBExListview1.Selected = nil then
    Exit;
  if FormChangesectionnamebyload.ShowModal = mrok then
  begin
    PBExListview1.Selected.SubItems[1] :=
      FormChangesectionnamebyload.ListBox1.items
      [FormChangesectionnamebyload.ListBox1.Itemindex];
    Sectionschanged := true;
  end;

end;

procedure TFormLoadstbplan.ComboBoxtemplateChange(Sender: TObject);
begin
  Checkifready;
end;

procedure TFormLoadstbplan.Checkifready;
begin

end;

end.
















