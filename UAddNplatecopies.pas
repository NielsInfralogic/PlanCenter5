unit UAddNplatecopies;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls;

type
  TFormAddNplatecopies = class(TForm)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    EditNcopies: TEdit;
    UpDown1: TUpDown;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAddNplatecopies: TFormAddNplatecopies;

implementation

{$R *.dfm}

end.
