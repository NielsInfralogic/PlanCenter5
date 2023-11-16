unit UHardproofselect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFormhardproofselect = class(TForm)
    Panel3: TPanel;
    Image2: TImage;
    Label7: TLabel;
    Label8: TLabel;
    Label1: TLabel;
    RadioGroupapproval: TRadioGroup;
    RadioGroupflatprooftype: TRadioGroup;
    ComboBoxconf: TComboBox;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    Hardproofconfig : longint;
  end;

var
  Formhardproofselect: TFormhardproofselect;

implementation

uses Uflatproof;

{$R *.dfm}

procedure TFormhardproofselect.FormActivate(Sender: TObject);
begin
  Formflatproof.ComboBoxconf.Items.clear;
  ComboBoxconf.Items.Clear;
  Formflatproof.loadflatproofers;
  ComboBoxconf.Items := Formflatproof.ComboBoxconf.Items;
  if (ComboBoxconf.Items.Count > 0) then
    ComboBoxconf.Itemindex := 1
  else
    ComboBoxconf.Itemindex := 0;
end;

procedure TFormhardproofselect.BitBtn1Click(Sender: TObject);
Var
  proofid : integer;

begin
  IF ComboBoxconf.Itemindex > 0 then
    proofid := Formflatproof.flatproofers[ComboBoxconf.Itemindex].id
  else
    proofid := 0;
  Hardproofconfig := Formflatproof.flatproofconfigcalc(ComboBoxconf.Itemindex > 0,
                                                       RadioGroupapproval.ItemIndex = 0,
                                                       proofid);
end;

end.
