unit USelectPaginationStyle;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

type
  TFormSelectPaginationStyle = class(TForm)
    BitBtnCancel: TBitBtn;
    BitBtnOK: TBitBtn;
    RadioGroupMethod: TRadioGroup;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSelectPaginationStyle: TFormSelectPaginationStyle;

implementation

{$R *.dfm}

end.
