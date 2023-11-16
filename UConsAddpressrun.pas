unit UConsAddpressrun;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls;

type
  TFormAddconsrun = class(TForm)
    BitBtn3: TBitBtn;
    Panelb: TPanel;
    Image2: TImage;
    Label2: TLabel;
    Label9: TLabel;
    BitBtn1: TBitBtn;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label1: TLabel;
    Label13: TLabel;
    editto: TEdit;
    Editpre: TEdit;
    Editpost: TEdit;
    ComboBoxSection: TComboBox;
    EditFoffset: TEdit;
    Editboffset: TEdit;
    UpDownFoffset: TUpDown;
    UpDownboffset: TUpDown;
    Editoffset: TEdit;
    UpDown1: TUpDown;
    ComboBoxcovername: TComboBox;
    Label3: TLabel;
    ComboBoxeditions: TComboBox;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAddconsrun: TFormAddconsrun;

implementation
Uses
  umain,udata,utypes;
{$R *.dfm}

procedure TFormAddconsrun.FormActivate(Sender: TObject);
begin
  ComboBoxeditions.Items := tnames1.Editionnames;
  ComboBoxSection.Items := tnames1.sectionnames;
  ComboBoxeditions.Itemindex := 0;
  ComboBoxSection.Itemindex := 0;
  editto.Text := '1';
  Editpre.Text := '';
  Editpost.Text := '';
  EditFoffset.Text := '0';
  Editboffset.Text := '0';
  Editoffset.Text := '0';
  ComboBoxcovername.Text := '';
  
end;

end.
