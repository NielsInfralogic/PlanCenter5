unit Ueditcreep;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFormCreep = class(TForm)
    Panel3: TPanel;
    Label8: TLabel;
    Label10: TLabel;
    Image3: TImage;
    GroupBox5: TGroupBox;
    Editcreep: TEdit;
    Label2: TLabel;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    EditCreepOffset: TEdit;
    RadioGroupCreepMode: TRadioGroup;
    procedure FormActivate(Sender: TObject);
    procedure EditcreepKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCreep: TFormCreep;

implementation

{$R *.dfm}
Uses
  umain;
procedure TFormCreep.FormActivate(Sender: TObject);
begin
  Editcreep.text := '0,0';
  EditCreepOffset.Text := '0,0';
end;


procedure TFormCreep.EditcreepKeyPress(Sender: TObject; var Key: Char);
Begin
  IF Not (Key in ['0','1','2','3','4','5','6','7','8','9',',','-',#8]) then
  begin
    key := #0;
  end;
end;  
end.
