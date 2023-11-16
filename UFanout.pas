unit UFanout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFormFanoutsetting = class(TForm)
    ListBox1: TListBox;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    pressid : Longint;
    { Public declarations }
  end;

var
  FormFanoutsetting: TFormFanoutsetting;

implementation
Uses
  udata;
{$R *.dfm}

procedure TFormFanoutsetting.FormActivate(Sender: TObject);
begin
  Listbox1.Items.Clear;
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('Select Distinct TowerName from PressTowerNames');
  DataM1.Query1.SQL.Add('where pressid = ' + inttostr(pressid));
  DataM1.Query1.SQL.Add('Order by TowerName');
  DataM1.Query1.open;
  While not DataM1.Query1.eof do
  begin
    Listbox1.Items.add(DataM1.Query1.fields[0].asstring);
    DataM1.Query1.next;
  end;
  DataM1.Query1.close;

end;

end.
