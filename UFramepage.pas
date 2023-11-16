unit UFramepage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls;

type
  TFramepage = class(TFrame)
    PanelSection: TPanel;
    Splitter1: TSplitter;
    Panelpagename: TPanel;
    PanelUnique: TPanel;
    Splitter3: TSplitter;
    Splitter4: TSplitter;
    Panelstatus: TPanel;
    Splitter5: TSplitter;
    Panelapprove: TPanel;
    Splitter6: TSplitter;
    Panelhold: TPanel;
    procedure Splitter2CanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure Splitter1Moved(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Number : Integer;

  end;

implementation

{$R *.dfm}
Uses
  unit1;

procedure TFramepage.Splitter2CanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
Var
  I : Integer;
begin
  Accept := NewSize > TSplitter(Sender).MinSize;
  
end;

procedure TFramepage.Splitter1Moved(Sender: TObject);
Var
  I : Integer;
begin

  for i := 1 to nframepages do
  begin
    IF i <> number then
    Begin
      framepages[i].PanelSection.width := PanelSection.width;
      framepages[i].Panelhold.width := Panelhold.width;
      framepages[i].PanelUnique.width := PanelUnique.width;
      framepages[i].Panelstatus.width := Panelstatus.width;
      framepages[i].Panelapprove.width := Panelapprove.width;
    End;
  end;
end;

end.
