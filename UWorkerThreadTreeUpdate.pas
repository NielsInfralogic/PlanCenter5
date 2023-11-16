
unit UWorkerThreadTreeUpdate;
interface
uses
  Classes,ComCtrls,FileCtrl, WinApi.ActiveX;
type
  TWorkerThreadTreeUpdate = class(TThread)
  private
    { Private declarations }
    procedure gettreedata;

    procedure LookForProductionError;
    procedure lookforhoney;
    Procedure checkthetreesize;
    procedure Setproderrorvisibil;
    procedure Settreedata;
    Function SetApagetree(LocationId : Integer;
                           Usespecificdata : Boolean;
                           specificdate : Tdatetime):Boolean;
    procedure refreshtree;
    Function makedatastr(tabledef : string;
                         pubdate : tdatetime):String;
    function GetDatabaseDateTree : String;

  protected
    procedure Execute; override;
  Public
    running : Boolean;
    setparentstatesum : Int64;
    Timeofsetparentstate : Tdatetime;
    Newvisi : Boolean;
    MainUpdateingNum : Integer;
    Rerun   : Boolean;
    terminateit : Boolean;
    Timetonextcheckthetreesize : Tdatetime;
    Constructor Create;
  end;

Var
  workerThreadTreeUpdate : TWorkerThreadTreeUpdate;

implementation
Uses
  windows,SysUtils,Usettings, utypes, Udata, UFTP,ShellAPI,umain,
  forms,DateUtils,Graphics,UPrev2, UUtils;

Var
  Ltree : TTreeView;
  sumorder : array[0..10] of Integer;
  TreeSelpubdate : Tdatetime;
  TreeSelpubid   : Integer;
  treedatareay : Boolean;
  pressrunsSize : Integer;
  Nlevel2 : Integer;
  level2Updt : Array of Integer;
  Nlevel3 : Integer;
  level3Updt : Array of Integer;
  Slevel2,Slevel3 : Integer;

  Npressruns    : Integer;
  pressruns  : Array of record
                          anychange : Boolean;
                          productionid : Integer;
                          publicationid : Integer;
                          pubdate : Tdatetime;
                          Pressrunid : Integer;
                          State : Integer;
                          OrgState : Integer;
                          Anymissing : boolean;
                          Anyreceived : Boolean;
                          SomeImaged : Boolean;
                          AnyImaged : Boolean;
                          Anyimaging : Boolean;
                          AnyError : Boolean;
                          AllImaged : Boolean;
                          Allcommon : Boolean;
                          SomeNotapproved : Boolean;
                          Itree : Integer;
                          NItrees : Integer;
                          Itrees : Array[1..20] of Integer;
                          Level2 : Integer;
                          Level3 : Integer;
                          // ### NAN 20151019
                          AllImagedOnce : Boolean;
                          PlanType : Integer;
                          OrgPlanType : Integer;
                          PagesReady : Boolean;
                          PagesIllegal : Boolean;
                          OrgPagesReady : Boolean;
                          OrgPagesIllegal :   Boolean;
                        end;

Constructor TWorkerThreadTreeUpdate.Create;
Begin
  inherited create(false);
  treeIdle := true;
  running := false;
  TreeStopit  := false;
  Rerun   := false;
  terminateit := false;
  freeonterminate := false;
  MainUpdateing := false;
  mainrefreshing := false;
  Newvisi := false;
  Timetonextcheckthetreesize := Now;
  Timetonextcheckthetreesize := IncMinute(Timetonextcheckthetreesize,1);

  sumorder[0] := 0;  //    blank
  sumorder[2] := 1;  //    missing
  sumorder[1] := 2;  //    All imaged
  sumorder[3] := 3;  //    Some imaged
  sumorder[6] := 4;  //    All common
  sumorder[4] := 5;  //    Some received
  sumorder[9] := 6;  //    All imaged once
  sumorder[8] := 7;  //    Imaging
  sumorder[7] := 8;  //    Error
  sumorder[5] := 9;  //    Some not approved   !

end;

procedure TWorkerThreadTreeUpdate.Execute;
Var
  Aktpos,I : Integer;
  TimetonextRefresh,anowtime,timetohoney : TDateTime;
begin
  timetohoney := Now;
  LookForProducerrorTime := Now;
  LookForProducerrorTimeblink := now;

  repeat

    i := 1;
    TimetonextRefresh := now;
    anowtime := TimetonextRefresh;
    Aktpos := Prefs.TreeAutoRefreshSpeed;
    IF Aktpos < Mintreerefresh then
      Aktpos := Mintreerefresh;
    treeIdle := true;
    TimetonextRefresh := IncSecond(TimetonextRefresh,Aktpos);   //antal sekunder til n�ster update
    Repeat
      Sleep(500);
      if (terminateit) then
        break;
      Sleep(500);
      if (Prefs.SynchronizedTreeUpdate) then
        Synchronize(GetTreeData)
      else
        GetTreeData;

      if (Prefs.UseHoneywell) then
        lookforhoney;
      if (not Prefs.LeanAndMeanPreview) then
        LookForProductionError();
      //application.ProcessMessages;
      Inc(i) ;
    //  IF (FoxrmSettings.CheckBoxDelaytreelamp.Checked and DoALamptreerefresh) then
    //  begin
    //    I := 201;
    //  end;
    until (terminateit) or (i > 200) or  (TreeStopit) or (Now > TimetonextRefresh);

    MainUpdateingNum := -99;
    IF (not MainUpdateing) and (not terminateit) then
    begin
      try
        if (Prefs.SynchronizedTreeUpdate) then
          Synchronize(checkthetreesize)
        else
          checkthetreesize;
        if Timetonextcheckthetreesize > Now then
        begin
          //checkthetreesize;
          Timetonextcheckthetreesize := Now;
          Timetonextcheckthetreesize := Incminute(Timetonextcheckthetreesize,1);
        end;
      Except
      End;
    end;

    IF (not MainUpdateing) and (not TreeStopit) and (not terminateit) then
    begin
      try
        MainUpdateingNum := 0;
        treeIdle := false;
        //setparentstatesum := 0;
        //Timeofsetparentstate := now;
         if (Prefs.SynchronizedTreeUpdate) then
            Synchronize(RefreshTree)
         else
            RefreshTree();
        //Timeofsetparentstate
        treeIdle := true;
        TimetonextRefresh := Now;
        TimetonextRefresh := IncSecond(TimetonextRefresh,Aktpos);
      Except
      End;
    end;
    //DoALamptreerefresh := false;
    treeIdle := true;
  until terminateit;
 //  CoUninitialize();
end;

Function TWorkerThreadTreeUpdate.MakeDataStr(tabledef : string;
                                      pubdate : tdatetime):String;
Var
  Year, Month, Day: Word;
  SYear, SMonth, SDay: string;
Begin
  DecodeDate(pubdate,Year, Month, Day);
  SYear   := IntToStr(Year);
  SMonth  := IntToStr(Month);
  SDay    := IntToStr(Day);
  result := '(datepart(day,'+tabledef+'pubdate) = ' +SDay+' and datepart(month,'+tabledef+'pubdate) = '+smonth+' and datepart(year,'+tabledef+'pubdate) = '+syear+')';
end;



//
procedure TWorkerThreadTreeUpdate.RefreshTree;
var
  DBOK : Boolean;
  LocationId : Integer;
begin
  LocationId := -1;
  DataM1.ConnectToServerTreeThread();
  if (DataM1.CheckDBTreeThread() = false) then
  begin
    DataM1.DisConnectFromServerTreeThread();
    exit;
  end;
  treedatareay := false;
  try

  if formmain.PageControlMain.ActivePageIndex < 5 then
  begin
    if formmain.ComboBoxpalocationNY.enabled AND (FormMain.ComboBoxpalocationNY.Text <> 'All') then
      LocationId := tnames1.locationnametoid(formmain.ComboBoxpalocationNy.items[formmain.ComboBoxpalocationNy.ItemIndex]);

    Case formmain.PageControlMain.ActivePageIndex of
      VIEW_SEPARATIONS :
          begin
            Ltree := formmain.TreeViewpagelist;

            IF Usesnewtreetable then
            begin
              DataM1.NewThreadtreetableLamps;
            end
            Else
            begin
              treedatareay := SetApagetree(LocationId,false,now);
            end;
          end;
      VIEW_THUMBNAILS :
          begin
            Ltree := formmain.TreeViewThumbs;
           IF Usesnewtreetable then
             begin
              DataM1.NewThreadtreetableLamps;
            end
             Else
           begin
              treedatareay := SetApagetree(LocationId,false,now);
            end;
          end;
      VIEW_PLATES :
          begin
            Ltree := formmain.TreeViewPlateview;
             IF Usesnewtreetable then
             begin
               DataM1.NewThreadtreetableLamps;
             end
              Else
             begin
              treedatareay := SetApagetree(LocationId,false,now);
            end;
          end;
      VIEW_PRODUCTIONS :
          begin
            Ltree := formmain.TreeViewprodcontrol;
            IF Usesnewtreetable then
            begin
              DataM1.NewThreadtreetableLamps;
            end
            Else
            begin
              treedatareay := SetApagetree(LocationId,false,now);
            end;
          end;
      VIEW_EDITIONS :
          begin
            Ltree := formmain.TreeViewNeweddtree;
            IF Usesnewtreetable then
            begin
              DataM1.NewThreadtreetableLamps;
            end
            Else
            begin
              treedatareay := SetApagetree(LocationId,false,now);
            end;
          end;
    end;
    if treedatareay then
    Begin
      if (Prefs.SynchronizedTreeUpdate) then
        Synchronize(Settreedata)
      else
        Settreedata;
    End;
  end;
  SetLength(pressruns,10);

  finally
    Datam1.DisConnectFromServerTreeThread();
  end;
end;


Procedure TWorkerThreadTreeUpdate.checkthetreesize;
  Procedure setnewprodsigns;
  Begin
    Formmain.Actionrefreshpagefilter.ImageIndex := ICON_WARNINGSIGN;
    Formmain.ActionThumbnailFilterrefresh.ImageIndex := ICON_WARNINGSIGN;
    Formmain.ActionPlaterefreshtree.ImageIndex := ICON_WARNINGSIGN;
    Formmain.Actionprogressrefreshfilter.ImageIndex := ICON_WARNINGSIGN;
    Formmain.Actionrefreshhedtree.ImageIndex := ICON_WARNINGSIGN;
    Formmain.Actionreportfilter.ImageIndex := ICON_WARNINGSIGN;
  End;

Var
  newsize : Integer;
begin
  try
  DataM1.ConnectToServerTreeThread();
  if (DataM1.CheckDBTreeThread() = false) then
  begin
    DataM1.DisConnectFromServerTreeThread();
    exit;
  end;
    IF (checkfiltercount > -1) And (Not formmain.Actionnewprods.Visible) then
    begin
      DataM1.SQLQueryTreethread.Sql.Clear;
      DataM1.SQLQueryTreethread.Sql.Add('Select Count (Distinct Pressrunid) from pressrunid (NOLOCK)');
      DataM1.SQLQueryTreethread.Open;
      newsize := DataM1.SQLQueryTreethread.Fields[0].AsInteger;
      DataM1.SQLQueryTreethread.Close;
      if (checkfiltercount <> newsize) and (checkfiltercount <> -1) then
      begin
        setnewprodsigns;
        formmain.Actionnewprods.Visible := true;
      end;
    End;
  Except
  end;
end;

function TWorkerThreadTreeUpdate.GetDatabaseDateTree : String;
Var
   adate : TDateTime;
begin
    result := '';
    Datam1.SQLQueryTreethread.SQL.Clear;
    Datam1.SQLQueryTreethread.SQL.Add('SELECT GETDATE()');
    Datam1.SQLQueryTreethread.Open;
    if not Datam1.SQLQueryTreethread.Eof then
      adate := DateOf(Datam1.SQLQueryTreethread.Fields[0].AsDateTime);
    Datam1.SQLQueryTreethread.Close;

    result := IntToStr(MonthOf(adate)) + '/' + IntToStr(DayOf(adate)) + '/' + IntToStr(YearOf(adate));
end;

// Assume LTree is set to correct tree-type
// Result is PressRuns array
Function TWorkerThreadTreeUpdate.SetApagetree(LocationId : Integer;
                                        Usespecificdata : Boolean;
                                        specificdate : Tdatetime):boolean;
Var
  Ipressruns,ipr,Lipr : Integer;
  aktpressrunid,aktlocation: Integer;
  aktflat : int64;
  ISTD,I,di,itree: Integer;
  Dnode,Pnode,enode,snode,tempNode : ttreenode;
  DBOK,foundachange : Boolean;
  StartTid : Tdatetime;

  status     : Integer;
  uniquepage : Integer;
  outputversion : Integer;
  approved,Al2,Al3,prepollstatus   : Integer;
  Pubdatefilter : Tdatetime;
  treelevelixdx : Integer;
  ThisPressRunID : Integer;
  thisNotApproved : boolean;
  GotException : boolean;
  SQLCurrentDate : String;
   PressRunMiscInt2 : Integer;
   PressRunPlanVersion : Integer;
   NumberOfNodes,n : Integer;
   CurItem : TTreeNode;
Begin
  result := false;
  GotException := false;
  StartTid := now;
  writeMainlogfile('SetaPageTree start');
  ThisPressRunID := 0;
 // for debug... Ltree.Color := clBlue;
  // Check connection to DB
  DBOK := DataM1.CheckDBTreeThread();
  if not DBOK then
    exit;

  try
    di := 0;
    pressrunsSize := 1000;
    Setlength(pressruns,pressrunsSize);
    Npressruns := 0;
    aktpressrunid := -1;
    if (Ltree.Items.Count > 0) then
    begin
      CurItem := Ltree.Items.GetFirstNode;
//      For itree := 0 to Ltree.Items.Count-1 do
      while CurItem <> nil do
      begin
        itree :=  CurItem.Index;
        // Scan through level 4 items (section level)
        IF (CurItem.Level = 4) then
        begin
          // Register number of different press runs in existing tree - initialise pressruns array
          ThisPressRunID := TTreeViewpagestype(CurItem.data^).pressrunid;
          IF aktpressrunid <> ThisPressRunID then
          begin
            aktpressrunid := ThisPressRunID;
            Inc(Npressruns);
            IF pressrunsSize <= Npressruns then
            begin
              Inc(pressrunsSize,1000);
              Setlength(pressruns,pressrunsSize);
            end;
            pressruns[Npressruns].anychange := false;
            pressruns[Npressruns].OrgState := CurItem.StateIndex;
            pressruns[Npressruns].Pressrunid := ThisPressRunID;
            pressruns[Npressruns].OrgPagesIllegal := TTreeViewpagestype(CurItem.data^).PagesIllegal;
            pressruns[Npressruns].OrgPagesReady := TTreeViewpagestype(CurItem.data^).PagesReady;
            pressruns[Npressruns].State := -1;
            pressruns[Npressruns].Anymissing := false;
            pressruns[Npressruns].Anyreceived := false;
            pressruns[Npressruns].AnyImaged := false;
            pressruns[Npressruns].Anyimaging := false;
            pressruns[Npressruns].AnyError := false;
            pressruns[Npressruns].AllImaged := true;
            pressruns[Npressruns].AllImagedOnce := true;
            pressruns[Npressruns].Allcommon := true;
            pressruns[Npressruns].SomeNotapproved := false;
            pressruns[Npressruns].Itree := itree;
            pressruns[Npressruns].anychange := false;
            pressruns[Npressruns].Itrees[1] := itree;
            pressruns[Npressruns].NItrees := 1;
  //        pressruns[Npressruns].Level2        := Ltree.Items[itree].Parent.Parent.AbsoluteIndex ; // TTreeViewpagestype(Ltree.Items[itree].data^).PublItree;
  //        pressruns[Npressruns].Level3        := Ltree.Items[itree].Parent.AbsoluteIndex; //TTreeViewpagestype(Ltree.Items[itree].data^).edItree;
            pressruns[Npressruns].PagesReady := false;
            pressruns[Npressruns].PagesIllegal := false;
            // NAN
            pressruns[Npressruns].PlanType := 1;
            if (Ltree.Items[itree].ImageIndex = 16) then
              pressruns[Npressruns].OrgPlanType := 0
            else if (Ltree.Items[itree].ImageIndex = 296) then
              pressruns[Npressruns].OrgPlanType := 3
            else if (Ltree.Items[itree].ImageIndex = 295) then
              pressruns[Npressruns].OrgPlanType := 2
            else
              pressruns[Npressruns].OrgPlanType := 1;

            if MainUpdateing or treeStopit then
            Begin
              MainUpdateingNum := 1;
              result := false;
              exit;
            End;
          End
          Else
          begin
            // register tree node index in pressruns structure
            Inc(pressruns[Npressruns].NItrees);
            pressruns[Npressruns].Itrees[pressruns[Npressruns].NItrees] := itree;
          end;
        end;
        CurItem := CurItem.GetNext;
      end;
    End;
    aktpressrunid := -1;
    Ipressruns := -1;
    // first item not used...
    pressruns[0].Pressrunid := -111;
    SQLCurrentDate := GetDatabaseDateTree;
    datam1.SQLQueryTreethread.SQL.Clear;
    if (Prefs.TreeShowPrepollEvents) then
    begin
      if (PressRunIDPlanVersionPossible) then
	      datam1.SQLQueryTreethread.SQL.add('Select distinct p1.pressrunid,p1.status,p1.uniquepage,p1.approved,MAX(ISNULL(PRE.Event,0)),P1.OutputVersion,PROD.PlanType,PREID.MiscInt2,PREID.PlanVersion FROM pagetable p1 (NOLOCK)')
      else
        datam1.SQLQueryTreethread.SQL.add('Select distinct p1.pressrunid,p1.status,p1.uniquepage,p1.approved,MAX(ISNULL(PRE.Event,0)),P1.OutputVersion,PROD.PlanType FROM pagetable p1 (NOLOCK)');
	    datam1.SQLQueryTreethread.SQL.add('LEFT OUTER JOIN PrepollPageTable PRE WITH (NOLOCK) ON P1.MasterCopySeparationSet=PRE.MasterCopySeparationSet AND PRE.Event IN (116,126,136,216)');
      // ## NAN 20160329 - added to track PlanType change
	    datam1.SQLQueryTreethread.SQL.add('LEFT OUTER JOIN ProductionNames PROD WITH (NOLOCK) ON P1.ProductionID=PROD.ProductionID');
	    datam1.SQLQueryTreethread.SQL.add('LEFT OUTER JOIN PressRunID PREID WITH (NOLOCK) ON P1.PressRunID=PREID.PressRunID');
    end
    else
    begin
      if (PressRunIDPlanVersionPossible) then
	      datam1.SQLQueryTreethread.SQL.add('Select distinct p1.pressrunid,p1.status,p1.uniquepage,p1.approved,0,P1.OutputVersion,PROD.PlanType,PREID.MiscInt2,PREID.PlanVersion from pagetable p1 (NOLOCK)')
      else
	      datam1.SQLQueryTreethread.SQL.add('Select distinct p1.pressrunid,p1.status,p1.uniquepage,p1.approved,0,P1.OutputVersion,PROD.PlanType from pagetable p1 (NOLOCK)');
      // ## NAN 20160329 - added to track PlanType change
      datam1.SQLQueryTreethread.SQL.add('LEFT OUTER JOIN ProductionNames PROD WITH (NOLOCK) ON P1.ProductionID=PROD.ProductionID');
	    datam1.SQLQueryTreethread.SQL.add('LEFT OUTER JOIN PressRunID PREID WITH (NOLOCK) ON P1.PressRunID=PREID.PressRunID');
    end;
    datam1.SQLQueryTreethread.SQL.add('Where p1.active = 1 and p1.pagetype < 3 and p1.dirty = 0 and DATEPART(year,p1.PubDate) < 2100');
    if FormMain.ComboBoxGlobalPubDateFilter.Itemindex > 1 then
    begin
      if (not Prefs.ShowWeekNumberInTree) then
      Begin
        Pubdatefilter := strtodate(Formmain.ComboBoxGlobalPubDateFilter.text);
        DataM1.SQLQueryTreethread.SQL.add(' and '+  DataM1.makedatastr('p1.',Pubdatefilter));
      end
      else
      begin
        Pubdatefilter := StartOfAWeek(StrToInt(Copy(FormMain.ComboBoxGlobalPubDateFilter.Text, 4, 8)) , StrToInt(Copy(FormMain.ComboBoxGlobalPubDateFilter.Text, 1, 2)));
        Datam1.SQLQueryTreethread.SQL.Add(' and (p1.pubdate >= ''' + FormatDateTime('YYYY-MM-DD', Pubdatefilter) + ''')');
        Pubdatefilter := EndOfAWeek(StrToInt(Copy(FormMain.ComboBoxGlobalPubDateFilter.Text, 4, 8)) , StrToInt(Copy(FormMain.ComboBoxGlobalPubDateFilter.Text, 1, 2)));
        Datam1.SQLQueryTreethread.SQL.Add(' and (p1.pubdate <= ''' + FormatDateTime('YYYY-MM-DD', Pubdatefilter) + ''')');
      end;
    end
    else
    begin
      if Formmain.ComboBoxGlobalPubDateFilter.Text = Formmain.LabelFromtoday.Caption then
      begin
        //Datam1.SQLQueryTreethread.SQL.Add(' and (p1.pubdate >= ''' + SQLCurrentDate + ''')');
        //DataM1.SQLQueryTreethread.SQL.add(' and (p1.pubdate >= CAST(DATEPART(month,GETDATE()) as varchar(4)) + ''/'' + CAST(DATEPART(day,GETDATE()) as varchar(4)) + ''/'' + CAST(DATEPART(year,GETDATE()) as varchar(4)))');
        Datam1.SQLQueryTreethread.SQL.Add(' and (DATEDIFF(day,GETDATE(),p1.pubdate) >= 0)');
      end;
    end;
    if (LocationID>0) then
      datam1.SQLQueryTreethread.SQL.Add('and p1.locationid = ' + IntToStr(Locationid));
    if Pressvisibilylimited then
      datam1.SQLQueryTreethread.SQL.Add('and p1.pressid IN ' + PressvisibilyIN);
    if (Prefs.TreeShowPrepollEvents) then
    begin
      if (PressRunIDPlanVersionPossible) then
        datam1.SQLQueryTreethread.SQL.add('GROUP BY p1.pressrunid,p1.status,p1.uniquepage,p1.approved,OutputVersion,PROD.PlanType,PREID.MiscInt2,PREID.PlanVersion')
      else
        datam1.SQLQueryTreethread.SQL.add('GROUP BY p1.pressrunid,p1.status,p1.uniquepage,p1.approved,OutputVersion,PROD.PlanType');
    end;
    datam1.SQLQueryTreethread.SQL.add('order by pressrunid');
    IF Prefs.debug then
      datam1.SQLQueryTreethread.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'pagetreeTHR.sql');
    writeMainlogfile('SetaPageTree SQLQueryTreethread start');
    datam1.SQLQueryTreethread.open;
    while not datam1.SQLQueryTreethread.Eof do
    begin
      if MainUpdateing or treeStopit then
      Begin
        MainUpdateingNum := 22;
        result := false;
        exit;
      End;
      ThisPressRunID :=  datam1.SQLQueryTreethread.Fields[0].AsInteger;
      if aktpressrunid <> ThisPressRunID then
      begin
        // Find reference to internal pressruns list (index Ipressruns)
        Ipressruns := -1;
        aktpressrunid := ThisPressRunID;
        For ipr := 1 to Npressruns do
        begin
          if MainUpdateing or treeStopit then
          Begin
            MainUpdateingNum := 2;
            result := false;
            exit;
          End;
          if pressruns[Ipr].Pressrunid = aktpressrunid then
          begin
            Ipressruns := Ipr;
            Break;
          end;
        end;
      end;

      if Ipressruns > 0 then
      begin
        status     :=  datam1.SQLQueryTreethread.fields[1].AsInteger;
        uniquepage :=  datam1.SQLQueryTreethread.fields[2].AsInteger;
        approved   :=  datam1.SQLQueryTreethread.fields[3].AsInteger;
        outputversion :=  datam1.SQLQueryTreethread.fields[5].AsInteger;
        // ## NAN 20160329 - track if PlanType has changed
        pressruns[Ipressruns].PlanType :=  datam1.SQLQueryTreethread.fields[6].AsInteger;
        PressRunMiscInt2 := 0;
        PressRunPlanVersion := 1;
        if (PressRunIDPlanVersionPossible) then
        begin
          PressRunMiscInt2 := (datam1.SQLQueryTreethread.fields[7].AsInteger) DIV 256;
          PressRunPlanVersion := (datam1.SQLQueryTreethread.fields[8].AsInteger);
        end;
        if (PressRunMiscInt2>0) then
          pressruns[Ipressruns].PlanType := PressRunMiscInt2;
        if ( PressRunPlanVersion > 1) and (PressRunPlanVersion < 8) then
          pressruns[Ipressruns].PagesReady := true
        else
          pressruns[Ipressruns].PagesReady := false;
        if ( PressRunPlanVersion >= 8) then
          pressruns[Ipressruns].PagesIllegal := true
        else
          pressruns[Ipressruns].PagesIllegal := false;
        thisNotApproved := (status>0) AND (approved IN [0,2]) AND (uniquepage<>0);
        prepollstatus := 0;
        if (Prefs.TreeShowPrepollEvents) then
          prepollstatus :=  datam1.SQLQueryTreethread.fields[4].AsInteger;
        // Determine accumulation state flags
        IF (status = 0) And (uniquepage > 0) then
          pressruns[Ipressruns].Anymissing := true;
        IF (status > 0) And (uniquepage <> 0) then
          pressruns[Ipressruns].Anyreceived := true;
        IF (outputversion = 0) AND (uniquepage > 0) then
          pressruns[Ipressruns].AllImagedOnce := false;
        IF (status IN [6,16,26,36,46,56]) OR (prepollstatus > 0) then
          pressruns[Ipressruns].AnyError := true
        else
        begin
          IF status >= 50 then
            pressruns[Ipressruns].AnyImaged := true;
          IF (status > 30) and (status < 50) then
            pressruns[Ipressruns].Anyimaging := true;
        end;
        IF (status < 50) then
          pressruns[Ipressruns].AllImaged := false;
        IF uniquepage > 0 then
          pressruns[Ipressruns].Allcommon := false;
        IF (Not pressruns[Ipressruns].SomeNotapproved) and thisNotApproved and (pressruns[Ipressruns].Anyreceived) and (Not pressruns[Ipressruns].allimaged) and (approved in [0,2] ) then
        begin
          pressruns[Ipressruns].SomeNotapproved := true;
        end;
      end;
      if MainUpdateing or treeStopit then
      Begin
        MainUpdateingNum := 3;
        result := false;
        exit;
      End;
      datam1.SQLQueryTreethread.Next;
    End;
    datam1.SQLQueryTreethread.Close;
    writeMainlogfile('SetaPageTree SQLQueryTreethread end');




    For ipr := 1 to Npressruns do
    begin
      if MainUpdateing or treeStopit then
      Begin
        MainUpdateingNum := 4;
        result := false;
        exit;
      End;
      // .State is the final dot color selector
      pressruns[ipr].State := 0;
      IF pressruns[ipr].Anyreceived then
        pressruns[ipr].State := 1;
      IF (pressruns[ipr].AllImagedOnce) AND (pressruns[ipr].Allcommon = false) AND (Prefs.IncludeImageOnceState) then
        pressruns[ipr].State := 8;
      IF pressruns[ipr].SomeNotapproved then
        pressruns[ipr].State := 7;
      if (pressruns[ipr].AnyImaged) and (pressruns[ipr].Anymissing) then
        pressruns[ipr].State := 2;
      IF pressruns[ipr].AllImaged then
        pressruns[ipr].State := 3;
      IF pressruns[ipr].Anyimaging then
        pressruns[ipr].State := 4;
      IF (pressruns[ipr].Allcommon) And (pressruns[ipr].State <= 1) then
        pressruns[ipr].State := 5;
      IF pressruns[ipr].AnyError then
        pressruns[ipr].State := 6;
      // Re-map to image index in tree imagelist
      Case pressruns[ipr].state of
        0  : ISTD := 2; //0    =  2      missing    HVID
        1  : ISTD := 4; //1    =  4      received       GUL
        2  : ISTD := 3; //2    =  3      some missing some imaged HVID/GR�N
        3  : ISTD := 1; //3    =  1      All imaged                 GR�N
        4  : ISTD := 8; //4    =  8      Imaging                    Tandhjul
        5  : ISTD := 6; //5    =  6      All common                 BL�
        6  : ISTD := 7; //6    =  7      ERROR                      R�D
        7  : ISTD := 5; //7    =  5      Some not approved          ORANGE
        8  : ISTD := 9; //8    =  9      All imaged once (outputversion>=1)
        Else
          ISTD := 0;    // blank
      End;
      pressruns[ipr].state := ISTD;
    End;
    Nlevel2 := 0;
    Nlevel3 := 0;
    Slevel2 := Npressruns*4;
    Slevel3 := Npressruns*4;
    Setlength(level2Updt,Slevel2);
    Setlength(level3Updt,Slevel3);
    Al2 := -1;
    Al3 := -1;

    NumberOfNodes := Ltree.Items.Count;
    Ltree.Items.BeginUpdate();
    For ipr := 1 to Npressruns do
    begin
      if MainUpdateing or treeStopit then
      Begin
        MainUpdateingNum := 23;
        result := false;
        Ltree.Items.EndUpdate();
        exit;
      End;
      // See if there is any changes from last update
      if (pressruns[ipr].State <> pressruns[ipr].OrgState)
          or (pressruns[ipr].PlanType <> pressruns[ipr].OrgPlanType)
          or (pressruns[ipr].PagesIllegal <> pressruns[ipr].OrgPagesIllegal)
          or (pressruns[ipr].PagesReady <> pressruns[ipr].OrgPagesReady) then
      begin
        pressruns[ipr].anychange := true;
        treelevelixdx := pressruns[ipr].Itree;
        // 20210122
        pressruns[ipr].OrgPagesIllegal := pressruns[ipr].PagesIllegal;
        pressruns[ipr].OrgPagesReady := pressruns[ipr].PagesReady;
        if ( treelevelixdx < NumberOfNodes) then
        begin
          try
            // Level 2 = Publication


            tempNode := Ltree.Items[treelevelixdx].Parent;

            //## 20230523
            if (tempNode <> PtrToNil) then
            begin
              if (tempNode.Parent <>PtrToNil)  then
                 pressruns[ipr].Level2 := tempNode.Parent.AbsoluteIndex ; // TTreeViewpagestype(Ltree.Items[itree].data^).PublItree;
              // Level 3 = Edition
              pressruns[ipr].Level3 := tempNode.AbsoluteIndex;         //TTreeViewpagestype(Ltree.Items[itree].data^).edItree;
            end
          except
          end;
        end;

        if Al2 <> pressruns[ipr].Level2 then
        begin
          Al2 := pressruns[ipr].Level2;
          Inc(Nlevel2);
          IF Slevel2 <= Nlevel2 then
          begin
            Inc(Slevel2,100);
            Setlength(level2Updt,Slevel2);
          end;
          level2Updt[Nlevel2] := Al2;
        end;

        IF Al3 <> pressruns[ipr].Level3 then
        begin
          Al3 := pressruns[ipr].Level3;
          Inc(Nlevel3);
          IF Slevel3 <= Nlevel3 then
          begin
            Inc(Slevel3,100);
            Setlength(level3Updt,Slevel3);
          end;
          level3Updt[Nlevel3] := Al3;
        end;
      end;
    End;
    result := true;
  Except
    GotException := true;
  end;
  if MainUpdateing or treeStopit then
  Begin
    MainUpdateingNum := 5;
    result := false;
  End;
  if (GotException) then
    result := false;

  Ltree.Items.EndUpdate();

  writeMainlogfile('SetaPageTree end '+ IntToStr(Slevel2) + ' ' + IntToStr(Slevel3));
End;

// Transfer result of pressruns array (from DB) to tree
procedure TWorkerThreadTreeUpdate.SetTreeData;

    // Propagate min(status) of node sibling up to parent..
    function setparentstate(Anode : ttreenode):Boolean;
    Var
      Childnode : ttreenode;
      Statesum, stateIdx : Integer;
      pnode : ttreenode;
      aktsum : Integer;
      setparentstatestart : Tdatetime;
      akthigh,nonecommon,aktnonecommon : Integer;
      sumorder : array[0..10] of Integer;
    Begin
      try
        (*
         1    0      blank
         2    2      missing
         3    1      All imaged
         4    6      some missing some imaged
         5    4      All common
         6    3      received
         7    8      Imaging
         8    7      ERROR
         5           Some not approved..
        rank  state
         0    0      blank
         1    2      missing
         2    1      All imaged
         3    3      some missing some imaged
         4    6      All common
         5    4      received
         6    9      All imaged once
         7    8      Imaging
         8    7      ERROR
         9    5      Some not approved..
        *)
        result := false;
        //setparentstatestart := now;
      (*  sumorder[0] := 0;  //
        sumorder[2] := 1;  //
        sumorder[1] := 2;  //
        sumorder[6] := 3;  //    some imaged
        sumorder[4] := 4;  //
        sumorder[3] := 5;  //    received
        sumorder[8] := 6;  //    some not approved
        sumorder[7] := 7;  //
        sumorder[5] := 8;  //
        // NAN 20151019
        sumorder[9] := 9;  //
        *)
        // Moved to initialise tree
    //    sumorder[0] := 0;  //    blank
    //    sumorder[2] := 1;  //    missing
    //    sumorder[1] := 2;  //    All imaged
    //    sumorder[3] := 3;  //    Some imaged
    //    sumorder[6] := 4;  //    All common
    //    sumorder[4] := 5;  //    Some received
    //    sumorder[9] := 6;  //    All imaged once
    //    sumorder[8] := 7;  //    Imaging
    //    sumorder[7] := 8;  //    Error
    //    sumorder[5] := 9;  //    Some not approved   !
        akthigh := 0;
        aktnonecommon := 0;
        Childnode := Anode.getFirstChild;
        Statesum := 0;
        nonecommon := 0;
    //writeMainlogfile('Setparentstate start');
        While Childnode <> nil do
        begin
          if MainUpdateing or treestopit then
          begin
            MainUpdateingNum := 6;
            break;
          end;
          stateIdx := Childnode.StateIndex;
        (*  IF (anode.Level = 2) and (stateIdx = 6) then        // Pub level - All common
          begin
          end
          else *)
          if (anode.Level <> 2) or (stateIdx <> 6) then
          begin     // Not all common
            IF Statesum < sumorder[stateIdx] then
            Begin
              Statesum := sumorder[stateIdx];
              akthigh := stateIdx;
            End;
          end;
          IF (stateIdx <> 6) then          // Not common
          begin
            IF (nonecommon < sumorder[stateIdx]) then
            Begin
              nonecommon := sumorder[stateIdx];
              aktnonecommon := stateIdx;
            End;
          End;

          Childnode := Childnode.getNextSibling;
        end;

        // ## 20230524
        if (Anode.Level >= 2) then
        begin
          Anode.StateIndex := akthigh;

          IF (Anode.StateIndex = 6) and (aktnonecommon > 0) then
          begin
            Anode.StateIndex := aktnonecommon;
          end;
        end;
        if MainUpdateing or treestopit then
        begin
          MainUpdateingNum := 7;
          result := false;
        end
        else
        begin
          result := true;
        end;
        //setparentstatesum := setparentstatesum + MilliSecondsBetween(Now,setparentstatestart);
      Except
        result := false;
      //  writeMainlogfile('Setparentstate end');
      End;
    end;

Var
  i,ipr,itree : Integer;
  Tid : Tdatetime;
  treeitemidx : Integer;
  hasDoneUpdate : Boolean;
  publevelindex,numberOfNodes : Integer;
  pubNode,tempNode,CurItem : TTreeNode;
Begin
  try
    hasDoneUpdate := false;
    Ltree.Color := clCream;


    writeMainlogfile('Settreedata start');


    if MainUpdateing or treeStopit then
    begin
      MainUpdateingnum := 8;
      exit;
    end;

    // 20211113..
    Ltree.Items.BeginUpdate;
   // Ltree.Visible := false;

    // STEP 1 Determine PlanType symbol
     writeMainlogfile('Settreedata step 1 start ' + IntToStr(Npressruns) + ' pressruns..');
    For ipr := 1 to Npressruns do
    begin
     //  writeMainlogfile('Pressrun  ' + IntToStr(ipr) + ': ' + IntToStr(pressruns[ipr].NItrees) + ' subtrees');
      for i := 1 to pressruns[ipr].NItrees do
      begin
        itree := pressruns[ipr].Itrees[i];
        if (itree < Ltree.Items.Count) then
        begin
         // if (pressruns[ipr].anychange) or (true) then
            // Set lamp image index
            // ## 20230524
            if (Ltree.Items[itree].level >= 2) then
              Ltree.Items[itree].StateIndex := pressruns[ipr].State;
            // ## NAN 20160329 - set plantype symbol in publication level
            if (Ltree.Items[itree].level = 4) then         // sec level
            begin
                pubNode := Ltree.Items[itree].Parent.Parent;   // pub level
                if ( pubNode <> nil) then
                begin
                  case (pressruns[ipr].PlanType) of
                    3: pubNode.ImageIndex := ICON_PLANRED;
                    2: pubNode.ImageIndex := ICON_PLANYELLOW;
                    0: pubNode.ImageIndex := ICON_PLANUNAPPLIED;
                    1: pubNode.ImageIndex := ICON_PLANAPPLIED;
                  end;
                  pubNode.selectedindex := pubNode.ImageIndex;
                  TTreeViewpagestype(pubNode.data^).PagesReady := pressruns[ipr].PagesReady;
                  TTreeViewpagestype(pubNode.data^).PagesIllegal := pressruns[ipr].PagesIllegal;

                end;

            end;
        end;
      end;
    end;
     writeMainlogfile('Settreedata step 1 end');
    writeMainlogfile('Settreedata step 2 start ');

   // numberOfNodes := Ltree.Items.Count;
     CurItem := Ltree.Items.GetFirstNode;
   // for itree := 0 to numberOfNodes-1 do
    while CurItem <> nil do
    begin
      if (hasDoneUpdate) then
        break;
      if MainUpdateing or treeStopit then
      begin
        MainUpdateingnum := 9;
        break;
      end;

      if (CurItem.level = 1) and (CurItem.Expanded) then    // Pubdate level
      begin
        hasDoneUpdate := true;
        if not (MainUpdateing or treeStopit ) then
        begin

          For i := 1 to Nlevel3 do
          begin
            // ## NAN 20150212
            treeitemidx := level3Updt[i];
            if (treeitemidx < numberOfNodes) then
            begin
            // ## NAN 20150212
              if not setparentstate(Ltree.Items[treeitemidx]) then
                break;
             end;
          end;

          For i := 1 to Nlevel2 do
          begin
            // ## NAN 20150212
            treeitemidx := level2Updt[i];
            if (treeitemidx < numberOfNodes) then
            begin
            // ## NAN 20150212
              if not setparentstate(Ltree.Items[treeitemidx]) then
                break;
             end;
          End;
        End
        Else
          MainUpdateingnum := 10; // End if not stop

      End; // end if expanded pubdate node
      if MainUpdateing or treeStopit then
      Begin
        MainUpdateingnum := 11;
        break;
      end;
      CurItem := CurItem.GetNext;
    End;
    writeMainlogfile('Settreedata step 2 end ');
  except
       formmain.Actionproductionerror.Visible := false;
  end;
  //formmain.edit1.Text := IntToStr(secondsbetween(now,tid));

  Ltree.Color := clwhite;

  // 20211113
  Ltree.Items.EndUpdate;
 //            Ltree.Visible := true;
  writeMainlogfile('Settreedata end');
end;



procedure TWorkerThreadTreeUpdate.GetTreeData;
Var
  n : ttreenode;
Begin
try
begin
  n := nil;
  if formmain.PageControlMain.ActivePageIndex < 5 then
  begin
    TreeSelpubdate := 0;
    TreeSelpubid   := -1;
    case formmain.PageControlMain.ActivePageIndex of
      VIEW_SEPARATIONS :
          begin
            if formmain.TreeViewpagelist.Selected = nil then exit;
            n := formmain.TreeViewpagelist.Selected;
          end;
      VIEW_THUMBNAILS :
          begin
            if formmain.TreeViewThumbs.Selected = nil then exit;
            n := formmain.TreeViewThumbs.Selected;
          end;
      VIEW_PLATES :
          begin
            if formmain.TreeViewPlateview.Selected = nil then exit;
            n := formmain.TreeViewPlateview.Selected;
          end;
      VIEW_PRODUCTIONS :
          Begin
            n := formmain.TreeViewprodcontrol.Selected;
          end;
      VIEW_EDITIONS :
          begin
            if formmain.TreeViewNeweddtree.Selected = nil then exit;
            n := formmain.TreeViewNeweddtree.Selected;
          end;
    end;
    IF (formmain.PageControlMain.ActivePageIndex = VIEW_PLATES) and (n <> nil)  then
    begin
      While n.Level > 0 do
      begin
        Case TTreeViewpagestype(n.data^).Kind of //0=all,1=location,2=publication,pubdate,3=issue,4=edition,5=section
          1 : TreeSelpubdate := TTreeViewpagestype(n.data^).pubdate;
          2 : TreeSelpubid := TTreeViewpagestype(n.data^).publicationid;
        end;
        n := n.Parent;
      end;
    end
    else
    begin
      While n.Level > 0 do
      begin
        Case TTreeViewpagestype(n.data^).Kind of //0=all,1=location,2=publication,pubdate,3=issue,4=edition,5=section
          1 : TreeSelpubdate := TTreeViewpagestype(n.data^).pubdate;
          2 : TreeSelpubid := TTreeViewpagestype(n.data^).publicationid;
        end;
        n := n.Parent;
      end;
    end;
     While n.Level > 0 do
     begin
        Case TTreeViewpagestype(n.data^).Kind of //0=all,1=location,2=publication,pubdate,3=issue,4=edition,5=section
          1 : GSelpubdate := TTreeViewpagestype(n.data^).pubdate;
          2 : GSelpubid := TTreeViewpagestype(n.data^).publicationid;
        end;
        n := n.Parent;
      end;
  End;
  end;
   Except
  end;
End;

procedure TWorkerThreadTreeUpdate.LookForProductionError;
Var
  aerror : Boolean;
Begin
(*
GSelpubdate : tdatetime;
  GSelpubid : Integer;
  CurrentLocationid
*)
  aerror := false;
  try
    (*
    if (secondsbetween(LookForProducerrorTimeBlink,now) > 2) and (formmain.Actionproductionerror.Visible) then
    begin
      if formmain.Actionproductionerror.ImageIndex = 274 then
        formmain.Actionproductionerror.ImageIndex := 275
      else
        formmain.Actionproductionerror.ImageIndex := 274;
      LookForProducerrorTimeBlink := now;
    end;
    *)
    IF (SecondsBetween(LookForProducerrorTime,Now) > 20) OR (LookForProducerrorNow) then
    begin
      LookForProducerrorNow := false;
      if giveproductionwarning then
      begin
        IF (formmain.PageControlMain.ActivePageIndex <= VIEW_PLATES) and (GSelpubid > 0) and (giveproductionwarning) then
        begin

          if statuswarningstr <> '(-999)' then
          begin
            datam1.SQLQueryTreethread.SQL.Clear;                                                    //,productionid,publicationid,pubdate

            datam1.SQLQueryTreethread.SQL.add('select top 1 status from pagetable (NOLOCK)');
            datam1.SQLQueryTreethread.SQL.add('where publicationid = ' + IntToStr(GSelpubid));
            datam1.SQLQueryTreethread.SQL.add('and '+DataM1.makedatastr('',GSelpubdate));
            datam1.SQLQueryTreethread.SQL.add('and status IN '+statuswarningstr+' ');
            DataM1.SQLQueryTreethread.SQL.add('And active = 1');
            DataM1.SQLQueryTreethread.SQL.add('And pagetype <> 3 ');
            IF Prefs.debug then datam1.SQLQueryTreethread.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'prodwarnstat.sql');
            datam1.SQLQueryTreethread.Open;
            if not datam1.SQLQueryTreethread.eof then
            begin
              aerror := true;
            end;
            datam1.SQLQueryTreethread.Close;
          End;
          if (extstatuswarningstr <> '(-999)') and (not aerror) then
          begin
            datam1.SQLQueryTreethread.SQL.Clear;                                                    //,productionid,publicationid,pubdate

            datam1.SQLQueryTreethread.SQL.add('select top 1 ExternalStatus from pagetable (NOLOCK)');
            datam1.SQLQueryTreethread.SQL.add('where publicationid = ' + IntToStr(GSelpubid));
            datam1.SQLQueryTreethread.SQL.add('and '+DataM1.makedatastr('',GSelpubdate));
            datam1.SQLQueryTreethread.SQL.add('and ExternalStatus IN '+extstatuswarningstr+' ');
            DataM1.SQLQueryTreethread.SQL.add('And active = 1');
            DataM1.SQLQueryTreethread.SQL.add('And pagetype <> 3 ');
            IF Prefs.debug then datam1.SQLQueryTreethread.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'prodwarnEXTstat.sql');
            datam1.SQLQueryTreethread.open;
            if not datam1.SQLQueryTreethread.eof then
            begin
              aerror := true;
            end;
            datam1.SQLQueryTreethread.close;
          End;
          if (Prefs.WarnIfAnyDisapproved)  and (not aerror) then
          begin
            datam1.SQLQueryTreethread.SQL.Clear;                                                    //,productionid,publicationid,pubdate
            datam1.SQLQueryTreethread.SQL.add('SELECT top 1 Approved from pagetable (NOLOCK)');
            datam1.SQLQueryTreethread.SQL.add('where publicationid = ' + IntToStr(GSelpubid));
            datam1.SQLQueryTreethread.SQL.add('and '+DataM1.makedatastr('',GSelpubdate));
            datam1.SQLQueryTreethread.SQL.add('and Approved = 2 ');
            DataM1.SQLQueryTreethread.SQL.add('And active = 1');
            DataM1.SQLQueryTreethread.SQL.add('And pagetype <> 3 ');
            IF Prefs.debug then datam1.SQLQueryTreethread.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'prodwarnAppr.sql');
            datam1.SQLQueryTreethread.open;
            if not datam1.SQLQueryTreethread.eof then
            begin
              aerror := true;
            end;
            datam1.SQLQueryTreethread.close;
          end;
          if formmain.Actionproductionerror.Visible <> aerror then
          begin
            Newvisi := aerror;
            Synchronize(Setproderrorvisibil);
          end;
        end;
      end;
      LookForProducerrorTime := now;
    end;
  except
    formmain.Actionproductionerror.Visible := false;
  end;
end;

procedure TWorkerThreadTreeUpdate.Setproderrorvisibil;
Begin
  try
    formmain.Actionproductionerror.Visible := Newvisi;
  except
  end;
end;


procedure TWorkerThreadTreeUpdate.lookforhoney;
Var
  F: TSearchRec;
  P,T : String;
  Alist,flist    : TStrings;
  i : Integer;
  maxpageindex   : Integer;
  newestFileTime : Integer;
  newestFile     : string;
  secnumber      : Integer;
 // SectionID      : Integer;
  foundsec,foundpage,foundproduct,foundpubdate, foundedition : Boolean;
  NewPublicationID : Integer;
  NewPubDate : TDateTime;
  aktfilename,tmpstr : String;
  Afiletime,Ahightime : Tdatetime;
  R,Nfoundfiles,pageno,aktmaster,NMachinegun1,NMachinegun2,nrepeats : Integer;
  smallestfiletimedif,aktfiletimedif,highnumber,filenumber : int64;
  (*foundfiles : Array[1..500] of record
                                  filename : string;
                                  number : Integer;
                                End;
    *)
function CountFiles : Integer;
var
	Rec : TSearchRec;
	nFileCount : Integer;
	foo : string;
begin
  newestFile := '';
  newestFileTime := 0;
	nFileCount := 0;
 // Flist.Clear;
  if (Flist = nil) then
    Flist := TStringList.Create;
  Flist.Clear;
	if FindFirst(p + '*.GUS', faAnyFile, Rec) = 0 then
	begin
		repeat
			if ((Rec.Attr and faDirectory) <> faDirectory) then
      Begin
        // NAN
        if(Rec.Time > newestFileTime) then
        Begin
          newestFileTime :=  Rec.Time;
          newestFile := Rec.Name;
        End;
        // NAN
				Inc(nFileCount);
        Flist.add(Rec.Name);
      End;
		until FindNext(Rec) <> 0;
		FindClose(Rec);
	end;
	Result := nFileCount;
end;

Begin
  try
    NewPublicationID := 0;
    pageno := 0;
    if (Prefs.UseHoneywell) And (Prefs.PathToHoneywell <> '') then
    begin
      if (formmain.PageControlMain.ActivePageIndex = VIEW_THUMBNAILS) and
         ((formmain.active or formmain.showing) or (Formprev2.active or formprev2.showing) ) and (LookForhonneywherestr <> '') then
      Begin
       P := includetrailingbackslash(Prefs.PathToHoneywell);
        NMachinegun1 :=  CountFiles;
        if (formmain.TreeViewThumbs.Selected <> nil) and (NMachinegun1>0) then
        begin
          foundsec := false;
          foundpage := false;
          foundproduct := false;
          foundpubdate := false;
          foundedition := false;
          aktfilename := '';
          Nfoundfiles := 0;
          Ahightime := encodedatetime(2099,1,1,1,1,1,1);
          NewPubDate := encodedatetime(1975,1,1,0,0,0,0);

          // NAN
          aktfilename := p + newestFile;
          (*
          Flist := TStringList.Create;
          NMachinegun1 := CountFiles;
          NMachinegun2 := NMachinegun1;
          Nrepeats := 0;
          IF NMachinegun1 > 0 then
          begin
            repeat
              Sleep(1000);
              NMachinegun1 := NMachinegun2;
              NMachinegun2 := CountFiles;
              Inc(Nrepeats);
            until (Nrepeats > 20) or (NMachinegun2 = NMachinegun1);
          end;
          IF Flist.count > 0 then
          begin
            aktfilename := p+Flist[Flist.count-1];
          end;
          *)
          IF aktfilename <> '' then
          begin
            Alist := TStringList.Create;
            alist.LoadFromFile(aktfilename);
            secnumber := 1;
            For i := 0 to alist.Count-1 do
            begin
              T := uppercase(alist[i]);
              While pos('\',T) > 0 do
                delete(t,pos('\',T),1);
              if pos('PRODUCT',T) > 0 then
              begin
                tmpstr := copy(t,9,100);
                Trim(tmpstr);
                NewPublicationID := tnames1.publicationNameToID(tmpstr);
                if ( NewPublicationID > 0) then
                   foundproduct := true;
              end;
              if pos('PUBLDATE',T) > 0 then
              begin
                tmpstr := copy(t,10,100);
                Trim(tmpstr);
                IF DataM1.Stringtopubdate('YYYYMMDD',tmpstr,NewPubdate) then
                   foundPubDate := true;
              end;
              if pos('SECTION',T) > 0 then
              begin
                tmpstr := copy(t,9,100);
                try
                 //secnumber := tmpstr;
                  secnumber := StrToInt( tmpstr);
                  foundsec := true;
                except
                end;
              end;
              if pos('PAGENO',T) > 0 then
              begin
                tmpstr := copy(t,8,100);
                try
                  pageno := StrToInt(tmpstr);
                  foundpage := true;
                except
                end;
              end;
            end;
            alist.free;
            deletefile(aktfilename);
            // NAN: Delete all files in folder...
            for i := 0 to Flist.count-1 do
              deletefile(p + Flist[i]);
            // Check if we received a new product GUS file..
            IF foundPubDate AND foundProduct then
            begin
                foundProduct := false;
                datam1.SQLQueryTreethread.SQL.Clear;
                datam1.SQLQueryTreethread.SQL.add('select TOP 1 ProductionID from pagetable (NOLOCK) WHERE Dirty=0 AND PublicationID='+ IntToStr(NewPublicationID));
                datam1.SQLQueryTreethread.SQL.add('and '+DataM1.makedatastr('',NewPubdate));
                datam1.SQLQueryTreethread.open;
                If not datam1.SQLQueryTreethread.eof then
                begin
                  foundProduct := true;
                end;
                datam1.SQLQueryTreethread.close;
                if (foundProduct) then
                begin
                   LookForhonneypublid := NewPublicationID;
                   LookForhonneypubldate := NewPubdate;
                   Formmain.SelectSpecificThumbTreeNode(tnames1.publicationIDToName(LookForhonneypublid), datetostr(LookForhonneypubldate));
                end;
            end;
            IF foundpage and foundsec then
            begin
              aktmaster := -1;
              maxpageindex := 9999;
              //Find SectionID
             (* datam1.SQLQueryTreethread.sql.Clear;
              datam1.SQLQueryTreethread.SQL.Add('select SectionID from SectionNames (NOLOCK)');
              datam1.SQLQueryTreethread.SQL.Add(    'where Name = ''' + secnumber + '''');
              datam1.SQLQueryTreethread.Open;
              if NOT datam1.SQLQueryTreethread.Eof then
                SectionID := datam1.SQLQueryTreethread.FieldByName('SectionID').AsInteger;
              datam1.SQLQueryTreethread.Close;  *)
              datam1.SQLQueryTreethread.SQL.Clear;                                                    //,productionid,publicationid,pubdate
              datam1.SQLQueryTreethread.SQL.add('select MAX(pageindex) from pagetable (NOLOCK)');
              datam1.SQLQueryTreethread.SQL.add('where publicationid = ' + IntToStr(LookForhonneypublid));
          //    if (SectionID >0) then
          //      datam1.SQLQueryTreethread.SQL.add('And sectionid = ' + IntToStr(SectionID));
          // Old KCH style!! !!  Ugly SECTION in Honeyweel file = ID in DB..!
              IF secnumber > 0 then
                datam1.SQLQueryTreethread.SQL.add('And sectionid = ' + IntToStr(secnumber));
              IF LookForhonneyeditionid > 0 then
                datam1.SQLQueryTreethread.SQL.add('And active = 1 And pagetype <> 3 and editionid = ' + IntToStr(LookForhonneyeditionid));
              datam1.SQLQueryTreethread.SQL.add('and '+DataM1.makedatastr('',LookForhonneypubldate));
              if Prefs.debug then datam1.SQLQueryTreethread.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'Honey1.sql');
              datam1.SQLQueryTreethread.open;
              maxpageindex := datam1.SQLQueryTreethread.fields[0].asinteger;
              datam1.SQLQueryTreethread.Close;
              IF pageno > maxpageindex then
                pageno := maxpageindex;
              datam1.SQLQueryTreethread.SQL.Clear;                                                    //,productionid,publicationid,pubdate
              datam1.SQLQueryTreethread.SQL.add('Select TOP 1 mastercopyseparationset from pagetable (NOLOCK)');
              datam1.SQLQueryTreethread.SQL.add('where publicationid = ' + IntToStr(LookForhonneypublid));
//              IF secnumber <> '0' then
              //if (SectionID >0) then
               // datam1.SQLQueryTreethread.SQL.add('And sectionid = ' + IntToStr(SectionID));
               // Old KCH style!!  Ugly SECTION in Honeyweel file = ID in DB..!
              IF secnumber > 0 then
                datam1.SQLQueryTreethread.SQL.add('And sectionid = ' + IntToStr(secnumber));
              IF LookForhonneyeditionid > 0 then
                datam1.SQLQueryTreethread.SQL.add('and editionid = ' + IntToStr(LookForhonneyeditionid));
              datam1.SQLQueryTreethread.SQL.add('and '+DataM1.makedatastr('',LookForhonneypubldate));
              datam1.SQLQueryTreethread.SQL.add('and pageindex = ' + IntToStr(pageno));
              //if debug then datam1.SQLQueryTreethread.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'Honey1.sql');
              datam1.SQLQueryTreethread.Open;
              If not datam1.SQLQueryTreethread.eof then
              begin
                aktmaster := datam1.SQLQueryTreethread.fields[0].asinteger;
              end;
              datam1.SQLQueryTreethread.Close;
              For i := 0 to formmain.PBExListviewthumbnail.Items.Count-1 do
              begin
                formmain.PBExListviewthumbnail.Items[i].Selected := false;
                IF Showthubms[i].mastercopyseparationset = aktmaster then
                begin
                  formmain.PBExListviewthumbnail.Items[i].Selected := true;
                end;
              end;
              formprev2.specificmaster := aktmaster;
              formmain.Timershowprev.Enabled := true;
            end;
          end;
        end;
      End
      Else
      begin

      end;
    End;
  Except
  end;
End;


end.
