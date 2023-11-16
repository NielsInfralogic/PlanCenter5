unit Usetdeadline;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, Vcl.Mask;

type
  TFormsetdeadline = class(TForm)
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Formsetdeadline: TFormsetdeadline;

implementation

{$R *.dfm}

uses
  UUtils, DateUtils;


procedure TFormsetdeadline.FormActivate(Sender: TObject);
begin
  IF yearof(DateTimePicker1.Date) < 2000 then
  begin
    DateTimePicker1.Date := now;
    DateTimePicker2.Time :=  EncodeTime(12, 0, 0,0);
  end;

  
end;


end.
