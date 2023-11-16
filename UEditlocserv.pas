unit UEditlocserv;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, CheckLst;

type
  TFormlocserv = class(TForm)
    Label1: TLabel;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Editserv: TEdit;
    Label2: TLabel;
    Edituser: TEdit;
    Label3: TLabel;
    Edituserpassword: TEdit;
    Label4: TLabel;
    EditDB: TEdit;
    Label5: TLabel;
    EditDSN: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Formlocserv: TFormlocserv;

implementation

{$R *.dfm}

end.
