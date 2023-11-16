unit Uaddsubplannedname;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons,UMain;

type
  TFormapplyedplanname = class(TForm)
    GroupBox6: TGroupBox;
    Label9: TLabel;
    ComboBoxplannedname: TComboBox;
    Editweek: TEdit;
    UpDownweek: TUpDown;
    BitBtn1: TBitBtn;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Formapplyedplanname: TFormapplyedplanname;

implementation

uses Usettings;

{$R *.dfm}

procedure TFormapplyedplanname.FormActivate(Sender: TObject);
Var
  i : longint;
begin
  ComboBoxplannedname.Items.Clear;
  for i := 0 to Length(Prefs.PlannedNameDefinitions)-1 do
  begin
    ComboBoxplannedname.Items.Add(Prefs.PlannedNameDefinitions[i].Name);
    if (Prefs.PlannedNameDefinitions[i].Enabled) then
      ComboBoxplannedname.Itemindex := ComboBoxplannedname.Items.Count-1;
  end;
end;

end.
