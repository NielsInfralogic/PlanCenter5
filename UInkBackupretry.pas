unit UInkBackupretry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ShellCtrls;

type
  TFormInkbackupFile = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    DateTimePicker1: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    ListView1: TListView;
    BitBtn2: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure ListView1Compare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure FormCreate(Sender: TObject);
    procedure ListView1ColumnClick(Sender: TObject; Column: TListColumn);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure loadlist;
  end;

var
  FormInkbackupFile: TFormInkbackupFile;

implementation

{$R *.dfm}
Uses
  usettings;

Var
  Frompath,Topath : String;
  SortUp : Boolean;
  ColumnToSort : Longint;

procedure TFormInkbackupFile.loadlist;
Var
  F: TSearchRec;
  R : Longint;
  L : Tlistitem;
  TD : Tdatetime;
Begin
  ListView1.Items.BeginUpdate;
  ListView1.Items.Clear;

  R := FindFirst(Frompath+Edit1.Text,faArchive	,F);
  While R = 0 do
  begin
    L := ListView1.Items.Add;
    L.Caption := F.Name;
    TD :=  FileDateToDateTime(F.Time);
    if DateTimePicker1.Checked then
    begin
      if td >= DateTimePicker1.Date then
        L.SubItems.Add( FormatDateTime('yyyy-mm-dd hh:nn:ss',TD));
    end
    else
      L.SubItems.Add(FormatDateTime('yyyy-mm-dd hh:nn:ss',TD));
    R := findnext(F);
  end;
  Findclose(F);

  ListView1.AlphaSort;
  ListView1.Items.EndUpdate;
end;


procedure TFormInkbackupFile.FormActivate(Sender: TObject);
begin
  DateTimePicker1.Date := now;
  //Frompath := includetrailingbackslash(InkBackups);
  //Topath := includetrailingbackslash(foxrmsettings.Editinksystemhotfolder.Text);
  loadlist;
end;

procedure TFormInkbackupFile.ListView1Compare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
var
  ix: Integer;
begin
  if ColumnToSort = 0 then
    Compare := CompareText(Item1.Caption,Item2.Caption)
  else begin
   ix := ColumnToSort - 1;
   Compare := CompareText(Item1.SubItems[ix],Item2.SubItems[ix]);
  end;

  IF Sortup then
  begin
    IF Compare <> 0 then
    begin
      Compare := Compare * -1;
    end;
  end;

end;

procedure TFormInkbackupFile.FormCreate(Sender: TObject);
begin
  SortUp := false;
  ColumnToSort := 0;
end;

procedure TFormInkbackupFile.ListView1ColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  IF ColumnToSort = Column.Index then
    SortUp := Not SortUp;
  ColumnToSort := Column.Index;
  ListView1.AlphaSort;
end;

procedure TFormInkbackupFile.BitBtn2Click(Sender: TObject);
Var
  I : Longint;
begin
  For i :=  0 to listview1.Items.Count-1 do
  begin
    if listview1.Items[i].Selected then
    begin
      if not copyfile(pchar(frompath+listview1.items[i].caption),pchar(topath+listview1.items[i].caption),false) then
      begin

      end;
    end;
  end;
end;

end.
