(******************************************************************************)
(* SPDay - Single and multiple day planner                                    *)
(*                                                                            *)
(* Shorter Path Planners                                                      *)
(*                                                                            *)
(* Copyright © 2004, 2007 Shorter Path Software                               *)
(* http://www.shorterpath.com                                                 *)
(******************************************************************************)

unit SPDay;

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
  Classes, Windows, SysUtils, Controls,
  //SPPlanners,
  Graphics;

type
  TSPDayCount = 1..MaxInt;
  TSPDayViewMode = (vmDays, vmOneDay, vmWorkWeek, vmLongWorkWeek, vmWeek);
  TSPTimeScale = (ts5Minutes, ts10Minutes, ts15Minutes, ts20Minutes,
    ts30Minutes, ts1Hour);

  TSPDayPlanner = class(TSPBasePlanner)
  private
    FDate: TDate;
    FDayCount: TSPDayCount;
    FViewMode: TSPDayViewMode;
    FTimeScale: TSPTimeScale;
    FActiveDayStart: TTime;
    FActiveDayEnd: TTime;
    FDayItemLists: TList;
    FItemLists: TList;
    FContentBitmap: TBitmap;
    FMinEndCell: Integer;
    FMaxStartCell: Integer;
    FPrintDayBarWidth: Integer;
    FShowActiveTimeOnly: Boolean;
    FActiveDayFirstRow: Integer;
    FActiveDayRowCount: Integer;
    FShowSubHeader: Boolean;
    procedure ReadItems;
    procedure ApplyViewSettings;
    procedure ApplyViewMode;
    procedure AdjustTopRow;
    procedure SetDate(const Value: TDate);
    procedure SetShowSubHeader(const Value: Boolean);
    procedure SetDayCount(const Value: TSPDayCount);
    procedure SetViewMode(const Value: TSPDayViewMode);
    function IsDayCountStored: Boolean;
    procedure SetTimeScale(const Value: TSPTimeScale);
    procedure SetActiveDayEnd(const Value: TTime);
    procedure SetActiveDayStart(const Value: TTime);
    function GetItemLists(Index: Integer): TSPDisplayItems;
    function GetDayItemLists(Index: Integer): TSPDisplayItems;
    procedure PaintResourceDayItems(ResIndex, CellIndex, CellCount: Integer);
    procedure PrintResourceDayItems(ACanvas: TCanvas; ABorderColor: TColor;
      ResIndex, CellIndex, CellCount: Integer);
    procedure CalcItemLeftRight(DisplayItem: TSPDisplayItem; ColIndex: Integer;
      var Left, Right: Integer);
    procedure CalcItemPrintLeftRight(DisplayItem: TSPDisplayItem; ColIndex: Integer;
      var Left, Right: Integer);
    procedure SetShowActiveTimeOnly(const Value: Boolean);
  protected
    procedure ClockFormatChanged; override;
    procedure PaintBar(ARect: TRect); override;
    procedure PaintContent(ARect: TRect); override;
    procedure PaintHeader(ARect: TRect); override;
    procedure PaintSubHeader(ARect: TRect); override;
    procedure SourceChanged; override;
    function ItemHitTest(Item: TSPPlanItem; CursorPos: TPoint): TSPItemHit; override;
    function GetItemEditRect(Item: TSPPlanItem;
      ACol, ARow: Integer): TRect; override;
    procedure DoInsertItem(Item: TSPPlanItem); override;
    procedure DoWeekStartChange; override;
    procedure ResourcesChange; override;
    function FindDisplayItem(Item: TSPPlanItem;
      ACol, ARow: Integer): TSPDisplayItem; override;
    procedure GetDisplayItemRect(DisplayItem: TSPDisplayItem;
      ACol, ARow: Integer; var ItemRect: TRect;
      var ExtendsBefore, ExtendsAfter: Boolean); override;
    procedure GetDisplayItemPrintRect(DisplayItem: TSPDisplayItem;
      ACol, ARow: Integer; var ItemRect: TRect;
      var ExtendsBefore, ExtendsAfter: Boolean); override;
    procedure InitPrintSettings(ACanvas: TCanvas; ARect: TRect;
      AFit: Boolean); override;
    procedure ScalePrintFont(ACanvas: TCanvas; ARect: TRect); override;
    procedure PrintBar(ACanvas: TCanvas;
      AColor, AHeaderColor, AHeaderTextColor, ABorderColor: TColor;
      APage: Integer); override;
    procedure PrintContent(ACanvas: TCanvas;
      AColor, AHeaderColor, AHeaderTextColor, ABorderColor: TColor;
      APage: Integer); override;
    procedure PrintHeader(ACanvas: TCanvas;
      AColor, AHeaderColor, AHeaderTextColor, ABorderColor: TColor;
      APage: Integer); override;
    procedure PrintSubHeader(ACanvas: TCanvas;
      AColor, AHeaderColor, AHeaderTextColor, ABorderColor: TColor;
      APage: Integer); override;
    property DayItemLists[Index: Integer]: TSPDisplayItems read GetDayItemLists;
    property ItemLists[Index: Integer]: TSPDisplayItems read GetItemLists;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure GetCellDates(ACol, ARow: Integer; var StartTime,
      EndTime: TDateTime); override;
    function GetCellResource(ACol, ARow: Integer): TSPPlannerResource; override;
    function FindItemAtPos(X, Y: Integer): TSPPlanItem; override;
  published
    property Align;
    property AllowInplaceEdit;
    property AllowResize;
    property Anchors;
    property BackgroundColor;
    property Ctl3D default True;
    property BiDiMode;
    property BorderStyle;
    property Constraints;
    property Color;
    property CopyOnDrop;
    property Enabled;
    property Visible;
    property Width default 160;
    property Height default 120;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property PrintFont;
    property ReadOnly;
    property Resources;
    property TabOrder;
    property TabStop default True;
    property PopupMenu;
    property DragMode;
    property DragCursor;
    property Hint;
    property ParentShowHint;
    property ShowHint;
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
    property WeekStart;
    property Source;
    property GroupBy;
    property Filter;
    property ThemeStyle;
    property ShowSubHeader: Boolean read FShowSubHeader write SetShowSubHeader default true;
    property ViewMode: TSPDayViewMode read FViewMode write SetViewMode default vmOneDay;
    property DayCount: TSPDayCount read FDayCount write SetDayCount stored IsDayCountStored;
    property Date: TDate read FDate write SetDate;
    property TimeScale: TSPTimeScale read FTimeScale write SetTimeScale default ts30Minutes;
    property ActiveDayStart: TTime read FActiveDayStart write SetActiveDayStart;
    property ActiveDayEnd: TTime read FActiveDayEnd write SetActiveDayEnd;
    property ShowActiveTimeOnly: Boolean read FShowActiveTimeOnly write SetShowActiveTimeOnly default False;
    property ClockFormat;
    property OnDrawItem;
    property OnDrawCell;
    property OnInsertItem;
    property OnItemHint;
  end;

resourcestring
  SActiveDayError = 'ActiveDayEnd cannot be smaller than ActiveDayStart';

implementation

uses
  CommCtrl
  {$IFNDEF VCL4}
  {$IFNDEF VCL5}
  , Types
  {$ENDIF}
  {$ENDIF}
  ;

const
  RowsPerHour: array[TSPTimeScale] of Integer = (12, 6, 4, 3, 2, 1);
  MinutesPerRow: array[TSPTimeScale] of Integer = (5, 10, 15, 20, 30, 60);

const
  DAY_BAR_WIDTH = 5;
  CELL_MARGIN = 2;
  ITEM_SPACING = 3;
  DAY_ITEM_SPACING = 2;

{ TSPDayPlanner }

procedure TSPDayPlanner.AdjustTopRow;
begin
  TopRow := Trunc((Frac(ActiveDayStart) + EncodeTime(0, 0, 0, 1)) /
    (MinutesPerRow[FTimeScale] * EncodeTime(0, 1, 0, 0)));
end;

procedure TSPDayPlanner.ApplyViewMode;
const
  ModeDays: array[vmOneDay..vmWeek] of Integer = (1, 5, 6, 7);
var
  RequiredDay, RequestedDay: Integer;
  h, m, s, ms: Word;
  LastRow: Integer;
begin
  if FViewMode <> vmDays then
  begin
    FDayCount := ModeDays[FViewMode];
    if FViewMode <> vmOneDay then
    begin
      RequiredDay := 1;
      if WeekStart = wsMonday then
        RequiredDay := 2;
      RequestedDay := DayOfWeek(TDateTime(FDate));

      FDate := FDate - (RequestedDay - RequiredDay);
      if RequestedDay < RequiredDay then
        FDate := FDate - 7;
    end;
  end;

  DecodeTime(TDateTime(ActiveDayStart), h, m, s, ms);
  FActiveDayFirstRow := (h * 60 + m) div MinutesPerRow[TimeScale];
  DecodeTime(TDateTime(ActiveDayEnd), h, m, s, ms);
  LastRow := (h * 60 + m) div MinutesPerRow[TimeScale];
  if (LastRow > FActiveDayFirstRow) and (m mod MinutesPerRow[TimeScale] = 0) then
    Dec(LastRow);
  FActiveDayRowCount := 1 + LastRow - FActiveDayFirstRow;

  if FShowActiveTimeOnly then
    SetRowCount(FActiveDayRowCount)
  else
    SetRowCount(RowsPerHour[FTimeScale] * 24);

  ResourcesChange;
  RequestItems(Trunc(FDate), Trunc(FDate) + DayCount);
end;

procedure TSPDayPlanner.ApplyViewSettings;
var
  NewSelection: TRect;
begin
 
  if (GroupBy <> grNone) and (Resources.Count > 0) then
    HeaderRows := 2
  else
    HeaderRows := 1;


  if FTimeScale = ts1Hour then
    BarCols := 8
  else
    BarCols := 10;

  NewSelection := Selection;
  if NewSelection.Left >= Columns.Count then
    NewSelection.Left := Columns.Count - 1;
  if NewSelection.Right >= Columns.Count then
    NewSelection.Right := Columns.Count - 1;
  if NewSelection.Bottom >= RowCount then
    NewSelection.Bottom := RowCount - 1;
  if NewSelection.Top > NewSelection.Bottom then
    NewSelection.Top := NewSelection.Bottom;
  Selection := NewSelection;

  ReadItems;
end;

procedure TSPDayPlanner.CalcItemLeftRight(DisplayItem: TSPDisplayItem;
  ColIndex: Integer; var Left, Right: Integer);
var
  SpanPartWidth, ItemPartWidth: Integer;
begin
  SpanPartWidth := (Columns[ColIndex].Right - Columns[ColIndex].Left) -
    (DAY_BAR_WIDTH - ITEM_SPACING);
  if DisplayItem.SpanRange > 0 then
    SpanPartWidth := SpanPartWidth div DisplayItem.SpanRange;

  if DisplayItem.SpanEnd > DisplayItem.SpanStart then
    ItemPartWidth := DisplayItem.SpanEnd - DisplayItem.SpanStart
  else
    ItemPartWidth := 1;

  if UseRightToLeftAlignment then
  begin
    Right := Columns[ColIndex].Right - SpanPartWidth * DisplayItem.SpanStart;
    Left := Right - (ItemPartWidth * SpanPartWidth - ITEM_SPACING);
  end else
  begin
    Left := Columns[ColIndex].Left + SpanPartWidth * DisplayItem.SpanStart;
    Right := Left + ItemPartWidth * SpanPartWidth - ITEM_SPACING;
  end;
end;

procedure TSPDayPlanner.CalcItemPrintLeftRight(DisplayItem: TSPDisplayItem;
  ColIndex: Integer; var Left, Right: Integer);
var
  ColLeft, ColRight, SpanPartWidth, ItemPartWidth: Integer;
begin
  if UseRightToLeftAlignment then
  begin
    ColRight := PrintContentRect.Right - ColIndex * PrintColWidth;
    ColLeft := ColRight - PrintColWidth;
  end else
  begin
    ColLeft := PrintContentRect.Left + ColIndex * PrintColWidth;
    ColRight := ColLeft + PrintColWidth;
  end;

  SpanPartWidth := (ColRight - ColLeft) -
    (FPrintDayBarWidth - PrintSpacing);
  if DisplayItem.SpanRange > 0 then
    SpanPartWidth := SpanPartWidth div DisplayItem.SpanRange;

  if DisplayItem.SpanEnd > DisplayItem.SpanStart then
    ItemPartWidth := DisplayItem.SpanEnd - DisplayItem.SpanStart
  else
    ItemPartWidth := 1;

  if UseRightToLeftAlignment then
  begin
    Right := ColRight - SpanPartWidth * DisplayItem.SpanStart;
    Left := Right - (ItemPartWidth * SpanPartWidth - PrintSpacing);
  end else
  begin
    Left := ColLeft + SpanPartWidth * DisplayItem.SpanStart;
    Right := Left + ItemPartWidth * SpanPartWidth - PrintSpacing;
  end;
end;

procedure TSPDayPlanner.ClockFormatChanged;
begin
  inherited ClockFormatChanged;
  ApplyViewMode;
end;

constructor TSPDayPlanner.Create(AOwner: TComponent);
begin
  FDayItemLists := TList.Create;
  FItemLists := TList.Create;

  inherited Create(AOwner);
  Ctl3D := True;
  Width := 160;
  Height := 120;
  TabStop := True;
  ShowSubHeader := true;

  HeaderRows := 1;
  SubHeaderRows := 0;
  FooterRows := 0;
  SetAutoSizeRows(False);
  FActiveDayStart := TTime(EncodeTime(8, 0, 0, 0));
  FActiveDayEnd := TTime(EncodeTime(17, 0, 0, 0));
  ViewMode := vmOneDay;
  TimeScale := ts30Minutes;
  Date := TDate(Now);
  DragAllDayItems := True;
end;

destructor TSPDayPlanner.Destroy;
var
  i: Integer;
begin
  for i := 0 to FItemLists.Count - 1 do
    ItemLists[i].Free;
  FItemLists.Free;

  for i := 0 to FDayItemLists.Count - 1 do
    DayItemLists[i].Free;
  FDayItemLists.Free;

  if Assigned(FContentBitmap) then
  begin
    FContentBitmap.Free;
    FContentBitmap := nil;
  end;
    
  inherited Destroy;
end;

procedure TSPDayPlanner.DoInsertItem(Item: TSPPlanItem);
begin
  if Resources.Count > 0 then
    case GroupBy of
      grDate:
        Item.Resource := Resources[Selection.Left mod Resources.Count].Name;
      grResource:
        Item.Resource := Resources[Selection.Left div DayCount].Name;
    end;

  inherited DoInsertItem(Item);
end;

procedure TSPDayPlanner.DoWeekStartChange;
begin
  ApplyViewMode;
  inherited DoWeekStartChange;
end;

function TSPDayPlanner.FindDisplayItem(Item: TSPPlanItem;
  ACol, ARow: Integer): TSPDisplayItem;
var
  ItemList: TSPDisplayItems;
  i, ResIndex: Integer;
begin
  ItemList := nil;
  Result := nil;

  if ACol >= 0 then
  begin
    if ARow >= 0 then
      ItemList := ItemLists[ACol]
    else
      if ARow = SUB_HEADER_ROW then
      begin
        ResIndex := 0;
        if (Resources.Count > 0) and (GroupBy <> grNone) then
          case GroupBy of
            grDate:
                ResIndex := ACol mod Resources.Count;
            grResource:
                ResIndex := ACol div DayCount;
          end;
        ItemList := DayItemLists[ResIndex];
      end;
  end;

  if Assigned(ItemList) then
    for i := 0 to ItemList.Count - 1 do
      if ItemList[i].Item = Item then
      begin
        Result := ItemList[i];
        Break;
      end;
end;

function TSPDayPlanner.FindItemAtPos(X, Y: Integer): TSPPlanItem;
var
  i, Col, Row, ResIndex, CellIndex: Integer;
  ItemRect: TRect;
  ItemList: TSPDisplayItems;
  DisplayItem: TSPDisplayItem;
begin
  Result := nil;
  GetCellAtPos(X, Y, Col, Row);
  if (Col >= 0) then
  begin
    if (Row >= 0) then
    begin
      ItemList := ItemLists[Col];
      for i := 0 to ItemList.Count - 1 do
      begin
        DisplayItem := ItemList[i];
        if (DisplayItem.EndCell >= Row) and (DisplayItem.StartCell <= Row) then
        begin
          CalcItemLeftRight(DisplayItem, Col, ItemRect.Left, ItemRect.Right);
          if (X >= ItemRect.Left) and (X <= ItemRect.Right) then
          begin
            Result := DisplayItem.Item;
            Break;
          end;
        end;
      end;
    end else
    if (Row = SUB_HEADER_ROW) then
    begin
      ResIndex := 0;
      CellIndex := Col;
      if (Resources.Count > 0) and (GroupBy <> grNone) then
        case GroupBy of
          grDate:
            begin
              ResIndex := Col mod Resources.Count;
              CellIndex := Col div Resources.Count;
            end;
          grResource:
            begin
              ResIndex := Col div DayCount;
              CellIndex := Col mod DayCount;
            end;
        end;

      ItemList := DayItemLists[ResIndex];
      for i := 0 to ItemList.Count - 1 do
      begin
        DisplayItem := ItemList[i];
        if (DisplayItem.EndCell >= CellIndex) and
          (DisplayItem.StartCell <= CellIndex) then
        begin
          ItemRect.Top := SubHeaderRect.Top + DAY_ITEM_SPACING +
            DisplayItem.SpanStart *
              (LineHeight + CELL_MARGIN * 2 + DAY_ITEM_SPACING);
          ItemRect.Bottom := ItemRect.Top + CELL_MARGIN * 2 + LineHeight;

          if UseRightToLeftAlignment then
          begin
            ItemRect.Right := Columns[Col].Right;
            ItemRect.Left := Columns[Col].Left;
            if DisplayItem.StartCell >= CellIndex then
              Dec(ItemRect.Right, DAY_ITEM_SPACING);
            if DisplayItem.EndCell <= CellIndex then
              Inc(ItemRect.Left, DAY_ITEM_SPACING + 1);
          end else
          begin
            ItemRect.Left := Columns[Col].Left;
            ItemRect.Right := Columns[Col].Right;
            if DisplayItem.StartCell >= CellIndex then
              Inc(ItemRect.Left, DAY_ITEM_SPACING);
            if DisplayItem.EndCell <= CellIndex then
              Dec(ItemRect.Right, DAY_ITEM_SPACING + 1);
          end;

          if PtInRect(ItemRect, Point(X, Y)) then
          begin
            Result := DisplayItem.Item;
            Break;
          end;
        end;
      end;
    end;
  end;
end;

procedure TSPDayPlanner.GetCellDates(ACol, ARow: Integer; var StartTime,
  EndTime: TDateTime);
begin
  inherited GetCellDates(ACol, ARow, StartTime, EndTime);

  if IsCellValid(ACol, ARow) then
  begin
    if ARow >= 0 then
    begin
      StartTime := ItemLists[ACol].CellStart +
        ARow * ItemLists[ACol].CellDuration;
      EndTime := StartTime + ItemLists[ACol].CellDuration;
    end else
    begin
      StartTime := ItemLists[ACol].CellStart;
      EndTime := StartTime + 1;
    end;
  end;
end;

function TSPDayPlanner.GetCellResource(ACol,
  ARow: Integer): TSPPlannerResource;
begin
  Result := nil;
  if (GroupBy <> grNone) and (Resources.Count > 0) and (ACol >= 0) and
    (ARow >= SUB_HEADER_ROW) then
    case GroupBy of
      grDate:
        Result := Resources[ACol mod Resources.Count];
      grResource:
        Result := Resources[ACol div DayCount];
    end;
end;

function TSPDayPlanner.GetDayItemLists(Index: Integer): TSPDisplayItems;
begin
  Result := TSPDisplayItems(FDayItemLists[Index]);
end;

procedure TSPDayPlanner.GetDisplayItemPrintRect(
  DisplayItem: TSPDisplayItem; ACol, ARow: Integer; var ItemRect: TRect;
  var ExtendsBefore, ExtendsAfter: Boolean);
var
  ItemFirstCell, ItemLastCell, ResIndex, FirstCell, LastCell,
  FirstCol, LastCol, ItemFirstCol, ItemLastCol: Integer;
  CellRect: TRect;
begin
  inherited GetDisplayItemPrintRect(DisplayItem, ACol, ARow, ItemRect,
    ExtendsBefore, ExtendsAfter);

  if Assigned(DisplayItem) then
  begin
    if ARow >= 0 then
    begin
      CalcItemPrintLeftRight(DisplayItem, ACol, ItemRect.Left, ItemRect.Right);
      ItemFirstCell := DisplayItem.StartCell;
      if ItemFirstCell < 0 then
        ItemFirstCell := 0;
      ItemLastCell := DisplayItem.EndCell;
      if ItemLastCell >= RowCount then
        ItemLastCell := RowCount - 1;

      ItemRect.Top := (ItemFirstCell) * PrintRowHeight +
        PrintContentRect.Top;
      ItemRect.Bottom := (ItemLastCell + 1) * PrintRowHeight +
        PrintContentRect.Top - 1;

      ExtendsBefore := ItemFirstCell > DisplayItem.StartCell;
      ExtendsAfter := ItemLastCell < DisplayItem.EndCell;
    end else
    begin
      FirstCol := 0;
      LastCol := Columns.Count - 1;
      FirstCell := 0;
      LastCell := LastCol;
      if (Resources.Count > 0) and (GroupBy <> grNone) then
        case GroupBy of
          grDate:
            begin
              FirstCell := ACol div Resources.Count;
              LastCell := FirstCell;
              FirstCol := ACol;
              LastCol := FirstCol;
            end;
          grResource:
            begin
              ResIndex := ACol div DayCount;
              FirstCol := ResIndex * DayCount;
              LastCol := FirstCol + DayCount - 1;
              LastCell := DayCount - 1;
            end;
        end;

        CellRect := PrintSubHeaderRect;

        if UseRightToLeftAlignment then
        begin
          CellRect.Right := PrintContentRect.Right - FirstCol * PrintColWidth;
          CellRect.Left := PrintContentRect.Right - (LastCol + 1) * PrintColWidth;
        end else
        begin
          CellRect.Left := PrintContentRect.Left + FirstCol * PrintColWidth;
          CellRect.Right := PrintContentRect.Left + (LastCol + 1) * PrintColWidth;
        end;

        if (DisplayItem.EndCell >= FirstCell) and
          (DisplayItem.StartCell <= LastCell) then
        begin
          ItemFirstCol := FirstCol + DisplayItem.StartCell - FirstCell;
          ItemLastCol := FirstCol + DisplayItem.EndCell - FirstCell;

          ExtendsBefore := DisplayItem.StartCell < FirstCell;
          ExtendsAfter := DisplayItem.EndCell > LastCell;

          if ExtendsBefore then
            ItemFirstCol := FirstCol;
          if ExtendsAfter then
            ItemLastCol := LastCol;

          ItemRect := CellRect;
          ItemRect.Top := CellRect.Top + PrintSpacing * 2 +
            DisplayItem.SpanStart * (PrintTextHeight + PrintSpacing * 4);
          ItemRect.Bottom := ItemRect.Top + PrintSpacing * 2 + PrintTextHeight;
          if UseRightToLeftAlignment then
          begin
            ItemRect.Right := PrintContentRect.Right - ItemFirstCol * PrintColWidth;
            ItemRect.Left := PrintContentRect.Right - (ItemLastCol + 1) * PrintColWidth;
            if not ExtendsBefore then
              Dec(ItemRect.Right, PrintSpacing * 4);
            if not ExtendsAfter then
              Inc(ItemRect.Left, PrintSpacing * 4);
          end else
          begin
            ItemRect.Left := PrintContentRect.Left + ItemFirstCol * PrintColWidth;
            ItemRect.Right := PrintContentRect.Left + (ItemLastCol + 1) * PrintColWidth;
            if not ExtendsBefore then
              Inc(ItemRect.Left, PrintSpacing * 4);
            if not ExtendsAfter then
              Dec(ItemRect.Right, PrintSpacing * 4);
          end;
        end;
    end;
  end;
end;

procedure TSPDayPlanner.GetDisplayItemRect(DisplayItem: TSPDisplayItem;
  ACol, ARow: Integer; var ItemRect: TRect;
  var ExtendsBefore, ExtendsAfter: Boolean);
var
  ItemFirstCell, ItemLastCell, ResIndex, FirstCell, LastCell,
  FirstCol, LastCol, ItemFirstCol, ItemLastCol: Integer;
  CellRect: TRect;
begin
  inherited GetDisplayItemRect(DisplayItem, ACol, ARow, ItemRect,
    ExtendsBefore, ExtendsAfter);

  if Assigned(DisplayItem) then
  begin
    if ARow >= 0 then
    begin
      CalcItemLeftRight(DisplayItem, ACol, ItemRect.Left, ItemRect.Right);
      ItemFirstCell := DisplayItem.StartCell;
      if ItemFirstCell < 0 then
        ItemFirstCell := 0;
      ItemLastCell := DisplayItem.EndCell;
      if ItemLastCell >= RowCount then
        ItemLastCell := RowCount - 1;

      ItemRect.Top := (ItemFirstCell - TopRow) * RowHeights[0] +
        ContentRect.Top;
      ItemRect.Bottom := (ItemLastCell + 1 - TopRow) * RowHeights[0] +
        ContentRect.Top - 1;

      ExtendsBefore := ItemFirstCell > DisplayItem.StartCell;
      ExtendsAfter := ItemLastCell < DisplayItem.EndCell;
    end else
    begin
      FirstCol := 0;
      LastCol := Columns.Count - 1;
      FirstCell := 0;
      LastCell := LastCol;
      if (Resources.Count > 0) and (GroupBy <> grNone) then
        case GroupBy of
          grDate:
            begin
              FirstCell := ACol div Resources.Count;
              LastCell := FirstCell;
              FirstCol := ACol;
              LastCol := FirstCol;
            end;
          grResource:
            begin
              ResIndex := ACol div DayCount;
              FirstCol := ResIndex * DayCount;
              LastCol := FirstCol + DayCount - 1;
              LastCell := DayCount - 1;
            end;
        end;

        CellRect := SubHeaderRect;

        if UseRightToLeftAlignment then
        begin
          CellRect.Right := Columns[FirstCol].Right;
          CellRect.Left := Columns[LastCol].Left;
        end else
        begin
          CellRect.Left := Columns[FirstCol].Left;
          CellRect.Right := Columns[LastCol].Right;
        end;

        if (DisplayItem.EndCell >= FirstCell) and
          (DisplayItem.StartCell <= LastCell) then
        begin
          ItemFirstCol := FirstCol + DisplayItem.StartCell - FirstCell;
          ItemLastCol := FirstCol + DisplayItem.EndCell - FirstCell;

          ExtendsBefore := DisplayItem.StartCell < FirstCell;
          ExtendsAfter := DisplayItem.EndCell > LastCell;

          if ExtendsBefore then
            ItemFirstCol := FirstCol;
          if ExtendsAfter then
            ItemLastCol := LastCol;

          ItemRect := CellRect;
          ItemRect.Top := CellRect.Top + DAY_ITEM_SPACING + DisplayItem.SpanStart *
            (LineHeight + CELL_MARGIN * 2 + DAY_ITEM_SPACING);
          ItemRect.Bottom := ItemRect.Top + CELL_MARGIN * 2 + LineHeight;
          if UseRightToLeftAlignment then
          begin
            ItemRect.Right := Columns[ItemFirstCol].Right;
            ItemRect.Left := Columns[ItemLastCol].Left;
            if not ExtendsBefore then
              Dec(ItemRect.Right, DAY_ITEM_SPACING);
            if not ExtendsAfter then
              Inc(ItemRect.Left, DAY_ITEM_SPACING + 1);
          end else
          begin
            ItemRect.Left := Columns[ItemFirstCol].Left;
            ItemRect.Right := Columns[ItemLastCol].Right;
            if not ExtendsBefore then
              Inc(ItemRect.Left, DAY_ITEM_SPACING);
            if not ExtendsAfter then
              Dec(ItemRect.Right, DAY_ITEM_SPACING + 1);
          end;
        end;
    end;
  end;
end;

function TSPDayPlanner.GetItemEditRect(Item: TSPPlanItem; ACol,
  ARow: Integer): TRect;
var
  R: TRect;
  ExtendsBefore, ExtendsAfter, ShowRect: Boolean;
begin
  Result := inherited GetItemEditRect(Item, ACol, ARow);
  if Assigned(Item) then
  begin
    GetItemRect(Item, ACol, ARow, R, ExtendsBefore, ExtendsAfter);
    if ARow >= 0 then
      ShowRect := IntersectRect(R, R, ContentRect)
    else
      ShowRect := IntersectRect(R, R, SubHeaderRect);
    if ShowRect then
    begin
      InflateRect(R, -2, -2);
      if ARow >= 0 then
      begin
        if UseRightToLeftAlignment then
          Dec(R.Right, DAY_BAR_WIDTH)
        else
          Inc(R.Left, DAY_BAR_WIDTH);
      end;
      Result := R;
    end;
  end;
end;

function TSPDayPlanner.GetItemLists(Index: Integer): TSPDisplayItems;
begin
  Result := TSPDisplayItems(FItemLists[Index]);
end;

procedure TSPDayPlanner.InitPrintSettings(ACanvas: TCanvas; ARect: TRect;
  AFit: Boolean);
begin
  inherited InitPrintSettings(ACanvas, ARect, AFit);
  FPrintDayBarWidth := GetDeviceCaps(ACanvas.Handle, LOGPIXELSX) div 20;
  if FPrintDayBarWidth < DAY_BAR_WIDTH then
    FPrintDayBarWidth := DAY_BAR_WIDTH;
end;

function TSPDayPlanner.IsDayCountStored: Boolean;
begin
  Result := (FViewMode = vmDays);
end;

function TSPDayPlanner.ItemHitTest(Item: TSPPlanItem;
  CursorPos: TPoint): TSPItemHit;
var
  Col, Row: Integer;
  ItemRect, R: TRect;
  ExtendsBefore, ExtendsAfter: Boolean;
  ExtendsLeft, ExtendsRight: Boolean;
begin
  Result := inherited ItemHitTest(Item, CursorPos);
  if Assigned(Item) then
  begin
    GetCellAtPos(CursorPos.X, CursorPos.Y, Col, Row);
    GetItemRect(Item, Col, Row, ItemRect, ExtendsBefore, ExtendsAfter);

    if (Col >= 0) and (Col < Columns.Count) and
      PtInRect(ItemRect, CursorPos) then
    begin
      Result := ihContent;
      if Row >= 0 then
      begin
        R := ItemRect;
        R.Bottom := R.Top + 4;
        if (not ExtendsBefore) and PtInRect(R, CursorPos) then
          Result := ihTop
        else
          begin
            R := ItemRect;
            R.Top := R.Bottom - 4;
            if (not ExtendsAfter) and PtInRect(R, CursorPos) then
              Result := ihBottom
            else
              begin
                R := ItemRect;
                if UseRightToLeftAlignment then
                  R.Left := R.Right - (DAY_BAR_WIDTH + 1)
                else
                  R.Right := R.Left + DAY_BAR_WIDTH + 1;
                if PtInRect(R, CursorPos) then
                  Result := ihSelect;
              end;
          end;
      end else
      begin
        if UseRightToLeftAlignment then
        begin
          ExtendsLeft := ExtendsAfter;
          ExtendsRight := ExtendsBefore;
        end else
        begin
          ExtendsLeft := ExtendsBefore;
          ExtendsRight := ExtendsAfter;
        end;

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
      end;
    end;
  end;
end;

procedure TSPDayPlanner.PaintBar(ARect: TRect);
var
  i, Hours, Minutes: Integer;
  LineWidth, TextWidth: Integer;
  s, AMPM: string;
  TextRect, LargeTextRect: TRect;
  LargeHeight, HourTop, RowHeight, VisibleRows: Integer;
  Flags: Integer;
  LastRow, FirstHour, LastHour: Integer;
begin
  inherited PaintBar(ARect);

  RowHeight := RowHeights[0];

  Canvas.Brush.Style := bsClear;
  Canvas.Font := Font;
  Canvas.Pen.Style := psSolid;
  Canvas.Pen.Width := 0;
  Canvas.Pen.Color := clBtnShadow;

  if TimeScale = ts1Hour then
  begin
    LineWidth := CharWidth * 8;
    TextWidth := CharWidth * 7;
  end else
  begin
    LineWidth := CharWidth *4;
    TextWidth := CharWidth *4;
  end;

  LastRow := RowCount - 1;
  if FShowActiveTimeOnly then
    LastRow := FActiveDayRowCount - 1;

  for i := TopRow to LastRow do
  begin
    if FShowActiveTimeOnly then
      Minutes := MinutesPerRow[TimeScale] * (i + FActiveDayFirstRow)
    else
      Minutes := MinutesPerRow[TimeScale] * i;
    Hours := Minutes div 60;
    Minutes := Minutes mod 60;

    if (DisplayClockFormat = cf12Hours) and
      ((i = TopRow) or ((Hours = 12) and (Minutes = 0))) then
    begin
      if Hours >= 12 then
        AMPM := SClockPM
      else
        AMPM := SClockAM;

      Hours := Hours mod 12;
      if Hours = 0 then
        Hours := 12;

      if TimeScale = ts1Hour then
        s := Format('%.d %s', [Hours, AMPM])
      else
      begin
        s := AMPM;
        if ((i + 1) mod RowsPerHour[TimeScale]) = 0 then
          LineWidth := (ARect.Right - ARect.Left) - CharWidth
        else
          LineWidth := CharWidth *4;
      end;
    end else
    begin
      if TimeScale = ts1Hour then
      begin
        if DisplayClockFormat = cf12Hours then
          s := Format('%.d:00', [Hours])
        else
          s := Format('%.2d:00', [Hours]);
      end else
      begin
        s := Format('%.2d', [Minutes]);
        if FShowActiveTimeOnly then
        begin
          if ((i + 1 + FActiveDayFirstRow) mod RowsPerHour[TimeScale]) = 0 then
            LineWidth := (ARect.Right - ARect.Left) - CharWidth
          else
            LineWidth := CharWidth *4;
        end else
        begin
          if ((i + 1) mod RowsPerHour[TimeScale]) = 0 then
            LineWidth := (ARect.Right - ARect.Left) - CharWidth
          else
            LineWidth := CharWidth *4;
        end;
      end;
    end;

    TextRect := ARect;
    TextRect.Top := ARect.Top + (i - TopRow) * RowHeight;
    TextRect.Bottom := TextRect.Top + RowHeight;
    if UseRightToLeftAlignment then
      TextRect.Right := TextRect.Left + TextWidth
    else
      TextRect.Left := TextRect.Right - TextWidth;

    InflateRect(TextRect, 0, -3);
    DrawText(Canvas.Handle, {$IFNDEF CLR}PChar{$ENDIF}(s), Length(s), TextRect,
      DT_CENTER or DT_SINGLELINE or DT_NOPREFIX);

    TextRect := ARect;
    TextRect.Top := ARect.Top + (i - TopRow) * RowHeight;
    TextRect.Bottom := TextRect.Top + RowHeight;
    if UseRightToLeftAlignment then
      TextRect.Right := TextRect.Left + LineWidth
    else
      TextRect.Left := TextRect.Right - LineWidth;

    Canvas.Polyline([
      Point(TextRect.Left, TextRect.Bottom - 1),
      Point(TextRect.Right, TextRect.Bottom - 1)]);
  end;

  if TimeScale <> ts1Hour then
  begin
    TextRect := ARect;
    Canvas.Font.Size := Canvas.Font.Size * 2;
    if UseRightToLeftAlignment then
    begin
      TextRect.Left := ARect.Left + CharWidth * 5;
      TextRect.Right := TextRect.Left + Canvas.TextWidth('00');
    end else
    begin
      TextRect.Right := ARect.Right - CharWidth * 5;
      TextRect.Left := TextRect.Right - Canvas.TextWidth('00');
    end;

    LargeHeight := Canvas.TextHeight('0');
    HourTop := ((RowHeight * RowsPerHour[TimeScale]) - LargeHeight) div 2;

    if FShowActiveTimeOnly then
    begin
      FirstHour := FActiveDayFirstRow div RowsPerHour[TimeScale];
      LastHour :=
        (FActiveDayFirstRow + FActiveDayRowCount - 1) div RowsPerHour[TimeScale];
    end else
    begin
      FirstHour := 0;
      LastHour := 23;
    end;
    for i := FirstHour to LastHour do
    begin
      if DisplayClockFormat = cf12Hours then
      begin
        if i mod 12 = 0 then
          s := '12'
        else
          s := Format('%.d', [i mod 12]);
      end else
        s := Format('%.2d', [i]);
      TextRect.Top :=
        ARect.Top + (i * RowsPerHour[TimeScale] - TopRow) * RowHeight + HourTop;
      if FShowActiveTimeOnly then
        Dec(TextRect.Top, FActiveDayFirstRow * RowHeight);
      
      TextRect.Bottom := TextRect.Top + LargeHeight;

      if IntersectRect(LargeTextRect, ARect, TextRect) then
      begin
        if UseRightToLeftAlignment then
          Flags := DT_LEFT or DT_SINGLELINE
        else
          Flags := DT_RIGHT or DT_SINGLELINE;
        if TextRect.Top < LargeTextRect.Top then
          Flags := Flags or DT_BOTTOM;
        DrawText(Canvas.Handle, {$IFNDEF CLR}PChar{$ENDIF}(s), Length(s),
          LargeTextRect, Flags or DT_NOPREFIX);
      end;
    end;

    Canvas.Font := Font;
  end;

  VisibleRows := (ContentRect.Bottom - ContentRect.Top) div RowHeight;
  DrawBarMoreBitmaps(Canvas, ARect, (TopRow > FMinEndCell),
    ((TopRow + VisibleRows) < FMaxStartCell), UseRightToLeftAlignment);
end;

procedure TSPDayPlanner.PaintContent(ARect: TRect);
var
  i, x, ActiveTop, ActiveBottom, RowHeight: Integer;
  R, CellRect: TRect;
  BackColor: TColor;
  ItemList: TSPDisplayItems;
  ItemRect, ItemBarRect, ItemDataRect: TRect;
  DisplayItemIndex: Integer;
  DisplayItem: TSPDisplayItem;
  CurRow, HighRow: Integer;
  ExtendsBefore, ExtendsAfter, ItemSelected: Boolean;
  Iext : Longint;
  TextToWrite : String;

begin
  if not Assigned(FContentBitmap) then
  begin
    FContentBitmap := TBitmap.Create;
    FContentBitmap.Width := ClientWidth + 32;
    FContentBitmap.Height := ClientHeight + 32;
  end else
  begin
    if (ClientWidth > FContentBitmap.Width) or
      (ClientWidth + 32 < FContentBitmap.Width) then
        FContentBitmap.Width := ClientWidth + 32;
    if (ClientHeight > FContentBitmap.Height) or
      (ClientHeight + 32 < FContentBitmap.Height) then
        FContentBitmap.Height := ClientHeight + 32;
  end;

  FContentBitmap.Canvas.Pen.Width := 0;
  FContentBitmap.Canvas.Pen.Style := psSolid;
  FContentBitmap.Canvas.Pen.Color := clGray;
  FContentBitmap.Canvas.Font := Font;

  RowHeight := RowHeights[0];

  if FShowActiveTimeOnly then
  begin
    ActiveTop := (0 - TopRow) * RowHeight + ARect.Top;
    ActiveBottom := (FActiveDayRowCount - TopRow) * RowHeight + ARect.Top;
  end else
  begin
    ActiveTop := (FActiveDayFirstRow - TopRow) * RowHeight + ARect.Top;
    ActiveBottom :=
      (FActiveDayFirstRow + FActiveDayRowCount - TopRow) * RowHeight + ARect.Top;
  end;

  FContentBitmap.Canvas.Brush.Style := bsSolid;
  FContentBitmap.Canvas.Brush.Color := clWhite;
  for i := 0 to Columns.Count - 1 do
  begin
    FContentBitmap.Canvas.Pen.Color := clGray;

    R := ContentRect;
    R.Left := Columns[i].Left;
    R.Right := Columns[i].Right;

    if UseRightToLeftAlignment then
      Dec(R.Right, DAY_BAR_WIDTH + 1)
    else
      Inc(R.Left, DAY_BAR_WIDTH + 1);

    if Columns[i].BackColor = clNone then
      BackColor := BackgroundColor
    else
      BackColor := Columns[i].BackColor;

    if ActiveTop > ARect.Top then
    begin
      R.Top := ActiveTop;
      PaintBackground(FContentBitmap.Canvas,
        Rect(R.Left, ARect.Top, R.Right, ActiveTop),
        BackColor, False, DitherBackground);
    end;

    if ActiveBottom < ARect.Bottom then
    begin
      R.Bottom := ActiveBottom;
      PaintBackground(FContentBitmap.Canvas,
        Rect(R.Left, ActiveBottom, R.Right, ARect.Bottom),
        BackColor, False, DitherBackground);
    end;

    if R.Top < ARect.Top then
      R.Top := ARect.Top;
    if R.Bottom > ARect.Bottom then
      R.Bottom := ARect.Bottom;

    if R.Top < R.Bottom then
      PaintBackground(FContentBitmap.Canvas, R, BackColor, True,
        DitherBackground);

    if Focused and (SelectedCount = 0) and
      (Selection.Left <= i) and (Selection.Right >= i) then
    begin
      if Selection.Left < i then
        R.Top := ARect.Top
      else
        R.Top := (Selection.Top - TopRow) * RowHeight + ARect.Top;
      if R.Top < ARect.Top then
        R.Top := ARect.Top;

      if Selection.Right > i then
        R.Bottom := (RowCount - TopRow) * RowHeight + ARect.Top
      else
        R.Bottom := (Selection.Bottom + 1 - TopRow) * RowHeight + ARect.Top;
      if R.Bottom > ARect.Bottom then
        R.Bottom := ARect.Bottom;

      FContentBitmap.Canvas.Brush.Style := bsSolid;
      FContentBitmap.Canvas.Brush.Color := clHighlight;
      FContentBitmap.Canvas.FillRect(R);

    end;

    R.Top := ARect.Top;
    R.Bottom := ARect.Bottom;
    R.Left := Columns[i].Left;
    R.Right := Columns[i].Right;

    FContentBitmap.Canvas.Brush.Style := bsSolid;
    FContentBitmap.Canvas.Brush.Color := clWhite;
    if UseRightToLeftAlignment then
    begin
      R.Left := R.Right - DAY_BAR_WIDTH;
      FContentBitmap.Canvas.Polyline([Point(R.Left - 1, ARect.Top),
        Point(R.Left - 1, ARect.Bottom)]);
    end else
    begin
      R.Right := R.Left + DAY_BAR_WIDTH;
      FContentBitmap.Canvas.Polyline([Point(R.Right, ARect.Top),
        Point(R.Right, ARect.Bottom)]);
    end;
    FContentBitmap.Canvas.FillRect(R);

    R.Left := Columns[i].Left;
    R.Right := Columns[i].Right;
    if UseRightToLeftAlignment then
    begin
      Dec(R.Right, DAY_BAR_WIDTH + 1);
      if i < Columns.Count - 1 then
        Inc(R.Left, 1);
    end else
    begin
      Inc(R.Left, DAY_BAR_WIDTH + 1);
      if i < Columns.Count - 1 then
        Dec(R.Right, 1);
    end;

    R.Bottom := ARect.Top + RowHeight;
    CellRect := R;
    R.Top := R.Bottom - 1;

    HighRow := RowsPerHour[TimeScale];
    CurRow := TopRow + 1;

    while CellRect.Top <= ARect.Bottom do
    begin
      if Assigned(OnDrawCell) then
        DoDrawCell(FContentBitmap.Canvas, i, CurRow - 1, CellRect,
          IsCellSelected(i, CurRow - 1))
      else
        DoDrawCell(FContentBitmap.Canvas, i, CurRow - 1, CellRect, False);

      PaintBorder(FContentBitmap.Canvas, R, BackColor,
        CurRow mod HighRow = 0, DitherBackground);
      Inc(R.Bottom, RowHeight);
      OffsetRect(CellRect, 0, RowHeight);
      R.Top := R.Bottom - 1;
      Inc(CurRow);
    end;

    R.Top := ARect.Top;
    R.Bottom := ARect.Bottom;
    R.Left := Columns[i].Left;
    R.Right := Columns[i].Right;
    if i < Columns.Count - 1 then
    begin
      if UseRightToLeftAlignment then
        x := Columns[i].Left
      else
        x := Columns[i].Right - 1;
      FContentBitmap.Canvas.Polyline([Point(x, ARect.Top),
        Point(x, ARect.Bottom)]);
    end;

    ItemList := ItemLists[i];
    for DisplayItemIndex := 0 to ItemList.Count - 1 do
    begin
      DisplayItem := ItemList[DisplayItemIndex];

      GetDisplayItemRect(DisplayItem, i, 0, ItemRect,
        ExtendsBefore, ExtendsAfter);
      TextToWrite := DisplayItem.Item.Title;
      if (ItemRect.Bottom >= ContentRect.Top - RowHeight) and
        (ItemRect.Top <= ContentRect.Bottom) then
      begin
        ItemSelected := IsItemSelected(DisplayItem.Item);
        if not DoDrawItem(DisplayItem.Item, FContentBitmap.Canvas, ItemRect,
          ExtendsBefore, ExtendsAfter, ItemSelected,
          (ItemUnderMouse = DisplayItem.Item), ContentRect) then
        begin
          ItemBarRect := ItemRect;
          ItemDataRect := ItemRect;

          if UseRightToLeftAlignment then
          begin
            ItemBarRect.Left := ItemBarRect.Right - (DAY_BAR_WIDTH + 1);
            ItemDataRect.Right := ItemBarRect.Left;
          end else
          begin
            ItemBarRect.Right := ItemBarRect.Left + DAY_BAR_WIDTH + 1;
            ItemDataRect.Left := ItemBarRect.Right;
          end;

          FContentBitmap.Canvas.Pen.Color := clGray;
          FContentBitmap.Canvas.Brush.Style := bsSolid;
          FContentBitmap.Canvas.Brush.Color := clWhite;
          FContentBitmap.Canvas.Rectangle(
            ItemBarRect.Left, ItemBarRect.Top,
            ItemBarRect.Right, ItemBarRect.Bottom);

          if not ExtendsBefore then
            Inc(ItemBarRect.Top,
              Trunc(DisplayItem.StartTimeMarker * RowHeight));
          if not ExtendsAfter then
            Dec(ItemBarRect.Bottom,
              Trunc((1 - DisplayItem.EndTimeMarker) * RowHeight));

          FContentBitmap.Canvas.Brush.Style := bsClear;

          BusyRect(FContentBitmap.Canvas, ItemBarRect,
            DisplayItem.Item.BusyStatus);
          FContentBitmap.Canvas.Rectangle(
            ItemBarRect.Left, ItemBarRect.Top,
            ItemBarRect.Right, ItemBarRect.Bottom);
          FContentBitmap.Canvas.Brush.Style := bsSolid;

          if DisplayItem.Item.Color <> clNone then
            FContentBitmap.Canvas.Brush.Color := DisplayItem.Item.Color
          else
            FContentBitmap.Canvas.Brush.Color := clWhite;

          FillGradientRect(FContentBitmap.Canvas, ItemDataRect, FContentBitmap.Canvas.Brush.Color, clWhite);

          if ItemSelected then
            FContentBitmap.Canvas.Pen.Color := clHighlight;

          R := ItemRect;
          FContentBitmap.Canvas.Brush.Style := bsClear;
          FContentBitmap.Canvas.Rectangle(R.Left, R.Top, R.Right, R.Bottom);
          if ItemSelected then
          begin
            InflateRect(R, -1, -1);
            FContentBitmap.Canvas.Rectangle(R.Left, R.Top, R.Right, R.Bottom);
          end;
          if ItemUnderMouse = DisplayItem.Item then
          begin
            InflateRect(R, -1, -1);
            DrawGlow(FContentBitmap.Canvas, R);
          end;
          FContentBitmap.Canvas.Brush.Style := bsSolid;

          InflateRect(ItemDataRect, 0 - CELL_MARGIN, -1);

          FContentBitmap.Canvas.Brush.Style := bsClear;
          FContentBitmap.Canvas.Font := Font;
          DrawItemIcons(FContentBitmap.Canvas, ItemDataRect, Source.Images,
            DisplayItem.Item.Icons, UseRightToLeftAlignment);

          InflateRect(ItemDataRect, 0, 0 - (CELL_MARGIN - 1));
          //her skal der kaldes

          DrawText(FContentBitmap.Canvas.Handle,
            {$IFNDEF CLR}PChar{$ENDIF}(DisplayItem.Item.Title),
            -1, ItemDataRect,
          DrawTextBiDiModeFlags(DT_LEFT or DT_WORDBREAK or DT_NOPREFIX));


          DrawShadow(FContentBitmap.Canvas, ItemRect);
        end;


      end;
    end;
  end;

  Canvas.CopyRect(ContentRect, FContentBitmap.Canvas, ContentRect);



end;

procedure TSPDayPlanner.PaintHeader(ARect: TRect);
var
  DateWidth: Integer;
  DateFormat: string;
  R: TRect;
  i: Integer;
  TextRect, IconRect: TRect;
  s: string;
  ColsPerGroup, GroupCount: Integer;
  EdgeFlags: Integer;
begin
  inherited PaintHeader(ARect);

  if Columns.Count > 0 then
  begin
    ColsPerGroup := 1;
    if (GroupBy <> grNone) and (Resources.Count > 1) then
    begin
      if GroupBy = grResource then
        ColsPerGroup := DayCount
      else
        if GroupBy = grDate then
          ColsPerGroup := Resources.Count;
    end else
      ColsPerGroup := Columns.Count;

    DateWidth := (ARect.Right - ARect.Left) div Columns.Count;
    if (GroupBy = grDate) and (Resources.Count > 0) then
      DateWidth := (ARect.Right - ARect.Left) div Resources.Count;
    DateWidth := DateWidth div CharWidth;
    if DateWidth > 36 then
      DateFormat := 'dddd dd mmmm'
    else
      if DateWidth > 24 then
        DateFormat := 'ddd dd mmmm'
      else
        if DateWidth > 7 then
          DateFormat := 'ddd d'
        else
          DateFormat := 'd';

    Canvas.Font := Font;
    Canvas.Brush.Style := bsClear;

    if UseRightToLeftAlignment then
      EdgeFlags := BF_LEFT
    else
      EdgeFlags := BF_RIGHT;

    R := ARect;
    if (GroupBy <> grNone) and (Resources.Count > 0) then
    begin
      R := ARect;
      R.Top := R.Bottom - (LineHeight + 6);
    end;

    if (GroupBy <> grDate) or (Resources.Count = 0) then
      for i := 0 to Columns.Count - 1 do
      begin
        TextRect := R;
        TextRect.Left := Columns[i].Left;
        TextRect.Right := Columns[i].Right;
        InflateRect(TextRect, -2, -3);
        s := FormatDateTime(DateFormat, TDateTime(Date) +
          i mod ColsPerGroup);
        DrawText(Canvas.Handle, {$IFNDEF CLR}PChar{$ENDIF}(s), Length(s),
          TextRect,
          DrawTextBiDiModeFlags(DT_CENTER or DT_SINGLELINE or DT_NOPREFIX));
      end;

    if (GroupBy <> grNone) and (Resources.Count > 0) then
    begin
      R := ARect;
      R.Bottom := R.Top + (LineHeight + 6);

      if GroupBy = grResource then
        GroupCount := Resources.Count
      else
        GroupCount := DayCount;

      for i := 0 to GroupCount - 1 do
      begin
        TextRect := R;

        if UseRightToLeftAlignment then
        begin
          TextRect.Right := Columns[i * ColsPerGroup].Right;
          TextRect.Left := Columns[(i + 1) * ColsPerGroup - 1].Left;
        end else
        begin
          TextRect.Left := Columns[i * ColsPerGroup].Left;
          TextRect.Right := Columns[(i + 1) * ColsPerGroup - 1].Right;
        end;

        IconRect := TextRect;
        InflateRect(IconRect, -2, -2);
        InflateRect(TextRect, -2, -3);
        if GroupBy = grResource then
        begin
          s := Resources[i].Name;

          if (Resources[i].ImageIndex >= 0) and Assigned(Source) and
            Assigned(Source.Images) and
            (Source.Images.Count > Resources[i].ImageIndex) then
          begin
            if UseRightToLeftAlignment then
              IconRect.Left := IconRect.Right - Source.Images.Width
            else
              IconRect.Right := IconRect.Left + Source.Images.Width;
            if (IconRect.Bottom - IconRect.Top) > Source.Images.Height then
              IconRect.Bottom := IconRect.Top + Source.Images.Height;

            ImageList_DrawEx(Source.Images.Handle, Resources[i].ImageIndex,
              Canvas.Handle, IconRect.Left, IconRect.Top,
              IconRect.Right - IconRect.Left, IconRect.Bottom - IconRect.Top,
              CLR_NONE, CLR_DEFAULT, ILD_NORMAL);
          end;
        end else
          s := FormatDateTime(DateFormat, TDateTime(Date) + i);
        DrawText(Canvas.Handle, {$IFNDEF CLR}PChar{$ENDIF}(s), Length(s),
          TextRect,
          DrawTextBiDiModeFlags(DT_CENTER or DT_SINGLELINE or DT_NOPREFIX));

        if i < GroupCount - 1 then
        begin
          InflateRect(TextRect, 3, 0);
          DrawEdge(Canvas.Handle, TextRect, EDGE_ETCHED, EdgeFlags);
        end;
      end;
    end;
  end;
end;

procedure TSPDayPlanner.PaintResourceDayItems(ResIndex, CellIndex,
  CellCount: Integer);
var
  ItemList: TSPDisplayItems;
  DisplayItem: TSPDisplayItem;
  i, LastCell, FirstCol: Integer;
  ItemRect, R: TRect;
  ExtendsBefore, ExtendsAfter, ItemSelected: Boolean;
  TextToWrite : String;
begin
  ItemList := DayItemLists[ResIndex];
  LastCell := CellIndex + CellCount - 1;
  if (Resources.Count > 0) and (GroupBy <> grNone) then
  begin
    if GroupBy = grResource then
      FirstCol := ResIndex * DayCount + CellIndex
    else
      FirstCol := Resources.Count * CellIndex + ResIndex;
  end else
    FirstCol := CellIndex;

  Canvas.Brush.Style := bsSolid;
  Canvas.Brush.Color := clWhite;
  Canvas.Pen.Style := psSolid;
  Canvas.Pen.Color := clGray;
  Canvas.Pen.Width := 0;
  Canvas.Font := Font;

  for i := 0 to ItemList.Count - 1 do
  begin
    DisplayItem := ItemList[i];
    if (DisplayItem.EndCell >= CellIndex) and
      (DisplayItem.StartCell <= LastCell) then
    begin
      GetDisplayItemRect(DisplayItem, FirstCol, SUB_HEADER_ROW,
        ItemRect, ExtendsBefore, ExtendsAfter);

      if ItemRect.Bottom <= SubHeaderRect.Bottom then
      begin
        ItemSelected := IsItemSelected(DisplayItem.Item);

        TextToWrite := DisplayItem.Item.Title;
        if not DoDrawItem(DisplayItem.Item, Canvas, ItemRect, ExtendsBefore,
          ExtendsAfter, ItemSelected, (ItemUnderMouse = DisplayItem.Item),
          SubHeaderRect) then
        begin
          if DisplayItem.Item.Color <> clNone then
            Canvas.Brush.Color := DisplayItem.Item.Color
          else
            Canvas.Brush.Color := clWhite;

          FillGradientRect(Canvas, ItemRect, clWhite, Canvas.Brush.Color, True);

          Canvas.Brush.Style := bsClear;

          if ItemSelected then
            Canvas.Pen.Color := clHighlight
          else
            Canvas.Pen.Color := clGray;

          R := ItemRect;
          Canvas.Rectangle(R.Left, R.Top, R.Right, R.Bottom);

          if ItemSelected then
          begin
            InflateRect(R, -1, -1);
            Canvas.Rectangle(R.Left, R.Top, R.Right, R.Bottom);
          end;

          if ItemUnderMouse = DisplayItem.Item then
          begin
            InflateRect(R, -1, -1);
            DrawGlow(Canvas, R);
          end;

          InflateRect(ItemRect, 0 - CELL_MARGIN, -1);

          Canvas.Brush.Style := bsClear;
          DrawItemIcons(Canvas, ItemRect, Source.Images,
            DisplayItem.Item.Icons, UseRightToLeftAlignment);
          InflateRect(ItemRect, 0, 0 - (CELL_MARGIN - 1));
          DrawText(Canvas.Handle,
            {$IFNDEF CLR}PChar{$ENDIF}(DisplayItem.Item.Title), -1,
            ItemRect, DrawTextBiDiModeFlags(DT_LEFT or DT_NOPREFIX));
        end;
      end;
    end;
  end;
end;

procedure TSPDayPlanner.PaintSubHeader(ARect: TRect);
var
  ResIndex, DayIndex: Integer;
begin
  inherited PaintSubHeader(ARect);

  if (Resources.Count > 0) and (GroupBy <> grNone) then
    case GroupBy of
      grDate:
        for DayIndex := 0 to DayCount - 1 do
          for ResIndex := 0 to Resources.Count - 1 do
            PaintResourceDayItems(ResIndex, DayIndex, 1);
      grResource:
        for ResIndex := 0 to Resources.Count - 1 do
          PaintResourceDayItems(ResIndex, 0, DayCount);
    end
  else
    PaintResourceDayItems(0, 0, DayCount);
end;

procedure TSPDayPlanner.PrintBar(ACanvas: TCanvas; AColor, AHeaderColor,
  AHeaderTextColor, ABorderColor: TColor; APage: Integer);
var
  i, Hours, Minutes: Integer;
  LineWidth, TextWidth: Integer;
  s, AMPM: string;
  TextRect, LargeTextRect: TRect;
  LargeHeight, HourTop, FirstPrintRow, LastRow, PrintCharWidth: Integer;
  FirstHour, LastHour: Integer;
  Flags: Integer;
begin
  inherited PrintBar(ACanvas, AColor, AHeaderColor, AHeaderTextColor,
    ABorderColor, APage);

  ACanvas.Brush.Style := bsClear;
  ACanvas.Font := PrintFont;
  ACanvas.Pen.Style := psSolid;
  ACanvas.Pen.Width := PrintLineWidth;
  ACanvas.Pen.Color := ABorderColor;

  PrintCharWidth := ACanvas.TextWidth('0');

  if TimeScale = ts1Hour then
  begin
    LineWidth := PrintCharWidth * 8;
    TextWidth := PrintCharWidth * 7;
  end else
  begin
    LineWidth := PrintCharWidth * 4;
    TextWidth := PrintCharWidth * 4;
  end;

  FirstPrintRow := 0;
  if APage > 1 then
    FirstPrintRow := (APage - 1) *
     ((PrintContentRect.Bottom - PrintContentRect.Top) div PrintRowHeight);

  LastRow := RowCount - 1;
  if FShowActiveTimeOnly then
    LastRow := FActiveDayRowCount - 1;

  for i := FirstPrintRow to LastRow do
  begin
    if FShowActiveTimeOnly then
      Minutes := MinutesPerRow[TimeScale] * (i + FActiveDayFirstRow)
    else
      Minutes := MinutesPerRow[TimeScale] * i;
    Hours := Minutes div 60;
    Minutes := Minutes mod 60;

    if (DisplayClockFormat = cf12Hours) and
      ((i = FirstPrintRow) or ((Hours = 12) and (Minutes = 0))) then
    begin
      if Hours >= 12 then
        AMPM := SClockPM
      else
        AMPM := SClockAM;

      Hours := Hours mod 12;
      if Hours = 0 then
        Hours := 12;

      if TimeScale = ts1Hour then
        s := Format('%.d %s', [Hours, AMPM])
      else
      begin
        s := AMPM;
        if ((i + 1) mod RowsPerHour[TimeScale]) = 0 then
          LineWidth := (PrintBarRect.Right - PrintBarRect.Left) - PrintCharWidth
        else
          LineWidth := PrintCharWidth *4;
      end;
    end else
    begin
      if TimeScale = ts1Hour then
      begin
        if DisplayClockFormat = cf12Hours then
          s := Format('%.d:00', [Hours])
        else
          s := Format('%.2d:00', [Hours]);
      end else
      begin
        s := Format('%.2d', [Minutes]);
        if FShowActiveTimeOnly then
        begin
          if ((i + 1 + FActiveDayFirstRow) mod RowsPerHour[TimeScale]) = 0 then
            LineWidth := (PrintBarRect.Right - PrintBarRect.Left) - PrintCharWidth
          else
            LineWidth := PrintCharWidth *4;
        end else
        begin
          if ((i + 1) mod RowsPerHour[TimeScale]) = 0 then
            LineWidth := (PrintBarRect.Right - PrintBarRect.Left) - PrintCharWidth
          else
            LineWidth := PrintCharWidth *4;
        end;
      end;
    end;

    TextRect := PrintBarRect;
    TextRect.Top := PrintBarRect.Top + (i - FirstPrintRow) * PrintRowHeight;
    if TextRect.Top < PrintBarRect.Bottom then
    begin
      TextRect.Bottom := TextRect.Top + PrintRowHeight;
      if UseRightToLeftAlignment then
        TextRect.Right := TextRect.Left + TextWidth
      else
        TextRect.Left := TextRect.Right - TextWidth;

      InflateRect(TextRect, 0, 0 - PrintLineWidth);
      DrawText(ACanvas.Handle, {$IFNDEF CLR}PChar{$ENDIF}(s), Length(s), TextRect,
        DT_CENTER or DT_SINGLELINE or DT_NOPREFIX);

      TextRect := PrintBarRect;
      TextRect.Top := PrintBarRect.Top + (i - FirstPrintRow) * PrintRowHeight;
      TextRect.Bottom := TextRect.Top + PrintRowHeight;
      if UseRightToLeftAlignment then
        TextRect.Right := TextRect.Left + LineWidth
      else
        TextRect.Left := TextRect.Right - LineWidth;

      ACanvas.Polyline([
        Point(TextRect.Left, TextRect.Bottom - 1),
        Point(TextRect.Right, TextRect.Bottom - 1)]);
    end;
  end;

  if TimeScale <> ts1Hour then
  begin
    TextRect := PrintBarRect;
    ACanvas.Font.Size := ACanvas.Font.Size * 2;
    if UseRightToLeftAlignment then
    begin
      TextRect.Left := PrintBarRect.Left + PrintCharWidth * 5;
      TextRect.Right := TextRect.Left + ACanvas.TextWidth('00');
    end else
    begin
      TextRect.Right := PrintBarRect.Right - PrintCharWidth * 5;
      TextRect.Left := TextRect.Right - ACanvas.TextWidth('00');
    end;

    LargeHeight := ACanvas.TextHeight('0');
    HourTop := ((PrintRowHeight * RowsPerHour[TimeScale]) - LargeHeight) div 2;

    if FShowActiveTimeOnly then
    begin
      FirstHour := FActiveDayFirstRow div RowsPerHour[TimeScale];
      LastHour :=
        (FActiveDayFirstRow + FActiveDayRowCount - 1) div RowsPerHour[TimeScale];
    end else
    begin
      FirstHour := 0;
      LastHour := 23;
    end;
    for i := FirstHour to LastHour do
    begin
      if DisplayClockFormat = cf12Hours then
      begin
        if i mod 12 = 0 then
          s := '12'
        else
          s := Format('%.d', [i mod 12]);
      end else
        s := Format('%.2d', [i]);

      TextRect.Top :=
        PrintBarRect.Top + (i * RowsPerHour[TimeScale] - FirstPrintRow) * PrintRowHeight + HourTop;
      if FShowActiveTimeOnly then
        Dec(TextRect.Top, FActiveDayFirstRow * PrintRowHeight);
      TextRect.Bottom := TextRect.Top + LargeHeight;

      if IntersectRect(LargeTextRect, PrintBarRect, TextRect) then
      begin
        if UseRightToLeftAlignment then
          Flags := DT_LEFT or DT_SINGLELINE
        else
          Flags := DT_RIGHT or DT_SINGLELINE;
        if TextRect.Top < LargeTextRect.Top then
          Flags := Flags or DT_BOTTOM;
        DrawText(ACanvas.Handle, {$IFNDEF CLR}PChar{$ENDIF}(s), Length(s),
          LargeTextRect, Flags or DT_NOPREFIX);
      end;
    end;

    ACanvas.Font := PrintFont;
  end;
end;

procedure TSPDayPlanner.PrintContent(ACanvas: TCanvas; AColor,
  AHeaderColor, AHeaderTextColor, ABorderColor: TColor; APage: Integer);
var
  i, x, ActiveTop, ActiveBottom: Integer;
  R, CellRect: TRect;
  BackColor, ItemColor: TColor;
  ItemList: TSPDisplayItems;
  ItemRect, ItemBarRect, ItemDataRect: TRect;
  DisplayItemIndex: Integer;
  DisplayItem: TSPDisplayItem;
  CurRow, HighRow: Integer;
  ExtendsBefore, ExtendsAfter: Boolean;
  FirstPrintRow: Integer;
  ItemPrefix, ItemSuffix: Integer;
  TextToWrite : String;
begin
  ACanvas.Pen.Width := PrintLineWidth;
  ACanvas.Pen.Style := psSolid;
  ACanvas.Pen.Color := ABorderColor;
  ACanvas.Font := PrintFont;

  FirstPrintRow := 0;
  if APage > 1 then
    FirstPrintRow := (APage - 1) *
     ((PrintContentRect.Bottom - PrintContentRect.Top) div PrintRowHeight);

  if FShowActiveTimeOnly then
  begin
    ActiveTop := (0 - FirstPrintRow) * PrintRowHeight + PrintContentRect.Top;
    ActiveBottom := (FActiveDayRowCount - FirstPrintRow) * PrintRowHeight + PrintContentRect.Top;
  end else
  begin
    ActiveTop := (FActiveDayFirstRow - FirstPrintRow) * PrintRowHeight + PrintContentRect.Top;
    ActiveBottom :=
      (FActiveDayFirstRow + FActiveDayRowCount - FirstPrintRow) * PrintRowHeight + PrintContentRect.Top;
  end;

  ACanvas.Brush.Style := bsSolid;
  ACanvas.Brush.Color := clWhite;
  for i := 0 to Columns.Count - 1 do
  begin
    ACanvas.Pen.Color := ABorderColor;

    R := PrintContentRect;
    if UseRightToLeftAlignment then
    begin
      R.Right := PrintContentRect.Right - i * PrintColWidth;
      R.Left := R.Right - PrintColWidth;
      Dec(R.Right, FPrintDayBarWidth);
    end else
    begin
      R.Left := PrintContentRect.Left + i * PrintColWidth;
      R.Right := R.Left + PrintColWidth;
      Inc(R.Left, FPrintDayBarWidth);
    end;

    if Columns[i].BackColor = clNone then
      BackColor := BackgroundColor
    else
      BackColor := Columns[i].BackColor;

    if ActiveTop > PrintContentRect.Top then
    begin
      R.Top := ActiveTop;
      if ActiveTop > PrintContentRect.Bottom then
        ActiveTop := PrintContentRect.Bottom;
      PaintBackground(ACanvas,
        Rect(R.Left, PrintContentRect.Top, R.Right, ActiveTop),
        BackColor, False, False);
    end;

    if ActiveBottom < PrintContentRect.Bottom then
    begin
      R.Bottom := ActiveBottom;
      if ActiveBottom < PrintContentRect.Top then
        ActiveBottom := PrintContentRect.Top;
      PaintBackground(ACanvas,
        Rect(R.Left, ActiveBottom, R.Right, PrintContentRect.Bottom),
        BackColor, False, False);
    end;

    if R.Top < PrintContentRect.Top then
      R.Top := PrintContentRect.Top;
    if R.Bottom > PrintContentRect.Bottom then
      R.Bottom := PrintContentRect.Bottom;

    if R.Top < R.Bottom then
      PaintBackground(ACanvas, R, BackColor, True, False);

    R := PrintContentRect;
    if UseRightToLeftAlignment then
    begin
      R.Right := PrintContentRect.Right - i * PrintColWidth;
      R.Left := R.Right - PrintColWidth;
      Dec(R.Right, FPrintDayBarWidth);
    end else
    begin
      R.Left := PrintContentRect.Left + i * PrintColWidth;
      R.Right := R.Left + PrintColWidth;
      Inc(R.Left, FPrintDayBarWidth);
    end;

    R.Bottom := PrintContentRect.Top + PrintRowHeight;
    CellRect := R;
    R.Top := R.Bottom - PrintLineWidth;

    HighRow := RowsPerHour[TimeScale];
    CurRow := FirstPrintRow + 1;

    while CellRect.Bottom <= PrintContentRect.Bottom do
    begin
      DoDrawCell(ACanvas, i, CurRow - 1, CellRect, False);

      PaintBorder(ACanvas, R, BackColor, CurRow mod HighRow = 0, False);
      Inc(R.Bottom, PrintRowHeight);
      OffsetRect(CellRect, 0, PrintRowHeight);
      R.Top := R.Bottom - PrintLineWidth;
      Inc(CurRow);
    end;

    R := PrintContentRect;
    if UseRightToLeftAlignment then
    begin
      R.Right := PrintContentRect.Right - i * PrintColWidth;
      R.Left := R.Right - FPrintDayBarWidth;
    end else
    begin
      R.Left := PrintContentRect.Left + i * PrintColWidth;
      R.Right := R.Left + FPrintDayBarWidth;
    end;

    ACanvas.Brush.Style := bsSolid;
    ACanvas.Brush.Color := clWhite;
    ACanvas.Rectangle(R.Left, R.Top, R.Right, R.Bottom);

    ItemList := ItemLists[i];
    for DisplayItemIndex := 0 to ItemList.Count - 1 do
    begin
      DisplayItem := ItemList[DisplayItemIndex];

      GetDisplayItemPrintRect(DisplayItem, i, 0, ItemRect,
        ExtendsBefore, ExtendsAfter);

      OffsetRect(ItemRect, 0, 0 - FirstPrintRow * PrintRowHeight);

      if (ItemRect.Bottom >= PrintContentRect.Top - PrintRowHeight) and
        (ItemRect.Top <= PrintContentRect.Bottom) then
      begin
        TextToWrite := DisplayItem.Item.Title;
        if not DoDrawItem(DisplayItem.Item, ACanvas, ItemRect,
          ExtendsBefore, ExtendsAfter, False, False, PrintContentRect) then
        begin
          if ItemRect.Top < PrintContentRect.Top then
          begin
            ItemPrefix := PrintContentRect.Top - ItemRect.Top;
            ItemRect.Top := PrintContentRect.Top;
          end else
            ItemPrefix := 0;

          if ItemRect.Bottom > PrintContentRect.Bottom then
          begin
            ItemSuffix := ItemRect.Bottom - PrintContentRect.Bottom;
            ItemRect.Bottom := PrintContentRect.Bottom;
          end else
            ItemSuffix := 0;

          ItemBarRect := ItemRect;
          ItemDataRect := ItemRect;

          if UseRightToLeftAlignment then
          begin
            ItemBarRect.Left := ItemBarRect.Right - FPrintDayBarWidth;
            ItemDataRect.Right := ItemBarRect.Left;
          end else
          begin
            ItemBarRect.Right := ItemBarRect.Left + FPrintDayBarWidth;
            ItemDataRect.Left := ItemBarRect.Right;
          end;

          ACanvas.Pen.Color := ABorderColor;
          ACanvas.Brush.Style := bsSolid;
          ACanvas.Brush.Color := clWhite;
          ACanvas.Rectangle(
            ItemBarRect.Left, ItemBarRect.Top,
            ItemBarRect.Right, ItemBarRect.Bottom);

          if not ExtendsBefore then
          begin
            Inc(ItemBarRect.Top,
              Trunc(DisplayItem.StartTimeMarker * PrintRowHeight));
            Dec(ItemBarRect.Top, ItemPrefix);
            if ItemBarRect.Top < ItemRect.Top then
              ItemBarRect.Top := ItemRect.Top;
          end;
          if not ExtendsAfter then
          begin
            Dec(ItemBarRect.Bottom,
              Trunc((1 - DisplayItem.EndTimeMarker) * PrintRowHeight));
            Inc(ItemBarRect.Bottom, ItemSuffix);
            if ItemBarRect.Bottom > ItemRect.Bottom then
              ItemBarRect.Bottom := ItemRect.Bottom;
          end;

          ACanvas.Brush.Style := bsClear;

          BusyRect(ACanvas, ItemBarRect,
            DisplayItem.Item.BusyStatus);       
          ACanvas.Rectangle(
            ItemBarRect.Left, ItemBarRect.Top,
            ItemBarRect.Right, ItemBarRect.Bottom);
          ACanvas.Brush.Style := bsSolid;

          ItemColor := DisplayItem.Item.Color;
          if ItemColor = clNone then
            ItemColor := clWhite;
          ItemColor := GetMidColor(ItemColor, clWhite);

          ACanvas.Brush.Color := ItemColor;

          ACanvas.Brush.Style := bsSolid;
          ACanvas.Brush.Color := ItemColor;
          ACanvas.FillRect(ItemDataRect);

          R := ItemRect;
          ACanvas.Brush.Style := bsClear;
          ACanvas.Rectangle(R.Left, R.Top, R.Right, R.Bottom);
          ACanvas.Brush.Style := bsSolid;

          R := ItemDataRect;
          InflateRect(R, 0 - PrintSpacing, -1);

          ACanvas.Brush.Style := bsClear;
          PrintItemIcons(ACanvas, R, Source.Images,
            DisplayItem.Item.Icons, UseRightToLeftAlignment, ItemColor);
          InflateRect(R, 0, 0 - PrintSpacing);
          DrawText(ACanvas.Handle,
            {$IFNDEF CLR}PChar{$ENDIF}(DisplayItem.Item.Title),
            -1, R, DrawTextBiDiModeFlags(DT_LEFT or DT_WORDBREAK or DT_NOPREFIX));

          R := ItemDataRect;
          ACanvas.Brush.Style := bsClear;
          ACanvas.Rectangle(R.Left, R.Top, R.Right, R.Bottom);
        end;
      end;
    end;
  end;

  ACanvas.Pen.Width := PrintLineWidth;
  ACanvas.Pen.Style := psSolid;
  ACanvas.Pen.Color := ABorderColor;
  ACanvas.Brush.Style := bsClear;
  ACanvas.Rectangle(PrintContentRect.Left, PrintContentRect.Top,
    PrintContentRect.Right, PrintContentRect.Bottom);
end;

procedure TSPDayPlanner.PrintHeader(ACanvas: TCanvas; AColor, AHeaderColor,
  AHeaderTextColor, ABorderColor: TColor; APage: Integer);
var
  DateWidth: Integer;
  DateFormat: string;
  R: TRect;
  i: Integer;
  TextRect: TRect;
  s: string;
  ColsPerGroup, GroupCount: Integer;
begin
  inherited PrintHeader(ACanvas, AColor, AHeaderColor, AHeaderTextColor,
    ABorderColor, APage);

  if Columns.Count > 0 then
  begin
    ColsPerGroup := 1;
    if (GroupBy <> grNone) and (Resources.Count > 1) then
    begin
      if GroupBy = grResource then
        ColsPerGroup := DayCount
      else
        if GroupBy = grDate then
          ColsPerGroup := Resources.Count;
    end else
      ColsPerGroup := Columns.Count;

    DateWidth := (PrintHeaderRect.Right - PrintHeaderRect.Left) div Columns.Count;
    if (GroupBy = grDate) and (Resources.Count > 0) then
      DateWidth := (PrintHeaderRect.Right - PrintHeaderRect.Left) div Resources.Count;
    DateWidth := DateWidth div ACanvas.TextWidth('0');
    if DateWidth > 36 then
      DateFormat := 'dddd dd mmmm'
    else
      if DateWidth > 24 then
        DateFormat := 'ddd dd mmmm'
      else
        if DateWidth > 7 then
          DateFormat := 'ddd d'
        else
          DateFormat := 'd';

    ACanvas.Brush.Style := bsClear;

    R := PrintHeaderRect;
    if (GroupBy <> grNone) and (Resources.Count > 0) then
      R.Top := R.Bottom - (PrintTextHeight + 2 * PrintSpacing);

    if (GroupBy <> grDate) or (Resources.Count = 0) then
      for i := 0 to Columns.Count - 1 do
      begin
        TextRect := R;

        if UseRightToLeftAlignment then
        begin
          TextRect.Right := PrintHeaderRect.Right - i * PrintColWidth;
          TextRect.Left := TextRect.Right - PrintColWidth;
        end else
        begin
          TextRect.Left := PrintHeaderRect.Left + i * PrintColWidth;
          TextRect.Right := TextRect.Left + PrintColWidth;
        end;

        InflateRect(TextRect, 0 - PrintSpacing, 0 - PrintSpacing);
        s := FormatDateTime(DateFormat, TDateTime(Date) +
          i mod ColsPerGroup);
        DrawText(ACanvas.Handle, {$IFNDEF CLR}PChar{$ENDIF}(s), Length(s),
          TextRect, DrawTextBiDiModeFlags(DT_CENTER or DT_SINGLELINE or DT_NOPREFIX));
      end;

    if (GroupBy <> grNone) and (Resources.Count > 0) then
    begin
      R := PrintHeaderRect;
      R.Bottom := R.Top + PrintTextHeight + 2 * PrintSpacing;

      if GroupBy = grResource then
        GroupCount := Resources.Count
      else
        GroupCount := DayCount;

      for i := 0 to GroupCount - 1 do
      begin
        TextRect := R;

        if UseRightToLeftAlignment then
        begin
          TextRect.Right :=
            PrintHeaderRect.Right - PrintColWidth * (i * ColsPerGroup);
          TextRect.Left := TextRect.Right - PrintColWidth * ColsPerGroup;
        end else
        begin
          TextRect.Left :=
            PrintHeaderRect.Left + PrintColWidth * (i * ColsPerGroup);
          TextRect.Right := TextRect.Left + PrintColWidth * ColsPerGroup;
        end;

        InflateRect(TextRect, 0 - PrintSpacing, 0 - PrintSpacing);
        if GroupBy = grResource then
          s := Resources[i].Name
        else
          s := FormatDateTime(DateFormat, TDateTime(Date) + i);
        DrawText(ACanvas.Handle, {$IFNDEF CLR}PChar{$ENDIF}(s), Length(s),
          TextRect, DrawTextBiDiModeFlags(DT_CENTER or DT_SINGLELINE or DT_NOPREFIX));

        if i < GroupCount - 1 then
        begin
          InflateRect(TextRect, PrintSpacing, 0);
          if UseRightToLeftAlignment then
            ACanvas.Polyline([
              Point(TextRect.Left, TextRect.Top),
              Point(TextRect.Left, TextRect.Bottom)])
          else
            ACanvas.Polyline([
              Point(TextRect.Right, TextRect.Top),
              Point(TextRect.Right, TextRect.Bottom)])
        end;
      end;
    end;
  end;
end;

procedure TSPDayPlanner.PrintResourceDayItems(ACanvas: TCanvas;
  ABorderColor: TColor; ResIndex, CellIndex, CellCount: Integer);
var
  ItemList: TSPDisplayItems;
  DisplayItem: TSPDisplayItem;
  i, LastCell, FirstCol: Integer;
  ItemRect, R: TRect;
  ExtendsBefore, ExtendsAfter: Boolean;
  ItemColor: TColor;
//  TextToWrite : String;
begin
  ItemList := DayItemLists[ResIndex];
  LastCell := CellIndex + CellCount - 1;
  if (Resources.Count > 0) and (GroupBy <> grNone) then
  begin
    if GroupBy = grResource then
      FirstCol := ResIndex * DayCount + CellIndex
    else
      FirstCol := Resources.Count * CellIndex + ResIndex;
  end else
    FirstCol := CellIndex;

  ACanvas.Brush.Style := bsSolid;
  ACanvas.Brush.Color := clWhite;
  ACanvas.Pen.Style := psSolid;
  ACanvas.Pen.Color := ABorderColor;
  ACanvas.Pen.Width := PrintLineWidth;
  ACanvas.Font := PrintFont;

  for i := 0 to ItemList.Count - 1 do
  begin
    DisplayItem := ItemList[i];
    if (DisplayItem.EndCell >= CellIndex) and
      (DisplayItem.StartCell <= LastCell) then
    begin
      GetDisplayItemPrintRect(DisplayItem, FirstCol, SUB_HEADER_ROW,
        ItemRect, ExtendsBefore, ExtendsAfter);

      if ItemRect.Bottom <= PrintSubHeaderRect.Bottom then
      begin
        if not DoDrawItem(DisplayItem.Item, ACanvas, ItemRect, ExtendsBefore,
          ExtendsAfter, False, False, PrintSubHeaderRect) then
        begin
          ItemColor := DisplayItem.Item.Color;
          if ItemColor = clNone then
            ItemColor := clWhite;
          ItemColor := GetMidColor(ItemColor, clWhite);

          ACanvas.Brush.Color := ItemColor;
          ACanvas.FillRect(ItemRect);

          ACanvas.Brush.Style := bsClear;
          ACanvas.Pen.Style := psSolid;
          ACanvas.Pen.Color := ABorderColor;
          ACanvas.Pen.Width := PrintLineWidth;

          R := ItemRect;
          ACanvas.Rectangle(R.Left, R.Top, R.Right, R.Bottom);

          InflateRect(ItemRect, 0 - PrintSpacing, 0 - PrintSpacing);

          Canvas.Brush.Style := bsClear;
          PrintItemIcons(ACanvas, ItemRect, Source.Images,
            DisplayItem.Item.Icons, UseRightToLeftAlignment, ItemColor);

          DrawText(ACanvas.Handle,
            {$IFNDEF CLR}PChar{$ENDIF}(DisplayItem.Item.Title), -1,
            ItemRect, DrawTextBiDiModeFlags(DT_LEFT or DT_NOPREFIX));
        end;
      end;
    end;
  end;
end;

procedure TSPDayPlanner.PrintSubHeader(ACanvas: TCanvas; AColor, AHeaderColor,
  AHeaderTextColor, ABorderColor: TColor; APage: Integer);
var
  ResIndex, DayIndex: Integer;
begin
  inherited PrintSubHeader(ACanvas, AColor, AHeaderColor, AHeaderTextColor,
    ABorderColor, APage);

  if APage = 1 then
  begin
    if (Resources.Count > 0) and (GroupBy <> grNone) then
      case GroupBy of
        grDate:
          for DayIndex := 0 to DayCount - 1 do
            for ResIndex := 0 to Resources.Count - 1 do
              PrintResourceDayItems(ACanvas, ABorderColor, ResIndex, DayIndex, 1);
        grResource:
          for ResIndex := 0 to Resources.Count - 1 do
            PrintResourceDayItems(ACanvas, ABorderColor, ResIndex, 0, DayCount);
      end
    else
      PrintResourceDayItems(ACanvas, ABorderColor, 0, 0, DayCount);
  end;
end;

procedure TSPDayPlanner.ReadItems;
var
  i, j: Integer;
  StartDate, EndDate: TDateTime;
  Item: TSPPlanItem;
  ColResources: TStringList;
  ColIndex, ResIndex, DateIndex: Integer;
  List: TSPDisplayItems;
  DisplayItem: TSPDisplayItem;
  MaxDaySpan: Integer;
  DayLength: TDateTime;

  procedure ReadItem(AItem: TSPPlanItem; Offset: Double;
    const Resource: string);
  var
    j: Integer;
  begin
    if CanShowItem(AItem) then
    begin
      if AItem.AllDayEvent then
      begin
        if (Resources.Count > 0) and (GroupBy <> grNone) then
          ResIndex := ColResources.IndexOf(Resource)
        else
          ResIndex := 0;

        if ResIndex >= 0 then
          DayItemLists[ResIndex].Add(AItem, Offset);
      end else
      begin
        if (Resources.Count > 0) and (GroupBy <> grNone) then
          ResIndex := ColResources.IndexOf(Resource)
        else
          ResIndex := 0;

        DayLength := 1;
        if FShowActiveTimeOnly then
          DayLength :=
            MinutesPerRow[TimeScale] * FActiveDayFirstRow * EncodeTime(0, 1, 0, 0);

        if ResIndex >= 0 then
        begin
          DateIndex := Trunc((AItem.StartTime + Offset) - StartDate);
          if DateIndex < 0 then
            DateIndex := 0;
          for j := DateIndex to DayCount - 1 do
          begin
            case GroupBy of
              grDate: ColIndex := Resources.Count * j + ResIndex;
              grResource: ColIndex := ResIndex * DayCount + j;
            else
              ColIndex := j;
            end;

            List := ItemLists[ColIndex];

            if ((AItem.EndTime + Offset) > List.CellStart) and
              ((AItem.StartTime + Offset) < List.CellStart + DayLength) then
              List.Add(AItem, Offset);
          end;
        end;
      end;
    end;
  end;

begin
  FMinEndCell := RowCount + 1;
  FMaxStartCell := -1 ;

  for i := 0 to FItemLists.Count - 1 do
  begin
    ItemLists[i].BeginUpdate;
    ItemLists[i].Clear;
  end;

  for i := 0 to FDayItemLists.Count - 1 do
  begin
    DayItemLists[i].BeginUpdate;
    DayItemLists[i].Clear;
  end;

  StartDate := Trunc(Date);
  EndDate := StartDate + DayCount;

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

          if (Item.StartTime) >= EndDate then
            Break;

          if (Item.EndTime > StartDate) and
             ((DragPlanner.Source <> Source) or
              (not DragPlanner.IsItemSelected(Item)) or
              ((GroupBy <> grNone) and (Item.Resource <> DragResourceName))) then
            ReadItem(Item, 0, Item.Resource);
        end;

      for i := 0 to DragPlanner.SelectedCount - 1 do
      begin
        Item := DragPlanner.SelectedItems[i];

        if Item.AllDayEvent then
        begin
          if ((Item.StartTime + DragDayOffset) < EndDate) and
            ((Item.EndTime + DragDayOffset) > StartDate) then
            ReadItem(Item, DragDayOffset, DragResourceName);
        end else
        begin
          if ((Item.StartTime + DragOffset) < EndDate) and
            ((Item.EndTime + DragOffset) > StartDate) then
            ReadItem(Item, DragOffset, DragResourceName);
        end;

      end;
    end else
      if Assigned(Source) then
        for i := 0 to Source.Count - 1 do
        begin
          Item := Source[i];

          if (Item.StartTime) >= EndDate then
            Break;

          if (Item.EndTime) > StartDate then
            ReadItem(Item, 0, Item.Resource);
        end;
  finally
    ColResources.Free;
  end;

  for i := 0 to FItemLists.Count - 1 do
    ItemLists[i].EndUpdate;

  for i := 0 to FDayItemLists.Count - 1 do
    DayItemLists[i].EndUpdate;

  for i := 0 to FItemLists.Count - 1 do
  begin
    List := ItemLists[i];
    for j := 0 to List.Count - 1 do
    begin
      DisplayItem := List[j];
      if DisplayItem.StartCell > FMaxStartCell then
        FMaxStartCell := DisplayItem.StartCell;
      if DisplayItem.EndCell < FMinEndCell then
        FMinEndCell := DisplayItem.EndCell;
    end;
  end;

  MaxDaySpan := 1;
  for i := 0 to FDayItemLists.Count - 1 do
  begin
    List := DayItemLists[i];
    for j := 0 to List.Count - 1 do
    begin
      DisplayItem := List[j];
      if DisplayItem.SpanRange > MaxDaySpan then
        MaxDaySpan := DisplayItem.SpanRange;
    end;
  end;

  SubHeaderRows := MaxDaySpan;
  IF Not ShowSubHeader then
    SubHeaderRows := 0;
//  SubHeaderRows := 0;             //klaus

  RefreshContentView;
end;

procedure TSPDayPlanner.ResourcesChange;
var
  ColCount, ResCount, i, j: Integer;
  BaseStart: TDateTime;
begin
  ColCount := FDayCount;

  if (GroupBy <> grNone) and (Resources.Count > 1) then
    ColCount := Resources.Count * ColCount;

  Columns.BeginUpdate;
  while Columns.Count < ColCount do
    Columns.Add;

  while Columns.Count > ColCount do
    Columns[Columns.Count - 1].Free;

  while FItemLists.Count > ColCount do
  begin
    ItemLists[FItemLists.Count - 1].Free;
    FItemLists.Delete(FItemLists.Count - 1);
  end;

  while FItemLists.Count < ColCount do
    FItemLists.Add(TSPDisplayItems.Create);

  ResCount := Resources.Count;
  if (GroupBy = grNone) or (Resources.Count <= 1) then
    ResCount := 1;

  while FDayItemLists.Count > ResCount do
  begin
    DayItemLists[FDayItemLists.Count - 1].Free;
    FDayItemLists.Delete(FDayItemLists.Count - 1);
  end;

  while FDayItemLists.Count < ResCount do
    FDayItemLists.Add(TSPDisplayItems.Create);

  for i := 0 to FDayItemLists.Count - 1 do
  begin
    DayItemLists[i].CellStart := Trunc(FDate);
    DayItemLists[i].CellDuration := 1;
  end;

  for i := 0 to ColCount - 1 do
    Columns[i].ImageIndex := -1;

  BaseStart := Trunc(FDate);
  if FShowActiveTimeOnly then
    BaseStart := BaseStart +
      MinutesPerRow[TimeScale] * FActiveDayFirstRow * EncodeTime(0, 1, 0, 0);


  for i := 0 to ResCount - 1 do
    for j := 0 to FDayCount - 1 do
      if (GroupBy = grDate) and (Resources.Count > 0) then
      begin
        Columns[j * ResCount + i].BackColor := Resources[i].Color;
        Columns[j * ResCount + i].Header := Resources[i].Name;
        Columns[j * ResCount + i].ImageIndex := Resources[i].ImageIndex;
        ItemLists[j * ResCount + i].CellStart := BaseStart + j;
        ItemLists[j * ResCount + i].CellDuration :=
          MinutesPerRow[TimeScale] * EncodeTime(0, 1, 0, 0);
      end else
      begin
        if (GroupBy = grResource) and (Resources.Count > 0) then
          Columns[i * FDayCount + j].BackColor := Resources[i].Color
        else
          Columns[i * FDayCount + j].BackColor := clNone;
        Columns[i * FDayCount + j].Header := '';
        ItemLists[i * FDayCount + j].CellStart := BaseStart + j;
        ItemLists[i * FDayCount + j].CellDuration :=
          MinutesPerRow[TimeScale] * EncodeTime(0, 1, 0, 0);
      end;

  Columns.EndUpdate;

  ApplyViewSettings;
  inherited ResourcesChange;
end;

procedure TSPDayPlanner.ScalePrintFont(ACanvas: TCanvas; ARect: TRect);
begin
  inherited ScalePrintFont(ACanvas, ARect);
  while PrintFooterRect.Bottom > ARect.Bottom do
  begin
    PrintFont.Size := PrintFont.Size - 1;
    InitPrintSettings(ACanvas, ARect, True);
  end;
end;

procedure TSPDayPlanner.SetActiveDayEnd(const Value: TTime);
begin
  if Frac(Value) < Frac(FActiveDayStart) then
    raise Exception.Create(SActiveDayError);

  if FActiveDayEnd <> Value then
  begin
    FActiveDayEnd := Value;
    ApplyViewMode;
    AdjustTopRow;
  end;
end;

procedure TSPDayPlanner.SetActiveDayStart(const Value: TTime);
begin
  if FActiveDayStart <> Value then
  begin
    FActiveDayStart := Value;
    if Frac(Value) > Frac(FActiveDayEnd) then
      FActiveDayEnd := Value;
    ApplyViewMode;
    AdjustTopRow;
  end;
end;

procedure TSPDayPlanner.SetDate(const Value: TDate);
begin
  if FDate <> Value then
  begin
    FDate := Value;
    ApplyViewMode;
  end;
end;

procedure TSPDayPlanner.SetShowSubHeader(const Value: Boolean);
Begin
  FShowSubHeader := Value;
  ApplyViewMode;
end;
procedure TSPDayPlanner.SetDayCount(const Value: TSPDayCount);
begin
  if FDayCount <> Value then
  begin
    FDayCount := Value;
    FViewMode := vmDays;
    ApplyViewMode;
  end;
end;

procedure TSPDayPlanner.SetShowActiveTimeOnly(const Value: Boolean);
begin
  if Value <> FShowActiveTimeOnly then
  begin
    FShowActiveTimeOnly := Value;
    ApplyViewMode;
    AdjustTopRow;
  end;
end;

procedure TSPDayPlanner.SetTimeScale(const Value: TSPTimeScale);
begin
  if FTimeScale <> Value then
  begin
    FTimeScale := Value;
    ApplyViewMode;
    AdjustTopRow;
  end;
end;

procedure TSPDayPlanner.SetViewMode(const Value: TSPDayViewMode);
begin
  if FViewMode <> Value then
  begin
    FViewMode := Value;
    ApplyViewMode;
  end;
end;

procedure TSPDayPlanner.SourceChanged;
begin
  inherited SourceChanged;
  ReadItems;
  RequestItems(Trunc(FDate), Trunc(FDate) + DayCount);
end;

end.
