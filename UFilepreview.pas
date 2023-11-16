unit UFilepreview;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, imageenproc, imageenio, ieview, imageenview, imageen, StdCtrls, hyiedefs,
  xmldom, XMLIntf, msxmldom, XMLDoc, ToolWin, ActnMan, ActnCtrls,
  ActnMenus, ActnList, XPStyleActnCtrls, ComCtrls, hyieutils, iexBitmaps,
  iesettings, System.Actions, System.Contnrs, Vcl.Printers, iexLayers, iexRulers,
  iexToolbars, iexUserInteractions, iexProcEffects;

type
  TFormfilepreview = class(TForm)
    ImageEn1: TImageEn;
    XMLDocument1: TXMLDocument;
    ActionManager1: TActionManager;
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    Action4: TAction;
    Action7: TAction;
    SaveDialog1: TSaveDialog;
    ActionToolBarprevfile: TActionToolBar;
    Action5: TAction;
    PrintDialog1: TPrintDialog;
    ActionFit: TAction;
    Action6: TAction;
    Action8: TAction;
    ImageEnProc1: TImageEnProc;
    procedure FormActivate(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure Action4Execute(Sender: TObject);
    procedure Action7Execute(Sender: TObject);
    procedure Action5Execute(Sender: TObject);
    procedure ImageEn1ZoomIn(Sender: TObject; var NewZoom: Double);
    procedure ImageEn1ZoomOut(Sender: TObject; var NewZoom: Double);
    procedure ActionFitExecute(Sender: TObject);
    procedure Action6Execute(Sender: TObject);
    procedure Action8Execute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
//    procedure SetUbluebar;
  public
    JustLoadTif : Boolean;

    Nfiles : Longint;
    Files : Array[1..10] of record
                              name : String;
                              color : String;
                            End;
     Function makexmls(xmlfilename : string;
                        JPGOutputfile : String):boolean;

    Function CallResampledll:Boolean;
    Function Genprevfiles:boolean;
  end;

var
  Formfilepreview: TFormfilepreview;

implementation

Uses
  UMain, Usettings, UResampleprogress, ULoadDlls, UUtils;
{$R *.dfm}

Var
  prevresult : Longint;
Function TFormfilepreview.CallResampledll:Boolean;

Var
  skaldeklarerespgadll : Longint;
  resulttat : Integer;
begin
  Runningdll := true;
  try
    try
      strpcopy(szXmlFileName, ExcludeTrailingBackSlash(TUtils.GetTempDirectory())+'AXml.XML');

      resulttat := Resample(szXmlFileName,szErrorMessage);

      result := resulttat = 1;

     Except
     end;
  finally
    Runningdll := false;
    screen.Cursor := crdefault;
  end;
end;


Function TFormfilepreview.Genprevfiles:boolean;
Var
  IX,I : Longint;
  R : Longint;
  F: TSearchRec;
  filesok,resamok : Boolean;


  Temppath : String;

begin
  result := false;
  try
    try

      Temppath := ExcludeTrailingBackSlash(TUtils.GetTempDirectory())+'Prevtemp';

      CreateDir(Temppath);
      Deletefile(Temppath+'\aprev.jpg');

      R := FindFirst(Temppath+'\*.*',faArchive,F);
      While (r = 0) do
      begin
        deletefile(Temppath+'\'+f.name);
        r := findnext(f);
      End;
      findclose(f);

      filesok := true;
      For I := 1 to Nfiles do
      begin

        if not copyfile(pchar(files[i].name),pchar(Temppath+'\'+extractfilename(files[i].name)),true) then
        begin
          filesok := false;
          MessageDlg(formmain.InfraLanguage1.Translate('Error copying files'), mtError,[mbOk], 0);
          break;
        end;
        files[i].name := Temppath+'\'+extractfilename(files[i].name);
      end;

      if filesok then
      begin
        makexmls(ExcludeTrailingBackSlash(TUtils.GetTempDirectory()) + 'AXml.XML',Temppath+'\aprev.jpg');


        Formresampleprogress.Repaint;
        resamok := CallResampledll;

        if (resamok) and fileexists(Temppath+'\aprev.jpg') then
        begin
          result := true;
        end;

      End;
    Except
      result := false;
    end;

  finally

  end;

end;

Function TFormfilepreview.makexmls(xmlfilename : string;
                                   JPGOutputfile : String):boolean;
Var
  Mainnode,Commandnode,Jobnode : IXMLNode;
  Separationsnode,Separationnode : IXMLNode;
  Filternode,ICCnode,LinearizationNode : IXMLNode;

  I : Longint;
begin
  try
    deletefile(xmlfilename);
    result := false;

    XMLDocument1.Active := true;
    XMLDocument1.XML.Clear;

    XMLDocument1.Encoding := 'ISO-8859-1';
    XMLDocument1.Version := '1.0';

    Mainnode := XMLDocument1.AddChild('JMF','http://tempuri.org/ImportCenter.xsd');
    Mainnode.SetAttribute('TimeStamp',formatdatetime('YYYY-MM-DD',now)+'T'+formatdatetime('HH-NN-SS',now));
    Mainnode.SetAttribute('SenderID','Plancenter.exe');
    //Mainnode.SetAttribute('xmlns','http://www.CIP4.org/JDFSchema_1_1');

    Commandnode := Mainnode.AddChild('Command');
    Commandnode.SetAttribute('Type','ProofRequest');
    Commandnode.SetAttribute('id','Plancenterpreview');
    Commandnode.SetAttribute('Status','Waiting');
    Jobnode := Commandnode.AddChild('Job');
    Jobnode.SetAttribute('Units','mm');
    Jobnode.SetAttribute('OutputName',JPGOutputfile);

    Jobnode.SetAttribute('MakeThumbnail','0');
    Jobnode.SetAttribute('ThumbnailOutputName','c:\th.jpg');

    Jobnode.SetAttribute('Resolution','72.00000');

    Jobnode.SetAttribute('ThumbnailResolution','16');
    Jobnode.SetAttribute('OutputType','SOFT');
    Jobnode.SetAttribute('Format','JPEG');
    Jobnode.SetAttribute('WriteEachSeparation','0');
    Jobnode.SetAttribute('UseTrimBox','0');
    Jobnode.SetAttribute('TrimSizeX','100.00000');
    Jobnode.SetAttribute('TrimSizeY','100.00000');
    Jobnode.SetAttribute('TrimPositionX','10.00000');
    Jobnode.SetAttribute('TrimPositionY','10.00000');
    Jobnode.SetAttribute('UseMarkTrimBox','0');
    Jobnode.SetAttribute('MarkBleed','0.00000');
    Jobnode.SetAttribute('MarkTrimSizeX','0.00000');
    Jobnode.SetAttribute('MarkTrimSizeY','0.00000');
    Jobnode.SetAttribute('MarkTrimPositionX','0.00000');
    Jobnode.SetAttribute('MarkTrimPositionY','0.00000');
    Jobnode.SetAttribute('LookForMarks','0');
    Jobnode.SetAttribute('MarkZonePosX','0.00000');
    Jobnode.SetAttribute('MarkZonePosY','0.00000');
    Jobnode.SetAttribute('MarkZoneSizeX','0.00000');
    Jobnode.SetAttribute('MarkZoneSizeY','0.00000');
    Jobnode.SetAttribute('Invert','0');
    Jobnode.SetAttribute('Mirror','0');
    Jobnode.SetAttribute('Rotate','0');
    Jobnode.SetAttribute('GrayScale','0');
    Jobnode.SetAttribute('MaxInkLevel','0');
    Jobnode.SetAttribute('ResamplingMode','2');
    Jobnode.SetAttribute('ResamplingSpecialBlack','0');
    Jobnode.SetAttribute('ResamplingModeBlack','2');
    Jobnode.SetAttribute('JPEGQuality','104');
    Jobnode.SetAttribute('Copies','1');
    Jobnode.SetAttribute('PostProcessingCommand','');
    Jobnode.SetAttribute('ColorConfig','0');
    Jobnode.SetAttribute('PixelFormat','0');
    Jobnode.SetAttribute('Compression','0');
    Jobnode.SetAttribute('Dithering','0');
    Jobnode.SetAttribute('Planar','0');
    Jobnode.SetAttribute('MakePreview','0');
    Jobnode.SetAttribute('PreviewType','4');


    Jobnode.SetAttribute('PreviewResolution', '72');
    Separationsnode := Jobnode.AddChild('Separations');

    For I := 1 to Nfiles do
    begin
      Separationnode := Separationsnode.AddChild('Separation');
      Separationnode.SetAttribute('SeparationFileName',files[i].name);
      Separationnode.SetAttribute('SeparationColorName',files[i].color);
      Separationnode.SetAttribute('ProcessCyan','0');
      Separationnode.SetAttribute('ProcessMagenta','0');
      Separationnode.SetAttribute('ProcessYellow','0');
      Separationnode.SetAttribute('ProcessBlack','0');

      IF files[i].color = 'C' then
        Separationnode.SetAttribute('ProcessCyan','100');
      IF files[i].color = 'M' then
        Separationnode.SetAttribute('ProcessMagenta','100');
      IF files[i].color = 'Y' then
        Separationnode.SetAttribute('ProcessYellow','100');
      IF files[i].color = 'K' then
        Separationnode.SetAttribute('ProcessBlack','100');
    end;
    ICCnode := Jobnode.AddChild('ICC');
    ICCnode.SetAttribute('UseICC','0');
    ICCnode.SetAttribute('InputProfile','');
    ICCnode.SetAttribute('MonitorProfile','');
    ICCnode.SetAttribute('PrinterProfile','');
    ICCnode.SetAttribute('RenderingIntent','Perceptual');
    ICCnode.SetAttribute('EnableProofProfiling','1');
    ICCnode.SetAttribute('ProofProfile','');
    ICCnode.SetAttribute('ProofRenderingIntent','Absolute Colorimetric');
    ICCnode.SetAttribute('OutOfGamutAlarm','0');

    LinearizationNode := Jobnode.AddChild('Linearization');
    LinearizationNode.SetAttribute('UseLinearization','0');

    Filternode := Jobnode.AddChild('Filter');
    Filternode.SetAttribute('UseFilter','1');
    Filternode.SetAttribute('FilterBlackOnly','1');
    Filternode.SetAttribute('FilterCoeff','-0.003500,-0.015900,-0.026200,-0.015900,-0.003500,-0.015900,-0.071200,-0.117300,-0.071200,-0.015900,-0.026200,-0.117300,2.000000,-0.117300,-0.026200,-0.015900,-0.071200,-0.117300,-0.071200,-0.015900,-0.003500,-0.015900,-0.026200,-0.015900,-0.003500');

    XMLDocument1.SaveToFile(xmlfilename);
    result := true;
  finally
    XMLDocument1.Active := false;
  End;
end;


procedure TFormfilepreview.FormActivate(Sender: TObject);
begin
  ImageEn1.VScrollBarParams.LineStep := 100;
  Formfilepreview.ImageEn1.Fit;

end;

procedure TFormfilepreview.Action2Execute(Sender: TObject);
begin
  ImageEn1.Proc.Rotate(90,false,ierFast,clnone);

end;

procedure TFormfilepreview.Action3Execute(Sender: TObject);
begin
  ImageEn1.Proc.Rotate(180,false,ierFast,clnone);
end;

procedure TFormfilepreview.Action4Execute(Sender: TObject);
begin
  ImageEn1.Proc.Rotate(270,false,ierFast,clnone);
end;

procedure TFormfilepreview.Action7Execute(Sender: TObject);
Var
  T: string;
begin
  t := extractfilename(Files[1].name);
  t := changefileext(t,'.jpg');

  SaveDialog1.FileName := T;
  IF SaveDialog1.Execute then
  begin
    ImageEn1.IO.SaveToFile(SaveDialog1.FileName);
  end;
end;

procedure TFormfilepreview.Action5Execute(Sender: TObject);
Begin
  IF PrintDialog1.Execute then
  begin

    Printer.BeginDoc;
    Printer.Title := 'Plancenter';
    ImageEn1.IO.PrintImage(Printer.Canvas,0,0,0,0,ievpCENTER,iehpCENTER,iesFITTOPAGE,0,0,1);
    Printer.EndDoc;

  end;
End;
procedure TFormfilepreview.ImageEn1ZoomIn(Sender: TObject;
  var NewZoom: Double);
begin
  IF ImageEn1.zoom + Prefs.PreviewZoomStep > Prefs.PreviewMaxzoom then
  begin
    NewZoom := ImageEn1.zoom;
    beep;
  end;
  if NewZoom <> ImageEn1.zoom then
  begin
    newzoom := ImageEn1.zoom + Prefs.PreviewZoomStep;
  end;
end;

procedure TFormfilepreview.ImageEn1ZoomOut(Sender: TObject;
  var NewZoom: Double);
begin
  IF ImageEn1.zoom - Prefs.PreviewZoomStep < Prefs.PreviewMinzoom then
  begin
    NewZoom := ImageEn1.zoom;
    beep;
  end;
  if NewZoom <> ImageEn1.zoom then
  begin
    newzoom := ImageEn1.zoom - Prefs.PreviewZoomStep;
  end;
end;

procedure TFormfilepreview.ActionFitExecute(Sender: TObject);
begin
  ImageEn1.Fit;
  ImageEn1.refresh;
end;

procedure TFormfilepreview.Action6Execute(Sender: TObject);
begin
  ImageEn1.ZoomAt(0,0,100);
  ImageEn1.refresh;
end;

procedure TFormfilepreview.Action8Execute(Sender: TObject);
begin
  ImageEnProc1.Flip(fdHorizontal);
end;

procedure TFormfilepreview.FormCreate(Sender: TObject);
begin
  JustLoadTif := false;
end;

procedure TFormfilepreview.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  JustLoadTif := false;
end;

end.
