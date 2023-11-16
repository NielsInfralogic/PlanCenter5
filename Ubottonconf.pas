unit Ubottonconf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls;

type
  TFormbuttonconfig = class(TForm)
    Panel3: TPanel;
    Image3: TImage;
    Label8: TLabel;
    Label10: TLabel;
    GroupBox1: TGroupBox;
    ComboBox1: TComboBox;
    TreeView1: TTreeView;
    TreeView2: TTreeView;
    TreeView3: TTreeView;
    TreeView4: TTreeView;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure init;
  end;

var
  Formbuttonconfig: TFormbuttonconfig;

implementation

{$R *.dfm}

procedure TFormbuttonconfig.init;

Var
  I : Longint;
  T : string;
begin
  (*

  edit1.Text := inttostr(ActionManager1.ActionCount);
  ListBox1.Items.Clear;
  For i := 0 to ActionManager1.ActionCount -1 do
  begin
    ListBox1.Items.add(ActionManager1.Actions[i].Category + ' / ' + TAction(ActionManager1.Actions[i]).Caption + ' / '+ inttostr(ActionManager1.Actions[i].Tag));
  end;
  ListBox1.Items.SaveToFile('c:\actions.txt');
  *)

End;


end.
