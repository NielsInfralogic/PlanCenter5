unit UMultirunframe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ExtCtrls, ComCtrls, PBExListview, StdCtrls, System.ImageList;

type
  TFrameMultirun = class(TFrame)
    ImageListplates: TImageList;
    Timer1: TTimer;
    Panelactive: TPanel;
    GroupBox1: TGroupBox;
    PBExListviewplates: TPBExListview;
    GroupBox2: TGroupBox;
    Panel3: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Panel2: TPanel;
    LabelNplates: TLabel;
    LabelPlatesready: TLabel;
    LabelNness: TLabel;
    Labelplatesimaged: TLabel;
    Labelplatesmissing: TLabel;
  private
    { Private declarations }

  public
    { Public declarations }
    Number : Longint;
    lastpos : Longint;

  end;

implementation
Uses
  Utypes,Umain;

{$R *.dfm}

end.
