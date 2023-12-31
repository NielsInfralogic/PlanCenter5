unit USeprationlist;
interface
uses
  SysUtils, Classes,FMTBcd, SqlExpr,
  DB, Graphics, Controls, Forms ;
Procedure DOAutorefreshseparations;
Procedure DOloadSuperHSDB2(autosizecols : Boolean);
Procedure DOclearhs;
procedure DOHSToExcel;
procedure DOresetsuperhsselection;
function Dogetfirstselectedhs:Longint;
procedure DOdoseparationsapproval;
procedure DoresetpreselHS;
procedure DOdoseparationsReapproval;
procedure DodoseparationsAutoapproval;
procedure DODOPageDisapproveExecute;
procedure DODoPageHoldExecute;
procedure DODoPagereleaseExecute(Onlymono : Boolean);
Procedure DOreleaseonseprationset;

implementation

Uses
  Umain,utypes,udata,usettings,ComCtrls,ulogin,Ualfalist,Uflatproof,ComObj,DateUtils, UUtils;


Procedure DOclearhs;
Var
  I : Longint;
Begin
  try
    StringGridHSempty := true;
    formmain.StringGridHS.rowcount := 2;
    For i := 0 to formmain.StringGridHS.ColCount-1 do
    begin
      formmain.StringGridHS.cells[i,1] := '';
    end;
  Except
  end;
end;

Procedure DOAutorefreshseparations;
Function makeatimestr(Adatetime : tdatetime):string;
Begin
  result := '';
  if Prefs.SeparationsUseLocaleTimeFormat then
    result :=  Prefs.MakeDateTimeString(Adatetime)
  else
  begin
    try
      IF Adatetime > encodedate(1970,1,1) then
        result := formatdatetime(Prefs.SeparationTimeFormat,Adatetime)
      else
        result := '';
    Except
      result := Prefs.MakeDateTimeString(Adatetime)
    end;
  end;
end;
Procedure applynewdata(DataI : Longint);
Var
  RowI,I : Longint;
  rowchanged : boolean;
  T : string;
Begin
  try
    RowI := DataI +1;
    rowchanged := false;
    if (SuperHSdata[DataI].status <> DataM1.Queryautorefresh1.fields[0].asinteger) and
       (hscols[0].colx < formmain.StringGridHS.ColCount-9) then
    begin
      SuperHSdata[DataI].status := DataM1.Queryautorefresh1.fields[0].asinteger;
      formmain.StringGridHS.cells[hscols[0].colx,RowI] := statusarray[SuperHSdata[DataI].status].name;
      rowchanged := true;
    end;
    if (SuperHSdata[DataI].approved <> DataM1.Queryautorefresh1.fields[2].asinteger) and
       (hscols[16].colx < formmain.StringGridHS.ColCount-9) then
    begin
      SuperHSdata[DataI].approved := DataM1.Queryautorefresh1.fields[2].asinteger;
      formmain.StringGridHS.cells[hscols[16].colx,RowI] := apprnamearray[SuperHSdata[DataI].approved+1];
      rowchanged := true;
    end;
    if (SuperHSdata[DataI].Hold <> DataM1.Queryautorefresh1.fields[3].asinteger) and
       (hscols[17].colx < formmain.StringGridHS.ColCount-9) then
    begin
      SuperHSdata[DataI].hold := DataM1.Queryautorefresh1.fields[3].asinteger;
      formmain.StringGridHS.cells[hscols[17].colx,RowI] := Holdrealesarray[SuperHSdata[DataI].hold];
      rowchanged := true;
    end;
    if (hscols[12].colx < formmain.StringGridHS.ColCount-9) then
    begin
      if formmain.StringGridHS.cells[hscols[12].colx,RowI] <> DataM1.Queryautorefresh1.fields[4].asstring then
      begin
        formmain.StringGridHS.cells[hscols[12].colx,RowI] := DataM1.Queryautorefresh1.fields[4].asstring;
        rowchanged := true;
      end;
    End;
    if (hscols[46].colx < formmain.StringGridHS.ColCount-9) then
    begin
      if formmain.StringGridHS.cells[hscols[46].colx,RowI] <> DataM1.Queryautorefresh1.fields[5].asstring then
      begin
        formmain.StringGridHS.cells[hscols[46].colx,RowI] := DataM1.Queryautorefresh1.fields[5].asstring;
        rowchanged := true;
      end;
    End;
    if (SuperHSdata[DataI].DEVICEID <> DataM1.Queryautorefresh1.fields[6].asinteger) and
       (hscols[11].colx < formmain.StringGridHS.ColCount-9) then
    begin
      SuperHSdata[DataI].deviceid := DataM1.Queryautorefresh1.fields[6].asinteger;
      formmain.StringGridHS.cells[hscols[11].colx,RowI] := tnames1.deviceidtoname(SuperHSdata[DataI].deviceid);
      rowchanged := true;
    end;
    if (hscols[59].colx < formmain.StringGridHS.ColCount-9) then
    begin
      if formmain.StringGridHS.cells[hscols[59].colx,RowI] <> DataM1.Queryautorefresh1.fields[20].Asstring then
      begin
        formmain.StringGridHS.cells[hscols[59].colx,RowI] := DataM1.Queryautorefresh1.fields[20].Asstring;
        rowchanged := true;
      end;
    End;
    if (hscols[1].colx < formmain.StringGridHS.ColCount-9) then
    begin
      if formmain.StringGridHS.cells[hscols[1].colx,RowI] <> Externalstatusarray[DataM1.Queryautorefresh1.fields[7].Asinteger].name then
      begin
        formmain.StringGridHS.cells[hscols[1].colx,RowI] := Externalstatusarray[DataM1.Queryautorefresh1.fields[7].Asinteger].name;
        rowchanged := true;
      end;
    End;

    if (SuperHSdata[DataI].InkStaus <> DataM1.Queryautorefresh1.fields[8].asinteger) and
       (hscols[35].colx < formmain.StringGridHS.ColCount-9) then
    begin
      SuperHSdata[DataI].InkStaus := DataM1.Queryautorefresh1.fields[8].asinteger;
      formmain.StringGridHS.cells[hscols[35].colx,RowI] := Inkstatusarray[SuperHSdata[DataI].InkStaus];
      rowchanged := true;
    end;
    if (SuperHSdata[DataI].Unique <> DataM1.Queryautorefresh1.fields[9].asinteger) and
       (hscols[38].colx < formmain.StringGridHS.ColCount-9) then
    begin
      SuperHSdata[DataI].Unique := DataM1.Queryautorefresh1.fields[9].asinteger;
      formmain.StringGridHS.cells[hscols[38].colx,RowI] := Uniquearray[SuperHSdata[DataI].unique];
      rowchanged := true;
    end;
    if (hscols[48].colx < formmain.StringGridHS.ColCount-9) then
    begin
      if formmain.StringGridHS.cells[hscols[48].colx,RowI] <> DataM1.Queryautorefresh1.fields[10].asstring then
      begin
        formmain.StringGridHS.cells[hscols[48].colx,RowI] := DataM1.Queryautorefresh1.fields[10].asstring;
        rowchanged := true;
      end;
    End;
    For I := 51 to 55 do
    begin
      if (hscols[I].colx < formmain.StringGridHS.ColCount-9) then
      begin
        //InputTime,ApproveTime,ReadyTime,OutputTime,VerifyTime
        T := makeatimestr(DataM1.Queryautorefresh1.fields[I-40].asdatetime);
        if formmain.StringGridHS.cells[hscols[I].colx,RowI] <> T then
        begin
          formmain.StringGridHS.cells[hscols[I].colx,RowI] := T;
          rowchanged := true;
        end;
      End;
    End;
    if (hscols[69].colx < formmain.StringGridHS.ColCount-9) then
    begin
      if formmain.StringGridHS.cells[hscols[69].colx,RowI] <> DataM1.Queryautorefresh1.fields[16].asstring then
      begin
        formmain.StringGridHS.cells[hscols[69].colx,RowI] := DataM1.Queryautorefresh1.fields[16].asstring;
        rowchanged := true;
      end;
    End;
    if (hscols[19].colx < formmain.StringGridHS.ColCount-9) then
    begin
      if formmain.StringGridHS.cells[hscols[19].colx,RowI] <> DataM1.Queryautorefresh1.fields[17].asstring then
      begin
        formmain.StringGridHS.cells[hscols[19].colx,RowI] := DataM1.Queryautorefresh1.fields[17].asstring;
        rowchanged := true;
      end;
    End;

    (*    //flatproof kan vente den bliver allige vel aldrig brugt
    if (hscols[41].colx < formmain.StringGridHS.ColCount-9) then
    begin
      T := Formflatproof.flatproofconfigtostr(DataM1.Queryautorefresh1.fields[19].asinteger);
      if formmain.StringGridHS.cells[hscols[41].colx,RowI] <> T then
      begin
        formmain.StringGridHS.cells[hscols[41].colx,RowI] := T;
        rowchanged := true;
      end;
    End;
    *)
  Except
  end;

end;

Var
  AktRow,i : Longint;
  aktseparation : int64;
  foundrow : Boolean;
begin
  DataM1.Queryautorefresh1.SQL.Clear;   //  0       1            2      3       4            5           6               7                 8                 9          10             11          12         13       14          15         16           17         18         19            20
  DataM1.Queryautorefresh1.SQL.Add('Select p1.status,p1.proofstatus,p1.approved,p1.hold,p1.version,p1.outputversion,p1.deviceid,p1.externalstatus,p1.InkStatus,p1.UniquePage,p1.HardProofStatus,p1.InputTime,p1.ApproveTime,');
  DataM1.Queryautorefresh1.SQL.Add('p1.ReadyTime,p1.OutputTime,p1.VerifyTime,p1.OutputPriority,p1.priority,p1.separation,p1.flatproofstatus,p1.comment');
  DataM1.Queryautorefresh1.SQL.Add('from pagetable p1 (NOLOCK), colornames (NOLOCK) ,pressrunid pr (NOLOCK) ' );
  for i := 1 to NAutoSelectionstrings do
    DataM1.Queryautorefresh1.SQL.Add(AutoSelectionstrings[i]);
  for i := 1 to NAutoOrderbystrings do
    DataM1.Queryautorefresh1.SQL.Add(AutoOrderbystrings[i]);
  IF Prefs.debug then datam1.Queryautorefresh1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'AutorefreshSQLsql.sql');
  AktRow := 1;
  DataM1.Queryautorefresh1.open;
  While not DataM1.Queryautorefresh1.eof do
  begin
    IF (mainrefreshing) or (not formmain.ActionCHKpageautorefresh.Checked) then break;
    aktseparation := DataM1.Queryautorefresh1.fields[18].asvariant;
    //F�rst pr�v fra aktrow det kan g� hurtigere
    foundrow := false;
    for i := AktRow to formmain.StringGridHS.RowCount do
    begin
      IF (mainrefreshing) or (not formmain.ActionCHKpageautorefresh.Checked) then break;
      IF SuperHSdata[i-1].Separation = aktseparation then
      begin
        applynewdata(i-1);
        foundrow := true;
        Inc(AktRow);
        break;
      End;
    end;
    IF (mainrefreshing) or (not formmain.ActionCHKpageautorefresh.Checked) then break;
    IF not foundrow then
    Begin
      AktRow := 1;
      for i := AktRow to formmain.StringGridHS.RowCount do
      begin
        IF (mainrefreshing) or (not formmain.ActionCHKpageautorefresh.Checked) then break;
        IF SuperHSdata[i-1].Separation = aktseparation then
        begin
          applynewdata(i-1);
          foundrow := true;
          Inc(AktRow);
          break;
        End;
      end;
    end;
    IF (mainrefreshing) or (not formmain.ActionCHKpageautorefresh.Checked) then break;
    DataM1.Queryautorefresh1.next;
  end;
  DataM1.Queryautorefresh1.close;
end;

Procedure DOloadSuperHSDB2(autosizecols : Boolean);

Var
  pidxinuse : boolean;
  I,I1 : Integer;
  orderstr,T,T2 : string;
  addcol : boolean;
  n : ttreenode;
  ANmarks : Integer;
  Amarks : marksarray;
  wherestr : string;
  descstr : String;
  ndebugadd,nitemadd : Longint;
  Showingall : Boolean;
  ipre,NDDD,iddd : Longint;
  DDD : Array of record
                   cols : Array[1..50] of string;
                 end;
  ltime : Tdatetime;
  aktoprowsep,akttoprow : longint;
  Nreselection : Longint;
  reselection : array of longint;
  Foundany : boolean;
  L : Tlistitem;
  pagetlborder : String;
  Buf : THSdatatype;
  prewherestr : String;
  aktfieldpos,Nmanfields : Longint;
  aktmaster,fromfieldcount : Longint;
  aktevent,maxsub : Longint;
  akteventtime : tdatetime;
  aktmessage,FieldsinT : string;
  akteventname : String;
  atime,starttime,maxcol : tdatetime;
  ProductionName : string;
Begin
  ProductionName := '';
  starttime := now;
  mainrefreshing := true;
  Showingall := false;
  LookForProducerrorNow := true;
  NaktHScols := Prefs.NcolsSeparationView;
  aktoprowsep := -1;
  akttoprow := -1;
  try
    IF formmain.StringGridHS.TopRow > 1 then
    begin
      akttoprow := formmain.StringGridHS.TopRow;
      aktoprowsep := SuperHSdata[formmain.StringGridHS.TopRow].Separation;
    end;
  Except
  end;
  IF (Prefs.SeparationsReselectPages) then
  begin
    Nreselection := 0;
    for i := 1 to formmain.StringGridHS.RowCount do
    begin
      IF SuperHSdata[i-1].Selected then
      begin
        Inc(Nreselection);
      End;
    end;
    IF Nreselection > 0 then
      setlength(reselection,Nreselection);
    I1 := -1;
    for i := 1 to formmain.StringGridHS.RowCount do
    begin
      IF SuperHSdata[i-1].Selected then
      begin
        Inc(i1);
        reselection[i1] := SuperHSdata[i-1].Separation;
      End;
    end;
  End;
  DOclearhs;
  maxsub := -9;
  IF formmain.TreeViewpagelist.Selected = nil then exit;
  IF formmain.TreeViewpagelist.Selected.level <= 1 then
  begin
    if Prefs.SeparationsAllowShowAllPublications then
    begin
      Showingall := Prefs.ISadministrator;
    end
    Else
      exit;
  end;
  try
    ltime := now;


    try
      atime := now;
      starttime := now;
      if Prefs.FirstColumnDescentingSort then
        descstr := ' DESC,'
      else
        descstr := ',';
      LastHSsel := -1;
      screen.Cursor := crhourglass;
      formmain.StringGridHS.Visible := false;
      n := formmain.TreeViewpagelist.Selected;
      wherestr := ' and p1.pagetype <> 3';
      IF formmain.ComboBoxactive.ItemIndex = 0 then
        wherestr := wherestr + ' and p1.active = 1';
      IF (formmain.ComboBoxpalocationNy.enabled) AND (FormMain.ComboBoxpalocationNY.Text <> 'All') then
      begin
        wherestr := wherestr + ' and p1.locationid = ' + inttostr(tnames1.locationnametoid(formmain.ComboBoxpalocationNy.items[formmain.ComboBoxpalocationNy.ItemIndex]));
      end;
      if (Pressvisibilylimited) (*AND (Prefs.LimitPresses)*) then
      begin
        wherestr := wherestr + ' and p1.pressid IN ' + PressvisibilyIN;
      end;

      IF formmain.ComboBoxStatus.Itemindex > 0 then
      begin
        Case formmain.ComboBoxStatus.Itemindex of
          1 : wherestr := wherestr + ' and p1.status > 0';
          2 : wherestr := wherestr + ' and p1.status < 30';
          3 : wherestr := wherestr + ' and p1.status < 50';
          4 : wherestr := wherestr + ' and p1.status in (6,16,26,36,46,56)';
          else
          begin
            wherestr := wherestr + ' and p1.status = ' + inttostr(inittypes.getstatuscodefromname(formmain.ComboBoxStatus.Items[formmain.ComboBoxStatus.Itemindex]));
          end;
        end;
      end;
      Case formmain.ComboBoxapproval.itemindex of
        1 : wherestr := wherestr + ' and p1.approved in (0,2)';
        2 : wherestr := wherestr + ' and p1.approved in (-1,1)';
        3 : wherestr := wherestr + ' and p1.approved = 2';
      end;
      IF formmain.ComboBoxPagescopies.itemindex > 0 then
      begin
        wherestr := wherestr + ' and p1.copynumber = ' + formmain.ComboBoxPagescopies.text;
      end;
      Case formmain.ComboBoxhold.itemindex of
        1 : wherestr := wherestr + ' and p1.hold = 1';
        2 : wherestr := wherestr + ' and p1.hold = 0';        // OK  - select command
      End;

      prewherestr := ' and p1.pagetype <> 3';
      IF formmain.ComboBoxactive.ItemIndex = 0 then
        prewherestr := prewherestr + ' and p1.active = 1';
      IF formmain.ComboBoxpalocationNY.enabled AND (FormMain.ComboBoxpalocationNY.Text <> 'All') then
      begin
        prewherestr := prewherestr + ' and p1.locationid = ' + inttostr(tnames1.locationnametoid(formmain.ComboBoxpalocationNy.items[formmain.ComboBoxpalocationNy.ItemIndex]));
      end;
      if (Pressvisibilylimited) (*AND (Prefs.LimitPresses)*) then
      begin
        prewherestr := prewherestr + ' and p1.pressid IN ' + PressvisibilyIN;
      end;


      (*IF formmain.ComboBoxPressGrp.Itemindex > 0 then
      begin
        prewherestr := prewherestr + ' and p1.pressid = ' + inttostr(tnames1.pressnametoid(formmain.ComboBoxpagepress.items[formmain.ComboBoxpagepress.ItemIndex]));
      end;
      *)
      While n.Level > 0 do
      begin
        Case TTreeViewpagestype(n.data^).Kind of
          4 : Begin
                wherestr := wherestr + ' and p1.editionid = ' + inttostr(TTreeViewpagestype(n.data^).editionid);
                prewherestr := prewherestr + ' and p1.editionid = ' + inttostr(TTreeViewpagestype(n.data^).editionid);
              End;
          5 : Begin
                wherestr := wherestr + ' and p1.sectionid = ' + inttostr(TTreeViewpagestype(n.data^).sectionid);
                prewherestr := prewherestr + ' and p1.sectionid = ' + inttostr(TTreeViewpagestype(n.data^).sectionid);
              End;
        end;
        n := n.Parent;
      end;
      pidxinuse := false;
      DataM1.Query1.SQL.Clear;
      DataM1.Query1.SQL.add('SELECT PN.Name FROM ProductionNames PN WITH (NOLOCK) INNER JOIN PageTable P WITH (NOLOCK) ON P.ProductionID=PN.ProductionID ');
      DataM1.Query1.SQL.add('WHERE P.PublicationID= ' + IntToStr(GSelpubid));
      DataM1.Query1.SQL.add(' AND ' + DataM1.makedatastr('P.',GSelpubdate));

      // 20230811 - fix picking up wrong productionname if made on two presses..
      IF (formmain.ComboBoxPressGrp.itemindex > 0) OR (Pressvisibilylimited) then
      begin
        DataM1.Query1.SQL.add(' and P.pressid IN ' + PressvisibilyIN);
      end;
      FormMain.tryopen(datam1.Query1);

      if not datam1.Query1.eof then
        ProductionName := datam1.Query1.fields[0].AsString;
      DataM1.Query1.Close;

      formmain.StringGridHS.ColCount := NaktHScols+10;
      formmain.StringGridHS.RowCount := 2;
      DataM1.Query1.SQL.Clear;
      DataM1.Query1.SQL.add('Select Count(p1.separation) as tal from pagetable p1 (NOLOCK)');
      DataM1.Query1.SQL.add('where p1.dirty = 0 ');
      IF GSelpubdate > 0 then
        DataM1.Query1.SQL.add(' and ' + DataM1.makedatastr('p1.',GSelpubdate));
      IF Not Showingall then
      begin
        DataM1.Query1.SQL.add(' and p1.publicationid = ' + inttostr(GSelpubid));
      End;
      DataM1.Query1.SQL.add(wherestr);
      datam1.Query1.SQL.Add(WP1editionStr);
      starttime := now;
      formmain.tryopen(datam1.Query1);
      starttime := now;
      IF not datam1.Query1.eof then
      begin
        NDDD := datam1.Query1.fields[0].asinteger;
      end;
      datam1.Query1.close;

      DataM1.Query1.SQL.Clear;
      DataM1.Query1.SQL.add('Select Count(p1.separation) as tal from pagetable p1 (NOLOCK)');
      DataM1.Query1.SQL.add('where p1.dirty = 0 ');
      IF GSelpubdate > 0 then
        DataM1.Query1.SQL.add(' and ' + DataM1.makedatastr('p1.',GSelpubdate));
      IF Not Showingall then
      begin
        DataM1.Query1.SQL.add(' and p1.publicationid = ' + inttostr(GSelpubid));
      End;

      IF formmain.ComboBoxPressGrp.itemindex > 0 then
      begin
        DataM1.Query1.SQL.add(' and p1.pressid IN ' + PressvisibilyIN);
      end;

      DataM1.Query1.SQL.add(wherestr);
      datam1.Query1.SQL.Add(WeditionStr);
      if Prefs.debug then
        DataM1.Query1.SQL.savetofile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'SQLCountQuerypage.SQL');
      formmain.tryopen(datam1.Query1);

      IF not datam1.Query1.eof then
      begin
        NDDD := datam1.Query1.fields[0].asinteger;
      end;
      datam1.Query1.close;

      IF NDDD + 1 < 2 then
        formmain.StringGridHS.RowCount := 2
      else
        formmain.StringGridHS.RowCount := NDDD + 1;
      DataM1.SQLQuerypage.SQL.Clear;
      for i := 0 to 200 do
      begin
        HSCols[i].inlist := false;
      end;
      T := ' ';
      for i := 0 to NaktHScols do
      begin
        T := T + HSCols[HSOrder[i]].field+ ',';
        HSCols[HSOrder[i]].inlist := true;
        HSCols[HSOrder[i]].fieldpos := i;
      end;

      T := T + 'p1.mastercopyseparationset,p1.copyseparationset,p1.separationset,p1.separation,p1.copyflatseparationset,p1.flatseparationset,p1.flatseparation,colorname,pr.pressrunid';
      IF PDFMASTEROK then
        T := T + ',p1.pdfmaster'
      Else
        T := T + ',p1.mastercopyseparationset';
      I := 0;
      FieldsinT := T;
      while pos(',',FieldsinT) > 0 do
      begin
        Inc(I);
        delete(FieldsinT,1,pos(',',FieldsinT));
      end;
      fromfieldcount := i - NaktHScols;
      Nmanfields := 0;
      for i := 0 to 100 do
      begin
        if (HSCols[i].mandatory) and (not HSCols[i].inlist) then
        begin
          T := T +','+HSCols[i].field;
          HSCols[i].fieldpos := fromfieldcount+ NaktHScols+Nmanfields;
          Inc(Nmanfields);
        end;
      end;
      pagetlborder := ' ';
      pidxinuse := false;
      IF Firstsortcolnumber > 0 then
      begin
        IF (HSCols[HSOrder[Firstsortcolnumber]].Inorder)  then
        begin
          IF (HSOrder[Firstsortcolnumber] = 8)  then
          Begin
            pagetlborder := pagetlborder +  'colornames.colorname'+descstr;
          end;
          IF (HSOrder[Firstsortcolnumber] = 7) or (HSOrder[Firstsortcolnumber] = 44) then
          begin
            IF (HSOrder[Firstsortcolnumber] = 7) then
            begin
              IF (Prefs.UsePageIndexForSorting) then
              begin
                IF (not pidxinuse) then
                begin
                  pagetlborder := pagetlborder +  'p1.pageindex'+descstr;
                  pidxinuse := true;
                end;
              end
              else
              begin
                pagetlborder := pagetlborder + HSCols[HSOrder[Firstsortcolnumber]].field+descstr;
              end;
            end;
            if (HSOrder[Firstsortcolnumber] = 44) and (not pidxinuse) then
            begin
               pagetlborder := pagetlborder +  'p1.pageindex'+descstr;
               pidxinuse := true;
            end;
          end
          else
          begin
            pagetlborder := pagetlborder + HSCols[HSOrder[Firstsortcolnumber]].field;
            pagetlborder := pagetlborder +  descstr;
          end;
        End;
      end;
      for i := 0 to NaktHScols do
      begin
        IF (Firstsortcolnumber = 0) or (i <> Firstsortcolnumber) then
        begin
          IF (HSCols[HSOrder[i]].Inorder)  then
          begin
            IF (HSOrder[i] = 8)  then
            Begin
              pagetlborder := pagetlborder +  'colornames.colorname'+descstr;
            end;
            IF (HSOrder[i] = 7) or (HSOrder[i] = 44) then
            begin
              IF (HSOrder[i] = 7) then
              begin
                if (Prefs.UsePageIndexForSorting) then
                begin
                  IF (not pidxinuse) then
                  begin
                    pagetlborder := pagetlborder +  'p1.pageindex'+descstr;
                    pidxinuse := true;
                  end;
                end
                else
                begin
                  pagetlborder := pagetlborder + HSCols[HSOrder[i]].field+descstr;
                end;
              end;
              if (HSOrder[i] = 44) and (not pidxinuse) then
              begin
                 pagetlborder := pagetlborder +  'p1.pageindex'+descstr;
                 pidxinuse := true;
              end;
            end
            else
            begin
              pagetlborder := pagetlborder + HSCols[HSOrder[i]].field;
              pagetlborder := pagetlborder +  descstr;
            end;
          end
          else
          begin
          end;
        End;
      end;
      delete(pagetlborder,length(pagetlborder),1);
      DataM1.SQLQuerypage.SQL.add('Select ' + t );
      DataM1.SQLQuerypage.SQL.add( ' from pagetable p1 (NOLOCK), colornames (NOLOCK), pressrunid pr (NOLOCK)');
      DataM1.SQLQuerypage.SQL.add('where p1.dirty = 0 ');
      IF GSelpubdate > 0 then
        DataM1.SQLQuerypage.SQL.add(' and ' + DataM1.makedatastr('p1.',GSelpubdate));
      IF Not Showingall then
      begin
        DataM1.SQLQuerypage.SQL.add(' and p1.publicationid = ' + inttostr(GSelpubid));
      End;
      if Pressvisibilylimited then
        DataM1.SQLQuerypage.SQL.add(' and p1.pressid IN ' + PressvisibilyIN);

      DataM1.SQLQuerypage.SQL.add(wherestr);
      datam1.SQLQuerypage.SQL.Add(WeditionStr);
      DataM1.SQLQuerypage.SQL.add('and p1.colorid = colornames.colorid');
      DataM1.SQLQuerypage.SQL.add('and p1.pressrunid = pr.pressrunid');
      DataM1.SQLQuerypage.SQL.add('order by '+pagetlborder);
      AutoSelectionstrings[1] := 'where p1.dirty = 0 ';
      AutoSelectionstrings[2] := ' and ' + DataM1.makedatastr('p1.',GSelpubdate);
      AutoSelectionstrings[3] := ' and p1.publicationid = ' + inttostr(GSelpubid);
      AutoSelectionstrings[4] := wherestr;
      AutoSelectionstrings[5] := WeditionStr;
      AutoSelectionstrings[6] := 'and p1.colorid = colornames.colorid';
//      NAutoSelectionstrings := 6;
      AutoSelectionstrings[7] := 'and p1.pressrunid = pr.pressrunid';
      NAutoSelectionstrings := 7;
      IF Formmain.ComboBoxPressGrp.ItemIndex > 0 then
      begin
        AutoSelectionstrings[8] := ' and p1.pressid IN ' + PressvisibilyIN;
        NAutoSelectionstrings := 8;
      End;
      AutoOrderbystrings[1] := 'order by '+pagetlborder;
      NAutoOrderbystrings := 1;

      if Prefs.debug then
        DataM1.SQLQuerypage.SQL.savetofile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'SQLQuerypage.SQL');
      setlength(SuperHSdata,NDDD+10);
      iddd := -1;
    except
    end;
    try

      Formalfasort.anychange := false;
      Formalfasort.ListView1.Items.BeginUpdate;
      Formalfasort.ListView1.Items.Clear;
      DataM1.SQLQuerypage.open;
      For i := 0 to  DataM1.SQLQuerypage.fields.count-1 do
      begin
        T := Uppercase(DataM1.SQLQuerypage.fields[i].fieldname);
        IF pos('.',T) > 0 then
          delete(T,1,pos('.',T));
        for i1 := 0 to 116 do
        begin
          T2 := Uppercase(HSCols[ i1].field);
          IF pos('.',T2) > 0 then
            delete(T2,1,pos('.',T2));
          IF T = T2 then
          begin
            HSCols[ i1].fieldpos := i;
          end;
        End;
      end;

      While not DataM1.SQLQuerypage.eof do
      begin
        atime := now;
        inc(iddd);
        SuperHSdata[iddd].Selected := false;
        SuperHSdata[iddd].changed := false;
        SuperHSdata[iddd].ColorID  := DataM1.SQLQuerypage.fields[HSCols[8].fieldpos].asinteger;
        SuperHSdata[iddd].status   := DataM1.SQLQuerypage.fields[HSCols[0].fieldpos].asinteger;
        SuperHSdata[iddd].externalstatus   := DataM1.SQLQuerypage.fields[HSCols[1].fieldpos].asinteger;
        SuperHSdata[iddd].approved := DataM1.SQLQuerypage.fields[HSCols[16].fieldpos].asinteger;
        SuperHSdata[iddd].hold     := DataM1.SQLQuerypage.fields[HSCols[17].fieldpos].asinteger;
        SuperHSdata[iddd].active   := DataM1.SQLQuerypage.fields[HSCols[18].fieldpos].asinteger;
        SuperHSdata[iddd].Unique   := DataM1.SQLQuerypage.fields[HSCols[38].fieldpos].asinteger;
        SuperHSdata[iddd].sheet                    := DataM1.SQLQuerypage.fields[HSCols[23].fieldpos].asinteger;
        SuperHSdata[iddd].productionID             := DataM1.SQLQuerypage.fields[HSCols[32].fieldpos].asinteger;
        SuperHSdata[iddd].IssueID                  := DataM1.SQLQuerypage.fields[HSCols[5].fieldpos].asinteger;
        SuperHSdata[iddd].publicationID            := DataM1.SQLQuerypage.fields[HSCols[2].fieldpos].asinteger;
        SuperHSdata[iddd].SectionID                := DataM1.SQLQuerypage.fields[HSCols[3].fieldpos].asinteger;
        SuperHSdata[iddd].EditionID                := DataM1.SQLQuerypage.fields[HSCols[4].fieldpos].asinteger;
        SuperHSdata[iddd].locationID               := DataM1.SQLQuerypage.fields[HSCols[39].fieldpos].asinteger;
        SuperHSdata[iddd].proofID                  := DataM1.SQLQuerypage.fields[HSCols[10].fieldpos].asinteger;
        SuperHSdata[iddd].Hardproofid              := DataM1.SQLQuerypage.fields[HSCols[47].fieldpos].asinteger;
        SuperHSdata[iddd].Flatproofid              := DataM1.SQLQuerypage.fields[HSCols[40].fieldpos].asinteger;

        SuperHSdata[iddd].MasterCopySeparationSet  := DataM1.SQLQuerypage.fields[NaktHScols+1].asinteger;
        SuperHSdata[iddd].CopySeparationSet        := DataM1.SQLQuerypage.fields[NaktHScols+2].asinteger;
        SuperHSdata[iddd].SeparationSet            := DataM1.SQLQuerypage.fields[NaktHScols+3].asinteger;
        SuperHSdata[iddd].Separation               := DataM1.SQLQuerypage.fields[NaktHScols+4].asvariant;
        SuperHSdata[iddd].CopyFlatSeparationSet    := DataM1.SQLQuerypage.fields[NaktHScols+5].asinteger;
        SuperHSdata[iddd].FlatSeparationSet        := DataM1.SQLQuerypage.fields[NaktHScols+6].asinteger;
        SuperHSdata[iddd].FlatSeparation           := DataM1.SQLQuerypage.fields[NaktHScols+7].asvariant;
        SuperHSdata[iddd].TemplateID               := DataM1.SQLQuerypage.fields[HSCols[9].fieldpos].asinteger;
        SuperHSdata[iddd].DEVICEID                 := DataM1.SQLQuerypage.fields[HSCols[11].fieldpos].asinteger;
        SuperHSdata[iddd].copynumber               := SuperHSdata[iddd].SeparationSet mod (SuperHSdata[iddd].CopySeparationSet * 100);
        SuperHSdata[iddd].InkStaus                 := DataM1.SQLQuerypage.fields[HSCols[35].fieldpos].asinteger;
        SuperHSdata[iddd].pressrunid               := DataM1.SQLQuerypage.fieldbyname('pressrunid').asinteger;
        IF pdfmasterOK then
          SuperHSdata[iddd].PDFMaster                := DataM1.SQLQuerypage.fieldbyname('Pdfmaster').asinteger
        Else
          SuperHSdata[iddd].PDFMaster                := DataM1.SQLQuerypage.fieldbyname('mastercopyseparationset').asinteger;
        // ## NAN 20150204
        if (SuperHSdata[iddd].PDFMaster = 0) then
          SuperHSdata[iddd].PDFMaster                := DataM1.SQLQuerypage.fieldbyname('mastercopyseparationset').asinteger;

        if (HSCols[71].fieldpos < NaktHScols) then
          SuperHSdata[iddd].CustomerID            := DataM1.SQLQuerypage.fields[HSCols[71].fieldpos].asinteger
        Else
          SuperHSdata[iddd].CustomerID            := -1;
        SuperHSdata[iddd].foundinlist := false;
        L := Formalfasort.ListView1.Items.Add;
        For i := 0 to NaktHScols do
        begin
          aktsubitemkinds[i] := HSCols[HSOrder[i]].Kind;
          aktfieldpos := HSCols[HSOrder[i]].fieldpos;
          HSCols[HSOrder[i]].ColX := I;
          atime := now;
          Case HSOrder[i] of
            0 : T := statusarray[SuperHSdata[Iddd].status].name;
            1 : T := Externalstatusarray[DataM1.SQLQuerypage.fields[aktfieldpos].asinteger].name;
            2 : T := tnames1.publicationIDtoname(SuperHSdata[iddd].publicationID);
            3 : T := tnames1.sectionIDtoname(SuperHSdata[iddd].sectionID);
            4 : T := tnames1.editionIDtoname(SuperHSdata[iddd].editionID);
            6 : T := datetostr(GSelpubdate);
            8 : T := tnames1.ColornameIDtoname(SuperHSdata[iddd].ColorID);
            9 : T := PlatetemplateArray[inittypes.gettemplatenumberfromID(SuperHSdata[iddd].TemplateID)].TemplateName;
            10 : T := tnames1.proofIDtoname(DataM1.SQLQuerypage.fields[aktfieldpos].asinteger);
            11 : T := tnames1.deviceIDtoname(SuperHSdata[iddd].DEVICEID);
            16 : T := apprnamearray[SuperHSdata[iddd].approved+1];
            17 : T := Holdrealesarray[SuperHSdata[iddd].hold];
            18 : T := Yesnoarray[SuperHSdata[iddd].Active];
            21 : T := pagetypesarray[DataM1.SQLQuerypage.fields[aktfieldpos].asinteger];
            24 : T := fronbackstr[DataM1.SQLQuerypage.fields[aktfieldpos].asinteger];
            25 : T := tnames1.pressnameIDtoname(DataM1.SQLQuerypage.fields[aktfieldpos].asinteger);
            32 : T := ProductionName + ' / ' + DataM1.SQLQuerypage.fields[aktfieldpos].asstring;
            34 : T := Proofarray[DataM1.SQLQuerypage.fields[aktfieldpos].asinteger];
            35 : T := Inkstatusarray[SuperHSdata[iddd].InkStaus];
            38 : T := Uniquearray[DataM1.SQLQuerypage.fields[aktfieldpos].asinteger];
            39 : T := tnames1.locationIDtoname(SuperHSdata[iddd].locationID);
            40 : T := Formflatproof.flatproofconfigtostr(DataM1.SQLQuerypage.fields[aktfieldpos].asinteger);  //flatproof
            41 : if DataM1.SQLQuerypage.fields[aktfieldpos].asinteger > 0 then
                         T := 'Proofed'
                       else
                         T := 'Not proofed';
            43 : begin
                   T := DataM1.SQLQuerypage.fields[aktfieldpos].asstring;
                   inittypes.markstrtoarray(T,Amarks,ANmarks);
                   T := inittypes.marksnamestr(ANmarks,Amarks);
                 end;
            45 : T := Yesnoarray[DataM1.SQLQuerypage.fields[aktfieldpos].asinteger];
            47 : T := Formflatproof.flatproofconfigtostr(DataM1.SQLQuerypage.fields[aktfieldpos].asinteger);  //HARDproof
            48 : if DataM1.SQLQuerypage.fields[aktfieldpos].asinteger > 0 then
                   T := 'Proofed'
                 else
                   T := 'Not proofed';
            71 : T := tnames1.CustomerIDtoname(SuperHSdata[iddd].CustomerID); //CustomerID
            72 : T := DataM1.SQLQuerypage.fields[aktfieldpos].asstring; //'EmailStatus';
            73 : T := DataM1.SQLQuerypage.fields[aktfieldpos].asstring; //'Miscint1';
            74 : T := DataM1.SQLQuerypage.fields[aktfieldpos].asstring; //'Miscint2';
            75 : T := DataM1.SQLQuerypage.fields[aktfieldpos].asstring; //'Miscint3';
            76 : T := DataM1.SQLQuerypage.fields[aktfieldpos].asstring; //'Miscint4';
            77 : T := DataM1.SQLQuerypage.fields[aktfieldpos].asstring; //'Miscstring1';
            78 : T := DataM1.SQLQuerypage.fields[aktfieldpos].asstring; //'Miscstring2';
            79 : T := DataM1.SQLQuerypage.fields[aktfieldpos].asstring; //'Miscstring3';
            80 : T := DataM1.SQLQuerypage.fields[aktfieldpos].asstring; //'Miscdate';
            115 : T := inittypes.DeviceGroupIDtoName(DataM1.SQLQuerypage.fields[aktfieldpos].asinteger);
            Else
            Begin
              Case HSCols[HSOrder[i]].Kind of
                4 : begin
                      if Prefs.SeparationsUseLocaleTimeFormat then
                        T := Prefs.MakeDateTimeString(DataM1.SQLQuerypage.fields[aktfieldpos].AsDateTime)
                      else
                      begin
                        try
                          IF DataM1.SQLQuerypage.fields[aktfieldpos].AsDateTime > encodedate(1970,1,1) then
                            T := FormatDateTime(Prefs.SeparationTimeFormat,DataM1.SQLQuerypage.fields[aktfieldpos].AsDateTime)
                          else
                            T := '';
                        Except
                          T := Prefs.MakeDateTimeString(DataM1.SQLQuerypage.fields[aktfieldpos].AsDateTime)
                        end;
                      end;
                    end;
                else
                  T := DataM1.SQLQuerypage.fields[aktfieldpos].asstring;
              end;
            end;
          End;
          IF i = 0 then
            L.Caption := T
          Else
            l.SubItems.Add(t);
        end;

        l.SubItems.Add(inttostr(SuperHSdata[iddd].PDFMaster));  //her havde jeg ''
        l.SubItems.Add(inttostr(SuperHSdata[iddd].MasterCopySeparationSet));
        l.SubItems.Add(inttostr(SuperHSdata[iddd].CopySeparationSet));
        l.SubItems.Add(inttostr(SuperHSdata[iddd].SeparationSet));
        l.SubItems.Add(inttostr(SuperHSdata[iddd].Separation));
        l.SubItems.Add(inttostr(SuperHSdata[iddd].CopyFlatSeparationSet));
        l.SubItems.Add(inttostr(SuperHSdata[iddd].FlatSeparationSet));
        l.SubItems.Add(inttostr(SuperHSdata[iddd].FlatSeparation));
        l.SubItems.Add(inttostr(SuperHSdata[iddd].ColorID));

        DataM1.SQLQuerypage.next;
      End;
      DataM1.SQLQuerypage.close;
      starttime := now;
      Formalfasort.Stopcompare := 0;
      Formalfasort.ColumnToSort := 0;
      Formalfasort.ListView1.AlphaSort;
      Formalfasort.ListView1.Items.EndUpdate;
      Sleep(100);
      application.ProcessMessages;
      For I := 0 to NaktHScols do
      begin
        formmain.StringGridHS.cells[i,0] := HScols[HSOrder[i]].name;
        formmain.StringGridHS.colwidths[i] := HScols[HSOrder[i]].width;
      End;
      Sleep(100);
      application.ProcessMessages;
      formmain.StringGridHS.cells[NaktHScols+2,0] := 'p1.MasterCopySeparationSet';
      formmain.StringGridHS.cells[NaktHScols+3,0] := 'p1.CopySeparationSet';
      formmain.StringGridHS.cells[NaktHScols+4,0] := 'p1.SeparationSet';
      formmain.StringGridHS.cells[NaktHScols+5,0] := 'p1.Separation';
      formmain.StringGridHS.cells[NaktHScols+6,0] := 'p1.CopyFlatSeparationSet';
      formmain.StringGridHS.cells[NaktHScols+7,0] := 'p1.FlatSeparationSet';
      formmain.StringGridHS.cells[NaktHScols+8,0] := 'p1.FlatSeparation';
      For I := 0 to Formalfasort.ListView1.Items.Count-1 do
      begin
        formmain.StringGridHS.cells[0,i+1] := Formalfasort.ListView1.Items[i].caption;
        for i1 := 0 to Formalfasort.ListView1.Items[i].SubItems.Count-1 do
          formmain.StringGridHS.cells[i1+1,i+1] := Formalfasort.ListView1.Items[i].SubItems[i1];
        StringGridHSempty := false;
      end;
      starttime := now;
      IF Formalfasort.anychange then
      begin
        repeat
          Foundany := false;
          For i := 1 to formmain.StringGridHS.rowcount-1 do
          begin
            IF not SuperHSdata[i-1].foundinlist then
            begin
              IF formmain.StringGridHS.cells[NaktHScols+5,i] <> inttostr(SuperHSdata[i-1].Separation) then
              begin
                Foundany := true;
                for i1 := 1 to formmain.StringGridHS.rowcount-1 do
                begin
                  IF formmain.StringGridHS.cells[NaktHScols+5,i] = inttostr(SuperHSdata[i1-1].Separation) then
                  begin
                    buf := SuperHSdata[i1-1];
                    SuperHSdata[i1-1] := SuperHSdata[i-1];
                    SuperHSdata[i1-1].foundinlist := false;
                    buf.foundinlist := true;
                    SuperHSdata[i-1] := Buf;
                    break;
                  end;
                End;
              end
              Else
                SuperHSdata[i-1].foundinlist := true;
            End;
          End;
        Until not foundany;
        starttime := now;
     end;

     starttime := now;
     If (HSCols[95].Inlist) or (HSCols[96].Inlist) or (HSCols[97].Inlist) or (HSCols[98].Inlist) then
     Begin
        For i := 1 to formmain.StringGridHS.rowcount-1 do
        begin
          if HSCols[95].Inlist then
            formmain.StringGridHS.cells[HSCols[95].colx,i] := '';
          if HSCols[96].Inlist then
            formmain.StringGridHS.cells[HSCols[96].colx,i] := '';
          if HSCols[97].Inlist then
            formmain.StringGridHS.cells[HSCols[97].colx,i] := '';
          if HSCols[98].Inlist then
            formmain.StringGridHS.cells[HSCols[98].colx,i] := '';
        End;
        datam1.Query1.SQL.Clear;              //0              1                  2                3           4                            5
        datam1.Query1.SQL.Add('Select distinct pr.EventTime,pr.Event,pr.mastercopyseparationset,pr.message,p1.mastercopyseparationset,e.eventname from prepollpagetable pr (NOLOCK),pagetable p1 (NOLOCK),eventcodes e (NOLOCK)');
        datam1.Query1.SQL.Add('where active <> -999 and pr.mastercopyseparationset = p1.mastercopyseparationset');
        DataM1.Query1.SQL.add(' and pr.Event = e.Eventnumber');
        DataM1.Query1.SQL.add(' and pr.mastercopyseparationset = p1.mastercopyseparationset');
        IF GSelpubdate > 0 then
          DataM1.Query1.SQL.add(' and ' + DataM1.makedatastr('p1.',GSelpubdate));
        DataM1.Query1.SQL.add(prewherestr);
        IF Not Showingall then
        begin
          DataM1.Query1.SQL.add(' and p1.publicationid = ' + inttostr(GSelpubid));
        End;
        DataM1.Query1.SQL.add('order by p1.mastercopyseparationset,pr.event,pr.EventTime');
        if Prefs.debug then
          DataM1.Query1.SQL.savetofile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'presel.SQL');
        aktmaster := -1;
        aktevent := -1;
        akteventtime := encodedate(2000,1,1);
        aktmessage := '';
        formmain.tryopen(DataM1.Query1);
        While not DataM1.Query1.eof do
        begin
          IF (aktevent <> DataM1.Query1.fields[1].asinteger) or (aktmaster <> DataM1.Query1.fields[2].asinteger) then
          begin
            aktmaster := DataM1.Query1.fields[2].asinteger;
            aktevent  :=  DataM1.Query1.fields[1].asinteger;
            akteventtime := DataM1.Query1.fields[0].asdatetime;
            aktmessage := DataM1.Query1.fields[3].asstring;
            akteventname := DataM1.Query1.fields[5].asstring;
            ipre :=  -1;
            Case aktevent of
              130..139 : Begin
                           IF HSCols[95].Inlist then
                             ipre := HSCols[95].ColX;
                     End;
              110..119 : Begin
                           IF HSCols[96].Inlist then
                             ipre := HSCols[96].ColX;
                         End;
              120..129 : Begin
                           IF HSCols[97].Inlist then
                             ipre := HSCols[97].ColX;
                         End;
              140..149 : Begin
                           IF HSCols[98].Inlist then
                             ipre := HSCols[98].ColX;
                         End;
              210..219 : Begin
                           IF HSCols[98].Inlist then
                             ipre := HSCols[98].ColX;
                         End;
            end;
            IF ipre > -1 then
            Begin
              For i := 1 to formmain.StringGridHS.rowcount-1 do
              begin
                if SuperHSdata[i-1].mastercopyseparationset = aktmaster then
                begin
                  formmain.StringGridHS.cells[ipre,i] := akteventname +' ' +aktmessage;
                end;
              End;
            End;
          end;

          DataM1.Query1.next;
        End;
        DataM1.Query1.close;
        (*
        HSCols[95].name          := 'FTP';
        130..139
        HSCols[96].name          := 'Preflight';
        110..119
        HSCols[97].name          := 'RIP';
        120..129
        HSCols[98].name          := 'Color level';
        140..149
        *)
     End;
     if (akttoprow > -1) And (akttoprow < formmain.StringGridHS.rowcount  ) then
     begin
       if aktoprowsep = SuperHSdata[akttoprow].Separation then
       begin
         formmain.StringGridHS.toprow := akttoprow;
       end;
     End;
     starttime := now;
    Except
    end;
  finally

    if DataM1.SQLQuerypage.active then
      DataM1.SQLQuerypage.close;
    screen.Cursor := crdefault;
    formmain.StringGridHS.visible := true;
    mainrefreshing := false;
    starttime := now;
  end;
end;
procedure DOHSToExcel;
var
    {excel}
  Sheet,objExcel : Variant;
  Title,t,cap : String;
  x,y: Longint;
  tmpDate,testtid : TDateTime;
  FormatSettings: TFormatSettings;
  timeformatstr : string;
  NExcelcols,Iexcelcol : Longint;
  Ycel,x1 : Longint;
  nnode : ttreenode;
  filterstr : string;
begin
  nnode := formmain.TreeViewpagelist.Selected;
  if nnode = nil then exit;
  filterstr := '';
  While nnode.Level > 1 do
  begin
    filterstr := nnode.text + ', ' + filterstr;
    nnode := nnode.Parent;
  end;
  filterstr := nnode.text + ', ' + filterstr;
  Screen.Cursor := crHourGlass;
  try
    GetLocaleFormatSettings(0,FormatSettings);
    timeformatstr := localdatetimesettings.ShortDateFormat + ' ' + localdatetimesettings.ShortTimeFormat+':ss';
    Title := 'CC Data';
    {create an instance of excel}
    objExcel := CreateOleObject ('Excel.Application');
    objExcel.Visible := True;
    objExcel.Caption := 'CC Data ' + filterstr;
    {add the sheet}
    objExcel.Workbooks.Add;
    objExcel.Workbooks[1].Sheets.Add;
    objExcel.Workbooks[1].WorkSheets[1].Name := Title;
    Sheet := objExcel.Workbooks[1].WorkSheets[Title];

    for x := 0 to formmain.StringGridHS.ColCount-1 do
      Sheet.Cells[(2), (x+1 )] := formmain.StringGridHS.cells[x,0];

    {create the columns}
    NExcelcols := formmain.StringGridHS.ColCount-1;
    Ycel := -1;
    for y := 1 to (formmain.StringGridHS.rowCount) do
    begin
      Iexcelcol := -1;
      IF (not Prefs.SeparationsExportOnlySelectedRows) or (SuperHSdata[y-1].Selected) then
      begin
        Inc(Ycel);
        for x := 0 to formmain.StringGridHS.ColCount-1 do
        begin
          try
            {check if output is date and add to excel in correct format}
            Inc(Iexcelcol);
            T := formmain.StringGridHS.cells[x,y];

            Sheet.Cells[(Ycel + 3), (Iexcelcol + 1)] := T;

            //tmpDate := StrToDate(PBExListviewdatalist.Items.Item[y].SubItems.Strings[x]);

          //Sheet.Cells[(y + 3), (x + 2)] := tmpDate;
          //objExcel.Selection.NumberFormat := 'mm/dd/yyyy';
          except on EConvertError do
          begin
            {if there was a conversion error then just add as normal i.e. string}
            //Sheet.Cells[(y + 3), (x + 2)] := PBExListviewdatalist.Items.Item[y].SubItems.Strings[x];
          end;
        end;
      End;
    end;
    end;
    {Select cells and format}
    objExcel.Cells.select;
    objExcel.Selection.Font.Name:='Arial';
    objExcel.Selection.Font.Size:=9;
    objExcel.selection.Columns.AutoFit;
  except
  begin
    Screen.Cursor := crDefault;
    exit;
  end;
  end;
  Screen.Cursor := crDefault;
end;

procedure DOresetsuperhsselection;
var
  I : longint;
Begin
  for i := 1 to formmain.StringGridHS.RowCount do
  begin
    SuperHSdata[i-1].Selected := false;
  End;
  formmain.StringGridHS.Repaint;
end;
function Dogetfirstselectedhs:Longint;
Var
  I : longint;
begin
  result := -1;
  for i := 1 to formmain.StringGridHS.RowCount do
  begin
    IF SuperHSdata[i-1].Selected then
    begin
      result := i;
      break;
    end;
  end;
end;
procedure DOdoseparationsapproval;
Var
  I : Longint;
  n,c : ttreenode;
  foundone : boolean;
  Inliste : String;
  eventtime : Tdatetime;
begin
  //dogetpreselHS;
  Inliste := 'and separation IN (-99,';
  eventtime := -1;
  foundone := false;
  for i := 1 to formmain.StringGridHS.RowCount do
  begin
    IF SuperHSdata[i-1].Selected then
    begin
      IF SuperHSdata[i-1].approved <> 1 then
        Inliste := Inliste + inttostr(SuperHSdata[i-1].Separation) + ',';
      foundone := true;
    End;
  end;
  IF foundone then
  begin
    Inliste[length(Inliste)] := ')';
    datam1.Query1.SQL.Clear;
    datam1.Query1.SQL.Add('Update pagetable');
    datam1.Query1.SQL.Add('Set approved = 1');
    datam1.Query1.SQL.Add('where active <> -999');
    datam1.Query1.SQL.Add(Inliste);
    datam1.Query1.SQL.Add(WeditionStr);
    datam1.Query1.SQL.Add('and ' + formmain.pagetreeselstr);
    datam1.Query1.SQL.Add(WpublicationStr);
    IF Prefs.debug then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'approve.sql');
    formmain.trysql(datam1.Query1);
    IF (Prefs.LogApproval) then
    begin
      for i := 1 to formmain.StringGridHS.RowCount do
      begin
        IF (SuperHSdata[i-1].selected) And (SuperHSdata[i-1].approved <> 1) then
        begin
          datam1.Query1.SQL.Clear;
          datam1.Query1.SQL.Add('Select distinct filename,version from pagetable (NOLOCK) where separation = '+inttostr(SuperHSdata[i-1].Separation));
          datam1.Query1.open;
          IF Not datam1.Query1.Eof then
            Formmain.SaveEventlog(70,SuperHSdata[i-1].Separation,0,'',datam1.Query1.fields[0].asstring,datam1.Query1.fields[1].asinteger,SuperHSdata[i-1].productionID);
          datam1.Query1.close;
        End;
      end;
    end;
  end;
  for i := 1 to formmain.StringGridHS.RowCount do
  begin
    IF SuperHSdata[i-1].selected then
    begin
      formmain.afterapproval(SuperHSdata[i-1].MasterCopySeparationSet,-2702);
    End;
  end;
  doloadSuperHSDB2(false);
  doresetpreselHS;
End;

procedure DoresetpreselHS;
Var
  I1,I,foundn : longint;
Begin
  try
    IF Npreactionsel > 0 then
    begin
      foundn := 0;
      For i := 1 to formmain.StringGridHS.RowCount do
      begin
        For i1 := 0 to Npreactionsel-1 do
        begin
          IF SuperHSdata[i-1].Separation = preactionsel[i1] then
          begin
            Inc(foundn);
            SuperHSdata[i-1].Selected := true;
            break;
          end;
        end;
        IF foundn = Npreactionsel then
          break;
      End;
      formmain.StringGridHS.Repaint;
    end;
    Npreactionsel := 0;
    setlength(preactionsel,2);
  Except
  end;
end;
procedure DOdoseparationsReapproval;
Var
  I : Longint;
  n : ttreenode;
  foundone : boolean;
  Inliste : String;
  eventtime : Tdatetime;
begin

  //DOgetpreselHS;
  Inliste := 'and separation IN (';
  eventtime := -1;
  foundone := false;
  for i := 1 to formmain.StringGridHS.RowCount do
  begin
    IF SuperHSdata[i-1].Selected then
    begin
      Inliste := Inliste + inttostr(SuperHSdata[i-1].Separation) + ',';
      foundone := true;
    End;
  end;
  IF foundone then
  begin
    Inliste[length(Inliste)] := ')';
    datam1.Query1.SQL.Clear;
    datam1.Query1.SQL.Add('Update pagetable');
    datam1.Query1.SQL.Add('Set approved = 0');
    datam1.Query1.SQL.Add('where active <> -999 ');
    datam1.Query1.SQL.Add(Inliste);
    datam1.Query1.SQL.Add(WeditionStr);
    datam1.Query1.SQL.Add('and ' + formmain.pagetreeselstr);
    datam1.Query1.SQL.Add(WpublicationStr);
    IF Prefs.debug then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'approve.sql');
    formmain.trysql(datam1.Query1);
  end;
  DOloadSuperHSDB2(false);
  doresetpreselHS;
End;

procedure DodoseparationsAutoapproval;
Var
  I : Longint;
  n,c : ttreenode;
  foundone : boolean;
  Inliste : String;
  eventtime : Tdatetime;
begin

  //DOgetpreselHS;
  Inliste := 'and separation IN (';
  eventtime := -1;
  foundone := false;
  for i := 1 to formmain.StringGridHS.RowCount do
  begin
    IF SuperHSdata[i-1].Selected then
    begin
      Inliste := Inliste + inttostr(SuperHSdata[i-1].Separation) + ',';
      foundone := true;
    End;
  end;
  IF foundone then
  begin
    Inliste[length(Inliste)] := ')';
    datam1.Query1.SQL.Clear;
    datam1.Query1.SQL.Add('Update pagetable');
    datam1.Query1.SQL.Add('Set approved = -1');
    datam1.Query1.SQL.Add('where active <> -999');
    datam1.Query1.SQL.Add('and ' + formmain.pagetreeselstr);
    datam1.Query1.SQL.Add(Inliste);
    datam1.Query1.SQL.Add(WeditionStr);
    datam1.Query1.SQL.Add(WpublicationStr);
    IF Prefs.debug then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'approve.sql');
    formmain.trysql(datam1.Query1);
  end;
  doloadSuperHSDB2(false);
  doresetpreselHS;
End;

procedure DoDOPageDisapproveExecute;
Var
  I : longint;
  eventtime : Tdatetime;
begin
  //dogetpreselHS;
  formmain.setpagetablestddata('set approved = 2,approvetime = 0,approveuser='+''''+Prefs.username+'''','');
  eventtime := -1;
  if (Prefs.LogDisapproval) then
  begin
    for i := 1 to formmain.StringGridHS.RowCount do
    begin
      IF SuperHSdata[i-1].selected then
      begin
        datam1.Query1.SQL.Clear;
        datam1.Query1.SQL.Add('Select filename,version from pagetable (NOLOCK) where separation = '+inttostr(SuperHSdata[i-1].Separation));
        datam1.Query1.open;
        IF Not datam1.Query1.Eof then
          Formmain.SaveEventlog(71,SuperHSdata[i-1].Separation,0,'',datam1.Query1.fields[0].asstring,datam1.Query1.fields[1].asinteger,SuperHSdata[i-1].productionID);
        datam1.Query1.close;
      End;
    end;
  end;
  formmain.sendedisapprovemail(-1,'Page disapproved',0);
  doloadSuperHSDB2(false);
  doresetpreselHS;
end;

procedure DODoPageHoldExecute;
Var
  I : longint;
  eventtime : tdatetime;
begin
  //DOgetpreselHS;
  formmain.setpagetablestddata('set hold = 1','');
  if (Prefs.LogHold) then
  begin
    eventtime := -1;
    for i := 1 to formmain.StringGridHS.RowCount do
    begin
      IF SuperHSdata[i-1].Selected then
      begin
        datam1.Query1.SQL.Clear;
        datam1.Query1.SQL.Add('Select filename,version from pagetable (NOLOCK) where separation = '+inttostr(SuperHSdata[i-1].Separation));
        datam1.Query1.open;
        IF Not datam1.Query1.Eof then
          Formmain.SaveEventlog(81,SuperHSdata[i-1].Separation,0,'',datam1.Query1.fields[0].asstring,datam1.Query1.fields[1].asinteger,SuperHSdata[i-1].productionID);
        datam1.Query1.close;
      End;
    end;
  end;
  doloadSuperHSDB2(false);
  doresetpreselHS;
end;

procedure DODoPagereleaseExecute(Onlymono : Boolean);
Var
  T : String;
  prodid,I : longint;
  eventtime : tdatetime;
  somedevnotset : Boolean;
Begin
  Releaseproductionids.clear;
  ReleasePressrunids.clear;
  ReleasePlates.clear;
  for i := 1 to formmain.StringGridHS.RowCount do
  begin
    IF SuperHSdata[i-1].Selected then
    begin
      IF Releaseproductionids.IndexOfName(inttostr(SuperHSdata[i-1].productionID)) < 0 then
        Releaseproductionids.add(inttostr(SuperHSdata[i-1].productionID));
      IF ReleasePressrunids.IndexOfName(inttostr(SuperHSdata[i-1].Pressrunid)) < 0 then
        ReleasePressrunids.add(inttostr(SuperHSdata[i-1].Pressrunid));
      IF ReleasePlates.IndexOfName(inttostr(SuperHSdata[i-1].copyflatseparationset)) < 0 then
        ReleasePlates.add(inttostr(SuperHSdata[i-1].copyflatseparationset));
      break;
    End;
  End;
  if (Prefs.MustSetDeviceOnRelease) then
  begin
    IF Not formmain.checkdevbeforerelease then
      exit;
  end;
  if (Prefs.ReleaseOnSeparationSet) then
    doreleaseonseprationset
  Else
  begin
    IF onlymono then
    begin
      if (Prefs.SetApproveTimeOnRelease) then
        formmain.setpagetablestddata('set hold = 0, approvetime = getdate(),approveuser='+''''+Prefs.username+'''','And (colorid = 4) ')        // OK
      Else
        formmain.setpagetablestddata('set hold = 0','And (colorid = 4) ');  // OK
    end
    Else
    Begin
      if (Prefs.SetApproveTimeOnRelease) then
        formmain.setpagetablestddata('set hold = 0, approvetime = getdate(),approveuser='+''''+Prefs.username+'''','')        // OK
      else
        formmain.setpagetablestddata('set hold = 0','');       // OK
    End;
    if (Prefs.LogRelease) then
    begin
      eventtime := -1;
      for i := 1 to formmain.StringGridHS.RowCount do
      begin
        IF SuperHSdata[i-1].Selected then
        begin
          datam1.Query1.SQL.Clear;
          datam1.Query1.SQL.Add('Select filename,version from pagetable (NOLOCK) where separation = '+inttostr(SuperHSdata[i-1].Separation));
          datam1.Query1.open;
          IF Not datam1.Query1.Eof then
            Formmain.SaveEventlog(80,SuperHSdata[i-1].Separation,0,'',datam1.Query1.fields[0].asstring,datam1.Query1.fields[1].asinteger,SuperHSdata[i-1].productionID);
          datam1.Query1.close;
        End;
      end;
    end;
  End;

  doloadSuperHSDB2(false);
  doresetpreselHS;
End;
Procedure DOreleaseonseprationset;
Var
  I : Longint;
  n,c : ttreenode;
  foundone : boolean;
  Inliste : String;
begin
  Inliste := 'and separationset IN (';
  for i := 1 to formmain.StringGridHS.RowCount do
  begin
    IF SuperHSdata[i-1].selected then
    begin
      Inliste := Inliste + inttostr(SuperHSdata[i-1].Separationset) + ',';
      foundone := true;
    End;
  end;
  IF foundone then
  begin
    Inliste[length(Inliste)] := ')';
    datam1.Query1.SQL.Clear;
    datam1.Query1.SQL.Add('Update pagetable');
    datam1.Query1.SQL.Add('set hold = 0');  // OK
    if (Prefs.SetApproveTimeOnRelease) then
      DataM1.Query1.SQL.add(', approvetime = getdate(),approveuser='+''''+Prefs.username+'''');
    datam1.Query1.SQL.Add('where active <> -999');
    datam1.Query1.SQL.Add('and ' + formmain.pagetreeselstr);
    IF formmain.ComboBoxPagescopies.ItemIndex > 0 then
    begin
      datam1.Query1.SQL.Add('and copynumber = ' +formmain.ComboBoxPagescopies.text);
    end;
    datam1.Query1.SQL.Add(Inliste);
    datam1.Query1.SQL.Add(WeditionStr);
    datam1.Query1.SQL.Add(WpublicationStr);
    formmain.trysql(datam1.Query1);
    IF (Prefs.LogApproval) then
    begin
      for i := 1 to formmain.StringGridHS.RowCount do
      begin
        IF SuperHSdata[i-1].selected then
        begin
          datam1.Query1.SQL.Clear;
          datam1.Query1.SQL.Add('Select filename,version from pagetable (NOLOCK) where separation = '+inttostr(SuperHSdata[i-1].Separation));
          datam1.Query1.open;
          IF Not datam1.Query1.Eof then
            Formmain.SaveEventlog(80,SuperHSdata[i-1].Separation,0,'',datam1.Query1.fields[0].asstring,datam1.Query1.fields[1].asinteger,SuperHSdata[i-1].productionID);
          datam1.Query1.close;
        End;
      end;
    end;
  end;
End;


end.
