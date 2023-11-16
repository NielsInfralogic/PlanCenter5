unit Uadminlogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TFormAdminlogin = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
  private
    { Private declarations }
  public
    Function DoLogin:Boolean;

  end;

var
  FormAdminlogin: TFormAdminlogin;

implementation

uses UUser;

{$R *.dfm}

Function TFormAdminlogin.DoLogin:Boolean;
Var
  T : String;

Begin
  result := false;
  IF FormAdminlogin.ShowModal = mrok then
  begin
    T := Edit1.Text;
    IF Formusers.chkusername(T,Edit2.text) > -1 then
      result := true;

  end
  Else
    result := false;

End;

end.
