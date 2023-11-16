unit Utowername;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, ValEdit;
type
  TFormtower = class(TForm)
    Panel2: TPanel;
    Image1: TImage;
    Labelwizardheader1: TLabel;
    Labelwizardheader2: TLabel;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBoxStandardcyl: TGroupBox;
    ValueListEditorCyl: TValueListEditor;
    Panel3: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    ComboBox1: TComboBox;
    ComboBox3: TComboBox;
    RadioGroupHilo: TRadioGroup;
    RadioGroupMomplateside: TRadioGroup;
    Panel4: TPanel;
    PanelShowcopy: TPanel;
    Label2: TLabel;
    ComboBox2: TComboBox;
    CheckBox1: TCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    setcyls : boolean;
    pressid : Longint;
    NColoridstocyl : Longint;
    Coloridstocyl : Array[1..20] of record
                                      colorid : Longint;
                                      cylname : string;
                                    end;
    flatseparationset : Longint;
    { Public declarations }
  end;
var
  Formtower: TFormtower;
implementation
Uses
  umain,udata, Usettings;
{$R *.dfm}
procedure TFormtower.FormActivate(Sender: TObject);
Var
  Pressname,akttowname : string;
  i,idx : Longint;
begin
  try
    akttowname := ComboBox1.text;
    Pressname  := tnames1.pressnameIDtoname(pressid);
    GroupBoxStandardcyl.Visible := true;
    RadioGroupMomplateside.visible := false;
    idx := 0;
    for i := 0 to Length(Prefs.InkGenerationSystemPerPress)-1 do
    begin
      if (Prefs.InkGenerationSystemPerPress[i].Key = Pressname) then
      begin
        idx := i;
        break;
      end;
    end;

    if Prefs.InkGenerationSystemPerPress[idx].Value = 'Monigraf' then
    Begin
      GroupBoxStandardcyl.Visible := false;
      RadioGroupMomplateside.visible := true;
    end;
    ComboBox3.items.clear;
    ComboBox1.items.clear;
    setcyls := false;
    ValueListEditorCyl.Strings.Clear;
    for i := 0 to Length(Prefs.CylinderNameTranslation)-1 do
      ValueListEditorCyl.Strings.add(Prefs.CylinderNameTranslation[i].Value);
    if (not Prefs.UseDBTowerNames) then
    begin
      for i := 0 to Length(Prefs.PressTowers)-1 do
      Begin
        if (uppercase(Pressname) = uppercase(Prefs.PressTowers[i].Press)) then
          ComboBox3.items.add(Prefs.PressTowers[i].Tower);
      end;
    end
    else
    begin
      DataM1.Query1.sql.Clear;
      DataM1.Query1.sql.Add('Select distinct TowerName from PressTowerNames ');
      DataM1.Query1.sql.Add('where pressid = '+inttostr(Pressid));
      DataM1.Query1.sql.Add('order by TowerName');
      formmain.Tryopen(DataM1.Query1);
      ComboBox3.Items.Clear;
      while not DataM1.Query1.eof do
      begin
        ComboBox3.Items.Add(DataM1.Query1.Fields[0].AsString);
        DataM1.Query1.Next;
      end;
      DataM1.Query1.close;
    end;
    For i := 0 to Length(Prefs.ZoneNamesList)-1 do
      ComboBox1.items.add(Prefs.ZoneNamesList[i]);
    ComboBox3.text := akttowname;
  Except
  end;
end;
procedure TFormtower.FormClose(Sender: TObject; var Action: TCloseAction);
Var
  i : Longint;
begin
  setcyls := false;
  NColoridstocyl := 0;

  for i := 1 to ValueListEditorCyl.RowCount-1 do
  begin
    IF ValueListEditorCyl.Cells[1,i] <> '' then
    begin
      Inc(NColoridstocyl);
      Coloridstocyl[NColoridstocyl].colorid := tnames1.Colornametoid(ValueListEditorCyl.Cells[0,i]);
      Coloridstocyl[NColoridstocyl].cylname := ValueListEditorCyl.Cells[1,i];
      setcyls := true;
    end;
  end;
end;
end.
