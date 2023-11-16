unit UMultirunframetext;

interface

uses
  UPlateframe,Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ExtCtrls, ComCtrls, PBExListview, StdCtrls;

type
  TFrameMultiruntext = class(TFrame)
    ImageListplates: TImageList;
    Timer1: TTimer;
    Panelactive: TPanel;
    GroupBox2: TGroupBox;
    Panel3: TPanel;
    Label6: TLabel;
    Label8: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Panel2: TPanel;
    LabelPlatesready: TLabel;
    LabelNness: TLabel;
    Labelplatesimaged: TLabel;
    Labelplatesmissing: TLabel;
    procedure PBExListviewplateshorzcroll(Sender: TObject);
    procedure PBExListviewplatesVertscroll(Sender: TObject);
    procedure GroupBox2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }

  public
    { Public declarations }
    Selected : Boolean;
    PressID : Longint;
    pressrunID : Longint;
    EditionID : Longint;
    publicationid : Longint;
   
    Pubdate : tdatetime;
    Number : Longint;
    lastpos : Longint;
    Nuniquepages : Longint;
    Nuseinothereditions : Longint;
    NFramePlateframes : Integer;
    FramePlateframes : array[1..1024] of TFramePlateframe;
  end;

  TMultirunsText = array[1..1] of record
                                      FrameMultirun : TFrameMultirunText;
                                      Nshowplates : Integer;
                                    end;

Var
  NMultirunsText : Integer;
  MultirunsText : TMultirunsText;
implementation
Uses
  Utypes,
  Umain;

{$R *.dfm}

procedure TFrameMultiruntext.PBExListviewplateshorzcroll(Sender: TObject);
begin

//  Formmain.Syncscrollbars(number);

end;

procedure TFrameMultiruntext.PBExListviewplatesVertscroll(Sender: TObject);
Var
  lpMinPos,lpMaxPos,x,N,I,x2 : Longint;


Begin
  x2 := GetScrollPos(Multiruns[Number].FrameMultirun.PBExListviewplates.Handle,SB_VERT);
  for i := 1 to NMultiruns do
  begin
    if i <> Number then
    begin
      GetScrollRange(Multiruns[i].FrameMultirun.PBExListviewplates.Handle,SB_VERT	,lpMinPos,lpMaxPos);
      x := GetScrollPos(Multiruns[i].FrameMultirun.PBExListviewplates.Handle,SB_VERT);
      IF x2 <= lpMaxPos then
      begin
        n := x2-x;
        Multiruns[i].FrameMultirun.PBExListviewplates.Scroll(0,n);
      end;
    End;
  End;

end;

procedure TFrameMultiruntext.GroupBox2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var
  R,P : Longint;
Begin
  IF mbLeft = Button then
  begin
    IF not (ssCtrl IN Shift) then
    begin
      For R := 1 to NMultirunstext do
      begin
        IF R <> NUMber then
        begin
          Multirunstext[R].FrameMultirun.Panelactive.color := clBtnFace;
          Multirunstext[R].FrameMultirun.selected := false;
        end;
        For P := 1 to Multirunstext[R].FrameMultirun.NFramePlateframes do
        begin
          Multirunstext[R].FrameMultirun.FramePlateframes[p].Selected := false;
          Multirunstext[R].FrameMultirun.FramePlateframes[p].Panel1.Color :=  clBtnFace;
        end;
      end;

      Selected := not Selected;
      IF Selected THEN
        Panelactive.Color := clActiveCaption
      Else
        Panelactive.Color :=  clBtnFace;
    end
    Else
    begin

      Selected := not Selected;
      IF Selected THEN
        Panelactive.Color := clActiveCaption
      Else
        Panelactive.Color :=  clBtnFace;
    end;
  End;


end;


end.
