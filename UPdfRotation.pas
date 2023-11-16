unit UPdfRotation;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

type
  TPDFRotation = class(TForm)
    Panelsys: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel1: TPanel;
    RadioGroupRotation: TRadioGroup;
    CheckBoxDeleteExistingPage: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PDFRotation: TPDFRotation;

implementation

{$R *.dfm}

Uses
  Udata;


end.
