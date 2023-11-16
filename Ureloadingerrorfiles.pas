unit Ureloadingerrorfiles;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

type
  TFormreloadingerrorfiles = class(TForm)
    Panel3: TPanel;
    Image3: TImage;
    Label8: TLabel;
    Label10: TLabel;
    BitBtn2: TBitBtn;
    Panel1: TPanel;
    Animate1: TAnimate;
    procedure BitBtn2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    stopit : Boolean;
  end;

var
  Formreloadingerrorfiles: TFormreloadingerrorfiles;

implementation

{$R *.dfm}

procedure TFormreloadingerrorfiles.BitBtn2Click(Sender: TObject);
begin
  stopit := true;
end;

procedure TFormreloadingerrorfiles.Button1Click(Sender: TObject);
begin
  Animate1.Active := not Animate1.Active;
end;

end.
