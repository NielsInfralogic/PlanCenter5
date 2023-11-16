unit UAutotower;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, UMain;

type
  TFormAutotower = class(TForm)
    Label1: TLabel;
    Editprefix: TEdit;
    Label2: TLabel;
    Editppostfix: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Pressname : string;
    NAutotows : Longint;

    Autotows : Array[1..100] of string;
  end;

var
  FormAutotower: TFormAutotower;

implementation

uses Usettings;

{$R *.dfm}

procedure TFormAutotower.FormActivate(Sender: TObject);
Var
  i : Integer;
begin
  NAutotows := 0;
  For i := 0 to Length(Prefs.PressTowers)-1 do
  begin
    IF uppercase(Prefs.PressTowers[i].Press) = pressname then
    begin
      Inc(NAutotows);
      Autotows[NAutotows] := Prefs.PressTowers[i].Tower;

    end;

  end;

end;

procedure TFormAutotower.BitBtn1Click(Sender: TObject);
Var
  itow : Longint;
begin
  For itow := 1 to NAutotows do
  begin
    Autotows[itow] := editprefix.text + Autotows[itow] + Editppostfix.text;
  End;
end;

end.
