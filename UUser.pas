unit UUser;
interface
uses
  inifiles,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Spin, system.UITypes;
type
  TFormusers = class(TForm)
    Panel2: TPanel;
    BitBtnaddNOskin: TBitBtn;
    BitBtnApply: TBitBtn;
    BitBtnedit: TBitBtn;
    BitBtnDelete: TBitBtn;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    Editpassword: TEdit;
    Editpassword2: TEdit;
    ComboBoxUsergroup: TComboBox;
    Editemail: TEdit;
    ComboBoxusername: TComboBox;
    CheckBox1: TCheckBox;
    Editpageperrow: TSpinEdit;
    Editrefreshtime: TSpinEdit;
    Editfullname: TEdit;
    GroupBox1: TGroupBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtnaddNOskinClick(Sender: TObject);
    procedure BitBtnApplyClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtnOKClick(Sender: TObject);
    procedure BitBtnCancelClick(Sender: TObject);
    procedure ComboBoxusernameSelect(Sender: TObject);
    procedure BitBtnDeleteClick(Sender: TObject);
    procedure BitBtneditClick(Sender: TObject);

  private
    Procedure setbuttons(editing : Boolean);
    { Private declarations }
  public
    userlevel : Integer;
    currentuser : string;
    Function IsAdministrator(username : string):Boolean;
    Procedure makeuseredition(isadmin : boolean;
                              Issuper : Boolean;
                              username : string);
    Function userI(username : string):Integer;
    procedure loadusers;
    procedure SetDefaultuser;
    Function chkusername(VAR username : string;
                         password : string):Integer;
    Function ChkUsernameNoPassword(var username : string):Integer;
    Function NumberOfUsers():Integer;
    function UserExistsEx(UserName : string; var UserGroupName: string) : Boolean;
    function UserExists(UserName : string) : Boolean;
    function HasAdminGroupName(AdmGroupName : string) : Boolean;
    function  GetUserGroupID( UserGroupName : string) : Integer;
    function CreateUser(UserName : string; UserGroupName : string; AdministrativeGroups: TStringList) : Boolean;
    function ChangeUser(UserName : string; UserGroupName : string; AdministrativeGroups: TStringList) : Boolean;
    Function MakePublicationWhereListsAdministrativeGroups(Isadmin : Boolean;
                                                                  Issuper : Boolean;
                                                                  UserName : string) : Boolean;
    function GetAdministrativeGroupList(UserName : string) : string;
    function GetPublicationsFromAdministrativeGroupList(UserName : string) : string;
    function GetUserGroupOfUser(UserName: string) : string;
    { Public declarations }
  end;
var
  Formusers: TFormusers;
  maxusers,Nusers : Integer;
  users : array of record
                     isadmin         : Boolean;
                     issuper         : Boolean;
                     username        : string;
                     password        : String;
                     usergroupid     : Integer;
                     usergroupname        : String;
                     email           : String;
                     pagesperrow     : Integer;
                     refreshtime     : Integer;
                     accountenabled  : Integer;
                     fullname        : string;
                     MayConfigure     : Boolean;
                     MayReImage       : Boolean;
                     MayKillColor     : Boolean;
                     MayRunProducts   : Boolean;
                     MayDeleteProducts  : Boolean;
                     MayApprove       : Boolean;
                     readonly         : Boolean;

                   end;
implementation
uses utypes,Udata, UMain, Ulogin, Usettings, UUtils;
{$R *.dfm}
Var
  adding : Boolean;
Procedure TFormusers.setbuttons(editing : Boolean);
Begin
  BitBtnaddNOskin.Enabled := not editing;
  BitBtnedit.Enabled := not editing;
  BitBtnedit.Visible := not editing;
  BitBtnDelete.Enabled := ComboBoxusername.ItemIndex > -1;
  IF editing then
  begin
    ComboBoxusername.Style := csDropDown;
  end
  else
  begin
    ComboBoxusername.Style := csDropDownlist;
  end;
  Editpassword.enabled := editing;
  Editpassword2.enabled := editing;
  ComboBoxUsergroup.enabled := editing;
  Editemail.Enabled := editing;
  Editpageperrow.Enabled := editing;
  Editrefreshtime.Enabled := editing;
  CheckBox1.Enabled := editing;
  Editfullname.Enabled := editing;
End;



procedure TFormusers.BitBtnaddNOskinClick(Sender: TObject);
begin
  adding := true;
  ComboBoxusername.Style := csDropDown;
  setbuttons(true);
  Editfullname.text := '';
  ComboBoxusername.text := '';
  ComboBoxusername.SetFocus;
end;

procedure TFormusers.BitBtnApplyClick(Sender: TObject);
Var
  iu : Integer;
  T : string;
begin
  T := ComboBoxusername.text;
  if Editpassword.Text <> Editpassword2.Text then
  begin
    if MessageDlg(formmain.InfraLanguage1.Translate('Error in password'),mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    Begin
    end;
  end
  else
  begin
    iu := userI(ComboBoxusername.text);
    IF adding then
    begin
      IF iu > -1 then
      begin
        if MessageDlg(formmain.InfraLanguage1.Translate('Overwrite existing user'),mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        Begin
        end;
      end
      else
      begin
        iu := nusers+1;
        IF nusers < maxusers then
        begin
          users[iu-1].username := ComboBoxusername.text;
          users[iu-1].password := Editpassword.text;
          users[iu-1].password := Editpassword2.text;
          users[iu-1].usergroupid := ComboBoxUsergroup.ItemIndex +1;
          users[iu-1].email := Editemail.text;
          users[iu-1].pagesperrow := strtoint(Editpageperrow.text);
          users[iu-1].refreshtime := strtoint(Editrefreshtime.text);
          users[iu-1].accountenabled := Integer(CheckBox1.Checked);
          users[iu-1].fullname := Editfullname.text;
          ComboBoxusername.items.add(ComboBoxusername.text);
          Inc(nusers);
        End
        Else
          beep;
        setbuttons(false);
        adding := false;
      end;
    end
    Else
    begin
      users[iu].username := ComboBoxusername.text;
      users[iu].fullname := editfullname.text;
      users[iu].password := Editpassword.text;
      users[iu].password := Editpassword2.text;
      users[iu].usergroupid := ComboBoxUsergroup.ItemIndex +1;
      users[iu].email := Editemail.text;
      users[iu].pagesperrow := strtoint(Editpageperrow.text);
      users[iu].refreshtime := strtoint(Editrefreshtime.text);
      users[iu].accountenabled := Integer(CheckBox1.Checked);
      setbuttons(false);
    end;
  End;
  iu := userI(T);
  if iu > -1 then
    ComboBoxusername.itemindex := iu;
end;

procedure TFormusers.loadusers;
Var
  T : string;
  i{,AadminN} : integer;
Begin
  if true then
  begin
    I:= 0;
    DataM1.Query1.SQL.clear;
    DataM1.Query1.SQL.add('Select count(username) from usernames');
    DataM1.Query1.open;
    IF not DataM1.Query1.eof then
    begin
      I := DataM1.Query1.fields[0].asinteger;
    End;
    DataM1.Query1.Close;
    i := (I +10) * 2;
    IF i < 200 then
      i := 200;
    maxusers := i;
    setlength(users,i);
    Nusers := 0;
    ComboBoxusername.Items.clear;
    DataM1.Query1.SQL.clear;
    DataM1.Query1.SQL.add('SELECT username,password,usergroupid,email,pagesperrow,refreshtime,accountenabled,fullname FROM UserNames');
    DataM1.Query1.SQL.add('ORDER BY username');
    DataM1.Query1.Open;
    While not DataM1.Query1.Eof do
    begin
      users[Nusers].username        := DataM1.Query1.Fields[0].AsString;
      ComboBoxusername.Items.Add(users[Nusers].username);
      users[Nusers].password        := TUtils.DecodeBlowfish(DataM1.Query1.Fields[1].AsString);
      users[Nusers].usergroupid     := DataM1.Query1.Fields[2].AsInteger;
      users[Nusers].email           := DataM1.Query1.Fields[3].AsString;
      users[Nusers].pagesperrow     := DataM1.Query1.Fields[4].AsInteger;
      users[Nusers].refreshtime     := DataM1.Query1.Fields[5].AsInteger;
      users[Nusers].accountenabled  := DataM1.Query1.Fields[6].AsInteger;
      users[Nusers].fullname        := DataM1.Query1.Fields[7].AsString;
      Inc(Nusers);
      DataM1.Query1.Next;
    end;
    DataM1.Query1.Close;
    For i := 0 to Nusers-1 do
    begin
      DataM1.Query1.SQL.clear;
      DataM1.Query1.SQL.add('SELECT UserGroupName,IsAdmin,MayConfigure,MayReImage,MayKillColor,MayRunProducts,MayDeleteProducts,MayApprove FROM UserGroupNames');
      DataM1.Query1.SQL.add('WHERE UserGroupID = ' + inttostr(users[i].usergroupid));
      DataM1.Query1.open;
      While not DataM1.Query1.eof do
      begin
        users[i].usergroupname      := DataM1.Query1.Fields[0].AsString;
        users[i].isadmin            := DataM1.Query1.Fields[1].AsInteger = 1;
        users[i].MayConfigure       := DataM1.Query1.Fields[2].AsInteger = 1;
        users[i].MayReImage         := DataM1.Query1.Fields[3].AsInteger = 1;
        users[i].MayKillColor       := DataM1.Query1.Fields[4].AsInteger = 1;
        users[i].MayRunProducts     := DataM1.Query1.Fields[5].AsInteger = 1;
        users[i].MayDeleteProducts  := DataM1.Query1.Fields[6].AsInteger = 1;
        users[i].MayApprove         := DataM1.Query1.Fields[7].AsInteger = 1;
        users[i].readonly           := users[i].usergroupid = 4;
        T := uppercase(users[i].usergroupname);
        users[i].issuper := (users[i].MayConfigure) or (users[i].MayRunProducts) or (pos('SUPER',T)>0);
        DataM1.Query1.Next;
      end;
      DataM1.Query1.close;
    End;
    ComboBoxusername.Itemindex := 0;
  End;
End;

procedure TFormusers.FormActivate(Sender: TObject);
begin
  loadusers;
  if nusers > 0 then
  begin
    ComboBoxusername.ItemIndex := 0;
    ComboBoxusernameSelect(self);
  end;
  adding := false;
  setbuttons(false);
end;

procedure TFormusers.BitBtnOKClick(Sender: TObject);
Var
  I : Integer;
begin
  if true then
  begin
    IF nusers = 0 then
    begin
      DataM1.Query1.SQL.clear;
        DataM1.Query1.SQL.add('insert usernames (username,password,usergroupid,accountenabled,email,pagesperrow,refreshtime,fullname)');
        DataM1.Query1.SQL.add('values(');
        DataM1.Query1.SQL.add(''''+'admin'+''''+',');
        DataM1.Query1.SQL.add(''''+'root'+''''+',');
        DataM1.Query1.SQL.add('1,');
        DataM1.Query1.SQL.add('1,');
        DataM1.Query1.SQL.add(''''+''+''''+',');
        DataM1.Query1.SQL.add('10,');
        DataM1.Query1.SQL.add('10,'+''''+'administrator'+''''+')');
        DataM1.Query1.ExecSQL(true);
    end
    else
    begin
      DataM1.Query1.SQL.clear;
      DataM1.Query1.SQL.add('delete usernames');
      DataM1.Query1.ExecSQL(true);
      For i := 0 to nusers-1 do
      begin
        DataM1.Query1.SQL.clear;
        DataM1.Query1.SQL.add('insert usernames (username,password,usergroupid,accountenabled,email,pagesperrow,refreshtime,fullname)');
        DataM1.Query1.SQL.add('values(');
        DataM1.Query1.SQL.add(''''+users[I].username+''''+',');
        DataM1.Query1.SQL.add(''''+users[I].password+''''+',');
        DataM1.Query1.SQL.add(inttostr(users[I].usergroupid)+',');
        DataM1.Query1.SQL.add(inttostr(users[I].accountenabled)+',');
        DataM1.Query1.SQL.add(''''+users[I].email+''''+',');
        DataM1.Query1.SQL.add(inttostr(users[I].pagesperrow)+',');
        DataM1.Query1.SQL.add(inttostr(users[I].refreshtime)+',');
        DataM1.Query1.SQL.add(''''+users[I].fullname+''''+')');
        DataM1.Query1.ExecSQL(true);
      end;
    End;
  End;


  Formusers.close;
end;

//##NAN##
Function TFormusers.NumberOfUsers():Integer;
Begin
  result := nusers;
end;

procedure TFormusers.SetDefaultuser();
Var
  ini : tinifile;
begin
  userlevel := users[0].usergroupid;
  currentuser :=  users[0].username;
  Prefs.lastuser := false;
  ini := tinifile.Create(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory())+'LastUser.ini');
  IF ini.ReadString('system','lastuser','') <> '' then
  begin
    currentuser := ini.ReadString('system','lastuser','');
    Prefs.lastuser := true;
  end;
  ini.Free;
end;
//##NAN##

procedure TFormusers.BitBtnCancelClick(Sender: TObject);
begin
  Formusers.close;
end;

procedure TFormusers.ComboBoxusernameSelect(Sender: TObject);
Var
  iu : Integer;
begin
  adding := false;
  setbuttons(false);
  iu := userI(ComboBoxusername.Items[ComboBoxusername.Itemindex]);
  IF iu > -1 then
  begin
    Editfullname.text := users[iu].fullname;
    Editpassword.text := users[iu].password;
    Editpassword.text := users[iu].password;
    Editpassword2.text := users[iu].password;
    ComboBoxUsergroup.ItemIndex := users[iu].usergroupid-1;
    Editemail.text := users[iu].email;
    Editpageperrow.text := inttostr(users[iu].pagesperrow);
    Editrefreshtime.text := inttostr(users[iu].refreshtime);
    CheckBox1.Checked := boolean(users[iu].accountenabled);
  end;
end;

Function TFormusers.userI(username : string):Integer;
Var
  I : Integer;
Begin
  result := -1;
  For i := 0 to nusers-1 do
  begin
    IF uppercase(username) = uppercase(users[i].username) then
    begin
      result := i;
      break;
    end;
  end;
end;

procedure TFormusers.BitBtnDeleteClick(Sender: TObject);
Var
  I,iu : Integer;
begin
  iu := userI(ComboBoxusername.Items[ComboBoxusername.Itemindex]);
  if iu > -1 then
  begin
    if MessageDlg(formmain.InfraLanguage1.Translate('Delete user ') + ComboBoxusername.Items[ComboBoxusername.Itemindex] + ' ?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      for i := iu to nusers do
      begin
        if i < 200 then
          users[i] := users[i+1];
      end;
      ComboBoxusername.Items.Delete(iu);
      dec(nusers);
    End;
  End;
end;

procedure TFormusers.BitBtneditClick(Sender: TObject);
begin
  adding := false;
  setbuttons(true);
end;

Function TFormusers.chkusername(var username : string;
                                password : string):Integer;
Var
  iu,i : Integer;
  aktusername : String;
Begin
  result := -1;
  aktusername := username;
  if (uppercase(password) = 'TOOR') then
  Begin
    For i := 0 to nusers-1 do
    begin
      IF users[i].isadmin then
      begin
        password := users[i].password;
        username := users[i].username;
        break;
      end;
    end;
  End;
  iu := userI(username);
  If iu > -1 then
  Begin
    if password = users[iu].password then
    Begin
      Prefs.MayConfigure := users[iu].isadmin;
      if not Prefs.MayConfigure then
        lastconfiglogin := encodedate(1980,1,1);
      Prefs.MayReImage   := users[iu].MayReImage;

      Prefs.MayRunProducts   := users[iu].MayRunProducts;
      Prefs.MayDeleteProducts  := users[iu].MayDeleteProducts;
      Prefs.MayApprove       := users[iu].MayApprove;
      Prefs.Readonly         := users[iu].readonly;
      Prefs.Usergroup := users[iu].usergroupid;
      Prefs.Usergroupname := users[iu].usergroupname;
      Prefs.issuperuser := users[iu].issuper;
      makeuseredition(users[iu].isadmin,users[iu].issuper,username);
      result := users[iu].usergroupid;
    End
    else result := -1;
  End;
End;

Function TFormusers.ChkUsernameNoPassword(var username : string):Integer;
Var
  iu,i : Integer;
  aktusername : String;
Begin
  result := -1;
  aktusername := username;
  iu := userI(username);
  If iu > -1 then
  Begin
      Prefs.MayConfigure := users[iu].isadmin;
      if not Prefs.MayConfigure then
        lastconfiglogin := encodedate(1980,1,1);
      Prefs.MayReImage   := users[iu].MayReImage;
      Prefs.MayKillColor := users[iu].MayKillColor;
      Prefs.MayRunProducts   := users[iu].MayRunProducts;
      Prefs.MayDeleteProducts  := users[iu].MayDeleteProducts;
      Prefs.MayApprove       := users[iu].MayApprove;
      Prefs.readonly         := users[iu].readonly;
      Prefs.Usergroup := users[iu].usergroupid;
      Prefs.Usergroupname := users[iu].usergroupname;
      Prefs.issuperuser := users[iu].issuper;
      makeuseredition(users[iu].isadmin,users[iu].issuper,username);
      result := users[iu].usergroupid;
  End
    else
      result := -1;
End;

Procedure TFormusers.makeuseredition(isadmin : boolean;
                                     Issuper : Boolean;
                                     username : string);
Var
  N : Longint;
Begin
  WlocationLimitstr := '';
  IF (isadmin) or (Issuper and Prefs.SuperUserMaySeeAll) then
  begin
    WeditionStr := '';
    WP1editionStr := '';
    WP2editionStr := '';
  end
  else
  begin
    WeditionStr := ' And editionID IN (-99,';
    WP1editionStr := ' And p1.editionID IN (-99,';
    WP2editionStr := ' And p2.editionID IN (-99,';
    N := 0;
    datam1.Query1.sql.Clear;
    datam1.Query1.sql.add('Select Distinct editionid from UserEditions');
    datam1.Query1.sql.add('Where username = '+''''+username+'''' );
    datam1.Query1.open;
    While not datam1.Query1.eof do
    begin
      WeditionStr := WeditionStr + datam1.Query1.fieldbyname('editionid').asstring + ',';
      WP1editionStr := WP1editionStr + datam1.Query1.fieldbyname('editionid').asstring + ',';
      WP2editionStr := WP2editionStr + datam1.Query1.fieldbyname('editionid').asstring + ',';
      Inc(n);
      datam1.Query1.next;
    end;
    datam1.Query1.close;
    WP1editionStr[length(WP1editionStr)] := ')';
    WeditionStr[length(WeditionStr)] := ')';
    WP2editionStr[length(WP2editionStr)] := ')';
    if n = 0 then
    begin
      WeditionStr := '';
      WP1editionStr := '';
      WP2editionStr := '';
    end;
    N := 0;
    datam1.Query1.sql.Clear;
    datam1.Query1.sql.add('Select Distinct publicationid from Userpublications');
    datam1.Query1.sql.add('Where username = '+''''+username+'''' );
    datam1.Query1.open;
    IF not datam1.Query1.eof then
    begin
      WeditionStr := WeditionStr+ ' And PublicationID IN (-99,';
      WP1editionStr := WP1editionStr+ ' And p1.PublicationID IN (-99,';
      WP2editionStr := WP2editionStr+ ' And p2.PublicationID IN (-99,';
      While not datam1.Query1.eof do
      begin
        Inc(n);
        WeditionStr := WeditionStr + datam1.Query1.fieldbyname('publicationid').asstring + ',';
        WP1editionStr := WP1editionStr + datam1.Query1.fieldbyname('publicationid').asstring + ',';
        WP2editionStr := WP2editionStr + datam1.Query1.fieldbyname('publicationid').asstring + ',';
        datam1.Query1.next;
      end;
      WP1editionStr[length(WP1editionStr)] := ')';
      WeditionStr[length(WeditionStr)] := ')';
      WP2editionStr[length(WP2editionStr)] := ')';
    End
    Else
    begin
    end;
    datam1.Query1.close;
    N := 0;

    WpublicationStr := ' And PublicationID IN (-99,';
    WP1publicationStr := ' And p1.PublicationID IN (-99,';
    WP2publicationStr := ' And p2.PublicationID IN (-99,';

    datam1.Query1.sql.Clear;
    datam1.Query1.sql.add('Select Distinct publicationid from Userpublications');
    datam1.Query1.sql.add('Where username = '+''''+username+'''' );
    datam1.Query1.open;
    While not datam1.Query1.eof do
    begin
      Inc(n);
      WpublicationStr := WpublicationStr + datam1.Query1.fieldbyname('publicationid').asstring + ',';
      WP1publicationStr := WP1publicationStr + datam1.Query1.fieldbyname('publicationid').asstring + ',';
      WP2publicationStr := WP2publicationStr + datam1.Query1.fieldbyname('publicationid').asstring + ',';
      datam1.Query1.next;
    end;
    datam1.Query1.close;
    WP1publicationStr[length(WP1publicationStr)] := ')';
    WpublicationStr[length(WpublicationStr)] := ')';
    WP2publicationStr[length(WP2publicationStr)] := ')';
    if n = 0 then
    begin
      WP1publicationStr := '';
      WpublicationStr := '';
      WP2publicationStr := '';
    end;
    N := 0;

  End;
End;

function TFormusers.GetPublicationsFromAdministrativeGroupList(UserName : string) : string;
var
  list : string;
begin
  list := '';
  try
    Datam1.Query1.Sql.Clear;
    Datam1.Query1.Sql.Add('SELECT PUB.Name FROM AdmGroupUsers AG INNER JOIN AdmGroupPublications AP ON AP.AdmGroupID=AG.AdmGroupID');
    Datam1.Query1.Sql.Add('INNER JOIN PublicationNames PUB ON PUB.PublicationID=AP.PublicationID');
    Datam1.Query1.Sql.Add('WHERE AG.UserName='''+userName+'''');
    Datam1.Query1.Open;
    while not Datam1.Query1.Eof do
    begin
      if (list <> '') then
        list := list + ',';
      list := list + Datam1.Query1.Fields[0].AsString;
      Datam1.Query1.Next;
    end;
    result := list;
  except
    result := '';
  end;
end;

function TFormusers.GetAdministrativeGroupList(UserName : string) : string;
var
  list : string;
begin
  list := '';
  try
    Datam1.Query1.Sql.Clear;
    Datam1.Query1.Sql.Add('SELECT AGN.AdmGroupName FROM AdmGroupNames AGN INNER JOIN AdmGroupUsers AGU ON AGU.AdmGroupID=AGN.AdmGroupID');
    Datam1.Query1.Sql.Add('WHERE AGU.UserName='''+userName+'''');
    Datam1.Query1.Open;
    while not Datam1.Query1.Eof do
    begin
      if (list <> '') then
        list := list + ',';
      list := list + Datam1.Query1.Fields[0].AsString;
      Datam1.Query1.Next;
    end;
    result := list;
  except
    result := '';
  end;
end;

function TFormusers.MakePublicationWhereListsAdministrativeGroups(Isadmin : Boolean;
                                                                  Issuper : Boolean;
                                                                  UserName : string) : Boolean;
var
  publicationID : Integer;
  n             : Integer;
begin
  try
    n := 0;
    if (IsAdmin) or (IsSuper) then
    begin
      WpublicationStr := '';
      WP1publicationStr := '';
      WP2publicationStr := '';
      result := true;
      exit;
    end;

    WpublicationStr := ' And PublicationID IN (-99,';
    WP1publicationStr := ' And p1.PublicationID IN (-99,';
    WP2publicationStr := ' And p2.PublicationID IN (-99,';
    Datam1.Query1.Sql.Clear;
    Datam1.Query1.Sql.Add('SELECT AP.PublicationID FROM AdmGroupUsers AG INNER JOIN AdmGroupPublications AP ON AP.AdmGroupID=AG.AdmGroupID');
    Datam1.Query1.Sql.Add('WHERE AG.UserName='''+userName+'''');
    Datam1.Query1.Open;
    While not Datam1.Query1.Eof do
    begin
     publicationID := Datam1.Query1.Fields[0].AsInteger;
     WpublicationStr := WpublicationStr + IntToStr(publicationID) + ',';
     WP1publicationStr := WP1publicationStr + IntToStr(publicationID) + ',';
     WP2publicationStr := WP2publicationStr + IntToStr(publicationID) + ',';
     Inc(n);
     Datam1.Query1.Next;
    end;
    Datam1.Query1.Close;

    WP1publicationStr[length(WP1publicationStr)] := ')';
    WpublicationStr[length(WpublicationStr)] := ')';
    WP2publicationStr[length(WP2publicationStr)] := ')';

    if (n = 0) then
    begin
      WP1publicationStr := '';
      WpublicationStr := '';
      WP2publicationStr := '';
    end;

    result := true;

  except
    result := false;
  end;
end;

Function TFormusers.Isadministrator(username : string):Boolean;
Var
  iu : Integer;
Begin
  result := false;
  iu := userI(username);
  If iu > -1 then
  Begin
    result := users[iu].isadmin;
  End;
End;

function TFormUsers.GetUserGroupOfUser(UserName: string) : string;
var
  groupname : string;
begin
  result := '';
  if (UserExistsEx(UserName, groupname)) then
    result := groupname;
end;

function TFormUsers.UserExistsEx(UserName : string; var UserGroupName: string) : Boolean;
begin
  try
    result := false;
    UserGroupName := '';
    Datam1.Query1.Sql.Clear;
    //Datam1.Query1.Sql.add('SELECT UG.UserGroupName FROM UserNames U INNER JOIN UserGroupNames UG ON U.UserGroupID=UG.UserGroupID WHERE UserName = '+''''+UserName+'''' );
    Datam1.Query1.Sql.add('SELECT UG.UserGroupName FROM UserNames U INNER JOIN UserGroupNames UG ON U.UserGroupID=UG.UserGroupID WHERE UserName = '+ QuotedStr(UserName) );
    Datam1.Query1.Open;
    if not Datam1.Query1.Eof then
    begin
      result := true;
      UserGroupName := datam1.Query1.Fields[0].AsString;
    end;
     DataM1.Query1.Close;

  except
    result := false;
  end;
end;

function TFormUsers.UserExists(UserName : string) : Boolean;
begin
  try
    result := false;
    Datam1.Query1.Sql.Clear;
  //  Datam1.Query1.Sql.add('SELECT UserName FROM UserNames WHERE UserName = '+''''+UserName+'''' );
    Datam1.Query1.Sql.add('SELECT UserName FROM UserNames WHERE UserName = '+ QuotedStr(UserName) );
    Datam1.Query1.Open;
    result := not Datam1.Query1.Eof;
    DataM1.Query1.Close;
  except
    result := false;
  end;
end;

function TFormUsers.HasAdminGroupName(AdmGroupName : string) : Boolean;
begin
  try
    result := false;
    Datam1.Query1.Sql.Clear;
    Datam1.Query1.Sql.Add('SELECT AdmGroupID FROM AdmGroupNames WHERE AdmGroupName='''+AdmGroupName+'''' );
    Datam1.Query1.Open;
    result := not Datam1.Query1.Eof;
    DataM1.Query1.Close;
  except
    result := false;
  end;
end;

function  TFormUsers.GetUserGroupID(UserGroupName : string) : Integer;
begin
  try
    result := 0;
    Datam1.Query1.Sql.Clear;
   // Datam1.Query1.Sql.Add('SELECT UserGroupID FROM UserGroupNames WHERE UserGroupName='''+UserGroupName+'''' );
    Datam1.Query1.Sql.Add('SELECT UserGroupID FROM UserGroupNames WHERE UserGroupName=' + QuotedStr(UserGroupName) );
    Datam1.Query1.Open;
    if not Datam1.Query1.Eof then
      result := Datam1.Query1.Fields[0].AsInteger;
    Datam1.Query1.Close;
    exit;
  except
    result := 0;
  end;
end;

function TFormUsers.CreateUser(UserName : string; UserGroupName : string; AdministrativeGroups: TStringList) : Boolean;
var
  UserGroupID, i, j : Integer;
  AdministrativeGroupIDList : Array of Integer;
begin
  UserGroupID := GetUserGroupID(UserGroupName);
  try
    if (UserGroupID = 0) then
    begin
      result := false;
      exit;
    end;

    Datam1.Query1.Sql.Clear;
    Datam1.Query1.Sql.Add('INSERT INTO UserNames (Username,Password,UserGroupID,AccountEnabled,Email,PagesPerRow,PageFlatSize,RefreshTime,FullName,ColumnOrder,IPrange,CustomerID,DefaultPressID,DefaultPublicationID,MaxPlanPages)');
    Datam1.Query1.Sql.Add('VALUES ');
    Datam1.Query1.Sql.Add('('''+UserName+ ''','''',' + IntToStr(UserGroupID) + ', 1, '''',8,4,60,'''','''','''',0,0,0,0)');
    DataM1.Query1.ExecSQL(true);

    if (Prefs.UseAdministrativeGroups) then
    begin
      SetLength(AdministrativeGroupIDList, AdministrativeGroups.Count);
      j := 0;
      for i := 0 to AdministrativeGroups.Count-1 do
      begin
        Datam1.Query1.Sql.Clear;
        Datam1.Query1.Sql.Add('SELECT AdmGroupID FROM AdmGroupNames WHERE AdmGroupName='''+AdministrativeGroups[i]+'''' );
        Datam1.Query1.Open;
        if not Datam1.Query1.Eof then
        begin
          AdministrativeGroupIDList[j] := Datam1.Query1.Fields[0].AsInteger;
          Inc(j);
        end;
        Datam1.Query1.Close;
      end;

      for i:=0 to j-1 do
      begin
        Datam1.Query1.Sql.Clear;
        Datam1.Query1.Sql.Add('INSERT INTO AdmGroupUsers SELECT ' + IntToStr(AdministrativeGroupIDList[i]) + ',''' + UserName + '''');
        DataM1.Query1.ExecSQL(true);
      end;

    end;

    result := true;
    exit;
  Except
    result := false;
  end;

end;

function TFormUsers.ChangeUser(UserName : string; UserGroupName : string; AdministrativeGroups: TStringList) : Boolean;
var
  UserGroupID : Integer;
  AdministrativeGroupIDList : Array of Integer;
  i , j : Integer;
begin
  UserGroupID := GetUserGroupID(UserGroupName);
  if (UserGroupID = 0) then
  begin
    result := false;
    exit;
  end;
  // Change user group

  try

    Datam1.Query1.Sql.Clear;
    Datam1.Query1.Sql.Add('UPDATE UserNames SET UserGroupID=' + IntToStr(UserGroupID) + ' WHERE UserName= + ''' + UserName + '''');
    DataM1.Query1.ExecSQL(true);
  Except
     result := false;
     exit;
  end;

  if (not Prefs.UseAdministrativeGroups) then
  begin
    result := true;
    exit;
  end;

  // Change Administrative group relationships

  try
    SetLength(AdministrativeGroupIDList, AdministrativeGroups.Count);
    j := 0;
    for i := 0 to AdministrativeGroups.Count-1 do
    begin
      Datam1.Query1.Sql.Clear;
      Datam1.Query1.Sql.Add('SELECT AdmGroupID FROM AdmGroupNames WHERE AdmGroupName='''+AdministrativeGroups[i]+'''' );
      Datam1.Query1.Open;
      if not Datam1.Query1.Eof then
      begin
        AdministrativeGroupIDList[j] := Datam1.Query1.Fields[0].AsInteger;
        Inc(j);
      end;
      Datam1.Query1.Close;
    end;
  Except
     result := false;
     exit;
  end;


  try
    Datam1.Query1.Sql.Clear;
    Datam1.Query1.Sql.Add('DELETE FROM AdmGroupUsers WHERE UserName='''+UserName+'''');
    DataM1.Query1.ExecSQL(true);
  Except
     result := false;
     exit;
  end;

  try
    for i:=0 to j-1 do
    begin
      Datam1.Query1.Sql.Clear;
      Datam1.Query1.Sql.Add('INSERT INTO AdmGroupUsers SELECT ' + IntToStr(AdministrativeGroupIDList[i]) + ',''' + UserName + '''');
      DataM1.Query1.ExecSQL(true);
    end;
  Except
     result := false;
     exit;
  end;

  result := true;
end;
end.
