unit Fileclipboard;

interface

uses
  SysUtils, Classes;

type
  TFileclipboard = class(TComponent)
  private
    { Private declarations }
    PCLBfiles : Tstrings;
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property CLBfiles : Tstrings read PCLBfiles write PCLBfiles;
    procedure refreshList;
    procedure ApplyList;
    Function PutFilesToClipboard(Var Alist : Tstrings):boolean;
    Function GetFilesFromClipboard(Var Alist : Tstrings):boolean;
  end;


implementation
uses
   Windows, clipbrd, shellapi,ShlObj;

constructor TFileclipboard.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  PCLBfiles := TStringList.create;
end;

destructor TFileclipboard.Destroy;
begin
  PCLBfiles.free;
  inherited;
end;







Function TFileclipboard.GetFilesFromClipboard(Var Alist : Tstrings):boolean;
var
   f: THandle;
   buffer: Array [0..MAX_PATH] of Char;
   i, numFiles: Integer;
begin
   result := false;
   Clipboard.Open;
   try
     f:= Clipboard.GetAsHandle( CF_HDROP ) ;
     If f <> 0 Then
     Begin
       numFiles := DragQueryFile( f, $FFFFFFFF, nil, 0 ) ;
       Alist.Clear;
       for i:= 0 to numfiles - 1 do
       begin
         buffer[0] := #0;
         DragQueryFile( f, i, buffer, sizeof(buffer)) ;
         Alist.add( buffer ) ;
       end;
       result := alist.Count > 0;
     end;
   finally
     Clipboard.close;
   end;
end;

Function TFileclipboard.PutFilesToClipboard(Var Alist : Tstrings):boolean;
var
  DropFiles: PDropFiles;
  hGlobal: THandle;
  I,iLen: Integer;
  FileList: string;
  listok : boolean;

begin
  listok := alist.count > 0;
  result := false;
  iLen := 0;
  try
    if listok then
    begin
      listok := false;
      FileList := '';
      For i := 0 to alist.count-1 do
      begin
        FileList := FileList + alist[i];
        if (i < alist.count-1) then
        begin
          FileList := FileList + #0;
        end;
      end;
    end;
    listok := true;
  except
    listok := false;
  end;

  IF listok then
  begin
    try
      iLen := Length(FileList) + 2;
      FileList := FileList + #0#0;
      hGlobal := GlobalAlloc(GMEM_SHARE or GMEM_MOVEABLE or GMEM_ZEROINIT,
        SizeOf(TDropFiles) + iLen);
    Except
      hGlobal := 0;
    end;

    if (hGlobal = 0) then
    Begin
      result := false;
    end
    else
    begin
      try
        DropFiles := GlobalLock(hGlobal);
        DropFiles^.pFiles := SizeOf(TDropFiles);
        Move(FileList[1], (PChar(DropFiles) + SizeOf(TDropFiles))^, iLen);
        GlobalUnlock(hGlobal);
        Clipboard.SetAsHandle(CF_HDROP, hGlobal);
        result := true;
      Except
        result := false;
      end;
    End;
  End;
end;


procedure TFileclipboard.refreshList;
Begin

  PCLBfiles.clear;
  GetFilesFromClipboard(PCLBfiles);
End;

procedure TFileclipboard.ApplyList;
Begin

  PutFilesToClipboard(PCLBfiles);
End;


end.
