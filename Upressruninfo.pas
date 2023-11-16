unit Upressruninfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TFormpressruninfo = class(TForm)
    ComboBoxComment: TComboBox;
    Label1: TLabel;
    ComboBoxPressConfigname: TComboBox;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Formpressruninfo: TFormpressruninfo;

implementation

{$R *.dfm}
    
end.
