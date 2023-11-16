unit UChangecomment;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFormChangecomment = class(TForm)
    Label1: TLabel;
    PanelYesNO: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    EditChangeComment: TEdit;
    CheckBoxallsubed: TCheckBox;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormChangecomment: TFormChangecomment;

implementation

uses Umain;

{$R *.dfm}

procedure TFormChangecomment.FormActivate(Sender: TObject);
begin
  CheckBoxallsubed.checked := Prefs.SetCommentOnAllEditions;

 // if (foxrmsettings.Editcommentdata.Text <> '') then
 //   ComboBox1.setfocus
  //  else
 //   EditChangeComment.SetFocus;
end;

end.
