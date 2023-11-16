unit ULoadDLLs;
interface
Uses
  Winapi.Windows, Vcl.Dialogs, System.SysUtils, System.IOUtils, Vcl.Forms,
  UTypes;




function LoadAllDlls : Boolean;
Var
  Imposecaldllhandle : Thandle;
  Setupdllhandle : Thandle;
  PlotInfohandle : Thandle;
  Resampledllhandle : Thandle;
  //BlowFishDllHandle : Thandle;

  Imposecalc : TImposecalc;
  CalculateImposeAsian : TImposecalc;
  RipSetupNameSetup : RipSetupNameSetupType;
  StackingBinSetup : StackingBinSetupType;
  ResampleRegisterProgress : ResampleRegisterProgressType;
  ResampleCancel : ResampleCancelType;
  ResampleInit  : ResampleInitType;
  Resample      : ResampleType;
  DeviceSetup   : DeviceSetupType;
  ApplyPlateMerge : ApplyPlateMergeType;
  SplitProduct : SplitProductType;
  Combinepressrun  : CombinepressrunType;
  PressSetup    :  PressSetupType;
  TemplateSetup : TemplateSetupType;
  UrlRequest    : UrlRequestType;
  JobNamesSetup : JobNamesSetupType;
  ChannelNamesSetup : ChannelNamesSetupType;
  PageFormatSetup : PageFormatSetupType;
  GeneralSetup       : GeneralSetupType;
  FileInfoEx : FileInfoExType;
  PublicationEditionSectionAliasSetup : PublicationEditionSectionAliasSetupType;
  ColorSetup         : ColorSetupType;

  LocationSetup      : LocationSetupType;
  ReConnectDB    : ReConnectDBType;
  PlotInfo       : PlotInfotype;
  IsPDFFile : IsPDFFileType;

  RenameFileDialog : RenameFileDialogType;

  DecodeBlowFish2 : TDecodeBlowFish2;
  EncodeBlowFish2 : TEncodeBlowFish2;

implementation

uses
  UMain,InfraLanguage;

function LoadAllDlls : Boolean;
begin
  result := false;
   TFile.AppendAllText('c:\temp\plancenterinit.log', 'loading dlls');
   try
       Imposecaldllhandle := LoadLibrary(Pchar(ExtractFilePath(Application.ExeName)+'ImposeCalc.dll'));
   except
        TFile.AppendAllText('c:\temp\plancenterinit.log', 'Exception loading ImposeCalc.dll');
   end;
   if (Imposecaldllhandle = 0) then
     TFile.AppendAllText('c:\temp\plancenterinit.log', 'Imposecaldllhandle is null')
   else
     TFile.AppendAllText('c:\temp\plancenterinit.log', 'ImposeCalc.dll loaded');

  Imposecalc := GetProcAddress(Imposecaldllhandle,'CalculateImpose');

  CalculateImposeAsian :=  GetProcAddress(Imposecaldllhandle,'CalculateImposeAsian');
  CalculateImposeVersion :=  GetProcAddress(Imposecaldllhandle,'CalculateImposeVersion');
  if addr(Imposecalc) = nil then
  begin
      TFile.AppendAllText('c:\temp\plancenterinit.log', 'Unable to load ImposeCalc.dll');
    MessageDlg(FormMain.InfraLanguage1.Translate('Unable to load ImposeCalc.dll'), mtInformation,[mbOk], 0);

    exit;
  end;

  if Addr(CalculateImposeAsian) = nil then
  begin
      TFile.AppendAllText('c:\temp\plancenterinit.log', 'Unable to load correct version of ImposeCalc.dll');
    MessageDlg(FormMain.InfraLanguage1.Translate('Unable to load correct version of ImposeCalc.dll'), mtInformation,[mbOk], 0);

    exit;
  end;

  if Addr(CalculateImposeVersion) = nil then
    imposeSize := 1
  else
    imposeSize := CalculateImposeVersion;
      TFile.AppendAllText('c:\temp\plancenterinit.log', 'Loading TemplateDialogEnt.dll..' + ExtractFilePath(Application.ExeName)+'TemplateDialogEnt.dll');
    try
      //  Setupdllhandle := LoadLibrary(Pchar(ExtractFilePath(Application.ExeName)+'TemplateDialogEnt.dll'));
        Setupdllhandle := SafeLoadLibrary(Pchar(ExtractFilePath(Application.ExeName)+'TemplateDialogEnt.dll'));
    except
         TFile.AppendAllText('c:\temp\plancenterinit.log', 'Exception loading TemplateDialogEnt.dll');
    end;

  if (Setupdllhandle = 0) then
  begin
   TFile.AppendAllText('c:\temp\plancenterinit.log', 'Unable to load TemplateDialogEnt.dll');
    MessageDlg(FormMain.InfraLanguage1.Translate('Unable to load  TemplateDialogEnt.dll'), mtError,[mbOk], 0);

    exit;
  end;
  TFile.AppendAllText('c:\temp\plancenterinit.log', 'TemplateDialogEnt.dll loaded');

  Combinepressrun := GetProcAddress(Setupdllhandle,'CombineRuns');

  CombinepressrunPoissible := Addr(Combinepressrun) <> nil;
  DeviceSetup := GetProcAddress(Setupdllhandle,'DeviceSetup');
  ApplyPlateMerge := GetProcAddress(Setupdllhandle,'ApplyPlateMerge');
  SplitProduct := GetProcAddress(Setupdllhandle,'SplitProduct');
  PressSetup := GetProcAddress(Setupdllhandle,'PressSetup');
  TemplateSetup := GetProcAddress(Setupdllhandle,'TemplateSetup');
  UrlRequest := GetProcAddress(Setupdllhandle,'UrlRequest');
  JobNamesSetup := GetProcAddress(Setupdllhandle,'JobNamesSetup');
  PageFormatSetup := GetProcAddress(Setupdllhandle,'PageFormatSetup');
  GeneralSetup := GetProcAddress(Setupdllhandle,'GeneralSetup');
  ColorSetup := GetProcAddress(Setupdllhandle,'ColorSetup');
  LocationSetup := GetProcAddress(Setupdllhandle,'LocationSetup');
  ReConnectDB := GetProcAddress(Setupdllhandle,'ReConnectDB');
  MakePdfBook := GetProcAddress(Setupdllhandle,'MakePdfBook');
  MakePdfBookFlats := GetProcAddress(Setupdllhandle,'MakePdfBookFlats');
  PublicationEditionSectionAliasSetup := GetProcAddress(Setupdllhandle,'PublicationEditionSectionAliasSetup');
  DLLGenerateReport := GetProcAddress(Setupdllhandle,'GenerateReport');
  StackingBinSetup := GetProcAddress(Setupdllhandle,'StackingBinSetup');
  RipSetupNameSetup := GetProcAddress(Setupdllhandle,'RipSetupNameSetup');
  ExportPressTemplateDataDialog :=   GetProcAddress(Setupdllhandle,'ExportPressTemplateData');
  RenameFileDialog := GetProcAddress(Setupdllhandle,'RenameFileDialog');
  MergeJpegs := GetProcAddress(Setupdllhandle,'MergeJpegs');

  DecodeBlowFish2         := GetProcAddress(Setupdllhandle,'DecodeBlowFish2');
  EncodeBlowFish2         := GetProcAddress(Setupdllhandle,'EncodeBlowFish2');
  DecodeBlowFish2 := nil;
  EncodeBlowFish2 := nil;
  if Addr(DeviceSetup) = nil then
  begin
   TFile.AppendAllText('c:\temp\plancenterinit.log', 'Unable to load DeviceSetup from TemplateDialogEnt.dll');
    MessageDlg(FormMain.InfraLanguage1.Translate('Unable to load DeviceSetup from TemplateDialogEnt.dll'), mtInformation,[mbOk], 0);

    exit;
  end;

  if Addr(PressSetup) = nil then
  begin
    MessageDlg(FormMain.InfraLanguage1.Translate('Unable to load PressSetup from TemplateDialogEnt.dll'), mtInformation,[mbOk], 0);
     exit;
  end;

  if Addr(JobNamesSetup) = nil then
  begin
    MessageDlg(FormMain.InfraLanguage1.Translate('Unable to load JobNamesSetup from TemplateDialogEnt.dll'), mtInformation,[mbOk], 0);
    exit;
  end;

  if Addr(PageFormatSetup) = nil then
  begin
    MessageDlg(FormMain.InfraLanguage1.Translate('Unable to load PageFormatSetup from TemplateDialogEnt.dll'), mtInformation,[mbOk], 0);
    exit;
  end;


  if Addr(GeneralSetup) = nil then
  begin
    MessageDlg(FormMain.InfraLanguage1.Translate('Unable to load GeneralSetup from TemplateDialogEnt.dll'), mtInformation,[mbOk], 0);
    exit;
  end;

  if addr(ColorSetup) = nil then
  begin
    MessageDlg(FormMain.InfraLanguage1.Translate('Unable to load ColorSetup from TemplateDialogEnt.dll'), mtInformation,[mbOk], 0);
    exit;
  end;

  if addr(LocationSetup) = nil then
  begin
    MessageDlg(FormMain.InfraLanguage1.Translate('Unable to load LocationSetup from TemplateDialogEnt.dll'), mtInformation,[mbOk], 0);
    exit;
  end;

  if addr(ReConnectDB) = nil then
  begin
    TFile.AppendAllText('c:\temp\plancenterinit.log', 'Unable to load ReConnectDB from TemplateDialogEnt.dll');
      MessageDlg(FormMain.InfraLanguage1.Translate('Unable to load ReConnectDB from TemplateDialogEnt.dll'), mtInformation,[mbOk], 0);

    exit;
  end;

  //BlowFishDllHandle := LoadLibrary(Pchar(ExtractFilePath(Application.ExeName)+'BlowFish.dll'));
  //DecodeBlowFish2 := nil;
  //EncodeBlowFish2 := nil;
  //try
  //  DecodeBlowFish2         := GetProcAddress(BlowFishDllHandle,'DecodeBlowFish2');
  //  EncodeBlowFish2         := GetProcAddress(BlowFishDllHandle,'EncodeBlowFish2');
  // Except
  //end;

  //if addr(DecodeBlowFish2) = nil then
  //begin
 //   MessageDlg(FormMain.InfraLanguage1.Translate('Unable to load BlowFish.dll'), mtInformation,[mbOk], 0);
 //   exit;
  //end;

  try
    ChannelNamesSetup := GetProcAddress(Setupdllhandle,'Channelsetup');
  Except
  end;


  NyFileInfoOK := false;
  NyFileInfo := GetProcAddress(Setupdllhandle,'FileInfo');
  if addr(NyFileInfo) <> nil then
  begin
    NyFileInfoOK := true;
    FileInfoEx := GetProcAddress(Setupdllhandle,'FileInfoEx');
    IsPDFFile := GetProcAddress(Setupdllhandle,'IsPDFFile');
  end else
  begin
    TFile.AppendAllText('c:\temp\plancenterinit.log', 'FileInfo in TemplateDialogEnt.dll failed');
    ShowMessage('FileInfo in TemplateDialogEnt.dll failed');
  end;

  UseMergeJpegs := Addr(MergeJpegs) <> nil;
  MakePdfBookposible := Addr(MakePdfBook) <> nil;
  MakePdfBookFlatsposible := Addr(MakePdfBookFlats) <> nil;
  PublicationEditionSectionAliasSetupPossible := Addr(PublicationEditionSectionAliasSetup) <> nil;
  ApletoDLLGenerateReport := Addr(DLLGenerateReport) <> nil;
  AbleToStackingBinSetup := Addr(StackingBinSetup) <> nil;
  ApletoUseRipSetupNameSetup := Addr(RipSetupNameSetup) <> nil;
  RenameFileDialogPossible := Addr(RenameFileDialog) <> nil;
    // NAN DISABLED!
  RenameFileDialogPossible := false;

  ExportPressTemplateDataPossible := Addr(ExportPressTemplateDataDialog) <> nil;

  FileResampleposible := false;
  if fileexists(ExtractFilePath(Application.ExeName)+'Resample.dll') then
  begin
    Resampledllhandle := LoadLibrary(Pchar(ExtractFilePath(Application.ExeName)+'Resample.dll'));
    ResampleInit := GetProcAddress(Resampledllhandle,'ResampleInit');
    if Addr(ResampleInit) <> nil then
    begin
      ResampleRegisterProgress := GetProcAddress(Resampledllhandle,'ResampleRegisterProgress');

      ResampleCancel := GetProcAddress(Resampledllhandle,'ResampleCancel');

      Resample := GetProcAddress(Resampledllhandle,'Resample');
      if Addr(Resample) <> nil then
        FileResampleposible := true;
    end;
  end;
  FormMain.writeinitlog('Create 22');

  PlotInfohandle := LoadLibrary(PChar(ExtractFilePath(Application.ExeName)+'tiffinfo.dll'));
  PlotInfo := GetProcAddress(plotinfohandle, 'PlotInfo');
  if Addr(PlotInfo) = nil then
  begin
   TFile.AppendAllText('c:\temp\plancenterinit.log', 'Unable to load plotinfo from tiffinfo.dll');
    MessageDlg('Unable to load plotinfo from tiffinfo.dll', mtInformation,[mbOk], 0);
    exit;
  end;

  result := true;
    TFile.AppendAllText('c:\temp\plancenterinit.log', 'All dlls loaded ok');
end;

end.