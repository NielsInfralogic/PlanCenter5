unit Udata;
interface
uses
  windows,SysUtils, Classes, FMTBcd, SqlExpr,
  DB,ComCtrls, dateutils, DBXDevartSQLServer, Data.Win.ADODB, UITypes;
type
  TDataM1 = class(TDataModule)
    CRSQLConnectionplan: TSQLConnection;
    Query1: TSQLQuery;
    Query2: TSQLQuery;
    Queryapplypressrun: TSQLQuery;
    SQLQueryname: TSQLQuery;
    Query3: TSQLQuery;
    SQLQuerypage: TSQLQuery;
    QueryapplypressrunChanges: TSQLQuery;
    SQLQueryTmp: TSQLQuery;
    SQLQueryTestserver: TSQLQuery;
    Query4: TSQLQuery;
    Query5: TSQLQuery;
    Querytree: TSQLQuery;
    SQLQueryTreethread: TSQLQuery;
    Queryautorefresh1: TSQLQuery;
    SQLQueryTestATry: TSQLQuery;
    SQLQueryplateupd: TSQLQuery;
    SQLQueryAnyplate: TSQLQuery;
    SQLQuerydevcontrol: TSQLQuery;
    SQLQueryMplateupd: TSQLQuery;
    SQLQuerytreecash: TSQLQuery;
    SQLQuerytreecashUpd: TSQLQuery;
    SQLQueryconsole: TSQLQuery;
    SQLQuerypagetable: TSQLQuery;
    SQLQuerySJO1: TSQLQuery;
    QueryProductionStatus1: TSQLQuery;
    QueryWorkerThreadUnknownPages: TSQLQuery;
    SQLConnectionErrorFileThread: TSQLConnection;
    SQLConnectionTreestate: TSQLConnection;
    SQLConnectionDeviceState: TSQLConnection;
  private
    { Private declarations }
  public
    Servername : string;
    Database   : String;
    Instance   : String;
    DBUser     : String;
    DBPassword : String;
    Usebackup  : boolean;
    DSN        : String;
    OSAuthentication : Boolean;

    Procedure SetParamters(ConnectionName: string; DBreconnect : Boolean; DBFetchAll : Boolean; DBCommandTimeout : Integer; DBOSAuthentication : Boolean);
    Function loadAllPlateSQL(usePossiblepressrunid :Boolean):Boolean;
    function getspparamcount(spname : string):Longint;
    procedure NewThreadtreetableLamps;
    procedure CheckAndcreateSPandTables;
    Procedure SetNewtreeprodid;
    procedure UpdateTreeStateOnProduction(updateall : Boolean);
    Procedure fixinstanceservername(Var servername : String;
                                    Var Instance   : String);
    Function makedatastr(tabledef : string;
                         pubdate : tdatetime):String;
    Function makedatastrSign(tabledef : string;
                                 Sign : String;
                                 pubdate : tdatetime):String;
    Function  Stringtopubdate(format : string;
                                      Adatestr : String;
                                      var Apubdate : Tdatetime):Boolean;

    Function ConnecttoserverErrorFileThread: Boolean;
    function DisConnectFromServerErrorFileThread: Boolean;

    function ConnectToServerTreeThread: Boolean;
    function DisConnectFromServerTreeThread: Boolean;
    function CheckDBTreeThread : Boolean;

    function ConnectToServerDeviceState: Boolean;
    function CheckDBDeviceState: Boolean;
    function DisConnectFromServerDeviceState: Boolean;

    function ConnectToServer: Boolean;
    function DisConnectFromServer: Boolean;

    function TableExists(tableName:string) : Boolean;
    function StoredProcedureExists(spName:string) : Boolean;
    function StoredProcedureParameterExists(spName: string; parameterName : String): Boolean;
    function TableFieldExists(tableName:string; fieldName:string) : Boolean;
    function HasEvent(eventNumber: Integer) : Boolean;
    procedure InsertEvent(eventNumber: Integer;EventName: string);
    function TableHasData(tableName: string) : Boolean;
    Function MakePresstimeStr(tabledef : string; pressTime:TDateTime):String;
  end;
var
  DataM1: TDataM1;
implementation
{$R *.dfm}
Uses
  inifiles,forms, Usettings,utypes, Userverconfig,Registry, Umain, UUtils;
  // NAN 20170317
Procedure TDataM1.SetParamters(ConnectionName: string; DBreconnect : Boolean; DBFetchAll : Boolean; DBCommandTimeout : Integer; DBOSAuthentication : Boolean);
begin

  if AnsiCompareText(ConnectionName, 'SQLConnectionErrorFileThread') = 0 then
  begin
    if (DBFetchAll) then
      SQLConnectionErrorFileThread.Params.Values['FetchAll'] := 'True'
    else
       SQLConnectionErrorFileThread.Params.Values['FetchAll'] := ' False';

    if (DBreconnect) then
      SQLConnectionErrorFileThread.Params.Values['Reconnect'] := 'True'
    else
      SQLConnectionErrorFileThread.Params.Values['Reconnect'] := 'False';
    if (DBCommandTimeout>0) then
      SQLConnectionErrorFileThread.Params.Values['CommandTimeout'] := IntToStr(DBCommandTimeout);
    if (DBOSAuthentication) then
      SQLConnectionErrorFileThread.Params.Values['OS Authentication'] := 'True'
    else
      SQLConnectionErrorFileThread.Params.Values['OS Authentication'] := 'False';
  end
  else if AnsiCompareText(ConnectionName, 'SQLConnectionTreestate') = 0 then
  begin
    if (DBFetchAll) then
      SQLConnectionTreestate.Params.Values['FetchAll'] := 'True'
    else
       SQLConnectionTreestate.Params.Values['FetchAll'] := ' False';

    if (DBreconnect) then
      SQLConnectionTreestate.Params.Values['Reconnect'] := 'True'
    else
      SQLConnectionTreestate.Params.Values['Reconnect'] := 'False';
    if (DBCommandTimeout>0) then
      SQLConnectionTreestate.Params.Values['CommandTimeout'] := IntToStr(DBCommandTimeout);
    if (DBOSAuthentication) then
      SQLConnectionTreestate.Params.Values['OS Authentication'] := 'True'
    else
      SQLConnectionTreestate.Params.Values['OS Authentication'] := 'False';
  end
    else if AnsiCompareText(ConnectionName, 'SQLConnectionDeviceState') = 0 then
  begin
    if (DBFetchAll) then
      SQLConnectionDeviceState.Params.Values['FetchAll'] := 'True'
    else
       SQLConnectionDeviceState.Params.Values['FetchAll'] := ' False';

    if (DBreconnect) then
      SQLConnectionDeviceState.Params.Values['Reconnect'] := 'True'
    else
      SQLConnectionDeviceState.Params.Values['Reconnect'] := 'False';
    if (DBCommandTimeout>0) then
      SQLConnectionDeviceState.Params.Values['CommandTimeout'] := IntToStr(DBCommandTimeout);
    if (DBOSAuthentication) then
      SQLConnectionDeviceState.Params.Values['OS Authentication'] := 'True'
    else
      SQLConnectionDeviceState.Params.Values['OS Authentication'] := 'False';
  end
  else
  begin
    if (DBFetchAll) then
      CRSQLConnectionplan.Params.Values['FetchAll'] := 'True'
    else
       CRSQLConnectionplan.Params.Values['FetchAll'] := ' False';

    if (DBreconnect) then
      CRSQLConnectionplan.Params.Values['Reconnect'] := 'True'
    else
      CRSQLConnectionplan.Params.Values['Reconnect'] := 'False';
    if (DBCommandTimeout>0) then
      CRSQLConnectionplan.Params.Values['CommandTimeout'] := IntToStr(DBCommandTimeout);
    if (DBOSAuthentication) then
      CRSQLConnectionplan.Params.Values['OS Authentication'] := 'True'
    else
      CRSQLConnectionplan.Params.Values['OS Authentication'] := 'False';
  end;

  OSAuthentication := DBOSAuthentication;
end;

Function TDataM1.makedatastr(tabledef : string;
                             pubdate : tdatetime):String;
Var
  Year, Month, Day: Word;
  SYear, SMonth, SDay: string;
Begin
  DecodeDate(pubdate,Year, Month, Day);
  SYear   := inttostr(Year);
  SMonth  := inttostr(Month);
  SDay    := inttostr(Day);
  result := '(datepart(day,'+tabledef+'pubdate) = ' +SDay+' and datepart(month,'+tabledef+'pubdate) = '+smonth+' and datepart(year,'+tabledef+'pubdate) = '+syear+')';
end;

Function TDataM1.MakePresstimeStr(tabledef : string; pressTime:TDateTime):String;
Var
  Year, Month, Day: Word;
  SYear, SMonth, SDay: string;
Begin
  DecodeDate(pressTime,Year, Month, Day);
  SYear   := inttostr(Year);
  SMonth  := inttostr(Month);
  SDay    := inttostr(Day);
  result := '(datepart(day,'+tabledef+'PressTime) = ' +SDay+' and datepart(month,'+tabledef+'PressTime) = '+smonth+' and datepart(year,'+tabledef+'PressTime) = '+syear+')';
end;


Function TDataM1.MakeDataStrSign(tabledef : string;
                                 Sign : String;
                                 pubdate : tdatetime):String;
Var
  Year, Month, Day: Word;
  SYear, SMonth, SDay: string;
Begin
  DecodeDate(pubdate,Year, Month, Day);
  SYear   := inttostr(Year);
  SMonth  := inttostr(Month);
  SDay    := inttostr(Day);
  result := '(datepart(day,'+tabledef+'pubdate) '+Sign+' ' +SDay+' and datepart(month,'+tabledef+'pubdate) = '+smonth+' and datepart(year,'+tabledef+'pubdate) = '+syear+')';
end;

Function TDataM1.StringToPubdate(format : string;
                                      Adatestr : String;
                                      var Apubdate : Tdatetime):Boolean;
Var
  Ys,ms,ds : String;
  y,m,d,i : Longint;
Begin
  result := false;
  try
    IF length(format) <> length(Adatestr) then
    begin
      result := false;
      exit;
    end;
    Ys  := '';
    ms  := '';
    ds  := '';
    format := Uppercase(format);
    For i := 1 to Length(format) do
    begin
      Case format[i] of
        'D' : ds := ds + Adatestr[i];
        'M' : ms := ms + Adatestr[i];
        'Y' : ys := ys + Adatestr[i];
      end;
    end;
    if ys = '' then
    begin
      ys := IntToStr(yearof(now));
    end;
    y := StrToInt(ys);
    m := StrToInt(ms);
    d := StrToInt(ds);
    Apubdate := Encodedatetime(y,m,d,0,0,0,0);
    result := true;
  except
    result := false;
  end;
end;
procedure TDataM1.FixInstanceServerName(Var servername : String;
                                        Var Instance   : String);
Begin
  Instance := '';
  IF pos('\',servername) > 0 then
  begin
    Instance := copy(servername,pos('\',servername)+1,length(servername));
    delete(servername,pos('\',servername),length(servername));
  end;
end;

Procedure TDataM1.SetNewtreeprodid;
Begin
  try
    Newtreeprodid := -1;
    Case formmain.PageControlMain.ActivePageIndex of
      VIEW_SEPARATIONS :
          begin
            if TTreeViewpagestype(formmain.TreeViewpagelist.Selected.data^).productionid > -1 then
              Newtreeprodid := TTreeViewpagestype(formmain.TreeViewpagelist.Selected.data^).productionid;
          end;
      VIEW_THUMBNAILS :
          begin
            if TTreeViewpagestype(formmain.TreeViewThumbs.Selected.data^).productionid > -1 then
              Newtreeprodid := TTreeViewpagestype(formmain.TreeViewThumbs.Selected.data^).productionid;
          end;
      VIEW_PLATES :
          begin
            if TTreeViewpagestype(formmain.TreeViewPlateview.Selected.data^).productionid > -1 then
              Newtreeprodid := TTreeViewpagestype(formmain.TreeViewPlateview.Selected.data^).productionid;
          end;
      VIEW_PRODUCTIONS :
          begin
            if TTreeViewpagestype(formmain.TreeViewprodcontrol.Selected.data^).productionid > -1 then
              Newtreeprodid := TTreeViewpagestype(formmain.TreeViewprodcontrol.Selected.data^).productionid;
          end;
      VIEW_EDITIONS :
          begin
            if TTreeViewpagestype(formmain.TreeViewNeweddtree.Selected.data^).productionid > -1 then
              Newtreeprodid := TTreeViewpagestype(formmain.TreeViewNeweddtree.Selected.data^).productionid;
          end;
    End;
  Except
    Newtreeprodid := -1;
  end;
end;

Procedure TDataM1.UpdateTreeStateOnProduction(updateall : Boolean);
//Var
  //Aktproductionid : Longint;
Begin
(*
  try
    if Usesnewtreetable then
    Begin
      Aktproductionid := -1;
      IF Not updateall then
      begin
        IF Newtreeprodid < 1 then
        begin
        End
        Else
          Aktproductionid := Newtreeprodid;
        if (Aktproductionid > 0)  then
        begin
          SQLQuerytreecashUpd.sql.clear;
          SQLQuerytreecashUpd.sql.add('Exec spUpdateTreeState ');
          SQLQuerytreecashUpd.sql.add('@SpecificProductionID=' + inttostr(Aktproductionid) +',');
          SQLQuerytreecashUpd.sql.add('@SpecificPressRunID=0');
          formmain.trysql(SQLQuerytreecashUpd);
        End;
      end
      Else
      Begin
        SQLQuerytreecashUpd.sql.clear;
        SQLQuerytreecashUpd.sql.add('Exec spUpdateTreeState ');
        SQLQuerytreecashUpd.sql.add('@SpecificProductionID=0' +',');
        SQLQuerytreecashUpd.sql.add('@SpecificPressRunID=0');
        formmain.trysql(SQLQuerytreecashUpd);
      end;
    End;
  except
  end;
   *)
  Newtreeprodid := -1;
End;


procedure TDataM1.NewThreadtreetableLamps;
Var
  NnewtreetableCashthread : Longint;
  newtreetableCashthread : Array of TreestateDataType;

  Function LoadnewThreadtreetableCash(locationid : Longint):Boolean;
  Var
    i,newsize : Longint;
  Begin
  //  Anychange := false;
    try
  //    Anychange := true;
      SQLQuerytreecash.close;
    except
    end;

    SQLQueryTreethread.close;
    SQLQueryTreethread.sql.clear;
    SQLQueryTreethread.sql.add('Select * From Treestate (NOLOCK)');
    SQLQueryTreethread.sql.add('Where publicationid > -99' );
    if locationid > 0 then
    begin
      SQLQueryTreethread.sql.add('and LocationID = ' + inttostr(locationid));
    end;
    if formmain.PageControlMain.ActivePageIndex = 2 then
    begin
      SQLQueryTreethread.sql.add('and PressrunID > 0 ');
    end
    Else
    begin
      SQLQueryTreethread.sql.add('and productionid > 0 ');
    end;
    SQLQueryTreethread.sql.add('order by LocationID,Pubdate,PublicationID,EditionID,SectionID,PressRunID');
    IF Prefs.debug then datam1.SQLQueryTreethread.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'SQLQueryTreethread.sql');
    try
      datam1.SQLQueryTreethread.open;
      newsize := SQLQueryTreethread.RecordCount;
      NnewtreetableCashthread := newsize;
      Setlength(newtreetableCashthread,NnewtreetableCashthread+100);
      I := 0;
      While not SQLQueryTreethread.eof do
      begin
        Inc(I);
        IF I > NnewtreetableCashthread then
        Begin
          NnewtreetableCashthread := I;
          Setlength(newtreetableCashthread,NnewtreetableCashthread+100);
        End;
        newtreetableCashthread[i].LocationID      := SQLQueryTreethread.fields[0].asinteger;
        newtreetableCashthread[i].Pubdate         := SQLQueryTreethread.fields[1].asdatetime;
        newtreetableCashthread[i].PublicationID   := SQLQueryTreethread.fields[2].asinteger;
        newtreetableCashthread[i].EditionID       := SQLQueryTreethread.fields[3].asinteger;
        newtreetableCashthread[i].SectionID       := SQLQueryTreethread.fields[4].asinteger;
        newtreetableCashthread[i].ProductionID    := SQLQueryTreethread.fields[5].asinteger;
        newtreetableCashthread[i].PressRunID      := SQLQueryTreethread.fields[6].asinteger;
        newtreetableCashthread[i].MinStatus       := SQLQueryTreethread.fields[7].asinteger;
        newtreetableCashthread[i].MaxStatus       := SQLQueryTreethread.fields[8].asinteger;
        newtreetableCashthread[i].NeedApproval    := SQLQueryTreethread.fields[9].asinteger;
        newtreetableCashthread[i].AllApproved     := SQLQueryTreethread.fields[10].asinteger;
        newtreetableCashthread[i].AnyUniquePage   := SQLQueryTreethread.fields[11].asinteger;
        newtreetableCashthread[i].AnyImaging      := SQLQueryTreethread.fields[12].asinteger;
        newtreetableCashthread[i].AnyReady        := SQLQueryTreethread.fields[13].asinteger;
        newtreetableCashthread[i].AnyError        := SQLQueryTreethread.fields[14].asinteger;
        newtreetableCashthread[i].AnyOnHold       := SQLQueryTreethread.fields[15].asinteger;
        newtreetableCashthread[i].TimeOfState     := SQLQueryTreethread.fields[16].asdatetime;
        newtreetableCashthread[i].MiscInt1        := SQLQueryTreethread.fields[17].asinteger;
        newtreetableCashthread[i].MiscInt2        := SQLQueryTreethread.fields[18].asinteger;
        newtreetableCashthread[i].MiscInt3        := SQLQueryTreethread.fields[19].asinteger;
        newtreetableCashthread[i].MiscInt4        := SQLQueryTreethread.fields[20].asinteger;
        newtreetableCashthread[i].Prodchange := true;
        newtreetableCashthread[i].StatChange := true;
        SQLQueryTreethread.next;
      end;
      SQLQueryTreethread.close;
  //    Anychange := false;
    Except
    end;
    //result := Anychange;
    result := true;
  End;
  Procedure Calcsumstate(Var astate : Longint;
                         Nodestate : Longint);
  Begin
    (*
    r�kkef�lge
    any error                 1
    any imaging               2
    all missing               3
    all common Ikke forced    4
    all imaged                5
    Der er noget der er kommet men ikke approved 6 stop
    Der er noget der er klar  7
    noget er imaged og noget mangler 8
    Miscint1 = alt har v�re imaged og der er ingen fejl s� 5
    Hvis der er noget der ikke er imaged og det er on hold s� + 10
    *)
    IF (astate < 1) or (astate > 50) then
      astate := Nodestate;
    Case Nodestate of
      1 : Begin
            astate := 1;
          end;
      2 : Begin
            IF astate > 2 then
              astate := 2;
          end;
      3 : Begin  //all missing
            Case astate Of
              1 : astate := 1;
              2 : astate := 2;
              3 : astate := 3;
              4 : Begin
                    astate := 4;
                  End;
              5 : Begin
                    astate := 8;
                  end;
              6 : Begin
                    astate := 6;
                  end;
              7 : Begin
                    astate := 7;
                  end;
              8 : astate := 8;
            end;
          end;
      4 : Begin  //all common Ikke forced
            IF astate = 4 then
              astate := 4
            Else
            begin
              IF (astate < 1) or (astate > 50) then
                astate := 4;
            end;
          end;
      5 : Begin
            Case astate of
              3 : astate := 8;
            end;
          end;
      6 : Begin
            Case astate Of
              1 : astate := 1;
              2 : astate := 2;
              3 : astate := 6;
              4 : astate := 6;
              5 : astate := 6;
              6 : astate := 6;
              7 : astate := 7;
              8 : astate := 6;
            end;
          end;
      7 : Begin
            Case astate Of
              1 : astate := 1;
              2 : astate := 2;
              3 : astate := 7;
              4 : astate := 7;
              5 : astate := 7;
              6 : astate := 7;
              7 : astate := 7;
              8 : astate := 7;
            end;
          end;
      8 : Begin
            Case astate Of
              1 : astate := 1;
              2 : astate := 2;
              3 : astate := 8;
              4 : astate := 4;
              5 : astate := 5;
              6 : astate := 6;
              7 : astate := 7;
              8 : astate := 8;
            end;
          end;
      Else
        astate := Nodestate;
    end;

  End;
  Procedure makeAstate(Var Astate : Longint;
                       Icash : Longint);
  Begin
                (*
                r�kkef�lge
                any error                 1
                any imaging               2
                all missing               3
                all common Ikke forced    4
                all imaged                5
                Der er noget der er kommet men ikke approved 6 stop
                Der er noget der er klar  7
                noget er imaged og noget mangler 8
                Hvis der er noget der ikke er imaged og det er on hold s� + 10
                *)
    IF newtreetableCashthread[Icash].AnyError > 0 then
      Astate := 1
    else
    begin
      IF (Prefs.TreeGreenOnceImaged) and (newtreetableCashthread[Icash].AnyError = 0) and (newtreetableCashthread[Icash].MiscInt1 = 1) then
        Astate := 5
      else
      Begin
        IF newtreetableCashthread[Icash].AnyImaging > 0 then
          Astate := 2
        else
        begin
          IF newtreetableCashthread[Icash].MaxStatus < 1 then
            Astate := 3
          else
          begin
            IF newtreetableCashthread[Icash].AnyUniquePage = 0 then
              Astate := 4
            else
            begin
              IF newtreetableCashthread[Icash].minStatus >= 50 then
                Astate := 5
              else
              begin
                IF (newtreetableCashthread[Icash].NeedApproval > 0) and (newtreetableCashthread[Icash].AllApproved < 1)  then
                  Astate := 6
                else
                begin
                  IF (newtreetableCashthread[Icash].AnyReady > 0) then
                    Astate := 7
                  else
                  begin
                    IF (newtreetableCashthread[Icash].MinStatus < 1) and (newtreetableCashthread[Icash].MaxStatus >= 50) then
                      Astate := 8
                    else
                    begin
                      Astate := 0;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      End;
    end;
  End;

Var
  Itree,Icash,Astate  : Longint;
  day,publ,ed,sec : Ttreenode;
  publState,edState,secState: Longint;
  Atree : Ttreeview;
  locationid : Longint;
  Treetype : Longint; // 1 = page 2 = plate
Begin
  try
    try
      Treetype := 1;
      Atree := formmain.TreeViewThumbs;
      if formmain.PageControlMain.ActivePageIndex < 5 then
      begin
        locationid := -100;
        // Always use ComboBoxpalocationN for location selection (except planning, active queue views)
        if (formmain.ComboBoxpalocationNY.enabled) AND (formmain.ComboBoxpalocationNY.Text <> 'All')  then
          LocationId := tnames1.locationnametoid(formmain.ComboBoxpalocationNy.items[formmain.ComboBoxpalocationNy.ItemIndex]);
        Case formmain.PageControlMain.ActivePageIndex of
          VIEW_SEPARATIONS :
              Begin
                Atree := formmain.TreeViewpagelist;
                Treetype := 1;
              end;
          VIEW_THUMBNAILS :
              Begin
                Atree := formmain.TreeViewThumbs;
                Treetype := 1;
              end;
          VIEW_PLATES :
              Begin
                Atree := formmain.TreeViewPlateview;
                Treetype := 2;
              end;
          VIEW_PRODUCTIONS :
              Begin
                Atree := formmain.TreeViewprodcontrol;
                Treetype := 1;
              end;
          VIEW_EDITIONS :
              Begin
                Atree := formmain.TreeViewNeweddtree;
                Treetype := 1;
              end;
        end;
        //nfound := 0;
        For Itree := 0 to Atree.Items.Count-1 do
        begin
          if (MainUpdateing or TreeStopit) OR (Not Atree.visible) then break;
          IF Atree.Items[Itree].Level > 0 then
          begin
//            Atree.Items[Itree].StateIndex := 0;
            TTreeViewpagestype(Atree.Items[Itree].Data^).Newstate := 100;
            TTreeViewpagestype(Atree.Items[Itree].Data^).Anyonhold := false;
          end;
        end;
        if (MainUpdateing or TreeStopit) OR (Not Atree.visible) then Exit;
        LoadnewThreadtreetableCash(locationid);

        //nfound := 0;
        For Itree := 0 to Atree.Items.Count-1 do
        begin
          if (MainUpdateing or TreeStopit) OR (Not Atree.visible) then break;
          IF {TTreeViewpagestype(Atree.Items[Itree].Data^).kind = 5} Atree.Items[Itree].Level = 4 then
          begin
            For Icash := 1 to NnewtreetableCashthread do
            begin
              if (MainUpdateing or TreeStopit) OR (Not Atree.visible) then break;
              IF (newtreetableCashthread[Icash].PressRunID > 0) and (Treetype = 2) then
              begin
                //Inc(nfound);
                IF  //(TTreeViewpagestype(Atree.Items[Itree].Data^).locationid = newtreetableCashthread[Icash].locationid) and
                    (TTreeViewpagestype(Atree.Items[Itree].Data^).pressrunid = newtreetableCashthread[Icash].pressrunid) then
                begin
                  Astate := 0;
                  makeAstate(Astate,Icash);
                  if (MainUpdateing or TreeStopit) OR (Not Atree.visible) then break;
                  Atree.Items[Itree].StateIndex := Astate;
                  TTreeViewpagestype(Atree.Items[Itree].Data^).Anyonhold := newtreetableCashthread[Icash].Anyonhold > 0;
                  break;
                end;
              End
              else
              begin
                if (MainUpdateing or TreeStopit) OR (Not Atree.visible) then break;
                IF  // (TTreeViewpagestype(Atree.Items[Itree].Data^).locationid = newtreetableCashthread[Icash].locationid) and
                   (Treetype = 1) AND (newtreetableCashthread[Icash].PressRunID = 0) and
                   (TTreeViewpagestype(Atree.Items[Itree].Data^).pubdate = newtreetableCashthread[Icash].Pubdate) And
                   (TTreeViewpagestype(Atree.Items[Itree].Data^).publicationid = newtreetableCashthread[Icash].publicationid) and
                   (TTreeViewpagestype(Atree.Items[Itree].Data^).Editionid = newtreetableCashthread[Icash].Editionid) and
                   (TTreeViewpagestype(Atree.Items[Itree].Data^).Sectionid = newtreetableCashthread[Icash].Sectionid) then
                Begin
                  IF (((newtreetableCashthread[Icash].Prodchange) or (newtreetableCashthread[Icash].StatChange)) or (true) )  then
                  begin
                    if (MainUpdateing or TreeStopit) OR (Not Atree.visible) then break;
                    TTreeViewpagestype(Atree.Items[Itree].Data^).Newstate := 100;
                    Astate := 0;
                    if (MainUpdateing or TreeStopit) OR (Not Atree.visible) then break;
                    TTreeViewpagestype(Atree.Items[Itree].Data^).Anyonhold := newtreetableCashthread[Icash].Anyonhold > 0;
                    makeAstate(Astate,Icash);
                    if (MainUpdateing or TreeStopit) OR (Not Atree.visible) then break;
                    Atree.Items[Itree].StateIndex := Astate;
                    break;
                  end;
                end;
              end;
            end;
          end;
        end;
        IF Treetype = 1 then
        begin
          if (MainUpdateing or TreeStopit) OR (Not Atree.visible) then exit;
          //Found := false;
          day := Atree.Items[0].getFirstChild;
          //dayState := 100;
          While day <> nil do
          begin
            publ := day.getFirstChild;
            publState := 100;
            //publhold := 0;
            While publ <> nil do
            begin
              if (MainUpdateing or TreeStopit) OR (Not Atree.visible) then break;
              ed := publ.getFirstChild;
              edState := 100;
              //edhold := 0;
              While ed <> nil do
              begin
                if (MainUpdateing or TreeStopit) OR (Not Atree.visible) then break;
                sec := ed.getFirstChild;
                //sechold := 0;
                secState := 100;
                While sec <> nil do
                begin
                  Calcsumstate(secState,sec.StateIndex);
                  sec.StateIndex := sec.StateIndex;
                  if (MainUpdateing or TreeStopit) OR (Not Atree.visible) then break;
                  sec := sec.getNextSibling;
                End;
                ed.StateIndex := secState;
                //edhold := sechold;
                Calcsumstate(edState,ed.StateIndex);
                ed.StateIndex := ed.StateIndex;// + edhold;
                if (MainUpdateing or TreeStopit) OR (Not Atree.visible) then break;
                ed := ed.getNextSibling;
              End;
              publ.StateIndex := edstate;
              Calcsumstate(publState,publ.StateIndex);
              publ.StateIndex := publ.StateIndex;// + edhold;
              if (MainUpdateing or TreeStopit) OR (Not Atree.visible) then break;
              publ := publ.getNextSibling;
            End;
            day.StateIndex := publstate;
            day.StateIndex := day.StateIndex;// + edhold;
            if (MainUpdateing or TreeStopit) OR (Not Atree.visible) then break;
            day := day.getNextSibling;
          end;
          //Found := true;
        end;
        {IF Treetype = 2 then //Sat h�rd til 1
        begin
          if (MainUpdateing or TreeStopit) OR (Not Atree.visible) then exit;
          Pressnode := Atree.Items[0];
          //Found := false;

          While Pressnode <> nil do
          begin
            if (MainUpdateing or TreeStopit) OR (Not Atree.visible) then break;
            day := Pressnode.getFirstChild;
            //dayState := 100;
            While day <> nil do
            begin
              if (MainUpdateing or TreeStopit) OR (Not Atree.visible) then break;
              publ := day.getFirstChild;
              publState := 100;
              //publhold := 0;
              While publ <> nil do
              begin
                if (MainUpdateing or TreeStopit) OR (Not Atree.visible) then break;
                ed := publ.getFirstChild;
                edState := 100;
                //edhold := 0;
                While ed <> nil do
                begin
                  if (MainUpdateing or TreeStopit) OR (Not Atree.visible) then break;
                  sec := ed.getFirstChild;
                  secState := 100;
                  sechold := 0;
                  While sec <> nil do
                  begin
                    if (MainUpdateing or TreeStopit) OR (Not Atree.visible) then break;
                    Calcsumstate(secState,sec.StateIndex);
                    IF TTreeViewpagestype(sec.Data^).Anyonhold then
                      sechold := 8;
                    sec.StateIndex := sec.StateIndex;// + sechold;
                    if (MainUpdateing or TreeStopit) OR (Not Atree.visible) then break;
                    sec := sec.getNextSibling;
                  End;
                  //edhold := sechold;
                  ed.StateIndex := secState;
                  Calcsumstate(edState,ed.StateIndex);
                  ed.StateIndex := ed.StateIndex;// + edhold;
                  if (MainUpdateing or TreeStopit) OR (Not Atree.visible) then break;
                  ed := ed.getNextSibling;
                End;
                //publhold := edhold;
                if (MainUpdateing or TreeStopit) OR (Not Atree.visible) then break;
                publ.StateIndex := edstate;
                Calcsumstate(publState,publ.StateIndex);
                publ.StateIndex := publ.StateIndex;// + publhold;
                if (MainUpdateing or TreeStopit) OR (Not Atree.visible) then break;
                publ := publ.getNextSibling;
              End;
              day := day.getNextSibling;
            end;
            //Found := true;
            if (MainUpdateing or TreeStopit) OR (Not Atree.visible) then break;
            Pressnode := Pressnode.getNextSibling;
          end;
          if (MainUpdateing or TreeStopit) OR (Not Atree.visible) then exit;
          Pressnode := Atree.Items[0];
          //Found := false;

        End;  }
      End;
    except
    end;
  Finally
    Setlength(newtreetableCashthread,0);
  end;
End;

procedure TDataM1.CheckAndcreateSPandTables;
Var
  T,t2 :string;
  tableMissing,spmissing : Boolean;
Begin
  try
    DataM1.Query3.SQL.Clear;
    DataM1.Query3.SQL.Add('select * from dbo.sysobjects');
    DataM1.Query3.SQL.Add('where name = ' + ''''+'PublicationMisc'+'''');
    DataM1.Query3.Open;
    tableMissing := DataM1.Query3.eof;
    DataM1.Query3.Close;
    IF tableMissing then
    begin
      DataM1.Query3.SQL.Clear;
      DataM1.Query3.SQL.add('CREATE TABLE [dbo].[PublicationMisc](');
      DataM1.Query3.SQL.add('[PublicationID] [int] NOT NULL,');
      DataM1.Query3.SQL.add('[Miscint1] [int] NULL,');
      DataM1.Query3.SQL.add('[Miscint2] [int] NULL,');
      DataM1.Query3.SQL.add('[Miscint3] [int] NULL,');
      DataM1.Query3.SQL.add('[Miscint4] [int] NULL,');
      DataM1.Query3.SQL.add('[Miscstring1] [varchar](50) NULL,');
      DataM1.Query3.SQL.add('[Miscstring2] [varchar](50) NULL,');
      DataM1.Query3.SQL.add('[Miscstring3] [varchar](50) NULL,');
      DataM1.Query3.SQL.add('[Miscstring4] [varchar](50) NULL');
      DataM1.Query3.SQL.add(') ON [PRIMARY]');
      DataM1.Query3.ExecSQL(false);
    End;

    DataM1.Query3.SQL.Clear;
    DataM1.Query3.SQL.add('select * from dbo.sysobjects');
    DataM1.Query3.SQL.add('where name = ' + ''''+'PlancenterSetup'+'''');
    DataM1.Query3.open;
    tableMissing := DataM1.Query3.eof;
    DataM1.Query3.close;
    IF tableMissing then
    begin
      DataM1.Query3.SQL.Clear;
      DataM1.Query3.SQL.add('CREATE TABLE [dbo].[PlancenterSetup] (');
      DataM1.Query3.SQL.add('[Globalsettings] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,');
      DataM1.Query3.SQL.add('[Globalvars] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,');
      DataM1.Query3.SQL.add('[minversion] [int] NULL');
      DataM1.Query3.SQL.add('[dateformat] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,');
      DataM1.Query3.SQL.add('[datetimeformat] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,');
      DataM1.Query3.SQL.add('[timeformat] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL');
      DataM1.Query3.SQL.add(') ON [PRIMARY]');
      DataM1.Query3.ExecSQL(false);
      DataM1.Query3.SQL.Clear;
      DataM1.Query3.SQL.add('Insert PlancenterSetup (Globalsettings,Globalvars,minversion)');
      DataM1.Query3.SQL.add('values ('+''''+'1'+''''+','+''''+''+''''+','+inttostr(programminorversion)+ ')');
      DataM1.Query3.ExecSQL(false);
    end;
    DataM1.Query3.SQL.Clear;
    DataM1.Query3.SQL.add('select * from dbo.sysobjects');
    DataM1.Query3.SQL.add('where name = ' + ''''+'SPplancenterpostplan3'+'''');
    DataM1.Query3.Open;
    IF DataM1.Query3.eof then
    begin
      DataM1.Query2.SQL.Clear;
      DataM1.Query2.SQL.add('CREATE PROCEDURE spPlancenterpostplan3');
      DataM1.Query2.SQL.add('@PublicationID  int,');
      DataM1.Query2.SQL.add('@Pubdate datetime,');
      DataM1.Query2.SQL.add('@PressID  int');
      DataM1.Query2.SQL.add('');
      DataM1.Query2.SQL.add('AS');
      DataM1.Query2.SQL.add('');
      DataM1.Query2.SQL.add('DECLARE @Result int');
      DataM1.Query2.SQL.add('DECLARE @Message varchar(50)');
      DataM1.Query2.SQL.add('');
      DataM1.Query2.SQL.add('SET @Result = 1');
      DataM1.Query2.SQL.add('SET @Message = '+''''+'OK'+'''');
      DataM1.Query2.SQL.add('');
      DataM1.Query2.SQL.add('Select @Result,@Message');
      DataM1.Query2.execsql;
    end;
    DataM1.Query3.Close;
    DataM1.Query3.SQL.Clear;
    DataM1.Query3.SQL.add('select * from dbo.sysobjects');
    DataM1.Query3.SQL.add('where name = ' + ''''+'SPplancenterpostplanProd3'+'''');
    DataM1.Query3.open;
    spmissing := DataM1.Query3.eof;
    DataM1.Query3.Close;
    IF spmissing then
    begin
      DataM1.Query3.SQL.Clear;
      DataM1.Query3.SQL.add('CREATE PROCEDURE [dbo].[SPplancenterpostplanProd3]');
      DataM1.Query3.SQL.add('@productionID  int');
      DataM1.Query3.SQL.add('AS');
      DataM1.Query3.SQL.add('DECLARE @Result int');
      DataM1.Query3.SQL.add('DECLARE @Message varchar(50)');
      DataM1.Query3.SQL.add('SET @Result = 1');
      DataM1.Query3.SQL.add('SET @Message = '+''''+'OK'+'''');
      DataM1.Query3.SQL.add('Select @Result,@Message');
      DataM1.Query3.SQL.add('GO');
      DataM1.Query3.ExecSQL;
    end;
    IF not localmode then
    begin
      try
(*        DataM1.Query3.SQL.Clear;
        DataM1.Query3.SQL.add('select * from dbo.sysobjects');
        DataM1.Query3.SQL.add('where name = ' + ''''+'FileServers'+'''');
        DataM1.Query3.open;
        tableMissing := DataM1.Query3.eof;
        DataM1.Query3.close;
        IF tableMissing then
        begin
          DataM1.Query3.SQL.Clear;
          DataM1.Query3.SQL.add('CREATE TABLE [dbo].[FileServers](');
          DataM1.Query3.SQL.add('[Name] [varchar](50) NOT NULL,');
          DataM1.Query3.SQL.add('[Servertype] [int] NOT NULL,');
          DataM1.Query3.SQL.add('[CCdatashare] [varchar](200) NULL,');
          DataM1.Query3.SQL.add('[Username] [varchar](50) NULL,');
          DataM1.Query3.SQL.add('[password] [varchar](50) NULL,');
          DataM1.Query3.SQL.add('[IP] [varchar](20) NULL,');
          DataM1.Query3.SQL.add('[Locationid] [int] NULL,');
          DataM1.Query3.SQL.add('[FTPServer] [varchar](50) NULL,');
          DataM1.Query3.SQL.add('[FTPFolder] [varchar](50) NULL,');
          DataM1.Query3.SQL.add('[FTPuser] [varchar](50) NULL,');
          DataM1.Query3.SQL.add('[FTPpassword] [varchar](200) NULL,');
          DataM1.Query3.SQL.add('[FTPPort] [int] NULL,');
          DataM1.Query3.SQL.add('[Inuse] [int] NULL,');
          DataM1.Query3.SQL.add('[Backupfor] [varchar](50) NULL,');
          DataM1.Query3.SQL.add('[uselocaluser] [int] NULL,');
          DataM1.Query3.SQL.add('CONSTRAINT [PK_Fileservers] PRIMARY KEY CLUSTERED');
          DataM1.Query3.SQL.add(' ( [Name] ASC,');
          DataM1.Query3.SQL.add('[Servertype] ASC ');
          DataM1.Query3.SQL.add(')WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
          DataM1.Query3.SQL.add(') ON [PRIMARY]');
          DataM1.Query3.Execsql;
        end;
        *)

        DataM1.Query1.SQL.Clear;
        DataM1.Query1.SQL.Add('Select TOP 1 LocationID,CCdatashare,Name,IP,uselocaluser,Username,password From FileServers where (Servertype = 1 OR ServerType = 11) ORDER BY ServerType DESC');
        DataM1.Query1.Open;
        if not datam1.Query1.Eof then
        begin
          T :=  Trim(DataM1.Query1.fields[3].AsString);
          if T <> '' then
            T := '\\'+ T +'\'+ Trim(DataM1.Query1.fields[1].AsString)+'\'
          else
            T := '\\'+Trim(DataM1.Query1.fields[2].AsString)+'\'+Trim(DataM1.Query1.fields[1].AsString)+'\';
          Prefs.CCFilesPath := T + 'CCfiles';
          Prefs.CCPreviewPath := T + 'CCpreviews';
          Prefs.CCThumbnailPath := T + 'CCthumbnails';
          MAINCC := T;
          MainCCDATA := UpperCase(Prefs.CCFilesPath);
          MainCCConfig := T + 'CCCONFIG\';
          Commentconfigfilename := IncludeTrailingBackslash(MainCCConfig)+'Commentnames.ini';
        End;
        datam1.Query1.Close;
      Except
      end;
    End;
    DataM1.Query3.SQL.Clear;
    DataM1.Query3.SQL.add('select * from dbo.sysobjects');
    DataM1.Query3.SQL.add('where name = ' + ''''+'spCustomRelease'+'''');
    DataM1.Query3.open;
    spmissing := DataM1.Query3.eof;
    DataM1.Query3.close;
    IF spmissing then
    begin
      DataM1.Query3.SQL.Clear;
      DataM1.Query3.SQL.add('Create PROCEDURE spCustomRelease');
      DataM1.Query3.SQL.add('@CopyFlatSeparationSet int,');
      DataM1.Query3.SQL.add('@Hold int = 0,');
      DataM1.Query3.SQL.add('@ColorID int = 0,');
      DataM1.Query3.SQL.add('@CopyNumber int = 0');
      DataM1.Query3.SQL.add('AS');
      DataM1.Query3.SQL.add('BEGIN');
      DataM1.Query3.SQL.add('SET @CopyFlatSeparationSet = 0');
      DataM1.Query3.SQL.add('/*');
      DataM1.Query3.SQL.add('	SET NOCOUNT ON;');
      DataM1.Query3.SQL.add('	DECLARE @PublicationID int');
      DataM1.Query3.SQL.add('	SET @PublicationID = (SELECT TOP 1 PublicationID FROM PageTable WITH (NOLOCK) WHERE CopyFlatSeparationSet=@CopyFlatSeparationSet)');
      DataM1.Query3.SQL.add('	DECLARE @PubDate datetime');
      DataM1.Query3.SQL.add('	SET @PubDate = (SELECT TOP 1 PubDate FROM PageTable WITH (NOLOCK) WHERE CopyFlatSeparationSet=@CopyFlatSeparationSet)');
      DataM1.Query3.SQL.add('	DECLARE @EditionID datetime');
      DataM1.Query3.SQL.add('	SET @EditionID = (SELECT TOP 1 EditionID FROM PageTable WITH (NOLOCK) WHERE CopyFlatSeparationSet=@CopyFlatSeparationSet)');
      DataM1.Query3.SQL.add('	DECLARE @PressID datetime');
      DataM1.Query3.SQL.add('	SET @PressID = (SELECT TOP 1 PressID FROM PageTable WITH (NOLOCK) WHERE CopyFlatSeparationSet=@CopyFlatSeparationSet)');
      DataM1.Query3.SQL.add('	DECLARE @MiscString3 varchar(50)');
      DataM1.Query3.SQL.add('	SET @MiscString3 = (SELECT TOP 1 MiscString3 FROM PageTable WITH (NOLOCK) WHERE CopyFlatSeparationSet=@CopyFlatSeparationSet)');
      DataM1.Query3.SQL.add('	*/');
      DataM1.Query3.SQL.add('END');
      DataM1.Query3.ExecSQL;
    end;
    DataM1.Query3.SQL.Clear;
    DataM1.Query3.SQL.add('select * from dbo.sysobjects');
    DataM1.Query3.SQL.add('where name = ' + ''''+'spCustomRetransmit'+'''');
    DataM1.Query3.open;
    spmissing := DataM1.Query3.eof;
    DataM1.Query3.close;
    IF spmissing then
    begin
      DataM1.Query3.SQL.Clear;
      DataM1.Query3.SQL.add('Create PROCEDURE spCustomRetransmit');
      DataM1.Query3.SQL.add('@CopyFlatSeparationSet int,');
      DataM1.Query3.SQL.add('@ColorID int = 0');
      DataM1.Query3.SQL.add('AS');
      DataM1.Query3.SQL.add('BEGIN');
      DataM1.Query3.SQL.add('SET @CopyFlatSeparationSet = 0');
      DataM1.Query3.SQL.add('	/*');
      DataM1.Query3.SQL.add('	SET NOCOUNT ON;');
      DataM1.Query3.SQL.add('	DECLARE @PublicationID int');
      DataM1.Query3.SQL.add('	SET @PublicationID = (SELECT TOP 1 PublicationID FROM PageTable WITH (NOLOCK) WHERE CopyFlatSeparationSet=@CopyFlatSeparationSet)');
      DataM1.Query3.SQL.add('	DECLARE @PubDate datetime');
      DataM1.Query3.SQL.add('	SET @PubDate = (SELECT TOP 1 PubDate FROM PageTable WITH (NOLOCK) WHERE CopyFlatSeparationSet=@CopyFlatSeparationSet)');
      DataM1.Query3.SQL.add('	DECLARE @EditionID datetime');
      DataM1.Query3.SQL.add('	SET @EditionID = (SELECT TOP 1 EditionID FROM PageTable WITH (NOLOCK) WHERE CopyFlatSeparationSet=@CopyFlatSeparationSet)');
      DataM1.Query3.SQL.add('	DECLARE @PressID datetime');
      DataM1.Query3.SQL.add('	SET @PressID = (SELECT TOP 1 PressID FROM PageTable WITH (NOLOCK) WHERE CopyFlatSeparationSet=@CopyFlatSeparationSet)');
      DataM1.Query3.SQL.add('	DECLARE @MiscString2 varchar(50)');
      DataM1.Query3.SQL.add('	SET @MiscString2 = (SELECT TOP 1 MiscString2 FROM PageTable WITH (NOLOCK) WHERE CopyFlatSeparationSet=@CopyFlatSeparationSet)');
      DataM1.Query3.SQL.add('	*/');
      DataM1.Query3.SQL.add('END');
      DataM1.Query3.ExecSQL;
    end;

  except
  end;
//spCustomRelease
end;

Function TDataM1.GetSpParamCount(spname : string):Longint;
Begin
  result := 0;
  try
    DataM1.Query3.SQL.Clear;
    DataM1.Query3.SQL.add(' select count (distinct name)  from sys.all_parameters');
    DataM1.Query3.SQL.add('	where object_id = (select top 1 object_id  from sys.objects ');
    DataM1.Query3.SQL.add('	where name =  ' + ''''+spname+'''' + ')');
    if Prefs.debug then DataM1.Query3.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'chkspsize.sql');
    DataM1.Query3.open;
    if not DataM1.Query3.eof then
      result := DataM1.Query3.fields[0].asinteger;
    DataM1.Query3.close;
  except
  end;
end;

// NOTE : SELECT IS FIRED PRIOR TO CALLING THIS FUNCTION!
Function TDataM1.loadAllPlateSQL(usePossiblepressrunid :Boolean):Boolean;
Var
  aktpressrunidOK : Boolean;
  i,ip,datasize,dbtype,aktpressrunid : Longint;
//  T : String;
Begin

  NPagetabeldb := 0;
  datasize := 10;
  SetLength(Pagetabeldb,datasize);
  result := false;
  try
    Try
      IF Prefs.debug then datam1.SQLQuerypagetable.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'loadplateviewAllplate.sql');
      formmain.tryopen(datam1.SQLQuerypagetable);
      IF datam1.SQLQuerypagetable.eof then
      begin
        datam1.SQLQuerypagetable.Close;
        exit;
      end;
      result := false;
      writeMainlogfile('loadAPlate start ' + inttostr(0));
      i := 0;
      dbtype := 1;
      if (PageTableFieldCount >= 80) then
         dbtype := 2;
      if (PageTableFieldCount >= 95) then
         dbtype := 3;
      //if datam1.SQLQuerypagetable.FieldCount >= 80 then
      //  dbtype := 2;
     // if datam1.SQLQuerypagetable.FieldCount >= 95 then
     //   dbtype := 3;
      aktpressrunidOK := false;
      aktpressrunid := -1;
      While not datam1.SQLQuerypagetable.eof do
      Begin
        IF usePossiblepressrunid then
        begin
          IF (aktpressrunid <> datam1.SQLQuerypagetable.fields[39].AsInteger) then
          begin
            aktpressrunid := datam1.SQLQuerypagetable.fields[39].AsInteger;
            aktpressrunidOK := false;
            for ip := 1 to NPossiblepressrunid do
            begin
              IF Possiblepressrunid[ip] = aktpressrunid then
              begin
                aktpressrunidOK := true;
                break;
              end;
            end;
          end;
        End
        Else
          aktpressrunidOK := true;
        IF aktpressrunidOK then
        Begin
          Inc(i);
          IF I+5 > datasize then
          begin
            Inc(datasize,100);
            SetLength(Pagetabeldb,datasize);
          end;
          With Pagetabeldb[i] do
          begin
            NPagetabeldb := i;
            CopySeparationSet := datam1.SQLQuerypagetable.fields[0].asInteger;
            SeparationSet := datam1.SQLQuerypagetable.fields[1].AsInteger;
            Separation := datam1.SQLQuerypagetable.fields[2].AsInteger;
            CopyFlatSeparationSet := datam1.SQLQuerypagetable.fields[3].AsInteger;
            MasterCopyFlatSeparationSet := datam1.SQLQuerypagetable.fields[3].AsInteger;
            FlatSeparationSet := datam1.SQLQuerypagetable.fields[4].AsInteger;
            FlatSeparation := datam1.SQLQuerypagetable.fields[5].AsInteger;
            Status := datam1.SQLQuerypagetable.fields[6].AsInteger;
            ExternalStatus := datam1.SQLQuerypagetable.fields[7].AsInteger;
            PublicationID := datam1.SQLQuerypagetable.fields[8].AsInteger;
            SectionID := datam1.SQLQuerypagetable.fields[9].AsInteger;
            EditionID := datam1.SQLQuerypagetable.fields[10].AsInteger;
            IssueID := datam1.SQLQuerypagetable.fields[11].AsInteger;
            PubDate := datam1.SQLQuerypagetable.fields[12].Asdatetime;
            PageName  := datam1.SQLQuerypagetable.fields[13].Asstring;
            ColorID := datam1.SQLQuerypagetable.fields[14].AsInteger;
            TemplateID := datam1.SQLQuerypagetable.fields[15].AsInteger;
            ProofID := datam1.SQLQuerypagetable.fields[16].AsInteger;
            DeviceID  := datam1.SQLQuerypagetable.fields[17].AsInteger;
            Version := datam1.SQLQuerypagetable.fields[18].AsInteger;
            Layer := datam1.SQLQuerypagetable.fields[19].AsInteger;
            CopyNumber := datam1.SQLQuerypagetable.fields[20].AsInteger;
            Pagination  := datam1.SQLQuerypagetable.fields[21].AsInteger;
            Approved := datam1.SQLQuerypagetable.fields[22].AsInteger;
            Hold := datam1.SQLQuerypagetable.fields[23].AsInteger;
            Active := datam1.SQLQuerypagetable.fields[24].AsInteger;
            Priority  := datam1.SQLQuerypagetable.fields[25].AsInteger;
            PagePosition  := datam1.SQLQuerypagetable.fields[26].AsInteger;
            PageType := datam1.SQLQuerypagetable.fields[27].AsInteger;
            PagesOnPlate := datam1.SQLQuerypagetable.fields[28].AsInteger;
            SheetNumber := datam1.SQLQuerypagetable.fields[29].AsInteger;
            SheetSide :=        datam1.SQLQuerypagetable.fields[30].AsInteger;
            PressID :=          datam1.SQLQuerypagetable.fields[31].AsInteger;
            PressSectionNumber  := datam1.SQLQuerypagetable.fields[32].AsInteger;
            SortingPosition  := datam1.SQLQuerypagetable.fields[33].Asstring;
            PressTower  :=      datam1.SQLQuerypagetable.fields[34].Asstring;
            PressCylinder  :=   datam1.SQLQuerypagetable.fields[35].Asstring;
            PressZone  :=       datam1.SQLQuerypagetable.fields[36].Asstring;
            PressHighLow  :=    datam1.SQLQuerypagetable.fields[37].Asstring;
            ProductionID :=     datam1.SQLQuerypagetable.fields[38].AsInteger;
            PressRunID :=       datam1.SQLQuerypagetable.fields[39].AsInteger;
            ProofStatus  :=     datam1.SQLQuerypagetable.fields[40].AsInteger;
            InkStatus  :=       datam1.SQLQuerypagetable.fields[41].AsInteger;
            PlanPageName  :=    datam1.SQLQuerypagetable.fields[42].Asstring;
            IssueSequenceNumber  := datam1.SQLQuerypagetable.fields[43].AsInteger;
            MasterCopySeparationSet := datam1.SQLQuerypagetable.fields[44].AsInteger;
            UniquePage :=       datam1.SQLQuerypagetable.fields[45].AsInteger;
            LocationID :=       datam1.SQLQuerypagetable.fields[46].AsInteger;
            FlatProofConfigurationID  := datam1.SQLQuerypagetable.fields[47].AsInteger;
            FlatProofStatus  := datam1.SQLQuerypagetable.fields[48].AsInteger;
            Creep :=            datam1.SQLQuerypagetable.fields[49].AsFloat;
            MarkGroups  :=      datam1.SQLQuerypagetable.fields[50].Asstring;
            PageIndex  :=       datam1.SQLQuerypagetable.fields[51].AsInteger;
            GutterImage  :=     datam1.SQLQuerypagetable.fields[52].AsInteger;
            Outputversion  :=   datam1.SQLQuerypagetable.fields[53].AsInteger;
            HardProofConfigurationID  := datam1.SQLQuerypagetable.fields[54].AsInteger;
            HardProofStatus  := datam1.SQLQuerypagetable.fields[55].AsInteger;
            FileServer  :=      datam1.SQLQuerypagetable.fields[56].Asstring;
            Dirty  :=           datam1.SQLQuerypagetable.fields[57].AsInteger;
            InputTime :=        datam1.SQLQuerypagetable.fields[58].Asdatetime;
            ApproveTime :=      datam1.SQLQuerypagetable.fields[59].Asdatetime;
            ReadyTime :=        datam1.SQLQuerypagetable.fields[60].Asdatetime;
            OutputTime :=       datam1.SQLQuerypagetable.fields[61].Asdatetime;
            VerifyTime :=       datam1.SQLQuerypagetable.fields[62].Asdatetime;
            ApproveUser  :=     datam1.SQLQuerypagetable.fields[63].Asstring;
            FileName :=         datam1.SQLQuerypagetable.fields[64].Asstring;
            LastError :=        datam1.SQLQuerypagetable.fields[65].Asstring;
            Comment  :=         datam1.SQLQuerypagetable.fields[66].Asstring;
            DeadLine :=         datam1.SQLQuerypagetable.fields[67].Asdatetime;
            InputID  :=         datam1.SQLQuerypagetable.fields[68].AsInteger;
            PagePositions  :=   datam1.SQLQuerypagetable.fields[69].Asstring;
            InputProcessID  :=  datam1.SQLQuerypagetable.fields[70].AsInteger;
            SoftProofProcessID  := datam1.SQLQuerypagetable.fields[71].AsInteger;
            HardProofProcessID  := datam1.SQLQuerypagetable.fields[72].AsInteger;
            TransmitProcessID := datam1.SQLQuerypagetable.fields[73].AsInteger;
            ImagingProcessID  := datam1.SQLQuerypagetable.fields[74].AsInteger;
            InkProcessID  :=    datam1.SQLQuerypagetable.fields[75].AsInteger;
            OutputPriority  :=  datam1.SQLQuerypagetable.fields[76].AsInteger;
            PressTime :=        datam1.SQLQuerypagetable.fields[77].Asdatetime;
            CustomerID  :=      datam1.SQLQuerypagetable.fields[78].AsInteger;
            IF dbtype > 1 then
            begin
              EmailStatus  :=     datam1.SQLQuerypagetable.fields[79].AsInteger;
              Miscint1 :=         datam1.SQLQuerypagetable.fields[80].AsInteger;
              Miscint2  :=        datam1.SQLQuerypagetable.fields[81].AsInteger;
              Miscint3  :=        datam1.SQLQuerypagetable.fields[82].AsInteger;
              Miscint4  :=        datam1.SQLQuerypagetable.fields[83].AsInteger;
              Miscstring1  :=     datam1.SQLQuerypagetable.fields[84].Asstring;
              Miscstring2  :=     datam1.SQLQuerypagetable.fields[85].Asstring;
              Miscstring3  :=     datam1.SQLQuerypagetable.fields[86].Asstring;
              Miscdate :=         datam1.SQLQuerypagetable.fields[87].Asdatetime;
            End;
            if dbtype > 2 then
            Begin
              PdfMaster :=        datam1.SQLQuerypagetable.fields[88].AsInteger;
              FlatMaster :=       datam1.SQLQuerypagetable.fields[89].AsInteger;
              PageFormatID :=     datam1.SQLQuerypagetable.fields[90].AsInteger;
              RipSetupID :=       datam1.SQLQuerypagetable.fields[91].AsInteger;
              FanoutID :=         datam1.SQLQuerypagetable.fields[92].AsInteger;
              PageCategoryID :=   datam1.SQLQuerypagetable.fields[93].AsInteger;
              if (Global_HasPlateStatusField) then
              begin
                DeviceGroupID  :=   datam1.SQLQuerypagetable.fields[94].AsInteger;
                PlateStatus  :=     datam1.SQLQuerypagetable.fields[95].AsInteger;
                PostOutputVersion  := datam1.SQLQuerypagetable.fields[96].AsInteger;
              end
              else
              begin
                DeviceGroupID := 0;
                PlateStatus := 0;
                PostOutputVersion := 0;
              end;
            End;
            altpagename := PageName;
            altsheetname := inttostr(SheetNumber);
            if (Prefs.AlternativePageNameField <> '') then
              altpagename := DataM1.SQLQuerypagetable.fieldbyname(Prefs.AlternativePageNameField).Asstring;
            if (Prefs.AlternativeSheetnameField <> '') then
              altsheetname := DataM1.SQLQuerypagetable.fieldbyname(Prefs.AlternativeSheetnameField).Asstring;
          End;
        End;
        datam1.SQLQuerypagetable.next;
      End;
      datam1.SQLQuerypagetable.close;
      pagetableloadstatus := true;
      writeMainlogfile('loadAPlate  no exception');
    Except
      on E: Exception do
       Begin
         writeMainlogfile('loadAPlate ' + e.Message);
       end;
    end;
    pagetableloadstatus := false;
  Finally
  end;
  writeMainlogfile('loadAPlate end ' + inttostr(0));
end;




function TDataM1.ConnectToServerErrorFileThread: Boolean;
Var
  ini: TIniFile;
  anyerror: Boolean;
  connFile: string;
  ConnectionName : string;
begin


  //FormMain.writeinitlog('Connect to DB server (ErrorFileThread) ');
  anyerror := false;
  ConnectionName := 'SQLConnectionErrorFileThread';
   {
  try
    connFile := IncludeTrailingBackSlash(TUtils.GetTempDirectory())  + ConnectionName + '.ini';
    ini := TIniFile.Create(connFile);
    if Prefs.DBInstance <> '' then
      ini.WriteString(ConnectionName, 'HostName', Prefs.DBServerName + '\' + Prefs.DBInstance)
    else
      ini.WriteString(ConnectionName, 'HostName', Prefs.DBServerName);

    ini.WriteString( ConnectionName, 'DataBase', Prefs.DBDatabase);
    ini.WriteString( ConnectionName, 'User_Name', Prefs.DBUser);
    ini.WriteString( ConnectionName, 'Password',  Prefs.DBPassword);
    ini.WriteString( ConnectionName, 'OS Authentication', 'False');
    ini.UpdateFile;
    ini.free;
  except
    on E: Exception do
    begin
      FormMain.writeinitlog('Exception writing ' + connFile + ' - ' + E.Message);
    end;
  end;
  }

  if SQLConnectionErrorFileThread.Connected then
  begin
    SQLConnectionErrorFileThread.Close;
    SQLConnectionErrorFileThread.Connected := false;
  end;
  //Datam1.SQLConnectionErrorFileThread.LoadParamsFromIniFile(connFile);
  SQLConnectionErrorFileThread.Params.Clear;
  SQLConnectionErrorFileThread.Params.Add('User_Name='+ Prefs.DBUser);
  SQLConnectionErrorFileThread.Params.Add('Password=' + Prefs.DBPassword);
  if Prefs.DBInstance <> '' then
    SQLConnectionErrorFileThread.Params.Add('HostName=' + Prefs.DBServerName + '\' + Prefs.DBInstance)
  else
     SQLConnectionErrorFileThread.Params.Add('HostName=' +  Prefs.DBServerName);
  SQLConnectionErrorFileThread.Params.Add('Database=' +  Prefs.DBDatabase);
  SQLConnectionErrorFileThread.Params.Add('VendorLib=not used');
  // Force commenction params
  SetParamters(ConnectionName,Prefs.DBreconnect, Prefs.DBFetchAll,
                    Prefs.DBCommandTimeout, Prefs.DBUser = '');

  try
    SQLConnectionErrorFileThread.Open;
    FormMain.writeinitlog('Connected to server -  SQLConnectionErrorFileThread');
  Except
    on E: Exception do
    begin
      anyerror := true;
      FormMain.writeinitlog('Unable to connect to server (SQLConnectionErrorFileThread) - ' + e.Message);
    end;
  end;

  result := not anyerror;
end;

function TDataM1.DisConnectFromServerErrorFileThread: Boolean;
begin
  if SQLConnectionErrorFileThread.Connected then
  begin
    SQLConnectionErrorFileThread.Close;
    SQLConnectionErrorFileThread.Connected := false;
  end;
  result := true;
end;



function TDataM1.ConnectToServerTreeThread: Boolean;
Var
  ini: TIniFile;
  anyerror: Boolean;
  connFile: string;
  ConnectionName : string;
begin


  FormMain.writeinitlog('Connect to DB server 1 ');
  anyerror := false;
  ConnectionName := 'SQLConnectionTreeState';
{
  try
    connFile := IncludeTrailingBackSlash(TUtils.GetTempDirectory())  + ConnectionName + '.ini';
    ini := TIniFile.Create(connFile);
    if Prefs.DBInstance <> '' then
      ini.WriteString(ConnectionName, 'HostName', Prefs.DBServerName + '\' + Prefs.DBInstance)
    else
      ini.WriteString(ConnectionName, 'HostName', Prefs.DBServerName);

    ini.WriteString( ConnectionName, 'DataBase', Prefs.DBDatabase);
    ini.WriteString( ConnectionName, 'User_Name', Prefs.DBUser);
    ini.WriteString( ConnectionName, 'Password',  Prefs.DBPassword);
    ini.WriteString( ConnectionName, 'OS Authentication', 'False');
    ini.UpdateFile;
    ini.free;
  except
    on E: Exception do
    begin
      FormMain.writeinitlog('Exception writing ' + connFile + ' - ' + E.Message);
    end;
  end;        }

  if SQLConnectionTreestate.Connected then
  begin
    SQLConnectionTreestate.Close;
    SQLConnectionTreestate.Connected := false;
  end;
 // SQLConnectionErrorFileThread.LoadParamsFromIniFile(connFile);

  SQLConnectionTreestate.Params.Clear;
  SQLConnectionTreestate.Params.Add('User_Name='+ Prefs.DBUser);
  SQLConnectionTreestate.Params.Add('Password=' + Prefs.DBPassword);
  if Prefs.DBInstance <> '' then
    SQLConnectionTreestate.Params.Add('HostName=' + Prefs.DBServerName + '\' + Prefs.DBInstance)
  else
     SQLConnectionTreestate.Params.Add('HostName=' +  Prefs.DBServerName);
  SQLConnectionTreestate.Params.Add('Database=' +  Prefs.DBDatabase);
  SQLConnectionTreestate.Params.Add('VendorLib=not used');
  SetParamters(ConnectionName,Prefs.DBreconnect, Prefs.DBFetchAll,
                    Prefs.DBCommandTimeout, Prefs.DBUser = '');

  try
    SQLConnectionTreestate.Open;
   // FormMain.writeinitlog('Connected to server -  SQLConnectionTreestate');
  Except
    on E: Exception do
    begin
      anyerror := true;
      FormMain.writeinitlog('Unable to connect to server (SQLConnectionTreestate) - ' + e.Message);
    end;
  end;

  result := not anyerror;
end;


function TDataM1.DisConnectFromServerTreeThread: Boolean;
begin
  if SQLConnectionTreestate.Connected then
  begin
    SQLConnectionTreestate.Close;
    SQLConnectionTreestate.Connected := false;
  end;
  result := true;
end;

function  TDataM1.CheckDBTreeThread : Boolean;
var
  DBOK : Boolean;
begin
    DBOK := false;
    try

      SQLQueryTreethread.SQL.Clear;
      SQLQueryTreethread.SQL.Add('Select servername from GeneralPreferences (NOLOCK) ');
      SQLQueryTreethread.Open;
      DBOK := true;
      SQLQueryTreethread.Close;
    Except
      DBOK := false;
  end;
   result :=  DBOK;
end;

function TDataM1.ConnectToServerDeviceState: Boolean;
Var
  ini: TIniFile;
  anyerror: Boolean;
  connFile: string;
  ConnectionName : string;
begin


//  FormMain.writeinitlog('Connect to DB server 1 ');
  anyerror := false;
  ConnectionName := 'SQLConnectionDeviceState';
{
  try
    connFile := IncludeTrailingBackSlash(TUtils.GetTempDirectory())  + ConnectionName + '.ini';
    ini := TIniFile.Create(connFile);
    if Prefs.DBInstance <> '' then
      ini.WriteString(ConnectionName, 'HostName', Prefs.DBServerName + '\' + Prefs.DBInstance)
    else
      ini.WriteString(ConnectionName, 'HostName', Prefs.DBServerName);

    ini.WriteString( ConnectionName, 'DataBase', Prefs.DBDatabase);
    ini.WriteString( ConnectionName, 'User_Name', Prefs.DBUser);
    ini.WriteString( ConnectionName, 'Password',  Prefs.DBPassword);
    ini.WriteString( ConnectionName, 'OS Authentication', 'False');
    ini.UpdateFile;
    ini.free;
  except
    on E: Exception do
    begin
      FormMain.writeinitlog('Exception writing ' + connFile + ' - ' + E.Message);
    end;
  end;        }

  if SQLConnectionDeviceState.Connected then
  begin
    SQLConnectionDeviceState.Close;
    SQLConnectionDeviceState.Connected := false;
  end;
 // SQLConnectionErrorFileThread.LoadParamsFromIniFile(connFile);

  SQLConnectionDeviceState.Params.Clear;
  SQLConnectionDeviceState.Params.Add('User_Name='+ Prefs.DBUser);
  SQLConnectionDeviceState.Params.Add('Password=' + Prefs.DBPassword);
  if Prefs.DBInstance <> '' then
    SQLConnectionDeviceState.Params.Add('HostName=' + Prefs.DBServerName + '\' + Prefs.DBInstance)
  else
     SQLConnectionDeviceState.Params.Add('HostName=' +  Prefs.DBServerName);
  SQLConnectionDeviceState.Params.Add('Database=' +  Prefs.DBDatabase);
  SQLConnectionDeviceState.Params.Add('VendorLib=not used');
  SetParamters(ConnectionName,Prefs.DBreconnect, Prefs.DBFetchAll,
                    Prefs.DBCommandTimeout, Prefs.DBUser = '');

  try
    SQLConnectionDeviceState.Open;
  //  FormMain.writeinitlog('Connected to server -  SQLConnectionDeviceState');
  Except
    on E: Exception do
    begin
      anyerror := true;
      FormMain.writeinitlog('Unable to connect to server (SQLConnectionDeviceState) - ' + e.Message);
    end;
  end;

  result := not anyerror;
end;


function TDataM1.DisConnectFromServerDeviceState: Boolean;
begin
  if SQLConnectionDeviceState.Connected then
  begin
    SQLConnectionDeviceState.Close;
    SQLConnectionDeviceState.Connected := false;
  end;
  result := true;
end;



function  TDataM1.CheckDBDeviceState: Boolean;
var
  DBOK : Boolean;
begin
    DBOK := false;
    try

      SQLQuerydevcontrol.SQL.Clear;
      SQLQuerydevcontrol.SQL.Add('Select servername from GeneralPreferences (NOLOCK) ');
      SQLQuerydevcontrol.Open;
      DBOK := true;
      SQLQuerydevcontrol.Close;
    Except
      DBOK := false;
  end;
   result :=  DBOK;
end;

function TDataM1.ConnectToServer: Boolean;
Var
  ini: TIniFile;
  anyerror: Boolean;
  connFile: string;
begin


  FormMain.writeinitlog('Connect to DB server 1 ');
  anyerror := false;


  if CRSQLConnectionplan.Connected then
  begin
    CRSQLConnectionplan.Close;
    CRSQLConnectionplan.Connected := false;
  end;

  FormMain.writeinitlog('Connect to server 3');
  //Datam1.CRSQLConnectionplan.LoadParamsFromIniFile(connFile);

  CRSQLConnectionplan.Params.Clear;
  CRSQLConnectionplan.Params.Add('User_Name='+ Prefs.DBUser);
  CRSQLConnectionplan.Params.Add('Password=' + Prefs.DBPassword);
  if Prefs.DBInstance <> '' then
    CRSQLConnectionplan.Params.Add('HostName=' + Prefs.DBServerName + '\' + Prefs.DBInstance)
  else
     CRSQLConnectionplan.Params.Add('HostName=' +  Prefs.DBServerName);
  CRSQLConnectionplan.Params.Add('Database=' +  Prefs.DBDatabase);
  CRSQLConnectionplan.Params.Add('VendorLib=not used');

  FormMain.writeinitlog('Connect to server 4');

  // Force commenction params
  SetParamters('',Prefs.DBreconnect, Prefs.DBFetchAll,
    Prefs.DBCommandTimeout, Prefs.DBUser = '');
  FormMain.writeinitlog('Connect to server 5');

  try
    FormMain.writeinitlog('Connect to server 6');
    CRSQLConnectionplan.Open;
    FormMain.writeinitlog('Connected to server (CRSQLConnectionplan)');

  Except
    on E: Exception do
    begin
      anyerror := true;
      // MessageDlg('Unable to connect to server - ' + e.Message, mtError,[mbOk], 0);
      // Application.Terminate;
        FormMain.writeinitlog('Exception in ConnectToServer CRSQLConnectionplan) -' + e.Message);
    end;
  end;

  // opens query...
  if (not anyerror) then
    FormMain.Getnewsystemtype;

  result := not anyerror;
end;

function TDataM1.DisConnectFromServer: Boolean;
begin
  if CRSQLConnectionplan.Connected then
  begin
    CRSQLConnectionplan.Close;
    CRSQLConnectionplan.Connected := false;
  end;
  result := true;
end;


function TDataM1.TableExists(tableName:string) : Boolean;
begin
   result := false;
   Query3.SQL.Clear;
   Query3.SQL.Add('select * from dbo.sysobjects');
   Query3.SQL.Add('where name = ' + QuotedStr(tableName));
   Query3.Open;
   result := not Query3.Eof;
   Query3.Close;
end;

function TDataM1.TableFieldExists(tableName:string; fieldName:string) : Boolean;
var
  i: Integer;
begin
  result  := false;
  Datam1.Query3.SQL.Clear;
  Datam1.Query3.SQL.Add('SELECT TOP 1 * FROM ' + tableName + ' WITH (NOLOCK)');
  Datam1.Query3.Open;
  for i := 0 to Datam1.Query3.Fields.Count - 1 do
  begin
    if AnsiCompareText(Datam1.Query3.Fields[i].FieldName, fieldName) = 0 then
    begin
      result := true;
      break;
    end;
  end;
  Datam1.Query3.Close;
end;

function TDataM1.StoredProcedureExists(spName:string) : Boolean;
begin
   result := false;
   Query3.SQL.Clear;
   Query3.SQL.Add('select * from dbo.sysobjects');
   Query3.SQL.Add('where name = ' + QuotedStr(spName));
   Query3.Open;
   result := not Query3.Eof;
   Query3.Close;
end;

function TDataM1.StoredProcedureParameterExists(spName: string; parameterName : String): Boolean;
begin

  result := false;
  Datam1.Query3.SQL.Clear;
  Datam1.Query3.SQL.Add('exec sp_sproc_columns ' + QuoteDStr(spName));
  Datam1.Query3.Open;
  while not Datam1.Query3.Eof do
  begin
    if (AnsiCompareText(Datam1.Query3.Fields[3].AsString,parameterName) = 0) then
    begin
      result := true;
      break;
    end;
    Datam1.Query3.Next;
  end;
  Datam1.Query3.Close;
end;

function TDataM1.TableHasData(tableName: string) : Boolean;
begin
  result := false;
  Datam1.Query3.SQL.Clear;
  Datam1.Query3.SQL.Add('SELECT TOP 1 * FROM ' + tableName);
  Datam1.Query3.Open;
  if not Datam1.Query3.Eof then
    result := true;
  Datam1.Query3.Close;
end;

function TDataM1.HasEvent(eventNumber: Integer) : Boolean;
begin
  result := false;
  Datam1.Query3.SQL.Clear;
  Datam1.Query3.SQL.Add('select TOP 1 EventNumber from EventCodes WHERE EventNumber=' + IntToStr(eventNumber));
  Datam1.Query3.Open;
  if not Datam1.Query3.Eof then
    result := true;
  Datam1.Query3.Close;
end;

procedure TDataM1.InsertEvent(eventNumber: Integer;EventName: string);
begin
    Datam1.Query3.SQL.Clear;
    Datam1.Query3.SQL.Add('INSERT INTO EventCodes (EventNumber,EventName) VALUES (' + IntToStr(eventNumber) + ',' + QuotedStr(EventName) + ')');
   Datam1.Query3.ExecSQL(false);
end;


end.
