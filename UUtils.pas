﻿unit UUtils;

interface

uses
  Winapi.Windows, System.SysUtils, Winapi.SHFolder,
  System.DateUtils,  System.Types, Winapi.ShellAPI, System.Classes, System.StrUtils,
  Vcl.Forms;

type

  TUtils = class

  public
    class constructor Create; // Not used yet

    class function DateOfDateTime(adate : TDateTime):TDateTime;
    class function DateOfWeek(Year : Longint; Week : Longint; DayOfWeek : Longint): TDateTime; static;

    class function GetThisComputerName(): string; static;
    class procedure DisableProcessWindowsGhosting(); static;
    class function GetMajorVersion(): string; static;
    class function GetVersion(var programminorversion: Integer): string; static;
    class function GetAppName(Doc: string): string; static;
    class function ShowPDFFile(PDFFileName : string; ExternalPDFEditorPath: string ) : Boolean; static;
    class procedure ExecNewProcess(ProgramName : String; ProgramParameter : string); static;
    class function  LeadingZeroes(const aNumber, Length : integer) : string; static;

    class function CreateStatusWindow(const Text: string; mainHandle: Cardinal): HWND;
    class procedure RemoveStatusWindow(StatusWindow: HWND);
    class function GetLocalDateSeparator(): string;
    class function GetTempDirectory(): string;
    class function GetUserAppDirectory(): string;
    class function GetCommonAppDirectory(): string;
    class function GetPlanCenterIniFilePath(iniFileTitle : string) : string;
    class procedure MirrorIniToUserFolder(iniFileName : string);
    class procedure MirrorIniToUserFolderIfNewer(iniFileName : string);
    class function StringToPAnsiChar(stringVar : string) : PAnsiChar;
    class function CsvToFixedSpaced(csv : string): string;
    class function GetFileLastWriteTime(iniFileName : string; var fileTime: TDateTime ) : Boolean;
    class function GenerateTimeStamp():string;
    class function HighDPIScale(const X: Integer): Integer;
    class function IntArrayToStringList(narr : array of Integer):string;
    class function DecodeBlowfish(inputString : string):string;
    class function EncodeBlowfish(inputString : string):string;

    class function CheckstrTal(Astr: String): Boolean;
    class function GetFileLastAccessTime(sFileName : string; filetimetype : Integer) : TDateTime;
    class function IsInStringArray(s : string; list :  array of string) : boolean;
    class function WeekToDate(Uge, Ar: Word): Tdate;
    class procedure SplitString(Delimiter: char; Str: string; ListOfStrings: TStringList);
    // class function NetDirectoryExists(const dirname: String; timeoutMSecs: Dword ): Boolean;
    // procedure TNetDirThread.Execute : override;
end;
TTestResult = (trNoDirectory, trDirectoryExists, trTimeout );
TNetDirThread = class(TThread);
implementation

uses
  Vcl.Dialogs, UImages,  UTypes, ULoadDLLs;

class constructor TUtils.Create;
begin
  // some init..
end;

class function TUtils.HighDPIScale(const X: Integer): Integer;
begin
  Result := MulDiv(X, Screen.PixelsPerInch, FormImage.PixelsPerInch);
end;

class function TUtils.StringToPAnsiChar(stringVar : string) : PAnsiChar;
Var
  AnsString : AnsiString;
  InternalError : Boolean;
begin
  InternalError := false;
  Result := '';
  try
    if stringVar <> '' Then
    begin
       AnsString := AnsiString(StringVar);
       Result := PAnsiChar(PAnsiString(AnsString));
    end;
  Except
    InternalError := true;
  end;
  if InternalError or (String(Result) <> stringVar) then
  begin
    Result := '';
//    Raise Exception.Create('Conversion from string to PAnsiChar failed!');
  end;
end;

// Copy ini-file to common users folder if not already there
class procedure TUtils.MirrorIniToUserFolderIfNewer(iniFileName : string);
var
  appFolderIniFile : string;
  installFolderIniFile : string;
  age1,age2 : TDateTime;
  age1ok, age2ok : boolean;
begin
  appFolderIniFile := IncludeTrailingBackSlash(GetCommonAppDirectory()) + iniFileName;
  installFolderIniFile := ExtractFilePath(Application.ExeName) + iniFileName;
  if (not FileExists(appFolderIniFile)) then
  begin
    try
      CopyFile(PChar(installFolderIniFile), PChar(appFolderIniFile), false);
    finally
    end;
    exit;
  end
(*  else // check if ini-file in install folder is newer
  begin
   // age1ok := FileAge(installFolderIniFile, age1);
   // age2ok := FileAge(appFolderIniFile, age2);
    age1ok := GetFileLastWriteTime(installFolderIniFile, age1);
    age2ok := GetFileLastWriteTime(appFolderIniFile, age2);
    if (age1ok) and (age2ok) then
    begin
      if (CompareDateTime (age1 ,age2) > 0) then    // age1 newer than age2
      begin
      try
          CopyFile(PChar(installFolderIniFile), PChar( appFolderIniFile),false);
        finally
        end;
      end;
    end;
  end;  *)
end;

class function TUtils.GetFileLastWriteTime(iniFileName : string; var fileTime: TDateTime ) : Boolean;
var
  attributes : TWin32FileAttributeData;
  SystemTime, LocalTime: TSystemTime;
begin
  result := false;
  if (not GetFileAttributesEx(PChar(iniFileName), GetFileExInfoStandard, @attributes)) then
    exit;

  if (not FileTimeToSystemTime(attributes.ftLastWriteTime, SystemTime)) then
    exit;

  if (not SystemTimeToTzSpecificLocalTime(nil, SystemTime, LocalTime)) then
    exit;

  fileTime := EncodeDateTime(LocalTime.wYear, LocalTime.wMonth, LocalTime.wDay, LocalTime.wHour,
                          LocalTime.wMinute, LocalTime.wSecond, LocalTime.wMilliseconds);

end;

// Copy ini-file to common users folder if not already there
class procedure TUtils.MirrorIniToUserFolder(iniFileName : string);
var
  appFolderIniFile : string;
  installFolderIniFile : string;
begin
  appFolderIniFile := IncludeTrailingBackSlash(GetCommonAppDirectory()) + iniFileName;
  installFolderIniFile := ExtractFilePath(Application.ExeName) + iniFileName;
  if (not FileExists(appFolderIniFile)) then
  begin
    try
      CopyFile(PChar(installFolderIniFile), PChar( appFolderIniFile),false);
    finally
    end;
  end;
end;


class function TUtils.GetPlanCenterIniFilePath(iniFileTitle : string) : string;
var
  appFolderIniFile : string;
  installFolderIniFile : string;
begin
  appFolderIniFile := IncludeTrailingBackSlash(GetCommonAppDirectory()) + iniFileTitle;
  installFolderIniFile := ExtractFilePath(Application.ExeName) + iniFileTitle;
  if (FileExists(appFolderIniFile)) then
    Result := appFolderIniFile
  else
  begin
    if FileExists(installFolderIniFile) then
    begin

       MirrorIniToUserFolder(iniFileTitle);
      if (FileExists(appFolderIniFile)) then
        Result := appFolderIniFile
      else
        Result :=  installFolderIniFile;
    end;

  end;

end;

// Get common app config folder. Falls back to user app folder in case of error
class function TUtils.GetCommonAppDirectory(): string;
var
  appFolder: array[0..MAX_PATH] of Char;
  appFolderstr : string;
begin


  // if SHGetFolderPath(0, CSIDL_COMMON_APPDATA, 0, SHGFP_TYPE_CURRENT, appFolder) = S_OK then
   if SHGetFolderPath(0, CSIDL_COMMON_DOCUMENTS, 0, SHGFP_TYPE_CURRENT, appFolder) = S_OK then
  begin

    appFolderstr := IncludeTrailingBackSlash(appFolder) + 'PlanCenter';
    Result := appFolderstr;
    if (not DirectoryExists(appFolderstr)) then
    begin
      try
        CreateDir( appFolderstr);
      except
        Result := GetUserAppDirectory();
      end;
    end;
  end
  else
    Result := GetUserAppDirectory();
end;

class function TUtils.GetUserAppDirectory(): string;
var
  appFolder: array[0..MAX_PATH] of Char;
  appFolderstr : string;
begin


  if SHGetFolderPath(0, CSIDL_LOCAL_APPDATA, 0, SHGFP_TYPE_CURRENT, appFolder) = S_OK then
  begin
    appFolderstr := IncludeTrailingBackSlash(appFolder) + 'PlanCenter';
    Result := appFolderstr;
    if (not DirectoryExists(appFolderstr)) then
    begin
      try
        CreateDir( appFolderstr);
      except
        Result := '';
      end;
    end;
  end
  else
    Result := '';
end;


class function TUtils.GetTempDirectory(): string;
var
  tempFolder: array[0..MAX_PATH] of Char;
begin
  GetTempPath(MAX_PATH, @tempFolder);
  result := StrPas(tempFolder);
  if (not DirectoryExists(result)) then
    CreateDir(tempFolder);
end;

class function TUtils.DateOfDateTime(adate : TDateTime):TDateTime;
Var
  Year, Month, Day: Word;
begin
  DecodeDate(adate,Year, Month, Day);
  result := EncodeDate(Year, Month, Day);
end;

class function TUtils.DateOfWeek(Year : Longint;
                    Week : Longint;
                    DayOfWeek : Longint): TDateTime;
var
  dt : TDateTime;
  Y, M, D : Word;
begin
  try
    dt := EncodeDateWeek(Year,Week,DayOfWeek);
    DecodeDate(dt, Y, M, D);
    result := dt;
  except
    result := EncodeDate(1900,1,1);
  end;

end;

class function TUtils.GetThisComputerName: string;
var
  r :  DWORD;
  g : array[0..MAX_COMPUTERNAME_LENGTH + 1] of char;
begin
  r := MAX_COMPUTERNAME_LENGTH + 1;
  if GetComputerName(g,r) then
    result := StrPas(g)
  else
    result := '';
end;


class procedure TUtils.DisableProcessWindowsGhosting;
var
  DisableProcessWindowsGhostingProc: procedure;
begin
  DisableProcessWindowsGhostingProc := GetProcAddress(GetModuleHandle('user32.dll'),'DisableProcessWindowsGhosting');
  if Assigned(DisableProcessWindowsGhostingProc) then
    DisableProcessWindowsGhostingProc;
end;

class function TUtils.GetMajorVersion: string;
var
  VerInfoSize: DWORD;
  VerInfo: Pointer;
  VerValueSize: DWORD;
  VerValue: PVSFixedFileInfo;
  Dummy: DWORD;
begin
  Result := '';
  VerInfoSize := GetFileVersionInfoSize(Pchar(ParamStr(0)), Dummy);
  if VerInfoSize = 0 then
    Exit;
  GetMem(VerInfo, VerInfoSize);
  GetFileVersionInfo(Pchar(ParamStr(0)), 0, VerInfoSize, VerInfo);
  VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
  with VerValue^ do
  begin
    Result := IntToStr(dwFileVersionMS shr 16);
  end;
  FreeMem(VerInfo, VerInfoSize);
end;

class function TUtils.GetVersion(var programminorversion: Integer): string;
var
  VerInfoSize: DWORD;
  VerInfo: Pointer;
  VerValueSize: DWORD;
  VerValue: PVSFixedFileInfo;
  Dummy: DWORD;
begin
  Result := '';
  VerInfoSize := GetFileVersionInfoSize(Pchar(ParamStr(0)), Dummy);
  if VerInfoSize = 0 then Exit;
  GetMem(VerInfo, VerInfoSize);
  GetFileVersionInfo(Pchar(ParamStr(0)), 0, VerInfoSize, VerInfo);
  VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
  with VerValue^ do
  begin
    Result := IntToStr(dwFileVersionMS shr 16);
    programminorversion := dwFileVersionMS and $FFFF;
    Result := Result + '.' + IntToStr(programminorversion);
    Result := Result + '.' + IntToStr(dwFileVersionLS shr 16);
    Result := Result + '.' + IntToStr(dwFileVersionLS and $FFFF);
  end;
  FreeMem(VerInfo, VerInfoSize);

end;



// Bruges til at finde det program som man kan åbne en fil med f.eks acrobat til pdf.
//GetAppName('c:\test.pdf') give c:\programf...acrobat.exe
class function TUtils.GetAppName(Doc: string): string;
var
  FN, DN, RES: array[0..255] of char;
begin
  StrPCopy(FN, DOC);
  DN[0]  := #0;
  RES[0] := #0;
  FindExecutable(FN, DN, RES);
  Result := StrPas(RES);
end;

class function TUtils.ShowPDFFile(PDFFileName : string; ExternalPDFEditorPath: string ) : Boolean;
Var
  t,t2 : String;
  StartInfo  : TStartupInfo;
  ProcInfo   : TProcessInformation;
  CreateOK   : Boolean;

begin
  t := ExternalPDFEditorPath;
  if (ExternalPDFEditorPath = '') OR ((ExternalPDFEditorPath <> '') AND  (not FileExists(ExternalPDFEditorPath))) then
    t := TUtils.GetAppName(PDFFileName);

  if t = '' then
  begin
    result := false;
   // MessageDlg('PDF viewer must be selected in settings ') , mtInformation,[mbOk], 0);
    exit;
  end;

  FillChar(StartInfo,SizeOf(TStartupInfo),#0);
  FillChar(ProcInfo,SizeOf(TProcessInformation),#0);
  StartInfo.cb := SizeOf(TStartupInfo);

  //+programparameter+'"'
  t := '"'+t+'"' + ' "' +PDFFileName+'"';
  CreateOK := CreateProcess(nil,Pchar(T), nil, nil,False,
                  CREATE_NEW_PROCESS_GROUP+NORMAL_PRIORITY_CLASS,
                  nil, nil, StartInfo, ProcInfo);

      (*
      if CreateOK then
        WaitForSingleObject(ProcInfo.hProcess, INFINITE);
      *)


  (*/n Launch a separate instance of the Acrobat application, even if one is currently open.
/s Open Acrobat, suppressing the splash screen.
/o Open Acrobat, suppressing the open file dialog.
/h Open Acrobat in hidden mode.*)
  result := CreateOK;

end;


class procedure TUtils.ExecNewProcess(ProgramName      : String;
                                   programparameter : string);
var
  StartInfo  : TStartupInfo;
  ProcInfo   : TProcessInformation;
  CreateOK   : Boolean;
  T : String;
begin

  FillChar(StartInfo,SizeOf(TStartupInfo),#0);
  FillChar(ProcInfo,SizeOf(TProcessInformation),#0);
  StartInfo.cb := SizeOf(TStartupInfo);

  //+programparameter+'"'
  T := '"'+ProgramName+'"' + ' "' +programparameter+'"';

  CreateOK := CreateProcess(nil,Pchar(T), nil, nil,False,
              CREATE_NEW_PROCESS_GROUP+NORMAL_PRIORITY_CLASS,
              nil, nil, StartInfo, ProcInfo);

  if CreateOK then
    WaitForSingleObject(ProcInfo.hProcess, INFINITE);

end;


class function TUtils.LeadingZeroes(const aNumber, Length : integer) : string;
begin
  result := Format('%.*d', [Length, aNumber]) ;
end;



class function TUtils.CreateStatusWindow(const Text: string; mainHandle: Cardinal): HWND;
var
  FormWidth,
  FormHeight: integer;
begin
  FormWidth := 400;
  FormHeight := 160;
  result := CreateWindow('STATIC',
                         PChar(Text),
                         WS_OVERLAPPED or WS_POPUPWINDOW or WS_THICKFRAME or SS_CENTER or SS_CENTERIMAGE,
                         (Screen.Width - FormWidth) div 2,
                         (Screen.Height - FormHeight) div 2,
                         FormWidth,
                         FormHeight,
                         mainHandle,
                         0,
                         HInstance,
                         nil);
  ShowWindow(result, SW_SHOWNORMAL);
  UpdateWindow(result);
end;

class procedure TUtils.RemoveStatusWindow(StatusWindow: HWND);
begin
  DestroyWindow(StatusWindow);
end;

class function TUtils.GetLocalDateSeparator: string;

  function MAKELANGID(Language : Word; SubLanguage: WORD = SUBLANG_DEFAULT): WORD; inline;
  begin
    Result := WORD(SubLanguage shl 10) or Language;
  end;

var
  formatSettings : TFormatSettings;
begin
//  try
    formatSettings := TFormatSettings.Create(MAKELANGID(LANG_NEUTRAL));
    result := StringOfChar(formatSettings.DateSeparator,1);
//  finally
//    formatSettings.Free;

end;



class function TUtils.CsvToFixedSpaced(csv : string): string;
var
  arr : array of TStringList;
  lines : TStringList;
  a : TStringList;
  i,j : Integer;
  narr : array of Integer;
  sresult : string;
begin
   lines := TStringList.Create;
   lines.Text := csv;

   SetLength(arr,lines.Count);
   for i:= 0 to lines.Count-1 do
   begin
     arr[i] := TStringList.Create;
     arr[i].Text := ReplaceText(lines[i],';',#13#10);
   end;
   SetLength(narr, arr[0].Count);

   for i:= 0 to lines.Count-1 do
   begin
     for  j:= 0 to  arr[i].Count-1 do
     begin
       if (i = 0) then
         narr[j] := Length(arr[i][j])
       else
       begin
         if (Length(arr[i][j]) > narr[j]) then
           narr[j] := Length(arr[i][j]);
       end;
     end;
  end;
  sresult := '';
  for i:= 0 to lines.Count-1 do
  begin
    for  j:= 0 to  arr[i].Count-1 do
    begin
      sresult := sresult + arr[i][j] + StringOfChar ( ' ', narr[j] - Length(arr[i][j]) + 5 );
    end;
    sresult := sresult + #13#10;
  end;

  for i:= 0 to lines.Count-1 do
    arr[i].Free;
  lines.Free;

  result := sresult;
end;

class function TUtils.GenerateTimeStamp():string;
begin
  result := FormatDateTime('yyyymmddhhnnsszzz', Now);
end;

class function TUtils.IntArrayToStringList(narr : array of Integer):string;
var
  s : string;
  i : Integer;
begin
  s := '';
  for i := 0 to Length(narr) - 1 do
  begin
    if s <> '' then
      s := s + ',';
    s := s + IntToStr(narr[i]);
  end;

  result := s;
end;


class function TUtils.DecodeBlowfish(inputString : string):string;
var
  szInput: PAnsiChar;
  szOutput: PAnsiChar;
  ret : Integer;
begin

  result :=  inputString;
  szInput := AnsiStrAlloc(256);
  szOutput := AnsiStrAlloc(256);
  strpcopy(szInput, inputString);
  strpcopy(szOutput, '');


  if Addr(DecodeBlowFish2) = nil then
    exit;
  try
    ret := DecodeBlowFish2(szInput, szOutput);
    if (ret > 0) then
      result :=  StrPas(szOutput);
  finally

  end;
end;

class function TUtils.EncodeBlowfish(inputString : string):string;
var
  szInput: PAnsiChar;
  szOutput: PAnsiChar;
  ret : Integer;
begin

  result :=  inputString;
  szInput := AnsiStrAlloc(256);
  szOutput := AnsiStrAlloc(256);
  strpcopy(szInput, inputString);
  strpcopy(szOutput, '');


  if Addr(EncodeBlowFish2) = nil then
    exit;
  try
    ret := EncodeBlowFish2(szInput, szOutput);
    if (ret > 0) then
      result :=  StrPas(szOutput);
  finally

  end;
end;

class function TUtils.CheckstrTal(Astr: String): Boolean;
Var
  i: Integer;
begin
  result := true;
  if Length(Astr) > 0 then
  begin
    for i := 1 to Length(Astr) do
    begin
      if not(Astr[i] in tal) then
      begin
        result := false;
        break;
      end;
    end;
  end
  else
    result := false;
end;

class function TUtils.GetFileLastAccessTime(sFileName : string;
                                         filetimetype : Integer) : TDateTime;
var
  ffd : TWin32FindData;
  dft : DWord;
  lft : TFileTime;
  h   : THandle;
begin
  result := now;
  try
    h := FindFirstFile(PChar(sFileName), ffd);
    if(INVALID_HANDLE_VALUE <> h)then
    begin
      Winapi.Windows.FindClose( h );
      Case filetimetype of
        0 : FileTimeToLocalFileTime(ffd.ftCreationTime, lft );
        1 : FileTimeToLocalFileTime(ffd.ftLastAccessTime, lft );
        2 : FileTimeToLocalFileTime(ffd.ftLastWriteTime, lft );
        else
          FileTimeToLocalFileTime(ffd.ftLastAccessTime, lft );
      end;
      FileTimeToDosDateTime(lft,
      LongRec(dft).Hi, LongRec(dft).Lo);
      Result := FileDateToDateTime(dft);
    end;
  Except
  end;
end;

class function TUtils.IsInStringArray(s : string; list :  array of string) : boolean;
var
  i : Integer;
begin
    result := false;
    for i := 0 to Length(list) - 1 do
    begin
      if CompareText(list[i],s) = 0 then
      begin
        result := true;
        exit;
      end;
    end;

end;

class function TUtils.WeekToDate(Uge, Ar: Word): Tdate;
var
  temp1: Tdate;
  temp2: Word;
begin
  result := 1;
  if (Uge <= 0) or (Uge > WeeksInYear(Ar)) then
    exit;
  temp1 := StrToDate('01-01-' + IntToStr(Ar));
  temp2 := WeekOfTheYear(temp1);
  if temp2 = 1 then
    result := 7 * (Uge - 1) + temp1
  else
    result := 7 * Uge + temp1;
end;

class procedure TUtils.SplitString(Delimiter: char; Str: string; ListOfStrings: TStringList);
begin
   ListOfStrings.Clear;
   ListOfStrings.Delimiter       := Delimiter;
   ListOfStrings.StrictDelimiter := True; // Requires D2006 or newer.
   ListOfStrings.DelimitedText   := Str;
end;

{class procedure TUtils.SplitString(delim: char; s: string; ListOfStrings: TStrings);
var
  temp: string;
  i: integer;
begin
   temp := '';
   ListOfStrings.Clear;
   for i:=1 to length(s) do
    begin
      if s[i] = delim then
        begin
          ListOfStrings.Add(temp);
          temp := '';
        end
      else
        begin
          temp := temp + s[i];
          if i=length(s) then
             ListOfStrings.Add(temp);
        end;
    end;
    ListOfStrings.Add(temp);
end;
}
{
class function TUtils.NetDirectoryExists(
            const dirname: String; timeoutMSecs: Dword ): Boolean;
 Var
   res: TTestResult;
   thread: TNetDirThread;
 Begin
   Assert( dirname <> '', 'NetDirectoryExists: dirname cannot be empty.' );
   Assert( timeoutMSecs > 0, 'NetDirectoryExists: timeout cannot be 0.' );
   thread:= TNetDirThread.Create( true );
   try
     res:= thread.TestForDir( dirname, timeoutMSecs );
     Result := res = trDirectoryExists;
     If res <> trTimeout Then
       thread.Free;

   except
     thread.free;
     raise
   end;
 End;


 procedure TUtils.Execute;
 begin
   try
     FResult := DirectoryExists( FDirname );
   except
     On E: Exception Do Begin
       FErr := E.Message;
       FErrclass := ExceptionClass( E.Classtype );
     End;
   end;
 end;

 function TNetDirThread.TestForDir(const dirname: String;
   timeoutMSecs: Dword): TTestResult;
 begin
   FDirname := dirname;
   Resume;
   If WaitForSingleObject( Handle, timeoutMSecs ) = WAIT_TIMEOUT
   Then Begin
     Result := trTimeout;
     FreeOnTerminate := true;
   End
   Else Begin
     If Assigned( FErrclass ) Then
       raise FErrClass.Create( FErr );
     If FResult Then
       Result := trDirectoryExists
     Else
       Result := trNoDirectory;
   End;
 end;
 *}
(*
initialization
  // some
*)
end.


