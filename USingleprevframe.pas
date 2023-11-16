unit USingleprevframe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ieview, ImageEnView, ImageEnProc, ImageEnIO, StdCtrls;

type
  TFramesingleprev = class(TFrame)
    ImageEnIO1: TImageEnIO;
    ImageEnProc1: TImageEnProc;
    GroupBox1: TGroupBox;
    ImageEnView1: TImageEnView;
    procedure ImageEnView1ZoomIn(Sender: TObject; var NewZoom: Double);
    procedure ImageEnView1ZoomOut(Sender: TObject; var NewZoom: Double);
    procedure ImageEnView1ViewChange(Sender: TObject; Change: Integer);
  private
    { Private declarations }
  public
    Number : Integer;
    remotesizing : boolean;
    remotemoving : boolean;
    { Public declarations }
  end;

implementation
Uses
  Uprev;

{$R *.dfm}

procedure TFramesingleprev.ImageEnView1ZoomIn(Sender: TObject;
  var NewZoom: Double);
begin
  if not remotesizing then
  Begin
    NewZoom :=  Formpreview.Singleprevzoom + 10;
    Formpreview.Singleprevzoom := newzoom;
    Formpreview.SetallSingleframes(Number);
  end
  Else
  begin
    NewZoom :=  Formpreview.Singleprevzoom
  end;

end;

procedure TFramesingleprev.ImageEnView1ZoomOut(Sender: TObject;
  var NewZoom: Double);
begin
  if not remotesizing then
  Begin
    NewZoom :=  Formpreview.Singleprevzoom - 10;
    Formpreview.Singleprevzoom := newzoom;
    Formpreview.SetallSingleframes(Number);
  end
  Else
    NewZoom :=  Formpreview.Singleprevzoom
end;

procedure TFramesingleprev.ImageEnView1ViewChange(Sender: TObject;
  Change: Integer);
begin
  case Change of
     0 : Begin
           IF not remotemoving then
           begin
             Formpreview.SingleX := ImageEnView1.viewx;
             Formpreview.SingleY := ImageEnView1.viewy;
             Formpreview.MoveallSingleframes(number);
           End;
         end;
     1 : begin

         end;

  end;
end;

end.
