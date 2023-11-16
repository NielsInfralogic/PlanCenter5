unit Upageinfoframe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls;

type
  TFramepageinformation = class(TFrame)
    GroupBox1: TGroupBox;
    ListView1: TListView;
    TreeView1: TTreeView;
    Label1: TLabel;
  private
    { Private declarations }
  public
    Procedure insertpagedata(aktnode : ttreenode;
                                            orgnode : ttreenode;
                                            editorialnode : ttreenode);

  end;

implementation

{$R *.dfm}
uses
  umain;
Procedure TFramepageinformation.insertpagedata(aktnode : ttreenode;
                                               orgnode : ttreenode;
                                               editorialnode : ttreenode);
var
  I: Integer;
//  NewColumn: TListColumn;
//  ListItem: TListItem;
  nnode : ttreenode;

begin
  TreeView1.Items.clear;
  nnode := TreeView1.items.Add(nil, orgnode.Parent.Parent.Parent.Parent.text);
  nnode.ImageIndex := orgnode.Parent.Parent.Parent.Parent.ImageIndex;
  nnode.selectedIndex := orgnode.Parent.Parent.Parent.Parent.ImageIndex;
  nnode.stateIndex := orgnode.Parent.Parent.Parent.Parent.stateIndex;

  nnode := TreeView1.items.AddChildFirst(nnode,orgnode.Parent.Parent.Parent.text);
  nnode.ImageIndex := orgnode.Parent.Parent.Parent.ImageIndex;
  nnode.selectedIndex := orgnode.Parent.Parent.Parent.ImageIndex;
  nnode.stateIndex := orgnode.Parent.Parent.Parent.stateIndex;
  nnode := TreeView1.items.AddChildFirst(nnode,orgnode.Parent.Parent.text);
  nnode.ImageIndex := orgnode.Parent.Parent.ImageIndex;
  nnode.selectedIndex := orgnode.Parent.Parent.ImageIndex;
  nnode.stateIndex := orgnode.Parent.Parent.stateIndex;
  nnode := TreeView1.items.AddChildFirst(nnode,orgnode.Parent.text);
  nnode.ImageIndex := orgnode.Parent.ImageIndex;
  nnode.selectedIndex := orgnode.Parent.ImageIndex;

  nnode.stateIndex := orgnode.Parent.stateIndex;

  for i := 0 to TreeView1.Items.Count-1 do
  Begin
    TreeView1.Items[i].Expand(true);
    Case TreeView1.Items[i].level of
      1 : begin
            TreeView1.Items[i].ImageIndex := 3;
            TreeView1.Items[i].selectedIndex := 3;

          end;

    end;
  End;
End;

end.




