unit UADlogin;

interface

uses
  Windows, Classes, SysUtils, Vcl.Forms;

type

  TADlogin = class(TComponent)
    public
      function GetCurrentUserGroupList(domain: string): string;
      function GetCurrentUser(): string;
      function GetCurrentDomain(CurrentUser: string): string;
      function GetCurrentUserSimple(): string;
      function GetCurrentDomainSimple() : string;
  end;



implementation

uses
  System.Types, Winapi.ShellAPI,UUtils;


function TADlogin.GetCurrentUser(): string;
const
  cnMaxUserNameLen = 1024;
var
  dwUserNameLen : DWORD;
  userName        : array[0..cnMaxUserNameLen] of char;
begin
  dwUserNameLen := cnMaxUserNameLen-1;
  GetUserName(userName, dwUserNameLen);
  Result := StrPas(userName);
end;

function TADlogin.GetCurrentDomainSimple() : string;
begin
     result:=GetEnvironmentVariable('USERDOMAIN');
end;

function TADlogin.GetCurrentUserSimple() : string;
begin
     result:=GetEnvironmentVariable('USERNAME');
end;



function TADlogin.GetCurrentDomain(CurrentUser: string): string;
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

     if LookupAccountName(nil, PChar(CurrentUser), sid, sidSize,
              domainName, domainNameSize, sidNameUse) then
         Result := StrPas(domainName);
  finally
    FreeMem(sid);
  end;

end;

///////////////////////////////////////////////
///  GET AD GROUPS OF CRRENTLY LOGGED IN USER
///////////////////////////////////////////////

function TADlogin.GetCurrentUserGroupList(domain: string): string;
var
  StartInfo  : TStartupInfo;
  ProcInfo   : TProcessInformation;
  cmd        : string;
  outputfile : string;
  CreateOK   : boolean;
  txtFile    : TextFile;
  resultText : string;
  logStr : string;
  nowtime : TDateTime;
  InitlogStrs : TStrings;
  buffer: TByteDynArray;
  l : Integer;
  shi: TShellExecuteInfo;
begin
  nowtime := Now;
  result := '';
  InitlogStrs := TStringList.Create;
  try
    FillChar(StartInfo, SizeOf(TStartupInfo),#0);
    FillChar(ProcInfo, SizeOf(TProcessInformation),#0);
    StartInfo.cb := SizeOf(TStartupInfo);
    StartInfo.dwFlags := STARTF_USESHOWWINDOW;
    StartInfo.wShowWindow := SW_HIDE;

    outputfile := TUtils.GetTempDirectory() +'LoggedInGroupsResult.txt';
    cmd := '"' + ExtractFilePath(Application.ExeName) + 'LoggedInGroups.exe" ' + domain + ' "' + outputfile + '"';      // OK!

    InitlogStrs.Add(logstr);
    InitlogStrs.SaveToFile(TUtils.GetTempDirectory()+'\winlogon.log');

    //Copy to writable buffer (including null terminator)
    l := (Length(cmd)+1)*sizeof(Char);
    SetLength(buffer, l);
    Move(cmd[1], buffer[0], l);

    DeleteFile(outputfile);
    CreateOK := CreateProcess(PChar(nil),
                              @buffer[0], //PChar(WideString(cmd)),
                              nil,
                              nil,
                              false,
                              CREATE_NEW_PROCESS_GROUP+NORMAL_PRIORITY_CLASS,
                              nil,
                              PChar(nil),
                              StartInfo,
                              {var}ProcInfo);


    if not CreateOK then
    begin
      CloseHandle(ProcInfo.hProcess);
      CloseHandle(ProcInfo.hThread);
      InitlogStrs.Add('CreateProcess failed');
      InitlogStrs.SaveToFile(TUtils.GetTempDirectory()+'\winlogon.log');
      exit;
    end;

    WaitForSingleObject(ProcInfo.hProcess, INFINITE);
    CloseHandle(ProcInfo.hProcess);
    CloseHandle(ProcInfo.hThread);


    resultText := '';
    if FileExists(outputfile) then
    begin
      AssignFile(txtFile, outputfile);
      Reset(txtFile);
      if not Eof(txtFile) then
        ReadLn(txtFile, resultText);
      CloseFile(txtFile);
    end;
    InitlogStrs.Add('Result : ' + resultText);
    InitlogStrs.SaveToFile(TUtils.GetTempDirectory()+'\winlogon.log');

    StringReplace(resultText,'#13#10','', [rfReplaceAll, rfIgnoreCase]);

    result :=  resultText;
  Except
    InitlogStrs.Add('Exception calling CreateProcess');
    InitlogStrs.SaveToFile(TUtils.GetTempDirectory()+'\winlogon.log');
  end;

end;

end.
