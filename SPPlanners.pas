(******************************************************************************)
(* SPPlanners - Base planner classes                                          *)
(*                                                                            *)
(* Shorter Path Planners                                                      *)
(*                                                                            *)
(* Copyright © 2004, 2007 Shorter Path Software                               *)
(* http://www.shorterpath.com                                                 *)
(******************************************************************************)

unit SPPlanners;

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

{$IFDEF CONDITIONALEXPRESSIONS}
{$IF RTLVersion >= 14.0}
{$WARN SYMBOL_PLATFORM OFF}
{$IFNDEF CLR}
{$DEFINE SP_FAST_DITHER}
{$ENDIF}
{$IFEND}
{$IF RTLVersion >= 15.0}
{$DEFINE SP_HAS_THEMES}
{$IFEND}
{$ENDIF}

interface

uses
  Classes, Windows, Messages, Controls, Forms, Graphics, SysUtils, ImgList,
  StdCtrls, system.UITypes
  {$IFDEF SP_HAS_THEMES}
  , Themes, UxTheme
  {$ENDIF}
  ;

const
  SUB_HEADER_ROW = -1;
  INVALID_ROW = -2;
  INVALID_COL = -1;

type
  TSPPlannerLink = class;
  TSPCustomSource = class;

  {$IFDEF VCL4}
  TImageIndex = type Integer;
  {$ENDIF}

  TSPPlanIcons = class
  private
    FCount: Integer;
    FArraySize: Integer;
    FIcons: array of TImageIndex;
    FOnChange: TNotifyEvent;
    function GetItem(Index: Integer): TImageIndex;
    procedure SetItem(Index: Integer; const Value: TImageIndex);
  protected
    procedure Change;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  public
    constructor Create;
    function Add(Value: TImageIndex): Integer;
    procedure Delete(Index: Integer);
    procedure Clear;
    procedure Assign(Source: TSPPlanIcons);
    property Count: Integer read FCount;
    property Items[Index: Integer]: TImageIndex read GetItem
      write SetItem; default;
  end;

  TSPBusyStatus = (bsFree, bsTentative, bsBusy, bsOutOfOffice);

  TSPPlanItem = class
  private
    FSource: TSPCustomSource;
    FAllDayEvent: Boolean;
    FData: TObject;
    FTitle: string;
    FEndTime: TDateTime;
    FStartTime: TDateTime;
    FIcons: TSPPlanIcons;
    FColor: TColor;
    FIsPrivate: Boolean;
    FResource: string;
    FBusyStatus: TSPBusyStatus;
    FReadOnly: Boolean;
    FSavedAllDayEvent: Boolean;
    FSavedTitle: string;
    FSavedEndTime: TDateTime;
    FSavedStartTime: TDateTime;
    FSavedColor: TColor;
    FSavedIsPrivate: Boolean;
    FSavedResource: string;
    FSavedBusyStatus: TSPBusyStatus;
    FSavedReadOnly: Boolean;
    FModified: Boolean;
    function GetDuration: TDateTime;
    procedure SetAllDayEvent(const Value: Boolean);
    procedure SetEndTime(const Value: TDateTime);
    procedure SetIcons(const Value: TSPPlanIcons);
    procedure SetStartTime(const Value: TDateTime);
    procedure SetTitle(const Value: string);
    procedure SetColor(const Value: TColor);
    procedure IconsChange(Sender: TObject);
    procedure SetIsPrivate(const Value: Boolean);
    procedure SetResource(const Value: string);
    procedure SetBusyStatus(const Value: TSPBusyStatus);
    procedure SetReadOnly(const Value: Boolean);
  protected
    procedure Change; dynamic;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Save;
    procedure Revert;
    procedure AcceptChanges;
    procedure Delete;
    procedure MoveBy(Value: Double);
    procedure Assign(ASource: TSPPlanItem); virtual;
    property Source: TSPCustomSource read FSource;
    property Title: string read FTitle write SetTitle;
    property AllDayEvent: Boolean read FAllDayEvent write SetAllDayEvent;
    property StartTime: TDateTime read FStartTime write SetStartTime;
    property EndTime: TDateTime read FEndTime write SetEndTime;
    property Duration: TDateTime read GetDuration;
    property Icons: TSPPlanIcons read FIcons write SetIcons;
    property Color: TColor read FColor write SetColor;
    property IsPrivate: Boolean read FIsPrivate write SetIsPrivate;
    property Resource: string read FResource write SetResource;
    property ReadOnly: Boolean read FReadOnly write SetReadOnly;
    property BusyStatus: TSPBusyStatus read FBusyStatus write SetBusyStatus;
    property Data: TObject read FData write FData;
    property Modified: Boolean read FModified;
  end;

  TSPPlanItemClass = class of TSPPlanItem;
  
  TSPPlanItemEvent = procedure(Sender: TObject; Item: TSPPlanItem) of object;
  TSPRequestEvent = procedure(Sender: TObject;
    StartTime, EndTime: TDateTime) of object;

  TSPCustomSource = class(TComponent)
  private
    FClients: TList;
    FItems: TList;
    FChanged: Boolean;
    FUpdateCount: Integer;
    FImageChangeLink: TChangeLink;
    FOnChange: TNotifyEvent;
    FOnItemDelete: TSPPlanItemEvent;
    FOnItemChange: TSPPlanItemEvent;
    FOnRequestItems: TSPRequestEvent;
    FImages: TCustomImageList;
    FOnItemSave: TSPPlanItemEvent;
    FReadOnly: Boolean;
    FPlanItemClass: TSPPlanItemClass;
    FRequests: TList;
    function GetCount: Integer;
    function GetItems(Index: Integer): TSPPlanItem;
    procedure Sort;
    procedure SetImages(const Value: TCustomImageList);
    procedure ImageListChange(Sender: TObject);
  protected
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure RegisterChanges(Value: TSPPlannerLink);
    procedure UnRegisterChanges(Value: TSPPlannerLink);
    procedure Change; dynamic;
    procedure ItemChange(Item: TSPPlanItem); dynamic;
    procedure ItemDelete(Item: TSPPlanItem); dynamic;
    procedure ItemSave(Item: TSPPlanItem); dynamic;
    procedure DoRequestItems(StartTime, EndTime: TDateTime); dynamic;
    property PlanItemClass: TSPPlanItemClass read FPlanItemClass write FPlanItemClass;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default False;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnItemChange: TSPPlanItemEvent read FOnItemChange
      write FOnItemChange;
    property OnItemDelete: TSPPlanItemEvent read FOnItemDelete
      write FOnItemDelete;
    property OnItemSave: TSPPlanItemEvent read FOnItemSave write FOnItemSave;
    property OnRequestItems: TSPRequestEvent read FOnRequestItems
      write FOnRequestItems;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure Remove(Item: TSPPlanItem);
    procedure Delete(Index: Integer);
    function Add: TSPPlanItem;
    function AddItem(const Resource, Title: string;
      StartTime, EndTime: TDateTime; AllDayEvent: Boolean; IsPrivate: Boolean;
      Color: TColor; BusyStatus: TSPBusyStatus): TSPPlanItem;
    function IndexOf(Item: TSPPlanItem): Integer;
    procedure Save;
    procedure Revert;
    procedure AcceptChanges;
    procedure RequestItems(StartTime, EndTime: TDateTime);
    procedure RequestAllItems;
    procedure Clear;
    procedure DeleteItem(Item: TSPPlanItem); overload;
    procedure DeleteItem(Index: Integer); overload;
    function CanModify: Boolean; virtual;
    property Items[Index: Integer]: TSPPlanItem read GetItems; default;
    property Count: Integer read GetCount;
    property Images: TCustomImageList read FImages write SetImages;
  end;

  TSPPlannerLink = class
  private
    FSender: TSPCustomSource;
    FOnChange: TNotifyEvent;
  public
    destructor Destroy; override;
    procedure Change; dynamic;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Sender: TSPCustomSource read FSender write FSender;
  end;

  TSPCustomCalendarProvider = class(TComponent)
  private
    FDate: TDateTime;
    procedure SetDate(const Value: TDateTime);
  protected
    FDayName: string;
    FMonthName: string;
    FYearName: string;
  public
    constructor Create(AOwner: TComponent); override;
    property Date: TDateTime read FDate write SetDate;
    property DayName: string read FDayName;
    property MonthName: string read FMonthName;
    property YearName: string read FYearName;
    procedure GetNames(ADate: TDateTime;
      out ADayName, AMonthName, AYearName: string); virtual; abstract;
    function GetDayName(ADate: TDateTime): string;
    function GetMonthName(ADate: TDateTime): string;
    function GetYearName(ADate: TDateTime): string;
  end;

  TSPDisplayItems = class;

  TSPDisplayItem = class
  private
    FOwner: TSPDisplayItems;
    FSpanEnd: Integer;
    FSpanRange: Integer;
    FEndCell: Integer;
    FStartCell: Integer;
    FSpanStart: Integer;
    FItem: TSPPlanItem;
    FEndTimeMarker: Double;
    FStartTimeMarker: Double;
    FOffset: Double;
  protected
    procedure Change;
  public
    constructor Create(AOwner: TSPDisplayItems; AItem: TSPPlanItem;
      AOffset: Double);
    destructor Destroy; override;
    property Item: TSPPlanItem read FItem;
    property StartCell: Integer read FStartCell;
    property EndCell: Integer read FEndCell;
    property StartTimeMarker: Double read FStartTimeMarker;
    property EndTimeMarker: Double read FEndTimeMarker;
    property SpanRange: Integer read FSpanRange;
    property SpanStart: Integer read FSpanStart;
    property SpanEnd: Integer read FSpanEnd;
  end;

  TSPDisplayItems = class
  private
    FList: TList;
    FUpdateCount: Integer;
    FCellStart: TDateTime;
    FCellDuration: TDateTime;
    procedure CalcItemCells(DisplayItem: TSPDisplayItem);
    procedure SetGroupSpans(StartIndex, EndIndex: Integer);
    procedure CalculateSpans;
    function GetCount: Integer;
    function GetItem(Index: Integer): TSPDisplayItem;
    procedure SetCellDuration(const Value: TDateTime);
    procedure SetCellStart(const Value: TDateTime);
  protected
    procedure Change(Item: TSPDisplayItem);
  public
    constructor Create;
    destructor Destroy; override;
    procedure BeginUpdate;
    procedure EndUpdate;
    function Add(Item: TSPPlanItem; Offset: Double): TSPDisplayItem;
    procedure Delete(Index: Integer);
    procedure Remove(DisplayItem: TSPDisplayItem);
    procedure Clear;
    property Items[Index: Integer]: TSPDisplayItem read GetItem; default;
    property Count: Integer read GetCount;
    property CellStart: TDateTime read FCellStart write SetCellStart;
    property CellDuration: TDateTime read FCellDuration write SetCellDuration;
  end;

  TSPBasePlanner = class;

  TSPWeekStart = (wsSunday, wsMonday);
  TSPSelectionFlow = (sfHorizontal, sfVertical);

  TSPPlannerColumn = class(TCollectionItem)
  private
    FHeader: string;
    FBackColor: TColor;
    FImageIndex: TImageIndex;
    FLeft: Integer;
    FRight: Integer;
    procedure SetBackColor(const Value: TColor);
    procedure SetHeader(const Value: string);
    procedure SetImageIndex(const Value: TImageIndex);
  public
    constructor Create(Collection: TCollection); override;
    property Left: Integer read FLeft;
    property Right: Integer read FRight;
  published
    property Header: string read FHeader write SetHeader;
    property ImageIndex: TImageIndex read FImageIndex write SetImageIndex;
    property BackColor: TColor read FBackColor
      write SetBackColor default clNone;
  end;

  TSPPlannerColumns = class(TCollection)
  private
    FPlanner: TSPBasePlanner;
    procedure SetItem(Index: Integer; Value: TSPPlannerColumn);
    function GetItem(Index: Integer): TSPPlannerColumn;
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(Planner: TSPBasePlanner);
    function Add: TSPPlannerColumn;
    property Items[Index: Integer]: TSPPlannerColumn read GetItem
      write SetItem; default;
  end;

  TSPPlannerResource = class(TCollectionItem)
  private
    FName: string;
    FImageIndex: TImageIndex;
    FColor: TColor;
    procedure SetImageIndex(const Value: TImageIndex);
    procedure SetName(const Value: string);
    procedure SetColor(const Value: TColor);
  protected
    procedure AssignTo(Dest: TPersistent); override;
    function GetDisplayName: string; override;
    procedure SetDisplayName(const Value: string); override;
  public
    constructor Create(Collection: TCollection); override;
  published
    property Color: TColor read FColor write SetColor default clNone;
    property Name: string read FName write SetName;
    property ImageIndex: TImageIndex read FImageIndex
      write SetImageIndex default -1;
  end;

  TSPPlannerResources = class(TCollection)
  private
    FPlanner: TSPBasePlanner;
    procedure SetItem(Index: Integer; Value: TSPPlannerResource);
    function GetItem(Index: Integer): TSPPlannerResource;
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(Planner: TSPBasePlanner);
    function Add: TSPPlannerResource;
    property Items[Index: Integer]: TSPPlannerResource read GetItem
      write SetItem; default;
  end;

  TSPInplaceEdit = class(TCustomEdit)
  private
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TSPItemResize = (irNone, irStart, irEnd);
  TSPItemHit = (ihNone, ihLeft, ihTop, ihRight, ihBottom, ihSelect, ihContent);
  TSPGroupBy = (grNone, grDate, grResource);
  TSPScrollDirection =
    (sdLeft, sdRight, sdUp, sdDown, sdPrior, sdNext, sdHome, sdEnd);
  TSPFilter = set of (flNormal, flAllDay, flPrivate);
  TSPClockFormat = (cfLocaleDefault, cf24Hours, cf12Hours);
  TSPThemeStyle = (tsRebar, tsTabSheet, tsTreeView, tsTrackThumb,
    tsTrackThumbHot, tsActiveCaption, tsInactiveCaption, tsFlashCaption);

  TSPDrawItemEvent = procedure(Sender: TObject; Item: TSPPlanItem;
    ACanvas: TCanvas; ItemRect: TRect; ExtendsBefore, ExtendsAfter,
    Selected, Highlighted: Boolean; ClipRect: TRect;
    var Drawn: Boolean) of object;
  TSPDrawCellEvent = procedure(Sender: TObject; ACanvas: TCanvas;
    ACol, ARow: Integer; CellRect: TRect; Selected: Boolean;
    var Drawn: Boolean) of object;
  TSPItemHintEvent = procedure(Sender: TObject; Item: TSPPlanItem;
    var ItemHint: string) of object;

  TSPBasePlanner = class(TCustomControl)
  private
    FSource: TSPCustomSource;
    FLink: TSPPlannerLink;
    FBorderStyle: TBorderStyle;
    FFooterHeight: Integer;
    FHeaderHeight: Integer;
    FBarWidth: Integer;
    FSubHeaderHeight: Integer;
    FLineHeight: Integer;
    FCharWidth: Integer;
    FHeaderRect: TRect;
    FSubHeaderRect: TRect;
    FHeaderCornerRect: TRect;
    FBarRect: TRect;
    FContentRect: TRect;
    FFooterRect: TRect;
    FRowHeights: array of Integer;
    FRowTops: array of Integer;
    FColumns: TSPPlannerColumns;
    FResources: TSPPlannerResources;
    FAutoSizeRows: Boolean;
    FRowCount: Integer;
    FHeaderRows: Integer;
    FSubHeaderRows: Integer;
    FBarCols: Integer;
    FFooterRows: Integer;
    FSelection: TRect;
    FSelectionFlow: TSPSelectionFlow;
    FItemUnderMouse: TSPPlanItem;
    FStartSelectCol: Integer;
    FStartSelectRow: Integer;
    FFocusCol: Integer;
    FFocusRow: Integer;
    FSelectedItems: TList;
    FAllowInplaceEdit: Boolean;
    FAllowResize: Boolean;
    FItemResize: TSPItemResize;
    FItemHit: TSPItemHit;
    FReadOnly: Boolean;
    FItemToEdit: TSPPlanItem;
    FItemToEditCol: Integer;
    FItemToEditRow: Integer;
    FEditor: TSPInplaceEdit;
    FEditedItem: TSPPlanItem;
    FEditingNewItem: Boolean;
    FOnInsertItem: TSPPlanItemEvent;
    FWeekStart: TSPWeekStart;
    FGroupBy: TSPGroupBy;
    FTopRow: Integer;
    FDitherBackground: Boolean;
    FBackgroundColor: TColor;
    FDragPlanner: TSPBasePlanner;
    FDragOffset: Double;
    FDragDayOffset: Double;
    FDragResourceName: string;
    FCopyOnDrop: Boolean;
    FFilter: TSPFilter;
    FAlternateCalendar: TSPCustomCalendarProvider;
    FPrintFont: TFont;
    FPrintColWidth: Integer;
    FPrintTextHeight: Integer;
    FPrintLineWidth: Integer;
    FPrintRowHeight: Integer;
    FPrintRowLines: Integer;
    FPrintSpacing: Integer;
    FPrintHeaderRect: TRect;
    FPrintFooterRect: TRect;
    FPrintCornerRect: TRect;
    FPrintBarRect: TRect;
    FPrintContentRect: TRect;
    FPrintSubHeaderRect: TRect;
    FOnDrawItem: TSPDrawItemEvent;
    FOnDrawCell: TSPDrawCellEvent;
    FOnItemHint: TSPItemHintEvent;
    FClockFormat: TSPClockFormat;
    FDisplayClockFormat: TSPClockFormat;
    FDragAllDayItems: Boolean;
    FRowHeight: Integer;
    FDragStartTime: TDateTime;
    FThemeStyle: TSPThemeStyle;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
    {$IFDEF SP_HAS_THEMES}
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    {$ENDIF}
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
    procedure WMTimer(var Message: TWMTimer); message WM_TIMER;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    procedure CMWantSpecialKey(var Message: TWMKey); message CM_WANTSPECIALKEY;
    procedure SetSource(const Value: TSPCustomSource);
    procedure SetBorderStyle(const Value: TBorderStyle);
    procedure CalcCharSize;
    procedure CalcDisplayRects;
    function CanModifySelected: Boolean;
    procedure AdjustRowHeights;
    procedure LinkChange(Sender: TObject);
    procedure SetHeaderRows(const Value: Integer);
    procedure SetSubHeaderRows(const Value: Integer);
    procedure SetBarCols(const Value: Integer);
    procedure SetFooterRows(const Value: Integer);
    procedure SetSelection(const Value: TRect);
    procedure SetSelectionFlow(const Value: TSPSelectionFlow);
    function GetSelectedCount: Integer;
    function GetSelectedItems(Index: Integer): TSPPlanItem;
    procedure SetRowHeight(const Value: Integer);
    function GetRowHeights(Index: Integer): Integer;
    procedure SetWeekStart(const Value: TSPWeekStart);
    procedure SetGroupBy(const Value: TSPGroupBy);
    procedure SetResources(const Value: TSPPlannerResources);
    procedure SetTopRow(const Value: Integer);
    procedure SetDitherBackground(const Value: Boolean);
    procedure SetBackgroundColor(const Value: TColor);
    function GetRowTops(Index: Integer): Integer;
    procedure SetFilter(const Value: TSPFilter);
    procedure SetPrintFont(const Value: TFont);
    procedure SetAlternateCalendar(const Value: TSPCustomCalendarProvider);
    procedure SetClockFormat(const Value: TSPClockFormat);
    procedure ApplyClockFormat;
    {$IFNDEF SP_FAST_DITHER}
    procedure DitheredRect(ACanvas: TCanvas; ARect: TRect;
      BackColor, ForeColor: TColor);
    {$ENDIF}
    procedure DragScrollTimer;
    procedure SendMouseMove;
    procedure SetThemeStyle(const Value: TSPThemeStyle);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CalcAreaSizes; virtual;
    procedure CalcScrollBars; virtual;
    {$IFDEF SP_HAS_THEMES}
    function GetBackgroundElementDetails: TThemedElementDetails; virtual;
    function GetBorderElementDetails: TThemedElementDetails; virtual;
    {$ENDIF}
    procedure FillBackgroundRect(ARect: TRect); virtual;
    procedure PaintHeader(ARect: TRect); virtual;
    procedure PaintSubHeader(ARect: TRect); virtual;
    procedure PaintHeaderCorner(ARect: TRect); virtual;
    procedure PaintBar(ARect: TRect); virtual;
    procedure PaintContent(ARect: TRect); virtual;
    procedure PaintFooter(ARect: TRect); virtual;
    procedure Paint; override;
    procedure DisplayRectsChanged; virtual;
    procedure DrawMoreBitmap(ACanvas: TCanvas; ARect: TRect);
    procedure SourceChanged; virtual;
    procedure FilterChanged; virtual;
    procedure AlternateCalendarChanged; virtual;
    procedure ClockFormatChanged; virtual;
    procedure SetAutoSizeRows(const Value: Boolean);
    procedure SetRowCount(const Value: Integer);
    function GetMidColor(Color1, Color2: TColor): TColor;
    procedure Navigate(Direction: TSPScrollDirection; Select: Boolean);
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure RequestItems(StartTime, EndTime: TDateTime);
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    function DoMouseWheelDown(Shift: TShiftState;
      MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState;
      MousePos: TPoint): Boolean; override;
    function FindDisplayItem(Item: TSPPlanItem;
      ACol, ARow: Integer): TSPDisplayItem; virtual;
    procedure GetDisplayItemRect(DisplayItem: TSPDisplayItem;
      ACol, ARow: Integer; var ItemRect: TRect;
      var ExtendsBefore, ExtendsAfter: Boolean); virtual;
    procedure GetItemRect(Item: TSPPlanItem; ACol, ARow: Integer;
      var ItemRect: TRect; var ExtendsBefore, ExtendsAfter: Boolean); virtual;
    procedure GetDisplayItemPrintRect(DisplayItem: TSPDisplayItem;
      ACol, ARow: Integer; var ItemRect: TRect;
      var ExtendsBefore, ExtendsAfter: Boolean); virtual;
    procedure GetItemPrintRect(Item: TSPPlanItem; ACol, ARow: Integer;
      var ItemRect: TRect; var ExtendsBefore, ExtendsAfter: Boolean); virtual;
    function ItemHitTest(Item: TSPPlanItem;
      CursorPos: TPoint): TSPItemHit; virtual;
    function CanShowItem(Item: TSPPlanItem): Boolean; virtual;
    function DoDrawItem(Item: TSPPlanItem; ACanvas: TCanvas; ItemRect: TRect;
      ExtendsBefore, ExtendsAfter, Selected, Highlighted: Boolean;
      ClipRect: TRect): Boolean; dynamic;
    function DoDrawCell(ACanvas: TCanvas; ACol, ARow: Integer; CellRect: TRect;
      Selected: Boolean): Boolean; dynamic;
    procedure DoItemHint(Item: TSPPlanItem; var ItemHint: string); dynamic;
    procedure Click; override;
    procedure DblClick; override;
    procedure EditItem(Item: TSPPlanItem);
    function GetItemEditRect(Item: TSPPlanItem;
      ACol, ARow: Integer): TRect; virtual;
    procedure CloseEditor(Apply: Boolean);
    procedure DoInsertItem(Item: TSPPlanItem); dynamic;
    procedure DoWeekStartChange; dynamic;
    procedure ResourcesChange; virtual;
    procedure RefreshContentView;
    procedure FillGradientRect(ACanvas: TCanvas; ARect: TRect;
      StartColor, EndColor: TColor; Horizontal: Boolean = False);
    procedure DrawGlow(ACanvas: TCanvas; ARect: TRect);
    procedure DrawItemIcons(ACanvas: TCanvas; var ItemRect: TRect;
      AImages: TCustomImageList; AIcons: TSPPlanIcons; RTL: Boolean);
    procedure PrintItemIcons(ACanvas: TCanvas; var ItemRect: TRect;
      AImages: TCustomImageList; AIcons: TSPPlanIcons; RTL: Boolean;
      ItemColor: TColor);
    procedure PaintBackground(ACanvas: TCanvas; ARect: TRect; AColor: TColor;
      Active, Dithered: Boolean);
    procedure PaintBorder(ACanvas: TCanvas; ARect: TRect; AColor: TColor;
      Dark, Dithered: Boolean);
    procedure DrawShadow(ACanvas: TCanvas; ARect: TRect);
    procedure BusyRect(ACanvas: TCanvas; ARect: TRect;
      BusyStatus: TSPBusyStatus);
    procedure DrawBarMoreBitmaps(ACanvas: TCanvas; ARect: TRect;
      Up, Down, RTL: Boolean);
    procedure ScalePrintFont(ACanvas: TCanvas; ARect: TRect); virtual;
    procedure InitPrintSettings(ACanvas: TCanvas; ARect: TRect;
      AFit: Boolean); virtual;
    procedure PrintHeader(ACanvas: TCanvas;
      AColor, AHeaderColor, AHeaderTextColor, ABorderColor: TColor;
      APage: Integer); virtual;
    procedure PrintSubHeader(ACanvas: TCanvas;
      AColor, AHeaderColor, AHeaderTextColor, ABorderColor: TColor;
      APage: Integer); virtual;
    procedure PrintHeaderCorner(ACanvas: TCanvas;
      AColor, AHeaderColor, AHeaderTextColor, ABorderColor: TColor;
      APage: Integer); virtual;
    procedure PrintBar(ACanvas: TCanvas;
      AColor, AHeaderColor, AHeaderTextColor, ABorderColor: TColor;
      APage: Integer); virtual;
    procedure PrintContent(ACanvas: TCanvas;
      AColor, AHeaderColor, AHeaderTextColor, ABorderColor: TColor;
      APage: Integer); virtual;
    procedure PrintFooter(ACanvas: TCanvas;
      AColor, AHeaderColor, AHeaderTextColor, ABorderColor: TColor;
      APage: Integer); virtual;
    property LineHeight: Integer read FLineHeight;
    property CharWidth: Integer read FCharWidth;
    property Columns: TSPPlannerColumns read FColumns;
    property Resources: TSPPlannerResources read FResources write SetResources;
    property HeaderRows: Integer read FHeaderRows write SetHeaderRows;
    property SubHeaderRows: Integer read FSubHeaderRows write SetSubHeaderRows;
    property BarCols: Integer read FBarCols write SetBarCols;
    property FooterRows: Integer read FFooterRows write SetFooterRows;
    property SelectionFlow: TSPSelectionFlow read FSelectionFlow
      write SetSelectionFlow;
    property ItemUnderMouse: TSPPlanItem read FItemUnderMouse;
    property FocusCol: Integer read FFocusCol;
    property FocusRow: Integer read FFocusRow;
    property HeaderRect: TRect read FHeaderRect;
    property SubHeaderRect: TRect read FSubHeaderRect;
    property HeaderCornerRect: TRect read FHeaderCornerRect;
    property BarRect: TRect read FBarRect;
    property ContentRect: TRect read FContentRect;
    property FooterRect: TRect read FFooterRect;
    property RowHeight: Integer read FRowHeight write SetRowHeight;
    property RowHeights[Index: Integer]: Integer read GetRowHeights;
    property RowTops[Index: Integer]: Integer read GetRowTops;
    property AllowInplaceEdit: Boolean read FAllowInplaceEdit
      write FAllowInplaceEdit default True;
    property AllowResize: Boolean read FAllowResize
      write FAllowResize default True;
    property ItemResize: TSPItemResize read FItemResize;
    property ItemHit: TSPItemHit read FItemHit;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default False;
    property WeekStart: TSPWeekStart read FWeekStart
      write SetWeekStart default wsMonday;
    property OnInsertItem: TSPPlanItemEvent read FOnInsertItem
      write FOnInsertItem;
    property GroupBy: TSPGroupBy read FGroupBy
      write SetGroupBy default grResource;
    property TopRow: Integer read FTopRow write SetTopRow;
    property DitherBackground: Boolean read FDitherBackground
      write SetDitherBackground default False;
    property BackgroundColor: TColor read FBackgroundColor
      write SetBackgroundColor default clYellow;
    property DragPlanner: TSPBasePlanner read FDragPlanner;
    property DragOffset: Double read FDragOffset;
    property DragDayOffset: Double read FDragDayOffset;
    property DragResourceName: string read FDragResourceName;
    property DragAllDayItems: Boolean read FDragAllDayItems
      write FDragAllDayItems default False;
    property DragStartTime: TDateTime read FDragStartTime;
    property Filter: TSPFilter read FFilter write SetFilter
      default [flNormal, flAllDay, flPrivate];
    property ClockFormat: TSPClockFormat read FClockFormat write SetClockFormat default cfLocaleDefault;
    property DisplayClockFormat: TSPClockFormat read FDisplayClockFormat;
    property PrintColWidth: Integer read FPrintColWidth write FPrintColWidth;
    property PrintTextHeight: Integer read FPrintTextHeight write FPrintTextHeight;
    property PrintLineWidth: Integer read FPrintLineWidth write FPrintLineWidth;
    property PrintRowHeight: Integer read FPrintRowHeight write FPrintRowHeight;
    property PrintRowLines: Integer read FPrintRowLines write FPrintRowLines;
    property PrintSpacing: Integer read FPrintSpacing write FPrintSpacing;
    property PrintHeaderRect: TRect read FPrintHeaderRect write FPrintHeaderRect;
    property PrintFooterRect: TRect read FPrintFooterRect write FPrintFooterRect;
    property PrintCornerRect: TRect read FPrintCornerRect write FPrintCornerRect;
    property PrintBarRect: TRect read FPrintBarRect write FPrintBarRect;
    property PrintContentRect: TRect read FPrintContentRect write FPrintContentRect;
    property PrintSubHeaderRect: TRect read FPrintSubHeaderRect write FPrintSubHeaderRect;
    property AlternateCalendar: TSPCustomCalendarProvider
      read FAlternateCalendar write SetAlternateCalendar;
    property OnDrawItem: TSPDrawItemEvent read FOnDrawItem write FOnDrawItem;
    property OnDrawCell: TSPDrawCellEvent read FOnDrawCell write FOnDrawCell;
    property OnItemHint: TSPItemHintEvent read FOnItemHint write FOnItemHint;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DragDrop(Source: TObject; X, Y: Integer); override;
    procedure GetCellAtPos(X, Y: Integer;
      var ACol, ARow: Integer); overload;
    procedure GetCellAtPos(X, Y: Integer;
      var ACol, ARow: Integer; var CellRect: TRect); overload;
    function IsCellSelected(ACol, ARow: Integer): Boolean;
    function IsItemSelected(Item: TSPPlanItem): Boolean;
    function CanModify: Boolean; virtual;
    function AllowNewItem(var ResourceName: string;
      var StartTime, EndTime: TDateTime): Boolean;
    function Editing: Boolean;
    procedure CancelEdit;
    procedure GetCellDates(ACol, ARow: Integer;
      var StartTime, EndTime: TDateTime); virtual;
    function GetCellResource(ACol, ARow: Integer): TSPPlannerResource; virtual;
    function FindItemAtPos(X, Y: Integer): TSPPlanItem; virtual;
    function IsCellValid(ACol, ARow: Integer): Boolean; virtual;
    function GetPrintPages(ACanvas: TCanvas; ARect: TRect): Integer; virtual;
    procedure Print(ACanvas: TCanvas; ARect: TRect;
      AColor, AHeaderColor, AHeaderTextColor, ABorderColor: TColor;
      APage: Integer; AInvertHeaderColors, AFit: Boolean); virtual;
    property Source: TSPCustomSource read FSource write SetSource;
    property BorderStyle: TBorderStyle read FBorderStyle
      write SetBorderStyle default bsSingle;
    property RowCount: Integer read FRowCount default 1;
    property AutoSizeRows: Boolean read FAutoSizeRows
      write SetAutoSizeRows default False;
    property Selection: TRect read FSelection write SetSelection;
    property SelectedItems[Index: Integer]: TSPPlanItem read GetSelectedItems;
    property SelectedCount: Integer read GetSelectedCount;
    property CopyOnDrop: Boolean read FCopyOnDrop write FCopyOnDrop
      default False;
    property PrintFont: TFont read FPrintFont write SetPrintFont;
    property ThemeStyle: TSPThemeStyle read FThemeStyle write SetThemeStyle default tsRebar;
  end;

  TSPPlannerSource = class(TSPCustomSource)
  published
    property Images;
    property ReadOnly;
    property OnChange;
    property OnItemChange;
    property OnItemDelete;
    property OnItemSave;
    property OnRequestItems;
  end;

resourcestring
  SPositiveValueError = 'Value must be 0 or larger';
  SEndTimeError = 'End time cannot be earlier than start time';
  SPrintCanvas = 'A Canvas is required for printing';
  SPrintRect = 'An invalid printing area has been specified';
  SPrintPage = 'The requested page is out of range';
  SClockAM = 'am';
  SClockPM = 'pm';

implementation

uses
  CommCtrl,
  {$IFNDEF VCL4}
  {$IFNDEF VCL5}
  Types,
  DateUtils,
  {$ENDIF}
  {$ENDIF}
  {$IFDEF CLR}
  WinUtils, System.Reflection, System.Runtime.InteropServices,
  System.Globalization,
  {$ENDIF}
  Math;

{$IFDEF CLR}
{$R 'ShorterPath.Planners.Vcl.SPPlanBitmaps.resources'}
{$ELSE}
{$R SPPlanBitmaps.res}
{$ENDIF}

{$I Util1.inc}

type
  _TRIVERTEX = packed record
    x: Longint;
    y: Longint;
    Red: Word;
    Green: Word;
    Blue: Word;
    Alpha: Word;
  end;
  TTriVertex = _TRIVERTEX;
  TRIVERTEX = _TRIVERTEX;

{$IFDEF CLR}
[DllImport(msimg32, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'GradientFill')]
function GradientFill(DC: HDC; [in] Vertex: array of TTriVertex; NumVertex: ULONG;
  const Mesh: TGradientTriangle; NumMesh, Mode: ULONG): BOOL; external; overload;
[DllImport(msimg32, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'GradientFill')]
function GradientFill(DC: HDC; [in] Vertex: array of TTriVertex; NumVertex: ULONG;
  const Mesh: TGradientRect; NumMesh, Mode: ULONG): BOOL; external; overload;
{$ELSE}
type
  TGradientFill = function(DC: HDC; pVertex: Pointer; dwNumVertex: DWORD;
    pMesh: Pointer; dwNumMesh, dwMode: DWORD): LongBool; stdcall;
  TAlphaBlend = function(DC: HDC; p2, p3, p4, p5: Integer;
    DC6: HDC; p7, p8, p9, p10: Integer; p11: TBlendFunction): BOOL; stdcall;
{$ENDIF}

const
  AC_SRC_OVER = $00;
  AC_SRC_ALPHA = $01;

var
  {$IFNDEF CLR}
  hMsImg32: HMODULE = 0;
  FuncGradientFill: TGradientFill = nil;
  FuncAlphaBlend: TAlphaBlend = nil;
  {$ENDIF}
  GlowBitmap: TBitmap;
  PatternBitmap: TBitmap;
  ShadowTR: TBitmap;
  ShadowR: TBitmap;
  ShadowBR: TBitmap;
  ShadowB: TBitmap;
  ShadowBL: TBitmap;
  BarMoreBitmap: TBitmap;
  OutOfOfficeBitmap: TBitmap;
  MoreBitmapLTR: TBitmap;
  MoreBitmapRTL: TBitmap;

const
  TIMER_EDIT = 1;
  TIMER_SCROLL = 2;

  SCROLL_DELAY = 200;

{$IFNDEF CONDITIONALEXPRESSIONS}
const
  OneMillisecond = 1 / MSecsPerDay;

type
  TValueRelationship = -1..1;

const
  LessThanValue = Low(TValueRelationship);
  EqualsValue = 0;
  GreaterThanValue = High(TValueRelationship);

function CompareDateTime(const A, B: TDateTime): TValueRelationship;
begin
  if Abs(A - B) < OneMillisecond then
    Result := EqualsValue
  else if A < B then
    Result := LessThanValue
  else
    Result := GreaterThanValue;
end;
{$ENDIF}

function ComparePlanItems(
  Item1, Item2: {$IFDEF CLR}TObject{$ELSE}Pointer{$ENDIF}): Integer;
var
  PlanItem1, PlanItem2: TSPPlanItem;
begin
  Result := 0;
  if Item1 <> Item2 then
  begin
    PlanItem1 := TSPPlanItem(Item1);
    PlanItem2 := TSPPlanItem(Item2);

    if PlanItem1.StartTime < PlanItem2.StartTime then
      Result := -1 else
    if PlanItem1.StartTime > PlanItem2.StartTime then
      Result := 1 else
    if PlanItem1.EndTime < PlanItem2.EndTime then
      Result := -1 else
    if PlanItem1.EndTime > PlanItem2.EndTime then
      Result := 1 else
    if PlanItem1.AllDayEvent <> PlanItem2.AllDayEvent then
    begin
      if PlanItem1.AllDayEvent then
        Result := -1 else
        Result := 1;
    end;

    if Result = 0 then
      Result := CompareStr(PlanItem2.Title, PlanItem1.Title);
  end;
end;

function CompareDisplayItems(
  Item1, Item2: {$IFDEF CLR}TObject{$ELSE}Pointer{$ENDIF}): Integer;
var
  DisplayItem1, DisplayItem2: TSPDisplayItem;
begin
  Result := 0;
  if Item1 <> Item2 then
  begin
    DisplayItem1 := TSPDisplayItem(Item1);
    DisplayItem2 := TSPDisplayItem(Item2);

    if DisplayItem1.Item.AllDayEvent <> DisplayItem2.Item.AllDayEvent then
    begin
      if DisplayItem1.Item.AllDayEvent then
        Result := -1 else
        Result := 1;
    end else
    if (DisplayItem1.Item.StartTime + DisplayItem1.FOffset) <
      (DisplayItem2.Item.StartTime + DisplayItem2.FOffset) then
      Result := -1 else
    if (DisplayItem1.Item.StartTime + DisplayItem1.FOffset) >
      (DisplayItem2.Item.StartTime + DisplayItem2.FOffset) then
      Result := 1 else
    if (DisplayItem1.Item.EndTime + DisplayItem1.FOffset) <
      (DisplayItem2.Item.EndTime + DisplayItem2.FOffset) then
      Result := -1 else
    if (DisplayItem1.Item.EndTime + DisplayItem1.FOffset) >
      (DisplayItem2.Item.EndTime + DisplayItem2.FOffset) then
      Result := 1;

    if Result = 0 then
      Result := CompareStr(DisplayItem2.Item.Title,
        DisplayItem1.Item.Title);
  end;
end;

type
  TSPRequest = class
  public
    StartTime: TDateTime;
    EndTime: TDateTime;
  end;
  
{ TSPPlannerLink }

procedure TSPPlannerLink.Change;
begin
  if Assigned(OnChange) then OnChange(Sender);
end;

destructor TSPPlannerLink.Destroy;
begin
  if Sender <> nil then Sender.UnRegisterChanges(Self);
  inherited Destroy;
end;

{ TSPCustomSource }

procedure TSPCustomSource.AcceptChanges;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    Items[i].AcceptChanges;
end;

function TSPCustomSource.Add: TSPPlanItem;
begin
  Result := FPlanItemClass.Create;
  Result.FSource := Self;
  FItems.Add(Result);
  Sort;
end;

function TSPCustomSource.AddItem(const Resource, Title: string; StartTime,
  EndTime: TDateTime; AllDayEvent, IsPrivate: Boolean; Color: TColor;
  BusyStatus: TSPBusyStatus): TSPPlanItem;
begin
  Result := Add;
  Result.FResource := Resource;
  Result.FTitle := Title;
  Result.FStartTime := StartTime;
  Result.FEndTime := EndTime;
  Result.FAllDayEvent := AllDayEvent;
  Result.FIsPrivate := IsPrivate;
  Result.FColor := Color;
  Result.FBusyStatus := BusyStatus;
  Sort;
  Result.AcceptChanges;
  ItemChange(Result);
  if FUpdateCount = 0 then
    Change else
    FChanged := True;
end;

procedure TSPCustomSource.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

function TSPCustomSource.CanModify: Boolean;
begin
  Result := not ReadOnly;
end;

procedure TSPCustomSource.Change;
var
  i: Integer;
begin
  FChanged := False;
  if FClients <> nil then
    for I := 0 to FClients.Count - 1 do
      TSPPlannerLink(FClients[I]).Change;
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TSPCustomSource.Clear;
begin
  BeginUpdate;
  while Count > 0 do
    Items[0].Free;
  EndUpdate;
end;

constructor TSPCustomSource.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FClients := TList.Create;
  FItems := TList.Create;
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  FPlanItemClass := TSPPlanItem;
  FRequests := TList.Create;
  {$I Util3.inc}
end;

procedure TSPCustomSource.Delete(Index: Integer);
begin
  Items[Index].Free;
end;

procedure TSPCustomSource.DeleteItem(Item: TSPPlanItem);
begin
  ItemDelete(Item);
  Item.Free;
end;

procedure TSPCustomSource.DeleteItem(Index: Integer);
begin
  DeleteItem(Items[Index]);
end;

destructor TSPCustomSource.Destroy;
var
  i: Integer;
begin
  while FClients.Count > 0 do
    UnRegisterChanges(TSPPlannerLink(FClients.Last));
  FClients.Free;
  FClients := nil;

  FImageChangeLink.Free;

  for i := 0 to FItems.Count - 1 do
  begin
    Items[i].FSource := nil;
    Items[i].Free;
  end;
  FItems.Free;

  for i := 0 to FRequests.Count - 1 do
    TSPRequest(FRequests[i]).Free;
  FRequests.Free;
  
  inherited Destroy;
end;

procedure TSPCustomSource.DoRequestItems(StartTime, EndTime: TDateTime);
begin
  if Assigned(FOnRequestItems) then
    FOnRequestItems(Self, StartTime, EndTime);
end;

procedure TSPCustomSource.EndUpdate;
begin
  if FUpdateCount > 0 then
  begin
    Dec(FUpdateCount);
    if FChanged then
      Change;
  end;
end;

function TSPCustomSource.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TSPCustomSource.GetItems(Index: Integer): TSPPlanItem;
begin
  Result := TSPPlanItem(FItems[Index]);
end;

procedure TSPCustomSource.ImageListChange(Sender: TObject);
begin
  if Sender = Images then Change;
end;

function TSPCustomSource.IndexOf(Item: TSPPlanItem): Integer;
begin
  Result := FItems.IndexOf(Item);
end;

procedure TSPCustomSource.ItemChange(Item: TSPPlanItem);
begin
  if Assigned(FOnItemChange) then
    FOnItemChange(Self, Item);
end;

procedure TSPCustomSource.ItemDelete(Item: TSPPlanItem);
begin
  if Assigned(FOnItemDelete) then
    FOnItemDelete(Self, Item);
end;

procedure TSPCustomSource.ItemSave(Item: TSPPlanItem);
begin
  if Assigned(FOnItemSave) then
    FOnItemSave(Self, Item);
end;

procedure TSPCustomSource.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = Images) then
    Images := nil;
end;

procedure TSPCustomSource.RegisterChanges(Value: TSPPlannerLink);
begin
  Value.Sender := Self;
  if Assigned(FClients) then FClients.Add(Value);
end;

procedure TSPCustomSource.Remove(Item: TSPPlanItem);
begin
  Item.Free;
end;

procedure TSPCustomSource.RequestAllItems;
var
  i: Integer;
  CurRequest: TSPRequest;
begin
  for i := 0 to FRequests.Count - 1 do
  begin
    CurRequest := TSPRequest(FRequests[i]);
    DoRequestItems(CurRequest.StartTime, CurRequest.EndTime);
  end;
end;

procedure TSPCustomSource.RequestItems(StartTime, EndTime: TDateTime);
var
  i: Integer;
  CurRequest, NewRequest: TSPRequest;
begin
  for i := 0 to FRequests.Count - 1 do
  begin
    CurRequest := TSPRequest(FRequests[i]);
    if (CurRequest.StartTime <= StartTime) and
      (CurRequest.EndTime >= EndTime) then
      Exit;

    if (CurRequest.StartTime > StartTime) and
      (CurRequest.StartTime < EndTime) then
    begin
      RequestItems(StartTime, CurRequest.StartTime);
      RequestItems(CurRequest.StartTime, EndTime);
      Exit;
    end;

    if (CurRequest.EndTime > StartTime) and
      (CurRequest.EndTime < EndTime) then
    begin
      RequestItems(StartTime, CurRequest.EndTime);
      RequestItems(CurRequest.EndTime, EndTime);
      Exit;
    end;
  end;

  NewRequest := TSPRequest.Create;
  NewRequest.StartTime := StartTime;
  NewRequest.EndTime := EndTime;
  FRequests.Add(NewRequest);
  DoRequestItems(StartTime, EndTime);

  for i := FRequests.Count - 1 downto 1 do
  begin
    CurRequest := TSPRequest(FRequests[i]);
    NewRequest := TSPRequest(FRequests[i - 1]);
    if NewRequest.EndTime = CurRequest.StartTime then
    begin
      NewRequest.EndTime := CurRequest.EndTime;
      FRequests.Delete(i);
      CurRequest.Free;
    end;
  end;
end;

procedure TSPCustomSource.Revert;
var
  i: Integer;
begin
  BeginUpdate;
  for i := 0 to Count - 1 do
    Items[i].Revert;
  EndUpdate;
end;

procedure TSPCustomSource.Save;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    Items[i].Save;
end;

procedure TSPCustomSource.SetImages(const Value: TCustomImageList);
begin
  if Images <> nil then Images.UnRegisterChanges(FImageChangeLink);
  FImages := Value;
  if Images <> nil then
  begin
    Images.RegisterChanges(FImageChangeLink);
    Images.FreeNotification(Self);
  end;
end;

procedure TSPCustomSource.Sort;
begin
  FItems.Sort(ComparePlanItems);
end;

procedure TSPCustomSource.UnRegisterChanges(Value: TSPPlannerLink);
var
  i: Integer;
begin
  if FClients <> nil then
    for i := 0 to FClients.Count - 1 do
      if FClients[I] = Value then
      begin
        Value.Sender := nil;
        FClients.Delete(I);
        Break;
      end;
end;

{ TSPCustomCalendarProvider }

constructor TSPCustomCalendarProvider.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Date := Now;
end;

function TSPCustomCalendarProvider.GetDayName(ADate: TDateTime): string;
var
  Y, M: string;
begin
  GetNames(ADate, Result, M, Y);
end;

function TSPCustomCalendarProvider.GetMonthName(ADate: TDateTime): string;
var
  D, Y: string;
begin
  GetNames(ADate, D, Result, Y);
end;

function TSPCustomCalendarProvider.GetYearName(ADate: TDateTime): string;
var
  D, M: string;
begin
  GetNames(ADate, D, M, Result);
end;

procedure TSPCustomCalendarProvider.SetDate(const Value: TDateTime);
begin
  if FDate <> Value then
  begin
    FDate := Value;
    GetNames(FDate, FDayName, FMonthName, FYearName);
  end;
end;

{ TSPPlanItem }

procedure TSPPlanItem.AcceptChanges;
begin
  FModified := False;
  FSavedAllDayEvent := FAllDayEvent;
  FSavedTitle := FTitle;
  FSavedEndTime := FEndTime;
  FSavedStartTime := FStartTime;
  FSavedColor := FColor;
  FSavedIsPrivate := FIsPrivate;
  FSavedResource := FResource;
  FSavedBusyStatus := FBusyStatus;
  FSavedReadOnly := FReadOnly;
end;

procedure TSPPlanItem.Assign(ASource: TSPPlanItem);
begin
  if Assigned(ASource) then
  begin
    FAllDayEvent := ASource.FAllDayEvent;
    FTitle := ASource.FTitle;
    FEndTime := ASource.FEndTime;
    FStartTime := ASource.FStartTime;
    FColor := ASource.FColor;
    FIsPrivate := ASource.FIsPrivate;
    FResource := ASource.FResource;
    FBusyStatus := ASource.FBusyStatus;
    FReadOnly := ASource.FReadOnly;
    AcceptChanges;
    FIcons.Assign(ASource.Icons);
  end;
end;

procedure TSPPlanItem.Change;
begin
  FModified := True;
  if Assigned(FSource) then
  begin
    FSource.Sort;
    FSource.ItemChange(Self);
    if FSource.FUpdateCount = 0 then
      FSource.Change else
      FSource.FChanged := True;
  end;
end;

constructor TSPPlanItem.Create;
begin
  inherited Create;
  FIcons := TSPPlanIcons.Create;
  FIcons.OnChange := IconsChange;
  FColor := clNone;
  FBusyStatus := bsBusy;
end;

procedure TSPPlanItem.Delete;
begin
  if Assigned(FSource) then
    FSource.DeleteItem(Self);
end;

destructor TSPPlanItem.Destroy;
begin
  if Assigned(FSource) then
  begin
    FSource.FItems.Remove(Self);
    if FSource.FUpdateCount = 0 then
      FSource.Change else
      FSource.FChanged := True;
  end;
  FIcons.Free;
  inherited Destroy;
end;

function TSPPlanItem.GetDuration: TDateTime;
begin
  Result := FEndTime - FStartTime;
end;

procedure TSPPlanItem.IconsChange(Sender: TObject);
begin
  Change;
end;

procedure TSPPlanItem.MoveBy(Value: Double);
begin
  if Value <> 0 then
  begin
    FStartTime := FStartTime + Value;
    FEndTime := FEndTime + Value;
    Change;
  end;
end;

procedure TSPPlanItem.Revert;
begin
  FAllDayEvent := FSavedAllDayEvent;
  FTitle := FSavedTitle;
  FEndTime := FSavedEndTime;
  FStartTime := FSavedStartTime;
  FColor := FSavedColor;
  FIsPrivate := FSavedIsPrivate;
  FResource := FSavedResource;
  FBusyStatus := FSavedBusyStatus;
  FReadOnly := FSavedReadOnly;
  Change;
  FModified := False;
end;

procedure TSPPlanItem.Save;
begin
  try
    if Assigned(FSource) then
      FSource.ItemSave(Self);

    AcceptChanges;
  except
    Revert;
    raise;
  end;
end;

procedure TSPPlanItem.SetAllDayEvent(const Value: Boolean);
begin
  if FAllDayEvent <> Value then
  begin
    FAllDayEvent := Value;
    Change;
  end;
end;

procedure TSPPlanItem.SetBusyStatus(const Value: TSPBusyStatus);
begin
  if FBusyStatus <> Value then
  begin
    FBusyStatus := Value;
    Change;
  end;
end;

procedure TSPPlanItem.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Change;
  end;
end;

procedure TSPPlanItem.SetEndTime(const Value: TDateTime);
begin
  if FEndTime <> Value then
  begin
    if Value < FStartTime then
      raise Exception.Create(SEndTimeError);
    FEndTime := Value;
    Change;
  end;
end;

procedure TSPPlanItem.SetIcons(const Value: TSPPlanIcons);
begin
  FIcons.Assign(Value);
end;

procedure TSPPlanItem.SetIsPrivate(const Value: Boolean);
begin
  if FIsPrivate <> Value then
  begin
    FIsPrivate := Value;
    Change;
  end;
end;

procedure TSPPlanItem.SetReadOnly(const Value: Boolean);
begin
  if FReadOnly <> Value then
  begin
    FReadOnly := Value;
    Change;
  end;
end;

procedure TSPPlanItem.SetResource(const Value: string);
begin
  if FResource <> Value then
  begin
    FResource := Value;
    Change;
  end;
end;

procedure TSPPlanItem.SetStartTime(const Value: TDateTime);
begin
  if FStartTime <> Value then
  begin
    FStartTime := Value;
    if FEndTime < FStartTime then
      FEndTime := FStartTime;
    Change;
  end;
end;

procedure TSPPlanItem.SetTitle(const Value: string);
begin
  if FTitle <> Value then
  begin
    FTitle := Value;
    Change;
  end;
end;

{ TSPBasePlanner }

procedure TSPBasePlanner.CalcAreaSizes;
begin
  CalcCharSize;

  if FHeaderRows > 0 then
    FHeaderHeight := (FLineHeight + 6) * FHeaderRows
  else
    FHeaderHeight := 0;

  if FFooterRows > 0 then
    FFooterHeight := (FLineHeight + 6) * FFooterRows
  else
    FFooterHeight := 0;

  if FBarCols > 0 then
    FBarWidth := FCharWidth * FBarCols + 6
  else
    FBarWidth := 0;

  if FSubHeaderRows > 0 then
    FSubHeaderHeight := (FLineHeight + 6) * FSubHeaderRows + 8
  else
   FSubHeaderHeight := 0;

  CalcDisplayRects;
end;

procedure TSPBasePlanner.CMCtl3DChanged(var Message: TMessage);
begin
  inherited;
  RecreateWnd;
end;

procedure TSPBasePlanner.CMFontChanged(var Message: TMessage);
begin
  inherited;
  CalcAreaSizes;
  AdjustRowHeights;
end;

constructor TSPBasePlanner.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLink := TSPPlannerLink.Create;
  FLink.OnChange := LinkChange;
  FColumns := TSPPlannerColumns.Create(Self);
  FResources := TSPPlannerResources.Create(Self);
  FBorderStyle := bsSingle;
  FRowCount := 1;
  FAutoSizeRows := False;
  FSelectionFlow := sfVertical;
  SetLength(FRowHeights, 1);
  SetLength(FRowTops, 1);
  FSelectedItems := TList.Create;
  FAllowInplaceEdit := True;
  FAllowResize := True;
  FItemResize := irNone;
  FItemHit := ihNone;
  FWeekStart := wsMonday;
  FGroupBy := grResource;
  FBackgroundColor := clYellow;
  FClockFormat := cfLocaleDefault;
  FThemeStyle := tsRebar;
  ApplyClockFormat;
  FFilter := [flNormal, flAllDay, flPrivate];
  FPrintFont := TFont.Create;
  FPrintFont.Assign(Font);
  FPrintRowLines := 1;
  ResourcesChange;
  CalcAreaSizes;
  {$I Util2.inc}
  {$I Util3.inc}
end;

procedure TSPBasePlanner.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or WS_CLIPCHILDREN or WS_VSCROLL;
  {$IFDEF SP_HAS_THEMES}
  if (StyleServices.ThemesEnabled) then Exit;
  {$ENDIF}
  if FBorderStyle = bsSingle then
  begin
    if Ctl3D then
      Params.ExStyle := Params.ExStyle or WS_EX_CLIENTEDGE
    else
      Params.Style := Params.Style or WS_BORDER;
  end;
end;

destructor TSPBasePlanner.Destroy;
begin
  FSelectedItems.Clear;
  FLink.Free;
  FColumns.Free;
  FSelectedItems.Free;
  FResources.Free;
  FPrintFont.Free;
  inherited Destroy;
end;

procedure TSPBasePlanner.CalcCharSize;
var
  DC: HDC;
  SaveFont: HFont;
  Metrics: TTextMetric;
begin
  DC := GetDC(0);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);

  FLineHeight := Metrics.tmHeight;
  FCharWidth := Metrics.tmAveCharWidth;
end;

procedure TSPBasePlanner.SetBorderStyle(const Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TSPBasePlanner.SetSource(const Value: TSPCustomSource);
begin
  if FSource <> Value then
  begin
    {$I Util3.inc}
    if Assigned(FSource) then
      FSource.UnRegisterChanges(FLink);
    FSource := Value;
    if Assigned(FSource) then
    begin
      FSource.RegisterChanges(FLink);
      FSource.FreeNotification(Self);
    end;
    SourceChanged;
  end;
end;

{$IFDEF SP_HAS_THEMES}
procedure TSPBasePlanner.WMNCPaint(var Message: TWMNCPaint);
var
  R, ExRect: TRect;
  Details: TThemedElementDetails;
  DC: HDC;
begin
  inherited;
  if (StyleServices.ThemesEnabled) and (FBorderStyle = bsSingle) then
  begin
    GetWindowRect(Handle, R);
    OffsetRect(R, 0 - R.Left, 0 - R.Top);
    DC := GetWindowDC(Handle);
    try
      Details := GetBorderElementDetails;
      GetThemeBackgroundContentRect(
        StyleServices.Theme[Details.Element], 0,
        Details.Part, Details.State,
        R,
        {$IFNDEF CLR}@{$ENDIF}ExRect);
      ExcludeClipRect(DC, ExRect.Left, ExRect.Top, ExRect.Right, ExRect.Bottom);
      StyleServices.DrawParentBackground(Handle, DC,
        {$IFNDEF CLR}@{$ENDIF}Details, False, {$IFNDEF CLR}@{$ENDIF}R);
      StyleServices.DrawElement(DC, Details, R);
    finally
      ReleaseDC(Handle, DC);
    end;
  end;
end;

procedure TSPBasePlanner.WMNCCalcSize(var Message: TWMNCCalcSize);
var
  Details: TThemedElementDetails;
  CurRect, NewRect: TRect;
  {$IFDEF CLR}
  Params: TNCCalcSizeParams;
  {$ENDIF}
begin
//  inherited;
//  if (StyleServices.ThemesEnabled) and (FBorderStyle = bsSingle) then
//    with Message do
//    begin
//      Details := GetBorderElementDetails;
//      {$IFDEF CLR}
//      Params := CalcSize_Params;
//      CurRect := CalcSize_Params.rgrc0;
//      {$ELSE}
//      CurRect := CalcSize_Params.rgrc[0];
//      {$ENDIF}
//      GetThemeBackgroundContentRect(
//        StyleService.Theme[Details.Element], 0,
//        Details.Part, Details.State,
//        CurRect, {$IFNDEF CLR}@{$ENDIF}NewRect);
//      {$IFDEF CLR}
//      Params.rgrc0 := NewRect;
//      CalcSize_Params := Params;
//      {$ELSE}
//      CalcSize_Params.rgrc[0] := NewRect;
//      {$ENDIF}
//    end;
end;
{$ENDIF}

procedure TSPBasePlanner.Paint;
begin
  Canvas.Font := Font;
  Canvas.Brush.Color := Color;
  Canvas.Brush.Style := bsSolid;
  PaintHeader(FHeaderRect);

  Canvas.Font := Font;
  Canvas.Brush.Color := Color;
  Canvas.Brush.Style := bsSolid;
  PaintSubHeader(FSubHeaderRect);

  Canvas.Font := Font;
  Canvas.Brush.Color := Color;
  Canvas.Brush.Style := bsSolid;
  PaintHeaderCorner(FHeaderCornerRect);

  Canvas.Font := Font;
  Canvas.Brush.Color := Color;
  Canvas.Brush.Style := bsSolid;
  PaintBar(FBarRect);

  Canvas.Font := Font;
  Canvas.Brush.Color := Color;
  Canvas.Brush.Style := bsSolid;
  PaintFooter(FFooterRect);

  Canvas.Font := Font;
  Canvas.Brush.Color := Color;
  Canvas.Brush.Style := bsSolid;
  PaintContent(FContentRect);
end;

procedure TSPBasePlanner.PaintBar(ARect: TRect);
begin
  FillBackgroundRect(ARect);

  if UseRightToLeftAlignment then
    DrawEdge(Canvas.Handle, ARect, BDR_SUNKENOUTER, BF_LEFT)
  else
    DrawEdge(Canvas.Handle, ARect, BDR_RAISEDINNER, BF_RIGHT);
end;

procedure TSPBasePlanner.PaintContent(ARect: TRect);
var
  i: Integer;
  R: TRect;
begin
  if FColumns.Count > 0 then
  begin
    R := ARect;
    for i := 0 to FColumns.Count - 1 do
    begin
      R.Left := FColumns[i].Left + 1;
      R.Right := FColumns[i].Right;
      if FColumns[i].BackColor <> clNone then
      begin
        Canvas.Brush.Color := FColumns[i].BackColor;
        Canvas.FillRect(R);
      end else
        FillBackgroundRect(R);
      Inc(R.Right);
      DrawEdge(Canvas.Handle, R, EDGE_ETCHED, BF_RIGHT);
    end;
  end else
    FillBackgroundRect(ARect);
  Canvas.Brush.Color := Color;
end;

procedure TSPBasePlanner.PaintFooter(ARect: TRect);
begin
  FillBackgroundRect(ARect);

  DrawEdge(Canvas.Handle, ARect, EDGE_ETCHED, BF_TOP);
end;

procedure TSPBasePlanner.PaintHeader(ARect: TRect);
var
  i: Integer;
  R, TextRect, IconRect: TRect;
begin
  FillBackgroundRect(ARect);

  DrawEdge(Canvas.Handle, ARect, BDR_RAISEDINNER, BF_BOTTOM);

  if (GroupBy <> grNone) and (Resources.Count > 0) and (HeaderRows > 1) then
  begin
    R := ARect;
    R.Top := R.Bottom - (LineHeight + 6) - 1;
    DrawEdge(Canvas.Handle, R, EDGE_ETCHED, BF_TOP);
    Inc(R.Top);
  end else
    R := ARect;

  if FColumns.Count > 0 then
  begin
    Canvas.Brush.Style := bsClear;
    for i := 0 to FColumns.Count - 1 do
    begin
      TextRect := R;
      TextRect.Left := FColumns[i].Left;
      TextRect.Right := FColumns[i].Right;

      if UseRightToLeftAlignment then
        Dec(TextRect.Left)
      else
        Inc(TextRect.Right);

      if (FColumns[i].ImageIndex >= 0) and Assigned(FSource) and
        Assigned(FSource.Images) and
        (FSource.Images.Count > FColumns[i].ImageIndex) then
      begin
        IconRect := TextRect;
        InflateRect(IconRect, -2, -2);
        if UseRightToLeftAlignment then
          IconRect.Left := IconRect.Right - FSource.Images.Width
        else
          IconRect.Right := IconRect.Left + FSource.Images.Width;
        if (IconRect.Bottom - IconRect.Top) > FSource.Images.Height then
          IconRect.Bottom := IconRect.Top + FSource.Images.Height;

        ImageList_DrawEx(FSource.Images.Handle, FColumns[i].ImageIndex,
          Canvas.Handle, IconRect.Left, IconRect.Top,
          IconRect.Right - IconRect.Left, IconRect.Bottom - IconRect.Top,
          CLR_NONE, CLR_DEFAULT, ILD_NORMAL);
      end;

      InflateRect(TextRect, -2, -3);
      DrawText(Canvas.Handle, {$IFNDEF CLR}PChar{$ENDIF}(FColumns[i].FHeader), -1, TextRect,
        DrawTextBiDiModeFlags(DT_CENTER or DT_SINGLELINE or DT_NOPREFIX));
      InflateRect(TextRect, 2, 0);
      if i < FColumns.Count - 1 then
      begin
        if UseRightToLeftAlignment then
          DrawEdge(Canvas.Handle, TextRect, EDGE_ETCHED, BF_LEFT)
        else
          DrawEdge(Canvas.Handle, TextRect, EDGE_ETCHED, BF_RIGHT);
      end;
    end;
    Canvas.Brush.Style := bsSolid;
  end;
end;

procedure TSPBasePlanner.PaintSubHeader(ARect: TRect);
var
  i, x: Integer;
  SelectRect: TRect;
begin
  Canvas.Pen.Width := 0;
  Canvas.Pen.Style := psSolid;
  Canvas.Pen.Color := clGray;

  FillGradientRect(Canvas, ARect, clBtnFace, clBtnShadow, True);

  if (FSelectedItems.Count = 0) and (Selection.Top = SUB_HEADER_ROW) then
  begin
    SelectRect := ARect;
    Dec(SelectRect.Bottom);
    Canvas.Brush.Color := clWhite;
    Canvas.Brush.Style := bsSolid;
    for i := Selection.Left to FColumns.Count - 1 do
    begin
      if Selection.Right < i then
        Break;
      SelectRect.Left := FColumns[i].Left;
      SelectRect.Right := FColumns[i].Right;
      Canvas.FillRect(SelectRect);
    end;
  end;

  for i := 0 to FColumns.Count - 2 do
  begin
    if UseRightToLeftAlignment then
      x := FColumns[i].Left
    else
      x := FColumns[i].Right - 1;
    Canvas.Polyline([Point(x, ARect.Top), Point(x, ARect.Bottom)]);
  end;

end;

procedure TSPBasePlanner.CalcDisplayRects;
var
  i: Integer;
  ContentWidth, ColWidth, LastCol: Integer;
begin
  if not HandleAllocated then Exit;
  
  FContentRect := ClientRect;
  FHeaderRect := FContentRect;
  FFooterRect := FContentRect;

  if UseRightToLeftAlignment then
    Dec(FHeaderRect.Right, FBarWidth) else
    Inc(FHeaderRect.Left, FBarWidth);

  FSubHeaderRect := FHeaderRect;
  FHeaderRect.Bottom := FHeaderRect.Top + FHeaderHeight;
  FSubHeaderRect.Top := FHeaderRect.Bottom;
  FSubHeaderRect.Bottom := FSubHeaderRect.Top + FSubHeaderHeight;

  FHeaderCornerRect := FHeaderRect;
  FHeaderCornerRect.Bottom := FSubHeaderRect.Bottom;
  if UseRightToLeftAlignment then
  begin
    FHeaderCornerRect.Right := FContentRect.Right;
    FHeaderCornerRect.Left := FHeaderCornerRect.Right - FBarWidth;
  end else
  begin
    FHeaderCornerRect.Left := FContentRect.Left;
    FHeaderCornerRect.Right := FHeaderCornerRect.Left + FBarWidth;
  end;

  FContentRect.Top := FSubHeaderRect.Bottom;
  Dec(FContentRect.Bottom, FFooterHeight);
  FFooterRect.Top := FContentRect.Bottom;

  FBarRect := FContentRect;


  FContentRect.Left := FHeaderRect.Left;
  FContentRect.Right := FHeaderRect.Right;

  FBarRect.Left := FHeaderCornerRect.Left;
  FBarRect.Right := FHeaderCornerRect.Right;

  LastCol := 0;
  if FColumns.Count > 0 then
  begin
    ContentWidth := FContentRect.Right - FContentRect.Left;
    for i := 0 to FColumns.Count - 1 do
    begin
      ColWidth := Round(ContentWidth/(FColumns.Count - i));
      Dec(ContentWidth, ColWidth);
      if UseRightToLeftAlignment then
      begin
        FColumns[i].FRight := FContentRect.Right - LastCol;
        FColumns[i].FLeft := FColumns[i].FRight - ColWidth;
      end else
      begin
        FColumns[i].FLeft := FContentRect.Left + LastCol;
        FColumns[i].FRight := FColumns[i].FLeft + ColWidth;
      end;
      Inc(LastCol, ColWidth);
    end;
  end;

  DisplayRectsChanged;
end;

procedure TSPBasePlanner.PaintHeaderCorner(ARect: TRect);
begin
  FillBackgroundRect(ARect);

  DrawEdge(Canvas.Handle, ARect, BDR_RAISEDINNER, BF_BOTTOM);

  if UseRightToLeftAlignment then
    DrawEdge(Canvas.Handle, ARect, BDR_SUNKENOUTER, BF_LEFT)
  else
    DrawEdge(Canvas.Handle, ARect, BDR_RAISEDINNER, BF_RIGHT);
end;

procedure TSPBasePlanner.WMSize(var Message: TWMSize);
begin
  inherited;
  CloseEditor(True);
  CalcDisplayRects;
  AdjustRowHeights;
  Invalidate;
end;

procedure TSPBasePlanner.SetAutoSizeRows(const Value: Boolean);
begin
  if FAutoSizeRows <> Value then
  begin
    FAutoSizeRows := Value;
    if FAutoSizeRows then
      FTopRow := 0;
    AdjustRowHeights;
    Invalidate;
  end;
end;

procedure TSPBasePlanner.SetRowCount(const Value: Integer);
begin
  if FRowCount <> Value then
  begin
    SetLength(FRowHeights, Value);
    SetLength(FRowTops, Value);
    FRowCount := Value;
    AdjustRowHeights;
    Invalidate;
  end;
end;

procedure TSPBasePlanner.SetRowHeight(const Value: Integer);
begin
  if FRowHeight <> Value then
  begin
    FRowHeight := Value;
    AdjustRowHeights;
    Invalidate;
  end;
end;

procedure TSPBasePlanner.AdjustRowHeights;
var
  i: Integer;
  ContentHeight: Integer;
  FixedRowHeight: Integer;
begin
  if FAutoSizeRows then
  begin
    ContentHeight := FContentRect.Bottom - FContentRect.Top;
    for i := 0 to FRowCount - 1 do
    begin
      FRowHeights[i] := Round(ContentHeight / (FRowCount - i));
      Dec(ContentHeight, FRowHeights[i]);
    end;
  end else
  begin
    CalcCharSize;
    if FRowHeight <= 0 then
      FixedRowHeight := FLineHeight + 6
    else
      FixedRowHeight := FRowHeight;

    for i := 0 to FRowCount - 1 do
      FRowHeights[i] := FixedRowHeight;
  end;
  if FRowCount > 0 then
  begin
    FRowTops[0] := 0;
    for i := 1 to FRowCount - 1 do
      FRowTops[i] := FRowTops[i - 1] + FRowHeights[i - 1];
  end;

  TopRow := FTopRow;
end;

procedure TSPBasePlanner.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TSPBasePlanner.DisplayRectsChanged;
begin
end;

procedure TSPBasePlanner.DrawMoreBitmap(ACanvas: TCanvas; ARect: TRect);
begin
  if UseRightToLeftAlignment then
    ACanvas.Draw(ARect.Right - 15, ARect.Bottom - 9, MoreBitmapRTL)
  else
    ACanvas.Draw(ARect.Left, ARect.Bottom - 9, MoreBitmapLTR);
end;

procedure TSPBasePlanner.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = Source then
      Source := nil;
    if AComponent = AlternateCalendar then
      AlternateCalendar := nil;
  end;
end;

procedure TSPBasePlanner.LinkChange(Sender: TObject);
begin
  SourceChanged;
end;

procedure TSPBasePlanner.SourceChanged;
var
  i: Integer;
begin
  if Assigned(FSource) then
  begin
    i := 0;
    while i < FSelectedItems.Count do
      if FSource.IndexOf(TSPPlanItem(FSelectedItems[i])) < 0 then
        FSelectedItems.Delete(i)
      else
        Inc(i);
  end else
    FSelectedItems.Clear;
end;

procedure TSPBasePlanner.RequestItems(StartTime, EndTime: TDateTime);
begin
  if Assigned(FSource) then
  begin
    FSource.BeginUpdate;
    FSource.RequestItems(StartTime, EndTime);
    FSource.EndUpdate;
  end;
end;

procedure TSPBasePlanner.SetHeaderRows(const Value: Integer);
begin
  if FHeaderRows <> Value then
  begin
    if Value < 0 then
      raise Exception.Create(SPositiveValueError);
    FHeaderRows := Value;
    CalcAreaSizes;
  end;
end;

procedure TSPBasePlanner.SetSubHeaderRows(const Value: Integer);
begin
  if FSubHeaderRows <> Value then
  begin
    if Value < 0 then
      raise Exception.Create(SPositiveValueError);
    FSubHeaderRows := Value;
    CalcAreaSizes;
  end;
end;

procedure TSPBasePlanner.SetBarCols(const Value: Integer);
begin
  if FBarCols <> Value then
  begin
    if Value < 0 then
      raise Exception.Create(SPositiveValueError);
    FBarCols := Value;
    CalcAreaSizes;
  end;
end;

procedure TSPBasePlanner.SetFooterRows(const Value: Integer);
begin
  if FFooterRows <> Value then
  begin
    if Value < 0 then
      raise Exception.Create(SPositiveValueError);
    FFooterRows := Value;
    CalcAreaSizes;
  end;
end;

procedure TSPBasePlanner.GetCellAtPos(X, Y: Integer; var ACol,
  ARow: Integer);
var
  NullRect: TRect;
begin
  GetCellAtPos(X, Y, ACol, ARow, NullRect);
end;

{$IFDEF SP_HAS_THEMES}
function TSPBasePlanner.GetBackgroundElementDetails: TThemedElementDetails;
begin
  case FThemeStyle of
    tsRebar:
      Result := StyleServices.GetElementDetails(trRebarRoot);
    tsTabSheet:
      if BorderStyle = bsSingle then
        Result := StyleServices.GetElementDetails(ttPane)
      else
        Result := StyleServices.GetElementDetails(ttBody);
    tsTreeView:
      Result := StyleServices.GetElementDetails(ttTreeviewRoot);
    tsTrackThumb:
      Result := StyleServices.GetElementDetails(ttbThumbNormal);
    tsTrackThumbHot:
      Result := StyleServices.GetElementDetails(ttbThumbHot);
    tsActiveCaption:
      Result := StyleServices.GetElementDetails(twCaptionActive);
    tsInactiveCaption:
      Result := StyleServices.GetElementDetails(twCaptionInactive);
    tsFlashCaption:
      Result := StyleServices.GetElementDetails(ttbFlashButton);
  end;
end;

function TSPBasePlanner.GetBorderElementDetails: TThemedElementDetails;
begin
  case FThemeStyle of
    tsRebar:
      Result := StyleServices.GetElementDetails(teEditRoot);
    tsTabSheet:
      Result := StyleServices.GetElementDetails(ttPane);
    tsTreeView:
      Result := StyleServices.GetElementDetails(ttTreeviewRoot);
    tsTrackThumb:
      Result := StyleServices.GetElementDetails(ttbThumbNormal);
    tsTrackThumbHot:
      Result := StyleServices.GetElementDetails(ttbThumbHot);
    tsActiveCaption:
      Result := StyleServices.GetElementDetails(twCaptionActive);
    tsInactiveCaption:
      Result := StyleServices.GetElementDetails(twCaptionInactive);
    tsFlashCaption:
      Result := StyleServices.GetElementDetails(ttbFlashButton);
  end;
end;
{$ENDIF}

procedure TSPBasePlanner.GetCellAtPos(X, Y: Integer; var ACol, ARow: Integer;
  var CellRect: TRect);
var
  i: Integer;
  R: TRect;
begin
  ACol := INVALID_COL;
  ARow := INVALID_ROW;
  if PtInRect(FContentRect, Point(X, Y)) or
    PtInRect(FSubHeaderRect, Point(X, Y)) then
  begin
    for i := 0 to Columns.Count - 1 do
      if (X >= Columns[i].Left) and (X <= Columns[i].Right) then
      begin
        ACol := i;
        R.Left := Columns[i].Left;
        R.Right := Columns[i].Right;
        Break;
      end;

    if PtInRect(FSubHeaderRect, Point(X, Y)) then
    begin
      ARow := SUB_HEADER_ROW;
      R.Top := FSubHeaderRect.Top;
      R.Bottom := FSubHeaderRect.Bottom;
    end else
    begin
      ARow := TopRow;
      R.Bottom := FContentRect.Top;
      for i := TopRow to RowCount - 1 do
      begin
        R.Top := R.Bottom;
        R.Bottom := R.Top + FRowHeights[i];
        if Y <= R.Bottom then
          Break;
        Inc(ARow);
      end;
    end;

    CellRect := R;
  end;
end;

procedure TSPBasePlanner.SetSelection(const Value: TRect);
var
  Smaller: TPoint;
  SmallerPart: Integer;
  OldSelection: TRect;
begin
  OldSelection := FSelection;
  FSelection := Value;
  if FSelectionFlow = sfHorizontal then
  begin
    if FSelection.Bottom < FSelection.Top then
    begin
      Smaller := FSelection.BottomRight;
      FSelection.BottomRight := FSelection.TopLeft;
      FSelection.TopLeft := Smaller;
    end else
      if (FSelection.Bottom = FSelection.Top) and
        (FSelection.Right < FSelection.Left) then
      begin
        SmallerPart := FSelection.Right;
        FSelection.Right := FSelection.Left;
        FSelection.Left := SmallerPart;
      end;
  end;

  if FSelectionFlow = sfVertical then
  begin
    if FSelection.Right < FSelection.Left then
    begin
      Smaller := FSelection.BottomRight;
      FSelection.BottomRight := FSelection.TopLeft;
      FSelection.TopLeft := Smaller;
    end else
      if (FSelection.Right = FSelection.Left) and
        (FSelection.Bottom < FSelection.Top) then
      begin
        SmallerPart := FSelection.Bottom;
        FSelection.Bottom := FSelection.Top;
        FSelection.Top := SmallerPart;
      end;
  end;

  if HandleAllocated and
    ((OldSelection.Top <> FSelection.Top) or
     (OldSelection.Left <> FSelection.Left) or
     (OldSelection.Bottom <> FSelection.Bottom) or
     (OldSelection.Right <> FSelection.Right)) then
    RefreshContentView;
end;

procedure TSPBasePlanner.SetSelectionFlow(const Value: TSPSelectionFlow);
begin
  if FSelectionFlow <> Value then
  begin
    FSelectionFlow := Value;
    RefreshContentView;
  end;
end;

function TSPBasePlanner.IsCellSelected(ACol, ARow: Integer): Boolean;
var
  First, Last, Cell: Integer;
begin
  if FSelectionFlow = sfHorizontal then
  begin
    First := FSelection.Top * Columns.Count + FSelection.Left;
    Last := FSelection.Bottom * Columns.Count + FSelection.Right;
    Cell := ARow * Columns.Count + ACol;
  end else
  begin
    First := FSelection.Left * FRowCount + FSelection.Top;
    Last := FSelection.Right * FRowCount + FSelection.Bottom;
    Cell := ACol * FRowCount + ARow;
  end;
  Result := (Cell >= First) and (Cell <= Last);
end;

procedure TSPBasePlanner.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  Invalidate;
end;

procedure TSPBasePlanner.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  Invalidate;
end;

procedure TSPBasePlanner.WMSetCursor(var Message: TWMSetCursor);
var
  p: TPoint;
  ItemHit: TSPItemHit;
begin
  inherited;
  if (Message.CursorWnd = Handle) and (not (csDesigning in ComponentState)) and
    CanModify and AllowResize and Assigned(FItemUnderMouse) and
    (not FItemUnderMouse.ReadOnly) then
  begin
    GetCursorPos(p);
    ItemHit := ItemHitTest(FItemUnderMouse, ScreenToClient(p));
    case ItemHit of
      ihLeft, ihRight:
        begin
          Message.Result := 1;
          SetCursor(Screen.Cursors[crSizeWE])
        end;
      ihTop, ihBottom:
        begin
          Message.Result := 1;
          SetCursor(Screen.Cursors[crSizeNS]);
        end;
      ihSelect:
        begin
          Message.Result := 1;
          SetCursor(Screen.Cursors[crSizeAll]);
        end;
    end;
  end;
end;

procedure TSPBasePlanner.CMWantSpecialKey(var Message: TWMKey);
begin
  inherited;
  if (Message.CharCode in [VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT, VK_HOME, VK_END,
    VK_SHIFT, VK_PRIOR, VK_NEXT]) then
    Message.Result := 1;
end;

procedure TSPBasePlanner.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  ClickCol, ClickRow, i: Integer;
  Resize: TSPItemResize;
  Hit: TSPItemHit;
begin
  if HandleAllocated and Visible and (not (ssDouble in Shift)) then
    SetFocus;
  GetCellAtPos(X, Y, ClickCol, ClickRow);
  FItemToEditCol := ClickCol;
  FItemToEditRow := ClickRow;
  FItemUnderMouse := FindItemAtPos(X, Y);

  if FEditedItem <> FItemUnderMouse then
    CloseEditor(True);

  if Assigned(FItemUnderMouse) then
  begin
    Hit := ItemHitTest(FItemUnderMouse, Point(X, Y));
    Resize := irNone;
    if AllowResize and Assigned(FItemUnderMouse) then
    begin
      case Hit of
        ihLeft:
          if UseRightToLeftAlignment then
            Resize := irEnd
          else
            Resize := irStart;
        ihRight:
          if UseRightToLeftAlignment then
            Resize := irStart
          else
            Resize := irEnd;
        ihTop:
          Resize := irStart;
        ihBottom:
          Resize := irEnd;
      end;
    end;

    if (ssCtrl in Shift) and (Resize = irNone) then
    begin
      i := FSelectedItems.IndexOf(FItemUnderMouse);
      if i >= 0 then
      begin
        if not (ssRight in Shift) then
          FSelectedItems.Delete(i);
      end else
        FSelectedItems.Add(FItemUnderMouse);
    end else
    if (ssRight in Shift) and (Resize = irNone) then
    begin
      i := FSelectedItems.IndexOf(FItemUnderMouse);
      if i < 0 then
      begin
        FSelectedItems.Clear;
        FSelectedItems.Add(FItemUnderMouse);
      end;
      CloseEditor(True);
    end else
    begin
      if (Resize <> irNone) or (not (ssShift in Shift)) then
        FSelectedItems.Clear;

      i := FSelectedItems.IndexOf(FItemUnderMouse);
      if i < 0 then
        FSelectedItems.Add(FItemUnderMouse);
      CloseEditor(True);
    end;

    FItemResize := Resize;
    FItemHit := Hit;

    FStartSelectCol := ClickCol;
    FStartSelectRow := ClickRow;
    FFocusCol := ClickCol;
    FFocusRow := ClickRow;
    Selection := Rect(ClickCol, ClickRow, ClickCol, ClickRow);
    RefreshContentView;
  end else
  begin
    if Button = mbLeft then
    begin
      if FSelectedItems.Count > 0 then
        RefreshContentView;

      FSelectedItems.Clear;
      if IsCellValid(ClickCol, ClickRow) then
      begin
        FFocusCol := ClickCol;
        FFocusRow := ClickRow;
        if ssShift in Shift then
          Selection := Rect(ClickCol, ClickRow,
            FStartSelectCol, FStartSelectRow)
        else
          begin
            FStartSelectCol := ClickCol;
            FStartSelectRow := ClickRow;
            Selection := Rect(ClickCol, ClickRow, ClickCol, ClickRow);
          end;
      end else
        RefreshContentView;
    end;
  end;

  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TSPBasePlanner.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  NewItem: TSPPlanItem;
  NewCol, NewRow: Integer;
  StartTime, EndTime, TimeDiff: TDateTime;
  CanMove: Boolean;
  ItemResource: string;
  TargetResource: TSPPlannerResource;
begin
  if ssLeft in Shift then
  begin
    GetCellAtPos(X, Y, NewCol, NewRow);
    if FSelectedItems.Count = 0 then
    begin
      if IsCellValid(NewCol, NewRow) then
      begin
        FFocusCol := NewCol;
        FFocusRow := NewRow;
        Selection := Rect(NewCol, NewRow, FStartSelectCol, FStartSelectRow);
      end;
    end else
      if CanModify then
      begin
        if (FItemResize <> irNone) and Assigned(FItemUnderMouse) then
        begin
          FItemToEditCol := NewCol;
          FItemToEditRow := NewRow;
          GetCellDates(NewCol, NewRow, StartTime, EndTime);
          CanMove := not FItemUnderMouse.ReadOnly;
          if CanMove and (GroupBy <> grNone) then
          begin
            TargetResource := GetCellResource(NewCol, NewRow);
            if Assigned(TargetResource) then
              CanMove := TargetResource.Name = FItemUnderMouse.Resource;
          end;

          if CanMove then
          begin
            if (FItemResize = irStart) and (StartTime > 0) and
              (StartTime < FItemUnderMouse.EndTime) then
            begin
              GetCellDates(FStartSelectCol, FStartSelectRow, TimeDiff, EndTime);
              TimeDiff := FItemUnderMouse.StartTime + StartTime - TimeDiff;
              if TimeDiff < FItemUnderMouse.EndTime then
              begin
                FItemUnderMouse.StartTime := TimeDiff;
                FStartSelectCol := NewCol;
                FStartSelectRow := NewRow;
                Selection := Rect(NewCol, NewRow, NewCol, NewRow);
              end;
            end else
              if (FItemResize = irEnd) and (EndTime >= 0) and
                (EndTime > FItemUnderMouse.StartTime) then
              begin
                GetCellDates(FStartSelectCol, FStartSelectRow,
                  StartTime, TimeDiff);
                TimeDiff := FItemUnderMouse.EndTime + EndTime - TimeDiff;
                if (TimeDiff - FItemUnderMouse.StartTime) > OneMillisecond then
                begin
                  FItemUnderMouse.EndTime := TimeDiff;
                  FStartSelectCol := NewCol;
                  FStartSelectRow := NewRow;
                  Selection := Rect(NewCol, NewRow, NewCol, NewRow);
                end;
              end;
          end;
        end else
          if IsCellValid(NewCol, NewRow) then
          begin
            ItemResource := '';
            CloseEditor(False);
            if Assigned(FItemUnderMouse) and
              (ItemHitTest(FItemUnderMouse, Point(X, Y)) <> ihNone) and
              CanModifySelected then
            begin
              GetCellDates(FStartSelectCol, FStartSelectRow, FDragStartTime, EndTime);
              BeginDrag(False);
            end;
          end;
      end;
  end else
  begin
    NewItem := FindItemAtPos(X, Y);
    if NewItem <> FItemUnderMouse then
    begin
      FItemUnderMouse := NewItem;
      Application.CancelHint;
      RefreshContentView;
    end;
  end;
  inherited MouseMove(Shift, X, Y);
end;

procedure TSPBasePlanner.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if (FItemResize <> irNone) and Assigned(FItemUnderMouse) then
  begin
    FItemResize := irNone;
    FItemUnderMouse.Save;
  end;
  inherited MouseUp(Button, Shift, X, Y);
end;

function TSPBasePlanner.FindItemAtPos(X, Y: Integer): TSPPlanItem;
begin
  Result := nil;
end;

function TSPBasePlanner.IsCellValid(ACol, ARow: Integer): Boolean;
begin
  Result := (ACol > INVALID_COL) and (ARow > INVALID_ROW) and
    (ACol < Columns.Count) and (ARow < FRowCount);
  if (FSubHeaderRows = 0) and (ARow < 0) then
    Result := False; 
end;

function TSPBasePlanner.GetSelectedCount: Integer;
begin
  Result := FSelectedItems.Count;
end;

function TSPBasePlanner.GetSelectedItems(Index: Integer): TSPPlanItem;
begin
  Result := TSPPlanItem(FSelectedItems[Index]);
end;

function TSPBasePlanner.IsItemSelected(Item: TSPPlanItem): Boolean;
begin
  Result := FSelectedItems.IndexOf(Item) >= 0;
end;

function TSPBasePlanner.GetRowHeights(Index: Integer): Integer;
begin
  Result := FRowHeights[Index];
end;

procedure TSPBasePlanner.GetCellDates(ACol, ARow: Integer; var StartTime,
  EndTime: TDateTime);
begin
  StartTime := -1;
  EndTime := -1;
end;

procedure TSPBasePlanner.KeyDown(var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_LEFT:
      begin
        FSelectedItems.Clear;
        Navigate(sdLeft, (ssShift in Shift));
      end;
    VK_RIGHT:
      begin
        FSelectedItems.Clear;
        Navigate(sdRight, (ssShift in Shift));
      end;
    VK_UP:
      begin
        FSelectedItems.Clear;
        Navigate(sdUp, (ssShift in Shift));
      end;
    VK_DOWN:
      begin
        FSelectedItems.Clear;
        Navigate(sdDown, (ssShift in Shift));
      end;
    VK_PRIOR:
      begin
        FSelectedItems.Clear;
        Navigate(sdPrior, (ssShift in Shift));
      end;
    VK_NEXT:
      begin
        FSelectedItems.Clear;
        Navigate(sdNext, (ssShift in Shift));
      end;
    VK_HOME:
      begin
        FSelectedItems.Clear;
        Navigate(sdHome, (ssShift in Shift));
      end;
    VK_END:
      begin
        FSelectedItems.Clear;
        Navigate(sdEnd, (ssShift in Shift));
      end;
    VK_ESCAPE:
      begin
        CloseEditor(False);
        if FItemResize <> irNone then
        begin
          if Assigned(FItemUnderMouse) then
            FItemUnderMouse.Revert;
          FItemResize := irNone;
          mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
        end;
      end;
  end;
  inherited KeyDown(Key, Shift);
end;

function TSPBasePlanner.CanModify: Boolean;
begin
  Result := Assigned(Source) and (Source.CanModify) and (not ReadOnly);
end;

procedure TSPBasePlanner.Click;
var
  DblClickTime: DWORD;
begin
  inherited Click;
  DblClickTime := GetDoubleClickTime;

  FItemToEdit := nil;

  if CanModify and (FSelectedItems.Count = 1) and
    (FSelectedItems[0] = FItemUnderMouse) and (FItemHit <> ihSelect) and
    (FItemHit <> ihNone) and (not FItemUnderMouse.ReadOnly) then
  begin
    FItemToEdit := FItemUnderMouse;
    SetTimer(Handle, TIMER_EDIT, DblClickTime, nil);
  end;
end;

procedure TSPBasePlanner.EditItem(Item: TSPPlanItem);
var
  ItemRect: TRect;
begin
  if (FEditedItem <> Item) then
    CloseEditor(True);

  FItemToEdit := nil;

  if not Assigned(Item) then
    Exit;

  if Assigned(Item) and CanModify and FAllowInplaceEdit and
    (not Item.ReadOnly) and Visible then
  begin
    ItemRect := GetItemEditRect(Item, FItemToEditCol, FItemToEditRow);

    if ((ItemRect.Bottom - ItemRect.Top) > 0) and
      ((ItemRect.Right - ItemRect.Left) > 0) then
    begin
      FEditedItem := Item;

      if not Assigned(FEditor) then
      begin
        FEditor := TSPInplaceEdit.Create(Self);
        FEditor.Parent := Self;
      end;

      FEditor.BoundsRect := ItemRect;
      FEditor.Text := FEditedItem.Title;
      FEditor.Visible := True;
      FEditor.SetFocus;
    end;
  end;
end;

function TSPBasePlanner.GetItemEditRect(Item: TSPPlanItem;
  ACol, ARow: Integer): TRect;
begin
  Result := Rect(0, 0, 0, 0);
end;

procedure TSPBasePlanner.WMTimer(var Message: TWMTimer);
begin
  inherited;
  case Message.TimerID of
    TIMER_EDIT:
      begin
        KillTimer(Handle, TIMER_EDIT);
        if Assigned(FItemToEdit) then
        begin
          if not Dragging then
            EditItem(FItemToEdit);
          FItemToEdit := nil;
        end;
      end;
    TIMER_SCROLL:
      begin
        DragScrollTimer;
      end;
  end;
end;

procedure TSPBasePlanner.DblClick;
begin
  FItemToEdit := nil;
  inherited DblClick;
end;

procedure TSPBasePlanner.CloseEditor(Apply: Boolean);
var
  Item: TSPPlanItem;
begin
  if Assigned(FEditor) and (FEditor.Visible) and Assigned(FEditedItem) then
  try
    if Apply then
    begin
      Item := FEditedItem;
      Item.Title := FEditor.Text;
      if Item.Modified or FEditingNewItem then
      try
        Item.Save;
      except
        if FEditingNewItem then
          Item.Free;
        raise;
      end;
    end else
      if FEditingNewItem then
        FEditedItem.Free;
  finally
    FEditingNewItem := False;
    FEditedItem := nil;
    if FEditor.Focused and HandleAllocated and Visible then
      SetFocus;
    FEditor.Hide;
  end;
  FEditedItem := nil;
end;

procedure TSPBasePlanner.KeyPress(var Key: Char);
var
  NewItem: TSPPlanItem;
  StartDate, EndDate: TDateTime;
  ItemResourceName: string;
begin
  if FAllowInplaceEdit and (Key >= #32) and (FSelectedItems.Count = 0) and
    AllowNewItem(ItemResourceName, StartDate, EndDate) then
  begin
    Source.BeginUpdate;
    NewItem := Source.AddItem(ItemResourceName, '', StartDate, EndDate,
      (FSelection.Top = SUB_HEADER_ROW), False, clNone, bsBusy);
    FSelectedItems.Add(NewItem);
    DoInsertItem(NewItem);
    Source.EndUpdate;
    if CanShowItem(NewItem) then
    begin
      FEditingNewItem := True;
      FItemToEditCol := FSelection.Left;
      FItemToEditRow := FSelection.Top;
      EditItem(NewItem);
      if Assigned(FEditor) then
        SendMessage(FEditor.Handle, WM_CHAR, Ord(Key), 0);
    end else
      NewItem.Free;
  end else
    inherited;
end;

procedure TSPBasePlanner.DoInsertItem(Item: TSPPlanItem);
begin
  if Assigned(FOnInsertItem) then
    FOnInsertItem(Self, Item);
end;

procedure TSPBasePlanner.SetWeekStart(const Value: TSPWeekStart);
begin
  if FWeekStart <> Value then
  begin
    FWeekStart := Value;
    DoWeekStartChange;
  end;
end;

procedure TSPBasePlanner.DoWeekStartChange;
begin
  Invalidate;
end;

procedure TSPBasePlanner.SetGroupBy(const Value: TSPGroupBy);
begin
  if Value <> FGroupBy then
  begin
    FGroupBy := Value;
    ResourcesChange;
  end;
end;

procedure TSPBasePlanner.ResourcesChange;
begin
  CloseEditor(False);
  Invalidate;
end;

procedure TSPBasePlanner.SetResources(const Value: TSPPlannerResources);
begin
  FResources.Assign(Value);
end;

procedure TSPBasePlanner.SetThemeStyle(const Value: TSPThemeStyle);
begin
  if Value <> FThemeStyle then
  begin
    FThemeStyle := Value;
    RecreateWnd;
  end;
end;

procedure TSPBasePlanner.SetTopRow(const Value: Integer);
var
  VisibleRows: Integer;
begin
  if not AutoSizeRows then
  begin
    FTopRow := Value;
    VisibleRows := (ContentRect.Bottom - ContentRect.Top) div FRowHeights[0];
    if FTopRow > FRowCount - VisibleRows then
      FTopRow := FRowCount - VisibleRows;
    if FTopRow < 0 then
      FTopRow := 0;
  end else
    FTopRow := 0;
  CalcScrollBars;
  if HandleAllocated then
  begin
    InvalidateRect(Handle, {$IFNDEF CLR}@{$ENDIF}FContentRect, False);
    InvalidateRect(Handle, {$IFNDEF CLR}@{$ENDIF}FBarRect, False);
  end;
end;

procedure TSPBasePlanner.CalcScrollBars;
var
  ScrollInfo: TScrollInfo;
  PageSize: Integer;
begin
  if HandleAllocated then
  begin
    {$IFNDEF CLR}
    FillChar(ScrollInfo, SizeOf(ScrollInfo), 0);
    {$ENDIF}
    ScrollInfo.cbSize := SizeOf(TScrollInfo);
    ScrollInfo.fMask := SIF_ALL;

    if (not AutoSizeRows) and (RowCount > 0) then
    begin
      ScrollInfo.nMin := 0;
      PageSize := (ContentRect.Bottom - ContentRect.Top) div FRowHeights[0];
      ScrollInfo.nPage := PageSize;
      ScrollInfo.nMax := FRowCount - 1;
      ScrollInfo.nPos := FTopRow;
    end;
    SetScrollInfo(Handle, SB_VERT, ScrollInfo, True);
  end;
end;

procedure TSPBasePlanner.WMVScroll(var Message: TWMVScroll);
var
  NewRow, PageSize: Integer;
begin
  NewRow := FTopRow;
  PageSize := (ContentRect.Bottom - ContentRect.Top) div FRowHeights[0];

  CloseEditor(True);

  case Message.ScrollCode of
    SB_LINEUP:
      Dec(NewRow);
    SB_LINEDOWN:
      Inc(NewRow);
    SB_PAGEUP:
      Dec(NewRow, PageSize);
    SB_PAGEDOWN:
      Inc(NewRow, PageSize);
    SB_THUMBPOSITION,
    SB_THUMBTRACK:
      NewRow := Message.Pos;
  end;

  TopRow := NewRow;

  Message.Result := 0;
end;

procedure TSPBasePlanner.SetDitherBackground(const Value: Boolean);
begin
  if FDitherBackground <> Value then
  begin
    FDitherBackground := Value;
    Invalidate;
  end;
end;

procedure TSPBasePlanner.SetBackgroundColor(const Value: TColor);
begin
  if FBackgroundColor <> Value then
  begin
    FBackgroundColor := Value;
    Invalidate;
  end;
end;

procedure TSPBasePlanner.RefreshContentView;
begin
  if HandleAllocated then
  begin
    InvalidateRect(Handle, {$IFNDEF CLR}@{$ENDIF}ContentRect, False);
    InvalidateRect(Handle, {$IFNDEF CLR}@{$ENDIF}SubHeaderRect, False);
  end;
end;

function TSPBasePlanner.ItemHitTest(Item: TSPPlanItem;
  CursorPos: TPoint): TSPItemHit;
begin
  Result := ihNone;
end;

function TSPBasePlanner.FindDisplayItem(Item: TSPPlanItem;
  ACol, ARow: Integer): TSPDisplayItem;
begin
  Result := nil;
end;

procedure TSPBasePlanner.GetDisplayItemRect(DisplayItem: TSPDisplayItem;
  ACol, ARow: Integer; var ItemRect: TRect;
  var ExtendsBefore, ExtendsAfter: Boolean);
begin
  ItemRect := Rect(-1, -1, -1, -1);
  ExtendsBefore := False;
  ExtendsAfter := False;
end;

procedure TSPBasePlanner.GetItemRect(Item: TSPPlanItem;
  ACol, ARow: Integer; var ItemRect: TRect;
  var ExtendsBefore, ExtendsAfter: Boolean);
var
  DisplayItem: TSPDisplayItem;
begin
  DisplayItem := FindDisplayItem(Item, ACol, ARow);
  GetDisplayItemRect(DisplayItem, ACol, ARow, ItemRect,
    ExtendsBefore, ExtendsAfter);
end;

procedure TSPBasePlanner.GetDisplayItemPrintRect(DisplayItem: TSPDisplayItem;
  ACol, ARow: Integer; var ItemRect: TRect;
  var ExtendsBefore, ExtendsAfter: Boolean);
begin
  ItemRect := Rect(-1, -1, -1, -1);
  ExtendsBefore := False;
  ExtendsAfter := False;
end;

procedure TSPBasePlanner.GetItemPrintRect(Item: TSPPlanItem;
  ACol, ARow: Integer; var ItemRect: TRect;
  var ExtendsBefore, ExtendsAfter: Boolean);
var
  DisplayItem: TSPDisplayItem;
begin
  DisplayItem := FindDisplayItem(Item, ACol, ARow);
  GetDisplayItemPrintRect(DisplayItem, ACol, ARow, ItemRect,
    ExtendsBefore, ExtendsAfter);
end;

function TSPBasePlanner.GetCellResource(ACol,
  ARow: Integer): TSPPlannerResource;
begin
  Result := nil;
end;

function TSPBasePlanner.GetRowTops(Index: Integer): Integer;
begin
  Result := FRowTops[Index];
end;

procedure TSPBasePlanner.CMHintShow(var Message: TCMHintShow);
var
  HintInfo: {$IFDEF CLR}THintInfo{$ELSE}PHintInfo{$ENDIF};
  ItemHint: string;
  Col, Row: Integer;
  ItemRect: TRect;
  ExtendsBefore, ExtendsAfter: Boolean;
begin
  inherited;
  if Message.Result = 0 then
  begin
    if (FItemResize <> irNone) or Dragging then
    begin
      Message.Result := 1;
      Exit;
    end;

    HintInfo := Message.HintInfo;

    if Assigned(FItemUnderMouse) then
    begin
      if FItemUnderMouse.AllDayEvent then
        ItemHint :=
          DateToStr(FItemUnderMouse.FStartTime) + '-' +
          DateToStr(FItemUnderMouse.FEndTime)
      else
        if Trunc(FItemUnderMouse.FStartTime) <> Trunc(FItemUnderMouse.FEndTime) then
          ItemHint :=
            DateTimeToStr(FItemUnderMouse.FStartTime) + '-' +
            DateTimeToStr(FItemUnderMouse.FEndTime)
        else
          ItemHint :=
            TimeToStr(FItemUnderMouse.FStartTime) + '-' +
            TimeToStr(FItemUnderMouse.FEndTime);

      ItemHint := ItemHint + #13#10 + FItemUnderMouse.Title;
      DoItemHint(FItemUnderMouse, ItemHint);

      GetCellAtPos(HintInfo.CursorPos.X, HintInfo.CursorPos.Y, Col, Row);
      GetItemRect(FItemUnderMouse, Col, Row, ItemRect,
        ExtendsBefore, ExtendsAfter);

      if not IsRectEmpty(ItemRect) then
        HintInfo.CursorRect := ItemRect;
      HintInfo.HintStr := ItemHint;
      Message.HintInfo := HintInfo;
    end;
  end;
end;

procedure TSPBasePlanner.DragOver(Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  SourceResourceName: string;
  TargetResource: TSPPlannerResource;
  i, Col, Row: Integer;
  StartTime, EndTime, TargetStart: TDateTime;
  SaveDragOffset: Double;
  SaveDragDayOffset: Double;
  SaveDragResourceName: string;
begin
  SaveDragOffset := FDragOffset;
  SaveDragDayOffset := FDragDayOffset;
  FDragOffset := 0;
  FDragDayOffset := 0;

  SaveDragResourceName := FDragResourceName;
  FDragResourceName := '';
  if Source is TSPBasePlanner then
    FDragPlanner := TSPBasePlanner(Source)
  else
    FDragPlanner := nil;

  if (State = dsDragMove) and Assigned(FDragPlanner) then
  begin
    Accept := False;
    GetCellAtPos(X, Y, Col, Row);

    if (FDragPlanner.FSelectedItems.Count > 0) and
      IsCellValid(Col, Row) then
    begin
      Accept := True;
      if (GroupBy <> grNone) and (Resources.Count > 0) then
      begin
        SourceResourceName := FDragPlanner.SelectedItems[0].Resource;
        for i := 1 to FDragPlanner.FSelectedItems.Count - 1 do
          if FDragPlanner.SelectedItems[i].Resource <> SourceResourceName then
          begin
            Accept := False;
            Break;
          end;
        if Accept then
        begin
          TargetResource := GetCellResource(Col, Row);
          FDragResourceName := TargetResource.Name;
        end;
      end;

      if Accept then
      begin
        StartTime := FDragPlanner.DragStartTime;
        GetCellDates(Col, Row, TargetStart, EndTime);
        {$IFDEF CLR}
        FDragOffset := TargetStart.ToOADate - StartTime.ToOADate;
        FDragDayOffset := Trunc(TargetStart.ToOADate) - Trunc(StartTime.ToOADate);
        {$ELSE}
        FDragOffset := TargetStart - StartTime;
        FDragDayOffset := Trunc(TargetStart) - Trunc(StartTime);
        {$ENDIF}
      end;
    end;
  end;

  if State = dsDragEnter then
    SetTimer(Handle, TIMER_SCROLL, SCROLL_DELAY, nil)
  else
    if State = dsDragLeave then
      KillTimer(Handle, TIMER_SCROLL);
      
  if Assigned(OnDragOver) then
  begin
    Accept := True;
    OnDragOver(Self, Source, X, Y, State, Accept);
  end;

  if not Accept then
  begin
    FDragOffset := 0;
    FDragDayOffset := 0;
  end;
  if (FDragOffset <> SaveDragOffset) or (FDragDayOffset <> SaveDragDayOffset) or
    (FDragResourceName <> SaveDragResourceName) then
    SourceChanged;
end;

procedure TSPBasePlanner.DragScrollTimer;
var
  Threshold: Integer;
  LocalPos: TPoint;
begin
  if not Editing then
  begin
    Threshold := 10;
    if (ContentRect.Bottom - ContentRect.Top) < (Threshold * 3) then
      Threshold := (ContentRect.Bottom - ContentRect.Top) div 3;
    if Threshold > 0 then
    begin
      LocalPos := ScreenToClient(Mouse.CursorPos);

      if PtInRect(Rect(ContentRect.Left, ContentRect.Top,
        ContentRect.Right, ContentRect.Top + Threshold), LocalPos) then
        TopRow := TopRow - 1;

      if PtInRect(Rect(ContentRect.Left, ContentRect.Bottom - Threshold,
          ContentRect.Right, ContentRect.Bottom), LocalPos) then
        TopRow := TopRow + 1;

      if PtInRect(Rect(ContentRect.Left, ContentRect.Top,
          ContentRect.Left + Threshold, ContentRect.Bottom), LocalPos) then
      begin
        SendMessage(Handle, WM_HSCROLL, SB_LINELEFT, 0);
        SendMouseMove;
      end;

      if PtInRect(Rect(ContentRect.Right - Threshold, ContentRect.Top,
          ContentRect.Right, ContentRect.Bottom), LocalPos) then
      begin
        SendMessage(Handle, WM_HSCROLL, SB_LINERIGHT, 0);
        SendMouseMove;
      end;
    end;
  end;
end;

procedure TSPBasePlanner.DragDrop(Source: TObject; X, Y: Integer);
var
  i, Col, Row: Integer;
  Item, NewItem: TSPPlanItem;
  TargetResource: TSPPlannerResource;
  StartTime, EndTime, TargetStart: TDateTime;
  DropPlanner: TSPBasePlanner;
  DropOffset: Double;
  DropDayOffset: Double;
  DropResourceName: string;
  CopyItems: Boolean;
begin
  FDragPlanner := nil;
  FDragOffset := 0;
  FDragDayOffset := 0;
  FDragResourceName := '';

  if Assigned(OnDragDrop) then
    inherited DragDrop(Source, X, Y)
  else
    if Source is TSPBasePlanner then
    begin
      DropPlanner := TSPBasePlanner(Source);
      GetCellAtPos(X, Y, Col, Row);
      if (DropPlanner.FSelectedItems.Count > 0) and IsCellValid(Col, Row) then
      begin
        TargetResource := GetCellResource(Col, Row);
        if Assigned(TargetResource) then
          DropResourceName := TargetResource.Name
        else
          DropResourceName := '';
        StartTime := DropPlanner.DragStartTime;
        GetCellDates(Col, Row, TargetStart, EndTime);
        {$IFDEF CLR}
        DropOffset := TargetStart.ToOADate - StartTime.ToOADate;
        DropDayOffset := Trunc(TargetStart.ToOADate) - Trunc(StartTime.ToOADate);
        {$ELSE}
        DropOffset := TargetStart - StartTime;
        DropDayOffset := Trunc(TargetStart) - Trunc(StartTime);
        {$ENDIF}

        CopyItems := (DropPlanner.Source <> FSource);
        if FCopyOnDrop and (not CopyItems) then
          CopyItems := (GroupBy <> grNone) and (DropPlanner.SelectedCount > 0) and
            (DropResourceName <> DropPlanner.SelectedItems[0].Resource);

        FSource.BeginUpdate;
        try
          for i := 0 to DropPlanner.SelectedCount - 1 do
          begin
            Item := DropPlanner.SelectedItems[i];
            if CopyItems then
            begin
              NewItem := FSource.Add;
              NewItem.Assign(Item);
            end else
              NewItem := Item;
            if DragAllDayItems and Item.AllDayEvent then
              NewItem.MoveBy(DropDayOffset)
            else
              NewItem.MoveBy(DropOffset);
            if (GroupBy <> grNone) and (Resources.Count > 0) then
              NewItem.Resource := DropResourceName;
            NewItem.Save;
          end;
        finally
          FSource.EndUpdate;
        end;
      end;
      FItemToEdit := nil;
    end;
end;

procedure TSPBasePlanner.Navigate(Direction: TSPScrollDirection;
  Select: Boolean);
var
  NewCol, NewRow: Integer;
  ValidateForward, NoAdjust: Boolean;
  VisibleRows: Integer;
  MinRow: Integer;
begin
  NewCol := FFocusCol;
  NewRow := FFocusRow;
  MinRow := 0;
  if SubHeaderRows > 0 then
    MinRow := SUB_HEADER_ROW;

  VisibleRows := RowCount;
  if (not AutoSizeRows) and (RowCount > 0) and (FRowHeights[0] > 0) then
    VisibleRows := (ContentRect.Bottom - ContentRect.Top) div FRowHeights[0];
    
  ValidateForward := True;
  NoAdjust := False;
  case Direction of
    sdLeft:
      if UseRightToLeftAlignment then
        Inc(NewCol)
      else
        begin
          Dec(NewCol);
          ValidateForward := False;
        end;
    sdRight:
      if UseRightToLeftAlignment then
      begin
        Dec(NewCol);
        ValidateForward := False;
      end else
        Inc(NewCol);
    sdUp:
      begin
        Dec(NewRow);
        NoAdjust := (SelectionFlow = sfHorizontal);
        ValidateForward := False;
      end;
    sdDown:
      begin
        Inc(NewRow);
        NoAdjust := (SelectionFlow = sfHorizontal);
      end;
    sdPrior:
      begin
        if NewRow >= 0 then
        begin
          Dec(NewRow, VisibleRows - 1);
          if NewRow < 0 then
            NewRow := 0;
        end;
        NoAdjust := True;
      end;
    sdNext:
      begin
        Inc(NewRow, VisibleRows - 1);
        if NewRow >= RowCount then
          NewRow := RowCount - 1;
        NoAdjust := True;
      end;
    sdHome:
      begin
        NewCol := 0;
        NewRow := 0;
      end;
    sdEnd:
      begin
        NewCol := FColumns.Count - 1;
        NewRow := FRowCount - 1;
        ValidateForward := False;
      end;
  end;

  if not (IsCellValid(NewCol, NewRow) or NoAdjust) then
    repeat
      if SelectionFlow = sfHorizontal then
      begin
        if ValidateForward then
        begin
          Inc(NewCol);
          if NewCol >= FColumns.Count then
          begin
            Inc(NewRow);
            NewCol := 0;
          end;
        end else
        begin
          Dec(NewCol);
          if NewCol < 0 then
          begin
            Dec(NewRow);
            NewCol := FColumns.Count - 1;
          end;
        end;
      end else
      begin
        if ValidateForward then
        begin
          Inc(NewRow);
          if NewRow >= FRowCount then
          begin
            Inc(NewCol);
            NewRow := MinRow;
          end;
        end else
        begin
          Dec(NewRow);
          if NewRow < MinRow then
          begin
            Dec(NewCol);
            NewRow := FRowCount - 1;
          end;
        end;
      end;
    until IsCellValid(NewCol, NewRow) or
      (NewCol >= FColumns.Count) or (NewRow >= RowCount) or
      (NewCol < 0) or (NewRow < MinRow);

  if IsCellValid(NewCol, NewRow) and
    ((FFocusCol <> NewCol) or (FFocusRow <> NewRow)) then
  begin
    FFocusCol := NewCol;
    FFocusRow := NewRow;
    if not Select then
    begin
      FStartSelectCol := NewCol;
      FStartSelectRow := NewRow;
    end;
    Selection := Rect(FStartSelectCol, FStartSelectRow, NewCol, NewRow);

    if FFocusRow >= 0 then
    begin
      if FFocusRow < TopRow then
        TopRow := FFocusRow;

      if (not AutoSizeRows) and (RowCount > 0) and (FRowHeights[0] > 0) then
      begin
        VisibleRows := (ContentRect.Bottom - ContentRect.Top) div FRowHeights[0];
        if (FFocusRow - TopRow) >= VisibleRows then
          TopRow := FFocusRow - VisibleRows + 1;
      end;
    end;
  end;
end;

procedure TSPBasePlanner.SetFilter(const Value: TSPFilter);
begin
  if FFilter <> Value then
  begin
    FFilter := Value;
    FilterChanged;
  end;
end;

procedure TSPBasePlanner.FilterChanged;
begin
  SourceChanged;
end;

procedure TSPBasePlanner.AlternateCalendarChanged;
begin
  Invalidate;
end;

function TSPBasePlanner.CanShowItem(Item: TSPPlanItem): Boolean;
var
  i: Integer;
begin
  Result := False;

  if Assigned(Item) then
  begin
    Result :=
      (((flNormal in FFilter) and (not Item.AllDayEvent)) or
       ((flAllDay in FFilter) and (Item.AllDayEvent))) and
      ((flPrivate in FFilter) or (not Item.IsPrivate));

    if Result and (Resources.Count > 0) then
    begin
      Result := False;
      for i := 0 to Resources.Count - 1 do
        if Resources[i].Name = Item.Resource then
        begin
          Result := True;
          Break;
        end;
    end;
  end;
end;

function TSPBasePlanner.DoDrawItem(Item: TSPPlanItem; ACanvas: TCanvas;
  ItemRect: TRect; ExtendsBefore, ExtendsAfter, Selected, Highlighted: Boolean;
  ClipRect: TRect): Boolean;
begin
  Result := False;

  if Assigned(FOnDrawItem) then
  begin
    Result := True;
    FOnDrawItem(Self, Item, ACanvas, ItemRect, ExtendsBefore, ExtendsAfter,
      Selected, Highlighted, ClipRect, Result);
  end;
end;

function TSPBasePlanner.DoDrawCell(ACanvas: TCanvas; ACol, ARow: Integer;
  CellRect: TRect; Selected: Boolean): Boolean;
begin
  Result := False;

  if Assigned(FOnDrawCell) then
  begin
    Result := True;
    FOnDrawCell(Self, ACanvas, ACol, ARow, CellRect, Selected, Result);
  end;
end;

function TSPBasePlanner.Editing: Boolean;
begin
  Result := Assigned(FEditor) and (FEditor.Visible) and Assigned(FEditedItem);
end;

procedure TSPBasePlanner.CancelEdit;
begin
  CloseEditor(False);
end;

function TSPBasePlanner.DoMouseWheelDown(Shift: TShiftState;
  MousePos: TPoint): Boolean;
begin
  if not Editing then
    TopRow := TopRow + 1;
  Result := inherited DoMouseWheelDown(Shift, MousePos);
end;

function TSPBasePlanner.DoMouseWheelUp(Shift: TShiftState;
  MousePos: TPoint): Boolean;
begin
  if (not Editing) and (TopRow > 0) then
    TopRow := TopRow - 1;
  Result := inherited DoMouseWheelUp(Shift, MousePos);
end;

function TSPBasePlanner.AllowNewItem(var ResourceName: string;
  var StartTime, EndTime: TDateTime): Boolean;
var
  StartDate, EndDate, IgnoreDate: TDateTime;
  ItemResource: TSPPlannerResource;
begin
  Result := False;
  ResourceName := '';
  StartTime := 0;
  EndTime := 0;

  if CanModify  then
  begin
    GetCellDates(FSelection.Left, FSelection.Top, StartDate, IgnoreDate);
    GetCellDates(FSelection.Right, FSelection.Bottom, IgnoreDate, EndDate);

    ItemResource := GetCellResource(FSelection.Left, FSelection.Top);
    if ItemResource <>
      GetCellResource(FSelection.Right, FSelection.Bottom) then
      GetCellDates(FSelection.Left, FSelection.Top, IgnoreDate, EndDate);

    if (StartDate >= 0) and (EndDate >= 0) and (EndDate > StartDate) then
    begin
      if Assigned(ItemResource) then
        ResourceName := ItemResource.Name;
      StartTime := StartDate;
      EndTime := EndDate;
      Result := True;
    end;
  end;
end;

procedure TSPBasePlanner.BusyRect(ACanvas: TCanvas; ARect: TRect;
  BusyStatus: TSPBusyStatus);
var
  Brush: HBrush;
begin
  case BusyStatus of
    bsFree:
      Brush := CreateSolidBrush(clWhite);
    bsTentative:
      Brush := CreatePatternBrush(OutOfOfficeBitmap.Handle);
    bsOutOfOffice:
      Brush := CreateSolidBrush(clPurple);
  else
    Brush := CreateSolidBrush(clBlue);
  end;

  FillRect(ACanvas.Handle, ARect, Brush);
  DeleteObject(Brush);
end;

procedure TSPBasePlanner.DrawBarMoreBitmaps(ACanvas: TCanvas; ARect: TRect;
  Up, Down, RTL: Boolean);
var
  R: TRect;
begin
  R := ARect;
  if RTL then
    R.Right := R.Left + 20
  else
    R.Left := R.Right - 20;

  if Up then
  begin
    if RTL then
      {$IFDEF CLR}
      BarMoreBitmap.LoadFromResourceName('SPBARUPRIGHT',
        'ShorterPath.Planners.Vcl.SPPlanBitmaps',
        Assembly.GetCallingAssembly)
      {$ELSE}
      BarMoreBitmap.LoadFromResourceName(HInstance, 'SPBARUPRIGHT')
      {$ENDIF}
    else
      {$IFDEF CLR}
      BarMoreBitmap.LoadFromResourceName('SPBARUPLEFT',
        'ShorterPath.Planners.Vcl.SPPlanBitmaps',
        Assembly.GetCallingAssembly);
      {$ELSE}
      BarMoreBitmap.LoadFromResourceName(HInstance, 'SPBARUPLEFT');
      {$ENDIF}
    ACanvas.Draw(R.Left, R.Top, BarMoreBitmap);
  end;

  if Down then
  begin
    R.Top := R.Bottom - 8;
    if RTL then
      {$IFDEF CLR}
      BarMoreBitmap.LoadFromResourceName('SPBARDOWNRIGHT',
        'ShorterPath.Planners.Vcl.SPPlanBitmaps',
        Assembly.GetCallingAssembly)
      {$ELSE}
      BarMoreBitmap.LoadFromResourceName(HInstance, 'SPBARDOWNRIGHT')
      {$ENDIF}
    else
      {$IFDEF CLR}
      BarMoreBitmap.LoadFromResourceName('SPBARDOWNLEFT',
        'ShorterPath.Planners.Vcl.SPPlanBitmaps',
        Assembly.GetCallingAssembly);
      {$ELSE}
      BarMoreBitmap.LoadFromResourceName(HInstance, 'SPBARDOWNLEFT');
      {$ENDIF}
    ACanvas.Draw(R.Left, R.Top, BarMoreBitmap);
  end;
end;

procedure TSPBasePlanner.DrawGlow(ACanvas: TCanvas; ARect: TRect);
var
  Dest: TRect;
begin
  if (ARect.Bottom - ARect.Top) >= GlowBitmap.Height then
  begin
    Dest := ARect;
    Dest.Top := Dest.Bottom - GlowBitmap.Height;
    ACanvas.StretchDraw(Dest, GlowBitmap);
  end;
end;

procedure TSPBasePlanner.DrawItemIcons(ACanvas: TCanvas;
  var ItemRect: TRect; AImages: TCustomImageList; AIcons: TSPPlanIcons;
  RTL: Boolean);
var
  i, Index: Integer;
  IconRect: TRect;
  ImageCount, ImageWidth, ImageHeight, IconHeight: Integer;
  LastEdge: Integer;
begin
  if Assigned(AImages) and Assigned(AIcons) then
  begin
    ImageCount := AImages.Count;
    ImageWidth := AImages.Width;
    ImageHeight := AImages.Height;

    if RTL then
      LastEdge := ItemRect.Right
    else
      LastEdge := ItemRect.Left;

    if (ImageCount > 0) then
    begin
      IconRect := ItemRect;
      if RTL then
        IconRect.Left := IconRect.Right - ImageWidth
      else
        IconRect.Right := IconRect.Left + ImageWidth;
      IconRect.Bottom := ItemRect.Top;

      for i := 0 to AIcons.Count - 1 do
      begin
        Index := AIcons[i];
        if (Index >= 0) and (Index < ImageCount) then
        begin
          IconRect.Top := IconRect.Bottom;
          IconRect.Bottom := IconRect.Top + ImageHeight;
          if (IconRect.Bottom >= ItemRect.Bottom) and (i > 0) then
          begin
            IconRect.Top := ItemRect.Top;
            if RTL then
              OffsetRect(IconRect, 0 - ImageWidth, 0)
            else
              OffsetRect(IconRect, ImageWidth, 0);
          end;

          if (IconRect.Right <= ItemRect.Right) and
            (IconRect.Left >= ItemRect.Left) then
          begin
            if RTL then
              LastEdge := IconRect.Left
            else
              LastEdge := IconRect.Right;

            IconRect.Bottom := IconRect.Top + ImageHeight;
            if IconRect.Bottom >= ItemRect.Bottom then
              IconRect.Bottom := ItemRect.Bottom;
            IconHeight := IconRect.Bottom - IconRect.Top;

            ImageList_DrawEx(AImages.Handle, Index, ACanvas.Handle,
              IconRect.Left, IconRect.Top, ImageWidth, IconHeight,
              CLR_NONE, CLR_DEFAULT, ILD_NORMAL)
          end;
        end;
      end;

      if RTL then
      begin
        ItemRect.Right := LastEdge - 1;
        if ItemRect.Right < ItemRect.Left then
          ItemRect.Right := ItemRect.Left;
      end else
      begin
        ItemRect.Left := LastEdge + 2;
        if ItemRect.Left > ItemRect.Right then
          ItemRect.Left := ItemRect.Right;
      end;
    end;
  end;
end;

procedure TSPBasePlanner.DrawShadow(ACanvas: TCanvas; ARect: TRect);
var
  BlendFunction: TBlendFunction;
begin
  {$IFNDEF CLR}
  if Assigned(FuncAlphaBlend) then
  begin
  {$ENDIF}
    BlendFunction.BlendOp := AC_SRC_OVER;
    BlendFunction.BlendFlags := 0;
    BlendFunction.SourceConstantAlpha := 255;
    BlendFunction.AlphaFormat := AC_SRC_ALPHA;

    {$IFDEF CLR}AlphaBlend{$ELSE}FuncAlphaBlend{$ENDIF}(
      ACanvas.Handle, ARect.Right, ARect.Top, 4, 4,
      ShadowTR.Canvas.Handle, 0, 0, 4, 4, BlendFunction);
    {$IFDEF CLR}AlphaBlend{$ELSE}FuncAlphaBlend{$ENDIF}(
      ACanvas.Handle, ARect.Right, ARect.Top + 4, 4,
      (ARect.Bottom - ARect.Top) - 4,
      ShadowR.Canvas.Handle, 0, 0, 4, 4, BlendFunction);
    {$IFDEF CLR}AlphaBlend{$ELSE}FuncAlphaBlend{$ENDIF}(
      ACanvas.Handle, ARect.Right, ARect.Bottom, 4, 4,
      ShadowBR.Canvas.Handle, 0, 0, 4, 4, BlendFunction);
    {$IFDEF CLR}AlphaBlend{$ELSE}FuncAlphaBlend{$ENDIF}(
      ACanvas.Handle, ARect.Left + 4, ARect.Bottom,
      (ARect.Right - ARect.Left) - 4, 4,
      ShadowB.Canvas.Handle, 0, 0, 4, 4, BlendFunction);
    {$IFDEF CLR}AlphaBlend{$ELSE}FuncAlphaBlend{$ENDIF}(
      ACanvas.Handle, ARect.Left, ARect.Bottom, 4, 4,
      ShadowBL.Canvas.Handle, 0, 0, 4, 4, BlendFunction);
  {$IFNDEF CLR}
  end;
  {$ENDIF}
end;

procedure TSPBasePlanner.FillBackgroundRect(ARect: TRect);
{$IFDEF SP_HAS_THEMES}
var
//  Details,
  BorderDetails: TThemedElementDetails;
//  DrawRect: TRect;
{$ENDIF}
begin
//  Canvas.Brush.Color := Color;
//  {$IFDEF SP_HAS_THEMES}
//  if StyleServices.StyleServices then //  klaus
//////  begin
//    Details := GetBackgroundElementDetails;
//    StyleServices.DrawParentBackground(Handle, Canvas.Handle,
//      {$IFNDEF CLR}@{$ENDIF}Details, True, {$IFNDEF CLR}@{$ENDIF}ARect);
//    BorderDetails := GetBorderElementDetails;
//////    if (Details.Element = BorderDetails.Element) and
//      (Details.Part = BorderDetails.Part) and
//      (Details.State = BorderDetails.State) then
//    begin
//      GetWindowRect(Handle, DrawRect);
//      DrawRect.TopLeft := ScreenToClient(DrawRect.TopLeft);
//      DrawRect.BottomRight := ScreenToClient(DrawRect.BottomRight);
////      StyleServices.DrawElement(Canvas.Handle,
//        GetBackgroundElementDetails, DrawRect, {$IFNDEF CLR}@{$ENDIF}ARect);
//    end else
//      StyleServices.DrawElement(Canvas.Handle,
//        GetBackgroundElementDetails, ClientRect, {$IFNDEF CLR}@{$ENDIF}ARect);
//  end else
//  {$ENDIF}
//    Canvas.FillRect(ARect);
end;

procedure TSPBasePlanner.FillGradientRect(ACanvas: TCanvas; ARect: TRect;
  StartColor, EndColor: TColor; Horizontal: Boolean);
var
  DC: HDC;
  GRect: TGradientRect;
  Vert: array[0..1] of Trivertex;
  StartRGB, EndRGB: TColor;
  {$IFNDEF CLR}
  SolidBrush: HBrush;
  {$ENDIF}
begin
  DC := ACanvas.Handle;
  {$IFNDEF CLR}
  if Assigned(FuncGradientFill) then
  begin
  {$ENDIF}
    StartRGB := ColorToRGB(StartColor);
    EndRGB := ColorToRGB(EndColor);

    GRect.UpperLeft := 0;
    GRect.LowerRight := 1;

    Vert[0].x := ARect.Left;
    Vert[0].y := ARect.Top;
    Vert[0].Red := GetRValue(StartRGB) shl 8;
    Vert[0].Green := GetGValue(StartRGB) shl 8;
    Vert[0].Blue := GetBValue(StartRGB) shl 8;
    Vert[0].Alpha := $0000;

    Vert[1].x := ARect.Right;
    Vert[1].y := ARect.Bottom;
    Vert[1].Red := GetRValue(EndRGB) shl 8;
    Vert[1].Green := GetGValue(EndRGB) shl 8;
    Vert[1].Blue := GetBValue(EndRGB) shl 8;
    Vert[1].Alpha := $0000;

    {$IFDEF CLR}
    if Horizontal then
      GradientFill(DC, Vert, 2, GRect, 1, GRADIENT_FILL_RECT_H)
    else
      GradientFill(DC, Vert, 2, GRect, 1, GRADIENT_FILL_RECT_V);
    {$ELSE}
    if Horizontal then
      FuncGradientFill(DC, @Vert, 2, @GRect, 1, GRADIENT_FILL_RECT_H)
    else
      FuncGradientFill(DC, @Vert, 2, @GRect, 1, GRADIENT_FILL_RECT_V);
    {$ENDIF}
  {$IFNDEF CLR}
  end else
  begin
    SolidBrush := CreateSolidBrush(ColorToRGB(StartColor));
    FillRect(DC, ARect, SolidBrush);
    DeleteObject(SolidBrush);
  end;
  {$ENDIF}
end;

procedure TSPBasePlanner.PaintBackground(ACanvas: TCanvas; ARect: TRect;
  AColor: TColor; Active, Dithered: Boolean);
var
  BackColor: TColor;
  SaveBrush: TBrush;
  SaveFont: TFont;
begin
  SaveBrush := TBrush.Create;
  SaveFont := TFont.Create;
  SaveBrush.Assign(ACanvas.Brush);
  SaveFont.Assign(ACanvas.Font);
  try
    if Dithered then
    begin
      {$IFDEF SP_FAST_DITHER}
      if Active then
        ACanvas.Font.Color := clWhite
      else
        ACanvas.Font.Color := ColorToRGB(clBtnShadow);
      ACanvas.Brush.Bitmap := PatternBitmap;
      SetBkColor(ACanvas.Handle, ColorToRGB(AColor));
      ACanvas.FillRect(ARect);
      {$ELSE}
      if Active then
        DitheredRect(ACanvas, ARect, ColorToRGB(AColor), clWhite)
      else
        DitheredRect(ACanvas, ARect, ColorToRGB(AColor), ColorToRGB(clBtnShadow));
      {$ENDIF}
    end else
    begin
      BackColor := GetMidColor(GetMidColor(AColor, clWhite), clWhite);
      if Active then
        BackColor := GetMidColor(BackColor, clWhite);
      ACanvas.Brush.Color := BackColor;
      ACanvas.FillRect(ARect);
    end;
  finally
    ACanvas.Brush := SaveBrush;
    ACanvas.Font := SaveFont;
    SaveBrush.Free;
    SaveFont.Free;
  end;
end;

procedure TSPBasePlanner.PaintBorder(ACanvas: TCanvas; ARect: TRect;
  AColor: TColor; Dark, Dithered: Boolean);
var
  BackColor: TColor;
  SaveBrush: TBrush;
  SaveFont: TFont;
begin
  SaveBrush := TBrush.Create;
  SaveFont := TFont.Create;
  SaveBrush.Assign(ACanvas.Brush);
  SaveFont.Assign(ACanvas.Font);
  try
    if Dithered then
    begin
      {$IFDEF SP_FAST_DITHER}
      if Dark then
        ACanvas.Font.Color := clBlack
      else
        ACanvas.Font.Color := clGray;
      ACanvas.Brush.Bitmap := PatternBitmap;
      SetBkColor(ACanvas.Handle, ColorToRGB(AColor));
      ACanvas.FillRect(ARect);
      {$ELSE}
      if Dark then
        DitheredRect(ACanvas, ARect, ColorToRGB(AColor), clDkGray)
      else
        DitheredRect(ACanvas, ARect, ColorToRGB(AColor), clGray);
      {$ENDIF}
    end else
    begin
      BackColor := GetMidColor(GetMidColor(AColor, clWhite), clWhite);
      if Dark then
        BackColor := GetMidColor(AColor, BackColor);
      BackColor := GetMidColor(BackColor, clSilver);
      ACanvas.Brush.Color := BackColor;
      ACanvas.FillRect(ARect);
    end;
  finally
    ACanvas.Brush := SaveBrush;
    ACanvas.Font := SaveFont;
    SaveBrush.Free;
    SaveFont.Free;
  end;
end;

function TSPBasePlanner.GetMidColor(Color1, Color2: TColor): TColor;
begin
  Result := ((ColorToRGB(Color1) shr 1) and $7F7F7F7F) +
    ((ColorToRGB(Color2) shr 1) and $7F7F7F7F);
end;

procedure TSPBasePlanner.SetPrintFont(const Value: TFont);
begin
  FPrintFont.Assign(Value);
end;

function TSPBasePlanner.GetPrintPages(ACanvas: TCanvas; ARect: TRect): Integer;
var
  RowsPerPage: Integer;
begin
  if AutoSizeRows then
  begin
    Result := 1
  end else
  begin
    InitPrintSettings(ACanvas, ARect, False);

    RowsPerPage :=
      (PrintContentRect.Bottom - PrintContentRect.Top) div PrintRowHeight;
    Result := RowCount div RowsPerPage;
    if RowCount mod RowsPerPage > 0 then
      Inc(Result);
  end;
end;

procedure TSPBasePlanner.ScalePrintFont(ACanvas: TCanvas; ARect: TRect);
begin
end;

procedure TSPBasePlanner.InitPrintSettings(ACanvas: TCanvas; ARect: TRect;
  AFit: Boolean);
var
  TempHeaderHeight, TempFooterHeight, TempBarWidth, TempSubHeight,
  TotalHeight, TotalWidth, VisibleRows: Integer;
  LinesPerRow, RequiredSpace: Integer;
begin
  FPrintLineWidth :=
    (GetDeviceCaps(ACanvas.Handle, LOGPIXELSX) +
     GetDeviceCaps(ACanvas.Handle, LOGPIXELSX)) div 216;

  ACanvas.Font := PrintFont;
  FPrintTextHeight := ACanvas.TextHeight('0');
  FPrintSpacing := PrintTextHeight div 10;

  TotalHeight := ARect.Bottom - ARect.Top;
  TotalWidth := ARect.Right - ARect.Left;

  TempHeaderHeight := HeaderRows * (FPrintTextHeight + 2 * FPrintSpacing);
  TempFooterHeight := FooterRows * (FPrintTextHeight + 2 * FPrintSpacing);
  TempSubHeight := SubHeaderRows * (FPrintTextHeight + 4 * FPrintSpacing);
  if SubHeaderRows > 0 then
    Inc(TempSubHeight, 4 * FPrintSpacing);

  if AutoSizeRows then
  begin
    FPrintRowHeight :=
      (TotalHeight - (TempHeaderHeight + TempFooterHeight)) div RowCount;

    FPrintHeaderRect := ARect;
    FPrintHeaderRect.Bottom :=
      ARect.Bottom -
        (TempFooterHeight + TempSubHeight + RowCount * FPrintRowHeight);
  end else
  begin
    LinesPerRow := FPrintRowLines;
    if LinesPerRow < 1 then
      LinesPerRow := 1;
    RequiredSpace := 2;
    if LinesPerRow > 1 then
      RequiredSpace := RequiredSpace * 2;
    
    FPrintRowHeight :=
      LinesPerRow * (FPrintTextHeight + RequiredSpace * FPrintSpacing);

    FPrintHeaderRect := ARect;
    FPrintHeaderRect.Bottom := FPrintHeaderRect.Top + TempHeaderHeight;
  end;

  FPrintSubHeaderRect := ARect;
  FPrintSubHeaderRect.Top := FPrintHeaderRect.Bottom;
  FPrintSubHeaderRect.Bottom := FPrintSubHeaderRect.Top + TempSubHeight;

  FPrintContentRect := ARect;
  FPrintContentRect.Top := FPrintSubHeaderRect.Bottom;
  FPrintContentRect.Bottom :=
    FPrintContentRect.Top + RowCount * FPrintRowHeight;

  FPrintFooterRect := ARect;
  FPrintFooterRect.Top := FPrintContentRect.Bottom;
  FPrintFooterRect.Bottom := FPrintFooterRect.Top + TempFooterHeight;

  if FPrintFooterRect.Bottom > ARect.Bottom then
  begin
    if AFit then
      FPrintRowHeight :=
        (TotalHeight -
          (TempHeaderHeight + TempSubHeight + TempFooterHeight))
         div RowCount;

    VisibleRows :=
      ((ARect.Bottom - FPrintContentRect.Top) - TempFooterHeight)
        div FPrintRowHeight;
    FPrintContentRect.Bottom := FPrintContentRect.Top +
      FPrintRowHeight * VisibleRows;

    FPrintFooterRect.Top := FPrintContentRect.Bottom;
    FPrintFooterRect.Bottom := FPrintFooterRect.Top + TempFooterHeight;
  end;

  TempBarWidth := BarCols * ACanvas.TextWidth('0');
  if BarCols > 0 then
    Inc(TempBarWidth, 2 * FPrintSpacing);

  if Columns.Count > 0 then
  begin
    FPrintColWidth := (TotalWidth - TempBarWidth) div Columns.Count;
    if BarCols > 0 then
      TempBarWidth := TotalWidth - Columns.Count * FPrintColWidth;
  end;

  FPrintBarRect := ARect;
  if UseRightToLeftAlignment then
  begin
    FPrintBarRect.Left := FPrintBarRect.Right - TempBarWidth;
    FPrintContentRect.Right := FPrintBarRect.Left;
    FPrintHeaderRect.Right := FPrintBarRect.Left;
    FPrintSubHeaderRect.Right := FPrintBarRect.Left;
  end else
  begin
    FPrintBarRect.Right := FPrintBarRect.Left + TempBarWidth;
    FPrintContentRect.Left := FPrintBarRect.Right;
    FPrintHeaderRect.Left := FPrintBarRect.Right;
    FPrintSubHeaderRect.Left := FPrintBarRect.Right;
  end;

  FPrintCornerRect := FPrintBarRect;
  FPrintCornerRect.Bottom := FPrintSubHeaderRect.Bottom;

  FPrintBarRect.Top := FPrintContentRect.Top;
  FPrintBarRect.Bottom := FPrintContentRect.Bottom;
end;

procedure TSPBasePlanner.PrintHeader(ACanvas: TCanvas;
  AColor, AHeaderColor, AHeaderTextColor, ABorderColor: TColor; APage: Integer);
var
  i: Integer;
  R, TextRect: TRect;
begin
  ACanvas.Rectangle(PrintHeaderRect.Left, PrintHeaderRect.Top,
    PrintHeaderRect.Right, PrintHeaderRect.Bottom);

  if (GroupBy <> grNone) and (Resources.Count > 0) and (HeaderRows > 1) then
  begin
    R := PrintHeaderRect;
    R.Top := R.Bottom - (PrintTextHeight + 2 * PrintSpacing);
    ACanvas.Rectangle(R.Left, R.Top, R.Right, R.Bottom);
  end else
    R := PrintHeaderRect;

  if FColumns.Count > 0 then
  begin
    ACanvas.Brush.Style := bsClear;
    for i := 0 to FColumns.Count - 1 do
    begin
      TextRect := R;

      if UseRightToLeftAlignment then
      begin
        TextRect.Right := R.Right - i * PrintColWidth;
        TextRect.Left := TextRect.Right - PrintColWidth;
      end else
      begin
        TextRect.Left := R.Left + i * PrintColWidth;
        TextRect.Right := TextRect.Left + PrintColWidth;
      end;

      ACanvas.Rectangle(TextRect.Left, TextRect.Top,
        TextRect.Right, TextRect.Bottom);
      InflateRect(TextRect, 0 - PrintSpacing, 0 - PrintSpacing);
      DrawText(ACanvas.Handle, {$IFNDEF CLR}PChar{$ENDIF}(FColumns[i].FHeader),
        -1, TextRect, DrawTextBiDiModeFlags(DT_CENTER or DT_SINGLELINE or DT_NOPREFIX));
    end;
  end;
end;

procedure TSPBasePlanner.PrintSubHeader(ACanvas: TCanvas;
  AColor, AHeaderColor, AHeaderTextColor, ABorderColor: TColor; APage: Integer);
var
  i, x: Integer;
begin
  ACanvas.Rectangle(PrintSubHeaderRect.Left, PrintSubHeaderRect.Top,
    PrintSubHeaderRect.Right, PrintSubHeaderRect.Bottom);

  for i := 0 to FColumns.Count - 2 do
  begin
    if UseRightToLeftAlignment then
      x := PrintSubHeaderRect.Right - PrintColWidth * (i + 1)
    else
      x := PrintSubHeaderRect.Left + PrintColWidth * (i + 1);
    ACanvas.Polyline([Point(x, PrintSubHeaderRect.Top), Point(x, PrintSubHeaderRect.Bottom)]);
  end;
end;

procedure TSPBasePlanner.PrintHeaderCorner(ACanvas: TCanvas;
  AColor, AHeaderColor, AHeaderTextColor, ABorderColor: TColor; APage: Integer);
begin
  ACanvas.Rectangle(PrintCornerRect.Left, PrintCornerRect.Top,
    PrintCornerRect.Right, PrintCornerRect.Bottom);
end;

procedure TSPBasePlanner.PrintBar(ACanvas: TCanvas;
  AColor, AHeaderColor, AHeaderTextColor, ABorderColor: TColor; APage: Integer);
begin
  ACanvas.Rectangle(PrintBarRect.Left, PrintBarRect.Top,
    PrintBarRect.Right, PrintBarRect.Bottom);
end;

procedure TSPBasePlanner.PrintContent(ACanvas: TCanvas;
  AColor, AHeaderColor, AHeaderTextColor, ABorderColor: TColor; APage: Integer);
begin
  ACanvas.Rectangle(PrintContentRect.Left, PrintContentRect.Top,
    PrintContentRect.Right, PrintContentRect.Bottom);
end;

procedure TSPBasePlanner.PrintFooter(ACanvas: TCanvas;
  AColor, AHeaderColor, AHeaderTextColor, ABorderColor: TColor; APage: Integer);
begin
  ACanvas.Rectangle(PrintFooterRect.Left, PrintFooterRect.Top,
    PrintFooterRect.Right, PrintFooterRect.Bottom);
end;

procedure TSPBasePlanner.Print(ACanvas: TCanvas; ARect: TRect;
  AColor, AHeaderColor, AHeaderTextColor, ABorderColor: TColor;
  APage: Integer; AInvertHeaderColors, AFit: Boolean);

  procedure InitCanvas(BrushColor, TextColor: TColor);
  begin
    ACanvas.Font := PrintFont;
    ACanvas.Font.Color := TextColor;
    ACanvas.Brush.Color := BrushColor;
    ACanvas.Brush.Style := bsSolid;
    ACanvas.Pen.Style := psSolid;
    ACanvas.Pen.Width := FPrintLineWidth;
    ACanvas.Pen.Color := ABorderColor;
  end;

var
  SaveBrush: TBrush;
  SaveFont: TFont;
  SavePen: TPen;
  SaveFontSize: Integer;
  ActualHeaderColor, ActualHeaderTextColor: TColor;
begin
  if not Assigned(ACanvas) then
    raise Exception.Create(SPrintCanvas);
  if (ARect.Right <= ARect.Left) or (ARect.Bottom <= ARect.Top) then
    raise Exception.Create(SPrintRect);
  if APage < 1 then
    raise Exception.Create(SPrintPage);

  SaveBrush := TBrush.Create;
  SaveFont := TFont.Create;
  SavePen := TPen.Create;
  SaveBrush.Assign(ACanvas.Brush);
  SaveFont.Assign(ACanvas.Font);
  SavePen.Assign(ACanvas.Pen);

  SaveFontSize := PrintFont.Size;

  try
    if AFit then
      ScalePrintFont(ACanvas, ARect);

    if APage > 1 then
    begin
      if AFit then
        raise Exception.Create(SPrintPage)
      else
        if APage > GetPrintPages(ACanvas, ARect) then
          raise Exception.Create(SPrintPage)
    end;

    InitPrintSettings(ACanvas, ARect, AFit);

    InitCanvas(AColor, PrintFont.Color);
    PrintContent(ACanvas, AColor, AHeaderColor, AHeaderTextColor,
      ABorderColor, APage);

    InitCanvas(GetMidColor(AColor, AHeaderColor), AHeaderTextColor);
    PrintSubHeader(ACanvas, AColor, AHeaderColor, AHeaderTextColor,
      ABorderColor, APage);

    InitCanvas(AHeaderColor, AHeaderTextColor);
    PrintBar(ACanvas, AColor, AHeaderColor, AHeaderTextColor,
      ABorderColor, APage);

    if AInvertHeaderColors then
    begin
      ActualHeaderColor := AHeaderTextColor;
      ActualHeaderTextColor := AHeaderColor;
    end else
    begin
      ActualHeaderColor := AHeaderColor;
      ActualHeaderTextColor := AHeaderTextColor;
    end;

    InitCanvas(ActualHeaderColor, ActualHeaderTextColor);
    PrintHeader(ACanvas, AColor, ActualHeaderColor, ActualHeaderTextColor,
      ABorderColor, APage);

    InitCanvas(ActualHeaderColor, ActualHeaderTextColor);
    PrintHeaderCorner(ACanvas, AColor, ActualHeaderColor, ActualHeaderTextColor,
      ABorderColor, APage);

    InitCanvas(ActualHeaderColor, ActualHeaderTextColor);
    PrintFooter(ACanvas, AColor, ActualHeaderColor, ActualHeaderTextColor,
      ABorderColor, APage);

  finally
    ACanvas.Brush := SaveBrush;
    ACanvas.Font := SaveFont;
    ACanvas.Pen := SavePen;
    SaveBrush.Free;
    SaveFont.Free;
    SavePen.Free;
    PrintFont.Size := SaveFontSize;
  end;
end;

procedure TSPBasePlanner.PrintItemIcons(ACanvas: TCanvas; var ItemRect: TRect;
  AImages: TCustomImageList; AIcons: TSPPlanIcons; RTL: Boolean;
  ItemColor: TColor);
var
  IconBitmap: TBitmap;
  i: Integer;
  IconRect: TRect;
begin
  IconBitmap := TBitmap.Create;
  IconBitmap.PixelFormat := pf24bit;
  try
    if Assigned(AImages) then
    begin
      IconBitmap.Width := Source.Images.Width;
      IconBitmap.Height := Source.Images.Height;
      IconBitmap.Canvas.Brush.Style := bsSolid;
      IconBitmap.Canvas.Brush.Color := ItemColor;

      for i := 0 to AIcons.Count - 1 do
        if AIcons[i] < AImages.Count then
        begin
          IconBitmap.Canvas.FillRect(
            Rect(0, 0, IconBitmap.Width, IconBitmap.Height));

          AImages.Draw(IconBitmap.Canvas, 0, 0, AIcons[i]);
          IconRect := ItemRect;
          if UseRightToLeftAlignment then
            IconRect.Left := IconRect.Right - PrintTextHeight
          else
            IconRect.Right := IconRect.Left + PrintTextHeight;
          IconRect.Bottom := IconRect.Top + PrintTextHeight;
          if (IconRect.Left >= ItemRect.Left) and
            (IconRect.Right <= ItemRect.Right) then
          begin
            ACanvas.StretchDraw(IconRect, IconBitmap);
            if UseRightToLeftAlignment then
              ItemRect.Right := IconRect.Left - PrintSpacing
            else
              ItemRect.Left := IconRect.Right + PrintSpacing;
          end else
            Break;
        end;
    end;
  finally
    IconBitmap.Free;
  end;
end;

{$IFNDEF SP_FAST_DITHER}
procedure TSPBasePlanner.DitheredRect(ACanvas: TCanvas; ARect: TRect;
  BackColor, ForeColor: TColor);
var
  BackBitmap, ForeBitmap: TBitmap;
  SaveBrush: TBrush;
  BitRect: TRect;
begin
  BitRect := Rect(0, 0, 8, 8);

  SaveBrush := TBrush.Create;
  SaveBrush.Assign(ACanvas.Brush);

  BackBitmap := TBitmap.Create;
  ForeBitmap := TBitmap.Create;

  try
    BackBitmap.Width := 8;
    BackBitmap.Height := 8;
    BackBitmap.Canvas.Brush.Style := bsSolid;
    BackBitmap.Canvas.Brush.Color := BackColor;
    BackBitmap.Canvas.FillRect(BitRect);
    ForeBitmap.Width := 8;
    ForeBitmap.Height := 8;
    ForeBitmap.Canvas.Brush.Style := bsSolid;

    ForeBitmap.Canvas.Brush.Color := BackColor;
    ForeBitmap.Canvas.BrushCopy(BitRect, PatternBitmap, BitRect, clBlack);
    BackBitmap.Canvas.BrushCopy(BitRect, ForeBitmap, BitRect, BackColor);
    ForeBitmap.Canvas.Brush.Color := ForeColor;
    ForeBitmap.Canvas.BrushCopy(BitRect, PatternBitmap, BitRect, clWhite);
    BackBitmap.Canvas.BrushCopy(BitRect, ForeBitmap, BitRect, clBlack);

    ACanvas.Brush.Bitmap := BackBitmap;
    ACanvas.FillRect(ARect);
  finally
    ACanvas.Brush := SaveBrush;
    SaveBrush.Free;
    BackBitmap.Free;
    ForeBitmap.Free;
  end;
end;
{$ENDIF}

procedure TSPBasePlanner.SendMouseMove;
var
  CurPos: TPoint;
  SmallCurPos: TSmallPoint;
begin
  CurPos := Mouse.CursorPos;
  Windows.ScreenToClient(Mouse.Capture, CurPos);
  SmallCurPos := PointToSmallPoint(CurPos);
  SendMessage(Mouse.Capture, WM_MouseMove, 0,
    {$IFDEF CLR}
    MakeLParam(SmallCurPos.X, SmallCurPos.Y)
    {$ELSE}
    Integer(SmallCurPos)
    {$ENDIF}
    );
end;

procedure TSPBasePlanner.SetAlternateCalendar(const Value: TSPCustomCalendarProvider);
begin
  if FAlternateCalendar <> Value then
  begin
    FAlternateCalendar := Value;
    if Assigned(FAlternateCalendar) then
      FAlternateCalendar.FreeNotification(Self);
    AlternateCalendarChanged;
  end;
end;

function TSPBasePlanner.CanModifySelected: Boolean;
var
  i: Integer;
begin
  if SelectedCount > 0 then
  begin
    Result := True;
    for i := 0 to SelectedCount - 1 do
      if SelectedItems[i].ReadOnly then
      begin
        Result := False;
        Break;
      end;
  end else
    Result := False;
end;

procedure TSPBasePlanner.DoItemHint(Item: TSPPlanItem; var ItemHint: string);
begin
  if Assigned(FOnItemHint) then
    FOnItemHint(Self, Item, ItemHint);
end;

procedure TSPBasePlanner.SetClockFormat(const Value: TSPClockFormat);
begin
  if FClockFormat <> Value then
  begin
    FClockFormat := Value;
    ApplyClockFormat;
    ClockFormatChanged;
  end;
end;

procedure TSPBasePlanner.ClockFormatChanged;
begin
end;

procedure TSPBasePlanner.ApplyClockFormat;
begin
  if FClockFormat = cfLocaleDefault then
  begin
    {$IFDEF CLR}
    if Pos('tt', DateTimeFormatInfo.CurrentInfo.ShortTimePattern) > 0 then
    {$ELSE}
    if StrToIntDef(GetLocaleStr(GetThreadLocale, LOCALE_ITIME, '0'), 0) = 0 then
    {$ENDIF}
      FDisplayClockFormat := cf12Hours
    else
      FDisplayClockFormat := cf24Hours;
  end else
    FDisplayClockFormat := FClockFormat;
end;

{ TSPPlannerColumns }

function TSPPlannerColumns.Add: TSPPlannerColumn;
begin
  Result := TSPPlannerColumn(inherited Add);
end;

constructor TSPPlannerColumns.Create(Planner: TSPBasePlanner);
begin
  inherited Create(TSPPlannerColumn);
  FPlanner := Planner;
end;

function TSPPlannerColumns.GetItem(Index: Integer): TSPPlannerColumn;
begin
  Result := TSPPlannerColumn(inherited GetItem(Index));
end;

function TSPPlannerColumns.GetOwner: TPersistent;
begin
  Result := FPlanner;
end;

procedure TSPPlannerColumns.SetItem(Index: Integer;
  Value: TSPPlannerColumn);
begin
  inherited SetItem(Index, Value);
end;

procedure TSPPlannerColumns.Update(Item: TCollectionItem);
begin
  inherited Update(Item);
  if Assigned(FPlanner) then
  begin
    FPlanner.CalcDisplayRects;
    FPlanner.Invalidate;
  end;
end;

{ TSPPlannerColumn }

constructor TSPPlannerColumn.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FBackColor := clNone;
  FImageIndex := -1;
end;

procedure TSPPlannerColumn.SetBackColor(const Value: TColor);
begin
  if FBackColor <> Value then
  begin
    FBackColor := Value;
    Changed(False);
  end;
end;

procedure TSPPlannerColumn.SetHeader(const Value: string);
begin
  if FHeader <> Value then
  begin
    FHeader := Value;
    Changed(False);
  end;
end;

procedure TSPPlannerColumn.SetImageIndex(const Value: TImageIndex);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    Changed(False);
  end;
end;

{ TSPPlanIcons }

function TSPPlanIcons.Add(Value: TImageIndex): Integer;
begin
  if FCount = FArraySize then
  begin
    Inc(FArraySize, 8);
    SetLength(FIcons, FArraySize);
  end;
  FIcons[FCount] := Value;
  Result := FCount;
  Inc(FCount);
  Change;
end;

procedure TSPPlanIcons.Assign(Source: TSPPlanIcons);
begin
  FArraySize := Source.FArraySize;
  FIcons := Copy(Source.FIcons);
  Change;
end;

procedure TSPPlanIcons.Change;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TSPPlanIcons.Clear;
var
  OldCount: Integer;
begin
  OldCount := FCount;
  FCount := 0;
  if OldCount <> FCount then
    Change;
end;

constructor TSPPlanIcons.Create;
begin
  inherited Create;
  FArraySize := 8;
  SetLength(FIcons, FArraySize);
end;

procedure TSPPlanIcons.Delete(Index: Integer);
var
  i: Integer;
begin
  for i := Index + 1 to FCount - 1 do
    FIcons[i - 1] := FIcons[i];
  Dec(FCount);
  if (FCount <= (FArraySize - 8)) and (FArraySize > 8) then
  begin
    Dec(FArraySize, 8);
    SetLength(FIcons, FArraySize);
  end;
  Change;
end;

function TSPPlanIcons.GetItem(Index: Integer): TImageIndex;
begin
  Result := FIcons[Index];
end;

procedure TSPPlanIcons.SetItem(Index: Integer; const Value: TImageIndex);
begin
  if FIcons[Index] <> Value then
  begin
    FIcons[Index] := Value;
    Change;
  end;
end;

{ TSPInplaceEdit }

constructor TSPInplaceEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ParentCtl3D := False;
  Ctl3D := False;
  TabStop := False;
  BorderStyle := bsNone;
  DoubleBuffered := False;
end;

procedure TSPInplaceEdit.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style :=
    (Params.Style or ES_MULTILINE) and (not ES_AUTOHSCROLL);
end;

procedure TSPInplaceEdit.CreateWnd;
begin
  inherited CreateWnd;
  SendMessage(Handle, EM_SETMARGINS,
    EC_LEFTMARGIN or EC_RIGHTMARGIN, $00020002);
end;

procedure TSPInplaceEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: TSPBasePlanner(Parent).CloseEditor(False);
    VK_RETURN:
      begin
        if ssShift in Shift then
          inherited KeyDown(Key, Shift)
        else
          TSPBasePlanner(Parent).CloseEditor(True);
      end;
  else
    inherited KeyDown(Key, Shift);
  end;
end;

procedure TSPInplaceEdit.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  TSPBasePlanner(Parent).CloseEditor(True);
end;

{ TSPPlannerResource }

constructor TSPPlannerResource.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FImageIndex := -1;
  FColor := clNone;
end;

procedure TSPPlannerResource.AssignTo(Dest: TPersistent); 
var
  DestResource: TSPPlannerResource;
begin
  if Dest is TSPPlannerResource then
  begin
    DestResource := TSPPlannerResource(Dest);
    DestResource.FName := FName;
    DestResource.FImageIndex := FImageIndex;
    DestResource.FColor := FColor;
    DestResource.Changed(False);
  end else
    inherited AssignTo(Dest);
end;

function TSPPlannerResource.GetDisplayName: string;
begin
  if FName <> '' then
    Result := FName
  else
    Result := inherited GetDisplayName;
end;

procedure TSPPlannerResource.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Changed(False);
  end;
end;

procedure TSPPlannerResource.SetDisplayName(const Value: string);
begin
  Name := Value;
end;

procedure TSPPlannerResource.SetImageIndex(const Value: TImageIndex);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    Changed(False);
  end;
end;

procedure TSPPlannerResource.SetName(const Value: string);
begin
  if FName <> Value then
  begin
    FName := Value;
    Changed(False);
  end;
end;

{ TSPPlannerResources }

function TSPPlannerResources.Add: TSPPlannerResource;
begin
  Result := TSPPlannerResource(inherited Add);
end;

constructor TSPPlannerResources.Create(Planner: TSPBasePlanner);
begin
  inherited Create(TSPPlannerResource);
  FPlanner := Planner;
end;

function TSPPlannerResources.GetItem(Index: Integer): TSPPlannerResource;
begin
  Result := TSPPlannerResource(inherited GetItem(Index));
end;

function TSPPlannerResources.GetOwner: TPersistent;
begin
  Result := FPlanner;
end;

procedure TSPPlannerResources.SetItem(Index: Integer;
  Value: TSPPlannerResource);
begin
  inherited SetItem(Index, Value);
end;

procedure TSPPlannerResources.Update(Item: TCollectionItem);
begin
  inherited Update(Item);
  if Assigned(FPlanner) then
    FPlanner.ResourcesChange;
end;

{ TSPDisplayItem }

procedure TSPDisplayItem.Change;
begin
  if Assigned(FOwner) then
    FOwner.Change(Self);
end;

constructor TSPDisplayItem.Create(AOwner: TSPDisplayItems;
  AItem: TSPPlanItem; AOffset: Double);
begin
  inherited Create;
  FOwner := AOwner;
  FItem := AItem;
  FOffset := AOffset;
  if Assigned(FOwner) then
    FOwner.FList.Add(Self);
  Change;
end;

destructor TSPDisplayItem.Destroy;
begin
  if Assigned(FOwner) then
    FOwner.FList.Remove(Self);
  Change;
  inherited Destroy;
end;

{ TSPDisplayItems }

function TSPDisplayItems.Add(Item: TSPPlanItem;
  Offset: Double): TSPDisplayItem;
begin
  Result := TSPDisplayItem.Create(Self, Item, Offset);
end;

procedure TSPDisplayItems.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TSPDisplayItems.CalcItemCells(DisplayItem: TSPDisplayItem);
var
  ItemStart, ItemEnd: Double;
begin
  ItemStart := DisplayItem.Item.StartTime{$IFDEF CLR}.ToOADate{$ENDIF} +
    DisplayItem.FOffset;
  ItemEnd := DisplayItem.Item.EndTime{$IFDEF CLR}.ToOADate{$ENDIF} +
    DisplayItem.FOffset;

  DisplayItem.FStartCell :=
    Floor((ItemStart + OneMillisecond -
      CellStart{$IFDEF CLR}.ToOADate{$ENDIF}) /
        CellDuration{$IFDEF CLR}.ToOADate{$ENDIF});
  DisplayItem.FStartTimeMarker :=
    ((ItemStart - CellStart{$IFDEF CLR}.ToOADate{$ENDIF}) /
      CellDuration{$IFDEF CLR}.ToOADate{$ENDIF}) - DisplayItem.FStartCell;

  DisplayItem.FEndCell :=
    Floor((ItemEnd - (OneMillisecond +
      CellStart{$IFDEF CLR}.ToOADate{$ENDIF})) /
        CellDuration{$IFDEF CLR}.ToOADate{$ENDIF});
  if DisplayItem.FEndCell < DisplayItem.FStartCell then
    DisplayItem.FEndCell := DisplayItem.FStartCell;

  DisplayItem.FEndTimeMarker :=
    ((ItemEnd - CellStart{$IFDEF CLR}.ToOADate{$ENDIF}) /
      CellDuration{$IFDEF CLR}.ToOADate{$ENDIF}) - DisplayItem.FEndCell;

  if (CompareDateTime(DisplayItem.FEndTimeMarker, 0) = 0) and
    (DisplayItem.FEndCell > DisplayItem.FStartCell) then
  begin
    DisplayItem.FEndTimeMarker := 1;
    Dec(DisplayItem.FEndCell);
  end;
end;

procedure TSPDisplayItems.CalculateSpans;
var
  i: Integer;
  CurItem: TSPDisplayItem;
  LastGroupIndex, LastGroupBottom: Integer;
begin
  LastGroupIndex := - 1;
  LastGroupBottom := 0;

  for i := 0 to FList.Count - 1 do
  begin
    CurItem := TSPDisplayItem(FList[i]);
    CalcItemCells(CurItem);
    CurItem.FSpanRange := 0;
    CurItem.FSpanStart := 0;
    CurItem.FSpanEnd := 0;
  end;

  for i := 0 to FList.Count - 1 do
  begin
    CurItem := TSPDisplayItem(FList[i]);
    if i < FList.Count - 1 then
    begin
      if CurItem.EndCell > LastGroupBottom then
        LastGroupBottom := CurItem.EndCell;
      if LastGroupBottom >=
        TSPDisplayItem(FList[i + 1]).StartCell then
      begin
        if LastGroupIndex < 0 then
          LastGroupIndex := i;
      end else
      if LastGroupIndex >= 0 then
      begin
        SetGroupSpans(LastGroupIndex, i);
        LastGroupIndex := -1;
        LastGroupBottom := 0;
      end;
    end else
      if LastGroupIndex >= 0 then
        SetGroupSpans(LastGroupIndex, i);
  end;
end;

procedure TSPDisplayItems.Change(Item: TSPDisplayItem);
begin
  if FUpdateCount = 0 then
  begin
    FList.Sort(CompareDisplayItems);
    CalculateSpans;
  end;
end;

procedure TSPDisplayItems.Clear;
begin
  if Count > 0 then
  begin
    BeginUpdate;
    while Count > 0 do
      Items[0].Free;
    EndUpdate;
  end;
end;

constructor TSPDisplayItems.Create;
begin
  inherited Create;
  FList := TList.Create;
  FCellDuration := 1;
end;

procedure TSPDisplayItems.Delete(Index: Integer);
begin
  Items[Index].Free;
end;

destructor TSPDisplayItems.Destroy;
begin
  Clear;
  FList.Free;
  inherited Destroy;
end;

procedure TSPDisplayItems.EndUpdate;
begin
  if FUpdateCount > 0 then
  begin
    Dec(FUpdateCount);
    if FUpdateCount = 0 then
      Change(nil);
  end;
end;

function TSPDisplayItems.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TSPDisplayItems.GetItem(Index: Integer): TSPDisplayItem;
begin
  Result := TSPDisplayItem(FList[Index]);
end;

procedure TSPDisplayItems.Remove(DisplayItem: TSPDisplayItem);
begin
  DisplayItem.Free;
end;

procedure TSPDisplayItems.SetCellDuration(const Value: TDateTime);
begin
  if FCellDuration <> Value then
  begin
    FCellDuration := Value;
    Change(nil);
  end;
end;

procedure TSPDisplayItems.SetCellStart(const Value: TDateTime);
begin
  if FCellStart <> Value then
  begin
    FCellStart := Value;
    Change(nil);
  end;
end;

procedure TSPDisplayItems.SetGroupSpans(StartIndex, EndIndex: Integer);
var
  i, j, k, TotalRange: Integer;
  Item, CompareItem, OverlapItem: TSPDisplayItem;
  ItemRect, CompareRect, OverlapRect: TRect;
begin
  TotalRange := 0;
  for i := StartIndex to EndIndex do
  begin
    Item := TSPDisplayItem(FList[i]);
    Item.FSpanStart := TotalRange;
    for j := TotalRange - 1 downto 0 do
    begin
      OverlapItem := nil;
      for k := i - 1 downto StartIndex do
      begin
        CompareItem := TSPDisplayItem(FList[k]);
        if (CompareItem.FSpanStart = j) and
          (CompareItem.EndCell >= Item.StartCell) then
        begin
          OverlapItem := CompareItem;
          Break;
        end;
      end;
      if not Assigned(OverlapItem) then
        Item.FSpanStart := j;
    end;

    Item.FSpanEnd := Item.FSpanStart + 1;
    if Item.FSpanEnd > TotalRange then
      TotalRange := Item.FSpanEnd;
  end;

  for i := StartIndex to EndIndex do
  begin
    Item := TSPDisplayItem(FList[i]);
    Item.FSpanRange := TotalRange;
    if Item.FSpanEnd < TotalRange then
    begin
      ItemRect :=
        Rect(Item.FSpanStart, Item.StartCell, Item.FSpanEnd, Item.EndCell + 1);
      for j := Item.FSpanEnd + 1 to TotalRange do
      begin
        ItemRect.Right := j;
        OverlapItem := nil;
        for k := StartIndex to EndIndex do
        begin
          CompareItem := TSPDisplayItem(FList[k]);
          if CompareItem <> Item then
          begin
            CompareRect :=
              Rect(CompareItem.FSpanStart, CompareItem.StartCell,
                CompareItem.FSpanEnd, CompareItem.EndCell + 1);
            IntersectRect(OverlapRect, ItemRect, CompareRect);
            if OverlapRect.Right > 0 then
            begin
              OverlapItem := CompareItem;
              Break;
            end;
          end;
        end;
        if Assigned(OverlapItem) then
          Break;
        Item.FSpanEnd := j;
      end;
    end;
  end;
end;

procedure PreparePatternBitmap;
var
  x, y: Integer;
begin
  PatternBitmap := TBitmap.Create;
  {$IFDEF CONDITIONALEXPRESSIONS}
  {$IF RTLVersion >= 14.0}
  {$IFNDEF CLR}
  PatternBitmap.PixelFormat := pf1bit;
  {$ENDIF}
  {$IFEND}
  {$ENDIF}
  PatternBitmap.Width := 8;
  PatternBitmap.Height := 8;
  for x := 0 to 7 do
    for y := 0 to 7 do
      if (x mod 2) = (y mod 2) then
        PatternBitmap.Canvas.Pixels[x, y] := clWhite
      else
        PatternBitmap.Canvas.Pixels[x, y] := clBlack;
end;

type
  {$IFNDEF CLR}
  PBitmapLine = ^TBitmapLine;
  TBitmapLine = array[0..32767] of DWORD;
  {$ENDIF}

  TShadowDef = array[0..3] of DWORD;

const
  SHADOW_TOP_RIGHT: TShadowDef =
    ($0A070401, $1E160B04, $3C2D1607, $503C1E0A);
  SHADOW_RIGHT: TShadowDef =
    ($5A44220B, $5A44220B, $5A44220B, $5A44220B);
  SHADOW_BOTTOM_RIGHT: TShadowDef =
    ($503C1E0A, $3C2D1607, $1E160B04, $0A070401);
  SHADOW_BOTTOM: TShadowDef =
    ($5A5A5A5A, $44444444, $22222222, $0B0B0B0B);
  SHADOW_BOTTOM_LEFT: TShadowDef =
    ($0A1E3C50, $07162D3C, $040B161E, $0104070A);

function BuildAlphaBitmap(Def: TShadowDef): TBitmap;
var
  x, y: Integer;
  Pixel: DWORD;
  {$IFDEF CLR}
  Line: IntPtr;
  {$ELSE}
  Line: PBitmapLine;
  {$ENDIF}
  Value: DWORD;
begin
  Result := TBitmap.Create;
  Result.Width := 4;
  Result.Height := 4;
  Result.PixelFormat := pf32Bit;
  for y := 0 to 3 do
  begin
    Line := Result.ScanLine[y];
    Value := Def[y];
    for x := 0 to 3 do
    begin
      Pixel := (Value shl ((y * 4 + x) * 8)) and $FF000000;
      {$IFDEF CLR}
      Marshal.WriteInt32(Line, x * 4, Pixel);
      {$ELSE}
      Line[x] := Pixel;
      {$ENDIF}
    end;
  end;
end;

initialization
  {$IFNDEF CLR}
  hMsImg32 := LoadLibrary('MSIMG32.DLL');
  if hMsImg32 <> 0 then
  begin
    FuncGradientFill := GetProcAddress(hMsImg32, 'GradientFill');
    FuncAlphaBlend := GetProcAddress(hMsImg32, 'AlphaBlend');
  end;
  {$ENDIF}
  GlowBitmap := TBitmap.Create;
  BarMoreBitmap := TBitmap.Create;
  OutOfOfficeBitmap := TBitmap.Create;
  MoreBitmapLTR := TBitmap.Create;
  MoreBitmapRTL := TBitmap.Create;
  {$IFDEF CLR}
  GlowBitmap.LoadFromResourceName('SPGLOW',
    'ShorterPath.Planners.Vcl.SPPlanBitmaps',
    Assembly.GetCallingAssembly);
  OutOfOfficeBitmap.LoadFromResourceName('SPOUTOFOFFICE',
    'ShorterPath.Planners.Vcl.SPPlanBitmaps',
    Assembly.GetCallingAssembly);
  MoreBitmapLTR.LoadFromResourceName('SPMORELTR',
    'ShorterPath.Planners.Vcl.SPPlanBitmaps',
    Assembly.GetCallingAssembly);
  MoreBitmapRTL.LoadFromResourceName('SPMORERTL',
    'ShorterPath.Planners.Vcl.SPPlanBitmaps',
    Assembly.GetCallingAssembly);
  {$ELSE}
  GlowBitmap.LoadFromResourceName(HInstance, 'SPGLOW');
  OutOfOfficeBitmap.LoadFromResourceName(HInstance, 'SPOUTOFOFFICE');
  MoreBitmapLTR.LoadFromResourceName(HInstance, 'SPMORELTR');
  MoreBitmapRTL.LoadFromResourceName(HInstance, 'SPMORERTL');
  {$ENDIF}
  PreparePatternBitmap;
  ShadowTR := BuildAlphaBitmap(SHADOW_TOP_RIGHT);
  ShadowR :=  BuildAlphaBitmap(SHADOW_RIGHT);
  ShadowBR := BuildAlphaBitmap(SHADOW_BOTTOM_RIGHT);
  ShadowB :=  BuildAlphaBitmap(SHADOW_BOTTOM);
  ShadowBL := BuildAlphaBitmap(SHADOW_BOTTOM_LEFT);

finalization
  {$IFNDEF CLR}
  if hMsImg32 > 0 then
    FreeLibrary(hMsImg32);
  {$ENDIF}
  GlowBitmap.Free;
  PatternBitmap.Free;
  ShadowTR.Free;
  ShadowR.Free;
  ShadowBR.Free;
  ShadowB.Free;
  SHadowBL.Free;
  OutOfOfficeBitmap.Free;
  BarMoreBitmap.Free;
  MoreBitmapLTR.Free;
  MoreBitmapRTL.Free;

end.
