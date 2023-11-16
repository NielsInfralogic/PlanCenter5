unit Uaddplan;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons, Vcl.Mask;
type
  TFormaddplan = class(TForm)
    Panel1: TPanel;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    RadioGroupApproval: TRadioGroup;
    RadioGrouplocked: TRadioGroup;
    BitBtn1: TBitBtn;
    Panel2: TPanel;
    Image1: TImage;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    ComboBoxIssue: TComboBox;
    Panel3: TPanel;
    Label2: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    DateTimePicker1: TDateTimePicker;
    ComboBoxpublication: TComboBox;
    Editpriority: TEdit;
    UpDown1: TUpDown;
    Panelbigwizz: TPanel;
    Label3: TLabel;
    Label8: TLabel;
    ComboBoxedition: TComboBox;
    Editplanname: TEdit;
    Editweek: TEdit;
    UpDownweek: TUpDown;
    Label9: TLabel;
    CheckBoxSchedulefilter: TCheckBox;
    CheckBoxOnlyShowDefaultPressPublications: TCheckBox;
    Label10: TLabel;
    EditPressName: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure ComboBoxpublicationChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditweekChange(Sender: TObject);
    procedure  FillPublicationCombo();
    procedure CheckBoxOnlyShowDefaultPressPublicationsClick(Sender: TObject);
    procedure DateTimePicker1Change(Sender: TObject);
  private
    { Private declarations }
    isFillingPublicationCombo : boolean;
  public
    pressname : string;
    deadline : Tdatetime;
    publicationid : Integer;
    primaryeditionid : Integer;
    planname : string;
    { Public declarations }
  end;
var
  Formaddplan: TFormaddplan;
  puli : Integer;
implementation
uses DateUtils,Umain, Udata, Usettings, Uprodplan, UDeadlinesettings,
  UApplyplan, Uloadpressplan,utypes, UUtils, UPrefs;
{$R *.dfm}
procedure TFormaddplan.FormActivate(Sender: TObject);
Var
  deadl : Tdatetime;
  Year, Month, Day: Word;
begin
  isFillingPublicationCombo := false;
  if (Prefs.Proversion = 2) then
    Panelbigwizz.Visible := false;
  Editweek.Text := '0';
  if (Prefs.ShowWeekNumberInTree) then
  begin
    Editweek.Text := IntToStr(WeekOf(DateTimePicker1.Date));
     Editweek.Enabled := True;
    DateTimePicker1.Enabled := False;
  end
  else
  begin
    Editweek.Enabled := False;
    DateTimePicker1.Enabled := True;
  end;

  Editplanname.Visible := Prefs.SimplePlanLoad = false;
  Label3.Visible := Prefs.SimplePlanLoad = false;
  CheckBoxSchedulefilter.Visible := Prefs.SimplePlanLoad = false;
  if (Prefs.SimplePlanLoad) then
    CheckBoxSchedulefilter.Checked := false;
(*
  IF Panelbigwizz.Visible then
  begin
    Formaddplan.height := 355;
    Panel1.Top := 272;
  end
  else
  begin
    Formaddplan.height := 257;
    Panel1.Top := 172;
  end;
  *)
  Formaddplan.Repaint;
  CheckBoxSchedulefilter.Checked := AllowSchedules;
  DateTimePicker1.Date := IncDay(now);
  deadl := Formaddplan.DateTimePicker1.DateTime;
  DecodeDate(deadl,Year, Month, Day);
  deadl := EncodeDateTime(Year, Month, Day,0,0,0,0);
  deadl := IncHour(deadl,1);

  FormApplyproduction.DateTimePickerdeadlinedate.Date := deadl;
  Formdeadlines.DateTimePickerDeadlinedate.Date := deadl;
  Formdeadlines.DateTimePickerdeadlinetime.Time := deadl;
  FillPublicationCombo();
  EditPressName.Text := pressname;
  Editplanname.Text := formprodplan.createproductionname(tnames1.publicationnametoid(ComboBoxpublication.Text),
                                    tnames1.pressnametoid(pressname),DateTimePicker1.date);
  If Prefs.ShowWeekNumberInTree then
    EditweekChange(self);
  if formprodplan.Editmode <> PLANADDMODE_APPLY then
  begin
    ComboBoxedition.Items := tNames1.Editionnames;
    ComboBoxedition.Itemindex := 0;
    IF Formmain.Limiteditionselection(tnames1.publicationnametoid(ComboBoxpublication.text),ComboBoxedition.items) then
    begin
      ComboBoxedition.ItemIndex := 0;
    end;
    if (Prefs.PlanningDefaultFirstEdition <> '') then
    begin
      if tnames1.editionnametoid(Prefs.PlanningDefaultFirstEdition) > 0 then
      Begin
        ComboBoxedition.ItemIndex := ComboBoxedition.Items.IndexOf(Prefs.PlanningDefaultFirstEdition);
        ComboBoxedition.Text := Prefs.PlanningDefaultFirstEdition;
      end;
    end;
  end;
  ComboBoxIssue.Items := tNames1.issuenames;
  ComboBoxIssue.Itemindex := 0;
  if (Prefs.PlanningUsePublicationDefaultlPriority) then
  begin
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('Select Priority from publicationtemplates');
    DataM1.Query1.SQL.Add('where publicationid = ' + IntToStr(tnames1.publicationnametoid(ComboBoxpublication.Text)) );
    DataM1.Query1.Open;
    IF not DataM1.Query1.Eof then
    begin
      Editpriority.text := DataM1.Query1.Fields[0].AsString;
      UpDown1.Position := StrToInt(Editpriority.Text);
    end;
    DataM1.Query1.Close;
  end;
   CheckBoxOnlyShowDefaultPressPublications.Checked := Prefs.PlanningOnlyShowDefaultPressPublications;
end;
procedure  TFormAddPlan.FillPublicationCombo();
begin
  isFillingPublicationCombo := true;
  ComboBoxpublication.Items.Clear;

  if (CheckBoxOnlyShowDefaultPressPublications.Checked) and (pressname <> '') then
  begin
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('SELECT DISTINCT PUB.[Name] FROM PublicationNames PUB');
    DataM1.Query1.SQL.Add('INNER JOIN PressNames PN ON PUB.DefaultTemplateID=PN.PressID');
    DataM1.Query1.SQL.Add('WHERE PN.PressName=''' + pressname + '''');
    DataM1.Query1.SQL.Add('ORDER BY PUB.[Name]');
    DataM1.Query1.Open;
    While not DataM1.Query1.Eof do
    begin
      ComboBoxpublication.Items.Add( DataM1.Query1.Fields[0].AsString);
      DataM1.Query1.Next
    end;
    DataM1.Query1.Close;
  end
  else
    ComboBoxpublication.Items := tNames1.publicationnames;
  ComboBoxpublication.itemindex := puli;

  isFillingPublicationCombo := false;
end;
procedure TFormaddplan.CheckBoxOnlyShowDefaultPressPublicationsClick(Sender: TObject);
begin
  puli := 0;
  FillPublicationCombo();
end;

procedure TFormaddplan.ComboBoxpublicationChange(Sender: TObject);
begin
 if (isFillingPublicationCombo) then
    exit;
  Editplanname.Text := formprodplan.createproductionname(tnames1.publicationnametoid(ComboBoxpublication.Text),
                                    tnames1.pressnametoid(pressname),DateTimePicker1.Date);
  if Prefs.PlanningUsePublicationDefaultlPriority then
  begin
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('SELECT TOP 1 Priority FROM PublicationTemplates (NOLOCK)');
    DataM1.Query1.SQL.Add('WHERE PublicationID = ' + IntToStr(tnames1.publicationnametoid(ComboBoxpublication.Text)) );
    DataM1.Query1.Open;
    IF not DataM1.Query1.Eof then
    begin
      UpDown1.Position := DataM1.Query1.Fields[0].AsInteger;
      Editpriority.Text := IntToStr(UpDown1.Position);
    end;
    DataM1.Query1.Close;
  end;
  ComboBoxedition.Clear;
  ComboBoxedition.Items := tNames1.Editionnames;
  ComboBoxedition.ItemIndex := 0;
  IF Formmain.Limiteditionselection(tnames1.publicationnametoid(ComboBoxpublication.text),ComboBoxedition.items) then
    ComboBoxedition.ItemIndex := 0;
  if (Prefs.PlanningDefaultFirstEdition <> '') then
  begin
    if tnames1.editionnametoid(Prefs.PlanningDefaultFirstEdition) > 0 then
    begin
      ComboBoxedition.ItemIndex := ComboBoxedition.Items.IndexOf(Prefs.PlanningDefaultFirstEdition);
      ComboBoxedition.Text := Prefs.PlanningDefaultFirstEdition;
    end;
  end;
end;
procedure TFormaddplan.DateTimePicker1Change(Sender: TObject);
begin
         Editplanname.Text := formprodplan.createproductionname(tnames1.publicationnametoid(ComboBoxpublication.Text),
                                    tnames1.pressnametoid(pressname),DateTimePicker1.Date);
end;

procedure TFormaddplan.FormCreate(Sender: TObject);
begin
  DateTimePicker1.Datetime := now;
  puli := 0;
end;
procedure TFormaddplan.BitBtn3Click(Sender: TObject);
Var
  deadl,adedl,dedltime : Tdatetime;
  daybefore : Longint;
  T : string;
begin
  puli := ComboBoxpublication.ItemIndex;
  planname := Editplanname.Text;
  daybefore := 2;
  daybefore := daybefore -1;
  deadl := DateOf(DateTimePicker1.Date);
  deadl := deadl + TimeOf(now);
  deadl := formmain.Getdafaultdeadline(DateTimePicker1.Date, tnames1.publicationnametoid(ComboBoxpublication.Text));
  FormApplyproduction.DateTimePickerdeadlinedate.Date := DateOf(deadl);
  FormApplyproduction.DateTimePickerdeadlinetime.time := TimeOf(deadl);
end;
procedure TFormaddplan.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  publicationid := tnames1.publicationnametoid(ComboBoxpublication.text);
  primaryeditionid := tnames1.editionnametoid(ComboBoxedition.text);
end;
procedure TFormaddplan.EditweekChange(Sender: TObject);
Var
  curweek,AYear,Year, Month, Day: Word;
  adate : tdatetime;
  week   : Integer;
begin
  IF (editweek.Text = '') OR (editweek.Text = '0') then
    exit;
  week := StrToInt(editweek.Text);
  FormApplyproduction.ApplyweekNumber := week;
  IF week< 1 then
    exit;
  IF week > 53 then
    exit;
  try
   curweek := WeekOf(now);
   DecodeDate(now, Year, Month, Day);
   if (curweek = 53) AND (year = 2021) then
     year := 2020;


   IF ((curweek <> 52) AND (curweek > week)) OR ((curweek =1) AND (Month = 12)) OR (week<curweek) then
     Inc(Year);
   if (week = 53) AND (year = 2021) then
     year := 2020;
   if (week = 1) AND (year = 2022) then
     year := 2023;
   adate := EncodeDateWeek(Year, week , Prefs.DayOfWeek+1);
   DateTimePicker1.Date := adate;
  except
  end;
end;
end.
