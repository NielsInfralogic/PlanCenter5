unit Uincludeinlog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, Buttons, ExtCtrls;

type
  TFormincludetolog = class(TForm)
    Panelb: TPanel;
    Image2: TImage;
    Label2: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    CheckListBoxalllog: TCheckListBox;
    CheckListBox1: TCheckListBox;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
    firstact : Boolean;
  public
    { Public declarations }
  end;

var
  Formincludetolog: TFormincludetolog;

implementation

uses Usettings;

{$R *.dfm}

procedure TFormincludetolog.FormCreate(Sender: TObject);
begin
  firstact := true;
end;

procedure TFormincludetolog.FormActivate(Sender: TObject);
Var
  I : Longint;
begin
  if firstact then
  begin
    firstact := false;
    For i := 0 to CheckListBoxalllog.Items.Count-1 do
    begin
      CheckListBoxalllog.checked[i] := formsettings.CheckListBoxalllog.checked[i];

    end;

  end;
  For i := 0 to CheckListBoxalllog.Items.Count-1 do
  begin
    CheckListBox1.checked[i] := CheckListBoxalllog.checked[i];
  end;

end;

procedure TFormincludetolog.BitBtn2Click(Sender: TObject);
Var
  I : Integer;
begin
  For i := 0 to CheckListBoxalllog.Items.Count-1 do
  begin
    CheckListBoxalllog.checked[i] := CheckListBox1.checked[i];
  end;
  close;
end;

end.
