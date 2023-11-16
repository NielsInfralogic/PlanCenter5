unit UAttachtomail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons;

type
  TFormattachtomail = class(TForm)
    Panel2: TPanel;
    Image1: TImage;
    Label6: TLabel;
    Label7: TLabel;
    ListView1: TListView;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
    Productionid : Longint;
    Editionid    : Longint;
    Sectionid    : Longint;
    Attachtype   : Longint;  //1 tif 2 preview 3 thumbnail 4 pdf 5 pdflog
  end;

var
  Formattachtomail: TFormattachtomail;

implementation

{$R *.dfm}

end.
