unit UDeviceControlframe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Menus;

type
  TFrameDevicecontrol = class(TFrame)
    Panel2: TPanel;
    PopupMenupress: TPopupMenu;
    Addpress1: TMenuItem;
    Removepress1: TMenuItem;
    Panel3: TPanel;
    LabelDevame: TLabel;
    Panel1: TPanel;
    Image1: TImage;
    Image2: TImage;
    ListBox1: TListBox;
    GroupBox1: TGroupBox;
    Paneljobingueue: TPanel;

    procedure Addpress1Click(Sender: TObject);
    procedure Removepress1Click(Sender: TObject);
    procedure ListBox1Exit(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
  private

  public
    { Public declarations }
    deviceid : Longint;
    Currentstate : Longint;
    DevEnabled : Longint;
    Devicetype : Longint;
    JobsInQueue : Longint;
    procedure Setstate;
  end;

implementation

{$R *.dfm}
Uses
  Udevicecontrolplacer,umain, Usettings, UUtils;

procedure TFrameDevicecontrol.Addpress1Click(Sender: TObject);
Var
  T : String;
begin
  T := formmain.FrameDeviceplacer1.addpress(deviceid);
  IF T <> '' then
  begin
    if ListBox1.items.Count = 1 then
    begin
      if ListBox1.items[0] = 'No presses' then
        ListBox1.items.delete(0);
    end;

    ListBox1.items.add(T);

    ListBox1.Height := (ListBox1.ItemHeight) * (ListBox1.Items.Count)+4;
    ListBox1.ItemIndex := -1;
    ListBox1.repaint;
  End;
end;

procedure TFrameDevicecontrol.Removepress1Click(Sender: TObject);
begin
  IF ListBox1.ItemIndex > -1 then
  begin
    formmain.FrameDeviceplacer1.removepress(tnames1.pressnametoid(ListBox1.Items[ListBox1.ItemIndex]) ,deviceid);
    ListBox1.Items.Delete(ListBox1.ItemIndex);

    IF ListBox1.Items.Count = 0 then
      ListBox1.Items.add('No presses');

    ListBox1.Height := (ListBox1.ItemHeight) * (ListBox1.Items.Count)+4;
    ListBox1.ItemIndex := -1;
    ListBox1.repaint;


  end;

  ListBox1.ItemIndex := -1;
  ListBox1.repaint;
end;

procedure TFrameDevicecontrol.ListBox1Exit(Sender: TObject);
begin
  ListBox1.ItemIndex := -1;
  ListBox1.repaint;

end;

procedure TFrameDevicecontrol.Image1DblClick(Sender: TObject);
begin
  if (Prefs.AllowControlDevices) then
  begin
    formmain.FrameDeviceplacer1.Enableadevice(deviceid);
    formmain.FrameDeviceplacer1.Getdevicestate(deviceid,Currentstate,DevEnabled);
    Setstate();
  End;

end;

procedure TFrameDevicecontrol.Setstate;
Var
  devimnum : Longint;
Begin
  devimnum :=  devicetype * 2;

  if DevEnabled < 1 then
    inc(devimnum);

  //Image2.Picture.Bitmap.
  Image1.Picture.Bitmap.Canvas.Brush.Color := clwhite;
  Image1.Picture.Bitmap.Canvas.pen.Color := clwhite;

  Image1.Picture.Bitmap.Canvas.Rectangle(0,0,TUtils.HighDPIScale(47),TUtils.HighDPIScale(47));
  //IF Prefs.PlateTransmissionSystem then
  //begin
  //  devimnum := 0;
  //  if DevEnabled < 1 then
   //   inc(devimnum);

   // formmain.FrameDeviceplacer1.imagelist3.GetBitmap(devimnum,Image1.Picture.Bitmap);
  //End
  //Else
 // begin
    formmain.FrameDeviceplacer1.imagelist1.GetBitmap(devimnum,Image1.Picture.Bitmap);
 // end;

  IF Currentstate <> 1 then
    formmain.FrameDeviceplacer1.ImageList2.GetBitmap(0,Image2.Picture.Bitmap)
  else
    formmain.FrameDeviceplacer1.ImageList2.GetBitmap(1,Image2.Picture.Bitmap);



  IF JobsInQueue > 0 then
  begin
    Paneljobingueue.caption := inttostr(JobsInQueue);
  end
  Else
  begin
    Paneljobingueue.caption := 'none';
  end;


  repaint;


  Image1.repaint;
  Image2.repaint;


End;
end.
