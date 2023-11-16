unit JPGGetComment;

interface

uses Windows,
  Classes,
  SysUtils,
  FileCtrl,
  Graphics,
  Forms,
  Dialogs,
  ClipBrd;

const
  ErrCommentTooLong = 'Comment is too long (%d bytes).' + #10 + #13 +
    'A comment can be up to 65531 bytes long.';
  ErrCouldNotRestore = 'Could not restore stream. Sorry!';
  ErrFileAlreadyExists = 'File %s already exists';
  ErrFileDoesNotExist = 'File %s does not exist';
  ErrFileSizeIsNull = 'File %s is Empty';
  ErrInvalidFileAttr = 'FileAttributes (%d) of File %s are invalid';
  ErrInvalidFileType = 'FileType %s is invalid';
  ErrInvalidJPEGFile = 'File %s is not a valid JPEG file';
  ErrNoJPEGCommentFile = 'File %s does not contain a JPEG Comment';
  ErrReadingFile = 'File %s Stream Reading Error';
  ErrWritingDateToFile = 'Could not write filedate of File %s';
  ErrWritingToFile = 'Could not write into File %s';
  ErrWritingToStream = 'Could not write into stream';
  ErrUnknown = 'Unknown Error';
  ReadBufferSize = 32768;
  wdMarker: word = $FEFF;

type
  EJPEGCommentReadException = class(EReadError);
  EJPEGCommentWriteException = class(Exception);

  TJPEGCommentSetting = (tjCheckFile, tjEXIFCompatible, tjKeepFileTimes,
    tjReadOnly, tjSilent);
  TJPEGCommentSettings = set of TJPEGCommentSetting;
  TJPEGByteArray = array of byte;
  TJPEGWriteType = (wtOverride, wtRemove, wtWriteNew);

  // TPersistent
  TJPGGetComment = class(TComponent)
  private
    fEXIFOffset: LongInt;
    fEXIFLength: word;
    fFileName: string;
    fImageStream: TMemoryStream;
    fJPEGComment: TStrings;
    fJPEGCommentLength: word;
    fJPEGCommentOffset: integer;
    fJPEGCommentSettings: TJPEGCommentSettings;
    fStreamSize: integer;
    function BinBufferFirstPos(Pattern: pByte; PatternLen: integer;
      Buffer: pByte; BufferLen: integer; var MatchPos: integer;
      var MatchLen: integer): BOOLEAN;
    function FindFirstBinaryPattern(const BinaryPattern: TJPEGByteArray;
      aStream: TStream): integer;
  protected
    fBIsReadOnly: BOOLEAN;
    fFTCreationTime: TFileTime;
    fFTLastAccessTime: TFileTime;
    fFTLastWriteTime: TFileTime;
    fLastError: string;
    fWriteType: TJPEGWriteType;
    function _ChangeComment(const strComment: string): BOOLEAN;
    function _CheckFile(const FileName: string): BOOLEAN;
    function _GetComment(var aMemoryStream: TMemoryStream;
      var _CommentOffset: LongInt; var _CommentLength: word;
      var _Comment: string): integer; // OffsetTotal
    function _GetEXIFOffsetAndLength(var aMemoryStream: TMemoryStream;
      var _EXIFOffset: LongInt; var _EXIFLength: word): integer; // OffsetTotal
    function _InsertComment(var aMemoryStream: TMemoryStream;
      const aFileName: string; const _CommentOffset: LongInt;
      const _Comment: string; const bKeepFileTimes: BOOLEAN): BOOLEAN;
    function _IsPositionOK(const TheJPEGCommentOffset: LongInt): BOOLEAN;
    function _OverrideComment(var aMemoryStream: TMemoryStream;
      const aFileName: string; const _CommentOffset: LongInt;
      const _NewComment: string; const bKeepFileTimes: BOOLEAN): BOOLEAN;
    function _ReadFile(aFileName: string; var aMemoryStream: TMemoryStream;
      var aStreamSize: LongInt; var aCommentOffset: LongInt;
      var aCommentLength: word; var aCommentStrings: TStrings;
      var aEXIFOffset: LongInt; var aEXIFLength: word): BOOLEAN;
    function _RemoveComment(var aMemoryStream: TMemoryStream;
      const aFileName: string; const aCommentOffset: LongInt;
      const aCommentLength: word; const bKeepFileTimes: BOOLEAN): BOOLEAN;
    function _RemoveEXIF(var aMemoryStream: TMemoryStream;
      const aFileName: string; const aEXIFOffset: LongInt;
      const aEXIFLength: integer; const bKeepFileTimes: BOOLEAN): BOOLEAN;
    function _SetFileTimes(const aFileName: string;
      const FTCreationTime: TFileTime; const FTLastAccessTime: TFileTime;
      const FTLastWriteTime: TFileTime): BOOLEAN;
    procedure SetEXIFOffset(value: LongInt);
    procedure SetEXIFLength(value: word);
    procedure SetFileName(value: string);
    procedure SetJPEGComment(value: TStrings);
    procedure SetJPEGCommentLength(value: word);
    procedure SetJPEGCommentOffset(value: integer);
    procedure SetJPEGCommentSettings(value: TJPEGCommentSettings);
    procedure SetStreamSize(value: integer);
  public
    // constructor Create;
    constructor Create(AOwner: TComponent); override;
    constructor CreateFromFile(const FileName: string;
      const cJPEGCommentSettings: TJPEGCommentSettings);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure AssignTo(Dest: TPersistent); override;
    procedure AssignToStringList(var Strings: TStrings; const DoClear: BOOLEAN);
    procedure ClearInfo;
    procedure CommentFromClipBoard;
    procedure CommentToClipboard;
    function InsertComment: BOOLEAN;
    function OverrideComment: BOOLEAN;
    function RemoveComment: BOOLEAN;
    function RemoveEXIF: BOOLEAN;
    function ResampleComment: BOOLEAN;
    function Update: BOOLEAN;
  published
    property EXIFOffset: LongInt read fEXIFOffset write SetEXIFOffset;
    property EXIFLength: word read fEXIFLength write SetEXIFLength;
    property FileName: string read fFileName write SetFileName;
    property JPEGComment: TStrings read fJPEGComment write SetJPEGComment;
    property JPEGCommentLength: word read fJPEGCommentLength
      write SetJPEGCommentLength;
    property JPEGCommentOffset: integer read fJPEGCommentOffset
      write SetJPEGCommentOffset;
    property JPEGCommentSettings: TJPEGCommentSettings read fJPEGCommentSettings
      write SetJPEGCommentSettings;
  end;


  // Helper Functions

function FileGetJPEGCommentInfoP(const FileName: string;
  const JPEGCommentSettings: TJPEGCommentSettings): TJPGGetComment;
function FileGetJPEGCommentStrings(const FileName: string;
  const JPEGCommentSettings: TJPEGCommentSettings;
  var JPEGCommentStrings: TStrings): BOOLEAN;
function FileSetJPEGCommentStrings(const FileName: string;
  const JPEGCommentSettings: TJPEGCommentSettings;
  const JPEGCommentStrings: TStrings): BOOLEAN;

implementation

const
  JPEGCommentHeader: word = $FEFF;
  JPEGCommentMarker: array [1 .. 2] of byte = ($FF, $FE);
  JPEGEXIFHeader: word = $E1FF;
  JPEGEXIFMarker: array [1 .. 2] of byte = ($FF, $E1);

function GetNULLFileTime: TFileTime;
begin
  with result do
  begin
    dwLowDateTime := 297119744;
    dwHighDateTime := 27111886;
  end;
end;

function Word_Swap(const InWord: word): word;
begin
  result := MakeWord(HiByte(InWord), LoByte(InWord)); // 1.LOW, 2.HIGH
end;

function Word_SwapMinus2(const InWord: word): word;
begin
  result := Word_Swap(InWord) - 2; // 1.LOW, 2.HIGH
end;

function Word_SwapPlus2(const InWord: word): word;
var
  wInWord: word;
begin
  wInWord := InWord + 2;
  result := Word_Swap(wInWord); // 1.LOW, 2.HIGH
end;

// Helper Functions

function FileGetJPEGCommentInfoP(const FileName: string;
  const JPEGCommentSettings: TJPEGCommentSettings): TJPGGetComment;
begin
  result := TJPGGetComment.CreateFromFile(FileName, JPEGCommentSettings);
end;

function FileGetJPEGCommentStrings(const FileName: string;
  const JPEGCommentSettings: TJPEGCommentSettings;
  var JPEGCommentStrings: TStrings): BOOLEAN;
var
  aJPEGCommentInfo: TJPGGetComment;
begin
  result := FALSE;
  if (JPEGCommentStrings = nil) then
    JPEGCommentStrings := TStringList.Create;
  aJPEGCommentInfo := FileGetJPEGCommentInfoP(FileName, JPEGCommentSettings);
  if (aJPEGCommentInfo <> nil) then
  begin
    aJPEGCommentInfo.AssignToStringList(JPEGCommentStrings, TRUE);
    aJPEGCommentInfo.Free;
    result := TRUE;
  end;
end;

function FileSetJPEGCommentStrings(const FileName: string;
  const JPEGCommentSettings: TJPEGCommentSettings;
  const JPEGCommentStrings: TStrings): BOOLEAN;
var
  aJPEGCommentInfo: TJPGGetComment;
begin
  result := FALSE;
  if (JPEGCommentStrings = nil) then
    EXIT
  else
  begin
    aJPEGCommentInfo := FileGetJPEGCommentInfoP(FileName, JPEGCommentSettings);
    if (aJPEGCommentInfo <> nil) then
    begin
      aJPEGCommentInfo.fJPEGComment.Assign(JPEGCommentStrings);
      aJPEGCommentInfo.Free;
      result := TRUE;
    end;
  end;
end;

// Helper Functions

{ TTGJPGCommentInfoP }

function TJPGGetComment.BinBufferFirstPos(Pattern: pByte; PatternLen: integer;
  Buffer: pByte; BufferLen: integer; var MatchPos: integer;
  var MatchLen: integer): BOOLEAN;
var
  RunPattern: pByte;
  BufferIndex: integer;
  RunBuffer: pByte;
begin
  result := FALSE;
  MatchPos := 0;
  MatchLen := 0;
  RunPattern := Pattern;
  RunBuffer := Buffer;
  BufferIndex := 0;
  repeat
    Inc(MatchPos);
    if (RunPattern^ = RunBuffer^) then
    begin
      MatchLen := 0;
      repeat
        if (RunPattern^ <> RunBuffer^) then
          BREAK
        else
        begin
          Inc(RunPattern);
          Inc(RunBuffer);
          Inc(BufferIndex);
          Inc(MatchLen);
        end;
      until (MatchLen = PatternLen);
      if (MatchLen = PatternLen) then
      begin
        MatchPos := BufferIndex - PatternLen;
        result := TRUE;
        BREAK;
      end;
      if (BufferIndex + MatchLen >= BufferLen - 1) then
      begin
        MatchPos := BufferIndex - MatchLen;
        result := TRUE;
        BREAK;
      end;
    end
    else
    begin
      Inc(RunBuffer);
      Inc(BufferIndex);
    end;
    RunPattern := Pattern;
  until (BufferIndex = BufferLen - 1);
end;

function TJPGGetComment.FindFirstBinaryPattern(const BinaryPattern
  : TJPEGByteArray; aStream: TStream): integer;
var
  apBytePattern: pByte;
  BytePatternLen: integer;
  FindBuffer: pByte;
  BytesToRead: integer;
  BytesReadTotal: integer;
  bTemp: BOOLEAN;
  mPos: integer;
  mLen: integer;
  SavePos: integer;
  aStreamSize: integer;
begin
  result := -1;
  if (aStream <> nil) then
  begin
    aStreamSize := aStream.Size;
    if (aStreamSize > 0) then
    begin
      // bTemp := FALSE;
      if (aStream.Size < ReadBufferSize) then
        BytesToRead := aStreamSize
      else
        BytesToRead := ReadBufferSize;
      BytesReadTotal := 0;
      apBytePattern := @BinaryPattern[0];
      BytePatternLen := Length(BinaryPattern);
      FindBuffer := AllocMem(BytesToRead);
      try
        aStream.Seek(0, soFromBeginning);
        repeat
          aStream.Read(FindBuffer^, BytesToRead);
          BytesReadTotal := aStream.Position;
          bTemp := BinBufferFirstPos(apBytePattern, BytePatternLen, FindBuffer,
            BytesToRead, mPos, mLen);
          if (bTemp = TRUE) then
          begin
            if (mLen = BytePatternLen) then
              result := BytesReadTotal - BytesToRead + mPos
            else
            begin
              if (mLen > 0) and (BytesReadTotal + BytePatternLen <= aStreamSize)
              then
              begin
                SavePos := aStream.Position;
                aStream.Seek(SavePos - BytePatternLen, soFromBeginning);
              end
              else
                result := -1;
            end;
          end;
          FillChar(FindBuffer^, BytesToRead, 0);
          if (aStream.Position > (aStreamSize - BytePatternLen)) then
          begin
            BytesToRead := aStreamSize - aStream.Position;
          end;
        until ((BytesToRead = 0) or (result >= 0));
        aStream.Seek(0, soFromBeginning);
      finally
        apBytePattern := nil;
        if (FindBuffer <> nil) then
          FreeMem(FindBuffer);
      end; // ..of try..finally..end
    end; // ..of if (fStreamSize > 0) then
  end; // ..of if (fImageStream <> nil) then
end;

function TJPGGetComment._ChangeComment(const strComment: string): BOOLEAN;
var
  bKeepFileTimes: BOOLEAN;
  bPositionOK: BOOLEAN;
  iPosition: LongInt;
begin
  result := FALSE;
  iPosition := 0;
  if not(tjReadOnly in fJPEGCommentSettings) then
  begin
    if (tjKeepFileTimes in fJPEGCommentSettings) then
      bKeepFileTimes := TRUE
    else
      bKeepFileTimes := FALSE;
    if (tjEXIFCompatible in fJPEGCommentSettings) then
    begin
      bPositionOK := _IsPositionOK(fJPEGCommentOffset);
      case bPositionOK of
        TRUE:
          iPosition := fJPEGCommentOffset;
        FALSE:
          begin
            if (fEXIFOffset > 0) and (fEXIFLength > 0) then
              iPosition := fEXIFOffset + fEXIFLength + 4
            else
              iPosition := 2;
          end;
      end;
    end
    else
    begin
      bPositionOK := TRUE;
      if (fJPEGCommentOffset > 0) then
        iPosition := fJPEGCommentOffset
      else
        iPosition := 2;
    end;
    case fWriteType of
      wtOverride:
        begin
          if (Length(strComment) > 0) then
          begin
            case bPositionOK of
              TRUE:
                begin
                  result := _OverrideComment(fImageStream, fFileName, iPosition,
                    strComment, bKeepFileTimes);
                end;
              FALSE:
                begin
                  if (_RemoveComment(fImageStream, fFileName,
                    fJPEGCommentOffset, fJPEGCommentLength, bKeepFileTimes)
                    = TRUE) then
                    result := _InsertComment(fImageStream, fFileName, iPosition,
                      strComment, bKeepFileTimes);
                end;
            end;
          end;
        end;
      wtRemove:
        begin
          if (fJPEGCommentLength > 0) then
            result := _RemoveComment(fImageStream, fFileName,
              fJPEGCommentOffset, fJPEGCommentLength, bKeepFileTimes);
        end;
      wtWriteNew:
        begin
          if (Length(strComment) > 0) then
          begin
            result := _InsertComment(fImageStream, fFileName, iPosition,
              strComment, bKeepFileTimes);
          end;
        end;
    end;
    if (result = TRUE) then
      Update;
  end;
end;

function TJPGGetComment._CheckFile(const FileName: string): BOOLEAN;
var
  aJPEGException: EJPEGCommentReadException;
  dwError: DWORD;
  FindData: TWin32FindData;
  FindHandle: THandle;
  pcFileName: pChar;
  iStreamSize: integer;
  strError: string;
  strFileExt: string;

  function CheckDWFileAttributes(dwAttr: DWORD): BOOLEAN;
  begin
    result := FALSE;
    if ((dwAttr and FILE_ATTRIBUTE_COMPRESSED) = 0) and
      ((dwAttr and FILE_ATTRIBUTE_HIDDEN) = 0) and
      ((dwAttr and FILE_ATTRIBUTE_OFFLINE) = 0) and
      ((dwAttr and FILE_ATTRIBUTE_SYSTEM) = 0) and
      ((dwAttr and FILE_ATTRIBUTE_TEMPORARY) = 0) and
      ((dwAttr and FILE_ATTRIBUTE_DIRECTORY) = 0) then
      result := TRUE;
  end;

begin
  result := FALSE;
  dwError := 0;
  if (Length(FileName) > 0) then
  begin
    strFileExt := ExtractFileExt(FileName);
    if (CompareText(strFileExt, '.jpg') = 0) or
      (CompareText(strFileExt, '.jpeg') = 0) then
    begin
      iStreamSize := 0;
      pcFileName := StrAlloc(Length(FileName) + 1);
      StrPCopy(pcFileName, FileName);
      strError := '';
      FillChar(FindData, SizeOf(TWin32FindData), 0);
      FindHandle := INVALID_HANDLE_VALUE;
      try
        FindHandle := Windows.FindFirstFile(pcFileName, FindData);
        if (FindHandle <> INVALID_HANDLE_VALUE) then
        begin
          iStreamSize := (FindData.nFileSizeHigh * MAXDWORD) +
            FindData.nFileSizeLow;
          if (iStreamSize > 0) then
          begin
            if ((FindData.dwFileAttributes and FILE_ATTRIBUTE_HIDDEN) = 0) then
              fBIsReadOnly := FALSE
            else
              fBIsReadOnly := TRUE;
            if (CheckDWFileAttributes(FindData.dwFileAttributes) = TRUE) then
              result := TRUE
            else
              fLastError := Format(ErrInvalidFileAttr, [FileName]);
          end
          else
            fLastError := Format(ErrFileSizeIsNull, [FileName]);
          Windows.FindClose(FindHandle);
        end
        else
          fLastError := Format(ErrFileDoesNotExist, [FileName]);
        dwError := GetLastError;
        if (dwError <> 0) then
          strError := SysErrorMessage(dwError);
      finally
        StrDispose(pcFileName);
      end;
    end
    else
      fLastError := Format(ErrInvalidFileType, [FileName]);
    if not(tjSilent in fJPEGCommentSettings) then
    begin
      if (dwError <> 0) then
        fLastError := fLastError + #10#13 + strError;
      if (Length(fLastError) > 0) then
      begin
        aJPEGException := EJPEGCommentReadException.Create(fLastError);
        raise aJPEGException;
      end;
    end;
  end;
end;

function TJPGGetComment._GetComment(var aMemoryStream: TMemoryStream;
  var _CommentOffset: LongInt; var _CommentLength: word;
  var _Comment: string): integer;
var
  aJPEGException: EJPEGCommentReadException;
  lSavePosition: LongInt;
  CommentPattern: TJPEGByteArray;
  CommentTemp: string;
  CommentTempOffset: LongInt;
  CommentTempLength: word;
  wdMarker: word;
  wdSegLen: word;
  dwError: DWORD;
  strError: string;

  function GetCommentPattern: TJPEGByteArray;
  begin
    SetLength(result, 2);
    result[0] := JPEGCommentMarker[1];
    result[1] := JPEGCommentMarker[2];
  end;

begin
  result := -1;
  _CommentOffset := -1;
  _CommentLength := 0;
  SetLength(CommentPattern, 0);
  if (aMemoryStream <> nil) then
  begin
    if (aMemoryStream.Size > 0) then
    begin
      lSavePosition := aMemoryStream.Position;
      CommentTempOffset := -1;
      CommentTempLength := 0;
      CommentPattern := GetCommentPattern;
      CommentTempOffset := FindFirstBinaryPattern(CommentPattern,
        aMemoryStream);
      if (CommentTempOffset > 0) then
      begin
        dwError := 0;
        strError := '';
        wdMarker := 0;
        wdSegLen := 0;
        aMemoryStream.Seek(CommentTempOffset, soFromBeginning);
        try
          aMemoryStream.Read(wdMarker, 2);
          if (wdMarker = $FEFF) then
          begin
            aMemoryStream.Read(wdSegLen, 2);
            CommentTempLength := Word_SwapMinus2(wdSegLen);
            if (CommentTempLength > 0) then
            begin
              SetLength(CommentTemp, CommentTempLength);
              aMemoryStream.Read(CommentTemp[1], CommentTempLength);
              _CommentOffset := CommentTempOffset;
              _CommentLength := CommentTempLength;
              _Comment := CommentTemp;
              result := _CommentOffset + _CommentLength + 4;
            end;
          end;
          aMemoryStream.Seek(lSavePosition, soFromBeginning);
          dwError := GetLastError;
          if (dwError <> 0) then
            strError := SysErrorMessage(dwError);
        finally
          if (dwError <> 0) then
          begin
            fLastError := Format(ErrReadingFile, [fFileName]) + #10#13
              + strError;
            if not(tjSilent in fJPEGCommentSettings) then
            begin
              aJPEGException := EJPEGCommentReadException.Create(fLastError);
              raise aJPEGException;
            end;
          end;
        end;
      end;
    end;
  end;
end;

function TJPGGetComment._GetEXIFOffsetAndLength(var aMemoryStream
  : TMemoryStream; var _EXIFOffset: LongInt; var _EXIFLength: word): integer;
var
  aJPEGException: EJPEGCommentReadException;
  EXIFPattern: TJPEGByteArray;
  EXIFTempOffset: integer;
  EXIFTempLength: word;
  EXIFTempMarker: word;
  lSavePosition: LongInt;
  dwError: DWORD;
  strError: string;

  function GetEXIFPattern: TJPEGByteArray;
  begin
    SetLength(result, 2);
    result[0] := JPEGEXIFMarker[1];
    result[1] := JPEGEXIFMarker[2];
  end;

begin
  result := 0;
  _EXIFOffset := -1;
  _EXIFLength := 0;
  SetLength(EXIFPattern, 0);
  if (aMemoryStream <> nil) then
  begin
    if (aMemoryStream.Size > 0) then
    begin
      lSavePosition := aMemoryStream.Position;
      EXIFPattern := GetEXIFPattern;
      EXIFTempOffset := FindFirstBinaryPattern(EXIFPattern, aMemoryStream);
      if (EXIFTempOffset > 0) then
      begin
        dwError := 0;
        strError := '';
        EXIFTempLength := 0;
        aMemoryStream.Seek(0, soFromBeginning);
        try
          aMemoryStream.Seek(EXIFTempOffset, soFromBeginning);
          aMemoryStream.Read(EXIFTempMarker, 2);
          if (EXIFTempMarker = $E1FF) then
            aMemoryStream.Read(EXIFTempLength, 2);
          if (aMemoryStream.Position = EXIFTempOffset + 4) then
          begin
            _EXIFOffset := EXIFTempOffset;
            _EXIFLength := Word_SwapMinus2(EXIFTempLength);
            result := _EXIFOffset + _EXIFLength + 4;
          end;
          aMemoryStream.Seek(lSavePosition, soFromBeginning);
          dwError := GetLastError;
          if (dwError <> 0) then
            strError := SysErrorMessage(dwError);
        finally
          if (dwError <> 0) then
          begin
            fLastError := Format(ErrReadingFile, [fFileName]) + #10#13
              + strError;
            if not(tjSilent in fJPEGCommentSettings) then
            begin
              aJPEGException := EJPEGCommentReadException.Create(fLastError);
              raise aJPEGException;
            end; // ..of if not (tjSilent in fJPEGCommentSettings) then
          end; // ..of if (dwError <> 0) then
        end; // ..of try..finally..end
      end; // ..of if (EXIFTempOffset > 0) then
    end; // ..of if (aMemoryStream.Size > 0) then
  end; // ..of if (aMemoryStream <> nil) then
end;

function TJPGGetComment._InsertComment(var aMemoryStream: TMemoryStream;
  const aFileName: string; const _CommentOffset: LongInt;
  const _Comment: string; const bKeepFileTimes: BOOLEAN): BOOLEAN;
const
  wdMarker: word = $FEFF;
var
  aJPEGException: EJPEGCommentWriteException;
  aSaveStream: TMemoryStream;
  aFileStream: TFileStream;
  lCommentTotal: LongInt;
  lSavePosition: LongInt;
  lStreamSizeOld: LongInt;
  lStreamSizeNew: LongInt;
  wdSegLen: word;
  dwError: DWORD;
  strError: string;
begin
  result := FALSE;
  if (aMemoryStream <> nil) and (_CommentOffset > 1) then
  begin
    if (Length(_Comment) > 0) and (Length(_Comment) <= MAXWORD) then
    begin
      lStreamSizeOld := aMemoryStream.Size;
      lCommentTotal := Length(_Comment) + 4;
      lStreamSizeNew := lStreamSizeOld + lCommentTotal;
      wdSegLen := Word_SwapPlus2(Length(_Comment));
      if (aMemoryStream.Position < _CommentOffset) then
        lSavePosition := aMemoryStream.Position
      else
        lSavePosition := aMemoryStream.Position + lCommentTotal;
      dwError := 0;
      aSaveStream := TMemoryStream.Create;
      aSaveStream.Size := lStreamSizeNew;
      aFileStream := TFileStream.Create(aFileName, fmOpenWrite or
        fmShareDenyWrite);
      aFileStream.Seek(0, soFromBeginning);
      aMemoryStream.Seek(0, soFromBeginning);
      try
        aSaveStream.CopyFrom(aMemoryStream, _CommentOffset);
        if (aSaveStream.Position = _CommentOffset) then
        begin
          aSaveStream.Write(wdMarker, 2);
          aSaveStream.Write(wdSegLen, 2);
          aSaveStream.Write(_Comment[1], Length(_Comment));
          if (aSaveStream.Position = (_CommentOffset + lCommentTotal)) then
          begin
            aMemoryStream.Seek(_CommentOffset, soFromBeginning);
            aSaveStream.CopyFrom(aMemoryStream,
              lStreamSizeOld - _CommentOffset);
            if (aSaveStream.Position = lStreamSizeNew) then
            begin
              with aMemoryStream do
              begin
                Seek(0, soFromBeginning);
                Clear;
                CopyFrom(aSaveStream, 0);
              end; // ..of with aMemoryStream do
              if (aMemoryStream.Size = lStreamSizeNew) then
              begin
                fJPEGCommentLength := Word_SwapMinus2(Length(_Comment));
                fJPEGCommentOffset := _CommentOffset;
                fJPEGComment.Clear;
                fJPEGComment.Text := _Comment;
              end;
              aFileStream.CopyFrom(aSaveStream, 0);
              aFileStream.Free;
              if (bKeepFileTimes = TRUE) then
                result := _SetFileTimes(aFileName, fFTCreationTime,
                  fFTLastAccessTime, fFTLastWriteTime)
              else
                result := TRUE;
            end; // ..of if (SaveStream.Position = lStreamSizeNew) then
          end; // ..of if (SaveStream.Position = _CommentOffset
        end; // ..of if (SaveStream.Position = _CommentOffset) then
        aMemoryStream.Seek(lSavePosition, soFromBeginning);
        aSaveStream.Seek(0, soFromBeginning);
        dwError := GetLastError;
        if (dwError <> 0) then
          strError := SysErrorMessage(dwError);
      finally
        aSaveStream.Free;
        if (dwError <> 0) then
        begin
          fLastError := Format(ErrWritingToFile, [fFileName]) + #10#13
            + strError;
          if not(tjSilent in fJPEGCommentSettings) then
          begin
            aJPEGException := EJPEGCommentWriteException.Create(fLastError);
            raise aJPEGException;
          end; // ..of if not (tjSilent in fJPEGCommentSettings) then
        end; // ..of if (dwError <> 0) then
      end; // ..of try..finally..end
    end; // ..of if (Length(_Comment) > 0) and
  end; // ..of if (aMemoryStream <> nil) and
end;

function TJPGGetComment._IsPositionOK(const TheJPEGCommentOffset
  : LongInt): BOOLEAN;
var
  iResult: integer;
begin
  result := FALSE;
  if (fImageStream <> nil) and (fStreamSize > 0) then
  begin
    fEXIFOffset := 0;
    fEXIFLength := 0;
    iResult := _GetEXIFOffsetAndLength(fImageStream, fEXIFOffset, fEXIFLength);
    if (iResult = 0) then
    begin
      if (TheJPEGCommentOffset >= 2) then
        result := TRUE;
    end
    else
    begin
      if (TheJPEGCommentOffset < iResult) then
        result := FALSE
      else
        result := TRUE;
    end;
  end;
end;

function TJPGGetComment._OverrideComment(var aMemoryStream: TMemoryStream;
  const aFileName: string; const _CommentOffset: LongInt;
  const _NewComment: string; const bKeepFileTimes: BOOLEAN): BOOLEAN;
const
  wdMarker: word = $FEFF;
var
  aJPEGException: EJPEGCommentWriteException;
  aSaveStream: TMemoryStream;
  aFileStream: TFileStream;
  lCommentOld: LongInt;
  lCommentTotal: LongInt;
  lSavePosition: LongInt;
  lStreamSizeOld: LongInt;
  lStreamSizeNew: LongInt;
  wdSegLen: word;
  dwError: DWORD;
  strError: string;
begin
  result := FALSE;
  if (aMemoryStream <> nil) and (_CommentOffset > 1) then
  begin
    if (Length(_NewComment) > 0) and (Length(_NewComment) <= MAXWORD) then
    begin
      lCommentOld := fJPEGCommentLength + 4;
      lStreamSizeOld := aMemoryStream.Size;
      lCommentTotal := Length(_NewComment) + 4;
      lStreamSizeNew := lStreamSizeOld + Length(_NewComment) -
        fJPEGCommentLength;
      wdSegLen := Word_SwapPlus2(Length(_NewComment));
      if (aMemoryStream.Position < _CommentOffset) then
        lSavePosition := aMemoryStream.Position
      else
        lSavePosition := aMemoryStream.Position + lCommentTotal;
      dwError := 0;
      aSaveStream := TMemoryStream.Create;
      aSaveStream.Size := lStreamSizeNew;
      aFileStream := TFileStream.Create(aFileName, fmOpenWrite or
        fmShareDenyWrite);
      aFileStream.Seek(0, soFromBeginning);
      aMemoryStream.Seek(0, soFromBeginning);
      try
        aSaveStream.CopyFrom(aMemoryStream, _CommentOffset);
        if (aSaveStream.Position = _CommentOffset) then
        begin
          aSaveStream.Write(wdMarker, 2);
          aSaveStream.Write(wdSegLen, 2);
          aSaveStream.Write(_NewComment[1], Length(_NewComment));
          if (aSaveStream.Position = (_CommentOffset + lCommentTotal)) then
          begin
            aMemoryStream.Seek(_CommentOffset, soFromBeginning);
            aSaveStream.CopyFrom(aMemoryStream, lStreamSizeOld - lCommentOld -
              _CommentOffset);
            if (aSaveStream.Position = lStreamSizeNew) then
            begin
              with aMemoryStream do
              begin
                Seek(0, soFromBeginning);
                Clear;
                CopyFrom(aSaveStream, 0);
              end; // ..of with aMemoryStream do
              if (aMemoryStream.Size = lStreamSizeNew) then
              begin
                fJPEGCommentLength := Word_SwapMinus2(Length(_NewComment));
                fJPEGCommentOffset := _CommentOffset;
                fJPEGComment.Clear;
                fJPEGComment.Text := _NewComment;
              end;
              aFileStream.CopyFrom(aSaveStream, 0);
              aFileStream.Free;
              if (bKeepFileTimes = TRUE) then
                result := _SetFileTimes(aFileName, fFTCreationTime,
                  fFTLastAccessTime, fFTLastWriteTime)
              else
                result := TRUE;
            end; // ..of if (SaveStream.Position = lStreamSizeNew) then
          end; // ..of if (SaveStream.Position = _CommentOffset
        end; // ..of if (SaveStream.Position = _CommentOffset) then
        aMemoryStream.Seek(lSavePosition, soFromBeginning);
        aSaveStream.Seek(0, soFromBeginning);
        dwError := GetLastError;
        if (dwError <> 0) then
          strError := SysErrorMessage(dwError);
      finally
        aSaveStream.Free;
        if (dwError <> 0) then
        begin
          fLastError := Format(ErrWritingToFile, [fFileName]) + #10#13
            + strError;
          if not(tjSilent in fJPEGCommentSettings) then
          begin
            aJPEGException := EJPEGCommentWriteException.Create(fLastError);
            raise aJPEGException;
          end; // ..of if not (tjSilent in fJPEGCommentSettings) then
        end; // ..of if (dwError <> 0) then
      end; // ..of try..finally..end
    end; // ..of if (Length(_Comment) > 0) and
  end; // ..of if (aMemoryStream <> nil) and
end;

function TJPGGetComment._ReadFile(aFileName: string;
  var aMemoryStream: TMemoryStream; var aStreamSize: LongInt;
  var aCommentOffset: LongInt; var aCommentLength: word;
  var aCommentStrings: TStrings; var aEXIFOffset: LongInt;
  var aEXIFLength: word): BOOLEAN;
var
  strComment: string;
begin
  result := FALSE;
  aStreamSize := 0;
  aCommentOffset := -1;
  aCommentLength := 0;
  aEXIFOffset := -1;
  aEXIFLength := 0;
  if (aCommentStrings <> nil) then
    aCommentStrings.Clear;
  if (aCommentStrings = nil) then
    aCommentStrings := TStringList.Create;
  if (Length(aFileName) <> 0) and (aMemoryStream <> nil) then
  begin
    aMemoryStream.Clear;
    aMemoryStream.LoadFromFile(aFileName);
    aStreamSize := aMemoryStream.Size;
    if (aStreamSize > 0) then
    begin
      _GetEXIFOffsetAndLength(aMemoryStream, aEXIFOffset, aEXIFLength);
      if (_GetComment(aMemoryStream, aCommentOffset, aCommentLength,
        strComment) > 0) then
      begin
        aCommentStrings.Text := strComment;
        result := TRUE;
      end;
    end;
  end;
end;

function TJPGGetComment._RemoveComment(var aMemoryStream: TMemoryStream;
  const aFileName: string; const aCommentOffset: LongInt;
  const aCommentLength: word; const bKeepFileTimes: BOOLEAN): BOOLEAN;
var
  aJPEGException: EJPEGCommentWriteException;
  aFileStream: TFileStream;
  aSaveStream: TMemoryStream;
  lCommentOffset: LongInt;
  lCommentTotal: LongInt;
  lSavePosition: LongInt;
  lStreamSizeOld: LongInt;
  lStreamSizeNew: LongInt;
  dwError: DWORD;
  strError: string;
begin
  result := FALSE;
  if (aMemoryStream <> nil) and (aCommentOffset > 1) and (aCommentLength > 0)
  then
  begin
    dwError := 0;
    strError := '';
    lStreamSizeOld := aMemoryStream.Size;
    lCommentOffset := aCommentOffset;
    lCommentTotal := aCommentLength + 4;
    lStreamSizeNew := lStreamSizeOld - lCommentTotal;
    if (aMemoryStream.Position < lCommentOffset) then
      lSavePosition := aMemoryStream.Position
    else
      lSavePosition := 0;
    aMemoryStream.Seek(0, soFromBeginning);
    aSaveStream := TMemoryStream.Create;
    aFileStream := TFileStream.Create(aFileName, fmOpenWrite or
      fmShareDenyWrite);
    aFileStream.Seek(0, soFromBeginning);
    try
      aSaveStream.CopyFrom(aMemoryStream, lCommentOffset);
      aMemoryStream.Seek(lCommentOffset + lCommentTotal, soFromBeginning);
      if (aSaveStream.Position = lCommentOffset) then
        aSaveStream.CopyFrom(aMemoryStream, lStreamSizeNew - lCommentOffset);
      if (aSaveStream.Position = lStreamSizeNew) then
      begin
        aFileStream.CopyFrom(aSaveStream, 0);
        aFileStream.Free;
        aMemoryStream.Clear;
        aMemoryStream.CopyFrom(aSaveStream, 0);
        fJPEGCommentOffset := -1;
        fJPEGCommentLength := 0;
        fJPEGComment.Clear;
        if (bKeepFileTimes = TRUE) then
          result := _SetFileTimes(aFileName, fFTCreationTime, fFTLastAccessTime,
            fFTLastWriteTime)
        else
          result := TRUE;
      end;
      aMemoryStream.Seek(lSavePosition, soFromBeginning);
      dwError := GetLastError;
      if (dwError <> 0) then
        strError := SysErrorMessage(dwError);
    finally
      aSaveStream.Free;
      if (dwError <> 0) then
      begin
        fLastError := Format(ErrWritingToFile, [fFileName]) + #10#13 + strError;
        if not(tjSilent in fJPEGCommentSettings) then
        begin
          aJPEGException := EJPEGCommentWriteException.Create(fLastError);
          raise aJPEGException;
        end;
      end;
    end;
  end;
end;

function TJPGGetComment._RemoveEXIF(var aMemoryStream: TMemoryStream;
  const aFileName: string; const aEXIFOffset: LongInt;
  const aEXIFLength: integer; const bKeepFileTimes: BOOLEAN): BOOLEAN;
var
  aJPEGException: EJPEGCommentWriteException;
  aFileStream: TFileStream;
  aSaveStream: TMemoryStream;
  lEXIFOffset: LongInt;
  lEXIFTotal: LongInt;
  lSavePosition: LongInt;
  lStreamSizeOld: LongInt;
  lStreamSizeNew: LongInt;
  dwError: DWORD;
  strError: string;
begin
  result := FALSE;
  if (aMemoryStream <> nil) and (aEXIFOffset > 1) and (aEXIFLength > 0) then
  begin
    dwError := 0;
    strError := '';
    lStreamSizeOld := aMemoryStream.Size;
    lEXIFOffset := aEXIFOffset;
    lEXIFTotal := aEXIFLength + 4;
    lStreamSizeNew := lStreamSizeOld - lEXIFTotal;
    if (aMemoryStream.Position < lEXIFOffset) then
      lSavePosition := aMemoryStream.Position
    else
      lSavePosition := 0;
    aMemoryStream.Seek(0, soFromBeginning);
    aSaveStream := TMemoryStream.Create;
    aFileStream := TFileStream.Create(aFileName, fmOpenWrite or
      fmShareDenyWrite);
    aFileStream.Seek(0, soFromBeginning);
    try
      aSaveStream.CopyFrom(aMemoryStream, lEXIFOffset);
      aMemoryStream.Seek(lEXIFOffset + lEXIFTotal, soFromBeginning);
      if (aSaveStream.Position = lEXIFOffset) then
        aSaveStream.CopyFrom(aMemoryStream, lStreamSizeNew - lEXIFOffset);
      if (aSaveStream.Position = lStreamSizeNew) then
      begin
        aFileStream.CopyFrom(aSaveStream, 0);
        aFileStream.Free;
        aMemoryStream.Clear;
        aMemoryStream.CopyFrom(aSaveStream, 0);
        fEXIFOffset := -1;
        fEXIFLength := 0;
        if (bKeepFileTimes = TRUE) then
          result := _SetFileTimes(aFileName, fFTCreationTime, fFTLastAccessTime,
            fFTLastWriteTime)
        else
          result := TRUE;
      end;
      aMemoryStream.Seek(lSavePosition, soFromBeginning);
      dwError := GetLastError;
      if (dwError <> 0) then
        strError := SysErrorMessage(dwError);
    finally
      aSaveStream.Free;
      if (dwError <> 0) then
      begin
        fLastError := Format(ErrWritingToFile, [fFileName]) + #10#13 + strError;
        if not(tjSilent in fJPEGCommentSettings) then
        begin
          aJPEGException := EJPEGCommentWriteException.Create(fLastError);
          raise aJPEGException;
        end;
      end;
    end;
  end;
end;

function TJPGGetComment._SetFileTimes(const aFileName: string;
  const FTCreationTime: TFileTime; const FTLastAccessTime: TFileTime;
  const FTLastWriteTime: TFileTime): BOOLEAN;
var
  aJPEGException: EJPEGCommentWriteException;
  BOOLResult: LongBOOL;
  dwError: DWORD;
  FileHandle: THandle;
  pcFileName: pChar;
  strError: string;
  _FTNULLTime: TFileTime;
begin
  result := FALSE;
  _FTNULLTime := GetNULLFileTime;
  if (Length(aFileName) > 0) then
  begin
    pcFileName := StrAlloc(Length(aFileName) + 1);
    StrPCopy(pcFileName, aFileName);
    dwError := 0;
    BOOLResult := TRUE;
    // FileHandle := INVALID_HANDLE_VALUE;
    try
      FileHandle := CreateFile(pcFileName, GENERIC_WRITE or GENERIC_READ,
        FILE_SHARE_WRITE or FILE_SHARE_READ, nil, OPEN_EXISTING, 0, 0);
      if (FileHandle <> INVALID_HANDLE_VALUE) then
      begin
        BOOLResult := SetFileTime(FileHandle, @FTCreationTime,
          @FTLastAccessTime, @FTLastWriteTime);
        CloseHandle(FileHandle);
      end;
      dwError := GetLastError;
      if (dwError <> 0) then
        strError := SysErrorMessage(dwError);
    finally
      StrDispose(pcFileName);
      if (dwError <> 0) then
      begin
        fLastError := Format(ErrWritingDateToFile, [aFileName]) + #10#13
          + strError;
        if not(tjSilent in fJPEGCommentSettings) then
        begin
          aJPEGException := EJPEGCommentWriteException.Create(fLastError);
          raise aJPEGException;
        end;
      end;
      result := BOOLEAN(BOOLResult);
    end;
  end;
end;

procedure TJPGGetComment.SetEXIFOffset(value: LongInt);
begin
end;

procedure TJPGGetComment.SetEXIFLength(value: word);
begin
end;

procedure TJPGGetComment.SetFileName(value: string);
begin
  ClearInfo;
  if (fFileName <> value) then
  begin
    if (Length(value) > 0) then
    begin
      if (tjCheckFile in fJPEGCommentSettings) then
      begin
        if (_CheckFile(value) = TRUE) then
          fFileName := value;
      end
      else
        fFileName := value;
      _ReadFile(fFileName, fImageStream, fStreamSize, fJPEGCommentOffset,
        fJPEGCommentLength, fJPEGComment, fEXIFOffset, fEXIFLength);
    end
    else
      fFileName := value;
  end;
end;

procedure TJPGGetComment.SetJPEGComment(value: TStrings);
var
  strNew: string;
  strOld: string;
begin
  if not(tjReadOnly in fJPEGCommentSettings) then
  begin
    if (value = nil) then
      fWriteType := wtRemove
    else
      strNew := TrimRight(value.Text);
    if (Length(strNew) = 0) then
      fWriteType := wtRemove
    else
    begin
      strOld := TrimRight(fJPEGComment.Text);
      if (Length(strOld) > 0) then
        fWriteType := wtOverride
      else
        fWriteType := wtWriteNew;
    end;
    if (_ChangeComment(strNew) = TRUE) then
      fJPEGComment.Assign(value);
  end;
end;

procedure TJPGGetComment.SetJPEGCommentLength(value: word);
begin
end;

procedure TJPGGetComment.SetJPEGCommentOffset(value: integer);
begin
end;

procedure TJPGGetComment.SetJPEGCommentSettings(value: TJPEGCommentSettings);
var
  TempCommentSettings: TJPEGCommentSettings;
begin
  if (fJPEGCommentSettings <> value) then
  begin
    TempCommentSettings := value;
    if (tjReadOnly in TempCommentSettings) then
      Exclude(TempCommentSettings, tjReadOnly);
    fJPEGCommentSettings := TempCommentSettings;
  end;
end;

procedure TJPGGetComment.SetStreamSize(value: integer);
begin
end;

// constructor TJPGGetComment.Create;
constructor TJPGGetComment.Create(AOwner: TComponent);
begin
  // inherited Create;

  fBIsReadOnly := FALSE;
  fEXIFLength := 0;
  fEXIFOffset := -1;
  fFileName := '';
  fFTCreationTime := GetNULLFileTime;
  fFTLastAccessTime := GetNULLFileTime;
  fFTLastWriteTime := GetNULLFileTime;
  fImageStream := TMemoryStream.Create;
  fJPEGComment := TStringList.Create;
  fJPEGCommentLength := 0;
  fJPEGCommentOffset := -1;
  fJPEGCommentSettings := [tjCheckFile];
  fLastError := '';
  fStreamSize := 0;
  inherited;
end;

constructor TJPGGetComment.CreateFromFile(const FileName: string;
  const cJPEGCommentSettings: TJPEGCommentSettings);
begin
  // Create;
  JPEGCommentSettings := cJPEGCommentSettings;
  fFileName := FileName;
end;

destructor TJPGGetComment.Destroy;
begin
  if (fImageStream <> nil) then
  begin
    fImageStream.Clear;
    fImageStream.Free;
  end;
  if (fJPEGComment <> nil) then
  begin
    fJPEGComment.Clear;
    fJPEGComment.Free;
  end;
  inherited Destroy;
end;

procedure TJPGGetComment.Assign(Source: TPersistent);
var
  aTGJPEGComment: TJPGGetComment;
begin
  if (Source is TJPGGetComment) then
  begin
    ClearInfo;
    aTGJPEGComment := Source as TJPGGetComment;
    FileName := aTGJPEGComment.fFileName;
  end
  else
    inherited Assign(Source);
end;

procedure TJPGGetComment.AssignTo(Dest: TPersistent);
var
  aTGJPEGComment: TJPGGetComment;
begin
  if (Dest is TJPGGetComment) then
  begin
    aTGJPEGComment := Dest as TJPGGetComment;
    aTGJPEGComment.ClearInfo;
    with aTGJPEGComment do
    begin
      FileName := self.fFileName;
    end;
  end
  else
    inherited AssignTo(Dest);
end;

procedure TJPGGetComment.AssignToStringList(var Strings: TStrings;
  const DoClear: BOOLEAN);
begin
  if (Strings = nil) then
    Strings := TStringList.Create
  else
  begin
    if (DoClear = TRUE) then
      Strings.Clear;
  end;
  Strings.AddStrings(fJPEGComment);
end;

procedure TJPGGetComment.ClearInfo;
begin
  fBIsReadOnly := FALSE;
  fEXIFLength := 0;
  fEXIFOffset := -1;
  fFTCreationTime := GetNULLFileTime;
  fFTLastAccessTime := GetNULLFileTime;
  fFTLastWriteTime := GetNULLFileTime;
  fJPEGComment.Clear;
  fJPEGCommentLength := 0;
  fJPEGCommentOffset := -1;
  fLastError := '';
  fStreamSize := 0;
end;

procedure TJPGGetComment.CommentFromClipBoard;
var
  Clip: TClipBoard;
  strComment: string;
  sComment: TStringList;
begin
  if (fImageStream <> nil) and not(tjReadOnly in fJPEGCommentSettings) then
  begin
    Clip := ClipBoard;
    if (Clip <> nil) then
    begin
      strComment := Clip.AsText;
      if (Length(strComment) > 0) then
      begin
        sComment := TStringList.Create;
        try
          sComment.Text := strComment;
          JPEGComment := sComment;
        finally
          sComment.Free;
        end;
      end;
    end;
  end;
end;

procedure TJPGGetComment.CommentToClipboard;
var
  Clip: TClipBoard;
  strComment: string;
begin
  if (fImageStream <> nil) then
  begin
    strComment := fJPEGComment.Text;
    if (Length(strComment) > 0) then
    begin
      Clip := ClipBoard;
      if (Clip <> nil) then
        Clip.AsText := strComment;
    end;
  end;
end;

function TJPGGetComment.InsertComment: BOOLEAN;
var
  bKeepFileTimes: BOOLEAN;
  bEXIFCompatible: BOOLEAN;
  strComment: string;
  lOffset: LongInt;
begin
  result := FALSE;
  if (fImageStream <> nil) and not(tjReadOnly in fJPEGCommentSettings) then
  begin
    strComment := fJPEGComment.Text;
    if (Length(strComment) > 0) then
    begin
      if (tjKeepFileTimes in fJPEGCommentSettings) then
        bKeepFileTimes := TRUE
      else
        bKeepFileTimes := FALSE;
      if (tjEXIFCompatible in fJPEGCommentSettings) then
        bEXIFCompatible := TRUE
      else
        bEXIFCompatible := FALSE;
      if (fEXIFOffset = -1) then
        lOffset := 2
      else
      begin
        if (fEXIFOffset >= 2) and (bEXIFCompatible = TRUE) then
          lOffset := fEXIFOffset + fEXIFLength + 4
        else
          lOffset := 2;
      end;
      result := _InsertComment(fImageStream, fFileName, lOffset, strComment,
        bKeepFileTimes);
      Update;
    end;
  end;
end;

function TJPGGetComment.OverrideComment: BOOLEAN;
var
  bKeepFileTimes: BOOLEAN;
  bEXIFCompatible: BOOLEAN;
  strComment: string;
  lOffset: LongInt;
begin
  result := FALSE;
  if (fImageStream <> nil) and not(tjReadOnly in fJPEGCommentSettings) then
  begin
    strComment := fJPEGComment.Text;
    if (Length(strComment) > 0) then
    begin
      if (tjKeepFileTimes in fJPEGCommentSettings) then
        bKeepFileTimes := TRUE
      else
        bKeepFileTimes := FALSE;
      if (tjEXIFCompatible in fJPEGCommentSettings) then
        bEXIFCompatible := TRUE
      else
        bEXIFCompatible := FALSE;
      if (fEXIFOffset = -1) then
        lOffset := 2
      else
      begin
        if (fEXIFOffset >= 2) and (bEXIFCompatible = TRUE) then
          lOffset := fEXIFOffset + fEXIFLength + 4
        else
          lOffset := 2;
      end;
      result := _OverrideComment(fImageStream, fFileName, lOffset, strComment,
        bKeepFileTimes);
      Update;
    end;
  end;
end;

function TJPGGetComment.RemoveComment: BOOLEAN;
var
  bKeepFileTimes: BOOLEAN;
  strComment: string;
begin
  result := FALSE;
  if (fImageStream <> nil) and not(tjReadOnly in fJPEGCommentSettings) then
  begin
    strComment := fJPEGComment.Text;
    if (Length(strComment) > 0) then
    begin
      if (tjKeepFileTimes in fJPEGCommentSettings) then
        bKeepFileTimes := TRUE
      else
        bKeepFileTimes := FALSE;
      result := _RemoveComment(fImageStream, fFileName, fJPEGCommentOffset,
        fJPEGCommentLength, bKeepFileTimes);
      Update;
    end;
  end;
end;

function TJPGGetComment.RemoveEXIF: BOOLEAN;
var
  bKeepFileTimes: BOOLEAN;
begin
  result := FALSE;
  if (fImageStream <> nil) and not(tjReadOnly in fJPEGCommentSettings) then
  begin
    if (fEXIFOffset > 0) and (fEXIFLength > 0) then
    begin
      if (tjKeepFileTimes in fJPEGCommentSettings) then
        bKeepFileTimes := TRUE
      else
        bKeepFileTimes := FALSE;
      if (_RemoveEXIF(fImageStream, fFileName, fEXIFOffset, fEXIFLength,
        bKeepFileTimes) = TRUE) then
        result := ResampleComment;
      Update;
    end;
  end;
end;

function TJPGGetComment.ResampleComment: BOOLEAN;
var
  bKeepFileTimes: BOOLEAN;
  iCommentTotal: integer;
  iCommentTempOffset: integer;
  strComment: string;
  wCommentTempLength: word;
  iNewCommentOffset: integer;
  iEXIFTotal: integer;
  iEXIFTempOffset: integer;
  wEXIFTempLength: word;
begin
  result := FALSE;
  iNewCommentOffset := 0;
  if (fImageStream <> nil) and not(tjReadOnly in fJPEGCommentSettings) then
  begin
    if (tjKeepFileTimes in fJPEGCommentSettings) then
      bKeepFileTimes := TRUE
    else
      bKeepFileTimes := FALSE;
    iCommentTotal := _GetComment(fImageStream, iCommentTempOffset,
      wCommentTempLength, strComment);
    if (iCommentTotal > 0) then
    begin
      iEXIFTotal := _GetEXIFOffsetAndLength(fImageStream, iEXIFTempOffset,
        wEXIFTempLength);
      if (iEXIFTotal > 0) and (iCommentTempOffset <> iEXIFTotal) then
        iNewCommentOffset := iEXIFTotal;
      if (iEXIFTotal = 0) and (iCommentTempOffset > 2) then
        iNewCommentOffset := 2;
      if (iNewCommentOffset > 0) then
      begin
        if (_RemoveComment(fImageStream, fFileName, iCommentTempOffset,
          wCommentTempLength, bKeepFileTimes) = TRUE) then
          result := _InsertComment(fImageStream, fFileName, iNewCommentOffset,
            strComment, bKeepFileTimes);
      end
      else
        result := TRUE;
    end;
  end;
end;

function TJPGGetComment.Update: BOOLEAN;
begin
  result := FALSE;
  if (Length(fFileName) > 0) then
  begin
    ClearInfo;
    result := _ReadFile(fFileName, fImageStream, fStreamSize,
      fJPEGCommentOffset, fJPEGCommentLength, fJPEGComment, fEXIFOffset,
      fEXIFLength);
  end;
end;

end.
