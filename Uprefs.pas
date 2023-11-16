unit Uprefs;

// Preference class instanciated in FormMain to hold global settings.
// Settings are read from PlanCenter.ini in LoadIniFile()
// Some settings are read in LoadIniFileAfterDBInit() after tnames1 (Names) initialisation

interface

uses
  System.SysUtils, System.Classes, System.UITypes, System.IniFiles, Vcl.Forms, Vcl.Graphics, System.Math;

type
  TPressTowersType =  array of record
                        Press : string;
                        Tower : string;
                      end;

  TVisiblePressesType = array of record
                        Press : string;
                        Visible : Boolean;
                      end;

  TVisiblePressTowerType = array of record
                        Press : string;
                        Tower : string;
                        Visible : Boolean;
                      end;

  TNameEnabledType = array of record
                        Name : string;
                        Enabled : Boolean;
                      end;

  TNameNumberEnabledType = array of record
                        Name : string;
                        Number : Integer;
                        Enabled : Boolean;
                      end;

  // homemade set...
  TValueListType = array of record
                    Key : string;
                    Value : string;
                  end;

  TProductionColumnType = array of record
                    ColumnName : string;
                    Visible : Boolean;
                    Width : Integer;
                  end;


  TProductionGridFontType = array of record
                    Name : string;
                    Style : TFontStyles;
                    Size : Longint;
                  end;

  TPlannedNameDefinitionType = array of record
                     Name : string;
                     Format : string;
                     Dateformat : string;
                     Enabled : Boolean;
                  end;

  tPrefs = class(TComponent)

  public


    PlanCenterConfigFileName : string;
    FixedDomain : string;
    SimpleUserLookup : boolean;
    CurrentWindowsUser : string;
    CurrentWindowsDomain : string;
    CurrentADGroups : string;
    UseWindowsUser : Boolean;
    UseAdministrativeGroups : Boolean;
    UseADGroups : Boolean;


    DBServerName : string;
    DBDatabase : string;
    DBInstance : string;
    DBUser : string;
    DBPassword : string;
    DSN : string;

    DBUseBackup : Boolean;
    DBBackupServerName : string;
    DBBackupDatabase : string;
    DBBackupInstance : string;
    DBBackupUser : string;
    DBBackupPassword : string;

    BackupDSN : string;

    DBreconnect : Boolean;
    DBFetchAll : Boolean;
    DBCommandTimeout : Integer;

    UsePreviewCache : Boolean;
    PreviewCacheShare : string;
    Caption : string;                                   // Application.Caption

    LimitTowers : Boolean;                               // FormxSettings.CheckBoxLimitTowers

    OnlyConnectPlanCenterUser : Boolean;               // FormxSettings.CheckBoxOnlyConnectPlanCenterUser

    ShowSpecificDevices       : Boolean;               // FormxSettings.CheckBoxShowSpecificDevicesOnly
    SpecificDevices           : TNameEnabledType;        // FormxSettings.CheckListBoxSpecificDevices
    OnlyShowDefaultDevices    : Boolean;               // FormxSettings.CheckboxOnlyShowDefaultDevices
    AlwaysUseGeneratedReadViews : Boolean;
    PreviewForceGrayBackground : Boolean;               // CheckBoxForceGrayBackground

    ShowLogStoredProc : string;

    Proversion : Integer;
    PlannningMaxPlateFrames : Integer;
    IgnoreImposeCalcNumbering : Boolean;              // FormMain.cheatnumbers
    ShowAllActionsOverrule : Boolean;

    Language : string;                                // FormxSettings.ComboBoxlanguage.Text
    PressSpecific: Boolean;                          // Extracted from DB Globalsettings (bit 2) CheckBoxpressspecifik
    AllowMultipleInstances : Boolean;
    WritePlanLogFile : Boolean;                       // FormxSettings.Writeplanlogfile

    CCFilesPath : string;                             // FormxSettings.Edithighrespath.Text
    CCPreviewPath : string;                           // FormxSettings.Editlowres.Text
    CCThumbnailPath : string;                         // FormxSettings.Editthumbpath.Text
    CCWebProofPath : string;                          // FormxSettings.Editwebproofpath.Text
    CopyToWebCenter : Boolean;                        // FormxSettings.CheckBoxusewebproofpath.checked

    webisftp : boolean;
    ftpservername : string;
    ftpusername : string;
    ftppasword : string;
    ftpport : Integer;
    ftpfolder : string;

    StackNamesList : array of string; //TStringList;                     // FormxSettings.ListViewStacknames
    ZoneNamesList : array of string; //TStringList;                      // FormxSettings.ListViewZonenames
    DefMarksList : array of string; //TStringList;                       // FormxSettings.ListViewdefmarks
    FilterList :  array of string; //TStringList;                        // FormxSettings.ListViewFilter
    PrePollEventNames : array of string; //TStringList;                // FormxSettings.MemoShortevent.Lines[i]
    ThumbnailSortingOrder : array of string; //TStringList;            // FormxSettings.ListBoxthumborder.Items[i]

    PressTowers : TPressTowersType;  // 0-index       // FormxSettings.StringGridTowers
    VisiblePressesConfig : TVisiblePressesType;          // FormxSettings.CheckListBoxvisiblepressesConfig.Items[i]
    VisibleTowers : TVisiblePressTowerType;              // FormxSettings.CheckListBoxvisibletowers
    ArchiveFolderNameDefinitions : array of Boolean;     // FormxSettings.CheckListBoxAFoldername.Checked[i]


    MinAutoRefresh  : Integer;                        // FormxSettings.Minautorefresh
    MinTreeRefresh : Integer;                         // FormxSettings.Mintreerefresh
    MinDeviceRefresh : Integer;                       // FormxSettings.Mindevicefresh
    Debug : Boolean;                                  // FormxSettings.debug

    AutoLogin : Boolean;                              // FormxSettings.CheckBoxautologin.Checked
    AutoLoginUser : string;                           // FormxSettings.EditAutoLoginUser.text
    AutoLoginPassword : string;                       // FormxSettings.EditAutoLoginPassword.text
    AutoConsole : Boolean;                            // FormxSettings.CheckBoxautoconsole.checked
    ConsoleName  : string;                            // FormxSettings.Editconsolename.text
    MaxConsoleAge : Integer;                          // FormxSettings.Editmaxconsoleage.text
    UseConfigurablePagination : Boolean;              // FormxSettings.usenewpagina
    LocalMode : Boolean;                              // FormxSettings.localmode

    NcolsSeparationView : Integer;                    // FormxSettings.EditNcols.text
    AutoTowerOrder : Boolean;                         // FormxSettings.CheckBoxtowerorderauto.Checked

    DeleteOnlyOnSelectedPress : Boolean;              // FormxSettings.CheckBoxdelonlyselon.Checked

    CustomPlanCheck : Boolean;                        // FormxSettings.CheckBoxcustomplancheck.checked
    CustomCheckSystemName : string;                   // FormxSettings.EditCustomchecksystemname.Text

    UseHoneywell : Boolean;                           // FormxSettings.CheckBoxUsehoneywell.checked
    PathToHoneywell : string;                         // FormxSettings.EditPathtohoneywell.Text
    HoneywellUsername : string;                       // FormxSettings.EditHoneywellpassword.Text
    HoneywellPassword : string;                       // FormxSettings.EditHoneywellusername.Text

    TreeShowPagesReadyFlag : Boolean;                 // FormxSettings.CheckBoxTreeShowPagesReadyFlag.checked
    AlwaysFullTreeExpand : Boolean;                   // FormxSettings.CheckBoxAlwaysfullTreeExpand.checked

    AllowPageDelete: Boolean;                          // FormxSettings.CheckBoxpagedelete.checked
    UseAdobeView : Boolean;                            // FormxSettings.useadobeview

    SwapPlateMerger : Boolean;                         // FormxSettings.CheckBoxswapplatemerger ????
    ProductionSelectAllCopies : Boolean;               // FormxSettings.CheckBoxSellallcopiesprod.checked
    ProductionReleaseHoldAllCopies : Boolean;          // FormxSettings.CheckBoxprodreleaseholdallcopy.Checked
    DefaultThumbnailOnlyPagePlans : Boolean;           // FormxSettings.CheckBoxDefaultThumbnailOnlyPagePlans.Checke
    ThumbnailForceReadorder : Boolean;                 // FormxSettings.CheckBoxforcereadorder.checked
    PlateDetailsOff : Boolean;                         // FormxSettings.CheckBoxplatedetailof.Checked

    GrayDensityMap : Boolean;                          // FormxSettings.CheckBoxgraydns.checked
    MinTreeLevelLog : Integer;                         // FormxSettings.Editminlogtree.Text
    PlanLoadDefaultToNoTemplateChange : Boolean;       // FormxSettings.CheckBoxdefnochangetmpl.Checked
    EditionUseAsMasterIgnorePress : Boolean;           // FormxSettings.CheckBoxeditionignorepress.checked

    UnknownPDFfolder : string;                         // FormxSettings.Editunknownpdf.Text
    PDFArchivefolder : string;                         // FormxSettings.Editarchivepath.Text
    ExcludeArchiveFilter : string;                     // FormxSettings.EditExcludeArchiveFilter.Text

    SelectAllCopiesOnReimage : Boolean;                // FormxSettings.CheckBoxreimcopies.checked
    SelectAllCopiesOnRelease : Boolean;                // FormxSettings.CheckBoxSelectAllCopiesOnRelease.checked
    ClearDeviceOnLayoutChange : Boolean;               // FormxSettings.CheckboxClearDeviceOnLayoutChange.checked
    KeepOutputVersionOnReimage : Boolean;               // FormxSettings.CheckBoxKeepOutputVersionOnReimage.checked

    EnsurePreviewFormInFront : Boolean;                 // FormxSettings.CheckBoxEnsurePreviewFormInFront.Checked
    LeanAndMeanPreview : Boolean;                       // FormxSettings.CheckBoxLeanAndMeanPreview.Checked

    SpecialHalfwebMode : Integer;                       // FormxSettings.RadioGroupHalfWeb.ItemIndex
    SpecialHalfwebAtMinPage : Integer;                  // FormxSettings.Edit3
    SpecialHalfwebAtFixedPage : Integer;                  // FormxSettings.Edit5

    PlanningPageNameIn : Integer;                       //FormxSettings.RadioGroupPlanningPageNameIn.ItemIndex
    DecreaseVersion : Boolean;                          // FormxSettings.CheckBoxDecreasever.checked

    AdminTab : Boolean;                                 // FormxSettings.CheckBoxadmintab.Checked
    AllowPaginaRecalculate: Boolean;                    // FormxSettings. CheckBoxpaginarecalc.checked
    ActivateOnlyBlack : Boolean;                        // FormxSettings.CheckBoxractivateonlyblack
    TreeOrder : Integer;                                // FormxSettings.RadioGroupTreeorder
    RemoveMissingColorsOnApprove : Boolean;             // FomrSettings. CheckBoxremovemissingcolorsonaprove.Checked
    ReleaseOnApproval : Boolean;                        // FormxSettings.CheckBoxreleaseonapproval.Checked
    ReleaseOnSeparationSet : Boolean;                   // FormxSettings.Checkboxreleaseonseprationset.checked
    ShowPreviewBestfit : Integer;                       // FormxSettings.RadioButtonBestfit  Betsfit=0, 1:1=1, zoomby=2
    ShowPreviewInitZoom : Integer;                      // FormxSettings.EditInitzoom.text

    UseCustomReleaseScript : Boolean;                   // FormxSettings.CheckBoxCustomrelchecked
    ReportDateFormat : string;                           // FormxSettings.Editreportdateform.Text

    MainArchiveFolderHighres : string;                 // FormxSettings.Editmainarchivefolderhighres.Text
    MainArchiveFolderLowres : string;                  // FormxSettings.Editmainarchivefolderlowres.Text
    AddPressRunDefaultSection : string;                   // FormxSettings.EditDefsection.Text
    ApplyPlanAutoMultiPress: Boolean;                    // FormxSettings.CheckBoxAutomultipress.checked
    DefaultShowNoUnplanned : Boolean;                    // FormxSettings.CheckBox2nounplanned.Checed

    EditionViewOnlySecInEd : Boolean;                    // FormxSettings.CheckBoxOnlySecined.checked

    AllowParalelView : Boolean;                          // FormxSettings.CheckBoxAllowparalelview.Checked
    NewPreviewNames : Boolean;                           // FormxSettings.CheckBoxNewPreviewNames.Checked
    PressTimeInPlateTree : Boolean;                      // FormxSettings.CheckBoxpresstimeinplatetree.Checked
    AllowTimedEditions : Boolean;                        // FormxSettings.CheckBoxtimedEd.checked
    DefaultHardproofType : Integer;                      // FormxSettings.ComboBoxdefHardprtype.ItemIndex
    DefaultSoftproofType : Integer;                      // FormxSettings.ComboBoxdefSoftprtype.ItemIndex
    PlateTreeExpansion : Integer;                        // FomrSettings.RadioGroupplatetreeexp.ItemIndex
    FlatproofWaitForApproval: Boolean;                   // FormxSettings.CheckBoxdefsoftvait.checked
    HardproofWaitForApproval : Boolean;                  // FormxSettings.CheckBoxhardvait.Checked

    IncludeImageOnceState : Boolean;                     // FormxSettings.CheckBoxIncludeImageOnceState.Checked
    DefaultDateSelect : Integer;                         // FormxSettings.RadioGroupdefdatesel.itemindex
    ShowPdfBook : Integer;                               // FormxSettings.RadioGroupShowpdfbook.Itemindex
    UsePlateviewThumbnails : Boolean;                    // FormxSettings.CheckBoxplatethumb.checked
    PlanInkaliasLoad : Boolean;                          // FormxSettings.CheckBoxplaninkaliasload.checked
    ErrorFileRetrySendLog : Boolean;                     // FormxSettings.CheckBoxuknownsendlog.Checked
    OnlyApplyOnUnapplied : Boolean;                      // FormxSettings.CheckBoxonlyaplyonunapplied.Checked
    MinimumPlatenameLength : Integer;                    // FormxSettings.Editminplatenamelength.text

    ArchiveEnabled : Boolean;                            // FormxSettings.CheckBoxarchiveenabled.checked
    DefaultArchiveHighres : Boolean;                     // FormxSettings.CheckBoxdefarchivehighress.checked
    DefaultArchiveLowres : Boolean;                      // FormxSettings.CheckBoxdefarchivelowres.checked
    ShowAddCopyDialog : Boolean;                         // FormxSettings.CheckBoxaddcopydialog.checked
    ReimageExternalStatus : Integer;                     // FormxSettings.Editreimextstat.Text
    PecomImport : Boolean;                               // CheckBoxpecomImport.Checked
    TreeGreenOnceImaged : Boolean;                       // FormxSettings. CheckBoxtreeonceimaged.checked
    ShowNewProductSign : Boolean;                        // FormxSettings.CheckBoxnewprodsign.Checked

    EditionApplyUseAlterntiveEditionFile : Boolean;      // FormxSettings.CheckBoxusealted.Checked
    LoadPdfInPreview : Boolean;                            // FormxSettings.CheckBoxUseadobereader.checked
    UseExtendedPlateView : Boolean;                      // FormxSettings.CheckBoxplatedeluxe.Checked

    PressDataRequestLevel : Integer;                     // FormxSettings.ComboBoxpressreqlevel.ItemIndex
    PressDataRequestPressSpecific : Boolean;             // FormxSettings.CheckBoxpressspecreq.Checked
    TreeShowPrepollEvents : Boolean;                     // FormxSettings.CheckboxTreeShowPrepollEvents.Checked
    TimedEditionRule : Integer;                          // FormxSettings.RadioGrouptimedrules.ItemIndex
    InsertSheetNumbersFor1up : Boolean;                  // FormxSettings.CheckBoxinsertsheetnumbersfor1up.Checked
    PlateDoneStatisticsMode : Integer;                   // FormxSettings.RadioGroupplatedonestat.itemindex
    AlwaysUseOffset0OnApply : Boolean;                   // FormxSettings.CheckBoxAlwaysUseOffset0OnApply.Checked
    NoTreeLamps : Boolean;                               // FormxSettings.CheckBoxnotreelamps.Checked
    HidePlateCopyBar : Boolean;                          // FormxSettings.CheckBoxplatehidecopy.checked

    LogDeleteActions : Boolean;                          // FormxSettings.CheckBoxlogdelete.checked
    LogPlanningActions : Boolean;                        // FormxSettings.CheckBoxlogplanning.checked
    AutoShowMasked : Boolean;                            // FormxSettings.CheckBoxautomasked.checked
    RecombineOnUnapply : Boolean;                        // FormxSettings.CheckBoxrecombatunapply.Checked

    PartialNoEditionChange : Boolean;                    // FormxSettings.CheckBoxPartialNoEdChange.Checked
    PartialNoSecionChange : Boolean;                     // FormxSettings.CheckBoxPartialNoSecChange.Checked
    TreeShowDayName : Boolean;                           // FormxSettings.CheckBoxtreedayname.Checked
    TreeShowWeekNumberInfo : Boolean;                    // FormxSettings.CheckBoxTreeShowWeeknumberAlso
    IgnoreNetUseCommand : Boolean;                       // FormxSettings.CheckBoxignorenetuse.checked

    DefaultToApprovalRequired : Boolean;                 // FormxSettings.CheckBoxplanapproval.checked

    PlateNoThumbnailRotation : Boolean;                  // FormxSettings.CheckBoxPlatenothumbrot.checked
    PressHighPlateName : string;                         // FormxSettings.EditHighplate.Text
    PressLowPlateName : string;                          // FormxSettings.Editlowplate.Text
    PressHighPlateName2 : string;                         // FormxSettings.EditHighplate.Text
    PressLowPlateName2 : string;                          // FormxSettings.Editlowplate.Text

    PlannedPageNameDataFile : string;                    // FormxSettings.Editplannedpagenamedata.Text

    PlateNameRestartOnEachRun : Boolean;                 // FormxSettings.CheckBoxplatenamerecount.Checked
    UsePressSpecificInkRegenPath : Boolean;              // FormxSettings.CheckBoxinkpresspath.checked
    FileInfoBufferSize : Integer;                        // FormxSettings.NyFileInfosize
    SetSecionNamesInPressrunComment : Boolean;           // FormxSettings.CheckBoxsecInpressruncom.Checked
    UseFileCenterTiffArchive : Boolean;                  // FormxSettings.CheckBoxUseFileCenterTiffArchive.Checked
    SynchronizedTreeUpdate : Boolean;                    // FormxSettings.CheckBoxFastTree.Checked
    EnableArchive : Boolean;                             // FormxSettings.CheckBoxArkenabled.Checked
    ShowPdfUnknownFiles : Boolean;                       // FormxSettings.CheckBoxPdfunknown.Checked
    Split1UpRuns : Boolean;                              // FormxSettings.CheckBoxsplit1upruns.checked
    TextOnReportGraph : Boolean;                         // FormxSettings.CheckBoxtextongrp.checked
    UseWebFileNameWithVersion : Boolean;                 // FormxSettings.CheckBoxwebver.Checked
    RestrictRetransmit : Boolean;                        // FormxSettings.CheckBoxOverruleretransmit.Checked
    StartupWindowsSize : Integer;                        // FormxSettings.RadioGroupstartupsize.itemindex
    PlateShowExternalStatus : Boolean;                   // FormxSettings.CheckBoxplateshowextstat.Checked
    ArchiveHigresFilenameDefinition : string;            // FormxSettings.Edithighresarch.text
    DefaultAutomatePlanname : Boolean;                   // FormxSettings.CheckBoxdefaultautomateplanname.Checked
    PlanClearSections : Boolean;                         // FormxSettings.CheckBoxplanclearsections.Checked
    UseTrueSheetSide : Boolean;                          // FormxSettings.CheckBoxusetruesheetside.Checked
    ShowInkDensityInformation : Boolean;                 // FormxSettings.CheckBoxShowInkDensityInformation.Checked
    ShowSizeInformation : Boolean;                       // FormxSettings.CheckBoxShowSizeInformation.Checked
    AllowDropFilesDeleteAfterCopy : Boolean;             // FormxSettings.CheckBoxAllowDropFilesDeleteAfterCopy.Checked
    DeviceControlOnlyAdmins : Boolean;                   // FormxSettings.CheckBoxDeviceControlOnlyAdmins.Checked
    PlanningPageFormat : Boolean;                        // FormxSettings.CheckBoxCheckPlanningPageFormat.Checked
    PlanningRipSetup : Boolean;                          // FormxSettings.CheckBoxCheckPlanningRipSetup.Checked
    AutoFlatProof : Boolean;                             // FormxSettings.CheckBoxautoflatproof.checked
    EnablePressSpecificSelection : Boolean;              // FormSetting.CheckBoxenablespecifiksel.Checked
    NewInkRegeneration : Boolean;                        // FormxSettings.CheckBoxnewinkregen.Checked
    AutoReImageOnDeviceChange : Boolean;                 // FormxSettings.CheckBoxautoreimondevch.Checked
    ApplyOnlyPlannedColors : Boolean;                    // FormxSettings.CheckBoxApplyonlyplannedcolors.Checked
    ForceSameDevice : Boolean;                           // FormxSettings.CheckBoxForcesamedev.Checked
    DefaultSavePageListFile : String;                    // FormxSettings.Editdefaultsavepagelistfile.Text
    AllowManualPlanning : Boolean;                       // FormxSettings.CheckBoxmanualplanning.Checked

    UnplannedApplyDefaultMethodToWizard : Boolean;       // FormxSettings.RadioButtonload=false / RadioButtonwizard = true
    SmoothPlateAutoRefresh : Boolean;                    // FormxSettings.CheckBoxsmootplateautorefresh.Checked
    PreviewZoomfilter : Integer;                         // FormxSettings.ComboBoxZoomfilter.Index
    ProductionViewShowOrder : Boolean;                   // FormxSettings.CheckBoxprodshoworder.Checked
    PlateviewOrderInCaption : Boolean;                   // FormxSettings.CheckBoxorderintopcap.Checked
    PreviewGoToNeedApproval : Boolean;                   // FormxSettings.CheckBoxgtoneedapr.Checked
    AllowSelectionOfAnyLayout : Boolean;                 // FormxSettings.CheckBoxlayoutanaki.Checked
    PlanningAllowManualHalfWebOverride : Boolean;        // FormxSettings.CheckBoxmanhw
    DefaultPlanHold : Boolean;                           // FormxSettings.CheckBoxplanhold.Checked
    ReportShowAllGraphTime : Boolean;                    // FormxSettings.CheckBoxshowallgraphtime.checked
    PlanningDefaultPDF : Boolean;                        // FormxSettings.CheckBoxdefaultPDF.Checked
    UseCustomTowerNames : Boolean;                       // FormxSettings.CheckBoxCustomtowerrnames.Checked
    TreeAutoExpandLevel : Integer;                       // FormxSettings.UpDownnewautoexp.Position
    UseDBTowerNames : Boolean;                           // FormxSettings.CheckBoxUseDBtowernames.Checked
    PlanRepair : Boolean;                                // FormxSettings.CheckBoxPlanrepair.Checked
    PlanningDefaultInserted : Boolean;                   // FormxSettings.CheckBoxDefplaninserted.Checked
    DefaultShowPlateDetails : Boolean;                   // FormxSettings.CheckBoxdefaultshowplatedetails.Checked
    AutoRefreshOn : Boolean;                             // FormxSettings.CheckBoxAutorefreshon.Checked
    LogApproval : Boolean;                               // FormxSettings.CheckBoxlogapprove.Checked
    LogDisapproval : Boolean;                            // FormxSettings.CheckBoxlogdisapprove.Checked
    LogHold : Boolean;                                   // FormxSettings.CheckBoxloghold.Checked
    LogRelease : Boolean;                                // FormxSettings.CheckBoxlogrelease.Checked
    PlateviewShowRipSystem : Boolean;                    // FormxSettings.CheckBoxplateshowripsystem.Checked
    KeepTreeExpansion : Boolean;                         // FormxSettings.CheckBoxKeeptreeexpantion.Checked
    ShowWeekNumberInTree : Boolean;                      // FormxSettings.CheckBoxShowWeekNr.Checked
    ReselectThumbnails : Boolean;                        // FormxSettings.CheckBoxreselectthumb.Checked
    ReselectPlates : Boolean;                            // FormxSettings.CheckBoxreselectplates.Checked
    SendEmailMode : Integer;                             // FormxSettings.RadioGroupSendemail.ItemIndex
    EmailServer : string;                                // FormxSettings.Editemailserver.Text
    EmailFromAddress : string;                           // FormxSettings.Editemailadress.Text
    CommaSeparatorChar : string;                         // FormxSettings.ComboBoxSepSEP.Text
    DefaultDevice : string;                              // FormxSettings.Editdefaultdevice.Text
    UseDefaultDevice : Boolean;                          // FormxSettings.CheckBoxusedefaultdevice.Checked
    PlanningGeneratePlateNames : Boolean;                // FormxSettings.CheckBoxplatenames.checked

    PostPlanSPPressrunExecute : Boolean;                 // FormxSettings.CheckBoxSPPressrunexec.checked
    PostPlanSPPressrunExecute2 : Boolean;                // FormxSettings.CheckBoxSPPressrunexec2.checked
    PostPlanSPProductionExecute : Boolean;               // FormxSettings.CheckBoxSPProductionexec.checked
    ApplyDoPostProductionProcedure : Boolean;            // FormxSettings.CheckBoxApplyDoPostProductionProcedure.Checked
    ApplyDoPostPressRunProcedure : Boolean;              // FormxSettings.CheckBoxApplyDoPostPressRunProcedure.Checked

    GenerateReportWhenDeleting : Boolean;                // FormxSettings.CheckBoxgenrepwhendel.checked
    PlanningClearPubliationsOnLoad : Boolean;            // FormxSettings.CheckBoxclearpublonload.checked
    SimplePlanLoad : Boolean;                            // FormxSettings.CheckBoxSimplePlanLoad.checked
    CustomXMLReportOutputFolder : string;                // FormxSettings.Editcustomdelcomdest.Text
    AllowControlDevices : Boolean;                       // FormxSettings.CheckBoxcontroldev.checked
    ReportTimeOut : Integer;                             // FormxSettings.ReportTimeOut.Text
    ReportSaveFolder : string;                           // FormxSettings.ReportSaveFolder.Text
    ReportOnProductionDeleteSendEmail : Boolean;         // FormxSettings.ReportOnProductionDeleteEmail.checked
    EmailUsePublicationSpecificMail : Boolean;           // FormxSettings.EmailUsePublicationSpecificMail.checked
    MailFrom : string;                                   // FormxSettings.MailFrom.text
    MailTo : string;                                     // FormxSettings.MailTo.Text
    MailCC : string;                                     // FormxSettings.MailCC.Text
    MailSubject : string;                                // FormxSettings.MailSubject.Text
    HideCommonPlates : Boolean;                          // FormxSettings.CheckBoxnocommonplates.Checked
    UnknownFilesFileNameLengthMatch : Integer;           // FormxSettings.UpDowndropdownfilter.Position ???????????
    SuperUserMaySeeAll : Boolean;                        // FormxSettings.CheckBoxsuperall.Checked
    NewProductDeleteSystem : Boolean;                    // FormxSettings.CheckBoxnewdelsys.Checked

    CustomPlanExportFilenameDefinition : string;         // FormxSettings.EditCustomplanexportfilename.Text
    ProductionShowRipSetup : Boolean;                    // FormxSettings.CheckBoxprodshowRipsetup.Checked
    PlanningExportXMLPlan : Boolean;                     // FormxSettings.CheckBoxplanexport.Checked
    PageListExportIncludeHeaders : Boolean;              // FormxSettings.CheckBoxSEPHEader.Checked
    ReimageWithHighPriority : Boolean;                   // FormxSettings.CheckBoxreimhighpri.Checked
    PlateTreeMinLevel : Integer;                         // FormxSettings.EditPlateminlevel.Text
    DayOfWeek : Integer;                                 // FormxSettings.ComboBoxdayofweek.ItemIndex
    GraphTimeFormat : string;                            // FormxSettings.ComboBoxgraphtimeformat.Text
    PreviewSeparationsOnReadview : Boolean;              // FormxSettings.CheckBoxseponreadview.Checked
    EmailLoginNameAsSenderName : Boolean;                // FormxSettings.CheckBoxemailasuser.checked
    EmailSenderName : string;                            // FormxSettings.Editsendername.Text
    EmailTitleDefinition : string;                       // FormxSettings.Editemailtitle.Text

    SeparationsUseLocaleTimeFormat : Boolean;            // FormxSettings.CheckBoxlocaltimeset.checked
    SeparationTimeFormat : string;                         // FormxSettings.Editlistime.Text
    PlateviewBoldFont : Boolean;                          // FormxSettings.CheckBoxplatefont.Checked
    PreviewCommentAsCaption : Boolean;                    // FormxSettings.CheckBoxPrevcomment.checked
    EmailPagenameDefinition : string;                     // FormxSettings.Editemailpagename.Text
    AlternativePageNameField : string;                    // FormxSettings.Editaltpagenamefield.Text
    AlternativeSheetnameField : string;                   // FormxSettings.EditAltSheet.Text
    AllowApplyPlateMerge : Boolean;                       // FormxSettings.CheckBoxApplyPlateMerge.Checked
    DefaultHidePagePlans : Boolean;                       // FormxSettings.CheckBoxDefaultHidePagePlans.Checked
    ShowReimgeDialog : Boolean;                           // FormxSettings.CheckBoxshowreimgediaglog.Checked
    ThumbnailsSingleEditionRelease : Boolean;             // FormxSettings.CheckBoxThsingleedrelease.Checked
    CheckJpegTag : Boolean;                               // FormxSettings.CheckBoxCheckJpgTag.checked
    NewCCFilesNames : Boolean;                            // FormxSettings.CheckboxNewCCFilesNames.checked
    AllowInkfileRegenerate : Boolean;                     // FormxSettings.CheckBoxAllowInkfileRegenerate.checked
    PreviewZoomStep : Integer;                            // FormxSettings.EditZoomstep.text
    PreviewMinzoom : Integer;                             // FormxSettings.EditMinzoom.text
    PreviewMaxzoom : Integer;                             // FormxSettings.EditMaxzoom.text
    DatabaseQueueInkResend : Boolean;                     // FormxSettings.CheckBoxnewinkresend.Checked
    ProductionShowPressTime : Boolean;                    // FormxSettings.CheckBoxShowPressTime.checked
    SeparateNodesPerPressrun : Boolean;                   // FormxSettings.CheckBoxSeparateNodesPerPressrun.checked
    StartupTab : Integer;                                 // FormxSettings.ComboBoxStartupTab.ItemIndex
    SetCommentOnFalseSpreads : Boolean;                   // FormxSettings.CheckBoxsetcommentonfalsespreads.checked
    OrStackpositionsTogether : Boolean;                   // FormxSettings.CheckBoxOrstacks.Checked
    EmailImageFormat : Integer;                           // FormxSettings.RadioGroupemailimageformat.ItemIndex
    ShowPlannameInTree : Boolean;                         // FormxSettings.CheckBoxplannameintree.checked
    NoProductionDeleteDebug : Boolean;                    // FormxSettings.nodeldebug
    AlwaysShowAllPresses : Boolean;                        // FormxSettings.CheckBoxAlwaysShowAllPresses.checked
    ForcePlanToApplied : Boolean;                         // FormxSettings.CheckBoxcustforcetoaplied.checked
    UseGeneratedReadViews : Boolean;                      // FormxSettings.CheckBoxpregenreadview.checked
    UseDatabasePressTowerInfo : Boolean;                  // FormxSettings.CheckBoxusepresstowerinfo.checked
    PlanningDefaultBackwardNumbering : Boolean;           // FormxSettings.CheckBoxbackwards.checked
    ThumbnailTreeMinimumLevel : Integer;                  // FormxSettings.Editminthumblevel.Text
    ThumbnailSize : Integer;                              // FormxSettings.RadioGroupthumbnailsize.itemindex
    DeadlockDelay : Integer;                              // FormxSettings.Editdeadlockdealay.Text
    ShowDataOnPlateThumbnails : Boolean;                  // FormxSettings.CheckBoxdataonplate.checked
    ShowReimageDialog : Boolean;                          // FormxSettings.CheckBoxreimage.checked
    ResetDeviceOnReimage : Boolean;                       // FormxSettings.CheckBoxreimdevicereset.checked
    ReimageAllColors : Boolean;                           // FormxSettings.CheckBoxreimcolors.checked
    NewPlateDataSystem : Boolean;                         // FormxSettings.CheckBoxnewplatedata.Checked
    SeparationMinTreeLevel : Integer;                     // FormxSettings.Editminpagetreelevel.Text
    ProductionMinTreeLevel : Integer;                     // FormxSettings.Editminprodtreelevel.Text
    PlanningUseImportCenter : Boolean;                    // FormxSettings.CheckBoxuseimportcenter.Checked
    ImportCenterInputPath : string;                       // FormxSettings.Editimportcenterinputpath.Text
    ImportCenterErrorPath : string;                       // FormxSettings.Editimportcentererrorpath.Text
    ImportCenterDonePath : string;                       // FormxSettings.Editimportcenterdonepath.Text
    ThumbnailMakeChangesOnSubeditions : Boolean;          // FormxSettings.CheckBoxthumbpagechangesonsubeditions.checked
    PreviewShowSidebar : Boolean;                         // FormxSettings.CheckBoxShowsidebar.checked
    PreviewSidebarWidth : Integer;                        // FormxSettings.Editsidebarwidth.text
    PreviewSidebarHeight : Integer;                        // FormxSettings.Editsidebarheight.text
    MustSetDeviceOnRelease : Boolean;                      // FormxSettings.CheckBoxmustsetdev.Checked
    PreviewUsePregeneratedDns : Boolean;                   // FormxSettings.CheckBoxpregendns.checked
    PlanningErrorFilesRetry : Boolean;                    // FormxSettings.CheckBoxerrorfileretry.Checked
    SeparationsReselectPages : Boolean;                     // FormxSettings.CheckBoxreselectpages.checked
    PreviewPreloadSeparations : Boolean;                   // FormxSettings.CheckBoxpageprevseps.checked
    PreviewPreloadDns : Boolean;                          // FormxSettings.CheckBoxpageprevlevel.checked
    PreviewPreloadPlateSeparations : Boolean;             // FormxSettings.CheckBoxplateprevseps.checked
    PreviewPreloadPlateDns : Boolean;                     // FormxSettings.CheckBoxplateprevlevel.checked
    PreviewPreloadInkzones : Boolean;                     // FormxSettings.CheckBoxplateprevZones.checked
    NoLoginPrompt : Boolean;                              // FormxSettings.CheckBoxNologin.checked
    PlanningAllowUnplannedColors : Boolean;               // FormxSettings.CheckBoxAllowunplannedcolors.checked
    ReleaseRuleBasedOn : Integer;                         // FormxSettings.RadioGroupreleaserulebase.itemindex
    InkWarningLevel : Integer;                            // FormxSettings.UpDowninklimit.Position
    AutoScrollspeed : Integer;                            // FormxSettings.UpDownAutoscroolspeed.Position
    UsePageIndexForSorting : Boolean;                     // FormxSettings.CheckBoxpagename.Checked
    SeparationsVisibleColumns : Integer;                 // FormxSettings.UpDownVisiblecols.Position
    SeparationsExportOnlySelectedRows : Boolean;          // FormxSettings.CheckBoxOnlyselection.Checked
    PlanningDefaultUseAllMarkGroups : Boolean;            // FormxSettings.CheckBoxallmarkgroups.Checked
    PlateHideNamesOnThumbnails : Boolean;               // FormxSettings.CheckBoxhideprogthumb.Checked
    PlanningDefaultToMono : Boolean;                      // FormxSettings.CheckBoxdefaultK.Checked
    PlanningUsePublicationDefaults : Boolean;            // FormxSettings.CheckBoxusepublicationdefaults.Checked
    SeparationsAllowShowAllPublications : Boolean;        // ForSettings.CheckBoxpagesshowall.Checked
    PlatesAutoReimageOnDeviceChange : Boolean;            // FormxSettings.CheckBoxplateReimondevch.Checked
    PlatesAllowSinglePagePreview : Boolean;               // FormxSettings.CheckBoxplatepagepreview.Checked
    ExternalTiffEditorPath : string;                      // FormxSettings.Editexternedittif.Text
    ExternalPDFEditorPath : string;                      // FormxSettings.Editexterneditpdf.Text
    TreeUseTreeUpdateTable : Boolean;                     // FormxSettings.CheckBoxnewtreeload.Checked
    ThumbnailsShowMonoPDFIndicator : Boolean;             // FormxSettings.CheckBoxthumbshowmono.Checked
    AddEditionDefaultUniqueType : Integer;                    // FormxSettings.RadioGroupdefaultpagetypeaddedition.ItemIndex
    AddEditionDefaultApprovalUniquePage : Integer;        // FormxSettings.RadioGroupdefaultUniqePaddedition.ItemIndex
    AddEditionDefaultApprovalCommonPage : Integer;        // FormxSettings.RadioGroupdefaultCommonPaddedition.ItemIndex
    AddEditionDefaultKeepDevice : Integer;                // FormxSettings.RadioGroupdefaultDeviceaddedition.ItemIndex
    AddEditionDefaultHold : Integer;                      // FormxSettings.RadioGroupdefaultHoldaddedition.ItemIndex
    ThumbnailShowPitstopLog : Boolean;                    // FormxSettings.CheckBoxShowpitstoplog.Checked
    ShowPanelUnknownFiles : Boolean;                      // FormxSettings.CheckBoxShowPanelUnknown.Checked
    ShowPanelUnknownFilesRefreshTime : Integer;           // FormxSettings.EditCheckTimeUnknown.Text
    PlanningDefaultFirstEdition : string;                 // FormxSettings.Editdefaultfirsted.Text  editzoomstep

    EnableEditOfMiscInt2: Boolean;                      // FormxSettings.CheckListBoxMiscedit[0]
    EnableEditOfMiscInt3: Boolean;                      // FormxSettings.CheckListBoxMiscedit[1]
    EnableEditOfMiscString2: Boolean;                      // FormxSettings.CheckListBoxMiscedit[2]
    EnableEditOfMiscString3: Boolean;                      // FormxSettings.CheckListBoxMiscedit[3]
    PlanningAutoSetEditionsOnLoad : Boolean;                // FormxSettings.CheckBoxautosetedonload
    PlateTransmissionSystem : Boolean;                    // FormxSettings.CheckBoxpreparetrans
    SetApproveTimeOnRelease : Boolean;                    // FormxSettings.CheckBoxapprovetimeonrelease.checked
    SetCommentOnAllEditions : Boolean;                    // FormxSettings.CheckBoxdefaultsetcomed.checked
    PlanningRunThroughPagination : Boolean;               // FormxSettings.CheckBoxruntrhoughpagina.checked
    AddTimeToPageComment : Boolean;                      // FormxSettings.CheckBoxCommenttime.checked
    ReportSeparator  :string;                             // FormxSettings.ComboBoxreportdetailsave.text
    DefaultReportFolder : string;                        // FormxSettings.EditDeafaultreportfolder.text
    PlanXMLExportFolder : string;                        // FormxSettings.EditCustomplanexportdest.text
    PlanningDefaultColorProofer : string;                 // FormxSettings.ComboBoxcolorproof.text
    PlanningDefaultPDFProofer : string;                   // FormxSettings.ComboBoxpdfproof.text
    PlanningDefatulMonoProofer : string;                  // FormxSettings.ComboBoxBWproof.text

    PlanningOnlyShowDefaultPressPublications : Boolean;           // FormxSettings.ComboBoxOnlyShowDefaultPressPublications
    TreeShowAliasFirst : Boolean;                         // FormxSettings.CheckboxTreeShowAliasFirst.Checked

    UsePlanLock : Boolean;                              // FormxSettings.CheckBoxExclusive.checked
    PlanningPaginationMode : Integer;                   // FormxSettings.ComboBoxdefpagina.ItemIndex
    ReportIncludeHeaders : Boolean;                     // FormxSettings.CheckBoxsavereportdetailcolumns.Checked
    ThumnailsShowHold : Boolean;                          // FormxSettings.CheckBoxthumbshowhold.checked
    MenuToolbarColor : string;                            // FormxSettings.ColorBoxMenuToolbar.Selected
    ToolbarColor : string;                            // FormxSettings.ColorBoxToolbar.Selected
    ToolbarSelectedColor : string;                            // FormxSettings.ColorBoxToolbarSel.Selected

    CheckForUnknownFilesTimer : Boolean;                   // FormxSettings.CheckBoxunknowncheck.Checked
    CheckForUnknownFilesTimerInterval : Integer;                   // FormxSettings.Editunknowndropdownfilter.Text

    SeparationsFullAutorefresh : Boolean;                 // FormxSettings.CheckBoxpagefullautorefresh.Checked
    SeparationsResetDeviceOnReimage : Boolean;              // FormxSettings.CheckBoxlistredevatreim.Checked
    SeparationsShowStatusIcons : Boolean;                 // FormxSettings.CheckBoxpageicons.Checked
    ThumbnailsShowExternalStatus : Boolean;               // FormxSettings.CheckBoxthumbshowextstat.checked
    PlatesShowTemplateInCaption : Boolean;                // FormxSettings. CheckBoxShowtemplateincaption.checked

    ShowDeviceControl : Boolean;                          // FormSetings.CheckBoxshowdevcontrol.checked
    DeviceControlUsePressDevices : Boolean;               // FormxSettings.CheckBoxpressindevcontrol.checked
    TreeOrderByEditionID : Boolean;                       // FormxSettings.CheckBoxtreebyedid.checked
    AllowDropFiles : Boolean;                            // FormxSettings.CheckBoxAllowDropFiles.Checked
    AllowDropFilesDialog : Boolean;                       // FormxSettings.CheckBoxAllowDropFilesDialog.Checked
    DropFilesDestination : string;                        // FormSetting.EditDropFilesDestination.Text
    ThumbnailAllowSetFalseSpread : Boolean;                   // FormxSettings.CheckBoxAllowfalsespret.checked
    ThumbnailResetStatusOnPageTypeChange : Boolean;       // FormxSettings.CheckBoxstatresetonpagetypechange.checked
    PreviewShowInkZones : Boolean;                        // FormxSettings.CheckBoxShowInkZones.checked
    PlanningUsePublicationDefaultlPriority : Boolean;    // FormxSettings.CheckBoxPlanpri.checked
    PlatesShowPagesStanding : Boolean;                    // FormxSettings.CheckBoxplatespecialstanding.Checked
    TreeFilterOnProductionDate : Boolean;                 // FormxSettings.CheckBoxpublfilreonproddate.Checked
    PlatePrintoutUseSectionPage : Boolean;                // FormxSettings.CheckBoxplateprtsecpage.Checked
    PlanningHotTimeFromDeadline : Boolean;                 // FormxSettings.CheckBoxhttimedeadline.Checked
    PlanningHotTimeFromDeadlineAddHours : Integer;          // FormxSettings.Edithottimehours.Text
    ArchiveLowResNameDefinition : string;                // FormxSettings.Editlowarch.text
    ArchiveLowResDateDefinition : string;                 // FormxSettings.Editarchdate.text
    HotHourPriorityDifference : Integer;                 // FormxSettings.UpDownhothours.Position
    HotHourPriorityLength : Integer;                      // FormxSettings.UpDownhotlength.Position
    HotHourPriorityBefore  : Integer;                   // FormxSettings.UpDownhotbefore.Position
    HotHourPriorityDuring  : Integer;                   // FormxSettings.UpDownhotunder.Position
    HotHourPriorityAfter  : Integer;                   // FormxSettings.UpDownhotafter.Position
    AutoRefreshSpeed : Integer;                         // FormxSettings.UpDownautorefresh.Position
    TreeAutoRefreshSpeed : Integer;                     // FormxSettings.UpDownnewtreeupdate.Position
    DeviceAutoRefreshSpeed : Integer;                   // FormxSettings.UpDownupddevcontrol.Position

    EditionsAssignUniqueToLocalOnly : Boolean;          // FormxSettings.Checkboxuniqloconly

    // Custom stuff
    CheatPecom : Boolean;
    DongAInkVisible: Boolean;                           // FormxSettings.CheckBoxDongA.Checked
    PlanningAutoOrderNumberBergen : Boolean;              // FormxSettings.CheckBoxAutoplannumbergen.checked

  //  PlanningCreateDoPostPressRunProcedure : Boolean;    // FormxSettings.CheckBoxSPPressrunexec
  //  PlanningCreateDoPostPressRunProcedure2 : Boolean;    // FormxSettings.CheckBoxSPPressrunexec2
  //  PlanningCreateDoPostProductionProcedure : Boolean;    // FormxSettings.CheckBoxSPProductionexec
    EditionsSetForceWhenCommon : Boolean;                // FormxSettings.CheckBoxforcewhencommon,Check

    // Moved from FormMain.
    OverwritePlanLogFilepath : string;
    FirstColumnDescentingSort : Boolean;                // FormMain.firstsortcoldirectiondesc
    FirstSortColumnName : string;                       // FormMain.firstsortcolname

    ReleaseRules : array of Boolean;                    // FormxSettings.CheckListBoxreleaserules.checked[]
    SectionText : array of Boolean;                     // FormxSettings.CheckListBoxSectionText
    ThumbnailStatusBar : TNameEnabledType;               // FormxSettings.CheckListBoxthumbstatbar
    TreeExtraPublicationText : array of Boolean;      // FormxSettings.CheckListBoxextrafiltertext[..]
    TreeExtraEditionText : array of Boolean;          // FormxSettings.CheckListBoxEditionText.Checked[..]
    ThumbnailCaptionText : TNameEnabledType;          //  FormxSettings.CheckListBoxthumbtext.Checked[i]
    ThumbnailGroupCaptionText : TNameEnabledType;          //  FormxSettings.CheckListBoxthgroupecap.Checked[i]
    PlateText : TNameEnabledType;                 // FormxSettings.CheckListBoxPlatetext
    PlateCaptionText : TNameEnabledType;                 // FormxSettings.CheckListBoxplatecaption
    TowerNameTranslation : TValueListType;                // FormxSettings.ValueListEditortowerfilters.Strings
    CylinderNameTranslation : TValueListType;             // FormxSettings.ValueListEditorCyl
    MaxPagesPerPress : TValueListType;                  // FormxSettings.ValueListEditormaxpagepress
    OldInkPathsPerPress : TValueListType;               // FormxSettings.ValueListEditorOldInk
    InkGenerationSystemPerPress : TValueListType;       // FormxSettings.ValueListEditorInkGen

    SeparationsReportColumns : array of Boolean;       // FormxSettings.CheckListBoxdetailsavecols.Checked[i]
    PlatePrintListTitleDefinition : array of Boolean;   // FormxSettings.CheckListBoxPLtPrnttitle.Checked[i]
    PlatePrintListPlateDefinition : array of Boolean;   // FormxSettings.CheckListBoxPLtPrntplate.Checked[i]

    PressRunTexts : TNameEnabledType;                     // FormxSettings.CheckListBoxpressruntexts
    ProductionColumns : TProductionColumnType;   // FormxSettings.StringGridprods og ChechListBox
    ProductionGridFonts : TProductionGridFontType;       // FormSetting.Prodgridfonts
    NewlineInThumbnails : Boolean;                      // FormxSettings.NewlineInthumb1
    ShowThumbnailGroups : Boolean;                      // FormxSettings.Showthowthumbgrps
    ThumbnailEvents : TNameEnabledType;                 // FormxSettings.CheckListBoxThumbevents.checked[i]
    PlannedNameDefinitions : TPlannedNameDefinitionType; // FormxSettings.ListViewplannamedstyles

    DefaultUnknownFilesFolders : TNameEnabledType;        // FormxSettings.CheckListBoxdefunknown.Checked[i]
    EventLogs : TNameNumberEnabledType;                         // FormxSettings.ListVieweventlogs.items
    StatusWarningList : TNameEnabledType;                 // FormxSettings.CheckListBoxwarnstatus
    ExtStatusWarningList : TNameEnabledType;                 // FormxSettings.CheckListBoxwarnext
    DataExportColumns : TNameEnabledType;                 // FormxSettings.CheckListBoxexport;
    WarnIfAnyDisapproved : Boolean;                       // FormxSettings.CheckBoxwarnifanydisapproved

    ThumbnailGapVertical : Integer;
    ThumbnailGapHorizontal : Integer;
    ThumbnailInnerMargin : Integer;
    ThumbnailCaptionHeight : Integer;

    CustomReleaseScript : TStringList;

    CustomManualStackerSet : Boolean;                    // FormxSettings.CheckBoxUseNiceManualStacker
    ShowPageNoteIndicator : Boolean;                     // FormxSettings.CheckBoxShowPageNote


    AllowLocationPressAllSelection : Boolean;
    AllowOnlyDefaultLocationPress : Boolean;
    LocationPressFilterMode : Integer;
    DefaultLocation : string;                            // FormxSettings.ComboBoxlocations.text
    DefaultPress : string;                               // FormxSettings.ComboBoxDefaultPress.text

    FlatLook : Boolean;
    DefaultSaveToLocalFolder : Boolean;
    DefaultCSVReportfolder : string;                     // FormxSettings.EditDefaultCSVReportfolder.text
    ExcelEmailOption : Integer;                // FormxSettings.adioGroupExcelEmailOption
    DefaultExcelEmailTO : string;
    DefaultExcelEmailCC : string;
    DefaultExcelEmailSUBJ : string;
    PlanLoadPromptForSectionEdition : Boolean;

    ShowPanelUnknownFilesWidth : Integer;
    TreeShowPagesOutOfRange : Boolean;                  // FormxSettings.CheckBoxShowPagesOutOfRange.Checked

    ExternalPlanLoaderExe : string;                    // FormxSettings.EditExternalPlanLoadExe
    UseExternalPlanLoad : Boolean;                     // FormxSettings.CheckBoxUseExternalPlanLoad
    ThumbnailsAllowPdfRotation : Boolean;

    ThumbnailsShowAlsoForcedPages : Boolean;          // FormxSettings.CheckboxThumbnailsShowAlsoForcedPages

    RestrictUniqueDelete : Boolean;                     // FormxSettings.CheckboxRestrictUniqueDelete

    CustomBuildName: string;                      // SPECIAL FOR Schibsted STB hacks..!

    UseMultiPressTemplateLoad : Boolean;                // FormxSettings.

    GeneratePlanPageNames : Boolean;                      // FormxSettings.CheckBoxGeneratePlanPageNames
    XMLPlanAddTimestampToFileName : Boolean;
    AllowMovePages : Boolean;

    SetReleaseNowOnReimage :    Boolean;

    GetAllUnplannedPagesMode : Integer;

    PlanCenterFileServerType : Integer;

    ColorBoxMenuToolbarSelected : TColor;
    ColorBoxToolbarSelected : TColor;
    ColorMapToolBarSelectedColor : TColor;
    FontDialogplateprintFont : TFont;

    // Moved from ULogin
    LoggedOut : boolean;
    LoggedIN         : Boolean;
    LoginError : Boolean;
    Username : string;
    UsernameOnStatusbar : string;
    LastUser : boolean;
    Usergroup : longint;
    Usergroupname : string;
    MayConfigure     : Boolean;
    MayReImage       : Boolean;
    MayKillColor     : Boolean;
    MayRunProducts   : Boolean;
    MayDeleteProducts  : Boolean;
    MayApprove       : Boolean;
    Readonly         : Boolean;
    IsAdministrator : Boolean;
    IsSuperuser     : Boolean;

  public
    constructor Create(AOwner: TComponent); override;
    procedure PreLoadIniFile;
    procedure LoadIniFile;
    procedure LoadIniFileAfterDBInit;
    procedure SaveIniFile;
    procedure SaveIniDatabaseDetails;
    function MakeDateTimeString(DateTime : tdatetime):String;
    procedure SetErrorFolders;
    procedure SetVisibleTowers;
    procedure ReadDataExportColumns;
    procedure SetFileServerAlternativeIP;
    procedure SaveWarningSystem;

    procedure LoadSpecificFont(FStream: TIniFile; Section: string; smFont: TFont);
    procedure SaveSpecificFont(FStream: TIniFile; Section: string; smFont: TFont);
    function  VisiblePressConfigNameVisible(name : string) : Boolean;

    procedure LoadShortCuts;
    procedure SaveShortCuts;
    procedure LoadWarningSystem;


 const
    PRODUCTIONCOLUMNCOUNT = 28;
    DATALISTCOLUMNSCOUNT = 55;
   // Constant_LenghtCheckListBoxthumbtext = 14;
   // Constant_Length_CheckListBoxthgroupecap = 3;


    DefaultEventsOn : set of byte= [6,10,16,20,26,30,46,50,70,71,80,81,90];

    DefaultProductionColumnNames : array[0..27] of string = ('Press','State','Priority','Publication','Edition',
            'Section','Copy','Device','N/A','FTP','Pre','Inksave','RIP','Input','Approval','Output','Normal/Panorama',
            'Comment','Ink comment','Order number','Rip setup','Creep','Pageformat','Tower','DeviceGroup','Press section no','Output order','N/A');

     CheckListBoxSectionTextItems : array[0..5] of string = ('Pressrun comment','Press sequense number', 'PressrunID','Only pressrun comment','Pagetable comment','InkComment');
     CheckListBoxextrafiltertextItems :  array[0..9] of string = ( 'Week number','Pressrun ordernumber','Pressrun comment','Customer name','Input alias','Ink comment','Inkalias','OutputAlias','Presstime','Production ordernumber');
     CheckListBoxEditionTextItems : array[0..3] of string = ('Ink Comment','Comment','Order number','Press time');
     CheckListBoxplatecaptionItems : array[0..26] of string = ('Sheet','Side','pagina','pageindex','Copy','Tower','Platenumber','Pagename','Low pageindex','Low pagina','Device','Edition','Section',
                                                                    'Layout','Planedpagename','Altpagename','Alt Low pageindex','Alt Low pagina','Alt sheet','Layout Alias','Zone','InkAlias','DeviceAlias','Master edition','Low/High','SortingPosition','Ink name (MiscString3)');
     CheckListBoxPlatetextItems    : array[0..4] of string = ('Common edition','Section', 'Alt pagename', 'InkPlatenumber', 'Zone');

     CheckListBoxpressruntextsItems : array[0..7] of string = ('Press','Pubdate','Publication','Edition','Section','Layout Alias','Runs', 'InkComment');

     CheckListBoxthumbtextItems  : array[0..14] of string = ('Pagename','Edition','Section','Location','version','Publication','PageIndex','Plannedname','Comment','Press','Pagina','#','Master edition','Page format','Short planpagename');
     ListBoxthumborderItems    : array[0..8] of string = ('publication','edition','section','pageindex','location','PresssectionNumber','Press','Pagination','PageName');

     CheckListBoxThumbeventsItems : array[0..4] of string = ('FTP','Preflight','Rip','Color level','Ink save');
     CheckListBoxthgroupecapItems :  array[0..2] of string = ('Location','Edition','Section');
     CheckListBoxthumbstatbarItems : array[0..3] of string = ( 'Proof','Pageformat','Page arrival','Page approval');
     MemoShorteventItems : array[0..4] of string = ( 'FTP','PRE','RIP','COL','INK');

     CheckListBoxPLtPrnttitleItems : array[0..3] of string = ('Press','Publication','Pubdate','Edition');

     CheckListBoxPLtPrntplateItems :  array[0..3] of string = ('Press','Publication','Pubdate','Edition');
     CheckListBoxAFoldernameItems :  array[0..4] of string = ('Location','Pub. date','Publication','Edition','Section');
     CheckListBoxreleaserulesItems :  array[0..6] of string = ('Device','Tower','Cylinder','Zone','High/low','Sorting position','Comment');

     CheckListBoxdetailsavecolsItems : array[0..19] of string = ('Publ.Date','Publication','Edition','Section','Location','Press','Page','UniquePage','CopyNumber','Color','Status','Approved','Released','Inputtime','Approvetime','Outputtime','Device','Deadline','Comment','Pageindex' );
end;




implementation

uses
  UMain, USettings, UProdPlan, UAddpressrun, UTypes, Udata, UUtils,
  Vcl.Dialogs;

constructor tPrefs.Create(AOwner: TComponent);
var
  preIni  : TIniFile;
  IniFileMaster : string;
begin
  inherited Create(AOwner);

  CustomReleaseScript := TStringList.Create;
  Debug := false;
  PlanCenterConfigFileName := 'PlanCenter.ini';

  IniFileMaster := ExtractFilePath(Application.ExeName) + 'PlanCenterMaster.ini';

  if (FileExists(IniFileMaster)) then
  begin
    try
      preIni := TIniFile.Create(IniFileMaster);
      PlanCenterConfigFileName := preIni.ReadString('System','PlanCenterConfigFileName','PlanCenter.ini');
      preIni.Free;
    except
    end;
  end;

  if (PlanCenterConfigFileName = '') then
    PlanCenterConfigFileName := 'PlanCenter.ini';

  FontDialogplateprintFont := TFont.Create;
  FontDialogplateprintFont.Assign(FormMain.Canvas.font);

  MayConfigure := false;
  MayReImage := true;
  MayKillColor := true;
  MayRunProducts := true;
  MayDeleteProducts := true;
  MayApprove := true;
  ReadOnly := false;
  LastUser := false;
  IsAdministrator := false;
  IsSuperuser := false;
  UsergroupName := '';
  Usergroup := 0;
  UsernameOnStatusbar := '';
  Username := '';
end;

// Called from FormMain.Create

procedure tPrefs.PreLoadIniFile;
var
 ini : TIniFile;
 IniFile : string;
begin

  try
    IniFile := TUtils.GetPlanCenterIniFilePath(PlanCenterConfigFileName);
    if (not FileExists(IniFile)) then
      MessageDlg('WARNING - inifile ' + IniFile + ' not found - using defaults' , mtWarning,[mbOk], 0);

    ini := TIniFile.Create(IniFile);

    CustomBuildName := ini.ReadString('System','CustomBuildName','');
    PlanCenterFileServerType  :=  ini.ReadInteger('System','PlanCenterFileServerType', 11);

    Debug := ini.ReadBool('System','debug',false);
    Caption := ini.ReadString('System','Caption',FormMain.Caption);
    Proversion   := ini.Readinteger('system','pro',0); //0 enterprice,1gammelpro, 2 ny lillepro
    AllowMultipleInstances := ini.Readbool('System','multibleinstance',false);

    SimpleUserLookup   := ini.Readbool('System','SimpleUserLookup',true);

    ShowPanelUnknownFilesWidth := ini.ReadInteger('System','EditUnknownFilesPanelWidth', 125);

    FixedDomain := ini.ReadString('System','FixedDomain','');

    DBServerName := ini.ReadString('server1','Servername','');
    if (DBServerName = '') then
      DBServerName := ini.ReadString('System','Servername','');

    DBDatabase   := ini.ReadString('server1','Database','');
    if (DBDatabase = '') then
      DBDatabase   := ini.ReadString('System','Database','');

    // Separate server and instance name
    DBInstance := '';
    if Pos('\', DBServerName) > 0 then
    begin
      DBInstance := Copy(DBServerName, Pos('\', DBServerName)+1, Length(DBServerName));
      Delete(DBServerName, Pos('\', DBServerName), Length(DBServerName));
    end;

    DBUser := ini.ReadString('server1','DBUser','');
    DBPassword := TUtils.DecodeBlowfish(ini.ReadString('server1','DBPassword',''));
    DBUsebackup := ini.ReadBool('server1','Usebackup',false);
    DSN := ini.ReadString('server1','DSN','');

    // Backup stuff not currently used.
    DBBackupServerName := ini.ReadString('server1','BACKUPServername','');
    DBBackupDatabase := ini.ReadString('server1','BACKUPDatabase','');
    DBBackupInstance := '';
    if Pos('\', DBBackupServerName) > 0 then
    begin
      DBBackupInstance := Copy(DBBackupServerName, Pos('\', DBBackupServerName)+1, Length(DBBackupServerName));
      delete(Prefs.DBBackupServerName, Pos('\', DBBackupServerName), Length(DBBackupServerName));
    end;

    DBBackupUser := ini.ReadString('server1','BACKUPDBUser','');
    DBBackupPassword := TUtils.DecodeBlowfish(ini.ReadString('server1','BACKUPDBPassword',''));
    BackupDSN := ini.ReadString('server1','BACKUPDSN','');

    DBreconnect := ini.ReadBool('server1','DBreconnect',true);
    DBFetchAll := ini.ReadBool('server1','DBFetchAll',true);
    DBCommandTimeout := ini.Readinteger('server1','DBCommandTimeout',30);

    ColorBoxMenuToolbarSelected := StringToColor(ini.ReadString('System','ColorBoxMenuToolbarSelected','$02FF8800'));
    ColorBoxToolbarSelected := StringToColor(ini.ReadString('System','ColorBoxToolbarSelected','$02FF8800')); ;
    ColorMapToolBarSelectedColor := StringToColor(ini.ReadString('System','ColorMapToolBarSelectedColor','$02FF8800'));

    ini.Free;
  except

  end;
end;

// Called in FormMain.Activate (after FormSettings.Create..)

procedure tPrefs.LoadIniFile;
var
 ini  : TIniFile;
 n,i,j  : Integer;
 t,t2    : string;
begin

  try

//    t := TUtils.GetPlanCenterIniFilePath();
//    if (not FileExists(t)) then
//      MessageDlg('WARNING - inifile ' + t + ' not found - using defafults' , mtWarning,[mbOk], 0);

    ini := TIniFile.Create(TUtils.GetPlanCenterIniFilePath(PlanCenterConfigFileName));


    PlanCenterFileServerType  :=  ini.ReadInteger('System','PlanCenterFileServerType', 11);

    GetAllUnplannedPagesMode  :=  ini.ReadInteger('System','GetAllUnplannedPagesMode', 0);

    UsePreviewCache := ini.Readbool('System','UsePreviewCache',false);
    PreviewCacheShare := ini.ReadString('System','PreviewCacheShare','');

    UseMultiPressTemplateLoad    := ini.Readbool('System','UseMultiPressTemplateLoad',false);
    ThumbnailsShowAlsoForcedPages := ini.Readbool('System','ThumbnailsShowAlsoForcedPages',true);
    PreviewForceGrayBackground  := ini.Readbool('System','PreviewForceGrayBackground',true);

    SetReleaseNowOnReimage  := ini.Readbool('System','SetReleaseNowOnReimage',true);
    GeneratePlanPageNames  := ini.Readbool('System','GeneratePlanPageNames',false);

    AllowMovePages  := ini.Readbool('System','AllowMovePages',false);
    RestrictUniqueDelete  := ini.Readbool('System','RestrictUniqueDelete',true);

    TreeShowAliasFirst  := ini.Readbool('System','TreeShowAliasFirst',false);

    TreeShowPagesOutOfRange := ini.Readbool('System','CheckBoxShowPagesOutOfRange',false);
    TreeShowWeekNumberInfo := ini.Readbool('System','TreeShowWeekNumberInfo',false);
                                                          //CheckBoxTreeShowWeeknumberAlso
    XMLPlanAddTimestampToFileName  := ini.Readbool('System','XMLPlanAddTimestampToFileName',false);

    UseExternalPlanLoad := ini.Readbool('System','CheckBoxUseExternalPlanLoad',false);
    ExternalPlanLoaderExe := ini.ReadString('System','EditExternalPlanLoadExe','');

    ShowPanelUnknownFilesWidth := ini.ReadInteger('System','EditUnknownFilesPanelWidth', 125);
    PlanningOnlyShowDefaultPressPublications := ini.Readbool('System','PlanningOnlyShowDefaultPressPublications',false);
    ThumbnailsAllowPdfRotation  := ini.Readbool('System','ThumbnailsAllowPdfRotation',false);

    PlanLoadPromptForSectionEdition := ini.Readbool('System','PlanLoadPromptForSectionEdition',true);
    FlatLook := ini.ReadBool('System','FlatLook', true);
    DefaultSaveToLocalFolder := ini.ReadBool('System','CheckBoxExcelSaveToFolder', true);
    DefaultCSVReportfolder := ini.ReadString('System','EditDefaultCSVReportfolder','c:\temp');

    DefaultExcelEmailTO := ini.ReadString('System','EditDefaultExcelEmailTO','');
    DefaultExcelEmailCC := ini.ReadString('System','EditDefaultExcelEmailCC','');
    DefaultExcelEmailSUBJ := ini.ReadString('System','EditDefaultExcelEmailSUBJ','ControlCenter report');

    ShowLogStoredProc := ini.ReadString('System','ShowLogStoredProc','spPlanCreateDeleteLog');

    ExcelEmailOption := ini.ReadInteger('System','RadioGroupExcelEmailOption', 0);


    LocationPressFilterMode := ini.ReadInteger('System','RadioGroupLocationPressFilterMode', LOCATIONPRESSSFILTERMODE_PRESS);
    AllowLocationPressAllSelection := ini.ReadBool('System','CheckBoxAllowLocationPressAllSelection',false);
    AllowOnlyDefaultLocationPress := ini.ReadBool('System','CheckBoxAllowOnlyDefaultLocationPress',false);

    LimitTowers := ini.ReadBool('System','CheckBoxLimitTowers',false);

    WritePlanLogFile := ini.ReadBool('System','Writeplanlogfile',true);
    PlannningMaxPlateFrames := ini.ReadInteger('System','Maxplateframes', 100);
    IgnoreImposeCalcNumbering := ini.ReadBool('System','cheatImpose',false);

    OnlyConnectPlanCenterUser := ini.ReadBool('System','CheckBoxOnlyConnectPlanCenterUser',true);

    UseAdministrativeGroups := ini.ReadBool('System','CheckBoxUseAdministrativeGroups',false);
    UseADGroups := ini.ReadBool('System','CheckBoxUseADGroups',false);
    UseWindowsUser := ini.ReadBool('System','CheckBoxUseWindowsUser',false);


    n := ini.ReadInteger('stack','Nstack',0);
    SetLength(StackNamesList, n);
    for i := 0 to n-1 do
      StackNamesList[i] := ini.ReadString('stack','stack'+IntToStr(i+1),'none');

    n := ini.ReadInteger('Zone','NZone',0);
    SetLength(ZoneNamesList, n);
    for i := 0 to n-1 do
      ZoneNamesList[i] := ini.ReadString('Zone','Zone'+IntToStr(i+1),'none');

    n := ini.ReadInteger('Markgroup','NMarkgroup',0);
    SetLength(DefMarksList, n);
    for i := 0 to n-1 do
      DefMarksList[i] := ini.ReadString('Markgroup','Markgroup'+IntToStr(i+1),'none');

    n := ini.ReadInteger('ListViewFilter','NFilter',0);
    SetLength(FilterList, 0);
    j := 0;
    for i := 0 to n-1 do
    begin
      t := ini.ReadString('ListViewFilter','ListViewFilter'+IntToStr(i+1),'*.*');
      if (tUtils.IsInStringArray(t, FilterList) = false) then
      begin

        SetLength(FilterList, j+1);
        FilterList[j] := t;
        Inc(j);
      end;

    end;

    if (j = 0) then
    begin
     SetLength(FilterList, 1);
     FilterList[0] := '*.*';
    end;

  (*
    n := ini.ReadInteger('Tower','NTower',1);
    SetLength(PressTowers, n);
    for i := 0 to n-1 do
    Begin
      PressTowers[i].Tower := ini.ReadString('Tower','Tower'+IntToStr(i+1),'');
      PressTowers[i].Press := ini.ReadString('Tower','Press'+IntToStr(i+1),'');
    end;
  *)

    n := ini.ReadInteger('cyl','Ncyl',1);
    SetLength(CylinderNameTranslation, 0);
    j := 0;
    for i := 0 to n-1 do
    Begin
      t :=  ini.ReadString('cyl','cyl'+IntToStr(i+1),'');
      t2 :=    ini.ReadString('cyl','cylvalue'+IntToStr(i+1),'');

       if  (t <> '') AND (t2 <> '') then
       begin
           SetLength(CylinderNameTranslation, j+1);
           CylinderNameTranslation[j].Key := t;
           CylinderNameTranslation[j].Value := t2;
           Inc(j);
       end;
    End;

    AutoRefreshSpeed  := ini.ReadInteger('System','Autorefreshspeed',20);
    TreeAutoRefreshSpeed  := ini.ReadInteger('System','Treerefreshspeed',60);
    DeviceAutoRefreshSpeed  := ini.ReadInteger('System','UpDownupddevcontrol',30);


    MinAutoRefresh  := ini.ReadInteger('System','Minautorefresh',30);
    MinTreeRefresh  := ini.ReadInteger('System','Mintreerefresh',30);
    MinDeviceRefresh  := ini.ReadInteger('System','Mindevicefresh',10);

    AutoLogin := ini.ReadBool('System','AutoLogin',true);
    AutoLoginUser := ini.ReadString('System','EditAutoLoginUser','');
    AutoLoginPassword := TUtils.DecodeBlowfish(ini.ReadString('System','EditAutoLoginPassword', ''));

    AutoConsole := ini.ReadBool('System','CheckBoxautoconsole', false);
    ConsoleName := ini.ReadString('System','Editconsolename', Thisdevicename);
    MaxConsoleAge := ini.ReadInteger('System','Editmaxconsoleage', 60);

    UseConfigurablePagination := ini.ReadBool('System','usenewpagina',false);
    LocalMode := ini.ReadBool('System','localmode',false);

    NcolsSeparationView := ini.ReadInteger('System','gridSize', 30);
    AutoTowerOrder := ini.ReadBool('System','CheckBoxtowerorderauto',false);

    DeleteOnlyOnSelectedPress := ini.Readbool('System','CheckBoxdelonlyselon', true);

    CustomPlanCheck := ini.ReadBool('System','CheckBoxcustomplancheck', false);
    CustomCheckSystemName := ini.ReadString('System','EditCustomchecksystemname', '');
    CustomManualStackerSet := ini.ReadBool('System','CheckBoxUseNiceManualStacker', false);

    UseHoneywell := ini.ReadBool('System','CheckBoxUsehoneywell', false);
    PathToHoneywell := ini.ReadString('System','EditPathtohoneywell', '');
    HoneywellUsername := ini.ReadString('System','EditHoneywellusername', '');
    HoneywellPassword := ini.ReadString('System','EditHoneywellpassword', '');

    TreeShowPagesReadyFlag := ini.ReadBool('System','CheckBoxTreeShowPagesReadyFlag',false);
    AlwaysFullTreeExpand := ini.ReadBool('System','AlwaysfullTreeExpand',false);

    AllowPageDelete := ini.ReadBool('System','CheckBoxpagedelete', false);

    UseAdobeView := ini.ReadBool('System','useadobeview',true);

    SwapPlateMerger := ini.ReadBool('System','CheckBoxswapplatemerger',false);

    ProductionSelectAllCopies := ini.ReadBool('System','CheckBoxSellallcopiesprod',false);

    ProductionReleaseHoldAllCopies := ini.ReadBool('System','CheckBoxprodreleaseholdallcopy',false);
    DefaultThumbnailOnlyPagePlans :=  ini.ReadBool('System','CheckBoxDefaultThumbnailOnlyPagePlans', false);
    ThumbnailForceReadorder := ini.ReadBool('System','CheckBoxforcereadorder', false);
    PlateDetailsOff  := ini.ReadBool('System','CheckBoxplatedetailof', false);
    GrayDensityMap := ini.Readbool('System','CheckBoxgraydns', true);

    MinTreeLevelLog :=  ini.ReadInteger('System','Editminlogtree', 2);

    PlanLoadDefaultToNoTemplateChange := ini.ReadBool('System','CheckBoxdefnochangetmpl', false);
    EditionUseAsMasterIgnorePress := ini.ReadBool('System','CheckBoxeditionignorepress',false);

    UnknownPDFfolder := ini.Readstring('System','Editunknownpdf', MAINCC+ '\CCPDFUnknownFiles');
    PDFArchivefolder := ini.Readstring('System','Editarchivepath',MAINCC+ '\CCPDFArchive');

    SelectAllCopiesOnReimage := ini.ReadBool('System','CheckBoxreimcopies', false);
    SelectAllCopiesOnRelease := ini.ReadBool('System','CheckBoxSelectAllCopiesOnRelease',false);
    ClearDeviceOnLayoutChange := ini.ReadBool('System','CheckboxClearDeviceOnLayoutChange',false);
    ExcludeArchiveFilter  :=  ini.ReadString('System','EditExcludeArchiveFilter','');

    KeepOutputVersionOnReimage  := ini.ReadBool('System','CheckBoxKeepOutputVersionOnReimage',false);

    EnsurePreviewFormInFront := ini.ReadBool('System','CheckBoxEnsurePreviewFormInFront',false);
    LeanAndMeanPreview  := ini.ReadBool('System','CheckBoxLeanAndMeanPreview', false);

    SpecialHalfwebAtMinPage := ini.ReadInteger('HalfWeb special setting','Fix halfweb at min. page', 0);
    SpecialHalfwebAtFixedPage := ini.ReadInteger('HalfWeb special setting','Fix Halfweb page', 0);
    SpecialHalfwebMode  := ini.ReadInteger('HalfWeb special setting','Fix Halfweb calculate page', 0);

    PlanningPageNameIn := ini.ReadInteger('System','PlateNameIn', 0);
    DecreaseVersion := ini.ReadBool('System','CheckBoxDecreasever',false);
    AdminTab := ini.ReadBool('System','CheckBoxadmintab',false);

    AllowPaginaRecalculate   := ini.ReadBool('System','CheckBoxpaginarecalc',false);
    ActivateOnlyBlack :=  ini.ReadBool('System','CheckBoxractivateonlyblack', false);

    TreeOrder := ini.ReadInteger('System','RadioGroupTreeorder',0);

    RemoveMissingColorsOnApprove := ini.ReadBool('System','CheckBoxremovemissingcolorsonaprove',false);
    ReleaseOnApproval := ini.ReadBool('System','CheckBoxreleaseonapproval',false);
    ReleaseOnSeparationSet := ini.ReadBool('System','Checkboxreleaseonseprationset',false);

    ShowPreviewBestfit := ini.ReadInteger('System','RadioButtonBestfit',0);
    ShowPreviewInitZoom := ini.ReadInteger('System','EditInitzoom',100);

    UseCustomReleaseScript := ini.ReadBool('System','CheckBoxCustomrel',false);

    ReportDateFormat := ini.ReadString('System','Editreportdateform','');

    MainArchiveFolderHighres := ini.ReadString('System','Editmainarchivefolderhighres','');
    MainArchiveFolderLowres := ini.ReadString('System','Editmainarchivefolderlowres','');

    AddPressRunDefaultSection := ini.ReadString('System','EditDefsection','');

    ApplyPlanAutoMultiPress := ini.Readbool('System','CheckBoxAutomultipress', false);

    DefaultShowNoUnplanned := ini.Readbool('System','CheckBox2nounplanned',false);
    EditionViewOnlySecInEd := ini.Readbool('System','CheckBoxOnlySecined',false);

    AllowParalelView := ini.ReadBool('System','CheckBoxAllowparalelview', false);
    NewPreviewNames := ini.ReadBool('System','CheckBoxNewPreviewNames', false);
    PressTimeInPlateTree := ini.ReadBool('System','CheckBoxpresstimeinplatetree',false);
    AllowTimedEditions := ini.ReadBool('System','CheckBoxtimedEd', true);

    DefaultHardproofType := ini.ReadInteger('System','ComboBoxdefHardprtype',0);
    DefaultSoftproofType := ini.ReadInteger('System','ComboBoxdefSoftprtype',0);

    PlateTreeExpansion := ini.ReadInteger('System','RadioGroupplatetreeexp',0);

    FlatproofWaitForApproval := ini.ReadBool('System','CheckBoxdefsoftvait', false);
    HardproofWaitForApproval := ini.ReadBool('System','CheckBoxdefhardvait', false);

    IncludeImageOnceState := ini.ReadBool('System','CheckBoxIncludeImageOnceState', true);

    DefaultDateSelect := ini.ReadInteger('System','RadioGroupdefdatesel',0);
    ShowPdfBook := ini.ReadInteger('System','RadioGroupShowpdfbook', 0);
    UsePlateviewThumbnails := ini.ReadBool('System','CheckBoxplatethumb', false);

    PlanInkaliasLoad := ini.ReadBool('System','CheckBoxplaninkaliasload', false);
    ErrorFileRetrySendLog := ini.ReadBool('System','CheckBoxuknownsendlog', true);
    OnlyApplyOnUnapplied := ini.ReadBool('System','CheckBoxonlyaplyonunapplied',false);

    CheckForUnknownFilesTimerInterval := ini.ReadInteger('System','Editunknowndropdownfilter', 30);

    MinimumPlatenameLength := ini.ReadInteger('System','Editminplatenamelength',2);

    ArchiveEnabled := ini.ReadBool('System','CheckBoxarchiveenabled', true);

    DefaultArchiveHighres := ini.ReadBool('System','CheckBoxdefarchivehighress', false);
    DefaultArchiveLowres := ini.ReadBool('System','CheckBoxdefarchivelowres',false);

    ShowAddCopyDialog := ini.ReadBool('System','CheckBoxaddcopydialog', false);
    ReimageExternalStatus := ini.ReadInteger('System','Editreimextstat', -1);
    PecomImport := ini.Readbool('System','CheckBoxpecomImport', false);
    TreeGreenOnceImaged := ini.ReadBool('System','CheckBoxtreeonceimaged',false);
    ShowNewProductSign := ini.ReadBool('System','CheckBoxnewprodsign', true);

    EditionApplyUseAlterntiveEditionFile := ini.Readbool('System','CheckBoxusealted',false);
    LoadPdfInPreview := ini.ReadBool('System','CheckBoxUseadobereader', true);

    UseExtendedPlateView := ini.ReadBool('System','CheckBoxplatedeluxe', true);
    PressDataRequestLevel := ini.ReadInteger('System','ComboBoxpressreqlevel',0);
    PressDataRequestPressSpecific := ini.Readbool('System','CheckBoxpressspecreq', false);

    TreeShowPrepollEvents := ini.Readbool('System','CheckboxTreeShowPrepollEvents', true);
    TimedEditionRule := ini.ReadInteger('System','RadioGrouptimedrules', 0);

    InsertSheetNumbersFor1up := ini.Readbool('System','CheckBoxinsertsheetnumbersfor1up', false);
    PlateDoneStatisticsMode  := ini.ReadInteger('System','RadioGroupplatedonestat',0);
    AlwaysUseOffset0OnApply := ini.Readbool('System','CheckBoxAlwaysUseOffset0OnApply',true);
    NoTreeLamps := ini.ReadBool('System','CheckBoxnotreelamps', false);
    HidePlateCopyBar := ini.Readbool('System','CheckBoxplatehidecopy', false);

    LogDeleteActions := ini.Readbool('System','CheckBoxlogdelete', false);
    LogPlanningActions := ini.Readbool('System','CheckBoxlogplanning', false);
    AutoShowMasked := ini.Readbool('System','CheckBoxautomasked', false);
    RecombineOnUnapply := ini.ReadBool('System','CheckBoxrecombatunapply', false);
    PartialNoEditionChange:= ini.Readbool('System','CheckBoxPartialNoEdChange', true);

    PartialNoSecionChange := ini.Readbool('System','CheckBoxPartialNoSecChange', true);
    //ShowPressFilters := ini.Readbool('System','CheckBoxshowpressfilt', false);

    TreeShowDayName := ini.ReadBool('System','CheckBoxtreedayname', false);

    IgnoreNetUseCommand := ini.ReadBool('System','CheckBoxignorenetuse', true);
    DefaultToApprovalRequired := ini.ReadBool('System','CheckBoxplanapproval', false);
    PlateNoThumbnailRotation := ini.ReadBool('System','CheckBoxPlatenothumbrot', false);

    PressHighPlateName :=ini.ReadString('System','EditHighplate', 'H');
    PressLowPlateName :=ini.ReadString('System','Editlowplate', 'L');
    PressHighPlateName2 :=ini.ReadString('System','EditHighplate2', 'HOY');
    PressLowPlateName2 :=ini.ReadString('System','Editlowplate2', 'LAV');


    PlannedPageNameDataFile := ini.ReadString('System','Editplannedpagenamedata','');
    PlateNameRestartOnEachRun  := ini.ReadBool('System','CheckBoxplatenamerecount', false);
    UsePressSpecificInkRegenPath := ini.ReadBool('System','CheckBoxinkpresspath', false);
    FileInfoBufferSize := ini.ReadInteger('System','NyFileInfosize',2048);
    SetSecionNamesInPressrunComment := ini.Readbool('System','CheckBoxsecInpressruncom', false);

    UseFileCenterTiffArchive := ini.Readbool('System','CheckBoxUseFileCenterTiffArchive', false);
    SynchronizedTreeUpdate := ini.ReadBool('System','CheckBoxFastTree', false);
    EnableArchive := ini.ReadBool('System','CheckBoxArkenabled', true);
    ShowPdfUnknownFiles := ini.ReadBool('System','CheckBoxPdfunknown', false);
    //PressGroupSystem := ini.Readinteger('System','UsePressGroups',0);

    Split1UpRuns := ini.ReadBool('System','CheckBoxsplit1upruns', false);

    TextOnReportGraph  := ini.ReadBool('System','CheckBoxtextongrp',false);
    UseWebFileNameWithVersion := ini.ReadBool('System','UseWebfileswithversions',false);
    RestrictRetransmit := ini.Readbool('System','CheckBoxOverruleretransmit',false);

    StartupWindowsSize  := ini.ReadInteger('System','RadioGroupstartupsize',0);
    PlateShowExternalStatus  := ini.Readbool('System','CheckBoxplateshowextstat', true);

    ArchiveHigresFilenameDefinition  := ini.ReadString('System','Edithighresarch', '');

    DefaultAutomatePlanname := ini.ReadBool('System','CheckBoxdefaultautomateplanname', false);
    PlanClearSections := ini.ReadBool('System','CheckBoxplanclearsections', false);

    UseTrueSheetSide := ini.Readbool('System','CheckBoxusetruesheetside', false);
    ShowInkDensityInformation := ini.Readbool('System','CheckBoxShowInkDensityInformation', true);
    ShowSizeInformation := ini.Readbool('System','CheckBoxShowSizeInformation',false);
    AllowDropFilesDeleteAfterCopy := ini.Readbool('System','CheckBoxAllowDropFilesDeleteAfterCopy', false);
    DeviceControlOnlyAdmins := ini.Readbool('System','CheckBoxDeviceControlOnlyAdmins', false);
    PlanningPageFormat := ini.Readbool('System','CheckBoxCheckPlanningPageFormat',false);
    PlanningRipSetup := ini.Readbool('System','CheckBoxCheckPlanningRipSetup',false);

    // Size of arrays determined from FormSettings!!
   // SetLength(SectionText, FormSettings.CheckListBoxSectionText.Count);
    SetLength(SectionText, Length(CheckListBoxSectionTextItems));
    for i := 0 to Length(SectionText)-1 do
      SectionText[i] := ini.Readbool('System','CheckListBoxSectionText'+IntToStr(i), false);

    SetLength(ThumbnailStatusBar, Length(CheckListBoxthumbstatbarItems));
    for i := 0 to Length(ThumbnailStatusBar)-1 do
    begin
      //ThumbnailStatusBar[i].Name := FormSettings.CheckListBoxthumbstatbar.Items[i];
      //ThumbnailStatusBar[i].Enabled := ini.ReadBool('thumbstatbar'+IntToStr(i), FormSettings.CheckListBoxthumbstatbar.Items[i],false);
      ThumbnailStatusBar[i].Name := CheckListBoxthumbstatbarItems[i];
      ThumbnailStatusBar[i].Enabled := ini.ReadBool('thumbstatbar'+IntToStr(i), CheckListBoxthumbstatbarItems[i],false);
    end;

    AutoFlatProof := ini.ReadBool('System','CheckBoxautoflatproof', false);

    EnablePressSpecificSelection := ini.Readbool('System','CheckBoxenablespecifiksel', false);
    NewInkRegeneration := ini.Readbool('System','CheckBoxnewinkregen', true);
    AutoReImageOnDeviceChange := ini.Readbool('System','CheckBoxautoreimondevch',false);
    ApplyOnlyPlannedColors := ini.Readbool('System','CheckBoxApplyonlyplannedcolors',false);
    ForceSameDevice := ini.Readbool('System','CheckBoxForcesamedev', false);

    DefaultSavePageListFile := ini.Readstring('System','Editdefaultsavepagelistfile', '');
    AllowManualPlanning := ini.ReadBool('System','CheckBoxmanualplanning', false);

    UnplannedApplyDefaultMethodToWizard := ini.ReadBool('System','RadioButtonwizard', false);

    SmoothPlateAutoRefresh := ini.Readbool('System','CheckBoxsmootplateautorefresh', true);
    PreviewZoomfilter := ini.ReadInteger('System','ComboBoxZoomfilter', 5);
    ProductionViewShowOrder := ini.ReadBool('System','CheckBoxprodshoworder',false);
    PlateviewOrderInCaption := ini.Readbool('System','CheckBoxorderintopcap', false);
    PreviewGoToNeedApproval := ini.ReadBool('System','CheckBoxgtoneedapr',false);
    AllowSelectionOfAnyLayout := ini.ReadBool('System','CheckBoxlayoutanaki', false);

    PlanningAllowManualHalfWebOverride := ini.ReadBool('System','CheckBoxmanhw', false);
    DefaultPlanHold := ini.ReadBool('System','CheckBoxplanhold', true);

    ReportShowAllGraphTime := ini.ReadBool('System','CheckBoxshowallgraphtime', false);
    PlanningDefaultPDF := ini.ReadBool('System','CheckBoxdefaultPDF',false);
    UseCustomTowerNames := ini.ReadBool('System','CheckBoxCustomtowerrnames',false);
    TreeAutoExpandLevel  := ini.ReadInteger('System','EditAutotreeexpand',1);
    UseDBTowerNames := ini.ReadBool('System','CheckBoxUseDBtowernames',true);
    PlanRepair := ini.Readbool('System','CheckBoxPlanrepair',true);

    // Custom stuff
    CheatPecom := ini.ReadBool('System','cheatpecomp',false);

    //SetLength(TreeExtraPublicationText, 10 (*FormSettings.CheckListBoxextrafiltertext.Items.Count *));
    SetLength(TreeExtraPublicationText,  Length(CheckListBoxextrafiltertextItems));
    TreeExtraPublicationText[0] := ini.ReadBool('System','Weekinfilter',false);
    TreeExtraPublicationText[1] := ini.ReadBool('System','Orderinfilter',false);
    TreeExtraPublicationText[2] := ini.ReadBool('System','Commentinfilter',false);
    TreeExtraPublicationText[3] := ini.ReadBool('System','Custommerinfilter',false);
    TreeExtraPublicationText[4] := ini.ReadBool('System','Publinfilter',false);
    TreeExtraPublicationText[5] := ini.ReadBool('System','INKinPublinfilter',false);
    TreeExtraPublicationText[6] := ini.ReadBool('System','INKALIASinPublinfilter',false);
    TreeExtraPublicationText[7] := ini.ReadBool('System','OUTALIASPublinfilter',false);
    TreeExtraPublicationText[8] := ini.ReadBool('System','PressTimePublinfilter',false);
    TreeExtraPublicationText[9] := ini.ReadBool('System','ProdOrderPublinfilter',false);

    PlanningDefaultInserted := ini.Readbool('System','CheckBoxDefplaninserted',false);
    DefaultShowPlateDetails := ini.ReadBool('System','CheckBoxdefaultshowplatedetails',true);
    AutoRefreshOn := ini.ReadBool('System','CheckBoxAutorefreshon',false);
    DongAInkVisible := ini.ReadBool('System','CheckBoxDongA', false);
    LogApproval := ini.ReadBool('System','CheckBoxlogapprove', true);
    LogDisapproval := ini.ReadBool('System','CheckBoxlogdisapprove', true);
    LogHold := ini.ReadBool('System','CheckBoxloghold', true);
    LogRelease := ini.ReadBool('System','CheckBoxlogrelease', true);
    PlateviewShowRipSystem := ini.ReadBool('System','CheckBoxplateshowripsystem',false);
    KeepTreeExpansion := ini.ReadBool('System','CheckBoxKeeptreeexpantion', true);
    ShowWeekNumberInTree := ini.ReadBool('System','CheckBoxShowWeekNr', false);
    ReselectThumbnails := ini.ReadBool('System','CheckBoxreselectthumb', false);
    ReselectPlates := ini.ReadBool('System','CheckBoxreselectplates', false);
    SendEmailMode := ini.ReadInteger('System','RadioGroupSendemail',0);
    EmailServer := ini.ReadString('System','Editemailserver', '');
    EmailFromAddress := ini.ReadString('System','Editemailadress', '');
    CommaSeparatorChar := ini.ReadString('System','ComboBoxSepSEP',',');
    DefaultDevice := ini.ReadString('System','Editdefaultdevice','');
    UseDefaultDevice := ini.ReadBool('System','CheckBoxusedefaultdevice',false);
    PlanningGeneratePlateNames := ini.ReadBool('System','CheckBoxplatenames',true);

    PostPlanSPPressrunExecute := ini.ReadBool('System','CheckBoxSPPressrunexec',true);
    PostPlanSPPressrunExecute2 := ini.ReadBool('System','CheckBoxSPPressrunexec2',false);
    PostPlanSPProductionExecute := ini.ReadBool('System','CheckBoxSPProductionexec',false);
    ApplyDoPostProductionProcedure :=   ini.ReadBool('System','CheckBoxApplyDoPostProductionProcedure',false);
    ApplyDoPostPressRunProcedure :=   ini.ReadBool('System','CheckBoxApplyDoPostPressRunProcedure', true);



    GenerateReportWhenDeleting := ini.Readbool('System','CheckBoxgenrepwhendel',false);
    PlanningClearPubliationsOnLoad := ini.ReadBool('System','CheckBoxclearpublonload', false);
    SimplePlanLoad := ini.ReadBool('System','CheckBoxSimplePlanLoad', false);
    DefaultPress := ini.ReadString('System','ComboBoxDefaultPress', '');

    DefaultLocation := ini.ReadString('System','ComboBoxlocations','');
    CustomXMLReportOutputFolder := ini.ReadString('System','Editcustomdelcomdest', '');

    AllowControlDevices  := ini.Readbool('System','CheckBoxcontroldev', false);

   // SetLength(TreeExtraEditionText, 4 (* FormSettings.CheckListBoxEditionText.Items.Count *));
    SetLength(TreeExtraEditionText,  Length(CheckListBoxEditionTextItems));
    TreeExtraEditionText[0] := ini.Readbool('System','CheckListBoxEditionText0', false);
    TreeExtraEditionText[1] := ini.Readbool('System','CheckListBoxEditionText1', false);
    TreeExtraEditionText[2] := ini.Readbool('System','CheckListBoxEditionText2',false);
    TreeExtraEditionText[3] := ini.Readbool('System','CheckListBoxEditionText3',false);

    ReportTimeOut := ini.ReadInteger('System','ReportTimeOut', 30);
    ReportSaveFolder := ini.ReadString('System','ReportSaveFolder', '');
    ReportOnProductionDeleteSendEmail := ini.ReadInteger('System','ReportOnProductionDeleteEmail',1) = 1;
    EmailUsePublicationSpecificMail := ini.ReadInteger('System','EmailUsePublicationSpecificMail', 1) = 1;

    MailFrom := ini.ReadString('System','MailFrom','');
    MailTo := ini.ReadString('System','MailTo', '');
    MailCC := ini.ReadString('System','MailCC', '');
    MailSubject := ini.ReadString('System','MailSubject', '');

    HideCommonPlates  := ini.ReadBool('System','CheckBoxnocommonplates', false);
    UnknownFilesFileNameLengthMatch  := ini.ReadInteger('System','UpDowndropdownfilter', 0);

    SuperUserMaySeeAll := ini.ReadBool('System','CheckBoxsuperall', true);

    NewProductDeleteSystem := ini.ReadBool('System','CheckBoxnewdelsys', true);
    CustomPlanExportFilenameDefinition := ini.ReadString('System','EditCustomplanexportfilename','');
    ProductionShowRipSetup := ini.Readbool('System','CheckBoxprodshowRipsetup',false);
    PlanningExportXMLPlan := ini.ReadBool('System','CheckBoxplanexport', false);
    PageListExportIncludeHeaders := ini.ReadBool('System','CheckBoxSEPHEader', true);

    ReimageWithHighPriority := ini.ReadBool('System','CheckBoxreimhighpri', true);

    PlateTreeMinLevel := ini.ReadInteger('System','EditPlateminlevel',2);
    DayOfWeek := ini.ReadInteger('System','ComboBoxdayofweek',6);
    GraphTimeFormat := ini.ReadString('System','ComboBoxgraphtimeformat','hh:nn');

    PreviewSeparationsOnReadview := ini.Readbool('System','CheckBoxseponreadview', false);
    EmailLoginNameAsSenderName := ini.ReadBool('System','CheckBoxemailasuser', false);
    EmailSenderName := ini.ReadString('System','Editsendername','PlanCenter');
    EmailTitleDefinition := ini.ReadString('System','Editemailtitle','Page (N) has been disapproved by (U)');

    SeparationsUseLocaleTimeFormat := ini.ReadBool('System','CheckBoxlocaltimeset', true);
    SeparationTimeFormat := ini.ReadString('System','Editlistime','DDMMYYYY-HHNNSS');
    PlateviewBoldFont := ini.ReadBool('System','CheckBoxplatefont',false);
    PreviewCommentAsCaption := ini.ReadBool('System','CheckBoxPrevcomment', false);
    EmailPagenameDefinition := ini.ReadString('System','Editemailpagename','%P %S %N %C');
    AlternativePageNameField := ini.ReadString('System','Editaltpagenamefield','Comment');
    AlternativeSheetnameField := ini.ReadString('System','EditAltSheet','Comment');
    AllowApplyPlateMerge := ini.ReadBool('System','CheckBoxApplyPlateMerge', false);
    DefaultHidePagePlans := ini.ReadBool('System','CheckBoxDefaultHidePagePlans',false);
    ShowReimgeDialog := ini.ReadBool('System','CheckBoxshowreimgediaglog', false);
    ThumbnailsSingleEditionRelease := ini.ReadBool('System','CheckBoxThsingleedrelease',false);
    CheckJpegTag := ini.Readbool('System','CheckBoxCheckJpgTag', true);
    NewCCFilesNames := ini.Readbool('System','CheckboxNewCCFilesNames', false);
    AllowInkfileRegenerate := ini.Readbool('System','CheckBoxAllowInkfileRegenerate', false);
    PreviewZoomStep := ini.ReadInteger('System','Zoomstep',20);
    PreviewMinzoom := ini.ReadInteger('System','EditMinzoom',20);
    PreviewMaxzoom := ini.ReadInteger('System','EditMaxzoom',200);

    DatabaseQueueInkResend := ini.Readbool('System','CheckBoxnewinkresend', true);
    ProductionShowPressTime := ini.Readbool('System','CheckBoxShowPressTime', false);

    SeparateNodesPerPressrun := ini.Readbool('System','CheckBoxSeparateNodesPerPressrun', false);
    StartupTab := ini.ReadInteger('System','ComboBoxStartupTab',0);

    SetCommentOnFalseSpreads := ini.Readbool('System','CheckBoxsetcommentonfalsespreads', false);

    OrStackpositionsTogether := ini.Readbool('System','CheckBoxOrstacks', true);
    EmailImageFormat := ini.ReadInteger('System','RadioGroupemailimageformat',0);
    ShowPlannameInTree := ini.ReadBool('System','CheckBoxplannameintree', false);
    NoProductionDeleteDebug := ini.ReadBool('System','nodeldebug',false);
    AlwaysShowAllPresses := ini.ReadBool('System','CheckBoxAlwaysShowAllPresses',false);
    ForcePlanToApplied := ini.ReadBool('System','CheckBoxcustforcetoaplied', false);
    UseGeneratedReadViews := ini.ReadBool('System','CheckBoxpregenreadview',true);

    AlwaysUseGeneratedReadViews := ini.ReadBool('System','AlwaysUseGeneratedReadViews',true);
    if (AlwaysUseGeneratedReadViews) then
      UseGeneratedReadViews := true;

    UseDatabasePressTowerInfo := ini.ReadBool('System','CheckBoxusepresstowerinfo',true);

    PlanningDefaultBackwardNumbering := ini.ReadBool('System','CheckBoxbackwards',false);

    ThumbnailTreeMinimumLevel := ini.ReadInteger('System','Editminthumblevel',3);
    if (ThumbnailTreeMinimumLevel < 2) then
      ThumbnailTreeMinimumLevel := 2;

    ThumbnailSize := ini.ReadInteger('System','thumbnailsize',2);
    DeadlockDelay := ini.ReadInteger('System','deadlockdealay', 10000);

    ShowDataOnPlateThumbnails := ini.ReadBool('System','dataonthumb',true);
    ShowReimageDialog := ini.ReadBool('System','Reimagedialog',true);
    ResetDeviceOnReimage := ini.ReadBool('System','resetdeviceatreimage',true);
    ReimageAllColors := ini.ReadBool('System','reimallcolors',false);
    NewPlateDataSystem := ini.ReadBool('System','CheckBoxnewplatedata', true);

    SeparationMinTreeLevel := ini.ReadInteger('System','Editminpagetreelevel', 2 );
    if (SeparationMinTreeLevel < 2) then
      SeparationMinTreeLevel := 2;
    ProductionMinTreeLevel := ini.ReadInteger('System','Editminprodtreelevel',1);

    PlanningUseImportCenter := ini.Readbool('System','CheckBoxuseimportcenter', false);
    ImportCenterInputPath := ini.Readstring('System','Editimportcenterinputpath','');
    ImportCenterErrorPath := ini.Readstring('System','Editimportcentererrorpath','');
    ImportCenterDonePath := ini.Readstring('System','Editimportcenterdonepath','');

    ThumbnailMakeChangesOnSubeditions := ini.ReadBool('System','CheckBoxthumbpagechangesonsubeditions',true);
    PreviewShowSidebar := ini.ReadBool('System','CheckBoxShowsidebar',true);
    PreviewSidebarWidth := ini.ReadInteger('System','Editsidebarwidth',210);
    PreviewSidebarHeight := ini.ReadInteger('System','Editsidebarheight',210);
    MustSetDeviceOnRelease := ini.Readbool('System','CheckBoxmustsetdev', false);
    PreviewUsePregeneratedDns := ini.Readbool('System','CheckBoxpregendns', true);

    PlanningErrorFilesRetry := ini.ReadBool('System','CheckBoxerrorfileretry', false);
    SeparationsReselectPages := ini.ReadBool('System','CheckBoxreselectpages', false);

    PreviewPreloadSeparations := ini.ReadBool('System','CheckBoxpageprevseps', false);
    PreviewPreloadDns := ini.ReadBool('System','CheckBoxpageprevlevel', false);
    PreviewPreloadPlateSeparations := ini.ReadBool('System','CheckBoxplateprevseps',false);
    PreviewPreloadPlateDns := ini.ReadBool('System','CheckBoxplateprevlevel', false);
    PreviewPreloadInkzones := ini.ReadBool('System','CheckBoxplateprevZones', false);

    NoLoginPrompt := ini.ReadBool('System','CheckBoxNologin', false);
    PlanningAllowUnplannedColors := ini.ReadBool('System','CheckBoxAllowunplannedcolors', false);
    ReleaseRuleBasedOn := ini.ReadInteger('System','RadioGroupreleaserulebase',0);
    InkWarningLevel := ini.ReadInteger('System','UpDowninklimit',220);
    AutoScrollspeed := ini.ReadInteger('System','Autoscroolspeed',5);

    UsePageIndexForSorting := ini.ReadBool('System','pageindexaspagename',false);
    SeparationsVisibleColumns := ini.ReadInteger('System','Visiblecols',16);

    SeparationsExportOnlySelectedRows := ini.ReadBool('System','Exportonlyselection',false);

    PlanningDefaultUseAllMarkGroups := ini.ReadBool('System','allmarkgroups',true);
    PlateHideNamesOnThumbnails :=  ini.ReadBool('System','hideprogthumb',false);

    PlanningDefaultToMono := ini.ReadBool('System','defaultK', false);
    PlanningUsePublicationDefaults := ini.ReadBool('System','CheckBoxusepublicationdefaults',true);
    SeparationsAllowShowAllPublications := ini.Readbool('System','CheckBoxpagesshowall', false);
    PlatesAutoReimageOnDeviceChange := ini.Readbool('System','CheckBoxplateReimondevch',false);
    PlatesAllowSinglePagePreview := ini.ReadBool('System','CheckBoxplatepagepreview', false);
    ExternalTiffEditorPath := ini.ReadString('System','externedittif','');
    ExternalPDFEditorPath  := ini.ReadString('System','externeditpdf','');
    TreeUseTreeUpdateTable := ini.Readbool('System','CheckBoxnewtreeload', false);
    ThumbnailsShowMonoPDFIndicator :=   ini.Readbool('System','CheckBoxthumbshowmono',false);

    AddEditionDefaultUniqueType := ini.ReadInteger('System','RadioGroupdefaultpagetypeaddedition',0);
    AddEditionDefaultApprovalUniquePage := ini.ReadInteger('System','RadioGroupdefaultUniqePaddedition',0);
    AddEditionDefaultApprovalCommonPage := ini.ReadInteger('System','RadioGroupdefaultCommonPaddedition', 0);
    AddEditionDefaultKeepDevice := ini.ReadInteger('System','RadioGroupdefaultDeviceaddedition',0);
    AddEditionDefaultHold := ini.ReadInteger('System','RadioGroupdefaultHoldaddedition', 0);
    ThumbnailShowPitstopLog := ini.Readbool('System','CheckBoxShowpitstoplog', false);

    ShowPanelUnknownFiles := ini.Readbool('System','CheckBoxShowUnknownPanel', False);
    ShowPanelUnknownFilesRefreshTime := ini.ReadInteger('System','EditCheckTimeUnknown', 1);

    PlanningDefaultFirstEdition := ini.Readstring('System','Editdefaultfirsted','');
    EditionsAssignUniqueToLocalOnly := ini.Readbool('System','Checkboxuniqloconly', false);


    NewlineInThumbnails := true;
    //SetLength(ThumbnailCaptionText,Constant_LenghtCheckListBoxthumbtext);
    SetLength(ThumbnailCaptionText, Length(CheckListBoxthumbtextItems));
    for i := 0 to Length(ThumbnailCaptionText)-1 do
    begin
   //   ThumbnailCaptionText[i].Name := ini.ReadString('CheckListBoxthumbtext','name'+IntToStr(i), FormSettings.CheckListBoxthumbtext.Items[i]);
      ThumbnailCaptionText[i].Name := ini.ReadString('CheckListBoxthumbtext','name'+IntToStr(i), CheckListBoxthumbtextItems[i]);
      if (i<2) then
        ThumbnailCaptionText[i].Enabled := ini.ReadBool('CheckListBoxthumbtext','Checked'+IntToStr(i), true)
      else
        ThumbnailCaptionText[i].Enabled := ini.ReadBool('CheckListBoxthumbtext','Checked'+IntToStr(i), false);
      t := ThumbnailCaptionText[i].Name;
      if t[length(t)] <> '#' then
        NewlineInThumbnails := false;
    End;

    ShowThumbnailGroups := false;
   // SetLength(ThumbnailGroupCaptionText, Constant_Length_CheckListBoxthgroupecap);
    SetLength(ThumbnailGroupCaptionText, Length(CheckListBoxthgroupecapItems));
    For i := 0 to Length(ThumbnailGroupCaptionText)-1 do
    begin
     // ThumbnailGroupCaptionText[i].Name := ini.ReadString('CheckListBoxthgroupecap','name'+IntToStr(i),FormSettings.CheckListBoxthgroupecap.Items[i]);
      ThumbnailGroupCaptionText[i].Name := ini.ReadString('CheckListBoxthgroupecap','name'+IntToStr(i),CheckListBoxthgroupecapItems[i]);
      ThumbnailGroupCaptionText[i].Enabled := ini.ReadBool('CheckListBoxthgroupecap','Checked'+IntToStr(i), false);
      if ThumbnailGroupCaptionText[i].Enabled Then
        ShowThumbnailGroups := true;
    End;

    n := ini.ReadInteger('towfilter','Ntowfilter',0);
    SetLength(TowerNameTranslation, n);
    for i := 0 to n-1 do
    Begin
      TowerNameTranslation[i].Key :=  ini.ReadString('towfilter','towfiltername'+IntToStr(i+1),'');
      TowerNameTranslation[i].Value :=  ini.ReadString('towfilter','towfilter'+IntToStr(i+1),'');
    end;

    EnableEditOfMiscString2 := ini.ReadBool('CheckListBoxMiscedit','Checked0', false);
    EnableEditOfMiscString3 := ini.ReadBool('CheckListBoxMiscedit','Checked1', false);
    EnableEditOfMiscInt2 := ini.ReadBool('CheckListBoxMiscedit','Checked2', false);
    EnableEditOfMiscInt3 := ini.ReadBool('CheckListBoxMiscedit','Checked3', false);


    //SetLength(ReleaseRules, FormSettings.CheckListBoxreleaserules.Items.Count);
    SetLength(ReleaseRules, Length(CheckListBoxreleaserulesItems));
    For i := 0 to Length(ReleaseRules)-1 do
    begin
      ReleaseRules[i] := ini.Readbool('CheckListBoxreleaserules',IntToStr(i), false);
    end;

   // SetLength(PlateText, FormSettings.CheckListBoxPlatetext.Items.Count);
    SetLength(PlateText, Length(CheckListBoxPlatetextItems));
    For i := 0 to Length(PlateText)-1 do
    begin
     // PlateText[i].Name := ini.ReadString('CheckListBoxPlatetext','name'+IntToStr(i), FormSettings.CheckListBoxPlatetext.Items[i]);
      PlateText[i].Name := ini.ReadString('CheckListBoxPlatetext','name'+IntToStr(i), CheckListBoxPlatetextItems[i]);
      if (i<2) then
        PlateText[i].Enabled := ini.ReadBool('CheckListBoxPlatetext','Checked'+IntToStr(i), true)
      else
        PlateText[i].Enabled := ini.ReadBool('CheckListBoxPlatetext','Checked'+IntToStr(i), false);
    End;

   // SetLength(PressRunTexts, FormSettings.CheckListBoxpressruntexts.Items.Count);
    SetLength(PressRunTexts, Length(CheckListBoxpressruntextsItems));

    For i := 0 to Length(PressRunTexts)-1 do
    begin
      //PressRunTexts[i].Name :=  ini.ReadString('CheckListBoxpressruntexts','name'+IntToStr(i), FormSettings.CheckListBoxpressruntexts.Items[i]);
      PressRunTexts[i].Name :=  ini.ReadString('CheckListBoxpressruntexts','name'+IntToStr(i), CheckListBoxpressruntextsItems[i]);
      if (i=3) OR (i=4) then
        PressRunTexts[i].Enabled := ini.ReadBool('CheckListBoxpressruntexts','Checked'+IntToStr(i), true)
      else
        PressRunTexts[i].Enabled := ini.ReadBool('CheckListBoxpressruntexts','Checked'+IntToStr(i), false);
    End;

    n := (FormMain.StringGridprods.Width - 320) div 8;
    SetLength(ProductionColumns, PRODUCTIONCOLUMNCOUNT);
    For i := 0 to Length(ProductionColumns)-1 do
    begin

      ProductionColumns[i].ColumnName :=  ini.ReadString('StringGridprodsWName',IntToStr(i), DefaultProductionColumnNames[i]);

       Case i of
        1..3 : ProductionColumns[i].Width  := ini.ReadInteger('StringGridprodsW',IntToStr(i), 55);
        6 : ProductionColumns[i].Width := ini.ReadInteger('StringGridprodsW',IntToStr(i), 40);
        7..15 : ProductionColumns[i].Width := ini.ReadInteger('StringGridprodsW',IntToStr(i), 100);
        else
          ProductionColumns[i].Width := ini.ReadInteger('StringGridprodsW',IntToStr(i), n);
      end;

      ProductionColumns[i].Visible := (ProductionColumns[i].ColumnName <> '') AND (ProductionColumns[i].ColumnName <> 'N/A') AND (ProductionColumns[i].Width>0);
    end;

    //SetLength(PlateCaptionText, FormSettings.CheckListBoxplatecaption.Items.Count);
    SetLength(PlateCaptionText, Length(CheckListBoxplatecaptionItems));
    For i := 0 to Length(PlateCaptionText)-1 do
    begin
      //PlateCaptionText[i].Name := ini.ReadString('CheckListBoxplatecaption','name'+IntToStr(i), FormSettings.CheckListBoxplatecaption.Items[i]);
      PlateCaptionText[i].Name := ini.ReadString('CheckListBoxplatecaption','name'+IntToStr(i), CheckListBoxplatecaptionItems[i]);

      if (i=0) OR (i=1) OR (i=4) then
        PlateCaptionText[i].Enabled := ini.ReadBool('CheckListBoxplatecaption','Checked'+IntToStr(i), true)
      else
        PlateCaptionText[i].Enabled := ini.ReadBool('CheckListBoxplatecaption','Checked'+IntToStr(i), false);
    End;

    ShowAllActionsOverrule := ini.readbool('system','showallactionsin3',false);
    PlanningAutoSetEditionsOnLoad := ini.Readbool('System','CheckBoxautosetedonload', false);
    PlateTransmissionSystem := ini.ReadBool('System','CheckBoxpreparetrans', false);
    SetApproveTimeOnRelease  := ini.ReadBool('System','CheckBoxapprovetimeonrelease', false);
    PlanningAutoOrderNumberBergen := ini.ReadBool('System','CheckBoxAutoplannumbergen', false);
    ReportSeparator := ini.ReadString('System','ComboBoxreportdetailsave',',');

    DefaultReportFolder := ini.ReadString('System','EditDeafaultreportfolder',IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()));

    SetCommentOnAllEditions := ini.ReadBool('System','CheckBoxdefaultsetcomed',false);

    PlanningRunThroughPagination := ini.ReadBool('System','CheckBoxruntrhoughpagina',false);
    AddTimeToPageComment := ini.ReadBool('System','CheckBoxCommenttime', false);

    PlanXMLExportFolder := ini.ReadString('System','EditCustomplanexportdest','');

    UsePlanLock := ini.Readbool('System','CheckBoxExclusive', true);

    PlanningDefaultColorProofer := ini.ReadString('System','Editdefcolorproof','');
    PlanningDefaultPDFProofer := ini.ReadString('System','Editdefpdfproof','');
    PlanningDefatulMonoProofer := ini.ReadString('System','EditdefBWproof','');

    PlanningPaginationMode := ini.ReadInteger('System','ComboBoxdefpagina',0);
    if not UseConfigurablePagination then
      PlanningPaginationMode := 0;
    FormProdPlan.ComboBoxdefpagina.ItemIndex :=  PlanningPaginationMode;

    ReportIncludeHeaders := ini.ReadBool('System','CheckBoxsavereportdetailcolumns', true);
    ThumnailsShowHold := ini.ReadBool('System','CheckBoxthumbshowhold',true);


    MenuToolbarColor := ini.ReadString('System','MenuToolbar Color', 'White');
    ToolbarColor := ini.ReadString('System','Toolbar Color', 'Menu Background');
    ToolbarSelectedColor := ini.ReadString('System','Toolbar Color Selected', 'Menu Highlight');

    CheckForUnknownFilesTimer := ini.ReadBool('System','CheckBoxunknowncheck', false);
    SeparationsFullAutorefresh := ini.ReadBool('System','CheckBoxpagefullautorefresh',false);
    SeparationsResetDeviceOnReimage := ini.ReadBool('System','datalistautoresetdev',false);

    SeparationsShowStatusIcons := ini.ReadBool('System','Pageicons',false);
    ThumbnailsShowExternalStatus := ini.ReadBool('System','CheckBoxthumbshowextstat',false);
    ShowDeviceControl := ini.ReadBool('System','CheckBoxshowdevcontrol', false);
    DeviceControlUsePressDevices := ini.ReadBool('System','CheckBoxpressindevcontrol',false);

    TreeOrderByEditionID := ini.ReadBool('System','CheckBoxtreebyedid', false);

    ThumbnailAllowSetFalseSpread := ini.ReadBool('System','CheckBoxAllowfalsespret',false);
    ThumbnailResetStatusOnPageTypeChange := ini.ReadBool('System','CheckBoxstatresetonpagetypechange',false);

    PlatesShowTemplateInCaption := ini.ReadBool('System','CheckBoxShowtemplateincaption',false);

    AllowDropFiles := ini.ReadBool('System','CheckBoxAllowDropFiles', false);
    AllowDropFilesDialog := ini.ReadBool('System','CheckBoxAllowDropFilesDialog',false);
    DropFilesDestination := ini.ReadString('System','EditDropFilesDestination', '');

    PreviewShowInkZones := ini.ReadBool('System','CheckBoxShowInkZones', false);
    PlanningUsePublicationDefaultlPriority := ini.ReadBool('System','CheckBoxPlanpri',false);

    PlatesShowPagesStanding := ini.ReadBool('System','CheckBoxplatespecialstanding',false);

    TreeFilterOnProductionDate  := ini.ReadBool('System','CheckBoxpublfilreonproddate',false);
    PlatePrintoutUseSectionPage  := ini.ReadBool('System','CheckBoxplateprtsecpage',false);

    EditionsSetForceWhenCommon  := ini.ReadBool('System','CheckBoxforcewhencommon',false);


    // Moved from FormMain
    OverwritePlanLogFilepath := ini.ReadString('System','overwriteplanlogfilepath','');
    FirstColumnDescentingSort := ini.ReadBool('System','firstsortcoldirectiondesc',false);
    FirstSortColumnName := ini.ReadString('System','firstsortcolname','');

    PlanningHotTimeFromDeadline  := ini.ReadBool('System','CheckBoxhttimedeadline',false);
    PlanningHotTimeFromDeadlineAddHours := ini.ReadInteger('System','Edithottimehours',0);

   // SetLength( ThumbnailSortingOrder, FormSettings.ListBoxthumborder.Items.Count);
    SetLength( ThumbnailSortingOrder, Length(ListBoxthumborderItems));
    for i := 0 to Length(ThumbnailSortingOrder)-1 do
    begin
     // ThumbnailSortingOrder[i] := ini.ReadString('Thumborder',inttostr(i), FormSettings.ListBoxthumborder.Items[i]);
      ThumbnailSortingOrder[i] := ini.ReadString('Thumborder',inttostr(i), ListBoxthumborderItems[i]);
    end;

   // SetLength(ArchiveFolderNameDefinitions, FormSettings.CheckListBoxAFoldername.Items.Count);
    SetLength(ArchiveFolderNameDefinitions, Length(CheckListBoxAFoldernameItems));
    for i := 0 to Length(ArchiveFolderNameDefinitions)-1 do
      ArchiveFolderNameDefinitions[i] := ini.ReadBool('CheckListBoxAFoldername', IntToStr(i), true);

    ArchiveLowResNameDefinition := ini.Readstring('System','Editlowarch','%P-%D-%E-%S-%N');
    ArchiveLowResDateDefinition := ini.Readstring('System','Editarchdate','DDMMY');

   // SetLength(ThumbnailEvents, FormSettings.CheckListBoxThumbevents.Items.Count);
    SetLength(ThumbnailEvents, Length(CheckListBoxThumbeventsItems));
    for i := 0 to Length(ThumbnailEvents)-1 do
    begin
      //ThumbnailEvents[i].Name := FormSettings.CheckListBoxThumbevents.Items[i];
      ThumbnailEvents[i].Name := CheckListBoxThumbeventsItems[i];
     // ThumbnailEvents[i].Enabled := ini.ReadBool('CheckListBoxThumbevents',IntToStr(i), FormSettings.CheckListBoxThumbevents.Checked[i]);
      ThumbnailEvents[i].Enabled := ini.ReadBool('CheckListBoxThumbevents',IntToStr(i), true);
    end;

    //TreeShowAllLocationOption  := ini.ReadBool('System','CheckBoxshowallfilter',false);
    //if (not ShowAllLocations) then
    //  TreeShowAllLocationOption := false;

   // SetLength(SeparationsReportColumns, FormSettings.CheckListBoxdetailsavecols.Items.Count);
    SetLength(SeparationsReportColumns, Length(CheckListBoxdetailsavecolsItems));
  //  for i := 0 to FormSettings.CheckListBoxdetailsavecols.Items.count-1 do
    for i := 0 to Length(SeparationsReportColumns)-1 do
      SeparationsReportColumns[i] := ini.ReadBool('CheckListBoxdetailsavecols', IntToStr(i),true);

    //SetLength(PlatePrintListTitleDefinition, FormSettings.CheckListBoxPLtPrnttitle.Items.Count);
    SetLength(PlatePrintListTitleDefinition, Length(CheckListBoxPLtPrnttitleItems));
    //for i := 0 to FormSettings.CheckListBoxPLtPrnttitle.Items.Count-1 do
    for i := 0 to Length(PlatePrintListTitleDefinition)-1 do
     // PlatePrintListTitleDefinition[i] := ini.ReadBool('CheckListBoxPLtPrnttitle',IntToStr(i), FormSettings.CheckListBoxPLtPrnttitle.Checked[i]);
      PlatePrintListTitleDefinition[i] := ini.ReadBool('CheckListBoxPLtPrnttitle',IntToStr(i), true);

   // SetLength(PlatePrintListPlateDefinition, FormSettings.CheckListBoxPLtPrntplate.Items.Count);
    SetLength(PlatePrintListPlateDefinition, Length(CheckListBoxPLtPrntplateItems));
   // for i := 0 to FormSettings.CheckListBoxPLtPrntplate.Items.count-1 do
    for i := 0 to Length(CheckListBoxPLtPrntplateItems)-1 do
    begin
      if (i=2) then
        PlatePrintListPlateDefinition[i] := ini.ReadBool('CheckListBoxPLtPrntplate',IntToStr(i), true)
      else
        PlatePrintListPlateDefinition[i] := ini.ReadBool('CheckListBoxPLtPrntplate',IntToStr(i), false);
    end;

   // SetLength(PrePollEventNames, FormSettings.MemoShortevent.Lines.Count);
    SetLength(PrePollEventNames, Length(MemoShorteventItems));
   // for i := 0 to FormSettings.MemoShortevent.Lines.Count-1 do
    for i := 0 to Length(MemoShorteventItems)-1 do
      //PrePollEventNames[i] := ini.Readstring('MemoShortevent',IntToStr(i), FormSettings.MemoShortevent.Lines[i]);
      PrePollEventNames[i] := ini.Readstring('MemoShortevent',IntToStr(i), MemoShorteventItems[i]);

    FormMain.SaveDialogreportdetails.InitialDir := DefaultCSVReportfolder;
    FormMain.SaveDialogsavetextreport.InitialDir := DefaultCSVReportfolder;
    FormMain.SaveDialogreport.InitialDir := DefaultCSVReportfolder;

    //FormAddpressrun.CheckBoxCombinetoonerun.Checked := ini.ReadBool('split','Splitasonerun',false);
    FormAddpressrun.CheckBoxCombinetoonerun.Checked := false;

    TrimOdd := ini.ReadInteger('System','TrimOdd',1);
    Trimeven := ini.ReadInteger('System','Trimeven',1);

    Language := ini.ReadString('System','Language','Default');
    FormMain.InfraLanguage1.Language :=  Language;

    SetLength(ProductionGridFonts,  PRODUCTIONCOLUMNCOUNT);
    for i := 0 to PRODUCTIONCOLUMNCOUNT-1 do
    begin
      ProductionGridFonts[i].name := ini.Readstring('Prodgridfonts'+IntToStr(i),'name'+IntToStr(i), FormMain.Font.Name);
      if (ProductionGridFonts[i].name = '') then
        ProductionGridFonts[i].name := FormMain.Font.Name;

      ProductionGridFonts[i].Style := TFontStyles(Byte(ini.ReadInteger('Prodgridfonts'+IntToStr(i),'Style'+IntToStr(i),Byte(FormMain.Font.Style))));
      if (Byte(ProductionGridFonts[i].Style) = 0) then
        ProductionGridFonts[i].Style := FormMain.Font.Style;
      ProductionGridFonts[i].Size := ini.ReadInteger('Prodgridfonts'+IntToStr(i),'Size'+IntToStr(i), 8(*FormMain.Font.Size*));
      if (ProductionGridFonts[i].Size = 0) then
        ProductionGridFonts[i].Size := FormMain.Font.Size;
    end;

    n := ini.ReadInteger('System','ListViewplannamedstyles',0);
    SetLength(PlannedNameDefinitions, n);
    for i := 0 to n-1 do
    begin
      PlannedNameDefinitions[i].Name := ini.ReadString('ListViewplannamedstyles','name'+IntToStr(i),'');
      PlannedNameDefinitions[i].Format := ini.ReadString('ListViewplannamedstyles','format'+IntToStr(i),'');
      PlannedNameDefinitions[i].Dateformat := ini.ReadString('ListViewplannamedstyles','date'+IntToStr(i),'');
      PlannedNameDefinitions[i].Enabled := false;
    end;

    i := ini.ReadInteger('System','ListViewplannamedstylesdefault',-1);
    if (n > 0) and (n >= i) and (i > -1) then
      PlannedNameDefinitions[i].Enabled := true;

    HotHourPriorityDifference := ini.ReadInteger('System','UpDownhothours',1);
    HotHourPriorityLength := ini.ReadInteger('System','UpDownhotlength',2);
    HotHourPriorityBefore := ini.ReadInteger('System','UpDownhotbefore', 50);
    HotHourPriorityDuring := ini.ReadInteger('System','UpDownhotunder', 70);
    HotHourPriorityAfter := ini.ReadInteger('System','UpDownhotafter',30);

    //LoadSpecificFont(ini,'plateprint', FormSettings.FontDialogplateprint.font);



    LoadSpecificFont(ini,'plateprint', FontDialogplateprintFont);

    //ShowAllLocationsSeparations := ini.ReadBool('system','CheckBoxAllLocationsPa', false);
    //ShowAllLocationsThumbnails := ini.ReadBool('system','CheckBoxThumball', false);
    //ShowAllLocationsProduction := ini.ReadBool('system','CheckBoxAllLocationsProd', false);
    ThumbnailInnerMargin  := ini.ReadInteger('System','ThumbnailInnerMargin', 4);
    ThumbnailGapVertical  := ini.ReadInteger('System','ThumbnailGapVertical', 8);         // 8
    ThumbnailGapHorizontal  := ini.ReadInteger('System','ThumbnailGapHorizontal', 8); // 8
    ThumbnailCaptionHeight   := ini.ReadInteger('System','ThumbnailCaptionHeight', 28); // 28


    ShowPageNoteIndicator  := ini.ReadBool('system','CheckBoxShowPageNote', false);

    ini.Free;

    if FileExists(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'Customreleasescript.txt') then
      CustomReleaseScript.LoadFromFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'Customreleasescript.txt');

  except
    MessageDlg('ERROR reading settings from PlanCenter.ini file', mtError,[mbOk], 0);
  end;

end;

// Read this after inittypes.initthetypes..
procedure tPrefs.ReadDataExportColumns;
var
  i : Integer;
  ini : Tinifile;
begin

  try
    ini := TIniFile.Create(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'PlanCenter_datalist.ini');
    SetLength(DataExportColumns, DATALISTCOLUMNSCOUNT);
    For i := 0 to DATALISTCOLUMNSCOUNT-1 do
    begin
      DataExportColumns[i].Name := datalistCols[i].name;
      DataExportColumns[i].Enabled := ini.ReadBool('Export',datalistCols[i].Field,true);
    End;
    ini.Free;
  except

  end;
end;

procedure tPrefs.LoadIniFileAfterDBInit;
var
 ini  : Tinifile;
  i   : Integer;
  defaultOn : Boolean;
  found : Boolean;
begin

   try
     ini := TIniFile.Create(TUtils.GetPlanCenterIniFilePath(PlanCenterConfigFileName));

     // Notes :
     //  StatusWarningList already loaded in FormMain.ActivateData
     //  ExtStatusWarningList already loaded in FormMain.ActivateData

    found := false;
    IF tnames1 <> nil then
    begin
      SetLength(VisiblePressesConfig,  tnames1.pressnames.Count);
      SetLength(MaxPagesPerPress, tnames1.PNpressnames);
      SetLength(OldInkPathsPerPress, tnames1.PNpressnames);
      SetLength(InkGenerationSystemPerPress, tnames1.PNpressnames);

      for i := 0 to tnames1.pressnames.Count-1 do
      Begin
        VisiblePressesConfig[i].Press :=  tnames1.pressnames[i];
        VisiblePressesConfig[i].Visible := ini.Readbool('visiblepresses', VisiblePressesConfig[i].Press, true);
        if (VisiblePressesConfig[i].Visible) then
          found := true;

        MaxPagesPerPress[i].Key := tnames1.pressnames[i];
        MaxPagesPerPress[i].Value := ini.readString('Maxpresspage','press'+MaxPagesPerPress[i].Key,'0');

        OldInkPathsPerPress[i].Key := tnames1.pressnames[i];
        OldInkPathsPerPress[i].Value := ini.readString('ValueListEditorOldInk','press'+OldInkPathsPerPress[i].Key,'');

        InkGenerationSystemPerPress[i].Key := tnames1.pressnames[i];
        InkGenerationSystemPerPress[i].Value := ini.readString('Inpresetvalues', InkGenerationSystemPerPress[i].Key,'None');
      end;

      // If no visible presses set - enable all..
      if (not found) then
      begin
        for i := 0 to tnames1.pressnames.Count-1 do
          VisiblePressesConfig[i].Visible := true;
      end;

      DefaultLocation :=  ini.ReadString('system','ComboBoxlocations', tnames1.locationnames[0]);

      SetLength(CylinderNameTranslation, tnames1.Colornames.Count);
      for i := 0 to tnames1.Colornames.Count-1 do
      begin
        CylinderNameTranslation[i].Key := tnames1.Colornames[i];
        CylinderNameTranslation[i].Value := ini.readString('cyl','cyl'+tnames1.Colornames[i],'');
      end;


      SetLength(EventLogs, tnames1.Eventnames.Count);
      for i := 0 to tnames1.Eventnames.Count-1 do
      begin
        EventLogs[i].Name := tnames1.Eventnames[i];  // 0-based
        EventLogs[i].Number := tnames1.eventnumberfromname(tnames1.Eventnames[i]);
        defaultOn := EventLogs[i].Number IN DefaultEventsOn;
        EventLogs[i].Enabled := ini.ReadBool('Eventlogs',EventLogs[i].Name+IntToStr(EventLogs[i].Number) ,defaultOn);
      end;


      OnlyShowDefaultDevices := ini.Readbool('System','CheckBoxOnlyShowDefaultDevices',false);
      ShowSpecificDevices := ini.Readbool('System','CheckBoxShowSpecificDevicesOnly',false);
      SetLength(SpecificDevices, tnames1.DeviceNames.Count);
       for i := 0 to tnames1.DeviceNames.Count-1 do
      begin
        SpecificDevices[i].Name := tnames1.Devicenames[i];  // 0-based
        if (ShowSpecificDevices) then
          SpecificDevices[i].Enabled := ini.ReadBool('SpecificDevices',SpecificDevices[i].Name, true)
        else
          SpecificDevices[i].Enabled := true;
      end;

    end;

    ini.Free;
    except
//    MessageDlg('ERROR reading settings from PlanCenter.ini file', mtError,[mbOk], 0);
  end;

end;


procedure tPrefs.SetFileServerAlternativeIP();
var
  i : Integer;
  ini : Tinifile;
begin
  ini := TIniFile.Create(TUtils.GetPlanCenterIniFilePath(PlanCenterConfigFileName));
  for i := 1 to tNames1.NFileServerNames do
  begin
    tNames1.FileServerNames[i].AlternativeIP := ini.readString('AlternativeIP',tNames1.FileServerNames[i].Name+ IntToStr(tNames1.FileServerNames[i].ServerType),'');
    if (tNames1.FileServerNames[i].AlternativeIP <> '') then
    begin
      tNames1.FileServerNames[i].IP := tNames1.FileServerNames[i].AlternativeIP;
      tNames1.FileServerNames[i].FullPath := '\\'+IncludeTrailingBackSlash(tNames1.FileServerNames[i].IP)+tNames1.FileServerNames[i].Share+'\';
    end;
  end;
  ini.Free;
end;

procedure tPrefs.SetErrorFolders;
var
  i : Integer;
  ini : Tinifile;
begin

  ini := TIniFile.Create(TUtils.GetPlanCenterIniFilePath(PlanCenterConfigFileName));
  SetLength(DefaultUnknownFilesFolders, NErrorfolders);
  for i := 0 to NErrorfolders-1 do
   begin
      DefaultUnknownFilesFolders[i].Name := Errorfolders[i+1].name; // 1-based!
      DefaultUnknownFilesFolders[i].Enabled := ini.readbool('CheckListBoxdefunknown', DefaultUnknownFilesFolders[i].Name, i = 0);
  end;
  ini.Free;
end;

procedure tPrefs.SetVisibleTowers;
var
  i,n : Integer;
  ini : Tinifile;
  found : Boolean;
begin
  ini := TIniFile.Create(TUtils.GetPlanCenterIniFilePath(PlanCenterConfigFileName));

  found := false;
  for i := 0 to Length(VisibleTowers)-1 do
  begin
    VisibleTowers[i].Visible :=  ini.readbool('CheckListBoxvisibletowers', Prefs.VisibleTowers[i].Press+ '-' + Prefs.VisibleTowers[i].Tower, true) ;
    if (VisibleTowers[i].Visible) then
      found := true;
  end;

  // If not visible towers at all - enable all...
  if (not found) then
  begin
    for i := 0 to Length(VisibleTowers)-1 do
      VisibleTowers[i].Visible := true;
  end;

  if (not UseDBTowerNames) then
  begin
    n := ini.ReadInteger('Tower','NTower',1);
    for i := 0 to min(Length(PressTowers), n)-1 do
    Begin
      PressTowers[i].Tower := ini.ReadString('Tower','Tower'+IntToStr(i+1),'');
      PressTowers[i].Press := ini.ReadString('Tower','Press'+IntToStr(i+1),'');
    end;
  end;

  ini.Free;
end;


procedure tPrefs.SaveIniDatabaseDetails;
var
   ini  : Tinifile;
begin
  try
    ini := TIniFile.Create(TUtils.GetPlanCenterIniFilePath(PlanCenterConfigFileName));

    if (Prefs.DBInstance <> '') then
      ini.WriteString('server1','Servername', DBServerName + '/' + DBInstance)
    else
      ini.WriteString('server1','Servername', DBServerName);

    ini.WriteString('server1','Database', DBDatabase);
    ini.WriteString('server1','DBUser', DBUser);
    ini.WriteString('server1','DSN', DSN);
    ini.WriteString('server1','DBPassword', TUtils.EncodeBlowfish(DBPassword));
    ini.WriteBool('server1','Usebackup', DBUsebackup);

    if (DBBackupInstance <> '') then
      ini.WriteString('server1','BACKUPServername', DBBACKUPServername + '/' + DBBackupInstance )
    else
      ini.WriteString('server1','BACKUPServername', DBBACKUPServername);

    ini.WriteString('server1','BACKUPDatabase', DBBackupDatabase);
    ini.WriteString('server1','BACKUPDBUser', DBBackupUser);
    ini.WriteString('server1','BACKUPDBPassword', TUtils.EncodeBlowfish(DBBackupPassword));
    ini.WriteString('server1','BACKUPDSN', BackupDSN);

    ini.WriteBool('server1','DBreconnect', DBreconnect);
    ini.WriteBool('server1','DBFetchAll', DBFetchAll);
    ini.WriteInteger('server1','DBCommandTimeout', DBCommandTimeout);

    ini.UpdateFile;
    ini.Free;
  except

  end;
end;

procedure tPrefs.SaveIniFile;
var
 ini  : Tinifile;
 n,i    : Integer;
begin
  try
    ini := TIniFile.Create(TUtils.GetPlanCenterIniFilePath(PlanCenterConfigFileName));

    ini.WriteBool('System','UsePreviewCache', UsePreviewCache);
    ini.WriteString('System','PreviewCacheShare',PreviewCacheShare);

    ini.WriteBool('System','UseMultiPressTemplateLoad', UseMultiPressTemplateLoad);
    ini.WriteBool('System','ThumbnailsShowAlsoForcedPages', ThumbnailsShowAlsoForcedPages);

    ini.WriteBool('System','GeneratePlanPageNames', GeneratePlanPageNames);
    ini.WriteBool('System','AllowMovePages', AllowMovePages);

    ini.WriteBool('System','SetReleaseNowOnReimage', SetReleaseNowOnReimage);

    ini.WriteBool('System','PreviewForceGrayBackground', PreviewForceGrayBackground);
    ini.WriteBool('System','TreeShowAliasFirst', TreeShowAliasFirst);

    ini.WriteBool('System','RestrictUniqueDelete', RestrictUniqueDelete);

    ini.WriteBool('System','CheckBoxShowPagesOutOfRange', TreeShowPagesOutOfRange);
    ini.WriteInteger('system','EditUnknownFilesPanelWidth', ShowPanelUnknownFilesWidth);
    ini.WriteBool('System','ThumbnailsAllowPdfRotation', ThumbnailsAllowPdfRotation);
    ini.WriteBool('System','PlanningOnlyShowDefaultPressPublications', PlanningOnlyShowDefaultPressPublications);

    ini.WriteBool('System','CheckBoxUseExternalPlanLoad', UseExternalPlanLoad);
    ini.WriteString('System','EditExternalPlanLoadExe', ExternalPlanLoaderExe);

    ini.WriteBool('System','SimpleUserLookup', SimpleUserLookup);
    ini.WriteString('System','FixedDomain', FixedDomain);

    ini.WriteBool('System','PlanLoadPromptForSectionEdition', PlanLoadPromptForSectionEdition);
    ini.WriteBool('System','CheckBoxLimitTowers', LimitTowers);
    ini.WriteBool('System','FlatLook', FlatLook);
    ini.WriteBool('System','CheckBoxExcelSaveToFolder', DefaultSaveToLocalFolder);
    ini.WriteString('System','EditDefaultCSVReportfolder', DefaultCSVReportfolder);
    ini.WriteInteger('system','RadioGroupExcelEmailOption', ExcelEmailOption);

    ini.WriteString('System','EditDefaultExcelEmailTO', DefaultExcelEmailTO);
    ini.WriteString('System','EditDefaultExcelEmailCC', DefaultExcelEmailCC);
    ini.WriteString('System','EditDefaultExcelEmailSUBJ', DefaultExcelEmailSUBJ);

    ini.WriteBool('system','CheckBoxAllowLocationPressAllSelection', AllowLocationPressAllSelection);
    ini.WriteBool('system','CheckBoxAllowOnlyDefaultLocationPress', AllowOnlyDefaultLocationPress);
    ini.WriteInteger('system','RadioGroupLocationPressFilterMode', LocationPressFilterMode);

    ini.WriteString('System','gridSize',IntToStr(NcolsSeparationView));

    ini.WriteBool('system','CheckBoxOnlyConnectPlanCenterUser', OnlyConnectPlanCenterUser);

    ini.WriteBool('system','CheckBoxUseAdministrativeGroups', UseAdministrativeGroups);
    ini.WriteBool('system','CheckBoxUseADGroups', UseADGroups);
    ini.WriteBool('system','CheckBoxUseWindowsUser', UseWindowsUser);

    ini.WriteString('System','Editdefaultsavepagelistfile',DefaultSavePageListFile);

    ini.WriteInteger('ListViewFilter','NFilter', Length(FilterList));
    for i := 0 to Length(FilterList)-1 do
      ini.WriteString('ListViewFilter','ListViewFilter'+IntToStr(i+1),FilterList[i]);

    ini.WriteInteger('Markgroup','NMarkgroup', Length(DefMarksList));
    for i := 0 to Length(DefMarksList)-1 do
      ini.WriteString('Markgroup','Markgroup'+IntToStr(i+1),DefMarksList[i]);

    ini.WriteInteger('Zone','NZone', Length(ZoneNamesList));
    for i := 0 to Length(ZoneNamesList)-1 do
      ini.WriteString('Zone','Zone'+IntToStr(i+1), ZoneNamesList[i]);


    ini.WriteInteger('cyl','Ncyl', Length(CylinderNameTranslation));
    for i := 0 to Length(CylinderNameTranslation)-1 do
    begin
      ini.WriteString('cyl','cyl'+ IntToStr(i+1), CylinderNameTranslation[i].Key);
      ini.WriteString('cyl','cylvalue'+IntToStr(i+1), CylinderNameTranslation[i].Value);
    end;

    ini.WriteInteger('towfilter','Ntowfilter', Length(TowerNameTranslation));
    for i := 0 to Length(TowerNameTranslation)-1 do
    Begin
      ini.WriteString('towfilter','towfiltername'+IntToStr(i+1), TowerNameTranslation[i].Key);
      ini.WriteString('towfilter','towfilter'+IntToStr(i+1),TowerNameTranslation[i].Value);
    end;

    ini.WriteInteger('stack','Nstack', Length(StackNamesList));
    for i := 0 to Length(StackNamesList)-1 do
      ini.WriteString('stack','stack'+IntToStr(i+1),StackNamesList[i]);

    ini.WriteInteger('Tower','NTower', Length(PressTowers));
    for i := 0 to Length(PressTowers)-1 do
    begin
      ini.WriteString('Tower','Press'+IntToStr(i),PressTowers[i].Press);
      ini.WriteString('Tower','Tower'+IntToStr(i),PressTowers[i].Tower);
    end;

    ini.WriteInteger('System','ReportTimeOut', ReportTimeOut);
    ini.WriteString('System','ReportSaveFolder', ReportSaveFolder);
    ini.writeInteger('System','EmailUsePublicationSpecificMail',Integer(EmailUsePublicationSpecificMail));
    ini.writeInteger('System','ReportOnProductionDeleteEmail',Integer(ReportOnProductionDeleteSendEmail));

    ini.WriteString('System','MailFrom', MailFrom);
    ini.WriteString('System','MailTo', MailTo);
    ini.WriteString('System','MailCC', MailCC);
    ini.WriteString('System','MailSubject', MailSubject);

    ini.WriteString('System','Editmainarchivefolderhighres', MainArchiveFolderHighres);
    ini.WriteString('System','Editmainarchivefolderlowres', MainArchiveFolderLowres);

    ini.WriteString('System','Editlistime', SeparationTimeFormat);

    ini.WriteBool('System','Writeplanlogfile',Writeplanlogfile);

    ini.WriteBool('system','showallactionsin3', ShowAllActionsOverrule);
    ini.WriteBool('System','CheckBoxreimcopies', SelectAllCopiesOnReimage);
    ini.WriteBool('System','CheckBoxarchiveenabled', ArchiveEnabled);

    ini.WriteBool('System','CheckBoxdefarchivehighress', DefaultArchiveHighres);
    ini.WriteBool('System','CheckBoxdefarchivelowres', DefaultArchiveLowres);

    ini.WriteBool('System','CheckBoxCheckJpgTag', CheckJpegTag);
    ini.WriteBool('System','CheckBoxsetcommentonfalsespreads', SetCommentOnFalseSpreads);
    ini.WriteBool('System','CheckBoxclearpublonload', PlanningClearPubliationsOnLoad);

    ini.WriteBool('System','CheckBoxSellallcopiesprod', ProductionSelectAllCopies);
    ini.WriteBool('System','CheckBoxgtoneedapr', PreviewGoToNeedApproval);

    ini.WriteBool('System','CheckBoxorderintopcap', PlateviewOrderInCaption);

    ini.WriteBool('System','CheckBoxdefaultautomateplanname', DefaultAutomatePlanname);
    ini.WriteBool('System','CheckBoxPlatenothumbrot', PlateNoThumbnailRotation);
    ini.Writeinteger('System','UseWebfileswithversions',Integer(UseWebFileNameWithVersion));
    ini.Writeinteger('System','Editreimextstat', ReimageExternalStatus);

    ini.WriteBool('System','CheckBoxDefaultThumbnailOnlyPagePlans', DefaultThumbnailOnlyPagePlans);
    ini.writeInteger('System','RadioGrouptimedrules', TimedEditionRule);
    ini.WriteBool('System','CheckBoxractivateonlyblack', ActivateOnlyBlack);

    ini.WriteBool('System','CheckBoxsplit1upruns', Split1UpRuns);

    ini.WriteBool('System','CheckBoxShowInkDensityInformation', ShowInkDensityInformation);
    ini.WriteBool('System','CheckBoxShowSizeInformation', ShowSizeInformation);
    ini.WriteBool('System','CheckBoxAlwaysShowAllPresses', AlwaysShowAllPresses);

    ini.WriteBool('System','CheckBoxShowPressTime', ProductionShowPressTime);
    ini.WriteBool('System','XMLPlanAddTimestampToFileName', XMLPlanAddTimestampToFileName);


    for i := 0 to Length(VisiblePressesConfig)-1 do
      ini.WriteBool('visiblepresses', VisiblePressesConfig[i].Press, VisiblePressesConfig[i].Visible);

    ini.WriteBool('System','CheckBoxUseadobereader', LoadPdfInPreview);
    ini.WriteBool('System','CheckBoxpaginarecalc', AllowPaginaRecalculate);
    ini.WriteBool('System','CheckBoxignorenetuse', IgnoreNetUseCommand);
    ini.WriteBool('System','CheckBoxtimedEd', AllowTimedEditions);

    ini.WriteInteger('System','RadioGroupSendemail', SendEmailMode);
    ini.WriteString('System','Editemailserver', EmailServer);
    ini.WriteString('System','Editemailadress', EmailFromAddress);
    ini.WriteBool('System','CheckBoxemailasuser', EmailLoginNameAsSenderName);

    ini.WriteString('System','Editsendername', EmailSenderName);
    ini.WriteString('System','Editemailtitle', EmailTitleDefinition);
    ini.WriteString('System','Editemailpagename', EmailPagenameDefinition);
    ini.WriteInteger('System','Editminthumblevel', ThumbnailTreeMinimumLevel);
    ini.WriteString('System','EditAutoLoginUser', AutoLoginUser);
    ini.WriteString('System','EditAutoLoginPassword', TUtils.EncodeBlowfish(AutoLoginPassword));

    ini.WriteString('System','EditPathtohoneywell', PathToHoneywell);
    ini.WriteString('System','EditHoneywellusername', HoneywellUsername);
    ini.WriteString('System','EditHoneywellpassword', HoneywellPassword);

    ini.WriteBool('System','CheckBoxplanhold', DefaultPlanHold);
    ini.WriteBool('System','CheckBoxerrorfileretry', PlanningErrorFilesRetry);
    ini.WriteBool('System','CheckBoxprodreleaseholdallcopy', ProductionReleaseHoldAllCopies);

    ini.WriteInteger('System','RadioGroupShowpdfbook', ShowPdfBook);
    ini.WriteInteger('System','deadlockdealay', DeadlockDelay);
    ini.WriteBool('System','CheckBoxautomasked', AutoShowMasked);
    ini.WriteBool('System','CheckBoxadmintab', AdminTab);
  //  ini.WriteInteger('System','TemaChange', RadioGroupTemaChange.ItemIndex);
    ini.WriteBool('System','CheckBoxnewprodsign', ShowNewProductSign);
    ini.WriteBool('System','CheckBoxinsertsheetnumbersfor1up', InsertSheetNumbersFor1up);
    ini.WriteBool('System','CheckBoxnewtreeload', TreeUseTreeUpdateTable);
    ini.WriteBool('System','CheckBoxplanexport', PlanningExportXMLPlan);
    ini.WriteBool('System','CheckListBoxEditionText0', TreeExtraEditionText[0]);
    ini.WriteBool('System','CheckListBoxEditionText1', TreeExtraEditionText[1]);
    ini.WriteBool('System','CheckListBoxEditionText2', TreeExtraEditionText[2]);
    ini.WriteBool('System','CheckListBoxEditionText3', TreeExtraEditionText[3]);

    for i := 0 to Length(SectionText)-1 do
      ini.WriteBool('System','CheckListBoxSectionText'+IntToStr(i), SectionText[i]);

    ini.WriteBool('System','CheckBoxtreedayname', TreeShowDayName);
    ini.WriteInteger('System','ComboBoxpressreqlevel', PressDataRequestLevel);
    ini.WriteBool('System','CheckBoxpressspecreq', PressDataRequestPressSpecific);
    ini.WriteBool('System','CheckBoxShowInkZones', PreviewShowInkZones);
    ini.WriteBool('System','CheckBoxAllowDropFiles', AllowDropFiles);
    ini.WriteBool('System','CheckBoxAllowDropFilesDialog', AllowDropFilesDialog);
    ini.WriteBool('System','CheckBoxDefaultHidePagePlans', DefaultHidePagePlans);
    ini.WriteString('System','EditDropFilesDestination', DropFilesDestination);
    ini.WriteBool('System','CheckBoxinkpresspath', UsePressSpecificInkRegenPath);
    ini.WriteBool('System','CheckBoxExclusive', UsePlanLock);
    ini.WriteBool('System','dataonthumb', ShowDataOnPlateThumbnails);
    ini.WriteBool('System','Reimagedialog', ShowReimageDialog);
    ini.WriteBool('System','resetdeviceatreimage', ResetDeviceOnReimage);
    ini.WriteBool('System','reimallcolors', ReimageAllColors);
    ini.WriteBool('System','CheckBoxCustomtowerrnames', UseCustomTowerNames);
    ini.WriteInteger('System','EditAutotreeexpand', TreeAutoExpandLevel);
    ini.WriteString('System','Language', Language);

    ini.WriteInteger('System','Editunknowndropdownfilter', CheckForUnknownFilesTimerInterval);


    ini.WriteString('System','MenuToolbar color', MenuToolbarColor);
    ini.WriteString('System','Toolbar color', ToolbarColor);
    ini.WriteString('System','Toolbar color selected', ToolbarSelectedColor);

    ini.WriteBool('System','CheckBoxreselectthumb', ReselectThumbnails);
    ini.WriteBool('System','CheckBoxreselectplates', ReselectPlates);
    ini.WriteInteger('System','RadioGroupstartupsize', StartupWindowsSize);
    ini.WriteBool('System','CheckBoxEnsurePreviewFormInFront', EnsurePreviewFormInFront);
    ini.WriteBool('System','CheckBoxCustomrel', UseCustomReleaseScript);
    ini.WriteBool('System','AutoLogin', AutoLogin);
    ini.WriteBool('System','Checkboxreleaseonseprationset', ReleaseOnSeparationSet);
    ini.WriteString('System','EditCustomplanexportfilename', CustomPlanExportFilenameDefinition);
    ini.WriteBool('System','CheckBoxmanualplanning', AllowManualPlanning);
    ini.WriteBool('System','CheckBoxAllowunplannedcolors', PlanningAllowUnplannedColors);
    ini.WriteBool('System','CheckBoxreselectpages', SeparationsReselectPages);
    ini.WriteInteger('System','RadioGroupemailimageformat', EmailImageFormat);
    ini.WriteInteger('System','ComboBoxStartupTab', StartupTab);

    ini.WriteInteger('System','RadioGroupdefaultpagetypeaddedition', AddEditionDefaultUniqueType);
    ini.WriteInteger('System','RadioGroupdefaultUniqePaddedition', AddEditionDefaultApprovalUniquePage);
    ini.WriteInteger('System','RadioGroupdefaultCommonPaddedition', AddEditionDefaultApprovalCommonPage);
    ini.WriteInteger('System','RadioGroupdefaultDeviceaddedition', AddEditionDefaultKeepDevice);
    ini.WriteInteger('System','RadioGroupdefaultHoldaddedition', AddEditionDefaultHold);
    ini.WriteBool('System','CheckBoxdefaultPDF', PlanningDefaultPDF);
    ini.WriteBool('System','CheckBoxsavereportdetailcolumns', ReportIncludeHeaders);

    ini.WriteInteger('System','ComboBoxdefHardprtype', DefaultHardproofType);
    ini.WriteInteger('System','ComboBoxdefSoftprtype', DefaultSoftproofType);

    ini.WriteBool('System','CheckBoxPartialNoEdChange', PartialNoEditionChange);
    ini.WriteBool('System','CheckBoxdefsoftvait', FlatproofWaitForApproval);
    ini.WriteBool('System','CheckBoxdefhardvait', HardproofWaitForApproval);
    ini.WriteBool('System','CheckBoxArkenabled', EnableArchive);



    ini.WriteBool('System','RadioButtonwizard', UnplannedApplyDefaultMethodToWizard);
    ini.WriteBool('System','CheckBoxplatefont', PlateviewBoldFont);
    ini.WriteBool('System','CheckBoxplatedetailof', PlateDetailsOff);
    ini.WriteBool('System','CheckBoxlayoutanaki', AllowSelectionOfAnyLayout);
    ini.WriteBool('System','CheckBoxnewdelsys', NewProductDeleteSystem);

    ini.WriteBool('System','CheckBoxnocommonplates', HideCommonPlates);
    ini.WriteBool('System','CheckBoxplateshowextstat', PlateShowExternalStatus);
    ini.WriteBool('System','CheckBoxdefnochangetmpl', PlanLoadDefaultToNoTemplateChange);
    ini.WriteBool('System','CheckBoxlogapprove', LogApproval);
    ini.WriteBool('System','CheckBoxlogdisapprove', LogDisapproval);
    ini.WriteBool('System','CheckBoxloghold', LogHold);
    ini.WriteBool('System','CheckBoxlogrelease', LogRelease);
    ini.WriteBool('System','CheckBoxreimhighpri', ReimageWithHighPriority);
    ini.WriteBool('System','CheckBoxautosetedonload', PlanningAutoSetEditionsOnLoad);
    ini.WriteBool('System','CheckboxClearDeviceOnLayoutChange', ClearDeviceOnLayoutChange);
    ini.WriteString('System','EditExcludeArchiveFilter', ExcludeArchiveFilter);
    ini.WriteString('System','EditCustomchecksystemname', CustomCheckSystemName);
    ini.writeString('System','EditDefsection', AddPressRunDefaultSection);
    ini.WriteInteger('System','EditPlateminlevel', PlateTreeMinLevel);
    ini.WriteBool('System','CheckBoxApplyonlyplannedcolors', ApplyOnlyPlannedColors);
    ini.WriteBool('System','CheckBox2nounplanned', DefaultShowNoUnplanned);
    ini.WriteInteger('HalfWeb special setting','Fix halfweb at min. page',   SpecialHalfwebAtMinPage);
    ini.WriteInteger('HalfWeb special setting','Fix Halfweb page', SpecialHalfwebAtFixedPage);
    ini.WriteInteger('HalfWeb special setting','Fix Halfweb calculate page', SpecialHalfwebMode);

    ini.WriteInteger('System','PlateNameIn', PlanningPageNameIn);
    ini.WriteInteger('System','Editminpagetreelevel', SeparationMinTreeLevel);
    ini.WriteInteger('System','Autoscroolspeed', AutoScrollspeed);
    ini.WriteInteger('System','Visiblecols', SeparationsVisibleColumns);
    ini.WriteBool('System','pageindexaspagename', UsePageIndexForSorting);
    ini.WriteBool('System','CheckBoxbackwards', PlanningDefaultBackwardNumbering);
    ini.WriteBool('System','datalistautoresetdev',SeparationsResetDeviceOnReimage);

    if AutoRefreshSpeed < MinAutoRefresh then
      AutoRefreshSpeed := MinAutoRefresh;
    ini.WriteInteger('System','Autorefreshspeed', AutoRefreshSpeed);

    if TreeAutoRefreshSpeed < MinTreeRefresh then
      TreeAutoRefreshSpeed := MinTreeRefresh;
    ini.WriteInteger('System','Treerefreshspeed', TreeAutoRefreshSpeed);

    if DeviceAutoRefreshSpeed < MinDeviceRefresh then
      DeviceAutoRefreshSpeed := MinDeviceRefresh;
    ini.WriteInteger('System','UpDownupddevcontrol', DeviceAutoRefreshSpeed);

    ini.WriteBool('System','CheckBoxDeviceControlOnlyAdmins', DeviceControlOnlyAdmins);

    ini.WriteBool('System','Exportonlyselection', SeparationsExportOnlySelectedRows);
    ini.WriteBool('System','Pageicons', SeparationsShowStatusIcons);
    ini.WriteInteger('System','thumbnailsize', ThumbnailSize);
    ini.WriteInteger('System','RadioGroupdefdatesel', DefaultDateSelect);
    ini.WriteBool('System','defaultK', PlanningDefaultToMono);
    if (AlwaysUseGeneratedReadViews) then
      ini.WriteBool('System','CheckBoxpregenreadview', true)
    else
      ini.WriteBool('System','CheckBoxpregenreadview', UseGeneratedReadViews);
    ini.WriteBool('System','CheckBoxplatenamerecount', PlateNameRestartOnEachRun);
    ini.WriteBool('System','allmarkgroups', PlanningDefaultUseAllMarkGroups);
    ini.WriteBool('System','hideprogthumb', PlateHideNamesOnThumbnails);
    ini.WriteBool('System','CheckBoxthumbpagechangesonsubeditions', ThumbnailMakeChangesOnSubeditions);
    ini.WriteBool('System','CheckBoxlocaltimeset', SeparationsUseLocaleTimeFormat);
    ini.WriteBool('System','CheckBoxshowreimgediaglog', ShowReimgeDialog);
    ini.WriteBool('System','CheckBoxplatenames', PlanningGeneratePlateNames);
    ini.WriteBool('System','CheckBoxDefplaninserted', PlanningDefaultInserted);

    for i := 0 to Length(EventLogs)-1 do
      ini.WriteBool('Eventlogs', EventLogs[i].Name+IntToStr(EventLogs[i].Number), EventLogs[i].Enabled);

    ini.WriteString('System','EditHighplate', PressHighPlateName);
    ini.WriteString('System','Editlowplate', PressLowPlateName);

    ini.WriteInteger('System','Editminlogtree', MinTreeLevelLog);
    ini.WriteBool('System','CheckBoxpublfilreonproddate', TreeFilterOnProductionDate);

    ini.WriteInteger('System','UpDowninklimit', InkWarningLevel);
    ini.WriteBool('System','CheckBoxseponreadview', PreviewSeparationsOnReadview);
    ini.WriteBool('System','CheckBoxcustomplancheck', CustomPlanCheck);

    ini.WriteBool('System','CheckBoxpecomImport', PecomImport);
    ini.WriteBool('System','CheckBoxsecInpressruncom', SetSecionNamesInPressrunComment);
    ini.WriteBool('System','CheckBoxThsingleedrelease', ThumbnailsSingleEditionRelease);
    ini.WriteBool('System','CheckBoxusepresstowerinfo', UseDatabasePressTowerInfo);
    ini.WriteBool('System','CheckBoxSimplePlanLoad', SimplePlanLoad);
    ini.WriteBool('System','CheckboxNewCCFilesNames', NewCCFilesNames);
    ini.WriteBool('System','CheckboxTreeShowPrepollEvents', TreeShowPrepollEvents);
    ini.WriteBool('System','CheckBoxplatehidecopy', HidePlateCopyBar);
    ini.WriteBool('System','CheckBoxlogdelete', LogDeleteActions);
    ini.WriteBool('System','CheckBoxlogplanning', LogPlanningActions);
    ini.WriteBool('System','CheckBoxruntrhoughpagina', PlanningRunThroughPagination);
    ini.WriteString('System','Editdefaultdevice', DefaultDevice);
    ini.WriteBool('System','CheckBoxusedefaultdevice', UseDefaultDevice);
    ini.WriteBool('System','CheckBoxsmootplateautorefresh', SmoothPlateAutoRefresh);
    ini.WriteBool('System','CheckBoxPartialNoSecChange', PartialNoSecionChange);
   // ini.WriteInteger('System','UsePressGroups', PressGroupSystem);
    ini.WriteBool('System','CheckBoxplanapproval', DefaultToApprovalRequired);
    ini.WriteBool('System','CheckBoxLeanAndMeanPreview', LeanAndMeanPreview);
    ini.WriteBool('System','CheckBoxKeepOutputVersionOnReimage', KeepOutputVersionOnReimage);
    ini.WriteBool('System','CheckBoxdefaultshowplatedetails', DefaultShowPlateDetails);
    ini.WriteInteger('System','RadioButtonBestfit', ShowPreviewBestfit);
    ini.WriteInteger('System','EditInitzoom', ShowPreviewInitZoom);

    ini.WriteInteger('System','Editsidebarwidth', PreviewSidebarWidth);
    ini.WriteInteger('System','Editsidebarheight', PreviewSidebarHeight);

    ini.WriteBool('System','CheckBoxthumbshowmono', ThumbnailsShowMonoPDFIndicator);
    ini.WriteBool('System','CheckBoxplateshowripsystem', PlateviewShowRipSystem);
    ini.WriteBool('System','CheckBoxusepublicationdefaults', PlanningUsePublicationDefaults);
    ini.WriteBool('System','CheckBoxnotreelamps', NoTreeLamps);
    ini.WriteBool('System','CheckBoxusealted', EditionApplyUseAlterntiveEditionFile);
    ini.WriteInteger('System','ComboBoxdayofweek', DayOfWeek);
    ini.WriteBool('System','firstsortcoldirectiondesc',FirstColumnDescentingSort);
    ini.WriteString('System','firstsortcolname', FirstSortColumnName);
    ini.WriteBool('System','CheckBoxApplyPlateMerge', AllowApplyPlateMerge);
    ini.WriteBool('System','CheckBoxnewinkresend', DatabaseQueueInkResend);
    ini.WriteBool('System','CheckBoxTreeShowPagesReadyFlag', TreeShowPagesReadyFlag);
    ini.WriteBool('System','AlwaysfullTreeExpand', AlwaysFullTreeExpand);
    ini.WriteBool('System','CheckBoxDongA', DongAInkVisible);
    ini.WriteString('System','ComboBoxreportdetailsave', ReportSeparator);

    ini.WriteBool('System','CheckBoxSPPressrunexec', PostPlanSPPressrunExecute);
    ini.WriteBool('System','CheckBoxSPPressrunexec2', PostPlanSPPressrunExecute2);
    ini.WriteBool('System','CheckBoxSPProductionexec',PostPlanSPProductionExecute);
    ini.WriteBool('System','CheckBoxApplyDoPostPressRunProcedure',ApplyDoPostPressRunProcedure);
    ini.WriteBool('System','CheckBoxApplyDoPostProductionProcedure',ApplyDoPostProductionProcedure);



    ini.WriteBool('System','CheckBoxplatedeluxe', UseExtendedPlateView);
    ini.WriteBool('System','CheckBoxeditionignorepress', EditionUseAsMasterIgnorePress);
    ini.WriteBool('System','CheckBoxmustsetdev', MustSetDeviceOnRelease);
    ini.WriteBool('System','CheckBoxreleaseonapproval', ReleaseOnApproval);

    ini.WriteBool('split','Splitasonerun',false);

    ini.WriteString('System','externedittif','"' + ExternalTiffEditorPath + '"');
    ini.Writestring('System','externeditpdf','"' + ExternalPDFEditorPath + '"');
    ini.WriteBool('System','CheckBoxunknowncheck', CheckForUnknownFilesTimer);
    ini.WriteBool('System','CheckBoxAllowInkfileRegenerate', AllowInkfileRegenerate);

    ini.WriteInteger('System','Zoomstep', PreviewZoomStep);
    ini.WriteString('System','Editdefaultfirsted', PlanningDefaultFirstEdition);
    ini.WriteString('System','Editunknownpdf', '"' + UnknownPDFfolder + '"');
    ini.WriteString('System','Editarchivepath', '"' + PDFArchivefolder + '"');

    ini.WriteBool('System','Weekinfilter', TreeExtraPublicationText[0]);
    ini.WriteBool('System','Orderinfilter', TreeExtraPublicationText[1]);
    ini.WriteBool('System','Commentinfilter', TreeExtraPublicationText[2]);
    ini.WriteBool('System','Custommerinfilter', TreeExtraPublicationText[3]);
    ini.WriteBool('System','Publinfilter', TreeExtraPublicationText[4]);
    ini.WriteBool('System','INKinPublinfilter', TreeExtraPublicationText[5]);
    ini.WriteBool('System','INKALIASinPublinfilter', TreeExtraPublicationText[6]);
    ini.WriteBool('System','OUTALIASPublinfilter', TreeExtraPublicationText[7]);
    ini.WriteBool('System','PressTimePublinfilter', TreeExtraPublicationText[8]);
    ini.WriteBool('System','ProdOrderPublinfilter', TreeExtraPublicationText[9]);

    ini.WriteBool('System','CheckBoxOrstacks', OrStackpositionsTogether);
    ini.WriteString('System','EditCustomplanexportdest',  '"' + PlanXMLExportFolder + '"');
    ini.WriteBool('System','CheckBoxautoflatproof', AutoFlatProof);
    ini.WriteBool('System','CheckBoxpagefullautorefresh', SeparationsFullAutorefresh);
    ini.WriteBool('System','CheckBoxKeeptreeexpantion', KeepTreeExpansion);
    ini.WriteBool('System','CheckBoxShowWeekNr', ShowWeekNumberInTree);
    ini.WriteBool('System','CheckBoxAutoplannumbergen', PlanningAutoOrderNumberBergen);
    ini.WriteBool('System','CheckBoxPrevcomment', PreviewCommentAsCaption);
    ini.WriteString('System','Edithighresarch', ArchiveHigresFilenameDefinition);
    ini.WriteString('System','Editarchdate', ArchiveLowResDateDefinition);




    ini.WriteBool('System','CheckBoxshowallgraphtime', ReportShowAllGraphTime);
    ini.WriteString('System','ComboBoxgraphtimeformat', GraphTimeFormat);
    ini.WriteBool('System','CheckBoxpagesshowall', SeparationsAllowShowAllPublications);
    ini.WriteBool('System','CheckBoxUseDBtowernames', UseDBTowerNames);
    ini.WriteBool('System','CheckBoxPlanrepair', PlanRepair);
    ini.WriteBool('System','CheckBoxNologin', NoLoginPrompt);
    ini.WriteBool('System','CheckBoxthumbshowhold', ThumnailsShowHold);
    ini.WriteBool('System','CheckBoxgenrepwhendel', GenerateReportWhenDeleting);
    ini.WriteBool('System','CheckBoxtreebyedid', TreeOrderByEditionID);
    ini.WriteBool('System','CheckBoxuniqloconly', EditionsAssignUniqueToLocalOnly);
    ini.WriteString('System','Editreportdateform', ReportDateFormat);

    ini.WriteInteger('System','RadioGroupTreeorder', TreeOrder);
    ini.WriteString('System','ComboBoxSepSEP', CommaSeparatorChar);
    ini.WriteInteger('System','EditMinzoom', PreviewMinzoom);
    ini.WriteInteger('System','EditMaxzoom', PreviewMaxzoom);
    ini.WriteBool('System','CheckBoxCommenttime', AddTimeToPageComment);
    ini.WriteBool('System','CheckBoxplannameintree', ShowPlannameInTree);
    ini.WriteBool('System','CheckBoxShowsidebar', PreviewShowSidebar);

    ini.WriteBool('System','CheckBoxremovemissingcolorsonaprove', RemoveMissingColorsOnApprove);
    ini.WriteBool('System','CheckBoxautoreimondevch', AutoReImageOnDeviceChange);
    ini.WriteInteger('System','Editminplatenamelength', MinimumPlatenameLength);
    ini.WriteBool('System','CheckBoxshowdevcontrol', ShowDeviceControl);
    ini.WriteBool('System','CheckBoxpressindevcontrol', DeviceControlUsePressDevices);
    ini.WriteBool('System','CheckBoxSEPHEader', PageListExportIncludeHeaders);
    ini.WriteString('System','Editdefcolorproof', PlanningDefaultColorProofer);
    ini.WriteString('System','Editdefpdfproof', PlanningDefaultPDFProofer);
    ini.WriteString('System','EditdefBWproof', PlanningDefatulMonoProofer);
    ini.WriteBool('System','CheckBoxpregendns', PreviewUsePregeneratedDns);
    ini.WriteString('System','Editcustomdelcomdest', CustomXMLReportOutputFolder);
    ini.WriteString('system','EditDeafaultreportfolder', DefaultReportFolder);
    ini.WriteBool('System','CheckBoxdefaultsetcomed', SetCommentOnAllEditions);
    ini.WriteBool('system','CheckBoxAutorefreshon', AutoRefreshOn);
    ini.WriteBool('system','CheckBoxthumbshowextstat', ThumbnailsShowExternalStatus);
    ini.WriteBool('System','CheckBoxShowtemplateincaption', PlatesShowTemplateInCaption);
    ini.WriteBool('System','CheckBoxmanhw', PlanningAllowManualHalfWebOverride);
    ini.WriteBool('System','CheckBoxautoconsole', AutoConsole);
    ini.WriteString('System','Editconsolename', ConsoleName);
    ini.WriteInteger('System','Editmaxconsoleage', MaxConsoleAge);
    ini.WriteBool('System','CheckBoxForcesamedev', ForceSameDevice);
    ini.WriteBool('System','CheckBoxAllowparalelview', AllowParalelView);
    ini.WriteBool('System','CheckBoxforcewhencommon', EditionsSetForceWhenCommon);
    ini.WriteBool('System','CheckBoxusetruesheetside', UseTrueSheetSide);
  //  ini.WriteBool('System','CheckBoxshowallfilter', TreeShowAllLocationOption);
    ini.WriteBool('System','CheckBoxSelectAllCopiesOnRelease', SelectAllCopiesOnRelease);
    ini.WriteBool('System','CheckBoxcontroldev', AllowControlDevices);
    ini.WriteString('System','Editplannedpagenamedata', PlannedPageNameDataFile);
    ini.WriteInteger('System','UpDowndropdownfilter', UnknownFilesFileNameLengthMatch);
    ini.WriteBool('System','CheckBoxprodshoworder', ProductionViewShowOrder);
    ini.WriteBool('System','CheckBoxShowpitstoplog', ThumbnailShowPitstopLog);
    ini.WriteBool('System','CheckBoxprodshowRipsetup', ProductionShowRipSetup);
    ini.WriteBool('System', 'CheckBoxShowUnknownPanel', ShowPanelUnknownFiles);
    ini.WriteInteger('System','EditCheckTimeUnknown', ShowPanelUnknownFilesRefreshTime);
    ini.WriteBool('System','CheckBoxcustforcetoaplied', ForcePlanToApplied);
    ini.WriteBool('System','CheckBoxOverruleretransmit', RestrictRetransmit);
    ini.WriteBool('system','CheckBoxplanclearsections', PlanClearSections);
    ini.WriteBool('System','CheckBoxplateReimondevch', PlatesAutoReimageOnDeviceChange);
    ini.WriteBool('System','CheckBoxnewinkregen', NewInkRegeneration);
    ini.WriteInteger('System','Editminprodtreelevel', ProductionMinTreeLevel);
  //  ini.WriteBool('System','CheckBoxshowpressfilt', ShowPressFilters);


    ini.WriteBool('System','CheckBoxforcereadorder', ThumbnailForceReadorder);
    ini.WriteBool('System','CheckBoxplatethumb', UsePlateviewThumbnails);
    ini.WriteBool('System','CheckBoxgraydns', GrayDensityMap);
    ini.WriteBool('System','CheckBoxUseFileCenterTiffArchive', UseFileCenterTiffArchive);
    ini.WriteBool('System','CheckBoxIncludeImageOnceState', IncludeImageOnceState);
    ini.WriteBool('System','CheckBoxplateprtsecpage', PlatePrintoutUseSectionPage);
    ini.WriteBool('System','CheckBoxplatespecialstanding', PlatesShowPagesStanding);
    ini.WriteBool('System','CheckBoxAllowfalsespret', ThumbnailAllowSetFalseSpread);
    ini.WriteBool('System','CheckBoxstatresetonpagetypechange', ThumbnailResetStatusOnPageTypeChange);
    ini.WriteBool('system','CheckBoxpagedelete', AllowPageDelete);
    ini.WriteBool('System','CheckBoxtowerorderauto', AutoTowerOrder);
    ini.WriteBool('System','CheckBoxaddcopydialog', ShowAddCopyDialog);
    ini.WriteBool('System','CheckBoxuknownsendlog', ErrorFileRetrySendLog);
    ini.WriteBool('System','CheckBoxDecreasever', DecreaseVersion);
    ini.WriteBool('System','CheckBoxOnlySecined', EditionViewOnlySecInEd);
    ini.WriteInteger('System','RadioGroupreleaserulebase', ReleaseRuleBasedOn);
    ini.WriteBool('System','CheckBoxapprovetimeonrelease', SetApproveTimeOnRelease);
    ini.WriteString('System','Editaltpagenamefield', AlternativePageNameField);
    ini.WriteString('System','EditAltSheet', AlternativeSheetnameField);
    ini.WriteBool('System','CheckBoxuseimportcenter', PlanningUseImportCenter);
    ini.WriteString('System','Editimportcenterinputpath', ImportCenterInputPath);
    ini.WriteString('System','Editimportcenterdonepath', ImportCenterDonePath);
    ini.WriteString('System','Editimportcentererrorpath', ImportCenterErrorPath);
    ini.WriteBool('System','CheckBoxenablespecifiksel', EnablePressSpecificSelection);
    ini.WriteBool('System','CheckBoxpresstimeinplatetree', PressTimeInPlateTree);
    ini.WriteBool('System','CheckBoxCheckPlanningRipSetup', PlanningRipSetup);
    ini.WriteBool('System','CheckBoxCheckPlanningPageFormat', PlanningPageFormat);
    ini.WriteBool('System','CheckBoxNewPreviewNames', NewPreviewNames);
    ini.WriteBool('System','CheckBoxPdfunknown', ShowPdfUnknownFiles);
    ini.WriteBool('System','CheckBoxpageprevseps', PreviewPreloadSeparations);
    ini.WriteBool('System','CheckBoxpageprevlevel', PreviewPreloadDns);
    ini.WriteBool('System','CheckBoxplateprevseps', PreviewPreloadPlateSeparations);
    ini.WriteBool('System','CheckBoxplateprevlevel', PreviewPreloadPlateDns);
    ini.WriteBool('System','CheckBoxplateprevZones', PreviewPreloadInkzones);
    ini.WriteBool('System','CheckBoxonlyaplyonunapplied', OnlyApplyOnUnapplied);
    ini.WriteBool('System','CheckBoxhttimedeadline', PlanningHotTimeFromDeadline);
    ini.WriteInteger('System','Edithottimehours', PlanningHotTimeFromDeadlineAddHours);
    ini.WriteInteger('System','ComboBoxZoomfilter', PreviewZoomfilter);
    ini.WriteBool('system','CheckBoxAutomultipress', ApplyPlanAutoMultiPress);
    ini.WriteBool('system','CheckBoxtextongrp', TextOnReportGraph);
    ini.WriteInteger('System','RadioGroupplatedonestat', PlateDoneStatisticsMode);
    ini.WriteBool('System','CheckBoxAllowDropFilesDeleteAfterCopy', AllowDropFilesDeleteAfterCopy);
    ini.WriteBool('System','CheckBoxAlwaysUseOffset0OnApply', AlwaysUseOffset0OnApply);
    ini.WriteBool('System','CheckBoxnewplatedata', NewPlateDataSystem);

    ini.WriteInteger('System','ListViewplannamedstyles', Length(PlannedNameDefinitions));
    ini.Writeinteger('System','ListViewplannamedstylesdefault',0);

    ini.WriteBool('System','CheckBoxUseNiceManualStacker', CustomManualStackerSet);

    ini.WriteBool('System','TreeShowWeekNumberInfo', TreeShowWeekNumberInfo);



    for i := 0 to Length(PlannedNameDefinitions)-1 do
    begin
      ini.WriteString('ListViewplannamedstyles','name'+IntToStr(i), PlannedNameDefinitions[i].Name);
      ini.WriteString('ListViewplannamedstyles','format'+IntToStr(i),PlannedNameDefinitions[i].Format);
      ini.WriteString('ListViewplannamedstyles','date'+IntToStr(i), PlannedNameDefinitions[i].Dateformat);
      if PlannedNameDefinitions[i].Enabled then
        ini.Writeinteger('System','ListViewplannamedstylesdefault', i);
    end;

    for i := 0 to Length(ArchiveFolderNameDefinitions)-1 do
      ini.WriteBool('CheckListBoxAFoldername', IntToStr(i), ArchiveFolderNameDefinitions[i]);

    for i := 0 to Length(ReleaseRules)-1 do
      ini.WriteBool('CheckListBoxreleaserules',IntToStr(i), ReleaseRules[i]);

    for i := 0 to Length(ProductionColumns)-1 do
    begin
      ini.WriteInteger('StringGridprodsW', IntToStr(i), ProductionColumns[i].Width);
      ini.WriteString('StringGridprodsWName', IntToStr(i), ProductionColumns[i].ColumnName);

    end;

    for i := 0 to Length(PlateText)-1 do
    begin
      ini.WriteString('CheckListBoxPlatetext','name'+ IntToStr(i), PlateText[i].Name);
      ini.WriteBool('CheckListBoxPlatetext','Checked'+ IntToStr(i), PlateText[i].Enabled);
    end;

    for i := 0 to Length(PressRunTexts)-1 do
    begin
      ini.WriteString('CheckListBoxpressruntexts','name'+IntToStr(i),PressRunTexts[i].Name);
      ini.WriteBool('CheckListBoxpressruntexts','Checked'+IntToStr(i),PressRunTexts[i].Enabled);
    end;

    ini.WriteBool('System','CheckBoxplatepagepreview', PlatesAllowSinglePagePreview);

    for i := 0 to Length(PlateCaptionText)-1 do
    begin
      ini.WriteString('CheckListBoxplatecaption','name'+IntToStr(i), PlateCaptionText[i].Name);
      ini.WriteBool('CheckListBoxplatecaption','Checked'+IntToStr(i), PlateCaptionText[i].Enabled);
    end;

    for i := 0 to Length(ThumbnailCaptionText)-1 do
    begin
      ini.WriteString('CheckListBoxthumbtext','name'+IntToStr(i), ThumbnailCaptionText[i].Name);
      ini.WriteBool('CheckListBoxthumbtext','Checked'+IntToStr(i), ThumbnailCaptionText[i].Enabled);
    end;

    for i := 0 to Length(ThumbnailGroupCaptionText)-1 do
    begin
      ini.WriteString('CheckListBoxthgroupecap','name'+IntToStr(i), ThumbnailGroupCaptionText[i].Name);
      ini.WriteBool('CheckListBoxthgroupecap','Checked'+IntToStr(i), ThumbnailGroupCaptionText[i].Enabled);
    End;

    ini.WriteBool('CheckListBoxMiscedit','Checked0', EnableEditOfMiscString2);
    ini.WriteBool('CheckListBoxMiscedit','Checked1', EnableEditOfMiscString3);
    ini.WriteBool('CheckListBoxMiscedit','Checked2', EnableEditOfMiscInt2);
    ini.WriteBool('CheckListBoxMiscedit','Checked3', EnableEditOfMiscInt3);

    ini.WriteInteger('System','ComboBoxdefpagina', PlanningPaginationMode);
    ini.WriteBool('System','CheckBoxFastTree', SynchronizedTreeUpdate);

    for i := 0 to PRODUCTIONCOLUMNCOUNT-1 do
    begin
      ini.WriteString('Prodgridfonts'+IntToStr(i),'name'+IntToStr(i), ProductionGridFonts[i].Name);
      ini.writeInteger('Prodgridfonts'+IntToStr(i),'Style'+IntToStr(i),Byte(ProductionGridFonts[i].Style));
      ini.writeInteger('Prodgridfonts'+IntToStr(i),'Size'+IntToStr(i), ProductionGridFonts[i].Size);
    end;

    for i := 0 to Length(ThumbnailStatusBar)-1 do
     ini.WriteBool('thumbstatbar'+IntToStr(i),ThumbnailStatusBar[i].Name,ThumbnailStatusBar[i].Enabled);

    ini.WriteString('System','Editlowarch', ArchiveLowResNameDefinition);
    ini.WriteBool('System','CheckBoxPlanpri', PlanningUsePublicationDefaultlPriority);
    ini.WriteBool('System','CheckBoxUsehoneywell', UseHoneywell);
    ini.WriteBool('System','CheckBoxswapplatemerger', SwapPlateMerger);
    ini.WriteBool('System','CheckBoxpreparetrans', PlateTransmissionSystem);
    ini.WriteBool('System','CheckBoxtreeonceimaged', TreeGreenOnceImaged);
    ini.WriteBool('System','CheckBoxplaninkaliasload', PlanInkaliasLoad);

    ini.WriteInteger('System','UpDownhothours', HotHourPriorityDifference);
    ini.WriteInteger('System','UpDownhotlength', HotHourPriorityLength);
    ini.WriteInteger('System','UpDownhotbefore', HotHourPriorityBefore);
    ini.WriteInteger('System','UpDownhotunder', HotHourPriorityDuring);
    ini.WriteInteger('System','UpDownhotafter', HotHourPriorityAfter);

    ini.WriteBool('system','CheckBoxSeparateNodesPerPressrun', SeparateNodesPerPressrun);
    ini.WriteInteger('system','RadioGroupplatetreeexp', PlateTreeExpansion);

    for i := 0 to Length(ThumbnailSortingOrder)-1 do
      ini.WriteString('Thumborder', IntToStr(i), ThumbnailSortingOrder[i]);

    for i := 0 to Length(ThumbnailEvents)-1 do
      ini.WriteBool('CheckListBoxThumbevents', IntToStr(i), ThumbnailEvents[i].Enabled);

    for i := 0 to Length(PrePollEventNames)-1 do
      ini.WriteString('MemoShortevent',IntToStr(i),PrePollEventNames[i]);

    for i := 0 to Length(PlatePrintListTitleDefinition)-1 do
      ini.WriteBool('CheckListBoxPLtPrnttitle', IntToStr(i), PlatePrintListTitleDefinition[i]);

    for i := 0 to Length(PlatePrintListPlateDefinition)-1 do
      ini.WriteBool('CheckListBoxPLtPrntplate', IntToStr(i), PlatePrintListPlateDefinition[i]);

    For i := 0 to Length(SeparationsReportColumns)-1 do
      ini.WriteBool('CheckListBoxdetailsavecols', IntToStr(i), SeparationsReportColumns[i]);

    ini.WriteBool('System','CheckBoxsuperall', SuperUserMaySeeAll);

  //  ini.WriteBool('System','CheckBoxalllocations', ShowAllLocations);


    ini.WriteString('System','ComboBoxlocations', DefaultLocation);
    ini.WriteString('System','ComboBoxDefaultPress', DefaultPress);
    ini.WriteBool('System','CheckBoxdelonlyselon', DeleteOnlyOnSelectedPress);
    ini.WriteBool('System','CheckBoxShowPageNote', ShowPageNoteIndicator);




     ini.WriteString('System','ColorBoxMenuToolbarSelected', ColorToString(ColorBoxMenuToolbarSelected));
    ini.WriteString('System','ColorBoxToolbarSelected', ColorToString(ColorBoxToolbarSelected));
    ini.WriteString('System','ColorMapToolBarSelectedColor', ColorToString(ColorMapToolBarSelectedColor));



   // SaveSpecificFont(ini,'plateprint', FormSettings.FontDialogplateprint.font);
     SaveSpecificFont(ini,'plateprint', FontDialogplateprintFont);



    for i := 0 to Length(VisibleTowers)-1 do
      ini.WriteBool('CheckListBoxvisibletowers',VisibleTowers[i].Press+'-'+VisibleTowers[i].Tower,VisibleTowers[i].Visible) ;

    for i := 0 to Length(DefaultUnknownFilesFolders)-1 do
      ini.WriteBool('CheckListBoxdefunknown',DefaultUnknownFilesFolders[i].Name, DefaultUnknownFilesFolders[i].Enabled);

    for i := 0 to Length(MaxPagesPerPress)-1 do
      ini.WriteString('Maxpresspage','press'+MaxPagesPerPress[i].Key, MaxPagesPerPress[i].value);

    for i := 0 to Length(OldInkPathsPerPress)-1 do
      ini.WriteString('ValueListEditorOldInk','press'+OldInkPathsPerPress[i].Key, OldInkPathsPerPress[i].Value);

    for i := 0 to Length(InkGenerationSystemPerPress)-1 do
      ini.WriteString('Inpresetvalues',InkGenerationSystemPerPress[i].Key, InkGenerationSystemPerPress[i].Value);

    for i := 0 to Length(VisiblePressesConfig)-1 do
      ini.WriteBool('visiblepresses',Prefs.VisiblePressesConfig[i].Press,Prefs.VisiblePressesConfig[i].Visible);

    ini.WriteBool('System','CheckBoxShowSpecificDevicesOnly', ShowSpecificDevices);
    ini.WriteBool('System','CheckBoxOnlyShowDefaultDevices', OnlyShowDefaultDevices);


    for i := 0 to Length(SpecificDevices)-1 do
       ini.WriteBool('SpecificDevices',SpecificDevices[i].Name, SpecificDevices[i].Enabled);



    ini.Free;

    ini := TIniFile.Create(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'PlanCenter_datalist.ini');
    for i := 0 to DATALISTCOLUMNSCOUNT-1 do
      ini.WriteBool('Export',DataExportColumns[i].Name,DataExportColumns[i].Enabled);
    ini.Free;

    if (CustomReleaseScript.Count > 0) then
      CustomReleaseScript.savetoFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'Customreleasescript.txt');




  (*  if not ShowAllLocations then
    begin
     formmain.ComboBoxpalocationNy.Items.Clear;
     formmain.ComboBoxactivequeue.Items.Clear;
     formmain.ComboBoxplanlocation.Items.Clear;

     formmain.ComboBoxplanlocation.Items.add(DefaultLocation);
     formmain.ComboBoxpalocationNy.Items.add(DefaultLocation);
     formmain.ComboBoxactivequeue.Items.add(DefaultLocation);

     formmain.ComboBoxpalocationNy.ItemIndex := 0;
     formmain.ComboBoxactivequeue.ItemIndex := 0;
     formmain.ComboBoxplanlocation.ItemIndex := 0;
    end
    else
    begin
     formmain.ComboBoxplanlocation.ItemIndex :=formmain.ComboBoxplanlocation.items.IndexOf(DefaultLocation);
     formmain.ComboBoxpalocationNy.ItemIndex :=formmain.ComboBoxpalocationNy.items.IndexOf(DefaultLocation);
     formmain.ComboBoxactivequeue.ItemIndex :=formmain.ComboBoxactivequeue.items.IndexOf(DefaultLocation);
    end;
    *)
  except

  end;
end;


procedure TPrefs.LoadWarningSystem;
var
  i   : Integer;
  ini : Tinifile;
begin
  try
    ini := tinifile.Create(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory())+'WarnSystem.ini');
    for i := 0 to Length(Prefs.StatusWarningList)-1 do
      Prefs.StatusWarningList[i].Enabled := ini.ReadBool('Statuswarning',IntToStr(i), false);
    for i := 0 to Length(Prefs.ExtStatusWarningList)-1 do
      Prefs.ExtStatusWarningList[i].Enabled := ini.ReadBool('EXTStatuswarning',IntToStr(i), false);
    Prefs.WarnIfAnyDisapproved := ini.ReadBool('approvalStatuswarning','disapparoved', Prefs.WarnIfAnyDisapproved);
    ini.Free;
  except
  end;
end;

procedure TPrefs.LoadShortCuts;
var
  i   : Integer;
  ini : Tinifile;
begin
   try
        ini := tinifile.Create(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'Shortcuts.ini');
        for i := 0 to 9 do
        begin
          treeShortcuts[i].Key         := ini.readinteger('Shortcut'+IntToStr(i),'key',0);
          treeShortcuts[i].location    := ini.readstring('Shortcut'+IntToStr(i),'Location','');
          treeShortcuts[i].press       := ini.readstring('Shortcut'+IntToStr(i),'press','');
          treeShortcuts[i].pubdate     := ini.readstring('Shortcut'+IntToStr(i),'pubdate','');
          treeShortcuts[i].publication := ini.readstring('Shortcut'+IntToStr(i),'publication','');
          treeShortcuts[i].Edition     := ini.readstring('Shortcut'+IntToStr(i),'Edition','');
          treeShortcuts[i].Section     := ini.readstring('Shortcut'+IntToStr(i),'Section','');
        end;
        ini.free;
      except
      end;
end;

procedure TPrefs.SaveShortCuts;
var
  i   : Integer;
  ini : Tinifile;
begin
  try
    ini := tinifile.Create(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'Shortcuts.ini');
    for i := 0 to 9 do
    begin
      ini.WriteInteger('Shortcut'+IntToStr(i),'key',treeShortcuts[i].Key);
      ini.WriteString('Shortcut'+IntToStr(i),'Location',treeShortcuts[i].location);
      ini.WriteString('Shortcut'+IntToStr(i),'press',treeShortcuts[i].press);
      ini.WriteString('Shortcut'+IntToStr(i),'pubdate',treeShortcuts[i].pubdate);
      ini.WriteString('Shortcut'+IntToStr(i),'publication',treeShortcuts[i].publication);
      ini.WriteString('Shortcut'+IntToStr(i),'Edition',treeShortcuts[i].Edition);
      ini.WriteString('Shortcut'+IntToStr(i),'Section',treeShortcuts[i].Section);
    end;
    ini.Free;
  except
  end;
end;

procedure tPrefs.SaveWarningSystem;
var
  i   : Integer;
  ini : Tinifile;
begin
  try
    ini := tinifile.Create(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory())+'warnsystem.ini');
    for i := 0 to Length(StatusWarningList)-1 do
      ini.WriteBool('Statuswarning',IntToStr(i),StatusWarningList[i].Enabled);

    for i := 0 to Length(ExtStatusWarningList)-1 do
    begin
      ini.WriteBool('EXTStatuswarning',IntToStr(i), ExtStatusWarningList[i].Enabled);
    end;

    ini.WriteBool('approvalStatuswarning','disapparoved', WarnIfAnyDisapproved);

    ini.Free;
    FormMain.SetWarningSystem;
  except
  end;
end;


function tPrefs.VisiblePressConfigNameVisible(name : string) : Boolean;
var
  i : Integer;
begin
  result := false;
  for i := 0 to Length(VisiblePressesConfig) -1 do
  begin
    if (VisiblePressesConfig[i].Press = name) then
    begin
      result := VisiblePressesConfig[i].Visible;
      exit;
    end;

  end;

end;

procedure tPrefs.SaveSpecificFont(FStream: TIniFile; Section: string; smFont: TFont);
begin
  try
    FStream.WriteString(Section, 'Name', smFont.Name);
    FStream.WriteInteger(Section, 'CharSet', smFont.CharSet);
    FStream.WriteInteger(Section, 'Color', smFont.Color);
    FStream.WriteInteger(Section, 'Size', smFont.Size);
    FStream.WriteInteger(Section, 'Style', Byte(smFont.Style));
  except
  end;
end;

procedure tPrefs.LoadSpecificFont(FStream: TIniFile; Section: string; smFont: TFont);
var
t : string;
begin

  smFont.Name := FStream.ReadString(Section, 'Name', smFont.Name);
  smFont.CharSet := TFontCharSet(FStream.ReadInteger(Section, 'CharSet', smFont.CharSet));
  smFont.Color := TColor(FStream.ReadInteger(Section, 'Color', smFont.Color));
  smFont.Size := FStream.ReadInteger(Section, 'Size', smFont.Size);
  smFont.Style := TFontStyles(Byte(FStream.ReadInteger(Section, 'Style', Byte(smFont.Style))));
end;

Function tPrefs.MakeDateTimeString(DateTime : tdatetime):String;
Begin
  result := '';
  if DateTime > EncodeDate(1900,1,1) then
  begin
    try
      result := FormatDateTime(localdatetimesettings.ShortDateFormat + ' ' + localdatetimesettings.ShortTimeFormat+':ss:zzz',DateTime)
    except
    end;
  end;
end;


end.
