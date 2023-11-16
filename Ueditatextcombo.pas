unit Ueditatextcombo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFormeditatext = class(TForm)
    Label1: TLabel;
    PanelYesNO: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ComboBox1: TComboBox;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Formeditatext: TFormeditatext;

implementation

{$R *.dfm}

Procedure TFormeditatext.FormActivate(Sender: TObject);
begin
  ComboBox1.SetFocus;
end;

end.
