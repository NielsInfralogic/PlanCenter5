(* SPDBSrc - Database Planner Source                                          *)
(*                                                                            *)
(* Shorter Path Planners                                                      *)
(*                                                                            *)
(* Copyright © 2004, 2007 Shorter Path Software                               *)
(* http://www.shorterpath.com                                                 *)
(******************************************************************************)

unit SPDBSrc;

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
  SysUtils, Classes,
  {$IFDEF CLR}
  ShorterPath.Planners.Vcl.SPPlanners,
  {$ELSE}
  SPPlanners,
  {$ENDIF}
  {$IFDEF CONDITIONALEXPRESSIONS}
  {$IF RTLVersion >= 14.0}
  Variants,
  {$IFEND}
  {$ENDIF}
  DB, DBConsts;

type
  TSPDBSource = class;

  TSPPlannerDataLink = class(TDataLink)
  private
    FSource: TSPDBSource;
    FScrolling: Boolean;
  protected
    procedure ActiveChanged; override;
    procedure DataSetChanged; override;
    procedure DataSetScrolled(Distance: Integer); override;
  public
    constructor Create(ASource: TSPDBSource);
    property Source: TSPDBSource read FSource;
  end;

  TSPFieldMappings = class(TPersistent)
  private
    FSource: TSPDBSource;
    FAllDayEventField: string;
    FBusyStatusField: string;
    FColorField: string;
    FEndTimeField: string;
    FIsPrivateField: string;
    FResourceField: string;
    FKeyField: string;
    FStartTimeField: string;
    FTitleField: string;
    procedure Changed;
    procedure SetAllDayEventField(const Value: string);
    procedure SetBusyStatusField(const Value: string);
    procedure SetColorField(const Value: string);
    procedure SetEndTimeField(const Value: string);
    procedure SetIsPrivateField(const Value: string);
    procedure SetKeyField(const Value: string);
    procedure SetResourceField(const Value: string);
    procedure SetStartTimeField(const Value: string);
    procedure SetTitleField(const Value: string);
  public
    constructor Create(ASource: TSPDBSource);
    procedure Assign(Source: TPersistent); override;
    property Source: TSPDBSource read FSource;
  published
    property AllDayEventField: string read FAllDayEventField write SetAllDayEventField;
    property BusyStatusField: string read FBusyStatusField write SetBusyStatusField;
    property ColorField: string read FColorField write SetColorField;
    property EndTimeField: string read FEndTimeField write SetEndTimeField;
    property IsPrivateField: string read FIsPrivateField write SetIsPrivateField;
    property KeyField: string read FKeyField write SetKeyField;
    property ResourceField: string read FResourceField write SetResourceField;
    property StartTimeField: string read FStartTimeField write SetStartTimeField;
    property TitleField: string read FTitleField write SetTitleField;
  end;

  TSPResourceFields = class(TPersistent)
  private
    FSource: TSPDBSource;
    FIDField: string;
    FNameField: string;
    procedure Changed;
    procedure SetIDField(const Value: string);
    procedure SetNameField(const Value: string);
  public
    constructor Create(ASource: TSPDBSource);
    procedure Assign(Source: TPersistent); override;
    property Source: TSPDBSource read FSource;
  published
    property IDField: string read FIDField write SetIDField;
    property NameField: string read FNameField write SetNameField;
  end;

  TSPDBPlanItem = class(TSPPlanItem)
  private
    FKey: Variant;
  public
    property Key: Variant read FKey;
    function Locate: Boolean;
  end;

  TSPDBSource = class(TSPCustomSource)
  private
    FDataLink: TSPPlannerDataLink;
    FResourcesLink: TSPPlannerDataLink;
    FFieldMappings: TSPFieldMappings;
    FResourceFields: TSPResourceFields;
    FLoadedActive: Boolean;
    FActive: Boolean;
    FAllDayEventField: TField;
    FBusyStatusField: TField;
    FColorField: TField;
    FEndTimeField: TField;
    FIsPrivateField: TField;
    FResourceField: TField;
    FKeyField: TField;
    FStartTimeField: TField;
    FTitleField: TField;
    FResourceIDField: TField;
    FResourceNameField: TField;
    FUpdating: Boolean;
    function GetDataSource: TDataSource;
    procedure SetDataSource(const Value: TDataSource);
    procedure SetFieldMappings(const Value: TSPFieldMappings);
    procedure ReadItems;
    procedure UpdateFields;
    procedure SetActive(const Value: Boolean);
    procedure DataChanged;
    function GetResourcesSource: TDataSource;
    procedure SetResourcesSource(const Value: TDataSource);
    procedure SetResourceFields(const Value: TSPResourceFields);
  protected
    procedure ItemDelete(Item: TSPPlanItem); override;
    procedure ItemSave(Item: TSPPlanItem); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    property DataLink: TSPPlannerDataLink read FDataLink;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CanModify: Boolean; override;
    function LocateItem(Item: TSPPlanItem): Boolean;
  published
    property Active: Boolean read FActive write SetActive;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property FieldMappings: TSPFieldMappings read FFieldMappings write SetFieldMappings;
    property ResourcesSource: TDataSource read GetResourcesSource write SetResourcesSource;
    property ResourceFields: TSPResourceFields read FResourceFields write SetResourceFields;
    property Images;
  end;

  ESPDBError = class(Exception)
  end;

implementation

uses
  Graphics;

resourcestring
  SEmptyMapping = 'Property ''%s'' must be mapped to a field';
  SItemNotFound = 'The requested item could not be located';
  SNoKeyField = 'A key field name is required to modify data';
  SResourceMapping = 'Error in resources mapping';
  SMissingResource = 'Item ''%s'' is linked to the resource ID ''%s'', ' +
    'but the resource cannot be found';

{ TSPPlannerDataLink }

procedure TSPPlannerDataLink.ActiveChanged;
begin
  inherited ActiveChanged;
  if Assigned(FSource) and (not Active) then
    FSource.Active := False;
end;

constructor TSPPlannerDataLink.Create(ASource: TSPDBSource);
begin
  inherited Create;
  FSource := ASource;
end;

procedure TSPPlannerDataLink.DataSetChanged;
begin
  inherited DataSetChanged;
  if (not FScrolling) and Assigned(FSource) then
    FSource.DataChanged;
end;

procedure TSPPlannerDataLink.DataSetScrolled(Distance: Integer);
begin
  FScrolling := True;
  try
    inherited DataSetScrolled(Distance);
  finally
    FScrolling := False;
  end;
end;

{ TSPDBSource }

function TSPDBSource.CanModify: Boolean;
begin
  Result := inherited CanModify and FDataLink.Active and
    FDataLink.DataSet.CanModify and Assigned(FKeyField);
end;

constructor TSPDBSource.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  PlanItemClass := TSPDBPlanItem;
  FDataLink := TSPPlannerDataLink.Create(Self);
  FResourcesLink := TSPPlannerDataLink.Create(Self);
  FFieldMappings := TSPFieldMappings.Create(Self);
  FResourceFields := TSPResourceFields.Create(Self);
end;

procedure TSPDBSource.DataChanged;
begin
  if Active and not FUpdating then
    ReadItems;
end;

destructor TSPDBSource.Destroy;
begin
  Active := False;
  FResourcesLink.Free;
  FResourcesLink := nil;
  FDataLink.Free;
  FDataLink := nil;
  FFieldMappings.Free;
  FFieldMappings := nil;
  FResourceFields.Free;
  FResourceFields := nil;
  inherited;
end;

function TSPDBSource.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TSPDBSource.GetResourcesSource: TDataSource;
begin
  Result := FResourcesLink.DataSource;
end;

procedure TSPDBSource.ItemDelete(Item: TSPPlanItem);
var
  DBItem: TSPDBPlanItem;
begin
  if Item is TSPDBPlanItem then
  begin
    if not Assigned(FKeyField) then
      raise ESPDBError.Create(SNoKeyField);

    DBItem := TSPDBPlanItem(Item);
    if not (VarIsEmpty(DBItem.FKey) or VarIsNull(DBItem.FKey)) then
    begin
      FUpdating := True;
      try
        if not FDataLink.DataSet.Locate(
          FKeyField.FieldName, DBItem.FKey, []) then
          raise ESPDBError.Create(SItemNotFound);
        FDataLink.DataSet.Delete;
      finally
        FUpdating := False;
      end;
    end;
  end;
  inherited ItemDelete(Item);
end;

procedure TSPDBSource.ItemSave(Item: TSPPlanItem);
var
  DBItem: TSPDBPlanItem;
begin
  if Item is TSPDBPlanItem then
  begin
    if not Assigned(FKeyField) then
      raise ESPDBError.Create(SNoKeyField);

    if Assigned(FResourcesLink.DataSet) then
      if not (Assigned(FResourceIDField) and Assigned(FResourceNameField)) then
        raise ESPDBError.Create(SResourceMapping);

    DBItem := TSPDBPlanItem(Item);
    FUpdating := True;
    try
      if VarIsEmpty(DBItem.FKey) or VarIsNull(DBItem.FKey) then
        FDataLink.DataSet.Append
      else
      begin
        if not FDataLink.DataSet.Locate(FKeyField.FieldName, DBItem.FKey, []) then
          raise ESPDBError.Create(SItemNotFound);
        FDataLink.DataSet.Edit;
      end;
      try
        FStartTimeField.AsDateTime := DBItem.StartTime;
        FEndTimeField.AsDateTime := DBItem.EndTime;
        FTitleField.AsString := DBItem.Title;

        if Assigned(FBusyStatusField) then
          FBusyStatusField.AsInteger := Ord(DBItem.BusyStatus);
        if Assigned(FColorField) then
          FColorField.AsInteger := Integer(DBItem.Color);
        if Assigned(FAllDayEventField) then
        begin
          if (FAllDayEventField is TBooleanField) or
            (FAllDayEventField is TStringField) then
            FAllDayEventField.AsBoolean := DBItem.AllDayEvent
          else
            FAllDayEventField.AsInteger := Ord(DBItem.AllDayEvent);
        end;
        if Assigned(FIsPrivateField) then
        begin
          if (FIsPrivateField is TBooleanField) or
            (FIsPrivateField is TStringField) then
            FIsPrivateField.AsBoolean := DBItem.IsPrivate
          else
            FIsPrivateField.AsInteger := Ord(DBItem.IsPrivate);
        end;
        if Assigned(FResourceField) then
        begin
          if Assigned(FResourceNameField) then
          begin
            if FResourcesLink.DataSet.Locate(
              FResourceNameField.FieldName, DBItem.Resource, []) then
              FResourceField.Value :=
                FResourcesLink.DataSet.FieldByName(FResourceIDField.FieldName).Value
            else
              if DBItem.Resource = '' then
                FResourceField.Clear
              else
                raise ESPDBError.Create(SResourceMapping);
          end else
            FResourceField.AsString := DBItem.Resource;
        end;

        FDataLink.DataSet.Post;
        DBItem.FKey := FKeyField.Value;
      except
        FDataLink.DataSet.Cancel;
        raise;
      end;
    finally
      FUpdating := False;
    end;
  end;
  inherited ItemSave(Item);
end;

procedure TSPDBSource.Loaded;
begin
  inherited Loaded;
  if FLoadedActive then
    Active := True;
end;

function TSPDBSource.LocateItem(Item: TSPPlanItem): Boolean;
var
  DBItem: TSPDBPlanItem;
begin
  Result := False;
  if Item is TSPDBPlanItem and Assigned(FKeyField) then
  begin
    DBItem := TSPDBPlanItem(Item);
    if not (VarIsEmpty(DBItem.FKey) or VarIsNull(DBItem.FKey)) then
      Result := FDataLink.DataSet.Locate(FKeyField.FieldName, DBItem.FKey, []);
  end;
end;

procedure TSPDBSource.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and Assigned(FDataLink) and
    (AComponent = DataSource) then
    DataSource := nil;
  if (Operation = opRemove) and Assigned(FResourcesLink) and
    (AComponent = ResourcesSource) then
    ResourcesSource := nil;
end;

procedure TSPDBSource.ReadItems;

  procedure CheckField(Field: TField; const PropName: string);
  begin
    if not Assigned(Field) then
      raise ESPDBError.Create(Format(SEmptyMapping, [PropName]));
  end;

var
  SaveActive: Integer;
  NewItem: TSPDBPlanItem;
begin
  if FDataLink.Active and (not FUpdating) and
    ((not Assigned(FResourcesLink.DataSet)) or FResourcesLink.Active) then
  begin
    CheckField(FStartTimeField, 'StartTime');
    CheckField(FEndTimeField, 'EndTime');
    CheckField(FTitleField, 'Title');

    FUpdating := True;
    FDataLink.BufferCount := FDataLink.RecordCount;
    BeginUpdate;
    Clear;
    SaveActive := FDataLink.ActiveRecord;
    try
      FDataLink.DataSet.First;
      while not FDataLink.DataSet.Eof do
      begin
        NewItem := TSPDBPlanItem(Add);
        try
          NewItem.StartTime := FStartTimeField.AsDateTime;
          NewItem.EndTime := FEndTimeField.AsDateTime;
          NewItem.Title := FTitleField.AsString;

          if Assigned(FBusyStatusField) then
            NewItem.BusyStatus := TSPBusyStatus(FBusyStatusField.AsInteger);
          if Assigned(FColorField) then
            NewItem.Color := TColor(FColorField.AsInteger);
          if Assigned(FAllDayEventField) then
          begin
            if (FAllDayEventField is TBooleanField) or
              (FAllDayEventField is TStringField) then
              NewItem.AllDayEvent := FAllDayEventField.AsBoolean
            else
              NewItem.AllDayEvent := FAllDayEventField.AsInteger <> 0;
          end;
          if Assigned(FIsPrivateField) then
          begin
            if (FIsPrivateField is TBooleanField) or
              (FIsPrivateField is TStringField) then
              NewItem.IsPrivate := FIsPrivateField.AsBoolean
            else
              NewItem.IsPrivate := FIsPrivateField.AsInteger <> 0;
          end;
          if Assigned(FResourceField) then
          begin
            if Assigned(FResourcesLink.DataSet) then
            begin
              if not (Assigned(FResourceIDField) and Assigned(FResourceNameField)) then
                raise ESPDBError.Create(SResourceMapping);

              if FResourcesLink.DataSet.Locate(
                FResourceIDField.FieldName, FResourceField.Value, []) then
                NewItem.Resource := FResourceNameField.AsString
              else
                raise ESPDBError.Create(Format(
                  SMissingResource, [NewItem.Title, FResourceField.AsString]));
            end else
              NewItem.Resource := FResourceField.AsString;
          end;

          if Assigned(FKeyField) then
            NewItem.FKey := FKeyField.Value;

          NewItem.AcceptChanges;
        except
          NewItem.Free;
          raise;
        end;
        FDataLink.DataSet.Next;
      end;
    finally
      EndUpdate;
      FDataLink.ActiveRecord := SaveActive;
      FUpdating := False;
    end;
  end;
end;

procedure TSPDBSource.SetActive(const Value: Boolean);
begin
  if FActive <> Value then
  begin
    if Value then
    begin
      if csLoading in ComponentState then
        FLoadedActive := True
      else
      begin
        if Assigned(FDataLink.DataSet) then
          FDataLink.DataSet.Active := True;
        if Assigned(FResourcesLink.DataSet) then
          FResourcesLink.DataSet.Active := True;
        UpdateFields;
        FActive := True;
        ReadItems;
      end;
    end else
    begin
      FActive := Value;
      Clear;
    end;
  end;
end;

procedure TSPDBSource.SetDataSource(const Value: TDataSource);
begin
  if Value <> FDataLink.DataSource then
  begin
    {$IFNDEF VCL4}
    {$IFNDEF VCL5}
    if Assigned(Value) then
      if Assigned(Value.DataSet) then
        if Value.DataSet.IsUnidirectional then
          DatabaseError(SDataSetUnidirectional);
    {$ENDIF}
    {$ENDIF}
    FDataLink.DataSource := Value;
    if Value <> nil then Value.FreeNotification(Self);
  end;
end;

procedure TSPDBSource.SetFieldMappings(const Value: TSPFieldMappings);
begin
  FFieldMappings.Assign(Value);
end;

procedure TSPDBSource.SetResourceFields(const Value: TSPResourceFields);
begin
  FResourceFields.Assign(Value);
end;

procedure TSPDBSource.SetResourcesSource(const Value: TDataSource);
begin
  if Value <> FResourcesLink.DataSource then
  begin
    {$IFNDEF VCL4}
    {$IFNDEF VCL5}
    if Assigned(Value) then
      if Assigned(Value.DataSet) then
        if Value.DataSet.IsUnidirectional then
          DatabaseError(SDataSetUnidirectional);
    {$ENDIF}
    {$ENDIF}
    FResourcesLink.DataSource := Value;
    if Value <> nil then Value.FreeNotification(Self);
  end;
end;

procedure TSPDBSource.UpdateFields;

  procedure SetDataField(var Field: TField; const FieldName: string);
  begin
    if FieldName <> '' then
      Field := DataLink.DataSet.FieldByName(FieldName);
  end;

  procedure SetResourceField(var Field: TField; const FieldName: string);
  begin
    if FieldName <> '' then
      Field := FResourcesLink.DataSet.FieldByName(FieldName);
  end;

begin
  FAllDayEventField := nil;
  FBusyStatusField := nil;
  FColorField := nil;
  FEndTimeField := nil;
  FIsPrivateField := nil;
  FResourceField := nil;
  FKeyField := nil;
  FStartTimeField := nil;
  FTitleField := nil;

  if Assigned(FDataLink.DataSet) and (FDataLink.Active) then
  begin
    SetDataField(FAllDayEventField, FFieldMappings.FAllDayEventField);
    SetDataField(FBusyStatusField, FFieldMappings.FBusyStatusField);
    SetDataField(FColorField, FFieldMappings.FColorField);
    SetDataField(FEndTimeField, FFieldMappings.FEndTimeField);
    SetDataField(FIsPrivateField, FFieldMappings.FIsPrivateField);
    SetDataField(FResourceField, FFieldMappings.FResourceField);
    SetDataField(FKeyField, FFieldMappings.FKeyField);
    SetDataField(FStartTimeField, FFieldMappings.FStartTimeField);
    SetDataField(FTitleField, FFieldMappings.FTitleField);
  end;

  FResourceIDField := nil;
  FResourceNameField := nil;

  if Assigned(FResourcesLink.DataSet) and (FResourcesLink.Active) then
  begin
    SetResourceField(FResourceIDField, FResourceFields.FIDField);
    SetResourceField(FResourceNameField, FResourceFields.FNameField);
  end;
end;

{ TSPFieldMappings }

procedure TSPFieldMappings.Assign(Source: TPersistent);
begin
  if Source is TSPFieldMappings then
  begin
    FAllDayEventField := TSPFieldMappings(Source).FAllDayEventField;
    FBusyStatusField := TSPFieldMappings(Source).FBusyStatusField;
    FColorField := TSPFieldMappings(Source).FColorField;
    FEndTimeField := TSPFieldMappings(Source).FEndTimeField;
    FIsPrivateField := TSPFieldMappings(Source).FIsPrivateField;
    FResourceField := TSPFieldMappings(Source).FResourceField;
    FKeyField := TSPFieldMappings(Source).FKeyField;
    FStartTimeField := TSPFieldMappings(Source).FStartTimeField;
    FTitleField := TSPFieldMappings(Source).FTitleField;
    Changed;
  end else
    inherited Assign(Source);
end;

procedure TSPFieldMappings.Changed;
begin
  if Assigned(FSource) then
    FSource.Active := False;
end;

constructor TSPFieldMappings.Create(ASource: TSPDBSource);
begin
  inherited Create;
  FSource := ASource;
end;

procedure TSPFieldMappings.SetAllDayEventField(const Value: string);
begin
  if FAllDayEventField <> Value then
  begin
    Changed;
    FAllDayEventField := Value;
  end;
end;

procedure TSPFieldMappings.SetBusyStatusField(const Value: string);
begin
  if FBusyStatusField <> Value then
  begin
    Changed;
    FBusyStatusField := Value;
  end;
end;

procedure TSPFieldMappings.SetColorField(const Value: string);
begin
  if FColorField <> Value then
  begin
    Changed;
    FColorField := Value;
  end;
end;

procedure TSPFieldMappings.SetEndTimeField(const Value: string);
begin
  if FEndTimeField <> Value then
  begin
    Changed;
    FEndTimeField := Value;
  end;
end;

procedure TSPFieldMappings.SetIsPrivateField(const Value: string);
begin
  if FIsPrivateField <> Value then
  begin
    Changed;
    FIsPrivateField := Value;
  end;
end;

procedure TSPFieldMappings.SetKeyField(const Value: string);
begin
  if FKeyField <> Value then
  begin
    Changed;
    FKeyField := Value;
  end;
end;

procedure TSPFieldMappings.SetResourceField(const Value: string);
begin
  if FResourceField <> Value then
  begin
    Changed;
    FResourceField := Value;
  end;
end;

procedure TSPFieldMappings.SetStartTimeField(const Value: string);
begin
  if FStartTimeField <> Value then
  begin
    Changed;
    FStartTimeField := Value;
  end;
end;

procedure TSPFieldMappings.SetTitleField(const Value: string);
begin
  if FTitleField <> Value then
  begin
    Changed;
    FTitleField := Value;
  end;
end;

{ TSPDataResources }

procedure TSPResourceFields.Changed;
begin
  if Assigned(FSource) then
    FSource.Active := False;
end;

constructor TSPResourceFields.Create(ASource: TSPDBSource);
begin
  inherited Create;
  FSource := ASource;
end;

procedure TSPResourceFields.SetNameField(const Value: string);
begin
  if FNameField <> Value then
  begin
    FNameField := Value;
    Changed;
  end;
end;

procedure TSPResourceFields.SetIDField(const Value: string);
begin
  if FIDField <> Value then
  begin
    FIDField := Value;
    Changed;
  end;
end;

procedure TSPResourceFields.Assign(Source: TPersistent);
begin
  if Source is TSPResourceFields then
  begin
    FIDField := TSPResourceFields(Source).FIDField;
    FNameField := TSPResourceFields(Source).FNameField;
  end else
    inherited Assign(Source);
end;

{ TSPDBPlanItem }

function TSPDBPlanItem.Locate: Boolean;
begin
  Result := (Source as TSPDBSource).LocateItem(Self);
end;

end.
