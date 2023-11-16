unit USellwin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormSellwin = class(TForm)
    ComboBox1: TComboBox;
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSellwin: TFormSellwin;

implementation

{$R *.dfm}

procedure TFormSellwin.ComboBox1Change(Sender: TObject);
begin
  FormSellwin.Close;
end;

end.
