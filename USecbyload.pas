unit USecbyload;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFormChangesectionnamebyload = class(TForm)
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
  FormChangesectionnamebyload: TFormChangesectionnamebyload;

implementation
Uses
  umain;

{$R *.dfm}

procedure TFormChangesectionnamebyload.FormActivate(Sender: TObject);
begin
  Formmain.loadids('FormChangesectionnamebyload', false);
  listbox1.Items.Clear;

  listbox1.Items := tnames1.sectionnames;
  listbox1.Itemindex := 0;
end;

end.
