unit Udevmanager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TFramedevicemanager = class(TFrame)
    Panel2: TPanel;
    GroupBoxdename: TGroupBox;
    Panel1: TPanel;
    GroupBox3: TGroupBox;
    Image2: TImage;
    GroupBox2: TGroupBox;
    Panel3: TPanel;
    GroupBox5: TGroupBox;
    Image1: TImage;
    GroupBox4: TGroupBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Var
  Ndevmans : Longint;
  devmans : array[1..100] of record
                               deviceid : longint;
                               currentstate : longint;
                               Currentjob : string;
                               enabled    : Longint;
                               devmana : TFramedevicemanager;
                               workload : longint;
                             end;



implementation

{$R *.dfm}

end.
