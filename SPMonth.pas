(******************************************************************************)
(* SPMonth - Monthly planner                                                  *)
(*                                                                            *)
(* Shorter Path Planners                                                      *)
(*                                                                            *)
(* Copyright © 2004, 2007 Shorter Path Software                               *)
(* http://www.shorterpath.com                                                 *)
(******************************************************************************)

unit SPMonth;

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
  TSPMonthPlanner = class(TSPBasePlanner)
  private
    FDate: TDate;
    FEndDate: TDate;
    FFirstCellDay: Integer;
    FItemLists: TList;
    FStartDate: TDate;
    FMonthCellsCount: Integer;
    FMonthStartCell: Integer;
    procedure ApplyViewSettings;
    function GetItemLists(Index: Integer): TSPDisplayItems;
    function GetMonth: Integer;
    function GetYear: Integer;
    procedure ReadItems;
    procedure SetDate(const Value: TDate);
    procedure SetMonth(const Value: Integer);
    procedure SetYear(const Value: Integer);
  protected
    procedure DoInsertItem(Item: TSPPlanItem); override;
    procedure DoWeekStartChange; override;
    function FindDisplayItem(Item: TSPPlanItem;
      ACol, ARow: Integer): TSPDisplayItem; override;
    procedure GetDisplayItemRect(DisplayItem: TSPDisplayItem;
      ACol, ARow: Integer; var ItemRect: TRect;
      var ExtendsBefore, ExtendsAfter: Boolean); override;
    function GetItemEditRect(Item: TSPPlanItem;
      ACol, ARow: Integer): TRect; override;
    function ItemHitTest(Item: TSPPlanItem;
      CursorPos: TPoint): TSPItemHit; override;
    procedure PaintBar(ARect: TRect); override;
    procedure PaintContent(ARect: TRect); override;
    procedure PaintHeader(ARect: TRect); override;
    procedure GetDisplayItemPrintRect(DisplayItem: TSPDisplayItem;
      ACol, ARow: Integer; var ItemRect: TRect;
      var ExtendsBefore, ExtendsAfter: Boolean); override;
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
    procedure ResourcesChange; override;
    procedure SourceChanged; override;
    property ItemLists[Index: Integer]: TSPDisplayItems read GetItemLists;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure GetCellDates(ACol, ARow: Integer; var StartTime,
      EndTime: TDateTime); override;
    function FindItemAtPos(X, Y: Integer): TSPPlanItem; override;
    function GetCellResource(ACol, ARow: Integer): TSPPlannerResource; override;
    property Date: TDate read FDate write SetDate;
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
    property ThemeStyle;
    property Month: Integer read GetMonth write SetMonth;
    property Year: Integer read GetYear write SetYear;
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
    property OnDrawItem;
    property OnDrawCell;
    property OnInsertItem;
    property OnItemHint;
  end;

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
  DAY_COUNT = 7;
  WEEK_COUNT = 6;

  CELL_MARGIN = 1;
  ITEM_SPACING = 2;
  ITEM_HORZ_SPACE = 3;
  ITEM_MIN_TEXT = 9;
  ITEM_TIME_WIDTH = 6;

{ TSPMonthPlanner }

procedure TSPMonthPlanner.ApplyViewSettings;
var
  i, j, Day, ResCount, ColCount, ListCount: Integer;
  ADay, AMonth, AYear: Word;
begin
  FStartDate := FDate;

  if WeekStart = wsSunday then
    Day := 1
  else
    Day := 2;
  while DayOfWeek(TDateTime(FStartDate)) <> Day do
    FStartDate := FStartDate - 1;

  FEndDate := FDate + 42;

  FMonthStartCell := Trunc(FDate) - Trunc(FStartDate);
  FMonthCellsCount := MonthDays[IsLeapYear(Year), Month];
  DecodeDate(TDateTime(FStartDate), AYear, AMonth, ADay);
  FFirstCellDay := ADay;

  if (GroupBy = grResource) and (Resources.Count > 0) then
    HeaderRows := 2
  else
    HeaderRows := 1;

  if (GroupBy = grDate) and (Resources.Count > 0) then
    BarCols := 3
  else
    BarCols := 0;

  if (GroupBy <> grNone) and (Resources.Count > 0) then
    ResCount := Resources.Count
  else
    ResCount := 1;

  if GroupBy = grDate then
  begin
    SetRowCount(WEEK_COUNT * ResCount);
    ColCount := DAY_COUNT;
  end else
  begin
    SetRowCount(WEEK_COUNT);
    ColCount := DAY_COUNT * ResCount;
  end;

  Columns.BeginUpdate;
  while Columns.Count < ColCount do
    Columns.Add;
  while Columns.Count > ColCount do
    Columns[ColCount].Free;

  ListCount := WEEK_COUNT * ResCount;

  while FItemLists.Count > ListCount do
  begin
    ItemLists[FItemLists.Count - 1].Free;
    FItemLists.Delete(FItemLists.Count - 1);
  end;

  while FItemLists.Count < ListCount do
    FItemLists.Add(TSPDisplayItems.Create);

  for i := 0 to ResCount - 1 do
    for j := 0 to WEEK_COUNT - 1 do
    begin
      ItemLists[i * WEEK_COUNT + j].CellStart :=
        TDateTime(FStartDate) + j * DAY_COUNT;
      ItemLists[i * WEEK_COUNT + j].CellDuration := 1;
    end;

  Columns.EndUpdate;

  ReadItems;
end;

constructor TSPMonthPlanner.Create(AOwner: TComponent);
begin
  FItemLists := TList.Create;
  {$IFDEF CLR}
  FDate := TDate(TDateTime.FromOADate(0));
  {$ENDIF}

  inherited Create(AOwner);
  Ctl3D := True;
  Width := 160;
  Height := 120;
  TabStop := True;

  HeaderRows := 1;
  SubHeaderRows := 0;
  FooterRows := 0;
  SetAutoSizeRows(True);
  SelectionFlow := sfHorizontal;
  Date := TDate(Now);
end;

destructor TSPMonthPlanner.Destroy;
var
  i: Integer;
begin
  for i := 0 to FItemLists.Count - 1 do
    ItemLists[i].Free;
  FItemLists.Free;

  inherited Destroy;
end;

procedure TSPMonthPlanner.DoInsertItem(Item: TSPPlanItem);
begin
  if Resources.Count > 0 then
    case GroupBy of
      grDate:
        Item.Resource := Resources[Selection.Top div WEEK_COUNT].Name;
      grResource:
        Item.Resource := Resources[Selection.Left div DAY_COUNT].Name;
    end;
  if flAllDay in Filter then
    Item.AllDayEvent := True;

  inherited DoInsertItem(Item);
end;

procedure TSPMonthPlanner.DoWeekStartChange;
begin
  ApplyViewSettings;
  inherited DoWeekStartChange;
end;

function TSPMonthPlanner.FindDisplayItem(Item: TSPPlanItem;
  ACol, ARow: Integer): TSPDisplayItem;
var
  ItemList: TSPDisplayItems;
  i, ResIndex: Integer;
begin
  Result := nil;

  if IsCellValid(ACol, ARow) then
  begin
    ResIndex := 0;
    if (GroupBy <> grNone) and (Resources.Count > 0) then
      case GroupBy of
        grDate: ResIndex := ARow div WEEK_COUNT;
        grResource: ResIndex := ACol div DAY_COUNT;
      end;

    ItemList := ItemLists[ResIndex * WEEK_COUNT + ARow mod WEEK_COUNT];

    for i := 0 to ItemList.Count - 1 do
      if ItemList[i].Item = Item then
      begin
        Result := ItemList[i];
        Break;
      end;
  end;
end;

function TSPMonthPlanner.FindItemAtPos(X, Y: Integer): TSPPlanItem;
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
      case GroupBy of
        grDate: ResIndex := Row div WEEK_COUNT;
        grResource: ResIndex := Col div DAY_COUNT;
      end;

    ItemList := ItemLists[ResIndex * WEEK_COUNT + Row mod WEEK_COUNT];
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

procedure TSPMonthPlanner.GetCellDates(ACol, ARow: Integer; var StartTime,
  EndTime: TDateTime);
begin
  inherited GetCellDates(ACol, ARow, StartTime, EndTime);

  if IsCellValid(ACol, ARow) then
  begin
    StartTime := TDateTime(FStartDate) + (ARow mod WEEK_COUNT) * DAY_COUNT +
      ACol mod DAY_COUNT;
    EndTime := StartTime + 1;
  end;
end;

function TSPMonthPlanner.GetCellResource(ACol,
  ARow: Integer): TSPPlannerResource;
begin
  Result := nil;
  if (GroupBy <> grNone) and (Resources.Count > 0) and
    IsCellValid(ACol, ARow) then
    case GroupBy of
      grDate:
        Result := Resources[ARow div WEEK_COUNT];
      grResource:
        Result := Resources[ACol div DAY_COUNT];
    end;
end;

procedure TSPMonthPlanner.GetDisplayItemPrintRect(
  DisplayItem: TSPDisplayItem; ACol, ARow: Integer; var ItemRect: TRect;
  var ExtendsBefore, ExtendsAfter: Boolean);
var
  ItemFirstCell, ItemLastCell, FirstCol, LastCol, StartSpace, EndSpace: Integer;
  CellRect: TRect;
begin
  inherited GetDisplayItemPrintRect(DisplayItem, ACol, ARow, ItemRect,
    ExtendsBefore, ExtendsAfter);

  if Assigned(DisplayItem) and IsCellValid(ACol, ARow) then
  begin
    CellRect.Top := PrintContentRect.Top + ARow * PrintRowHeight;
    CellRect.Bottom := CellRect.Top + PrintRowHeight;

    if UseRightToLeftAlignment then
    begin
      CellRect.Right := PrintContentRect.Right - ACol * PrintColWidth;
      CellRect.Left := CellRect.Right - PrintColWidth;
    end else
    begin
      CellRect.Left := PrintContentRect.Left + ACol * PrintColWidth;
      CellRect.Right := CellRect.Left + PrintColWidth;
    end;

    ItemRect.Top := CellRect.Top + PrintTextHeight +
      (PrintTextHeight + PrintSpacing * 4) * DisplayItem.SpanStart;
    ItemRect.Bottom := ItemRect.Top + PrintTextHeight + PrintSpacing * 2;

    ItemFirstCell := DisplayItem.StartCell;
    ItemLastCell := DisplayItem.EndCell;

    if ItemFirstCell < 0 then
    begin
      ItemFirstCell := 0;
      ExtendsBefore := True;
    end;

    if ItemLastCell >= DAY_COUNT - 1 then
    begin
      ItemLastCell := DAY_COUNT - 1;
      ExtendsAfter := True;
    end;

    FirstCol := ItemFirstCell;
    LastCol := ItemLastCell;
    if (GroupBy = grResource) and (Resources.Count > 0) then
    begin
      FirstCol := ItemFirstCell + (ACol div DAY_COUNT) * DAY_COUNT;
      LastCol := ItemLastCell + (ACol div DAY_COUNT) * DAY_COUNT;
    end;

    StartSpace := 0;
    EndSpace := 0;

    if not ExtendsBefore then
      StartSpace := PrintSpacing * 2;
    if not ExtendsAfter then
      EndSpace := PrintSpacing * 2;

    if UseRightToLeftAlignment then
    begin
      ItemRect.Right :=
        (PrintContentRect.Right - FirstCol * PrintColWidth) - StartSpace;
      ItemRect.Left :=
        (PrintContentRect.Right - (LastCol + 1) * PrintColWidth) + EndSpace;
    end else
    begin
      ItemRect.Left :=
        (PrintContentRect.Left + FirstCol * PrintColWidth) + StartSpace;
      ItemRect.Right :=
        (PrintContentRect.Left + (LastCol + 1) * PrintColWidth) - EndSpace;
    end;
  end;
end;

procedure TSPMonthPlanner.GetDisplayItemRect(DisplayItem: TSPDisplayItem;
  ACol, ARow: Integer; var ItemRect: TRect;
  var ExtendsBefore, ExtendsAfter: Boolean);
var
  ItemFirstCell, ItemLastCell, FirstCol, LastCol, StartSpace, EndSpace: Integer;
  CellRect: TRect;
begin
  inherited GetDisplayItemRect(DisplayItem, ACol, ARow, ItemRect,
    ExtendsBefore, ExtendsAfter);

  if Assigned(DisplayItem) and IsCellValid(ACol, ARow) then
  begin
    CellRect.Top := RowTops[ARow] + ContentRect.Top;
    CellRect.Bottom := CellRect.Top + RowHeights[ARow];
    ItemRect.Top := CellRect.Top + LineHeight +
      (LineHeight + CELL_MARGIN * 2 + ITEM_SPACING) * DisplayItem.SpanStart;
    ItemRect.Bottom := ItemRect.Top + LineHeight + CELL_MARGIN * 2;

    ItemFirstCell := DisplayItem.StartCell;
    ItemLastCell := DisplayItem.EndCell;

    if ItemFirstCell < 0 then
    begin
      ItemFirstCell := 0;
      ExtendsBefore := True;
    end;

    if ItemLastCell >= DAY_COUNT - 1 then
    begin
      ItemLastCell := DAY_COUNT - 1;
      ExtendsAfter := True;
    end;

    FirstCol := ItemFirstCell;
    LastCol := ItemLastCell;
    if (GroupBy = grResource) and (Resources.Count > 0) then
    begin
      FirstCol := ItemFirstCell + (ACol div DAY_COUNT) * DAY_COUNT;
      LastCol := ItemLastCell + (ACol div DAY_COUNT) * DAY_COUNT;
    end;

    StartSpace := 0;
    EndSpace := 0;

    if not ExtendsBefore then
      StartSpace := ITEM_HORZ_SPACE;
    if not ExtendsAfter then
      EndSpace := ITEM_HORZ_SPACE;

    if UseRightToLeftAlignment then
    begin
      ItemRect.Right := Columns[FirstCol].Right - StartSpace;
      ItemRect.Left := Columns[LastCol].Left + 1 + EndSpace;
    end else
    begin
      ItemRect.Left := Columns[FirstCol].Left + StartSpace;
      ItemRect.Right := Columns[LastCol].Right - (1 + EndSpace);
    end;
  end;
end;

function TSPMonthPlanner.GetItemEditRect(Item: TSPPlanItem; ACol,
  ARow: Integer): TRect;
var
  R: TRect;
  ExtendsBefore, ExtendsAfter: Boolean;
begin
  Result := inherited GetItemEditRect(Item, ACol, ARow);
  if Assigned(Item) then
  begin
    GetItemRect(Item, ACol, ARow, R, ExtendsBefore, ExtendsAfter);
    if IntersectRect(R, R, ContentRect) then
    begin
      InflateRect(R, -1, -1);
      if (not Item.AllDayEvent) and
        ((R.Right - R.Left) > CharWidth * ITEM_MIN_TEXT) then
      begin
        if UseRightToLeftAlignment then
          Dec(R.Right, CharWidth * ITEM_TIME_WIDTH)
        else
          Inc(R.Left, CharWidth * ITEM_TIME_WIDTH);
      end;
      Result := R;
    end;
  end;
end;

function TSPMonthPlanner.GetItemLists(Index: Integer): TSPDisplayItems;
begin
  Result := TSPDisplayItems(FItemLists[Index]);
end;

function TSPMonthPlanner.GetMonth: Integer;
var
  AYear, AMonth, ADay: Word;
begin
  DecodeDate(TDateTime(FDate), AYear, AMonth, ADay);
  Result := AMonth;
end;

function TSPMonthPlanner.GetYear: Integer;
var
  AYear, AMonth, ADay: Word;
begin
  DecodeDate(TDateTime(FDate), AYear, AMonth, ADay);
  Result := AYear;
end;

function TSPMonthPlanner.ItemHitTest(Item: TSPPlanItem;
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

    if (ItemRect.Top >= (ContentRect.Top + RowTops[Row])) and
      (ItemRect.Bottom <= (ContentRect.Top + RowTops[Row] + RowHeights[Row])) and
      PtInRect(ItemRect, CursorPos) then
    begin
      Result := ihSelect;
      if Item.AllDayEvent or
        (Trunc(Item.StartTime) <> Trunc(Item.EndTime)) then
      begin
        Result := ihContent;
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
      end else
      begin
        R := ItemRect;
        if (R.Right - R.Left) > CharWidth * ITEM_MIN_TEXT then
        begin
          if UseRightToLeftAlignment then
            Dec(R.Right, CharWidth * ITEM_TIME_WIDTH)
          else
            Inc(R.Left, CharWidth * ITEM_TIME_WIDTH);
        end;
        if PtInRect(R, CursorPos) then
          Result := ihContent;
      end;
    end;
  end;
end;

procedure TSPMonthPlanner.PaintBar(ARect: TRect);
var
  i, X, Y: Integer;
  TextRect: TRect;
  LogFont: TLogFont;
  SaveAlign, TextFlags: UINT;
  ResourceName: string;
begin
  inherited PaintBar(ARect);

  if (BarRect.Right > BarRect.Left) and (Resources.Count > 0) then
  begin
    {$IFNDEF CLR}
    FillChar(LogFont, SizeOf(LogFont), 0);
    {$ENDIF}
    GetObject(Font.Handle, SizeOf(LogFont), {$IFNDEF CLR}@{$ENDIF}LogFont);
    if UseRightToLeftAlignment then
      LogFont.lfEscapement := 2700
    else
      LogFont.lfEscapement := 900;
    LogFont.lfOrientation := LogFont.lfEscapement;
    Canvas.Font.Handle := CreateFontIndirect(LogFont);

    Canvas.Brush.Style := bsClear;

    TextRect := ARect;
    InflateRect(TextRect, -2, 0);

    if UseRightToLeftAlignment then
      X := (TextRect.Right - TextRect.Left) - LineHeight
    else
      X := LineHeight;

    TextFlags := TA_CENTER or TA_BASELINE;
    if UseRightToLeftAlignment then
      TextFlags := TextFlags or TA_RTLREADING;

    SaveAlign := SetTextAlign(Canvas.Handle, TextFlags);

    for i := 0 to Resources.Count - 1 do
    begin
      TextRect.Top := RowTops[i * WEEK_COUNT] + ARect.Top;
      TextRect.Bottom :=
        ARect.Top +
        RowTops[(i + 1) * WEEK_COUNT - 1] +
        RowHeights[(i + 1) * WEEK_COUNT - 1];

      Y := (TextRect.Bottom - TextRect.Top) div 2;
      ResourceName := Resources[i].Name;

      if (Resources[i].ImageIndex >= 0) and Assigned(Source) and
        Assigned(Source.Images) and
        (Source.Images.Count > Resources[i].ImageIndex) then
        Source.Images.Draw(Canvas, TextRect.Left, TextRect.Top + 1,
          Resources[i].ImageIndex);

      ExtTextOut(Canvas.Handle,
        TextRect.Left + X, TextRect.Top + Y, ETO_CLIPPED,
        {$IFNDEF CLR}@{$ENDIF}TextRect,
        {$IFNDEF CLR}PChar{$ENDIF}(ResourceName), Length(ResourceName), nil);

      if i < (Resources.Count - 1) then
        DrawEdge(Canvas.Handle, TextRect, EDGE_ETCHED, BF_BOTTOM);
    end;
    SetTextAlign(Canvas.Handle, SaveAlign);
  end;
end;

procedure TSPMonthPlanner.PaintContent(ARect: TRect);
var
  i, j, Row, Col, VertCount, HorzCount, ListIndex,
  FirstRow, FirstCol, CellDay, DrawFlags, DisplayItemIndex: Integer;
  CellRect, CellHeaderRect, ItemRect, ItemBarRect, ItemDataRect: TRect;
  BackColor: TColor;
  ItemList: TSPDisplayItems;
  DisplayItem: TSPDisplayItem;
  ExtendsBefore, ExtendsAfter, ItemSelected, BackActive: Boolean;
  DateString, ItemText,TextToWrite: string;
begin
  Canvas.Pen.Width := 0;
  Canvas.Pen.Style := psSolid;
  Canvas.Pen.Color := clGray;
  Canvas.Font := Font;

  VertCount := 1;
  HorzCount := 1;
  if Resources.Count > 0 then
  begin
    if GroupBy = grDate then
      VertCount := Resources.Count
    else
      if GroupBy = grResource then
        HorzCount := Resources.Count;
  end;

  for j := 0 to VertCount - 1 do
    for i := 0 to HorzCount - 1 do
    begin
      FirstCol := 0;
      FirstRow := 0;
      ListIndex := 0;
      BackColor := BackgroundColor;
      if (GroupBy <> grNone) and (Resources.Count > 0) then
      begin
        if GroupBy = grDate then
        begin
          FirstRow := j * WEEK_COUNT;
          ListIndex := FirstRow;
          if Resources[j].Color <> clNone then
            BackColor := Resources[j].Color;
        end else
        begin
          FirstCol := i * DAY_COUNT;
          ListIndex := i * WEEK_COUNT;
          if Resources[i].Color <> clNone then
            BackColor := Resources[i].Color;
        end;
      end;

      for Row := FirstRow to FirstRow + WEEK_COUNT - 1 do
      begin
        Canvas.Pen.Color := clGray;
        Canvas.Brush.Style := bsClear;

        CellRect.Top := RowTops[Row] + ContentRect.Top;
        CellRect.Bottom := CellRect.Top + RowHeights[Row];

        for Col := FirstCol to FirstCol + DAY_COUNT - 1 do
        begin
          CellRect.Left := Columns[Col].Left;
          CellRect.Right := Columns[Col].Right;
          CellDay := (Row mod WEEK_COUNT) * DAY_COUNT + Col mod DAY_COUNT;
          BackActive := True;
          if CellDay < FMonthStartCell then
          begin
            CellDay := FFirstCellDay + CellDay;
            BackActive := False;
          end else
            if CellDay >= FMonthStartCell + FMonthCellsCount then
            begin
              CellDay := CellDay + 1 - (FMonthStartCell + FMonthCellsCount);
              BackActive := False;
            end else
              CellDay := CellDay + 1 - FMonthStartCell;

          if not DoDrawCell(Canvas, Col, Row, CellRect,
            (SelectedCount = 0) and Focused and IsCellSelected(Col, Row)) then
          begin
            PaintBackground(Canvas, CellRect, BackColor, BackActive,
              DitherBackground);

            DateString := IntToStr(CellDay);

            CellHeaderRect := CellRect;
            InflateRect(CellHeaderRect, -2, -1);
            CellHeaderRect.Bottom := CellHeaderRect.Top + LineHeight;
            if (SelectedCount = 0) and Focused and IsCellSelected(Col, Row) then
            begin
              Canvas.Brush.Style := bsSolid;
              Canvas.Brush.Color := clHighlight;
              Canvas.Font.Color := clHighlightText;
              Canvas.FillRect(CellHeaderRect);
            end else
            begin
              Canvas.Brush.Style := bsClear;
              Canvas.Font := Font;
            end;
            DrawText(Canvas.Handle, {$IFNDEF CLR}PChar{$ENDIF}(DateString), -1,
              CellHeaderRect,
              DrawTextBiDiModeFlags(DT_RIGHT or DT_SINGLELINE or DT_NOPREFIX));
          end;

          if Col < Columns.Count - 1 then
          begin
            if UseRightToLeftAlignment then
              Canvas.Polyline(
                [Point(CellRect.Left, CellRect.Top),
                 Point(CellRect.Left, CellRect.Bottom)])
            else
              Canvas.Polyline(
                [Point(CellRect.Right - 1, CellRect.Top),
                 Point(CellRect.Right - 1, CellRect.Bottom)]);
          end;

          if Row < RowCount - 1 then
          begin
            Canvas.Polyline(
              [Point(CellRect.Left, CellRect.Bottom - 1),
               Point(CellRect.Right, CellRect.Bottom - 1)]);
          end;
        end;

        ItemList := ItemLists[ListIndex + Row - FirstRow];
        for DisplayItemIndex := 0 to ItemList.Count - 1 do
        begin
          DisplayItem := ItemList[DisplayItemIndex];
          GetDisplayItemRect(DisplayItem, FirstCol, Row, ItemRect,
            ExtendsBefore, ExtendsAfter);
          if ItemRect.Bottom < CellRect.Bottom then
          begin
            ItemSelected := IsItemSelected(DisplayItem.Item);
            TextToWrite := DisplayItem.Item.title;
            if not DoDrawItem(DisplayItem.Item, Canvas, ItemRect, ExtendsBefore,
              ExtendsAfter, ItemSelected, (ItemUnderMouse = DisplayItem.Item),
              ContentRect) then
            begin
              Canvas.Font := Font;
              Canvas.Pen.Color := clBlack;
              if ItemSelected or DisplayItem.Item.AllDayEvent or
                (DisplayItem.StartCell <> DisplayItem.EndCell) or
                (DisplayItem.Item.Color <> clNone) then
              begin
                Canvas.Brush.Style := bsSolid;
                if ItemSelected then
                begin
                  Canvas.Brush.Color := clHighlight;
                  Canvas.Font.Color := clHighlightText;
                end else
                  if DisplayItem.Item.Color <> clNone then
                    Canvas.Brush.Color := DisplayItem.Item.Color
                  else
                    Canvas.Brush.Color := clWhite;
                if DisplayItem.Item.AllDayEvent or
                  (DisplayItem.StartCell <> DisplayItem.EndCell) then
                  Canvas.Rectangle(ItemRect.Left, ItemRect.Top,
                    ItemRect.Right, ItemRect.Bottom)
                else
                  Canvas.FillRect(ItemRect);
              end;

              Canvas.Brush.Style := bsClear;
              InflateRect(ItemRect, 0 - CELL_MARGIN, -1);

              DrawItemIcons(Canvas, ItemRect, Source.Images,
                DisplayItem.Item.Icons, UseRightToLeftAlignment);
              InflateRect(ItemRect, 0, 0 - (CELL_MARGIN - 1));

              DrawFlags := 0;
              if DisplayItem.Item.AllDayEvent or
                (DisplayItem.StartCell <> DisplayItem.EndCell) then
                DrawFlags := DT_CENTER;
              ItemText := DisplayItem.Item.Title;
              if (not DisplayItem.Item.AllDayEvent) and
                ((ItemRect.Right - ItemRect.Left) >
                  CharWidth * ITEM_MIN_TEXT) then
                ItemText :=
                  FormatDateTime('hh:mm ', DisplayItem.Item.StartTime) +
                  ItemText;
              if (ItemRect.Right - ItemRect.Left) <
                Canvas.TextWidth(ItemText) then
                DrawFlags := DT_LEFT;

              DrawText(Canvas.Handle, {$IFNDEF CLR}PChar{$ENDIF}(ItemText), -1,
                ItemRect, DrawTextBiDiModeFlags(DrawFlags or DT_NOPREFIX));
            end;
          end else
            DrawMoreBitmap(Canvas,
              Rect(ItemRect.Left, CellRect.Top,
                ItemRect.Right, CellRect.Bottom));
        end;
      end;
    end;
end;

procedure TSPMonthPlanner.PaintHeader(ARect: TRect);
var
  R, TextRect, IconRect: TRect;
  i, WeekDay: Integer;
  s: string;
  UseShortNames: Boolean;
  formatSettings: TFormatSettings;
begin
  inherited PaintHeader(ARect);

  Canvas.Font := Font;
  Canvas.Brush.Style := bsClear;

  if Columns.Count > 0 then
  begin
    UseShortNames :=
      (ARect.Right - ARect.Left) div (Columns.Count * CharWidth) <= 10;

    if (GroupBy = grResource) and (Resources.Count > 0) then
    begin
      R := ARect;
      R.Bottom := R.Top + LineHeight + 6;

      for i := 0 to Resources.Count - 1 do
      begin
        TextRect := R;
        if UseRightToLeftAlignment then
        begin
          TextRect.Right := Columns[i * DAY_COUNT].Right;
          TextRect.Left := Columns[(i + 1) * DAY_COUNT - 1].Left - 1;
        end else
        begin
          TextRect.Left := Columns[i * DAY_COUNT].Left;
          TextRect.Right := Columns[(i + 1) * DAY_COUNT - 1].Right + 1;
        end;
        IconRect := TextRect;
        InflateRect(IconRect, -2, -2);
        InflateRect(TextRect, 0, -3);

        if i < Resources.Count - 1 then
        begin
          if UseRightToLeftAlignment then
            DrawEdge(Canvas.Handle, TextRect, EDGE_ETCHED, BF_LEFT)
          else
            DrawEdge(Canvas.Handle, TextRect, EDGE_ETCHED, BF_RIGHT);
        end;

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

        InflateRect(TextRect, -2, 0);
        DrawText(Canvas.Handle, {$IFNDEF CLR}PChar{$ENDIF}(Resources[i].Name),
          -1, TextRect, DrawTextBiDiModeFlags(DT_CENTER or DT_SINGLELINE or DT_NOPREFIX));
      end;
    end;

    R := ARect;
    R.Top := R.Bottom - (LineHeight + 6);

    for i := 0 to Columns.Count - 1 do
    begin
      TextRect := R;
      TextRect.Left := Columns[i].Left;
      TextRect.Right := Columns[i].Right;

      WeekDay := i mod DAY_COUNT;
      if WeekStart = wsMonday then
        Inc(WeekDay);

      if UseShortNames then
        s := formatSettings.ShortDayNames[WeekDay mod 7 + 1]
      else
        s := formatSettings.LongDayNames[WeekDay mod 7 + 1];
      InflateRect(TextRect, 0, -2);
      DrawText(Canvas.Handle, {$IFNDEF CLR}PChar{$ENDIF}(s), Length(s),
        TextRect, DrawTextBiDiModeFlags(DT_CENTER or DT_SINGLELINE or DT_NOPREFIX));
    end;
  end;
end;

procedure TSPMonthPlanner.PrintBar(ACanvas: TCanvas; AColor, AHeaderColor,
  AHeaderTextColor, ABorderColor: TColor; APage: Integer);
var
  i, X, Y: Integer;
  TextRect: TRect;
  LogFont: TLogFont;
  SaveAlign, TextFlags: UINT;
  ResourceName: string;
begin
  inherited PrintBar(ACanvas, AColor, AHeaderColor, AHeaderTextColor, ABorderColor, APage);

  if (PrintBarRect.Right > PrintBarRect.Left) and (Resources.Count > 0) then
  begin
    {$IFNDEF CLR}
    FillChar(LogFont, SizeOf(LogFont), 0);
    {$ENDIF}
    GetObject(PrintFont.Handle, SizeOf(LogFont), {$IFNDEF CLR}@{$ENDIF}LogFont);
    if UseRightToLeftAlignment then
      LogFont.lfEscapement := 2700
    else
      LogFont.lfEscapement := 900;
    LogFont.lfOrientation := LogFont.lfEscapement;
    LogFont.lfHeight := 0 - MulDiv(PrintFont.Size,
      GetDeviceCaps(ACanvas.Handle, LOGPIXELSY), 72);

    ACanvas.Font.Handle := CreateFontIndirect(LogFont);

    ACanvas.Brush.Style := bsClear;

    TextRect := PrintBarRect;

    if UseRightToLeftAlignment then
      X := (TextRect.Right - TextRect.Left) - PrintTextHeight
    else
      X := PrintTextHeight;

    TextFlags := TA_CENTER or TA_BASELINE;
    if UseRightToLeftAlignment then
      TextFlags := TextFlags or TA_RTLREADING;

    SaveAlign := SetTextAlign(ACanvas.Handle, TextFlags);

    for i := 0 to Resources.Count - 1 do
    begin
      TextRect.Top := PrintBarRect.Top + PrintRowHeight * i * WEEK_COUNT;
      TextRect.Bottom := TextRect.Top + PrintRowHeight * WEEK_COUNT;

      Y := (TextRect.Bottom - TextRect.Top) div 2;
      ResourceName := Resources[i].Name;

      ExtTextOut(ACanvas.Handle,
        TextRect.Left + X, TextRect.Top + Y, ETO_CLIPPED,
        {$IFNDEF CLR}@{$ENDIF}TextRect,
        {$IFNDEF CLR}PChar{$ENDIF}(ResourceName), Length(ResourceName), nil);

      ACanvas.Rectangle(TextRect.Left, TextRect.Top,
        TextRect.Right, TextRect.Bottom);
    end;
    SetTextAlign(ACanvas.Handle, SaveAlign);
  end;
end;

procedure TSPMonthPlanner.PrintContent(ACanvas: TCanvas; AColor,
  AHeaderColor, AHeaderTextColor, ABorderColor: TColor; APage: Integer);
var
  i, j, Row, Col, VertCount, HorzCount, ListIndex,
  FirstRow, FirstCol, CellDay, DrawFlags, DisplayItemIndex: Integer;
  CellRect, CellHeaderRect, ItemRect, ItemBarRect, ItemDataRect: TRect;
  BackColor, ItemColor: TColor;
  ItemList: TSPDisplayItems;
  DisplayItem: TSPDisplayItem;
  ExtendsBefore, ExtendsAfter, BackActive: Boolean;
  DateString, ItemText,TextToWrite: string;
begin
  inherited PrintContent(ACanvas, AColor, AHeaderColor, AHeaderTextColor, ABorderColor, APage);

  ACanvas.Pen.Width := PrintLineWidth;
  ACanvas.Pen.Style := psSolid;
  ACanvas.Pen.Color := ABorderColor;
  ACanvas.Font := PrintFont;

  VertCount := 1;
  HorzCount := 1;
  if Resources.Count > 0 then
  begin
    if GroupBy = grDate then
      VertCount := Resources.Count
    else
      if GroupBy = grResource then
        HorzCount := Resources.Count;
  end;

  for j := 0 to VertCount - 1 do
    for i := 0 to HorzCount - 1 do
    begin
      FirstCol := 0;
      FirstRow := 0;
      ListIndex := 0;
      BackColor := BackgroundColor;
      if (GroupBy <> grNone) and (Resources.Count > 0) then
      begin
        if GroupBy = grDate then
        begin
          FirstRow := j * WEEK_COUNT;
          ListIndex := FirstRow;
          if Resources[j].Color <> clNone then
            BackColor := Resources[j].Color;
        end else
        begin
          FirstCol := i * DAY_COUNT;
          ListIndex := i * WEEK_COUNT;
          if Resources[i].Color <> clNone then
            BackColor := Resources[i].Color;
        end;
      end;

      for Row := FirstRow to FirstRow + WEEK_COUNT - 1 do
      begin
        CellRect.Top := PrintContentRect.Top + Row * PrintRowHeight;
        CellRect.Bottom := CellRect.Top + PrintRowHeight;

        for Col := FirstCol to FirstCol + DAY_COUNT - 1 do
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

          CellDay := (Row mod WEEK_COUNT) * DAY_COUNT + Col mod DAY_COUNT;
          BackActive := True;
          if CellDay < FMonthStartCell then
          begin
            CellDay := FFirstCellDay + CellDay;
            BackActive := False;
          end else
            if CellDay >= FMonthStartCell + FMonthCellsCount then
            begin
              CellDay := CellDay + 1 - (FMonthStartCell + FMonthCellsCount);
              BackActive := False;
            end else
              CellDay := CellDay + 1 - FMonthStartCell;

          ACanvas.Pen.Color := ABorderColor;
          ACanvas.Brush.Style := bsClear;
          ACanvas.Font := PrintFont;
          if not DoDrawCell(ACanvas, Col, Row, CellRect, False) then
          begin
            PaintBackground(ACanvas, CellRect, BackColor, BackActive, False);

            DateString := IntToStr(CellDay);

            CellHeaderRect := CellRect;
            InflateRect(CellHeaderRect, -1, -1);
            CellHeaderRect.Bottom := CellHeaderRect.Top + PrintTextHeight;
            ACanvas.Brush.Style := bsClear;
            ACanvas.Font := PrintFont;
            DrawText(ACanvas.Handle, {$IFNDEF CLR}PChar{$ENDIF}(DateString), -1,
              CellHeaderRect,
              DrawTextBiDiModeFlags(DT_RIGHT or DT_SINGLELINE or DT_NOPREFIX));
          end;

          ACanvas.Brush.Style := bsClear;
          ACanvas.Pen.Style := psSolid;
          ACanvas.Pen.Color := ABorderColor;
          ACanvas.Pen.Width := PrintLineWidth;
          ACanvas.Rectangle(CellRect.Left, CellRect.Top,
            CellRect.Right, CellRect.Bottom);
        end;

        ItemList := ItemLists[ListIndex + Row - FirstRow];
        for DisplayItemIndex := 0 to ItemList.Count - 1 do
        begin
          DisplayItem := ItemList[DisplayItemIndex];
          GetDisplayItemPrintRect(DisplayItem, FirstCol, Row, ItemRect,
            ExtendsBefore, ExtendsAfter);
          if ItemRect.Bottom < CellRect.Bottom then
          begin
            ACanvas.Font := PrintFont;
            ACanvas.Pen.Color := clBlack;
            ACanvas.Pen.Width := PrintLineWidth div 2;
            TextToWrite := DisplayItem.Item.Title;
            if not DoDrawItem(DisplayItem.Item, Canvas, ItemRect, ExtendsBefore,
              ExtendsAfter, False, False, PrintContentRect) then
            begin
              ACanvas.Font := PrintFont;
              ACanvas.Pen.Color := clBlack;
              ACanvas.Pen.Width := PrintLineWidth div 2;

              ItemColor := clWhite;
              if DisplayItem.Item.AllDayEvent or
                (DisplayItem.StartCell <> DisplayItem.EndCell) or
                (DisplayItem.Item.Color <> clNone) then
              begin
                ACanvas.Brush.Style := bsSolid;
                if DisplayItem.Item.Color <> clNone then
                  ItemColor := DisplayItem.Item.Color;
                ACanvas.Brush.Color := ItemColor;
                if DisplayItem.Item.AllDayEvent or
                  (DisplayItem.StartCell <> DisplayItem.EndCell) then
                  ACanvas.Rectangle(ItemRect.Left, ItemRect.Top,
                    ItemRect.Right, ItemRect.Bottom)
                else
                  ACanvas.FillRect(ItemRect);
              end;

              ACanvas.Brush.Style := bsClear;
              InflateRect(ItemRect, 0 - PrintSpacing, 0 - PrintSpacing);

              PrintItemIcons(ACanvas, ItemRect, Source.Images,
                DisplayItem.Item.Icons, UseRightToLeftAlignment, ItemColor);

              DrawFlags := 0;
              if DisplayItem.Item.AllDayEvent or
                (DisplayItem.StartCell <> DisplayItem.EndCell) then
                DrawFlags := DT_CENTER;
              ItemText := DisplayItem.Item.Title;
              if (not DisplayItem.Item.AllDayEvent) and
                ((ItemRect.Right - ItemRect.Left) >
                  ACanvas.TextWidth('00:00 00')) then
                ItemText :=
                  FormatDateTime('hh:mm ', DisplayItem.Item.StartTime) +
                  ItemText;
              if (ItemRect.Right - ItemRect.Left) <
                ACanvas.TextWidth(ItemText) then
                DrawFlags := DT_LEFT;

              DrawText(ACanvas.Handle, {$IFNDEF CLR}PChar{$ENDIF}(ItemText),
                Length(ItemText), ItemRect,
                DrawTextBiDiModeFlags(DrawFlags or DT_NOPREFIX));
            end;
          end;
        end;
      end;
    end;

end;

procedure TSPMonthPlanner.PrintHeader(ACanvas: TCanvas; AColor,
  AHeaderColor, AHeaderTextColor, ABorderColor: TColor; APage: Integer);
var
  R, TextRect: TRect;
  i, WeekDay: Integer;
  s: string;
  UseShortNames: Boolean;
begin
  inherited PrintHeader(ACanvas, AColor, AHeaderColor, AHeaderTextColor,
    ABorderColor, APage);

  ACanvas.Brush.Style := bsClear;

  if Columns.Count > 0 then
  begin
    UseShortNames :=
      (PrintHeaderRect.Right - PrintHeaderRect.Left) div
        (Columns.Count * ACanvas.TextWidth('0')) <= 10;

    if (GroupBy = grResource) and (Resources.Count > 0) then
    begin
      R := PrintHeaderRect;
      R.Bottom := R.Top + PrintTextHeight + 2 * PrintSpacing;

      for i := 0 to Resources.Count - 1 do
      begin
        TextRect := R;
        if UseRightToLeftAlignment then
        begin
          TextRect.Right := PrintHeaderRect.Right - i * DAY_COUNT * PrintColWidth;
          TextRect.Left := TextRect.Right - DAY_COUNT * PrintColWidth;
        end else
        begin
          TextRect.Left := PrintHeaderRect.Left + i * DAY_COUNT * PrintColWidth;
          TextRect.Right := TextRect.Left + DAY_COUNT * PrintColWidth;
        end;

        ACanvas.Rectangle(TextRect.Left, TextRect.Top,
          TextRect.Right, TextRect.Bottom);
        InflateRect(TextRect, 0 - PrintSpacing, 0 - PrintSpacing);
        DrawText(ACanvas.Handle, {$IFNDEF CLR}PChar{$ENDIF}(Resources[i].Name),
          -1, TextRect,
          DrawTextBiDiModeFlags(DT_CENTER or DT_SINGLELINE or DT_NOPREFIX));
      end;
    end;

    R := PrintHeaderRect;
    R.Top := R.Bottom - (PrintTextHeight + 2 * PrintSpacing);

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

      WeekDay := i mod DAY_COUNT;
      if WeekStart = wsMonday then
        Inc(WeekDay);

      if UseShortNames then
        s := formatSettings.ShortDayNames[WeekDay mod 7 + 1]
      else
        s := formatSettings.LongDayNames[WeekDay mod 7 + 1];
      InflateRect(TextRect, 0, 0 - PrintSpacing);
      DrawText(ACanvas.Handle, {$IFNDEF CLR}PChar{$ENDIF}(s), Length(s),
        TextRect,
        DrawTextBiDiModeFlags(DT_CENTER or DT_SINGLELINE or DT_NOPREFIX));
    end;
  end;
end;

procedure TSPMonthPlanner.ReadItems;
var
  i: Integer;
  Item: TSPPlanItem;
  ColResources: TStringList;
  ResIndex: Integer;
  List: TSPDisplayItems;

  procedure ReadItem(AItem: TSPPlanItem; Offset: Double;
    const Resource: string);
  var
    j: Integer;
  begin
    if CanShowItem(AItem) then
    begin
      if (Resources.Count > 0) and (GroupBy <> grNone) then
        ResIndex := ColResources.IndexOf(Resource)
      else
        ResIndex := 0;

      if ResIndex >= 0 then
      begin
        for j := 0 to WEEK_COUNT - 1 do
        begin
          List := ItemLists[ResIndex * WEEK_COUNT + j];

          if ((AItem.EndTime + Offset) > List.CellStart) and
            ((AItem.StartTime + Offset) < List.CellStart + DAY_COUNT) then
            List.Add(AItem, Offset);
        end;
      end;
    end;
  end;

begin
  for i := 0 to FItemLists.Count - 1 do
  begin
    ItemLists[i].BeginUpdate;
    ItemLists[i].Clear;
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

          if Item.StartTime >= TDateTime(FEndDate) then
            Break;

          if (Item.EndTime > TDateTime(FStartDate)) and
             ((DragPlanner.Source <> Source) or
              (not DragPlanner.IsItemSelected(Item)) or
              ((GroupBy <> grNone) and (Item.Resource <> DragResourceName))) then
            ReadItem(Item, 0, Item.Resource);
        end;

      for i := 0 to DragPlanner.SelectedCount - 1 do
      begin
        Item := DragPlanner.SelectedItems[i];

        if ((Item.StartTime + DragOffset) < TDateTime(FEndDate)) and
          ((Item.EndTime + DragOffset) > TDateTime(FStartDate)) then
          ReadItem(Item, DragOffset, DragResourceName);
      end;
    end else
      if Assigned(Source) then
        for i := 0 to Source.Count - 1 do
        begin
          Item := Source[i];

          if (Item.StartTime) >= TDateTime(FEndDate) then
            Break;

          if (Item.EndTime) > TDateTime(FStartDate) then
            ReadItem(Item, 0, Item.Resource);
        end;
  finally
    ColResources.Free;
  end;

  for i := 0 to FItemLists.Count - 1 do
    ItemLists[i].EndUpdate;

  RefreshContentView;
end;

procedure TSPMonthPlanner.ResourcesChange;
begin
  ApplyViewSettings;
  inherited ResourcesChange;
end;

procedure TSPMonthPlanner.ScalePrintFont(ACanvas: TCanvas; ARect: TRect);
var
  x, y, h, MaxItems: Integer;
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

  h := Trunc(
    (ARect.Bottom - ARect.Top) /
      (1.2 * (HeaderRows + (MaxItems + 1) * RowCount)));
  ACanvas.Font := PrintFont;
  while ACanvas.TextHeight('0') > h do
  begin
    PrintFont.Size := PrintFont.Size - 1;
    ACanvas.Font := PrintFont;
  end;

end;

procedure TSPMonthPlanner.SetDate(const Value: TDate);
var
  AYear, AMonth, ADay: Word;
begin
  DecodeDate(TDateTime(Value), AYear, AMonth, ADay);
  if (AMonth <> Month) or (AYear <> Year) then
  begin
    FDate := TDate(EncodeDate(AYear, AMonth, 1));
    ApplyViewSettings;
    RequestItems(TDateTime(FStartDate), TDateTime(FEndDate));
  end;
end;

procedure TSPMonthPlanner.SetMonth(const Value: Integer);
begin
  SetDate(TDate(EncodeDate(Year, Value, 1)));
end;

procedure TSPMonthPlanner.SetYear(const Value: Integer);
begin
  SetDate(TDate(EncodeDate(Value, Month, 1)));
end;

procedure TSPMonthPlanner.SourceChanged;
begin
  inherited SourceChanged;
  ReadItems;
  RequestItems(TDateTime(FStartDate), TDateTime(FEndDate));
end;

end.
