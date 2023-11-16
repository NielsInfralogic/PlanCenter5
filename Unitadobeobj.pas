unit Unitadobeobj;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, AcroPDFLib_TLB;

type
  TFormAdopeobj = class(TForm)
    AcroPDF1: TAcroPDF;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAdopeobj: TFormAdopeobj;

implementation

{$R *.dfm}

end.
