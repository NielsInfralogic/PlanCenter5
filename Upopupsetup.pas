unit Upopupsetup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, CheckLst, Buttons;

type
  TFormPopupsetup = class(TForm)
    CheckListBoxvisible: TCheckListBox;
    Panel1: TPanel;
    ComboBoxmenues: TComboBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
  private
    procedure loadmenucaptions;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPopupsetup: TFormPopupsetup;

implementation

uses Umain;

{$R *.dfm}

procedure TFormPopupsetup.loadmenucaptions;

function remandsign(ft : string):string;
Begin
end;

Begin
end;


end.
