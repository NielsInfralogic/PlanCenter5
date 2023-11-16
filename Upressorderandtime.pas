unit Upressorderandtime;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls;

type
  TFormpressorderandtime = class(TForm)
    Label1: TLabel;
    Editpressordernumber: TEdit;
    GroupBox1: TGroupBox;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    combineddatetime : tdatetime;
    { Public declarations }
  end;

var
  Formpressorderandtime: TFormpressorderandtime;

implementation

{$R *.dfm}

procedure TFormpressorderandtime.BitBtn1Click(Sender: TObject);
begin
  ReplaceDate(combineddatetime,DateTimePicker1.Date);
  ReplaceTime(combineddatetime,DateTimePicker2.Date);
end;

end.
