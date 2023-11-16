unit UMPS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls;

type
  TFormMPS = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    UpDown1: TUpDown;
    Edit2: TEdit;
    Label2: TLabel;
    UpDown2: TUpDown;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMPS: TFormMPS;

implementation

{$R *.dfm}

end.
