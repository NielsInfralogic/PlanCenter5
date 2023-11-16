unit UDeviceframe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ComCtrls, StdCtrls, Menus, ActnPopup,
  Vcl.PlatformDefaultStyleActnCtrls;

type
  TFrameDevice = class(TFrame)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    EditDevname: TEdit;
    Editworkload: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Editstatus: TEdit;
    ListView1: TListView;
    Label3: TLabel;
    EditEnabled: TEdit;
    PopupActionBarExedtions: TPopupActionBar;
    Priority1: TMenuItem;
    Hold1: TMenuItem;
    procedure ListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
  private
    { Private declarations }
  public
    deviceid : Longint;
    Selnum   : Longint;
    { Public declarations }
  end;

implementation

{$R *.dfm}
Uses
  umain;
procedure TFrameDevice.ListView1SelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);

begin
  actDevselected := Selnum;
end;

end.
