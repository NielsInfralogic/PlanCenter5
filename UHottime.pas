unit UHottime;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

type
  TFormHottime = class(TForm)
    Panelmovepress: TPanel;
    Image2: TImage;
    Label11: TLabel;
    Label12: TLabel;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Edit1: TEdit;
    PriorityBeforeHottime: TUpDown;
    Edit2: TEdit;
    PriorityDuringHottime: TUpDown;
    Edit3: TEdit;
    PriorityAfterHottime: TUpDown;
    DateTimePickertimebegin: TDateTimePicker;
    DateTimePickerdatebegin: TDateTimePicker;
    DateTimePickertimeend: TDateTimePicker;
    DateTimePickerdateend: TDateTimePicker;
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
  FormHottime: TFormHottime;

implementation

{$R *.dfm}
Uses
  dateutils;

procedure TFormHottime.FormActivate(Sender: TObject);
Var
  h,m : Longint;
begin
  h := hourof(DateTimePickertimebegin.Time);
  m := minuteof(DateTimePickertimebegin.Time);
  DateTimePickertimebegin.Time := encodetime(h,m,0,1);
end;

end.
