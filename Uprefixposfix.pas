unit Uprefixposfix;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFormPrepostfix = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Editprefix: TEdit;
    Label1: TLabel;
    editpostfix: TEdit;
    Label2: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrepostfix: TFormPrepostfix;

implementation

{$R *.dfm}

end.
