unit UXMLExport;
Interface
uses
  System.SysUtils, System.Classes,inifiles, Xml.xmldom, Xml.XMLIntf, Xml.Win.msxmldom, Xml.XMLDoc,
  WinApi.ActiveX, System.StrUtils, System.NetEncoding, Vcl.Dialogs,
  NativeXml, System.WideStrUtils;
type
  TDataModuleXML = class(TDataModule)
    XMLDocument1: TXMLDocument;
    SaveDialog1: TSaveDialog;
  private
  public
    { Public declarations }
    Function maketransxmls():boolean;
    Function TransferplantoAXML(loadedPlan: boolean):boolean;
    Function getfromdatabase(publicationid : Integer;
                             pubdate       : Tdatetime;
                             Pressid       : Integer;
                             NotIneditionid : Longint):boolean;
    Function makexmls(xmlfilename : string ):boolean;
    function GenerateStandardPlanPageName(PublicationAlias: string; Pubdate: TDateTime; Editionid: Integer; Sectionid: Integer; pageName: string): string;

  end;
var
  DataModuleXML: TDataModuleXML;

  NEditiondata : Integer;
  Editiondata : array[1..200] of  record
                                   presstime         : Tdatetime;
                                   EditionID           : Integer;
                                   Anyplates         : boolean;
                                   Numberofcopies    : Integer;
                                   NPages : Integer;
                                   PressSectionNumber : Integer;
                                   Pages : Array[1..200] of record
                                                              pagina         : Integer;   //3
                                                              pageindex      : Integer;   //4
                                                              pagename       : string;    //6
                                                              Priority          : Integer;
                                                              Section        : Integer;   //7
                                                              Unique         : Integer;   //9 1=X 0 =''
                                                              Planedpagename : string;    //10
                                                              NColors        : Integer;
                                                              miscstring2    : String;
                                                              pageID         : Integer;
                                                              masterpageid   : Integer;
                                                              Colors         : array[1..5] of record
                                                                                                colorid : Integer;
                                                                                                active  : Integer;
                                                                                              end;
                                                              Pagetype       : Integer;   //12 0 normal 1 panorama 2 anti
                                                              copyseparationset         : Integer;
                                                              mastercopyseparationset   : Integer;
                                                              Masteredition             : Integer;
                                                              Approved       : Integer;
                                                              Hold           : Integer;
                                                              Version        : Integer;
                                                              iplf           : Integer;
                                                              IPl            : Integer;
                                                              IP             : Integer;
                                                            end;

                                   Nplates : Integer;
                                   plates  : array[1..100] of record
                                                                Front : Integer;
                                                                Npages : Integer;
                                                                templatelistid    : Integer;
                                                                SortingPosition : String;
                                                                PressTower      : String;
                                                                PressZone       : String;
                                                                PressHighLow    : String;
                                                                miscstring3     : String;
                                                                Pages : Array[1..16] of record
                                                                                          posX : Integer;
                                                                                          posY : Integer;
                                                                                          pageindex : Integer;
                                                                                          pageid : Integer;
                                                                                          masterpageid : Integer;
                                                                                          copyseparationset : Integer;
                                                                                          sectionid : Integer;
                                                                                          pagina : Integer;
                                                                                          pagename : String;
                                                                                          iplf           : Integer;
                                                                                          IPl            : Integer;
                                                                                          IP             : Integer;
                                                                                        end;
                                                                NColors        : Integer;
                                                                Colors         : array[1..5] of record
                                                                                                  colorid : Integer;
                                                                                                  active  : Integer;
                                                                                                  Ncopies        : Integer;
                                                                                                  Cylinder : string;
                                                                                                  Copies         : array[1..4] of record
                                                                                                                                    miscstring2 : String;
                                                                                                                                    miscstring3 : String;
                                                                                                                                    High : String;
                                                                                                                                    SortingPosition : String;
                                                                                                                                  end;
                                                                                                end;
                                                              end;

                                 end;

implementation
uses forms, Umain,udata,utypes,DateUtils,UPlanframe, Uloadpressplan,
  UApplyplan, ULoadstbplan, UUtils,UPrefs;
{$R *.dfm}

Function TDataModuleXML.getfromdatabase(publicationid : Integer;
                                        pubdate       : Tdatetime;
                                        Pressid       : Integer;
                                        NotIneditionid : Longint):boolean;
Var
  I,Ied,ied2,dbl1,Ipage,ipage2,ColorIfound,Icolor,x,y,iplate : Integer;
  pubdatestr : string;
  Publicationexists : Boolean;
  T : String;
  aktcopyseparationset,aktcopyflatseparationset,akteditionid,aktsectionid,aktpageindex : Integer;
  aktpagenumber : Integer;
  Pacross,Pdown,Ppos : Integer;
Begin
  Pacross := 1;
  Pdown := 1;
  aktpagenumber := 0;
  NEditiondata := 0;
  pubdatestr    := DataM1.makedatastr('',pubdate);
  result := false;
  Publicationexists := false;
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.add('Select Distinct pressid,editionid,sectionid,pageindex,colorid,Pagination,pagename,UniquePage,PlanPageName,Pagetype,active,copyseparationset,mastercopyseparationset,miscstring2 ');
  DataM1.Query1.SQL.add(' ,max(hold),min(approved),min(version),min(presstime)');
  DataM1.Query1.SQL.add(' from pagetable WITH (NOLOCK) ');
  DataM1.Query1.SQL.add('where publicationid = ' + inttostr(publicationid) );
  DataM1.Query1.SQL.add('and '+ pubdatestr);
  IF Pressid > -1 then
    DataM1.Query1.SQL.add('and pressid = '+ inttostr(Pressid));
  DataM1.Query1.SQL.add('and editionid <> '+ inttostr(NotIneditionid));
  DataM1.Query1.SQL.add('and copynumber = 1');
  DataM1.Query1.SQL.add('and pagetype < 3 ');
  DataM1.Query1.SQL.add('group by pressid,editionid,sectionid,pageindex,colorid,Pagination,pagename,UniquePage,PlanPageName,Pagetype,active,copyseparationset,mastercopyseparationset,miscstring2 ');
  DataM1.Query1.SQL.add('order by pressid,editionid,sectionid,pageindex,colorid');
  IF Prefs.debug then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'XMLPage.sql');
  DataM1.Query1.open;
  akteditionid := -1;
  aktsectionid := -1;
  aktpageindex := -1;
  While not DataM1.Query1.eof do
  begin
    Publicationexists := true;
    IF (akteditionid <> DataM1.Query1.fieldbyname('editionid').asinteger) or
       (aktsectionid <> DataM1.Query1.fieldbyname('sectionid').asinteger) or
       (aktpageindex <> DataM1.Query1.fieldbyname('pageindex').asinteger) then
    begin
      IF (akteditionid <> DataM1.Query1.fieldbyname('editionid').asinteger) then
      begin
        akteditionid := DataM1.Query1.fieldbyname('editionid').asinteger;
        Inc(NEditiondata);
        Editiondata[NEditiondata].NPages := 0;
        Editiondata[NEditiondata].EditionId := akteditionid;
        Editiondata[NEditiondata].Nplates :=0;
        Editiondata[NEditiondata].presstime := DataM1.Query1.fieldS[17].AsDateTime;
        IF Editiondata[NEditiondata].presstime < encodedate(2000,1,1) then
          Editiondata[NEditiondata].presstime := now;
      end;
      IF (aktsectionid <> DataM1.Query1.fieldbyname('sectionid').asinteger) then
      begin
        aktsectionid := DataM1.Query1.fieldbyname('sectionid').asinteger;
      end;
      IF (aktpageindex <> DataM1.Query1.fieldbyname('pageindex').asinteger) then
      Begin
        aktpageindex := DataM1.Query1.fieldbyname('pageindex').asinteger;
      end;
      Inc(aktpagenumber);
      Inc(Editiondata[NEditiondata].NPages);
      Editiondata[NEditiondata].Pages[Editiondata[NEditiondata].NPages].pagina := DataM1.Query1.fieldbyname('Pagination').asinteger;
      Editiondata[NEditiondata].Pages[Editiondata[NEditiondata].NPages].pageindex := DataM1.Query1.fieldbyname('pageindex').asinteger;
      Editiondata[NEditiondata].Pages[Editiondata[NEditiondata].NPages].pagename := DataM1.Query1.fieldbyname('pagename').asstring;
      Editiondata[NEditiondata].Pages[Editiondata[NEditiondata].NPages].Section := DataM1.Query1.fieldbyname('sectionid').asinteger;
      Editiondata[NEditiondata].Pages[Editiondata[NEditiondata].NPages].Unique := DataM1.Query1.fieldbyname('UniquePage').asinteger;
      Editiondata[NEditiondata].Pages[Editiondata[NEditiondata].NPages].Planedpagename := DataM1.Query1.fieldbyname('PlanPageName').asstring;
      Editiondata[NEditiondata].Pages[Editiondata[NEditiondata].NPages].miscstring2 := DataM1.Query1.fieldbyname('miscstring2').asstring;
      Editiondata[NEditiondata].Pages[Editiondata[NEditiondata].NPages].NColors := 0;
      Editiondata[NEditiondata].Pages[Editiondata[NEditiondata].NPages].Pagetype := DataM1.Query1.fieldbyname('Pagetype').asinteger;
      Editiondata[NEditiondata].Pages[Editiondata[NEditiondata].NPages].copyseparationset := DataM1.Query1.fieldbyname('copyseparationset').asinteger;
      Editiondata[NEditiondata].Pages[Editiondata[NEditiondata].NPages].mastercopyseparationset := DataM1.Query1.fieldbyname('mastercopyseparationset').asinteger;
      Editiondata[NEditiondata].Pages[Editiondata[NEditiondata].NPages].Approved := DataM1.Query1.fields[15].asinteger;
      Editiondata[NEditiondata].Pages[Editiondata[NEditiondata].NPages].Hold := DataM1.Query1.fields[14].asinteger;
      Editiondata[NEditiondata].Pages[Editiondata[NEditiondata].NPages].Version := DataM1.Query1.fields[16].asinteger;
    end;
    Inc(Editiondata[NEditiondata].Pages[Editiondata[NEditiondata].NPages].NColors);
    Editiondata[NEditiondata].Pages[Editiondata[NEditiondata].NPages].Colors[Editiondata[NEditiondata].Pages[Editiondata[NEditiondata].NPages].NColors].colorid :=
      DataM1.Query1.fieldbyname('colorid').asinteger;
    Editiondata[NEditiondata].Pages[Editiondata[NEditiondata].NPages].Colors[Editiondata[NEditiondata].Pages[Editiondata[NEditiondata].NPages].NColors].active :=
      DataM1.Query1.fieldbyname('active').asinteger;
    DataM1.Query1.next;
  end;
  DataM1.Query1.close;
  For Ied := 1 to NEditiondata do
  begin
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.add('Select distinct PressSectionNumber,pressrunid,sheetnumber,sheetside,copyflatseparationset,Copynumber,flatseparationset,pagepositions,copyseparationset,');
    DataM1.Query1.SQL.add('TemplateID,colorid,flatseparation,MiscString3,SortingPosition,PressTower,PressZone,PressHighLow from pagetable WITH (NOLOCK)');
    DataM1.Query1.SQL.add('where publicationid = ' + inttostr(publicationid) );
    DataM1.Query1.SQL.add('and '+ pubdatestr);
    IF Pressid > -1 then
      DataM1.Query1.SQL.add('and pressid = '+ inttostr(Pressid));
    DataM1.Query1.SQL.add('and editionid = '+ inttostr(Editiondata[Ied].EditionID));
    //DataM1.Query1.SQL.add('and copynumber = 1');
    DataM1.Query1.SQL.add('order by PressSectionNumber,pressrunid,sheetnumber,sheetside,copyflatseparationset,Copynumber,flatseparationset,pagepositions,flatseparation');
    DataM1.Query1.open;
    aktcopyflatseparationset := -1;
    Editiondata[Ied].Nplates := 0;
    While not DataM1.Query1.eof do
    begin
      IF aktcopyflatseparationset <> DataM1.Query1.fieldbyname('copyflatseparationset').asinteger then
      begin
        Inc(Editiondata[Ied].Nplates);
        aktcopyflatseparationset := DataM1.Query1.fieldbyname('copyflatseparationset').asinteger;
        Editiondata[Ied].plates[Editiondata[Ied].Nplates].Npages := 0;
        Editiondata[Ied].plates[Editiondata[Ied].Nplates].Front := DataM1.Query1.fieldbyname('sheetside').asinteger;
        Editiondata[Ied].plates[Editiondata[Ied].Nplates].templatelistid :=
          inittypes.gettemplatenumberfromID(DataM1.Query1.fieldbyname('TemplateID').asinteger);
        Pacross := PlatetemplateArray[Editiondata[Ied].plates[Editiondata[Ied].Nplates].templatelistid].PagesAcross;
        pdown   := PlatetemplateArray[Editiondata[Ied].plates[Editiondata[Ied].Nplates].templatelistid].PagesDown;
        Editiondata[Ied].plates[Editiondata[Ied].Nplates].NColors := 0;

        Editiondata[Ied].plates[Editiondata[Ied].Nplates].SortingPosition
          := DataM1.Query1.fieldbyname('SortingPosition').asString;
        Editiondata[Ied].plates[Editiondata[Ied].Nplates].PressTower
          := DataM1.Query1.fieldbyname('PressTower').asString;
        Editiondata[Ied].plates[Editiondata[Ied].Nplates].PressZone
          := DataM1.Query1.fieldbyname('PressZone').asString;
        Editiondata[Ied].plates[Editiondata[Ied].Nplates].PressHighLow
          := DataM1.Query1.fieldbyname('PressHighLow').asString;
        aktcopyseparationset := -1;
      end;
      Ppos := strtoint(DataM1.Query1.fieldbyname('pagepositions').asstring);
      X := Ppos Mod Pacross;
      IF x = 0 then x := Pacross;
      Y := ((Ppos-1) div Pacross)+1;
      Editiondata[Ied].plates[Editiondata[Ied].Nplates].Pages[Ppos].posX := x;
      Editiondata[Ied].plates[Editiondata[Ied].Nplates].Pages[Ppos].posY := Y;
      Editiondata[Ied].plates[Editiondata[Ied].Nplates].Pages[Ppos].copyseparationset :=
        DataM1.Query1.fieldbyname('copyseparationset').asinteger;
      Editiondata[Ied].plates[Editiondata[Ied].Nplates].Npages := Pdown * Pacross;
      ColorIfound := -1;
      for icolor := 1 to Editiondata[Ied].plates[Editiondata[Ied].Nplates].NColors do
      begin
        IF Editiondata[Ied].plates[Editiondata[Ied].Nplates].Colors[icolor].colorid = DataM1.Query1.fieldbyname('ColorID').asinteger then
        begin
          ColorIfound := icolor;
          break;
        end;
      end;
      IF ColorIfound = -1 then
      Begin
        Inc(Editiondata[Ied].plates[Editiondata[Ied].Nplates].NColors);
        ColorIfound := Editiondata[Ied].plates[Editiondata[Ied].Nplates].NColors;
      end;
      Editiondata[Ied].plates[Editiondata[Ied].Nplates].Colors[ColorIfound].colorid := DataM1.Query1.fieldbyname('ColorID').asinteger;
      Editiondata[Ied].plates[Editiondata[Ied].Nplates].Colors[ColorIfound].Ncopies := DataM1.Query1.fieldbyname('Copynumber').asinteger;
      Editiondata[Ied].plates[Editiondata[Ied].Nplates].Colors[ColorIfound].copies[DataM1.Query1.fieldbyname('Copynumber').asinteger].miscstring3 :=
        DataM1.Query1.fieldbyname('miscstring3').asstring;
      T := DataM1.Query1.fieldbyname('miscstring3').asstring;
      dbl1 := pos(';',T);
      Delete(T,dbl1,100);
      Editiondata[Ied].plates[Editiondata[Ied].Nplates].Colors[ColorIfound].copies[DataM1.Query1.fieldbyname('Copynumber').asinteger].miscstring3 := T;

      DataM1.Query1.next;
    End;
  end;

  For Ied := 1 to NEditiondata do
  begin
    For ipage := 1 to Editiondata[Ied].Npages do
    begin
      if Editiondata[Ied].pages[ipage].mastercopyseparationset <> Editiondata[Ied].pages[ipage].copyseparationset then
      begin
        Editiondata[Ied].pages[ipage].Masteredition := -1;
        For Ied2 := 1 to NEditiondata do
        begin
          IF ied2 <> ied then
          begin
            For ipage2 := 1 to Editiondata[Ied2].Npages do
            begin
              if Editiondata[Ied].pages[ipage].mastercopyseparationset = Editiondata[Ied2].pages[ipage2].copyseparationset then
              begin
                Editiondata[Ied].pages[ipage].Masteredition := ied2;
                break;
              end;
            End;
          End;
          IF Editiondata[Ied].pages[ipage].Masteredition <> -1 then
            break;
        End;
      end;
    End;
  End;

  For Ied := 1 to NEditiondata do
  begin
    for iplate := 1 to Editiondata[Ied].Nplates do
    begin
      For ipage := 1 to Editiondata[Ied].plates[iplate].Npages do
      begin
        for ipage2 := 1 to Editiondata[Ied].NPages do
        begin
          IF Editiondata[Ied].plates[iplate].Pages[ipage].copyseparationset = Editiondata[Ied].pages[ipage2].copyseparationset then
          begin
            Editiondata[Ied].plates[iplate].Pages[ipage].pageindex := ipage2;
            break;
          end;
        end;
        IF Editiondata[Ied].plates[iplate].Pages[ipage].pageindex <= 0 then
          beep;
      end;

    end;
  end;

end;

Function TDataModuleXML.MakeXmls(xmlfilename : string):boolean;
Var
  pressesnodes,Pressnode,Plannode,publicationnode,issuesnode,issuenode : IXMLNode;
  editionsnode,editionnode,Sectionsnode,sectionnode,pagesnode,pagenode : IXMLNode;
  Separationsnode,Separationnode : IXMLNode;
  sheetsnode,sheetnode,SheetFrontItemsNode,SheetFrontItemNode : IXMLNode;
  PressCylindersnode,PressCylindernode : IXMLNode;
  icpy,Ied,ipage,masterpageid,ic,ipl,isec : Integer;
  FrontBacktext,aktplan,aktedition,aktsection,plateidstr : string;
  StackI, PlateCopies : Integer;
  produceedition : boolean;
  aktdatestr : string;
  aktdatetd : tdatetime;
  ds,ms,ys,T,savename : String;
  I : Integer;
begin
  try
    icpy  := 1;
    CoInitialize(Nil);

    result := false;
    StackI := 1;
    XMLDocument1.Active := true;
    XMLDocument1.XML.Clear;
    XMLDocument1.Encoding := 'ISO-8859-1';
    XMLDocument1.Version := '1.0';
    Plannode := XMLDocument1.AddChild('Plan','http://tempuri.org/ImportCenter.xsd');
    ds := inttostr(dayof(XMLPubdate));
    ms := inttostr(monthof(XMLPubdate));
    ys := inttostr(yearof(XMLPubdate));
    aktdatetd := XMLPubdate;
    Plannode.SetAttribute('version','1');
    Plannode.SetAttribute('UpdateTime',formatdatetime('YYYY-MM-DD',now)+'T'+formatdatetime('HH-NN-SS',now));
    Plannode.SetAttribute('Sender','ImportPlugin.dll');
    publicationnode := Plannode.AddChild('Publication');
    publicationnode.SetAttribute('PubDate',formatdatetime('YYYY-MM-DD',XMLPubdate));
    publicationnode.SetAttribute('Name',tnames1.publicationidtoname(XMLPublicationID) );
    publicationnode.SetAttribute('WeekReference',0);
    ied := 0;
    aktplan := 'uyoiwqouiwkj';
    issuesnode := publicationnode.AddChild('Issues');
    issuenode := issuesnode.AddChild('Issue');
    issuenode.SetAttribute('Name','Main');
    editionsnode := issuenode.AddChild('Editions');
    aktedition := '';
    aktsection := 'A';
    For ied := 1 to NEditiondata do
    begin
      aktedition := tnames1.editionIDtoname(Editiondata[ied].EditionID);
      editionnode := editionsnode.AddChild('Edition');
      editionnode.SetAttribute('Name',aktedition);
      pressesnodes := editionnode.AddChild('IntendedPresses');
      Pressnode  := pressesnodes.AddChild('IntendedPress');
      Pressnode.SetAttribute('Name',tnames1.pressnameIDtoname(XMLPressID));
      Pressnode.SetAttribute('Copies',10000);
      Pressnode.SetAttribute('PlateCopies',Editiondata[ied].Numberofcopies);
      Pressnode.SetAttribute('PostalUrl',''); //xyz.se/file.txt"
      Pressnode.SetAttribute('Presstime',formatdatetime('YYYY-MM-DD',Editiondata[ied].presstime)+'T'+formatdatetime('HH-NN-SS',Editiondata[ied].presstime));
      Sectionsnode := editionnode.AddChild('Sections');
      sectionnode := Sectionsnode.AddChild('Section');
      sectionnode.SetAttribute('Name',aktsection);
      pagesnode := Sectionnode.AddChild('Pages');
      for ipage := 1 to Editiondata[ied].NPages do
      begin
        PlateCopies := Editiondata[ied].Numberofcopies;

        pagenode := Pagesnode.AddChild('Page');
        pagenode.SetAttribute('Name',Editiondata[ied].Pages[ipage].pagename);
        pagenode.SetAttribute('FileName',Editiondata[ied].Pages[ipage].Planedpagename);
        pagenode.SetAttribute('PageID',Editiondata[ied].Pages[ipage].copyseparationset);
        pagenode.SetAttribute('PageType',Editiondata[ied].Pages[ipage].Pagetype);
        pagenode.SetAttribute('Pagination',Editiondata[ied].Pages[ipage].pagina);
        pagenode.SetAttribute('PageIndex',Editiondata[ied].Pages[ipage].pageindex);
        //pagenode.SetAttribute('Comment',Pagedata[ipage].platetext);
        if Editiondata[ied].Pages[ipage].copyseparationset=Editiondata[ied].Pages[ipage].mastercopyseparationset then
          pagenode.SetAttribute('Unique','true')
        else
          pagenode.SetAttribute('Unique','false');
        pagenode.SetAttribute('MasterPageID',Editiondata[ied].Pages[ipage].mastercopyseparationset);
        masterpageid := Editiondata[ied].Pages[ipage].mastercopyseparationset;
        IF Editiondata[ied].Pages[ipage].copyseparationset <> Editiondata[ied].Pages[ipage].mastercopyseparationset then
         // pagenode.SetAttribute('MasterEdition',tnames1.editionIDtoname(Editiondata[Editiondata[ied].Pages[ipage].Masteredition].EditionID))
          pagenode.SetAttribute('MasterEdition',tnames1.editionIDtoname(Editiondata[ied].Pages[ipage].Masteredition))
        else
          pagenode.SetAttribute('MasterEdition',tnames1.editionIDtoname(Editiondata[ied].EditionID));
        pagenode.SetAttribute('Approved',Editiondata[ied].Pages[ipage].Approved);
        pagenode.SetAttribute('Hold',Editiondata[ied].Pages[ipage].Hold);
        pagenode.SetAttribute('Priority',Editiondata[ied].Pages[ipage].Priority);
        pagenode.SetAttribute('Version',Editiondata[ied].Pages[ipage].Version);
        Separationsnode := Pagenode.AddChild('Separations');
        for ic := 1 to Editiondata[ied].Pages[ipage].NColors do
        begin
          Separationnode := Separationsnode.AddChild('Separation');
          Separationnode.SetAttribute('Name', tnames1.ColornameIDtoname(Editiondata[ied].Pages[ipage].Colors[ic].colorid) );
        end;
      end;

      sheetsnode := editionnode.AddChild('Sheets');
      for ipl := 1 to Editiondata[ied].Nplates do
      begin
        IF true then
        begin
          IF ipl mod 2 = 1 then
          begin
            sheetnode := sheetsnode.AddChild('Sheet');
            sheetnode.SetAttribute('Template',PlatetemplateArray[Editiondata[ied].plates[ipl].templatelistid].TemplateName);
            sheetnode.SetAttribute('PressSectionNumber',IntToStr(Editiondata[ied].PressSectionNumber));
          End;
          if Editiondata[ied].plates[ipl].Front = 0 then
          Begin
            FrontBacktext := 'Front';
          End
          else
            FrontBacktext := 'Back';

          //Todo
          sheetnode.SetAttribute('MarkGroups','');
          sheetnode.SetAttribute('PagesOnPlate',PlatetemplateArray[Editiondata[ied].plates[ipl].templatelistid].NupOnplate);

          SheetFrontItemsNode := sheetnode.AddChild('Sheet'+FrontBacktext+'Items');
          SheetFrontItemsNode.SetAttribute('SortingPosition',Editiondata[ied].plates[ipl].SortingPosition);
          SheetFrontItemsNode.SetAttribute('PressTower',Editiondata[ied].plates[ipl].PressTower);
          SheetFrontItemsNode.SetAttribute('PressZone',Editiondata[ied].plates[ipl].PressZone);
          SheetFrontItemsNode.SetAttribute('PressHighLow',Editiondata[ied].plates[ipl].PressHighLow);
          SheetFrontItemsNode.SetAttribute('ActiveCopies',Editiondata[ied].plates[ipl].Colors[1].Ncopies);

          For ipage := 1 to Editiondata[ied].plates[ipl].Npages do
          begin
            SheetFrontItemNode := SheetFrontItemsNode.AddChild('Sheet'+FrontBacktext+'Item');
            SheetFrontItemNode.SetAttribute('PageName',Editiondata[ied].pages[Editiondata[ied].plates[ipl].pages[ipage].pageindex].pagename);
            SheetFrontItemNode.SetAttribute('PageID',Editiondata[ied].plates[ipl].Pages[ipage].copyseparationset);
            SheetFrontItemNode.SetAttribute('MasterPageID',Editiondata[ied].pages[Editiondata[ied].plates[ipl].pages[ipage].pageindex].mastercopyseparationset);
            SheetFrontItemNode.SetAttribute('Section',tnames1.sectionIDtoname(Editiondata[ied].pages[Editiondata[ied].plates[ipl].pages[ipage].pageindex].Section));
            SheetFrontItemNode.SetAttribute('PosX',Editiondata[ied].plates[ipl].Pages[ipage].posX);
            SheetFrontItemNode.SetAttribute('PosY',Editiondata[ied].plates[ipl].Pages[ipage].posY);
          End;
          PressCylindersnode := SheetFrontItemsNode.AddChild('PressCylinders'+FrontBacktext);
          for ic := 1 to Editiondata[ied].plates[ipl].NColors do
          begin
            PressCylindernode := PressCylindersnode.AddChild('PressCylinder'+FrontBacktext);
            PressCylindernode.SetAttribute('Name','');
            PressCylindernode.SetAttribute('Color',tnames1.ColornameIDtoname(Editiondata[ied].plates[ipl].Colors[ic].colorid));

            PressCylindernode.SetAttribute('FormID',Editiondata[ied].pages[Editiondata[ied].plates[ipl].pages[1].pageindex].miscstring2);


            plateidstr := Editiondata[ied].plates[ipl].Colors[ic].Copies[1].miscstring3;
            if (PlateCopies = 2) and (plateidstr <>'') then
               plateidstr := plateidstr + ',' + Editiondata[ied].plates[ipl*PlateCopies].Colors[ic].Copies[2].miscstring3;
            PressCylindernode.SetAttribute('PlateID',plateidstr);
          end;
        end;
      end;

    End;

    if Prefs.ImportCenterInputPath <> '' then
    begin
      savename := Includetrailingbackslash(Prefs.ImportCenterInputPath) +
          tnames1.pressnameIDtoname(XMLPressID) + '_' +
          tnames1.publicationidtoname(XMLPublicationID)+'_'+
          formatdatetime('YYYY-MM-DD',XMLPubdate);

       if (Prefs.XMLPlanAddTimestampToFileName) then
        savename := savename + '_' + TUtils.GenerateTimeStamp();

      savename := savename + '.xml';
      deletefile(savename);
      XMLDocument1.SaveToFile(savename);
    end;
    SaveDialog1.FileName := tnames1.publicationidtoname(XMLPublicationID)+'_'+ formatdatetime('YYYY-MM-DD',XMLPubdate)+'.xml';
    IF SaveDialog1.execute then
    begin
      deletefile(SaveDialog1.FileName);
      XMLDocument1.SaveToFile(SaveDialog1.FileName);
    end;

    result := true;
  finally
    XMLDocument1.Active := false;
  End;
end;
// Used by Plan create apply and load
// Global vars XMLPubdate, XMLPublicationID, XMLPressID are set by caller prior to call.
Function TDataModuleXML.MakeTransXmls():boolean;
Var
  pressesnodes,Pressnode,Plannode,publicationnode,issuesnode,issuenode : IXMLNode;
  editionsnode,editionnode,Sectionsnode,sectionnode,pagesnode,pagenode : IXMLNode;
  Separationsnode,Separationnode : IXMLNode;
  sheetsnode,sheetnode,SheetFrontItemsNode,SheetFrontItemNode : IXMLNode;
  PressCylindersnode,PressCylindernode : IXMLNode;
  icpy,Ied,ipage,masterpageid,ic,ipl,isec : Integer;
  FrontBacktext,aktedition,aktsection,plateidstr : string;
  Aktsecionid,StackI : Integer;
  produceedition,Foundsec : boolean;
  aktdatestr : string;
  aktdatetd : tdatetime;
  //ds,ms,ys,
  T,sortstr,savename,formIDstr : String;
  I : Integer;
  Nsections,isecs,dbl1 : Integer;
  Sections : Array[1..10] of Integer;
  ADoc: TNativeXml;
  plannodeX, publicationnodeX, issuesnodeX,issuenodeX,editionsnodeX,editionnodeX,
  pressesnodeX,pressnodeX,sectionsnodeX,sectionnodeX,PagesnodeX,PagenodeX, SeparationsnodeX, SeparationnodeX,
  SheetsnodeX,SheetnodeX, SheetFrontItemsNodeX, SheetFrontItemNodeX, PressCylindersnodeX, PressCylindernodeX :   TXmlNode;
  platecopies : Integer;
  xmlText : String;
begin
  try

    CoInitialize(Nil);
    result := false;
    StackI := 1;
    ADoc := TNativeXml.CreateName('Plan');
    plannodeX := ADoc.Root;
    ADoc.ExternalEncoding := seUTF8;
   // ds := inttostr(dayof(XMLPubdate));
   // ms := inttostr(monthof(XMLPubdate));
   // ys := inttostr(yearof(XMLPubdate));
    aktdatetd := XMLPubdate;
     plannodeX.AttributeAdd('xmlns', 'http://tempuri.org/ImportCenter.xsd');
     plannodeX.AttributeAdd('Plantype', 'PressPlan');
     plannodeX.AttributeAdd('Planmode', 'Add');
     plannodeX.AttributeAdd('Version', '2');
     plannodeX.AttributeAdd('UpdateTime', formatdatetime('YYYY-MM-DD',now)+'T'+formatdatetime('HH-NN-SS',now));
     plannodeX.AttributeAdd('RipSetup', XMLRipSetup);
     plannodeX.AttributeAdd('PreflightSetup', XMLPreflightSetup);
     plannodeX.AttributeAdd('InkSaveSetup', XMLInkSaveSetup);
     plannodeX.AttributeAdd('SpecificDevice', XMLSpecificDevice);
     plannodeX.AttributeAdd('Sender','PlanCenter');
     publicationnodeX := plannodeX.NodeNew('Publication');
     publicationnodeX.AttributeAdd('PubDate',formatdatetime('YYYY-MM-DD',XMLPubdate));
     publicationnodeX.AttributeAdd('Name',TNetEncoding.HTML.Encode(tnames1.publicationidtoname(XMLPublicationID) ));
     publicationnodeX.AttributeAdd('WeekReference','0');
     issuesnodeX := publicationnodeX.NodeNew('Issues');
     issuenodeX := issuesnodeX.NodeNew('Issue');
     issuenodeX.AttributeAdd('Name','Main');
     editionsnodeX := issuenodeX.NodeNew('Editions');
     aktedition := '';
     aktsection := '1';
     Aktsecionid := -1;

    For ied := 1 to NEditiondata do
    begin
      if (aktedition <>  tnames1.editionIDtoname(Editiondata[ied].EditionID)) then
      begin
        editionnodeX := editionsnodeX.NodeNew('Edition');
        editionnodeX.AttributeAdd('Name',tnames1.editionIDtoname(Editiondata[ied].EditionID));
        pressesnodeX := editionnodeX.NodeNew('IntendedPresses');
        pressnodeX  := pressesnodeX.NodeNew('IntendedPress');
        pressnodeX.AttributeAdd('Name',tnames1.pressnameIDtoname(XMLPressID));
        pressnodeX.AttributeAdd('Copies','10000');
        pressnodeX.AttributeAdd('PlateCopies',IntToStr(Editiondata[ied].Numberofcopies));
        pressnodeX.AttributeAdd('PostalUrl','');
        pressnodeX.AttributeAdd('Presstime',formatdatetime('YYYY-MM-DD',Editiondata[ied].presstime)+'T'+formatdatetime('HH-NN-SS',Editiondata[ied].presstime));
        aktedition := tnames1.editionIDtoname(Editiondata[ied].EditionID);
        sectionsnodeX := editionnodeX.NodeNew('Sections');
      end;
      Nsections := 0;
      for ipage := 1 to Editiondata[ied].NPages do
      begin
        Foundsec := false;
        For i := 1 to Nsections do
        begin
          IF Editiondata[ied].Pages[ipage].Section = sections[i] then
          Begin
            foundsec := true;
            break;
          End;
        end;
        IF Not Foundsec Then
        Begin
          Inc(Nsections);
          sections[Nsections] := Editiondata[ied].Pages[ipage].Section;
        End;
      End;

      For isecs := 1 to Nsections do
      begin
        aktsection := tnames1.SectionIDtoname(sections[Isecs]);
        SectionnodeX := SectionsnodeX.NodeNew('Section');
        SectionnodeX.AttributeAdd('Name',aktsection);
        PagesnodeX := SectionnodeX.NodeNew('Pages');
        Aktsecionid := sections[Isecs];
        for ipage := 1 to Editiondata[ied].NPages do
        begin
          IF Editiondata[ied].Pages[ipage].Section = sections[Isecs] then
          begin
            pagenodeX := PagesnodeX.NodeNew('Page');
            pagenodeX.AttributeAdd('Name',Editiondata[ied].Pages[ipage].pagename);
            pagenodeX.AttributeAdd('FileName',Editiondata[ied].Pages[ipage].Planedpagename);
            pagenodeX.AttributeAdd('PageID', IntToStr(Editiondata[ied].Pages[ipage].pageID));
            pagenodeX.AttributeAdd('PageType',IntToStr(Editiondata[ied].Pages[ipage].Pagetype));
            pagenodeX.AttributeAdd('Pagination',IntToStr(Editiondata[ied].Pages[ipage].pagina));
            pagenodeX.AttributeAdd('PageIndex', IntToStr(Editiondata[ied].Pages[ipage].pageindex));
            if Editiondata[ied].Pages[ipage].pageid=Editiondata[ied].Pages[ipage].masterpageid then
              PagenodeX.AttributeAdd('Unique','true')
            else
              PagenodeX.AttributeAdd('Unique','false');
            pagenodeX.AttributeAdd('MasterPageID',IntToStr(Editiondata[ied].Pages[ipage].masterpageid));

            masterpageid := Editiondata[ied].Pages[ipage].mastercopyseparationset;
            if Editiondata[ied].Pages[ipage].pageid <> Editiondata[ied].Pages[ipage].masterpageid then
//              pagenodeX.AttributeAdd('MasterEdition',tnames1.editionIDtoname(Editiondata[Editiondata[ied].Pages[ipage].Masteredition].EditionID))
              pagenodeX.AttributeAdd('MasterEdition',tnames1.editionIDtoname(Editiondata[ied].Pages[ipage].Masteredition))
            else
              pagenodeX.AttributeAdd('MasterEdition',tnames1.editionIDtoname(Editiondata[ied].EditionID));
            pagenodeX.AttributeAdd('Approved', IntToStr(Editiondata[ied].Pages[ipage].Approved));
            pagenodeX.AttributeAdd('Hold', IntToStr(Editiondata[ied].Pages[ipage].Hold));
            pagenodeX.AttributeAdd('Priority',IntToStr(Editiondata[ied].Pages[ipage].Priority));
            pagenodeX.AttributeAdd('Version', IntToStr(Editiondata[ied].Pages[ipage].Version));
            separationsnodeX := PagenodeX.NodeNew('Separations');
            for ic := 1 to Editiondata[ied].Pages[ipage].NColors do
            begin
              separationnodeX := SeparationsnodeX.NodeNew('Separation');
              separationnodeX.AttributeAdd('Name', tnames1.ColornameIDtoname(Editiondata[ied].Pages[ipage].Colors[ic].colorid) );
            end;
          End;
        end;
      End;
    End;   // end editions NAN

    sheetsnodeX := EditionnodeX.NodeNew('Sheets');

    For ied := 1 to NEditiondata do
    begin
      PlateCopies := Editiondata[ied].Numberofcopies;
      Editiondata[ied].Nplates := Editiondata[ied].Nplates div PlateCopies;
      aktedition := tnames1.editionIDtoname(Editiondata[ied].EditionID);

      for ipl := 1 to Editiondata[ied].Nplates do
      begin
        if  (true) then //((PlateCopies = 1) or ((PlateCopies = 2) and ((ipl mod 2) = 1)) )   then
        begin
          IF  Editiondata[ied].plates[ipl*PlateCopies].Front = 0 then //ipl mod 2 = 1 then
          begin
            sheetnodeX := SheetsnodeX.NodeNew('Sheet');
            sheetnodeX.AttributeAdd('Template',PlatetemplateArray[Editiondata[ied].plates[ipl*PlateCopies].templatelistid].TemplateName);
            FrontBacktext := 'Front';
            sheetnodeX.AttributeAdd('MarkGroups','');
            sheetnodeX.AttributeAdd('PagesOnPlate', IntToStr(PlatetemplateArray[Editiondata[ied].plates[ipl*PlateCopies].templatelistid].NupOnplate));
            sheetnodeX.AttributeAdd('PressSectionNumber',IntToStr(Editiondata[ied].PressSectionNumber));
          end
          else
            FrontBacktext := 'Back';
          sheetFrontItemsNodeX := SheetnodeX.NodeNew('Sheet'+FrontBacktext+'Items');
          T := Editiondata[ied].plates[ipl*PlateCopies].PressTower;
          dbl1 := pos(';',T);
          IF dbl1 > 0 then
          Begin
            delete(t,dbl1,100);
          End;
          sheetFrontItemsNodeX.AttributeAdd('PressTower',T);
          sheetFrontItemsNodeX.AttributeAdd('PressZone',Editiondata[ied].plates[ipl*PlateCopies].PressZone);
          T := Editiondata[ied].plates[ipl*PlateCopies].PressHighLow;
          if (PlateCopies = 2) and (T <>'') then
            T := T + ',' +  Editiondata[ied].plates[ipl*PlateCopies+1].PressHighLow;
          T  := StringReplace(T, ';', ',', [rfReplaceAll, rfIgnoreCase]);
          sheetFrontItemsNodeX.AttributeAdd('PressHighLow',T);
          sheetFrontItemsNodeX.AttributeAdd('ActiveCopies',IntToStr(PlateCopies));
          For ipage := 1 to Editiondata[ied].plates[ipl].Npages do
          begin
            SheetFrontItemNodeX := SheetFrontItemsNodeX.NodeNew('Sheet'+FrontBacktext+'Item');
            SheetFrontItemNodeX.AttributeAdd('PageName',Editiondata[ied].plates[ipl*PlateCopies].Pages[ipage].pagename);
            SheetFrontItemNodeX.AttributeAdd('PageID',IntToStr(Editiondata[ied].plates[ipl*PlateCopies].Pages[ipage].pageid));
            SheetFrontItemNodeX.AttributeAdd('MasterPageID',IntToStr(Editiondata[ied].plates[ipl*PlateCopies].Pages[ipage].masterpageid));
            SheetFrontItemNodeX.AttributeAdd('Section',tnames1.sectionIDtoname(Editiondata[ied].plates[ipl*PlateCopies].Pages[ipage].sectionid));
            SheetFrontItemNodeX.AttributeAdd('PosX', IntToStr(Editiondata[ied].plates[ipl*PlateCopies].Pages[ipage].posX));
            SheetFrontItemNodeX.AttributeAdd('PosY', IntToStr(Editiondata[ied].plates[ipl*PlateCopies].Pages[ipage].posY));
          End;
          PressCylindersnodeX := SheetFrontItemsNodeX.NodeNew('PressCylinders'+FrontBacktext);
          for ic := 1 to Editiondata[ied].plates[ipl*PlateCopies].NColors do
          begin
            plateidstr := Editiondata[ied].plates[ipl*PlateCopies].Colors[ic].Copies[1].miscstring3;
            if (PlateCopies = 2) and (plateidstr <>'') then
               plateidstr := plateidstr + ',' + Editiondata[ied].plates[ipl*PlateCopies].Colors[ic].Copies[2].miscstring3;
            sortstr := Editiondata[ied].plates[ipl*PlateCopies].colors[ic].copies[1].SortingPosition;
            if (PlateCopies = 2) and (sortstr <>'') then
                   sortstr := sortstr + ',' + Editiondata[ied].plates[ipl*PlateCopies].colors[ic].copies[2].SortingPosition;
            formIDstr := Editiondata[ied].plates[ipl*PlateCopies].Colors[ic].Copies[1].miscstring2;
            if (PlateCopies = 2) and (formIDstr <>'') then
              formIDstr := formIDstr + ',' + Editiondata[ied].plates[ipl*PlateCopies].Colors[ic].Copies[2].miscstring2;
            Delete(Editiondata[ied].plates[ipl*PlateCopies+1].PressZone,dbl1,100);
            PressCylindernodeX := PressCylindersnodeX.NodeNew('PressCylinder'+FrontBacktext);
            T := Editiondata[ied].plates[ipl*PlateCopies].Colors[ic].cylinder;
            dbl1 := pos(';',T);
            IF dbl1 > 0 then
            Begin
              delete(t,dbl1,100);
            End;
            PressCylindernodeX.AttributeAdd('Name',T);
            PressCylindernodeX.AttributeAdd('Color',tnames1.ColornameIDtoname(Editiondata[ied].plates[ipl].Colors[ic].colorid));
            T := StringReplace(sortstr, ';', ',', [rfReplaceAll, rfIgnoreCase]);
            PressCylindernodeX.AttributeAdd('SortingPosition',T);
            PressCylindernodeX.AttributeAdd('FormID',formIDstr);
            PressCylindernodeX.AttributeAdd('PlateID',plateidstr);
          end;
        end;
      end;
    End;
    IF Prefs.ImportCenterInputPath <> '' then
    Begin
      savename := Includetrailingbackslash(Prefs.ImportCenterInputPath) + tnames1.pressnameIDtoname(XMLPressID) +'_'+  tnames1.publicationidtoname(XMLPublicationID)+'_'+ formatdatetime('YYYY-MM-DD',XMLPubdate);
      if (Prefs.XMLPlanAddTimestampToFileName) then
        savename := savename + '_' + TUtils.GenerateTimeStamp();
      savename := savename  +'.xml';
      deletefile(savename);
      ADoc.XmlFormat := xfReadable;
     // ADoc.SaveToFile(savename);
      xmlText := AnsiToUtf8Ex(ADoc.WriteToString,1252);
      with TStringList.Create do
     try
      Add(xmlText);
      SaveToFile(savename);
     finally
      Free;
     end;
    End
    Else
    Begin
      SaveDialog1.FileName := tnames1.publicationidtoname(XMLPublicationID)+'_'+ formatdatetime('YYYY-MM-DD',XMLPubdate)+'.xml';
      IF SaveDialog1.execute then
      begin
        deletefile(SaveDialog1.FileName);
        ADoc.XmlFormat := xfReadable;
        ADoc.SaveToFile(SaveDialog1.FileName);
      end;
    End;
    result := true;
  finally
    FreeAndNil(ADoc);
  End;
end;

Function TDataModuleXML.TransferplantoAXML(loadedPlan: boolean):boolean;
Var
  nedi : Integer;
Procedure findpagespageids(Editionid : Integer;
                           sectionid : Integer;
                           pageindex : Integer;
                           Var pageid : Integer;
                           Var Masterpageid : Longint);
Var
  ied,ip : Integer;
Begin
  For ied := 1 to nedi do
  begin
    for ip := 1 to Editiondata[ied].NPages do
    begin
      if (Editiondata[ied].Pages[ip].pageindex = pageindex) and
         (Editiondata[ied].Pages[ip].Section = sectionid) and
         (editionid = Editiondata[ied].EditionID) then
      begin
        pageid :=  Editiondata[ied].Pages[ip].pageID;
        masterpageid :=  Editiondata[ied].Pages[ip].masterpageID;
      end;
    end;
  end;
end;

Var
  ied,isec,iEpage,Iplf,ipl,ip : Integer;
  Nsections : Integer;
  Sections : Array[1..10] of Integer;

Var
  I,ied2,ip2 : Integer;
  T,tt : String;
  Pageid,PLip,Pip,ic,EdiIP,ipf,icpy : Integer;
  ncop,Foundipl,Foundiplf,foundip :Integer;
  Aktfront,iedP,aktedition,dbl1 : Integer;
  NextIPLF,founded : boolean;
  aktsection : Integer;
  PressSectionNumber : Integer;
  Nup : Integer;
begin
  try
  ipl := 0;
  i := 0;
    nedi := 0;
    result := false;
    NEditiondata := 1;
    Editiondata[1].NPages := 0;
    Nsections := 0;
    Ied := 1;
    PressSectionNumber := 0;
    XMLPlateCopies := 1;
  //  XMLRipSetup := '';
  //  XMLPreflightSetup := '';
  //  XMLInkSaveSetup := '';
    if (loadedPlan) then
    begin
      if (Prefs.CustomBuildName = 'STB') and (XMLPressID = 3) then
      begin   // Schibsted STB hack
          XMLPublicationID := tnames1.publicationnametoid(Formloadstbplan.ComboBoxpublication.Text);
          XMLPubdate := Formloadstbplan.DateTimePicker1loadplan.Date;
          XMLPlateCopies := Formloadstbplan.UpDownCopies.Position;
      end
      else
      begin
         XMLPublicationID := tnames1.publicationnametoid(Formloadpressplan.ComboBoxpublication.Text);
         XMLPubdate := Formloadpressplan.DateTimePicker1loadplan.Date;
         XMLPlateCopies := Formloadpressplan.UpDownCopies.Position;
      end;
    end
    else    // Create
    begin
      for iplf := 1 to Nplateframes  do
      begin
        for ipl := 0 to plateframes[iplf].Nprodplates do
        begin
           if (plateframes[iplf].Numberofcopies > XMLPlateCopies) then
              XMLPlateCopies :=  plateframes[iplf].Numberofcopies;
        end;
      end;

    end;

    pageid := 0;
    Foundipl := -1;
    Foundiplf := -1;
    foundip := -1;
    aktedition := -1;
    aktsection := -1;
    Ied := 0;
    Pageid := 0;
    NextIPLF := true;
    for iplf := 1 to Nplateframes  do
    begin
      ipl := 0;
      inc(PressSectionNumber);
      // New edition?
      if (aktedition <> plateframesdata[iplf].prodplates[1].EditionID) or (true) then
      begin
          Inc(ied);
          Editiondata[ied].PressSectionNumber := PressSectionNumber;
          Editiondata[ied].NPages := 0;
          Editiondata[ied].Anyplates := false;
          Editiondata[ied].Nplates := plateframes[iplf].Nprodplates+1;
          Editiondata[ied].Numberofcopies := XMLPlateCopies;
          aktedition := plateframesdata[iplf].prodplates[1].EditionID;
          Editiondata[ied].EditionID := aktedition;
          Editiondata[ied].Anyplates := false;
          nedi := ied;
          NextIPLF := false;
      end;
      Foundipl := ipl;
      Foundiplf := iplf;
      foundip := i;
      Aktfront := 1;
      For ipl := 0 to plateframes[iplf].Nprodplates do
      begin
        Nup :=  platetemplatearray[plateframesdata[iplf].prodplates[ipl].templatelistid].NupOnplate;
        for ip := 1 to Nup do
        Begin
          founded := false;
          For iedP := 1 to Editiondata[ied].NPages do
          begin
            if (Editiondata[ied].Pages[iedP].pageindex = plateframesdata[iplf].prodplates[ipl].pages[ip].pageindex) and
               (Editiondata[ied].Pages[iedP].Section = plateframesdata[iplf].prodplates[ipl].pages[ip].SectionID) and
               (Editiondata[ied].EditionID = plateframesdata[iplf].prodplates[ipl].EditionID) then
            begin
              founded := true;
              break;
            end;
          end;
          if not founded then
          begin
            Inc(Pageid);
            Inc(Editiondata[ied].NPages);
            Editiondata[ied].EditionID := plateframesdata[iplf].prodplates[ipl].EditionID;
            if plateframesdata[iplf].prodplates[ipl].pages[ip].totUniquePage = 1 then
              Editiondata[ied].Anyplates := true;
            Editiondata[ied].Pages[Editiondata[ied].NPages].pagina := plateframesdata[iplf].prodplates[ipl].pages[ip].Pagina;
            Editiondata[ied].Pages[Editiondata[ied].NPages].pageindex := plateframesdata[iplf].prodplates[ipl].pages[ip].pageindex;
            Editiondata[ied].Pages[Editiondata[ied].NPages].pagename := plateframesdata[iplf].prodplates[ipl].pages[ip].pagename;
            Editiondata[ied].Pages[Editiondata[ied].NPages].Priority := 50;
            Editiondata[ied].Pages[Editiondata[ied].NPages].Section := plateframesdata[iplf].prodplates[ipl].pages[ip].SectionID;
            Editiondata[ied].Pages[Editiondata[ied].NPages].NColors := plateframesdata[iplf].prodplates[ipl].pages[ip].Ncolors;
            Editiondata[ied].Pages[Editiondata[ied].NPages].Pagetype := 1;//plateframesdata[iplf].prodplates[ipl].pages[ip].pagetype;
            if (AnsiContainsText(Editiondata[ied].Pages[Editiondata[ied].NPages].pagename,'Dinkey')) then
              Editiondata[ied].Pages[Editiondata[ied].NPages].Pagetype := 3;
            Editiondata[ied].Pages[Editiondata[ied].NPages].copyseparationset := plateframesdata[iplf].prodplates[ipl].pages[ip].CopySeparationSet;
            Editiondata[ied].Pages[Editiondata[ied].NPages].Approved := plateframesdata[iplf].prodplates[ipl].pages[ip].approved;
            Editiondata[ied].Pages[Editiondata[ied].NPages].Hold := FormApplyproduction.RadioGrouphold.ItemIndex + 1;
            Editiondata[ied].Pages[Editiondata[ied].NPages].Version := 0;
            Editiondata[ied].Pages[Editiondata[ied].NPages].iplf := iplf;
            Editiondata[ied].Pages[Editiondata[ied].NPages].ipl := ipl;
            Editiondata[ied].Pages[Editiondata[ied].NPages].ip := ip;
            Editiondata[ied].Pages[Editiondata[ied].NPages].pageid := Pageid;
            plateframesdata[iplf].prodplates[ipl].pages[ip].pageid := pageid;
            Editiondata[ied].Pages[Editiondata[ied].NPages].mastercopyseparationset := plateframesdata[iplf].prodplates[ipl].pages[ip].MasterCopySeparationSet;
            IF plateframesdata[iplf].prodplates[ipl].pages[ip].OrgeditionID = plateframesdata[iplf].prodplates[ipl].EditionID then
            Begin
              Editiondata[ied].Pages[Editiondata[ied].NPages].masterpageid := Pageid;
              plateframesdata[iplf].prodplates[ipl].pages[ip].masterpageid := pageid;
              Editiondata[ied].Pages[Editiondata[ied].NPages].Masteredition := plateframesdata[iplf].prodplates[ipl].EditionID;
              Editiondata[ied].Pages[Editiondata[ied].NPages].mastercopyseparationset := plateframesdata[iplf].prodplates[ipl].EditionID;
              Editiondata[ied].Pages[Editiondata[ied].NPages].Unique := 1;
              Editiondata[ied].Pages[Editiondata[ied].NPages].Masteredition := Editiondata[ied].EditionID;
            End
            Else
            Begin
              Editiondata[ied].Pages[Editiondata[ied].NPages].Unique := 0;
              Editiondata[ied].Pages[Editiondata[ied].NPages].Masteredition := plateframesdata[iplf].prodplates[ipl].pages[ip].OrgeditionID;
              Editiondata[ied].Pages[Editiondata[ied].NPages].mastercopyseparationset := plateframesdata[iplf].prodplates[ipl].pages[ip].MasterCopySeparationSet;
              plateframesdata[iplf].prodplates[ipl].pages[ip].masterpageid := 0;
              Editiondata[ied].Pages[Editiondata[ied].NPages].masterpageid := 0;
            End;
            for ic := 1 to plateframesdata[iplf].prodplates[ipl].pages[ip].Ncolors do
            begin
              Editiondata[ied].Pages[Editiondata[ied].NPages].Colors[ic].colorid := plateframesdata[iplf].prodplates[ipl].pages[ip].colors[ic].colorid;
              Editiondata[ied].Pages[Editiondata[ied].NPages].Colors[ic].active := plateframesdata[iplf].prodplates[ipl].pages[ip].colors[ic].active;
            end;

            if (Prefs.GeneratePlanPageNames) then
            begin
              t := tnames1.publicationIDtoname(XMLPublicationID);
              t := tnames1.GetPublicationAlias(t);
              Editiondata[ied].Pages[Editiondata[ied].NPages].Planedpagename := GenerateStandardPlanPageName(t, XMLPubdate,  Editiondata[ied].EditionID, Editiondata[ied].Pages[Editiondata[ied].NPages].Section,Editiondata[ied].Pages[Editiondata[ied].NPages].pagename);
            end;
          end;

        End;
      end;
      NextIPLF := true;
    End;
    for iplf := 1 to Nplateframes do
    begin
      For ied := 1 to nedi do
      begin
        //ied := iplf;
        For ip := 1 to Editiondata[ied].NPages do
        begin
          IF Editiondata[ied].Pages[ip].masterpageid = 0 then
          begin
            For ied2 := 1 to nedi do
            begin
              IF Editiondata[ied2].EditionID = Editiondata[ied].Pages[ip].Masteredition then
              begin
                For ip2 := 1 to Editiondata[ied2].NPages do
                begin
                  if (Editiondata[ied2].Pages[iP2].pageindex = Editiondata[ied].Pages[iP].pageindex) and
                     (Editiondata[ied2].Pages[iP2].Section = Editiondata[ied].Pages[iP].Section) then
                  begin
                    Editiondata[ied].Pages[iP].masterpageid := Editiondata[ied2].Pages[iP2].masterpageid;
                    break;
                  end;
                end;
                IF Editiondata[ied].Pages[iP].masterpageid <> 0 then
                  break;
              End;
            End;
          end;
        end;
      end;
    End;
  //  if (loadedPlan) then
 //   begin
  //    if (Prefs.CustomBuildName = 'STB') and (XMLPressID = 3) then
  //      ncop := Formloadstbplan.UpDownCopies.Position
   //   else
   //     ncop := Formloadpressplan.UpDownCopies.Position;
  //  end;
    // NAN
    ncop := 1;
    Aktfront := 1;
    for iplf := 1 to Nplateframes do
    begin
    (*
      For ied := 1 to nedi do
      begin
      *)
        ied := iplf;
        for ipl := 0 to plateframes[iplf].Nprodplates do
        begin
          Nup := platetemplatearray[plateframesdata[iplf].prodplates[ipl * ncop].templatelistid].NupOnplate;
          for ip := 1 to Nup do
          begin
            IF aktfront = 1 then
              aktfront := 0
            Else
              aktfront := 1;
            Editiondata[ied].plates[ipl+1].Front := plateframesdata[iplf].prodplates[ipl * ncop].Front;
            Editiondata[ied].plates[ipl+1].Npages := platetemplatearray[plateframesdata[iplf].prodplates[ipl * ncop].templatelistid].NupOnplate;
            Editiondata[ied].plates[ipl+1].templatelistid := plateframesdata[iplf].prodplates[ipl * ncop].templatelistid;
            Editiondata[ied].plates[ipl+1].PressTower := Getplantowername(plateframesdata[iplf].prodplates[ipl * ncop].Tower);
            Editiondata[ied].plates[ipl+1].PressZone := GetPlannameFromID(5,plateframesdata[iplf].prodplates[ipl * ncop].Zone);

            dbl1 := pos(';',Editiondata[ied].plates[ipl+1].PressZone);
            Delete(Editiondata[ied].plates[ipl+1].PressZone,dbl1,100);
            Editiondata[ied].plates[ipl+1].NColors := 4;
            Editiondata[ied].plates[ipl+1].Pages[1].posX := 1;
            Editiondata[ied].plates[ipl+1].Pages[1].posy := 1;
            if (Nup = 2) and (Editiondata[ied].plates[ipl+1].Npages > 1) then
            begin
              if platetemplatearray[plateframesdata[iplf].prodplates[ipl * ncop].templatelistid].Pagesdown > platetemplatearray[plateframesdata[iplf].prodplates[ipl * ncop].templatelistid].Pagesacross then
              begin
                Editiondata[ied].plates[ipl+1].Pages[2].posX := 1;
                Editiondata[ied].plates[ipl+1].Pages[2].posy := 2;
              end
              else
              begin
                Editiondata[ied].plates[ipl+1].Pages[2].posX := 2;
                Editiondata[ied].plates[ipl+1].Pages[2].posy := 1;
              end;
            end;
            if (Nup = 4) and (Editiondata[ied].plates[ipl+1].Npages >= 4) then
            begin
               Editiondata[ied].plates[ipl+1].Pages[2].posX := 2;
               Editiondata[ied].plates[ipl+1].Pages[2].posy := 1;
               Editiondata[ied].plates[ipl+1].Pages[3].posX := 1;
               Editiondata[ied].plates[ipl+1].Pages[3].posy := 2;
               Editiondata[ied].plates[ipl+1].Pages[4].posX := 2;
               Editiondata[ied].plates[ipl+1].Pages[4].posy := 2;
            end;
            if (Nup = 8) and (Editiondata[ied].plates[ipl+1].Npages >= 8) then
            begin
              if platetemplatearray[plateframesdata[iplf].prodplates[ipl * ncop].templatelistid].Pagesdown > platetemplatearray[plateframesdata[iplf].prodplates[ipl * ncop].templatelistid].Pagesacross then
              begin
                 Editiondata[ied].plates[ipl+1].Pages[2].posX := 2;
                 Editiondata[ied].plates[ipl+1].Pages[2].posy := 1;
                 Editiondata[ied].plates[ipl+1].Pages[3].posX := 1;
                 Editiondata[ied].plates[ipl+1].Pages[3].posy := 2;
                 Editiondata[ied].plates[ipl+1].Pages[4].posX := 2;
                 Editiondata[ied].plates[ipl+1].Pages[4].posy := 2;
                 Editiondata[ied].plates[ipl+1].Pages[5].posX := 1;
                 Editiondata[ied].plates[ipl+1].Pages[5].posy := 3;
                 Editiondata[ied].plates[ipl+1].Pages[6].posX := 2;
                 Editiondata[ied].plates[ipl+1].Pages[6].posy := 3;
                 Editiondata[ied].plates[ipl+1].Pages[7].posX := 1;
                 Editiondata[ied].plates[ipl+1].Pages[7].posy := 4;
                 Editiondata[ied].plates[ipl+1].Pages[8].posX := 2;
                 Editiondata[ied].plates[ipl+1].Pages[8].posy := 4;
              end
              else
              begin
                 Editiondata[ied].plates[ipl+1].Pages[2].posX := 2;
                 Editiondata[ied].plates[ipl+1].Pages[2].posy := 1;
                 Editiondata[ied].plates[ipl+1].Pages[3].posX := 3;
                 Editiondata[ied].plates[ipl+1].Pages[3].posy := 1;
                 Editiondata[ied].plates[ipl+1].Pages[4].posX := 4;
                 Editiondata[ied].plates[ipl+1].Pages[4].posy := 1;
                 Editiondata[ied].plates[ipl+1].Pages[5].posX := 1;
                 Editiondata[ied].plates[ipl+1].Pages[5].posy := 2;
                 Editiondata[ied].plates[ipl+1].Pages[6].posX := 2;
                 Editiondata[ied].plates[ipl+1].Pages[6].posy := 2;
                 Editiondata[ied].plates[ipl+1].Pages[7].posX := 3;
                 Editiondata[ied].plates[ipl+1].Pages[7].posy := 2;
                 Editiondata[ied].plates[ipl+1].Pages[8].posX := 4;
                 Editiondata[ied].plates[ipl+1].Pages[8].posy := 2;
              end;
            end;
            For i := 1 to platetemplatearray[plateframesdata[iplf].prodplates[ipl * ncop].templatelistid].NupOnplate do
            begin
              Editiondata[ied].plates[ipl+1].Pages[i].pageindex := plateframesdata[iplf].prodplates[ipl * ncop].pages[i].pageindex;
              Editiondata[ied].plates[ipl+1].Pages[i].copyseparationset := plateframesdata[iplf].prodplates[ipl * ncop].pages[i].CopySeparationSet;
              Editiondata[ied].plates[ipl+1].Pages[i].sectionid := plateframesdata[iplf].prodplates[ipl * ncop].pages[i].SectionID;
              Editiondata[ied].plates[ipl+1].Pages[i].pagina := plateframesdata[iplf].prodplates[ipl * ncop].pages[i].Pagina;
              Editiondata[ied].plates[ipl+1].Pages[i].pagename := plateframesdata[iplf].prodplates[ipl * ncop].pages[i].pagename;
              findpagespageids(Editiondata[ied].EditionID,
                             Editiondata[ied].plates[ipl+1].Pages[i].sectionid,
                             Editiondata[ied].plates[ipl+1].Pages[i].pageindex,
                             Editiondata[ied].plates[ipl+1].Pages[i].pageid,
                             Editiondata[ied].plates[ipl+1].Pages[i].masterpageid);

              For ic := 1 to plateframesdata[iplf].prodplates[ipl * ncop].pages[i].Ncolors do
              begin
                if (plateframesdata[iplf].prodplates[ipl * ncop].pages[i].colors[ic].colorid = 6) then
                  continue;
                 Editiondata[ied].plates[ipl+1].miscstring3 := GetPlannameFromID(8,plateframesdata[iplf].prodplates[ipl * ncop].Pages[i].colors[ic].Miscstring3);
                 T := Editiondata[ied].plates[ipl+1].miscstring3;
                 dbl1 := pos(';',T);
                 Delete(T,dbl1,100);
                 Editiondata[ied].plates[ipl+1].miscstring3 := T;
                 Editiondata[ied].plates[ipl+1].Colors[ic].colorid := plateframesdata[iplf].prodplates[ipl * ncop].pages[i].colors[ic].colorid;
                 Editiondata[ied].plates[ipl+1].Colors[ic].cylinder := GetPlannameFromID(4,plateframesdata[iplf].prodplates[ipl * ncop].pages[i].colors[ic].Cylinder);
                 dbl1 := pos(';',Editiondata[ied].plates[ipl+1].Colors[ic].cylinder);
              //   Delete(Editiondata[ied].plates[ipl+1].PressZone,dbl1,100);
                 Delete(Editiondata[ied].plates[ipl+1].Colors[ic].cylinder,dbl1,100);
                 Editiondata[ied].plates[ipl+1].Colors[ic].Ncopies := Editiondata[ied].Numberofcopies;
                For icpy := 1 to Editiondata[ied].plates[ipl+1].Colors[ic].Ncopies do
                begin
                  Editiondata[ied].plates[ipl+1].Colors[ic].Copies[icpy].SortingPosition :=
                         GetPlannameFromID(2,plateframesdata[iplf].prodplates[ipl * ncop].pages[i].colors[ic].stackpos);
                  Editiondata[ied].plates[ipl+1].Colors[ic].Copies[icpy].miscstring3 :=  GetPlannameFromID(8,plateframesdata[iplf].prodplates[ipl * ncop].pages[i].colors[ic].Miscstring3);

                  Editiondata[ied].plates[ipl+1].Colors[ic].Copies[icpy].miscstring2 :=  GetPlannameFromID(2,plateframesdata[iplf].prodplates[ipl * ncop].pages[i].colors[ic].Miscstring3);
                  T := Editiondata[ied].plates[ipl+1].Colors[ic].Copies[icpy].miscstring3;
                  dbl1 := pos(';',T);
                  IF dbl1 > 0 then
                  begin
                    Delete(T,dbl1,100);
                    Editiondata[ied].plates[ipl+1].Colors[ic].Copies[icpy].miscstring3 := T;
                  End;


                  if (Prefs.CustomBuildName = 'STB')  then
                    tt:=   GetHighLowSTB(plateframesdata[iplf].prodplates[ipl * ncop].pages[i].colors[ic].High)
                    else
                    tt := GetPlannameFromID(3,plateframesdata[iplf].prodplates[ipl * ncop].pages[i].colors[ic].High);
                  Editiondata[ied].plates[ipl+1].Colors[ic].Copies[icpy].High := tt;
                  Editiondata[ied].plates[ipl+1].PressHighLow := tt;
                end;
              end;
            end;
          End;
        End;
      //End;
    End;
    result := true;
    NEditiondata := nedi;

  finally
  End;
end;


function TDataModuleXML.GenerateStandardPlanPageName(PublicationAlias: string; Pubdate: TDateTime; Editionid: Integer; Sectionid: Integer; pageName: string): string;
begin


    if (StrToInt(pageName) > 0) then
       pageName := RightStr('00' +  pageName, 3);

     result := PublicationAlias + '-' +
              FormaTDateTime('DDMMYY', Pubdate) + '-' +
              tNames1.editionIDtoname(editionid) + '-' +
              tNames1.sectionidtoname(Sectionid) + '-' +
              pageName;

end;
end.
