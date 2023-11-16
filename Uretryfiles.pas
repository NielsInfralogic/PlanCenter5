unit Uretryfiles;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls;

type
  TFormretryfiles = class(TForm)
    Animate1: TAnimate;
    ProgressBar1: TProgressBar;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    abortretry : Boolean;
  end;

var
  Formretryfiles: TFormretryfiles;

implementation

{$R *.dfm}

procedure TFormretryfiles.BitBtn1Click(Sender: TObject);
begin
  abortretry := true;
  Animate1.Active := false;
  Formretryfiles.close;
end;

end.
