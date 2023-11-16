unit UpressplanConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Buttons, CheckLst, ExtDlgs,
  ImgList;

type
  TFormPressplanConfig = class(TForm)
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox1: TGroupBox;
    Button1: TButton;
    ColorDialog: TColorDialog;
    Panel1: TPanel;
    ColorBox1: TColorBox;
    ColorPaint: TPaintBox;
    Label1: TLabel;
    Label2: TLabel;
    Editcolorname: TEdit;
    BitBtn3: TBitBtn;
    TabSheet3: TTabSheet;
    ListBoxcolors: TListBox;
    Button2: TButton;
    Button3: TButton;
    OpenPictureDialog1: TOpenPictureDialog;
    ColorDialogmaskcolor: TColorDialog;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    GroupBox3: TGroupBox;
    MemoPapir: TMemo;
    GroupBox4: TGroupBox;
    Memofalse: TMemo;
    GroupBox5: TGroupBox;
    Memoglu: TMemo;
    GroupBox6: TGroupBox;
    ListBoxprint: TListBox;
    GroupBox7: TGroupBox;
    ListBoxpack: TListBox;
    GroupBoxediticon: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Editgenactionname: TEdit;
    ComboBoxgenicon: TComboBox;
    GroupBox8: TGroupBox;
    ListBoxprepress: TListBox;
    GroupBox9: TGroupBox;
    ListBoxgeneral: TListBox;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Label6: TLabel;
    Button4: TButton;
    ColorBoxmaskcolor: TColorBox;
    BitBtn4: TBitBtn;
    procedure ListBoxcolorsDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ListBoxcolorsClick(Sender: TObject);
    procedure ColorPaintPaint(Sender: TObject);
    procedure ColorPaintDblClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
  private
    FColorChanged: Boolean;
    FPaintColor: TColor;

  public
    procedure load;
    procedure Save;

    Function getAcolorfromname(aname : String):Tcolor;
    Procedure Initcolors;
  end;

var
  FormPressplanConfig: TFormPressplanConfig;


  NPossiblecolors : Longint;
  Possiblecolors : Array[0..100] of record
                                       Acolor : tcolor;
                                       Aname  : String;

                                     End;


  Ngeneralactions : Longint;
  generalactions : Array[0..100] of record
                                       name : String;
                                       Index : Longint;
                                     end;

  NPrepressactions : Longint;
  Prepressactions : Array[0..100] of record
                                       name : String;
                                       Index : Longint;
                                     end;

  NPrintactions : Longint;
  Printactions : Array[0..100] of record
                                     name : String;
                                     Index : Longint;
                                   end;

  Npackactions : Longint;
  packactions : Array[0..100] of record
                                   name : String;
                                   Index : Longint;
                                 end;


implementation

uses UMain,inifiles;

{$R *.dfm}
Procedure TFormPressplanConfig.Initcolors;
Var
  I : Longint;
Begin
  ListBoxcolors.Items.Clear;

  NPossiblecolors := 4;

  Possiblecolors[0].Acolor := clMoneyGreen;
  Possiblecolors[0].Aname := 'Heatset';

  Possiblecolors[1].Acolor := clSkyBlue;
  Possiblecolors[1].Aname := 'Coldset';

  Possiblecolors[2].Acolor := clFuchsia;
  Possiblecolors[2].Aname := 'Special plan';


  For i := 0 to NPossiblecolors-1 do
  begin
    ListBoxcolors.Items.Add(Possiblecolors[i].Aname);
  end;
end;



Function TFormPressplanConfig.getAcolorfromname(aname : String):Tcolor;
Var
  I : Longint;
Begin
  result := clwhite;
  Aname := uppercase(Aname);

  For i := 0 to NPossiblecolors-1 do
  begin
    IF Uppercase(Possiblecolors[i].Aname) = Aname then
    begin
      result := Possiblecolors[i].Acolor;
      break;
    end;

  end;

end;

procedure TFormPressplanConfig.ListBoxcolorsDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
 if odSelected in State then
 Begin
   (Control as TListBox).Canvas.Brush.Color := clHighlight
 End
 else
 Begin
   (Control as TListBox).Canvas.Brush.Color := clWhite;
 End;

 (Control as TListBox).Canvas.FillRect(Rect);

 with (Control as TListBox).Canvas do
 begin
  TextOut(Rect.Left + 18,Rect.Top, Possiblecolors[index].Aname);
  Brush.Color := Possiblecolors[index].Acolor;
  Rectangle(Rect.Left + 1,Rect.Top + 1,Rect.Left + 16,Rect.Bottom - 1);
 end;

end;

procedure TFormPressplanConfig.FormCreate(Sender: TObject);

begin
  NGeneralactions := 2;
  Generalactions[0].name   := 'Order received';
  Generalactions[0].Index  := 4;
  Generalactions[1].name   := 'Order confirmed';
  Generalactions[1].Index  := 2;
  ListBoxgeneral.Items.Add(Generalactions[0].name);
  ListBoxgeneral.Items.Add(Generalactions[1].name);

  NPrepressactions := 2;
  Prepressactions[0].name   := 'Plates are being prepared';
  Prepressactions[0].Index  := 1;
  Prepressactions[1].name   := 'All plates are ready';
  Prepressactions[1].Index  := 3;
  ListBoxprepress.Items.Add(Prepressactions[0].name);
  ListBoxprepress.Items.Add(Prepressactions[1].name);

  Nprintactions := 2;
  printactions[0].name   := 'Press plan ready';
  printactions[0].Index  := 5;
  printactions[1].name   := 'Done';
  printactions[1].Index  := 6;
  ListBoxprint.Items.Add(printactions[0].name);
  ListBoxprint.Items.Add(printactions[1].name);

  Npackactions := 2;
  packactions[0].name   := 'Role up';
  packactions[0].Index  := 7;
  packactions[1].name   := 'Truck is loaded';
  packactions[1].Index  := 8;


  ListBoxpack.Items.Add(packactions[0].name);
  ListBoxpack.Items.Add(packactions[1].name);
  ListBoxpack.Items.Add(packactions[2].name);
  Initcolors;
end;

procedure TFormPressplanConfig.Button1Click(Sender: TObject);
begin
  ColorDialog.Color := FPaintColor;
  if ColorDialog.Execute then
  begin
    FPaintColor := ColorDialog.Color;
    ColorPaint.Invalidate;
    FColorChanged := True;
  end;
end;


procedure TFormPressplanConfig.ListBoxcolorsClick(Sender: TObject);
begin
  IF (ListBoxcolors.ItemIndex > -1) then
    FPaintColor := Possiblecolors[ListBoxcolors.ItemIndex].Acolor;

  ColorPaint.Color := FPaintColor;
  Editcolorname.Text := Possiblecolors[ListBoxcolors.ItemIndex].Aname;
  ColorPaint.Invalidate;
  FColorChanged := True;
end;

procedure TFormPressplanConfig.ColorPaintPaint(Sender: TObject);

var
  R: TRect;
begin
  R := ColorPaint.ClientRect;

  ColorPaint.Canvas.Brush.Style := bsSolid;
  ColorPaint.Canvas.Brush.Color := FPaintColor;
  ColorPaint.Canvas.FillRect(R);

  DrawEdge(ColorPaint.Canvas.Handle, R, EDGE_SUNKEN, BF_RECT);
end;

procedure TFormPressplanConfig.ColorPaintDblClick(Sender: TObject);
begin
  ColorDialog.Color := FPaintColor;
  if ColorDialog.Execute then
  begin
    FPaintColor := ColorDialog.Color;
    ColorPaint.Invalidate;
    FColorChanged := True;
  end;

end;

procedure TFormPressplanConfig.BitBtn3Click(Sender: TObject);
begin
  IF ListBoxcolors.ItemIndex > -1 then
  begin

    Possiblecolors[ListBoxcolors.ItemIndex].Aname := Editcolorname.Text;
    ListBoxcolors.Items[ListBoxcolors.ItemIndex] := Editcolorname.Text;

    Possiblecolors[ListBoxcolors.ItemIndex].Acolor := ColorPaint.Canvas.Brush.Color;
    ListBoxcolors.Repaint;
  end;
end;

procedure TFormPressplanConfig.BitBtn1Click(Sender: TObject);
begin
  Inc(NPossiblecolors);
  Possiblecolors[NPossiblecolors-1].Aname := Editcolorname.Text;
  Possiblecolors[NPossiblecolors-1].Acolor := ColorPaint.Canvas.Brush.Color;

  ListBoxcolors.Items.Add(Editcolorname.Text);

  ListBoxcolors.Repaint;

end;

procedure TFormPressplanConfig.FormActivate(Sender: TObject);
Var
  I : Longint;
begin
  ColorBoxmaskcolor.ItemIndex := ColorBoxmaskcolor.Items.IndexOf('clWhite');
  ComboBoxgenicon.Items.Clear;
  For i := 0 to Formmain.PlannerImages.Count-1 do
  begin
    ComboBoxgenicon.Items.add(inttostr(i));

  end;
  ComboBoxgenicon.Itemindex := 0;
  GroupBoxediticon.Visible := PageControl1.ActivePageIndex < 4;
end;

procedure TFormPressplanConfig.Button4Click(Sender: TObject);
begin
  IF OpenPictureDialog1.Execute then
  begin

    if Formmain.PlannerImages.FileLoad(rtBitmap,OpenPictureDialog1.FileName,ColorBoxmaskcolor.Selected) then
    begin
      ComboBoxgenicon.Items.Add(inttostr(ComboBoxgenicon.Items.Count-1));
      WriteComponentResFile(Extractfilepath(application.exename) +'Myplanner.icons',Formmain.PlannerImages);
    end;

  end;
end;

procedure TFormPressplanConfig.PageControl1Change(Sender: TObject);
begin
  GroupBoxediticon.Visible := PageControl1.ActivePageIndex < 4;
end;


procedure TFormPressplanConfig.load;
Begin

End;

procedure TFormPressplanConfig.Save;
Begin

End;

end.
