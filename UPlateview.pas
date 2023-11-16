unit UPlateview;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, XPStyleActnCtrls, ActnMan, ToolWin, ActnCtrls, ieview,
  ImageEnView, ComCtrls, ImgList, ImageEnProc, ImageEnIO, StdCtrls,
  Buttons, ExtCtrls;

type
  TFormplatepreview = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    ImageEnViewRGB: TImageEnView;
    ActionManager1: TActionManager;
    ActionCloseplateview: TAction;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    ImageEnIORGB: TImageEnIO;
    ImageEnProcRGB: TImageEnProc;
    ImageListplateviewcolors: TImageList;
    Button1: TButton;
    Button2: TButton;
    ImageEnView1: TImageEnView;
    ImageEnView2: TImageEnView;
    ImageEnView3: TImageEnView;
    ImageEnView4: TImageEnView;
    ImageEnView5: TImageEnView;
    ImageEnView6: TImageEnView;
    ImageEnView7: TImageEnView;
    ImageEnIO1: TImageEnIO;
    ImageEnIO2: TImageEnIO;
    ImageEnIO3: TImageEnIO;
    ImageEnIO4: TImageEnIO;
    ImageEnIO5: TImageEnIO;
    ImageEnIO6: TImageEnIO;
    ImageEnIO7: TImageEnIO;
    ImageEnProc1: TImageEnProc;
    ImageEnProc2: TImageEnProc;
    ImageEnProc3: TImageEnProc;
    ImageEnProc4: TImageEnProc;
    ImageEnProc5: TImageEnProc;
    ImageEnProc6: TImageEnProc;
    ImageEnProc7: TImageEnProc;
    Panel2: TPanel;
    Image1: TImage;
    Image2: TImage;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ImageEnViewRGBViewChange(Sender: TObject; Change: Integer);
    procedure ImageEnViewRGBZoomIn(Sender: TObject; var NewZoom: Double);
    procedure ImageEnViewRGBZoomOut(Sender: TObject; var NewZoom: Double);
    procedure PageControl1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    procedure movethemall(number : Integer);
    Procedure zoomall(number : Integer);
    { Private declarations }
  public
    { Public declarations }
    Nplates : Integer;
    RGBname : string;
    Plates : array[1..8] of record
                              filename  : String;
                              Colorname : string;
                              Colorlook : Tcolor;
                            end;
  end;

var
  Formplatepreview: TFormplatepreview;

implementation
Uses
  umain;
{$R *.dfm}
Var
  x,y : Longint;
  aktzoom : Double;
procedure TFormplatepreview.FormActivate(Sender: TObject);
Var
  I : Integer;
  B : tbitmap;
  d : trect;
begin
  b := tbitmap.Create;
  b.Width := 40;
  b.Height := 28;
  d.Top := 0;
  d.Left := 0;
  d.Right := 39;
  d.Bottom := 27;
  ImageListplateviewcolors.Clear;
  ImageListplateviewcolors.AddMasked(image1.Picture.Bitmap,clnone);
  For i := 1 to Nplates do
  begin
    b.Canvas.Brush.Color := plates[i].Colorlook;
    b.Canvas.pen.color := plates[i].Colorlook;
    b.Canvas.rectangle(0,0,40,28);
    b.Canvas.CopyMode := cmSrcAnd	;
    b.Canvas.CopyRect(d,Image2.Canvas,d);
    ImageListplateviewcolors.AddMasked(b,clnone);
  end;
  For i := 1 to 7 do
  begin
    PageControl1.Pages[i].ImageIndex := i;
  End;


  ImageEnViewRGB.Clear;
  ImageEnView1.visible := false;
  ImageEnView2.visible := false;
  ImageEnView3.visible := false;
  ImageEnView4.visible := false;
  ImageEnView5.visible := false;
  ImageEnView6.visible := false;
  ImageEnView7.visible := false;

  ImageEnView1.clear;
  ImageEnView2.clear;
  ImageEnView3.clear;
  ImageEnView4.clear;
  ImageEnView5.clear;
  ImageEnView6.clear;
  ImageEnView7.clear;

  For i := 1 to 7 do
  begin
    PageControl1.Pages[i].TabVisible := false;
  end;

  PageControl1.ActivePageIndex := 0;
  IF fileexists(RGBname) then
  begin
    ImageEnIORGB.LoadFromFileJpeg(RGBname);
    ImageEnViewRGB.Fit;
    ImageEnViewRGB.refresh;
    aktzoom := ImageEnViewRGB.zoom;
  end;


  For i := 1 to Nplates do
  begin
    Case i of
      1 : begin
            IF fileexists(plates[i].filename) then
            begin
              ImageEnIO1.LoadFromFileJpeg(plates[i].filename);
              ImageEnView1.visible := true;
              ImageEnView1.Fit;
            end;
          end;
      2 : begin
            IF fileexists(plates[i].filename) then
            begin
              ImageEnIO2.LoadFromFileJpeg(plates[i].filename);
              ImageEnView2.visible := true;
              ImageEnView2.Fit;
            end;
          end;
      3 : begin
            IF fileexists(plates[i].filename) then
            begin
              ImageEnIO3.LoadFromFileJpeg(plates[i].filename);
              ImageEnView3.visible := true;
              ImageEnView3.Fit;
            end;
          end;
      4 : begin
            IF fileexists(plates[i].filename) then
            begin
              ImageEnIO4.LoadFromFileJpeg(plates[i].filename);
              ImageEnView4.visible := true;
              ImageEnView4.Fit;
            end;
          end;
      5 : begin
            IF fileexists(plates[i].filename) then
            begin
              ImageEnIO5.LoadFromFileJpeg(plates[i].filename);
              ImageEnView5.visible := true;
              ImageEnView5.Fit;
            end;
          end;
      6 : begin
            IF fileexists(plates[i].filename) then
            begin
              ImageEnIO6.LoadFromFileJpeg(plates[i].filename);
              ImageEnView6.visible := true;
              ImageEnView6.Fit;
            end;
          end;
      7 : begin
            IF fileexists(plates[i].filename) then
            begin
              ImageEnIO7.LoadFromFileJpeg(plates[i].filename);
              ImageEnView7.visible := true;
              ImageEnView7.Fit;
            end;
          end;

    End;
  end;

  For i := 1 to Nplates do
  begin
    PageControl1.Pages[i].Caption := plates[i].Colorname;
    PageControl1.Pages[i].TabVisible := true;
  End;

  For i := 7 downto Nplates+1 do
  begin
    PageControl1.Pages[i].TabVisible := false;
  end;

end;

procedure TFormplatepreview.Button1Click(Sender: TObject);
begin
  ImageEnViewRGB.ZoomAt(0,0,100);
  IF ImageEnView1.Visible then ImageEnView1.ZoomAt(0,0,100);
  IF ImageEnView2.Visible then ImageEnView2.ZoomAt(0,0,100);
  IF ImageEnView3.Visible then ImageEnView3.ZoomAt(0,0,100);
  IF ImageEnView4.Visible then ImageEnView4.ZoomAt(0,0,100);
  IF ImageEnView5.Visible then ImageEnView5.ZoomAt(0,0,100);
  IF ImageEnView6.Visible then ImageEnView6.ZoomAt(0,0,100);
  IF ImageEnView7.Visible then ImageEnView7.ZoomAt(0,0,100);
end;

procedure TFormplatepreview.ImageEnViewRGBViewChange(Sender: TObject;
  Change: Integer);
begin
  case Change of
     0 : Begin
           x := TImageEnView(Sender).ViewX;
           y := TImageEnView(Sender).ViewY;
         end;
  end;
end;

procedure TFormplatepreview.ImageEnViewRGBZoomIn(Sender: TObject;
  var NewZoom: Double);
begin
  IF (aktzoom > 90) And (aktzoom < 100) then aktzoom := 100
  Else
    aktzoom := aktzoom + 10;
  Newzoom := aktzoom;

end;

procedure TFormplatepreview.ImageEnViewRGBZoomOut(Sender: TObject;
  var NewZoom: Double);
begin
  IF (aktzoom > 100) And (aktzoom < 110) then aktzoom := 100
  Else
    aktzoom := aktzoom - 10;
  Newzoom := aktzoom;

end;

procedure TFormplatepreview.movethemall(number : Integer);
Begin

  IF (ImageEnView1.Visible) and (number <> 1) then
  Begin
    ImageEnView1.SetViewXY(x,y);
  End;
  IF (ImageEnView2.Visible) and (number <> 2) then
  Begin
    ImageEnView2.SetViewXY(x,y);
  End;
  IF (ImageEnView3.Visible) and (number <> 3) then
  Begin
    ImageEnView3.SetViewXY(x,y);
  End;
  IF (ImageEnView4.Visible) and (number <> 4) then
  Begin
    ImageEnView4.SetViewXY(x,y);
  End;
  IF (ImageEnView5.Visible) and (number <> 5) then
  Begin
    ImageEnView5.SetViewXY(x,y);
  End;
  IF (ImageEnView6.Visible) and (number <> 6) then
  Begin
    ImageEnView6.SetViewXY(x,y);
  End;
  IF (ImageEnView7.Visible) and (number <> 7) then
  Begin
    ImageEnView7.SetViewXY(x,y);
  End;
  IF number <> 0 then
  Begin
    ImageEnViewRGB.SetViewXY(x,y);
  End;



End;

Procedure TFormplatepreview.zoomall(number : Integer);
Begin
  IF (ImageEnView1.Visible) and (number <> 1) then
  Begin
    ImageEnView1.Zoom := aktzoom;
  End;

  IF (ImageEnView1.Visible) and (number <> 1) then
  Begin
    ImageEnView1.Zoom := aktzoom;
  End;
  IF (ImageEnView2.Visible) and (number <> 2) then
  Begin
    ImageEnView2.Zoom := aktzoom;
  End;
  IF (ImageEnView3.Visible) and (number <> 3) then
  Begin
    ImageEnView3.Zoom := aktzoom;
  End;
  IF (ImageEnView4.Visible) and (number <> 4) then
  Begin
    ImageEnView4.Zoom := aktzoom;
  End;
  IF (ImageEnView5.Visible) and (number <> 5) then
  Begin
    ImageEnView5.Zoom := aktzoom;
  End;
  IF (ImageEnView6.Visible) and (number <> 6) then
  Begin
    ImageEnView6.Zoom := aktzoom;
  End;
  IF (ImageEnView7.Visible) and (number <> 7) then
  Begin
    ImageEnView7.Zoom := aktzoom;
  End;
  IF number <> 0 then
  Begin
    ImageEnViewRGB.Zoom := aktzoom;
  End;

End;



procedure TFormplatepreview.PageControl1Change(Sender: TObject);
begin
  IF (ImageEnView1.Visible) and (PageControl1.ActivePageIndex = 1) then
  Begin
    ImageEnView1.Zoom := aktzoom;
  End;

  IF (ImageEnView1.Visible) and (PageControl1.ActivePageIndex = 1) then
  Begin
    ImageEnView1.Zoom := aktzoom;
  End;
  IF (ImageEnView2.Visible) and (PageControl1.ActivePageIndex = 2) then
  Begin
    ImageEnView2.Zoom := aktzoom;
  End;
  IF (ImageEnView3.Visible) and (PageControl1.ActivePageIndex = 3) then
  Begin
    ImageEnView3.Zoom := aktzoom;
  End;
  IF (ImageEnView4.Visible) and (PageControl1.ActivePageIndex = 4) then
  Begin
    ImageEnView4.Zoom := aktzoom;
  End;
  IF (ImageEnView5.Visible) and (PageControl1.ActivePageIndex = 5) then
  Begin
    ImageEnView5.Zoom := aktzoom;
  End;
  IF (ImageEnView6.Visible) and (PageControl1.ActivePageIndex = 6) then
  Begin
    ImageEnView6.Zoom := aktzoom;
  End;
  IF (ImageEnView7.Visible) and (PageControl1.ActivePageIndex = 7) then
  Begin
    ImageEnView7.Zoom := aktzoom;
  End;
  IF PageControl1.ActivePageIndex = 0 then
  Begin
    ImageEnViewRGB.Zoom := aktzoom;
  End;


  IF (ImageEnView1.Visible) and (PageControl1.ActivePageIndex = 1) then
  Begin
    ImageEnView1.SetViewXY(x,y);
  End;
  IF (ImageEnView2.Visible) and (PageControl1.ActivePageIndex = 2) then
  Begin
    ImageEnView2.SetViewXY(x,y);
  End;
  IF (ImageEnView3.Visible) and (PageControl1.ActivePageIndex = 3) then
  Begin
    ImageEnView3.SetViewXY(x,y);
  End;
  IF (ImageEnView4.Visible) and (PageControl1.ActivePageIndex = 4) then
  Begin
    ImageEnView4.SetViewXY(x,y);
  End;
  IF (ImageEnView5.Visible) and (PageControl1.ActivePageIndex = 5) then
  Begin
    ImageEnView5.SetViewXY(x,y);
  End;
  IF (ImageEnView6.Visible) and (PageControl1.ActivePageIndex = 6) then
  Begin
    ImageEnView6.SetViewXY(x,y);
  End;
  IF (ImageEnView7.Visible) and (PageControl1.ActivePageIndex = 7) then
  Begin
    ImageEnView7.SetViewXY(x,y);
  End;
  IF PageControl1.ActivePageIndex = 0 then
  Begin
    ImageEnViewRGB.SetViewXY(x,y);
  End;


end;

procedure TFormplatepreview.Button2Click(Sender: TObject);
begin
  ImageEnViewRGB.fit;
  IF ImageEnView1.Visible then ImageEnView1.fit;
  IF ImageEnView2.Visible then ImageEnView2.fit;
  IF ImageEnView3.Visible then ImageEnView3.fit;
  IF ImageEnView4.Visible then ImageEnView4.fit;
  IF ImageEnView5.Visible then ImageEnView5.fit;
  IF ImageEnView6.Visible then ImageEnView6.fit;
  IF ImageEnView7.Visible then ImageEnView7.fit;
  aktzoom := ImageEnViewRGB.zoom;
  x := 0;
  y := 0;
end;

end.
