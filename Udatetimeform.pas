unit Udatetimeform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls;

type
  TFormdatetimetool = class(TForm)
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox1: TGroupBox;
    DateTimePicker1: TDateTimePicker;
    GroupBox2: TGroupBox;
    MonthCalendar1: TMonthCalendar;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Formdatetimetool: TFormdatetimetool;

implementation

{$R *.dfm}

end.
