unit Usingprev;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ieview, ImageEnView, hyieutils, iexBitmaps, hyiedefs, iesettings,
  System.Contnrs, iexLayers, iexRulers, iexToolbars, iexUserInteractions,
  imageenio, imageenproc, iexProcEffects;

type
  TFrame2 = class(TFrame)
    ImageEnView2: TImageEnView;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
