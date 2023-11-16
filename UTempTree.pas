unit UTempTree;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls;

type
  TFormtemptree = class(TForm)
    TreeViewTemp: TTreeView;
    Button1: TButton;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Formtemptree: TFormtemptree;

implementation

{$R *.dfm}
Uses
  utypes;

procedure TFormtemptree.Button1Click(Sender: TObject);
begin
  Edit1.text := inttostr(TTreeViewpagestype(TreeViewTemp.Selected.Data^).publicationid);
end;

end.
