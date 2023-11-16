Unit Usettings;

interface

uses
  ActnList,Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Math,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, CheckLst,
  XPStyleActnCtrls, ActnMan, inifiles,Grids, Mask, Menus, ValEdit, UITypes, UImages;

type
  TFormSettings = class(TForm)
    PageControl1: TPageControl;
    Panel1: TPanel;
    TabSheetmonoshit: TTabSheet;
    CheckBox1: TCheckBox;
    TabSheet3: TTabSheet;
    GroupBox6: TGroupBox;
    Label3: TLabel;
    Label7: TLabel;
    ScrollBox1: TScrollBox;
    Panel2: TPanel;
    Edit1: TEdit;
    UpDown1: TUpDown;
    Edit2: TEdit;
    UpDown2: TUpDown;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet10: TTabSheet;
    TabSheet11: TTabSheet;

    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panela: TPanel;
    Image1: TImage;
    Labeldialogcaption1: TLabel;
    Labeldialogcaption2: TLabel;
    OpenDialog1: TOpenDialog;
    PopupMenuStack: TPopupMenu;
    Add1: TMenuItem;
    Delete1: TMenuItem;
    PopupMenuCyl: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    PopupMenuZone: TPopupMenu;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    PopupMenuTower: TPopupMenu;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    PopupMenufileserver: TPopupMenu;
    Add2: TMenuItem;
    PopupMenudefmarks: TPopupMenu;
    Add3: TMenuItem;
    Delete2: TMenuItem;
    Loadall1: TMenuItem;
    PopupMenufilters: TPopupMenu;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    OpenDialogsoundX: TOpenDialog;
    TabSheet19: TTabSheet;
    FontDialog1: TFontDialog;
    Image4: TImage;
    PopupMenulocserv: TPopupMenu;
    Add4: TMenuItem;
    Edit4: TMenuItem;
    Delete3: TMenuItem;
    PopupMenulogsys: TPopupMenu;
    Clearall1: TMenuItem;
    Setall1: TMenuItem;
    PopupMenuthumbcapnewline: TPopupMenu;
    NewlineInthumb1: TMenuItem;
    Spacethumbcapline: TMenuItem;
    PopupMenutowfilt: TPopupMenu;
    Add5: TMenuItem;
    Delete4: TMenuItem;
    Panel5: TPanel;
    GroupBox124: TGroupBox;
    ComboBoxlanguage: TComboBox;
    RadioGroupstartupsize: TRadioGroup;
    GroupBox116: TGroupBox;
    ComboBoxStartupTab: TComboBox;
    Panel6: TPanel;
    GroupBox57: TGroupBox;
    CheckBoxautologin: TCheckBox;
    CheckBoxNologin: TCheckBox;
    CheckBoxsuperall: TCheckBox;
    CheckBoxadmintab: TCheckBox;
    Panel9: TPanel;
    Panel11: TPanel;
    GroupBox122: TGroupBox;
    CheckBoxlistredevatreim: TCheckBox;
    Checkboxreleaseonseprationset: TCheckBox;
    CheckBoxshowreimgediaglog: TCheckBox;
    CheckBoxautoreimondevch: TCheckBox;
    GroupBox123: TGroupBox;
    UpDown7: TUpDown;
    GroupBox128: TGroupBox;
    Editminpagetreelevel: TEdit;
    Editvisiblecols: TEdit;
    UpDownVisiblecols: TUpDown;
    GroupBox129: TGroupBox;
    EditNcols: TEdit;
    UpDown12: TUpDown;
    GroupBox130: TGroupBox;
    EditAutoscroolspeed: TEdit;
    UpDownAutoscroolspeed: TUpDown;
    GroupBox35: TGroupBox;
    Label51: TLabel;
    CheckBoxlocaltimeset: TCheckBox;
    Editlistime: TEdit;
    Panel12: TPanel;
    Panel13: TPanel;
    RadioGroupthumbnailsize: TRadioGroup;
    CheckBoxreselectthumb: TCheckBox;
    Panel14: TPanel;
    GroupBox92: TGroupBox;
    CheckListBoxthumbtext: TCheckListBox;
    GroupBox93: TGroupBox;
    ListBoxthumborder: TListBox;
    Panel15: TPanel;
    GroupBox66: TGroupBox;
    CheckListBoxThumbevents: TCheckListBox;
    MemoShortevent: TMemo;
    GroupBox90: TGroupBox;
    CheckListBoxthgroupecap: TCheckListBox;
    GroupBox95: TGroupBox;
    CheckListBoxthumbstatbar: TCheckListBox;
    Panel16: TPanel;
    Label48: TLabel;
    CheckBoxthumbshowhold: TCheckBox;
    CheckBoxthumbpagechangesonsubeditions: TCheckBox;
    CheckBoxthumbshowextstat: TCheckBox;
    CheckBoxCheckJpgTag: TCheckBox;
    CheckBoxthumbshowmono: TCheckBox;
    CheckBoxpagedelete: TCheckBox;
    CheckBoxforcereadorder: TCheckBox;
    Panel19: TPanel;
    GroupBox100: TGroupBox;
    CheckBoxpresstimeinplatetree: TCheckBox;
    RadioGroupplatetreeexp: TRadioGroup;
    GroupBox80: TGroupBox;
    Label53: TLabel;
    EditPlateminlevel: TEdit;
    UpDown11: TUpDown;
    GroupBox82: TGroupBox;
    CheckBoxreimdevicereset: TCheckBox;
    CheckBoxplatedetailof: TCheckBox;
    CheckBoxdefaultshowplatedetails: TCheckBox;
    CheckBoxreimcolors: TCheckBox;
    CheckBox2nounplanned: TCheckBox;
    CheckBoxreimcopies: TCheckBox;
    CheckBoxSelectAllCopiesOnRelease: TCheckBox;
    Panel22: TPanel;
    Panel23: TPanel;
    GroupBox118: TGroupBox;
    Editminprodtreelevel: TEdit;
    UpDown15: TUpDown;
    GroupBox74: TGroupBox;
    StringGridprods: TStringGrid;
    Panel24: TPanel;
    GroupBox120: TGroupBox;
    CheckListBox1: TCheckListBox;
    Panel25: TPanel;
    GroupBox119: TGroupBox;
    CheckBoxpublfilreonproddate: TCheckBox;
    CheckBoxprodreleaseholdallcopy: TCheckBox;
    CheckBoxSellallcopiesprod: TCheckBox;
    CheckBoxShowPressTime: TCheckBox;
    Panel26: TPanel;
    GroupBox121: TGroupBox;
    Label91: TLabel;
    Label121: TLabel;
    Edit6: TEdit;
    Edit7: TEdit;
    Panel27: TPanel;
    Panel28: TPanel;
    GroupBox28: TGroupBox;
    CheckBoxusepublicationdefaults: TCheckBox;
    CheckBoxerrorfileretry: TCheckBox;
    CheckBoxplanhold: TCheckBox;
    CheckBoxplanapproval: TCheckBox;
    CheckBoxCheckPlanningPageFormat: TCheckBox;
    GroupBox10: TGroupBox;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    ComboBoxcolorproof: TComboBox;
    ComboBoxBWproof: TComboBox;
    ComboBoxpdfproof: TComboBox;
    GroupBox111: TGroupBox;
    Label56: TLabel;
    Label61: TLabel;
    ComboBoxdefSoftprtype: TComboBox;
    ComboBoxdefHardprtype: TComboBox;
    CheckBoxdefsoftvait: TCheckBox;
    CheckBoxhardvait: TCheckBox;
    GroupBox27: TGroupBox;
    GroupBox29: TGroupBox;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Image2: TImage;
    Image3: TImage;
    RadioButtonwizard: TRadioButton;
    RadioButtonload: TRadioButton;
    CheckBoxonlyaplyonunapplied: TCheckBox;
    GroupBox112: TGroupBox;
    Label113: TLabel;
    Label114: TLabel;
    Label115: TLabel;
    CheckBoxuseimportcenter: TCheckBox;
    Editimportcenterinputpath: TEdit;
    Editimportcenterdonepath: TEdit;
    Editimportcentererrorpath: TEdit;
    CheckBoxplaninkaliasload: TCheckBox;
    GroupBox115: TGroupBox;
    Panel29: TPanel;
    Panel30: TPanel;
    Panel31: TPanel;
    Panel32: TPanel;
    GroupBox96: TGroupBox;
    CheckBoxpregendns: TCheckBox;
    CheckBoxpregenreadview: TCheckBox;
    CheckBoxPrevcomment: TCheckBox;
    CheckBoxgtoneedapr: TCheckBox;
    CheckBoxautomasked: TCheckBox;
    CheckBoxShowsidebar: TCheckBox;
    CheckBoxUseadobereader: TCheckBox;
    CheckBoxLeanAndMeanPreview: TCheckBox;
    CheckBoxShowSizeInformation: TCheckBox;
    CheckBoxShowInkDensityInformation: TCheckBox;
    CheckBoxEnsurePreviewFormInFront: TCheckBox;
    GroupBox97: TGroupBox;
    CheckBoxpageprevseps: TCheckBox;
    CheckBoxpageprevLevel: TCheckBox;
    CheckBoxShowInkZones: TCheckBox;
    GroupBoxPlateviewoptions: TGroupBox;
    CheckBoxplateprevseps: TCheckBox;
    CheckBoxplateprevLevel: TCheckBox;
    CheckBoxplateprevZones: TCheckBox;
    RadioGroup1: TRadioGroup;
    Panel34: TPanel;
    GroupBox50: TGroupBox;
    GroupBoxdefunknowfolder: TGroupBox;
    CheckListBoxdefunknown: TCheckListBox;
    CheckBoxignorenetuse: TCheckBox;
    CheckBoxnewdelsys: TCheckBox;
    CheckBoxdelonlyselon: TCheckBox;
    CheckboxNewCCFilesNames: TCheckBox;
    CheckBoxAllowDropFiles: TCheckBox;
    CheckBoxNewPreviewNames: TCheckBox;
    Label120: TLabel;
    EditDropFilesDestination: TEdit;
    CheckBoxAllowDropFilesDialog: TCheckBox;
    CheckBoxAllowDropFilesDeleteAfterCopy: TCheckBox;
    GroupBox51: TGroupBox;
    ListViewFilter: TListView;
    Editunknowndropdownfilter: TEdit;
    UpDowndropdownfilter: TUpDown;
    CheckBoxunknowncheck: TCheckBox;
    CheckBoxuknownsendlog: TCheckBox;
    Panel37: TPanel;
    GroupBox9: TGroupBox;
    Label15: TLabel;
    Editexternedittif: TEdit;
    GroupBox54: TGroupBox;
    Label60: TLabel;
    ComboBoxSepSEP: TComboBox;
    CheckBoxSEPHEader: TCheckBox;
    GroupBox47: TGroupBox;
    Label16: TLabel;
    CheckBoxShowpitstoplog: TCheckBox;
    EditexterneditPDF: TEdit;
    CheckBoxwebver: TCheckBox;
    RadioGroupShowpdfbook: TRadioGroup;
    Panel38: TPanel;
    RadioGroupHalfWeb: TRadioGroup;
    Panel108: TPanel;
    Label118: TLabel;
    Edit5: TEdit;
    Edit3: TEdit;
    Label119: TLabel;
    PageControl2: TPageControl;
    TabSheet26: TTabSheet;
    Panel43: TPanel;
    Panel41: TPanel;
    GroupBox88: TGroupBox;
    CheckBoxshowdevcontrol: TCheckBox;
    CheckBoxpressindevcontrol: TCheckBox;
    CheckBoxcontroldev: TCheckBox;
    CheckBoxDeviceControlOnlyAdmins: TCheckBox;
    GroupBox131: TGroupBox;
    CheckBoxpreparetrans: TCheckBox;
    CheckBoxautoflatproof: TCheckBox;
    CheckBoxpressspecifik: TCheckBox;
    CheckBoxpressgrpXXX: TCheckBox;
    CheckBoxDecreasever: TCheckBox;
    CheckBoxnewplatedata: TCheckBox;
    GroupBox40: TGroupBox;
    Label11: TLabel;
    EditAutorefresh: TEdit;
    UpDownautorefresh: TUpDown;
    TabSheet23: TTabSheet;
    Panel44: TPanel;
    Label49: TLabel;
    CheckBoxKeeptreeexpantion: TCheckBox;
    EditNewautoexpand: TEdit;
    UpDownnewautoexp: TUpDown;
    GroupBox8: TGroupBox;
    CheckListBoxextrafiltertext: TCheckListBox;
    GroupBox72: TGroupBox;
    CheckListBoxEditionText: TCheckListBox;
    GroupBox75: TGroupBox;
    CheckListBoxSectionText: TCheckListBox;
    CheckBoxSeparateNodesPerPressrun: TCheckBox;
    CheckBoxDefaultHidePagePlans: TCheckBox;
    CheckBoxDefaultThumbnailOnlyPagePlans: TCheckBox;
    Panel45: TPanel;
    CheckBoxtreedayname: TCheckBox;
    CheckBoxtreebyedid: TCheckBox;
    CheckBoxnewprodsign: TCheckBox;
    CheckBoxtreeonceimaged: TCheckBox;
    CheckBoxnotreelamps: TCheckBox;
    CheckboxTreeShowPrepollEvents: TCheckBox;
    CheckBoxIncludeImageOnceState: TCheckBox;
    CheckBoxTreeShowPagesReadyFlag: TCheckBox;
    RadioGroupTreeorder: TRadioGroup;
    RadioGroupdefdatesel: TRadioGroup;
    GroupBox117: TGroupBox;
    CheckBoxShowWeekNr: TCheckBox;
    CheckBoxAlwaysfullTreeExpand: TCheckBox;
    Panel47: TPanel;
    GroupBox114: TGroupBox;
    CheckListBoxvisibletowers: TCheckListBox;
    TabSheet25: TTabSheet;
    Panel49: TPanel;
    GroupBox78: TGroupBox;
    CheckBoxmustsetdev: TCheckBox;
    RadioGroupreleaserulebase: TRadioGroup;
    GroupBox79: TGroupBox;
    CheckListBoxreleaserules: TCheckListBox;
    TabSheet27: TTabSheet;
    Panel50: TPanel;
    GroupBox68: TGroupBox;
    Editdefaultsavepagelistfile: TEdit;
    BitBtn3: TBitBtn;
    CheckBoxpagename: TCheckBox;
    CheckBoxpageicons: TCheckBox;
    CheckBoxreselectpages: TCheckBox;

    CheckBoxpagefullautorefresh: TCheckBox;
    CheckBoxpagesshowall: TCheckBox;
    CheckBoxdefaultsetcomed: TCheckBox;
    Panel106: TPanel;
    TabSheet28: TTabSheet;
    Panel51: TPanel;
    GroupBox81: TGroupBox;
    Panel53: TPanel;
    Label50: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    CheckListBoxplatecaption: TCheckListBox;
    Editaltpagenamefield: TEdit;
    EditAltSheet: TEdit;
    CheckBoxplatefont: TCheckBox;
    CheckBoxShowtemplateincaption: TCheckBox;
    CheckBoxorderintopcap: TCheckBox;
    CheckBoxplateshowextstat: TCheckBox;
    CheckBoxplatehidecopy: TCheckBox;
    CheckBoxplatethumb: TCheckBox;
    Panel54: TPanel;
    Label25: TLabel;
    Label110: TLabel;
    CheckListBoxPlatetext: TCheckListBox;
    CheckListBoxpressruntexts: TCheckListBox;
    CheckBoxplatespecialstanding: TCheckBox;
    CheckBoxdataonplate: TCheckBox;
    CheckBoxhideprogthumb: TCheckBox;
    CheckBoxPlatenothumbrot: TCheckBox;
    CheckBoxplatepagepreview: TCheckBox;
    Panel52: TPanel;
    GroupBox83: TGroupBox;
    CheckBoxlayoutanaki: TCheckBox;
    CheckBoxplateshowripsystem: TCheckBox;
    CheckBoxreimhighpri: TCheckBox;
    CheckBoxreimage: TCheckBox;
    CheckBoxApplyPlateMerge: TCheckBox;
    Editreimextstat: TEdit;
    UpDownreimext: TUpDown;
    CheckBoxaddcopydialog: TCheckBox;
    CheckBoxplateReimondevch: TCheckBox;
    CheckBoxnewinkregen: TCheckBox;
    CheckBoxnewinkresend: TCheckBox;
    CheckboxClearDeviceOnLayoutChange: TCheckBox;
    CheckBoxKeepOutputVersionOnReimage: TCheckBox;
    CheckBoxUseFileCenterTiffArchive: TCheckBox;
    CheckBoxAllowInkfileRegenerate: TCheckBox;
    RadioGroupplatedonestat: TRadioGroup;
    TabSheet29: TTabSheet;
    Panel55: TPanel;
    RadioGroupdefaultpagetypeaddedition: TRadioGroup;
    RadioGroupdefaultDeviceaddedition: TRadioGroup;
    RadioGroupdefaultHoldaddedition: TRadioGroup;
    Panel56: TPanel;
    GroupBox43: TGroupBox;
    RadioGroupdefaultUniqePaddedition: TRadioGroup;
    RadioGroupdefaultCommonPaddedition: TRadioGroup;
    GroupBox77: TGroupBox;
    CheckBoxtimedEd: TCheckBox;
    RadioGrouptimedrules: TRadioGroup;
    GroupBox91: TGroupBox;
    CheckBoxuniqloconly: TCheckBox;
    CheckBoxOnlySecined: TCheckBox;
    CheckBoxforcewhencommon: TCheckBox;
    CheckBoxusealted: TCheckBox;
    CheckBoxeditionignorepress: TCheckBox;
    Panel57: TPanel;
    TabSheet16: TTabSheet;
    Panel58: TPanel;
    GroupBox25: TGroupBox;
    CheckBoxlogapprove: TCheckBox;
    CheckBoxlogdisapprove: TCheckBox;
    CheckBoxloghold: TCheckBox;
    CheckBoxlogrelease: TCheckBox;
    CheckBoxlogplanning: TCheckBox;
    CheckBoxlogdelete: TCheckBox;
    CheckBoxapprovetimeonrelease: TCheckBox;
    Panel59: TPanel;
    Label92: TLabel;
    Editminlogtree: TEdit;
    GroupBox85: TGroupBox;
    ListVieweventlogs: TListView;
    UpDown16: TUpDown;
    Panel60: TPanel;
    TabSheet2: TTabSheet;
    Panel61: TPanel;
    GroupBox39: TGroupBox;
    EditDeafaultreportfolder: TEdit;
    BitBtn6: TBitBtn;
    GroupBox38: TGroupBox;
    Label32: TLabel;
    Label52: TLabel;
    Label79: TLabel;
    CheckListBoxdetailsavecols: TCheckListBox;
    CheckBoxsavereportdetailcolumns: TCheckBox;
    ComboBoxreportdetailsave: TComboBox;
    Editreportdateform: TEdit;
    CheckBoxtextongrp: TCheckBox;
    Panel62: TPanel;
    GroupBox107: TGroupBox;
    GroupBox108: TGroupBox;
    CheckListBoxwarnstatus: TCheckListBox;
    GroupBox109: TGroupBox;
    CheckListBoxwarnext: TCheckListBox;
    CheckBoxwarnifanydisapproved: TCheckBox;
    TabSheet15: TTabSheet;
    Panel64: TPanel;
    GroupBox110: TGroupBox;
    Label26: TLabel;
    Label33: TLabel;
    Label88: TLabel;
    CheckBoxAllowunplannedcolors: TCheckBox;
    CheckBoxractivateonlyblack: TCheckBox;
    CheckBoxplatenames: TCheckBox;
    CheckBoxplatenamerecount: TCheckBox;
    CheckBoxApplyonlyplannedcolors: TCheckBox;
    Editdefaultfirsted: TEdit;
    EditDefsection: TEdit;
    Editminplatenamelength: TEdit;
    UpDown14: TUpDown;
    CheckBoxsecInpressruncom: TCheckBox;
    CheckBoxAutomultipress: TCheckBox;
    Panel65: TPanel;
    GroupBox37: TGroupBox;
    CheckBoxplannameintree: TCheckBox;
    CheckBoxExclusive: TCheckBox;
    CheckBoxruntrhoughpagina: TCheckBox;
    CheckBoxAutoplannumbergen: TCheckBox;
    CheckBoxinsertsheetnumbersfor1up: TCheckBox;
    CheckBoxnocommonplates: TCheckBox;
    CheckBoxsplit1upruns: TCheckBox;
    CheckBoxAlwaysUseOffset0OnApply: TCheckBox;
    GroupBox36: TGroupBox;
    Panel66: TPanel;
    CheckBoxallmarkgroups: TCheckBox;
    CheckBoxdefaultK: TCheckBox;
    CheckBoxdefaultPDF: TCheckBox;
    CheckBoxdefaultautomateplanname: TCheckBox;
    CheckBoxusepresstowerinfo: TCheckBox;
    Panel67: TPanel;
    CheckBoxDefplaninserted: TCheckBox;
    CheckBoxPlanpri: TCheckBox;
    CheckBoxplanexport: TCheckBox;
    CheckBoxautosetedonload: TCheckBox;
    GroupBox106: TGroupBox;
    CheckBoxenablespecifiksel: TCheckBox;
    CheckBoxplanclearsections: TCheckBox;
    CheckBoxdefnochangetmpl: TCheckBox;
    TabSheet30: TTabSheet;
    Panel68: TPanel;
    GroupBoxconsole: TGroupBox;
    Label103: TLabel;
    Label104: TLabel;
    CheckBoxautoconsole: TCheckBox;
    Editconsolename: TEdit;
    Editmaxconsoleage: TEdit;
    UpDowncosoletime: TUpDown;
    CheckBoxgraydns: TCheckBox;
    CheckBoxAllowparalelview: TCheckBox;
    Panel69: TPanel;
    GroupBox70: TGroupBox;
    Label29: TLabel;
    Label31: TLabel;
    LabelInklimit: TLabel;
    Editsidebarwidth: TEdit;
    EditsidebarHeight: TEdit;
    UpDown17: TUpDown;
    Editinklimit: TEdit;
    UpDowninklimit: TUpDown;
    CheckBoxseponreadview: TCheckBox;
    Panel70: TPanel;
    TabSheet31: TTabSheet;
    Panel71: TPanel;
    GroupBox5: TGroupBox;
    StringGridTowers: TStringGrid;
    GroupBox7: TGroupBox;
    ValueListEditortowerfilters: TValueListEditor;
    GroupBox2: TGroupBox;
    ListViewStacknames: TListView;
    CheckBoxOrstacks: TCheckBox;
    CheckBoxCustomtowerrnames: TCheckBox;
    CheckBoxUseDBtowernames: TCheckBox;
    CheckBoxtowerorderauto: TCheckBox;
    CheckBoxusetruesheetside: TCheckBox;
    Panel72: TPanel;
    Label81: TLabel;
    Label82: TLabel;
    GroupBox3: TGroupBox;
    ValueListEditorCyl: TValueListEditor;
    EditHighplate: TEdit;
    EditLowplate: TEdit;
    GroupBox4: TGroupBox;
    ListViewZonenames: TListView;
    Panel73: TPanel;
    GroupBox16: TGroupBox;
    ListViewdefmarks: TListView;
    GroupBox105: TGroupBox;
    ValueListEditorOldInk: TValueListEditor;
    CheckBoxinkpresspath: TCheckBox;
    GroupBox89: TGroupBox;
    ValueListEditormaxpagepress: TValueListEditor;
    TabSheet1: TTabSheet;
    Panel74: TPanel;
    GroupBox71: TGroupBox;
    Label62: TLabel;
    Label63: TLabel;
    CheckBoxgenrepwhendel: TCheckBox;
    ReportTimeOut: TEdit;
    UpDown13: TUpDown;
    ReportOnProductionDeleteEmail: TCheckBox;
    EmailUsePublicationSpecificMail: TCheckBox;
    Panel75: TPanel;
    ReportSaveFolder: TEdit;
    BitBtn4: TBitBtn;
    Panel76: TPanel;
    Label64: TLabel;
    Label86: TLabel;
    MailFrom: TEdit;
    MailCC: TEdit;
    Panel77: TPanel;
    Label85: TLabel;
    Label87: TLabel;
    MailTo: TEdit;
    MailSubject: TEdit;
    GroupBox64: TGroupBox;
    Label80: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label12: TLabel;
    EditCustomplanexportdest: TEdit;
    Editcustomdelcomdest: TEdit;
    EditCustomplanexportfilename: TEdit;
    Panel78: TPanel;
    GroupBox56: TGroupBox;
    Label10: TLabel;
    CheckListBoxexport: TCheckListBox;
    CheckBoxOnlyselection: TCheckBox;
    GroupBox73: TGroupBox;
    Label89: TLabel;
    Splitter1: TSplitter;
    CheckListBoxPLtPrntplate: TCheckListBox;
    CheckListBoxPLtPrnttitle: TCheckListBox;
    Panel4: TPanel;
    Button9: TButton;
    CheckBoxplateprtsecpage: TCheckBox;
    Panel79: TPanel;
    TabSheet32: TTabSheet;
    Panel80: TPanel;
    GroupBox17: TGroupBox;
    Label39: TLabel;
    Label37: TLabel;
    Editemailadress: TEdit;
    Editemailserver: TEdit;
    RadioGroupemailimageformat: TRadioGroup;
    GroupBox19: TGroupBox;
    Label40: TLabel;
    Editsendername: TEdit;
    CheckBoxemailasuser: TCheckBox;
    Panel81: TPanel;
    RadioGroupSendemail: TRadioGroup;
    GroupBox20: TGroupBox;
    Label41: TLabel;
    Editemailtitle: TEdit;
    GroupBox21: TGroupBox;
    Editemailpagename: TEdit;
    ListBox1: TListBox;
    Panel82: TPanel;
    TabSheet8: TTabSheet;
    StringGrid1: TStringGrid;
    Button6: TButton;
    Button7: TButton;
    TabSheet13: TTabSheet;
    Panel83: TPanel;
    GroupBox101: TGroupBox;
    Label27: TLabel;
    ComboBoxpressreqlevel: TComboBox;
    CheckBoxpressspecreq: TCheckBox;
    GroupBox99: TGroupBox;
    CheckBoxpecomImport: TCheckBox;
    Panel84: TPanel;
    GroupBox76: TGroupBox;
    ValueListEditorInkGen: TValueListEditor;
    ListBoxInpresettypes: TListBox;
    GroupBox103: TGroupBox;
    Label109: TLabel;
    EditPathtohoneywell: TEdit;
    BitBtn10: TBitBtn;
    CheckBoxUsehoneywell: TCheckBox;
    Panel87: TPanel;
    Panel85: TPanel;
    Label105: TLabel;
    EditHoneywellusername: TEdit;
    Panel86: TPanel;
    Label106: TLabel;
    EditHoneywellpassword: TEdit;
    Panel88: TPanel;
    TabSheet14: TTabSheet;
    Panel89: TPanel;
    GroupBox42: TGroupBox;
    ListViewplannamedstyles: TListView;
    Panel90: TPanel;
    GroupBox24: TGroupBox;
    ListBox3: TListBox;
    Panel91: TPanel;
    Label43: TLabel;
    Label44: TLabel;
    Label55: TLabel;
    Editstylename: TEdit;
    Editnameformat: TEdit;
    Editnamedateformat: TEdit;
    Panel92: TPanel;
    BitBtn7: TBitBtn;
    BitBtn9: TBitBtn;
    BitBtn8: TBitBtn;
    TabSheet17: TTabSheet;
    Panel93: TPanel;
    CheckBoxarchiveenabled: TCheckBox;
    CheckBoxdefarchivehighress: TCheckBox;
    CheckBoxdefarchivelowres: TCheckBox;
    Panel94: TPanel;
    GroupBox30: TGroupBox;
    Editmainarchivefolderhighres: TEdit;
    BitBtn5: TBitBtn;
    GroupBox33: TGroupBox;
    Editmainarchivefolderlowres: TEdit;
    BitBtnlresarc: TBitBtn;
    Panel95: TPanel;
    GroupBox31: TGroupBox;
    CheckListBoxAFoldername: TCheckListBox;
    Panel96: TPanel;
    Label58: TLabel;
    GroupBox32: TGroupBox;
    Edithighresarch: TEdit;
    GroupBox34: TGroupBox;
    Editlowarch: TEdit;
    Editarchdate: TEdit;
    Panel97: TPanel;
    GroupBox46: TGroupBox;
    Memo1: TMemo;
    TabSheet9: TTabSheet;
    Panel98: TPanel;
    GroupBox104: TGroupBox;
    Label107: TLabel;
    CheckBoxcustforcetoaplied: TCheckBox;
    CheckBoxcustomplancheck: TCheckBox;
    EditCustomchecksystemname: TEdit;
    Panel99: TPanel;
    TabSheet18: TTabSheet;
    Panel100: TPanel;
    Label20: TLabel;
    Editdeadlockdealay: TEdit;
    UpDown4: TUpDown;
    GroupBox13: TGroupBox;
    CheckBoxremovemissingcolorsonaprove: TCheckBox;
    GroupBox14: TGroupBox;
    Panel3: TPanel;
    CheckBoxreleaseonapproval: TCheckBox;
    CheckBoxCustomrel: TCheckBox;
    GroupBox15: TGroupBox;
    MemoCustomrel: TMemo;
    CheckBoxThsingleedrelease: TCheckBox;
    CheckBoxCommenttime: TCheckBox;
    GroupBox67: TGroupBox;
    Label84: TLabel;
    Editplannedpagenamedata: TEdit;
    CheckBoxnewtreeload: TCheckBox;
    CheckBoxFastTree: TCheckBox;
    Panel101: TPanel;
    Label42: TLabel;
    GroupBox12: TGroupBox;
    Label14: TLabel;
    CheckBoxshowallgraphtime: TCheckBox;
    ComboBoxgraphtimeformat: TComboBox;
    GroupBox22: TGroupBox;
    CheckBoxusedefaultdevice: TCheckBox;
    Editdefaultdevice: TEdit;
    ComboBoxdayofweek: TComboBox;
    CheckBoxSPPressrunexec: TCheckBox;
    CheckBoxpresssectionCalcX: TCheckBox;
    CheckBoxAutorefreshon: TCheckBox;
    CheckBoxPlanrepair: TCheckBox;
    CheckBoxprodshoworder: TCheckBox;
    CheckBoxprodshowRipsetup: TCheckBox;
    CheckBoxOverruleretransmit: TCheckBox;

    CheckBoxpaginarecalc: TCheckBox;
    CheckBoxSPPressrunexec2: TCheckBox;
    CheckBoxSPProductionexec: TCheckBox;
    CheckBoxApplyDoPostPressRunProcedure: TCheckBox;
    CheckBoxApplyDoPostProductionProcedure: TCheckBox;
    Panel102: TPanel;
    GroupBox102: TGroupBox;
    CheckListBoxMiscedit: TCheckListBox;
    GroupBox1: TGroupBox;
    CheckBoxDongA: TCheckBox;
    CheckBoxswapplatemerger: TCheckBox;
    GroupBox87: TGroupBox;
    Label94: TLabel;
    Label95: TLabel;
    Label96: TLabel;
    Label97: TLabel;
    Label98: TLabel;
    Label99: TLabel;
    CheckBoxhttimedeadline: TCheckBox;
    Edithottimehours: TEdit;
    UpDownhothours: TUpDown;
    Edithotbefore: TEdit;
    UpDownhotbefore: TUpDown;
    Edithotunder: TEdit;
    UpDownhotunder: TUpDown;
    Edithotafter: TEdit;
    UpDownhotafter: TUpDown;
    Editlength: TEdit;
    UpDownhotlength: TUpDown;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    CheckBoxAllowfalsespret: TCheckBox;
    CheckBoxsetcommentonfalsespreads: TCheckBox;
    CheckBoxstatresetonpagetypechange: TCheckBox;
    FontDialogplateprint: TFontDialog;
    EditAutoLoginUser: TEdit;
    Username: TLabel;
    Label116: TLabel;
    EditAutoLoginPassword: TEdit;
    UpDown8: TUpDown;
    Editminthumblevel: TEdit;
    GroupBox11: TGroupBox;
    Label28: TLabel;
    Label102: TLabel;
    RadioButtonBestfit: TRadioButton;
    RadioButton1to1: TRadioButton;
    UpDown6: TUpDown;
    EditInitzoom: TEdit;
    RadioButtonzoomby: TRadioButton;
    EditZoomstep: TEdit;
    UpDown5: TUpDown;
    ComboBoxZoomfilter: TComboBox;
    EditMinzoom: TEdit;
    Label13: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label30: TLabel;
    UpDown3: TUpDown;
    UpDown9: TUpDown;
    EditMaxzoom: TEdit;
    CheckBoxSimplePlanLoad: TCheckBox;
    CheckBoxCheckPlanningRipSetup: TCheckBox;
    Label100: TLabel;
    Editdevconttime: TEdit;
    Label101: TLabel;
    UpDownupddevcontrol: TUpDown;
    Label34: TLabel;
    UpDownnewtreeupdate: TUpDown;
    Editnewtreeupdate: TEdit;
    Label23: TLabel;
    Label24: TLabel;
    CheckBoxOnlyConnectPlanCenterUser: TCheckBox;
    Label36: TLabel;
    CheckBoxsmootplateautorefresh: TCheckBox;
    CheckBoxUseNiceManualStacker: TCheckBox;
    Label38: TLabel;
    Label45: TLabel;
    CheckBoxLimitTowers: TCheckBox;
    CheckBoxShowPageNote: TCheckBox;
    CheckBoxUseAdministrativeGroups: TCheckBox;
    CheckBoxUseADGroups: TCheckBox;
    CheckBoxUseWindowsUser: TCheckBox;
    CheckBoxclearpublonload: TCheckBox;
    CheckBoxmanualplanning: TCheckBox;
    CheckBoxmanhw: TCheckBox;
    GroupBox125: TGroupBox;
    Label122: TLabel;
    Label8: TLabel;
    Label35: TLabel;
    ColorBoxToolBarSel: TColorBox;
    ColorBoxToolbar: TColorBox;
    ColorBoxMenuToolBar: TColorBox;
    GroupBoxLocationPressFilterMode: TGroupBox;
    Label57: TLabel;
    RadioGroupLocationPressFilterMode: TRadioGroup;
    CheckBoxAllowLocationPressAllSelection: TCheckBox;
    CheckBoxAllowOnlyDefaultLocationPress: TCheckBox;
    ComboBoxlocations: TComboBox;
    GroupBox113: TGroupBox;
    CheckListBoxvisiblepressesConfig: TCheckListBox;
    Label54: TLabel;
    ComboBoxDefaultPress: TComboBox;
    CheckBoxFlatlook: TCheckBox;
    Label59: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    CheckBoxExcelSaveToFolder: TCheckBox;
    RadioGroupExcelEmailOption: TRadioGroup;
    Label67: TLabel;
    Label68: TLabel;
    EditDefaultExcelEmailTO: TEdit;
    EditDefaultExcelEmailCC: TEdit;
    EditDefaultExcelEmailSUBJ: TEdit;
    Label69: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    BitBtn11: TBitBtn;
    EditDefaultCSVReportfolder: TEdit;
    CheckBoxPlanLoadPromptForSectionEdition: TCheckBox;
    GroupBox132: TGroupBox;
    Label9: TLabel;
    CheckBoxShowPanelUnknown: TCheckBox;
    EditCheckTimeUnknown: TEdit;
    GroupBox18: TGroupBox;
    Label117: TLabel;
    EditExcludeArchiveFilter: TEdit;
    Editarchivepath: TEdit;
    CheckBoxArkenabled: TCheckBox;
    Editunknownpdf: TEdit;
    CheckBoxPdfunknown: TCheckBox;
    GroupBox26: TGroupBox;
    CheckBoxForcesamedev: TCheckBox;
    CheckBoxreselectplates: TCheckBox;
    CheckBoxplatedeluxe: TCheckBox;
    CheckBoxAllowPdfRotation: TCheckBox;
    CheckBoxOnlyShowDefaultPressPublications: TCheckBox;
    Label73: TLabel;
    EditUnknownFilesPanelWidth: TEdit;
    CheckBoxShowPagesOutOfRange: TCheckBox;
    GroupBox41: TGroupBox;
    CheckBoxrecombatunapply: TCheckBox;
    CheckBoxPartialNoEdChange: TCheckBox;
    CheckBoxPartialNoSecChange: TCheckBox;
    GroupBox98: TGroupBox;
    ComboBoxdefpagina: TComboBox;
    GroupBox53: TGroupBox;
    Label74: TLabel;
    CheckBoxUseExternalPlanLoad: TCheckBox;
    EditExternalPlanLoadExe: TEdit;
    CheckBoxbackwards: TCheckBox;
    CheckBoxShowSpecificDevicesOnly: TCheckBox;
    CheckListBoxSpecificDevices: TCheckListBox;
    CheckBoxForceGrayBackground: TCheckBox;
    CheckboxTreeShowAliasFirst: TCheckBox;
    CheckBoxThumbnailsShowAlsoForcedPages: TCheckBox;
    Panel18: TPanel;
    CheckBoxOnlyShowDefaultDevices: TCheckBox;
    CheckboxRestrictUniqueDelete: TCheckBox;
    CheckBoxMultiPressTemplateLoad: TCheckBox;
    RadioGroupPlanningPageNameIn: TRadioGroup;
    CheckBoxGeneratePlanPageNames: TCheckBox;
    CheckBoxAllowPageMove: TCheckBox;
    CheckBoxSetReleaseNowOnReimage: TCheckBox;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    GroupBox23: TGroupBox;
    Label78: TLabel;
    CheckBoxUsePreviewCache: TCheckBox;
    EditPreviewCacheShare: TEdit;
    CheckBoxTreeShowWeeknumberAlso: TCheckBox;
    CheckBoxXMLPlanAddTimestamp: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure BitBtnlresarcClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure EditrunrangestartKeyPress(Sender: TObject; var Key: Char);
    procedure EditrangetopKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure Add1Click(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure Add2Click(Sender: TObject);
    procedure Add3Click(Sender: TObject);
    procedure Delete2Click(Sender: TObject);
    procedure Loadall1Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure EditlistimeKeyPress(Sender: TObject; var Key: Char);
    procedure MemoShorteventExit(Sender: TObject);
    procedure CheckListBoxthumbtextStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure CheckListBoxthumbtextDragDrop(Sender, Source: TObject; X,
      Y: Integer);
    procedure CheckListBoxthumbtextDragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ListBoxthumborderStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure ListBoxthumborderDragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ListBoxthumborderDragDrop(Sender, Source: TObject; X,
      Y: Integer);
    procedure CheckListBoxPlatetextStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure CheckListBoxPlatetextDragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure CheckListBoxPlatetextDragDrop(Sender, Source: TObject; X,
      Y: Integer);
    procedure CheckListBoxplatecaptionDragDrop(Sender, Source: TObject; X,
      Y: Integer);
    procedure CheckListBoxplatecaptionDragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure CheckListBoxplatecaptionStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure StringGridprodsDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGridprodsSelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure StringGridprodsDblClick(Sender: TObject);
    procedure Clearall1Click(Sender: TObject);
    procedure Setall1Click(Sender: TObject);
    procedure CheckListBoxdefunknownClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure NewlineInthumb1Click(Sender: TObject);
    procedure SpacethumbcaplineClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Add5Click(Sender: TObject);
    procedure Delete4Click(Sender: TObject);
    procedure CheckListBoxThumbeventsClickCheck(Sender: TObject);
    procedure CheckBoxAllowDropFilesClick(Sender: TObject);
    procedure CheckListBox1ClickCheck(Sender: TObject);
    procedure CheckListBox1Click(Sender: TObject);
    procedure Edit6Change(Sender: TObject);
    procedure Edit6Enter(Sender: TObject);
    procedure Edit7Change(Sender: TObject);
    procedure RadioGroupHalfWebClick(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure LoadSettingsFromPrefs;
    procedure SaveSettingsToPrefs;
    procedure InitializeCheckBoxLists();


  private
    activated : boolean;
    Procedure getthelangs;

    { Private declarations }
  public
    restart : boolean;
    Advancedsettings : Boolean;
//    Showallchk,showallfilt : Boolean;
    Showthowthumbgrps : Boolean;
    multicheckbefore : Boolean;



    Webfileverion : Longint;
    Prodgridfonts : Array[0..27] of record
                                      name : String;
                                      Style : TFontStyles;
                                      Size : Longint;
                                    end;

    Function FindbiggestfontInternal:Longint;

  end;

var
  curlangforcancel : String;
  Idragorder : Longint;
  FormSettings: TFormSettings;
  localdatetimesettings : TFormatSettings;
  globaldbsettings : string;

  sqldateformat     : String;
  SQLdatetimeformat : string;
  sqltimeformat     : string;
  SQLnotime         : String;
  nodeldebug : Boolean;

implementation

{$R *.dfm}
uses
  utypes, USelectfolder, Umain, USelecttemplate,
  UHSOrder, Uaddpressrun, Udata, Uproof, Userverconfig, UFileserversetup,
  Ueditatextcombo, UEditlocserv, UTowerfilter, UPrefs, ULoadDlls;
Var
  Firstactivate : boolean;

  AddL : Tlistitem;



procedure TFormSettings.SaveSettingsToPrefs;
Var
  i, j : Integer;
  T,R,inifilename2 : string;
  found : Boolean;
Begin
  Prefs.FontDialogplateprintFont.Assign(FontDialogplateprint.Font);


  Prefs.ColorBoxMenuToolbarSelected := ColorBoxMenuToolbar.Selected;
  Prefs.ColorBoxToolbarSelected := ColorBoxToolbar.Selected;
  Prefs.ColorMapToolBarSelectedColor := ColorBoxToolbarSel.Selected;

  Prefs.UsePreviewCache := CheckBoxUsePreviewCache.Checked;
  Prefs.PreviewCacheShare := EditPreviewCacheShare.Text;

  Prefs.SetReleaseNowOnReimage := CheckBoxSetReleaseNowOnReimage.Checked;
  Prefs.GeneratePlanPageNames := CheckBoxGeneratePlanPageNames.Checked;
  Prefs.XMLPlanAddTimestampToFileName := CheckBoxXMLPlanAddTimestamp.Checked;

  Prefs.UseMultiPressTemplateLoad := CheckBoxMultiPressTemplateLoad.Checked;
  Prefs.ShowSpecificDevices :=   CheckBoxShowSpecificDevicesOnly.Checked;
  Prefs.PreviewForceGrayBackground := CheckboxForceGrayBackground.Checked;

  Prefs.OnlyShowDefaultDevices := CheckBoxOnlyShowDefaultDevices.Checked;


  for i := 0 to min(CheckListBoxSpecificDevices.Items.Count, Length(Prefs.SpecificDevices))-1 do
  begin
    CheckListBoxSpecificDevices.Items[i] := Prefs.SpecificDevices[i].Name;
    CheckListBoxSpecificDevices.Checked[i] := Prefs.SpecificDevices[i].Enabled;
  end;

  Prefs.ThumbnailsShowAlsoForcedPages := CheckBoxThumbnailsShowAlsoForcedPages.Checked;

  Prefs.UseExternalPlanLoad := CheckBoxUseExternalPlanLoad.Checked;
  Prefs.ExternalPlanLoaderExe := EditExternalPlanLoadExe.Text;

  Prefs.TreeShowPagesOutOfRange := CheckBoxShowPagesOutOfRange.Checked;
  Prefs.ShowPanelUnknownFilesWidth := StrToInt(EditUnknownFilesPanelWidth.Text);
  Prefs.PlanningOnlyShowDefaultPressPublications := CheckBoxOnlyShowDefaultPressPublications.Checked;
  Prefs.DefaultCSVReportfolder := EditDefaultCSVReportfolder.Text;

  Prefs.ExcelEmailOption := RadioGroupExcelEmailOption.ItemIndex;
  Prefs.DefaultExcelEmailTO := EditDefaultExcelEmailTO.Text;
  Prefs.DefaultExcelEmailCC := EditDefaultExcelEmailCC.Text;
  Prefs.DefaultExcelEmailSUBJ := EditDefaultExcelEmailSUBJ.Text;

  Prefs.PlanLoadPromptForSectionEdition := CheckBoxPlanLoadPromptForSectionEdition.Checked;
  Prefs.DefaultSaveToLocalFolder := CheckBoxExcelSaveToFolder.Checked;
  Prefs.FlatLook := CheckBoxFlatlook.Checked;
  Prefs.AllowOnlyDefaultLocationPress := CheckBoxAllowOnlyDefaultLocationPress.Checked;
  Prefs.AllowLocationPressAllSelection := CheckBoxAllowLocationPressAllSelection.Checked;
  Prefs.NcolsSeparationView := StrToInt(EditNcols.text);
  Prefs.DefaultSavePageListFile := Editdefaultsavepagelistfile.Text;
  Prefs.ShowPageNoteIndicator := CheckBoxShowPageNote.Checked;

  Prefs.LocationPressFilterMode := RadioGroupLocationPressFilterMode.ItemIndex;

  Prefs.OnlyConnectPlanCenterUser := CheckBoxOnlyConnectPlanCenterUser.Checked;

  Prefs.ThumbnailsAllowPdfRotation := CheckBoxAllowPdfRotation.Checked;

  Prefs.RestrictUniqueDelete :=  CheckboxRestrictUniqueDelete.Checked;

  Prefs.UseAdministrativeGroups :=  CheckBoxUseAdministrativeGroups.Checked;
  Prefs.UseADGroups := CheckBoxUseADGroups.Checked;
  Prefs.UseWindowsUser := CheckBoxUseWindowsUser.Checked;


  Prefs.LimitTowers :=  CheckBoxLimitTowers.Checked;

  if (Length(Prefs.FilterList) < ListViewFilter.Items.Count) then
    SetLength(Prefs.FilterList, ListViewFilter.Items.Count);
  for i := 0 to ListViewFilter.items.Count-1 do
    Prefs.FilterList[i] := ListViewFilter.Items[i].Caption;

  if (Length(Prefs.DefMarksList) <  ListViewdefmarks.Items.Count) then
    SetLength(Prefs.DefMarksList, ListViewdefmarks.Items.Count);
  for i := 0 to ListViewdefmarks.items.Count-1 do
    Prefs.DefMarksList[i] := ListViewdefmarks.Items[i].Caption;

  if (Length(Prefs.ZoneNamesList) <  ListViewZonenames.Items.Count) then
    SetLength(Prefs.ZoneNamesList, ListViewZonenames.Items.Count);
  for i := 0 to ListViewZonenames.items.Count-1 do
    Prefs.ZoneNamesList[i] := ListViewZonenames.Items[i].Caption;

  if (Length(Prefs.CylinderNameTranslation) < ValueListEditorCyl.Strings.Count) then
    SetLength(Prefs.CylinderNameTranslation, ValueListEditorCyl.Strings.Count);
  for i := 0 to ValueListEditorCyl.strings.Count-1 do
  Begin
    Prefs.CylinderNameTranslation[i].Key :=  ValueListEditorCyl.Cells[0,i+1];
    Prefs.CylinderNameTranslation[i].Value :=  ValueListEditorCyl.Cells[1,i+1];
  end;

  if (Length(Prefs.TowerNameTranslation) < ValueListEditortowerfilters.Strings.Count) then
    SetLength(Prefs.TowerNameTranslation, ValueListEditortowerfilters.Strings.Count);

  for i := 0 to ValueListEditortowerfilters.strings.Count-1 do
  begin
    Prefs.TowerNameTranslation[i].Key := ValueListEditortowerfilters.Cells[0,i+1];
    Prefs.TowerNameTranslation[i].Value := ValueListEditortowerfilters.Cells[1,i+1];
  end;

  if (Length(Prefs.StackNamesList) < ListViewStacknames.Items.Count) then
    SetLength(Prefs.StackNamesList, ListViewStacknames.Items.Count);
  for i := 0 to ListViewStacknames.items.Count-1 do
    Prefs.StackNamesList[i] := ListViewStacknames.items[i].Caption;

  if (Length(Prefs.PressTowers) < StringGridTowers.RowCount) then
    SetLength(Prefs.PressTowers, StringGridTowers.RowCount);
  for i := 0 to StringGridTowers.RowCount-1 do
  Begin
    Prefs.PressTowers[i].Press := StringGridTowers.Cells[0,i+1];
    Prefs.PressTowers[i].Tower := StringGridTowers.Cells[1,i+1];
  end;

  Prefs.ReportTimeOut := StrToInt(ReportTimeOut.Text);
  Prefs.ReportSaveFolder :=  ReportSaveFolder.Text;
  Prefs.EmailUsePublicationSpecificMail := EmailUsePublicationSpecificMail.Checked;
  Prefs.ReportOnProductionDeleteSendEmail := ReportOnProductionDeleteEmail.Checked;
  Prefs.MailFrom := MailFrom.Text;
  Prefs.MailTo := MailTo.Text;
  Prefs.MailCC := MailCC.Text;
  Prefs.MailSubject := MailSubject.Text;

  Prefs.MainArchiveFolderHighres := Editmainarchivefolderhighres.Text;
  Prefs.MainArchiveFolderLowres := Editmainarchivefolderlowres.Text;
  Prefs.SeparationTimeFormat := Editlistime.Text;

  Prefs.SelectAllCopiesOnReimage := CheckBoxreimcopies.Checked;
  Prefs.ArchiveEnabled := CheckBoxarchiveenabled.Checked;

  Prefs.DefaultArchiveHighres := CheckBoxdefarchivehighress.Checked;
  Prefs.DefaultArchiveLowres := CheckBoxdefarchivelowres.Checked;

  Prefs.CheckJpegTag := CheckBoxCheckJpgTag.Checked;
  Prefs.SetCommentOnFalseSpreads := CheckBoxsetcommentonfalsespreads.Checked;
  Prefs.PlanningClearPubliationsOnLoad := CheckBoxclearpublonload.Checked;
  Prefs.ProductionSelectAllCopies := CheckBoxSellallcopiesprod.Checked;
  Prefs.PreviewGoToNeedApproval := CheckBoxgtoneedapr.Checked;
  Prefs.PlateviewOrderInCaption := CheckBoxorderintopcap.Checked;
  Prefs.DefaultAutomatePlanname := CheckBoxdefaultautomateplanname.Checked;
  Prefs.PlateNoThumbnailRotation := CheckBoxPlatenothumbrot.Checked;
  Prefs.UseWebFileNameWithVersion := CheckBoxwebver.Checked;
  Prefs.ReimageExternalStatus := StrToInt(Editreimextstat.Text);

  Prefs.DefaultThumbnailOnlyPagePlans := CheckBoxDefaultThumbnailOnlyPagePlans.Checked;
  Prefs.TimedEditionRule := RadioGrouptimedrules.ItemIndex;
  Prefs.ActivateOnlyBlack := CheckBoxractivateonlyblack.Checked;
  Prefs.Split1UpRuns := CheckBoxsplit1upruns.Checked;
  Prefs.ShowInkDensityInformation := CheckBoxShowInkDensityInformation.Checked;
  Prefs.ShowSizeInformation := CheckBoxShowSizeInformation.Checked;

  Prefs.ProductionShowPressTime := CheckBoxShowPressTime.Checked;

  Prefs.LoadPdfInPreview := CheckBoxUseadobereader.Checked;
  Prefs.AllowPaginaRecalculate := CheckBoxpaginarecalc.Checked;

  Prefs.IgnoreNetUseCommand := CheckBoxignorenetuse.Checked;
  Prefs.AllowTimedEditions := CheckBoxtimedEd.Checked;

  Prefs.SendEmailMode := RadioGroupSendemail.ItemIndex;

  Prefs.EmailServer := Editemailserver.Text;
  Prefs.EmailFromAddress := Editemailadress.Text;

  Prefs.EmailLoginNameAsSenderName := CheckBoxemailasuser.Checked;
  Prefs.EmailSenderName := Editsendername.Text;
  Prefs.EmailTitleDefinition := Editemailtitle.Text;
  Prefs.EmailPagenameDefinition := Editemailpagename.Text;

  Prefs.ThumbnailTreeMinimumLevel := StrToInt(Editminthumblevel.Text);
  Prefs.AutoLoginUser := EditAutoLoginUser.Text;
  Prefs.AutoLoginPassword := EditAutoLoginPassword.Text;

  Prefs.PathToHoneywell := EditPathtohoneywell.Text;
  Prefs.HoneywellUsername := EditHoneywellusername.Text;
  Prefs.HoneywellPassword := EditHoneywellpassword.Text;

  Prefs.DefaultPlanHold := CheckBoxplanhold.Checked;
  Prefs.PlanningErrorFilesRetry := CheckBoxerrorfileretry.Checked;
  Prefs.ProductionReleaseHoldAllCopies := CheckBoxprodreleaseholdallcopy.Checked;

  Prefs.ShowPdfBook := RadioGroupShowpdfbook.ItemIndex;

  Prefs.DeadlockDelay := StrToInt(Editdeadlockdealay.Text);

  Prefs.AutoShowMasked := CheckBoxautomasked.Checked;
  Prefs.AdminTab := CheckBoxadmintab.Checked;

  Prefs.ShowNewProductSign := CheckBoxnewprodsign.Checked;
  Prefs.InsertSheetNumbersFor1up := CheckBoxinsertsheetnumbersfor1up.Checked;
  Prefs.TreeUseTreeUpdateTable := CheckBoxnewtreeload.Checked;
  Prefs.TreeShowWeekNumberInfo := CheckBoxTreeShowWeeknumberAlso.Checked;


  Prefs.PlanningExportXMLPlan := CheckBoxplanexport.Checked;

  if (Length(Prefs.TreeExtraEditionText) < CheckListBoxEditionText.Items.Count) then
    SetLength(Prefs.TreeExtraEditionText, CheckListBoxEditionText.Items.Count);
  for i := 0 to CheckListBoxEditionText.Items.Count-1 do
    Prefs.TreeExtraEditionText[i] := CheckListBoxEditionText.Checked[i];

  if (Length(Prefs.SectionText) < CheckListBoxSectionText.Items.Count) then
    SetLength(Prefs.SectionText, CheckListBoxSectionText.Count);
  for i := 0 to CheckListBoxSectionText.Count-1 do
    Prefs.SectionText[i] := CheckListBoxSectionText.Checked[i];

  Prefs.TreeShowDayName := CheckBoxtreedayname.Checked;

  Prefs.PressDataRequestLevel := ComboBoxpressreqlevel.ItemIndex;
  Prefs.PressDataRequestPressSpecific := CheckBoxpressspecreq.Checked;
  Prefs.PreviewShowInkZones := CheckBoxShowInkZones.Checked;

  Prefs.AllowDropFiles := CheckBoxAllowDropFiles.Checked;
  Prefs.AllowDropFilesDialog := CheckBoxAllowDropFilesDialog.Checked;
  Prefs.DropFilesDestination := EditDropFilesDestination.Text;

  Prefs.DefaultHidePagePlans := CheckBoxDefaultHidePagePlans.Checked;
  Prefs.UsePressSpecificInkRegenPath := CheckBoxinkpresspath.Checked;

  Prefs.UsePlanLock := CheckBoxExclusive.Checked;
  Prefs.ShowDataOnPlateThumbnails := CheckBoxdataonplate.Checked;
  Prefs.ShowReimageDialog := CheckBoxreimage.Checked;
  Prefs.ResetDeviceOnReimage := CheckBoxreimdevicereset.Checked;
  Prefs.ReimageAllColors := CheckBoxreimcolors.Checked;
  Prefs.UseCustomTowerNames := CheckBoxCustomtowerrnames.Checked;

  Prefs.TreeAutoExpandLevel := UpDownnewautoexp.Position;

  Prefs.Language := ComboBoxlanguage.Text;

  Prefs.MenuToolbarColor := ColorBoxMenuToolbar.ColorNames[ColorBoxMenuToolbar.ItemIndex];
  Prefs.ToolbarColor := ColorBoxToolbar.ColorNames[ColorBoxToolbar.ItemIndex];
  Prefs.ToolbarSelectedColor := ColorBoxToolbarSel.ColorNames[ColorBoxToolbarSel.ItemIndex];

  Prefs.ReselectThumbnails := CheckBoxreselectthumb.Checked;
  Prefs.ReselectPlates := CheckBoxreselectplates.Checked;

  Prefs.StartupWindowsSize := RadioGroupstartupsize.ItemIndex;
  Prefs.EnsurePreviewFormInFront := CheckBoxEnsurePreviewFormInFront.Checked;

  Prefs.UseCustomReleaseScript := CheckBoxCustomrel.Checked;
  Prefs.AutoLogin := CheckBoxautologin.Checked;
  Prefs.ReleaseOnSeparationSet := Checkboxreleaseonseprationset.Checked;

  Prefs.CustomPlanExportFilenameDefinition := EditCustomplanexportfilename.Text;

  Prefs.AllowManualPlanning := CheckBoxmanualplanning.Checked;
  Prefs.PlanningAllowUnplannedColors := CheckBoxAllowunplannedcolors.Checked;

  Prefs.SeparationsReselectPages := CheckBoxreselectpages.Checked;

  Prefs.EmailImageFormat := RadioGroupemailimageformat.ItemIndex;
  Prefs.StartupTab := ComboBoxStartupTab.ItemIndex;

  Prefs.AddEditionDefaultUniqueType := RadioGroupdefaultpagetypeaddedition.ItemIndex;
  Prefs.AddEditionDefaultApprovalUniquePage := RadioGroupdefaultUniqePaddedition.ItemIndex;
  Prefs.AddEditionDefaultApprovalCommonPage := RadioGroupdefaultCommonPaddedition.ItemIndex;
  Prefs.AddEditionDefaultKeepDevice := RadioGroupdefaultDeviceaddedition.ItemIndex;
  Prefs.AddEditionDefaultHold := RadioGroupdefaultHoldaddedition.ItemIndex;

  Prefs.PlanningDefaultPDF := CheckBoxdefaultPDF.Checked;
  Prefs.ReportIncludeHeaders := CheckBoxsavereportdetailcolumns.Checked;

  Prefs.DefaultHardproofType := ComboBoxdefHardprtype.ItemIndex;
  Prefs.DefaultSoftproofType := ComboBoxdefSoftprtype.ItemIndex;

  Prefs.PartialNoEditionChange := CheckBoxPartialNoEdChange.Checked;



  Prefs.FlatproofWaitForApproval := CheckBoxdefsoftvait.Checked;

  Prefs.HardproofWaitForApproval := CheckBoxhardvait.Checked;
  Prefs.EnableArchive := CheckBoxArkenabled.Checked;
  Prefs.UnplannedApplyDefaultMethodToWizard := RadioButtonwizard.Checked;

  Prefs.PlateviewBoldFont := CheckBoxplatefont.Checked;

  Prefs.PlateDetailsOff := CheckBoxplatedetailof.Checked;

  Prefs.AllowSelectionOfAnyLayout := CheckBoxlayoutanaki.Checked;
  Prefs.NewProductDeleteSystem := CheckBoxnewdelsys.Checked;

  Prefs.HideCommonPlates := CheckBoxnocommonplates.Checked;

  Prefs.PlateShowExternalStatus := CheckBoxplateshowextstat.Checked;
  Prefs.PlanLoadDefaultToNoTemplateChange := CheckBoxdefnochangetmpl.Checked;

  Prefs.LogApproval := CheckBoxlogapprove.Checked;
  Prefs.LogDisapproval := CheckBoxlogdisapprove.Checked;

  Prefs.LogHold := CheckBoxloghold.Checked;
  Prefs.LogRelease := CheckBoxlogrelease.Checked;
  Prefs.ReimageWithHighPriority := CheckBoxreimhighpri.Checked;
  Prefs.PlanningAutoSetEditionsOnLoad := CheckBoxautosetedonload.Checked;
  Prefs.ClearDeviceOnLayoutChange := CheckboxClearDeviceOnLayoutChange.Checked;

  Prefs.ExcludeArchiveFilter := EditExcludeArchiveFilter.Text;
  Prefs.CustomCheckSystemName := EditCustomchecksystemname.Text;

  Prefs.AddPressRunDefaultSection := EditDefsection.Text;
  Prefs.PlateTreeMinLevel := StrToInt(EditPlateminlevel.Text);

  Prefs.ApplyOnlyPlannedColors := CheckBoxApplyonlyplannedcolors.Checked;
  Prefs.DefaultShowNoUnplanned := CheckBox2nounplanned.Checked;

  Prefs.SpecialHalfwebAtMinPage := StrToInt(Edit3.Text);
  Prefs.SpecialHalfwebAtFixedPage := StrToInt(Edit5.Text);

  Prefs.SpecialHalfwebMode := RadioGroupHalfWeb.ItemIndex;

  Prefs.PlanningPageNameIn := RadioGroupPlanningPageNameIn.ItemIndex;
  Prefs.SeparationMinTreeLevel := StrToInt(Editminpagetreelevel.Text);
  Prefs.AutoScrollspeed := UpDownAutoscroolspeed.Position;
  Prefs.SeparationsVisibleColumns := UpDownVisiblecols.Position;
  Prefs.UsePageIndexForSorting := CheckBoxpagename.Checked;
  Prefs.PlanningDefaultBackwardNumbering := CheckBoxbackwards.checked;
  Prefs.SeparationsResetDeviceOnReimage := CheckBoxlistredevatreim.Checked;

  Prefs.CheckForUnknownFilesTimerInterval := StrToInt(Editunknowndropdownfilter.Text);
  if (Prefs.CheckForUnknownFilesTimerInterval < 1) then
    Prefs.CheckForUnknownFilesTimerInterval := 30;

  UpDownautorefresh.Min := Minautorefresh;
  if UpDownautorefresh.Position < Minautorefresh then
    UpDownautorefresh.Position := Minautorefresh;
  Prefs.AutoRefreshSpeed := UpDownautorefresh.Position;

  UpDownnewtreeupdate.Min := Mintreerefresh;
  if UpDownnewtreeupdate.Position < Mintreerefresh then
    UpDownnewtreeupdate.Position := Mintreerefresh;
  Prefs.TreeAutoRefreshSpeed := UpDownnewtreeupdate.Position;

  UpDownupddevcontrol.Min := Mindevicefresh;
  if UpDownupddevcontrol.Position < Mindevicefresh then
    UpDownupddevcontrol.Position := Mindevicefresh;

  Prefs.DeviceAutoRefreshSpeed := UpDownupddevcontrol.Position;

  Prefs.DeviceControlOnlyAdmins := CheckBoxDeviceControlOnlyAdmins.Checked;
  Prefs.SeparationsExportOnlySelectedRows := CheckBoxOnlyselection.Checked;
  Prefs.SeparationsShowStatusIcons := CheckBoxpageicons.Checked;
  Prefs.ThumbnailSize := RadioGroupthumbnailsize.ItemIndex;
  Prefs.DefaultDateSelect := RadioGroupdefdatesel.ItemIndex;

  Prefs.PlanningDefaultToMono := CheckBoxdefaultK.Checked;

  Prefs.UseGeneratedReadViews := CheckBoxpregenreadview.Checked;

  Prefs.PlateNameRestartOnEachRun := CheckBoxplatenamerecount.Checked;
  Prefs.PlanningDefaultUseAllMarkGroups := CheckBoxallmarkgroups.Checked;
  Prefs.PlateHideNamesOnThumbnails := CheckBoxhideprogthumb.Checked;

  Prefs.ThumbnailMakeChangesOnSubeditions := CheckBoxthumbpagechangesonsubeditions.Checked;
  Prefs.SeparationsUseLocaleTimeFormat := CheckBoxlocaltimeset.Checked;
  Prefs.ShowReimgeDialog := CheckBoxshowreimgediaglog.Checked;
  Prefs.PlanningGeneratePlateNames := CheckBoxplatenames.Checked;

  Prefs.PlanningDefaultInserted := CheckBoxDefplaninserted.Checked;

  for i := 0 to ListVieweventlogs.Items.Count-1 do
  begin
    for j := 0 to Length(Prefs.EventLogs)-1  do
    begin
      if (ListVieweventlogs.Items[i].Caption) = Prefs.EventLogs[j].Name then
      begin
        Prefs.EventLogs[j].Enabled := ListVieweventlogs.Items[i].Checked;
        break;
      end;
    end;
  end;

  Prefs.PressHighPlateName := EditHighplate.Text;
  Prefs.PressLowPlateName := Editlowplate.Text;
  Prefs.MinTreeLevelLog := StrToInt(Editminlogtree.Text);
  Prefs.TreeFilterOnProductionDate := CheckBoxpublfilreonproddate.Checked;

  Prefs.InkWarningLevel := UpDowninklimit.Position;
  Prefs.PreviewSeparationsOnReadview := CheckBoxseponreadview.Checked;

  Prefs.CustomPlanCheck := CheckBoxcustomplancheck.Checked;

  Prefs.PecomImport := CheckBoxpecomImport.Checked;

  Prefs.SetSecionNamesInPressrunComment := CheckBoxsecInpressruncom.Checked;
  Prefs.ThumbnailsSingleEditionRelease := CheckBoxThsingleedrelease.Checked;

  Prefs.UseDatabasePressTowerInfo := CheckBoxusepresstowerinfo.Checked;
  Prefs.SimplePlanLoad := CheckBoxSimplePlanLoad.Checked;

  Prefs.NewCCFilesNames := CheckboxNewCCFilesNames.Checked;

  Prefs.TreeShowPrepollEvents := CheckboxTreeShowPrepollEvents.Checked;

  Prefs.HidePlateCopyBar := CheckBoxplatehidecopy.Checked;

  Prefs.LogDeleteActions := CheckBoxlogdelete.Checked;

  Prefs.LogPlanningActions := CheckBoxlogplanning.Checked;

  Prefs.PlanningRunThroughPagination := CheckBoxruntrhoughpagina.Checked;

  Prefs.DefaultDevice := Editdefaultdevice.Text;

  Prefs.UseDefaultDevice := CheckBoxusedefaultdevice.Checked;

  Prefs.SmoothPlateAutoRefresh := CheckBoxsmootplateautorefresh.Checked;

  Prefs.PartialNoSecionChange := CheckBoxPartialNoSecChange.Checked;

//  Prefs.PressGroupSystem := RadioGrouppresssystem.ItemIndex;

  Prefs.DefaultToApprovalRequired := CheckBoxplanapproval.Checked;
  Prefs.LeanAndMeanPreview := CheckBoxLeanAndMeanPreview.Checked;
  Prefs.KeepOutputVersionOnReimage := CheckBoxKeepOutputVersionOnReimage.Checked;
  Prefs.DefaultShowPlateDetails := CheckBoxdefaultshowplatedetails.Checked;

  if (RadioButton1to1.Checked) then
    Prefs.ShowPreviewBestfit := 1
  else if (RadioButtonzoomby.Checked) then
    Prefs.ShowPreviewBestfit := 2
  else
    Prefs.ShowPreviewBestfit := 0;
  Prefs.ShowPreviewInitZoom := StrToInt(EditInitzoom.Text);

  Prefs.PreviewSidebarWidth := StrToInt(Editsidebarwidth.Text);
  Prefs.PreviewSidebarHeight := StrToInt(Editsidebarheight.Text);

  Prefs.ThumbnailsShowMonoPDFIndicator := CheckBoxthumbshowmono.Checked;
  Prefs.PlateviewShowRipSystem := CheckBoxplateshowripsystem.Checked;
  Prefs.PlanningUsePublicationDefaults := CheckBoxusepublicationdefaults.Checked;
  Prefs.NoTreeLamps := CheckBoxnotreelamps.Checked;
  Prefs.EditionApplyUseAlterntiveEditionFile := CheckBoxusealted.Checked;
  Prefs.DayOfWeek := ComboBoxdayofweek.ItemIndex;
  Prefs.AllowApplyPlateMerge := CheckBoxApplyPlateMerge.Checked;
  Prefs.DatabaseQueueInkResend := CheckBoxnewinkresend.Checked;
  Prefs.TreeShowPagesReadyFlag := CheckBoxTreeShowPagesReadyFlag.Checked;
  Prefs.AlwaysFullTreeExpand := CheckBoxAlwaysfullTreeExpand.Checked;

   Prefs.DongAInkVisible := CheckBoxDongA.Checked;

  Prefs.ReportSeparator := ComboBoxreportdetailsave.Text;

  Prefs.PostPlanSPPressrunExecute := CheckBoxSPPressrunexec.Checked;
  Prefs.PostPlanSPPressrunExecute2 := CheckBoxSPPressrunexec2.Checked;
  Prefs.PostPlanSPProductionExecute := CheckBoxSPProductionexec.Checked;
  Prefs.ApplyDoPostPressRunProcedure := CheckBoxApplyDoPostPressRunProcedure.Checked;
  Prefs.ApplyDoPostProductionProcedure := CheckBoxApplyDoPostProductionProcedure.Checked;


  Prefs.UseExtendedPlateView := CheckBoxplatedeluxe.Checked;
  Prefs.EditionUseAsMasterIgnorePress := CheckBoxeditionignorepress.Checked;
  Prefs.MustSetDeviceOnRelease := CheckBoxmustsetdev.Checked;
  Prefs.ReleaseOnApproval := CheckBoxreleaseonapproval.Checked;

  Prefs.ExternalTiffEditorPath := Editexternedittif.Text;
  Prefs.ExternalPDFEditorPath := Editexterneditpdf.Text;

  Prefs.CheckForUnknownFilesTimer := CheckBoxunknowncheck.Checked;
  Prefs.AllowInkfileRegenerate := CheckBoxAllowInkfileRegenerate.Checked;

  Prefs.PreviewZoomStep := StrToInt(EditZoomstep.Text);

  Prefs.PlanningDefaultFirstEdition := Editdefaultfirsted.Text;

  Prefs.UnknownPDFfolder := Editunknownpdf.Text;
  Prefs.PDFArchivefolder := Editarchivepath.Text;

  if (Length(Prefs.TreeExtraPublicationText) < CheckListBoxextrafiltertext.Items.Count) then
    SetLength(Prefs.TreeExtraPublicationText, CheckListBoxextrafiltertext.Items.Count);
  for i := 0 to CheckListBoxextrafiltertext.Items.Count-1 do
    Prefs.TreeExtraPublicationText[i] := CheckListBoxextrafiltertext.Checked[i];

  Prefs.OrStackpositionsTogether := CheckBoxOrstacks.Checked;
  Prefs.PlanXMLExportFolder := EditCustomplanexportdest.Text;

  Prefs.AutoFlatProof := CheckBoxautoflatproof.Checked;

  Prefs.SeparationsFullAutorefresh := CheckBoxpagefullautorefresh.Checked;

  Prefs.KeepTreeExpansion := CheckBoxKeeptreeexpantion.Checked;
  Prefs.ShowWeekNumberInTree := CheckBoxShowWeekNr.Checked;

  Prefs.PlanningAutoOrderNumberBergen := CheckBoxAutoplannumbergen.Checked;

  Prefs.PreviewCommentAsCaption := CheckBoxPrevcomment.Checked;
  Prefs.ArchiveHigresFilenameDefinition := Edithighresarch.Text;
  Prefs.ArchiveLowResDateDefinition := Editarchdate.Text;
  Prefs.ReportShowAllGraphTime := CheckBoxshowallgraphtime.Checked;
  Prefs.GraphTimeFormat := ComboBoxgraphtimeformat.Text;
  Prefs.SeparationsAllowShowAllPublications := CheckBoxpagesshowall.Checked;
  Prefs.UseDBTowerNames := CheckBoxUseDBtowernames.Checked;
  Prefs.PlanRepair := CheckBoxPlanrepair.Checked;
  Prefs.NoLoginPrompt := CheckBoxNologin.Checked;
  Prefs.ThumnailsShowHold := CheckBoxthumbshowhold.Checked;
  Prefs.GenerateReportWhenDeleting := CheckBoxgenrepwhendel.Checked;

  Prefs.TreeOrderByEditionID := CheckBoxtreebyedid.Checked;
  Prefs.EditionsAssignUniqueToLocalOnly := CheckBoxuniqloconly.Checked;

  Prefs.ReportDateFormat := Editreportdateform.Text;

  Prefs.TreeOrder := RadioGroupTreeorder.ItemIndex;

  Prefs.CommaSeparatorChar := ComboBoxSepSEP.Text;

  Prefs.PreviewMinzoom := StrToInt(EditMinzoom.Text);
  Prefs.PreviewMaxzoom := StrToInt(EditMaxzoom.Text);

  Prefs.AddTimeToPageComment := CheckBoxCommenttime.Checked;
  Prefs.ShowPlannameInTree := CheckBoxplannameintree.Checked;

  Prefs.PreviewShowSidebar := CheckBoxShowsidebar.Checked;
  Prefs.RemoveMissingColorsOnApprove := CheckBoxremovemissingcolorsonaprove.Checked;

  Prefs.AutoReImageOnDeviceChange := CheckBoxautoreimondevch.Checked;
  Prefs.MinimumPlatenameLength := StrToInt(Editminplatenamelength.Text);
  Prefs.ShowDeviceControl := CheckBoxshowdevcontrol.Checked;
  Prefs.DeviceControlUsePressDevices := CheckBoxpressindevcontrol.Checked;
  Prefs.PageListExportIncludeHeaders := CheckBoxSEPHEader.Checked;
  Prefs.PlanningDefaultColorProofer := ComboBoxcolorproof.Text;
  Prefs.PlanningDefaultPDFProofer := ComboBoxpdfproof.Text;
  Prefs.PlanningDefatulMonoProofer := ComboBoxBWproof.Text;
  Prefs.PreviewUsePregeneratedDns := CheckBoxpregendns.Checked;
  Prefs.CustomXMLReportOutputFolder := Editcustomdelcomdest.Text;
  Prefs.DefaultReportFolder := EditDeafaultreportfolder.Text;
  Prefs.SetCommentOnAllEditions := CheckBoxdefaultsetcomed.Checked;
  Prefs.AutoRefreshOn := CheckBoxAutorefreshon.Checked;
  Prefs.ThumbnailsShowExternalStatus := CheckBoxthumbshowextstat.Checked;
  Prefs.PlatesShowTemplateInCaption := CheckBoxShowtemplateincaption.Checked;

  Prefs.PlanningAllowManualHalfWebOverride := CheckBoxmanhw.Checked;
  Prefs.AutoConsole := CheckBoxautoconsole.Checked;
  Prefs.ConsoleName := Editconsolename.Text;
  Prefs.MaxConsoleAge := StrToInt(Editmaxconsoleage.Text);
  Prefs.ForceSameDevice := CheckBoxForcesamedev.Checked;
  Prefs.AllowParalelView := CheckBoxAllowparalelview.Checked;
  Prefs.EditionsSetForceWhenCommon := CheckBoxforcewhencommon.Checked;
  Prefs.UseTrueSheetSide := CheckBoxusetruesheetside.Checked;
//  Prefs.TreeShowAllLocationOption := CheckBoxshowallfilter.Checked;
  Prefs.SelectAllCopiesOnRelease := CheckBoxSelectAllCopiesOnRelease.Checked;
  Prefs.AllowControlDevices := CheckBoxcontroldev.Checked;

  Prefs.PlannedPageNameDataFile := Editplannedpagenamedata.Text;

  Prefs.UnknownFilesFileNameLengthMatch := UpDowndropdownfilter.Position;
  Prefs.ProductionViewShowOrder := CheckBoxprodshoworder.Checked;
  Prefs.ThumbnailShowPitstopLog := CheckBoxShowpitstoplog.Checked;
  Prefs.ProductionShowRipSetup := CheckBoxprodshowRipsetup.Checked;

  Prefs.ShowPanelUnknownFiles := CheckBoxShowPanelUnknown.Checked;
  Prefs.ShowPanelUnknownFilesRefreshTime := StrToInt(EditCheckTimeUnknown.Text);
  Prefs.ForcePlanToApplied := CheckBoxcustforcetoaplied.Checked;
  Prefs.RestrictRetransmit := CheckBoxOverruleretransmit.Checked;
  Prefs.PlanClearSections := CheckBoxplanclearsections.Checked;
  Prefs.PlatesAutoReimageOnDeviceChange := CheckBoxplateReimondevch.Checked;
  Prefs.NewInkRegeneration := CheckBoxnewinkregen.Checked;
  Prefs.ProductionMinTreeLevel := StrToInt(Editminprodtreelevel.Text);
//  Prefs.ShowPressFilters := CheckBoxshowpressfilters.Checked;
  Prefs.DefaultPress := ComboBoxDefaultPress.Text;
  Prefs.ThumbnailForceReadorder := CheckBoxforcereadorder.Checked;
  Prefs.UsePlateviewThumbnails := CheckBoxplatethumb.Checked;
  Prefs.GrayDensityMap := CheckBoxgraydns.Checked;
  Prefs.UseFileCenterTiffArchive :=  CheckBoxUseFileCenterTiffArchive.Checked;
  Prefs.IncludeImageOnceState := CheckBoxIncludeImageOnceState.Checked;
  Prefs.PlatePrintoutUseSectionPage := CheckBoxplateprtsecpage.Checked;
  Prefs.PlatesShowPagesStanding := CheckBoxplatespecialstanding.Checked;
  Prefs.ThumbnailAllowSetFalseSpread := CheckBoxAllowfalsespret.Checked;
  Prefs.ThumbnailResetStatusOnPageTypeChange := CheckBoxstatresetonpagetypechange.Checked;
  Prefs.AllowPageDelete := CheckBoxpagedelete.Checked;
  Prefs.AutoTowerOrder := CheckBoxtowerorderauto.Checked;
  Prefs.ShowAddCopyDialog := CheckBoxaddcopydialog.Checked;
  Prefs.ErrorFileRetrySendLog := CheckBoxuknownsendlog.Checked;
  Prefs.DecreaseVersion := CheckBoxDecreasever.Checked;

  Prefs.EditionViewOnlySecInEd := CheckBoxOnlySecined.Checked;

  Prefs.ReleaseRuleBasedOn := RadioGroupreleaserulebase.ItemIndex;

  Prefs.SetApproveTimeOnRelease := CheckBoxapprovetimeonrelease.Checked;
  Prefs.AlternativePageNameField := Editaltpagenamefield.Text;
  Prefs.AlternativeSheetnameField := EditAltSheet.Text;

  Prefs.PlanningUseImportCenter := CheckBoxuseimportcenter.Checked;
  Prefs.ImportCenterInputPath := Editimportcenterinputpath.Text;
  Prefs.ImportCenterDonePath := Editimportcenterdonepath.Text;
  Prefs.ImportCenterErrorPath := Editimportcentererrorpath.Text;

  Prefs.EnablePressSpecificSelection := CheckBoxenablespecifiksel.Checked;
  Prefs.PressTimeInPlateTree := CheckBoxpresstimeinplatetree.Checked;

  Prefs.PlanningRipSetup := CheckBoxCheckPlanningRipSetup.Checked;

  Prefs.PlanningPageFormat := CheckBoxCheckPlanningPageFormat.Checked;

  Prefs.NewPreviewNames := CheckBoxNewPreviewNames.Checked;

  Prefs.ShowPdfUnknownFiles := CheckBoxPdfunknown.Checked;

  Prefs.AllowMovePages := CheckBoxAllowPageMove.Checked;

  Prefs.PreviewPreloadSeparations := CheckBoxpageprevseps.Checked;
  Prefs.PreviewPreloadDns := CheckBoxpageprevlevel.Checked;
  Prefs.PreviewPreloadPlateSeparations := CheckBoxplateprevseps.Checked;
  Prefs.PreviewPreloadPlateDns := CheckBoxplateprevlevel.Checked;
  Prefs.PreviewPreloadInkzones := CheckBoxplateprevZones.Checked;

  Prefs.OnlyApplyOnUnapplied := CheckBoxonlyaplyonunapplied.Checked;

  Prefs.PlanningHotTimeFromDeadline := CheckBoxhttimedeadline.Checked;
  Prefs.PlanningHotTimeFromDeadlineAddHours := StrToInt(Edithottimehours.Text);
  Prefs.PreviewZoomfilter := ComboBoxZoomfilter.ItemIndex;
  Prefs.ApplyPlanAutoMultiPress := CheckBoxAutomultipress.Checked;
  Prefs.TextOnReportGraph := CheckBoxtextongrp.Checked;
  Prefs.PlateDoneStatisticsMode := RadioGroupplatedonestat.ItemIndex;
  Prefs.AllowDropFilesDeleteAfterCopy := CheckBoxAllowDropFilesDeleteAfterCopy.Checked;
  Prefs.AlwaysUseOffset0OnApply := CheckBoxAlwaysUseOffset0OnApply.Checked;
  Prefs.NewPlateDataSystem := CheckBoxnewplatedata.Checked;
  Prefs.PlatesAllowSinglePagePreview := CheckBoxplatepagepreview.Checked;

  if (Length(Prefs.ArchiveFolderNameDefinitions) < CheckListBoxAFoldername.Items.Count)  then
    SetLength(Prefs.ArchiveFolderNameDefinitions, CheckListBoxAFoldername.Items.Count);
  for i := 0 to CheckListBoxAFoldername.Items.Count-1 do
    Prefs.ArchiveFolderNameDefinitions[i] := CheckListBoxAFoldername.Checked[i];

  if (Length(Prefs.ReleaseRules) < CheckListBoxreleaserules.Items.Count)  then
    SetLength(Prefs.ReleaseRules, CheckListBoxreleaserules.Items.Count);
  for i := 0 to CheckListBoxreleaserules.Items.count-1 do
    Prefs.ReleaseRules[i] := CheckListBoxreleaserules.Checked[i];


 // ini.WriteInteger('system','ListViewplannamedstyles', ListViewplannamedstyles.Items.Count);

  //ini.Writeinteger('system','ListViewplannamedstylesdefault',0);

  if (Length(Prefs.PlannedNameDefinitions) <  ListViewplannamedstyles.Items.Count) then
    SetLength(Prefs.PlannedNameDefinitions, ListViewplannamedstyles.Items.Count);
  for i := 0 to ListViewplannamedstyles.Items.Count-1 do
  begin
    Prefs.PlannedNameDefinitions[i].Name := ListViewplannamedstyles.Items[i].Caption;
    Prefs.PlannedNameDefinitions[i].Format :=  ListViewplannamedstyles.Items[i].SubItems[0];
    Prefs.PlannedNameDefinitions[i].Dateformat := ListViewplannamedstyles.Items[i].SubItems[1];
    Prefs.PlannedNameDefinitions[i].Enabled := ListViewplannamedstyles.Items[i].Checked;
  end;

  if (Length(Prefs.PlateText) <  CheckListBoxPlatetext.Items.Count) then
    SetLength(Prefs.PlateText, CheckListBoxPlatetext.Items.Count);
  for i := 0 to CheckListBoxPlatetext.Items.Count-1 do
  begin
    Prefs.PlateText[i].Name := CheckListBoxPlatetext.Items[i];
    Prefs.PlateText[i].Enabled := CheckListBoxPlatetext.Checked[i];
  end;

  if (Length(Prefs.PressRunTexts) < CheckListBoxpressruntexts.Items.Count) then
     SetLength(Prefs.PressRunTexts, CheckListBoxpressruntexts.Items.Count);
  for i := 0 to CheckListBoxpressruntexts.Items.Count-1 do
  begin
    Prefs.PressRunTexts[i].Name := CheckListBoxpressruntexts.Items[i];
    Prefs.PressRunTexts[i].Enabled :=  CheckListBoxpressruntexts.Checked[i];
  end;

  if (Length(Prefs.PlateCaptionText) < CheckListBoxplatecaption.Items.Count) then
    SetLength(Prefs.PlateCaptionText, CheckListBoxplatecaption.Items.Count);
  for i := 0 to CheckListBoxplatecaption.Items.Count-1 do
  begin
    Prefs.PlateCaptionText[i].Name := CheckListBoxplatecaption.Items[i];
     Prefs.PlateCaptionText[i].Enabled := CheckListBoxplatecaption.Checked[i];
  End;

  if (Length(Prefs.ThumbnailCaptionText) < CheckListBoxthumbtext.Items.Count) then
    SetLength(Prefs.ThumbnailCaptionText, CheckListBoxthumbtext.Items.Count);
  for i := 0 to CheckListBoxthumbtext.Items.Count-1 do
  begin
    Prefs.ThumbnailCaptionText[i].Name := CheckListBoxthumbtext.Items[i];
    Prefs.ThumbnailCaptionText[i].Enabled := CheckListBoxthumbtext.Checked[i];
  End;

  if (Length(Prefs.ThumbnailGroupCaptionText) < CheckListBoxthgroupecap.Items.Count) then
    SetLength(Prefs.ThumbnailGroupCaptionText, CheckListBoxthgroupecap.Items.Count);
  for i := 0 to CheckListBoxthgroupecap.Items.count-1 do
  begin
    Prefs.ThumbnailGroupCaptionText[i].Name := CheckListBoxthgroupecap.Items[i];
    Prefs.ThumbnailGroupCaptionText[i].Enabled := CheckListBoxthgroupecap.Checked[i];
  End;

  Prefs.EnableEditOfMiscString2 :=  CheckListBoxMiscedit.checked[0];
  Prefs.EnableEditOfMiscString3 :=  CheckListBoxMiscedit.checked[1];
  Prefs.EnableEditOfMiscInt2 :=  CheckListBoxMiscedit.checked[2];
  Prefs.EnableEditOfMiscInt3 :=  CheckListBoxMiscedit.checked[3];

  Prefs.PlanningPaginationMode := ComboBoxdefpagina.ItemIndex;
  Prefs.SynchronizedTreeUpdate := CheckBoxFastTree.Checked;

  if (Length(Prefs.ProductionColumns) <  StringGridprods.ColCount) then
    SetLength(Prefs.ProductionColumns, StringGridprods.ColCount);
  for i := 0 to min(Length(Prefs.ProductionColumns),StringGridprods.ColCount)-1 do
  begin
    Prefs.ProductionColumns[i].Width := StringGridprods.ColWidths[i];
    Prefs.ProductionColumns[i].ColumnName := StringGridprods.Cells[i, 0];
    Prefs.ProductionColumns[i].Visible := CheckListbox1.Checked[i]; //StringGridprods.ColWidths[i] > 0;
  end;

  SetLength(Prefs.ProductionGridFonts, Prefs.PRODUCTIONCOLUMNCOUNT);
  for i := 0 to Prefs.PRODUCTIONCOLUMNCOUNT-1 do
  begin
    Prefs.ProductionGridFonts[i].Name := Prodgridfonts[i].name;
    Prefs.ProductionGridFonts[i].Style :=  Prodgridfonts[i].Style;
    Prefs.ProductionGridFonts[i].Size :=  Prodgridfonts[i].Size;
  end;

  if (Length(Prefs.ThumbnailStatusBar) <>  CheckListBoxthumbstatbar.Items.Count) then
    SetLength(Prefs.ThumbnailStatusBar, CheckListBoxthumbstatbar.Items.Count);
  For i := 0 to CheckListBoxthumbstatbar.Items.Count-1 do
  begin
    Prefs.ThumbnailStatusBar[i].Enabled := CheckListBoxthumbstatbar.Checked[i];
    Prefs.ThumbnailStatusBar[i].Name := CheckListBoxthumbstatbar.Items[i];
  End;

  Prefs.ArchiveLowResNameDefinition := Editlowarch.Text;
  Prefs.PlanningUsePublicationDefaultlPriority := CheckBoxPlanpri.Checked;
  Prefs.UseHoneywell := CheckBoxUsehoneywell.Checked;
  Prefs.SwapPlateMerger := CheckBoxswapplatemerger.Checked;

  Prefs.PlateTransmissionSystem := CheckBoxpreparetrans.Checked;

  Prefs.TreeGreenOnceImaged := CheckBoxtreeonceimaged.Checked;
  Prefs.PlanInkaliasLoad := CheckBoxplaninkaliasload.Checked;

  Prefs.HotHourPriorityDifference := UpDownhothours.Position;
  Prefs.HotHourPriorityLength := UpDownhotlength.Position;
  Prefs.HotHourPriorityBefore := UpDownhotbefore.Position;
  Prefs.HotHourPriorityDuring := UpDownhotunder.Position;
  Prefs.HotHourPriorityAfter := UpDownhotafter.Position;

  Prefs.SeparateNodesPerPressrun := CheckBoxSeparateNodesPerPressrun.Checked;
  Prefs.PlateTreeExpansion := RadioGroupplatetreeexp.ItemIndex;

  if (Length(Prefs.ThumbnailSortingOrder) < ListBoxthumborder.Items.Count) then
    SetLength(Prefs.ThumbnailSortingOrder, ListBoxthumborder.Items.Count);
  for i := 0 to ListBoxthumborder.Items.Count-1 do
    Prefs.ThumbnailSortingOrder[i] :=  ListBoxthumborder.Items[i];

  if (Length(Prefs.ThumbnailEvents) < CheckListBoxThumbevents.Items.Count) then
    SetLength(Prefs.ThumbnailEvents, CheckListBoxThumbevents.Items.Count);
  for i := 0 to CheckListBoxThumbevents.Items.Count-1 do
  begin
    Prefs.ThumbnailEvents[i].Name := CheckListBoxThumbevents.Items[i];
    Prefs.ThumbnailEvents[i].Enabled := CheckListBoxThumbevents.checked[i];
  end;

  if (Length(Prefs.PrePollEventNames) < MemoShortevent.Lines.Count) then
    SetLength(Prefs.PrePollEventNames, MemoShortevent.Lines.Count);
  for i := 0 to MemoShortevent.Lines.Count-1 do
    Prefs.PrePollEventNames[i] := MemoShortevent.Lines[i];

  if (Length(Prefs.PlatePrintListTitleDefinition) < CheckListBoxPLtPrnttitle.Items.Count) then
    SetLength(Prefs.PlatePrintListTitleDefinition, CheckListBoxPLtPrnttitle.Items.Count);
  For i := 0 to CheckListBoxPLtPrnttitle.Items.Count-1 do
    Prefs.PlatePrintListTitleDefinition[i] := CheckListBoxPLtPrnttitle.Checked[i];

  if (Length(Prefs.PlatePrintListPlateDefinition) < CheckListBoxPLtPrntplate.Items.Count) then
    SetLength(Prefs.PlatePrintListPlateDefinition, CheckListBoxPLtPrntplate.Items.Count);
  for i := 0 to CheckListBoxPLtPrntplate.Items.count-1 do
    Prefs.PlatePrintListPlateDefinition[i] := CheckListBoxPLtPrntplate.Checked[i];


  if (Length(Prefs.SeparationsReportColumns) < CheckListBoxdetailsavecols.Items.Count) then
    SetLength(Prefs.SeparationsReportColumns, CheckListBoxdetailsavecols.Items.Count);
  for i := 0 to CheckListBoxdetailsavecols.Items.Count-1 do
    Prefs.SeparationsReportColumns[i] := CheckListBoxdetailsavecols.Checked[i];

  Prefs.SuperUserMaySeeAll := CheckBoxsuperall.Checked;
  Prefs.DefaultLocation := ComboBoxlocations.Text;
  Prefs.DeleteOnlyOnSelectedPress := CheckBoxdelonlyselon.Checked;

  found := false;
  if (Length(Prefs.VisibleTowers) < CheckListBoxvisibletowers.Items.Count) then
    SetLength(Prefs.VisibleTowers, CheckListBoxvisibletowers.Items.Count);
  for i := 0 to CheckListBoxvisibletowers.Items.Count-1 do
  begin
    Prefs.VisibleTowers[i].Press := CheckListBoxvisibletowers.Items[i];
    Prefs.VisibleTowers[i].Visible :=  CheckListBoxvisibletowers.Checked[i];
    if (Prefs.VisibleTowers[i].Visible) then
      found := true;
  end;

  if (not found) then
    for i := 0 to Length(Prefs.VisibleTowers)-1 do
      Prefs.VisibleTowers[i].Visible :=  true;

  if (Length(Prefs.MaxPagesPerPress) < ValueListEditormaxpagepress.Strings.Count) then
    SetLength(Prefs.MaxPagesPerPress, ValueListEditormaxpagepress.Strings.Count);
  for i := 0 to ValueListEditormaxpagepress.Strings.Count-1 do
  begin
      Prefs.MaxPagesPerPress[i].Key := ValueListEditormaxpagepress.Cells[0,i+1] ;
      Prefs.MaxPagesPerPress[i].Value := ValueListEditormaxpagepress.Cells[1,i+1];
  end;

  if (Length(Prefs.OldInkPathsPerPress) < ValueListEditorOldInk.Strings.Count) then
    SetLength(Prefs.OldInkPathsPerPress, ValueListEditorOldInk.Strings.Count);
  for i := 0 to ValueListEditorOldInk.Strings.Count-1 do
  begin
      Prefs.OldInkPathsPerPress[i].Key := ValueListEditorOldInk.Cells[0,i+1] ;
      Prefs.OldInkPathsPerPress[i].Value := ValueListEditorOldInk.Cells[1,i+1];
  end;

  if (Length(Prefs.InkGenerationSystemPerPress) < ValueListEditorInkGen.Strings.Count) then
    SetLength(Prefs.InkGenerationSystemPerPress, ValueListEditorInkGen.Strings.Count);
  for i := 0 to ValueListEditorInkGen.Strings.Count-1 do
  begin
      Prefs.InkGenerationSystemPerPress[i].Key := ValueListEditorInkGen.Cells[0,i+1] ;
      Prefs.InkGenerationSystemPerPress[i].Value := ValueListEditorInkGen.Cells[1,i+1];
  end;

  if (Length(Prefs.DefaultUnknownFilesFolders) < CheckListBoxdefunknown.Items.Count) then
    SetLength(Prefs.DefaultUnknownFilesFolders, CheckListBoxdefunknown.Items.Count);
  for i := 0 to CheckListBoxdefunknown.Items.Count-1 do
  begin
      Prefs.DefaultUnknownFilesFolders[i].Name := CheckListBoxdefunknown.Items[i];
      Prefs.DefaultUnknownFilesFolders[i].Enabled := CheckListBoxdefunknown.Checked[i];
  end;

  found := false;
  if (Length(Prefs.VisiblePressesConfig) < CheckListBoxvisiblepressesConfig.Items.Count) then
    SetLength(Prefs.VisiblePressesConfig, CheckListBoxvisiblepressesConfig.Items.Count);
  for i := 0 to  CheckListBoxvisiblepressesConfig.Items.Count-1 do
  begin
     Prefs.VisiblePressesConfig[i].Press := CheckListBoxvisiblepressesConfig.Items[i];
     Prefs.VisiblePressesConfig[i].Visible := CheckListBoxvisiblepressesConfig.Checked[i];
     if (Prefs.VisiblePressesConfig[i].Visible) then
       found := true;
  end;

  if (not found) then
    for i := 0 to Length(Prefs.VisiblePressesConfig)-1 do
      Prefs.VisiblePressesConfig[i].Visible :=  true;

  if (MemoCustomrel.Lines.Count > 0) then
    Prefs.CustomReleaseScript.AddStrings(MemoCustomrel.Lines);


  Prefs.CustomManualStackerSet :=  CheckBoxUseNiceManualStacker.Checked;
  Prefs.TreeShowAliasFirst := CheckboxTreeShowAliasFirst.Checked;

end;


Procedure TFormSettings.getthelangs;
Var
  I: Integer;
  T,T1 : String;
  F : Tsearchrec;
Begin
  ComboBoxlanguage.Items.Clear;
  ComboBoxlanguage.Items.Add('Default');
  T := ExtractFilePath(Application.ExeName) + 'INFRA-*.Trl'; // OK!
  i := FindFirst(t, faArchive,f);
  While i = 0 do
  begin
    t1 := f.name;
    t1 := ChangeFileExt(t1,'');

    Delete(t1,1,6);
    ComboBoxlanguage.Items.Add(t1);
    i := FindNext(f);
  end;
  FindClose(f);
End;


procedure TFormSettings.LoadSettingsFromPrefs;
Var
  i,j : integer;
  L : tlistitem;
  T,t1,t2,aktlang : string;
  nn   : Integer;
  s   : String;
  n : Integer;
Begin
  aktlang := ComboBoxlanguage.Text;
  getthelangs;
   writeMainlogfile('Setting - LoadSettingsFromPrefs 0');
  if (Prefs.AlwaysUseGeneratedReadViews) then
  begin
    CheckBoxpregenreadview.Checked := true;
    CheckBoxpregenreadview.Enabled := false;
  end;

  try
   // FontDialogplateprint.Font := Prefs.FontDialogplateprintFont;

    FontDialogplateprint.Font.Assign(Prefs.FontDialogplateprintFont);


  except

  end;

  ColorBoxMenuToolbar.Selected :=  Prefs.ColorBoxMenuToolbarSelected;
  ColorBoxToolbar.Selected :=  Prefs.ColorBoxToolbarSelected;
  ColorBoxToolbarSel.Selected :=  Prefs.ColorMapToolBarSelectedColor;

  CheckBoxUsePreviewCache.Checked := Prefs.UsePreviewCache;
  EditPreviewCacheShare.Text := Prefs.PreviewCacheShare;

  CheckBoxGeneratePlanPageNames.Checked :=  Prefs.GeneratePlanPageNames;
  CheckBoxOnlyShowDefaultDevices.Checked := Prefs.OnlyShowDefaultDevices;

  CheckBoxFlatlook.Checked := Prefs.FlatLook;
  CheckboxForceGrayBackground.Checked := Prefs.PreviewForceGrayBackground;

  CheckBoxThumbnailsShowAlsoForcedPages.Checked := Prefs.ThumbnailsShowAlsoForcedPages;


  CheckBoxUseExternalPlanLoad.Checked  := Prefs.UseExternalPlanLoad;
  EditExternalPlanLoadExe.Text := Prefs.ExternalPlanLoaderExe;


  CheckBoxShowPagesOutOfRange.Checked := Prefs.TreeShowPagesOutOfRange;

  EditUnknownFilesPanelWidth.Text := IntToStr(Prefs.ShowPanelUnknownFilesWidth);
  CheckBoxOnlyShowDefaultPressPublications.Checked :=  Prefs.PlanningOnlyShowDefaultPressPublications;
  RadioGroupExcelEmailOption.ItemIndex  := Prefs.ExcelEmailOption;
  EditDefaultExcelEmailTO.Text := Prefs.DefaultExcelEmailTO;
  EditDefaultExcelEmailCC.Text := Prefs.DefaultExcelEmailCC;
  EditDefaultExcelEmailSUBJ.Text := Prefs.DefaultExcelEmailSUBJ;

  EditDefaultCSVReportfolder.Text := Prefs.DefaultCSVReportfolder;
  CheckBoxAllowOnlyDefaultLocationPress.Checked := Prefs.AllowOnlyDefaultLocationPress;
  CheckBoxAllowLocationPressAllSelection.Checked := Prefs.AllowLocationPressAllSelection;
  CheckBoxOnlyConnectPlanCenterUser.Checked := Prefs.OnlyConnectPlanCenterUser;
  CheckBoxUseAdministrativeGroups.Checked := Prefs.UseAdministrativeGroups;
  CheckBoxUseADGroups.Checked := Prefs.UseADGroups;
  CheckBoxUseWindowsUser.Checked := Prefs.UseWindowsUser;

  RadioGroupLocationPressFilterMode.ItemIndex := Prefs.LocationPressFilterMode;

  CheckBoxShowPageNote.Checked := Prefs.ShowPageNoteIndicator;


  CheckBoxXMLPlanAddTimestamp.Checked :=   Prefs.XMLPlanAddTimestampToFileName;
  CheckBoxLimitTowers.Checked := Prefs.LimitTowers;

  writeMainlogfile('Setting - LoadSettingsFromPrefs '+IntToStr(Length(Prefs.StackNamesList)) + ' ' + IntToStr(Length(Prefs.ZoneNamesList))+ ' ' + IntToStr(Length(Prefs.DefMarksList))+ ' ' +IntToStr(Length(Prefs.FilterList)) + ' ' + IntToStr(Length(Prefs.PressTowers)) );
  ListViewStacknames.Items.Clear;
  for i := 0 to Length(Prefs.StackNamesList)-1 do
  Begin
    L := ListViewStacknames.Items.Add;
    L.Caption := Prefs.StackNamesList[i];
  end;

  ListViewZonenames.Items.Clear;
  for i := 0 to Length(Prefs.ZoneNamesList)-1 do
  Begin
    L := ListViewZonenames.Items.Add;
    L.Caption := Prefs.ZoneNamesList[i];
  end;

  ListViewdefmarks.Items.Clear;
  for i := 0 to Length(Prefs.DefMarksList)-1 do
  Begin
    L := ListViewdefmarks.Items.Add;
    L.Caption := Prefs.DefMarksList[i];
  end;

  ListViewFilter.Items.Clear;
  for i := 0 to Length(Prefs.FilterList)-1 do
  Begin
    L := ListViewFilter.Items.Add;
    L.Caption := Prefs.FilterList[i];
  end;

  if Length(Prefs.FilterList) = 0 then
  begin
    L := ListViewFilter.Items.Add;
    L.caption := '*.*';
  end;


  StringGridTowers.RowCount := Length(Prefs.PressTowers);
  for i := 0 to Length(Prefs.PressTowers)-1 do
  Begin
    StringGridTowers.Cells[1,i+1] := Prefs.PressTowers[i].Tower;
    StringGridTowers.Cells[0,i+1] := Prefs.PressTowers[i].Press;
  end;
  StringGridTowers.Cells[0,0] := 'Press';
  StringGridTowers.Cells[1,0] := 'Tower';

  writeMainlogfile('Setting - LoadSettingsFromPrefs 1');

  Minautorefresh  := Prefs.MinAutoRefresh;
  Mintreerefresh  := Prefs.MinTreeRefresh;
  Mindevicefresh  := Prefs.MinDeviceRefresh;

  UpDownautorefresh.Min   := Minautorefresh;
  UpDownnewtreeupdate.Min := Mintreerefresh;

  UpDownautorefresh.Position := Prefs.AutoRefreshSpeed;
  IF UpDownautorefresh.Position < Minautorefresh then
    UpDownautorefresh.Position := Minautorefresh;

  UpDownnewtreeupdate.Min := Mintreerefresh;
  UpDownnewtreeupdate.Position := Prefs.TreeAutoRefreshSpeed;
  IF UpDownnewtreeupdate.Position < Mintreerefresh then
    UpDownnewtreeupdate.Position := Mintreerefresh;

  UpDownupddevcontrol.Min := Mindevicefresh;
  UpDownupddevcontrol.Position := Prefs.DeviceAutoRefreshSpeed;
  IF UpDownupddevcontrol.Position < Mindevicefresh then
    UpDownupddevcontrol.Position := Mindevicefresh;

  EditAutoLoginUser.text := Prefs.AutoLoginUser;
  EditAutoLoginPassword.text := Prefs.AutoLoginPassword;

  CheckBoxautoconsole.checked := Prefs.AutoConsole;
  Editconsolename.text := Prefs.ConsoleName;
  Editmaxconsoleage.text := IntToStr(Prefs.MaxConsoleAge);

  usenewpagina := Prefs.UseConfigurablePagination;
  ComboBoxdefpagina.Visible := usenewpagina;

  localmode := Prefs.LocalMode;

  EditNcols.text := IntToStr(Prefs.NcolsSeparationView);

  CheckBoxtowerorderauto.Checked := Prefs.AutoTowerOrder;
  CheckBoxautologin.Checked := Prefs.AutoLogin;

  Edit2.text := '100';
  Edit1.text := '120';

  CheckBoxdelonlyselon.Checked := Prefs.DeleteOnlyOnSelectedPress;
  formmain.Imageload.Height := StrToInt(Edit2.text);
  formmain.Imageload.Width := StrToInt(Edit1.text);

  EditCustomchecksystemname.Text := Prefs.CustomCheckSystemName;

  CheckBoxUsehoneywell.checked := Prefs.UseHoneywell;
  EditPathtohoneywell.Text := Prefs.PathToHoneywell;
  EditHoneywellpassword.Text := Prefs.HoneywellUsername;
  EditHoneywellusername.Text := Prefs.HoneywellPassword;

  CheckBoxTreeShowPagesReadyFlag.checked := Prefs.TreeShowPagesReadyFlag;
  CheckBoxAlwaysfullTreeExpand.checked := Prefs.AlwaysFullTreeExpand;

  CheckBoxcustomplancheck.checked := Prefs.CustomPlanCheck;
  CheckBoxpagedelete.checked := Prefs.AllowPageDelete;

  CheckBoxswapplatemerger.checked := Prefs.SwapPlateMerger;

  CheckBoxSellallcopiesprod.checked := Prefs.ProductionSelectAllCopies;
  CheckBoxprodreleaseholdallcopy.Checked := Prefs.ProductionReleaseHoldAllCopies;

  CheckBoxDefaultThumbnailOnlyPagePlans.Checked := Prefs.DefaultThumbnailOnlyPagePlans;

  CheckBoxforcereadorder.checked := Prefs.ThumbnailForceReadorder;
  CheckBoxplatedetailof.Checked := Prefs.PlateDetailsOff;

  CheckBoxgraydns.checked := Prefs.GrayDensityMap;
  Editminlogtree.Text :=  IntToStr(Prefs.MinTreeLevelLog);
  CheckBoxdefnochangetmpl.Checked := Prefs.PlanLoadDefaultToNoTemplateChange;
  CheckBoxeditionignorepress.checked := Prefs.EditionUseAsMasterIgnorePress;

  Editunknownpdf.Text := Prefs.UnknownPDFfolder;
  Editarchivepath.Text := Prefs.PDFArchivefolder;
  CheckBoxreimcopies.checked := Prefs.SelectAllCopiesOnReimage;

  CheckBoxSelectAllCopiesOnRelease.checked := Prefs.SelectAllCopiesOnRelease;
  CheckboxClearDeviceOnLayoutChange.checked := Prefs.ClearDeviceOnLayoutChange;

  EditExcludeArchiveFilter.Text := Prefs.ExcludeArchiveFilter;

  CheckBoxEnsurePreviewFormInFront.Checked := Prefs.EnsurePreviewFormInFront;
  CheckBoxLeanAndMeanPreview.Checked := Prefs.LeanAndMeanPreview;

  CheckBoxKeepOutputVersionOnReimage.Checked := Prefs.KeepOutputVersionOnReimage;
  //Indl�s halfweb special setting

  Edit3.Text := IntToStr(Prefs.SpecialHalfwebAtMinPage);
  Edit5.Text := IntToStr(Prefs.SpecialHalfwebAtFixedPage);
  RadioGroupHalfWeb.ItemIndex := Prefs.SpecialHalfwebMode;
  RadioGroupHalfWebClick(TObject(0));

  RadioGroupPlanningPageNameIn.ItemIndex := Prefs.PlanningPageNameIn;

  CheckBoxDecreasever.checked := Prefs.DecreaseVersion;
  CheckBoxadmintab.checked := Prefs.AdminTab;

//  RadioGroupTemaChange.ItemIndex := ini.ReadInteger('System','TemaChange', 0);

  CheckBoxpaginarecalc.checked := Prefs.AllowPaginaRecalculate;

  CheckBoxractivateonlyblack.checked := Prefs.ActivateOnlyBlack;
  RadioGroupTreeorder.itemindex := Prefs.TreeOrder;
  CheckBoxremovemissingcolorsonaprove.Checked := Prefs.RemoveMissingColorsOnApprove;

  CheckBoxreleaseonapproval.Checked := Prefs.ReleaseOnApproval;
  Checkboxreleaseonseprationset.checked := Prefs.ReleaseOnSeparationSet;

  RadioButtonBestfit.Checked := Prefs.ShowPreviewBestfit = 0;
  RadioButton1to1.Checked := Prefs.ShowPreviewBestfit = 1;
  RadioButtonzoomby.Checked := Prefs.ShowPreviewBestfit = 2;

  EditInitzoom.text := IntToStr(Prefs.ShowPreviewInitZoom);

  CheckBoxCustomrel.Checked := Prefs.UseCustomReleaseScript;
  Editreportdateform.Text := Prefs.ReportDateFormat;

  Editmainarchivefolderhighres.Text := Prefs.MainArchiveFolderHighres;
  Editmainarchivefolderlowres.Text := Prefs.MainArchiveFolderLowres;
  EditDefsection.Text := Prefs.AddPressRunDefaultSection;
  CheckBoxAutomultipress.checked := Prefs.ApplyPlanAutoMultiPress;
  CheckBox2nounplanned.checked := Prefs.DefaultShowNoUnplanned;
  CheckBoxPlanLoadPromptForSectionEdition.Checked := Prefs.PlanLoadPromptForSectionEdition;

  CheckBoxOnlySecined.checked := Prefs.EditionViewOnlySecInEd;
  CheckBoxAllowparalelview.Checked := Prefs.AllowParalelView;

  CheckBoxNewPreviewNames.Checked := Prefs.NewPreviewNames;
  CheckBoxpresstimeinplatetree.Checked := Prefs.PressTimeInPlateTree;

  CheckBoxtimedEd.checked := Prefs.AllowTimedEditions;
  ComboBoxdefHardprtype.ItemIndex := Prefs.DefaultHardproofType;
  ComboBoxdefSoftprtype.ItemIndex := Prefs.DefaultSoftproofType;

  RadioGroupplatetreeexp.ItemIndex := Prefs.PlateTreeExpansion;

  CheckBoxdefsoftvait.Checked := Prefs.FlatproofWaitForApproval;
  CheckBoxhardvait.Checked := Prefs.HardproofWaitForApproval;


  CheckBoxIncludeImageOnceState.Checked := Prefs.IncludeImageOnceState;

  RadioGroupdefdatesel.itemindex := Prefs.DefaultDateSelect;
  RadioGroupShowpdfbook.Itemindex := Prefs.ShowPdfBook;

  CheckBoxplatethumb.checked := Prefs.UsePlateviewThumbnails;
  CheckBoxplaninkaliasload.checked := Prefs.PlanInkaliasLoad;
  CheckBoxuknownsendlog.Checked := Prefs.ErrorFileRetrySendLog;

  CheckBoxonlyaplyonunapplied.Checked := Prefs.OnlyApplyOnUnapplied;

  Editminplatenamelength.text := IntToStr(Prefs.MinimumPlatenameLength);
  CheckBoxarchiveenabled.checked := Prefs.ArchiveEnabled;
  CheckBoxdefarchivehighress.checked := Prefs.DefaultArchiveHighres;
  CheckBoxdefarchivelowres.checked := Prefs.DefaultArchiveLowres;

  CheckBoxaddcopydialog.checked := Prefs.ShowAddCopyDialog;

  Editreimextstat.Text := IntToStr(Prefs.ReimageExternalStatus);

  CheckBoxpecomImport.Checked := Prefs.PecomImport;
  CheckBoxtreeonceimaged.checked := Prefs.TreeGreenOnceImaged;
  CheckBoxnewprodsign.Checked := Prefs.ShowNewProductSign;

  CheckBoxusealted.Checked := Prefs.EditionApplyUseAlterntiveEditionFile;
  CheckBoxUseadobereader.checked := Prefs.LoadPdfInPreview;

  CheckBoxplatedeluxe.checked := Prefs.UseExtendedPlateView;

  ComboBoxpressreqlevel.ItemIndex := Prefs.PressDataRequestLevel;
  CheckBoxpressspecreq.Checked := Prefs.PressDataRequestPressSpecific;
  CheckboxTreeShowPrepollEvents.Checked := Prefs.TreeShowPrepollEvents;

  RadioGrouptimedrules.ItemIndex := Prefs.TimedEditionRule;
  CheckBoxinsertsheetnumbersfor1up.Checked := Prefs.InsertSheetNumbersFor1up;
  RadioGroupplatedonestat.itemindex := Prefs.PlateDoneStatisticsMode;
  CheckBoxAlwaysUseOffset0OnApply.Checked := Prefs.AlwaysUseOffset0OnApply;
  CheckBoxnotreelamps.Checked := Prefs.NoTreeLamps;
  CheckBoxplatehidecopy.checked := Prefs.HidePlateCopyBar;
  CheckBoxlogdelete.checked := Prefs.LogDeleteActions;
  CheckBoxlogplanning.checked := Prefs.LogPlanningActions;
  CheckBoxautomasked.checked := Prefs.AutoShowMasked;
  CheckBoxrecombatunapply.Checked := Prefs.RecombineOnUnapply;


  CheckBoxTreeShowWeeknumberAlso.Checked := Prefs.TreeShowWeekNumberInfo;


  CheckBoxPartialNoEdChange.Checked := Prefs.PartialNoEditionChange;
  CheckBoxPartialNoSecChange.Checked := Prefs.PartialNoSecionChange;

  //CheckBoxshowpressfilters.Checked := Prefs.ShowPressFilters;
  CheckBoxtreedayname.Checked := Prefs.TreeShowDayName;
  CheckBoxignorenetuse.checked := Prefs.IgnoreNetUseCommand;
  CheckBoxplanapproval.checked := Prefs.DefaultToApprovalRequired;

  CheckBoxPlatenothumbrot.checked := Prefs.PlateNoThumbnailRotation;

  EditHighplate.Text := Prefs.PressHighPlateName;
  Editlowplate.Text := Prefs.PressLowPlateName;

  Editplannedpagenamedata.Text := Prefs.PlannedPageNameDataFile;

  CheckBoxplatenamerecount.Checked := Prefs.PlateNameRestartOnEachRun;

  CheckBoxinkpresspath.checked := Prefs.UsePressSpecificInkRegenPath;
  NyFileInfosize := Prefs.FileInfoBufferSize;

  CheckBoxsecInpressruncom.Checked := Prefs.SetSecionNamesInPressrunComment;
  CheckBoxUseFileCenterTiffArchive.Checked := Prefs.UseFileCenterTiffArchive;
  CheckBoxFastTree.Checked := Prefs.SynchronizedTreeUpdate;

  CheckBoxArkenabled.Checked := Prefs.EnableArchive;
  CheckBoxPdfunknown.Checked := Prefs.ShowPdfUnknownFiles;

  CheckBoxMultiPressTemplateLoad.Checked := Prefs.UseMultiPressTemplateLoad;

//  RadioGrouppresssystem.ItemIndex := Prefs.PressGroupSystem;

  CheckBoxsplit1upruns.checked := Prefs.Split1UpRuns;

  CheckBoxtextongrp.checked := Prefs.TextOnReportGraph;

  CheckBoxwebver.Checked := Prefs.UseWebFileNameWithVersion;
  Webfileverion := Integer(CheckBoxwebver.Checked);

  if Editmainarchivefolderhighres.Text = '' then
    CheckBoxarchiveenabled.checked := false;

  CheckBoxOverruleretransmit.Checked := Prefs.RestrictRetransmit;

  CheckBoxAllowPageMove.Checked :=  Prefs.AllowMovePages;

  RadioGroupstartupsize.ItemIndex := Prefs.StartupWindowsSize;
  CheckBoxplateshowextstat.Checked := Prefs.PlateShowExternalStatus;

  Edithighresarch.Text := Prefs.ArchiveHigresFilenameDefinition;

  CheckBoxdefaultautomateplanname.Checked := Prefs.DefaultAutomatePlanname;
  CheckBoxplanclearsections.Checked := Prefs.PlanClearSections;
  CheckBoxusetruesheetside.Checked := Prefs.UseTrueSheetSide;

  CheckBoxShowInkDensityInformation.Checked := Prefs.ShowInkDensityInformation;
  CheckBoxShowSizeInformation.Checked := Prefs.ShowSizeInformation;

  CheckBoxAllowDropFilesDeleteAfterCopy.Checked := Prefs.AllowDropFilesDeleteAfterCopy;

  CheckBoxDeviceControlOnlyAdmins.Checked := Prefs.DeviceControlOnlyAdmins;

  CheckBoxCheckPlanningPageFormat.Checked := Prefs.PlanningPageFormat;
  CheckBoxCheckPlanningRipSetup.Checked := Prefs.PlanningRipSetup;
   writeMainlogfile('Setting - LoadSettingsFromPrefs 2');
  for i := 0 to min(CheckListBoxSectionText.Items.Count, Length(Prefs.SectionText))-1 do
    CheckListBoxSectionText.Checked[i] := Prefs.SectionText[i];

  for i := 0 to min(CheckListBoxthumbstatbar.Items.Count, Length(Prefs.ThumbnailStatusBar))-1 do
  begin
    CheckListBoxthumbstatbar.Items[i] := Prefs.ThumbnailStatusBar[i].Name;
    CheckListBoxthumbstatbar.Checked[i] := Prefs.ThumbnailStatusBar[i].Enabled;
  end;

  CheckBoxautoflatproof.Checked := Prefs.AutoFlatProof;
  CheckBoxenablespecifiksel.Checked := Prefs.EnablePressSpecificSelection;

  CheckBoxnewinkregen.Checked := Prefs.NewInkRegeneration;
  CheckBoxautoreimondevch.Checked := Prefs.AutoReImageOnDeviceChange;
  CheckBoxApplyonlyplannedcolors.Checked := Prefs.ApplyOnlyPlannedColors;
  CheckBoxForcesamedev.Checked := Prefs.ForceSameDevice;
  Editdefaultsavepagelistfile.Text := Prefs.DefaultSavePageListFile;

  CheckBoxmanualplanning.Checked := Prefs.AllowManualPlanning;

  RadioButtonload.Checked := not Prefs.UnplannedApplyDefaultMethodToWizard;
  RadioButtonwizard.Checked := Prefs.UnplannedApplyDefaultMethodToWizard;

  CheckBoxsmootplateautorefresh.Checked := Prefs.SmoothPlateAutoRefresh;
  ComboBoxZoomfilter.ItemIndex := Prefs.PreviewZoomfilter;

  CheckBoxprodshoworder.Checked := Prefs.ProductionViewShowOrder;
  CheckBoxorderintopcap.Checked := Prefs.PlateviewOrderInCaption;
  CheckBoxgtoneedapr.checked := Prefs.PreviewGoToNeedApproval;
  CheckBoxlayoutanaki.Checked := Prefs.AllowSelectionOfAnyLayout;
  CheckBoxmanhw.Checked := Prefs.PlanningAllowManualHalfWebOverride;

  CheckBoxplanhold.Checked := Prefs.DefaultPlanHold;
  CheckBoxshowallgraphtime.checked := Prefs.ReportShowAllGraphTime;
  CheckBoxdefaultPDF.Checked := Prefs.PlanningDefaultPDF;
  CheckBoxCustomtowerrnames.Checked := Prefs.UseCustomTowerNames;

  UpDownnewautoexp.Position := Prefs.TreeAutoExpandLevel;
  CheckBoxUseDBtowernames.Checked := Prefs.UseDBTowerNames;

  CheckBoxPlanrepair.Checked := Prefs.PlanRepair;
  writeMainlogfile('Setting - LoadSettingsFromPrefs 3');
  for i:=0 to min(CheckListBoxextrafiltertext.Items.Count, Length(Prefs.TreeExtraPublicationText))-1 do
    CheckListBoxextrafiltertext.Checked[i] := Prefs.TreeExtraPublicationText[i];

  CheckBoxDefplaninserted.checked := Prefs.PlanningDefaultInserted;
  CheckBoxdefaultshowplatedetails.Checked := Prefs.DefaultShowPlateDetails;

  CheckBoxAutorefreshon.Checked := Prefs.AutoRefreshOn;

  CheckBoxDongA.Checked := Prefs.DongAInkVisible;
  CheckBoxlogapprove.Checked := Prefs.LogApproval;
  CheckBoxlogdisapprove.Checked := Prefs.LogDisapproval;

  CheckBoxloghold.Checked := Prefs.LogHold;

  CheckBoxlogrelease.Checked := Prefs.LogRelease;

  CheckBoxplateshowripsystem.Checked := Prefs.PlateviewShowRipSystem;
  CheckBoxKeeptreeexpantion.Checked := Prefs.KeepTreeExpansion;

  CheckBoxShowWeekNr.Checked := Prefs.ShowWeekNumberInTree;

  CheckBoxreselectthumb.Checked := Prefs.ReselectThumbnails;
  CheckBoxreselectplates.Checked := Prefs.ReselectPlates;

  RadioGroupSendemail.ItemIndex := Prefs.SendEmailMode;
  Editemailserver.Text := Prefs.EmailServer;
  Editemailadress.Text := Prefs.EmailFromAddress;
  ComboBoxSepSEP.Text := Prefs.CommaSeparatorChar;

  Editdefaultdevice.Text := Prefs.DefaultDevice;
  CheckBoxusedefaultdevice.Checked := Prefs.UseDefaultDevice;
  CheckBoxplatenames.Checked := Prefs.PlanningGeneratePlateNames;

  CheckBoxSPPressrunexec.Checked := Prefs.PostPlanSPPressrunExecute;
  CheckBoxSPPressrunexec2.Checked := Prefs.PostPlanSPPressrunExecute2;
  CheckBoxSPProductionexec.Checked := Prefs.PostPlanSPProductionExecute;

  CheckBoxApplyDoPostProductionProcedure.Checked :=  Prefs.ApplyDoPostProductionProcedure;
  CheckBoxApplyDoPostPressRunProcedure.Checked := Prefs.ApplyDoPostPressRunProcedure;



  CheckBoxAllowPdfRotation.Checked := Prefs.ThumbnailsAllowPdfRotation;

  CheckBoxgenrepwhendel.Checked := Prefs.GenerateReportWhenDeleting;

//  CheckBoxalllocations.Checked := Prefs.ShowAllLocations;
  CheckBoxclearpublonload.Checked := Prefs.PlanningClearPubliationsOnLoad;
  CheckBoxSimplePlanLoad.Checked := Prefs.SimplePlanLoad;


  CheckboxRestrictUniqueDelete.Checked :=  Prefs.RestrictUniqueDelete;

  ComboBoxlocations.Items.Clear;
  ComboBoxlocations.Items := tnames1.locationnames;
  if (Prefs.DefaultLocation <> '') then
    ComboBoxlocations.ItemIndex := ComboBoxlocations.Items.IndexOf(Prefs.DefaultLocation)
  else
    ComboBoxlocations.ItemIndex := 0;

  ComboBoxDefaultPress.Items.Clear;
  ComboBoxDefaultPress.Items := tnames1.pressnames;

  if (PressGroupNamesPossible) then
  begin
      Datam1.Query3.SQL.Clear;
      Datam1.Query3.SQL.Add('SELECT DISTINCT PressGroupName FROM PressGroupNames');
      Datam1.Query3.SQL.Add('ORDER BY PressGroupName');
      Datam1.Query3.Open;
      while not Datam1.Query3.Eof do
      begin
        t := Datam1.Query3.Fields[0].AsString;
        if ComboBoxDefaultPress.Items.IndexOf(t) < 0 then
          ComboBoxDefaultPress.Items.Add(t);
        Datam1.Query3.Next;
      end;
      Datam1.Query3.Close;
  end;

  if (Prefs.DefaultPress <> '') then
    ComboBoxDefaultPress.ItemIndex := ComboBoxDefaultPress.Items.IndexOf(Prefs.DefaultPress)
  else
    ComboBoxDefaultPress.ItemIndex := 0;


  Editcustomdelcomdest.Text := Prefs.CustomXMLReportOutputFolder;
  CheckBoxcontroldev.Checked := Prefs.AllowControlDevices;

  for i:=0 to min(CheckListBoxEditionText.Items.Count, Length(Prefs.TreeExtraEditionText))-1 do
    CheckListBoxEditionText.Checked[i] := Prefs.TreeExtraEditionText[i];

  ReportTimeOut.Text := IntToStr(Prefs.ReportTimeOut);
  ReportSaveFolder.Text := Prefs.ReportSaveFolder;
  ReportOnProductionDeleteEmail.Checked := Prefs.ReportOnProductionDeleteSendEmail;
  EmailUsePublicationSpecificMail.Checked := Prefs.EmailUsePublicationSpecificMail;

  MailFrom.Text := Prefs.MailFrom;
  MailTo.Text := Prefs.MailTo;
  MailCC.Text := Prefs.MailCC;
  MailSubject.Text := Prefs.MailSubject;

  CheckBoxnocommonplates.Checked := Prefs.HideCommonPlates;
  UpDowndropdownfilter.Position := Prefs.UnknownFilesFileNameLengthMatch;
  CheckBoxsuperall.Checked := Prefs.SuperUserMaySeeAll;
  CheckBoxnewdelsys.Checked := Prefs.NewProductDeleteSystem;

//  CheckBoxautosetNedonload.Checked := ini.Readbool('System','CheckBoxautosetNedonload',CheckBoxautosetNedonload.Checked);

  EditCustomplanexportfilename.Text := Prefs.CustomPlanExportFilenameDefinition;
  CheckBoxprodshowRipsetup.Checked := Prefs.ProductionShowRipSetup;
  CheckBoxplanexport.Checked := Prefs.PlanningExportXMLPlan;;
  CheckBoxSEPHEader.Checked := Prefs.PageListExportIncludeHeaders;
  CheckBoxreimhighpri.Checked := Prefs.ReimageWithHighPriority;

  EditPlateminlevel.Text := IntToStr(Prefs.PlateTreeMinLevel);

  ComboBoxdayofweek.ItemIndex := Prefs.DayOfWeek;
  ComboBoxgraphtimeformat.Text := Prefs.GraphTimeFormat;
  CheckBoxseponreadview.Checked := Prefs.PreviewSeparationsOnReadview;

  CheckBoxemailasuser.checked := Prefs.EmailLoginNameAsSenderName;

  Editsendername.Text := Prefs.EmailSenderName;

  Editemailtitle.Text := Prefs.EmailTitleDefinition;

  CheckBoxlocaltimeset.checked := Prefs.SeparationsUseLocaleTimeFormat;

  Editlistime.Text := Prefs.SeparationTimeFormat;

  CheckBoxplatefont.Checked := Prefs.PlateviewBoldFont;

  CheckBoxPrevcomment.checked := Prefs.PreviewCommentAsCaption;

  Editemailpagename.Text := Prefs.EmailPagenameDefinition;

  Editaltpagenamefield.Text := Prefs.AlternativePageNameField;
  EditAltSheet.Text := Prefs.AlternativeSheetnameField;
  CheckBoxApplyPlateMerge.Checked := Prefs.AllowApplyPlateMerge;
  CheckBoxDefaultHidePagePlans.Checked := Prefs.DefaultHidePagePlans;

  CheckBoxshowreimgediaglog.Checked := Prefs.ShowReimgeDialog;

  CheckBoxThsingleedrelease.Checked := Prefs.ThumbnailsSingleEditionRelease;
  CheckBoxCheckJpgTag.checked := Prefs.CheckJpegTag;
  CheckboxNewCCFilesNames.checked := Prefs.NewCCFilesNames;
  CheckBoxAllowInkfileRegenerate.checked := Prefs.AllowInkfileRegenerate;

  EditZoomstep.text := IntToStr(Prefs.PreviewZoomStep);
  EditMinzoom.text := IntToStr(Prefs.PreviewMinzoom);
  EditMaxzoom.text := IntToStr(Prefs.PreviewMaxzoom);
 // EditMinzoom.text := '10';
 // EditMaxzoom.text := '200';

  CheckBoxnewinkresend.Checked := Prefs.DatabaseQueueInkResend;
  CheckBoxShowPressTime.Checked := Prefs.ProductionShowPressTime;
  CheckBoxSeparateNodesPerPressrun.Checked := Prefs.SeparateNodesPerPressrun;

  ComboBoxStartupTab.ItemIndex := Prefs.StartupTab;
  CheckBoxsetcommentonfalsespreads.Checked := Prefs.SetCommentOnFalseSpreads;

  CheckBoxOrstacks.Checked := Prefs.OrStackpositionsTogether;

  RadioGroupemailimageformat.ItemIndex := Prefs.EmailImageFormat;
  CheckBoxplannameintree.Checked := Prefs.ShowPlannameInTree;

  nodeldebug := Prefs.NoProductionDeleteDebug;


  CheckBoxcustforcetoaplied.checked := Prefs.ForcePlanToApplied;
  CheckBoxpregenreadview.checked := Prefs.UseGeneratedReadViews;
  CheckBoxusepresstowerinfo.checked := Prefs.UseDatabasePressTowerInfo;
  CheckBoxbackwards.checked := Prefs.PlanningDefaultBackwardNumbering;

  Editminthumblevel.Text := IntToStr(Prefs.ThumbnailTreeMinimumLevel);
  if StrToInt(Editminthumblevel.Text) < 2 then
    Editminthumblevel.Text := '2';

  RadioGroupthumbnailsize.ItemIndex := Prefs.ThumbnailSize;;
  Editdeadlockdealay.Text := IntToStr(Prefs.DeadlockDelay);

  CheckBoxdataonplate.Checked := Prefs.ShowDataOnPlateThumbnails;

  CheckBoxreimage.Checked := Prefs.ShowReimageDialog;

  CheckBoxreimdevicereset.Checked := Prefs.ResetDeviceOnReimage;
  CheckBoxreimcolors.Checked := Prefs.ReimageAllColors;

  CheckBoxnewplatedata.Checked := Prefs.NewPlateDataSystem;
  Editminpagetreelevel.Text := IntToStr(Prefs.SeparationMinTreeLevel);
  if StrToInt(Editminpagetreelevel.text) < 2 then
    Editminpagetreelevel.Text := '2';

  UpDown15.Position := Prefs.ProductionMinTreeLevel;
  Editminprodtreelevel.Text := IntToStr(Prefs.ProductionMinTreeLevel);

  CheckBoxuseimportcenter.Checked := Prefs.PlanningUseImportCenter;
  Editimportcenterinputpath.Text := Prefs.ImportCenterInputPath;;
  Editimportcentererrorpath.Text := Prefs.ImportCenterErrorPath;;
  Editimportcenterdonepath.Text := Prefs.ImportCenterDonePath;;

  CheckBoxthumbpagechangesonsubeditions.Checked := Prefs.ThumbnailMakeChangesOnSubeditions;

  CheckBoxShowsidebar.Checked := Prefs.PreviewShowSidebar;
  Editsidebarwidth.Text := IntToStr(Prefs.PreviewSidebarWidth);
  Editsidebarheight.Text := IntToStr(Prefs.PreviewSidebarHeight);

  CheckBoxmustsetdev.Checked := Prefs.MustSetDeviceOnRelease;
  CheckBoxpregendns.Checked := Prefs.PreviewUsePregeneratedDns;;

  CheckBoxerrorfileretry.Checked := Prefs.PlanningErrorFilesRetry;
  CheckBoxreselectpages.Checked := Prefs.SeparationsReselectPages;

  CheckBoxpageprevseps.Checked := Prefs.PreviewPreloadSeparations;
  CheckBoxpageprevlevel.Checked := Prefs.PreviewPreloadDns;
  CheckBoxplateprevseps.Checked := Prefs.PreviewPreloadPlateSeparations;

  CheckBoxplateprevlevel.Checked := Prefs.PreviewPreloadPlateDns;
  CheckBoxplateprevZones.Checked := Prefs.PreviewPreloadInkzones;
  CheckBoxNologin.checked := Prefs.NoLoginPrompt;;

  CheckBoxAllowunplannedcolors.Checked := Prefs.PlanningAllowUnplannedColors;

  RadioGroupreleaserulebase.itemindex := Prefs.ReleaseRuleBasedOn;

  UpDowninklimit.Position := Prefs.InkWarningLevel;
  UpDownAutoscroolspeed.Position := Prefs.AutoScrollspeed;;

  CheckBoxpagename.Checked := Prefs.UsePageIndexForSorting;
  UpDownVisiblecols.Position := Prefs.SeparationsVisibleColumns;

  CheckBoxOnlyselection.Checked := Prefs.SeparationsExportOnlySelectedRows;;
  CheckBoxallmarkgroups.Checked := Prefs.PlanningDefaultUseAllMarkGroups;
  CheckBoxhideprogthumb.Checked := Prefs.PlateHideNamesOnThumbnails;
  CheckBoxdefaultK.Checked := Prefs.PlanningDefaultToMono;

  CheckBoxusepublicationdefaults.Checked := Prefs.PlanningUsePublicationDefaults;
  CheckBoxpagesshowall.Checked := Prefs.SeparationsAllowShowAllPublications;

  CheckBoxplateReimondevch.Checked := Prefs.PlatesAutoReimageOnDeviceChange;

  CheckBoxplatepagepreview.Checked := Prefs.PlatesAllowSinglePagePreview;

  Editexternedittif.Text := Prefs.ExternalTiffEditorPath;
  Editexterneditpdf.Text := Prefs.ExternalPDFEditorPath;

  CheckBoxnewtreeload.Checked := Prefs.TreeUseTreeUpdateTable;

  CheckBoxthumbshowmono.Checked := Prefs.ThumbnailsShowMonoPDFIndicator;

  RadioGroupdefaultpagetypeaddedition.ItemIndex := Prefs.AddEditionDefaultUniqueType;
  RadioGroupdefaultUniqePaddedition.ItemIndex := Prefs.AddEditionDefaultApprovalUniquePage;

  RadioGroupdefaultCommonPaddedition.ItemIndex := Prefs.AddEditionDefaultApprovalCommonPage;
  RadioGroupdefaultDeviceaddedition.ItemIndex := Prefs.AddEditionDefaultKeepDevice;
  RadioGroupdefaultHoldaddedition.ItemIndex := Prefs.AddEditionDefaultHold;

  CheckBoxShowpitstoplog.Checked := Prefs.ThumbnailShowPitstopLog;

CheckBoxSetReleaseNowOnReimage.Checked := Prefs.SetReleaseNowOnReimage;

  CheckBoxShowPanelUnknown.Checked := Prefs.ShowPanelUnknownFiles;;
  EditCheckTimeUnknown.Text := IntToStr(Prefs.ShowPanelUnknownFilesRefreshTime);
  Editdefaultfirsted.Text := Prefs.PlanningDefaultFirstEdition;

  NewlineInthumb1.Enabled := true;
  for i := 0 to min(CheckListBoxthumbtext.Items.Count, Length(Prefs.ThumbnailCaptionText))-1 do
  begin
    CheckListBoxthumbtext.Items[i] := Prefs.ThumbnailCaptionText[i].Name;
    CheckListBoxthumbtext.Checked[i] := Prefs.ThumbnailCaptionText[i].Enabled;
    T := CheckListBoxthumbtext.items[i];
    if T[length(T)] <> '#' then
      NewlineInthumb1.Enabled := false;
  end;

  Showthowthumbgrps := false;
  for i := 0 to min(CheckListBoxthgroupecap.Items.Count, Length(Prefs.ThumbnailGroupCaptionText))-1 do
  begin
    CheckListBoxthgroupecap.Items[i] := Prefs.ThumbnailGroupCaptionText[i].Name;
    CheckListBoxthgroupecap.Checked[i] := Prefs.ThumbnailGroupCaptionText[i].Enabled;
    if CheckListBoxthgroupecap.Checked[i] then
      Showthowthumbgrps := true;
  end;

  ValueListEditortowerfilters.Strings.Clear;
  for i := 0 to Length(Prefs.TowerNameTranslation)-1 do
    ValueListEditortowerfilters.InsertRow(Prefs.TowerNameTranslation[i].Key,Prefs.TowerNameTranslation[i].Value, True);

  CheckListBoxMiscedit.Checked[0] := Prefs.EnableEditOfMiscString2;
  CheckListBoxMiscedit.Checked[1] := Prefs.EnableEditOfMiscString3;
  CheckListBoxMiscedit.Checked[2] := Prefs.EnableEditOfMiscInt2;
  CheckListBoxMiscedit.Checked[3] := Prefs.EnableEditOfMiscInt3;

  for i := 0 to min(CheckListBoxreleaserules.Items.Count, Length(Prefs.ReleaseRules))-1 do
    CheckListBoxreleaserules.Checked[i] := Prefs.ReleaseRules[i];

  for i := 0 to min(CheckListBoxPlatetext.Items.Count, Length(Prefs.PlateText))-1 do
  begin
    CheckListBoxPlatetext.Items[i] := Prefs.PlateText[i].Name;
    CheckListBoxPlatetext.checked[i] := Prefs.PlateText[i].Enabled;
  end;

  for i := 0 to min(CheckListBoxpressruntexts.Items.Count, Length(Prefs.PressRunTexts))-1 do
  begin
    CheckListBoxpressruntexts.Items[i] :=   Prefs.PressRunTexts[i].Name;
    CheckListBoxpressruntexts.checked[i] := Prefs.PressRunTexts[i].Enabled;
  end;


  for i := 0 to min(StringGridprods.ColCount, Length(Prefs.ProductionColumns))-1 do
  begin
    StringGridprods.ColWidths[i] := Prefs.ProductionColumns[i].Width;
    StringGridprods.Cells[i, 0] := Prefs.ProductionColumns[i].ColumnName;

    CheckListbox1.Items[i] := Prefs.ProductionColumns[i].ColumnName;
    CheckListbox1.Checked[i] :=  Prefs.ProductionColumns[i].Visible;
  end;

  for i := 0 to min(CheckListBoxplatecaption.Items.Count, Length(Prefs.PlateCaptionText))-1 do
  begin
    CheckListBoxplatecaption.Items[i] := Prefs.PlateCaptionText[i].Name;
    CheckListBoxplatecaption.Checked[i] :=  Prefs.PlateCaptionText[i].Enabled;
  end;

  CheckBoxautosetedonload.Checked := Prefs.PlanningAutoSetEditionsOnLoad;
  CheckBoxpreparetrans.Checked := Prefs.PlateTransmissionSystem;
  CheckBoxapprovetimeonrelease.Checked := Prefs.SetApproveTimeOnRelease;
  CheckBoxAutoplannumbergen.Checked := Prefs.PlanningAutoOrderNumberBergen;
  CheckBoxdefaultsetcomed.Checked := Prefs.SetCommentOnAllEditions;

  CheckBoxruntrhoughpagina.Checked := Prefs.PlanningRunThroughPagination;
  CheckBoxCommenttime.Checked := Prefs.AddTimeToPageComment;

  ComboBoxreportdetailsave.Text := Prefs.ReportSeparator;
  EditDeafaultreportfolder.Text := Prefs.DefaultReportFolder;
  CheckBoxExcelSaveToFolder.Checked := Prefs.DefaultSaveToLocalFolder;

  formmain.SaveDialogreportdetails.InitialDir := EditDeafaultreportfolder.text;
  formmain.SaveDialogsavetextreport.InitialDir := EditDeafaultreportfolder.text;
  formmain.SaveDialogreport.InitialDir := EditDeafaultreportfolder.text;

  EditCustomplanexportdest.text := Prefs.PlanXMLExportFolder;

  CheckBoxExclusive.Checked := Prefs.UsePlanLock;
  ComboBoxcolorproof.Text := Prefs.PlanningDefaultColorProofer;
  ComboBoxpdfproof.Text := Prefs.PlanningDefaultPDFProofer;
  ComboBoxBWproof.Text := Prefs.PlanningDefatulMonoProofer;

  ComboBoxdefpagina.ItemIndex := Prefs.PlanningPaginationMode;
  if not usenewpagina then
    ComboBoxdefpagina.ItemIndex := 0;

  CheckBoxsavereportdetailcolumns.Checked := Prefs.ReportIncludeHeaders;
  CheckBoxthumbshowhold.Checked := Prefs.ThumnailsShowHold;

  ColorBoxMenuToolbar.ItemIndex := ColorBoxMenuToolbar.Items.IndexOf(Prefs.MenuToolbarColor);
  ColorBoxToolbar.ItemIndex := ColorBoxToolbar.Items.IndexOf(Prefs.ToolbarColor);
  ColorBoxToolbarSel.ItemIndex := ColorBoxToolbarSel.Items.IndexOf(Prefs.ToolbarSelectedColor);
  CheckBoxunknowncheck.Checked := Prefs.CheckForUnknownFilesTimer;
  Editunknowndropdownfilter.Text :=  IntToStr(Prefs.CheckForUnknownFilesTimerInterval);

  CheckBoxpagefullautorefresh.Checked := Prefs.SeparationsFullAutorefresh;
  CheckBoxlistredevatreim.Checked := Prefs.SeparationsResetDeviceOnReimage;

  CheckBoxpageicons.Checked :=Prefs.SeparationsShowStatusIcons;

  CheckBoxthumbshowextstat.checked := Prefs.ThumbnailsShowExternalStatus;

  CheckBoxshowdevcontrol.Checked := Prefs.ShowDeviceControl;
  CheckBoxpressindevcontrol.Checked := Prefs.DeviceControlUsePressDevices;

  CheckBoxtreebyedid.Checked := Prefs.TreeOrderByEditionID;
  CheckBoxAllowfalsespret.Checked := Prefs.ThumbnailAllowSetFalseSpread;
  CheckBoxstatresetonpagetypechange.Checked := Prefs.ThumbnailResetStatusOnPageTypeChange;

  CheckBoxShowtemplateincaption.Checked := Prefs.PlatesShowTemplateInCaption;

  CheckBoxforcewhencommon.Checked := Prefs.EditionsSetForceWhenCommon;

  CheckBoxAllowDropFiles.Checked := Prefs.AllowDropFiles;
  CheckBoxAllowDropFilesDialog.Checked := Prefs.AllowDropFilesDialog;
  EditDropFilesDestination.Text := Prefs.DropFilesDestination;

  CheckBoxShowInkZones.checked := Prefs.PreviewShowInkZones;
  CheckBoxPlanpri.checked := Prefs.PlanningUsePublicationDefaultlPriority;

  CheckBoxplatespecialstanding.Checked := Prefs.PlatesShowPagesStanding;

  CheckBoxpublfilreonproddate.Checked := Prefs.TreeFilterOnProductionDate;
  CheckBoxplateprtsecpage.Checked := Prefs.PlatePrintoutUseSectionPage;

  CheckBoxhttimedeadline.Checked := Prefs.PlanningHotTimeFromDeadline;
  Edithottimehours.Text := IntToStr(Prefs.PlanningHotTimeFromDeadlineAddHours);

  CheckBoxUseNiceManualStacker.Checked := Prefs.CustomManualStackerSet;

  CheckboxTreeShowAliasFirst.Checked := Prefs.TreeShowAliasFirst;

  for i := 0 to min(ListBoxthumborder.Items.Count, Length(Prefs.ThumbnailSortingOrder))-1 do
    ListBoxthumborder.Items[i] := Prefs.ThumbnailSortingOrder[i];

  for i := 0 to min(CheckListBoxAFoldername.Items.Count, Length(Prefs.ArchiveFolderNameDefinitions))-1 do
    CheckListBoxAFoldername.Checked[i] := Prefs.ArchiveFolderNameDefinitions[i];

  Editlowarch.text := Prefs.ArchiveLowResNameDefinition;
  Editarchdate.text := Prefs.ArchiveLowResDateDefinition;

  for i := 0 to min(CheckListBoxThumbevents.Items.Count, Length(Prefs.ThumbnailEvents))-1 do
    CheckListBoxThumbevents.Checked[i] := Prefs.ThumbnailEvents[i].Enabled;

//  CheckBoxshowallfilter.Checked := Prefs.TreeShowAllLocationOption;
      writeMainlogfile('Setting - LoadSettingsFromPrefs ');
  for i := 0 to min(CheckListBoxdetailsavecols.Items.Count, Length(Prefs.SeparationsReportColumns))-1 do
    CheckListBoxdetailsavecols.Checked[i] := Prefs.SeparationsReportColumns[i];

  for i := 0 to min(CheckListBoxPLtPrnttitle.Items.Count, Length(Prefs.PlatePrintListTitleDefinition))-1 do
    CheckListBoxPLtPrnttitle.Checked[i] := Prefs.PlatePrintListTitleDefinition[i];

  for i := 0 to min(CheckListBoxPLtPrntplate.Items.Count, Length(Prefs.PlatePrintListPlateDefinition))-1 do
    CheckListBoxPLtPrntplate.Checked[i] := Prefs.PlatePrintListPlateDefinition[i];

  for i := 0 to min(MemoShortevent.Lines.Count, Length(Prefs.PrePollEventNames))-1 do
    MemoShortevent.Lines[i] := Prefs.PrePollEventNames[i];

  for i := 0 to Prefs.PRODUCTIONCOLUMNCOUNT-1 do
  begin
    Prodgridfonts[i].name := Prefs.ProductionGridFonts[i].name;
    Prodgridfonts[i].Style := Prefs.ProductionGridFonts[i].Style;
    Prodgridfonts[i].Size := Prefs.ProductionGridFonts[i].Size;
  end;

  ListViewplannamedstyles.Items.Clear;
  for i := 0 to Length(Prefs.PlannedNameDefinitions)-1 do
  begin
    l := ListViewplannamedstyles.Items.Add;
    l.Caption := Prefs.PlannedNameDefinitions[i].Name;
    l.SubItems.Add(Prefs.PlannedNameDefinitions[i].Format);
    l.SubItems.Add(Prefs.PlannedNameDefinitions[i].Dateformat);
    if (Prefs.PlannedNameDefinitions[i].Enabled) then
      ListViewplannamedstyles.Items[i].Checked := true;
  end;

  UpDownhothours.Position := Prefs.HotHourPriorityDifference;
  UpDownhotlength.Position := Prefs.HotHourPriorityLength;
  UpDownhotbefore.Position := Prefs.HotHourPriorityBefore;
  UpDownhotunder.Position := Prefs.HotHourPriorityDuring;
  UpDownhotafter.Position := Prefs.HotHourPriorityAfter;;

  CheckListBoxvisiblepressesConfig.Items.Clear;
  for i := 0 to  Length(Prefs.VisiblePressesConfig)-1 do
  begin
     CheckListBoxvisiblepressesConfig.Items.Add(Prefs.VisiblePressesConfig[i].Press);
     CheckListBoxvisiblepressesConfig.Checked[i] := Prefs.VisiblePressesConfig[i].Visible;
  end;

  CheckListBoxvisibletowers.Items.Clear;
  if Length(Prefs.VisibleTowers) > 0 then
  begin
    for i := 0 to Length(Prefs.VisibleTowers) -1 do
    begin
      CheckListBoxvisibletowers.Items.Add(Prefs.VisibleTowers[i].Tower);
      CheckListBoxvisibletowers.Checked[i] :=  Prefs.VisibleTowers[i].Visible;
    end;
  end;
  CheckListBoxdefunknown.Items.Clear;
  CheckListBoxdefunknown.Items.Add('Show all folders');
  for i := 0 to Length(Prefs.DefaultUnknownFilesFolders) -1 do
  begin
    CheckListBoxdefunknown.Items.Add(Prefs.DefaultUnknownFilesFolders[i].Name);
    CheckListBoxdefunknown.Checked[i+1] :=  Prefs.DefaultUnknownFilesFolders[i].Enabled;
  end;

  ValueListEditormaxpagepress.Strings.Clear;
  for i := 0 to Length(Prefs.MaxPagesPerPress)-1 do
    ValueListEditormaxpagepress.Strings.Add(Prefs.MaxPagesPerPress[i].Key+'='+Prefs.MaxPagesPerPress[i].Value);

  ValueListEditorOldInk.Strings.Clear;
  for i := 0 to Length(Prefs.OldInkPathsPerPress)-1 do
    ValueListEditorOldInk.Strings.Add(Prefs.OldInkPathsPerPress[i].Key+'='+Prefs.OldInkPathsPerPress[i].Value);

  ValueListEditorInkGen.Strings.Clear;
  for i := 0 to Length(Prefs.InkGenerationSystemPerPress)-1 do
  begin
    ValueListEditorInkGen.Strings.Add(Prefs.InkGenerationSystemPerPress[i].Key+'='+Prefs.InkGenerationSystemPerPress[i].Value);
    ValueListEditorInkGen.ItemProps[i].EditStyle := esPickList;
    ValueListEditorInkGen.ItemProps[i].PickList := ListBoxInpresettypes.Items;
    ValueListEditorInkGen.ItemProps[i].ReadOnly := true;
  end;

  ValueListEditorCyl.Strings.Clear;
  for i := 0 to Length(Prefs.CylinderNameTranslation)-1 do
    ValueListEditorCyl.Strings.Add(Prefs.CylinderNameTranslation[i].Key+'='+Prefs.CylinderNameTranslation[i].Value);

  ListVieweventlogs.Items.Clear;
  for i:=0 to Length(Prefs.EventLogs)-1 do
  begin
    L := ListVieweventlogs.Items.Add;
    L.Caption := Prefs.EventLogs[i].Name;
    L.subitems.Add(IntToStr(Prefs.EventLogs[i].Number));
    L.Checked := Prefs.EventLogs[i].Enabled;
  end;

  IF (Prefs.Language <> aktlang) or (ComboBoxlanguage.Text = '' ) or (ComboBoxlanguage.ItemIndex < 0) then
  begin
    ComboBoxlanguage.ItemIndex := ComboBoxlanguage.Items.IndexOf(Prefs.Language);
    formmain.InfraLanguage1.language := Prefs.Language;
  end;

//  if FileExists(ExtractFilePath(Axpplication.ExeName)+'Customreleasescript.txt') then
//    MemoCustomrel.Lines.LoadFromFile(ExtractFilePath(Axpplication.ExeName)+'Customreleasescript.txt');

  if (Prefs.CustomReleaseScript.Count > 0) then
   MemoCustomrel.Lines :=  Prefs.CustomReleaseScript;


end;


procedure TFormSettings.FormCreate(Sender: TObject);
Var
  I : Integer;
Begin
   For i := 0 to Prefs.PRODUCTIONCOLUMNCOUNT-1 do
  Begin
    Prodgridfonts[i].Name := FormMain.Font.Name;
    Prodgridfonts[i].Size := FormMain.Font.Size;
    Prodgridfonts[i].Style := FormMain.Font.Style;
  End;
  Advancedsettings := false;
  activated := false;
  InitializeCheckBoxLists();
end;

procedure TFormSettings.BitBtnlresarcClick(Sender: TObject);
begin
 with TFileOpenDialog.Create(nil) do
        try
          Options := [fdoPickFolders];
          if Execute then
            Editmainarchivefolderlowres.Text  := FileName;
        finally
          Free;
        end;

end;



procedure TFormSettings.FormActivate(Sender: TObject);
var
  c,b,p : string;

begin

  c := ComboBoxcolorproof.text;
  p := ComboBoxpdfproof.text;
  b := ComboBoxbwproof.text;

  Formproof.init;
  ComboBoxcolorproof.items := Formproof.ComboBoxsoftproof.Items;
  ComboBoxpdfproof.items   := Formproof.ComboBoxsoftproof.Items;
  ComboBoxbwproof.items    := Formproof.ComboBoxsoftproof.Items;
  ComboBoxcolorproof.text  := c;
  ComboBoxbwproof.text     := b;
  ComboBoxpdfproof.text    := p;

  CheckBoxApplyPlateMerge.Visible := Addr(ApplyPlateMerge) <> nil;

  Firstactivate := false;

  curlangforcancel := ComboBoxlanguage.Text;

  restart := false;
end;


procedure TFormSettings.Button6Click(Sender: TObject);
begin
  StringGrid1.RowCount := 2;
  StringGrid1.colCount := 2;
  StringGrid1.cells[0,0] := '';
  StringGrid1.cells[1,0] := '';
  StringGrid1.cells[1,1] := '';
  StringGrid1.cells[0,1] := '';
end;

procedure TFormSettings.Button8Click(Sender: TObject);
Var
//  skaldeklarerespgadll : Integer;
  resulttat : Integer;
begin
  Runningdll := true;
  resulttat := ReConnectDB(DLLErrormessage);
  if resulttat = 1 then
    resulttat := JobNamesSetup(DLLErrormessage);


  Runningdll := false;
end;



procedure TFormSettings.RadioGroupHalfWebClick(Sender: TObject);
begin
  if RadioGroupHalfWeb.ItemIndex = 2 then
  Begin
    Edit5.Enabled := True;
    Edit3.Enabled := True;
  End else
  Begin
    Edit5.Enabled := False;
    Edit3.Enabled := False;
  End;
end;



procedure TFormSettings.EditrunrangestartKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (key in tal) then
    key := '0';
end;

procedure TFormSettings.EditrangetopKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (key in tal) then
    key := '0';
end;


procedure TFormSettings.BitBtn5Click(Sender: TObject);
begin

with TFileOpenDialog.Create(nil) do
        try
          Options := [fdoPickFolders];
          if Execute then
            Editmainarchivefolderhighres.Text  := FileName;
        finally
          Free;
        end;

end;

procedure TFormSettings.Button4Click(Sender: TObject);
begin
  IF OpenDialog1.Execute then
  begin
    DataM1.Query1.SQL.LoadFromFile(OpenDialog1.FileName);
    try
      DataM1.Query1.ExecSQL;
    except
    end;
  end;
end;

procedure TFormSettings.BitBtn6Click(Sender: TObject);
begin


  with TFileOpenDialog.Create(nil) do
        try
          Options := [fdoPickFolders];
          if Execute then
            EditDeafaultreportfolder.Text  := FileName;
        finally
          Free;
        end;

end;

procedure TFormSettings.BitBtn11Click(Sender: TObject);
begin


 with TFileOpenDialog.Create(nil) do
        try
          Options := [fdoPickFolders];
          if Execute then
            EditDefaultCSVReportfolder.Text  := FileName;
        finally
          Free;
        end;
end;

procedure TFormSettings.BitBtn7Click(Sender: TObject);
Var
  l : tlistitem;
begin
  l := ListViewplannamedstyles.Items.add;
  l.Caption := Editstylename.text;
  l.SubItems.Add(Editnameformat.Text);
  l.SubItems.Add(Editnamedateformat.Text);
end;

procedure TFormSettings.BitBtn8Click(Sender: TObject);
begin
  IF ListViewplannamedstyles.selected = nil then exit;
  if ListViewplannamedstyles.selected.Index = 0 then exit;
  ListViewplannamedstyles.selected.Caption := Editstylename.text;
  ListViewplannamedstyles.selected.subitems[0] := Editnameformat.Text;
  ListViewplannamedstyles.selected.subitems[1] := Editnamedateformat.Text;
end;

procedure TFormSettings.BitBtn9Click(Sender: TObject);
begin
  IF ListViewplannamedstyles.selected = nil then exit;
  if ListViewplannamedstyles.selected.Index = 0 then exit;
  ListViewplannamedstyles.selected.Delete;
end;

procedure TFormSettings.Add1Click(Sender: TObject);

begin
  AddL := ListViewStacknames.Items.Add;
  AddL.Caption := 'new';
  ListViewStacknames.Selected := Addl;
  ListViewStacknames.Selected.EditCaption;

end;

procedure TFormSettings.Delete1Click(Sender: TObject);
begin
  IF ListViewStacknames.Selected <> nil then
    ListViewStacknames.Selected.Delete;
end;

procedure TFormSettings.MenuItem3Click(Sender: TObject);
begin
  AddL := ListViewZonenames.Items.Add;
  AddL.Caption := 'new';
  ListViewZonenames.Selected := Addl;
  ListViewZonenames.Selected.EditCaption;

end;

procedure TFormSettings.MenuItem4Click(Sender: TObject);
begin
  IF ListViewZonenames.Selected <> nil then
    ListViewZonenames.Selected.Delete;
end;

procedure TFormSettings.Add2Click(Sender: TObject);
begin
  IF FormFileseversetup.ShowModal = mrOk then
  begin

  end;
end;

procedure TFormSettings.Add3Click(Sender: TObject);
begin
  AddL := ListViewdefmarks.Items.Add;
  AddL.Caption := 'new';
  ListViewdefmarks.Selected := Addl;
  ListViewdefmarks.Selected.EditCaption;
end;

procedure TFormSettings.Delete2Click(Sender: TObject);
begin
  IF ListViewdefmarks.Selected <> nil then
    ListViewdefmarks.Selected.Delete;
end;

procedure TFormSettings.Loadall1Click(Sender: TObject);
begin
  ListViewdefmarks.items.Clear;
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('SELECT DISTINCT MarkGroupName FROM MarkGroupNames');
  DataM1.Query1.SQL.Add('ORDER by MarkGroupName');
  try
    DataM1.Query1.Open;
    while not DataM1.Query1.eof do
    begin
      AddL := ListViewdefmarks.Items.Add;
      AddL.Caption := DataM1.Query1.Fields[0].AsString;
      DataM1.Query1.Next;
    end;
    DataM1.Query1.Close;
  Except

  end;
end;

procedure TFormSettings.MenuItem7Click(Sender: TObject);
begin
  AddL := ListViewFilter.Items.Add;
  AddL.Caption := 'new';
  ListViewFilter.Selected := Addl;
  ListViewFilter.Selected.EditCaption;
end;

procedure TFormSettings.MenuItem8Click(Sender: TObject);
begin
  IF ListViewFilter.Selected <> nil then
    ListViewFilter.Selected.Delete;
end;

procedure TFormSettings.EditlistimeKeyPress(Sender: TObject;   var Key: Char);
{Const
  Possiblekeys = 'YyMmDdHhNn:/.- ';
Var
  i : Integer;
  Found : boolean;}
begin
(*
  found := false;
  For i := 1 to 14 do
  Begin
    if key = Possiblekeys[i] then
    begin
      found := true;
      break;
    end;
  end;
  if not found then
  begin
    key := #0;
    beep;
  End;
  *)
end;

procedure TFormSettings.MemoShorteventExit(Sender: TObject);
begin
  IF MemoShortevent.lines.count < 4 then
  begin
    MessageDlg('There must be one short name for each event', mtError,[mbOk], 0);
    MemoShortevent.lines.clear;
    MemoShortevent.lines.add('FTP');
    MemoShortevent.lines.add('PRE');
    MemoShortevent.lines.add('RIP');
    MemoShortevent.lines.add('COL');

  end;
end;

procedure TFormSettings.CheckListBoxthumbtextStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  Idragorder := CheckListBoxthumbtext.ItemIndex;
end;

procedure TFormSettings.CheckListBoxthumbtextDragDrop(Sender,
  Source: TObject; X, Y: Integer);
Var
  Newidx : Integer;
  Apoint : Tpoint;
  Movestr : string;
  movecheck : boolean;

begin
  IF Source = CheckListBoxthumbtext then
  begin
     Apoint.X := x;
     Apoint.Y := Y;
     Newidx := CheckListBoxthumbtext.ItemAtPos(Apoint,true);
     IF newidx <> Idragorder then
     begin
       Movestr := CheckListBoxthumbtext.Items[Idragorder];
       movecheck := CheckListBoxthumbtext.checked[Idragorder];
       CheckListBoxthumbtext.Items.Delete(Idragorder);
       CheckListBoxthumbtext.Items.Insert(newidx,Movestr);
       CheckListBoxthumbtext.checked[newidx] := movecheck;

     end;
  end;
end;

procedure TFormSettings.CheckListBoxthumbtextDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Source = CheckListBoxthumbtext;
end;

procedure TFormSettings.ListBoxthumborderStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  Idragorder := ListBoxthumborder.ItemIndex;
end;

procedure TFormSettings.ListBoxthumborderDragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Source = ListBoxthumborder;
end;



procedure TFormSettings.ListBoxthumborderDragDrop(Sender, Source: TObject;
  X, Y: Integer);
Var
  Newidx : Integer;
  Apoint : Tpoint;
  Movestr : string;
//  movecheck : boolean;
begin
  IF Source = ListBoxthumborder then
  begin
     Apoint.X := x;
     Apoint.Y := Y;
     Newidx := ListBoxthumborder.ItemAtPos(Apoint,true);
     IF newidx <> Idragorder then
     begin
       Movestr := ListBoxthumborder.Items[Idragorder];
       ListBoxthumborder.Items.Delete(Idragorder);
       ListBoxthumborder.Items.Insert(newidx,Movestr);
     end;
  end;
end;

procedure TFormSettings.CheckListBoxPlatetextStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
    Idragorder := CheckListBoxPlatetext.ItemIndex;
end;

procedure TFormSettings.CheckListBoxPlatetextDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Source = CheckListBoxPlatetext;
end;

procedure TFormSettings.CheckListBoxPlatetextDragDrop(Sender,
  Source: TObject; X, Y: Integer);

Var
  Newidx : Integer;
  Apoint : Tpoint;
  Movestr : string;
  movecheck : boolean;
begin
  IF Source = CheckListBoxPlatetext then
  begin
     Apoint.X := x;
     Apoint.Y := Y;
     Newidx := CheckListBoxPlatetext.ItemAtPos(Apoint,true);
     IF newidx <> Idragorder then
     begin
       Movestr := CheckListBoxPlatetext.Items[Idragorder];
       movecheck := CheckListBoxPlatetext.checked[Idragorder];
       CheckListBoxPlatetext.Items.Delete(Idragorder);
       CheckListBoxPlatetext.Items.Insert(newidx,Movestr);
       CheckListBoxPlatetext.checked[newidx] := movecheck;
     end;
  end;
end;

procedure TFormSettings.CheckListBoxplatecaptionDragDrop(Sender,
  Source: TObject; X, Y: Integer);
Var
  Newidx : Integer;
  Apoint : Tpoint;
  Movestr : string;
  movecheck : boolean;
begin
  IF Source = CheckListBoxplatecaption then
  begin
     Apoint.X := x;
     Apoint.Y := Y;
     Newidx := CheckListBoxplatecaption.ItemAtPos(Apoint,true);
     IF newidx <> Idragorder then
     begin
       Movestr := CheckListBoxplatecaption.Items[Idragorder];
       movecheck := CheckListBoxplatecaption.checked[Idragorder];
       CheckListBoxplatecaption.Items.Delete(Idragorder);
       CheckListBoxplatecaption.Items.Insert(newidx,Movestr);
       CheckListBoxplatecaption.checked[newidx] := movecheck;
     end;
  end;
end;

procedure TFormSettings.CheckListBoxplatecaptionDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Source = CheckListBoxplatecaption;
end;

procedure TFormSettings.CheckListBoxplatecaptionStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
    Idragorder := CheckListBoxplatecaption.ItemIndex;
end;

procedure TFormSettings.BitBtn3Click(Sender: TObject);
begin

   with TFileOpenDialog.Create(nil) do
        try
          Options := [fdoPickFolders];
          if Execute then
            Editdefaultsavepagelistfile.Text  := FileName;
        finally
          Free;
        end;
end;

procedure TFormSettings.MenuItem5Click(Sender: TObject);
begin
  StringGridTowers.RowCount := StringGridTowers.RowCount+1;
end;

procedure TFormSettings.MenuItem6Click(Sender: TObject);
begin
  StringGridTowers.RowCount := StringGridTowers.RowCount-1;
end;

procedure TFormSettings.BitBtn4Click(Sender: TObject);
begin

  with TFileOpenDialog.Create(nil) do
        try
          Options := [fdoPickFolders];
          if Execute then
            ReportSaveFolder.Text  := FileName;
        finally
          Free;
        end;
end;



procedure TFormSettings.Button9Click(Sender: TObject);
begin
  FontDialogplateprint.Execute;
end;





procedure TFormSettings.StringGridprodsDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  r,s : trect;
  pros,o,i : Integer;

begin

  try
    if arow = 0 then exit;
    IF StringGridprods.cells[0,1] = '' then exit;

    StringGridprods.Canvas.Font.Name := Prodgridfonts[ACol].name;
    StringGridprods.Canvas.Font.Style := Prodgridfonts[ACol].Style;
    StringGridprods.Canvas.Font.Size := Prodgridfonts[ACol].Size;
    if (ACol >= 13) and (ACol <= 15) then  // Dette er barene
    begin
      StringGridprods.Canvas.Brush.Color := Clwhite;
      StringGridprods.Canvas.pen.Color := Clwhite;
      StringGridprods.Canvas.Font.Name := Prodgridfonts[ACol].name;
      StringGridprods.Canvas.Font.Style := Prodgridfonts[ACol].Style;
      StringGridprods.Canvas.Font.Size := Prodgridfonts[ACol].Size;

      StringGridprods.Canvas.Font.color := clblack;
      r := rect;
      r.Left := r.Left+1;
      r.right := r.right-1;
      r.top := r.top+1;
      r.Bottom := r.Bottom-1;
      s.top := 0;
      s.left := 0;
      s.right := 10;
      s.bottom := 13;
      o := 32;
      i := 16;
    //  Tstringgrid(Sender).Canvas.StretchDraw(r,FormImage.Imageprgbargray.Picture.Bitmap);
      Case acol of
        8 : begin
              o := 32;
              i := 16;
            end;
        9 : begin
              o := 32;
              i := 16;
            end;
       10 : begin
              o := 128;
              i := 64;
            end;
      end;
      try
        if o > 0 then
          pros := (i * 100) div o
        else
          pros := 0;
      except
        pros := 0;
      end;
      if (i > 0) and (pros < 100) then
      Begin
        if pros < 100 then
          r.Right := r.Right - (100-pros);
           StringGridprods.Canvas.Brush.Color := ClYellow;
        StringGridprods.Canvas.FillRect(r);
//        Tstringgrid(Sender).Canvas.StretchDraw(r,FormImage.Imageprgbargreen.Picture.Bitmap);
      end;
      if pros = 100 then
      begin
        StringGridprods.Canvas.Brush.Color := ClLime;
        StringGridprods.Canvas.FillRect(r);
      end;
       // Tstringgrid(Sender).Canvas.StretchDraw(r,FormImage.Imageprgbargreen.Picture.Bitmap);
      StringGridprods.Canvas.Brush.Style := bsClear;
      Tstringgrid(Sender).Canvas.Textout(rect.left+2,rect.top+2,Tstringgrid(Sender).cells[acol,arow]);
    End
    Else
    begin

      StringGridprods.Canvas.Brush.Color := Clwhite;
      StringGridprods.Canvas.pen.Color := Clwhite;

      StringGridprods.Canvas.Font.Name := Prodgridfonts[ACol].name;
      StringGridprods.Canvas.Font.Style := Prodgridfonts[ACol].Style;
      StringGridprods.Canvas.Font.Size := Prodgridfonts[ACol].Size;
      StringGridprods.Canvas.Font.color := clblack;

      IF ACol = 1 then
      begin
        StringGridprods.Canvas.Brush.Color := RGB(255,157,157);
      End
      Else
      Begin
        StringGridprods.Canvas.Brush.Color := Clwhite;
        StringGridprods.Canvas.pen.Color := Clwhite;
        StringGridprods.Canvas.Font.Name := Prodgridfonts[ACol].name;
        StringGridprods.Canvas.Font.Style := Prodgridfonts[ACol].Style;
        StringGridprods.Canvas.Font.Size := Prodgridfonts[ACol].Size;
        StringGridprods.Canvas.Font.color := clblack;
      End;

      Tstringgrid(Sender).Canvas.rectangle(rect.left,rect.top,rect.right,rect.bottom);
      Tstringgrid(Sender).Canvas.Textout(rect.left+2,rect.top+2,Tstringgrid(Sender).cells[acol,arow]);
    end;
  except

  end;
end;

procedure TFormSettings.StringGridprodsSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  CanSelect := true;
end;

procedure TFormSettings.StringGridprodsDblClick(Sender: TObject);
begin
  if (StringGridprods.Selection.Left > -1) And (StringGridprods.Selection.Right < 38) then
  Begin
    IF FontDialog1.Execute then
    begin
      Prodgridfonts[StringGridprods.Selection.Left].name := FontDialog1.Font.name;
      Prodgridfonts[StringGridprods.Selection.Left].Size := FontDialog1.Font.size;
      Prodgridfonts[StringGridprods.Selection.Left].Style := FontDialog1.Font.style;
      FindbiggestfontInternal;
    end;
  end;
end;

// Only used in FormSettings...
Function TFormSettings.FindbiggestfontInternal:Integer;
Var
  //B,
  H,I : Integer;

Begin
  H := -1;
  For i := 0 to 15 do
  begin
    Image4.Canvas.Font.Name := Prodgridfonts[i].name;
    Image4.Canvas.Font.Style := Prodgridfonts[i].Style;
    Image4.Canvas.Font.Size := Prodgridfonts[i].Size;
    IF H < Image4.Canvas.TextHeight('ZXY�') then
    Begin
      H := Image4.Canvas.TextHeight('ZXY�');
      //B := I;
    End;
  end;
  StringGridprods.DefaultRowHeight := H+4;
  result := StringGridprods.DefaultRowHeight;
end;




procedure TFormSettings.Clearall1Click(Sender: TObject);
Var
  i : Integer;
begin
  for i := 0 to ListVieweventlogs.Items.count-1 do
    ListVieweventlogs.Items[i].Checked := false;
end;

procedure TFormSettings.Setall1Click(Sender: TObject);
Var
  i : Integer;
begin
  for i := 0 to ListVieweventlogs.Items.count-1 do
    ListVieweventlogs.Items[i].Checked := true;
end;

procedure TFormSettings.CheckListBoxdefunknownClick(Sender: TObject);
Var
  I : Integer;
begin

  if CheckListBoxdefunknown.itemindex = 0 then
  Begin
    For i := 0 to CheckListBoxdefunknown.items.Count-1 do
      CheckListBoxdefunknown.checked[i] := false;

    CheckListBoxdefunknown.checked[0] := true;
  end;

  For i := 1 to CheckListBoxdefunknown.items.Count-1 do
  Begin
    IF CheckListBoxdefunknown.checked[i] then
    begin
      CheckListBoxdefunknown.checked[0] := false;
    end;

  End;
end;

procedure TFormSettings.BitBtn1Click(Sender: TObject);
//Var
  //I : Integer;
//  doarestart : Boolean;
begin
(*  Showthowthumbgrps := false;
  doarestart := false;

  if not CheckBoxalllocations.Checked then
  begin
    if CheckBoxshowallfilter.Checked then
    begin
      MessageDlg('If plancenter is limited to a specific location'+#13+'the Show All Location filter will be disabled ', mtInformation,[mbOk], 0);
      CheckBoxshowallfilter.Checked := false;
    end;
  end;
  For i := 0 to CheckListBoxthgroupecap.Items.Count-1 do
  begin
    if CheckListBoxthgroupecap.Checked[i] Then
      Showthowthumbgrps := true;
  End;

  if (Showallchk <> CheckBoxalllocations.checked) OR (showallfilt <> CheckBoxshowallfilter.checked) then
  begin
    doarestart := true;
  End;

  if doarestart then
    MessageDlg('Plancenter must be restarted to apply changes ', mtInformation,[mbOk], 0);
       *)
end;

procedure TFormSettings.NewlineInthumb1Click(Sender: TObject);
Var
  I : Integer;
  T : String;
begin

  For i := 0 to CheckListBoxthumbtext.Items.Count-1 do
  begin
    T := CheckListBoxthumbtext.items[i];
    if (CheckListBoxthumbtext.Selected[i]) and (T[length(T)] <> '#') then
    Begin
      CheckListBoxthumbtext.items[i] := CheckListBoxthumbtext.items[i] +' #';
      NewlineInthumb1.enabled := false;
    End;
  end;
end;





procedure TFormSettings.SpacethumbcaplineClick(Sender: TObject);
Var
  I : Integer;
  T : String;
begin
    For i := 0 to CheckListBoxthumbtext.Items.Count-1 do
    begin
      T := CheckListBoxthumbtext.items[i];
      if (CheckListBoxthumbtext.Selected[i]) and (T[length(T)] = '#') then
      Begin
        delete(t,length(T)-1,2);
        CheckListBoxthumbtext.items[i] := T;
        NewlineInthumb1.enabled := true;
      End;
    end;

end;

procedure TFormSettings.BitBtn2Click(Sender: TObject);
begin
  ComboBoxlanguage.Text :=  curlangforcancel;
  //readsettings(-1);
end;

procedure TFormSettings.Add5Click(Sender: TObject);
begin
  Formtowerfilter.towstring := '';
  Formtowerfilter.Init(true);
  if Formtowerfilter.showmodal = mrok then
  begin
    if (Formtowerfilter.towstring <> '') And (Formtowerfilter.Editname.Text <> '') then
    begin
      ValueListEditortowerfilters.InsertRow(Formtowerfilter.Editname.Text,Formtowerfilter.towstring,true);
    end;
  end;
end;

procedure TFormSettings.Delete4Click(Sender: TObject);
{Var
  i : Integer;}
begin
  ValueListEditortowerfilters.DeleteRow(ValueListEditortowerfilters.Row);
end;

procedure TFormSettings.CheckListBoxThumbeventsClickCheck(Sender: TObject);
Var
  i,n : Integer;
begin
  n := 0;
  for i := 0 to CheckListBoxThumbevents.Items.Count-1 do
  begin
    if CheckListBoxThumbevents.Checked[i] then
      inc(n);
  End;
  if n > 4 then
  Begin
    For i := 0 to CheckListBoxThumbevents.Items.Count-1 do
    Begin
      if CheckListBoxThumbevents.Selected[i] then
      Begin
        CheckListBoxThumbevents.Checked[i] := false;
        break;
      End;
    End;
    beep;
    MessageDlg('No more than four prepoll events can be shown in thumbnail view', mtInformation,[mbOk], 0);

  End;
end;

procedure TFormSettings.CheckBoxAllowDropFilesClick(Sender: TObject);
begin

  EditDropFilesDestination.Enabled :=  (CheckBoxAllowDropFiles.Checked = true);
  CheckBoxAllowDropFilesDialog.Enabled := (CheckBoxAllowDropFiles.Checked = true);
  CheckBoxAllowDropFilesDeleteAfterCopy.Enabled := (CheckBoxAllowDropFiles.Checked = true);
end;

procedure TFormSettings.CheckListBox1ClickCheck(Sender: TObject);
begin
  If NOT CheckListBox1.Checked[CheckListBox1.ItemIndex] then
    StringGridprods.ColWidths[CheckListBox1.ItemIndex] := 0 else
    If StringGridprods.ColWidths[CheckListBox1.ItemIndex] < 20 then
       StringGridprods.ColWidths[CheckListBox1.ItemIndex] := 100;
end;


procedure TFormSettings.CheckListBox1Click(Sender: TObject);
begin
  Edit6.Text := CheckListBox1.Items[CheckListBox1.itemindex];
  Edit7.Text := IntToStr(StringGridprods.ColWidths[CheckListBox1.itemindex]);
end;

procedure TFormSettings.Edit6Change(Sender: TObject);
begin
  If CheckListBox1.itemindex >= 0 Then
  Begin
    CheckListBox1.Items[CheckListBox1.itemindex] := Edit6.Text;
    StringGridprods.Cells[CheckListBox1.itemindex, 0] := Edit6.Text;
  End;
end;

procedure TFormSettings.Edit6Enter(Sender: TObject);
begin
  If CheckListBox1.itemindex < 0 Then
    ShowMessage('Select a column name in the left box');
end;

procedure TFormSettings.Edit7Change(Sender: TObject);
begin
  If (CheckListBox1.itemindex >= 0) And (Edit7.Text <> '') Then
    StringGridprods.ColWidths[CheckListBox1.itemindex] := StrToInt(Edit7.Text);
end;


procedure TFormSettings.InitializeCheckBoxLists();
var
  i: integer;
begin
   CheckListBoxSectionText.Items.Clear();
   for i := 0 to Length(Prefs.CheckListBoxSectionTextItems)-1 do
   begin
        CheckListBoxSectionText.Items.Add(Prefs.CheckListBoxSectionTextItems[i]);
   end;

   CheckListBoxextrafiltertext.Items.Clear();
   for i := 0 to Length(Prefs.CheckListBoxextrafiltertextItems)-1 do
   begin
        CheckListBoxextrafiltertext.Items.Add(Prefs.CheckListBoxextrafiltertextItems[i]);
   end;

   CheckListBoxEditionText.Items.Clear();
   for i := 0 to Length(Prefs.CheckListBoxEditionTextItems)-1 do
   begin
        CheckListBoxEditionText.Items.Add(Prefs.CheckListBoxEditionTextItems[i]);
   end;

   CheckListBoxplatecaption.Items.Clear();
   for i := 0 to Length(Prefs.CheckListBoxplatecaptionItems)-1 do
   begin
        CheckListBoxplatecaption.Items.Add(Prefs.CheckListBoxplatecaptionItems[i]);
   end;

   CheckListBoxPlatetext.Items.Clear();
   for i := 0 to Length(Prefs.CheckListBoxPlatetextItems)-1 do
   begin
        CheckListBoxPlatetext.Items.Add(Prefs.CheckListBoxPlatetextItems[i]);
   end;

   CheckListBoxpressruntexts.Items.Clear();
   for i := 0 to Length(Prefs.CheckListBoxpressruntextsItems)-1 do
   begin
        CheckListBoxpressruntexts.Items.Add(Prefs.CheckListBoxpressruntextsItems[i]);
   end;

   ListBoxthumborder.Items.Clear();
   for i := 0 to Length(Prefs.ListBoxthumborderItems)-1 do
   begin
        ListBoxthumborder.Items.Add(Prefs.ListBoxthumborderItems[i]);
   end;

   CheckListBoxThumbevents.Items.Clear();
   for i := 0 to Length(Prefs.CheckListBoxThumbeventsItems)-1 do
   begin
        CheckListBoxThumbevents.Items.Add(Prefs.CheckListBoxThumbeventsItems[i]);
   end;

   CheckListBoxthgroupecap.Items.Clear();
   for i := 0 to Length(Prefs.CheckListBoxthgroupecapItems)-1 do
   begin
        CheckListBoxthgroupecap.Items.Add(Prefs.CheckListBoxthgroupecapItems[i]);
   end;

   CheckListBoxthumbstatbar.Items.Clear();
   for i := 0 to Length(Prefs.CheckListBoxthumbstatbarItems)-1 do
   begin
        CheckListBoxthumbstatbar.Items.Add(Prefs.CheckListBoxthumbstatbarItems[i]);
   end;

   MemoShortevent.Lines.Clear();
   for i := 0 to Length(Prefs.MemoShorteventItems)-1 do
   begin
        MemoShortevent.Lines.Add(Prefs.MemoShorteventItems[i]);
   end;

   CheckListBoxPLtPrnttitle.Items.Clear();
   for i := 0 to Length(Prefs.CheckListBoxPLtPrnttitleItems)-1 do
   begin
        CheckListBoxPLtPrnttitle.Items.Add(Prefs.CheckListBoxPLtPrnttitleItems[i]);
   end;

   CheckListBoxPLtPrntplate.Items.Clear();
   for i := 0 to Length(Prefs.CheckListBoxPLtPrntplateItems)-1 do
   begin
        CheckListBoxPLtPrntplate.Items.Add(Prefs.CheckListBoxPLtPrntplateItems[i]);
   end;

   CheckListBoxAFoldername.Items.Clear();
   for i := 0 to Length(Prefs.CheckListBoxAFoldernameItems)-1 do
   begin
        CheckListBoxAFoldername.Items.Add(Prefs.CheckListBoxAFoldernameItems[i]);
   end;
end;

end.
