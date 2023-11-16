unit Uplanisbusy;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons;

type
  TFormplanisbusy = class(TForm)
    Image1: TImage;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    inuseby : String;
    aborted : Boolean;
  end;

var
  Formplanisbusy: TFormplanisbusy;

implementation

{$R *.dfm}

Uses
  umain;

// Another production plan are being applied by '' please wait
procedure TFormplanisbusy.FormActivate(Sender: TObject);
begin
  aborted := false;
  Formplanisbusy.panel1.caption := 'Another production plan are being applied by ' + PlanLockClient + ' please wait';
end;

procedure TFormplanisbusy.BitBtn1Click(Sender: TObject);
begin
  aborted := true;
end;

end.
