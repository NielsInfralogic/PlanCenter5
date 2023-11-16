unit Ueditdates;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, DateUtils, Vcl.Mask;
type
  TFormeditdates = class(TForm)
    DateTimePickerpubdate: TDateTimePicker;
    Label1: TLabel;
    DateTimePickerpressdate: TDateTimePicker;
    Label2: TLabel;
    Editweeknumber: TEdit;
    Label3: TLabel;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label4: TLabel;
    ComboBoxPublication: TComboBox;
    Label5: TLabel;
    ComboBoxEdition: TComboBox;
    UpDownweek: TUpDown;
    procedure DateTimePickerpubdateChange(Sender: TObject);
    procedure EditweeknumberChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  Formeditdates: TFormeditdates;
implementation
{$R *.dfm}

uses Umain, UUtils;
procedure TFormeditdates.FormActivate(Sender: TObject);
begin

   DateTimePickerpubdateChange(nil);
end;



procedure TFormeditdates.DateTimePickerpubdateChange(Sender: TObject);
begin
  Editweeknumber.Text := TUtils.LeadingZeroes(WeekOf(DateTimePickerpubdate.DateTime), 2);
end;


procedure TFormeditdates.EditweeknumberChange(Sender: TObject);
Var
  curweek,
  AYear, Year, Month, Day : Word;
  week : Integer;
   adate : tdatetime;
begin
  IF (Editweeknumber.Text = '')  OR (Editweeknumber.Text = '0') then
    exit;
  week := StrToInt(Editweeknumber.Text);
  IF week < 1  then
    exit;
  IF week > 53 then
    exit;
  if (not Editweeknumber.Enabled)
    then exit;        // Don't do it if wekknumber not used!!

  Curweek := WeekOf(now);
  DecodeDate(now, Year, Month, Day);
  if (curweek = 53) AND (year = 2021) then
    year := 2020;
  if (curweek > week) AND (curweek <>52) then
    Inc(Year);
  if (week = 53) AND (year = 2021) then
     year := 2020;
  if (week = 1) AND (curweek = 52) then
     Inc(Year);
  adate := EncodeDateWeek(Year, week, Prefs.DayOfWeek + 1);
  DateTimePickerpubdate.Date := adate;
end;


end.
