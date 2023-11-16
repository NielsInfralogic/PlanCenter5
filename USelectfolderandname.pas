unit USelectfolderandname;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, ShellCtrls, StdCtrls, Buttons, ActnList,
  XPStyleActnCtrls, ActnMan, ExtCtrls;

type
  TFormSelectfolderandname = class(TForm)
    ShellTreeView1: TShellTreeView;
    PopupMenu1: TPopupMenu;
    ActionManager1: TActionManager;
    ActionNewfolder: TAction;
    Newfolder1: TMenuItem;
    Actionrefresh: TAction;
    Refresh1: TMenuItem;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    procedure ActionNewfolderExecute(Sender: TObject);
    procedure ActionrefreshExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSelectfolderandname: TFormSelectfolderandname;

implementation
{$R *.dfm}

procedure TFormSelectfolderandname.ActionNewfolderExecute(Sender: TObject);
Var
  foldercreated : boolean;
  newtext,newfoldername : String;
  newtextI : Integer;
  n : ttreenode;
begin
  newtextI := 0;

  newtext := '';
  foldercreated := false;
  newfoldername := ShellTreeView1.SelectedFolder.PathName+'\New Folder'+newtext;
  While not foldercreated do
  begin
    foldercreated := createdir(newfoldername);
    IF not foldercreated then
    begin
      inc(newtextI);
      newtext := '('+inttostr(newtextI)+')';
      newfoldername := ShellTreeView1.SelectedFolder.PathName+'\New Folder'+newtext;
    end;
  end;

  ShellTreeView1.Refresh(ShellTreeView1.Selected);
  n := ShellTreeView1.Selected.getFirstChild;
  While (n <> nil) and (n.Text <> extractfilename(newfoldername)) do
    n := n.getNextSibling;

  ShellTreeView1.Selected := n;

end;

procedure TFormSelectfolderandname.ActionrefreshExecute(Sender: TObject);
begin
  IF ShellTreeView1.Selected <> nil then
    ShellTreeView1.Refresh(ShellTreeView1.Selected);
end;

procedure TFormSelectfolderandname.FormActivate(Sender: TObject);
begin

  IF ShellTreeView1.Selected = nil then
    ShellTreeView1.Selected := ShellTreeView1.Items.GetFirstNode;


  ShellTreeView1.Selected.MakeVisible;
  ShellTreeView1.SetFocus;
end;

procedure TFormSelectfolderandname.Edit1KeyPress(Sender: TObject;
  var Key: Char);
CONST
  LongForbiddenChars  : set of Char = ['?',':','*','<', '>', '|', '"', '\', '/'];

begin
  IF key IN LongForbiddenChars then
  Begin
    key := '#';
  end;
end;

procedure TFormSelectfolderandname.Edit1Change(Sender: TObject);
begin
  BitBtn1.enabled := (edit1.text <> '') And (checkbox1.Checked or checkbox2.Checked);
end;

end.
