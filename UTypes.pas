unit UTypes;
(*

Nye felter
I PageTable:

Felt RipSetupID (int)
DWORD n = dwRipSetupIDFraPageTable;
int nRipSetupID = n & 0x0000FF;
int nPreflightSetupID = (n & 0x00FF00) >> 8;
int nSaveinkSetupID = (n & 0xFF0000) >> 16;
Eksempel:
dwRipSetupIDFraPageTable=0x020101 (131329)
nRipSetupID = 1
nPreflightSetupID = 1
nSaveinkSetupID = 2


I PublicationTemplates..
Felt RipSetup er en string..(pis)
De tre setups er sammensat med semikolon:
"RipSetup;PreflightSetup;InksaveSetup"
Eksempel "Std;Std;Bypass"

Planning Er Det en pdf plan s� er bit 2 i seperate runs sat

TreeSel := 1;
PlanCenterSetup
Tabel i controlcenter
GlobalSettings   komma separeret
pressspecik, systemtype,
Pressspecifik
0 Ikke pressspecifik
1 alt er pressspecifik

GlobalVars
Bruges til system type tom eller 1 normal, 2 prepare trans system, 3 channel system
Globalsystemtype
FlatPageTable
Kun hvis FlatPageTablePossible
resample processtype 65 el. 66
event    queued 158   bl� � prik
         started 159  bl� � prik
         error 156    r�d � prik
         ok      150 aflevet  g� efter normal status
Ediution types
state sat i pressrun id
0 open
1 locked
2 working
4 klar til at blive en timed
*)
//fileservertypes
(*
1 mainserver
2 localserver al'a nortt�lje
3 remoteserver dvs outputcenter maskine med workfolder
4 inkserver inkcenter med inkprevies
5 webserver
6 backupserver
7 PDF SERVER
kun hvis der er en type 2 er der tale om et multiserver system ligesom i NT
*)
// approval  -1 auto 0 not approved 1 approved 2 disapproved  i status 20 +
 (* flags
   bl� 4-5   editorial men ingen press ingen location
   gr�n 6-7  running   press og location er sat
   red 8-9   error
   hvid 10-11  pressplan under construction arbejde findes ikke i db
   gul 12-13   copy af running and press og/eller anden location
 *)
//pagetypes 0 norm 1 pano 2 anti 3 dummy
// TreeViewpages rod = 0 plan=1 publication = 2 issue=3 edition = 4 section = 5 page=6 color=7
//dbversion 1 gammel pressrunid 2 ny pressrunid
// TreeViewPressrun   press=0 plan=1 presssection + issue + edition = 2 section =3 page = 4 color = 5;
(*
CopyFlatSeparationSet := Pressrundatatype(pagenode.Data^).CopyFlatSeparationSet;
FlatSeparationSet     := (CopyFlatSeparationSet*100)+Copynumber;
FlatSeparation        := (FlatSeparationSet*100)+ colorI;
*)
(*
Uniquepage
0 common
1 unique
2 forced
*)
(*
message events
event
page
500 unread     info
501 unread     Sevier
510 read       info
511 read       Sevier
MASTER gir sig selv
pressrun
520 unread     info
521 unread     Sevier
530 read       info
531 read       Sevier
MASTER find et eller andet master i run
ProcessID
0 CC
1..x CustommerId
//eller 1 hvis ingen custommer id
ProcessType
1 master
2 pressrunid
*)
(*
Nametype 1 edition
         3 pressrun
         4 publication
         5 section
         7 location
         8 proofs  / ogs� hardproof
        11 device
        12 flatproof
        13 custommer
        100 color
        110 pressname
        120 pageformat
*)
interface
Uses
  Winapi.Windows,
  System.StrUtils,
  System.IOUtils,
  System.IniFiles,
  System.Classes,
  System.SysUtils,
  System.Types,
  Vcl.Controls,
  Vcl.ComCtrls,
  Vcl.Graphics,
  UMultirunframe,
  PBExListview,
  udata,
  //UStatusframe,
  UStatusmother,
  UImages,
  UDeviceControlframe ,
  UUtils;
Var
  imposeSize : Integer;
  plancentermainlog : Tstrings;
 // MAXSECTIONS	 : Integer;	// To be adjusted..
Const
  MAXSECTIONS = 200;
  MAXPAGESINSECTION = 256;
	//MAXLOCATIONS = 20;
	//MAXPRESSES = 50;
  MAXSTATUSES = 200;
  MAXTEMPLATES = 512;
  MAXINKFOLDERS = 32;
  MAXPDFFOLDERS = 32;
  MAXTHUMBNAILS = 1000;
  AllowSchedules = false;
  dbcoloroffset = 50;
  dbnamepost = '2';
  PLATEVIEWGUTTER = 12; //16
  PLATEVIEWGUTTERVERTICAL = 22; // 28;
  PLANVIEWGUTTER = 16;
  PLANVIEWGUTTERVERTICAL = 28;
  PLANVIEWXADJUST = 12; //= 28;

  tal : set of AnsiChar =['0'..'9'];
  Decimaltal : set of AnsiChar=['0'..'9','.'];
  //0 just open, 1 edit mode, 2 wizard mode, 3 copymode, 4 movemode, 5 applymode, 6 multisave
  PLANADDMODE_LOAD = 0;
  PLANADDMODE_EDIT = 1;
  PLANADDMODE_CREATE = 2;
  PLANADDMODE_COPY = 3;
  PLANADDMODE_MOVE = 4;
  PLANADDMODE_APPLY = 5;
  PLANADDMODE_MULTISAVE = 6;
  PLANAPPLYMODE_LOAD = 1;
  PLANAPPLYMODE_WIZARD = 2;
  PLANAPPLYMODE_WIZARD_OTHER_PRESS = 3;
  Errorstates : set of byte=[6,16,26,36,46,56,66,76,86,96];
  blueflag = 4;
  greenflag = 6;
  whiteflag = 8;
  BWpageidx = 49;
  COLORpageidx = 50;
  treimdx: array[0..9] of integer = (40,20,16,23,11,0,41,28,8,9);
  pagetreimdx: array[0..9] of integer = (59,20,16,23,11,0,41,28,8,9);
  fronbackstr: array[0..1] of string = ('Front','Back');
  //DLL interface
  MAXPAGES = 64;	// Pages total front+back per flat
  MAXFLATS    = 256;
 // MAXISSUES   = 40;
  //DLL interface
  //maxDBcolorsonpage = 20;
 // Impospw100 = 36*2;
 // Imposph100 = 48*2;
  Impospw100 = 40*2;
  Imposph100 = 50*2;
  Imposmw100 = 4;
  Imposmh100 = 4;
  PartialeditOK = false;
   FILESERVERTYPE_MAIN = 1;
   FILESERVERTYPE_LOCAL = 2;
   FILESERVERTYPE_OUTPUTCENTER = 3;
   FILESERVERTYPE_INKCENTER = 4;
   FILESERVERTYPE_WEBCENTER	= 5;
   FILESERVERTYPE_BACKUPSERVER = 6;
   FILESERVERTYPE_PDFSERVER = 7;
   FILESERVERTYPE_PROOFCENTER	= 8;
   FILESERVERTYPE_ADDITIONALPREVIEW	= 9;
   FILESERVERTYPE_ADDITIONALFLATPREVIEW	= 10;
   FILESERVERTYPE_PLANCENTER = 11;
   PATHTYPE_CCFILES = 1;
   PATHTYPE_CCPREVIEWS = 2;
   PATHTYPE_CCTHUMBNAILS = 3;
   PATHTYPE_CCREADVIEWPREVIEWS = 4;
   PATHTYPE_CCVERSIONS = 5;

   LOCATIONPRESSSFILTERMODE_NONE = 0;
   LOCATIONPRESSSFILTERMODE_PRESS = 1;
   LOCATIONPRESSSFILTERMODE_PRESSGROUP = 2;
   LOCATIONPRESSSFILTERMODE_LOCATION = 3;

   VIEW_SEPARATIONS = 0;
   VIEW_THUMBNAILS = 1;
   VIEW_PLATES = 2;
   VIEW_PRODUCTIONS = 3;
   VIEW_EDITIONS = 4;
   VIEW_PLANS = 5;
   VIEW_LOGS = 6;
   VIEW_REPORTS = 7;
   VIEW_FILES = 8;
   VIEW_ACTIVEQUEUE = 9;
  ProdImpospw100 = 50;
  ProdImposph100 = 75;
  ProdImposmw100 = 4;
  ProdImposmh100 = 4;

  ICON_WARNINGSIGN = 199;
  ICON_PLANAPPLIED = 185;
  ICON_PLANUNAPPLIED = 16;
  ICON_PLANYELLOW = 295;
  ICON_PLANRED = 296;
  ICON_TIMEDEDITIONWHITE = 243;
  ICON_TIMEDEDITIONGREEN = 227;
  ICON_TIMEDEDITIONRED = 229;
Type
  PstatusframeDataType = ^TstatusframeDataType;
  TstatusframeDataType = record
                       Rect : Trect;
                       Itsablank : Boolean;
                       EditionID : Integer;
                       SectionId : Integer;
                       PageIndex : Integer;
                       FTP : Integer;
                       PRE : Integer;
                       INK : Integer;
                       RIP : Integer;
                       Ready : Integer;
                       Appr : Integer;
                       CTP : Integer;
                       Bend : Integer;
                       Preset : Integer;
                       Sorted : Integer;
                       FTPversion : Integer;
                       PREversion : Integer;
                       INKversion : Integer;
                       RIPversion : Integer;
			                 Readyversion : Integer;
                       Apprversion : Integer;
                       CTPversion : Integer;
                       Bendversion : Integer;
                       SortedVersion : Integer;
                       Presetversion : Integer;
                     End;
		 //	FTPtime ,PREtime ,INKtime ,RIPtime ,Readytime ,Approvetime , CTPtime ,Bendtime ,Presettime,

  (*Tstatusframetype = record
                       Pubdate : Tdatetime;
                       Publicationid : Integer;
                       pressid : Integer;
                       pressgrpId : Integer;
                       StatusFrame : TFrameStatus;
                     End;
    *)

  TreestateDataType = record
                        LocationID : Integer;
                        Pubdate : Tdatetime;
                        PublicationID : Integer;
                        EditionID : Integer;
                        SectionID : Integer;
                        ProductionID : Integer;
                        PressRunID : Integer;
                        MinStatus : Integer;
                        MaxStatus : Integer;
                        NeedApproval : Integer;
                        AllApproved : Integer;
                        AnyUniquePage : Integer;
                        AnyImaging : Integer;
                        AnyReady : Integer;
                        AnyError : Integer;
                        AnyOnHold : Integer;
                        TimeOfState : Tdatetime;
                        MiscInt1 : Integer;
                        MiscInt2 : Integer;
                        MiscInt3 : Integer;
                        MiscInt4 : Integer;
                        StatChange : Boolean;
                        Prodchange : Boolean;
                      end;

  TPlateSelecttionstyle = Record
                            reseting : Boolean;
                            Locationid : Integer;
                            Pressid : Integer;
                            Treedate : tdatetime;
                            Treedateinuse : Boolean;
                            TreeCheckBoxolreadyplates : boolean;
                            Thumbnails : Boolean;
                            Hidecommon : Boolean;
                            HideEmpty : boolean;
                            Showmissing : Boolean;
                            Small : Boolean;
                          end;

  TSchData = Class(Tobject)
    private
    public
      data : array[1..10] of record
                               AType : Integer; // 1 = start  2 = all 3 = stop 4 = start + stop
                               rect : trect;
                               DataType : Integer; // 1 : Pross 2 : press 3 ....
                             end;
    End;


  RecipientArrayType = array[1..20] of record
                                        name : string;
                                        adress : string;
                                        CCname : string;
                                        CCadress : string;
                                      end;
  editiontype = record
                  Unique                  : Integer;
                  ChangeTo                : Integer;
                  Adding                  : boolean;
                  editionid               : Integer;
                  locationid              : Integer;
                  Sectionid               : Integer;
                  pagename                : string;
                  copyseparationset       : Integer;
                  pressrunid              : Integer;
                  pressid                 : Integer;
                  productionid            : Integer;
                  mastercopyseparationset : Integer;
                  Masterlocationid        : Integer;
                  Mastereditionid         : Integer;
                  Mastersectionid         : Integer;
                  OrgMasterlocationid     : Integer;
                  OrgMasterpressid        : Integer;
                  OrgMastereditionid         : Integer;
                  OrgMastersectionid         : Integer;
                  Orgmastercopyseparationset : Integer;
                  Orgpagemasterpagename    : String;
                  IStimed                  : Boolean;
                  TimedFrom                : Integer;
                  TimedTo                  : Integer;
                end;
 (* regexparray = Array[1..100] of record
                                    MatchExpression : string;
                                    FormatExpression : String;
                                    PartialMatch : Integer;
                                  end;
  *)
  trprodcontType = record
                     leveltype       : Integer;
                     ProductionID    : Integer;
                     LocationID      : Integer;
                     PressID         : Integer;
                     PubDate         : Tdatetime;
                     PublicationID   : Integer;
                     EditionID       : Integer;
                     SectionID       : Integer;
                     Copynumber      : Integer;
                   end;

  PThumbdata = ^Thumbdata;
  Thumbdata = record
                pagename : string;
                filenametime : tdatetime;
                Mastercopyseparationset : Integer;
                LocationID              : Integer;
                pubdate                 : tdatetime;
                productionID            : Integer;
                IssueID                 : Integer;
                publicationID           : Integer;
                SectionID               : Integer;
                EditionID               : Integer;
                Copynumber              : Integer;
                NColors                 : Integer;
                Colors                  : array[1..10] of record
                                                            colorID : Integer;
                                                            status : Integer;
                                                          end;
                ColorID                 : Integer;
                status                  : Integer;
              end;
  pparray = Array[1..64] of integer;
  marksarray = Array[1..100] of integer;

  // DLL interface
  TFLATDEF = record
                bIsDualSided           : Integer;				// 0: Single sided signature 1: dual sided signature
    	          nPagesPerSide          : Integer;					// Number of page positions per side (incl. dummies) (eg. 4 for 4up)
    	          aSignaturePages        : ARRAY[0..129] OF Integer;		// Signature master for front side followed by back side. Eg. 4,1, 2,3
	              aHalfwebSignaturePages : ARRAY[0..129] OF Integer;	// Signature master for halfweb front side followed by back side. Use 0 for dummys (halfwebs) eg. 0,1, 2,0
    	          aOutputPages           : ARRAY[0..129] OF Integer;			// Final re-numbered pagenumbers for both sides - front followed by back
	              aCreep                 : ARRAY[0..129] OF double;			// Calculated creep in mm per page - use directly in PageTable Creep field..
              End;
   TSECTIONDEF = Record
                   nPagesInSection     : Integer;				// Actual pages in section (excluding dummies)
    	             nBindingStyle 			 : Integer;		    // 0: Perfect bound,  1: Saddle Stitched  (more may come)
    	             nFlatsInSection 		 : Integer;		    // SET INTERNALLY. Number of flats for this section
   	               nStartingPageNumber : Integer;				// Start number for section not inserted in each other!
	                 nHalfWebPage        : Integer;				// Page number of halfweb - lowest page number on falt
	                 nHalfWebPage2       : Integer;				// Page number of optional second halfweb - lowest page number on falt
	                 aFlats              : array[0..MAXFLATS] of Tflatdef;			// Placeholder for the flats
                 END;

   TPRODUCTIONDEF = RECORD
                      nPagesInProduction           : Integer;			  // SET INTERNALLY - Actual pages in whole job (excluding dummies)
                      nSectionsInProduction        : Integer;			  // Number of sections in production
                      nGeneralPageOffset           : Integer;				// Start number for whole production
                      nCollectionMode              : Integer;				// 0: consecutive,  1: Inserted
                      nSplitmode                   : Integer;			  // Collectmode 0 no , 1 sidebyside 2 overunder
                      aSections                    : ARRAY[0..MAXSECTIONS] of TSECTIONDEF;	// Sections in production
//                      aSections                    : ARRAY of TSECTIONDEF;	// Sections in production
                      fCreepSetting                : double;				// Creep from Run dialog - mm per 100 pages
                    END;
  TImposecalc = function(Var PRODUCTION : TPRODUCTIONDEF): Integer;stdcall;
  CalculateImposeVersionType  = function: Integer;stdcall;
  RipSetupNameSetupType = function(Errormessage : PAnsichar): Integer;stdcall;

  StackingBinSetupType  = function(Errormessage : PAnsichar): Integer;stdcall;

  ResampleProgressCallBackType = procedure(progress : Longint);stdcall;
  ResampleRegisterProgressType = function(AResampleProgressCallBack : ResampleProgressCallBackType): Integer;stdcall;
  ResampleInitType  = function: Integer;stdcall;
  ResampleCancelType = function: Integer;stdcall;
  ResampleType = function(XmlFileName : pchar; Errormessage : PAnsichar): Integer;stdcall;

  UrlRequestType   = function(szUrl : pchar; szErrorMessage : PAnsichar): Integer;stdcall;
  DeviceSetupType  = function(Errormessage : PAnsichar): Integer;stdcall;

  ApplyPlateMergeType = function(Errormessage : PAnsichar): Integer;stdcall;
  SplitProductType = function(productionID : Integer; Errormessage : PAnsichar): Integer;stdcall;

  PressSetupType  = function(Errormessage : PAnsichar): Integer;stdcall;
  TemplateSetupType  = function(Errormessage : PAnsichar): Integer;stdcall;
  CombinepressrunType  = function(PressName    : PAnsichar; Errormessage : PAnsichar): Integer;stdcall;

  RenameFileDialogType = function(pFilenameIn : Pointer; pFilenameOut : Pointer; numberOfFiles : Longint): Integer;stdcall;

  ExportPressTemplateDataDialogType  = function(Errormessage : PAnsichar): Integer;stdcall;

  GeneralSetupType  = function(Errormessage : PAnsichar): Integer;stdcall;
  PublicationEditionSectionAliasSetupType = function(Errormessage : PAnsichar): Integer;stdcall;
  JobNamesSetupType = function(Errormessage : PAnsichar): Integer;stdcall;
  ChannelNamesSetupType = function(Errormessage : PAnsichar): Integer;stdcall;
  PageFormatSetupType = function(Errormessage : PAnsichar): Integer;stdcall;
  ColorSetupType  = function(Errormessage : PAnsichar): Integer;stdcall;

  LocationSetupType  = function(Errormessage : PAnsichar): Integer;stdcall;
  ReConnectDBType = function(Errormessage : PansiChar): Integer;stdcall;
  MakePdfBookType = function(nProductionID : Integer;
                             nPressRunID   : Integer;
                             OutputFileName : PansiChar;
                             Errormessage : PansiChar):Integer;stdcall;
  MakePdfBookFlatsType = function(nProductionID : Integer;
                             nPressRunID   : Integer;
                             OutputFileName : PansiChar;
                             Errormessage : PansiChar):Integer;stdcall;

  GenerateReportType = function(nProductionID : Longint): Integer;stdcall;

  IsPDFFileType = function(filname       : Pchar):Integer;stdcall;

  PlotInfotype    = function(pcfilname       : PansiChar ;                             //: Pchar; {komplet sti}
                             Var Xres      : Single;
                             Var Yres      : Single;
                             Var Width     : Single;
	                           Var Height    : Single;
	                           Var CompRatio : Single) :Integer;stdcall;

  FileInfotype    = function(pcfilname       : PansiChar ;                           //PansiChar ;//Pchar; {komplet sti}
                             Var Xres      : Single;
                             Var Yres      : Single;
                             Var Width     : Single;
	                           Var Height    : Single;
	                           Var CompRatio : Single) :Integer; stdcall;
  MemoTextType = array[0..64000] of Char;
  FileInfoExType = function(filname       : Pchar; {komplet sti}
                            Var szInfo    : MemoTextType;
                            maxLenInfo    : Longint): Integer;stdcall;
  TMergeJpegs = function(szFileNameLeft     : pansichar;  // pchar
                         szFileNameRight    : pansichar;
                         szOutputFileName   : pansichar;
                         nPageTypeLeft      : Integer;
                         nPageTypeRight     : Integer;
                         nPagePositionLeft  : Integer;
                         nPagePositionRight : Integer;
                         nSheetSide         : Integer;
                         nProofID           : Integer;
                         nTemplateID        : Integer;
                         nPublicationid     : Integer): Integer;stdcall;
  TDecodeBlowFish2  = function(InputString    : PansiChar; OutputString : PansiChar): Integer;stdcall;
  TEncodeBlowFish2  = function(InputString    : PansiChar; OutputString : PansiChar): Integer;stdcall;
  //DLL interface
  Tstatusarray = array[0..513] of record
                                    name : string;
                                    color : tcolor;
                                  End;
  Tstatusarrayex = array[0..513] of record
                                    name : string;
                                    color : tcolor;
                                    number : Integer;
                                  End;

  TPageNumbering = array[1..64] of integer;
  TPageorientation = array[1..8,1..8] of integer;

  editionviewtype = record
                      publicationid   : Integer;
                      publicationdate : tdatetime;
                      locationid      : Integer;
                      pressid         : Integer;
                      planid          : Integer;
                      Editionid       : Integer;
                    end;
  Peditionviewtype = ^editionviewtype;
  TDrawpagearray = Array[1..8,1..8] of record
                                         pagename : string;
                                         pagination : Integer;
                                         orientation : Integer; //0 up 1 down 2 left, 3 right
                                       end;

  TPlatetemplate = record
                     TemplateID : Integer;
                     TemplateName : String;
                     Outputalias : String;
                     TrimPage : Integer;
                     TrimPageWidth : Single;
                     TrimPageHeight : Single;
                     TrimOffsetXEven : Single;
                     TrimOffsetYEven : Single;
                     TrimOffsetXOdd : Single;
                     TrimOffsetYOdd : Single;
                     BleedMargin : Single;
                     DefaultProofIDEven : Integer;
                     DefaultProofIDOdd : Integer;
                     PressID : Integer;
                     MediaID : Integer;
                     PagesAcross : Integer;
                     PagesDown : Integer;
                     TopMargin : Integer;
                     BottomMargin : Integer;
                     LeftMargin : Integer;
                     RightMargin : Integer;
                     GutterHorzList : String;
                     GutterVertList : String;
                     PageRotationList : TPageNumbering;
                     PageSnapList :  String;
                     PlateReference : Integer;
                     MarksFile : String;
                     TrimMarks : Integer;
                     RegisterMarks : Integer;
                     FoldMarks : Integer;
                     PageNumberingFront : TPageNumbering;
                     PageNumberingBack : TPageNumbering;
                     PageNumberingFrontHalfWeb : TPageNumbering;
                     PageNumberingBackHalfWeb : TPageNumbering;
                     EnableScaling : Integer;
                     ScalingCyanX : Single;
                     ScalingCyanY : Single;
                     ScalingMagentaX : Single;
                     ScalingMagentaY : Single;
                     ScalingYellowX : Single;
                     ScalingYellowY : Single;
                     ScalingBlackX : Single;
                     ScalingBlackY : Single;
                     ScalingSpotX : Single;
                     ScalingSpotY : Single;
                     DirectLithoCyan : Integer;
                     DirectLithoMagenta : Integer;
                     DirectLithoYellow : Integer;
                     DirectLithoBlack : Integer;
                     DirectLithoSpot : Integer;
                     DeviceList : String;
                     DeviceEnableList : String;
                     CassetteList : String;
                     PunchList : String;
                     ExposureLevelList : String;
                     InvertList : String;
                     MirrorList : String;
                     RotationList : String;
                     Copies : Integer;
                     OutputnameMask : String;
                     OutputnameMaskPagenumbers : Integer;
                     OutputnameMaskUseAliases : Integer;
                     Platecut : Integer;
                     TestPageEvenHires : String;
                     TestPageOddHires : String;
                     TestPageEvenLowres : String;
                     TestPageOddLowRes : String;
                     IncomingPageXEven : Single;
                     IncomingPageYEven : Single;
                     IncomingPageXOdd : Single;
                     IncomingPageYOdd : Single;
                     IncomingPageRotationEven : Integer;
                     IncomingPageRotationOdd : Integer;
                     IncomingPageSnapEven : Single;
                     IncomingPageSnapOdd : Single;
                     ShowSheet : Integer;
                     SheetWidth : Single;
                     SheetHeight : Single;
                     SheetOffsetLeft : Single;
                     SheetOffsetTop : String;
                     PageFormatID : Integer;
                     BackAsFront : Integer;
                     TopMarginBack : Single;
                     BottomMarginBack : Single;
                     LeftMarginBack : Single;
                     RightMarginBack : Single;
                     GutterHorzBackList : string;
                     GutterVertBackList : string;
                     PageRotationBackList : TPageNumbering;
                     PageSnapBackList : string;
                     PlateReferenceBack : Integer;
                     MarksFileBack : string;
                     TrimMarksBack : Integer;
                     RegisterMarksBack : Integer;
                     FoldMarksBack : Integer;
                     OffsetCyanX : Single;
                     OffsetCyanY : Single;
                     OffsetMagentaX : Single;
                     OffsetMagentaY : Single;
                     OffsetYellowX : Single;
                     OffsetYellowY : Single;
                     OffsetBlackX : Single;
                     OffsetBlackY : Single;
                     OffsetSpotX : Single;
                     OffsetSpotY : Single;
                     NupOnplate  : Integer;
                     ISdouble : Integer;
                     ISDoublefronttoback : Integer;
                     Numberofblanks : Integer;
                     proofdeviceintemplate : boolean;
                     ProofdeviceID : Integer;
                     Nmarkgroups : Integer;
                     markgroups  : marksarray;
                     CollectMode : Boolean;
                     CollectOverUnder : Boolean;
                     Splitmode : Integer;
                     Plateorientation : Integer;
                   end;
  TPlatetemplateArray = array[1..MAXTEMPLATES] of TPlatetemplate;
  Psmallpagedata = ^smallpagedata;
  smallpagedata = record
                    Pubdate : Tdatetime;
                  end;

  Progressdatatype = record
                       pubdate : tdatetime;
                       publicationid: Integer;
                       editionid: Integer;
                       sectionid: Integer;
                       locationid: Integer;
                       copynumber : Integer;
                     End;


  Colorstatusarray = array[1..16] of Record
                                       colorID : Integer;
                                       status : Integer;
                                       externalstatus : Integer;
                                       active  : Integer;
                                       uniquepage  : Integer;
                                       color : tcolor;
                                       version : Integer;
                                     End;

  Tshowthumb = record
                 thumbpos : trect;
                 Fileserver : string;
                 Pagename : string;
                 Planpagename : String;
                 Pageindex : Integer;
                 SpecialNoAciveEd : Integer;
                 locationstr : string;
                 Editionstr  : string;
                 MasterEdition: Integer;
                 version     : Integer;
                 pagetype    : Integer;
                 UniquePage  : Integer;
                 Publication : Integer;
                 Edition     : Integer;
                 Issue       : Integer;
                 Section     : Integer;
                 Location    : Integer;
                 Mastercopyseparationset : Integer;
                 PDFMaster : Integer;
                 Lstat       : Integer;
                 Hstat       : Integer;
                 Ncolor     : Integer;
                 Anyproof   : Integer;
                 ThumbOK      : Boolean;
                 AnyReadviewproof : Integer;
                 LProofed     : Integer;
                 RProofed     : Integer;
                 LThumbOK     : Boolean;
                 RThumbOK     : Boolean;
                 ISautoappr   : Boolean;
                 anynotapproved : boolean;
                 anyheld   : Boolean;
                 isdisapproved : boolean;
                 colorstatarray : Colorstatusarray;
                 Imageindex  : Integer;
                 Filetime : tdatetime;
                 Changed  : boolean;
                 Comment  : String;
                 pressstr  : string;
                 Pagina : Integer;
                 Npre : Integer;
                 Lock : Integer;
                 PageFormatID: Integer;
                 FileName : string;
                 Rotation : Integer;
                 PDFsent : Integer;
                 pre : Array[1..6] of record
                                        Status       : Integer;
                                        PreEvent     : Integer;
                                        PreMessage   : String;
                                        PreEventTime : tdatetime;
                                        rect         : Trect;
                                      End;
               End;
(*
  PTTreeViewArktype = ^TTreeViewArktype;
  TTreeViewArktype = record
                         Nodelevel : Integer; //0=all,1=pubdate,2=publication
                         Itemnumber : Integer;
                         publicationid : Integer;
                         pubdate       : Tdatetime;
                       end;
  *)
  PTTreeViewpagestype = ^TTreeViewpagestype;
  TTreeViewpagestype = record      //0=all,1=location,2=publication,pubdate,3=issue,4=edition,5=section
                         Nodecaption : String;
                         Nodelevel : Integer;
                         Itemnumber : Integer;
                         EditionOrder : Integer;
                         platetreepressid  : Integer;
                         Kind          : Integer;
                         locationid    : Integer;
                         publicationid : Integer;
                         issueid       : Integer;
                         editionid     : Integer;
                         sectionid     : Integer;
                         pubdate       : Tdatetime;
                         pressrunid    : Integer;
                         productionid  : Integer;
                         Weeknumber    : Integer;
                         Stateindex    : Integer;
                         statesum      : Integer;
                         timedfrom     : Integer;
                         timedTo       : Integer;
                         timedState    : Integer;
                         Newstate : Integer;
                         Anyonhold : Boolean;
                         PublItreeX : Integer;    //Viser publickation fra sektion
                         EdItreeX : Integer;    //Viser edition fra sektion
                         PagesReady : Boolean;
                         PagesIllegal : Boolean;
                       end;

  THSdatatype = record
                  foundinlist       : boolean;
                  changed           : boolean;
                  Selected          : Boolean;
                  productionID      : Integer;
                  Pressrunid        : Integer;
                  IssueID           : Integer;
                  publicationID     : Integer;
                  SectionID         : Integer;
                  EditionID         : Integer;
                  locationID        : Integer;
                  ColorID           : Integer;
                  TemplateID        : Integer;
                  DeviceID          : Integer;
                  DeviceGRPid       : Integer;
                  Copynumber        : Integer;
                  Hold              : Integer;
                  approved          : Integer;
                  status            : Integer;
                  active            : Integer;
                  Unique            : Integer;
                  Sheet             : Integer;
                  externalstatus    : Integer;
                  proofid           : Integer;
                  Hardproofid           : Integer;
                  Flatproofid           : Integer;
                  InkStaus          : Integer;
                  CustomerID        : Integer;
                  PDFMaster         : Integer;
                  MasterCopySeparationSet : Integer;
                  CopySeparationSet : Integer;
                  SeparationSet : Integer;
                  FlatSeparationSet : Integer;
                  CopyFlatSeparationSet : Integer;
                  Separation : Int64;
                  FlatSeparation : Int64;
                end;

  Tshowplate = record
                  thumbpos : Trect;
                  Anyimaging            : Boolean;
                  prevready             : Integer; //-1 no folder 0 not ready 1 inkready 2 ink+prev
                  Softprevready         : Boolean;
                  InkError              : Boolean;
                  Imageindex            : Integer;
                  Changed               : Boolean;
                  Front                 : Integer;
                  TrueFront             : Integer;
                  sheetnumber           : Integer;
                  CopyFlatSeparationSet : Integer;
                  MasterCopyFlatSeparationSet : Integer;
                  productionID          : Integer;
                  IssueID               : Integer;
                  publicationID         : Integer;
                  EditionID             : Integer;
                  locationID            : Integer;
                  Templatelistid        : Integer;
                  Fullflatlistid        : Integer;
                  Flattproofid          : Integer;
                  pressid               : Integer;
                  runid                 : Integer;
                  produce               : Boolean;
                  readytoproduce        : Boolean;
                  someerror             : Boolean;
                  Totappr               : Integer;
                  Totstat               : Integer; //alle kopier
                  TotOKImaged           : boolean;
                  NUniquepages          : Integer;
                  Presssectionnumber    : Integer;
                  Nmarkgroups           : Integer;
                  markgroups            : marksarray;
                  Miscstring1           : string[16];
                  Miscstring3           : string[16];
                  Altsheet              : String;
                  Zone                  : String[16];
                  MinOutputVersion      : Integer;
                  Ncopies               : Integer;
                  Copies                : Array[1..16] of record
                    Tower                 : string[16];
                    LowHigh               : string[16];
                    SortingPosition       : string[64];
                    deviceid              : Integer;
                    FlatSeparationSet     : Integer;
                    Ncolors               : Integer;
                    colorstatus           : Array[1..16] of record
                                                              Active  : Integer;
                                                              colorid : Integer;
                                                              Inkstatus : Integer;
                                                              status  : Integer;
                                                              externalstatus : Integer;
                                                              Bendingprik : integer;
                                                              Sortedprik  : integer;
                                                              Flatpagestatus : Integer;
                                                              Hold    : Integer;
                                                              OutputVersion : Integer;
                                                            End;
                  End;
                  Npages : Integer;
                  Pages : array[1..32] of record
                      Fileserver        : string;
                      totapproval       : Integer;
                      position          : trect;
                      Nocolorisactive   : Boolean;
                      Anyheld           : boolean;
                      Anyreleased       : Boolean;
                      UniquePage        : Integer;
                      Antipanorama      : Integer; //pairpos
                      //halfweb           : Integer;  //lookup pagetype 0 norm 1 pano 2 anti 3 dummy
                      pagetype          : Integer; //set pagetype 0 norm 1 pano 2 anti 3 dummy
                      Creep             : double;
                      SectionID         : Integer;
                      pagename          : String[50];
                      Altpagename       : String[50];
                      MasterCopySeparationSet : Integer;
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
                      pagechange        : Boolean;
                      proofid           : Integer;
                      OrgPageiplf       : Integer;
                      OrgPageipl        : Integer;
                      OrgPageip         : Integer;
                      Oldrunid          : Integer;
                      miscstring        : String;
                      // ## NAN 20150206
                      PageRotationOverrule : Integer;
                      PhonyPanorama : Integer;
                      colors : array[1..16] of record
                                                 Separation        : Int64;
                                                 FlatSeparation    : Int64;
                                                 colorid           : Integer;
                                                 copynumber        : Integer;
                                                 Uniquepage        : Integer;
                                                 active            : Integer;
                                                 status            : Integer;
                                                 externalstatus    : Integer;
                                                 Proofstatus       : Integer;
                                                 Approved          : Integer;
                                                 priority          : Integer;
                                                 Hold              : Integer;
                                                 version           : Integer;
                                                 stackpos          : string[4];
                                                 High              : string[4];
                                                 Cylinder          : string[4];
                                                 Zone              : string[4];
                                               end;
                 End;
               end;
  Tshowplates = Array of Tshowplate;
  TshowplateRec = record
                     Front                 : Integer;
                     sheetnumber           : Integer;
                     FlatSeparationSet     : Integer;
                     CopyFlatSeparationSet : Integer;
                     Nmarkgroups           : Integer;
                     markgroups            : marksarray;
                     productionID          : Integer;
                     IssueID               : Integer;
                     publicationID         : Integer;
                     Copynumber            : Integer;
                     EditionID             : Integer;
                     locationID            : Integer;
                     templatelistid        : Integer;
                     deviceid              : Integer;
                     pressid               : Integer;
                     runid                 : Integer;
                     produce               : Boolean;
                     readytoproduce        : Boolean;
                     someerror             : Boolean;
                     Creep                 : double;
                     totappr               : Integer;
                     totstat               : Integer;
                     totBendingprik        : Integer;
                     totSortedprik         : Integer;
                     Comparesets           : string;
                     NUniquepages          : Integer;
                     pages                 : Array[1..64] of record
                                                               registered   : boolean;
                                                               activepage   : Integer;
                                                               UniquePage   : Integer;
                                                               pagetype     : INteger;
                                                               pagename     : string;
                                                               sectionID    : Integer;
                                                               OrgEditionID : Integer;
                                                               Mastercopyseparationset : Integer;
                                                               Pagestatus   : Integer;
                                                               Pageapproval : Integer;

                                                             end;
                     NPlates               : Integer;
                     Nactiveplates         : Integer;
                     Plates                : Array[1..20] of record
                                                               active         : Integer;
                                                               ColorID        : Integer;
                                                               readytoproduce : boolean;
                                                               status         : Integer;
                                                               TowerHighCylinderZone : String;
                                                             end;
                 End;

  TMultiruns = array[1..20] of record
                                 FrameMultirun : TFrameMultirun;
                                 Nshowplates : Integer;
                                 showplates  : Array[0..255] of ^Tshowplate;
                               end;

  Type Tinittypes = class
    private
    protected
    public
      Function DeviceGroupnametoID(name : String):Integer;
      Function DeviceGroupIDtoName(ID : Longint):String;
      Function InitDeviceGroupNames:Boolean;
      Function GetLocalserverid(servername : string):Integer;
      Function DeleteFolderandsubs(Folder : String): Boolean;
      Function geteventcolorfromnumber(eventnumber : Longint):Tcolor;
      Function getapprovecolorfromname(name : string):Tcolor;
      procedure getdeviceIDSfromtemplate(templatenumber : Integer);
      function HexToInt(s: string): Longword;
      Procedure loadstatusvalues;
      Procedure loadmarks;
      Function gettemplatenumberfromID(templateID : Integer):Integer;
      Procedure Typesloadtemplatearray2;
     // Procedure loadpresses;
//      Procedure InitListViewplateview1dataArray;
      Procedure loadcolornames;
      Procedure initthetypes;
      Function calccolor(C,M,Y,K : single):tcolor;
      Function gettemplatelistnumberfromname(name : string):Integer;
      Function gettemplatelistnumberfromdbID(dbtemplateid : Longint):Integer;
      Function getTcolorfromname(name : string):Tcolor;
      Function getTcolorfromID(ID : Integer):Tcolor;
      Function getcolorImagefromname(name : string):Integer;
      Function getcolorIDfromname(name : String):integer;
      Function Isablackcolor(ID : Integer):Boolean;
      Function getcolornamefromID(ID : Integer):string;
      Function ISblack(colorname : string):boolean;
    //  Function getdeviceidfromname(name : string):Integer;
      procedure getdevicelistfromtemplate(templatenumber : Integer);
      procedure makehslist2;
      procedure makehslist3;
      procedure getdeviceGrplistfromtemplate(templatenumber : Integer);
      Function inarraystr(arstring : string;
                          findstr : string):Integer;
      procedure getdevicelistfromtemplateNogrp(templatenumber : Integer);
      Function marksIDstr(ANmarks : Integer;
                          Amarks : marksarray):string;
      Function marksnamestr(ANmarks : Integer;
                            Amarks : marksarray):string;
      Procedure markstrtoarray(Astr : String;
                               Var Amarks : marksarray;
                               Var ANmarks : Integer);
      Procedure marknamestrtoarray(Astr : String;
                                   Var Amarks : marksarray;
                                   Var ANmarks : Integer);
      function markIDtoname(markid : Integer):string;
      function marknametoid(markname : string):Integer;
      Function getstatuscolorfromname(name : string):Tcolor;
      Function getstatuscodefromname(name : string):Integer;
      Procedure PPOSstrtoarray(Astr : String;
                               Var APPOS : pparray;
                               Var ANPPOS : Integer);
      Function POSinPosarray(Apos : Integer;
                             APPOS : pparray;
                             ANPPOS : Integer):Boolean;
      function GeneratePreviewGUID(nPublicationID : Integer; tPubDate : TDateTime): String;

  end;
  colordtype = array[0..100] of Integer;

  Tpressrunidtabletype = record
                          PressRunID: Integer;
                          SequenceNumber: Integer;
                          Deadline1 : Tdatetime;
                          Deadline2 : Tdatetime;
                          Deadline3 : Tdatetime;
                          Deadline4 : Tdatetime;
                          PriorityBeforeHottime : Integer;
                          PriorityDuringHottime : Integer;
                          PriorityAfterHottime : Integer;
                          PriorityHottimeBegin : Tdatetime;
                          PriorityHottimeEnd : Tdatetime;
                          Comment : String;
                          UsePressTowerInfo : Integer;
                          OrderNumber : String;
                          InkComment : String;
                          Backwards : Integer;
                          PerfectBound : Integer;
                          Inserted : Integer;
                          PlanName : String;
                          PressSystem : String;
                          PlanType : Integer;
                          TimedEditionFrom : Integer;
                          TimedEditionTo : Integer;
                          TimedEditionState : Integer;
                          FromZone : Integer;
                          ToZone : Integer;
                          Circulation : Integer;
                          Circulation2 : Integer;
                          Comment2 : String;
                          MiscInt1 : Integer;
                          MiscInt2 : Integer;
                          MiscString1 : String;
                          MiscString2 : String;
                          MiscString3 : String;
                          MiscDate : Tdatetime;
                          PlanVersion : Integer;
                          PlanSystem : String;
                         end;
  TPagetabeltype = record
                    altpagename : String;
                    altsheetname : String;
                    MasterCopyFlatSeparationSet : Integer;
                    CopySeparationSet : Integer;
                    SeparationSet : Integer;
                    Separation : Int64	;
                    CopyFlatSeparationSet : Integer;
                    FlatSeparationSet : Integer;
                    FlatSeparation : Int64	;
                    Status : Integer;
                    ExternalStatus : Integer;
                    PublicationID : Integer;
                    SectionID : Integer;
                    EditionID : Integer;
                    IssueID : Integer;
                    PubDate :Tdatetime;
                    PageName  : string;
                    ColorID : Integer;
                    TemplateID : Integer;
                    ProofID : Integer;
                    DeviceID  : Integer;
                    Version : Integer;
                    Layer : Integer;
                    CopyNumber : Integer;
                    Pagination  : Integer;
                    Approved : Integer;
                    Hold : Integer;
                    Active : Integer;
                    Priority  : Integer;
                    PagePosition  : Integer;
                    PageType : Integer;
                    PagesOnPlate : Integer;
                    SheetNumber : Integer;
                    SheetSide : Integer;
                    PressID : Integer;
                    PressSectionNumber  : Integer;
                    SortingPosition  : string;
                    PressTower  : string;
                    PressCylinder  : string;
                    PressZone  : string;
                    PressHighLow  : string;
                    ProductionID : Integer;
                    PressRunID : Integer;
                    ProofStatus  : Integer;
                    InkStatus  : Integer;
                    PlanPageName  : string;
                    IssueSequenceNumber  : Integer;
                    MasterCopySeparationSet : Integer;
                    UniquePage : Integer;
                    LocationID : Integer;
                    FlatProofConfigurationID  : Integer;
                    FlatProofStatus  : Integer;
                    Creep : real;
                    MarkGroups  : string;
                    PageIndex  : Integer;
                    GutterImage  : Integer;
                    Outputversion  : Integer;
                    HardProofConfigurationID  : Integer;
                    HardProofStatus  : Integer;
                    FileServer  : string;
                    Dirty  : Integer;
                    InputTime :Tdatetime;
                    ApproveTime :Tdatetime;
                    ReadyTime :Tdatetime;
                    OutputTime :Tdatetime;
                    VerifyTime :Tdatetime;
                    ApproveUser  : string;
                    FileName : string;
                    LastError : string;
                    Comment  : string;
                    DeadLine :Tdatetime;
                    InputID  : Integer;
                    PagePositions  : string;
                    InputProcessID  : Integer;
                    SoftProofProcessID  : Integer;
                    HardProofProcessID  : Integer;
                    TransmitProcessID  : Integer;
                    ImagingProcessID  : Integer;
                    InkProcessID  : Integer;
                    OutputPriority  : Integer;
                    PressTime :Tdatetime;
                    CustomerID  : Integer;
                    EmailStatus  : Integer;
                    Miscint1 : Integer;
                    Miscint2  : Integer;
                    Miscint3  : Integer;
                    Miscint4  : Integer;
                    Miscstring1  : string;
                    Miscstring2  : string;
                    Miscstring3  : string;
                    Miscdate :Tdatetime;
                    PdfMaster : Integer;
                    FlatMaster : Integer;
                    PageFormatID : Integer;
                    RipSetupID : Integer;
                    FanoutID : Integer;
                    PageCategoryID : Integer;
                    DeviceGroupID  : Integer;
                    PlateStatus  : Integer;
                    PostOutputVersion  : Integer;
                  End;
  Procedure writeMainlogfile(logline : String);
Var

  //Nstatusframes : Integer;
  //statusframes : Array of Tstatusframetype;
  PlateviewtmpImage,Plateviewtmpplim: TBitmap;
  Plateviewci,Plateviewsi,Plateviewsibar : tbitmap;
  //Pressgrpname : Tstringlist;
  //PressgrpID   : Tstringlist;
  //Pressgrppress   : Tstringlist;
  debugautorefreshing : Boolean;
  NAllShowplates : Integer;
  pagetableloadstatus : Boolean;
  AllShowplates : Array[1..2] of record
                                      Aktshowplate : Tshowplate;
                                    End;
  Prev2Width,Prev2Height,Prev2xpos,Prev2ypos,Prev2Winstate : Integer;
  Globalsystemtype : Integer; //se globalvars
  globaldbvars : String;
 (* Plancenterflags : Array[1..5] of record
                                     View : Integer;
                                     Selection : Integer;
                                     ActionType : Integer;
                                     oncap : String;
                                     ofcap : String;
                                     Visible : Boolean;
                                     Status : Integer;
                                     Aaction : Integer;
                                   end;
  *)
  //staok : Boolean;
  nopresssesectedinsettings : Boolean;
  usenewpagina : Boolean;
  MainUpdateing : Boolean;
  TreeStopit  : Boolean;
  InkReportPlateQueuePossible : Boolean;
  Newtreeprodid : Integer;
  treeIdle : Boolean;
  Usesnewtreetable : Boolean;
  NnewtreetableCash : Integer;
  LastnewtreetableCash : Tdatetime;
  newtreetableCash : Array of TreestateDataType;
  Nplateframes : Integer;
  NplateframesDummy : Integer;
  NyFileInfoOK : Boolean;
  NyFileInfosize : Integer;
 // NThreadnewtreetableCash : Integer;
  //ThreadLastnewtreetableCash : Tdatetime;
  //ThreadnewtreetableCash : Array of TreestateDataType;
  Global_SelectedProductionID : Integer;
  Comment2INPressrunid : Boolean;
  Planloggingtype : Integer; // 990 booked jeg bruger den ikke
                             // 991 applied eller planned
                             // 992 changed
  Planloggingmessage : String;
  Planloggingseparation : int64;
  //cheatnumbers : Boolean;      // Replaced by Prefs.IgnoreImposeCalcNumbering
  keeptreesLoading,platedatasystem : boolean;
  Nkeeptrees : Integer;
  Keeptreeselection : Record
                        Anyselect : Boolean;
                        Selectionlevel : Integer;
                        Pubdate : Tdatetime;
                        Publicationid : Integer;
                        Editionid : Integer;
                        Sectionid : Integer;
                        pressrunid : Integer;
                        pressid   : Integer;
                      end;
  keeptrees : Array[1..100] of record
                                Locationname : String;     // kan v�re *
                                Ntree : Integer;
                                tree : array of record
                                                  Level : Integer;
                                                  Expanded : Boolean;
                                                  Selected : Boolean;
                                                  Pubdate : Tdatetime;
                                                  Publicationid : Integer;
                                                  Editionid : Integer;
                                                  Sectionid : Integer;
                                                  pressrunid : Integer;
                                                  pressid   : Integer;
                                                end;
                              End;
  CurrentLocationid : Integer;
  Currentlocationname : String;
  giveproductionwarning : Boolean;
  statuswarningstr,extstatuswarningstr : String;
  PBExListviewplateinfoflatsepsubitem : Integer;
  ChangetoMultilocationserver : Integer;
  ChangetoMultilocationlocation : String;
  LookForProducerrorTimeBlink,LookForProducerrorTime : Tdatetime;
  LookForProducerrorID : Integer;
  LookForProducerrorNow : boolean;
  Multilocationslist : Tstringlist;
  smallpressrunidtable : Boolean;
  AkttiveMultiserver : Integer;
  prepollpagetable_hasdirty : Boolean;
  (*NumberMultiserverlocations : Integer;
  Multiserverlocations : Array[1..MAXLOCATIONS] of record
                                            SQLServername : String;
                                            DSN    : String;
                                            DBname : String;
                                            DBusername : String;
                                            DBpassword : String;
                                            Nlocations : Integer;
                                            Locations : Array[1..MAXLOCATIONS] of record
                                                                           locationid : Integer;
                                                                           name : string ;
                                                                         End;
                                          end;
                                                *)
  PlateSelecttionstyle : TPlateSelecttionstyle;
  Therearenoplates : Boolean;
  CCMesagePossible : Boolean;
  RipSetupIDInPageTable : Boolean;
  PublicationEditionSectionAliasSetupPossible,ImportCenterPreImportCustomPossible,ImportCenterPressRunCustom2Possible,
  ImportCenterProductionCustomPossible3,spPlancenterInputeditorialsep4Possible,spTransmitUpdateStatusPDFPossible : Boolean;
  FlatPageTablePossible,PressGroupNamesPossible,UserPressesPossible,UserPressGroupsPossible : boolean;
  spPlancenterImportCenterAddSeparation3PageCategoryParamPossible, spPlancenterInputeditorialsep3Possible ,spPlanCenterLoadMultiplePressTemplatesPossible: Boolean;
  spPlanCenterLoadMultiplePressTemplatesPressTemplateID5ParamPossible : boolean;
  DeviceGroupNamesPossible  : boolean;
  GeneralPreferencesExtraPossible : boolean;
  GeneralPreferencesExtraPossible_TiffPlateArchiveFolder : Boolean;
  GeneralPreferencesExtraPossible_ReportFolder : Boolean;
  PressRunOutputMethodTablePossible : boolean;
  OutputMethodNamesTablePossible : Boolean;
  spGetAllUnplannedPagesPossible : Boolean;
  Global_spImportCenterRetryMissingPagesPossible : Boolean;
  Global_spImportCenterPageOutOfRangeCheckPossible : Boolean;
  PreflightSetupNamesPossible, InkSaveSetupNamesPossible, AutoRetryQueueFileCenterPossible : boolean;
  IsDefaultPressTemplateNamesPossible : Boolean;
  PressTemplatePageRotationPossible : Boolean;
  spPlanCenterCopyPressSettingsPossible : Boolean;
  spPlanCenterSavePressSettingsPossible : Boolean;
  spPlanCenterConsecutivePaginationPossible : Boolean;
  spPlanCenterGeneratePlanPageNamesPossible : Boolean;
  Pressdevpossible : Boolean;
  StackerNamesPossible : Boolean;
  AdmGroupPublicationsPossible : Boolean;
  AdmGroupUserGroupRelationsPossible : Boolean;
  PressRunIDPlanVersionPossible : boolean;
  BackupApplicationConfigFilesPossible : boolean;
  PageTableFieldCount : Integer;
  NDeviceGroupNames : Integer;
  DeviceGroupNames  : array[1..50] of record
                                         name : String;
                                         ID   : Integer;
                                         NDevices : Integer;
                                         Devices : Array[1..50] of Integer;
                                       End;
  spAddLogEntrySetsVersion : Integer;
  Presstemplatedbversion : Integer;  //1 har kun til og med Backwards   2 g�r helt til ColorControlID
  PublicationTemplatesPossible : Boolean;
  Releaseproductionids : TStrings;
  ReleasePressrunids   : TStrings;
  ReleasePlates       : TStrings;
  Newprodcheckcount : Integer;
  advancedstatavail : boolean;  // om det er muligt at kalde spplancenterInputStatistic4 bruges bla. til nielses GenerateReport ved del
  NpdfFolders : Integer;
  pdfFolders  : Array[1..MAXPDFFOLDERS] of record
                                  Locationid  : Integer;
                                  PDFShare : string;
                                  username : String;
                                  password : string;
                                End;
  NInkFolders : Integer;
  InkFolders : Array[1..MAXINKFOLDERS] of record
                                  Locationid  : Integer;
                                  InkShare : string;
                                  username : String;
                                  password : string;
                                End;
  PrepollEvents : Array[1..12] of record
                                    Number : Integer;
                                    name : string;
                                 end;
  NLocalServerIds : Integer;
  LocalServerIds : Array[1..32] of string;
  TiffArchiveFolder : String;
  TimedEdPossible : Boolean;
  Minautorefresh : Integer;
  Mintreerefresh : Integer;
  Mindevicefresh : Integer;
  Allpagetablestr,P1Allpagetablestr : String;
  Dummystr1,Dummystr2,Dummystr3,Dummystr4,Dummystr5,Dummystr6 : String;
  Plotinfofilname     : Pchar;
  MrgFileNameLeft     : pchar;
  MrgFileNameRight    : pchar;
  MrgOutputFileName   : pchar;
  MrgPageTypeLeft      : Integer;
  MrgPageTypeRight     : Integer;
  MrgPagePositionLeft  : Integer;
  MrgPagePositionRight : Integer;
  MrgSheetSide         : Integer;
  MrgProofID           : Integer;
  MrgTemplateID        : Integer;

  MAXColsortcount : Integer;
  //PDFCOLORID : Integer;
  Themebrgdark : Tcolor;
  ThemebrgLight : Tcolor;
  Themebardark : Tcolor;
  ThemeBarLight : Tcolor;
  SetplannameINpressrunID : Boolean;
  WP1editionStr : string;
  WP2editionStr : string;
  WeditionStr : string;
  Wtowerstr, WP1towerstr: String;
  WP1publicationStr : string;
  WP2publicationStr : string;
  WpublicationStr : string;
  WlocationLimitstr : String;
  NMultiruns : Integer;
  Multiruns : TMultiruns;
  NSPcustomNum : Integer; //0= none, 1 spCustomRelease, 2  spCustomRetransmit
  NSPCustomparamslist :Integer;
  SPCustomparamslist : Array[1..10]  of String;

  Nselectedmasters : Integer;
  selectedmasters : Array[1..256] of Integer;
  marksnamestrarray : Array[1..400] of string;
  cobomtexts : array[0..100] of string;
  colposses : array[0..100] of record
                                 x1 : Integer;
                                 x2 : integer;
                               end;
  NComparecols : Integer;
  comparecols : array[0..20] of record
                                  col : integer;
                                  sorttype : Integer;
                                End;
 // Runordercalc : Array[1..1000] of integer;
  PDFMasterOK,Pageformatinpagetable,Global_HasPageCategoryField,Global_spReImage : Boolean;
  Global_HasPlateStatusField : Boolean;
  platepresel : array of Integer;
  Nthumbprepos : Integer;
  thumbprepos  : Array[0..3] of Trect;
  XYZ999 : Integer;
  Showthubms : Array[0..MAXTHUMBNAILS] of Tshowthumb;
  TrimOdd,Trimeven : Integer;
  NMarks : Integer;
  Marks : array[1..521] of record
                              markid : Integer;
                              template : Integer;
                              markname : string;
                            end;
//  XYZ998 : Integer;
  //DLL INTERFACE
  AktPRODUCTION : TPRODUCTIONDEF;
  Nplanpagesections : integer;
  XMLPublicationID,XMLPressID : Integer;
  StartuPdone : Boolean;
  XMLPubdate : Tdatetime;
  XMLPlateCopies : Integer;
  XMLRipSetup : string;
  XMLPreflightSetup : string;
  XMLInkSaveSetup : string;
  XMLSpecificDevice : string;
                           //iplf
  planpagenames : array[1..MAXSECTIONS] of record
                                     collection   : Integer;
                                     prepaired    : boolean;
                                     bindingstyle : Boolean;
                                     Numberofcopies : Integer;
                                     newedition   : boolean;
                                     sectionnode  : ttreenode;
                                     Edition      : Integer;
                                     editionid    : Integer;
                                     Npages       : Integer;
                                     hw1,hw2      : Integer;
                                     Nhalfwebpage : Integer;
                                     pages : array[0..MAXPAGESINSECTION] of record
                                                                name      : string; //pagename
                                                                Orgeditionid : Integer;
                                                                pageindex : Integer;
                                                                pagina    : Integer;
                                                                seci      : Integer;
                                                                Sectionid : Integer;
                                                                pagenode  : ttreenode;
                                                                PressSecionNumber : Integer;
                                                                PaginaIndex : Integer;
                                                                PageID : Integer;
                                                                OrgpageID : Integer;
                                                                PageRotation : Integer;
                                                                RipSetupID : Integer;
                                                                // Ncopies      : Integer;
                                                                Copies : array[1..32] of record
                                                                                           ipl : Integer;
                                                                                           ip  : Integer;
                                                                                         end;
                                                                //gridrow   : Integer;
                                                              End;
                                   end;
  //DLL INTERFACE
  Aktdevicelist,Aktdevicegrplist : TStringList;
  Aktdeviceliststring : String;
  Naktdeviceidlist : Integer;
  aktdeviceidliststring : String;
  aktdeviceidlist : array[1..200] of integer;
  Orgpdffilepossible : Boolean;
  Orgpdffilepath : string;
//$00096000
  NaktdeviceGRPidlist : Integer;
  aktdeviceGRPidliststring : String;
  aktdeviceGRPidlist : array[1..200] of integer;
  PDFarchivepath : String;
  PDFUnknownpath : String;
    //0 Integer 1 string 2 Yesno 3 date > transid
  // transid 4 color 5 template 6 device 7 press 8 status 9 approve  10 proofid  11 frontback
  Colorder : colordtype;
  coltotext : colordtype;
  saveColorder : colordtype;
  prevcolorder : colordtype;
  HSOrder : array[0..200] of integer;
  NaktHScols : Integer;
  aktHScols : array[0..200] of integer;
  aktsubitemkinds : array[0..100] of integer;
  aktitemkind : integer;
  Nprosenttypes : Integer;
  prosenttypes : Array[1..100] of record
                                    prosst : String;
                                    foundpos : Integer;
                                    dblevel  : Integer;
                                  end;

  HSCols : array[0..200] of record
                              name : string;
                              field : string;
                              Kind  : Integer; //0 Integer 1 string 2 Yesno 3 date 4 tid 5 status 6 device 7 template 20 external status
                              ColX   : Integer;
                              width : Integer;
                              tag   : Integer;
                              Show  : Boolean;
                              iscaption : boolean;
                              Inorder : Boolean;
                              fieldpos : Integer;
                              Inlist : boolean;
                              Mandatory : Boolean;
                            End;
  NdatalistCols : Integer;
  datalistCols : array[0..200] of record
                                    name : string;
                                    field : string;
                                    Kind  : Integer; //0 Integer 1 string 2 Yesno 3 date > transid
                                    Col   : Integer;
                                    width : Integer;
                                    tag   : Integer;
                                    Show  : Boolean;
                                    iscaption : boolean;
                                    // transid 4 colorid 5 templateid 6 deviceid 7 pressid  8 prodcutionid 9 publid 10 editionid 11 issueid 12 sectionid
                                  End;
  publdeadpossible : Boolean;
  statustoIMnumber : array[0..100] of integer;
  IMtostatusnumber : array[0..100] of integer;
  inittypes : Tinittypes;
  NPlatetemplateArray : Integer;
  PlatetemplateArray : TPlatetemplateArray;
 // Ndeletethese : Integer;
  //processids : array[0..1000] of string;
 // deletethese : array[1..1000] of integer;
 // deviceIds : array[0..200] of Integer;
  //devicenames : array[0..500] of string;
  //proofnames : array[0..200] of string;
 // pressnames : array[0..200] of string;
  apprnamearray : Array[0..10] of string;
  Yesnoarray    : Array[0..30] of string;
  Proofarray    : Array[0..30] of string;
  pagetypesarray : array[0..10] of string;// 0 norm 1 pano 2 anti 3 dummy
  Holdrealesarray : Array[0..10] of string;
  Inkstatusarray  : Array[0..20] of string;
  Uniquearray : Array[0..10] of string;
  Nstatusarray : Integer;
  statusarray : Tstatusarray;
  NPagetabeldb : Integer;
  Pagetabeldb : Array of TPagetabeltype;
  NPossiblepressrunid : Integer;
  Possiblepressrunid : Array[1..500] of Integer;
  treeShortcuts : array[0..9] of record
                                   key : Word;
                                   location    : string;
                                   press       : String;
                                   pubdate     : string;
                                   publication : String;
                                   Edition     : String;
                                   Section     : String;
                                 End;
  NExternalstatusarray : Integer;
  Externalstatusarray : Tstatusarray;
  ExternalstatusarrayEx : Tstatusarrayex;
  Impospw : Integer;
  Imposph : Integer;
  Imposmw : Integer;
  Imposmh : Integer;
  Pressvisibilylimited : Boolean;
  PressvisibilyIN      : String;
  NShowthubms : Integer;
  //OLD
  //NListViewplateview1dataArray : integer;
  //ListViewplateview1dataArray : TListViewplateview1dataArray;

  Ndrawdataarray : Integer;
  NPresses : Integer;
(*  Presses : Array[1..MAXPRESSES] of record
                               PressID : Integer;
                               PressName : String;
                               LocationID : Integer;
                               UseBroadsheet : Integer;
                               BroadsheetWidth : Single;
                               BroadsheetHeight : Single;
                               UsePanorama : Integer;
                               PanoramaWidth : Single;
                               PanoramaHeight : Single;
                               UseAlternate : Integer;
                               AlternateWidth : Single;
                               AlternateHeight : Single;
                               InkZonesBroadsheet : Integer;
                               InkZoneWidth : Single;
                               InkZoneOffset : Single;
                               InkIgnoreTopEdge : Single;
                               InkIgnoreBottomEdge : Single;
                               InkIgonreLeftEdge : Single;
                               InkIgnoreRightEdge : Single;
                             end;
  *)
  Colorsnames : array of record
                                         name : string;
                                         C : Integer;
                                         M : Integer;
                                         Y : Integer;
                                         K : Integer;
                                         colorindex : Integer;
                                         Colorlook : Tcolor;
                                         colorimage : Integer;
                                         valid : boolean;
                                         colororder : Integer;
                                       end;
implementation
Uses
  forms,usettings,
  umain;

Function Tinittypes.GetLocalserverid(servername : string):Integer;
Var
  I : Integer;
Begin
  result := 0;
  IF NLocalServerIds > 0 then
  Begin
    for i := 1 to NLocalServerIds do
    begin
      IF uppercase(servername) = LocalServerIds[i] then
      begin
        result := i;
        break;
      end;
    End;
  end;
End;
Function Tinittypes.DeleteFolderandsubs(Folder : String): Boolean;
var
 Ok: Integer;
 F: TSearchRec;
begin
   ExcludeTrailingBackslash(folder);
   Ok := FindFirst(Folder+'\*.*',faAnyFile,F);
   Result := True;
   while (Ok = 0) and (Result) do
   begin
     if (F.Name <> '.') and (F.Name <> '..') then
     begin
       if F.Attr <> faDirectory then
         Result := DeleteFile(Folder + '\' + F.Name)
       else
         begin
           Result := DeleteFolderandsubs(Folder + '\' + F.Name);
         end;
     end;
     Ok := FindNext(F);
   end;
   FindClose(F);
end;

Function Tinittypes.getapprovecolorfromname(name : string):Tcolor;
Var
  I : Integer;
begin
  result := clwhite;
  for I := 0 to 10 do
  begin
    IF name = apprnamearray[i] then
    begin
      Case i of
        0 : result := clwhite; //No Approval
        1 : result := clYellow; //not approved
        2 : result := cllime; //Approved
        3 : result := clred; //Disapproved
        else
          result := clwhite;
      end;
      break;
    end;
  end;
end;

Function Tinittypes.geteventcolorfromnumber(eventnumber : Longint):Tcolor;
//Var
//  I : Integer;
begin
  result := clwhite;
  Case eventnumber of
    0 : result := clwhite;
    6 : result := statusarray[6].color;
    10 : result := statusarray[10].color;
    16 : result := statusarray[16].color;
    20 : result := statusarray[20].color;
    26 : result := statusarray[26].color;
    30 : result := statusarray[30].color;
    46 : result := statusarray[46].color;
    50 : result := statusarray[50].color;
    56 : result := statusarray[56].color;
    60 : result := statusarray[60].color;
    70 : result := cllime;
    71 : result := clred;
    80 : result := cllime;
    81 : result := RGB(255,157,157);
    90 : result := cllime;
    96 : result := clred;
    99 : result := clsilver;
    100 : result := cllime;
    106 : result := clred;
    110 : result := cllime;
    116 : result := clred;
    117 : result := clyellow;
    120 : result := cllime;
    126 : result := clred;
    127 : result := clyellow;
    130 : result := cllime;
    136 : result := clred;
    137 : result := clyellow;
    600 : result := RGB(255,128,0);
    else
      result := clwhite;
  End;
end;

Function Tinittypes.getstatuscolorfromname(name : string):Tcolor;
Var
  I : Integer;
Begin
  result := clwhite;
  For i := 0 to 100 do
  begin
    IF uppercase(name) = uppercase(statusarray[i].name) then
    begin
      result := statusarray[i].color;
      break;
    end;
  end;
end;
Function Tinittypes.getstatuscodefromname(name : string):Integer;
Var
  I : Integer;
Begin
  result := 0;
  For i := 0 to 100 do
  begin
    IF uppercase(name) = uppercase(statusarray[i].name) then
    begin
      result := i;
      break;
    end;
  end;
end;

Function Tinittypes.getTcolorfromname(name : string):Tcolor;
Var
  I : Integer;
Begin
  result := clwhite;
  For i := 1 to Length(Colorsnames) do
  begin
    IF uppercase(name) = uppercase(Colorsnames[i].name) then
    begin
      result := Colorsnames[i].colorlook;
      break;
    end;
  end;
end;

Function Tinittypes.getcolorImagefromname(name : string):Integer;
Var
  I : Integer;
Begin
  result := 0;
  For i := 1 to Length(Colorsnames) do
  begin
    IF uppercase(name) = uppercase(Colorsnames[i].name) then
    begin
      result := Colorsnames[i].colorimage;
      break;
    end;
  end;
end;
Function Tinittypes.getTcolorfromID(ID : Integer):Tcolor;
Var
  I : Integer;
Begin
  result := clwhite;
  For i := 1 to Length(Colorsnames) do
  begin
    IF ID = Colorsnames[i].colorindex then
    begin
      result := Colorsnames[i].colorlook;
      break;
    end;
  end;
end;

Function Tinittypes.getcolornamefromID(ID : Integer):string;
Var
  I : Integer;
Begin
  result := Inttostr(ID);
  For i := 1 to Length(Colorsnames) do
  begin
    IF ID = Colorsnames[i].colorindex then
    begin
      result := Colorsnames[i].name;
      break;
    end;
  end;
end;

Function Tinittypes.Isablackcolor(ID : Integer):Boolean;
Var
  I : Integer;
Begin
  result := false;
  For i := 1 to Length(Colorsnames) do
  begin
    IF (ID = Colorsnames[i].colorindex) and (ID < 50) then
    begin
      result := Colorsnames[i].K = 100;
      break;
    end;
  end;
end;

Function Tinittypes.getcolorIDfromname(name : String):integer;
Var
  I : Integer;
Begin
  result := clwhite;
  For i := 0 to Length(Colorsnames) do
  begin
    IF name = Colorsnames[i].name then
    begin
      result := Colorsnames[i].colorindex;
      break;
    end;
  end;
end;

Procedure Tinittypes.initthetypes;
Var
  i : Integer;
Begin
// approval  -1 auto 0 not approved 1 approved 2 disapproved  i status 20 +
  Allpagetablestr :=
{00} 'CopySeparationSet,'+
{01} 'SeparationSet,'+
{02} 'Separation,'+
{03} 'CopyFlatSeparationSet,'+
{04} 'FlatSeparationSet,'+
{05} 'FlatSeparation,'+
{06} 'Status,'+
{07} 'ExternalStatus,'+
{08} 'PublicationID,'+
{09} 'SectionID,'+
{10} 'EditionID,'+
{11} 'IssueID,'+
{12} 'PubDate,'+
{13} 'PageName,'+
{14} 'ColorID,'+
{15} 'TemplateID,'+
{16} 'ProofID,'+
{17} 'DeviceID,'+
{18} 'Version,'+
{19} 'Layer,'+
{20} 'CopyNumber,'+
{21} 'Pagination,'+
{22} 'Approved,'+
{23} 'Hold,'+
{24} 'Active,'+
{25} 'Priority,'+
{26} 'PagePosition,'+
{27} 'PageType,'+
{28} 'PagesOnPlate,'+
{29} 'SheetNumber,'+
{30} 'SheetSide,'+
{31} 'PressID,'+
{32} 'PressSectionNumber,'+
{33} 'SortingPosition,'+
{34} 'PressTower,'+
{35} 'PressCylinder,'+
{36} 'PressZone,'+
{37} 'PressHighLow,'+
{38} 'ProductionID,'+
{39} 'PressRunID,'+
{40} 'ProofStatus,'+
{41} 'InkStatus,'+
{42} 'PlanPageName,'+
{43} 'IssueSequenceNumber,'+
{44} 'MasterCopySeparationSet,'+
{45} 'UniquePage,'+
{46} 'LocationID,'+
{47} 'FlatProofConfigurationID,'+
{48} 'FlatProofStatus,'+
{49} 'Creep,'+
{50} 'MarkGroups,'+
{51} 'PageIndex,'+
{52} 'GutterImage,'+
{53} 'Outputversion,'+
{54} 'HardProofConfigurationID,'+
{55} 'HardProofStatus,'+
{56} 'FileServer,'+
{57} 'Dirty,'+
{58} 'InputTime,'+
{59} 'ApproveTime,'+
{60} 'ReadyTime,'+
{61} 'OutputTime,'+
{62} 'VerifyTime,'+
{63} 'ApproveUser,'+
{64} 'FileName,'+
{65} 'LastError,'+
{66} 'Comment,'+
{67} 'DeadLine,'+
{68} 'InputID,'+
{69} 'PagePositions,'+
{70} 'InputProcessID,'+
{71} 'SoftProofProcessID,'+
{72} 'HardProofProcessID,'+
{73} 'TransmitProcessID,'+
{74} 'ImagingProcessID,'+
{75} 'InkProcessID,'+
{76} 'OutputPriority,'+
{77} 'PressTime,'+
{78} 'CustomerID,'+
{79} 'EmailStatus,'+
{80} 'Miscint1,'+
{81} 'Miscint2,'+
{82} 'Miscint3,'+
{83} 'Miscint4,'+
{84} 'Miscstring1,'+
{85} 'Miscstring2,'+
{86} 'Miscstring3,'+
{87} 'Miscdate';
p1Allpagetablestr := 'p1.' ;
for i := 1 to length(Allpagetablestr) do
begin
  if Allpagetablestr[i] = ',' then
  begin
    p1Allpagetablestr := p1Allpagetablestr +',p1.'
  end
  else
  begin
    p1Allpagetablestr := p1Allpagetablestr +Allpagetablestr[i];
  end;
end;
  //MAXSECTIONS := 80;

  cobomtexts[0]   := formmain.InfraLanguage1.Translate('All');
  cobomtexts[1]   := formmain.InfraLanguage1.Translate('Not missing');
  cobomtexts[2]   := formmain.InfraLanguage1.Translate('Not transmitted');
  cobomtexts[3]   := formmain.InfraLanguage1.Translate('Not Imaged');
  cobomtexts[4]   := formmain.InfraLanguage1.Translate('Any error');
  cobomtexts[5]   := formmain.InfraLanguage1.Translate('Not approved');
  cobomtexts[6]   := formmain.InfraLanguage1.Translate('Approved');
  cobomtexts[7]   := formmain.InfraLanguage1.Translate('Disapproved');
  cobomtexts[8]   := formmain.InfraLanguage1.Translate('Held');
  cobomtexts[9]   := formmain.InfraLanguage1.Translate('Released');
  cobomtexts[10]   := formmain.InfraLanguage1.Translate('Hide');
  cobomtexts[11]   := formmain.InfraLanguage1.Translate('Show');
  cobomtexts[12]   := formmain.InfraLanguage1.Translate('Page');
  cobomtexts[13]   := formmain.InfraLanguage1.Translate('Plate');
  cobomtexts[14]   := formmain.InfraLanguage1.Translate('Sheet');
  cobomtexts[15]   := formmain.InfraLanguage1.Translate('Run');
  cobomtexts[16]   := formmain.InfraLanguage1.Translate('Production');
  cobomtexts[17]   := formmain.InfraLanguage1.Translate('Tower');
  cobomtexts[18]   := formmain.InfraLanguage1.Translate('Zone');

  apprnamearray[0] := formmain.InfraLanguage1.Translate('Auto approval');
  apprnamearray[1] := formmain.InfraLanguage1.Translate('not approved');
  apprnamearray[2] := formmain.InfraLanguage1.Translate('Approved');
  apprnamearray[3] := formmain.InfraLanguage1.Translate('Disapproved');
  apprnamearray[4] := formmain.InfraLanguage1.Translate('No Approval');
  Yesnoarray[0] := formmain.InfraLanguage1.Translate('No');
  Yesnoarray[1] := formmain.InfraLanguage1.Translate('Yes');
  Yesnoarray[2] := formmain.InfraLanguage1.Translate('No');
  Yesnoarray[10] := formmain.InfraLanguage1.Translate('Yes');
  Yesnoarray[20] := formmain.InfraLanguage1.Translate('Yes');
  For i := 0 to 30 do
    Proofarray[i] := 'Not proofed';
  Proofarray[5] := 'Proofing';
  Proofarray[10] := 'Proofed';
  Proofarray[15] := 'Single proofing readview';
  Proofarray[20] := 'Single+readview';
  Holdrealesarray[0] := formmain.InfraLanguage1.Translate('Released');
  Holdrealesarray[1] := formmain.InfraLanguage1.Translate('Hold');
  pagetypesarray[0] := 'Single';
  pagetypesarray[1] := 'Center';
  pagetypesarray[2] := 'Antipano';
  pagetypesarray[3] := 'Dinky';
  Uniquearray[0] := formmain.InfraLanguage1.Translate('Common');
  Uniquearray[1] := formmain.InfraLanguage1.Translate('Unique');
  Uniquearray[2] := formmain.InfraLanguage1.Translate('Forced');

  For i := 0 to 20 do
  Begin
    Inkstatusarray[i] := '';
  End;
  Inkstatusarray[0] := '';
  Inkstatusarray[5] := 'Calculating';
  Inkstatusarray[6] := 'Error';
  Inkstatusarray[10] := 'OK';
  For i := 0 to 100 do
  Begin
    statustoIMnumber[i] := 1;
    IMtostatusnumber[i] := 0;
  end;
  statustoIMnumber[0]  := 1; // missing
  statustoIMnumber[5]  := 2; // polling
  statustoIMnumber[6]  := 4; // polling error
  statustoIMnumber[10] := 3; // polled
  statustoIMnumber[15] := 3; // resampling
  statustoIMnumber[16] := 0; // resampling error
  statustoIMnumber[20] := 3; // polled
  statustoIMnumber[25] := 5; // transmitting
  statustoIMnumber[26] := 7; // trans error
  statustoIMnumber[30] := 6; // transmitted
  statustoIMnumber[35] := 8; // assembling
  statustoIMnumber[36] := 10; // assembling error
  statustoIMnumber[40] := 9;  // assembled
  statustoIMnumber[45] := 11; // imaging
  statustoIMnumber[46] := 13; // imaging error
  statustoIMnumber[49] := 11; // imaging
  statustoIMnumber[50] := 12; // imaged
  statustoIMnumber[55] := 14; // verifying
  statustoIMnumber[56] := 16; // verifying error
  statustoIMnumber[60] := 15; // verifyied
  statustoIMnumber[99] := 17; // killed

  For i := 0 to 100 do
  Begin
    IMtostatusnumber[statustoIMnumber[i]] := i;
  end;
  For i := 0 to 100 do
  Begin
    datalistCols[i].Kind := 1;
    datalistCols[i].width := 80;
    datalistCols[i].tag := i;
    datalistCols[i].Col := i;
    Colorder[i] := i;
  End;
  datalistCols[0].name := formmain.InfraLanguage1.Translate('Location');
  datalistCols[0].field := 'p1.LocationID';
  datalistCols[1].name := formmain.InfraLanguage1.Translate('Production');
  datalistCols[1].field := 'p1.ProductionID';
  datalistCols[2].name := formmain.InfraLanguage1.Translate('Publication');
  datalistCols[2].field := 'p1.PublicationID';
  datalistCols[3].name := formmain.InfraLanguage1.Translate('Issue');
  datalistCols[3].field := 'p1.IssueID';
  datalistCols[4].name := formmain.InfraLanguage1.Translate('Edition');
  datalistCols[4].field := 'p1.EditionID';
  datalistCols[5].name := formmain.InfraLanguage1.Translate('Section');
  datalistCols[5].field := 'p1.SectionID';
  datalistCols[6].name := formmain.InfraLanguage1.Translate('Pagina');
  datalistCols[6].field := 'p1.Pagination';
  datalistCols[6].kind := 2;
  datalistCols[7].name := formmain.InfraLanguage1.Translate('Page name');
  datalistCols[7].field := 'p1.pagename';
  datalistCols[8].name := formmain.InfraLanguage1.Translate('Color');
  datalistCols[8].field := 'p1.ColorID';
  datalistCols[8].Kind := 4;
  datalistCols[9].name := formmain.InfraLanguage1.Translate('Version');
  datalistCols[9].field := 'p1.Version';
  datalistCols[9].Kind := 2;
  datalistCols[10].name := formmain.InfraLanguage1.Translate('Status');
  datalistCols[10].field := 'p1.Status';
  datalistCols[10].kind := 4;
  datalistCols[11].name := formmain.InfraLanguage1.Translate('External Status');
  datalistCols[11].field := 'p1.ExternalStatus';
  datalistCols[11].kind := 20;
  datalistCols[12].name := formmain.InfraLanguage1.Translate('Priority');
  datalistCols[12].field := 'p1.Priority';
  datalistCols[12].Kind := 2;
  datalistCols[13].name := formmain.InfraLanguage1.Translate('Approved');
  datalistCols[13].field := 'p1.Approved';
  datalistCols[14].name := formmain.InfraLanguage1.Translate('Hold');
  datalistCols[14].field := 'p1.Hold';
  datalistCols[15].name := formmain.InfraLanguage1.Translate('Pub.Date');
  datalistCols[15].field := 'p1.Pubdate';
  datalistCols[16].name := formmain.InfraLanguage1.Translate('Proof template');
  datalistCols[16].field := 'p1.ProofID';
  datalistCols[17].name := formmain.InfraLanguage1.Translate('Press');
  datalistCols[17].field := 'p1.PressID';
  datalistCols[18].name := formmain.InfraLanguage1.Translate('Press Run');
  datalistCols[18].field := 'p1.PressRunID';
  datalistCols[19].name := formmain.InfraLanguage1.Translate('Copy');
  datalistCols[19].field := 'p1.CopyNumber';
  datalistCols[19].Kind := 2;
  datalistCols[20].name := formmain.InfraLanguage1.Translate('Layout');
  datalistCols[20].field := 'p1.TemplateID';
  datalistCols[21].name := formmain.InfraLanguage1.Translate('Device');
  datalistCols[21].field := 'p1.DeviceID';
  datalistCols[22].name := formmain.InfraLanguage1.Translate('Pageposition');
  datalistCols[22].field := 'p2.Pagepositions';
  datalistCols[22].Kind := 2;
  datalistCols[23].name := formmain.InfraLanguage1.Translate('Sheet');
  datalistCols[23].field := 'p1.SheetNumber';
  datalistCols[23].Kind := 2;
  datalistCols[24].name := formmain.InfraLanguage1.Translate('Sheet side');
  datalistCols[24].field := 'p1.Sheetside';
  datalistCols[25].name := formmain.InfraLanguage1.Translate('Tower');
  datalistCols[25].field := 'p1.PressTower';
  datalistCols[26].name := formmain.InfraLanguage1.Translate('Zone');
  datalistCols[26].field := 'p1.PressZone';
  datalistCols[27].name := formmain.InfraLanguage1.Translate('Cylinder');
  datalistCols[27].field := 'p1.PressCylinder';
  datalistCols[28].name := formmain.InfraLanguage1.Translate('High/Low');
  datalistCols[28].field := 'p1.PressHighLow';
  datalistCols[29].name := formmain.InfraLanguage1.Translate('Proof status');
  datalistCols[29].field := 'p1.Proofstatus';
  datalistCols[30].name := formmain.InfraLanguage1.Translate('Active');
  datalistCols[30].field := 'p1.Active';
  datalistCols[31].name := formmain.InfraLanguage1.Translate('Unique');
  datalistCols[31].field := 'p1.UniquePage';
  datalistCols[32].name := formmain.InfraLanguage1.Translate('Presssection');
  datalistCols[32].field := 'p1.Presssection';
  datalistCols[33].name := formmain.InfraLanguage1.Translate('Flatproofconfiguration');
  datalistCols[33].field := 'p1.FlatproofconfigurationID';
  datalistCols[34].name := formmain.InfraLanguage1.Translate('Planpagename');
  datalistCols[34].field := 'p1.Planpagename';
  datalistCols[35].name := formmain.InfraLanguage1.Translate('Marks');
  datalistCols[35].field := 'p1.MarkGroups';
  datalistCols[36].name := formmain.InfraLanguage1.Translate('Inputtime');
  datalistCols[36].field := 'p2.Inputtime';
  datalistCols[36].Kind := 3;
  datalistCols[37].name := formmain.InfraLanguage1.Translate('ApproveTime');
  datalistCols[37].field := 'p2.ApproveTime';
  datalistCols[37].Kind := 3;
  datalistCols[38].name := formmain.InfraLanguage1.Translate('ReadyTime');
  datalistCols[38].field := 'p2.ReadyTime';
  datalistCols[38].Kind := 3;
  datalistCols[39].name := formmain.InfraLanguage1.Translate('OutputTime');
  datalistCols[39].field := 'p2.OutputTime';
  datalistCols[39].Kind := 3;
  datalistCols[40].name := formmain.InfraLanguage1.Translate('VerifyTime');
  datalistCols[40].field := 'p2.VerifyTime';
  datalistCols[40].Kind := 3;
  datalistCols[41].name := formmain.InfraLanguage1.Translate('ApproveUser');
  datalistCols[41].field := 'p2.ApproveUser';
  datalistCols[41].Kind := 3;
  datalistCols[42].name := formmain.InfraLanguage1.Translate('FileName');
  datalistCols[42].field := 'p2.FileName';
  datalistCols[43].name := formmain.InfraLanguage1.Translate('LastError');
  datalistCols[43].field := 'p2.LastError';
  datalistCols[44].name := formmain.InfraLanguage1.Translate('Comment');
  datalistCols[44].field := 'p2.Comment';
  datalistCols[45].name := formmain.InfraLanguage1.Translate('DeadLine');
  datalistCols[45].field := 'p2.DeadLine';
  datalistCols[45].Kind := 3;
  datalistCols[46].name := 'Pageindex';
  datalistCols[46].field := 'p1.Pageindex';
  datalistCols[46].kind := 2;
  datalistCols[54].name := formmain.InfraLanguage1.Translate('InputID');
  datalistCols[54].field := 'p2.InputID';
  datalistCols[47].name := 'MasterCopyseparationset';
  datalistCols[47].field := 'p1.MasterCopyseparationset';
  datalistCols[48].name := 'Copyseparationset';
  datalistCols[48].field := 'p1.Copyseparationset';
  datalistCols[49].name := 'Separationset';
  datalistCols[49].field := 'p1.Separationset';
  datalistCols[50].name := 'Separation';
  datalistCols[50].field := 'p1.Separation';
  datalistCols[51].name := 'CopyFlatseparationset';
  datalistCols[51].field := 'p1.CopyFlatseparationset';
  datalistCols[52].name := 'FlatSeparationset';
  datalistCols[52].field := 'p1.FlatSeparationset';
  datalistCols[53].name := 'FlatSeparation';
  datalistCols[53].field := 'p1.FlatSeparation';

  Nprosenttypes := 20;
  prosenttypes[1].prosst := '%P';    //   Publication
  prosenttypes[2].prosst := '%E';    //   Edition
  prosenttypes[3].prosst := '%S';    //   Section's
  prosenttypes[4].prosst := '%B';    //   Presssequence
  prosenttypes[5].prosst := '%J';    //   timestamp
  prosenttypes[6].prosst := '%U';    //   pressname
  prosenttypes[7].prosst := '%>';    //   Pressrun comment
  prosenttypes[8].prosst := '%K1';    //  presstime start
  prosenttypes[9].prosst := '%K2';    //  presstime End
  prosenttypes[10].prosst := '%K3';   //  presstime length
  prosenttypes[11].prosst := '%M';    //  printCopies
  prosenttypes[12].prosst := '%D';    //  Pubdate
  prosenttypes[13].prosst := '%L';    //  Location
  prosenttypes[14].prosst := '%O';    //  Ordernumber
  prosenttypes[15].prosst := '%I';    //  Presssystemname
  prosenttypes[16].prosst := '%B';    //  Pressectionnumber
  prosenttypes[17].prosst := '%N';    //  printCopies2
  prosenttypes[18].prosst := '%K5';    //  Deadline1
  prosenttypes[19].prosst := '%K6';    //  Deadline2
  prosenttypes[20].prosst := '%R';    //  loadedplane

  prosenttypes[1].dblevel := 1;    //   Publication
  prosenttypes[2].dblevel := 2;    //   Edition
  prosenttypes[3].dblevel := 3;    //   Section's
  prosenttypes[4].dblevel := 3;    //   Presssequence
  prosenttypes[5].dblevel := 0;    //   timestamp
  prosenttypes[6].dblevel := 1;    //   pressname
  prosenttypes[7].dblevel := 3;    //   Pressrun comment
  prosenttypes[8].dblevel := 3;    //  presstime start
  prosenttypes[9].dblevel := 3;    //  presstime End
  prosenttypes[10].dblevel := 3;    //  presstime length
  prosenttypes[11].dblevel := 1;    //  printCopies
  prosenttypes[12].dblevel := 1;    //  Pubdate
  prosenttypes[13].dblevel := 1;    //  Location
  prosenttypes[14].dblevel := 1;    //  Ordernumber
  prosenttypes[15].dblevel := 1;    //  Presssystemname
  prosenttypes[16].dblevel := 3;    //  Pressectionnumber
  prosenttypes[17].dblevel := 1;    //  issues2
  prosenttypes[18].dblevel := 1;    //  deadline1
  prosenttypes[19].dblevel := 1;    //  deadline2
  prosenttypes[20].dblevel := 1;    //loaded planname
  PrepollEvents[1].Number := 110;
  PrepollEvents[1].name := 'Preflight OK';
  PrepollEvents[2].Number := 116;
  PrepollEvents[2].name := 'Preflight error';
  PrepollEvents[3].Number := 117;
  PrepollEvents[3].name := 'Preflight warning';
  PrepollEvents[4].Number := 120;
  PrepollEvents[4].name := 'Ripped OK';
  PrepollEvents[5].Number := 126;
  PrepollEvents[5].name := 'Rip error';
  PrepollEvents[6].Number := 127;
  PrepollEvents[6].name := 'Rip warning';
  PrepollEvents[7].Number := 130;
  PrepollEvents[7].name := 'FTP OK';
  PrepollEvents[8].Number := 136;
  PrepollEvents[8].name := 'FTP error';
  PrepollEvents[9].Number := 137;
  PrepollEvents[9].name := 'FTP warning';
  PrepollEvents[10].Number := 140;
  PrepollEvents[10].name := 'Color OK';
  PrepollEvents[11].Number := 146;
  PrepollEvents[11].name := 'Color error';
  PrepollEvents[12].Number := 147;
  PrepollEvents[12].name := 'Color warning';
  MAXColsortcount := 47;
  IF Not DeviceGroupNamesPossible then  makehslist2
  else
    makehslist3;
  NdatalistCols := 54;
  loadmarks;
  //Typesloadtemplatearray;
 // loadpresses;
  //InitListViewplateview1dataArray;
  loadcolornames;
  loadstatusvalues;

End;

function Tinittypes.HexToInt(s: string): Longword;
var
  b: Byte;
  c: Char;
begin
  Result := 0;
  s := UpperCase(s);
  for b := 1 to Length(s) do
  begin
    Result := Result * 16;
    c := s[b];
    case c of
      '0'..'9': Inc(Result, Ord(c) - Ord('0'));
      'A'..'F': Inc(Result, Ord(c) - Ord('A') + 10);
      else
        raise EConvertError.Create('No Hex-Number');
    end;
  end;
end;

// NAN 20150507
function Tinittypes.GeneratePreviewGUID(nPublicationID : Integer; tPubDate : TDateTime): String;
var
  s: String;
begin
  if (nPublicationID <= 0) then
     Result := ''
  else
  begin
    s := RightStr('000' + inttostr(nPublicationID),4);
    s := s + FormatDateTime('yymmdd', tPubDate);
    Result := s;
  end;
end;

Procedure Tinittypes.Typesloadtemplatearray2;
  Function converttoTPageorientation(InpT : String;
                                     PagesAcross : Integer;
                                     PagesDown   : Integer):TPageorientation;
  var
    IA,ID : Integer;
    a,T : string;
    P : TPageorientation;
  begin
    a := InpT + ',';
    for ID := 1 to 8 do
      For IA := 1 to 8 do
        p[id,ia] := 0;
    try
      for ID := 1 to PagesDown do
      begin
        For IA := 1 to PagesAcross do
        begin
          T := copy(a,1,pos(',',a)-1);
          p[id,ia] := strtoint(t);
          Delete(a,1,pos(',',a));
        end;
      End;
    Except
    end;
    result := p;
  End;
  Function converttoTPageNumbering(InpT : String):TPageNumbering;
  Var
    I : Integer;
    a,T : string;
    P : TPageNumbering;
  Begin
    a := InpT + ',';
    for I := 1 to 32 do
      p[I] := 0;
    try
      for I := 1 to 64 do
      Begin
        T := copy(a,1,pos(',',a)-1);
        IF T = '' then
          T := '0';
        p[I] := strtoint(t);
        Delete(a,1,pos(',',a));
      End;
    Except
    end;
    result := p;
  End;

  Function findtemplatewithID(tmlpID : Integer):Integer;
  Var
    I : Integer;
  Begin
    result := -1;
    for I := 1 to NPlatetemplateArray do
    begin
      if PlatetemplateArray[i].TemplateID = tmlpID then
      begin
        result := i;
        break;
      end;
    end;
  End;

Var
  T,name : string;
  I,i2,SPL,IPlatetemplateArray : Integer;
  ThisTemplateID : Integer;
begin
  writeMainlogfile('Start get templates');
  try
    Datam1.Query1.sql.Clear;
    Datam1.Query1.sql.add('Select * from templateconfigurations');
    Datam1.Query1.sql.add('Where templateid > 0');
    Datam1.Query1.sql.add('Order by templatename');
    Datam1.Query1.Open;
    while not Datam1.Query1.eof do
    begin
      ThisTemplateID := Datam1.Query1.Fields[0].AsInteger;
      Name := Datam1.Query1.Fields[1].Asstring;
      if NPlatetemplateArray > 0 then
      begin
        IPlatetemplateArray := FindTemplateWithID(ThisTemplateID);
        if IPlatetemplateArray = -1 then
        begin
          Inc(NPlatetemplateArray);
          IPlatetemplateArray := NPlatetemplateArray;
        end;
      end
      else
      Begin
        Inc(NPlatetemplateArray);
        IPlatetemplateArray := NPlatetemplateArray;
      End;
      with PlatetemplateArray[IPlatetemplateArray] do
      begin
        TemplateID := ThisTemplateID;
        TemplateName := Name;
        Outputalias := TemplateName;
        Datam1.Query2.Sql.Clear;
        Datam1.Query2.Sql.Add('SELECT ShortName from OutputAliases');
        Datam1.Query2.Sql.Add('WHERE LongName = ' + ''''+TemplateName+'''');
        Datam1.Query2.Sql.Add('AND type = ' + ''''+'Template'+'''');
        Datam1.Query2.Open;
        IF Not Datam1.Query2.Eof then
          Outputalias := Datam1.Query2.fields[0].Asstring;
        Datam1.Query2.Close;
        TrimPage :=                        Datam1.Query1.fields[2].AsInteger;
        TrimPageWidth :=                   Datam1.Query1.fields[3].Asfloat;
        TrimPageHeight :=                  Datam1.Query1.fields[4].Asfloat;
        TrimOffsetXEven :=                 Datam1.Query1.fields[5].Asfloat;
        TrimOffsetYEven :=                 Datam1.Query1.fields[6].Asfloat;
        TrimOffsetXOdd :=                  Datam1.Query1.fields[7].Asfloat;
        TrimOffsetYOdd :=                  Datam1.Query1.fields[8].Asfloat;
        BleedMargin :=                     Datam1.Query1.fields[9].Asfloat;
        DefaultProofIDEven :=              Datam1.Query1.fields[10].AsInteger;
        DefaultProofIDOdd :=               Datam1.Query1.fields[11].AsInteger;
        PressID :=                         Datam1.Query1.fields[12].AsInteger;
        MediaID :=                         Datam1.Query1.fields[13].AsInteger;
        PagesAcross :=                     Datam1.Query1.fields[14].AsInteger;
        PagesDown :=                       Datam1.Query1.fields[15].AsInteger;
        nuponplate :=  PagesAcross * PagesDown;
        TopMargin :=                       Datam1.Query1.fields[16].AsInteger;
        BottomMargin :=                    Datam1.Query1.fields[17].AsInteger;
        LeftMargin :=                      Datam1.Query1.fields[18].AsInteger;
        RightMargin :=                     Datam1.Query1.fields[19].AsInteger;
        GutterHorzList :=                  Datam1.Query1.fields[20].Asstring;
        GutterVertList :=                  Datam1.Query1.fields[21].Asstring;
        T :=                               Datam1.Query1.fields[22].Asstring; //
        ISdouble := 1;
        ISDoublefronttoback := 0;
        PageRotationList := converttoTPageNumbering(t);
        Numberofblanks := 0;
        PageSnapList :=                    Datam1.Query1.fields[23].Asstring;
        PlateReference :=                  Datam1.Query1.fields[24].AsInteger;
        MarksFile :=                       Datam1.Query1.fields[25].Asstring;
        TrimMarks :=                       Datam1.Query1.fields[26].AsInteger;
        RegisterMarks :=                   Datam1.Query1.fields[27].AsInteger;
        FoldMarks :=                       Datam1.Query1.fields[28].AsInteger;
        T :=                               Datam1.Query1.fields[29].Asstring;//
        PageNumberingFront := converttoTPageNumbering(T);
        T :=                               Datam1.Query1.fields[30].Asstring;//
        PageNumberingBack := converttoTPageNumbering(T);
        T :=                               Datam1.Query1.fields[31].Asstring;//

        PageNumberingFrontHalfWeb := converttoTPageNumbering(T);
        T :=                               Datam1.Query1.fields[32].Asstring;//
        PageNumberingBackHalfWeb := converttoTPageNumbering(T);
        T := Datam1.Query1.fields[33].FieldName;
        I := 1;
        for i2 := 1 to nuponplate do
        begin
          if i2 <> i then
          begin
            if (PageNumberingFront[i] = PageNumberingFront[i2]) and (PageNumberingFront[i] <> 0) then
            begin
              Inc(ISdouble);
            end;
          end;
        end;
        for i2 := 1 to nuponplate do
        begin
          if (PageNumberingFront[i] = PageNumberingBACK[i2]) and (PageNumberingFront[i] <> 0) then
          begin
            ISDoublefronttoback := 1;
            break;
          end;
        end;
        for i := 1 to nuponplate do
        begin
          if PageNumberingFront[i] = 0 then
            Inc(Numberofblanks);
          if PageNumberingBack[i] = 0 then
            Inc(Numberofblanks);
        end;
        //Numberofblanks
        EnableScaling :=                   Datam1.Query1.fields[33].AsInteger;
        ScalingCyanX :=                    Datam1.Query1.fields[34].Asfloat;
        ScalingCyanY :=                    Datam1.Query1.fields[35].Asfloat;
        ScalingMagentaX :=                 Datam1.Query1.fields[36].Asfloat;
        ScalingMagentaY :=                 Datam1.Query1.fields[37].Asfloat;
        ScalingYellowX :=                  Datam1.Query1.fields[38].Asfloat;
        ScalingYellowY :=                  Datam1.Query1.fields[39].Asfloat;
        ScalingBlackX :=                   Datam1.Query1.fields[40].Asfloat;
        ScalingBlackY :=                   Datam1.Query1.fields[41].Asfloat;
        ScalingSpotX :=                    Datam1.Query1.fields[42].Asfloat;
        ScalingSpotY :=                    Datam1.Query1.fields[43].Asfloat;
        DirectLithoCyan :=                 Datam1.Query1.fields[44].AsInteger;
        DirectLithoMagenta :=              Datam1.Query1.fields[45].AsInteger;
        DirectLithoYellow :=               Datam1.Query1.fields[46].AsInteger;
        DirectLithoBlack :=                Datam1.Query1.fields[47].AsInteger;
        DirectLithoSpot :=                 Datam1.Query1.fields[48].AsInteger;
        DeviceList :=                      Datam1.Query1.fields[49].Asstring;
        DeviceEnableList :=                Datam1.Query1.fields[50].Asstring;
        CassetteList :=                    Datam1.Query1.fields[51].Asstring;
        PunchList :=                       Datam1.Query1.fields[52].Asstring;
        ExposureLevelList :=               Datam1.Query1.fields[53].Asstring;
        InvertList :=                      Datam1.Query1.fields[54].Asstring;
        MirrorList :=                      Datam1.Query1.fields[55].Asstring;
        RotationList :=                    Datam1.Query1.fields[56].Asstring;
        Copies :=                          Datam1.Query1.fields[57].AsInteger;
        OutputnameMask :=                  Datam1.Query1.fields[58].Asstring;
        OutputnameMaskPagenumbers :=       Datam1.Query1.fields[59].AsInteger;
        OutputnameMaskUseAliases :=        Datam1.Query1.fields[60].AsInteger;
        Platecut :=                        Datam1.Query1.fields[61].AsInteger;
        T := Datam1.Query1.fields[62].FieldName;
        TestPageEvenHires :=               Datam1.Query1.fields[62].Asstring;
        TestPageOddHires :=                Datam1.Query1.fields[63].Asstring;
        TestPageEvenLowres :=              Datam1.Query1.fields[64].Asstring;
        TestPageOddLowRes :=               Datam1.Query1.fields[65].Asstring;
        IncomingPageXEven :=               Datam1.Query1.fields[66].Asfloat;
        IncomingPageYEven :=               Datam1.Query1.fields[67].Asfloat;
        IncomingPageXOdd :=                Datam1.Query1.fields[68].Asfloat;
        IncomingPageYOdd :=                Datam1.Query1.fields[69].Asfloat;
        T := Datam1.Query1.fields[70].FieldName;
        IncomingPageRotationEven  :=       Datam1.Query1.fields[70].AsInteger;
        IncomingPageRotationOdd  :=        Datam1.Query1.fields[71].AsInteger;
        IncomingPageSnapEven  :=           Datam1.Query1.fields[72].AsInteger;
        IncomingPageSnapOdd  :=            Datam1.Query1.fields[73].AsInteger;
        ShowSheet :=                       Datam1.Query1.fields[74].AsInteger;
        SheetWidth :=                      Datam1.Query1.fields[75].Asfloat;
        SheetHeight :=                     Datam1.Query1.fields[76].Asfloat;
        SheetOffsetLeft :=                 Datam1.Query1.fields[77].Asfloat;
        SheetOffsetTop :=                  Datam1.Query1.fields[78].Asstring;
        PageFormatID :=                    Datam1.Query1.fields[79].AsInteger;
        BackAsFront :=                     Datam1.Query1.fields[80].AsInteger;
        TopMarginBack :=                   Datam1.Query1.fields[81].Asfloat;
        BottomMarginBack :=                Datam1.Query1.fields[82].Asfloat;
        LeftMarginBack :=                  Datam1.Query1.fields[83].Asfloat;
        RightMarginBack :=                 Datam1.Query1.fields[84].Asfloat;
        GutterHorzBackList :=              Datam1.Query1.fields[85].Asstring;
        GutterVertBackList :=              Datam1.Query1.fields[86].Asstring;
        PageRotationBackList :=            converttoTPageNumbering(Datam1.Query1.fields[87].Asstring);
        PageSnapBackList :=                Datam1.Query1.fields[88].Asstring;
        PlateReferenceBack :=              Datam1.Query1.fields[89].AsInteger;
        MarksFileBack :=                   Datam1.Query1.fields[90].Asstring;
        TrimMarksBack :=                   Datam1.Query1.fields[91].AsInteger;
        RegisterMarksBack :=               Datam1.Query1.fields[92].AsInteger;
        FoldMarksBack :=                   Datam1.Query1.fields[93].AsInteger;
        OffsetCyanX :=                     Datam1.Query1.fields[94].Asfloat;
        OffsetCyanY :=                     Datam1.Query1.fields[95].Asfloat;
        OffsetMagentaX :=                  Datam1.Query1.fields[96].Asfloat;
        OffsetMagentaY :=                  Datam1.Query1.fields[97].Asfloat;
        OffsetYellowX :=                   Datam1.Query1.fields[98].Asfloat;
        OffsetYellowY :=                   Datam1.Query1.fields[99].Asfloat;
        OffsetBlackX :=                    Datam1.Query1.fields[100].Asfloat;
        OffsetBlackY :=                    Datam1.Query1.fields[101].Asfloat;
        OffsetSpotX :=                     Datam1.Query1.fields[102].Asfloat;
        OffsetSpotY :=                     Datam1.Query1.fields[103].Asfloat;
        SPL :=                     Datam1.Query1.fieldbyname('UseTiffCopy').asinteger;
        CollectMode      := SPL and 128 > 0;
        CollectOverUnder := SPL and 256 > 0;
        Splitmode := 0;
        IF CollectMode then
          Splitmode := 1;
        IF CollectOverUnder then
          Splitmode := 2;
        Plateorientation := 0;
        (*
        Er 1 hvis front roteret
        Er 2 hvis back roteret
        Er 3 hvis begge roteret
        *)
(*          Datam1.Query2.sql.clear;
        Datam1.Query2.sql.add('SELECT (Platecut & 0x60)/32 from TemplateConfigurations ');
        Datam1.Query2.sql.add('where TemplateID = ' + inttostr(templateid));
        Datam1.Query2.open;
        IF not Datam1.Query2.eof then
          Plateorientation := Datam1.Query2.fields[0].AsInteger;
        Datam1.Query2.close;
       *)
        PlateOrientation := (Platecut AND $60) DIV 32;
        Datam1.Query2.Sql.Clear;
        Datam1.Query2.Sql.Add('select MarkGroupID from markgroupnames');
        Datam1.Query2.Sql.Add('where templateid = ' + inttostr(templateid));
        Datam1.Query2.Open;
        Nmarkgroups := 0;
        while not Datam1.Query2.eof do
        begin
          Inc(Nmarkgroups);
          markgroups[Nmarkgroups] := Datam1.Query2.Fields[0].AsInteger;
          Datam1.Query2.Next;
        end;
        Datam1.Query2.Close;
        inittypes.getdeviceIDSfromtemplate(IPlatetemplateArray);

        proofdeviceintemplate := false;
        For I := 1 to Naktdeviceidlist do
        begin
          Datam1.Query2.Sql.Clear;
          Datam1.Query2.Sql.Add('select devicetype from deviceconfigurations');
          Datam1.Query2.Sql.Add('where deviceid = ' + IntToStr(aktdeviceidlist[i]));
          Datam1.Query2.Open;
          IF not Datam1.Query2.Eof then
          begin
            if Datam1.Query2.Fields[0].AsInteger = 10 then
            begin
              proofdeviceintemplate := true;
              ProofdeviceID := aktdeviceidlist[i];
            end;
          end;
          Datam1.Query2.Close;
        end;
       end;
       Datam1.Query1.Next;
    end;
    Datam1.Query1.Close;
    writeMainlogfile('done reading templates');
  except
    writeMainlogfile('Exception in get templates');
  end;
end;


Function Tinittypes.gettemplatenumberfromID(templateID : Integer):Integer;
Var
  I : Integer;
Begin
  result := 1;
  For i := 1 to NPlatetemplateArray do
  begin
    if PlatetemplateArray[i].TemplateID = TemplateID then
    begin
      result := i;
      break;
    end;
  End;
End;

// Returns global list Aktdevicelist of device names
procedure Tinittypes.getdevicelistfromtemplate(templatenumber : Integer);
Var
  T,t2,s,s2 : string;
  I : integer;
Begin
  IF Aktdevicelist = nil then
    Aktdevicelist := TStringList.Create;
  Aktdevicelist.Clear;
  s  := PlatetemplateArray[templatenumber].DeviceEnableList;
  t := PlatetemplateArray[templatenumber].DeviceList;
  //t2 := PlatetemplateArray[templatenumber].DeviceEnableList;
   i := 0;
  IF length(t) > 0 then
  begin
    IF pos(',',t) > 0 then
    begin
      While t <> '' do
      begin
        IF pos(',',t) > 0 then
        Begin
          t2 := copy(t,1,pos(',',t)-1);
          Delete(t,1,pos(',',t));
          s2 := copy(s,1,pos(',',s)-1);
          Delete(s,1,pos(',',s));
        End
        else
        Begin
          t2 := t;
          t := '';
           s2 := s;
          s := '';
        end;
         inc(i);
        IF s2 <> '0' then
        Begin
          i := strtoint(t2);
          aktDeviceList.Add(tnames1.deviceIDtoname(i));
        End;
      end;
    end
    else
    begin
      IF t2 <> '0' then
      Begin
        i := strtoint(t);
        Aktdevicelist.Add(tnames1.deviceIDtoname(i));
      End;
    end;
  end;
end;

procedure Tinittypes.getdevicelistfromtemplateNogrp(templatenumber : Integer);
Var
  T,t2,s,s2 : string;
  i : integer;
Begin
  IF Aktdevicelist = nil then
    Aktdevicelist := TStringList.Create;
  Aktdevicelist.Clear;
  T  := PlatetemplateArray[templatenumber].DeviceList;
  s := PlatetemplateArray[templatenumber].DeviceEnableList;
   i := 0;
  IF length(t) > 0 then
  begin
    IF pos(',',t) > 0 then
    begin
      While t <> '' do
      begin
        IF pos(',',t) > 0 then
        Begin
          t2 := copy(t,1,pos(',',t)-1);
          Delete(t,1,pos(',',t));
          s2 := copy(s,1,pos(',',s)-1);
          Delete(s,1,pos(',',s));
        End
        else
        Begin
          t2 := t;
          t := '';
          s2 := s;
          s := '';
        end;
        inc(i);
      //  IF t2 <> '0' then
        IF s2 <> '0' then
        Begin
          i := StrToInt(t2);
         // i := strtoint(s);
          aktDeviceList.Add(tnames1.deviceIDtoname(i));
        End;
      end;
    end
    else
    begin
      IF t2 <> '0' then
      Begin
        i := StrToInt(t);
        Aktdevicelist.Add(tnames1.deviceIDtoname(i));
      End;
    end;
  end;
end;

 // returns aktdeviceidliststring, Aktdeviceliststring & Naktdeviceidlist
procedure Tinittypes.getdeviceIDSfromtemplate(templatenumber : Integer);
var
  T,t2 : string;
  i : integer;
  ET,Et2 : string;
  EI : integer;
Begin
  Naktdeviceidlist := 0;
  aktdeviceidliststring := '';
  Aktdeviceliststring := '';
  IF Aktdevicelist = nil then
    Aktdevicelist := TStringList.Create;
  T := PlatetemplateArray[templatenumber].DeviceList;
  ET := PlatetemplateArray[templatenumber].DeviceEnableList;
  IF (length(t) > 0) then
  begin
    IF pos(',',t) > 0 then
    begin
      While t <> '' do
      begin
        IF pos(',',t) > 0 then
        Begin
          t2 := copy(t,1,pos(',',t)-1);
          Et2 := copy(Et,1,pos(',',Et)-1);
          Delete(t,1,pos(',',t));
          Delete(Et,1,pos(',',Et));
        End
        else
        Begin
          t2 := t;
          t := '';
          Et2 := Et;
          Et := '';
        end;
        IF t2 <> '0' then
        Begin
          i := strtoint(t2);
          EI := strtoint(Et2);
          IF EI > 0 then
          begin
            Inc(Naktdeviceidlist);
            aktdeviceidlist[Naktdeviceidlist] := i;
            IF length(aktdeviceidliststring) > 0 then
              aktdeviceidliststring := aktdeviceidliststring + ',';
            aktdeviceidliststring := aktdeviceidliststring + inttostr(i);
            IF length(Aktdeviceliststring) > 0 then
              Aktdeviceliststring := Aktdeviceliststring + ',';
            Aktdeviceliststring := Aktdeviceliststring + tnames1.deviceIDtoname(i);

          End;
        End;
      end;
    end
    else
    begin
      IF t2 <> '0' then
      Begin
        i := strtoint(t);
        Ei := strtoint(Et);
        IF EI > 0 then
        begin
          Inc(Naktdeviceidlist);
          aktdeviceidlist[Naktdeviceidlist] := i;
          IF length(aktdeviceidliststring) > 0 then
            aktdeviceidliststring := aktdeviceidliststring + ',';
          aktdeviceidliststring := aktdeviceidliststring + inttostr(i);
          IF length(Aktdeviceliststring) > 0 then
            Aktdeviceliststring := Aktdeviceliststring + ',';
          Aktdeviceliststring := Aktdeviceliststring + tnames1.deviceIDtoname(i);
        End;
      End;
    end;
  end;
end;
(*
Function Tinittypes.getdeviceidfromname(name : string):Integer;
Var
  I : Integer;
Begin

  result := 0;
  for i := 0 to 200 do
  begin
    if uppercase(name) = uppercase(tnames1.deviceIDtoname(i)) then
    begin
      result := i;
      break;
    end;
  end;
End;
*)

Function Tinittypes.gettemplatelistnumberfromdbID(dbtemplateid : Longint):Integer;
Var
  I : Integer;
Begin
  result := 1;
  For i := 1 to NPlatetemplateArray do
  begin
    if PlatetemplateArray[i].TemplateID = dbtemplateid then
    begin
      result := i;
      break;
    end;
  End;
end;

function Tinittypes.gettemplatelistnumberfromname(name : string):Integer;
Var
  I : Integer;
Begin
  result := 1;
  For i := 1 to NPlatetemplateArray do
  begin
    if PlatetemplateArray[i].TemplateName = name then
    begin
      result := i;
      break;
    end;
  End;
End;
(*
procedure RGBTOCMYK(R : byte;
                    G : byte;
                    B : byte;
                    var C : byte;
                    var M : byte;
                    var Y : byte;
                    var K : byte);
begin
  C := 255 - R;
  M := 255 - G;
  Y := 255 - B;
  if C < M then
    K := C else
    K := M;
  if Y < K then
    K := Y;
  if k > 0 then begin
    c := c - k;
    m := m - k;
    y := y - k;
  end;
end;
*)

Function Tinittypes.calccolor(C,M,Y,K : single):tcolor;
Var
  R,G,B : Integer;
  Bk : Single;
Begin
  C := C * 2.55;
  M := M * 2.55;
  Y := Y * 2.55;
  K := K * 2.55;
  Bk := (255-K) / 255;
  R := Round(Bk * (255-C));
  G := Round(Bk * (255-M));
  B := Round(Bk * (255-Y));
  IF R > 255 then R := 255;
  IF G > 255 then G := 255;
  IF B > 255 then B := 255;
  IF R < 0 then R := 0;
  IF G < 0 then G := 0;
  IF B < 0 then B := 0;
  calccolor := R + (G * $100)  + (B * $10000) +  $0000000;
end;

Procedure Tinittypes.LoadColorNames;
Var
  d : trect;
  ci : Tbitmap;
  id,i : Integer;
  maxDBColors : Integer;
begin
  formmain.ImageListdatasmall.clear;
  ci := tbitmap.Create;
  ci.Width := 16;
  ci.height := 16;
  //I := formmain.ImageListdatasmall.Count;

  For i := 0 to FormImage.ImageListStatus.Count-1 do
  begin
    ci.canvas.Brush.color := clwhite;
    ci.canvas.pen.color := clwhite;
    ci.canvas.Rectangle(0,0,16,16);
    FormImage.ImageListStatus.GetBitmap(i,ci);
    formmain.ImageListdatasmall.AddMasked(ci,clnone);
  end;
  d.top := 0;
  d.Left := 0;
  d.Right := 16;
  d.bottom := 16;

  ci.canvas.Brush.color := clwhite;
  ci.canvas.pen.color := clwhite;
  ci.canvas.Rectangle(0,0,16,16);

  ci.Canvas.CopyMode := cmSrcAnd;
  ci.Canvas.CopyRect(d,FormImage.Imagecolorbrg.Canvas,d);
  maxDBColors := 2000;
  Datam1.Query1.sql.Clear;
  Datam1.Query1.sql.add('Select MAX(ColorID) from Colornames (NOLOCK)');
  Datam1.Query1.open;
  if not  Datam1.Query1.eof then
    maxDBcolors := Datam1.Query1.Fields[0].Asinteger;
  SetLength(Colorsnames, maxDBcolors+1);  // colornames is 1-based.. 0 element not used

  formmain.ImageListdatasmall.AddMasked(ci,clnone);
  for i := 0 to maxDBcolors do
  begin
   Colorsnames[i].valid := false;
  end;
  Datam1.Query1.Sql.Clear;
  Datam1.Query1.Sql.Add('SELECT ColorID,ColorName,C,M,Y,K,ColorOrder FROM ColorNames (NOLOCK)');
  Datam1.Query1.Sql.Add('ORDER BY ColorOrder');
  Datam1.Query1.Open;
  While not Datam1.Query1.Eof do
  begin
    id :=  Datam1.Query1.Fields[0].AsInteger;
    Colorsnames[id].valid := true;
    Colorsnames[id].name := Datam1.Query1.Fields[1].AsString;
    Colorsnames[id].C := Datam1.Query1.fields[2].AsInteger;
    Colorsnames[id].M := Datam1.Query1.fields[3].AsInteger;
    Colorsnames[id].Y := Datam1.Query1.fields[4].AsInteger;
    Colorsnames[id].K := Datam1.Query1.fields[5].AsInteger;
    Colorsnames[id].colorindex := Id;
    Colorsnames[id].Colorlook := calccolor(Colorsnames[Id].C,Colorsnames[Id].M,Colorsnames[Id].Y,Colorsnames[Id].K);
    Colorsnames[id].colororder := Datam1.Query1.Fields[6].asInteger;
    d.top := 0;
    d.Left := 0;
    d.Right := 16;
    d.bottom := 16;
    ci.canvas.Brush.color := Colorsnames[id].Colorlook;
    ci.canvas.pen.color := Colorsnames[id].Colorlook;
    ci.canvas.Rectangle(0,0,16,16);
    IF Colorsnames[id].K = 100 then
    Begin
      ci.Canvas.CopyMode := cmSrcCopy;
      ci.Canvas.CopyRect(d,FormImage.ImageKcolor.Canvas,d);
    End
    else
    Begin
      ci.Canvas.CopyMode := cmSrcAnd;
      ci.Canvas.CopyRect(d,FormImage.Imagecolorbrg.Canvas,d);
    End;
    Colorsnames[id].colorimage := formmain.ImageListdatasmall.AddMasked(ci,clnone);
    Datam1.Query1.Next;
  end;
  Datam1.Query1.Close;
  ci.free;
end;

Procedure Tinittypes.loadstatusvalues;
Var
  T : string;
  R,G,B : Byte;
  I : Integer;
  statusName : string;
  statuscode : Integer;
Begin
  formmain.ComboBoxStatus.Items.clear;
  formmain.ComboBoxStatus.Items.add(cobomtexts[0]{'all'});
  formmain.ComboBoxStatus.Items.add(cobomtexts[1]{'Not missing'});
  formmain.ComboBoxStatus.Items.add(cobomtexts[2]{'Not transmitted'});
  formmain.ComboBoxStatus.Items.add(cobomtexts[3]{'Not Imaged'});
  formmain.ComboBoxStatus.Items.add(cobomtexts[4]{'Any error'});
  formmain.ComboBoxapproval.Items.clear;
  formmain.ComboBoxapproval.Items.add(cobomtexts[0]{'all'});
  formmain.ComboBoxapproval.Items.add(cobomtexts[5]{''Not approved''});
  formmain.ComboBoxapproval.Items.add(cobomtexts[6]{'Approved'});
  formmain.ComboBoxapproval.Items.add(cobomtexts[7]{'Disapproved'});
  formmain.ComboBoxapproval.itemindex := 0;
  formmain.ComboBoxhold.Items.clear;
  formmain.ComboBoxhold.Items.add(cobomtexts[0]{'all'});
  formmain.ComboBoxhold.Items.add(cobomtexts[8]{'held'});
  formmain.ComboBoxhold.Items.add(cobomtexts[9]{'released'});
  formmain.ComboBoxhold.itemindex := 0;
  formmain.ComboBoxactive.Items.clear;
  formmain.ComboBoxactive.Items.add(cobomtexts[10]{'hide'});
  formmain.ComboBoxactive.Items.add(cobomtexts[11]{'show'});
  formmain.ComboBoxactive.itemindex := 0;
  For i := 0 to 200 do
  begin
    statusarray[i].name := '';
    statusarray[i].color := clwhite;
    externalstatusarray[i].name := '';
    externalstatusarray[i].color := clwhite;
    externalstatusarrayex[i].name := '';
    externalstatusarrayex[i].color := clwhite;
    externalstatusarrayex[i].number := 1;
  end;
  Datam1.Query1.sql.Clear;
  Datam1.Query1.sql.add('SELECT StatusNumber,StatusName,StatusColor FROM StatusCodes (NOLOCK)');
  Datam1.Query1.sql.add('ORDER BY StatusName');
  Datam1.Query1.open;
  Nstatusarray := 0;
  While not Datam1.Query1.eof do
  begin
    statuscode := Datam1.Query1.Fields[0].AsInteger;
    statusname :=  Datam1.Query1.Fields[1].AsString;
    statusarray[statuscode].name := statusname;
    formmain.ComboBoxStatus.Items.Add(statusname);
    T := Datam1.Query1.fields[2].AsString;
    R := HexToInt(copy(t,1,2));
    G := HexToInt(copy(t,3,2));
    B := HexToInt(copy(t,5,2));
    statusarray[statuscode].name := statusname;
    statusarray[statuscode].color := RGB(R,G,B);
    Datam1.Query1.next;
  End;
  Datam1.Query1.Close;
  formmain.ComboBoxStatus.Itemindex := 0;
  Datam1.Query1.sql.Clear;
  Datam1.Query1.sql.add('SELECT StatusNumber,StatusName,StatusColor FROM ExternalStatusCodes (NOLOCK)');
  Datam1.Query1.sql.add('ORDER BY StatusName');
  Datam1.Query1.open;
  Nexternalstatusarray := 0;
  i := 0;
  While not Datam1.Query1.eof do
  begin
    statuscode := Datam1.Query1.Fields[0].AsInteger;
    statusname :=  Datam1.Query1.Fields[1].AsString;
    externalstatusarray[statuscode].name := statusname;
    T := Datam1.Query1.fields[2].AsString;
    R := HexToInt(copy(t,1,2));
    G := HexToInt(copy(t,3,2));
    B := HexToInt(copy(t,5,2));
    externalstatusarray[statuscode].color := RGB(R,G,B);
    externalstatusarrayex[i].name := externalstatusarray[statuscode].name;
    externalstatusarrayex[i].color := externalstatusarray[statuscode].color;
    externalstatusarrayex[i].number := statuscode;
    inc(i);
    Datam1.Query1.next;
  End;
  Datam1.Query1.close;
End;

Function Tinittypes.ISblack(colorname : string):boolean;
var
  I : Integer;
begin
  result := false;
  for i := 1 to Length(colorsnames) do
  begin
    IF colorname = Colorsnames[i].name then
    begin
      result := Colorsnames[i].K = 100;
      break;
    end;
  end;
end;

Function Tinittypes.InArrayStr(arstring : string;
                               findstr : string):integer;
Var
  t,t2 : string;
  I : Integer;
Begin
  result := -1;
  t := arstring;
  i := 0;
  IF length(t) > 0 then
  begin
    IF pos(',',t) > 0 then
    begin
      While t <> '' do
      begin
        Inc(i);
        IF pos(',',t) > 0 then
        Begin
          t2 := copy(t,1,pos(',',t)-1);
          Delete(t,1,pos(',',t));
        End
        else
        Begin
          t2 := t;
          t := '';
        end;
        IF uppercase(t2) = uppercase(findstr) then
          result := i;
      end;
    end
    else
    begin
      IF uppercase(t) = uppercase(findstr) then
        result := i;
    end;
  end;
end;

Procedure Tinittypes.loadmarks;
Begin
  NMarks := 0;
  Datam1.Query2.sql.Clear;
  Datam1.Query2.sql.Add('select markgroupid,markgroupname,templateid from markgroupnames');
  Datam1.Query2.Open;
  while not Datam1.Query2.Eof do
  begin
    Inc(NMarks);
    Marks[NMarks].markid   := Datam1.Query2.fields[0].AsInteger;
    Marks[NMarks].template := Datam1.Query2.fields[2].AsInteger;
    Marks[NMarks].markname := Datam1.Query2.fields[1].AsString;
    marksnamestrarray[Marks[NMarks].markid] := Marks[NMarks].markname;
    Datam1.Query2.Next;
  end;
  Datam1.Query2.Close;
end;

Function Tinittypes.marksIDstr(ANmarks : Integer;
                               Amarks : marksarray):string;
Var
  I : Integer;
Begin
  result := '';
  For i := 1 to ANmarks do
  begin
    result := result + ',' + inttostr(Amarks[i]);
  end;
  if length(result) > 0 then
    Delete(result,1,1);
end;
Function Tinittypes.marksnamestr(ANmarks : Integer;
                                 Amarks : marksarray):string;
Var
  I{,i2} : Integer;
Begin
  result := '';
  For i := 1 to ANmarks do
  begin
    result := result + ',' + marksnamestrarray[Amarks[i]];
  end;
  if length(result) > 0 then
    Delete(result,1,1);
end;

Function Tinittypes.POSinPosarray(Apos : Integer;
                                  APPOS : pparray;
                                  ANPPOS : Integer):Boolean;
Var
  I : Integer;
Begin
  result := false;
  try
    for i := 1 to ANPPOS do
    begin
      IF APPOS[i] = Apos then
      begin
        result := true;
        break;
      end;
    end;
  except
  end;
end;

Procedure Tinittypes.PPOSstrtoarray(Astr : String;
                                    Var APPOS : pparray;
                                    Var ANPPOS : Integer);
Var
  t,t2 : string;
//  I : Integer;
Begin
  ANPPOS := 0;
  IF length(Astr) > 0 then
  begin
    t := Astr;
    IF length(t) > 0 then
    begin
      IF pos(',',t) > 0 then
      begin
        While t <> '' do
        begin
          Inc(ANPPOS);
          IF pos(',',t) > 0 then
          Begin
            t2 := copy(t,1,pos(',',t)-1);
            APPOS[ANPPOS] := strtoint(t2);
            Delete(t,1,pos(',',t));
          End
          else
          Begin
            t2 := t;
            APPOS[ANPPOS] := strtoint(t2);
            t := '';
          end;
        end;
      end
      else
      begin
        Inc(ANPPOS);
        APPOS[ANPPOS] := strtoint(t);
      end;
    end;
  end;
End;
Procedure Tinittypes.markstrtoarray(Astr : String;
                                    Var Amarks : marksarray;
                                    Var ANmarks : Integer);
var
  t,t2 : string;
//  I : Integer;
begin
  ANmarks := 0;
  if length(Astr) > 0 then
  begin
    t := Astr;
    if length(t) > 0 then
    begin
      IF pos(',',t) > 0 then
      begin
        While t <> '' do
        begin
          Inc(ANmarks);
          IF pos(',',t) > 0 then
          Begin
            t2 := copy(t,1,pos(',',t)-1);
            Amarks[ANmarks] := strtoint(t2);
            Delete(t,1,pos(',',t));
          End
          else
          Begin
            t2 := t;
            Amarks[ANmarks] := strtoint(t2);
            t := '';
          end;
        end;
      end
      else
      begin
        Inc(ANmarks);
        Amarks[ANmarks] := strtoint(t);
      end;
    end;
  end;
End;

Procedure Tinittypes.marknamestrtoarray(Astr : String;
                                        Var Amarks : marksarray;
                                        Var ANmarks : Integer);
var
  t,t2 : string;
//  I : Integer;
begin
  ANmarks := 0;
  if length(Astr) > 0 then
  begin
    t := Astr;
    if length(t) > 0 then
    begin
      IF Pos(',',t) > 0 then
      begin
        While t <> '' do
        begin
          Inc(ANmarks);
          IF Pos(',',t) > 0 then
          Begin
            t2 := Copy(t,1,Pos(',',t)-1);
            Amarks[ANmarks] :=   inittypes.marknametoid(t2);
            Delete(t,1,Pos(',',t));
          End
          else
          Begin
            t2 := t;
            Amarks[ANmarks] := inittypes.marknametoid(t2);
            t := '';
          end;
        end;
      end
      else
      begin
        Inc(ANmarks);
        Amarks[ANmarks] := inittypes.marknametoid(t2);
      end;
    end;
  end;
end;

function Tinittypes.markIDtoname(markid : Integer):string;
var
  i : Integer;
begin
  result := '';
  for i := 1 to nmarks do
  begin
    if marks[i].markid = markid then
    begin
      result := marks[i].markname;
      break;
    end;
  end;
end;

function Tinittypes.marknametoid(markname : string):Integer;
var
  i : Integer;
begin
  result := 0;
  for i := 1 to nmarks do
  begin
    if uppercase(marks[i].markname) = uppercase(markname) then
    begin
      result := marks[i].markid;
      break;
    end;
  end;
end;

Procedure Tinittypes.makehslist2;
var
  I : Integer;
  inif : tinifile;
begin
  for i := 0 to 200 do
  begin
    HSOrder[i] := i;
    HSCols[i].tag := i;
    HSCols[i].iscaption := false;
    HSCols[i].Show := false;
    HSCols[i].width := 50;
    HSCols[i].ColX := i;
    HSCols[i].Mandatory := false;
  end;
	HSCols[ 0].name          := 'Status';
	HSCols[ 1].name          := 'ExternalStatus';
	HSCols[ 2].name          := 'Publication';
	HSCols[ 3].name          := 'Section';
	HSCols[ 4].name          := 'Edition';
	HSCols[ 5].name          := 'Issue';
	HSCols[ 6].name          := 'PubDate';
	HSCols[ 7].name          := 'PageName';
	HSCols[ 8].name          := 'Color';
	HSCols[ 9].name          := 'Layout';
	HSCols[10].name          := 'Prooftemplate';
	HSCols[11].name          := 'Device';
	HSCols[12].name          := 'Version';
	HSCols[13].name          := 'Layer';
	HSCols[14].name          := 'CopyNumber';
	HSCols[15].name          := 'Pagination';
	HSCols[16].name          := 'Approved';
	HSCols[17].name          := 'Hold';
	HSCols[18].name          := 'Active';
	HSCols[19].name          := 'Priority';
	HSCols[20].name          := 'PagePosition';
	HSCols[21].name          := 'PageType';
	HSCols[22].name          := 'PagesOnPlate';
	HSCols[23].name          := 'SheetNumber';
	HSCols[24].name          := 'SheetSide';
	HSCols[25].name          := 'Press';
	HSCols[26].name          := 'PressSectionNumber';
	HSCols[27].name          := 'SortingPosition';
	HSCols[28].name          := 'PressTower';
	HSCols[29].name          := 'PressCylinder';
	HSCols[30].name          := 'PressZone';
	HSCols[31].name          := 'PressHighLow';
	HSCols[32].name          := 'Production';
	HSCols[33].name          := 'PressRun';
	HSCols[34].name          := 'ProofStatus';
	HSCols[35].name          := 'InkStatus';
	HSCols[36].name          := 'PlanPageName';
	HSCols[37].name          := 'IssueSequenceNumber';
	HSCols[38].name          := 'UniquePage';
	HSCols[39].name          := 'Location';
	HSCols[40].name          := 'FlatProofConfiguration';
	HSCols[41].name          := 'FlatProofStatus';
	HSCols[42].name          := 'Creep';
	HSCols[43].name          := 'MarkGroups';
	HSCols[44].name          := 'PageIndex';
	HSCols[45].name          := 'GutterImage';
	HSCols[46].name          := 'Outputversion';
	HSCols[47].name          := 'HardProofConfiguration';
	HSCols[48].name          := 'HardProofStatus';
	HSCols[49].name          := 'FileServer';
	HSCols[50].name          := 'Dirty';
	HSCols[51].name          := 'InputTime';
	HSCols[52].name          := 'ApproveTime';
	HSCols[53].name          := 'ReadyTime';
	HSCols[54].name          := 'OutputTime';
	HSCols[55].name          := 'VerifyTime';
	HSCols[56].name          := 'ApproveUser';
	HSCols[57].name          := 'FileName';
	HSCols[58].name          := 'LastError';
	HSCols[59].name          := 'Comment';
	HSCols[60].name          := 'DeadLine';
	HSCols[61].name          := 'InputID';
	HSCols[62].name          := 'PagePositions';
	HSCols[63].name          := 'InputProcessID';
	HSCols[64].name          := 'SoftProofProcessID';
	HSCols[65].name          := 'HardProofProcessID';
	HSCols[66].name          := 'TransmitProcessID';
	HSCols[67].name          := 'ImagingProcessID';
	HSCols[68].name          := 'InkProcessID';
	HSCols[69].name          := 'OutputPriority';
	HSCols[70].name          := 'PressTime';
	HSCols[71].name          := 'Customer';
	HSCols[72].name          := 'EmailStatus';
	HSCols[73].name          := 'Extragutter';
	HSCols[74].name          := 'Week/Number';
	HSCols[75].name          := 'Miscint3';
	HSCols[76].name          := 'Miscint4';
	HSCols[77].name          := 'Plate number';
	HSCols[78].name          := 'Miscstring2';
	HSCols[79].name          := 'Miscstring3';
	HSCols[80].name          := 'Miscdate';
	HSCols[81].name          := 'SequenceNumber';
	HSCols[82].name          := 'Deadline1';
	HSCols[83].name          := 'Deadline2';
	HSCols[84].name          := 'Deadline3';
	HSCols[85].name          := 'Deadline4';
	HSCols[86].name          := 'PriorityBeforeHottime';
	HSCols[87].name          := 'PriorityDuringHottime';
	HSCols[88].name          := 'PriorityAfterHottime';
	HSCols[89].name          := 'PriorityHottimeBegin';
	HSCols[90].name          := 'PriorityHottimeEnd';
	HSCols[91].name          := 'Prod. Comment';
	HSCols[92].name          := 'UsePressTowerInfo';
	HSCols[93].name          := 'OrderNumber';
	HSCols[94].name          := 'InkComment';
  HSCols[95].name          := 'FTP';
  HSCols[96].name          := 'Preflight';
  HSCols[97].name          := 'RIP';
  HSCols[98].name          := 'Color message';
  HSCols[99].name          := 'Planname';
  HSCols[100].name          := 'Presssystem';
  HSCols[101].name          := 'Plantype';
  HSCols[102].name          := 'TimedEditionFrom';
  HSCols[103].name          := 'TimedEditionTo';
  HSCols[104].name          := 'TimedEditionState';
  HSCols[105].name          := 'FromZone';
  HSCols[106].name          := 'ToZone';
  HSCols[107].name          := 'Circulation';
  HSCols[108].name          := 'Circulation2';
  HSCols[109].name          := 'Comment2';
  HSCols[110].name          := 'Show crop';
  HSCols[111].name          := 'prMiscint2';
  HSCols[112].name          := 'prMiscstring1';
  HSCols[113].name          := 'prMiscstring2';
  HSCols[114].name          := 'prMiscdate';
//  HSCols[115].name          := 'Devicegroupe';
  HSCols[116].name          := 'prMiscstring3';

	HSCols[ 0].field          := 'p1.Status';
	HSCols[ 1].field          := 'p1.ExternalStatus';
	HSCols[ 2].field          := 'p1.PublicationID';
	HSCols[ 3].field          := 'p1.SectionID';
	HSCols[ 4].field          := 'p1.EditionID';
	HSCols[ 5].field          := 'p1.IssueID';
	HSCols[ 6].field          := 'p1.PubDate';
	HSCols[ 7].field          := 'p1.PageName';
	HSCols[ 8].field          := 'p1.colorid';
	HSCols[ 9].field          := 'p1.TemplateID';
	HSCols[10].field          := 'p1.ProofID';
	HSCols[11].field          := 'p1.DeviceID';
	HSCols[12].field          := 'p1.Version';
	HSCols[13].field          := 'p1.Layer';
	HSCols[14].field          := 'p1.CopyNumber';
	HSCols[15].field          := 'p1.Pagination';
	HSCols[16].field          := 'p1.Approved';
	HSCols[17].field          := 'p1.Hold';
	HSCols[18].field          := 'p1.Active';
	HSCols[19].field          := 'p1.Priority';
	HSCols[20].field          := 'p1.PagePosition';
	HSCols[21].field          := 'p1.PageType';
	HSCols[22].field          := 'p1.PagesOnPlate';
	HSCols[23].field          := 'p1.SheetNumber';
	HSCols[24].field          := 'p1.SheetSide';
	HSCols[25].field          := 'p1.PressID';
	HSCols[26].field          := 'p1.PressSectionNumber';
	HSCols[27].field          := 'p1.SortingPosition';
	HSCols[28].field          := 'p1.PressTower';
	HSCols[29].field          := 'p1.PressCylinder';
	HSCols[30].field          := 'p1.PressZone';
	HSCols[31].field          := 'p1.PressHighLow';
	HSCols[32].field          := 'p1.ProductionID';
	HSCols[33].field          := 'p1.PressRunID';
	HSCols[34].field          := 'p1.ProofStatus';
	HSCols[35].field          := 'p1.InkStatus';
	HSCols[36].field          := 'p1.PlanPageName';
	HSCols[37].field          := 'p1.IssueSequenceNumber';
	HSCols[38].field          := 'p1.UniquePage';
	HSCols[39].field          := 'p1.LocationID';
	HSCols[40].field          := 'p1.FlatProofConfigurationID';
	HSCols[41].field          := 'p1.FlatProofStatus';
	HSCols[42].field          := 'p1.Creep';
	HSCols[43].field          := 'p1.MarkGroups';
	HSCols[44].field          := 'p1.PageIndex';
	HSCols[45].field          := 'p1.GutterImage';
	HSCols[46].field          := 'p1.Outputversion';
	HSCols[47].field          := 'p1.HardProofConfigurationID';
	HSCols[48].field          := 'p1.HardProofStatus';
	HSCols[49].field          := 'p1.FileServer';
	HSCols[50].field          := 'p1.Dirty';
	HSCols[51].field          := 'p1.InputTime';
	HSCols[52].field          := 'p1.ApproveTime';
	HSCols[53].field          := 'p1.ReadyTime';
	HSCols[54].field          := 'p1.OutputTime';
	HSCols[55].field          := 'p1.VerifyTime';
	HSCols[56].field          := 'p1.ApproveUser';
	HSCols[57].field          := 'p1.FileName';
	HSCols[58].field          := 'p1.LastError';
	HSCols[59].field          := 'p1.Comment';
	HSCols[60].field          := 'p1.DeadLine';
	HSCols[61].field          := 'p1.InputID';
	HSCols[62].field          := 'p1.PagePositions';
	HSCols[63].field          := 'p1.InputProcessID';
	HSCols[64].field          := 'p1.SoftProofProcessID';
	HSCols[65].field          := 'p1.HardProofProcessID';
	HSCols[66].field          := 'p1.TransmitProcessID';
	HSCols[67].field          := 'p1.ImagingProcessID';
	HSCols[68].field          := 'p1.InkProcessID';
	HSCols[69].field          := 'p1.OutputPriority';
	HSCols[70].field          := 'p1.PressTime';
	HSCols[71].field          := 'p1.CustomerID';
	HSCols[72].field          := 'p1.EmailStatus';
	HSCols[73].field          := 'p1.Miscint1';
	HSCols[74].field          := 'p1.Miscint2';
	HSCols[75].field          := 'p1.Miscint3';
	HSCols[76].field          := 'p1.Miscint4';
	HSCols[77].field          := 'p1.Miscstring1';
	HSCols[78].field          := 'p1.Miscstring2';
	HSCols[79].field          := 'p1.Miscstring3';
	HSCols[80].field          := 'p1.Miscdate';
  HSCols[81].field          := 'pr.SequenceNumber';
	HSCols[82].field          := 'pr.Deadline1';
	HSCols[83].field          := 'pr.Deadline2';
	HSCols[84].field          := 'pr.Deadline3';
	HSCols[85].field          := 'pr.Deadline4';
	HSCols[86].field          := 'pr.PriorityBeforeHottime';
	HSCols[87].field          := 'pr.PriorityDuringHottime';
	HSCols[88].field          := 'pr.PriorityAfterHottime';
	HSCols[89].field          := 'pr.PriorityHottimeBegin';
	HSCols[90].field          := 'pr.PriorityHottimeEnd';
	HSCols[91].field          := 'pr.Comment';
	HSCols[92].field          := 'pr.UsePressTowerInfo';
	HSCols[93].field          := 'pr.OrderNumber';
	HSCols[94].field          := 'pr.InkComment';
  HSCols[95].field          := ''''+'FTP'+'''';
  HSCols[96].field          := ''''+'Preflight'+'''';
  HSCols[97].field          := ''''+'RIP'+'''';
  HSCols[98].field          := ''''+'Color'+'''';

  HSCols[99].field          := 'pr.Planname';
  HSCols[100].field          := 'pr.Presssystem';
  HSCols[101].field          := 'pr.Plantype';
  HSCols[102].field          := 'pr.TimedEditionFrom';
  HSCols[103].field          := 'pr.TimedEditionTo';
  HSCols[104].field          := 'pr.TimedEditionState';
  HSCols[105].field          := 'pr.FromZone';
  HSCols[106].field          := 'pr.ToZone';
  HSCols[107].field          := 'pr.Circulation';
  HSCols[108].field          := 'pr.Circulation2';
  HSCols[109].field          := 'pr.Comment2';
  HSCols[110].field          := 'pr.Miscint1';
  HSCols[111].field          := 'pr.Miscint2';
  HSCols[112].field          := 'pr.Miscstring1';
  HSCols[113].field          := 'pr.Miscstring2';
  HSCols[114].field          := 'pr.Miscdate';
//  HSCols[115].field          := 'p1.DeviceGroupID';
  HSCols[116].field          := 'pr.Miscstring3';

  HSCols[ 0].inorder          := true;  // 'Status';
	HSCols[ 1].inorder          := true;  // 'ExternalStatus';
	HSCols[ 2].inorder          := false;  // 'PublicationID';
	HSCols[ 3].inorder          := false;  // 'SectionID';
	HSCols[ 4].inorder          := false;  // 'EditionID';
	HSCols[ 5].inorder          := false;  // 'IssueID';
	HSCols[ 6].inorder          := true;  // 'PubDate';
	HSCols[ 7].inorder          := true;  // 'PageName';
	HSCols[ 8].inorder          := true;  // 'ColorID';
	HSCols[ 9].inorder          := true;  // 'TemplateID';
	HSCols[10].inorder          := false;  // 'ProofID';
	HSCols[11].inorder          := false;  // 'DeviceID';
	HSCols[12].inorder          := true;  // 'Version';
	HSCols[13].inorder          := true;  // 'Layer';
	HSCols[14].inorder          := true;  // 'CopyNumber';
	HSCols[15].inorder          := true;  // 'Pagination';
	HSCols[16].inorder          := true;  // 'Approved';
	HSCols[17].inorder          := true;  // 'Hold';
	HSCols[18].inorder          := true;  // 'Active';
	HSCols[19].inorder          := true;  // 'Priority';
	HSCols[20].inorder          := true;  // 'PagePosition';
	HSCols[21].inorder          := true;  // 'PageType';
	HSCols[22].inorder          := true;  // 'PagesOnPlate';
	HSCols[23].inorder          := true;  // 'SheetNumber';
	HSCols[24].inorder          := true;  // 'SheetSide';
	HSCols[25].inorder          := false;  // 'PressID';
	HSCols[26].inorder          := true;  // 'PressSectionNumber';
	HSCols[27].inorder          := true;  // 'SortingPosition';
	HSCols[28].inorder          := true;  // 'PressTower';
	HSCols[29].inorder          := true;  // 'PressCylinder';
	HSCols[30].inorder          := true;  // 'PressZone';
	HSCols[31].inorder          := true;  // 'PressHighLow';
	HSCols[32].inorder          := true;  // 'ProductionID';
	HSCols[33].inorder          := true;  // 'PressRunID';
	HSCols[34].inorder          := true;  // 'ProofStatus';
	HSCols[35].inorder          := true;  // 'InkStatus';
	HSCols[36].inorder          := true;  // 'PlanPageName';
	HSCols[37].inorder          := true;  // 'IssueSequenceNumber';
	HSCols[38].inorder          := true;  // 'UniquePage';
	HSCols[39].inorder          := false;  // 'LocationID';
	HSCols[40].inorder          := false;  // 'FlatProofConfigurationID';
	HSCols[41].inorder          := true;  // 'FlatProofStatus';
	HSCols[42].inorder          := true;  // 'Creep';
	HSCols[43].inorder          := true;  // 'MarkGroups';
	HSCols[44].inorder          := true;  // 'PageIndex';
	HSCols[45].inorder          := true;  // 'GutterImage';
	HSCols[46].inorder          := true;  // 'Outputversion';
	HSCols[47].inorder          := false;  // 'HardProofConfigurationID';
	HSCols[48].inorder          := true;  // 'HardProofStatus';
	HSCols[49].inorder          := true;  // 'FileServer';
	HSCols[50].inorder          := true;  // 'Dirty';
	HSCols[51].inorder          := true;  // 'InputTime';
	HSCols[52].inorder          := true;  // 'ApproveTime';
	HSCols[53].inorder          := true;  // 'ReadyTime';
	HSCols[54].inorder          := true;  // 'OutputTime';
	HSCols[55].inorder          := true;  // 'VerifyTime';
	HSCols[56].inorder          := true;  // 'ApproveUser';
	HSCols[57].inorder          := true;  // 'FileName';
	HSCols[58].inorder          := true;  // 'LastError';
	HSCols[59].inorder          := true;  // 'Comment';
	HSCols[60].inorder          := true;  // 'DeadLine';
	HSCols[61].inorder          := true;  // 'InputID';
	HSCols[62].inorder          := true;  // 'PagePositions';
	HSCols[63].inorder          := true;  // 'InputProcessID';
	HSCols[64].inorder          := true;  // 'SoftProofProcessID';
	HSCols[65].inorder          := true;  // 'HardProofProcessID';
	HSCols[66].inorder          := true;  // 'TransmitProcessID';
	HSCols[67].inorder          := true;  // 'ImagingProcessID';
	HSCols[68].inorder          := true;  // 'InkProcessID';
	HSCols[69].inorder          := true;  // 'OutputPriority';
	HSCols[70].inorder          := true;  // 'PressTime';
	HSCols[71].inorder          := false;  // 'CustomerID';
	HSCols[72].inorder          := true;  // 'EmailStatus';
	HSCols[73].inorder          := true;  // 'Miscint1';
	HSCols[74].inorder          := true;  // 'Miscint2';
	HSCols[75].inorder          := true;  // 'Miscint3';
	HSCols[76].inorder          := true;  // 'Miscint4';
	HSCols[77].inorder          := true;  // 'Miscstring1';
	HSCols[78].inorder          := true;  // 'Miscstring2';
	HSCols[79].inorder          := true;  // 'Miscstring3';
	HSCols[80].inorder          := true;  // 'Miscdate';
  HSCols[81].inorder          := false;// 'pr.SequenceNumber';
	HSCols[82].inorder          := false;// 'pr.Deadline1';
	HSCols[83].inorder          := false;// 'pr.Deadline2';
	HSCols[84].inorder          := false;// 'pr.Deadline3';
	HSCols[85].inorder          := false;// 'pr.Deadline4';
	HSCols[86].inorder          := false;// 'pr.PriorityBeforeHottime';
	HSCols[87].inorder          := false;// 'pr.PriorityDuringHottime';
	HSCols[88].inorder          := false;// 'pr.PriorityAfterHottime';
	HSCols[89].inorder          := false;// 'pr.PriorityHottimeBegin';
	HSCols[90].inorder          := false;// 'pr.PriorityHottimeEnd';
	HSCols[91].inorder          := false;// 'pr.Comment';
	HSCols[92].inorder          := false;// 'pr.UsePressTowerInfo';
	HSCols[93].inorder          := false;// 'pr.OrderNumber';
	HSCols[94].inorder          := false;// 'pr.InkComment';
  HSCols[95].inorder          := false;//          := 'e.FTP';
  HSCols[96].inorder          := false;//         := 'e.Preflight';
  HSCols[97].inorder          := false;//          := 'e.RIP';
  HSCols[98].inorder          := false;//          := 'e.Color';
  HSCols[99].inorder := false;
  HSCols[00].inorder := false;
  HSCols[01].inorder := false;
  HSCols[02].inorder := false;
  HSCols[03].inorder := false;
  HSCols[104].inorder := false;
  HSCols[105].inorder := false;
  HSCols[106].inorder := false;
  HSCols[107].inorder := false;
  HSCols[108].inorder := false;
  HSCols[109].inorder := false;
  HSCols[110].inorder := false;
  HSCols[111].inorder := false;
  HSCols[112].inorder := false;
  HSCols[113].inorder := false;
  HSCols[114].inorder := false;
//  HSCols[115].inorder := false;
  HSCols[ 0].kind          := 5;
	HSCols[ 1].kind          := 20;
	HSCols[ 2].kind          := 1;
	HSCols[ 3].kind          := 1;
	HSCols[ 4].kind          := 1;
	HSCols[ 5].kind          := 1;
	HSCols[ 6].kind          := 3;
	HSCols[ 7].kind          := 17;
	HSCols[ 8].kind          := 13;
	HSCols[ 9].kind          := 1;
	HSCols[10].kind          := 1;
	HSCols[11].kind          := 1;
	HSCols[12].kind          := 1;
	HSCols[13].kind          := 1;
	HSCols[14].kind          := 1;
	HSCols[15].kind          := 0;
	HSCols[16].kind          := 9;
	HSCols[17].kind          := 14;
	HSCols[18].kind          := 2;
	HSCols[19].kind          := 0;
	HSCols[20].kind          := 0;
	HSCols[21].kind          := 1;
	HSCols[22].kind          := 0;
	HSCols[23].kind          := 0;
	HSCols[24].kind          := 1;
	HSCols[25].kind          := 1;
	HSCols[26].kind          := 0;
	HSCols[27].kind          := 1;
	HSCols[28].kind          := 1;
	HSCols[29].kind          := 1;
	HSCols[30].kind          := 1;
	HSCols[31].kind          := 1;
	HSCols[32].kind          := 1;
	HSCols[33].kind          := 0;
	HSCols[34].kind          := 21;
	HSCols[35].kind          := 25;
	HSCols[36].kind          := 1;
	HSCols[37].kind          := 0;
	HSCols[38].kind          := 16;
	HSCols[39].kind          := 1;
	HSCols[40].kind          := 1;
	HSCols[41].kind          := 1;
	HSCols[42].kind          := 22;
	HSCols[43].kind          := 1;
	HSCols[44].kind          := 0;
	HSCols[45].kind          := 1;
	HSCols[46].kind          := 0;
	HSCols[47].kind          := 1;
	HSCols[48].kind          := 1;
	HSCols[49].kind          := 1;
	HSCols[50].kind          := 1;
	HSCols[51].kind          := 4;
	HSCols[52].kind          := 4;
	HSCols[53].kind          := 4;
	HSCols[54].kind          := 4;
	HSCols[55].kind          := 4;
	HSCols[56].kind          := 1;
	HSCols[57].kind          := 1;
	HSCols[58].kind          := 1;
	HSCols[59].kind          := 1;
	HSCols[60].kind          := 4;
	HSCols[61].kind          := 1;
	HSCols[62].kind          := 1;
	HSCols[63].kind          := 1;
	HSCols[64].kind          := 1;
	HSCols[65].kind          := 1;
	HSCols[66].kind          := 1;
	HSCols[67].kind          := 1;
	HSCols[68].kind          := 1;
	HSCols[69].kind          := 0;
	HSCols[70].kind          := 3;
	HSCols[71].kind          := 1;
	HSCols[72].kind          := 1;
	HSCols[73].kind          := 0;
	HSCols[74].kind          := 0;
	HSCols[75].kind          := 0;
	HSCols[76].kind          := 0;
	HSCols[77].kind          := 1;
	HSCols[78].kind          := 1;
	HSCols[79].kind          := 1;
	HSCols[80].kind          := 4;
             //0 Integer 1 string 2 Yesno 3 date 4 tid 5 status 6 device 7 template 20 external status
  HSCols[81].kind          := 1;// 'pr.SequenceNumber';
	HSCols[82].kind          := 1;// 'pr.Deadline1';
	HSCols[83].kind          := 1;// 'pr.Deadline2';
	HSCols[84].kind          := 1;// 'pr.Deadline3';
	HSCols[85].kind          := 1;// 'pr.Deadline4';
	HSCols[86].kind          := 1;// 'pr.PriorityBeforeHottime';
	HSCols[87].kind          := 1;// 'pr.PriorityDuringHottime';
	HSCols[88].kind          := 1;// 'pr.PriorityAfterHottime';
	HSCols[89].kind          := 1;// 'pr.PriorityHottimeBegin';
	HSCols[90].kind          := 1;// 'pr.PriorityHottimeEnd';
	HSCols[91].kind          := 1;// 'pr.Comment';
	HSCols[92].kind          := 1;// 'pr.UsePressTowerInfo';
	HSCols[93].kind          := 1;// 'pr.OrderNumber';
	HSCols[94].kind          := 1;// 'pr.InkComment';
  HSCols[95].kind          := 1;//          := 'e.FTP';
  HSCols[96].kind          := 1;//         := 'e.Preflight';
  HSCols[97].kind          := 1;//          := 'e.RIP';
  HSCols[98].kind          := 1;//          := 'e.Color';
  HSCols[99].kind          := 1; //'pr.Planname';
  HSCols[100].kind          := 1; //'pr.Presssystem';
  HSCols[101].kind          := 1; //'pr.Plantype';
  HSCols[102].kind          := 1; //'pr.TimedEdition'from
  HSCols[103].kind          := 1; //'pr.TimedEdition'to
  HSCols[104].kind          := 1; //'pr.TimedEditionState';
  HSCols[105].kind          := 1; //'pr.FromZone';
  HSCols[106].kind          := 1; //'pr.ToZone';
  HSCols[107].kind          := 1; //'pr.Circulation';
  HSCols[108].kind          := 1; //'pr.Circulation2';
  HSCols[109].kind          := 1; //'pr.Comment2';
  HSCols[110].kind          := 1; //'pr.Miscint1';
  HSCols[111].kind          := 1; //'pr.Miscint2';
  HSCols[112].kind          := 1; //'pr.Miscstring1';
  HSCols[113].kind          := 1; //'pr.Miscstring2';
  HSCols[114].kind          := 1; //'pr.Miscdate';
//  HSCols[115].kind          := 0; //devicegrp
  HSCols[116].kind          := 2; //'pr.Miscstring3';
  HSCols[35].mandatory := true;
  HSCols[8].mandatory := true;
  HSCols[0].mandatory := true;
  HSCols[1].mandatory := true;
  HSCols[16].mandatory := true;
  HSCols[17].mandatory := true;
  HSCols[18].mandatory := true;
  HSCols[38].mandatory := true;
  HSCols[23].mandatory := true;
  HSCols[32].mandatory := true;
  HSCols[5].mandatory := true;
  HSCols[2].mandatory := true;
  HSCols[3].mandatory := true;
  HSCols[4].mandatory := true;
  HSCols[39].mandatory := true;
  HSCols[9].mandatory := true;
  HSCols[11].mandatory := true;
  HSCols[10].mandatory := true;
  HSCols[40].mandatory := true;
  HSCols[47].mandatory := true;
  HSCols[71].mandatory := true;
  HSCols[95].mandatory := false;
  HSCols[96].mandatory := false;
  HSCols[97].mandatory := false;
  HSCols[98].mandatory := false;
  HSCols[99].mandatory := false;
  HSCols[100].mandatory := false;
  HSCols[101].mandatory := false;
  HSCols[102].mandatory := false;
  HSCols[103].mandatory := false;
  HSCols[104].mandatory := false;
  HSCols[105].mandatory := false;
  HSCols[106].mandatory := false;
  HSCols[107].mandatory := false;
  HSCols[108].mandatory := false;
  HSCols[109].mandatory := false;
  for i := 0 to 200 do
  Begin
    HSOrder[i] := i;
    HSCols[i].fieldpos := 0;
  end;
  HSOrder[0] :=4;
  HSOrder[1] :=3;
  HSOrder[2] :=7;
  HSOrder[3] :=14;
  HSOrder[4] :=8;
  HSOrder[5] :=0;
  HSOrder[6] :=16;
  HSOrder[7] :=17;
  HSOrder[8] :=12;
  HSOrder[9] :=19;
  HSOrder[10] :=9;
  HSOrder[11] :=11;
  HSOrder[12] :=10;
  HSOrder[13] :=15;
  HSOrder[14] :=21;
  HSOrder[15] :=20;
  HSOrder[16] :=1;
  HSOrder[17] :=38;
  HSOrder[18] :=23;
  HSOrder[19] :=24;
  HSOrder[20] :=42;
  HSOrder[21] :=51;
  HSOrder[22] :=52;
  HSOrder[23] :=53;
  HSOrder[24] :=54;
  HSOrder[25] :=55;
  HSOrder[26] :=56;
  HSOrder[27] :=59;
  HSOrder[28] :=39;
  HSOrder[29] :=25;
  HSOrder[30] :=71;
  HSOrder[31] :=32;
  HSOrder[32] :=34;
  HSOrder[33] :=35;
  HSOrder[34] :=70;
  HSOrder[35] :=26;
  HSOrder[36] :=69;
  HSOrder[37] :=46;
  HSOrder[38] :=43;
  HSOrder[39] :=27;
  HSOrder[40] :=60;
  HSOrder[41] :=28;
  HSOrder[42] :=29;
  HSOrder[43] :=30;
  HSOrder[44] :=31;
  HSOrder[45] :=36;
  HSOrder[46] :=18;
  HSOrder[47] :=22;
  HSOrder[48] :=33;
  HSOrder[49] :=47;
  HSOrder[50] :=48;
  HSOrder[51] :=40;
  HSOrder[52] :=41;
  HSOrder[53] :=45;
  HSOrder[54] :=57;
  HSOrder[55] :=6;
  HSOrder[56] :=2;
  HSOrder[57] :=5;
  HSOrder[58] :=13;
  HSOrder[59] :=37;
  HSOrder[60] :=44;
  HSOrder[61] :=49;
  HSOrder[62] :=50;
  HSOrder[63] :=58;
  HSOrder[64] :=61;
  HSOrder[65] :=62;
  HSOrder[66] :=63;
  HSOrder[67] :=64;
  HSOrder[68] :=65;
  HSOrder[69] :=66;
  HSOrder[70] :=67;
  HSOrder[71] :=68;
  HSOrder[72] :=72;
  HSOrder[73] :=73;
  HSOrder[74] :=74;
  HSOrder[75] :=75;
  HSOrder[76] :=76;
  HSOrder[77] :=77;
  HSOrder[78] :=78;
  HSOrder[79] :=79;
  HSOrder[80] :=80;
  HSOrder[81] :=81;
  HSOrder[82] :=82;
  HSOrder[83] :=83;
  HSOrder[84] :=84;
  HSOrder[85] :=85;
  HSOrder[86] :=86;
  HSOrder[87] :=87;
  HSOrder[88] :=88;
  HSOrder[89] :=89;
  HSOrder[90] :=90;
  HSOrder[91] :=91;
  HSOrder[92] :=92;
  HSOrder[93] :=93;
  HSOrder[94] :=94;
  HSOrder[95] :=95;
  HSOrder[96] :=96;
  HSOrder[97] :=97;
  HSOrder[98] :=98;
  HSOrder[99] :=99;
  HSOrder[100] :=100;
  HSOrder[101] :=101;
  HSOrder[102] :=102;
  HSOrder[103] :=103;
  HSOrder[104] :=104;
  HSOrder[105] :=105;
  HSOrder[106] :=106;
  HSOrder[107] :=107;
  HSOrder[108] :=108;
  HSOrder[109] :=109;
  HSOrder[110] :=110;
  HSOrder[111] :=111;
  HSOrder[112] :=112;
  HSOrder[113] :=113;
  HSOrder[114] :=114;
  HSOrder[115] :=115;
  HSOrder[116] :=116;

  MAXColsortcount := 98;          // if SetplannameINpressrunID i activate data
  //HSCols[8].field := 'pagetable.colorid';
  For i := 1 to 109 do
    HSCols[i].name := formmain.InfraLanguage1.Translate(HSCols[i].name);
  inif := tinifile.Create(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory())+'DataListorder.ini');
  For i := 0 to 109 do
  Begin
    HSOrder[i] := inif.readinteger('Order',inttostr(I),HSOrder[i]);
    inif.writeinteger('Order',inttostr(I),HSOrder[i]);
    HSCols[i].Width := inif.readinteger('Width',inttostr(I),50);
    inif.writeinteger('Width',inttostr(I),HSCols[i].Width);
  End;
  For i := 0 to formmain.StringGridReport.ColCount-1 do
  Begin
    formmain.StringGridReport.ColWidths[i] := inif.readinteger('StringGridReport',inttostr(I),formmain.StringGridReport.ColWidths[i]);
  End;
  inif.Free;

  (*-1 indexnum  0 Integer 1 string 2 Yesno 3 date 4 tid 5 status 6 device
  7 template 8 extstatus 9 approval 10 frontback 11 highlow 12 markgrp 13 color 14 hold
  15 active 16 unique 17 ID, 18 deadlinetid ... 18 er ikke lavet endu
  *)

End;


Procedure writeMainlogfile(logline : String);
Var
  ErrorFile : TextFile;

Begin
  IF Prefs.debug then
  begin
    Try
     // plancentermainlog.BeginUpdate;
      //IF plancentermainlog.Count > 1000000 then
      //  plancentermainlog.clear;
     // plancentermainlog.add(datetimetostr(now) + ' : ' + logline);
     // plancentermainlog.EndUpdate;
      logline := DateTimeToStr(now) + ' : ' + logline +   Chr(13) + Chr(10);
      TFile.AppendAllText(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory())+'PlancenterMain.log', logline);
     // plancentermainlog.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory())+'PlancenterMain.log');

     //    plancentermainlog.SaveToFile('c:\temp\PlancenterMain.log');

    Except
      on E: Exception do
      Begin
        AssignFile(ErrorFile, 'Error.log');
        Append(ErrorFile);
        WriteLn(ErrorFile, 'Error: Try to write in PlancenterMain.log file with this text:' + logline);
        WriteLn(ErrorFile, 'Error message:' + E.Message );
        CloseFile(ErrorFile);
      end;
    End;
  end;
End;

Procedure Tinittypes.makehslist3;
Var
  I : Integer;
  inif : tinifile;
Begin
  For i := 0 to 200 do
  Begin
    HSOrder[i] := i;
    HSCols[i].tag := i;
    HSCols[i].iscaption := false;
    HSCols[i].Show := false;
    HSCols[i].width := 50;
    HSCols[i].ColX := i;
    HSCols[i].Mandatory := false;
  end;
	HSCols[ 0].name          := 'Status';
	HSCols[ 1].name          := 'ExternalStatus';
	HSCols[ 2].name          := 'Publication';
	HSCols[ 3].name          := 'Section';
	HSCols[ 4].name          := 'Edition';
	HSCols[ 5].name          := 'Issue';
	HSCols[ 6].name          := 'PubDate';
	HSCols[ 7].name          := 'PageName';
	HSCols[ 8].name          := 'Color';
	HSCols[ 9].name          := 'Layout';
	HSCols[10].name          := 'Prooftemplate';
	HSCols[11].name          := 'Device';
	HSCols[12].name          := 'Version';
	HSCols[13].name          := 'Layer';
	HSCols[14].name          := 'CopyNumber';
	HSCols[15].name          := 'Pagination';
	HSCols[16].name          := 'Approved';
	HSCols[17].name          := 'Hold';
	HSCols[18].name          := 'Active';
	HSCols[19].name          := 'Priority';
	HSCols[20].name          := 'PagePosition';
	HSCols[21].name          := 'PageType';
	HSCols[22].name          := 'PagesOnPlate';
	HSCols[23].name          := 'SheetNumber';
	HSCols[24].name          := 'SheetSide';
	HSCols[25].name          := 'Press';
	HSCols[26].name          := 'PressSectionNumber';
	HSCols[27].name          := 'SortingPosition';
	HSCols[28].name          := 'PressTower';
	HSCols[29].name          := 'PressCylinder';
	HSCols[30].name          := 'PressZone';
	HSCols[31].name          := 'PressHighLow';
	HSCols[32].name          := 'Production';
	HSCols[33].name          := 'PressRun';
	HSCols[34].name          := 'ProofStatus';
	HSCols[35].name          := 'InkStatus';
	HSCols[36].name          := 'PlanPageName';
	HSCols[37].name          := 'IssueSequenceNumber';
	HSCols[38].name          := 'UniquePage';
	HSCols[39].name          := 'Location';
	HSCols[40].name          := 'FlatProofConfiguration';
	HSCols[41].name          := 'FlatProofStatus';
	HSCols[42].name          := 'Creep';
	HSCols[43].name          := 'MarkGroups';
	HSCols[44].name          := 'PageIndex';
	HSCols[45].name          := 'GutterImage';
	HSCols[46].name          := 'Outputversion';
	HSCols[47].name          := 'HardProofConfiguration';
	HSCols[48].name          := 'HardProofStatus';
	HSCols[49].name          := 'FileServer';
	HSCols[50].name          := 'Dirty';
	HSCols[51].name          := 'InputTime';
	HSCols[52].name          := 'ApproveTime';
	HSCols[53].name          := 'ReadyTime';
	HSCols[54].name          := 'OutputTime';
	HSCols[55].name          := 'VerifyTime';
	HSCols[56].name          := 'ApproveUser';
	HSCols[57].name          := 'FileName';
	HSCols[58].name          := 'LastError';
	HSCols[59].name          := 'Comment';
	HSCols[60].name          := 'DeadLine';
	HSCols[61].name          := 'InputID';
	HSCols[62].name          := 'PagePositions';
	HSCols[63].name          := 'InputProcessID';
	HSCols[64].name          := 'SoftProofProcessID';
	HSCols[65].name          := 'HardProofProcessID';
	HSCols[66].name          := 'TransmitProcessID';
	HSCols[67].name          := 'ImagingProcessID';
	HSCols[68].name          := 'InkProcessID';
	HSCols[69].name          := 'OutputPriority';
	HSCols[70].name          := 'PressTime';
	HSCols[71].name          := 'Customer';
	HSCols[72].name          := 'EmailStatus';
	HSCols[73].name          := 'Extragutter';
	HSCols[74].name          := 'Week/Number';
	HSCols[75].name          := 'Miscint3';
	HSCols[76].name          := 'Miscint4';
	HSCols[77].name          := 'Plate number';
	HSCols[78].name          := 'Miscstring2';
	HSCols[79].name          := 'Miscstring3';
	HSCols[80].name          := 'Miscdate';
	HSCols[81].name          := 'SequenceNumber';
	HSCols[82].name          := 'Deadline1';
	HSCols[83].name          := 'Deadline2';
	HSCols[84].name          := 'Deadline3';
	HSCols[85].name          := 'Deadline4';
	HSCols[86].name          := 'PriorityBeforeHottime';
	HSCols[87].name          := 'PriorityDuringHottime';
	HSCols[88].name          := 'PriorityAfterHottime';
	HSCols[89].name          := 'PriorityHottimeBegin';
	HSCols[90].name          := 'PriorityHottimeEnd';
	HSCols[91].name          := 'Prod. Comment';
	HSCols[92].name          := 'UsePressTowerInfo';
	HSCols[93].name          := 'OrderNumber';
	HSCols[94].name          := 'InkComment';
  HSCols[95].name          := 'FTP';
  HSCols[96].name          := 'Preflight';
  HSCols[97].name          := 'RIP';
  HSCols[98].name          := 'Color message';
  HSCols[99].name          := 'Planname';
  HSCols[100].name          := 'Presssystem';
  HSCols[101].name          := 'Plantype';
  HSCols[102].name          := 'TimedEditionFrom';
  HSCols[103].name          := 'TimedEditionTo';
  HSCols[104].name          := 'TimedEditionState';
  HSCols[105].name          := 'FromZone';
  HSCols[106].name          := 'ToZone';
  HSCols[107].name          := 'Circulation';
  HSCols[108].name          := 'Circulation2';
  HSCols[109].name          := 'Comment2';
  HSCols[110].name          := 'Show crop';
  HSCols[111].name          := 'prMiscint2';
  HSCols[112].name          := 'prMiscstring1';
  HSCols[113].name          := 'prMiscstring2';
  HSCols[114].name          := 'prMiscdate';
  HSCols[115].name          := 'DeviceGroup';
  HSCols[116].name          := 'PlateStatus';
  HSCols[117].name          := 'PostOutputVersion';
  HSCols[118].name          := 'prMiscstring3';

	HSCols[ 0].field          := 'p1.Status';
	HSCols[ 1].field          := 'p1.ExternalStatus';
	HSCols[ 2].field          := 'p1.PublicationID';
	HSCols[ 3].field          := 'p1.SectionID';
	HSCols[ 4].field          := 'p1.EditionID';
	HSCols[ 5].field          := 'p1.IssueID';
	HSCols[ 6].field          := 'p1.PubDate';
	HSCols[ 7].field          := 'p1.PageName';
	HSCols[ 8].field          := 'p1.colorid';
	HSCols[ 9].field          := 'p1.TemplateID';
	HSCols[10].field          := 'p1.ProofID';
	HSCols[11].field          := 'p1.DeviceID';
	HSCols[12].field          := 'p1.Version';
	HSCols[13].field          := 'p1.Layer';
	HSCols[14].field          := 'p1.CopyNumber';
	HSCols[15].field          := 'p1.Pagination';
	HSCols[16].field          := 'p1.Approved';
	HSCols[17].field          := 'p1.Hold';
	HSCols[18].field          := 'p1.Active';
	HSCols[19].field          := 'p1.Priority';
	HSCols[20].field          := 'p1.PagePosition';
	HSCols[21].field          := 'p1.PageType';
	HSCols[22].field          := 'p1.PagesOnPlate';
	HSCols[23].field          := 'p1.SheetNumber';
	HSCols[24].field          := 'p1.SheetSide';
	HSCols[25].field          := 'p1.PressID';
	HSCols[26].field          := 'p1.PressSectionNumber';
	HSCols[27].field          := 'p1.SortingPosition';
	HSCols[28].field          := 'p1.PressTower';
	HSCols[29].field          := 'p1.PressCylinder';
	HSCols[30].field          := 'p1.PressZone';
	HSCols[31].field          := 'p1.PressHighLow';
	HSCols[32].field          := 'p1.ProductionID';
	HSCols[33].field          := 'p1.PressRunID';
	HSCols[34].field          := 'p1.ProofStatus';
	HSCols[35].field          := 'p1.InkStatus';
	HSCols[36].field          := 'p1.PlanPageName';
	HSCols[37].field          := 'p1.IssueSequenceNumber';
	HSCols[38].field          := 'p1.UniquePage';
	HSCols[39].field          := 'p1.LocationID';
	HSCols[40].field          := 'p1.FlatProofConfigurationID';
	HSCols[41].field          := 'p1.FlatProofStatus';
	HSCols[42].field          := 'p1.Creep';
	HSCols[43].field          := 'p1.MarkGroups';
	HSCols[44].field          := 'p1.PageIndex';
	HSCols[45].field          := 'p1.GutterImage';
	HSCols[46].field          := 'p1.Outputversion';
	HSCols[47].field          := 'p1.HardProofConfigurationID';
	HSCols[48].field          := 'p1.HardProofStatus';
	HSCols[49].field          := 'p1.FileServer';
	HSCols[50].field          := 'p1.Dirty';
	HSCols[51].field          := 'p1.InputTime';
	HSCols[52].field          := 'p1.ApproveTime';
	HSCols[53].field          := 'p1.ReadyTime';
	HSCols[54].field          := 'p1.OutputTime';
	HSCols[55].field          := 'p1.VerifyTime';
	HSCols[56].field          := 'p1.ApproveUser';
	HSCols[57].field          := 'p1.FileName';
	HSCols[58].field          := 'p1.LastError';
	HSCols[59].field          := 'p1.Comment';
	HSCols[60].field          := 'p1.DeadLine';
	HSCols[61].field          := 'p1.InputID';
	HSCols[62].field          := 'p1.PagePositions';
	HSCols[63].field          := 'p1.InputProcessID';
	HSCols[64].field          := 'p1.SoftProofProcessID';
	HSCols[65].field          := 'p1.HardProofProcessID';
	HSCols[66].field          := 'p1.TransmitProcessID';
	HSCols[67].field          := 'p1.ImagingProcessID';
	HSCols[68].field          := 'p1.InkProcessID';
	HSCols[69].field          := 'p1.OutputPriority';
	HSCols[70].field          := 'p1.PressTime';
	HSCols[71].field          := 'p1.CustomerID';
	HSCols[72].field          := 'p1.EmailStatus';
	HSCols[73].field          := 'p1.Miscint1';
	HSCols[74].field          := 'p1.Miscint2';
	HSCols[75].field          := 'p1.Miscint3';
	HSCols[76].field          := 'p1.Miscint4';
	HSCols[77].field          := 'p1.Miscstring1';
	HSCols[78].field          := 'p1.Miscstring2';
	HSCols[79].field          := 'p1.Miscstring3';
	HSCols[80].field          := 'p1.Miscdate';
  HSCols[81].field          := 'pr.SequenceNumber';
	HSCols[82].field          := 'pr.Deadline1';
	HSCols[83].field          := 'pr.Deadline2';
	HSCols[84].field          := 'pr.Deadline3';
	HSCols[85].field          := 'pr.Deadline4';
	HSCols[86].field          := 'pr.PriorityBeforeHottime';
	HSCols[87].field          := 'pr.PriorityDuringHottime';
	HSCols[88].field          := 'pr.PriorityAfterHottime';
	HSCols[89].field          := 'pr.PriorityHottimeBegin';
	HSCols[90].field          := 'pr.PriorityHottimeEnd';
	HSCols[91].field          := 'pr.Comment';
	HSCols[92].field          := 'pr.UsePressTowerInfo';
	HSCols[93].field          := 'pr.OrderNumber';
	HSCols[94].field          := 'pr.InkComment';
  HSCols[95].field          := ''''+'FTP'+'''';
  HSCols[96].field          := ''''+'Preflight'+'''';
  HSCols[97].field          := ''''+'RIP'+'''';
  HSCols[98].field          := ''''+'Color'+'''';

  HSCols[99].field          := 'pr.Planname';
  HSCols[100].field          := 'pr.Presssystem';
  HSCols[101].field          := 'pr.Plantype';
  HSCols[102].field          := 'pr.TimedEditionFrom';
  HSCols[103].field          := 'pr.TimedEditionTo';
  HSCols[104].field          := 'pr.TimedEditionState';
  HSCols[105].field          := 'pr.FromZone';
  HSCols[106].field          := 'pr.ToZone';
  HSCols[107].field          := 'pr.Circulation';
  HSCols[108].field          := 'pr.Circulation2';
  HSCols[109].field          := 'pr.Comment2';
  HSCols[110].field          := 'pr.Miscint1';
  HSCols[111].field          := 'pr.Miscint2';
  HSCols[112].field          := 'pr.Miscstring1';
  HSCols[113].field          := 'pr.Miscstring2';
  HSCols[114].field          := 'pr.Miscdate';
  HSCols[115].field          := 'p1.DeviceGroupID';
  HSCols[116].field          := 'p1.PlateStatus';
  HSCols[117].field          := 'p1.PostOutputVersion';
  HSCols[118].field          := 'pr.Miscstring3';

  HSCols[ 0].inorder          := true;  // 'Status';
	HSCols[ 1].inorder          := true;  // 'ExternalStatus';
	HSCols[ 2].inorder          := false;  // 'PublicationID';
	HSCols[ 3].inorder          := false;  // 'SectionID';
	HSCols[ 4].inorder          := false;  // 'EditionID';
	HSCols[ 5].inorder          := false;  // 'IssueID';
	HSCols[ 6].inorder          := true;  // 'PubDate';
	HSCols[ 7].inorder          := true;  // 'PageName';
	HSCols[ 8].inorder          := true;  // 'ColorID';
	HSCols[ 9].inorder          := true;  // 'TemplateID';
	HSCols[10].inorder          := false;  // 'ProofID';
	HSCols[11].inorder          := false;  // 'DeviceID';
	HSCols[12].inorder          := true;  // 'Version';
	HSCols[13].inorder          := true;  // 'Layer';
	HSCols[14].inorder          := true;  // 'CopyNumber';
	HSCols[15].inorder          := true;  // 'Pagination';
	HSCols[16].inorder          := true;  // 'Approved';
	HSCols[17].inorder          := true;  // 'Hold';
	HSCols[18].inorder          := true;  // 'Active';
	HSCols[19].inorder          := true;  // 'Priority';
	HSCols[20].inorder          := true;  // 'PagePosition';
	HSCols[21].inorder          := true;  // 'PageType';
	HSCols[22].inorder          := true;  // 'PagesOnPlate';
	HSCols[23].inorder          := true;  // 'SheetNumber';
	HSCols[24].inorder          := true;  // 'SheetSide';
	HSCols[25].inorder          := false;  // 'PressID';
	HSCols[26].inorder          := true;  // 'PressSectionNumber';
	HSCols[27].inorder          := true;  // 'SortingPosition';
	HSCols[28].inorder          := true;  // 'PressTower';
	HSCols[29].inorder          := true;  // 'PressCylinder';
	HSCols[30].inorder          := true;  // 'PressZone';
	HSCols[31].inorder          := true;  // 'PressHighLow';
	HSCols[32].inorder          := true;  // 'ProductionID';
	HSCols[33].inorder          := true;  // 'PressRunID';
	HSCols[34].inorder          := true;  // 'ProofStatus';
	HSCols[35].inorder          := true;  // 'InkStatus';
	HSCols[36].inorder          := true;  // 'PlanPageName';
	HSCols[37].inorder          := true;  // 'IssueSequenceNumber';
	HSCols[38].inorder          := true;  // 'UniquePage';
	HSCols[39].inorder          := false;  // 'LocationID';
	HSCols[40].inorder          := false;  // 'FlatProofConfigurationID';
	HSCols[41].inorder          := true;  // 'FlatProofStatus';
	HSCols[42].inorder          := true;  // 'Creep';
	HSCols[43].inorder          := true;  // 'MarkGroups';
	HSCols[44].inorder          := true;  // 'PageIndex';
	HSCols[45].inorder          := true;  // 'GutterImage';
	HSCols[46].inorder          := true;  // 'Outputversion';
	HSCols[47].inorder          := false;  // 'HardProofConfigurationID';
	HSCols[48].inorder          := true;  // 'HardProofStatus';
	HSCols[49].inorder          := true;  // 'FileServer';
	HSCols[50].inorder          := true;  // 'Dirty';
	HSCols[51].inorder          := true;  // 'InputTime';
	HSCols[52].inorder          := true;  // 'ApproveTime';
	HSCols[53].inorder          := true;  // 'ReadyTime';
	HSCols[54].inorder          := true;  // 'OutputTime';
	HSCols[55].inorder          := true;  // 'VerifyTime';
	HSCols[56].inorder          := true;  // 'ApproveUser';
	HSCols[57].inorder          := true;  // 'FileName';
	HSCols[58].inorder          := true;  // 'LastError';
	HSCols[59].inorder          := true;  // 'Comment';
	HSCols[60].inorder          := true;  // 'DeadLine';
	HSCols[61].inorder          := true;  // 'InputID';
	HSCols[62].inorder          := true;  // 'PagePositions';
	HSCols[63].inorder          := true;  // 'InputProcessID';
	HSCols[64].inorder          := true;  // 'SoftProofProcessID';
	HSCols[65].inorder          := true;  // 'HardProofProcessID';
	HSCols[66].inorder          := true;  // 'TransmitProcessID';
	HSCols[67].inorder          := true;  // 'ImagingProcessID';
	HSCols[68].inorder          := true;  // 'InkProcessID';
	HSCols[69].inorder          := true;  // 'OutputPriority';
	HSCols[70].inorder          := true;  // 'PressTime';
	HSCols[71].inorder          := false;  // 'CustomerID';
	HSCols[72].inorder          := true;  // 'EmailStatus';
	HSCols[73].inorder          := true;  // 'Miscint1';
	HSCols[74].inorder          := true;  // 'Miscint2';
	HSCols[75].inorder          := true;  // 'Miscint3';
	HSCols[76].inorder          := true;  // 'Miscint4';
	HSCols[77].inorder          := true;  // 'Miscstring1';
	HSCols[78].inorder          := true;  // 'Miscstring2';
	HSCols[79].inorder          := true;  // 'Miscstring3';
	HSCols[80].inorder          := true;  // 'Miscdate';
  HSCols[81].inorder          := false;// 'pr.SequenceNumber';
	HSCols[82].inorder          := false;// 'pr.Deadline1';
	HSCols[83].inorder          := false;// 'pr.Deadline2';
	HSCols[84].inorder          := false;// 'pr.Deadline3';
	HSCols[85].inorder          := false;// 'pr.Deadline4';
	HSCols[86].inorder          := false;// 'pr.PriorityBeforeHottime';
	HSCols[87].inorder          := false;// 'pr.PriorityDuringHottime';
	HSCols[88].inorder          := false;// 'pr.PriorityAfterHottime';
	HSCols[89].inorder          := false;// 'pr.PriorityHottimeBegin';
	HSCols[90].inorder          := false;// 'pr.PriorityHottimeEnd';
	HSCols[91].inorder          := false;// 'pr.Comment';
	HSCols[92].inorder          := false;// 'pr.UsePressTowerInfo';
	HSCols[93].inorder          := false;// 'pr.OrderNumber';
	HSCols[94].inorder          := false;// 'pr.InkComment';
  HSCols[95].inorder          := false;//          := 'e.FTP';
  HSCols[96].inorder          := false;//         := 'e.Preflight';
  HSCols[97].inorder          := false;//          := 'e.RIP';
  HSCols[98].inorder          := false;//          := 'e.Color';
  HSCols[99].inorder := false;
  HSCols[00].inorder := false;
  HSCols[01].inorder := false;
  HSCols[02].inorder := false;
  HSCols[03].inorder := false;
  HSCols[104].inorder := false;
  HSCols[105].inorder := false;
  HSCols[106].inorder := false;
  HSCols[107].inorder := false;
  HSCols[108].inorder := false;
  HSCols[109].inorder := false;
  HSCols[110].inorder := false;
  HSCols[111].inorder := false;
  HSCols[112].inorder := false;
  HSCols[113].inorder := false;
  HSCols[114].inorder := false;
  HSCols[115].inorder := true;
  HSCols[116].inorder := true;
  HSCols[117].inorder := true;

  HSCols[ 0].kind          := 5;
	HSCols[ 1].kind          := 20;
	HSCols[ 2].kind          := 1;
	HSCols[ 3].kind          := 1;
	HSCols[ 4].kind          := 1;
	HSCols[ 5].kind          := 1;
	HSCols[ 6].kind          := 3;
	HSCols[ 7].kind          := 17;
	HSCols[ 8].kind          := 13;
	HSCols[ 9].kind          := 1;
	HSCols[10].kind          := 1;
	HSCols[11].kind          := 1;
	HSCols[12].kind          := 1;
	HSCols[13].kind          := 1;
	HSCols[14].kind          := 1;
	HSCols[15].kind          := 0;
	HSCols[16].kind          := 9;
	HSCols[17].kind          := 14;
	HSCols[18].kind          := 2;
	HSCols[19].kind          := 0;
	HSCols[20].kind          := 0;
	HSCols[21].kind          := 1;
	HSCols[22].kind          := 0;
	HSCols[23].kind          := 0;
	HSCols[24].kind          := 1;
	HSCols[25].kind          := 1;
	HSCols[26].kind          := 0;
	HSCols[27].kind          := 1;
	HSCols[28].kind          := 1;
	HSCols[29].kind          := 1;
	HSCols[30].kind          := 1;
	HSCols[31].kind          := 1;
	HSCols[32].kind          := 1;
	HSCols[33].kind          := 0;
	HSCols[34].kind          := 21;
	HSCols[35].kind          := 25;
	HSCols[36].kind          := 1;
	HSCols[37].kind          := 0;
	HSCols[38].kind          := 16;
	HSCols[39].kind          := 1;
	HSCols[40].kind          := 1;
	HSCols[41].kind          := 1;
	HSCols[42].kind          := 22;
	HSCols[43].kind          := 1;
	HSCols[44].kind          := 0;
	HSCols[45].kind          := 1;
	HSCols[46].kind          := 0;
	HSCols[47].kind          := 1;
	HSCols[48].kind          := 1;
	HSCols[49].kind          := 1;
	HSCols[50].kind          := 1;
	HSCols[51].kind          := 4;
	HSCols[52].kind          := 4;
	HSCols[53].kind          := 4;
	HSCols[54].kind          := 4;
	HSCols[55].kind          := 4;
	HSCols[56].kind          := 1;
	HSCols[57].kind          := 1;
	HSCols[58].kind          := 1;
	HSCols[59].kind          := 1;
	HSCols[60].kind          := 4;
	HSCols[61].kind          := 1;
	HSCols[62].kind          := 1;
	HSCols[63].kind          := 1;
	HSCols[64].kind          := 1;
	HSCols[65].kind          := 1;
	HSCols[66].kind          := 1;
	HSCols[67].kind          := 1;
	HSCols[68].kind          := 1;
	HSCols[69].kind          := 0;
	HSCols[70].kind          := 3;
	HSCols[71].kind          := 1;
	HSCols[72].kind          := 1;
	HSCols[73].kind          := 0;
	HSCols[74].kind          := 0;
	HSCols[75].kind          := 0;
	HSCols[76].kind          := 0;
	HSCols[77].kind          := 1;
	HSCols[78].kind          := 1;
	HSCols[79].kind          := 1;
	HSCols[80].kind          := 4;
             //0 Integer 1 string 2 Yesno 3 date 4 tid 5 status 6 device 7 template 20 external status
  HSCols[81].kind          := 1;// 'pr.SequenceNumber';
	HSCols[82].kind          := 1;// 'pr.Deadline1';
	HSCols[83].kind          := 1;// 'pr.Deadline2';
	HSCols[84].kind          := 1;// 'pr.Deadline3';
	HSCols[85].kind          := 1;// 'pr.Deadline4';
	HSCols[86].kind          := 1;// 'pr.PriorityBeforeHottime';
	HSCols[87].kind          := 1;// 'pr.PriorityDuringHottime';
	HSCols[88].kind          := 1;// 'pr.PriorityAfterHottime';
	HSCols[89].kind          := 1;// 'pr.PriorityHottimeBegin';
	HSCols[90].kind          := 1;// 'pr.PriorityHottimeEnd';
	HSCols[91].kind          := 1;// 'pr.Comment';
	HSCols[92].kind          := 1;// 'pr.UsePressTowerInfo';
	HSCols[93].kind          := 1;// 'pr.OrderNumber';
	HSCols[94].kind          := 1;// 'pr.InkComment';
  HSCols[95].kind          := 1;//          := 'e.FTP';
  HSCols[96].kind          := 1;//         := 'e.Preflight';
  HSCols[97].kind          := 1;//          := 'e.RIP';
  HSCols[98].kind          := 1;//          := 'e.Color';
  HSCols[99].kind          := 1; //'pr.Planname';
  HSCols[100].kind          := 1; //'pr.Presssystem';
  HSCols[101].kind          := 1; //'pr.Plantype';
  HSCols[102].kind          := 1; //'pr.TimedEdition'from
  HSCols[103].kind          := 1; //'pr.TimedEdition'to
  HSCols[104].kind          := 1; //'pr.TimedEditionState';
  HSCols[105].kind          := 1; //'pr.FromZone';
  HSCols[106].kind          := 1; //'pr.ToZone';
  HSCols[107].kind          := 1; //'pr.Circulation';
  HSCols[108].kind          := 1; //'pr.Circulation2';
  HSCols[109].kind          := 1; //'pr.Comment2';
  HSCols[110].kind          := 1; //'pr.Miscint1';
  HSCols[111].kind          := 1; //'pr.Miscint2';
  HSCols[112].kind          := 1; //'pr.Miscstring1';
  HSCols[113].kind          := 1; //'pr.Miscstring2';
  HSCols[114].kind          := 1; //'pr.Miscdate';
  HSCols[115].kind          := 0; //'p1.DeviceGroupID';
  HSCols[116].kind          := 1; //'p1.PlateStatus';
  HSCols[117].kind          := 1; //'p1.PostOutputVersion';
  HSCols[118].kind          := 2; //'pr.Miscstring3';
  HSCols[35].mandatory := true;
  HSCols[8].mandatory := true;
  HSCols[0].mandatory := true;
  HSCols[1].mandatory := true;
  HSCols[16].mandatory := true;
  HSCols[17].mandatory := true;
  HSCols[18].mandatory := true;
  HSCols[38].mandatory := true;
  HSCols[23].mandatory := true;
  HSCols[32].mandatory := true;
  HSCols[5].mandatory := true;
  HSCols[2].mandatory := true;
  HSCols[3].mandatory := true;
  HSCols[4].mandatory := true;
  HSCols[39].mandatory := true;
  HSCols[9].mandatory := true;
  HSCols[11].mandatory := true;
  HSCols[10].mandatory := true;
  HSCols[40].mandatory := true;
  HSCols[47].mandatory := true;
  HSCols[71].mandatory := true;
  HSCols[95].mandatory := false;
  HSCols[96].mandatory := false;
  HSCols[97].mandatory := false;
  HSCols[98].mandatory := false;
  HSCols[99].mandatory := false;
  HSCols[100].mandatory := false;
  HSCols[101].mandatory := false;
  HSCols[102].mandatory := false;
  HSCols[103].mandatory := false;
  HSCols[104].mandatory := false;
  HSCols[105].mandatory := false;
  HSCols[106].mandatory := false;
  HSCols[107].mandatory := false;
  HSCols[108].mandatory := false;
  HSCols[109].mandatory := false;

  HSCols[115].mandatory := false;
  HSCols[116].mandatory := false;
  HSCols[117].mandatory := false;

  for i := 0 to 200 do
  Begin
    HSOrder[i] := i;
    HSCols[i].fieldpos := 0;
  end;
  HSOrder[0] :=4;
  HSOrder[1] :=3;
  HSOrder[2] :=7;
  HSOrder[3] :=14;
  HSOrder[4] :=8;
  HSOrder[5] :=0;
  HSOrder[6] :=16;
  HSOrder[7] :=17;
  HSOrder[8] :=12;
  HSOrder[9] :=19;
  HSOrder[10] :=9;
  HSOrder[11] :=11;
  HSOrder[12] :=10;
  HSOrder[13] :=15;
  HSOrder[14] :=21;
  HSOrder[15] :=20;
  HSOrder[16] :=1;
  HSOrder[17] :=38;
  HSOrder[18] :=23;
  HSOrder[19] :=24;
  HSOrder[20] :=42;
  HSOrder[21] :=51;
  HSOrder[22] :=52;
  HSOrder[23] :=53;
  HSOrder[24] :=54;
  HSOrder[25] :=55;
  HSOrder[26] :=56;
  HSOrder[27] :=59;
  HSOrder[28] :=39;
  HSOrder[29] :=25;
  HSOrder[30] :=71;
  HSOrder[31] :=32;
  HSOrder[32] :=34;
  HSOrder[33] :=35;
  HSOrder[34] :=70;
  HSOrder[35] :=26;
  HSOrder[36] :=69;
  HSOrder[37] :=46;
  HSOrder[38] :=43;
  HSOrder[39] :=27;
  HSOrder[40] :=60;
  HSOrder[41] :=28;
  HSOrder[42] :=29;
  HSOrder[43] :=30;
  HSOrder[44] :=31;
  HSOrder[45] :=36;
  HSOrder[46] :=18;
  HSOrder[47] :=22;
  HSOrder[48] :=33;
  HSOrder[49] :=47;
  HSOrder[50] :=48;
  HSOrder[51] :=40;
  HSOrder[52] :=41;
  HSOrder[53] :=45;
  HSOrder[54] :=57;
  HSOrder[55] :=6;
  HSOrder[56] :=2;
  HSOrder[57] :=5;
  HSOrder[58] :=13;
  HSOrder[59] :=37;
  HSOrder[60] :=44;
  HSOrder[61] :=49;
  HSOrder[62] :=50;
  HSOrder[63] :=58;
  HSOrder[64] :=61;
  HSOrder[65] :=62;
  HSOrder[66] :=63;
  HSOrder[67] :=64;
  HSOrder[68] :=65;
  HSOrder[69] :=66;
  HSOrder[70] :=67;
  HSOrder[71] :=68;
  HSOrder[72] :=72;
  HSOrder[73] :=73;
  HSOrder[74] :=74;
  HSOrder[75] :=75;
  HSOrder[76] :=76;
  HSOrder[77] :=77;
  HSOrder[78] :=78;
  HSOrder[79] :=79;
  HSOrder[80] :=80;
  HSOrder[81] :=81;
  HSOrder[82] :=82;
  HSOrder[83] :=83;
  HSOrder[84] :=84;
  HSOrder[85] :=85;
  HSOrder[86] :=86;
  HSOrder[87] :=87;
  HSOrder[88] :=88;
  HSOrder[89] :=89;
  HSOrder[90] :=90;
  HSOrder[91] :=91;
  HSOrder[92] :=92;
  HSOrder[93] :=93;
  HSOrder[94] :=94;
  HSOrder[95] :=95;
  HSOrder[96] :=96;
  HSOrder[97] :=97;
  HSOrder[98] :=98;
  HSOrder[99] :=99;
  HSOrder[100] :=100;
  HSOrder[101] :=101;
  HSOrder[102] :=102;
  HSOrder[103] :=103;
  HSOrder[104] :=104;
  HSOrder[105] :=105;
  HSOrder[106] :=106;
  HSOrder[107] :=107;
  HSOrder[108] :=108;
  HSOrder[109] :=109;
  HSOrder[110] :=110;
  HSOrder[111] :=111;
  HSOrder[112] :=112;
  HSOrder[113] :=113;
  HSOrder[114] :=114;
  HSOrder[115] :=115;
  HSOrder[116] :=116;
  HSOrder[117] :=117;
  HSOrder[118] :=118;
  HSOrder[119] :=119;

  MAXColsortcount := 98;          // if SetplannameINpressrunID i activate data
  //HSCols[8].field := 'pagetable.colorid';
  For i := 1 to 119 do
    HSCols[i].name := formmain.InfraLanguage1.Translate(HSCols[i].name);
  inif := tinifile.Create(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory())+'DataListorder.ini');
  For i := 0 to 119 do
  Begin
    HSOrder[i] := inif.readinteger('Order',inttostr(I),HSOrder[i]);
    inif.writeinteger('Order',inttostr(I),HSOrder[i]);
    HSCols[i].Width := inif.readinteger('Width',inttostr(I),50);
    inif.writeinteger('Width',inttostr(I),HSCols[i].Width);
  End;
  For i := 0 to formmain.StringGridReport.ColCount-1 do
  Begin
    formmain.StringGridReport.ColWidths[i] := inif.readinteger('StringGridReport',inttostr(I),formmain.StringGridReport.ColWidths[i]);
  End;
  inif.Free;

  (*-1 indexnum  0 Integer 1 string 2 Yesno 3 date 4 tid 5 status 6 device
  7 template 8 extstatus 9 approval 10 frontback 11 highlow 12 markgrp 13 color 14 hold
  15 active 16 unique 17 ID, 18 deadlinetid ... 18 er ikke lavet endu
  Nye
  115 p1.DeviceGroupID';
  116 'p1.PlateStatus';
  117 p1.PostOutputVersion';

  *)
End;

Function Tinittypes.DeviceGroupnametoID(name : String):Integer;
Var
  I : Integer;
  T : String;
Begin
  result := -1;
  if DeviceGroupNamesPossible then
  begin
    T := uppercase(name);
    for i := 1 to NDeviceGroupNames do
    begin
      if Uppercase(DeviceGroupNames[i].name) = T then
      begin
        result := DeviceGroupNames[i].ID;
        break;
      end;
    end;
  end;
end;

Function Tinittypes.DeviceGroupIDtoName(ID : Longint):String;
Var
  I : Integer;
//  T : String;
Begin
  result := '';
  IF DeviceGroupNamesPossible then
  begin
    For i := 1 to NDeviceGroupNames do
    begin
      IF DeviceGroupNames[i].ID = ID then
      begin
        result := DeviceGroupNames[i].name;
        break;
      end;
    end;
  end;
end;

Function Tinittypes.InitDeviceGroupNames:Boolean;
Var
  aktname : string;
Begin
  result := true;
  NDeviceGroupNames := 0;
  aktname := '';
  IF DeviceGroupNamesPossible then
  begin
    Datam1.Query2.sql.clear;
    Datam1.Query2.sql.add('select DeviceGroupID,DeviceGroupName,DeviceID from DeviceGroupNames');
    Datam1.Query2.sql.add('order by DeviceGroupName');
    Datam1.Query2.open;
    while not Datam1.Query2.eof do
    begin
      IF uppercase(aktname) <> uppercase(Datam1.Query2.Fields[1].AsString)  then
      begin
        aktname := Datam1.Query2.Fields[1].AsString;
        Inc(NDeviceGroupNames);
        DeviceGroupNames[NDeviceGroupNames].NDevices := 0;
      end;
      DeviceGroupNames[NDeviceGroupNames].ID := Datam1.Query2.Fields[0].Asinteger;
      DeviceGroupNames[NDeviceGroupNames].name := Datam1.Query2.Fields[1].AsString;
      Inc(DeviceGroupNames[NDeviceGroupNames].NDevices);
      DeviceGroupNames[NDeviceGroupNames].Devices[DeviceGroupNames[NDeviceGroupNames].NDevices] :=
        Datam1.Query2.Fields[2].Asinteger;
      Datam1.Query2.next;
    end;
    Datam1.Query2.close;
  end;
end;

procedure Tinittypes.getdeviceGrplistfromtemplate(templatenumber : Integer);
Var
  //T,t2 : string;
  idr,I,igr{,aktdevid,tmplid} : integer;
  found : boolean;
Begin
  NaktdeviceGRPidlist := 0;
  // returns aktdeviceidliststring, Aktdeviceliststring  and    Naktdeviceidlist
  getdeviceIDSfromtemplate(templatenumber);

  //tmplid := PlatetemplateArray[templatenumber].TemplateID;
  IF Aktdevicegrplist = nil then
    Aktdevicegrplist := TStringList.Create;
  aktdeviceGRPidliststring := '';
  NaktdeviceGRPidlist := 0;
  For igr := 1 to NDeviceGroupNames do
  begin
    found := false;
    for idr := 1 to DeviceGroupNames[igr].NDevices do
    begin
      For i := 1 to Naktdeviceidlist do
      begin
        IF DeviceGroupNames[igr].Devices[idr] = aktdeviceidlist[i] then
        begin
          Inc(NaktdeviceGRPidlist);
          aktdeviceGRPidlist[NaktdeviceGRPidlist] := DeviceGroupNames[igr].ID;
          found := true;
          Break;
        end;
      end;
      if found then break;
    end;
  End;
  Aktdevicegrplist.clear;
  For igr := 1 to NaktdeviceGRPidlist do
  begin
    idr := aktdeviceGRPidlist[igr];
    Aktdevicegrplist.add(DeviceGroupIDtoName(idr));
  End;
end;
end.
