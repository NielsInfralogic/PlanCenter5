unit UCalcReacur;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, CheckLst, ExtCtrls, Buttons;

type
  TSelDaysInweek = Array [0..6] of boolean; //0=mandag...6 = søndag
  TRecurenceFormel = Record
                       RecurID : longint;
                       Recurtype : Longint; // 1 dayli,2 weekly, 3 monthly on date, 4 montly on the
                       Startdate : Tdatetime;
                       StartTime : Tdatetime;
                       Printtime : Longint;
                       NumOfRecur : Longint;
                       NumOfActiveRecur : Longint;
                       Ofevery : Longint;   //Recurtype = 1 every 2 every second
                       SelDaysInweek : TSelDaysInweek;
                       DayNumber : Longint; // daynumber 1-31 with recurtype 3,  1 = first if recurtype 4

                     End;

  Tresultdatatype = Array of record
                               Adate : tdatetime;
                               StartTime : tdatetime;
                               Printtime : tdatetime;
                             end;

  TFormGentagne = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    Panel2: TPanel;
    RadioGroupRecurtype: TRadioGroup;
    GroupBoxMonthly: TGroupBox;
    GroupBoxweekly: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EdithverNuge: TEdit;
    CheckListBoxonday: TCheckListBox;
    UpDown1: TUpDown;
    GroupBoxdayli: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    EditNdage: TEdit;
    UpDown2: TUpDown;
    BitBtn2: TBitBtn;
    GroupBox1: TGroupBox;
    Label10: TLabel;
    DateTimePickerstartdag: TDateTimePicker;
    Label9: TLabel;
    Label4: TLabel;
    EditnSchedules: TEdit;
    UpDownantalgange: TUpDown;
    EditnActiveSchedules: TEdit;
    UpDownantalplannerafg: TUpDown;
    GroupBox3: TGroupBox;
    Label16: TLabel;
    Label17: TLabel;
    Editeverynmonths: TEdit;
    UpDown8: TUpDown;
    Panel3: TPanel;
    GroupBox7: TGroupBox;
    EditdatoiMonth: TEdit;
    UpDown6: TUpDown;
    RadioButtonMonthOnDay: TRadioButton;
    GroupBox6: TGroupBox;
    ComboBoxFSTW: TComboBox;
    ComboBoxmonthday: TComboBox;
    RadioButtonMonthOnThe: TRadioButton;
    procedure FormActivate(Sender: TObject);
    procedure RadioGroupRecurtypeClick(Sender: TObject);
    procedure CheckListBoxondayClick(Sender: TObject);
    procedure EditdatoiMonthChange(Sender: TObject);
    procedure DateTimePickerstartdagChange(Sender: TObject);
    procedure RadioButtonMonthOnTheClick(Sender: TObject);
    procedure RadioButtonMonthOnDayClick(Sender: TObject);
    procedure ComboBoxFSTWChange(Sender: TObject);
    procedure ComboBoxmonthdayChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    Daynames : Array[0..6] of string;
    Nresultdata : Longint;
    resultdata : Tresultdatatype;
    procedure FormelToForm(RecurFormel : TRecurenceFormel);
    procedure FormToFormel(Var RecurFormel : TRecurenceFormel);
    procedure setnewresult(adate : tdatetime;
                           APrintime : Longint);
    procedure Calcdayli(EveryNday : Longint;
                        NumberOfschedules : Longint;
                        FromDate : Tdatetime;
                        APrinttime : Longint);
    procedure CalcWeekly(EveryNWeek : Longint;
                         NumberOfschedules : Longint;
                         FromDate : Tdatetime;
                         SelDaysInweek : TSelDaysInweek;
                         APrinttime : Longint);
    procedure CalcMonthly(MonthrecurType : Longint;    //3 eller 4
                          EveryNMonth : Longint;
                          NumberOfschedules : Longint;
                          FromDate : Tdatetime;
                          EveryDayNumber : Longint;
                          SelDaysInweek : TSelDaysInweek; //0=mandag
                          APrinttime : Longint);

  end;

var
  FormGentagne: TFormGentagne;


implementation

{$R *.dfm}
Uses

  DateUtils, Uselfromlist;



procedure TFormGentagne.FormActivate(Sender: TObject);
Var
  I : Longint;
begin
  Nresultdata := 0;

  CheckListBoxonday.Items.clear;

  For i := 2 to 7 do
    CheckListBoxonday.Items.add(SysUtils.FormatSettings.LongDayNames[i]);

  CheckListBoxonday.Items.add(SysUtils.FormatSettings.LongDayNames[1]);

  ComboBoxmonthday.items.clear;
  For i := 0 to 6 do
    ComboBoxmonthday.items.add(CheckListBoxonday.Items[i]);

  ComboBoxmonthday.itemindex := 0;

end;

procedure TFormGentagne.RadioGroupRecurtypeClick(Sender: TObject);
begin


  GroupBoxdayli.Visible := RadioGroupRecurtype.ItemIndex = 0;
  GroupBoxWeekly.Visible := RadioGroupRecurtype.ItemIndex = 1;
  GroupBoxMonthly.Visible := RadioGroupRecurtype.ItemIndex = 2;
  IF GroupBoxMonthly.Visible then
  Begin
    EditdatoiMonth.Text := inttostr(dayof(DateTimePickerstartdag.DateTime));
  end;
end;









procedure TFormGentagne.CheckListBoxondayClick(Sender: TObject);
Var
  i2 : longint;
begin
  for i2 := 0 to 6 do
  begin
    IF CheckListBoxonday.checked[i2] then
    begin
      break;
    End;
  End;

end;

procedure TFormGentagne.EditdatoiMonthChange(Sender: TObject);
Var
  fdag : Longint;
  aktday : tdatetime;
  Ndageimoth : Longint;
begin
  if EditdatoiMonth.Text <> '' then
  begin

    Ndageimoth := DaysInAMonth(yearof(DateTimePickerstartdag.DateTime),monthof(DateTimePickerstartdag.DateTime));

    fdag := strtoint(EditdatoiMonth.text);
    IF Ndageimoth < fdag then
    begin
      EditdatoiMonth.text := inttostr(Ndageimoth);
      beep;
    end;
    fdag := strtoint(EditdatoiMonth.text);

    aktday := DateTimePickerstartdag.DateTime;
    If fdag <> dayof(aktday) then
    begin
      aktday := incday(aktday,fdag - dayof(aktday));
      DateTimePickerstartdag.DateTime := aktday;
      DateTimePickerstartdag.refresh;
    End;
  End;
end;



procedure TFormGentagne.DateTimePickerstartdagChange(Sender: TObject);
Var
  i : Longint;
  idat,Fdayinmonth : tdatetime;

  weekcount,Ndayinmonth,Aweekday : Longint;
  dayname : string;

begin

  if (sender = DateTimePickerstartdag) Then
  Begin
    idat := DateTimePickerstartdag.DateTime;

    if  (RadioGroupRecurtype.ItemIndex= 2) and (RadioButtonMonthOnDay.Checked) then
    Begin
      EditdatoiMonth.Text := inttostr(dayof(DateTimePickerstartdag.DateTime));
    end;

    if  (RadioGroupRecurtype.ItemIndex= 2) and (RadioButtonMonthOnThe.Checked) then
    Begin
      weekcount := 0;
      Ndayinmonth := dayof(idat);

      dayname    := formatdatetime('dddd',idat);

      Fdayinmonth := encodedate(yearof(idat),monthof(idat),1);

      Aweekday := dayoftheweek(idat);

      For i := 1 to Ndayinmonth do
      begin
        IF dayname = formatdatetime('dddd',Fdayinmonth) then
        begin
          Inc(weekcount);
        end;
        Fdayinmonth := Incday(Fdayinmonth);
      end;

      weekcount := weekcount-1;

      IF weekcount < 0 then
        weekcount := 0;
      IF weekcount > 4 then
        weekcount := 4;

      ComboBoxFSTW.Itemindex := weekcount;

      Aweekday := Aweekday-1;
      IF Aweekday < 0 then
        Aweekday := 0;
      IF Aweekday > 6 then
        Aweekday := 6;

      ComboBoxmonthday.Itemindex := Aweekday;

    end;
  End;



end;

procedure TFormGentagne.RadioButtonMonthOnTheClick(Sender: TObject);
begin
  RadioButtonMonthOnDay.Checked := Not RadioButtonMonthOnThe.Checked;
end;

procedure TFormGentagne.RadioButtonMonthOnDayClick(Sender: TObject);
begin
  RadioButtonMonthOnThe.Checked := not RadioButtonMonthOnDay.Checked;
end;

procedure TFormGentagne.ComboBoxFSTWChange(Sender: TObject);
Var
  dayname : string;
  lastfoundday,Fdayinmonth,idat : Tdatetime;
  I,weekcount : Longint;
  found : Boolean;


begin
  if sender = ComboBoxFSTW then
  begin
    found := false;
    lastfoundday := DateTimePickerstartdag.DateTime;
    idat := DateTimePickerstartdag.DateTime;
    Fdayinmonth := encodedate(yearof(idat),monthof(idat),1);
    dayname     :=  uppercase(ComboBoxmonthday.Text);

    weekcount := 0;

    For i := 1 to 28 do
    begin
      IF dayname = Uppercase(formatdatetime('dddd',Fdayinmonth)) then
      begin
        lastfoundday := Fdayinmonth;
        Inc(weekcount);
        IF weekcount = ComboBoxFSTW.ItemIndex+1 then
        begin
          DateTimePickerstartdag.DateTime := Fdayinmonth;
          found := true;
          break;
        end;
      end;
      Fdayinmonth := Incday(Fdayinmonth);
    End;
    IF Not found then
    begin
      DateTimePickerstartdag.DateTime := lastfoundday;

    end;
  end;
end;

procedure TFormGentagne.ComboBoxmonthdayChange(Sender: TObject);
Var
  dayname : string;
  lastfoundday,Fdayinmonth,idat : Tdatetime;
  I,ncount : Longint;



begin
  if sender = ComboBoxmonthday then
  begin
    lastfoundday := DateTimePickerstartdag.DateTime;
    dayname     :=  uppercase(ComboBoxmonthday.Text);
    idat := DateTimePickerstartdag.DateTime;
    Fdayinmonth := encodedate(yearof(idat),monthof(idat),1);
    ncount := ComboBoxFSTW.ItemIndex+1;
    IF ncount > 4 then
      ncount := 4;

    For i := 1 to (ncount*7) do
    begin
      IF dayname = Uppercase(formatdatetime('dddd',Fdayinmonth)) then
      begin
        lastfoundday := Fdayinmonth;

      End;
      Fdayinmonth := Incday(Fdayinmonth);
    end;

    DateTimePickerstartdag.DateTime := lastfoundday;

  End;
end;



procedure TFormGentagne.BitBtn1Click(Sender: TObject);
begin

(*
  Case RadioGroupRecurtype.ItemIndex of
    0 : begin
          Calcdayli;
        end;
    1 : begin
          CalcWeekly;
        end;
    2 : begin
          CalcMonthly;
        end;
  end;
  *)
end;

procedure TFormGentagne.setnewresult(adate : tdatetime;
                                     APrintime : Longint);
Begin
  Inc(nresultdata);
  resultdata[nresultdata].Adate := adate;
  resultdata[nresultdata].StartTime := timeof(adate);
  resultdata[nresultdata].Printtime := APrintime;


  (*

   := encodedatetime(yearof(adate),monthof(adate),dayof(adate),
                                                      hourof(StartTime),minuteof(StartTime),0,0);
  resultdata[nresultdata].Printtime := Printtime;
    *)
end;

procedure TFormGentagne.Calcdayli(EveryNday : Longint;
                                  NumberOfschedules : Longint;
                                  FromDate : Tdatetime;
                                  APrinttime : Longint);

Var
  hverndage : Longint;
  I : Longint;
  aktday : Tdatetime;
Begin
  hverNdage := EveryNday;

  SetLength(resultdata, NumberOfschedules+10);
  Nresultdata := 0;
  aktday := FromDate;
  For i := 1 to NumberOfschedules do
  begin

    setnewresult(aktday,APrinttime);
    aktday := IncDay(aktday,hverNdage);
  end;

end;

procedure TFormGentagne.CalcWeekly(EveryNWeek : Longint;
                                   NumberOfschedules : Longint;
                                   FromDate : Tdatetime;
                                   SelDaysInweek : TSelDaysInweek;
                                   APrinttime : Longint);


Var
  hvernuge : Longint;
  I,i2 : Longint;
  aktday,iday : Tdatetime;

  Fdag : Longint;

Begin
  hvernuge := EveryNWeek;
  SetLength(resultdata, NumberOfschedules+10);
  Nresultdata := 0;

  fdag := 0;
  aktday := FromDate;
  for i2 := 0 to 6 do
  begin
    IF SelDaysInweek[i2] then
    begin
      Fdag := i2+1;
      break;
    End;
  End;

  i2 := dayoftheweek(aktday);
  IF i2 < fdag then
  begin
    aktday := incday(aktday,fdag-i2);
    FromDate := aktday;
  end;


  For i := 1 to NumberOfschedules do
  begin
    iday := aktday;
    for i2 := dayoftheweek(aktday)-1 to 6 do
    begin
      IF SelDaysInweek[i2] then
      begin
        setnewresult(iday,APrinttime);
      end;
      iday := incday(iday);
    end;

    aktday := Incweek(aktday,hvernuge);
    While dayoftheweek(aktday) > 1 do
      aktday := incday(aktday,-1);

    IF nresultdata >= NumberOfschedules then
      break;

  end;

end;

procedure TFormGentagne.CalcMonthly(MonthrecurType : Longint;    //3 eller 4
                                    EveryNMonth : Longint;
                                    NumberOfschedules : Longint;
                                    FromDate : Tdatetime;
                                    EveryDayNumber : Longint;
                                    SelDaysInweek : TSelDaysInweek; //0=mandag
                                    APrinttime : Longint);


Var
  hvernMonth,i,imonth,n,Jmonth : Longint;
  aktday,iday : Tdatetime;
  T,dayname : String;
  fstcount,Nfstcount : Longint;
Begin
  SetLength(resultdata, NumberOfschedules+10);
  Nresultdata := 0;
  Jmonth := 1;
  iday   := FromDate;

  IF MonthrecurType = 3 then
  begin
    hvernMonth := EveryDayNumber;
    n := NumberOfschedules;
    i := 0;
    repeat
      iday := Incday(iday);
      IF dayof(iday) = EveryDayNumber then
      begin
        IF Jmonth = EveryNMonth then
        begin
          T := formatdatetime('dddd',iday);
          setnewresult(iday,APrinttime);
          inc(i);
          Jmonth := 1;
        End
        else
        begin
          Inc(Jmonth);
        end;
      end;
      IF nresultdata >= NumberOfschedules then
        break;
    until (i >= n);
  end
  else
  begin
    Nfstcount := 1;
    For i := 0 to 6 do
    begin
      IF SelDaysInweek[i] then
      begin
        Nfstcount := i+1;
        break;
      end;
    end;

    hvernMonth := EveryNMonth;
    n := NumberOfschedules;

    I :=0;

    dayname := Daynames[Nfstcount-1];
    aktday := FromDate;

    repeat

      iday := encodedate(yearof(aktday),monthof(aktday),1);
      fstcount := 0;
      For imonth := 1 to DaysInAMonth(yearof(aktday),monthof(aktday)) do
      begin
        IF uppercase(formatdatetime('dddd',iday)) = dayname then
        begin
          Inc(fstcount);
          IF Nfstcount = fstcount then
          begin
            T := formatdatetime('dddd',iday);
            setnewresult(iday,APrinttime);
            //ListBox1.Items.add(T + ' d. '+   datetostr(iday));
            inc(i);
          end;
        end;
        iday := Incday(iday);
        IF nresultdata >= NumberOfschedules then
          break;
      end;
      aktday := incmonth(aktday,hvernMonth);
      IF nresultdata >= NumberOfschedules then
        break;
    until (i >= n);
  end;
end;



procedure TFormGentagne.FormCreate(Sender: TObject);
Var
  i : Longint;
begin
  For i := 0 to 5 do
    Daynames[i] := SysUtils.FormatSettings.LongDayNames[i+2];

  Daynames[6] := SysUtils.FormatSettings.LongDayNames[1];
end;

procedure TFormGentagne.FormToFormel(Var RecurFormel : TRecurenceFormel);
Var
  I : Longint;
Begin
  For i := 0 to 6 do
    RecurFormel.SelDaysInweek[i] := false;
  RecurFormel.Recurtype := RadioGroupRecurtype.ItemIndex+1;
  RecurFormel.DayNumber := 0;
  IF RadioGroupRecurtype.ItemIndex = 2 then
  begin
    IF RadioButtonMonthOnThe.Checked then
      RecurFormel.Recurtype := 4;
  end;
  RecurFormel.Startdate := DateTimePickerstartdag.Date;
  RecurFormel.NumOfRecur := strtoint(EditnSchedules.text);
  RecurFormel.NumOfActiveRecur := strtoint(EditnActiveSchedules.text);

  Case RecurFormel.Recurtype of
    1 : begin
          RecurFormel.Ofevery := strtoint(EditNdage.Text);
        end;
    2 : Begin
          RecurFormel.Ofevery := strtoint(EdithverNuge.Text);
          For i := 0 to 6 do
            RecurFormel.SelDaysInweek[i] := CheckListBoxonday.checked[i];
        end;
    3 : begin
          RecurFormel.DayNumber := strtoint(EditdatoiMonth.Text);
          RecurFormel.Ofevery := strtoint(Editeverynmonths.Text);
        end;
    4 : begin
          RecurFormel.DayNumber := ComboBoxFSTW.ItemIndex+1;
          RecurFormel.Ofevery := strtoint(Editeverynmonths.Text);
          RecurFormel.SelDaysInweek[ComboBoxmonthday.ItemIndex] := true;
        end;

  end;

  // KKK RecurFormel.StartTime := StartTime;
//  RecurFormel.StopTime := DateTimePickerendtime.Time;

end;


procedure TFormGentagne.FormelToForm(RecurFormel : TRecurenceFormel);
Var
  I : Longint;
Begin
  For i := 0 to 6 do
    CheckListBoxonday.checked[i] := false;

  RadioGroupRecurtype.ItemIndex := 0;

  Case RecurFormel.Recurtype of
    1 : Begin
          RadioGroupRecurtype.ItemIndex := 0;
        end;
    2 : Begin
          RadioGroupRecurtype.ItemIndex := 1;
        end;
    3 : Begin
          RadioGroupRecurtype.ItemIndex := 2;
          RadioButtonMonthOnDay.Checked := true;
          RadioButtonMonthOnThe.Checked := false;

        end;
    4 : Begin
          RadioButtonMonthOnDay.Checked := false;
          RadioButtonMonthOnThe.Checked := true;
          RadioGroupRecurtype.ItemIndex := 2;
        end;
  end;

  DateTimePickerstartdag.Date := RecurFormel.Startdate;
  EditnSchedules.text := inttostr(RecurFormel.NumOfRecur);
  EditnActiveSchedules.text := inttostr(RecurFormel.NumOfActiveRecur);

  Case RecurFormel.Recurtype of
    1 : begin
          EditNdage.Text := inttostr(RecurFormel.Ofevery);
        end;
    2 : Begin
          EdithverNuge.Text := inttostr(RecurFormel.Ofevery);
          For i := 0 to 6 do
            CheckListBoxonday.checked[i] := RecurFormel.SelDaysInweek[i];
        end;
    3 : begin
          EditdatoiMonth.Text := inttostr(RecurFormel.DayNumber);
          Editeverynmonths.Text := inttostr(RecurFormel.Ofevery);
        end;
    4 : begin
          ComboBoxFSTW.ItemIndex := RecurFormel.DayNumber-1;
          Editeverynmonths.Text := inttostr(RecurFormel.Ofevery);
          for i := 0 to 6 do
          begin
            if RecurFormel.SelDaysInweek[i] then
            begin
              ComboBoxmonthday.ItemIndex := i;
              break;
            end;
          end;

        end;

  end;

end;


End.
