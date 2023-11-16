unit URemoteControl;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ButtonGroup, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.ExtCtrls, UImages, Vcl.CheckLst;

type
  TFormRemoteControl = class(TForm)
    Panel3: TPanel;
    Image2: TImage;
    Label7: TLabel;
    Label8: TLabel;
    TabControl1: TTabControl;
    Panel1: TPanel;
    RadioButton1: TRadioButton;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    CheckListBox1: TCheckListBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormRemoteControl: TFormRemoteControl;

implementation

{$R *.dfm}

end.
