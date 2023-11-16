unit PBExListview;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls;

type

  TLVColumnResizeEvent = procedure(Sender: TCustomListview;
    columnindex: Integer;
    columnwidth: Integer) of object;

  Tscolstoppevent = procedure(Sender: TCustomListview;
                              horizontal : boolean) of object;


  TPBExListview = class(TListview)
  private
    flastparm : Longint;
    fhorzpos : Longint;
    fhorzmove : Longint;
    fVertpos : Longint;
    fdragfromcol : Integer;
    fdragtocol  : Integer;
    FBeginColumnResizeEvent: TLVColumnResizeEvent;
    FEndColumnResizeEvent: TLVColumnResizeEvent;
    FColumnResizeEvent: TLVColumnResizeEvent;
    FBeginColumnDragEvent: TLVColumnResizeEvent;
    FOnVertscroll: TNotifyEvent;
    FOnHorzcroll: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;
    Fmouselastcoord : tpoint;
    fscollstopped : Tscolstoppevent;
    Procedure WMVScroll( Var Msg: TMessage ); message WM_VSCROLL;
    Procedure WMHScroll( Var Msg: TMessage ); message WM_HSCROLL;
    Procedure WMKeyDown( Var Msg: TMessage ); message WM_KEYDOWN;
    Procedure WMKeyUp  ( Var Msg: TMessage ); message WM_KEYUP;
    Procedure WMChar   ( Var Msg: TMessage ); message WM_CHAR;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  protected
    procedure doscrollstop(horizontal : boolean);
      virtual;
    procedure DoBeginColumnResize(columnindex, columnwidth: Integer);
      virtual;
    procedure DoEndColumnResize(columnindex, columnwidth: Integer);
      virtual;
    procedure DoColumnResize(columnindex, columnwidth: Integer);
      virtual;
    procedure DoBeginColumnDrag(columnindex, columnwidth: Integer);
      virtual;
    procedure WMNotify(var Msg: TWMNotify); message WM_NOTIFY;

    function FindColumnIndex(pHeader: pNMHdr): Integer;
    function FindColumnWidth(pHeader: pNMHdr): Integer;
    procedure CreateWnd; override;
  public

  published

    property horzmove : Longint read fhorzmove write fhorzmove;
    property horzpos : Longint read fhorzpos write fhorzpos;
    property Vertpos : Longint read fVertpos write fVertpos;
    property lastparm : Longint read flastparm;
    Property dragfromcol : Integer read fdragfromcol;
    Property dragtocol   : Integer read fdragtocol;
    Property mouselastcoord : tpoint read Fmouselastcoord write Fmouselastcoord;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
    property OnVertscroll: TNotifyEvent read FOnVertscroll write FOnVertscroll;
    property Onhorzcroll: TNotifyEvent read FOnhorzcroll write FOnhorzcroll;

    property OnBeginColumnResize: TLVColumnResizeEvent
      read FBeginColumnResizeEvent write FBeginColumnResizeEvent;
    property OnEndColumnResize: TLVColumnResizeEvent
      read FEndColumnResizeEvent write FEndColumnResizeEvent;
    property OnColumnResize: TLVColumnResizeEvent
      read FColumnResizeEvent write FColumnResizeEvent;
    property OnColumnBegindrag: TLVColumnResizeEvent
      read FBeginColumnDragEvent write FBeginColumnDragEvent;

    property OnScrollstopped: Tscolstoppevent
      read fscollstopped write fscollstopped;



  end;

procedure Register;

implementation

uses CommCtrl;

procedure Register;
begin
  RegisterComponents('PBGoodies', [TPBExListview]);
end;


procedure TPBExListview.WMChar(var Msg: TMessage);
begin
end;

procedure TPBExListview.WMHScroll(var Msg: TMessage);
Var
  doscroll : boolean;
begin
  doscroll := true;
  IF msg.WParamlo = 5 then
  Begin
    fhorzmove := msg.WParamHi-fhorzpos;
    fhorzpos := msg.WParamHi;
  end;
  IF msg.WParamlo = 8 then
  begin
    if Assigned(fscollstopped) then
    Begin
      doscroll := false;
      doscrollstop(true);
    end;
  end;

  IF Assigned(FOnHorzcroll) then
  begin
    IF doscroll then
    FOnHorzcroll(self);
  end;
  inherited;
end;

procedure TPBExListview.WMKeyDown(var Msg: TMessage);
begin
  inherited;
end;

procedure TPBExListview.WMKeyUp(var Msg: TMessage);
begin
  inherited;
end;

procedure TPBExListview.WMVScroll(var Msg: TMessage);
begin
  IF msg.WParamlo = 5 then
    fVertpos := msg.WParamHi;
  IF Assigned(FOnVertscroll) then
    FOnVertscroll(self);
  inherited;
end;



//Old stuf

procedure TPBExListview.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if Assigned(FOnMouseLeave) then
  Begin
    Fmouselastcoord.X := 10;
    Fmouselastcoord.y := 10;

    FOnMouseLeave(self);
  End;
end;

procedure TPBExListview.DoBeginColumnResize(columnindex, columnwidth: Integer);
begin
  if Assigned(FBeginColumnResizeEvent) then
    FBeginColumnResizeEvent(Self, columnindex, columnwidth);
end;

procedure TPBExListview.DoEndColumnResize(columnindex, columnwidth: Integer);
begin
  if Assigned(FEndColumnResizeEvent) then
    FEndColumnResizeEvent(Self, columnindex, columnwidth);
end;

procedure TPBExListview.DoColumnResize(columnindex, columnwidth: Integer);
begin
  if Assigned(FColumnResizeEvent) then
    FColumnResizeEvent(Self, columnindex, columnwidth);
end;

procedure TPBExListview.DoBeginColumnDrag(columnindex, columnwidth: Integer);
begin
  if Assigned(FBeginColumnDragEvent) then
  Begin
    FBeginColumnDragEvent(Self, columnindex, columnwidth);
    fdragfromcol := columnindex;
  End;
end;


function TPBExListview.FindColumnIndex(pHeader: pNMHdr): Integer;
var
  hwndHeader: HWND;
  iteminfo: THdItem;
  ItemIndex: Integer;
  buf: array [0..128] of Char;
begin
  Result := -1;
  hwndHeader := pHeader^.hwndFrom;
  ItemIndex := pHDNotify(pHeader)^.Item;
  FillChar(iteminfo, SizeOf(iteminfo), 0);
  iteminfo.Mask := HDI_TEXT;
  iteminfo.pszText := buf;
  iteminfo.cchTextMax := SizeOf(buf) - 1;
  Header_GetItem(hwndHeader, ItemIndex, iteminfo);
  if CompareStr(Columns[ItemIndex].Caption, iteminfo.pszText) = 0 then
    Result := ItemIndex
  else
  begin
    for ItemIndex := 0 to Columns.Count - 1 do
      if CompareStr(Columns[ItemIndex].Caption, iteminfo.pszText) = 0 then
      begin
        Result := ItemIndex;
        Break;
      end;
  end;
end;

procedure TPBExListview.WMNotify(var Msg: TWMNotify);
begin
  inherited;
  try
    case Msg.NMHdr^.code of
      HDN_ENDTRACK:
        DoEndColumnResize(FindColumnIndex(Msg.NMHdr),
          FindColumnWidth(Msg.NMHdr));
      HDN_BEGINTRACK:
        DoBeginColumnResize(FindColumnIndex(Msg.NMHdr),
          FindColumnWidth(Msg.NMHdr));
      HDN_TRACK:
        DoColumnResize(FindColumnIndex(Msg.NMHdr),
          FindColumnWidth(Msg.NMHdr));
      HDN_BEGINDRAG:DoBeginColumnDrag(FindColumnIndex(Msg.NMHdr),
          FindColumnWidth(Msg.NMHdr));

    end;
  Except
  end;  
end;

procedure TPBExListview.CreateWnd;
var
  wnd: HWND;
begin
  inherited;
  wnd := GetWindow(Handle, GW_CHILD);
  SetWindowLong(wnd, GWL_STYLE,
    GetWindowLong(wnd, GWL_STYLE) and not HDS_FULLDRAG);
end;

function TPBExListview.FindColumnWidth(pHeader: pNMHdr): Integer;
begin
  Result := -1;
  if Assigned(PHDNotify(pHeader)^.pItem) and
    ((PHDNotify(pHeader)^.pItem^.mask and HDI_WIDTH) <> 0) then
    Result := PHDNotify(pHeader)^.pItem^.cxy;
end;

procedure TPBExListview.doscrollstop(horizontal : boolean);
begin

  if Assigned(fscollstopped) then
  Begin
    fscollstopped(self,horizontal);
  End;

end;



end.


