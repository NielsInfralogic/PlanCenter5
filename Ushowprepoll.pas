unit Ushowprepoll;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, XPStyleActnCtrls,
  ActnList, ActnMan, ToolWin, ActnCtrls, System.Actions;

type
  TFormprepollmessages = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    RichEdit1: TRichEdit;
    ActionToolBar1: TActionToolBar;
    ActionManager1: TActionManager;
    Action1: TAction;
    Action2: TAction;
    procedure Action1Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
  private
    { Private declarations }
  public

    { Public declarations }
  end;

var
  Formprepollmessages: TFormprepollmessages;


implementation

Uses
  umain;
{$R *.dfm}

procedure TFormprepollmessages.Action1Execute(Sender: TObject);
begin
  RichEdit1.print('prepoll eventmessages ' + formatdatetime('NNSS',now));
end;

procedure TFormprepollmessages.Action2Execute(Sender: TObject);
begin
  RichEdit1.Lines.SaveToFile('prepoll eventmessages ' + formatdatetime('NNSS',now));
end;

end.
