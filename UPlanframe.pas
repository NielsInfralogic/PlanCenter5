unit UPlanframe;
interface
uses
  utypes,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, PBExListview, StdCtrls, ImgList, ExtCtrls, ToolWin,
  ActnMan, ActnCtrls, System.ImageList;
//Const
  //TOTMaxplateframes = 100;
type
  Tnamearray = array of string;
  Tprodcolorsrec =  record
                      TmpInt            : Integer;
                      Separation        : Int64;
                      FlatSeparation    : Int64;
                      Layer             : Integer;
                      colorid           : Integer;
                      OrgeditionID      : Integer;
                      DoubleBurned      : Boolean;
                      copynumber        : Integer;
                      Uniquepage        : Integer;
                      active            : Integer;
                      status            : Integer;
                      Proofstatus       : Integer;
                      Approved          : Integer;
                      priority          : Integer;
                      Hold              : Integer;
                      Foundlevel        : Integer;
                      Miscint1          : integer;
                      Miscint2          : integer;
                      Miscint3          : integer;
                      Miscint4          : integer;
                      Miscstring1       : Integer;
                      Miscstring2       : Integer;
                      Miscstring3       : Integer;
                      stackpos          : Integer;
                      High              : Integer;
                      Cylinder          : Integer;
                      Findresult        : Integer;
                    end;
  Tprodpage = Record
                      pageid                : Integer;
                      masterpageid          : Integer;
                      EidIP        : Integer;
                      TmpInt            : Integer;
                      totapproval       : Integer;
                      position          : trect;
                      Anyheld           : boolean;
                      totUniquePage     : Integer;
                      Antipanorama      : Integer; //pairpos
                      pagetype          : Integer; //set pagetype 0 norm 1 pano 2 anti 3 dummy
                      Creep             : double;
                      SectionID         : Integer;
                      pagename          : string; //String[50];
                      fileserver        : string;
                      MasterCopySeparationSet : Integer;
                      PDFMaster               : Integer;
                      CopySeparationSet : Integer;
                      OrgCopySeparationSet : Integer;
                      SeparationSet     : Integer;
                      Ncolors           : Integer;
                      pagestatus        : Integer;
                      proofed           : Boolean;
                      approved          : Integer;
                      OrgeditionID      : Integer;
                      Pagina            : Integer;
                      pageindex         : Integer;
                      orgpageindex      : Integer;
                      pagechange        : Boolean;
                      proofid           : Integer;
                      OrgPageiplf       : Integer;
                      OrgPageipl        : Integer;
                      OrgPageip         : Integer;
                      Oldrunid          : Integer;
                      FoundAMaster      : Integer;
                      PageRotation      : Integer;
                      RipSetupID        : Integer;
                      PageFormatID      : Integer;
                      colors : Array[1..16] of Tprodcolorsrec;
              end;
  tprodpagesarray = array[1..32] of Tprodpage;
  Tprodplate = record
                  collection            : Integer;
                  prepaired             : Boolean;
                  TmpInt                : Integer;
                  Changed               : Boolean;
                  Front                 : Integer;
                  sheetnumber           : Integer;
                  FlatSeparationSet     : Integer;
                  CopyFlatSeparationSet : Integer;
                  productionID          : Integer;
                  IssueID               : Integer;
                  publicationID         : Integer;
                  Copynumber            : Integer;
                  Ncopies               : Integer;
                  EditionID             : Integer;
                  locationID            : Integer;
                  templatelistid        : Integer;
                  deviceid              : Integer;
                  pressid               : Integer;
                  runid                 : Integer;
                  produce               : Boolean;
                  readytoproduce        : Boolean;
                  someerror             : Boolean;
                  totappr               : Integer;
                  totstat               : Integer;
                  NUniquepages          : Integer;
                  Presssectionnumber    : Integer;
                  Nmarkgroups           : Integer;
                  markgroups            : marksarray;
                  pages                 : tprodpagesarray;
                  Tower                 : Integer;
                  Zone                  : Integer;
                  truefront             : Integer;

                  OutputPriority             : Integer;
                  FlatProofConfigurationid   : Integer;
                  HardProofConfigurationID   : Integer;
                  isonmained                 : Boolean;
                  anyuniquepages             : Boolean;
               end;
  Tprodplates = Array of Tprodplate;
  TPlateframe = class(TFrame)
    ImageListplanframe: TImageList;
    Panelborder: TPanel;
    GroupBoxtop: TGroupBox;
    PBExListview1: TPBExListview;
    Image1: TImage;
    procedure PanelborderMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PBExListview1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PBExListview1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure PBExListview1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure PBExListview1Vertscroll(Sender: TObject);
    procedure PBExListview1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    Mouseisdown : Boolean;
    procedure Setplateframeselection(Button: TMouseButton; Shift: TShiftState);
  public
    Plantype         : Integer;
    Planversion      : Integer;
    perfecktbound    : Integer;
    Inserted         : Integer;
    // ## NAN 20160309 RipSetupID uses Backwards field in saved plans
    Backwards        : Integer;
    Selected         : Boolean;
    plateframenumber : Integer;
    pressrunid       : Integer;
    PressTime         : Tdatetime;
    presssystemname : String;
    CustomerID        : Integer;
    Numberofcopies    : Integer;
    NumberOfIssues    : Integer;
    NumberOfIssues2    : Integer;
    Miscdate              : tdatetime;
    SequenceNumber        : Integer;
    Productiontime             : tdatetime;
    RipSetupId            : Integer;
    PriorityBeforeHottime : Integer;
    PriorityDuringHottime : Integer;
    PriorityAfterHottime  : Integer;
    PriorityHottimeBegin  : tdatetime;
    PriorityHottimeEnd    : tdatetime;
    Inkcomment            : String;
    Comment               : string;
    // Benyttes ved move
    OrgRunID : Integer;
    Orgfromeditionid : Integer;
    OrgPubdate : Tdatetime;
    OrgFromPressid : Integer;
    OrgFromLocationid : Integer;
    OrgPublicationid : Integer;
    orgproductionid : Integer;
    PressConfignameX : string;
    order           : string;
    Nprodplates     : Integer;
    Sizeofprodplates : Integer;
    Manualaddedplates : string;

  end;
  Tplantreedata = record
                    pubdate : tdatetime;
                    plantype : Integer;
                    locationid,pressid,productionid,publicationid,pressrunid,editionid,sectionid : Integer;
                  end;

  Tplateframes = Array of TPlateframe;
var
    PressLowPlateName : string;
    PressHighPlateName : string;
      PressLowPlateName2 : string;
    PressHighPlateName2 : string;
Procedure SetLowHigh();

Function makeAplatecaption(IPLFNumber : Integer;
                           platenumber : Integer;
                           Extratext   : String):String;
Procedure addprodplate(IPLF : Integer;
                       IPL  : Integer;
                       var prodplate : Tprodplate);

Function GetPlannameFromID(nametype : Integer;
                           ID : Integer):string;
Function SetPlanIDFromname(nametype : Integer;
                           name : string):Integer;

Function SetplanTowername(Towername : String):Integer;
Function SetPlanhighlows(Highlowname : String):Integer;
Function GetplanTowername(ID : Integer):string;

Procedure makeplateframes(Var Parentbox : TScrollBox;
                         small         : Boolean);
Function loadplan(iplfnumber : Longint):boolean;
Procedure drawtheplates(small          : Boolean;
                        IPLFNumber     : Longint);
Procedure getorgeds(NAprodplates    : Integer;
                    Var Aprodplates : Tprodplates);

Function GetHighLowSTB( ID : Integer):string;

Var
  NPlantowers : Integer;
  Plantowers : Tnamearray;
  NPlanhighlows : Integer;
  Planhighlows : Tnamearray;
  //Maxplateframes : Integer;
  NMiscstring1 : Integer;
  NMiscstring2 : Integer;
  NMiscstring3 : Integer;
  Nstackpos    : Integer;
  NHigh        : Integer;
  NCylinder    : Integer;
  NZone        : Integer;
  planstrMiscstring1 : Tnamearray;
  planstrMiscstring2 : Tnamearray;
  planstrMiscstring3 : Tnamearray;
  planstrstackpos    : Tnamearray;
  planstrHigh        : Tnamearray;
  planstrCylinder    : Tnamearray;
  planstrZone        : Tnamearray;
  plateframesdata  : array[1..200] of record
                                        collection : Integer;
                                        prepaired  : boolean;
                                        bindingstyle : boolean;
                                        Aktsize      : Integer;
                                        applythis    : boolean;
                                        Impositiongroup : Integer;
                                        prodplates   : Tprodplates;
                                        PresstimeStart    : Tdatetime;
                                        PresstimeLength   : Tdatetime;  // Seconds og ms
                                        runSequenceNumber       : Integer;
                                        Anyuniqueplate : Boolean;
                                        PlateCopies : Integer;
                                      end;
  planpartpressrunid : Integer;
  
  Sizeofplateframes : Integer;
  plateframes : Tplateframes;
  plateframesproductionname   : string;
  plateframesproductionid     : Integer;
  plateframesPubdate          : Tdatetime;
  plateframesPublicationid    : Integer;
  plateframeslocationid       : Integer;
  plateframespressid       : Integer;
  plateframesApplyproductionid     : Integer;
  plateframesLoadedname : string;
  SelIplf,selipl,selip : Integer;
  ptX,pty : Integer;
  mouseoverimage,Mouseoveriplf,mouseoveripl,mouseoverip,mouseoverx,mouseovery : Integer;
implementation
{$R *.dfm}
Uses
  umain,udata, Uprodplan, Usettings, UUtils;
Var
  onerowbottom : Integer;

Function DoMakePlateFrames(Var Parentbox : TScrollBox;
                           small         : Boolean):boolean;
Var
  I, IPLF        : Integer;
  N              : ttreenode;
  newmarkgroups  : marksarray;
  Newpr          : Boolean;
Begin
  try
    result         := true;
    Mouseoveriplf  := -1;
    mouseoveripl   := -1;
    mouseoverip    := -1;
    mouseoverX     := -1;
    mouseoverY     := -1;
    mouseoverimage := -1;
    formmain.Deallocateplateframes;
    SetLowHigh();
    Nplateframes := 0;
    onerowbottom := 0;
    n := formmain.TreeViewplan.Selected;
    plateframesproductionid     := Tplantreedata(n.data^).productionid;
    plateframesPubdate          := Tplantreedata(n.data^).pubdate;
    plateframesPublicationid    := Tplantreedata(n.data^).publicationid;
    plateframeslocationid       := Tplantreedata(n.data^).locationid;
    plateframespressid          := Tplantreedata(n.data^).pressid;
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.add('Select distinct pressrunid from pagetable WITH (NOLOCK) ');
    DataM1.Query1.SQL.add('where publicationid = ' + inttostr(Tplantreedata(n.data^).publicationid) );
  //  DataM1.Query1.SQL.add('and locationid = ' + inttostr(Tplantreedata(n.data^).locationid) );
    DataM1.Query1.SQL.add('and pressid = ' + inttostr(Tplantreedata(n.data^).pressid) );
    DataM1.Query1.SQL.add('and productionid = ' + inttostr(Tplantreedata(n.data^).productionid) );
    DataM1.Query1.SQL.add('and ' + datam1.makedatastr('',Tplantreedata(n.data^).pubdate));
    IF formprodplan.planningaction = 6 then
    begin
       DataM1.Query1.SQL.add('and pressrunid = ' + inttostr(planpartpressrunid));
    end;
    IF Prefs.debug then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'makeplateframes.sql');
    DataM1.Query1.SQL.add('order by pressrunid');
    Nplateframes := 0;
    plateframesloadedname := '';
    formmain.Tryopen(DataM1.Query1);
    While not DataM1.Query1.eof do
    begin
      Inc(Nplateframes);
      DataM1.Query1.next;
    end;
    DataM1.Query1.close;
    if formmain.allocateplateframes(Parentbox,Nplateframes) then
    begin
      DataM1.Query1.SQL.Clear;
      DataM1.Query1.SQL.add('Select distinct pr.pressrunid,p.presssectionnumber,pr.plantype from pagetable p WITH (NOLOCK), pressrunid pr WITH (NOLOCK) ');
      DataM1.Query1.SQL.add('where p.publicationid = ' + inttostr(Tplantreedata(n.data^).publicationid) );
     // DataM1.Query1.SQL.add('and p.locationid = ' + inttostr(Tplantreedata(n.data^).locationid) );
      DataM1.Query1.SQL.add('and p.pressid = ' + inttostr(Tplantreedata(n.data^).pressid) );
      DataM1.Query1.SQL.add('and p.productionid = ' + inttostr(Tplantreedata(n.data^).productionid) );
      DataM1.Query1.SQL.add('and p.pressrunid = pr.pressrunid');
      DataM1.Query1.SQL.add('and ' + datam1.makedatastr('p.',Tplantreedata(n.data^).pubdate));
      IF formprodplan.planningaction = 6 then
      begin
         DataM1.Query1.SQL.add('and p.pressrunid = ' + inttostr(planpartpressrunid));
      end;
      DataM1.Query1.SQL.add('order by pr.plantype,p.presssectionnumber,pr.pressrunid');
      IF Prefs.debug then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'makeplateframes.sql');
      formmain.Tryopen(DataM1.Query1);
      IPLF := 0;
      While not DataM1.Query1.eof do
      begin
        Newpr := true;
        IF IPLF > 0 then
        begin
          for i := 1 to IPLF do
          begin
            IF plateframes[IPLF].pressrunid = DataM1.Query1.fields[0].asinteger then
            begin
              Newpr := false;
              break;
            end;
          end;
        end;
        IF Newpr then
        begin
          Inc(IPLF);
          plateframes[IPLF].pressrunid := DataM1.Query1.fields[0].asinteger;
          plateframes[IPLF].presssystemname := '';
          plateframes[IPLF].Plantype := 1;
        End;
        DataM1.Query1.next;
      end;
      DataM1.Query1.close;


      IF small then
        Pressviewzoom := 50
      else
        Pressviewzoom := 100;
      plateviewimage.Width := 23;    //204
      plateviewimage.height := 51;   //176
      For I := 1 to Nplateframes do
      Begin
        plateframes[I].Plantype := 1;
        IF dbversion > 1 then
        begin
          DataM1.Query1.SQL.Clear;       //0         1            2          3            4         5
          DataM1.Query1.SQL.add('Select plantype,Presssystem,Circulation,Circulation2,Deadline1,Deadline2,planversion from pressrunid WITH (NOLOCK)');
          DataM1.Query1.SQL.add('where pressrunid = ' + inttostr(plateframes[I].pressrunid) );
          DataM1.Query1.open;
          While not DataM1.Query1.eof do
          begin
            plateframes[I].Plantype        := DataM1.Query1.fields[0].asinteger;
            plateframes[I].presssystemname := DataM1.Query1.fields[1].asstring;
            plateframes[I].NumberOfIssues  := DataM1.Query1.fields[2].asInteger;
            plateframes[I].NumberOfIssues2 := DataM1.Query1.fields[3].asInteger;
            plateframes[I].productiontime  := DataM1.Query1.fields[4].asdatetime;
            plateframes[I].Planversion     := DataM1.Query1.fields[6].asinteger;
            DataM1.Query1.next;
          end;
          DataM1.Query1.close;
        End
        Else
        begin
          DataM1.Query1.SQL.Clear;
          DataM1.Query1.SQL.add('Select plantype from ProductionNames WITH (NOLOCK)');
          DataM1.Query1.SQL.add('Where productionid = ' + inttostr(plateframesproductionid));
          if not DataM1.Query1.eof then
            plateframes[I].Plantype := DataM1.Query1.fields[0].asinteger;
          DataM1.Query1.close;
          plateframes[I].Planversion := 1;
        end;
        IF plateframes[I].Plantype = 0 then
          plateframes[I].PBExListview1.color := RGB(233,233,233)
        else
          plateframes[I].PBExListview1.color := clwindow;
        loadplan(i);
        plateframes[I].GroupBoxtop.caption := tnames1.editionIDtoname(plateframesdata[I].prodplates[0].EditionID);
      End;
      Formprodplan.findorgedpages;
      For I := 1 to Nplateframes do
      Begin
        getorgeds(plateframes[i].Nprodplates,plateframesdata[I].prodplates);
        drawtheplates(small,i);
      End;
      Formprodplan.copyplantoplanpages;
      Formprodplan.makepagelist(Formprodplan.PBExListview1,0);
      if nplateframes > 0 then
      begin
        plateframesproductionid := Tplantreedata(n.data^).productionid;
        plateframeslocationid := Tplantreedata(n.data^).locationID;
        plateframespressid := Tplantreedata(n.data^).pressID;
        plateframesPubdate := Tplantreedata(n.data^).pubdate;
        Formprodplan.ApplyGlobData(1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,newmarkgroups);
        Formprodplan.findorgedpages;
        Formprodplan.Loadprodrundata(plateframesdata[1].prodplates[0].productionid);
        Formprodplan.SetprodrundataToUI;
      end;
      formprodplan.pressruncaptionnames;
    End
    Else
      result := false;
  except
    result := false;
  end;
end;
Procedure makeplateframes(Var Parentbox : TScrollBox;
                         small         : Boolean);
Begin
  IF not domakeplateframes(Parentbox,small) then
  begin
    domakeplateframes(Parentbox,small);
  end;
end;

Procedure SetLowHigh();
begin
  PressHighPlateName := Prefs.PressHighPlateName;
  PressLowPlateName := Prefs.PressLowPlateName;
    PressHighPlateName2 := Prefs.PressHighPlateName2;
  PressLowPlateName2 := Prefs.PressLowPlateName2;
  if (Prefs.UseDBTowerNames) then
  begin
    DataM1.Query1.Sql.Clear;
    DataM1.Query1.Sql.Add('Select TOP 1 HighName,LowName from PressNames');
    if (plateframespressid > 0) then
      DataM1.Query1.Sql.Add('where pressid = '+inttostr(plateframespressid));
    formmain.Tryopen(DataM1.Query1);
    IF not DataM1.Query1.Eof then
    begin
        if DataM1.Query1.Fields[0].AsString <> '' then
          PressHighPlateName := DataM1.Query1.Fields[0].AsString;
        if DataM1.Query1.Fields[1].AsString <> '' then
          PressLowPlateName := DataM1.Query1.Fields[1].AsString;
      end;
      DataM1.Query1.Close;
  end;
end;
Function loadplan(iplfnumber : Longint):boolean;
Var
  aktflatseparationset,aktcopyflatseparationset : Integer;
  IP : Integer;
  ipl : Integer;
  MaxCopy    : Integer;
  ippos,Nppos : Integer;
  ppos : pparray;
  T : string;
  runnode : ttreenode;
  ipl2,aktncopies, n : Integer;
  Nprods : Integer;
begin
  result := true;
  try
    SetLowHigh();
    runnode := formmain.TreeViewplan.Selected;
//    plateframe.ImageListplanframe.clear;
    plateframes[iplfnumber].PBExListview1.clear;
    SelIplf := -1;
    selipl  := -1;
    selip   := -1;
    if runnode = nil then
    begin
      result := false;
      exit;
    end;
    Nprods := 0;
    MaxCopy := 999;
    DataM1.Query1.sql.clear;
    DataM1.Query1.sql.add('Select distinct copyFlatseparationset, max(copynumber) from pagetable (NOLOCK)');
    DataM1.Query1.sql.add('where pressid = ' + inttostr(plateframespressid));
    DataM1.Query1.sql.add('and pressrunid = ' + inttostr(plateframes[iplfnumber].pressrunid));
    DataM1.Query1.sql.add('and locationid = '+inttostr(plateframeslocationid));
    DataM1.Query1.SQL.add(' and ' + DataM1.makedatastr('',plateframesPubdate));
    DataM1.Query1.sql.add('group by copyFlatseparationset');
    IF Prefs.debug then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'loadplateview.sql');
    formmain.Tryopen(DataM1.Query1);
    While not DataM1.Query1.Eof do
    begin
      n :=  DataM1.Query1.fields[1].asinteger;
      IF MaxCopy > n then
        MaxCopy := n;
      DataM1.Query1.next;
    end;
    DataM1.Query1.close;

    DataM1.Query1.sql.clear;
    DataM1.Query1.sql.add('Select Count( distinct(Flatseparationset)) from pagetable (NOLOCK)');
    DataM1.Query1.sql.add('where pressid = ' + inttostr(plateframespressid));
    DataM1.Query1.sql.add('and pressrunid = ' + inttostr(plateframes[iplfnumber].pressrunid));
    DataM1.Query1.sql.add('and locationid = '+inttostr(plateframeslocationid));
    DataM1.Query1.SQL.add(' and ' + DataM1.makedatastr('',plateframesPubdate));
    DataM1.Query1.SQL.add('and copynumber <= ' + inttostr(MaxCopy));
    IF Prefs.debug then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'loadplateview.sql');
    formmain.Tryopen(DataM1.Query1);
    n := DataM1.Query1.fields[0].asinteger;
    IF Nprods < n then
      Nprods := n;
    DataM1.Query1.close;
    formmain.Allocateprodplates(iplfnumber,Nprods);
    IF DBVersion > 1 then
    Begin
      DataM1.Query1.sql.clear;
      DataM1.Query1.sql.add('Select planname from pressrunid (NOLOCK)');
      DataM1.Query1.sql.add('where pressrunid = ' + inttostr(plateframes[iplfnumber].pressrunid));
      DataM1.Query1.open;
      IF not DataM1.Query1.eof then
      begin
        plateframesloadedname := DataM1.Query1.fields[0].asstring;
        plateframes[iplfnumber].NumberOfIssues := 0;
        plateframes[iplfnumber].NumberOfIssues2 := 0;
      end;
      DataM1.Query1.close;
    End;

    DataM1.Query1.sql.clear;
   // DataM1.Query1.sql.add('Select * from pagetable (NOLOCK)');

    Datam1.Query1.SQL.Add('SELECT CopySeparationSet');
    Datam1.Query1.SQL.Add(',SeparationSet');
    Datam1.Query1.SQL.Add(',Separation');
    Datam1.Query1.SQL.Add(',CopyFlatSeparationSet');
    Datam1.Query1.SQL.Add(',FlatSeparationSet');
    Datam1.Query1.SQL.Add(',FlatSeparation');
    Datam1.Query1.SQL.Add(',Status');
    Datam1.Query1.SQL.Add(',ExternalStatus');
    Datam1.Query1.SQL.Add(',PublicationID');
    Datam1.Query1.SQL.Add(',SectionID');
    Datam1.Query1.SQL.Add(',EditionID');
    Datam1.Query1.SQL.Add(',IssueID');
    Datam1.Query1.SQL.Add(',PubDate');
    Datam1.Query1.SQL.Add(',PageName');
    Datam1.Query1.SQL.Add(',ColorID');
    Datam1.Query1.SQL.Add(',TemplateID');
    Datam1.Query1.SQL.Add(',ProofID');
    Datam1.Query1.SQL.Add(',DeviceID');
    Datam1.Query1.SQL.Add(',Version');
    Datam1.Query1.SQL.Add(',Layer');
    Datam1.Query1.SQL.Add(',CopyNumber');
    Datam1.Query1.SQL.Add(',Pagination');
    Datam1.Query1.SQL.Add(',Approved');
    Datam1.Query1.SQL.Add(',Hold');
    Datam1.Query1.SQL.Add(',Active');
    Datam1.Query1.SQL.Add(',Priority');
    Datam1.Query1.SQL.Add(',PagePosition');
    Datam1.Query1.SQL.Add(',PageType');
    Datam1.Query1.SQL.Add(',PagesOnPlate');
    Datam1.Query1.SQL.Add(',SheetNumber');
    Datam1.Query1.SQL.Add(',SheetSide');
    Datam1.Query1.SQL.Add(',PressID');
    Datam1.Query1.SQL.Add(',PressSectionNumber');
    Datam1.Query1.SQL.Add(',SortingPosition');
    Datam1.Query1.SQL.Add(',PressTower');
    Datam1.Query1.SQL.Add(',PressCylinder');
    Datam1.Query1.SQL.Add(',PressZone');
    Datam1.Query1.SQL.Add(',PressHighLow');
    Datam1.Query1.SQL.Add(',ProductionID');
    Datam1.Query1.SQL.Add(',PressRunID');
    Datam1.Query1.SQL.Add(',ProofStatus');
    Datam1.Query1.SQL.Add(',InkStatus');
    Datam1.Query1.SQL.Add(',PlanPageName');
    Datam1.Query1.SQL.Add(',IssueSequenceNumber');
    Datam1.Query1.SQL.Add(',MasterCopySeparationSet');
    Datam1.Query1.SQL.Add(',UniquePage');
    Datam1.Query1.SQL.Add(',LocationID');
    Datam1.Query1.SQL.Add(',FlatProofConfigurationID');
    Datam1.Query1.SQL.Add(',FlatProofStatus');
    Datam1.Query1.SQL.Add(',Creep');
    Datam1.Query1.SQL.Add(',MarkGroups');
    Datam1.Query1.SQL.Add(',PageIndex');
    Datam1.Query1.SQL.Add(',GutterImage');
    Datam1.Query1.SQL.Add(',Outputversion');
    Datam1.Query1.SQL.Add(',HardProofConfigurationID');
    Datam1.Query1.SQL.Add(',HardProofStatus');
    Datam1.Query1.SQL.Add(',FileServer');
    Datam1.Query1.SQL.Add(',Dirty');
    Datam1.Query1.SQL.Add(',InputTime');
    Datam1.Query1.SQL.Add(',ApproveTime');
    Datam1.Query1.SQL.Add(',ReadyTime');
    Datam1.Query1.SQL.Add(',OutputTime');
    Datam1.Query1.SQL.Add(',VerifyTime');
    Datam1.Query1.SQL.Add(',ApproveUser');
    Datam1.Query1.SQL.Add(',FileName');
    Datam1.Query1.SQL.Add(',LastError');
    Datam1.Query1.SQL.Add(',Comment');
    Datam1.Query1.SQL.Add(',DeadLine');
    Datam1.Query1.SQL.Add(',InputID');
    Datam1.Query1.SQL.Add(',PagePositions');
    Datam1.Query1.SQL.Add(',InputProcessID');
    Datam1.Query1.SQL.Add(',SoftProofProcessID');
    Datam1.Query1.SQL.Add(',HardProofProcessID');
    Datam1.Query1.SQL.Add(',TransmitProcessID');
    Datam1.Query1.SQL.Add(',ImagingProcessID');
    Datam1.Query1.SQL.Add(',InkProcessID');
    Datam1.Query1.SQL.Add(',OutputPriority');
    Datam1.Query1.SQL.Add(',PressTime');
    Datam1.Query1.SQL.Add(',CustomerID');
    if (PageTableFieldCount >= 80) then
    begin
      Datam1.Query1.SQL.Add(',EmailStatus');
      Datam1.Query1.SQL.Add(',Miscint1');
      Datam1.Query1.SQL.Add(',Miscint2');
      Datam1.Query1.SQL.Add(',Miscint3');
      Datam1.Query1.SQL.Add(',Miscint4');
      Datam1.Query1.SQL.Add(',Miscstring1');
      Datam1.Query1.SQL.Add(',Miscstring2');
      Datam1.Query1.SQL.Add(',Miscstring3');
      Datam1.Query1.SQL.Add(',Miscdate');
      if (PageTableFieldCount >= 89) then
      begin
        Datam1.Query1.SQL.Add(',PdfMaster');
        Datam1.Query1.SQL.Add(',FlatMaster');
        Datam1.Query1.SQL.Add(',PageFormatID');
        Datam1.Query1.SQL.Add(',RipSetupID');
        Datam1.Query1.SQL.Add(',FanoutID');
        Datam1.Query1.SQL.Add(',PageCategoryID');
        if (PageTableFieldCount >= 95) then
        begin
          Datam1.Query1.SQL.Add(',DeviceGroupID');
          Datam1.Query1.SQL.Add(',PlateStatus');
          Datam1.Query1.SQL.Add(',PostOutputVersion');
        end;
      end;
    end;
    Datam1.Query1.SQL.Add('FROM  PageTable WITH (NOLOCK) ');

    DataM1.Query1.sql.add('where pressid = ' + inttostr(plateframespressid));
    DataM1.Query1.sql.add('and pressrunid = ' + inttostr(plateframes[iplfnumber].pressrunid));
    DataM1.Query1.sql.add('and locationid = '+inttostr(plateframeslocationid));
    DataM1.Query1.SQL.add(' and ' + DataM1.makedatastr('',plateframesPubdate));
    DataM1.Query1.SQL.add('and copynumber <= ' + inttostr(MaxCopy));
    DataM1.Query1.sql.add('order by sheetnumber,sheetside,copyflatseparationset,flatseparationset,colorid,pagepositions');
    IF Prefs.debug then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'loadplateview1.sql');
    formmain.Tryopen(DataM1.Query1);
    aktflatseparationset := -1;
    aktcopyflatseparationset := -1;
    ipl := -1;
    repeat
      IF aktflatseparationset <> DataM1.Query1.fields[4].asinteger then  //flatseparationset
      begin
        Inc(ipl);
        aktflatseparationset  := DataM1.Query1.fields[4].asinteger;      //flatseparationset
        plateframes[iplfnumber].PressTime := DataM1.Query1.fields[77].Asdatetime; //PressTime
        plateframesdata[iplfnumber].prodplates[ipl].HardProofConfigurationID  := DataM1.Query1.fields[54].Asinteger; //HardProofConfigurationID
        plateframesdata[iplfnumber].prodplates[ipl].FlatProofConfigurationID  := DataM1.Query1.fields[47].Asinteger; //FlatProofConfigurationID
        plateframesdata[iplfnumber].prodplates[ipl].pressid               := DataM1.Query1.fields[31].Asinteger; //pressid
        plateframesdata[iplfnumber].prodplates[ipl].runid                 := DataM1.Query1.fields[39].Asinteger; //pressrunid
        plateframesdata[iplfnumber].prodplates[ipl].Front                 := DataM1.Query1.fields[30].Asinteger; //sheetside
        plateframesdata[iplfnumber].prodplates[ipl].truefront             := plateframesdata[iplfnumber].prodplates[ipl].Front;
        IF (DataM1.Query1.fields[35].Asstring = fronbackstr[0]) OR (DataM1.Query1.fields[35].Asstring = fronbackstr[1]) then
        begin
          IF (DataM1.Query1.fields[35].Asstring = fronbackstr[0]) then
            plateframesdata[iplfnumber].prodplates[ipl].truefront := 2;
          IF (DataM1.Query1.fields[35].Asstring = fronbackstr[1]) then
            plateframesdata[iplfnumber].prodplates[ipl].truefront := 3;
        end
        Else
        begin
        end;
        plateframesdata[iplfnumber].prodplates[ipl].sheetnumber           := DataM1.Query1.fields[29].Asinteger; //sheetnumber
        plateframesdata[iplfnumber].prodplates[ipl].FlatSeparationSet     := DataM1.Query1.fields[4].Asinteger; //   FlatSeparationSet
        plateframesdata[iplfnumber].prodplates[ipl].CopyFlatSeparationSet := DataM1.Query1.fields[3].Asinteger; //CopyFlatSeparationSet
        plateframesdata[iplfnumber].prodplates[ipl].productionID          := DataM1.Query1.fields[38].Asinteger; //productionID
        plateframesdata[iplfnumber].prodplates[ipl].IssueID               := DataM1.Query1.fields[11].Asinteger; //IssueID
        plateframesdata[iplfnumber].prodplates[ipl].publicationID         := DataM1.Query1.fields[8].Asinteger; //publicationID
        plateframesdata[iplfnumber].prodplates[ipl].Copynumber            := DataM1.Query1.fields[20].Asinteger; //Copynumber
        plateframesdata[iplfnumber].prodplates[ipl].EditionID             := DataM1.Query1.fields[10].Asinteger; //EditionID
        plateframesdata[iplfnumber].prodplates[ipl].locationID            := DataM1.Query1.fields[46].Asinteger; //locationID
        plateframesdata[iplfnumber].prodplates[ipl].deviceID              := DataM1.Query1.fields[17].Asinteger; //deviceID
        plateframesdata[iplfnumber].prodplates[ipl].Presssectionnumber    := DataM1.Query1.fields[32].Asinteger; //Presssectionnumber
        plateframesdata[iplfnumber].prodplates[ipl].templatelistid        := inittypes.gettemplatenumberfromID(DataM1.Query1.fields[15].Asinteger);//templateid
        plateframes[iplfnumber].Numberofcopies  :=1;
        plateframesdata[iplfnumber].prodplates[ipl].Tower             := SetplanTowername(DataM1.Query1.fields[34].Asstring); //pressTower
        plateframesdata[iplfnumber].prodplates[ipl].Zone := SetPlanIDFromname(5,DataM1.Query1.fields[36].Asstring); //pressZone
        plateframes[iplfnumber].OrgRunID              := DataM1.Query1.fields[39].Asinteger; //pressrunid
        plateframes[iplfnumber].Orgfromeditionid      := DataM1.Query1.fields[10].Asinteger; //editionid
        plateframes[iplfnumber].OrgPubdate            := plateframesPubdate;
        plateframes[iplfnumber].OrgFromPressid        := DataM1.Query1.fields[31].Asinteger; //pressid
        plateframes[iplfnumber].OrgFromLocationid     := DataM1.Query1.fields[46].Asinteger; //Locationid
        plateframes[iplfnumber].OrgPublicationid      := DataM1.Query1.fields[8].Asinteger; //Publicationid
        plateframes[iplfnumber].orgproductionid       := DataM1.Query1.fields[38].Asinteger; //Productionid
        inittypes.markstrtoarray(DataM1.Query1.fields[50].Asstring,plateframesdata[iplfnumber].prodplates[ipl].markgroups,  plateframesdata[iplfnumber].prodplates[ipl].Nmarkgroups); //Markgroups
      end;
      T := DataM1.Query1.fields[69].asstring; //pagepositions
      inittypes.PPOSstrtoarray(t,ppos,Nppos);
      For ippos := 1 to Nppos do
      begin
        plateframesdata[iplfnumber].prodplates[ipl].Pages[ppos[ippos]].totUniquePage := DataM1.Query1.fields[45].Asinteger; //UniquePage
        plateframesdata[iplfnumber].prodplates[ipl].Pages[ppos[ippos]].pagetype := DataM1.Query1.fields[27].Asinteger; //pagetype
        plateframesdata[iplfnumber].prodplates[ipl].Pages[ppos[ippos]].Creep := DataM1.Query1.fields[49].Asinteger;  //Creep
        plateframesdata[iplfnumber].prodplates[ipl].Pages[ppos[ippos]].SectionID  := DataM1.Query1.fields[9].Asinteger; //SectionID
        plateframesdata[iplfnumber].prodplates[ipl].Pages[ppos[ippos]].proofid := DataM1.Query1.fields[16].Asinteger; //proofid

        plateframesdata[iplfnumber].prodplates[ipl].Pages[ppos[ippos]].pagename := DataM1.Query1.fields[13].Asstring;   //pagename
        plateframesdata[iplfnumber].prodplates[ipl].Pages[ppos[ippos]].Pagina := DataM1.Query1.fields[21].Asinteger; //pagination
        plateframesdata[iplfnumber].prodplates[ipl].Pages[ppos[ippos]].pageindex := DataM1.Query1.fields[51].Asinteger; //pageindex
        plateframesdata[iplfnumber].prodplates[ipl].Pages[ppos[ippos]].OrgeditionID := plateframesdata[iplfnumber].prodplates[ipl].EditionID;
        plateframesdata[iplfnumber].prodplates[ipl].Pages[ppos[ippos]].MasterCopySeparationSet := DataM1.Query1.fields[44].Asinteger; //MasterCopySeparationSet

        if (Prefs.PressSpecific) And (pdfmasterOK) then
          plateframesdata[iplfnumber].prodplates[ipl].Pages[ppos[ippos]].PDFMaster := DataM1.Query1.fieldbyname('PDFmaster').Asinteger //MasterCopySeparationSe        end
        else
          plateframesdata[iplfnumber].prodplates[ipl].Pages[ppos[ippos]].PDFMaster := plateframesdata[iplfnumber].prodplates[ipl].Pages[ppos[ippos]].MasterCopySeparationSet; //MasterCopySeparationSet
        plateframesdata[iplfnumber].prodplates[ipl].Pages[ppos[ippos]].CopySeparationSet := DataM1.Query1.fields[0].Asinteger; //
        plateframesdata[iplfnumber].prodplates[ipl].Pages[ppos[ippos]].OrgCopySeparationSet := plateframesdata[iplfnumber].prodplates[ipl].Pages[ppos[ippos]].CopySeparationSet;
        plateframesdata[iplfnumber].prodplates[ipl].Pages[ppos[ippos]].SeparationSet := DataM1.Query1.fields[1].Asinteger;
        plateframesdata[iplfnumber].prodplates[ipl].Pages[ppos[ippos]].Oldrunid := DataM1.Query1.fields[39].Asinteger; //pressrunid
        if (RipSetupIDInPageTable) then
        begin
          plateframesdata[iplfnumber].prodplates[ipl].Pages[ppos[ippos]].PageRotation := DataM1.Query1.FieldByName('PageCategoryID').AsInteger;
          plateframesdata[iplfnumber].prodplates[ipl].Pages[ppos[ippos]].RipSetupID := DataM1.Query1.FieldByName('RipSetupID').AsInteger;
          plateframesdata[iplfnumber].prodplates[ipl].Pages[ppos[ippos]].PageFormatID := DataM1.Query1.FieldByName('PageFormatID').AsInteger;
        end;
        Inc(plateframesdata[iplfnumber].prodplates[ipl].Pages[ppos[ippos]].Ncolors);
        With plateframesdata[iplfnumber].prodplates[ipl].Pages[ppos[ippos]].colors[plateframesdata[iplfnumber].prodplates[ipl].Pages[ppos[ippos]].Ncolors] do
        begin
          copynumber        := DataM1.Query1.fields[20].Asinteger;   //copynumber
          UniquePage        := DataM1.Query1.fields[45].Asinteger;  //Unique
          Separation        := DataM1.Query1.fields[2].AsVariant; // Separation
          FlatSeparation    := DataM1.Query1.fields[5].Asvariant; //FlatSeparation
          colorid           := DataM1.Query1.fields[14].Asinteger; //colorid
          layer             := DataM1.Query1.fields[19].Asinteger; //layer
          status            := DataM1.Query1.fields[6].Asinteger;   //status
          active            := DataM1.Query1.fields[24].Asinteger; //active
          Proofstatus       := DataM1.Query1.fields[40].Asinteger; //Proofstatus
          Approved          := DataM1.Query1.fields[22].Asinteger; //Approved
          priority          := DataM1.Query1.fields[25].Asinteger; //priority
          Hold              := DataM1.Query1.fields[23].Asinteger; //Hold
          stackpos          := SetPlanIDFromname(2,DataM1.Query1.fields[33].Asstring); //sortingposition
          High              := SetPlanIDFromname(3,DataM1.Query1.fields[37].Asstring); //pressHighlow
          IF (DataM1.Query1.fields[35].Asstring = fronbackstr[0]) OR (DataM1.Query1.fields[35].Asstring = fronbackstr[1]) then
            Cylinder          := -1
          else
            Cylinder          := SetPlanIDFromname(4,DataM1.Query1.fields[35].Asstring); //pressCylinder
          IF (plateframesdata[iplfnumber].prodplates[ipl].Pages[ppos[ippos]].pagetype <> 3) and (active = 1) then
          begin
            IF (Approved = 2) then
              plateframesdata[iplfnumber].prodplates[ipl].Pages[ppos[ippos]].totapproval := 2;
            IF (Approved = 0) and (plateframesdata[iplfnumber].prodplates[ipl].Pages[ppos[ippos]].totapproval <> 2) then
              plateframesdata[iplfnumber].prodplates[ipl].Pages[ppos[ippos]].totapproval := 0;
            IF hold = 1 then
              plateframesdata[iplfnumber].prodplates[ipl].Pages[ppos[ippos]].Anyheld := true;
          End;
        end;
      End;
      DataM1.Query1.next;
    Until DataM1.Query1.Eof;
    DataM1.Query1.close;
    plateframes[iplfnumber].Nprodplates := IPL;

    aktcopyflatseparationset := -1;
    aktncopies := plateframes[iplfnumber].Numberofcopies;

    For ip := 0 to IPL do
    Begin
      IF aktcopyflatseparationset <> plateframesdata[iplfnumber].prodplates[ip].CopyFlatSeparationSet then
      begin
        aktcopyflatseparationset := plateframesdata[iplfnumber].prodplates[ip].CopyFlatSeparationSet;
        aktncopies := plateframesdata[iplfnumber].prodplates[ip].Copynumber;
        For ipl2 := 0 to ipl do
        begin
          IF aktcopyflatseparationset = plateframesdata[iplfnumber].prodplates[ipl2].CopyFlatSeparationSet then
          begin
            IF aktncopies < plateframesdata[iplfnumber].prodplates[ipl2].Copynumber then
            begin
              aktncopies := plateframesdata[iplfnumber].prodplates[ipl2].Copynumber;
            end;
          end;
        end;
        For ipl2 := 0 to ipl do
        begin
          IF aktcopyflatseparationset = plateframesdata[iplfnumber].prodplates[ipl2].CopyFlatSeparationSet then
          begin
            //plateframesdata[iplfnumber].prodplates[ipl2].Ncopies := aktncopies;
            plateframes[iplfnumber].Numberofcopies := aktncopies;
          end;
        end;
      end;
    end;

  Except
    sleep(1);
    result := false;
  end;
End;
Procedure DrawThePlates(small : Boolean;  IPLFNumber : Longint);
Var
  thisrow: Integer;
  thiscol: Integer;
  maxcols: Integer;
  //multicopies : Boolean;
  plateresult : Integer;
  IPL,IP{,IC} : Integer;
  imindx : Integer;
  l : tlistitem;
  pt: TPoint;
  refreckdone : boolean;
  platenumber : Integer;
Begin
  try
     maxcols := 0;
    SetLowHigh();
    Formprodplan.setproduce;

    if small then
      Pressviewzoom := 60
    else
      Pressviewzoom := 100;
    plateframes[IPLFNumber].PBExListview1.Items.clear;
    plateframes[IPLFNumber].ImageListplanframe.Clear;
    refreckdone := false;
    plateframes[IPLFNumber].PBExListview1.Items.BeginUpdate;
    thisrow := 0;
    thiscol := 0;
    //multicopies := false;

    if formprodplan.Calledwizardtoplates then
    begin
      if (not Prefs.InsertSheetNumbersFor1up) then
      begin
        formprodplan.Calledwizardtoplates := false;
        formprodplan.Checkfrontbackon1up;
      end;
    end;
    plateviewimage.Width := 21;
    IPL := plateframes[IPLFNumber].Nprodplates;
{    For ip := 0 to ipl do
    begin
      if plateframesdata[IPLFNumber].prodplates[ip].Copynumber > 1 then
      begin
        //multicopies := true;
        break;
      end;
    End;}
    platenumber := -1;
    For ip := 0 to ipl do
    begin
      if (plateframesdata[IPLFNumber].prodplates[ip].Copynumber = 1) {or (true)} then
      begin
        Inc(platenumber);
        plateresult := formprodplan.makeprodviewimage(IPLFNumber,
                                                  plateframes[IPLFNumber].ImageListplanframe,
                                                  plateframes[IPLFNumber].PBExListview1,
                                                  false,    //CheckBoxplanthumbnails
                                                  small,
                                                  false,platenumber,ip,-1,plateframes[IPLFNumber].Numberofcopies);
        IF plateframes[IPLFNumber].ImageListplanframe.Count-1 < platenumber then
        begin
          imindx := plateframes[IPLFNumber].ImageListplanframe.AddMasked(plateviewimage,clwhite);
        end
        Else
        begin
          plateframes[IPLFNumber].ImageListplanframe.ReplaceMasked(ip,plateviewimage,clwhite);
        end;

        if plateresult > 0 then
        begin
          IF (platenumber = 0)  then
            maxcols :=  plateframes[IPLFNumber].PBExListview1.Width div ((plateframes[IPLFNumber].ImageListplanframe.width+20));
          if (plateresult = 1) or (plateresult = 2)  then
          begin
            IF plateframes[IPLFNumber].PBExListview1.Items.Count-1 < platenumber then
            Begin
              l := plateframes[IPLFNumber].PBExListview1.Items.Add;
            end;
            plateframes[IPLFNumber].PBExListview1.Items[platenumber].Caption :=
              makeAplatecaption(IPLFNumber,ip,'');
(*
                           Extratext   : String):String;
              inttostr(plateframesdata[IPLFNumber].prodplates[ip].sheetnumber) + ' ' + fronbackstr[plateframesdata[IPLFNumber].prodplates[ip].Front] +
                       ' '+ GetplanTowername(plateframesdata[IPLFNumber].prodplates[ip].Tower);
  *)
            plateframes[IPLFNumber].PBExListview1.Items[platenumber].ImageIndex := platenumber;
            Inc(thiscol);
            if (thiscol > maxcols) then
            begin
              thiscol := 1;
              Inc(thisrow);
            end;
            IF Thisrow = 1 then
            begin
              onerowbottom := plateframes[IPLFNumber].ImageListplanframe.height+PLANVIEWGUTTERVERTICAL;
            end;

            pt.X := (thiscol-1)*(plateframes[IPLFNumber].ImageListplanframe.width+PLANVIEWGUTTER) - PLANVIEWGUTTER;
            pt.Y := thisrow * (plateframes[IPLFNumber].ImageListplanframe.height+PLANVIEWGUTTERVERTICAL);
            //????????????????????????????????????????????????????????????????????????????????????
            IF plateframes[IPLFNumber].PBExListview1 = plateframes[IPLFNumber].PBExListview1 then
            Begin
              IF (pt.Y > plateframes[IPLFNumber].PBExListview1.height) and (not refreckdone) then
              begin
                refreckdone := true;
              end;
            End;
            plateframes[IPLFNumber].PBExListview1.Items[platenumber].Position := pt;
          End;
        End;
      end;
    End;
    plateframes[IPLFNumber].PBExListview1.Items.EndUpdate;
    plateframes[IPLFNumber].PBExListview1.Visible := true;

  except
    sleep(1);
  end;
  formprodplan.setactionenabled;
end;

Procedure GetOrgEds(NAprodplates    : Integer;
                    Var Aprodplates : Tprodplates);
Var
  IPL,IP{,IC} : Integer;
Begin
  try
    IF NAprodplates > -1 then
    begin
      DataM1.Query1.sql.clear;
      DataM1.Query1.sql.add('select distinct p1.pagename,p1.mastercopyseparationset,p1.editionid,p2.editionid,p2.mastercopyseparationset,p2.copyseparationset from pagetable p1 WITH (NOLOCK), pagetable p2 WITH (NOLOCK)');
      DataM1.Query1.sql.add('where p1.uniquepage <> 1 and p2.uniquepage = 1 and p1.mastercopyseparationset = p2.mastercopyseparationset');
      formmain.Tryopen(DataM1.Query1);
      while not DataM1.Query1.eof do
      begin
        for IPL := 0 to NAprodplates do
        begin
          for ip := 1 to platetemplatearray[Aprodplates[IPL].templatelistid].NupOnplate do
          begin
            IF Aprodplates[IPL].Pages[ip].totUniquePage <> 1 then
            begin
              IF Aprodplates[IPL].Pages[ip].MasterCopySeparationSet =
                DataM1.Query1.Fields[1].asinteger then
              begin
                Aprodplates[IPL].Pages[ip].OrgeditionID := DataM1.Query1.Fields[3].asinteger;
                Aprodplates[IPL].Pages[ip].OrgCopySeparationSet := DataM1.Query1.Fields[5].asinteger;
              end;
            end;
          end;
        end;
        DataM1.Query1.next;
      end;
      DataM1.Query1.Close;
    End;
  except
    sleep(1);
  end;
end;

procedure TPlateframe.PanelborderMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Setplateframeselection(Button,shift);
  formprodplan.ActionediteditionRun.Enabled := true;
end;
procedure TPlateframe.Setplateframeselection(Button: TMouseButton; Shift: TShiftState);
    Function makesectionidsstr(IPLF : longint):string;
    Var
      ipl,ip : Integer;
      sectionids : string;
    Begin
      try
        result := '';
        sectionids := '';
        For ipl := 0 to plateframes[iplf].Nprodplates do
        begin
          for ip := 1 to platetemplatearray[plateframesdata[iplf].prodplates[ipl].templatelistid].NupOnplate do
          begin
            IF pos('('+inttostr(plateframesdata[iplf].prodplates[ipl].pages[ip].SectionID)+')',sectionids) = 0 then
            Begin
              sectionids := sectionids + '('+inttostr(plateframesdata[iplf].prodplates[ipl].pages[ip].SectionID)+')';
            End;
          End;
        End;
        result := sectionids;
      Except
      end;
    End;
Var
  iplf,ipl : Integer;
  Selsections,subSelsections : String;
  akteditionid : Integer;
Begin
  IF (formprodplan.Actioneditpages.Checked) And (plateframes[plateframenumber].Selected) then
  begin
    Formprodplan.editpagename(plateframenumber,mouseoveripl,Mouseoverip);
  end
  else
  begin
    For iplf := 1 to nplateframes do
    begin
      if plateframes[iplf].PBExListview1.Items.Count <> plateframes[plateframenumber].PBExListview1.Items.Count then
      begin
        plateframes[iplf].Selected := false;
        for ipl := 0 to plateframes[iplf].PBExListview1.Items.Count-1 do
        begin
          plateframes[iplf].PBExListview1.Items[ipl].Selected := false;
        end;
      end;
    end;

    IF ssCtrl IN shift  then
    begin
      Selected := Not Selected;
    end
    Else
    begin
      akteditionid := plateframesdata[plateframenumber].prodplates[0].EditionID;
      Selected := true;
      Selsections := makesectionidsstr(plateframenumber);
      for iplf := 1 to nplateframes do
      begin
        IF (iplf <> plateframenumber) then
        begin
          subSelsections := makesectionidsstr(IPLF);
          plateframes[iplf].Selected := false;
          IF (Selsections = subSelsections) and (Formprodplan.CheckBoxsubedselection.checked) then
          begin
            if (plateframesdata[plateframenumber].prodplates[0].EditionID <> plateframesdata[iplf].prodplates[0].EditionID) and
               (plateframes[iplf].PBExListview1.Items.Count = plateframes[plateframenumber].PBExListview1.Items.Count) then
              plateframes[iplf].Selected := true;
          End;
        End;
      End;
    end;
    for iplf := 1 to nplateframes do
    begin
      IF plateframes[iplf].Selected then
      begin
        plateframes[iplf].Panelborder.Color := clblue;
      end
      else
      begin
        plateframes[iplf].Panelborder.Color := clBtnFace;
      End;
      plateframes[iplf].GroupBoxtop.repaint;
    end;
  End;
  IF selected then
    Formprodplan.Editthisrun := plateframenumber;
End;
procedure TPlateframe.PBExListview1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IF formprodplan.ActionMovepages.Checked then
  begin
    PBExListview1.Cursor := crMultiDrag;
    formprodplan.CopyIPLF := Mouseoveriplf;
    formprodplan.copyIPL  := mouseoveripl;
    formprodplan.CopyIP   := mouseoverip;
  end;
  Mouseisdown := true;
  Setplateframeselection(Button,shift);
end;
procedure TPlateframe.PBExListview1SelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);

    Function makesectionidsstr(IPLF : longint):string;
    Var
      ipl,ip : Integer;
      sectionids : string;
    Begin
      try
        result := '';
        sectionids := '';
        For ipl := 0 to plateframes[iplf].Nprodplates do
        begin
          for ip := 1 to platetemplatearray[plateframesdata[iplf].prodplates[ipl].templatelistid].NupOnplate do
          begin
            IF pos('('+inttostr(plateframesdata[iplf].prodplates[ipl].pages[ip].SectionID)+')',sectionids) = 0 then
            Begin
              sectionids := sectionids + '('+inttostr(plateframesdata[iplf].prodplates[ipl].pages[ip].SectionID)+')';
            End;
          End;
        End;
        result := sectionids;
      Except
      end;
    End;

Var
  Iplf,ipl{,ip,ic} : Integer;
  Secselection : string;
  SubSecselection : string;

begin
  IF Not formprodplan.issetting then
  begin
    formprodplan.issetting := true;
    if item.Selected then
      selipl := Formprodplan.ImagenumbertoIPL(plateframenumber,item.Index);
    IF formprodplan.Visible then
    begin
      IF formprodplan.CheckBoxsubedselection.checked then
      begin
        For iplf := 1 to nplateframes do
        begin
          if plateframes[iplf].PBExListview1.Items.Count <> PBExListview1.Items.Count then
          begin
            plateframes[iplf].Selected := false;
            for ipl := 0 to plateframes[iplf].PBExListview1.Items.Count-1 do
            begin
              plateframes[iplf].PBExListview1.Items[ipl].Selected := false;
            end;
          end;
        end;
        ipl := item.Index;
        Secselection := makesectionidsstr(plateframenumber);
        For iplf := 1 to nplateframes do
        begin
          IF (iplf <> plateframenumber)  then
          begin
            SubSecselection := makesectionidsstr(IPLF);
            if (SubSecselection = Secselection) and (plateframes[iplf].PBExListview1.Items.Count = PBExListview1.Items.Count) then
            begin
              plateframes[iplf].PBExListview1.Items[ipl].Selected := Selected;
            end;
          End;
        end;
      end
      Else
      begin
        For iplf := 1 to nplateframes do
        begin
          IF iplf <> plateframenumber then
          begin
            plateframes[iplf].Selected := false;
            if plateframes[iplf].PBExListview1.Items.Count = PBExListview1.Items.Count then
            begin
              for ipl := 0 to plateframes[iplf].PBExListview1.Items.Count-1 do
                plateframes[iplf].PBExListview1.Items[ipl].Selected := false;
            end;
          end;
        end;
      end;
      for iplf := 1 to nplateframes do
      begin
        IF plateframes[iplf].Selected then
        begin
          plateframes[iplf].Panelborder.Color := clblue;
        end
        else
        begin
          plateframes[iplf].Panelborder.Color := clBtnFace;
        End;
        plateframes[iplf].GroupBoxtop.repaint;
      end;
    End;
    formprodplan.setactionenabled;
    formprodplan.issetting := false;
  End;
end;

procedure TPlateframe.PBExListview1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
Var
  //I,
  iplf,icol : Integer;
  {ix,iy,}ipl,IP,ipm : Integer;
  L{,l1} : tlistitem;
  drect{,drect1} : trect;
  tp,tp1 : tpoint;
  plateresult : Integer;
  Ncopies : Integer;
  Nplates : Integer;
  foundover : Boolean;
  Aktplateframenumber : Integer;
begin
  try
    IF Formprodplan.Active then
    begin
      Aktplateframenumber := TPlateframe(tpbexlistview(sender).Owner).plateframenumber;
      Nplates := plateframes[Aktplateframenumber].Nprodplates;
      Ncopies := plateframesdata[Aktplateframenumber].prodplates[Nplates].Copynumber;
      (*
      Mouseoveriplf := -1;
      mouseoveripl  := -1;
      mouseoverip   := -1;
      *)
      mouseoverx := x;
      mouseovery := y;
      foundover  := false;
      if TPlateframe(tpbexlistview(sender).Owner).Selected then
      begin
        iplf := TPlateframe(tpbexlistview(sender).Owner).plateframenumber;
        if iplf > -1 then
        begin
          // Get TListItem under mouse  (l.index)
          L := PBExListview1.GetItemAt(X, Y);
          if l <> nil then
          begin
            drect := l.DisplayRect(drIcon	);
            ipl := Formprodplan.ImagenumbertoIPL(iplf, l.Index);
            tp1 := PBExListview1.items[0].Position;
            tp := l.Position;
            // NAN 20170523
            //  icol := ((tp.X+ImageListplanframe.width)-28) div (ImageListplanframe.width+16);
            icol := ((tp.X+ImageListplanframe.width)-PLANVIEWXADJUST) div (ImageListplanframe.width+PLANVIEWGUTTER);
            // NAN 20170523
            //  tp.x := (icol *16) + (ImageListplanframe.width*(icol))+28;
            tp.x := (icol * PLANVIEWGUTTER) + (ImageListplanframe.width*(icol))+PLANVIEWXADJUST;
            mouseoverx := x-tp.x;
            mouseovery := y-tp.Y+PBExListview1.Vertpos;
            ipm := -1;
             for ip := 1 to PlatetemplateArray[plateframesdata[iplf].prodplates[ipl].templatelistid].NupOnplate do
            begin
              if (plateframesdata[iplf].prodplates[ipl].Pages[ip].position.Left < mouseoverx) and
              (plateframesdata[iplf].prodplates[ipl].Pages[ip].position.right > mouseoverx) and
              (plateframesdata[iplf].prodplates[ipl].Pages[ip].position.top < mouseovery) and
              (plateframesdata[iplf].prodplates[ipl].Pages[ip].position.bottom > mouseovery) then
              begin
                ipm := ip;
                Formprodplan.edit1.Text := plateframesdata[iplf].prodplates[ipl].Pages[ipm].pagename;
                foundover := true;
                break;
              end;
            end;
            if (foundover) and (Mouseoveriplf <> iplf) or (mouseoverimage <> l.Index) or (mouseoverip <> ipm) and (ipm <> -1) then
            begin
              if (Mouseoveriplf > -1) and (mouseoverimage > -1) and (mouseoverimage < plateframes[Mouseoveriplf].ImageListplanframe.Count) then
                plateframes[Mouseoveriplf].ImageListplanframe.GetBitmap(mouseoverimage,PlateviewImage);
              IF (Mouseoveriplf > -1) and (mouseoverimage > -1) and (mouseoveripl > -1 ) and (mouseoverimage < PBExListview1.items.count) then
              begin
                Formprodplan.edit1.Text := inttostr(mouseoveriplf)+ ' , ' + inttostr(mouseoveripl);
                plateframes[Mouseoveriplf].ImageListplanframe.GetBitmap(mouseoverimage,PlateviewImage);
                plateresult := formprodplan.makeprodviewimage(Mouseoveriplf,
                                                              plateframes[Mouseoveriplf].ImageListplanframe,
                                                              plateframes[Mouseoveriplf].PBExListview1,
                                                              false,    //CheckBoxplanthumbnails
                                                              Formprodplan.CheckBoxsmallimagesinEdit.checked,
                                                              false,
                                                              mouseoveripl,mouseoveripl,-1,plateframes[Mouseoveriplf].Numberofcopies);
                plateframes[Mouseoveriplf].ImageListplanframe.Replacemasked(mouseoverimage,plateviewimage,clwhite);
              end;

              ImageListplanframe.GetBitmap(l.Index,PlateviewImage);
              Mouseoveriplf := iplf;
              mouseoveripl := ipl;
              mouseoverip := ipm;
              mouseoverimage := l.Index;
              Formprodplan.edit2.Text := inttostr(ipm) + ' , ' + inttostr(ipl);
              plateresult := formprodplan.makeprodviewimage(Mouseoveriplf ,
                                                            Plateframes[Mouseoveriplf].ImageListplanframe,
                                                            Plateframes[Mouseoveriplf].PBExListview1,
                                                            false,    //CheckBoxplanthumbnails
                                                            Formprodplan.CheckBoxsmallimagesinEdit.checked,
                                                            false,
                                                            ipl,ipl,mouseoverip,plateframes[Mouseoveriplf].Numberofcopies);

              ImageListplanframe.Replacemasked(mouseoverimage,plateviewimage,clwhite);
           end;
          end;
        End;
      End;
    End;
  Except
    sleep(1);
  end;
end;

Function SetPlanhighlows(Highlowname : String):Integer;
Var
  I : Integer;
Begin
  result := -1;
  if (Highlowname = PressHighPlateName) then
    result := 0;
  if (Highlowname = PressLowPlateName) then
    result := 1;
  if (result >= 0) then
    exit;
  For i := 1 to NPlanhighlows do
  begin
    IF Planhighlows[i] = highlowname then
    begin
      result := i;
      break;
    end;
  end;
  IF result = -1 then
  begin
    inc(NPlanhighlows);
    setlength(Highlowname,NPlanhighlows+5);
    Planhighlows[NPlanhighlows] := Highlowname;
    result := NPlanhighlows;
  end;
end;

Function SetplanTowername(Towername : String):Integer;
Var
  I : Integer;
Begin
  result := -1;
  For i := 1 to NPlantowers do
  begin
    IF Plantowers[i] = Towername then
    begin
      result := i;
      break;
    end;
  end;
  IF result = -1 then
  begin
    inc(NPlantowers);
    setlength(Plantowers,NPlantowers+5);
    Plantowers[NPlantowers] := Towername;
    result := NPlantowers;
  end;
end;
Function GetplanTowername(ID : Integer):string;
Begin
  IF (ID < 0) or (ID > 256) then
    result := ''
  Else
  begin
    result := Plantowers[id];
  end;
end;

Function SetPlanIDFromname(nametype : Integer;
                           name : string):Integer;
Function doset(Var theset : tnamearray;
               var Ntheset : Integer;
               name : string):Integer;
Var
  I : Integer;
begin
  result := -1;
  For i := 1 to Ntheset do
  begin
    IF theset[i] = name then
    begin
      result := i;
      break;
    end;
  end;
  IF result = -1 then
  begin
    inc(Ntheset);
    setlength(theset,Ntheset+5);
    theset[Ntheset] := name;
    result := Ntheset;
  end;
end;
{Var
  I : Integer;}
Begin
  result := -1;
  if name = '' then
    exit;
  Case nametype of
    1 : Begin                                             //Tower
          result := doset(Plantowers,NPlantowers,name);
         end;
    2 : Begin
          result := doset(planstrstackpos,Nstackpos,name); //Stack
         end;
    3 : Begin
         // result := doset(Planhighlows,NPlanhighlows,name);
          //if result < 0 then
          //begin
            result := 1;
            IF (name = PressHighPlateName) OR (name =PressHighPlateName2) then result := 0;
            IF (name = PressLowPlateName) OR (name = PressLowPlateName2)  then result := 1;
          //end;
         end;
    4 : Begin
          result := doset(planstrCylinder,NCylinder,name);
         end;
    5 : Begin
          result := doset(planstrZone,NZone,name);
         end;
    6 : Begin
          result := doset(planstrMiscstring1,NMiscstring1,name);
         end;
    7 : Begin
          result := doset(planstrMiscstring2,NMiscstring2,name);
         end;
    8 : Begin
          result := doset(planstrMiscstring3,NMiscstring3,name);
         end;
  end;
end;

Function GetHighLowSTB( ID : Integer):string;
begin
  result := '';
    Case ID of
            0 : result := PressHighPlateName2;
            1 : result := PressLowPlateName2;
          end;
end;

Function GetPlannameFromID(nametype : Integer;
                           ID : Integer):string;
//1 tower, 2 stackpos, 3highlow,4 cyl,5 zone,6 Miscstring1,7 Miscstring2,8 Miscstring3
  Function doset(Var theset : tnamearray;
                 var Ntheset : Integer;
                 ID : Integer):String;
  Begin
    try
      if theset <> nil then
        result := theset[id];
    Except
    end;
  end;
begin
  try
    IF (ID < 0) or (ID > 256) then
      result := ''
    Else
    begin
      Case nametype of
        1 : Begin
              result := doset(Plantowers,NPlantowers,ID);
             end;
        2 : Begin
              result := doset(planstrstackpos,Nstackpos,ID);
             end;
        3 : Begin
              result := '';
              //if id > -1 then
              //  result := doset(Planhighlows,NPlanhighlows,ID);
              //if result = '' then
              //begin
                result := '';
                Case ID of
                  0 : result := PressHighPlateName;
                  1 : result := PressLowPlateName;
                end;


              //End;
             end;
        4 : Begin
              result := doset(planstrCylinder,NCylinder,ID);
             end;
        5 : Begin
              result := doset(planstrZone,NZone,ID);
             end;
        6 : Begin
              result := doset(planstrMiscstring1,NMiscstring1,ID);
             end;
        7 : Begin
              result := doset(planstrMiscstring2,NMiscstring2,ID);
             end;
        8 : Begin
              result := doset(planstrMiscstring3,NMiscstring3,ID);
             end;
      end;
    end;
  except
  end;
end;

Procedure addprodplate(IPLF : Integer;
                       IPL  : Integer;
                       Var prodplate : Tprodplate);
Begin
end;

procedure TPlateframe.PBExListview1Vertscroll(Sender: TObject);
Var
  I : Integer;
begin
  I := PBExListview1.Vertpos;
  IF I > 9999 then
    I := 2134;
end;
procedure TPlateframe.PBExListview1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Mouseisdown := false;
  PBExListview1.Cursor := crdefault;
  IF formprodplan.ActionMovepages.Checked then
  begin
    IF ((formprodplan.CopyIPLF = Mouseoveriplf) and ((formprodplan.copyIPL  <> mouseoveripl) or (formprodplan.CopyIP  <> mouseoverip))) and (mouseoverip > -1) then
      formprodplan.ActionPlanpastpageExecute(self);
  end;
end;
Function makeAplatecaption(IPLFNumber : Integer;
                           platenumber : Integer;
                           Extratext   : String):String;
Var
  tow,zone,{HL,}Frontback : String;
//  ip : Integer;
Begin
  result := '';
  try
    Frontback := fronbackstr[plateframesdata[IPLFNumber].prodplates[platenumber].Front];
    tow := GetplanTowername(plateframesdata[IPLFNumber].prodplates[platenumber].Tower);
    zone := GetPlannameFromID(5,plateframesdata[IPLFNumber].prodplates[platenumber].Zone);
    if (Prefs.UseTrueSheetSide) then
    begin
      IF plateframesdata[IPLFNumber].prodplates[platenumber].truefront - 2 in [0,1] then
      begin
        Frontback := fronbackstr[plateframesdata[IPLFNumber].prodplates[platenumber].truefront - 2];
      end;
    end;
    result := inttostr(plateframesdata[IPLFNumber].prodplates[platenumber].sheetnumber)+' '+Frontback;
    IF tow <> '' then
      result := result +' '+tow;
    IF Zone <> '' then
      result := result +' '+Zone;

  Except
  end;

end;

end.
