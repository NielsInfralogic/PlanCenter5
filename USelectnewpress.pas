unit USelectnewpress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFormSelectnewpress = class(TForm)
    Panel2: TPanel;
    Image1: TImage;
    Labelwizardheader1: TLabel;
    Labelwizardheader2: TLabel;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn6: TBitBtn;
    ComboBoxpress: TComboBox;
    Label1: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure ComboBoxpressSelect(Sender: TObject);
  private
    { Private declarations }
  public
    Locationid : Longint;
    Newpressid : Longint;
    { Public declarations }
  end;

var
  FormSelectnewpress: TFormSelectnewpress;

implementation

uses Udata,umain;

{$R *.dfm}

procedure TFormSelectnewpress.FormActivate(Sender: TObject);
Begin
  BitBtn1.enabled := false;
  ComboBoxpress.items.clear;
  DataM1.Query2.sql.clear;
  DataM1.Query2.sql.add('Select pressname from pressnames');
  DataM1.Query2.sql.add('where locationid = '+inttostr(Locationid));
  DataM1.Query2.sql.add('order by PressName');

  DataM1.Query2.open;
  While not DataM1.Query2.eof do
  begin
    ComboBoxpress.items.add(DataM1.Query2.Fields[0].AsString);
    DataM1.Query2.next;
  end;
  DataM1.Query2.close;

  IF ComboBoxpress.items.count > 0 then
  begin
    ComboBoxpress.itemindex := 0;
    Newpressid := tnames1.pressnametoid(ComboBoxpress.text);
    BitBtn1.enabled := true;
  End;
end;
procedure TFormSelectnewpress.ComboBoxpressSelect(Sender: TObject);
begin
  Newpressid := tnames1.pressnametoid(ComboBoxpress.text);
end;

end.
