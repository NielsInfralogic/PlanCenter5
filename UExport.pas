unit UExport;

interface

uses
  SysUtils, Classes, xmldom, XMLIntf, msxmldom, XMLDoc;

type
  TDataModuleExport = class(TDataModule)
    Documentformat: TXMLDocument;
    Plateformat: TXMLDocument;
    pageFormat: TXMLDocument;
    ExportDoc: TXMLDocument;
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure ExportProduction(productionid    : Longint;
                               formatfile      : string;
                               Pageformatfile  : string;
                               Plateformatfile : string);

  end;

var
  DataModuleExport: TDataModuleExport;

implementation

{$R *.dfm}
Procedure TDataModuleExport.ExportProduction(productionid    : Longint;
                                             formatfile      : string;
                                             Pageformatfile  : string;
                                             Plateformatfile : string);
Begin
  Documentformat.LoadFromFile(formatfile);

  IF Pageformatfile <> '' then
    pageFormat.LoadFromFile(Pageformatfile);

  IF Plateformatfile <> '' then
    Plateformat.LoadFromFile(Plateformatfile);




end;

end.
