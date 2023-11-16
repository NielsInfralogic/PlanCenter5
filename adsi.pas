unit adsi;

interface

uses
  SysUtils, Classes, ActiveX, Windows, ComCtrls, ExtCtrls,
   ActiveDs_TLB,
  //adshlp,
  oleserver, Variants;

type
  TPassword = record
    Expired: boolean;
    NeverExpires: boolean;
    CannotChange: boolean;
end;

type
  TADSIUserInfo = record
    UID: string;
    UserName: string;
    Description: string;
    Password: TPassword;
    Disabled: boolean;
    LockedOut: boolean;
    Groups: string; //CSV
end;

type
  TADSI = class(TComponent)

  private
    FUserName:  string;
    FPassword:  string;
    FCurrentUser: string;
    FCurrentDomain: string;

    function GetCurrentUserName: string;
    function GetCurrentDomain: string;


  protected
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property CurrentUserName: string read FCurrentUser;
    property CurrentDomain: string read FCurrentDomain;

    function GetUser(Domain, UserName: string; var ADSIUser: TADSIUserInfo): boolean;
    function Authenticate(Domain, UserName, Group: string): boolean;

  published
    property LoginUserName: string read FUserName write FUserName;
    property LoginPassword: string read FPassword write FPassword;
  end;

procedure Register;

implementation


function ADsOpenObject(lpszPathName,lpszUserName,lpszPassword : WideString; dwReserved : DWORD; const riid:TGUID; out ppObject): HResult; safecall; external 'activeds.dll';

function ContainsValComma(s1,s: string): boolean;
var
  sub,str: string;
begin
  Result:=false;
  if (s='') or (s1='') then exit;
  if SameText(s1,s) then begin
    Result:=true;
    exit;
  end;
  sub:=','+lowercase(trim(s1))+','; str:=','+lowercase(trim(s))+',';
  Result:=(pos(sub, str)>0);
end;

procedure Register;
begin
  RegisterComponents('ADSI', [TADSI]);
end;

constructor TADSI.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);

   FCurrentUser:=GetCurrentUserName;
   FCurrentDomain:=GetCurrentDomain;
   FUserName:='';
   FPassword:='';
end;

destructor TADSI.Destroy;
begin

   inherited Destroy;
end;

function TADSI.GetCurrentUserName : string;
const
  cnMaxUserNameLen = 254;
var
  sUserName     : string;
  dwUserNameLen : DWord;
begin
  dwUserNameLen := cnMaxUserNameLen-1;
  SetLength(sUserName, cnMaxUserNameLen );
  GetUserName(PChar(sUserName), dwUserNameLen );
  SetLength(sUserName, dwUserNameLen);
  Result := sUserName;
end;

function TADSI.GetCurrentDomain: string;
const
  DNLEN = 255;
var
  sid               : PSID;
  sidSize           : DWORD;
  sidNameUse        : DWORD;
  domainNameSize    : DWORD;
  domainName        : array[0..DNLEN] of char;

begin
  sidSize := 65536;
  GetMem(sid, sidSize);
  domainNameSize := DNLEN + 1;
  sidNameUse := SidTypeUser;
  try
     if LookupAccountName(nil, PChar(FCurrentUser), sid, sidSize,
        domainName, domainNameSize, sidNameUse) then
         Result:=StrPas(domainName);
  finally
    FreeMem(sid);
  end;
end;

function TADSI.Authenticate(Domain, UserName, Group: string): boolean;
var
  aUser: TADSIUserInfo;
begin
  Result:=false;
  if GetUser(Domain,UserName,aUser) then begin
     if not aUser.Disabled and not aUser.LockedOut then begin
        if Group='' then
           Result:=true
        else
           Result:=ContainsValComma(Group, aUser.Groups);
     end;
  end;
end;

function TADSI.GetUser(Domain, UserName: string; var ADSIUser: TADSIUserInfo): boolean;
var
  usr   :    IAdsUser;
  flags :    integer;
  Enum  :    IEnumVariant;
  grps  :    IAdsMembers;
  grp   :    IAdsGroup;
  varGroup : OleVariant;
  Temp :     LongWord;
  dom1, uid1: string;

  //ui: TADSIUserInfo;

begin
  ADSIUser.UID:='';
  ADSIUser.UserName:='';
  ADSIUser.Description:='';
  ADSIUser.Disabled:=true;
  ADSIUser.LockedOut:=true;
  ADSIUser.Groups:='';
  Result:=false;

  if UserName='' then
     uid1:=FCurrentUser
  else
     uid1:=UserName;

  if Domain='' then
     dom1:=FCurrentDomain
  else
     dom1:=Domain;

  if uid1='' then exit;
  if dom1='' then exit;

  try
     if trim(FUserName)<>'' then
        ADsOpenObject('WinNT://' + dom1 + '/' + uid1, FUserName, FPassword, 1, IADsUser, usr)
     else
        ADsGetObject('WinNT://' + dom1 + '/' + uid1, IADsUser, usr);

     if usr=nil then exit;

     ADSIUser.UID:= UserName;
     ADSIUser.UserName := usr.FullName;
     ADSIUser.Description := usr.Description;
     flags := usr.Get('userFlags');
     ADSIUser.Password.Expired := usr.Get('PasswordExpired');
     ADSIUser.Password.CannotChange := (flags AND ADS_UF_PASSWD_CANT_CHANGE)<>0;
     ADSIUser.Password.NeverExpires := (flags and ADS_UF_DONT_EXPIRE_PASSWD)<>0;
     ADSIUser.Disabled := usr.AccountDisabled;
     ADSIUser.LockedOut := usr.IsAccountLocked;

     ADSIUser.Groups:='';
     grps := usr.Groups;
     Enum := grps._NewEnum as IEnumVariant;
     if Enum <> nil then begin
       while (Enum.Next(1,varGroup, Temp) = S_OK) do begin
         grp := IDispatch(varGroup) as IAdsGroup;
         //sGroupType := GetGroupType(grp);
         if ADSIUser.Groups<>'' then ADSIUser.Groups:=ADSIUser.Groups+',';
         ADSIUser.Groups:=ADSIUser.Groups+grp.Name;
         VariantClear(varGroup);
       end;
     end;
     usr:=nil;
     Result:=true;
  except
     on e: exception do begin
        Result:=false;
        exit;
     end;
  end;
end;

end.
