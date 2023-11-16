unit UResampleprogress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls;

type
  TFormresampleprogress = class(TForm)
    ProgressBar1: TProgressBar;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Formresampleprogress: TFormresampleprogress;

implementation

{$R *.dfm}
Uses
  Umain, UTypes, ULoadDlls;

procedure TFormresampleprogress.BitBtn1Click(Sender: TObject);
begin
  ResampleCancel;
end;

end.
