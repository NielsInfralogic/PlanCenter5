unit Uloadpressconf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFormloadpressconf = class(TForm)
    Panel2: TPanel;
    Image1: TImage;
    Labelwizardheader1: TLabel;
    Labelwizardheader2: TLabel;
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ListBox1: TListBox;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    EditionID : Longint;
    PressID : Longint;
    SectionID : Longint;
    Numberofpages : Longint;

    aktpressconfid : Longint;

  end;

var
  Formloadpressconf: TFormloadpressconf;

implementation

{$R *.dfm}
Uses
  umain,udata;
procedure TFormloadpressconf.FormActivate(Sender: TObject);
begin
  aktpressconfid := -1;
  ListBox1.Items.Clear;

  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.add('Select Name from PressConfignames');
  DataM1.Query1.SQL.add('order by name');
  DataM1.Query1.open;
  While not DataM1.Query1.eof do
  begin
    ListBox1.Items.add(DataM1.Query1.fields[0].asstring);
    DataM1.Query1.next;
  end;
  DataM1.Query1.close;
  ListBox1.Itemindex := 0;
end;

procedure TFormloadpressconf.BitBtn1Click(Sender: TObject);
begin
  IF ListBox1.Itemindex > -1 then
  begin
    try
      DataM1.Query1.SQL.Clear;
      DataM1.Query1.SQL.add('Select pressconfid from PressConfignames');
      DataM1.Query1.SQL.add('where name = '+''''+ListBox1.Items[ListBox1.Itemindex]+'''');
      DataM1.Query1.open;
      aktpressconfid := DataM1.Query1.fields[0].asinteger;
      DataM1.Query1.close;
    Except
    end;
  end;



end;

end.
