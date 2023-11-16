unit UTabs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls;

type
  TFormtabs = class(TForm)
    GroupBox17: TGroupBox;
    CheckBoxplantab: TCheckBox;
    CheckBoxprodtab: TCheckBox;
    CheckBoxplatetab: TCheckBox;
    CheckBoxlogtab: TCheckBox;
    CheckBoxpagelist: TCheckBox;
    CheckBoxThumbnailtab: TCheckBox;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    CheckBoxEdtab: TCheckBox;
    CheckBoxreporttab: TCheckBox;
    CheckBoxunkowntab: TCheckBox;
    CheckBoxactQtab: TCheckBox;
    CheckBoxschedule: TCheckBox;
    BitBtn3: TBitBtn;
    ListViewtabs: TListView;
    BitBtn2: TBitBtn;
    CheckBoxStatus: TCheckBox;
    procedure ListViewtabsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    DBset : Boolean;
    procedure loadtabsettings;
    Procedure settabvisible;
  end;

var
  Formtabs: TFormtabs;

implementation

{$R *.dfm}
Uses
  umain,
  inifiles, Udata, Ulogin,utypes;

Var
  AONOFF : Array[0..1] of String;

procedure TFormtabs.loadtabsettings;

Var
  i : Longint;
  l : Tlistitem;
  T : String;
  ini : tinifile;
begin
  formmain.writeinitlog('Loading settings');
  AONOFF[0] := 'OFF';
  AONOFF[1] := 'ON';
  ListViewtabs.Items.Clear;
  IF dbset then
  begin
    formmain.writeinitlog('Using DB');
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.add('select UserGroupName,PlanCenterViews from UserGroupNames');
    DataM1.Query1.SQL.add('order by UserGroupName');
    DataM1.Query1.open;

    While not DataM1.Query1.eof do
    begin
      l := ListViewtabs.Items.add;
      l.Caption := DataM1.Query1.fields[0].AsString;
      T := DataM1.Query1.fields[1].AsString;

      IF length(t) <> 11 then
      begin
        T := '11111111111';
      end;

      For i := 1 to 11 do
      begin
        IF t[i] = '1' then
          l.SubItems.add('ON')
        else
          l.SubItems.add('OFF');
      end;

      DataM1.Query1.next;
    end;
    formmain.writeinitlog('Loaded');
    DataM1.Query1.close;
  end
  else
  begin
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.add('select UserGroupName from UserGroupNames');
    DataM1.Query1.SQL.add('order by UserGroupName');
    DataM1.Query1.open;

    While not DataM1.Query1.eof do
    begin
      l := ListViewtabs.Items.add;
      l.Caption := DataM1.Query1.fields[0].AsString;

      ini := tinifile.Create(IncludeTrailingBackslash(MainCCConfig) + DataM1.Query1.fields[0].AsString+'.tab');

      l.subitems.add(AONOFF[Integer(ini.readBool('Tabs','CheckBoxpagelist',true))]);
      l.subitems.add(AONOFF[Integer(ini.readBool('Tabs','CheckBoxThumbnailtab',true))]);
      l.subitems.add(AONOFF[Integer(ini.readBool('Tabs','CheckBoxplatetab',true))]);
      l.subitems.add(AONOFF[Integer(ini.readBool('Tabs','CheckBoxprodtab',true))]);
      l.subitems.add(AONOFF[Integer(ini.readBool('Tabs','CheckBoxlogtab',true))]);
      l.subitems.add(AONOFF[Integer(ini.readBool('Tabs','CheckBoxplantab',true))]);
      l.subitems.add(AONOFF[Integer(ini.readBool('Tabs','CheckBoxEdtab',true))]);
      l.subitems.add(AONOFF[Integer(ini.readBool('Tabs','CheckBoxreporttab',true))]);
      l.subitems.add(AONOFF[Integer(ini.readBool('Tabs','CheckBoxunkowntab',true))]);
      l.subitems.add(AONOFF[Integer(ini.readBool('Tabs','CheckBoxactQtab',true))]);
      l.subitems.add(AONOFF[Integer(ini.readBool('Tabs','CheckBoxStatus',true))]);

      ini.free;
      DataM1.Query1.next;
    End;
    DataM1.Query1.close;
  end;

end;

procedure TFormtabs.ListViewtabsSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  CheckBoxpagelist.checked      := item.SubItems[0] = 'ON';
  CheckBoxThumbnailtab.checked  := item.SubItems[1] = 'ON';
  CheckBoxplatetab.checked      := item.SubItems[2] = 'ON';
  CheckBoxprodtab.checked       := item.SubItems[3] = 'ON';
  CheckBoxEdtab.checked        := item.SubItems[4] = 'ON';
  CheckBoxplantab.checked       := item.SubItems[5] = 'ON';
  CheckBoxlogtab.checked         := item.SubItems[6] = 'ON';
  CheckBoxreporttab.checked     := item.SubItems[7] = 'ON';
  CheckBoxunkowntab.checked     := item.SubItems[8] = 'ON';
  CheckBoxactQtab.checked       := item.SubItems[9] = 'ON';
  CheckBoxStatus.checked       := item.SubItems[10] = 'ON';
end;

procedure TFormtabs.BitBtn3Click(Sender: TObject);
begin
  IF ListViewtabs.selected = nil then exit;

  if CheckBoxpagelist.checked or CheckBoxThumbnailtab.checked or CheckBoxplatetab.checked or
     CheckBoxprodtab.checked or CheckBoxlogtab.checked or CheckBoxplantab.checked or
     CheckBoxEdtab.checked or CheckBoxreporttab.checked or CheckBoxunkowntab.checked or
     CheckBoxactQtab.checked or CheckBoxschedule.checked then
  begin

    ListViewtabs.selected.subitems[0] := AONOFF[Integer(CheckBoxpagelist.checked)];
    ListViewtabs.selected.subitems[1] := AONOFF[Integer(CheckBoxThumbnailtab.checked)];
    ListViewtabs.selected.subitems[2] := AONOFF[Integer(CheckBoxplatetab.checked)];
    ListViewtabs.selected.subitems[3] := AONOFF[Integer(CheckBoxprodtab.checked)];
    ListViewtabs.selected.subitems[4] := AONOFF[Integer(CheckBoxEdtab.checked)];
    ListViewtabs.selected.subitems[5] := AONOFF[Integer(CheckBoxplantab.checked)];
    ListViewtabs.selected.subitems[6] := AONOFF[Integer(CheckBoxlogtab.checked)];
    ListViewtabs.selected.subitems[7] := AONOFF[Integer(CheckBoxreporttab.checked)];
    ListViewtabs.selected.subitems[8] := AONOFF[Integer(CheckBoxunkowntab.checked)];
    ListViewtabs.selected.subitems[9] := AONOFF[Integer(CheckBoxactQtab.checked)];
    ListViewtabs.selected.subitems[10] := AONOFF[Integer(CheckBoxStatus.checked)];

  end
  else
  begin
    MessageDlg(formmain.InfraLanguage1.Translate('No tabs visible'), mterror,[mbOk], 0);

  end;
end;

procedure TFormtabs.BitBtn1Click(Sender: TObject);
Var
  I,I1 : longint;
  TabT,T : string;
  ini : Tinifile;
begin
  IF dbset then
  begin
    for i := 0 to ListViewtabs.Items.Count-1 do
    begin
      TabT := '';
      For I1 := 0 to ListViewtabs.Items[i].SubItems.Count-1 do
      begin
        IF ListViewtabs.Items[i].SubItems[i1] = 'ON' then
          TabT := TabT +'1'
        else
          TabT := TabT +'0';
      end;
      DataM1.Query1.SQL.Clear;
      DataM1.Query1.SQL.add('Update UserGroupNames');
      DataM1.Query1.SQL.add('Set PlanCenterViews = ' + ''''+TabT+'''');

      DataM1.Query1.SQL.add('Where UserGroupName = ' + ''''+ListViewtabs.Items[i].Caption+'''');
      formmain.trysql(DataM1.Query1);
    end;
  End
  Else
  begin
    for i := 0 to ListViewtabs.Items.Count-1 do
    begin
      ini := tinifile.Create(IncludeTrailingBackslash(MainCCConfig) + ListViewtabs.Items[i].Caption+'.tab');
      ini.writeBool('Tabs','CheckBoxpagelist',    ListViewtabs.Items[i].SubItems[0] = 'ON');
      ini.writeBool('Tabs','CheckBoxThumbnailtab',ListViewtabs.Items[i].SubItems[1] = 'ON');
      ini.writeBool('Tabs','CheckBoxplatetab',    ListViewtabs.Items[i].SubItems[2] = 'ON');
      ini.writeBool('Tabs','CheckBoxprodtab',     ListViewtabs.Items[i].SubItems[3] = 'ON');
      ini.writeBool('Tabs','CheckBoxEdtab',       ListViewtabs.Items[i].SubItems[4] = 'ON');
      ini.writeBool('Tabs','CheckBoxplantab',     ListViewtabs.Items[i].SubItems[5] = 'ON');
      ini.writeBool('Tabs','CheckBoxlogtab',      ListViewtabs.Items[i].SubItems[6] = 'ON');
      ini.writeBool('Tabs','CheckBoxreporttab',   ListViewtabs.Items[i].SubItems[7] = 'ON');
      ini.writeBool('Tabs','CheckBoxunkowntab',   ListViewtabs.Items[i].SubItems[8] = 'ON');
      ini.writeBool('Tabs','CheckBoxactQtab',     ListViewtabs.Items[i].SubItems[9] = 'ON');
      ini.writeBool('Tabs','CheckBoxactStat',     ListViewtabs.Items[i].SubItems[10] = 'ON');

      ini.free;
    End;
  end;

end;

Procedure TFormtabs.settabvisible;
Var
  I : Longint;

Begin
  formmain.writeinitlog('Settings tabs');


  if (Prefs.Proversion = 2) Then
  Begin
    CheckBoxpagelist.checked     := true;
    CheckBoxThumbnailtab.checked := true;
    CheckBoxplatetab.checked     := true;
    CheckBoxprodtab.checked      := true;
    CheckBoxlogtab.checked       := true;
    CheckBoxplantab.checked      := true;
    CheckBoxEdtab.checked        := true;
    CheckBoxreporttab.checked    := true;
    CheckBoxunkowntab.checked    := true;
    CheckBoxactQtab.checked      := true;
    CheckBoxschedule.checked     := true;


    (*
    IF true then
    begin
      formmain.writeinitlog('Using db');
      For i := 0 to ListViewtabs.Items.Count -1 do
      begin
        IF uppercase(formlogin.Usergroupname) = uppercase(ListViewtabs.Items[i].Caption) then
        begin
          formmain.writeinitlog('Found'+formlogin.Usergroupname);
          CheckBoxpagelist.checked      := ListViewtabs.Items[i].SubItems[0] = 'ON';
          CheckBoxThumbnailtab.checked  := ListViewtabs.Items[i].SubItems[1] = 'ON';
          CheckBoxplatetab.checked      := ListViewtabs.Items[i].SubItems[2] = 'ON';
          CheckBoxprodtab.checked       := ListViewtabs.Items[i].SubItems[3] = 'ON';
          CheckBoxEdtab.checked         := ListViewtabs.Items[i].SubItems[4] = 'ON';
          CheckBoxplantab.checked       := ListViewtabs.Items[i].SubItems[5] = 'ON';
          CheckBoxlogtab.checked        := ListViewtabs.Items[i].SubItems[6] = 'ON';
          CheckBoxreporttab.checked     := ListViewtabs.Items[i].SubItems[7] = 'ON';
          CheckBoxunkowntab.checked     := ListViewtabs.Items[i].SubItems[8] = 'ON';
          CheckBoxactQtab.checked       := ListViewtabs.Items[i].SubItems[9] = 'ON';
          break;
        end;
      end;
    end
    else
    begin

    End;
    *)

    CheckBoxpagelist.checked     := true;
    CheckBoxThumbnailtab.checked := true;
    CheckBoxplatetab.checked     := true;
    CheckBoxprodtab.checked      := true;
    CheckBoxlogtab.checked       := false;
    CheckBoxplantab.checked      := true;
    CheckBoxEdtab.checked        := false;
    CheckBoxreporttab.checked    := false;
    CheckBoxunkowntab.checked    := false;
    CheckBoxactQtab.checked      := false;
    CheckBoxschedule.checked     := false;
    formmain.TabSheetEdition.TabVisible := false;
    CheckBoxStatus.checked     := false;
  End
  else
  begin



    CheckBoxpagelist.checked     := true;
    CheckBoxThumbnailtab.checked := true;
    CheckBoxplatetab.checked     := true;
    CheckBoxprodtab.checked      := true;
    CheckBoxlogtab.checked       := true;
    CheckBoxplantab.checked      := true;
    CheckBoxEdtab.checked        := true;
    CheckBoxreporttab.checked    := true;
    CheckBoxunkowntab.checked    := true;
    CheckBoxactQtab.checked      := true;
    CheckBoxschedule.checked     := true;
    CheckBoxStatus.checked     := true;

    IF (*Formtabs.DBset*) true then
    begin

      formmain.writeinitlog('Using db');
      For i := 0 to ListViewtabs.Items.Count -1 do
      begin
        IF uppercase(Prefs.Usergroupname) = uppercase(ListViewtabs.Items[i].Caption) then
        begin
          formmain.writeinitlog('Found'+Prefs.Usergroupname);
          CheckBoxpagelist.checked      := ListViewtabs.Items[i].SubItems[0] = 'ON';
          CheckBoxThumbnailtab.checked  := ListViewtabs.Items[i].SubItems[1] = 'ON';
          CheckBoxplatetab.checked      := ListViewtabs.Items[i].SubItems[2] = 'ON';
          CheckBoxprodtab.checked       := ListViewtabs.Items[i].SubItems[3] = 'ON';
          CheckBoxEdtab.checked         := ListViewtabs.Items[i].SubItems[4] = 'ON';
          CheckBoxplantab.checked       := ListViewtabs.Items[i].SubItems[5] = 'ON';
          CheckBoxlogtab.checked        := ListViewtabs.Items[i].SubItems[6] = 'ON';
          CheckBoxreporttab.checked     := ListViewtabs.Items[i].SubItems[7] = 'ON';
          CheckBoxunkowntab.checked     := ListViewtabs.Items[i].SubItems[8] = 'ON';
          CheckBoxactQtab.checked       := ListViewtabs.Items[i].SubItems[9] = 'ON';
          CheckBoxStatus.checked       := ListViewtabs.Items[i].SubItems[10] = 'ON';
          break;
        end;
      end;
    end
    else
    begin

    End;

    if Globalsystemtype = 3 then
    begin
      formmain.TabSheetplates.TabVisible := false;
      formmain.TabSheetactiivequeue.TabVisible := false;
    End;

    if (Prefs.Proversion > 0) then
    Begin
      formmain.TabSheetEdition.TabVisible := false;
    end;
  end;
end;


end.
