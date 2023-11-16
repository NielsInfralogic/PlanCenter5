unit UTiffpreview;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ieview, imageenview, ComCtrls, XPStyleActnCtrls,
  ActnMan, ToolWin, ActnCtrls, imageenproc, ActnMenus, ImgList,
  ActnColorMaps, StdCtrls, ExtCtrls, hyieutils, iexBitmaps, hyiedefs,
  iesettings, System.ImageList, System.Actions, System.Contnrs, iexLayers,
  iexRulers, iexToolbars, iexUserInteractions, imageenio, iexProcEffects;

type
  TFormtiffpreview = class(TForm)
    ActionManager1: TActionManager;
    StatusBar1: TStatusBar;
    ImageEnView1: TImageEnView;
    Actionclose: TAction;
    Actionsaveas: TAction;
    Actionfit: TAction;
    Action1to1: TAction;
    Action90: TAction;
    Action180: TAction;
    Action270: TAction;
    SaveDialog1: TSaveDialog;
    ImageEnProc1: TImageEnProc;
    ActionMirror: TAction;
    ActionSelect: TAction;
    Actioninvert: TAction;
    Action5: TAction;
    ImageList1: TImageList;
    Panel1: TPanel;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Labelposy: TLabel;
    Labelposx: TLabel;
    Label5: TLabel;
    Labelselh: TLabel;
    Labelselw: TLabel;
    Labelsely: TLabel;
    Labelselx: TLabel;
    Label10: TLabel;
    GroupBox3: TGroupBox;
    Label11: TLabel;
    Labelfilesize: TLabel;
    Labeldpi: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    ActionToolBar1: TActionToolBar;
    Actionrotate: TAction;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    Button1: TButton;
    Edit2: TEdit;
    ComboBox1: TComboBox;
    Navigator: TGroupBox;
    ImageEnViewnavbuf: TImageEnView;
    ImageEnViewnav: TImageEnView;
    Button2: TButton;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Actionsave: TAction;
    GroupBoxcolorlist: TGroupBox;
    ListBoxColors: TListBox;
    ListBoxColorfilenames: TListBox;
    procedure ActionsaveasExecute(Sender: TObject);
    procedure ActionfitExecute(Sender: TObject);
    procedure Action1to1Execute(Sender: TObject);
    procedure Action90Execute(Sender: TObject);
    procedure Action180Execute(Sender: TObject);
    procedure Action270Execute(Sender: TObject);
    procedure ActionMirrorExecute(Sender: TObject);
    procedure ImageEnView1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure ActioninvertExecute(Sender: TObject);
    procedure Action5Execute(Sender: TObject);
    procedure ActionrotateExecute(Sender: TObject);
    procedure ActionSelectExecute(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ImageEnView1ViewChange(Sender: TObject; Change: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ImageEnViewnavSelectionChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ActionsaveExecute(Sender: TObject);
    procedure ListBoxColorsClick(Sender: TObject);
  private
    activated : Boolean;
    aktMMposX,aktMMposY : Double;
    aktselx1 : Double;
    aktsely1 : Double;
    aktselx2 : Double;
    aktsely2 : Double;
    aktselw : Double;
    aktselh : Double;
    r,Rw,Rh,pw,ph : Double;
    procedure Setnav;
    Function getmousemmpos(x,y : Longint;
                           Var xm : Double;
                           Var ym : Double;
                           Var selx1 : Double;
                           Var sely1 : Double;
                           Var selx2 : Double;
                           Var sely2 : Double;
                           Var selw : Double;
                           Var selh : Double):boolean;

  public
    aktProofPDI : Double;
    Tiff_filename : String;
//    procedure Setbluebar;
    Function Doafile(filename : string;
                     Newfilename : String;
                     xoffset : Double;
                     yoffset : Double;
                     newwidth : Double;
                     NewHeight : Double;
                     KeepWidth : Boolean;
                     KeepHeight : Boolean;
                     Offsetpoint : Longint):Boolean;

    { Public declarations }
  end;

var
  Formtiffpreview: TFormtiffpreview;

implementation
Uses
  umain, UCroptiff,{hyieutils,hyiedefs,}utypes;

{$R *.dfm}

procedure TFormtiffpreview.ActionsaveasExecute(Sender: TObject);
begin
  SaveDialog1.FileName := extractfilename(Tiff_filename);
  SaveDialog1.InitialDir := 'c:\';
  IF SaveDialog1.Execute then
  begin
    IF Tiff_filename = SaveDialog1.FileName then
    begin
       if MessageDlg('This will owerwrite the file use for making the plate.  Continiue?',mtWarning, [mbYes, mbNo], 0) = mrYes then
      begin
        ImageEnview1.IO.SaveToFileTIFF(SaveDialog1.FileName);
      end;
    End
    else
      ImageEnview1.IO.SaveToFileTIFF(SaveDialog1.FileName);
  end;

end;

procedure TFormtiffpreview.ActionfitExecute(Sender: TObject);
begin
  ImageEnview1.Fit;
  ImageEnview1.refresh;
end;

procedure TFormtiffpreview.Action1to1Execute(Sender: TObject);
begin
  ImageEnview1.ZoomAt(0,0,100);
  ImageEnview1.refresh;
end;

procedure TFormtiffpreview.Action90Execute(Sender: TObject);
begin
  ImageEnview1.Proc.Rotate(270,false,ierFast,clnone);
end;

procedure TFormtiffpreview.Action180Execute(Sender: TObject);
begin
  ImageEnview1.Proc.Rotate(180,false,ierFast,clnone);
end;

procedure TFormtiffpreview.Action270Execute(Sender: TObject);
begin
  ImageEnview1.Proc.Rotate(90,false,ierFast,clnone);
end;

procedure TFormtiffpreview.ActionMirrorExecute(Sender: TObject);
begin
  ImageEnProc1.Flip(fdHorizontal);
end;

procedure TFormtiffpreview.ImageEnView1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  IF aktProofPDI > 0 then
  begin

    getmousemmpos(x,y,aktMMposX,aktMMposY,aktselx1,aktsely1,aktselx2,aktsely2,aktselw,aktselh);

    Labelposx.caption := ' X : ' +FormatFloat('0.00',aktMMposX);
    Labelposy.caption := ' Y : ' +FormatFloat('0.00',aktMMposY);



    IF ImageEnView1.Selected then
    Begin
      Labelselx.caption := ' X : ' +FormatFloat('0.00',aktselx1);
      Labelsely.caption := ' Y : ' +FormatFloat('0.00',aktsely1);
      Labelselw.caption := ' Width  : ' +FormatFloat('0.00',aktselw);
      Labelselh.caption := ' Height : ' +FormatFloat('0.00',aktselh);
    End
    else
    Begin
      Labelselx.caption := ' X : ';
      Labelsely.caption := ' Y : ';
      Labelselw.caption := ' Width  : ';
      Labelselh.caption := ' Height : ';
    End;
  End;
  edit5.Text := inttostr(x);
end;

procedure TFormtiffpreview.FormActivate(Sender: TObject);
Var
  mx,my : Longint;
begin
  screen.cursor := crhourglass;
  try
    IF not activated then
    begin
      activated := true;
      //Setbluebar;
    end;
    ActionToolBar1.Repaint;
    ImageEnView1.cursor := crhourglass;
    ImageEnView1.visible := false;
    ImageEnViewnav.visible := false;
    ActionSelect.checked := false;
    ImageEnView1.MouseInteract := [miZoom,miScroll];

    ImageEnViewnavbuf.io.LoadFromFileTIFF(Tiff_filename);
    ImageEnViewnavbuf.fit;

    Labelselx.caption := ' X : ';
    Labelselx.caption := ' Y : ';
    Labelselw.caption := ' Width  : ';
    Labelselh.caption := ' Height : ';


    aktProofPDI := ImageEnview1.IO.Params.Dpi;

    ImageEnview1.GradientEndColor := ThemebrgLight;//clSkyBlue;
    StatusBar1.panels[0].Text := ImageEnview1.IO.Params.FileTypeStr;
    StatusBar1.panels[1].Text := Tiff_filename;
    Labeldpi.caption := ' dpi. ' + floattostr(aktProofPDI);
    Labelfilesize.caption := ' File size : ' +  FormatFloat('0.00',(ImageEnView1.Bitmap.Width/aktProofPDI) * 25.4) + ' * '+
                                              FormatFloat('0.00',(ImageEnView1.Bitmap.height/aktProofPDI) * 25.4);


    ImageEnview1.Fit;
    ImageEnView1.visible := true;
    ImageEnViewnav.visible := true;
    ImageEnView1.cursor := 1785;
    ImageEnView1.GetMaxViewXY(mx,my);
    RW := (ImageEnView1.ExtentX + mx) / ImageEnViewnavbuf.ExtentX;
    RH := (ImageEnView1.ExtentY + my) / ImageEnViewnavbuf.ExtentY;

//    ImageEnview1.refresh;
    Setnav;
  Except
  end;
  screen.cursor := crdefault;
end;

Function TFormtiffpreview.getmousemmpos(x,y : Longint;
                                        Var xm : Double;
                                        Var ym : Double;
                                        Var selx1 : Double;
                                        Var sely1 : Double;
                                        Var selx2 : Double;
                                        Var sely2 : Double;
                                        Var selw : Double;
                                        Var selh : Double):boolean;
Var
  zfact : Double;
begin
  x := x + ImageEnView1.viewx;
  y := y + ImageEnView1.viewy;

  zfact := (100 / ImageEnView1.Zoom);
  IF (x-ImageEnView1.OffsetX > ImageEnView1.ExtentX+ ImageEnView1.viewx) then
  begin
    x := ImageEnView1.ExtentX+ImageEnView1.OffsetX+ ImageEnView1.viewx;
  end;
  IF (y-ImageEnView1.Offsety > ImageEnView1.Extenty+ ImageEnView1.viewy) then
  begin
    y := ImageEnView1.Extenty+ImageEnView1.Offsety+ ImageEnView1.viewy;
  end;
  IF aktProofPDI < 1 then
    aktProofPDI := 1024;

  xm := ((x-ImageEnView1.OffsetX)/aktProofPDI) * 25.4;
  ym := ((y-ImageEnView1.OffsetY)/aktProofPDI) * 25.4;
  IF Ym < 0 then
    Ym := 0;
  IF xm < 0 then
    xm := 0;
  xm := xm * zfact;
  ym := ym * zfact;

  IF ImageEnView1.selected then
  begin
    selx1 := ( (ImageEnView1.SelX1/aktProofPDI) * 25.4);
    sely1 := ( (ImageEnView1.SelY1/aktProofPDI) * 25.4);
    selx2 := ( (ImageEnView1.SelX2/aktProofPDI) * 25.4);
    sely2 := ( (ImageEnView1.SelY2/aktProofPDI) * 25.4);
    selw := ( ((ImageEnView1.SelX2 - ImageEnView1.SelX1) /aktProofPDI) * 25.4);
    selh := ( ((ImageEnView1.Sely2 - ImageEnView1.Sely1) /aktProofPDI) * 25.4);
  End;
  result := true;
end;


procedure TFormtiffpreview.ActioninvertExecute(Sender: TObject);
begin
  ImageEnProc1.Negative;
end;

procedure TFormtiffpreview.Action5Execute(Sender: TObject);
Var
  x,y,w,h,cw,ch,Tw,Th : Longint;
  fx,fy,fw,fh,D : double;
begin
  (*
  ActionSelect.checked := false;
  ImageEnView1.MouseInteract := [miZoom,miScroll];
  *)
  Formcroptif.CheckBoxchpath.visible := false;
  IF Formcroptif.Editw.Text = '' then
    Formcroptif.Editw.Text := FormatFloat('0.00',(ImageEnView1.Bitmap.Width/aktProofPDI) * 25.4);
  IF Formcroptif.Edith.Text = '' then
    Formcroptif.EditH.Text := FormatFloat('0.00',(ImageEnView1.Bitmap.height/aktProofPDI) * 25.4);

  IF ImageEnView1.Selected then
  begin
    Formcroptif.Editx.Text := FormatFloat('0.00',aktselx1);
    Formcroptif.Edity.Text := FormatFloat('0.00',aktsely1);
    Formcroptif.Editw.Text := FormatFloat('0.00',aktselw);
    Formcroptif.Edith.Text := FormatFloat('0.00',aktselh);

  end;

  if Formcroptif.showmodal = mrok then
  begin
    ImageEnView1.DeSelect;
    Labelselx.caption := ' X : ';
    Labelsely.caption := ' Y : ';
    Labelselw.caption := ' Width  : ';
    Labelselh.caption := ' Height : ';


    fx := strtofloat(Formcroptif.Editx.Text);
    fy := strtofloat(Formcroptif.Edity.Text);
    fw := strtofloat(Formcroptif.Editw.Text);
    fh := strtofloat(Formcroptif.Edith.Text);

    Tw := ImageEnView1.Bitmap.Width;
    Th := ImageEnView1.Bitmap.height;

    w := round((fw / 25.4) * aktProofPDI);
    h := round((fh / 25.4) * aktProofPDI);
    D := (fw / 25.4) * aktProofPDI;
    cw := (ImageEnView1.Bitmap.Width - w) Div 2;
    ch := (ImageEnView1.Bitmap.height - h) Div 2;


    IF fx > 0 then
      x := round((fx / 25.4) * aktProofPDI)
    else
      x := 0;
    IF fy > 0 then
      y := round((fy / 25.4) * aktProofPDI)
    else
      y := 0;


    Case Formcroptif.RadioGroup1.ItemIndex of
      0 : Begin //top left
          End;
      1 : Begin //center left
            y := y + ch;
          End;
      2 : Begin //bottom left
            y := y + ch+ ch;
          End;
      3 : Begin //top center
            x := x + cw;
          End;
      4 : Begin //Image centrum
            y := y + ch;
            x := x + cw;
          End;
      5 : Begin //Bottom center
            x := x + cw;
            y := y + ch+ ch;
          End;
      6 : Begin //top right
            x := x + cw+ cw;
          End;
      7 : Begin //center right
            x := x + cw+ cw;
            y := y + ch;
          End;
      8 : Begin //bottom right
            x := x + cw+ cw;
            y := y + ch+ ch;
          End;
    end;

    ImageEnProc1.Crop(x,y,(x+w)-1,(y+h)-1);

    IF Formcroptif.CheckBoxkeepW.Checked or Formcroptif.CheckBoxkeepH.Checked then
    begin
      IF Not Formcroptif.CheckBoxkeepW.Checked then
        tw := ImageEnView1.Bitmap.Width;
      IF Not Formcroptif.CheckBoxkeepH.Checked then
        tH := ImageEnView1.Bitmap.Height;

      Case Formcroptif.RadioGroup1.ItemIndex of
        0 : Begin //top left
              ImageEnProc1.ImageResize(Tw,Th, iehLeft,ievTop);
            End;
        1 : Begin //center left
              ImageEnProc1.ImageResize(Tw,Th, iehLeft,ievCenter);
            End;
        2 : Begin //bottom left
              ImageEnProc1.ImageResize(Tw,Th, iehLeft,ievBottom);
            End;
        3 : Begin //top center
              ImageEnProc1.ImageResize(Tw,Th, iehCenter,ievTop);
            End;
        4 : Begin //Image centrum
              ImageEnProc1.ImageResize(Tw,Th, iehCenter,ievCenter);
            End;
        5 : Begin //Bottom center
              ImageEnProc1.ImageResize(Tw,Th, iehCenter,ievBottom);
            End;
        6 : Begin //top right
              ImageEnProc1.ImageResize(Tw,Th, iehRight,ievTop);
            End;
        7 : Begin //center right
              ImageEnProc1.ImageResize(Tw,Th, iehRight,ievCenter);
            End;
        8 : Begin //bottom right
              ImageEnProc1.ImageResize(Tw,Th, iehRight,ievBottom);
            End;
      end;
    end;

  End;
end;

Function TFormtiffpreview.Doafile(filename : string;
                                  Newfilename : String;
                                  xoffset : Double;
                                  yoffset : Double;
                                  newwidth : Double;
                                  NewHeight : Double;
                                  KeepWidth : Boolean;
                                  KeepHeight : Boolean;
                                  Offsetpoint : Longint):Boolean;
Var
  x,y,w,h,cw,ch,Tw,Th : Longint;
  D : Double;
begin
  result := true;
  try
    ImageEnView1.IO.LoadFromFileTIFF(filename);
    aktProofPDI := ImageEnview1.IO.Params.Dpi;



    Tw := ImageEnView1.Bitmap.Width;
    Th := ImageEnView1.Bitmap.height;

    w := round((newwidth / 25.4) * aktProofPDI);
    h := round((NewHeight / 25.4) * aktProofPDI);

    cw := (ImageEnView1.Bitmap.Width - w) Div 2;
    ch := (ImageEnView1.Bitmap.height - h) Div 2;


    IF xoffset > 0 then
      x := round((xoffset / 25.4) * aktProofPDI)
    else
      x := 0;
    IF yoffset > 0 then
      y := round((yoffset / 25.4) * aktProofPDI)
    else
      y := 0;


    Case Offsetpoint of
      0 : Begin //top left
          End;
      1 : Begin //center left
            y := y + ch;
          End;
      2 : Begin //bottom left
            y := y + ch+ ch;
          End;
      3 : Begin //top center
            x := x + cw;
          End;
      4 : Begin //Image centrum
            y := y + ch;
            x := x + cw;
          End;
      5 : Begin //Bottom center
            x := x + cw;
            y := y + ch+ ch;
          End;
      6 : Begin //top right
            x := x + cw+ cw;
          End;
      7 : Begin //center right
            x := x + cw+ cw;
            y := y + ch;
          End;
      8 : Begin //bottom right
            x := x + cw+ cw;
            y := y + ch+ ch;
          End;
    end;

    ImageEnProc1.Crop(x,y,(x+w)-1,(y+h)-1);

    IF KeepWidth or KeepHeight then
    begin
      IF Not KeepWidth then
        tw := ImageEnView1.Bitmap.Width;
      IF Not KeepHeight then
        tH := ImageEnView1.Bitmap.Height;

      Case Offsetpoint of
        0 : Begin //top left
              ImageEnProc1.ImageResize(Tw,Th, iehLeft,ievTop);
            End;
        1 : Begin //center left
              ImageEnProc1.ImageResize(Tw,Th, iehLeft,ievCenter);
            End;
        2 : Begin //bottom left
              ImageEnProc1.ImageResize(Tw,Th, iehLeft,ievBottom);
            End;
        3 : Begin //top center
              ImageEnProc1.ImageResize(Tw,Th, iehCenter,ievTop);
            End;
        4 : Begin //Image centrum
              ImageEnProc1.ImageResize(Tw,Th, iehCenter,ievCenter);
            End;
        5 : Begin //Bottom center
              ImageEnProc1.ImageResize(Tw,Th, iehCenter,ievBottom);
            End;
        6 : Begin //top right
              ImageEnProc1.ImageResize(Tw,Th, iehRight,ievTop);
            End;
        7 : Begin //center right
              ImageEnProc1.ImageResize(Tw,Th, iehRight,ievCenter);
            End;
        8 : Begin //bottom right
              ImageEnProc1.ImageResize(Tw,Th, iehRight,ievBottom);
            End;
      end;
    end;
  Except
    result := false;
  end;

end;


procedure TFormtiffpreview.ActionrotateExecute(Sender: TObject);
begin
  beep;
end;

procedure TFormtiffpreview.ActionSelectExecute(Sender: TObject);
begin
  ActionSelect.checked := Not ActionSelect.checked;

  IF ActionSelect.checked then
  begin
    ImageEnView1.MouseInteract := [miZoom,miSelect];
  end
  else
  begin
    ImageEnView1.MouseInteract := [miZoom,miScroll];
  end;

end;



procedure TFormtiffpreview.ComboBox1Change(Sender: TObject);
begin
  Case ComboBox1.itemindex of
    0 : ImageEnView1.ZoomFilter := rfNone;
    1 : ImageEnView1.ZoomFilter := rfTriangle;
    2 : ImageEnView1.ZoomFilter := rfHermite;
    3 : ImageEnView1.ZoomFilter := rfBell;
    4 : ImageEnView1.ZoomFilter := rfBSpline;
    5 : ImageEnView1.ZoomFilter := rfLanczos3;
    6 : ImageEnView1.ZoomFilter := rfMitchell;
    7 : ImageEnView1.ZoomFilter := rfNearest;
    8 : ImageEnView1.ZoomFilter := rfLinear;
    9 : ImageEnView1.ZoomFilter := rfFastLinear;
    10 : ImageEnView1.ZoomFilter := rfBilinear;
    11 : ImageEnView1.ZoomFilter := rfBicubic;
    12 : ImageEnView1.ZoomFilter := rfProjectBW;
    13 : ImageEnView1.ZoomFilter := rfProjectWB;
  End;
  ImageEnView1.Repaint;
end;

procedure TFormtiffpreview.Setnav;
Var
  d,s : Trect;
  Navmx, Navmy: integer;
  mx, my: integer;
  pcx,pcy,pcx2,pcy2 : double;
  x,y,x2,y2 : Longint;

Begin
  ImageEnView1.GetMaxViewXY(mx, my);
  Navmx := ImageEnViewnavbuf.ExtentX;
  Navmy := ImageEnViewnavbuf.ExtentY;

  pcx := (ImageEnView1.viewX*100) / (ImageEnView1.Extentx + mx);
  pcy := (ImageEnView1.viewy*100) / (ImageEnView1.Extenty + my);
  pcx2 := ((ImageEnView1.viewX+ImageEnView1.ExtentX)*100) / (ImageEnView1.Extentx + mx);
  pcy2 := ((ImageEnView1.viewY+ImageEnView1.Extenty)*100) / (ImageEnView1.Extenty + my);
  ImageEnViewnavbuf.DrawTo(ImageEnViewnav.Bitmap.Canvas);
  ImageEnViewnav.Update;
  x := round((Navmx * pcx) /100);
  y := round((Navmy * pcy) /100);
  x2 := round((Navmx * pcx2) /100);
  y2 := round((Navmy * pcy2) /100);
  ImageEnViewnav.Bitmap.Canvas.Pen.Color := clred;
  ImageEnViewnav.Bitmap.Canvas.Brush.Style :=  bsClear;
  ImageEnViewnav.Bitmap.Canvas.Rectangle(x,y,x2,y2);
  ImageEnViewnav.Update;



end;


procedure TFormtiffpreview.ImageEnView1ViewChange(Sender: TObject;
  Change: Integer);
begin
  Setnav;
end;

procedure TFormtiffpreview.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ListBoxColors.Visible := false;
  Formtiffpreview.position := poDefault;
end;

procedure TFormtiffpreview.FormCreate(Sender: TObject);
begin
  activated := false;
end;

procedure TFormtiffpreview.ImageEnViewnavSelectionChange(Sender: TObject);
Var


  SelX1,SelX2,Sely1,Sely2,mx,my,Tmx,Tmy : Longint;
  SelX1p,SelX2p,Sely1p,Sely2p,zx,zy,az : Double;

Begin
  ImageEnView1.GetMaxViewXY(mx,my);
  pw := (ImageEnViewnavbuf.ExtentX * 100) / (mx+ImageEnView1.ExtentX);
  ph := (ImageEnViewnavbuf.Extenty * 100) / (my+ImageEnView1.ExtentY);

  SelX1p := (ImageEnViewnav.SelX1 * 100) / ImageEnViewnavbuf.ExtentX;
  SelX2p := (ImageEnViewnav.SelX2 * 100) / ImageEnViewnavbuf.ExtentX;
  Sely1p := (ImageEnViewnav.SelY1 * 100) / ImageEnViewnavbuf.ExtentY;
  Sely2p := (ImageEnViewnav.SelY2 * 100) / ImageEnViewnavbuf.ExtentY;

  selx1 := round((((mx+ImageEnView1.ExtentX) * SelX1p) / 100)+ImageEnView1.OffsetX-ImageEnView1.ViewX);
  sely1 := round((((my+ImageEnView1.Extenty) * Sely1p) / 100)+ImageEnView1.Offsety-ImageEnView1.ViewY);
  selx2 := round((((mx+ImageEnView1.ExtentX) * SelX2p) / 100)+ImageEnView1.OffsetX-ImageEnView1.ViewX);
  sely2 := round((((my+ImageEnView1.Extenty) * Sely2p) / 100)+ImageEnView1.Offsety-ImageEnView1.ViewY);

  ImageEnView1.Select(selx1,sely1,selx2,sely2);
  ImageEnView1.ZoomSelection(true);
  Setnav;
end;
procedure TFormtiffpreview.Button1Click(Sender: TObject);
Var
SelX1,SelX2,Sely1,Sely2,mx,my : Longint;
  zx,zy,az : Double;

begin

  ImageEnView1.GetMaxViewXY(mx,my);
  edit1.text := FormatFloat('0.00',ImageEnView1.ExtentX);
  edit2.text := FormatFloat('0.00',mx);
  edit3.text := FormatFloat('0.00',mx+ImageEnView1.ExtentX);

end;

procedure TFormtiffpreview.ActionsaveExecute(Sender: TObject);
begin
  ImageEnview1.IO.SaveToFileTIFF(Tiff_filename);
end;

procedure TFormtiffpreview.ListBoxColorsClick(Sender: TObject);
begin
  Formtiffpreview.Tiff_filename := Formtiffpreview.ListBoxColorfilenames.Items[Formtiffpreview.ListBoxColors.itemindex];
  Formtiffpreview.Caption := Formtiffpreview.Tiff_filename;
  Formtiffpreview.ImageEnView1.IO.LoadFromFileTIFF(Formtiffpreview.Tiff_filename);
 

end;

end.
