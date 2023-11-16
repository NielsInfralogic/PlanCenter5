unit Unewpubl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TFormnewpublA = class(TForm)
    Editnewname: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Editinput: TEdit;
    Label2: TLabel;
    Editoutput: TEdit;
    Label3: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure EditnewnameChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormnewpublA: TFormnewpublA;

implementation
                   
{$R *.dfm}

procedure TFormnewpublA.FormActivate(Sender: TObject);
begin
  Editnewname.Text := '';
  Editinput.Text := '';
  Editoutput.Text := '';

  BitBtn1.Enabled := false;
end;

procedure TFormnewpublA.EditnewnameChange(Sender: TObject);
begin
  BitBtn1.Enabled :=  Editnewname.Text <> '';
end;

end.
