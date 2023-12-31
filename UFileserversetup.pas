unit UFileserversetup;
(*
1 mainserver
2 localserver al'a nortt�lje
3 remoteserver dvs outputcenter maskine med workfolder
4 inkserver inkcenter med inkprevies
5 webserver
6 backupserver
*)
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, system.UITypes;

type
  TFormFileseversetup = class(TForm)
    Panela: TPanel;
    Image1: TImage;
    Label46: TLabel;
    Label47: TLabel;
    RadioGroupType: TRadioGroup;
    Label2: TLabel;
    EditShare: TEdit;
    Label3: TLabel;
    Editname: TEdit;
    Label1: TLabel;
    EditIP: TEdit;
    Label4: TLabel;
    EditUsername: TEdit;
    Label5: TLabel;
    Editpassword: TEdit;
    Button2: TButton;
    CheckBoxUselocal: TCheckBox;
    ComboBoxlocation: TComboBox;
    Label6: TLabel;
    BitBtn1: TBitBtn;
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormFileseversetup: TFormFileseversetup;

implementation

uses Udata,umain;

{$R *.dfm}

procedure TFormFileseversetup.Button2Click(Sender: TObject);
begin
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.add('Insert Fileservers (Name,Servertype,CCdatashare,Username,password,IP,Locationid,Inuse,Backupfor,uselocaluser)');
  DataM1.Query1.SQL.add('Values ('+''''+Editname.Text+''''+','+inttostr(RadioGroupType.ItemIndex+1)+','+''''+EditShare.Text+''''+
                                 ','+''''+EditUsername.Text+''''+','+''''+Editpassword.Text+''''+','+''''+EditIP.Text+''''+
                                 ','+inttostr(tnames1.locationnametoid(ComboBoxlocation.text))+
                                 ',1,'+''''+''+''''+','+inttostr(integer(CheckBoxUselocal.checked)+1)+')');

  Try

    DataM1.Query1.ExecSQL(false);

    MessageDlg(formmain.InfraLanguage1.Translate('Plancenter must be restarted after fileservers are added'), mtInformation,[mbOk], 0);


  Except
    MessageDlg(formmain.InfraLanguage1.Translate('Unable to create fileserver ') + Editname.Text, mtError,[mbOk], 0);
  end;

  Close;
end;

procedure TFormFileseversetup.FormActivate(Sender: TObject);
begin
  ComboBoxlocation.Items := tnames1.locationnames;
  ComboBoxlocation.Itemindex := 0;
end;

end.
