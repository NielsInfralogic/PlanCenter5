(* SPOutSrc - Outlook Planner Source                                          *)
(*                                                                            *)
(* Shorter Path Planners                                                      *)
(*                                                                            *)
(* Copyright © 2004, 2007 Shorter Path Software                               *)
(* http://www.shorterpath.com                                                 *)
(******************************************************************************)

unit SPOutSrc;

{$B-,G+,H+,J-,O+,S-,Q-,R-,T-,W-,X+}
{$IFDEF CONDITIONALEXPRESSIONS}
{$IF RTLVersion >= 14.0}
  {$WARN SYMBOL_PLATFORM OFF}
{$IFEND}
{$ENDIF}
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

interface

uses
  Classes, SPPlanners,
  {$IFDEF CONDITIONALEXPRESSIONS}
  {$IF RTLVersion >= 14.0}
  Variants,
  {$IFEND}
  {$ENDIF}
  SPOutlook, SysUtils;

type
  TSPOutlookSource = class;
  TSPOutlookItem = class;

  TSPOutlookCalendar = class(TCollectionItem)
  private
    FDefaultCalendar: Boolean;
    FResourceName: string;
    FFolderPath: string;
    FSource: TSPOutlookSource;
    FEvents: TSPOulookItemsEvents;
    procedure SetDefaultCalendar(const Value: Boolean);
    procedure SetFolderPath(const Value: string);
    procedure SetResourceName(const Value: string);
    function IsFolderPathStored: Boolean;
    procedure DeleteItems;
    procedure UpdateItemResources;
    procedure ReadItems(StartTime, EndTime: TDateTime);
    procedure ReadItemDetails(PlanItem: TSPOutlookItem; Item: AppointmentItem);
    procedure RemoveDuplicates;
    function GetFolder: MAPIFolder;
    procedure ItemAdd(Sender: TObject; const Item: IDispatch);
    procedure ItemChange(Sender: TObject; const Item: IDispatch);
    procedure ItemDelete(Sender: TObject);
    procedure RegisterEvents(Folder: MAPIFolder);
    procedure UnregisterEvents;
  protected
    property Source: TSPOutlookSource read FSource;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property DefaultCalendar: Boolean read FDefaultCalendar
      write SetDefaultCalendar;
    property FolderPath: string read FFolderPath
      write SetFolderPath stored IsFolderPathStored;
    property ResourceName: string read FResourceName write SetResourceName;
  end;

  TSPOutlookCalendars = class(TCollection)
  private
    FSource: TSPOutlookSource;
    procedure SetItem(Index: Integer; Value: TSPOutlookCalendar);
    function GetItem(Index: Integer): TSPOutlookCalendar;
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(Source: TSPOutlookSource);
    function Add: TSPOutlookCalendar;
    property Items[Index: Integer]: TSPOutlookCalendar read GetItem
      write SetItem; default;
    property Source: TSPOutlookSource read FSource;
  end;

  TSPOutlookItem = class(TSPPlanItem)
  private
    FStoreID: string;
    FEntryID: string;
    FCalendar: TSPOutlookCalendar;
    function GetAppointment: IDispatch;
  public
    property StoreID: string read FStoreID;
    property EntryID: string read FEntryID;
    property Appointment: IDispatch read GetAppointment;
    property Calendar: TSPOutlookCalendar read FCalendar;
  end;

  TSPOutlookSource = class(TSPCustomSource)
  private
    FActive: Boolean;
    FLogonPrompt: Boolean;
    FApplication: OutlookApplication;
    FNameSpace: NameSpace;
    FPassword: string;
    FProfile: string;
    FCalendars: TSPOutlookCalendars;
    FRequestCalendar: TSPOutlookCalendar;
    FRefreshOnDelete: Boolean;
    procedure SetActive(const Value: Boolean);
    function GetDefaultFolderPath: string;
    procedure SetCalendars(const Value: TSPOutlookCalendars);
  protected
    procedure DoRequestItems(StartTime, EndTime: TDateTime); override;
    procedure ItemDelete(Item: TSPPlanItem); override;
    procedure ItemSave(Item: TSPPlanItem); override;
    property Application: OutlookApplication read FApplication;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CanModify: Boolean; override;
    function GetNameSpace: IDispatch;
  published
    property Active: Boolean read FActive write SetActive;
    property LogonPrompt: Boolean read FLogonPrompt
      write FLogonPrompt default False;
    property Profile: string read FProfile write FProfile;
    property Password: string read FPassword write FPassword;
    property Calendars: TSPOutlookCalendars read FCalendars write SetCalendars;
    property Images;
    property ReadOnly;
    property RefreshOnDelete: Boolean read FRefreshOnDelete
      write FRefreshOnDelete default True;
    property OnChange;
    property OnItemChange;
    property OnItemDelete;
    property OnItemSave;
    property OnRequestItems;
  end;

resourcestring
  SItemFolderError = 'Could not find a calendar folder for the item';
  SOpenFolderError = 'Could not open the calendar folder';

implementation

uses
  ComObj;

const
  olFolderCalendar = $00000009;

  olAppointmentItem = $00000001;

  olPrivate = $00000002;

  olFree = $00000000;
  olTentative = $00000001;
  olBusy = $00000002;
  olOutOfOffice = $00000003;

  CLASS_OutlookApplication: TGUID = '{0006F033-0000-0000-C000-000000000046}';

{$IFNDEF CONDITIONALEXPRESSIONS}
function VarIsClear(V: Variant): Boolean;
begin
  Result := VarIsEmpty(V) or VarIsNull(V);
end;

{$IFDEF VCL4}
function Supports(const Instance: IUnknown; const IID: TGUID; out Intf): Boolean;
begin
  Result := (Instance <> nil) and (Instance.QueryInterface(IID, Intf) = 0);
end;
{$ENDIF}
{$ENDIF}

{ TSPOutlookCalendar }

constructor TSPOutlookCalendar.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FSource := (Collection as TSPOutlookCalendars).FSource;
end;

procedure TSPOutlookCalendar.DeleteItems;
var
  i: Integer;
  Item: TSPOutlookItem;
begin
  Source.BeginUpdate;
  i := 0;
  while i < Source.Count do
  begin
    Item := TSPOutlookItem(Source[i]);
    if Item.FCalendar = Self then
      Source.Delete(i)
    else
      Inc(i);
  end;
  Source.EndUpdate;
end;

destructor TSPOutlookCalendar.Destroy;
begin
  if Assigned(FEvents) then
  begin
    FEvents.Free;
    FEvents := nil;
  end;
  DeleteItems;
  inherited Destroy;
end;

function TSPOutlookCalendar.GetFolder: MAPIFolder;

  function FindFolder(AFolders: Folders; Path: string): MAPIFolder;
  var
    p: Integer;
    FolderName: string;
    CurFolder: MAPIFolder;
  begin
    Result := nil;
    if Length(Path) > 0 then
    begin
      p := Pos('\', Path);
      if p > 0 then
        FolderName := Copy(Path, 1, p - 1)
      else
        FolderName := Path;
      CurFolder := AFolders.Item(FolderName);
      if p > 0 then
        Result := FindFolder(CurFolder.Folders, Copy(Path, p + 1, Length(Path)))
      else
        Result := CurFolder;
    end;
  end;

begin
  Result := nil;
  if Source.Active then
  begin
    if DefaultCalendar then
      Result := Source.FNameSpace.GetDefaultFolder(olFolderCalendar)
    else
      Result := FindFolder(Source.FNameSpace.Folders, FolderPath);
  end;
end;

function TSPOutlookCalendar.IsFolderPathStored: Boolean;
begin
  Result := not DefaultCalendar;
end;

procedure TSPOutlookCalendar.ItemAdd(Sender: TObject;
  const Item: IDispatch);
begin
  if Source.Active then
    ReadItemDetails(TSPOutlookItem(Source.Add), Item as AppointmentItem);
end;

procedure TSPOutlookCalendar.ItemChange(Sender: TObject;
  const Item: IDispatch);
var
  Appointment: AppointmentItem;
  i: Integer;
  ItemEntryID, ItemStoreID: string;
  PlanItem: TSPOutlookItem;
begin
  if Source.Active then
  begin
    PlanItem := nil;
    Appointment := Item as AppointmentItem;
    ItemEntryID := Appointment.EntryID;
    ItemStoreID := (Appointment.Parent as MAPIFolder).StoreID;

    for i := 0 to Source.Count - 1 do
    begin
      PlanItem := TSPOutlookItem(Source[i]);
      if (PlanItem.EntryID = ItemEntryID) and
        (PlanItem.StoreID = ItemStoreID) then
        Break;
      PlanItem := nil;
    end;
    if not Assigned(PlanItem) then
      PlanItem := TSPOutlookItem(Source.Add);
    ReadItemDetails(PlanItem, Appointment);
  end;
end;

procedure TSPOutlookCalendar.ItemDelete(Sender: TObject);
begin
  if Source.Active and Source.RefreshOnDelete then
  begin
    DeleteItems;
    Source.FRequestCalendar := Self;
    try
      Source.RequestAllItems;
    finally
      Source.FRequestCalendar := nil;
    end;
  end;
end;

procedure TSPOutlookCalendar.ReadItemDetails(PlanItem: TSPOutlookItem;
  Item: AppointmentItem);
begin
  PlanItem.FCalendar := Self;
  PlanItem.FStoreID := GetFolder.StoreID;
  PlanItem.FEntryID := Item.EntryID;
  PlanItem.Title := Item.Subject;
  PlanItem.StartTime := Item.Start;
  PlanItem.EndTime := Item.End_;
  PlanItem.AllDayEvent := Item.AllDayEvent;
  PlanItem.IsPrivate := False;
  PlanItem.Resource := ResourceName;
  if Item.BusyStatus = olFree then
    PlanItem.BusyStatus := bsFree
  else
    if Item.BusyStatus = olTentative then
      PlanItem.BusyStatus := bsTentative
    else
      if Item.BusyStatus = olOutOfOffice then
        PlanItem.BusyStatus := bsOutOfOffice;
  PlanItem.AcceptChanges;
end;

procedure TSPOutlookCalendar.ReadItems(StartTime, EndTime: TDateTime);
var
  Folder: MAPIFolder;
  FolderItems: Items;
  CurItem: IDispatch;
  Item: AppointmentItem;
  PlanItem: TSPOutlookItem;
  i: Integer;
  Restriction: string;
  ItemsAdded: Boolean;
begin
  if Source.Active then
  begin
    UnregisterEvents;
    Source.BeginUpdate;
    Folder := GetFolder;
    if not VarIsClear(Folder) then
    begin
      ItemsAdded := False;
      FolderItems := Folder.Items;

      Restriction :=
        '[End] > "' + DateTimeToStr(StartTime) + '" and ' +
        '[Start] < "' + DateTimeToStr(EndTime) + '"';

      FolderItems.Sort('[Start]', EmptyParam);
      FolderItems.IncludeRecurrences := True;
      FolderItems := FolderItems.Restrict(Restriction);
      FolderItems.Sort('[Start]', EmptyParam);

      for i := 1 to FolderItems.Count do
      begin
        try
          CurItem := FolderItems.Item(i);
          if CurItem = nil then
            Break;
        except
          Break;
        end;

        try
          Item := CurItem as AppointmentItem;
        except
          Item := nil;
        end;

        if not VarIsClear(Item) then
        begin
          PlanItem := TSPOutlookItem(Source.Add);
          ReadItemDetails(PlanItem, Item);
          ItemsAdded := True;
        end;
      end;

      if ItemsAdded then
        RemoveDuplicates;
    end;
    Source.EndUpdate;
    RegisterEvents(Folder);
  end;
end;

procedure TSPOutlookCalendar.RegisterEvents(Folder: MAPIFolder);
begin
  UnregisterEvents;
  if Source.Active and Assigned(Folder) then
  begin
    FEvents := TSPOulookItemsEvents.Create(Source);
    FEvents.Connect(Folder.Items);
    FEvents.OnItemAdd := ItemAdd;
    FEvents.OnItemChange := ItemChange;
    FEvents.OnItemRemove := ItemDelete;
  end;
end;

procedure TSPOutlookCalendar.RemoveDuplicates;
var
  Entries: TStringList;
  i: Integer;
  Item: TSPOutlookItem;
begin
  Entries := TStringList.Create;
  try
    for i := 0 to Source.Count - 1 do
    begin
      Item := TSPOutlookItem(Source[i]);
      Entries.AddObject(Item.StoreID + ' ' + Item.EntryID + ' ' +
        DateTimeToStr(Item.StartTime) + ' ' +
        DateTimeToStr(Item.EndTime), Item);
    end;
    Entries.Sort;
    for i := 1 to Entries.Count - 1 do
      if Entries[i] = Entries[i - 1] then
        TSPOutlookItem(Entries.Objects[i]).Free;
  finally
    Entries.Free;
  end;
end;

procedure TSPOutlookCalendar.SetDefaultCalendar(const Value: Boolean);
begin
  if FDefaultCalendar <> Value then
  begin
    if Value then
      FolderPath :=
        TSPOutlookCalendars(Collection).FSource.GetDefaultFolderPath;
    FDefaultCalendar := Value;
  end;
end;

procedure TSPOutlookCalendar.SetFolderPath(const Value: string);
begin
  if FFolderPath <> Value then
  begin
    DeleteItems;
    FFolderPath := Value;
    FDefaultCalendar := False;

    Source.FRequestCalendar := Self;
    try
      Source.RequestAllItems;
    finally
      Source.FRequestCalendar := nil;
    end;
  end;
end;

procedure TSPOutlookCalendar.SetResourceName(const Value: string);
begin
  if FResourceName <> Value then
  begin
    FResourceName := Value;
    UpdateItemResources;
  end;
end;

procedure TSPOutlookCalendar.UnregisterEvents;
begin
  if Assigned(FEvents) then
    FEvents.Free;
  FEvents := nil;
end;

procedure TSPOutlookCalendar.UpdateItemResources;
var
  i: Integer;
  Item: TSPOutlookItem;
begin
  Source.BeginUpdate;
  for i := 0 to Source.Count - 1 do
  begin
    Item := TSPOutlookItem(Source[i]);
    if Item.FCalendar = Self then
      Item.Resource := ResourceName;
  end;
  Source.EndUpdate;
end;

{ TSPOutlookCalendars }

function TSPOutlookCalendars.Add: TSPOutlookCalendar;
begin
  Result := TSPOutlookCalendar(inherited Add);
end;

constructor TSPOutlookCalendars.Create(Source: TSPOutlookSource);
begin
  inherited Create(TSPOutlookCalendar);
  FSource := Source;
end;

function TSPOutlookCalendars.GetItem(Index: Integer): TSPOutlookCalendar;
begin
  Result := TSPOutlookCalendar(inherited GetItem(Index));
end;

function TSPOutlookCalendars.GetOwner: TPersistent;
begin
  Result := FSource;
end;

procedure TSPOutlookCalendars.SetItem(Index: Integer;
  Value: TSPOutlookCalendar);
begin
  inherited SetItem(Index, Value);
end;

{ TSPOutlookItem }

function TSPOutlookItem.GetAppointment: IDispatch;
begin
  Result := nil;
  if (Source is TSPOutlookSource) and (TSPOutlookSource(Source).Active) and
    (FEntryID <> '') and (FStoreID <> '') then
    Result :=
      TSPOutlookSource(Source).FNameSpace.GetItemFromID(FEntryID, FStoreID);
end;

{ TSPOutlookSource }

function TSPOutlookSource.CanModify: Boolean;
begin
  Result := Active and inherited CanModify;
end;

constructor TSPOutlookSource.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  PlanItemClass := TSPOutlookItem;
  FCalendars := TSPOutlookCalendars.Create(Self);
  FRefreshOnDelete := True;
end;

destructor TSPOutlookSource.Destroy;
begin
  Active := False;
  FCalendars.Free;
  inherited Destroy;
end;

procedure TSPOutlookSource.DoRequestItems(StartTime, EndTime: TDateTime);
var
  i: Integer;
begin
  for i := 0 to Calendars.Count - 1 do
    if (FRequestCalendar = nil) or (FRequestCalendar = Calendars[i]) then
      Calendars[i].ReadItems(StartTime, EndTime);
  inherited DoRequestItems(StartTime, EndTime);
end;

function TSPOutlookSource.GetDefaultFolderPath: string;

  function BuildPath(AFolder: MAPIFolder; const Path: string): string;
  var
    ParentFolder: IDispatch;
    ParentMAPIFolder: MAPIFolder;
  begin
    Result := Path;
    if Path <> '' then
      Result := '\' + Path;
    Result := AFolder.Name + Result;
    ParentFolder := AFolder.Parent;
    if Supports(ParentFolder, MAPIFolder, ParentMAPIFolder) then
      Result := BuildPath(ParentMAPIFolder, Result);
  end;

var
  SaveActive: Boolean;
  Folder: MAPIFolder;
begin
  SaveActive := Active;
  Active := True;
  Folder := FNameSpace.GetDefaultFolder(olFolderCalendar);
  Result := BuildPath(Folder, '');
  Active := SaveActive;
end;

function TSPOutlookSource.GetNameSpace: IDispatch;
begin
  Active := True;
  Result := FNameSpace;
end;

procedure TSPOutlookSource.ItemDelete(Item: TSPPlanItem);
var
  Appointment: AppointmentItem;
  PlanItem: TSPOutlookItem;
begin
  if Item is TSPOutlookItem then
  begin
    PlanItem := TSPOutlookItem(Item);
    try
      PlanItem.Calendar.UnregisterEvents;
      try
        Appointment := TSPOutlookItem(Item).Appointment as AppointmentItem;
        if not VarIsClear(Appointment) then
          Appointment.Delete;
      except
      end;
    finally
      PlanItem.Calendar.RegisterEvents(PlanItem.Calendar.GetFolder);
    end;
  end;
  inherited ItemDelete(Item);
end;

procedure TSPOutlookSource.ItemSave(Item: TSPPlanItem);
var
  Appointment: AppointmentItem;
  PlanItem: TSPOutlookItem;
  i: Integer;
  Folder: MAPIFolder;
begin
  if Item is TSPOutlookItem then
  begin
    PlanItem := TSPOutlookItem(Item);
    if not Assigned(PlanItem.Calendar) then
    begin
      for i := 0 to Calendars.Count - 1 do
        if Calendars[i].ResourceName = PlanItem.Resource then
        begin
          PlanItem.FCalendar := Calendars[i];
          Break;
        end;

      if not Assigned(PlanItem.Calendar) and (Calendars.Count = 1) then
        PlanItem.FCalendar := Calendars[0];

      if not Assigned(PlanItem.Calendar) then
        raise Exception.Create(SItemFolderError);
    end;

    PlanItem.Calendar.UnregisterEvents;
    try
      Folder := PlanItem.Calendar.GetFolder;
      if VarIsClear(Folder) then
        raise Exception.Create(SOpenFolderError);

      Appointment := PlanItem.Appointment as AppointmentItem;

      if VarIsClear(Appointment) then
      begin
        Appointment := Folder.Items.Add(olAppointmentItem) as AppointmentItem;
        Appointment.ReminderSet := False;
      end;

      Appointment.Start := PlanItem.StartTime;
      Appointment.End_ := PlanItem.EndTime;
      Appointment.AllDayEvent := PlanItem.AllDayEvent;
      Appointment.Subject := PlanItem.Title;
      if PlanItem.IsPrivate then
        Appointment.Sensitivity := olPrivate;
      case PlanItem.BusyStatus of
        bsFree: Appointment.BusyStatus := olFree;
        bsTentative: Appointment.BusyStatus := olTentative;
        bsOutOfOffice: Appointment.BusyStatus := olOutOfOffice;
      else
        Appointment.BusyStatus := olBusy;
      end;

      Appointment.Save;

      if (PlanItem.EntryID = '') or (PlanItem.StoreID = '') then
      begin
        PlanItem.FStoreID := Folder.StoreID;
        PlanItem.FEntryID := Appointment.EntryID;
      end;
    finally
      PlanItem.Calendar.RegisterEvents(PlanItem.Calendar.GetFolder);
    end;
  end;
  inherited ItemSave(Item);
end;

procedure TSPOutlookSource.SetActive(const Value: Boolean);
var
  i: Integer;
begin
  if FActive <> Value then
  begin
    if Value then
    try
      FApplication := CreateComObject(CLASS_OutlookApplication) as OutlookApplication;
      FNameSpace := FApplication.GetNamespace('MAPI');
      FNameSpace.Logon(FProfile, FPassword, FLogonPrompt, EmptyParam);
      FActive := True;
      RequestAllItems;
    except
      FApplication := nil;
      FNameSpace := nil;
      FActive := False;
      raise;
    end else
    begin
      for i := 0 to FCalendars.Count - 1 do
        FCalendars[i].UnregisterEvents;
      FActive := Value;
      Clear;
      if Assigned(FNameSpace) then
        FNameSpace.Logoff;
      FNameSpace := nil;
      FApplication := nil;
    end;
  end;
end;

procedure TSPOutlookSource.SetCalendars(const Value: TSPOutlookCalendars);
begin
  FCalendars.Assign(Value);
end;

end.
