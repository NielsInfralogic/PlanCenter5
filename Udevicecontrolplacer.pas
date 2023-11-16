unit Udevicecontrolplacer;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, XPMan,UDeviceControlframe, FMTBcd, DB, SqlExpr,
  ImgList, ExtCtrls, StrUtils, System.ImageList, UITypes;
type
  TFrameDeviceplacer = class(TFrame)
    ComboBoxlocationManage: TComboBox;
    ImageList1: TImageList;
    ImageList2: TImageList;
    Timerdeviceupdate: TTimer;
    ImageList3: TImageList;
    procedure TimerdeviceupdateTimer(Sender: TObject);
    procedure ComboBoxlocationManageChange(Sender: TObject);
  private
    { Private declarations }
  public
    Ndevicecontrolframes : Longint;
    devicecontrolframes : Array of TFrameDevicecontrol;
    Lastupdate : Tdatetime;
    DEVPressvisibilyIN : String;
    Function MakeFramDevPressGrpIN() : Integer;
    procedure updatedevices;
    Procedure Getdevicestate(deviceid : Longint;
                             Var devCurrentstate : Longint;
                             Var devenabled      : Longint);
    Procedure Enableadevice(deviceid : Longint);
    Procedure loaddevices;
    Function addpress(deviceid : Longint):string;
    Procedure Removepress(pressid : Longint;
                          deviceid : Longint);
    procedure AfterConstruction; override;
  end;
implementation
{$R *.dfm}
Uses
  utypes,Udata,umain, Usettings,Ulistselect, UListselection,DateUtils,
  Ulogin, UUtils, UImages;
procedure TFrameDeviceplacer.AfterConstruction;
var
  i : Integer;
begin
  inherited;

 { if Screen.PixelsPerInch <> 96 then //as I’m designing at 96 DPI
  begin
      for i := 0 to -1 + ComponentCount do
        if Components[i] is TImageList then
          FormImage.ResizeImageListImagesforHighDPI(TImageList(Components[i]));

  end;  }
end;

Procedure TFrameDeviceplacer.LoadDevices;
Var
  i,j   : Integer;
  s   : String;
  presses  : Integer;
  UseSpecificDevices : Boolean;
  SpecificDevicesList : Array of Integer;
begin
try
  UseSpecificDevices := false;
  //SJO 261015
  //Fjern alle device componenter i .
  if FormMain.FrameDeviceplacer1 is TWinControl then
  begin
    for i := (FormMain.FrameDeviceplacer1.ComponentCount - 1) downto 0 do
    Begin
      If FormMain.FrameDeviceplacer1.Components[i] is TFrameDevicecontrol then
        FormMain.FrameDeviceplacer1.Components[i].Free
    End;
  End;
  DataM1.ConnectToServerDeviceState();
  presses := MakeFramDevPressGrpIN();
  // Note - filter on top (Press (group) or location) is set in FormMain.ActivateData
  ComboBoxlocationManage.Align := alTop;
  ComboBoxlocationManage.Realign;
  SetLength(SpecificDevicesList, 0);
  j := 0;
  if (Prefs.ShowSpecificDevices) then
  begin
    UseSpecificDevices := true;
     for i := 0 to Length(Prefs.SpecificDevices)-1 do
     begin
       if (Prefs.SpecificDevices[i].Enabled) then
       begin
          SetLength(SpecificDevicesList, j+1);
          SpecificDevicesList[j] := tNames1.DeviceNameToID(Prefs.SpecificDevices[i].Name);
          Inc(j);
       end;
     end;
     if (Length(SpecificDevicesList) = 0) then
       UseSpecificDevices := false;
  end;


  if (DataM1.CheckDBDeviceState() = false) then
  begin
    DataM1.DisConnectFromServerDeviceState();
    exit;
  end;

  if (UseSpecificDevices = false) then
  begin
    try
      DataM1.SQLQuerydevcontrol.SQL.Clear;
      if (Prefs.DeviceControlUsePressDevices) and (Pressdevpossible) then
      begin
        DataM1.SQLQuerydevcontrol.SQL.Add('select COUNT(deviceid) from PressDevices ');
        DataM1.SQLQuerydevcontrol.SQL.Add('where pressid in ' + DEVPressvisibilyIN);
      end
      else     // fall back up location filter
      begin
        DataM1.SQLQuerydevcontrol.SQL.Add('SELECT COUNT(DeviceID) FROM DeviceConfigurations ');
        DataM1.SQLQuerydevcontrol.SQL.Add('WHERE LocationID = ' + IntToStr(tnames1.locationnametoid(ComboBoxlocationManage.Text)));
      end;
    //    IF Prefs.debug then datam1.SQLQuerydevcontrol.sql.SaveToFile(ExcludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'DeviceConfigurationsCount.sql');
      DataM1.SQLQuerydevcontrol.Open;
      if not DataM1.SQLQuerydevcontrol.Eof then
      begin
        Ndevicecontrolframes := DataM1.SQLQuerydevcontrol.Fields[0].AsInteger;
        Setlength(devicecontrolframes,Ndevicecontrolframes+2);
      End;
      DataM1.SQLQuerydevcontrol.close;
    except

    end;

  end
  else
  begin
     Ndevicecontrolframes :=  Length(SpecificDevicesList);
     Setlength(devicecontrolframes,Ndevicecontrolframes+2);
  end;
  try
    DataM1.SQLQuerydevcontrol.SQL.Clear;
    if (UseSpecificDevices) then
    begin
        DataM1.SQLQuerydevcontrol.SQL.Add('select DeviceID,Devicename,devicetype,Enabled,CurrentState,PanoramaOrientation from DeviceConfigurations ');
        DataM1.SQLQuerydevcontrol.SQL.Add('where DeviceID IN (' + TUtils.IntArrayToStringList( SpecificDevicesList) + ')');
        DataM1.SQLQuerydevcontrol.SQL.Add('order by DeviceName');
    end
    else
    begin
      if (Prefs.DeviceControlUsePressDevices) and (Pressdevpossible) then
      begin
        DataM1.SQLQuerydevcontrol.SQL.Add('select distinct DC.DeviceID,DC.Devicename,DC.devicetype,DC.Enabled,DC.CurrentState,PD.deviceid,DC.PanoramaOrientation from DeviceConfigurations DC , pressdevices PD');
        DataM1.SQLQuerydevcontrol.SQL.Add('Where PD.deviceid = DC.deviceid and PD.pressid in ' + DEVPressvisibilyIN  );
        DataM1.SQLQuerydevcontrol.SQL.Add('order by DeviceName');
      end
      else
      begin
        DataM1.SQLQuerydevcontrol.SQL.Add('select DeviceID,Devicename,devicetype,Enabled,CurrentState,PanoramaOrientation from DeviceConfigurations ');
        DataM1.SQLQuerydevcontrol.SQL.Add('where locationid = ' + IntToStr(tnames1.locationnametoid(ComboBoxlocationManage.Text)));
        DataM1.SQLQuerydevcontrol.SQL.Add('order by DeviceName');
      end;
    end;
    Self.Visible := false;
    if Prefs.debug then datam1.SQLQuerydevcontrol.SQL.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'DeviceConfigurations.sql');
    DataM1.SQLQuerydevcontrol.Open;
    // Moved from top NAN
    //SJO 261015 Dette behøves ikke længere, men lader den lidt stå.
    //FormMain.GroupBoxdevicelist.Caption := IntToStr(Ndevicecontrolframes) + ' - ' + IntToStr(Length(devicecontrolframes)) ;
  {  if Ndevicecontrolframes > 0 then
    begin
      For i := 0 to (Ndevicecontrolframes - 1) do
      begin
        IF devicecontrolframes[i] <> nil then
        begin
          devicecontrolframes[i].Free;
        end;
      end;
    end;}
    i := 0;
    while not DataM1.SQLQuerydevcontrol.eof do
    begin
      //devimnum := DataM1.SQLQuerydevcontrol.Fields[2].AsInteger * 2;
      devicecontrolframes[i] := TFrameDevicecontrol.Create(Self);
      devicecontrolframes[i].Name := 'devicecontrol'+IntToStr(i);
      devicecontrolframes[i].ListBox1.Visible := true;
      //(not foxrmsettings.CheckBoxpressindevcontrol.checked) And (Pressdevpossible)
      s:=DataM1.SQLQuerydevcontrol.Fields[1].AsString;
      devicecontrolframes[i].LabelDevame.Caption := s;
      devicecontrolframes[i].deviceid     := DataM1.SQLQuerydevcontrol.Fields[0].AsInteger;
      devicecontrolframes[i].Currentstate := DataM1.SQLQuerydevcontrol.Fields[4].AsInteger;
      devicecontrolframes[i].DevEnabled   := DataM1.SQLQuerydevcontrol.Fields[3].AsInteger;
      devicecontrolframes[i].Devicetype   := DataM1.SQLQuerydevcontrol.Fields[2].AsInteger;
      s := UpperCase(s);
      if AnsiContainsStr(s,'DOTMATE') then
        devicecontrolframes[i].Devicetype := 2;
      if AnsiContainsStr(s,'KATANA') then
        devicecontrolframes[i].Devicetype := 5;
      if devicecontrolframes[i].Devicetype = 18 then // KODAK XPO
        devicecontrolframes[i].Devicetype := 8;
      if devicecontrolframes[i].Devicetype = 19 then // Polaris
        devicecontrolframes[i].Devicetype := 12;
      if devicecontrolframes[i].Devicetype = 20 then // Basys
        devicecontrolframes[i].Devicetype := 7;
      devicecontrolframes[i].JobsInQueue  := DataM1.SQLQuerydevcontrol.Fieldbyname('PanoramaOrientation').AsInteger;
      //if devicecontrolframes[i].DevEnabled < 1 then
      //  inc(devimnum);
      devicecontrolframes[i].Setstate;
      devicecontrolframes[i].Parent := Self;
      Inc(I);
      DataM1.SQLQuerydevcontrol.Next;
    end;
    DataM1.SQLQuerydevcontrol.Close;
  except

  end;
  Ndevicecontrolframes := i;
  if  (Prefs.DeviceControlUsePressDevices) and (Pressdevpossible) then
  begin
    For i := 0 to Ndevicecontrolframes-1 do
    begin
      if (devicecontrolframes[i].ListBox1.Visible)  then
      begin
        // Fetch press name for item headers
        try
          DataM1.SQLQuerydevcontrol.SQL.Clear;
          DataM1.SQLQuerydevcontrol.SQL.Add('select pd.pressid,pn.PressName from PressDevices pd, PressNames pn ');
          DataM1.SQLQuerydevcontrol.SQL.Add('where pd.deviceid = ' + inttostr(devicecontrolframes[i].deviceid));
          DataM1.SQLQuerydevcontrol.SQL.Add('And pd.pressid = pn.pressid');
          DataM1.SQLQuerydevcontrol.SQL.Add('order by pn.PressName');
          DataM1.SQLQuerydevcontrol.Open;
          While not DataM1.SQLQuerydevcontrol.Eof do
          begin
            devicecontrolframes[i].ListBox1.Items.Add(DataM1.SQLQuerydevcontrol.Fields[1].AsString);
            DataM1.SQLQuerydevcontrol.Next;
          end;
          DataM1.SQLQuerydevcontrol.Close;
        except

        end;
      end;
    End;
  End;

  For i := 0 to Ndevicecontrolframes-1 do
  begin
    IF devicecontrolframes[i].ListBox1.Visible then
    begin
      IF devicecontrolframes[i].ListBox1.Items.Count = 0 then
        devicecontrolframes[i].ListBox1.Items.Add('No presses');
      devicecontrolframes[i].ListBox1.Height := (devicecontrolframes[i].ListBox1.ItemHeight) * (devicecontrolframes[i].ListBox1.Items.Count)+4;
      devicecontrolframes[i].Panel3.AutoSize := true;
    End;
    devicecontrolframes[i].Top := Ndevicecontrolframes+10 * 240;
    devicecontrolframes[i].Align := alTop;
    devicecontrolframes[i].Realign;
  End;
  Lastupdate := now;
  visible := true;
   except
  end;
end;

Function TFrameDeviceplacer.AddPress(DeviceID : Longint):string;
Begin
  result := '';
  try
    FormListselection.caption := 'Add a press to the device ';
    DataM1.SQLQuerydevcontrol.SQL.Clear;
    if (Prefs.DeviceControlUsePressDevices) and (Pressdevpossible) then
    begin
      DataM1.SQLQuerydevcontrol.SQL.Add('select pressid from  PressDevices pn');
      DataM1.SQLQuerydevcontrol.SQL.Add('where deviceid = ' + IntToStr(deviceid)+')' );
    end
    else
    Begin
      DataM1.SQLQuerydevcontrol.SQL.Add('select pressid from  PressNames');
      DataM1.SQLQuerydevcontrol.SQL.Add('where deviceid = ' + IntToStr(deviceid)+')' );
      DataM1.SQLQuerydevcontrol.SQL.Add('and LocationID = ' + IntToStr(tnames1.locationnametoid(ComboBoxlocationManage.Text) ));
      DataM1.SQLQuerydevcontrol.SQL.Add('order by pressid');
    End;
    DataM1.SQLQuerydevcontrol.Open;
    FormListselection.ListBox1.items.Clear;
    While not DataM1.SQLQuerydevcontrol.eof do
    begin
      FormListselection.ListBox1.Items.Add(tnames1.pressnameIDtoname( DataM1.SQLQuerydevcontrol.Fields[0].AsInteger));
      DataM1.SQLQuerydevcontrol.Next;
    end;
    DataM1.SQLQuerydevcontrol.Close;

    IF FormListselection.ListBox1.Items.Count > 0 then
    begin
      FormListselection.ListBox1.ItemIndex := 0;
      if (Pressdevpossible) then
      begin
        if FormListselection.ShowModal = mrok then
        begin
          DataM1.SQLQuerydevcontrol.SQL.Clear;
          DataM1.SQLQuerydevcontrol.SQL.Add('INSERT PressDevices (PressID,DeviceID)');
          DataM1.SQLQuerydevcontrol.SQL.Add('VALUES (' + IntToStr(tnames1.pressnametoid(FormListselection.ListBox1.items[FormListselection.ListBox1.itemindex]) ));
          DataM1.SQLQuerydevcontrol.SQL.Add(',' + IntToStr(deviceid)+')');
          DataM1.SQLQuerydevcontrol.ExecSQL;
          result := FormListselection.ListBox1.items[FormListselection.ListBox1.ItemIndex];
        end;
      end;
    end
    Else
    begin
      MessageDlg('There are no presses to add', mtInformation, [mbOk], 0);
    end;
  except
  end;
end;
Procedure TFrameDeviceplacer.RemovePress(pressid : Longint;
                                         deviceid : Longint);
Begin
  if (Pressdevpossible) then
  begin
    if MessageDlg('Remove ' + tnames1.pressnameIDtoname(pressid) + ' from ' + tnames1.deviceIDtoname(deviceid) + ' ? ',mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      try

        DataM1.SQLQuerydevcontrol.SQL.Clear;
        DataM1.SQLQuerydevcontrol.SQL.Add('DELETE PressDevices WHERE PressID = ' + IntToStr(pressid));
        DataM1.SQLQuerydevcontrol.SQL.Add('AND deviceID = ' + IntToStr(deviceid));
        DataM1.SQLQuerydevcontrol.ExecSql;
      except
      end;

    end;
  end;
End;

Procedure TFrameDeviceplacer.Enableadevice(deviceid : Longint);
Begin
  try
    DataM1.SQLQuerydevcontrol.SQL.Clear;
    DataM1.SQLQuerydevcontrol.SQL.Add('DECLARE @enabled int');
    DataM1.SQLQuerydevcontrol.SQL.Add('SET @enabled = (SELECT Enabled FROM DeviceConfigurations');
    DataM1.SQLQuerydevcontrol.SQL.Add('WHERE DeviceID = ' + IntToStr(deviceid)+' )');
    DataM1.SQLQuerydevcontrol.SQL.Add('SET @enabled = 1- @enabled');
    DataM1.SQLQuerydevcontrol.SQL.Add('UPDATE DeviceConfigurations');
    DataM1.SQLQuerydevcontrol.SQL.Add('SET enabled = @enabled');
    DataM1.SQLQuerydevcontrol.SQL.Add('WHERE DeviceID = ' + IntToStr(deviceid));
    DataM1.SQLQuerydevcontrol.ExecSql;
  except
  end;
End;

Procedure TFrameDeviceplacer.Getdevicestate(deviceid : Longint;
                                            Var devCurrentstate : Longint;
                                            Var devenabled      : Longint);
Begin
  try
    DataM1.SQLQuerydevcontrol.SQL.Clear;
    DataM1.SQLQuerydevcontrol.SQL.Add('Select enabled,currentstate from DeviceConfigurations');
    DataM1.SQLQuerydevcontrol.SQL.Add('where DeviceID = ' + IntToStr(deviceid));
    DataM1.SQLQuerydevcontrol.Open;
    IF not DataM1.SQLQuerydevcontrol.eof then
    begin
      devCurrentstate := DataM1.SQLQuerydevcontrol.Fields[1].AsInteger;
      devEnabled := DataM1.SQLQuerydevcontrol.Fields[0].AsInteger;
    end;
    DataM1.SQLQuerydevcontrol.Close;
  Except
  end;
End;

procedure TFrameDeviceplacer.TimerdeviceupdateTimer(Sender: TObject);
begin
try
  Timerdeviceupdate.Enabled := false;
  IF (Secondsbetween(now,Lastupdate) > Prefs.DeviceAutoRefreshSpeed) and (Prefs.DeviceAutoRefreshSpeed > 0) and
     (Prefs.ShowDeviceControl) and (formmain.GroupBoxdevicelist.Visible) then
  begin
    UpdateDevices;
  end;
  Except
  end;
  Timerdeviceupdate.Enabled := true;
end;

procedure TFrameDeviceplacer.UpdateDevices;
Var
  aktN,i : Longint;
  s      : String;
  anydif : Boolean;
begin
  aktN := 0;
   DataM1.ConnectToServerDeviceState();
  if (DataM1.CheckDBDeviceState() = false) then
  begin
    DataM1.DisConnectFromServerDeviceState();
    exit;
  end;
  try
    DataM1.SQLQuerydevcontrol.SQL.Clear;
    if (Prefs.DeviceControlUsePressDevices) and (Pressdevpossible) then
    Begin
      DataM1.SQLQuerydevcontrol.SQL.Add('Select distinct DC.DeviceID,PD.deviceid from DeviceConfigurations DC , pressdevices PD');
      DataM1.SQLQuerydevcontrol.SQL.Add('Where PD.deviceid = DC.deviceid and PD.pressid in ' + DEVPressvisibilyIN  );
      DataM1.SQLQuerydevcontrol.SQL.Add('order by DC.DeviceID');
      DataM1.SQLQuerydevcontrol.Open;
      aktN := 0;
      While not DataM1.SQLQuerydevcontrol.eof do
      begin
        Inc(aktN);
        DataM1.SQLQuerydevcontrol.Next;
      end;
    end
    Else
    begin
      DataM1.SQLQuerydevcontrol.SQL.Add('select count(deviceid) from DeviceConfigurations ');
      DataM1.SQLQuerydevcontrol.SQL.Add('where locationid = ' + IntToStr(tnames1.locationnametoid(ComboBoxlocationManage.Text)));
      DataM1.SQLQuerydevcontrol.Open;
      IF not DataM1.SQLQuerydevcontrol.eof then
      begin
        aktN := DataM1.SQLQuerydevcontrol.Fields[0].AsInteger;
      End;
    end;

    DataM1.SQLQuerydevcontrol.Close;
    Anydif := false;
    IF (aktN = Ndevicecontrolframes) and (aktN>0) then
    begin
      DataM1.SQLQuerydevcontrol.SQL.Clear;
      if (Prefs.DeviceControlUsePressDevices) and (Pressdevpossible) then
      begin
        DataM1.SQLQuerydevcontrol.SQL.Clear;
        DataM1.SQLQuerydevcontrol.SQL.Add('select distinct DC.DeviceID,DC.Devicename,DC.devicetype,DC.Enabled,DC.CurrentState,PD.deviceid,DC.PanoramaOrientation from DeviceConfigurations DC , pressdevices PD');
        DataM1.SQLQuerydevcontrol.SQL.Add('Where PD.deviceid = DC.deviceid and PD.pressid in ' + DEVPressvisibilyIN  );
        DataM1.SQLQuerydevcontrol.SQL.Add('order by DC.DeviceName');
      End
      else
      begin
        DataM1.SQLQuerydevcontrol.SQL.Add('select DeviceID,Devicename,devicetype,Enabled,CurrentState,PanoramaOrientation from DeviceConfigurations ');
        DataM1.SQLQuerydevcontrol.SQL.Add('where locationid = ' + inttostr(tnames1.locationnametoid(ComboBoxlocationManage.Text)));
        DataM1.SQLQuerydevcontrol.SQL.Add('order by DeviceName');
      End;
      DataM1.SQLQuerydevcontrol.Open;
      i := 0;
      While not DataM1.SQLQuerydevcontrol.eof do
      begin
        IF devicecontrolframes[i] <> nil then
        begin
          s:= DataM1.SQLQuerydevcontrol.Fields[1].AsString;
          devicecontrolframes[i].deviceid := DataM1.SQLQuerydevcontrol.Fields[0].AsInteger;
          devicecontrolframes[i].LabelDevame.caption := s;
          devicecontrolframes[i].devicetype := DataM1.SQLQuerydevcontrol.Fields[2].AsInteger;
          s := UpperCase(s);
          if AnsiContainsStr(s,'DOTMATE') then
            devicecontrolframes[i].Devicetype := 2;
          if AnsiContainsStr(s,'KATANA') then
            devicecontrolframes[i].Devicetype := 5;
          if devicecontrolframes[i].Devicetype = 18 then // KODAK XPO
            devicecontrolframes[i].Devicetype := 8;
          if devicecontrolframes[i].Devicetype = 19 then // Polaris
            devicecontrolframes[i].Devicetype := 12;
          if devicecontrolframes[i].Devicetype = 20 then // Basys
            devicecontrolframes[i].Devicetype := 7;
          devicecontrolframes[i].DevEnabled := DataM1.SQLQuerydevcontrol.Fields[3].AsInteger;
          devicecontrolframes[i].Currentstate := DataM1.SQLQuerydevcontrol.Fields[4].AsInteger;
          devicecontrolframes[i].JobsInQueue := DataM1.SQLQuerydevcontrol.FieldByName('PanoramaOrientation').AsInteger;
        End
        Else
        begin
          anydif := true;
          break;
        end;
        Inc(I);
        DataM1.SQLQuerydevcontrol.Next;
      End;
      DataM1.SQLQuerydevcontrol.Close;
      (*
      IF not anydif then
      begin
        IF Pressdevpossible then
        begin
          For i := 0 to Ndevicecontrolframes-1 do
          begin
            IF devicecontrolframes[i].ListBox1.Visible then
            begin
              DataM1.SQLQuerydevcontrol.SQL.Clear;
              DataM1.SQLQuerydevcontrol.SQL.add('select pd.pressid,pn.PressName from PressDevices pd, PressNames pn ');
              DataM1.SQLQuerydevcontrol.SQL.add('where pd.deviceid = ' + inttostr(devicecontrolframes[i].deviceid));
              DataM1.SQLQuerydevcontrol.SQL.add('And pd.pressid = pn.pressid');
              DataM1.SQLQuerydevcontrol.SQL.add('order by pn.PressName');
              DataM1.SQLQuerydevcontrol.open;
              devicecontrolframes[i].ListBox1.items.BeginUpdate;
              devicecontrolframes[i].ListBox1.items.clear;
              While not DataM1.SQLQuerydevcontrol.eof do
              begin
                devicecontrolframes[i].ListBox1.items.add(DataM1.SQLQuerydevcontrol.fields[1].asstring);
                DataM1.SQLQuerydevcontrol.next;
              end;
              DataM1.SQLQuerydevcontrol.close;
              IF devicecontrolframes[i].ListBox1.items.count = 0 then
                devicecontrolframes[i].ListBox1.Items.add('No presses');
              devicecontrolframes[i].ListBox1.items.endUpdate;
              devicecontrolframes[i].ListBox1.Height := (devicecontrolframes[i].ListBox1.ItemHeight) * (devicecontrolframes[i].ListBox1.Items.Count)+4;
            end;
          End;
        End;
      end;
      *)
    end
    Else
      Anydif := true;

    IF not anydif then
    begin
      For i := 0 to Ndevicecontrolframes-1 do
      begin
        devicecontrolframes[i].Setstate;
      End;
    end;
  Except
    Anydif := true;
  end;
  if anydif then
    loaddevices;
  Lastupdate := now;
end;
procedure TFrameDeviceplacer.ComboBoxlocationManageChange(Sender: TObject);
begin
  LoadDevices;
end;

function TFrameDeviceplacer.MakeFramDevPressGrpIN : Integer;
var
  //idx,
  i : Longint;
  T :String;
  n : Integer;
begin
  n := 0;
  result := 0;
  try
    nopresssesectedinsettings := Prefs.ISadministrator;
    if (not Prefs.ISadministrator) then
    begin
      for i := 0 to Length(Prefs.VisiblePressesConfig)-1 do
      begin
        if (Prefs.VisiblePressesConfig[i].Visible) then
        begin
          nopresssesectedinsettings := false;
          break;
        end;
      End;
    end;

    DEVPressvisibilyIN := '(-99';
    if (Prefs.LocationPressFilterMode <> LOCATIONPRESSSFILTERMODE_PRESSGROUP) OR (not Pressdevpossible) then
    begin
      DEVPressvisibilyIN := DEVPressvisibilyIN +','+ IntToStr(tnames1.pressnametoid(ComboBoxlocationManage.Text));
    end
    else   // (Prefs.LocationPressFilterMode = LOCATIONPRESSSFILTERMODE_PRESSGROUP)
    begin
      DataM1.SQLQuerydevcontrol.SQL.Clear;
      DataM1.SQLQuerydevcontrol.SQL.Add('SELECT PressGroupID,PressGroupName,PressID FROM PressGroupNames');
      DataM1.SQLQuerydevcontrol.SQL.Add('WHERE PressGroupName = ' +''''+ComboBoxlocationManage.Text+'''');
      DataM1.SQLQuerydevcontrol.SQL.Add('ORDER BY PressID');
      DataM1.SQLQuerydevcontrol.Open;
      While not DataM1.SQLQuerydevcontrol.eof do
      begin
        T := tnames1.pressnameIDtoname(DataM1.SQLQuerydevcontrol.Fields[2].AsInteger);
        if ( Prefs.VisiblePressConfigNameVisible(T)) OR (nopresssesectedinsettings) then
        begin
          Inc(n);
          DEVPressvisibilyIN := DEVPressvisibilyIN + ','+DataM1.SQLQuerydevcontrol.Fields[2].AsString;
        end;
        DataM1.SQLQuerydevcontrol.Next;
      end;
      DataM1.SQLQuerydevcontrol.Close;
    end;
    DEVPressvisibilyIN := DEVPressvisibilyIN + ')';
    result := n;
  except
  end;
end;

end.
