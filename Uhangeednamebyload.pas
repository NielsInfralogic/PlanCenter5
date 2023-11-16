unit Uhangeednamebyload;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFormchednameload = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ListBox1: TListBox;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Formchednameload: TFormchednameload;

implementation

Uses
  umain;
{$R *.dfm}

procedure TFormchednameload.FormActivate(Sender: TObject);
begin
  Formmain.loadids('Formchednameload', false);
  listbox1.Items.Clear;

  listbox1.Items := tnames1.Editionnames;
  listbox1.Itemindex := 0;
end;

end.
