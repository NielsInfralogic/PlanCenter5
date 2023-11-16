unit Ueditpagedef;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, CheckLst, Spin;

type
  TFormeditpagedef = class(TForm)
    ComboBoxpublication: TComboBox;
    Label1: TLabel;
    ComboBoxsection: TComboBox;
    Label2: TLabel;
    ComboBoxedition: TComboBox;
    Label3: TLabel;
    ComboBoxissue: TComboBox;
    Label4: TLabel;
    CheckListBoxcolor: TCheckListBox;
    Label5: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label11: TLabel;
    ComboBoxproofer: TComboBox;
    Label7: TLabel;
    SpinEditpriority: TSpinEdit;
    Label12: TLabel;
    ComboBoxpagetype: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Formeditpagedef: TFormeditpagedef;

implementation

{$R *.dfm}

end.
