unit UPlateframe;

interface

uses
  Windows, Utypes,Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls;

type
  TFramePlateframe = class(TFrame)
    Panel1: TPanel;
    Panel3: TPanel;
    Panel2: TPanel;
    ListViewPages: TListView;
    Panel4: TPanel;
    Image1: TImage;
    procedure ListViewPagesCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure ListViewPagesMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListViewPagesSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure Panel2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    Procedure doselection(Shift: TShiftState;
                          Button: TMouseButton);

    { Private declarations }
  public
    calch          : Longint;
    Number         : Integer;
    MultirunNumber : INteger;
    showplate      : TshowplateRec;
    Selected       : boolean;
    Ncolors        : Integer;
    Nnes           : Integer;
    Nimaged        : Integer;
    Nmissing       : Integer;
    NReady         : Integer;



    Procedure makelistpages;
    { Public declarations }
  end;

implementation
uses
  UMultirunframetext,
  umain;

{$R *.dfm}

Procedure TFramePlateframe.makelistpages;
Var
  lp : tlistitem;
  ip: Longint;
  tmpl :  TPlatetemplate;


  R : trect;
  ic : Longint;

  IDrColors,NDrColors: Integer;
  colorw : Integer;

Begin
  try
    panel2.Caption := inttostr(showplate.sheetnumber) + ' ' + fronbackstr[showplate.front] + ' ' + inttostr(showplate.Copynumber);
    ListViewPages.Items.Clear;

    tmpl := PlatetemplateArray[showplate.templatelistid];
    NDrColors := 0;
    For IDrColors := 1 to showplate.NPlates do
    Begin
      if (showplate.Plates[IDrColors].active = 1) then
        inc(NDrColors);
    end;

    for ip := 1 to tmpl.NupOnplate do
    begin
      IF showplate.pages[ip].pagetype <> 3 then
      begin
        lp := ListViewPages.Items.add;
        lp.Caption :=   tnames1.editionIDtoname(showplate.pages[ip].OrgeditionID);
        lp.SubItems.Add(tnames1.SectionIDtoname(showplate.pages[ip].SectionID));
        lp.SubItems.Add(showplate.pages[ip].pagename);
      End
      Else
      begin
        lp := ListViewPages.Items.add;
        lp.Caption := '';
        lp.SubItems.Add('');
        lp.SubItems.Add('');
      end;
    End;

    IF NDrColors < 4 then
      NDrColors := 4;
    colorw := 32 div NDrColors;

    For IDrColors := 1 to showplate.NPlates do
    begin
      IF showplate.Plates[IDrColors].active = 1 then
      begin
        Image1.Canvas.Brush.Color := Colorsnames[showplate.Plates[IDrColors].ColorID].Colorlook;
        Image1.Canvas.pen.Color   := Colorsnames[showplate.Plates[IDrColors].ColorID].Colorlook;
        Image1.Canvas.Rectangle( (IDrColors-1) *colorw,0,(IDrColors) *colorw,15);
      End;
    end;

    r := ListViewPages.Items[ListViewPages.Items.count-1].DisplayRect(drBounds);
    calch := ListViewPages.Top+r.Bottom+16;
  Except

  end;


end;

procedure TFramePlateframe.ListViewPagesCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  var DefaultDraw: Boolean);

begin

  ListViewPages.canvas.Brush.Color := clwhite;

  IF Multirunnumber > 1 then
  begin
    if MultirunsText[Multirunnumber-1].FrameMultirun.NFramePlateframes >= MultirunsText[Multirunnumber].FrameMultirun.NFramePlateframes then
    begin
      if MultirunsText[Multirunnumber-1].FrameMultirun.FramePlateframes[Number].showplate.Pages[item.Index+1].MasterCopySeparationSet <>
         MultirunsText[Multirunnumber].FrameMultirun.FramePlateframes[Number].showplate.Pages[item.Index+1].MasterCopySeparationSet then
      begin
        ListViewPages.canvas.Brush.Color := clSkyBlue;
      end;
    End;
  end;
  DefaultDraw := true;
end;

procedure TFramePlateframe.ListViewPagesMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  doselection(Shift,Button);
end;

procedure TFramePlateframe.ListViewPagesSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  Item.Selected := false;
end;

procedure TFramePlateframe.Panel2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  doselection(Shift,Button);
end;

procedure TFramePlateframe.Panel1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  doselection(Shift,Button);
end;

Procedure TFramePlateframe.doselection(Shift: TShiftState;
                                       Button: TMouseButton);
Var
  R,P : Longint;
Begin
  IF mbLeft = Button then
  begin
    IF not (ssCtrl IN Shift) then
    begin
      For R := 1 to NMultirunstext do
      begin
        For P := 1 to Multirunstext[R].FrameMultirun.NFramePlateframes do
        begin
          Multirunstext[R].FrameMultirun.Selected := false;
          Multirunstext[R].FrameMultirun.Panelactive.color := clBtnFace;
          IF (R <> MultirunNumber) or (P <> NUMBER) then
          begin
            Multirunstext[R].FrameMultirun.FramePlateframes[p].Selected := false;
            Multirunstext[R].FrameMultirun.FramePlateframes[p].Panel1.Color :=  clBtnFace;
          end;
        end;
      end;
      Selected := not Selected;
      IF Selected THEN
        Panel1.Color := clActiveCaption
      Else
        Panel1.Color :=  clBtnFace;
    end
    Else
    begin
      For R := 1 to NMultirunstext do
      Begin
        Multirunstext[R].FrameMultirun.Selected := false;
        Multirunstext[R].FrameMultirun.Panelactive.color := clBtnFace;
      end;
      Selected := not Selected;
      IF Selected THEN
        Panel1.Color := clActiveCaption
      Else
        Panel1.Color :=  clBtnFace;
    end;
  End;


end;

end.
