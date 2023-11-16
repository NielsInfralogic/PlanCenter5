unit Uusercolssaveload;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, CheckLst, ExtCtrls;
type
  TFormSaveloadcols = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    CheckListBox1: TCheckListBox;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    Panel3: TPanel;
    BitBtn2: TBitBtn;
    GroupBox2: TGroupBox;
    Panel4: TPanel;
    BitBtn3: TBitBtn;
    ListBox1: TListBox;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure loadAuserColsort(userfile : string; userfile2 : string);
    Procedure Savemycols(Username : string);
    { Public declarations }
  end;
var
  FormSaveloadcols: TFormSaveloadcols;
implementation
{$R *.dfm}
Uses
  UUser, Udata,umain,inifiles,utypes, Ulogin, UUtils;

procedure TFormSaveloadcols.FormActivate(Sender: TObject);
var F: TSearchRec;
  R : longint;
  i : Longint;
begin
  CheckListBox1.Items.Clear;
  datam1.Query2.SQL.Clear;
  datam1.Query2.SQL.Add('select Username from usernames');
  datam1.Query2.SQL.Add('order by Username');
  datam1.Query2.Open;
  while not datam1.Query2.Eof do
  begin
    CheckListBox1.items.add(datam1.Query2.Fields[0].AsString);
    datam1.Query2.Next;
  end;
  datam1.Query2.Close;
  For i := 0 to CheckListBox1.Items.Count-1 do
    CheckListBox1.Checked[i] := false;
  ListBox1.Items.Clear;
  R := FindFirst(includetrailingbackslash(MainCCConfig) +'*.col',faArchive,F);
  While R = 0 do
  begin
    ListBox1.Items.Add(changefileext(f.Name,''));
    r := findnext(f);
  end;
  findclose(f);
end;
Procedure TFormSaveloadcols.BitBtn2Click(Sender: TObject);
Var
  inif : tinifile;
  I,iu : Longint;
begin
  inif := tinifile.Create(includetrailingbackslash(MainCCConfig) + 'Utemp.col');
  For i := 0 to 200 do
  Begin
    inif.writeinteger('Order',inttostr(I),HSOrder[i]);
    inif.writeinteger('Width',inttostr(I),HSCols[i].Width);
  End;
  inif.Free;
  Sleep(100);
  application.ProcessMessages;

  For iu := 0 to CheckListBox1.Items.Count-1 do
  Begin
    IF CheckListBox1.Checked[iu] then
    begin
      copyfile(pchar(includetrailingbackslash(MainCCConfig) + 'Utemp.col'),pchar(includetrailingbackslash(MainCCConfig) + CheckListBox1.items[iu]+ '.col'),false);
    End;
  end;
end;
procedure TFormSaveloadcols.BitBtn3Click(Sender: TObject);
Begin
  IF listbox1.ItemIndex > -1 then
  Begin
    loadAuserColsort(listbox1.items[listbox1.ItemIndex], listbox1.items[listbox1.ItemIndex]);
  End;
end;

procedure TFormSaveloadcols.loadAuserColsort(userfile : string; userfile2 : string);
Var
  inif : tinifile;
  I : Longint;
  colpath : string;
  inipath : string;
begin
  colpath := includetrailingbackslash(MainCCConfig) + userfile +'.col';
  if FileExists(colpath) = false then
    colpath := includetrailingbackslash(MainCCConfig) + userfile2 +'.col';
  inipath :=  IncludeTrailingBackSlash(TUtils.GetTempDirectory())+'tempHSCol.ini';
  IF fileexists(colpath) then
  begin
    IF copyfile(pchar(colpath),pchar(inipath),false) then
    begin
      inif := tinifile.Create(inipath);
      For i := 0 to 200 do
      Begin
        HSOrder[i] := inif.readinteger('Order',inttostr(I),HSOrder[i]);
        HSCols[i].Width := inif.readinteger('Width',inttostr(I),HSCols[i].Width);
      End;
      inif.Free;
    End;
  End;
end;

procedure TFormSaveloadcols.Savemycols(Username : string);
Var
  inif : tinifile;
  I    : Longint;
  colpath    : string;
  inipath : string;
begin
  colpath := includetrailingbackslash(MainCCConfig) + username+'.col';
  inipath := IncludeTrailingBackSlash(TUtils.GetTempDirectory())+'tempHSCol.ini';
  try
    inif := tinifile.Create(inipath);
    For i := 0 to 200 do
    Begin
      inif.writeinteger('Order',inttostr(I),HSOrder[i]);
      inif.writeinteger('Width',inttostr(I),HSCols[i].Width);
    End;
    inif.Free;
  except

  end;
  IF not CopyFile(pchar(inipath),pchar(colpath),false) then
  begin
    MessageDlg(formmain.InfraLanguage1.Translate('Cannot write') +' ' + colpath, mtError,[mbOk], 0);
  End;
  //Ovenstående skal formendlig væk, nu gemmes der direkte i DataListorder.ini filen
  try
    inif := tinifile.Create(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory())+'DataListorder.ini');
    For i := 0 to 200 do
    Begin
      inif.writeinteger('Order',inttostr(I),HSOrder[i]);
      inif.writeinteger('Width',inttostr(I),HSCols[i].Width);
    End;
    inif.Free;
  except
  end;
end;

end.
