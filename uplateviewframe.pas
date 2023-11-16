unit UPlateviewframe;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.ImgList, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, System.ImageList, Utypes,  PBExListview;
type
  TFPV = class(TFrame)
    GPV: TGroupBox;
    IPV: TImageList;
    ImageMinmax: TImage;
    panelminmax: TPanel;
    ImageMin: TImage;
    ImageMax: TImage;
    PanelSelall: TPanel;
    Image1: TImage;
    LPV: TPBExListview;
    procedure LPVClick(Sender: TObject);
    procedure LPVMouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y: Integer);
    procedure ImageMinmaxClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure LPVDblClick(Sender: TObject);
    procedure LPVKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LPVMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    PlateviewImage : tbitmap;
    selfnumber : Integer;
    pressrunid : Integer;
    AnyFlatpagetabledata : Boolean;
    presssectionnumber : Integer;
    Locationid : Integer;
    pressid    : Integer;
    Selpubdate    : Tdatetime;
    Secselection : Integer;
    Seledition : Integer;
    Nplates : Integer;
    platesData  : Tshowplates;
    Maxheight   : Integer;
    scrollheight : Integer;
    firstrowtop : Integer;
    firstrowBottom : Integer;
    prevtop : Integer;
    Ordernumber : String;
    baroffset : Integer;
    Mouseoverpage : Integer;
    AnySeledition : Integer;
    Anysecselection : Integer;
    Anyplatecalc : Integer;
    Anyplatesecset : Integer;
    megaplatevidth : Integer;
    megaplateheight : Integer;
    megaplaterect : Trect;
    megapagevidth : Integer;
    megapageheight : Integer;
    InkComment : String;
    PressRunName : String;
    flatVStatesets : string;
    Firsttemplateid : Integer;
    ndiftmpls : Integer;
    diftmpls : array[1..100] of Integer;
    procedure getdiftmpls;
    Procedure Getmegasize(pressrunid : Integer);
    Procedure setSinglepage;
    Procedure setcenterspread;
    function Updateplateviewdata:Integer;
    Function loadAPlateFromdata(copyflatseparationset : Integer;
                                Var Aktshowplate : Tshowplate):Boolean;
    Function LoadAPlate(copyflatseparationset : Integer;
                        Var Aktshowplate : Tshowplate):Boolean;
    Function makeAplateCaption(platesDataIP : Integer):String;
    Procedure deselectothers(selected : Integer);
    procedure makeplateinfo(Plate : Tshowplate);
    Procedure getorgeds;
    procedure loadplateviewdata(Keepviews : Boolean);
    Function makeplateviewimageDeluxe(showthumbnails     : boolean;
                                       small              : boolean;
                                       showinkpreview     : boolean;
                                       platenumber        : Integer;
                                       PreviewGUID : String):Integer;//0 error 1 ok 2 ok dontproduce
    Function makeplateviewimage(showthumbnails     : boolean;
                                small              : boolean;
                                showinkpreview     : boolean;
                                platenumber        : Integer;
                                PreviewGUID : String):Integer;//0 error 1 ok 2 ok dontproduce
    Function makeImagesize(PageRotation : TPageNumbering;
                           Inputorientation : Integer;
                           phorz : Integer;
                           pvert : Integer;
                           Var platewidth : Integer;
                           Var plateheight : Integer;
                           Var pagewidth   : Integer;
                           Var pageheight  : Integer):trect;
    function GetTriangleImageNumber(PlateColor : Integer; Rotation : Integer) : Integer;
    { Public declarations }
  end;
  Procedure CheckAllruns;
  function Updateviews:boolean;
  function AnyplateInPressrunid(pressrunid : Integer;
                              Seledition : Integer;
                              secselection : Integer):Integer; //-1,0 der er ingen ellers antal plates
  procedure loadplateviewRuns(Pressrunselstr : string;
                              nselected : Integer;
                              Pressrunid : Integer;
                              pressname : String;
                              SelPublicationid : Integer;
                              Selpubdate       : tdatetime;
                              Secselection : Integer;
                              Seledition : Integer;
                              KeepViews  : Boolean);
Var
  Specialplatestanding : Boolean;
  towerfilter : String;
  PlateviewAutorefreshing : boolean;
  PlateviewProductionid : Integer;
  //Platevieweditionmotherid : Integer;
  Nviews : Integer;
  Views  : array[0..512] of TFPV;
  VisibleView : Integer;
  VisibleViewNeg : Boolean;
  AnyPlatesselected : Boolean;
  Viewselected : Integer;
  flatStatesets : string;
  PlatefilterType : Integer;  // 0 all, 1 missing, 2 ready, 3 hide empty
  PlatesortType  : Integer;  // 0 Sheet, 1 Side, 2 Tower
  NAllruns : Integer;
  Allruns : Array[0..512] of record
                               pressrunid : Integer;
                               Isvisible : Boolean;
                             end;
implementation
uses Umain, Usettings, Udata, UPrev2, UPrevPlate2,Uflatproof, UTowerfilter, UImages, UUtils;
{$R *.dfm}

Procedure TFPV.getdiftmpls;
Var
  IPL,I : Integer;
  found : Boolean;
Begin
  ndiftmpls := 0;
  for IPL := 0 to Nplates do
  begin
    if (platesData[IPL].templatelistid > 0) and (platesData[IPL].templatelistid < 200) then
    begin
      found := false;
      for i := 1 to ndiftmpls do
      begin
        if diftmpls[i] = platesData[IPL].templatelistid then
        begin
          found := true;
          break;
        end;
      end;
      if not found then
      begin
        Inc(ndiftmpls);
        diftmpls[ndiftmpls] := platesData[IPL].templatelistid;
      end;
    end;
  end;
end;

Procedure TFPV.getorgeds;
Var
  IPL,IP
  //,IC
   : Integer;
Begin
  if Nplates > -1 then
  begin
    DataM1.Query2.sql.clear;
    DataM1.Query2.sql.add('select distinct p1.pagename,p1.mastercopyseparationset,p1.editionid,p2.editionid,p2.mastercopyseparationset,p2.copyseparationset from pagetable p1 (NOLOCK), pagetable p2 (NOLOCK)');
    DataM1.Query2.sql.add('where p1.uniquepage <> 1 and p2.uniquepage = 1 and p1.mastercopyseparationset = p2.mastercopyseparationset');
    DataM1.Query2.sql.add('and p1.pressid = ' + inttostr( pressid));
    DataM1.Query2.sql.add('and p1.pressrunid = ' + inttostr(pressrunid));
    DataM1.Query2.sql.add('and p1.locationid = '+inttostr(locationid));
    DataM1.Query2.sql.add('and p1.dirty = 0 and p2.dirty = 0 ');
    formmain.tryopen(datam1.Query2);
    while not DataM1.Query2.eof do
    begin
      for IPL := 0 to Nplates do
      begin
        if (platesData[IPL].templatelistid > 0) and (platesData[IPL].templatelistid < 200) then
        begin
          for ip := 1 to platetemplatearray[platesData[IPL].templatelistid].NupOnplate do
          begin
            if platesData[IPL].Pages[ip].UniquePage <> 1 then
            begin
              if platesData[IPL].Pages[ip].MasterCopySeparationSet = DataM1.Query2.Fields[1].asinteger then
              begin
                platesData[IPL].Pages[ip].OrgeditionID := DataM1.Query2.Fields[3].asinteger;
                platesData[IPL].Pages[ip].OrgCopySeparationSet := DataM1.Query2.Fields[5].asinteger;
              end;
            end;
          end;
        end;
      end;
      DataM1.Query2.next;
    end;
    DataM1.Query2.Close;
  end;
end;

Function TFPV.makeImagesize(PageRotation : TPageNumbering;
                            Inputorientation : Integer;
                            phorz : Integer;
                            pvert : Integer;
                            Var platewidth : Integer;
                            Var plateheight : Integer;
                            Var pagewidth   : Integer;
                            Var pageheight  : Integer):trect;
Var
//  w,h : Integer;
  VImposmw,VImpospw : Integer;
  VImposmh,VImposph : Integer;
  Standing : boolean;
  Sphorz : Integer;
  Spvert : Integer;
  f : Double;
Begin
  try
    Standing := true;
    if ((PageRotation[1]) mod 2 = 0) then
    begin
      //siderne skal st� op
      if Inputorientation mod 2 = 0 then
      begin
        Standing := true;
      End
      Else
      begin
        Standing := false;
      end;
    End
    else
    begin
      if Inputorientation mod 2 = 0 then
      begin
        Standing := false;
      End
      Else
      begin
        Standing := true;
      end;
    end;
    Specialplatestanding := false;
    if (not standing and Prefs.PlatesShowPagesStanding)  then
    begin
      Standing := true;
      Specialplatestanding := true;
      Sphorz := phorz;
      Spvert := pvert;
      phorz := Spvert;
      pvert := Sphorz;
    end;
    if standing then
    begin
      Impospw := (Impospw100 * Pressviewzoom) div 100;
      Imposph := (Imposph100 * Pressviewzoom) div 100;
      Imposmw := (Imposmw100 * Pressviewzoom) div 100;
      Imposmh := (Imposmh100 * Pressviewzoom) div 100;
    end
    else
    begin
      Imposph := (Impospw100 * Pressviewzoom) div 100;
      Impospw := (Imposph100 * Pressviewzoom) div 100;
      Imposmh := (Imposmw100 * Pressviewzoom) div 100;
      Imposmw := (Imposmh100 * Pressviewzoom) div 100;
    end;
    VImposmw := Imposmw;
    VImpospw := Impospw;
    VImposmh := Imposmh;
    VImposph := Imposph;
    platewidth := (phorz * VImpospw) + ((phorz+1)* VImposmw);
    plateheight := (pvert * VImposph) + ((pvert+1)* VImposmh);
    if ( phorz = 3) AND (pvert = 1) then
    begin
       f := 1.25 * platewidth;
       platewidth := Round(f);
       f := 1.50 * plateheight;
       plateheight := Round(f);
    end;
    //plateheight := plateheight + 20;
    if (not Prefs.HidePlateCopyBar) then
    Begin
      plateheight := plateheight + 44;
    end;
    if (formmain.ActionplateThumbnails.Checked) And (Prefs.UsePlateviewThumbnails) then
    Begin
      plateheight := plateheight + baroffset;
    end;
    result := rect(0,0,platewidth,plateheight);
  except
  end;
end;

Procedure CheckAllruns;
Var
  iview,iallv : Integer;
Begin
  if Nallruns > 0 then
  begin
    For iallv := 0 to Nallruns-1 do
    begin
      For iview := 0 to Nviews-1 do
      begin
        if Allruns[iallv].pressrunid = Views[iview].pressrunid then
        begin
          Allruns[iallv].Isvisible := true;
          break;
        end;
      end;
    end;
  end;
end;
//SJO 130715 Function til at sortere en stringlist
//Sorting metode 1,2,3,4,5,7,8,9,10 = 1-5,6-10
//Sorting metode 1,2,3,4,8,9,10     = 1-4,8-10
function StringsToPages(st: TStringList; isSorted: Boolean = false): string;
var
  i, t, n, l, err  : Integer;
  init             : Boolean;
begin
  Result := '';
  if Not Assigned(st) or (st.Count=0) then Exit;
  if Not isSorted then st.Sort;

  init := false;
  n := 0;
  l := 0;

  For i := 0 to st.Count - 1 do
  Begin
    Val(st[i], t, err);
    if err <> 0 then Continue;

    if Not init Or (t>l+1) then
    Begin
      if not init then init := true
      else
      begin
        if n = l then Result := Result + ',' + IntToStr(n)
                 else Result := Result + ',' + IntToStr(n) + '-' + IntToStr(l);
      end;
      n := t;
      l := t;
    end else if t = l + 1 then
      l := t
  end;
  if n = l then
    Result := Result + ',' + IntToStr(n)
  else
    Result := Result + ',' + IntToStr(n) + '-' + IntToStr(l);
  Result := Copy(Result, 2, length(Result) - 1);
end;

procedure loadplateviewRuns(Pressrunselstr : string;
                            nselected : Integer;
                            Pressrunid : Integer;
                            pressname : String;
                            SelPublicationid : Integer;
                            Selpubdate       : tdatetime;
                            Secselection : Integer;
                            Seledition : Integer;
                            KeepViews  : Boolean);

Var
//  T,
  cap : string;
//  Icap : Integer;
//  Captext : string;
  I,
  //i2,Y,
  i3 : Integer;
  pt: TPoint;
  aktedition : Integer;
  NSectioncaps, LocationID
  //,iview
   : Integer;
  Sectioncaps : Array[1..100] of string;
  Anyplateresult,Iviews : Integer;
  nPressRunID : Integer;
  PressSectionNumber :Integer;
//  PressRunName,
  TmpString    : String;
  PageInRun    : TStringList;
  SekInRun     : TStringList;
  int
  //, p
         : Integer;
begin
  try
   // KeepViews := false;  // her kan jeg muligvis lave en slags check mennnnn
    AnyPlatesselected := false;
    formmain.PBExListviewplateinfo.Items.Clear;
    writeMainlogfile('loadplateviewRuns start');
    NAllruns := 0;
    if (not keepviews) then
    begin
      if Nviews > 0 then
      begin
        For i := 0 to Nviews-1 do
        begin
          Views[i].Free;
        end;
        Nviews := 0;
      end;
    end;
    therearenoplates := false;
    if formmain.ComboBoxpalocationNY.Enabled then
      LocationID := tnames1.locationnametoid(formmain.ComboBoxpalocationNY.Text)
    else
      LocationID := -1;
    if Not therearenoplates then
    begin
      writeMainlogfile('loadplateviewRuns 1');
      DataM1.Query1.sql.clear;
      DataM1.Query1.sql.add('Select Distinct p1.PressSectionNumber,p1.pressrunid,p1.editionid,e1.name from pagetable p1 (NOLOCK), editionnames e1 (NOLOCK)');
      DataM1.Query1.sql.add('where p1.pressid = ' + inttostr(tnames1.pressnametoid(pressname)));
      DataM1.Query1.sql.add('and p1.pressrunid IN ' + Pressrunselstr);
      if (LocationID > 0) then
        DataM1.Query1.sql.add('and p1.locationid = '+IntToStr(LocationID));
      DataM1.Query1.sql.add('and p1.editionid = e1.editionid');
      DataM1.Query1.sql.add('and p1.dirty = 0 ');
      if (Prefs.TreeOrder = 0) then
        DataM1.Query1.sql.add('Order by p1.PressSectionNumber,e1.name,p1.pressrunid')
      else
        DataM1.Query1.sql.add('Order by e1.name,p1.PressSectionNumber,p1.pressrunid');
      if Prefs.debug then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'loadplateviewRuns2.sql');
      writeMainlogfile('loadplateviewRuns 2');
      DataM1.Query1.open;
      writeMainlogfile('loadplateviewRuns2.sql is open');
      Iviews := 0;
      if (Prefs.debug) and (DataM1.Query1.eof) then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'loadplateviewRuns2Empty.sql');
      While not DataM1.Query1.eof do
      begin
        Inc(Nallruns);
        PressSectionNumber := DataM1.Query1.fields[0].asinteger;
        nPressRunID :=  DataM1.Query1.fields[1].asinteger;
        Allruns[Nallruns-1].pressrunid := nPressRunID;
        Allruns[Nallruns-1].Isvisible := false;

        writeMainlogfile('loadplateviewRuns2.sql next');
        Anyplateresult := AnyplateInPressrunid(nPressRunID, Seledition, secselection);
        writeMainlogfile('loadplateviewRuns Anyplateresult ' + inttostr(Anyplateresult));
        if Anyplateresult > 0 then
        begin
          writeMainlogfile('Anyplateresult > 0');
          Inc(Iviews);
          if not keepviews then
          Begin
            writeMainlogfile('not keepviews');
            writeMainlogfile('loadplateviewRuns nviewnumber ' + inttostr(Nviews));
            Views[Iviews-1] := TFPV.Create(formmain.PlateviewMain);
            Views[Iviews-1].Name := 'PLView' + inttostr(Iviews);
            Views[Iviews-1].Parent := formmain.PlateviewMain;
            //SJO 130715 - indsat for at lave gul baggrund i groupbox
            Views[Iviews-1].ParentBackground := False;
            Views[Iviews-1].Color := clSkyblue;
            Views[Iviews-1].LPV.DoubleBuffered := true;
            Views[Iviews-1].LPV.multiselect := true;
            Views[Iviews-1].LPV.readonly := true;
            Views[Iviews-1].LPV.hideselection := false;
         //   Views[Iviews-1].LPV.popupmenu := formmain.PopupActionBarEx1plateview;
            Views[Iviews-1].Align := alnone;
            if Iviews-1 = 0 then
              Views[Iviews-1].Top := 0
            else
              Views[Iviews-1].Top := Views[Iviews-2].Top + Views[Iviews-2].Height + 10;
            Views[Iviews-1].GPV.caption := 'dsdsds'+inttostr(PressSectionNumber);
            Views[Iviews-1].Align := altop;
            Views[Iviews-1].Height := 8000;
            Views[Iviews-1].panelminmax.left := Views[Iviews-1].Width -17;
            Views[Iviews-1].panelminmax.top  := 0;
            Views[Iviews-1].PanelSelall.left := Views[Iviews-1].panelminmax.left -19;
            Views[Iviews-1].PanelSelall.top  := 0;
          end;
          Views[Iviews-1].pressrunid := nPressRunID;
          Views[Iviews-1].presssectionnumber := PressSectionNumber;
          Views[Iviews-1].Locationid := tnames1.locationnametoid(formmain.ComboBoxpalocationNY.text);
          Views[Iviews-1].pressid    := tnames1.pressnametoid(pressname);
          Views[Iviews-1].Selpubdate    := selpubdate;
          Views[Iviews-1].Secselection    := Secselection;
          Views[Iviews-1].Seledition      := Seledition;
          Views[Iviews-1].prevtop := Views[Iviews-1].top;
          Views[Iviews-1].Anyplatecalc := Anyplateresult;
          Views[Iviews-1].AnySeledition := Seledition;
          Views[Iviews-1].Anysecselection := Secselection;

          Views[Iviews-1].flatVStatesets := flatStatesets;
          // Start load start load start load Start load start load start load Start load start load start load
          Views[Iviews-1].loadplateviewdata(Keepviews);
          // end load end load end load end load end load end load end load end load end load

          Views[Iviews-1].selfnumber := Iviews-1;
          Views[Iviews-1].Height := Views[Iviews-1].Maxheight;
          writeMainlogfile('loadplateviewRuns Views[Iviews-1].LPV.Items.count = ' + inttostr(Views[Iviews-1].LPV.Items.count));
          if Views[Iviews-1].LPV.Items.count > 0 then
          begin
            pt := Views[Iviews-1].LPV.Items[0].Position;
            for i := 0 to Views[Iviews-1].lpv.items.count-1 do
            begin
              pt := Views[Iviews-1].LPV.Items[I].Position;
            end;
          end;
        end;
        DataM1.Query1.next;
      end;
      DataM1.Query1.close;
      writeMainlogfile('loadplateviewRuns Iviews done');
      Nviews := Iviews;
      if nviews > 0 then
      Begin
        formmain.PlateviewMain.VertScrollBar.Increment := views[0].scrollheight;
        writeMainlogfile('nviews = ' + inttostr(nviews));
      end;
      for i := 0 to Nviews-1 do
      begin
        DataM1.Query1.sql.clear;
        //SJO 130715 - Tilf�jet RunName
        DataM1.Query1.sql.add('Select distinct min(pageindex) as maxp, max(pageindex) as minp, editionid, sectionid from pagetable (NOLOCK)');
        DataM1.Query1.sql.add('where pressid = ' + inttostr(tnames1.pressnametoid(pressname)));
        DataM1.Query1.sql.add('and presssectionnumber = ' + inttostr(Views[I].presssectionnumber));
        DataM1.Query1.sql.add('and pressrunid = ' + inttostr(Views[I].pressrunid));
        DataM1.Query1.sql.add('and dirty = 0 and pagetype<3');
        DataM1.Query1.sql.add('group by editionid,sectionid');
        DataM1.Query1.sql.add('order by editionid,sectionid');
        if (Prefs.debug) then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'Getnsec.sql');
        DataM1.Query1.open;
        writeMainlogfile('Getnsec.sql is open ');
        aktedition := -1;
        cap := '';
        NSectioncaps := 0;
        while not DataM1.Query1.eof do
        begin
          aktedition := DataM1.Query1.fields[2].AsInteger;
          inc(NSectioncaps);
          Sectioncaps[NSectioncaps] := tnames1.sectionIDtoname(DataM1.Query1.fields[3].AsInteger) + '(' +DataM1.Query1.fields[0].Asstring+'-'+DataM1.Query1.fields[1].Asstring+')';
          DataM1.Query1.next;
        end;
        DataM1.Query1.Close;
        writeMainlogfile('loadplateviewRuns NSectioncaps ' + IntToStr(NSectioncaps));
        DataM1.Query1.sql.clear;
        DataM1.Query1.sql.add('Select top 1 ISNULL(ordernumber,''''), ISNULL(Comment,''''),ISNULL(InkComment,'''') from pressrunid (NOLOCK)');
        DataM1.Query1.sql.add('where pressrunid = ' + IntToStr(Views[I].pressrunid));
        DataM1.Query1.open;
        Views[i].Ordernumber := '';
        if not DataM1.Query1.eof then
        Begin
          Views[i].Ordernumber := DataM1.Query1.fields[0].AsString;
          //SJO 130715 - Variable tilf�jet til pressrunname
          Views[i].PressRunName         := DataM1.Query1.fields[1].AsString;
          Views[i].InkComment := DataM1.Query1.fields[2].AsString;
        end;
        DataM1.Query1.Close;

        Views[i].GPV.caption := '';
        Views[i].getdiftmpls;
        //SJO 130715 - tilf�jet runs i adv settings "runs" itemindex=6
        if (Prefs.PressRunTexts[6].Enabled) OR (Prefs.PressRunTexts[4].Enabled) then
        Begin
          PageInRun            := TStringList.Create;
//          PageInRun.Duplicates := dupIgnore;
//          PageInRun.Sorted     := True;
          SekInRun             := TStringList.Create;
//          SekInRun.Duplicates  := dupIgnore;
//          SekInRun.Sorted      := True;

          TmpString := '';
          DataM1.Query1.sql.clear;
          DataM1.Query1.sql.add('Select Distinct SectionID from PageTable (NOLOCK)');
          DataM1.Query1.sql.add('where pressrunid = ' + inttostr(Views[I].pressrunid));
          DataM1.Query1.sql.add('And Dirty = 0 And PageType < 3');
          DataM1.Query1.open;
          While not DataM1.Query1.eof do
          begin
            SekInRun.Append(DataM1.Query1.FieldByName('SectionID').AsString);
            DataM1.Query1.next;
          end;
          For int := 0 to SekInRun.Count -1 do
          Begin
            DataM1.Query1.sql.clear;
            DataM1.Query1.sql.add('Select Distinct PageName, PageIndex from PageTable (NOLOCK)');
            DataM1.Query1.sql.add('where pressrunid = ' + inttostr(Views[I].pressrunid));
            DataM1.Query1.sql.add('And SectionID = ' + SekInRun.Strings[int]);
            DataM1.Query1.sql.add('And Dirty = 0 And PageType < 3');
            DataM1.Query1.sql.add('Order by PageIndex');
            DataM1.Query1.open;
            PageInRun.Clear;
            While not DataM1.Query1.eof do
            begin
              PageInRun.Append(DataM1.Query1.FieldByName('PageName').AsString);
              DataM1.Query1.next;
            end;
            TmpString := TmpString + tnames1.sectionIDtoname(StrToInt(SekInRun.Strings[int])) + '(' + StringsToPages(PageInRun, True) + ')     ';
          end;
          if (Prefs.PressRunTexts[6].Enabled) then
             Views[i].GPV.caption := Views[i].GPV.caption + 'Run: ' + IntToStr(i + 1) + '/' + IntToStr(Nviews) + '      ' + Views[i].PressRunName;
          PageInRun.Free;
          SekInRun.Free;
        end;

        if (Prefs.PressRunTexts[0].Enabled) then
          Views[i].GPV.caption := Views[i].GPV.caption + 'Press: '+ pressname;
        if (Prefs.PressRunTexts[1].Enabled) then
          Views[i].GPV.caption := Views[i].GPV.caption + ' Date: '+ datetostr(Selpubdate);
        if Prefs.PressRunTexts[2].Enabled then
          Views[i].GPV.caption := Views[i].GPV.caption + ' Publ: '+ tnames1.publicationIDtoname(SelPublicationid);
        // Edition in caption
        if (Prefs.PressRunTexts[3].Enabled) then
          Views[i].GPV.caption := Views[i].GPV.caption + ' Ed: '+ tnames1.editionIDtoname(aktedition);
        if (Prefs.PressRunTexts[4].Enabled) then
          Views[i].GPV.caption := Views[i].GPV.caption +  '     Page:' + TmpString;
        if (Prefs.PressRunTexts[5].Enabled) then
        Begin
          for i3 := 1 to Views[i].ndiftmpls do
          begin
            Views[i].GPV.caption := Views[i].GPV.caption + '   '+  PlatetemplateArray[Views[i].diftmpls[i3]].Outputalias;
          end;
        end;

        if (prefs.PlatesShowTemplateInCaption) then
          Views[i].GPV.caption := Views[i].GPV.caption + '    '+  PlatetemplateArray[Views[i].platesData[0].Templatelistid].TemplateName;
        if (Prefs.PlateviewOrderInCaption) then
          Views[i].GPV.caption := Views[i].GPV.caption + '  '+ Views[i].Ordernumber;
        if (Prefs.PressRunTexts[7].Enabled) then
            Views[i].GPV.caption := Views[i].GPV.caption + '   '+ Views[i].InkComment;

      end;
    end;
    VisibleView := 0;
    VisibleViewNeg := views[0].Top < 0;

    CheckAllruns;
    writeMainlogfile('loadplateviewRuns End');
  except
    writeMainlogfile('loadplateviewRuns exception');
  end;
end;

procedure TFPV.LPVClick(Sender: TObject);
Var
  I : Integer;
  found : Integer;
Begin
  if LPV.Selected = nil then exit;
  deselectothers(self.selfnumber);
  formmain.StatusBar1.Panels[4].Text := '';
  found := -1;
  For i := 0 to Nplates - 1 do
  begin
    if platesData[i].Imageindex = LPV.Selected.ImageIndex then
    begin
      found := i;
      break;
    end;
  end;
  if found > -1 then
    makeplateinfo(platesData[found]);
  formmain.StatusBar1.Panels[4].Text := inttostr(LPV.SelCount);
  AnyPlatesselected := LPV.SelCount > 0;
  Viewselected := self.selfnumber;
  formmain.ActionEnable('LPVClick');
  formprev2.Clearprev2;
  if formprev2.showing and Prefs.AllowParalelView then
    LPVDblClick(self);
end;

procedure TFPV.makeplateinfo(Plate : Tshowplate);
Var
//  aktflatseparationset,CPhold,Cpstat,cpact : Integer;
  devgrpname,devname : String;
//  IP,IC,
  ICPY,
  //,Icpl,icpstat : Integer;
  platestatus : Integer;
  l : tlistitem;
//  I : Integer;
//  Found : Boolean;
  tmplnum : Integer;
//  icx,Niplcol,icps : Integer;
{  IPLCol : Array[1..200] of record
                              Colorid : Integer;
                              Hold : Integer;
                            end;}
  aktflatseparation : int64;
begin
  formmain.PBExListviewplateinfo.Items.BeginUpdate;
  formmain.PBExListviewplateinfo.Items.Clear;
  aktflatseparation := -1;

  DataM1.Query1.sql.clear;

  DataM1.Query1.sql.add('select flatseparation,colorid,deviceid,');
  DataM1.Query1.sql.add('MIN(status) as status, MIN(CASE WHEN approved=-1 or approved=1 THEN 1 ELSE 0 END) as approved ,MAX(hold) as hold,');
  DataM1.Query1.sql.add('active,PressTower,PressZone,PressCylinder,PressHighLow,SortingPosition,pagename,copynumber,TemplateID,outputversion,outputtime');
  if (DeviceGroupNamesPossible) then
    DataM1.Query1.sql.add(',DeviceGroupID');
  DataM1.Query1.sql.add('from pagetable (NOLOCK) where copyflatseparationset = ' + IntToStr(Plate.CopyFlatSeparationSet));
  DataM1.Query1.sql.add('and active = 1 and dirty = 0 and PageType < 2 ');
  DataM1.Query1.sql.add('group by copynumber,colorid,pagename,flatseparation,deviceid,active,PressTower,PressZone,PressCylinder,PressHighLow,SortingPosition,pagename,copynumber,TemplateID,outputversion,outputtime');
  if (DeviceGroupNamesPossible) then
    DataM1.Query1.sql.add(',DeviceGroupID');
  DataM1.Query1.sql.add('order by copynumber,colorid,pagename');
  DataM1.Query1.open;
  While not DataM1.Query1.eof do
  begin
    ICPY := DataM1.Query1.FieldByName('copynumber').asinteger;
    if aktflatseparation <> DataM1.Query1.FieldByName('flatseparation').AsVariant then
    begin
      aktflatseparation := DataM1.Query1.FieldByName('flatseparation').AsVariant;
      l := formmain.PBExListviewplateinfo.Items.add;
      l.Caption := DataM1.Query1.FieldByName('pagename').asstring;
      l.SubItems.add(Inttostr(ICPY));
      l.SubItems.add(Colorsnames[DataM1.Query1.FieldByName('colorid').asinteger].name);
      tmplnum := inittypes.gettemplatelistnumberfromdbID(DataM1.Query1.FieldByName('TemplateID').AsInteger);
      l.SubItems.add(PlatetemplateArray[tmplnum].TemplateName);
      if DeviceGroupNamesPossible then
      begin
        if DataM1.Query1.FieldByName('DeviceGroupID').AsInteger > 0 then
        begin
          devgrpname := inittypes.DeviceGroupIDtoName(DataM1.Query1.FieldByName('DeviceGroupID').AsInteger);
        end
        Else
          devgrpname := ' - ';
        if DataM1.Query1.FieldByName('deviceid').asinteger > 0 then
          devname := tnames1.deviceIDtoname(DataM1.Query1.FieldByName('deviceid').AsInteger)
        else
          devname := ' - ';
        l.SubItems.add(devgrpname + ' / ' + devname);
      end
      else
        l.SubItems.add(tnames1.deviceIDtoname(DataM1.Query1.FieldByName('deviceid').AsInteger));
      l.SubItems.add(statusarray[DataM1.Query1.FieldByName('status').asinteger].name);
      l.SubItems.add(apprnamearray[DataM1.Query1.FieldByName('approved').asinteger+1]);
      l.SubItems.add(Holdrealesarray[DataM1.Query1.FieldByName('hold').asinteger]); // 6
      l.SubItems.add(Yesnoarray[DataM1.Query1.FieldByName('active').asinteger]);
      l.SubItems.add(DataM1.Query1.FieldByName('PressTower').asstring);
      l.SubItems.add(DataM1.Query1.FieldByName('PressZone').asstring);
      l.SubItems.add(DataM1.Query1.FieldByName('PressCylinder').asstring);
      l.SubItems.add(DataM1.Query1.FieldByName('PressHighLow').asstring);
      l.SubItems.add(DataM1.Query1.FieldByName('SortingPosition').asstring);
      l.SubItems.add(inittypes.marksnamestr(plate.Nmarkgroups,plate.markgroups));
      l.SubItems.add(tnames1.pressnameIDtoname(plate.pressid));
      l.SubItems.add(inttostr(plate.runid));
      l.SubItems.add(inttostr(plate.CopyFlatSeparationSet));
      l.SubItems.add(Inttostr(platestatus));
      l.SubItems.add(DataM1.Query1.FieldByName('outputversion').Asstring);
      l.SubItems.add(DataM1.Query1.FieldByName('outputtime').Asstring);
      PBExListviewplateinfoflatsepsubitem := 20;  //denne kan �ndres hvis der skal flere subitems ind
      l.SubItems.add(Inttostr(DataM1.Query1.FieldByName('flatseparation').AsVariant));
    End
    else
      l.Caption := l.Caption + ',' +DataM1.Query1.FieldByName('pagename').AsString;
    DataM1.Query1.next;
  end;

  DataM1.Query1.close;
  formmain.PBExListviewplateinfo.Items.EndUpdate;
end;
Procedure TFPV.deselectothers(selected : Integer);
Var
  I,it : Integer;
Begin
  For i := 0 to nviews-1 do
  begin
    if i <> selected then
    begin
      views[i].LPV.selected := nil;
      for it := 0 to views[i].LPV.Items.Count-1 do
      begin
        views[i].LPV.Items[it].Selected := false;
      end;
    end;
  end;
end;

procedure TFPV.LPVMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i, iFirst, iLast: Integer;
  Found : Boolean;
begin
iFirst := 0;
iLast := 0;
  plateviewmousecoord.x := x;
  plateviewmousecoord.y := y;
  plateviewmouseButton := Button;
  plateviewmouseShift := Shift;
  plateviewmouseScreencoord.Y   := mouse.CursorPos.Y;
  plateviewmouseScreencoord.x   := mouse.CursorPos.x;
  AnyPlatesselected := LPV.SelCount > 0;
  Viewselected := self.selfnumber;
  formmain.ActionEnable('LPVMouseDown');
  if (AnyPlatesselected) and (Button = mbRight) and (not formmain.TimerPlateviewPopup.Enabled) then
  Begin
    formmain.TimerPlateviewPopup.Enabled := true;
  end;

  if ssShift in Shift then
  begin
    Found := false;
    for i := 0 to Views[Viewselected].LPV.Items.Count - 1 do
      if Views[Viewselected].LPV.Items[i].Selected then
      begin
        if not Found then
        begin
          iFirst := i;
          Found := true;
        end;
        iLast := i;
      end;

    for i := 0 to Views[Viewselected].LPV.Items.Count - 1 do
      if (i >= ifirst) And (i<= iLast) then
        Views[Viewselected].LPV.Items[i].Selected := true;
  end;

end;

procedure TFPV.ImageMinmaxClick(Sender: TObject);
begin
  if Views[selfnumber].Height <= 24 then
  Begin
    Views[selfnumber].Height := Views[selfnumber].Maxheight;
    Views[selfnumber].ImageMinmax.Picture := Views[selfnumber].ImageMin.Picture;
  end
  else
  begin
    Views[selfnumber].Height := 24;
    Views[selfnumber].ImageMinmax.Picture := Views[selfnumber].ImageMax.Picture;
  end;
  Views[selfnumber].ImageMinmax.Refresh;
end;

procedure TFPV.Image1Click(Sender: TObject);
Var
  I : Integer;
begin
  For i := 0 to Views[selfnumber].LPV.Items.Count-1 do
  begin
    Views[selfnumber].LPV.Items[i].Selected := true;
  end;
  Views[selfnumber].LPV.SetFocus;
end;

procedure TFPV.LPVDblClick(Sender: TObject);
Var
  plateresult,
  //imindx,
  ip,ipl,ic,thiscolorid, thisapproved,FlatSeparationSet,MasterCopySeparationSet : Integer;
  Afilename, thispagename : string;
  PreviewGUID : string;
begin
  if not AnyPlatesselected then exit;
  if Views[Viewselected].LPV.Selected = nil then exit;
  try
    if ((formmain.ActionplateThumbnails.Checked) And (Not Prefs.UsePlateviewThumbnails)) OR (Prefs.PlatesAllowSinglePagePreview) then
    Begin
      if (Mouseoverpage > -1) then
      begin
        if Views[Viewselected].platesData[Views[Viewselected].LPV.Selected.ImageIndex].Pages[Mouseoverpage].proofed then
        begin
          Formprev2.prevmaster := Views[Viewselected].platesData[Views[Viewselected].LPV.Selected.ImageIndex].Pages[Mouseoverpage].MasterCopySeparationSet;
          if (Prefs.AllowParalelView) then
          begin
            if (((formprev2.Active) or (formprev2.showing)))  then
            begin
              Formprev2.gotospecific(Formprev2.prevmaster);
            End
            Else
            begin
              Formprev2.show;
            end;
          end
          else
          begin
            Formprev2.ShowModal;
          end;
          ipl := Views[Viewselected].LPV.Selected.ImageIndex;
          DataM1.Query1.sql.clear;
          DataM1.Query1.sql.add('Select status,approved,hold,pagepositions,colorid,pagename,PublicationID,PubDate from pagetable (NOLOCK) where ');
          DataM1.Query1.sql.add('Dirty = 0 and ');
          DataM1.Query1.sql.add('copyflatseparationset = ' + inttostr(Views[Viewselected].platesData[Views[Viewselected].LPV.Selected.ImageIndex].CopyFlatSeparationSet));
          DataM1.Query1.Open;
          For IP := 1 to 32 do
          begin
            Views[Viewselected].platesData[IPL].pages[ip].totapproval := 1;
          end;
          While not DataM1.Query1.eof do
          begin
            PreviewGUID := inittypes.GeneratePreviewGUID(DataM1.Query1.fields[6].Asinteger, DataM1.Query1.fields[7].AsDateTime);
            thisapproved := DataM1.Query1.fields[1].Asinteger;
            thiscolorid :=  DataM1.Query1.fields[4].Asinteger;
            thispagename := DataM1.Query1.fields[5].AsString;
            For IP := 1 to platetemplatearray[Views[Viewselected].platesData[IPL].templatelistid].NupOnplate do
            begin
              if Views[Viewselected].platesData[IPL].pages[ip].pagename = thispagename then
              begin
                For ic := 1 to Views[Viewselected].platesData[IPL].pages[ip].Ncolors do
                begin
                  if Views[Viewselected].platesData[IPL].pages[ip].colors[ic].colorid = thiscolorid then
                  begin
                    Views[Viewselected].platesData[IPL].pages[ip].colors[ic].Approved := thisapproved;

                    if (Views[Viewselected].platesData[IPL].pages[ip].colors[ic].Approved <> 3) then
                    begin
                      if (Views[Viewselected].platesData[IPL].pages[ip].colors[ic].Approved = 2) then
                        Views[Viewselected].platesData[IPL].pages[ip].totapproval := 2;
                      if (Views[Viewselected].platesData[IPL].pages[ip].colors[ic].Approved = 0) and
                         (Views[Viewselected].platesData[IPL].pages[ip].totapproval <> 2) then
                        Views[Viewselected].platesData[IPL].pages[ip].totapproval := 0;
                    end;
                    break;
                  end;
                end;
              end;
            end;
            DataM1.Query1.next;
          end;
          DataM1.Query1.Close;
          PlateviewImage := tbitmap.Create;
          PlateviewImage.Width := IPV.Width;
          PlateviewImage.Height := IPV.Height;

          if (Prefs.UseExtendedPlateView) then
            plateresult := makeplateviewimagedeluxe(formmain.ActionplateThumbnails.checked,
                                            formmain.ActionnewplanSmallimages.checked,
                                            false,Views[Viewselected].LPV.Selected.ImageIndex, PreviewGUID)
          else
            plateresult := makeplateviewimage(formmain.ActionplateThumbnails.checked,
                                            formmain.ActionnewplanSmallimages.checked,
                                            false,Views[Viewselected].LPV.Selected.ImageIndex, PreviewGUID);
          IPV.ReplaceMasked(Views[Viewselected].LPV.Selected.ImageIndex,plateviewimage,clwhite);
          PlateviewImage.Free;
        end;
      end
      Else
      begin
        if ((Views[Viewselected].platesData[Views[Viewselected].LPV.Selected.ImageIndex].prevready > 0) or
           (Views[Viewselected].platesData[Views[Viewselected].LPV.Selected.ImageIndex].Softprevready)) and
           (Views[Viewselected].platesData[Views[Viewselected].LPV.Selected.ImageIndex].Totstat >= 30) then
        begin
          FlatSeparationSet := Views[Viewselected].platesData[Views[Viewselected].LPV.Selected.ImageIndex].Copies[1].FlatSeparationSet;
          Afilename := '';
          if (Prefs.UsePreviewCache) then
             Afilename := IncludeTrailingBackslash(FormMain.GetInkFolderCache(1)) +IntToStr(FlatSeparationSet)+'.jpg';
          if ((not Prefs.UsePreviewCache) or (Prefs.UsePreviewCache and not fileexists(Afilename))) then
            Afilename := IncludeTrailingBackslash(formmain.getinkfolder(1,tnames1.locationnametoid(formmain.ComboBoxpalocationNY.Text)))+inttostr(FlatSeparationSet)+'.jpg';

          if (Prefs.PlateTransmissionSystem) then
          begin
            if (Views[Viewselected].platesData[Views[Viewselected].LPV.Selected.ImageIndex].MasterCopyFlatSeparationSet <> Views[Viewselected].platesData[Views[Viewselected].LPV.Selected.ImageIndex].CopyFlatSeparationSet ) then
            begin
               Afilename := '';
              if (Prefs.UsePreviewCache) then
                 Afilename := IncludeTrailingBackslash(FormMain.GetInkFolderCache(1)) +inttostr((Views[Viewselected].platesData[Views[Viewselected].LPV.Selected.ImageIndex].masterCopyFlatSeparationSet * 100) +1)+'.jpg';
              if ((not Prefs.UsePreviewCache) or (Prefs.UsePreviewCache and not fileexists(Afilename))) then
                Afilename := IncludeTrailingBackslash(formmain.getinkfolder(1,tnames1.locationnametoid(formmain.ComboBoxpalocationNY.Text)))+inttostr((Views[Viewselected].platesData[Views[Viewselected].LPV.Selected.ImageIndex].masterCopyFlatSeparationSet * 100) +1)+'.jpg';
            end;
          end;

          if FileExists(Afilename) then
          begin

            FormprevPlate2.prevmaster := FlatSeparationSet;
            if (Prefs.AllowParalelView) then
            begin

              if (((FormprevPlate2.Active) or (FormprevPlate2.showing)))  then
              begin
                FormprevPlate2.gotospecific(FormprevPlate2.prevmaster);
              End
              Else
              begin
                FormprevPlate2.show;
              end;
            end
            else
            begin
              FormprevPlate2.ShowModal;
            end;
          end;
        end;
      end;
    End
    Else
    begin
      if ((Views[Viewselected].platesData[Views[Viewselected].LPV.Selected.ImageIndex].prevready > 0) or
         (Views[Viewselected].platesData[Views[Viewselected].LPV.Selected.ImageIndex].Softprevready)) and
         (Views[Viewselected].platesData[Views[Viewselected].LPV.Selected.ImageIndex].Totstat >= 30) then
      begin
        FlatSeparationSet := Views[Viewselected].platesData[Views[Viewselected].LPV.Selected.ImageIndex].Copies[1].FlatSeparationSet;
         Afilename := '';
        if (Prefs.UsePreviewCache) then
           Afilename := IncludeTrailingBackslash(FormMain.GetInkFolderCache(1)) +inttostr(FlatSeparationSet)+'.jpg';
        if ((not Prefs.UsePreviewCache) or (Prefs.UsePreviewCache and not fileexists(Afilename))) then
          Afilename := includetrailingbackslash(formmain.getinkfolder(1,tnames1.locationnametoid(formmain.ComboBoxpalocationNY.Text)))+inttostr(FlatSeparationSet)+'.jpg';

        if (Prefs.PlateTransmissionSystem) then
        begin
          if (Views[Viewselected].platesData[Views[Viewselected].LPV.Selected.ImageIndex].MasterCopyFlatSeparationSet <> Views[Viewselected].platesData[Views[Viewselected].LPV.Selected.ImageIndex].CopyFlatSeparationSet ) then
          begin
           Afilename := '';
            if (Prefs.UsePreviewCache) then
            begin
               Afilename := IncludeTrailingBackslash(FormMain.GetInkFolderCache(1)) +inttostr((Views[Viewselected].platesData[Views[Viewselected].LPV.Selected.ImageIndex].masterCopyFlatSeparationSet * 100) +1)+'.jpg';
            end;
            if ((not Prefs.UsePreviewCache) or (Prefs.UsePreviewCache and not fileexists(Afilename))) then
              Afilename := includetrailingbackslash(formmain.getinkfolder(1,tnames1.locationnametoid(formmain.ComboBoxpalocationNY.Text)))+inttostr((Views[Viewselected].platesData[Views[Viewselected].LPV.Selected.ImageIndex].masterCopyFlatSeparationSet * 100) +1)+'.jpg';
          end;
        end;

        if fileexists(Afilename) then
        begin
          FormprevPlate2.prevmaster := FlatSeparationSet;
          FormprevPlate2.Flatprevmaster := Formprev2.prevmaster;
          if (Prefs.PlateTransmissionSystem) then
          begin
            FormprevPlate2.Flatprevmaster := (Views[Viewselected].platesData[Views[Viewselected].LPV.Selected.ImageIndex].masterCopyFlatSeparationSet * 100)+1;
          end;

          if (Prefs.AllowParalelView) then
          begin
            if (((FormprevPlate2.Active) or (FormprevPlate2.showing)))  then
            begin
              FormprevPlate2.gotospecific(FormprevPlate2.prevmaster);
            End
            Else
            begin
              FormprevPlate2.show;
            end;
          end
          else
          begin
            FormprevPlate2.ShowModal;
          end;
        end;
      end;
    end;
  Except
  end;
  Updateviews;
end;

procedure TFPV.LPVKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((ssAlt IN Shift) OR (ssCtrl IN Shift)) And ((key < 58) And (key > 47)) then
  Begin
    TimerPlatetreekeyKey   := key;
    TimerPlatetreekeyshift := shift;
    formmain.TimerPlatetreekey.Enabled := true;
   // formmain.TreeViewpagelistKeyDown(formmain,Key,Shift);
    exit;
  end;
end;
procedure TFPV.LPVMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Var
//  I : Integer;
  L : Tlistitem;
  tp,tp1 : tpoint;
  IP,icol : Integer;
//  d : trect;
  mouseoverx,mouseovery : Integer;
begin
  Mouseoverpage := -1;
  if selfnumber <> -1 then
  begin
    L := Views[selfnumber].LPV.GetItemAt(x,y);
    if L <> nil then
    begin
      tp1 := Views[selfnumber].LPV.items[0].Position;
      tp := l.Position;
      icol := ((tp.X+Views[selfnumber].ipv.width)-28) div (Views[selfnumber].ipv.width+16);
      tp.x := (icol *16) + (Views[selfnumber].ipv.width*(icol))+28;
      mouseoverx := x-tp.x;
      mouseovery := y-tp.Y+Views[selfnumber].LPV.Vertpos;
    //  formmain.edit1.text := inttostr(mouseoverx)+ ','+inttostr(mouseovery) ;  DEBUG purpose
      For ip := 1 to platetemplatearray[Views[selfnumber].platesData[l.Index].templatelistid].NupOnplate do
      begin
        if (Views[selfnumber].platesData[l.Index].Pages[ip].position.Left < mouseoverx) and
           (Views[selfnumber].platesData[l.Index].Pages[ip].position.Right > mouseoverx) and
           (Views[selfnumber].platesData[l.Index].Pages[ip].position.top < mouseovery) and
           (Views[selfnumber].platesData[l.Index].Pages[ip].position.Bottom > mouseovery) then
        begin
          Mouseoverpage := ip;
          break;
        end;
      end;
    end;
  end;
 // formmain.edit1.text := inttostr(Mouseoverpage);       DEBUG purpose
end;

Function TFPV.makeAplateCaption(platesDataIP : Integer):String;
Var
  Icap,altI : Integer;
  Captext,devicenameT : String;
Begin
  result := Inttostr(platesDataIP);
  Captext := '';
  For Icap := 0 to Length(Prefs.PlateCaptionText)-1 do
  begin
    if (Prefs.PlateCaptionText[icap].Enabled) then
    begin
      if Captext <> '' then
        Captext := Captext + ' ';
      if Prefs.PlateCaptionText[icap].Name = 'Sheet' then
      begin
        captext := captext + inttostr(platesData[platesDataIP].sheetnumber);
      end;
      if Prefs.PlateCaptionText[icap].Name = 'Side' then
      begin
        if (Prefs.UseTrueSheetSide) and (platesData[platesDataIP].TrueFront IN [2,3]) then
        begin
          captext := captext + fronbackstr[platesData[platesDataIP].TrueFront-2];
        end
        else
        begin
          captext := captext + fronbackstr[platesData[platesDataIP].Front];
        end;
      end;
      if Prefs.PlateCaptionText[icap].Name = 'Altpagename' then
      begin
        captext := captext + platecapaltpage;
      end;
       (*  kkk
      if Prefs.PlateCaptionText[icap].Name = 'Alt sheet' then
      begin
        captext := captext + platecapaltpage;
      end;
      *)
      if Prefs.PlateCaptionText[icap].Name = 'Alt Low pageindex' then
      begin
        For altI := 1 to platesData[platesDataIP].Npages do
        begin
          if platesData[platesDataIP].pages[altI].pageindex = LCappageindex then
          begin
            captext := captext + platesData[platesDataIP].pages[altI].Altpagename;
            break;
          end;
        end;
      end;
      if Prefs.PlateCaptionText[icap].Name = 'Alt Low pagina' then
      begin
        For altI := 1 to platesData[platesDataIP].Npages do
        begin
          if platesData[platesDataIP].pages[altI].Pagina = LCappagina then
          begin
            captext := captext + platesData[platesDataIP].pages[altI].Altpagename;
            break;
          end;
        end;
      end;
      if Prefs.PlateCaptionText[icap].Name = 'pagina' then
      begin
        captext := captext + platecappagina;
      end;
      if Prefs.PlateCaptionText[icap].Name = 'pageindex' then
      begin
        captext := captext + platecappageindex;
      end;
      if Prefs.PlateCaptionText[icap].Name = 'Copy' then
      begin
        captext := captext + 'c' + inttostr(platesData[platesDataIP].Ncopies);
      end;
      if Prefs.PlateCaptionText[icap].Name = 'Tower' then
      begin
        captext := captext  + platesData[platesDataIP].Copies[1].Tower;
      end;
      if Prefs.PlateCaptionText[icap].Name = 'Zone' then
      begin
        captext := captext  + platesData[platesDataIP].Zone;
      end;
      if Prefs.PlateCaptionText[icap].Name = 'Low/High' then
      begin
        if ( platesData[platesDataIP].Ncopies = 1) then
          captext := captext  + platesData[platesDataIP].Copies[1].LowHigh
        else
          captext := captext  + platesData[platesDataIP].Copies[1].LowHigh  + '/' + platesData[platesDataIP].Copies[2].LowHigh;
      end;
      if Prefs.PlateCaptionText[icap].Name = 'SortingPosition' then
      begin
        if ( platesData[platesDataIP].Ncopies = 1) then
          captext := captext  + platesData[platesDataIP].Copies[1].SortingPosition
        else
          captext := captext  + platesData[platesDataIP].Copies[1].SortingPosition  + '/' + platesData[platesDataIP].Copies[2].SortingPosition;
      end;
      if Prefs.PlateCaptionText[icap].Name = 'Platenumber' then
      begin
        captext := captext  + platesData[platesDataIP].Miscstring1;
      end;
      if Prefs.PlateCaptionText[icap].Name = 'Ink name (MiscString3)' then
      begin
        captext := captext  + platesData[platesDataIP].Miscstring3;
      end;
      if Prefs.PlateCaptionText[icap].Name = 'Pagename' then
      begin
        captext := captext  + platepanenamescap;
      end;
      if Prefs.PlateCaptionText[icap].Name = 'Low pageindex' then
      begin
        captext := captext  + inttostr(LCappageindex);
      end;
      if Prefs.PlateCaptionText[icap].Name = 'Low pagina' then
      begin
        captext := captext  + inttostr(LCappagina);
      end;
      if Prefs.PlateCaptionText[icap].Name = 'Device' then
      begin
        if platesData[platesDataIP].copies[1].deviceid > 0 then
          captext := captext  + tnames1.deviceIDtoname(platesData[platesDataIP].copies[1].deviceid);
      end;
      if Prefs.PlateCaptionText[icap].Name = 'Edition' then
      begin
        captext := captext  + tnames1.editionIDtoname(platesData[platesDataIP].EditionID);
      end;
      if Prefs.PlateCaptionText[icap].Name = 'Master edition' then
      begin
        if (platesData[platesDataIP].Pages[1].OrgEditionID > 0) then
          captext := captext  + tnames1.editionIDtoname(platesData[platesDataIP].Pages[1].OrgEditionID)
        else
          captext := captext  + tnames1.editionIDtoname(platesData[platesDataIP].EditionID)
      end;
      if Prefs.PlateCaptionText[icap].Name = 'Section' then
      begin
        captext := captext  + tnames1.sectionIDtoname(platesData[platesDataIP].Pages[1].SectionID);
      end;
      if Prefs.PlateCaptionText[icap].Name = 'Layout' then
      begin
        captext := captext  + platetemplatearray[platesData[platesDataIP].templatelistid].TemplateName;
      end;
      if Prefs.PlateCaptionText[icap].Name = 'Layout Alias' then
      begin
        captext := captext  + platetemplatearray[platesData[platesDataIP].templatelistid].Outputalias;
      end;

      if Prefs.PlateCaptionText[icap].Name = 'InkAlias' then
      begin
        DataM1.Query3.SQL.Clear;
        DataM1.Query3.SQL.Add('Select top 1 ShortName from InkAliases where LongName = '+''''+tnames1.publicationIDtoname(platesData[platesDataIP].publicationID)+'''');
        DataM1.Query3.SQL.Add('and pressid = ' + IntToStr(pressid));
        DataM1.Query3.Open;
        if not DataM1.Query3.Eof then
        begin
          if DataM1.Query3.fieldbyname('shortname').AsString <> '' then
            captext := captext  +  DataM1.Query3.FieldByName('shortname').AsString;
        end;
        DataM1.Query3.Close;
      end;


      if Prefs.PlateCaptionText[icap].Name = 'DeviceAlias' then
      begin
        if platesData[platesDataIP].copies[1].deviceid > 0 then
        begin
          DataM1.Query3.SQL.clear;
          DataM1.Query3.SQL.add('Select top 1 longname,ShortName From OutputAliases WITH (nolock)');
          DataM1.Query3.SQL.add('Where Type = ' +''''+'Device'+'''');
          DataM1.Query3.SQL.add('and longname = ' +''''+tnames1.deviceIDtoname(platesData[platesDataIP].copies[1].deviceid)+'''');
          DataM1.Query3.open;
          if not DataM1.Query3.eof then
          begin
            captext := captext  + DataM1.Query3.fields[1].asstring;
          end;
          DataM1.Query3.close;
        end;
      end;
    end;
  end;
  result := Captext;
end;

procedure TFPV.loadplateviewdata(Keepviews : Boolean);
Var
  Aktprevisready,anyactiveincpy : Boolean;
  plateresult : Integer;
  plateresults : array[0..2000] of Integer;
  aktselectedCopyflatsepset : Integer;
  l : tlistitem;
  aktCopyflatseparationset,aktflatseparationset : Integer;
  Iplate : Integer;
  IP : Integer;
  Plateimage : Tbitmap;
  ipl : Integer;
  imindx : Integer;
  InotOK,IOK : Integer;
  pt: TPoint;
  iip,thisrow: Integer;
  thiscol: Integer;
  maxcols: Integer;
  T : string;
  Insertedsections : Integer;
  Aktshowplate : Tshowplate;
  Icap : Integer;
  Captext : string;
  multicopies,anyunique,anyreceived : Boolean;
  Topitemcopyplateset : Integer;
  akttopitem,icpcol : Integer;

  I,i1,ICPY,ic : Integer;
  Nplatepresel : Integer;

  AktPLpressrunid,aktpleditionid : Integer;
  firstrow : Boolean;
  aktsection,aktedition : Integer;
  aktpresssectionnumber,aktpressrunid,aktivencopies : Integer;

  LPVItemsNum : Integer;
  loadplatesucces,FoundFlatPageTable : Boolean;
  thiscopyflatseparationset : Integer;
  PreviewGUID : String;
begin
  try
    towerfilter := '';
    if (Formmain.GroupBoxtowerfilter.visible) and (Formmain.ComboBoxplatetowersfilter.itemindex > 0 ) then
    begin
      towerfilter := Formtowerfilter.gettowINstring(Formmain.ComboBoxplatetowersfilter.text);
    end;
    Specialplatestanding := false;
    Therearenoplates := false;
    firstrow := true;
    AktPLpressrunid := -1;
    aktpleditionid := -1;
    Insertedsections := -1;
    PlateviewImage := tbitmap.Create;
    plateviewimage.Width := 23;    //204
    plateviewimage.height := 51;   //176
    Topitemcopyplateset := -1;
    if formmain.ActionplateSmallimages.Checked then
      Pressviewzoom := 50
    else
      Pressviewzoom := 100;
    aktselectedCopyflatsepset := -1;
    AnyFlatpagetabledata := false;
    if (FlatPageTablePossible) then
    begin
      DataM1.SQLQueryplateupd.sql.Clear;
      DataM1.SQLQueryplateupd.sql.add('Select top 1 f.processtype,p.productionid ');
      DataM1.SQLQueryplateupd.sql.add('from FlatPageTable f (NOLOCK),pagetable p (NOLOCK)');
      DataM1.SQLQueryplateupd.sql.add('where ((p.status = 46) or (p.status=49))');
      DataM1.SQLQueryplateupd.sql.add('and p.pressrunid = ' + inttostr(pressrunid));
      DataM1.SQLQueryplateupd.sql.add('and f.FlatSeparation = p.FlatSeparation');
      if towerfilter <> '' then
      begin
        DataM1.SQLQueryplateupd.sql.add('and p.presstower IN ('+towerfilter+')' );
      end;
      DataM1.SQLQueryplateupd.sql.add('order by p.productionid');
      if Prefs.debug then datam1.SQLQueryplateupd.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'Getflatpagetablestat2.sql');
      DataM1.SQLQueryplateupd.Open;
      if not DataM1.SQLQueryplateupd.eof then
      begin
        AnyFlatpagetabledata := true;
      end;
      DataM1.SQLQueryplateupd.Close;
    end;
    PreviewGUID := '';
    DataM1.Query2.sql.clear;
    DataM1.Query2.sql.add('Select TOP 1 PublicationID, PubDate FROM PageTable (NOLOCK)');
    DataM1.Query2.sql.add('where pressid = ' + inttostr(pressid));
    DataM1.Query2.sql.add('and pressrunid = ' + inttostr(pressrunid));
    DataM1.Query2.sql.add('and active = 1 and dirty = 0');
    DataM1.Query2.open;
    if not DataM1.Query2.eof then
    begin
      PreviewGUID := inittypes.GeneratePreviewGUID(DataM1.Query2.fields[0].asinteger, DataM1.Query2.fields[1].AsDateTime);
    end;
    DataM1.Query2.close;
    DataM1.Query2.sql.clear;
    DataM1.Query2.sql.add('Select Count(Distinct Copyflatseparationset) from pagetable (NOLOCK)');
    DataM1.Query2.sql.add('where pressid = ' + inttostr(pressid));
    DataM1.Query2.sql.add('and pressrunid = ' + inttostr(pressrunid));
    DataM1.Query2.sql.add('and active = 1 and dirty = 0');
  //  DataM1.Query2.open;
    if PlatesortType > 0 then
    begin
      DataM1.Query2.sql.add('and Copynumber = 1');
    end;
    DataM1.Query2.sql.add('and copyflatseparationset IN ' + flatStatesets);
    if towerfilter <> '' then
    begin
      DataM1.Query2.sql.add('and presstower IN ('+ towerfilter +')' );
    end;
    if Therearenoplates then
      DataM1.Query2.sql.add('and locationid = -932');
    DataM1.Query2.sql.add('and locationid = '+inttostr(locationid));
    if Prefs.debug then datam1.Query2.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'plateviewgetflatseparationsets1.sql');
    DataM1.Query2.open;
    Nplates := 0;
    if not DataM1.Query2.eof then
      Nplates := DataM1.Query2.fields[0].asinteger;
    DataM1.Query2.close;
    Setlength(platesData,Nplates+10);
    // NAN
    //DataM1.Query2.sql.Clear;
    Case PlatesortType  of
      0 : begin
            DataM1.Query2.sql[0] := 'Select Distinct copyflatseparationset,editionid,PressSectionNumber,pressrunid,sheetnumber,sheetside from pagetable (NOLOCK)';
            DataM1.Query2.sql.Add('order by editionid,PressSectionNumber,pressrunid,sheetnumber,sheetside,copyflatseparationset');
          end;
      1 : Begin
            DataM1.Query2.sql[0] := 'Select Distinct copyflatseparationset,editionid,PressSectionNumber,pressrunid,sheetnumber,sheetside,PressTower from pagetable (NOLOCK)';
            DataM1.Query2.sql.Add('order by editionid,PressSectionNumber,pressrunid,sheetside,sheetnumber,copyflatseparationset');
          end;
      2 : begin
            DataM1.Query2.sql[0] := 'Select Distinct copyflatseparationset,editionid,PressSectionNumber,pressrunid,sheetnumber,sheetside,PressTower from pagetable (NOLOCK)';
            DataM1.Query2.sql.Add('order by editionid,PressSectionNumber,pressrunid,PressTower,sheetnumber,sheetside,copyflatseparationset');
          end;
      Else
      begin
        DataM1.Query2.sql[0] := 'Select Distinct copyflatseparationset,editionid,PressSectionNumber,pressrunid,sheetnumber,sheetside,PressTower from pagetable (NOLOCK)';
        DataM1.Query2.sql.Add('order by editionid,PressSectionNumber,pressrunid,sheetnumber,sheetside,copyflatseparationset');
      end;
    end;
    if Prefs.debug then datam1.Query2.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'loadplateview.sql');
    formmain.tryopen(datam1.Query2);
    aktCopyflatseparationset := -1;
    aktflatseparationset := -1;
    ipl := -1;
    Firsttemplateid := -1;

    While not DataM1.Query2.eof do
    begin
      thiscopyflatseparationset :=  DataM1.Query2.fields[0].AsInteger;
      if (Prefs.NewPlateDataSystem) then
      begin
        loadplatesucces :=  loadAPlateFromdata(thiscopyflatseparationset,aktshowplate);
      end
      else
      begin
        loadplatesucces := LoadAPlate(thiscopyflatseparationset,aktshowplate);
      end;
      if loadplatesucces then
      begin
        aktshowplate.changed := false;
        anyunique := false;
        aktivencopies := Aktshowplate.Ncopies;
        anyreceived := false;
        for ip := 1 to PlatetemplateArray[Aktshowplate.Templatelistid].NupOnplate do
        begin
          if aktshowplate.Pages[ip].UniquePage <> 0 then
          begin
            anyunique := true;
            break;
          end;
        end;
        for ip := 1 to PlatetemplateArray[Aktshowplate.Templatelistid].NupOnplate do
        begin
          For ic := 0 to aktshowplate.Pages[ip].Ncolors do
          begin
            if aktshowplate.Pages[ip].colors[ic].status <> 0 then
            begin
              anyreceived := true;
              break;
            end;
          end;
          if anyreceived then
            break;
        end;
        for icpy := Aktshowplate.Ncopies downto 1 do
        begin
          anyactiveincpy := false;
          for ic := 1 to Aktshowplate.copies[icpy].Ncolors do
          begin
            if Aktshowplate.copies[icpy].colorstatus[ic].Active = 1 then
            begin
              anyactiveincpy := true;
              break;
            end;
          end;
          if not anyactiveincpy then
            dec(aktivencopies);
        end;
        Aktshowplate.Ncopies := aktivencopies;
        {
        if (aktivencopies > 0) and ((anyunique) or (not formmain.actionplateHidecommon.checked)) and
           ((anyreceived) OR (not formmain.Actionplatehideempty.checked)  )then
        }

        if (aktivencopies > 0) then
        Begin
          Inc(IPL);
          platesData[ipl] := Aktshowplate;
        end;
      end
      Else
      begin

      end;
      DataM1.Query2.next;
    end;
    DataM1.Query2.close;

    if ipl > -1 then
      getorgeds;


    // Start make image Start make image Start make image Start make image Start make image Start make image
    // Start make image Start make image Start make image Start make image Start make image Start make image
    // Start make image Start make image Start make image Start make image Start make image Start make image
    // Start make image Start make image Start make image Start make image Start make image Start make image
    // Start make image Start make image Start make image Start make image Start make image Start make image

    LPV.Items.BeginUpdate;
    thisrow := 0;
    thiscol := 0;
    nplates := ipl +1;
    Getmegasize(pressrunid);
    For ip := 0 to ipl do
    begin
      // kalder makeplateviewimage kalder makeplateviewimage kalder makeplateviewimage kalder makeplateviewimage
      // kalder makeplateviewimage kalder makeplateviewimage kalder makeplateviewimage kalder makeplateviewimage
      // kalder makeplateviewimage kalder makeplateviewimage kalder makeplateviewimage kalder makeplateviewimage
      // kalder makeplateviewimage kalder makeplateviewimage kalder makeplateviewimage kalder makeplateviewimage
      if platesData[IP].Ncopies > 0 then
      begin
        if (Prefs.UseExtendedPlateView) then
          plateresult := makeplateviewimagedeluxe(formmain.ActionplateThumbnails.checked,
                                          formmain.ActionnewplanSmallimages.checked,
                                          false,ip,PreviewGUID)
        else
          plateresult := makeplateviewimage(formmain.ActionplateThumbnails.checked,
                                          formmain.ActionnewplanSmallimages.checked,
                                          false,ip,PreviewGUID);
        plateresults[ip] := plateresult;
        if plateresult > 0 then
        begin
          if (plateresult = 1) or (true) then
          begin
            imindx := IPV.AddMasked(plateviewimage,clwhite);
            if firstrow  then
            Begin
              maxcols :=  LPV.Width div (IPV.width+plateviewgutter+1 (*10*));
              firstrow := false;
              aktsection := platesData[ip].Pages[1].SectionID;
              aktedition := platesData[ip].editionid;
            end;
            Captext := makeAplateCaption(IP);
            if LPV.Items.Count-1 < ip then
            Begin
              l := LPV.Items.Add;
            end;
            if KeepViews then
            begin
              LPVItemsNum := IP;
            end
            else
            begin
              LPVItemsNum := LPV.Items.Count-1;
            end;
            LPV.Items[LPVItemsNum].Caption := captext;
            LPV.Items[LPVItemsNum].ImageIndex := imindx;
            LPV.Items[LPVItemsNum].SubItems.Add(inttostr(platesData[ip].CopyFlatSeparationSet));
            platesData[ip].Imageindex := imindx;
            Inc(thiscol);
            if ((thiscol > maxcols)) then
            begin
              thiscol := 1;
              Inc(thisrow);
            end;

            if AktPLpressrunid = -1 then
            Begin
              AktPLpressrunid := platesData[ip].runid;
              aktpleditionid  := platesData[ip].EditionID;
            end;

            if ((aktsection <> platesData[ip].Pages[1].SectionID) and (Insertedsections = 1)) or (AktPLpressrunid <> platesData[ip].runid)
               or (aktpleditionid <> platesData[ip].EditionID) then
            begin
              aktsection := platesData[ip].Pages[1].SectionID;
              AktPLpressrunid := platesData[ip].runid;
              aktpleditionid := platesData[ip].EditionID;
              thiscol := 1;
              Inc(thisrow,1);
            end;

            pt.X := (thiscol-1)*(IPV.width+PLATEVIEWGUTTER) - PLATEVIEWGUTTER;
            pt.Y := thisrow * (IPV.height+PLATEVIEWGUTTERVERTICAL) + 4;
            scrollheight := IPV.height+PLATEVIEWGUTTERVERTICAL;
            if thisrow = 0 then
            begin
              firstrowtop := pt.Y + self.Top;
              firstrowBottom := firstrowtop+LPV.Top+scrollheight;
            end;
            LPV.Items[LPVItemsNum].Position := pt;
            Maxheight := pt.Y + IPV.height +72;
          end;
        End
        Else
          platesData[ip].Imageindex := -1;
      End
      Else
        platesData[ip].Imageindex := -1;
    end;
    // end make image end make image end make image end make image end make image end make image
    // end make image end make image end make image end make image end make image end make image
    // end make image end make image end make image end make image end make image end make image
    // end make image end make image end make image end make image end make image end make image
    // end make image end make image end make image end make image end make image end make image

    While LPV.Items.count > ip do
      LPV.Items[LPV.Items.count-1].Delete;
    LPV.Items.EndUpdate;
    LPV.Visible := true;

  Except
  end;
  PlateviewImage.Free;
end;

Function TFPV.loadAPlate(copyflatseparationset : Integer;
                         Var Aktshowplate : Tshowplate):Boolean;
Var
  T,anumT : String;
  ip,IC,ICPY,icpcol : Integer;
  ippos,Nppos : Integer;
  ppos : pparray;
  foundcpcol : boolean;
  Afilename : string;
  Aktprevisready,anyactiveincpy : Boolean;
  neededactive,Areactive : Integer;
  AFlatproofstatus : Integer;
  ThisColorID : Integer;
Begin
  result := false;
  try
    Try
      result := false;
      writeMainlogfile('loadAPlate start ' + inttostr(0));
      DataM1.SQLQueryplateupd.sql.clear;
      DataM1.SQLQueryplateupd.sql.add('Select pagepositions,pressrunid,UniquePage, pagetype,Creep,SectionID,pressid,pagename,MasterCopySeparationSet,');
      DataM1.SQLQueryplateupd.sql.add('CopySeparationSet,SeparationSet,pagetable.Separation,flatseparationset,');
      DataM1.SQLQueryplateupd.sql.add('sheetside,CopyFlatSeparationSet,productionID,IssueID,publicationID,Copynumber,EditionID,locationID,deviceID,templateid,');
      DataM1.SQLQueryplateupd.sql.add('pagetable.FlatSeparation,colorid,active,status,Proofstatus,Approved,priority,Hold,sortingposition,sheetnumber,');
      DataM1.SQLQueryplateupd.sql.add('pressTower,pressHighlow,pressCylinder,pressZone,pagetype,pagename,pagination,pageindex,MarkGroups,flatproofconfigurationid,HardProofConfigurationID,Miscstring1,Miscstring3,version,inkstatus,fileserver,externalstatus,flatproofstatus');
      if (Prefs.PlateTransmissionSystem) then
        DataM1.SQLQueryplateupd.sql.add(', miscstring2, miscstring1');
      if Prefs.AlternativePageNameField <> '' then
      DataM1.SQLQueryplateupd.sql.add(', ' + Prefs.AlternativePageNameField);
      if Prefs.AlternativeSheetnameField <> '' then
        DataM1.SQLQueryplateupd.sql.add(', ' +  Prefs.AlternativeSheetnameField);
      // # NAN 20150206
      if (Global_HasPageCategoryField) then
         DataM1.SQLQueryplateupd.sql.add(', PageCategoryID, FanoutID,OutputVersion');
      // # NAN 20150206
         DataM1.SQLQueryplateupd.sql.add(', PressHighLow');

      DataM1.SQLQueryplateupd.sql.add(' from pagetable (NOLOCK) ');
      DataM1.SQLQueryplateupd.sql.add('where dirty = 0 and copyflatseparationset = ' + inttostr(copyflatseparationset));
      DataM1.SQLQueryplateupd.sql.add('order by editionid,PressSectionNumber,pressrunid,sheetnumber,sheetside,Copynumber,copyflatseparationset,flatseparationset,colorid,pagepositions');
      if Prefs.debug then datam1.SQLQueryplateupd.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'loadplateviewAplate.sql');
      //datam1.SQLQueryplateupd.Open;
      formmain.tryopen(datam1.SQLQueryplateupd);
      writeMainlogfile('loadAPlate is open SQLQueryplateupd ' + inttostr(1));

      if datam1.SQLQueryplateupd.eof then
      begin
        writeMainlogfile('loadAPlate eof ' + inttostr(-1));
        result := false;
        exit;
      end;
      Aktshowplate.InkError := false;
      if formmain.getinkfolder(1,tnames1.locationnametoid(formmain.ComboBoxpalocationNY.Text)) = '' then
        Aktshowplate.prevready             := -1
      Else
        Aktshowplate.prevready             := 1;
      writeMainlogfile('loadAPlate Aktshowplate.prevready ' + inttostr(Aktshowplate.prevready));
      Aktshowplate.pressid               := DataM1.SQLQueryplateupd.fieldbyname('pressid').Asinteger;
      Aktshowplate.runid                 := DataM1.SQLQueryplateupd.fieldbyname('pressrunid').Asinteger;
      Aktshowplate.Front                 := DataM1.SQLQueryplateupd.fieldbyname('sheetside').Asinteger;
      Aktshowplate.trueFront := Aktshowplate.Front;
      if (DataM1.SQLQueryplateupd.fieldbyname('pressCylinder').Asstring = fronbackstr[0]) or (DataM1.SQLQueryplateupd.fieldbyname('pressCylinder').Asstring = fronbackstr[1]) then
      Begin
        if (DataM1.SQLQueryplateupd.fieldbyname('pressCylinder').Asstring = fronbackstr[0]) then
          Aktshowplate.trueFront := 2
        else
          Aktshowplate.trueFront := 3;
      end;
      writeMainlogfile('loadAPlate Aktshowplate.trueFront ' + inttostr(Aktshowplate.trueFront));
      Aktshowplate.sheetnumber           := DataM1.SQLQueryplateupd.fieldbyname('sheetnumber').Asinteger;
      Aktshowplate.CopyFlatSeparationSet := DataM1.SQLQueryplateupd.fieldbyname('CopyFlatSeparationSet').Asinteger;
      Aktshowplate.MasterCopyFlatSeparationSet := DataM1.SQLQueryplateupd.fieldbyname('CopyFlatSeparationSet').Asinteger;
      if (Prefs.PlateTransmissionSystem) then
      Begin
        anumT := DataM1.SQLQueryplateupd.fieldbyname('miscstring2').Asstring;
        if TUtils.checkstrTal(anumT) then
          Aktshowplate.MasterCopyFlatSeparationSet := DataM1.SQLQueryplateupd.fieldbyname('miscstring2').Asinteger;
      end;
      Aktshowplate.productionID          := DataM1.SQLQueryplateupd.fieldbyname('productionID').Asinteger;
      Aktshowplate.IssueID               := DataM1.SQLQueryplateupd.fieldbyname('IssueID').Asinteger;
      Aktshowplate.publicationID         := DataM1.SQLQueryplateupd.fieldbyname('publicationID').Asinteger;
      Aktshowplate.EditionID             := DataM1.SQLQueryplateupd.fieldbyname('EditionID').Asinteger;
      Aktshowplate.locationID            := DataM1.SQLQueryplateupd.fieldbyname('locationID').Asinteger;
      Aktshowplate.Miscstring1           := DataM1.SQLQueryplateupd.fieldbyname('miscstring1').Asstring;
      Aktshowplate.Miscstring3           := DataM1.SQLQueryplateupd.fieldbyname('miscstring3').Asstring;
      Aktshowplate.Altsheet := '';
      Aktshowplate.templatelistid        := inittypes.gettemplatenumberfromID(DataM1.SQLQueryplateupd.fieldbyname('templateid').Asinteger);
      if Prefs.AlternativeSheetnameField <> '' then
      Begin
        Aktshowplate.Altsheet := DataM1.SQLQueryplateupd.fieldbyname(Prefs.AlternativeSheetnameField).Asstring;
      end;
      // ny korean bare for sjov
      //Aktshowplate.templatelistid        := Firsttemplateid;

      Aktshowplate.Fullflatlistid        := inittypes.gettemplatenumberfromID(DataM1.SQLQueryplateupd.fieldbyname('FlatProofConfigurationID').Asinteger);
      Aktshowplate.Flattproofid          := Formflatproof.Getflatproofid(DataM1.SQLQueryplateupd.fieldbyname('FlatProofConfigurationID').Asinteger);
      Aktshowplate.Npages := 1;
      inittypes.markstrtoarray(DataM1.SQLQueryplateupd.fieldbyname('MarkGroups').Asstring,Aktshowplate.markgroups,Aktshowplate.Nmarkgroups);
      for ip := 1 to 32 do
      Begin
        Aktshowplate.Pages[ip].Altpagename := '';
        Aktshowplate.Pages[ip].pagetype := -1;
        Aktshowplate.Pages[ip].Ncolors :=0;
        Aktshowplate.Pages[ip].totapproval := 1;
        Aktshowplate.Pages[ip].Anyheld := false;
        Aktshowplate.Pages[ip].Anyreleased := false;
        for ic := 1 to 16 do
        begin
          Aktshowplate.Pages[ip].colors[ic].active := 0;
        end;
      end;
      For icpy := 1 to 16 do
      begin
        Aktshowplate.Copies[ICPY].Ncolors := 0;
        For icpcol := 1 to 16 do
        Begin
          Aktshowplate.Copies[ICPY].colorstatus[icpcol].colorid :=-1;
          Aktshowplate.Copies[ICPY].colorstatus[icpcol].Active := 0;
          Aktshowplate.Copies[ICPY].colorstatus[icpcol].Hold := 0;
          Aktshowplate.Copies[ICPY].colorstatus[icpcol].Status := -1;
          Aktshowplate.Copies[ICPY].colorstatus[icpcol].Flatpagestatus := -1;
          Aktshowplate.Copies[ICPY].colorstatus[icpcol].Inkstatus :=0;
          Aktshowplate.Copies[ICPY].colorstatus[icpcol].Bendingprik := -1;  //0 ingen prik 1 g�n prik 2 r�d prik
          Aktshowplate.Copies[ICPY].colorstatus[icpcol].Sortedprik := -1;   //0 ingen prik 1 g�n prik 2 r�d prik
        end;
      end;
      Aktshowplate.Templatelistid := inittypes.gettemplatenumberfromID(DataM1.SQLQueryplateupd.fieldbyname('templateid').Asinteger);

      Aktshowplate.Npages := PlatetemplateArray[Aktshowplate.Templatelistid].NupOnplate;
      While not datam1.SQLQueryplateupd.eof do
      begin
        ICPY := DataM1.SQLQueryplateupd.fieldbyname('Copynumber').Asinteger;
        T := DataM1.SQLQueryplateupd.fields[0].asstring;
        Aktshowplate.Copies[ICPY].FlatSeparationSet  := DataM1.SQLQueryplateupd.fieldbyname('FlatSeparationSet').Asinteger;
        Aktshowplate.Copies[ICPY].deviceID           := DataM1.SQLQueryplateupd.fieldbyname('deviceID').Asinteger;
        Aktshowplate.Copies[ICPY].Tower              := DataM1.SQLQueryplateupd.fieldbyname('pressTower').Asstring;
        Aktshowplate.Copies[ICPY].LowHigh            := DataM1.SQLQueryplateupd.fieldbyname('PressHighLow').Asstring;
        Aktshowplate.Copies[ICPY].SortingPosition    := DataM1.SQLQueryplateupd.fieldbyname('sortingposition').Asstring;

        Aktshowplate.Ncopies := ICPY;
        inittypes.PPOSstrtoarray(t,ppos,Nppos);
        For ippos := 1 to Nppos do
        begin
          Aktshowplate.Pages[ppos[ippos]].UniquePage := DataM1.SQLQueryplateupd.fieldbyname('UniquePage').Asinteger;
  //        Aktshowplate.Pages[ppos[ippos]].halfweb := 0;
          Aktshowplate.Pages[ppos[ippos]].pagetype := DataM1.SQLQueryplateupd.fieldbyname('pagetype').Asinteger;
          Aktshowplate.Pages[ppos[ippos]].Creep := DataM1.SQLQueryplateupd.fieldbyname('Creep').Asinteger;
          Aktshowplate.Pages[ppos[ippos]].SectionID  := DataM1.SQLQueryplateupd.fieldbyname('SectionID').Asinteger;
          Aktshowplate.Pages[ppos[ippos]].pagename := DataM1.SQLQueryplateupd.fieldbyname('pagename').Asstring;
          Aktshowplate.Pages[ppos[ippos]].MasterCopySeparationSet := DataM1.SQLQueryplateupd.fieldbyname('MasterCopySeparationSet').Asinteger;
          Aktshowplate.Pages[ppos[ippos]].CopySeparationSet := DataM1.SQLQueryplateupd.fieldbyname('CopySeparationSet').Asinteger;
          Aktshowplate.Pages[ppos[ippos]].SeparationSet := DataM1.SQLQueryplateupd.fieldbyname('SeparationSet').Asinteger;
          Aktshowplate.Pages[ppos[ippos]].OrgeditionID := Aktshowplate.EditionID;
          Aktshowplate.Pages[ppos[ippos]].OrgCopySeparationSet := Aktshowplate.Pages[ppos[ippos]].CopySeparationSet;
          Aktshowplate.Pages[ppos[ippos]].pagina            := DataM1.SQLQueryplateupd.fieldbyname('pagination').Asinteger;
          Aktshowplate.Pages[ppos[ippos]].pageindex         := DataM1.SQLQueryplateupd.fieldbyname('pageindex').Asinteger;
          Aktshowplate.Pages[ppos[ippos]].Fileserver        := DataM1.SQLQueryplateupd.fieldbyname('fileserver').Asstring;
          Aktshowplate.Pages[ppos[ippos]].miscstring        := DataM1.SQLQueryplateupd.fieldbyname('miscstring1').Asstring;
          // # NAN 20150206
          if (Global_HasPageCategoryField) then
          begin
            Aktshowplate.Pages[ppos[ippos]].PageRotationOverrule :=  DataM1.SQLQueryplateupd.fieldbyname('PageCategoryID').Asinteger;
            Aktshowplate.Pages[ppos[ippos]].PhonyPanorama := (DataM1.SQLQueryplateupd.fieldbyname('FanoutID').Asinteger) AND 255;
           // Aktshowplate.Pages[ppos[ippos]].OutputVersion := DataM1.SQLQueryplateupd.fieldbyname('OutputVersion').Asinteger;

            //if (DataM1.SQLQueryplateupd.fieldbyname('FanoutID').Asinteger = 2) AND (Aktshowplate.Pages[ppos[ippos]].PageRotationOverrule = 4) then
            //   Aktshowplate.Pages[ppos[ippos]].PageRotationOverrule := 2;
          end
          else
          begin
            Aktshowplate.Pages[ppos[ippos]].PageRotationOverrule := 0;
            Aktshowplate.Pages[ppos[ippos]].PhonyPanorama := 0;
            //Aktshowplate.Pages[ppos[ippos]].OutputVersion := 0;
          // # NAN 20150206
          end;
          if Aktshowplate.Pages[ppos[ippos]].pagetype < 3 then
          begin
            if ICPY = 1 then
              Inc(Aktshowplate.Pages[ppos[ippos]].Ncolors);
            foundcpcol := false;
            For icpcol := 1 to Aktshowplate.Copies[ICPY].Ncolors do
            begin
              if Aktshowplate.Copies[ICPY].colorstatus[icpcol].colorid =
                 DataM1.SQLQueryplateupd.fieldbyname('Colorid').Asinteger then
              begin
                foundcpcol := true;
                break;
              end;
            end;
            if not foundcpcol then
            begin
              Inc(Aktshowplate.Copies[ICPY].Ncolors);
              icpcol := Aktshowplate.Copies[ICPY].Ncolors;
              Aktshowplate.Copies[ICPY].colorstatus[icpcol].colorid := DataM1.SQLQueryplateupd.fieldbyname('Colorid').Asinteger;
            end;

            if DataM1.SQLQueryplateupd.fieldbyname('Active').Asinteger = 1 then
            Begin
              if Aktshowplate.Pages[ppos[ippos]].Altpagename = '' then
                Aktshowplate.Pages[ppos[ippos]].Altpagename := DataM1.SQLQueryplateupd.fieldbyname(Prefs.AlternativePageNameField).Asstring;
              if Aktshowplate.Copies[ICPY].colorstatus[icpcol].status = -1 then
              begin
                // F�rste side
                Aktshowplate.Copies[ICPY].colorstatus[icpcol].Active := 1;
                Aktshowplate.Copies[ICPY].colorstatus[icpcol].status := DataM1.SQLQueryplateupd.fieldbyname('status').Asinteger;
                Aktshowplate.Copies[ICPY].colorstatus[icpcol].Inkstatus := DataM1.SQLQueryplateupd.fieldbyname('Inkstatus').Asinteger;
                Aktshowplate.Copies[ICPY].colorstatus[icpcol].Hold := DataM1.SQLQueryplateupd.fieldbyname('Hold').Asinteger;
                Aktshowplate.Copies[ICPY].colorstatus[icpcol].externalstatus := DataM1.SQLQueryplateupd.fieldbyname('externalstatus').Asinteger;
                // ### NAN 20151019
                Aktshowplate.Copies[ICPY].colorstatus[icpcol].OutputVersion := DataM1.SQLQueryplateupd.fieldbyname('OutputVersion').Asinteger;
              end
              Else
              begin
                // N�ste side
                Aktshowplate.Copies[ICPY].colorstatus[icpcol].Active := 1;
                if Aktshowplate.Copies[ICPY].colorstatus[icpcol].status > DataM1.SQLQueryplateupd.fieldbyname('status').Asinteger then
                  Aktshowplate.Copies[ICPY].colorstatus[icpcol].status := DataM1.SQLQueryplateupd.fieldbyname('status').Asinteger;
                if DataM1.SQLQueryplateupd.fieldbyname('Hold').Asinteger = 1 then
                 Aktshowplate.Copies[ICPY].colorstatus[icpcol].Hold := 1;
                // ### NAN 20151019
                 if Aktshowplate.Copies[ICPY].colorstatus[icpcol].OutputVersion > DataM1.SQLQueryplateupd.fieldbyname('OutputVersion').Asinteger then
                  Aktshowplate.Copies[ICPY].colorstatus[icpcol].OutputVersion := DataM1.SQLQueryplateupd.fieldbyname('OutputVersion').Asinteger;
              end;
            end;
            With Aktshowplate.Pages[ppos[ippos]].colors[Aktshowplate.Pages[ppos[ippos]].Ncolors] do
            begin
              if Aktshowplate.Pages[ppos[ippos]].Fileserver = '' then
              begin
                if DataM1.SQLQueryplateupd.fieldbyname('fileserver').Asstring <> '' then
                  Aktshowplate.Pages[ppos[ippos]].Fileserver        := DataM1.SQLQueryplateupd.fieldbyname('fileserver').Asstring;
              end;
              UniquePage        := DataM1.SQLQueryplateupd.fieldbyname('UniquePage').Asinteger;
              Separation        := DataM1.SQLQueryplateupd.fieldbyname('separation').asvariant;
              FlatSeparation    := DataM1.SQLQueryplateupd.fieldbyname('flatseparation').asvariant;
              colorid           := DataM1.SQLQueryplateupd.fieldbyname('colorid').Asinteger;
              copynumber        := DataM1.SQLQueryplateupd.fieldbyname('copynumber').Asinteger;
              if active = 0 then
              begin
                active            := DataM1.SQLQueryplateupd.fieldbyname('active').Asinteger;
              end;
              if active = 1 then
              begin
                version           := DataM1.SQLQueryplateupd.fieldbyname('version').Asinteger;
                status            := DataM1.SQLQueryplateupd.fieldbyname('status').Asinteger;
                externalstatus    := DataM1.SQLQueryplateupd.fieldbyname('externalstatus').Asinteger;
                Proofstatus       := DataM1.SQLQueryplateupd.fieldbyname('Proofstatus').Asinteger;
                Approved          := DataM1.SQLQueryplateupd.fieldbyname('Approved').Asinteger;
                priority          := DataM1.SQLQueryplateupd.fieldbyname('priority').Asinteger;
                Hold              := DataM1.SQLQueryplateupd.fieldbyname('Hold').Asinteger;
              //  outputversion     := DataM1.SQLQueryplateupd.fieldbyname('OutputVersion').Asinteger;
              end;
              if active=1 then
              begin
                if (DataM1.SQLQueryplateupd.fieldbyname('Copynumber').Asinteger = 1) and (DataM1.SQLQueryplateupd.fieldbyname('Active').Asinteger = 1) then
                begin
                  Aktshowplate.Inkerror := false;
                  if DataM1.SQLQueryplateupd.fieldbyname('inkstatus').Asinteger = 6 then
                    Aktshowplate.Inkerror := true;
                  Aktshowplate.Softprevready := false;
                  AFlatproofstatus := DataM1.SQLQueryplateupd.fieldbyname('Flatproofstatus').Asinteger;
                  if (Prefs.PlateTransmissionSystem) and (Aktshowplate.MasterCopyFlatSeparationSet <> Aktshowplate.CopyFlatSeparationSet ) then
                  begin
                    DataM1.SQLQueryMplateupd.SQL.Clear;
                    DataM1.SQLQueryMplateupd.SQL.add('');
                  end;
                  if (AFlatproofstatus = 10) then
                  Begin
                    Afilename := includetrailingbackslash(formmain.getinkfolder(1,tnames1.locationnametoid(formmain.ComboBoxpalocationNY.Text)))+inttostr(Aktshowplate.Copies[1].FlatSeparationSet)+'.jpg';
                    Aktprevisready := fileexists(Afilename);
                    Aktshowplate.Softprevready := true;
                  end;
                  if (DataM1.SQLQueryplateupd.fieldbyname('status').Asinteger < 49) then
                  Begin
                    Aktshowplate.prevready := 0;
                  end
                  else
                  begin
                    Case DataM1.SQLQueryplateupd.fieldbyname('inkstatus').Asinteger of
                      5 : Begin
                            Aktshowplate.prevready := 1;
                          end;
                      6 : Begin
                            Aktshowplate.prevready := 1;
                          end;
                      9 : Begin
                            Aktshowplate.prevready := 1;
                          end;
                     10 : Begin
                            Aktshowplate.prevready := 2;
                          end;
                     Else
                     Begin
                       Aktshowplate.prevready := 0;
                     end;
                    end;
                  end;
                  if (Prefs.PlateTransmissionSystem) and (Aktshowplate.MasterCopyFlatSeparationSet <> Aktshowplate.CopyFlatSeparationSet ) then
                  begin
                    DataM1.SQLQueryMplateupd.SQL.Clear;
                    DataM1.SQLQueryMplateupd.SQL.add('Select top 1 inkstatus,Flatproofstatus,status,FlatSeparationSet from pagetable (NOLOCK) where CopyFlatSeparationSet = ' + inttostr(Aktshowplate.MasterCopyFlatSeparationSet));
                    DataM1.SQLQueryMplateupd.SQL.add('and colorid = ' + inttostr(colorid));
                    DataM1.SQLQueryMplateupd.open;
                    if Not DataM1.SQLQueryMplateupd.eof then
                    begin
                      AFlatproofstatus := DataM1.SQLQueryMplateupd.fieldbyname('Flatproofstatus').Asinteger;
                      if (AFlatproofstatus = 10) then
                      Begin
                        Afilename := includetrailingbackslash(formmain.getinkfolder(1,tnames1.locationnametoid(formmain.ComboBoxpalocationNY.Text)))+DataM1.SQLQueryMplateupd.fields[3].asstring+'.jpg';
                        Aktprevisready := fileexists(Afilename);
                        Aktshowplate.Softprevready := true;
                        Aktshowplate.prevready := 1;
                      end;
                      Case DataM1.SQLQueryMplateupd.fieldbyname('inkstatus').Asinteger of
                        5 : Begin
                              Aktshowplate.prevready := 1;
                            end;
                        6 : Begin
                              Aktshowplate.prevready := 1;
                            end;
                        9 : Begin
                              Aktshowplate.prevready := 1;
                            end;
                       10 : Begin
                              Aktshowplate.prevready := 2;
                            end;
                       Else
                       Begin
                         Aktshowplate.prevready := 0;
                       end;
                      end;

                    end;
                    DataM1.SQLQueryMplateupd.close;
                  end;
                end;
              end;
              if (Aktshowplate.Inkerror)  then
                Aktshowplate.prevready := 1;
              stackpos          := DataM1.SQLQueryplateupd.fieldbyname('sortingposition').Asstring;
              High              := DataM1.SQLQueryplateupd.fieldbyname('pressHighlow').Asstring;
              if (DataM1.SQLQueryplateupd.fieldbyname('pressCylinder').Asstring <> fronbackstr[0]) and (DataM1.SQLQueryplateupd.fieldbyname('pressCylinder').Asstring <> fronbackstr[1]) then
                Cylinder          := DataM1.SQLQueryplateupd.fieldbyname('pressCylinder').Asstring;
              Zone              := DataM1.SQLQueryplateupd.fieldbyname('pressZone').Asstring;
              Aktshowplate.Zone := DataM1.SQLQueryplateupd.fieldbyname('pressZone').Asstring;
              if (Aktshowplate.Pages[ppos[ippos]].pagetype <> 3) and (active = 1) then
              begin
                if (Approved = 2) then
                  Aktshowplate.Pages[ppos[ippos]].totapproval := 2;
                if (Approved = 0) and (Aktshowplate.Pages[ppos[ippos]].totapproval <> 2) then
                  Aktshowplate.Pages[ppos[ippos]].totapproval := 0;
                if hold = 1 then
                  Aktshowplate.Pages[ppos[ippos]].Anyheld := true;
                if hold = 0 then
                  Aktshowplate.Pages[ppos[ippos]].Anyreleased := true;

              end;
            end;
          end;
        end;
        DataM1.SQLQueryplateupd.next;
      end;
      DataM1.SQLQueryplateupd.close;
      writeMainlogfile('loadAPlate DataM1.SQLQueryplateupd.close ' + inttostr(1));
      if (FlatPageTablePossible) AND (AnyFlatpagetabledata) then
      begin
//        writeMainlogfile('loadAPlate  (FlatPageTablePossible) AND (AnyFlatpagetabledata)' + inttostr(1));
        DataM1.SQLQueryplateupd.sql.Clear; //                0                1       2           3            4        5          6          7              8               9
        DataM1.SQLQueryplateupd.sql.add('Select distinct f.flatseparation,f.side,f.processid,f.processtype,f.event,f.message,f.eventtime,p.copynumber,p.flatseparationset,p.colorid ');
        DataM1.SQLQueryplateupd.sql.add('from FlatPageTable f (NOLOCK),pagetable p (NOLOCK)');
        DataM1.SQLQueryplateupd.sql.add('where ((p.status = 46) or (p.status=49))');
        DataM1.SQLQueryplateupd.sql.add('and p.copyflatseparationset = ' + inttostr(aktshowplate.CopyFlatSeparationSet));
        DataM1.SQLQueryplateupd.sql.add('and f.flatseparation = p.flatseparation');
        DataM1.SQLQueryplateupd.sql.add('order by f.flatseparation');
        if Prefs.debug then datam1.SQLQueryplateupd.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'Getflatpagetablestat.sql');
        DataM1.SQLQueryplateupd.open;
//        writeMainlogfile('loadAPlate  Getflatpagetablestat.sql open' + inttostr(1));
        While not DataM1.SQLQueryplateupd.eof do
        begin
          ICPY := DataM1.SQLQueryplateupd.fields[7].AsInteger;
          ThisColorID := DataM1.SQLQueryplateupd.fields[9].AsInteger;
          begin
            if ICPY > 32 then
              break;
            if Aktshowplate.Copies[ICPY].FlatSeparationSet = DataM1.SQLQueryplateupd.fields[8].AsInteger then
            begin
              For ic := 1 to Aktshowplate.Copies[ICPY].Ncolors do
              begin
                if Aktshowplate.Copies[ICPY].colorstatus[ic].colorid = ThisColorID then
                begin
                  Aktshowplate.Copies[ICPY].colorstatus[ic].Flatpagestatus := DataM1.SQLQueryplateupd.fields[4].AsInteger;
                  break;
                end;
              end;
            end;
          end;
          DataM1.SQLQueryplateupd.next;
        end;
        DataM1.SQLQueryplateupd.close;
      end;
      result := true;
      writeMainlogfile('loadAPlate  Aktshowplate.Npages' + inttostr(Aktshowplate.Npages));
      neededactive := 0;
      Areactive := 0;
      for ip := 1 to Aktshowplate.Npages do
      begin
        if Aktshowplate.pages[ip].pagetype < 2 then
        begin
          Inc(neededactive);
          for ic := 1 to Aktshowplate.pages[ip].Ncolors do
          begin
            if Aktshowplate.pages[ip].colors[ic].active <> 0 then
            begin
              Inc(Areactive);
              break;
            end;
          end;
        end;
      end;
      if Areactive < neededactive then
        result := false;

      writeMainlogfile('loadAPlate  no exception');
    Except
      on E: Exception do
       Begin
         writeMainlogfile('loadAPlate ' + e.Message);
       end;
    end;
  Finally
    DataM1.SQLQueryplateupd.close;
  end;
  writeMainlogfile('loadAPlate end ' + inttostr(0));
end;


function AnyplateInPressrunid(pressrunid : Integer;
                              Seledition : Integer;
                              secselection : Integer):Integer; //-1,0 der er ingen ellers antal plates
Var
  CPYFlats : string;   // Only missing eller eller hide empty Actionplatehideempty eller Actionplateshowmissing
  uniqueCPYsets : String;   // viser kun plader med unique sider  ActionplateHidecommon
  UseCPYFlats : Boolean;
Begin
  writeMainlogfile('Start AnyplateInPressrunid');
  result := -1;
  towerfilter := '';
  if (Formmain.GroupBoxtowerfilter.visible) and (Formmain.ComboBoxplatetowersfilter.itemindex > 0 ) and (Prefs.LimitTowers) then
  begin
    towerfilter := Formtowerfilter.gettowINstring(Formmain.ComboBoxplatetowersfilter.text);
  end;
  UseCPYFlats := false;
  try
    if PlatefilterType = 2 then  // fra gammel checkbox
    begin
      if  (Prefs.debug) then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'plateviewtype2.sql');
      UseCPYFlats := true;
      DataM1.SQLQueryAnyplate.sql.clear;
      DataM1.SQLQueryAnyplate.sql.add('Select distinct p1.Copyflatseparationset');
      DataM1.SQLQueryAnyplate.sql.add('from pagetable P1 (NOLOCK)');
      DataM1.SQLQueryAnyplate.sql.add('where (active = 1)');
      DataM1.SQLQueryAnyplate.sql.add(' and pressrunid = ' + Inttostr(pressrunid));
      if (secselection > -1) and (Seledition  < 0) then
      begin
        DataM1.SQLQueryAnyplate.sql.add('and (Sectionid = ' + inttostr(secselection)+' or pressrunid = ' + inttostr(Pressrunid)+ ')');
      end;
      if towerfilter <> '' then
      begin
        DataM1.SQLQueryAnyplate.sql.add('and p1.presstower IN ('+towerfilter+')' );
      end;
      DataM1.SQLQueryAnyplate.sql.add('and (Uniquepage = 1 or Uniquepage = 2)');
      DataM1.SQLQueryAnyplate.sql.add('and status = 30 and (approved = 1 or approved = -1) and (active = 1) and (PageType<3)');
      DataM1.SQLQueryAnyplate.sql.add('and not exists (');
      DataM1.SQLQueryAnyplate.sql.add('select p3.flatseparation from pagetable p3 (NOLOCK)');
      DataM1.SQLQueryAnyplate.sql.add('where p1.flatseparation = p3.flatseparation and p3.active = 1 and p3.pagetype<3 and (p3.status < 30 or (p3.approved = 2 or p3.approved = 0)  ))');
      DataM1.SQLQueryAnyplate.sql.add('and not exists (');
      DataM1.SQLQueryAnyplate.sql.add('select p4.flatseparationset from pagetable p4 (NOLOCK)');
      DataM1.SQLQueryAnyplate.sql.add('where p1.flatseparationset = p4.flatseparationset and p4.active = 1 and p4.pagetype<3 and ((p4.approved = 2 or p4.approved = 0)  ))');
      DataM1.SQLQueryAnyplate.sql.add('order by p1.copyflatseparationset');
      CPYFlats := '(-22,';
      if Prefs.debug then datam1.SQLQueryAnyplate.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'Nplates1.sql');
      DataM1.SQLQueryAnyplate.open;
      While not DataM1.SQLQueryAnyplate.eof do
      begin
        CPYFlats := CPYFlats + DataM1.SQLQueryAnyplate.fields[0].asstring+',';
        DataM1.SQLQueryAnyplate.next;
      end;
      DataM1.SQLQueryAnyplate.close;
      CPYFlats := CPYFlats +'-99)';
    end;
    if PlatefilterType = 1 then // vis kun de plader som endu ikke er lavet
    begin
      if  (Prefs.debug) then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'plateviewtype1.sql');
      UseCPYFlats := true;
      DataM1.SQLQueryAnyplate.sql.clear;
      DataM1.SQLQueryAnyplate.sql.add('Select distinct p1.Copyflatseparationset');
      DataM1.SQLQueryAnyplate.sql.add('from pagetable P1 (NOLOCK)');
      DataM1.SQLQueryAnyplate.sql.add('where (active = 1) and (PageType<3)');
      DataM1.SQLQueryAnyplate.sql.add(' and pressrunid = ' + Inttostr(pressrunid));
      if (secselection > -1) and (Seledition  < 0) then
      begin
        DataM1.SQLQueryAnyplate.sql.add('and (Sectionid = ' + inttostr(secselection)+' or pressrunid = ' + inttostr(Pressrunid)+ ')');
      end;

      if (Prefs.PlateDoneStatisticsMode > 0) then
      begin
        DataM1.SQLQueryAnyplate.sql.add('and status < 50 or (status = 50 and (externalstatus & 1) = 0');
      end
      else
        DataM1.SQLQueryAnyplate.sql.add('and status < 50 ');
      CPYFlats := '(-22,';
      if towerfilter <> '' then
      begin
        DataM1.SQLQueryAnyplate.sql.add('and p1.presstower IN ('+towerfilter+')' );
      end;
      if Prefs.debug then datam1.SQLQueryAnyplate.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'Nplates2.sql');
      DataM1.SQLQueryAnyplate.open;
      While not DataM1.SQLQueryAnyplate.eof do
      begin
        CPYFlats := CPYFlats + DataM1.SQLQueryAnyplate.fields[0].asstring+',';
        DataM1.SQLQueryAnyplate.next;
      end;
      DataM1.SQLQueryAnyplate.close;
      CPYFlats := CPYFlats +'-99)';
    end;
    if PlatefilterType = 3 then
    begin
      if  (Prefs.debug) then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'plateviewtype3.sql');
      UseCPYFlats := true;
      DataM1.SQLQueryAnyplate.sql.clear;
      DataM1.SQLQueryAnyplate.sql.add('Select distinct p1.Copyflatseparationset');
      DataM1.SQLQueryAnyplate.sql.add('from pagetable P1 (NOLOCK)');
      DataM1.SQLQueryAnyplate.sql.add('where (active = 1) and (pagetype<3)');
      DataM1.SQLQueryAnyplate.sql.add(' and pressrunid = ' + Inttostr(pressrunid));
      if (secselection > -1) and (Seledition  < 0) then
      begin
        DataM1.SQLQueryAnyplate.sql.add('and (Sectionid = ' + inttostr(secselection)+' or pressrunid = ' + inttostr(Pressrunid)+ ')');
      end;
      DataM1.SQLQueryAnyplate.sql.add('and (Uniquepage = 1 or Uniquepage = 2)');
      DataM1.SQLQueryAnyplate.sql.add('and status > 0 ');
      CPYFlats := '(-22,';
      if Prefs.debug then datam1.SQLQueryAnyplate.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'Nplates3.sql');
      if towerfilter <> '' then
      begin
        DataM1.SQLQueryAnyplate.sql.add('and p1.presstower IN ('+towerfilter+')' );
      end;
      DataM1.SQLQueryAnyplate.open;
      While not DataM1.SQLQueryAnyplate.eof do
      begin
        CPYFlats := CPYFlats + DataM1.SQLQueryAnyplate.fields[0].asstring+',';
        DataM1.SQLQueryAnyplate.next;
      end;
      DataM1.SQLQueryAnyplate.close;
      CPYFlats := CPYFlats +'-99)';
    end;

    if formmain.ActionplateHidecommon.checked then // vis kun plader med unique sider
    begin
      uniqueCPYsets := '(-22,';
      DataM1.SQLQueryAnyplate.sql.clear;
      DataM1.SQLQueryAnyplate.sql.add('Select distinct p1.Copyflatseparationset');
      DataM1.SQLQueryAnyplate.sql.add('from pagetable P1 (NOLOCK)');
      DataM1.SQLQueryAnyplate.sql.add('where (active = 1) and (pagetype<3)');
      DataM1.SQLQueryAnyplate.sql.add(' and pressrunid = ' + Inttostr(pressrunid));
      if (secselection > -1) and (Seledition  < 0) then
      begin
        DataM1.SQLQueryAnyplate.sql.add('and (Sectionid = ' + inttostr(secselection)+' or pressrunid = ' + inttostr(Pressrunid)+ ')');
      end;
      DataM1.SQLQueryAnyplate.sql.add('and (Uniquepage = 1 or Uniquepage = 2)');
      uniqueCPYsets := '(-22,';
      if towerfilter <> '' then
      begin
        DataM1.SQLQueryAnyplate.sql.add('and p1.presstower IN ('+towerfilter+')' );
      end;
      if Prefs.debug then datam1.SQLQueryAnyplate.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'Nplates4.sql');
      DataM1.SQLQueryAnyplate.open;
      While not DataM1.SQLQueryAnyplate.eof do
      begin
        uniqueCPYsets := uniqueCPYsets + DataM1.SQLQueryAnyplate.fields[0].asstring+',';
        DataM1.SQLQueryAnyplate.next;
      end;
      DataM1.SQLQueryAnyplate.close;
      uniqueCPYsets := uniqueCPYsets +'-99)';
    end;
    DataM1.SQLQueryAnyplate.sql.clear;
    DataM1.SQLQueryAnyplate.sql.add('Select Distinct copyflatseparationset from pagetable (NOLOCK)');
    DataM1.SQLQueryAnyplate.sql.add('where pressrunid = ' + inttostr(pressrunid));
    DataM1.SQLQueryAnyplate.sql.add('and active = 1 and (pagetype<3)');
    if UseCPYFlats then
      DataM1.SQLQueryAnyplate.sql.add('and copyflatseparationset IN ' + CPYFlats);
    if formmain.ActionplateHidecommon.checked then
      DataM1.SQLQueryAnyplate.sql.add('and copyflatseparationset IN ' + uniqueCPYsets);

    if towerfilter <> '' then
    begin
      DataM1.SQLQueryAnyplate.sql.add('and presstower IN ('+towerfilter+')' );
    end;

    flatStatesets := '(-22,';

    if Prefs.debug then datam1.SQLQueryAnyplate.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'Getflatpages5.sql');
    DataM1.SQLQueryAnyplate.open;
    While Not DataM1.SQLQueryAnyplate.eof do
    begin
      flatStatesets := flatStatesets + DataM1.SQLQueryAnyplate.fields[0].asstring+',';
      DataM1.SQLQueryAnyplate.next;
    end;
    DataM1.SQLQueryAnyplate.close;
    flatStatesets := flatStatesets +'-99)';
    DataM1.SQLQueryAnyplate.sql.clear;
    DataM1.SQLQueryAnyplate.sql.add('Select Count(Distinct Copyflatseparationset) from pagetable (NOLOCK)');
    DataM1.SQLQueryAnyplate.sql.add('where pressrunid = ' + inttostr(pressrunid));
    DataM1.SQLQueryAnyplate.sql.add('and active = 1 and (pagetype<3)');
    DataM1.SQLQueryAnyplate.sql.add('and copyflatseparationset IN ' + flatStatesets);

    if towerfilter <> '' then
    begin
      DataM1.SQLQueryAnyplate.sql.add('and presstower IN ('+towerfilter+')' );
    end;
    if Prefs.debug then datam1.SQLQueryAnyplate.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'Getflatpages6.sql');
    DataM1.SQLQueryAnyplate.Open;
    result := 0;
    if not DataM1.SQLQueryAnyplate.eof then
      result := DataM1.SQLQueryAnyplate.fields[0].asinteger;
    DataM1.SQLQueryAnyplate.Close;
  Except
    writeMainlogfile('Exception in AnyplateInPressrunid');
  end;
end;

function TFPV.Updateplateviewdata:Integer;
Var
  achange : Boolean;
  IPL,icpy,ic,ip : Integer;
// TmpPldat,aktpldat : Integer;
 // Selpublid,productionid,pressid : Integer;
  Tempshowplate : Tshowplate;
//  curplate : Tshowplate;
  Bigchange,loadplatesucces : Boolean;
  //selpubdate : Tdatetime;
//  pressnode,runnode : ttreenode;

begin
  try
    result := 0;
    Bigchange := false;

   // Selpublid := TTreeViewpagestype(runnode.data^).publicationid;
   // selpubdate := TTreeViewpagestype(runnode.data^).pubdate;
   // productionid := TTreeViewpagestype(runnode.data^).productionid;
   // pressid := TTreeViewpagestype(runnode.data^).platetreepressid;
    try
      for IPL := 0 to Nplates -1 do
      begin
      //  Tempshowplate := platesData[ipl];
        if (Prefs.NewPlateDataSystem) then
        begin
          loadplatesucces :=  loadAPlateFromdata(platesData[ipl].CopyFlatSeparationSet,Tempshowplate);
        end
        else
        begin
          loadplatesucces := LoadAPlate(platesData[ipl].CopyFlatSeparationSet,Tempshowplate);
        end;
        if loadplatesucces then
        Begin
          achange := false;
          Tempshowplate.Imageindex := -1;
          if (platesData[ipl].Front <> Tempshowplate.Front) or
             (platesData[ipl].sheetnumber <> Tempshowplate.sheetnumber) then
          begin
            achange := true;
            Bigchange := true;
            platesData[ipl].Changed := false;
            break;
          end;
          if (platesData[ipl].Templatelistid <> Tempshowplate.Templatelistid) then  achange := true;
          if (platesData[ipl].Fullflatlistid <> Tempshowplate.Fullflatlistid) then  achange := true;
          if (platesData[ipl].Flattproofid <> Tempshowplate.Flattproofid) then  achange := true;
          if (Not achange) then
          begin
            For icpy := 1 to Tempshowplate.ncopies do
            begin
              for ic := 1 to Tempshowplate.copies[icpy].Ncolors do
              begin
                if Tempshowplate.copies[icpy].Ncolors <> platesData[ipl].copies[icpy].Ncolors then  achange := true;
                if (platesData[ipl].copies[icpy].deviceid <> Tempshowplate.copies[icpy].deviceid) then  achange := true;
                if not achange then
                begin
                  if (Tempshowplate.copies[icpy].colorstatus[ic].colorid <>
                      platesData[ipl].copies[icpy].colorstatus[ic].colorid) or
                     (Tempshowplate.copies[icpy].colorstatus[ic].status <>
                      platesData[ipl].copies[icpy].colorstatus[ic].status) or
                      (Tempshowplate.copies[icpy].colorstatus[ic].externalstatus <>
                      platesData[ipl].copies[icpy].colorstatus[ic].externalstatus) or
                     (Tempshowplate.copies[icpy].colorstatus[ic].Active <>
                      platesData[ipl].copies[icpy].colorstatus[ic].Active) or
                     (Tempshowplate.copies[icpy].colorstatus[ic].hold <>
                      platesData[ipl].copies[icpy].colorstatus[ic].hold) or
                     (Tempshowplate.copies[icpy].colorstatus[ic].Inkstatus <>
                      platesData[ipl].copies[icpy].colorstatus[ic].Inkstatus)  then
                    Begin
                      achange := true;
                      break;
                    end;
                end;
                if achange then
                  break;
              end;
              if achange then
                break;
            end;
          end;

          if not achange then
          begin
            For ip := 1 to platesData[ipl].NPages do
            begin
              Tempshowplate.Pages[ip].proofed := false;
              For ic := 1 to Tempshowplate.Pages[ip].Ncolors do
              begin
                if (Tempshowplate.Pages[ip].colors[ic].status > 0) and
                   ((Tempshowplate.Pages[ip].colors[ic].Proofstatus = 10) or (Tempshowplate.Pages[ip].colors[ic].Proofstatus = 20)) then
                Begin
                  Tempshowplate.Pages[ip].proofed := true;
                  break;
                end;
              end;

              if (platesData[ipl].Pages[ip].proofed <> Tempshowplate.Pages[ip].proofed) or
                 (platesData[ipl].Pages[ip].CopySeparationSet <> Tempshowplate.Pages[ip].CopySeparationSet) OR
                 (platesData[ipl].Pages[ip].Ncolors <> Tempshowplate.Pages[ip].Ncolors) then
              begin
                achange := true;
                break;
              end
              Else
              begin
                For ic := 1 to platesData[ipl].Pages[ip].Ncolors do
                begin
                  if (platesData[ipl].Pages[ip].colors[ic].colorid <> Tempshowplate.Pages[ip].colors[ic].colorid) or
                     (platesData[ipl].Pages[ip].colors[ic].active <> Tempshowplate.Pages[ip].colors[ic].active) or
                     (platesData[ipl].Pages[ip].colors[ic].Hold <> Tempshowplate.Pages[ip].colors[ic].Hold) or
                     (platesData[ipl].Pages[ip].colors[ic].Approved <> Tempshowplate.Pages[ip].colors[ic].Approved) or
                     (platesData[ipl].Pages[ip].colors[ic].status <> Tempshowplate.Pages[ip].colors[ic].status) then
                  Begin
                    achange := true;
                    break;
                  end;
                end;
              end;
              if achange then
                break;
            end;
          end;

          if achange then
          begin
            result := 1;
            Tempshowplate.Imageindex := platesData[ipl].Imageindex;
            platesData[ipl] := Tempshowplate;
            platesData[ipl].Changed := true;
          end;
          if Bigchange then
          begin
            result := 2;
            break;
          end;
        end
        else
        begin
          Bigchange := true;
          result := 2;
          break;
        end;
      end;
    Except
      result := 2;
    end;
  finally
    if Bigchange then
      result := 2;
  end;
end;

function Updateviews:boolean;
Var
  Iview,Iallruns,iallrunch
  //,itid
  ,ipl,Aplateresult : Integer;
//  NewPlateviewImage : tbitmap;
  Updcount : Integer;
  Bigchange : Boolean;
  Anyplresult : Integer;
  PreviewGUID : String;
begin
  PreviewGUID := '';
  result := true;
  try
    Updcount := 0;
    Bigchange := false;
    if not Formprev2.Showing then
    begin
      For Iallruns := 0 to nallruns-1 do
      begin
        if Not allruns[Iallruns].Isvisible then
        begin
          iallrunch :=  AnyplateInPressrunid(allruns[Iallruns].pressrunid,-1,-1);
          if iallrunch > 0 then
          begin
            Bigchange := true;
          end;
        end;
      end;

      for iview := 0 to Nviews -1 do
      begin
        application.ProcessMessages;
        if Formprev2.Showing then
        begin
          break;
        End
        Else
        Begin
          Anyplresult := AnyplateInPressrunid(Views[iview].pressrunid,Views[iview].Anysecselection,Views[iview].AnySeledition);
          Views[iview].PlateviewImage := tbitmap.Create;

          if Views[iview].Anyplatecalc <> Anyplresult then
          begin
            Bigchange := true;
          end
          Else
          begin
            Views[iview].AnyFlatpagetabledata := false;
            if (FlatPageTablePossible) then
            begin
              DataM1.SQLQueryplateupd.sql.Clear;
              DataM1.SQLQueryplateupd.sql.add('Select top 1 f.processtype,p.productionid ');
              DataM1.SQLQueryplateupd.sql.add('from FlatPageTable f (NOLOCK),pagetable p (NOLOCK)');
              DataM1.SQLQueryplateupd.sql.add('where ((p.status = 46) or (p.status=49))');
              DataM1.SQLQueryplateupd.sql.add('and p.pressrunid = ' + inttostr(Views[iview].pressrunid));
              DataM1.SQLQueryplateupd.sql.add('and f.pressrunid = p.pressrunid');
              DataM1.SQLQueryplateupd.sql.add('order by p.productionid');
              if Prefs.debug then datam1.SQLQueryplateupd.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'Getflatpagetablestat2.sql');
              DataM1.SQLQueryplateupd.open;
              if not DataM1.SQLQueryplateupd.eof then
              begin
                Views[iview].AnyFlatpagetabledata := true;
              end;
              DataM1.SQLQueryplateupd.close;
            end;
            DataM1.SQLQueryplateupd.sql.Clear;
            DataM1.SQLQueryplateupd.sql.add('Select TOP 1 PublicationID,PubDate FROM PageTable (NOLOCK) ');
            DataM1.SQLQueryplateupd.sql.add('WHERE PressRunID = ' + inttostr(Views[iview].pressrunid));
            DataM1.SQLQueryplateupd.open;
            if not DataM1.SQLQueryplateupd.eof then
            begin
              PreviewGUID := inittypes.GeneratePreviewGUID(DataM1.SQLQueryplateupd.fields[0].AsInteger, DataM1.SQLQueryplateupd.fields[1].AsDateTime);
            end;
            DataM1.SQLQueryplateupd.close;
            Case Views[iview].Updateplateviewdata of
              0 : begin
                  end;
              1 : Begin
                    Views[iview].LPV.items.BeginUpdate;
                    for ipl := 0 to Views[iview].nplates - 1 do
                    begin
                      if Formprev2.Showing then
                        break
                      else
                      begin
                        if Views[iview].platesData[ipl].changed then
                        Begin
                          Inc(Updcount);
                          Views[iview].PlateviewImage.Width := Views[iview].IPV.Width;
                          Views[iview].PlateviewImage.Height := Views[iview].IPV.Height;
                          if (Prefs.UseExtendedPlateView) then
                            Aplateresult := Views[iview].makeplateviewimagedeluxe(formmain.ActionplateThumbnails.checked,
                                                                          formmain.ActionnewplanSmallimages.checked,
                                                                          false,Views[iview].platesData[ipl].ImageIndex,PreviewGUID)
                          else
                          Aplateresult := Views[iview].makeplateviewimage(formmain.ActionplateThumbnails.checked,
                                                                          formmain.ActionnewplanSmallimages.checked,
                                                                          false,Views[iview].platesData[ipl].ImageIndex,PreviewGUID);
                          Views[iview].IPV.ReplaceMasked(Views[iview].platesData[ipl].ImageIndex,Views[iview].PlateviewImage,clwhite);
                        end;
                      end;
                    end;
                    Views[iview].LPV.items.EndUpdate;
                  end;
              2 : begin
                    bigchange := true;
                  end;
            end;
          end;
        end;
        Views[iview].PlateviewImage.Free;
        if bigchange then
          break;
      end;
    end;
  finally
    if bigchange then
      result := false;
  end;

end;

Procedure TFPV.setcenterspread;
Begin
  if (Mouseoverpage > -1) then
  begin
    Formmain.changemastertocenterspread(Views[Viewselected].platesData[Views[Viewselected].LPV.Selected.ImageIndex].Pages[Mouseoverpage].MasterCopySeparationSet);
  end;
end;

Procedure TFPV.setSinglepage;
Begin
  if (Mouseoverpage > -1) then
  begin
    Formmain.changemastertoSinglespread(Views[Viewselected].platesData[Views[Viewselected].LPV.Selected.ImageIndex].Pages[Mouseoverpage].MasterCopySeparationSet);
  end;
end;

Function TFPV.makeplateviewimageDeluxe(showthumbnails     : boolean;
                                       small              : boolean;
                                       showinkpreview     : boolean;
                                       platenumber        : Integer;
                                       PreviewGUID        : String):Integer;//0 error 1 ok 2 ok dontproduce
Var
  aktpagetypes : TPageNumbering;

  plateprect : trect;
  bartopoffset,platew,plateh,pagew,pageh : Integer;
  ci,si,sibar : tbitmap;
  ip,ncolors,icolor : Integer;
  tmpl :  TPlatetemplate;
  T: string;
  w,h,tw : Integer;
  dest,source : trect;
  d,s,destd,sourced,thumbrect,dbarrect : trect;
  r6040,sd,r1616,r2010,r3232,r6432,sirect,siver : trect;
  y,pt,pl,x : Integer;
  tmpImage,tmpplim: TBitmap;
  platenametext : string;
  platenametextwidth,plpos,ap : Integer;
  secnametext : string;
  secnametextwidth,secpos : Integer;
  versionnametext : string;
  versionnametextwidth,versionpos : Integer;
  i,porient,PageRotation : Integer;
  isleft,isup : boolean;
  ncolorsW,barheight,Hofext : Integer;
  ImptextY : Integer;
  ThumbFilesok,Thumbok : boolean;
  Smallhold,smallrelease : Boolean;

  ppath : String;
  maxver : Integer;
  pagestatus : array[1..64] of record
                                 proofed  : boolean;
                                 status   : Integer;
                                 maxstatus : Integer;
                                 approved : Integer;
                                 uniquepage : Integer;
                                 version : Integer;
                               end;
  Plate : Tshowplate;
  ic : Integer;
  NEWLINE : BOOLEAN;
  apath : string;
  PlanStyleview : boolean;
  alldummy : boolean;
  anyactive : boolean;
  neededactive ,Areactive : Integer;
  anyunique,anyreceived : boolean;
  ow,oh,PN,Exttop,Extleft : Integer;
  Ncperror,Ncpdone,Icpy,icpcol : Integer;
  Colorstatuss : Array[1..32] of Integer;
  ColorEXTstatuss : Array[1..32] of Integer;
  ColorFlatstatuss : Array[1..32] of Integer;
  fltsetnum : Integer;
  Anyimaging : Boolean;
  Imagingpriktype : Integer;
  Xnum : Integer;
  platethumbR : Trect;
  HaveAplatethumb : Boolean;
  pltextW,pltextH : Integer;
  pltextrec : Trect;
  PageRotationList : TPageNumbering;
  PhonyPanorama :  Array[1..32] of Integer;
  TestPath, TestPath2,testpath3 : String;
  Impospw_tmp, Imposph_tmp : Integer;
  f : Double;
  PlateBackgroundColor : Integer;
  TriangleOffset : Integer;
Begin
  TriangleOffset := 15;
  PlateBackgroundColor := clWebLightgrey;
  result := 0;
  ci := tbitmap.Create;
  si := tbitmap.Create;
  sibar :=tbitmap.Create;
  tmpImage := tbitmap.Create;
  tmpplim := tbitmap.Create;
  For ic := 1 to 32 do Colorstatuss[ic] := 100;
  For ic := 1 to 32 do ColorEXTstatuss[ic] := 100;
  For ic := 1 to 32 do ColorFlatstatuss[ic] := 100;
  For ic := 1 to 32 do PhonyPanorama[ic] := 0;

  try
    r1616.Top := 0;
    r1616.Left := 0;
    r1616.Bottom := 16;
    r1616.Right := 16;
    r6040.Top := 0;
    r6040.Left := 0;
    r6040.Bottom := 40;
    r6040.Right := 60;
    r2010.Top := 0;
    r2010.Left := 0;
    r2010.Bottom := 10;
    r2010.Right := 20;
    r3232.Top := 0;
    r3232.Left := 0;
    r3232.Bottom := 32;
    r3232.Right := 32;
    r6432.Top := 0;
    r6432.Left := 0;
    r6432.Bottom := 32;
    r6432.Right := 64;
    baroffset := 0;
    if (formmain.ActionplateThumbnails.Checked) (*And (foxrmsettings.CheckBoxplatethumb.checked)*) then
    Begin
      baroffset := 0;
    end;
    platesData[platenumber].totstat := 100;
    platesData[platenumber].totappr := 1;
    platesData[platenumber].someerror := false;
    Plate := platesData[platenumber];
    if (Prefs.AllowSelectionOfAnyLayout) then
    begin
      tmpl := PlatetemplateArray[platesData[0].Templatelistid];
    end
    else
      tmpl := PlatetemplateArray[Plate.templatelistid];
    platesData[platenumber].produce := false;
    platesData[platenumber].readytoproduce := true;
    // ### NAN 20151019
    platesData[platenumber].MinOutputVersion := 100;
    alldummy := true;
    anyactive := false;
    for ip := 1 to tmpl.NupOnplate do
    begin
      if plate.pages[ip].pagetype < 3 then
        alldummy := false;
    end;
    platecapaltpage := '';
    platecappagina := '';
    platepanenamescap := '';
    platecappageindex := '';
    LCappagina  := 9999;
    LCappageindex := 9999;
    platesData[platenumber].Anyimaging := false;

    // Determine status colors
    For i := 1 to plate.Copies[1].Ncolors do
    begin
      if plate.Copies[1].colorstatus[i].Active = 1 then
      begin
        Ncpdone := 0;
        Ncperror := 0;
        For icpy := 1 to plate.Ncopies do
        begin
          if plate.Copies[icpy].colorstatus[i].Active = 1 then
          begin
            if ColorEXTstatuss[i] > plate.Copies[icpy].colorstatus[i].externalstatus then
              ColorEXTstatuss[i] := plate.Copies[icpy].colorstatus[i].externalstatus;
            if (Prefs.PlateDoneStatisticsMode) = 1 then
            begin
              if plate.Copies[icpy].colorstatus[i].externalstatus and 2 = 2 then
              begin
                if plate.Copies[icpy].colorstatus[i].status >= 50 then
                  plate.Copies[icpy].colorstatus[i].status := 56;
              end
              Else
              begin
                xnum := plate.Copies[icpy].colorstatus[i].externalstatus and 1;
                if xnum <> 1 then
                  if plate.Copies[icpy].colorstatus[i].status >= 50 then
                    plate.Copies[icpy].colorstatus[i].status := 49;
              end;
            end;
            // ### NAN 20151019
            if (platesData[platenumber].MinOutputVersion > plate.Copies[icpy].colorstatus[i].outputversion) then
               platesData[platenumber].MinOutputVersion := plate.Copies[icpy].colorstatus[i].outputversion;

            if (platesData[platenumber].totstat > plate.Copies[icpy].colorstatus[i].status) and
                        (plate.Copies[icpy].colorstatus[i].Active = 1) then
              platesData[platenumber].totstat := plate.Copies[icpy].colorstatus[i].status;
            if (plate.Copies[icpy].colorstatus[i].status = 16) or
             (plate.Copies[icpy].colorstatus[i].status = 26) or
             (plate.Copies[icpy].colorstatus[i].status = 36) or
             (plate.Copies[icpy].colorstatus[i].status = 46) or
             (plate.Copies[icpy].colorstatus[i].status = 56) then
            Begin
              Colorstatuss[i] := plate.Copies[icpy].colorstatus[i].status;
              platesData[platenumber].someerror := true;
            End
            Else
            Begin
              if (Colorstatuss[i] > plate.Copies[icpy].colorstatus[i].status) and ((Colorstatuss[i] >= 50) or (Colorstatuss[i] <= 30)) then
                Colorstatuss[i] := plate.Copies[icpy].colorstatus[i].status;
              if ((plate.Copies[icpy].colorstatus[i].status  = 45) or (plate.Copies[icpy].colorstatus[i].status  = 49)) and (plate.Copies[icpy].colorstatus[i].active = 1) then
              Begin
                platesData[platenumber].Anyimaging := true;
              end;
              if (plate.Copies[icpy].colorstatus[i].status  < 30) and
                 (plate.Copies[icpy].colorstatus[i].active = 1) then
              Begin
                platesData[platenumber].readytoproduce := false;
              end;
            end;
            if ((Colorstatuss[i] = 46) OR (Colorstatuss[i] = 49)) And (FlatPageTablePossible) then
            begin
              if ColorFlatstatuss[i] <> 156 then
              begin
                if ColorFlatstatuss[i] < plate.Copies[icpy].colorstatus[i].Flatpagestatus then
                  ColorFlatstatuss[i] := plate.Copies[icpy].colorstatus[i].Flatpagestatus;
              end;
              if plate.Copies[icpy].colorstatus[i].Flatpagestatus = 156 then
                ColorFlatstatuss[i] := 156;
            end;
          end;
        end;
      end;
    end;
    // Determine approve,hold etc...
    for ip := 1 to tmpl.NupOnplate do
    begin
      if (plate.pages[ip].pagetype < 2) then
      begin
        platecappagina := platecappagina + inttostr(plate.pages[ip].Pagina)+' ';
        platepanenamescap := platepanenamescap + plate.pages[ip].pagename+' ';
        platecappageindex := platecappageindex + inttostr(plate.pages[ip].pageindex)+' ';
        platecapaltpage := platecapaltpage + plate.pages[ip].Altpagename + ' ';
        if LCappagina > plate.pages[ip].Pagina then
          LCappagina := plate.pages[ip].Pagina;
        if LCappageindex > plate.pages[ip].pageindex then
          LCappageindex := plate.pages[ip].pageindex;
      end;
      if plate.pages[ip].pagetype <> 3 then
      begin
        pagestatus[ip].proofed := false;
        pagestatus[ip].status := 100;
        pagestatus[ip].maxstatus := 0;
        pagestatus[ip].approved := 100;
        pagestatus[ip].version := 0;
        For ic := 1 to plate.pages[ip].ncolors do
        begin
          if (plate.pages[ip].colors[ic].status > pagestatus[ip].maxstatus) then
            pagestatus[ip].maxstatus := plate.pages[ip].colors[ic].status;
          if (plate.pages[ip].colors[ic].version > pagestatus[ip].version) then
            pagestatus[ip].version := plate.pages[ip].colors[ic].version;
          if (plate.pages[ip].colors[ic].status > 0) and
             ((plate.pages[ip].colors[ic].Proofstatus = 10) or (plate.pages[ip].colors[ic].Proofstatus = 20)) then
            pagestatus[ip].proofed := true;
          if plate.pages[ip].colors[ic].Uniquepage > 0 then
              platesData[platenumber].produce := true;
          if plate.pages[ip].colors[ic].active = 1 then
          begin
            if plate.pages[ip].colors[ic].status < pagestatus[ip].status then
            begin
              pagestatus[ip].status := plate.pages[ip].colors[ic].status;
            end;
            if plate.pages[ip].colors[ic].Approved < pagestatus[ip].Approved then
            begin
              pagestatus[ip].Approved := plate.pages[ip].colors[ic].Approved;
            end;
            if plate.pages[ip].colors[ic].Approved = 2 then
              platesData[platenumber].totappr := 2;
            if (plate.pages[ip].colors[ic].Approved = 0) and (platesData[platenumber].totappr <> 2)  then
              platesData[platenumber].totappr := 0;
            if (plate.pages[ip].colors[ic].Approved = -1) and (platesData[platenumber].totappr <> 2) and (platesData[platenumber].totappr <> 0) then
              platesData[platenumber].totappr := -1;
          end;
        end;
      end;
    end;
    if length(platecapaltpage) > 0 then
    begin
      delete(platecapaltpage,length(platecapaltpage),1);
    end;
    if length(platecappagina) > 0 then
    begin
      delete(platecappagina,length(platecappagina),1);
    end;
    if length(platecappageindex) > 0 then
    begin
      delete(platecappageindex,length(platecappageindex),1);
    end;
    if length(platepanenamescap) > 0 then
    begin
      delete(platepanenamescap,length(platepanenamescap),1);
    end;
    neededactive := 0;
    Areactive := 0;
    for ip := 1 to tmpl.NupOnplate do
    begin
      plate.pages[ip].Nocolorisactive := true;
      if plate.pages[ip].pagetype < 2 then
      begin
        Inc(neededactive);
        for ic := 1 to plate.pages[ip].Ncolors do
        begin
          if plate.pages[ip].colors[ic].active <> 0 then
          begin
            plate.pages[ip].Nocolorisactive := false;
            Inc(Areactive);
            break;
          end;
        end;
      End
      Else
        plate.pages[ip].Nocolorisactive := false;
    end;
    if Areactive >= neededactive then
      anyactive := true;
    anyunique := false;
    anyreceived := false;
    for ip := 1 to tmpl.NupOnplate do
    begin
      if plate.pages[ip].UniquePage > 0 then
      begin
        anyunique := true;
      End
    end;
    for ip := 1 to tmpl.NupOnplate do
    begin
      For ic := 0 to plate.pages[ip].Ncolors do
      begin
        if plate.pages[ip].colors[ic].status <> 0 then
        begin
          anyreceived := true;
          break;
        end;
      end;
      if anyreceived then
        break;
    end;
    // ## NAN 20150206
    for ip := 1 to tmpl.NupOnplate do
    begin
       if plate.Front = 0 then
         PageRotationList[ip] := tmpl.PageRotationList[ip]
       else
         PageRotationList[ip] := tmpl.PageRotationBackList[ip];
       if plate.pages[ip].PageRotationOverrule > 0 then
       begin
          if  (plate.pages[ip].PageRotationOverrule) = 8 then
          begin
            PageRotationList[ip] := PageRotationList[ip] + 2;
            if (PageRotationList[ip]>3) then
               PageRotationList[ip] := PageRotationList[ip] - 4;
          end
          else
            PageRotationList[ip] :=    plate.pages[ip].PageRotationOverrule - 1;
       end;
       PhonyPanorama[ip] := 0;
       if (plate.pages[ip].PhonyPanorama > 0)  then
       begin
         PageRotationList[ip] := 1;
         PhonyPanorama[ip] := plate.pages[ip].PhonyPanorama;
       end;
    end;

    ci.Width := 18;
    ci.height := 18;
    sibar.Width := 20;
    sibar.height := 10;
    Si.Width := 60;
    Si.height := 40;
    tmpImage.Width := 13;    //204
    tmpImage.height := 13;   //176
    tmpplim.Width := 16;
    tmpplim.height := 16;
 //   plateprect := makeimagesize(tmpl.PageRotationList,
    plateprect := makeimagesize(PageRotationList,
                                tmpl.IncomingPageRotationEven,
                                tmpl.PagesAcross,
                                tmpl.PagesDown,
                                platew,
                                plateh,
                                pagew,
                                pageh);
    platew := megaplatevidth;               // Overrule with largest size..
    plateh := megaplateheight;
    plateprect := megaplaterect;

    if (plateviewimage.Width <> platew) or (plateviewimage.height <> plateh) then
    Begin
      plateviewimage.Width := platew;    //204
      plateviewimage.height := plateh;   //176
      IPV.clear;
      IPV.Height := plateviewimage.Height;
      IPV.width := plateviewimage.width;
    end;
    plateviewimage.Canvas.Brush.Color := clwhite;
    plateviewimage.Canvas.CopyMode :=  cmSrcCopy;
    // Generate plate background image (colored)
    plateviewimage.Canvas.Pen.Color := clGray;
    if alldummy then
    begin
      PlateBackgroundColor := clWebLightgrey;
   //   plateviewimage.Canvas.Brush.Color := clWebLightgrey;
   //   plateviewimage.Canvas.Rectangle(plateprect);
    end
    else
    begin
      if platesData[platenumber].someerror then
      Begin
        PlateBackgroundColor := clRed;
       // plateviewimage.Canvas.Brush.Color := clRed;
        //plateviewimage.Canvas.Rectangle(plateprect);
      end
      else
      Begin
        if platesData[platenumber].totstat > 49 then
        Begin
           PlateBackgroundColor := clLime;
          //plateviewimage.Canvas.Brush.Color := clLime;
         // plateviewimage.Canvas.Rectangle(plateprect);
        end
        else
        Begin
          if platesData[platenumber].Anyimaging then
          begin
            PlateBackgroundColor := clWebOrange;
            //plateviewimage.Canvas.Brush.Color := clWebDarkOrange;
           // plateviewimage.Canvas.Rectangle(plateprect);
          end
          Else
          Begin
            if not platesData[platenumber].produce then
            Begin
               PlateBackgroundColor := clWebMediumBlue;
              //plateviewimage.Canvas.Brush.Color := clWebMediumBlue ;
             // plateviewimage.Canvas.Rectangle(plateprect);
            end
            else
            Begin
              if platesData[platenumber].readytoproduce and ((platesData[platenumber].totappr = 1) OR (platesData[platenumber].totappr = -1))  then
              Begin
                // ### NAN 20151019 begin
                if (platesdata[platenumber].MinOutputVersion > 0) and (Prefs.IncludeImageOnceState) then
                begin
                   PlateBackgroundColor := clWebKhaki; //clWebAquamarine; // // ;
                   //plateviewimage.Canvas.Brush.Color := clWebAqua;
                  // plateviewimage.Canvas.Rectangle(plateprect);
                end
                else
                begin
                  PlateBackgroundColor := clYellow;
                //   plateviewimage.Canvas.Brush.Color := clYellow;
                 //  plateviewimage.Canvas.Rectangle(plateprect);
                end;
              End
              else
              begin
                PlateBackgroundColor := clWebLightgrey;
               //plateviewimage.Canvas.Brush.Color := clWebLightgrey;
              //  plateviewimage.Canvas.Rectangle(plateprect);
              end;
            end;
          end;
        end;
      end;
    end;
    plateviewimage.Canvas.Brush.Color := PlateBackgroundColor;
    plateviewimage.Canvas.Rectangle(plateprect);
    w := 0;
    h := 1;
    platesData[platenumber].thumbpos.Left := 9999;
    platesData[platenumber].thumbpos.top := 9999;
    platesData[platenumber].thumbpos.bottom := 0;
    platesData[platenumber].thumbpos.right := 0;
    plate.Totstat := platesData[platenumber].totstat;
    if plate.Totstat < 30 then
    begin
      plate.Softprevready := false;
      plate.prevready := 0;
    end;
    for ip := 1 to tmpl.NupOnplate do
    begin
      if Specialplatestanding then
      begin
        inc(w);
        if w > tmpl.PagesDown then
        begin
          inc(h);
          w := 1;
        end;
      end
      else
      begin
        inc(w);
        if w > tmpl.PagesAcross then
        begin
          inc(h);
          w := 1;
        end;
      end;
      platesData[platenumber].Pages[ip].position.Left := (Imposmw*w)+ ((w-1)*Impospw);
      platesData[platenumber].Pages[ip].position.top  := (Imposmh*h)+ (h-1)*Imposph;
      platesData[platenumber].Pages[ip].position.Right := (Imposmw*w)+(w*Impospw);
      platesData[platenumber].Pages[ip].position.Bottom := (Imposmh*h)+(h*Imposph);
      platesData[platenumber].Pages[ip].proofed := pagestatus[ip].proofed;
      plate.pages[ip].position.Left := (Imposmw*w)+ ((w-1)*Impospw);
      plate.pages[ip].position.top  := ((Imposmh*h)+ (h-1)*Imposph)+baroffset;
      plate.pages[ip].position.Right := (Imposmw*w)+(w*Impospw);
      plate.pages[ip].position.Bottom := ((Imposmh*h)+(h*Imposph))+baroffset;
      // ####  NAN Special handling 3-up!!
      if (tmpl.NupOnplate = 3) then
      begin
        f :=  1.25 * Impospw;
        Impospw_tmp := Round(f);
        f :=  1.5 * Imposph;
        Imposph_tmp := Round(f);
        platesData[platenumber].Pages[ip].position.Left := (Imposmw*w)+ ((w-1)*Impospw_tmp);
        platesData[platenumber].Pages[ip].position.top  := (Imposmh*h)+ (h-1)*Imposph_tmp;
        platesData[platenumber].Pages[ip].position.Right := (Imposmw*w)+(w*Impospw_tmp);
        platesData[platenumber].Pages[ip].position.Bottom := (Imposmh*h)+(h*Imposph_tmp);
        platesData[platenumber].Pages[ip].proofed := pagestatus[ip].proofed;
        plate.pages[ip].position.Left := (Imposmw*w)+ ((w-1)*Impospw_tmp);
        plate.pages[ip].position.top  := ((Imposmh*h)+ (h-1)*Imposph_tmp)+baroffset;
        plate.pages[ip].position.Right := (Imposmw*w)+(w*Impospw_tmp);
        plate.pages[ip].position.Bottom := ((Imposmh*h)+(h*Imposph_tmp))+baroffset;
      end;

    if platesData[platenumber].thumbpos.Left > platesData[platenumber].Pages[ip].position.Left then
      platesData[platenumber].thumbpos.Left := platesData[platenumber].Pages[ip].position.Left;
    if platesData[platenumber].thumbpos.top > platesData[platenumber].Pages[ip].position.top then
      platesData[platenumber].thumbpos.top := platesData[platenumber].Pages[ip].position.top;
    if platesData[platenumber].thumbpos.right < platesData[platenumber].Pages[ip].position.right then
      platesData[platenumber].thumbpos.right := platesData[platenumber].Pages[ip].position.right;
    if platesData[platenumber].thumbpos.Bottom < platesData[platenumber].Pages[ip].position.Bottom then
      platesData[platenumber].thumbpos.Bottom := platesData[platenumber].Pages[ip].position.Bottom;

    end;
    plate.thumbpos := platesData[platenumber].thumbpos;
    w := 0;
    h := 1;
    for ip := 1 to tmpl.NupOnplate do
    begin
      inc(w);
      if w > tmpl.PagesAcross then
      begin
        inc(h);
        w := 1;
      end;
      if plate.pages[ip].pagetype = 1 then   // ip=Panorama ap=Antipanorama
      Begin
        for ap := 1 to tmpl.NupOnplate do
        Begin
          aktpagetypes[ap] := plate.pages[ap].pagetype;
        end;
        ap := formmain.Supergetantipos(ip,aktpagetypes,plate.templatelistid,false);
        if ap <> -1 then
        begin
          if plate.pages[ip].position.Left > plate.pages[ap].position.Left then
            plate.pages[ip].position.Left := plate.pages[ap].position.Left;
          if plate.pages[ip].position.right < plate.pages[ap].position.right then
            plate.pages[ip].position.right := plate.pages[ap].position.right;
          if plate.pages[ip].position.top > plate.pages[ap].position.top then
            plate.pages[ip].position.top := plate.pages[ap].position.top;
          if plate.pages[ip].position.bottom < plate.pages[ap].position.bottom then
            plate.pages[ip].position.bottom := plate.pages[ap].position.bottom;
          platesData[platenumber].Pages[ip].position.Left := plate.pages[ip].position.Left;
          platesData[platenumber].Pages[ip].position.top  := plate.pages[ip].position.top;
          platesData[platenumber].Pages[ip].position.Right := plate.pages[ip].position.right;
          platesData[platenumber].Pages[ip].position.Bottom := plate.pages[ip].position.bottom;
          platesData[platenumber].Pages[ip].proofed := pagestatus[ip].proofed;
          platesData[platenumber].Pages[ap].position.Left := -2200;
          platesData[platenumber].Pages[ap].position.top  := -2200;
          platesData[platenumber].Pages[ap].position.Right := -2200;
          platesData[platenumber].Pages[ap].position.Bottom := -2200;
          platesData[platenumber].Pages[ip].proofed := pagestatus[ip].proofed;
        end;
      end;
    end;

    if alldummy then
    begin
      // alt er dummy barg er hvid
      platesData[platenumber].produce := false;
    end
    else
    begin
      //NY thumb p� plateview  totstat
      HaveAplatethumb := false;
      if (showthumbnails) and (Prefs.UsePlateviewThumbnails) then
      begin
        plateviewimage.Canvas.Brush.Color := clskyblue;
        plateviewimage.Canvas.Brush.style := bssolid;
        d.Left := plate.thumbpos.Left;
        d.Top  := plate.thumbpos.top;
        d.Right := plate.thumbpos.right;
        d.Bottom := plate.thumbpos.Bottom;
//        plateviewimage.Canvas.Rectangle(d);
        if (plate.Softprevready) or (plate.prevready > 0)  then
        Begin
          fltsetnum := (plate.CopyFlatSeparationSet*100)+1;

          apath := Formmain.getinkfolder(2,plate.locationID);
          ppath := Formmain.getinkfolder(1,plate.locationID);
          testpath := '';

          if (Prefs.UsePreviewCache) then
            testpath := FormMain.GetInkFolderCache(2)+inttostr(fltsetnum)+'.jpg';
          if ((not Prefs.UsePreviewCache) or (Prefs.UsePreviewCache and not fileexists(testpath))) then
            testpath := Formmain.getinkfolder(2,plate.locationID)+inttostr(fltsetnum)+'.jpg';

          if fileexists(testpath) then
          begin
            formmain.ImageEnIO1.LoadFromFileJpeg(testpath);
            ThumbFilesok := true;
//            plateviewimage.Canvas.CopyMode := cmSrcand;
//            plateviewimage.Canvas.CopyRect(d,tmpplim.Canvas,r1616);

           // d.Left := d.Left;
           // d.top := d.top;
           // d.right := d.right;
           // d.Bottom := d.Bottom;
            platethumbR := d;
            plateviewimage.Canvas.StretchDraw(platethumbR,FormImage.ImageEnViewplatethumb.Bitmap);
            HaveAplatethumb := true;
          end;
        end;

        For ip := 1 to tmpl.NupOnplate do
        begin
          pl := plate.pages[ip].position.Left;
          pt := plate.pages[ip].position.Top;
          plateviewimage.Canvas.Brush.Style := bsClear;
          plateviewimage.Canvas.Font := FormImage.Labelplatetext.Font;
          platenametext := plate.pages[ip].pagename;
          (*if anyactive then
            platenametext := '1' +platenametext
          else
            platenametext := '0' +platenametext;
          *)
          if (Prefs.PlateviewBoldFont) then
            plateviewimage.Canvas.Font.Style := [fsBold]
          else
            plateviewimage.Canvas.Font.Style := [];
          //plateviewimage.Canvas.Font.height := -16;
          plateviewimage.Canvas.Font.height := -10;
          platenametextWidth := plateviewimage.Canvas.TextWidth(platenametext);
          plpos := (Impospw - platenametextWidth) div 2;
          if (tmpl.NupOnplate = 3) then
          begin
            f :=  1.25 * Impospw;
            Impospw_tmp := Round(f);
            plpos := (Impospw - platenametextWidth) div 2;
          end;

        //  plateviewimage.Canvas.Font.Style := [];
  //          plateviewimage.Canvas.Font.height := -12;
          plateviewimage.Canvas.Font.height := -10;
          secnametext := tnames1.SectionIDtoname(plate.pages[ip].SectionID);
          //secnametext := '';
          secnametextWidth := plateviewimage.Canvas.TextWidth(secnametext);
          if secnametextWidth > Impospw then
          Begin
            delete(secnametext,4,100);
            secnametext := secnametext +'...';
            secnametextWidth := plateviewimage.Canvas.TextWidth(secnametext);
          end;
          secpos := (Impospw - secnametextWidth) div 2;
          if (tmpl.NupOnplate = 3) then
          begin
            f :=  1.25 * Impospw;
            Impospw_tmp := Round(f);
            secpos := (Impospw_tmp - secnametextWidth) div 2;
          end;
          secnametextWidth := plateviewimage.Canvas.TextWidth(secnametext);
          if Pressviewzoom <> 50 then
            ImptextY := (Imposph div 4)
          else
            ImptextY := (Imposph div 2);
          if (tmpl.NupOnplate = 3) then
          begin
            f :=  1.50 * Imposph;
            Imposph_tmp := Round(f);
            if Pressviewzoom <> 50 then
              ImptextY := (Imposph_tmp div 4)
            else
              ImptextY := (Imposph_tmp div 2);
          end;
          if (plate.pages[ip].pagetype <> 3) And (plate.pages[ip].pagetype <> 2) then
          Begin
            Case plate.pages[ip].pagetype of
              0..1 : begin
                        y := pt + ImptextY - FormImage.Labelplatetext.Height;
                        Y := y-6;
                        if (Prefs.PlateviewBoldFont) then
                          plateviewimage.Canvas.Font.Style := [fsBold]
                        else
                          plateviewimage.Canvas.Font.Style := [];
                        plateviewimage.Canvas.Font.height := -10;
                        FormImage.Labelplatetext.Font := plateviewimage.Canvas.Font;
                        pltextW := plateviewimage.Canvas.TextWidth(platenametext);
                        pltextrec.Left := (pl+plpos)-5;
                        pltextH := FormImage.Labelplatetext.Height * 2;
                        if plateviewimage.Canvas.TextWidth(secnametext) > pltextW then
                        Begin
                          pltextW := plateviewimage.Canvas.TextWidth(secnametext);
                          pltextrec.Left := (pl+secpos)-5;
                        end;
                        pltextrec.right := pltextrec.Left + pltextW+10;
                        pltextrec.Top := y-1;
                        pltextrec.Bottom := y+pltextH+2;
                        //pltextrec : Trect;

                        plateviewimage.canvas.Pen.Color := clblack;
                        plateviewimage.canvas.Pen.Width := 1;
                        plateviewimage.canvas.brush.Color := clWebLightgrey;
                        //if pltextrec.Right - pltextrec.Left > 32 then
                         // plateviewimage.Canvas.CopyRect(pltextrec,FormImage.Imageplatenumberimagewide.Canvas,r6432)
                       //    plateviewimage.Canvas.Rectangle(r6432)
                       // Else
                         // plateviewimage.Canvas.CopyRect(pltextrec,FormImage.Imageplatenumberimage.Canvas,r3232);
                          plateviewimage.Canvas.Rectangle(pltextrec);
                        plateviewimage.canvas.Pen.Color := clgray;
                        plateviewimage.canvas.brush.Color := clnone;



                        plateviewimage.canvas.brush.style := bsClear;
                        plateviewimage.Canvas.TextOut(pl+plpos,y,platenametext);
                        Inc(y,FormImage.Labelplatetext.Height);
                        plateviewimage.Canvas.TextOut(pl+secpos,y,secnametext);
                        (*
                        //plateviewimage.Canvas.Font.Style := [];
                        //plateviewimage.Canvas.Font.height := -10;
                        //plateviewimage.Canvas.Font.height := -12;
                        *)
                        FormImage.Labelplatetext.Font := plateviewimage.Canvas.Font;
                        Inc(y,FormImage.Labelplatetext.Height);
                      end;
              3     : Begin
                        plateviewimage.Canvas.font.Color := clwhite;
                        y := pt + ImptextY - FormImage.Labelplatetext.Height;
                        plateviewimage.Canvas.TextOut(pl+plpos,y,plate.pages[ip].pagename);
                      end;
              else  begin // den b�r ikke komme her til
                       (*
                        y := pt + ImptextY - Labelplatetext.Height;
                        plateviewimage.Canvas.TextOut(pl+plpos,y,platenametext);
                        Inc(y,Labelplatetext.Height);
                        plateviewimage.Canvas.TextOut(pl+secpos,y,secnametext);
                        Inc(y,Labelplatetext.Height);
                        *)
                      end;

            end;

          End
          else
          begin
          end;
        end;
      end;
      if Not HaveAplatethumb then    //skyblue
      Begin
        w := 0;
        h := 1;
        for ip := 1 to tmpl.NupOnplate do
        begin
          inc(w);
          PN := 0;
          if w > tmpl.PagesAcross then
          begin
            inc(h);
            w := 1;
          end;
          plateviewimage.Canvas.Brush.Color := clwhite;
          plateviewimage.Canvas.pen.Color := clblack;
          if (plate.pages[ip].pagetype <> 3) And (plate.pages[ip].pagetype <> 2) then
          Begin
            if pagestatus[ip].maxstatus >= 30 then
            begin
              plateviewimage.Canvas.Brush.Style := bsSolid;
              plateviewimage.Canvas.Brush.Color := clWebPaleGoldenrod ;
              plateviewimage.Canvas.Pen.Color := clWebDarkGray;
              plateviewimage.Canvas.Pen.Width := 4;

              Case plate.pages[ip].totapproval of
                0 : plateviewimage.Canvas.Pen.Color := clWebDarkGray; //plateviewimage.Canvas.StretchDraw(plate.pages[ip].position,FormImage.Imageplatepagearrived.Picture.Bitmap);
                1 : plateviewimage.Canvas.Pen.Color := clWebLimeGreen ; //plateviewimage.Canvas.StretchDraw(plate.pages[ip].position,FormImage.Imageplatepageapprovedarrived.Picture.Bitmap);
                2 : plateviewimage.Canvas.Pen.Color := clWebCrimson ; //plateviewimage.Canvas.StretchDraw(plate.pages[ip].position,FormImage.Imageplatepagedisapprovedarrived.Picture.Bitmap);
              end;
              plateviewimage.Canvas.Rectangle(plate.pages[ip].position);
            end
            else
            begin
              plateviewimage.Canvas.Brush.Style := bsSolid;
              plateviewimage.Canvas.Brush.Color := clWebWhiteSmoke;
              plateviewimage.Canvas.Pen.Color := clWebDarkGray;
              plateviewimage.Canvas.Pen.Width := 4;

              Case plate.pages[ip].totapproval of
                0 : plateviewimage.Canvas.Pen.Color := clWebDarkGray; //plateviewimage.Canvas.StretchDraw(plate.pages[ip].position,FormImage.Imageplatepagenotarrived.Picture.Bitmap);
                1 : plateviewimage.Canvas.Pen.Color := clWebLimeGreen ; //plateviewimage.Canvas.StretchDraw(plate.pages[ip].position,FormImage.Imageplatepageapprovednotarrived.Picture.Bitmap);
                2 : plateviewimage.Canvas.Pen.Color := clWebCrimson ; //plateviewimage.Canvas.StretchDraw(plate.pages[ip].position,FormImage.Imageplatepagedisapprovednotarrived.Picture.Bitmap);
              end;

              plateviewimage.Canvas.Rectangle(plate.pages[ip].position);
            end;
            plateviewimage.Canvas.Pen.Width := 1;
            if (not Prefs.UsePlateviewThumbnails) and (showthumbnails) then
            begin
              Thumbok := false;
              plateviewimage.Canvas.CopyMode := cmSrccopy;
              if pagestatus[ip].proofed then
              begin
                apath := formmain.GetFileServerPath(PATHTYPE_CCTHUMBNAILS, plate.pages[ip].Fileserver);
                ppath := formmain.GetFileServerPath(PATHTYPE_CCPREVIEWS,plate.pages[ip].Fileserver);
                testpath := '';
                testpath2 := '';

                if (Prefs.UsePreviewCache) then
                  testpath := FormMain.getfileserverpathcached(PATHTYPE_CCTHUMBNAILS) + inttostr(plate.pages[ip].MasterCopySeparationSet)+'.jpg';
                if ((not Prefs.UsePreviewCache) or (Prefs.UsePreviewCache and not fileexists(testpath))) then
                  testpath := apath + inttostr(plate.pages[ip].MasterCopySeparationSet)+'.jpg';


                if (Prefs.UsePreviewCache) then
                  testpath2 := FormMain.getfileserverpathcached(PATHTYPE_CCPREVIEWS) + inttostr(plate.pages[ip].MasterCopySeparationSet)+'.jpg';
                if ((not Prefs.UsePreviewCache) or (Prefs.UsePreviewCache and not fileexists(testpath2))) then
                  testpath2 := ppath + inttostr(plate.pages[ip].MasterCopySeparationSet)+'.jpg';


                ThumbFilesok := false;

                if (Prefs.NewPreviewNames) then
                begin
                  testpath3 := testpath;
                  testpath := '';
                  if (Prefs.UsePreviewCache) then
                    testpath := FormMain.getfileserverpathcached(PATHTYPE_CCTHUMBNAILS) + PreviewGUID + '====' + inttostr(plate.pages[ip].MasterCopySeparationSet)+'.jpg';
                  if ((not Prefs.UsePreviewCache) or (Prefs.UsePreviewCache and not fileexists(testpath))) then
                    testpath := apath + PreviewGUID + '====' + inttostr(plate.pages[ip].MasterCopySeparationSet)+'.jpg';

                  if not fileexists(testpath) then
                    testpath := testpath3;

                  testpath3 := testpath2;
                  testpath2 := '';
                  if (Prefs.UsePreviewCache) then
                    testpath2 := FormMain.getfileserverpathcached(PATHTYPE_CCPREVIEWS) + PreviewGUID + '====' + inttostr(plate.pages[ip].MasterCopySeparationSet)+'.jpg';
                  if ((not Prefs.UsePreviewCache) or (Prefs.UsePreviewCache and not fileexists(testpath2))) then
                    testpath2 := ppath + PreviewGUID + '====' + inttostr(plate.pages[ip].MasterCopySeparationSet)+'.jpg';

                  if not fileexists(testpath2) then
                    testpath2 := testpath3;
                end;


                if (fileexists(testpath)) and (fileexists(testpath2))  then
                Begin
                  ThumbFilesok := true;
                  formmain.ImageEnIO1.LoadFromFileJpeg(testpath);
                End
                else
                Begin
                  ThumbFilesok := false;
                end;
                if ThumbFilesok Then
                begin
                  FormImage.ImageEnViewplatethumb.Refresh;
                  if (Specialplatestanding) OR (Prefs.PlateNoThumbnailRotation) then
                  begin
                  end
                  else
                  begin
                    // ## NAN 20150206
                    //Case tmpl.PageRotationList[ip] of
                    if (PhonyPanorama[ip] = 0) then
                    begin
                      Case PageRotationList[ip] of
                      0 : begin
                          end;
                      1 : begin
                            formmain.ImageEnProcplate.Rotate(270,false);
                          end;
                      2 : begin
                            formmain.ImageEnProcplate.Rotate(180,false);
                          end;
                      3 : begin
                            formmain.ImageEnProcplate.Rotate(90,false);
                          end;
                      end;
                    end;
                    if (PhonyPanorama[ip] = 2) then
                        formmain.ImageEnProcplate.Rotate(180,false);
                  end;
                  //plateviewimage.Canvas.StretchDraw(plate.pagepos[ip],TJPEGImage(Imageplatethumb.picture.Graphic));
                  thumbrect := plate.pages[ip].position;
                  thumbrect.Left := thumbrect.Left+6;
                  thumbrect.top := thumbrect.top+6;
                  thumbrect.bottom := thumbrect.bottom-6;
                  thumbrect.right := thumbrect.right-6;
                  plateviewimage.Canvas.StretchDraw(thumbrect,FormImage.ImageEnViewplatethumb.Bitmap);
                end;
                Thumbok := ThumbFilesok;

       //       plateviewimage.Canvas.StretchDraw(plate.pages[ip].position,Imageplatethumb.Picture.Bitmap);

              end;
            end;
          end;

           // ## NAN 20150206
         // if plate.Front = 0 then
        //   PageRotation := tmpl.PageRotationList[ip]
         // else
         //   PageRotation := tmpl.PageRotationBackList[ip];
          PageRotation := PageRotationList[ip];

          pt := (Imposmh*h)+ (h-1)*Imposph;
          pl := (Imposmw*w)+ ((w-1)*Impospw);
          //pl := (Imposmw*w)+ ((w-1)*Impospw);
          //plate.pages[ip].position
          pl := plate.pages[ip].position.Left;
          pt := plate.pages[ip].position.Top;
          plateviewimage.Canvas.Brush.Style := bsClear;
         // plateviewimage.Canvas.Font := FormImage.Labelplatetext.Font;
          platenametext := plate.pages[ip].pagename;

          if (pagestatus[ip].version > 1) and (Thumbok)  then
            platenametext := plate.pages[ip].pagename + ' V'+ IntToStr(pagestatus[ip].version);

          (*if anyactive then
            platenametext := '1' +platenametext
          else
            platenametext := '0' +platenametext;
          *)
          if Prefs.PlateviewBoldFont then
            plateviewimage.Canvas.Font.Style := [fsBold]
          Else
            plateviewimage.Canvas.Font.Style := [];

          //plateviewimage.Canvas.Font.height := -16;
          plateviewimage.Canvas.Font.height := -10;
          platenametextWidth := plateviewimage.Canvas.TextWidth(platenametext);
          plpos := (Impospw - platenametextWidth) div 2;

          plateviewimage.Canvas.Font.height := -10;
          secnametext := tnames1.sectionIDtoname(plate.pages[ip].SectionID);
          secnametext := '';
          for i := 0 to Length(Prefs.PlateText)-1 do
          begin
            if Prefs.PlateText[i].Enabled then
            Begin
              if secnametext <> '' then
                secnametext := secnametext + ' ';
              if Prefs.PlateText[i].Name = 'Common edition' then
              begin
                secnametext := secnametext + tnames1.EditionIDtoname(plate.pages[ip].OrgeditionID);
              end;
              if Prefs.PlateText[i].Name = 'Section' then
              begin
                secnametext := secnametext + tnames1.sectionIDtoname(plate.pages[ip].SectionID);
              end;
              if Prefs.PlateText[i].Name = 'Alt pagename' then
              begin
                secnametext := secnametext + plate.pages[ip].Altpagename;
              end;
              if Prefs.PlateText[i].Name = 'Zone' then
              begin
                secnametext := secnametext + plate.Zone;
              end;
            end;
          end;
          secnametextWidth := plateviewimage.Canvas.TextWidth(secnametext);
          if secnametextWidth > Impospw then
          begin
            delete(secnametext,4,100);
            secnametext := secnametext + '...';
            secnametextWidth := plateviewimage.Canvas.TextWidth(secnametext);
          end;
          secpos := (Impospw - secnametextWidth) div 2;
          if Pressviewzoom <> 50 then
            ImptextY := (Imposph div 4)
          else
            ImptextY := (Imposph div 2);
          if (pagestatus[ip].version > 1) and (Thumbok)  then
             plateviewimage.Canvas.Font.Color := clFuchsia
          else
             plateviewimage.Canvas.Font.Color := clBlack;
          if (plate.pages[ip].pagetype <> 3) And (plate.pages[ip].pagetype <> 2) then
          Begin
            if ((not showthumbnails) or (Not Thumbok)) or (showthumbnails and (not Prefs.PlateHideNamesOnThumbnails)) then
            begin
              Case plate.pages[ip].pagetype of
                0..1 : begin
                          y := pt + ImptextY - FormImage.Labelplatetext.Height;
                          Y := y-6;
                          if Prefs.PlateviewBoldFont then
                            plateviewimage.Canvas.Font.Style := [fsBold]
                          Else
                            plateviewimage.Canvas.Font.Style := [];
                          plateviewimage.Canvas.Font.height := -10;
                          FormImage.Labelplatetext.Font := plateviewimage.Canvas.Font;
                          if (Prefs.ShowDataOnPlateThumbnails) and (Thumbok) and (showthumbnails) then
                          begin
                            plateviewimage.canvas.Pen.Color := clwhite;
                            plateviewimage.canvas.brush.Color := clblue;
                            pltextW := plateviewimage.Canvas.TextWidth(platenametext);
                            pltextrec.Left := (pl+plpos)-5;
                            pltextH := FormImage.Labelplatetext.Height * 2;
                            if plateviewimage.Canvas.TextWidth(secnametext) > pltextW then
                            Begin
                              pltextW := plateviewimage.Canvas.TextWidth(secnametext);
                              pltextrec.Left := (pl+secpos)-5;
                            end;
                            pltextrec.right := pltextrec.Left + pltextW+10;
                            pltextrec.Top := y-1;
                            pltextrec.Bottom := y+pltextH+2;
                            //pltextrec : Trect;
                            plateviewimage.canvas.Pen.Color := clblack;
                             plateviewimage.canvas.Pen.Width := 1;
                            plateviewimage.canvas.brush.Color := clWebLightgrey;

                            //if pltextrec.Right - pltextrec.Left > 32 then
                             // plateviewimage.Canvas.CopyRect(pltextrec,FormImage.Imageplatenumberimagewide.Canvas,r6432)
                           //    plateviewimage.Canvas.Rectangle(r6432)
                           // Else
                             // plateviewimage.Canvas.CopyRect(pltextrec,FormImage.Imageplatenumberimage.Canvas,r3232);
                              plateviewimage.Canvas.Rectangle(pltextrec);

                            plateviewimage.canvas.Pen.Color := clgray;
                            plateviewimage.canvas.brush.Color := clnone;
                            plateviewimage.canvas.brush.style := bsClear;
                            plateviewimage.Canvas.TextOut(pl+plpos,y,platenametext);
                            Inc(y,FormImage.Labelplatetext.Height);
                            plateviewimage.Canvas.TextOut(pl+secpos,y,secnametext);
                            //ikke her plateviewimage.Canvas.rectangle(pl+plpos-2,y-1,pl+plpos+4+platenametextWidth,y+Labelplatetext.Height);
                          end
                          else
                          begin
                            plateviewimage.Canvas.TextOut(pl+plpos,y,platenametext);
                            Inc(y,FormImage.Labelplatetext.Height);
                            plateviewimage.Canvas.Font.height := -10;
                            //plateviewimage.Canvas.Font.height := -12;
                            plateviewimage.Canvas.TextOut(pl+secpos,y,secnametext);
                            FormImage.Labelplatetext.Font := plateviewimage.Canvas.Font;
                            Inc(y,FormImage.Labelplatetext.Height);
                          end;
                        end;
                3     : Begin
                          plateviewimage.Canvas.font.Color := clwhite;
                          y := pt + ImptextY - FormImage.Labelplatetext.Height;
                          plateviewimage.Canvas.TextOut(pl+plpos,y,plate.pages[ip].pagename);
                        end;
                else  begin // den b�r ikke komme her til
                         (*
                          y := pt + ImptextY - Labelplatetext.Height;
                          plateviewimage.Canvas.TextOut(pl+plpos,y,platenametext);
                          Inc(y,Labelplatetext.Height);
                          plateviewimage.Canvas.TextOut(pl+secpos,y,secnametext);
                          Inc(y,Labelplatetext.Height);
                          *)
                        end;

              end;
            end;
          End
          else
          begin
          end;
          plateviewimage.Canvas.Font.Color := clBlack;
          if (Prefs.PlateviewBoldFont) then
            plateviewimage.Canvas.Font.Style := [fsBold]
          Else
            plateviewimage.Canvas.Font.Style := [];
          plateviewimage.Canvas.Font.height := -10;
          //plateviewimage.Canvas.Font.height := -12;
          if ( (showthumbnails) or (Not Thumbok) or (Prefs.ShowDataOnPlateThumbnails) ) and
             (Pressviewzoom <> 50) then
          begin
            if (plate.pages[ip].pagetype <> 2) and (plate.pages[ip].pagetype <> 3) and (plate.pages[ip].pagetype <> -1)then
            Begin
              ncolors := plate.pages[ip].Ncolors;
              ncolorsW := (20 * (ncolors-1))+18;
              ci.Canvas.CopyMode := cmSrcAnd;
              icolor := 0;
              d.top := 0;
              d.Left := 0;
              d.Right := 18;
              d.bottom := 18;
              s := d;
              x := 0;
              NEWLINE := FALSE;
              si.Canvas.StretchDraw(r6040,FormImage.Imagestatusbox.Picture.Bitmap);
              barheight := 36 div plate.pages[ip].Ncolors;
              if barheight > 36 div 4 then
                barheight := 36 div 4;
              Hofext := barheight;
              bartopoffset := (38 - (barheight * plate.pages[ip].Ncolors)) div 2;
              Inc(bartopoffset);
              sibar.Width := 19;
              sibar.height := barheight;
              sirect.Top := 0;
              sirect.Left := 0;
              sirect.Right := 19;
              sirect.bottom := barheight;
              siver.Top := 0;
              siver.Left := 0;
              siver.Right := 9;
              siver.bottom := barheight;
              For ic := 1 to plate.pages[ip].Ncolors do
              begin
                if Impospw > Imposph then
                Begin
                  d.top := y;
                  d.Left := plate.pages[ip].position.Left + 6;
                  d.Right := d.Left + 60;
                  d.bottom := y+40;
                End
                else
                begin
                  d.top := y;
                  d.Left := plate.pages[ip].position.Left + 8;
                  d.Right := d.Left + 60;
                  d.bottom := y+40;
                end;
                //ci.canvas.Brush.color := Colorsnames[plate.pages[ip].colors[ic].colorid].Colorlook;
                //ci.canvas.pen.color := Colorsnames[plate.pages[ip].colors[ic].colorid].Colorlook;
                si.canvas.Brush.color := Colorsnames[plate.pages[ip].colors[ic].colorid].Colorlook;
                si.canvas.pen.color := Colorsnames[plate.pages[ip].colors[ic].colorid].Colorlook;
                dbarrect.top := bartopoffset + (barheight* (ic-1));
                dbarrect.bottom := bartopoffset + (barheight* ic);
                if plate.pages[ip].colors[ic].active=1 then
                begin
                  if plate.pages[ip].colors[ic].status = 0 then
                  Begin
                    dbarrect.left := 1;
                    dbarrect.right := 20;
                    si.canvas.pen.color := clGray;
                    si.Canvas.Rectangle(dbarrect);
                  end;

                  if (plate.pages[ip].colors[ic].status > 0) and (Colorstatuss[ic] <= 30) then
                  Begin
                    dbarrect.left := 1;
                    dbarrect.right := 20;
                    si.canvas.pen.color := clGray;
                    si.Canvas.Rectangle(dbarrect);
                    dbarrect.left := 21;
                    dbarrect.right := 40;
                    si.canvas.pen.color := clGray;
                    si.Canvas.Rectangle(dbarrect);
                  end;
                  if (Colorstatuss[ic] > 30) and (Colorstatuss[ic] < 50) then
                  Begin
                    dbarrect.left := 1;
                    dbarrect.right := 20;
                    si.canvas.pen.color := clGray;
                    si.Canvas.Rectangle(dbarrect);
                    dbarrect.left := 21;
                    dbarrect.right := 40;
                    si.canvas.pen.color := clGray;
                    si.Canvas.Rectangle(dbarrect);

                    Imagingpriktype := 0;
                    if (Colorstatuss[ic] = 36) or (Colorstatuss[ic] = 46) then
                    Begin
                      Imagingpriktype := 4;  // hel r�d
                      if FlatPageTablePossible then
                      begin
                        if ColorFlatstatuss[ic] = 156 then
                          Imagingpriktype := 3; // halv r�d
                      end;
                    End
                    else
                    Begin
                      Imagingpriktype := 1;  // normal gr�n prik    'Imaging'
                      if FlatPageTablePossible then
                      begin
                        Case ColorFlatstatuss[ic] of
                          158 : Imagingpriktype := 2; // halv bl�
                          159 : Imagingpriktype := 2; // halv bl�
                          156 : Imagingpriktype := 3; // halv r�d
                        end;
                      end;
                    end;
                    sibar.canvas.pen.color := clGray;
                    sibar.canvas.brush.color := clGray;
                    sibar.Canvas.Rectangle(sirect);
                    if (Imagingpriktype > 0) then
                    begin
                      Case Imagingpriktype of
                        1 : sibar.canvas.brush.color := clWebOrange; //clLime;        imaging
                        2 : sibar.canvas.brush.color := clLime;        // Sent to device
                        3 : sibar.canvas.brush.color := clWebDarkOrange;  // some other error
                        4 : sibar.canvas.brush.color := clRed;            // imaging error
                      end;
                      if (barheight <= 19)  then
                        sibar.Canvas.Ellipse((19 - barheight) div 2,0,barheight + (19 - barheight) div 2,barheight)
                      else
                        sibar.Canvas.Ellipse(0,(barheight-19) div 2,barheight ,19+(barheight-19) div 2);

                      si.Canvas.CopyMode := cmSrcand;
                      dbarrect.left := 41;
                      dbarrect.right := 59;
                      si.Canvas.CopyRect(dbarrect,sibar.Canvas,sirect);
                    end;
                  end;
                  if (Colorstatuss[ic] >= 50) then
                  Begin
                      dbarrect.left := 1;
                      dbarrect.right := 20;
                      si.canvas.pen.color := clGray;
                      si.Canvas.Rectangle(dbarrect);
                      dbarrect.left := 21;
                      dbarrect.right := 40;
                      si.canvas.pen.color := clGray;
                      si.Canvas.Rectangle(dbarrect);
                      dbarrect.left := 41;
                      dbarrect.right := 59;
                      si.canvas.pen.color := clGray;
                      si.Canvas.Rectangle(dbarrect);
                  end;
                  if (Prefs.PlateShowExternalStatus) And (Prefs.PlateDoneStatisticsMode > 0) then
                  begin
                   // dbarrect.left := 41;
                   // dbarrect.right := 59;           dsds
                    si.canvas.Brush.Color := externalstatusarray[ColorEXTstatuss[ic]].color;
                    si.canvas.pen.Color := clblack;
                    Exttop := bartopoffset + (barheight* (ic-1));
                    Extleft := 30-(Hofext div 2);
                    si.canvas.Ellipse(Extleft,Exttop,Extleft+Hofext,Exttop+Hofext);
                  end;
                  if (plate.pages[ip].colors[ic].version > 1)  then
                  begin
                    (*
                    si.Canvas.Brush.Style := bssolid;
                    si.Canvas.Brush.color := clwhite;
                    si.Canvas.pen.color := clwhite;
                    siver.left := 0;
                    siver.Top := 0;
                    siver.right := 19;
                    siver.Bottom := barheight;
                    *)
                    si.Canvas.Brush.Style := bsClear;
                    //si.Canvas.pen.color := clwhite;
                    si.Canvas.Font := FormImage.Labelplatever.Font;
                    dbarrect.left := 1;
                    dbarrect.right := 20;
                    if Colorsnames[plate.pages[ip].colors[ic].colorid].K = 100 then
                      si.Canvas.Font.color := clwhite
                    Else
                      si.Canvas.Font.color := clblack;
                    si.Canvas.Font.Size := si.Canvas.Font.Size - 1;
                    si.Canvas.TextRect(dbarrect,dbarrect.Left + 2,dbarrect.Top - 1,'V '+inttostr(plate.pages[ip].colors[ic].version));
                  end;

                end;
                if (not showthumbnails) or (Not Thumbok) then
                Begin
                  plateviewimage.Canvas.CopyMode := cmSrcCopy;
                  plateviewimage.Canvas.CopyRect(d,si.Canvas,r6040);
                end;
                inc(icolor);
              end;
              if (not showthumbnails) or (Not Thumbok) then
              Begin
                if Impospw > Imposph then
                begin
                  d.left := d.right + 4;//+ 2;
                  d.right := d.Left + 16;
                  d.top := d.top+2;
                  d.bottom := d.top+16;
                end
                else
                begin
                  d.left := d.left + 2;
                  d.right := d.Left + 16;
                  d.top := d.bottom+2;
                  d.bottom := d.top+16;
                end;
                tmpplim.Canvas.Brush.Color := clwhite;
                tmpplim.Canvas.pen.Color := clwhite;
                tmpplim.Canvas.Rectangle(r1616);
  //              tmpplim.Canvas.CopyRect(r1616,FormImage.Imagecolorbrg1616.Canvas,r1616);

                if (plate.pages[ip].Anyheld) And (plate.pages[ip].Anyreleased) then
                Begin
                  FormImage.ImageListStatus.GetBitmap(31, tmpplim);
                end;
                if (plate.pages[ip].Anyheld) And (Not plate.pages[ip].Anyreleased) then
                Begin
                  FormImage.ImageListStatus.GetBitmap(33, tmpplim);
                end;
                if (Not plate.pages[ip].Anyheld) And (plate.pages[ip].Anyreleased) then
                Begin
                  FormImage.ImageListStatus.GetBitmap(32, tmpplim);
                end;
                plateviewimage.Canvas.CopyMode := cmSrcand;
                plateviewimage.Canvas.CopyRect(d,tmpplim.Canvas,r1616);
                plateviewimage.Canvas.CopyMode := cmSrcCopy;

                if Impospw > Imposph then
                begin
                  d.top := d.top +18;
                  d.bottom := d.top+16;
                end
                else
                begin
                  d.left := d.left + 20; //+18;
                  d.right := d.Left + 16;
                end;
                tmpplim.Canvas.Brush.Color := clwhite;
                tmpplim.Canvas.pen.Color := clwhite;
                tmpplim.Canvas.Rectangle(r1616);
              //  tmpplim.Canvas.CopyRect(r1616,FormImage.Imagecolorbrg1616.Canvas,r1616);
                Case plate.pages[ip].UniquePage of
                  0 : FormImage.ImageListStatus.GetBitmap(25, tmpplim);
                  1 : FormImage.ImageListStatus.GetBitmap(26, tmpplim);
                  2 : FormImage.ImageListStatus.GetBitmap(29, tmpplim);
                end;

                plateviewimage.Canvas.CopyMode := cmSrcand;
                plateviewimage.Canvas.CopyRect(d,tmpplim.Canvas,r1616);
                if (plate.Softprevready) or (plate.prevready > 0) or (plate.InkError) then
                Begin
                  d.left := d.left + 20; //+18;
                  d.right := d.Left + 16;
                  tmpplim.Canvas.Brush.Color := clwhite;
                  tmpplim.Canvas.pen.Color := clwhite;
                  tmpplim.Canvas.Rectangle(r1616);
              //    tmpplim.Canvas.CopyRect(r1616,FormImage.Imagecolorbrg1616.Canvas,r1616);
                  if plate.Softprevready then
                  begin
                    FormImage.ImageListStatus.GetBitmap(30, tmpplim);
                  end;
                  if plate.InkError then
                  Begin
                    Case plate.prevready of
                      1 : FormImage.ImageListStatus.GetBitmap(36, tmpplim);
                      2 : FormImage.ImageListStatus.GetBitmap(30, tmpplim);
                    end;
                  End
                  else
                  Begin
                    Case plate.prevready of
                      1 : FormImage.ImageListStatus.GetBitmap(35, tmpplim);
                      2 : FormImage.ImageListStatus.GetBitmap(30, tmpplim);
                    end;
                  end;
                  plateviewimage.Canvas.CopyMode := cmSrcand;
                  plateviewimage.Canvas.CopyRect(d,tmpplim.Canvas,r1616);
                end;
              end;
              plateviewimage.Canvas.CopyMode := cmSrcCopy;
            end;
            //plateviewimage.Canvas.Brush.Style := bssolid;
        end;

        porient := 0;
        Case PageRotation of
          0 : Begin
                if ip mod 2 = 1 then
                   porient := 1
                 Else
                   porient := 2;
              end;
          1 : begin
                if h mod 2 = 1 then
                  porient := 2
                else
                  porient := 3;
              end;
          2 : Begin
                if ip mod 2 = 1 then
                   porient := 4
                 Else
                   porient := 3;
              end;
          3 : begin
                if h mod 2 = 1 then
                  porient := 1
                else
                  porient := 4;
              end;
        end;
        if not Specialplatestanding then
        begin
          if (plate.pages[ip].pagetype <> 3) and (plate.pages[ip].pagetype <> 2) then
          Begin
            Sourced.Top := 0;
            Sourced.left := 0;
            Sourced.Right := TriangleOffset-1;
            Sourced.bottom := TriangleOffset-1;
            destd := plate.pages[ip].position;
            Case porient of
              1 : begin  // top left
                  //  FormImage.ImageListdonk.GetBitmap(2, tmpImage);
                    FormImage.ImageListDonkeyears.GetBitmap(GetTriangleImageNumber(PlateBackgroundColor,porient), tmpImage);
                    destd.left := destd.left - 2;
                    destd.top := destd.top - 2;
                    destd.Right := destd.left + TriangleOffset;
                    destd.bottom := destd.top + TriangleOffset;
                    plateviewimage.Canvas.CopyRect(Destd, tmpImage.Canvas,Sourced);
                  end;
              2 : begin  // top right
                    FormImage.ImageListdonk.GetBitmap(0, tmpImage);
                    FormImage.ImageListDonkeyears.GetBitmap(GetTriangleImageNumber(PlateBackgroundColor,porient), tmpImage);
                    destd.Right := destd.Right + 2;
                    destd.top := destd.top - 2;
                    destd.left := destd.Right - TriangleOffset;
                    destd.bottom := destd.top + TriangleOffset;
                    plateviewimage.Canvas.CopyRect(Destd, tmpImage.Canvas,Sourced);
                  end;
              3 : begin  // bottom right
                    FormImage.ImageListdonk.GetBitmap(1, tmpImage);
                    FormImage.ImageListDonkeyears.GetBitmap(GetTriangleImageNumber(PlateBackgroundColor,porient), tmpImage);
                    destd.Right := destd.Right + 2;
                    destd.bottom := destd.bottom + 2;
                    destd.left := destd.Right - TriangleOffset;
                    destd.top := destd.bottom - TriangleOffset;
                    plateviewimage.Canvas.CopyRect(Destd, tmpImage.Canvas,Sourced);
                  end;
              4 : begin  // bottom left
                    FormImage.ImageListdonk.GetBitmap(3, tmpImage);
                    FormImage.ImageListDonkeyears.GetBitmap(GetTriangleImageNumber(PlateBackgroundColor,porient), tmpImage);
                    destd.left := destd.left - 2;
                    destd.bottom := destd.bottom + 2;
                    destd.Right := destd.left + TriangleOffset;
                    destd.top := destd.bottom - TriangleOffset ;

                    plateviewimage.Canvas.CopyRect(Destd, tmpImage.Canvas,Sourced);
                  end;
                else
                begin
                end;
              end;
            end;
          end;
        end;
(*
        T := tmpl.TemplateName;
        tw := plateviewimage.Canvas.TextWidth(T);
        plateviewimage.Canvas.Brush.Style := bsClear;
        plateviewimage.Canvas.TextOut((plateviewimage.Width div 2)- (tw div 2),plateviewimage.Height-Labelplatetext.Height-4,T);
  *)
        plateviewimage.Canvas.Brush.Style := bssolid;
      end;
       Smallhold     := false;
        smallrelease  := false;
        For ip := 1 to tmpl.NupOnplate do
        begin
          if plate.pages[ip].Anyreleased then
            smallrelease := true;
          if plate.pages[ip].Anyheld then
            smallhold := true;
        end;

      if (Pressviewzoom = 50) then
      Begin
        d.left := (plateviewimage.Width div 2)-8;
        d.right := d.Left + 16;
        d.top := 4;
        d.bottom := d.top+16;
        tmpplim.Canvas.Brush.Color := clwhite;
        tmpplim.Canvas.pen.Color := clwhite;
        tmpplim.Canvas.Rectangle(r1616);
        tmpplim.Canvas.CopyRect(r1616,FormImage.Imagecolorbrg1616.Canvas,r1616);
         if (Smallhold) And (smallrelease) then
        Begin
          FormImage.ImageListStatus.GetBitmap(31, tmpplim);
        end;
        if (Smallhold) And (Not smallrelease) then
        Begin
          FormImage.ImageListStatus.GetBitmap(33, tmpplim);
        end;
        if (Not Smallhold) And (smallrelease) then
        Begin
          FormImage.ImageListStatus.GetBitmap(32, tmpplim);
        end;


        plateviewimage.Canvas.CopyMode := cmSrcCopy;
        plateviewimage.Canvas.CopyRect(d,tmpplim.Canvas,r1616);
        plateviewimage.Canvas.CopyMode := cmSrcCopy;
      End
      else
      Begin
        if (showthumbnails) then
        begin
          d.left := Imposmw;
          d.right := d.Left + 16;
          d.bottom := plateviewimage.Height - 4;
          d.top := d.bottom - 16;
          tmpplim.Canvas.Brush.Color := clwhite;
          tmpplim.Canvas.pen.Color := clwhite;
          tmpplim.Canvas.Rectangle(r1616);
        //  tmpplim.Canvas.CopyRect(r1616,FormImage.Imagecolorbrg1616.Canvas,r1616);
          if (Smallhold) And (smallrelease) then
          Begin
            FormImage.ImageListStatus.GetBitmap(31, tmpplim);
          end;
          if (Smallhold) And (Not smallrelease) then
          Begin
            FormImage.ImageListStatus.GetBitmap(33, tmpplim);
          end;
          if (Not Smallhold) And (smallrelease) then
          Begin
            FormImage.ImageListStatus.GetBitmap(32, tmpplim);
          end;
          plateviewimage.Canvas.CopyMode := cmSrcCopy;
          plateviewimage.Canvas.CopyRect(d,tmpplim.Canvas,r1616);
          plateviewimage.Canvas.CopyMode := cmSrcCopy;
        end;
      end;

      plateviewimage.Canvas.Brush.Style := bssolid;

      d.Top := plateviewimage.Height-44;
      d.Left := 4;
      d.Right := plateviewimage.Width-4;
      d.Bottom := d.Top+41;

      plateviewimage.Canvas.Brush.Style := bssolid;
      plateviewimage.Canvas.pen.Color := clblack;
      //plateviewimage.Canvas.Rectangle(d);
      ow  := (d.right - d.left) DIV plate.Copies[1].Ncolors;
      if ow > 32 then
        ow := 32;
      d.left := (plateviewimage.Width - (ow*plate.Copies[1].Ncolors )) div 2;
      d.Right := d.Left + (plate.Copies[1].Ncolors * ow);
      destd.Top := d.Top+1;
      destd.Bottom := d.Bottom-1;
      oh := ((destd.Bottom-destd.Top)-10) div plate.Ncopies;
      sibar.Width := ow;
      sibar.Height := destd.Bottom-destd.top;
      Sourced.Top := 0;
      Sourced.left := 0;
      Sourced.Right := ow;
      Sourced.bottom := destd.Bottom-destd.top;

      if (not Prefs.HidePlateCopyBar) then
      begin
        For i := 1 to plate.Copies[1].Ncolors do
        begin
          if plate.Copies[1].colorstatus[i].Active = 1 then
          begin
            destd.Left := d.Left + (ow * (i-1));
            destd.Right := destd.Left+ow;
            plateviewimage.Canvas.pen.Color := Clwhite;
            plateviewimage.Canvas.Brush.Color := Clwhite;
            plateviewimage.Canvas.Rectangle(destd);
            Ncpdone := 0;
            Ncperror := 0;
            For icpy := 1 to plate.Ncopies do
            begin
              if plate.Copies[icpy].colorstatus[i].Active = 1 then
              begin
                if (plate.Copies[icpy].colorstatus[i].status >= 50) and
                   (plate.Copies[icpy].colorstatus[i].status <> 56) then
                begin
                  Inc(Ncpdone);
                end;
                if (plate.Copies[icpy].colorstatus[i].status = 56) then
                Begin
                  Inc(Ncperror);
                end;
              end;
            end;
            destd.Bottom := d.Bottom-1;
            destd.Top := d.Top+1;
            plateviewimage.Canvas.pen.Color := clGray;
            plateviewimage.Canvas.Brush.Color := Colorsnames[plate.Copies[1].colorstatus[i].colorid].Colorlook;
            plateviewimage.Canvas.Rectangle(destd);

            plateviewimage.Canvas.pen.Color := Clblack;
            // ## 20150422 NAN
            plateviewimage.Canvas.Brush.Color :=  externalstatusarray[ColorEXTstatuss[i]].color; // Clwhite;
            destd.Bottom := destd.top + 15;
            plateviewimage.Canvas.Rectangle(destd);
            w := (ow - plateviewimage.Canvas.TextWidth(inttostr(Ncpdone))) Div 2;
            plateviewimage.Canvas.Brush.Style := bsClear;
            plateviewimage.Canvas.TextOut(destd.Left+ w ,destd.Top,inttostr(Ncpdone));
            plateviewimage.Canvas.Brush.Style := bssolid;
            // ## 20150422 NAN
            if (Ncpdone = plate.Ncopies) then
              plateviewimage.Canvas.Brush.Color :=  externalstatusarray[ColorEXTstatuss[i]].color; // Clwhite;
            Inc(destd.top,14);
            destd.Bottom := destd.top + 15;
            plateviewimage.Canvas.Rectangle(destd);
            w := (ow - plateviewimage.Canvas.TextWidth(inttostr(plate.Ncopies))) Div 2;
            plateviewimage.Canvas.Brush.Style := bsClear;
            plateviewimage.Canvas.TextOut(destd.Left+ w ,destd.Top,inttostr(plate.Ncopies));
            plateviewimage.Canvas.Brush.Style := bssolid;
          end;
        end;
      End;
      d.Top := 0;
      d.Left := 0;
      d.Right := plateviewimage.Width;
      d.Bottom := plateviewimage.Height;
    end;
    if platesData[platenumber].produce then
    begin
      result := 1;
      if formmain.ActionplateHidecommon.checked then
      begin
        if not anyunique then
          result := 2;
      end;
      if PlatefilterType = 3 then
      begin
        if not anyreceived then
          result := 2;
      end;
    end
    else
      result := 2;
    if not anyactive then
    begin
      result := 0;
    end;
  Except
  end;
  //  plateviewimage.Free;
  sibar.Free;
  si.free;
  ci.free;
  tmpImage.free;
  tmpplim.Free;
end;
// Determine largest plate image size for pressrun
Procedure TFPV.Getmegasize(pressrunid : Integer);
var
  arect : Trect;
  Atmpl : TPlatetemplate;
  Atemplatelistid,Aplatew,Aplateh,Apagew,Apageh : Integer;
Begin
  try
    megaplatevidth := -1;
    megaplateheight := -1;
    megapagevidth := -1;
    megapageheight := -1;
    Aplatew := -1;
    Aplateh  := -1;
    Apagew  := -1;
    Apageh  := -1;
    DataM1.SQLQueryAnyplate.sql.clear;
    DataM1.SQLQueryAnyplate.sql.add('Select distinct templateid from pagetable (NOLOCK)');
    DataM1.SQLQueryAnyplate.sql.add('where pressrunid = ' + inttostr(pressrunid));
    DataM1.SQLQueryAnyplate.sql.add('and copynumber = 1 ');
    DataM1.SQLQueryAnyplate.open;
    While not DataM1.SQLQueryAnyplate.eof do
    begin
      Atemplatelistid := -1;
      Atemplatelistid := inittypes.gettemplatelistnumberfromdbID(DataM1.SQLQueryAnyplate.FieldByName('TemplateID').asinteger);
      Atmpl := PlatetemplateArray[Atemplatelistid];
      arect := makeImagesize(Atmpl.PageRotationList,
                             Atmpl.IncomingPageRotationEven,
                             Atmpl.PagesAcross,
                             Atmpl.PagesDown,
                             Aplatew,
                             Aplateh,
                             Apagew,
                             Apageh);
      if megaplatevidth < Aplatew then
        megaplatevidth := Aplatew;
      if megaplateheight < Aplateh then
        megaplateheight := Aplateh;
      if megapagevidth < Apagew then
        megapagevidth := Apagew;
      if megapageheight < Apageh then
        megapageheight := Apageh;
      DataM1.SQLQueryAnyplate.next;
    end;
    DataM1.SQLQueryAnyplate.close;
    megaplaterect := rect(0,0,megaplatevidth,megaplateheight);
  except
  end;
end;

Function TFPV.makeplateviewimage(showthumbnails     : boolean;
                                 small              : boolean;
                                 showinkpreview     : boolean;
                                 platenumber        : Integer;
                                 PreviewGUID        : String):Integer;//0 error 1 ok 2 ok dontproduce
Var
  aktpagetypes : TPageNumbering;

  plateprect : trect;
  bartopoffset,platew,plateh,pagew,pageh : Integer;
  ci,si,sibar : tbitmap;
  ip,ncolors,icolor : Integer;
  tmpl :  TPlatetemplate;
  T: string;
  w,h,tw : Integer;
  dest,source : trect;
  d,s,destd,sourced,thumbrect,dbarrect : trect;
  r6040,sd,r1616,r2010,r3232,r6432,sirect,siver : trect;
  y,pt,pl,x : Integer;
  tmpImage,tmpplim: TBitmap;
  platenametext : string;
  platenametextwidth,plpos,ap : Integer;
  secnametext : string;
  secnametextwidth,secpos : Integer;
  i,porient,PageRotation : Integer;
  isleft,isup : boolean;
  ncolorsW,barheight,Hofext : Integer;
  ImptextY : Integer;
  ThumbFilesok,Thumbok : boolean;
  Smallhold,smallrelease : Boolean;
  SignaturePageNumber : Integer;
  ppath : String;
  maxver : Integer;
  pagestatus : array[1..64] of record
                                 proofed  : boolean;
                                 status   : Integer;
                                 maxstatus : Integer;
                                 approved : Integer;
                                 uniquepage : Integer;
                               end;
  Plate : Tshowplate;
  ic : Integer;
  NEWLINE : BOOLEAN;
  apath : string;
  PlanStyleview : boolean;
  alldummy : boolean;
  anyactive : boolean;
  neededactive ,Areactive,ExtOK : Integer;
  anyunique,anyreceived : boolean;
  ow,oh,PN,Exttop,Extleft : Integer;
  Ncperror,Ncpdone,Icpy,icpcol : Integer;
  Colorstatuss : Array[1..32] of Integer;
  ColorEXTstatuss : Array[1..32] of Integer;
  ColorFlatstatuss : Array[1..32] of Integer;
  Bendingprikss : Array[1..32] of Integer;
  sortingprikss : Array[1..32] of Integer;
  fltsetnum : Integer;
  Anyimaging : Boolean;
  Imagingpriktype : Integer;
  Xnum : Integer;
  platethumbR : Trect;
  Exterr : Integer;
  HaveAplatethumb : Boolean;
  pltextW,pltextH : Integer;
  pltextrec : Trect;
  PageRotationList : TPageNumbering;
  TestPath,TestPath2,testpath3 : String;
  PlateBackgroundColor : Integer;
  TriangleOffset : Integer;
  MasterCopySeparationSet : Integer;
Begin
  TriangleOffset := 15;
  PlateBackgroundColor := clWebLightgrey;
  result := 0;
  ci := tbitmap.Create;
  si :=tbitmap.Create;
  sibar :=tbitmap.Create;
  tmpImage := tbitmap.Create;
  tmpplim := tbitmap.Create;
  For ic := 1 to 32 do Colorstatuss[ic] := 100;
  For ic := 1 to 32 do ColorEXTstatuss[ic] := 100;
  For ic := 1 to 32 do ColorFlatstatuss[ic] := 100;
  try
    r1616.Top := 0;
    r1616.Left := 0;
    r1616.Bottom := 16;
    r1616.Right := 16;
    r6040.Top := 0;
    r6040.Left := 0;
    r6040.Bottom := 40;
    r6040.Right := 60;
    r2010.Top := 0;
    r2010.Left := 0;
    r2010.Bottom := 10;
    r2010.Right := 20;
    r3232.Top := 0;
    r3232.Left := 0;
    r3232.Bottom := 32;
    r3232.Right := 32;
    r6432.Top := 0;
    r6432.Left := 0;
    r6432.Bottom := 32;
    r6432.Right := 64;
    baroffset := 0;
    if (formmain.ActionplateThumbnails.Checked) (*And (foxrmsettings.CheckBoxplatethumb.checked)*) then
    Begin
      baroffset := 0;
    end;
    platesData[platenumber].totstat := 100;
    platesData[platenumber].totappr := 1;
    platesData[platenumber].someerror := false;
    Plate := platesData[platenumber];
    if (Prefs.AllowSelectionOfAnyLayout) then
      tmpl := PlatetemplateArray[platesData[0].Templatelistid]
    else
      tmpl := PlatetemplateArray[Plate.templatelistid];
    platesData[platenumber].produce := false;
    platesData[platenumber].readytoproduce := true;
    // ### NAN 20151019
    platesData[platenumber].MinOutputVersion := 100;
    alldummy := true;
    anyactive := false;
    for ip := 1 to tmpl.NupOnplate do
    begin
      if plate.pages[ip].pagetype < 3 then
        alldummy := false;
    end;
    platecapaltpage := '';
    platecappagina := '';
    platepanenamescap := '';
    platecappageindex := '';
    LCappagina  := 9999;
    LCappageindex := 9999;
    platesData[platenumber].Anyimaging := false;
    platesData[platenumber].TotOKImaged := true;
    For i := 1 to plate.Copies[1].Ncolors do
    begin
      if plate.Copies[1].colorstatus[i].Active = 1 then
      begin
        Ncpdone := 0;
        Ncperror := 0;
        For icpy := 1 to plate.Ncopies do
        begin
          if plate.Copies[icpy].colorstatus[i].Active = 1 then
          begin
            if ColorEXTstatuss[i] > plate.Copies[icpy].colorstatus[i].externalstatus then
              ColorEXTstatuss[i] := plate.Copies[icpy].colorstatus[i].externalstatus;
            if Prefs.PlateDoneStatisticsMode > 0 then
            begin
              Case Prefs.PlateDoneStatisticsMode of
                1 : Begin
                      if plate.Copies[icpy].colorstatus[i].externalstatus and 2 = 2 then
                      begin
                        plate.Copies[icpy].colorstatus[i].Bendingprik := 2;
                        if plate.Copies[icpy].colorstatus[i].status >= 50 then
                          plate.Copies[icpy].colorstatus[i].status := 56;
                      end
                      Else
                      begin
                        platesData[platenumber].TotOKImaged := false;
                        xnum := plate.Copies[icpy].colorstatus[i].externalstatus and 1;
                        if xnum <> 1 then
                        Begin
                          if plate.Copies[icpy].colorstatus[i].status >= 50 then
                            plate.Copies[icpy].colorstatus[i].status := 49;
                        End
                        Else
                        begin
                          if plate.Copies[icpy].colorstatus[i].status >= 50 then
                            plate.Copies[icpy].colorstatus[i].Bendingprik := 1;
                        end;
                      end;
                    end;
                2 : Begin
                      if plate.Copies[icpy].colorstatus[i].externalstatus and 512 = 512 then
                      begin
                        if plate.Copies[icpy].colorstatus[i].status >= 50 then
                        Begin
                          plate.Copies[icpy].colorstatus[i].Sortedprik := 2;
                          plate.Copies[icpy].colorstatus[i].status := 56;
                        end;
                      end
                      Else
                      begin
                        platesData[platenumber].TotOKImaged := false;
                        xnum := plate.Copies[icpy].colorstatus[i].externalstatus and 256;
                        if xnum <> 256 then
                        Begin
                          if plate.Copies[icpy].colorstatus[i].status >= 50 then
                            plate.Copies[icpy].colorstatus[i].status := 49;
                        End
                        Else
                        begin
                          if plate.Copies[icpy].colorstatus[i].status >= 50 then
                            plate.Copies[icpy].colorstatus[i].Sortedprik := 1;
                        end;
                      end;

                    end;
              end;
            end;
             // ### NAN 20151019
            if (platesData[platenumber].MinOutputVersion > plate.Copies[icpy].colorstatus[i].outputversion) then
               platesData[platenumber].MinOutputVersion := plate.Copies[icpy].colorstatus[i].outputversion;
            if (platesData[platenumber].totstat > plate.Copies[icpy].colorstatus[i].status) and
                           (plate.Copies[icpy].colorstatus[i].Active = 1) then
              platesData[platenumber].totstat := plate.Copies[icpy].colorstatus[i].status;
            if (plate.Copies[icpy].colorstatus[i].status = 16) or
             (plate.Copies[icpy].colorstatus[i].status = 26) or
             (plate.Copies[icpy].colorstatus[i].status = 36) or
             (plate.Copies[icpy].colorstatus[i].status = 46) or
             (plate.Copies[icpy].colorstatus[i].status = 56) then
            Begin
              Colorstatuss[i] := plate.Copies[icpy].colorstatus[i].status;
              platesData[platenumber].someerror := true;
            End
            Else
            Begin
              if (Colorstatuss[i] > plate.Copies[icpy].colorstatus[i].status) and ((Colorstatuss[i] >= 50) or (Colorstatuss[i] <= 30)) then
                Colorstatuss[i] := plate.Copies[icpy].colorstatus[i].status;
              if ((plate.Copies[icpy].colorstatus[i].status  = 45) or (plate.Copies[icpy].colorstatus[i].status  = 49)) and (plate.Copies[icpy].colorstatus[i].active = 1) then
              Begin
                platesData[platenumber].Anyimaging := true;
              end;
              if (plate.Copies[icpy].colorstatus[i].status  < 30) and
                 (plate.Copies[icpy].colorstatus[i].active = 1)  then
              Begin
                platesData[platenumber].readytoproduce := false;
              end;
            end;
            if ((Colorstatuss[i] = 46) OR (Colorstatuss[i] = 49)) And (FlatPageTablePossible) then
            begin
              if ColorFlatstatuss[i] <> 156 then  // Fanout error
              begin
                if ColorFlatstatuss[i] < plate.Copies[icpy].colorstatus[i].Flatpagestatus then
                  ColorFlatstatuss[i] := plate.Copies[icpy].colorstatus[i].Flatpagestatus;
              end;
              if plate.Copies[icpy].colorstatus[i].Flatpagestatus = 156 then
                ColorFlatstatuss[i] := 156;
            end;
          end;
        end;
      end;
    end;

    for ip := 1 to tmpl.NupOnplate do
    begin
      if (plate.pages[ip].pagetype < 2) then
      begin
        platecapaltpage := platecapaltpage + plate.pages[ip].Altpagename+' ';
        platecappagina := platecappagina + inttostr(plate.pages[ip].Pagina)+' ';
        platepanenamescap := platepanenamescap + plate.pages[ip].pagename+' ';
        platecappageindex := platecappageindex + inttostr(plate.pages[ip].pageindex)+' ';
        if LCappagina > plate.pages[ip].Pagina then
          LCappagina := plate.pages[ip].Pagina;
        if LCappageindex > plate.pages[ip].pageindex then
          LCappageindex := plate.pages[ip].pageindex;
      end;
      if plate.pages[ip].pagetype <> 3 then
      begin
        pagestatus[ip].proofed := false;
        pagestatus[ip].status := 100;
        pagestatus[ip].maxstatus := 0;
        pagestatus[ip].approved := 100;
        For ic := 1 to plate.pages[ip].ncolors do
        begin
          if (plate.pages[ip].colors[ic].status > pagestatus[ip].maxstatus) then
            pagestatus[ip].maxstatus := plate.pages[ip].colors[ic].status;

          if (plate.pages[ip].colors[ic].status > 0) and
             ((plate.pages[ip].colors[ic].Proofstatus = 10) or (plate.pages[ip].colors[ic].Proofstatus = 20)) then
            pagestatus[ip].proofed := true;
          if plate.pages[ip].colors[ic].Uniquepage > 0 then
              platesData[platenumber].produce := true;
          if plate.pages[ip].colors[ic].active = 1 then
          begin
            if plate.pages[ip].colors[ic].status < pagestatus[ip].status then
            begin
              pagestatus[ip].status := plate.pages[ip].colors[ic].status;
            end;
            if plate.pages[ip].colors[ic].Approved < pagestatus[ip].Approved then
            begin
              pagestatus[ip].Approved := plate.pages[ip].colors[ic].Approved;
            end;
            if plate.pages[ip].colors[ic].Approved = 2 then
              platesData[platenumber].totappr := 2;
            if (plate.pages[ip].colors[ic].Approved = 0) and (platesData[platenumber].totappr <> 2) then
              platesData[platenumber].totappr := 0;
            if (plate.pages[ip].colors[ic].Approved = -1) and (platesData[platenumber].totappr <> 2) then
              platesData[platenumber].totappr := -1;
          end;
        end;
      end;
    end;
    if length(platecappagina) > 0 then
    begin
      delete(platecappagina,length(platecappagina),1);
    end;
    if length(platecapaltpage) > 0 then
    begin
      delete(platecapaltpage,length(platecapaltpage),1);
    end;
    if length(platecappageindex) > 0 then
    begin
      delete(platecappageindex,length(platecappageindex),1);
    end;
    if length(platepanenamescap) > 0 then
    begin
      delete(platepanenamescap,length(platepanenamescap),1);
    end;
    neededactive := 0;
    Areactive := 0;
    for ip := 1 to tmpl.NupOnplate do
    begin
      plate.pages[ip].Nocolorisactive := true;
      if plate.pages[ip].pagetype < 2 then
      begin
        Inc(neededactive);
        for ic := 1 to plate.pages[ip].Ncolors do
        begin
          if plate.pages[ip].colors[ic].active <> 0 then
          begin
            plate.pages[ip].Nocolorisactive := false;
            Inc(Areactive);
            break;
          end;
        end;
      End
      Else
        plate.pages[ip].Nocolorisactive := false;
    end;

    if Areactive >= neededactive then
      anyactive := true;

    anyunique := false;
    anyreceived := false;
    for ip := 1 to tmpl.NupOnplate do
    begin
      if plate.pages[ip].UniquePage > 0 then
      begin
        anyunique := true;
      End
    end;
    for ip := 1 to tmpl.NupOnplate do
    begin
      For ic := 0 to plate.pages[ip].Ncolors do
      begin
        if plate.pages[ip].colors[ic].status <> 0 then
        begin
          anyreceived := true;
          break;
        end;
      end;
      if anyreceived then
        break;
    end;
     for ip := 1 to tmpl.NupOnplate do
     begin
        if plate.Front = 0 then
          PageRotationList[ip] :=  tmpl.PageRotationList[ip]
        else
          PageRotationList[ip] :=  tmpl.PageRotationBackList[ip];
        if plate.pages[ip].PageRotationOverrule > 0 then
          PageRotationList[ip] :=  plate.pages[ip].PageRotationOverrule - 1;
     end;
    ci.Width := 18;
    ci.height := 18;
    sibar.Width := 20;
    sibar.height := 10;
    Si.Width := 60;
    Si.height := 40;
    tmpImage.Width := 13;    //204
    tmpImage.height := 13;   //176
    tmpplim.Width := 16;
    tmpplim.height := 16;
  //  plateprect := makeimagesize(tmpl.PageRotationList,
    plateprect := makeimagesize(PageRotationList,
                                tmpl.IncomingPageRotationEven,
                                tmpl.PagesAcross,
                                tmpl.PagesDown,
                                platew,
                                plateh,
                                pagew,
                                pageh);

    if (plateviewimage.Width <> platew) or (plateviewimage.height <> plateh) then
    Begin
      plateviewimage.Width := platew;    //204
      plateviewimage.height := plateh;   //176
      IPV.clear;
      IPV.Height := plateviewimage.Height;
      IPV.width := plateviewimage.width;
    end;
    plateviewimage.Canvas.Brush.Color := clwhite;
    plateviewimage.Canvas.CopyMode :=  cmSrcCopy;

    plateviewimage.Canvas.Pen.Color := clGray;
    if alldummy then
    begin
      PlateBackgroundColor := clWebLightgrey;
    //  plateviewimage.Canvas.Brush.Color := clWebLightgrey;
    //  plateviewimage.Canvas.Rectangle(plateprect);
    end
    else
    begin
      if platesData[platenumber].someerror then
      Begin
        PlateBackgroundColor := clRed;
      //  plateviewimage.Canvas.Brush.Color := clRed;
      //  plateviewimage.Canvas.Rectangle(plateprect);
      End
      else
      Begin
        if platesData[platenumber].totstat > 49 then
        Begin
          PlateBackgroundColor := clLime;
      //    plateviewimage.Canvas.Brush.Color := clLime;
      //    plateviewimage.Canvas.Rectangle(plateprect);
        end
        else
        Begin
          if platesData[platenumber].Anyimaging then
          begin
            PlateBackgroundColor := clWebOrange;
      //      plateviewimage.Canvas.Brush.Color := clWebOrange;
      //      plateviewimage.Canvas.Rectangle(plateprect);
          end
          else
          Begin
            if not platesData[platenumber].produce then
            Begin
              PlateBackgroundColor := clWebMediumBlue;
      //        plateviewimage.Canvas.Brush.Color := clWebMediumBlue;
      //        plateviewimage.Canvas.Rectangle(plateprect);
            End
            else
            Begin
              if platesData[platenumber].readytoproduce then
              Begin
               // ### NAN 20151019 begin
                if (platesdata[platenumber].MinOutputVersion > 0) and (Prefs.IncludeImageOnceState) then
                begin

                  PlateBackgroundColor := clWebKhaki; //clWebAquamarine ;
      //            plateviewimage.Canvas.Brush.Color := clWebAqua;
      //            plateviewimage.Canvas.Rectangle(plateprect);
                end
                else
                // ### NAN 20151019 end
                begin
                  PlateBackgroundColor := clYellow;
      //            plateviewimage.Canvas.Brush.Color := clYellow;
      //            plateviewimage.Canvas.Rectangle(plateprect);
                end;
              End
              else
              Begin
                PlateBackgroundColor := clWebLightgrey;
      //          plateviewimage.Canvas.Brush.Color := clMedGray;
      //          plateviewimage.Canvas.Rectangle(plateprect);
              end;
            end;
          end;
        end;
      end;
    end;
    plateviewimage.Canvas.Brush.Color := PlateBackgroundColor;
    plateviewimage.Canvas.Rectangle(plateprect);
    w := 0;
    h := 1;
    platesData[platenumber].thumbpos.Left := 9999;
    platesData[platenumber].thumbpos.top := 9999;
    platesData[platenumber].thumbpos.bottom := 0;
    platesData[platenumber].thumbpos.right := 0;
    plate.Totstat := platesData[platenumber].totstat;
    if plate.Totstat < 30 then
    begin
      plate.Softprevready := false;
      plate.prevready := 0;
    end;

    for ip := 1 to tmpl.NupOnplate do
    begin
      if Specialplatestanding then
      begin
        inc(w);
        if w > tmpl.PagesDown then
        begin
          inc(h);
          w := 1;
        end;
      end
      else
      begin
        inc(w);
        if w > tmpl.PagesAcross then
        begin
          inc(h);
          w := 1;
        end;
      end;
      platesData[platenumber].Pages[ip].position.Left := (Imposmw*w)+ ((w-1)*Impospw);
      platesData[platenumber].Pages[ip].position.top  := (Imposmh*h)+ (h-1)*Imposph;
      platesData[platenumber].Pages[ip].position.Right := (Imposmw*w)+(w*Impospw);
      platesData[platenumber].Pages[ip].position.Bottom := (Imposmh*h)+(h*Imposph);
      platesData[platenumber].Pages[ip].proofed := pagestatus[ip].proofed;
      plate.pages[ip].position.Left := (Imposmw*w)+ ((w-1)*Impospw);
      plate.pages[ip].position.top  := ((Imposmh*h)+ (h-1)*Imposph)+baroffset;
      plate.pages[ip].position.Right := (Imposmw*w)+(w*Impospw);
      plate.pages[ip].position.Bottom := ((Imposmh*h)+(h*Imposph))+baroffset;

      if platesData[platenumber].thumbpos.Left > platesData[platenumber].Pages[ip].position.Left then
        platesData[platenumber].thumbpos.Left := platesData[platenumber].Pages[ip].position.Left;
      if platesData[platenumber].thumbpos.top > platesData[platenumber].Pages[ip].position.top then
        platesData[platenumber].thumbpos.top := platesData[platenumber].Pages[ip].position.top;
      if platesData[platenumber].thumbpos.right < platesData[platenumber].Pages[ip].position.right then
        platesData[platenumber].thumbpos.right := platesData[platenumber].Pages[ip].position.right;
      if platesData[platenumber].thumbpos.Bottom < platesData[platenumber].Pages[ip].position.Bottom then
        platesData[platenumber].thumbpos.Bottom := platesData[platenumber].Pages[ip].position.Bottom;

    end;
    plate.thumbpos := platesData[platenumber].thumbpos;
    w := 0;
    h := 1;
    for ip := 1 to tmpl.NupOnplate do
    begin
      inc(w);
      if w > tmpl.PagesAcross then
      begin
        inc(h);
        w := 1;
      end;
      if plate.pages[ip].pagetype = 1 then
      Begin
        for ap := 1 to tmpl.NupOnplate do
        Begin
          aktpagetypes[ap] := plate.pages[ap].pagetype;
        end;
        ap := formmain.Supergetantipos(ip,aktpagetypes,plate.templatelistid,false);
        if ap <> -1 then
        begin
          if plate.pages[ip].position.Left > plate.pages[ap].position.Left then
            plate.pages[ip].position.Left := plate.pages[ap].position.Left;
          if plate.pages[ip].position.right < plate.pages[ap].position.right then
            plate.pages[ip].position.right := plate.pages[ap].position.right;
          if plate.pages[ip].position.top > plate.pages[ap].position.top then
            plate.pages[ip].position.top := plate.pages[ap].position.top;
          if plate.pages[ip].position.bottom < plate.pages[ap].position.bottom then
            plate.pages[ip].position.bottom := plate.pages[ap].position.bottom;
          platesData[platenumber].Pages[ip].position.Left := plate.pages[ip].position.Left;
          platesData[platenumber].Pages[ip].position.top  := plate.pages[ip].position.top;
          platesData[platenumber].Pages[ip].position.Right := plate.pages[ip].position.right;
          platesData[platenumber].Pages[ip].position.Bottom := plate.pages[ip].position.bottom;
          platesData[platenumber].Pages[ip].proofed := pagestatus[ip].proofed;
          platesData[platenumber].Pages[ap].position.Left := -2200;
          platesData[platenumber].Pages[ap].position.top  := -2200;
          platesData[platenumber].Pages[ap].position.Right := -2200;
          platesData[platenumber].Pages[ap].position.Bottom := -2200;
          platesData[platenumber].Pages[ip].proofed := pagestatus[ip].proofed;
        end;
      end;
    end;

    if alldummy then
    begin
      // alt er dummy barg er hvid
      platesData[platenumber].produce := false;
    end
    else
    begin
      //NY thumb p� plateview  totstat
      HaveAplatethumb := false;
      if (showthumbnails) and (Prefs.UsePlateviewThumbnails) then
      begin
        plateviewimage.Canvas.Brush.Color := clskyblue;
        plateviewimage.Canvas.Brush.style := bssolid;
        d.Left := plate.thumbpos.Left;
        d.Top := plate.thumbpos.top;
        d.Right := plate.thumbpos.right;
        d.Bottom := plate.thumbpos.Bottom;
//        plateviewimage.Canvas.Rectangle(d);
        if (plate.Softprevready) or (plate.prevready > 0)  then
        Begin
         //#### apath := Formmain.getinkfolder(2,plate.locationID);
         //#### ppath := Formmain.getinkfolder(1,plate.locationID);
          fltsetnum := (plate.CopyFlatSeparationSet*100)+1;
          testpath := '';
          if (Prefs.UsePreviewCache) then
            testpath := FormMain.GetInkFolderCache(2)+inttostr(fltsetnum)+'.jpg';
          if ((not Prefs.UsePreviewCache) or (Prefs.UsePreviewCache and not fileexists(testpath))) then
            testpath := Formmain.getinkfolder(2,plate.locationID)+inttostr(fltsetnum)+'.jpg';

          if fileexists(testpath) then
          begin
            formmain.ImageEnIO1.LoadFromFileJpeg(testpath);
            ThumbFilesok := true;
//            plateviewimage.Canvas.CopyMode := cmSrcand;
//            plateviewimage.Canvas.CopyRect(d,tmpplim.Canvas,r1616);

          (*  d.Left := d.Left;
            d.top := d.top;
            d.right := d.right;
            d.Bottom := d.Bottom; *)
            platethumbR := d;
            plateviewimage.Canvas.StretchDraw(platethumbR,FormImage.ImageEnViewplatethumb.Bitmap);
            HaveAplatethumb := true;
          end;
        end;
        For ip := 1 to tmpl.NupOnplate do
        begin
          pl := plate.pages[ip].position.Left;
          pt := plate.pages[ip].position.Top;
          plateviewimage.Canvas.Brush.Style := bsClear;
          plateviewimage.Canvas.Font := FormImage.Labelplatetext.Font;
          platenametext := plate.pages[ip].pagename;
          (*if anyactive then
            platenametext := '1' +platenametext
          else
            platenametext := '0' +platenametext;
          *)
          if (Prefs.PlateviewBoldFont) then
            plateviewimage.Canvas.Font.Style := [fsBold]
          else
            plateviewimage.Canvas.Font.Style := [];
          //plateviewimage.Canvas.Font.height := -16;
          plateviewimage.Canvas.Font.height := -10;
          platenametextWidth := plateviewimage.Canvas.TextWidth(platenametext);
          plpos := (Impospw - platenametextWidth) div 2;

        //  plateviewimage.Canvas.Font.Style := [];
  //          plateviewimage.Canvas.Font.height := -12;
          plateviewimage.Canvas.Font.height := -10;
          secnametext := tnames1.sectionIDtoname(plate.pages[ip].SectionID);
          //secnametext := '';
          secnametextWidth := plateviewimage.Canvas.TextWidth(secnametext);
          if secnametextWidth > Impospw then
          Begin
            delete(secnametext,4,100);
            secnametext := secnametext +'...';
            secnametextWidth := plateviewimage.Canvas.TextWidth(secnametext);
          end;
          secpos := (Impospw - secnametextWidth) div 2;

          secnametextWidth := plateviewimage.Canvas.TextWidth(secnametext);
          if Pressviewzoom <> 50 then
            ImptextY := (Imposph div 4)
          else
            ImptextY := (Imposph div 2);
          if (plate.pages[ip].pagetype <> 3) And (plate.pages[ip].pagetype <> 2) then
          begin
            Case plate.pages[ip].pagetype of
              0..1 : begin
                        y := pt + ImptextY - FormImage.Labelplatetext.Height;
                        Y := y-6;
                        if (Prefs.PlateviewBoldFont) then
                          plateviewimage.Canvas.Font.Style := [fsBold]
                        else
                          plateviewimage.Canvas.Font.Style := [];
                        plateviewimage.Canvas.Font.height := -10;
                        FormImage.Labelplatetext.Font := plateviewimage.Canvas.Font;
                        pltextW := plateviewimage.Canvas.TextWidth(platenametext);
                        pltextrec.Left := (pl+plpos)-5;
                        pltextH := FormImage.Labelplatetext.Height * 2;
                        if plateviewimage.Canvas.TextWidth(secnametext) > pltextW then
                        begin
                          pltextW := plateviewimage.Canvas.TextWidth(secnametext);
                          pltextrec.Left := (pl+secpos)-5;
                        end;
                        pltextrec.right := pltextrec.Left + pltextW+10;
                        pltextrec.Top := y-1;
                        pltextrec.Bottom := y+pltextH+2;
                        //pltextrec : Trect;

                        plateviewimage.canvas.Pen.Color := clblack;
                        plateviewimage.canvas.Pen.Width := 1;
                        plateviewimage.canvas.brush.Color := clWebLightgrey;
                        //if pltextrec.Right - pltextrec.Left > 32 then
                         // plateviewimage.Canvas.CopyRect(pltextrec,FormImage.Imageplatenumberimagewide.Canvas,r6432)
                       //    plateviewimage.Canvas.Rectangle(r6432)
                       // Else
                         // plateviewimage.Canvas.CopyRect(pltextrec,FormImage.Imageplatenumberimage.Canvas,r3232);
                          plateviewimage.Canvas.Rectangle(pltextrec);

                        plateviewimage.canvas.Pen.Color := clgray;
                        plateviewimage.canvas.brush.Color := clnone;
                        plateviewimage.canvas.brush.style := bsClear;
                        plateviewimage.Canvas.TextOut(pl+plpos,y,platenametext);
                        Inc(y,FormImage.Labelplatetext.Height);
                        plateviewimage.Canvas.TextOut(pl+secpos,y,secnametext);
                        (*
                        //plateviewimage.Canvas.Font.Style := [];
                        //plateviewimage.Canvas.Font.height := -10;
                        //plateviewimage.Canvas.Font.height := -12;
                        *)
                        FormImage.Labelplatetext.Font := plateviewimage.Canvas.Font;
                        Inc(y,FormImage.Labelplatetext.Height);
                      end;
              3     : Begin
                        plateviewimage.Canvas.font.Color := clwhite;
                        y := pt + ImptextY - FormImage.Labelplatetext.Height;
                        plateviewimage.Canvas.TextOut(pl+plpos,y,plate.pages[ip].pagename);
                      end;
              else  begin // den b�r ikke komme her til
                       (*
                        y := pt + ImptextY - Labelplatetext.Height;
                        plateviewimage.Canvas.TextOut(pl+plpos,y,platenametext);
                        Inc(y,Labelplatetext.Height);
                        plateviewimage.Canvas.TextOut(pl+secpos,y,secnametext);
                        Inc(y,Labelplatetext.Height);
                        *)
                      end;

            end;

          End
          else
          begin
          end;
        end;
      end;

      if Not HaveAplatethumb then    //skyblue
      Begin
        w := 0;
        h := 1;
        for ip := 1 to tmpl.NupOnplate do
        begin
          inc(w);
          PN := 0;
          if w > tmpl.PagesAcross then
          begin
            inc(h);
            w := 1;
          end;
          plateviewimage.Canvas.Brush.Color := clwhite;
          plateviewimage.Canvas.pen.Color := clblack;
          if (plate.pages[ip].pagetype <> 3) And (plate.pages[ip].pagetype <> 2) then
          Begin
            if pagestatus[ip].maxstatus >= 30 then
            begin
              plateviewimage.Canvas.Brush.Style := bsSolid;
              plateviewimage.Canvas.Brush.Color := clWebPaleGoldenrod ;
              plateviewimage.Canvas.Pen.Color := clWebDarkGray;
              plateviewimage.Canvas.Pen.Width := 4;
              Case plate.pages[ip].totapproval of
                0 : plateviewimage.Canvas.Pen.Color := clWebDarkGray; //plateviewimage.Canvas.StretchDraw(plate.pages[ip].position,FormImage.Imageplatepagearrived.Picture.Bitmap);
                1 : plateviewimage.Canvas.Pen.Color := clWebLimeGreen ; //plateviewimage.Canvas.StretchDraw(plate.pages[ip].position,FormImage.Imageplatepageapprovedarrived.Picture.Bitmap);
                2 : plateviewimage.Canvas.Pen.Color := clWebCrimson ; //plateviewimage.Canvas.StretchDraw(plate.pages[ip].position,FormImage.Imageplatepagedisapprovedarrived.Picture.Bitmap);
              end;
              plateviewimage.Canvas.Rectangle(plate.pages[ip].position);
            end
            else
            begin
              plateviewimage.Canvas.Brush.Style := bsSolid;
              plateviewimage.Canvas.Brush.Color := clWebWhiteSmoke;
              plateviewimage.Canvas.Pen.Color := clWebDarkGray;
              plateviewimage.Canvas.Pen.Width := 4;
              Case plate.pages[ip].totapproval of
                0 : plateviewimage.Canvas.Pen.Color := clWebDarkGray; //plateviewimage.Canvas.StretchDraw(plate.pages[ip].position,FormImage.Imageplatepagenotarrived.Picture.Bitmap);
                1 : plateviewimage.Canvas.Pen.Color := clWebLimeGreen ; //plateviewimage.Canvas.StretchDraw(plate.pages[ip].position,FormImage.Imageplatepageapprovednotarrived.Picture.Bitmap);
                2 : plateviewimage.Canvas.Pen.Color := clWebCrimson ; //plateviewimage.Canvas.StretchDraw(plate.pages[ip].position,FormImage.Imageplatepagedisapprovednotarrived.Picture.Bitmap);
              end;
              plateviewimage.Canvas.Rectangle(plate.pages[ip].position);
            end;
            plateviewimage.Canvas.Pen.Width := 1;

            if (not Prefs.UsePlateviewThumbnails) and (showthumbnails) then
            begin
              Thumbok := false;
              plateviewimage.Canvas.CopyMode := cmSrccopy;
              if pagestatus[ip].proofed then
              begin
                MasterCopySeparationSet := plate.pages[ip].MasterCopySeparationSet;
                apath := formmain.GetFileServerPath(PATHTYPE_CCTHUMBNAILS, plate.pages[ip].Fileserver);
                ppath := formmain.GetFileServerPath(PATHTYPE_CCPREVIEWS, plate.pages[ip].Fileserver);
                testpath := '';
                testpath2 := '';

                if (Prefs.UsePreviewCache) then
                  testpath := FormMain.getfileserverpathcached(PATHTYPE_CCTHUMBNAILS) + inttostr(MasterCopySeparationSet)+'.jpg';
                if ((not Prefs.UsePreviewCache) or (Prefs.UsePreviewCache and not fileexists(testpath))) then
                  testpath := apath + inttostr(MasterCopySeparationSet)+'.jpg';


                if (Prefs.UsePreviewCache) then
                  testpath2 := FormMain.getfileserverpathcached(PATHTYPE_CCPREVIEWS) + inttostr(MasterCopySeparationSet)+'.jpg';
                if ((not Prefs.UsePreviewCache) or (Prefs.UsePreviewCache and not fileexists(testpath2))) then
                  testpath2 := ppath + inttostr(MasterCopySeparationSet)+'.jpg';

                ThumbFilesok := false;

                if (Prefs.NewPreviewNames) then
                begin
                  testpath3 := testpath;
                  testpath := '';
                  if (Prefs.UsePreviewCache) then
                    testpath := FormMain.getfileserverpathcached(PATHTYPE_CCTHUMBNAILS) + PreviewGUID + '====' + inttostr(MasterCopySeparationSet)+'.jpg';
                  if ((not Prefs.UsePreviewCache) or (Prefs.UsePreviewCache and not fileexists(testpath))) then
                    testpath := apath + PreviewGUID + '====' + inttostr(MasterCopySeparationSet)+'.jpg';

                  if not fileexists(testpath) then
                    testpath := testpath3;

                  testpath3 := testpath2;
                  testpath2 := '';
                  if (Prefs.UsePreviewCache) then
                    testpath2 := FormMain.getfileserverpathcached(PATHTYPE_CCPREVIEWS) + PreviewGUID + '====' + inttostr(MasterCopySeparationSet)+'.jpg';
                  if ((not Prefs.UsePreviewCache) or (Prefs.UsePreviewCache and not fileexists(testpath2))) then
                    testpath2 := ppath + PreviewGUID + '====' + inttostr(MasterCopySeparationSet)+'.jpg';

                  if not fileexists(testpath2) then
                    testpath2 := testpath3;
                end;


                if (fileexists(testpath)) and (fileexists(testpath2)) then
                Begin
                  ThumbFilesok := true;
                  formmain.ImageEnIO1.LoadFromFileJpeg(testpath);
                End
                else
                Begin
                  ThumbFilesok := false;
                end;



                if ThumbFilesok Then
                begin
                  FormImage.ImageEnViewplatethumb.Refresh;
                  if (Specialplatestanding) OR (Prefs.PlateNoThumbnailRotation) then
                  begin
                  end
                  else
                  begin
                   // ## NAN 20150206
                   // Case tmpl.PageRotationList[ip] of
                    Case PageRotationList[ip] of
                      0 : begin
                          end;
                      1 : begin
                            formmain.ImageEnProcplate.Rotate(270,false);
                          end;
                      2 : begin
                            formmain.ImageEnProcplate.Rotate(180,false);
                          end;
                      3 : begin
                            formmain.ImageEnProcplate.Rotate(90,false);
                          end;
                    end;
                  end;
                  //plateviewimage.Canvas.StretchDraw(plate.pagepos[ip],TJPEGImage(Imageplatethumb.picture.Graphic));
                  thumbrect := plate.pages[ip].position;
                  thumbrect.Left := thumbrect.Left+6;
                  thumbrect.top := thumbrect.top+6;
                  thumbrect.bottom := thumbrect.bottom-6;
                  thumbrect.right := thumbrect.right-6;
                  plateviewimage.Canvas.StretchDraw(thumbrect,FormImage.ImageEnViewplatethumb.Bitmap);
                end;
                Thumbok := ThumbFilesok;

       //       plateviewimage.Canvas.StretchDraw(plate.pages[ip].position,Imageplatethumb.Picture.Bitmap);

              end;
            end;
          end;

          if plate.Front = 0 then
          begin
            PageRotation := tmpl.PageRotationList[ip];
            SignaturePageNumber := tmpl.PageNumberingFront[ip];
          end
          else
          begin
            PageRotation := tmpl.PageRotationBackList[ip];
            SignaturePageNumber := tmpl.PageNumberingBack[ip];
          end;
          // ## NAN 20150206
          if (plate.pages[ip].PageRotationOverrule > 0) then
            PageRotation :=  plate.pages[ip].PageRotationOverrule -1;
          pt := (Imposmh*h)+ (h-1)*Imposph;
          pl := (Imposmw*w)+ ((w-1)*Impospw);
          //pl := (Imposmw*w)+ ((w-1)*Impospw);
          //plate.pages[ip].position
          pl :=plate.pages[ip].position.Left;
          pt := plate.pages[ip].position.Top;
          plateviewimage.Canvas.Brush.Style := bsClear;
          plateviewimage.Canvas.Font := FormImage.Labelplatetext.Font;
          platenametext := plate.pages[ip].pagename;
          (*if anyactive then
            platenametext := '1' +platenametext
          else
            platenametext := '0' +platenametext;
          *)
          if (Prefs.PlateviewBoldFont) then
            plateviewimage.Canvas.Font.Style := [fsBold]
          else
            plateviewimage.Canvas.Font.Style := [];
          //plateviewimage.Canvas.Font.height := -16;
          plateviewimage.Canvas.Font.height := -10;
          platenametextWidth := plateviewimage.Canvas.TextWidth(platenametext);
          plpos := (Impospw - platenametextWidth) div 2;

          plateviewimage.Canvas.Font.height := -10;
          secnametext := tnames1.sectionIDtoname(plate.pages[ip].SectionID);
          secnametext := '';
          for i := 0 to Length(Prefs.PlateText)-1 do
          begin
            if Prefs.PlateText[i].Enabled then
            Begin
              if secnametext <> '' then
                secnametext := secnametext + ' ';
              if Prefs.PlateText[i].Name = 'Common edition' then
              begin
                secnametext := secnametext + tnames1.EditionIDtoname(plate.pages[ip].OrgeditionID);
              end;
              if Prefs.PlateText[i].Name = 'Section' then
              begin
                secnametext := secnametext + tnames1.sectionIDtoname(plate.pages[ip].SectionID);
              end;
              if Prefs.PlateText[i].Name = 'Alt pagename' then
              begin
                secnametext := secnametext + plate.pages[ip].Altpagename;
              end;
              if Prefs.PlateText[i].Name = 'Zone' then
              begin
                secnametext := secnametext + plate.Zone;
              end;
            end;
          end;
          for i := 0 to Length(Prefs.PlateText)-1 do
          begin
            if Prefs.PlateText[i].Enabled then
            Begin
              if Prefs.PlateText[i].Name = 'InkPlatenumber' then
              begin
                secnametext := secnametext +plate.pages[ip].miscstring;
              end;

            end;
          end;

          secnametextWidth := plateviewimage.Canvas.TextWidth(secnametext);
          if secnametextWidth > Impospw then
          begin
            delete(secnametext,4,100);
            secnametext := secnametext + '...';
            secnametextWidth := plateviewimage.Canvas.TextWidth(secnametext);
          end;
          secpos := (Impospw - secnametextWidth) div 2;
         if Pressviewzoom <> 50 then
            ImptextY := (Imposph div 4)
          else
            ImptextY := (Imposph div 2);
          if (plate.pages[ip].pagetype <> 3) And (plate.pages[ip].pagetype <> 2) then
          begin
            if ((not showthumbnails) or (Not Thumbok)) or (showthumbnails and (not Prefs.PlateHideNamesOnThumbnails)) then
            begin
              Case plate.pages[ip].pagetype of
                0..1 : begin
                          y := pt + ImptextY - FormImage.Labelplatetext.Height;
                          Y := y-6;
                          if (Prefs.PlateviewBoldFont) then
                            plateviewimage.Canvas.Font.Style := [fsBold]
                          else
                            plateviewimage.Canvas.Font.Style := [];
                          plateviewimage.Canvas.Font.height := -10;
                          FormImage.Labelplatetext.Font := plateviewimage.Canvas.Font;

                          if (Prefs.ShowDataOnPlateThumbnails) and (Thumbok) and (showthumbnails) then
                          begin
                            plateviewimage.canvas.Pen.Color := clwhite;
                            plateviewimage.canvas.brush.Color := clblue;
                            pltextW := plateviewimage.Canvas.TextWidth(platenametext);
                            pltextrec.Left := (pl+plpos)-5;
                            pltextH := FormImage.Labelplatetext.Height * 2;
                            if plateviewimage.Canvas.TextWidth(secnametext) > pltextW then
                            Begin
                              pltextW := plateviewimage.Canvas.TextWidth(secnametext);
                              pltextrec.Left := (pl+secpos)-5;
                            end;
                            pltextrec.right := pltextrec.Left + pltextW+10;
                            pltextrec.Top := y-1;
                            pltextrec.Bottom := y+pltextH+2;
                            //pltextrec : Trect;

                            plateviewimage.canvas.Pen.Color := clblack;
                             plateviewimage.canvas.Pen.Width := 1;
                            plateviewimage.canvas.brush.Color := clWebLightgrey;

                            //if pltextrec.Right - pltextrec.Left > 32 then
                             // plateviewimage.Canvas.CopyRect(pltextrec,FormImage.Imageplatenumberimagewide.Canvas,r6432)
                           //    plateviewimage.Canvas.Rectangle(r6432)
                           // Else
                             // plateviewimage.Canvas.CopyRect(pltextrec,FormImage.Imageplatenumberimage.Canvas,r3232);
                              plateviewimage.Canvas.Rectangle(pltextrec);

                            plateviewimage.canvas.Pen.Color := clgray;
                            plateviewimage.canvas.brush.Color := clnone;
                            plateviewimage.canvas.brush.style := bsClear;
                            plateviewimage.Canvas.TextOut(pl+plpos,y,platenametext);
                            Inc(y,FormImage.Labelplatetext.Height);
                            plateviewimage.Canvas.TextOut(pl+secpos,y,secnametext);

                            //ikke her plateviewimage.Canvas.rectangle(pl+plpos-2,y-1,pl+plpos+4+platenametextWidth,y+Labelplatetext.Height);
                          end
                          else
                          begin
                            plateviewimage.Canvas.TextOut(pl+plpos,y,platenametext);
                            Inc(y,FormImage.Labelplatetext.Height);
                            plateviewimage.Canvas.Font.height := -10;
                            //plateviewimage.Canvas.Font.height := -12;
                            plateviewimage.Canvas.TextOut(pl+secpos,y,secnametext);
                            FormImage.Labelplatetext.Font := plateviewimage.Canvas.Font;
                            Inc(y,FormImage.Labelplatetext.Height);
                          end;

                        end;
                3     : Begin
                          plateviewimage.Canvas.font.Color := clwhite;
                          y := pt + ImptextY - FormImage.Labelplatetext.Height;
                          plateviewimage.Canvas.TextOut(pl+plpos,y,plate.pages[ip].pagename);
                        end;
                else  begin // den b�r ikke komme her til
                         (*
                          y := pt + ImptextY - Labelplatetext.Height;
                          plateviewimage.Canvas.TextOut(pl+plpos,y,platenametext);
                          Inc(y,Labelplatetext.Height);
                          plateviewimage.Canvas.TextOut(pl+secpos,y,secnametext);
                          Inc(y,Labelplatetext.Height);
                          *)
                        end;

              end;
            end;
          End;
          if (Prefs.PlateviewBoldFont) then
            plateviewimage.Canvas.Font.Style := [fsBold]
          else
            plateviewimage.Canvas.Font.Style := [];
          plateviewimage.Canvas.Font.height := -10;
          //plateviewimage.Canvas.Font.height := -12;
          if ( (showthumbnails) or (not Thumbok) or (Prefs.ShowDataOnPlateThumbnails) ) and
             (Pressviewzoom <> 50) then
          begin
            if (plate.pages[ip].pagetype <> 2) and (plate.pages[ip].pagetype <> 3) and (plate.pages[ip].pagetype <> -1)then
            Begin
              ncolors := plate.pages[ip].Ncolors;
              ncolorsW := (20 * (ncolors-1))+18;
              ci.Canvas.CopyMode := cmSrcAnd;
              icolor := 0;
              d.top := 0;
              d.Left := 0;
              d.Right := 18;
              d.bottom := 18;
              s := d;
              x := 0;
              NEWLINE := FALSE;
              si.Canvas.StretchDraw(r6040,FormImage.Imagestatusbox.Picture.Bitmap);
              barheight := 36 div plate.pages[ip].Ncolors;
              if barheight > 36 div 4 then
                barheight := 36 div 4;
              Hofext := barheight;
              bartopoffset := (38 - (barheight * plate.pages[ip].Ncolors)) div 2;
              Inc(bartopoffset);
              sibar.Width := 19;
              sibar.height := barheight;
              sirect.Top := 0;
              sirect.Left := 0;
              sirect.Right := 19;
              sirect.bottom := barheight;
              siver.Top := 0;
              siver.Left := 0;
              siver.Right := 9;
              siver.bottom := barheight;
              for ic := 1 to plate.pages[ip].Ncolors do
              begin
                if Impospw > Imposph then
                begin
                  d.top := y;
                  d.Left := plate.pages[ip].position.Left + 6;
                  d.Right := d.Left + 60;
                  d.bottom := y+40;
                end
                else
                begin
                  d.top := y;
                  d.Left := plate.pages[ip].position.Left + 8;
                  d.Right := d.Left + 60;
                  d.bottom := y+40;
                end;
                //ci.canvas.Brush.color := Colorsnames[plate.pages[ip].colors[ic].colorid].Colorlook;
                //ci.canvas.pen.color := Colorsnames[plate.pages[ip].colors[ic].colorid].Colorlook;
                si.canvas.Brush.color := Colorsnames[plate.pages[ip].colors[ic].colorid].Colorlook;
                si.canvas.pen.color := Colorsnames[plate.pages[ip].colors[ic].colorid].Colorlook;
                dbarrect.top := bartopoffset + (barheight* (ic-1));
                dbarrect.bottom := dbarrect.top + barheight; //bartopoffset + (barheight* ic);
                if plate.pages[ip].colors[ic].active=1 then
                begin
                  if plate.pages[ip].colors[ic].status = 0 then
                  Begin
                    dbarrect.left := 1;
                    dbarrect.right := 20;
                    si.canvas.pen.color := clGray;
                    si.Canvas.Rectangle(dbarrect);
                  end;

                  if (plate.pages[ip].colors[ic].status > 0) and (Colorstatuss[ic] <= 30) then
                  Begin
                    dbarrect.left := 1;
                    dbarrect.right := 20;
                    si.canvas.pen.color := clGray;
                    si.Canvas.Rectangle(dbarrect);
                    dbarrect.left := 21;
                    dbarrect.right := 40;
                    si.canvas.pen.color := clGray;
                    si.Canvas.Rectangle(dbarrect);
                  end;
                  if (Colorstatuss[ic] > 30) and (Colorstatuss[ic] < 50) then
                  Begin
                    dbarrect.left := 1;
                    dbarrect.right := 20;
                    si.canvas.pen.color := clGray;
                    si.Canvas.Rectangle(dbarrect);
                    dbarrect.left := 21;
                    dbarrect.right := 40;
                    si.canvas.pen.color := clGray;
                    si.Canvas.Rectangle(dbarrect);
                    Imagingpriktype := 0;
                    if (Colorstatuss[ic] = 36) or (Colorstatuss[ic] = 46) then
                    Begin
                      Imagingpriktype := 4;  // hel r�d
                      if FlatPageTablePossible then
                      begin
                        if ColorFlatstatuss[ic] = 156 then
                          Imagingpriktype := 3; // halv r�d
                      end;
                    End
                    else
                    Begin
                      Imagingpriktype := 1;  // normal gr�n prik
                      if FlatPageTablePossible then
                      begin
                        Case ColorFlatstatuss[ic] of
                          158 : Imagingpriktype := 2; // halv bl�
                          159 : Imagingpriktype := 2; // halv bl�
                          156 : Imagingpriktype := 3; // halv r�d
                        end;
                      end;
                    end;
                    if (Imagingpriktype > 0) then
                    begin
                     sibar.canvas.pen.color := clGray;
                     sibar.canvas.brush.color := clGray;
                     sibar.Canvas.Rectangle(sirect);
                      Case Imagingpriktype of
                        1 : sibar.canvas.brush.color := clWebOrange;
                        2 : sibar.canvas.brush.color := clLime; //clBlue;
                        3 : sibar.canvas.brush.color := clWebDarkOrange;
                        4 : sibar.canvas.brush.color := clRed;
                      end;
                      if (barheight <= 19)  then
                        sibar.Canvas.Ellipse((19 - barheight) div 2,0,barheight + (19 - barheight) div 2,barheight)
                      else
                        sibar.Canvas.Ellipse(0,(barheight-19) div 2,barheight ,19+(barheight-19) div 2);

                      si.Canvas.CopyMode := cmSrcand;
                      //si.canvas.Rectangle(41,bartopoffset + (barheight* (ic-1)),59,bartopoffset + (barheight* ic));
                      dbarrect.left := 41;
                      dbarrect.right := 59;
                      si.Canvas.CopyRect(dbarrect,sibar.Canvas,sirect);
                    end;
                  End;
                  if (Colorstatuss[ic] >= 50) then
                  begin
                    dbarrect.left := 1;
                    dbarrect.right := 20;
                    si.canvas.pen.color := clGray;
                    si.Canvas.Rectangle(dbarrect);
                    dbarrect.left := 21;
                    dbarrect.right := 40;
                    si.canvas.pen.color := clGray;
                    si.Canvas.Rectangle(dbarrect);
                    dbarrect.left := 41;
                    dbarrect.right := 59;
                    si.canvas.pen.color := clGray;
                    si.Canvas.Rectangle(dbarrect);
                  end;
                  if (Prefs.PlateShowExternalStatus) And (Prefs.PlateDoneStatisticsMode > 0) then
                  begin
                    Case Prefs.PlateDoneStatisticsMode of
                      1 : Begin
                          end;
                    end;

                   (*
                    si.canvas.Brush.Color := externalstatusarray[ColorEXTstatuss[ic]].color;
                    si.canvas.pen.Color := clblack;
                    Exttop := bartopoffset + (barheight* (ic-1));
                    Extleft := 30-(Hofext div 2);
                    si.canvas.Ellipse(Extleft,Exttop,Extleft+Hofext,Exttop+Hofext);
                    *)
                  end
                  Else
                  Begin                      //lars
                    if (Prefs.PlateShowExternalStatus) then
                    begin
                      si.canvas.Brush.Color := externalstatusarray[ColorEXTstatuss[ic]].color;
                      si.canvas.pen.Color := clblack;
                      Exttop := bartopoffset + (barheight* (ic-1));
                      Extleft := 30-(Hofext div 2);
                      si.canvas.Ellipse(Extleft,Exttop,Extleft+Hofext,Exttop+Hofext);
                    end;
                  end;
                  if (plate.pages[ip].colors[ic].version > 1)  then
                  begin
                    (*
                    si.Canvas.Brush.Style := bssolid;
                    si.Canvas.Brush.color := clwhite;
                    si.Canvas.pen.color := clwhite;
                    siver.left := 0;
                    siver.Top := 0;
                    siver.right := 19;
                    siver.Bottom := barheight;
                    *)
                    si.Canvas.Brush.Style := bsClear;
                    //si.Canvas.pen.color := clwhite;
                    si.Canvas.Font := FormImage.Labelplatever.Font;
                    dbarrect.left := 1;
                    dbarrect.right := 20;
                    if Colorsnames[plate.pages[ip].colors[ic].colorid].K = 100 then
                      si.Canvas.Font.color := clwhite
                    Else
                      si.Canvas.Font.color := clblack;
                    si.Canvas.TextRect(dbarrect, dbarrect.Left+1,dbarrect.Top-1,'V ' + IntToStr(plate.pages[ip].colors[ic].version));

                  end;

                end;
                if (not showthumbnails) or (Not Thumbok) then
                Begin
                  plateviewimage.Canvas.CopyMode := cmSrcCopy;
                  plateviewimage.Canvas.CopyRect(d,si.Canvas,r6040);
                end;
                inc(icolor);
              end;
              if (not showthumbnails) or (Not Thumbok) then
              Begin
                if Impospw > Imposph then
                begin
                  d.left := d.right + 2;
                  d.right := d.Left + 16;
                  d.top := d.top+2;
                  d.bottom := d.top+16;
                end
                else
                begin
                  d.left := d.left +2;
                  d.right := d.Left + 16;
                  d.top := d.bottom+2;
                  d.bottom := d.top+16;
                end;
                tmpplim.Canvas.Brush.Color := clwhite;
                tmpplim.Canvas.pen.Color := clwhite;
                tmpplim.Canvas.Rectangle(r1616);
               // tmpplim.Canvas.CopyRect(r1616,FormImage.Imagecolorbrg1616.Canvas,r1616);

                if (plate.pages[ip].Anyheld) And (plate.pages[ip].Anyreleased) then
                Begin
                  FormImage.ImageListStatus.GetBitmap(31, tmpplim);
                end;
                if (plate.pages[ip].Anyheld) And (Not plate.pages[ip].Anyreleased) then
                Begin
                  FormImage.ImageListStatus.GetBitmap(33, tmpplim);
                end;
                if (Not plate.pages[ip].Anyheld) And (plate.pages[ip].Anyreleased) then
                Begin
                  FormImage.ImageListStatus.GetBitmap(32, tmpplim);
                end;
                plateviewimage.Canvas.CopyMode := cmSrcand;
                plateviewimage.Canvas.CopyRect(d,tmpplim.Canvas,r1616);
                plateviewimage.Canvas.CopyMode := cmSrcCopy;

                if Impospw > Imposph then
                begin
                  d.top := d.top+18;
                  d.bottom := d.top+16;
                end
                else
                begin
                  d.left := d.left+20;
                  d.right := d.Left + 16;
                end;
                tmpplim.Canvas.Brush.Color := clwhite;
                tmpplim.Canvas.pen.Color := clwhite;
                tmpplim.Canvas.Rectangle(r1616);
                //tmpplim.Canvas.CopyRect(r1616,FormImage.Imagecolorbrg1616.Canvas,r1616);
                Case plate.pages[ip].UniquePage of
                  0 : FormImage.ImageListStatus.GetBitmap(25, tmpplim);
                  1 : FormImage.ImageListStatus.GetBitmap(26, tmpplim);
                  2 : FormImage.ImageListStatus.GetBitmap(29, tmpplim);
                end;

                plateviewimage.Canvas.CopyMode := cmSrcand;
                plateviewimage.Canvas.CopyRect(d,tmpplim.Canvas,r1616);
                if (plate.Softprevready) or (plate.prevready > 0) or (plate.InkError) then
                Begin
                  d.left := d.left+20;
                  d.right := d.Left + 16;
                  tmpplim.Canvas.Brush.Color := clwhite;
                  tmpplim.Canvas.pen.Color := clwhite;
                  tmpplim.Canvas.Rectangle(r1616);
                 // tmpplim.Canvas.CopyRect(r1616,FormImage.Imagecolorbrg1616.Canvas,r1616);
                  if plate.Softprevready then
                  begin
                    FormImage.ImageListStatus.GetBitmap(30, tmpplim);
                  end;
                  if plate.InkError then
                  Begin
                    Case plate.prevready of
                      1 : FormImage.ImageListStatus.GetBitmap(36, tmpplim);
                      2 : FormImage.ImageListStatus.GetBitmap(30, tmpplim);
                    end;
                  End
                  else
                  Begin
                    Case plate.prevready of
                      1 : FormImage.ImageListStatus.GetBitmap(35, tmpplim);
                      2 : FormImage.ImageListStatus.GetBitmap(30, tmpplim);
                    end;
                  end;
                  plateviewimage.Canvas.CopyMode := cmSrcand;
                  plateviewimage.Canvas.CopyRect(d,tmpplim.Canvas,r1616);
                end;
              end;
              plateviewimage.Canvas.CopyMode := cmSrcCopy;
            end;
            //plateviewimage.Canvas.Brush.Style := bssolid;
        end;

        porient := 0;
        Case PageRotation of
          0 : Begin
                if ip mod 2 = 1 then
                   porient := 1
                 Else
                   porient := 2;
              end;
          1 : begin
                if h mod 2 = 1 then
                  porient := 2
                else
                  porient := 3;
              end;
          2 : Begin
                if ip mod 2 = 1 then
                   porient := 4
                 Else
                   porient := 3;
              end;
          3 : begin
                if h mod 2 = 1 then
                  porient := 1
                else
                  porient := 4;
              end;
        end;
        // ## NAN Quick fix...
        if (tmpl.IncomingPageRotationEven = 1) then
        begin
            if porient = 0 then
              porient := 1
            else if  porient = 2 then
              porient := 3;
        end
        else
        if (tmpl.IncomingPageRotationEven = 3) then
        begin
            if porient = 2 then
              porient := 1
            else if  porient = 0 then
              porient := 3;
        end;
  (*      if (tmpl.IncomingPageRotationEven>0) then
        begin
          Case tmpl.IncomingPageRotationEven of
          0 : Begin
                if Signaturepagenumber mod 2 = 0 then
                   porient := 1
                 Else
                   porient := 2;
              end;
          1 : begin
                if Signaturepagenumber mod 2 = 0 then
                  porient := 2
                else
                  porient := 3;
              end;
          2 : Begin
                if Signaturepagenumber mod 2 = 0 then
                   porient := 3
                 Else
                   porient := 4;
              end;
          3 : begin
                if Signaturepagenumber mod 2 = 0 then
                  porient := 4
                else
                  porient := 1;
              end;
        end;
        end;
  *)
        if not Specialplatestanding then
        begin

          if (plate.pages[ip].pagetype <> 3) and (plate.pages[ip].pagetype <> 2) then
          Begin
            Sourced.Top := 0;
            Sourced.left := 0;
            Sourced.Right := TriangleOffset-1;
            Sourced.bottom := TriangleOffset-1;
            destd := plate.pages[ip].position;
            Case porient of
              1 : begin  // top left

                  //  FormImage.ImageListdonk.GetBitmap(2, tmpImage);
                    FormImage.ImageListDonkeyears.GetBitmap(GetTriangleImageNumber(PlateBackgroundColor,porient), tmpImage);
                    destd.left := destd.left - 2;
                    destd.top := destd.top - 2;
                    destd.Right := destd.left + TriangleOffset;
                    destd.bottom := destd.top + TriangleOffset;
                    plateviewimage.Canvas.CopyRect(Destd, tmpImage.Canvas,Sourced);
                  end;
              2 : begin  // top right
//                    FormImage.ImageListdonk.GetBitmap(0, tmpImage);
                    FormImage.ImageListDonkeyears.GetBitmap(GetTriangleImageNumber(PlateBackgroundColor,porient), tmpImage);
                    destd.Right := destd.Right + 2;
                    destd.top := destd.top - 2;
                    destd.left := destd.Right - TriangleOffset;
                    destd.bottom := destd.top + TriangleOffset;
                    plateviewimage.Canvas.CopyRect(Destd, tmpImage.Canvas,Sourced);
                  end;
              3 : begin  // bottom right
//                    FormImage.ImageListdonk.GetBitmap(1, tmpImage);
                    FormImage.ImageListDonkeyears.GetBitmap(GetTriangleImageNumber(PlateBackgroundColor,porient), tmpImage);
                    destd.Right := destd.Right + 2;
                    destd.bottom := destd.bottom + 2;
                    destd.left := destd.Right - TriangleOffset;
                    destd.top := destd.bottom - TriangleOffset;
                    plateviewimage.Canvas.CopyRect(Destd, tmpImage.Canvas,Sourced);
                  end;
              4 : begin  // bottom left
//                    FormImage.ImageListdonk.GetBitmap(3, tmpImage);
                    FormImage.ImageListDonkeyears.GetBitmap(GetTriangleImageNumber(PlateBackgroundColor,porient), tmpImage);
                    destd.left := destd.left - 2;
                    destd.bottom := destd.bottom + 2;
                    destd.Right := destd.left + TriangleOffset;
                    destd.top := destd.bottom - TriangleOffset ;
                    plateviewimage.Canvas.CopyRect(Destd, tmpImage.Canvas,Sourced);
                  end;
                else
                begin
                end;
              end;
            end;
          end;
        end;
(*
        T := tmpl.TemplateName;
        tw := plateviewimage.Canvas.TextWidth(T);
        plateviewimage.Canvas.Brush.Style := bsClear;
        plateviewimage.Canvas.TextOut((plateviewimage.Width div 2)- (tw div 2),plateviewimage.Height-Labelplatetext.Height-4,T);
  *)
        plateviewimage.Canvas.Brush.Style := bssolid;
      end;
      if (Pressviewzoom = 50) then
      Begin
        Smallhold     := false;
        smallrelease  := false;
        For ip := 1 to tmpl.NupOnplate do
        begin
          if plate.pages[ip].Anyreleased then
            smallrelease := true;
          if plate.pages[ip].Anyheld then
            smallhold := true;
        end;
        d.left := (plateviewimage.Width div 2)-8;
        d.right := d.Left + 16;
        d.top := 4;
        d.bottom := d.top+16;
        tmpplim.Canvas.Brush.Color := clwhite;
        tmpplim.Canvas.pen.Color := clwhite;
        tmpplim.Canvas.Rectangle(r1616);
      //  tmpplim.Canvas.CopyRect(r1616,FormImage.Imagecolorbrg1616.Canvas,r1616);
        if (Smallhold) And (smallrelease) then
        Begin
          FormImage.ImageListStatus.GetBitmap(31, tmpplim);
        end;
        if (Smallhold) And (Not smallrelease) then
        Begin
          FormImage.ImageListStatus.GetBitmap(33, tmpplim);
        end;
        if (Not Smallhold) And (smallrelease) then
        Begin
          FormImage.ImageListStatus.GetBitmap(32, tmpplim);
        end;
        plateviewimage.Canvas.CopyMode := cmSrcCopy;
        plateviewimage.Canvas.CopyRect(d,tmpplim.Canvas,r1616);
        plateviewimage.Canvas.CopyMode := cmSrcCopy;
      end;
      plateviewimage.Canvas.Brush.Style := bssolid;
      d.Top := plateviewimage.Height-44;
      d.Left := 4;
      d.Right := plateviewimage.Width-4;
      d.Bottom := d.Top+41;

      plateviewimage.Canvas.Brush.Style := bssolid;
      plateviewimage.Canvas.pen.Color := clblack;
      //plateviewimage.Canvas.Rectangle(d);
      //multi korea
      ow  := (d.right - d.left) DIV plate.Copies[1].Ncolors;
      if ow > 32 then
        ow := 32;
      d.left := (plateviewimage.Width - (ow*plate.Copies[1].Ncolors )) div 2;
      d.Right := d.Left + (plate.Copies[1].Ncolors * ow);
      destd.Top := d.Top+1;
      destd.Bottom := d.Bottom-1;
      oh := ((destd.Bottom-destd.Top)-10) div plate.Ncopies;
      sibar.Width := ow;
      sibar.Height := destd.Bottom-destd.top;
      Sourced.Top := 0;
      Sourced.left := 0;
      Sourced.Right := ow;
      Sourced.bottom := destd.Bottom-destd.top;
      if (not Prefs.HidePlateCopyBar) then
      begin
        For i := 1 to plate.Copies[1].Ncolors do
        begin
          if plate.Copies[1].colorstatus[i].Active = 1 then
          begin
            destd.Left := d.Left + (ow * (i-1));
            destd.Right := destd.Left+ow;
            plateviewimage.Canvas.pen.Color := Clwhite;
            plateviewimage.Canvas.Brush.Color := Clwhite;
            plateviewimage.Canvas.Rectangle(destd);
            Ncpdone := 0;
            Ncperror := 0;
            For icpy := 1 to plate.Ncopies do
            begin
              if plate.Copies[icpy].colorstatus[i].Active = 1 then
              begin
                if (plate.Copies[icpy].colorstatus[i].status >= 50) and
                   (plate.Copies[icpy].colorstatus[i].status <> 56) then
                begin
                  Inc(Ncpdone);
                end;
                if (plate.Copies[icpy].colorstatus[i].status = 56) then
                Begin
                  Inc(Ncperror);
                end;
              end;
            end;
            destd.Bottom := d.Bottom-1;
            destd.Top := d.Top+1;
            plateviewimage.Canvas.pen.Color := clGray;
            plateviewimage.Canvas.Brush.Color := Colorsnames[plate.Copies[1].colorstatus[i].colorid].Colorlook;
            plateviewimage.Canvas.Rectangle(destd);

            plateviewimage.Canvas.pen.Color := Clblack;
            // ## 20150422 NAN
            plateviewimage.Canvas.Brush.Color :=  externalstatusarray[ColorEXTstatuss[i]].color; // Clwhite;
            destd.Bottom := destd.top + 15;
            plateviewimage.Canvas.Rectangle(destd);
            w := (ow - plateviewimage.Canvas.TextWidth(inttostr(Ncpdone))) Div 2;
            plateviewimage.Canvas.Brush.Style := bsClear;
            plateviewimage.Canvas.TextOut(destd.Left+ w ,destd.Top, IntToStr(Ncpdone));
            plateviewimage.Canvas.Brush.Style := bssolid;
            // ## 20150422 NAN
            if (Ncpdone = plate.Ncopies) then
              plateviewimage.Canvas.Brush.Color :=  externalstatusarray[ColorEXTstatuss[i]].color; // Clwhite;
            Inc(destd.top,14);
            destd.Bottom := destd.top + 15;
            plateviewimage.Canvas.Rectangle(destd);
            w := (ow - plateviewimage.Canvas.TextWidth(inttostr(plate.Ncopies))) Div 2;
            plateviewimage.Canvas.Brush.Style := bsClear;
            plateviewimage.Canvas.TextOut(destd.Left+ w ,destd.Top,inttostr(plate.Ncopies));
            plateviewimage.Canvas.Brush.Style := bssolid;
          end;
        end;
      end;
      d.Top := 0;
      d.Left := 0;
      d.Right := plateviewimage.Width;
      d.Bottom := plateviewimage.Height;
    end;
    if platesData[platenumber].produce then
    begin
      result := 1;
      if formmain.ActionplateHidecommon.checked then
      begin
        if not anyunique then
          result := 2;
      end;
      if PlatefilterType = 3 then
      begin
        if not anyreceived then
          result := 2;
      end;
    end
    else
      result := 2;
    if not anyactive then
    begin
      result := 0;
    end;
  Except
  end;
  //  plateviewimage.Free;
  tmpImage.free;
  tmpplim.Free;
  sibar.Free;
  si.free;
  ci.free;
end;

function TFPV.GetTriangleImageNumber(PlateColor : Integer; Rotation : Integer) : Integer;
begin
  case (PlateColor) of
    clWebLightgrey,clMedGray :
      begin
        case (Rotation) of
          1: result := 2;// idx 2
          2: result := 0; // idx 0
          3: result := 1;  // idx 1
          4: result := 3;  // idx 3
        end;
      end;

    clYellow :
      begin
        case (Rotation) of
          1: result := 6;// idx 2
          2: result := 4; // idx 0
          3: result := 5;  // idx 1
          4: result := 7;  // idx 3
        end;
      end;

    clLime :
      begin
        case (Rotation) of
          1: result := 10;// idx 2
          2: result := 8; // idx 0
          3: result := 9;  // idx 1
          4: result := 11;  // idx 3
        end;
      end;

    clRed :
      begin
        case (Rotation) of
          1: result := 14;// idx 2
          2: result := 12; // idx 0
          3: result := 13;  // idx 1
          4: result := 15;  // idx 3
        end;
      end;

    clWebMediumBlue :
      begin
        case (Rotation) of
          1: result := 18;// idx 2
          2: result := 16; // idx 0
          3: result := 17;  // idx 1
          4: result := 19;  // idx 3
        end;
      end;

    clWebOrange :
      begin
        case (Rotation) of
          1: result := 22;// idx 2
          2: result := 20; // idx 0
          3: result := 21;  // idx 1
          4: result := 23;  // idx 3
        end;
      end;

    clWebAquamarine :
      begin
        case (Rotation) of
          1: result := 26;// idx 2
          2: result := 24; // idx 0
          3: result := 25;  // idx 1
          4: result := 27;  // idx 3
        end;
      end;
       clWebKhaki :
      begin
        case (Rotation) of
          1: result := 30;// idx 2
          2: result := 28; // idx 0
          3: result := 29;  // idx 1
          4: result := 31;  // idx 3
        end;
      end;
  end;
end;
Function TFPV.loadAPlateFromdata(copyflatseparationset : Integer;
                                 Var Aktshowplate : Tshowplate):Boolean;
Var
  T,anumT : String;
  ip,IC,ICPY,icpcol : Integer;
  ippos,Nppos : Integer;
  ppos : pparray;
  foundcpcol : boolean;
  Afilename : string;
  Aktprevisready
  //,anyactiveincpy
   : Boolean;
  neededactive,Areactive : Integer;
  AFlatproofstatus : Integer;
  ioffset,i,imasteroffset,imaster : Integer;
  thiscolorid : Integer;
Begin
  result := false;
  try
    Try
      result := false;
      writeMainlogfile('loadAPlate start ' + inttostr(0));
      ioffset := 0;
      For i := 1 to NPagetabeldb do
      begin
        if Pagetabeldb[i].CopyFlatSeparationSet = CopyFlatSeparationSet then
        begin
          imasteroffset := i;
          ioffset := i;
          break;
        end;
      end;

      if ioffset < 1 then
      begin
        writeMainlogfile('loadAPlate eof ' + inttostr(-1));
        result := false;
        exit;
      end;
      i := 0;
      if (Prefs.PlateTransmissionSystem)  then
      begin
        anumT := Pagetabeldb[i+ioffset].miscstring2;
        if TUtils.checkstrTal(anumT) then
          Pagetabeldb[ioffset].MasterCopyFlatSeparationSet := strtoint(Pagetabeldb[i+ioffset].miscstring2);
        if (Pagetabeldb[ioffset].MasterCopyFlatSeparationSet <> Pagetabeldb[ioffset].CopyFlatSeparationSet ) then
        begin
          for imaster := 1 to NPagetabeldb do
          begin
            if Pagetabeldb[imaster].CopyFlatSeparationSet = Pagetabeldb[ioffset].MasterCopyFlatSeparationSet then
            begin
              imasteroffset := imaster;
              break;
            end;
          end;
        end;
      end;

      i := 0;
      Aktshowplate.InkError := false;
      if formmain.getinkfolder(1,tnames1.locationnametoid(formmain.ComboBoxpalocationNY.Text)) = '' then
        Aktshowplate.prevready             := -1
      Else
        Aktshowplate.prevready             := 1;

      writeMainlogfile('loadAPlate Aktshowplate.prevready ' + inttostr(Aktshowplate.prevready));
      Aktshowplate.pressid               := Pagetabeldb[i+ioffset].pressid;
      Aktshowplate.runid                 := Pagetabeldb[i+ioffset].pressrunid;
      Aktshowplate.Front                 := Pagetabeldb[i+ioffset].sheetside;
      Aktshowplate.trueFront := Aktshowplate.Front;
      if (Pagetabeldb[i+ioffset].pressCylinder = fronbackstr[0]) or (Pagetabeldb[i+ioffset].pressCylinder = fronbackstr[1]) then
      Begin
        if (Pagetabeldb[i+ioffset].pressCylinder = fronbackstr[0]) then
          Aktshowplate.trueFront := 2
        else
          Aktshowplate.trueFront := 3;
      end;
      writeMainlogfile('loadAPlate Aktshowplate.trueFront ' + inttostr(Aktshowplate.trueFront));
      Aktshowplate.sheetnumber           := Pagetabeldb[i+ioffset].sheetnumber;
      Aktshowplate.CopyFlatSeparationSet := Pagetabeldb[i+ioffset].CopyFlatSeparationSet;
      Aktshowplate.MasterCopyFlatSeparationSet := Pagetabeldb[i+ioffset].masterCopyFlatSeparationSet;
      Aktshowplate.productionID          := Pagetabeldb[i+ioffset].productionID;
      Aktshowplate.IssueID               := Pagetabeldb[i+ioffset].IssueID;
      Aktshowplate.publicationID         := Pagetabeldb[i+ioffset].publicationID;
      Aktshowplate.EditionID             := Pagetabeldb[i+ioffset].EditionID;
      Aktshowplate.locationID            := Pagetabeldb[i+ioffset].locationID;
      Aktshowplate.Miscstring1           := Pagetabeldb[i+ioffset].miscstring1;
      // ### NAN 20151019
      Aktshowplate.MinOutputVersion         := Pagetabeldb[i+ioffset].outputversion;
      Aktshowplate.Altsheet := '';
      Aktshowplate.templatelistid        := inittypes.gettemplatenumberfromID(Pagetabeldb[i+ioffset].templateid);
      if (Prefs.AlternativeSheetnameField) <> '' then
        Aktshowplate.Altsheet := Pagetabeldb[i+ioffset].altsheetname;
      // ny korean bare for sjov
      //Aktshowplate.templatelistid        := Firsttemplateid;

      Aktshowplate.Fullflatlistid        := inittypes.gettemplatenumberfromID(Pagetabeldb[i+ioffset].FlatProofConfigurationID);
      Aktshowplate.Flattproofid          := Formflatproof.Getflatproofid(Pagetabeldb[i+ioffset].FlatProofConfigurationID);
      Aktshowplate.Npages := 1;
      inittypes.markstrtoarray(Pagetabeldb[i+ioffset].MarkGroups,Aktshowplate.markgroups,Aktshowplate.Nmarkgroups);
      for ip := 1 to 32 do
      Begin
        Aktshowplate.Pages[ip].Altpagename := '';
        Aktshowplate.Pages[ip].pagetype := -1;
        Aktshowplate.Pages[ip].Ncolors :=0;
        Aktshowplate.Pages[ip].totapproval := 1;
        Aktshowplate.Pages[ip].Anyheld := false;
        Aktshowplate.Pages[ip].Anyreleased := false;
        Aktshowplate.Pages[ip].PageRotationOverrule := 0;
        Aktshowplate.Pages[ip].PhonyPanorama := 0;
        for ic := 1 to 16 do
        begin
          Aktshowplate.Pages[ip].colors[ic].active := 0;
        end;
      end;
      For icpy := 1 to 16 do
      begin
        Aktshowplate.Copies[ICPY].Ncolors := 0;
        For icpcol := 1 to 16 do
        Begin
           // ### NAN 20151019
          Aktshowplate.Copies[ICPY].colorstatus[icpcol].outputVersion := 100;
          Aktshowplate.Copies[ICPY].colorstatus[icpcol].colorid :=-1;
          Aktshowplate.Copies[ICPY].colorstatus[icpcol].Active := 0;
          Aktshowplate.Copies[ICPY].colorstatus[icpcol].Hold := 0;
          Aktshowplate.Copies[ICPY].colorstatus[icpcol].Status := -1;
          Aktshowplate.Copies[ICPY].colorstatus[icpcol].Flatpagestatus := -1;
          Aktshowplate.Copies[ICPY].colorstatus[icpcol].Inkstatus :=0;
          Aktshowplate.Copies[ICPY].colorstatus[icpcol].Bendingprik := -1;  //0 ingen prik 1 g�n prik 2 r�d prik
          Aktshowplate.Copies[ICPY].colorstatus[icpcol].Sortedprik := -1;   //0 ingen prik 1 g�n prik 2 r�d prik
        end;
      end;
      Aktshowplate.Templatelistid := inittypes.gettemplatenumberfromID(Pagetabeldb[i+ioffset].templateid);
      Aktshowplate.Npages := PlatetemplateArray[Aktshowplate.Templatelistid].NupOnplate;

      For i := 0 to NPagetabeldb do
      begin
        if Pagetabeldb[i+ioffset].CopyFlatSeparationSet <> CopyFlatSeparationSet then
          break;
        ICPY := Pagetabeldb[i+ioffset].Copynumber;
        if (ICPY>4) then
          continue;
        T := Pagetabeldb[i+ioffset].pagepositions;
        Aktshowplate.Copies[ICPY].FlatSeparationSet  := Pagetabeldb[i+ioffset].FlatSeparationSet;
        Aktshowplate.Copies[ICPY].deviceID           := Pagetabeldb[i+ioffset].deviceID;
        Aktshowplate.Copies[ICPY].Tower              := Pagetabeldb[i+ioffset].pressTower;
        Aktshowplate.Copies[ICPY].LowHigh            := Pagetabeldb[i+ioffset].pressHighLow;
        Aktshowplate.Copies[ICPY].SortingPosition    := Pagetabeldb[i+ioffset].sortingposition;

        Aktshowplate.Ncopies := ICPY;
        inittypes.PPOSstrtoarray(t,ppos,Nppos);
        For ippos := 1 to Nppos do
        begin
          Aktshowplate.Pages[ppos[ippos]].UniquePage := Pagetabeldb[i+ioffset].UniquePage;
  //        Aktshowplate.Pages[ppos[ippos]].halfweb := 0;
          Aktshowplate.Pages[ppos[ippos]].pagetype := Pagetabeldb[i+ioffset].pagetype;
          Aktshowplate.Pages[ppos[ippos]].Creep := Pagetabeldb[i+ioffset].Creep;
          Aktshowplate.Pages[ppos[ippos]].SectionID  := Pagetabeldb[i+ioffset].SectionID;
          Aktshowplate.Pages[ppos[ippos]].pagename := Pagetabeldb[i+ioffset].pagename;
          Aktshowplate.Pages[ppos[ippos]].MasterCopySeparationSet := Pagetabeldb[i+ioffset].MasterCopySeparationSet;
          Aktshowplate.Pages[ppos[ippos]].CopySeparationSet := Pagetabeldb[i+ioffset].CopySeparationSet;
          Aktshowplate.Pages[ppos[ippos]].SeparationSet := Pagetabeldb[i+ioffset].SeparationSet;
          Aktshowplate.Pages[ppos[ippos]].OrgeditionID := Aktshowplate.EditionID;
          Aktshowplate.Pages[ppos[ippos]].OrgCopySeparationSet := Aktshowplate.Pages[ppos[ippos]].CopySeparationSet;
          Aktshowplate.Pages[ppos[ippos]].pagina            := Pagetabeldb[i+ioffset].pagination;
          Aktshowplate.Pages[ppos[ippos]].pageindex         := Pagetabeldb[i+ioffset].pageindex;
          Aktshowplate.Pages[ppos[ippos]].Fileserver        := Pagetabeldb[i+ioffset].fileserver;
          Aktshowplate.Pages[ppos[ippos]].miscstring        := Pagetabeldb[i+ioffset].miscstring1;
          Aktshowplate.Pages[ppos[ippos]].PageRotationOverrule := Pagetabeldb[i+ioffset].PageCategoryID;
          Aktshowplate.Pages[ppos[ippos]].PhonyPanorama := (Pagetabeldb[i+ioffset].FanoutID AND 255);

      //    if (Pagetabeldb[i+ioffset].PageCategoryID = 4) AND (Pagetabeldb[i+ioffset].FanoutID = 2) then
      //        Aktshowplate.Pages[ppos[ippos]].PageRotationOverrule := 2;
          if Aktshowplate.Pages[ppos[ippos]].pagetype < 3 then
          begin
            if ICPY = 1 then
              Inc(Aktshowplate.Pages[ppos[ippos]].Ncolors);
            foundcpcol := false;
            For icpcol := 1 to Aktshowplate.Copies[ICPY].Ncolors do
            begin
              if Aktshowplate.Copies[ICPY].colorstatus[icpcol].colorid = Pagetabeldb[i+ioffset].Colorid then
              begin
                foundcpcol := true;
                break;
              end;
            end;
            if not foundcpcol then
            begin
              Inc(Aktshowplate.Copies[ICPY].Ncolors);
              icpcol := Aktshowplate.Copies[ICPY].Ncolors;
              Aktshowplate.Copies[ICPY].colorstatus[icpcol].colorid := Pagetabeldb[i+ioffset].Colorid;
            end;

            if Pagetabeldb[i+ioffset].Active = 1 then
            Begin
              if Aktshowplate.Pages[ppos[ippos]].Altpagename = '' then
              Begin
                Aktshowplate.Pages[ppos[ippos]].Altpagename := Pagetabeldb[i+ioffset].altpagename;
              end;
              if Aktshowplate.Copies[ICPY].colorstatus[icpcol].status = -1 then
              begin
                // F�rste side
                Aktshowplate.Copies[ICPY].colorstatus[icpcol].Active := 1;
                Aktshowplate.Copies[ICPY].colorstatus[icpcol].status := Pagetabeldb[i+ioffset].status;
                Aktshowplate.Copies[ICPY].colorstatus[icpcol].Inkstatus := Pagetabeldb[i+ioffset].Inkstatus;
                Aktshowplate.Copies[ICPY].colorstatus[icpcol].Hold := Pagetabeldb[i+ioffset].Hold;
                Aktshowplate.Copies[ICPY].colorstatus[icpcol].externalstatus := Pagetabeldb[i+ioffset].externalstatus;
                // ### NAN 20151019
                Aktshowplate.Copies[ICPY].colorstatus[icpcol].outputversion := Pagetabeldb[i+ioffset].outputversion;
              end
              Else
              begin
                // N�ste side
                Aktshowplate.Copies[ICPY].colorstatus[icpcol].Active := 1;
                if Aktshowplate.Copies[ICPY].colorstatus[icpcol].status > Pagetabeldb[i+ioffset].status then
                  Aktshowplate.Copies[ICPY].colorstatus[icpcol].status := Pagetabeldb[i+ioffset].status;
                if Pagetabeldb[i+ioffset].Hold = 1 then
                 Aktshowplate.Copies[ICPY].colorstatus[icpcol].Hold := 1;
                // ### NAN 20151019 
                if Pagetabeldb[i+ioffset].outputversion <  Aktshowplate.Copies[ICPY].colorstatus[icpcol].outputversion then
                  Aktshowplate.Copies[ICPY].colorstatus[icpcol].outputversion := Pagetabeldb[i+ioffset].outputversion;
              end;
            end;
            With Aktshowplate.Pages[ppos[ippos]].colors[Aktshowplate.Pages[ppos[ippos]].Ncolors] do
            begin
              if Aktshowplate.Pages[ppos[ippos]].Fileserver = '' then
              begin
                if Pagetabeldb[i+ioffset].fileserver <> '' then
                  Aktshowplate.Pages[ppos[ippos]].Fileserver := Pagetabeldb[i+ioffset].fileserver;
              end;
              UniquePage := Pagetabeldb[i+ioffset].UniquePage;
              Separation  := Pagetabeldb[i+ioffset].separation;
              FlatSeparation    := Pagetabeldb[i+ioffset].flatseparation;
              colorid           := Pagetabeldb[i+ioffset].colorid;
              copynumber        := Pagetabeldb[i+ioffset].copynumber;
              if active = 0 then
              begin
                active := Pagetabeldb[i+ioffset].active;
              end;
              if active = 1 then
              begin
                Aktshowplate.Pages[ppos[ippos]].colors[Aktshowplate.Pages[ppos[ippos]].Ncolors].version           := Pagetabeldb[i+ioffset].version;
                Aktshowplate.Pages[ppos[ippos]].colors[Aktshowplate.Pages[ppos[ippos]].Ncolors].status            := Pagetabeldb[i+ioffset].status;
                Aktshowplate.Pages[ppos[ippos]].colors[Aktshowplate.Pages[ppos[ippos]].Ncolors].externalstatus    := Pagetabeldb[i+ioffset].externalstatus;
                Aktshowplate.Pages[ppos[ippos]].colors[Aktshowplate.Pages[ppos[ippos]].Ncolors].Proofstatus       := Pagetabeldb[i+ioffset].Proofstatus;
                Aktshowplate.Pages[ppos[ippos]].colors[Aktshowplate.Pages[ppos[ippos]].Ncolors].Approved          := Pagetabeldb[i+ioffset].Approved;
                Aktshowplate.Pages[ppos[ippos]].colors[Aktshowplate.Pages[ppos[ippos]].Ncolors].priority          := Pagetabeldb[i+ioffset].priority;
                Aktshowplate.Pages[ppos[ippos]].colors[Aktshowplate.Pages[ppos[ippos]].Ncolors].Hold              := Pagetabeldb[i+ioffset].Hold;
              end;
              if active=1 then
              begin
                if (Pagetabeldb[i+ioffset].Copynumber = 1) and (Pagetabeldb[i+ioffset].Active = 1) then
                begin
                  Aktshowplate.Inkerror := false;
                  if Pagetabeldb[i+ioffset].inkstatus = 6 then
                    Aktshowplate.Inkerror := true;
                  Aktshowplate.Softprevready := false;
                  AFlatproofstatus := Pagetabeldb[i+ioffset].Flatproofstatus;

                  if (AFlatproofstatus = 10) then
                  Begin
                    Afilename := '';
                    if (Prefs.UsePreviewCache) then
                        Afilename := includetrailingbackslash(formmain.getinkfoldercache(1))+inttostr(Aktshowplate.Copies[1].FlatSeparationSet)+'.jpg';
                    if ((not Prefs.UsePreviewCache) or (Prefs.UsePreviewCache and not fileexists(Afilename))) then
                        Afilename := includetrailingbackslash(formmain.getinkfolder(1,tnames1.locationnametoid(formmain.ComboBoxpalocationNY.Text)))+inttostr(Aktshowplate.Copies[1].FlatSeparationSet)+'.jpg';
                    Aktprevisready := fileexists(Afilename);
                    Aktshowplate.Softprevready := true;
                  end;
                  if (Pagetabeldb[i+ioffset].status < 49) then
                  Begin
                    Aktshowplate.prevready := 0;
                  end
                  else
                  begin
                    Case Pagetabeldb[i+ioffset].inkstatus of
                      5 : Begin
                            Aktshowplate.prevready := 1;
                          end;
                      6 : Begin
                            Aktshowplate.prevready := 1;
                          end;
                      9 : Begin
                            Aktshowplate.prevready := 1;
                          end;
                     10 : Begin
                            Aktshowplate.prevready := 2;
                          end;
                     Else
                     Begin
                       Aktshowplate.prevready := 0;
                     end;
                    end;
                  end;
                  
                end;
              end;
              if (Aktshowplate.Inkerror)  then
                Aktshowplate.prevready := 1;
              stackpos := Pagetabeldb[i+ioffset].sortingposition;
              High := Pagetabeldb[i+ioffset].pressHighlow;
              if (Pagetabeldb[i+ioffset].pressCylinder <> fronbackstr[0]) and (Pagetabeldb[i+ioffset].pressCylinder <> fronbackstr[1]) then
                Cylinder := Pagetabeldb[i+ioffset].pressCylinder;
              Zone := Pagetabeldb[i+ioffset].pressZone;
              Aktshowplate.Zone := Pagetabeldb[i+ioffset].pressZone;
              if (Aktshowplate.Pages[ppos[ippos]].pagetype <> 3) and (active = 1) then
              begin
                if (Approved = 2) then
                  Aktshowplate.Pages[ppos[ippos]].totapproval := 2;
                if (Approved = 0) and (Aktshowplate.Pages[ppos[ippos]].totapproval <> 2) then
                  Aktshowplate.Pages[ppos[ippos]].totapproval := 0;
                if hold = 1 then
                  Aktshowplate.Pages[ppos[ippos]].Anyheld := true;
                if hold = 0 then
                  Aktshowplate.Pages[ppos[ippos]].Anyreleased := true;

              end;
            end;
          end;
        end;
       // DataM1.SQLQueryplateupd.next;
      end; // For i := 0 to NPagetabeldb do
     // DataM1.SQLQueryplateupd.close;


      writeMainlogfile('loadAPlate DataM1.SQLQueryplateupd.close ' + inttostr(1));

      if (FlatPageTablePossible) AND (AnyFlatpagetabledata) then
      begin
        writeMainlogfile('loadAPlate  (FlatPageTablePossible) AND (AnyFlatpagetabledata)' + inttostr(1));
        DataM1.SQLQueryplateupd.sql.Clear; //                0                1       2           3            4        5          6          7              8               9
        DataM1.SQLQueryplateupd.sql.add('Select distinct f.flatseparation,f.side,f.processid,f.processtype,f.event,f.message,f.eventtime,p.copynumber,p.flatseparationset,p.colorid ');
        DataM1.SQLQueryplateupd.sql.add('from FlatPageTable f (NOLOCK),pagetable p (NOLOCK)');
        DataM1.SQLQueryplateupd.sql.add('where ((p.status = 46) or (p.status=49))');
        DataM1.SQLQueryplateupd.sql.add('and p.copyflatseparationset = ' + inttostr(aktshowplate.CopyFlatSeparationSet));
        DataM1.SQLQueryplateupd.sql.add('and f.flatseparation = p.flatseparation');
        DataM1.SQLQueryplateupd.sql.add('order by f.flatseparation');
        if Prefs.debug then datam1.SQLQueryplateupd.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'Getflatpagetablestat.sql');
        DataM1.SQLQueryplateupd.open;
        writeMainlogfile('loadAPlate  Getflatpagetablestat.sql open' + inttostr(1));
        While not DataM1.SQLQueryplateupd.eof do
        begin
          ICPY := DataM1.SQLQueryplateupd.fields[7].AsInteger;
          thiscolorid := DataM1.SQLQueryplateupd.fields[9].AsInteger;
          begin
            if ICPY > 32 then
              break;
            if Aktshowplate.Copies[ICPY].FlatSeparationSet = DataM1.SQLQueryplateupd.fields[8].AsInteger then
            begin
              For ic := 1 to Aktshowplate.Copies[ICPY].Ncolors do
              begin
                if Aktshowplate.Copies[ICPY].colorstatus[ic].colorid = thiscolorid then
                begin
                  Aktshowplate.Copies[ICPY].colorstatus[ic].Flatpagestatus := DataM1.SQLQueryplateupd.fields[4].AsInteger;
                  break;
                end;
              end;
            end;
          end;
          DataM1.SQLQueryplateupd.next;
        end;
        DataM1.SQLQueryplateupd.close;
      end;
      result := true;
      writeMainlogfile('loadAPlate  Aktshowplate.Npages' + inttostr(Aktshowplate.Npages));

      neededactive := 0;
      Areactive := 0;
      for ip := 1 to Aktshowplate.Npages do
      begin
        if Aktshowplate.pages[ip].pagetype < 2 then
        begin
          Inc(neededactive);
          for ic := 1 to Aktshowplate.pages[ip].Ncolors do
          begin
            if Aktshowplate.pages[ip].colors[ic].active <> 0 then
            begin
              Inc(Areactive);
              break;
            end;
          end;
        end;
      end;
      if Areactive < neededactive then
        result := false;

      writeMainlogfile('loadAPlate  no exception');
    except
      on E: Exception do
       Begin
         writeMainlogfile('loadAPlate ' + e.Message);
       end;
    end;
  finally
  end;
  writeMainlogfile('loadAPlate end ' + inttostr(0));
end;
end.

