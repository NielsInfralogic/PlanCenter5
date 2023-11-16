unit UCroptiff;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, jpeg;

type
  TFormcroptif = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    RadioGroup1: TRadioGroup;
    Editw: TEdit;
    Edith: TEdit;
    Editx: TEdit;
    Edity: TEdit;
    CheckBoxkeepW: TCheckBox;
    CheckBoxkeepH: TCheckBox;
    Panel3: TPanel;
    Image2: TImage;
    Label7: TLabel;
    Label8: TLabel;
    CheckBoxchpath: TCheckBox;
    procedure EditxKeyPress(Sender: TObject; var Key: Char);
    procedure EdityKeyPress(Sender: TObject; var Key: Char);
    procedure EditwKeyPress(Sender: TObject; var Key: Char);
    procedure EdithKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    Function Chktext(T : String):Boolean;
    Function Chkchr(T : char):Boolean;
  public
    { Public declarations }
  end;

var
  Formcroptif: TFormcroptif;

implementation

{$R *.dfm}


Function TFormcroptif.Chktext(T : String):Boolean;
Var
  i : Longint;
Begin
  result := true;
  For i := 1 to length(T) do
  begin
    IF Not (T[i] in ['0','1','2','3','4','5','6','7','8','9','.']) then
    begin
      result := false;
      break;
    end;

  end;
end;

Function TFormcroptif.Chkchr(T : char):Boolean;
Var
  i : Longint;
Begin
  result := true;
  IF Not (T in ['0','1','2','3','4','5','6','7','8','9',',',#8]) then
  begin
    result := false;
  end;
end;


procedure TFormcroptif.EditxKeyPress(Sender: TObject; var Key: Char);
begin
  IF Not Chkchr(key) then
    key := #0;
end;

procedure TFormcroptif.EdityKeyPress(Sender: TObject; var Key: Char);
begin
  IF Not Chkchr(key) then
    key := #0;

end;

procedure TFormcroptif.EditwKeyPress(Sender: TObject; var Key: Char);
begin
  IF Not Chkchr(key) then
    key := #0;

end;

procedure TFormcroptif.EdithKeyPress(Sender: TObject; var Key: Char);
begin
  IF Not Chkchr(key) then
    key := #0;
end;

end.
