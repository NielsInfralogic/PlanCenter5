(******************************************************************************)
(* SPTmline - Timeline planner                                                *)
(*                                                                            *)
(* Shorter Path Planners                                                      *)
(*                                                                            *)
(* Copyright © 2004, 2007 Shorter Path Software                               *)
(* http://www.shorterpath.com                                                 *)
(******************************************************************************)

unit SPTmline;

{$B-,G+,H+,J-,O+,S-,Q-,R-,T-,W-,X+}
{$ObjExportAll On}

{$IFDEF VER120}
{$DEFINE VCL4}
{$ENDIF}

{$IFDEF VER125}
{$DEFINE VCL4}
{$ENDIF}

{$IFDEF VER130}
{$DEFINE VCL5}
{$ENDIF}

{$IFDEF CLR}
{$WARN SYMBOL_PLATFORM OFF}
{$ENDIF}

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, SPPlanners, Graphics;

type
  TSPColumnTimeSpan = (ct30Minutes, ctHour, ctDay, ct1Minute);

  TSPTimelinePlanner = class(TSPBasePlanner)
  private
    FColTimeSpan: TSPColumnTimeSpan;
    FColCount: Integer;
    FStartTime: TDateTime;
    FScrollStart: TDateTime;
    FItemLists: TList;
    procedure ApplyViewSettings;
    function GetColTimeSpanValue: TDateTime;
    function GetScrollTimeSpanValue: TDateTime;
    procedure ResetScrollBar;
    procedure UpdateScrollBar;
    procedure RequestScrollItems;
    procedure ReadItems;
    procedure SetScrollStart(Value: TDateTime);
    procedure DoSetStartTime(Value: TDateTime);
    procedure DrawItemBorder(ACanvas: TCanvas; BorderRect: TRect;
      Selected, ExtendsBefore, ExtendsAfter: Boolean);
    function GetItemLists(Index: Integer): TSPDisplayItems;
    procedure SetColCount(const Value: Integer);
    procedure SetColTimeSpan(const Value: TSPColumnTimeSpan);
    procedure SetStartTime(const Value: TDateTime);
    procedure WMHScroll(var Message: TWMHScroll); message WM_HSCROLL;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateHandle; override;
    procedure ClockFormatChanged; override;
    procedure DoInsertItem(Item: TSPPlanItem); override;
    function FindDisplayItem(Item: TSPPlanItem;
      ACol, ARow: Integer): TSPDisplayItem; override;
    procedure GetDisplayItemRect(DisplayItem: TSPDisplayItem;
      ACol, ARow: Integer; var ItemRect: TRect;
      var ExtendsBefore, ExtendsAfter: Boolean); override;
    function GetItemEditRect(Item: TSPPlanItem;
      ACol, ARow: Integer): TRect; override;
    function ItemHitTest(Item: TSPPlanItem;
      CursorPos: TPoint): TSPItemHit; override;
    procedure GetDisplayItemPrintRect(DisplayItem: TSPDisplayItem;
      ACol, ARow: Integer; var ItemRect: TRect;
      var ExtendsBefore, ExtendsAfter: Boolean); override;
    procedure PaintBar(ARect: TRect); override;
    procedure PaintContent(ARect: TRect); override;
    procedure PaintHeader(ARect: TRect); override;
    procedure PrintBar(ACanvas: TCanvas;
      AColor, AHeaderColor, AHeaderTextColor, ABorderColor: TColor;
      APage: Integer); override;
    procedure PrintContent(ACanvas: TCanvas;
      AColor, AHeaderColor, AHeaderTextColor, ABorderColor: TColor;
      APage: Integer); override;
    procedure PrintHeader(ACanvas: TCanvas;
      AColor, AHeaderColor, AHeaderTextColor, ABorderColor: TColor;
      APage: Integer); override;
    procedure ResourcesChange; override;
    procedure ScalePrintFont(ACanvas: TCanvas; ARect: TRect); override;
    procedure SourceChanged; override;
    property ItemLists[Index: Integer]: TSPDisplayItems read GetItemLists;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure GetCellDates(ACol, ARow: Integer; var StartTime,
      EndTime: TDateTime); override;
    function FindItemAtPos(X, Y: Integer): TSPPlanItem; override;
    function GetCellResource(ACol, ARow: Integer): TSPPlannerResource; override;
  published
    property Align;
    property AllowInplaceEdit;
    property AllowResize;
    property Anchors;
    property AutoSizeRows default True;
    property BackgroundColor;
    property Ctl3D default True;
    property BiDiMode;
    property BorderStyle;
    property Constraints;
    property ClockFormat;
    property ColCount: Integer read FColCount write SetColCount default 48;
    property ColTimeSpan: TSPColumnTimeSpan read FColTimeSpan
      write SetColTimeSpan default ct30Minutes;
    property Color;
    property CopyOnDrop;
    property Enabled;
    property Visible;
    property Width default 160;
    property Height default 120;
    property Font;
    property Filter;
    property GroupBy;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ReadOnly;
    property Resources;
    property RowHeight default 80;
    property TabOrder;
    property TabStop default True;
    property PopupMenu;
    property DragMode;
    property DragCursor;
    property Hint;
    property ParentShowHint;
    property ShowHint;
    property Source;
    property StartTime: TDateTime read FStartTime write SetStartTime;
    property ThemeStyle;
    property OnClick;
    property OnDblClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseUp;
    property OnMouseMove;
    {$IFDEF CONDITIONALEXPRESSIONS}
    {$IF RTLVersion >= 18.0}
    property OnMouseActivate;
    property OnMouseEnter;
    property OnMouseLeave;
    {$IFEND}
    {$ENDIF}
    property OnStartDrag;
    property OnEndDrag;
    property OnDragOver;
    property OnDragDrop;
    property OnEnter;
    property OnExit;
    property OnDrawItem;
    property OnDrawCell;
    property OnInsertItem;
    property OnItemHint;
  end;

resourcestring
  SInvalidColCount = 'ColCount must be a positive integer';

implementation

{$IFDEF CLR}
uses
  Types, WinUtils;
{$ENDIF}

const
  CELL_MARGIN = 2;
  ITEM_SPACING = 3;

  { VIEW_PAGES must be an odd number }
  VIEW_PAGES = 9;

{ TSPTimelinePlanner }

constructor TSPTimelinePlanner.Create(AOwner: TComponent);
begin
  FItemLists := TList.Create;

  inherited Create(AOwner);
  Ctl3D := True;
  Width := 160;
  Height := 120;
  TabStop := True;

  SelectionFlow := sfHorizontal;
  HeaderRows := 2;
  SubHeaderRows := 0;
  FooterRows := 0;

  FColCount := 48;
  FColTimeSpan := ct30Minutes;

  SetAutoSizeRows(True);
  RowHeight := 80;
  ApplyViewSettings;
  StartTime := Trunc(Now) + Double(EncodeTime(9, 0, 0, 0));
  DoubleBuffered := True;
end;

procedure TSPTimelinePlanner.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or WS_HSCROLL;
end;

destructor TSPTimelinePlanner.Destroy;
var
  i: Integer;
begin
  for i := 0 to FItemLists.Count - 1 do
    ItemLists[i].Free;
  FItemLists.Free;

  inherited Destroy;
end;

procedure TSPTimelinePlanner.PaintBar(ARect: TRect);
var
  i: Integer;
  CellRect, TextRect, BorderRect: TRect;
  ResText: string;
  TextOffset: Integer;
begin
  inherited PaintBar(ARect);
  Canvas.Brush.Style := bsClear;
  CellRect := ARect;
  for i := TopRow to RowCount - 1 do      
  begin
    CellRect.Top := ARect.Top + RowTops[i - TopRow];
    CellRect.Bottom := CellRect.Top + RowHeights[i - TopRow];

    TextRect := CellRect;
    InflateRect(TextRect, -2, -2);
    TextOffset := (TextRect.Bottom - (TextRect.Top + LineHeight)) div 2;
    if TextOffset > 0 then
      Inc(TextRect.Top, TextOffset);

    if (GroupBy <> grNone) and (Resources.Count > 0) then
    begin
      if (Resources[i].ImageIndex >= 0) and Assigned(Source) and
        Assigned(Source.Images) and
        (Source.Images.Count > Resources[i].ImageIndex) then
      begin
        if UseRightToLeftAlignment then
        begin
          Source.Images.Draw(Canvas, TextRect.Right - Source.Images.Width,
            TextRect.Top, Resources[i].ImageIndex);
          Dec(TextRect.Right, Source.Images.Width + 2);
        end else
        begin
          Source.Images.Draw(Canvas, TextRect.Left, TextRect.Top,
            Resources[i].ImageIndex);
          Inc(TextRect.Left, Source.Images.Width + 2);
        end;
      end;
      ResText := Resources[i].Name;
      DrawText(Canvas.Handle,
        {$IFNDEF CLR}PChar{$ENDIF}(ResText),
        Length(ResText), TextRect,
        DrawTextBiDiModeFlags(DT_LEFT or DT_SINGLELINE or DT_NOPREFIX));
    end;

    if (i < RowCount - 1) or (not AutoSizeRows) then
    begin
      BorderRect := CellRect;
      InflateRect(BorderRect, -2, 0);
      Inc(BorderRect.Bottom);
      DrawEdge(Canvas.Handle, BorderRect, EDGE_ETCHED, BF_BOTTOM);
    end;
  end;
end;

procedure TSPTimelinePlanner.PaintHeader(ARect: TRect);
var
  HeaderText: string;
  ColsPerText, ColsPerHour, ColsPerDayText: Integer;
  RequiredWidth: Integer;
  ColWidth: Integer;
  i: Integer;
  ColHeaderRect: TRect;
  ColDateTime: TDateTime;
  ColYear, ColMonth, ColDay, ColHour, ColMinute: Word;
  TimeString: string;
begin
  if ColTimeSpan = ctDay then
    HeaderText := '00'
  else
    HeaderText := '00:00';
  Canvas.Font := Font;
  RequiredWidth := Canvas.TextWidth(HeaderText) + 4;
  ColWidth := Columns[0].Right - Columns[0].Left;
  ColsPerText := RequiredWidth div ColWidth + 1;
  if (ColsPerText > 1) and (ColsPerText mod 2 = 1) and (ColTimeSpan <> ctDay) then
    Inc(ColsPerText);
  if (ColsPerText = 1) and
    ((ColTimeSpan = ct30Minutes) or (ColTimeSpan = ct1Minute)) then
    ColsPerText := 2;

  Canvas.Brush.Style := bsSolid;
  Canvas.Brush.Color := clWindow;
  Canvas.FillRect(ARect);

  Canvas.Brush.Style := bsClear;
  ColHeaderRect := ARect;
  ColHeaderRect.Top := ColHeaderRect.Bottom - (LineHeight + 3);
  i := 0;
  while i < Columns.Count do
  begin
    if UseRightToLeftAlignment then
    begin
      ColHeaderRect.Right := Columns[i].Right;
      if (i + ColsPerText) <= Columns.Count then
        ColHeaderRect.Left := Columns[i + ColsPerText - 1].Left
      else
        ColHeaderRect.Left := ARect.Left;
    end else
    begin
      ColHeaderRect.Left := Columns[i].Left;
      if (i + ColsPerText) <= Columns.Count then
        ColHeaderRect.Right := Columns[i + ColsPerText - 1].Right
      else
        ColHeaderRect.Right := ARect.Right;
    end;

    ColDateTime := StartTime + i * GetColTimeSpanValue;
    DecodeTime(ColDateTime, ColHour, ColMinute, ColMonth, ColDay);
    DecodeDate(ColDateTime, ColYear, ColMonth, ColDay);

    if ColTimeSpan = ctDay then
    begin
      HeaderText := Format('%.2d', [ColDay])
    end else
    begin
      if ColTimeSpan = ct1Minute then
        TimeString := Format(':%.2d', [ColMinute])
      else
        TimeString := ':00';
      if DisplayClockFormat = cf12Hours then
      begin
        if ((i = 0) and (ColTimeSpan <> ct1Minute)) or
          ((ColHour mod 12 = 0) and
            ((ColTimeSpan <> ct1Minute) or (ColMinute mod 60 = 0))) then
        begin
          if ColHour < 12 then
            TimeString := ' ' + SClockAM
          else
            TimeString := ' ' + SClockPM;
        end;
        ColHour := ColHour mod 12;
        if ColHour = 0 then
          ColHour := 12;
      end;
      HeaderText := Format('%.2d%s', [ColHour, TimeString]);
    end;

    InflateRect(ColHeaderRect, -2, 0);
    DrawText(Canvas.Handle,
      {$IFNDEF CLR}PChar{$ENDIF}(HeaderText),
      Length(HeaderText), ColHeaderRect,
      DrawTextBiDiModeFlags(DT_LEFT or DT_SINGLELINE or DT_NOPREFIX));

    Inc(i, ColsPerText);
  end;

  ColHeaderRect := ARect;
  ColHeaderRect.Bottom := ColHeaderRect.Top + LineHeight + 6;
  InflateRect(ColHeaderRect, 0, -3);
  Canvas.Font.Style := [fsBold];

  if ColTimeSpan = ct30Minutes then
    ColsPerHour := 2
  else
    if ColTimeSpan = ct1Minute then
      ColsPerHour := 60
    else
      ColsPerHour := 1;

  if ColTimeSpan = ctDay then
    ColsPerText := 1
  else
    ColsPerText := 24 * ColsPerHour;

  i := 0;
  while i < Columns.Count do
  begin
    ColDateTime := StartTime + i * GetColTimeSpanValue;
    DecodeTime(ColDateTime, ColHour, ColYear, ColMonth, ColDay);
    DecodeDate(ColDateTime, ColYear, ColMonth, ColDay);

    if ColTimeSpan = ctDay then
    begin
      ColsPerDayText := MonthDays[IsLeapYear(ColYear), ColMonth] - ColDay + 1;
      HeaderText := FormatDateTime('mmmm yyyy', ColDateTime);
    end else
    begin
      if ColHour > 0 then
        ColsPerDayText := ColsPerText - ColHour * ColsPerHour
      else
        ColsPerDayText := ColsPerText;
      HeaderText := FormatDateTime('dddddd', ColDateTime);
    end;

    if UseRightToLeftAlignment then
    begin
      ColHeaderRect.Right := Columns[i].Right;
      if (i + ColsPerDayText) <= Columns.Count then
        ColHeaderRect.Left := Columns[i + ColsPerDayText - 1].Left
      else
        ColHeaderRect.Left := ARect.Left;
    end else
    begin
      ColHeaderRect.Left := Columns[i].Left;
      if (i + ColsPerDayText) <= Columns.Count then
        ColHeaderRect.Right := Columns[i + ColsPerDayText - 1].Right
      else
        ColHeaderRect.Right := ARect.Right;
    end;

    InflateRect(ColHeaderRect, -2, 0);
    
    if (i = 0) and
      (Canvas.TextWidth(HeaderText) >
        ColHeaderRect.Right - ColHeaderRect.Left) then
      DrawText(Canvas.Handle,
        {$IFNDEF CLR}PChar{$ENDIF}(HeaderText),
        Length(HeaderText), ColHeaderRect,
        DrawTextBiDiModeFlags(DT_RIGHT or DT_SINGLELINE or DT_NOPREFIX))
    else
      DrawText(Canvas.Handle,
        {$IFNDEF CLR}PChar{$ENDIF}(HeaderText),
        Length(HeaderText), ColHeaderRect,
        DrawTextBiDiModeFlags(DT_LEFT or DT_SINGLELINE or DT_NOPREFIX));

    Inc(i, ColsPerDayText);
  end;

  DrawEdge(Canvas.Handle, ARect, BDR_RAISEDINNER, BF_BOTTOM);
end;

procedure TSPTimelinePlanner.PaintContent(ARect: TRect);
var
  Row, Col: Integer;
  CellRect, BorderRect: TRect;
  CellColor: TColor;
  ItemList: TSPDisplayItems;
  DisplayItemIndex: Integer;
  DisplayItem: TSPDisplayItem;
  ItemRect: TRect;
  ExtendsBefore: Boolean;
  ExtendsAfter: Boolean;
  ItemSelected: Boolean;
  ItemColor: TColor;
begin
  for Row := TopRow to RowCount - 1 do
  begin
    CellRect.Top := ARect.Top + RowTops[Row - TopRow];
    CellRect.Bottom := CellRect.Top + RowHeights[Row - TopRow];
    CellRect.Left := ARect.Left;
    CellRect.Right := ARect.Right;

    CellColor := BackgroundColor;
    if (GroupBy <> grNone) and (Resources.Count > 0) and
      (Resources[Row].Color <> clNone) then
      CellColor := Resources[Row].Color;

    PaintBackground(Canvas, CellRect, CellColor, True, False);

    for Col := 0 to ColCount - 1 do
    begin
      CellRect.Left := Columns[Col].Left;
      CellRect.Right := Columns[Col].Right;

      if not DoDrawCell(Canvas, Col, Row, CellRect,
        (SelectedCount = 0) and Focused and IsCellSelected(Col, Row)) then
      begin
        if (SelectedCount = 0) and Focused and IsCellSelected(Col, Row) then
        begin
          Canvas.Brush.Style := bsSolid;
          Canvas.Brush.Color := clHighlight;
          Canvas.Font.Color := clHighlightText;
          Canvas.FillRect(CellRect);
        end;
      end;

      if Col < Columns.Count - 1 then
      begin
        BorderRect := CellRect;
        if UseRightToLeftAlignment then
          BorderRect.Right := BorderRect.Left + 1
        else
          BorderRect.Left := BorderRect.Right - 1;
        PaintBorder(Canvas, BorderRect, CellColor,
          Col mod 2 = 1, False);
      end;
    end;

    ItemList := ItemLists[Row];
    for DisplayItemIndex := 0 to ItemList.Count - 1 do
    begin
      DisplayItem := ItemList[DisplayItemIndex];
      GetDisplayItemRect(DisplayItem, 0, Row, ItemRect,
        ExtendsBefore, ExtendsAfter);
      if ItemRect.Bottom < CellRect.Bottom then
      begin
        ItemSelected := IsItemSelected(DisplayItem.Item);
        if not DoDrawItem(DisplayItem.Item, Canvas, ItemRect,
          ExtendsBefore, ExtendsAfter, ItemSelected,
          (ItemUnderMouse = DisplayItem.Item), ContentRect) then
        begin
          Canvas.Font := Font;
          Canvas.Brush.Style := bsClear;

          ItemColor := DisplayItem.Item.Color;
          if ItemColor = clNone then
            ItemColor := clWhite;
          FillGradientRect(Canvas, ItemRect, ItemColor, clWhite);

          if ItemUnderMouse = DisplayItem.Item then
          begin
            if ItemSelected then
            begin
              InflateRect(ItemRect, 0, -2);
              if ItemResize = irNone then
                DrawGlow(Canvas, ItemRect);
              InflateRect(ItemRect, 0, 2);
              DrawItemBorder(Canvas, ItemRect, ItemSelected,
                ExtendsBefore, ExtendsAfter);
            end else
            begin
              DrawItemBorder(Canvas, ItemRect, ItemSelected,
                ExtendsBefore, ExtendsAfter);
              DrawGlow(Canvas, ItemRect);
            end;
          end else
            DrawItemBorder(Canvas, ItemRect, ItemSelected,
              ExtendsBefore, ExtendsAfter);
          InflateRect(ItemRect, 0 - CELL_MARGIN, 0 - CELL_MARGIN);

          DrawItemIcons(Canvas, ItemRect, Source.Images,
            DisplayItem.Item.Icons, UseRightToLeftAlignment);
          DrawText(Canvas.Handle,
            {$IFNDEF CLR}PChar{$ENDIF}(DisplayItem.Item.Title), -1, ItemRect,
            DrawTextBiDiModeFlags(DT_NOPREFIX));
        end;
      end else
        DrawMoreBitmap(Canvas,
          Rect(ItemRect.Left, CellRect.Top,
            ItemRect.Right, CellRect.Bottom)); 
    end;

    if (Row < RowCount - 1) or (not AutoSizeRows) then
      begin
        CellRect.Left := ARect.Left;
        CellRect.Right := ARect.Right;
        Canvas.Pen.Style := psSolid;
        Canvas.Pen.Color := clGray;
        Canvas.Pen.Width := 0;
        Canvas.Polyline(
          [Point(CellRect.Left, CellRect.Bottom - 1),
           Point(CellRect.Right, CellRect.Bottom - 1)]);
      end;
  end;

  if not AutoSizeRows then
  begin
    CellRect := ARect;
    CellRect.Top := ARect.Top + RowTops[RowCount - (TopRow + 1)] +
      RowHeights[RowCount - (TopRow + 1)];
    if CellRect.Top < CellRect.Bottom then
      FillBackgroundRect(CellRect);
  end;
end;

procedure TSPTimelinePlanner.SetColTimeSpan(const Value: TSPColumnTimeSpan);
begin
  if FColTimeSpan <> Value then
  begin
    FColTimeSpan := Value;
    DoSetStartTime(FStartTime);
    ApplyViewSettings;
  end;
end;

procedure TSPTimelinePlanner.SetColCount(const Value: Integer);
begin
  if Value < 1 then
    raise Exception.Create(SInvalidColCount);

  if FColCount <> Value then
  begin
    FColCount := Value;
    ApplyViewSettings;
  end;
end;

procedure TSPTimelinePlanner.SetStartTime(const Value: TDateTime);
begin
  DoSetStartTime(Value);
  ResetScrollBar;
end;

procedure TSPTimelinePlanner.ApplyViewSettings;
var
  i, ResLength: Integer;
begin
  if (GroupBy <> grNone) and (Resources.Count > 0) then
  begin
    ResLength := 0;
    for i := 0 to Resources.Count - 1 do
      if Length(Resources[i].Name) > ResLength then
        ResLength := Length(Resources[i].Name);
    Inc(ResLength, 4);
    if ResLength < 24 then
      BarCols := ResLength
    else
      BarCols := 24;
    SetRowCount(Resources.Count);
  end else
  begin
    BarCols := 0;
    SetRowCount(1);
  end;

  Columns.BeginUpdate;

  while Columns.Count < ColCount do
    Columns.Add;
  while Columns.Count > ColCount do
    Columns[ColCount].Free;

  while FItemLists.Count > RowCount do
  begin
    ItemLists[FItemLists.Count - 1].Free;
    FItemLists.Delete(FItemLists.Count - 1);
  end;

  while FItemLists.Count < RowCount do
    FItemLists.Add(TSPDisplayItems.Create);

  Columns.EndUpdate;
  ReadItems;
  ResetScrollBar;
end;

procedure TSPTimelinePlanner.ResourcesChange;
begin
  ApplyViewSettings;
  inherited ResourcesChange;
end;

function TSPTimelinePlanner.GetColTimeSpanValue: TDateTime;
begin
  case ColTimeSpan of
    ct30Minutes:
      Result := EncodeTime(0, 30, 0, 0);
    ctHour:
      Result := EncodeTime(1, 0, 0, 0);
    ct1Minute:
      Result := EncodeTime(0, 1, 0, 0);
  else
    Result := 1;
  end;
end;

procedure TSPTimelinePlanner.UpdateScrollBar;
var
  ScrollInfo: TScrollInfo;
  ScrollPos: Integer;
begin
  if HandleAllocated then
  begin
    {$IFNDEF CLR}
    FillChar(ScrollInfo, SizeOf(ScrollInfo), 0);
    {$ENDIF}
    ScrollInfo.cbSize := SizeOf(TScrollInfo);
    ScrollInfo.fMask := SIF_ALL;

    ScrollPos := Trunc((StartTime - FScrollStart) / GetColTimeSpanValue);

    ScrollInfo.nMin := 0;
    ScrollInfo.nPage := ColCount;
    ScrollInfo.nMax := ColCount * VIEW_PAGES - 1;

    if UseRightToLeftAlignment then
      ScrollInfo.nPos :=
        ScrollInfo.nMax - (ScrollPos + Integer(ScrollInfo.nPage) + 1)
    else
      ScrollInfo.nPos := ScrollPos;
    SetScrollInfo(Handle, SB_HORZ, ScrollInfo, True);
  end;
end;

procedure TSPTimelinePlanner.ResetScrollBar;
var
  ScrollOffset: Double;
begin
  ScrollOffset := GetColTimeSpanValue * ColCount * (VIEW_PAGES div 2);
  if StartTime > ScrollOffset then
    SetScrollStart(StartTime - ScrollOffset)
  else
    SetScrollStart(StartTime);
end;

procedure TSPTimelinePlanner.WMHScroll(var Message: TWMHScroll);
begin
  CloseEditor(True);

  case Message.ScrollCode of
    SB_LINELEFT:
      if UseRightToLeftAlignment then
        DoSetStartTime(StartTime + GetScrollTimeSpanValue)
      else
        DoSetStartTime(StartTime - GetScrollTimeSpanValue);
    SB_LINERIGHT:
      if UseRightToLeftAlignment then
        DoSetStartTime(StartTime - GetScrollTimeSpanValue)
      else
        DoSetStartTime(StartTime + GetScrollTimeSpanValue);
    SB_PAGELEFT:
      if UseRightToLeftAlignment then
        DoSetStartTime(StartTime + GetColTimeSpanValue * ColCount)
      else
        DoSetStartTime(StartTime - GetColTimeSpanValue * ColCount);
    SB_PAGERIGHT:
      if UseRightToLeftAlignment then
        DoSetStartTime(StartTime - GetColTimeSpanValue * ColCount)
      else
        DoSetStartTime(StartTime + GetColTimeSpanValue * ColCount);
    SB_THUMBPOSITION,
    SB_THUMBTRACK:
      if UseRightToLeftAlignment then
        DoSetStartTime(FScrollStart +
          GetColTimeSpanValue * (VIEW_PAGES * ColCount - Message.Pos))
      else
        DoSetStartTime(FScrollStart + GetColTimeSpanValue * Message.Pos);
    SB_ENDSCROLL:
      begin
        if FStartTime < FScrollStart + GetColTimeSpanValue * ColCount then
          SetScrollStart(FStartTime - GetColTimeSpanValue * ColCount);
        if FStartTime >
          FScrollStart + GetColTimeSpanValue * ColCount * (VIEW_PAGES - 2) then
            SetScrollStart(FStartTime -
              GetColTimeSpanValue * ColCount * (VIEW_PAGES - 2));
      end;
  end;

  Message.Result := 0;
end;

function TSPTimelinePlanner.GetScrollTimeSpanValue: TDateTime;
begin
  if ColTimeSpan = ctDay then
    Result := 1
  else
    if ColTimeSpan = ct1Minute then
      Result := EncodeTime(0, 1, 0, 0)
    else
      Result := EncodeTime(1, 0, 0, 0);
end;

procedure TSPTimelinePlanner.CreateHandle;
begin
  inherited CreateHandle;
  UpdateScrollBar;
end;

procedure TSPTimelinePlanner.ReadItems;
var
  i: Integer;
  Item: TSPPlanItem;
  ColResources: TStringList;
  ResIndex: Integer;
  List: TSPDisplayItems;
  EndTime: TDateTime;

  procedure ReadItem(AItem: TSPPlanItem; Offset: Double;
    const Resource: string);
  begin
    if CanShowItem(AItem) then
    begin
      if (Resources.Count > 0) and (GroupBy <> grNone) then
        ResIndex := ColResources.IndexOf(Resource)
      else
        ResIndex := 0;

      if ResIndex >= 0 then
      begin
        List := ItemLists[ResIndex];

        if ((AItem.EndTime + Offset) > StartTime) and
          ((AItem.StartTime + Offset) < EndTime) then
          List.Add(AItem, Offset);
      end;
    end;
  end;

begin
  EndTime := StartTime + GetColTimeSpanValue * ColCount;

  for i := 0 to FItemLists.Count - 1 do
  begin
    ItemLists[i].BeginUpdate;
    ItemLists[i].Clear;
    ItemLists[i].CellStart := FStartTime;
    ItemLists[i].CellDuration := GetColTimeSpanValue;
  end;

  ColResources := TStringList.Create;
  try
    for i := 0 to Resources.Count - 1 do
      ColResources.Add(Resources[i].Name);

    if Assigned(DragPlanner) then
    begin
      if Assigned(Source) then
        for i := 0 to Source.Count - 1 do
        begin
          Item := Source[i];

          if Item.StartTime >= EndTime then
            Break;

          if (Item.EndTime > StartTime) and
             ((DragPlanner.Source <> Source) or
              (not DragPlanner.IsItemSelected(Item)) or
              ((GroupBy <> grNone) and (Item.Resource <> DragResourceName))) then
            ReadItem(Item, 0, Item.Resource);
        end;

      for i := 0 to DragPlanner.SelectedCount - 1 do
      begin
        Item := DragPlanner.SelectedItems[i];

        if ((Item.StartTime + DragOffset) < EndTime) and
          ((Item.EndTime + DragOffset) > StartTime) then
          ReadItem(Item, DragOffset, DragResourceName);
      end;
    end else
      if Assigned(Source) then
        for i := 0 to Source.Count - 1 do
        begin
          Item := Source[i];

          if (Item.StartTime) >= TDateTime(EndTime) then
            Break;

          if (Item.EndTime) > TDateTime(StartTime) then
            ReadItem(Item, 0, Item.Resource);
        end;

    for i := 0 to FItemLists.Count - 1 do
      ItemLists[i].EndUpdate;
  finally
    ColResources.Free;
  end;

  RefreshContentView;
end;

function TSPTimelinePlanner.GetItemLists(Index: Integer): TSPDisplayItems;
begin
  Result := TSPDisplayItems(FItemLists[Index]);
end;

function TSPTimelinePlanner.GetCellResource(ACol,
  ARow: Integer): TSPPlannerResource;
begin
  Result := nil;
  if (GroupBy <> grNone) and (Resources.Count > 0) and
    IsCellValid(ACol, ARow) then
      Result := Resources[ARow];
end;

procedure TSPTimelinePlanner.DoInsertItem(Item: TSPPlanItem);
begin
  if (Resources.Count > 0) and (GroupBy <> grNone) then
    Item.Resource := Resources[Selection.Top].Name;

  inherited DoInsertItem(Item);
end;

procedure TSPTimelinePlanner.SourceChanged;
begin
  inherited SourceChanged;
  ReadItems;
  RequestScrollItems;
end;

procedure TSPTimelinePlanner.GetDisplayItemPrintRect(
  DisplayItem: TSPDisplayItem; ACol, ARow: Integer; var ItemRect: TRect;
  var ExtendsBefore, ExtendsAfter: Boolean);
var
  ItemFirstCell, ItemLastCell, FirstCol, LastCol: Integer;
  CellRect: TRect;
begin
  inherited GetDisplayItemPrintRect(DisplayItem, ACol, ARow, ItemRect,
    ExtendsBefore, ExtendsAfter);

  if Assigned(DisplayItem) and (ARow >= 0) and (ARow < RowCount) then
  begin
    CellRect := PrintContentRect;
    CellRect.Top := PrintContentRect .Top + ARow * PrintRowHeight;
    CellRect.Bottom := CellRect.Top + PrintRowHeight;

    ItemFirstCell := DisplayItem.StartCell;
    ItemLastCell := DisplayItem.EndCell;

    if ItemFirstCell < 0 then
    begin
      ItemFirstCell := 0;
      ExtendsBefore := True;
    end;

    if ItemLastCell >= ColCount then
    begin
      ItemLastCell := ColCount - 1;
      ExtendsAfter := True;
    end;

    FirstCol := ItemFirstCell;
    LastCol := ItemLastCell;

    if UseRightToLeftAlignment then
    begin
      ItemRect.Right := CellRect.Right - FirstCol * PrintColWidth;
      ItemRect.Left := CellRect.Right - (LastCol + 1) * PrintColWidth;
    end else
    begin
      ItemRect.Left := PrintContentRect.Left + FirstCol * PrintColWidth;
      ItemRect.Right := PrintContentRect.Left + (LastCol + 1) * PrintColWidth;
    end;

    InflateRect(ItemRect, 0 - PrintLineWidth div 2, 0);

    ItemRect.Top := CellRect.Top + PrintSpacing * 2 +
      (PrintTextHeight + PrintSpacing * 3) * DisplayItem.SpanStart;
    ItemRect.Bottom := ItemRect.Top + PrintTextHeight + PrintSpacing;
  end;
end;

function TSPTimelinePlanner.FindItemAtPos(X, Y: Integer): TSPPlanItem;
var
  i, Col, Row, ResIndex: Integer;
  ItemRect: TRect;
  ItemList: TSPDisplayItems;
  ExtendsBefore, ExtendsAfter: Boolean;
begin
  Result := nil;
  GetCellAtPos(X, Y, Col, Row);

  if IsCellValid(Col, Row) then
  begin
    ResIndex := 0;
    if (GroupBy <> grNone) and (Resources.Count > 0) then
      ResIndex := Row;

    ItemList := ItemLists[ResIndex];
    for i := 0 to ItemList.Count - 1 do
    begin
      GetDisplayItemRect(ItemList[i], Col, Row, ItemRect,
        ExtendsBefore, ExtendsAfter);
      if PtInRect(ItemRect, Point(X, Y)) then
      begin
        Result := ItemList[i].Item;
        Break;
      end;
    end;
  end;
end;

procedure TSPTimelinePlanner.PrintContent(ACanvas: TCanvas; AColor,
  AHeaderColor, AHeaderTextColor, ABorderColor: TColor; APage: Integer);
var
  Row, Col: Integer;
  CellRect, BorderRect: TRect;
  CellColor: TColor;
  ItemList: TSPDisplayItems;
  DisplayItemIndex: Integer;
  DisplayItem: TSPDisplayItem;
  ItemRect, TextRect: TRect;
  ExtendsBefore: Boolean;
  ExtendsAfter: Boolean;
  ItemColor: TColor;
begin
  for Row := 0 to RowCount - 1 do
  begin
    CellRect.Top := PrintContentRect.Top + Row * PrintRowHeight;
    CellRect.Bottom := CellRect.Top + PrintRowHeight;
    CellRect.Left := PrintContentRect.Left;
    CellRect.Right := PrintContentRect.Right;

    CellColor := BackgroundColor;
    if (GroupBy <> grNone) and (Resources.Count > 0) and
      (Resources[Row].Color <> clNone) then
      CellColor := Resources[Row].Color;

    PaintBackground(ACanvas, CellRect, CellColor, True, False);

    for Col := 0 to ColCount - 1 do
    begin
      if UseRightToLeftAlignment then
      begin
        CellRect.Right := PrintContentRect.Right - Col * PrintColWidth;
        CellRect.Left := CellRect.Right - PrintColWidth;
      end else
      begin
        CellRect.Left := PrintContentRect.Left + Col * PrintColWidth;
        CellRect.Right := CellRect.Left + PrintColWidth;
      end;

      DoDrawCell(ACanvas, Col, Row, CellRect, False);

      if Col < Columns.Count - 1 then
      begin
        BorderRect := CellRect;
        if UseRightToLeftAlignment then
          BorderRect.Right := BorderRect.Left + PrintLineWidth
        else
          BorderRect.Left := BorderRect.Right - PrintLineWidth;
        PaintBorder(ACanvas, BorderRect, CellColor,
          Col mod 2 = 1, False);
      end;
    end;

    ItemList := ItemLists[Row];
    for DisplayItemIndex := 0 to ItemList.Count - 1 do
    begin
      DisplayItem := ItemList[DisplayItemIndex];
      GetDisplayItemPrintRect(DisplayItem, 0, Row, ItemRect,
        ExtendsBefore, ExtendsAfter);
      if ItemRect.Bottom < CellRect.Bottom then
      begin
        if not DoDrawItem(DisplayItem.Item, ACanvas, ItemRect,
          ExtendsBefore, ExtendsAfter, False, False, PrintContentRect) then
        begin
          ACanvas.Font := PrintFont;
          ACanvas.Brush.Style := bsClear;

          ItemColor := DisplayItem.Item.Color;
          if ItemColor = clNone then
            ItemColor := clWhite
          else
            ItemColor := GetMidColor(ItemColor, clWhite);

          ACanvas.Brush.Style := bsSolid;
          ACanvas.Brush.Color := ItemColor;
          ACanvas.FillRect(ItemRect);

          TextRect := ItemRect;
          InflateRect(TextRect, 0 - PrintSpacing, 0);

          PrintItemIcons(ACanvas, TextRect, Source.Images,
            DisplayItem.Item.Icons, UseRightToLeftAlignment, ItemColor);

          ACanvas.Brush.Style := bsClear;

          DrawText(ACanvas.Handle,
            {$IFNDEF CLR}PChar{$ENDIF}(DisplayItem.Item.Title), -1, TextRect,
            DrawTextBiDiModeFlags(DT_NOPREFIX));

          ACanvas.Pen.Width := PrintLineWidth;
          ACanvas.Pen.Color := $00404040;
          ACanvas.Polyline([ItemRect.TopLeft,
            Point(ItemRect.Right - 1, ItemRect.Top)]);
          ACanvas.Polyline([Point(ItemRect.Left, ItemRect.Bottom),
            Point(ItemRect.Right - 1, ItemRect.Bottom)]);

          if UseRightToLeftAlignment then
          begin
            if not ExtendsBefore then
              ACanvas.Polyline([Point(ItemRect.Right, ItemRect.Top),
                Point(ItemRect.Right, ItemRect.Bottom - 1)]);
            if not ExtendsAfter then
              ACanvas.Polyline([Point(ItemRect.Left, ItemRect.Top),
                Point(ItemRect.Left, ItemRect.Bottom - 1)]);
          end else
          begin
            if not ExtendsBefore then
              ACanvas.Polyline([Point(ItemRect.Left, ItemRect.Top),
                Point(ItemRect.Left, ItemRect.Bottom - 1)]);
            if not ExtendsAfter then
              ACanvas.Polyline([Point(ItemRect.Right, ItemRect.Top),
                Point(ItemRect.Right, ItemRect.Bottom - 1)]);
          end;
        end;
      end;
    end;

    CellRect.Left := PrintContentRect.Left;
    CellRect.Right := PrintContentRect.Right;
    ACanvas.Brush.Style := bsClear;
    ACanvas.Pen.Style := psSolid;
    ACanvas.Pen.Color := ABorderColor;
    ACanvas.Pen.Width := PrintLineWidth;
    ACanvas.Rectangle(CellRect.Left, CellRect.Top,
      CellRect.Right, CellRect.Bottom);
  end;
end;

function TSPTimelinePlanner.GetItemEditRect(Item: TSPPlanItem; ACol,
  ARow: Integer): TRect;
var
  ExtendsBefore, ExtendsAfter: Boolean;
begin
  Result := inherited GetItemEditRect(Item, ACol, ARow);

  GetItemRect(Item, ACol, ARow, Result, ExtendsBefore, ExtendsAfter);
  if not IsRectEmpty(Result) then
    InflateRect(Result, 0 - CELL_MARGIN, 0 - CELL_MARGIN);
end;

procedure TSPTimelinePlanner.GetCellDates(ACol, ARow: Integer; var StartTime,
  EndTime: TDateTime);
begin
  inherited GetCellDates(ACol, ARow, StartTime, EndTime);

  if IsCellValid(ACol, ARow) then
  begin
    StartTime := FStartTime + ACol * GetColTimeSpanValue;
    EndTime := StartTime + GetColTimeSpanValue;
  end;
end;

function TSPTimelinePlanner.FindDisplayItem(Item: TSPPlanItem; ACol,
  ARow: Integer): TSPDisplayItem;
var
  ItemList: TSPDisplayItems;
  i: Integer;
begin
  Result := nil;

  if IsCellValid(ACol, ARow) then
  begin
    ItemList := ItemLists[ARow];
    for i := 0 to ItemList.Count - 1 do
      if ItemList[i].Item = Item then
      begin
        Result := ItemList[i];
        Break;
      end;
  end;
end;

function TSPTimelinePlanner.ItemHitTest(Item: TSPPlanItem;
  CursorPos: TPoint): TSPItemHit;
var
  Col, Row: Integer;
  ItemRect, R: TRect;
  ExtendsLeft, ExtendsRight: Boolean;
begin
  Result := inherited ItemHitTest(Item, CursorPos);
  if Assigned(Item) then
  begin
    GetCellAtPos(CursorPos.X, CursorPos.Y, Col, Row);

    if UseRightToLeftAlignment then
      GetItemRect(Item, Col, Row, ItemRect, ExtendsRight, ExtendsLeft)
    else
      GetItemRect(Item, Col, Row, ItemRect, ExtendsLeft, ExtendsRight);

    if (Col >= 0) and (Col < Columns.Count) and
      PtInRect(ItemRect, CursorPos) then
    begin
      Result := ihContent;

      R := ItemRect;
      R.Right := R.Left + 3;
      if (not ExtendsLeft) and PtInRect(R, CursorPos) then
        Result := ihLeft
      else
        begin
          R := ItemRect;
          R.Left := R.Right - 3;
          if (not ExtendsRight) and PtInRect(R, CursorPos) then
            Result := ihRight;
        end;

      if Result = ihContent then
      begin
        R := ItemRect;
        R.Top := R.Bottom - 3;
        if PtInRect(R, CursorPos) then
          Result := ihSelect;
      end;
    end;
  end;
end;

procedure TSPTimelinePlanner.GetDisplayItemRect(DisplayItem: TSPDisplayItem;
  ACol, ARow: Integer; var ItemRect: TRect; var ExtendsBefore,
  ExtendsAfter: Boolean);
var
  ItemFirstCell, ItemLastCell, FirstCol, LastCol: Integer;
  CellRect: TRect;
begin
  inherited GetDisplayItemRect(DisplayItem, ACol, ARow, ItemRect,
    ExtendsBefore, ExtendsAfter);

  if Assigned(DisplayItem) and (ARow >= 0) and (ARow < RowCount) then
  begin
    CellRect := ContentRect;
    Inc(CellRect.Top, RowTops[ARow - TopRow]);
    CellRect.Bottom := CellRect.Top + RowHeights[ARow - TopRow];

    ItemFirstCell := DisplayItem.StartCell;
    ItemLastCell := DisplayItem.EndCell;

    if ItemFirstCell < 0 then
    begin
      ItemFirstCell := 0;
      ExtendsBefore := True;
    end;

    if ItemLastCell >= ColCount then
    begin
      ItemLastCell := ColCount - 1;
      ExtendsAfter := True;
    end;

    FirstCol := ItemFirstCell;
    LastCol := ItemLastCell;               

    if UseRightToLeftAlignment then
    begin
      ItemRect.Right := Columns[FirstCol].Right;
      ItemRect.Left := Columns[LastCol].Left + 1;
    end else
    begin
      ItemRect.Left := Columns[FirstCol].Left;
      ItemRect.Right := Columns[LastCol].Right - 1;
    end;

    ItemRect.Top := CellRect.Top + ITEM_SPACING +
      (LineHeight + ITEM_SPACING * 3) * DisplayItem.SpanStart;
    ItemRect.Bottom := ItemRect.Top + LineHeight + ITEM_SPACING * 2;
  end;
end;

procedure TSPTimelinePlanner.PrintBar(ACanvas: TCanvas; AColor, AHeaderColor,
  AHeaderTextColor, ABorderColor: TColor; APage: Integer);
var
  i: Integer;
  CellRect, TextRect: TRect;
  ResText: string;
  TextOffset: Integer;
begin
  inherited PrintBar(ACanvas, AColor, AHeaderColor, AHeaderTextColor,
    ABorderColor, APage);
  ACanvas.Brush.Style := bsClear;
  CellRect := PrintBarRect;
  for i := 0 to RowCount - 1 do
  begin
    CellRect.Top := PrintBarRect.Top + i * PrintRowHeight;
    CellRect.Bottom := CellRect.Top + PrintRowHeight;

    TextRect := CellRect;
    InflateRect(TextRect, 0 - PrintSpacing, 0 - PrintSpacing);
    TextOffset := (TextRect.Bottom - (TextRect.Top + PrintTextHeight)) div 2;
    if TextOffset > 0 then
      Inc(TextRect.Top, TextOffset);

    if (GroupBy <> grNone) and (Resources.Count > 0) then
    begin
      ResText := Resources[i].Name;
      DrawText(ACanvas.Handle,
        {$IFNDEF CLR}PChar{$ENDIF}(ResText),
        Length(ResText), TextRect,
        DrawTextBiDiModeFlags(DT_LEFT or DT_SINGLELINE or DT_NOPREFIX));
    end;

    if i < RowCount - 1 then
      ACanvas.Rectangle(CellRect.Left, CellRect.Top,
        CellRect.Right, CellRect.Bottom);
  end;
end;

procedure TSPTimelinePlanner.PrintHeader(ACanvas: TCanvas; AColor, AHeaderColor,
  AHeaderTextColor, ABorderColor: TColor; APage: Integer);
var
  HeaderText: string;
  ColsPerText, ColsPerHour, ColsPerDayText: Integer;
  RequiredWidth: Integer;
  i: Integer;
  ColHeaderRect: TRect;
  ColDateTime: TDateTime;
  ColYear, ColMonth, ColDay, ColHour, ColMinute: Word;
  TimeString: string;
begin
  if ColTimeSpan = ctDay then
    HeaderText := '00'
  else
    HeaderText := '00:00';
  Canvas.Font := Font;
  RequiredWidth := ACanvas.TextWidth(HeaderText) + PrintSpacing * 2;
  ColsPerText := RequiredWidth div PrintColWidth + 1;
  if (ColsPerText > 1) and (ColsPerText mod 2 = 1) and (ColTimeSpan <> ctDay) then
    Inc(ColsPerText);
  if (ColsPerText = 1) and
    ((ColTimeSpan = ct30Minutes) or (ColTimeSpan = ct1Minute)) then
    ColsPerText := 2;

  ACanvas.Brush.Style := bsSolid;
  ACanvas.Brush.Color := clWhite;
  ACanvas.FillRect(PrintHeaderRect);

  ACanvas.Brush.Style := bsClear;
  ColHeaderRect := PrintHeaderRect;
  ColHeaderRect.Top := ColHeaderRect.Bottom - (PrintTextHeight + PrintSpacing);
  i := 0;
  while i < Columns.Count do
  begin
    if UseRightToLeftAlignment then
    begin
      ColHeaderRect.Right := PrintHeaderRect.Right - i * PrintColWidth;
      if (i + ColsPerText) <= Columns.Count then
        ColHeaderRect.Left :=
          ColHeaderRect.Right - ColsPerText * PrintColWidth
      else
        ColHeaderRect.Left := PrintHeaderRect.Left;
    end else
    begin
      ColHeaderRect.Left := PrintHeaderRect.Left + i * PrintColWidth;
      if (i + ColsPerText) <= Columns.Count then
        ColHeaderRect.Right :=
          ColHeaderRect.Left + ColsPerText * PrintColWidth
      else
        ColHeaderRect.Right := PrintHeaderRect.Right;
    end;

    ColDateTime := StartTime + i * GetColTimeSpanValue;
    DecodeTime(ColDateTime, ColHour, ColMinute, ColMonth, ColDay);
    DecodeDate(ColDateTime, ColYear, ColMonth, ColDay);

    if ColTimeSpan = ctDay then
    begin
      HeaderText := Format('%.2d', [ColDay])
    end else
    begin
      if ColTimeSpan = ct1Minute then
        TimeString := Format(':%.2d', [ColMinute])
      else
        TimeString := ':00';
      if DisplayClockFormat = cf12Hours then
      begin
        if ((i = 0) and (ColTimeSpan <> ct1Minute)) or
          ((ColHour mod 12 = 0) and
            ((ColTimeSpan <> ct1Minute) or (ColMinute mod 60 = 0))) then
        begin
          if ColHour < 12 then
            TimeString := ' ' + SClockAM
          else
            TimeString := ' ' + SClockPM;
        end;
        ColHour := ColHour mod 12;
        if ColHour = 0 then
          ColHour := 12;
      end;
      HeaderText := Format('%.2d%s', [ColHour, TimeString]);
    end;

    InflateRect(ColHeaderRect, 0 - PrintSpacing, 0);
    DrawText(ACanvas.Handle,
      {$IFNDEF CLR}PChar{$ENDIF}(HeaderText),
      Length(HeaderText), ColHeaderRect,
      DrawTextBiDiModeFlags(DT_LEFT or DT_SINGLELINE or DT_NOPREFIX));

    Inc(i, ColsPerText);
  end;

  ColHeaderRect := PrintHeaderRect;
  ColHeaderRect.Bottom := ColHeaderRect.Top + PrintTextHeight;
  OffsetRect(ColHeaderRect, 0, PrintSpacing);
  ACanvas.Font.Style := [fsBold];

  if ColTimeSpan = ct30Minutes then
    ColsPerHour := 2
  else
    if ColTimeSpan = ct1Minute then
      ColsPerHour := 60
    else
      ColsPerHour := 1;

  if ColTimeSpan = ctDay then
    ColsPerText := 1
  else
    ColsPerText := 24 * ColsPerHour;

  i := 0;
  while i < Columns.Count do
  begin
    ColDateTime := StartTime + i * GetColTimeSpanValue;
    DecodeTime(ColDateTime, ColHour, ColYear, ColMonth, ColDay);
    DecodeDate(ColDateTime, ColYear, ColMonth, ColDay);

    if ColTimeSpan = ctDay then
    begin
      ColsPerDayText := MonthDays[IsLeapYear(ColYear), ColMonth] - ColDay + 1;
      HeaderText := FormatDateTime('mmmm yyyy', ColDateTime);
    end else
    begin
      if ColHour > 0 then
        ColsPerDayText := ColsPerText - ColHour * ColsPerHour
      else
        ColsPerDayText := ColsPerText;
      HeaderText := FormatDateTime('dddddd', ColDateTime);
    end;

    if UseRightToLeftAlignment then
    begin
      ColHeaderRect.Right := PrintHeaderRect.Right - i * PrintColWidth;
      if (i + ColsPerText) <= Columns.Count then
        ColHeaderRect.Left :=
          ColHeaderRect.Right - ColsPerText * PrintColWidth
      else
        ColHeaderRect.Left := PrintHeaderRect.Left;
    end else
    begin
      ColHeaderRect.Left := PrintHeaderRect.Left + i * PrintColWidth;
      if (i + ColsPerText) <= Columns.Count then
        ColHeaderRect.Right :=
          ColHeaderRect.Left + ColsPerText * PrintColWidth
      else
        ColHeaderRect.Right := PrintHeaderRect.Right;
    end;

    InflateRect(ColHeaderRect, 0 - PrintSpacing, 0);

    if (i = 0) and
      (ACanvas.TextWidth(HeaderText) >
        ColHeaderRect.Right - ColHeaderRect.Left) then
      DrawText(ACanvas.Handle,
        {$IFNDEF CLR}PChar{$ENDIF}(HeaderText),
        Length(HeaderText), ColHeaderRect,
        DrawTextBiDiModeFlags(DT_RIGHT or DT_SINGLELINE or DT_NOPREFIX))
    else
      DrawText(ACanvas.Handle,
        {$IFNDEF CLR}PChar{$ENDIF}(HeaderText),
        Length(HeaderText), ColHeaderRect,
        DrawTextBiDiModeFlags(DT_LEFT or DT_SINGLELINE or DT_NOPREFIX));

    Inc(i, ColsPerDayText);
  end;

  ACanvas.Rectangle(PrintHeaderRect.Left, PrintHeaderRect.Top,
    PrintHeaderRect.Right, PrintHeaderRect.Bottom);
end;

procedure TSPTimelinePlanner.ScalePrintFont(ACanvas: TCanvas; ARect: TRect);
var
  x, y, MaxItems: Integer;
  DisplayItem: TSPDisplayItem;
begin
  MaxItems := 1;

  for y := 0 to RowCount - 1 do
    for x := 0 to ItemLists[y].Count - 1 do
    begin
      DisplayItem := ItemLists[y][x];
      if DisplayItem.SpanRange > MaxItems then
        MaxItems := DisplayItem.SpanRange;
    end;

  PrintRowLines := MaxItems;

  InitPrintSettings(ACanvas, ARect, True);
  while PrintRowHeight <
    MaxItems * (PrintTextHeight + PrintSpacing * 4) do
  begin
    PrintFont.Size := PrintFont.Size - 1;
    InitPrintSettings(ACanvas, ARect, True);
  end;
end;

procedure TSPTimelinePlanner.DrawItemBorder(ACanvas: TCanvas; BorderRect: TRect;
  Selected, ExtendsBefore, ExtendsAfter: Boolean);
var
  R: TRect;
  Brush: HBrush;
  BorderWidth: Integer;
  DrawLeft, DrawRight: Boolean;
begin
  if Selected then
  begin
    BorderWidth := 2;
    Brush := GetSysColorBrush(COLOR_HIGHLIGHT);
  end else
  begin
    BorderWidth := 1;
    Brush := GetStockObject(GRAY_BRUSH);
  end;

  if UseRightToLeftAlignment then
  begin
    DrawRight := not ExtendsBefore;
    DrawLeft := not ExtendsAfter;
  end else
  begin
    DrawLeft := not ExtendsBefore;
    DrawRight := not ExtendsAfter;
  end;

  R := BorderRect;
  R.Bottom := R.Top + BorderWidth;
  FillRect(ACanvas.Handle, R, Brush);

  R := BorderRect;
  R.Top := R.Bottom - BorderWidth;
  FillRect(ACanvas.Handle, R, Brush);

  if DrawLeft then
  begin
    R := BorderRect;
    R.Right := R.Left + BorderWidth;
    FillRect(ACanvas.Handle, R, Brush);
  end;

  if DrawRight then
  begin
    R := BorderRect;
    R.Left := R.Right - BorderWidth;
    FillRect(ACanvas.Handle, R, Brush);
  end;
end;

procedure TSPTimelinePlanner.SetScrollStart(Value: TDateTime);
begin
  if FScrollStart <> Value then
  begin
    FScrollStart := Value;
    UpdateScrollBar;
    RequestScrollItems;
  end;
end;

procedure TSPTimelinePlanner.DoSetStartTime(Value: TDateTime);
var
  Hour, Minute, Second, MS: Word;
  NewStart, NewScrollStart: TDateTime;
begin
  DecodeTime(Value, Hour, Minute, Second, MS);
  if ColTimeSpan = ctDay then
    NewStart := Trunc(Value)
  else
    if ColTimeSpan = ct1Minute then
      NewStart := Trunc(Value) + EncodeTime(Hour, Minute, 0, 0)
    else
      NewStart := Trunc(Value) + EncodeTime(Hour, 0, 0, 0);
  NewScrollStart := FScrollStart;
  if ColTimeSpan = ctDay then
    NewScrollStart := Trunc(NewScrollStart);
  if FStartTime <> NewStart then
  begin
    FStartTime := NewStart;
    if FStartTime < FScrollStart then
      NewScrollStart := StartTime;
    if FStartTime > FScrollStart +
      (GetColTimeSpanValue * ColCount * (VIEW_PAGES - 1)) then
      NewScrollStart := StartTime -
        (GetColTimeSpanValue * ColCount * (VIEW_PAGES - 1));
    UpdateScrollBar;
    ReadItems;
    SetScrollStart(NewScrollStart);
    Refresh;
  end;
end;

procedure TSPTimelinePlanner.ClockFormatChanged;
begin
  inherited ClockFormatChanged;
  Refresh;
end;

procedure TSPTimelinePlanner.RequestScrollItems;
var
  RequestStart, RequestEnd: TDateTime;
begin
  RequestStart := Trunc(FScrollStart);
  RequestEnd := FScrollStart + GetColTimeSpanValue * ColCount * VIEW_PAGES;
  if Frac(RequestEnd) > 0 then
    RequestEnd := Trunc(RequestEnd) + 1;
  RequestItems(RequestStart, RequestEnd);
end;

end.
