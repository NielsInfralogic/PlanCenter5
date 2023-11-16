unit UEdittemplatedata;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  utypes,Dialogs, ComCtrls, ExtCtrls, StdCtrls, Buttons, CheckLst;

type
  TFormedittemplatedata = class(TForm)
    Panel1: TPanel;
    EditCreep: TEdit;
    Label1: TLabel;
    UpDownSplit: TUpDown;
    Label2: TLabel;
    Editsplit: TEdit;
    PanelYesNO: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panelwizard: TPanel;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    CheckBoxSplitsections: TCheckBox;
    BitBtn5: TBitBtn;
    Label3: TLabel;
    EditNcopies: TEdit;
    UpDown1: TUpDown;
    Label4: TLabel;
    ComboBoxstackpos: TComboBox;
    Label9: TLabel;
    ComboBoxproof: TComboBox;
    Label11: TLabel;
    ComboBoxproofcolor: TComboBox;
    Label13: TLabel;
    ComboBoxproofPDF: TComboBox;
    Panel4: TPanel;
    Image4: TImage;
    Label15: TLabel;
    Label16: TLabel;
  private
    procedure loadmarks;
    { Private declarations }
  public

  end;

var
  Formedittemplatedata: TFormedittemplatedata;

implementation
{$R *.dfm}

procedure TFormedittemplatedata.loadmarks;
begin
end;

end.
