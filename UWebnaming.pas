unit UWebnaming;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFormWebnaming = class(TForm)
    Panel2: TPanel;
    Image1: TImage;
    Labelwizardheader1: TLabel;
    ComboBox1: TComboBox;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ComboBox2: TComboBox;
    lblCopy1: TLabel;
    lblCopy2: TLabel;
    CheckBocApplyToAllPlates: TCheckBox;
    procedure InitNames;
  private
    { Private declarations }
  public
    Webkindname : Longint;{ 1 press 2 zone 3 highlow 4 true frontback }
    pressid     : Longint;
  end;

var
  FormWebnaming: TFormWebnaming;

implementation

uses Udata, Umain, Usettings;

{$R *.dfm}


procedure TFormWebnaming.InitNames;
var
  i : Integer;
begin
  ComboBox1.Items.Clear;
  ComboBox2.Items.Clear;

  ComboBox2.Visible := false;
  lblCopy1.Visible := false;
  lblCopy2.Visible := false;

  CheckBocApplyToAllPlates.Checked := false;
  CheckBocApplyToAllPlates.Enabled := false;
  Case Webkindname of
    1 : Begin
          if (Prefs.UseDBTowerNames) then
          begin
            DataM1.Query1.sql.clear;
            DataM1.Query1.sql.add('Select distinct TowerName from PressTowerNames');
            DataM1.Query1.sql.add('where pressid = '+IntToStr(pressid));
            DataM1.Query1.sql.add('order by TowerName');
            formmain.Tryopen(DataM1.Query1);
            ComboBox1.Items.Clear;
            ComboBox1.Items.Add('<None>');
            While not DataM1.Query1.Eof do
            begin
              ComboBox1.Items.Add(DataM1.Query1.Fields[0].AsString);
              DataM1.Query1.Next;
            end;
            DataM1.Query1.Close;
          End
          Else
          begin
            ComboBox1.Items.Clear;
            ComboBox1.Items.Add('<None>');
            for i := 0 to Length(Prefs.PressTowers)-1 do
            Begin
              if Uppercase(tnames1.pressnameIDtoname(pressid)) = Uppercase(Prefs.PressTowers[i].Press) then
                ComboBox1.Items.Add(Prefs.PressTowers[i].Tower);
            end;
          end;
        end;

    2 : Begin
          IF Prefs.UseDBTowerNames then
          begin
            DataM1.Query1.sql.Clear;
            DataM1.Query1.sql.Add('Select ZoneName1,ZoneName2,ZoneName3,ZoneName4 from PressNames');
            DataM1.Query1.sql.Add('where pressid = '+inttostr(pressid));
            formmain.Tryopen(DataM1.Query1);
            ComboBox1.Items.Clear;
            IF not DataM1.Query1.Eof then
            begin
              IF DataM1.Query1.fields[0].AsString <> '' then
                ComboBox1.Items.Add(DataM1.Query1.Fields[0].AsString);
              IF DataM1.Query1.Fields[1].AsString <> '' then
                ComboBox1.Items.Add(DataM1.Query1.Fields[1].AsString);
              IF DataM1.Query1.Fields[2].AsString <> '' then
                ComboBox1.Items.Add(DataM1.Query1.Fields[2].AsString);
              IF DataM1.Query1.Fields[3].AsString <> '' then
                ComboBox1.Items.Add(DataM1.Query1.Fields[3].AsString);
            end;
            DataM1.Query1.Close;
          End
          Else
          begin
            ComboBox1.items.Clear;
            For i := 0 to Length(Prefs.ZoneNamesList)-1 do
              ComboBox1.Items.Add(Prefs.ZoneNamesList[i]);
          end;
        end;
    3 : Begin
        ComboBox2.Visible := true;
        lblCopy1.Visible := true;
        lblCopy2.Visible := true;
        CheckBocApplyToAllPlates.Enabled := true;
         IF Prefs.UseDBTowerNames then
          begin
            DataM1.Query1.sql.clear;
            DataM1.Query1.sql.add('Select TOP 1 HighName,LowName from PressNames');
            DataM1.Query1.sql.add('where pressid = '+inttostr(pressid));
            formmain.Tryopen(DataM1.Query1);
            ComboBox1.Items.Clear;
            ComboBox2.Items.Clear;

            IF not DataM1.Query1.eof then
            begin
              IF DataM1.Query1.Fields[0].AsString <> '' then
                ComboBox1.Items.Add(DataM1.Query1.Fields[0].AsString);
              IF DataM1.Query1.Fields[1].AsString <> '' then
                ComboBox1.Items.Add(DataM1.Query1.Fields[1].AsString);

              IF DataM1.Query1.Fields[0].AsString <> '' then
                ComboBox2.Items.Add(DataM1.Query1.Fields[0].AsString);
              IF DataM1.Query1.Fields[1].AsString <> '' then
                ComboBox2.Items.Add(DataM1.Query1.Fields[1].AsString);
            end;
            DataM1.Query1.Close;
          End
          Else
          begin
            ComboBox1.Items.Clear;
            ComboBox1.Items.Add(Prefs.PressHighPlateName);
            ComboBox1.Items.Add(Prefs.PressLowPlateName);
            ComboBox2.Items.Clear;
            ComboBox2.Items.Add(Prefs.PressHighPlateName);
            ComboBox2.Items.Add(Prefs.PressLowPlateName);

          end;
        end;
    4 : Begin

          ComboBox1.Items.Clear;
          ComboBox1.Items.Add('Front');
          ComboBox1.Items.Add('Back');
        end;
  end;
  ComboBox1.ItemIndex := 0;
  ComboBox2.ItemIndex := 0;
end;

end.
