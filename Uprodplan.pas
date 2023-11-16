unit Uprodplan;

{ achange }
interface

uses
  UTypes, uplanframe, DateUtils,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  system.UITypes,
  Dialogs, ToolWin, ActnMan, ActnCtrls, ActnMenus, ActnList, Vcl.Mask,
  XPStyleActnCtrls, ComCtrls, StdCtrls, ExtCtrls, PBExListview, Menus,
  ActnPopup, DB, FMTBcd, SqlExpr, inifiles, Vcl.PlatformDefaultStyleActnCtrls,
  system.Actions, UImages, ULoadDlls, system.Generics.Collections;

type
  TFormprodplan = class(TForm)
    ActionManagerPlanning: TActionManager;
    ActionWizard: TAction;
    ActionSave: TAction;
    ActionLoad: TAction;
    ActionDelete: TAction;
    ActionRun: TAction;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ScrollBoxplan: TScrollBox;
    Panel19: TPanel;
    CheckBoxsmallimagesinEdit: TCheckBox;
    PBExListview1: TPBExListview;
    ActionToolBar1: TActionToolBar;
    Actionclear: TAction;
    StatusBar1: TStatusBar;
    ProgressBarprod: TProgressBar;
    PopupActionBarExplan: TPopupActionBar;
    Actionhalfweb: TAction;
    Actioncommon: TAction;
    Actioneditcolors: TAction;
    Actionlayout: TAction;
    Editcolors1: TMenuItem;
    Changelayout1: TMenuItem;
    Producecommonplate1: TMenuItem;
    Halfweb1: TMenuItem;
    Actioncenterspread: TAction;
    Actionsinglespread: TAction;
    ActionSetRipSetup: TAction;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    DateTimePickerPubdate: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    ComboBoxPublication: TComboBox;
    Label3: TLabel;
    ComboBoxLocation: TComboBox;
    Label4: TLabel;
    ComboBoxpress: TComboBox;
    EditProductionname: TEdit;
    Label5: TLabel;
    PopupActionBarExdatapopup: TPopupActionBar;
    Actionpagepagenamenameedit: TAction;
    Actionpagestackpos: TAction;
    Actionpagetower: TAction;
    Actionpagecylinder: TAction;
    Actionpagezone: TAction;
    ActionpageHighlow: TAction;
    Pagename1: TMenuItem;
    Stackposition1: TMenuItem;
    ower1: TMenuItem;
    Zone1: TMenuItem;
    Cylinder1: TMenuItem;
    Highlow1: TMenuItem;
    Action1pagerefresh: TAction;
    CheckBoxsubedselection: TCheckBox;
    ActionSetuniquepages: TAction;
    Actionplaterefresh: TAction;
    Refresh1: TMenuItem;
    Actioncopyadd: TAction;
    Actioncopydelete: TAction;
    Actionexit: TAction;
    ActionediteditionRun: TAction;
    ActionSetuniquepage: TAction;
    Settounique1: TMenuItem;
    Centerspread1: TMenuItem;
    ActionCombine: TAction;
    Edit1: TEdit;
    Edit2: TEdit;
    Button4: TButton;
    Actionplatemark: TAction;
    Plateoptions1: TMenuItem;
    Actionsetpressrundata: TAction;
    Actionplanproofing: TAction;
    Proofsettings1: TMenuItem;
    Actionplanflatproof: TAction;
    Flatproofsettings1: TMenuItem;
    Actionplantower: TAction;
    ower2: TMenuItem;
    Pressrundata1: TMenuItem;
    Actionswappages: TAction;
    Swappagepositions1: TMenuItem;
    Actionswapfrontback: TAction;
    Swapfrontback1: TMenuItem;
    Actioneditpages: TAction;
    Actionplaaddcons: TAction;
    ActionMovepages: TAction;
    ActionPlancopypage: TAction;
    ActionPlanpastpage: TAction;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    Actionpopuppresssysname: TAction;
    Presssystem1: TMenuItem;
    ActionaddSheet: TAction;
    Addplate1: TMenuItem;
    ActionRemoveSheet: TAction;
    Removeblanksheets1: TMenuItem;
    Button5: TButton;
    ActionSetPlateNumber: TAction;
    SetMomigraf1: TMenuItem;
    ActionZone: TAction;
    Zonename1: TMenuItem;
    ActionHighlow: TAction;
    HighLow2: TMenuItem;
    ActiontrueSheetside: TAction;
    rueSheetside1: TMenuItem;
    Actionpresscylname: TAction;
    ActionAutoHW: TAction;
    Presssettings1: TMenuItem;
    Cylindername1: TMenuItem;
    Actionpagechangemaster: TAction;
    Changemasterpageautomatic1: TMenuItem;
    Actionmakeplatepageunique: TAction;
    Editions1: TMenuItem;
    Makeunique1: TMenuItem;
    Actionmakeplateunique: TAction;
    Setplatestounique1: TMenuItem;
    Setplatenumbers1: TMenuItem;
    ComboBoxdefpagina: TComboBox;
    Labelpageindex: TLabel;
    GroupBox3: TGroupBox;
    CheckBoxname: TCheckBox;
    CheckBoxpagina: TCheckBox;
    CheckBoxindex: TCheckBox;
    ListBoxnumsort: TListBox;
    Edit3: TEdit;
    Label6: TLabel;
    ScrollBoxDummyPages: TScrollBox;
    Editpagenumbers1: TMenuItem;
    ActionPlanEditPagenumbers: TAction;
    ActionPlanningRearrangePages: TAction;
    Rearrangepages1: TMenuItem;
    Movesheetforward1: TMenuItem;
    Movesheetbackward1: TMenuItem;
    ActionMoveSheetForward: TAction;
    ActionMoveSheetBackward: TAction;
    procedure FormActivate(Sender: TObject);
    procedure CheckBoxsmallimagesinEditClick(Sender: TObject);
    Procedure productionidckeckup;
    procedure ActionRunExecute(Sender: TObject);
    procedure ActionclearExecute(Sender: TObject);
    procedure ActionSaveExecute(Sender: TObject);
    procedure StatusBar1DrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActioncommonExecute(Sender: TObject);
    procedure ActioneditcolorsExecute(Sender: TObject);
    procedure ActionhalfwebExecute(Sender: TObject);
    procedure ActionWizardExecute(Sender: TObject);
    procedure ActionLoadExecute(Sender: TObject);
    procedure ComboBoxLocationSelect(Sender: TObject);
    procedure ComboBoxpressSelect(Sender: TObject);
    procedure DateTimePickerPubdateChange(Sender: TObject);
    procedure ComboBoxPublicationSelect(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PBExListview1Edited(Sender: TObject; Item: TListItem;
      var S: String);
    procedure ActionpagepagenamenameeditExecute(Sender: TObject);
    procedure Action1pagerefreshExecute(Sender: TObject);
    procedure PBExListview1ColumnClick(Sender: TObject; Column: TListColumn);
    procedure PBExListview1Compare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure ActionpagestackposExecute(Sender: TObject);
    procedure ActionpagetowerExecute(Sender: TObject);
    procedure ActionpagecylinderExecute(Sender: TObject);
    procedure ActionpagezoneExecute(Sender: TObject);
    procedure ActionpageHighlowExecute(Sender: TObject);
    procedure ActionlayoutExecute(Sender: TObject);
    procedure ActionSetRipSetupExecute(Sender: TObject);
    procedure CheckBoxsubedselectionClick(Sender: TObject);
    procedure ActionSetuniquepagesExecute(Sender: TObject);
    procedure ActionplaterefreshExecute(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ActioncopyaddExecute(Sender: TObject);
    procedure ActioncopydeleteExecute(Sender: TObject);
    procedure ActionexitExecute(Sender: TObject);
    procedure ActionediteditionRunExecute(Sender: TObject);
    procedure ActionSetuniquepageExecute(Sender: TObject);
    procedure ActioncenterspreadExecute(Sender: TObject);
    procedure ActionDeleteExecute(Sender: TObject);
    procedure PBExListview1Click(Sender: TObject);
    procedure ActionCombineExecute(Sender: TObject);
    procedure ActionplatemarksExecute(Sender: TObject);
    procedure ActionplatemarkExecute(Sender: TObject);
    procedure ActionplanproofingExecute(Sender: TObject);
    procedure ActionplanflatproofExecute(Sender: TObject);
    procedure ActionplantowerExecute(Sender: TObject);
    procedure ActionsetpressrundataExecute(Sender: TObject);
    procedure ActionswappagesExecute(Sender: TObject);
    procedure ActionswapfrontbackExecute(Sender: TObject);
    procedure ActioneditpagesExecute(Sender: TObject);
    procedure ActionplaaddconsExecute(Sender: TObject);
    procedure ActionMovepagesExecute(Sender: TObject);
    procedure ActionPlancopypageExecute(Sender: TObject);
    procedure ActionPlanpastpageExecute(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ActionpopuppresssysnameExecute(Sender: TObject);
    procedure ActionaddSheetExecute(Sender: TObject);
    procedure ActionRemoveSheetExecute(Sender: TObject);
    procedure ActionSetPlateNumberExecute(Sender: TObject);
    procedure ActionZoneExecute(Sender: TObject);
    procedure ActionHighlowExecute(Sender: TObject);
    procedure ActiontrueSheetsideExecute(Sender: TObject);
    procedure ActionpresscylnameExecute(Sender: TObject);
    procedure RadioGrouppageviewtextXYZClick(Sender: TObject);
    procedure ActionAutoHWExecute(Sender: TObject);
    procedure ActionpagechangemasterExecute(Sender: TObject);
    procedure ActionmakeplatepageuniqueExecute(Sender: TObject);
    procedure ActionmakeplateuniqueExecute(Sender: TObject);
    procedure PBExListview1AdvancedCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage;
      var DefaultDraw: Boolean);
    procedure CheckBoxnameClick(Sender: TObject);
    procedure ComboBoxdefpaginaChange(Sender: TObject);
    procedure ActionPlanEditPagenumbersExecute(Sender: TObject);

    procedure ActionPlanningRearrangePagesExecute(Sender: TObject);
    procedure ActionMoveSheetForwardExecute(Sender: TObject);
    procedure ActionMoveSheetBackwardExecute(Sender: TObject);

  private
    Function makeApagetext(pagename: String; Pageindex: Integer;
      pagina: Integer): String;
    procedure SetHWonSpecifik(AIPLF: Longint; Aipl: Longint);

    procedure lookforcenterspread;
    { procedure SetRunningnumbers(prepaired : Boolean;
      FromPressrun : longint;
      ToPressrun : longint); }
    Function CheckForUniquePlates: Longint;
    Function FindACommonplate(Iplf2: Longint; ipl2: Longint): Boolean;

    procedure Customtowersetting;
    procedure lookApplydata;
    procedure lookforexistingplansepnum;
    procedure Checkifallareapply;
   // procedure superinsert;
    procedure Checkfornocolorpages;
    Procedure rebuildmanualdinks;
    Procedure docollect;
    Procedure checkuponhwafteredit;
    procedure applypublicationdataafterloadafplan;
    Function Checknewproduction: Boolean;
    Procedure somethingalliedorinserted(productionid: Longint;
      pressrunid: Longint; publicationid: Longint; pubdate: Tdatetime);

    Function checkfordubles(frompl: Longint; Npl: Longint): Boolean;

    Function Addplateframes(parentBox: TScrollBox;
      AddNumberofframes: Longint): Boolean;

    Function AddExtraruntopages: Boolean;

    Procedure SetMomigrafdata;

    function GetSelectedSheetNumber(PlateFrameIndex: Integer): Integer;
    procedure ChangeSheetNumber(PlateFrameIndex: Integer;
      SheetNumberFrom: Integer; SheetNumberTo: Integer);
    // Procedure Allcolors;
    // procedure Writeplanfile;

    procedure changesections;
    procedure changesectionsSTB;
    procedure changeeditions;
    procedure changeeditionsSTB;
    procedure changeoffset;
    procedure changeoffsetSTB;

    Function checktowers: Boolean;
    Procedure genmiscstring; // laver et platenumber i miscsring1
    procedure Deletetouniqueplates;
    Function max8car(fromstr: string): String;
    procedure setothercopies(iplf: Longint; ipl: Longint);

    // Procedure swapwidthseq;
    // Procedure applydifferenthwtemplate(templateListid : Longint);

    procedure makeinsectionids;
    Procedure Editplantoplates(iplf: Longint; templatelistid: Longint;
      proofid: Longint; Nmarkgroups: Integer; markgroups: marksarray);

    Procedure ForceToMainEdition();
    Procedure writeplanlog(planname: String);
    procedure ApplyRelocationsstatus(iplf, ipl, ip, ic: Longint);
    procedure ApplySamelocationstatus(iplf, ipl, ip, ic: Longint);
    Function Needtoproduce(iplf, ipl: Longint): Boolean;
    Function changePress(newpressid: Longint): Boolean;
    procedure SetHalfweb;
    Function doImposecalc: Boolean;
    Procedure Wizardtoplates;
    Procedure reimposedplantoplates(iplf: Integer);
    procedure Editeditiontoplanpages(cursectionI: Integer; halfwebpage1: String;
      halfwebpage2: string);
    Function Newimpositioncalulation(halfwebpage1: string; halfwebpage2: string;
      halfwebsec1: string; halfwebsec2: string): Boolean;
    Procedure AddExtraruntoplates;
    function PageNameToInt(pagename: string): Integer;
    procedure  GeneratePlanPageNames(ProductionID: Integer);
  public
    { Public declarations }
    ItsArepair: Boolean;
    NextPartseqnum: Longint;
    IgnorePagicheck: Boolean;
    Copytopressdontshowapply: Boolean;
    Calledwizardtoplates: Boolean;
    JustAlayoutchange: Boolean;
    PartialPlanning: Boolean;
    PartialOrgpressrunid: Longint;
    NupCol: Longint;
    ManualImposistion: Boolean;
    ManualNPlates: Longint;
    NManualpagesOnplates: Longint;
    ManualpagesOnplates: Array [1 .. 200] of Longint;
    Applyonlyplannedcolors: Boolean;
    Editthisrun: Longint;

    plancenteristoold: Boolean;
    Starttoruntime, endrunningtime: Tdatetime;
    planningaction: Integer; // 0 load,1 edit,2 create,3 copy, 4 move, 5 apply
    Anyerrosduringrun: Boolean;
    NApplieddata: Longint;
    Applieddata: array [1 .. 100] of record productionid: Longint;
    pressrunid: Longint;
    publicationid: Longint;
    pubdate: Tdatetime;
  End;

  FoundAapplynewpage: Boolean;
  ColumnToSort: Integer;
  planisactive: Boolean;
  Multiplanid: Longint;
  Editmode: Integer; // 0 just open, 1 edit mode, 2 wizard mode, 3 copymode, 4 movemode, 5 applymode, 6 multisave
  issetting: Boolean;
  Anychange: Boolean;
  usingpdfplan: Boolean;
  Currentblackcolorid: Longint;
  Wiplf, Wipl, Wip, Wop: Longint;
  prodsections: String;
  prodpages: String;
  Validplancolors: String;
  addingplatelistid: Longint;
  JustaddoneUP: Boolean;
  prodcombined: Integer;
  prodcollection: Integer;
  prodbindingstyle: Integer;
  prodplancreep: Single;
  prodplannedhold: Integer;
  prodplannedapproval: Integer;
  prodplantype: Integer;
  prodplanforceapply: Boolean;
  Addrunfromsec: Integer;

  Movepressruncomment, movepressrunorder: String;
  PlanVersion : Integer;
  moveunplannedfrompressid: Longint;
  moveunplannedfromprodcutionid: Longint;
  ApplyingToPDF: Boolean;
  NApplymodecolors: Integer;
  Applymodecolors: Array [1 .. 16] of Integer;
  Appendtoplan: Boolean;
  Currentcreep: Double;
  NLoadasonPressrunids: Longint;
  LoadasonPressrunids:
  Array [1 .. 20] of Longint;
  Activated: Boolean;
  lastlocktime: Tdatetime;
  HwInsecs: array [1 .. 100] of Longint;
  Plantimer: Tdatetime;

  platenametextFontStyle:
  TFontStyles;

  DragIPLF, DragIPL, DragIP: Longint;
  CopyIPLF, copyIPL, CopyIP: Longint;
  pasteIPLF, pasteIPL, pasteIP: Longint;

  Nruntimes: Integer;
  addingplate, Runschanged: Boolean;

  Insectionidsstr: string;
  // Nacs : Integer;
  splitsections: Boolean;
  Plantimming: TStrings;

  remotecallinformation:
    Record publicationid: Longint;
      pubdate: Tdatetime;
      MainEditionID: Longint;
      Priority: Longint;
      proofid: Longint;
      Flatproofid: Longint;
      Creep: Longint;
      nSections: Longint;
      Sections: array [1 .. 10] of record Sectionsid: Longint;
      Pages: String;
      prefix: String;
      postfix: String;
      ncoverpages: String;
      ninsertpages: String;
      offset: String;
      namedcover: String;
      sectionorder: Longint;
    end;
  collectionmode: Longint;
  Perfectbound: Boolean;
  Prepaired: Boolean;
  Backwards: Boolean;
  Applyonlyplanedcolor: Boolean;

  Locationid: Longint;
  Pressid: Longint;
  templatelistid: Longint;

end;

  Function getpaginaoffset(iplf: Longint): Longint;
  Procedure pageindextopagina;

  Procedure calulatepagina;
  Procedure CalculatePaginaAfterCombine(method: Integer);
  Procedure Newcalulatepagina;

  procedure AddAcopy;
  procedure Checkfrontbackon1up;
  Procedure loadNoneplatedatafromdb(iplf: Longint; resetpagetype: Boolean);

  procedure Changelayoutonrun(templatename: String);
//                 procedure fastruniftotnew;
  Procedure plantimdadd(Atext: String);
  Procedure SelApage(iplf: Longint; ipl: Longint; ip: Longint);

  Procedure MoveApage(Fiplf: Longint; Fipl: Longint;
            FIP: Longint; Tiplf: Longint; Tipl: Longint;
            TIP: Longint);

  Function PlanContainsMultiblesections: Boolean;
  // Function SmallWizard(selectpress : Boolean):boolean;
  Procedure editpagename(iplf: Longint; ipl: Longint; ip: Longint);
  Function publanddateexists: Boolean;
  Procedure loadpressruniddata;
  Procedure setAllpressruniddata;
  procedure pressruncaptionnames;
  Procedure setpressruniddata
      (pressrunid: Longint;
      SequenceNumber: Longint;
      Deadline1: Tdatetime;
      Deadline2: Tdatetime;
      Deadline3: Tdatetime;
      Deadline4: Tdatetime;
      PriorityBeforeHottime: Longint;
      PriorityDuringHottime: Longint;
      PriorityAfterHottime: Longint;
      PriorityHottimeBegin: Tdatetime;
      PriorityHottimeEnd: Tdatetime;
      Comment: string; pressrunconfig: String;
      order: string; Perfectbound: Integer;
      inserted: Integer; Backwards: Integer);

  Function createproductionname(publicationid: Longint; Pressid: Longint; pubdate: Tdatetime): string;
  Procedure Incrementpresssections;
  Procedure getproductioncolors;
  Function Insertnewpressrun(RunNumber: Longint): Longint;
  Procedure findpossibledevises;
  Function unplannedexists: Boolean;
  procedure cleanupexistingdata;
  procedure findunplannedUniquepages;
  procedure Keeponplannedcolors;
  Procedure setactionenabled;
  procedure Setbluebar;
  Procedure loadplatedatafromdb(iplf: Longint; resetpagetype: Boolean);
  Procedure Setproduce;
  Function Needtobeunique(iplf, ipl: Longint): Boolean;
  Function CheckIfOtherUseCommon(iplf, ipl, ip: Longint; Var Riplf, Ripl, Rip: Longint): Boolean;

  Function changelocation(newlocationid: Longint;
                                        newpressid: Longint;
                                        Newtemplatelistid: Longint;
                                        NewNmarkgroups: Integer;
                                        Newmarkgroups: marksarray): Boolean;
  Function SelectNewlocation(newlocationid: Longint;
                                        Var newpressid: Longint;
                                        Var Newtemplatelistid: Longint;
                                        Var NewNmarkgroups: Integer;
                                        Var Newmarkgroups: marksarray): Boolean;

  Function ImagenumbertoIPL(iplf: Integer; Selectedimageindex: Integer): Integer;

  Procedure possiblepressesonlocation(Locationid: Longint; items: TStrings);

  Function makeprodImagesize(PageRotation: TPageNumbering;
                                        Inputorientation: Longint;
                                        phorz: Longint; pvert: Longint;
                                        Var platewidth: Longint;
                                        Var plateheight: Longint;
                                        Var pagewidth: Longint;
                                        Var pageheight: Integer): TRect;

  Function makeprodviewimage (iplf: Longint;
                                        Var drawImageListplates: TImageList;
                                        var drawPBExListview: TPBExListview;
                                        showthumbnails: Boolean; small: Boolean;
                                        showinkpreview: Boolean;
                                        platenumber: Integer; plateipl: Integer;
                                        highresip: Integer;
                                        Numberofcopies: Longint): Integer;
                                        // 0 error 1 ok 2 ok dontproduce

   Procedure makepagelist(Var APBExListview : TPBExListview; akttopindex: Longint);

   Function doreimposecalc(templatenumber: Integer; resethw: Boolean): Boolean;

   procedure copyplantoplanpages;
   procedure Sethwonplanpages(iplf: Integer; ipl: Integer);

   procedure setpressrunids;
   procedure setpressrunidstodbrunid;
   Function loadpressplanSTB (var parentBox: TScrollBox;
                                        showit: Boolean; small: Boolean;
                                        applying: Boolean;
                                        changeLoadedsections: Boolean): Boolean;

   Function LoadPressPlan(Var parentBox: TScrollBox;
                                        showit: Boolean; small: Boolean;
                                        applying: Boolean;
                                        changeLoadedsections: Boolean): Boolean;
   Procedure LoadpressplandataSTD(presstemplateid: Longint;
                                        Pressid: Longint; multiplan: Boolean;
                                        changeLoadedsections: Boolean);

   Procedure Loadpressplandata(presstemplateid: Integer;
                                        presstemplateid2: Integer;
                                        presstemplateid3: Integer;
                                        presstemplateid4: Integer;
                                        presstemplateid5: Integer;
                                        inserted1: Boolean; inserted2: Boolean;
                                        inserted3: Boolean;  inserted4: Boolean;
                                        Pressid: Integer;
                                        multipresstemplateload: Boolean;
                                        changeLoadedsections: Boolean);

    procedure findorgedpages;
    Function Wizard(selectpress: Boolean): Boolean;
    procedure setactions;
    Procedure GetprodrundatafromUI;
    Procedure SetprodrundataToUI;
    Procedure saveprodrundata(productionid: Longint);
    Procedure Loadprodrundata(productionid: Longint);
    Function RunProduction(frommain: Boolean): Boolean;
    procedure setdinkydata(offset: Longint);
    procedure applyglobdata(offset: Longint;
                                      Newproductionid: Longint;
                                      Newpublicationid: Longint;
                                      newlocationid: Longint;
                                      newpressid: Longint;
                                      Newtemplatelistid: Longint;
                                      Newflatproofid: Longint;
                                      Newcolorproofid: Integer;
                                      NewMonoproofid: Integer;
                                      NewPDFproofid: Integer;
                                      NewNmarkgroups: Integer;
                                      Newmarkgroups: marksarray);
   Function pagepositionsfromprodplate(Var prodplate: Tprodplate;Ipage: Integer): string;

   Procedure Oldappendit
                                                          (Var prodplate: Tprodplate;
                                                          Ipage: Integer; Icolor: Integer;
                                                          Copynumber: Integer; iplf: Longint;
                                                          Var firstcolor: Boolean;
                                                          Var aktcopyseparationset: Longint; Var GotError: Boolean);

   Function findpagerunnig(Locationid: Integer; Pressid: Integer;
                                        productionid: Integer;
                                        publicationid: Integer;
                                        pressrunid: Integer; pubdate: Tdatetime;
                                        editionid: Integer; sectionid: Integer;
                                        pagename: string; ColorID: Integer;
                                        Copynumber: Integer; iplf: Longint;
                                        ipl: Longint; Var proofid: Integer;
                                        var frompressid: Integer;
                                        var fromlocationid: Integer;
                                        var Unique: Integer;
                                        Var MasterCopySeparationSet: Longint;
                                        Var CopySeparationSet: Longint;
                                        Var SeparationSet: Longint;
                                        Var FlatSeparationSet: Longint;
                                        Var CopyFlatSeparationSet: Integer;
                                        Var Separation: Int64;
                                        Var FlatSeparation: Int64;
                                        var curstat: Integer;
                                        Var CurRelease: Integer;
                                        Var CurApproval: Integer;
                                        Var proofstatus: Integer;
                                        Var fileserver: String;
                                        var pagetypeX: Integer): Integer;

     Procedure getcurrentplan;
     procedure Applyplan(iplf: Integer;
                                        NAprodplates: Integer;
                                        frompressid: Integer;
                                        fromlocationid: Integer;
                                        applydevice: Integer; frommain: Boolean;
                                        extracopyoffset: Integer);

    function GenerateRipSetupID(publicationid: Integer;Pressid: Integer): Integer;

    procedure CombineTwoRuns;

    function GetPlatePageData(plateFrameNo: Integer;
                                        pageNameToFind: string;
                                        sectionIdToFind: Integer;
                                        editionIdToFind: Integer): Tprodpage;

  end;

  Type
     PTbufplateframeType = ^TbufplateframeType;

    TbufplateframeType = record
        NProdPlates: Integer;
        ProdPlates: Tprodplates;
        pressrunid: Integer;
        plateframenumber: Integer;
        Selected: Boolean;
        OrgRunID: Integer;
        Orgfromeditionid: Integer;
        OrgPubdate: Tdatetime;
        OrgFromPressid: Integer;
        OrgFromLocationid: Integer;
        OrgPublicationid: Integer;
        orgproductionid: Integer;
    End;

   const

      ProdImpospw100 = 50;
      ProdImposph100 = 75;
      ProdImposmw100 = 4;
      ProdImposmh100 = 4;

  var

     Formprodplan: TFormprodplan;

implementation

Uses
  SqlTimSt,
  umain, Udata, Uaddplan, UEditionpageplan, Uproof, USelecttemplate,
  Usettings, Uloadpressplan, Uaddpressrun,
  USelectnewpress, Unewlocalpress, Uprefixposfix, Ulistselect, Uchlayout,
  UEditcolors, UApplyplan, Ueditedition, Uplancenterspread,
  Udeletepressplans, UQplanedit, Usavename, Uappendruns,
  Umarkgroups, Utowername, Ueditplan,
  Upressruninfo, UCustomTowers, USwappagepos, Uplaneditpage,
  UConsAddpressrun, UaddExtrapressrun, Ueditionorder, USetschedules,
  Ueditatextcombo, Uflatproof, UWebnaming, USetpressCylinder, Ulogin,
  Uselfromlist, UListselection, ULoadstbplan,
  UReProcess,
  UReProcessSimple,
  UPlanEdit2up, UPlanEdit4up, UPlanEdit8up, USelectHalfwebPage, UUtils,
  USelectPaginationStyle, UFormPlanRearrangePages,
  UXMLExport,
  UApplyLoadedPressTemplate;

{$R *.dfm}

Var
  MakingdoubleFrontback: Boolean;

  appendsec, findingsec, insertsec: Integer;
  { bufplateframes : array[1..64] of record
    envar : Integer;
    bufplateframe : PTbufplateframeType;
    end; }
  // Nbufplateframes : Integer;

  Numberofhalfweb: Integer;
  Nprodplatebuf: Integer;
  prodplatebuf: Tprodplates;

Function TFormprodplan.Newimpositioncalulation(halfwebpage1: string;
  halfwebpage2: string; halfwebsec1: string; halfwebsec2: string): Boolean;
Var
  PNN, Ipage, I, isec, ied, iflat, isgn, ihwsign: Integer;
  Npresssec, nsection, npage, ncolor: ttreenode;
  T: string;
  ip, nh, Nup: Integer;
  IPBExListviewSections, ispl, nispl, npinisec: Integer;
  numberofsections, cursectionI, nflatcalc: Integer;

  contpagon: Boolean;

  np, nis, iis, ipoffset, FixHWMin, FixHWPage: Integer;
  aktcombsec: string;
  pplus, pofspl, fromtop, topI, akttop, namedoffset: Integer;
  coveroffset, insertoffset: array [0 .. MAXSECTIONS] of Integer;
  presssecionnumber: Integer;
  newed: Boolean;

  pagina, aktedid, aktsecid, iplf: Integer;

  isplit: Boolean;
  PNT: String;

  AktflInSec, Iflc: Integer;
  MT1, MT2, MT3: string;
  MI1, MI2, MI3, presecI: Integer;
  ini: tinifile;
  up1Runtrhough: Boolean;
Begin

  formmain.planlogging('Newimpositioncalulation');
  ipoffset := 0;
  pplus := 0;
  for I := 1 to MAXSECTIONS do
  begin
    for Ipage := 0 to MAXPAGESINSECTION - 1 do
    begin
      planpagenames[I].Pages[Ipage].Pageindex := 0;
      planpagenames[I].Pages[Ipage].paginaindex := 0;
    end;
  end;

  // Read offset data from page count section grid
  For isec := 0 to FormAddpressrun.PBExListviewSections.items.count - 1 do
  begin
    IF FormAddpressrun.PBExListviewSections.items[isec].subitems.count < 7 then
      FormAddpressrun.PBExListviewSections.items[isec].subitems.add('');

    coveroffset[isec] := StrToInt(FormAddpressrun.PBExListviewSections.items[isec].subitems[3]) div 2;

    IF (FormAddpressrun.PBExListviewSections.items[isec].subitems[6] <> '') then
    Begin
      coveroffset[isec] := 0;
      namedoffset := StrToInt(FormAddpressrun.PBExListviewSections.items[isec].subitems[3]) div 2;
    End;
    insertoffset[isec] := StrToInt(FormAddpressrun.PBExListviewSections.items[isec].subitems[4]) + coveroffset[isec];
  end;
  cursectionI := 0;
  np := 0;
  aktcombsec := '';

  up1Runtrhough := (Prefs.PlanningRunThroughPagination) And
    (FormAddpressrun.RadioGroupcollection.ItemIndex = 0) and
    (PlatetemplateArray[Formselecttemplate.Selectedtemplatenumber].NupOnplate = 1);

  IF (not FormAddpressrun.CheckBoxsplitall1up.checked) AND (not up1Runtrhough)
    and ((FormAddpressrun.Oldstyleinsert) OR
    ((not FormAddpressrun.CheckBoxprepaired.checked) and
    (PlatetemplateArray[Formselecttemplate.Selectedtemplatenumber].NupOnplate = 1))) then
  begin
    for ied := 1 to Formeditionpageplan.NEditions do
    begin
      presssecionnumber := 0;
      iis := 0;
      cursectionI := ied; // der er kun en ied sections alt er indsat i den
      planpagenames[cursectionI].Npages := 0;
      planpagenames[cursectionI].collection :=
        FormAddpressrun.RadioGroupcollection.ItemIndex;
      planpagenames[cursectionI].editionid :=
        tnames1.editionnametoid(Formeditionpageplan.StringGrideds.cells[ied, 0]);
      planpagenames[cursectionI].newedition := true;
      np := 0;
      Inc(presssecionnumber);
      for isec := 0 to FormAddpressrun.PBExListviewSections.items.count - 1 do
      begin
        T := FormAddpressrun.PBExListviewSections.items[isec].subitems[0];
        npinisec := FormAddpressrun.npagestrtonpages(T, nispl);
        planpagenames[cursectionI].Npages := planpagenames[cursectionI].Npages + npinisec;
        planpagenames[cursectionI].Nhalfwebpage := 0;
      End;

      for isec := 0 to FormAddpressrun.PBExListviewSections.items.count - 1 do
      begin
        T := FormAddpressrun.PBExListviewSections.items[isec].subitems[0];
        npinisec := FormAddpressrun.npagestrtonpages(T, nispl);
        planpagenames[cursectionI].Pages[0].name := 'Dinky';

        planpagenames[cursectionI].Pages[0].Orgeditionid := planpagenames[cursectionI].editionid;
        planpagenames[cursectionI].Pages[0].seci := isec;
        planpagenames[cursectionI].Pages[0].sectionid :=
          tnames1.sectionnametoid(FormAddpressrun.PBExListviewSections.items[isec].Caption);
        planpagenames[cursectionI].Pages[0].presssecionnumber := presssecionnumber;

        namedoffset := 0;
        IF (FormAddpressrun.PBExListviewSections.items[isec].subitems[6] <> '')
        then
        Begin
          coveroffset[isec] := 0;
          namedoffset := StrToInt(FormAddpressrun.PBExListviewSections.items[isec].subitems[3]) div 2;
        End;
        insertoffset[isec] :=
          StrToInt(FormAddpressrun.PBExListviewSections.items[isec].subitems[4])
          + coveroffset[isec];
        np := 0;
        (* IF (false) and (Prefs.PlanningRunThroughPagination) and (planpagenames[cursectionI].collection = 0) then
          begin
          if isec = FormAddpressrun.PBExListviewSections.items.count-1 then
          Begin
          nis := (FormAddpressrun.Commastrlist[1])
          End;
          End
          Else
          begin *)
        if isec = FormAddpressrun.PBExListviewSections.items.count - 1 then
          nis := (FormAddpressrun.Commastrlist[1])
        else
          nis := (FormAddpressrun.Commastrlist[1]) div 2;
        (* End; *)

        For ip := 1 to nis do
        begin
          Inc(iis);
          Inc(np);
          pofspl := np;
          (* IF (false) and (Prefs.PlanningRunThroughPagination) and (planpagenames[cursectionI].collection = 0) then
            begin
            pofspl := pofspl+ coveroffset[isec];
            End
            Else
            Begin *)
          if iis < planpagenames[cursectionI].Npages div 2 then
            pofspl := pofspl + coveroffset[isec];
          if iis > planpagenames[cursectionI].Npages div 2 then
            pofspl := pofspl + insertoffset[isec];
          (* End; *)
          IF (FormAddpressrun.PBExListviewSections.items[isec].subitems[6] <> '') and (namedoffset > 0) then
          Begin
            PNT := FormAddpressrun.PBExListviewSections.items[isec].subitems[1];
            IF (pofspl <= namedoffset) OR (pofspl > planpagenames[cursectionI].Npages - namedoffset) then
            Begin
              PNT := PNT + 'C';
              IF (pofspl > planpagenames[cursectionI].Npages - namedoffset) then
                PNN := (namedoffset - (planpagenames[cursectionI].Npages -
                  pofspl)) + namedoffset
              else
                PNN := pofspl;
            End
            else
            Begin
              PNN := pofspl - namedoffset;
            End;
            PNN := PNN + StrToInt(FormAddpressrun.PBExListviewSections.items[isec].subitems[5]); // Offset
            PNT := PNT + inttostr(PNN) + FormAddpressrun.PBExListviewSections.items[isec].subitems[2];

            planpagenames[cursectionI].Pages[iis].name := PNT;
          end
          Else
          Begin
            planpagenames[cursectionI].Pages[iis].name :=
              FormAddpressrun.PBExListviewSections.items[isec].subitems[1] +
              inttostr(pofspl +
              StrToInt(FormAddpressrun.PBExListviewSections.items[isec].subitems[5])) +
                FormAddpressrun.PBExListviewSections.items[isec].subitems[2];
          end;

          planpagenames[cursectionI].Pages[iis].Pageindex := pofspl +
            StrToInt(FormAddpressrun.PBExListviewSections.items[isec].subitems[5]);

          planpagenames[cursectionI].Pages[iis].seci := isec;
          planpagenames[cursectionI].Pages[iis].sectionid :=
            tnames1.sectionnametoid(FormAddpressrun.PBExListviewSections.items[isec].Caption);
          planpagenames[cursectionI].Pages[iis].Orgeditionid :=
            Formeditionpageplan.getuniqueEdID(tnames1.editionIDtoname(planpagenames[cursectionI].editionid),
            planpagenames[cursectionI].Pages[iis].name,
            FormAddpressrun.PBExListviewSections.items[isec].Caption);

          planpagenames[cursectionI].Pages[iis].presssecionnumber :=
            presssecionnumber;

          if (planpagenames[cursectionI].Pages[iis].name = halfwebpage1) or
            (planpagenames[cursectionI].Pages[iis].name = halfwebpage2) then
          begin
            IF planpagenames[cursectionI].hw1 = 0 then
              planpagenames[cursectionI].hw1 := iis
            else
              planpagenames[cursectionI].hw2 := iis;
          end;
        end;
      End;

      for isec := FormAddpressrun.PBExListviewSections.items.count -
        2 downto 0 do
      begin
        T := FormAddpressrun.PBExListviewSections.items[isec].subitems[0];
        npinisec := FormAddpressrun.npagestrtonpages(T, nispl);
        planpagenames[cursectionI].collection :=
          FormAddpressrun.RadioGroupcollection.ItemIndex;
        planpagenames[cursectionI].Pages[0].name := 'Dinky';
        planpagenames[cursectionI].Pages[0].Orgeditionid :=
          planpagenames[cursectionI].editionid;
        planpagenames[cursectionI].Pages[0].seci := isec;
        planpagenames[cursectionI].Pages[0].sectionid :=
          tnames1.sectionnametoid(FormAddpressrun.PBExListviewSections.items[isec].Caption);
        planpagenames[cursectionI].Pages[0].presssecionnumber := presssecionnumber;
        coveroffset[isec] := StrToInt(FormAddpressrun.PBExListviewSections.items[isec].subitems[3]) div 2;
        namedoffset := 0;
        IF (FormAddpressrun.PBExListviewSections.items[isec].subitems[6] <> '')
        then
        Begin
          coveroffset[isec] := 0;
          namedoffset := StrToInt(FormAddpressrun.PBExListviewSections.items[isec].subitems[3]) div 2;
        End;
        insertoffset[isec] :=
          StrToInt(FormAddpressrun.PBExListviewSections.items[isec].subitems[4])
          + coveroffset[isec];

        nis := (FormAddpressrun.Commastrlist[1]) div 2;
        np := nis;

        for ip := 1 to nis do
        begin
          Inc(iis);
          Inc(np);
          pofspl := np;

          if iis < planpagenames[cursectionI].Npages div 2 then
            pofspl := pofspl + coveroffset[isec];

          if iis > planpagenames[cursectionI].Npages div 2 then
            pofspl := pofspl + insertoffset[isec];

          IF (FormAddpressrun.PBExListviewSections.items[isec].subitems[6] <>
            '') and (namedoffset > 0) then
          Begin
            PNT := FormAddpressrun.PBExListviewSections.items[isec].subitems[1];
            IF (pofspl <= namedoffset) OR
              (pofspl > planpagenames[cursectionI].Npages - namedoffset) then
            Begin
              PNT := PNT + 'C';
              IF (pofspl > planpagenames[cursectionI].Npages - namedoffset) then
                PNN := (namedoffset - (planpagenames[cursectionI].Npages -
                  pofspl)) + namedoffset
              else
                PNN := pofspl;
            End
            else
            Begin
              PNN := pofspl - namedoffset;
            End;
            PNN := PNN + StrToInt(FormAddpressrun.PBExListviewSections.items[isec].subitems[5]); // Offset
            PNT := PNT + inttostr(PNN) + FormAddpressrun.PBExListviewSections.items[isec].subitems[2];

            planpagenames[cursectionI].Pages[iis].name := PNT;
          end
          Else
          Begin
            planpagenames[cursectionI].Pages[iis].name :=
              FormAddpressrun.PBExListviewSections.items[isec].subitems[1] +
              inttostr(pofspl +
              StrToInt(FormAddpressrun.PBExListviewSections.items[isec].subitems
              [5])) + FormAddpressrun.PBExListviewSections.items[isec].subitems[2];
          end;

          planpagenames[cursectionI].Pages[iis].Pageindex := pofspl +
            StrToInt(FormAddpressrun.PBExListviewSections.items[isec].subitems[5]);

          planpagenames[cursectionI].Pages[iis].seci := isec;
          planpagenames[cursectionI].Pages[iis].presssecionnumber :=
            presssecionnumber;
          planpagenames[cursectionI].Pages[iis].sectionid :=
            tnames1.sectionnametoid(FormAddpressrun.PBExListviewSections.items[isec].Caption);
          planpagenames[cursectionI].Pages[iis].Orgeditionid :=
            Formeditionpageplan.getuniqueEdID(tnames1.editionIDtoname(planpagenames[cursectionI].editionid),
            planpagenames[cursectionI].Pages[iis].name,
            FormAddpressrun.PBExListviewSections.items[isec].Caption);

          IF (planpagenames[cursectionI].Pages[iis].name = halfwebpage1) or
            (planpagenames[cursectionI].Pages[iis].name = halfwebpage2) then
          begin
            IF planpagenames[cursectionI].hw1 = 0 then
              planpagenames[cursectionI].hw1 := iis
            Else
              planpagenames[cursectionI].hw2 := iis;
          end;

        end;

      End;

    End;

  end
  else
  begin
    for ied := 1 to Formeditionpageplan.NEditions do
    begin

      newed := true;
      presssecionnumber := 0;
      for isec := 0 to FormAddpressrun.PBExListviewSections.items.count - 1 do
      begin
        coveroffset[isec] := StrToInt(FormAddpressrun.PBExListviewSections.items[isec].subitems[3]) div 2;
        namedoffset := 0;
        IF (FormAddpressrun.PBExListviewSections.items[isec].subitems[6] <> '')
        then
        Begin
          coveroffset[isec] := 0;
          namedoffset := StrToInt(FormAddpressrun.PBExListviewSections.items
            [isec].subitems[3]) div 2;
        End;
        insertoffset[isec] :=
          StrToInt(FormAddpressrun.PBExListviewSections.items[isec].subitems[4])
          + coveroffset[isec];
        T := FormAddpressrun.PBExListviewSections.items[isec].subitems[0];
        npinisec := FormAddpressrun.npagestrtonpages(T, nispl);
        fromtop := npinisec + 1;

        if nispl > 1 then
        begin
          np := 0;
          For ispl := 1 to nispl do
          begin
            Inc(cursectionI);
            planpagenames[cursectionI].collection :=
              FormAddpressrun.RadioGroupcollection.ItemIndex;
            planpagenames[cursectionI].Npages :=
              FormAddpressrun.Commastrlist[ispl];
            planpagenames[cursectionI].Nhalfwebpage := 0;
            planpagenames[cursectionI].editionid :=
              tnames1.editionnametoid(Formeditionpageplan.StringGrideds.cells[ied, 0]);
            planpagenames[cursectionI].newedition := newed;
            newed := false;
            Inc(presssecionnumber);

            akttop := fromtop;
            topI := (planpagenames[cursectionI].Npages div 2) + 1;
            planpagenames[cursectionI].Pages[0].name := 'Dinky';
            planpagenames[cursectionI].Pages[0].Orgeditionid := planpagenames[cursectionI].editionid;
            planpagenames[cursectionI].Pages[0].seci := isec;
            planpagenames[cursectionI].Pages[0].sectionid :=
              tnames1.sectionnametoid(FormAddpressrun.PBExListviewSections.items[isec].Caption);
            planpagenames[cursectionI].Pages[0].presssecionnumber := presssecionnumber;

            for ip := 1 to planpagenames[cursectionI].Npages do
            begin
              IF ip < planpagenames[cursectionI].Npages div 2 then
                pplus := coveroffset[isec];

              IF ip > planpagenames[cursectionI].Npages div 2 then
                pplus := insertoffset[isec];

              IF ip > planpagenames[cursectionI].Npages div 2 then
              Begin
                Dec(fromtop);
                Dec(topI);
                pofspl := (akttop - topI) + pplus;
              end
              else
              Begin
                Inc(np);
                pofspl := np + pplus;
              End;

              IF (FormAddpressrun.PBExListviewSections.items[isec].subitems[6] <> '') and (namedoffset > 0) then
              Begin
                PNT := FormAddpressrun.PBExListviewSections.items[isec].subitems[1];
                IF (pofspl <= namedoffset) OR
                  (pofspl > planpagenames[cursectionI].Npages - namedoffset)
                then
                Begin
                  PNT := PNT + 'C';
                  IF (pofspl > planpagenames[cursectionI].Npages - namedoffset)
                  then
                    PNN := (namedoffset - (planpagenames[cursectionI].Npages - pofspl)) + namedoffset
                  else
                    PNN := pofspl;
                End
                else
                Begin
                  PNN := pofspl - namedoffset;
                End;
                PNN := PNN + StrToInt(FormAddpressrun.PBExListviewSections.items[isec].subitems[5]); // Offset
                PNT := PNT + inttostr(PNN) +
                  FormAddpressrun.PBExListviewSections.items[isec].subitems[2];

                planpagenames[cursectionI].Pages[ip].name := PNT;
              end
              Else
              Begin
                planpagenames[cursectionI].Pages[ip].name :=
                  FormAddpressrun.PBExListviewSections.items[isec].subitems[1] +
                  inttostr(pofspl +
                  StrToInt(FormAddpressrun.PBExListviewSections.items[isec].subitems[5])) + FormAddpressrun.PBExListviewSections.items[isec].subitems[2];
              end;

              planpagenames[cursectionI].Pages[ip].Pageindex := pofspl +
                StrToInt(FormAddpressrun.PBExListviewSections.items[isec].subitems[5]);

              planpagenames[cursectionI].Pages[ip].seci := isec;
              planpagenames[cursectionI].Pages[ip].sectionid :=
                tnames1.sectionnametoid(FormAddpressrun.PBExListviewSections.items[isec].Caption);
              planpagenames[cursectionI].Pages[ip].Orgeditionid :=
                Formeditionpageplan.getuniqueEdID(tnames1.editionIDtoname(planpagenames[cursectionI].editionid),
                planpagenames[cursectionI].Pages[ip].name,
                FormAddpressrun.PBExListviewSections.items[isec].Caption);

              planpagenames[cursectionI].Pages[ip].presssecionnumber :=
                presssecionnumber;
              IF ((planpagenames[cursectionI].Pages[ip].name = halfwebpage1) and
                (tnames1.sectionIDtoname(planpagenames[cursectionI].Pages[ip].sectionid) = halfwebsec1)) then
                planpagenames[cursectionI].hw1 := ip;
              IF ((planpagenames[cursectionI].Pages[ip].name = halfwebpage2) and
                (tnames1.sectionIDtoname(planpagenames[cursectionI].Pages[ip].sectionid) = halfwebsec2)) then
                planpagenames[cursectionI].hw2 := ip;

            end;
          end;
        End
        Else
        begin // ingen split

          IF (cursectionI = 0) then
          Begin
            Inc(cursectionI);
            planpagenames[cursectionI].collection :=
              FormAddpressrun.RadioGroupcollection.ItemIndex;
            planpagenames[cursectionI].Npages := 0;
            planpagenames[cursectionI].editionid :=
              tnames1.editionnametoid
              (Formeditionpageplan.StringGrideds.cells[ied, 0]);
            planpagenames[cursectionI].newedition := newed;
            newed := false;
            ipoffset := 0;
            np := 0;
          end
          Else
          begin
            if (FormAddpressrun.CheckBoxCombinetoonerun.checked) then
            begin
              presssecionnumber := 0;
              if isec > 0 then
              begin
                if (FormAddpressrun.PBExListviewSections.items[isec]
                  .Caption = FormAddpressrun.PBExListviewSections.items
                  [isec - 1].Caption) then
                begin
                  ipoffset := ipoffset + planpagenames[cursectionI].Npages;
                end
                Else
                Begin
                  Inc(cursectionI);
                  planpagenames[cursectionI].collection :=
                    FormAddpressrun.RadioGroupcollection.ItemIndex;
                  planpagenames[cursectionI].newedition := newed;
                  newed := false;
                  planpagenames[cursectionI].Npages := 0;
                  ipoffset := 0;
                  np := 0;
                  presssecionnumber := 0;
                end;
              end
              else
              begin
                ipoffset := 0;
                Inc(cursectionI);
                planpagenames[cursectionI].collection :=
                  FormAddpressrun.RadioGroupcollection.ItemIndex;
                planpagenames[cursectionI].newedition := newed;
                newed := false;
                planpagenames[cursectionI].Npages := 0;
                np := 0;
                presssecionnumber := 0;
              end;
            end
            Else
            Begin
              Inc(cursectionI);
              planpagenames[cursectionI].collection :=
                FormAddpressrun.RadioGroupcollection.ItemIndex;
              planpagenames[cursectionI].newedition := newed;
              newed := false;
              planpagenames[cursectionI].Npages := 0;
              ipoffset := 0;
              np := 0;
              presssecionnumber := 0;
            end;
          end;
          Inc(presssecionnumber);

          planpagenames[cursectionI].editionid :=
            tnames1.editionnametoid
            (Formeditionpageplan.StringGrideds.cells[ied, 0]);
          planpagenames[cursectionI].Npages := planpagenames[cursectionI].Npages
            + FormAddpressrun.Commastrlist[1];
          planpagenames[cursectionI].Nhalfwebpage := 0;
          planpagenames[cursectionI].Pages[0].name := 'Dinky';
          planpagenames[cursectionI].Pages[0].seci := isec;
          planpagenames[cursectionI].Pages[0].sectionid :=
            tnames1.sectionnametoid(FormAddpressrun.PBExListviewSections.items
            [isec].Caption);
          planpagenames[cursectionI].Pages[0].presssecionnumber :=
            presssecionnumber;
          planpagenames[cursectionI].Pages[0].Orgeditionid :=
            planpagenames[cursectionI].editionid;

          for ip := 1 to FormAddpressrun.Commastrlist[1] do
          begin
            Inc(np);
            pofspl := np;

            if ip <= planpagenames[cursectionI].Npages div 2 then
              pofspl := pofspl + coveroffset[isec];

            if ip > (planpagenames[cursectionI].Npages div 2) then
              pofspl := pofspl + insertoffset[isec];

            if (FormAddpressrun.PBExListviewSections.items[isec].subitems[6] <>
              '') and (namedoffset > 0) then
            begin
              PNT := FormAddpressrun.PBExListviewSections.items[isec]
                .subitems[1];
              IF (pofspl <= namedoffset) OR
                (pofspl > planpagenames[cursectionI].Npages - namedoffset) then
              Begin
                PNT := PNT + 'C';
                IF (pofspl > planpagenames[cursectionI].Npages - namedoffset)
                then
                  PNN := (namedoffset - (planpagenames[cursectionI].Npages -
                    pofspl)) + namedoffset
                else
                  PNN := pofspl;
              End
              else
              Begin
                PNN := pofspl - namedoffset;
              End;
              PNN := PNN + StrToInt(FormAddpressrun.PBExListviewSections.items
                [isec].subitems[5]); // Offset
              PNT := PNT + inttostr(PNN) + FormAddpressrun.PBExListviewSections.
                items[isec].subitems[2];

              planpagenames[cursectionI].Pages[ip + ipoffset].name := PNT;
            end
            Else
            Begin
              planpagenames[cursectionI].Pages[ip + ipoffset].name :=
                FormAddpressrun.PBExListviewSections.items[isec].subitems[1] +
                inttostr(pofspl +
                StrToInt(FormAddpressrun.PBExListviewSections.items[isec]
                .subitems[5])) + FormAddpressrun.PBExListviewSections.items
                [isec].subitems[2];
            end;

            planpagenames[cursectionI].Pages[ip + ipoffset].Pageindex :=
              pofspl + StrToInt(FormAddpressrun.PBExListviewSections.items[isec]
              .subitems[5]);

            planpagenames[cursectionI].Pages[ip + ipoffset].seci := isec;
            planpagenames[cursectionI].Pages[ip + ipoffset].sectionid :=
              tnames1.sectionnametoid(FormAddpressrun.PBExListviewSections.items
              [isec].Caption);
            planpagenames[cursectionI].Pages[ip + ipoffset].Orgeditionid :=
              Formeditionpageplan.getuniqueEdID
              (tnames1.editionIDtoname(planpagenames[cursectionI].editionid),
              planpagenames[cursectionI].Pages[ip + ipoffset].name,
              FormAddpressrun.PBExListviewSections.items[isec].Caption);

            planpagenames[cursectionI].Pages[ip + ipoffset].presssecionnumber :=
              presssecionnumber;
            IF ((planpagenames[cursectionI].Pages[ip + ipoffset]
              .name = halfwebpage1) and
              (tnames1.sectionIDtoname(planpagenames[cursectionI].Pages
              [ip + ipoffset].sectionid) = halfwebsec1)) then
              planpagenames[cursectionI].hw1 := ip + ipoffset;
            IF ((planpagenames[cursectionI].Pages[ip + ipoffset]
              .name = halfwebpage2) and
              (tnames1.sectionIDtoname(planpagenames[cursectionI].Pages
              [ip + ipoffset].sectionid) = halfwebsec2)) then
              planpagenames[cursectionI].hw2 := ip + ipoffset;

          End;

        end;
      end;

      IF ((up1Runtrhough)) or ((FormAddpressrun.CheckBoxprepaired.checked)) and
        (cursectionI > 1) then
      begin
        For presecI := 2 to cursectionI do
        begin

          PNN := planpagenames[1].Npages;

          For ip := 1 to (planpagenames[presecI].Npages DIV 2) do // fra 1 til 4
          begin
            Inc(PNN);
            planpagenames[1].Pages[PNN].pagina := planpagenames[presecI].Pages
              [ip].pagina;
            planpagenames[1].Pages[PNN] := planpagenames[presecI].Pages[ip];
            planpagenames[1].Pages[PNN].pagina := PNN;
          end;

          For ip := (planpagenames[presecI].Npages DIV 2) + 1 to planpagenames
            [presecI].Npages do // fra  -8
          begin
            Inc(PNN);
            planpagenames[1].Pages[PNN] := planpagenames[presecI].Pages[ip];
            planpagenames[1].Pages[PNN].pagina := PNN;
          end;
          planpagenames[1].Npages := PNN;

        End;
        cursectionI := 1;
      end;
    End;
  end;

  for I := 1 to cursectionI do
  Begin
    planpagenames[I].collection :=
      FormAddpressrun.RadioGroupcollection.ItemIndex;
    planpagenames[I].Prepaired := FormAddpressrun.CheckBoxprepaired.checked;
    planpagenames[I].bindingstyle :=
      FormAddpressrun.CheckBoxbindingstyle.checked;
  End;
  numberofsections := cursectionI;

  Nup := PlatetemplateArray[Formselecttemplate.Selectedtemplatenumber]
    .NupOnplate;
  Nplanpagesections := numberofsections;

  splitsections := (FormAddpressrun.Multisecplan) and (numberofsections > 1);

  AktPRODUCTION.nSectionsInProduction := numberofsections;
  AktPRODUCTION.nGeneralPageOffset := 1;
  AktPRODUCTION.nCollectionMode := 0;
  AktPRODUCTION.nSplitmode := PlatetemplateArray
    [Formselecttemplate.Selectedtemplatenumber].Splitmode;

  AktPRODUCTION.fCreepSetting := 100;
  Currentcreep := Formselecttemplate.Creep;

  For isec := 1 to AktPRODUCTION.nSectionsInProduction do
  begin
    AktPRODUCTION.aSections[isec].Nhalfwebpage := planpagenames[isec].hw1;
    AktPRODUCTION.aSections[isec].nHalfWebPage2 := planpagenames[isec].hw2;

    IF PlatetemplateArray[Formselecttemplate.Selectedtemplatenumber].ISdouble > 1
    then
      AktPRODUCTION.aSections[isec].nPagesInSection := planpagenames[isec]
        .Npages * PlatetemplateArray
        [Formselecttemplate.Selectedtemplatenumber].ISdouble
    else
      AktPRODUCTION.aSections[isec].nPagesInSection :=
        planpagenames[isec].Npages;

    MakingdoubleFrontback := PlatetemplateArray
      [Formselecttemplate.Selectedtemplatenumber].ISDoublefronttoback = 1;
    if PlatetemplateArray[Formselecttemplate.Selectedtemplatenumber]
      .Numberofblanks > 0 then
    begin
      AktPRODUCTION.aSections[isec].nPagesInSection := planpagenames[isec]
        .Npages + PlatetemplateArray[Formselecttemplate.Selectedtemplatenumber]
        .Numberofblanks;
    end;
    AktPRODUCTION.aSections[isec].nStartingPageNumber := 1;
    AktPRODUCTION.aSections[isec].nBindingStyle :=
      Integer(FormAddpressrun.CheckBoxbindingstyle.checked);
    AktPRODUCTION.aSections[isec].nFlatsInSection :=
      ((AktPRODUCTION.aSections[isec].nPagesInSection div Nup) div 2) +
      ((AktPRODUCTION.aSections[isec].nPagesInSection div Nup) MOD 2);

    AktPRODUCTION.aSections[isec].nFlatsInSection := AktPRODUCTION.aSections
      [isec].nFlatsInSection * 2;

    case (Prefs.SpecialHalfwebMode) of
      0:
        planpagenames[isec].hw1 := AktPRODUCTION.aSections[isec].nPagesInSection DIV Nup;
      1:
        planpagenames[isec].hw1 :=
          (AktPRODUCTION.aSections[isec].nPagesInSection DIV Nup) - 1;
      2:
        Begin
          planpagenames[isec].hw1 := AktPRODUCTION.aSections[isec].nPagesInSection DIV Nup;
          FixHWPage := Prefs.SpecialHalfwebAtFixedPage;
          FixHWMin := Prefs.SpecialHalfwebAtMinPage;
          if (FixHWPage < 1) then
            FixHWPage := 1;
          if (FixHWMin < 1) then
            FixHWMin := 1;

          if (AktPRODUCTION.aSections[isec].nPagesInSection >= FixHWMin) And
            (FixHWMin > 0) then
          begin
            AktPRODUCTION.aSections[isec].Nhalfwebpage := FixHWPage;
            planpagenames[isec].hw1 := FixHWPage;
          end;
        End;
    end;

    IF AktPRODUCTION.aSections[isec].nFlatsInSection <= 2 then
      planpagenames[isec].hw1 := AktPRODUCTION.aSections[isec]
        .nPagesInSection DIV Nup;

    IF planpagenames[isec].hw1 < 0 then
      planpagenames[isec].hw1 := AktPRODUCTION.aSections[isec]
        .nPagesInSection DIV Nup;

    AktPRODUCTION.aSections[isec].Nhalfwebpage := planpagenames[isec].hw1;
    AktPRODUCTION.aSections[isec].nHalfWebPage2 := planpagenames[isec].hw2;

    IF ManualImposistion then
    begin
      AktPRODUCTION.aSections[isec].nFlatsInSection := ManualNPlates div 2;
    end
    else
    begin
      // IF (*((AktPRODUCTION.aSections[isec].nPagesInSection mod nup <> 0) ) {and (nup mod 3 <> 0)} And (Not Prefs.IgnoreImposeCalcNumbering) *) false then
      // begin
      // MessageDlg(formmain.InfraLanguage1.Translate('Number of pages do not fit platelayout'), mterror,[mbOk], 0);
      // exit;
      // End;

      For iflat := 1 to AktPRODUCTION.aSections[isec].nFlatsInSection + 2 do
      begin
        NupCol := Nup;
        IF AktPRODUCTION.nSplitmode > 0 then
          NupCol := Nup * 2;

        AktPRODUCTION.aSections[isec].aFlats[iflat].bIsDualSided := 1;
        AktPRODUCTION.aSections[isec].aFlats[iflat].nPagesPerSide := NupCol;

        For isgn := 1 to NupCol do
        begin
          AktPRODUCTION.aSections[isec].aFlats[iflat].aSignaturePages[isgn] :=
            PlatetemplateArray[Formselecttemplate.Selectedtemplatenumber]
            .PageNumberingFront[isgn];
        end;
        For isgn := 1 to NupCol do
        begin
          AktPRODUCTION.aSections[isec].aFlats[iflat].aSignaturePages
            [isgn + NupCol] := PlatetemplateArray
            [Formselecttemplate.Selectedtemplatenumber].PageNumberingback[isgn];
        end;
        For isgn := 1 to NupCol do
        begin
          AktPRODUCTION.aSections[isec].aFlats[iflat].aHalfwebSignaturePages
            [isgn] := PlatetemplateArray
            [Formselecttemplate.Selectedtemplatenumber]
            .PageNumberingFrontHalfWeb[isgn];
        end;
        For isgn := 1 to NupCol do
        begin
          AktPRODUCTION.aSections[isec].aFlats[iflat].aHalfwebSignaturePages
            [isgn + NupCol] := PlatetemplateArray
            [Formselecttemplate.Selectedtemplatenumber]
            .PageNumberingBackHalfWeb[isgn];
        end;
      End;
    End;
  end;
  IF AktPRODUCTION.nSectionsInProduction = 0 then
    AktPRODUCTION.nSectionsInProduction := 1;

  For I := 1 to AktPRODUCTION.nSectionsInProduction do
  Begin
    if AktPRODUCTION.aSections[I].nFlatsInSection = 0 then
      AktPRODUCTION.aSections[I].nFlatsInSection := 1;
  End;

  IF not ManualImposistion then
  begin
    result := doImposecalc();

    For isec := 1 to AktPRODUCTION.nSectionsInProduction do
    begin

      planpagenames[isec].hw1 := 32000;
      // IF AktPRODUCTION.aSections[isec].nHalfWebPage > 0 then
      // begin
      // end;
      For iflat := 1 to AktPRODUCTION.aSections[isec].nFlatsInSection do
      begin
        For isgn := 1 to Nup do
        Begin
          IF AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages[isgn] = 0
          then
            Inc(planpagenames[isec].Nhalfwebpage);
        End;

        For isgn := 1 to Nup do
        Begin
          IF AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages
            [isgn + Nup] = 0 then
            Inc(planpagenames[isec].Nhalfwebpage);
        End;
      End;
      // planpagenames[isec].hw1 := AktPRODUCTION.aSections[isec].nPagesInSection DIV nup;
      // gammle
      planpagenames[isec].hw1 := AktPRODUCTION.aSections[isec]
        .nPagesInSection DIV Nup;

      // Ny halfwebcalc
      planpagenames[isec].hw1 :=
        (AktPRODUCTION.aSections[isec].nPagesInSection DIV Nup) - 1;
      IF AktPRODUCTION.aSections[isec].nFlatsInSection <= 2 then
        planpagenames[isec].hw1 := AktPRODUCTION.aSections[isec]
          .nPagesInSection DIV Nup;

      IF planpagenames[isec].hw1 < 0 then
        planpagenames[isec].hw1 := AktPRODUCTION.aSections[isec]
          .nPagesInSection DIV Nup;
    End;

  End
  Else
  begin
    // Manual imposition

    For isec := 1 to AktPRODUCTION.nSectionsInProduction do
    begin
      Ipage := 0;
      NManualpagesOnplates := 0;
      IF addingplate then
      Begin
        FormAddpressrun.PBExListviewSections.items[isec - 1].subitems[7] :=
          FormAddpressrun.PBExListviewSections.items[isec - 1].subitems
          [7] + ',0,0';
      end;

      MT1 := FormAddpressrun.PBExListviewSections.items[isec - 1].subitems[7];

      While MT1 <> '' do
      begin
        Inc(NManualpagesOnplates);
        IF POS(',', MT1) > 0 then
        begin
          MT2 := copy(MT1, 1, POS(',', MT1) - 1);
          delete(MT1, 1, POS(',', MT1));
        end
        else
        begin
          MT2 := MT1;
          MT1 := '';
        end;
        ManualpagesOnplates[NManualpagesOnplates] := StrToInt(MT2);

      end;
      MI1 := 0; // hvilken plade er jeg p�
      For iflat := 1 to AktPRODUCTION.aSections[isec].nFlatsInSection do
      begin
        NupCol := Nup;
        IF AktPRODUCTION.nSplitmode > 0 then
          NupCol := Nup * 2;

        AktPRODUCTION.aSections[isec].aFlats[iflat].nPagesPerSide := NupCol;

        For isgn := 1 to NupCol do
        begin
          AktPRODUCTION.aSections[isec].aFlats[iflat].aSignaturePages[isgn] :=
            PlatetemplateArray[Formselecttemplate.Selectedtemplatenumber]
            .PageNumberingFront[isgn];
        end;

        For isgn := 1 to NupCol do
        begin
          AktPRODUCTION.aSections[isec].aFlats[iflat].aSignaturePages
            [isgn + NupCol] := PlatetemplateArray
            [Formselecttemplate.Selectedtemplatenumber].PageNumberingback[isgn];
        end;
        For isgn := 1 to NupCol do
        begin
          AktPRODUCTION.aSections[isec].aFlats[iflat].aHalfwebSignaturePages
            [isgn] := PlatetemplateArray
            [Formselecttemplate.Selectedtemplatenumber]
            .PageNumberingFrontHalfWeb[isgn];
        end;
        For isgn := 1 to NupCol do
        begin
          AktPRODUCTION.aSections[isec].aFlats[iflat].aHalfwebSignaturePages
            [isgn + NupCol] := PlatetemplateArray
            [Formselecttemplate.Selectedtemplatenumber]
            .PageNumberingBackHalfWeb[isgn];
        end;

        // front
        Inc(MI1);
        MI2 := 0;
        // AktPRODUCTION.aSections[isec].aFlats[iflat].nPagesPerSide := ManualpagesOnplates[MI1];
        For I := 1 to 255 do
        begin
          AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages[I] := 0
        End;

        For I := 1 to ManualpagesOnplates[MI1] do
        begin
          Inc(Ipage);
          IF (Ipage > planpagenames[isec].Npages) then
            AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages[I] := 0
          Else
            AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages[I]
              := Ipage;

        end;
        MI2 := AktPRODUCTION.aSections[isec].aFlats[iflat].nPagesPerSide;

        Inc(MI1);
        // back
        For I := 1 to ManualpagesOnplates[MI1] do
        begin
          Inc(Ipage);
          IF (Ipage > planpagenames[isec].Npages) then
            AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages
              [MI2 + I] := 0
          Else
            AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages
              [MI2 + I] := Ipage;
        end;
      End;
    End;

    result := true;
  end;

  I := 1;
  sleep(1 * 10);

End;

Function TFormprodplan.doImposecalc: Boolean;

Var
  I: Integer;
Begin
  I := 0;
  result := false;

  if (imposeSize = 1) and (AktPRODUCTION.nSectionsInProduction > 80) then
  begin
    MessageDlg('Job too big for imposecalc', mtError, [mbOk], 0);

    result := false;
    exit;

  end;

  try
    if not FormAddpressrun.CheckBoxbackward.checked then
      I := Imposecalc(AktPRODUCTION)
    else
      I := CalculateImposeAsian(AktPRODUCTION);

    docollect();

  except
  end;
  IF I = 1 then
    result := true
  else
    result := false;
end;

Procedure TFormprodplan.getcurrentplan;
Var
  iplf: Integer;
Begin
  formmain.planlogging('getcurrentplan');
  IF Nplateframes > 0 then
  begin
    for iplf := Nplateframes downto 1 do
    begin
      plateframes[iplf].visible := false;
      plateframes[iplf].Align := alnone;
      plateframes[iplf].Height := 20;
      plateframes[iplf].Top := ScrollBoxplan.Height + (400 * Nplateframes);
    End;

    for iplf := 1 to Nplateframes do
    begin
      plateframes[iplf].Parent := ScrollBoxplan;
      plateframes[iplf].visible := true;
      plateframes[iplf].Align := altop;
      if ScrollBoxplan.Height div Nplateframes < 200 then
        plateframes[iplf].Height := 200
      else
        plateframes[iplf].Height := ScrollBoxplan.Height div Nplateframes;

      plateframes[iplf].PBExListview1.Align := alnone;
      plateframes[iplf].PBExListview1.Top := 10;
      plateframes[iplf].PBExListview1.left := 10;
      plateframes[iplf].PBExListview1.Align := alclient;

    end;

  end;

end;

procedure TFormprodplan.FormActivate(Sender: TObject);
Var
  I, iplf: Integer;

begin
  IF ActionManagerPlanning.Images = nil then
    ActionManagerPlanning.Images := FormImage.ImageList1;

  IF Not usenewpagina then
  begin
    Labelpageindex.visible := false;
    ComboBoxdefpagina.visible := false;
  end;

  MakingdoubleFrontback := false;
  IgnorePagicheck := false;
  issetting := false;
  addingplate := false;
  FoundAapplynewpage := true;
  Calledwizardtoplates := false;
  Copytopressdontshowapply := false;

  formmain.planlogging('FormActivate start');
  ScrollBoxplan.visible := false;
  CheckBoxsubedselection.checked := false;
  Editthisrun := 1;

  ComboBoxLocation.Enabled := (Editmode <> PLANADDMODE_LOAD) and
    (Editmode <= PLANADDMODE_APPLY);
  ComboBoxpress.Enabled := (Editmode <> PLANADDMODE_LOAD) and
    (Editmode <= PLANADDMODE_APPLY);
  DateTimePickerPubdate.Enabled := (Editmode <> PLANADDMODE_LOAD) and
    (Editmode <= PLANADDMODE_APPLY);
  ComboBoxPublication.Enabled := (Editmode <> PLANADDMODE_LOAD) and
    (Editmode <= PLANADDMODE_APPLY);
  EditProductionname.Enabled := (Editmode <> PLANADDMODE_LOAD) and
    (Editmode <= PLANADDMODE_APPLY);

  // Inc(Nacs);
  For iplf := 1 to Nplateframes do
  begin
    plateframes[iplf].Height := plateframes[iplf]
      .Parent.Height div Nplateframes;
    IF plateframes[iplf].Height < 200 then
      plateframes[iplf].Height := 200;
  end;

  getcurrentplan;

  IF Nplateframes > 0 then
  begin
    plateviewimage.Width := 23; // 204
    plateviewimage.Height := 51; // 176
    For I := 1 to Nplateframes do
    begin
      plateframes[I].PBExListview1.clear;
      plateframes[I].ImageListplanframe.clear;
      DrawThePlates(Formprodplan.CheckBoxsmallimagesinEdit.checked, I);
    end;

    IF plateframes[1].NProdPlates > 0 then
    begin
      Formselecttemplate.selectedtemplateid := PlatetemplateArray
        [plateframesdata[1].ProdPlates[0].templatelistid].TemplateID;
      Formselecttemplate.markgroups := plateframesdata[1].ProdPlates[0]
        .markgroups;
      Formselecttemplate.Nmarkgroups := plateframesdata[1].ProdPlates[0]
        .Nmarkgroups;
      Formselecttemplate.Selectedtemplatenumber := plateframesdata[1].ProdPlates
        [0].templatelistid;
    end;

    if plateframes[Nplateframes].Top + plateframes[Nplateframes].Height <
      ScrollBoxplan.Height then
      plateframes[Nplateframes].Align := alclient;

  End;
  ScrollBoxplan.visible := true;
  setactionenabled;
  ActiontrueSheetside.visible := Prefs.UseTrueSheetSide;

  if (Prefs.SimplePlanLoad) then
    PBExListview1.visible := false;

  if (Prefs.ShowWeekNumberInTree) then
  Begin
    Edit3.Enabled := true;
    DateTimePickerPubdate.Enabled := false;
    Edit3.Text := inttostr(WeekOf(DateTimePickerPubdate.DateTime));
  End
  else
  Begin
    Edit3.Enabled := false;
    DateTimePickerPubdate.Enabled := true;
  End;


  ActionMovepages.visible := Prefs.AllowMovePages;
  ActionMovepages.checked := false;
  Actioneditpages.checked := false;
end;

procedure TFormprodplan.CheckBoxsmallimagesinEditClick(Sender: TObject);
Var
  I: Integer;
begin
  formmain.planlogging('CheckBoxsmallimagesinEditClick');
  plateviewimage.Width := 23; // 204
  plateviewimage.Height := 51; // 176
  For I := 1 to Nplateframes do
  begin
    plateframes[I].PBExListview1.clear;
    plateframes[I].ImageListplanframe.clear;
    DrawThePlates(CheckBoxsmallimagesinEdit.checked, I);
  end;
end;

Function TFormprodplan.Wizard(selectpress: Boolean): Boolean;
// WIZZZ
Var
  wizcancel: Boolean;
  I, StepN: Integer;
  iplf: Integer;

Var
  planisok: Boolean;

begin
  result := false;
  try
    addingplate := false;
    plateframesproductionname := '';
    formmain.planlogging('Wizard start');
    Runschanged := true;
    formmain.loadids('Wizard start', false);
    wizcancel := false;
    Formproof.init;

    SelIplf := -1;
    selipl := -1;
    selip := -1;
    if selectpress then
      StepN := 1
    else
      StepN := 2;

    // IF not Remotecall then
    // Begin
    Repeat
      Case StepN of
        1:
          begin
            formmain.planlogging('Wizard step 1');
            Case FormSelectnewpress.ShowModal of
              mryes:
                Inc(StepN);
              mrno:
                Dec(StepN);
              mrcancel:
                wizcancel := true;
            end;
            plateframespressid := FormSelectnewpress.newpressid;
            ComboBoxpress.ItemIndex := ComboBoxpress.items.IndexOf(tnames1.pressnameIDtoname(plateframespressid));
          end;

        2:
          begin
            Formaddplan.Panelbigwizz.visible := true;
            formmain.planlogging('Wizard step 2');
            IF Editmode <> PLANADDMODE_APPLY then // Not apply
            begin
              Formaddplan.pressname := tnames1.pressnameIDtoname(plateframespressid);
              Formaddplan.Panelbigwizz.visible := true;
              Case Formaddplan.ShowModal of
                mryes:
                  Inc(StepN);
                mrno:
                  Dec(StepN);
                mrcancel:
                  wizcancel := true;
              end;
            end
            else
              Inc(StepN);
            plateframesproductionname := Formaddplan.planname;
            plateframesproductionid := -1;
            plateframesPubdate := Formaddplan.DateTimePicker1.Date;
            plateframespublicationid := Formaddplan.publicationid;
            EditProductionname.Text := plateframesproductionname;
          end;
        3:
          begin
            formmain.planlogging('Wizard step 3');
            Formselecttemplate.applydeftemplatename := '';
            Formselecttemplate.applydefproofname := '';

            DataM1.Query1.sql.clear;
            DataM1.Query1.sql.Add('select top 1 t1.TemplateName,pr1.ProofName from pagetable p1 (NOLOCK), ProofConfigurations pr1 (NOLOCK), TemplateConfigurations t1 (NOLOCK) ');
            DataM1.Query1.sql.Add('where p1.pressid = ' + inttostr(plateframespressid));
            DataM1.Query1.sql.Add('and p1.publicationid = ' + inttostr(plateframespublicationid));
            DataM1.Query1.sql.Add('and ' + DataM1.makedatastr('', plateframesPubdate));
            DataM1.Query1.sql.Add('and p1.proofid = pr1.proofid ');
            DataM1.Query1.sql.Add('and p1.templateid = t1.templateid ');
            try
              if Prefs.debug then
                DataM1.Query1.sql.SaveToFile
                  (IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) +
                  'sqllogs\' + 'Getproddefaults.sql');

              DataM1.Query1.open;
              IF Not DataM1.Query1.eof then
              begin
                Formselecttemplate.applydeftemplatename := DataM1.Query1.fields[0].asstring;
                Formselecttemplate.applydefproofname := DataM1.Query1.fields[1].asstring;
              end;
              DataM1.Query1.close;
            Except
            end;
            try

              DataM1.Query1.sql.clear;
              DataM1.Query1.sql.add ('select pr.ProofName,N.name From PublicationNames N, ProofConfigurations pr');
              DataM1.Query1.sql.add('where N.publicationid  = ' + IntToStr(plateframespublicationid));
              DataM1.Query1.sql.add('And PR.proofid = n.DefaultProofID');
              DataM1.Query1.open;

              IF Not DataM1.Query1.eof then
              begin
                IF Formselecttemplate.applydefproofname = '' then
                begin
                  Formselecttemplate.applydefproofname := DataM1.Query1.fields[0].asstring;
                End;

              end;
              DataM1.Query1.close;
            Except
            end;
            Formselecttemplate.Aktpressid := plateframespressid;
            Formselecttemplate.aktpublicationid := plateframespublicationid;

            Formselecttemplate.Panelwizard.visible := true;
            Formselecttemplate.Panel2.visible := true;
            Formselecttemplate.Panel3.visible := false;
            Formselecttemplate.Panel4.visible := false;

            Formselecttemplate.Panelmovepress.visible := false;
            Formselecttemplate.Aktpressname :=  tnames1.pressnameIDtoname(plateframespressid);

            Formselecttemplate.PagesAcross := -1;
            Formselecttemplate.PagesDown := -1;
            Formselecttemplate.Aktpressid := plateframespressid;
            Formselecttemplate.aktpublicationid := plateframespublicationid;

            case Formselecttemplate.ShowModal of
              mryes:
                Inc(StepN);
              mrno:
                Dec(StepN);
              mrcancel:
                wizcancel := true;
            end;
          end;
        4:
          begin
            formmain.planlogging('Wizard step 4');
            FormAddpressrun.Panela.visible := true;
            FormAddpressrun.Panelb.visible := false;
            Case FormAddpressrun.ShowModal of
              mryes:
                Inc(StepN);
              mrno:
                Dec(StepN);
              mrcancel:
                wizcancel := true;
            End;
          end;
        5:
          begin
            lookforcenterspread;
            formmain.planlogging('Wizard step 5');
            if (Prefs.Proversion > 0) or (tnames1.Editionnames.count < 2) then
            begin
              Formeditionpageplan.NEditions := 1;
              IF Newimpositioncalulation('', '', '', '') then
              begin
                Formeditionpageplan.init;
                Inc(StepN);
              End
              else
              begin
                MessageDlg(formmain.InfraLanguage1.Translate ('Error preparing plan'), mtInformation, [mbOk], 0);
                StepN := 4;
              end;
            end
            else
            begin
              Formeditionpageplan.NEditions := 1;
              IF Newimpositioncalulation('', '', '', '') then
              begin
                IF (Prefs.PartialNoEditionChange) AND
                  (Formprodplan.PartialPlanning) then
                begin
                  IF Newimpositioncalulation('', '', '', '') then
                  begin
                    Formeditionpageplan.init;
                    Inc(StepN);
                  End
                  else
                  begin
                    MessageDlg(formmain.InfraLanguage1.Translate
                      ('Error preparing plan'), mtInformation, [mbOk], 0);
                    StepN := 4;
                  end;
                end
                else
                begin
                  Case Formeditionpageplan.ShowModal of
                    mryes:
                      Inc(StepN);
                    mrno:
                      Dec(StepN);
                    mrcancel:
                      wizcancel := true;
                  end;
                End;
              End
              Else
              Begin
                MessageDlg(formmain.InfraLanguage1.Translate
                  ('Unable to prepare plan'), mtInformation, [mbOk], 0);
                StepN := 4;
              end;
            End;
          End;
      end;
    until ((StepN = 0) and (selectpress)) or ((StepN = 1) and (not selectpress)) or (StepN = 6) or (wizcancel);

    formmain.planlogging('Wizard End of step');
    (* end
      Else
      Begin
      Formeditionpageplan.NEditions := 1;

      IF Newimpositioncalulation('','','','') then
      begin
      //Formeditionpageplan.remoteinit;
      Formeditionpageplan.setresult;
      End;
      StepN := 6;
      end; *)

    IF (Not wizcancel) and (StepN = 6) then
    begin
      plateframesPubdate := Formaddplan.DateTimePicker1.Date;
      planisok := true;
      GetprodrundatafromUI;

      IF (planningaction <> PLANADDMODE_COPY) (* And (not Remotecall) *) then
      begin
        IF unplannedexists then
        begin
          MessageDlg(formmain.InfraLanguage1.Translate('There are unplanned pages for this publication - a plan must be Applied from main menu'), mtWarning, [mbOk], 0);
        end;
      end;

      IF not planisok then
      begin
        // der er noget galt med plannen
      end;

      IF planisok then
      begin
        Validplancolors := '';
        For I := 0 to FormAddpressrun.CheckListBoxcolors.items.count - 1 do
        begin
          if FormAddpressrun.CheckListBoxcolors.checked[I] then
          begin
            if (Validplancolors <> '') then
              Validplancolors := Validplancolors + ',';
            Validplancolors := Validplancolors + inttostr(tnames1.Colornametoid(FormAddpressrun.CheckListBoxcolors.items[I]));
          end;
        end;
        Validplancolors := '(' + Validplancolors + ')';

        prodcombined := 0;
        // Integer(FormAddpressrun.CheckBoxCombinetoonerunX.Checked);
        prodbindingstyle := Integer(FormAddpressrun.CheckBoxbindingstyle.checked);
        prodcollection := FormAddpressrun.RadioGroupcollection.ItemIndex;
        prodplancreep := Formselecttemplate.Creep;
        Currentcreep := Formselecttemplate.Creep;
        prodplannedhold := Formaddplan.RadioGrouplocked.ItemIndex;
        prodplannedapproval := Formaddplan.RadioGroupApproval.ItemIndex;

        // WizardHW :=0;
        if Newimpositioncalulation('', '', '', '') then
        begin
          plateframesproductionname := Formaddplan.planname;
          plateframesproductionid := -1;

          if NOT usenewpagina then
            calulatepagina;

          Wizardtoplates;
          IF Editmode = PLANADDMODE_APPLY then
            findunplannedUniquepages;

          IF (Editmode >= PLANADDMODE_APPLY) And (Applyonlyplannedcolors) then
          Begin
            Keeponplannedcolors;

          End;

          setdinkydata(1);
          applyglobdata(1, plateframesproductionid, Formaddplan.publicationid,
            plateframeslocationid, plateframespressid,
            inittypes.gettemplatenumberfromID
            (Formselecttemplate.selectedtemplateid),
            inittypes.gettemplatenumberfromID
            (Formselecttemplate.selectedtemplateid),
            Formselecttemplate.Selectedcolorproofid,
            Formselecttemplate.Selectedmonoproofid,
            Formselecttemplate.Selectedpdfproofid,
            Formselecttemplate.Nmarkgroups, Formselecttemplate.markgroups);
          genmiscstring;
          findorgedpages;
          copyplantoplanpages;
          checktowers;
          lookforcenterspread;

          for I := 1 to Nplateframes do
          begin
            IF CheckBoxsmallimagesinEdit.checked then
              Pressviewzoom := 60
            else
              Pressviewzoom := 100;

            plateviewimage.Width := 23; // 204
            plateviewimage.Height := 51; // 176

            DrawThePlates(CheckBoxsmallimagesinEdit.checked, I);
          end;

        End;
      end;
      result := true;
    End;

  except
  end;

  Newcalulatepagina;

  IF Nplateframes > 0 then
  begin
    pressruncaptionnames;
    plateframes[1].Selected := true;
    for iplf := 1 to Nplateframes do
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
  end;
  EditProductionname.Text := plateframesproductionname;
  setactionenabled;
  formmain.planlogging('Wizard End');
end;

Procedure TFormprodplan.Wizardtoplates;

  Function getplansectionname(isec: Integer): Integer;
  Var
    T: string;
  Begin
    T := FormAddpressrun.PBExListviewSections.items[isec].Caption;

    result := tnames1.sectionnametoid(T);

  end;

Var
  iplf, ic, Iplateframe, ied, isec, iflat, ifront, outp, sheet, isgn: Integer;
  nSections, NEditions, nplates: Integer;
  Nsheet: Integer;
  Sectioncounter: Integer;
  I: Integer;
  pagetypes: TPageNumbering;
  antipanoposes: TPageNumbering;
  Nnewcolors: Integer;
  Nprods: Integer;
  icopy: Integer;
  Newcolors: Array [1 .. 100] of record ColorID: Integer;
  colorname: String;
  Doubleburn: Boolean;
end;

// Akteditionname : string;
HINprods, Aktncopies: Integer;
DefaultRipSetupID:
Integer;
NProdPlates:
Integer;
Begin
  // NprodplatesSize     Fixed
  formmain.planlogging('Wizard to plates');
  Calledwizardtoplates := true;
  try
    formmain.Deallocateplateframes;

    IF CheckBoxsmallimagesinEdit.checked then
      Pressviewzoom := 60
    else
      Pressviewzoom := 100;

    plateviewimage.Width := 23; // 204
    plateviewimage.Height := 51; // 176

    for I := 1 to PlatetemplateArray[Formselecttemplate.Selectedtemplatenumber]
      .NupOnplate do
    begin
      antipanoposes[I] := formmain.Supergetantipos(I, pagetypes,
        Formselecttemplate.Selectedtemplatenumber, true);
    end;
    Nnewcolors := 0;

    for I := 0 to FormAddpressrun.CheckListBoxcolors.items.count - 1 do
    begin
      if FormAddpressrun.CheckListBoxcolors.checked[I] then
      begin
        Inc(Nnewcolors);
        Newcolors[Nnewcolors].ColorID :=
          tnames1.Colornametoid(FormAddpressrun.CheckListBoxcolors.items[I]);
        Newcolors[Nnewcolors].colorname :=
          FormAddpressrun.CheckListBoxcolors.items[I];
        Newcolors[Nnewcolors].Doubleburn := false;
      end;
    end;

    nplates := 0;

    Nplateframes := 0;
    Nsheet := 0;

    Nplateframes := AktPRODUCTION.nSectionsInProduction;

    IF Formprodplan.Showing then
      formmain.allocateplateframes(ScrollBoxplan, Nplateframes)
    else
      formmain.allocateplateframes(formmain.ScrollBoxplanmain, Nplateframes);

    Iplateframe := 1;

    NEditions := Formeditionpageplan.StringGrideds.ColCount - 1;
    IF NEditions > 1 then
    begin
      nSections := AktPRODUCTION.nSectionsInProduction div NEditions;
    end
    else
    begin
      nSections := AktPRODUCTION.nSectionsInProduction;
    end;
    ied := 0;
    Sectioncounter := 0;

    DefaultRipSetupID := GenerateRipSetupID(plateframespublicationid,
      plateframespressid);

    DataM1.Query1.sql.clear;
    DataM1.Query1.sql.add
      ('select Distinct pagename from pagetable WITH (NOLOCK) ');
    DataM1.Query1.sql.add('where publicationid = ' +
      inttostr(plateframespublicationid));
    DataM1.Query1.sql.add('and ' + DataM1.makedatastr('', plateframesPubdate));
    DataM1.Query1.sql.add('and pagetype = 3');
    DataM1.Query1.open;
    Numberofhalfweb := 0;
    While not DataM1.Query1.eof do
    begin
      Inc(Numberofhalfweb);
      DataM1.Query1.next;
    end;
    DataM1.Query1.close;

    HINprods := 0;

    For isec := 1 to AktPRODUCTION.nSectionsInProduction do
    Begin
      Nprods := (AktPRODUCTION.aSections[isec].nFlatsInSection *
        StrToInt(FormAddpressrun.editCopies.Text)) * 2;
      IF Nprods > HINprods then
        HINprods := Nprods;
    End;

    For isec := 1 to AktPRODUCTION.nSectionsInProduction do
    Begin
      formmain.Allocateprodplates(isec, HINprods + 32);
    End;

    For isec := 1 to AktPRODUCTION.nSectionsInProduction do
    Begin
      sheet := 0;
      Inc(Sectioncounter);
      IF (Sectioncounter = nSections) or (ied = 0) then
      begin
        Inc(ied);
        Sectioncounter := 0;
      end;

      // Akteditionname := Formeditionpageplan.StringGrideds.cells[Ied,0];

      For iflat := 1 to AktPRODUCTION.aSections[isec].nFlatsInSection do
      begin
        Inc(sheet);
        Aktncopies := StrToInt(FormAddpressrun.editCopies.Text);
        plateframes[Iplateframe].Numberofcopies :=
          StrToInt(FormAddpressrun.editCopies.Text);

        for icopy := 1 to Aktncopies do
        begin

          Inc(plateframes[Iplateframe].NProdPlates);
          NProdPlates := plateframes[Iplateframe].NProdPlates;

          plateframesdata[Iplateframe].ProdPlates[NProdPlates]
            .sheetnumber := sheet;
          plateframesdata[Iplateframe].ProdPlates[NProdPlates].Front := 0;
          plateframesdata[Iplateframe].ProdPlates[NProdPlates].TrueFront := 0;

          plateframesdata[Iplateframe].ProdPlates[NProdPlates].templatelistid :=
            Formselecttemplate.Selectedtemplatenumber;
          plateframesdata[Iplateframe].ProdPlates[NProdPlates].markgroups :=
            Formselecttemplate.markgroups;
          plateframesdata[Iplateframe].ProdPlates[NProdPlates].Nmarkgroups :=
            Formselecttemplate.Nmarkgroups;

          plateframesdata[Iplateframe].ProdPlates[NProdPlates]
            .Copynumber := icopy;
          // plateframesdata[Iplateframe].prodplates[Nprodplates].Ncopies  := Aktncopies;

          plateframesdata[Iplateframe].ProdPlates[NProdPlates]
            .productionid := 0;
          plateframesdata[Iplateframe].ProdPlates[NProdPlates].publicationid :=
            Formaddplan.publicationid;

          plateframesdata[Iplateframe].ProdPlates[NProdPlates].Locationid :=
            plateframeslocationid;
          plateframesdata[Iplateframe].ProdPlates[NProdPlates].deviceid := 0;
          plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pressid :=
            plateframespressid;
          plateframesdata[Iplateframe].ProdPlates[NProdPlates].runid := -99;
          // nyt pressrunid skal laves
          plateframesdata[Iplateframe].ProdPlates[NProdPlates].produce := false;
          plateframesdata[Iplateframe].ProdPlates[NProdPlates]
            .readytoproduce := false;
          plateframesdata[Iplateframe].ProdPlates[NProdPlates]
            .someerror := false;
          plateframesdata[Iplateframe].ProdPlates[NProdPlates].totappr :=
            Formaddplan.RadioGroupApproval.ItemIndex - 1;
          plateframesdata[Iplateframe].ProdPlates[NProdPlates].totstat := 0;
          plateframesdata[Iplateframe].ProdPlates[NProdPlates].editionid :=
            planpagenames[isec].editionid;

          For isgn := 1 to AktPRODUCTION.aSections[isec].aFlats[iflat]
            .nPagesPerSide do // front
          Begin
            plateframesdata[Iplateframe].collection := planpagenames[isec]
              .collection;
            plateframesdata[Iplateframe].Prepaired := planpagenames[isec]
              .Prepaired;
            plateframesdata[Iplateframe].bindingstyle := planpagenames[isec]
              .bindingstyle;
            plateframesdata[Iplateframe].ProdPlates[NProdPlates]
              .Presssectionnumber := planpagenames[isec].Pages
              [AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages[isgn]]
              .presssecionnumber;
            plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
              .pagename := planpagenames[isec].Pages
              [AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages
              [isgn]].name;
            plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
              .pagina := planpagenames[isec].Pages
              [AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages
              [isgn]].pagina;
            plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
              .Pageindex := planpagenames[isec].Pages
              [AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages[isgn]]
              .Pageindex;
            plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
              .sectionid := getplansectionname
              (planpagenames[isec].Pages[AktPRODUCTION.aSections[isec].aFlats
              [iflat].aOutputPages[isgn]].seci);
            plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
              .Oldrunid := -99;
            plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
              .totapproval := Formaddplan.RadioGroupApproval.ItemIndex - 1;
            plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
              .Anyheld := Formaddplan.RadioGrouplocked.ItemIndex = 0;
            plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
              .Antipanorama := 0;
            plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
              .pagetype := 0;
            plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
              .Creep := AktPRODUCTION.aSections[isec].aFlats[iflat]
              .aCreep[isgn];
            plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
              .Ncolors := Nnewcolors;
            plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
              .pagestatus := 0;
            plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
              .proofed := false;
            plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
              .approved := Formaddplan.RadioGroupApproval.ItemIndex - 1;
            plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
              .pagechange := false;
            plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
              .Orgeditionid := planpagenames[isec].Pages
              [AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages[isgn]]
              .Orgeditionid;

            IF plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
              .Orgeditionid = plateframesdata[Iplateframe].ProdPlates
              [NProdPlates].editionid then
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .totUniquePage := 1
            else
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .totUniquePage := 0;

            // #####
            // plateframesdata[Iplateframe].prodplates[Nprodplates].Pages[isgn].RipSetupID := DefaultRipSetupID;

            For ic := 1 to Nnewcolors do
            begin
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[ic].ColorID := Newcolors[ic].ColorID;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[ic].DoubleBurned := Newcolors[ic].Doubleburn;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[ic].Copynumber := icopy;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[ic].Uniquepage := plateframesdata[Iplateframe]
                .ProdPlates[NProdPlates].Pages[isgn].totUniquePage;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[ic].active := 1;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[ic].status := 0;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[ic].proofstatus := 0;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[ic].Priority := 50;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[ic].Hold := Formaddplan.RadioGrouplocked.ItemIndex;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[ic].stackpos :=
                SetPlanIDFromname(2, Formselecttemplate.ComboBoxstackpos.Text);
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Tower := -1;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[ic].High := -1;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[ic].Cylinder := -1;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Zone := -1;
            end;

            IF AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages[isgn] = 0
            then
            begin
              Inc(Numberofhalfweb);
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .pagetype := 3;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .pagename := 'Dinkey' +
                inttostr((Iplateframe * 100) + Numberofhalfweb);
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .Ncolors := 1;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .Oldrunid := -1;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[1].ColorID := 6;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[1].DoubleBurned := false;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[1].Copynumber := icopy;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[1].Uniquepage := plateframesdata[Iplateframe].ProdPlates
                [NProdPlates].Pages[isgn].totUniquePage;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[1].active := 1;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[1].status := 0;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[1].proofstatus := 0;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[1].Priority := 50;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[1].Hold := Formaddplan.RadioGrouplocked.ItemIndex;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[1].stackpos :=
                SetPlanIDFromname(2, Formselecttemplate.ComboBoxstackpos.Text);
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Tower := -1;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[1].High := -1;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[1].Cylinder := -1;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Zone := -1;
            end;

          End;

        End;

        for icopy := 1 to Aktncopies do
        begin

          // back

          Inc(plateframes[Iplateframe].NProdPlates);
          NProdPlates := plateframes[Iplateframe].NProdPlates;

          plateframesdata[Iplateframe].ProdPlates[NProdPlates].editionid :=
            planpagenames[isec].editionid;
          plateframesdata[Iplateframe].ProdPlates[NProdPlates]
            .sheetnumber := sheet;
          plateframesdata[Iplateframe].ProdPlates[NProdPlates].Front := 1;
          plateframesdata[Iplateframe].ProdPlates[NProdPlates].TrueFront := 1;
          plateframesdata[Iplateframe].ProdPlates[NProdPlates].templatelistid :=
            Formselecttemplate.Selectedtemplatenumber;
          plateframesdata[Iplateframe].ProdPlates[NProdPlates]
            .Copynumber := icopy;
          // plateframesdata[Iplateframe].prodplates[Nprodplates].Ncopies := aktncopies;
          plateframesdata[Iplateframe].ProdPlates[NProdPlates]
            .productionid := 0;
          plateframesdata[Iplateframe].ProdPlates[NProdPlates].publicationid :=
            Formaddplan.publicationid;
          plateframesdata[Iplateframe].ProdPlates[NProdPlates].Locationid :=
            plateframeslocationid;
          plateframesdata[Iplateframe].ProdPlates[NProdPlates].deviceid := 0;
          plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pressid :=
            plateframespressid;
          plateframesdata[Iplateframe].ProdPlates[NProdPlates].runid := -99;
          plateframesdata[Iplateframe].ProdPlates[NProdPlates].produce := false;
          plateframesdata[Iplateframe].ProdPlates[NProdPlates]
            .readytoproduce := false;
          plateframesdata[Iplateframe].ProdPlates[NProdPlates]
            .someerror := false;
          plateframesdata[Iplateframe].ProdPlates[NProdPlates].totappr :=
            Formaddplan.RadioGroupApproval.ItemIndex - 1;
          plateframesdata[Iplateframe].ProdPlates[NProdPlates].totstat := 0;

          For isgn := 1 to AktPRODUCTION.aSections[isec].aFlats[iflat]
            .nPagesPerSide do
          Begin
            plateframesdata[Iplateframe].collection := planpagenames[isec]
              .collection;
            plateframesdata[Iplateframe].Prepaired := planpagenames[isec]
              .Prepaired;
            plateframesdata[Iplateframe].bindingstyle := planpagenames[isec]
              .bindingstyle;

            plateframesdata[Iplateframe].ProdPlates[NProdPlates]
              .Presssectionnumber := planpagenames[isec].Pages
              [AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages
              [isgn + AktPRODUCTION.aSections[isec].aFlats[iflat].nPagesPerSide]
              ].presssecionnumber;

            plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
              .pagename := planpagenames[isec].Pages
              [AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages
              [isgn + AktPRODUCTION.aSections[isec].aFlats[iflat]
              .nPagesPerSide]].name;

            plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
              .pagina := planpagenames[isec].Pages
              [AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages
              [isgn + AktPRODUCTION.aSections[isec].aFlats[iflat]
              .nPagesPerSide]].pagina;

            plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
              .Pageindex := planpagenames[isec].Pages
              [AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages
              [isgn + AktPRODUCTION.aSections[isec].aFlats[iflat].nPagesPerSide]
              ].Pageindex;

            plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
              .sectionid := getplansectionname
              (planpagenames[isec].Pages[AktPRODUCTION.aSections[isec].aFlats
              [iflat].aOutputPages[isgn + AktPRODUCTION.aSections[isec].aFlats
              [iflat].nPagesPerSide]].seci);

            plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
              .totapproval := Formaddplan.RadioGroupApproval.ItemIndex - 1;
            plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
              .Oldrunid := -1;
            plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
              .Anyheld := Formaddplan.RadioGrouplocked.ItemIndex = 0;
            plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
              .Antipanorama := 0;
            plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
              .pagetype := 0;
            plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
              .Creep := AktPRODUCTION.aSections[isec].aFlats[iflat].aCreep
              [isgn + AktPRODUCTION.aSections[isec].aFlats[iflat]
              .nPagesPerSide];
            plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
              .Ncolors := Nnewcolors;
            plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
              .pagestatus := 0;
            plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
              .proofed := false;
            plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
              .approved := Formaddplan.RadioGroupApproval.ItemIndex - 1;
            plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
              .pagechange := false;
            plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
              .Orgeditionid := planpagenames[isec].Pages
              [AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages
              [isgn + AktPRODUCTION.aSections[isec].aFlats[iflat].nPagesPerSide]
              ].Orgeditionid;

            IF plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
              .Orgeditionid = plateframesdata[Iplateframe].ProdPlates
              [NProdPlates].editionid then
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .totUniquePage := 1
            else
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .totUniquePage := 0;

            For ic := 1 to Nnewcolors do
            begin

              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[ic].ColorID := Newcolors[ic].ColorID;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[ic].DoubleBurned := Newcolors[ic].Doubleburn;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[ic].Copynumber := icopy;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[ic].Uniquepage := plateframesdata[Iplateframe]
                .ProdPlates[NProdPlates].Pages[isgn].totUniquePage;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[ic].active := 1;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[ic].status := 0;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[ic].proofstatus := 0;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[ic].Priority := 50;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[ic].Hold := Formaddplan.RadioGrouplocked.ItemIndex;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[ic].stackpos :=
                SetPlanIDFromname(2, Formselecttemplate.ComboBoxstackpos.Text);

              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Tower := -1;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[ic].High := -1;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[ic].Cylinder := -1;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Zone := -1;
            end;

            IF AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages
              [isgn + AktPRODUCTION.aSections[isec].aFlats[iflat]
              .nPagesPerSide] = 0 then
            begin
              Inc(Numberofhalfweb);
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .pagetype := 3;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .pagename := 'Dinkey' +
                inttostr((Iplateframe * 100) + Numberofhalfweb);
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .Ncolors := 1;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .Oldrunid := -1;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[1].ColorID := 6;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[1].DoubleBurned := Newcolors[1].Doubleburn;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[1].Copynumber := icopy;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[1].Uniquepage := plateframesdata[Iplateframe].ProdPlates
                [NProdPlates].Pages[isgn].totUniquePage;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[1].active := 1;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[1].status := 0;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[1].proofstatus := 0;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[1].Priority := 50;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[1].Hold := Formaddplan.RadioGrouplocked.ItemIndex;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[1].stackpos :=
                SetPlanIDFromname(2, Formselecttemplate.ComboBoxstackpos.Text);
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Tower := -1;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[1].High := -1;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Pages[isgn]
                .colors[1].Cylinder := -1;
              plateframesdata[Iplateframe].ProdPlates[NProdPlates].Zone := -1;
            end;
          End;
        End; // Icopies
      End;

      Inc(Iplateframe);

    End; // for isec
    for Iplateframe := 1 to Nplateframes do
    begin
      plateframes[Iplateframe].SequenceNumber := Iplateframe;
      plateframes[Iplateframe].productiontime := 0;
      plateframes[Iplateframe].PriorityBeforeHottime :=
        StrToInt(Formaddplan.Editpriority.Text);
      plateframes[Iplateframe].PriorityDuringHottime :=
        StrToInt(Formaddplan.Editpriority.Text);
      plateframes[Iplateframe].PriorityAfterHottime :=
        StrToInt(Formaddplan.Editpriority.Text);
      plateframes[Iplateframe].PriorityHottimeBegin := 0;
      plateframes[Iplateframe].PriorityHottimeEnd := 0;
      plateframes[Iplateframe].Comment := '';
      plateframes[Iplateframe].order := '';
      plateframes[Iplateframe].PressConfignameX := '';
      plateframes[Iplateframe].Inkcomment := '';
      plateframes[Iplateframe].perfecktbound :=
        Integer(FormAddpressrun.CheckBoxbindingstyle.checked);
      plateframes[Iplateframe].inserted :=
        FormAddpressrun.RadioGroupcollection.ItemIndex;
      plateframes[Iplateframe].Backwards :=
        Integer(FormAddpressrun.CheckBoxbackward.checked);

    end;
  except
  end;
  formmain.planlogging('Wizard to plates End');

  lookforcenterspread;

end;

Procedure TFormprodplan.calulatepagina;
Var
  Aktpresssecionnumber, aktsectionid, aktedid, isec, Ipage: Integer;
  pagina
  // ,i
    : Integer;

Begin
  formmain.planlogging('calulatepagina');

  aktedid := -1;
  aktsectionid := -1;
  Aktpresssecionnumber := -1;
  pagina := 0;

  For isec := 1 to Nplanpagesections do
  begin
    IF (splitsections) And (not Prefs.PlanningRunThroughPagination) then
    Begin
      pagina := 0;
    end;

    for Ipage := 1 to planpagenames[isec].Npages do
    begin
      IF (aktedid <> planpagenames[isec].editionid) or
        ((not Prefs.PlanningRunThroughPagination) and
        (Aktpresssecionnumber <> planpagenames[isec].Pages[Ipage]
        .presssecionnumber)) or ((not Prefs.PlanningRunThroughPagination) and
        (aktsectionid <> planpagenames[isec].Pages[Ipage].sectionid)) then
      Begin
        IF (planpagenames[isec].collection = 0) and
          (not planpagenames[isec].Prepaired) then
        begin
          pagina := 0;
        End;
        aktedid := planpagenames[isec].editionid;
        aktsectionid := planpagenames[isec].Pages[Ipage].sectionid;
        Aktpresssecionnumber := planpagenames[isec].Pages[Ipage]
          .presssecionnumber;
      end;
      Inc(pagina);
      planpagenames[isec].Pages[Ipage].pagina := pagina;
    End;
  End;
  formmain.planlogging('calulatepagina End');

end;

Procedure TFormprodplan.CalculatePaginaAfterCombine(method: Integer);
Var
  Aktpresssecionnumber, aktedid, isec, Ipage, ied: Integer;
  pagina, I, iplf, ipl, ip: Integer;
  foundpagina: Boolean;
  PagesInSection: Integer;
  SubEditionList: TList<Integer>;
  FirstEdition: Integer;
Begin

  FirstEdition := planpagenames[1].editionid;
  SubEditionList := TList<Integer>.Create;
  for isec := 1 to Nplanpagesections do
  begin
    if (planpagenames[isec].editionid <> FirstEdition) and
      (not SubEditionList.Contains(planpagenames[isec].editionid)) then
      SubEditionList.add(planpagenames[isec].editionid);
  end;

  aktedid := -1;
  Aktpresssecionnumber := -1;

  // Set pagination on first edition

  case (method) of
    0:
      begin // Run-through inserted
        // first half
        pagina := 1;
        for isec := 1 to Nplanpagesections do
        begin
          if (planpagenames[isec].editionid = FirstEdition) then
          begin
            for Ipage := 1 to planpagenames[isec].Npages div 2 do
            begin
              planpagenames[isec].Pages[Ipage].pagina := pagina;
              Inc(pagina);
            end;
          end;
        end;

        // second half
        For isec := Nplanpagesections downto 1 do
        begin
          if (planpagenames[isec].editionid = FirstEdition) then
          begin
            for Ipage := (planpagenames[isec].Npages div 2) + 1 to planpagenames
              [isec].Npages do
            begin
              planpagenames[isec].Pages[Ipage].pagina := pagina;
              Inc(pagina);
            end;
          end;
        end;
      end;

    1:
      begin // Run-through consecutive..
        pagina := 1;
        for isec := 1 to Nplanpagesections do
        begin
          if (planpagenames[isec].editionid = FirstEdition) then
          begin
            for Ipage := 1 to planpagenames[isec].Npages do
            begin
              planpagenames[isec].Pages[Ipage].pagina := pagina;
              Inc(pagina);
            end;
          end;
        end;
      end;

    2:
      begin // Section by section
        For isec := 1 to Nplanpagesections do
        begin
          if (planpagenames[isec].editionid = FirstEdition) then
          begin
            pagina := 1;
            for Ipage := 1 to planpagenames[isec].Npages div 2 do
            begin
              planpagenames[isec].Pages[Ipage].pagina := pagina;
              Inc(pagina);
            end;
          end;
        end;
      end;

  end;

  // Copy planpagenames-structure pagina to plateframesdata structure pagina
  for iplf := 1 to Nplateframes do
  begin
    for ipl := 0 to plateframes[iplf].NProdPlates do
    begin
      for ip := 1 to PlatetemplateArray
        [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
      begin

        foundpagina := false;
        for isec := 1 to Nplanpagesections do
        begin
          for Ipage := 1 to planpagenames[isec].Npages do
          begin
            if (planpagenames[isec].Pages[Ipage].name = plateframesdata[iplf]
              .ProdPlates[ipl].Pages[ip].pagename) and
              (planpagenames[isec].Pages[Ipage].sectionid = plateframesdata
              [iplf].ProdPlates[ipl].Pages[ip].sectionid) then
            begin
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagina :=
                planpagenames[isec].Pages[Ipage].pagina;
              foundpagina := true;
              break;
            end;
          end;
          if (foundpagina) then
            break;
        end;

      end;
    end;
  end;

  formmain.planlogging('CalculatePaginaAfterCombine End');
  SubEditionList.Free;
end;

Procedure TFormprodplan.Incrementpresssections;
Var
  akttopprss, iplf, ipl: Integer;
Begin

  if not JustAlayoutchange then
  begin
    Try
      formmain.planlogging('Incrementpresssections');
      akttopprss := 0;
      DataM1.Query1.sql.clear;
      DataM1.Query1.sql.add
        ('SELECT MIN(PressSectionNumber) FROM PageTable WITH (NOLOCK) ');

      // ## NAN 20160314   - PressID - ikke LocationID
      // DataM1.Query1.SQL.add('WHERE locationid = '+inttostr(plateframeslocationid));
      DataM1.Query1.sql.add('WHERE PressID = ' + inttostr(plateframespressid));

      DataM1.Query1.sql.add('AND publicationid = ' +
        inttostr(plateframespublicationid));
      DataM1.Query1.sql.add('AND ' + DataM1.makedatastr('',
        plateframesPubdate));

      akttopprss := 0;
      if Prefs.debug then
        DataM1.Query1.sql.SaveToFile
          (IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'
          + 'presssectionnumber.sql');
      formmain.Tryopen(DataM1.Query1);
      IF not DataM1.Query1.eof then
      begin
        akttopprss := DataM1.Query1.fields[0].asinteger;
      end;
      DataM1.Query1.close;

      Inc(akttopprss);
      For iplf := 1 to Nplateframes do
      begin
        For ipl := 0 to plateframes[iplf].NProdPlates do
        begin
          plateframesdata[iplf].ProdPlates[ipl].Presssectionnumber :=
            akttopprss;
        End;
        Inc(akttopprss);
      End;
    Except
    end;
    formmain.planlogging('Incrementpresssections End');
  end;
end;

// This will do the actual db apply
function TFormprodplan.RunProduction(frommain: Boolean): Boolean;
var
  Flatproofconfig, hardproofconfig: Integer;
  mExtracopies: Integer;
  totnewprod: Boolean;
  prcount, iplf, ipl, ishpl: Integer;
  proofid, Hproofid: Integer;
  AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond: Word;
begin
  mExtracopies := 0;
  totnewprod := false;
  try
    try

      Plantimming.clear;
      Plantimer := now;
      plantimdadd('Start ');
      CheckForUniquePlates();

      (*
        IF editmode=PLANADDMODE_APPLY then
        begin
        lookforexistingplansepnum;
        Checkifallareapply;
        end;
      *)

      plancenteristoold := false;
      result := false;
      NApplieddata := 0;
      Anyerrosduringrun := false;
      formmain.planlogging('runproduction');
      formmain.Setplanlock(true);

      appendsec := 0;
      findingsec := 0;
      insertsec := 0;

      prcount := 0;

      For iplf := 1 to Nplateframes do
      begin
        plateframesdata[iplf].runSequenceNumber := iplf;
        For ishpl := 0 to plateframes[iplf].NProdPlates do
        begin
          Inc(prcount);
        end;
      end;

      ForceToMainEdition();

      if not frommain then
      begin
        ProgressBarprod.Position := 0;
        ProgressBarprod.Max := prcount * 2;
      end
      else
      begin
        formmain.ProgressBarmain.Position := 0;
        formmain.ProgressBarmain.Max := prcount * 2;
        formmain.setGroupBoxworking;
      end;

      if ((Runschanged) and (not JustAlayoutchange)) then
        SetPressrunIds()
      else
        SetPressrunIdsToDBrunId();

      // ny sletning af dinkeys

      MakeInSectionIds();

      GetProductionColors();

      GenMiscstring(); // PlateName

      if (Prefs.PlanningUseImportCenter) AND (Prefs.UseMultiPressTemplateLoad = false) then
      begin

        XMLPressID := plateframespressid;
        XMLPublicationID := plateframespublicationid;
        XMLPubdate := plateframesPubdate;

        XMLRipSetup := FormApplyproduction.ComboBoxRipSetupname.Text;
        XMLPreflightSetup := FormApplyproduction.ComboBoxPreflightSetup.Text;
        XMLInkSaveSetup := FormApplyproduction.ComboBoxInksaveSetup.Text;
        XMLSpecificDevice := FormApplyproduction.ComboBoxdevice.Text;
        if (XMLSpecificDevice = 'Use workload') then
          XMLSpecificDevice := '';

        Formprodplan.copyplantoplanpages;
        DataModuleXML.TransferplantoAXML(false);
        DataModuleXML.maketransxmls();
        formmain.GroupBoxworking.visible := false;
        exit;
      end
      else
      begin
        DataM1.Query1.sql.clear;
        DataM1.Query1.sql.add('Select top 1 copyseparationset from pagetable WITH (NOLOCK) where ');
        DataM1.Query1.sql.add('publicationid = ' + inttostr(plateframespublicationid));
        if (FormApplyproduction.CheckBoxpressSpecifik.checked) and (plateframespressid>0) then
        begin
          DataM1.Query1.sql.add('AND pressid = ' + inttostr(plateframespressid));
        end;
        DataM1.Query1.sql.add('and ' + DataM1.makedatastr('',plateframesPubdate));
        DataM1.Query1.open;
        if Prefs.debug then
          DataM1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\' + 'queryplan1.sql');
        totnewprod := DataM1.Query1.eof;
        DataM1.Query1.close;


        // if (editmode = PLANADDMODE_APPLY) and (Not FoundAapplynewpage) and (false) then
        // LookApplyData;

        writeMainlogfile('RunProduction: After LookApplyData');

        // Slet eksisterende dinky sider  (Overwrite moe)
        IF (FormApplyproduction.RadioGroupApplymode.ItemIndex = 0) and (Editmode <> PLANADDMODE_MULTISAVE) then
        begin
          For iplf := 1 to Nplateframes do
          begin
            if Formprodplan.PartialPlanning then      // ?????????????????????????????? not   Formprodplan.PartialPlanning ??
            Begin
              DataM1.Query1.sql.clear;
              DataM1.Query1.sql.add('DELETE FROM PageTable WHERE PageType = 3');
              DataM1.Query1.sql.add('and pressrunid = ' + inttostr(plateframes[iplf].OrgRunID));
              //DataM1.Query1.sql.add('and locationid = ' + inttostr(plateframeslocationid));
              DataM1.Query1.sql.add('and publicationid = ' + inttostr(plateframespublicationid));
              DataM1.Query1.sql.add('and pressid = ' + inttostr(plateframespressid));
              DataM1.Query1.sql.add('and ' + DataM1.makedatastr('', plateframesPubdate));
            end
            else
            begin
              DataM1.Query1.sql.clear;
              DataM1.Query1.sql.add('DELETE FROM PageTable WHERE PageType = 3');
            //  DataM1.Query1.sql.add('and locationid = ' + inttostr(plateframeslocationid));
              DataM1.Query1.sql.add('and publicationid = ' + inttostr(plateframespublicationid));
              DataM1.Query1.sql.add('and pressid = ' + inttostr(plateframespressid));
              DataM1.Query1.sql.add('and editionid = ' + inttostr(plateframesdata[iplf].ProdPlates[0].editionid));
              DataM1.Query1.sql.add('and ' + DataM1.makedatastr('', plateframesPubdate));
              DataM1.Query1.sql.add(Insectionidsstr);
            end;

            IF not formmain.trysql(DataM1.Query1) then
            begin
              Anyerrosduringrun := true;
              plantimdadd('ERROR 1');
            end;
          End;
        End;

        // Set dirty flag       (overwrite mode)
        if (FormApplyproduction.RadioGroupApplymode.ItemIndex = 0) and
          ((Editmode < PLANADDMODE_COPY) or (Editmode = PLANADDMODE_APPLY)) and
          (Editmode <> PLANADDMODE_MULTISAVE) and
          (Formprodplan.planningaction <> 6) then
        begin
          writeMainlogfile('RunProduction: Set dirty');
          DataM1.Query2.sql.clear;
          DataM1.Query2.sql.add('update pagetable set dirty = 1');
          DataM1.Query2.sql.add('where productionid = ' + inttostr(plateframesproductionid) + ' and ');
      //    DataM1.Query2.sql.add('locationid = ' + inttostr(plateframeslocationid));
          DataM1.Query2.sql.add('  pressid = ' +  inttostr(plateframespressid));
          DataM1.Query2.sql.add(Insectionidsstr);
          if Prefs.debug then
            DataM1.Query2.sql.SaveToFile
              (IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) +
              'sqllogs\' + 'setdirtyplan.sql');
          if not formmain.trysql(DataM1.Query2) then
          begin
            Anyerrosduringrun := true;
            plantimdadd('ERROR 2');
          end;
        end;

        if (FormApplyproduction.RadioGroupApplymode.ItemIndex = 0) and
          (Editmode = PLANADDMODE_MOVE) and (Editmode <> PLANADDMODE_MULTISAVE)
          and (Editmode <> PLANADDMODE_COPY) then
        begin
          For iplf := 1 to Nplateframes do
          begin
            IF (Formprodplan.planningaction <> 6) then
            begin
              writeMainlogfile('RunProduction: Set dirty 2');
              DataM1.Query2.sql.clear;
              DataM1.Query2.sql.add('update pagetable set dirty = 1');
              DataM1.Query2.sql.add('where productionid = ' +inttostr(plateframes[iplf].orgproductionid));
           //   DataM1.Query2.sql.add('and locationid = ' +inttostr(plateframes[iplf].OrgFromLocationid));
              DataM1.Query2.sql.add('and editionid = ' + inttostr(plateframesdata[iplf].ProdPlates[0].editionid));
              DataM1.Query2.sql.add('and pressid = ' + inttostr(plateframes[iplf].OrgFromPressid));
              DataM1.Query2.sql.add('and publicationid = ' + inttostr(plateframes[iplf].OrgPublicationid));
              DataM1.Query2.sql.add('and pressrunid = ' + inttostr(plateframes[iplf].OrgRunID));
              if Prefs.debug then
                DataM1.Query2.sql.SaveToFile
                  (IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) +
                  'sqllogs\' + 'movedirtyplan.sql');
              if not formmain.trysql(DataM1.Query2) then
              begin
                Anyerrosduringrun := true;
                plantimdadd('ERROR 3');
              end;
            End;

            DataM1.Query2.sql.clear;
            DataM1.Query2.sql.add('update pagetable set pressid = ' + inttostr(plateframespressid));
            DataM1.Query2.sql.add(',locationid = ' +  inttostr(plateframeslocationid));
            DataM1.Query2.sql.add(', productionid = ' + inttostr(plateframesproductionid));
            DataM1.Query2.sql.add('where productionid = ' + inttostr(plateframes[iplf].orgproductionid));
            //DataM1.Query2.sql.add('and locationid = ' + inttostr(plateframes[iplf].OrgFromLocationid));
            DataM1.Query2.sql.add('and editionid = ' + inttostr(plateframes[iplf].Orgfromeditionid));
            DataM1.Query2.sql.add('and pressid = ' + inttostr(plateframes[iplf].OrgFromPressid));
            DataM1.Query2.sql.add('and publicationid = ' + inttostr(plateframes[iplf].OrgPublicationid));
            DataM1.Query2.sql.add('and pressrunid = ' + inttostr(plateframes[iplf].OrgRunID));

            if Prefs.debug then
              DataM1.Query2.sql.SaveToFile
                (IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\' + 'moveplan.sql');

            if not formmain.trysql(DataM1.Query2) then
            begin
              Anyerrosduringrun := true;
              plantimdadd('ERROR 4');
              writeMainlogfile('RunProduction: TrySql failed - ' + DataM1.Query2.sql.Text);

            end;

          end;
        end;

        if (FormApplyproduction.RadioGroupApplymode.ItemIndex = 0) and
          (Editmode <> PLANADDMODE_MULTISAVE) and (not JustAlayoutchange) and
          (Editmode <> PLANADDMODE_COPY) then

          cleanupexistingdata;

        if planlock then
          formmain.Setplanlock(true);

        For iplf := 1 to Nplateframes do
        begin
          IF (Editmode = PLANADDMODE_APPLY) and (not Formprodplan.PartialPlanning) then
          begin
            For ipl := 0 to plateframes[iplf].NProdPlates do
            begin
              plateframesdata[iplf].ProdPlates[ipl].runid := -1;
            End;
          end;
          IF Not JustAlayoutchange then
            Insertnewpressrun(iplf);

          IF plancenteristoold then
          Begin
            formmain.Setplanlock(false);
            exit;
          End;
          plantimdadd('Applying plan..');
          Applyplan(iplf, plateframes[iplf].NProdPlates, -1, -1, -1, frommain, 0);
          plantimdadd('Applied plan.');
        End;

        if Nplateframes > 0 then
          saveprodrundata(plateframesproductionid);

        // Clean remaining dirty pages
        IF (Formprodplan.planningaction <> 6) and
          (Editmode <> PLANADDMODE_MULTISAVE) then
        begin
          DataM1.Query2.sql.clear;
          DataM1.Query2.sql.add('delete pagetable');
          DataM1.Query2.sql.add('where productionid = ' + inttostr(plateframesproductionid));
          DataM1.Query2.sql.add('and locationid = ' +  inttostr(plateframeslocationid));
          DataM1.Query2.sql.add('and dirty = 1');
          if not formmain.trysql(DataM1.Query2) then
          begin
            Anyerrosduringrun := true;
            plantimdadd('ERROR 5');
          end;
        End;

        IF Editmode = PLANADDMODE_MOVE then
        begin
          // ???????????????????????????????????????????????????????????????????????????????????????????????????????????
          // formmain.trysql(DataM1.Query2);

          For iplf := 1 to Nplateframes do
          begin
            IF (Formprodplan.planningaction <> 6) then
            begin

              DataM1.Query2.sql.clear;
              DataM1.Query2.sql.add('delete pagetable');
              DataM1.Query2.sql.add('where productionid = ' + inttostr(plateframes[iplf].orgproductionid));
              DataM1.Query2.sql.add('and locationid = ' + inttostr(plateframes[iplf].OrgFromLocationid));
              DataM1.Query2.sql.add('and editionid = ' + inttostr(plateframes[iplf].Orgfromeditionid));
              DataM1.Query2.sql.add('and pressid = ' + inttostr(plateframes[iplf].OrgFromPressid));
              DataM1.Query2.sql.add('and publicationid = ' + inttostr(plateframes[iplf].OrgPublicationid));
              DataM1.Query2.sql.add('and pressrunid = ' + inttostr(plateframes[iplf].OrgRunID));
              DataM1.Query2.sql.add('and dirty = 1');
              if Prefs.debug then
                DataM1.Query2.sql.SaveToFile
                  (IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) +'sqllogs\' + 'moveplan.sql');
              if not formmain.trysql(DataM1.Query2) then
              begin
                Anyerrosduringrun := true;
                plantimdadd('ERROR 5.5');
              end;
            End;
          end;
        end;

        If (Editmode = PLANADDMODE_APPLY) then
        begin
          IF Validplancolors <> '' then // ikke ved apply
          begin
            IF (Formprodplan.planningaction <> 6) then
            begin

              DataM1.Query2.sql.clear;
              DataM1.Query2.sql.add('delete pagetable');
              DataM1.Query2.sql.add('where productionid = ' +
                inttostr(moveunplannedfromprodcutionid));
              DataM1.Query2.sql.add('and colorid not in ' + Validplancolors);
              DataM1.Query2.sql.add('and pagetype < 3');
              if not formmain.trysql(DataM1.Query2) then
              begin
                Anyerrosduringrun := true;
                plantimdadd('ERROR 6');
              end;
            End;
          end;
        end;

        // If (editmode = PLANADDMODE_MOVE) then
        // begin

        // end;

        IF (FormApplyproduction.DateTimePickerdeadlinedate.checked) And (Not JustAlayoutchange) then
        begin
          DataM1.Query2.sql.clear;
          DataM1.Query2.sql.add
            ('UPDATE Pagetable SET Deadline = :deadline WHERE productionid = ' +
            inttostr(plateframesproductionid));
          Decodedate(FormApplyproduction.DateTimePickerdeadlinedate.Date, AYear, AMonth, ADay);
          decodetime(FormApplyproduction.DateTimePickerdeadlinetime.Time, AHour, AMinute, ASecond, AMilliSecond);
          DataM1.Query2.ParamByName('deadline').AsDateTime := EncodeDateTime(AYear, AMonth, ADay, AHour, AMinute, 0, 0);
          formmain.trysql(DataM1.Query2);
          // Ikke kritisk..
          (* if not formmain.trysql(DataM1.Query2) then
            Anyerrosduringrun := true; *)
        end;

        IF (FormApplyproduction.DateTimePickerhotdatestart.checked) And (Not JustAlayoutchange) then
        begin
          For iplf := 1 to Nplateframes do
          begin
            Decodedate(FormApplyproduction.DateTimePickerhotdatestart.Date,
              AYear, AMonth, ADay);
            decodetime(FormApplyproduction.DateTimePickerhottimestart.Time,
              AHour, AMinute, ASecond, AMilliSecond);
            plateframes[iplf].PriorityHottimeBegin :=
              EncodeDateTime(AYear, AMonth, ADay, AHour, AMinute, 0, 1);
            Decodedate(FormApplyproduction.DateTimePickerhotdateend.Date, AYear,
              AMonth, ADay);
            decodetime(FormApplyproduction.DateTimePickerhottimeend.Time, AHour,
              AMinute, ASecond, AMilliSecond);
            plateframes[iplf].PriorityHottimeEnd :=
              EncodeDateTime(AYear, AMonth, ADay, AHour, AMinute, 0, 1);
            plateframes[iplf].PriorityBeforeHottime :=
              FormApplyproduction.UpDownhotbefore.Position;
            plateframes[iplf].PriorityDuringHottime :=
              FormApplyproduction.UpDownunder.Position;
            plateframes[iplf].PriorityAfterHottime :=
              FormApplyproduction.UpDownafter.Position;
          End;

        end;

        setAllpressruniddata;

        proofid := 0;

        try
          IF FormApplyproduction.ComboBoxconf.ItemIndex > 0 then
          begin
            if FormApplyproduction.ComboBoxconf.items.count > 0 then
            begin
              proofid := Formflatproof.flatproofers
                [FormApplyproduction.ComboBoxconf.ItemIndex].id;
            end;
          End;
        except
        end;
        Hproofid := 0;
        try
          IF FormApplyproduction.ComboBoxHproofconf.ItemIndex > 0 then
          begin
            if FormApplyproduction.ComboBoxconf.items.count > 0 then
            begin
              Hproofid := Formflatproof.flatproofers
                [FormApplyproduction.ComboBoxHproofconf.ItemIndex].id;
            end;
          End;

        except
        end;

        hardproofconfig := Formflatproof.flatproofconfigcalc
          (FormApplyproduction.ComboBoxHproofconf.ItemIndex > 0,
          FormApplyproduction.RadioGrouphardproofapproval.ItemIndex = 0,
          Hproofid);

        Flatproofconfig := Formflatproof.flatproofconfigcalc
          (FormApplyproduction.ComboBoxconf.ItemIndex > 0,
          FormApplyproduction.RadioGroupApproval.ItemIndex = 0, proofid);

        IF Not JustAlayoutchange then
        begin
          DataM1.Query2.sql.clear;
          DataM1.Query2.sql.add('update pagetable');
          DataM1.Query2.sql.add
            ('Set flatproofstatus = 0 ,FlatProofConfigurationID = ' +
            inttostr(Flatproofconfig));
          DataM1.Query2.sql.add(',HardProofConfigurationID = ' +
            inttostr(hardproofconfig));
          DataM1.Query2.sql.add(',miscint4 = 0 ');
          DataM1.Query2.sql.add(',miscint1 =  ' +
            inttostr(FormApplyproduction.xtragutter));
          DataM1.Query2.sql.add(',miscint2 =  ' +
            inttostr(FormApplyproduction.ApplyweekNumber));
          IF FormApplyproduction.newmarks <> '' then
          begin
            DataM1.Query2.sql.add(', MarkGroups = ' + '''' +
              FormApplyproduction.newmarks + '''');
          End;

          DataM1.Query2.sql.add('Where pressId = ' +
            inttostr(plateframespressid));
          DataM1.Query2.sql.add('and Publicationid = ' +
            inttostr(plateframespublicationid));
          DataM1.Query2.sql.add('and ' + DataM1.makedatastr('',
            plateframesPubdate));
          DataM1.Query2.ExecSQL(false);
        End;


      end;

    Except
      Anyerrosduringrun := true;
      plantimdadd('ERROR 7');

    end;

    if not Anyerrosduringrun then
    begin
      try
        Anyerrosduringrun := Checknewproduction;
      except
      end;
    End;

  finally
    formmain.CleanupProductionNames;
    formmain.Setplanlock(false);

    // 20210908
    DataM1.Query2.sql.clear;
    DataM1.Query2.sql.add('UPDATE PageTable');
    DataM1.Query2.sql.add('SET HardProofStatus=0 ');
    DataM1.Query2.sql.add('WHERE productionid = ' + IntToStr(plateframesproductionid));
    DataM1.Query2.ExecSQL(false);

    if Prefs.GeneratePlanPageNames   then
    begin
        GeneratePlanPageNames(plateframesproductionid);
    end;

    IF plateframesproductionname = '' then
    begin
      DataM1.Query2.sql.clear;
      DataM1.Query2.sql.add
        ('Select name from productionnames WITH (NOLOCK) where productionid = '
        + inttostr(plateframesproductionid));
      DataM1.Query2.open;
      IF not DataM1.Query2.eof then
        plateframesproductionname := DataM1.Query2.fields[0].asstring;
      DataM1.Query2.close;

    end;
    writeplanlog(plateframesproductionname);

    IF (Planloggingtype > 0) And (plateframesproductionname <> '') then
    begin
      DataM1.Query2.sql.clear;
      DataM1.Query2.sql.add
        ('Select top 1 separation from pagetable WITH (NOLOCK) ');
      DataM1.Query2.sql.add('Where productionid = ' +
        inttostr(plateframesproductionid));
      DataM1.Query2.sql.add('and active = 1 and pagetype <> 3');
      DataM1.Query2.open;
      Planloggingseparation := -1;
      IF not DataM1.Query2.eof then
      begin
        Planloggingseparation := DataM1.Query2.fields[0].asvariant;
      end;
      DataM1.Query2.close;

      IF Planloggingseparation > -1 then
      begin
        formmain.SaveEventlog(Planloggingtype, Planloggingseparation, 0,
          Planloggingmessage, plateframesproductionname, 1,
          plateframesproductionid);
      End;
    end;
    Planloggingmessage := '';
    Planloggingseparation := -1;
    Planloggingtype := -1;

    ProgressBarprod.Position := 0;
    formmain.GroupBoxworking.visible := false;
    screen.Cursor := crdefault;
    result := not Anyerrosduringrun;
    IF JustAlayoutchange then
      Formprodplan.close;
    Case Editmode of
      0:
        Begin
        end;
      1:
        Begin
          Formprodplan.close;
        end;
      2:
        Begin
          Formprodplan.close;
        end;
      3:
        Begin
          Formprodplan.close;
        end;
      4:
        Begin
          Formprodplan.close;
        end;
      5:
        Begin
          Formprodplan.close;
        end;
      6:
        Begin
          // Formprodplan.close;
        end;

    end;

  end;
  plantimdadd('End of run ');
  formmain.planlogging('runproduction End');
end;

Procedure TFormprodplan.plantimdadd(Atext: String);
Var
  timedef: Integer;
Begin
  timedef := millisecondsbetween(now, Plantimer);
  Plantimming.add(Atext + #9 + timetostr(now) + #9 + inttostr(timedef));
  Plantimer := now;

  writeMainlogfile('PlanTimdAdd: ' + Atext);
end;

Function TFormprodplan.findpagerunnig(Locationid: Integer; Pressid: Integer;
  productionid: Integer; publicationid: Integer; pressrunid: Integer;
  pubdate: Tdatetime; editionid: Integer; sectionid: Integer; pagename: string;
  ColorID: Integer; Copynumber: Integer; iplf: Integer; ipl: Integer;
  Var proofid: Integer; var frompressid: Integer; var fromlocationid: Integer;
  var Unique: Integer; Var MasterCopySeparationSet: Integer;
  Var CopySeparationSet: Integer; Var SeparationSet: Integer;
  Var FlatSeparationSet: Integer; Var CopyFlatSeparationSet: Integer;
  Var Separation: Int64; Var FlatSeparation: Int64; var curstat: Integer;
  Var CurRelease: Integer; Var CurApproval: Integer; Var proofstatus: Integer;
  Var fileserver: String; var pagetypeX: Integer): Integer;

  Procedure setsets;
  Begin
    try

      MasterCopySeparationSet := DataM1.Query2.fieldbyname
        ('MasterCopySeparationSet').asinteger;
      CopySeparationSet := DataM1.Query2.fieldbyname('CopySeparationSet')
        .asinteger;
      SeparationSet := DataM1.Query2.fieldbyname('SeparationSet').asinteger;
      FlatSeparationSet := DataM1.Query2.fieldbyname('FlatSeparationSet')
        .asinteger;
      CopyFlatSeparationSet := DataM1.Query2.fieldbyname
        ('CopyFlatSeparationSet').asinteger;
      Separation := DataM1.Query2.fieldbyname('separation').asvariant;
      FlatSeparation := DataM1.Query2.fieldbyname('flatseparation').asvariant;
      CurRelease := DataM1.Query2.fieldbyname('hold').asinteger;
      CurApproval := DataM1.Query2.fieldbyname('approved').asinteger;

      if (PartialPlanning) and (Prefs.PartialNoEditionChange) then
        Unique := DataM1.Query2.fieldbyname('UniquePage').asinteger;

      // pagetype     := DataM1.Query2.fieldbyname('pagetype').asinteger;
    except
    end;
  End;

Var
  X: Integer;
  hcopy: Integer;
  hrun: Integer;
  aktrunid, Aktpressid, aktplanid: Integer;
  samerun, sameed, sameis, samecolor, samelocation, samepress,
    sameplan: Boolean;

  Ifound, Hfound, foundP: Integer;
  foundproof: Boolean;
  sec1: Tdatetime;

  itsadoubleFB: Boolean;
  ip, DBFBCopyseparationset: Integer;
  thisCopySeparationSet, thisMasterCopySeparationSet,thisApproved :  Integer;
Begin
  DBFBCopyseparationset := -997;
  sec1 := now;
  MakingdoubleFrontback := PlatetemplateArray
    [plateframesdata[iplf].ProdPlates[ipl].templatelistid]
    .ISDoublefronttoback = 1;

  itsadoubleFB := (MakingdoubleFrontback) and (ipl Mod 2 = 1);
  if itsadoubleFB then
  begin
    for ip := 1 to PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl - 1]
      .templatelistid].NupOnplate do
    begin
      IF (plateframesdata[iplf].ProdPlates[ipl - 1].Pages[ip]
        .pagename = pagename) and
        (plateframesdata[iplf].ProdPlates[ipl - 1].Pages[ip]
        .sectionid = sectionid) then
      begin
        DBFBCopyseparationset := plateframesdata[iplf].ProdPlates[ipl - 1].Pages[ip].CopySeparationSet;
        break;
      end;
    end;
  end;

  result := 0;
  curstat := 0;
  CurRelease := -1;
  CurApproval := -1;
  fileserver := '';

  try
    IF (Editmode = PLANADDMODE_APPLY) and (Not FoundAapplynewpage) and (false)
    then
    begin

    end
    else
    begin

      DataM1.Query2.sql.clear;
      DataM1.Query2.sql.add
        ('select locationID,pressID,pressrunid,productionid,fileserver,proofID,colorid,copynumber,status,proofstatus,');
      DataM1.Query2.sql.add
        ('MasterCopySeparationSet,CopySeparationSet,SeparationSet,FlatSeparationSet,CopyFlatSeparationSet,separation,flatseparation,hold,approved,pagetype,UniquePage');
      DataM1.Query2.sql.add(' from pagetable (NOLOCK) where');
      DataM1.Query2.sql.add('publicationid = ' + inttostr(publicationid)
        + ' and ');
      DataM1.Query2.sql.add('editionid = ' + inttostr(editionid) + ' and ');
      DataM1.Query2.sql.add('sectionid = ' + inttostr(sectionid) + ' and ');
      IF FormApplyproduction.CheckBoxpressspecifik.checked then
      Begin
        DataM1.Query2.sql.add('pressid = ' + inttostr(Pressid) + ' and ');
      End;

      DataM1.Query2.sql.add('pagename = ' + '''' + pagename + '''');
      DataM1.Query2.sql.add(' and ' + DataM1.makedatastr('', pubdate));

      // DataM1.Query2.SQL.add('and pressid = '+inttostr(pressid));

      IF Prefs.debug then
        DataM1.Query2.sql.SaveToFile
          (IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'
          + 'lookforpage.sql');
      formmain.Tryopen(DataM1.Query2);
      foundproof := false;
      Ifound := 0;
      hcopy := 0;
      hrun := 0;
      Hfound := 0;
      samecolor := false;

      Aktpressid := Pressid;
      aktplanid := productionid;
      aktrunid := pressrunid;
      proofstatus := 0;
      While not DataM1.Query2.eof do
      begin
        samelocation := (DataM1.Query2.fieldbyname('locationID').asinteger = Locationid);
        samepress := (DataM1.Query2.fieldbyname('pressID').AsInteger = Pressid);
        samerun := (DataM1.Query2.fieldbyname('pressrunid').AsInteger = pressrunid);
        sameplan := (DataM1.Query2.fieldbyname('productionid').asinteger = productionid);
        fileserver := DataM1.Query2.fieldbyname('fileserver').asstring;
        thisCopySeparationSet :=DataM1.Query2.fieldbyname('Copyseparationset').AsInteger ;
        thisMasterCopySeparationSet := DataM1.Query2.fieldbyname('MasterCopySeparationSet').AsInteger;
        thisApproved :=  DataM1.Query2.fieldbyname('approved').AsInteger;
        If not foundproof then
          proofid := DataM1.Query2.fieldbyname('proofID').asinteger;
        IF ColorID <> -1 then
        begin
          samecolor := (DataM1.Query2.fieldbyname('colorid').asinteger = ColorID) And
                       (DataM1.Query2.fieldbyname('copynumber').asinteger = Copynumber);

          if (DataM1.Query2.fieldbyname('colorid').asinteger = ColorID) then
          Begin
            curstat := DataM1.Query2.fieldbyname('status').asinteger;
            proofstatus := DataM1.Query2.fieldbyname('proofstatus').asinteger;
            frompressid := DataM1.Query2.fieldbyname('pressID').asinteger;
            fromlocationid := DataM1.Query2.fieldbyname('locationID').asinteger;
          End;
        end
        Else
        Begin // det er en halfweb side
          samecolor := true;
        End;

        IF hrun < DataM1.Query2.fieldbyname('pressrunid').asinteger then
          hrun := DataM1.Query2.fieldbyname('pressrunid').asinteger;

        if samecolor then
        begin
          proofid := DataM1.Query2.fieldbyname('proofID').asinteger;
          foundproof := true;
          IF samelocation and samepress and samerun and sameplan then
          Begin
            if DBFBCopyseparationset = thisCopySeparationSet then
            begin
              MasterCopySeparationSet := thisMasterCopySeparationSet;
              CurApproval := thisApproved;
              result := 3;
            end
            else
            begin
              setsets;
              result := 1;
              break;
            End;
          end
          Else
          begin
            if (not samepress) or (not samelocation) or (not sameplan) then
            begin
              setsets;
              result := 3;
            end;

            IF (not samerun) and ((samepress) or (sameplan)) then
            begin
              if DBFBCopyseparationset = thisCopySeparationSet then
              begin
                MasterCopySeparationSet := thisMasterCopySeparationSet;
                CurApproval := thisApproved;
                result := 3;
              end
              else
              begin
                setsets;
                result := 1;
                break;
              End;
            end;
          end;
        end
        else
        begin
          IF (samelocation and samepress) and (result = 0) then
          Begin
            if DBFBCopyseparationset = thisCopySeparationSet then
            Begin
              MasterCopySeparationSet := thisMasterCopySeparationSet;
              CurApproval := thisApproved;
              result := 3;
            end
            else
            begin
              setsets;
              result := 2;
            End;
          end;

          IF (samelocation) and (result = 0) then
          Begin
            if DBFBCopyseparationset = thisCopySeparationSet then
            Begin
              MasterCopySeparationSet := thisMasterCopySeparationSet;
              CurApproval := thisApproved;
              result := 3;
            end
            else
            begin

              setsets;
              result := 3;
            End;
          end;
        end;
        DataM1.Query2.next;
      End;
      DataM1.Query2.close;
    End;
  except
  end;

  Inc(findingsec, millisecondsbetween(now, sec1));

End;

Function TFormprodplan.pagepositionsfromprodplate(Var prodplate: Tprodplate;
  Ipage: Integer): string;
Var
  I: Integer;
Begin
  result := '';
  For I := 1 to PlatetemplateArray[prodplate.templatelistid].NupOnplate do
  begin
    IF (prodplate.Pages[I].pagename = prodplate.Pages[Ipage].pagename) and
      (prodplate.Pages[I].sectionid = prodplate.Pages[Ipage].sectionid) then
    begin
      result := result + inttostr(I) + ',';
    end;
  end;
  delete(result, length(result), 1);
end;

// Still in use!
Procedure TFormprodplan.Oldappendit(Var prodplate: Tprodplate; Ipage: Integer;
  Icolor: Integer; Copynumber: Integer; iplf: Integer; Var firstcolor: Boolean;
  Var aktcopyseparationset: Integer; var GotError: Boolean);

Var
  Color: String;
  publIDT, EdIDT, secIDT, IssueIDT: String;
  ColorID, Pressid, I: Integer;
  // Maxcopynumber : Integer;

  insertisok: Boolean;

  Function checkifitexists: Boolean;
  Var
    septodel: Int64;
  Begin
    result := false;
    try
      if DataM1.Query2.active then
      begin
        DataM1.Query2.close;
      End;

      septodel := -1;

      DataM1.Query2.sql.clear;
      // datam1.Query2.SQL.add('set lock_timeout 20000');
      DataM1.Query2.sql.add('Select TOP 1 separation from pagetable (NOLOCK)');
      DataM1.Query2.sql.add('where PublicationID = ' + publIDT +
        ' and EditionID = ' + EdIDT + ' and SectionID = ' + secIDT +
        ' and LocationID = ' + inttostr(plateframeslocationid) +
        ' and PageName = ' + '''' + prodplate.Pages[Ipage].pagename + '''' +
        ' and ColorID = ' + inttostr(ColorID));
      DataM1.Query2.sql.add('and (' + DataM1.makedatastr('',
        plateframesPubdate) + ')');
      DataM1.Query2.sql.add('and Pressid = ' + inttostr(Pressid));
      if not formmain.Tryopen(DataM1.Query2) then
        Anyerrosduringrun := true;

      if not DataM1.Query2.eof then
      begin
        septodel := DataM1.Query2.fields[0].asvariant;
      End;
      DataM1.Query2.close;

      IF septodel > -1 then
      begin

        IF (Formprodplan.planningaction <> 6) then
        begin

          DataM1.Query2.sql.clear;
          DataM1.Query2.sql.add('delete pagetable');
          DataM1.Query2.sql.add('Where separation = ' + inttostr(septodel));
          if not formmain.trysql(DataM1.Query2) then
            Anyerrosduringrun := true;
        End;
      end;
    Except

    end;
  end;

Var
  resultfromsql: Integer;
  insertreties: Integer;
  sec1: Tdatetime;
  cylstr: String;
Begin
  GotError := false;
  sec1 := now;
  resultfromsql := 0;
  Pressid := prodplate.Pressid;
  publIDT := inttostr(prodplate.publicationid);
  EdIDT := inttostr(prodplate.editionid);
  secIDT := inttostr(prodplate.Pages[Ipage].sectionid);
  IssueIDT := inttostr(1);

  if (aktcopyseparationset <= 0) then
    aktcopyseparationset := -1;

  IF prodplate.Pages[Ipage].pagetype = 3 then
  Begin
    Color := 'Dinky';
    ColorID := tnames1.Colornametoid(Color);
  End
  Else
  Begin
    ColorID := prodplate.Pages[Ipage].colors[Icolor].ColorID;
    Color := tnames1.ColornameIDtoname(ColorID);
  End;
  ReplaceTime(plateframesPubdate, EncodeTime(0, 0, 0, 0));
  plateframes[iplf].Miscdate := plateframesPubdate;

  plancenteristoold := false;
  // datam1.Query3.SQL.add('set lock_timeout 60000');

  IF (prodplate.TrueFront IN [2, 3]) And (Prefs.UseTrueSheetSide) then
    cylstr := fronbackstr[prodplate.TrueFront - 2]
  else
    cylstr := GetPlannameFromID(4, prodplate.Pages[Ipage].colors[Icolor].Cylinder);

  DataM1.Query3.sql.clear;
  DataM1.Query3.sql.add('DECLARE @resultat int');
  DataM1.Query3.sql.add('exec @resultat = spPlancenterInputeditorialsep3 ' +
    ' @pubdate = ' + '''' + formatdatetime(sqldateformat, plateframesPubdate) +
    '''' + ' , @IssueID = ' + IssueIDT + ',' + '@PublicationID = ' + publIDT +
    ', @EditionID = ' + EdIDT + ', @SectionID = ' + secIDT + ',@LocationID = ' +
    inttostr(plateframeslocationid) + ',@PageName = ' + '''' + prodplate.Pages
    [Ipage].pagename + '''' + ',@ColorID = ' + inttostr(ColorID) +
    ',@DefaultCopies =' + inttostr(Copynumber) + ',@ApprovalRequired =' +
    inttostr(prodplate.Pages[Ipage].colors[Icolor].approved) +
    ',@HoldIncoming =' + inttostr(prodplate.Pages[Ipage].colors[Icolor].Hold) +
    ',@DefaultTemplateID = ' + inttostr(PlatetemplateArray
    [prodplate.templatelistid].TemplateID) + ',@DefaultProofID = ' +
    inttostr(prodplate.Pages[Ipage].proofid) + ',' + '@DefaultPriority = ' +
    inttostr(prodplate.Pages[Ipage].colors[Icolor].Priority) + ',@FileName = ' +
    '''' + 'filename' + '''' + ',@ColorINDX = ' + inttostr(ColorID) +
    ',@CurCopySeparationSep = :CurCopySeparationSep,' + '@Pagination = ' +
    inttostr(prodplate.Pages[Ipage].pagina) + ', @ProductionID = ' +
    inttostr(plateframesproductionid) + ', @PressrunID = ' +
    inttostr(prodplate.runid) + ', @Presssectionnumber = ' +
    inttostr(prodplate.Presssectionnumber) + ', @Pressid = ' + inttostr(Pressid)
    + ',@Pagetype =' + inttostr(prodplate.Pages[Ipage].pagetype) +
    ',@stackpos = ' + '''' + GetPlannameFromID(2,
    prodplate.Pages[Ipage].colors[Icolor].stackpos) + '''' + ', @tower = ' +
    '''' + Getplantowername(prodplate.Tower) + '''' + ', @Cylinder = ' + '''' +
    cylstr + '''' + ', @Zone = ' + '''' + GetPlannameFromID(5, prodplate.Zone) +
    '''' + ', @Highlow = ' + '''' + GetPlannameFromID(3,
    prodplate.Pages[Ipage].colors[Icolor].High) + '''' + ',@Sheetnumber = ' +
    inttostr(prodplate.sheetnumber) + ',@Sheetside = ' +
    inttostr(prodplate.Front) + ', @Uniquepage = ' +
    inttostr(prodplate.Pages[Ipage].totUniquePage) + ', @PageIndex = ' +
    inttostr(prodplate.Pages[Ipage].Pageindex) + ', @Pagepositions = ' + '''' +
    pagepositionsfromprodplate(prodplate, Ipage) + '''');

  DataM1.Query3.sql.add(', @FlatProofConfigurationID = ' +
    inttostr(prodplate.FlatProofConfigurationID) +
    ', @HardProofConfigurationID = ' +
    inttostr(prodplate.HardProofConfigurationID) + ', @GutterImage = 0' +
    // + inttostr(prodplate.GutterImage)+
    ', @OutputPriority = ' + inttostr(prodplate.OutputPriority) +
    ', @CustomerID = ' + inttostr(plateframes[iplf].CustomerID) +
    ', @PressTime = :PressTime' + ', @Miscint1 = ' +
    inttostr(prodplate.Pages[Ipage].colors[Icolor].Miscint1) + ', @Miscint2 = '
    + inttostr(prodplate.Pages[Ipage].colors[Icolor].Miscint2) +
    ', @Miscint3 = ' + inttostr(prodplate.Pages[Ipage].colors[Icolor].Miscint3)
    + ', @Miscint4 = ' + inttostr(prodplate.Pages[Ipage].colors[Icolor]
    .Miscint4) + ', @Miscstring1 = ' + '''' + GetPlannameFromID(6,
    prodplate.Pages[Ipage].colors[Icolor].Miscstring1) + '''' +
    ', @Miscstring2 = ' + '''' + GetPlannameFromID(7,
    prodplate.Pages[Ipage].colors[Icolor].Miscstring2) + '''' +
    ', @Miscstring3 = ' + '''' + GetPlannameFromID(8,
    prodplate.Pages[Ipage].colors[Icolor].Miscstring3) + '''' +
    ', @Miscdate = :Miscdate');

  if (spPlancenterInputeditorialsep3Possible) then
  begin
    DataM1.Query3.sql.add(', @PageFormatID = ' +
      inttostr(prodplate.Pages[Ipage].PageFormatID) + ', @RipSetupID = ' +
      inttostr(prodplate.Pages[Ipage].RipSetupID) + ', @FanoutID = 0' +
      ', @PageCategoryID = ' + inttostr(prodplate.Pages[Ipage].PageRotation));
  end;

  DataM1.Query3.ParamByName('PressTime').AsSQLTimeStamp :=
    DateTimeToSQLTimeStamp(plateframes[iplf].PressTime);
  DataM1.Query3.ParamByName('Miscdate').AsSQLTimeStamp :=
    DateTimeToSQLTimeStamp(plateframes[iplf].Miscdate);

  DataM1.Query3.sql.add('select ' + '''' + 'resultatet' + '''' + ' = @resultat');

  IF firstcolor then
  Begin
    firstcolor := false;
    // datam1.Query3.ParamByName('CurCopySeparationSep').Asinteger := getnextavailopenset;
    DataM1.Query3.ParamByName('CurCopySeparationSep').asinteger := -1;
  End
  Else
    DataM1.Query3.ParamByName('CurCopySeparationSep').asinteger := aktcopyseparationset;

  IF Prefs.debug then
    DataM1.Query3.sql.SaveToFile
      (IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\' +
      'Append.SQL');

  DataM1.Query3.Prepared := false;
  insertisok := false;

  somethingalliedorinserted(plateframesproductionid, prodplate.runid,StrToInt(publIDT), plateframesPubdate);

  insertreties := 0;
  repeat
    try
      DataM1.Query3.open;
      resultfromsql := DataM1.Query3.fieldbyname('resultatet').asinteger;
      DataM1.Query3.close;
      insertisok := resultfromsql <> -1;

      // formmain.planlogging( IntToStr(resultfromsql));

      IF resultfromsql = -10 then
      begin
        plancenteristoold := true;
      end;

    except

      on E: Exception do
      Begin
        insertisok := false;
        formmain.planlogging('Exception in ProdPlan.OldAppendIt()');
        formmain.planlogging(E.Message);
        for I := 0 to DataM1.Query3.sql.count - 1 do
        begin
          formmain.planlogging(DataM1.Query3.sql[I]);
        end;
        formmain.planlogging('');
        Anyerrosduringrun := true;

      End;
    end;
    if not insertisok then
    begin
      if DataM1.Query3.active then
        DataM1.Query3.close;
      checkifitexists;
      Inc(insertreties);
      sleep(100);
      formmain.planlogging
        ('spPlancenterInputeditorialsep3 failed - retry count = ' + inttostr(insertreties));
    end;
  until (insertisok) or (insertreties > 10);

  try
    aktcopyseparationset := resultfromsql;
    // datam1.Query3.fieldbyname('resultatet').AsInteger;
    prodplate.Pages[Ipage].CopySeparationSet := aktcopyseparationset;
    prodplate.Pages[Ipage].SeparationSet := (aktcopyseparationset * 100) + Copynumber;
    if prodplate.Pages[Ipage].pagetype <> 3 then
      prodplate.Pages[Ipage].colors[Icolor].Separation :=
        (prodplate.Pages[Ipage].SeparationSet * 100) +
        tnames1.Colornametoid(Color)
    Else
      prodplate.Pages[Ipage].colors[Icolor].Separation :=
        (prodplate.Pages[Ipage].SeparationSet * 100) +
        tnames1.Colornametoid(Color);

    prodplate.CopyFlatSeparationSet := -1;
    prodplate.Pages[Ipage].MasterCopySeparationSet := aktcopyseparationset;

    DataM1.Query3.close;
  Except
    Anyerrosduringrun := true;
  end;
  Inc(appendsec, millisecondsbetween(now, sec1));
  IF insertsec < millisecondsbetween(now, sec1) then
    insertsec := millisecondsbetween(now, sec1);

    GotError := not insertisok;
end;

// Sets ID-numbers on all plan plates. -1 : do not set
procedure TFormprodplan.applyglobdata(offset: Integer; Newproductionid: Integer;
  Newpublicationid: Integer; newlocationid: Integer; newpressid: Integer;
  Newtemplatelistid: Integer; Newflatproofid: Integer; Newcolorproofid: Integer;
  NewMonoproofid: Integer; NewPDFproofid: Integer; NewNmarkgroups: Integer;
  Newmarkgroups: marksarray);
Var
  iplf, ipl, ip
  // ic,nup
    : Integer;

begin
  formmain.planlogging('applyglobdata');
  For iplf := offset to Nplateframes do
  begin
    For ipl := 0 to plateframes[iplf].NProdPlates do
    begin
      plateframesdata[iplf].ProdPlates[ipl].Presssectionnumber := iplf;
      IF Newproductionid > -1 then
        plateframesdata[iplf].ProdPlates[ipl].productionid := Newproductionid;
      IF Newproductionid > -1 then
        plateframesdata[iplf].ProdPlates[ipl].publicationid := Newpublicationid;
      IF Newproductionid > -1 then
        plateframesdata[iplf].ProdPlates[ipl].Locationid := newlocationid;
      IF Newproductionid > -1 then
        plateframesdata[iplf].ProdPlates[ipl].Pressid := newpressid;

      IF Newtemplatelistid > -1 then
        plateframesdata[iplf].ProdPlates[ipl].templatelistid := Newtemplatelistid;

      IF Newflatproofid > -1 then
        plateframesdata[iplf].ProdPlates[ipl].FlatProofConfigurationID := Newflatproofid;

      IF NewNmarkgroups > -1 then
      Begin
        plateframesdata[iplf].ProdPlates[ipl].markgroups := Newmarkgroups;
        plateframesdata[iplf].ProdPlates[ipl].Nmarkgroups := NewNmarkgroups;
      end;

      for ip := 1 to PlatetemplateArray
        [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
      begin

        IF (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors > 1) and
          (Newcolorproofid > -1) then
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].proofid := Newcolorproofid;

        IF (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors < 2) and
          (NewMonoproofid > -1) then
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].proofid := NewMonoproofid;

        IF (NewPDFproofid > -1) and
          (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors > 0) and
          (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[1].ColorID = tnames1.PDFCOLORID) then
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].proofid := NewPDFproofid;

      end;
    end;
  end;

end;

procedure TFormprodplan.setdinkydata(offset: Integer);
Var
  iplf, ipl, ip, ip2
  // ,ic,nup
    : Integer;
begin
  formmain.planlogging('Setdinkey data');
  For iplf := 1 to Nplateframes do
  begin
    For ipl := 0 to plateframes[iplf].NProdPlates do
    begin
      for ip := 1 to PlatetemplateArray
        [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
      begin
        IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype = 3 then
        begin
          for ip2 := 1 to PlatetemplateArray
            [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
          Begin
            if plateframesdata[iplf].ProdPlates[ipl].Pages[ip2].pagetype <> 3
            then
            Begin
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Oldrunid :=
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip2].Oldrunid;
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totapproval :=
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip2].totapproval;
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Anyheld :=
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip2].Anyheld;
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                .totUniquePage := 0;
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Creep :=
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip2].Creep;
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].sectionid :=
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip2].sectionid;
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].proofid :=
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip2].proofid;
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagestatus := 0;
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors := 1;
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[1]
                .active := 0;
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[1].ColorID
                := tnames1.Colornametoid('Dinky');
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[1]
                .Copynumber := plateframesdata[iplf].ProdPlates[ipl].Pages[ip2]
                .colors[1].Copynumber;
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[1]
                .Uniquepage := plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                .totUniquePage;
              break;
            end;
          end;
        end;
      end;
    end;
  end;
  formmain.planlogging('Setdinkey data end');
end;

procedure TFormprodplan.ActionRunExecute(Sender: TObject);
Var
  anytorepair: Boolean;
  SpecificDeviceID: Integer;
  prodname: string;
  existingPlanOverwrite: Boolean;
  AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond: Word;
begin
  try
    existingPlanOverwrite := false;
    CheckForUniquePlates();
    Inc(NextPartseqnum);
    formmain.planlogging('ActionRunExecute');
    FormApplyproduction.CheckBoxapproveNochange.Enabled := false;
    FormApplyproduction.CheckBoxholdnochange.Enabled := false;

    FormApplyproduction.GroupBoxRipsetup.visible := (ApletoUseRipSetupNameSetup)
      and (tnames1.RipSetupnames.count > 0);
    FormApplyproduction.ComboBoxRIPsetup.items.clear;
    IF FormApplyproduction.GroupBoxRipsetup.visible then
    begin
      DataM1.Query1.sql.clear;
      DataM1.Query1.sql.add('Select name from RipSetupNames');
      DataM1.Query1.sql.add('order by name');
      DataM1.Query1.open;
      While not DataM1.Query1.eof do
      begin
        FormApplyproduction.ComboBoxRIPsetup.items.add(DataM1.Query1.fields[0].asstring);
        DataM1.Query1.next;
      end;
      DataM1.Query1.close;
    End;

    // Findes tabelen OutputMethodNames overhoved?
    if OutputMethodNamesTablePossible then
    Begin
      DataM1.Query1.sql.clear;
      DataM1.Query1.sql.add
        ('Select DISTINCT OutputMethodName from OutputMethodNames with (NOLOCK)');
      DataM1.Query1.open;
      FormApplyproduction.ComboBoxOutputMetode.items.clear;
      While not DataM1.Query1.eof do
      begin
        FormApplyproduction.ComboBoxOutputMetode.items.add
          (DataM1.Query1.fields[0].asstring);
        DataM1.Query1.next;
      end;
      DataM1.Query1.close;
    end
    else
      FormApplyproduction.ComboBoxOutputMetode.Enabled := false;

    Case Editmode of
      // 0 just open, 1 edit mode, 2 wizard mode, 3 copymode, 4 movemode 5 load to apply
      0 .. 1:
        begin
          IF FormApplyproduction.GroupBoxRipsetup.visible then
          begin
            IF plateframes[1].RipSetupID > -1 then
            Begin
              FormApplyproduction.ComboBoxRIPsetup.ItemIndex :=
                FormApplyproduction.ComboBoxRIPsetup.items.IndexOf
                (tnames1.ripsetupIDtoname(plateframes[1].RipSetupID));
            End;
          End;
        end;
      2:
        Begin
          IF (Formtower.CheckBox1.checked) And (Not Prefs.AutoTowerOrder) then
          begin
            IF not checktowers then
            begin
              if MessageDlg(formmain.InfraLanguage1.Translate
                ('Tower have not been assigned to all plates ') + #13 +
                formmain.InfraLanguage1.Translate
                ('plan will not use tower specific fanout, Continue?'),
                mtConfirmation, [mbYes, mbno], 0) <> mryes then
              begin
                exit;
              End;
            end;
          end;

          Incrementpresssections;
          FormApplyproduction.RadioGroupapprovalnew.ItemIndex :=
            Formaddplan.RadioGroupApproval.ItemIndex;
          FormApplyproduction.RadioGrouphold.ItemIndex :=
            Formaddplan.RadioGrouplocked.ItemIndex;
        end;
      PLANADDMODE_APPLY:
        Begin
          FormApplyproduction.RadioGroupapprovalnew.ItemIndex :=
            Formaddplan.RadioGroupApproval.ItemIndex;
          FormApplyproduction.RadioGrouphold.ItemIndex :=
            Formaddplan.RadioGrouplocked.ItemIndex;
          FormApplyproduction.CheckBoxapproveNochange.Enabled := true;
          FormApplyproduction.CheckBoxholdnochange.Enabled := true;
          FormApplyproduction.CheckBoxholdnochange.checked := false;
          FormApplyproduction.CheckBoxapproveNochange.checked := false;

          IF FormApplyproduction.GroupBoxRipsetup.visible then
          begin
            IF plateframes[1].RipSetupID > -1 then
            Begin
              FormApplyproduction.ComboBoxRIPsetup.ItemIndex :=
                FormApplyproduction.ComboBoxRIPsetup.items.IndexOf
                (tnames1.ripsetupIDtoname(plateframes[1].RipSetupID));
            End;
          End;

        end;
      3 .. 4:
        Begin
          FormApplyproduction.CheckBoxapproveNochange.Enabled := true;
          FormApplyproduction.CheckBoxholdnochange.Enabled := true;
          FormApplyproduction.CheckBoxholdnochange.checked := false;
          FormApplyproduction.CheckBoxapproveNochange.checked := false;

          Case Formnewlocalpress.RadioGroupApproval.ItemIndex of
            0:
              begin
                FormApplyproduction.CheckBoxapproveNochange.Enabled := true;
                FormApplyproduction.CheckBoxapproveNochange.checked := true;
                FormApplyproduction.CheckBoxholdnochange.Enabled := true;
                FormApplyproduction.CheckBoxholdnochange.checked := true;
              end;
            1:
              begin
                FormApplyproduction.RadioGroupapprovalnew.ItemIndex := 0;
              end;
            2:
              begin
                FormApplyproduction.RadioGroupapprovalnew.ItemIndex := 1;
              end;
          end;

          Case Formnewlocalpress.RadioGrouprelease.ItemIndex of
            0:
              begin
                FormApplyproduction.CheckBoxholdnochange.checked := true;
              end;
            1:
              begin
                FormApplyproduction.RadioGrouphold.ItemIndex := 0;
                FormApplyproduction.CheckBoxholdnochange.checked := false;
              end;
            2:
              begin
                FormApplyproduction.RadioGrouphold.ItemIndex := 1;
                FormApplyproduction.CheckBoxholdnochange.checked := false;
              end;
          end;

        end;
    end;

    IF Editmode = PLANADDMODE_APPLY then
    begin
      lookforexistingplansepnum;
      Checkifallareapply;
    end;

    IF Copytopressdontshowapply then
    begin
      FormApplyproduction.ModalResult := mrok;
      FormApplyproduction.RadioGroupApplymode.ItemIndex := 0;
      FormApplyproduction.CheckBoxapproveNochange.checked := true;
      FormApplyproduction.CheckBoxholdnochange.checked := true;
      FormApplyproduction.CheckBoxkeepcolors.checked := true;
    end
    else
    begin
      IF (Not JustAlayoutchange) then
      begin
        FormApplyproduction.Initialize(false);
        FormApplyproduction.ModalResult := mrNone;
        FormApplyproduction.ShowModal;
      end
      else
      Begin
        FormApplyproduction.ModalResult := mrok;
      End;
    end;

    IF FormApplyproduction.ModalResult = mrok then
    begin
      IF ImportCenterPreImportCustomPossible then
      begin

        DataM1.Query2.sql.clear;
        DataM1.Query2.sql.add('exec spImportCenterPreImportCustom');
        DataM1.Query2.sql.add('@PublicationID = ' + IntToStr(plateframespublicationid) + ',');
        DataM1.Query2.sql.add('@PubDate = :pubdate' + ',');
        DataM1.Query2.sql.add('@PressID = ' + IntToStr(plateframespressid) + ',');
        DataM1.Query2.sql.add('@PlanType = 1');
        DataM1.Query2.ParamByName('Pubdate').AsDateTime := plateframesPubdate;
      //  if Prefs.debug then
       //   DataM1.Query2.sql.SaveToFile
        //    (IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) +
         //   'sqllogs\' + 'PreImportCustom.sql');
        formmain.trysql(DataM1.Query2);

      end;

      if not formmain.Setplanlock(true) then
      begin

      end
      else
      begin
        productionidckeckup;

        IF (Not Copytopressdontshowapply) and (Not JustAlayoutchange) and
          (Formprodplan.Editmode <> PLANADDMODE_APPLY) and
          (Formprodplan.Editmode <> PLANADDMODE_EDIT) and
          (Formprodplan.Editmode <> PLANADDMODE_MULTISAVE) then
        begin
          IF FormApplyproduction.RadioGroupApplymode.ItemIndex = 0 then
          begin
            IF publanddateexists then
            begin
              if MessageDlg(formmain.InfraLanguage1.Translate
                ('Overwrite existing plan ?'), mtConfirmation, [mbYes, mbno], 0)
                = mrno then
              begin
                exit;
              End;
              existingPlanOverwrite := true;
            end;
          End;
        End;

        Starttoruntime := now;
        FormApplyproduction.ComboBoxdevice.visible := true;

        if RunProduction(not Formprodplan.Showing) then
        begin

          // 0 just open, 1 edit mode, 2 wizard mode, 3 copymode, 4 movemode 5 load to apply

          IF FormApplyproduction.ComboBoxdevice.ItemIndex > 0 then
          begin

            // NAN Change - take into account change to DeviceGroup
            SpecificDeviceID := tnames1.devicenametoid
              (FormApplyproduction.ComboBoxdevice.Text);
            if (SpecificDeviceID <= 0) then // Maybe DeviceGroup?
            begin
              SpecificDeviceID := inittypes.DeviceGroupnametoID
                (FormApplyproduction.ComboBoxdevice.Text);
              if (SpecificDeviceID > 0) then
                SpecificDeviceID := SpecificDeviceID + 100;
            end;

            writeMainlogfile('Applysepecifikdeviceid :' +
              inttostr(SpecificDeviceID));

            formmain.applysepecifikdeviceid(SpecificDeviceID,
              plateframesproductionid);
          end;

          if (RipSetupIDInPageTable) AND
            (FormApplyproduction.ComboBoxRipSetupname.ItemIndex >= 0) and
            (FormApplyproduction.ComboBoxPreflightSetup.ItemIndex >= 0) and
            (FormApplyproduction.ComboBoxInksaveSetup.ItemIndex >= 0) then
            formmain.ApplyRipSetups(plateframesproductionid,
                                    FormApplyproduction.ComboBoxRipSetupname.Text,
                                    FormApplyproduction.ComboBoxPreflightSetup.Text,
                                    FormApplyproduction.ComboBoxInksaveSetup.Text);

          if (FormApplyproduction.Groupbox13.Enabled) AND (Utypes.PressRunOutputMethodTablePossible) then
            FOrmMain.ApplyOutputMetode(plateframesproductionid, FormApplyproduction.ComboBoxOutputMetode.Text);

          if planningaction <> PLANADDMODE_MULTISAVE then
          begin
            formmain.postapplyplan(plateframeslocationid, plateframespressid,
                      plateframesproductionid, plateframespublicationid,
                      plateframesPubdate, Editmode, existingPlanOverwrite);
          End
          Else
          begin
            try
              DataM1.Query2.sql.clear;
              DataM1.Query2.sql.add('Exec SPplancenterpostplan3 ');
              DataM1.Query2.sql.add('@PublicationID = ' + IntToStr(plateframespublicationid) + ' ,');
              DataM1.Query2.sql.add('@Pubdate = :Pubdate' + ' ,');
              DataM1.Query2.sql.add('@PressID = ' + inttostr(plateframespressid));
              DataM1.Query2.ParamByName('Pubdate').AsDateTime := plateframesPubdate;
              formmain.trysql(DataM1.Query2);
            except
            End;

            try
              DataM1.Query2.sql.clear;
              DataM1.Query2.sql.add('exec SPplancenterpostplanProd3 ');
              DataM1.Query2.sql.add('@productionID = ' + inttostr(plateframesproductionid));
              formmain.trysql(DataM1.Query2);
            except
            End;

            // ### 20210302 - fix active flag for antipanoramas..
            try
              DataM1.Query2.sql.clear;
              DataM1.Query2.sql.add('UPDATE PageTable SET Active=0,ReadyTime=GETDATE() WHERE PageType=2 AND ProductionID=' +  inttostr(plateframesproductionid));
              formmain.trysql(DataM1.Query2);
            except
            End;


            // sET DEADLINE HERE (MOVED TO AFTER POSTPROCS)
            IF (FormApplyproduction.DateTimePickerdeadlinedate.checked) then
            begin

              DecodeDate(FormApplyproduction.DateTimePickerdeadlinedate.Date, AYear, AMonth, ADay);
              DecodeTime(FormApplyproduction.DateTimePickerdeadlinetime.Time, AHour, AMinute, ASecond, AMilliSecond);

              DataM1.Query2.sql.clear;
              DataM1.Query2.sql.add('UPDATE Pagetable SET Deadline = :deadline WHERE productionid = ' + inttostr(plateframesproductionid));
              DataM1.Query2.ParamByName('deadline').AsDateTime := EncodeDateTime(AYear, AMonth, ADay, AHour, AMinute, 0, 0);
              formmain.trysql(DataM1.Query2);
            end;


            // Register plan action to log   990 991:apply
            prodname := tnames1.publicationIDtoname(plateframespublicationid) +
              ' ' + DateToStr(plateframesPubdate) + '  ' +
              tnames1.pressnameIDtoname(plateframespressid);

            // FormMain.SaveEventlog(990,0,0,'Plan created',prodname,1, plateframesproductionid);

          end;

        End;
        endrunningtime := now;
        formmain.StatusBar1.Panels[5].Text := inttostr(secondsbetween(endrunningtime, Starttoruntime)) + ' sec.';

      End;

    end;
    formmain.planlogging('ActionRunExecute End');

    if formmain.Setplanlock(true) then
    begin
      IF (Prefs.PlanRepair) then
      begin
        DataM1.Query3.sql.clear;
        DataM1.Query3.sql.add
          ('SELECT DISTINCT P1.CopySeparationSet,P1.PublicationID,P1.PubDate,P1.SectionID,P1.PageName FROM PageTable P1 WITH (NOLOCK) ');
        DataM1.Query3.sql.add
          ('WHERE (P1.uniquepage <> 1 and p1.copyseparationset <> p1.mastercopyseparationset) and');
        DataM1.Query3.sql.add
          ('(( EXISTS (SELECT MasterCopySeparationSet FROM PageTable P2  WITH (NOLOCK) WHERE P1.MasterCopySeparationSet=P2.MasterCopySeparationSet AND (P1.PublicationID<>P2.PublicationID OR P1.PubDate <> P2.PubDate)))');
        DataM1.Query3.sql.add
          ('or (not EXISTS (SELECT P3.MasterCopySeparationSet FROM PageTable P3 WITH (NOLOCK) WHERE P1.MasterCopySeparationSet=P3.MasterCopySeparationSet AND p3.uniquepage = 1)))');
        if Prefs.debug then
          DataM1.Query3.sql.SaveToFile
            (IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) +
            'sqllogs\' + 'Chepagetable.sql');
        DataM1.Query3.open;
        anytorepair := not DataM1.Query3.eof;
        DataM1.Query3.close;

        IF anytorepair then
        begin
          DataM1.Query3.sql.clear;
          DataM1.Query3.sql.add('Exec spRepairPageTable @PressSpecificPlan = ' +
            inttostr(Integer(FormApplyproduction.CheckBoxpressspecifik.
            checked)));
          formmain.trysql(DataM1.Query3);
        End;
      end;
    End;

    Deletetouniqueplates;

  finally
    formmain.Setplanlock(false);
  end;
end;

procedure TFormprodplan.Deletetouniqueplates;
Var
  iplf, ipl, ip
  // ,ip2,ic
  // ,nup
    : Integer;
begin
  formmain.planlogging('Deletetouniqueplates');
  For iplf := 1 to Nplateframes do
  begin
    For ipl := 0 to plateframes[iplf].NProdPlates do
    begin
      plateframesdata[iplf].ProdPlates[ipl].NUniquepages := 0;
      for ip := 1 to PlatetemplateArray
        [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
      begin
        IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totUniquePage > 0
        then
        begin
          Inc(plateframesdata[iplf].ProdPlates[ipl].NUniquepages);
        End;
      End;

    end;
  End;

  (*
    for ip := 1 to platetemplatearray[plateframesdata[iplf].prodplates[ipl].templatelistid].NupOnplate do
    begin
    IF plateframesdata[iplf].prodplates[ipl].Pages[ip].pagetype = 3 then
    begin
    for ip2 := 1 to platetemplatearray[plateframesdata[iplf].prodplates[ipl].templatelistid].NupOnplate do
    Begin
    if plateframesdata[iplf].prodplates[ipl].Pages[ip2].pagetype <> 3 then
    Begin
    plateframesdata[iplf].prodplates[ipl].Pages[ip].Oldrunid :=
    plateframesdata[iplf].prodplates[ipl].Pages[ip2].Oldrunid;
    plateframesdata[iplf].prodplates[ipl].Pages[ip].totapproval :=
    plateframesdata[iplf].prodplates[ipl].Pages[ip2].totapproval;
    plateframesdata[iplf].prodplates[ipl].Pages[ip].Anyheld :=
    plateframesdata[iplf].prodplates[ipl].Pages[ip2].anyheld;
    plateframesdata[iplf].prodplates[ipl].Pages[ip].totUniquePage := 0;



    For i := fdfd

  *)

end;

procedure TFormprodplan.ActionclearExecute(Sender: TObject);
// Var
// IPLF : Integer;
begin
  IF Anychange then
  begin
    if MessageDlg(formmain.InfraLanguage1.Translate
      ('All changes will be lost Continue?'), mtWarning, [mbYes, mbCancel], 0) = mrcancel
    then
      exit;
  end;
  Anychange := false;
  Editmode := PLANADDMODE_EDIT;
  ActionRun.ImageIndex := 98;
  ActionRun.Caption := 'Run';

  formmain.Deallocateplateframes;

  Nplateframes := 0;

  IF CheckBoxsmallimagesinEdit.checked then
    Pressviewzoom := 60
  else
    Pressviewzoom := 100;

  plateviewimage.Width := 23; // 204
  plateviewimage.Height := 51; // 176
  setactionenabled;
end;

procedure TFormprodplan.setactions;
Begin
  ActionSave.Enabled := false;
  ActionRun.Enabled := false;
  Actionclear.Enabled := false;
  IF Nplateframes > 0 then
  Begin
    ActionSave.Enabled := true;
    ActionRun.Enabled := true;
    Actionclear.Enabled := true;
  end;
end;

procedure TFormprodplan.findorgedpages;
Var
  found: Boolean;
  iplf, ipl, ip: Integer;
  Iplf2, ipl2, ip2: Integer;
Begin
  For iplf := 1 to Nplateframes do
  begin
    For ipl := 0 to plateframes[iplf].NProdPlates do
    begin
      for ip := 1 to PlatetemplateArray
        [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
      begin
        if plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totUniquePage <> 1
        then
        begin
          found := false;
          For Iplf2 := 1 to Nplateframes do
          begin
            For ipl2 := 0 to plateframes[Iplf2].NProdPlates do
            begin
              if plateframesdata[Iplf2].ProdPlates[ipl2]
                .editionid = plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Orgeditionid
              then
              begin
                for ip2 := 1 to PlatetemplateArray
                  [plateframesdata[Iplf2].ProdPlates[ipl2].templatelistid]
                  .NupOnplate do
                begin
                  if (plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                    .pagename = plateframesdata[Iplf2].ProdPlates[ipl2].Pages
                    [ip2].pagename) and
                    (plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                    .sectionid = plateframesdata[Iplf2].ProdPlates[ipl2].Pages
                    [ip2].sectionid) then
                  begin
                    found := true;
                    plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                      .OrgPageiplf := Iplf2;
                    plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                      .OrgPageipl := ipl2;
                    plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                      .OrgPageip := ip2;
                    plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                      .OrgCopySeparationSet := plateframesdata[Iplf2].ProdPlates
                      [ipl2].Pages[ip2].CopySeparationSet;
                    break;
                  end;
                End;
                if found then
                  break;
              End;
              if found then
                break;
            End;
            if found then
              break;
          End;

          if not found then
          begin
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].OrgPageiplf := iplf;
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].OrgPageipl := ipl;
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].OrgPageip := ip;
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].OrgCopySeparationSet
              := plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
              .CopySeparationSet;
          end;

        end;
      end;
    End;
  End;
end;

// Handle progresss bar
procedure TFormprodplan.StatusBar1DrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);

Var
  I: Integer;
begin
  I := Rect.Bottom - Rect.Top;
  IF I < ProgressBarprod.Height then
  Begin
    StatusBar1.Height := StatusBar1.Height + (ProgressBarprod.Height - I);
  end
  else
  begin
    // StatusBar1.Canvas.Brush.Color := clblue;
    // StatusBar1.Canvas.Rectangle(rect);
  end;
  IF ProgressBarprod.Parent <> StatusBar1 then
  begin
    ProgressBarprod.Top := Rect.Top;
    ProgressBarprod.left := Rect.left;
    ProgressBarprod.Width := StatusBar1.Panels[1].Width;
    ProgressBarprod.Parent := StatusBar1;
  end
  Else
  begin
    ProgressBarprod.Top := Rect.Top;
    ProgressBarprod.left := Rect.left;
    ProgressBarprod.Width := StatusBar1.Panels[1].Width;
  end;
end;

Procedure TFormprodplan.GetprodrundatafromUI;

Var
  T: string;
  I, I2: Integer;

Begin
  I2 := 0;
  T := '';
  prodsections := '';
  prodpages := '';

  For I := 0 to FormAddpressrun.PBExListviewSections.items.count - 1 do
  begin
    prodsections := prodsections +
      inttostr(tnames1.sectionnametoid(FormAddpressrun.PBExListviewSections.
      items[I].Caption)) + ';';
    prodpages := prodpages + FormAddpressrun.PBExListviewSections.items[I]
      .subitems[0] + ';';
  end;
  prodcombined := 0;
  // Integer(FormAddpressrun.CheckBoxCombinetoonerunX.Checked);
  prodbindingstyle := Integer(FormAddpressrun.CheckBoxbindingstyle.checked);
  prodcollection := FormAddpressrun.RadioGroupcollection.ItemIndex;
  prodplancreep := Formselecttemplate.Creep;
  Currentcreep := Formselecttemplate.Creep;
  prodplannedhold := Formaddplan.RadioGrouplocked.ItemIndex;
  prodplannedapproval := Formaddplan.RadioGroupApproval.ItemIndex;
end;

Procedure TFormprodplan.saveprodrundata(productionid: Integer);
Begin
  if not JustAlayoutchange then
  begin
    DataM1.Query1.sql.clear;
    DataM1.Query1.sql.add('update productionnames ');
    DataM1.Query1.sql.add('set sections = ' + '''' + prodsections + '''');
    DataM1.Query1.sql.add(',pages = ' + '''' + prodpages + '''');
    DataM1.Query1.sql.add(',combined = ' + inttostr(prodcombined));
    DataM1.Query1.sql.add(',bindingstyle = ' + inttostr(prodbindingstyle));
    DataM1.Query1.sql.add(',collection = ' + inttostr(prodcollection));
    DataM1.Query1.sql.add(',plancreep = :creep');
    DataM1.Query1.sql.add(',plannedhold = ' + inttostr(prodplannedhold));
    DataM1.Query1.sql.add(',plannedapproval = ' +
      inttostr(prodplannedapproval));

    // ### NAN 20160209 - PlanType 2 illegal..
    // IF FormApplyproduction.CheckBoxAllowunplannedcolors.Checked then
    DataM1.Query1.sql.add(',plantype = 1');
    // else
    // DataM1.Query1.sql.add(',plantype = 2');

    DataM1.Query1.sql.add('where productionID=' + inttostr(productionid));
    DataM1.Query1.ParamByName('creep').AsFloat := prodplancreep;
    formmain.trysql(DataM1.Query1);
  End;
end;

Procedure TFormprodplan.Loadprodrundata(productionid: Integer);
Begin
  DataM1.Query2.sql.clear;
  //DataM1.Query2.sql.add('Select * from ProductionNames WITH (NOLOCK) ');
  DataM1.Query2.sql.add('SELECT sections,pages,combined,bindingstyle,collection,plancreep,plannedhold,plannedapproval,plantype FROM ProductionNames WITH (NOLOCK) ');
  DataM1.Query2.sql.add('WHERE productionID = ' + inttostr(productionid));

  prodsections := '';
  prodpages := '';
  prodcombined := 0;
  prodbindingstyle := 0;
  prodcollection := 0;
  prodplancreep := 0;
  prodplannedhold := 0;
  prodplannedapproval := 0;

  formmain.Tryopen(DataM1.Query2);
  if not DataM1.Query2.eof then
  begin
    prodsections :=  DataM1.Query2.fields[0].AsString;//DataM1.Query2.fieldbyname('sections').asstring;
    prodpages := DataM1.Query2.fields[1].AsString;//DataM1.Query2.fieldbyname('pages').asstring;
    prodcombined := DataM1.Query2.fields[2].AsInteger;//DataM1.Query2.fieldbyname('combined').asinteger;
    prodbindingstyle := DataM1.Query2.fields[3].AsInteger; //DataM1.Query2.fieldbyname('bindingstyle').asinteger;
    prodcollection := DataM1.Query2.fields[4].AsInteger; //DataM1.Query2.fieldbyname('collection').asinteger;
    prodplancreep := DataM1.Query2.fields[5].AsFloat; //DataM1.Query2.fieldbyname('plancreep').AsFloat;
    prodplannedhold := DataM1.Query2.fields[6].AsInteger; // DataM1.Query2.fieldbyname('plannedhold').asinteger;
    prodplannedapproval :=  DataM1.Query2.fields[7].AsInteger; //DataM1.Query2.fieldbyname('plannedapproval').asinteger;
    prodplantype := DataM1.Query2.fields[8].AsInteger; //DataM1.Query2.fieldbyname('plantype').asinteger;
  End;
  DataM1.Query2.close;
end;

Procedure TFormprodplan.SetprodrundataToUI;
Var
  L: TListItem;
  T
  // ,T2
    : string;
  I, I2, secstep: Integer;
  Validsecdata: Integer;
  nSections: Integer;
  Sections: array [1 .. 100] of record sectionname: String;
  Pages: string;
  prefix: String;
  postfix: string;
  coverp: String;
  Insertp: string;
  offsetp: String;
end;

procedure Applydatasecdata;
Begin
  case secstep of
    0:
      begin
        Inc(nSections);
        Sections[nSections].sectionname :=
          tnames1.sectionIDtoname(strtointDef(T, 0));
        Inc(Validsecdata);
      end;
    1:
      Begin
        Sections[nSections].prefix := T;
        Inc(Validsecdata);
      end;
    2:
      Begin
        Sections[nSections].postfix := T;
        Inc(Validsecdata);
      end;
    3:
      Begin
        Sections[nSections].coverp := T;
        Inc(Validsecdata);
      end;
    4:
      Begin
        Sections[nSections].Insertp := T;
        Inc(Validsecdata);
      end;
    5:
      Begin
        Sections[nSections].offsetp := T;
        Inc(Validsecdata);
      end;
  end;
end;

Begin
  I2 := 0;
  T := '';
  Validsecdata := 0;
  nSections := 0;
  secstep := 0;
  For I := 1 to length(prodsections) do
  begin
    case prodsections[I] of
      '(':
        begin

          Applydatasecdata;
          Inc(secstep);
          T := '';
        end;
      ')':
        begin
        end;
      ';':
        Begin

          Applydatasecdata;
          Inc(secstep);
          T := '';
          secstep := 0;
        end;
    else
      T := T + prodsections[I];

    end;
  end;
  T := '';
  I2 := 1;
  For I := 1 to length(prodpages) do
  Begin
    if prodpages[I] = ';' then
    begin
      Sections[I2].Pages := T;
      Inc(I2);
      T := '';
    end
    else
    begin
      T := T + prodpages[I];
    end;
  end;

  IF (nSections > 0) And (Validsecdata >= 6) then
  begin
    FormAddpressrun.PBExListviewSections.items.clear;

    for I := 1 to nSections do
    begin
      L := FormAddpressrun.PBExListviewSections.items.add;
      L.Caption := Sections[I].sectionname;
      L.subitems.add(Sections[I].Pages);
      L.subitems.add(Sections[I].prefix);
      L.subitems.add(Sections[I].postfix);
      L.subitems.add(Sections[I].coverp);
      L.subitems.add(Sections[I].Insertp);
      L.subitems.add(Sections[I].offsetp);
    end;

    FormAddpressrun.CheckBoxCombinetoonerun.checked := Boolean(prodcombined);
    FormAddpressrun.CheckBoxCombinetoonerun.checked := false;
    FormAddpressrun.CheckBoxbindingstyle.checked := Boolean(prodbindingstyle);
    FormAddpressrun.RadioGroupcollection.ItemIndex := prodcollection;
    Formselecttemplate.Creep := prodplancreep;
    Formaddplan.RadioGrouplocked.ItemIndex := prodplannedhold;
    Formaddplan.RadioGroupApproval.ItemIndex := prodplannedapproval;

    FormAddextrapressrun.CheckBoxCombinetoonerun.checked :=
      Boolean(prodcombined);
    FormAddextrapressrun.CheckBoxCombinetoonerun.checked := false;
    FormAddextrapressrun.CheckBoxbindingstyle.checked :=
      Boolean(prodbindingstyle);
    FormAddextrapressrun.RadioGroupcollection.ItemIndex := prodcollection;

  End;
end;

procedure TFormprodplan.ActionSaveExecute(Sender: TObject);
Var
  presstemplateid: Integer;
  iplf, ipl, ip, ic: Integer;
  aktmrkstr, pageposstr, S: string;
  isok: Boolean;
  Maxup: Integer;
  Copiesprrun: Array [1 .. 100] of Integer;
  NumberOfRuns, RunNumber: Integer;
begin
  formmain.planlogging('ActionSaveExecute');
  try

    if Editmode <> PLANADDMODE_MULTISAVE then
      presstemplateid := formmain.getpressplanid
    else
      presstemplateid := Multiplanid;

    IF presstemplateid = -1 then
      exit;

    isok := true;

    IF Formtower.CheckBox1.checked then
    begin
      (*
        IF (not checktowers) OR () then
        begin
        if MessageDlg(formmain.InfraLanguage1.Translate('Tower have not been assigned to all plates ')+ #13+
        formmain.InfraLanguage1.Translate('plan will not use tower specific fanout, Continue?') ,
        mtConfirmation, [mbYes, mbno	], 0) <> mrYes then
        begin
        exit;
        End;
        end;
      *)
    end;
    if Formsavename.appending then
    begin
      DataM1.Query1.sql.clear;
      DataM1.Query1.sql.add
        ('SELECT PublicationID FROM PressTemplate WITH (NOLOCK) ');
      DataM1.Query1.sql.add('WHERE PresstemplateID = ' +
        inttostr(presstemplateid));
      DataM1.Query1.sql.add('AND PublicationID <> ' +
        inttostr(plateframesdata[1].ProdPlates[0].publicationid));
      formmain.Tryopen(DataM1.Query1);
      IF not DataM1.Query1.eof then
      begin
        isok := false;
        MessageDlg(formmain.InfraLanguage1.Translate
          ('There cannot be two or more different publications in one press template'),
          mtError, [mbOk], 0);
      end;
      DataM1.Query1.close;
    end;

    if not isok then
      exit;

    if Formsavename.appending then
    begin
      RunNumber := 0;

      DataM1.Query1.sql.clear;
      DataM1.Query1.sql.add
        ('SELECT DISTINCT RunNumber FROM PressTemplate WITH (NOLOCK)');
      DataM1.Query1.sql.add('WHERE PresstemplateID = ' +
        inttostr(presstemplateid));
      DataM1.Query1.sql.add('AND PressID = ' +
        inttostr(plateframesdata[1].ProdPlates[0].Pressid));
      formmain.Tryopen(DataM1.Query1);
      while not DataM1.Query1.eof do
      begin
        RunNumber := DataM1.Query1.fields[0].asinteger;
        DataM1.Query1.next;
      end;
      DataM1.Query1.close;
    end
    else
    begin
      DataM1.Query1.sql.clear;
      DataM1.Query1.sql.add('DELETE PressTemplate');
      DataM1.Query1.sql.add('WHERE PressTemplateID = ' +
        inttostr(presstemplateid));
      DataM1.Query1.sql.add('AND PressID = ' +
        inttostr(plateframesdata[1].ProdPlates[0].Pressid));
      formmain.trysql(DataM1.Query1);
      RunNumber := 0;
    end;

    NumberOfRuns := 0;
    For iplf := 1 to Nplateframes do
    begin
      if Formappendruns.ListViewappend.items[iplf - 1].checked then
        Inc(NumberOfRuns);
    End;

    For iplf := 1 to Nplateframes do
    begin
      Copiesprrun[iplf] := 1;
      For ipl := 0 to plateframes[iplf].NProdPlates do
      begin
        IF Copiesprrun[iplf] < plateframesdata[iplf].ProdPlates[ipl].Copynumber
        then
        begin
          Copiesprrun[iplf] := plateframesdata[iplf].ProdPlates[ipl].Copynumber;
        end;
      End;

    End;

    For iplf := 1 to Nplateframes do
    begin
      Maxup := 0;

      For ipl := 0 to plateframes[iplf].NProdPlates do
      begin
        IF Maxup < PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl]
          .templatelistid].NupOnplate then
          Maxup := PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl]
            .templatelistid].NupOnplate;
      end;

      if Formappendruns.ListViewappend.items[iplf - 1].checked then
      begin
        Inc(RunNumber);
        For ipl := 0 to plateframes[iplf].NProdPlates do
        begin

          IF plateframesdata[iplf].ProdPlates[ipl].Copynumber = 1 then
          begin
            aktmrkstr := inittypes.marksIDstr(plateframesdata[iplf].ProdPlates
              [ipl].Nmarkgroups, plateframesdata[iplf].ProdPlates[ipl]
              .markgroups);

            for ip := 1 to
              Maxup { PlatetemplateArray[plateframesdata[iplf].prodplates[ipl].templatelistid].NupOnplate }
              do
            begin
              pageposstr := pagepositionsfromprodplate
                (plateframesdata[iplf].ProdPlates[ipl], ip);

              IF pageposstr = '' then
                pageposstr := inttostr(ip);
              if plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors = 0
              then
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors := 1;
              for ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                .Ncolors do
              begin
                DataM1.Query1.sql.clear;
                DataM1.Query1.sql.add('Insert Presstemplate');
                DataM1.Query1.sql.add('values(');
                DataM1.Query1.sql.add(inttostr(presstemplateid) + ',');
                { PresstemplateID }
                DataM1.Query1.sql.add
                  (inttostr(plateframesdata[iplf].ProdPlates[ipl].Pressid) +
                  ','); { PressID }
                DataM1.Query1.sql.add(inttostr(NumberOfRuns) + ',');
                { NumberOfRuns }
                DataM1.Query1.sql.add
                  (inttostr(plateframesdata[iplf].ProdPlates[ipl].publicationid)
                  + ','); { PublicationID }
                DataM1.Query1.sql.add
                  (inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                  .colors[ic].active) + ',');
                // issue bruges nu til active                                         {IssueID}
                DataM1.Query1.sql.add
                  (inttostr(plateframesdata[iplf].ProdPlates[ipl].editionid) +
                  ','); { EditionID }
                DataM1.Query1.sql.add(inttostr(RunNumber) + ','); { RunNumber }
                DataM1.Query1.sql.add
                  (inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                  .sectionid) + ','); { SectionID }
                DataM1.Query1.sql.add
                  (inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                  .pagina) + ','); { Pagina }
                DataM1.Query1.sql.add('''' + plateframesdata[iplf].ProdPlates
                  [ipl].Pages[ip].pagename + '''' + ','); { Pagename }
                DataM1.Query1.sql.add
                  (inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                  .colors[ic].ColorID) + ','); { Color }
                DataM1.Query1.sql.add
                  (inttostr(PlatetemplateArray[plateframesdata[iplf].ProdPlates
                  [ipl].templatelistid].TemplateID) + ','); { TemplateID }
                DataM1.Query1.sql.add(inttostr(0) + ',');
                DataM1.Query1.sql.add('''' + GetPlannameFromID(2,
                  plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                  .stackpos) + '''' + ','); { stackpos }
                DataM1.Query1.sql.add
                  ('''' + Getplantowername(plateframesdata[iplf].ProdPlates[ipl]
                  .Tower) + '''' + ','); { TowerID }
                DataM1.Query1.sql.add('''' + GetPlannameFromID(5,
                  plateframesdata[iplf].ProdPlates[ipl].Zone) + '''' + ',');
                { ZoneID }

                IF (plateframesdata[iplf].ProdPlates[ipl].TrueFront IN [2, 3])
                  And (Prefs.UseTrueSheetSide) then
                  DataM1.Query1.sql.add
                    ('''' + fronbackstr[plateframesdata[iplf].ProdPlates[ipl]
                    .TrueFront - 2] + '''' + ',')
                Else
                  DataM1.Query1.sql.add('''' + GetPlannameFromID(4,
                    plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                    .Cylinder) + '''' + ','); { CylinderID }

                DataM1.Query1.sql.add('''' + GetPlannameFromID(3,
                  plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                  .High) + '''' + ','); { High }
                DataM1.Query1.sql.add
                  (inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                  .CopySeparationSet) + ','); { copySeparationSet }
                DataM1.Query1.sql.add
                  (inttostr(plateframesdata[iplf].ProdPlates[ipl]
                  .CopyFlatSeparationSet) + ','); { copyflatSeparationSet }
                DataM1.Query1.sql.add(inttostr(ip) + ',');
                // pairpos num bruges den til at s�tte ind i ip
                DataM1.Query1.sql.add
                  (inttostr(plateframesdata[iplf].ProdPlates[ipl].Front) + ',');
                DataM1.Query1.sql.add
                  (inttostr(plateframesdata[iplf].ProdPlates[ipl]
                  .sheetnumber) + ',');
                DataM1.Query1.sql.add(inttostr(Copiesprrun[iplf]) + ',');
                DataM1.Query1.sql.add(inttostr(ic) + ',');
                // platenumber bruges nu til ic
                DataM1.Query1.sql.add
                  (inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                  .pagetype) + ',');
                DataM1.Query1.sql.add('''' + aktmrkstr + '''' + ',');
                DataM1.Query1.sql.add
                  (inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                  .Pageindex) + ',');
                DataM1.Query1.sql.add('''' + pageposstr + '''' + ',');
                DataM1.Query1.sql.add
                  (inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                  .proofid) + ',');
                DataM1.Query1.sql.add('''' + prodsections + '''' + ',');
                DataM1.Query1.sql.add('''' + prodpages + '''' + ',');
                DataM1.Query1.sql.add(inttostr(prodcombined) + ',');
                DataM1.Query1.sql.add(inttostr(prodbindingstyle) + ',');
                DataM1.Query1.sql.add(inttostr(prodcollection) + ',');
                DataM1.Query1.sql.add(':plannedcreep' + ',');
                DataM1.Query1.sql.add
                  (inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                  .totUniquePage) + ',');
                DataM1.Query1.sql.add
                  (inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                  .Orgeditionid) + ',');
                DataM1.Query1.sql.add
                  (inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                  .MasterCopySeparationSet) + ',');
                DataM1.Query1.sql.add
                  (inttostr(plateframesdata[iplf].ProdPlates[ipl]
                  .Presssectionnumber) + ',');
                DataM1.Query1.sql.add(':creep');
                DataM1.Query1.sql.add(',');
                DataM1.Query1.sql.add
                  (inttostr(plateframes[iplf].SequenceNumber) + ',');
                DataM1.Query1.sql.add('0,'); // gutterimage
                DataM1.Query1.sql.add
                  (inttostr(plateframesdata[iplf].ProdPlates[ipl]
                  .FlatProofConfigurationID) + ',');
                DataM1.Query1.sql.add
                  (inttostr(plateframesdata[iplf].ProdPlates[ipl]
                  .HardProofConfigurationID) + ',');

                DataM1.Query1.sql.add
                  (inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                  .colors[ic].Miscint1) + ',');
                DataM1.Query1.sql.add
                  (inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                  .colors[ic].Miscint2) + ',');
                DataM1.Query1.sql.add
                  (inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                  .colors[ic].Miscint3) + ',');
                DataM1.Query1.sql.add
                  (inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                  .colors[ic].Miscint4) + ',');
                DataM1.Query1.sql.add('''' + GetPlannameFromID(6,
                  plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                  .Miscstring1) + '''' + ',');
                DataM1.Query1.sql.add('''' + GetPlannameFromID(7,
                  plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                  .Miscstring2) + '''' + ',');

                // #### 20181203 - try storing highlow copy in MicsString3..
                if (Copiesprrun[iplf] = 2) then
                  DataM1.Query1.sql.add('''' + GetPlannameFromID(3,
                    plateframesdata[iplf].ProdPlates[ipl + 1].Pages[ip].colors
                    [ic].High) + '''' + ',') { High }
                else
                  DataM1.Query1.sql.add('''' + GetPlannameFromID(8,
                    plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                    .Miscstring3) + '''' + ',');
                DataM1.Query1.sql.add
                  (inttostr(Integer(Formtower.CheckBox1.checked)) + ',');
                DataM1.Query1.sql.add('''' + plateframes[iplf].Comment +
                  '''' + ',');
                DataM1.Query1.sql.add('''' + plateframes[iplf].PressConfignameX
                  + '''' + ',');
                DataM1.Query1.sql.add
                  (inttostr(plateframes[iplf].perfecktbound) + ',');
                DataM1.Query1.sql.add
                  (inttostr(plateframes[iplf].inserted) + ',');


                // ## NAN 20160309
                // DataM1.Query1.sql.add(inttostr(plateframes[iplf].Backwards) + ',');

                if (plateframes[iplf].RipSetupID < 0) then
                  plateframes[iplf].RipSetupID := 0;
                if (PressTemplatePageRotationPossible) then
                  DataM1.Query1.sql.add
                    (inttostr(plateframes[iplf].RipSetupID) + ',0)')
                else
                  DataM1.Query1.sql.add
                    (inttostr(plateframes[iplf].RipSetupID) + ')');

                IF Presstemplatedbversion > 1 then
                // 1 har kun til og med Backwards   2 g�r helt til ColorControlID
                begin
                  DataM1.Query1.sql.add('0,'); // TimedEditionFrom
                  DataM1.Query1.sql.add('0,'); // TimedEditionTo
                  DataM1.Query1.sql.add('0,'); // FromZone
                  DataM1.Query1.sql.add('0,'); // ToZone
                  DataM1.Query1.sql.add('0,'); // PreFlightID
                  DataM1.Query1.sql.add('0,');
                  DataM1.Query1.sql.add('0)'); // ColorControlID
                end;
                DataM1.Query1.ParamByName('plannedcreep').AsFloat :=
                  Currentcreep;
                DataM1.Query1.ParamByName('creep').AsFloat :=
                  plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Creep;
                formmain.trysql(DataM1.Query1);
              end;
            end;
          End;
        end;
      end;
    end;

    DataM1.Query1.sql.clear;
    DataM1.Query1.sql.add('UPDATE PressTemplate');
    DataM1.Query1.sql.add('SET NumberOfRuns = ' + inttostr(RunNumber));
    DataM1.Query1.sql.add('WHERE PresstemplateID = ' +
      inttostr(presstemplateid));
    DataM1.Query1.sql.add('AND PressID = ' +
      inttostr(plateframesdata[1].ProdPlates[0].Pressid));
    formmain.trysql(DataM1.Query1);

    if Formappendruns.CheckBoxautoname.checked then
    begin
      DataM1.Query1.sql.clear;
      DataM1.Query1.sql.add('Select PresstemplateID from Presstemplatenames');
      DataM1.Query1.sql.add('Where name = ' + '''' +
        Formappendruns.newautoname + '''');
      DataM1.Query1.sql.add('and PresstemplateID <> ' +
        inttostr(presstemplateid));
      formmain.Tryopen(DataM1.Query1);
      IF not DataM1.Query1.eof then
        Formappendruns.newautoname := Formappendruns.newautoname + '  2';
      DataM1.Query1.close;

      DataM1.Query1.sql.clear;
      DataM1.Query1.sql.add('update Presstemplatenames');
      DataM1.Query1.sql.add('set name = ' + '''' +
        Formappendruns.newautoname + '''');
      DataM1.Query1.sql.add('where PresstemplateID = ' +
        inttostr(presstemplateid));
      formmain.trysql(DataM1.Query1);

      IF Formsavename.ComboBoxname.items.IndexOf(Formappendruns.newautoname) = -1
      then
      Begin
        Formsavename.ComboBoxname.items.add(Formappendruns.newautoname);
        Formsavename.ComboBoxname.Text := Formappendruns.newautoname;
      end;
    end;
  except
  end;
  Anychange := false;
  formmain.planlogging('ActionSaveExecute End');
end;

procedure TFormprodplan.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Copytopressdontshowapply := false;
  planisactive := false;
  formmain.Setplanlock(false);
end;



// Gets  PressRunID from existing product in DB mathcing current EditionID,SectionID

procedure TFormprodplan.SetPressrunIds;
Var
  iplf, ipl, ip: Integer;

  Firstpublrun: Integer;
  PublRuncounter: Integer;
  foundsec: Boolean;
begin
  formmain.planlogging('SetPressrunIds()');

  // Check om publ og production findes
  Firstpublrun := 0;
  DataM1.Query1.sql.clear;
  DataM1.Query1.sql.add('SELECT DISTINCT PressRunID FROM PageTable WITH (NOLOCK) ');
  DataM1.Query1.sql.add('WHERE PressID = ' + IntToStr(plateframespressid));
  DataM1.Query1.sql.add('AND PublicationID = ' + IntToStr(plateframesdata[1].ProdPlates[0].publicationid));
  DataM1.Query1.sql.add('AND ProductionID = ' + IntToStr(plateframesdata[1].ProdPlates[0].productionid));
  DataM1.Query1.sql.add('AND ' + DataM1.makedatastr('', plateframesPubdate));
  DataM1.Query1.sql.add('ORDER BY PressRunID');
  formmain.Tryopen(DataM1.Query1);
  IF not DataM1.Query1.eof then
  begin
    Firstpublrun := DataM1.Query1.fields[0].asinteger;
  end;
  PublRuncounter := 0;
  While not DataM1.Query1.eof do
  begin
    Inc(PublRuncounter);
    DataM1.Query1.next;
  end;
  DataM1.Query1.close;

  IF Firstpublrun > 0 then
  begin // productionen findes den skal overskrives
    foundsec := false;
    DataM1.Query1.sql.clear;
    DataM1.Query1.sql.add
      ('Select distinct pressrunid,editionid,sectionid,pagename from pagetable WITH (NOLOCK) ');
    DataM1.Query1.sql.add('where pressid = ' + inttostr(plateframespressid));
    DataM1.Query1.sql.add('and publicationid = ' + IntToStr(plateframesdata[1].ProdPlates[0].publicationid));
    DataM1.Query1.sql.add('and productionid = ' + IntToStr(plateframesdata[1].ProdPlates[0].productionid));
    DataM1.Query1.sql.add('and ' + DataM1.makedatastr('', plateframesPubdate));
    DataM1.Query1.sql.add('order by pressrunid');
    formmain.Tryopen(DataM1.Query1);
    While not DataM1.Query1.eof do
    begin
      For iplf := 1 to Nplateframes do
      begin
        For ipl := 0 to plateframes[iplf].NProdPlates do
        begin
          IF plateframesdata[iplf].ProdPlates[ipl].editionid = DataM1.Query1.
            fields[1].asinteger then
          begin
            for ip := 1 to PlatetemplateArray
              [plateframesdata[iplf].ProdPlates[ipl].templatelistid]
              .NupOnplate do
            begin
              IF (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].sectionid = DataM1.Query1.fields[2].asinteger) And
                (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename = DataM1.Query1.fields[3].asstring) then
              begin
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Oldrunid :=  DataM1.Query1.fields[0].asinteger;
              end;
            end;
            break;
          end;
        end;
      end;
      DataM1.Query1.next;
    end;
    DataM1.Query1.close;
  end; // end same prod
  formmain.planlogging('setpressrunids End');
end;

// Gets  PressRunID from existing product in DB mathcing current EditionID,SectionID
// Variant??
procedure TFormprodplan.SetPressrunIdsToDBrunId;
Var
  iplf, ipl, ip: Integer;

begin
  formmain.planlogging('SetPressrunIdsToDBrunId()');
  if Nplateframes > 0 then
  begin
    DataM1.Query1.sql.clear;
    DataM1.Query1.sql.add
      ('Select distinct pressrunid,editionid,sectionid,pagename from pagetable WITH (NOLOCK) ');
    DataM1.Query1.sql.add('where pressid = ' + inttostr(plateframespressid));
    DataM1.Query1.sql.add('and publicationid = ' +
      inttostr(plateframespublicationid));
    DataM1.Query1.sql.add('and productionid = ' +
      inttostr(plateframesproductionid));
    DataM1.Query1.sql.add('and ' + DataM1.makedatastr('', plateframesPubdate));
    DataM1.Query1.sql.add('order by pressrunid');
    formmain.Tryopen(DataM1.Query1);
    While not DataM1.Query1.eof do
    begin
      For iplf := 1 to Nplateframes do
      begin
        For ipl := 0 to plateframes[iplf].NProdPlates do
        begin
          IF plateframesdata[iplf].ProdPlates[ipl].editionid = DataM1.Query1.
            fields[1].asinteger then
          begin
            for ip := 1 to PlatetemplateArray
              [plateframesdata[iplf].ProdPlates[ipl].templatelistid]
              .NupOnplate do
            begin
              IF (plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                .sectionid = DataM1.Query1.fields[2].asinteger) And
                (plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                .pagename = DataM1.Query1.fields[3].asstring) then
              begin
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Oldrunid :=
                  DataM1.Query1.fields[0].asinteger;
                plateframesdata[iplf].ProdPlates[ipl].runid :=
                  DataM1.Query1.fields[0].asinteger;
              end;
            end;
          end;
        end;
      end;
      DataM1.Query1.next;
    end;
    DataM1.Query1.close;
  End;
  formmain.planlogging('setpressrunidstodbrunid End');
end;

Function TFormprodplan.doreimposecalc(templatenumber: Integer;
  resethw: Boolean): Boolean;
Var
  I: Integer;
  Nup, isec, iflat, isgn: Integer;

Begin
  result := true;

  formmain.planlogging('doreimposecalc');
  Nup := PlatetemplateArray[templatenumber].NupOnplate;
  Nplanpagesections := Nplanpagesections; // ??????????????????
  AktPRODUCTION.nSectionsInProduction := Nplanpagesections;
  AktPRODUCTION.nGeneralPageOffset := 1;
  AktPRODUCTION.nCollectionMode := 0;
  AktPRODUCTION.nSplitmode := PlatetemplateArray
    [Formselecttemplate.Selectedtemplatenumber].Splitmode;
  // newcreep
  AktPRODUCTION.fCreepSetting := 100;
  Currentcreep := prodplancreep;
  // oldcreep
  // AktPRODUCTION.fCreepSetting := prodplancreep;

  For isec := 1 to AktPRODUCTION.nSectionsInProduction do
  begin
    AktPRODUCTION.aSections[isec].Nhalfwebpage := planpagenames[isec].hw1;
    AktPRODUCTION.aSections[isec].nHalfWebPage2 := planpagenames[isec].hw2;

    IF PlatetemplateArray[templatenumber].ISdouble > 1 then
      AktPRODUCTION.aSections[isec].nPagesInSection := planpagenames[isec]
        .Npages (* *PlatetemplateArray[templatenumber].ISdouble *)
    else
      AktPRODUCTION.aSections[isec].nPagesInSection :=
        planpagenames[isec].Npages;

    MakingdoubleFrontback := PlatetemplateArray
      [Formselecttemplate.Selectedtemplatenumber].ISDoublefronttoback = 1;
    AktPRODUCTION.aSections[isec].nStartingPageNumber := 1;
    AktPRODUCTION.aSections[isec].nBindingStyle := prodbindingstyle;
    AktPRODUCTION.aSections[isec].nFlatsInSection :=
      ((AktPRODUCTION.aSections[isec].nPagesInSection div Nup) div 2) +
      ((AktPRODUCTION.aSections[isec].nPagesInSection div Nup) mod 2);

    AktPRODUCTION.aSections[isec].nFlatsInSection := AktPRODUCTION.aSections
      [isec].nFlatsInSection * 2;

    IF (AktPRODUCTION.aSections[isec].nPagesInSection mod Nup <> 0)
    { and (nup mod 3 <> 0) } then
    begin
      MessageDlg(formmain.InfraLanguage1.Translate
        ('Number of pages do not fit platelayout'), mtError, [mbOk], 0);
      exit;
    End;

    For iflat := 1 to AktPRODUCTION.aSections[isec].nFlatsInSection + 2 do
    begin
      NupCol := Nup;
      IF AktPRODUCTION.nSplitmode > 0 then
        NupCol := Nup * 2;

      AktPRODUCTION.aSections[isec].aFlats[iflat].bIsDualSided := 1;
      AktPRODUCTION.aSections[isec].aFlats[iflat].nPagesPerSide := NupCol;

      For isgn := 1 to NupCol do
      begin
        AktPRODUCTION.aSections[isec].aFlats[iflat].aSignaturePages[isgn] :=
          PlatetemplateArray[templatenumber].PageNumberingFront[isgn];
      end;
      For isgn := 1 to NupCol do
      begin
        AktPRODUCTION.aSections[isec].aFlats[iflat].aSignaturePages
          [isgn + NupCol] := PlatetemplateArray[templatenumber]
          .PageNumberingback[isgn];
      end;
      For isgn := 1 to NupCol do
      begin
        AktPRODUCTION.aSections[isec].aFlats[iflat].aHalfwebSignaturePages[isgn]
          := PlatetemplateArray[templatenumber].PageNumberingFrontHalfWeb[isgn];
      end;
      For isgn := 1 to NupCol do
      begin
        AktPRODUCTION.aSections[isec].aFlats[iflat].aHalfwebSignaturePages
          [isgn + NupCol] := PlatetemplateArray[templatenumber]
          .PageNumberingBackHalfWeb[isgn];
      end;
    End;
  end;

  IF doImposecalc then
    result := true
  else
    result := false;

  IF resethw then
  begin

    For isec := 1 to AktPRODUCTION.nSectionsInProduction do
    begin
      planpagenames[isec].hw1 :=
        (AktPRODUCTION.aSections[isec].nPagesInSection DIV Nup) - 1;
      IF planpagenames[isec].hw1 < 0 then
        planpagenames[isec].hw1 := AktPRODUCTION.aSections[isec]
          .nPagesInSection DIV Nup;

      AktPRODUCTION.aSections[isec].Nhalfwebpage := planpagenames[isec].hw1;
      AktPRODUCTION.aSections[isec].nHalfWebPage2 := 0;

    End;

    IF doImposecalc then
      result := true
    else
      result := false;

  end;

  For isec := 1 to AktPRODUCTION.nSectionsInProduction do
  begin
    For iflat := 1 to AktPRODUCTION.aSections[isec].nFlatsInSection do
    begin

      For isgn := 1 to Nup do
      Begin
        IF AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages[isgn] = 0
        then
        begin
          Inc(planpagenames[isec].Nhalfwebpage);
        end;
      End;

      For isgn := 1 to Nup do
      Begin
        IF AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages
          [isgn + Nup] = 0 then
        begin
          Inc(planpagenames[isec].Nhalfwebpage);
        end;
      End;
    End;
  End;
  formmain.planlogging('doreimposecalc end');
  I := 1;
  sleep(1 * 10);
End;



// Iplf : plateframe (run)
// Ipl : Plate number in run

// Mouseoverip (global) : page number under mouse
procedure TFormprodplan.Sethwonplanpages(iplf: Integer; ipl: Integer);
Var
  ip, ipl2: Integer;
  lPag: Integer;
  Paginaoffset: Integer;
  Paginahighest: Integer;
  numberofpagesinrun: Integer;
  Nup: Integer;
  SelectedPagename: string;
Begin
  { achange }
  Paginaoffset := 99999;
  Paginahighest := 0;
  Nup := 1;
  For ipl2 := 0 to plateframes[iplf].NProdPlates do
  begin
    Nup := PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl]
      .templatelistid].NupOnplate;

    // Find lowest pagination (offset)
    for ip := 1 to Nup do
    begin
      if (Paginaoffset > plateframesdata[iplf].ProdPlates[ipl2].Pages[ip]
        .pagina) and (plateframesdata[iplf].ProdPlates[ipl2].Pages[ip]
        .pagina > 0) then
        Paginaoffset := plateframesdata[iplf].ProdPlates[ipl2].Pages[ip].pagina;

      if (Paginahighest < plateframesdata[iplf].ProdPlates[ipl2].Pages[ip]
        .pagina) and (plateframesdata[iplf].ProdPlates[ipl2].Pages[ip]
        .pagina > 0) then
        Paginahighest := plateframesdata[iplf].ProdPlates[ipl2].Pages
          [ip].pagina;

    End;
  End;

  if (Prefs.PlanningAllowManualHalfWebOverride) then
  begin
    planpagenames[iplf].hw1 := 0;
    planpagenames[iplf].hw2 := 0;
    planpagenames[iplf].Nhalfwebpage := 0;
    numberofpagesinrun := Paginahighest - Paginaoffset + 1;
    FormSelectHalfwebPage.RadioGroupPages.items.clear;
    for ip := 1 to Nup do
    // PlatetemplateArray[plateframesdata[iplf].prodplates[ipl].templatelistid].NupOnplate do
    begin
      if (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype <> 3) and
        (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagina <
        (numberofpagesinrun div 2)) then

        FormSelectHalfwebPage.RadioGroupPages.items.add
          (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename);
    end;

    // FormSelectHalfwebPage shows pagename - halfweb setting needs pagina - go find..
    if (FormSelectHalfwebPage.ShowModal = mrok) then
    begin
      SelectedPagename := FormSelectHalfwebPage.RadioGroupPages.items
        [FormSelectHalfwebPage.RadioGroupPages.ItemIndex];
      for ip := 1 to Nup do
        if plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename = SelectedPagename
        then
        begin
          planpagenames[iplf].hw1 :=
            (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagina -
            Paginaoffset) + 1;
          break;
        end;
    end
    else
      exit;

    (* for ip := 1 to NUp do //PlatetemplateArray[plateframesdata[iplf].prodplates[ipl].templatelistid].NupOnplate do
      begin
      IF plateframesdata[iplf].prodplates[ipl].Pages[ip].pagetype <> 3 then
      begin                                                                                         {achange}
      planpagenames[Iplf].hw1 := (plateframesdata[iplf].prodplates[ipl].Pages[Mouseoverip].Pagina-Paginaoffset)+1;
      end;
      End; *)
  end
  else
  begin // g�r efter den laveste
    lPag := 99999;

    planpagenames[iplf].hw1 := 0;
    planpagenames[iplf].hw2 := 0;
    planpagenames[iplf].Nhalfwebpage := 0;

    for ip := 1 to Nup do
    // PlatetemplateArray[plateframesdata[iplf].prodplates[ipl].templatelistid].NupOnplate do
    begin
      IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype <> 3 then
      begin

        IF lPag > plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagina then
          lPag := plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagina;
      end;
    End; { achange }
    planpagenames[iplf].hw1 := (lPag - Paginaoffset) + 1;
  end;
end;

procedure TFormprodplan.ActionhalfwebExecute(Sender: TObject);
Begin
  try
    SetHalfweb;
  Except
  end;
end;

Function TFormprodplan.makeprodImagesize(PageRotation: TPageNumbering;
  Inputorientation: Integer; phorz: Integer; pvert: Integer;
  Var platewidth: Integer; Var plateheight: Integer; Var pagewidth: Integer;
  Var pageheight: Integer): TRect;
Var

  VImposmw, VImpospw: Integer;
  VImposmh, VImposph: Integer;
  Standing: Boolean;
Begin
  try
    Standing := true;
    if ((PageRotation[1]) mod 2 = 0) then
    begin
      // siderne skal st� op
      IF Inputorientation mod 2 = 0 then
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
      IF Inputorientation mod 2 = 0 then
      begin
        Standing := false;
      End
      Else
      begin
        Standing := true;
      end;
    end;

    IF Standing then
    begin
      Impospw := (ProdImpospw100 * Pressviewzoom) div 100;
      Imposph := (ProdImposph100 * Pressviewzoom) div 100;
      Imposmw := (ProdImposmw100 * Pressviewzoom) div 100;
      Imposmh := (ProdImposmh100 * Pressviewzoom) div 100;
    end
    else
    begin
      Imposph := (ProdImpospw100 * Pressviewzoom) div 100;
      Impospw := (ProdImposph100 * Pressviewzoom) div 100;
      Imposmh := (ProdImposmw100 * Pressviewzoom) div 100;
      Imposmw := (ProdImposmh100 * Pressviewzoom) div 100;
    end;

    VImposmw := Imposmw;
    VImpospw := Impospw;
    VImposmh := Imposmh;
    VImposph := Imposph;

    platewidth := (phorz * VImpospw) + ((phorz + 1) * VImposmw);
    plateheight := (pvert * VImposph) + ((pvert + 1) * VImposmh);

    plateheight := plateheight + 20;

    result := Rect(0, 0, platewidth, plateheight);
  except
  end;
End;

Function TFormprodplan.makeprodviewimage(iplf: Integer;
  Var drawImageListplates: TImageList; var drawPBExListview: TPBExListview;
  showthumbnails: Boolean; small: Boolean; showinkpreview: Boolean;
  platenumber: Integer; plateipl: Integer; highresip: Integer;
  Numberofcopies: Integer): Integer; // 0 error 1 ok 2 ok dontproduce
Var
  aktpagetypes: TPageNumbering;
  plateprect: TRect;
  bartopoffset, platew, plateh, pagew, pageh: Integer;
  ci, si, sibar: tbitmap;
  ip, Ncolors, Icolor: Integer;
  tmpl: TPlatetemplate;
  T: string;
  w, h, tw: Integer;
  dest, source: TRect;
  d, S, destd, sourced, thumbrect, dbarrect: TRect;
  r6040, sd, r1616, r1210, r2010, sirect, Rinactive: TRect;

  y, pt, pl, X: Integer;
  tmpImage, tmpplim: tbitmap;
  platenametext: string;

  Paginatext: string;
  platenametextwidth, plpos, ap: Integer;

  Paginatextwidth, Pagplpos, Pagap: Integer;

  secnametext: string;
  secnametextwidth, secpos: Integer;
  I, porient, PageRotation: Integer;
  isleft, isup: Boolean;

  ncolorsW, barheight, barwidth: Integer;
  cw, ch: Integer;
  ImptextY: Integer;

  Thumbok: Boolean;
  pageindextext: String;

  pagestatus: array [1 .. 64] of record proofed: Boolean;
  status: Integer;
  approved: Integer;
  Uniquepage: Integer;
end;
Plate:
Tprodplate;
ic:
Integer;
NEWLINE:
Boolean;

PlanStyleview:
Boolean;

Cleft, ctop: Integer;

Apagewidth:
Integer;

fwidth:
Integer;
PageRotationList:
TPageNumbering;
Begin
  y := 0;

  if highresip < 0 then
    result := 0;
  ci := tbitmap.Create;
  si := tbitmap.Create;
  sibar := tbitmap.Create;
  tmpImage := tbitmap.Create;
  tmpplim := tbitmap.Create;

  // plateviewimage := tbitmap.Create;

  try

    r1616.Top := 0;
    r1616.left := 0;
    r1616.Bottom := 16;
    r1616.Right := 16;

    r6040.Top := 0;
    r6040.left := 0;
    r6040.Bottom := 40;
    r6040.Right := 60;

    r2010.Top := 0;
    r2010.left := 0;
    r2010.Bottom := 10;
    r2010.Right := 20;

    r1210.Top := 0;
    r1210.left := 0;
    r1210.Bottom := 12;
    r1210.Right := 10;

    Plate := plateframesdata[iplf].ProdPlates[plateipl];
    // drawprodplates[plateipl];
    (*
      IF Prefs.AllowSelectionOfAnyLayout then
      tmpl := PlatetemplateArray[plateframesdata[iplf].prodplates[0].templatelistid]
      else;
    *)
    tmpl := PlatetemplateArray[Plate.templatelistid];

    // ## NAN 20150206
    for ip := 1 to tmpl.NupOnplate do
    begin
      if Plate.Front = 0 then
        PageRotationList[ip] := tmpl.PageRotationList[ip]
      else
        PageRotationList[ip] := tmpl.PageRotationBackList[ip];

      if Plate.Pages[ip].PageRotation > 0 then
        PageRotationList[ip] := Plate.Pages[ip].PageRotation - 1;
    end;

    ci.Width := 18;
    ci.Height := 18;

    sibar.Width := 20;
    sibar.Height := 10;

    si.Width := 60;
    si.Height := 40;

    tmpImage.Width := 13; // 204
    tmpImage.Height := 13; // 176

    tmpplim.Width := 16;
    tmpplim.Height := 16;

    plateprect := makeprodImagesize(PageRotationList, // tmpl.PageRotationList,
      tmpl.IncomingPageRotationEven, tmpl.PagesAcross, tmpl.PagesDown, platew,
      plateh, pagew, pageh);

    if (plateviewimage.Width <> platew) or (plateviewimage.Height <> plateh)
    then
    Begin
      plateviewimage.Width := platew; // 204
      plateviewimage.Height := plateh; // 176
      drawImageListplates.clear;
      drawImageListplates.Height := plateviewimage.Height;
      drawImageListplates.Width := plateviewimage.Width;
    End;

    w := 0;
    h := 1;

    for ip := 1 to tmpl.NupOnplate do
    begin
      Inc(w);
      if w > tmpl.PagesAcross then
      begin
        Inc(h);
        w := 1;
      end;
      Plate.Pages[ip].Position.left := (Imposmw * w) + ((w - 1) * Impospw);
      Plate.Pages[ip].Position.Top := (Imposmh * h) + (h - 1) * Imposph;
      Plate.Pages[ip].Position.Right := (Imposmw * w) + (w * Impospw);
      Plate.Pages[ip].Position.Bottom := (Imposmh * h) + (h * Imposph);
      // plate.NUniquepages

    End;

    IF (Plate.NUniquepages = 0) and (Plate.produce) then
    begin
      for ip := 1 to tmpl.NupOnplate do
      begin
        IF Plate.Pages[ip].totUniquePage > 0 then
          Inc(Plate.NUniquepages);

      End;
      IF Plate.NUniquepages = 0 then
        Plate.produce := false;
    end;

    IF Plate.produce then
    Begin
      plateviewimage.Canvas.StretchDraw(plateprect,
        FormImage.Imageplatebrg.Picture.Bitmap);
    end
    else
    Begin
      plateviewimage.Canvas.StretchDraw(plateprect,
        FormImage.ImageDontprodplate.Picture.Bitmap);
    end;

    w := 0;
    h := 1;
    for ip := 1 to tmpl.NupOnplate do
    begin
      Inc(w);
      if w > tmpl.PagesAcross then
      begin
        Inc(h);
        w := 1;
      end;

      IF Plate.Pages[ip].pagetype = 1 then
      Begin
        for ap := 1 to tmpl.NupOnplate do
        Begin
          aktpagetypes[ap] := Plate.Pages[ip].pagetype;
        end;

        ap := formmain.Supergetantipos(ip, aktpagetypes,
          Plate.templatelistid, false);
        if ap <> -1 then
        begin
          if Plate.Pages[ip].Position.left > Plate.Pages[ap].Position.left then
            Plate.Pages[ip].Position.left := Plate.Pages[ap].Position.left;

          if Plate.Pages[ip].Position.Right < Plate.Pages[ap].Position.Right
          then
            Plate.Pages[ip].Position.Right := Plate.Pages[ap].Position.Right;

          if Plate.Pages[ip].Position.Top > Plate.Pages[ap].Position.Top then
            Plate.Pages[ip].Position.Top := Plate.Pages[ap].Position.Top;

          if Plate.Pages[ip].Position.Bottom < Plate.Pages[ap].Position.Bottom
          then
            Plate.Pages[ip].Position.Bottom := Plate.Pages[ap].Position.Bottom;
        End;
      End;
      plateframesdata[iplf].ProdPlates[plateipl].Pages[ip].Position.left :=
        Plate.Pages[ip].Position.left;
      plateframesdata[iplf].ProdPlates[plateipl].Pages[ip].Position.Top :=
        Plate.Pages[ip].Position.Top;
      plateframesdata[iplf].ProdPlates[plateipl].Pages[ip].Position.Right :=
        Plate.Pages[ip].Position.Right;
      plateframesdata[iplf].ProdPlates[plateipl].Pages[ip].Position.Bottom :=
        Plate.Pages[ip].Position.Bottom;
    End;

    Apagewidth := Plate.Pages[1].Position.Right - Plate.Pages[1].Position.left;

    w := 0;
    h := 1;
    for ip := 1 to tmpl.NupOnplate do
    begin
      Inc(w);
      if w > tmpl.PagesAcross then
      begin
        Inc(h);
        w := 1;
      end;
      plateviewimage.Canvas.Brush.Color := clwhite;
      plateviewimage.Canvas.pen.Color := clblack;
      IF (Plate.Pages[ip].pagetype <> 3) And (Plate.Pages[ip].pagetype <> 2)
      then
      Begin
        IF Plate.Pages[ip].totUniquePage <> 1 then
        begin
          IF highresip = -1 then
          begin
            plateviewimage.Canvas.StretchDraw(Plate.Pages[ip].Position,
              FormImage.ImagepageCommon.Picture.Bitmap);
          end
          Else
          begin
            if (Mouseoveripl = plateipl) and (highresip = ip) then
            begin

              plateviewimage.Canvas.StretchDraw(Plate.Pages[ip].Position,
                FormImage.ImagepageCommonsel.Picture.Bitmap);
            end
            else
              plateviewimage.Canvas.StretchDraw(Plate.Pages[ip].Position,
                FormImage.ImagepageCommon.Picture.Bitmap);
          End;
        end
        else
        begin
          IF highresip = -1 then
          begin
            plateviewimage.Canvas.StretchDraw(Plate.Pages[ip].Position,
              FormImage.Imagepagebrg.Picture.Bitmap);
          end
          Else
          begin

            if (Mouseoveripl = plateipl) and (highresip = ip) then
            begin
              plateviewimage.Canvas.StretchDraw(Plate.Pages[ip].Position,
                FormImage.Imagepagebrgsel.Picture.Bitmap);
            End
            else
            begin
              plateviewimage.Canvas.StretchDraw(Plate.Pages[ip].Position,
                FormImage.Imagepagebrg.Picture.Bitmap);
            end;
          End;
        end;
      End;

      // IF plate.Front = 0 then
      // PageRotation := tmpl.PageRotationList[ip]
      // else
      // PageRotation := tmpl.PageRotationBackList[ip];
      PageRotation := PageRotationList[ip];

      pt := (Imposmh * h) + (h - 1) * Imposph;

      pl := (Imposmw * w) + ((w - 1) * Impospw);

      // pl := (Imposmw*w)+ ((w-1)*Impospw);           dsds
      // plate.pages[ip].position

      pl := Plate.Pages[ip].Position.left;
      pt := Plate.Pages[ip].Position.Top;

      plateviewimage.Canvas.Brush.Style := bsClear;
      plateviewimage.Canvas.Font := FormImage.Labelplatetext.Font;
      Paginatext := inttostr(Plate.Pages[ip].pagina);
      pageindextext := inttostr(Plate.Pages[ip].Pageindex);
      IF CheckBoxsmallimagesinEdit.checked then
      Begin
        platenametextFontStyle := [];
      End
      else
      Begin
        platenametextFontStyle := [fsBold];

      End;

      plateviewimage.Canvas.Font.Height := -16;

      platenametext := makeApagetext(Plate.Pages[ip].pagename,
        Plate.Pages[ip].Pageindex, Plate.Pages[ip].pagina);

      plateviewimage.Canvas.Font.Style := platenametextFontStyle;

      IF (CheckBoxsmallimagesinEdit.checked) or
        (plateviewimage.Canvas.TextWidth(platenametext) > Impospw) then
      Begin
        platenametextFontStyle := [];
      end
      else
      Begin
        platenametextFontStyle := [fsBold];
      End;

      plateviewimage.Canvas.Font.Style := [];
      // plateviewimage.Canvas.Font.height := -4;
      plateviewimage.Canvas.Font.Height := -12;

      platenametextwidth := plateviewimage.Canvas.TextWidth(platenametext);
      Paginatextwidth := plateviewimage.Canvas.TextWidth(Paginatext);

      // ABC
      plpos := (Impospw - platenametextwidth) div 2;
      Pagplpos := (Impospw - Paginatextwidth) div 2;

      plateviewimage.Canvas.Font.Style := [];
      plateviewimage.Canvas.Font.Height := -12;
      // secnametext := tnames1.sectionIDtoname(plate.pages[ip].SectionID);
      secnametext := ' ';

      for I := 0 to length(Prefs.PlateText) - 1 do
      begin
        if Prefs.PlateText[I].Enabled then
        Begin
          IF secnametext <> ' ' then
            secnametext := secnametext + ',';
          IF Prefs.PlateText[I].name = 'Common edition' then
          begin
            secnametext := secnametext + tnames1.editionIDtoname
              (Plate.Pages[ip].Orgeditionid);
          end;
          IF Prefs.PlateText[I].name = 'Section' then
          begin
            secnametext := secnametext + tnames1.sectionIDtoname
              (Plate.Pages[ip].sectionid);
          end;
          (* IF Prefs.PlateText[i].Name = 'Alt pagename' then
            begin
            secnametext := secnametext + plate.pages[ip].Altpagename;
            end; *)
        end;
      end;

      secnametextwidth := plateviewimage.Canvas.TextWidth(secnametext);
      secpos := (Impospw - secnametextwidth) div 2;
      secpos := secpos - 3; // ToDo Denne er jeg ikke stolt af!

      IF Not small then
        ImptextY := (Imposph div 2)
      Else
        ImptextY := (Imposph div 4);

      IF (Plate.Pages[ip].pagetype <> 3) And (Plate.Pages[ip].pagetype <> 2)
      then
      Begin
        Case Plate.Pages[ip].pagetype of
          0 .. 1:
            begin
              y := pt + ImptextY - FormImage.Labelplatetext.Height;
              y := y - 6;

              // plateviewimage.Canvas.Font.Style := [fsBold];

              plateviewimage.Canvas.Font.Style := platenametextFontStyle;
              plateviewimage.Canvas.Font.Height := -16;

              plateviewimage.Canvas.Font.Style := [];
              // plateviewimage.Canvas.Font.height := -4;
              plateviewimage.Canvas.Font.Height := -12;

              FormImage.Labelplatetext.Font := plateviewimage.Canvas.Font;
              if (Prefs.ShowDataOnPlateThumbnails) and (Thumbok) and
                (showthumbnails) then
              begin
                plateviewimage.Canvas.pen.Color := clwhite;
                plateviewimage.Canvas.Brush.Color := clwhite;
              end;
              y := Plate.Pages[ip].Position.Top;

              plateviewimage.Canvas.TextOut(pl + plpos, y, platenametext);

              Inc(y, FormImage.Labelplatetext.Height);
              IF small then
                Dec(y, 4);
              plateviewimage.Canvas.Font.Style := [];
              plateviewimage.Canvas.Font.Height := -12;

              plateviewimage.Canvas.TextOut(pl + secpos, y, secnametext);
              FormImage.Labelplatetext.Font := plateviewimage.Canvas.Font;
              Inc(y, FormImage.Labelplatetext.Height);

            end;
          3:
            Begin
              plateviewimage.Canvas.Font.Color := clwhite;
              y := pt + ImptextY - FormImage.Labelplatetext.Height;
              plateviewimage.Canvas.TextOut(pl + plpos, y,
                Plate.Pages[ip].pagename);
            end;
        else
          begin // den b�r ikke komme her til
          end;

        end;
      End
      else
      begin
      end;

      plateviewimage.Canvas.Font.Style := [fsBold];
      plateviewimage.Canvas.Font.Height := -12;

      IF (Not small) then
      begin
        IF (Plate.Pages[ip].pagetype <> 2) and (Plate.Pages[ip].pagetype <> 3)
          and (Plate.Pages[ip].pagetype <> -1) then
        Begin
          Ncolors := Plate.Pages[ip].Ncolors;
          barwidth := Plate.Pages[ip].Position.Right - Plate.Pages[ip]
            .Position.left;
          barwidth := barwidth - 4;
          IF barwidth > Ncolors * 12 then
            barwidth := Ncolors * 12;
          if Ncolors = 0 then
            Ncolors := 1;
          cw := barwidth div Ncolors;
          Cleft := ((Plate.Pages[ip].Position.Right - Plate.Pages[ip]
            .Position.left) - barwidth) div 2;

          Cleft := Cleft + Plate.Pages[ip].Position.left;
          ci.Canvas.CopyMode := cmSrcAnd;
          Icolor := 0;
          d.Top := 0;
          d.left := 0;
          d.Right := cw - 1;
          d.Bottom := cw - 1;

          S := d;
          X := 0;
          NEWLINE := false;

          sibar.Width := cw;
          sibar.Height := cw;
          sirect.Top := 0;
          sirect.left := 0;
          sirect.Right := cw - 1;
          sirect.Bottom := cw - 1;

          For ic := 1 to Plate.Pages[ip].Ncolors do
          begin
            sibar.Canvas.Brush.Color :=
              Colorsnames[Plate.Pages[ip].colors[ic].ColorID].Colorlook;
            sibar.Canvas.pen.Color :=
              Colorsnames[Plate.Pages[ip].colors[ic].ColorID].Colorlook;
            IF Colorsnames[Plate.Pages[ip].colors[ic].ColorID].K = 100 then
            Begin
              sibar.Canvas.Rectangle(0, 0, cw - 1, cw - 1);
              sibar.Canvas.CopyMode := cmSrccopy;
              IF (Plate.Pages[ip].colors[ic].ColorID >= dbcoloroffset) and
                (false) then
                sibar.Canvas.StretchDraw(sirect,
                  FormImage.Image1616KDB.Picture.Bitmap)
              else
                sibar.Canvas.StretchDraw(sirect,
                  FormImage.Image1616K.Picture.Bitmap);
            End
            else
            begin
              IF (Plate.Pages[ip].colors[ic].ColorID >= dbcoloroffset) and
                (false) then
              Begin
                sibar.Canvas.Brush.Color := clwhite;
                sibar.Canvas.pen.Color := clwhite;
                sibar.Canvas.Rectangle(0, 0, cw - 1, (cw div 2));

                sibar.Canvas.Brush.Color :=
                  Colorsnames[Plate.Pages[ip].colors[ic].ColorID].Colorlook;
                sibar.Canvas.pen.Color :=
                  Colorsnames[Plate.Pages[ip].colors[ic].ColorID].Colorlook;
                sibar.Canvas.Rectangle(0, (cw div 2), cw - 1, cw - 1);
              End
              Else
                sibar.Canvas.Rectangle(0, 0, cw - 1, cw - 1);

              sibar.Canvas.CopyMode := cmSrcAnd;
              sibar.Canvas.StretchDraw(sirect,
                FormImage.Image1616w.Picture.Bitmap);
            end;

            d.Top := y + 1;
            d.left := Cleft + ((ic - 1) * cw);
            d.Bottom := d.Top + 12;
            d.Right := d.left + cw;

            if Plate.Pages[ip].colors[ic].active = 0 then
            Begin
              IF cw < 8 then
              begin
                Rinactive := sirect;
              end
              else
              begin
                Rinactive.Top := sirect.Top + 2;
                Rinactive.left := sirect.left + 2;
                Rinactive.Bottom := sirect.Bottom - 2;
                Rinactive.Right := sirect.Right - 2;
              End;
              sibar.Canvas.CopyMode := cmSrccopy;
              sibar.Canvas.StretchDraw(Rinactive,
                FormImage.Imagenotactive.Picture.Bitmap);
            End;

            plateviewimage.Canvas.CopyMode := cmSrccopy;
            plateviewimage.Canvas.CopyRect(d, sibar.Canvas, sirect);

            // plateviewimage.Canvas.Rectangle(d);

            Inc(Icolor);
          end;

        End;
        // plateviewimage.Canvas.Brush.Style := bssolid;
      end;

      porient := 0;
      Case PageRotation of
        0:
          Begin
            IF ip mod 2 = 1 then
              porient := 1
            Else
              porient := 2;
          end;
        1:
          begin
            IF h mod 2 = 1 then
              porient := 2
            else
              porient := 3;
          end;
        2:
          Begin
            IF ip mod 2 = 1 then
              porient := 4
            Else
              porient := 3;
          end;
        3:
          begin
            IF h mod 2 = 1 then
              porient := 1
            else
              porient := 4;
          end;
      end;

      IF (Plate.Pages[ip].pagetype <> 3) and (Plate.Pages[ip].pagetype <> 2)
      then
      Begin
        Case porient of
          1:
            begin // top left
              sourced.Top := 0;
              sourced.left := 0;
              sourced.Right := 12;
              sourced.Bottom := 12;
              FormImage.ImageListdonk.GetBitmap(2, tmpImage);
              destd := Plate.Pages[ip].Position;
              destd.Right := destd.left + 12;
              destd.Bottom := destd.Top + 12;
              plateviewimage.Canvas.CopyRect(destd, tmpImage.Canvas, sourced);
            end;

          2:
            begin // top right
              sourced.Top := 0;
              sourced.left := 0;
              sourced.Right := 12;
              sourced.Bottom := 12;
              FormImage.ImageListdonk.GetBitmap(0, tmpImage);

              destd := Plate.Pages[ip].Position;
              destd.left := destd.Right - 12;

              // destd.Right := destd.left + 12;
              destd.Bottom := destd.Top + 12;
              plateviewimage.Canvas.CopyRect(destd, tmpImage.Canvas, sourced);
            end;
          3:
            begin // bottom right
              sourced.Top := 0;
              sourced.left := 0;
              sourced.Right := 12;
              sourced.Bottom := 12;
              FormImage.ImageListdonk.GetBitmap(1, tmpImage);

              destd := Plate.Pages[ip].Position;
              destd.left := destd.Right - 12;

              // destd.Right := destd.left + 12;
              destd.Top := destd.Bottom - 12;
              plateviewimage.Canvas.CopyRect(destd, tmpImage.Canvas, sourced);
            end;
          4:
            begin // bottom left
              sourced.Top := 0;
              sourced.left := 0;
              sourced.Right := 12;
              sourced.Bottom := 12;
              FormImage.ImageListdonk.GetBitmap(3, tmpImage);

              destd := Plate.Pages[ip].Position;

              destd.Top := destd.Bottom - 12;
              destd.Right := destd.left + 12;

              plateviewimage.Canvas.CopyRect(destd, tmpImage.Canvas, sourced);
            end;

        else
          begin

          end;
        end;
      End;
    end;

    T := tmpl.templatename;
    tw := plateviewimage.Canvas.TextWidth(T);
    plateviewimage.Canvas.Brush.Style := bsClear;
    plateviewimage.Canvas.TextOut(26, plateviewimage.Height -
      FormImage.Labelplatetext.Height - 4, T);

    plateviewimage.Canvas.Brush.Style := bssolid;

    destd.Top := plateviewimage.Height - 21;
    destd.left := 2;
    destd.Bottom := destd.Top + 18;
    destd.Right := destd.left + 23;
    sourced.Top := 0;
    sourced.left := 0;
    sourced.Bottom := 18;
    sourced.Right := 23;

    plateviewimage.Canvas.CopyMode := cmSrccopy;
    plateviewimage.Canvas.CopyRect(destd,
      FormImage.ImageprodCopies.Canvas, sourced);

    plateviewimage.Canvas.Brush.Style := bsClear;
    plateviewimage.Canvas.Font.Color := clblack;

    plateviewimage.Canvas.TextOut(destd.left + 2, destd.Top + 4,
      inttostr(Numberofcopies));
    plateviewimage.Canvas.CopyMode := cmSrccopy;
    d.Top := 0;
    d.left := 0;
    d.Right := plateviewimage.Width;
    d.Bottom := plateviewimage.Height;

    if plateframesdata[iplf].ProdPlates[plateipl].produce then
      result := 1
    else
      result := 2;

  Except

  end;

  // plateviewimage.Free;
  sibar.Free;
  si.Free;
  ci.Free;

  tmpImage.Free;
  tmpplim.Free;

end;

procedure TFormprodplan.SetHalfweb;
Var
  AIPLF: Integer;
Begin
  For AIPLF := 1 to Nplateframes do
  begin
    IF (plateframes[AIPLF].Selected) and
      (plateframes[AIPLF].PBExListview1.Focused) then
    begin
      SetHWonSpecifik(AIPLF, selipl);
      break;
    End;
  End;

End;

// AIPLF : plateframe
// Aipl : Plate
procedure TFormprodplan.SetHWonSpecifik(AIPLF: Integer; Aipl: Integer);

Var
  I: Integer;
  iplf: Integer;
  Newmarkgroups: marksarray;

begin
  formmain.planlogging('SetHalfweb');

  copyplantoplanpages;
  setpressrunidstodbrunid;

  Sethwonplanpages(AIPLF, Aipl);
  setothercopies(AIPLF, Aipl);
  if doreimposecalc(plateframesdata[AIPLF].ProdPlates[Aipl].templatelistid,
    false) then
  begin
    calulatepagina;
    reimposedplantoplates(AIPLF);
    setdinkydata(1);
  end;

  applyglobdata(1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, Newmarkgroups);

  findorgedpages;
  copyplantoplanpages;

  for iplf := 1 to Nplateframes do
  begin
    IF CheckBoxsmallimagesinEdit.checked then
      Pressviewzoom := 60
    else
      Pressviewzoom := 100;

    plateviewimage.Width := 23; // 204
    plateviewimage.Height := 51; // 176

    DrawThePlates(CheckBoxsmallimagesinEdit.checked, iplf);
  end;

  formmain.planlogging('SetHalfweb end');

  I := 1;
  sleep(1 * 10);

end;

procedure TFormprodplan.ActionWizardExecute(Sender: TObject);

begin
  planningaction := 2; // 0 load,1 edit,2 create,3 copy, 4 move, 5 apply
  formmain.planlogging('ActionWizardExecute');
  Anychange := false;
  Editmode := 0;
  ActionRun.ImageIndex := 98;
  ActionRun.Caption := 'Run';

  FormSelectnewpress.Locationid := plateframeslocationid;
  IF Wizard(true) then
  begin
    Anychange := true;
  end;
  formmain.planlogging('ActionWizardExecute end');
end;

Function TFormprodplan.LoadPressPlan(Var parentBox: TScrollBox; showit: Boolean;
  small: Boolean; applying: Boolean; changeLoadedsections: Boolean): Boolean;

Var

  iplf, ipl: Integer;
  selectedPressTemplateID1: Integer;
  selectedPressTemplateID2: Integer;
  selectedPressTemplateID3: Integer;
  selectedPressTemplateID4: Integer;
  selectedPressTemplateID5: Integer;
  selectedInsert1: Boolean;
  selectedInsert2: Boolean;
  selectedInsert3: Boolean;
  selectedInsert4: Boolean;
begin
  formmain.planlogging('loadpressplan');
  selectedPressTemplateID1 := 0;
  selectedPressTemplateID2 := 0;
  selectedPressTemplateID3 := 0;
  selectedPressTemplateID4 := 0;
  selectedPressTemplateID5 := 0;
  selectedInsert1 := false;
  selectedInsert2 := false;
  selectedInsert3 := false;
  selectedInsert4 := false;
  result := false;
  try
    IF Formloadpressplan.itspartial then
    begin
    end
    else
    begin
      if (not applying) then
      Begin
        Formloadpressplan.Applytopublid := -1;
        Formloadpressplan.Applytopprodname := '';
      end;
    End;
    plateframesproductionname := '';
    Formloadpressplan.selectedpressID := plateframespressid;
    Formloadpressplan.init();

    if (Formloadpressplan.ListBoxpresstemplatename.items.count = 0) and
      (Prefs.UseMultiPressTemplateLoad = false) then
    begin
      MessageDlg(formmain.InfraLanguage1.Translate
        ('There are no press plans to select from'), mtInformation, [mbOk], 0);
      exit;
    end;

    Formloadpressplan.Sectionschanged := false;
    if showit then
    begin
      Formloadpressplan.Applingtoplan := applying;

      if (applying) and (Prefs.UseMultiPressTemplateLoad) then
      begin
        FormApplyLoadedPressTemplate.selectedpressID := plateframespressid;
        FormApplyLoadedPressTemplate.selectedPublicationID :=
          Formloadpressplan.defaultpublid;
        FormApplyLoadedPressTemplate.selectedPubDate :=
          Formloadpressplan.Applytodate;
        FormApplyLoadedPressTemplate.numberOfPages :=
          Formloadpressplan.TotalPages;
        FormApplyLoadedPressTemplate.selectedProductionID :=
          plateframesproductionid;
        if FormApplyLoadedPressTemplate.ShowModal <> mrok then
          exit;
        selectedPressTemplateID1 :=
          FormApplyLoadedPressTemplate.selectedPressTemplateID1;
        selectedPressTemplateID2 :=
          FormApplyLoadedPressTemplate.selectedPressTemplateID2;
        selectedPressTemplateID3 :=
          FormApplyLoadedPressTemplate.selectedPressTemplateID3;
        selectedPressTemplateID4 :=
          FormApplyLoadedPressTemplate.selectedPressTemplateID4;
        selectedPressTemplateID5 :=
          FormApplyLoadedPressTemplate.selectedPressTemplateID5;
        selectedInsert1 := FormApplyLoadedPressTemplate.selectedInsertMode;
        selectedInsert2 := FormApplyLoadedPressTemplate.selectedInsertMode2;
        selectedInsert3 := FormApplyLoadedPressTemplate.selectedInsertMode3;
        selectedInsert4 := FormApplyLoadedPressTemplate.selectedInsertMode4;
        Formloadpressplan.selectedplanid :=
          FormApplyLoadedPressTemplate.selectedPressTemplateID1;
        Formloadpressplan.UsingProddata := true;
        Formloadpressplan.NumberOfEditionsInProd :=
          FormApplyLoadedPressTemplate.NumberOfEditionsInProd;
      end
      else
      begin
        if Formloadpressplan.ShowModal <> mrok then
          exit;
      end;
      selectedPressTemplateID1 := Formloadpressplan.selectedplanid;
    end;

    if CheckBoxsmallimagesinEdit.checked then
      Pressviewzoom := 60
    else
      Pressviewzoom := 100;

    plateviewimage.Width := 23; // 204
    plateviewimage.Height := 51; // 176

    Nplateframes := 0;

    DataM1.Query1.sql.clear;
    DataM1.Query1.sql.add('Select distinct numberofruns from Presstemplate');
    DataM1.Query1.sql.add('where presstemplateid = ' +  inttostr(selectedPressTemplateID1));
    formmain.Tryopen(DataM1.Query1);
    if not DataM1.Query1.eof then
    Begin
      Nplateframes := DataM1.Query1.fieldbyname('numberofruns').asinteger;
    End;
    DataM1.Query1.close;

    if (selectedPressTemplateID2 > 0) then
    begin
      DataM1.Query1.sql.clear;
      DataM1.Query1.sql.add('Select distinct numberofruns from Presstemplate');
      DataM1.Query1.sql.add('where presstemplateid = ' +
        inttostr(selectedPressTemplateID2));
      formmain.Tryopen(DataM1.Query1);
      if not DataM1.Query1.eof then
      Begin
        Nplateframes := Nplateframes + DataM1.Query1.fieldbyname('numberofruns')
          .asinteger;
      End;
      DataM1.Query1.close;
    end;

    if (selectedPressTemplateID3 > 0) then
    begin
      DataM1.Query1.sql.clear;
      DataM1.Query1.sql.add('Select distinct numberofruns from Presstemplate');
      DataM1.Query1.sql.add('where presstemplateid = ' +
        inttostr(selectedPressTemplateID3));
      formmain.Tryopen(DataM1.Query1);
      if not DataM1.Query1.eof then
      Begin
        Nplateframes := Nplateframes + DataM1.Query1.fieldbyname('numberofruns')
          .asinteger;

      End;
      DataM1.Query1.close;
    end;

     if (selectedPressTemplateID4 > 0) then
    begin
      DataM1.Query1.sql.clear;
      DataM1.Query1.sql.add('Select distinct numberofruns from Presstemplate');
      DataM1.Query1.sql.add('where presstemplateid = ' +
        inttostr(selectedPressTemplateID4));
      formmain.Tryopen(DataM1.Query1);
      if not DataM1.Query1.eof then
      Begin
        Nplateframes := Nplateframes + DataM1.Query1.fieldbyname('numberofruns')
          .asinteger;

      End;
      DataM1.Query1.close;
    end;

    if (selectedPressTemplateID5 > 0) then
    begin
      DataM1.Query1.sql.clear;
      DataM1.Query1.sql.add('Select distinct numberofruns from Presstemplate');
      DataM1.Query1.sql.add('where presstemplateid = ' +
        inttostr(selectedPressTemplateID5));
      formmain.Tryopen(DataM1.Query1);
      if not DataM1.Query1.eof then
      Begin
        Nplateframes := Nplateframes + DataM1.Query1.fieldbyname('numberofruns')
          .asinteger;

      End;
      DataM1.Query1.close;
    end;

    if Formloadpressplan.UsingProddata then
    begin
      Nplateframes := Nplateframes * Formloadpressplan.NumberOfEditionsInProd;
    end;
    IF Nplateframes = 0 then
      exit;

    formmain.allocateplateframes(parentBox, Nplateframes);

    plateframesproductionname := Formloadpressplan.Editplanname.Text;

    if Editmode = PLANADDMODE_APPLY then
    begin // den bliver applyet s� den har allerede et productionnames og id
    end
    else
    begin
      plateframesproductionid := -1;
    end;

    EditProductionname.Text := plateframesproductionname;

    plateframespublicationid := tnames1.publicationnametoid(Formloadpressplan.ComboBoxPublication.Text);
    plateframesPubdate := Formloadpressplan.DateTimePicker1loadplan.Date;
    Currentcreep := Formloadpressplan.Creep;
    Loadpressplandata(selectedPressTemplateID1, selectedPressTemplateID2, selectedPressTemplateID3, selectedPressTemplateID4, selectedPressTemplateID5,
        selectedInsert1, selectedInsert2,   selectedInsert3,selectedInsert4,
        Formloadpressplan.selectedpressID, (applying) and
        (Prefs.UseMultiPressTemplateLoad), changeLoadedsections);

    if Editmode = PLANADDMODE_APPLY then
      findunplannedUniquepages;

    IF Nplateframes > 1 then
    begin
      For iplf := 2 to Nplateframes do
      begin
        For ipl := 0 to plateframes[iplf].NProdPlates do
        begin
          IF plateframesdata[iplf].ProdPlates[ipl].Presssectionnumber = 1 then
            plateframesdata[iplf].ProdPlates[ipl].Presssectionnumber := iplf;
        End;
      End;
    End;

    IF (Formloadpressplan.Sectionschanged) and (showit) then
    begin
      changesections;
    end;

    IF (Prefs.SimplePlanLoad) OR ((Formloadpressplan.Editionchanged) and
      (showit)) then
    Begin
      changeeditions;
    end;

    IF ((Formloadpressplan.Offsetchanged) or (Formprodplan.planningaction = 6))
      and (showit) then
    Begin
      changeoffset;
    end;

    Checkfornocolorpages;

    findorgedpages;
    For iplf := 1 to Nplateframes do
    Begin
      IF small then
        Pressviewzoom := 60
      else
        Pressviewzoom := 100;

      plateviewimage.Width := 23; // 204
      plateviewimage.Height := 51; // 176

      lookforcenterspread;
      DrawThePlates(small, iplf);
      plateframes[iplf].Refresh;
    End;

    Formprodplan.findorgedpages;
    pressruncaptionnames;
    FormApplyproduction.LoadSchedules;

    result := true;
    IF unplannedexists then
    begin
      MessageDlg(formmain.InfraLanguage1.Translate
        ('There are unplanned pages for this publcation - a plan must be applied from main menu'),
        mtError, [mbOk], 0);
      result := false;
    end;
  Except
  end;
  formmain.planlogging('loadpressplan end');
end;

procedure TFormprodplan.ActionLoadExecute(Sender: TObject);
begin
  addingplate := false;
  planningaction := 0; // 0 load,1 edit,2 create,3 copy, 4 move, 5 apply
  IF Anychange then
  begin
    if MessageDlg(formmain.InfraLanguage1.Translate
      ('All changes will be lost Continue?'), mtWarning, [mbYes, mbCancel], 0) = mrcancel
    then
      exit;
  end;
  Anychange := false;
  Editmode := 0;
  ActionRun.ImageIndex := 98;
  ActionRun.Caption := 'Run';
  Formloadpressplan.editionlist := '';
  Formloadpressplan.sectionlist := '';
  Formloadpressplan.Maxpages := 0;
  Formloadpressplan.defaultpublid := plateframespublicationid;

  Formloadpressplan.itspartial := false;
  Formloadpressplan.CheckBoxusecurprod.visible := false;
  Formloadpressplan.CheckBoxusecurprod.checked := false;

  loadpressplan(ScrollBoxplan, true, CheckBoxsmallimagesinEdit.checked,false, false);
  setactionenabled();
end;

Procedure TFormprodplan.possiblepressesonlocation(Locationid: Integer;
  items: TStrings);
Begin
  items.clear;
  DataM1.Query2.sql.clear;
  DataM1.Query2.sql.add('Select pressname from pressnames');
  DataM1.Query2.sql.add('where locationid = ' +
    inttostr(tnames1.locationnametoid(ComboBoxLocation.Text)));
  DataM1.Query2.sql.add('order by pressname');

  formmain.Tryopen(DataM1.Query2);
  While not DataM1.Query2.eof do
  begin
    items.add(DataM1.Query2.fields[0].asstring);
    DataM1.Query2.next;
  end;
  DataM1.Query2.close;
end;

procedure TFormprodplan.ComboBoxLocationSelect(Sender: TObject);

Var
  newlocationid: Integer;
  newpressid: Integer;
  Newtemplatelistid: Integer;
  NewNmarkgroups: Integer;
  Newmarkgroups: marksarray;

begin
  If plateframeslocationid <> tnames1.locationnametoid(ComboBoxLocation.Text)
  then
  begin
    newlocationid := tnames1.locationnametoid(ComboBoxLocation.Text);
    If SelectNewlocation(newlocationid, newpressid, Newtemplatelistid,
      NewNmarkgroups, Newmarkgroups) then
    begin
      possiblepressesonlocation(newlocationid, ComboBoxpress.items);
      ComboBoxpress.ItemIndex := ComboBoxpress.items.IndexOf
        (tnames1.pressnameIDtoname(newpressid));
      EditProductionname.Text := createproductionname
        (tnames1.publicationnametoid(ComboBoxPublication.Text),
        tnames1.pressnametoid(ComboBoxpress.Text), plateframesPubdate);

      changelocation(newlocationid, newpressid, Newtemplatelistid,
        NewNmarkgroups, Newmarkgroups);
      plateframesproductionname := EditProductionname.Text;
      Anychange := true;
    end
    else
    begin
      ComboBoxLocation.ItemIndex := ComboBoxLocation.items.IndexOf
        (tnames1.locationIDtoname(plateframeslocationid));

    end;
  end;
end;

Function TFormprodplan.changePress(newpressid: Integer): Boolean;
Var
  iplf: Integer;
  stepI, stepres: Integer;
  stepcancel: Boolean;
  Newtemplatelistid: Integer;

  NewNmarkgroups: Integer;
  Newmarkgroups: marksarray;
Begin
  stepres := 0;
  stepI := 1;
  stepcancel := false;
  Repeat
    Case stepI of
      1:
        begin
          FormSelectnewpress.Locationid := plateframeslocationid;
          stepres := FormSelectnewpress.ShowModal;
        end;
      2:
        Begin

          Formselecttemplate.Panelwizard.visible := true;
          Formselecttemplate.Panel2.visible := false;
          Formselecttemplate.Panelproof.visible := false;
          Formselecttemplate.Panel3.visible := true;
          Formselecttemplate.Panel4.visible := false;
          Formselecttemplate.Panelmovepress.visible := false;
          Formselecttemplate.Aktpressname :=
            tnames1.pressnameIDtoname(FormSelectnewpress.newpressid);
          Formselecttemplate.PagesAcross := -1;
          Formselecttemplate.PagesDown := -1;
          Formselecttemplate.Aktpressid := FormSelectnewpress.newpressid;
          Formselecttemplate.aktpublicationid := plateframespublicationid;

          stepres := Formselecttemplate.ShowModal;
          Formselecttemplate.Panel2.visible := true;
          Formselecttemplate.Panel4.visible := false;
          Formselecttemplate.Panelproof.visible := true;
          Formselecttemplate.Panelmovepress.visible := false;
        end;
    end;

    Case stepres of
      mryes:
        Inc(stepI);
      mrno:
        Dec(stepI);
      mrcancel:
        stepcancel := true;
    end;

  Until (stepI = 0) or (stepI = 3) or (stepcancel);

  IF stepI = 3 then
  begin

    plateframespressid := FormSelectnewpress.newpressid;
    Newtemplatelistid := inittypes.gettemplatenumberfromID
      (Formselecttemplate.selectedtemplateid);
    NewNmarkgroups := Formselecttemplate.Nmarkgroups;
    Newmarkgroups := Formselecttemplate.markgroups;

    possiblepressesonlocation(plateframeslocationid, ComboBoxpress.items);
    ComboBoxpress.ItemIndex := ComboBoxpress.items.IndexOf(tnames1.pressnameIDtoname(plateframespressid));
    EditProductionname.Text := createproductionname(tnames1.publicationnametoid(ComboBoxPublication.Text),
      tnames1.pressnametoid(ComboBoxpress.Text), plateframesPubdate);

    plateframesproductionid := -1;
    plateframesproductionname := EditProductionname.Text;
    // ############ DANGER ##################
    plateframesproductionid := tnames1.productionrunnametoid(EditProductionname.Text);
    // #####################################

    saveprodrundata(plateframesproductionid);

    copyplantoplanpages;
    for iplf := 1 to Nplateframes do
    begin
      planpagenames[iplf].hw1 := 0;
      planpagenames[iplf].hw2 := 0;
      planpagenames[iplf].Nhalfwebpage := 0;
    End;

    if doreimposecalc(Newtemplatelistid, true) then
    begin
      calulatepagina;
      for iplf := 1 to Nplateframes do
      begin
        reimposedplantoplates(iplf);
      end;

      applyglobdata(1, plateframesproductionid, plateframespublicationid,
        plateframeslocationid, plateframespressid, Newtemplatelistid,
        Newtemplatelistid, -1, -1, -1, NewNmarkgroups, Newmarkgroups);
      findorgedpages;
      setdinkydata(1);

      for iplf := 1 to Nplateframes do
      begin
        IF CheckBoxsmallimagesinEdit.checked then
          Pressviewzoom := 60
        else
          Pressviewzoom := 100;

        plateviewimage.Width := 23; // 204
        plateviewimage.Height := 51; // 176
        plateframes[iplf].PBExListview1.items.clear;
        plateframes[iplf].ImageListplanframe.clear;
        DrawThePlates(CheckBoxsmallimagesinEdit.checked, iplf);
      End;

      copyplantoplanpages;

    end;

  end;
  result := stepI = 3;
end;

procedure TFormprodplan.ComboBoxpressSelect(Sender: TObject);
begin
  if (plateframespressid <> tnames1.pressnametoid(ComboBoxpress.Text)) then
  begin
    if changePress(tnames1.locationnametoid(ComboBoxpress.Text)) then
    begin
      Anychange := true;
    end
    else
    begin
      ComboBoxpress.ItemIndex := ComboBoxpress.items.IndexOf
        (tnames1.pressnameIDtoname(plateframespressid));
    end;
  end;

end;

procedure TFormprodplan.DateTimePickerPubdateChange(Sender: TObject);
Var
  NewNmarkgroups: Integer;
  Newmarkgroups: marksarray;

begin
  NewNmarkgroups := -1;
  plateframesPubdate := DateTimePickerPubdate.Date;
  EditProductionname.Text := createproductionname
    (tnames1.publicationnametoid(ComboBoxPublication.Text),
    tnames1.pressnametoid(ComboBoxpress.Text), plateframesPubdate);

  plateframesproductionname := EditProductionname.Text;
  plateframesproductionid := -1;
  saveprodrundata(plateframesproductionid);

  applyglobdata(1, plateframesproductionid, plateframespublicationid,
    plateframeslocationid, plateframespressid, -1, -1, -1, -1, -1,
    NewNmarkgroups, Newmarkgroups);
  Anychange := true;

end;

procedure TFormprodplan.ComboBoxPublicationSelect(Sender: TObject);
Var
  NewNmarkgroups: Integer;
  Newmarkgroups: marksarray;

begin
  if plateframespublicationid <> tnames1.publicationnametoid
    (ComboBoxPublication.Text) then
  begin
    plateframespublicationid := tnames1.publicationnametoid
      (ComboBoxPublication.Text);
    NewNmarkgroups := -1;
    EditProductionname.Text := createproductionname
      (tnames1.publicationnametoid(ComboBoxPublication.Text),
      tnames1.pressnametoid(ComboBoxpress.Text), plateframesPubdate);

    plateframesproductionname := EditProductionname.Text;
    plateframesproductionid := tnames1.productionrunnametoid(EditProductionname.Text);
    IF plateframesproductionid = -1 then
      tnames1.Addname(9, EditProductionname.Text);
    plateframesproductionid := tnames1.productionrunnametoid(EditProductionname.Text);
    saveprodrundata(plateframesproductionid);

    applyglobdata(1, plateframesproductionid, plateframespublicationid,
      plateframeslocationid, plateframespressid, -1, -1, -1, -1, -1,
      NewNmarkgroups, Newmarkgroups);
    Anychange := true;
  end;
end;

procedure TFormprodplan.CopyPlanToPlanPages;
Var
  iplf, ipl, ip: Integer;
  hwplate: Boolean;
  Paginaoffset: Integer;
  Copynumber, Pageindex: Integer;
begin
  Nplanpagesections := 0;
  For iplf := 1 to Nplateframes do
  begin
    Paginaoffset := getpaginaoffset(iplf) - 1;
    Inc(Nplanpagesections);
    planpagenames[Nplanpagesections].newedition := true;
    planpagenames[Nplanpagesections].hw1 := 0;
    planpagenames[Nplanpagesections].hw2 := 0;
    planpagenames[Nplanpagesections].Nhalfwebpage := 0;
    planpagenames[Nplanpagesections].Npages := 0;
    planpagenames[Nplanpagesections].Numberofcopies := plateframes[iplf]
      .Numberofcopies;

    planpagenames[Nplanpagesections].collection := plateframesdata[iplf]
      .collection;
    planpagenames[Nplanpagesections].Prepaired := plateframesdata[iplf]
      .Prepaired;
    planpagenames[Nplanpagesections].bindingstyle := plateframesdata[iplf]
      .bindingstyle;

    For ipl := 0 to plateframes[iplf].NProdPlates do
    begin
      hwplate := false;
      planpagenames[Nplanpagesections].editionid := plateframesdata[iplf].ProdPlates[ipl].editionid;
      for ip := 1 to PlatetemplateArray
        [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
      begin
        Copynumber := plateframesdata[iplf].ProdPlates[ipl].Copynumber;
        IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype <> 3 then
        begin
          IF Copynumber = 1 then
            Inc(planpagenames[Nplanpagesections].Npages);

          { achange }

          Pageindex := plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagina -
            Paginaoffset;

          planpagenames[Nplanpagesections].Pages[Pageindex].Copies[Copynumber]
            .ipl := ipl;
          planpagenames[Nplanpagesections].Pages[Pageindex].Copies
            [Copynumber].ip := ip;
          // planpagenames[Nplanpagesections].pages[plateframesdata[iplf].prodplates[ipl].Pages[ip].Pagina].Ncopies := plateframesdata[iplf].prodplates[ipl].Copynumber;

          planpagenames[Nplanpagesections].Pages[Pageindex].name :=
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename;

          planpagenames[Nplanpagesections].Pages[Pageindex].pagina :=
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagina;

          planpagenames[Nplanpagesections].Pages[Pageindex].Pageindex :=
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Pageindex;
          planpagenames[Nplanpagesections].Pages[Pageindex].presssecionnumber :=
            plateframesdata[iplf].ProdPlates[ipl].Presssectionnumber;

          planpagenames[Nplanpagesections].Pages[Pageindex].Copies
            [Copynumber].ip := ip;
          planpagenames[Nplanpagesections].Pages[Pageindex].Copies[Copynumber]
            .ipl := ipl;
          planpagenames[Nplanpagesections].Pages[Pageindex].sectionid :=
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].sectionid;

          planpagenames[Nplanpagesections].Pages[Pageindex].PageRotation :=
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].PageRotation;
          planpagenames[Nplanpagesections].Pages[Pageindex].RipSetupID :=
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].RipSetupID;
        End
        else
        begin
          hwplate := true;
        end;
      end;

      IF hwplate then
      begin

        for ip := 1 to PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
        begin
          if (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype <> 3) and
             ((planpagenames[Nplanpagesections].hw1 = 0) or
              (planpagenames[Nplanpagesections].hw1 > plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagina)) then
          begin { achange }
            planpagenames[Nplanpagesections].hw1 := plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagina;
          end;
        end;

      end;
    end;
  end;

end;

Procedure TFormprodplan.ReimposedPlanToPlates(iplf: Integer);
Var
  isec, iflat, ifront, outp, sheet, isgn, ic: Integer;
  pagenode, presssection, colornode: ttreenode;
  nplates: Integer;
  T: string;
  hp: Integer;
  Nhw: Integer;
  mypagina: Integer;
  Nsheet: Integer;
  aktpressrunid: Integer;
  Bufipl, bufip, isgnback: Integer;
  ispl: Integer;
  Ncopies, icopy: Integer;

  Foundit: Boolean;

  Nprodcount, I, ipl, ip: Integer;

Begin
  // NprodplatesSize  Fixed
  Bufipl := 0;
  try
    try

      aktpressrunid := -1;
      hp := 0;
      mypagina := 0;
      nplates := 0;
      Nsheet := 0;
      sheet := 0;

      Nprodplatebuf := plateframes[iplf].NProdPlates;
      Setlength(prodplatebuf, Nprodplatebuf + 8);

      for ipl := 0 to Nprodplatebuf do
      begin
        prodplatebuf[ipl].TmpInt := plateframesdata[iplf].ProdPlates
          [ipl].TmpInt;
        prodplatebuf[ipl].Changed := plateframesdata[iplf].ProdPlates
          [ipl].Changed;
        prodplatebuf[ipl].Front := plateframesdata[iplf].ProdPlates[ipl].Front;
        prodplatebuf[ipl].TrueFront := plateframesdata[iplf].ProdPlates[ipl]
          .TrueFront;
        prodplatebuf[ipl].sheetnumber := plateframesdata[iplf].ProdPlates[ipl]
          .sheetnumber;
        prodplatebuf[ipl].FlatSeparationSet := plateframesdata[iplf].ProdPlates
          [ipl].FlatSeparationSet;
        prodplatebuf[ipl].CopyFlatSeparationSet := plateframesdata[iplf]
          .ProdPlates[ipl].CopyFlatSeparationSet;
        prodplatebuf[ipl].productionid := plateframesdata[iplf].ProdPlates[ipl]
          .productionid;
        prodplatebuf[ipl].IssueID := plateframesdata[iplf].ProdPlates
          [ipl].IssueID;
        prodplatebuf[ipl].publicationid := plateframesdata[iplf].ProdPlates[ipl]
          .publicationid;
        prodplatebuf[ipl].Copynumber := plateframesdata[iplf].ProdPlates[ipl]
          .Copynumber;
        prodplatebuf[ipl].editionid := plateframesdata[iplf].ProdPlates[ipl]
          .editionid;
        prodplatebuf[ipl].Locationid := plateframesdata[iplf].ProdPlates[ipl]
          .Locationid;
        prodplatebuf[ipl].templatelistid := plateframesdata[iplf].ProdPlates
          [ipl].templatelistid;
        prodplatebuf[ipl].deviceid := plateframesdata[iplf].ProdPlates
          [ipl].deviceid;
        prodplatebuf[ipl].Pressid := plateframesdata[iplf].ProdPlates
          [ipl].Pressid;
        prodplatebuf[ipl].runid := plateframesdata[iplf].ProdPlates[ipl].runid;
        prodplatebuf[ipl].produce := plateframesdata[iplf].ProdPlates
          [ipl].produce;
        prodplatebuf[ipl].readytoproduce := plateframesdata[iplf].ProdPlates
          [ipl].readytoproduce;
        prodplatebuf[ipl].someerror := plateframesdata[iplf].ProdPlates[ipl]
          .someerror;
        prodplatebuf[ipl].totappr := plateframesdata[iplf].ProdPlates
          [ipl].totappr;
        prodplatebuf[ipl].totstat := plateframesdata[iplf].ProdPlates
          [ipl].totstat;
        prodplatebuf[ipl].NUniquepages := plateframesdata[iplf].ProdPlates[ipl]
          .NUniquepages;
        prodplatebuf[ipl].Presssectionnumber := plateframesdata[iplf].ProdPlates
          [ipl].Presssectionnumber;
        prodplatebuf[ipl].Nmarkgroups := plateframesdata[iplf].ProdPlates[ipl]
          .Nmarkgroups;
        prodplatebuf[ipl].markgroups := plateframesdata[iplf].ProdPlates[ipl]
          .markgroups;
        for ip := 1 to 32 do
        begin
          prodplatebuf[ipl].Pages[ip].TmpInt := plateframesdata[iplf].ProdPlates
            [ipl].Pages[ip].TmpInt;
          prodplatebuf[ipl].Pages[ip].totapproval := plateframesdata[iplf]
            .ProdPlates[ipl].Pages[ip].totapproval;
          prodplatebuf[ipl].Pages[ip].Position := plateframesdata[iplf]
            .ProdPlates[ipl].Pages[ip].Position;
          prodplatebuf[ipl].Pages[ip].Anyheld := plateframesdata[iplf]
            .ProdPlates[ipl].Pages[ip].Anyheld;
          prodplatebuf[ipl].Pages[ip].totUniquePage := plateframesdata[iplf]
            .ProdPlates[ipl].Pages[ip].totUniquePage;
          prodplatebuf[ipl].Pages[ip].Antipanorama := plateframesdata[iplf]
            .ProdPlates[ipl].Pages[ip].Antipanorama; // pairpos
          prodplatebuf[ipl].Pages[ip].pagetype := plateframesdata[iplf]
            .ProdPlates[ipl].Pages[ip].pagetype;
          // set pagetype 0 norm 1 pano 2 anti 3 dummy
          prodplatebuf[ipl].Pages[ip].Creep := plateframesdata[iplf].ProdPlates
            [ipl].Pages[ip].Creep;
          prodplatebuf[ipl].Pages[ip].sectionid := plateframesdata[iplf]
            .ProdPlates[ipl].Pages[ip].sectionid;
          prodplatebuf[ipl].Pages[ip].pagename := plateframesdata[iplf]
            .ProdPlates[ipl].Pages[ip].pagename;
          prodplatebuf[ipl].Pages[ip].MasterCopySeparationSet :=
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
            .MasterCopySeparationSet;
          prodplatebuf[ipl].Pages[ip].CopySeparationSet := plateframesdata[iplf]
            .ProdPlates[ipl].Pages[ip].CopySeparationSet;
          prodplatebuf[ipl].Pages[ip].OrgCopySeparationSet :=
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
            .OrgCopySeparationSet;
          prodplatebuf[ipl].Pages[ip].SeparationSet := plateframesdata[iplf]
            .ProdPlates[ipl].Pages[ip].SeparationSet;
          prodplatebuf[ipl].Pages[ip].Ncolors := plateframesdata[iplf]
            .ProdPlates[ipl].Pages[ip].Ncolors;
          prodplatebuf[ipl].Pages[ip].pagestatus := plateframesdata[iplf]
            .ProdPlates[ipl].Pages[ip].pagestatus;
          prodplatebuf[ipl].Pages[ip].proofed := plateframesdata[iplf]
            .ProdPlates[ipl].Pages[ip].proofed;
          prodplatebuf[ipl].Pages[ip].approved := plateframesdata[iplf]
            .ProdPlates[ipl].Pages[ip].approved;
          prodplatebuf[ipl].Pages[ip].Orgeditionid := plateframesdata[iplf]
            .ProdPlates[ipl].Pages[ip].Orgeditionid;
          prodplatebuf[ipl].Pages[ip].pagina := plateframesdata[iplf].ProdPlates
            [ipl].Pages[ip].pagina;
          prodplatebuf[ipl].Pages[ip].Pageindex := plateframesdata[iplf]
            .ProdPlates[ipl].Pages[ip].Pageindex;
          prodplatebuf[ipl].Pages[ip].orgpageindex := plateframesdata[iplf]
            .ProdPlates[ipl].Pages[ip].orgpageindex;
          prodplatebuf[ipl].Pages[ip].pagechange := plateframesdata[iplf]
            .ProdPlates[ipl].Pages[ip].pagechange;
          prodplatebuf[ipl].Pages[ip].proofid := plateframesdata[iplf]
            .ProdPlates[ipl].Pages[ip].proofid;
          prodplatebuf[ipl].Pages[ip].OrgPageiplf := plateframesdata[iplf]
            .ProdPlates[ipl].Pages[ip].OrgPageiplf;
          prodplatebuf[ipl].Pages[ip].OrgPageipl := plateframesdata[iplf]
            .ProdPlates[ipl].Pages[ip].OrgPageipl;
          prodplatebuf[ipl].Pages[ip].OrgPageip := plateframesdata[iplf]
            .ProdPlates[ipl].Pages[ip].OrgPageip;
          prodplatebuf[ipl].Pages[ip].Oldrunid := plateframesdata[iplf]
            .ProdPlates[ipl].Pages[ip].Oldrunid;
          prodplatebuf[ipl].Pages[ip].PageRotation := plateframesdata[iplf]
            .ProdPlates[ipl].Pages[ip].PageRotation;
          prodplatebuf[ipl].Pages[ip].RipSetupID := plateframesdata[iplf]
            .ProdPlates[ipl].Pages[ip].RipSetupID;
          prodplatebuf[ipl].Pages[ip].PageFormatID := plateframesdata[iplf]
            .ProdPlates[ipl].Pages[ip].PageFormatID;

          for ic := 1 to 16 do
          begin

            prodplatebuf[ipl].Pages[ip].colors[ic].TmpInt :=
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].TmpInt;
            prodplatebuf[ipl].Pages[ip].colors[ic].Separation :=
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
              .Separation;
            prodplatebuf[ipl].Pages[ip].colors[ic].FlatSeparation :=
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
              .FlatSeparation;
            prodplatebuf[ipl].Pages[ip].colors[ic].Layer :=
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Layer;
            prodplatebuf[ipl].Pages[ip].colors[ic].ColorID :=
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors
              [ic].ColorID;
            prodplatebuf[ipl].Pages[ip].colors[ic].Orgeditionid :=
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
              .Orgeditionid;
            prodplatebuf[ipl].Pages[ip].colors[ic].DoubleBurned :=
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
              .DoubleBurned;
            prodplatebuf[ipl].Pages[ip].colors[ic].Copynumber :=
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
              .Copynumber;
            prodplatebuf[ipl].Pages[ip].colors[ic].Uniquepage :=
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
              .Uniquepage;
            prodplatebuf[ipl].Pages[ip].colors[ic].active :=
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].active;
            prodplatebuf[ipl].Pages[ip].colors[ic].status :=
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].status;
            prodplatebuf[ipl].Pages[ip].colors[ic].proofstatus :=
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
              .proofstatus;
            prodplatebuf[ipl].Pages[ip].colors[ic].approved :=
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors
              [ic].approved;
            prodplatebuf[ipl].Pages[ip].colors[ic].Priority :=
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors
              [ic].Priority;
            prodplatebuf[ipl].Pages[ip].colors[ic].Hold := plateframesdata[iplf]
              .ProdPlates[ipl].Pages[ip].colors[ic].Hold;
            prodplatebuf[ipl].Pages[ip].colors[ic].Foundlevel :=
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
              .Foundlevel;
            prodplatebuf[ipl].Pages[ip].colors[ic].Miscint1 :=
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors
              [ic].Miscint1;
            prodplatebuf[ipl].Pages[ip].colors[ic].Miscint2 :=
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors
              [ic].Miscint2;
            prodplatebuf[ipl].Pages[ip].colors[ic].Miscint3 :=
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors
              [ic].Miscint3;
            prodplatebuf[ipl].Pages[ip].colors[ic].Miscint4 :=
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors
              [ic].Miscint4;
            prodplatebuf[ipl].Pages[ip].colors[ic].Miscstring1 :=
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
              .Miscstring1;
            prodplatebuf[ipl].Pages[ip].colors[ic].Miscstring2 :=
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
              .Miscstring2;
            prodplatebuf[ipl].Pages[ip].colors[ic].Miscstring3 :=
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
              .Miscstring3;
            prodplatebuf[ipl].Pages[ip].colors[ic].stackpos :=
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors
              [ic].stackpos;
            prodplatebuf[ipl].Pages[ip].colors[ic].High := plateframesdata[iplf]
              .ProdPlates[ipl].Pages[ip].colors[ic].High;
            prodplatebuf[ipl].Pages[ip].colors[ic].Cylinder :=
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors
              [ic].Cylinder;
            prodplatebuf[ipl].Zone := plateframesdata[iplf].ProdPlates
              [ipl].Zone;
          end;

        end;
        prodplatebuf[ipl].Tower := plateframesdata[iplf].ProdPlates[ipl].Tower;
        prodplatebuf[ipl].OutputPriority := plateframesdata[iplf].ProdPlates
          [ipl].OutputPriority;
        prodplatebuf[ipl].FlatProofConfigurationID := plateframesdata[iplf]
          .ProdPlates[ipl].FlatProofConfigurationID;
        prodplatebuf[ipl].HardProofConfigurationID := plateframesdata[iplf]
          .ProdPlates[ipl].HardProofConfigurationID;
        prodplatebuf[ipl].isonmained := plateframesdata[iplf].ProdPlates[ipl]
          .isonmained;
        prodplatebuf[ipl].anyuniquepages := plateframesdata[iplf].ProdPlates
          [ipl].anyuniquepages;
      end;

      application.ProcessMessages;
      sleep(10);
      application.ProcessMessages;

      isec := iplf;

      plateframes[iplf].PBExListview1.items.clear;
      plateframes[iplf].ImageListplanframe.clear;

      plateframes[iplf].NProdPlates := -1;

      Numberofhalfweb := 0;
      Ncopies := 0;

      Nprodcount := (planpagenames[isec].Numberofcopies *
        AktPRODUCTION.aSections[isec].nFlatsInSection) * 2;

      IF Nplateframes > 1 then
      begin
        For I := 1 to Nplateframes do
        begin
          if I <> iplf then
          begin
            if plateframes[iplf].NProdPlates > Nprodcount then
              Nprodcount := plateframes[iplf].NProdPlates;
          end;
        end;
      end;

      formmain.Allocateprodplates(iplf, Nprodcount + 32);

      For iflat := 1 to AktPRODUCTION.aSections[isec].nFlatsInSection do
      begin
        Inc(sheet);
        Ncopies := planpagenames[isec].Numberofcopies;

        if Ncopies = 0 then
        Begin
          // beep;
          Ncopies := 1;
        End;
        Foundit := false;
        // Front front front Front front front Front front front Front front front Front front front
        For icopy := 1 to Ncopies do
        begin
          For isgn := 1 to AktPRODUCTION.aSections[isec].aFlats[iflat]
            .nPagesPerSide do
          begin
            if AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages[isgn] <> 0
            then
            begin
              for ispl := 1 to planpagenames[isec].Npages do
              begin
                if (planpagenames[isec].Pages[ispl].sectionid = planpagenames
                  [isec].Pages[AktPRODUCTION.aSections[isec].aFlats[iflat]
                  .aOutputPages[isgn]].sectionid) and
                  (planpagenames[isec].Pages[ispl].name = planpagenames[isec]
                  .Pages[AktPRODUCTION.aSections[isec].aFlats[iflat]
                  .aOutputPages[isgn]].name) then
                begin
                  Bufipl := planpagenames[isec].Pages[ispl].Copies[icopy].ipl;
                  bufip := planpagenames[isec].Pages[ispl].Copies[icopy].ip;
                  Foundit := true;
                  break;
                end;
              end;
              break;
            end
            Else
            begin
              Bufipl := 0;
            end;
          end;

          Inc(plateframes[iplf].NProdPlates);

          plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
            .sheetnumber := sheet;
          plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
            .Front := 0;
          plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
            .TrueFront := 0;
          plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
            .templatelistid := prodplatebuf[Bufipl].templatelistid;
          plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
            .Copynumber := icopy;
          plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
            .markgroups := prodplatebuf[Bufipl].markgroups;
          plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
            .Nmarkgroups := prodplatebuf[Bufipl].Nmarkgroups;
          plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
            .productionid := 0;
          plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
            .publicationid := plateframespublicationid;
          plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
            .editionid := prodplatebuf[Bufipl].editionid;
          plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
            .Locationid := plateframeslocationid;
          plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
            .deviceid := prodplatebuf[Bufipl].deviceid;
          plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
            .Pressid := plateframespressid;
          plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates].runid
            := prodplatebuf[Bufipl].runid;
          plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
            .produce := prodplatebuf[Bufipl].produce;
          plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
            .readytoproduce := false;
          plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
            .someerror := false;
          plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
            .totappr := prodplatebuf[Bufipl].totappr;
          plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
            .totstat := 0;
          // plateframesdata[iplf].prodplates[plateframes[iplf].Nprodplates].Ncopies := prodplatebuf[bufipl].Ncopies;

          For isgn := 1 to AktPRODUCTION.aSections[isec].aFlats[iflat]
            .nPagesPerSide do // front
          Begin
            bufip := -1;
            if AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages[isgn] > 0
            then
            begin
              for ispl := 1 to planpagenames[isec].Npages do
              begin
                if (planpagenames[isec].Pages[ispl].sectionid = planpagenames
                  [isec].Pages[AktPRODUCTION.aSections[isec].aFlats[iflat]
                  .aOutputPages[isgn]].sectionid) and
                  (planpagenames[isec].Pages[ispl].name = planpagenames[isec]
                  .Pages[AktPRODUCTION.aSections[isec].aFlats[iflat]
                  .aOutputPages[isgn]].name) then
                begin
                  Bufipl := planpagenames[isec].Pages[ispl].Copies[icopy].ipl;
                  bufip := planpagenames[isec].Pages[ispl].Copies[icopy].ip;
                end;
              end;
              if Bufipl < 0 then
              begin

              end;
            End;
            IF AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages[isgn] = 0
            then
            begin
              Inc(Numberofhalfweb);
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].pagetype := 3;
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].pagename := 'Dinkey' +
                inttostr((iplf * 100) + Numberofhalfweb);
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].Ncolors := 1;
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].Oldrunid := -1;
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].PageRotation := 0;
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].PageFormatID := 0;
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].RipSetupID := 0;
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].colors[1].ColorID := 6;
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].colors[1].Copynumber := icopy;
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].colors[1].Uniquepage := 1;
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].colors[1].active := 0;
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].colors[1].status := 0;
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].colors[1].proofstatus := 0;
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].colors[1].Priority := 50;
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].colors[1].Hold := 0;
            end
            else
            Begin
              Wiplf := iplf;
              Wipl := isgn;
              Wip := bufip;
              Wop := AktPRODUCTION.aSections[isec].aFlats[iflat]
                .aOutputPages[isgn];

              bufip := planpagenames[isec].Pages
                [AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages[isgn]]
                .Copies[icopy].ip;

              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Presssectionnumber := planpagenames[isec].Pages
                [AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages[isgn]]
                .presssecionnumber;

              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].pagename := planpagenames[isec].Pages
                [AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages
                [isgn]].name;

              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].pagina := planpagenames[isec].Pages
                [AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages
                [isgn]].pagina;

              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].Pageindex := planpagenames[isec].Pages
                [AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages[isgn]]
                .Pageindex;

              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].sectionid := planpagenames[isec].Pages
                [AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages[isgn]]
                .sectionid;
              try

                plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                  .Pages[isgn].Oldrunid := prodplatebuf[Bufipl].Pages
                  [bufip].Oldrunid;
                plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                  .Pages[isgn].totapproval := prodplatebuf[Bufipl].Pages[bufip]
                  .totapproval;
                plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                  .Pages[isgn].Anyheld := prodplatebuf[Bufipl].Pages
                  [bufip].Anyheld;
                plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                  .Pages[isgn].Antipanorama := prodplatebuf[Bufipl].Pages[bufip]
                  .Antipanorama;
                plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                  .Pages[isgn].pagetype := prodplatebuf[Bufipl].Pages
                  [bufip].pagetype;
                plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                  .Pages[isgn].Ncolors := prodplatebuf[Bufipl].Pages
                  [bufip].Ncolors;
                plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                  .Pages[isgn].proofid := prodplatebuf[Bufipl].Pages
                  [bufip].proofid;
                plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                  .Pages[isgn].Creep := AktPRODUCTION.aSections[isec].aFlats
                  [iflat].aCreep[isgn];
                plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                  .Pages[isgn].Ncolors := prodplatebuf[Bufipl].Pages
                  [bufip].Ncolors;
                plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                  .Pages[isgn].pagestatus := prodplatebuf[Bufipl].Pages[bufip]
                  .pagestatus;
                plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                  .Pages[isgn].proofed := prodplatebuf[Bufipl].Pages
                  [bufip].proofed;
                plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                  .Pages[isgn].approved := prodplatebuf[Bufipl].Pages
                  [bufip].approved;
                plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                  .Pages[isgn].pagechange := false;
                plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                  .Pages[isgn].Orgeditionid := prodplatebuf[Bufipl].Pages[bufip]
                  .Orgeditionid;
                plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                  .Pages[isgn].totUniquePage := prodplatebuf[Bufipl].Pages
                  [bufip].totUniquePage;

                plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                  .Pages[isgn].PageFormatID := prodplatebuf[Bufipl].Pages[bufip]
                  .PageFormatID;
                plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                  .Pages[isgn].RipSetupID := prodplatebuf[Bufipl].Pages[bufip]
                  .RipSetupID;
                plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                  .Pages[isgn].PageRotation := prodplatebuf[Bufipl].Pages[bufip]
                  .PageRotation;

                For ic := 1 to plateframesdata[iplf].ProdPlates
                  [plateframes[iplf].NProdPlates].Pages[isgn].Ncolors do
                begin
                  plateframesdata[iplf].ProdPlates
                    [plateframes[iplf].NProdPlates].Pages[isgn].colors[ic]
                    .ColorID := prodplatebuf[Bufipl].Pages[bufip].colors
                    [ic].ColorID;
                  plateframesdata[iplf].ProdPlates
                    [plateframes[iplf].NProdPlates].Pages[isgn].colors[ic]
                    .Copynumber := icopy;
                  plateframesdata[iplf].ProdPlates
                    [plateframes[iplf].NProdPlates].Pages[isgn].colors[ic]
                    .Uniquepage := prodplatebuf[Bufipl].Pages[bufip]
                    .totUniquePage;
                  plateframesdata[iplf].ProdPlates
                    [plateframes[iplf].NProdPlates].Pages[isgn].colors[ic]
                    .active := prodplatebuf[Bufipl].Pages[bufip].colors
                    [ic].active;
                  plateframesdata[iplf].ProdPlates
                    [plateframes[iplf].NProdPlates].Pages[isgn].colors[ic]
                    .status := prodplatebuf[Bufipl].Pages[bufip].colors
                    [ic].status;
                  plateframesdata[iplf].ProdPlates
                    [plateframes[iplf].NProdPlates].Pages[isgn].colors[ic]
                    .proofstatus := prodplatebuf[Bufipl].Pages[bufip].colors
                    [ic].status;
                  plateframesdata[iplf].ProdPlates
                    [plateframes[iplf].NProdPlates].Pages[isgn].colors[ic]
                    .Priority := prodplatebuf[Bufipl].Pages[bufip].colors
                    [ic].Priority;
                  plateframesdata[iplf].ProdPlates
                    [plateframes[iplf].NProdPlates].Pages[isgn].colors[ic].Hold
                    := prodplatebuf[Bufipl].Pages[bufip].colors[ic].Hold;
                  plateframesdata[iplf].ProdPlates
                    [plateframes[iplf].NProdPlates].Pages[isgn].colors[ic]
                    .stackpos := prodplatebuf[Bufipl].Pages[bufip].colors
                    [ic].stackpos;
                  plateframesdata[iplf].ProdPlates
                    [plateframes[iplf].NProdPlates].Tower :=
                    prodplatebuf[Bufipl].Tower;
                  plateframesdata[iplf].ProdPlates
                    [plateframes[iplf].NProdPlates].Pages[isgn].colors[ic].High
                    := prodplatebuf[Bufipl].Pages[bufip].colors[ic].High;
                  plateframesdata[iplf].ProdPlates
                    [plateframes[iplf].NProdPlates].Pages[isgn].colors[ic]
                    .Cylinder := prodplatebuf[Bufipl].Pages[bufip].colors
                    [ic].Cylinder;
                  plateframesdata[iplf].ProdPlates
                    [plateframes[iplf].NProdPlates].Zone :=
                    prodplatebuf[Bufipl].Zone;
                end;
              Except

              end;
            End;
          End;
        end;

        For icopy := 1 to Ncopies do
        begin
          // back back back back back back back back back back back back back back back back back back back back
          Inc(plateframes[iplf].NProdPlates);

          bufip := -1;
          For isgn := 1 to AktPRODUCTION.aSections[isec].aFlats[iflat]
            .nPagesPerSide do
          begin
            isgnback := isgn + AktPRODUCTION.aSections[isec].aFlats[iflat]
              .nPagesPerSide;
            if AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages
              [isgnback] <> 0 then
            begin
              for ispl := 1 to planpagenames[isec].Npages do
              begin
                if (planpagenames[isec].Pages[ispl].sectionid = planpagenames
                  [isec].Pages[AktPRODUCTION.aSections[isec].aFlats[iflat]
                  .aOutputPages[isgnback]].sectionid) and
                  (planpagenames[isec].Pages[ispl].name = planpagenames[isec]
                  .Pages[AktPRODUCTION.aSections[isec].aFlats[iflat]
                  .aOutputPages[isgnback]].name) then
                begin
                  Bufipl := planpagenames[isec].Pages[ispl].Copies[icopy].ipl;
                  bufip := planpagenames[isec].Pages[ispl].Copies[icopy].ip;
                  Foundit := true;
                  break;
                end;
              end;
              break;
              // Bufipl := planpagenames[isec].pages[AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages[isgnback]].copies[icopy].ipl;
              // bufip  := planpagenames[isec].pages[AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages[isgnback]].copies[icopy].ip;
              // break;
            end;
          end;
          Wiplf := iplf;
          Wipl := isgn;
          Wip := bufip;
          Wop := AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages[isgn];
          plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
            .sheetnumber := sheet;
          plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
            .Front := 1;
          plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
            .TrueFront := 1;
          plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
            .templatelistid := prodplatebuf[Bufipl].templatelistid;

          plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
            .markgroups := prodplatebuf[Bufipl].markgroups;
          plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
            .Nmarkgroups := prodplatebuf[Bufipl].Nmarkgroups;

          plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
            .Copynumber := icopy;
          plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
            .productionid := 0;
          plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
            .publicationid := plateframespublicationid;

          plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
            .editionid := prodplatebuf[Bufipl].editionid;

          plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
            .Locationid := plateframeslocationid;
          plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
            .deviceid := prodplatebuf[Bufipl].deviceid;
          plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
            .Pressid := plateframespressid;
          plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates].runid
            := prodplatebuf[Bufipl].runid;
          plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
            .produce := prodplatebuf[Bufipl].produce;
          plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
            .readytoproduce := false;
          plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
            .someerror := false;
          plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
            .totappr := prodplatebuf[Bufipl].totappr;
          plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
            .totstat := 0;
          // plateframesdata[iplf].prodplates[plateframes[iplf].Nprodplates].Ncopies := prodplatebuf[bufipl].Ncopies;
          For isgn := 1 to AktPRODUCTION.aSections[isec].aFlats[iflat]
            .nPagesPerSide do // back
          Begin
            isgnback := isgn + AktPRODUCTION.aSections[isec].aFlats[iflat]
              .nPagesPerSide;

            IF AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages
              [isgnback] = 0 then
            begin
              Inc(Numberofhalfweb);
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].pagetype := 3;
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].pagename := 'Dinkey' +
                inttostr((iplf * 100) + Numberofhalfweb);
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].Ncolors := 1;
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].Oldrunid := -1;
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].colors[1].ColorID := 6;
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].colors[1].Copynumber := icopy;
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].colors[1].Uniquepage := 1;
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].colors[1].active := 0;
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].colors[1].status := 0;
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].colors[1].proofstatus := 0;
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].colors[1].Priority := 50;
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].colors[1].Hold := 0;
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].RipSetupID := 0;
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].PageFormatID := 0;
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].PageRotation := 0;

            end
            else
            Begin
              for ispl := 1 to planpagenames[isec].Npages do
              begin
                if (planpagenames[isec].Pages[ispl].sectionid = planpagenames
                  [isec].Pages[AktPRODUCTION.aSections[isec].aFlats[iflat]
                  .aOutputPages[isgnback]].sectionid) and
                  (planpagenames[isec].Pages[ispl].name = planpagenames[isec]
                  .Pages[AktPRODUCTION.aSections[isec].aFlats[iflat]
                  .aOutputPages[isgnback]].name) then
                begin
                  Bufipl := planpagenames[isec].Pages[ispl].Copies[icopy].ipl;
                  bufip := planpagenames[isec].Pages[ispl].Copies[icopy].ip;
                end;
              end;
              bufip := planpagenames[isec].Pages
                [AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages
                [isgnback]].Copies[icopy].ip;

              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Presssectionnumber := planpagenames[isec].Pages
                [AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages
                [isgnback]].presssecionnumber;

              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].pagename := planpagenames[isec].Pages
                [AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages
                [isgnback]].name;

              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].pagina := planpagenames[isec].Pages
                [AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages
                [isgnback]].pagina;

              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].Pageindex := planpagenames[isec].Pages
                [AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages
                [isgnback]].Pageindex;

              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].sectionid := planpagenames[isec].Pages
                [AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages
                [isgnback]].sectionid;

              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].pagetype := prodplatebuf[Bufipl].Pages
                [bufip].pagetype;
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].Antipanorama := prodplatebuf[Bufipl].Pages[bufip]
                .Antipanorama;

              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].Oldrunid := prodplatebuf[Bufipl].Pages
                [bufip].Oldrunid;

              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].totapproval := prodplatebuf[Bufipl].Pages[bufip]
                .totapproval;
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].Anyheld := prodplatebuf[Bufipl].Pages
                [bufip].Anyheld;

              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].Creep := AktPRODUCTION.aSections[isec].aFlats
                [iflat].aCreep[isgnback];
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].Ncolors := prodplatebuf[Bufipl].Pages
                [bufip].Ncolors;
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].pagestatus := prodplatebuf[Bufipl].Pages[bufip]
                .pagestatus;
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].proofed := prodplatebuf[Bufipl].Pages
                [bufip].proofed;
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].approved := prodplatebuf[Bufipl].Pages
                [bufip].approved;
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].pagechange := false;

              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].Orgeditionid := prodplatebuf[Bufipl].Pages[bufip]
                .Orgeditionid;

              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].totUniquePage := prodplatebuf[Bufipl].Pages[bufip]
                .totUniquePage;

              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].Ncolors := prodplatebuf[Bufipl].Pages
                [bufip].Ncolors;
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].proofid := prodplatebuf[Bufipl].Pages
                [bufip].proofid;

              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].PageRotation := prodplatebuf[Bufipl].Pages[bufip]
                .PageRotation;

              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].RipSetupID := prodplatebuf[Bufipl].Pages[bufip]
                .RipSetupID;

              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].PageFormatID := prodplatebuf[Bufipl].Pages[bufip]
                .PageFormatID;

              For ic := 1 to plateframesdata[iplf].ProdPlates
                [plateframes[iplf].NProdPlates].Pages[isgn].Ncolors do
              begin
                plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                  .Pages[isgn].colors[ic].ColorID := prodplatebuf[Bufipl].Pages
                  [bufip].colors[ic].ColorID;
                plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                  .Pages[isgn].colors[ic].Copynumber := icopy;

                plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                  .Pages[isgn].colors[ic].Uniquepage := prodplatebuf[Bufipl]
                  .Pages[bufip].totUniquePage;
                plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                  .Pages[isgn].colors[ic].active := prodplatebuf[Bufipl].Pages
                  [bufip].colors[ic].active;
                plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                  .Pages[isgn].colors[ic].status := prodplatebuf[Bufipl].Pages
                  [bufip].colors[ic].status;
                plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                  .Pages[isgn].colors[ic].proofstatus := prodplatebuf[Bufipl]
                  .Pages[bufip].colors[ic].status;
                plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                  .Pages[isgn].colors[ic].Priority := prodplatebuf[Bufipl].Pages
                  [bufip].colors[ic].Priority;
                plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                  .Pages[isgn].colors[ic].Hold := prodplatebuf[Bufipl].Pages
                  [bufip].colors[ic].Hold;
                plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                  .Pages[isgn].colors[ic].stackpos := prodplatebuf[Bufipl].Pages
                  [bufip].colors[ic].stackpos;

                plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                  .Tower := prodplatebuf[Bufipl].Tower;
                plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                  .Pages[isgn].colors[ic].High := prodplatebuf[Bufipl].Pages
                  [bufip].colors[ic].High;
                plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                  .Pages[isgn].colors[ic].Cylinder := prodplatebuf[Bufipl].Pages
                  [bufip].colors[ic].Cylinder;
                plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                  .Zone := prodplatebuf[Bufipl].Zone;
              end;
            End;
          End;
        End; // icopy

      End;

    except
    end;

  Finally
    (*
      For Iplf := 1 to Nbufplateframes do
      Begin
      Dispose(bufplateframes[Iplf].bufplateframe);
      end;
    *)
  end;
end;

Function TFormprodplan.ImagenumbertoIPL(iplf: Integer;
  Selectedimageindex: Integer): Integer;
Var
  ipl, ipln: Integer;
Begin
  ipl := 0;
  result := 0;
  try
    IF Selectedimageindex > 0 then
    begin
      ipl := -1;
      For ipln := 0 to Selectedimageindex - 1 do
      begin
        Inc(ipl, plateframes[iplf].Numberofcopies);
        // Inc(ipl,plateframesdata[iplf].prodplates[ipln].Ncopies);
      end;
      Inc(ipl, 1);

    End;
  finally
    result := ipl;
  end;
end;

Function TFormprodplan.SelectNewlocation(newlocationid: Integer;
  Var newpressid: Integer; Var Newtemplatelistid: Integer;
  Var NewNmarkgroups: Integer; Var Newmarkgroups: marksarray): Boolean;
Var
  // ip,ic : Integer;
  stepI, stepres: Integer;
  stepcancel: Boolean;

Begin
  stepI := 1;
  stepres := 0;
  stepcancel := false;
  result := false;
  Repeat
    Case stepI of
      1:
        begin
          FormSelectnewpress.Locationid := newlocationid;
          stepres := FormSelectnewpress.ShowModal;
        end;
      2:
        Begin

          Formselecttemplate.Panelwizard.visible := true;
          Formselecttemplate.Panel2.visible := false;
          Formselecttemplate.Panelproof.visible := false;
          Formselecttemplate.Panel3.visible := true;
          Formselecttemplate.Panel4.visible := false;
          Formselecttemplate.Panelmovepress.visible := false;
          Formselecttemplate.Aktpressname :=
            tnames1.pressnameIDtoname(FormSelectnewpress.newpressid);
          Formselecttemplate.PagesAcross := -1;
          Formselecttemplate.PagesDown := -1;
          Formselecttemplate.Aktpressid := -1;
          Formselecttemplate.aktpublicationid := -1;

          stepres := Formselecttemplate.ShowModal;
          Formselecttemplate.Panel2.visible := true;
          Formselecttemplate.Panel4.visible := false;
          Formselecttemplate.Panelproof.visible := true;
          Formselecttemplate.Panelmovepress.visible := false;
        end;
    end;

    Case stepres of
      mryes:
        Inc(stepI);
      mrno:
        Dec(stepI);
      mrcancel:
        stepcancel := true;
    end;

  Until (stepI = 0) or (stepI = 3) or (stepcancel);
  IF stepI = 3 then
  begin
    Newtemplatelistid := inittypes.gettemplatenumberfromID
      (Formselecttemplate.selectedtemplateid);
    NewNmarkgroups := Formselecttemplate.Nmarkgroups;
    Newmarkgroups := Formselecttemplate.markgroups;
    newpressid := FormSelectnewpress.newpressid;
  End;

  result := stepI = 3;
End;

Function TFormprodplan.ChangeLocation(newlocationid: Integer;
  newpressid: Integer; Newtemplatelistid: Integer; NewNmarkgroups: Integer;
  Newmarkgroups: marksarray): Boolean;

Var
  iplf
  // ,ipl,ip,ic
    : Integer;

Begin
  result := true;
  plateframeslocationid := newlocationid;
  plateframespressid := newpressid;
  EditProductionname.Text := createproductionname(plateframespublicationid,
    newpressid, plateframesPubdate);

  plateframesproductionid := tnames1.productionrunnametoid
    (EditProductionname.Text);
  IF plateframesproductionid = -1 then
    tnames1.Addname(9, EditProductionname.Text);
  plateframesproductionid := tnames1.productionrunnametoid
    (EditProductionname.Text);
  saveprodrundata(plateframesproductionid);

  copyplantoplanpages;
  for iplf := 1 to Nplateframes do
  begin
    planpagenames[iplf].hw1 := 0;
    planpagenames[iplf].hw2 := 0;
    planpagenames[iplf].Nhalfwebpage := 0;
  End;

  if doreimposecalc(Newtemplatelistid, true) then
  begin
    calulatepagina;
    for iplf := 1 to Nplateframes do
    begin
      reimposedplantoplates(iplf);
    end;

    applyglobdata(1, plateframesproductionid, plateframespublicationid,
      plateframeslocationid, plateframespressid, Newtemplatelistid,
      Newtemplatelistid, -1, -1, -1, NewNmarkgroups, Newmarkgroups);
    findorgedpages;
    setdinkydata(1);

    for iplf := 1 to Nplateframes do
    begin
      IF CheckBoxsmallimagesinEdit.checked then
        Pressviewzoom := 60
      else
        Pressviewzoom := 100;

      plateviewimage.Width := 23; // 204
      plateviewimage.Height := 51; // 176
      plateframes[iplf].PBExListview1.items.clear;
      plateframes[iplf].ImageListplanframe.clear;
      DrawThePlates(CheckBoxsmallimagesinEdit.checked, iplf);
    End;
    setpressrunids;
    copyplantoplanpages;
  end;
end;

Procedure TFormprodplan.MakePageList(Var APBExListview: TPBExListview;
  akttopindex: Integer);
Var
  iplf, ipl, ip, ic, Ipage: Integer;
  L: TListItem;
  icol: Integer;
  Cursort: Integer;
Begin
  Cursort := 0;
  try

    IF APBExListview.items.count > 0 then
    begin
      Cursort := ColumnToSort;
    end;

    APBExListview.items.BeginUpdate;
    APBExListview.items.clear;

    Ipage := 0;

    For iplf := 1 to Nplateframes do
    begin
      For ipl := 0 to plateframes[iplf].NProdPlates do
      begin
        for ip := 1 to PlatetemplateArray
          [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
        begin
          IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype <> 3 then
          begin
            Inc(Ipage);
            For ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
              .Ncolors do
            begin
              L := APBExListview.items.add;
              L.Caption := plateframesdata[iplf].ProdPlates[ipl].Pages
                [ip].pagename;
              L.subitems.add(tnames1.editionIDtoname(plateframesdata[iplf]
                .ProdPlates[ipl].editionid));

              if plateframesdata[iplf].ProdPlates[ipl].runid < 0 then
                L.subitems.add(inttostr(iplf))
              Else
                L.subitems.add
                  (inttostr(plateframesdata[iplf].ProdPlates[ipl].runid));
              L.subitems.add(inttostr(plateframesdata[iplf].ProdPlates[ipl]
                .sheetnumber));
              L.subitems.add
                (inttostr(plateframesdata[iplf].ProdPlates[ipl].Front));
              L.subitems.add(inttostr(plateframesdata[iplf].ProdPlates[ipl]
                .Copynumber));
              L.subitems.add(PlatetemplateArray[plateframesdata[iplf].ProdPlates
                [ipl].templatelistid].templatename);
              L.subitems.add(tnames1.sectionIDtoname(plateframesdata[iplf]
                .ProdPlates[ipl].Pages[ip].sectionid));
              L.subitems.add(inttostr(plateframesdata[iplf].ProdPlates[ipl]
                .Pages[ip].pagetype));
              L.subitems.add(inttostr(plateframesdata[iplf].ProdPlates[ipl]
                .Pages[ip].pagina));
              L.subitems.add(inttostr(plateframesdata[iplf].ProdPlates[ipl]
                .Pages[ip].Pageindex));
              L.subitems.add(tnames1.editionIDtoname(plateframesdata[iplf]
                .ProdPlates[ipl].Pages[ip].Orgeditionid));
              L.subitems.add(tnames1.ColornameIDtoname(plateframesdata[iplf]
                .ProdPlates[ipl].Pages[ip].colors[ic].ColorID));
              L.subitems.add(inttostr(plateframesdata[iplf].ProdPlates[ipl]
                .Pages[ip].colors[ic].active));
              L.subitems.add(GetPlannameFromID(2,
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                .stackpos));
              L.subitems.add(Getplantowername(plateframesdata[iplf].ProdPlates
                [ipl].Tower));
              L.subitems.add(GetPlannameFromID(5,
                plateframesdata[iplf].ProdPlates[ipl].Zone));
              L.subitems.add(GetPlannameFromID(4,
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                .Cylinder));
              L.subitems.add(GetPlannameFromID(3,
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors
                [ic].High));
              L.subitems.add('');
              L.subitems.add('');
              L.subitems.add('');

              L.subitems.add(inttostr(iplf) + ',' + inttostr(ipl) + ',' +
                inttostr(ip) + ',' + inttostr(ic));
              L.subitems.add(inttostr(Ipage));
              L.subitems.add(inttostr(plateframesdata[iplf].ProdPlates[ipl]
                .Pages[ip].MasterCopySeparationSet));

              IF L.subitems[0] <> L.subitems[10] then
                L.ImageIndex := 269
              else
                L.ImageIndex := 48;

            end;
          End;
        end;
      end;
    end;

    IF APBExListview.items.count > 0 then
    begin
      for icol := 0 to APBExListview.Columns.count - 1 do
      begin
        IF APBExListview.Columns[icol].Index = Cursort then
        begin
          PBExListview1ColumnClick(APBExListview, APBExListview.Columns[icol]);
          break;
        end;

      end;

    end;

    APBExListview.items.EndUpdate;

    (*
      IF (akttopindex > 0) and (APBExListview.Items.Count > APBExListview.VisibleRowCount) and (akttopindex < APBExListview.Items.Count-1 ) and
      ((APBExListview.topItem.Index + APBExListview.VisibleRowCount) < akttopindex) then
      APBExListview.topItem := APBExListview.Items[akttopindex];
      akttopindex *)
  Except
    beep;
  end;
end;

procedure TFormprodplan.PageControl1Change(Sender: TObject);
Var
  I: Integer;
begin
  case PageControl1.ActivePageIndex of
    0:
      begin
        plateviewimage.Width := 23; // 204
        plateviewimage.Height := 51; // 176
        For I := 1 to Nplateframes do
        begin
          plateframes[I].PBExListview1.clear;
          plateframes[I].ImageListplanframe.clear;

          DrawThePlates(CheckBoxsmallimagesinEdit.checked, I);
        end;
      end;
    1:
      makepagelist(PBExListview1, 0);
  end;
end;

procedure TFormprodplan.FormCreate(Sender: TObject);
begin

  Copytopressdontshowapply := false;
  addingplate := false;
  Calledwizardtoplates := false;
  JustAlayoutchange := false;

  prodplantype := 1;
  moveunplannedfrompressid := -1;
  Activated := false;
  Plantimming := TStringList.Create;
end;

Function TFormprodplan.NeedToProduce(iplf, ipl: Integer): Boolean;
Var
  ip: Integer;
Begin
  result := false;
  IF iplf = 1 then
  begin
    result := true;
    exit;
  End;
  IF ipl > plateframes[iplf - 1].NProdPlates then
  begin
    result := true;
    exit;
  end;
  IF (plateframesdata[iplf].ProdPlates[ipl].sheetnumber <> plateframesdata
    [iplf - 1].ProdPlates[ipl].sheetnumber) or
    (plateframesdata[iplf].ProdPlates[ipl].Front <> plateframesdata[iplf - 1]
    .ProdPlates[ipl].Front) or
    (plateframesdata[iplf].ProdPlates[ipl].templatelistid <> plateframesdata
    [iplf - 1].ProdPlates[ipl].templatelistid) or
    (plateframesdata[iplf].ProdPlates[ipl].Nmarkgroups <> plateframesdata
    [iplf - 1].ProdPlates[ipl].Nmarkgroups) then
  begin
    result := true;
    exit;
  end;
  For ip := 1 to plateframesdata[iplf].ProdPlates[ipl].Nmarkgroups do
  begin
    IF plateframesdata[iplf].ProdPlates[ipl].markgroups[ip] <> plateframesdata
      [iplf - 1].ProdPlates[ipl].markgroups[ip] then
    begin
      result := true;
      exit;
    end;
  end;
  For ip := 1 to PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl]
    .templatelistid].NupOnplate do
  begin
    if plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totUniquePage <> 0 then
    begin
      result := true;
      exit;
    end;
    IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype <>
      plateframesdata[iplf - 1].ProdPlates[ipl].Pages[ip].pagetype then
    begin
      result := true;
      exit;
    end;

    IF (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype <> 3) then
    Begin
      if (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Creep <>
        plateframesdata[iplf - 1].ProdPlates[ipl].Pages[ip].Creep) or
        (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Orgeditionid <>
        plateframesdata[iplf - 1].ProdPlates[ipl].Pages[ip].Orgeditionid) or
        (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].sectionid <>
        plateframesdata[iplf - 1].ProdPlates[ipl].Pages[ip].sectionid) or
        (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename <>
        plateframesdata[iplf - 1].ProdPlates[ipl].Pages[ip].pagename) or
        (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors <>
        plateframesdata[iplf - 1].ProdPlates[ipl].Pages[ip].Ncolors) then
      begin
        result := true;
        exit;
      end;
    end;
  end;
end;

Procedure TFormprodplan.SetProduce;
Var
  iplf, ipl
  // ,ip,ic
    : Integer;

begin
  iplf := 1;

  For ipl := 0 to plateframes[iplf].NProdPlates do
  begin
    plateframesdata[iplf].ProdPlates[ipl].produce := true;
  End;

  IF Nplateframes > 1 then
  begin
    For iplf := 1 to Nplateframes do
    begin
      For ipl := 0 to plateframes[iplf].NProdPlates do
      begin
        IF iplf = 1 then
          plateframesdata[iplf].ProdPlates[ipl].produce := true
        else
          plateframesdata[iplf].ProdPlates[ipl].produce :=
            Needtoproduce(iplf, ipl);
      End;
    End;
  End;

end;

Procedure TFormprodplan.ForceToMainEdition;
Var
  iplf, ipl, ip, ic: Integer;

begin
  iplf := 1;
  IF NOT JustAlayoutchange then
  begin
    For ipl := 0 to plateframes[iplf].NProdPlates do
    begin
      plateframesdata[iplf].ProdPlates[ipl].produce := true;
      for ip := 1 to PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
      begin
        IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totUniquePage = 0
        then
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totUniquePage := 2;
        For ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors do
        begin
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Uniquepage
                  := plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totUniquePage;
        end;
      end;
    end;
  End;
end;

Function TFormprodplan.CheckIfOtherUseCommon(iplf, ipl, ip: Integer;
  Var Riplf, Ripl, Rip: Integer): Boolean;
Var
  Fiplf, Fipl, FIP: Integer;
Begin
  result := false;
  findorgedpages;
  For Fiplf := 1 to Nplateframes do
  begin
    IF Fiplf <> iplf then
    begin
      For Fipl := 0 to plateframes[Fiplf].NProdPlates do
      begin
        for FIP := 1 to PlatetemplateArray
          [plateframesdata[Fiplf].ProdPlates[Fipl].templatelistid].NupOnplate do
        begin
          IF (plateframesdata[Fiplf].ProdPlates[Fipl].Pages[FIP].totUniquePage
            <> 1) and (plateframesdata[Fiplf].ProdPlates[Fipl].Pages[FIP]
            .Orgeditionid = plateframesdata[iplf].ProdPlates[ipl].editionid) and
            (plateframesdata[Fiplf].ProdPlates[Fipl].Pages[FIP]
            .OrgPageiplf = iplf) and
            (plateframesdata[Fiplf].ProdPlates[Fipl].Pages[FIP]
            .OrgPageipl = ipl) and
            (plateframesdata[Fiplf].ProdPlates[Fipl].Pages[FIP].OrgPageip = ip)
          then
          begin
            Riplf := Fiplf;
            Ripl := Fipl;
            Rip := FIP;
            result := true;
            exit;
          end;
        End
      End;
    End;
  End;
end;

procedure TFormprodplan.PBExListview1Edited(Sender: TObject; Item: TListItem;
  var S: String);

Var
  Il, iplf, ipl, ip
  // ,ic
    : Integer;
  T, t1: string;
  aktcap: string;
  Newpagina: String;

  Procedure Makepossiblepagina;
  Var
    I: Integer;
  Begin
    Newpagina := '';
    for I := 1 to length(S) do
    begin
      IF S[I] in tal then
      begin
        Newpagina := Newpagina + S[I];
      end;
    end;

  end;

begin
  aktcap := Item.Caption;
  if S = '' then
  begin
    MessageDlg(formmain.InfraLanguage1.Translate('Blank pagenames not allowed'),
      mtError, [mbOk], 0);
    S := aktcap;
    exit;
  end
  else
  begin
    T := Item.subitems[21];

    t1 := copy(T, 1, POS(',', T) - 1);
    iplf := StrToInt(t1);
    delete(T, 1, POS(',', T));
    t1 := copy(T, 1, POS(',', T) - 1);
    ipl := StrToInt(t1);
    delete(T, 1, POS(',', T));
    t1 := copy(T, 1, POS(',', T) - 1);
    ip := StrToInt(t1);
    plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename := S;
    Makepossiblepagina;
    IF Newpagina = '' then
    begin

    end;

    For Il := 0 to PBExListview1.items.count - 1 do
    begin
      IF PBExListview1.items[Il].subitems[22] = Item.subitems[22] then
      begin
        PBExListview1.items[Il].Caption := S;
        if Newpagina <> '' then
        begin
          PBExListview1.items[Il].subitems[8] := Newpagina;
          PBExListview1.items[Il].subitems[9] := Newpagina;
        End;
      end;
    end;
  End;

end;

procedure TFormprodplan.ActionpagepagenamenameeditExecute(Sender: TObject);
Var
  Il, iplf, ipl, ip
  // ,ic
    : Integer;
  ail, T, t1: string;
begin
  ail := '-1';
  IF FormPrepostfix.ShowModal = mrok then
  begin
    For Il := 0 to PBExListview1.items.count - 1 do
    begin
      IF (PBExListview1.items[Il].Selected) then
      begin
        PBExListview1.items[Il].Caption := FormPrepostfix.Editprefix.Text +
          PBExListview1.items[Il].Caption + FormPrepostfix.editpostfix.Text;
      End;
    end;

    For Il := 0 to PBExListview1.items.count - 1 do
    begin
      IF PBExListview1.items[Il].Selected then
      begin
        T := PBExListview1.items[Il].subitems[21];
        t1 := copy(T, 1, POS(',', T) - 1);
        iplf := StrToInt(t1);
        delete(T, 1, POS(',', T));
        t1 := copy(T, 1, POS(',', T) - 1);
        ipl := StrToInt(t1);
        delete(T, 1, POS(',', T));
        t1 := copy(T, 1, POS(',', T) - 1);
        ip := StrToInt(t1);
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename :=
          PBExListview1.items[Il].Caption;
      End;
    End;
    For Il := 0 to PBExListview1.items.count - 1 do
    begin
      T := PBExListview1.items[Il].subitems[21];
      t1 := copy(T, 1, POS(',', T) - 1);
      iplf := StrToInt(t1);
      delete(T, 1, POS(',', T));
      t1 := copy(T, 1, POS(',', T) - 1);
      ipl := StrToInt(t1);
      delete(T, 1, POS(',', T));
      t1 := copy(T, 1, POS(',', T) - 1);
      ip := StrToInt(t1);
      PBExListview1.items[Il].Caption := plateframesdata[iplf].ProdPlates[ipl]
        .Pages[ip].pagename;
    End;
  end;
end;

procedure TFormprodplan.Action1pagerefreshExecute(Sender: TObject);
Var
  akttopitem: Integer;

begin
  akttopitem := PBExListview1.TopItem.Index;
  makepagelist(PBExListview1, akttopitem);
end;

procedure TFormprodplan.PBExListview1ColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  ColumnToSort := Column.Index;
  (Sender as TCustomListView).AlphaSort;
  setactionenabled;
end;

procedure TFormprodplan.PBExListview1Compare(Sender: TObject;
  Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
var
  ix: Integer;
  a, b: Integer;
  sorted: Boolean;
begin
  sorted := false;
  if ColumnToSort = 0 then
  begin
    Compare := CompareText(Item1.Caption, Item2.Caption);
    sorted := true;
  end
  else
  begin

    ix := ColumnToSort - 1;

    if ix in [2, 3, 4, 8, 9] then
    begin
      a := StrToInt(Item1.subitems[ix]);
      b := StrToInt(Item2.subitems[ix]);
      IF a = b then
        Compare := 0;
      IF a < b then
        Compare := -1;
      IF a > b then
        Compare := 1;
      sorted := true;
    end;

    if ix in [0, 6] then
    begin
      a := StrToInt(Item1.subitems[9]);
      b := StrToInt(Item2.subitems[9]);
      if Item1.subitems[ix] = Item2.subitems[ix] then
      begin
        IF a = b then
          Compare := 0;
        IF a < b then
          Compare := -1;
        IF a > b then
          Compare := 1;
      end
      else
      begin
        Compare := CompareText(Item1.subitems[ix], Item2.subitems[ix]);
      end;
      sorted := true;
    end;

    if not sorted then
    begin
      Compare := CompareText(Item1.subitems[ix], Item2.subitems[ix]);
    end;

    (*
      ix := ColumnToSort - 1;

      if ix in [2,3,4,8,9] then
      begin
      a := strtoint(Item1.SubItems[ix]);
      b := strtoint(Item2.SubItems[ix]);
      IF a=b then compare := 0;
      IF a<b then compare := -1;
      IF a>b then compare := 1;
      end
      else
      begin
      Compare := CompareText(Item1.SubItems[ix],Item2.SubItems[ix]);
      end;
    *)

  end;
end;

procedure TFormprodplan.ActionpagestackposExecute(Sender: TObject);
Var
  I, Il, iplf, ipl, ip, ic: Integer;

  ail, T, t1: string;
begin
  IF Formlistselect.Caption <> 'Stackposition' then
  begin
    Formlistselect.ComboBox1.MaxLength := 4;
    Formlistselect.ComboBox1.Style := csDropDown;

    Formlistselect.ComboBox1.items.clear;
    For I := 0 to length(Prefs.StackNamesList) - 1 do
      Formlistselect.ComboBox1.items.add(Prefs.StackNamesList[I]);
    Formlistselect.Caption := 'Stackposition';
    Formlistselect.ComboBox1.ItemIndex := 0;
  end;
  ail := '-1';
  IF Formlistselect.ShowModal = mrok then
  begin
    For Il := 0 to PBExListview1.items.count - 1 do
    begin
      IF (PBExListview1.items[Il].Selected) then
      begin
        PBExListview1.items[Il].subitems[13] := Formlistselect.ComboBox1.Text;
      End;
    end;

    For Il := 0 to PBExListview1.items.count - 1 do
    begin
      IF PBExListview1.items[Il].Selected then
      begin
        T := PBExListview1.items[Il].subitems[21];
        t1 := copy(T, 1, POS(',', T) - 1);
        iplf := StrToInt(t1);
        delete(T, 1, POS(',', T));
        t1 := copy(T, 1, POS(',', T) - 1);
        ipl := StrToInt(t1);
        delete(T, 1, POS(',', T));
        t1 := copy(T, 1, POS(',', T) - 1);
        ip := StrToInt(t1);
        delete(T, 1, POS(',', T));
        ic := StrToInt(T);
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].stackpos :=
          SetPlanIDFromname(2, Formlistselect.ComboBox1.Text);
      End;
    End;
  end;
end;

procedure TFormprodplan.ActionpagetowerExecute(Sender: TObject);
Var
  Il, iplf, ipl, ip, ic, itow: Integer;
  ail, T, t1: string;

  pressname: string;
  NAutotows: Integer;
  Autotows: Array [1 .. 100] of string;
begin
  itow := 0;
  IF (Prefs.AutoTowerOrder) and (length(Prefs.PressTowers) > 1) then
  begin
    pressname := uppercase(tnames1.pressnameIDtoname(plateframespressid));
    NAutotows := 0;
    For itow := 0 to length(Prefs.PressTowers) - 1 do
    begin
      IF uppercase(Prefs.PressTowers[itow].Press) = pressname then
      begin
        Inc(NAutotows);
        Autotows[NAutotows] := Prefs.PressTowers[itow].Tower;

      end;
    end;

    For iplf := 1 to Nplateframes do
    begin
      For ipl := 0 to plateframes[iplf].PBExListview1.items.count - 1 do
      begin
        Inc(itow);
        IF itow = NAutotows then
          itow := 1;

        plateframesdata[iplf].ProdPlates[ipl].Tower :=
          SetplanTowername(Autotows[itow]);

      End;
    End;
  End
  Else
  Begin
    IF Formlistselect.Caption <> 'Tower' then
    begin
      Formlistselect.ComboBox1.MaxLength := 8;
      Formlistselect.ComboBox1.Style := csDropDown;
      // Formlistselect.ComboBox1.Items := fxormsettings.ListBoxtowers.Items;
      Formlistselect.Caption := 'Tower';
      Formlistselect.ComboBox1.ItemIndex := 0;
    end;
    ail := '-1';
    IF Formlistselect.ShowModal = mrok then
    begin
      For Il := 0 to PBExListview1.items.count - 1 do
      begin
        IF (PBExListview1.items[Il].Selected) then
        begin
          PBExListview1.items[Il].subitems[14] :=
            max8car(Formlistselect.ComboBox1.Text);
        End;
      end;

      For Il := 0 to PBExListview1.items.count - 1 do
      begin
        IF PBExListview1.items[Il].Selected then
        begin
          T := PBExListview1.items[Il].subitems[21];
          t1 := copy(T, 1, POS(',', T) - 1);
          iplf := StrToInt(t1);
          delete(T, 1, POS(',', T));
          t1 := copy(T, 1, POS(',', T) - 1);
          ipl := StrToInt(t1);
          delete(T, 1, POS(',', T));
          t1 := copy(T, 1, POS(',', T) - 1);
          ip := StrToInt(t1);
          delete(T, 1, POS(',', T));
          ic := StrToInt(T);
          plateframesdata[iplf].ProdPlates[ipl].Tower :=
            SetplanTowername(Formlistselect.ComboBox1.Text);
        End;
      End;
    end;
  End;
end;

procedure TFormprodplan.ActionpagecylinderExecute(Sender: TObject);
Var
  I, Il, iplf, ipl, ip, ic: Integer;

  ail, T, t1: string;
begin
  IF Formlistselect.Caption <> 'Cylinder' then
  begin
    Formlistselect.ComboBox1.MaxLength := 8;
    Formlistselect.ComboBox1.Style := csDropDown;
    Formlistselect.ComboBox1.items.clear;
    for I := 0 to length(Prefs.CylinderNameTranslation) - 1 do
      Formlistselect.ComboBox1.items.add(Prefs.CylinderNameTranslation
        [I].Value);

    Formlistselect.Caption := 'Cylinder';
    Formlistselect.ComboBox1.ItemIndex := 0;
  end;
  ail := '-1';
  IF Formlistselect.ShowModal = mrok then
  begin
    For Il := 0 to PBExListview1.items.count - 1 do
    begin
      IF (PBExListview1.items[Il].Selected) then
      begin
        PBExListview1.items[Il].subitems[16] :=
          max8car(Formlistselect.ComboBox1.Text);
      End;
    end;

    For Il := 0 to PBExListview1.items.count - 1 do
    begin
      IF PBExListview1.items[Il].Selected then
      begin
        T := PBExListview1.items[Il].subitems[21];
        t1 := copy(T, 1, POS(',', T) - 1);
        iplf := StrToInt(t1);
        delete(T, 1, POS(',', T));
        t1 := copy(T, 1, POS(',', T) - 1);
        ipl := StrToInt(t1);
        delete(T, 1, POS(',', T));
        t1 := copy(T, 1, POS(',', T) - 1);
        ip := StrToInt(t1);
        delete(T, 1, POS(',', T));
        ic := StrToInt(T);
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Cylinder :=
          SetPlanIDFromname(4, Formlistselect.ComboBox1.Text);
      End;
    End;
  end;
end;

procedure TFormprodplan.ActionpagezoneExecute(Sender: TObject);
Var
  I, Il, iplf, ipl, ip, ic: Integer;

  ail, T, t1: string;
begin
  IF Formlistselect.Caption <> 'Zone' then
  begin
    Formlistselect.ComboBox1.MaxLength := 8;
    Formlistselect.ComboBox1.Style := csDropDown;
    Formlistselect.ComboBox1.items.clear;
    For I := 0 to length(Prefs.ZoneNamesList) - 1 do
      Formlistselect.ComboBox1.items.add(Prefs.ZoneNamesList[I]);

    Formlistselect.Caption := 'Zone';
    Formlistselect.ComboBox1.ItemIndex := 0;
  end;
  ail := '-1';
  IF Formlistselect.ShowModal = mrok then
  begin
    For Il := 0 to PBExListview1.items.count - 1 do
    begin
      IF (PBExListview1.items[Il].Selected) then
      begin
        PBExListview1.items[Il].subitems[15] :=
          max8car(Formlistselect.ComboBox1.Text);
      End;
    end;

    For Il := 0 to PBExListview1.items.count - 1 do
    begin
      IF PBExListview1.items[Il].Selected then
      begin
        T := PBExListview1.items[Il].subitems[21];
        t1 := copy(T, 1, POS(',', T) - 1);
        iplf := StrToInt(t1);
        delete(T, 1, POS(',', T));
        t1 := copy(T, 1, POS(',', T) - 1);
        ipl := StrToInt(t1);
        delete(T, 1, POS(',', T));
        t1 := copy(T, 1, POS(',', T) - 1);
        ip := StrToInt(t1);
        delete(T, 1, POS(',', T));
        ic := StrToInt(T);
        plateframesdata[iplf].ProdPlates[ipl].Zone :=
          SetPlanIDFromname(5, Formlistselect.ComboBox1.Text);
      End;
    End;
  end;
end;

procedure TFormprodplan.ActionpageHighlowExecute(Sender: TObject);
Var
  Il, iplf, ipl, ip, ic: Integer;

  ail, T, t1, S: string;
begin

  IF Formlistselect.Caption <> 'High / Low' then
  begin
    Formlistselect.ComboBox1.MaxLength := 8;
    Formlistselect.ComboBox1.Style := csDropDownlist;
    Formlistselect.ComboBox1.items.clear;

    if Prefs.UseDBTowerNames then
    begin
      DataM1.Query1.sql.clear;
      DataM1.Query1.sql.add('Select TOP 1 HighName,LowName from PressNames');
      if (plateframespressid > 0) then
        DataM1.Query1.sql.add('where pressid = ' +
          inttostr(plateframespressid));
      formmain.Tryopen(DataM1.Query1);

      IF not DataM1.Query1.eof then
      begin
        IF DataM1.Query1.fields[0].asstring <> '' then
          Formlistselect.ComboBox1.items.add(DataM1.Query1.fields[0].asstring);
        IF DataM1.Query1.fields[1].asstring <> '' then
          Formlistselect.ComboBox1.items.add(DataM1.Query1.fields[1].asstring);
      end;
      DataM1.Query1.close;
    end
    else
    begin
      Formlistselect.ComboBox1.items.add(Prefs.PressHighPlateName);
      Formlistselect.ComboBox1.items.add(Prefs.PressLowPlateName);
    end;
    Formlistselect.Caption := 'High / Low';
    Formlistselect.ComboBox1.ItemIndex := 0;
  end;

  // try to set existing value
  S := '';
  For Il := 0 to PBExListview1.items.count - 1 do
  begin
    IF (PBExListview1.items[Il].Selected) then
    begin
      S := PBExListview1.items[Il].subitems[17];
      break;
    End;
  end;

  if (S <> '') then
  begin
    Formlistselect.ComboBox1.Text := S;
  end;

  ail := '-1';
  IF Formlistselect.ShowModal = mrok then
  begin
    For Il := 0 to PBExListview1.items.count - 1 do
    begin
      IF (PBExListview1.items[Il].Selected) then
      begin
        PBExListview1.items[Il].subitems[17] :=
          max8car(Formlistselect.ComboBox1.Text);
      End;
    end;

    For Il := 0 to PBExListview1.items.count - 1 do
    begin
      IF PBExListview1.items[Il].Selected then
      begin
        T := PBExListview1.items[Il].subitems[21];
        t1 := copy(T, 1, POS(',', T) - 1);
        iplf := StrToInt(t1);
        delete(T, 1, POS(',', T));
        t1 := copy(T, 1, POS(',', T) - 1);
        ipl := StrToInt(t1);
        delete(T, 1, POS(',', T));
        t1 := copy(T, 1, POS(',', T) - 1);
        ip := StrToInt(t1);
        delete(T, 1, POS(',', T));
        ic := StrToInt(T);
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].High :=
          SetPlanIDFromname(3, Formlistselect.ComboBox1.Text);
      End;
    End;
  end;
end;

procedure TFormprodplan.ActionlayoutExecute(Sender: TObject);
Var
  I, iplf, impl, ipl, ip,
  // ic,
  icp, iplt: Integer;
  aktpl: Integer;
  ishalfweb: Boolean;
  Maxup: Integer;
  // aktiplm : Integer;
  Swappagepositions: Boolean;
  AskedSwap: Boolean;
  buttonSelected: Integer;
  Pagebuf: Tprodpage;
begin
  try
    Swappagepositions := false;
    AskedSwap := false;
    ishalfweb := false;
    aktpl := -1;
    Maxup := 1;

    For iplf := 1 to Nplateframes do
    begin
      For impl := 0 to plateframes[iplf].PBExListview1.items.count - 1 do
      begin
        IF plateframes[iplf].PBExListview1.items[impl].Selected then
        begin
          aktpl := plateframesdata[iplf].ProdPlates[impl].templatelistid;
          break;
        end;
      End;
      IF aktpl <> -1 then
        break;
    End;

    IF aktpl <> -1 then
    begin
      For iplf := 1 to Nplateframes do
      begin
        For impl := 0 to plateframes[iplf].PBExListview1.items.count - 1 do
        begin
          IF plateframes[iplf].PBExListview1.items[impl].Selected then
          begin
            IF Maxup < PlatetemplateArray
              [plateframesdata[iplf].ProdPlates[impl].templatelistid].NupOnplate
            then
              Maxup := PlatetemplateArray
                [plateframesdata[iplf].ProdPlates[impl].templatelistid]
                .NupOnplate;
          end;
        End;
      End;
      For iplf := 1 to Nplateframes do
      begin
        For impl := 0 to plateframes[iplf].PBExListview1.items.count - 1 do
        begin
          IF plateframes[iplf].PBExListview1.items[impl].Selected then
          begin
            For ip := 1 to Maxup do
            begin
              IF plateframesdata[iplf].ProdPlates[impl].Pages[ip].pagetype = 3
              then
              begin
                ishalfweb := true;
                break;
              end;
            End;
          end;
          IF ishalfweb then
            break;
        End;
      End;

      FormChlayout.Aktpressname := tnames1.pressnameIDtoname
        (plateframespressid);
      FormChlayout.Curtemplate := PlatetemplateArray[aktpl].templatename;

      IF (ishalfweb) AND (Prefs.AllowSelectionOfAnyLayout) then
        FormChlayout.Allowtoshowdiv2 := PlatetemplateArray[aktpl]
          .NupOnplate div 2;

      IF FormChlayout.ShowModal = mrok then
      begin
        For iplf := 1 to Nplateframes do
        begin
          For impl := 0 to plateframes[iplf].PBExListview1.items.count - 1 do
          begin
            IF plateframes[iplf].PBExListview1.items[impl].Selected then
            begin

              if (PlatetemplateArray[FormChlayout.Newtemplatelistid]
                .NupOnplate = 2) then
              begin

                if (PlatetemplateArray[plateframesdata[iplf].ProdPlates[impl]
                  .templatelistid].PageRotationList[1] <> PlatetemplateArray
                  [FormChlayout.Newtemplatelistid].PageRotationList[1]) AND
                  (PlatetemplateArray[plateframesdata[iplf].ProdPlates[impl]
                  .templatelistid].PageRotationList[2] <> PlatetemplateArray
                  [FormChlayout.Newtemplatelistid].PageRotationList[2]) then
                begin
                  if (AskedSwap = false) then
                  begin
                    buttonSelected :=
                      MessageDlg
                      ('New layout has different page orientation - swap page positions?',
                      mtWarning, [mbYes, mbno], 0);
                    if buttonSelected = mryes then
                      Swappagepositions := true;
                    AskedSwap := true;
                  end;
                end;

              end;

              iplt := ImagenumbertoIPL(iplf, impl);
              For icp := 0 to plateframes[iplf].Numberofcopies - 1 do
              begin
                ipl := icp + iplt;
                plateframesdata[iplf].ProdPlates[ipl].templatelistid :=
                  FormChlayout.Newtemplatelistid;

                if (Swappagepositions) then
                begin
                  Pagebuf := plateframesdata[iplf].ProdPlates[ipl].Pages[1];
                  plateframesdata[iplf].ProdPlates[ipl].Pages[1] :=
                    plateframesdata[iplf].ProdPlates[ipl].Pages[2];
                  plateframesdata[iplf].ProdPlates[ipl].Pages[2] := Pagebuf;
                end;

              end;
              (*
                For icp := 0 to plateframesdata[iplf].prodplates[iplt].Ncopies-1 do
                begin
                ipl := icp+iplt;
                plateframesdata[iplf].prodplates[ipl].templatelistid := FormChlayout.Newtemplatelistid;

                end;
              *)
            end;
          End;
        end;

        plateviewimage.Width := 23; // 204
        plateviewimage.Height := 51; // 176
        For I := 1 to Nplateframes do
        begin
          plateframes[I].PBExListview1.clear;
          plateframes[I].ImageListplanframe.clear;
          DrawThePlates(CheckBoxsmallimagesinEdit.checked, I);
        end;
      End;
    End;
  Finally
  end;
end;

procedure TFormprodplan.CheckBoxsubedselectionClick(Sender: TObject);

Var
  iplf, ipl { ,ip,ic } : Integer;

begin
  For iplf := 1 to Nplateframes do
  begin
    plateframes[iplf].Selected := CheckBoxsubedselection.checked;
    For ipl := 0 to plateframes[iplf].PBExListview1.items.count - 1 do
    begin
      plateframes[iplf].PBExListview1.items[ipl].Selected := false;
    end;
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
end;

procedure TFormprodplan.ActionCommonExecute(Sender: TObject);
Var
  I, iplf, impl, ipl, ip { ,ic } , icp, iplt: Integer;
  // aktpl : Integer;
begin
  try
    For iplf := 1 to Nplateframes do
    begin
      For impl := 0 to plateframes[iplf].PBExListview1.items.count - 1 do
      begin
        IF plateframes[iplf].PBExListview1.items[impl].Selected then
        begin
          iplt := ImagenumbertoIPL(iplf, impl);
          For icp := 0 to plateframes[iplf].Numberofcopies - 1 do
          begin
            ipl := icp + iplt;
            for ip := 1 to PlatetemplateArray
              [plateframesdata[iplf].ProdPlates[ipl].templatelistid]
              .NupOnplate do
            Begin
              IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totUniquePage = 0
              then
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                  .totUniquePage := 2;
            end;
          end;
        end;
      End;
    end;
    plateviewimage.Width := 23; // 204
    plateviewimage.Height := 51; // 176
    For I := 1 to Nplateframes do
    begin
      plateframes[I].PBExListview1.clear;
      plateframes[I].ImageListplanframe.clear;
      DrawThePlates(CheckBoxsmallimagesinEdit.checked, I);
    end;

  Finally
  end;
end;

procedure TFormprodplan.ActioneditcolorsExecute(Sender: TObject);

  procedure RemoveColor(iplf, ipl, ip, ColorID: Integer);
  Var
    // colorbuf : Tprodcolorsrec;
    I,
    // ic,
    I2: Integer;
    found: Boolean;
    T: string;
  Begin
    T := tnames1.ColornameIDtoname(ColorID);
    IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype <> 3 then
    begin
      found := false;
      if ColorID = plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors
        [plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors].ColorID then
      Begin
        Dec(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors);
      End
      else
      begin
        I2 := -1;
        For I := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors do
        Begin
          IF ColorID = plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[I]
            .ColorID then
          begin
            I2 := I;
            break;
          end;
        end;
        IF I2 > 0 then
        begin
          For I := I2 + 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
            .Ncolors do
          begin
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[I - 1] :=
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[I];
          end;
          Dec(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors);
        End;
      end;
    end;
  end;

  procedure AddColor(iplf, ipl, ip, ColorID: Integer);
  Var
    found: Boolean;
    ic: Integer;
    // I : Integer;
  Begin
    found := false;
    For ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors do
    begin
      IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].ColorID = ColorID
      then
      begin
        found := true;
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].active := 1;
        break;
      end;
    end;

    IF not found then
    begin
      Inc(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors);
      ic := plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].ColorID
        := ColorID;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
        .Separation := 0;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
        .FlatSeparation := 0;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Layer := 0;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Orgeditionid :=
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[1].Orgeditionid;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
        .DoubleBurned := false;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Copynumber :=
        plateframesdata[iplf].ProdPlates[ipl].Copynumber;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Uniquepage :=
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totUniquePage;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].active := 1;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].status := 0;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
        .proofstatus := 0;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].approved := 0;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Priority :=
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[1].Priority;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Hold :=
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[1].Hold;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].stackpos :=
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[1].stackpos;
      plateframesdata[iplf].ProdPlates[ipl].Tower := plateframesdata[iplf]
        .ProdPlates[ipl].Tower;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].High :=
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[1].High;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Cylinder :=
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[1].Cylinder;
      plateframesdata[iplf].ProdPlates[ipl].Zone := plateframesdata[iplf]
        .ProdPlates[ipl].Zone;
    End;
  end;

Var
  I, iplf, impl, ipl, ip, ic, icp, iplt, icl: Integer;
  aktpl: Integer;

begin
  try

    Formeditcolors.CheckListBoxcolors.items.clear;
    For I := 0 to tnames1.Colornames.count - 1 do
    begin
      IF uppercase(tnames1.Colornames[I]) <> 'DINKY' then
        Formeditcolors.CheckListBoxcolors.items.add(tnames1.Colornames[I]);
    end;

    aktpl := -1;
    For iplf := 1 to Nplateframes do
    begin
      For impl := 0 to plateframes[iplf].PBExListview1.items.count - 1 do
      begin
        IF plateframes[iplf].PBExListview1.items[impl].Selected then
        begin
          iplt := ImagenumbertoIPL(iplf, impl);
          for ip := 1 to PlatetemplateArray
            [plateframesdata[iplf].ProdPlates[iplt].templatelistid]
            .NupOnplate do
          Begin
            if plateframesdata[iplf].ProdPlates[iplt].Pages[ip].pagetype <> 3
            then
            begin
              aktpl := 1;
              For ic := 1 to plateframesdata[iplf].ProdPlates[iplt].Pages[ip]
                .Ncolors do
              begin
                I := Formeditcolors.CheckListBoxcolors.items.IndexOf
                  (tnames1.ColornameIDtoname(plateframesdata[iplf].ProdPlates
                  [iplt].Pages[ip].colors[ic].ColorID));
                Formeditcolors.CheckListBoxcolors.checked[I] :=
                  plateframesdata[iplf].ProdPlates[iplt].Pages[ip].colors[ic]
                  .active = 1;
              end;
              IF aktpl <> -1 then
                break;
            end;
          End;

          IF aktpl <> -1 then
            break;
        end;
      End;
      IF aktpl <> -1 then
        break;
    End;

    IF Formeditcolors.ShowModal = mrok then
    begin
      For iplf := 1 to Nplateframes do
      begin
        For impl := 0 to plateframes[iplf].PBExListview1.items.count - 1 do
        begin
          IF plateframes[iplf].PBExListview1.items[impl].Selected then
          begin
            iplt := ImagenumbertoIPL(iplf, impl);

            For icp := 0 to plateframes[iplf].Numberofcopies - 1 do
            begin
              ipl := icp + iplt;
              for ip := 1 to PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
              Begin
                IF plateframesdata[iplf].ProdPlates[iplt].Pages[ip].pagetype <> 3
                then
                begin

                  IF Formeditcolors.listbox2.items.count > 0 then
                  begin
                    for icl := 0 to Formeditcolors.listbox2.items.count - 1 do
                    begin
                      AddColor(iplf, ipl, ip,
                        tnames1.Colornametoid(Formeditcolors.listbox2.items[icl]));
                    End;
                  End;
                  IF Formeditcolors.listbox3.items.count > 0 then
                  begin
                    for icl := 0 to Formeditcolors.listbox3.items.count - 1 do
                    begin
                      RemoveColor(iplf, ipl, ip,
                        tnames1.Colornametoid(Formeditcolors.listbox3.items[icl]));
                    End;
                  End;
                End
                Else
                begin

                end;
              end;
            end;
          end;
        End;
      end;
      plateviewimage.Width := 23; // 204
      plateviewimage.Height := 51; // 176
      For I := 1 to Nplateframes do
      begin
        plateframes[I].PBExListview1.clear;
        plateframes[I].ImageListplanframe.clear;
        DrawThePlates(CheckBoxsmallimagesinEdit.checked, I);
      end;

    End;
  Finally
  end;
end;

Function TFormprodplan.Needtobeunique(iplf, ipl: Integer): Boolean;
Var
  ip
  // ,ic
    : Integer;
  Orgiplf, orgipl, orgip
  // ,orgic
    : Integer;
Begin
  result := false;
  For ip := 1 to PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl]
    .templatelistid].NupOnplate do
  begin
    if plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totUniquePage = 0 then
    begin
      Orgiplf := plateframesdata[iplf].ProdPlates[ipl].Pages[ip].OrgPageiplf;
      orgipl := plateframesdata[iplf].ProdPlates[ipl].Pages[ip].OrgPageipl;
      orgip := plateframesdata[iplf].ProdPlates[ipl].Pages[ip].OrgPageip;
      IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors <>
        plateframesdata[Orgiplf].ProdPlates[orgipl].Pages[orgip].Ncolors then
      begin
      end;
    End;
  end;
end;

procedure TFormprodplan.ActionSetuniquepagesExecute(Sender: TObject);
Var
  foundthepage, found, mustbeunique: Boolean;
  iplf, ipl, ip, ic: Integer;
  Iplf2, ipl2, ip2, ic2: Integer;
Begin

  IF Nplateframes > 1 then
  begin
    For iplf := 2 to Nplateframes do
    begin
      For ipl := 0 to plateframes[iplf].NProdPlates do
      begin
        for ip := 1 to PlatetemplateArray
          [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
        begin
          mustbeunique := true;
          foundthepage := false;
          found := false;
          For Iplf2 := iplf - 1 downto 1 do
          begin
            For ipl2 := 0 to plateframes[Iplf2].NProdPlates do
            begin
              if plateframesdata[Iplf2].ProdPlates[ipl2]
                .editionid = plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Orgeditionid
              then
              begin
                for ip2 := 1 to PlatetemplateArray
                  [plateframesdata[Iplf2].ProdPlates[ipl2].templatelistid]
                  .NupOnplate do
                begin
                  if (plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                    .pagename = plateframesdata[Iplf2].ProdPlates[ipl2].Pages
                    [ip2].pagename) and
                    (plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                    .sectionid = plateframesdata[Iplf2].ProdPlates[ipl2].Pages
                    [ip2].sectionid) then
                  begin
                    mustbeunique := false;
                    foundthepage := true;
                    for ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages
                      [ip].Ncolors do
                    begin
                      found := false;
                      for ic2 := 1 to plateframesdata[Iplf2].ProdPlates[ipl2]
                        .Pages[ip2].Ncolors do
                      begin
                        IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                          .colors[ic].ColorID = plateframesdata[Iplf2]
                          .ProdPlates[ipl2].Pages[ip2].colors[ic2].ColorID then
                        begin
                          found := true;
                          break;
                        end;
                      end;
                      IF not found then
                      begin
                        mustbeunique := true;
                        break;
                      end;
                    end;

                    for ic2 := 1 to plateframesdata[Iplf2].ProdPlates[ipl2]
                      .Pages[ip2].Ncolors do
                    begin
                      found := false;
                      for ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages
                        [ip].Ncolors do
                      begin
                        IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                          .colors[ic].ColorID = plateframesdata[Iplf2]
                          .ProdPlates[ipl2].Pages[ip2].colors[ic2].ColorID then
                        begin
                          found := true;
                          break;
                        end;
                      end;
                      IF not found then
                      begin
                        mustbeunique := true;
                        break;
                      end;
                    end;

                    IF mustbeunique then
                    begin
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                        .totUniquePage := 1;
                      // nymast
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                        .MasterCopySeparationSet := plateframesdata[iplf]
                        .ProdPlates[ipl].Pages[ip].CopySeparationSet;
                    End
                    else
                    begin
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                        .totUniquePage := 0;
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                        .OrgPageiplf := Iplf2;
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                        .OrgPageipl := ipl2;
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                        .OrgPageip := ip2;
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                        .OrgCopySeparationSet := plateframesdata[Iplf2]
                        .ProdPlates[ipl2].Pages[ip2].CopySeparationSet;
                    End;
                    break;
                  end;
                End;
                if foundthepage then
                  break;
              End;
              if foundthepage then
                break;
            End;
            if foundthepage then
              break;
          End;
          IF not foundthepage then
          begin
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totUniquePage := 1;
            // nymast
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
              .MasterCopySeparationSet := plateframesdata[iplf].ProdPlates[ipl]
              .Pages[ip].CopySeparationSet;
          end;
        end;
      End;
    End;
  End;

  plateviewimage.Width := 23; // 204
  plateviewimage.Height := 51; // 176
  For iplf := 1 to Nplateframes do
  begin
    plateframes[iplf].PBExListview1.clear;
    plateframes[iplf].ImageListplanframe.clear;

    DrawThePlates(CheckBoxsmallimagesinEdit.checked, iplf);
  end;

end;

procedure TFormprodplan.ActionplaterefreshExecute(Sender: TObject);
Var

  iplf: Integer;
begin
  plateviewimage.Width := 23; // 204
  plateviewimage.Height := 51; // 176
  For iplf := 1 to Nplateframes do
  begin
    plateframes[iplf].PBExListview1.clear;
    plateframes[iplf].ImageListplanframe.clear;
    DrawThePlates(CheckBoxsmallimagesinEdit.checked, iplf);
  end;

end;

procedure TFormprodplan.FormResize(Sender: TObject);
Var
  iplf: Integer;
begin
  (*
    IF Nplateframes > 0 then
    begin
    for IPLF := 1 to Nplateframes do
    begin
    plateframes[IPLF].visible := false;
    plateframes[IPLF].Align := alnone;
    plateframes[IPLF].Top := ScrollBoxplan.Height - 5;
    plateframes[IPLF].Height := 20;
    End;

    For iplf := 1 to Nplateframes do
    begin
    plateframes[iplf].Height := plateframes[iplf].Parent.Height div Nplateframes;
    IF plateframes[iplf].Height < 200 then
    plateframes[iplf].Height := 200;
    end;


    plateviewimage.Width := 23;    //204
    plateviewimage.height := 51;   //176
    For iPLF := 1 to Nplateframes do
    begin
    plateframes[IPLF].PBExListview1.clear;
    plateframes[IPLF].ImageListplanframe.Clear;

    drawtheplates(CheckBoxsmallimagesinEdit.Checked,iPLF);
    end;

    end;
  *)

  IF Nplateframes > 0 then
  begin
    getcurrentplan;

    plateviewimage.Width := 23; // 204
    plateviewimage.Height := 51; // 176
    For iplf := 1 to Nplateframes do
    begin
      plateframes[iplf].PBExListview1.clear;
      plateframes[iplf].ImageListplanframe.clear;
      DrawThePlates(Formprodplan.CheckBoxsmallimagesinEdit.checked, iplf);
    end;

    IF plateframes[1].NProdPlates > 0 then
    begin
      Formselecttemplate.selectedtemplateid := PlatetemplateArray
        [plateframesdata[1].ProdPlates[0].templatelistid].TemplateID;
      Formselecttemplate.markgroups := plateframesdata[1].ProdPlates[0]
        .markgroups;
      Formselecttemplate.Nmarkgroups := plateframesdata[1].ProdPlates[0]
        .Nmarkgroups;
      Formselecttemplate.Selectedtemplatenumber := plateframesdata[1].ProdPlates
        [0].templatelistid;
    end;

    if plateframes[Nplateframes].Top + plateframes[Nplateframes].Height <
      ScrollBoxplan.Height then
      plateframes[Nplateframes].Align := alclient;

  End;
  ScrollBoxplan.visible := true;
  setactionenabled;

end;

procedure TFormprodplan.ActioncopyaddExecute(Sender: TObject);
Begin
  AddAcopy;
End;

procedure TFormprodplan.AddAcopy;
  Procedure setpagedata(iplf, ipl: Integer);
  Var
    ip, ic: Integer;
  Begin
    plateframesdata[iplf].ProdPlates[ipl].FlatSeparationSet :=
      (plateframesdata[iplf].ProdPlates[ipl].CopyFlatSeparationSet * 100) +
      plateframesdata[iplf].ProdPlates[ipl].Copynumber;
    for ip := 1 to PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl]
      .templatelistid].NupOnplate do
    Begin
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].SeparationSet :=
        (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].CopySeparationSet *
        100) + plateframesdata[iplf].ProdPlates[ipl].Copynumber;
      For ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors do
      begin
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Separation :=
          (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].SeparationSet * 100)
          + plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].ColorID;
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
          .FlatSeparation :=
          (plateframesdata[iplf].ProdPlates[ipl].FlatSeparationSet * 100) +
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].ColorID;
        Case plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
          .status of
          0 .. 9:
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
              .status := 0;
          10 .. 29:
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
              .status := 10;
          30 .. 100:
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
              .status := 30;
        end;
      end;
    end;
  end;

Var

  iplf, ipl { ,ip,ic } : Integer;
  Niplf2, Iplf2, ipl2 { ,ip2,ic2 } : Integer;
  Hipprodcount: Integer;

begin // NprodplatesSize
  Hipprodcount := 0;
  For iplf := 1 to Nplateframes do
  begin
    if Hipprodcount < plateframes[iplf].NProdPlates + 1 then
      Hipprodcount := plateframes[iplf].NProdPlates + 1;
  end;

  Iplf2 := Nplateframes;
  For iplf := 1 to Nplateframes do
  begin
    Inc(Iplf2);
    plateframes[Iplf2].NProdPlates := plateframes[iplf].NProdPlates;
    plateframesdata[Iplf2].ProdPlates := plateframesdata[iplf].ProdPlates;
    plateframes[Iplf2].Selected := true;
    formmain.Allocateprodplates(Iplf2, ((Hipprodcount * 2) + 8) + 32);
  end;
  Niplf2 := Iplf2;
  iplf := 0;

  For Iplf2 := Nplateframes + 1 to Niplf2 do
  begin
    ipl := -1;
    Inc(iplf);
    Inc(plateframes[iplf].Numberofcopies);
    formmain.Allocateprodplates(iplf,
      (((plateframes[iplf].NProdPlates + 1) * plateframes[iplf].Numberofcopies)
      + 8) + 32);
    For ipl2 := 0 to plateframes[Iplf2].NProdPlates do
    begin
      Inc(ipl);
      plateframesdata[iplf].ProdPlates[ipl] := plateframesdata[Iplf2]
        .ProdPlates[ipl2];
      if plateframesdata[Iplf2].ProdPlates[ipl2 + 1].Copynumber = 1 then
      begin
        Inc(ipl);
        plateframesdata[iplf].ProdPlates[ipl] := plateframesdata[Iplf2]
          .ProdPlates[ipl2];
        Inc(plateframesdata[iplf].ProdPlates[ipl].Copynumber);
        setpagedata(iplf, ipl);
      end;
    end;
    Inc(ipl);
    plateframesdata[iplf].ProdPlates[ipl] := plateframesdata[Iplf2].ProdPlates
      [plateframes[Iplf2].NProdPlates];
    Inc(plateframesdata[iplf].ProdPlates[ipl].Copynumber);

    plateframes[iplf].NProdPlates := ipl;
    setpagedata(iplf, ipl);
  End;

  findorgedpages;
  copyplantoplanpages;

  For Iplf2 := Nplateframes + 1 to Niplf2 do
  Begin
    plateframes[Iplf2].PBExListview1.items.clear;
    plateframes[Iplf2].ImageListplanframe.clear;
    Setlength(plateframesdata[Iplf2].ProdPlates, 0);
  end;

  IF Nplateframes > 0 then
  begin
    plateviewimage.Width := 23; // 204
    plateviewimage.Height := 51; // 176
    For iplf := 1 to Nplateframes do
    begin
      plateframes[iplf].PBExListview1.clear;
      plateframes[iplf].ImageListplanframe.clear;

      DrawThePlates(CheckBoxsmallimagesinEdit.checked, iplf);
    end;
  End;

end;

procedure TFormprodplan.ActioncopydeleteExecute(Sender: TObject);
Var
  iplf, ipl { ,ip,ic } : Integer;
  Niplf2, Iplf2, ipl2
  // ,ip2,ic2
    : Integer;
begin // NprodplatesSize
  Iplf2 := Nplateframes;
  For iplf := 1 to Nplateframes do
  begin
    Inc(Iplf2);
    // plateframes[Iplf2] := Tplateframe.Create(nil);
    plateframes[Iplf2].NProdPlates := plateframes[iplf].NProdPlates;
    plateframesdata[Iplf2].ProdPlates := plateframesdata[iplf].ProdPlates;
    plateframes[Iplf2].pressrunid := plateframes[iplf].pressrunid;
    plateframes[Iplf2].PressTime := plateframes[iplf].PressTime;
    plateframes[Iplf2].CustomerID := plateframes[iplf].CustomerID;
    plateframes[Iplf2].Numberofcopies := plateframes[iplf].Numberofcopies;
    plateframes[Iplf2].Miscdate := plateframes[iplf].Miscdate;
    plateframes[Iplf2].SequenceNumber := plateframes[iplf].SequenceNumber;
    plateframes[Iplf2].productiontime := plateframes[iplf].productiontime;
    plateframes[Iplf2].PriorityBeforeHottime := plateframes[iplf]
      .PriorityBeforeHottime;
    plateframes[Iplf2].PriorityDuringHottime := plateframes[iplf]
      .PriorityDuringHottime;
    plateframes[Iplf2].PriorityAfterHottime := plateframes[iplf]
      .PriorityAfterHottime;
    plateframes[Iplf2].PriorityHottimeBegin := plateframes[iplf]
      .PriorityHottimeBegin;
    plateframes[Iplf2].PriorityHottimeEnd := plateframes[iplf]
      .PriorityHottimeEnd;
    plateframes[Iplf2].Comment := plateframes[iplf].Comment;
    plateframes[Iplf2].order := plateframes[iplf].order;
    plateframes[Iplf2].PressConfignameX := plateframes[iplf].PressConfignameX;
    plateframes[Iplf2].Inkcomment := plateframes[iplf].Inkcomment;

  end;
  Niplf2 := Iplf2;
  iplf := 0;
  For Iplf2 := Nplateframes + 1 to Niplf2 do
  begin
    Dec(plateframes[Iplf2].Numberofcopies);
    ipl := -1;
    Inc(iplf);
    For ipl2 := 0 to plateframes[Iplf2].NProdPlates do
    begin
      if (plateframesdata[Iplf2].ProdPlates[ipl2].Copynumber <= plateframes
        [Iplf2].Numberofcopies) then
      begin
        Inc(ipl);
        plateframesdata[iplf].ProdPlates[ipl] := plateframesdata[Iplf2]
          .ProdPlates[ipl2];
      end;
    end;
    plateframes[iplf].pressrunid := plateframes[Iplf2].pressrunid;
    plateframes[iplf].PressTime := plateframes[Iplf2].PressTime;
    plateframes[iplf].CustomerID := plateframes[Iplf2].CustomerID;
    plateframes[iplf].Numberofcopies := plateframes[Iplf2].Numberofcopies;
    plateframes[iplf].Miscdate := plateframes[Iplf2].Miscdate;
    plateframes[iplf].SequenceNumber := plateframes[Iplf2].SequenceNumber;
    plateframes[iplf].productiontime := plateframes[Iplf2].productiontime;
    plateframes[iplf].PriorityBeforeHottime := plateframes[Iplf2]
      .PriorityBeforeHottime;
    plateframes[iplf].PriorityDuringHottime := plateframes[Iplf2]
      .PriorityDuringHottime;
    plateframes[iplf].PriorityAfterHottime := plateframes[Iplf2]
      .PriorityAfterHottime;
    plateframes[iplf].PriorityHottimeBegin := plateframes[Iplf2]
      .PriorityHottimeBegin;
    plateframes[iplf].PriorityHottimeEnd := plateframes[Iplf2]
      .PriorityHottimeEnd;
    plateframes[iplf].Comment := plateframes[Iplf2].Comment;
    plateframes[iplf].order := plateframes[Iplf2].order;
    plateframes[iplf].PressConfignameX := plateframes[Iplf2].PressConfignameX;
    plateframes[iplf].Inkcomment := plateframes[Iplf2].Inkcomment;
    plateframes[iplf].NProdPlates := ipl;

  End;

  For Iplf2 := Nplateframes + 1 to Niplf2 do
  Begin
    try
      Setlength(plateframesdata[Iplf2].ProdPlates, 0);
    Except

    end;
  end;

  IF Nplateframes > 0 then
  begin
    plateviewimage.Width := 23; // 204
    plateviewimage.Height := 51; // 176
    For iplf := 1 to Nplateframes do
    begin
      plateframes[iplf].PBExListview1.clear;
      plateframes[iplf].ImageListplanframe.clear;
      DrawThePlates(CheckBoxsmallimagesinEdit.checked, iplf);
    end;
  End;

end;

procedure TFormprodplan.ApplySamelocationstatus(iplf, ipl, ip, ic: Integer);
Begin
  Case plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].status of
    0 .. 9:
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].status := 0;
    10 .. 29:
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].status := 10;
    30 .. 100:
      Begin
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].status := 30;
      end;
  end;
end;

procedure TFormprodplan.Applyplan(iplf: Integer; NAprodplates: Integer;
                                  frompressid: Integer; fromlocationid: Integer; applydevice: Integer;
                                  frommain: Boolean; extracopyoffset: Integer);
Var
  ip, ic, ipl: Integer;
  OrgPageiplf, OrgPageipl, OrgPageip, OrgCopySeparationSet: Integer;
  tmplid: Integer;
  Nup, ColorID: Integer;
  noplanrecordexists, recordexists, locationexists: Boolean;

  CopyFlatSeparationSet, aktcopyseparationset: Integer;
  hcopy, hrun: Integer;

  FMasterCopySeparationSet: Integer;
  FCopySeparationSet: Integer;
  FSeparationSet: Integer;
  FFlatSeparationSet: Integer;
  FCopyFlatSeparationSet: Integer;
  FSeparation: Int64;
  FFlatSeparation: Int64;
  Foundlevel: Integer;

  publIDT, EdIDT, secIDT, IssueIDT: string;

  firstcolor: Boolean;

          Procedure ApplyIt;
          Var
            I: Integer;
            // applydone : boolean;
            // applytries : Integer;
          Begin
            IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype = 3 then
              I := 21;

            IF (PartialPlanning) and (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype = 3) then
            begin
              // Der skal ikke applies hvis det er en pagetype 3 skal den addes
              sleep(12);
            end
            else
            begin
              DataM1.Query3.sql.clear;
              // DataM1.Query3.sql.add('set lock_timeout 30000');
              DataM1.Query3.sql.add('update pagetable set');
              DataM1.Query3.sql.add('pagination = ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagina));
              DataM1.Query3.sql.add(',LocationID = ' + inttostr(plateframeslocationid));
              DataM1.Query3.sql.add(',proofid = ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].proofid));
              DataM1.Query3.sql.add(',PressRunID = ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].runid));
              DataM1.Query3.sql.add(',TemplateID = ' + inttostr(PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl].templatelistid].TemplateID));
              DataM1.Query3.sql.add(',PagePosition = ' + inttostr(ip));
              DataM1.Query3.sql.add(',PageType = ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype));
              DataM1.Query3.sql.add(',PagesOnPlate = ' + inttostr(PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate));
              DataM1.Query3.sql.add(',SheetNumber = ' +  inttostr(plateframesdata[iplf].ProdPlates[ipl].sheetnumber));
              DataM1.Query3.sql.add(',SheetSide = ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].Front));
              DataM1.Query3.sql.add(',PressID = ' + inttostr(plateframespressid));
              DataM1.Query3.sql.add(',PressSectionNumber = ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].Presssectionnumber));
              DataM1.Query3.sql.add(',CopyFlatSeparationset = ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].CopyFlatSeparationSet));
              DataM1.Query3.sql.add(',CopySeparationset = ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].CopySeparationSet));
              DataM1.Query3.sql.add(',FlatSeparationset = ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].FlatSeparationSet));
              DataM1.Query3.sql.add(',Separationset = ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].SeparationSet));
              DataM1.Query3.sql.add(',Separation = ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Separation));
              DataM1.Query3.sql.add(',FlatSeparation = ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].FlatSeparation));
              DataM1.Query3.sql.add(',copynumber = ' +  inttostr(plateframesdata[iplf].ProdPlates[ipl].Copynumber + extracopyoffset)); // her skal g�res noget
              DataM1.Query3.sql.add(',uniquepage = ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totUniquePage));
              DataM1.Query3.sql.add(',active = ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].active));
              DataM1.Query3.sql.add(',Approved = ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].approved));
              DataM1.Query3.sql.add(',Hold = ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Hold));
              DataM1.Query3.sql.add(',pageindex = ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Pageindex));
              DataM1.Query3.sql.add(',MasterCopySeparationSet = ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].MasterCopySeparationSet));
              DataM1.Query3.sql.add(',GutterImage = 0');
              DataM1.Query3.sql.add(',FlatProofConfigurationID = ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].FlatProofConfigurationID));
              DataM1.Query3.sql.add(',HardProofConfigurationID = ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].HardProofConfigurationID));
              // 20210908   - indicate plan in progress
              DataM1.Query3.sql.add(',HardProofStatus=5');
              IF not Formprodplan.ItsArepair then
              begin
                DataM1.Query3.sql.add(',Sortingposition = ' + '''' + GetPlannameFromID(2, plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].stackpos) + '''');
                DataM1.Query3.sql.add(',presstower = ' + '''' +  Getplantowername(plateframesdata[iplf].ProdPlates[ipl].Tower) + '''');

                if (plateframesdata[iplf].ProdPlates[ipl].TrueFront IN [2, 3]) And (Prefs.UseTrueSheetSide) then
                  DataM1.Query3.sql.add(',Presscylinder = ' + '''' + fronbackstr[plateframesdata[iplf].ProdPlates[ipl].TrueFront - 2] + '''')
                else
                  DataM1.Query3.sql.add(',Presscylinder = ' + '''' + GetPlannameFromID(4, plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Cylinder) + '''');

                DataM1.Query3.sql.add(',presszone = ' + '''' + GetPlannameFromID(5, plateframesdata[iplf].ProdPlates[ipl].Zone) + '''');
                DataM1.Query3.sql.add(',Presshighlow = ' + '''' + GetPlannameFromID(3, plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].High) + '''');
                DataM1.Query3.sql.add(',miscstring1 = ' + '''' + GetPlannameFromID(6, plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Miscstring1) + '''');
              End;

              // ## 20190111 - fixed
              if (Pageformatinpagetable) AND (RipSetupIDInPageTable) then
              begin
                DataM1.Query3.sql.add(',PageFormatID = ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].PageFormatID));
                DataM1.Query3.sql.add(',RipSetupID = ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].RipSetupID));

                if (PressTemplatePageRotationPossible) AND (Global_HasPageCategoryField) then
                  DataM1.Query3.sql.add(',PageCategoryID = ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].PageRotation));
              end;

              DataM1.Query3.sql.add('Where ');
              DataM1.Query3.sql.add('Separation = ' + inttostr(FSeparation));
              DataM1.Query3.sql.add('and FlatSeparation = ' + inttostr(FFlatSeparation));
              IF Prefs.debug then
                DataM1.Query3.sql.SaveToFile
                  (IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'
                  + 'Queryapplypressrun.sql');
              try
                SomethingAlliedorInserted(plateframesproductionid, plateframesdata[iplf].ProdPlates[ipl].runid, plateframespublicationid, plateframesPubdate);
                if not formmain.trysql(DataM1.Query3) then
                begin
                  Anyerrosduringrun := true;
                  plantimdadd('ERROR applyit 1');
                end;
              except
                Anyerrosduringrun := true;
                plantimdadd('ERROR applyit 2');

              end;
            End;
          End;

Var
  prcount: Integer;
  neworgmast: Integer;
  Foundip: Integer;
  curstat: Integer;
  ICPY: Integer;
  ic2: Integer;
  orgstatus, secbtweenL: Integer;
  Incolors: String;
  insertpressrunid: Boolean;
  masterver: Integer;
  masterinputtime: Tdatetime;

  masterfilename: String;
  masterInputID: Integer;
  masterGutterImage: Integer;
  masterint3: Integer;
  masterapproved: Integer;
  masterapproveuser: String;
  masterapprovetime: Tdatetime;

  foundadiffplate, foundsameplate: Boolean;
  DBsectionid, DBpageindex, DBtemplateid: Integer;
  DBPagePositions: string;

  sec1, sec2: Tdatetime;
  secb: Integer;

  totnewpage, totnewprod: Boolean;

  Uniqueonotherpress, notAuniquepage: Boolean;
  thisPressRunID: Integer;
   plateframeindex : Integer;
   ErrorDuringInsert : Boolean;
begin
   ErrorDuringInsert := false;
  try
    aktcopyseparationset := -1;
    thisPressRunID := 0;
    screen.Cursor := crHourGlass;
    plancenteristoold := false;
    Formprodplan.repaint;
    IF NAprodplates < 0 then
      exit;

    formmain.doAhalftimeplanLock;
    lastlocktime := now;

    plateframes[iplf].CustomerID := 0;
    DataM1.Query1.sql.clear;
    DataM1.Query1.sql.add('select distinct customerid from pagetable (NOLOCK)');
    DataM1.Query1.sql.add('Where publicationid = ' + inttostr(plateframespublicationid));
    DataM1.Query1.sql.add(' and ' + DataM1.makedatastr('', plateframesPubdate));
    DataM1.Query1.open;
    if not DataM1.Query1.eof then
      plateframes[iplf].CustomerID := DataM1.Query1.fields[0].asinteger;
    DataM1.Query1.close;

    totnewprod := false;
    DataM1.Query1.sql.clear;
    DataM1.Query1.sql.add('SELECT TOP 1 ProductionID FROM PageTable (NOLOCK) WHERE');
    DataM1.Query1.sql.add('PublicationID = ' + inttostr(plateframesdata[iplf].ProdPlates[0].publicationid));
    IF FormApplyproduction.CheckBoxpressspecifik.checked then
    Begin
      DataM1.Query1.sql.add('AND pressid = ' + inttostr(plateframespressid));
    End;
    DataM1.Query1.sql.add(' AND ' + DataM1.makedatastr('', plateframesPubdate));

    DataM1.Query1.open;
    totnewprod := DataM1.Query1.eof;
    DataM1.Query1.close;

    // Find weeknumber if used
    DataM1.Query1.sql.clear;
    DataM1.Query1.sql.add('SELECT distinct miscint2 from pagetable (NOLOCK)');
    DataM1.Query1.sql.add('Where publicationid = ' + inttostr(plateframespublicationid));
    IF FormApplyproduction.CheckBoxpressspecifik.checked then
    Begin
      DataM1.Query1.sql.add('AND pressid = ' + inttostr(plateframespressid));
    End;
    DataM1.Query1.sql.add(' and ' + DataM1.makedatastr('', plateframesPubdate));
    DataM1.Query1.sql.add(' and miscint2 > 0');
    DataM1.Query1.open;

    if not DataM1.Query1.eof then
    Begin
      FormApplyproduction.ApplyweekNumber := DataM1.Query1.fields[0].asinteger;
      FormApplyproduction.UpDownweek.Position := FormApplyproduction.ApplyweekNumber;
    end;
    DataM1.Query1.close;

    if PartialPlanning then
    begin

      // Inc(NextPartseqnum);
      for ipl := 0 to NAprodplates do
      begin
        plateframesdata[iplf].ProdPlates[ipl].Presssectionnumber := NextPartseqnum + (iplf - 1);
      end;
      // plateframesdata[iplf].prodplates[ipl].runid
    end;

    for ipl := 0 to NAprodplates do
    begin

      if frommain then
      begin
        formmain.ProgressBarmain.StepIt;
      end
      else
      begin
        ProgressBarprod.StepIt;
      end;

      application.ProcessMessages;

      IF plateframesdata[iplf].ProdPlates[ipl].anyuniquepages then
      begin
        IF plateframesdata[iplf].ProdPlates[ipl].Copynumber <> -1 then
        begin
          publIDT := inttostr(plateframesdata[iplf].ProdPlates[ipl].publicationid);
          EdIDT := inttostr(plateframesdata[iplf].ProdPlates[ipl].editionid);
          tmplid := plateframesdata[iplf].ProdPlates[ipl].templatelistid;
          Nup := PlatetemplateArray[tmplid].NupOnplate;
          For ip := 1 to Nup do
          begin
            secIDT := inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].sectionid);
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].FoundAMaster := -1;
            IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype < 3 then
            begin
              firstcolor := true;
              totnewpage := false;
              For ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors do
              begin
                sec1 := now;
                if (not totnewpage) then
                begin
                  if (Editmode = PLANADDMODE_APPLY) and (Not FoundAapplynewpage) and (false) then
                  begin
                    frompressid := plateframespressid;
                    fromlocationid := plateframeslocationid;
                    curstat := plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].status;
                    Foundlevel := 1;
                    FMasterCopySeparationSet := plateframesdata[iplf].ProdPlates[ipl].Pages[ip].MasterCopySeparationSet;
                    FSeparationSet := plateframesdata[iplf].ProdPlates[ipl].Pages[ip].SeparationSet;
                    FCopyFlatSeparationSet := plateframesdata[iplf].ProdPlates[ipl].CopyFlatSeparationSet;
                    FCopySeparationSet := plateframesdata[iplf].ProdPlates[ipl].Pages[ip].CopySeparationSet;
                    FMasterCopySeparationSet := plateframesdata[iplf].ProdPlates[ipl].Pages[ip].MasterCopySeparationSet;
                    FSeparation := plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Separation;
                    FFlatSeparation := plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].FlatSeparation;
                  End
                  Else
                  Begin
                    Foundlevel := findpagerunnig(plateframeslocationid,
                      plateframespressid, plateframesproductionid,
                      plateframesdata[iplf].ProdPlates[ipl].publicationid,
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Oldrunid,
                      plateframesPubdate, plateframesdata[iplf].ProdPlates[ipl].editionid, plateframesdata[iplf].ProdPlates[ipl].Pages[ip].sectionid,
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename,
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].ColorID,
                      plateframesdata[iplf].ProdPlates[ipl].Copynumber + extracopyoffset, // her skal g�res noget
                      iplf, ipl,
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].proofid, frompressid, fromlocationid,
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totUniquePage,
                      FMasterCopySeparationSet,
                      FCopySeparationSet, FSeparationSet, FFlatSeparationSet,
                      FCopyFlatSeparationSet, FSeparation, FFlatSeparation,
                      curstat,
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Hold,
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].approved,
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].proofstatus,
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].fileserver, plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype);
                  End;
                  plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Foundlevel := Foundlevel;
                End
                Else
                begin
                  plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Foundlevel := 2;
                  Foundlevel := 200;
                  firstcolor := false;

                  plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].status := 0;
                  IF fromlocationid <> plateframeslocationid then
                  Begin
                    ApplyRelocationsstatus(iplf, ipl, ip, ic);
                  End
                  else
                  Begin
                    ApplySamelocationstatus(iplf, ipl, ip, ic);
                  End;
                  FCopySeparationSet := aktcopyseparationset;

                  plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Hold := FormApplyproduction.RadioGrouphold.ItemIndex;
                  plateframesdata[iplf].ProdPlates[ipl].Pages[ip].MasterCopySeparationSet := FMasterCopySeparationSet;
                  plateframesdata[iplf].ProdPlates[ipl].CopyFlatSeparationSet := FCopyFlatSeparationSet;
                  plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Separation :=
                      (((FCopySeparationSet * 100)
                      + plateframesdata[iplf].ProdPlates[ipl].Copynumber + extracopyoffset) * 100)
                      + plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].ColorID;
                  plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].FlatSeparation :=
                      (((FCopyFlatSeparationSet * 100) + plateframesdata[iplf].ProdPlates[ipl].Copynumber + extracopyoffset) * 100)
                      + plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].ColorID;
                  plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].approved := FormApplyproduction.RadioGroupapprovalnew.ItemIndex - 1;
                  plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Hold := FormApplyproduction.RadioGrouphold.ItemIndex;

                  Oldappendit(plateframesdata[iplf].ProdPlates[ipl], ip, ic, plateframesdata[iplf].ProdPlates[ipl].Copynumber + extracopyoffset, iplf, firstcolor, aktcopyseparationset, ErrorDuringInsert);
                  if (ErrorDuringInsert) then
                  begin
                     MessageDlg('Error during plan insert operation - see log file for details', mtWarning, [mbOk], 0);
                    exit;
                  end;
                  if plancenteristoold then
                  begin
                    MessageDlg(formmain.InfraLanguage1.Translate ('This PlanCenter is out-of-date. Contact IT to get an update'), mtWarning, [mbOk], 0);
                    exit;
                  end;
                end;

                Case Foundlevel of
                  0:
                    begin // findes slet ikke
                      totnewpage := true;

                      if Not FormApplyproduction.CheckBoxapproveNochange.checked
                      then
                      Begin
                        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].approved :=
                          FormApplyproduction.RadioGroupapprovalnew.ItemIndex - 1;
                      End;

                      if Not FormApplyproduction.CheckBoxholdnochange.checked
                      then
                      Begin
                        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Hold :=
                          FormApplyproduction.RadioGrouphold.ItemIndex;
                      End;

                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].approved :=
                        FormApplyproduction.RadioGroupapprovalnew.ItemIndex - 1;
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Hold :=
                        FormApplyproduction.RadioGrouphold.ItemIndex;

                      Oldappendit(plateframesdata[iplf].ProdPlates[ipl], ip, ic,
                        plateframesdata[iplf].ProdPlates[ipl].Copynumber + extracopyoffset, iplf, firstcolor,
                        aktcopyseparationset, ErrorDuringInsert);

                      if (ErrorDuringInsert) then
                      begin
                         MessageDlg('Error during plan insert operation - see log file for details', mtWarning, [mbOk], 0);
                        exit;
                      end;
                      if plancenteristoold then
                      begin
                        MessageDlg(formmain.InfraLanguage1.Translate
                          ('This plancenter is out of date - contact IT to get an update'),
                          mtInformation, [mbOk], 0);
                        exit;

                      end;

                    end;
                  1:
                    begin // samme findes updater
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].FoundAMaster := FMasterCopySeparationSet;

                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].SeparationSet := FSeparationSet;
                      plateframesdata[iplf].ProdPlates[ipl].CopyFlatSeparationSet := FCopyFlatSeparationSet;
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].CopySeparationSet := FCopySeparationSet;
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].MasterCopySeparationSet := FMasterCopySeparationSet;
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Separation := FSeparation;
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].FlatSeparation := FFlatSeparation;
                      ApplyIt;
                      firstcolor := false;
                      aktcopyseparationset := plateframesdata[iplf].ProdPlates[ipl].Pages[ip].CopySeparationSet;

                    end;
                  2:
                    begin // farven eller kopien findes ikke append
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].FoundAMaster := FMasterCopySeparationSet;
                      aktcopyseparationset := FCopySeparationSet;
                      firstcolor := false;
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].status := curstat;
                      IF fromlocationid <> plateframeslocationid then
                      Begin
                        ApplyRelocationsstatus(iplf, ipl, ip, ic);
                      End
                      else
                      Begin
                        ApplySamelocationstatus(iplf, ipl, ip, ic);
                      End;
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Hold := FormApplyproduction.RadioGrouphold.ItemIndex;

                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].MasterCopySeparationSet := FMasterCopySeparationSet;
                      plateframesdata[iplf].ProdPlates[ipl].CopyFlatSeparationSet := FCopyFlatSeparationSet;
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Separation :=
                        (((FCopySeparationSet * 100)
                        + plateframesdata[iplf].ProdPlates[ipl].Copynumber + extracopyoffset) * 100)
                        + plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].ColorID;
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].FlatSeparation :=
                        (((FCopyFlatSeparationSet * 100) + plateframesdata[iplf].ProdPlates[ipl].Copynumber + extracopyoffset) * 100)
                        +plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].ColorID;

                      IF (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype <> 3) and (Editmode >= PLANADDMODE_APPLY) And
                        (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].active = 0) and (Applyonlyplannedcolors) and
                        (planningaction <> 0) then
                      Begin
                        beep;
                      end
                      else
                        Oldappendit(plateframesdata[iplf].ProdPlates[ipl], ip,
                          ic, plateframesdata[iplf].ProdPlates[ipl].Copynumber +
                          extracopyoffset, iplf, firstcolor,
                          aktcopyseparationset, ErrorDuringInsert);


                      if (ErrorDuringInsert) then
                      begin
                         MessageDlg('Error during plan insert operation - see log file for details', mtWarning, [mbOk], 0);
                        exit;
                      end;

                      if plancenteristoold then
                      begin
                        MessageDlg(formmain.InfraLanguage1.Translate
                          ('This plancenter is out of date contact IT to get an update'),
                          mtInformation, [mbOk], 0);
                        exit;

                      end;

                    end;
                  3:
                    begin // siden findes men til anden presse
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].FoundAMaster := FMasterCopySeparationSet;

                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].status := curstat;
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].MasterCopySeparationSet := FMasterCopySeparationSet;
                      IF fromlocationid <> plateframeslocationid then
                      Begin
                        ApplyRelocationsstatus(iplf, ipl, ip, ic);
                      End
                      else
                      Begin
                        ApplySamelocationstatus(iplf, ipl, ip, ic);
                      End;

                      if Not FormApplyproduction.CheckBoxapproveNochange.checked
                      then
                      Begin
                        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].approved :=FormApplyproduction.RadioGroupapprovalnew.ItemIndex - 1;
                      End;

                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Hold := FormApplyproduction.RadioGrouphold.ItemIndex;

                      Oldappendit(plateframesdata[iplf].ProdPlates[ipl], ip, ic,
                        plateframesdata[iplf].ProdPlates[ipl].Copynumber +
                        extracopyoffset, iplf, firstcolor,
                        aktcopyseparationset, ErrorDuringInsert);

                      if (ErrorDuringInsert) then
                      begin
                         MessageDlg('Error during plan insert operation - see log file for details', mtWarning, [mbOk], 0);
                        exit;
                      end;

                      if plancenteristoold then
                      begin
                        MessageDlg(formmain.InfraLanguage1.Translate
                          ('This plancenter is out of date contact IT to get an update'),
                          mtInformation, [mbOk], 0);
                        exit;

                      end;

                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].MasterCopySeparationSet := FMasterCopySeparationSet;

                      if ((Editmode = PLANADDMODE_COPY) or
                        (Editmode = PLANADDMODE_MOVE)) and
                        (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors
                        [ic].active = 0) then
                      begin
                        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors
                          [ic].Separation :=
                          (((aktcopyseparationset * 100)
                          + plateframesdata[iplf].ProdPlates[ipl].Copynumber + extracopyoffset) * 100)
                          + plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].ColorID;
                        DataM1.Query2.sql.clear;
                        DataM1.Query2.sql.add('update pagetable set active = ' +
                          inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].active));
                        DataM1.Query2.sql.add('where separation = ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Separation));
                        formmain.trysql(DataM1.Query2);
                      End;

                    end;
                End;
              End; // IC
            End
            Else
            begin // dinkie
              firstcolor := true;
              ic := 1;
              Foundlevel := findpagerunnig(plateframeslocationid,
                plateframespressid, plateframesproductionid,
                plateframesdata[iplf].ProdPlates[ipl].publicationid,
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Oldrunid,
                plateframesPubdate,
                plateframesdata[iplf].ProdPlates[ipl].editionid,
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].sectionid,
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename,
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].ColorID,
                plateframesdata[iplf].ProdPlates[ipl].Copynumber + extracopyoffset,
                iplf, ipl,
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].proofid,
                frompressid, fromlocationid,
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totUniquePage,
                FMasterCopySeparationSet,
                FCopySeparationSet, FSeparationSet, FFlatSeparationSet,
                FCopyFlatSeparationSet, FSeparation, FFlatSeparation, curstat,
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Hold,
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].approved,
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].proofstatus,
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].fileserver,
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype);

              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Foundlevel := Foundlevel;
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].approved := -1;
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Hold := 0;
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].RipSetupID := 0;
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].PageFormatID := 0;
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].PageRotation := 0;

              Case Foundlevel of
                0:
                  begin // findes slet ikke
                    Oldappendit(plateframesdata[iplf].ProdPlates[ipl], ip, ic,
                      plateframesdata[iplf].ProdPlates[ipl].Copynumber +
                      extracopyoffset, iplf, firstcolor, aktcopyseparationset, ErrorDuringInsert);

                    if (ErrorDuringInsert) then
                    begin
                       MessageDlg('Error during plan insert operation - see log file for details', mtWarning, [mbOk], 0);
                      exit;
                    end;
                    if plancenteristoold then
                    begin
                      MessageDlg(formmain.InfraLanguage1.Translate
                        ('This plancenter is out of date contact IT to get an update'),
                        mtInformation, [mbOk], 0);
                      exit;

                    end;

                  end;
                1:
                  begin // samme findes updater
                    ApplyIt;
                  end;
                2:
                  begin // farven findes ikke append
                    Oldappendit(plateframesdata[iplf].ProdPlates[ipl], ip, ic,
                        plateframesdata[iplf].ProdPlates[ipl].Copynumber +
                        extracopyoffset, iplf, firstcolor, aktcopyseparationset, ErrorDuringInsert);
                    if (ErrorDuringInsert) then
                    begin
                       MessageDlg('Error during plan insert operation - see log file for details', mtWarning, [mbOk], 0);
                      exit;
                    end;
                    if plancenteristoold then
                    begin
                      MessageDlg(formmain.InfraLanguage1.Translate
                        ('This plancenter is out of date contact IT to get an update'),
                        mtInformation, [mbOk], 0);
                      exit;

                    end;

                  end;
                3:
                  begin
                    Oldappendit(plateframesdata[iplf].ProdPlates[ipl], ip, ic,
                      plateframesdata[iplf].ProdPlates[ipl].Copynumber +
                      extracopyoffset, iplf, firstcolor, aktcopyseparationset, ErrorDuringInsert);
                    if (ErrorDuringInsert) then
                    begin
                       MessageDlg('Error during plan insert operation - see log file for details', mtWarning, [mbOk], 0);
                      exit;
                    end;
                    if plancenteristoold then
                    begin
                      MessageDlg(formmain.InfraLanguage1.Translate
                        ('This plancenter is out of date contact IT to get an update'),
                        mtInformation, [mbOk], 0);
                      exit;

                    end;

                  end;
              End;

            End;
          End; // For IP
        End; // for plateframesdata[iplf].prodplates[ipl].anyuniquepages
      End; // for ipl
      secbtweenL := secondsbetween(now, lastlocktime);

      if secbtweenL > PlanLockTimeoutSec - 10 then
      begin
        formmain.doAhalftimeplanLock;
        lastlocktime := now;
      end;

    end;





    For ipl := 0 to plateframes[iplf].NProdPlates do
    begin
      ProgressBarprod.StepIt;
      application.ProcessMessages;
      IF plateframesdata[iplf].ProdPlates[ipl].anyuniquepages then
      Begin
        tmplid := plateframesdata[iplf].ProdPlates[ipl].templatelistid;
        Nup := PlatetemplateArray[tmplid].NupOnplate;

        for ip := 1 to Nup do
        begin
          if plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype <> 3 then
          Begin
            Foundip := ip;
            break;
          End;
        end;

        CopyFlatSeparationSet := plateframesdata[iplf].ProdPlates[ipl].Pages[Foundip].CopySeparationSet;

        for ip := 1 to Nup do
        begin

          plateframesdata[iplf].ProdPlates[ipl].CopyFlatSeparationSet :=CopyFlatSeparationSet;
          plateframesdata[iplf].ProdPlates[ipl].FlatSeparationSet := (CopyFlatSeparationSet * 100) + 1;

          if plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype = 3 then
          begin
            // start dinky
            ic := 1 { tnames1.Colornametoid('K') };
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
              .FlatSeparation :=
              (plateframesdata[iplf].ProdPlates[ipl].FlatSeparationSet *
              100) + ic;

            DataM1.Query2.sql.clear;
            DataM1.Query2.sql.add('update pagetable set ');
            DataM1.Query2.sql.add
              ('dirty = 0,pagetype = 3, HardProofStatus=0, copyflatseparationset = ' +
              inttostr(CopyFlatSeparationSet) + ',');
            DataM1.Query2.sql.add('flatseparationset = (' +
              inttostr(CopyFlatSeparationSet) + ' * 100)+copynumber  ,');
            DataM1.Query2.sql.add('FlatSeparation = (((cast(' +
              inttostr(CopyFlatSeparationSet) +
              'as bigint) * 100)+copynumber)*100)+colorid');

            DataM1.Query2.sql.add(',fileserver = ' + '''' + plateframesdata
              [iplf].ProdPlates[ipl].Pages[ip].fileserver + '''');
            DataM1.Query2.sql.add(',productionid = ' +
              inttostr(plateframesproductionid));
            DataM1.Query2.sql.add(',templateid = ' +
              inttostr(PlatetemplateArray[tmplid].TemplateID));
            DataM1.Query2.sql.add(',pagesonplate = ' +
              inttostr(PlatetemplateArray[tmplid].NupOnplate));
            DataM1.Query2.sql.add(',pressrunid = ' +
              inttostr(plateframesdata[iplf].ProdPlates[ipl].runid));
            DataM1.Query2.sql.add(',pageposition = ' + inttostr(ip));
            DataM1.Query2.sql.add(',creep = :creep');
            DataM1.Query2.sql.add(',MarkGroups = ' + '''' +
              inittypes.marksIDstr(plateframesdata[iplf].ProdPlates[ipl]
              .Nmarkgroups, plateframesdata[iplf].ProdPlates[ipl]
              .markgroups) + '''');
            IF applydevice > -1 then
            begin
              DataM1.Query2.sql.add(',deviceid = ' + inttostr(applydevice));
            end;
            DataM1.Query2.sql.add('where copyseparationset = ' +
              inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
              .CopySeparationSet));
            DataM1.Query2.sql.add('and copynumber = ' +
              inttostr(plateframesdata[iplf].ProdPlates[ipl].Copynumber +
              extracopyoffset));
            DataM1.Query2.sql.add('and pagename = ' + '''' + plateframesdata
              [iplf].ProdPlates[ipl].Pages[ip].pagename + '''');

            IF Currentcreep <> 0 then
            begin
              DataM1.Query2.ParamByName('creep').AsFloat :=
                (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Creep *
                Currentcreep) / 100;
            end
            else
              DataM1.Query2.ParamByName('creep').AsFloat := 0;

            DataM1.Query2.Prepared := false;
            if not formmain.trysql(DataM1.Query2) then
            begin
              Anyerrosduringrun := true;
              plantimdadd('ERROR Applyplan 0');
            end;

            DataM1.Query2.sql.clear;
            DataM1.Query2.sql.add('update pagetable set ');
            DataM1.Query2.sql.add('pagepositions = ' + '''' +
              pagepositionsfromprodplate(plateframesdata[iplf].ProdPlates[ipl],
              ip) + '''');
            DataM1.Query2.sql.add(',flatseparation = (( (' +
              inttostr(CopyFlatSeparationSet) +
              '*100)+ ((separation/100 )%100) ) *100)+(separation%100)');
            DataM1.Query2.sql.add('where CopySeparationSet  = ' +
              inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
              .CopySeparationSet));
            if not formmain.trysql(DataM1.Query2) then
            begin
              Anyerrosduringrun := true;
              plantimdadd('ERROR Applyplan 1');
            end;
            // End dinky
          end
          else
          Begin
            // NORMAL PAGE
            plateframesdata[iplf].ProdPlates[ipl].CopyFlatSeparationSet := CopyFlatSeparationSet;
            plateframesdata[iplf].ProdPlates[ipl].FlatSeparationSet := (CopyFlatSeparationSet * 100) + 1;
            Incolors := 'and colorid in (';

            For ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors do
            begin
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Separation :=
                (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].SeparationSet * 100)
                + plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].ColorID;
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].FlatSeparation :=
                (plateframesdata[iplf].ProdPlates[ipl].FlatSeparationSet * 100)
                + plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].ColorID;
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Layer
                := plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].FlatSeparation;      /// ?????????????????
              Incolors := Incolors + inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].ColorID) + ',';
            End;
            Incolors[length(Incolors)] := ')';

            DataM1.Query2.sql.clear;
            DataM1.Query2.sql.add('update pagetable set ');

            IF not JustAlayoutchange then
            begin

              IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totUniquePage <> 1 then
              Begin
                IF plateframesdata[plateframesdata[iplf].ProdPlates[ipl].Pages[ip].OrgPageiplf].ProdPlates[plateframesdata[iplf].ProdPlates[ipl].Pages[ip].OrgPageipl].Pages[plateframesdata[iplf].ProdPlates[ipl].Pages[ip].OrgPageip].MasterCopySeparationSet < 1 then
                Begin
                  DataM1.Query3.sql.clear;
                  DataM1.Query3.sql.add('Select distinct mastercopyseparationset from pagetable WITH (NOLOCK) where uniquepage = 1');
                  DataM1.Query3.sql.add('and publicationid = ' +inttostr(plateframespublicationid));
                  DataM1.Query3.sql.add('and ' + DataM1.makedatastr('',plateframesPubdate));
                  DataM1.Query3.sql.add('and Sectionid = ' +  inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].sectionid));
                  DataM1.Query3.sql.add('and pagename = ' + '''' + plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename + '''');
                  DataM1.Query3.open;
                  IF not DataM1.Query3.eof then
                  begin
                    plateframesdata[iplf].ProdPlates[ipl].Pages[ip].MasterCopySeparationSet := DataM1.Query3.fields[0].asinteger;
                    plateframesdata[plateframesdata[iplf].ProdPlates[ipl].Pages[ip].OrgPageiplf].ProdPlates[plateframesdata[iplf].ProdPlates[ipl].Pages[ip].OrgPageipl].Pages[plateframesdata[iplf].ProdPlates[ipl].Pages[ip].OrgPageip].MasterCopySeparationSet :=
                      DataM1.Query3.fields[0].asinteger;
                  end
                  Else
                  Begin
                    plateframesdata[iplf].ProdPlates[ipl].Pages[ip].MasterCopySeparationSet :=
                      plateframesdata[plateframesdata[iplf].ProdPlates[ipl].Pages[ip].OrgPageiplf].ProdPlates[plateframesdata[iplf].ProdPlates[ipl].Pages[ip].OrgPageipl].Pages[plateframesdata[iplf].ProdPlates[ipl].Pages[ip].OrgPageip].CopySeparationSet;
                  End;
                  DataM1.Query3.close;
                end
                else
                Begin
                  IF (Prefs.PartialNoEditionChange) AND (Formprodplan.PartialPlanning) then
                  begin
                  end
                  else
                  begin
                    plateframesdata[iplf].ProdPlates[ipl].Pages[ip].MasterCopySeparationSet :=
                          plateframesdata[plateframesdata[iplf].ProdPlates[ipl].Pages[ip].OrgPageiplf].ProdPlates[plateframesdata[iplf].ProdPlates[ipl].Pages[ip].OrgPageipl].Pages[plateframesdata[iplf].ProdPlates[ipl].Pages[ip].OrgPageip].MasterCopySeparationSet;
                  End;
                End;
                DataM1.Query2.sql.add('mastercopyseparationset = ' +
                  inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                  .MasterCopySeparationSet) + ',');
              End
              else
              begin
                // af en eller anden grund havde jeg ikke bare copyseparationset dette har noget at g�re med at siderne kan v�re fra andet site.

                if not FormApplyproduction.CheckBoxpressspecifik.checked then
                Begin
                  DataM1.Query2.sql.add('mastercopyseparationset = ' +
                    inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                    .MasterCopySeparationSet) + ',')
                End
                else
                Begin
                  DataM1.Query2.sql.add('mastercopyseparationset = ' +
                    inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                    .CopySeparationSet) + ',');
                End;
              end;
            End;

            DataM1.Query2.sql.add('dirty = 0,copyflatseparationset = ' + inttostr(CopyFlatSeparationSet) + ',');
            DataM1.Query2.sql.add('flatseparationset = (' + inttostr(CopyFlatSeparationSet) + ' * 100)+copynumber  ,');
            DataM1.Query2.sql.add('FlatSeparation = (((cast(' + inttostr(CopyFlatSeparationSet) + ' as bigint) * 100)+copynumber)*100)+cast( colorid as bigint)');
            DataM1.Query2.sql.add(',productionid = ' + inttostr(plateframesproductionid));
            DataM1.Query2.sql.add(',fileserver = ' + '''' + plateframesdata[iplf].ProdPlates[ipl].Pages[ip].fileserver + '''');
            DataM1.Query2.sql.add(',Layer = 1');
            DataM1.Query2.sql.add(',templateid = ' + inttostr(PlatetemplateArray[tmplid].TemplateID));
            DataM1.Query2.sql.add(',pagesonplate = ' + inttostr(PlatetemplateArray[tmplid].NupOnplate));
            DataM1.Query2.sql.add(',pressrunid = ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].runid));
            DataM1.Query2.sql.add(',pageposition = ' + inttostr(ip));
            DataM1.Query2.sql.add(',pagepositions = ' + '''' + pagepositionsfromprodplate(plateframesdata[iplf].ProdPlates[ipl], ip) + '''');
            DataM1.Query2.sql.add(',creep = :creep');
            DataM1.Query2.sql.add(',MarkGroups = ' + '''' + inittypes.marksIDstr(plateframesdata[iplf].ProdPlates[ipl].Nmarkgroups, plateframesdata[iplf].ProdPlates[ipl].markgroups) + '''');



            IF applydevice > -1 then
            begin
              DataM1.Query2.sql.add(',deviceid = ' + inttostr(applydevice));
            end;
            DataM1.Query2.sql.add('where copyseparationset = ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].CopySeparationSet));
            // medcopynumber
            if not Copytopressdontshowapply then
              DataM1.Query2.sql.add(Incolors);
            DataM1.Query2.sql.add('and copynumber = ' +
              inttostr(plateframesdata[iplf].ProdPlates[ipl].Copynumber +
              extracopyoffset));
            DataM1.Query2.sql.add('and pagename = ' + '''' + plateframesdata
              [iplf].ProdPlates[ipl].Pages[ip].pagename + '''');
            if Currentcreep <> 0 then
              DataM1.Query2.ParamByName('creep').AsFloat :=
                (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Creep *
                Currentcreep) / 100
            else
              DataM1.Query2.ParamByName('creep').AsFloat := 0;

            if Prefs.debug then
              DataM1.Query2.sql.SaveToFile
                (IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) +
                'sqllogs\' + 'updatepagetableset.sql');

            if not formmain.trysql(DataM1.Query2) then
            begin
              Anyerrosduringrun := true;
              plantimdadd('ERROR Applyplan 2');
            end;
          end; // end of ikke dink
        End; // for ip
      end; // plateframesdata[iplf].prodplates[ipl].anyuniquepages
    end; // for ipl



    // s�tter status, anden master baseret data

    For iplf := 1 to Nplateframes do
    begin
      For ipl := 0 to plateframes[iplf].NProdPlates do
      begin
        IF plateframesdata[iplf].ProdPlates[ipl].anyuniquepages then
        Begin
          if ipl <= plateframesdata[iplf].Aktsize then
          begin
            for ip := 1 to PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
            begin

              Uniqueonotherpress :=
                ((plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                .totUniquePage = 1) and
                (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].FoundAMaster >
                -1) and (not FormApplyproduction.CheckBoxpressspecifik.
                checked));

              notAuniquepage :=
                (plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                .totUniquePage <> 1);

              if (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype < 3)
              then
              begin
                OrgPageiplf := plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                  .OrgPageiplf;
                OrgPageipl := plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                  .OrgPageipl;
                OrgPageip := plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                  .OrgPageip;
                IF OrgPageiplf < 1 then
                Begin
                  OrgPageiplf := 1;
                  plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                    .OrgPageiplf := 1;
                End;
                IF OrgPageip = 0 then
                  OrgPageip := 1;

                OrgCopySeparationSet := plateframesdata[OrgPageiplf].ProdPlates
                  [OrgPageipl].Pages[OrgPageip].CopySeparationSet;

                IF notAuniquepage or Uniqueonotherpress then
                begin
                  For ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                    .Ncolors do
                  begin
                    masterver := 0;
                    DataM1.Query1.sql.clear;
                    DataM1.Query1.sql.add
                      ('select Status,ProofStatus,Version,FileServer,InputTime,filename,InputID,GutterImage,miscint3,locationid,approved,ApproveTime,ApproveUser from pagetable WITH (NOLOCK) where ');
                    DataM1.Query1.sql.add
                      (' colorid = ' + inttostr(plateframesdata[iplf].ProdPlates
                      [ipl].Pages[ip].colors[ic].ColorID));
                    DataM1.Query1.sql.add('and status > 0');
                    DataM1.Query1.sql.add('and uniquepage = 1');
                    DataM1.Query1.sql.add('and copynumber = 1');

                    IF notAuniquepage then
                    begin
                      DataM1.Query1.sql.add('and copyseparationset = ' +
                        inttostr(OrgCopySeparationSet));
                      // her kan evt bruges if Uniqueonotherpress or plateframesdata[iplf].prodplates[ipl].Pages[ip].FoundAMaster
                    end;

                    if Uniqueonotherpress then
                    begin
                      DataM1.Query1.sql.add('and mastercopyseparationset = ' +
                        inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                        .FoundAMaster));
                    end;

                    formmain.Tryopen(DataM1.Query1);

                    IF not DataM1.Query1.eof then
                    begin
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                        .status := DataM1.Query1.fields[0].asinteger;

                      if plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors
                        [ic].status > 30 then
                        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors
                          [ic].status := 30;

                      if DataM1.Query1.fields[9].asinteger <> plateframeslocationid
                      then
                      begin
                        if plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                          .colors[ic].status > 10 then
                          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors
                            [ic].status := 10;
                      end;

                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                        .proofstatus := DataM1.Query1.fields[1].asinteger;

                      masterver := DataM1.Query1.fields[2].asinteger;

                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].fileserver
                        := DataM1.Query1.fields[3].asstring;

                      masterinputtime := DataM1.Query1.fields[4].AsDateTime;

                      masterfilename := DataM1.Query1.fields[5].asstring;
                      masterInputID := DataM1.Query1.fields[6].asinteger;
                      masterGutterImage := DataM1.Query1.fields[7].asinteger;
                      masterint3 := DataM1.Query1.fields[8].asinteger;
                      masterapproved := DataM1.Query1.fields[10].asinteger;
                      masterapprovetime := DataM1.Query1.fields[11].AsDateTime;
                      masterapproveuser := DataM1.Query1.fields[12].asstring;
                      DataM1.Query1.close;

                      DataM1.Query2.sql.clear;
                      DataM1.Query2.sql.add('update pagetable set');
                      DataM1.Query2.sql.add('status = ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].status));
                      DataM1.Query2.sql.add(',proofstatus = ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].proofstatus));
                      DataM1.Query2.sql.add(',version = ' + inttostr(masterver));
                      DataM1.Query2.sql.add(',fileserver = ' + '''' + plateframesdata[iplf].ProdPlates[ipl].Pages[ip].fileserver + '''');
                      DataM1.Query2.sql.add(',inputtime = :inputtime');
                      DataM1.Query2.sql.add(',filename = ' + '''' +masterfilename + '''');
                      DataM1.Query2.sql.add(',InputID = ' + inttostr(masterInputID));
                      DataM1.Query2.sql.add(',GutterImage = ' +inttostr(masterGutterImage));
                      DataM1.Query2.sql.add(',miscint3 = ' + inttostr(masterint3));
                      DataM1.Query2.sql.add(',Approved = ' + inttostr(masterapproved));
                      DataM1.Query2.sql.add(',ApproveTime = :approvetime');
                      DataM1.Query2.sql.add(',ApproveUser = ' + '''' +masterapproveuser + '''');

                      DataM1.Query2.sql.add('where copyseparationset = ' +inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].CopySeparationSet));
                      DataM1.Query2.sql.add('and colorid = ' +inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].ColorID));

                      DataM1.Query2.ParamByName('inputtime').AsDateTime := masterinputtime;
                      DataM1.Query2.ParamByName('approvetime').AsDateTime := masterapprovetime;

                      formmain.trysql(DataM1.Query2);
                    end;
                  End;
                End;
              end;
            End;
          End;
        end;
      End;
    End;
    if (not usingpdfplan) and (Currentblackcolorid > -1) and
      (FormApplyproduction.CheckBoxractivateonlyblack.checked) then
    begin
      DataM1.Query2.sql.clear;
      DataM1.Query2.sql.add('update pagetable set');
      DataM1.Query2.sql.add('active = 0');
      DataM1.Query2.sql.add('Where productionid = ' +inttostr(plateframesproductionid));
      DataM1.Query2.sql.add('and status = 0 and colorid <> ' + inttostr(Currentblackcolorid));
      DataM1.Query2.sql.add('and colorid-50 <> ' + inttostr(Currentblackcolorid));
      DataM1.Query2.sql.add('and pagetype <> 3');
      DataM1.Query2.sql.add('and colorid <> ' + inttostr(tnames1.PDFCOLORID));
      if Prefs.debug then
        DataM1.Query2.sql.SaveToFile
          (IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'
          + 'deactivecolors.sql');
      if not formmain.trysql(DataM1.Query2) then
      begin
        Anyerrosduringrun := true;
        plantimdadd('ERROR Applyplan 3');
      end;
    end;

    DataM1.Query2.sql.clear;
    DataM1.Query2.sql.add('Select distinct pressrunid from pagetable WITH (NOLOCK) where productionid = ' + inttostr(plateframesproductionid));
    DataM1.Query2.sql.add('order by pressrunid');
    if not formmain.Tryopen(DataM1.Query2) then
    begin
      Anyerrosduringrun := true;
      plantimdadd('ERROR Applyplan 4');
    end;
    While not DataM1.Query2.eof do
    begin
      thisPressRunID := DataM1.Query2.fields[0].asinteger;
      DataM1.Query1.sql.clear;
      DataM1.Query1.sql.add('Select pressrunid from pressrunid WITH (NOLOCK) ');
      DataM1.Query1.sql.add('Where pressrunid = ' + inttostr(thisPressRunID));
      formmain.Tryopen(DataM1.Query1);
      insertpressrunid := DataM1.Query1.eof;
      DataM1.Query1.close;

      IF insertpressrunid then
      begin
        DataM1.Query1.sql.clear;
        IF DBVersion > 1 then
        Begin
          DataM1.Query1.sql.add('Insert PressRunID (PressRunID,SequenceNumber,PriorityBeforeHottime,PriorityDuringHottime,PriorityAfterHottime,PriorityHottimeBegin,PriorityHottimeEnd,Comment,UsePressTowerInfo,OrderNumber,InkComment,perfectbound,Inserted,Backwards,');
          DataM1.Query1.sql.add('Planname,Presssystem,Plantype,TimedEditionfrom,TimedEditionto,TimedEditionState,planversion)');
        End
        else
        begin
          DataM1.Query1.sql.add('Insert PressRunID (PressRunID,SequenceNumber,PriorityBeforeHottime,PriorityDuringHottime,PriorityAfterHottime,PriorityHottimeBegin,PriorityHottimeEnd,Comment,UsePressTowerInfo,OrderNumber,InkComment,perfectbound,Inserted,Backwards)');
        end;
        DataM1.Query1.sql.add('Values (');
        DataM1.Query1.sql.add(inttostr(thisPressRunID) + ',');
        DataM1.Query1.sql.add(inttostr(iplf) + ',');
        DataM1.Query1.sql.add(FormApplyproduction.EditbeforeH.Text + ',');
        DataM1.Query1.sql.add(FormApplyproduction.Editduringh.Text + ',');
        DataM1.Query1.sql.add(FormApplyproduction.EditAfterh.Text + ',');
        DataM1.Query1.sql.add(':PriorityHottimeBegin,');
        DataM1.Query1.sql.add(':PriorityHottimeEnd,');
        DataM1.Query1.sql.add('''' + plateframes[iplf].Comment + '''' + ',');
        DataM1.Query1.sql.add(inttostr(Integer(FormApplyproduction.CheckBoxUsepresstowerconf.checked)) + ',');
       // DataM1.Query1.sql.add('''' + plateframes[iplf].Inkcomment + '''' + ',');
        DataM1.Query1.sql.add('''' + plateframes[iplf].order + '''' + ',');
        DataM1.Query1.sql.add('''' + plateframes[iplf].Inkcomment + '''' + ',');
        DataM1.Query1.sql.add(inttostr(plateframes[iplf].perfecktbound) + ',');
        DataM1.Query1.sql.add(inttostr(plateframes[iplf].inserted) + ',');
        IF DBVersion > 1 then
        Begin
          DataM1.Query1.sql.add(inttostr(plateframes[iplf].Backwards) + ',');
          DataM1.Query1.sql.add('''' + plateframesLoadedname + '''' + ',');
          DataM1.Query1.sql.add('''' + plateframes[iplf].presssystemname + '''' + ',');
          DataM1.Query1.sql.add(inttostr(1) + ','); // plantype
          DataM1.Query1.sql.add(inttostr(0) + ','); // TimedEditionfrom
          DataM1.Query1.sql.add(inttostr(0) + ','); // TimedEditionto
          DataM1.Query1.sql.add(inttostr(0) + ',1)');
          // TimedEditionState,planversion

        End
        Else
        begin
          DataM1.Query1.sql.add(inttostr(plateframes[iplf].Backwards) + ')');
        end;
        IF FormApplyproduction.DateTimePickerhotdatestart.checked then
        begin
          DataM1.Query1.ParamByName('PriorityHottimeBegin').AsDateTime :=
            EncodeDateTime
            (yearof(FormApplyproduction.DateTimePickerhotdatestart.Date),
            monthof(FormApplyproduction.DateTimePickerhotdatestart.Date),
            Dayof(FormApplyproduction.DateTimePickerhotdatestart.Date),
            0, 0, 0, 0);
          DataM1.Query1.ParamByName('PriorityHottimeEnd').AsDateTime :=
            EncodeDateTime
            (yearof(FormApplyproduction.DateTimePickerhotdateend.Date),
            monthof(FormApplyproduction.DateTimePickerhotdateend.Date),
            Dayof(FormApplyproduction.DateTimePickerhotdateend.Date),
            0, 0, 0, 0);
        End
        Else
        begin
          DataM1.Query1.ParamByName('PriorityHottimeBegin').AsDateTime :=
            EncodeDateTime(1975, 1, 1, 0, 0, 0, 0);
          DataM1.Query1.ParamByName('PriorityHottimeEnd').AsDateTime :=
            EncodeDateTime(1975, 2, 1, 0, 0, 0, 0);
        end;

        if Prefs.debug then
          DataM1.Query1.sql.SaveToFile
            (IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) +
            'sqllogs\' + 'Insertpresssectionnumber.sql');

        if not formmain.trysql(DataM1.Query1) then
        begin
          Anyerrosduringrun := true;
          plantimdadd('ERROR Applyplan 5');
        end;
      End
      else
      begin

      end;
      DataM1.Query2.next;
    end;
    DataM1.Query2.close;

  Finally

  End;
end;

procedure TFormprodplan.ApplyRelocationsstatus(iplf, ipl, ip, ic: Integer);
Begin
  Case plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].status of
    0 .. 9:
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].status := 0;
    10 .. 100:
      Begin
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].status := 10;
      end;
  end;
end;

procedure TFormprodplan.ActionexitExecute(Sender: TObject);
begin
  Formprodplan.close;
end;

procedure TFormprodplan.Editeditiontoplanpages(cursectionI: Integer;
  halfwebpage1: String; halfwebpage2: string);
Var
  // Ipage,I,
  isec
  // ied,iflat,
  // isgn
    : Integer;
  // Npresssec,
  // nsection,npage,ncolor
  // : ttreenode;
  T: string;
  ip
  // ,nh,Nup
    : Integer;
  IPBExListviewSections
  // ,ispl
    , nispl, npinisec: Integer;
  // numberofsections  : Integer;
  np, nis, iis
  // ,ipoffset
    : Integer;
  aktcombsec: string;
  pplus, pofspl, coveroffset, insertoffset, fromtop, topI, akttop,
    namedoffset: Integer;

  newed: Boolean;
  Aktpresssecionnumber, pagina, aktedid, aktsecid: Integer;

Begin
  Aktpresssecionnumber := 0;
  np := 0;
  aktcombsec := '';

  iis := 0;
  planpagenames[cursectionI].Npages := 0;

  planpagenames[cursectionI].newedition := true;
  np := 0;

  for isec := 0 to Formeditedition.PBExListviewSections.items.count - 1 do
  begin
    T := Formeditedition.PBExListviewSections.items[isec].subitems[0];
    npinisec := Formeditedition.npagestrtonpages(T, nispl);
    planpagenames[cursectionI].Npages := planpagenames[cursectionI].Npages
      + npinisec;
    planpagenames[cursectionI].Nhalfwebpage := 0;
  End;

  for isec := 0 to Formeditedition.PBExListviewSections.items.count - 1 do
  begin
    Inc(Aktpresssecionnumber);
    T := Formeditedition.PBExListviewSections.items[isec].subitems[0];
    npinisec := Formeditedition.npagestrtonpages(T, nispl);
    planpagenames[cursectionI].Pages[0].name := 'Dinky';
    planpagenames[cursectionI].Pages[0].seci := isec;
    planpagenames[cursectionI].Pages[0].sectionid :=
      tnames1.sectionnametoid(Formeditedition.PBExListviewSections.items
      [isec].Caption);

    coveroffset := StrToInt(Formeditedition.PBExListviewSections.items[isec]
      .subitems[3]) div 2;
    namedoffset := 0;

    IF (Formeditedition.PBExListviewSections.items[isec].subitems[6] <> '') then
    Begin
      coveroffset := 0;
      namedoffset := StrToInt(Formeditedition.PBExListviewSections.items[isec]
        .subitems[3]) div 2;
    End;

    insertoffset := StrToInt(Formeditedition.PBExListviewSections.items[isec]
      .subitems[4]) + coveroffset;
    np := 0;
    if isec = Formeditedition.PBExListviewSections.items.count - 1 then
      nis := (Formeditedition.Commastrlist[1])
    Else
      nis := (Formeditedition.Commastrlist[1]) div 2;

    For ip := 1 to nis do
    begin
      Inc(iis);
      Inc(np);
      pofspl := np;
      IF iis < planpagenames[cursectionI].Npages div 2 then
      Begin
        pofspl := pofspl + coveroffset;
      end;
      IF iis > planpagenames[cursectionI].Npages div 2 then
      Begin
        pofspl := pofspl + insertoffset;
      End;

      planpagenames[cursectionI].Pages[iis].name :=
        Formeditedition.PBExListviewSections.items[isec].subitems[1] + inttostr(pofspl + StrToInt(Formeditedition.PBExListviewSections.items[isec].subitems[5])) + Formeditedition.PBExListviewSections.items[isec].subitems[2];

      planpagenames[cursectionI].Pages[iis].Pageindex := pofspl + StrToInt(Formeditedition.PBExListviewSections.items[isec].subitems[5]);
      planpagenames[cursectionI].Pages[iis].seci := isec;
      planpagenames[cursectionI].Pages[iis].sectionid := tnames1.sectionnametoid(Formeditedition.PBExListviewSections.items[isec].Caption);
      planpagenames[cursectionI].Pages[iis].presssecionnumber := Aktpresssecionnumber;

      IF (planpagenames[cursectionI].Pages[iis].name = halfwebpage1) or
        (planpagenames[cursectionI].Pages[iis].name = halfwebpage2) then
      begin
        IF planpagenames[cursectionI].hw1 = 0 then
          planpagenames[cursectionI].hw1 := iis
        Else
          planpagenames[cursectionI].hw2 := iis;
      end;
    end;
  End;

  for isec := Formeditedition.PBExListviewSections.items.count - 2 downto 0 do
  begin
    T := Formeditedition.PBExListviewSections.items[isec].subitems[0];
    npinisec := Formeditedition.npagestrtonpages(T, nispl);
    planpagenames[cursectionI].Pages[0].name := 'Dinky';

    planpagenames[cursectionI].Pages[0].seci := isec;
    planpagenames[cursectionI].Pages[0].sectionid :=
      tnames1.sectionnametoid(Formeditedition.PBExListviewSections.items
      [isec].Caption);

    coveroffset := StrToInt(Formeditedition.PBExListviewSections.items[isec].subitems[3]) div 2;
    namedoffset := 0;
    IF (FormAddpressrun.PBExListviewSections.items[isec].subitems[6] <> '') then
    Begin
      coveroffset := 0;
      namedoffset := StrToInt(FormAddpressrun.PBExListviewSections.items[isec].subitems[3]) div 2;
    End;
    insertoffset := StrToInt(Formeditedition.PBExListviewSections.items[isec].subitems[4]) + coveroffset;

    nis := (Formeditedition.Commastrlist[1]) div 2;
    np := nis;
    For ip := 1 to nis do
    begin
      Inc(iis);
      Inc(np);
      pofspl := np;
      IF iis < planpagenames[cursectionI].Npages div 2 then
      Begin
        pofspl := pofspl + coveroffset;
      end;

      IF iis > planpagenames[cursectionI].Npages div 2 then
      Begin
        pofspl := pofspl + insertoffset;
      End;

      planpagenames[cursectionI].Pages[iis].name :=
        Formeditedition.PBExListviewSections.items[isec].subitems[1] +
        inttostr(pofspl + StrToInt(Formeditedition.PBExListviewSections.items
        [isec].subitems[5])) + Formeditedition.PBExListviewSections.items[isec]
        .subitems[2];
      planpagenames[cursectionI].Pages[iis].Pageindex := pofspl +
        StrToInt(Formeditedition.PBExListviewSections.items[isec].subitems[5]);
      planpagenames[cursectionI].Pages[iis].seci := isec;
      planpagenames[cursectionI].Pages[iis].sectionid :=
        tnames1.sectionnametoid(Formeditedition.PBExListviewSections.items
        [isec].Caption);
      IF (planpagenames[cursectionI].Pages[iis].name = halfwebpage1) or
        (planpagenames[cursectionI].Pages[iis].name = halfwebpage2) then
      begin
        IF planpagenames[cursectionI].hw1 = 0 then
          planpagenames[cursectionI].hw1 := iis
        Else
          planpagenames[cursectionI].hw2 := iis;
      end;
    end;
  End;

End;

Procedure TFormprodplan.Editplantoplates(iplf: Integer; templatelistid: Integer;
  proofid: Integer; Nmarkgroups: Integer; markgroups: marksarray);

  Function getplansectionname(isec: Integer): Integer;
  Var
    T: string;
  Begin
    T := Formeditedition.PBExListviewSections.items[isec].Caption;
    result := tnames1.sectionnametoid(T);
  end;

Var
  ic, Iplateframe, ied, iflat, ifront, outp, sheet, isgn: Integer;
  nSections, NEditions, nplates: Integer;
  Nsheet: Integer;
  Sectioncounter: Integer;
  I: Integer;
  pagetypes: TPageNumbering;
  antipanoposes: TPageNumbering;
  Nnewcolors: Integer;
  NProdPlates: Integer;

  icopy: Integer;
  Newcolors: Array [1 .. 100] of record ColorID: Integer;
  colorname: String;
  Doubleburn: Boolean;
end;

// Akteditionname : string;
Nprodcount, Aktncopies: Integer;

Currunid:
Integer;

Begin // NprodplatesSize
  ied := 0;
  try
    IF CheckBoxsmallimagesinEdit.checked then
      Pressviewzoom := 60
    else
      Pressviewzoom := 100;

    plateviewimage.Width := 23; // 204
    plateviewimage.Height := 51; // 176

    Nnewcolors := 0;
    Currunid := plateframesdata[iplf].ProdPlates[0].runid;
    for I := 0 to Formeditedition.CheckListBoxcolors.items.count - 1 do
    begin
      if Formeditedition.CheckListBoxcolors.checked[I] then
      begin
        Inc(Nnewcolors);
        Newcolors[Nnewcolors].ColorID :=
          tnames1.Colornametoid(Formeditedition.CheckListBoxcolors.items[I]);
        Newcolors[Nnewcolors].colorname :=
          Formeditedition.CheckListBoxcolors.items[I];
        Newcolors[Nnewcolors].Doubleburn := false;
      end;
    end;

    nplates := 0;
    Nsheet := 0;
    Sectioncounter := 0;

    Numberofhalfweb := 0;
    sheet := 0;
    Inc(Sectioncounter);
    IF (Sectioncounter = nSections) or (ied = 0) then
    begin
      Inc(ied);
      Sectioncounter := 0;
    end;

    // Akteditionname := Formeditionpageplan.StringGrideds.cells[Ied,0];

    // Aktncopies := plateframesdata[iplf].prodplates[0].Ncopies;
    Aktncopies := plateframes[iplf].Numberofcopies;
    plateframes[iplf].NProdPlates := -1;

    Nprodcount := (AktPRODUCTION.aSections[iplf].nFlatsInSection *
      Aktncopies) * 2;

    if Nplateframes > 1 then
    begin
      For I := 1 to Nplateframes do
      begin
        IF I <> iplf then
        begin
          if Nprodcount < plateframes[I].NProdPlates then
            Nprodcount := plateframes[I].NProdPlates;
        end;
      end;
    end;

    formmain.Allocateprodplates(iplf, Nprodcount + 32);

    For iflat := 1 to AktPRODUCTION.aSections[iplf].nFlatsInSection do
    begin
      Inc(sheet);
      for icopy := 1 to Aktncopies do
      begin

        Inc(plateframes[iplf].NProdPlates);
        NProdPlates := plateframes[iplf].NProdPlates;
        plateframesdata[iplf].ProdPlates[NProdPlates].sheetnumber := sheet;
        plateframesdata[iplf].ProdPlates[NProdPlates].Front := 0;
        plateframesdata[iplf].ProdPlates[NProdPlates].TrueFront := 0;
        plateframesdata[iplf].ProdPlates[NProdPlates].templatelistid :=
          templatelistid;
        plateframesdata[iplf].ProdPlates[NProdPlates].markgroups := markgroups;
        plateframesdata[iplf].ProdPlates[NProdPlates].Nmarkgroups :=
          Nmarkgroups;

        plateframesdata[iplf].ProdPlates[NProdPlates].Copynumber := icopy;
        // plateframesdata[iplf].prodplates[Nprodplates].Ncopies  := Aktncopies;

        plateframesdata[iplf].ProdPlates[NProdPlates].productionid := 0;
        plateframesdata[iplf].ProdPlates[NProdPlates].publicationid :=
          plateframespublicationid;

        plateframesdata[iplf].ProdPlates[NProdPlates].Locationid :=
          plateframeslocationid;
        plateframesdata[iplf].ProdPlates[NProdPlates].deviceid := 0;
        plateframesdata[iplf].ProdPlates[NProdPlates].Pressid :=
          plateframespressid;
        plateframesdata[iplf].ProdPlates[NProdPlates].runid := Currunid;
        plateframesdata[iplf].ProdPlates[NProdPlates].produce := false;
        plateframesdata[iplf].ProdPlates[NProdPlates].readytoproduce := false;
        plateframesdata[iplf].ProdPlates[NProdPlates].someerror := false;
        plateframesdata[iplf].ProdPlates[NProdPlates].totappr := 0; // s�t
        plateframesdata[iplf].ProdPlates[NProdPlates].totstat := 0; // s�t
        plateframesdata[iplf].ProdPlates[NProdPlates].editionid :=
          planpagenames[iplf].editionid;

        For isgn := 1 to AktPRODUCTION.aSections[iplf].aFlats[iflat]
          .nPagesPerSide do // front
        Begin
          IF AktPRODUCTION.aSections[iplf].aFlats[iflat].aOutputPages[isgn] = 0
          then
          begin
            Inc(Numberofhalfweb);
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .pagetype := 3;
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn].pagename
              := 'Dinkey' + inttostr((iplf * 100) + Numberofhalfweb);
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .Ncolors := 0;
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .Oldrunid := -1;
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .PageRotation := 0;
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .RipSetupID := 0;
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .PageFormatID := 0;
          end
          else
          Begin
            plateframesdata[iplf].ProdPlates[NProdPlates].Presssectionnumber :=
              planpagenames[iplf].Pages
              [AktPRODUCTION.aSections[iplf].aFlats[iflat].aOutputPages[isgn]]
              .presssecionnumber;

            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn].pagename
              := planpagenames[iplf].Pages
              [AktPRODUCTION.aSections[iplf].aFlats[iflat].aOutputPages
              [isgn]].name;

            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn].pagina :=
              planpagenames[iplf].Pages
              [AktPRODUCTION.aSections[iplf].aFlats[iflat].aOutputPages
              [isgn]].pagina;

            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn].Pageindex
              := planpagenames[iplf].Pages
              [AktPRODUCTION.aSections[iplf].aFlats[iflat].aOutputPages[isgn]]
              .Pageindex;

            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .PageRotation := 0;
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .RipSetupID := 0;
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .PageFormatID := 0;

            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn].sectionid
              := getplansectionname(planpagenames[iplf].Pages
              [AktPRODUCTION.aSections[iplf].aFlats[iflat].aOutputPages
              [isgn]].seci);
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .Oldrunid := -1;
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .totapproval := 0;
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .Anyheld := false;
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .Antipanorama := 0;
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .pagetype := 0;
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn].Creep :=
              AktPRODUCTION.aSections[iplf].aFlats[iflat].aCreep[isgn];
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn].Ncolors :=
              Nnewcolors;
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .pagestatus := 0;
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .proofed := false;
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .approved := 0;
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .pagechange := false;

            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .Orgeditionid := planpagenames[iplf].Pages
              [AktPRODUCTION.aSections[iplf].aFlats[iflat].aOutputPages[isgn]]
              .Orgeditionid;

            IF plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .Orgeditionid = plateframesdata[iplf].ProdPlates[NProdPlates].editionid
            then
            Begin
              plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
                .totUniquePage := 1;
              plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
                .MasterCopySeparationSet := plateframesdata[iplf].ProdPlates
                [NProdPlates].Pages[isgn].CopySeparationSet;
            end
            else
            begin
              plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates]
                .Pages[isgn].totUniquePage := 0;
            end;

            For ic := 1 to Nnewcolors do
            begin
              plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn].colors
                [ic].ColorID := Newcolors[ic].ColorID;
              plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn].colors
                [ic].DoubleBurned := Newcolors[ic].Doubleburn;
              plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn].colors
                [ic].Copynumber := icopy;
              plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn].colors
                [ic].Uniquepage := plateframesdata[iplf].ProdPlates[NProdPlates]
                .Pages[isgn].totUniquePage;
              plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn].colors
                [ic].active := 1;
              plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn].colors
                [ic].status := 0;
              plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn].colors
                [ic].proofstatus := 0;
              plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn].colors
                [ic].Priority := 50;
              plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn].colors
                [ic].Hold := 0;
              plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn].colors
                [ic].stackpos := -1;
              plateframesdata[iplf].ProdPlates[NProdPlates].Tower := -1;
              plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn].colors
                [ic].High := -1;
              plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn].colors
                [ic].Cylinder := -1;
              plateframesdata[iplf].ProdPlates[NProdPlates].Zone := -1;
            end;
          End;
        End;
      End;
      for icopy := 1 to Aktncopies do
      begin

        // back

        Inc(plateframes[iplf].NProdPlates);
        NProdPlates := plateframes[iplf].NProdPlates;
        plateframesdata[iplf].ProdPlates[NProdPlates].editionid :=
          planpagenames[iplf].editionid;

        plateframesdata[iplf].ProdPlates[NProdPlates].sheetnumber := sheet;
        plateframesdata[iplf].ProdPlates[NProdPlates].Front := 1;
        plateframesdata[iplf].ProdPlates[NProdPlates].TrueFront := 1;
        plateframesdata[iplf].ProdPlates[NProdPlates].templatelistid :=
          templatelistid;
        plateframesdata[iplf].ProdPlates[NProdPlates].Copynumber := icopy;
        // plateframesdata[iplf].prodplates[Nprodplates].Ncopies := aktncopies;

        plateframesdata[iplf].ProdPlates[NProdPlates].productionid := 0;
        plateframesdata[iplf].ProdPlates[NProdPlates].publicationid :=
          plateframespublicationid;
        plateframesdata[iplf].ProdPlates[NProdPlates].Locationid :=
          plateframeslocationid;
        plateframesdata[iplf].ProdPlates[NProdPlates].deviceid := 0;
        plateframesdata[iplf].ProdPlates[NProdPlates].Pressid :=
          plateframespressid;
        plateframesdata[iplf].ProdPlates[NProdPlates].runid := Currunid;
        plateframesdata[iplf].ProdPlates[NProdPlates].produce := false;
        plateframesdata[iplf].ProdPlates[NProdPlates].readytoproduce := false;
        plateframesdata[iplf].ProdPlates[NProdPlates].someerror := false;
        plateframesdata[iplf].ProdPlates[NProdPlates].totappr := 0;
        plateframesdata[iplf].ProdPlates[NProdPlates].totstat := 0;

        For isgn := 1 to AktPRODUCTION.aSections[iplf].aFlats[iflat]
          .nPagesPerSide do
        Begin
          IF AktPRODUCTION.aSections[iplf].aFlats[iflat].aOutputPages
            [isgn + AktPRODUCTION.aSections[iplf].aFlats[iflat].nPagesPerSide] = 0
          then
          begin
            Inc(Numberofhalfweb);
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .pagetype := 3;
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn].pagename
              := 'Dinkey' + inttostr((iplf * 100) + Numberofhalfweb);
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .Ncolors := 1;
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .Oldrunid := -1;
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .PageRotation := 0;
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .RipSetupID := 0;
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .PageFormatID := 0;
          end
          else
          Begin
            plateframesdata[iplf].ProdPlates[NProdPlates].Presssectionnumber :=
              planpagenames[iplf].Pages
              [AktPRODUCTION.aSections[iplf].aFlats[iflat].aOutputPages
              [isgn + AktPRODUCTION.aSections[iplf].aFlats[iflat].nPagesPerSide]
              ].presssecionnumber;

            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn].pagename
              := planpagenames[iplf].Pages
              [AktPRODUCTION.aSections[iplf].aFlats[iflat].aOutputPages
              [isgn + AktPRODUCTION.aSections[iplf].aFlats[iflat]
              .nPagesPerSide]].name;

            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn].pagina :=
              planpagenames[iplf].Pages
              [AktPRODUCTION.aSections[iplf].aFlats[iflat].aOutputPages
              [isgn + AktPRODUCTION.aSections[iplf].aFlats[iflat]
              .nPagesPerSide]].pagina;

            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn].Pageindex
              := planpagenames[iplf].Pages
              [AktPRODUCTION.aSections[iplf].aFlats[iflat].aOutputPages
              [isgn + AktPRODUCTION.aSections[iplf].aFlats[iflat].nPagesPerSide]
              ].Pageindex;

            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn].sectionid
              := getplansectionname(planpagenames[iplf].Pages
              [AktPRODUCTION.aSections[iplf].aFlats[iflat].aOutputPages
              [isgn + AktPRODUCTION.aSections[iplf].aFlats[iflat]
              .nPagesPerSide]].seci);

            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .totapproval := 0;
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .Oldrunid := -1;
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .Anyheld := false;
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .Antipanorama := 0;
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .pagetype := 0;
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn].Creep :=
              AktPRODUCTION.aSections[iplf].aFlats[iflat].aCreep
              [isgn + AktPRODUCTION.aSections[iplf].aFlats[iflat]
              .nPagesPerSide];
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn].Ncolors :=
              Nnewcolors;
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .pagestatus := 0;
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .proofed := false;
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .approved := 0;
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .pagechange := false;

            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .PageRotation := 0;
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .RipSetupID := 0;
            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .PageFormatID := 0;

            plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .Orgeditionid := planpagenames[iplf].Pages
              [AktPRODUCTION.aSections[iplf].aFlats[iflat].aOutputPages
              [isgn + AktPRODUCTION.aSections[iplf].aFlats[iflat].nPagesPerSide]
              ].Orgeditionid;

            IF plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
              .Orgeditionid = plateframesdata[iplf].ProdPlates
              [plateframes[iplf].NProdPlates].editionid then
            Begin
              plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
                .totUniquePage := 1;
              plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
                .MasterCopySeparationSet := plateframesdata[iplf].ProdPlates
                [NProdPlates].Pages[isgn].CopySeparationSet;
            end
            else
              plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn]
                .totUniquePage := 0;

            For ic := 1 to Nnewcolors do
            begin

              plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn].colors
                [ic].ColorID := Newcolors[ic].ColorID;
              plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn].colors
                [ic].DoubleBurned := Newcolors[ic].Doubleburn;
              plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn].colors
                [ic].Copynumber := icopy;
              plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn].colors
                [ic].Uniquepage := plateframesdata[iplf].ProdPlates[NProdPlates]
                .Pages[isgn].totUniquePage;
              plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn].colors
                [ic].active := 1;
              plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn].colors
                [ic].status := 0;
              plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn].colors
                [ic].proofstatus := 0;
              plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn].colors
                [ic].Priority := 50;
              plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn].colors
                [ic].Hold := 0;
              plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn].colors
                [ic].stackpos := -1;
              plateframesdata[iplf].ProdPlates[NProdPlates].Tower := -1;
              plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn].colors
                [ic].High := -1;
              plateframesdata[iplf].ProdPlates[NProdPlates].Pages[isgn].colors
                [ic].Cylinder := -1;
              plateframesdata[iplf].ProdPlates[NProdPlates].Zone := -1;
            end;

          End;
        End;
      End; // Icopies
    End;

  except
  end;
end;

procedure TFormprodplan.ActionediteditionRunExecute(Sender: TObject);
Var
  iplf
  // ,iplf2
    , ipl, ip, ic
  // ,i2
    : Integer;
  isec: Integer;
  Nsecs: Integer;
  atemplatelistid: Integer;
  Newmarkgroups: marksarray;
  secs: array [1 .. 100] of record sectionid: Integer;
  Npages: Integer;
  firstpage: string; // index
  lastpage: string; // index
  Ninsert: Integer;
  lastindex: Integer;
  Firstindex: Integer;
  Splitrun: Boolean;
  Ncover: Integer;
end;
aproofid, asec: Integer;
L:
TListItem;
Samesec, Useplit, useoffset: Boolean;
Totnpages, Firstseciplf, Aktiplf, aktsectionid: Integer;
Secmode:
Integer;

Currunid:
Integer;
// plateframesdata[RunNumber].prodplates[0].runid
begin
  aproofid := 0;
  Useplit := false;
  useoffset := false;
  Samesec := false;

  Aktiplf := Editthisrun;
  atemplatelistid := plateframesdata[Aktiplf].ProdPlates[0].templatelistid;
  aktsectionid := plateframesdata[Aktiplf].ProdPlates[0].Pages[1].sectionid;
  Currunid := plateframesdata[Aktiplf].ProdPlates[0].runid;

  IF Nplateframes > 1 then
  begin
    For iplf := 1 to Nplateframes do
    begin
      IF (Aktiplf <> iplf) and
        (plateframesdata[iplf].ProdPlates[0].Pages[1].sectionid = aktsectionid)
      then
      begin
        Samesec := true;
        break;
      end;
    End;
    Totnpages := 0;
    Firstseciplf := -1;
    For iplf := 1 to Nplateframes do
    begin
      if plateframesdata[iplf].ProdPlates[0].Pages[1].sectionid = aktsectionid
      then
      begin
        IF Firstseciplf < 0 then
          Firstseciplf := iplf;
        Inc(Totnpages, planpagenames[iplf].Npages);
      end;
    End;

    IF planpagenames[Firstseciplf].Pages[planpagenames[Firstseciplf].Npages]
      .Pageindex = planpagenames[Firstseciplf].Npages then
      useoffset := true;

    IF (not useoffset) and (Samesec) then
    begin
      if planpagenames[Firstseciplf].Pages[planpagenames[Firstseciplf].Npages]
        .Pageindex = Totnpages then
        Useplit := true;
    end;

  End;

  copyplantoplanpages;
  For isec := 1 to 100 do
  begin
    secs[isec].sectionid := -1;
    secs[isec].Npages := 0;
    secs[isec].firstpage := '';
    secs[isec].lastpage := '';
    secs[isec].Ninsert := 0;
    secs[isec].lastindex := 0;
    secs[isec].Firstindex := 0;
    secs[isec].Ncover := 0;
  end;
  Formeditedition.PBExListviewSections.items.clear;

  Nsecs := 0;

  asec := -1;
  For ip := 1 to planpagenames[Aktiplf].Npages do
  begin
    IF Nsecs = 0 then
    Begin
      Inc(Nsecs);
      secs[Nsecs].sectionid := planpagenames[Aktiplf].Pages[ip].sectionid;
    End;

    For isec := 1 to Nsecs do
    begin
      IF secs[isec].sectionid = planpagenames[Aktiplf].Pages[ip].sectionid then
        break;
    End;
    IF secs[isec].sectionid <> planpagenames[Aktiplf].Pages[ip].sectionid then
    begin
      Inc(Nsecs);
      secs[Nsecs].sectionid := planpagenames[Aktiplf].Pages[ip].sectionid;
      isec := Nsecs;
    end;

    IF secs[isec].Npages = 0 then
    Begin
      secs[isec].firstpage := planpagenames[Aktiplf].Pages[ip].name;
      secs[isec].Firstindex := planpagenames[Aktiplf].Pages[ip].Pageindex;
    End;
    Inc(secs[isec].Npages);
    secs[isec].lastpage := planpagenames[Aktiplf].Pages[ip].name;

    IF planpagenames[Aktiplf].Pages[ip].Pageindex > secs[isec].lastindex + 1
    then
    Begin
      secs[isec].Ninsert := (planpagenames[Aktiplf].Pages[ip].Pageindex -
        secs[isec].lastindex) - 1;
    End;
    secs[isec].lastindex := planpagenames[Aktiplf].Pages[ip].Pageindex;

    IF secs[isec].Firstindex > 1 then
      secs[isec].Ncover := (secs[isec].Firstindex - 1) * 2;

  end;

  Secmode := 2;
  IF Useplit then
    Secmode := 1;
  IF useoffset then
    Secmode := 2;

  // WG
  // Secmode := 1;

  For isec := 1 to Nsecs do
  begin
    Case Secmode of
      0:
        begin
          secs[isec].Firstindex := 0;
        end;
      1:
        begin
          secs[isec].Firstindex := 0;
        end;
      2:
        begin
          IF secs[isec].Firstindex > 0 then
            secs[isec].Firstindex := secs[isec].Firstindex - 1;
          secs[isec].Ncover := 0;
          secs[isec].Ninsert := 0;
        end;
    end;
  End;
  IF not Samesec then
  begin
    secs[isec].Firstindex := 0;
  end;
  For isec := 1 to Nsecs do
  begin
    L := Formeditedition.PBExListviewSections.items.add;
    L.Caption := tnames1.sectionIDtoname(secs[isec].sectionid);
    L.subitems.add(inttostr(secs[isec].Npages));
    L.subitems.add('');
    L.subitems.add('');
    L.subitems.add(inttostr(secs[isec].Ncover));
    L.subitems.add(inttostr(secs[isec].Ninsert));
    L.subitems.add(inttostr(secs[isec].Firstindex));
    L.subitems.add('');
    L.subitems.add('');
  end;

  Formeditedition.CheckBoxbindingstyle.checked := plateframes[Aktiplf].perfecktbound = 1;

  // ## NAN 20160309
  // Formeditedition.CheckBoxbackward.checked := plateframes[Aktiplf].Backwards = 1;

  Formeditedition.Aktpressid := plateframespressid;
  Formeditedition.akttemplateListid := plateframesdata[Aktiplf].ProdPlates[0]
    .templatelistid;
  if Formeditedition.ShowModal = mrok then
  begin
    For ip := 1 to 64 do
    begin
      if plateframesdata[Aktiplf].ProdPlates[0].Pages[ip].pagetype <> 3 then
      begin
        aproofid := plateframesdata[Aktiplf].ProdPlates[0].Pages[ip].proofid;
        break;
      end;
    end;
    For ipl := 0 to plateframes[Aktiplf].NProdPlates do
    begin

      plateframesdata[Aktiplf].ProdPlates[ipl].templatelistid :=
        inittypes.gettemplatelistnumberfromname
        (Formeditedition.ComboBoxplatelayout.Text);
    End;
    For ipl := 0 to plateframes[Aktiplf].NProdPlates do
    begin
      for ip := 1 to PlatetemplateArray[plateframesdata[Aktiplf].ProdPlates[ipl]
        .templatelistid].NupOnplate do
      begin
        IF plateframesdata[Aktiplf].ProdPlates[ipl].Pages[ip].pagetype = 1 then
        begin
          plateframesdata[Aktiplf].ProdPlates[ipl].Pages[ip].pagetype := 0;
        End;

        IF plateframesdata[Aktiplf].ProdPlates[ipl].Pages[ip].pagetype = 2 then
        begin
          plateframesdata[Aktiplf].ProdPlates[ipl].Pages[ip].pagetype := 0;
          IF plateframesdata[Aktiplf].ProdPlates[ipl].Pages[ip].Ncolors <> 0
          then
          begin
            For ic := 1 to plateframesdata[Aktiplf].ProdPlates[ipl].Pages[ip]
              .Ncolors do
            Begin
              plateframesdata[Aktiplf].ProdPlates[ipl].Pages[ip].colors[ic]
                .active := 1;
            end;
          End;
        End;
      End;
    End;

    Editeditiontoplanpages(Aktiplf, '', '');
    doreimposecalc(plateframesdata[Aktiplf].ProdPlates[0].templatelistid, true);

    calulatepagina;
    Editplantoplates(Aktiplf, plateframesdata[Aktiplf].ProdPlates[0]
      .templatelistid, aproofid, plateframesdata[Aktiplf].ProdPlates[0]
      .Nmarkgroups, plateframesdata[Aktiplf].ProdPlates[0].markgroups);

    applyglobdata(1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, Newmarkgroups);
    loadplatedatafromdb(Aktiplf, true);

    For ipl := 0 to plateframes[Aktiplf].NProdPlates do
    begin
      for ip := 1 to PlatetemplateArray[plateframesdata[Aktiplf].ProdPlates[ipl]
        .templatelistid].NupOnplate do
      begin
        IF plateframesdata[Aktiplf].ProdPlates[ipl].Pages[ip].pagetype = 1 then
        begin
          plateframesdata[Aktiplf].ProdPlates[ipl].Pages[ip].pagetype := 0;
        End;

        IF plateframesdata[Aktiplf].ProdPlates[ipl].Pages[ip].pagetype = 2 then
        begin
          plateframesdata[Aktiplf].ProdPlates[ipl].Pages[ip].pagetype := 0;
          IF plateframesdata[Aktiplf].ProdPlates[ipl].Pages[ip].Ncolors <> 0
          then
          begin
            For ic := 1 to plateframesdata[Aktiplf].ProdPlates[ipl].Pages[ip]
              .Ncolors do
            Begin
              plateframesdata[Aktiplf].ProdPlates[ipl].Pages[ip].colors[ic]
                .active := 1;
            end;
          End;
        End;
      End;
    End;

    findorgedpages;
    copyplantoplanpages;

    checkuponhwafteredit;

    for iplf := 1 to Nplateframes do
    begin
      IF CheckBoxsmallimagesinEdit.checked then
        Pressviewzoom := 60
      else
        Pressviewzoom := 100;

      plateviewimage.Width := 23; // 204
      plateviewimage.Height := 51; // 176

      DrawThePlates(CheckBoxsmallimagesinEdit.checked, iplf);
    end;
  end;
end;

Procedure TFormprodplan.LoadPlateDataFromDB(iplf: Integer;
  resetpagetype: Boolean);
Var
  ipl, ip, ic: Integer;
  Foundpage, foundcolor: Boolean;
begin
  DataM1.Query1.sql.clear;
  DataM1.Query1.sql.add
    ('Select pagename,SectionID,sheetnumber,sheetside,copyflatseparationset,flatseparationset,colorid,pagepositions from pagetable (NOLOCK)');
  DataM1.Query1.sql.add('where pressid = ' + inttostr(plateframespressid));
  DataM1.Query1.sql.add('and pressrunid = ' +
    inttostr(plateframes[iplf].pressrunid));
  DataM1.Query1.sql.add('and locationid = ' + inttostr(plateframeslocationid));
  DataM1.Query1.sql.add('and ' + DataM1.makedatastr('', plateframesPubdate));
  DataM1.Query1.sql.add
    ('order by sheetnumber,sheetside,copyflatseparationset,flatseparationset,colorid,pagepositions');
  formmain.Tryopen(DataM1.Query1);
  While not DataM1.Query1.eof do
  begin
    For ipl := 0 to plateframes[iplf].NProdPlates do
    begin
      for ip := 1 to PlatetemplateArray
        [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
      begin
        IF (DataM1.Query1.fields[0].asstring = plateframesdata[iplf].ProdPlates
          [ipl].Pages[ip].pagename) and
          (DataM1.Query1.fields[1].asinteger = plateframesdata[iplf].ProdPlates
          [ipl].Pages[ip].sectionid) then
        Begin
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors := 0;
        End;
      end;
    end;
    DataM1.Query1.next;
  End;
  DataM1.Query1.close;

  For ipl := 0 to plateframes[iplf].NProdPlates do
  begin
    for ip := 1 to PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl]
      .templatelistid].NupOnplate do
    begin
      IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors <> 0 then
      begin
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totUniquePage := 1;
        For ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
          .Ncolors do
        begin
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
            .Uniquepage := 1;
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
            .status := 0;
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
            .proofstatus := 0;
        end;
      end;
    End;
  End;

  formmain.Tryopen(DataM1.Query1);
  While not DataM1.Query1.eof do
  begin
    For ipl := 0 to plateframes[iplf].NProdPlates do
    begin
      for ip := 1 to PlatetemplateArray
        [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
      begin
        IF (DataM1.Query1.fieldbyname('pagename').asstring = plateframesdata
          [iplf].ProdPlates[ipl].Pages[ip].pagename) and
          (DataM1.Query1.fieldbyname('SectionID').asinteger = plateframesdata
          [iplf].ProdPlates[ipl].Pages[ip].sectionid) then
        Begin
          Inc(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors);
          ic := plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors;
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
            .MasterCopySeparationSet := DataM1.Query1.fieldbyname
            ('mastercopyseparationset').asinteger;

          plateframesdata[iplf].ProdPlates[ipl].templatelistid :=
            inittypes.gettemplatenumberfromID
            (DataM1.Query1.fieldbyname('templateID').asinteger);
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].ColorID :=
            DataM1.Query1.fieldbyname('colorID').asinteger;
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].proofid :=
            DataM1.Query1.fieldbyname('proofid').asinteger;
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Uniquepage
            := DataM1.Query1.fieldbyname('UniquePage').asinteger;
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totUniquePage :=
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
            .Uniquepage;
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].active :=
            DataM1.Query1.fieldbyname('active').asinteger;

          if (RipSetupIDInPageTable) then
          begin
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].PageRotation :=
              DataM1.Query1.fieldbyname('PageCategoryID').asinteger;
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].RipSetupID :=
              DataM1.Query1.fieldbyname('RipSetupID').asinteger;
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].PageFormatID :=
              DataM1.Query1.fieldbyname('PageFormatID').asinteger;
          end
          else
          begin
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].PageRotation := 0;
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].RipSetupID := 0;
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].PageFormatID := 0;
          end;

          IF resetpagetype then
          begin
            if DataM1.Query1.fieldbyname('pagetype').asinteger = 1 then
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype := 0;

            if DataM1.Query1.fieldbyname('pagetype').asinteger = 2 then
            begin
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype := 0;
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                .active := 1;
            end;
          end;

          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].approved :=
            DataM1.Query1.fieldbyname('Approved').asinteger;
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].proofstatus
            := DataM1.Query1.fieldbyname('Proofstatus').asinteger;
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Priority :=
            DataM1.Query1.fieldbyname('priority').asinteger;
          plateframesdata[iplf].ProdPlates[ipl].Tower :=
            SetplanTowername(DataM1.Query1.fieldbyname('pressTower').asstring);
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].stackpos :=
            SetPlanIDFromname(2, DataM1.Query1.fieldbyname('sortingposition')
            .asstring);
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].High :=
            SetPlanIDFromname(3, DataM1.Query1.fieldbyname('pressHighlow')
            .asstring);
          IF (DataM1.Query1.fieldbyname('pressCylinder').asstring = fronbackstr
            [0]) or (DataM1.Query1.fieldbyname('pressCylinder')
            .asstring = fronbackstr[1]) then
          Begin
            IF DataM1.Query1.fieldbyname('pressCylinder')
              .asstring = fronbackstr[0] then
              plateframesdata[iplf].ProdPlates[ipl].TrueFront := 2
            else
              plateframesdata[iplf].ProdPlates[ipl].TrueFront := 3;
          End
          else
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Cylinder
              := SetPlanIDFromname(4, DataM1.Query1.fieldbyname('pressCylinder')
              .asstring);
          plateframesdata[iplf].ProdPlates[ipl].Zone :=
            SetPlanIDFromname(5, DataM1.Query1.fieldbyname('pressZone')
            .asstring);
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].status :=
            DataM1.Query1.fieldbyname('status').asinteger;
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Hold :=
            DataM1.Query1.fieldbyname('Hold').asinteger;

          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].CopySeparationSet :=
            DataM1.Query1.fieldbyname('CopySeparationSet').asinteger;
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].SeparationSet :=
            (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].CopySeparationSet *
            100) + plateframesdata[iplf].ProdPlates[ipl].Copynumber;
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Separation
            := (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].SeparationSet *
            100) + plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors
            [ic].ColorID;
        End;
      end;
    end;
    DataM1.Query1.next;
  End;
  DataM1.Query1.close;

  DataM1.Query1.sql.clear;
  DataM1.Query1.sql.add
    ('select distinct p1.pagename,p1.mastercopyseparationset,p1.editionid,p2.editionid,p2.mastercopyseparationset,p2.copyseparationset from pagetable p1 WITH (NOLOCK), pagetable p2 WITH (NOLOCK) ');
  DataM1.Query1.sql.add
    ('where p1.uniquepage <> 1 and p2.uniquepage = 1 and p1.mastercopyseparationset = p2.mastercopyseparationset');
  formmain.Tryopen(DataM1.Query1);
  while not DataM1.Query1.eof do
  begin
    for ipl := 0 to plateframes[iplf].NProdPlates do
    begin
      for ip := 1 to PlatetemplateArray
        [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
      begin
        IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totUniquePage <> 1
        then
        begin
          IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
            .MasterCopySeparationSet = DataM1.Query1.fields[1].asinteger then
          begin
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Orgeditionid :=
              DataM1.Query1.fields[3].asinteger;
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].OrgCopySeparationSet
              := DataM1.Query1.fields[5].asinteger;
          end;
        end;
      end;
    end;
    DataM1.Query1.next;
  end;
  DataM1.Query1.close;

end;

procedure TFormprodplan.ActionSetuniquepageExecute(Sender: TObject);
Var
  Il, iplf, ipl, ip, ic: Integer;
  ail, T, t1: string;
  akttop: Integer;

begin
  ail := '-1';
  akttop := PBExListview1.TopItem.Index;
  For Il := 0 to PBExListview1.items.count - 1 do
  begin
    IF PBExListview1.items[Il].Selected then
    begin
      T := PBExListview1.items[Il].subitems[21];
      t1 := copy(T, 1, POS(',', T) - 1);
      iplf := StrToInt(t1);
      delete(T, 1, POS(',', T));
      t1 := copy(T, 1, POS(',', T) - 1);
      ipl := StrToInt(t1);
      delete(T, 1, POS(',', T));
      t1 := copy(T, 1, POS(',', T) - 1);
      ip := StrToInt(t1);
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totUniquePage := 1;
      // nymast
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].MasterCopySeparationSet :=
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].CopySeparationSet;

      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Orgeditionid :=
        plateframesdata[iplf].ProdPlates[ipl].editionid;
      For ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors do
      Begin
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
          .Uniquepage := 1;
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Orgeditionid
          := plateframesdata[iplf].ProdPlates[ipl].editionid;
      End;
    End;
  End;
  makepagelist(PBExListview1, akttop);
end;

procedure TFormprodplan.Setbluebar;

  procedure Gradient(Col1, Col2: TColor; Bmp: tbitmap);
  type
    PixArray = array [1 .. 3] of Byte;
  var
    I, big, rdiv, gdiv, bdiv, h, w: Integer;
    ts: TStringList;
    p: ^PixArray;
  begin
    rdiv := GetRValue(Col1) - GetRValue(Col2);
    gdiv := GetgValue(Col1) - GetgValue(Col2);
    bdiv := GetbValue(Col1) - GetbValue(Col2);

    Bmp.PixelFormat := pf24Bit;

    for h := 0 to Bmp.Height - 1 do
    begin
      p := Bmp.ScanLine[h];
      for w := 0 to Bmp.Width - 1 do
      begin
        p^[1] := GetbValue(Col1) - Round((h / Bmp.Height) * bdiv);
        p^[2] := GetgValue(Col1) - Round((h / Bmp.Height) * gdiv);
        p^[3] := GetRValue(Col1) - Round((h / Bmp.Height) * rdiv);
        Inc(p);
      end;
    end;
  end;

Var
  I: Integer;
  Foundit: Boolean;
begin

  exit;

end;

procedure TFormprodplan.MakeInSectionIds;
Var
  iplf, ip, I, ipl: Integer;
  found: Boolean;
  Ninsectionids: Integer;
  insectionids: array [1 .. 100] of Integer;
Begin
  Ninsectionids := 0;

  For iplf := 1 to Nplateframes do
  begin
    For ipl := 0 to plateframes[iplf].NProdPlates do
    begin
      for ip := 1 to PlatetemplateArray
        [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
      begin
        found := false;
        For I := 1 to Ninsectionids do
        begin
          IF insectionids[I] = plateframesdata[iplf].ProdPlates[ipl].Pages[ip].sectionid
          then
          begin
            found := true;
            break;
          end;
        end;
        if (not found) and (Ninsectionids < 99) then
        begin
          Inc(Ninsectionids);
          insectionids[Ninsectionids] := plateframesdata[iplf].ProdPlates[ipl]
            .Pages[ip].sectionid;
        end;
      End;
    End;
  End;
  Insectionidsstr := '';
  IF Ninsectionids > 0 then
  begin
    Insectionidsstr := 'and SectionID IN (';
    For I := 1 to Ninsectionids do
    begin
      Insectionidsstr := Insectionidsstr + inttostr(insectionids[I]) + ',';
    End;
    Insectionidsstr[length(Insectionidsstr)] := ')';
  end;

End;

procedure TFormprodplan.ActioncenterspreadExecute(Sender: TObject);
Var
  orgedid, Orgiplf: Integer;
  iplf, ip, I, ipl, ic,Imasterstoset: Integer;
  found: Boolean;
  pagetypes: TPageNumbering;
  aktipairpos: Integer;
  antipairpos: Integer;
  Nmasterstoset: Integer;
  masterstoset: Array [1 .. 64] of record
              iplf: Integer;
              ipl: Integer;
              ip: Integer;
              pagetype :Integer;
            end;

Begin
  // Ninsectionids := 0;
  found := false;
  ipl := 0;

  For iplf := 1 to Nplateframes do
  begin
    if plateframes[iplf].Selected then
    begin

      IF plateframes[iplf].PBExListview1.Selected <> nil then
      begin
        ipl := plateframes[iplf].PBExListview1.Selected.Index;
        ipl := Formprodplan.ImagenumbertoIPL(iplf, plateframes[iplf].PBExListview1.Selected.Index);
        found := true;
      end;

      if found then
        break;
    End;
  End;

  Nmasterstoset := 0;
  IF (found) and (PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl]
    .templatelistid].NupOnplate > 1) then
  begin
    Formplancenterspread.CheckListBox1.items.clear;
    for ip := 1 to PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl]
      .templatelistid].NupOnplate do
    begin
      IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype <> 3 then
      begin
        Formplancenterspread.CheckListBox1.items.add(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename);
        Formplancenterspread.CheckListBox1.checked[Formplancenterspread.CheckListBox1.items.count - 1] := plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype = 1;
      End

    End;

    IF Formplancenterspread.ShowModal = mrok then
    begin
      orgedid := plateframesdata[iplf].ProdPlates[ipl].editionid;
      Orgiplf := iplf;
      for aktipairpos := 1 to PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
      Begin
        IF plateframesdata[iplf].ProdPlates[ipl].Pages[aktipairpos].pagetype <> 3
        then
        Begin
          plateframesdata[iplf].ProdPlates[ipl].Pages[aktipairpos].pagetype := 0;
          setothercopies(iplf, ipl);
        End;
      End;

      for I := 0 to Formplancenterspread.CheckListBox1.items.count - 1 do
      begin
        if Formplancenterspread.CheckListBox1.checked[I] then
        begin
          for aktipairpos := 1 to PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
          Begin
            IF plateframesdata[iplf].ProdPlates[ipl].Pages[aktipairpos].pagename = Formplancenterspread.CheckListBox1.items[I] then
            begin
              antipairpos := formmain.Supergetantipos(aktipairpos, pagetypes, plateframesdata[iplf].ProdPlates[ipl].templatelistid, true);
              plateframesdata[iplf].ProdPlates[ipl].Pages[aktipairpos].pagetype := 1;

              plateframesdata[iplf].ProdPlates[ipl].Pages[antipairpos].pagetype := 2;

              // ### 20210302
              for ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[antipairpos].Ncolors do
              begin
                plateframesdata[iplf].ProdPlates[ipl].Pages[antipairpos].colors[ic].active := 0;
              end;

              setothercopies(iplf, ipl);
            End;
          End;
        end;

        for ip := 1 to PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
        Begin
          IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype <> 3 then
          begin
            Inc(Nmasterstoset);
            masterstoset[Nmasterstoset].iplf := iplf;
            masterstoset[Nmasterstoset].ipl := ipl;
            masterstoset[Nmasterstoset].ip := ip;
            masterstoset[Nmasterstoset].pagetype := plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype;
          end;
        End;
      end;
    end;
    Actionplaterefresh.Execute;
  end;
end;

Procedure TFormprodplan.SetActionEnabled;
Var
  anyselectedplateframe: Boolean;
  anyselectedplate: Boolean;
  anyselectedpage: Boolean;
  iplf, ipl, I: Integer;

  procedure freemode; // wizard or open
  begin

    ActionWizard.Enabled := true;
    ActionSave.Enabled := Nplateframes > 0;
    ActionLoad.Enabled := true;

    ActionPlancopypage.Enabled := anyselectedplate;
    ActionPlanpastpage.Enabled := anyselectedplate;

    ActionRun.Enabled := Nplateframes > 0;
    Actionclear.Enabled := true;
    Actionplaaddcons.Enabled := true;
    ActionSetuniquepages.Enabled := Nplateframes > 0;
    Actioncopyadd.Enabled := Nplateframes > 0;
    Actioncopydelete.Enabled := Nplateframes > 0;
    ActionCombine.Enabled := Nplateframes > 0;
    // popup plate
    Actionhalfweb.Enabled := anyselectedplate;
    Actioncommon.Enabled := anyselectedplate;
    Actioneditcolors.Enabled := anyselectedplate;
    Actionlayout.Enabled := anyselectedplate;
    Actioncenterspread.Enabled := anyselectedplate;
    Actionsinglespread.Enabled := anyselectedplate;
    ActionediteditionRun.Enabled := anyselectedplateframe;
    (*
      if not anyselectedplateframe then
      beep;
    *)
    // popup page
    Actionpagepagenamenameedit.Enabled := anyselectedpage;
    Actionpagestackpos.Enabled := anyselectedpage;
    Actionpagetower.Enabled := anyselectedpage;
    Actionpagecylinder.Enabled := anyselectedpage;
    Actionpagezone.Enabled := anyselectedpage;
    ActionpageHighlow.Enabled := anyselectedpage;
    ActionSetuniquepage.Enabled := anyselectedpage;
  end;

  procedure restrictedmode;
  begin
    ActionWizard.Enabled := false;
    ActionSave.Enabled := Nplateframes > 0;
    ActionLoad.Enabled := true;

    ActionRun.Enabled := Nplateframes > 0;
    Actionclear.Enabled := false;
    ActionSetuniquepages.Enabled := Nplateframes > 0;
    Actioncopyadd.Enabled := Nplateframes > 0;
    Actioncopydelete.Enabled := Nplateframes > 0;

    // popup plate
    Actionhalfweb.Enabled := anyselectedplate;
    Actioncommon.Enabled := anyselectedplate;
    Actioneditcolors.Enabled := anyselectedplate;
    Actionlayout.Enabled := anyselectedplate;
    Actioncenterspread.Enabled := anyselectedplate;
    Actionsinglespread.Enabled := anyselectedplate;
    ActionediteditionRun.Enabled := false;
    ActionCombine.Enabled := Nplateframes > 0;
    // popup page
    Actionpagepagenamenameedit.Enabled := anyselectedpage;
    Actionpagestackpos.Enabled := anyselectedpage;
    Actionpagetower.Enabled := anyselectedpage;
    Actionpagecylinder.Enabled := anyselectedpage;
    Actionpagezone.Enabled := anyselectedpage;
    ActionpageHighlow.Enabled := anyselectedpage;
    ActionSetuniquepage.Enabled := anyselectedpage;
  end;

  procedure Veryrestrictedmode;
  Begin

    ActionRun.Enabled := true;
    ActionMovepages.Enabled := true;
    Actionhalfweb.Enabled := anyselectedplate;
    Actionplatemark.Enabled := true;
    Actionplanflatproof.Enabled := true;
    Actionplanproofing.Enabled := true;
    Actionplantower.Enabled := true;
    Actionswappages.Enabled := true;
    Actionswapfrontback.Enabled := true;
    ActionaddSheet.Enabled := true;
    Actionpopuppresssysname.Enabled := true;
    ActionRemoveSheet.Enabled := true;

    ActionWizard.Enabled := false;
    ActionSave.Enabled := false;
    ActionLoad.Enabled := false;
    Actionclear.Enabled := false;
    ActionSetuniquepages.Enabled := false;
    Actioncommon.Enabled := false;

    Actioncopyadd.Enabled := false;
    Actioncopydelete.Enabled := false;
    Actionplaaddcons.Enabled := false;
    ActionCombine.Enabled := false;
    ActionediteditionRun.Enabled := false;

    ActionPlancopypage.Enabled := false;
    ActionPlanpastpage.Enabled := false;
    Actioneditpages.Enabled := false;

  End;

begin
  try
    IF Not Activated then
      exit;
    if not Formprodplan.Showing then
      exit;
    anyselectedplateframe := false;
    anyselectedplate := false;
    anyselectedpage := false;
    IF Nplateframes > 0 then
    begin
      For iplf := 1 to Nplateframes do
      begin
        If plateframes[iplf].Selected then
          anyselectedplateframe := true;
        IF not anyselectedplate then
        begin
          For ipl := 0 to plateframes[iplf].PBExListview1.items.count - 1 do
          begin
            if plateframes[iplf].PBExListview1.items[ipl].Selected then
            begin
              anyselectedplate := true;
              break;
            end;
          End;
        End;
      end;
    end;

    For I := 0 to PBExListview1.items.count - 1 do
    begin
      if PBExListview1.items[I].Selected then
      begin
        anyselectedpage := true;
        break;
      end;
    end;

    // main
    ActionWizard.Enabled := false;
    ActionSave.Enabled := false;
    ActionLoad.Enabled := false;

    ActionRun.Enabled := false;
    Actionclear.Enabled := false;
    ActionSetuniquepages.Enabled := false;
    Actioncopyadd.Enabled := false;
    Actioncopydelete.Enabled := false;

    // popup plate
    Actionhalfweb.Enabled := false;
    Actioncommon.Enabled := false;
    Actioneditcolors.Enabled := false;
    Actionlayout.Enabled := false;
    Actioncenterspread.Enabled := false;
    Actionsinglespread.Enabled := false;
    ActionediteditionRun.Enabled := false;

    // popup page
    Actionpagepagenamenameedit.Enabled := false;
    Actionpagestackpos.Enabled := false;
    Actionpagetower.Enabled := false;
    Actionpagecylinder.Enabled := false;
    Actionpagezone.Enabled := false;
    ActionpageHighlow.Enabled := false;
    ActionSetuniquepage.Enabled := false;
    {
      //0 just open, 1 edit mode, 2 wizard mode,
      3 copymode, 4 movemode, 5 applymode
      anyselectedplateframe
      anyselectedplate
      anyselectedpage
    }

    Case Editmode of
      0:
        Begin
          freemode; // wizard or open
        end;
      2:
        Begin
          freemode; // wizard or open
        end;

      1:
        Begin
          // editmode
          restrictedmode;
          ActionediteditionRun.Enabled := anyselectedplateframe;

        end;
      3 .. 4:
        Begin
          // main
          restrictedmode;
        end;
      5:
        Begin
          freemode; // wizard or open
        end;
    end;

    IF planningaction = 6 then
    begin
      Veryrestrictedmode;

    end;

  except
  End;

end;

procedure TFormprodplan.FindUnplannedUniquePages;
Var
  found: Boolean;
  iplf, ipl, ip, ic: Integer;

Begin
  DataM1.Query1.sql.clear;
  DataM1.Query1.sql.add
    ('select editionid,sectionid,pagename,status,colorid,uniquepage,pagetype from pagetable WITH (NOLOCK) ');
  DataM1.Query1.sql.add('where publicationid = ' +
    inttostr(plateframespublicationid));
  DataM1.Query1.sql.add('and ' + DataM1.makedatastr('', plateframesPubdate));
  DataM1.Query1.sql.add('and locationid = ' + inttostr(plateframeslocationid));
  DataM1.Query1.sql.add('and ' + DataM1.makedatastr('', plateframesPubdate));
  DataM1.Query1.sql.add('and status > 0');
  DataM1.Query1.sql.add('and pagetype <> 3');

  formmain.Tryopen(DataM1.Query1);
  While not DataM1.Query1.eof do
  begin
    For iplf := 1 to Nplateframes do
    begin
      IF plateframesdata[iplf].ProdPlates[0].editionid <> DataM1.Query1.fields
        [0].asinteger then
        continue;

      For ipl := 0 to plateframes[iplf].NProdPlates do
      begin
        for ip := 1 to PlatetemplateArray
          [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
        begin
          IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype = 3 then
            continue;
          if (plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
            .sectionid = DataM1.Query1.fields[1].asinteger) and
            (plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
            .pagename = DataM1.Query1.fields[2].asstring) then
          begin
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totUniquePage :=
              DataM1.Query1.fields[5].asinteger;
          end;
        end;
      End;
    End;
    DataM1.Query1.next;
  End;
  DataM1.Query1.close;
end;

procedure TFormprodplan.CleanupExistingData;
Var
  found: Boolean;
  iplf, ipl, ip, ic, ic2: Integer;
  foundcolor: Boolean;
  Foundrecord: Boolean;
  Colorchange: Boolean;
Begin
  writeMainlogfile('RunProduction: CleanupExistingData called..');
  For iplf := 1 to Nplateframes do
  begin
    For ipl := 0 to plateframes[iplf].NProdPlates do
    begin
      plateframesdata[iplf].ProdPlates[ipl].TmpInt := 0;
      for ip := 1 to PlatetemplateArray
        [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
      begin
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].TmpInt := -99;
        // den findes slet ikke
        For ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
          .Ncolors do
        begin
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
            .TmpInt := -1;
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
            .active := 1;
        end;
      end;
    end;
  end;

  For iplf := 1 to Nplateframes do
  begin
    For ipl := 0 to plateframes[iplf].NProdPlates do
    begin
      for ip := 1 to PlatetemplateArray
        [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
      begin
        IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].TmpInt <> -99 then
        begin
          Colorchange := false;
          For ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
            .Ncolors do
          begin
            IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
              .TmpInt = -1 then
            begin
              Colorchange := true;
            End;
          end;

          IF Colorchange then
          begin
            IF (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totapproval <> 1) And (not FormApplyproduction.CheckBoxkeepcolors.checked) then
            begin

              DataM1.Query2.sql.clear;
              DataM1.Query2.sql.add
                ('update pagetable set status = 0,version=0, proofstatus=0');
              DataM1.Query2.sql.add('where mastercopyseparationset = ' +
                inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages
                [ip].TmpInt));
              formmain.trysql(DataM1.Query2);

            End
            Else
            begin
              For ic2 := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                .Ncolors do
              begin
                IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic2]
                  .TmpInt = -1 then
                begin
                  plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic2]
                    .TmpInt := -2; // s�t til active= 0
                End;
              End;
            end;
          End
          else
          begin
          end;
        End;
      end;
    end;
  end;

  DataM1.Query1.sql.clear;
  DataM1.Query1.sql.add
    ('select editionid,sectionid,pagename,status,colorid,uniquepage,pagetype,separation,mastercopyseparationset,approved,active from pagetable WITH (NOLOCK) ');
  DataM1.Query1.sql.add('where publicationid = ' +
    inttostr(plateframespublicationid));
  DataM1.Query1.sql.add('and ' + DataM1.makedatastr('', plateframesPubdate));
  DataM1.Query1.sql.add('and locationid = ' + inttostr(plateframeslocationid));
  DataM1.Query1.sql.add('and ' + DataM1.makedatastr('', plateframesPubdate));
  DataM1.Query1.sql.add('and pagetype <> 3');

  formmain.Tryopen(DataM1.Query1);
  While not DataM1.Query1.eof do
  begin
    Foundrecord := false;
    For iplf := 1 to Nplateframes do
    begin
      if plateframesdata[iplf].ProdPlates[0].editionid <> DataM1.Query1.fields
        [0].asinteger then
        continue;
      For ipl := 0 to plateframes[iplf].NProdPlates do
      begin
        for ip := 1 to PlatetemplateArray
          [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
        begin
          if plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype = 3 then
            continue;

          if (plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
            .sectionid = DataM1.Query1.fields[1].asinteger) and
            (plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
            .pagename = DataM1.Query1.fields[2].asstring) then
          begin
            For ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
              .Ncolors do
            begin
              if plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                .ColorID = DataM1.Query1.fields[4].asinteger then
              begin
                IF not((plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                  .pagetype = 0) and (DataM1.Query1.fields[6].asinteger = 2))
                then
                  plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                    .active := DataM1.Query1.fields[10].asinteger;
                Foundrecord := true;
                break;
              end;
            end;
          end;
        end;
      End;
    End;
    DataM1.Query1.next;
  End;
  DataM1.Query1.close;
  writeMainlogfile('RunProduction: CleanupExistingData done.');
end;

Function TFormprodplan.UnplannedExists: Boolean;
Begin
  result := false;
  if Editmode <> 5 then
  begin
    DataM1.Query1.sql.clear;
    DataM1.Query1.sql.add
      ('select p.productionid,pr.plantype from pagetable p WITH (NOLOCK), productionnames pr  WITH (NOLOCK) ');
    DataM1.Query1.sql.add('where p.publicationid = ' +
      inttostr(plateframespublicationid));
    DataM1.Query1.sql.add('and ' + DataM1.makedatastr('p.',
      plateframesPubdate));
    DataM1.Query1.sql.add('and p.locationid = ' +
      inttostr(plateframeslocationid));
    if (Prefs.PressSpecific) then
      DataM1.Query1.sql.add('and p.pressid = ' + inttostr(plateframespressid));

    DataM1.Query1.sql.add('and p.productionid = pr.productionid');
    DataM1.Query1.sql.add('and pr.plantype = 0');
    formmain.Tryopen(DataM1.Query1);
    IF not DataM1.Query1.eof then
    begin
      result := true;
    end;
    DataM1.Query1.close;
  end;
end;

procedure TFormprodplan.ActionDeleteExecute(Sender: TObject);
begin
  FormDelPlan.ShowModal;
end;

procedure TFormprodplan.PBExListview1Click(Sender: TObject);
begin
  setactionenabled;
end;

Procedure TFormprodplan.GetProductionColors;
Var
  iplf, ipl, ip, ic: Integer;

Begin
  usingpdfplan := false;
  Currentblackcolorid := -1;

  For iplf := 1 to Nplateframes do
  Begin
    For ipl := 0 to plateframes[iplf].NProdPlates do
    begin
      for ip := 1 to PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
      begin
        For ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors do
        begin
          if plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].ColorID = tnames1.PDFCOLORID then
          begin
            usingpdfplan := true;
          end;
          if inittypes.Isablackcolor(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].ColorID) and
            (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].ColorID < 50) then
            Currentblackcolorid := plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].ColorID;
        end;
      End;
    End;
  End;
end;


procedure TFormprodplan.ActionCombineExecute(Sender: TObject);
Var
  Tplf, iplf, ipl, ip, ic: Integer;
  i1, I, Nprodcount: Integer;
  Nsheet: Integer;
  curNplateframes: Integer;
  aktedition: Integer;
  aktPresssectionnumber: Integer;
  plateFramesSelected: Integer;
begin // NprodplatesSize
  try
    FormSelectPaginationStyle.RadioGroupMethod.ItemIndex := 0;
    if (FormSelectPaginationStyle.ShowModal = mrcancel) then
      exit;

    plateFramesSelected := 0;
    for iplf := 1 to Nplateframes do
    begin
      if plateframes[iplf].Selected then
        Inc(plateFramesSelected);
    end;

    (* if (plateFramesSelected = 2) then
      begin
      CombineTwoRuns();
      exit;
      end; *)

    Tplf := 1;
    curNplateframes := Nplateframes;

    aktedition := plateframesdata[1].ProdPlates[0].editionid;
    aktPresssectionnumber := plateframesdata[1].ProdPlates[0].Presssectionnumber;

    For iplf := 2 to Nplateframes do
    Begin
      Nsheet := plateframesdata[Tplf].ProdPlates[plateframes[Tplf].NProdPlates]
        .sheetnumber + 1;

      if aktedition <> plateframesdata[iplf].ProdPlates[0].editionid then
      begin
        Inc(Tplf);
        aktedition := plateframesdata[iplf].ProdPlates[0].editionid;

        Nprodcount := plateframes[iplf].NProdPlates + plateframes[Tplf]
          .NProdPlates + 8;
        formmain.Allocateprodplates(Tplf,
          (plateframes[Tplf].NProdPlates * 2) + 32);

        For ipl := 0 to plateframes[iplf].NProdPlates do
        begin
          i1 := ipl;
          plateframesdata[Tplf].ProdPlates[i1] := plateframesdata[iplf]
            .ProdPlates[ipl];
          plateframesdata[Tplf].ProdPlates[i1].sheetnumber :=
            plateframesdata[iplf].ProdPlates[ipl].sheetnumber;
          plateframesdata[Tplf].ProdPlates[i1].Presssectionnumber :=
            aktPresssectionnumber;
        end;

        plateframes[Tplf].NProdPlates := plateframes[iplf].NProdPlates;
        plateframes[Tplf].GroupBoxtop.Caption := plateframes[iplf]
          .GroupBoxtop.Caption;
      end
      Else
      begin

        Nprodcount := plateframes[iplf].NProdPlates + plateframes[Tplf]
          .NProdPlates + 8;
        formmain.Allocateprodplates(Tplf, Nprodcount + 32);

        For ipl := 0 to plateframes[iplf].NProdPlates do
        begin
          i1 := plateframes[Tplf].NProdPlates + ipl + 1;
          plateframesdata[Tplf].ProdPlates[i1] := plateframesdata[iplf].ProdPlates[ipl];
          plateframesdata[Tplf].ProdPlates[i1].sheetnumber := Nsheet;
          plateframesdata[Tplf].ProdPlates[i1].Presssectionnumber :=
            aktPresssectionnumber;

          IF ipl mod 2 = 1 then
            Inc(Nsheet);
        end;

        Inc(plateframes[Tplf].NProdPlates, plateframes[iplf].NProdPlates + 1);
        plateframes[Tplf].GroupBoxtop.Caption := plateframes[iplf]
          .GroupBoxtop.Caption;
      End;
    End;
    Nplateframes := Tplf;

    pressruncaptionnames();

    pageindextopagina();

    CalculatePaginaAfterCombine
      (FormSelectPaginationStyle.RadioGroupMethod.ItemIndex);

    genmiscstring(); // Platenumbers

    copyplantoplanpages();

    For iplf := Tplf + 1 to curNplateframes do
    begin
      plateframes[iplf].visible := false;
    end;

    plateframes[Tplf].Align := alclient;

    plateviewimage.Width := 23; // 204
    plateviewimage.Height := 51; // 176
    DrawThePlates(CheckBoxsmallimagesinEdit.checked, 1);
  Except
  end;

end;

procedure TFormprodplan.CombineTwoRuns;
Var
  iplf, ipl, ip, ic: Integer;
  i1, I, Nprodcount: Integer;
  Nsheet: Integer;
  curNplateframes: Integer;
  aktedition: Integer;
  aktPresssectionnumber: Integer;
  plateFrameSelected1: Integer;
  plateFrameSelected2: Integer;
begin // NprodplatesSize
  try

    plateFrameSelected1 := 0;
    plateFrameSelected2 := 0;
    for iplf := 1 to Nplateframes do
    begin
      if (plateframes[iplf].Selected) and (plateFrameSelected1 = 0) then
      begin
        plateFrameSelected1 := iplf;
        continue;
      end;
      if (plateframes[iplf].Selected) and (plateFrameSelected1 > 0) then
      begin
        plateFrameSelected2 := iplf;
        continue;
      end;
    end;

    if (plateFrameSelected1 = 0) or (plateFrameSelected2 = 0) then
      exit;

    curNplateframes := Nplateframes;

    aktedition := plateframesdata[plateFrameSelected1].ProdPlates[0].editionid;

    if (plateframesdata[plateFrameSelected1].ProdPlates[0].editionid <>
      plateframesdata[plateFrameSelected2].ProdPlates[0].editionid) then
      exit;

    aktPresssectionnumber := plateframesdata[plateFrameSelected1].ProdPlates[0]
      .Presssectionnumber;

    Nsheet := plateframesdata[plateFrameSelected1].ProdPlates
      [plateframes[plateFrameSelected1].NProdPlates].sheetnumber + 1;

    Nprodcount := plateframes[plateFrameSelected1].NProdPlates + plateframes
      [plateFrameSelected2].NProdPlates + 8;
    formmain.Allocateprodplates(plateFrameSelected1, Nprodcount + 32);

    For ipl := 0 to plateframes[plateFrameSelected2].NProdPlates do
    begin
      i1 := plateframes[plateFrameSelected1].NProdPlates + ipl + 1;
      plateframesdata[plateFrameSelected1].ProdPlates[i1] :=
        plateframesdata[plateFrameSelected2].ProdPlates[ipl];
      plateframesdata[plateFrameSelected1].ProdPlates[i1].sheetnumber := Nsheet;
      plateframesdata[plateFrameSelected1].ProdPlates[i1].Presssectionnumber :=
        aktPresssectionnumber;

      IF ipl mod 2 = 1 then
        Inc(Nsheet);
    end;

    Inc(plateframes[plateFrameSelected1].NProdPlates,
      plateframes[plateFrameSelected2].NProdPlates + 1);
    // plateframes[plateFrameSelected1].GroupBoxtop.Caption := plateframes[plateFrameSelected2].GroupBoxtop.Caption;

    Nplateframes := plateFrameSelected1;

    pressruncaptionnames;

    pageindextopagina;

    calulatepagina;

    genmiscstring; // Platenumbers

    copyplantoplanpages;

    plateframes[plateFrameSelected2].visible := false;

    plateframes[plateFrameSelected1].Align := alclient;

    plateviewimage.Width := 23; // 204
    plateviewimage.Height := 51; // 176
    DrawThePlates(CheckBoxsmallimagesinEdit.checked, 1);
  Except
  end;

end;

Procedure TFormprodplan.PageIndexToPagina;
var
  iplf, ipl, ip, ic: Integer;
begin
  for iplf := 1 to Nplateframes do
  begin
    For ipl := 0 to plateframes[iplf].NProdPlates do
    begin
      for ip := 1 to PlatetemplateArray
        [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
      begin
        For ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
          .Ncolors do
        begin
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagina :=
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Pageindex;
        end;
      end;
    end;
  end;
end;

procedure TFormprodplan.ActionplatemarksExecute(Sender: TObject);
var
  iplf, ipl, ip, ic: Integer;
begin
  try
    for iplf := 1 to Nplateframes do
    begin
      For ipl := 0 to plateframes[iplf].NProdPlates do
      begin
        for ip := 1 to PlatetemplateArray
          [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
        begin
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Pageindex :=
            StrToInt(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename);
        end;
      end;
    end;
  Except
  end;
end;

Procedure TFormprodplan.Loadpressplandata(presstemplateid: Integer;
  presstemplateid2: Integer; presstemplateid3: Integer; presstemplateid4: Integer;  presstemplateid5: Integer;
  inserted1: Boolean; inserted2: Boolean; inserted3: Boolean; inserted4: Boolean;
  Pressid: Integer; multipresstemplateload: Boolean;
  changeLoadedsections: Boolean);
var
  iplf, ipl, ip, ic, icopy, Ncopies: Integer;
  aktsheet, aktfront, aktcopy: Integer;

  PDFPlan: Boolean; // 1 tif,2pdf
  blackcolorid, ColorID: Integer;

  addbycopy: Boolean;
  m1, m2: Integer;

  I, nfl, ied, maxnproddata: Integer;

  Firsteditionid, Iedition, Neditionidinpresstemplate: Integer;
  DBRunnumber, runnumbercounter: Integer;
  nextFlatNumber, nextFront: Integer;
Begin // NprodplatesSize
  Ncopies := 1;
  Validplancolors := '';
  blackcolorid := tnames1.Colornametoid('K');
  PDFPlan := false;
  DataM1.Query1.sql.clear;
  DataM1.Query1.sql.add('Select Distinct Color from Presstemplate (NOLOCK)');
  DataM1.Query1.sql.add('where PressTemplateid = ' + inttostr(presstemplateid));
  DataM1.Query1.sql.add('or PressTemplateid = ' + inttostr(presstemplateid2));
  DataM1.Query1.sql.add('or PressTemplateid = ' + inttostr(presstemplateid3));
  formmain.Tryopen(DataM1.Query1);
  While not DataM1.Query1.eof do
  Begin
    ColorID := DataM1.Query1.fields[0].asinteger;
    if inittypes.Isablackcolor(ColorID) then
      blackcolorid := ColorID;
    IF ColorID = tnames1.PDFCOLORID then
      PDFPlan := true;
    if (Validplancolors <> '') then
      Validplancolors := Validplancolors + ',';
    Validplancolors := Validplancolors + DataM1.Query1.fields[0].asstring;

    DataM1.Query1.next;
  end;

  DataM1.Query1.close;

  Validplancolors := '(' + Validplancolors + ')';

  DataM1.Query1.sql.clear;
  DataM1.Query1.sql.add
    ('Select max(runnumber),max(flatnumber),max(copynumber) from Presstemplate (NOLOCK)');
  DataM1.Query1.sql.add('where presstemplateid = ' + inttostr(presstemplateid));
  DataM1.Query1.sql.add('and pressid = ' + inttostr(Pressid));
  formmain.Tryopen(DataM1.Query1);
  IF not DataM1.Query1.eof then
  begin
    maxnproddata := ((DataM1.Query1.fields[1].asinteger * DataM1.Query1.fields
      [2].asinteger) * 2) + 2;
    nfl := DataM1.Query1.fields[0].asinteger;
  end;
  DataM1.Query1.close;

  if (presstemplateid2 > 0) then
  begin
    DataM1.Query1.sql.clear;
    DataM1.Query1.sql.add
      ('Select max(runnumber),max(flatnumber),max(copynumber) from Presstemplate (NOLOCK)');
    DataM1.Query1.sql.add('where presstemplateid = ' +
      inttostr(presstemplateid2));
    DataM1.Query1.sql.add('and pressid = ' + inttostr(Pressid));
    formmain.Tryopen(DataM1.Query1);
    IF not DataM1.Query1.eof then
    begin
      maxnproddata := maxnproddata +
        ((DataM1.Query1.fields[1].asinteger * DataM1.Query1.fields[2]
        .asinteger) * 2) + 2;
      nfl := nfl + DataM1.Query1.fields[0].asinteger;
    end;
    DataM1.Query1.close;

  end;

  if (presstemplateid3 > 0) then
  begin
    DataM1.Query1.sql.clear;
    DataM1.Query1.sql.add
      ('Select max(runnumber),max(flatnumber),max(copynumber) from Presstemplate (NOLOCK)');
    DataM1.Query1.sql.add('where presstemplateid = ' +
      inttostr(presstemplateid3));
    DataM1.Query1.sql.add('and pressid = ' + inttostr(Pressid));
    formmain.Tryopen(DataM1.Query1);
    IF not DataM1.Query1.eof then
    begin
      maxnproddata := maxnproddata +
        ((DataM1.Query1.fields[1].asinteger * DataM1.Query1.fields[2]
        .asinteger) * 2) + 2;
      nfl := nfl + DataM1.Query1.fields[0].asinteger;
    end;
    DataM1.Query1.close;

  end;

   if (presstemplateid4 > 0) then
  begin
    DataM1.Query1.sql.clear;
    DataM1.Query1.sql.add
      ('Select max(runnumber),max(flatnumber),max(copynumber) from Presstemplate (NOLOCK)');
    DataM1.Query1.sql.add('where presstemplateid = ' +
      inttostr(presstemplateid4));
    DataM1.Query1.sql.add('and pressid = ' + inttostr(Pressid));
    formmain.Tryopen(DataM1.Query1);
    IF not DataM1.Query1.eof then
    begin
      maxnproddata := maxnproddata +
        ((DataM1.Query1.fields[1].asinteger * DataM1.Query1.fields[2]
        .asinteger) * 2) + 2;
      nfl := nfl + DataM1.Query1.fields[0].asinteger;
    end;
    DataM1.Query1.close;

  end;

  if (presstemplateid5 > 0) then
  begin
    DataM1.Query1.sql.clear;
    DataM1.Query1.sql.add
      ('Select max(runnumber),max(flatnumber),max(copynumber) from Presstemplate (NOLOCK)');
    DataM1.Query1.sql.add('where presstemplateid = ' +
      inttostr(presstemplateid5));
    DataM1.Query1.sql.add('and pressid = ' + inttostr(Pressid));
    formmain.Tryopen(DataM1.Query1);
    IF not DataM1.Query1.eof then
    begin
      maxnproddata := maxnproddata +
        ((DataM1.Query1.fields[1].asinteger * DataM1.Query1.fields[2]
        .asinteger) * 2) + 2;
      nfl := nfl + DataM1.Query1.fields[0].asinteger;
    end;
    DataM1.Query1.close;

  end;

  For I := 1 to Nplateframes + 1 do
  begin
    formmain.Allocateprodplates(I, maxnproddata + 32);
  end;
  (*
    For i := 1 to nfl+1 do
    begin
    formmain.Allocateprodplates(i,maxnproddata);
    end;
  *)
  if (plateframesproductionid > 0) and (Prefs.UseMultiPressTemplateLoad) and
    (spPlanCenterLoadMultiplePressTemplatesPossible) then
  begin
    DataM1.Query1.sql.clear;

    DataM1.Query1.sql.add('exec spPlanCenterLoadMultiplePressTemplates ');
    DataM1.Query1.sql.add('@PressTemplateID1 = ' + inttostr(presstemplateid));
    DataM1.Query1.sql.add(',@PressTemplateID2 = ' + inttostr(presstemplateid2));
    DataM1.Query1.sql.add(',@PressTemplateID3 = ' + inttostr(presstemplateid3));
    if (inserted1) then
      DataM1.Query1.sql.add(',@Inserted1 = 1')
    else
      DataM1.Query1.sql.add(',@Inserted1 = 0');
    if (inserted2) then
      DataM1.Query1.sql.add(',@Inserted2 = 1')
    else
      DataM1.Query1.sql.add(',@Inserted2 = 0');

    DataM1.Query1.sql.add(',@ProductionID = ' +
      inttostr(plateframesproductionid));

    if (spPlanCenterLoadMultiplePressTemplatesPressTemplateID5ParamPossible) then
    begin
       DataM1.Query1.sql.add(',@PressTemplateID4 = ' + inttostr(presstemplateid4));
       DataM1.Query1.sql.add(',@PressTemplateID5 = ' + inttostr(presstemplateid5));
    if (inserted3) then
      DataM1.Query1.sql.add(',@Inserted3 = 1')
    else
      DataM1.Query1.sql.add(',@Inserted3 = 0');
    if (inserted4) then
      DataM1.Query1.sql.add(',@Inserted4 = 1')
    else
      DataM1.Query1.sql.add(',@Inserted4 = 0');
    end;
  end
  else
  begin
    DataM1.Query1.sql.clear;
    DataM1.Query1.sql.add('Select * from Presstemplate (NOLOCK)');
    DataM1.Query1.sql.add('where presstemplateid = ' +
      inttostr(presstemplateid));
    DataM1.Query1.sql.add('and pressid = ' + inttostr(Pressid));

    if (not PDFPlan) and (ApplyingToPDF) then
    Begin
      DataM1.Query1.sql.add('and (color = ' + inttostr(blackcolorid));
      DataM1.Query1.sql.add('or pagetype = 3)');
    end;
    //
    DataM1.Query1.sql.add
      ('order by runnumber,flatnumber,copynumber,front,pairpos,platenumber ');
    // iplf      sheetnumber      ip      ic
  end;
  ipl := -1;
  aktsheet := -1;
  aktfront := -1;
  aktcopy := -1;
  iplf := -1;

  runnumbercounter := 0;
  if Prefs.debug then
    DataM1.Query1.sql.SaveToFile
      (IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\' +
      'loadpresstemplate.sql');

  For ied := 1 to Formloadpressplan.NumberOfEditionsInProd do
  begin
    DBRunnumber := -11;
    formmain.Tryopen(DataM1.Query1);
    While not DataM1.Query1.eof do
    Begin
      Formtower.CheckBox1.checked :=
        Boolean(DataM1.Query1.fieldbyname('UsePressTowerInfo').asinteger);
      Ncopies := DataM1.Query1.fieldbyname('copynumber').asinteger;
      if DBRunnumber <> DataM1.Query1.fieldbyname('runnumber').asinteger then
      Begin
        if (Ncopies > 1) and (ipl > -1) then
        Begin
          For icopy := 2 to Ncopies do
          Begin
            Inc(ipl);
            ip := -1;
            plateframesdata[iplf].ProdPlates[ipl] := plateframesdata[iplf]
              .ProdPlates[ipl - 1];
            plateframesdata[iplf].ProdPlates[ipl].Copynumber := icopy;
            plateframesdata[iplf].ProdPlates[ipl].FlatSeparationSet :=
              (100 * plateframesdata[iplf].ProdPlates[ipl]
              .CopyFlatSeparationSet) + icopy;

            For ip := 1 to PlatetemplateArray
              [plateframesdata[iplf].ProdPlates[ipl].templatelistid]
              .NupOnplate do
            Begin
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].SeparationSet :=
                (plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                .CopySeparationSet * 100) + icopy;
              For ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                .Ncolors do
              Begin
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                  .Copynumber := icopy;
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].High
                  := plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                  .Miscstring3;

                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                  .FlatSeparation :=
                  (plateframesdata[iplf].ProdPlates[ipl].FlatSeparationSet *
                  100) + plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors
                  [ic].ColorID;
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                  .Separation :=
                  (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].SeparationSet
                  * 100) + plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                  .colors[ic].ColorID;
              End;
            End;
          End;
          addbycopy := true;
        End;

        DBRunnumber := DataM1.Query1.fieldbyname('runnumber').asinteger;
        Inc(runnumbercounter);
        IF iplf > -1 then
          plateframes[iplf].NProdPlates := ipl;
        iplf := runnumbercounter;
        ipl := -1;
        aktsheet := -1;
        aktfront := -1;
      end;
      IF (Formloadpressplan.CheckBoxChangecopies.checked) and
        (not multipresstemplateload) then
        Ncopies := Formloadpressplan.UpDownCopies.Position;
      icopy := 1;

      addbycopy := false;

      nextFlatNumber := DataM1.Query1.fieldbyname('flatnumber').asinteger;
      nextFront := DataM1.Query1.fieldbyname('front').asinteger;

      // Copy number data to plate copy 2
      IF (Ncopies > 1) And (ipl > -1) then
      begin
        if (aktsheet <> nextFlatNumber) or (aktfront <> nextFront) then
        begin
          For icopy := 2 to Ncopies do
          begin
            Inc(ipl);
            ip := -1;
            plateframesdata[iplf].ProdPlates[ipl] := plateframesdata[iplf]
              .ProdPlates[ipl - 1];
            plateframesdata[iplf].ProdPlates[ipl].Copynumber := icopy;
            plateframesdata[iplf].ProdPlates[ipl].FlatSeparationSet :=
              (100 * plateframesdata[iplf].ProdPlates[ipl]
              .CopyFlatSeparationSet) + icopy;
            for ip := 1 to PlatetemplateArray
              [plateframesdata[iplf].ProdPlates[ipl].templatelistid]
              .NupOnplate do
            Begin
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].SeparationSet :=
                (plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                .CopySeparationSet * 100) + icopy;
              For ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                .Ncolors do
              begin
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                  .Copynumber := icopy;

                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].High
                  := plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                  .Miscstring3;

                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                  .FlatSeparation :=
                  (plateframesdata[iplf].ProdPlates[ipl].FlatSeparationSet *
                  100) + plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors
                  [ic].ColorID;
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                  .Separation :=
                  (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].SeparationSet
                  * 100) + plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                  .colors[ic].ColorID;
              end;
            end;
          End;
          addbycopy := true;
        End;
      end;

      if (aktsheet <> nextFlatNumber) or (aktfront <> nextFront) then
      begin
        Inc(ipl);
        ip := -1;
      End;

      aktfront := DataM1.Query1.fieldbyname('front').asinteger;
      aktsheet := DataM1.Query1.fieldbyname('flatnumber').asinteger;

      prodsections := DataM1.Query1.fieldbyname('sections').asstring;
      prodpages := DataM1.Query1.fieldbyname('pages').asstring;
      prodcombined := DataM1.Query1.fieldbyname('combined').asinteger;
      prodbindingstyle := DataM1.Query1.fieldbyname('bindingstyle').asinteger;
      prodcollection := DataM1.Query1.fieldbyname('collection').asinteger;
      prodplancreep := DataM1.Query1.fieldbyname('Plancreep').AsFloat;

      prodplannedhold := Formloadpressplan.RadioGrouplocked.ItemIndex;
      prodplannedapproval := Formloadpressplan.RadioGroupApproval.ItemIndex;
      plateframesPubdate := Formloadpressplan.DateTimePicker1loadplan.Date;
      iplf := runnumbercounter;
      plateframes[iplf].pressrunid := iplf;

      plateframes[iplf].NProdPlates := ipl;
      // plateframesdata[iplf].prodplates[ipl].Ncopies := 1;
      plateframes[iplf].Numberofcopies := 1;
      plateframes[iplf].PressConfignameX := DataM1.Query1.fieldbyname
        ('pressrunconfig').asstring;
      plateframes[iplf].Inkcomment := '';
      plateframes[iplf].Comment := DataM1.Query1.fieldbyname
        ('Pressruncomment').asstring;
      plateframes[iplf].perfecktbound := DataM1.Query1.fieldbyname
        ('perfecktbound').asinteger;
      plateframes[iplf].inserted := DataM1.Query1.fieldbyname('Inserted')
        .asinteger;

      plateframesdata[iplf].ProdPlates[ipl].Changed := false;
      plateframesdata[iplf].ProdPlates[ipl].Front :=
        DataM1.Query1.fieldbyname('Front').asinteger;
      plateframesdata[iplf].ProdPlates[ipl].TrueFront :=
        DataM1.Query1.fieldbyname('Front').asinteger;
      plateframesdata[iplf].ProdPlates[ipl].sheetnumber :=
        DataM1.Query1.fieldbyname('flatnumber').asinteger;
      plateframesdata[iplf].ProdPlates[ipl].FlatSeparationSet := 0;
      plateframesdata[iplf].ProdPlates[ipl].CopyFlatSeparationSet :=
        DataM1.Query1.fieldbyname('CopyFlatSeparationSet').asinteger;
      plateframesdata[iplf].ProdPlates[ipl].productionid :=
        plateframesproductionid;
      plateframesdata[iplf].ProdPlates[ipl].IssueID := 0;
      plateframesdata[iplf].ProdPlates[ipl].publicationid :=
        plateframespublicationid;
      plateframesdata[iplf].ProdPlates[ipl].Copynumber := 1;
      plateframesdata[iplf].ProdPlates[ipl].Ncopies := Ncopies;
      plateframesdata[iplf].ProdPlates[ipl].Locationid := plateframeslocationid;

      if Formloadpressplan.UsingProddata then
        plateframesdata[iplf].ProdPlates[ipl].editionid :=
          tnames1.editionnametoid(Formeditionorder.listbox1.items[ied - 1])
      else
        plateframesdata[iplf].ProdPlates[ipl].editionid :=
          DataM1.Query1.fieldbyname('EditionID').asinteger;

      IF (Formloadpressplan.ComboBoxtemplate.ItemIndex > 0) and
        (not multipresstemplateload) then
        plateframesdata[iplf].ProdPlates[ipl].templatelistid :=
          inittypes.gettemplatelistnumberfromname
          (Formloadpressplan.ComboBoxtemplate.Text)
      else
        plateframesdata[iplf].ProdPlates[ipl].templatelistid :=
          inittypes.gettemplatenumberfromID
          (DataM1.Query1.fieldbyname('templateid').asinteger);

      plateframesdata[iplf].ProdPlates[ipl].deviceid := 0;
      plateframesdata[iplf].ProdPlates[ipl].Pressid := plateframespressid;
      plateframesdata[iplf].ProdPlates[ipl].runid := -99;
      plateframesdata[iplf].ProdPlates[ipl].produce := true;
      plateframesdata[iplf].ProdPlates[ipl].readytoproduce := false;
      plateframesdata[iplf].ProdPlates[ipl].someerror := false;
      plateframesdata[iplf].ProdPlates[ipl].totappr := prodplannedapproval - 1;
      plateframesdata[iplf].ProdPlates[ipl].totstat := 0;
      plateframesdata[iplf].ProdPlates[ipl].NUniquepages := 64;
      plateframesdata[iplf].ProdPlates[ipl].Presssectionnumber :=
        DataM1.Query1.fieldbyname('Presssectionnumber').asinteger;
      inittypes.markstrtoarray(DataM1.Query1.fieldbyname('Markgroups').asstring,
        plateframesdata[iplf].ProdPlates[ipl].markgroups,
        plateframesdata[iplf].ProdPlates[ipl].Nmarkgroups);

      plateframes[iplf].SequenceNumber := runnumbercounter;

      If plateframes[iplf].SequenceNumber <= 0 then
        plateframes[iplf].SequenceNumber := iplf;

      plateframesdata[iplf].ProdPlates[ipl].FlatProofConfigurationID :=
        DataM1.Query1.fieldbyname('FlatProofConfigurationID').asinteger;
      plateframesdata[iplf].ProdPlates[ipl].HardProofConfigurationID :=
        DataM1.Query1.fieldbyname('HardProofConfigurationID').asinteger;

      ip := DataM1.Query1.fieldbyname('pairpos').asinteger;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totapproval :=
        prodplannedapproval - 1;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Anyheld := false;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totUniquePage :=
        DataM1.Query1.fieldbyname('UniquePage').asinteger;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype :=
        DataM1.Query1.fieldbyname('pagetype').asinteger;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Creep :=
        DataM1.Query1.fieldbyname('Creep').AsFloat;

      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].sectionid :=
        DataM1.Query1.fieldbyname('SectionID').asinteger;

      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].MasterCopySeparationSet :=
        DataM1.Query1.fieldbyname('MasterCopySeparationSet').asinteger;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagestatus := 0;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].proofed := false;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].approved :=
        prodplannedapproval - 1;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Orgeditionid :=
        DataM1.Query1.fieldbyname('OrgEditionID').asinteger;

      // ## NAN 20160309
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].RipSetupID :=
        DataM1.Query1.fieldbyname('Backwards').asinteger;
      // plateframes[iplf].Backwards := DataM1.Query1.FieldByName('Backwards').asinteger;

      if (PressTemplatePageRotationPossible) then
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].PageRotation :=
          DataM1.Query1.fieldbyname('PageRotation').asinteger
      else
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].PageRotation := 0;

      IF Formloadpressplan.UsingProddata then
      begin
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Orgeditionid :=
          tnames1.editionnametoid(Formeditionorder.listbox1.items[ied - 1]);
      end;

      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename :=
        DataM1.Query1.fieldbyname('pagename').asstring;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagina :=
        DataM1.Query1.fieldbyname('Pagina').asinteger;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Pageindex :=
        DataM1.Query1.fieldbyname('Pageindex').asinteger;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].orgpageindex :=
        DataM1.Query1.fieldbyname('Pageindex').asinteger;

      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagechange := false;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].proofid :=
        DataM1.Query1.fieldbyname('Proofid').asinteger;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].CopySeparationSet := 0;

      If (not PDFPlan) and (Formprodplan.ApplyingToPDF) then
      begin
        ic := 1;
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].ColorID :=
          tnames1.PDFCOLORID
      end
      else
      begin
        ic := DataM1.Query1.fieldbyname('platenumber').asinteger;
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].ColorID :=
          DataM1.Query1.fieldbyname('color').asinteger;
      end;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
        .Copynumber := 1;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Uniquepage :=
        DataM1.Query1.fieldbyname('Uniquepage').asinteger;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].active :=
        DataM1.Query1.fieldbyname('IssueID').asinteger;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].status := 0;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
        .proofstatus := 0;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].approved :=
        prodplannedapproval - 1;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Priority :=
        Formloadpressplan.UpDown1.Position;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Hold :=
        prodplannedhold;

      if Formloadpressplan.ComboBoxstackpos.Text = 'Planned' then
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].stackpos :=
          SetPlanIDFromname(2, DataM1.Query1.fieldbyname('stackpos').asstring)
      else
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].stackpos :=
          SetPlanIDFromname(2, Formloadpressplan.ComboBoxstackpos.Text);

      plateframesdata[iplf].ProdPlates[ipl].Tower :=
        SetplanTowername(DataM1.Query1.fieldbyname('TowerID').asstring);

      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].High :=
        SetPlanIDFromname(3, DataM1.Query1.fieldbyname('High').asstring);

      if (DataM1.Query1.fieldbyname('CylinderID').asstring = fronbackstr[0]) OR
        (DataM1.Query1.fieldbyname('CylinderID').asstring = fronbackstr[1]) then
      begin
        if (DataM1.Query1.fieldbyname('CylinderID').asstring = fronbackstr[0])
        then
          plateframesdata[iplf].ProdPlates[ipl].TrueFront := 2
        else
          plateframesdata[iplf].ProdPlates[ipl].TrueFront := 3;
      end
      else
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Cylinder :=
          SetPlanIDFromname(4, DataM1.Query1.fieldbyname('CylinderID')
          .asstring);

      plateframesdata[iplf].ProdPlates[ipl].Zone :=
        SetPlanIDFromname(5, DataM1.Query1.fieldbyname('ZoneID').asstring);
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors := ic;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Miscint1 :=
        DataM1.Query1.fieldbyname('Miscint1').asinteger;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Miscint2 :=
        DataM1.Query1.fieldbyname('Miscint2').asinteger;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Miscint3 :=
        DataM1.Query1.fieldbyname('Miscint3').asinteger;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Miscint4 :=
        DataM1.Query1.fieldbyname('Miscint4').asinteger;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Miscstring1 :=
        SetPlanIDFromname(6, DataM1.Query1.fieldbyname('Miscstring1').asstring);
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Miscstring2 :=
        SetPlanIDFromname(7, DataM1.Query1.fieldbyname('Miscstring2').asstring);
      // 20181203 - changed from 8 to 3 for HighLow fix
      // Chnaged back!
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Miscstring3 :=
        SetPlanIDFromname(8, DataM1.Query1.fieldbyname('Miscstring3').asstring);
      DataM1.Query1.next;
    end;
    DataM1.Query1.close;

    // Copy to copy number 2
    IF (Ncopies > 1) And (ipl > -1) then
    begin
      For icopy := 2 to Ncopies do
      begin
        Inc(ipl);
        ip := -1;
        plateframesdata[iplf].ProdPlates[ipl] := plateframesdata[iplf]
          .ProdPlates[ipl - 1]; // Copies all data!

        // Adjust for copy 2
        plateframesdata[iplf].ProdPlates[ipl].Copynumber := icopy;
        plateframesdata[iplf].ProdPlates[ipl].FlatSeparationSet :=
          (100 * plateframesdata[iplf].ProdPlates[ipl]
          .CopyFlatSeparationSet) + icopy;
        for ip := 1 to PlatetemplateArray
          [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
        Begin
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].SeparationSet :=
            (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].CopySeparationSet *
            100) + icopy;
          For ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
            .Ncolors do
          begin
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
              .Copynumber := icopy;
            // 20181203 - store high/low for copy 2 (taken from MiscString3)
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].High :=
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
              .Miscstring3;
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
              .FlatSeparation :=
              (plateframesdata[iplf].ProdPlates[ipl].FlatSeparationSet * 100) +
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors
              [ic].ColorID;
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
              .Separation := (plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
              .SeparationSet * 100) + plateframesdata[iplf].ProdPlates[ipl]
              .Pages[ip].colors[ic].ColorID;
          end;
        end;
      End;
      addbycopy := true;

    end;

    Nplateframes := iplf;
  End;
  IF iplf > -1 then
    plateframes[iplf].NProdPlates := ipl;

  IF Formloadpressplan.UsingProddata then
  begin

    For iplf := 1 to Nplateframes do
    begin
      DataM1.Query1.sql.clear;
      // 0                          1            2           3              4           5          6
      DataM1.Query1.sql.add
        ('Select distinct p1.mastercopyseparationset,p1.editionid,p1.pagename,p1.sectionid,p1.uniquepage,p2.editionid,p2.copyseparationset from pagetable p1 WITH (NOLOCK), pagetable p2 WITH (NOLOCK) ');
      DataM1.Query1.sql.add
        ('Where (p1.uniquepage <> 1 and p2.mastercopyseparationset = p1.mastercopyseparationset and p2.editionid <> p1.editionid)');
      DataM1.Query1.sql.add('and p1.editionid = ' +
        inttostr(plateframesdata[iplf].ProdPlates[0].editionid));
      DataM1.Query1.sql.add('and p1.pressid = ' + inttostr(Pressid));
      DataM1.Query1.sql.add('and (p1.publicationid = ' +
        inttostr(plateframespublicationid));
      DataM1.Query1.sql.add(' and ' + DataM1.makedatastr('p1.',
        plateframesPubdate));
      DataM1.Query1.sql.add(')');

      if Prefs.debug then
        DataM1.Query1.sql.SaveToFile
          (IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'
          + 'Findprodorged.sql');

      formmain.Tryopen(DataM1.Query1);

      while not DataM1.Query1.eof do
      begin
        IF DataM1.Query1.fields[5].asinteger <> plateframesdata[iplf].ProdPlates
          [0].editionid then
        begin
          For ipl := 0 to plateframes[iplf].NProdPlates do
          begin
            for ip := 1 to PlatetemplateArray
              [plateframesdata[iplf].ProdPlates[ipl].templatelistid]
              .NupOnplate do
            begin
              if (DataM1.Query1.fields[3].asinteger = plateframesdata[iplf]
                .ProdPlates[ipl].Pages[ip].sectionid) and
                (DataM1.Query1.fields[2].asstring = plateframesdata[iplf]
                .ProdPlates[ipl].Pages[ip].pagename) then
              begin
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Orgeditionid :=
                  DataM1.Query1.fields[5].asinteger;
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                  .totUniquePage := 0;
              end;
            End;
          End;
        End;
        DataM1.Query1.next;
      End;
      DataM1.Query1.close

    end;
  End;

  applypublicationdataafterloadafplan;
  copyplantoplanpages;
  pressruncaptionnames;

  setdinkydata(1);
end;

procedure TFormprodplan.ActionPlateMarkExecute(Sender: TObject);
Var
  found: Boolean;
  AIPLF, iplf, ipl, ip, ic: Integer;

begin
  found := false;
  AIPLF := 0;
  ipl := 0;
  For iplf := 1 to Nplateframes do
  begin
    if plateframes[iplf].Selected then
    begin
      IF plateframes[iplf].PBExListview1.Selected <> nil then
      begin
        ipl := Formprodplan.ImagenumbertoIPL(iplf,
          plateframes[iplf].PBExListview1.Selected.Index);
        AIPLF := iplf;
        found := true;
      end;
      if found then
        break;
    End;
  End;

  If not found then
    exit;
  iplf := AIPLF;
  FormMarkgroups.templatelistid := plateframesdata[iplf].ProdPlates[ipl]
    .templatelistid;

  FormMarkgroups.Amarks := plateframesdata[iplf].ProdPlates[ipl].markgroups;
  FormMarkgroups.ANmarks := plateframesdata[iplf].ProdPlates[ipl].Nmarkgroups;

  if FormMarkgroups.ShowModal = mrok then
  begin
    plateframesdata[iplf].ProdPlates[ipl].markgroups := FormMarkgroups.Amarks;
    plateframesdata[iplf].ProdPlates[ipl].Nmarkgroups := FormMarkgroups.ANmarks;
    setothercopies(iplf, ipl);
  end;
end;

// Copies
procedure TFormprodplan.SetOtherCopies(iplf: Integer; ipl: Integer);
Var
  ip, iplc, ic: Integer;
  Nup: Integer;
Begin
  // IF plateframesdata[iplf].prodplates[ipl].Ncopies > 1 then
  IF plateframes[iplf].Numberofcopies > 1 then
  begin
    // for iplc := ipl+1 to ipl+ plateframesdata[iplf].prodplates[ipl].Ncopies-1 do

    for iplc := ipl + 1 to ipl + plateframes[iplf].Numberofcopies - 1 do
    begin
      plateframesdata[iplf].ProdPlates[iplc].templatelistid :=
        plateframesdata[iplf].ProdPlates[ipl].templatelistid;
      plateframesdata[iplf].ProdPlates[iplc].markgroups := plateframesdata[iplf]
        .ProdPlates[ipl].markgroups;
      plateframesdata[iplf].ProdPlates[iplc].Nmarkgroups :=
        plateframesdata[iplf].ProdPlates[ipl].Nmarkgroups;

      Nup := PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl]
        .templatelistid].NupOnplate;

      for ip := 1 to Nup do
      begin

        plateframesdata[iplf].ProdPlates[iplc].Pages[ip].Ncolors :=
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors;
        plateframesdata[iplf].ProdPlates[iplc].Pages[ip].totUniquePage :=
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totUniquePage;
        plateframesdata[iplf].ProdPlates[iplc].Pages[ip].pagetype :=
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype;

        // NAN 20170523
        plateframesdata[iplf].ProdPlates[iplc].Pages[ip].pagename :=
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename;
        plateframesdata[iplf].ProdPlates[iplc].Pages[ip].pagina :=
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagina;
        plateframesdata[iplf].ProdPlates[iplc].Pages[ip].Pageindex :=
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Pageindex;
        //

        For ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors do
        begin
          plateframesdata[iplf].ProdPlates[iplc].Pages[ip].colors[ic].ColorID :=
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].ColorID;

          // NAN 20170523
          plateframesdata[iplf].ProdPlates[iplc].Pages[ip].colors[ic].active := plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].active;
          //
        End;
      End;
    End;
  end;
end;

Function TFormprodplan.Max8Car(fromstr: string): String;
Begin
  result := '';
  if length(fromstr) > 16 then
    delete(fromstr, 16, length(fromstr));

  result := fromstr;
end;

procedure TFormprodplan.FindPossibleDevises;
Var
  I, iplf, impl, ipl, ip, ic, icp, iplt: Integer;
  aktpl: Integer;
begin
  try
    aktpl := plateframesdata[1].ProdPlates[0].templatelistid;
    IF aktpl <> -1 then
    begin
      inittypes.getdeviceIDSfromtemplate(aktpl);
      inittypes.getdeviceGrplistfromtemplate(aktpl);
    End;
  Finally
  end;
end;

Function TFormprodplan.CreateProductionName(publicationid: Integer;
  Pressid: Integer; pubdate: Tdatetime): string;

Begin
  result := 'No name';
  try
    result := tnames1.publicationIDtoname(publicationid) + ' ' +
      formatdatetime('DD-MM-YYYY', pubdate) + ' ' +
      tnames1.pressnameIDtoname(Pressid);
  Except
  end;
end;

Procedure TFormprodplan.SetAllPressRunIdData;
Var
  iplf, mseq: Integer;
Begin
  mseq := 0;
  IF Not JustAlayoutchange then
  begin
    IF Formprodplan.planningaction = 6 then
    begin
      DataM1.Query3.sql.clear;
      DataM1.Query3.sql.add
        ('Select distinct pr.SequenceNumber,p.productionid from pressrunid pr WITH (NOLOCK), pagetable p WITH (NOLOCK) ');
      DataM1.Query3.sql.add('Where  p.productionid = ' +
        inttostr(plateframesproductionid));
      DataM1.Query3.sql.add('and pr.pressrunid = p.pressrunid');
      DataM1.Query3.sql.add('order by pr.SequenceNumber');
      DataM1.Query3.open;
      While not DataM1.Query3.eof do
      begin
        mseq := DataM1.Query3.fields[0].asinteger;
        DataM1.Query3.next;
      end;
      DataM1.Query3.close;

      For iplf := 1 to Nplateframes do
      begin
        plateframes[iplf].SequenceNumber := mseq + iplf;
      End;
    End;

    IF (Editmode = 5) or (Formprodplan.planningaction = 6) then
    begin
      For iplf := 1 to Nplateframes do
      begin
        IF PartialPlanning then
          plateframes[iplf].SequenceNumber := NextPartseqnum + (iplf - 1);

        setpressruniddata(plateframes[iplf].pressrunid,
          plateframes[iplf].SequenceNumber, plateframes[iplf].productiontime,
          now, now, now, plateframes[iplf].PriorityBeforeHottime,
          plateframes[iplf].PriorityDuringHottime,
          plateframes[iplf].PriorityAfterHottime,
          plateframes[iplf].PriorityHottimeBegin,
          plateframes[iplf].PriorityHottimeEnd, Movepressruncomment,
          plateframes[iplf].Inkcomment, movepressrunorder,
          plateframes[iplf].perfecktbound, plateframes[iplf].inserted,
          plateframes[iplf].Backwards);

      End;
    end
    else
    begin
      For iplf := 1 to Nplateframes do
      begin
        setpressruniddata(plateframes[iplf].pressrunid,
          plateframes[iplf].SequenceNumber, plateframes[iplf].productiontime,
          now, now, now, plateframes[iplf].PriorityBeforeHottime,
          plateframes[iplf].PriorityDuringHottime,
          plateframes[iplf].PriorityAfterHottime,
          plateframes[iplf].PriorityHottimeBegin,
          plateframes[iplf].PriorityHottimeEnd, plateframes[iplf].Comment,
          plateframes[iplf].Inkcomment, plateframes[iplf].order,
          plateframes[iplf].perfecktbound, plateframes[iplf].inserted,
          plateframes[iplf].Backwards);

      End;
    End;
  End;
end;

Procedure TFormprodplan.setpressruniddata(pressrunid: Integer;
  SequenceNumber: Integer; Deadline1: Tdatetime; Deadline2: Tdatetime;
  Deadline3: Tdatetime; Deadline4: Tdatetime; PriorityBeforeHottime: Integer;
  PriorityDuringHottime: Integer; PriorityAfterHottime: Integer;
  PriorityHottimeBegin: Tdatetime; PriorityHottimeEnd: Tdatetime;
  Comment: string; pressrunconfig: String; order: string; Perfectbound: Integer;
  inserted: Integer; Backwards: Integer);

Begin
  DataM1.Query1.sql.clear;
  DataM1.Query1.sql.add('Update PressRunID');
  DataM1.Query1.sql.add('Set SequenceNumber = ' + inttostr(SequenceNumber));

  IF PriorityBeforeHottime < 0 then
    PriorityBeforeHottime := 0;
  IF PriorityBeforeHottime > 100 then
    PriorityBeforeHottime := 100;
  IF PriorityDuringHottime < 0 then
    PriorityDuringHottime := 0;
  IF PriorityDuringHottime > 100 then
    PriorityDuringHottime := 100;
  IF PriorityAfterHottime < 0 then
    PriorityAfterHottime := 0;
  IF PriorityAfterHottime > 100 then
    PriorityAfterHottime := 100;

  DataM1.Query1.sql.add(',PriorityBeforeHottime = ' +
    inttostr(PriorityBeforeHottime));
  DataM1.Query1.sql.add(',PriorityDuringHottime = ' +
    inttostr(PriorityDuringHottime));
  DataM1.Query1.sql.add(',PriorityAfterHottime = ' +
    inttostr(PriorityAfterHottime));
  DataM1.Query1.sql.add(',comment = ' + '''' + Comment + '''');
  DataM1.Query1.sql.add(',InkComment = ' + '''' + pressrunconfig + '''');
  DataM1.Query1.sql.add(',OrderNumber = ' + '''' +
    FormApplyproduction.Editordernumber.Text + '''');
  DataM1.Query1.sql.add(',UsePressTowerInfo = ' +
    inttostr(Integer(FormApplyproduction.CheckBoxUsepresstowerconf.checked)));
  DataM1.Query1.sql.add(',PriorityHottimeBegin = :PriorityHottimeBegin');
  DataM1.Query1.sql.add(',PriorityHottimeEnd = :PriorityHottimeEnd');
  DataM1.Query1.sql.add(',Deadline1 = :Deadline1');
  DataM1.Query1.sql.add(',Deadline2 = :Deadline2');
  DataM1.Query1.sql.add(',Deadline3 = :Deadline3');
  DataM1.Query1.sql.add(',Deadline4 = :Deadline4');

  DataM1.Query1.sql.add('where pressrunid = ' + inttostr(pressrunid));

  DataM1.Query1.ParamByName('Deadline1').AsDateTime := Deadline1;
  DataM1.Query1.ParamByName('Deadline2').AsDateTime := Deadline2;
  DataM1.Query1.ParamByName('Deadline3').AsDateTime := Deadline3;
  DataM1.Query1.ParamByName('Deadline4').AsDateTime := Deadline4;

  DataM1.Query1.ParamByName('PriorityHottimeBegin').AsDateTime :=
    PriorityHottimeBegin;
  DataM1.Query1.ParamByName('PriorityHottimeEnd').AsDateTime :=
    PriorityHottimeEnd;

  if not formmain.trysql(DataM1.Query1) then
    Anyerrosduringrun := true;

end;

Procedure TFormprodplan.LoadPressRunIdData;
Var
  iplf: Integer;
Begin

  For iplf := 1 to Nplateframes do
  begin
    DataM1.Query1.sql.clear;
    // 0          1             2          3        4         5            6                   7                           8              9                      10            11           12             13          14
//    DataM1.Query1.sql.add('Select * from pressrunid (NOLOCK)');
      DataM1.Query1.Sql.Add('SELECT PressRunID');
      DataM1.Query1.Sql.Add(',SequenceNumber');
      DataM1.Query1.Sql.Add(',Deadline1');
      DataM1.Query1.Sql.Add(',Deadline2');
      DataM1.Query1.Sql.Add(',Deadline3');
      DataM1.Query1.Sql.Add(',Deadline4');
      DataM1.Query1.Sql.Add(',PriorityBeforeHottime');
      DataM1.Query1.Sql.Add(',PriorityDuringHottime');
      DataM1.Query1.Sql.Add(',PriorityAfterHottime');
      DataM1.Query1.Sql.Add(',PriorityHottimeBegin');
      DataM1.Query1.Sql.Add(',PriorityHottimeEnd');       // 10
      DataM1.Query1.Sql.Add(',Comment');
      DataM1.Query1.Sql.Add(',OrderNumber');
      DataM1.Query1.Sql.Add(',InkComment');
      DataM1.Query1.Sql.Add(',Backwards');
      DataM1.Query1.Sql.Add(',PerfectBound');
      DataM1.Query1.Sql.Add(',Inserted');  // 16
      DataM1.Query1.Sql.Add(',PlanName');
      DataM1.Query1.Sql.Add(',PressSystem');
      DataM1.Query1.Sql.Add(',PlanType');
      DataM1.Query1.Sql.Add(',Comment2');
	    DataM1.Query1.Sql.Add(',PlanVersion');      // 21
      DataM1.Query1.sql.add('FROM pressrunid WITH (NOLOCK) ');
      DataM1.Query1.sql.add('Where pressrunid = ' + inttostr(plateframes[iplf].pressrunid));
    formmain.Tryopen(DataM1.Query1);
    IF not DataM1.Query1.eof then
    begin
      plateframes[iplf].SequenceNumber := DataM1.Query1.fields[1].asinteger;
      plateframes[iplf].productiontime := DataM1.Query1.fields[2].AsDateTime;
      plateframes[iplf].PriorityBeforeHottime := DataM1.Query1.fields[6]
        .asinteger;
      plateframes[iplf].PriorityDuringHottime := DataM1.Query1.fields[7]
        .asinteger;
      plateframes[iplf].PriorityAfterHottime := DataM1.Query1.fields[8]
        .asinteger;
      plateframes[iplf].PriorityHottimeBegin := DataM1.Query1.fields[9]
        .AsDateTime;
      plateframes[iplf].PriorityHottimeEnd := DataM1.Query1.fields[10]
        .AsDateTime;
      plateframes[iplf].Comment := DataM1.Query1.fields[11].asstring;
      plateframes[iplf].order := DataM1.Query1.fields[12].asstring;
      plateframes[iplf].Inkcomment := DataM1.Query1.fields[13].asstring;
          // ## NAN 20160309
      plateframes[iplf].Backwards := 0;;
      plateframes[iplf].RipSetupID := DataM1.Query1.fields[14].asinteger;         // was 17
      // Backwards field used for RipSetupID!

      plateframes[iplf].perfecktbound := DataM1.Query1.fields[15].asinteger;
      plateframes[iplf].inserted := DataM1.Query1.fields[16].asinteger;


      IF DBVersion > 1 then
      Begin
        plateframes[iplf].presssystemname := DataM1.Query1.fields[18].AsString;  //DataM1.Query1.fieldbyname('Presssystem').asstring;
        plateframes[iplf].Plantype := DataM1.Query1.fields[19].AsInteger; //DataM1.Query1.fieldbyname('Plantype').asinteger;

        plateframes[iplf].planversion := DataM1.Query1.fields[21].AsInteger; //DataM1.Query1.fieldbyname ('Planversion').asinteger;
        IF tnames1.RipSetupnames.count > 0 then
        begin
          plateframes[iplf].RipSetupID := tnames1.ripsetupnametoid(DataM1.Query1.fields[20].AsString); //tnames1.ripsetupnametoid(DataM1.Query1.fieldbyname('Comment2').asstring);
        End;

      End;
    end
    else
    begin
      plateframes[iplf].planversion := 1;
      plateframes[iplf].SequenceNumber := iplf;
      plateframes[iplf].productiontime := 0;
      plateframes[iplf].PriorityBeforeHottime := 50;
      plateframes[iplf].PriorityDuringHottime := 50;
      plateframes[iplf].PriorityAfterHottime := 50;
      plateframes[iplf].PriorityHottimeBegin := 0;
      plateframes[iplf].PriorityHottimeEnd := 0;
      plateframes[iplf].Comment := '';
      plateframes[iplf].order := '';
      plateframes[iplf].Inkcomment := '';
      plateframes[iplf].perfecktbound := 0;
      plateframes[iplf].inserted := 0;

      // ## NAN 20160309
      // plateframes[iplf].Backwards             := 0;
      plateframes[iplf].RipSetupID := 0;

      plateframes[iplf].Plantype := 1;
      plateframes[iplf].presssystemname := '';
    end;
    DataM1.Query1.close;

  End;
  pressruncaptionnames;

End;

procedure TFormprodplan.PressRunCaptionNames;
Var
  iplf, ipl, ip, isec: Integer;
  sectionids: string;
  Sectionnames: string;
  Forndsec: Boolean;
  NSectionsInRun: Integer;
  SectionsInRun: Array [1 .. 256] of record sectionid: Integer;
  Lpage: Integer;
  pagename: String;
end;
Begin
  try

    For iplf := 1 to Nplateframes do
    begin
      sectionids := '';
      Sectionnames := '';

      for ip := 1 to 32 do
      begin
        SectionsInRun[ip].sectionid := -1;
        SectionsInRun[ip].Lpage := 1000;
      end;

      NSectionsInRun := 0;

      For ipl := 0 to plateframes[iplf].NProdPlates do
      begin
        for ip := 1 to PlatetemplateArray
          [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
        begin
          Forndsec := false;
          For isec := 1 to NSectionsInRun do
          begin
            IF SectionsInRun[isec].sectionid = plateframesdata[iplf].ProdPlates
              [ipl].Pages[ip].sectionid then
            begin
              Forndsec := true;
              break;
            end;
          end;
          IF not Forndsec Then
          begin
            Inc(NSectionsInRun);
            isec := NSectionsInRun;
            SectionsInRun[isec].sectionid := plateframesdata[iplf].ProdPlates
              [ipl].Pages[ip].sectionid;
          end;
          IF (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Pageindex > 0) AND
            (SectionsInRun[isec].Lpage > plateframesdata[iplf].ProdPlates[ipl]
            .Pages[ip].Pageindex) then
          Begin
            SectionsInRun[isec].Lpage := plateframesdata[iplf].ProdPlates[ipl]
              .Pages[ip].Pageindex;
            SectionsInRun[isec].pagename := plateframesdata[iplf].ProdPlates
              [ipl].Pages[ip].pagename;
          end;
        End;
      End;
      Sectionnames := '';
      For isec := 1 to NSectionsInRun do
      begin
        Sectionnames := Sectionnames + tnames1.sectionIDtoname
          (SectionsInRun[isec].sectionid) + '/' + SectionsInRun[isec]
          .pagename + ',';
      End;

      (*

        For ipl := 0 to plateframes[iplf].Nprodplates do
        begin
        for ip := 1 to platetemplatearray[plateframesdata[iplf].prodplates[ipl].templatelistid].NupOnplate do
        begin
        IF pos('('+inttostr(plateframesdata[iplf].prodplates[ipl].pages[ip].SectionID)+')',sectionids) = 0 then
        Begin
        sectionids := sectionids + '('+inttostr(plateframesdata[iplf].prodplates[ipl].pages[ip].SectionID)+')';

        if length(Sectionnames) > 0 then
        Sectionnames := Sectionnames + ',';
        Sectionnames := Sectionnames + tnames1.sectionIDtoname(plateframesdata[iplf].prodplates[ipl].pages[ip].SectionID);
        End;
        End;
        End;
      *)

      Sectionnames := '(' + Sectionnames;
      Sectionnames[length(Sectionnames)] := ')';

      plateframes[iplf].GroupBoxtop.Caption := 'Ed:' + tnames1.editionIDtoname
        (plateframesdata[iplf].ProdPlates[0].editionid) + '  Sec:' +
        Sectionnames + '  Seq:' + inttostr(plateframes[iplf].SequenceNumber);

    End;
  Except

  end;

end;

procedure TFormprodplan.ActionplanproofingExecute(Sender: TObject);
begin
  if Formproof.ShowModal = mrok then
  begin

  end;
end;

procedure TFormprodplan.ActionPlanFlatProofExecute(Sender: TObject);
Var
  I, iplf, impl, ipl, ip, ic, icp, iplt: Integer;
  aktpl: Integer;
begin
  try
    (*
      FormChlayout.Aktpressname := tnames1.pressnameIDtoname(plateframespressid);
      FormChlayout.Curtemplate  := PlatetemplateArray[aktpl].TemplateName;
      IF FormChlayout.ShowModal = mrok then
      begin
      For Iplf := 1 to Nplateframes do
      begin
      For impl := 0 to plateframes[iplf].PBExListview1.Items.Count-1 do
      begin
      IF plateframes[iplf].PBExListview1.Items[impl].Selected then
      begin
      iplt := ImagenumbertoIPL(Iplf,impl);
      For icp := 0 to plateframesdata[iplf].prodplates[iplt].Ncopies-1 do
      begin
      ipl := icp+iplt;
      plateframesdata[iplf].prodplates[ipl].FlatProofConfigurationListid := -1;

      end;
      end;
      End;
      end;

      plateviewimage.Width := 23;    //204
      plateviewimage.height := 51;   //176
      For i := 1 to Nplateframes do
      begin
      plateframes[i].PBExListview1.clear;
      plateframes[i].ImageListplanframe.Clear;
      drawtheplates(plateframes[i],CheckBoxsmallimagesinEdit.Checked);
      end;
      End;
    *)
  Finally
  end;
end;

Function TFormprodplan.CheckTowers: Boolean;
var
  iplf, ipl, ip, ic: Integer;
begin
  result := true;
  For iplf := 1 to Nplateframes do
  begin
    For ipl := 0 to plateframes[iplf].NProdPlates do
    begin
      IF plateframesdata[iplf].ProdPlates[ipl].Tower = -1 then
      Begin
        result := false;
        exit;
      End;
    end;
  end;
end;

procedure TFormprodplan.ChangeEditions;
Var
  edid, ied, iplf, ipl, ip, pidx: Integer;
Begin
  for pidx := 0 to Formloadpressplan.ListViewbefore.items.count - 1 do
  begin
    edid := tnames1.editionnametoid(Formloadpressplan.ListViewbefore.items[pidx]
      .subitems[0]);
    for iplf := 1 to Nplateframes do
    begin
      for ipl := 0 to plateframes[iplf].NProdPlates do
      begin
        if (plateframesdata[iplf].ProdPlates[ipl].editionid = edid) then
          plateframesdata[iplf].ProdPlates[ipl].editionid :=
            tnames1.editionnametoid(Formloadpressplan.PBExListview1.items[pidx]
            .subitems[0]);

        for ip := 1 to PlatetemplateArray
          [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
        begin
          if (plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
            .Orgeditionid = edid) then
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Orgeditionid :=
              tnames1.editionnametoid(Formloadpressplan.PBExListview1.items
              [pidx].subitems[0]);
        end;
      end;
    end;
  end;

  for ied := 1 to Formloadpressplan.NEdchanges do
  begin
    for iplf := 1 to Nplateframes do
    begin
      for ipl := 0 to plateframes[iplf].NProdPlates do
      begin
        if plateframesdata[iplf].ProdPlates[ipl].editionid = Formloadpressplan.
          Edchanges[ied].fromed then
          plateframesdata[iplf].ProdPlates[ipl].editionid :=
            Formloadpressplan.Edchanges[ied].toed;
      end;
    end;
  end;

  // NAN change! overrule by setting selected eidtion from new dropdown 20141210
  if (Prefs.SimplePlanLoad) then
  begin
    edid := tnames1.editionnametoid
      (Formloadpressplan.ComboBoxEditionSelection.Text);
    if (edid > 0) then
    begin
      For iplf := 1 to Nplateframes do
      begin
        for ipl := 0 to plateframes[iplf].NProdPlates do
        begin
          plateframesdata[iplf].ProdPlates[ipl].editionid := edid;
        end;
      end;
    end;
  end;

end;

procedure TFormprodplan.ChangeEditionsSTB;
Var
  edid, ied, iplf, ipl, ip, pidx: Integer;

Begin
  for pidx := 0 to Formloadstbplan.ListViewbefore.items.count - 1 do
  begin
    edid := tnames1.editionnametoid(Formloadstbplan.ListViewbefore.items[pidx]
      .subitems[0]);
    For iplf := 1 to Nplateframes do
    begin
      For ipl := 0 to plateframes[iplf].NProdPlates do
      begin
        if (plateframesdata[iplf].ProdPlates[ipl].editionid = edid) then
          plateframesdata[iplf].ProdPlates[ipl].editionid :=
            tnames1.editionnametoid(Formloadstbplan.PBExListview1.items[pidx].subitems[0]);
        for ip := 1 to PlatetemplateArray
          [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
        begin
          if (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Orgeditionid = edid) then
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Orgeditionid :=
              tnames1.editionnametoid(Formloadstbplan.PBExListview1.items[pidx].subitems[0]);
        End;
      End;
    End;
  End;

  For ied := 1 to Formloadstbplan.NEdchanges do
  begin
    For iplf := 1 to Nplateframes do
    begin
      For ipl := 0 to plateframes[iplf].NProdPlates do
      begin
        IF plateframesdata[iplf].ProdPlates[ipl].editionid = Formloadstbplan.Edchanges[ied].fromed then
        begin
          plateframesdata[iplf].ProdPlates[ipl].editionid := Formloadstbplan.Edchanges[ied].toed;

        End;
      End;
    End;
  End;
end;

procedure TFormprodplan.ChangeSections;
Var
  Nsectionpidx: Integer;
  sectionpidx: array [1 .. 512] of record Pageindex: Integer;
  sectionid: Integer;
end;
iplf, ipl, np, I, ip, nedsec, pidx, secoffset, Secid, edid: Integer;

Begin

  IF plateframes[1].inserted = 1 then
  begin
    Nsectionpidx := Formeditplan.Maxpages;
    secoffset := 0;

    for I := 0 to Formloadpressplan.PBExListview1.items.count - 1 do
    begin
      pidx := 1;
      np := StrToInt(Formloadpressplan.PBExListview1.items[I].subitems[2]);
      Secid := tnames1.sectionnametoid(Formloadpressplan.PBExListview1.items[I]
        .subitems[1]);
      For ip := 1 to np div 2 do
      begin
        sectionpidx[secoffset + ip].Pageindex := ip;
        sectionpidx[secoffset + ip].sectionid := Secid;
      end;

      For ip := 1 to np div 2 do
      begin
        sectionpidx[(Nsectionpidx - (secoffset + ip)) + 1].Pageindex :=
          ((np + 1) - ip);
        sectionpidx[(Nsectionpidx - (secoffset + ip)) + 1].sectionid := Secid;
      end;
      Inc(secoffset, (np Div 2));
    end;

    For iplf := 1 to Nplateframes do
    begin
      For ipl := 0 to plateframes[iplf].NProdPlates do
      begin
        for ip := 1 to PlatetemplateArray
          [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
        begin
          for I := 1 to Nsectionpidx do
          begin
            IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].orgpageindex = (I)
            then
            begin
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename :=
                inttostr(sectionpidx[I].Pageindex);
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Pageindex :=
                sectionpidx[I].Pageindex;
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].sectionid :=
                sectionpidx[I].sectionid;
              break;
            End;
          End;
        End;
      End;
    End;
  End
  else
  begin
    for pidx := 0 to Formloadpressplan.ListViewbefore.items.count - 1 do
    begin
      Secid := tnames1.sectionnametoid(Formloadpressplan.ListViewbefore.items
        [pidx].subitems[1]);
      edid := tnames1.editionnametoid(Formloadpressplan.ListViewbefore.items
        [pidx].subitems[0]);
      For iplf := 1 to Nplateframes do
      begin
        For ipl := 0 to plateframes[iplf].NProdPlates do
        begin
          if (plateframesdata[iplf].ProdPlates[ipl].editionid = edid) or
            (Formloadpressplan.CheckBoxignoreplanedition.checked) then
          begin
            for ip := 1 to PlatetemplateArray
              [plateframesdata[iplf].ProdPlates[ipl].templatelistid]
              .NupOnplate do
            begin
              if (plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                .sectionid = Secid) then
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].sectionid :=
                  tnames1.sectionnametoid(Formloadpressplan.PBExListview1.items
                  [pidx].subitems[1])
            End;
          End;
        End;
      End;
    End;
  end;
end;

procedure TFormprodplan.ChangeSectionsSTB;
Var
  Nsectionpidx: Integer;
  sectionpidx: array [1 .. 512] of record Pageindex: Integer;
  sectionid: Integer;
end;
iplf, ipl, np, I, ip, nedsec, pidx, secoffset, Secid, edid: Integer;

Begin

  IF plateframes[1].inserted = 1 then
  begin
    Nsectionpidx := Formeditplan.Maxpages;
    secoffset := 0;

    for I := 0 to Formloadstbplan.PBExListview1.items.count - 1 do
    begin
      pidx := 1;
      np := StrToInt(Formloadstbplan.PBExListview1.items[I].subitems[2]);
      Secid := tnames1.sectionnametoid(Formloadstbplan.PBExListview1.items[I].subitems[1]);
      For ip := 1 to np div 2 do
      begin
        sectionpidx[secoffset + ip].Pageindex := ip;
        sectionpidx[secoffset + ip].sectionid := Secid;
      end;

      For ip := 1 to np div 2 do
      begin
        sectionpidx[(Nsectionpidx - (secoffset + ip)) + 1].Pageindex := ((np + 1) - ip);
        sectionpidx[(Nsectionpidx - (secoffset + ip)) + 1].sectionid := Secid;
      end;
      Inc(secoffset, (np Div 2));
    end;

    For iplf := 1 to Nplateframes do
    begin
      For ipl := 0 to plateframes[iplf].NProdPlates do
      begin
        for ip := 1 to PlatetemplateArray
          [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
        begin
          for I := 1 to Nsectionpidx do
          begin
            IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].orgpageindex = (I)
            then
            begin
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename := inttostr(sectionpidx[I].Pageindex);
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Pageindex := sectionpidx[I].Pageindex;
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].sectionid := sectionpidx[I].sectionid;
              break;
            End;
          End;
        End;
      End;
    End;
  End
  else
  begin
    for pidx := 0 to Formloadstbplan.ListViewbefore.items.count - 1 do
    begin
      Secid := tnames1.sectionnametoid(Formloadstbplan.ListViewbefore.items[pidx].subitems[1]);
      edid := tnames1.editionnametoid(Formloadstbplan.ListViewbefore.items[pidx].subitems[0]);
      For iplf := 1 to Nplateframes do
      begin
        For ipl := 0 to plateframes[iplf].NProdPlates do
        begin
          if (plateframesdata[iplf].ProdPlates[ipl].editionid = edid) or
            (Formloadstbplan.CheckBoxignoreplanedition.checked) then
          begin
            for ip := 1 to PlatetemplateArray
              [plateframesdata[iplf].ProdPlates[ipl].templatelistid]
              .NupOnplate do
            begin
              if (plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                .sectionid = Secid) then
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].sectionid :=
                  tnames1.sectionnametoid(Formloadstbplan.PBExListview1.items
                  [pidx].subitems[1])
            End;
          End;
        End;
      End;
    End;
  end;
end;

procedure TFormprodplan.ActionSetPressRunDataExecute(Sender: TObject);
Var
  iplf: Integer;
begin
  if Formpressruninfo.ShowModal = mrok then
  begin
    For iplf := 1 to Nplateframes do
    begin
      if plateframes[iplf].Selected then
      begin
        plateframes[iplf].Comment := Formpressruninfo.ComboBoxComment.Text;
        plateframes[iplf].PressConfignameX :=
          Formpressruninfo.ComboBoxPressConfigname.Text;
      end;
    End;
  end;
end;

procedure TFormprodplan.ActionSwapPagesExecute(Sender: TObject);
Var
  np, fromip, toip, IPH, IPV, ip, iplf, ipl, pa, pd: Integer;

  Pagebuf: Tprodpage;

begin

  For iplf := 1 to Nplateframes do
  begin
    For ipl := 0 to plateframes[iplf].PBExListview1.items.count - 1 do
    begin
      IF plateframes[iplf].PBExListview1.items[ipl].Selected then
      begin
        pa := PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl]
          .templatelistid].PagesAcross;
        pd := PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl]
          .templatelistid].PagesDown;
        np := pa * pd;
        if (np = 2) then
        begin
          Pagebuf := plateframesdata[iplf].ProdPlates[ipl].Pages[1];
          plateframesdata[iplf].ProdPlates[ipl].Pages[1] :=
            plateframesdata[iplf].ProdPlates[ipl].Pages[2];
          plateframesdata[iplf].ProdPlates[ipl].Pages[2] := Pagebuf;
        end
        else
        begin
          For IPV := 1 to pd div 2 do
          begin
            For IPH := 1 to pa do
            begin
              fromip := (((IPV - 1) * pa) + IPH);
              toip := (np - (IPV * pa)) + IPH;

              Pagebuf := plateframesdata[iplf].ProdPlates[ipl].Pages[fromip];
              plateframesdata[iplf].ProdPlates[ipl].Pages[fromip] :=
                plateframesdata[iplf].ProdPlates[ipl].Pages[toip];
              plateframesdata[iplf].ProdPlates[ipl].Pages[toip] := Pagebuf;
            end;
          End;
        end;
      End;
    End;
  End;
  plateviewimage.Width := 23; // 204
  plateviewimage.Height := 51; // 176
  For iplf := 1 to Nplateframes do
  begin
    plateframes[iplf].PBExListview1.clear;
    plateframes[iplf].ImageListplanframe.clear;
    DrawThePlates(CheckBoxsmallimagesinEdit.checked, iplf);
  end;

end;

procedure TFormprodplan.ActionSwapFrontBackExecute(Sender: TObject);
Var
  np, fromip, toip, IPH, IPV, ip, iplf, ipl, pa, pd: Integer;

  Pagebuf: Tprodpage;

begin

  For iplf := 1 to Nplateframes do
  begin
    For ipl := 0 to plateframes[iplf].PBExListview1.items.count - 1 do
    begin
      if plateframes[iplf].PBExListview1.items[ipl].Selected then
        plateframesdata[iplf].ProdPlates[ipl].Front :=
          Integer(not Boolean(plateframesdata[iplf].ProdPlates[ipl].Front));
    end;
  end;
  plateviewimage.Width := 23; // 204
  plateviewimage.Height := 51; // 176
  For iplf := 1 to Nplateframes do
  begin
    plateframes[iplf].PBExListview1.clear;
    plateframes[iplf].ImageListplanframe.clear;
    DrawThePlates(CheckBoxsmallimagesinEdit.checked, iplf);
  end;

end;

procedure TFormprodplan.ActionEditPagesExecute(Sender: TObject);
begin
  Actioneditpages.checked := Not Actioneditpages.checked;

  if Actioneditpages.checked then
    ActionMovepages.checked := false;
end;

Procedure TFormprodplan.EditPageName(iplf: Integer; ipl: Integer; ip: Integer);
Var
  I: Integer;
  T: String;
  ikketal: Boolean;
Begin
  if (iplf < 1) or (iplf > Nplateframes) then
    exit;
  if plateframes[iplf].PBExListview1.Selected = nil then
    exit;
  if (ipl < 0) or (ipl > plateframes[iplf].NProdPlates) then
    exit;
  if (ip < 0) or (ip > PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl]
    .templatelistid].NupOnplate) then
    exit;

  (*
    plateframes[iplf].Edit1.Left := plateframesdata[iplf].prodplates[ipl].pages[ip].position.Left+4 +
    ( plateframes[iplf].PBExListview1.Items[ipl].Left);
    plateframes[iplf].Edit1.top := (plateframesdata[iplf].prodplates[ipl].pages[ip].position.Bottom-edit1.Height)-8+
    ( plateframes[iplf].PBExListview1.Items[ipl].top);
    plateframes[iplf].Edit1.Parent := plateframes[iplf].PBExListview1;
    plateframes[iplf].Edit1.Visible := true;
  *)

  Formplaneditpagename.Edit1.Text := plateframesdata[iplf].ProdPlates[ipl].Pages
    [ip].pagename;
  (*
    Formplaneditpagename.Left := plateframes[iplf].PBExListview1.Items[ipl].DisplayRect(drBounds	).Left
    +plateframes[iplf].PBExListview1.Left+plateframes[iplf].left;
    Formplaneditpagename.top := plateframes[iplf].PBExListview1.Items[ipl].DisplayRect(drBounds	).top+
    plateframes[iplf].PBExListview1.Top+plateframes[iplf].Top;
  *)
  if Formplaneditpagename.ShowModal = mrok then
  begin
    T := Formplaneditpagename.Edit1.Text;
    if (T <> '') then
    begin
      if (T = '0') then
      begin
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename := 'Dinkey' +
          inttostr((iplf * 100) + Numberofhalfweb);
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype := 3;
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors := 1;
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[1].ColorID := 6;

      end
      else
      begin
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename := T;
        if (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype = 3) then
        begin
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype := 0;
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors := 4;
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[1]
            .ColorID := 1;
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[2]
            .ColorID := 2;
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[3]
            .ColorID := 3;
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[4]
            .ColorID := 4;
        end;
      end;

      ikketal := false;
      for I := 1 to length(T) do
      begin
        IF not(T[I] in tal) then
        begin
          ikketal := true;
        end;
      end;
      if not ikketal then
      begin
        IgnorePagicheck := true;
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Pageindex :=
          StrToInt(Formplaneditpagename.Edit1.Text);
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagina :=
          StrToInt(Formplaneditpagename.Edit1.Text);
      end;
    end;
  end;
end;

Procedure TFormprodplan.GenMiscstring; // laver et platenumber i miscsring1
Var
  platename: string;
  iplf, ipl, ip, ic: Integer;
  Akted, Icount, miscstringI: Integer;
Begin
  if (Prefs.PlanningGeneratePlateNames) then
  begin
    Icount := 0;
    Akted := -1;
    for iplf := 1 to Nplateframes do
    begin
      if (Prefs.PlateNameRestartOnEachRun) then
        Icount := 0;
      for ipl := 0 to plateframes[iplf].NProdPlates do
      begin
        if Akted <> plateframesdata[iplf].ProdPlates[ipl].editionid then
        begin
          Akted := plateframesdata[iplf].ProdPlates[ipl].editionid;
          Icount := 0;
        end;

        if plateframesdata[iplf].ProdPlates[ipl].Copynumber = 1 then
          Inc(Icount);

        platename := inttostr(Icount);
        if Prefs.MinimumPlatenameLength > 0 then
        begin
          while length(platename) < Prefs.MinimumPlatenameLength do
            platename := '0' + platename;
        end;
        miscstringI := SetPlanIDFromname(6, platename);
        for ip := 1 to PlatetemplateArray
          [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
        begin
          for ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
            .Ncolors do
          begin
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
              .Miscstring1 := miscstringI;
          end;
        end;
      end;
    end;
  end;
end;

{ procedure TFormprodplan.Writeplanfile;
  Begin

  end;
}

{ Procedure TFormprodplan.Allcolors;

  procedure AddInactiveColor(Iplf,ipl,ip,colorid : Integer);
  Var
  ic : Integer;
  Begin

  Inc(plateframesdata[iplf].prodplates[ipl].Pages[ip].Ncolors);
  ic := plateframesdata[iplf].prodplates[ipl].Pages[ip].Ncolors;

  plateframesdata[iplf].prodplates[ipl].Pages[ip].colors[ic].colorid := colorid;
  plateframesdata[iplf].prodplates[ipl].Pages[ip].colors[ic].active :=0; //!
  plateframesdata[iplf].prodplates[ipl].Pages[ip].colors[ic].Separation := 0;
  plateframesdata[iplf].prodplates[ipl].Pages[ip].colors[ic].FlatSeparation := 0;
  plateframesdata[iplf].prodplates[ipl].Pages[ip].colors[ic].Layer :=0;
  plateframesdata[iplf].prodplates[ipl].Pages[ip].colors[ic].OrgeditionID := plateframesdata[iplf].prodplates[ipl].Pages[ip].colors[1].OrgeditionID;
  plateframesdata[iplf].prodplates[ipl].Pages[ip].colors[ic].DoubleBurned := false;
  plateframesdata[iplf].prodplates[ipl].Pages[ip].colors[ic].copynumber := plateframesdata[iplf].prodplates[ipl].Copynumber;
  plateframesdata[iplf].prodplates[ipl].Pages[ip].colors[ic].Uniquepage := plateframesdata[iplf].prodplates[ipl].Pages[ip].totUniquePage;
  plateframesdata[iplf].prodplates[ipl].Pages[ip].colors[ic].status := 0;
  plateframesdata[iplf].prodplates[ipl].Pages[ip].colors[ic].Proofstatus :=0;
  plateframesdata[iplf].prodplates[ipl].Pages[ip].colors[ic].Approved    :=0;
  plateframesdata[iplf].prodplates[ipl].Pages[ip].colors[ic].priority    := plateframesdata[iplf].prodplates[ipl].Pages[ip].colors[1].priority;
  plateframesdata[iplf].prodplates[ipl].Pages[ip].colors[ic].Hold        := plateframesdata[iplf].prodplates[ipl].Pages[ip].colors[1].hold;
  plateframesdata[iplf].prodplates[ipl].Pages[ip].colors[ic].stackpos := plateframesdata[iplf].prodplates[ipl].Pages[ip].colors[1].stackpos;
  plateframesdata[iplf].prodplates[ipl].Pages[ip].colors[ic].High  := plateframesdata[iplf].prodplates[ipl].Pages[ip].colors[1].high;
  plateframesdata[iplf].prodplates[ipl].Pages[ip].colors[ic].Cylinder := plateframesdata[iplf].prodplates[ipl].Pages[ip].colors[1].Cylinder;

  //  plateframesdata[iplf].prodplates[ipl].Zone := plateframesdata[iplf].prodplates[ipl].Zone;
  //  plateframesdata[iplf].prodplates[ipl].Tower := plateframesdata[iplf].prodplates[ipl].tower;

  end;


  // Actual procedure body

  var
  iplf,ipl,ip,ic : Integer;
  found : array[1..4] of boolean;
  begin

  for iplf := 1 to Nplateframes do
  begin
  For ipl := 0 to plateframes[iplf].Nprodplates do
  begin
  for ip := 1 to PlatetemplateArray[plateframesdata[iplf].prodplates[ipl].templatelistid].NupOnplate do
  begin
  if plateframesdata[iplf].prodplates[ipl].pages[ip].Ncolors < 4 then
  begin
  For ic := 1 to 4 do
  begin
  Found[ic] := false;
  end;
  for ic := 1 to plateframesdata[iplf].prodplates[ipl].pages[ip].Ncolors do
  begin
  if (plateframesdata[iplf].prodplates[ipl].pages[ip].colors[ic].colorid < 5) and
  (plateframesdata[iplf].prodplates[ipl].pages[ip].colors[ic].colorid > 0) then
  begin
  Found[plateframesdata[iplf].prodplates[ipl].pages[ip].colors[ic].colorid] := true;
  end;
  End;

  for ic := 1 to 4 do
  begin
  if not Found[ic] then
  begin
  addInactivecolor(Iplf,ipl,ip,IC);
  end;
  end;

  End;
  End;
  End;
  End;
  End;

}
Function TFormprodplan.PlanContainsMultiblesections: Boolean;
Var
  iplf, ip, nSections: Integer;
  sec1: Integer;
Begin
  result := false;

  sec1 := -1;
  for iplf := 1 to Nplateframes do
  begin
    for ip := 1 to planpagenames[iplf].Npages do
    begin
      if sec1 = -1 then
      begin
        sec1 := planpagenames[iplf].Pages[ip].sectionid;
      end
      else
      begin
        if planpagenames[iplf].Pages[ip].sectionid = sec1 then
        begin
          result := true;
          break;
        end;
      end;
    end;
    if result then
      break;
  end;
end;

Function TFormprodplan.AddExtraRunToPages: Boolean;

Var
  PNN, Ipage, I, isec, iflat, isgn, ihwsign: Integer;
  Npresssec, nsection, npage, ncolor: ttreenode;
  T: string;
  ip, nh, Nup: Integer;
  IPBExListviewSections, ispl, nispl, npinisec: Integer;
  numberofsections, cursectionI: Integer;

  np, nis, iis, ipoffset: Integer;
  aktcombsec: string;
  pplus, pofspl, fromtop, topI, akttop, namedoffset: Integer;
  coveroffset, insertoffset: array [0 .. 200] of Integer;
  presssecionnumber: Integer;
  newed: Boolean;

  pagina, aktedid, aktsecid, iplf: Integer;

  isplit: Boolean;
  PNT: String;

  nsectocalc, presssecoffset: Integer;
  Ntoprepare: Integer;
  ini: tinifile;
  FixHWMin, FixHWPage: Integer;

begin
  pplus := 0;
  ipoffset := 0;
  presssecoffset := 0;
  Addrunfromsec := Nplanpagesections + 1;

  for iplf := 1 to Nplanpagesections do
  begin
    for ip := 1 to planpagenames[iplf].Npages do
    begin
      if presssecoffset < planpagenames[iplf].Pages[ip].presssecionnumber then
        presssecoffset := planpagenames[iplf].Pages[ip].presssecionnumber;
    end;
  end;

  numberofsections := Nplanpagesections;
  formmain.planlogging('Newimpositioncalulation');
  for I := 1 to MAXSECTIONS do
  begin
    for Ipage := 0 to 256 do
    begin
      planpagenames[I].Pages[Ipage].Pageindex := 0;
    end;
  end;

  for isec := 0 to FormAddextrapressrun.PBExListviewSections.items.count - 1 do
  begin
    if FormAddextrapressrun.PBExListviewSections.items[isec].subitems.count < 7
    then
      FormAddextrapressrun.PBExListviewSections.items[isec].subitems.add('');

    coveroffset[isec] :=
      StrToInt(FormAddextrapressrun.PBExListviewSections.items[isec].subitems
      [3]) div 2;

    if (FormAddextrapressrun.PBExListviewSections.items[isec].subitems[6] <> '')
    then
    begin
      coveroffset[isec] := 0;
      namedoffset := StrToInt(FormAddextrapressrun.PBExListviewSections.items
        [isec].subitems[3]) div 2;
    end;
    insertoffset[isec] :=
      StrToInt(FormAddextrapressrun.PBExListviewSections.items[isec].subitems[4]
      ) + coveroffset[isec];
  end;
  cursectionI := numberofsections; // det samme som nul
  np := 0;
  aktcombsec := '';
  if FormAddextrapressrun.Oldstyleinsert then
  begin

    presssecionnumber := presssecoffset;
    iis := 0;
    cursectionI := numberofsections + 1; // det samme som 1
    planpagenames[cursectionI].Npages := 0;

    planpagenames[cursectionI].editionid :=
      tnames1.editionnametoid(FormAddextrapressrun.ComboBoxedition.Text);
    planpagenames[cursectionI].newedition := true;
    np := 0;
    Inc(presssecionnumber);
    for isec := 0 to FormAddextrapressrun.PBExListviewSections.items.
      count - 1 do
    begin
      T := FormAddextrapressrun.PBExListviewSections.items[isec].subitems[0];
      npinisec := FormAddextrapressrun.npagestrtonpages(T, nispl);
      planpagenames[cursectionI].Npages := planpagenames[cursectionI].Npages
        + npinisec;
      planpagenames[cursectionI].Nhalfwebpage := 0;
    end;

    for isec := 0 to FormAddextrapressrun.PBExListviewSections.items.
      count - 1 do
    begin
      T := FormAddextrapressrun.PBExListviewSections.items[isec].subitems[0];
      npinisec := FormAddextrapressrun.npagestrtonpages(T, nispl);
      planpagenames[cursectionI].Pages[0].name := 'Dinky';
      planpagenames[cursectionI].Pages[0].Orgeditionid :=
        planpagenames[cursectionI].editionid;
      planpagenames[cursectionI].Pages[0].seci := isec;
      planpagenames[cursectionI].Pages[0].sectionid :=
        tnames1.sectionnametoid(FormAddextrapressrun.PBExListviewSections.items
        [isec].Caption);
      planpagenames[cursectionI].Pages[0].presssecionnumber :=
        presssecionnumber;

      namedoffset := 0;
      if (FormAddextrapressrun.PBExListviewSections.items[isec].subitems[6]
        <> '') then
      begin
        coveroffset[isec] := 0;
        namedoffset := StrToInt(FormAddextrapressrun.PBExListviewSections.items
          [isec].subitems[3]) div 2;
      end;
      insertoffset[isec] :=
        StrToInt(FormAddextrapressrun.PBExListviewSections.items[isec].subitems
        [4]) + coveroffset[isec];
      np := 0;
      if isec = FormAddextrapressrun.PBExListviewSections.items.count - 1 then
        nis := (FormAddextrapressrun.Commastrlist[1])
      Else
        nis := (FormAddextrapressrun.Commastrlist[1]) div 2;

      For ip := 1 to nis do
      begin
        Inc(iis);
        Inc(np);
        pofspl := np;
        IF iis < planpagenames[cursectionI].Npages div 2 then
          pofspl := pofspl + coveroffset[isec];
        IF iis > planpagenames[cursectionI].Npages div 2 then
          pofspl := pofspl + insertoffset[isec];

        IF (FormAddextrapressrun.PBExListviewSections.items[isec].subitems[6] <>
          '') and (namedoffset > 0) then
        Begin
          PNT := FormAddextrapressrun.PBExListviewSections.items[isec]
            .subitems[1];
          IF (pofspl <= namedoffset) OR
            (pofspl > planpagenames[cursectionI].Npages - namedoffset) then
          Begin
            PNT := PNT + 'C';
            IF (pofspl > planpagenames[cursectionI].Npages - namedoffset) then
              PNN := (namedoffset - (planpagenames[cursectionI].Npages - pofspl)
                ) + namedoffset
            else
              PNN := pofspl;
          End
          else
          Begin
            PNN := pofspl - namedoffset;
          End;
          PNN := PNN + StrToInt(FormAddextrapressrun.PBExListviewSections.items
            [isec].subitems[5]); // Offset
          PNT := PNT + inttostr(PNN) +
            FormAddextrapressrun.PBExListviewSections.items[isec].subitems[2];

          planpagenames[cursectionI].Pages[iis].name := PNT;
        end
        Else
        Begin
          planpagenames[cursectionI].Pages[iis].name :=
            FormAddextrapressrun.PBExListviewSections.items[isec].subitems[1] +
            inttostr(pofspl +
            StrToInt(FormAddextrapressrun.PBExListviewSections.items[isec]
            .subitems[5])) + FormAddextrapressrun.PBExListviewSections.items
            [isec].subitems[2];
        end;

        planpagenames[cursectionI].Pages[iis].Pageindex := pofspl +
          StrToInt(FormAddextrapressrun.PBExListviewSections.items[isec]
          .subitems[5]);

        planpagenames[cursectionI].Pages[iis].seci := isec;
        planpagenames[cursectionI].Pages[iis].sectionid :=
          tnames1.sectionnametoid
          (FormAddextrapressrun.PBExListviewSections.items[isec].Caption);
        planpagenames[cursectionI].Pages[iis].Orgeditionid :=
          tnames1.editionnametoid(FormAddextrapressrun.ComboBoxedition.Text);
        planpagenames[cursectionI].Pages[iis].presssecionnumber :=
          presssecionnumber;
      end;
    End;

    for isec := FormAddextrapressrun.PBExListviewSections.items.count -
      2 downto 0 do
    begin
      T := FormAddextrapressrun.PBExListviewSections.items[isec].subitems[0];
      npinisec := FormAddextrapressrun.npagestrtonpages(T, nispl);
      planpagenames[cursectionI].Pages[0].name := 'Dinky';
      planpagenames[cursectionI].Pages[0].Orgeditionid :=
        planpagenames[cursectionI].editionid;
      planpagenames[cursectionI].Pages[0].seci := isec;
      planpagenames[cursectionI].Pages[0].sectionid :=
        tnames1.sectionnametoid(FormAddextrapressrun.PBExListviewSections.items
        [isec].Caption);
      planpagenames[cursectionI].Pages[0].presssecionnumber :=
        presssecionnumber;
      coveroffset[isec] :=
        StrToInt(FormAddextrapressrun.PBExListviewSections.items[isec].subitems
        [3]) div 2;
      namedoffset := 0;
      if (FormAddextrapressrun.PBExListviewSections.items[isec].subitems[6]
        <> '') then
      begin
        coveroffset[isec] := 0;
        namedoffset := StrToInt(FormAddextrapressrun.PBExListviewSections.items
          [isec].subitems[3]) div 2;
      end;
      insertoffset[isec] :=
        StrToInt(FormAddextrapressrun.PBExListviewSections.items[isec].subitems
        [4]) + coveroffset[isec];

      nis := (FormAddextrapressrun.Commastrlist[1]) div 2;
      np := nis;
      for ip := 1 to nis do
      begin
        Inc(iis);
        Inc(np);
        pofspl := np;
        if iis < planpagenames[cursectionI].Npages div 2 then
          pofspl := pofspl + coveroffset[isec];

        if iis > planpagenames[cursectionI].Npages div 2 then
          pofspl := pofspl + insertoffset[isec];

        if (FormAddextrapressrun.PBExListviewSections.items[isec].subitems[6] <>
          '') and (namedoffset > 0) then
        begin
          PNT := FormAddextrapressrun.PBExListviewSections.items[isec]
            .subitems[1];
          if (pofspl <= namedoffset) OR
            (pofspl > planpagenames[cursectionI].Npages - namedoffset) then
          begin
            PNT := PNT + 'C';
            if (pofspl > planpagenames[cursectionI].Npages - namedoffset) then
              PNN := (namedoffset - (planpagenames[cursectionI].Npages - pofspl)
                ) + namedoffset
            else
              PNN := pofspl;
          end
          else
          begin
            PNN := pofspl - namedoffset;
          end;
          PNN := PNN + StrToInt(FormAddextrapressrun.PBExListviewSections.items
            [isec].subitems[5]); // Offset
          PNT := PNT + inttostr(PNN) +
            FormAddextrapressrun.PBExListviewSections.items[isec].subitems[2];

          planpagenames[cursectionI].Pages[iis].name := PNT;
        end
        else
        begin
          planpagenames[cursectionI].Pages[iis].name :=
            FormAddextrapressrun.PBExListviewSections.items[isec].subitems[1] +
            inttostr(pofspl +
            StrToInt(FormAddextrapressrun.PBExListviewSections.items[isec]
            .subitems[5])) + FormAddextrapressrun.PBExListviewSections.items
            [isec].subitems[2];
        end;

        planpagenames[cursectionI].Pages[iis].Pageindex := pofspl +
          StrToInt(FormAddextrapressrun.PBExListviewSections.items[isec]
          .subitems[5]);

        planpagenames[cursectionI].Pages[iis].seci := isec;
        planpagenames[cursectionI].Pages[iis].presssecionnumber :=
          presssecionnumber;
        planpagenames[cursectionI].Pages[iis].sectionid :=
          tnames1.sectionnametoid
          (FormAddextrapressrun.PBExListviewSections.items[isec].Caption);
        planpagenames[cursectionI].Pages[iis].Orgeditionid :=
          tnames1.editionnametoid(FormAddextrapressrun.ComboBoxedition.Text);
      end;
    end;
  end
  else
  begin

    newed := true;
    presssecionnumber := presssecoffset;
    for isec := 0 to FormAddextrapressrun.PBExListviewSections.items.
      count - 1 do
    begin
      coveroffset[isec] :=
        StrToInt(FormAddextrapressrun.PBExListviewSections.items[isec].subitems
        [3]) div 2;
      namedoffset := 0;
      if (FormAddextrapressrun.PBExListviewSections.items[isec].subitems[6]
        <> '') then
      Begin
        coveroffset[isec] := 0;
        namedoffset := StrToInt(FormAddextrapressrun.PBExListviewSections.items
          [isec].subitems[3]) div 2;
      end;
      insertoffset[isec] :=
        StrToInt(FormAddextrapressrun.PBExListviewSections.items[isec].subitems
        [4]) + coveroffset[isec];
      T := FormAddextrapressrun.PBExListviewSections.items[isec].subitems[0];
      npinisec := FormAddextrapressrun.npagestrtonpages(T, nispl);
      fromtop := npinisec + 1;

      if nispl > 1 then
      begin
        np := 0;
        for ispl := 1 to nispl do
        begin
          Inc(cursectionI);

          planpagenames[cursectionI].Npages :=
            FormAddextrapressrun.Commastrlist[ispl];
          planpagenames[cursectionI].Nhalfwebpage := 0;
          planpagenames[cursectionI].editionid :=
            tnames1.editionnametoid(FormAddextrapressrun.ComboBoxedition.Text);
          planpagenames[cursectionI].newedition := true;
          newed := false;
          Inc(presssecionnumber);

          akttop := fromtop;
          topI := (planpagenames[cursectionI].Npages div 2) + 1;
          planpagenames[cursectionI].Pages[0].name := 'Dinky';
          planpagenames[cursectionI].Pages[0].Orgeditionid :=
            planpagenames[cursectionI].editionid;
          planpagenames[cursectionI].Pages[0].seci := isec;
          planpagenames[cursectionI].Pages[0].sectionid :=
            tnames1.sectionnametoid
            (FormAddextrapressrun.PBExListviewSections.items[isec].Caption);
          planpagenames[cursectionI].Pages[0].presssecionnumber :=
            presssecionnumber;

          for ip := 1 to planpagenames[cursectionI].Npages do
          begin
            if ip < planpagenames[cursectionI].Npages div 2 then
              pplus := coveroffset[isec];

            if ip > planpagenames[cursectionI].Npages div 2 then
              pplus := insertoffset[isec];

            if ip > planpagenames[cursectionI].Npages div 2 then
            begin
              Dec(fromtop);
              Dec(topI);
              pofspl := (akttop - topI) + pplus;
            end
            else
            begin
              Inc(np);
              pofspl := np + pplus;
            end;

            if (FormAddextrapressrun.PBExListviewSections.items[isec].subitems
              [6] <> '') and (namedoffset > 0) then
            begin
              PNT := FormAddextrapressrun.PBExListviewSections.items[isec]
                .subitems[1];
              if (pofspl <= namedoffset) OR
                (pofspl > planpagenames[cursectionI].Npages - namedoffset) then
              begin
                PNT := PNT + 'C';
                IF (pofspl > planpagenames[cursectionI].Npages - namedoffset)
                then
                  PNN := (namedoffset - (planpagenames[cursectionI].Npages -
                    pofspl)) + namedoffset
                else
                  PNN := pofspl;
              end
              else
              begin
                PNN := pofspl - namedoffset;
              end;
              PNN := PNN +
                StrToInt(FormAddextrapressrun.PBExListviewSections.items[isec]
                .subitems[5]); // Offset
              PNT := PNT + inttostr(PNN) +
                FormAddextrapressrun.PBExListviewSections.items[isec]
                .subitems[2];

              planpagenames[cursectionI].Pages[ip].name := PNT;
            end
            else
            begin
              planpagenames[cursectionI].Pages[ip].name :=
                FormAddextrapressrun.PBExListviewSections.items[isec].subitems
                [1] + inttostr
                (pofspl + StrToInt(FormAddextrapressrun.PBExListviewSections.
                items[isec].subitems[5])) +
                FormAddextrapressrun.PBExListviewSections.items[isec]
                .subitems[2];
            end;

            planpagenames[cursectionI].Pages[ip].Pageindex := pofspl +
              StrToInt(FormAddextrapressrun.PBExListviewSections.items[isec]
              .subitems[5]);
            planpagenames[cursectionI].Pages[ip].seci := isec;
            planpagenames[cursectionI].Pages[ip].sectionid :=
              tnames1.sectionnametoid
              (FormAddextrapressrun.PBExListviewSections.items[isec].Caption);
            planpagenames[cursectionI].Pages[ip].Orgeditionid :=
              tnames1.editionnametoid
              (FormAddextrapressrun.ComboBoxedition.Text);
            planpagenames[cursectionI].Pages[ip].presssecionnumber :=
              presssecionnumber;
          end;
        end;
      end
      else
      begin // ingen split
        if (cursectionI = Nplanpagesections) then // hvis den er lig med 0
        begin
          Inc(cursectionI);
          planpagenames[cursectionI].Npages := 0;
          planpagenames[cursectionI].editionid :=
            tnames1.editionnametoid(FormAddextrapressrun.ComboBoxedition.Text);
          planpagenames[cursectionI].newedition := true;
          newed := false;
          ipoffset := 0;
          np := 0;
        end
        else
        begin
          if (FormAddextrapressrun.CheckBoxCombinetoonerun.checked) then
          begin
            presssecionnumber := presssecoffset;
            if isec > 0 then
            begin
              if (FormAddextrapressrun.PBExListviewSections.items[isec]
                .Caption = FormAddextrapressrun.PBExListviewSections.items
                [isec - 1].Caption) then
              begin
                ipoffset := ipoffset + planpagenames[cursectionI].Npages;
              end
              else
              begin
                Inc(cursectionI);
                planpagenames[cursectionI].newedition := newed;
                newed := false;
                planpagenames[cursectionI].Npages := 0;
                ipoffset := 0;
                np := 0;
                presssecionnumber := presssecoffset;
              end;
            end
            else
            begin
              ipoffset := 0;
              Inc(cursectionI);
              planpagenames[cursectionI].newedition := newed;
              newed := false;
              planpagenames[cursectionI].Npages := 0;
              np := 0;
              presssecionnumber := presssecoffset;
            end;
          end
          else
          begin
            Inc(cursectionI);
            planpagenames[cursectionI].newedition := newed;
            newed := false;
            planpagenames[cursectionI].Npages := 0;
            ipoffset := 0;
            np := 0;
            presssecionnumber := presssecoffset;
          end;
        end;
        Inc(presssecionnumber);

        planpagenames[cursectionI].editionid :=
          tnames1.editionnametoid(FormAddextrapressrun.ComboBoxedition.Text);
        planpagenames[cursectionI].Npages := planpagenames[cursectionI].Npages +
          FormAddextrapressrun.Commastrlist[1];
        planpagenames[cursectionI].Nhalfwebpage := 0;
        planpagenames[cursectionI].Pages[0].name := 'Dinky';
        planpagenames[cursectionI].Pages[0].seci := isec;
        planpagenames[cursectionI].Pages[0].sectionid :=
          tnames1.sectionnametoid
          (FormAddextrapressrun.PBExListviewSections.items[isec].Caption);
        planpagenames[cursectionI].Pages[0].presssecionnumber :=
          presssecionnumber;
        planpagenames[cursectionI].Pages[0].Orgeditionid :=
          planpagenames[cursectionI].editionid;

        for ip := 1 to FormAddextrapressrun.Commastrlist[1] do
        begin
          Inc(np);
          pofspl := np;

          if ip <= planpagenames[cursectionI].Npages div 2 then
            pofspl := pofspl + coveroffset[isec];

          if ip > (planpagenames[cursectionI].Npages div 2) then
            pofspl := pofspl + insertoffset[isec];

          if (FormAddextrapressrun.PBExListviewSections.items[isec].subitems[6]
            <> '') and (namedoffset > 0) then
          begin
            PNT := FormAddextrapressrun.PBExListviewSections.items[isec]
              .subitems[1];
            if (pofspl <= namedoffset) OR
              (pofspl > planpagenames[cursectionI].Npages - namedoffset) then
            begin
              PNT := PNT + 'C';
              if (pofspl > planpagenames[cursectionI].Npages - namedoffset) then
                PNN := (namedoffset - (planpagenames[cursectionI].Npages -
                  pofspl)) + namedoffset
              else
                PNN := pofspl;
            end
            else
            begin
              PNN := pofspl - namedoffset;
            end;
            PNN := PNN +
              StrToInt(FormAddextrapressrun.PBExListviewSections.items[isec]
              .subitems[5]); // Offset
            PNT := PNT + inttostr(PNN) +
              FormAddextrapressrun.PBExListviewSections.items[isec].subitems[2];

            planpagenames[cursectionI].Pages[ip + ipoffset].name := PNT;
          end
          else
          begin
            planpagenames[cursectionI].Pages[ip + ipoffset].name :=
              FormAddextrapressrun.PBExListviewSections.items[isec].subitems[1]
              + inttostr
              (pofspl + StrToInt(FormAddextrapressrun.PBExListviewSections.items
              [isec].subitems[5])) + FormAddextrapressrun.PBExListviewSections.
              items[isec].subitems[2];
          end;

          planpagenames[cursectionI].Pages[ip + ipoffset].Pageindex :=
            pofspl + StrToInt(FormAddextrapressrun.PBExListviewSections.items
            [isec].subitems[5]);
          planpagenames[cursectionI].Pages[ip + ipoffset].seci := isec;
          planpagenames[cursectionI].Pages[ip + ipoffset].sectionid :=
            tnames1.sectionnametoid
            (FormAddextrapressrun.PBExListviewSections.items[isec].Caption);
          planpagenames[cursectionI].Pages[ip + ipoffset].Orgeditionid :=
            tnames1.editionnametoid(FormAddextrapressrun.ComboBoxedition.Text);
          planpagenames[cursectionI].Pages[ip + ipoffset].presssecionnumber :=
            presssecionnumber;
        end;
      end;
    end;
  end;

  nsectocalc := cursectionI - numberofsections;
  numberofsections := cursectionI;

  for I := Addrunfromsec to cursectionI do
  begin
    planpagenames[I].collection :=
      FormAddextrapressrun.RadioGroupcollection.ItemIndex;
    planpagenames[I].Prepaired :=
      FormAddextrapressrun.CheckBoxprepaired.checked;
    planpagenames[I].bindingstyle :=
      FormAddextrapressrun.CheckBoxbindingstyle.checked;
  end;

  Nup := PlatetemplateArray[addingplatelistid].NupOnplate;

  Nplanpagesections := numberofsections;

  splitsections := (FormAddextrapressrun.Multisecplan) and (nsectocalc > 1);

  // splitsections := (FormAddExtrapressrun.Multisecplan) and (numberofsections > 1);
  // (numberofsections > 1)

  AktPRODUCTION.nSectionsInProduction := nsectocalc;
  AktPRODUCTION.nGeneralPageOffset := 1;
  AktPRODUCTION.nCollectionMode := 0;
  AktPRODUCTION.nSplitmode := PlatetemplateArray[addingplatelistid].Splitmode;
  AktPRODUCTION.fCreepSetting := 100;
  Currentcreep := Formselecttemplate.Creep;

  for isec := 1 to AktPRODUCTION.nSectionsInProduction do
  begin

    AktPRODUCTION.aSections[isec].Nhalfwebpage :=
      planpagenames[isec + Addrunfromsec - 1].hw1;
    AktPRODUCTION.aSections[isec].nHalfWebPage2 :=
      planpagenames[isec + Addrunfromsec - 1].hw2;

    if PlatetemplateArray[addingplatelistid].ISdouble > 1 then
      AktPRODUCTION.aSections[isec].nPagesInSection :=
        planpagenames[isec + Addrunfromsec - 1].Npages * PlatetemplateArray
        [addingplatelistid].ISdouble
    else
      AktPRODUCTION.aSections[isec].nPagesInSection :=
        planpagenames[isec + Addrunfromsec - 1].Npages;

    MakingdoubleFrontback := PlatetemplateArray[addingplatelistid]
      .ISDoublefronttoback = 1;
    if PlatetemplateArray[addingplatelistid].Numberofblanks > 0 then
      AktPRODUCTION.aSections[isec].nPagesInSection :=
        planpagenames[isec + Addrunfromsec - 1].Npages + AktPRODUCTION.aSections
        [isec].nPagesInSection + PlatetemplateArray[addingplatelistid]
        .Numberofblanks;

    AktPRODUCTION.aSections[isec].nStartingPageNumber := 1;
    AktPRODUCTION.aSections[isec].nBindingStyle :=
      Integer(FormAddextrapressrun.CheckBoxbindingstyle.checked);
    AktPRODUCTION.aSections[isec].nFlatsInSection :=
      ((AktPRODUCTION.aSections[isec].nPagesInSection div Nup) div 2) +
      ((AktPRODUCTION.aSections[isec].nPagesInSection div Nup) MOD 2);

    AktPRODUCTION.aSections[isec].nFlatsInSection := AktPRODUCTION.aSections
      [isec].nFlatsInSection * 2;

    // planpagenames[isec+Addrunfromsec-1].hw1 := AktPRODUCTION.aSections[isec].nPagesInSection DIV nup;
    if (AktPRODUCTION.aSections[isec].nPagesInSection div Nup) mod Nup <> 0 then
    begin
      if ( Prefs.SpecialHalfwebMode = 0) then
      begin
          planpagenames[isec + Addrunfromsec - 1].hw1 := (AktPRODUCTION.aSections[isec].nPagesInSection DIV Nup);
      end;
      if ( Prefs.SpecialHalfwebMode = 1) then
      begin
      planpagenames[isec + Addrunfromsec - 1].hw1 :=
        (AktPRODUCTION.aSections[isec].nPagesInSection DIV Nup) - 1;
      end;

      // catch--
      if planpagenames[isec + Addrunfromsec - 1].hw1 < 0 then
        planpagenames[isec + Addrunfromsec - 1].hw1 := AktPRODUCTION.aSections
          [isec].nPagesInSection DIV Nup;
    end
    else
    begin
      planpagenames[isec + Addrunfromsec - 1].hw1 := 0;
      planpagenames[isec + Addrunfromsec - 1].hw2 := 0;
    end;
    // NY addrun hw

    FixHWMin := 0;
    FixHWPage := 0;
    if (Prefs.SpecialHalfwebMode  = 2)  then
    begin
      FixHWMin := Prefs.SpecialHalfwebAtMinPage;
      FixHWPage := Prefs.SpecialHalfwebAtFixedPage;
     if (FixHWPage < 1) then
            FixHWPage := 1;
          if (FixHWMin < 1) then
            FixHWMin := 1;
      // Set halfweb to ..... from ini file
      if (AktPRODUCTION.aSections[isec].nPagesInSection >= FixHWMin) And
        (FixHWMin > 0) then
      begin
        AktPRODUCTION.aSections[isec].Nhalfwebpage := FixHWPage;
        planpagenames[isec].hw1 := FixHWPage;
      end;
    end;
    { xxxx }

    if (AktPRODUCTION.aSections[isec].nPagesInSection mod Nup <> 0)
    { and (nup mod 3 <> 0) } then
    begin
      MessageDlg(formmain.InfraLanguage1.Translate
        ('Number of pages do not fit platelayout'), mtError, [mbOk], 0);
      exit;
    end;

    for iflat := 1 to AktPRODUCTION.aSections[isec].nFlatsInSection + 2 do
    begin

      NupCol := Nup;
      if AktPRODUCTION.nSplitmode > 0 then
        NupCol := Nup * 2;
      AktPRODUCTION.aSections[isec].aFlats[iflat].bIsDualSided := 1;
      AktPRODUCTION.aSections[isec].aFlats[iflat].nPagesPerSide := NupCol;

      for isgn := 1 to NupCol do
      begin
        AktPRODUCTION.aSections[isec].aFlats[iflat].aSignaturePages[isgn] :=
          PlatetemplateArray[addingplatelistid].PageNumberingFront[isgn];
      end;
      for isgn := 1 to NupCol do
      begin
        AktPRODUCTION.aSections[isec].aFlats[iflat].aSignaturePages
          [isgn + NupCol] := PlatetemplateArray[addingplatelistid]
          .PageNumberingback[isgn];
      end;
      For isgn := 1 to NupCol do
      begin
        AktPRODUCTION.aSections[isec].aFlats[iflat].aHalfwebSignaturePages[isgn]
          := PlatetemplateArray[addingplatelistid]
          .PageNumberingFrontHalfWeb[isgn];
      end;
      for isgn := 1 to NupCol do
      begin
        AktPRODUCTION.aSections[isec].aFlats[iflat].aHalfwebSignaturePages
          [isgn + NupCol] := PlatetemplateArray[addingplatelistid]
          .PageNumberingBackHalfWeb[isgn];
      end;
    end;
  end;
  if AktPRODUCTION.nSectionsInProduction = 0 then
    AktPRODUCTION.nSectionsInProduction := 1;

  for I := 1 to AktPRODUCTION.nSectionsInProduction do
  begin
    if AktPRODUCTION.aSections[I].nFlatsInSection = 0 then
      AktPRODUCTION.aSections[I].nFlatsInSection := 1;
  end;

  if doImposecalc then
    result := true
  else
    result := false;

  for isec := 1 to AktPRODUCTION.nSectionsInProduction do
  begin
    planpagenames[isec + Addrunfromsec - 1].hw1 := 32000;
    // if AktPRODUCTION.aSections[isec].nHalfWebPage > 0 then
    // begin

    // end;

    for iflat := 1 to AktPRODUCTION.aSections[isec].nFlatsInSection do
    begin
      for isgn := 1 to Nup do
      begin
        if AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages[isgn] = 0
        then
          Inc(planpagenames[isec + Addrunfromsec - 1].Nhalfwebpage);
      end;

      for isgn := 1 to Nup do
      Begin
        IF AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages
          [isgn + Nup] = 0 then
          Inc(planpagenames[isec + Addrunfromsec - 1].Nhalfwebpage);
      end;
    end;

    // planpagenames[isec+Addrunfromsec-1].hw1 := AktPRODUCTION.aSections[isec].nPagesInSection DIV nup;

    planpagenames[isec + Addrunfromsec - 1].hw1 :=
      (AktPRODUCTION.aSections[isec].nPagesInSection DIV Nup) - 1;
    if planpagenames[isec + Addrunfromsec - 1].hw1 < 0 then
      planpagenames[isec + Addrunfromsec - 1].hw1 := AktPRODUCTION.aSections
        [isec].nPagesInSection DIV Nup;

  end;

  // I := 1;
  // sleep(1*10);

End;

procedure TFormprodplan.AddExtrarunToPlates;

  function getplansectionname(isec: Integer): Integer;
  var
    T: string;
  begin
    T := FormAddextrapressrun.PBExListviewSections.items[isec].Caption;
    result := tnames1.sectionnametoid(T);
  end;

var
  iplf, ic, Iplateframe, isec, iflat, ifront, outp, sheet, isgn: Integer;
  nSections, nplates: Integer;
  Nsheet: Integer;

  I: Integer;
  pagetypes: TPageNumbering;
  antipanoposes: TPageNumbering;
  Nnewcolors: Integer;
  Nprods: Integer;
  icopy: Integer;
  Newcolors: Array [1 .. 100] of record ColorID: Integer;
  colorname: String;
  Doubleburn: Boolean;
end;

// Akteditionname : string;
HINprods, Aktncopies, Addrunoffset: Integer;
begin
  // NprodplatesSize     Fixed
  Addrunoffset := Addrunfromsec - 1;
  formmain.planlogging('Wizard to plates');
  try

    IF CheckBoxsmallimagesinEdit.checked then
      Pressviewzoom := 60
    else
      Pressviewzoom := 100;

    plateviewimage.Width := 23; // 204
    plateviewimage.Height := 51; // 176

    for I := 1 to PlatetemplateArray[addingplatelistid].NupOnplate do
    begin
      antipanoposes[I] := formmain.Supergetantipos(I, pagetypes,
        addingplatelistid, true);
    end;
    Nnewcolors := 0;

    for I := 0 to FormAddpressrun.CheckListBoxcolors.items.count - 1 do
    begin
      if FormAddpressrun.CheckListBoxcolors.checked[I] then
      begin
        Inc(Nnewcolors);
        Newcolors[Nnewcolors].ColorID :=
          tnames1.Colornametoid(FormAddpressrun.CheckListBoxcolors.items[I]);
        Newcolors[Nnewcolors].colorname :=
          FormAddpressrun.CheckListBoxcolors.items[I];
        Newcolors[Nnewcolors].Doubleburn := false;
      end;
    end;

    nplates := 0;
    Nsheet := 0;

    Addplateframes(ScrollBoxplan, AktPRODUCTION.nSectionsInProduction);

    Iplateframe := Nplateframes + 1;

    Nplateframes := Nplateframes + AktPRODUCTION.nSectionsInProduction;

    nSections := AktPRODUCTION.nSectionsInProduction;

    Numberofhalfweb := 0;

    HINprods := 0;

    for isec := 1 to AktPRODUCTION.nSectionsInProduction do
    begin
      Nprods := (AktPRODUCTION.aSections[isec].nFlatsInSection) * 2;
      if Nprods > HINprods then
        HINprods := Nprods;
    end;

    for isec := Addrunfromsec to (Addrunoffset +
      AktPRODUCTION.nSectionsInProduction) do
    begin
      formmain.Allocateprodplates(isec, HINprods + 32);
    end;

    for isec := 1 to AktPRODUCTION.nSectionsInProduction do
    begin
      sheet := 0;

      for iflat := 1 to AktPRODUCTION.aSections[isec].nFlatsInSection do
      begin
        Inc(sheet);
        Aktncopies := StrToInt(FormAddextrapressrun.editCopies.Text);
        plateframes[Iplateframe].Numberofcopies :=
          StrToInt(FormAddextrapressrun.editCopies.Text);
        for icopy := 1 to Aktncopies do
        begin
          Inc(plateframes[Iplateframe].NProdPlates);
          plateframesdata[Iplateframe].ProdPlates
            [plateframes[Iplateframe].NProdPlates].FlatProofConfigurationID :=
            plateframesdata[1].ProdPlates[0].FlatProofConfigurationID;
          plateframesdata[Iplateframe].ProdPlates
            [plateframes[Iplateframe].NProdPlates].sheetnumber := sheet;
          plateframesdata[Iplateframe].ProdPlates
            [plateframes[Iplateframe].NProdPlates].Front := 0;
          plateframesdata[Iplateframe].ProdPlates
            [plateframes[Iplateframe].NProdPlates].TrueFront := 0;
          plateframesdata[Iplateframe].ProdPlates
            [plateframes[Iplateframe].NProdPlates].templatelistid :=
            addingplatelistid;

          plateframesdata[Iplateframe].ProdPlates
            [plateframes[Iplateframe].NProdPlates].markgroups :=
            PlatetemplateArray[addingplatelistid].markgroups;
          plateframesdata[Iplateframe].ProdPlates
            [plateframes[Iplateframe].NProdPlates].Nmarkgroups :=
            PlatetemplateArray[addingplatelistid].Nmarkgroups;

          plateframesdata[Iplateframe].ProdPlates
            [plateframes[Iplateframe].NProdPlates].Copynumber := icopy;
          // plateframesdata[Iplateframe].prodplates[plateframes[iplateframe].Nprodplates].Ncopies  := Aktncopies;

          plateframesdata[Iplateframe].ProdPlates
            [plateframes[Iplateframe].NProdPlates].productionid := 0;
          plateframesdata[Iplateframe].ProdPlates
            [plateframes[Iplateframe].NProdPlates].publicationid :=
            Formaddplan.publicationid;

          plateframesdata[Iplateframe].ProdPlates
            [plateframes[Iplateframe].NProdPlates].Locationid :=
            plateframeslocationid;
          plateframesdata[Iplateframe].ProdPlates
            [plateframes[Iplateframe].NProdPlates].deviceid := 0;
          plateframesdata[Iplateframe].ProdPlates
            [plateframes[Iplateframe].NProdPlates].Pressid :=
            plateframespressid;
          plateframesdata[Iplateframe].ProdPlates
            [plateframes[Iplateframe].NProdPlates].runid := -99;
          plateframesdata[Iplateframe].ProdPlates
            [plateframes[Iplateframe].NProdPlates].produce := false;
          plateframesdata[Iplateframe].ProdPlates
            [plateframes[Iplateframe].NProdPlates].readytoproduce := false;
          plateframesdata[Iplateframe].ProdPlates
            [plateframes[Iplateframe].NProdPlates].someerror := false;
          plateframesdata[Iplateframe].ProdPlates
            [plateframes[Iplateframe].NProdPlates].totappr :=
            Formaddplan.RadioGroupApproval.ItemIndex - 1;
          plateframesdata[Iplateframe].ProdPlates
            [plateframes[Iplateframe].NProdPlates].totstat := 0;
          plateframesdata[Iplateframe].ProdPlates
            [plateframes[Iplateframe].NProdPlates].editionid :=
            planpagenames[Addrunoffset + isec].editionid;

          For isgn := 1 to AktPRODUCTION.aSections[isec].aFlats[iflat]
            .nPagesPerSide do // front
          Begin
            plateframesdata[Iplateframe].collection :=
              planpagenames[Addrunoffset + isec].collection;
            plateframesdata[Iplateframe].Prepaired :=
              planpagenames[Addrunoffset + isec].Prepaired;
            plateframesdata[Iplateframe].bindingstyle :=
              planpagenames[Addrunoffset + isec].bindingstyle;
            plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].Presssectionnumber :=
              planpagenames[Addrunoffset + isec].Pages
              [AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages[isgn]]
              .presssecionnumber;

            plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].Pages[isgn].pagename :=
              planpagenames[Addrunoffset + isec].Pages
              [AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages
              [isgn]].name;

            plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].Pages[isgn].pagina :=
              planpagenames[Addrunoffset + isec].Pages
              [AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages
              [isgn]].pagina;

            plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].Pages[isgn].Pageindex :=
              planpagenames[Addrunoffset + isec].Pages
              [AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages[isgn]]
              .Pageindex;
            plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].Pages[isgn].proofid :=
              plateframesdata[1].ProdPlates[0].Pages[1].proofid;
            plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].Pages[isgn].sectionid :=
              getplansectionname(planpagenames[Addrunoffset + isec].Pages
              [AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages
              [isgn]].seci);
            plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].Pages[isgn].Oldrunid := -1;
            plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].Pages[isgn].totapproval :=
              Formaddplan.RadioGroupApproval.ItemIndex - 1;
            plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].Pages[isgn].Anyheld :=
              Formaddplan.RadioGrouplocked.ItemIndex = 0;
            plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].Pages[isgn]
              .Antipanorama := 0;
            plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].Pages[isgn].pagetype := 0;
            plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].Pages[isgn].Creep :=
              AktPRODUCTION.aSections[isec].aFlats[iflat].aCreep[isgn];
            plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].Pages[isgn].Ncolors :=
              Nnewcolors;
            plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].Pages[isgn]
              .pagestatus := 0;
            plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].Pages[isgn]
              .proofed := false;
            plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].Pages[isgn].approved :=
              Formaddplan.RadioGroupApproval.ItemIndex - 1;
            plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].Pages[isgn]
              .pagechange := false;
            plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].Pages[isgn].Orgeditionid :=
              planpagenames[Addrunoffset + isec].Pages
              [AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages[isgn]]
              .Orgeditionid;

            IF plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].Pages[isgn]
              .Orgeditionid = plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].editionid then
            Begin
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn]
                .totUniquePage := 1;
              // nymast
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn]
                .MasterCopySeparationSet := plateframesdata[Iplateframe]
                .ProdPlates[plateframes[Iplateframe].NProdPlates].Pages[isgn]
                .CopySeparationSet;

            end
            else
            begin
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn]
                .totUniquePage := 0;
            end;

            For ic := 1 to Nnewcolors do
            begin
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[ic]
                .ColorID := Newcolors[ic].ColorID;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[ic]
                .DoubleBurned := Newcolors[ic].Doubleburn;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[ic]
                .Copynumber := icopy;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[ic]
                .Uniquepage := plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn]
                .totUniquePage;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[ic]
                .active := 1;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[ic]
                .status := 0;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[ic]
                .proofstatus := 0;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[ic]
                .Priority := 50;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[ic]
                .Hold := Formaddplan.RadioGrouplocked.ItemIndex;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[ic]
                .stackpos := SetPlanIDFromname(2,
                Formselecttemplate.ComboBoxstackpos.Text);
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Tower := -1;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[ic]
                .High := -1;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[ic]
                .Cylinder := -1;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Zone := -1;
            end;

            IF AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages[isgn] = 0
            then
            begin
              Inc(Numberofhalfweb);
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn]
                .pagetype := 3;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].pagename :=
                'Dinkey' + inttostr((Iplateframe * 100) + Numberofhalfweb);
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].Ncolors := 1;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn]
                .Oldrunid := -1;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[1]
                .ColorID := 6;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[1]
                .DoubleBurned := false;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[1]
                .Copynumber := icopy;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[1]
                .Uniquepage := plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn]
                .totUniquePage;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[1]
                .active := 1;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[1]
                .status := 0;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[1]
                .proofstatus := 0;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[1]
                .Priority := 50;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[1]
                .Hold := Formaddplan.RadioGrouplocked.ItemIndex;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[1]
                .stackpos := SetPlanIDFromname(2,
                Formselecttemplate.ComboBoxstackpos.Text);
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Tower := -1;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[1]
                .High := -1;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[1]
                .Cylinder := -1;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Zone := -1;
            end;

          End;

        End;
        for icopy := 1 to Aktncopies do
        begin

          // back

          Inc(plateframes[Iplateframe].NProdPlates);
          plateframesdata[Iplateframe].ProdPlates
            [plateframes[Iplateframe].NProdPlates].editionid :=
            planpagenames[Addrunoffset + isec].editionid;

          plateframesdata[Iplateframe].ProdPlates
            [plateframes[Iplateframe].NProdPlates].sheetnumber := sheet;
          plateframesdata[Iplateframe].ProdPlates
            [plateframes[Iplateframe].NProdPlates].Front := 1;
          plateframesdata[Iplateframe].ProdPlates
            [plateframes[Iplateframe].NProdPlates].TrueFront := 1;
          plateframesdata[Iplateframe].ProdPlates
            [plateframes[Iplateframe].NProdPlates].templatelistid :=
            addingplatelistid;
          plateframesdata[Iplateframe].ProdPlates
            [plateframes[Iplateframe].NProdPlates].Copynumber := icopy;
          // plateframesdata[Iplateframe].prodplates[plateframes[iplateframe].Nprodplates].Ncopies := aktncopies;

          plateframesdata[Iplateframe].ProdPlates
            [plateframes[Iplateframe].NProdPlates].productionid := 0;
          plateframesdata[Iplateframe].ProdPlates
            [plateframes[Iplateframe].NProdPlates].publicationid :=
            Formaddplan.publicationid;

          plateframesdata[Iplateframe].ProdPlates
            [plateframes[Iplateframe].NProdPlates].Locationid :=
            plateframeslocationid;
          plateframesdata[Iplateframe].ProdPlates
            [plateframes[Iplateframe].NProdPlates].deviceid := 0;
          plateframesdata[Iplateframe].ProdPlates
            [plateframes[Iplateframe].NProdPlates].Pressid :=
            plateframespressid;
          plateframesdata[Iplateframe].ProdPlates
            [plateframes[Iplateframe].NProdPlates].runid := -99;
          plateframesdata[Iplateframe].ProdPlates
            [plateframes[Iplateframe].NProdPlates].produce := false;
          plateframesdata[Iplateframe].ProdPlates
            [plateframes[Iplateframe].NProdPlates].readytoproduce := false;
          plateframesdata[Iplateframe].ProdPlates
            [plateframes[Iplateframe].NProdPlates].someerror := false;
          plateframesdata[Iplateframe].ProdPlates
            [plateframes[Iplateframe].NProdPlates].totappr :=
            Formaddplan.RadioGroupApproval.ItemIndex - 1;
          plateframesdata[Iplateframe].ProdPlates
            [plateframes[Iplateframe].NProdPlates].totstat := 0;

          For isgn := 1 to AktPRODUCTION.aSections[isec].aFlats[iflat]
            .nPagesPerSide do
          Begin
            plateframesdata[Iplateframe].collection :=
              planpagenames[Addrunoffset + isec].collection;
            plateframesdata[Iplateframe].Prepaired :=
              planpagenames[Addrunoffset + isec].Prepaired;
            plateframesdata[Iplateframe].bindingstyle :=
              planpagenames[Addrunoffset + isec].bindingstyle;

            plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].Presssectionnumber :=
              planpagenames[Addrunoffset + isec].Pages
              [AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages
              [isgn + AktPRODUCTION.aSections[isec].aFlats[iflat].nPagesPerSide]
              ].presssecionnumber;

            plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].Pages[isgn].pagename :=
              planpagenames[Addrunoffset + isec].Pages
              [AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages
              [isgn + AktPRODUCTION.aSections[isec].aFlats[iflat]
              .nPagesPerSide]].name;

            plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].Pages[isgn].pagina :=
              planpagenames[Addrunoffset + isec].Pages
              [AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages
              [isgn + AktPRODUCTION.aSections[isec].aFlats[iflat]
              .nPagesPerSide]].pagina;

            plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].Pages[isgn].Pageindex :=
              planpagenames[Addrunoffset + isec].Pages
              [AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages
              [isgn + AktPRODUCTION.aSections[isec].aFlats[iflat].nPagesPerSide]
              ].Pageindex;

            plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].Pages[isgn].sectionid :=
              getplansectionname(planpagenames[Addrunoffset + isec].Pages
              [AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages
              [isgn + AktPRODUCTION.aSections[isec].aFlats[iflat]
              .nPagesPerSide]].seci);

            plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].Pages[isgn].totapproval :=
              Formaddplan.RadioGroupApproval.ItemIndex - 1;
            plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].Pages[isgn].Oldrunid := -1;
            plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].Pages[isgn].Anyheld :=
              Formaddplan.RadioGrouplocked.ItemIndex = 0;
            plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].Pages[isgn]
              .Antipanorama := 0;
            plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].Pages[isgn].pagetype := 0;
            plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].Pages[isgn].Creep :=
              AktPRODUCTION.aSections[isec].aFlats[iflat].aCreep
              [isgn + AktPRODUCTION.aSections[isec].aFlats[iflat]
              .nPagesPerSide];
            plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].Pages[isgn].Ncolors :=
              Nnewcolors;
            plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].Pages[isgn]
              .pagestatus := 0;
            plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].Pages[isgn]
              .proofed := false;
            plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].Pages[isgn].approved :=
              Formaddplan.RadioGroupApproval.ItemIndex - 1;
            plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].Pages[isgn]
              .pagechange := false;

            plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].Pages[isgn].Orgeditionid :=
              planpagenames[Addrunoffset + isec].Pages
              [AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages
              [isgn + AktPRODUCTION.aSections[isec].aFlats[iflat].nPagesPerSide]
              ].Orgeditionid;

            IF plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].Pages[isgn]
              .Orgeditionid = plateframesdata[Iplateframe].ProdPlates
              [plateframes[Iplateframe].NProdPlates].editionid then
            Begin
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn]
                .totUniquePage := 1;
              // nymast
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn]
                .MasterCopySeparationSet := plateframesdata[Iplateframe]
                .ProdPlates[plateframes[Iplateframe].NProdPlates].Pages[isgn]
                .CopySeparationSet;
            end
            else
            begin
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn]
                .totUniquePage := 0;
            end;

            For ic := 1 to Nnewcolors do
            begin

              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[ic]
                .ColorID := Newcolors[ic].ColorID;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[ic]
                .DoubleBurned := Newcolors[ic].Doubleburn;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[ic]
                .Copynumber := icopy;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[ic]
                .Uniquepage := plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn]
                .totUniquePage;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[ic]
                .active := 1;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[ic]
                .status := 0;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[ic]
                .proofstatus := 0;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[ic]
                .Priority := 50;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[ic]
                .Hold := Formaddplan.RadioGrouplocked.ItemIndex;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[ic]
                .stackpos := SetPlanIDFromname(2,
                Formselecttemplate.ComboBoxstackpos.Text);

              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Tower := -1;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[ic]
                .High := -1;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[ic]
                .Cylinder := -1;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Zone := -1;
            end;

            IF AktPRODUCTION.aSections[isec].aFlats[iflat].aOutputPages
              [isgn + AktPRODUCTION.aSections[isec].aFlats[iflat]
              .nPagesPerSide] = 0 then
            begin
              Inc(Numberofhalfweb);
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn]
                .pagetype := 3;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].pagename :=
                'Dinkey' + inttostr((Iplateframe * 100) + Numberofhalfweb);
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].Ncolors := 1;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn]
                .Oldrunid := -1;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[1]
                .ColorID := 6;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[1]
                .DoubleBurned := Newcolors[1].Doubleburn;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[1]
                .Copynumber := icopy;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[1]
                .Uniquepage := plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn]
                .totUniquePage;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[1]
                .active := 1;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[1]
                .status := 0;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[1]
                .proofstatus := 0;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[1]
                .Priority := 50;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[1]
                .Hold := Formaddplan.RadioGrouplocked.ItemIndex;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[1]
                .stackpos := SetPlanIDFromname(2,
                Formselecttemplate.ComboBoxstackpos.Text);
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Tower := -1;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[1]
                .High := -1;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Pages[isgn].colors[1]
                .Cylinder := -1;
              plateframesdata[Iplateframe].ProdPlates
                [plateframes[Iplateframe].NProdPlates].Zone := -1;
            end;
          End;
        End; // Icopies
      End;

      Inc(Iplateframe);

    End; // for isec
    for Iplateframe := 1 to Nplateframes do
    begin
      plateframes[Iplateframe].SequenceNumber := Iplateframe;
      plateframes[Iplateframe].productiontime := 0;
      plateframes[Iplateframe].PriorityBeforeHottime :=
        StrToInt(Formaddplan.Editpriority.Text);
      plateframes[Iplateframe].PriorityDuringHottime :=
        StrToInt(Formaddplan.Editpriority.Text);
      plateframes[Iplateframe].PriorityAfterHottime :=
        StrToInt(Formaddplan.Editpriority.Text);
      plateframes[Iplateframe].PriorityHottimeBegin := 0;
      plateframes[Iplateframe].PriorityHottimeEnd := 0;
      plateframes[Iplateframe].Comment := '';
      plateframes[Iplateframe].order := '';
      plateframes[Iplateframe].PressConfignameX := '';
      plateframes[Iplateframe].Inkcomment := '';

      plateframes[Iplateframe].perfecktbound :=
        Integer(FormAddextrapressrun.CheckBoxbindingstyle.checked);
      plateframes[Iplateframe].inserted :=
        FormAddextrapressrun.RadioGroupcollection.ItemIndex;

      // ## NAN 20160309
      // plateframes[Iplateframe].Backwards := Integer(FormAddExtrapressrun.CheckBoxbackward.checked);
      plateframes[Iplateframe].RipSetupID := 0;

    end;
  except
  end;
  formmain.planlogging('Wizard to plates End');
end;

Function TFormprodplan.AddPlateFrames(parentBox: TScrollBox;
  AddNumberofframes: Integer): Boolean;
Var
  iplf: Integer;
  memallocres: Boolean;
  newheight: Integer;
Begin
  // NprodplatesSize
  result := true;

  newheight := parentBox.Height div (Nplateframes + AddNumberofframes);
  IF newheight < 200 then
    newheight := 200;

  For iplf := Nplateframes downto 1 do
  begin
    plateframes[iplf].Align := alnone;
    plateframes[iplf].Height := newheight;
    plateframes[iplf].visible := false;
  End;
  For iplf := 1 to Nplateframes do
  begin
    plateframes[iplf].Top := (iplf * newheight) + (iplf * 10);
  End;

  For iplf := Nplateframes + 1 to Nplateframes + AddNumberofframes do
  begin
    try
      plateframes[iplf].visible := false;
      plateframes[iplf].Align := alnone;
      plateframes[iplf].Parent := parentBox;
      plateframes[iplf].pressrunid := -99;
      plateframes[iplf].GroupBoxtop.Caption :=
        inttostr(plateframes[iplf].pressrunid);
      plateframes[iplf].name := 'Plateframe' + inttostr(iplf);
      plateframes[iplf].plateframenumber := iplf;
      plateframes[iplf].Panelborder.Color := clBtnFace;
      plateframes[iplf].Selected := false;
      plateframes[iplf].NProdPlates := -1;
      plateframes[iplf].Top := (iplf * newheight) + (iplf * 10);
    Except
      result := false;
    end;
  End;

  try
    // Parentbox.Align := alnone;
    // Parentbox.Height := Parentbox.Height + (AddNumberofframes * plateframes[Nplateframes].Height) + 100;
    For iplf := 1 to Nplateframes + AddNumberofframes do
    begin
      plateframes[iplf].Align := altop;
      plateframes[iplf].visible := true;
    end;

  Except
    result := false;
  end;

  IF Nplateframes + AddNumberofframes > 1 then
    plateframes[Nplateframes + AddNumberofframes].Align := alclient;

  (*
    try
    Parentbox.Align := alclient;

    IF Nplateframes + AddNumberofframes > 0 then
    plateframes[Nplateframes + AddNumberofframes].Align := alclient;

    Parentbox.Repaint;

    Except
    result := false;
    End;
    Formprodplan.Height := Formprodplan.Height - 10;

    application.ProcessMessages;
    Formprodplan.Height := Formprodplan.Height + 10;
  *)

end;

Function TFormprodplan.CheckForDubles(frompl: Integer; Npl: Integer): Boolean;

Var
  found: Boolean;
  isec1, isec2, ip1, ip2: Integer;
Begin
  found := false;
  For isec1 := 1 to frompl - 1 do
  begin
    For ip1 := 1 to planpagenames[isec1].Npages do
    begin
      For isec2 := frompl to (frompl + Npl) - 1 do
      begin
        For ip2 := 1 to planpagenames[isec2].Npages do
        begin
          IF (planpagenames[isec1].editionid = planpagenames[isec2].editionid)
            and (planpagenames[isec1].Pages[ip1].sectionid = planpagenames
            [isec2].Pages[ip2].sectionid) and
            (planpagenames[isec1].Pages[ip1].Pageindex = planpagenames[isec2]
            .Pages[ip2].Pageindex) then
          begin
            MessageDlg(formmain.InfraLanguage1.Translate
              ('The combination of edition ') + tnames1.editionIDtoname
              (planpagenames[isec2].editionid) + #13 +
              formmain.InfraLanguage1.Translate('and section ') +
              tnames1.sectionIDtoname(planpagenames[isec2].Pages[ip2].sectionid)
              + formmain.InfraLanguage1.Translate(' already exists '), mtError,
              [mbOk], 0);

            found := true;
          end;
          if found then
            break;
        end;
        if found then
          break;
      end;
      if found then
        break;
    end;
    if found then
      break;
  end;
  result := found;
end;

procedure TFormprodplan.ActionPlaaddconsExecute(Sender: TObject);

  Procedure setproofsontemplate;
  begin
    Formproof.init;

    Formselecttemplate.ComboBoxproof.items.clear;
    Formselecttemplate.ComboBoxproof.items := Formproof.ComboBoxsoftproof.items;

    Formselecttemplate.ComboBoxproofcolor.items.clear;
    Formselecttemplate.ComboBoxproofcolor.items :=
      Formproof.ComboBoxsoftproof.items;

    Formselecttemplate.ComboBoxproofpdf.items.clear;
    Formselecttemplate.ComboBoxproofpdf.items :=
      Formproof.ComboBoxsoftproof.items;

    if (Prefs.PlanningDefaultColorProofer <> '') then
    begin
      Formselecttemplate.ComboBoxproofcolor.ItemIndex :=
        Formselecttemplate.ComboBoxproofcolor.items.IndexOf
        (Prefs.PlanningDefaultColorProofer);
    end;

    if (Prefs.PlanningDefaultPDFProofer <> '') then
    begin
      Formselecttemplate.ComboBoxproofpdf.ItemIndex :=
        Formselecttemplate.ComboBoxproofpdf.items.IndexOf
        (Prefs.PlanningDefaultPDFProofer);
    end;

    if (Prefs.PlanningDefatulMonoProofer <> '') then
    begin
      Formselecttemplate.ComboBoxproof.ItemIndex :=
        Formselecttemplate.ComboBoxproof.items.IndexOf
        (Prefs.PlanningDefatulMonoProofer);
    end;

    IF Formselecttemplate.ComboBoxproofcolor.ItemIndex = -1 then
      Formselecttemplate.ComboBoxproofcolor.ItemIndex := 0;
    IF Formselecttemplate.ComboBoxproof.ItemIndex = -1 then
      Formselecttemplate.ComboBoxproof.ItemIndex := 0;

    Formselecttemplate.Selectedcolorproofid := plateframesdata[1].ProdPlates[0]
      .Pages[1].proofid;
    Formselecttemplate.Selectedmonoproofid := plateframesdata[1].ProdPlates[0]
      .Pages[1].proofid;
    Formselecttemplate.Selectedpdfproofid := plateframesdata[1].ProdPlates[0]
      .Pages[1].proofid;

  end;

Var
  cursectionI, I, Isub, iplf, ipl, ied: Integer;
  Beforeadd: Integer;
  L: TListItem;
  tempeditionname: string;
  tempeditionID: Integer;
  Putintoexistinged: Boolean;
  Addeditionid: Integer;
  Addeditionname: String;

begin
  if FormAddextrapressrun.ShowModal = mrok then
  begin
    Addeditionname := FormAddextrapressrun.ComboBoxedition.Text;
    Addeditionid := tnames1.editionnametoid(Addeditionname);
    Putintoexistinged := false;

    JustaddoneUP := FormAddextrapressrun.ComboBoxplatelayout.ItemIndex > 0;
    addingplatelistid := inittypes.gettemplatelistnumberfromname(FormAddextrapressrun.ComboBoxplatelayout.Text);
    FormAddpressrun.CheckListBoxcolors.items := FormAddextrapressrun.CheckListBoxextracolors.items;
    for i := 0 to FormAddpressrun.CheckListBoxcolors.items.count - 1 do
      FormAddpressrun.CheckListBoxcolors.Checked[i] := FormAddextrapressrun.CheckListBoxextracolors.checked[i];

    FormAddpressrun.PBExListviewSections.items.clear;
    For i := 0 to FormAddextrapressrun.PBExListviewSections.items.count - 1 do
    begin
      L := FormAddpressrun.PBExListviewSections.items.add;
      L.Caption := FormAddextrapressrun.PBExListviewSections.items[i].Caption;
      For Isub := 0 to FormAddextrapressrun.PBExListviewSections.items[i].subitems.count - 1 do
        L.subitems.add(FormAddextrapressrun.PBExListviewSections.items[i].subitems[Isub]);
    end;

    FormAddpressrun.RadioGroupcollection.ItemIndex :=
      FormAddextrapressrun.RadioGroupcollection.ItemIndex;
    FormAddpressrun.CheckBoxbindingstyle.checked :=
      FormAddextrapressrun.CheckBoxbindingstyle.checked;
    FormAddpressrun.CheckBoxprepaired.checked :=
      FormAddextrapressrun.CheckBoxprepaired.checked;

    FormAddpressrun.CheckBoxbackward.checked :=
      FormAddextrapressrun.CheckBoxbackward.checked;
    FormAddpressrun.CheckBoxprepaired.checked :=
      FormAddextrapressrun.CheckBoxprepaired.checked;

    FormAddpressrun.editCopies.Text := FormAddextrapressrun.editCopies.Text;

    For I := 1 to NPlatetemplateArray do
    begin
      if (FormAddextrapressrun.ComboBoxplatelayout.items
        [FormAddextrapressrun.ComboBoxplatelayout.ItemIndex] = PlatetemplateArray[I].templatename) and
        (PlatetemplateArray[I].Pressid = plateframespressid) then
      begin
        FormAddpressrun.Nup := PlatetemplateArray[I].NupOnplate;
        break;
      End;
    End;

    setproofsontemplate;
    Beforeadd := Nplanpagesections;
    copyplantoplanpages;
    setpressrunidstodbrunid;

    IF AddExtraruntopages() then
    begin
      if checkfordubles(Addrunfromsec, Nplanpagesections - Beforeadd) then
      begin
        Nplanpagesections := Beforeadd;
      end
      Else
      begin
        calulatepagina;
        AddExtraruntoplates;

        setdinkydata(Addrunfromsec);

        applyglobdata(Addrunfromsec, plateframesproductionid,
          plateframespublicationid, plateframeslocationid, plateframespressid,
          addingplatelistid, addingplatelistid,
          Formselecttemplate.Selectedcolorproofid,
          Formselecttemplate.Selectedmonoproofid,
          Formselecttemplate.Selectedpdfproofid, Formselecttemplate.Nmarkgroups,
          Formselecttemplate.markgroups);

        genmiscstring;
        // findorgedpages;
        copyplantoplanpages;

        // checktowers;
        for I := Addrunfromsec to Nplateframes do
        begin
          IF CheckBoxsmallimagesinEdit.checked then
            Pressviewzoom := 60
          else
            Pressviewzoom := 100;

          plateviewimage.Width := 23; // 204
          plateviewimage.Height := 51; // 176

          checkuponhwafteredit;
          DrawThePlates(CheckBoxsmallimagesinEdit.checked, I);

          pressruncaptionnames;

        end;
      End;
    End;

  End;
end;

Procedure TFormprodplan.somethingalliedorinserted(productionid: Integer;
  pressrunid: Integer; publicationid: Integer; pubdate: Tdatetime);
Var
  I: Integer;
  found: Boolean;
Begin
  found := false;
  For I := 1 to NApplieddata do
  begin
    if (Applieddata[I].productionid = productionid) and
      (Applieddata[I].pressrunid = pressrunid) and
      (Applieddata[I].publicationid = publicationid) and
      (Applieddata[I].pubdate = pubdate) then
    begin
      found := true;
      break;
    end;
  end;

  if (not found) and (NApplieddata < 99) then
  begin
    Inc(NApplieddata);
    Applieddata[NApplieddata].productionid := productionid;
    Applieddata[NApplieddata].pressrunid := pressrunid;
    Applieddata[NApplieddata].publicationid := publicationid;
    Applieddata[NApplieddata].pubdate := pubdate;
  end;
End;

Function TFormprodplan.Checknewproduction: Boolean;
Var
  I: Integer;
  anyproblem: Boolean;
Begin
  anyproblem := false;

  if (not Anyerrosduringrun) And (NApplieddata > 0) then
  begin
    for I := 1 to NApplieddata do
    begin
      if not formmain.productionIsok(Applieddata[I].productionid,
        Applieddata[I].pressrunid, Applieddata[I].publicationid,
        Applieddata[I].pubdate, -1) then
      begin
        anyproblem := true;
        break;
      end;
    end;
  end;
  if ((anyproblem) or (Anyerrosduringrun)) and (NApplieddata > 0) then
  begin
    MessageDlg(formmain.InfraLanguage1.Translate
      ('Could not apply new data please make the plan again '), mtError,
      [mbOk], 0);
    for I := 1 to NApplieddata do
    begin
      formmain.Deleteproductionwitherror(Applieddata[I].productionid,
        Applieddata[I].pressrunid, Applieddata[I].publicationid,
        Applieddata[I].pubdate, -1);
    End;
  end;
  result := anyproblem;
end;

Function TFormprodplan.PublandDateExists: Boolean;
Begin
  result := false;
  try
    DataM1.Query1.sql.clear;
    DataM1.Query1.sql.add('Select distinct productionid from pagetable WITH (NOLOCK) ');
    DataM1.Query1.sql.add('where publicationid = ' + inttostr(plateframespublicationid));
    DataM1.Query1.sql.add('and pressid = ' + inttostr(plateframespressid));
    DataM1.Query1.sql.add('and ' + DataM1.makedatastr('', plateframesPubdate));
    DataM1.Query1.open;
    result := not DataM1.Query1.eof;
    DataM1.Query1.close;
  Except
  end;
end;

Procedure TFormprodplan.ApplyPublicationDataAfterLoadafplan;

Var
  setmrks: Boolean;
  Amarksstr: string;
  Amarks, Nmarks: marksarray;
  NNmarks, ANmarks, iplf, ipl, im, im2: Integer;

begin
  try
    setmrks := false;
    for im2 := 1 to 100 do
    begin
      Nmarks[im2] := 0;
      Amarks[im2] := 0;

    End;
    try
      Amarksstr := '';
      DataM1.Query1.sql.clear;
      //DataM1.Query1.sql.add('Select * from publicationnames');
      DataM1.Query1.sql.add('Select DefaultMarkGroups from publicationnames');
      DataM1.Query1.sql.add('where publicationid = ' + inttostr(plateframespublicationid));
      DataM1.Query1.open;
      if not DataM1.Query1.eof then
      begin
       // if DataM1.Query1.fields.count >= 11 then
        //begin
       //   if DataM1.Query1.fields[11].DisplayName = 'DefaultMarkGroups' then
       //   begin
           //Amarksstr := DataM1.Query1.fieldbyname('DefaultMarkGroups').asstring;
            Amarksstr := DataM1.Query1.fields[0].asstring;
            if Amarksstr <> '' then
            begin
              inittypes.markstrtoarray(Amarksstr, Amarks, ANmarks);
              setmrks := true;
            end;
         // End;
       // End;
      end;
      DataM1.Query1.close;
    except

    end;
    if setmrks then
    begin
      For iplf := 1 to Nplateframes do
      begin
        For ipl := 0 to plateframes[iplf].NProdPlates do
        begin
          NNmarks := 0;
          for im := 1 to PlatetemplateArray
            [plateframesdata[iplf].ProdPlates[ipl].templatelistid]
            .Nmarkgroups do
          begin
            for im2 := 1 to ANmarks do
            begin
              if Amarks[im2] = PlatetemplateArray
                [plateframesdata[iplf].ProdPlates[ipl].templatelistid]
                .markgroups[im] then
              Begin
                Inc(NNmarks);
                Nmarks[NNmarks] := Amarks[im2];
                break;
              end;
            end;
          end;

          plateframesdata[iplf].ProdPlates[ipl].Nmarkgroups := NNmarks;
          for im2 := 1 to ANmarks do
          begin
            plateframesdata[iplf].ProdPlates[ipl].markgroups[im2] :=
              Nmarks[im2];
          End;

        End;
      End;

    end;

  Except
  end;
end;

Procedure TFormprodplan.CheckuponHWafteredit;
Var
  iplf, ipl, ip, isec, Ipage: Integer;
  aktsecid, aktedid: Integer;

begin
  aktsecid := 0;
  aktedid := 0;
  For iplf := 1 to Nplateframes do
  begin
    For ipl := 0 to plateframes[iplf].NProdPlates do
    begin
      for ip := 1 to PlatetemplateArray
        [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
      Begin
        IF (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype < 2) and
          (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].sectionid <> 0) then
        begin
          aktsecid := plateframesdata[iplf].ProdPlates[ipl].Pages[ip].sectionid;
          aktedid := plateframesdata[iplf].ProdPlates[ipl].editionid;
        end;
        IF (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype < 2) and
          (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].sectionid = 0) then
        Begin

        end;
      end;
      for ip := 1 to PlatetemplateArray
        [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
      Begin
        if plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype = 3 then
        begin
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].sectionid := aktsecid;
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Orgeditionid
            := aktedid;
        end;
      End;
    End;
  End;
end;

Procedure TFormprodplan.ProductionIdCkeckup;
Var
  iplf, ipl, ip: Integer;

Begin
  plateframesproductionid := -1;
  DataM1.Query1.sql.clear;
  DataM1.Query1.sql.add('Select distinct ProductionID from pagetable WITH (NOLOCK) ');
  DataM1.Query1.sql.add('where publicationid = ' +inttostr(plateframespublicationid));
  DataM1.Query1.sql.add('and pressid = ' + inttostr(plateframespressid));
  DataM1.Query1.sql.add('and ' + DataM1.makedatastr('', plateframesPubdate));
  formmain.Tryopen(DataM1.Query1);

  if not DataM1.Query1.eof then
  begin
    plateframesproductionid := DataM1.Query1.fields[0].asinteger;
  end;
  DataM1.Query1.close;

  if plateframesproductionid = -1 then
  begin
    if plateframesproductionname = '' then
    begin
      plateframesproductionname := tnames1.publicationIDtoname
        (plateframespublicationid) + ' ' + formatdatetime('DD-MM-YYYY',
        plateframesPubdate) + ' ' + tnames1.pressnameIDtoname
        (plateframespressid);
    end;
    plateframesproductionid := tnames1.productionrunnametoid
      (plateframesproductionname);
    IF plateframesproductionid = -1 then
    Begin
      tnames1.Addname(9, plateframesproductionname);
      plateframesproductionid := tnames1.productionrunnametoid
        (plateframesproductionname);
    End;
  end;

  For iplf := 1 to Nplateframes do
  begin
    For ipl := 0 to plateframes[iplf].NProdPlates do
    begin
      plateframesdata[iplf].ProdPlates[ipl].productionid :=
        plateframesproductionid;
    End;
  End;

End;

Procedure TFormprodplan.WritePlanLog(planname: String);
Var
  iplf, ipl, ip, ic, isec, Ipage: Integer;
  filename, T, t1: string;

  Year, Month, Day: Word;
  SYear, SMonth, SDay: string;
  Alist: TStrings;
  pldt: Tdatetime;

  NPageSum, IPageSum: Integer;
  foundIpagesum: Boolean;
  PageSum: Array [1 .. 1000] of record sectionid: Integer;
  editionid: Integer;
  Npages: Integer;
  offset: Integer;
end;

Begin

  IF Prefs.Writeplanlogfile then
  begin
    Alist := TStringList.Create;
    copyplantoplanpages;
    filename := tnames1.GetMainFileServerShare + 'CClogs\PLAN_' +  Thisdevicename + '.log';

    IF Prefs.OverwritePlanLogFilepath <> '' then
    Begin
      filename := IncludeTrailingBackSlash(Prefs.OverwritePlanLogFilepath) +  'PLAN_' + Thisdevicename + '.log';
    end;

    if fileexists(filename) then
    Begin

      Alist.LoadFromFile(filename);
      if Alist.count > 10000 then
      begin
        for ip := 0 to 1000 do
        begin
          Alist.delete(0);
        End;
      End;
    End;

    For IPageSum := 1 to 200 do
    begin
      PageSum[IPageSum].sectionid := -1;
      PageSum[IPageSum].editionid := -1;
      PageSum[IPageSum].Npages := 0;
      PageSum[IPageSum].offset := 10000;
    End;

    NPageSum := 0;
    For isec := 1 to Nplanpagesections do
    begin
      for Ipage := 1 to planpagenames[isec].Npages do
      begin
        foundIpagesum := false;
        For IPageSum := 1 to NPageSum do
        begin
          if (PageSum[IPageSum].sectionid = planpagenames[isec].Pages[Ipage].sectionid) and (PageSum[IPageSum].editionid = planpagenames[isec].editionid) then
          begin
            Inc(PageSum[IPageSum].Npages);
            IF PageSum[IPageSum].offset > planpagenames[isec].Pages[Ipage].Pageindex then
            Begin
              PageSum[IPageSum].offset := planpagenames[isec].Pages[Ipage].Pageindex;
            end;
            foundIpagesum := true;
            break;
          end;
        End;
        IF not foundIpagesum then
        begin
          Inc(NPageSum);
          PageSum[NPageSum].sectionid := planpagenames[isec].Pages[Ipage].sectionid;
          PageSum[NPageSum].editionid := planpagenames[isec].editionid;
          PageSum[NPageSum].offset := planpagenames[isec].Pages[Ipage].Pageindex;
          PageSum[NPageSum].Npages := 1;
        end;
      End;
    End;

    Alist.add('-------------------------');
    Alist.add('START PLAN ' + planname);
    Alist.add('PLANDATE ' + formatdatetime('DDMMYYYY', now));
    Alist.add('PLANTIME ' + formatdatetime('HHNNSS', now));
    Alist.add('');
    Alist.add('FindTIME ' + inttostr(findingsec));
    Alist.add('MappendTIME ' + inttostr(appendsec));
    Alist.add('Maxinsertsec ' + inttostr(insertsec));

    // FindTIME 15566
    // MappendTIME 459469
    Case planningaction of
      0:
        Alist.add('Load');
      1:
        Alist.add('Edit');
      2:
        Alist.add('Create');
      3:
        Alist.add('Copy');
      4:
        Alist.add('Move');
      5:
        Alist.add('Apply');
    end;

    //

    Alist.add('ProductionID ' + inttostr(plateframesproductionid));
    Alist.add('Publication ' + tnames1.publicationIDtoname(plateframespublicationid));
    Alist.add('Publication date' + DateToStr(plateframesPubdate));
    Alist.add('Press ' + tnames1.pressnameIDtoname(plateframespressid));
    Alist.add('Nruns ' + inttostr(Nplateframes));

    Alist.add('');
    Alist.add('Section setup');
    Alist.add('');
    For IPageSum := 1 to NPageSum do
    begin
      if tnames1.sectionIDtoname(PageSum[IPageSum].editionid) <> '' then
      begin
        T := ' Section ' + tnames1.sectionIDtoname(PageSum[IPageSum].sectionid);
        T := T + ' Number of Pages ' + inttostr(PageSum[IPageSum].Npages) +' Offset ' + inttostr(PageSum[IPageSum].offset);
        Alist.add(T);
        Alist.add('');
      End;
    End;

    Alist.add('');
    Alist.add('Editions setup');
    Alist.add('');
    For iplf := 1 to Nplateframes do
    begin
      Alist.add('Edition ' + tnames1.editionIDtoname(plateframesdata[iplf].ProdPlates[0].editionid));
    End;

    Alist.add('');
    Alist.add('Pages');
    Alist.add('');
    Alist.add('Sec' + #9 + 'Page' + #9 + 'Ed' + #9 + 'MasterEd');
    Alist.add('');
    For isec := 1 to Nplanpagesections do
    begin

      for Ipage := 1 to planpagenames[isec].Npages do
      begin
        Alist.add(tnames1.sectionIDtoname(planpagenames[isec].Pages[Ipage].sectionid) + #9 + planpagenames[isec].Pages[Ipage].name + #9 +
          tnames1.editionIDtoname(planpagenames[isec].editionid) + #9 +
          tnames1.editionIDtoname(planpagenames[isec].Pages[Ipage].Orgeditionid));
      end;
      Alist.add('');
    end;

    Alist.add('');

    Alist.add('Plates');
    Alist.add('');

    For iplf := 1 to Nplateframes do
    begin
      Alist.add('Edition ' + tnames1.editionIDtoname(plateframesdata[iplf].ProdPlates[0].editionid));
      Alist.add('Pressrunid ' + inttostr(plateframesdata[iplf].ProdPlates[0].runid));
      Alist.add('Nplates ' + inttostr(plateframes[iplf].NProdPlates + 1));
      Alist.add('Template ' + PlatetemplateArray[plateframesdata[iplf].ProdPlates[0].templatelistid].templatename);
      T := '';
      For ipl := 0 to plateframes[iplf].NProdPlates do
      begin
        T := T + '(';
        for ip := 1 to PlatetemplateArray
          [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
        Begin

          IF (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype < 3) then
          begin
            T := T + tnames1.sectionIDtoname(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].sectionid) + '_' + plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename + ','
          end
          Else
          begin
            T := T + plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename + ','
          end;
        End;
        if length(T) > 0 then
          T[length(T)] := ')';
      End;

      Alist.add(T);
      Alist.add('');
    End;

    Alist.add('END PLAN ' + planname);
    Alist.add('');

    // ### 20230531 - wrapped
    try
      Alist.SaveToFile(filename);
    except
    end;

    Alist.Free;

  end;

end;

Function TFormprodplan.InsertNewPressrun(RunNumber: Integer): Integer;

  function Sumtid(dato: Tdatetime; tid: Tdatetime): Tdatetime;
  Begin
    result := EncodeDateTime(yearof(dato), monthof(dato), Dayof(dato),
      hourof(tid), minuteof(tid), 0, 0);
  end;

Var
  ipl: Integer;
  s : string;
Begin
  result := -1; // plateframesdata[RunNumber].prodplates[0].runid = -99
  try

  DataM1.Query3.sql.clear;
  DataM1.Query3.sql.add('SELECT pressrunid FROM pressrunid WHERE pressrunid = '  + inttostr(plateframesdata[RunNumber].ProdPlates[0].runid));
  formmain.Tryopen(DataM1.Query3);
  IF not DataM1.Query3.eof then
    result := DataM1.Query3.fields[0].asinteger;
  DataM1.Query3.close;

  IF (result = -1) or (Formprodplan.planningaction = 6) then
  Begin
    DataM1.Query3.sql.clear;
    // 'MM"/"DD"/"YYYY HH":"MM'
    DataM1.Query3.sql.add('exec spPlanCenterAddPressRun3 ');
    DataM1.Query3.sql.add(inttostr(plateframesdata[RunNumber].runSequenceNumber) + ' ,');
    DataM1.Query3.sql.add('''' + SQLnotime + '''' + ' ,');
    DataM1.Query3.sql.add('''' + SQLnotime + '''' + ' ,');
    DataM1.Query3.sql.add('''' + SQLnotime + '''' + ' ,');
    DataM1.Query3.sql.add('''' + SQLnotime + '''' + ' ,');
    DataM1.Query3.sql.add('''' + plateframes[RunNumber].Comment + '''' + ' ,');
    DataM1.Query3.sql.add(FormApplyproduction.EditbeforeH.Text + ' ,');
    DataM1.Query3.sql.add(FormApplyproduction.Editduringh.Text + ' ,');
    DataM1.Query3.sql.add(FormApplyproduction.EditAfterh.Text + ' ,');

    IF FormApplyproduction.DateTimePickerhotdatestart.checked then
    begin
       // NAN 20231113 - substitude time delimiter . with :
       s :=  formatdatetime(SQLdatetimeformat, Sumtid(FormApplyproduction.DateTimePickerhotdatestart.Date, FormApplyproduction.DateTimePickerhottimestart.Time));
       s :=  StringReplace(s,'.',':', [rfReplaceAll]);
      DataM1.Query3.sql.add(QuotedStr(s) + ' ,');
      s := formatdatetime(SQLdatetimeformat,
            Sumtid(FormApplyproduction.DateTimePickerhotdateend.Date,
            FormApplyproduction.DateTimePickerhottimeend.Time));
      s :=  StringReplace(s,'.',':', [rfReplaceAll]);
      DataM1.Query3.sql.add(QuotedStr(s) + ' ,');
    End
    Else
    begin
      DataM1.Query3.sql.add('''' + SQLnotime + '''' + ' ,');
      DataM1.Query3.sql.add('''' + SQLnotime + '''' + ' ,');
    end;
    DataM1.Query3.sql.add
      (inttostr(Integer(FormApplyproduction.CheckBoxUsepresstowerconf.
      checked)) + ' ,');
    DataM1.Query3.sql.add('''' + FormApplyproduction.Editordernumber.Text +
      '''' + ' ,');
    DataM1.Query3.sql.add('''' + plateframes[RunNumber].Inkcomment +
      '''' + ' ,');

    // NAN ## 20160309
    // DataM1.Query3.sql.add(inttostr(plateframes[RunNumber].Backwards)+' ,');
    DataM1.Query3.sql.add('0,');

    DataM1.Query3.sql.add(inttostr(plateframes[RunNumber].perfecktbound) + ' ,');
    DataM1.Query3.sql.add(inttostr(plateframes[RunNumber].inserted));

    if Prefs.debug then
      DataM1.Query3.sql.SaveToFile (IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\' + 'Planinsertpressrun.sql');

    DataM1.Query3.open;
    if not DataM1.Query3.eof then
      result := DataM1.Query3.fields[0].asinteger;
    DataM1.Query3.close;

    if result <> -1 then
    begin
      writeMainlogfile('InsertNewPresssun(): Updating pressrunid ' + IntToStr(result));
      DataM1.Query3.sql.clear;
      DataM1.Query3.sql.add('Update pressrunid');
      DataM1.Query3.sql.add('Set Deadline1 = :Deadline1');
    //  IF Formprodplan.planningaction = 6 then
   //   begin

    //  end;

      if (PlanVersion = 0) then
        PlanVersion := 1;
      IF DBVersion > 1 then
      Begin
        IF plateframesLoadedname = '' then
          plateframesLoadedname := plateframesproductionname;
        DataM1.Query3.sql.add(', planname = ' + '''' +plateframesLoadedname + '''');
        DataM1.Query3.sql.add(', Presssystem = ' + '''' + plateframes[RunNumber].presssystemname + '''');
        DataM1.Query3.sql.add(', Circulation = ' +inttostr(plateframes[RunNumber].NumberOfIssues));
        DataM1.Query3.sql.add(', Circulation2 = ' +inttostr(plateframes[RunNumber].NumberOfIssues2));
        DataM1.Query3.sql.add(', Plantype = 1');
        DataM1.Query3.sql.add(', TimedEditionFrom = 0');
        DataM1.Query3.sql.add(', TimedEditionTo = 0');
        DataM1.Query3.sql.add(', TimedEditionState = 0');
        // DataM1.Query3.sql.add(', Planversion = '+inttostr(plateframes[RunNumber].Planversion));
        // ## NAN Reset planversion (ready-flag)
        if (Formprodplan.planningaction <> PLANADDMODE_APPLY) then
           DataM1.Query3.sql.add(', Planversion = '+inttostr(plateframes[RunNumber].Planversion))
        else
           DataM1.Query3.sql.add(', Planversion = ' + IntToStr(PlanVersion));

      End;

      DataM1.Query3.ParamByName('Deadline1').AsDateTime := plateframes[RunNumber].productiontime;

      DataM1.Query3.sql.add('Where pressrunid =  ' + inttostr(result));
      if Prefs.debug then
        DataM1.Query3.sql.SaveToFile (IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\' + 'Planupdatepressrun.sql');

      formmain.trysql(DataM1.Query3);

    End;
  End;

  if result <> -1 then
  begin
    for ipl := 0 to plateframes[RunNumber].NProdPlates do
    begin
      plateframes[RunNumber].pressrunid := result;
      plateframesdata[RunNumber].ProdPlates[ipl].runid := result;

    end;
  end;

  except
    on E: Exception do
    begin
       writeMainlogfile('RunProduction: Exception in InsertNewPressrun() - '+ E.Message);
    end;
  end;

end;

Procedure TFormprodplan.SelApage(iplf: Integer; ipl: Integer; ip: Integer);

Begin
  beep;
end;

Procedure TFormprodplan.MoveApage(Fiplf: Integer; Fipl: Integer; FIP: Integer;
  Tiplf: Integer; Tipl: Integer; TIP: Integer);
Begin
  // plateframenumber,mouseoveripl,Mouseoverip

  if (Fiplf < 1) or (Fiplf > Nplateframes) then
    exit;
  if plateframes[Fiplf].PBExListview1.Selected = nil then
    exit;
  if (Fipl < 0) or (Fipl > plateframes[Fiplf].NProdPlates) then
    exit;
  if (FIP < 0) or (FIP > PlatetemplateArray[plateframesdata[Fiplf].ProdPlates
    [Fipl].templatelistid].NupOnplate) then
    exit;

  if (Tiplf < 1) or (Tiplf > Nplateframes) then
    exit;
  if plateframes[Tiplf].PBExListview1.Selected = nil then
    exit;
  if (Tipl < 0) or (Tipl > plateframes[Tiplf].NProdPlates) then
    exit;
  if (TIP < 0) or (TIP > PlatetemplateArray[plateframesdata[Tiplf].ProdPlates
    [Tipl].templatelistid].NupOnplate) then
    exit;

  (*
    Formplaneditpagename.Edit1.Text := plateframesdata[iplf].prodplates[ipl].pages[ip].pagename;
    IF Formplaneditpagename.ShowModal = Mrok then
    begin
    plateframesdata[iplf].prodplates[ipl].pages[ip].pagename := Formplaneditpagename.Edit1.Text;
    plateframesdata[iplf].prodplates[ipl].pages[ip].pageindex := strtoint(Formplaneditpagename.Edit1.Text);
    end;
  *)
end;

procedure TFormprodplan.ActionMovepagesExecute(Sender: TObject);
begin
  ActionMovepages.checked := Not ActionMovepages.checked;

  IF ActionMovepages.checked then
    Actioneditpages.checked := false;
end;

procedure TFormprodplan.ActionPlancopypageExecute(Sender: TObject);
begin
  CopyIPLF := Mouseoveriplf;
  copyIPL := Mouseoveripl;
  CopyIP := mouseoverip;

end;

Procedure TFormprodplan.RebuildManualDinks;
Var
  iplf, ipl, ip: Integer;
  Hawlfwebnameoffset: Integer;
Begin
  Numberofhalfweb := 0;
  Hawlfwebnameoffset := 1;
  DataM1.Query3.sql.clear;
  DataM1.Query3.sql.add('Select distinct pressrunid from pagetable WITH (NOLOCK) where pagetype = 3 ');
  DataM1.Query3.sql.add('and  productionid = ' + inttostr(plateframesproductionid));
  DataM1.Query3.sql.add(' order by pressrunid');
  formmain.Tryopen(DataM1.Query3);
  While not DataM1.Query3.eof do
  begin
    Inc(Hawlfwebnameoffset);
    DataM1.Query3.next;
  end;
  DataM1.Query3.close;

  For iplf := 1 to Nplateframes do
  begin
    For ipl := 0 to plateframes[iplf].NProdPlates do
    begin
      for ip := 1 to PlatetemplateArray
        [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
      Begin
        IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype = 3 then
        begin
          Inc(Numberofhalfweb);
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename := 'Dinkey' + inttostr((Hawlfwebnameoffset * 100) + Numberofhalfweb);
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors := 1;
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Oldrunid := -1;
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[1].ColorID := 6;
        end;
      end;
    End;
  End;
end;

procedure TFormprodplan.Checkfornocolorpages;
Var
  iplf, ipl, ip, ic: Integer;
  foundsomedinks, Isadink: Boolean;
Begin
  foundsomedinks := false;
  For iplf := 1 to Nplateframes do
  begin
    For ipl := 0 to plateframes[iplf].NProdPlates do
    begin
      for ip := 1 to PlatetemplateArray
        [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
      Begin

        IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype = 0 then
        begin
          Isadink := true;
          For ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors do
          begin
            if (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].active = 1) then
            begin
              Isadink := false;
              break;
            end;
          end;
          if Isadink then
          begin
            foundsomedinks := true;
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype := 3;
          end;
        End;

      End;
    End;
  End;

  rebuildmanualdinks;
  setdinkydata(1);
  copyplantoplanpages;

  IF foundsomedinks then
  begin

  end;

end;

procedure TFormprodplan.ActionPlanpastpageExecute(Sender: TObject);

Var
  ISdink, foundanewdink: Boolean;
  plateresult, ic: Integer;
  Bufpage: Tprodpage;
  L: TListItem;
begin
  pasteIPLF := Mouseoveriplf;
  pasteIPL := Mouseoveripl;
  pasteIP := mouseoverip;

  foundanewdink := false;
  Bufpage := plateframesdata[pasteIPLF].ProdPlates[pasteIPL].Pages[pasteIP];

  plateframesdata[pasteIPLF].ProdPlates[pasteIPL].Pages[pasteIP] :=
    plateframesdata[CopyIPLF].ProdPlates[copyIPL].Pages[CopyIP];

  plateframesdata[CopyIPLF].ProdPlates[copyIPL].Pages[CopyIP] := Bufpage;

  IF plateframesdata[CopyIPLF].ProdPlates[copyIPL].Pages[CopyIP].pagetype = 0
  then
  begin
    ISdink := true;
    for ic := 1 to plateframesdata[CopyIPLF].ProdPlates[copyIPL].Pages[CopyIP].Ncolors do
    begin
      IF plateframesdata[CopyIPLF].ProdPlates[copyIPL].Pages[CopyIP].colors[ic].active = 1 then
      begin
        ISdink := false;
        break;
      end;

    end;
    IF ISdink Then
    Begin
      plateframesdata[CopyIPLF].ProdPlates[copyIPL].Pages[CopyIP].pagetype := 3;
    End;
  End;

  IF plateframesdata[pasteIPLF].ProdPlates[pasteIPL].Pages[pasteIP].pagetype = 0
  then
  begin
    ISdink := true;
    for ic := 1 to plateframesdata[pasteIPLF].ProdPlates[pasteIPL].Pages[pasteIP].Ncolors do
    begin
      IF plateframesdata[pasteIPLF].ProdPlates[pasteIPL].Pages[pasteIP].colors[ic].active = 1 then
      begin
        ISdink := false;
        break;
      end;

    end;
    IF ISdink Then
    Begin
      plateframesdata[pasteIPLF].ProdPlates[pasteIPL].Pages[pasteIP].pagetype := 3;
    End;
  End;

  plateresult := Formprodplan.makeprodviewimage(Mouseoveriplf,
    plateframes[pasteIPLF].ImageListplanframe,
    plateframes[pasteIPLF].PBExListview1, false, // CheckBoxplanthumbnails
    Formprodplan.CheckBoxsmallimagesinEdit.checked, false, pasteIPL, pasteIPL,
    -1, plateframes[pasteIPLF].Numberofcopies);

  plateframes[pasteIPLF].ImageListplanframe.Replacemasked(pasteIPL,plateviewimage, clwhite);

  plateresult := Formprodplan.makeprodviewimage(Mouseoveriplf,
    plateframes[CopyIPLF].ImageListplanframe,
    plateframes[CopyIPLF].PBExListview1, false, // CheckBoxplanthumbnails
    Formprodplan.CheckBoxsmallimagesinEdit.checked, false, copyIPL, copyIPL, -1,
    plateframes[CopyIPLF].Numberofcopies);

  plateframes[CopyIPLF].ImageListplanframe.Replacemasked(copyIPL,plateviewimage, clwhite);

  rebuildmanualdinks;
  setdinkydata(1);
  copyplantoplanpages;

end;

(*
  JustaddoneUP
  addingplatelistid
*)

Procedure TFormprodplan.DoCollect;
Var
  Nup, isec, iflat: Integer;

Begin
  IF AktPRODUCTION.nSplitmode > 0 then
  begin
    Nup := PlatetemplateArray[Formselecttemplate.Selectedtemplatenumber].NupOnplate;
    For isec := 1 to AktPRODUCTION.nSectionsInProduction do
    begin
      For iflat := 1 to AktPRODUCTION.aSections[isec].nFlatsInSection do
      begin
        AktPRODUCTION.aSections[isec].aFlats[iflat].nPagesPerSide := Nup;
      End;
    End;
  End;
end;

procedure TFormprodplan.ActionpopuppresssysnameExecute(Sender: TObject);
Var
  iplf: Integer;
begin
  Formeditatext.Caption := 'Press system name';
  Formeditatext.ComboBox1.items.clear;
  Formeditatext.ComboBox1.Text := '';
  Formeditatext.Label1.Caption := 'Press system name';
  For iplf := 1 to Nplateframes do
  begin
    Formeditatext.ComboBox1.items.add(plateframes[iplf].presssystemname);
  End;
  IF Formeditatext.ShowModal = mrok then
  begin
    For iplf := 1 to Nplateframes do
    begin
      IF plateframes[iplf].Selected then
        plateframes[iplf].presssystemname := Formeditatext.ComboBox1.Text;
    End;
  end;
end;

procedure TFormprodplan.ChangeOffset;
Var
  edid, ied, Secid, iplf, ipl, ip, pidx, offset, nprod, nplan, toppage, hpages,
    upperofset: Integer;

Begin
  IF Formloadpressplan.CheckBoxoffsetinsreted.checked then
  begin
    for pidx := 0 to Formloadpressplan.PBExListview1.items.count - 1 do
    begin
      // Niprod  niplan  offset

      // 16 = 64   ; 48        (niprod64 - iplan) - (offset div 2) + page
      // 15 = 63   ; 48

      edid := tnames1.editionnametoid(Formloadpressplan.PBExListview1.items[pidx].subitems[0]);
      Secid := tnames1.sectionnametoid(Formloadpressplan.PBExListview1.items[pidx].subitems[1]);
      nplan := StrToInt(Formloadpressplan.PBExListview1.items[pidx].subitems[2]);
      offset := StrToInt(Formloadpressplan.PBExListview1.items[pidx].subitems[3]);
      hpages := nplan div 2;

      nprod := -1;
      DataM1.Query3.sql.clear;
      DataM1.Query3.sql.add('Select max(pageindex) from pagetable WITH (NOLOCK) ');
      DataM1.Query3.sql.add('Where publicationid = ' + inttostr(plateframespublicationid));
      DataM1.Query3.sql.add('and editionid = ' + inttostr(edid));
      DataM1.Query3.sql.add('and sectionid = ' + inttostr(Secid));
      DataM1.Query3.sql.add('and PageType < 3');
      DataM1.Query3.sql.add('and active > 0');
      DataM1.Query3.sql.add('and ' + DataM1.makedatastr('',plateframesPubdate));
      DataM1.Query3.open;
      IF not DataM1.Query3.eof then
        nprod := DataM1.Query3.fields[0].asinteger;

      DataM1.Query3.close;

      IF (offset > 0) And (nprod > 0) then
      begin

        IF offset = 1 then
        Begin
          upperofset := (nprod - nplan) - (offset div 2);
          offset := offset - 1;
        End
        Else
        begin
          upperofset := (nprod - nplan) - offset;
        end;
        For iplf := 1 to Nplateframes do
        begin
          For ipl := 0 to plateframes[iplf].NProdPlates do
          begin
            if (plateframesdata[iplf].ProdPlates[ipl].editionid = edid) then
            begin
              for ip := 1 to PlatetemplateArray
                [plateframesdata[iplf].ProdPlates[ipl].templatelistid]
                .NupOnplate do
              begin
                if (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].sectionid = Secid) then
                begin
                  IF hpages >= plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Pageindex
                  then
                  begin
                    plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Pageindex :=
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Pageindex + offset;
                    plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename :=
                      inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Pageindex);
                    plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagina :=
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagina + offset;
                    plateframesdata[iplf].ProdPlates[ipl].Pages[ip].orgpageindex :=
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].orgpageindex + offset;
                  end
                  Else
                  begin
                    plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Pageindex :=
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Pageindex + upperofset;
                    plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename :=
                      inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Pageindex);
                    plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagina :=
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagina + upperofset;
                    plateframesdata[iplf].ProdPlates[ipl].Pages[ip].orgpageindex :=
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].orgpageindex + upperofset;
                  end;

                End;
              End;
            End;
          End;
        End;
      End;
    End;
  end
  else
  begin
    for pidx := 0 to Formloadpressplan.PBExListview1.items.count - 1 do
    begin
      edid := tnames1.editionnametoid(Formloadpressplan.PBExListview1.items[pidx].subitems[0]);
      Secid := tnames1.sectionnametoid(Formloadpressplan.PBExListview1.items[pidx].subitems[1]);
      offset := StrToInt(Formloadpressplan.PBExListview1.items[pidx].subitems[3]);
      IF offset > 1 then
      begin
        For iplf := 1 to Nplateframes do
        begin
          For ipl := 0 to plateframes[iplf].NProdPlates do
          begin
            if (plateframesdata[iplf].ProdPlates[ipl].editionid = edid) then
            begin
              for ip := 1 to PlatetemplateArray
                [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
              begin
                if (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].sectionid = Secid) then
                begin

                  plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Pageindex :=
                    plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Pageindex + offset;
                  plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename :=
                    inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Pageindex);
                  plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagina :=
                    plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagina + offset;
                  plateframesdata[iplf].ProdPlates[ipl].Pages[ip].orgpageindex :=
                    plateframesdata[iplf].ProdPlates[ipl].Pages[ip].orgpageindex + offset;

                end;
              End;
            End;
          End;
        End;
      End;
    End;
  End;
end;

procedure TFormprodplan.ChangeOffsetSTB;
Var
  edid, ied, Secid, iplf, ipl, ip, pidx, offset, nprod, nplan, toppage, hpages,
    upperofset: Integer;

Begin
  IF Formloadstbplan.CheckBoxoffsetinsreted.checked then
  begin
    for pidx := 0 to Formloadstbplan.PBExListview1.items.count - 1 do
    begin
      // Niprod  niplan  offset

      // 16 = 64   ; 48        (niprod64 - iplan) - (offset div 2) + page
      // 15 = 63   ; 48

      edid := tnames1.editionnametoid(Formloadstbplan.PBExListview1.items[pidx]
        .subitems[0]);
      Secid := tnames1.sectionnametoid(Formloadstbplan.PBExListview1.items[pidx]
        .subitems[1]);
      nplan := StrToInt(Formloadstbplan.PBExListview1.items[pidx].subitems[2]);
      offset := StrToInt(Formloadstbplan.PBExListview1.items[pidx].subitems[3]);
      hpages := nplan div 2;

      nprod := -1;
      DataM1.Query3.sql.clear;
      DataM1.Query3.sql.add('Select max(pageindex) from pagetable WITH (NOLOCK) ');
      DataM1.Query3.sql.add('Where publicationid = ' +inttostr(plateframespublicationid));
      DataM1.Query3.sql.add('and editionid = ' + inttostr(edid));
      DataM1.Query3.sql.add('and sectionid = ' + inttostr(Secid));
      DataM1.Query3.sql.add('and PageType < 3');
      DataM1.Query3.sql.add('and active > 0');
      DataM1.Query3.sql.add('and ' + DataM1.makedatastr('', plateframesPubdate));
      DataM1.Query3.open;
      IF not DataM1.Query3.eof then
        nprod := DataM1.Query3.fields[0].asinteger;

      DataM1.Query3.close;

      IF (offset > 0) And (nprod > 0) then
      begin

        IF offset = 1 then
        Begin
          upperofset := (nprod - nplan) - (offset div 2);
          offset := offset - 1;
        End
        Else
        begin
          upperofset := (nprod - nplan) - offset;
        end;
        For iplf := 1 to Nplateframes do
        begin
          For ipl := 0 to plateframes[iplf].NProdPlates do
          begin
            if (plateframesdata[iplf].ProdPlates[ipl].editionid = edid) then
            begin
              for ip := 1 to PlatetemplateArray
                [plateframesdata[iplf].ProdPlates[ipl].templatelistid]
                .NupOnplate do
              begin
                if (plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                  .sectionid = Secid) then
                begin
                  IF hpages >= plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Pageindex
                  then
                  begin
                    plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Pageindex :=
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Pageindex + offset;
                    plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename :=
                      inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Pageindex);
                    plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagina :=
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagina + offset;
                    plateframesdata[iplf].ProdPlates[ipl].Pages[ip].orgpageindex :=
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].orgpageindex + offset;
                  end
                  Else
                  begin
                    plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Pageindex :=
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Pageindex + upperofset;
                    plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename :=
                      inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Pageindex);
                    plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagina :=
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagina +  upperofset;
                    plateframesdata[iplf].ProdPlates[ipl].Pages[ip].orgpageindex :=
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].orgpageindex + upperofset;
                  end;

                End;
              End;
            End;
          End;
        End;
      End;
    End;
  end
  else
  begin
    for pidx := 0 to Formloadstbplan.PBExListview1.items.count - 1 do
    begin
      edid := tnames1.editionnametoid(Formloadstbplan.PBExListview1.items[pidx].subitems[0]);
      Secid := tnames1.sectionnametoid(Formloadstbplan.PBExListview1.items[pidx].subitems[1]);
      offset := StrToInt(Formloadstbplan.PBExListview1.items[pidx].subitems[3]);
      IF offset > 1 then
      begin
        For iplf := 1 to Nplateframes do
        begin
          For ipl := 0 to plateframes[iplf].NProdPlates do
          begin
            if (plateframesdata[iplf].ProdPlates[ipl].editionid = edid) then
            begin
              for ip := 1 to PlatetemplateArray
                [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
              begin
                if (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].sectionid = Secid) then
                begin

                  plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Pageindex :=
                    plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Pageindex + offset;
                  plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename :=
                    inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Pageindex);
                  plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagina :=
                    plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagina + offset;
                  plateframesdata[iplf].ProdPlates[ipl].Pages[ip].orgpageindex :=
                    plateframesdata[iplf].ProdPlates[ipl].Pages[ip].orgpageindex + offset;
                end;
              End;
            End;
          End;
        End;
      End;
    End;
  End;
end;

procedure TFormprodplan.ActionaddSheetExecute(Sender: TObject);
Var
  sheet, sheetnumber, iplf, ipl, ip: Integer;

begin
  Inc(ManualNPlates, 2);
  addingplate := true;

  for iplf := 1 to Nplateframes do
  begin
    IF (plateframes[iplf].Selected) And (plateframes[iplf].NProdPlates < 253)
    then
    begin
      copyplantoplanpages;
      plateframes[iplf].NProdPlates := plateframes[iplf].NProdPlates + 2;

      // NAN
      formmain.Allocateprodplates(iplf, plateframes[iplf].NProdPlates + 1);
      sheet := 0;
      sheetnumber := plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates - 2].sheetnumber + 1;
      For ipl := plateframes[iplf].NProdPlates - 1 to plateframes[iplf].NProdPlates do
      begin
        plateframesdata[iplf].ProdPlates[ipl] := plateframesdata[iplf].ProdPlates[plateframes[iplf].NProdPlates - 2];
        for ip := 1 to PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
        begin
          Inc(Numberofhalfweb);
          plateframesdata[iplf].ProdPlates[ipl].sheetnumber := sheetnumber;
          plateframesdata[iplf].ProdPlates[ipl].Front := sheet;
          plateframesdata[iplf].ProdPlates[ipl].TrueFront := sheet;
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors := 1;
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename := 'Dinkey' + inttostr((iplf * 100) + Numberofhalfweb);
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype := 3;
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[1].ColorID := 6;
        End;
        Inc(sheet);
      end;
    End;
  End;

  copyplantoplanpages;

  for iplf := 1 to Nplateframes do
  begin
    IF CheckBoxsmallimagesinEdit.checked then
      Pressviewzoom := 60
    else
      Pressviewzoom := 100;

    plateviewimage.Width := 23; // 204
    plateviewimage.Height := 51; // 176

    DrawThePlates(CheckBoxsmallimagesinEdit.checked, iplf);
  end;
  sleep(100);

end;

procedure TFormprodplan.ActionRemoveSheetExecute(Sender: TObject);
Var
  platetomove, sheet, sheetside, iplf, ipl, ip, nplatestorem: Integer;
  nopage: Boolean;
begin

  For iplf := 1 to Nplateframes do
  begin
    IF (plateframes[iplf].Selected) And (plateframes[iplf].NProdPlates > 2) then
    begin
      nplatestorem := 0;
      For ipl := 0 to plateframes[iplf].NProdPlates do
      begin
        nopage := true;
        for ip := 1 to PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
        Begin
          IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype <> 3 then
          Begin
            nopage := false;
            break;
          end;
        End;
        IF nopage Then
        Begin
          Inc(nplatestorem);
        End;
      End;

      // IF (nplatestorem > 1) and (nplatestorem Mod 2 = 0) then
      // begin
      Repeat
        platetomove := -1;
        For ipl := 0 to plateframes[iplf].NProdPlates do
        begin
          nopage := true;
          for ip := 1 to PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
          Begin
            IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype <> 3
            then
            Begin
              nopage := false;
              break;
            end;
          End;
          IF nopage Then
          Begin
            platetomove := ipl;
            break;
          End;
        End;
        IF platetomove > -1 then
        begin
          For ipl := platetomove + 1 to plateframes[iplf].NProdPlates do
          begin
            plateframesdata[iplf].ProdPlates[ipl - 1] := plateframesdata[iplf].ProdPlates[ipl];
          End;
          Dec(plateframes[iplf].NProdPlates);
        End;
      until platetomove = -1;

      (* sheet      := 1;
        sheetside  := 0;
        For ipl := 0 to plateframes[iplf].Nprodplates do
        begin
        plateframesdata[iplf].prodplates[ipl].sheetnumber := sheet;
        plateframesdata[iplf].prodplates[ipl].Front := sheetside;
        plateframesdata[iplf].prodplates[ipl].TrueFront := sheetside;
        IF sheetside = 0 then
        Begin
        sheetside := 1;
        end
        else
        begin
        sheetside := 0;
        Inc(sheet);
        end;
        end; *)
      // end;
    End;
  End;

  copyplantoplanpages;

  for iplf := 1 to Nplateframes do
  begin
    IF CheckBoxsmallimagesinEdit.checked then
      Pressviewzoom := 60
    else
      Pressviewzoom := 100;

    plateviewimage.Width := 23; // 204
    plateviewimage.Height := 51; // 176

    DrawThePlates(CheckBoxsmallimagesinEdit.checked, iplf);
  end;
  sleep(100);

end;

procedure TFormprodplan.Keeponplannedcolors;
Var
  found: Boolean;
  iplf, ipl, ip, ic, ic2: Integer;

Begin
  For iplf := 1 to Nplateframes do
  begin
    For ipl := 0 to plateframes[iplf].NProdPlates do
    begin
      plateframesdata[iplf].ProdPlates[ipl].TmpInt := 0;
      for ip := 1 to PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
      begin
        For ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors do
        begin
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic] .TmpInt := -1;
        end;
      end;
    end;
  end;

  DataM1.Query1.sql.clear;
  DataM1.Query1.sql.add
    ('select editionid,sectionid,pagename,status,colorid,uniquepage,pagetype from pagetable WITH (NOLOCK) ');
  DataM1.Query1.sql.add('where publicationid = ' +
    inttostr(plateframespublicationid));
  DataM1.Query1.sql.add('and ' + DataM1.makedatastr('', plateframesPubdate));
  DataM1.Query1.sql.add('and locationid = ' + inttostr(plateframeslocationid));
  DataM1.Query1.sql.add('and ' + DataM1.makedatastr('', plateframesPubdate));
  DataM1.Query1.sql.add('and pagetype <> 3');

  formmain.Tryopen(DataM1.Query1);
  While not DataM1.Query1.eof do
  begin
    For iplf := 1 to Nplateframes do
    begin
      IF plateframesdata[iplf].ProdPlates[0].editionid <> DataM1.Query1.fields[0].asinteger then
        continue;
      For ipl := 0 to plateframes[iplf].NProdPlates do
      begin
        for ip := 1 to PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
        begin
          if (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].sectionid = DataM1.Query1.fields[1].asinteger) and
            (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename = DataM1.Query1.fields[2].asstring) then
          begin
            found := false;
            For ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors do
            begin
              IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].ColorID = DataM1.Query1.fields[4].asinteger then
              begin
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].TmpInt := 1;
                break;
              end;
            end;
          end;
        end;
      End;
    End;
    DataM1.Query1.next;
  End;
  DataM1.Query1.close;

  For iplf := 1 to Nplateframes do
  begin
    For ipl := 0 to plateframes[iplf].NProdPlates do
    begin
      plateframesdata[iplf].ProdPlates[ipl].TmpInt := 0;
      for ip := 1 to PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
      begin
        IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype <> 3 then
        begin
          For ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors do
          begin
            IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].TmpInt = -1 then
            begin
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].active := 0;
            end;
          end;
        End;
      end;
    end;
  end;

end;

(*
procedure TFormprodplan.SuperInsert;
Var
  Pressid, Hproofid: Integer;
  publIDT, EdIDT, secIDT, IssueIDT, Color: string;

  ICPY, I, iplf, ipl, ip, ic, ColorID, Icount: Integer;
  ip2, ic2, ipl2, Iplf2: Integer;
  SeparationSet, CopyFlatSeparationSet: Integer;
  Copysets: Array of Integer;
  proofid: Integer;
  Flatproofconfig, hardproofconfig, FlatSeparationSet: Integer;
  Separation, FlatSeparation: Int64;
  AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond: Word;

Begin
  IssueIDT := inttostr(1);

  Pressid := plateframesdata[1].ProdPlates[0].Pressid;
  publIDT := inttostr(plateframesdata[1].ProdPlates[0].publicationid);

  IF FormApplyproduction.DateTimePickerdeadlinedate.checked then
  begin
    Decodedate(FormApplyproduction.DateTimePickerdeadlinedate.Date, AYear,
      AMonth, ADay);
    decodetime(FormApplyproduction.DateTimePickerdeadlinetime.Time, AHour,
      AMinute, ASecond, AMilliSecond);
  end;

  proofid := 0;
  try
    if (FormApplyproduction.ComboBoxconf.items.count > 0) AND
      (FormApplyproduction.ComboBoxconf.ItemIndex > 0) then
    begin
      proofid := Formflatproof.flatproofers[FormApplyproduction.ComboBoxconf.ItemIndex + 1].id;
    end
  except
  end;
  Hproofid := 0;
  try
    if (FormApplyproduction.ComboBoxHproofconf.items.count > 0) And
      (FormApplyproduction.ComboBoxHproofconf.ItemIndex > 0) then
    begin
      Hproofid := Formflatproof.flatproofers[FormApplyproduction.ComboBoxHproofconf.ItemIndex + 1].id;
    end
  except
  end;

  hardproofconfig := Formflatproof.flatproofconfigcalc
    (FormApplyproduction.ComboBoxHproofconf.ItemIndex > 0,
    FormApplyproduction.RadioGrouphardproofapproval.ItemIndex = 0, Hproofid);
  Formprodplan.plantimdadd('Post 7 ');
  Flatproofconfig := Formflatproof.flatproofconfigcalc
    (FormApplyproduction.ComboBoxconf.ItemIndex > 0,
    FormApplyproduction.RadioGroupApproval.ItemIndex = 0, proofid);

  productionidckeckup;

  Icount := 0;
  For iplf := 1 to Nplateframes do
  begin
    For ipl := 0 to plateframes[iplf].NProdPlates do
    begin
      Inc(Icount, PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate);
    End;
  End;
  Setlength(Copysets, Icount + 200);
  I := 0;
  DataM1.Query3.sql.clear;
  DataM1.Query3.sql.add('Select top ' + inttostr(Icount + 100) + ' number from allnum');
  DataM1.Query3.sql.add('where not exists(select copyseparationset from pagetable');
  DataM1.Query3.sql.add('where allnum.number = pagetable.copyseparationset or allnum.number = pagetable.mastercopyseparationset or allnum.number = pagetable.copyflatseparationset)');
  DataM1.Query3.sql.add('and allnum.number >= 1');
  if Prefs.debug then
    DataM1.Query3.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\' + 'Fastinsertsep.sql');
  DataM1.Query3.open;
  While not DataM1.Query3.eof do
  begin
    Inc(I);
    Copysets[I] := DataM1.Query3.fields[0].asinteger;
    DataM1.Query3.next;
  end;
  DataM1.Query3.close;
  For iplf := 1 to Nplateframes do
  begin
    For ipl := 0 to plateframes[iplf].NProdPlates do
    begin
      for ip := 1 to PlatetemplateArray
        [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
      begin
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].CopySeparationSet := -1;
      end;
    end;
  end;

  I := 0;
  For iplf := 1 to Nplateframes do
  begin
    For ipl := 0 to plateframes[iplf].NProdPlates do
    begin
      for ip := 1 to PlatetemplateArray
        [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
      begin
        Inc(I);
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].CopySeparationSet :=Copysets[I];
        IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totUniquePage = 1
        then
        Begin
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].MasterCopySeparationSet := Copysets[I];
        End;
        IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype <> 3 then
          plateframesdata[iplf].ProdPlates[ipl].CopyFlatSeparationSet :=
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].CopySeparationSet;

      end;
    end;
  end;
  For iplf := 1 to Nplateframes do
  begin
    For ipl := 0 to plateframes[iplf].NProdPlates do
    begin
      for ip := 1 to PlatetemplateArray
        [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
      begin
        IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totUniquePage <> 1
        then
        Begin
          Iplf2 := plateframesdata[iplf].ProdPlates[ipl].Pages[ip].OrgPageiplf;
          ipl2 := plateframesdata[iplf].ProdPlates[ipl].Pages[ip].OrgPageipl;
          ip2 := plateframesdata[iplf].ProdPlates[ipl].Pages[ip].OrgPageip;
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].MasterCopySeparationSet :=
            plateframesdata[Iplf2].ProdPlates[ipl2].Pages[ip2].CopySeparationSet;
        End;
      End;
    End;
  End;

  IssueIDT := inttostr(1);

  ProgressBarprod.Position := 0;
  I := 0;
  For iplf := 1 to Nplateframes do
  begin
    For ipl := 0 to plateframes[iplf].NProdPlates do
    begin
      if plateframesdata[iplf].ProdPlates[ipl].Ncopies < 1 then
        plateframesdata[iplf].ProdPlates[ipl].Ncopies := 1;

      for ip := 1 to PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
      begin

        For ICPY := 1 to plateframesdata[iplf].ProdPlates[ipl].Ncopies do
        begin
          For ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors do
          begin
            Inc(I);
          End;
        End;
      End;
    End;
  End;
  ProgressBarprod.Max := I;
  ProgressBarprod.visible := true;

  DataM1.Query3.sql.clear;
  DataM1.Query3.sql.add('ALTER INDEX ALL ON PageTable DISABLE');
  // datam1.Query3.SQL.add('ALTER INDEX ALL ON PageTable REBUILD');

  DataM1.Query3.ExecSQL(false);

  For iplf := 1 to Nplateframes do
  begin
    ReplaceTime(plateframesPubdate, EncodeTime(0, 0, 0, 0));
    plateframes[iplf].Miscdate := plateframesPubdate;
    EdIDT := inttostr(plateframesdata[iplf].ProdPlates[0].editionid);
    Insertnewpressrun(iplf);
    // EdIDT := inttostr(plateframesdata[iplf].prodplates[0].editionID);
    For ipl := 0 to plateframes[iplf].NProdPlates do
    begin
      CopyFlatSeparationSet := plateframesdata[iplf].ProdPlates[ipl].CopyFlatSeparationSet;
      for ip := 1 to PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
      begin
        secIDT := inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].sectionid);
        For ICPY := 1 to plateframesdata[iplf].ProdPlates[ipl].Ncopies do
        begin
          SeparationSet := (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].CopySeparationSet * 100) + ICPY;
          FlatSeparationSet := (CopyFlatSeparationSet * 100) + ICPY;
          For ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors do
          begin
            ProgressBarprod.Position := ProgressBarprod.Position + 1;
            ProgressBarprod.repaint;
            IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype = 3 then
            Begin
              Color := 'Dinky';
              ColorID := tnames1.Colornametoid(Color);
            End
            Else
            Begin
              ColorID := plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors
                [ic].ColorID;
              Color := tnames1.ColornameIDtoname(ColorID);
            End;

            Separation := SeparationSet;
            Separation := (Separation * 100) + ColorID;
            FlatSeparation := FlatSeparationSet;
            FlatSeparation := (FlatSeparation * 100) + ColorID;

            DataM1.Query3.sql.clear;
            DataM1.Query3.sql.add('INSERT INTO PageTable VALUES');
            DataM1.Query3.sql.add
              ('(' + inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
              .CopySeparationSet) + ',');
            DataM1.Query3.sql.add(' ' + inttostr(SeparationSet) + ',');
            DataM1.Query3.sql.add(' ' + inttostr(Separation) + ',');
            DataM1.Query3.sql.add(' ' + inttostr(CopyFlatSeparationSet) + ',');
            DataM1.Query3.sql.add(' ' + inttostr(FlatSeparationSet) + ',');
            DataM1.Query3.sql.add(' ' + inttostr(FlatSeparation) + ',');
            DataM1.Query3.sql.add(' 0,0,');
            DataM1.Query3.sql.add(' ' + publIDT + ',');
            DataM1.Query3.sql.add(' ' + secIDT + ',');
            DataM1.Query3.sql.add(' ' + EdIDT + ',');
            DataM1.Query3.sql.add(' ' + IssueIDT + ',');
            DataM1.Query3.sql.add(' ' + '''' + formatdatetime(sqldateformat,
              plateframesPubdate) + '''' + ',');

            DataM1.Query3.sql.add(' ' + '''' + plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename + '''' + ',');
            DataM1.Query3.sql.add(' ' + inttostr(ColorID) + ',');
            DataM1.Query3.sql.add
              (' ' + inttostr(PlatetemplateArray[plateframesdata[iplf]
              .ProdPlates[ipl].templatelistid].TemplateID) + ',');
            DataM1.Query3.sql.add
              (' ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
              .proofid) + ',');
            DataM1.Query3.sql.add(' 0, 0,1,');
            DataM1.Query3.sql.add(' ' + inttostr(ICPY) + ',');

            DataM1.Query3.sql.add
              (' ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
              .pagina) + ',');
            DataM1.Query3.sql.add
              (' ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
              .colors[ic].approved) + ',');
            DataM1.Query3.sql.add
              (' ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
              .colors[ic].Hold) + ',');
            DataM1.Query3.sql.add(' 1,');
            DataM1.Query3.sql.add
              (' ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
              .colors[ic].Priority) + ',');
            DataM1.Query3.sql.add(' 0,');
            DataM1.Query3.sql.add
              (' ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
              .pagetype) + ',');
            DataM1.Query3.sql.add(' 1,');
            DataM1.Query3.sql.add
              (' ' + inttostr(plateframesdata[iplf].ProdPlates[ipl]
              .sheetnumber) + ',');
            DataM1.Query3.sql.add
              (' ' + inttostr(plateframesdata[iplf].ProdPlates[ipl]
              .Front) + ',');
            DataM1.Query3.sql.add(' ' + inttostr(Pressid) + ',');
            DataM1.Query3.sql.add
              (' ' + inttostr(plateframesdata[iplf].ProdPlates[ipl]
              .Presssectionnumber) + ',');
            DataM1.Query3.sql.add(' ' + '''' + GetPlannameFromID(2,
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
              .stackpos) + '''' + ',');
            DataM1.Query3.sql.add
              (' ' + '''' + Getplantowername(plateframesdata[iplf].ProdPlates
              [ipl].Tower) + '''' + ',');
            IF plateframesdata[iplf].ProdPlates[ipl].TrueFront IN [2, 3] then
              DataM1.Query3.sql.add(' ' + '''' + fronbackstr
                [plateframesdata[iplf].ProdPlates[ipl].TrueFront - 2] +
                '''' + ',')
            else
              DataM1.Query3.sql.add(' ' + '''' + GetPlannameFromID(4,
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                .Cylinder) + '''' + ',');
            DataM1.Query3.sql.add(' ' + '''' + GetPlannameFromID(5,
              plateframesdata[iplf].ProdPlates[ipl].Zone) + '''' + ',');
            DataM1.Query3.sql.add(' ' + '''' + GetPlannameFromID(3,
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].High) +
              '''' + ',');
            DataM1.Query3.sql.add
              (' ' + inttostr(plateframesproductionid) + ',');
            DataM1.Query3.sql.add
              (' ' + inttostr(plateframesdata[iplf].ProdPlates[ipl]
              .runid) + ',');
            DataM1.Query3.sql.add(' 0,0,');
            DataM1.Query3.sql.add(' ' + '''' + '' + '''' + ',');

            DataM1.Query3.sql.add(' ' + inttostr(1) + ',');
            DataM1.Query3.sql.add
              (' ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
              .MasterCopySeparationSet) + ',');
            DataM1.Query3.sql.add
              (' ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
              .totUniquePage) + ',');
            DataM1.Query3.sql.add(' ' + inttostr(plateframeslocationid) + ',');
            DataM1.Query3.sql.add
              (' ' + inttostr(plateframesdata[iplf].ProdPlates[ipl]
              .FlatProofConfigurationID) + ',');
            DataM1.Query3.sql.add(' 0,0,');
            DataM1.Query3.sql.add(' ' + '''' + '' + '''' + ',');
            DataM1.Query3.sql.add
              (' ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
              .Pageindex) + ',');
            DataM1.Query3.sql.add(' 0,');
            DataM1.Query3.sql.add(' 0,');
            DataM1.Query3.sql.add
              (' ' + inttostr(plateframesdata[iplf].ProdPlates[ipl]
              .HardProofConfigurationID) + ',');
            DataM1.Query3.sql.add(' 0,');
            DataM1.Query3.sql.add(' ' + '''' + '' + '''' + ',');
            DataM1.Query3.sql.add(' 0,');
            DataM1.Query3.sql.add(' ' + '''' + '1/1/1975' + '''' + ',');
            DataM1.Query3.sql.add(' ' + '''' + '1/1/1975' + '''' + ',');
            DataM1.Query3.sql.add(' ' + '''' + '1/1/1975' + '''' + ',');
            DataM1.Query3.sql.add(' ' + '''' + '1/1/1975' + '''' + ',');
            DataM1.Query3.sql.add(' ' + '''' + '1/1/1975' + '''' + ',');
            DataM1.Query3.sql.add(' ' + '''' + '' + '''' + ',');
            DataM1.Query3.sql.add(' ' + '''' + 'FileName' + '''' + ',');

            DataM1.Query3.sql.add(' ' + '''' + '' + '''' + ',');
            DataM1.Query3.sql.add(' ' + '''' + '' + '''' + ',');
            IF FormApplyproduction.DateTimePickerdeadlinedate.checked then
              DataM1.Query3.sql.add(' :Deadline,')
            Else
              DataM1.Query3.sql.add(' ' + '''' + '1/1/1975' + '''' + ',');

            DataM1.Query3.sql.add(' 0,');
            DataM1.Query3.sql.add(' ' + pagepositionsfromprodplate
              (plateframesdata[iplf].ProdPlates[ipl], ip) + ',');
            DataM1.Query3.sql.add(' 0,0,0,0,0,0,');
            DataM1.Query3.sql.add
              (' ' + inttostr(plateframesdata[iplf].ProdPlates[ipl]
              .OutputPriority) + ',');
            DataM1.Query3.sql.add(' :PressTime ,');
            DataM1.Query3.sql.add
              (' ' + inttostr(plateframes[iplf].CustomerID) + ',');
            DataM1.Query3.sql.add(' 0,');
            DataM1.Query3.sql.add
              (' ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
              .colors[ic].Miscint1) + ',');
            DataM1.Query3.sql.add
              (' ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
              .colors[ic].Miscint2) + ',');
            DataM1.Query3.sql.add
              (' ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
              .colors[ic].Miscint3) + ',');
            DataM1.Query3.sql.add
              (' ' + inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
              .colors[ic].Miscint4) + ',');
            DataM1.Query3.sql.add(' ' + '''' + GetPlannameFromID(6,
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
              .Miscstring1) + '''' + ',');
            DataM1.Query3.sql.add(' ' + '''' + GetPlannameFromID(7,
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
              .Miscstring2) + '''' + ',');
            DataM1.Query3.sql.add(' ' + '''' + GetPlannameFromID(8,
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
              .Miscstring3) + '''' + ',');
            DataM1.Query3.sql.add(' :Miscdate )');

            DataM1.Query3.ParamByName('PressTime').AsSQLTimeStamp :=
              DateTimeToSQLTimeStamp(plateframes[iplf].PressTime);
            DataM1.Query3.ParamByName('Miscdate').AsSQLTimeStamp :=
              DateTimeToSQLTimeStamp(plateframes[iplf].Miscdate);

            IF FormApplyproduction.DateTimePickerdeadlinedate.checked then
              DataM1.Query3.ParamByName('deadline').AsDateTime :=
                EncodeDateTime(AYear, AMonth, ADay, AHour, AMinute, ASecond,
                AMilliSecond);

            if Prefs.debug then
              DataM1.Query3.sql.SaveToFile
                (IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) +
                'sqllogs\' + 'Fastinsert1.sql');
            DataM1.Query3.ExecSQL(false);

          end;


        End;
      End;
    End;
  End;

  DataM1.Query3.sql.clear;
  DataM1.Query3.sql.add(' ALTER INDEX ALL ON PageTable REBUILD ');
  DataM1.Query3.sql.add('  ');
  DataM1.Query3.sql.add(' ALTER TABLE PageTable CHECK CONSTRAINT ALL ');
  DataM1.Query3.ExecSQL(false);

  ProgressBarprod.Position := 0;
  ProgressBarprod.visible := false;

End;
 *)
(*
procedure TFormprodplan.FastRunIfTotnew;
begin
  makeinsectionids;
  getproductioncolors;
  genmiscstring;
  Plantimming.clear;
  Plantimer := now;
  plantimdadd('Start ');
  superinsert;
  plantimdadd('End ');

  Plantimming.SaveToFile(TUtils.GetTempDirectory() + '\FastPlantime.txt');

end;

*)
procedure TFormprodplan.Checkifallareapply;
Var
  iplf, ipl, ip: Integer;

Begin
  FoundAapplynewpage := false;
  For iplf := 1 to Nplateframes do
  begin
    For ipl := 0 to plateframes[iplf].NProdPlates do
    begin
      for ip := 1 to PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
      begin
        IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].OrgCopySeparationSet < 1 then
        begin
          FoundAapplynewpage := true;
          break;
        end;
      End;
      IF FoundAapplynewpage then
        break;
    End;
    IF FoundAapplynewpage then
      break;
  End;

end;

procedure TFormprodplan.lookforexistingplansepnum;
Var
  iplf, ipl, ip, ic: Integer;
  foundOK: Boolean;
  // mulighed
Begin
  DataM1.Query1.sql.clear;
  // 0               1           2       3        4               5                   6
  DataM1.Query1.sql.add
    ('Select distinct copyseparationset,editionid,sectionid,pagename,pressrunid,MasterCopySeparationSet,UniquePage');
  DataM1.Query1.sql.add(' from pagetable  WITH (NOLOCK) where ');
  DataM1.Query1.sql.add('publicationid = ' +
    inttostr(plateframespublicationid));
  DataM1.Query1.sql.add('and ' + DataM1.makedatastr('', plateframesPubdate));
  DataM1.Query1.sql.add('and pressid = ' + inttostr(plateframespressid));
  DataM1.Query1.sql.add('order by editionid,sectionid,pagename');
  formmain.Tryopen(DataM1.Query1);

  While not DataM1.Query1.eof do
  begin
    foundOK := false;
    For iplf := 1 to Nplateframes do
    begin
      IF plateframesdata[iplf].ProdPlates[1].editionid = DataM1.Query1.fields[1]
        .asinteger then
      begin
        For ipl := 0 to plateframes[iplf].NProdPlates do
        begin
          for ip := 1 to PlatetemplateArray
            [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
          begin
            IF (plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
              .sectionid = DataM1.Query1.fields[2].asinteger) And
              (plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
              .pagename = DataM1.Query1.fields[3].asstring) then
            begin

              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].CopySeparationSet
                := DataM1.Query1.fields[0].asinteger;
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                .OrgCopySeparationSet := DataM1.Query1.fields[0].asinteger;
              plateframesdata[iplf].ProdPlates[ipl].runid :=
                DataM1.Query1.fields[4].asinteger;
              if (Prefs.PartialNoEditionChange) then
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                  .MasterCopySeparationSet := DataM1.Query1.fields[5].asinteger;
              break;
              // IF plateframesdata[iplf].prodplates[ipl].pages[ip].OrgCopySeparationSet < 1 then
            end;
          End;
          if foundOK then
            break;
        End;
        if foundOK then
          break;
      End;
    End;
    DataM1.Query1.next;
  end;

  (*
    pressrunid,productionid,fileserver,proofID,status,proofstatus,
    hold,approved,pagetype');

  *)

  DataM1.Query1.close;

end;

procedure TFormprodplan.LookApplyData;
Var
  iplf, ipl, ip, ic: Integer;
  foundOK: Boolean;

Begin
  DataM1.Query1.sql.clear;
  // 0         1         2        3      4           5           6
  DataM1.Query1.sql.add
    ('Select colorid,fileserver,status,pressrunid,productionid,proofID,proofstatus,');
  // 7       8       9      10
  DataM1.Query1.sql.add('hold,approved,pagetype,copynumber,');
  // 11                   12           13       14
  DataM1.Query1.sql.add('CopySeparationSet, CopyFlatSeparationSet,pressrunid');

  DataM1.Query1.sql.add(' from pagetable  WITH (NOLOCK) where ');
  DataM1.Query1.sql.add('publicationid = ' +
    inttostr(plateframespublicationid));
  DataM1.Query1.sql.add('and ' + DataM1.makedatastr('', plateframesPubdate));
  DataM1.Query1.sql.add('and pressid = ' + inttostr(plateframespressid));
  DataM1.Query1.sql.add('and copynumber = 1');

  DataM1.Query1.sql.add('order by pressrunid,CopySeparationSet,colorid ');
  if Prefs.debug then
    DataM1.Query1.sql.SaveToFile
      (IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\' +
      'lookupapplydata.sql');
  formmain.Tryopen(DataM1.Query1);

  While not DataM1.Query1.eof do
  begin
    foundOK := false;
    For iplf := 1 to Nplateframes do
    begin
      IF plateframesdata[iplf].ProdPlates[1].runid = DataM1.Query1.fields[17].asinteger
      then
      begin
        For ipl := 0 to plateframes[iplf].NProdPlates do
        begin
          for ip := 1 to PlatetemplateArray
            [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
          begin
            IF (plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
              .CopySeparationSet = DataM1.Query1.fields[11].asinteger) then
            begin
              for ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                .Ncolors do
              begin
                if plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                  .ColorID = DataM1.Query1.fields[0].asinteger then
                begin

                  plateframesdata[iplf].ProdPlates[ipl].CopyFlatSeparationSet :=
                    DataM1.Query1.fields[14].asinteger;

                  plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                    .status := DataM1.Query1.fields[2].asinteger;
                  plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                    .proofstatus := DataM1.Query1.fields[6].asinteger;
                  if plateframesdata[iplf].ProdPlates[ipl].Pages[ip].proofid < 0
                  then
                    plateframesdata[iplf].ProdPlates[ipl].Pages[ip].proofid :=
                      DataM1.Query1.fields[5].asinteger;

                  plateframesdata[iplf].ProdPlates[ipl].Pages[ip].fileserver :=
                    DataM1.Query1.fields[1].asstring;

                  foundOK := true;
                  break;
                end;
              end;
              if foundOK then
                break;
            end;
          End;
          if foundOK then
            break;
        End;
        if foundOK then
          break;
      End;
    End;
    DataM1.Query1.next;
  end;
  DataM1.Query1.close;
end;

procedure TFormprodplan.Changelayoutonrun(templatename: String);
Var
  iplf, Iplf2, ipl, ip, ic, I2: Integer;
  isec: Integer;
  Nsecs: Integer;
  atemplatelistid: Integer;
  Newmarkgroups: marksarray;
  secs: array [1 .. 100] of record sectionid: Integer;
  Npages: Integer;
  firstpage: string; // index
  lastpage: string; // index
  Ninsert: Integer;
  lastindex: Integer;
  Firstindex: Integer;
  Splitrun: Boolean;
  Ncover: Integer;
end;
aproofid, asec: Integer;
L:
TListItem;
Samesec, Useplit, useoffset: Boolean;
Totnpages, Firstseciplf, Aktiplf, aktsectionid: Integer;
Secmode:
Integer;

Currunid:
Integer;
// plateframesdata[RunNumber].prodplates[0].runid
begin
  Useplit := false;
  useoffset := false;
  Samesec := false;
  isec := 1;
  aproofid := 0;

  Aktiplf := 1;
  atemplatelistid := plateframesdata[Aktiplf].ProdPlates[0].templatelistid;
  aktsectionid := plateframesdata[Aktiplf].ProdPlates[0].Pages[1].sectionid;
  Currunid := plateframesdata[Aktiplf].ProdPlates[0].runid;

  copyplantoplanpages;
  For isec := 1 to 100 do
  begin
    secs[isec].sectionid := -1;
    secs[isec].Npages := 0;
    secs[isec].firstpage := '';
    secs[isec].lastpage := '';
    secs[isec].Ninsert := 0;
    secs[isec].lastindex := 0;
    secs[isec].Firstindex := 0;
    secs[isec].Ncover := 0;
  end;
  Formeditedition.PBExListviewSections.items.clear;

  Nsecs := 0;

  asec := -1;
  For ip := 1 to planpagenames[Aktiplf].Npages do
  begin
    IF Nsecs = 0 then
    Begin
      Inc(Nsecs);
      secs[Nsecs].sectionid := planpagenames[Aktiplf].Pages[ip].sectionid;
    End;

    For isec := 1 to Nsecs do
    begin
      IF secs[isec].sectionid = planpagenames[Aktiplf].Pages[ip].sectionid then
        break;
    End;
    IF secs[isec].sectionid <> planpagenames[Aktiplf].Pages[ip].sectionid then
    begin
      Inc(Nsecs);
      secs[Nsecs].sectionid := planpagenames[Aktiplf].Pages[ip].sectionid;
      isec := Nsecs;
    end;

    IF secs[isec].Npages = 0 then
    Begin
      secs[isec].firstpage := planpagenames[Aktiplf].Pages[ip].name;
      secs[isec].Firstindex := planpagenames[Aktiplf].Pages[ip].Pageindex;
    End;
    Inc(secs[isec].Npages);
    secs[isec].lastpage := planpagenames[Aktiplf].Pages[ip].name;

    IF planpagenames[Aktiplf].Pages[ip].Pageindex > secs[isec].lastindex + 1
    then
    Begin
      secs[isec].Ninsert := (planpagenames[Aktiplf].Pages[ip].Pageindex -
        secs[isec].lastindex) - 1;
    End;
    secs[isec].lastindex := planpagenames[Aktiplf].Pages[ip].Pageindex;

    IF secs[isec].Firstindex > 1 then
      secs[isec].Ncover := (secs[isec].Firstindex - 1) * 2;

  end;

  Secmode := 2;
  IF Useplit then
    Secmode := 1;
  IF useoffset then
    Secmode := 2;

  For isec := 1 to Nsecs do
  begin
    Case Secmode of
      0:
        begin
          secs[isec].Firstindex := 0;
        end;
      1:
        begin
          secs[isec].Firstindex := 0;
        end;
      2:
        begin
          IF secs[isec].Firstindex > 0 then
            secs[isec].Firstindex := secs[isec].Firstindex - 1;
          secs[isec].Ncover := 0;
          secs[isec].Ninsert := 0;
        end;
    end;
  End;

  IF not Samesec then
  begin
    secs[isec].Firstindex := 0;
  end;
  For isec := 1 to Nsecs do
  begin
    L := Formeditedition.PBExListviewSections.items.add;
    L.Caption := tnames1.sectionIDtoname(secs[isec].sectionid);
    L.subitems.add(inttostr(secs[isec].Npages));
    L.subitems.add('');
    L.subitems.add('');
    L.subitems.add(inttostr(secs[isec].Ncover));
    L.subitems.add(inttostr(secs[isec].Ninsert));
    L.subitems.add(inttostr(secs[isec].Firstindex));
    L.subitems.add('');
    L.subitems.add('');
  end;

  Formeditedition.CheckBoxbindingstyle.checked := plateframes[Aktiplf]
    .perfecktbound = 1;
  // ## NAN 20160309
  // Formeditedition.CheckBoxbackward.checked := plateframes[Aktiplf].Backwards = 1;

  Formeditedition.Aktpressid := plateframespressid;
  Formeditedition.akttemplateListid := plateframesdata[Aktiplf].ProdPlates[0]
    .templatelistid;

  For ip := 1 to 64 do
  begin
    if plateframesdata[Aktiplf].ProdPlates[0].Pages[ip].pagetype <> 3 then
    begin
      aproofid := plateframesdata[Aktiplf].ProdPlates[0].Pages[ip].proofid;
      break;
    end;
  end;
  For ipl := 0 to plateframes[Aktiplf].NProdPlates do
  begin

    plateframesdata[Aktiplf].ProdPlates[ipl].templatelistid :=
      inittypes.gettemplatelistnumberfromname(templatename);
  End;
  For ipl := 0 to plateframes[Aktiplf].NProdPlates do
  begin
    for ip := 1 to PlatetemplateArray[plateframesdata[Aktiplf].ProdPlates[ipl]
      .templatelistid].NupOnplate do
    begin
      IF plateframesdata[Aktiplf].ProdPlates[ipl].Pages[ip].pagetype = 1 then
      begin
        plateframesdata[Aktiplf].ProdPlates[ipl].Pages[ip].pagetype := 0;
      End;

      IF plateframesdata[Aktiplf].ProdPlates[ipl].Pages[ip].pagetype = 2 then
      begin
        plateframesdata[Aktiplf].ProdPlates[ipl].Pages[ip].pagetype := 0;
        IF plateframesdata[Aktiplf].ProdPlates[ipl].Pages[ip].Ncolors <> 0 then
        begin
          For ic := 1 to plateframesdata[Aktiplf].ProdPlates[ipl].Pages[ip]
            .Ncolors do
          Begin
            plateframesdata[Aktiplf].ProdPlates[ipl].Pages[ip].colors[ic]
              .active := 1;
          end;
        End;
      End;
    End;
  End;

  Editeditiontoplanpages(Aktiplf, '', '');
  doreimposecalc(plateframesdata[Aktiplf].ProdPlates[0].templatelistid, true);

  calulatepagina;
  Editplantoplates(Aktiplf, plateframesdata[Aktiplf].ProdPlates[0]
    .templatelistid, aproofid, plateframesdata[Aktiplf].ProdPlates[0]
    .Nmarkgroups, plateframesdata[Aktiplf].ProdPlates[0].markgroups);

  applyglobdata(1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, Newmarkgroups);

  loadNoneplatedatafromdb(Aktiplf, true);
  copyplantoplanpages;

  checkuponhwafteredit;

  for iplf := 1 to Nplateframes do
  begin
    IF CheckBoxsmallimagesinEdit.checked then
      Pressviewzoom := 60
    else
      Pressviewzoom := 100;

    plateviewimage.Width := 23; // 204
    plateviewimage.Height := 51; // 176

    DrawThePlates(CheckBoxsmallimagesinEdit.checked, iplf);
  end;
end;

Procedure TFormprodplan.loadNoneplatedatafromdb(iplf: Integer;
  resetpagetype: Boolean);
Var
  ipl, ip, ic: Integer;
  Foundpage, foundcolor: Boolean;
begin
  DataM1.Query1.sql.clear;
  DataM1.Query1.sql.add
    ('Select pagename,SectionID,sheetnumber,sheetside,copyflatseparationset,flatseparationset,colorid,pagepositions from pagetable (NOLOCK)');
  DataM1.Query1.sql.add('where pressid = ' + inttostr(plateframespressid));
  DataM1.Query1.sql.add('and pressrunid = ' +
    inttostr(plateframes[iplf].pressrunid));
  DataM1.Query1.sql.add('and locationid = ' + inttostr(plateframeslocationid));
  DataM1.Query1.sql.add('and ' + DataM1.makedatastr('', plateframesPubdate));
  DataM1.Query1.sql.add
    ('order by sheetnumber,sheetside,copyflatseparationset,flatseparationset,colorid,pagepositions');
  formmain.Tryopen(DataM1.Query1);
  While not DataM1.Query1.eof do
  begin
    For ipl := 0 to plateframes[iplf].NProdPlates do
    begin
      for ip := 1 to PlatetemplateArray
        [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
      begin
        IF (DataM1.Query1.fields[0].asstring = plateframesdata[iplf].ProdPlates
          [ipl].Pages[ip].pagename) and
          (DataM1.Query1.fields[1].asinteger = plateframesdata[iplf].ProdPlates
          [ipl].Pages[ip].sectionid) then
        Begin
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors := 0;
        End;
      end;
    end;
    DataM1.Query1.next;
  End;
  DataM1.Query1.close;

  For ipl := 0 to plateframes[iplf].NProdPlates do
  begin
    for ip := 1 to PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl]
      .templatelistid].NupOnplate do
    begin
      IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors <> 0 then
      begin
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totUniquePage := 1;
        For ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
          .Ncolors do
        begin
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
            .Uniquepage := 1;
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
            .status := 0;
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
            .proofstatus := 0;
        end;
      end;
    End;
  End;

  formmain.Tryopen(DataM1.Query1);
  While not DataM1.Query1.eof do
  begin
    For ipl := 0 to plateframes[iplf].NProdPlates do
    begin
      for ip := 1 to PlatetemplateArray
        [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
      begin
        IF (DataM1.Query1.fieldbyname('pagename').asstring = plateframesdata
          [iplf].ProdPlates[ipl].Pages[ip].pagename) and
          (DataM1.Query1.fieldbyname('SectionID').asinteger = plateframesdata
          [iplf].ProdPlates[ipl].Pages[ip].sectionid) then
        Begin
          Inc(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors);
          ic := plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors;
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
            .MasterCopySeparationSet := DataM1.Query1.fieldbyname
            ('mastercopyseparationset').asinteger;

          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].ColorID :=
            DataM1.Query1.fieldbyname('colorID').asinteger;
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].proofid :=
            DataM1.Query1.fieldbyname('proofid').asinteger;
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Uniquepage
            := DataM1.Query1.fieldbyname('UniquePage').asinteger;
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totUniquePage :=
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
            .Uniquepage;
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].active :=
            DataM1.Query1.fieldbyname('active').asinteger;

          IF resetpagetype then
          begin
            if DataM1.Query1.fieldbyname('pagetype').asinteger = 1 then
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype := 0;

            if DataM1.Query1.fieldbyname('pagetype').asinteger = 2 then
            begin
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype := 0;
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                .active := 1;
            end;
          end;
          plateframesdata[iplf].ProdPlates[ipl].TrueFront := 0;
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].approved :=
            DataM1.Query1.fieldbyname('Approved').asinteger;
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].proofstatus
            := DataM1.Query1.fieldbyname('Proofstatus').asinteger;
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Priority :=
            DataM1.Query1.fieldbyname('priority').asinteger;
          plateframesdata[iplf].ProdPlates[ipl].Tower :=
            SetplanTowername(DataM1.Query1.fieldbyname('pressTower').asstring);
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].stackpos :=
            SetPlanIDFromname(2, DataM1.Query1.fieldbyname('sortingposition')
            .asstring);
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].High :=
            SetPlanhighlows(DataM1.Query1.fieldbyname('pressHighlow').asstring);
          // SetPlanIDFromname(3,DataM1.Query1.fieldbyname('pressHighlow').Asstring);
          IF (DataM1.Query1.fieldbyname('pressCylinder').asstring = fronbackstr
            [0]) or (DataM1.Query1.fieldbyname('pressCylinder')
            .asstring = fronbackstr[1]) then
          Begin
            IF (DataM1.Query1.fieldbyname('pressCylinder')
              .asstring = fronbackstr[0]) then
              plateframesdata[iplf].ProdPlates[ipl].TrueFront := 2
            else
              plateframesdata[iplf].ProdPlates[ipl].TrueFront := 3;
          end
          else
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Cylinder
              := SetPlanIDFromname(4, DataM1.Query1.fieldbyname('pressCylinder')
              .asstring);

          plateframesdata[iplf].ProdPlates[ipl].Zone :=
            SetPlanIDFromname(5, DataM1.Query1.fieldbyname('pressZone')
            .asstring);
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].status :=
            DataM1.Query1.fieldbyname('status').asinteger;
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Hold :=
            DataM1.Query1.fieldbyname('Hold').asinteger;

          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].CopySeparationSet :=
            DataM1.Query1.fieldbyname('CopySeparationSet').asinteger;
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].SeparationSet :=
            (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].CopySeparationSet *
            100) + plateframesdata[iplf].ProdPlates[ipl].Copynumber;
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Separation
            := (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].SeparationSet *
            100) + plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors
            [ic].ColorID;
        End;
      end;
    end;
    DataM1.Query1.next;
  End;
  DataM1.Query1.close;

  DataM1.Query1.sql.clear;
  DataM1.Query1.sql.add
    ('select distinct p1.pagename,p1.mastercopyseparationset,p1.editionid,p2.editionid,p2.mastercopyseparationset,p2.copyseparationset from pagetable p1 WITH (NOLOCK) , pagetable p2 WITH (NOLOCK) ');
  DataM1.Query1.sql.add
    ('where p1.uniquepage <> 1 and p2.uniquepage = 1 and p1.mastercopyseparationset = p2.mastercopyseparationset');
  formmain.Tryopen(DataM1.Query1);
  while not DataM1.Query1.eof do
  begin
    for ipl := 0 to plateframes[iplf].NProdPlates do
    begin
      for ip := 1 to PlatetemplateArray
        [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
      begin
        IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totUniquePage <> 1
        then
        begin
          IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
            .MasterCopySeparationSet = DataM1.Query1.fields[1].asinteger then
          begin
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Orgeditionid :=
              DataM1.Query1.fields[3].asinteger;
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].OrgCopySeparationSet
              := DataM1.Query1.fields[5].asinteger;
          end;
        end;
      end;
    end;
    DataM1.Query1.next;
  end;
  DataM1.Query1.close;

end;

procedure TFormprodplan.ActionSetPlateNumberExecute(Sender: TObject);
Begin
 // SetMomigrafdata;

end;

procedure TFormprodplan.Customtowersetting;

Var
  T: String;
  found: Boolean;
  itow, I, iplf, SelIplf, iplt, impl, ipl, ip, ic, icp, ivc: Integer;
  L: TListItem;

  pressname: string;
  NAutotows: Integer;
  Autotows: Array [1 .. 100] of string;
begin

  Formtower.Pressid := plateframespressid;
  Formtower.CheckBox1.visible := true;

  SelIplf := -1;
  For iplf := 1 to Nplateframes do
  begin
    if plateframes[iplf].Selected then
    begin
      SelIplf := iplf;
    End;
  End;

  For iplf := 1 to Nplateframes do
  begin
    if (SelIplf = iplf) or (CheckBoxsubedselection.checked) then
    begin

      IF plateframes[iplf].PBExListview1.Selected <> nil then
      begin
        try
          FormCustomTower.ComboBoxTower.items.clear;
          DataM1.Query1.sql.clear;
          DataM1.Query1.sql.add
            ('Select distinct TowerName from PressTowerNames');
          DataM1.Query1.sql.add('where pressid = ' +
            inttostr(plateframespressid));
          DataM1.Query1.sql.add('order by TowerName');
          formmain.Tryopen(DataM1.Query1);
          While not DataM1.Query1.eof do
          begin
            FormCustomTower.ComboBoxTower.items.add
              (DataM1.Query1.fields[0].asstring);
            DataM1.Query1.next;
          end;
          DataM1.Query1.close;
        Except
        end;

        FormCustomTower.ListViewCyl.items.clear;
        ipl := plateframes[iplf].PBExListview1.Selected.Index;
        for ip := 1 to PlatetemplateArray
          [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
        begin
          if plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype <> 3 then
          begin
            for ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
              .Ncolors do
            begin
              L := FormCustomTower.ListViewCyl.items.add;
              L.Caption := tnames1.ColornameIDtoname
                (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors
                [ic].ColorID);
              L.subitems.add(Getplantowername(plateframesdata[iplf].ProdPlates
                [ipl].Tower));
              L.subitems.add(GetPlannameFromID(4,
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                .Cylinder));
              L.subitems.add(GetPlannameFromID(2,
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                .stackpos));
            end;
            IF plateframesdata[iplf].ProdPlates[ipl].Tower <> -1 then
              FormCustomTower.ComboBoxTower.Text :=
                Getplantowername(plateframesdata[iplf].ProdPlates[ipl].Tower)
            Else
              FormCustomTower.ComboBoxTower.ItemIndex := -1;

            break;
          end;
        End;
        FormCustomTower.Aktpressid := plateframespressid;

        IF FormCustomTower.ShowModal = mrok then
        begin

          For ipl := 0 to plateframes[iplf].NProdPlates do
          begin
            IF plateframes[iplf].PBExListview1.items[ipl].Selected then
            Begin
              plateframesdata[iplf].ProdPlates[ipl].Tower :=
                SetplanTowername(FormCustomTower.ListViewCyl.items[0]
                .subitems[0]);

              for ip := 1 to PlatetemplateArray
                [plateframesdata[iplf].ProdPlates[ipl].templatelistid]
                .NupOnplate do
              begin
                for ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                  .Ncolors do
                begin
                  For icp := 0 to FormCustomTower.ListViewCyl.items.count - 1 do
                  begin
                    if plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors
                      [ic].ColorID = tnames1.Colornametoid
                      (FormCustomTower.ListViewCyl.items[icp].Caption) then
                    begin
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                        .Cylinder :=
                        SetPlanIDFromname(4, FormCustomTower.ListViewCyl.items
                        [icp].subitems[1]);
                      // plateframesdata[iplf].prodplates[ipl].pages[ip].colors[ic].Zone     := SetPlanIDFromname(5,FormCustomTower.ListViewCyl.Items[icp].SubItems[1]);
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                        .stackpos :=
                        SetPlanIDFromname(2, FormCustomTower.ListViewCyl.items
                        [icp].subitems[2]);
                      break;
                    end;
                  end;
                End;
              End;
            End;
          End;
          plateviewimage.Width := 23; // 204
          plateviewimage.Height := 51; // 176
          For I := 1 to Nplateframes do
          begin
            plateframes[I].PBExListview1.clear;
            plateframes[I].ImageListplanframe.clear;
            DrawThePlates(CheckBoxsmallimagesinEdit.checked, I);
          end;
        end;
      End;
    End;
  End;
end;

procedure TFormprodplan.ActionplantowerExecute(Sender: TObject);
Var
  T: String;
  found: Boolean;
  itow, I, iplf, SelIplf, iplt, impl, ipl, ip, ic, icp, ivc: Integer;
  L: TListItem;

  pressname: string;
  NAutotows: Integer;
  Autotows: Array [1 .. 100] of string;
begin
  SelIplf := -1;
  For iplf := 1 to Nplateframes do
  begin
    if plateframes[iplf].Selected then
    begin
      SelIplf := iplf;
    End;
  End;

  if (Prefs.UseCustomTowerNames) then
  begin
    Customtowersetting;
  end
  else
  begin
    FormWebnaming.Pressid := plateframespressid;
    FormWebnaming.Webkindname := 1;
    FormWebnaming.Labelwizardheader1.Caption := 'Tower name';
    FormWebnaming.InitNames;
    IF FormWebnaming.ShowModal = mrok then
    begin
      For iplf := 1 to Nplateframes do
      begin
        For impl := 0 to plateframes[iplf].PBExListview1.items.count - 1 do
        begin
          IF plateframes[iplf].PBExListview1.items[impl].Selected then
          begin
            iplt := ImagenumbertoIPL(iplf, impl);
            For icp := 0 to plateframes[iplf].Numberofcopies - 1 do
            begin
              ipl := icp + iplt;
              plateframesdata[iplf].ProdPlates[ipl].Tower :=
                SetplanTowername(FormWebnaming.ComboBox1.Text);
            End;
          End;
        End;
      End;
      plateviewimage.Width := 23; // 204
      plateviewimage.Height := 51; // 176
      For I := 1 to Nplateframes do
      begin
        plateframes[I].PBExListview1.clear;
        plateframes[I].ImageListplanframe.clear;
        DrawThePlates(CheckBoxsmallimagesinEdit.checked, I);
      end;
    end;

  End;

end;

procedure TFormprodplan.ActionZoneExecute(Sender: TObject);
Var
  T: String;
  found: Boolean;
  itow, I, iplf, SelIplf, iplt, impl, ipl, ip, ic, icp
  // ,ivc
    : Integer;
  // l : tlistitem;

  // Pressname : string;
  // NAutotows : Integer;
  // Autotows : Array[1..100] of string;
begin

  SelIplf := -1;
  For iplf := 1 to Nplateframes do
  begin
    if plateframes[iplf].Selected then
    begin
      SelIplf := iplf;
    End;
  End;

  IF (Prefs.UseCustomTowerNames) then
  begin
    Customtowersetting;
  end
  else
  begin
    FormWebnaming.Pressid := plateframespressid;
    FormWebnaming.Webkindname := 2;
    FormWebnaming.Labelwizardheader1.Caption := 'Zone name';
    FormWebnaming.InitNames;
    IF FormWebnaming.ShowModal = mrok then
    begin
      For iplf := 1 to Nplateframes do
      begin
        For impl := 0 to plateframes[iplf].PBExListview1.items.count - 1 do
        begin
          IF plateframes[iplf].PBExListview1.items[impl].Selected then
          begin
            iplt := ImagenumbertoIPL(iplf, impl);
            For icp := 0 to plateframes[iplf].Numberofcopies - 1 do
            begin
              ipl := icp + iplt;
              plateframesdata[iplf].ProdPlates[ipl].Zone :=
                SetPlanIDFromname(5, FormWebnaming.ComboBox1.Text);
            End;
          End;
        End;
      End;
      plateviewimage.Width := 23; // 204
      plateviewimage.Height := 51; // 176
      For I := 1 to Nplateframes do
      begin
        plateframes[I].PBExListview1.clear;
        plateframes[I].ImageListplanframe.clear;
        DrawThePlates(CheckBoxsmallimagesinEdit.checked, I);
      end;
    end;
  End;
end;

procedure TFormprodplan.ActionHighlowExecute(Sender: TObject);
Var
  // T : String;
  // found : boolean;
  // itow,
  I, iplf, SelIplf, iplt, impl, ipl, ip, ic, icp
  // ,ivc
    : Integer;
  // l : tlistitem;

  // Pressname : string;
  // NAutotows : Integer;
  // Autotows : Array[1..100] of string;
begin

  SelIplf := -1;
  For iplf := 1 to Nplateframes do
  begin
    if plateframes[iplf].Selected then
    begin
      SelIplf := iplf;
    End;
  End;

  if (Prefs.UseCustomTowerNames) then
  begin
    Customtowersetting;
  end
  else
  begin
    FormWebnaming.Pressid := plateframespressid;
    FormWebnaming.Webkindname := 3;
    FormWebnaming.Labelwizardheader1.Caption := 'High / low';
    FormWebnaming.InitNames;

    IF FormWebnaming.ShowModal = mrok then
    begin
      For iplf := 1 to Nplateframes do
      begin
        For impl := 0 to plateframes[iplf].PBExListview1.items.count - 1 do
        begin
          if (plateframes[iplf].PBExListview1.items[impl].Selected) OR
            (FormWebnaming.CheckBocApplyToAllPlates.checked) then
          begin
            iplt := ImagenumbertoIPL(iplf, impl);
            For icp := 0 to plateframes[iplf].Numberofcopies - 1 do
            begin
              ipl := icp + iplt;
              for ip := 1 to PlatetemplateArray
                [plateframesdata[iplf].ProdPlates[ipl].templatelistid]
                .NupOnplate do
              begin
                if plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype <> 3
                then
                begin
                  for ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                    .Ncolors do
                  begin
                    if (icp = 0) then
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                        .High := FormWebnaming.ComboBox1.ItemIndex
                    else
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                        .High := FormWebnaming.ComboBox2.ItemIndex;
                  end;
                End;
              end;
            end;
          End;
        End;
      End;
      plateviewimage.Width := 23; // 204
      plateviewimage.Height := 51; // 176
      For I := 1 to Nplateframes do
      begin
        plateframes[I].PBExListview1.clear;
        plateframes[I].ImageListplanframe.clear;
        DrawThePlates(CheckBoxsmallimagesinEdit.checked, I);
      end;
    end;
  End;
end;

procedure TFormprodplan.ActiontrueSheetsideExecute(Sender: TObject);
Var
  // T : String;
  // found : boolean;
  // itow,
  I, iplf,
  // ,seliplf,
  iplt, impl, ipl
  // ,ip,ic
    , icp
  // ,ivc
    : Integer;
  // l : tlistitem;

  // Pressname : string;
  // NAutotows : Integer;
  // Autotows : Array[1..100] of string;
begin

  SelIplf := -1;
  For iplf := 1 to Nplateframes do
  begin
    if plateframes[iplf].Selected then
    begin
      SelIplf := iplf;
    End;
  End;

  FormWebnaming.Pressid := plateframespressid;
  FormWebnaming.Webkindname := 4;
  FormWebnaming.Labelwizardheader1.Caption := 'True Front or Back';
  FormWebnaming.InitNames;
  IF FormWebnaming.ShowModal = mrok then
  begin
    For iplf := 1 to Nplateframes do
    begin
      For impl := 0 to plateframes[iplf].PBExListview1.items.count - 1 do
      begin
        IF plateframes[iplf].PBExListview1.items[impl].Selected then
        begin
          iplt := ImagenumbertoIPL(iplf, impl);
          For icp := 0 to plateframes[iplf].Numberofcopies - 1 do
          begin
            ipl := icp + iplt;
            plateframesdata[iplf].ProdPlates[ipl].TrueFront :=
              2 + FormWebnaming.ComboBox1.ItemIndex;
          End;
        End;
      End;
    End;
    plateviewimage.Width := 23; // 204
    plateviewimage.Height := 51; // 176
    For I := 1 to Nplateframes do
    begin
      plateframes[I].PBExListview1.clear;
      plateframes[I].ImageListplanframe.clear;
      DrawThePlates(CheckBoxsmallimagesinEdit.checked, I);
    end;
  end;

end;

procedure TFormprodplan.ActionpresscylnameExecute(Sender: TObject);
Var
  iplf, iplt, impl, ipl, ip, ic, icp, firstselectedside: Integer;
  T, colname: String;
begin
  Formpresscylinder.NColoridstocyl := 4;
  Formpresscylinder.Coloridstocyl[1].ColorID := tnames1.Colornametoid('C');
  Formpresscylinder.Coloridstocyl[1].cylname := '';
  Formpresscylinder.Coloridstocyl[1].colorname := 'C';
  Formpresscylinder.Coloridstocyl[2].ColorID := tnames1.Colornametoid('M');
  Formpresscylinder.Coloridstocyl[2].cylname := '';
  Formpresscylinder.Coloridstocyl[2].colorname := 'M';
  Formpresscylinder.Coloridstocyl[3].ColorID := tnames1.Colornametoid('Y');
  Formpresscylinder.Coloridstocyl[3].cylname := '';
  Formpresscylinder.Coloridstocyl[3].colorname := 'Y';
  Formpresscylinder.Coloridstocyl[4].ColorID := tnames1.Colornametoid('K');
  Formpresscylinder.Coloridstocyl[4].cylname := '';
  Formpresscylinder.Coloridstocyl[4].colorname := 'K';

  Formpresscylinder.Pressid := plateframespressid;

  firstselectedside := -1;
  for iplf := 1 to Nplateframes do
  begin
    For impl := 0 to plateframes[iplf].PBExListview1.items.count - 1 do
    begin
      if plateframes[iplf].PBExListview1.items[impl].Selected then
      begin
        iplt := ImagenumbertoIPL(iplf, impl);
        for icp := 0 to plateframes[iplf].Numberofcopies - 1 do
        begin
          ipl := icp + iplt;
          firstselectedside := plateframesdata[iplf].ProdPlates[ipl].Front;
          break;
        end;
      end;
      if (firstselectedside <> -1) then
        break;
    end;
    if (firstselectedside <> -1) then
      break;
  end;

  Formpresscylinder.InitNames(firstselectedside);
  if Formpresscylinder.ShowModal = mrok then
  begin
    For iplf := 1 to Nplateframes do
    begin
      For impl := 0 to plateframes[iplf].PBExListview1.items.count - 1 do
      begin
        IF plateframes[iplf].PBExListview1.items[impl].Selected then
        begin
          iplt := ImagenumbertoIPL(iplf, impl);
          For icp := 0 to plateframes[iplf].Numberofcopies - 1 do
          begin
            ipl := icp + iplt;
            for ip := 1 to PlatetemplateArray
              [plateframesdata[iplf].ProdPlates[ipl].templatelistid]
              .NupOnplate do
            begin
              if plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype <> 3
              then
              begin
                for ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                  .Ncolors do
                begin
                  colname := tnames1.ColornameIDtoname
                    (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors
                    [ic].ColorID);
                  T := Formpresscylinder.ValueListEditorCyl.values[colname];
                  IF length(T) > 5 then
                    delete(T, 5, 100);
                  plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                    .Cylinder := SetPlanIDFromname(4, T);
                end;
              End;
            end;
          end;
        End;
      End;
    End;
  End;
end;

Procedure TFormprodplan.SetMomigrafdata;

  Procedure setsmallplates;
  Var
    iplf, ipl, ipln, ip, ic, cyldid, miscstrid, towid, platenumber: Integer;
    Newcaption: String;

  Begin
    miscstrid := 0;
    For ip := 1 to 96 do
    begin
      ic := SetPlanIDFromname(1, inttostr(ip));
    end;
    (*
      For ip := 1 to 96 do
      begin
      ic := SetPlanIDFromname(6,inttostr(ip));
      end;
    *)
    ic := SetPlanIDFromname(4, 'F');
    ic := SetPlanIDFromname(4, 'B');

    ic := SetPlanIDFromname(5, 'NS');
    ic := SetPlanIDFromname(5, 'FS');
    towid := 1;
    platenumber := 1;
    For iplf := 1 to Nplateframes do
    begin
      For ipln := 1 to (plateframes[iplf].NProdPlates + 1) DIV 2 do
      begin
        ipl := ipln - 1;

        plateframesdata[iplf].ProdPlates[ipl].Tower :=
          SetPlanIDFromname(1, inttostr(towid));
        if ipl - 1 < plateframes[iplf].NProdPlates div 2 then
        Begin
          plateframesdata[iplf].ProdPlates[ipl].Zone :=
            SetPlanIDFromname(5, 'FS');

        End
        else
        Begin
          plateframesdata[iplf].ProdPlates[ipl].Zone :=
            SetPlanIDFromname(5, 'NS');
        End;

        IF plateframesdata[iplf].ProdPlates[ipl].Front = 0 then
        Begin
          cyldid := SetPlanIDFromname(4, 'F');
        End
        Else
        begin
          cyldid := SetPlanIDFromname(4, 'B');
        end;
        // miscstrid := SetPlanIDFromname(6,inttostr(platenumber));
        for ip := 1 to PlatetemplateArray
          [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
        begin
          For ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
            .Ncolors do
          begin
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
              .Miscstring1 := miscstrid;
          end;
          IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype <> 3 then
          begin
            For ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
              .Ncolors do
            begin
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                .High := 0;
              // plateframesdata[iplf].prodplates[ipl].Pages[ip].colors[ic].Miscstring1 := miscstrid;
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                .Cylinder := cyldid;
            End;
          End;
        End;
        // GetPlannameFromID(6,miscstrid)+','+
        Newcaption := 'P:' + GetPlannameFromID(1,
          plateframesdata[iplf].ProdPlates[ipl].Tower) + ',Z:' +
          GetPlannameFromID(5, plateframesdata[iplf].ProdPlates[ipl].Zone) +
          ',S:' + GetPlannameFromID(4, cyldid);

        // inttostr(plateframesdata[IPLF].prodplates[ipl].sheetnumber) +
        plateframes[iplf].PBExListview1.items[ipl].Caption := Newcaption;

        ipl := plateframes[iplf].NProdPlates - ipl;
        plateframesdata[iplf].ProdPlates[ipl].Tower :=
          SetPlanIDFromname(1, inttostr(towid));
        if ipl - 1 < plateframes[iplf].NProdPlates div 2 then
        Begin
          plateframesdata[iplf].ProdPlates[ipl].Zone :=
            SetPlanIDFromname(5, 'FS');

        End
        else
        Begin
          plateframesdata[iplf].ProdPlates[ipl].Zone :=
            SetPlanIDFromname(5, 'NS');

        End;

        IF plateframesdata[iplf].ProdPlates[ipl].Front = 0 then
        Begin
          cyldid := SetPlanIDFromname(4, 'F');
        End
        Else
        begin
          cyldid := SetPlanIDFromname(4, 'B');
        end;
        for ip := 1 to PlatetemplateArray
          [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
        begin
          IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype <> 3 then
          begin
            For ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
              .Ncolors do
            begin
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                .High := 0;
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                .Cylinder := cyldid;
              // plateframesdata[iplf].prodplates[ipl].Pages[ip].colors[ic].Miscstring1 := miscstrid;
            End;
          End;
        End;

        // inttostr(plateframesdata[IPLF].prodplates[ipl].sheetnumber) +
        // GetPlannameFromID(6,miscstrid)+','+
        Newcaption := 'P:' + GetPlannameFromID(1,
          plateframesdata[iplf].ProdPlates[ipl].Tower) + ',Z:' +
          GetPlannameFromID(5, plateframesdata[iplf].ProdPlates[ipl].Zone) +
          ',S:' + GetPlannameFromID(4, cyldid);

        plateframes[iplf].PBExListview1.items[ipl].Caption := Newcaption;
        IF (ipln mod 2) = 0 then
          Inc(towid);

        Inc(platenumber);

      End;

    End;
  end;

  Procedure setBigplates;
  Var
    iplf, ipl, ipln, ip, ic, cyldid, miscstrid, towid, platenumber: Integer;
    Newcaption: String;

  Begin
    miscstrid :=  0;
    For ip := 1 to 96 do
    begin
      ic := SetPlanIDFromname(1, inttostr(ip));
    end;
    (*
      For ip := 1 to 96 do
      begin
      ic := SetPlanIDFromname(6,inttostr(ip));
      end;
    *)
    ic := SetPlanIDFromname(4, 'F');
    ic := SetPlanIDFromname(4, 'B');

    ic := SetPlanIDFromname(5, 'NS');
    ic := SetPlanIDFromname(5, 'FS');
    towid := 1;
    platenumber := 1;
    For iplf := 1 to Nplateframes do
    begin
      For ipln := 1 to (plateframes[iplf].NProdPlates + 1) do
      begin
        ipl := ipln - 1;

        plateframesdata[iplf].ProdPlates[ipl].Tower :=
          SetPlanIDFromname(1, inttostr(towid));
        if ipl - 1 < plateframes[iplf].NProdPlates div 2 then
        Begin
          plateframesdata[iplf].ProdPlates[ipl].Zone :=
            SetPlanIDFromname(5, 'FS');

        End
        else
        Begin
          plateframesdata[iplf].ProdPlates[ipl].Zone :=
            SetPlanIDFromname(5, 'NS');
        End;

        IF plateframesdata[iplf].ProdPlates[ipl].Front = 0 then
        Begin
          cyldid := SetPlanIDFromname(4, 'F');
        End
        Else
        begin
          cyldid := SetPlanIDFromname(4, 'B');
        end;
        // miscstrid := SetPlanIDFromname(6,inttostr(platenumber));
        for ip := 1 to PlatetemplateArray
          [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
        begin
          For ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
            .Ncolors do
          begin
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Miscstring1 := miscstrid;
          end;
          IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype <> 3 then
          begin
            For ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
              .Ncolors do
            begin

              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                .High := 0;
              // plateframesdata[iplf].prodplates[ipl].Pages[ip].colors[ic].Miscstring1 := miscstrid;
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                .Cylinder := cyldid;
            End;
          End;
        End;
        // GetPlannameFromID(6,miscstrid)+','+
        Newcaption := 'P:' + GetPlannameFromID(1,
          plateframesdata[iplf].ProdPlates[ipl].Tower) + ',Z:' +
          GetPlannameFromID(5, plateframesdata[iplf].ProdPlates[ipl].Zone) +
          ',S:' + GetPlannameFromID(4, cyldid);

        // inttostr(plateframesdata[IPLF].prodplates[ipl].sheetnumber) +
        plateframes[iplf].PBExListview1.items[ipl].Caption := Newcaption;

        ipl := plateframes[iplf].NProdPlates - ipl;
        plateframesdata[iplf].ProdPlates[ipl].Tower :=
          SetPlanIDFromname(1, inttostr(towid));
        if ipl - 1 < plateframes[iplf].NProdPlates div 2 then
        Begin
          plateframesdata[iplf].ProdPlates[ipl].Zone :=
            SetPlanIDFromname(5, 'FS');

        End
        else
        Begin
          plateframesdata[iplf].ProdPlates[ipl].Zone :=
            SetPlanIDFromname(5, 'NS');

        End;

        IF plateframesdata[iplf].ProdPlates[ipl].Front = 0 then
        Begin
          cyldid := SetPlanIDFromname(4, 'F');
        End
        Else
        begin
          cyldid := SetPlanIDFromname(4, 'B');
        end;
        for ip := 1 to PlatetemplateArray
          [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
        begin

          For ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
            .Ncolors do
          begin
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
              .Miscstring1 := miscstrid;
          end;

          IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype <> 3 then
          begin
            For ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
              .Ncolors do
            begin
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                .High := 0;
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                .Cylinder := cyldid;
              // plateframesdata[iplf].prodplates[ipl].Pages[ip].colors[ic].Miscstring1 := miscstrid;
            End;
          End;
        End;

        // inttostr(plateframesdata[IPLF].prodplates[ipl].sheetnumber) +
        // GetPlannameFromID(6,miscstrid)+','+
        Newcaption := 'P:' + GetPlannameFromID(1,
          plateframesdata[iplf].ProdPlates[ipl].Tower) + ',Z:' +
          GetPlannameFromID(5, plateframesdata[iplf].ProdPlates[ipl].Zone) +
          ',S:' + GetPlannameFromID(4, cyldid);

        plateframes[iplf].PBExListview1.items[ipl].Caption := Newcaption;
        Inc(towid);

        Inc(platenumber);

      End;

    End;
  end;

Var
  iplf: Integer;

begin
  IF PlatetemplateArray[plateframesdata[1].ProdPlates[0].templatelistid]
    .MediaID > 0 then
  begin
    setBigplates;
  end
  else
  begin
    setsmallplates;
  end;
  for iplf := 1 to Nplateframes do
  begin
    plateframes[iplf].PBExListview1.Font := CheckBoxsubedselection.Font;
  end;
end;

procedure TFormprodplan.Checkfrontbackon1up;
Var
  iplf, sheetN, sheet: Integer;
  sheetside: Integer;

  Procedure setsec(aktsecid: Integer);
  Var
    icp, iplt, impl, ipl
    // ipln,
    // IP,ic
    // ,cyldid
      : Integer;

  Begin
    sheetN := -1;
    For impl := 0 to plateframes[iplf].NProdPlates do
    begin
      iplt := ImagenumbertoIPL(iplf, impl);
      For icp := 0 to plateframes[iplf].Numberofcopies - 1 do
      begin
        ipl := icp + iplt;
        if plateframesdata[iplf].ProdPlates[ipl].Pages[1].sectionid = aktsecid
        then
        begin
          Inc(sheetN);
          IF sheetN mod 2 = 0 then
          begin
            Inc(sheet);

          end;
          IF sheetside = 0 then
            sheetside := 1
          else
            sheetside := 0;
          plateframesdata[iplf].ProdPlates[ipl].sheetnumber := sheet;
          plateframesdata[iplf].ProdPlates[ipl].Front := sheetside;
        End;
      End;

    End;
  End;

Var
  iplt, icp, ipl, aktsecid, nsec, isec, impl: Integer;
  found: Boolean;
  Sections: array [1 .. 100] of Integer;
Begin
  aktsecid := -1;
  nsec := 0;
  found := false;

  For iplf := 1 to Nplateframes do
  begin
    IF (PlatetemplateArray[plateframesdata[iplf].ProdPlates[0].templatelistid]
      .NupOnplate = 1) then
    begin
      sheet := 0;
      sheetside := 1;
      aktsecid := plateframesdata[iplf].ProdPlates[0].Pages[1].sectionid;
      nsec := 1;
      Sections[nsec] := aktsecid;
      For impl := 0 to plateframes[iplf].NProdPlates do
      begin

        iplt := impl; // ImagenumbertoIPL(Iplf,impl);

        For icp := 0 to plateframes[iplf].Numberofcopies - 1 do
        begin
          ipl := icp + iplt;
          if aktsecid <> plateframesdata[iplf].ProdPlates[ipl].Pages[1].sectionid
          then
          begin
            aktsecid := plateframesdata[iplf].ProdPlates[ipl].Pages[1]
              .sectionid;
            found := false;
            for isec := 1 to nsec do
            begin
              if Sections[isec] = aktsecid then
              begin
                found := true;
                break;
              end;
            end;
            if not found then
            begin
              Inc(nsec);
              Sections[nsec] := aktsecid;
            end;
          End;
        End;
      end;
      for isec := 1 to nsec do
      begin
        sheetside := 1;
        setsec(Sections[isec]);
      end;

    End;
  End;
end;

procedure TFormprodplan.Button4Click(Sender: TObject);
begin
  Checkfrontbackon1up;
end;

{ procedure TFormprodplan.SetRunningnumbers(prepaired : Boolean;
  FromPressrun : Integer;
  ToPressrun : Integer);
  Var
  presecI,
  //Ied,aktedition,
  ip : Integer;
  PNN : Integer;

  Begin

  For presecI := FromPressrun to ToPressrun do
  begin
  PNN := planpagenames[FromPressrun].Npages;

  For ip := 1 to (planpagenames[presecI].Npages DIV 2) do
  begin
  Inc(PNN);
  planpagenames[FromPressrun].pages[pnn] := planpagenames[presecI].pages[ip];
  planpagenames[FromPressrun].pages[pnn].pagina := pnn;
  end;

  For ip := (planpagenames[presecI].Npages DIV 2)+1 to planpagenames[presecI].Npages  do//fra  -8
  begin
  Inc(PNN);
  planpagenames[FromPressrun].pages[pnn] := planpagenames[presecI].pages[ip];
  planpagenames[FromPressrun].pages[pnn].pagina := pnn;
  end;
  planpagenames[FromPressrun].Npages := PNN;

  End;

  End;
}
procedure TFormprodplan.RadioGrouppageviewtextXYZClick(Sender: TObject);
Var
  I: Integer;

begin
  plateviewimage.Width := 23; // 204
  plateviewimage.Height := 51; // 176
  For I := 1 to Nplateframes do
  begin
    plateframes[I].PBExListview1.clear;
    plateframes[I].ImageListplanframe.clear;
    DrawThePlates(CheckBoxsmallimagesinEdit.checked, I);
  end;
end;

procedure TFormprodplan.LookForCenterSpread;
Var
  iplf, ipl, ip, antipairpos: Integer;
  pagetypes: TPageNumbering;
  // antipanoposes : TPageNumbering;
Begin
  IF (Editmode IN [1, 3, 4, 5]) then
  Begin

    DataM1.Query1.sql.clear; // 0          1        2        3              4
    DataM1.Query1.sql.add
      ('select distinct pagetype,editionid,sectionid,PageName,mastercopyseparationset from PageTable WITH (NOLOCK) ');
    DataM1.Query1.sql.add('where pagetype = 1');
    DataM1.Query1.sql.add('and ' + DataM1.makedatastr('', plateframesPubdate));
    DataM1.Query1.sql.add('and publicationid = ' +
      inttostr(plateframespublicationid));
    DataM1.Query1.open;
    While not DataM1.Query1.eof do
    begin
      For iplf := 1 to Nplateframes do
      begin
        For ipl := 0 to plateframes[iplf].NProdPlates do
        begin
          IF PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl]
            .templatelistid].NupOnplate > 1 then
          begin
            for ip := 1 to PlatetemplateArray
              [plateframesdata[iplf].ProdPlates[ipl].templatelistid]
              .NupOnplate do
            begin
              IF (plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                .sectionid = DataM1.Query1.fields[2].asinteger) and
                (plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                .pagename = DataM1.Query1.fields[3].asstring) then
              begin
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype := 1;
                antipairpos := formmain.Supergetantipos(ip, pagetypes,
                  plateframesdata[iplf].ProdPlates[ipl].templatelistid, true);
                IF antipairpos <> -1 then
                  plateframesdata[iplf].ProdPlates[ipl].Pages[antipairpos]
                    .pagetype := 2;
                break;
              end;
            end;
          end;
        End;
      End;
      DataM1.Query1.next;
    end;
    DataM1.Query1.close;

  End;
end;

procedure TFormprodplan.ActionAutoHWExecute(Sender: TObject);
Var
  AIPLF: Integer;
  Nup: Integer;
Begin
  Nup := PlatetemplateArray[plateframesdata[1].ProdPlates[1].templatelistid]
    .NupOnplate;
  For AIPLF := 1 to Nplateframes do
  begin
    IF (planpagenames[AIPLF].Npages) Mod (Nup * 2) <> 0 then
    begin
      Mouseoveriplf := AIPLF;
      Mouseoveripl := plateframes[AIPLF].NProdPlates;
      mouseoverip := 1;
      mouseoverimage := plateframes[AIPLF].NProdPlates;

      SetHWonSpecifik(AIPLF, plateframes[AIPLF].NProdPlates);
      break;
    End;
  End;

End;

Function TFormprodplan.getpaginaoffset(iplf: Integer): Integer;

Var
  Paginaoffset, ipl2, ip: Integer;
Begin
  { achange }
  Paginaoffset := 99999;
  result := 1;
  For ipl2 := 0 to plateframes[iplf].NProdPlates do
  begin
    for ip := 1 to PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl2]
      .templatelistid].NupOnplate do
    begin
      IF (Paginaoffset > plateframesdata[iplf].ProdPlates[ipl2].Pages[ip]
        .pagina) and (plateframesdata[iplf].ProdPlates[ipl2].Pages[ip]
        .pagina > 0) then
      Begin

        Paginaoffset := plateframesdata[iplf].ProdPlates[ipl2].Pages[ip].pagina;
        result := Paginaoffset;
      end;
    End;
  End;
End;

procedure TFormprodplan.ActionpagechangemasterExecute(Sender: TObject);
Var
  I: Integer;
  aktsecid, Iplf2, ipl2, ip2, Il, iplf, ipl, ip, ic, neweditionid: Integer;
  ail, T, t1: string;
  updateOK: Boolean;
  aktpagename: string;

  akttop: Integer;

begin
  ail := '-1';
  akttop := PBExListview1.TopItem.Index;
  FormListselection.listbox1.items.clear;
  For iplf := 1 to Nplateframes do
  begin
    For ipl := 0 to plateframes[iplf].NProdPlates do
    begin
      for ip := 1 to PlatetemplateArray
        [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
      begin
        IF (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totUniquePage > 0)
        then
        begin
          T := tnames1.editionIDtoname(plateframesdata[iplf].ProdPlates[ipl]
            .editionid);
          I := FormListselection.listbox1.items.IndexOf(T);
          if I < 0 then
          begin
            FormListselection.listbox1.items.add(T);
          end;
        End;
      End;
    End;
  End;

  FormListselection.Caption := 'Change master edition to';
  IF (FormListselection.ShowModal = mrok) and
    (FormListselection.listbox1.ItemIndex > -1) then
  begin
    neweditionid := tnames1.editionnametoid(FormListselection.listbox1.items
      [FormListselection.listbox1.ItemIndex]);

    For Il := 0 to PBExListview1.items.count - 1 do
    begin

      IF PBExListview1.items[Il].Selected then
      begin
        T := PBExListview1.items[Il].subitems[21];
        t1 := copy(T, 1, POS(',', T) - 1);
        iplf := StrToInt(t1);
        delete(T, 1, POS(',', T));
        t1 := copy(T, 1, POS(',', T) - 1);
        ipl := StrToInt(t1);
        delete(T, 1, POS(',', T));
        t1 := copy(T, 1, POS(',', T) - 1);
        ip := StrToInt(t1);

        aktsecid := plateframesdata[iplf].ProdPlates[ipl].Pages[ip].sectionid;
        aktpagename := plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename;
        updateOK := false;
        For Iplf2 := 1 to Nplateframes do
        begin
          For ipl2 := 0 to plateframes[Iplf2].NProdPlates do
          begin
            for ip2 := 1 to PlatetemplateArray
              [plateframesdata[Iplf2].ProdPlates[ipl2].templatelistid]
              .NupOnplate do
            begin
              IF (plateframesdata[Iplf2].ProdPlates[ipl2].Pages[ip2]
                .totUniquePage > 0) and
                (plateframesdata[Iplf2].ProdPlates[ipl2]
                .editionid = neweditionid) and
                (plateframesdata[Iplf2].ProdPlates[ipl2].Pages[ip2]
                .sectionid = aktsecid) and
                (plateframesdata[Iplf2].ProdPlates[ipl2].Pages[ip2]
                .pagename = aktpagename) then
              begin
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                  .totUniquePage := 0;
                // nymast
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                  .MasterCopySeparationSet := plateframesdata[Iplf2].ProdPlates
                  [ipl2].Pages[ip2].CopySeparationSet;

                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Orgeditionid :=
                  plateframesdata[Iplf2].ProdPlates[ipl2].editionid;
                For ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                  .Ncolors do
                Begin
                  plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                    .Uniquepage := 0;
                  plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                    .Orgeditionid := plateframesdata[Iplf2].ProdPlates[ipl2]
                    .editionid;
                End;
                updateOK := true;
                break
              end;
              if updateOK then
                break;
            end;
            if updateOK then
              break;
          End;
          if updateOK then
            break;
        End;

        IF (updateOK) and (Prefs.HideCommonPlates) then
        begin
          IF Not FindACommonplate(iplf, ipl) then
          begin
            for ip := 1 to PlatetemplateArray
              [plateframesdata[iplf].ProdPlates[ipl].templatelistid]
              .NupOnplate do
            begin
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                .totUniquePage := 2;
            End;
            plateframesdata[iplf].ProdPlates[ipl].anyuniquepages := true;
            plateframesdata[iplf].Anyuniqueplate := true;
          end;
        end;
      End;
    End;
    makepagelist(PBExListview1, akttop);
  End;
end;

procedure TFormprodplan.ActionmakeplatepageuniqueExecute(Sender: TObject);
Var
  iplf, ipl, ip, ic: Integer;
  multiplate: Boolean;
begin
  multiplate := false;
  For iplf := 1 to Nplateframes do
  begin
    IF plateframes[iplf].Selected then
    begin
      if plateframes[iplf].PBExListview1.SelCount > 1 then
      begin
        multiplate := true;
      end;
      IF multiplate then
        break;
    end;
    IF multiplate then
      break;
  end;

  iplf := Mouseoveriplf;
  ipl := Mouseoveripl;
  ip := mouseoverip;
  IF (iplf > -1) and (ipl > -1) and (ip > -1) then
  begin
    plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totUniquePage := 1;
    // nymast
    plateframesdata[iplf].ProdPlates[ipl].Pages[ip].MasterCopySeparationSet :=
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].CopySeparationSet;

    plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Orgeditionid :=
      plateframesdata[iplf].ProdPlates[ipl].editionid;
    For ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors do
    Begin
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
        .Uniquepage := 1;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Orgeditionid :=
        plateframesdata[iplf].ProdPlates[ipl].editionid;
    End;

    DrawThePlates(CheckBoxsmallimagesinEdit.checked, iplf);

    (*
      plateviewimage.Width := 23;    //204
      plateviewimage.height := 51;   //176
      For i := 1 to Nplateframes do
      begin
      plateframes[i].PBExListview1.clear;
      plateframes[i].ImageListplanframe.Clear;
      drawtheplates(CheckBoxsmallimagesinEdit.Checked,i);
      end;

    *)

  end;

end;

procedure TFormprodplan.ActionmakeplateuniqueExecute(Sender: TObject);
Var
  iplf, ipl, ip, ic: Integer;
begin
  For iplf := 1 to Nplateframes do
  begin
    IF plateframes[iplf].Selected then
    begin
      For ipl := 0 to plateframes[iplf].NProdPlates do
      begin
        IF plateframes[iplf].PBExListview1.items[ipl].Selected then
        begin
          for ip := 1 to PlatetemplateArray
            [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
          begin
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totUniquePage := 1;
            // nymast
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
              .MasterCopySeparationSet := plateframesdata[iplf].ProdPlates[ipl]
              .Pages[ip].CopySeparationSet;

            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Orgeditionid :=
              plateframesdata[iplf].ProdPlates[ipl].editionid;
            For ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
              .Ncolors do
            Begin
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                .Uniquepage := 1;
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic]
                .Orgeditionid := plateframesdata[iplf].ProdPlates[ipl]
                .editionid;
            End;
          End;
        end
      End;
      DrawThePlates(CheckBoxsmallimagesinEdit.checked, iplf);
      break;
    end;
  End;
end;

Function TFormprodplan.CheckForUniquePlates: Integer;
Var
  iplf, ipl, ip
  // ,ic,nup
    : Integer;
  Nuniqueplatets: Integer;
  T, t1, t2: String;
begin
  result := 0;
  For iplf := 1 to Nplateframes do
  begin
    For ipl := 0 to plateframes[iplf].NProdPlates do
    begin
      T := '';
      t1 := '';
      t2 := '';
      for ip := 1 to PlatetemplateArray
        [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
      begin
        T := T + ',' + inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].OrgPageiplf);
        t1 := t1 + ',' + plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename;
        t2 := t2 + ',' + inttostr(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Orgeditionid);
      End;
    end;
  End;

  if (Prefs.HideCommonPlates) then
  begin
    Nuniqueplatets := 0;
    For iplf := 1 to Nplateframes do
    begin
      plateframesdata[iplf].Anyuniqueplate := false;
    end;

    For iplf := 1 to Nplateframes do
    begin
      plateframesdata[iplf].Anyuniqueplate := false;
      For ipl := 0 to plateframes[iplf].NProdPlates do
      begin
        plateframesdata[iplf].ProdPlates[ipl].NUniquepages := 0;
        for ip := 1 to PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
        begin
          IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totUniquePage > 0
          then
          begin
            Inc(plateframesdata[iplf].ProdPlates[ipl].NUniquepages);
          End;
        End;

        IF plateframesdata[iplf].ProdPlates[ipl].NUniquepages > 0 then
        begin
          plateframesdata[iplf].Anyuniqueplate := true;
        end
        Else
        begin
        end;

        IF plateframesdata[iplf].ProdPlates[ipl].NUniquepages < 1 then
        begin
          plateframesdata[iplf].ProdPlates[ipl].anyuniquepages := false;
          IF Not FindACommonplate(iplf, ipl) then
          begin
            for ip := 1 to PlatetemplateArray
              [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
            begin
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totUniquePage := 2;
            End;
            plateframesdata[iplf].ProdPlates[ipl].anyuniquepages := true;
            plateframesdata[iplf].Anyuniqueplate := true;
          End;

        end
        Else
        begin
          plateframesdata[iplf].ProdPlates[ipl].anyuniquepages := true;
        end;
      end;
    End;
  End
  Else
  begin
    For iplf := 1 to Nplateframes do
    begin
      plateframesdata[iplf].Anyuniqueplate := true;
      For ipl := 0 to plateframes[iplf].NProdPlates do
      begin
        plateframesdata[iplf].ProdPlates[ipl].anyuniquepages := true;
        plateframesdata[iplf].ProdPlates[ipl].NUniquepages := 0;
        for ip := 1 to PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
        begin
          IF plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totUniquePage > 0
          then
          begin
            Inc(plateframesdata[iplf].ProdPlates[ipl].NUniquepages);
          End;
        End;
      End;
    end;
  end;
end;

Function TFormprodplan.FindACommonplate(Iplf2: Integer; ipl2: Integer): Boolean;
Var
  iplf, ip, nup2, tmplid2: Integer;
  PlateOK: Boolean;
  Nplates2: Integer;
  Torged2: String;
  aktorged: String;

Begin
  tmplid2 := plateframesdata[Iplf2].ProdPlates[ipl2].templatelistid;
  nup2 := PlatetemplateArray[tmplid2].NupOnplate;
  Nplates2 := plateframes[Iplf2].NProdPlates;
  Torged2 := '';
  for ip := 1 to nup2 do
  // platetemplatearray[plateframesdata[iplf2].prodplates[ipl2].templatelistid].NupOnplate do
  begin
    Torged2 := Torged2 + ',' + plateframesdata[Iplf2].ProdPlates[ipl2].Pages[ip].pagename +
      '-' + inttostr(plateframesdata[Iplf2].ProdPlates[ipl2].Pages[ip].Orgeditionid);
  End;

  result := false;
  For iplf := 1 to Nplateframes do
  begin
    IF iplf <> Iplf2 then
    begin
      IF Nplates2 = plateframes[iplf].NProdPlates then
      Begin
        IF plateframesdata[iplf].ProdPlates[ipl2].templatelistid = tmplid2 then
        begin
          PlateOK := true;
          aktorged := '';
          for ip := 1 to PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl2].templatelistid].NupOnplate do
          begin
            aktorged := aktorged + ',' + plateframesdata[iplf].ProdPlates[ipl2].Pages[ip].pagename + '-' +
              inttostr(plateframesdata[iplf].ProdPlates[ipl2].Pages[ip].Orgeditionid);
          End;
          IF aktorged <> Torged2 then
          begin
            PlateOK := false;
          end;
          IF PlateOK then
          begin
            result := true;
          end;
        End; // plateframesdata[iplf].prodplates[ipl2].templatelistid
      end; // Nplates2 = plateframes[iplf].Nprodplates
    End; // Iplf <> Iplf2
    IF result then
    begin
      break;
    end;
  End;
end;

procedure TFormprodplan.PBExListview1AdvancedCustomDrawItem
  (Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  Stage: TCustomDrawStage; var DefaultDraw: Boolean);
begin
  (*
    DefaultDraw := true;
    IF Stage = cdPrePaint then
    begin

    if (SubItem = 1) then
    begin
    if (SubItem = 1) And (Item.SubItems.Count > 12)  {, cdPostPaint} then
    begin
    if Item.SubItems[0] <> Item.SubItems[10] then
    PBExListview1.color := clSkyBlue
    else
    PBExListview1.color := clWindow;
    end;
    end;
    end
    Else
    begin
    IF PBExListview1.color <> clWindow then
    PBExListview1.color := clWindow;
    end;

    PBExListview1.color := clWindow;
    IF Item.SubItems.Count > 12 then
    begin
    if Item.SubItems[0] <> Item.SubItems[10] then
    PBExListview1.color := clSkyBlue;
    end;
  *)

  // cdPrePaint, cdPostPaint
end;

Function TFormprodplan.makeApagetext(pagename: String; Pageindex: Integer;
  pagina: Integer): String;
Begin
  result := '';

  IF CheckBoxname.checked then
    result := pagename;

  IF CheckBoxindex.checked then
  begin
    IF result <> '' then
      result := result + '/';
    result := result + inttostr(Pageindex);
  end;

  IF CheckBoxpagina.checked then
  begin
    IF result <> '' then
      result := result + '/';
    result := result + inttostr(pagina);
  end;

end;

procedure TFormprodplan.CheckBoxnameClick(Sender: TObject);
Var
  I: Integer;

begin
  IF NOT(CheckBoxname.checked or CheckBoxindex.checked or CheckBoxpagina.checked)
  then
    CheckBoxname.checked := true;

  plateviewimage.Width := 23; // 204
  plateviewimage.Height := 51; // 176
  For I := 1 to Nplateframes do
  begin
    plateframes[I].PBExListview1.clear;
    plateframes[I].ImageListplanframe.clear;
    DrawThePlates(CheckBoxsmallimagesinEdit.checked, I);
  end;
end;

Procedure TFormprodplan.Newcalulatepagina;
Var
  // Aktpresssecionnumber,
  aktsectionid, aktedid, isec, Ipage: Integer;
  pagina, I, iplf, ipl, ip, ied
  // ,neds
    , NEditions: Integer;

  // aktsecid,
  aktied, PageSum, Insertsum: Integer;

  seccounter: Array [1 .. 200] of record editionid: Integer;
  nSections: Integer;
  Sections: Array [1 .. 100] of record sectionid: Integer;
  counter: Integer;
  Npages: Integer;
  PageSum: Integer;
  Insertsum: Integer;
  Lowpagindex: Integer;

end;
end;

Begin
  IF usenewpagina then
  begin
    aktedid := -1;
    aktsectionid := -1;

    pagina := 0;
    for ied := 1 to 200 do // editions
    begin
      seccounter[ied].editionid := -1;
      seccounter[ied].nSections := 0;
      for isec := 1 to 100 do // sections in edition
      begin
        seccounter[ied].Sections[isec].sectionid := -1;
        seccounter[ied].Sections[isec].counter := 0;
        seccounter[ied].Sections[isec].Npages := 0;
        seccounter[ied].Sections[isec].Insertsum := 0;
        seccounter[ied].Sections[isec].PageSum := 0;
        seccounter[ied].Sections[isec].Lowpagindex := 1000;
      end;
    end;
    NEditions := 0;

    For isec := 1 to Nplanpagesections do
    begin
      for Ipage := 1 to planpagenames[isec].Npages do
      begin
        aktied := 0;
        for ied := 1 to NEditions do
        begin
          if (seccounter[ied].editionid = planpagenames[isec].editionid) then
          begin
            aktied := ied;
            break;
          end;
        end;

        if aktied = 0 then
        begin
          Inc(NEditions);
          aktied := NEditions;
          seccounter[aktied].editionid := planpagenames[isec].editionid;
        end;

        ied := aktied;
        pagina := 0;

        for I := 1 to seccounter[ied].nSections do
        begin
          if seccounter[ied].Sections[I].sectionid = planpagenames[isec].Pages
            [Ipage].sectionid then
          begin
            Inc(seccounter[ied].Sections[I].Npages);
            pagina := seccounter[ied].Sections[I].Npages;

            If seccounter[ied].Sections[I].Lowpagindex > planpagenames[isec].Pages[Ipage].Pageindex then
              seccounter[ied].Sections[I].Lowpagindex := planpagenames[isec].Pages[Ipage].Pageindex;

            break;
          end;
        end;

        if pagina = 0 then
        begin
          Inc(seccounter[ied].nSections);
          seccounter[ied].Sections[seccounter[ied].nSections].sectionid :=
            planpagenames[isec].Pages[Ipage].sectionid;
          seccounter[ied].Sections[seccounter[ied].nSections].Npages := 1;
          seccounter[ied].Sections[seccounter[ied].nSections].Lowpagindex :=
            planpagenames[isec].Pages[Ipage].Pageindex;
        end;

      End;
    End;

    for ied := 1 to NEditions do
    begin
      PageSum := 0;
      seccounter[ied].Sections[1].PageSum := 0;
      for I := 2 to seccounter[ied].nSections do
      begin
        Inc(PageSum, seccounter[ied].Sections[I - 1].Npages);
        seccounter[ied].Sections[I].PageSum := PageSum;
      end;
    end;

    for ied := 1 to NEditions do
    begin
      seccounter[ied].Sections[seccounter[ied].nSections].Insertsum := 0;
      if seccounter[ied].nSections > 1 then
      begin
        Insertsum := seccounter[ied].Sections[seccounter[ied].nSections].PageSum;
        for I := seccounter[ied].nSections - 1 downto 1 do
        begin
          Dec(Insertsum, seccounter[ied].Sections[I + 1].Npages);
          seccounter[ied].Sections[I].Insertsum := Insertsum;
        End;
      end;
    end;

    // Set pageindex to default
    for ied := 1 to NEditions do
    begin
      for I := 1 to seccounter[ied].nSections do
      begin
        ListBoxnumsort.items.clear;
        ip := 0;
        For isec := 1 to Nplanpagesections do
        begin
          for Ipage := 1 to planpagenames[isec].Npages do
          begin
            IF (planpagenames[isec].editionid = seccounter[ied].editionid) and
              (seccounter[ied].Sections[I].sectionid = planpagenames[isec].Pages[Ipage].sectionid) then
            begin
              Inc(ip);
              planpagenames[isec].Pages[Ipage].paginaindex := ip;
            end;
          End;
        end;
      end;
    End;

    Case ComboBoxdefpagina.ItemIndex of
      0:
        Begin
          For isec := 1 to Nplanpagesections do
          begin
            for Ipage := 1 to planpagenames[isec].Npages do
            begin
              planpagenames[isec].Pages[Ipage].pagina := planpagenames[isec].Pages[Ipage].paginaindex;
            end;
          End;
        end;
      1:
        Begin
          (*
            For Isec := 1 to Nplanpagesections do
            begin
            for ipage := 1 to planpagenames[isec].Npages do
            begin
            for ied := 1 to neditions do
            begin
            for i := 1 to seccounter[ied].Nsections do
            begin
            seccounter[ied].Sections[i].npages

            IF planpagenames[isec].editionid = seccounter[ied].editionid then
            begin
            if seccounter[ied].Sections[i].sectionid = planpagenames[isec].pages[ipage].Sectionid then
            begin
            IF planpagenames[isec].pages[ipage].paginaindex <= (seccounter[ied].Sections[i].npages div 2 ) then
            begin
            planpagenames[isec].pages[ipage].pagina := (planpagenames[isec].pages[ipage].paginaindex +
            (seccounter[ied].Sections[i].pagesum div 2));
            end
            else
            begin

            end;
            break;
            end;
            end;
            end;

            end;
            End;
            End;
          *)
        end;
      2:
        Begin // consecutive
          For isec := 1 to Nplanpagesections do
          begin
            for Ipage := 1 to planpagenames[isec].Npages do
            begin
              for ied := 1 to NEditions do
              begin
                IF planpagenames[isec].editionid = seccounter[ied].editionid
                then
                begin
                  for I := 1 to seccounter[ied].nSections do
                  begin
                    if seccounter[ied].Sections[I].sectionid = planpagenames[isec].Pages[Ipage].sectionid then
                    begin
                      planpagenames[isec].Pages[Ipage].pagina :=
                        (planpagenames[isec].Pages[Ipage].paginaindex +
                        seccounter[ied].Sections[I].PageSum);
                      break;
                    end;
                  end;
                end;
              end;
            End;
          End;
        end;

    end;

    // Transfer to plate structure

    For isec := 1 to Nplanpagesections do
    begin
      for Ipage := 1 to planpagenames[isec].Npages do
      begin
        For iplf := 1 to Nplateframes do
        begin
          For ipl := 0 to plateframes[iplf].NProdPlates do
          begin
            for ip := 1 to PlatetemplateArray
              [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
            begin
              if (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Pageindex = planpagenames[isec].Pages[Ipage].Pageindex) and
                (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].sectionid = planpagenames[isec].Pages[Ipage].sectionid) and
                (plateframesdata[iplf].ProdPlates[ipl].editionid = planpagenames[isec].editionid) then
              begin
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagina := planpagenames[isec].Pages[Ipage].pagina;
              end;
            End;
          End;
        End;
      end;
    end;
  end;

  (*



    PaginationMode=0: Pagination starter forfra for hver sektion, uafh�ngigt af om udskydning er inserted eller ej A1=1..A16=16,B1=1�
    PaginationMode=1: Pagination er genneml�bende gennem alle sektioner som inserted. A1=1..A8=8,B1=9..B16=24,A9=25�
    PaginationMode=2: Pagination er genneml�bende gennem alle sektioner som consecutivt  A1=1.. A16=16,B1=17�.B16=32
    Platename (MiscString1) er altid laveste pagination p� hver plade. Hvis der er custom-shit skal det laves i spImportCenterPressRunCustom
  *)

end;

procedure TFormprodplan.ComboBoxdefpaginaChange(Sender: TObject);
Var
  I: Integer;
  // iplf : Integer;

begin
  Newcalulatepagina;
  plateviewimage.Width := 23; // 204
  plateviewimage.Height := 51; // 176
  For I := 1 to Nplateframes do
  begin
    plateframes[I].PBExListview1.clear;
    plateframes[I].ImageListplanframe.clear;
    DrawThePlates(CheckBoxsmallimagesinEdit.checked, I);
  end;
end;

Function TFormprodplan.loadpressplanSTB(Var parentBox: TScrollBox;
  showit: Boolean; small: Boolean; applying: Boolean;
  changeLoadedsections: Boolean): Boolean;

Var

  iplf, ipl: Integer;
begin
  formmain.planlogging('loadpressplan');

  result := false;
  try
    IF Formloadstbplan.itspartial then
    begin
    end
    else
    begin
      if (not applying) then
      Begin
        Formloadstbplan.Applytopublid := -1;
        Formloadstbplan.Applytopprodname := '';
      end;
    End;
    plateframesproductionname := '';
    Formloadstbplan.selectedpressID := plateframespressid;
    Formloadstbplan.init;

    if Formloadstbplan.ListBoxpresstemplatename.items.count = 0 then
    begin
      MessageDlg(formmain.InfraLanguage1.Translate('There are no press plans'),
        mtInformation, [mbOk], 0);
      exit;
    end;

    Formloadstbplan.Sectionschanged := false;
    if showit then
    begin
      Formloadstbplan.Applingtoplan := applying;
      IF Formloadstbplan.ShowModal <> mrok then
        exit;
    end
    else
    begin
    end;

    IF CheckBoxsmallimagesinEdit.checked then
      Pressviewzoom := 60
    else
      Pressviewzoom := 100;

    plateviewimage.Width := 23; // 204
    plateviewimage.Height := 51; // 176

    DataM1.Query1.sql.clear;
    DataM1.Query1.sql.add('Select distinct numberofruns from Presstemplate');
    DataM1.Query1.sql.add('where presstemplateid = ' + inttostr(Formloadstbplan.selectedplanid));
    formmain.Tryopen(DataM1.Query1);
    Nplateframes := 0;
    IF Not DataM1.Query1.eof then
    Begin
      Nplateframes := DataM1.Query1.fields[0].asinteger;
      IF Formloadstbplan.UsingProddata then
      begin
        Nplateframes := Nplateframes * Formloadstbplan.NumberOfEditionsInProd;
      end;
    End;
    DataM1.Query1.close;

    IF Nplateframes = 0 then
      exit;

    formmain.allocateplateframes(parentBox, Nplateframes);

    plateframesproductionname := Formloadstbplan.Editplanname.Text;

    if Editmode = 5 then
    begin // den bliver applyet s� den har allerede et productionnames og id
    end
    else
    begin
      plateframesproductionid := -1;
    end;

    EditProductionname.Text := plateframesproductionname;

    plateframespublicationid := tnames1.publicationnametoid
      (Formloadstbplan.ComboBoxPublication.Text);
    plateframesPubdate := Formloadstbplan.DateTimePicker1loadplan.Date;
    Currentcreep := Formloadstbplan.Creep;
    LoadpressplandataSTD(Formloadstbplan.selectedplanid,
      Formloadstbplan.selectedpressID, false, changeLoadedsections);

    if Editmode = 5 then
      findunplannedUniquepages;

    IF Nplateframes > 1 then
    begin
      For iplf := 2 to Nplateframes do
      begin
        For ipl := 0 to plateframes[iplf].NProdPlates do
        begin
          IF plateframesdata[iplf].ProdPlates[ipl].Presssectionnumber = 1 then
            plateframesdata[iplf].ProdPlates[ipl].Presssectionnumber := iplf;
        End;
      End;
    End;

    IF (Formloadstbplan.Sectionschanged) and (showit) then
    begin

      changesectionsSTB;
    end;

    IF (Formloadstbplan.Editionchanged) and (showit) then
    Begin
      changeeditionsSTB;
    end;

    IF ((Formloadstbplan.Offsetchanged) or (Formprodplan.planningaction = 6))
      and (showit) then
    Begin
      changeoffsetSTB;
    end;

    Checkfornocolorpages;

    findorgedpages;
    For iplf := 1 to Nplateframes do
    Begin
      IF small then
        Pressviewzoom := 60
      else
        Pressviewzoom := 100;

      plateviewimage.Width := 23; // 204
      plateviewimage.Height := 51; // 176

      lookforcenterspread;
      DrawThePlates(small, iplf);
      plateframes[iplf].Refresh;
    End;

    Formprodplan.findorgedpages;
    pressruncaptionnames;
    FormApplyproduction.LoadSchedules;

    result := true;
    // IF unplannedexists then
    // begin
    // MessageDlg(formmain.InfraLanguage1.Translate('There are unplanned pages for this publcation a plan must be applied from main menu'), mtError,[mbOk], 0);
    // result := false;
    // end;
  Except
  end;
  formmain.planlogging('loadpressplan end');
end;

Procedure TFormprodplan.LoadpressplandataSTD(presstemplateid: Integer;
  Pressid: Integer; multiplan: Boolean; changeLoadedsections: Boolean);
Var
  iplf, ipl, ip, ic, icopy, Ncopies: Integer;
  aktsheet, aktfront, aktcopy: Integer;

  PDFPlan: Boolean; // 1 tif,2pdf
  blackcolorid, ColorID: Integer;

  addbycopy: Boolean;
  m1, m2: Integer;

  I, nfl, ied, maxnproddata: Integer;

  Firsteditionid, Iedition, Neditionidinpresstemplate: Integer;
  DBRunnumber, runnumbercounter: Integer;
Begin // NprodplatesSize
  Ncopies := 1;
  Validplancolors := '';
  blackcolorid := tnames1.Colornametoid('K');
  PDFPlan := false;
  DataM1.Query1.sql.clear;
  DataM1.Query1.sql.add('Select Distinct color from Presstemplate');

  formmain.Tryopen(DataM1.Query1);
  While not DataM1.Query1.eof do
  Begin
    ColorID := DataM1.Query1.fields[0].asinteger;
    if inittypes.Isablackcolor(ColorID) then
      blackcolorid := ColorID;

    IF ColorID = tnames1.PDFCOLORID then
      PDFPlan := true;
    if (Validplancolors <> '') then
      Validplancolors := Validplancolors + ',';
    Validplancolors := Validplancolors + DataM1.Query1.fields[0].asstring;

    DataM1.Query1.next;
  end;

  DataM1.Query1.close;

  Validplancolors := '(' + Validplancolors + ')';

  DataM1.Query1.sql.clear;
  DataM1.Query1.sql.add
    ('Select max(runnumber),max(flatnumber),max(copynumber) from Presstemplate');
  DataM1.Query1.sql.add('where presstemplateid = ' + inttostr(presstemplateid));
  DataM1.Query1.sql.add('and pressid = ' + inttostr(Pressid));
  formmain.Tryopen(DataM1.Query1);
  IF not DataM1.Query1.eof then
  begin
    maxnproddata := ((DataM1.Query1.fields[1].asinteger * DataM1.Query1.fields
      [2].asinteger) * 2) + 2;
    nfl := DataM1.Query1.fields[0].asinteger;
    // NAN
    Ncopies := DataM1.Query1.fields[2].asinteger;
  end;
  DataM1.Query1.close;
  // UsingProddata

  For I := 1 to Nplateframes + 1 do
  begin
    formmain.Allocateprodplates(I, maxnproddata + 32);
  end;
  (*
    For i := 1 to nfl+1 do
    begin
    formmain.Allocateprodplates(i,maxnproddata);
    end;
  *)

  DataM1.Query1.sql.clear;
  DataM1.Query1.sql.add('Select * from Presstemplate');
  DataM1.Query1.sql.add('where presstemplateid = ' + inttostr(presstemplateid));
  DataM1.Query1.sql.add('and pressid = ' + inttostr(Pressid));

  if (not PDFPlan) and (ApplyingToPDF) then
  Begin
    DataM1.Query1.sql.add('and (color = ' + inttostr(blackcolorid));
    DataM1.Query1.sql.add('or pagetype = 3)');

  end;
  //
  DataM1.Query1.sql.add
    ('order by runnumber,flatnumber,copynumber,front,pairpos,platenumber ');
  // iplf      sheetnumber      ip      ic

  ipl := -1;
  aktsheet := -1;
  aktfront := -1;
  aktcopy := -1;
  iplf := -1;

  runnumbercounter := 0;
  if Prefs.debug then
    DataM1.Query1.sql.SaveToFile
      (IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\' +
      'loadpresstemplate.sql');

  For ied := 1 to Formloadstbplan.NumberOfEditionsInProd do
  begin
    DBRunnumber := -11;
    formmain.Tryopen(DataM1.Query1);
    While not DataM1.Query1.eof do
    Begin
      Formtower.CheckBox1.checked :=
        Boolean(DataM1.Query1.fieldbyname('UsePressTowerInfo').asinteger);
      IF DBRunnumber <> DataM1.Query1.fieldbyname('runnumber').asinteger then
      Begin
        IF (Ncopies > 1) And (ipl > -1) then
        Begin
          For icopy := 2 to Ncopies do
          Begin
            Inc(ipl);
            plateframesdata[iplf].ProdPlates[ipl] := plateframesdata[iplf].ProdPlates[ipl - 1];
            plateframesdata[iplf].ProdPlates[ipl].Copynumber := icopy;
            plateframesdata[iplf].ProdPlates[ipl].FlatSeparationSet :=
              (100 * plateframesdata[iplf].ProdPlates[ipl].CopyFlatSeparationSet) + icopy;

            For ip := 1 to PlatetemplateArray
              [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
            Begin
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].SeparationSet :=
                (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].CopySeparationSet * 100) + icopy;
              For ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors do
              Begin
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Copynumber := icopy;
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].FlatSeparation :=
                  (plateframesdata[iplf].ProdPlates[ipl].FlatSeparationSet * 100) + plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].ColorID;
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Separation :=
                  (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].SeparationSet * 100) + plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].ColorID;
              End;
            End;
          End;
          addbycopy := true;
        End;

        DBRunnumber := DataM1.Query1.fieldbyname('runnumber').asinteger;
        Inc(runnumbercounter);
        IF iplf > -1 then
          plateframes[iplf].NProdPlates := ipl;
        iplf := runnumbercounter;
        ipl := -1;
        aktsheet := -1;
        aktfront := -1;
        Ncopies := DataM1.Query1.fieldbyname('copynumber').asinteger;
      end;
      IF Formloadstbplan.CheckBoxChangecopies.checked then
        Ncopies := Formloadstbplan.UpDownCopies.Position;
      icopy := 1;

      addbycopy := false;
      IF (Ncopies > 1) And (ipl > -1) then
      begin
        if (aktsheet <> DataM1.Query1.fieldbyname('flatnumber').asinteger) or
          (aktfront <> DataM1.Query1.fieldbyname('front').asinteger) then
        begin
          For icopy := 2 to Ncopies do
          begin
            Inc(ipl);
            plateframesdata[iplf].ProdPlates[ipl] := plateframesdata[iplf].ProdPlates[ipl - 1];
            plateframesdata[iplf].ProdPlates[ipl].Copynumber := icopy;
            plateframesdata[iplf].ProdPlates[ipl].FlatSeparationSet :=
              (100 * plateframesdata[iplf].ProdPlates[ipl].CopyFlatSeparationSet) + icopy;
            for ip := 1 to PlatetemplateArray
              [plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
            Begin
              plateframesdata[iplf].ProdPlates[ipl].Pages[ip].SeparationSet :=
                (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].CopySeparationSet * 100) + icopy;
              For ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors do
              begin
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Copynumber := icopy;
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].FlatSeparation :=
                  (plateframesdata[iplf].ProdPlates[ipl].FlatSeparationSet * 100) + plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].ColorID;
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Separation :=
                  (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].SeparationSet * 100) + plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].ColorID;
              end;
            end;
          End;
          addbycopy := true;
        End;
      end;

      if (aktsheet <> DataM1.Query1.fieldbyname('flatnumber').asinteger) or
        (aktfront <> DataM1.Query1.fieldbyname('front').asinteger) then
      begin
        Inc(ipl);
        ip := -1;
      End;

      aktfront := DataM1.Query1.fieldbyname('front').asinteger;
      aktsheet := DataM1.Query1.fieldbyname('flatnumber').asinteger;
      prodsections := DataM1.Query1.fieldbyname('sections').asstring;
      prodpages := DataM1.Query1.fieldbyname('pages').asstring;
      prodcombined := DataM1.Query1.fieldbyname('combined').asinteger;
      prodbindingstyle := DataM1.Query1.fieldbyname('bindingstyle').asinteger;
      prodcollection := DataM1.Query1.fieldbyname('collection').asinteger;
      prodplancreep := DataM1.Query1.fieldbyname('Plancreep').AsFloat;

      prodplannedhold := Formloadstbplan.RadioGrouplocked.ItemIndex;
      prodplannedapproval := Formloadstbplan.RadioGroupApproval.ItemIndex;
      plateframesPubdate := Formloadstbplan.DateTimePicker1loadplan.Date;
      iplf := runnumbercounter;
      plateframes[iplf].pressrunid := iplf;

      plateframes[iplf].NProdPlates := ipl;
      // plateframesdata[iplf].prodplates[ipl].Ncopies := 1;
      plateframes[iplf].Numberofcopies := 1;
      plateframes[iplf].PressConfignameX := DataM1.Query1.fieldbyname('pressrunconfig').asstring;
      plateframes[iplf].Inkcomment := '';
      plateframes[iplf].Comment := DataM1.Query1.fieldbyname('Pressruncomment').asstring;
      plateframes[iplf].perfecktbound := DataM1.Query1.fieldbyname('perfecktbound').asinteger;

      // ## NAN 20160309
      // plateframes[iplf].Backwards := DataM1.Query1.FieldByName('Backwards').asinteger;
      plateframes[iplf].RipSetupID := DataM1.Query1.fieldbyname('Backwards').asinteger; // Backwards field used for RipSetupID
      if (plateframes[iplf].RipSetupID < 0) then
        plateframes[iplf].RipSetupID := 0;

      plateframes[iplf].inserted := DataM1.Query1.fieldbyname('Inserted').asinteger;

      plateframesdata[iplf].ProdPlates[ipl].Changed := false;
      plateframesdata[iplf].ProdPlates[ipl].Front :=
        DataM1.Query1.fieldbyname('Front').asinteger;
      plateframesdata[iplf].ProdPlates[ipl].TrueFront :=
        DataM1.Query1.fieldbyname('Front').asinteger;
      plateframesdata[iplf].ProdPlates[ipl].sheetnumber :=
        DataM1.Query1.fieldbyname('flatnumber').asinteger;
      plateframesdata[iplf].ProdPlates[ipl].FlatSeparationSet := 0;
      plateframesdata[iplf].ProdPlates[ipl].CopyFlatSeparationSet :=
        DataM1.Query1.fieldbyname('CopyFlatSeparationSet').asinteger;
      plateframesdata[iplf].ProdPlates[ipl].productionid :=
        plateframesproductionid;
      plateframesdata[iplf].ProdPlates[ipl].IssueID := 0;
      plateframesdata[iplf].ProdPlates[ipl].publicationid :=
        plateframespublicationid;
      plateframesdata[iplf].ProdPlates[ipl].Copynumber := 1;
      plateframesdata[iplf].ProdPlates[ipl].Ncopies := Ncopies;
      plateframesdata[iplf].ProdPlates[ipl].editionid :=
        DataM1.Query1.fieldbyname('EditionID').asinteger;
      IF Formloadstbplan.UsingProddata then
      begin
        plateframesdata[iplf].ProdPlates[ipl].editionid :=
          tnames1.editionnametoid(Formeditionorder.listbox1.items[ied - 1]);
      end;
      plateframesdata[iplf].ProdPlates[ipl].Locationid := plateframeslocationid;

      IF Formloadstbplan.ComboBoxtemplate.ItemIndex > 0 then
      begin
        plateframesdata[iplf].ProdPlates[ipl].templatelistid :=
          inittypes.gettemplatelistnumberfromname(Formloadstbplan.ComboBoxtemplate.Text);
      end
      else
        plateframesdata[iplf].ProdPlates[ipl].templatelistid :=
          inittypes.gettemplatenumberfromID(DataM1.Query1.fieldbyname('templateid').asinteger);

      plateframesdata[iplf].ProdPlates[ipl].deviceid := 0;
      plateframesdata[iplf].ProdPlates[ipl].Pressid := plateframespressid;
      plateframesdata[iplf].ProdPlates[ipl].runid := -99;
      plateframesdata[iplf].ProdPlates[ipl].produce := true;
      plateframesdata[iplf].ProdPlates[ipl].readytoproduce := false;
      plateframesdata[iplf].ProdPlates[ipl].someerror := false;
      plateframesdata[iplf].ProdPlates[ipl].totappr := prodplannedapproval - 1;
      plateframesdata[iplf].ProdPlates[ipl].totstat := 0;
      plateframesdata[iplf].ProdPlates[ipl].NUniquepages := 64;
      plateframesdata[iplf].ProdPlates[ipl].Presssectionnumber :=
        DataM1.Query1.fieldbyname('Presssectionnumber').asinteger;
      inittypes.markstrtoarray(DataM1.Query1.fieldbyname('Markgroups').asstring,
        plateframesdata[iplf].ProdPlates[ipl].markgroups,
        plateframesdata[iplf].ProdPlates[ipl].Nmarkgroups);

      plateframes[iplf].SequenceNumber := runnumbercounter;

      If plateframes[iplf].SequenceNumber <= 0 then
        plateframes[iplf].SequenceNumber := iplf;

      plateframesdata[iplf].ProdPlates[ipl].FlatProofConfigurationID :=
        DataM1.Query1.fieldbyname('FlatProofConfigurationID').asinteger;
      plateframesdata[iplf].ProdPlates[ipl].HardProofConfigurationID :=
        DataM1.Query1.fieldbyname('HardProofConfigurationID').asinteger;

      ip := DataM1.Query1.fieldbyname('pairpos').asinteger;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totapproval := prodplannedapproval - 1;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Anyheld := false;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totUniquePage :=
        DataM1.Query1.fieldbyname('UniquePage').asinteger;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype :=
        DataM1.Query1.fieldbyname('pagetype').asinteger;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Creep :=
        DataM1.Query1.fieldbyname('Creep').AsFloat;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].sectionid :=
        DataM1.Query1.fieldbyname('SectionID').asinteger;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].MasterCopySeparationSet :=
        DataM1.Query1.fieldbyname('MasterCopySeparationSet').asinteger;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagestatus := 0;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].proofed := false;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].approved := prodplannedapproval - 1;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Orgeditionid :=
        DataM1.Query1.fieldbyname('OrgEditionID').asinteger;
      IF Formloadstbplan.UsingProddata then
      begin
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Orgeditionid :=
          tnames1.editionnametoid(Formeditionorder.listbox1.items[ied - 1]);
      end;

      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename :=
        DataM1.Query1.fieldbyname('pagename').asstring;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagina :=
        DataM1.Query1.fieldbyname('Pagina').asinteger;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Pageindex :=
        DataM1.Query1.fieldbyname('Pageindex').asinteger;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].orgpageindex :=
        DataM1.Query1.fieldbyname('Pageindex').asinteger;

      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagechange := false;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].proofid :=
        DataM1.Query1.fieldbyname('Proofid').asinteger;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].CopySeparationSet := 0;

      If (not PDFPlan) and (Formprodplan.ApplyingToPDF) then
      begin
        ic := 1;
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].ColorID := tnames1.PDFCOLORID
      end
      else
      begin
        ic := DataM1.Query1.fieldbyname('platenumber').asinteger;
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].ColorID := DataM1.Query1.fieldbyname('color').asinteger;
      end;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Copynumber := 1;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Uniquepage := DataM1.Query1.fieldbyname('Uniquepage').asinteger;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].active :=  DataM1.Query1.fieldbyname('IssueID').asinteger;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].status := 0;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].proofstatus := 0;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].approved :=  prodplannedapproval - 1;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Priority := Formloadstbplan.UpDown1.Position;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Hold := prodplannedhold;

      IF Formloadstbplan.ComboBoxstackpos.Text = 'Planned' then
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].stackpos :=
          SetPlanIDFromname(2, DataM1.Query1.fieldbyname('stackpos').asstring)
      Else
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].stackpos :=
          SetPlanIDFromname(2, Formloadstbplan.ComboBoxstackpos.Text);

      plateframesdata[iplf].ProdPlates[ipl].Tower :=
        SetplanTowername(DataM1.Query1.fieldbyname('TowerID').asstring);

      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].High :=
        SetPlanIDFromname(3, DataM1.Query1.fieldbyname('High').asstring);

      IF (DataM1.Query1.fieldbyname('CylinderID').asstring = fronbackstr[0]) OR
        (DataM1.Query1.fieldbyname('CylinderID').asstring = fronbackstr[1]) then
      begin
        IF (DataM1.Query1.fieldbyname('CylinderID').asstring = fronbackstr[0])
        then
          plateframesdata[iplf].ProdPlates[ipl].TrueFront := 2
        Else
          plateframesdata[iplf].ProdPlates[ipl].TrueFront := 3;
      end
      else
        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Cylinder :=
          SetPlanIDFromname(4, DataM1.Query1.fieldbyname('CylinderID')
          .asstring);

      plateframesdata[iplf].ProdPlates[ipl].Zone :=
        SetPlanIDFromname(5, DataM1.Query1.fieldbyname('ZoneID').asstring);
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors := ic;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Miscint1 :=
        DataM1.Query1.fieldbyname('Miscint1').asinteger;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Miscint2 :=
        DataM1.Query1.fieldbyname('Miscint2').asinteger;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Miscint3 :=
        DataM1.Query1.fieldbyname('Miscint3').asinteger;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Miscint4 :=
        DataM1.Query1.fieldbyname('Miscint4').asinteger;
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Miscstring1 :=
        SetPlanIDFromname(6, DataM1.Query1.fieldbyname('Miscstring1').asstring);
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Miscstring2 :=
        SetPlanIDFromname(7, DataM1.Query1.fieldbyname('Miscstring2').asstring);
      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Miscstring3 :=
        SetPlanIDFromname(8, DataM1.Query1.fieldbyname('Miscstring3').asstring);
      DataM1.Query1.next;
    end;
    DataM1.Query1.close;

    IF (Ncopies > 1) And (ipl > -1) then
    begin
      For icopy := 2 to Ncopies do
      begin
        Inc(ipl);
        plateframesdata[iplf].ProdPlates[ipl] := plateframesdata[iplf].ProdPlates[ipl - 1];
        plateframesdata[iplf].ProdPlates[ipl].Copynumber := icopy;
        plateframesdata[iplf].ProdPlates[ipl].FlatSeparationSet := (100 * plateframesdata[iplf].ProdPlates[ipl].CopyFlatSeparationSet) + icopy;
        for ip := 1 to PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
        Begin
          plateframesdata[iplf].ProdPlates[ipl].Pages[ip].SeparationSet :=
            (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].CopySeparationSet * 100) + icopy;
          For ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors do
          begin
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Copynumber := icopy;
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].FlatSeparation :=
              (plateframesdata[iplf].ProdPlates[ipl].FlatSeparationSet * 100) + plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].ColorID;
            plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].Separation :=
              (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].SeparationSet * 100) + plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].ColorID;
          end;
        end;
      End;
      addbycopy := true;

    end;

    Nplateframes := iplf;
  End;
  IF iplf > -1 then
    plateframes[iplf].NProdPlates := ipl;

  IF Formloadstbplan.UsingProddata then
  begin
    For iplf := 1 to Nplateframes do
    begin
      DataM1.Query1.sql.clear;
      // 0                          1            2           3              4           5          6
      DataM1.Query1.sql.add('Select distinct p1.mastercopyseparationset,p1.editionid,p1.pagename,p1.sectionid,p1.uniquepage,p2.editionid,p2.copyseparationset from pagetable p1  WITH (NOLOCK) , pagetable p2  WITH (NOLOCK) ');
      DataM1.Query1.sql.add('Where (p1.uniquepage <> 1 and p2.mastercopyseparationset = p1.mastercopyseparationset and p2.editionid <> p1.editionid)');
      DataM1.Query1.sql.add('and p1.editionid = ' + inttostr(plateframesdata[iplf].ProdPlates[0].editionid));
      DataM1.Query1.sql.add('and (p1.publicationid = ' + inttostr(plateframespublicationid));
      DataM1.Query1.sql.add(' and ' + DataM1.makedatastr('p1.',plateframesPubdate));
      DataM1.Query1.sql.add(')');

      if Prefs.debug then
        DataM1.Query1.sql.SaveToFile
          (IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'
          + 'Findprodorged.sql');
      formmain.Tryopen(DataM1.Query1);
      while not DataM1.Query1.eof do
      begin
        IF DataM1.Query1.fields[5].asinteger <> plateframesdata[iplf].ProdPlates
          [0].editionid then
        begin
          For ipl := 0 to plateframes[iplf].NProdPlates do
          begin
            for ip := 1 to PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate do
            begin
              if (DataM1.Query1.fields[3].asinteger = plateframesdata[iplf].ProdPlates[ipl].Pages[ip].sectionid) and
                (DataM1.Query1.fields[2].asstring = plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename) then
              begin
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Orgeditionid :=
                  DataM1.Query1.fields[5].asinteger;
                plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totUniquePage := 0;
              end;
            End;
          End;
        End;
        DataM1.Query1.next;
      End;
      DataM1.Query1.close

    end;
  End;

  applypublicationdataafterloadafplan;
  copyplantoplanpages;
  pressruncaptionnames;

  setdinkydata(1);
end;

function TFormprodplan.GenerateRipSetupID(publicationid: Integer;Pressid: Integer): Integer;
var
  T, Defrip, Defpreflight, DefInksave: String;
  I: Integer;
begin
  result := 0;

  DataM1.Query3.sql.clear;
  DataM1.Query3.sql.add('SELECT TOP 1 RipSetup FROM PublicationTemplates');
  DataM1.Query3.sql.add('WHERE Publicationid = ' + inttostr(publicationid));
  DataM1.Query3.sql.add('AND PressID = ' + inttostr(Pressid));

  DataM1.Query3.open;
  if not DataM1.Query3.eof then
    T := DataM1.Query3.fields[0].asstring;
  DataM1.Query3.close;

  Defrip := '';
  Defpreflight := '';
  DefInksave := '';

  IF length(T) > 0 then
  begin
    Defrip := copy(T, 1, POS(';', T) - 1);
    delete(T, 1, POS(';', T));

    Defpreflight := copy(T, 1, POS(';', T) - 1);
    delete(T, 1, POS(';', T));

    DefInksave := copy(T, 1, 100);
  end;

  I := 0;
  if (Defrip <> '') then
  begin
    DataM1.Query3.sql.clear;
    DataM1.Query3.sql.add('SELECT TOP 1 RipSetupID FROM RipSetupNames');
    DataM1.Query3.sql.add('WHERE Name = ' + QuotedStr(Defrip));
    DataM1.Query3.open;
    IF not DataM1.Query3.eof then
      I := DataM1.Query3.fields[0].asinteger;
    DataM1.Query3.close;
  end;

  if (Defpreflight <> '') and (PreflightSetupNamesPossible) then
  begin
    DataM1.Query3.sql.clear;
    DataM1.Query3.sql.add('SELECT TOP 1 PreflightSetupID FROM PreflightSetupNames');
    DataM1.Query3.sql.add('WHERE Name = ' + QuotedStr(Defpreflight));
    DataM1.Query3.open;
    IF not DataM1.Query3.eof then
      I := I + (256 * (DataM1.Query3.fields[0].asinteger));
    DataM1.Query3.close;
  end;

  if (DefInksave <> '') and (UTypes.InkSaveSetupNamesPossible) then
  begin
    DataM1.Query3.sql.clear;
    DataM1.Query3.sql.add('SELECT TOP 1 InksaveSetupID FROM InksaveSetupNames');
    DataM1.Query3.sql.add('WHERE Name = ' + QuotedStr(DefInksave));
    DataM1.Query3.open;
    IF not DataM1.Query3.eof THEN
      I := I + (256 * 256 * (DataM1.Query3.fields[0].asinteger));
    DataM1.Query3.close;
  end;

  result := I;

end;

procedure TFormprodplan.ActionSetRipSetupExecute(Sender: TObject);
// Var
// T : String;
// found : boolean;
// itow,
// I,
// Iplf,seliplf : Integer;
// ,iplt,impl,ipl,ip,ic,icp,ivc

// l : tlistitem;

// Pressname : string;
// NAutotows : Integer;
// Autotows : Array[1..100] of string;
begin

  (*
    seliplf := -1;
    For Iplf := 1 to Nplateframes do
    begin
    if plateframes[iplf].Selected then
    begin
    seliplf := iplf;
    End;
    End;


    IF FormReprocessSimple.ShowModal = mrok then
    begin
    For Iplf := 1 to Nplateframes do
    begin
    For impl := 0 to plateframes[iplf].PBExListview1.Items.Count-1 do
    begin
    IF plateframes[iplf].PBExListview1.Items[impl].Selected then
    begin
    iplt := ImagenumbertoIPL(Iplf,impl);

    For icp := 0 to plateframes[iplf].Numberofcopies-1 do
    begin
    ipl := icp+iplt;
    plateframesdata[iplf].prodplates[ipl].pages[1].
    plateframesdata[iplf].[ipl]. := 2 + FormWebnaming.ComboBox1.ItemIndex;
    End;
    End;
    End;
    End;
    plateviewimage.Width := 23;    //204
    plateviewimage.height := 51;   //176
    For i := 1 to Nplateframes do
    begin
    plateframes[i].PBExListview1.clear;
    plateframes[i].ImageListplanframe.Clear;
    drawtheplates(CheckBoxsmallimagesinEdit.Checked,i);
    end;
    end;
  *)
end;

function TFormprodplan.GetPlatePageData(plateFrameNo: Integer;
  pageNameToFind: string; sectionIdToFind: Integer; editionIdToFind: Integer)
  : Tprodpage;
var
  ipl, ip, Nup: Integer;
begin
  (* result := nil; *)
  for ipl := 0 to plateframes[plateFrameNo].NProdPlates do
  begin
    Nup := PlatetemplateArray[plateframesdata[plateFrameNo].ProdPlates[ipl].templatelistid].NupOnplate;
    for ip := 1 to Nup do
    begin
      if (plateframesdata[plateFrameNo].ProdPlates[ipl].Pages[ip].pagename = pageNameToFind) and
        (plateframesdata[plateFrameNo].ProdPlates[ipl].Pages[ip].sectionid = sectionIdToFind) and
        (plateframesdata[plateFrameNo].ProdPlates[ipl].Pages[ip].Orgeditionid = editionIdToFind) then
      begin
        result := plateframesdata[plateFrameNo].ProdPlates[ipl].Pages[ip];
        exit;
      end;
    end;

  end;

end;

function TFormprodplan.PageNameToInt(pagename: string): Integer;

begin

  try
    result := StrToInt(pagename);
  Except
    result := 0;
  end;
end;

procedure TFormprodplan.ActionPlanEditPagenumbersExecute(Sender: TObject);

Var
  iplf, ipl, ip, ic, iplx: Integer;
  Nup: Integer;
  Numberofcopies: Integer;
  Orgeditionid: Integer;
  editionid: Integer;
  sectionid: Integer;
  PageDataBuf: Tprodpage;
  DinkeyPages: TStringList;
begin
  DinkeyPages := TStringList.Create;
  sectionid := 1;
  Orgeditionid := 1;
  for iplf := 1 to Nplateframes do
  begin

    if plateframes[iplf].Selected then
    begin

      // Register dinkeynames
      for ipl := 0 to plateframes[iplf].NProdPlates do
      begin
        Nup := PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate;
        for ip := 1 to Nup do
        begin
          if (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype = 3) then
            DinkeyPages.add(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename);
        end;
      end;

      Numberofcopies := plateframes[iplf].Numberofcopies;

      for ipl := 0 to plateframes[iplf].NProdPlates do
      begin
        iplx := ipl div Numberofcopies;
        if plateframes[iplf].PBExListview1.items[iplx].Selected then
        begin
          Nup := PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate;

          case Nup of
            2:
              begin

                for ip := 1 to Nup do
                begin
                  if plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype <> 3
                  then
                  begin
                    Orgeditionid := plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Orgeditionid;
                    sectionid := plateframesdata[iplf].ProdPlates[ipl].Pages[ip].sectionid;
                    FormEdit2upPlate.Pages[ip] :=
                      PageNameToInt(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename)
                  end
                  else
                    FormEdit2upPlate.Pages[ip] := 0;
                end;

                if (FormEdit2upPlate.ShowModal = mrok) then
                begin
                  for ip := 1 to Nup do
                  begin
                    if (FormEdit2upPlate.Pages[ip] = 0) then
                    begin
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype := 3;
                      for ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors do
                        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].active := 0;
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors := 1;
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[1].ColorID := tnames1.Colornametoid('Dinky');
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[1].active := 1;
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename  := 'Dinkey' + inttostr((iplf * 100 + ip));
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagina := 0;
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Pageindex := 0;
                    end
                    else
                    begin
                      (* PageDataBuf := GetPlatePageData(iplf, IntToStr(FormEdit2upPlate.Pages[ip]), Sectionid, OrgeditionID);
                        if (PageDataBuf <> nil) then
                        plateframesdata[iplf].prodplates[ipl].Pages[ip] := PageDataBuf
                        else
                        begin *)
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename := inttostr(FormEdit2upPlate.Pages[ip]);
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Pageindex := FormEdit2upPlate.Pages[ip];
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagina := FormEdit2upPlate.Pages[ip];
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype := 0;
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors := 4;
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Orgeditionid := Orgeditionid;
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].sectionid := sectionid;
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totUniquePage := 1;
                      // hardcoded to CMYK for now...
                      for ic := 1 to 4 do
                      begin
                        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].active := 1;
                        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].ColorID := ic;
                      end;
                      // end;
                    end;
                  end;
                  setothercopies(iplf, ipl);

                end;
              end;
            4:
              begin
                for ip := 1 to Nup do
                begin
                  if plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype <> 3
                  then
                  begin
                    Orgeditionid := plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Orgeditionid;
                    sectionid := plateframesdata[iplf].ProdPlates[ipl].Pages[ip].sectionid;
                    FormEdit4upPlate.Pages[ip] :=
                      PageNameToInt(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename)
                  end
                  else
                    FormEdit4upPlate.Pages[ip] := 0;
                end;
                if (FormEdit4upPlate.ShowModal = mrok) then
                begin
                  for ip := 1 to Nup do
                  begin
                    if (FormEdit4upPlate.Pages[ip] = 0) then
                    begin
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype := 3;
                      for ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors do
                        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].active := 0;
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors := 1;
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[1].ColorID := tnames1.Colornametoid('Dinky');
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[1].active := 1;
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename
                        := 'Dinkey' + inttostr((iplf * 100 + ip));
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagina := 0;
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Pageindex := 0;
                    end
                    else
                    begin
                      (* PageDataBuf := GetPlatePageData(iplf, IntToStr(FormEdit4upPlate.Pages[ip]), Sectionid, OrgeditionID);
                        if (PageDataBuf <> nil) then
                        plateframesdata[iplf].prodplates[ipl].Pages[ip] := PageDataBuf
                        else
                        begin *)
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename := inttostr(FormEdit4upPlate.Pages[ip]);
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Pageindex := FormEdit4upPlate.Pages[ip];
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagina :=FormEdit4upPlate.Pages[ip];
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype := 0;
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors := 4;
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Orgeditionid := Orgeditionid;
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].sectionid := sectionid;
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totUniquePage := 1;
                      // hardcoded to CMYK for now...
                      for ic := 1 to 4 do
                      begin
                        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].active := 1;
                        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].ColorID := ic;
                      end;
                      // end;
                    end;

                  end;
                  setothercopies(iplf, ipl);
                end;
              end;

            8:
              begin
                for ip := 1 to Nup do
                begin
                  if plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype <> 3
                  then
                  begin
                    Orgeditionid := plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Orgeditionid;
                    sectionid := plateframesdata[iplf].ProdPlates[ipl].Pages[ip].sectionid;
                    FormEdit8upPlate.Pages[ip] :=
                      PageNameToInt(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename)
                  end
                  else
                    FormEdit8upPlate.Pages[ip] := 0;
                end;
                if (FormEdit8upPlate.ShowModal = mrok) then
                begin
                  for ip := 1 to Nup do
                  begin
                    if (FormEdit8upPlate.Pages[ip] = 0) then
                    begin
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype := 3;
                      for ic := 1 to plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors do
                        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].active := 0;
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Ncolors := 1;
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[1].ColorID := tnames1.Colornametoid('Dinky');
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[1].active := 1;
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename := 'Dinkey' + inttostr((iplf * 100 + ip));
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagina := 0;
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Pageindex := 0;
                    end
                    else
                    begin
                      (* PageDataBuf := GetPlatePageData(iplf, IntToStr(FormEdit8upPlate.Pages[ip]), Sectionid, OrgeditionID);
                        if (PageDataBuf <> nil) then
                        plateframesdata[iplf].prodplates[ipl].Pages[ip] := PageDataBuf
                        else
                        begin *)
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename
                        := inttostr(FormEdit8upPlate.Pages[ip]);
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].Pageindex
                        := FormEdit8upPlate.Pages[ip];
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagina :=
                        FormEdit8upPlate.Pages[ip];
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                        .pagetype := 0;
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                        .Ncolors := 4;
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip]
                        .Orgeditionid := Orgeditionid;
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].sectionid
                        := sectionid;
                      plateframesdata[iplf].ProdPlates[ipl].Pages[ip].totUniquePage := 1;
                      // hardcoded to CMYK for now...
                      for ic := 1 to 4 do
                      begin
                        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].active := 1;
                        plateframesdata[iplf].ProdPlates[ipl].Pages[ip].colors[ic].ColorID := ic;
                      end;
                      // end;

                    end;

                  end;
                  setothercopies(iplf, ipl);
                end;
              end;

          end; // end case

          DrawThePlates(CheckBoxsmallimagesinEdit.checked, iplf);
          exit;
        end; // .. .Selected

      End;
    end;
  End;
  DinkeyPages.Free;
end;

procedure TFormprodplan.ActionPlanningRearrangePagesExecute(Sender: TObject);
var
  iplf, ipl, Nup, ip, I: Integer;
  Pages: TStringList;
  newPageName, S, s2: String;
  sectionid: Integer;
  found: Boolean;
begin
  Pages := TStringList.Create();

  // Register pages
  for iplf := 1 to Nplateframes do
  begin
    if plateframes[iplf].Selected then
    begin
      for ipl := 0 to plateframes[iplf].NProdPlates do
      begin
        Nup := PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl]
          .templatelistid].NupOnplate;
        for ip := 1 to Nup do
        begin
          if (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype <> 3)
          then
          begin
            S := tnames1.sectionIDtoname(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].sectionid);

            Pages.add(S + ' ' + copy('0' + plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename, length('0' + plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename) - (2 - 1), 2));
          end;
        end;
      end;
    end;
  end;
  Pages.Sort();

  PlanRearrangePages.numberOfPages := Pages.count;
  for I := 0 to Pages.count - 1 do
    PlanRearrangePages.Pages[I] := Pages[I];

  PlanRearrangePages.InitListBoxes;
  if (PlanRearrangePages.ShowModal = mrok) then
  begin
    for I := 0 to Pages.count - 1 do
    begin
      // if (PlanRearrangePages.Pages[i] <>  Pages[i]) then
      // begin
      sectionid := tnames1.sectionnametoid(copy(PlanRearrangePages.Pages[I], 1, 1));
      newPageName := copy(PlanRearrangePages.Pages[I], 3, length(PlanRearrangePages.Pages[I]) - 2);

      newPageName := inttostr(StrToInt(newPageName)); // remove leading zero(s)

      found := false;

      for iplf := 1 to Nplateframes do
      begin
        if plateframes[iplf].Selected then
        begin
          for ipl := 0 to plateframes[iplf].NProdPlates do
          begin
            Nup := PlatetemplateArray[plateframesdata[iplf].ProdPlates[ipl].templatelistid].NupOnplate;
            for ip := 1 to Nup do
            begin
              if (plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagetype <> 3)
              then
              begin
                s2 := tnames1.sectionIDtoname(plateframesdata[iplf].ProdPlates[ipl].Pages[ip].sectionid);
                s2 := s2 + ' ' + copy('0' + plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename,
                  length('0' + plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename) - (2 - 1), 2);

                if (Pages[I] = s2) then
                begin
                  plateframesdata[iplf].ProdPlates[ipl].Pages[ip].pagename := newPageName;
                  plateframesdata[iplf].ProdPlates[ipl].Pages[ip].sectionid := sectionid;
                  found := true;
                  break;
                end;

              end;
            end;
            if (found) then
              break;
          end;
          if (found) then
            break;
        end;

      end;

      // end;

    end;
    for iplf := 1 to Nplateframes do
      DrawThePlates(CheckBoxsmallimagesinEdit.checked, iplf);
  end;

  Pages.Free();
end;

procedure TFormprodplan.ActionMoveSheetBackwardExecute(Sender: TObject);
var
  iplf: Integer;
  selectedframe: Integer;
  currentsheetnumber: Integer;
begin

  currentsheetnumber := -1;
  selectedframe := 1;

  for iplf := 1 to Nplateframes do
  begin
    if plateframes[iplf].Selected then
    begin
      selectedframe := iplf;
      break;
    end;
  end;

  currentsheetnumber := GetSelectedSheetNumber(selectedframe);

  if currentsheetnumber > 0 then
  begin
    ChangeSheetNumber(selectedframe, currentsheetnumber - 1, 1000);
    ChangeSheetNumber(selectedframe, currentsheetnumber,
      currentsheetnumber - 1);
    ChangeSheetNumber(selectedframe, 1000, currentsheetnumber);

    for iplf := 1 to Nplateframes do
      DrawThePlates(CheckBoxsmallimagesinEdit.checked, iplf);
  end;

end;

procedure TFormprodplan.ActionMoveSheetForwardExecute(Sender: TObject);
var
  iplf: Integer;
  selectedframe: Integer;
  currentsheetnumber: Integer;
begin

  currentsheetnumber := -1;
  selectedframe := 1;

  for iplf := 1 to Nplateframes do
  begin
    if plateframes[iplf].Selected then
    begin
      selectedframe := iplf;
      break;
    end;
  end;

  currentsheetnumber := GetSelectedSheetNumber(selectedframe);

  if currentsheetnumber > 0 then
  begin
    ChangeSheetNumber(selectedframe, currentsheetnumber + 1, 1000);
    ChangeSheetNumber(selectedframe, currentsheetnumber,
      currentsheetnumber + 1);
    ChangeSheetNumber(selectedframe, 1000, currentsheetnumber);

    for iplf := 1 to Nplateframes do
      DrawThePlates(CheckBoxsmallimagesinEdit.checked, iplf);
  end;

end;

function TFormprodplan.GetSelectedSheetNumber(PlateFrameIndex: Integer)
  : Integer;
var
  iplf, impl, iplt, icp, ipl: Integer;
  selectedframe: Integer;
  currentsheetnumber: Integer;
begin
  currentsheetnumber := 0;
  iplf := PlateFrameIndex;
  For impl := 0 to plateframes[iplf].PBExListview1.items.count - 1 do
  begin
    IF plateframes[iplf].PBExListview1.items[impl].Selected then
    begin
      iplt := ImagenumbertoIPL(iplf, impl);
      For icp := 0 to plateframes[iplf].Numberofcopies - 1 do
      begin
        ipl := icp + iplt;
        currentsheetnumber := plateframesdata[iplf].ProdPlates[ipl].sheetnumber;
        break;
      End;
    End;
    if currentsheetnumber > 0 then
      break;
  End;

  result := currentsheetnumber;
end;

procedure TFormprodplan.ChangeSheetNumber(PlateFrameIndex: Integer;
  SheetNumberFrom: Integer; SheetNumberTo: Integer);
var
  iplf, impl, iplt, icp, ipl: Integer;
  currentsheetnumber: Integer;
begin
  currentsheetnumber := -1;

  iplf := PlateFrameIndex;
  for impl := 0 to plateframes[iplf].PBExListview1.items.count - 1 do
  begin

    iplt := ImagenumbertoIPL(iplf, impl);
    for icp := 0 to plateframes[iplf].Numberofcopies - 1 do
    begin
      ipl := icp + iplt;
      currentsheetnumber := plateframesdata[iplf].ProdPlates[ipl].sheetnumber;
      if (currentsheetnumber = SheetNumberFrom) then
        plateframesdata[iplf].ProdPlates[ipl].sheetnumber := SheetNumberTo;
    end;
  end;
end;


procedure TFormProdPlan.GeneratePlanPageNames(ProductionID: Integer);

var
   PressRunIdList:  array of Integer;
    i : Integer;
begin

    if (spPlanCenterGeneratePlanPageNamesPossible = false) then
    begin
      FormMain.Writeinitlog('Store proc spPlanCenterGeneratePlanPageNamesPossible does not exist');
      exit;
    end;


  // PlanPageName:
    SetLength(PressRunIdList,1);

    DataM1.Query1.Sql.Clear;
    DataM1.Query1.Sql.Add('SELECT DISTINCT PressRunID FROM PageTable WITH (NOLOCK)');
    DataM1.Query1.Sql.Add('WHERE ProductionID = ' + IntToStr(ProductionID));
    DataM1.Query1.Open;
    i := 0;
    while not DataM1.Query1.Eof do
    Begin
      SetLength(PressRunIdList,i + 1);
      PressRunIdList[i] := DataM1.Query1.fields[0].AsInteger;
      Inc(i);
      DataM1.Query1.Next;
    end;
    DataM1.Query1.Close;

    for i := 0 to Length(PressRunIdList)-1 do
    begin
      DataM1.Query1.Sql.Clear;
      DataM1.Query1.Sql.Add('exec spPlanCenterGeneratePlanPageNames ');
      DataM1.Query1.Sql.Add('@PressRunID  = ' + IntToStr(PressRunIdList[i]));
      FormMain.TrySql(DataM1.Query1);
      DataM1.Query1.Close;
    end;


    SetLength(PressRunIdList,0);


end;

end.
