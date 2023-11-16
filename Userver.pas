unit Userver;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, PBExListview, Buttons, system.UITypes,
  DB, SqlExpr;

type
  TFormServer = class(TForm)
    PBExListviewservers: TPBExListview;
    Panel1: TPanel;
    BitBtnaddNOskin: TBitBtn;
    BitBtnApply: TBitBtn;
    BitBtnedit: TBitBtn;
    BitBtnDelete: TBitBtn;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edituser: TEdit;
    Editpassword: TEdit;
    Editpassw2: TEdit;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    EditDBuser: TEdit;
    EditDBpassword: TEdit;
    EditDBpassw2: TEdit;
    Buttonlogon: TButton;
    Button1: TButton;
    Label1: TLabel;
    EditServer: TEdit;
    Label8: TLabel;
    EditInstance: TEdit;
    CRSQLConnectiontest: TSQLConnection;
    Editdatabase: TEdit;
    Label9: TLabel;
    procedure ButtonlogonClick(Sender: TObject);
    procedure BitBtnaddNOskinClick(Sender: TObject);
    procedure PBExListviewserversSelectItem(Sender: TObject;
      Item: TListItem; Selected: Boolean);
    procedure BitBtneditClick(Sender: TObject);
    procedure BitBtnApplyClick(Sender: TObject);
    procedure BitBtnDeleteClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure PBExListviewserversClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    function Remove_UNC_Level(var UNCPath:string):boolean;
    Function passstr(password : string):string;
  public
    Procedure fixinstance(var servername : string;
                          var instance   : string);

    Function getserver(servername : String;
                       Var username   : string;
                       Var password   : String;
                       Var instance   : string;
                       Var database   : string;
                       Var DBUsername : string;
                       Var DBPassword : string):boolean;
    function Logout(Path:String):Cardinal;
    function dbtest(servername : string;
                    instance   : string;
                    database   : string;
                    username   : string;
                    password   : string):boolean;
    Procedure loadservers;
    Procedure saveservers;
    function Logon(Path,Usr,Pwd:String):boolean;
    function IsLocalPath(const Path:string):boolean;
    Function logondb(Var CRSQLConnection : TSQLConnection;
                     servername : string;
                     instance   : string;
                     database   : string;
                     username   : string;
                     password   : string):boolean;
    { Public declarations }
  end;

var
  FormServer: TFormServer;

  

implementation
Uses
  inifiles, Umain;
{$R *.dfm}
function TFormServer.IsLocalPath(const Path:string):boolean;
var
 i:cardinal;
begin
  i:=GetDriveType(pchar(copy(path,1,2)));
  result:=(i=DRIVE_FIXED) or
          (i=DRIVE_CDROM) or
          (i=DRIVE_RAMDISK) or
          (i=DRIVE_REMOVABLE);
end;

function TFormServer.Remove_UNC_Level(var UNCPath:string):boolean;
var
 i:integer;
begin
 i:=length(UNCPath);
 while (i>3)and(not ispathdelimiter(UNCPath,i)) do
   dec(i);
 if i>3 then
   begin
     result:=true;
     UNCPath:=copy(UNCPath,1,i-1);
   end
 else
   result:=false;
end;


function TFormServer.Logout(Path:String):Cardinal;
begin
 result:=NO_ERROR;
 path:=Includetrailingpathdelimiter(ExpandUNCFileName(Trim(path)));
 while (Remove_UNC_Level(path)) do
   WNetCancelConnection2(pchar(Path),CONNECT_UPDATE_PROFILE,true);
 WNetCancelConnection2(pchar(copy(Path,3,length(path)-2)),CONNECT_UPDATE_PROFILE,true);
end;

function TFormServer.Logon(Path,Usr,Pwd:String):boolean;

var
 NetRes:TNetResource;
 tempres:cardinal;
 T :String;
 I,n : Integer;
begin
 T := '';
 n:= 0;

 for i := 1 to length(path) do
 begin
   IF path[i] = '\' then
   begin
     Inc(N);
   end;

   IF n < 3 then
   Begin
     t := t + path[i];
   end;
 end;
 path := t;
 if islocalpath(path) then
   tempres:=NO_ERROR  //No need to logon
 else
   begin
     tempres:=NO_ERROR+1;
     path:=Includetrailingpathdelimiter(ExpandUNCFileName(Trim(path)));
     while (tempres<>NO_ERROR)and(Remove_UNC_Level(path)) do
       begin
         NetRes.dwScope:=RESOURCE_GLOBALNET;
         NetRes.dwDisplayType:=RESOURCEDISPLAYTYPE_GENERIC;
         NetRes.dwUsage:=RESOURCEUSAGE_CONNECTABLE;
         NetRes.dwType:=RESOURCETYPE_DISK;
         NetRes.lpLocalName:='';
         NetRes.lpRemoteName:=pchar(path);
         NetRes.lpProvider:='';

         tempres:=WNetAddConnection2(NetRes,pchar(PWD),pchar(USR),0);
         if (tempres=ERROR_BAD_NET_NAME)and(copy(path,1,2)<>'\\') then
           tempres:=NO_ERROR;
     end;
   end;
 result:=tempres=0;
end;



procedure TFormServer.ButtonlogonClick(Sender: TObject);
begin
  IF Logon(EditServer.Text,Edituser.Text,Editpassword.Text) then
  begin
    MessageDlg(formmain.InfraLanguage1.Translate('Succes'), mtInformation,[mbOk], 0);
  end
  else
  begin
    MessageDlg(formmain.InfraLanguage1.Translate('Unable to logon'), mtWarning,[mbOk], 0);
  end;
end;

procedure TFormServer.BitBtnaddNOskinClick(Sender: TObject);
Var
  l : Tlistitem;
begin
  if Editpassw2.Text = Editpassword.Text then
  begin
    l := PBExListviewservers.Items.Add;
    l.Caption := EditServer.Text;
    l.subitems.Add(Edituser.Text);
    l.subitems.Add(passstr(Editpassword.Text));
    l.subitems.Add(Editpassword.Text);

    l.subitems.Add(Editinstance.Text);
    l.subitems.Add(Editdatabase.Text);

    l.subitems.Add(EditDBuser.Text);
    l.subitems.Add(passstr(EditDBpassword.Text));
    l.subitems.Add(EditDBpassword.Text);

    BitBtnDelete.Enabled := false;
    BitBtnedit.Visible := true;
    BitBtnedit.Enabled := false;
  End
  else
  begin
    MessageDlg('The passwords do not match please reenter the password in botht boxes', mtInformation,[mbOk], 0);

  end;
end;

Function TFormServer.passstr(password : string):string;
Var
  I : Integer;
  T : string;
Begin
  T := '';
  for i := 1 to length(password) do
    t := t + '*';

  result := t;
end;

Procedure TFormServer.loadservers;
Var
  ini : tinifile;
  i,N : Integer;
  l : Tlistitem;
Begin
  ini := TIniFile.Create(changefileext(application.ExeName,'.ini'));
  PBExListviewservers.Items.Clear;
  N := ini.ReadInteger('Servers','NumberOf',0);
  For i := 1 to n do
  begin
    l := PBExListviewservers.Items.add;
    l.Caption := ini.ReadString('Server'+inttostr(i),'Servername','');
    l.subitems.Add(ini.ReadString('Server'+inttostr(i),'Username',''));
    l.subitems.Add(passstr(ini.ReadString('Server'+inttostr(i),'Password','')));
    l.subitems.Add(ini.ReadString('Server'+inttostr(i),'Password',''));

    l.subitems.Add(ini.ReadString('Server'+inttostr(i),'Instance',''));
    l.subitems.Add(ini.ReadString('Server'+inttostr(i),'database',''));
    l.subitems.Add(ini.ReadString('Server'+inttostr(i),'DBuser',''));
    l.subitems.Add(passstr(ini.ReadString('Server'+inttostr(i),'DBPassword','')));
    l.subitems.Add(ini.ReadString('Server'+inttostr(i),'DBPassword',''));

  end;
  ini.Free;
  BitBtnaddNOskin.Enabled := true;
  BitBtnedit.Enabled := false;
  BitBtnedit.Visible := true;
  BitBtnDelete.Enabled := false;

End;

procedure TFormServer.PBExListviewserversSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if item <> nil then
  begin
    EditServer.Text := item.Caption;
    Edituser.Text := item.subitems[0];
    Editpassword.Text := item.subitems[2];
    Editpassw2.Text := item.subitems[2];

    EditInstance.Text := item.subitems[3];
    EditDBuser.Text := item.subitems[4];
    EditDBpassword.Text := item.subitems[6];
    EditDBpassw2.Text := item.subitems[6];

    BitBtnaddNOskin.Enabled := true;
    BitBtnedit.Enabled := true;
    BitBtnedit.Visible := true;
    BitBtnDelete.Enabled := true;
  End;
end;

procedure TFormServer.BitBtneditClick(Sender: TObject);
begin
  IF PBExListviewservers.Selected <> nil then
  begin
    BitBtnedit.Visible := false;
  end;
end;

procedure TFormServer.BitBtnApplyClick(Sender: TObject);
begin
  IF PBExListviewservers.Selected <> nil then
  begin
    if Editpassw2.Text = Editpassword.Text then
    begin
      BitBtnedit.Visible := true;
      BitBtnedit.enabled := true;
      BitBtnDelete.Enabled := true;

      PBExListviewservers.Selected.Caption := EditServer.Text;
      PBExListviewservers.Selected.subitems[0] := Edituser.Text;
      PBExListviewservers.Selected.subitems[1] := passstr(Editpassword.Text);
      PBExListviewservers.Selected.subitems[2] := Editpassword.Text;

      PBExListviewservers.Selected.subitems[3] := Editinstance.Text;
      PBExListviewservers.Selected.subitems[4] := EditDBuser.Text;
      PBExListviewservers.Selected.subitems[5] := passstr(EditDBpassword.Text);
      PBExListviewservers.Selected.subitems[6] := EditDBpassword.Text;

    End
    else
      MessageDlg('The passwords do not match please reenter the password in botht boxes', mtInformation,[mbOk], 0);
  end;
end;

procedure TFormServer.BitBtnDeleteClick(Sender: TObject);
begin
  IF PBExListviewservers.Selected <> nil then
  begin
    PBExListviewservers.Selected.Delete;
    BitBtnDelete.Enabled := false;
    BitBtnedit.Visible := true;
    BitBtnedit.Enabled := false;
  End;
end;

Procedure TFormServer.saveservers;
Var
  ini : tinifile;
  I : Longint;
  
Begin
  ini := TIniFile.Create(changefileext(application.ExeName,'.ini'));

  ini.writeInteger('Servers','NumberOf',PBExListviewservers.Items.count);
  For i := 0 to PBExListviewservers.Items.count-1 do
  begin
    ini.writeString('Server'+inttostr(i+1),'Servername',PBExListviewservers.Items[i].Caption);
    ini.writeString('Server'+inttostr(i+1),'Username',PBExListviewservers.Items[i].subitems[0]);
    ini.writeString('Server'+inttostr(i+1),'Password',PBExListviewservers.Items[i].subitems[2]);

    ini.writeString('Server'+inttostr(i+1),'Database',PBExListviewservers.Items[i].subitems[4]);
    ini.writeString('Server'+inttostr(i+1),'Instance',PBExListviewservers.Items[i].subitems[3]);
    ini.writeString('Server'+inttostr(i+1),'DBUser',PBExListviewservers.Items[i].subitems[5]);
    ini.writeString('Server'+inttostr(i+1),'DBPassword',PBExListviewservers.Items[i].subitems[7]);
  end;
  ini.Free;
  BitBtnaddNOskin.Enabled := true;
  BitBtnedit.Enabled := false;
  BitBtnedit.Visible := true;
  BitBtnDelete.Enabled := false;

End;


procedure TFormServer.BitBtn1Click(Sender: TObject);
begin
  saveservers;
end;

procedure TFormServer.BitBtn2Click(Sender: TObject);
begin
  loadservers;
end;

procedure TFormServer.FormActivate(Sender: TObject);
begin
  editpassw2.Text := '';
end;

procedure TFormServer.PBExListviewserversClick(Sender: TObject);
begin
  if PBExListviewservers.Selected <> nil then
  begin
    EditServer.Text := PBExListviewservers.Selected.Caption;
    Edituser.Text := PBExListviewservers.Selected.subitems[0];
    Editpassword.Text := PBExListviewservers.Selected.subitems[2];
    Editpassw2.Text := PBExListviewservers.Selected.subitems[2];


    EditInstance.Text := PBExListviewservers.Selected.subitems[3];
    EditDBuser.Text := PBExListviewservers.Selected.subitems[4];
    EditDBpassword.Text := PBExListviewservers.Selected.subitems[6];
    EditDBpassw2.Text := PBExListviewservers.Selected.subitems[6];

    BitBtnaddNOskin.Enabled := true;
    BitBtnedit.Enabled := true;
    BitBtnedit.Visible := true;
    BitBtnDelete.Enabled := true;
  End;
end;

Function TFormServer.getserver(servername : String;
                               Var username   : string;
                               Var password   : String;
                               Var instance   : string;
                               Var database   : string;
                               Var DBUsername : string;
                               Var DBPassword : string):boolean;
Var
  l : Tlistitem;
Begin
  result := false;
  if PBExListviewservers.items.count > 0 then
  begin
    l := PBExListviewservers.FindCaption(0,servername,false,true,false);
    if l <> nil then
    begin
      username := l.SubItems[0];
      password := l.SubItems[2];

      instance := l.SubItems[3];
      database := l.SubItems[4];
      DBUsername := l.SubItems[5];
      DBPassword := l.SubItems[7];

      result := true;
    end;
  end;
end;


function TFormServer.dbtest(servername : string;
                            instance   : string;
                            database   : string;
                            username   : string;
                            password   : string):boolean;
Var
  ini : Tinifile;
  //T,t2 :String;
  //I,n : Integer;
begin

  result := false;
  try



    ini := tinifile.Create(extractfilepath(application.ExeName)+'CRSQLConnectiontest.ini');
    IF instance <> '' then
      ini.WriteString('CRSQLConnectiontest','HostName',servername + '\'+instance)
    else
      ini.WriteString('CRSQLConnectiontest','HostName',servername);
    ini.WriteString('CRSQLConnectiontest','Database',database);
    ini.WriteString('CRSQLConnectiontest','User_Name',username);
    ini.WriteString('CRSQLConnectiontest','Password',password);
    ini.WriteString('CRSQLConnectiontest','OS Authentication','False');
    ini.Free;

    CRSQLConnectiontest.LoadParamsFromIniFile(extractfilepath(application.ExeName)+'CRSQLConnectiontest.ini');
    CRSQLConnectiontest.Open;
    result := true;
    CRSQLConnectiontest.Close;
  Except
    on e : exception do
    begin
       MessageDlg(e.Message, mtInformation,[mbOk], 0);

    end;
  end;
End;

procedure TFormServer.Button1Click(Sender: TObject);
begin
  IF dbtest(EditServer.Text,editinstance.Text,Editdatabase.Text,editdbuser.Text,Editdbpassword.Text) then
  begin
    MessageDlg('Succes', mtInformation,[mbOk], 0);
  end
  else
  begin
    MessageDlg('Unable to logon', mtWarning,[mbOk], 0);
  end;
end;


Function TFormServer.logondb(Var CRSQLConnection : TSQLConnection;
                             servername : string;
                             instance   : string;
                             database   : string;
                             username   : string;
                             password   : string):boolean;
Var
  ini : Tinifile;
Begin
  result := false;
  try
    ini := tinifile.Create(extractfilepath(application.ExeName)+'CRSQLConnection.ini');
    IF instance <> '' then
      ini.WriteString(CRSQLConnection.ConnectionName,'HostName',servername  + '\'+instance )
    else
      ini.WriteString(CRSQLConnection.ConnectionName,'HostName',servername);

    ini.WriteString(CRSQLConnection.ConnectionName,'Database',database);
    ini.WriteString(CRSQLConnection.ConnectionName,'User_Name',username);
    ini.WriteString(CRSQLConnection.ConnectionName,'Password',password);
    ini.WriteString(CRSQLConnection.ConnectionName,'OS Authentication','False');
    ini.Free;

    CRSQLConnection.LoadParamsFromIniFile(extractfilepath(application.ExeName)+'CRSQLConnection.ini');
    CRSQLConnection.Open;
    result := true;

  Except
    on e : exception do
    begin
       MessageDlg(e.Message, mtInformation,[mbOk], 0);

    end;
  end;
End;


Procedure TFormServer.fixinstance(var servername : string;
                                  var instance   : string);
Var
  T,t2 :String;
  I,n : Integer;

Begin
  t2 := '';
  T := '';
  n:= 0;
  for i := 1 to length(servername) do
  begin
    IF servername[i] = '\' then
    begin
      Inc(N);
    end;
    IF n < 1 then
    Begin
      t := t + servername[i];
    end
    Else
    Begin
      if servername[i] <> '\' then
        t2 := t2 + servername[i];
    end;
  end;
  servername := t;

  instance := t2;
End;


end.
