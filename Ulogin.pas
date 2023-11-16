unit Ulogin;

interface

uses
  inifiles,Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, system.UITypes;

type
  TFormlogin = class(TForm)
    EditUsername: TEdit;
    Label1: TLabel;
    EditPassword: TEdit;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel1: TPanel;
    Image1: TImage;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure EditPasswordKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
   // loggedout : boolean;
    //LoggedIN         : Boolean;
    //Loginerror : Boolean;
   // username : string;
   // UsernameOnStatusbar : String;
  //  lastuser : boolean;
   // Usergroup : longint;
   // Usergroupname : string;
    //MayConfigure     : Boolean;
   // MayReImage       : Boolean;
   // MayKillColor     : Boolean;
   // MayRunProducts   : Boolean;
   // MayDeleteProducts  : Boolean;
   // MayApprove       : Boolean;
   // readonly         : Boolean;
    //ISadministrator : Boolean;
//    issuperuser     : Boolean;
    { Public declarations }
  end;

var
  Formlogin: TFormlogin;
  closeisok : Boolean;
implementation

uses UUser, utypes,udata, Umain, UUtils;

{$R *.dfm}

procedure TFormlogin.BitBtn1Click(Sender: TObject);
Var
  Ausername : String;
begin
  closeisok := false;
  Ausername := EditUsername.Text;
  Prefs.UsernameOnStatusbar := EditUsername.Text;
  Formusers.userlevel := Formusers.chkusername(Ausername,EditPassword.Text);
  if Formusers.userlevel < 0 then
  begin
    Prefs.LoggedIN := false;
    MessageDlg(formmain.InfraLanguage1.Translate('Wrong user or password'), mtInformation,[mbOk], 0);
  end
  else
  begin
    Prefs.username := Ausername;
    Prefs.LoggedIN := true;
    closeisok := true;
    ModalResult := mrok;
    Close;
  end;
end;

procedure TFormlogin.FormActivate(Sender: TObject);
Var
  ini : tinifile;
begin
  Prefs.LoggedIN := false;
  IF not Prefs.LoggedOut then
  begin
    ini := tinifile.Create(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory())+'LastUser.ini');

    IF ini.ReadString('system','lastuser','') <> '' then
    begin
      EditUsername.text := ini.ReadString('system','lastuser','');
      EditPassword.SetFocus;
      Prefs.lastuser := true;
    end;
  End
  Else
  Begin
    Prefs.lastuser := false;
    EditUsername.text := '';
  End;
  Prefs.Username := '';
  closeisok := false;
  EditPassword.SetFocus;
end;

procedure TFormlogin.BitBtn2Click(Sender: TObject);
begin
  Prefs.LoggedIN := false;
  Prefs.LoginError := true;
end;

procedure TFormlogin.EditPasswordKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_RETURN then
  Begin
    key := 0;
    BitBtn1Click(self);
  End;
end;

procedure TFormlogin.FormCreate(Sender: TObject);
begin
  Prefs.LoginError := false;
  Prefs.LoggedOut := false;
  Prefs.LoggedIN := false;
  FormStyle := fsStayOnTop;
end;

end.
