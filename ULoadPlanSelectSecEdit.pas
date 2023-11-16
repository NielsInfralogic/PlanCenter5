unit ULoadPlanSelectSecEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

type
  TFormSelectSecEd = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    ListBoxSec: TListBox;
    Panel4: TPanel;
    Label2: TLabel;
    ListBoxEdition: TListBox;
    Panel5: TPanel;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSelectSecEd: TFormSelectSecEd;

implementation

{$R *.dfm}


procedure TFormSelectSecEd.BitBtn1Click(Sender: TObject);
begin
  close;
end;

end.
