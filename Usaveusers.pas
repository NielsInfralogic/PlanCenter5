unit Usaveusers;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, CheckLst, ExtCtrls;

type
  TFormsaveusersettings = class(TForm)
    Panela: TPanel;
    Image1: TImage;
    Label5: TLabel;
    Label12: TLabel;
    CheckListBox1: TCheckListBox;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Formsaveusersettings: TFormsaveusersettings;

implementation

uses UUser, Ulogin, Umain;

{$R *.dfm}

procedure TFormsaveusersettings.FormActivate(Sender: TObject);
Var
  I : Integer;
begin
  Formusers.loadusers;
  CheckListBox1.items.clear;
  CheckListBox1.items := Formusers.ComboBoxusername.Items;
  For i := 0 to CheckListBox1.items.Count-1 do
  begin
    CheckListBox1.Checked[i] := CheckListBox1.Items[i] = Prefs.username;
    IF uppercase(CheckListBox1.Items[i]) = 'ADMIN' then
      CheckListBox1.Checked[i] := false;
  end;
end;

procedure TFormsaveusersettings.BitBtn1Click(Sender: TObject);
Var
  aadmin : Boolean;
  I,iu : Longint;
  oktosave : Boolean;
  Nchecked : Integer;
begin
  Nchecked := 0;
  For i := 0 to CheckListBox1.items.Count-1 do
  Begin
    IF CheckListBox1.checked[i] then
    begin
      inc(Nchecked);
    End;
  End;  
  IF Nchecked = 0 then
  begin
    MessageDlg(formmain.InfraLanguage1.Translate('There are no users selected'), mtError,[mbOk], 0);
    exit;
  end;

  oktosave := true;
  aadmin := false;
  For i := 0 to CheckListBox1.items.Count-1 do
  Begin
    IF CheckListBox1.checked[i] then
    begin
      for iu := 0 to Nusers do
      begin
        if users[iu].username = CheckListBox1.items[i] then
        begin
          if users[iu].MayConfigure then
          begin
            aadmin := true;
            break;
          end;
        end;
      end;
    End;
  end;
  oktosave := true;
  IF aadmin then
  begin
    oktosave := false;
    if MessageDlg(formmain.InfraLanguage1.Translate('One or more administrators have been selected continue saving or cancel'),mtwarning, [mbYes, mbNo], 0) = mrYes then
      oktosave := true;
  End
  Else
  Begin
    IF Nchecked > 1 then
    begin
      oktosave := false;
      if MessageDlg(formmain.InfraLanguage1.Translate('Save the current settings to all the selected users'),mtinformation, [mbYes, mbNo], 0) = mrYes then
        oktosave := true;
    End;
  end;
  IF oktosave then
  begin
    For i := 0 to CheckListBox1.items.Count-1 do
    Begin
      IF CheckListBox1.checked[i] then
      begin
//        formmain.saveuserconfig(CheckListBox1.items[i]);
      End;
    End;
  end;
end;

end.
