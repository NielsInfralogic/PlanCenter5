unit USelectHalfwebPage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TFormSelectHalfwebPage = class(TForm)
    RadioGroupPages: TRadioGroup;
    Panel1: TPanel;
    BitBtnOK: TBitBtn;
    BitBtnCancel: TBitBtn;
    Panel2: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSelectHalfwebPage: TFormSelectHalfwebPage;

implementation

{$R *.dfm}

end.
