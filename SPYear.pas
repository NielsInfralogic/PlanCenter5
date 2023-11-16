(* SPYear - Year planner control                                              *)
(*                                                                            *)
(* Shorter Path Planners                                                      *)
(*                                                                            *)
(* Copyright © 2004, 2007 Shorter Path Software                               *)
(* http://www.shorterpath.com                                                 *)
(******************************************************************************)

unit SPYear;

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
  Classes, Windows, Messages, Controls, SysUtils, SPPlanners, Graphics;

type
  TSPYearPlanner = class(TSPBasePlanner)
  private
    FYear: Integer;
    FMonthDays: array[1..12] of Integer;
    FMonthFirstDay: array[1..12] of Integer;
    FItemOffset: Integer;
    FItemPrintOffset: Integer;
    FItemLists: array[1..12] of TSPDisplayItems;
    FFirstMonth: Integer;
    FAltMonthTitles: array[1..12] of string;
    FAltDayTitles: array[0..36, 0..11] of string;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure SetFirstMonth(const Value: Integer);
    procedure SetYear(const Value: Integer);
    procedure ReadValues;
    procedure ReadItems;
    procedure DrawItemBorder(ACanvas: TCanvas; BorderRect: TRect;
      Selected, ExtendsBefore, ExtendsAfter: Boolean);
    function GetAltMonthTitle(AMonth, AYear: Integer): string;
    function GetAltCellText(ACol, ARow: Integer): string;
  protected
    procedure PaintHeaderCorner(ARect: TRect); override;
    procedure PaintBar(ARect: TRect); override;
    procedure PaintContent(ARect: TRect); override;
    procedure SourceChanged; override;
    function ItemHitTest(Item: TSPPlanItem;
      CursorPos: TPoint): TSPItemHit; override;
    function GetItemEditRect(Item: TSPPlanItem;
      ACol, ARow: Integer): TRect; override;
    procedure DoInsertItem(Item: TSPPlanItem); override;
    procedure DoWeekStartChange; override;
    procedure ResourcesChange; override;
    procedure AlternateCalendarChanged; override;
    function FindDisplayItem(Item: TSPPlanItem;
      ACol, ARow: Integer): TSPDisplayItem; override;
    procedure GetDisplayItemRect(DisplayItem: TSPDisplayItem;
      ACol, ARow: Integer; var ItemRect: TRect;
      var ExtendsBefore, ExtendsAfter: Boolean); override;
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
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function IsCellValid(ACol, ARow: Integer): Boolean; override;
    procedure GetCellDates(ACol, ARow: Integer; var StartTime,
      EndTime: TDateTime); override;
    function FindItemAtPos(X, Y: Integer): TSPPlanItem; override;
    property AlternateCalendar;
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
    property WeekStart;
    property PopupMenu;
    property DragMode;
    property DragCursor;
    property Hint;
    property ParentShowHint;
    property ShowHint;
    property Source;
    property Filter default [flAllDay, flPrivate];
    property Year: Integer read FYear write SetYear;
    property FirstMonth: Integer read FFirstMonth write SetFirstMonth default 1;
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
  SInvalidYearError = 'Invalid year value';
  SInvalidMonthError = 'Invalid month value';

implementation

{$IFNDEF VCL4}
{$IFNDEF VCL5}
uses
  Types;
{$ENDIF}
{$ENDIF}

const
  CELL_MARGIN = 2;
  CELL_SPACING = 1;

{ TSPYearPlanner }

constructor TSPYearPlanner.Create(AOwner: TComponent);
var
  i: Integer;
  Col: TSPPlannerColumn;
  CurYear, CurMonth, CurDay: Word;
begin
  inherited Create(AOwner);
  FFirstMonth := 1;

  Ctl3D := True;
  Width := 160;
  Height := 120;
  TabStop := True;

  for i := 1 to 12 do
    FItemLists[i] := TSPDisplayItems.Create;

  for i := 0 to 36 do
  begin
    Col := Columns.Add;
    if (i mod 7 = 5) or (i mod 7 = 6) then
      Col.BackColor := clBtnShadow;
  end;

  DecodeDate(Now, CurYear, CurMonth, CurDay);
  FYear := CurYear;
  ReadValues;
  SelectionFlow := sfHorizontal;
  SetRowCount(12);
  SetAutoSizeRows(True);

  HeaderRows := 1;
  SubHeaderRows := 0;
  FooterRows := 0;

  Perform(CM_FONTCHANGED, 0, 0);
  GroupBy := grNone;
  Filter := [flAllDay, flPrivate];
  Navigate(sdHome, False);
  DoubleBuffered := True;
end;

destructor TSPYearPlanner.Destroy;
var
  i: Integer;
begin
  for i := 1 to 12 do
    FItemLists[i].Free;
  inherited Destroy;
end;

function TSPYearPlanner.FindItemAtPos(X, Y: Integer): TSPPlanItem;
var
  i, Col, Row: Integer;
  ItemRect: TRect;
  ItemList: TSPDisplayItems;
  ExtendsBefore, ExtendsAfter: Boolean;
begin
  Result := nil;
  GetCellAtPos(X, Y, Col, Row);

  if (Col >= 0) and (Row >= 0) then
    if (Col >= FMonthFirstDay[Row + 1]) and
      (Col < FMonthFirstDay[Row + 1] + FMonthDays[Row + 1]) then
    begin
      ItemList := FItemLists[Row + 1];
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

procedure TSPYearPlanner.GetCellDates(ACol, ARow: Integer; var StartTime,
  EndTime: TDateTime);
begin
  inherited GetCellDates(ACol, ARow, StartTime, EndTime);

  if IsCellValid(ACol, ARow) then
  begin
    StartTime :=
      EncodeDate(Year + (ARow + FFirstMonth - 1) div 12,
        (ARow + FFirstMonth - 1) mod 12 + 1,
        ACol - FMonthFirstDay[ARow + 1] + 1);
    EndTime := StartTime + 1;
  end;
end;

function TSPYearPlanner.IsCellValid(ACol, ARow: Integer): Boolean;
begin
  Result := inherited IsCellValid(ACol, ARow);
  if Result then
    Result := (ACol >= FMonthFirstDay[ARow + 1]) and
      (ACol < FMonthDays[ARow + 1] + FMonthFirstDay[ARow + 1]);
end;

procedure TSPYearPlanner.PaintBar(ARect: TRect);
var
  R, EdgeRect, TextRect: TRect;
  s: string;
  i, MonthIndex, HeightCalc: Integer;
begin
  inherited PaintBar(ARect);
  R := ARect;

  Canvas.Brush.Style := bsClear;

  for i := 0 to RowCount - 1 do
  begin
    R.Bottom := R.Top + RowHeights[i];

    MonthIndex := (i + FFirstMonth - 1) mod 12 + 1;
    s := LongMonthNames[MonthIndex];
    if (FFirstMonth <> 1) then
    begin
      if MonthIndex = 1 then
        s := s + ' ' + IntToStr(FYear + 1)
      else
        if i = 0 then
          s := s + ' ' + IntToStr(FYear);
    end;

    if Length(FAltMonthTitles[i + 1]) > 0 then
      s := s + #13#10 + FAltMonthTitles[i + 1];

    TextRect := R;
    HeightCalc := DrawText(Canvas.Handle, {$IFNDEF CLR}PChar{$ENDIF}(s), -1,
      TextRect, DT_CALCRECT or DrawTextBiDiModeFlags(DT_CENTER or DT_NOPREFIX));

    TextRect := R;
    HeightCalc := (R.Bottom - R.Top) - HeightCalc;
    if HeightCalc > 0 then
      InflateRect(TextRect, 0, 0 - HeightCalc div 2);

    DrawText(Canvas.Handle, {$IFNDEF CLR}PChar{$ENDIF}(s), -1, TextRect,
      DrawTextBiDiModeFlags(DT_CENTER or DT_NOPREFIX));

    if i < RowCount - 1 then
    begin
      EdgeRect := R;
      InflateRect(EdgeRect, -1, 1);
      DrawEdge(Canvas.Handle, EdgeRect, EDGE_ETCHED, BF_BOTTOM);
    end;

    R.Top := R.Bottom;
  end;
end;

procedure TSPYearPlanner.PaintContent(ARect: TRect);
var
  x, y, i: Integer;
  R, ItemRect, DateRect: TRect;
  s: string;
  EmptyCellBrush: HBrush;
  SmallFontSize: Integer;
  Col: TSPPlannerColumn;
  LastCol: Integer;
  ItemSelected: Boolean;
  DisplayItem: TSPDisplayItem;
  ExtendsBefore, ExtendsAfter: Boolean;
  ItemColor: TColor;
  CellDrawn: array of Boolean;
  CellSelected: Boolean;

  procedure DrawBorder(BorderRect: TRect; BorderColor: TColor;
    Horz, Vert: Boolean);
  var
    LineRect: TRect;
  begin
    if Horz then
    begin
      LineRect := BorderRect;
      LineRect.Top := LineRect.Bottom - 1;
      if DitherBackground then
        PaintBorder(Canvas, LineRect, BorderColor, True, True)
      else
        PaintBorder(Canvas, LineRect, clDkGray, True, False);
    end;

    if Vert then
    begin
      LineRect := BorderRect;
      if UseRightToLeftAlignment then
        LineRect.Right := LineRect.Left + 1 else
        LineRect.Left := LineRect.Right - 1;
      if DitherBackground then
        PaintBorder(Canvas, LineRect, BorderColor, True, True)
      else
        PaintBorder(Canvas, LineRect, clDkGray, True, False);
    end;
  end;

begin
  EmptyCellBrush := CreateSolidBrush(ColorToRGB(Color));

  SmallFontSize := Font.Size;
  if SmallFontSize >= 8 then
    SmallFontSize := (SmallFontSize * 80) div 100;

  Canvas.Font.Size := SmallFontSize;
  LastCol := Columns.Count - 1;

  SetLength(CellDrawn, Columns.Count);

  R := ARect;
  for y := 0 to RowCount - 1 do
  begin
    R.Bottom := R.Top + RowHeights[y];

    Canvas.Font.Size := SmallFontSize;
    for x := 0 to LastCol do
    begin
      Col := Columns[x];
      R.Left := Col.Left;
      R.Right := Col.Right;

      if (x >= FMonthFirstDay[y + 1]) and
        (x < FMonthFirstDay[y + 1] + FMonthDays[y + 1]) then
      begin
        CellDrawn[x] := DoDrawCell(Canvas, x, y, R,
          IsCellSelected(x, y) and Focused and (SelectedCount = 0));

        if IsCellSelected(x, y) and Focused and (SelectedCount = 0) then
        begin
          Canvas.Brush.Color := clHighlight;
          Canvas.Brush.Style := bsSolid;
          if not CellDrawn[x] then
            Canvas.FillRect(R);
          Canvas.Font.Color := clHighlightText;
        end else
        begin
          if not CellDrawn[x] then
            PaintBackground(Canvas, R, BackgroundColor, Col.BackColor = clNone,
              DitherBackground);
          Canvas.Font.Color := Font.Color;
        end;

        DrawBorder(R, BackgroundColor, y < RowCount - 1, x < LastCol);
      end else
      begin
        CellDrawn[x] := DoDrawCell(Canvas, x, y, R, False);

        if not CellDrawn[x] then
        begin
          if Col.BackColor <> clNone then
          begin
            if DitherBackground then
              PaintBackground(Canvas, R, Color, False, DitherBackground)
            else
              PaintBackground(Canvas, R, cl3DDkShadow, False, DitherBackground);
          end else
            FillRect(Canvas.Handle, R, EmptyCellBrush);
        end;
        DrawBorder(R, Color, y < RowCount - 1, x < LastCol);
      end;
    end;

    Canvas.Font := Font;
    Canvas.Brush.Style := bsClear;

    for i := 0 to FItemLists[y + 1].Count - 1 do
    begin
      DisplayItem := FItemLists[y + 1][i];
      GetDisplayItemRect(DisplayItem, 0, y, ItemRect,
        ExtendsBefore, ExtendsAfter);

      Canvas.Font := Font;
      Canvas.Brush.Style := bsClear;

      if ItemRect.Bottom <= R.Bottom then
      begin
        ItemSelected := IsItemSelected(DisplayItem.Item);

        if not DoDrawItem(DisplayItem.Item, Canvas, ItemRect, ExtendsBefore,
          ExtendsAfter, ItemSelected, (ItemUnderMouse = DisplayItem.Item),
          ContentRect) then
        begin
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
          InflateRect(ItemRect, 0 - CELL_MARGIN, -1);

          DrawItemIcons(Canvas, ItemRect, Source.Images,
            DisplayItem.Item.Icons, UseRightToLeftAlignment);
          InflateRect(ItemRect, 0, 0 - (CELL_MARGIN - 1));
          DrawText(Canvas.Handle,
            {$IFNDEF CLR}PChar{$ENDIF}(DisplayItem.Item.Title), -1, ItemRect,
            DrawTextBiDiModeFlags(DT_NOPREFIX));
        end;
      end else
        DrawMoreBitmap(Canvas,
          Rect(ItemRect.Left, R.Top, ItemRect.Right, R.Bottom));
    end;

    Canvas.Font.Size := SmallFontSize;
    DateRect := R;
    DateRect.Bottom := DateRect.Top + FItemOffset;
    for i := 1 to FMonthDays[y + 1] do
    begin
      x := FMonthFirstDay[y + 1] + i - 1;
      if not CellDrawn[x] then
      begin
        CellSelected := IsCellSelected(x, y) and Focused and (SelectedCount = 0);

        if CellSelected then
          Canvas.Font.Color := clHighlightText
        else
          Canvas.Font.Color := Font.Color;

        s := IntToStr(i);
        DateRect.Top := R.Top;
        DateRect.Bottom := DateRect.Top + FItemOffset;
        DateRect.Left := Columns[x].Left;
        DateRect.Right := Columns[x].Right;
        DrawText(Canvas.Handle, {$IFNDEF CLR}PChar{$ENDIF}(s), -1, DateRect,
          DT_LEFT or DT_SINGLELINE or DT_NOPREFIX);

        if Assigned(AlternateCalendar) and (FAltDayTitles[x, y] <> '') then
        begin
          DateRect.Top := DateRect.Bottom;
          DateRect.Bottom := R.Bottom;
          DrawText(Canvas.Handle, {$IFNDEF CLR}PChar{$ENDIF}(FAltDayTitles[x, y]), -1, DateRect,
            DrawTextBiDiModeFlagsReadingOnly or DT_RIGHT or DT_NOPREFIX);
        end;
      end;
    end;

    R.Top := R.Bottom;
  end;

  Canvas.Font := Font;
  DeleteObject(EmptyCellBrush);
end;

procedure TSPYearPlanner.PaintHeaderCorner(ARect: TRect);
var
  s: string;
begin
  inherited PaintHeaderCorner(ARect);
  Canvas.Brush.Style := bsClear;
  s := IntToStr(FYear);
  if FFirstMonth <> 1 then
    s := s + '-' + IntToStr(FYear + 1);
  DrawText(Canvas.Handle, {$IFNDEF CLR}PChar{$ENDIF}(s), -1, ARect,
    DrawTextBiDiModeFlags(DT_CENTER or DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX));
end;

procedure TSPYearPlanner.SourceChanged;
begin
  inherited SourceChanged;
  ReadItems;
  RequestItems(EncodeDate(Year, FFirstMonth, 1),
    EncodeDate(Year + 1, FFirstMonth, 1));
end;

procedure TSPYearPlanner.ReadValues;
var
  i, j: Integer;
  FirstDay: TDateTime;
  DayIndex, MaxMonth, MonthLength, CurYear, CurMonth: Integer;
begin
  for i := 1 to 12 do
  begin
    CurMonth := FFirstMonth + i - 1;
    CurYear := FYear;
    if CurMonth > 12 then
    begin
      Dec(CurMonth, 12);
      Inc(CurYear);
    end;

    FMonthDays[i] := MonthDays[IsLeapYear(CurYear), CurMonth];
    FirstDay := EncodeDate(CurYear, CurMonth, 1);
    FMonthFirstDay[i] := DayOfWeek(FirstDay) - 1;
    if WeekStart = wsMonday then
    begin
      Dec(FMonthFirstDay[i]);
      if FMonthFirstDay[i] < 0 then
        FMonthFirstDay[i] := 6;
    end;
    FItemLists[i].CellStart := EncodeDate(CurYear, CurMonth, 1);
    FItemLists[i].CellDuration := 1;
    FAltMonthTitles[i] := GetAltMonthTitle(CurMonth, CurYear);
    for j := 0 to 36 do
      FAltDayTitles[j, i - 1] := GetAltCellText(j, i - 1);
  end;

  Columns.BeginUpdate;
  for i := 0 to Columns.Count - 1 do
  begin
    if WeekStart = wsMonday then
    begin
      DayIndex := i mod 7 + 2;
      if DayIndex > 7 then Dec(DayIndex, 7);
    end else
      DayIndex := i mod 7 + 1;
    Columns[i].Header := Copy(ShortDayNames[DayIndex], 1, 1);
  end;
  Columns.EndUpdate;

  MaxMonth := 8;
  for i := 1 to 12 do
  begin
    MonthLength := Length(LongMonthNames[i]);

    if (FFirstMonth <> 1) and ((i = 1) or (i = FFirstMonth)) then
      Inc(MonthLength, 7);

    if MonthLength > MaxMonth then
      MaxMonth := MonthLength;

  end;
  BarCols := MaxMonth + 4;

  if not IsCellValid(FocusCol, FocusRow) then
    Navigate(sdHome, False);
end;

procedure TSPYearPlanner.ReadItems;
var
  i, j: Integer;
  Item: TSPPlanItem;
  StartDate, EndDate, MonthStart, MonthEnd: TDateTime;
begin
  if not Assigned(FItemLists[1]) then Exit;

  for i := 1 to 12 do
  begin
    FItemLists[i].BeginUpdate;
    FItemLists[i].Clear;
  end;

  EndDate := EncodeDate(Year + 1, FFirstMonth, 1);
  StartDate := EncodeDate(Year, FFirstMonth, 1);

  if Assigned(Source) then
    for i := 0 to Source.Count - 1 do
    begin
      Item := Source[i];

      if Item.StartTime >= EndDate then
        Break;

      if ((not Assigned(DragPlanner)) or (DragPlanner.Source <> Source) or
          (not DragPlanner.IsItemSelected(Item))) and
         (Item.EndTime > StartDate) and CanShowItem(Item) then
      begin
        for j := 1 to 12 do
        begin
          MonthStart := FItemLists[j].CellStart;
          MonthEnd := MonthStart + FMonthDays[j];
          if (Item.EndTime > MonthStart) and (Item.StartTime < MonthEnd) then
            FItemLists[j].Add(Item, 0);
        end;
      end;
    end;

  if Assigned(DragPlanner) then
    for i := 0 to DragPlanner.SelectedCount - 1 do
    begin
      Item := DragPlanner.SelectedItems[i];

      if (Item.StartTime + DragOffset < EndDate) and
        (Item.EndTime + DragOffset > StartDate) and CanShowItem(Item) then
      begin
        for j := 1 to 12 do
        begin
          MonthStart := FItemLists[j].CellStart;
          MonthEnd := MonthStart + FMonthDays[j];
          if (Item.EndTime + DragOffset > MonthStart) and
            (Item.StartTime + DragOffset < MonthEnd) then
            FItemLists[j].Add(Item, DragOffset);
        end;
      end;
    end;

  for i := 1 to 12 do
    FItemLists[i].EndUpdate;

  Invalidate;
end;

procedure TSPYearPlanner.SetFirstMonth(const Value: Integer);
begin
  if FFirstMonth <> Value then
  begin
    if (Value < 1) or (Value > 12) then
      raise Exception.Create(SInvalidMonthError);
    FFirstMonth := Value;
    ReadValues;
    ReadItems;
    RequestItems(EncodeDate(Year, FFirstMonth, 1),
      EncodeDate(Year + 1, FFirstMonth, 1));
  end;
end;

procedure TSPYearPlanner.SetYear(const Value: Integer);
begin
  if FYear <> Value then
  begin
    if (Value < 1900) or (Value > 2100) then
      raise Exception.Create(SInvalidYearError);
    FYear := Value;
    ReadValues;
    ReadItems;
    RequestItems(EncodeDate(Year, FFirstMonth, 1),
      EncodeDate(Year + 1, FFirstMonth, 1));
  end;
end;

function TSPYearPlanner.GetItemEditRect(Item: TSPPlanItem; ACol,
  ARow: Integer): TRect;
var
  ExtendsBefore, ExtendsAfter: Boolean;
begin
  Result := inherited GetItemEditRect(Item, ACol, ARow);

  GetItemRect(Item, ACol, ARow, Result, ExtendsBefore, ExtendsAfter);
  if not IsRectEmpty(Result) then
    InflateRect(Result, 0 - CELL_MARGIN, 0 - CELL_MARGIN);
end;

procedure TSPYearPlanner.DoInsertItem(Item: TSPPlanItem);
begin
  Item.AllDayEvent := True;
  Item.AcceptChanges;
  inherited DoInsertItem(Item);
end;

procedure TSPYearPlanner.DoWeekStartChange;
begin
  ReadValues;
  inherited DoWeekStartChange;
end;

procedure TSPYearPlanner.CMFontChanged(var Message: TMessage);
var
  DC: HDC;
  SaveFont: HFont;
  SmallFont: TFont;
  Metrics: TTextMetric;
begin
  inherited;
  SmallFont := TFont.Create;
  SmallFont.Assign(Font);
  if Font.Size >= 8 then
    SmallFont.Size := (Font.Size * 80) div 100;

  DC := GetDC(0);
  SaveFont := SelectObject(DC, SmallFont.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);

  SmallFont.Free;

  FItemOffset := Metrics.tmHeight;
end;

function TSPYearPlanner.FindDisplayItem(Item: TSPPlanItem; ACol,
  ARow: Integer): TSPDisplayItem;
var
  i: Integer;
  ItemList: TSPDisplayItems;
begin
  Result := nil;
  if (ARow >= 0) and (ARow < 12) then
  begin
    ItemList := FItemLists[ARow + 1];
    for i := 0 to ItemList.Count - 1 do
      if ItemList[i].Item = Item then
      begin
        Result := ItemList[i];
        Break;
      end;
  end;
end;

procedure TSPYearPlanner.GetDisplayItemRect(DisplayItem: TSPDisplayItem;
  ACol, ARow: Integer; var ItemRect: TRect; var ExtendsBefore,
  ExtendsAfter: Boolean);
var
  ItemFirstCell, ItemLastCell, FirstCol, LastCol: Integer;
  CellRect: TRect;
begin
  inherited GetDisplayItemRect(DisplayItem, ACol, ARow, ItemRect,
    ExtendsBefore, ExtendsAfter);

  if Assigned(DisplayItem) and (ARow >= 0) and (ARow < 12) then
  begin
    CellRect := ContentRect;
    Inc(CellRect.Top, RowTops[ARow]);
    CellRect.Bottom := CellRect.Top + RowHeights[ARow];

    ItemFirstCell := DisplayItem.StartCell;
    ItemLastCell := DisplayItem.EndCell;

    if ItemFirstCell < 0 then
    begin
      ItemFirstCell := 0;
      ExtendsBefore := True;
    end;

    if ItemLastCell >= FMonthDays[ARow + 1] then
    begin
      ItemLastCell := FMonthDays[ARow + 1] - 1;
      ExtendsAfter := True;
    end;

    FirstCol := ItemFirstCell + FMonthFirstDay[ARow + 1];
    LastCol := ItemLastCell + FMonthFirstDay[ARow + 1];

    if UseRightToLeftAlignment then
    begin
      ItemRect.Right := Columns[FirstCol].Right;
      ItemRect.Left := Columns[LastCol].Left + 1;
    end else
    begin
      ItemRect.Left := Columns[FirstCol].Left;
      ItemRect.Right := Columns[LastCol].Right - 1;
    end;

    ItemRect.Top := CellRect.Top + FItemOffset +
      (LineHeight + CELL_MARGIN * 2 + CELL_SPACING) * DisplayItem.SpanStart;
    if Assigned(AlternateCalendar) then
      Inc(ItemRect.Top, FItemOffset);
    ItemRect.Bottom := ItemRect.Top + LineHeight + CELL_MARGIN * 2;
  end;
end;

procedure TSPYearPlanner.DrawItemBorder(ACanvas: TCanvas; BorderRect: TRect;
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

function TSPYearPlanner.ItemHitTest(Item: TSPPlanItem;
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
    end;
  end;
end;

procedure TSPYearPlanner.PrintBar(ACanvas: TCanvas; AColor, AHeaderColor,
  AHeaderTextColor, ABorderColor: TColor; APage: Integer);
var
  R, TextRect: TRect;
  s: string;
  i, MonthIndex, HeightCalc: Integer;
begin
  inherited PrintBar(ACanvas, AColor, AHeaderColor, AHeaderTextColor,
    ABorderColor, APage);

  R := PrintBarRect;
  ACanvas.Brush.Style := bsClear;

  for i := 0 to RowCount - 1 do
  begin
    R.Bottom := R.Top + PrintRowHeight;

    MonthIndex := (i + FFirstMonth - 1) mod 12 + 1;
    s := LongMonthNames[MonthIndex];
    if (FFirstMonth <> 1) then
    begin
      if MonthIndex = 1 then
        s := s + ' ' + IntToStr(FYear + 1)
      else
        if i = 0 then
          s := s + ' ' + IntToStr(FYear);
    end;

    if Length(FAltMonthTitles[i + 1]) > 0 then
      s := s + #13#10 + FAltMonthTitles[i + 1];

    TextRect := R;
    HeightCalc := DrawText(ACanvas.Handle, {$IFNDEF CLR}PChar{$ENDIF}(s), -1,
      TextRect, DT_CALCRECT or DrawTextBiDiModeFlags(DT_CENTER or DT_NOPREFIX));

    TextRect := R;
    HeightCalc := (R.Bottom - R.Top) - HeightCalc;
    if HeightCalc > 0 then
      InflateRect(TextRect, 0, 0 - HeightCalc div 2);

    DrawText(ACanvas.Handle, {$IFNDEF CLR}PChar{$ENDIF}(s), -1, TextRect,
      DrawTextBiDiModeFlags(DT_CENTER or DT_NOPREFIX));

    if i < RowCount - 1 then
      ACanvas.Polyline([Point(R.Left, R.Bottom), Point(R.Right - 1, R.Bottom)]);

    R.Top := R.Bottom;
  end;

end;

procedure TSPYearPlanner.PrintContent(ACanvas: TCanvas; AColor,
  AHeaderColor, AHeaderTextColor, ABorderColor: TColor; APage: Integer);
var
  SmallFontSize: Integer;
  DisplayItem: TSPDisplayItem;
  R, TextRect, ItemRect: TRect;
  ExtendsBefore, ExtendsAfter: Boolean;
  s: string;
  ItemColor: TColor;
  x, y, i: Integer;
begin
  inherited PrintContent(ACanvas, AColor, AHeaderColor, AHeaderTextColor,
    ABorderColor, APage);

  SmallFontSize := Trunc(0.7 * PrintFont.Size);

  ACanvas.Font.Size := SmallFontSize;
  FItemPrintOffset := ACanvas.TextHeight('0');
  ACanvas.Font := PrintFont;

  for y := 0 to RowCount - 1 do
  begin
    R.Top := PrintContentRect.Top + y * PrintRowHeight;
    R.Bottom := R.Top + PrintRowHeight;

    for x := 0 to Columns.Count - 1 do
    begin
      if UseRightToLeftAlignment then
      begin
        R.Right := PrintContentRect.Right - x * PrintColWidth;
        R.Left := R.Right - PrintColWidth;
      end else
      begin
        R.Left := PrintContentRect.Left + x * PrintColWidth;
        R.Right := R.Left + PrintColWidth;
      end;

      if not DoDrawCell(Canvas, x, y, R, False) then
      begin
        if IsCellValid(x, y) then
        begin
          PaintBackground(ACanvas, R, BackgroundColor,
            Columns[x].BackColor = clNone, False);
          s := IntToStr(1 + x - FMonthFirstDay[y + 1]);
          TextRect := R;
          InflateRect(TextRect, 0 - PrintSpacing, 0 - PrintSpacing);
          ACanvas.Brush.Style := bsClear;
          ACanvas.Font := PrintFont;
          ACanvas.Font.Size := SmallFontSize;
          DrawText(ACanvas.Handle, {$IFNDEF CLR}PChar{$ENDIF}(s), -1,
            TextRect, DT_LEFT or DT_NOPREFIX);
          if Assigned(AlternateCalendar) and (FAltDayTitles[x, y] <> '') then
          begin
            ACanvas.Font.Color := AHeaderTextColor;
            Inc(TextRect.Top, FItemPrintOffset);
            s := FAltDayTitles[x, y];
            DrawText(ACanvas.Handle, {$IFNDEF CLR}PChar{$ENDIF}(s), -1,
              TextRect,
              DrawTextBiDiModeFlagsReadingOnly or DT_RIGHT or DT_NOPREFIX);
          end;
          ACanvas.Font := PrintFont;
        end else
          if Columns[x].BackColor <> clNone then
            PaintBackground(ACanvas, R, clGray, True, False);
      end;

      ACanvas.Brush.Style := bsClear;
      ACanvas.Pen.Style := psSolid;
      ACanvas.Pen.Color := ABorderColor;
      ACanvas.Pen.Width := PrintLineWidth;
      ACanvas.Rectangle(R.Left, R.Top, R.Right, R.Bottom);
    end;

    R.Left := PrintContentRect.Left;
    R.Right := PrintContentRect.Right;

    for i := 0 to FItemLists[y + 1].Count - 1 do
    begin
      DisplayItem := FItemLists[y + 1][i];

      GetDisplayItemPrintRect(DisplayItem, 0, y, ItemRect,
        ExtendsBefore, ExtendsAfter);

      if ItemRect.Bottom <= R.Bottom then
      begin
        ACanvas.Font := PrintFont;
        if not DoDrawItem(DisplayItem.Item, ACanvas, ItemRect, ExtendsBefore,
          ExtendsAfter, False, False, PrintContentRect) then
        begin
          ItemColor := DisplayItem.Item.Color;
          if ItemColor = clNone then
            ItemColor := clWhite;
          ItemColor := GetMidColor(ItemColor, clWhite);

          ACanvas.Brush.Style := bsSolid;
          ACanvas.Brush.Color := ItemColor;
          ACanvas.FillRect(ItemRect);

          ACanvas.Pen.Width := PrintLineWidth div 2;
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

          InflateRect(ItemRect, 0 - PrintSpacing, 0 - PrintSpacing);

          PrintItemIcons(ACanvas, ItemRect, Source.Images,
            DisplayItem.Item.Icons, UseRightToLeftAlignment, ItemColor);

          ACanvas.Brush.Style := bsClear;

          DrawText(ACanvas.Handle,
            {$IFNDEF CLR}PChar{$ENDIF}(DisplayItem.Item.Title), -1, ItemRect,
            DrawTextBiDiModeFlags(DT_NOPREFIX));
        end;
      end;
    end;
  end;
end;

procedure TSPYearPlanner.ScalePrintFont(ACanvas: TCanvas; ARect: TRect);
var
  x, y, h, MaxItems: Integer;
  DisplayItem: TSPDisplayItem;
begin
  MaxItems := 1;

  for y := 1 to 12 do
    for x := 0 to FItemLists[y].Count - 1 do
    begin
      DisplayItem := TSPDisplayItem(FItemLists[y][x]);
      if DisplayItem.SpanRange > MaxItems then
        MaxItems := DisplayItem.SpanRange;
    end;

  h := Trunc((ARect.Bottom - ARect.Top) / (((0.7 + MaxItems) * 12 + 1) * 1.4));
  ACanvas.Font := PrintFont;
  while ACanvas.TextHeight('0') > h do
  begin
    PrintFont.Size := PrintFont.Size - 1;
    ACanvas.Font := PrintFont;
  end;
end;

procedure TSPYearPlanner.GetDisplayItemPrintRect(
  DisplayItem: TSPDisplayItem; ACol, ARow: Integer; var ItemRect: TRect;
  var ExtendsBefore, ExtendsAfter: Boolean);
var
  ItemFirstCell, ItemLastCell, FirstCol, LastCol: Integer;
  CellRect: TRect;
begin
  inherited GetDisplayItemRect(DisplayItem, ACol, ARow, ItemRect,
    ExtendsBefore, ExtendsAfter);

  if Assigned(DisplayItem) and (ARow >= 0) and (ARow < 12) then
  begin
    CellRect := PrintContentRect;
    Inc(CellRect.Top, ARow * PrintRowHeight);
    CellRect.Bottom := CellRect.Top + PrintRowHeight;

    ItemFirstCell := DisplayItem.StartCell;
    ItemLastCell := DisplayItem.EndCell;

    if ItemFirstCell < 0 then
    begin
      ItemFirstCell := 0;
      ExtendsBefore := True;
    end;

    if ItemLastCell >= FMonthDays[ARow + 1] then
    begin
      ItemLastCell := FMonthDays[ARow + 1] - 1;
      ExtendsAfter := True;
    end;

    FirstCol := ItemFirstCell + FMonthFirstDay[ARow + 1];
    LastCol := ItemLastCell + FMonthFirstDay[ARow + 1];

    if UseRightToLeftAlignment then
    begin
      ItemRect.Right := CellRect.Right - FirstCol * PrintColWidth;
      ItemRect.Left := CellRect.Right - (LastCol + 1) * PrintColWidth;
      if not ExtendsBefore then
        Dec(ItemRect.Right, PrintSpacing * 2);
      if not ExtendsAfter then
        Inc(ItemRect.Left, PrintSpacing * 2);
    end else
    begin
      ItemRect.Left := CellRect.Left + FirstCol * PrintColWidth;
      ItemRect.Right := CellRect.Left + (LastCol + 1) * PrintColWidth;
      if not ExtendsBefore then
        Inc(ItemRect.Left, PrintSpacing * 2);
      if not ExtendsAfter then
        Dec(ItemRect.Right, PrintSpacing * 2);
    end;

    InflateRect(ItemRect, 0 - PrintLineWidth div 2, 0);

    ItemRect.Top := CellRect.Top + FItemPrintOffset + 2 * PrintSpacing +
      (PrintTextHeight + PrintSpacing * 4) * DisplayItem.SpanStart;
    if Assigned(AlternateCalendar) then
      Inc(ItemRect.Top, FItemPrintOffset);
    ItemRect.Bottom := ItemRect.Top + PrintTextHeight + PrintSpacing * 2;
  end;

end;

function TSPYearPlanner.GetAltMonthTitle(AMonth, AYear: Integer): string;
var
  AltFirst, AltLast: string;
begin
  Result := '';
  if Assigned(AlternateCalendar) then
  begin
    AltFirst := AlternateCalendar.GetMonthName(EncodeDate(AYear, AMonth, 1));

    AltLast := AlternateCalendar.GetMonthName(
      EncodeDate(AYear, AMonth, MonthDays[IsLeapYear(AYear), AMonth]));
  end;

  if (AltFirst <> '') and (AltLast <> '') then
  begin
    if AltFirst <> AltLast then
      Result := AltFirst + '-' + AltLast
    else
      Result := AltFirst;
  end else
    Result := AltFirst + AltLast;
end;

function TSPYearPlanner.GetAltCellText(ACol, ARow: Integer): string;
var
  StartTime, EndTime: TDateTime;
begin
  Result := '';

  if Assigned(AlternateCalendar) then
  begin
    GetCellDates(ACol, ARow, StartTime, EndTime);
    if StartTime <> 0 then
      Result := AlternateCalendar.GetDayName(StartTime);
  end;
end;

procedure TSPYearPlanner.AlternateCalendarChanged;
begin
  inherited AlternateCalendarChanged;
  ReadValues;
end;

procedure TSPYearPlanner.ResourcesChange;
begin
  inherited ResourcesChange;
  ReadItems;
end;

end.
