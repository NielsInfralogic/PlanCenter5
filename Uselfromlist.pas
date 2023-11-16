unit Uselfromlist;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFormselectfromlist = class(TForm)
    ListBox1: TListBox;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    PanelAllcopies: TPanel;
    CheckBox1: TCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Formselectfromlist: TFormselectfromlist;

implementation

{$R *.dfm}

procedure TFormselectfromlist.FormActivate(Sender: TObject);
begin
  ListBox1.Items.add('Reset device');

end;

procedure TFormselectfromlist.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  Formselectfromlist.PanelAllcopies.Visible := false;

end;

end.
