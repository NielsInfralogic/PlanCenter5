unit UPrevPlate2;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.ImageList,System.Actions,System.Contnrs,
  Vcl.ImgList, Vcl.Graphics, Vcl.Controls, Vcl.Forms, System.UITypes,
  Vcl.Dialogs, Vcl.ActnList, Vcl.XPStyleActnCtrls, Vcl.ActnMan, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ToolWin, Vcl.ActnCtrls,  Vcl.FileCtrl,  Vcl.OleCtrls, Vcl.Printers,
  ImageEnProc, ImageEnIO, ieview, ImageEnView, ImageEn,
  Utypes, ULoadDlls,
  HistogramBox, rulerbox, hyieutils,
  iexBitmaps, hyiedefs, iesettings,
  UImages, iexRulers, iexLayers, iexToolbars, iexUserInteractions,
  iexProcEffects;
type
  TFormprevPlate2 = class(TForm)
    ActionManagerpev: TActionManager;
    Actionapprove: TAction;
    Actionreject: TAction;
    Action2: TAction;
    ActionFit: TAction;
    Action1to1: TAction;
    Action90: TAction;
    Action180: TAction;
    Action270: TAction;
    Actionclose: TAction;
    Actionprevchangeprofer: TAction;
    ActionpreviewApproveNext: TAction;
    ActionpreviewDisApproveNext: TAction;
    ActionpreviewNext: TAction;
    Actionprint: TAction;
    ActionSave: TAction;
    Actionprev: TAction;
    ActionpreviewApproveprev: TAction;
    ActionpreviewRejectprev: TAction;
    Actiongotonotapproved: TAction;
    Action1: TAction;
    ActionComment: TAction;
    ActionToolBar1: TActionToolBar;
    PanelSingles: TPanel;
    ImageList1: TImageList;
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    ImageColorshadow: TImage;
    ImageKshadow: TImage;
    ImageColorshadowZone: TImage;
    ImageKshadowZone: TImage;
    ImageEnIO1: TImageEnIO;
    ImageEnProc1: TImageEnProc;
    //InfraStatusBar1: TInfraStatusBar;
    Panelsmallvis: TPanel;
    GroupBoxloading2: TGroupBox;
    ProgressBar1: TProgressBar;
    ActionEmail: TAction;
    PrintDialog1: TPrintDialog;
    SaveDialog1: TSaveDialog;
//    ImageEn1old: TImageEn;
    Actioneditcolors: TAction;
    Actionprevrelease: TAction;
    Actionprevhold: TAction;
    Action3: TAction;
    Actionprevmessure: TAction;
    Actionmovesel: TAction;
    Actionmasked: TAction;
    Actiondoconsole: TAction;
    Actionconsole: TAction;
    Timercosole: TTimer;
    Actionloadspeparations: TAction;
    Action4: TAction;
    ImageEn1: TImageEnView;
    Actionsetfalsespread: TAction;
    TabSheet3: TTabSheet;
    ActionViewpdf: TAction;
    Label6: TLabel;
    StatusBar1: TStatusBar;
    ActionShowNote: TAction;
    BalloonHint: TBalloonHint;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActionFitExecute(Sender: TObject);
    procedure Action1to1Execute(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);

    procedure ActionapproveExecute(Sender: TObject);
    procedure ActionrejectExecute(Sender: TObject);
    procedure ActionCommentExecute(Sender: TObject);
    procedure ActionpreviewApproveNextExecute(Sender: TObject);
    procedure ActionpreviewDisApproveNextExecute(Sender: TObject);
    procedure ActionpreviewNextExecute(Sender: TObject);
    procedure ActionprevExecute(Sender: TObject);
    procedure ActionpreviewApproveprevExecute(Sender: TObject);
    procedure ActionpreviewRejectprevExecute(Sender: TObject);
    procedure ActiongotonotapprovedExecute(Sender: TObject);
    procedure ActionEmailExecute(Sender: TObject);
    procedure ActionprintExecute(Sender: TObject);
    procedure ActionSaveExecute(Sender: TObject);
    procedure ActioncloseExecute(Sender: TObject);
    procedure Action90Execute(Sender: TObject);
    procedure Action180Execute(Sender: TObject);
    procedure Action270Execute(Sender: TObject);
    procedure ActioneditcolorsExecute(Sender: TObject);
    procedure ActionprevreleaseExecute(Sender: TObject);
    procedure ActionprevholdExecute(Sender: TObject);
    procedure ActionprevmessureExecute(Sender: TObject);

    procedure Button1Click(Sender: TObject);
    procedure ActionmoveselExecute(Sender: TObject);
    procedure ActionmaskedExecute(Sender: TObject);
    procedure ActionconsoleExecute(Sender: TObject);
    procedure TimercosoleTimer(Sender: TObject);
    procedure ActionloadspeparationsExecute(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ImageEn1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ImageEn1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ImageEn1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageEn1SelectionChange(Sender: TObject);
    procedure ImageEn1ZoomIn(Sender: TObject; var NewZoom: Double);
    procedure ImageEn1ZoomOut(Sender: TObject; var NewZoom: Double);
    procedure ActionsetfalsespreadExecute(Sender: TObject);
    procedure InfraStatusBar1DrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure ActionShowNoteExecute(Sender: TObject);
  private
    { Private declarations }
    SepInitialization : Boolean;
    DSNInitialization : Boolean;
    ZoneInitialization : Boolean;
    sepsareloaded : Boolean;
    maskisloaded  : Boolean;
    PLogfile : TStrings;
    Pregendnsloaded : Boolean;
    MaskIspossible2 : Boolean;
    lasttime : Tdatetime;
    activated : Boolean;
    Aktproofid : Integer;
    aktProofPDI: Double;
    Aktproofname : string;
    DNSCreated : Boolean;
    SEPScale : Double;
    prevzoom : Double;
//    sepset : Integer;
    ratio : single;
//    zcount : Integer;
//    smallzoom : Double;
    aktazone : Boolean;
    RGBImageEnfilename : String;
    Pregendnsfilename : String;
    Maskfilename : String;
    aktMMposX,aktMMposY : Double;
    Procedure writelogline(logine : String);
    procedure Makereadviewshadow;
    Procedure NextFlatsep(GoTonext : Boolean);
//    procedure Setbluebar;
    Function getmousemmpos(x,y : Integer;
                           Var xm : Double;
                           Var ym : Double):boolean;
    procedure settheallowedarrow;
    procedure applyactionEnable;
    Procedure enabledisableactions;
    procedure rotateimages(rotate : longint);
    Procedure readpageordernext(approve : Integer;  //-1 just move
                                         direction : Integer);
    procedure Apprnext(approve : Integer;  //-1 just move
                       direction : Integer);
    procedure ImageEnsmallMouseDown(Sender: TObject;
                                    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);


    procedure ImageEnsmallViewChange(Sender: TObject; Change: Integer);
    procedure createlevelimage;
    Procedure loadpregendns;
    Procedure loadMaskfile;
    Procedure fastmerge(frombitmap : tbitmap;
                        tobitmap : tbitmap);
  public
    { Public declarations }

    readorderpublicationid : Integer;
    Nreadordercolorfiles : Integer;
    AutoconsolePossible : Boolean;
    Consolemode : Boolean;
    ConsoleType : Integer;
    ConsoleViewType : Integer;
    ConsoleID1,ConsoleID2,ViewID1,ViewID2 : Integer;
    ConsoleNewID : Boolean;
    ConsoleColorid   : Integer;
    Specifikcolorid : Integer;
    viewpressrunid : Integer;
    ZoneOnly : Boolean;
    specificmaster : Integer;
    FirstZoom,firstshow : Boolean;
    pregenreadviewpath : String;
    Copyflatseparationset : Integer;

    Inkflatpreviewpath : string;
    Inkflatpreviewpathcached : string;
    InkflatZonepreviewpath : string;
    InkflatZonepreviewpathcached : string;
    Lowrespath : String;
    Lowrespathcache : string;
    Apath,mainservername : String;
    wherestr : String;
    AktReadorder : Integer;
    prevmaster : Integer;
    PDFmaster : Integer;
    UsePDFMaster : Boolean;
    Flatprevmaster : Integer;

    NReadordermasters : Integer;
    Readordermasters : array[1..1000] of record
                                           IthumbL    : Integer;
                                           IthumbR    : Integer;
                                           pagetypel : Integer;
                                           pagetypeR : Integer;
                                           masterl : Integer;
                                           masterR : Integer;
                                         end;
    activatefrommain : Boolean;
    RGBImageEn,ORGRGBImageEn : TImageEn;
    levelImageEn : TImageEn;
    MaskImageEn : TImageEn;
    PrevmasterL,prevmasterR : Integer;
    NPlates : Integer;
    Plates : array[1..32] of record
                               filename   : String;
                               Colorname  : string;
                               ColorID    : Integer;
                               Colorlook  : Tcolor;
                               ImageEn    :  TImageEn;
                               grpbox     :  TGroupBox;
                               Smallimage : TImageEn;
                               CMYKtype   : Integer;
                               Azone      : Boolean;
                               Fileisloaded : Boolean;
                               filecanbeloaded : Boolean;
                               readcolorI : Integer;
                             end;
   function Myreadorderfile(sFileNameLeft     : string;
                            sFileNameRight    : string;
                            sOutputFileName   : string;
                            nPageTypeLeft      : Integer;
                            nPageTypeRight     : Integer;
                            nPagePositionLeft  : Integer;
                            nPagePositionRight : Integer;
                            nSheetSide         : Integer;
                            nProofID           : Integer;
                            nTemplateID        : Integer;
                            nPublicationid     : Integer;
                            Makedns            : Boolean;
                            MainFile           : Boolean;
                            PubDate            : TDateTime): Integer;

    procedure gotospecific(Amaster : Longint);
    Procedure readpageorderspecific(Amaster : Longint);
    Procedure Clearprev2;
    procedure Trygetsize;
    Function readordermakefile:boolean;
    procedure Setconsoleviewdata;
    procedure Imageactivate;
    procedure loadprevform;
    procedure GetProoferInfo(Proofid : Integer;
                            Flatproof : Boolean);
  end;
var
  FormprevPlate2: TFormprevPlate2;
implementation
uses Usettings, Udata, Umain, Ulogin, Ueditatextcombo, Ufileinfo,
  Uendiscolor, UActionconfig, Uflatproof,DateUtils,math, Urelto,
  UPdfFileInfo, UFiletaginfo, UFalsespread,inifiles, UUtils;
{$R *.dfm}
Const
  Fixedtabs = 3;
  MaxPixelCount = 65536;
Type
  pRGBTripleArray = ^TRGBTripleArray;
  TRGBTripleArray = ARRAY[0..MaxPixelCount-1] OF TRGBTriple;

Var
//  tokeepdebug : Boolean;
  Ireadordercolorfiles : Integer;
  countleft,countright : Integer;
  readordercolorfiles : array[1..32] of record
                                          Colorid  : Integer;
                                          ptypeleft : Integer;
                                          ptypeRight : Integer;
                                          filenameleft : string;
                                          filenameright : string;
                                          tabnumber : Integer;
                                          plateI : Integer;
                                        end;
  platewidth,plateheight : Integer;
  prevzoomsmall : Double;
  CI,MI,KI,YI : Integer;
  KL : pRGBTripleArray;
  CL : pRGBTripleArray;
  ML : pRGBTripleArray;
  YL : pRGBTripleArray;
//  NFixedtabs : Integer;
  InkIsOverLimit : Boolean;

procedure TFormprevPlate2.FormCreate(Sender: TObject);
Var
  I : Integer;
begin




  Formmain.writeinitlog('FormCreate prev2 a');
  firstshow := true;
  Specifikcolorid := -1;
  ZoneOnly := false;
  viewpressrunid := -1;
  activated := false;
  activatefrommain :=true;
  Consolemode := false;
  ConsoleType := -1;
  ConsoleID1   := -1;
  ConsoleID2   := -1;
  ViewID1   := -1;
  ViewID2   := -1;
  ConsoleColorid := -1;
  ConsoleNewID := false;
  Formmain.writeinitlog('FormCreate prev2 b');
  lasttime := 0;
  for i := 1 to 32 do
  begin
    plates[I].ImageEn := TImageEn.Create(nil);
    plates[I].grpbox  := TGroupBox.Create(Panelsmallvis);
    plates[I].grpbox.Parent := Panelsmallvis;
    plates[I].grpbox.top := 3000;
    plates[I].grpbox.Align := altop;
    plates[I].grpbox.Height := (Panelsmallvis.height Div 4)-8;
    plates[i].grpbox.Name := 'grpx'+inttostr(i);
    plates[I].Smallimage := TImageEn.Create(plates[I].grpbox);
    plates[I].Smallimage.Parent := plates[I].grpbox;
    plates[I].Smallimage.Align := alclient;
    plates[i].Smallimage.Name := 'Smallimage'+inttostr(i);
    plates[I].grpbox.Visible := false;
    if (Prefs.PreviewForceGrayBackground) then
        plates[I].ImageEn.Background := clLtGray;
  end;
  Formmain.writeinitlog('FormCreate prev2 c');
  RGBImageEn := TImageEn.Create(nil);
  ORGRGBImageEn := TImageEn.Create(nil);
  levelImageEn := TImageEn.Create(nil);
  MaskImageEn := TImageEn.Create(nil);
  DeleteFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'prevload.txt');
  Formmain.writeinitlog('FormCreate prev2 d');
  PLogfile := TStringList.Create;
  Formmain.writeinitlog('FormCreate prev2 end');
 //  FormprevPlate2.bringtofront;

    // Register the PDFium Plug-In DLL
  IEGlobalSettings().RegisterPlugIns([ iepiPDFium ]);

end;

procedure TFormprevPlate2.FormClose(Sender: TObject; var Action: TCloseAction);
var
  ini : Tinifile;
begin
  IF Prefs.AllowParalelView then
  begin
    try
      ini := TIniFile.Create(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory())+'LastUser.ini');
      ini.writeInteger('Prev2Pos','xpos',FormprevPlate2.Left);
      ini.writeInteger('Prev2Pos','ypos',FormprevPlate2.top);
      Case FormprevPlate2.WindowState of
        wsNormal : Prev2Winstate := 1;
        wsMinimized : Prev2Winstate := 1;
        wsMaximized : Prev2Winstate := 2;
      end;
      ini.writeInteger('Prev2Pos','Winstate',Prev2Winstate);
      ini.writeInteger('Prev2Pos','Width',FormprevPlate2.Width);
      ini.writeInteger('Prev2Pos','Height',FormprevPlate2.Height);
      ini.Free;
    except
    end;
  End;
  activated := false;
  ImageEn1.viewy := 0;
  lasttime := 0;
  activatefrommain := true;
  BalloonHint.HideHint;

  ImageEn1.Align := alclient;
  ImageEn1.visible := true;
end;

procedure TFormprevPlate2.ActionFitExecute(Sender: TObject);
Var
  s : string;
//  I : Double;
begin
  ImageEn1.Fit;
  ImageEn1.refresh;
  str(ImageEn1.Zoom:5:2,s);
  //InfraStatusBar1.Panels[0].Text := 'Scale : ' + s;
  StatusBar1.Panels[0].Text := 'Scale : ' + s;
  FormprevPlate2.Repaint;
end;


procedure TFormprevPlate2.FormActivate(Sender: TObject);
Var
  ini : TIniFile;
Begin



  if (Prefs.AllowParalelView) then
  begin
    ini           := TIniFile.Create(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory())+'LastUser.ini');
    Prev2xpos     := ini.ReadInteger('Prev2Pos','xpos',-9999);
    Prev2ypos     := ini.ReadInteger('Prev2Pos','ypos',-9999);
    Prev2Winstate := ini.ReadInteger('Prev2Pos','Winstate',-9999);
    Prev2Width    := ini.ReadInteger('Prev2Pos','Width',-9999);
    Prev2Height   := ini.ReadInteger('Prev2Pos','Height',-9999);
    ini.Free;
    IF Prev2Winstate > -9999 then
    begin
      FormprevPlate2.WindowState := wsNormal;
      FormprevPlate2.Left        := Prev2xpos;
      FormprevPlate2.top         := Prev2ypos;
      FormprevPlate2.width       := Prev2width;
      FormprevPlate2.height      := Prev2height;
      Case Prev2Winstate of
        1 : FormprevPlate2.WindowState := wsNormal;
        2 : FormprevPlate2.WindowState := wsMaximized;
      end;
    end;
  end;
  IF Not activated then
  Begin
    Imageactivate;
  End;

  IF (Prefs.AllowParalelView) then
  begin
    Actionprint.Visible   := false;
    ActionSave.Visible    := false;
    Actionapprove.Visible := false;
    Actionreject.Visible  := false;
    Action2.Visible       := false;
    Actionprevchangeprofer.Visible      := false;
    ActionpreviewApproveNext.Visible    := false;
    ActionpreviewDisApproveNext.Visible := false;
    ActionpreviewNext.Visible           := false;
    Actionprev.Visible := false;
    ActionpreviewApproveprev.Visible := false;
    ActionpreviewRejectprev.Visible := false;
    Actiongotonotapproved.Visible := false;
    Action1.Visible := false;
    ActionComment.Visible := false;
    ActionEmail.Visible := false;
    Actioneditcolors.Visible := false;
    Actionprevrelease.Visible := false;
    Actionprevhold.Visible := false;
    Actionmasked.Visible := false;
    Actiondoconsole.Visible := false;
    Actionconsole.Visible := false;
    Actionloadspeparations.Visible := false;
    Action4.Visible := false;
    Actionsetfalsespread.Visible := false;
   // ActionViewpdf.Visible := false;

  end;
  if (Prefs.LeanAndMeanPreview) then
  Begin
     Actiondoconsole.Visible := false;
     Actiondoconsole.Enabled := false;
     Actionloadspeparations.Enabled := false;
     Actionloadspeparations.Visible := false;
  End;
  firstshow := false;
  // FormprevPlate2.st
  settheallowedarrow;
  FormprevPlate2.show;
  //   BringWindowToTop(FormprevPlate2.handle);
  // SetForegroundWindow(FormprevPlate2.handle);
  //SetWindowPos(FormprevPlate2.handle,hwnd_TopMost,0,0,0,0,SWP_SHOWWINDOW);
  // NAN - Enable for Hoenywell console mode!!
  if (Prefs.EnsurePreviewFormInFront) then
  begin
    Formmain.bringtofront;
    FormprevPlate2.bringtofront;
  end
  else
  begin
   FormprevPlate2.bringtofront;
  end;
end;

Procedure TFormprevPlate2.writelogline(logine : String);
Var
  T : String;
Begin
  IF Prefs.debug then
  begin
    IF lasttime = 0 then
      lasttime := now;
    IF PLogfile.Count > 1000 then
    begin
      PLogfile.clear;
    end;
    T := formatdatetime('ddmm hh:nn:ss:zzz ',now);
    PLogfile.add(t +' '+  inttostr(millisecondsbetween(now,lasttime)) + #9+ logine);
    PLogfile.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'prevplateload.txt');
    lasttime := now;
  end;
End;

Procedure TFormprevPlate2.fastmerge(frombitmap : tbitmap;
                               tobitmap : tbitmap);
Var
  fromscanline,toscanline : pRGBTripleArray;
  h,w,px,py : Integer;
Begin
  H := frombitmap.Height-1;
  W := frombitmap.width-1;
  for py := 0 to H do
  begin
    fromscanline := frombitmap.ScanLine[py];
    toscanline := tobitmap.ScanLine[py];
    for px := 0 to W do
      toscanline[px] := fromscanline[px];
  End;
end;

procedure TFormprevPlate2.Imageactivate;
Var
  T : string;
Begin
  InkIsOverLimit := false;
  Actionconsole.visible := Prefs.AutoConsole;
  if (Prefs.LeanAndMeanPreview) then
  Begin
    Actionconsole.visible := false; // NAN
    Actionconsole.Enabled := false; // NAN
  End;
  Consolemode := false;
  Actionconsole.checked := false;
  If Consolemode then
    Actionconsole.Caption := 'Console on'
  else
    Actionconsole.Caption := 'Console off';
  IF ActionManagerpev.Images = NIL then
  begin
    ActionManagerpev.Images := FormImage.ImageList1;
  end;
  FirstZoom := true;
  IF lasttime = 0 then
    lasttime := now;
  ImageEn1.Clear;
  Maskfilename := '';
  Actionmasked.Checked := false;
  PLogfile.Clear;
  ImageEn1.viewy := 0;
  PageControl1.ActivePageIndex := 0;
  Case Prefs.PreviewZoomfilter of
    0 : Begin
          IF ImageEn1.ZoomFilter <> rfnone then
            ImageEn1.ZoomFilter := rfnone;
        end;
    1 : Begin
          IF ImageEn1.ZoomFilter <> rfTriangle then
            ImageEn1.ZoomFilter := rfTriangle;
        end;
    2 : Begin
          IF ImageEn1.ZoomFilter <> rfHermite then
            ImageEn1.ZoomFilter := rfHermite;
        end;
    3 : Begin
          IF ImageEn1.ZoomFilter <> rfBell then
            ImageEn1.ZoomFilter := rfBell;
        end;
    4 : Begin
          IF ImageEn1.ZoomFilter <> rfBSpline then
            ImageEn1.ZoomFilter := rfBSpline;
        end;
    5 : Begin
          IF ImageEn1.ZoomFilter <> rfLanczos3 then
            ImageEn1.ZoomFilter := rfLanczos3;
        end;
    6 : Begin
          IF ImageEn1.ZoomFilter <> rfMitchell then
            ImageEn1.ZoomFilter := rfMitchell;
        end;
    7 : Begin
          IF ImageEn1.ZoomFilter <> rfNearest then
            ImageEn1.ZoomFilter := rfNearest;
        end;
    8 : Begin
          IF ImageEn1.ZoomFilter <> rfLinear then
            ImageEn1.ZoomFilter := rfLinear;
        end;
    9 : Begin
          IF ImageEn1.ZoomFilter <> rfFastLinear then
            ImageEn1.ZoomFilter := rfFastLinear;
        end;

  End;
  writelogline('Activate form');
  writelogline('imageen1.update');
  imageen1.update;
  writelogline('Zone off');
  aktazone := false;
  writelogline('imageen1.deselect');
  ImageEn1.DeSelect;
  writelogline('deselected');
  IF Not activated then
  begin
    //Setbluebar;
    activated := true;
  end;
  writelogline('Init imageen');
  ImageEn1.VScrollBarParams.LineStep := 100;
  if (Prefs.PreviewForceGrayBackground) then
    ImageEn1.Background := clLtGray ;

  Actionmovesel.Checked := false;
  ImageEn1.MouseInteract := [miZoom,miScroll];
  //ImageEn1.MouseInteract := [miMovingScroll];
  //ImageEn1.MouseInteract := [];
  Actionprevmessure.Checked := false;


  Actionprevrelease.visible := true;
  Actionprevhold.visible := true;
 
  imageen1.Cursor := crCross;
  writelogline('Cursor set');
  IF activatefrommain then
  begin
    writelogline('Activating from main 1');
    Actiongotonotapproved.Checked := Prefs.PreviewGoToNeedApproval;
    //GroupBoxloading.left := (Panel1.Width -  GroupBoxloading.Width) div 2;
    if (prevmaster > 0) then
    begin
      DataM1.Query1.sql.clear;
      DataM1.Query1.sql.add('Select TOP 1 locationid,editionid,sectionid,pagename,publicationID from pagetable WITH (NOLOCK)');
      DataM1.Query1.sql.add('where dirty=0 AND FlatSeparationSet = ' + inttostr(prevmaster));
      DataM1.Query1.sql.add('and active = 1');
      // DataM1.Query1.sql.add('order by locationid,editionid,sectionid,pagename');
      formmain.Tryopen(DataM1.Query1);
      IF not DataM1.Query1.eof then
      begin
        T := 'Product: '+tnames1.publicationIDtoname(DataM1.Query1.fields[4].asinteger)+'   '+
      //T := 'Location: '+tnames1.locationIDtoname(DataM1.Query1.fields[0].asinteger)+'   '+
           'Edition: '+tnames1.editionIDtoname(DataM1.Query1.fields[1].asinteger)+'   '+
           'Section: '+tnames1.sectionIDtoname(DataM1.Query1.fields[2].asinteger)+'   '+
           'Page: '+DataM1.Query1.fields[3].asstring;
        FormprevPlate2.caption := T;
      end;
      DataM1.Query1.close;
      writelogline('Activating from main 2');

      if (Prefs.PreviewCommentAsCaption) and (not Prefs.LeanAndMeanPreview) then
      begin
        DataM1.Query1.sql.clear;
        datam1.Query1.SQL.Add('Select TOP 1 comment from pagetable with (nolock)');
        datam1.Query1.SQL.Add('where dirty=0 AND mastercopyseparationset = '+inttostr(prevmaster));
        datam1.Query1.open;
        IF not DataM1.Query1.eof then
        begin
          FormprevPlate2.caption := ''''+DataM1.Query1.fields[0].asstring+'''';
        end;
        DataM1.Query1.close;
        writelogline('Activating from main done');
      End;
    End;
    PageControl1.ActivePageIndex := 0;
    if (not Prefs.PreviewSeparationsOnReadview)  AND (not Prefs.LeanAndMeanPreview) then
      TabSheet2.enabled := false;
    writelogline('Call loadprevform');
    loadprevform;
    activatefrommain := false;

  End;
  applyactionEnable;
  IF ImageEn1.Visible then
    ImageEn1.SetFocus;
  writelogline('Activate done');
  (*if (RadioButton1to1.Checked) then
    Prefs.ShowPreviewBestfit := 1
  else if (RadioButtonzoomby.Checked) then
    Prefs.ShowPreviewBestfit := 2
  else
    Prefs.ShowPreviewBestfit := 0;*)
  ImageEn1.ViewY := 0;
  IF FirstZoom then
  begin
    Application.ProcessMessages;
    Sleep(10);
    if Prefs.ShowPreviewBestfit = 1 then
    Begin
      Action1to1Execute(self);
    End
    else
    if Prefs.ShowPreviewBestfit = 0 then
    Begin
    //  Action1to1Execute(self);
    End
    else
    if Prefs.ShowPreviewBestfit = 2 then
    Begin
      ImageEn1.ZoomAt(0,0, Prefs.ShowPreviewInitZoom);
      ImageEn1.refresh;
   //   str(ImageEn1.Zoom:5:2,s);
   //   InfraStatusBar1.Panels[0].Text := 'Scale : ' + s;
//      StatusBar1.Panels[0].Text := 'Scale : ' + s;
      ImageEn1.Refresh;
    end;
    FirstZoom := false;
  End;
  Actionmasked.Enabled := (maskfilename <> '') And (MaskIspossible2 or true) AND  (not Prefs.LeanAndMeanPreview);
 // if (Prefs.LeanAndMeanPreview = false) then
    Trygetsize;
  if (Actionmasked.Enabled) And (Not Actionmasked.checked) and (Prefs.AutoShowMasked) then
  begin
    if maskfilename <> '' then
    begin
      Actionmasked.checked := Not Actionmasked.checked;
      PageControl1Change(self);
    end;
  end;
  IF Not pdfmasterok then
    UsePDFMaster := false;
  IF Usepdfmaster and false then
  begin
    ActionpreviewApproveNext.enabled  := false;
    ActionpreviewDisApproveNext.enabled := false;
    Actionprev.enabled := false;
    ActionpreviewApproveprev.enabled := false;
    ActionpreviewApproveprev.enabled := false;
    ActionpreviewRejectprev.enabled := false;
    Actiongotonotapproved.enabled := false;
    ActionpreviewNext.enabled := false;
    settheallowedarrow;
  end
  else
  begin
    ActionpreviewApproveNext.enabled  := true;
    ActionpreviewDisApproveNext.enabled := true;
    Actionprev.enabled := true;
    ActionpreviewApproveprev.enabled := true;
    ActionpreviewApproveprev.enabled := true;
    ActionpreviewRejectprev.enabled := true;
    Actiongotonotapproved.enabled := true;
    ActionpreviewNext.enabled := true;
  end;
  if (Prefs.AllowParalelView) then
  begin
    Actionprint.Visible := false;
    ActionSave.Visible := false;
    Actionapprove.Visible := false;
    Actionreject.Visible := false;
    Action2.Visible := false;
    Actionprevchangeprofer.Visible := false;
    ActionpreviewApproveNext.Visible := false;
    ActionpreviewDisApproveNext.Visible := false;
    ActionpreviewNext.Visible := false;
    Actionprev.Visible := false;
    ActionpreviewApproveprev.Visible := false;
    ActionpreviewRejectprev.Visible := false;
    Actiongotonotapproved.Visible := false;
    Action1.Visible := false;
    ActionComment.Visible := false;
    ActionEmail.Visible := false;
    Actioneditcolors.Visible := false;
    Actionprevrelease.Visible := false;
    Actionprevhold.Visible := false;
    Actionmasked.Visible := false;
    Actiondoconsole.Visible := false;
    Actionconsole.Visible := false;
    Actionloadspeparations.Visible := false;
    Action4.Visible := false;
    Actionsetfalsespread.Visible := false;
  end;
  if (Prefs.LeanAndMeanPreview) then
  Begin
   Actionloadspeparations.Enabled := false;
   Actionloadspeparations.Visible := false;
  End;
  settheallowedarrow;
  //Formmain.show;
  //FormprevPlate2.show;
//  if activatefrommain then
  //  Formmain.bringtofront;
  //FormprevPlate2.bringtofront;
 // if (Prefs.ShowSizeInformation = false) AND (Prefs.ShowInkDensityInformation = false) then
  //  Panelpageinfo.Visible := false;
end;

procedure TFormprevPlate2.settheallowedarrow;
Var
//  pract : boolean;
  I{,i2} : Integer;
begin
  applyactionEnable;
  For i := 0 to ActionManagerpev.ActionCount-1 do
  begin
    TAction(ActionManagerpev.Actions[i]).Visible := TAction(ActionManagerpev.Actions[i]).enabled;
  end;
 (*
 pract := false;
  For i := 0 to FormActionconfig.TreeViewactions.items.Count-1 do
  begin
    IF FormActionconfig.TreeViewactions.items[i].Level = 0 then
    begin
      if FormActionconfig.TreeViewactions.items[i].Text = 'Preview Window' then
        pract := true;
    end
    Else
    Begin
      IF pract then
      begin
        For i2 := 0 to FormprevPlate2.ActionManagerpev.ActionCount -1 do
        Begin
          IF Tactdatype(FormActionconfig.TreeViewactions.items[i].data^).Name = FormprevPlate2.ActionManagerpev.Actions[i2].Name then
          begin
            if proversion = 2 then
            begin
              IF FormActionconfig.TreeViewactions.items[i].stateindex = 2 then
              begin
                TAction(FormprevPlate2.ActionManagerpev.Actions[i2]).Enabled := false;
                TAction(FormprevPlate2.ActionManagerpev.Actions[i2]).Visible := false;
              end;
            end
            else
            begin
              IF FormActionconfig.TreeViewactions.items[i].stateindex = 2 then
              begin
                TAction(FormprevPlate2.ActionManagerpev.Actions[i2]).Enabled := false;
                TAction(FormprevPlate2.ActionManagerpev.Actions[i2]).Visible := false;
              end;
            end;
            break;
          end;
        End;
      End;
    End;
  End;
  *)
end;

procedure TFormprevPlate2.ApplyActionEnable;
Var
  pract : boolean;
  I,i2 : Integer;
//  t : string;
begin
  pract := false;
  For i := 0 to FormActionconfig.TreeViewactions.items.Count-1 do
  begin
    if FormActionconfig.TreeViewactions.items[i].Level = 0 then
    begin
      if FormActionconfig.TreeViewactions.items[i].Text = 'Preview Window' then
        pract := true;
    end
    Else
    Begin
      IF pract then
      begin
        For i2 := 0 to FormprevPlate2.ActionManagerpev.ActionCount -1 do
        Begin
          IF Tactdatype(FormActionconfig.TreeViewactions.items[i].data^).Name = FormprevPlate2.ActionManagerpev.Actions[i2].Name then
          begin
            IF FormActionconfig.TreeViewactions.items[i].stateindex = 2 then
              TAction(FormprevPlate2.ActionManagerpev.Actions[i2]).Enabled := false;
            break;
          end;
        end;
      end;
    End;
  End;
  if (Prefs.LeanAndMeanPreview) then
    Actionconsole.visible := false;
End;

procedure TFormprevPlate2.LoadPrevForm;
Var
  I : Integer;
  Colorname : string;
  B : tbitmap;
  d : trect;
  loadok : Boolean;
  NewTabSheet : TTabSheet;
  S,afname,T : String;
  tid : Tdatetime;
  AFileprevmaster : Integer;
  ZoneIsmaster : Boolean;
  CanfindZone : Boolean;
  frespdf,fres,Ifindz : Integer;
  F,FORGPDf : Tsearchrec;
  PreviewGUID, testpath,testpath2 : String;
  sPageComment : String;
  rectCommentRect,
  rectText       : trect;
  iCommentLayer : Integer;
  CommentNoteRect : TRect;
  BalPosLeft,
  BalPosRight : Integer;
  tpath : string;
begin
  Inkflatpreviewpath := '';
  Inkflatpreviewpathcached := '';
  PageControl1.Pages[2].Visible := false;
  PageControl1.Pages[2].TabVisible := false;
  if (Prefs.LeanAndMeanPreview) then
  Begin
   ActionViewpdf.Visible := false;
   ActionViewpdf.Enabled := false;
   Actionconsole.Visible := false;
   Actionconsole.Enabled := false;
  End;
  ActionShowNote.Visible := Prefs.ShowPageNoteIndicator;
  ActionShowNote.Enabled := Prefs.ShowPageNoteIndicator;
  SepInitialization := false;
  DSNInitialization := false;
  ZoneInitialization := false;
  sepsareloaded := false;
  maskisloaded := false;
  Pregendnsloaded := false;

  SepInitialization := Prefs.PreviewPreloadPlateSeparations;
  DSNInitialization := Prefs.PreviewPreloadPlateDns;
  ZoneInitialization := Prefs.PreviewPreloadInkzones;

  if (Prefs.PreviewShowInkZones) then
    ZoneInitialization := true;

  tid := now;
  loadok := true;
  lasttime := now;
  DNSCreated := False;
  writelogline('Loadprevform 1');
  PageControl1.Pages[1].TabVisible := true;
  PageControl1.Pages[2].TabVisible := false;
  Actionloadspeparations.Enabled := true;
  //NAN
  Actionloadspeparations.Enabled := false;


  try
    PanelSingles.visible := Prefs.PreviewShowSidebar;
    Aktproofid := -1;
    aktProofPDI := -1;
    Aktproofname := '';
    Pregendnsfilename := '';
    Maskfilename := '';
    MaskIspossible2 := false;
//    levelImageEn.IO.
    //InfraStatusBar1.Panels[8].Text :='';
    StatusBar1.Panels[8].Text :='';
    SEPScale := -1;
    pregenreadviewpath := '';
    writelogline('Loadprevform 2');
    enabledisableactions;
    writelogline('Loadprevform 3');
    Panelsmallvis.visible := false;
    //GroupBoxloading.visible := true;
    ProgressBar1.Position := 0;
    ProgressBar1.Max := 100;
    writelogline('Loadprevform repaint');
    FormprevPlate2.Repaint;
    writelogline('Loadprevform grbbox off');
    For i := 1 to 32 do
    begin
      plates[i].grpbox.Visible := false;
      plates[i].Fileisloaded := false;
      plates[i].filecanbeloaded := false;
      Plates[i].ColorID := -1;
      Plates[i].Colorname := '';
      Plates[i].filename := '';
      Plates[i].CMYKtype := -1;
      Plates[i].Azone := false;
    end;
    writelogline('Loadprevform 4');
    try
      PanelSingles.Width := Prefs.PreviewSidebarWidth;
      B := tbitmap.create;
      PageControl1.Height := Canvas.TextHeight('H_')+12;
      While PageControl1.PageCount > Fixedtabs do
      begin
        PageControl1.Pages[PageControl1.PageCount-1].Destroy;
      end;
      While ImageList1.Count > Fixedtabs do
      begin
        ImageList1.Delete(ImageList1.Count-1);
      end;
      writelogline('Loadprevform 5');
      //InfraStatusBar1.Panels[1].Text := 'Loading';
      StatusBar1.Panels[1].Text := 'Loading';
      b.Width := 16;
      b.Height := 16;
      d.Top := 0;
      d.Left := 0;
      d.Right := 15;
      d.Bottom := 15;
      writelogline('Loadprevform 6');

        writelogline('LoadPlate 1');
        maskispossible2 := false;
        if (Prefs.PlateTransmissionSystem) then
          AFileprevmaster := flatprevmaster
        else
          AFileprevmaster := prevmaster;

        DataM1.Query1.Sql.Clear;
        DataM1.Query1.Sql.Add('select TOP 1 FlatProofConfigurationID from pagetable (NOLOCK) ');
        DataM1.Query1.Sql.Add(' where flatseparationset = ' + inttostr(AFileprevmaster));
        DataM1.Query1.Open;
        IF Not DataM1.Query1.Eof then
          Aktproofid := Formflatproof.Getflatproofid(DataM1.Query1.fields[0].AsInteger);
        DataM1.Query1.Close;
        writelogline('LoadPlate 2');
        GetProoferInfo(Aktproofid,true);
        writelogline('LoadPlate 3');
        NPlates := 0;
        IF true then
        begin
          writelogline('LoadPlate 4');
          DataM1.Query1.sql.clear;
          DataM1.Query1.sql.add('select distinct p1.colorid,cn.colororder from pagetable p1 (NOLOCK),colornames cn (NOLOCK)');
          DataM1.Query1.sql.add('where p1.flatseparationset = ' + inttostr(AFileprevmaster));
          DataM1.Query1.sql.add('and cn.colorid = p1.colorid');
          DataM1.Query1.sql.add('and p1.active = 1');
          DataM1.Query1.sql.add('order by cn.colororder');
          DataM1.Query1.Open;

          writelogline('LoadPlate 5');
          Inkflatpreviewpath := formmain.getinkfolder(1,tnames1.locationnametoid(formmain.ComboBoxpalocationNY.Text));
          if (Prefs.UsePreviewCache) then
            Inkflatpreviewpathcached := IncludeTrailingBackslash(FormMain.GetInkFolderCache(1));



          if (DSNInitialization) then
          begin
            IF Pregendnsfilename = '' then
            begin
              if (Prefs.UsePreviewCache) then
                 Pregendnsfilename :=  Inkflatpreviewpathcached +IntToStr(AFileprevmaster)+'_dns'+'.jpg';
              if ((not Prefs.UsePreviewCache) or (Prefs.UsePreviewCache and not fileexists(Pregendnsfilename))) then
                 Pregendnsfilename := Inkflatpreviewpath+IntToStr(AFileprevmaster)+'_dns'+'.jpg';

              if not fileexists(Pregendnsfilename) then
                Pregendnsfilename := ''
              else
                LoadPregenDns;
            end;
          end
          else
            Pregendnsfilename := '';

          while not DataM1.Query1.eof do
          begin
            Colorname := Colorsnames[DataM1.Query1.fields[0].asinteger].name;
 (*           Inkflatpreviewpath := formmain.getinkfolder(1,tnames1.locationnametoid(formmain.ComboBoxpalocationNY.Text));
            IF (DSNInitialization) then
            Begin
              IF Pregendnsfilename = '' then
              begin
                Pregendnsfilename := Inkflatpreviewpath+inttostr(AFileprevmaster)+'_dns'+'.jpg';
                writelogline(Pregendnsfilename);
                IF not fileexists(Pregendnsfilename) then
                  Pregendnsfilename := ''
                Else
                  loadpregendns;
              End;
            End
            Else
              Pregendnsfilename := '';
  *)
            if (Uppercase(colorname) = 'PDF') then
            begin
             tpath := '';
             if (Prefs.UsePreviewCache) then
               tpath := Inkflatpreviewpathcached+inttostr(AFileprevmaster)+'_C.jpg';
             if ((not Prefs.UsePreviewCache) or (Prefs.UsePreviewCache and not fileexists(tpath))) then
                tpath := Inkflatpreviewpath+inttostr(AFileprevmaster)+'_C.jpg';
             IF fileexists(tpath) then
             begin
                Inc(NPlates);
                Plates[NPlates].ColorID := 1;
                Plates[NPlates].Colorname := 'C';
                Plates[NPlates].Colorlook := Colorsnames[1].Colorlook;
                Plates[NPlates].filename := tpath;
                Plates[NPlates].CMYKtype := -1;
                Plates[NPlates].Azone := false;
                Plates[NPlates].Fileisloaded := false;
                Plates[NPlates].filecanbeloaded := true;
              End;
             tpath := '';
             if (Prefs.UsePreviewCache) then
               tpath := Inkflatpreviewpathcached+inttostr(AFileprevmaster)+'_M.jpg';
             if ((not Prefs.UsePreviewCache) or (Prefs.UsePreviewCache and not fileexists(tpath))) then
                tpath := Inkflatpreviewpath+inttostr(AFileprevmaster)+'_M.jpg';
             IF fileexists(tpath) then
             begin
                Inc(NPlates);
                Plates[NPlates].ColorID := 2;
                Plates[NPlates].Colorname := 'M';
                Plates[NPlates].Colorlook := Colorsnames[2].Colorlook;
                Plates[NPlates].filename := tpath;
                Plates[NPlates].CMYKtype := -1;
                Plates[NPlates].Azone := false;
                Plates[NPlates].Fileisloaded := false;
                Plates[NPlates].filecanbeloaded := true;
              End;
              tpath := '';
             if (Prefs.UsePreviewCache) then
               tpath := Inkflatpreviewpathcached+inttostr(AFileprevmaster)+'_Y.jpg';
             if ((not Prefs.UsePreviewCache) or (Prefs.UsePreviewCache and not fileexists(tpath))) then
                tpath := Inkflatpreviewpath+inttostr(AFileprevmaster)+'_Y.jpg';
             IF fileexists(tpath) then
             begin
                Inc(NPlates);
                Plates[NPlates].ColorID := 3;
                Plates[NPlates].Colorname := 'Y';
                Plates[NPlates].Colorlook := Colorsnames[3].Colorlook;
                Plates[NPlates].filename := tpath;
                Plates[NPlates].CMYKtype := -1;
                Plates[NPlates].Azone := false;
                Plates[NPlates].Fileisloaded := false;
                Plates[NPlates].filecanbeloaded := true;
              End;
             tpath := '';
             if (Prefs.UsePreviewCache) then
               tpath := Inkflatpreviewpathcached+inttostr(AFileprevmaster)+'_K.jpg';
             if ((not Prefs.UsePreviewCache) or (Prefs.UsePreviewCache and not fileexists(tpath))) then
                tpath := Inkflatpreviewpath+inttostr(AFileprevmaster)+'_K.jpg';
             IF fileexists(tpath) then
             begin
                Inc(NPlates);
                Plates[NPlates].ColorID := 4;
                Plates[NPlates].Colorname := 'K';
                Plates[NPlates].Colorlook := Colorsnames[4].Colorlook;
                Plates[NPlates].filename := tpath;
                Plates[NPlates].CMYKtype := -1;
                Plates[NPlates].Azone := false;
                Plates[NPlates].Fileisloaded := false;
                Plates[NPlates].filecanbeloaded := true;
              End;

            end
            else    // not PDF
            begin
             tpath := '';
             if (Prefs.UsePreviewCache) then
               tpath := Inkflatpreviewpathcached+inttostr(AFileprevmaster)+'_'+colorname+'.jpg';
             if ((not Prefs.UsePreviewCache) or (Prefs.UsePreviewCache and not fileexists(tpath))) then
                tpath := Inkflatpreviewpath+inttostr(AFileprevmaster)+'_'+colorname+'.jpg';

             IF fileexists(tpath) then
             begin
               Inc(NPlates);
                Plates[NPlates].ColorID := DataM1.Query1.fields[0].asinteger;
                Plates[NPlates].Colorname := colorname;
                Plates[NPlates].Colorlook := Colorsnames[Plates[NPlates].ColorID].Colorlook;
                Plates[NPlates].filename := tpath;
                Plates[NPlates].CMYKtype := -1;
                Plates[NPlates].Azone := false;
                Plates[NPlates].Fileisloaded := false;
                Plates[NPlates].filecanbeloaded := true;
                writelogline('LoadPlate ' +  Plates[NPlates].filename);
              End;
            end;
            DataM1.Query1.next;
          end;
          DataM1.Query1.close;
        End;


        writelogline('LoadPlate GetInkfolder');
       // Inkflatpreviewpath := formmain.getinkfolder(1,tnames1.locationnametoid(formmain.ComboBoxpalocationNY.Text));
        ProgressBar1.max := NPlates+2;
        writelogline('LoadPlate CHK INK file');

        tpath := '';
        if (Prefs.UsePreviewCache) then
           tpath := Inkflatpreviewpathcached+inttostr(AFileprevmaster)+'.jpg';
         if ((not Prefs.UsePreviewCache) or (Prefs.UsePreviewCache and not fileexists(tpath))) then
            tpath := Inkflatpreviewpath+inttostr(AFileprevmaster)+'.jpg';

        IF fileexists(tpath) then
        begin
          writelogline('LoadPlate Get INK file');
          RGBImageEnfilename := tpath;
          RGBImageEn.IO.LoadFromFileJpeg(RGBImageEnfilename);
          ProgressBar1.Position := ProgressBar1.Position +1;
          writelogline('LoadPlate Get INK file done');
        End
        Else
        Begin
          loadok := false;
          writelogline('LoadPlate NO INK file');
        End;


        IF (formmain.getinkfolder(3,tnames1.locationnametoid(formmain.ComboBoxpalocationNY.Text)) <> '') And (ZoneInitialization ) then
        begin
          DataM1.Query1.sql.clear;
          DataM1.Query1.sql.add('select distinct p1.colorid,cn.colororder from pagetable p1 (NOLOCK),colornames cn (NOLOCK) where p1.flatseparationset = ' + inttostr(AFileprevmaster));
          DataM1.Query1.sql.add('and cn.colorid = p1.colorid');
          DataM1.Query1.sql.add('and p1.active = 1');
          DataM1.Query1.sql.add('order by cn.colororder');
          DataM1.Query1.open;
          writelogline('LoadPlate Get INK zonefile Start');
          while not DataM1.Query1.eof do
          begin
            Colorname := Colorsnames[DataM1.Query1.fields[0].asinteger].name;


            InkflatZonepreviewpath := IncludeTrailingBackSlash(formmain.getinkfolder(3,tnames1.locationnametoid(formmain.ComboBoxpalocationNY.Text)));
            if (Prefs.UsePreviewCache) then
              InkflatZonepreviewpathcached := IncludeTrailingBackslash(FormMain.GetInkFolderCache(3));
            CanfindZone := false;
            zoneIsmaster := true;
            tpath := '';
            if (Prefs.UsePreviewCache) then
              tpath := InkflatZonepreviewpathcached+inttostr(AFileprevmaster)+'_'+colorname+'.jpg';
            if ((not Prefs.UsePreviewCache) or (Prefs.UsePreviewCache and not fileexists(tpath))) then
              tpath := InkflatZonepreviewpath+inttostr(AFileprevmaster)+'_'+colorname+'.jpg';

            IF fileexists(tpath) then
            begin
              Inc(NPlates);
              Plates[NPlates].ColorID := DataM1.Query1.fields[0].asinteger;
              Plates[NPlates].Colorname := colorname;
              Plates[NPlates].Colorlook := Colorsnames[Plates[NPlates].ColorID].Colorlook;
              Plates[NPlates].filename := tpath;
              Plates[NPlates].CMYKtype := 8;
              Plates[NPlates].Azone := true;
              Plates[NPlates].Fileisloaded := false;
              writelogline('LoadPlate Get INK zonefile ' + Plates[NPlates].filename);
            End
            Else
            begin
              //ADB-01-B-1270104.jpg
              AfName := '';
              if (Prefs.UsePreviewCache) then
                AfName := InkflatZonepreviewpathcached+'*-'+inttostr(AFileprevmaster)+'0'+inttostr(tnames1.Colornametoid(colorname))+'.jpg';
              if ((not Prefs.UsePreviewCache) or (Prefs.UsePreviewCache and not fileexists(AfName))) then
                AfName := InkflatZonepreviewpath+'*-'+inttostr(AFileprevmaster)+'0'+inttostr(tnames1.Colornametoid(colorname))+'.jpg';

              IF fileexists(AfName) then
              begin
                if (Prefs.UsePreviewCache) then
                  Ifindz := FindFirst(InkflatZonepreviewpathcached+'*-'+inttostr(AFileprevmaster)+'0'+inttostr(tnames1.Colornametoid(colorname))+'.jpg',faArchive,F)
                else
                  Ifindz := FindFirst(InkflatZonepreviewpath+'*-'+inttostr(AFileprevmaster)+'0'+inttostr(tnames1.Colornametoid(colorname))+'.jpg',faArchive,F);
                IF Ifindz = 0 then
                begin
                  AfName := f.Name;
                end;
                Findclose(f);
                Inc(NPlates);
                Plates[NPlates].ColorID := DataM1.Query1.fields[0].asinteger;
                Plates[NPlates].Colorname := colorname;
                Plates[NPlates].Colorlook := Colorsnames[Plates[NPlates].ColorID].Colorlook;
                Plates[NPlates].filename := InkflatZonepreviewpath+AfName;
                Plates[NPlates].CMYKtype := 8;
                Plates[NPlates].Azone := true;
                Plates[NPlates].Fileisloaded := false;
                writelogline('LoadPlate Get INK zonefile ' + Plates[NPlates].filename);
              End;
            end;


            //IF fileexists(InkflatZonepreviewpath+inttostr(AFileprevmaster)+'_'+colorname+'.jpg') then
            //begin
            //End;
            DataM1.Query1.next;
          end;
          DataM1.Query1.close;
        End;


     
    except
      loadok := false;
    end;

    If loadok then
    begin
      writelogline('Loadfiles start');
      For i := 1 to nplates Do
      begin
        writelogline('Loadfiles1 num ' + inttostr(i) );
        b.Canvas.Brush.Color := plates[i].Colorlook;
        b.Canvas.Rectangle(d);
        IF not plates[i].Azone then
        begin
          IF GetRValue(plates[i].Colorlook) + GetBValue(plates[i].Colorlook) + GetGValue(plates[i].Colorlook) = 0 then
          Begin
            b.Canvas.CopyMode := cmSrcCopy	;
            b.Canvas.CopyRect(d,ImageKshadow.Canvas,d);
          end
          else
          begin
            b.Canvas.CopyMode := cmSrcAnd;
            b.Canvas.CopyRect(d,ImageColorshadow.Canvas,d);
          end;
        End
        Else
        begin
          IF GetRValue(plates[i].Colorlook) + GetBValue(plates[i].Colorlook) + GetGValue(plates[i].Colorlook) = 0 then
          Begin
            b.Canvas.CopyMode := cmSrcCopy	;
            b.Canvas.CopyRect(d,ImageKshadowZone.Canvas,d);
          end
          else
          begin
            b.Canvas.CopyMode := cmSrcAnd;
            b.Canvas.CopyRect(d,ImageColorshadowZone.Canvas,d);
          end;
        end;
        writelogline('Loadfiles2 num ' + inttostr(i) );
        ImageList1.AddMasked(b,clwhite);
        writelogline('Loadfiles3 num ' + inttostr(i) );
        NewTabSheet := TTabSheet.Create(PageControl1);
        NewTabSheet.Name := 'Sheet'+inttostr(i);
        NewTabSheet.PageControl := PageControl1;
        NewTabSheet.Caption := plates[i].Colorname;
        NewTabSheet.ImageIndex := (i+Fixedtabs)-1;
        plates[I].grpbox.Align := alnone;
        platewidth  := RGBImageEn.Bitmap.width;
        plateheight := RGBImageEn.Bitmap.height;
        writelogline('Loadfiles4 num ' + inttostr(i) );
        IF (not plates[i].Azone) and (plates[i].filename <> '') then
        begin
          plates[i].ImageEn.AutoStretch := true;
          plates[i].ImageEn.Bitmap.Width := platewidth;
          plates[i].ImageEn.Bitmap.height := plateheight;
          writelogline('Loadfiles5 num ' + inttostr(i) );
          IF sepInitialization then
          begin
            plates[i].ImageEn.IO.LoadFromFileJpeg(plates[i].filename);
            Plates[i].Fileisloaded := true;
            sepsareloaded := true;
          end
          else
          begin
            plates[i].ImageEn.IEBitmap.CopyFromTBitmap(RGBImageEn.Bitmap);
            plates[i].ImageEn.Proc.Fill(clnone);
          end;
          writelogline('Loadfiles6 num ' + inttostr(i) );
          IF (plates[i].ImageEn.Bitmap.Width <> RGBImageEn.Bitmap.Width) or (plates[i].ImageEn.Bitmap.height <> RGBImageEn.Bitmap.height) then
              plates[i].ImageEn.Proc.Resample(RGBImageEn.Bitmap.Width,RGBImageEn.Bitmap.Height,rfNone);
          writelogline('Loadfiles7 num ' + inttostr(i) );
          plates[i].ImageEn.Bitmap.Width := platewidth;
          plates[i].ImageEn.Bitmap.height := plateheight;
          plates[i].ImageEn.AutoStretch := true;
          writelogline('Loadfiles8 num ' + inttostr(i) );
          plates[i].ImageEn.update;
          writelogline('Loadfiles9 num ' + inttostr(i) );
        End;
        writelogline('Loadfiles10 num ' + inttostr(i) );
        ProgressBar1.Position := ProgressBar1.Position +1;
        IF not plates[i].Azone then
        begin
          plates[i].grpbox.Visible := true;
          plates[I].grpbox.Height := (Panelsmallvis.height Div 4)-8;
          plates[i].grpbox.caption := plates[i].colorname;
          plates[I].grpbox.top := 3000;
          plates[I].grpbox.Align := altop;
          writelogline('Loadfiles11 num ' + inttostr(i) );
          if (Prefs.PreviewShowSidebar) then
          begin
            plates[i].Smallimage.Bitmap.Width := plates[i].ImageEn.bitmap.Width;
            plates[i].Smallimage.Bitmap.height := plates[i].ImageEn.bitmap.height;
            plates[i].Smallimage.MouseInteract := [miScroll];//[miScroll];
            plates[i].Smallimage.ScrollBars := ssNone;
            plates[i].Smallimage.SelectionOptions := [iesoAnimated,iesoSizeable,iesoMoveable];
            plates[i].Smallimage.OnMouseDown :=ImageEnsmallMouseDown;
            plates[i].Smallimage.OnViewChange := ImageEnsmallViewChange;
            writelogline('Loadfiles12 num ' + inttostr(i) );
            fastmerge(plates[i].ImageEn.Bitmap,plates[i].Smallimage.Bitmap);
            writelogline('Loadfiles13 num ' + inttostr(i) );
            plates[i].Smallimage.update;
            writelogline('Loadfiles14 num ' + inttostr(i) );
            plates[i].Smallimage.fit;
            prevzoomsmall := plates[i].Smallimage.Zoom;
            writelogline('Loadfiles15 num ' + inttostr(i) );
          End;
          ProgressBar1.Position := ProgressBar1.Position+1;
          ProgressBar1.Repaint;
          writelogline('Loadfiles16 num ' + inttostr(i) );
        End;
      end;
      writelogline('Loadfiles done ');
      For i := 1 to Nplates do
      begin
        IF Not plates[i].Azone then
        begin
          IF (Uppercase(plates[i].Colorname) = 'C') or (Uppercase(plates[i].Colorname) = 'CYAN') then
          Begin
            plates[i].CMYKtype := 1;
          End;
          IF (Uppercase(plates[i].Colorname) = 'M') or (Uppercase(plates[i].Colorname) = 'MAGENTA') then
          Begin
            plates[i].CMYKtype := 2;
          End;
          IF (Uppercase(plates[i].Colorname) = 'Y') or (Uppercase(plates[i].Colorname) = 'YELLOW') then
          Begin
            plates[i].CMYKtype := 3;
          End;
          IF (Uppercase(plates[i].Colorname) = 'K') or (Uppercase(plates[i].Colorname) = 'BLACK') or
             (Uppercase(plates[i].Colorname) = 'GRAY') then
          Begin
            plates[i].CMYKtype := 4;
          End;
        End;
      End;
      writelogline('Init imageds start');
      CI := -1;
      MI := -1;
      KI := -1;
      YI := -1;
      For i := 1 to Nplates do
      begin
        IF plates[i].CMYKtype = 1 then
        begin
          CI := i;
        end;
        IF plates[i].CMYKtype = 2 then
        begin
          MI := i;
        end;
        IF plates[i].CMYKtype = 3 then
        begin
          YI := i;
        end;
        IF plates[i].CMYKtype = 4 then
        begin
          KI := i;
        end;
      End;
      platewidth  := RGBImageEn.Bitmap.width;
      plateheight := RGBImageEn.Bitmap.height;
      levelImageEn.Bitmap.Width := platewidth;
      levelImageEn.Bitmap.height := plateheight;
      MaskImageEn.Bitmap.Width := platewidth;
      MaskImageEn.Bitmap.height := plateheight;


      writelogline('Init imageds 1');
      IF (Prefs.PreviewUsePregeneratedDns) And (not Prefs.GrayDensityMap) then
      begin
        writelogline('Init imageds loadpregen');
        loadpregendns;
      end
      else
      begin
        writelogline('Init imageds MAKEpregen');
        if SepInitialization then
        Begin
          writelogline('Init calling createlevelimage');
          createlevelimage;
        End;
      end;      //Actionmasked.checked := false;
      if (SepInitialization) or (Prefs.AutoShowMasked) or (Actionmasked.checked AND Actionmasked.enabled) then
        loadMaskfile;
      writelogline('Init imageds 2');
      ProgressBar1.Position := ProgressBar1.Position +1;
      ratio := RGBImageEn.height / RGBImageEn.Width;
      ImageEn1.Bitmap.Width := platewidth;
      ImageEn1.Bitmap.height := plateheight;
      writelogline('Init imageds 3');
    end;

    IF loadok then
    Begin
      writelogline('Init imageds 5');
      ImageEn1.Proc.Merge(RGBImageEn.Bitmap,0);
      writelogline('Init imageds 6');
      IF (Prefs.ShowPreviewBestfit = 0) then
      Begin
        ImageEn1.ZoomAt(0,0,100);
        writelogline('Init imageds fit to screen');
        ImageEn1.Fit;
        writelogline('Init imageds fit to screen Done');
        str(ImageEn1.Zoom:5:2,s);
        //InfraStatusBar1.Panels[0].Text := 'Scale : ' + s;
        StatusBar1.Panels[0].Text := 'Scale : ' + s;
      end;
      writelogline('Init imageds 7');
      IF (Prefs.ShowPreviewBestfit = 1) then
      Begin
        ImageEn1.ZoomAt(0,0,100);
        str(ImageEn1.Zoom:5:2,s);
        //InfraStatusBar1.Panels[0].Text := 'Scale : ' + s;
        StatusBar1.Panels[0].Text := 'Scale : ' + s;
        ImageEn1.ViewX := 0;
        ImageEn1.ViewY := 0;
      End;
      writelogline('Init imageds 8');
      prevzoom :=ImageEn1.Zoom;
      if CI > -1 then
      begin
      //  plates[CI].ImageEn.Center := true;
        plates[CI].ImageEn.Zoom := ImageEn1.Zoom;
      end;
      if MI > -1 then
      Begin
        plates[MI].ImageEn.Zoom := ImageEn1.Zoom*Sepscale;
      End;
      if YI > -1 then
      Begin
        plates[YI].ImageEn.Zoom := ImageEn1.Zoom*Sepscale;
      End;
      if KI > -1 then
      Begin
        plates[KI].ImageEn.Zoom := ImageEn1.Zoom*Sepscale;
      End;
      For i := 1 to Nplates do
      begin
        IF Not plates[i].Azone then
        begin
          (*plates[I].ImageEn.AutoStretch := true;
          plates[I].ImageEn.Width := RGBImageEn.Width;
          plates[I].ImageEn.Height := RGBImageEn.Height;
                                                  *)
          // .ImageResize(RGBImageEn.IOParams.JPEG_OriginalWidth,RGBImageEn.IOParams.JPEG_OriginalHeight);
//          plates[I].ImageEn.Zoom *sepscale;
        End;
      End;
      writelogline('Init imageds 9');
    End
    Else
    begin
      MessageDlg(formmain.InfraLanguage1.Translate('Image not available'), mtInformation,[mbOk], 0);
    end;
  Finally

    writelogline('Finally 1');
    //InfraStatusBar1.Panels[7].Text := '';
    StatusBar1.Panels[7].Text := '';
    //InfraStatusBar1.Panels[4].Text := '';
    StatusBar1.Panels[4].Text := '';
    //InfraStatusBar1.Panels[5].Text := '';
    StatusBar1.Panels[5].Text := '';
    IF Aktproofid > 0 then
    begin
      //InfraStatusBar1.Panels[6].Text := Aktproofname;
      StatusBar1.Panels[6].Text := Aktproofname;
      IF aktProofPDI > 0 then
      //  InfraStatusBar1.Panels[5].Text := 'Jpg res: ' + FormatFloat('0.0',aktProofPDI);
        StatusBar1.Panels[5].Text := 'Jpg res: ' + FormatFloat('0.0',aktProofPDI);
    End;
    writelogline('Finally 2');
    ImageEn1.update;
    writelogline('Finally 3');
    Panelsmallvis.visible := Prefs.PreviewShowSidebar;
    writelogline('Finally 4');
    b.free;

    writelogline('Finally 5');
//    PageControl1.Pages[2].Visible := maskfilename <> '';

  End;
(*
  For i := 1 to Nplates do
  begin
    plates[i].ImageEn.width := RGBImageEn.Bitmap.width;
    plates[i].ImageEn.height := RGBImageEn.Bitmap.height;
    plates[i].ImageEn.ZoomFilter := RGBImageEn.ZoomFilter;
    plates[i].ImageEn.Zoom := RGBImageEn.Zoom;
  End;
  *)


  IF Not MaskIspossible2 then
  begin
    Actionmasked.checked := false;
    Actionmasked.enabled := false;
  end
  else
  begin
    IF Actionmasked.checked then
      PageControl1Change(self);
   End;
 (*
  IF ( (SepInitialization) and (plateviewing) ) OR
     ( (Pregendnsfilename = '') or (not fileexists(Pregendnsfilename)) ) then
  begin
    PageControl1.Pages[1].TabVisible := false;
    PageControl1.Pages[1].Enabled := false;
  End;
  *)
  (*
  If ( (Pregendnsfilename = '') or (not fileexists(Pregendnsfilename))) AND (Not DNSCreated) then
  begin
    PageControl1.Pages[1].TabVisible := false;
    PageControl1.Pages[1].Enabled := false;
  end;
  *)
  IF (Not Pregendnsloaded) then
  begin
    PageControl1.Pages[1].TabVisible := false;
    PageControl1.Pages[1].Enabled := false;
  end;
  try
    IF AutoconsolePossible then
    begin

      ConsoleViewType := 3;
      ViewID1 := prevmaster;
      ViewID1 := -1;
      IF ZoneOnly then
        ConsoleViewType := 4;

      Setconsoleviewdata;
    end;

  except
  end;
 // InfraStatusBar1.Panels[8].Text := 'time : ' + inttostr(millisecondsbetween(now,tid));
 // StatusBar1.Panels[8].Text := 'time : ' + inttostr(millisecondsbetween(now,tid));
 //  FormprevPlate2.bringtofront;
End;

procedure TFormprevPlate2.Action1to1Execute(Sender: TObject);
Var
  s : string;
//  I : Double;
begin
  ImageEn1.ZoomAt(0,0,100);
  ImageEn1.refresh;
  str(ImageEn1.Zoom:5:2,s);
  //InfraStatusBar1.Panels[0].Text := 'Scale : ' + s;
  StatusBar1.Panels[0].Text := 'Scale : ' + s;
  ImageEn1.ViewX := 0;
  ImageEn1.ViewY := 0;
end;

procedure TFormprevPlate2.PageControl1Change(Sender: TObject);
Var
  zonechange : Boolean;
  FromZonetonorm : Boolean;
begin
  FromZonetonorm := false;
  zonechange := aktazone;
  IF not sepsareloaded then
  begin
    IF not plates[(PageControl1.ActivePageIndex-Fixedtabs)+1].Azone then
    begin
      ActionloadspeparationsExecute(self);
    end;
  end;
  ImageEn1.Align := alclient;
  ImageEn1.visible := true;


  Case PageControl1.ActivePageIndex of
    0 : Begin
          IF (Actionmasked.Checked) and (Maskfilename <> '') then
          begin
            IF aktazone then
            Begin
              FromZonetonorm := true;
              MaskImageEn.IO.SaveToFile(IncludeTrailingBackSlash(TUtils.GetTempDirectory())+'XX.jpg');
              ImageEn1.IO.LoadFromFile(IncludeTrailingBackSlash(TUtils.GetTempDirectory())+'XX.jpg');
              aktazone := false;
            end
            else
            Begin
              fastmerge(MaskImageEn.Bitmap,ImageEn1.Bitmap);
            end;
          end
          Else
          begin
            IF aktazone then
            Begin
              FromZonetonorm := true;
              RGBImageEn.IO.SaveToFile(IncludeTrailingBackSlash(TUtils.GetTempDirectory())+'XX.jpg');
              ImageEn1.IO.LoadFromFile(IncludeTrailingBackSlash(TUtils.GetTempDirectory())+'XX.jpg');
              aktazone := false;
            end
            else
            Begin
              fastmerge(RGBImageEn.Bitmap,ImageEn1.Bitmap);
            end;
          end;
        end;
    1 : Begin
          IF aktazone then
          begin
            levelImageEn.IO.SaveToFile(IncludeTrailingBackSlash(TUtils.GetTempDirectory())+'XX.jpg');
            ImageEn1.IO.LoadFromFile(IncludeTrailingBackSlash(TUtils.GetTempDirectory())+'XX.jpg');
            aktazone := false;
          end
          else
            fastmerge(levelImageEn.Bitmap,ImageEn1.Bitmap);
        end;
     2 :Begin
        end;
    Else
    begin
      IF (Not plates[(PageControl1.ActivePageIndex-Fixedtabs)+1].Azone) And (zonechange) then
        FromZonetonorm := true;
      IF (plates[(PageControl1.ActivePageIndex-Fixedtabs)+1].Azone) and (Not plates[(PageControl1.ActivePageIndex-Fixedtabs)+1].Fileisloaded) then
      begin
        plates[(PageControl1.ActivePageIndex-Fixedtabs)+1].ImageEn.IO.LoadFromFileJpeg(plates[(PageControl1.ActivePageIndex-Fixedtabs)+1].filename);
        plates[(PageControl1.ActivePageIndex-Fixedtabs)+1].Fileisloaded := true;
      end;
      IF aktazone = plates[(PageControl1.ActivePageIndex-Fixedtabs)+1].Azone then
        fastmerge(plates[(PageControl1.ActivePageIndex-Fixedtabs)+1].ImageEn.Bitmap,ImageEn1.Bitmap)
      Else
      begin
        plates[(PageControl1.ActivePageIndex-Fixedtabs)+1].ImageEn.IO.SaveToFile(IncludeTrailingBackSlash(TUtils.GetTempDirectory())+'XX.jpg');
        ImageEn1.IO.LoadFromFile(IncludeTrailingBackSlash(TUtils.GetTempDirectory())+'XX.jpg');
        aktazone := Not aktazone;
      end;
    End;
  End;

  //if PageControl1.ActivePageIndex <> 2 then
  //begin
    ImageEn1.update;
    IF (FromZonetonorm) then
    begin
      IF (Prefs.ShowPreviewBestfit = 0) then
        ActionFit.Execute
      else
      IF (Prefs.ShowPreviewBestfit = 1) then
      Begin
        Action1to1.Execute;
      End;
    end
    else
    begin
      IF (aktazone <> zonechange) and (aktazone) then
        ActionFit.Execute;
   // End;

    ImageEn1.PdfViewer.Enabled := false;

  //End
 // Else    // PDF view.
 // Begin
 //  ImageEn1.PdfViewer.Enabled := true;
   // IF AcroPDF1 <> nil then
    //begin
    //  AcroPDF1.Visible := true;
    //  if (AcroPDF1.Visible) and (AcroPDF1 <> nil) then
    //  begin
//        FocusControl(nil);
//        FocusControl(AcroPDF1);
     // end;
   // End;
  End;
end;

procedure TFormprevPlate2.createlevelimage;
Var
  colorscale : Array[0..400] of tcolor;
procedure makecolorscale(max : Integer;
                         color1,color2,color3,color4 : tcolor);
Var
  r1,g1,b1,rs,gs,bs : real;
  r2,g2,b2,I{,y} : Integer;
//  acol : tcolor;
  {i1,}i2,i3 : Integer;

procedure normalizergb;
Begin
  if r1 > 255 then r1 := 255;
  if g1 > 255 then g1 := 255;
  if b1 > 255 then b1 := 255;
  if r1 < 0 then   r1 := 0;
  if g1 < 0 then   g1 := 0;
  if b1 < 0 then   b1 := 0;
end;

Procedure applycolorandcalcstep(acolor1,acolor2 : tcolor;
                                steplengt : Longint);
Begin
  r1 := GetRValue(acolor1);
  g1 := GetGValue(acolor1);
  b1 := GetBValue(acolor1);
  r2 := GetRValue(acolor2);
  g2 := GetGValue(acolor2);
  b2 := GetBValue(acolor2);
  rs := (r2-r1) / steplengt;
  gs := (g2-g1) / steplengt;
  bs := (b2-b1) / steplengt;
end;

begin
  i2 := max;
  i3 := ((390-max) div 2);
  applycolorandcalcstep(clwhite,color1,i2);
  For I := 0 to i2 do
  begin
    r1 := r1+rs;
    g1 := g1+gs;
    b1 := b1+bs;
    colorscale[i] := rgb(round(r1),round(g1),round(b1));
  end;
  applycolorandcalcstep(color1,color2,10);
  For I := i2 to i2+10 do
  begin
    r1 := r1+rs;
    g1 := g1+gs;
    b1 := b1+bs;
    colorscale[i] := rgb(round(r1),round(g1),round(b1));
  end;
  applycolorandcalcstep(color2,color3,i3);
  For I := i2+10 to i2+i3+10 do
  begin
    r1 := r1+rs;
    g1 := g1+gs;
    b1 := b1+bs;
    colorscale[i] := rgb(round(r1),round(g1),round(b1));
  end;
  applycolorandcalcstep(color3,color4,i3);
  For I := i2+i3+10 to i2+i3+10+i3 do
  begin
    r1 := r1+rs;
    g1 := g1+gs;
    b1 := b1+bs;
    colorscale[i] := rgb(round(r1),round(g1),round(b1));
  end;
end;
Var
  px,py : Integer;
  h,w : Integer;
  C,M,Y,K,I : Integer;
  CColor : pRGBTripleArray;
  Max : Integer;
begin
  try
    max := Prefs.InkWarningLevel;
    if max > 400 then
      max := 380;
    IF max < 10 then
      max := 20;
    makecolorscale(max,clyellow,rgb(255,128,0),clred,clblack);

    H := levelImageEn.Bitmap.Height-1;
    W := levelImageEn.Bitmap.width-1;
    for py := 0 to H do
    begin
      IF CI > -1 then
        CL := plates[CI].ImageEn.Bitmap.ScanLine[py];
      IF MI > -1 then
        ML := plates[MI].ImageEn.Bitmap.ScanLine[py];
      IF YI > -1 then
        YL := plates[YI].ImageEn.Bitmap.ScanLine[py];
      IF KI > -1 then
        KL := plates[KI].ImageEn.Bitmap.ScanLine[py];
      CColor := levelImageEn.Bitmap.ScanLine[py];
      for px := 0 to W do
      Begin
        C := 0;
        M := 0;
        Y := 0;
        K := 0;
        IF KI > -1 then
        begin
          K := KL[px].rgbtRed;
          IF K > 253 then
            K := 253;
          K := 253-K;
        End;
        IF CI > -1 then
        begin
          C := CL[px].rgbtRed;
          IF C > 253 then
            C := 253;
          C := 253-C;
        End;
        IF MI > -1 then
        begin
          M := ML[px].rgbtGreen;
          IF M > 253 then
            M := 253;
          M := 253-M;
        End;
        IF YI > -1 then
        begin
          Y := YL[px].rgbtBlue;
          IF Y > 253 then
            Y := 253;
          Y := 253-Y;
        End;
        I := C+M+K+Y;
        I := (I * 400) div 1012;
        CColor[px].rgbtBlue := GetBValue(colorscale[i]);
        CColor[px].rgbtGreen := GetGValue(colorscale[i]);
        CColor[px].rgbtRed := GetRValue(colorscale[i]);
        if (Prefs.GrayDensityMap) then
        begin
          IF I < 10 then
          begin
            CColor[px].rgbtBlue := 255;
            CColor[px].rgbtGreen := 255;
            CColor[px].rgbtRed := 255;
          end;
          IF (I >= 10) and (i < max-50) then
          begin
            CColor[px].rgbtBlue := 232;
            CColor[px].rgbtGreen := 232;
            CColor[px].rgbtRed := 232;
          end;

          IF (I >= max-50) and (i < max-25) then
          begin
            CColor[px].rgbtBlue := 212;
            CColor[px].rgbtGreen := 212;
            CColor[px].rgbtRed := 212;
          end;
          IF (I >= max-25) and (i < max) then
          begin
            CColor[px].rgbtBlue := 192;
            CColor[px].rgbtGreen := 192;
            CColor[px].rgbtRed := 192;
          end;
          IF  (i >= max) then
          begin
            CColor[px].rgbtBlue := 0;
            CColor[px].rgbtGreen := 0;
            CColor[px].rgbtRed := 255;
          end;
        End;
      End;
    end;
    Pregendnsloaded := true;
    DNSCreated := True;
  Except
  End;
end;

procedure TFormprevPlate2.ImageEnsmallMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var
  I : Integer;
  NewZoom : double;
Begin
  NewZoom := 1;
  Case Button of
    mbLeft :
        NewZoom := TImageEn(sender).zoom + 5;
    mbRight :
        NewZoom := TImageEn(sender).zoom - 5;
  End;
  TImageEn(sender).zoom := newzoom;
  prevzoomsmall := newzoom;
  for i := 1 to nplates do
  begin
    if plates[i].Smallimage.Name <> TImageEn(sender).Name then
    Begin
      plates[i].Smallimage.Zoom := newzoom;
      plates[i].Smallimage.ViewX := TImageEn(sender).viewx;
      plates[i].Smallimage.ViewY := TImageEn(sender).viewY;
    End;
  end;
end;

procedure TFormprevPlate2.ImageEnsmallViewChange(Sender: TObject; Change: Integer);
Var
  i : Integer;
begin
  for i := 1 to nplates do
  begin
    if (change = 0) and (TImageEn(plates[i].Smallimage).Name <> TImageEn(sender).Name) then
    Begin
      TImageEn(plates[i].Smallimage).ViewX := TImageEn(sender).viewx;
      TImageEn(plates[i].Smallimage).ViewY := TImageEn(sender).viewY;
    End;
  End;
end;


procedure TFormprevPlate2.Apprnext(approve : Integer;  //-1 just move
                                direction : Integer);
Var
  {I,}aktpindex : Integer;
  Copyseparationsets : TStrings;
  Newmast : Integer;
  eventtime : tdatetime;
  t,Incopyseps : String;
begin
  IF lasttime = 0 then
    lasttime := now;
  Copyseparationsets := TStringList.Create;
  try
    IF (approve <> -1) then
    begin
      DataM1.Query1.sql.clear;
      DataM1.Query1.sql.add('update pagetable set approved = '+inttostr(approve));
      if usepdfmaster then
        // ## NAN 20150204
//            DataM1.Query1.sql.add('where pdfmaster = ' + inttostr(prevmaster))
        DataM1.Query1.sql.add('where (pdfmaster>0 AND pdfmaster = ' + inttostr(prevmaster) + ') OR (pdfmaster=0 AND mastercopyseparationset = ' + inttostr(prevmaster) + ')')
      else
        DataM1.Query1.sql.add('where mastercopyseparationset = ' + inttostr(prevmaster));
      DataM1.Query1.ExecSQL(false);
      if usepdfmaster then
        formmain.afterapproval(-1,prevmaster)
      Else
        formmain.afterapproval(prevmaster,-1);
      IF approve = 1 then
      begin
        IF (Prefs.RemoveMissingColorsOnApprove) then
        Begin
          DataM1.Query1.sql.clear;
          DataM1.Query1.sql.add('update pagetable Set active = 0');
          if usepdfmaster then
            // ## NAN 20150204
//            DataM1.Query1.sql.add('where pdfmaster = ' + inttostr(prevmaster))
            DataM1.Query1.sql.add('where (pdfmaster>0 AND pdfmaster = ' + inttostr(prevmaster) + ') OR (pdfmaster=0 AND mastercopyseparationset = ' + inttostr(prevmaster) + ')')
          else
          DataM1.Query1.sql.add('where mastercopyseparationset = ' + inttostr(prevmaster));
          DataM1.Query1.sql.add('and status = 0 ');
          DataM1.Query1.ExecSQL(false);
        End;
      End;
      Incopyseps := '(';
      DataM1.Query1.sql.clear;
      DataM1.Query1.sql.add('select Distinct Copyseparationset from pagetable with (nolock) ');
      if usepdfmaster then
            // ## NAN 20150204
//        DataM1.Query1.sql.add('where pdfmaster = ' + inttostr(prevmaster))
            DataM1.Query1.sql.add('where (pdfmaster>0 AND pdfmaster = ' + inttostr(prevmaster) + ') OR (pdfmaster=0 AND mastercopyseparationset = ' + inttostr(prevmaster) + ')')
      else
      DataM1.Query1.sql.add('where mastercopyseparationset = ' + inttostr(prevmaster));
      DataM1.Query1.Open;
      while not DataM1.Query1.eof do
      begin
        Copyseparationsets.add(DataM1.Query1.fieldbyname('Copyseparationset').asstring);
        Incopyseps := Incopyseps +DataM1.Query1.fieldbyname('Copyseparationset').asstring;
        DataM1.Query1.next;
        IF not DataM1.Query1.eof then
          Incopyseps := Incopyseps +',';
      end;
      DataM1.Query1.close;
      Incopyseps := Incopyseps +')';
      IF (approve = 1) then
      begin
        DataM1.Query1.sql.add('update pagetable');
        DataM1.Query1.sql.add('set approvetime = getdate(),approveuser='+''''+Prefs.username+'''');
        DataM1.Query1.sql.add('where Copyseparationset in ' + Incopyseps );
        DataM1.Query1.execsql(false);
        IF (Prefs.LogApproval) then
        begin
          eventtime := -1;
          formmain.Addlogentry(70,Prefs.username,eventtime,-1,-1,-1,prevmaster,-1,-1,-1);
        End;
      End;
    End;
  Finally
    Copyseparationsets.Free;
  End;
  IF approve = 2 then
  begin
    Nselectedmasters := 0;
    formmain.addtoselectedmasters(prevmaster);
    Formmain.sendedisapprovemail(-1,'Page disapproved',1);
    if (Prefs.LogDisapproval) then
    begin
      eventtime := -1;
      formmain.Addlogentry(71,Prefs.username,eventtime,-1,-1,-1,prevmaster,-1,-1,-1);
    End;
  end;

  Try
    DataM1.Query1.sql.clear;
    DataM1.Query1.sql.add('Select TOP 1 p1.pageindex from pagetable p1 with (nolock) ');
    IF pos('WHERE',uppercase(wherestr)) = 0 then
      DataM1.Query1.sql.add('WHERE ');
    DataM1.Query1.sql.add(wherestr);
    DataM1.Query1.sql.add('And p1.mastercopyseparationset = ' + inttostr(prevmaster));
    DataM1.Query1.open;
    aktpindex := DataM1.Query1.fields[0].asinteger;
    DataM1.Query1.close;
    DataM1.Query1.sql.clear;
    DataM1.Query1.sql.add('Select TOP 1 mastercopyseparationset,priority,colorid,pagename,pageindex,active from pagetable p1 (NOLOCK)');
    IF pos('WHERE',uppercase(wherestr)) = 0 then
      DataM1.Query1.sql.add('WHERE ');

    DataM1.Query1.sql.add(wherestr);
    DataM1.Query1.sql.add('And active = 1');
    DataM1.Query1.sql.add('and proofstatus > 0');

    if Actiongotonotapproved.checked then
      DataM1.Query1.sql.add('and approved = 0');
    DataM1.Query1.sql.add('and status >= 10');
    Case direction of
       -1 : begin
                DataM1.Query1.sql.add('and pageindex < ' + inttostr(aktpindex));
            end;
        1 : begin
              DataM1.Query1.sql.add('and pageindex > ' + inttostr(aktpindex));
            end;
    end;
    DataM1.Query1.sql.add('and not exists(');
    DataM1.Query1.sql.add('Select P2.mastercopyseparationset from pagetable p2 (NOLOCK)');
    DataM1.Query1.sql.add('Where p1.mastercopyseparationset = p2.mastercopyseparationset');
    DataM1.Query1.sql.add('and (p2.status < 10 or p2.proofstatus = 0)');
    DataM1.Query1.sql.add('and p2.active = 1)');
    IF direction = -1 then
      DataM1.Query1.sql.add('order by p1.pageindex desc')
    else
      DataM1.Query1.sql.add('order by p1.pageindex');
    Newmast := -1;
    IF Prefs.debug then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'nextappr.sql');
    DataM1.Query1.open;
    IF not DataM1.Query1.eof then
    Begin
      Newmast := DataM1.Query1.fieldbyname('mastercopyseparationset').asinteger;
      prevmaster := Newmast;
    End;
    DataM1.Query1.close;
    prevmaster := Newmast;

    DataM1.Query1.sql.clear;
    DataM1.Query1.sql.add('Select TOP 1 locationid,editionid,sectionid,pagename,PublicationID from pagetable (NOLOCK) ');
    DataM1.Query1.sql.add('where mastercopyseparationset = ' + inttostr(prevmaster));
    DataM1.Query1.sql.add('and active = 1');
    //DataM1.Query1.sql.add('order by locationid,editionid,sectionid,pagename');
    formmain.Tryopen(DataM1.Query1);
    if not DataM1.Query1.eof then
    begin
      T := 'Product: '+tnames1.publicationIDtoname(DataM1.Query1.fields[4].asinteger)+'   '+
           'Edition: '+tnames1.editionIDtoname(DataM1.Query1.fields[1].asinteger)+'   '+
           'Section: '+tnames1.sectionIDtoname(DataM1.Query1.fields[2].asinteger)+'   '+
           'Name: '+DataM1.Query1.fields[3].asstring;
      FormprevPlate2.Caption := T;
      //DataM1.Query1.next;
    end;
    DataM1.Query1.close;

    IF prevmaster > -1 then
    begin
      loadprevform;
    end
    Else
    begin
      FormprevPlate2.close;
    end;
  except
  end;
  settheallowedarrow;
end;

procedure TFormprevPlate2.ActionCommentExecute(Sender: TObject);
Var
//  I : Integer;
//  n,c : ttreenode;
//  foundone : boolean;
//  Inliste : String;
  eventtime : tdatetime;
begin
  Formeditatext.Caption := 'Change page comment';
  Formeditatext.Label1.Caption := 'Comment';
  Formeditatext.ComboBox1.Items.Clear;
  datam1.Query1.SQL.Clear;
  datam1.Query1.SQL.Add('Select Distinct comment from pagetable (NOLOCK)');
  if usepdfmaster then
    // ## NAN 20150204
    //DataM1.Query1.sql.add('where pdfmaster = ' + inttostr(prevmaster))
    DataM1.Query1.sql.add('where (pdfmaster>0 AND pdfmaster = ' + inttostr(prevmaster) + ') OR (pdfmaster=0 AND mastercopyseparationset = ' + inttostr(prevmaster) + ')')
  else
    DataM1.Query1.sql.add('where mastercopyseparationset = ' + inttostr(prevmaster));
  datam1.Query1.open;
  While not datam1.Query1.eof do
  begin
    Formeditatext.ComboBox1.Items.add(datam1.Query1.fields[0].asstring);
    datam1.Query1.next;
  end;
  datam1.Query1.Close;
  Formeditatext.ComboBox1.text := '';
  IF Formeditatext.ComboBox1.Items.Count > 0 then
    Formeditatext.ComboBox1.Itemindex := 0;
  if Formeditatext.showmodal = mrok then
  begin
    datam1.Query1.SQL.Clear;
    datam1.Query1.SQL.Add('Update pagetable set comment = ' +''''+Formeditatext.ComboBox1.text+'''');
    if usepdfmaster then
    // ## NAN 20150204
//      DataM1.Query1.sql.add('where pdfmaster = ' + inttostr(prevmaster))
      DataM1.Query1.sql.add('where (pdfmaster>0 AND pdfmaster = ' + inttostr(prevmaster) + ') OR (pdfmaster=0 AND mastercopyseparationset = ' + inttostr(prevmaster) + ')')
    else
      DataM1.Query1.sql.add('where mastercopyseparationset = ' + inttostr(prevmaster));
    formmain.trysql(datam1.Query1);
    eventtime := -1;
    if (Prefs.PreviewCommentAsCaption) then
    begin
      FormprevPlate2.caption := ''''+Formeditatext.ComboBox1.text+'''';
    End;
  End;
End;
procedure TFormprevPlate2.ActionpreviewApproveNextExecute(Sender: TObject);
begin
  Actionprevmessure.Checked := false;
  Actionmovesel.Checked := false;
  ImageEn1.MouseInteract := [miZoom,miScroll];
  imageen1.Cursor := crCross;
  ImageEn1.DeSelect;
  Actionconsole.Checked := false;
  Actionconsole.Caption := 'Console off';

    Apprnext(1,1);
end;

procedure TFormprevPlate2.ActionpreviewDisApproveNextExecute(Sender: TObject);
begin
  Actionprevmessure.Checked := false;
  Actionmovesel.Checked := false;
  ImageEn1.MouseInteract := [miZoom,miScroll];
  imageen1.Cursor := crCross;
  ImageEn1.DeSelect;
  Actionconsole.Checked := false;
  Actionconsole.Caption := 'Console off';

    Apprnext(2,1);
end;

procedure TFormprevPlate2.ActionpreviewNextExecute(Sender: TObject);
begin
  Actionconsole.Checked := false;
  Actionconsole.Caption := 'Console off';
  Actionprevmessure.Checked := false;
    Actionmovesel.Checked := false;
    ImageEn1.MouseInteract := [miZoom,miScroll];
    imageen1.Cursor := crCross;
    ImageEn1.DeSelect;

    NextFlatsep(true);

end;

procedure TFormprevPlate2.ActionprevExecute(Sender: TObject);
begin
Actionprevmessure.Checked := false;
    Actionmovesel.Checked := false;
    ImageEn1.MouseInteract := [miZoom,miScroll];
    imageen1.Cursor := crCross;
    ImageEn1.DeSelect;
  Actionconsole.Checked := false;
  Actionconsole.Caption := 'Console off';

    NextFlatsep(false);

end;

procedure TFormprevPlate2.ActionpreviewApproveprevExecute(Sender: TObject);
begin
  Actionconsole.Checked := false;
  Actionconsole.Caption := 'Console off';
  Actionprevmessure.Checked := false;
    Actionmovesel.Checked := false;
    ImageEn1.MouseInteract := [miZoom,miScroll];
    imageen1.Cursor := crCross;
    ImageEn1.DeSelect;

    Apprnext(1,-1);
end;

procedure TFormprevPlate2.ActionpreviewRejectprevExecute(Sender: TObject);
begin
  Actionconsole.Checked := false;
  Actionconsole.Caption := 'Console off';
  Actionprevmessure.Checked := false;
    Actionmovesel.Checked := false;
    ImageEn1.MouseInteract := [miZoom,miScroll];
    imageen1.Cursor := crCross;
    ImageEn1.DeSelect;

    Apprnext(2,-1);
end;

procedure TFormprevPlate2.ActiongotonotapprovedExecute(Sender: TObject);
begin
  Actiongotonotapproved.checked := Not Actiongotonotapproved.checked;
end;

Procedure TFormprevPlate2.readpageordernext(approve : Integer;  //-1 just move
                                         direction : Integer);
Var
//  T : string;
  eventtime : tdatetime;
  I{,res,sheetside,proofid,templateid} : Integer;
//  APPOS : pparray;
//  ANPPOS : Integer;
  Copyseparationsets : TStrings;
//  aktpi,Ithumb : Integer;
//  readordfilename : string;
begin
  Copyseparationsets := TStringList.Create;
  IF lasttime = 0 then
    lasttime := now;
  try
    IF approve <> -1 then
    begin
      DataM1.Query1.sql.clear;
      DataM1.Query1.sql.add('update pagetable set approved = ' +inttostr(approve));
      DataM1.Query1.sql.add('where mastercopyseparationset = ' +inttostr(Readordermasters[AktReadorder].masterl));
      DataM1.Query1.sql.add('or mastercopyseparationset = '    +inttostr(Readordermasters[AktReadorder].masterr));
      DataM1.Query1.ExecSQL(false);
      IF approve = 1 then
      begin
        IF (Prefs.RemoveMissingColorsOnApprove) then
        Begin
          DataM1.Query1.sql.clear;
          DataM1.Query1.sql.add('update pagetable Set active = 0');
          DataM1.Query1.sql.add('where (mastercopyseparationset = ' + inttostr(Readordermasters[AktReadorder].masterl));
          DataM1.Query1.sql.add('and status = 0) ');
          DataM1.Query1.sql.add('or (mastercopyseparationset = ' + inttostr(Readordermasters[AktReadorder].masterr));
          DataM1.Query1.sql.add('and status = 0) ');
          IF Prefs.debug then datam1.Query1.SQL.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'Removeemptyseps.sql');
          DataM1.Query1.ExecSQL(false);
        End;
      End;
      DataM1.Query1.sql.clear;
      DataM1.Query1.sql.add('select Copyseparationset from pagetable (NOLOCK)');
      DataM1.Query1.sql.add('where mastercopyseparationset = ' + inttostr(Readordermasters[AktReadorder].masterl));
      DataM1.Query1.sql.add('or mastercopyseparationset = ' + inttostr(Readordermasters[AktReadorder].masterr));
      DataM1.Query1.Open;
      while not DataM1.Query1.eof do
      begin
        Copyseparationsets.add(DataM1.Query1.fieldbyname('Copyseparationset').asstring);
        DataM1.Query1.next;
      end;
      DataM1.Query1.close;
      if approve = 1 then
      begin
        For i := 0 to Copyseparationsets.count -1 do
        begin
          DataM1.Query1.sql.clear;
          DataM1.Query1.sql.add('update pagetable');
          DataM1.Query1.sql.add('set approvetime = getdate(),approveuser='+''''+Prefs.username+'''');
          DataM1.Query1.sql.add('where copyseparationset = ' + Copyseparationsets[i] );
          DataM1.Query1.execsql(false);
        end;
        if (Prefs.LogApproval) then
        begin
          eventtime := -1;
          IF Readordermasters[AktReadorder].masterl > -1 then
            formmain.Addlogentry(70,Prefs.username,eventtime,-1,-1,-1,Readordermasters[AktReadorder].masterl,-1,-1,-1);
          IF Readordermasters[AktReadorder].masterr > -1 then
            formmain.Addlogentry(70,Prefs.username,eventtime,-1,-1,-1,Readordermasters[AktReadorder].masterr,-1,-1,-1);
        End;
      End;
    End;
  finally
    Copyseparationsets.Free;
  end;
  AktReadorder := AktReadorder + direction;

  IF (AktReadorder > 0) and (AktReadorder <= NReadordermasters) then
  begin
    prevmasterL := Readordermasters[AktReadorder].masterl;
    prevmasterR := Readordermasters[AktReadorder].masterR;
    loadprevform;
    PageControl1.ActivePageIndex := 0;
  end
  else
  begin
    FormprevPlate2.close;
  end;
end;

Function TFormprevPlate2.readordermakefile:boolean;
Var
  T : string;
  APPOS : pparray;
  ANPPOS : Integer;
  res,i : Integer;
  Color : string;
  ColorID : Integer;
  PubDate : TDateTime;
  testpath : String;
  PreviewGUID : String;
Begin
  try
    result := true;
    strpcopy(MrgOutputFileName, IncludeTrailingBackSlash(TUtils.GetTempDirectory()) + 'merg1.jpg');
    strpcopy(MrgFileNameLeft,'');
    strpcopy(MrgFileNameRight,'');
    MrgPageTypeLeft      := 3;
    MrgPageTypeRight     := 3;
    MrgPagePositionLeft  := 2;
    MrgPagePositionRight := 1;
    MrgSheetSide         := 1;
    MrgProofID           := 1;
    MrgTemplateID        := 17;
    For i := 1 to 32 do
    begin
      readordercolorfiles[I].ptypeLeft  := 3;
      readordercolorfiles[I].ptypeRight  := 3;
      readordercolorfiles[I].filenameleft := '';
      readordercolorfiles[I].filenameRight := '';
    End;
    Nplates := 0;
    countleft   := 0;
    countright  := 0;
    Lowrespath := formmain.getfileserverFrommaster(PATHTYPE_CCPREVIEWS,PrevmasterL);
    pregenreadviewpath := formmain.getfileserverFrommaster(PATHTYPE_CCREADVIEWPREVIEWS, PrevmasterL);
    writelogline(pregenreadviewpath);
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.add('Select distinct p1.mastercopyseparationset,p1.proofid,p1.templateid,p1.sheetside,p1.pagepositions,p1.pagetype,p1.publicationid,p1.colorid,p1.active,p1.proofstatus,p1.fileserver,P1.PubDate,P1.UniquePage from pagetable p1 (NOLOCK)');
    DataM1.Query1.SQL.add('where p1.mastercopyseparationset = '+inttostr(PrevmasterL));
    DataM1.Query1.SQL.add('and p1.pagetype < 2');
    DataM1.Query1.SQL.add('and p1.copynumber = 1');
    DataM1.Query1.SQL.add('and p1.UniquePage = 1');
    IF Prefs.debug then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'mergeL.sql');
    formmain.tryopen(DataM1.Query1);
    Nreadordercolorfiles := 0;
    While not DataM1.Query1.eof do
    begin
      MrgProofID     := DataM1.Query1.fields[1].asinteger;
      MrgTemplateID  := DataM1.Query1.fields[2].asinteger;
      MrgSheetSide   := DataM1.Query1.fields[3].asinteger;
      readorderpublicationid  := DataM1.Query1.fields[6].asinteger;
      PubDate := DataM1.Query1.fields[11].AsDateTime;
      ColorID := DataM1.Query1.fields[7].asinteger;
      PreviewGUID := inittypes.GeneratePreviewGUID( readorderpublicationid, PubDate);
      Ireadordercolorfiles := 0;
      For i := 1 to Nreadordercolorfiles do
      begin
        IF readordercolorfiles[i].Colorid = ColorID then
        begin
          Ireadordercolorfiles := I;
          break;
        end;
      end;
      IF Ireadordercolorfiles = 0 then
      begin
        Inc(Nreadordercolorfiles);
        Ireadordercolorfiles := Nreadordercolorfiles;
      end;
      readordercolorfiles[Ireadordercolorfiles].Colorid := ColorID;
      Color := tnames1.ColornameIDtoname(readordercolorfiles[Ireadordercolorfiles].Colorid);
      IF DataM1.Query1.fields[8].asinteger = 1 then    // Active
      begin
        Inc(countleft);
        IF DataM1.Query1.fields[9].asinteger >= 10 then  // ProofStatus
        begin
          T := includetrailingbackslash(Lowrespath)+inttostr(prevmasterL)+'_'+Color+'.jpg';
          if (Prefs.NewPreviewNames) then
          begin
            T := includetrailingbackslash(Lowrespath)+PreviewGUID + '====' + inttostr(prevmasterL)+'_'+Color+'.jpg';
            if NOT fileexists(T) then
              T := includetrailingbackslash(Lowrespath)+inttostr(prevmasterL)+'_'+Color+'.jpg';
          end;
          readordercolorfiles[Ireadordercolorfiles].ptypeLeft := DataM1.Query1.fields[5].asinteger;
          readordercolorfiles[Ireadordercolorfiles].filenameleft := T;
          testpath := includetrailingbackslash(Lowrespath)+ inttostr(prevmasterL)+'.jpg';
          if (Prefs.NewPreviewNames) then
          begin
            testpath := includetrailingbackslash(Lowrespath)+ PreviewGUID + '====' + inttostr(prevmasterL)+'.jpg';
            if NOT FileExists(testpath) then
              testpath := includetrailingbackslash(Lowrespath)+ inttostr(prevmasterL)+'.jpg';
          end;
          writelogline(testpath);
          strpcopy(MrgFileNameLeft, testpath);
          IF MrgPageTypeLeft = 3 then
          begin
            MrgPageTypeLeft := DataM1.Query1.fields[5].asinteger;
          End;
        End;
        T := DataM1.Query1.fields[4].asstring;        // PagePositions
        inittypes.PPOSstrtoarray(T,APPOS,ANPPOS);
        MrgPagePositionLeft := APPOS[1];
      End;
      DataM1.Query1.Next;
    End;
    DataM1.Query1.close;
    IF PrevmasterL <> PrevmasterR then
    Begin
      Lowrespath := formmain.getfileserverFrommaster(PATHTYPE_CCPREVIEWS, PrevmasterR);
      IF pregenreadviewpath = '' then
        pregenreadviewpath := formmain.getfileserverFrommaster(PATHTYPE_CCREADVIEWPREVIEWS,PrevmasterR);
      DataM1.Query1.SQL.Clear;
      DataM1.Query1.SQL.add('Select distinct p1.mastercopyseparationset,p1.proofid,p1.templateid,p1.sheetside,p1.pagepositions,p1.pagetype,p1.publicationid,p1.colorid,p1.active,p1.proofstatus,P1.PubDate,P1.UniquePage from pagetable p1 (NOLOCK)');
      DataM1.Query1.SQL.add('where p1.mastercopyseparationset = '+inttostr(prevmasterR));
      DataM1.Query1.SQL.add('and p1.pagetype < 2');
      DataM1.Query1.SQL.add('and p1.active = 1');
      DataM1.Query1.SQL.add('and p1.copynumber = 1');
      DataM1.Query1.SQL.add('and p1.UniquePage = 1');
      IF Prefs.debug then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'mergeR.sql');
      formmain.tryopen(DataM1.Query1);
      While not DataM1.Query1.eof do
      begin
        MrgProofID     := DataM1.Query1.fields[1].asinteger;
        MrgTemplateID  := DataM1.Query1.fields[2].asinteger;
        MrgSheetSide   := DataM1.Query1.fields[3].asinteger;
        readorderpublicationid  := DataM1.Query1.fields[6].asinteger;
        pubdate := DataM1.Query1.fields[10].AsDateTime;
        PreviewGUID := inittypes.GeneratePreviewGUID( readorderpublicationid, PubDate);
        ColorID := DataM1.Query1.fields[7].asinteger;
        Ireadordercolorfiles := 0;
        For i := 1 to Nreadordercolorfiles do
        begin
          IF readordercolorfiles[i].Colorid = ColorID then
          begin
            Ireadordercolorfiles := I;
            break;
          end;
        end;
        IF Ireadordercolorfiles = 0 then
        begin
          Inc(Nreadordercolorfiles);
          Ireadordercolorfiles := Nreadordercolorfiles;
        end;
        readordercolorfiles[Ireadordercolorfiles].Colorid := ColorID;
        Color := tnames1.ColornameIDtoname(readordercolorfiles[Ireadordercolorfiles].Colorid);
        T := includetrailingbackslash(Lowrespath)+inttostr(prevmasterR)+'_'+Color+'.jpg';
        if (Prefs.NewPreviewNames) then
        begin
          T := includetrailingbackslash(Lowrespath) + PreviewGUID + '====' +inttostr(prevmasterR)+'_'+Color+'.jpg';
          if NOT FileExists(T) then
            T := includetrailingbackslash(Lowrespath)+inttostr(prevmasterR)+'_'+Color+'.jpg';
        end;
        IF DataM1.Query1.fields[8].asinteger = 1 then              // Active
        begin
          Inc(countright);
          IF DataM1.Query1.fields[9].asinteger >= 10 then          // ProofStatus
          begin
            readordercolorfiles[Ireadordercolorfiles].ptyperight := DataM1.Query1.fields[5].asinteger;
            readordercolorfiles[Ireadordercolorfiles].filenameright := T;
            testpath := includetrailingbackslash(Lowrespath)+ PreviewGUID + '====' + inttostr(prevmasterR)+'.jpg';
            if NOT FileExists(testpath) then
              testpath := includetrailingbackslash(Lowrespath)+ inttostr(prevmasterR)+'.jpg';
              writelogline(testpath);
            strpcopy(MrgFileNameright, testpath);
            if MrgPageTyperight = 3 then
            begin
              MrgPageTyperight := DataM1.Query1.fields[5].asinteger;
            End;
          End;
          T := DataM1.Query1.fields[4].asstring;
          inittypes.PPOSstrtoarray(T,APPOS,ANPPOS);
          MrgPagePositionright := APPOS[1];
        End;
        DataM1.Query1.Next;
      End;
      DataM1.Query1.close;
    End;
    IF (MrgPageTypeRight <> 3) or (MrgPageTypeLeft <> 3) then
    begin
      For i := 1 to Nreadordercolorfiles do
      begin
        IF (countleft = 1) and (readordercolorfiles[i].ptypeleft <> 3) then
        begin  // left is mono
          readordercolorfiles[i].filenameleft := strpas(MrgFileNameLeft);
        end;
        IF (countright = 1) and (readordercolorfiles[i].ptyperight <> 3) then
        begin  // right is mono
          readordercolorfiles[i].filenameright := strpas(MrgFileNameright);
        end;
      End;
      ProgressBar1.Max := Nreadordercolorfiles * 2;
      res := Myreadorderfile(MrgFileNameLeft,MrgFileNameRight,MrgOutputFileName,MrgPageTypeLeft,MrgPageTypeRight,MrgPagePositionLeft,
                             MrgPagePositionRight,MrgSheetSide,MrgProofID,MrgTemplateID,readorderpublicationid,true,true,PubDate);
      if res <> 1 then
      begin
        result := false;
      end
      Else
      begin
        sepsareloaded := false;
        if (Prefs.PreviewSeparationsOnReadview) then
        begin
          For i := 1 to Nreadordercolorfiles do
          begin
            MrgPageTypeLeft := readordercolorfiles[i].ptypeleft;
            MrgPageTyperight := readordercolorfiles[i].ptyperight;
            strpcopy(MrgFileNameLeft,readordercolorfiles[i].filenameleft);
            strpcopy(MrgFileNameright,readordercolorfiles[i].filenameright);
            strpcopy(MrgOutputFileName, IncludeTrailingBackSlash(TUtils.GetTempDirectory()) + 'merg1'+'_'+tnames1.ColornameIDtoname(readordercolorfiles[I].Colorid)+'.jpg');
            if true then
            begin
              res := Myreadorderfile(MrgFileNameLeft,MrgFileNameRight,MrgOutputFileName,MrgPageTypeLeft,MrgPageTypeRight,MrgPagePositionLeft,
                                MrgPagePositionRight,MrgSheetSide,MrgProofID,MrgTemplateID,readorderpublicationid,false,false,PubDate);
              if res = 1 then
              begin
                ProgressBar1.Position := ProgressBar1.Position +1;
                inc(Nplates);
                plates[Nplates].filecanbeloaded := true;
                plates[Nplates].Fileisloaded := true;
                plates[Nplates].filename := strpas(MrgOutputFileName);
                plates[Nplates].Colorname := tnames1.ColornameIDtoname(readordercolorfiles[i].Colorid);
                plates[Nplates].ColorID := readordercolorfiles[i].Colorid;
                plates[Nplates].Colorlook := Colorsnames[Plates[NPlates].ColorID].Colorlook;
                Plates[NPlates].CMYKtype := -1;
              end;
            end
            Else
            begin
              ProgressBar1.Position := ProgressBar1.Position +1;
              inc(Nplates);
              plates[Nplates].filecanbeloaded := true;
              if MrgFileNameLeft <> '' then
                plates[Nplates].filecanbeloaded := fileexists(MrgFileNameLeft);
              if (plates[Nplates].filecanbeloaded) and (MrgFileNameRight <> '') then
              begin
                plates[Nplates].filecanbeloaded := fileexists(MrgFileNameRight);
              end;
              plates[Nplates].Fileisloaded := false;
              plates[Nplates].filename := strpas(MrgOutputFileName);
              plates[Nplates].Colorname := tnames1.ColornameIDtoname(readordercolorfiles[i].Colorid);
              plates[Nplates].ColorID := readordercolorfiles[i].Colorid;
              plates[Nplates].Colorlook := Colorsnames[Plates[NPlates].ColorID].Colorlook;
              Plates[NPlates].CMYKtype := -1;
            end;
            readordercolorfiles[i].plateI := nplates;
          end;
        End;
      end;
    End;
  Except
    result := false;
  end;
End;

procedure TFormprevPlate2.Trygetsize;
Var
  filename : string;
  colorid : Integer;
  plres : Integer;
  Xres      : Single;
  Yres      : Single;
  Width     : Single;
  Height    : Single;
  CompRatio : Single;
  Hpath : string;
  orgfilename : string;
//  TmpS : String ;
 // TmpW : PWideChar;
  szFile : PAnsiChar;
begin
  try
    try
      DataM1.Query1.sql.clear;
      DataM1.Query1.sql.add('Select TOP 1 colorid,fileserver,filename from pagetable (NOLOCK)');
      DataM1.Query1.sql.add('where mastercopyseparationset = ' + inttostr(prevmaster));
      DataM1.Query1.sql.add('and active = 1 and UniquePage=1 ');
      DataM1.Query1.sql.add('and status >= 10');
      formmain.Tryopen(DataM1.Query1);
      colorid := -1;
      Hpath := '';
      if not DataM1.Query1.eof then
      begin
        IF Hpath = '' then
          Hpath := Formmain.GetFileServerPath(PATHTYPE_CCFILES, DataM1.Query1.fields[1].AsString);
        colorid := DataM1.Query1.fields[0].asinteger;
        orgfilename := DataM1.Query1.fields[2].AsString;
      End;
      DataM1.Query1.close;
      IF colorid > -1 then
      begin
        filename := Hpath + orgfilename + '====' + inttostr(prevmaster)+'.'+tnames1.ColornameIDtoname(ColorID);
        if NOT fileexists( filename) then
          filename := Hpath + inttostr(prevmaster)+'.'+tnames1.ColornameIDtoname(ColorID);
        szFile := AnsiStrAlloc(256);
        StrPCopy(szFile, filename);
        plres := PlotInfo(szFile,Xres,Yres,Width,Height,CompRatio);
        IF plres <> 0 then
        begin
          FormFileinfo.Xres := Xres;
          FormFileinfo.Yres := Yres;
          FormFileinfo.FWidth := Width;
          FormFileinfo.FHeight := Height;
          FormFileinfo.CompRatio := CompRatio;
          FormFileinfo.filename := filename;
          FormFileinfo.setvalues;
          //InfraStatusBar1.Panels[8].Text :=   'Size: '+ FormFileinfo.editwidth.text+' * '+FormFileinfo.editheight.text + '  Res: ' + FormFileinfo.Editxres.text+' * '+FormFileinfo.Edityres.text;
          StatusBar1.Panels[8].Text :=   'Size: '+ FormFileinfo.editwidth.text+' * ' + FormFileinfo.editheight.text + '  Res: ' + FormFileinfo.Editxres.text+' * ' + FormFileinfo.Edityres.text;
        end
        Else
        begin
          IF NyFileInfoOK then
          begin
           szFile := AnsiStrAlloc(256);
           StrPCopy(szFile, filename);

            plres := NyFileInfo(szFile   ,Xres,Yres,Width,Height,CompRatio);
            IF plres <> 0 then
            begin
              FormFileinfo.Xres      := Xres;
              FormFileinfo.Yres      := Yres;
              FormFileinfo.FWidth    := Width;
              FormFileinfo.FHeight   := Height;
              FormFileinfo.CompRatio := CompRatio;
              FormFileinfo.filename  := filename;
              FormFileinfo.setvalues;
              //InfraStatusBar1.Panels[8].Text :=   'Size: '+ FormFileinfo.editwidth.text+' * '+FormFileinfo.editheight.text;;
              StatusBar1.Panels[8].Text :=   'Size: '+ FormFileinfo.editwidth.text+' * '+FormFileinfo.editheight.text;;
            end else
              StatusBar1.Panels[8].Text :=   'Tiff missing';
          end else
            StatusBar1.Panels[8].Text :=   'Tiff missing';
        end;
      End;
    Except
    end;
  Finally

  End;
end;

procedure TFormprevPlate2.ActionEmailExecute(Sender: TObject);
begin
  //sendedisapprovemail(-1,'Send prev',0);
end;

procedure TFormprevPlate2.ActionprintExecute(Sender: TObject);
begin
  IF PrintDialog1.Execute then
  begin
    Printer.BeginDoc;
    Printer.Title := 'Plancenter';
    ImageEn1.IO.PrintImage(Printer.Canvas,0,0,0,0,ievpCENTER,iehpCENTER,iesFITTOPAGE,0,0,1);
    Printer.EndDoc;
  end;
end;

procedure TFormprevPlate2.ActionSaveExecute(Sender: TObject);
begin
   SaveDialog1.FileName := 'pagepreview.jpg';
   DataM1.Query1.sql.clear;
    DataM1.Query1.sql.add('Select TOP 1 locationid,editionid,sectionid,pagename,publicationID from pagetable WITH (NOLOCK)');
    DataM1.Query1.sql.add('where dirty=0 AND mastercopyseparationset = ' + inttostr(prevmaster));
    DataM1.Query1.sql.add('and active = 1');
    formmain.Tryopen(DataM1.Query1);
    IF not DataM1.Query1.eof then
    begin
      SaveDialog1.FileName := tnames1.publicationIDtoname(DataM1.Query1.fields[4].asinteger)+'_'+
          tnames1.editionIDtoname(DataM1.Query1.fields[1].asinteger)+'_'+
          tnames1.sectionIDtoname(DataM1.Query1.fields[2].asinteger)+'_'+
          DataM1.Query1.fields[3].asstring + '.jpg';
    end;
    DataM1.Query1.close;
  IF SaveDialog1.Execute then
  begin
    ImageEn1.IO.SaveToFile(SaveDialog1.FileName);
  end;
end;
procedure TFormprevPlate2.ActioncloseExecute(Sender: TObject);
begin
  FormprevPlate2.close;
end;
procedure TFormprevPlate2.rotateimages(rotate : longint);
Var
  I : Integer;
Begin
  ImageEn1.Proc.Rotate(rotate,false,ierFast,clnone);
  RGBImageEn.Proc.Rotate(rotate,false,ierFast,clnone);
  levelImageEn.Proc.Rotate(rotate,false,ierFast,clnone);
  MaskImageEn.Proc.Rotate(rotate,false,ierFast,clnone);
  For i := 1 to NPlates do
  begin
    Plates[i].ImageEn.Proc.Rotate(rotate,false,ierFast,clnone);
  end;
end;
procedure TFormprevPlate2.Action90Execute(Sender: TObject);
begin
  rotateimages(90);
end;
procedure TFormprevPlate2.Action180Execute(Sender: TObject);
begin
  rotateimages(180);
end;
procedure TFormprevPlate2.Action270Execute(Sender: TObject);
begin
  rotateimages(270);
end;

Procedure TFormprevPlate2.enabledisableactions;
begin

  if (Prefs.AllowParalelView) then
  begin
    Actionprint.Visible := false;
    ActionSave.Visible := false;
    Actionapprove.Visible := false;
    Actionreject.Visible := false;
    Action2.Visible := false;
    Actionprevchangeprofer.Visible := false;
    ActionpreviewApproveNext.Visible := false;
    ActionpreviewDisApproveNext.Visible := false;
    ActionpreviewNext.Visible := false;
    Actionprev.Visible := false;
    ActionpreviewApproveprev.Visible := false;
    ActionpreviewRejectprev.Visible := false;
    Actiongotonotapproved.Visible := false;
    Action1.Visible := false;
    ActionComment.Visible := false;
    ActionEmail.Visible := false;
    Actioneditcolors.Visible := false;
    Actionprevrelease.Visible := false;
    Actionprevhold.Visible := false;
    Actionmasked.Visible := false;
    Actiondoconsole.Visible := false;
    Actionconsole.Visible := false;
    Actionloadspeparations.Visible := false;
    Action4.Visible := false;
    Actionsetfalsespread.Visible := false;
  end
  Else
  begin
    //GroupBox1.Visible := not plateview;
    // NAN Begin
    //GroupBox1.Visible := false;
    //GroupBox1.Enabled := false;
  //  GroupBoxcolorproc.Visible := FoxrmSettings.CheckBoxShowInkDensityInformation.checked;
   // GroupBoxSize.Visible := false; //FoxrmSettings.CheckBoxShowSizeInformation.checked AND (NOT plateview);
     // NAN end
    Action2.Visible := false;
    Actionreject.Visible := false;
    Actionapprove.Visible := false;
    Actionprevchangeprofer.Visible := false;
    Actionprev.Visible := false;
    ActionpreviewNext.Visible := false;
    ActionpreviewDisApproveNext.Visible := false;
    ActionpreviewApproveNext.Visible := false;
    ActionpreviewApproveprev.Visible := false;
    ActionpreviewRejectprev.Visible := false;
    Actiongotonotapproved.Visible := false;
    Action1.Visible := false;
    ActionComment.Visible := false;
    Actionprev.Visible := true;
    ActionpreviewNext.Visible := true;
  end;
  settheallowedarrow;

end;

procedure TFormprevPlate2.ActioneditcolorsExecute(Sender: TObject);
begin
  (*
    NReadordermasters : Integer;
    Readordermasters : array[1..1000] of record
                                           IthumbL    : Integer;
                                           IthumbR    : Integer;
                                           pagetypel : Integer;
                                           pagetypeR : Integer;
                                           masterl : Integer;
                                           masterR : Integer;
                                         end;
  *)
  FormEndiscolors.Mastercopyseparationset := prevmaster;
  IF FormEndiscolors.ShowModal = mrok then
  begin
    DataM1.Query1.sql.clear;
    DataM1.Query1.sql.add('update pagetable set active = 1,proofstatus=0');
    DataM1.Query1.sql.add('where Mastercopyseparationset = ' +inttostr(prevmaster));
    datam1.Query1.SQL.Add(' and '+FormEndiscolors.enabledcolors);
    formmain.trysql(datam1.Query1);
    DataM1.Query1.sql.clear;
    DataM1.Query1.sql.add('update pagetable set active = 0,proofstatus=0');
    DataM1.Query1.sql.add('where Mastercopyseparationset = ' +inttostr(prevmaster));
    datam1.Query1.SQL.Add(' and '+FormEndiscolors.Disabledcolors);
    formmain.trysql(datam1.Query1);

  //  enablecolors;
    Actionclose.Execute;
  End;
end;

procedure TFormprevPlate2.ActionprevreleaseExecute(Sender: TObject);
Var
  publicationid,aktpressid,mkres,i2 : Integer;
  mscstr2,AApressInstr : String;
  pubdate : Tdatetime;
begin
  aktpressid := 0;
  publicationid := 0;

  IF (Prefs.PlateTransmissionSystem) then
  begin
    mscstr2 := '';
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.add('Select Miscstring2 from pagetable (NOLOCK)');
    DataM1.Query1.SQL.add('where pagetype <> 999');
    DataM1.Query1.SQL.add('and FlatSeparationSet = ' + inttostr(prevmaster));
    formmain.tryopen(DataM1.Query1);
    IF not DataM1.Query1.eof then
      mscstr2 := DataM1.Query1.fields[0].asstring;
    DataM1.Query1.close;
    IF mscstr2 <> '' then
    begin
      FormreleaseTo.CheckListBox1.Items.Clear;
      DataM1.Query1.SQL.clear;
      DataM1.Query1.SQL.add('Select top 1 pressid,publicationid,pubdate from pagetable (NOLOCK)');
      DataM1.Query1.SQL.add('where pagetype <> 999');
      DataM1.Query1.SQL.add('and FlatSeparationSet = ' + inttostr(prevmaster));
      DataM1.Query1.open;
      IF not DataM1.Query1.eof then
      begin
        aktpressid := DataM1.Query1.fields[0].asinteger;
        publicationid := DataM1.Query1.fields[1].asinteger;
        pubdate := DataM1.Query1.fields[2].asdatetime;
        DataM1.Query1.next;
      end;
      DataM1.Query1.close;
      DataM1.Query1.SQL.clear;
      DataM1.Query1.SQL.add('Select distinct pressid from pagetable (NOLOCK)');
      DataM1.Query1.SQL.add('Where publicationid =  ' + inttostr(publicationid));
      DataM1.Query1.SQL.add(' and '+  DataM1.makedatastr('',pubdate));
      DataM1.Query1.open;
      While not DataM1.Query1.eof do
      begin
        FormreleaseTo.CheckListBox1.Items.add(tnames1.pressnameIDtoname(DataM1.Query1.fields[0].asinteger));
        IF aktpressid = DataM1.Query1.fields[0].asinteger then
          FormreleaseTo.CheckListBox1.checked[FormreleaseTo.CheckListBox1.Items.count-1] := true;
        DataM1.Query1.next;
      end;
      DataM1.Query1.close;
      mkres := FormreleaseTo.showmodal;
      IF (mkres = mrok) or (mkres = mrall) then
      begin
        DataM1.Query1.SQL.Clear;
        DataM1.Query1.SQL.add('update pagetable');
        DataM1.Query1.SQL.add('set hold = 0');   // OK
        IF (Prefs.SetApproveTimeOnRelease) then
          DataM1.Query1.SQL.add(', approvetime = getdate(),approveuser='+''''+Prefs.username+'''');
        DataM1.Query1.SQL.add('where pagetype <> 999');
        DataM1.Query1.SQL.add('and Miscstring2 = ' + ''''+mscstr2+'''' );
        IF mkres = mrok then
        begin
          AApressInstr := 'and pressid IN (-99';
          For i2 := 0 to FormreleaseTo.CheckListBox1.Items.Count-1 do
          begin
            if FormreleaseTo.CheckListBox1.Checked[i2] then
              AApressInstr := AApressInstr + ','+INTTOSTR(tnames1.pressnametoid(FormreleaseTo.CheckListBox1.Items[I2]));
          end;
          AApressInstr := AApressInstr + ')';
          DataM1.Query1.SQL.add(AApressInstr);
        end;
        formmain.trysql(DataM1.Query1);
      End;
    End;
  end
  else
  begin
    Copyflatseparationset := -1;
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.add('Select copyflatseparationset from pagetable (NOLOCK) ');
    DataM1.Query1.SQL.add('where pagetype <> 999');
    DataM1.Query1.SQL.add('and FlatSeparationSet = ' + inttostr(prevmaster));
    formmain.tryopen(DataM1.Query1);
    IF not DataM1.Query1.eof then
      Copyflatseparationset := DataM1.Query1.fields[0].asinteger;
    DataM1.Query1.close;
    IF Copyflatseparationset <> -1 then
    begin
      DataM1.Query1.SQL.Clear;
      DataM1.Query1.SQL.add('update pagetable');
      DataM1.Query1.SQL.add('set hold = 0');   // OK
      if (Prefs.SetApproveTimeOnRelease) then
        DataM1.Query1.SQL.add(', approvetime = getdate(),approveuser='+''''+Prefs.username+'''');
      DataM1.Query1.SQL.add('where pagetype <> 999');
      DataM1.Query1.SQL.add('and CopyFlatSeparationSet = ' + inttostr(Copyflatseparationset));
      formmain.trysql(DataM1.Query1);
    End;
  end;
  Close;

end;

procedure TFormprevPlate2.ActionprevholdExecute(Sender: TObject);
begin

    Copyflatseparationset := -1;
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.add('Select copyflatseparationset from pagetable (NOLOCK) ');
    DataM1.Query1.SQL.add('where pagetype <> 999');
    DataM1.Query1.SQL.add('and FlatSeparationSet = ' + inttostr(prevmaster));
    formmain.tryopen(DataM1.Query1);
    IF not DataM1.Query1.eof then
      Copyflatseparationset := DataM1.Query1.fields[0].asinteger;
    DataM1.Query1.close;
    IF Copyflatseparationset <> -1 then
    begin
      DataM1.Query1.SQL.Clear;
      DataM1.Query1.SQL.add('update pagetable');
      DataM1.Query1.SQL.add('set hold = 1');
      DataM1.Query1.SQL.add('where pagetype <> 999');
      DataM1.Query1.SQL.add('and CopyFlatSeparationSet = ' + inttostr(Copyflatseparationset));
      formmain.trysql(DataM1.Query1);
    End;
    Close;

end;

procedure TFormprevPlate2.GetProoferInfo(Proofid : Integer;
                                    Flatproof : Boolean);
Begin
  aktProofPDI := -1;
  Aktproofname := '';
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.add('Select Resolution,ProofName');
  IF Not flatproof then
  begin
   DataM1.Query1.SQL.add('From ProofConfigurations');
  End
  Else
  begin
    DataM1.Query1.SQL.add('From FlatProofConfigurations');
  end;
  DataM1.Query1.SQL.add('where proofid = ' + inttostr(Proofid));
  formmain.Tryopen(DataM1.Query1);
  IF not DataM1.Query1.eof then
  begin
    aktProofPDI := DataM1.Query1.fields[0].AsFloat;
    Aktproofname := DataM1.Query1.fields[1].Asstring;
  end;
  DataM1.Query1.close;
end;

Function TFormprevPlate2.getmousemmpos(x,y : Integer;
                                   Var xm : Double;
                                   Var ym : Double):boolean;
Var
  zfact : Double;
begin
  x := x + ImageEn1.viewx;
  y := y + ImageEn1.viewy;
  zfact := (100 / ImageEn1.Zoom);
  IF (x-ImageEn1.OffsetX > ImageEn1.ExtentX+ ImageEn1.viewx) then
  begin
    x := ImageEn1.ExtentX+ImageEn1.OffsetX+ ImageEn1.viewx;
  end;
  IF (y-ImageEn1.Offsety > ImageEn1.Extenty+ ImageEn1.viewy) then
  begin
    y := ImageEn1.Extenty+ImageEn1.Offsety+ ImageEn1.viewy;
  end;
  IF aktProofPDI < 1 then
    aktProofPDI := 104;
  xm := ((x-ImageEn1.OffsetX)/aktProofPDI) * 25.4;
  ym := ((y-ImageEn1.OffsetY)/aktProofPDI) * 25.4;
  IF Ym < 0 then
    Ym := 0;
  IF xm < 0 then
    xm := 0;
  xm := xm * zfact;
  ym := ym * zfact;
  //25.4

  result := true;
end;

procedure TFormprevPlate2.ActionprevmessureExecute(Sender: TObject);
begin
  Actionprevmessure.Checked := Not Actionprevmessure.Checked;
  Actionmovesel.Checked := false;
  IF Actionprevmessure.Checked then
  begin
    imageen1.Cursor := 1780;
    ImageEn1.MouseInteract := [miSelect];
  end
  else
  begin
    ImageEn1.MouseInteract := [miZoom,miScroll];
    //ImageEn1.MouseInteract := [miMovingScroll];
    //ImageEn1.MouseInteract := [];
    imageen1.Cursor := crCross;
  end;
  ImageEn1.DeSelect;
end;
 (*
procedure TFormprevPlate2.ImageEn1oldSelectionChange(Sender: TObject);
Var
  zfact : Double;
  w,h : Integer;
  xm1,xm2,ym1,ym2,wm,hm : Double;
begin
  InfraStatusBar1.Panels[4].Text := '';
  If aktProofPDI = 0 then
    aktProofPDI := 104;
  w := ImageEn1.SelX2 - ImageEn1.SelX1;
  h := ImageEn1.Sely2 - ImageEn1.Sely1;
  IF (w < 0) or (h < 0) then
  begin
    InfraStatusBar1.Panels[4].Text := '';
    exit;
  end;
  wm := (w/aktProofPDI) * 25.4;
  hm := (h/aktProofPDI) * 25.4;
  IF wm < 0 then
    wm := 0;
  IF hm < 0 then
    hm := 0;

  InfraStatusBar1.Panels[4].Text := 'W: '+FormatFloat('0.0',wm) + '  H: '+  FormatFloat('0.0',hm);

 
end;
  *)
{procedure TFormprevPlate2.Setbluebar;

Var
  I : Integer;
//  foundit,foundsepcial : Boolean;
  Temptoolbar : Tactiontoolbar;
begin
  // NAN disabled..
  exit;
  for I := 0 to ActionManagerpev.ActionBars.Count-1 do
  begin
    ActionManagerpev.ActionBars[i].Background.LoadFromFile(extractfilepath(axpplication.ExeName)+'Horztoolbarimage.bmp');
    ActionManagerpev.ActionBars[i].BackgroundLayout := blStretch;
  end;
  Temptoolbar := ActionToolBar1;
  For i := 0 to Temptoolbar.ControlCount-1 do
  begin
   // TCustomButtonControl(Temptoolbar.Controls[i]).setacheckimage(formmain.ImageSelnewbar.Picture.Bitmap,
   //                                                               formmain.ImageSelnewbarMouse.Picture.Bitmap,
   //                                                               true);
  end;
End;
}
Procedure TFormprevPlate2.loadpregendns;
Begin
  writelogline(Pregendnsfilename);
  IF (Pregendnsfilename <> '') And (fileexists(Pregendnsfilename)) then
  begin
    levelImageEn.IO.LoadFromFile(Pregendnsfilename);
    Pregendnsloaded := true;
    IF (levelImageEn.Bitmap.Width <> RGBImageEn.Bitmap.Width) or (levelImageEn.Bitmap.height <> RGBImageEn.Bitmap.height) then
          levelImageEn.Proc.Resample(RGBImageEn.Bitmap.Width,RGBImageEn.Bitmap.Height,rfNone);
  end
  else
  begin
  end;
end;

Procedure TFormprevPlate2.loadMaskfile;
Begin
  IF (maskfilename <> '') And (not maskisloaded) then
  begin
    if fileexists(maskfilename) then
    begin
      MaskImageEn.IO.LoadFromFile(maskfilename);
     // PageControl1.Pages[2].Enabled := true;
      IF (MaskImageEn.Bitmap.Width <> RGBImageEn.Bitmap.Width) or (MaskImageEn.Bitmap.height <> RGBImageEn.Bitmap.height) then
            MaskImageEn.Proc.Resample(RGBImageEn.Bitmap.Width,RGBImageEn.Bitmap.Height,rfNone);
      maskisloaded := true;
    End
    else
    begin
      Actionmasked.Enabled := false;
      Actionmasked.Checked := false;
    end;
  end
  Else
  begin
    Actionmasked.Enabled := false;
    Actionmasked.Checked := false;
  end;
end;

function TFormprevPlate2.Myreadorderfile(sFileNameLeft     : string;
                                    sFileNameRight    : string;
                                    sOutputFileName   : string;
                                    nPageTypeLeft      : Integer;
                                    nPageTypeRight     : Integer;
                                    nPagePositionLeft  : Integer;
                                    nPagePositionRight : Integer;
                                    nSheetSide         : Integer;
                                    nProofID           : Integer;
                                    nTemplateID        : Integer;
                                    nPublicationid     : Integer;
                                    Makedns            : Boolean;
                                    MainFile           : Boolean;
                                    PubDate            : TDateTime): Integer;
Var
  filename,l,r : String;
  PreviewGUID : String;
Begin
  PreviewGUID := inittypes.GeneratePreviewGUID(nPublicationid, PubDate);
  if (Prefs.UseGeneratedReadViews) then
  begin
    result := 0;
    l := sFileNameLeft; //strpas(szFileNameLeft);
    r := sFileNameRight; //strpas(szFileNameRight);
    l := extractfilename(l);
    l := changefileext(l,'');
    r := extractfilename(r);
    r := changefileext(r,'');
    IF l = '' then
      l := '0';
    filename := l;
    IF r = '' then
      r := '0';
    filename := filename +'_'+ r;
    writelogline(filename);
    pregenreadviewpath := includetrailingbackslash(pregenreadviewpath);
    if Makedns then
      Pregendnsfilename :=  pregenreadviewpath+filename + '_dns.jpg';
    IF maskfilename = '' then
    begin
      maskfilename := pregenreadviewpath+filename + '_mask.jpg';
    End;
    filename := pregenreadviewpath+filename+ '.jpg' ;
       writelogline(filename);
     sOutputFileName := pchar(filename);
   // If fileexists(strpas(szOutputFileName)) then
    if fileexists(sOutputFileName) then
    Begin
      if copyfile(PChar(sOutputFileName),PChar(IncludeTrailingBackSlash(TUtils.GetTempDirectory()) + 'merg1.jpg'),false) then
        result := 1;
    End
    Else
    Begin
      (*
      IF MainFile then
      begin
        result := MergeJpegs(MrgFileNameLeft,MrgFileNameRight,MrgOutputFileName,MrgPageTypeLeft,MrgPageTypeRight,MrgPagePositionLeft,
                              MrgPagePositionRight,MrgSheetSide,MrgProofID,MrgTemplateID,npublicationid);
      end;
      *)
    End;
  end
  else
  begin
  //  result := MergeJpegs(PAnsiChar(MrgFileNameLeft),PAnsiChar(MrgFileNameRight),PAnsiChar(MrgOutputFileName),MrgPageTypeLeft,MrgPageTypeRight,MrgPagePositionLeft,
  //                          MrgPagePositionRight,MrgSheetSide,MrgProofID,MrgTemplateID,npublicationid);
      result := MergeJpegs(TUtils.StringToPAnsiChar(sFileNameLeft),
                          TUtils.StringToPAnsiChar(sFileNameRight),
                           TUtils.StringToPAnsiChar(sOutputFileName),
                          MrgPageTypeLeft,MrgPageTypeRight,MrgPagePositionLeft,
                            MrgPagePositionRight,MrgSheetSide,MrgProofID,MrgTemplateID,npublicationid);
  end;
End;

Procedure TFormprevPlate2.NextFlatsep(GoTonext : Boolean);
Var
  Foundnext : Integer;
  aktpressrunid,aktsheed,aktsheetside : Integer;
  Afilename : String;
Begin
  aktsheed := 0;
  IF lasttime = 0 then
    lasttime := now;
  Foundnext := -1;
  aktpressrunid := -1;
  DataM1.Query1.sql.clear;
  DataM1.Query1.sql.add('select top 1 pressrunid,sheetnumber,sheetside from pagetable (NOLOCK) where FlatSeparationSet = ' + inttostr(prevmaster));
  DataM1.Query1.open;
  IF Not DataM1.Query1.eof then
  begin
    aktpressrunid := DataM1.Query1.fields[0].asinteger;
    aktsheed      := DataM1.Query1.fields[1].asinteger;
    aktsheetside  := DataM1.Query1.fields[2].asinteger;  //0=front
  end;
  DataM1.Query1.close;
  IF aktpressrunid > -1 then
  begin
    IF GoTonext then
    begin
      IF aktsheetside = 0 then
      Begin
        aktsheetside := 1;
      End
      Else
      begin
        aktsheetside := 0;
        aktsheed := aktsheed+1;
      end;
    end
    else
    begin
      IF aktsheetside = 1 then
      Begin
        aktsheetside := 0;
      End
      Else
      begin
        aktsheetside := 1;
        aktsheed := aktsheed-1;
      end;
    end;
    DataM1.Query1.sql.clear;
    DataM1.Query1.sql.add('select top 1 FlatSeparationSet,locationid from pagetable (NOLOCK) ');
    DataM1.Query1.sql.add('where pressrunid = '+ inttostr(aktpressrunid));
    DataM1.Query1.sql.add('And sheetside = '+ inttostr(aktsheetside));
    DataM1.Query1.sql.add('And sheetnumber = '+ inttostr(aktsheed));
    DataM1.Query1.sql.add('And Copynumber = 1 ');
    DataM1.Query1.sql.add('And (inkstatus IN (5,6,9,10) OR Flatproofstatus = 10)');
    DataM1.Query1.open;
    Afilename := '';
    IF Not DataM1.Query1.eof then
    begin
      Foundnext := DataM1.Query1.fields[0].asinteger;
      if (Prefs.UsePreviewCache) then
         Afilename := includetrailingbackslash(formmain.GetInkFolderCache(1))+inttostr(Foundnext)+'.jpg';
      if ((not Prefs.UsePreviewCache) OR (Prefs.UsePreviewCache and not fileexists(Afilename))) then
        Afilename := includetrailingbackslash(formmain.getinkfolder(1,DataM1.Query1.fields[1].asinteger))+inttostr(Foundnext)+'.jpg';
    end;
    DataM1.Query1.close;
  end;
  IF Foundnext > -1 then
  begin
    IF fileexists(Afilename) then
    begin
      prevmaster := Foundnext;
      imageen1.Clear;
      imageen1.update;

      loadprevform;
    end
    Else
      FormprevPlate2.close;
  end
  Else
  begin
    FormprevPlate2.close;
  end;
End;

procedure TFormprevPlate2.Makereadviewshadow;

Procedure ApplyDark(Var r:Byte;
                    Var g :Byte;
                    Var b:Byte;
                    HowMuch:Byte);
Begin
  if (r>HowMuch) then r:=r-HowMuch else r:=0;
  if g>HowMuch then g:=g-HowMuch else g:=0;
  if b>HowMuch then b:=b-HowMuch else b:=0;
End;
Var
  R,G,B{,Ci} : byte;
  px,py : Integer;
  h,w : Integer;
  I : Integer;
  {Fromscanline,}toscanline : pRGBTripleArray;
//  Max : Integer;
begin
  try
    H := ImageEn1.Bitmap.Height-1;
    W := ImageEn1.Bitmap.width-1;
    for py := 0 to H do
    begin
      I := 0;
      toscanline   := ImageEn1.Bitmap.ScanLine[py];
      for px := (w div 2) - (w div 100)  to (w div 2) + (w div 100) do
      Begin
        IF px < w div 2 then
        Begin
          IF (I < 254) then
            Inc(I,2);
        End
        else
        begin
          Dec(I,2);
        end;
        IF (I > 0)  then
        Begin
          r := toscanline[px].rgbtRed;
          G := toscanline[px].rgbtGreen;
          B := toscanline[px].rgbtBlue;
          ApplyDark(r,g,b,i);
          toscanline[px].rgbtRed := R;
          toscanline[px].rgbtGreen := G;
          toscanline[px].rgbtBlue := B;
      End;
        End;
    end;
  Except
  end;
  ImageEn1.Repaint;
end;

procedure TFormprevPlate2.Button1Click(Sender: TObject);
begin
  Makereadviewshadow;
end;
 (*
procedure TFormprevPlate2.ImageEn1oldMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  prevzoom := ImageEn1.Zoom
end;
 *)
procedure TFormprevPlate2.ActionmoveselExecute(Sender: TObject);
begin
  Actionmovesel.Checked := Not Actionmovesel.Checked;
  Actionprevmessure.Checked := false;
  IF Actionmovesel.Checked then
    ImageEn1.MouseInteract := [miZoom,miSelectZoom]
  else
  Begin
    //ImageEn1.MouseInteract := [];
    ImageEn1.MouseInteract := [miZoom,miScroll];
//    ImageEn1.MouseInteract := [miMovingScroll];
  End;
end;

procedure TFormprevPlate2.ActionmaskedExecute(Sender: TObject);
begin
  if maskfilename <> '' then
  begin
    if not maskisloaded then
      loadMaskfile;
    Actionmasked.checked := Not Actionmasked.checked;
    PageControl1Change(self);
  End;
end;

procedure TFormprevPlate2.ActionconsoleExecute(Sender: TObject);
begin
  Actionconsole.Checked := Not Actionconsole.checked;
  Consolemode := Actionconsole.Checked;
  If Consolemode then
    Actionconsole.Caption := 'Console on'
  else
    Actionconsole.Caption := 'Console off';
  Timercosole.Enabled := Actionconsole.Checked;
end;

// NOT USED
procedure TFormprevPlate2.TimercosoleTimer(Sender: TObject);
begin
  Timercosole.Enabled := false;
  FormprevPlate2.ConsoleNewID := false;
  if (Prefs.AutoConsole) then
  begin
    IF (Actionconsole.Checked) And (FormprevPlate2.Showing)  then
    begin
      datam1.SQLQueryconsole.SQL.clear;
      datam1.SQLQueryconsole.SQL.add('Select ConsoleName,Consoletime,Consoletype,ConsoleDataID1,ConsoleDataID2,ConsoleColorID,ConsolepressrunID FRom ConSoleView');
      datam1.SQLQueryconsole.SQL.add('Where (ConsoleDataID1 <> ' + inttostr(FormprevPlate2.ConsoleID1));
      datam1.SQLQueryconsole.SQL.add('OR ConsoleDataID2 <> ' + inttostr(FormprevPlate2.ConsoleID2)+')');
      datam1.SQLQueryconsole.SQL.add('And ConsoleName = ' + ''''+Prefs.ConsoleName+'''');
      datam1.SQLQueryconsole.SQL.add('And Consoletype > 0 ');
      IF Prefs.MaxConsoleAge > 0 then
        datam1.SQLQueryconsole.SQL.add('and DATEDIFF(SECOND,Consoletime,getdate()) < '+ IntToStr(Prefs.MaxConsoleAge));
      datam1.SQLQueryconsole.SQL.add('And (ConsoleDataID1 > 0 or ConsoleDataID2 > 0)');
      IF Prefs.debug then datam1.SQLQueryconsole.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'Chkconsoledata.sql');
     // datam1.SQLQueryconsole.SQL.add('order by Viewtime ');
      datam1.SQLQueryconsole.open;
      IF Not datam1.SQLQueryconsole.eof then
      begin
        ConsoleType := datam1.SQLQueryconsole.fields[2].asinteger;
        ConsoleID1 := datam1.SQLQueryconsole.fields[3].asinteger;
        ConsoleID2 := datam1.SQLQueryconsole.fields[4].asinteger;
        ConsoleNewID := true;
      end;
      datam1.SQLQueryconsole.close;
    end;
  end;
  IF ConsoleNewID and Actionconsole.Checked then
  begin
    Screen.Cursor := crhourglass;
    try
      Case ConsoleType of
        0 : Begin
            end;
        1 : Begin  //page
            end;
        2 : Begin  //readview
            end;
        3 : Begin  //plate
              prevmaster := ConsoleID1;
              imageen1.Clear;
              imageen1.update;
              loadprevform;
            end;
        4 : Begin  //Zone

            end;
      end;
    except
      Screen.Cursor := crdefault;
    end;
  end;
  Timercosole.Enabled := Actionconsole.Checked;
  Screen.Cursor := crdefault;
end;

// NOT USED
procedure TFormprevPlate2.Setconsoleviewdata;
Begin
  try
    if (Prefs.AutoConsole) and (AutoconsolePossible) then
    begin
      Case ConsoleViewType of
        1 : Begin
            end;
        2 : Begin
            end;
        3..4 : Begin
               end;
      end;
      IF Actionconsole.Checked then
      Begin
        DataM1.Query1.sql.clear;
        DataM1.Query1.sql.add('Exec spConsoleSetData 2,'+''''+Prefs.ConsoleName+''''+',');
        DataM1.Query1.sql.add(inttostr(ConsoleViewType)+',');
        DataM1.Query1.sql.add(inttostr(ViewID1)+',');
        DataM1.Query1.sql.add(inttostr(ViewID2)+',');
        DataM1.Query1.sql.add(inttostr(viewpressrunid)+',1,');
        DataM1.Query1.sql.add(inttostr(Specifikcolorid));
        DataM1.Query1.ExecSQL;
      End
      else
      begin
        DataM1.Query1.sql.clear;
        DataM1.Query1.sql.add('Exec spConsoleSetData 2,'+''''+Prefs.ConsoleName+''''+',');
        DataM1.Query1.sql.add(inttostr(ConsoleViewType)+',');
        DataM1.Query1.sql.add(inttostr(ViewID1)+',');
        DataM1.Query1.sql.add(inttostr(ViewID2)+',');
        DataM1.Query1.sql.add(inttostr(viewpressrunid)+',1,');
        DataM1.Query1.sql.add(inttostr(Specifikcolorid));
        DataM1.Query1.ExecSQL;
      end;
    end;
  Except
  end;

End;
procedure TFormprevPlate2.ActionloadspeparationsExecute(Sender: TObject);
Var
//  loadsepok : Boolean;
  //I3,
  i
  //,res
   : Integer;
  Nsepstoload : Integer;
  aktcap : String;
begin
  try
    aktcap := GroupBoxloading2.caption;

      aktcap := GroupBoxloading2.caption;
      If Not sepsareloaded then
      begin
        Nsepstoload := 0;
        For i := 1 to nplates do
        begin
          IF (Not plates[i].Azone) and (not plates[i].Fileisloaded) and (plates[i].filecanbeloaded ) then
          begin
            Inc(Nsepstoload);
          End;
        End;
        aktcap := GroupBoxloading2.caption;
        GroupBoxloading2.caption := 'Loading separations';
//        GroupBoxloading.left := (Panel1.Width -  GroupBoxloading.Width) div 2;
        ProgressBar1.Position := 0;
        ProgressBar1.Min := 0;
        ProgressBar1.Max := Nsepstoload+1;
        //GroupBoxloading.Visible := true;
        //GroupBoxloading.Repaint;
        ProgressBar1.Repaint;
        For i := 1 to nplates do
        begin
          IF (Not plates[i].Azone) and (not plates[i].Fileisloaded) and (plates[i].filecanbeloaded ) then
          begin
            plates[i].ImageEn.Clear;
            plates[i].ImageEn.IO.LoadFromFileJpeg(plates[i].filename);
            IF (plates[i].ImageEn.Bitmap.Width <> RGBImageEn.Bitmap.Width) or (plates[i].ImageEn.Bitmap.height <> RGBImageEn.Bitmap.height) then
              plates[i].ImageEn.Proc.Resample(RGBImageEn.Bitmap.Width,RGBImageEn.Bitmap.Height,rfNone);
            ProgressBar1.position := ProgressBar1.position+1;
            ProgressBar1.Repaint;
            plates[i].ImageEn.Bitmap.Width := platewidth;
            plates[i].ImageEn.Bitmap.height := plateheight;
            plates[i].ImageEn.AutoStretch := true;
            plates[i].Fileisloaded := true;
            plates[i].ImageEn.update;
            //plates[i].ImageEn.zoom := prevzoom;
          end;
        End;
        For i := 1 to Nplates do
        begin
          IF Not plates[i].Azone then
          begin
            IF (Uppercase(plates[i].Colorname) = 'C') or (Uppercase(plates[i].Colorname) = 'CYAN') then
            Begin
              plates[i].CMYKtype := 1;
            End;
            IF (Uppercase(plates[i].Colorname) = 'M') or (Uppercase(plates[i].Colorname) = 'MAGENTA') then
            Begin
              plates[i].CMYKtype := 2;
            End;
            IF (Uppercase(plates[i].Colorname) = 'Y') or (Uppercase(plates[i].Colorname) = 'YELLOW') then
            Begin
              plates[i].CMYKtype := 3;
            End;
            IF (Uppercase(plates[i].Colorname) = 'K') or (Uppercase(plates[i].Colorname) = 'BLACK') or
               (Uppercase(plates[i].Colorname) = 'GRAY') then
            Begin
              plates[i].CMYKtype := 4;
            End;
          End;
        End;
        CI := -1;
        MI := -1;
        KI := -1;
        YI := -1;
        For i := 1 to Nplates do
        begin
          IF plates[i].CMYKtype = 1 then
          begin
            CI := i;
          end;
          IF plates[i].CMYKtype = 2 then
          begin
            MI := i;
          end;
          IF plates[i].CMYKtype = 3 then
          begin
            YI := i;
          end;
          IF plates[i].CMYKtype = 4 then
          begin
            KI := i;
          end;
        End;

        levelImageEn.Bitmap.Width := platewidth;
        levelImageEn.Bitmap.height := plateheight;
        if (Prefs.PreviewUsePregeneratedDns) AND (not Prefs.GrayDensityMap) then
        begin
          loadpregendns;
        end
        else
        begin
          createlevelimage;
        end;
        ProgressBar1.position := ProgressBar1.position+1;
        ProgressBar1.repaint;
        if CI > -1 then
        begin
          plates[CI].ImageEn.Zoom := ImageEn1.Zoom;
        end;
        if MI > -1 then
        Begin
          plates[MI].ImageEn.Zoom := ImageEn1.Zoom*Sepscale;
        End;
        if YI > -1 then
        Begin
          plates[YI].ImageEn.Zoom := ImageEn1.Zoom*Sepscale;
        End;
        if KI > -1 then
        Begin
          plates[KI].ImageEn.Zoom := ImageEn1.Zoom*Sepscale;
        End;

        if (Prefs.PreviewShowSidebar) then
        begin
          For i := 1 to nplates do
          begin
            IF (not plates[i].Azone) then
            begin
              plates[i].Smallimage.Bitmap.Width := plates[i].ImageEn.bitmap.Width;
              plates[i].Smallimage.Bitmap.height := plates[i].ImageEn.bitmap.height;
              plates[i].Smallimage.MouseInteract := [miScroll];//[miScroll];
              plates[i].Smallimage.ScrollBars := ssNone;
              plates[i].Smallimage.SelectionOptions := [iesoAnimated,iesoSizeable,iesoMoveable];
              plates[i].Smallimage.OnMouseDown :=ImageEnsmallMouseDown;
              plates[i].Smallimage.OnViewChange := ImageEnsmallViewChange;
              fastmerge(plates[i].ImageEn.Bitmap,plates[i].Smallimage.Bitmap);
              plates[i].Smallimage.update;
              plates[i].Smallimage.fit;
              prevzoomsmall := plates[i].Smallimage.Zoom;
            end;
          End;
        End;
        sepsareloaded := true;
      end;

  except
  end;
//  GroupBoxloading.Visible := false;
  GroupBoxloading2.caption := aktcap;
end;

procedure TFormprevPlate2.Button2Click(Sender: TObject);
begin
  Formfiletaginfo.showmodal;
end;

Procedure TFormprevPlate2.readpageorderspecific(Amaster : Longint);
Var
//  T : string;
//  eventtime : tdatetime;
  I                     : Longint ;
  //res,
//  sheetside,proofid,templateid : Integer;
//  APPOS : pparray;
//  ANPPOS : Integer;
//  Copyseparationsets : TStrings;
//  aktpi,Ithumb : Integer;
//  readordfilename : string;
begin
  IF lasttime = 0 then
    lasttime := now;
  try
    AktReadorder := 0;
    For i := 1 to NReadordermasters do
    begin
      IF (Readordermasters[i].masterl = Amaster) or (Readordermasters[i].masterr = Amaster) then
      begin
        AktReadorder := i;
        break;
      End;
    end;
    IF (AktReadorder > 0) and (AktReadorder <= NReadordermasters) then
    begin
      prevmasterL := Readordermasters[AktReadorder].masterl;
      prevmasterR := Readordermasters[AktReadorder].masterR;
      loadprevform;

      PageControl1.ActivePageIndex := 0;
    end
    else
    begin
      FormprevPlate2.close;
    end;
  Except
  end;
end;

procedure TFormprevPlate2.gotospecific(Amaster : Longint);
//Var
//  I,aktpindex : Integer;
//  Copyseparationsets : TStrings;
//  Newmast : Integer;
//  eventtime : tdatetime;
//  t,Incopyseps : String;
begin
  IF lasttime = 0 then
    lasttime := now;

  Try
    if (Prefs.AllowParalelView) then
    begin
      Actionprint.Visible := false;
      ActionSave.Visible := false;
      Actionapprove.Visible := false;
      Actionreject.Visible := false;
      Action2.Visible := false;
      Actionprevchangeprofer.Visible := false;
      ActionpreviewApproveNext.Visible := false;
      ActionpreviewDisApproveNext.Visible := false;
      ActionpreviewNext.Visible := false;
      Actionprev.Visible := false;
      ActionpreviewApproveprev.Visible := false;
      ActionpreviewRejectprev.Visible := false;
      Actiongotonotapproved.Visible := false;
      Action1.Visible := false;
      ActionComment.Visible := false;
      ActionEmail.Visible := false;
      Actioneditcolors.Visible := false;
      Actionprevrelease.Visible := false;
      Actionprevhold.Visible := false;
      Actionmasked.Visible := false;
      Actiondoconsole.Visible := false;
      Actionconsole.Visible := false;
      Actionloadspeparations.Visible := false;
      Action4.Visible := false;
      Actionsetfalsespread.Visible := false;
    end;
    settheallowedarrow;
    prevmaster := Amaster;

    DataM1.Query1.sql.clear;
    DataM1.Query1.sql.add('Select TOP 1 locationid,editionid,sectionid,pagename,publicationID from pagetable (NOLOCK) ');
  //  IF usepdfmaster then
  //    DataM1.Query1.sql.add('where Pdfmaster = ' + inttostr(Amaster))
  //  else
    DataM1.Query1.sql.add('where mastercopyseparationset = ' + inttostr(Amaster));
    DataM1.Query1.sql.add('and active = 1');
    DataM1.Query1.sql.add('order by locationid,editionid,sectionid,pagename');
    formmain.Tryopen(DataM1.Query1);
    if not DataM1.Query1.eof then
    begin
      FormprevPlate2.Caption := 'Product: '+tnames1.locationIDtoname(DataM1.Query1.fields[4].asinteger)+'   '+
           'Edition: '+tnames1.editionIDtoname(DataM1.Query1.fields[1].asinteger)+'   '+
           'Section: '+tnames1.sectionIDtoname(DataM1.Query1.fields[2].asinteger)+'   '+
           'Name: '+DataM1.Query1.fields[3].asstring;
    end;
    DataM1.Query1.close;

    IF prevmaster > -1 then
    begin
      loadprevform;
    end
    Else
    begin
      FormprevPlate2.close;
    end;
  except
  end;
  if (Prefs.AllowParalelView) then
  begin
    Actionprint.Visible := false;
    ActionSave.Visible := false;
    Actionapprove.Visible := false;
    Actionreject.Visible := false;
    Action2.Visible := false;
    Actionprevchangeprofer.Visible := false;
    ActionpreviewApproveNext.Visible := false;
    ActionpreviewDisApproveNext.Visible := false;
    ActionpreviewNext.Visible := false;
    Actionprev.Visible := false;
    ActionpreviewApproveprev.Visible := false;
    ActionpreviewRejectprev.Visible := false;
    Actiongotonotapproved.Visible := false;
    Action1.Visible := false;
    ActionComment.Visible := false;
    ActionEmail.Visible := false;
    Actioneditcolors.Visible := false;
    Actionprevrelease.Visible := false;
    Actionprevhold.Visible := false;
    Actionmasked.Visible := false;
    Actiondoconsole.Visible := false;
    Actionconsole.Visible := false;
    Actionloadspeparations.Visible := false;
    Action4.Visible := false;
    Actionsetfalsespread.Visible := false;
  end;
  settheallowedarrow;
end;


procedure TFormprevPlate2.ImageEn1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  IF Key = 13 then
  Begin
    ActionapproveExecute(Self);
  End;
  IF Key = 27 then
  Begin
    Close;
  End;
  IF Key = 34 then
  Begin
    ImageEn1.ViewY := 10000;
    Application.ProcessMessages;
    Sleep(10);
  End;
  IF Key = 33 then
  Begin
    ImageEn1.ViewY := 0;
    Application.ProcessMessages;
    Sleep(10);
  End;
 // IF (Key = 19)  then
 IF (Key = 83) OR (Key = 115) then
  begin
    ActionSaveExecute(self);
  end;
 //  IF (Key = 16) then
  IF (Key = 80) OR (Key = 112) then
  begin
    ActionPrintExecute(self);
  end;
end;

procedure TFormprevPlate2.ImageEn1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
Var
  px,py : Integer;
  CC,MM,YY,KK{,r,g,b} : Integer;
//  tc,tm,ty,tk : TColor;
//  I : Integer;
//  acanvas : tcanvas;
  Insidetheimage
  //,blnkK
   : boolean;
begin
  IF (not Prefs.PreviewSeparationsOnReadview)  then
  begin
    Exit;
  End;
  try
    IF aktProofPDI > 0 then
    begin
      getmousemmpos(x,y,aktMMposX,aktMMposY);
      //InfraStatusBar1.Panels[7].Text := 'X: '+FormatFloat('0.0',aktMMposX)+ ' , '+'Y: '+FormatFloat('0.0',aktMMposY);
      StatusBar1.Panels[7].Text := 'X: '+FormatFloat('0.0',aktMMposX)+ ' , '+'Y: '+FormatFloat('0.0',aktMMposY);
    End;
    Insidetheimage := (x-ImageEn1.OffsetX < ImageEn1.ExtentX+ ImageEn1.viewx) and (x-ImageEn1.OffsetX > 0) and
               (Y-ImageEn1.OffsetY < ImageEn1.EXtentY+ ImageEn1.viewY) and (Y-ImageEn1.OffsetY > 0);

    px := ImageEn1.XScr2Bmp(x);
    py := ImageEn1.YScr2Bmp(y);
    IF (px <= platewidth) and (py <= plateheight) And (Insidetheimage) then
    begin
      if px < 0 then exit;
      if py < 0 then exit;
      IF CI > -1 then
        CL := plates[CI].ImageEn.Bitmap.ScanLine[py];
      IF MI > -1 then
        ML := plates[MI].ImageEn.Bitmap.ScanLine[py];
      IF YI > -1 then
        YL := plates[YI].ImageEn.Bitmap.ScanLine[py];
      IF KI > -1 then
        KL := plates[KI].ImageEn.Bitmap.ScanLine[py];
      CC := 0;
      MM := 0;
      YY := 0;
      KK := 0;
      IF KI > -1 then
      begin
        KK := KL[px].rgbtRed;
        IF KK > 253 then
          KK := 253;
        KK := ((253-KK) * 100 ) div 253;
      End;
      IF CI > -1 then
      begin
        CC := CL[px].rgbtRed;
        IF CC > 253 then
          CC := 253;
        CC := ((253-CC) * 100 ) div 253;
      End;
      IF MI > -1 then
      begin
        MM := ML[px].rgbtGreen;
        IF MM > 253 then
          MM := 253;
        MM := ((253-MM) * 100 ) div 253;
      End;
      IF YI > -1 then
      begin
        YY := YL[px].rgbtBlue;
        IF YY > 253 then
          YY := 253;
        YY := ((253-YY) * 100 ) div 253;
      End;
      //InfraStatusBar1.Panels[9].Text := 'C: ' + inttostr(CC) + '% M: '+ inttostr(MM) + '% Y: '+inttostr(YY) + '% K: '+inttostr(KK) + '% TOTAL: '+ inttostr(KK+CC+MM+YY) +'%';
      StatusBar1.Panels[9].Text := 'C: ' + inttostr(CC) + '% M: '+ inttostr(MM) + '% Y: '+inttostr(YY) + '% K: '+inttostr(KK) + '% TOTAL: '+ inttostr(KK+CC+MM+YY) +'%';
      InkIsOverLimit :=  KK+CC+MM+YY >= Prefs.InkWarningLevel;
      //InfraStatusBar1.Canvas.Refresh;
      StatusBar1.Canvas.Refresh;
      IF NOT InkIsOverLimit then
      begin
          //InfraStatusBar1.Panels[10].Text := '';
          StatusBar1.Panels[10].Text := '';
      (*  if not Imageunderlimit.Visible then
        begin
          Imageunderlimit.Visible := true;
          Imageabovelimit.Visible := false;
          Imageunderlimit.repaint;
        end;   *)
      end
      else
      begin
         //InfraStatusBar1.Panels[10].Text := 'OVER LIMIT!';
         StatusBar1.Panels[10].Text := 'OVER LIMIT!';
       (* if not Imageabovelimit.Visible then
        begin
          Imageabovelimit.Visible := true;
          Imageunderlimit.Visible := false;
          Imageabovelimit.repaint;
        end; *)
      end;
    End
    Else
    begin
      //InfraStatusBar1.Panels[9].Text := '';
      StatusBar1.Panels[9].Text := '';
    end;
  Except
    //InfraStatusBar1.Panels[9].Text := '';
    StatusBar1.Panels[9].Text := '';
  end;
end;

procedure TFormprevPlate2.ImageEn1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  prevzoom := ImageEn1.Zoom
end;

procedure TFormprevPlate2.ImageEn1SelectionChange(Sender: TObject);
Var
//  zfact : Double;
  w,h : Integer;
//  xm1,xm2,ym1,ym2,
  wm,hm : Double;
begin
  //InfraStatusBar1.Panels[4].Text := '';
  StatusBar1.Panels[4].Text := '';
  If aktProofPDI = 0 then
    aktProofPDI := 104;
  w := ImageEn1.SelX2 - ImageEn1.SelX1;
  h := ImageEn1.Sely2 - ImageEn1.Sely1;
  IF (w < 0) or (h < 0) then
  begin
    //InfraStatusBar1.Panels[4].Text := '';
    StatusBar1.Panels[4].Text := '';
    exit;
  end;
  wm := (w/aktProofPDI) * 25.4;
  hm := (h/aktProofPDI) * 25.4;
  IF wm < 0 then
    wm := 0;
  IF hm < 0 then
    hm := 0;

  //InfraStatusBar1.Panels[4].Text := 'W: '+FormatFloat('0.0',wm) + '  H: '+  FormatFloat('0.0',hm);
  StatusBar1.Panels[4].Text := 'W: '+FormatFloat('0.0',wm) + '  H: '+  FormatFloat('0.0',hm);

  (*
  x := x + ImageEn1.viewx;
  y := y + ImageEn1.viewy;
  zfact := (100 / ImageEn1.Zoom);
  IF (x-ImageEn1.OffsetX > ImageEn1.ExtentX+ ImageEn1.viewx) then
  begin
    x := ImageEn1.ExtentX+ImageEn1.OffsetX+ ImageEn1.viewx;
  end;
  IF (y-ImageEn1.Offsety > ImageEn1.Extenty+ ImageEn1.viewy) then
  begin
    y := ImageEn1.Extenty+ImageEn1.Offsety+ ImageEn1.viewy;
  end;
  xm := ((x-ImageEn1.OffsetX)/aktProofPDI) * 25.4;
  ym := ((y-ImageEn1.OffsetY)/aktProofPDI) * 25.4;
  IF Ym < 0 then
    Ym := 0;
  IF xm < 0 then
    xm := 0;
  xm := xm * zfact;
  ym := ym * zfact;
  //25.4
  *)
end;
procedure TFormprevPlate2.ImageEn1ZoomIn(Sender: TObject; var NewZoom: Double);
Var
  s : string;
begin
  IF (prevzoom + Prefs.PreviewZoomStep) > Prefs.PreviewMaxzoom then
  begin
    NewZoom := prevzoom;
    //beep;
  end;
  if NewZoom <> prevzoom then
  begin
    newzoom := prevzoom + Prefs.PreviewZoomStep;
    Str(newzoom:5:2,s);
    prevzoom := newzoom;
    //InfraStatusBar1.Panels[0].Text := 'Scale : ' + s;
    StatusBar1.Panels[0].Text := 'Scale : ' + s;
    if CI > -1 then
      plates[CI].ImageEn.Zoom := NewZoom;
  end;
end;
procedure TFormprevPlate2.ImageEn1ZoomOut(Sender: TObject; var NewZoom: Double);
Var
  s : string;
begin
  IF (prevzoom - Prefs.PreviewZoomStep) < Prefs.PreviewMinzoom then
  begin
    NewZoom := prevzoom;
    beep;
  end
  else
  begin
    newzoom := prevzoom - Prefs.PreviewZoomStep;
    str(newzoom:5:2,s);
    prevzoom := newzoom;
    //InfraStatusBar1.Panels[0].Text := 'Scale : ' + s;
    StatusBar1.Panels[0].Text := 'Scale : ' + s;
  End;
end;

procedure TFormprevPlate2.ActionsetfalsespreadExecute(Sender: TObject);
begin
  if Formfalsespread.showmodal = mrok then
  begin
    Formfalsespread.setcreeptofalsespread(prevmaster);
  end;
end;
procedure TFormprevPlate2.ActionShowNoteExecute(Sender: TObject);
Var
  CommentNoteRect : TRect;
begin
  ActionShowNote.Checked := Not ActionShowNote.Checked;
  If ActionShowNote.Checked then
  Begin
    CommentNoteRect             := RGBImageEn.BoundsRect;
    CommentNoteRect.TopLeft     := ClientToScreen(CommentNoteRect.TopLeft);
    CommentNoteRect.BottomRight := ClientToScreen(CommentNoteRect.BottomRight);
    CommentNoteRect.TopLeft.x := CommentNoteRect.TopLeft.x + 200;
    BalloonHint.ShowHint(CommentNoteRect);
    BalloonHint.ImageIndex := 74;
  End else
  Begin
    BalloonHint.HideHint;
  End;
end;

Procedure TFormprevPlate2.ActionapproveExecute(Sender: TObject);

    Procedure Doapproved(Amaster : Longint);
    Var
      i         : Integer;
      Copyseparationsets : TStrings;
      T         : string;
      eventtime : tdatetime;
    begin
      Copyseparationsets := TStringList.Create;
      try
      //  i:= 0;
        //T := 'set approved = 1';
        DataM1.Query1.sql.clear;
        DataM1.Query1.sql.add('update pagetable set approved = 1');
        DataM1.Query1.sql.add('where mastercopyseparationset = ' + IntToStr(Amaster));
        formmain.trysql(DataM1.Query1);
        DataM1.Query1.sql.clear;
        DataM1.Query1.sql.add('select Distinct Copyseparationset from pagetable with (nolock) ');
        IF UsePDFMaster then
        // ## NAN 20150204
        //      DataM1.Query1.sql.add('where PDFMaster = ' + inttostr(Amaster))
          DataM1.Query1.sql.add('where (pdfmaster>0 AND pdfmaster = ' + IntToStr(Amaster) + ') OR (pdfmaster=0 AND mastercopyseparationset = ' + inttostr(Amaster) + ')')
        else
          DataM1.Query1.sql.add('where mastercopyseparationset = ' + IntToStr(Amaster));
        DataM1.Query1.Open;
        while not DataM1.Query1.eof do
        begin
          Copyseparationsets.add(DataM1.Query1.fieldbyname('Copyseparationset').asstring);
          DataM1.Query1.next;
        end;
        DataM1.Query1.close;
        if (Prefs.RemoveMissingColorsOnApprove) then
        Begin
          DataM1.Query1.sql.clear;
          DataM1.Query1.sql.add('update pagetable Set active = 0');
          DataM1.Query1.sql.add('where mastercopyseparationset = ' + inttostr(Amaster));
          DataM1.Query1.sql.add('and status = 0 ');
          formmain.trysql(DataM1.Query1);
        End;
        for i := 0 to Copyseparationsets.Count - 1 do
        begin
          DataM1.Query1.sql.Clear;
          DataM1.Query1.sql.add('update pagetable');
          DataM1.Query1.sql.add('set approvetime = getdate(),approveuser='+''''+Prefs.username+'''');
          DataM1.Query1.sql.add('where Copyseparationset = ' + Copyseparationsets[i] );
          formmain.trysql(DataM1.Query1);
        end;
        if UsePDFMaster then
          formmain.afterapproval(-1,Amaster)
        else
          formmain.afterapproval(Amaster,-2702);

        IF (Prefs.LogApproval) then
        begin
          eventtime := -1;
        //  formmain.Addlogentry(70,formlogin.username,eventtime,-1,-1,-1,Amaster,-1,-1,-1);
        End;
      Finally
        Copyseparationsets.Free;
        Close;
      End;
    end;
//Var
//  ir : Integer;
Begin

    Doapproved(prevmaster);

end;

procedure TFormprevPlate2.ActionrejectExecute(Sender: TObject);
//Var
//  s,t : string;
//  Amaster : Integer;
begin

    DataM1.Query1.sql.clear;
    DataM1.Query1.sql.add('update pagetable set approved = 2');
    DataM1.Query1.sql.add('where mastercopyseparationset = ' + inttostr(prevmaster));
    DataM1.Query1.ExecSQL(false);
    Nselectedmasters := 0;
    formmain.addtoselectedmasters(prevmaster);

  Formmain.sendedisapprovemail(-1,'Page disapproved',1);
  Close;
end;

Procedure TFormprevPlate2.Clearprev2;
Begin
  IF FormprevPlate2.showing and Prefs.AllowParalelView then
  begin
    ImageEn1.Clear;
    While PageControl1.PageCount > Fixedtabs do
    begin
      PageControl1.Pages[PageControl1.PageCount-1].Destroy;
    end;
    While ImageList1.Count > Fixedtabs do
    begin
      ImageList1.Delete(ImageList1.Count-1);
    end;
    Panelsmallvis.visible := false;
  End;
End;


procedure TFormprevPlate2.InfraStatusBar1DrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
//Var
//  r : trect;
begin
  with StatusBar.Canvas do
    begin
    case Panel.Index of
      9: begin
           if (InkIsOverLimit) then
              Font.Color := clRed
           else
              Font.Color := clBlack;
           TextRect(Rect,Rect.Left,Rect.Top,Panel.Text);
         end;
    end;
  end;
end;
end.







