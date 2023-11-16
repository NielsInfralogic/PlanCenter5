unit Udevicereport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

type
  TFormdevicereport = class(TForm)
    Panel3: TPanel;
    Image2: TImage;
    Label7: TLabel;
    Label8: TLabel;
    GroupBox1: TGroupBox;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    GroupBox2: TGroupBox;
    Edithours: TEdit;
    UpDownNhours: TUpDown;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Formdevicereport: TFormdevicereport;

implementation

{$R *.dfm}
Uses
  DateUtils;

procedure TFormdevicereport.FormActivate(Sender: TObject);
begin
  
  DateTimePicker2.Time := encodetime(0,0,0,0);
end;

end.
