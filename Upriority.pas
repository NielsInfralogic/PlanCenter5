unit Upriority;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls;

type
  TFormpriority = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Edit1: TEdit;
    Label1: TLabel;
    UpDown1: TUpDown;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Formpriority: TFormpriority;

implementation

{$R *.dfm}

end.
