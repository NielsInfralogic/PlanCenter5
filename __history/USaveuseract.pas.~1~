unit USaveuseract;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, system.UITypes;

type
  TFormsaveandloaduseract = class(TForm)
    BitBtnSave: TBitBtn;
    BitBtnLoad: TBitBtn;
    GroupBox1: TGroupBox;
    ComboBoxuser: TComboBox;
    BitBtn1: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure BitBtnSaveClick(Sender: TObject);
    procedure BitBtnLoadClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Loading: boolean;
  end;

var
  Formsaveandloaduseract: TFormsaveandloaduseract;

implementation

uses Udata, inifiles, umain, UActionconfig, UUtils;

{$R *.dfm}

procedure TFormsaveandloaduseract.FormActivate(Sender: TObject);
var
  F: TSearchRec;
  R: longint;

begin
  if Loading then
  begin
    BitBtnLoad.Visible := true;
    BitBtnSave.Visible := false;

    ComboBoxuser.Items.Clear;
    R := FindFirst(MainCCConfig + '*.act', faArchive, F);
    while R = 0 do
    begin
      ComboBoxuser.Items.Add(changefileext(F.Name, ''));
      R := findnext(F);
    end;
    findclose(F);
  end
  else
  begin
    BitBtnLoad.Visible := false;
    BitBtnSave.Visible := true;
    ComboBoxuser.Items.Clear;
    datam1.Query2.SQL.Clear;
    datam1.Query2.SQL.Add('select Username from usernames');
    datam1.Query2.SQL.Add('order by Username');
    datam1.Query2.Open;
    while not datam1.Query2.Eof do
    begin
      ComboBoxuser.Items.Add(Datam1.Query2.Fields[0].AsString);
      datam1.Query2.Next;
    end;
    datam1.Query2.Close;
    ComboBoxuser.itemindex := 0;
  end;
end;

procedure TFormsaveandloaduseract.BitBtnSaveClick(Sender: TObject);
var
  ini: Tinifile;
  i: longint;

  inipath : string;
  actpath : string;
begin
  i := 0;
  inipath :=  IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory())+'tempactions.ini';

  try
    ini := Tinifile.create(inipath);
    for i := 0 to FormActionconfig.TreeViewactions.Items.Count - 1 do
    begin
      if FormActionconfig.TreeViewactions.Items[i].Level = 1 then
      begin
        if (FormActionconfig.TreeViewactions.Items[i].Data <> nil) and
          (FormActionconfig.TreeViewactions.Items[i].Parent.Text <> '') then
          ini.WriteInteger(FormActionconfig.TreeViewactions.Items[i]
                .Parent.Text, Tactdatype(FormActionconfig.TreeViewactions.Items[i]
                .Data^).Name, FormActionconfig.TreeViewactions.Items[i].StateIndex);
      end;
    end;
    ini.Free;
  except
  end;

  actpath := IncludeTrailingBackSlash(MainCCConfig) + ComboBoxuser.Text + '.Act';
  if not CopyFile(pchar(inipath), pchar(actpath), false) then
  begin
    MessageDlg(formmain.InfraLanguage1.Translate('Cannot write') + ' ' + actpath, mtError, [mbOk], 0);
  end;

  if (Prefs.Proversion = 2) then
  begin
    actpath := extractfilepath(application.ExeName) + 'PLCPro.Act';  // OK!
    if not CopyFile(pchar(inipath), pchar(actpath), false) then
    begin
      MessageDlg(formmain.InfraLanguage1.Translate('Cannot write') + ' ' + actpath,
        mtError, [mbOk], 0);
    end;
  end;

end;

procedure TFormsaveandloaduseract.BitBtnLoadClick(Sender: TObject);
var
  ini: Tinifile;
  x, i: longint;
  T: string;
  inipath : string;
  actpath : string;
begin
  inipath :=  IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory())+'tempactions.ini';

  actpath := IncludeTrailingBackSlash(MainCCConfig) + ComboBoxuser.Text + '.Act';
  if CopyFile(PChar(actpath), PChar(inipath), false) then
  begin
    try
      ini := TiniFile.Create(inipath);
      for i := 0 to FormActionconfig.TreeViewactions.Items.Count - 1 do
      begin
        if (FormActionconfig.TreeViewactions.Items[i].Level = 1) then
        begin
          x := ini.ReadInteger(FormActionconfig.TreeViewactions.Items[i]
                              .Parent.Text, Tactdatype(FormActionconfig.TreeViewactions.Items[i]
                              .Data^).Name, 1);
          FormActionconfig.TreeViewactions.Items[i].StateIndex := x;
        end;
      end;

      ini.Free;
    except

    end;

  end;
end;

end.
