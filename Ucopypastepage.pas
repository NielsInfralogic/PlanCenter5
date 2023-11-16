unit Ucopypastepage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons;

type
  TFormcopypastepage = class(TForm)
    Panel3: TPanel;
    Image2: TImage;
    Label7: TLabel;
    Label8: TLabel;
    Panel2: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    RadioGroup1: TRadioGroup;
    GroupBox1: TGroupBox;
    ProgressBar1: TProgressBar;
    TabSheet2: TTabSheet;
    BitBtn2: TBitBtn;
    Memo1: TMemo;
    BitBtn1: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Ncopycolorids : Longint;
    copycolorids : array[1..100] of longint;
    ffile,tfile : string;
    anyerror,proofok : Boolean;
    tomasterset : Longint;
  end;

var
  Formcopypastepage: TFormcopypastepage;

implementation

uses Usettings, Udata,umain;

{$R *.dfm}

procedure TFormcopypastepage.FormActivate(Sender: TObject);
begin
  ProgressBar1.Position := 0;


  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.add('Select count (Distinct RemoteFolder) from LocationNames');
  DataM1.Query1.open;
  IF not DataM1.Query1.eof then
  begin
    IF DataM1.Query1.Fields[0].asinteger = 1 then
      RadioGroup1.Visible := false
    else
      RadioGroup1.Visible := true;
  end;
  DataM1.Query1.close;


end;

procedure TFormcopypastepage.BitBtn1Click(Sender: TObject);
Var
  I : longint;
  ISinuse : Boolean;
begin
  try
    Memo1.lines.clear;
    ProgressBar1.Max := Ncopycolorids;
    Memo1.lines.add('Start copy paste');




    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.add('Select status,miscint4 from pagetable WITH (NOLOCK)');
    DataM1.Query1.SQL.add('Where mastercopyseparationset = ' + inttostr(tomasterset));
    DataM1.Query1.SQL.add('And status IN (5,15,25,35,45)  and active = 1');
    formmain.tryopen(DataM1.Query1);
    ISinuse := false;
    IF not DataM1.Query1.eof then
    begin
      Memo1.lines.add('The selected page since it is currently in use');
      if MessageDlg(formmain.InfraLanguage1.Translate('The selected page since it is currently in use'),mtwarning, [mbIgnore	, mbAbort	], 0) = mrAbort then
        ISinuse := true;
    end;
    DataM1.Query1.Close;

    IF Not ISinuse then
    begin
      DataM1.Query1.SQL.Clear;
      DataM1.Query1.SQL.add('update pagetable');
      DataM1.Query1.SQL.add('Set status = 0, miscint4 = 0');
      DataM1.Query1.SQL.add('Where mastercopyseparationset = ' + inttostr(tomasterset));
      formmain.trysql(DataM1.Query1);

      For i := 1 To Ncopycolorids do
      begin

        Ffile := formmain.getfileserverFrommaster(1,Thumbcopymasterset) + inttostr(Thumbcopymasterset)+'.'+tnames1.ColornameIDtoname(copycolorids[i]);



        tfile := extractfilepath(ffile) + inttostr(tomasterset)+'.'+tnames1.ColornameIDtoname(copycolorids[i]);
        Memo1.lines.add('Copy from ' + Ffile + ' to ' +Tfile );

        IF not copyfile(pchar(Ffile),pchar(Tfile),false) Then
        begin
          anyerror := true;
          Memo1.lines.add('Cannot Copy from ' + Ffile + ' to ' +Tfile );
          MessageDlg(formmain.InfraLanguage1.Translate('Error copying file'), mtInformation,[mbOk], 0);
          break;
        end;
        ProgressBar1.position := I;
      end;

      if not anyerror then
      begin
        Memo1.lines.add('Updateting database ');
        For i := 1 To Ncopycolorids do
        begin
          DataM1.Query1.SQL.Clear;
          DataM1.Query1.SQL.add('update pagetable');
          IF RadioGroup1.Visible then
          begin
            Case RadioGroup1.ItemIndex of
              0 : DataM1.Query1.SQL.add('Set status = 10, miscint4 = 0,proofstatus=0,inkstatus=0');
              1 : DataM1.Query1.SQL.add('Set status = 30, miscint4 = 0,proofstatus=0,inkstatus=0');
            End;
          End
          Else
            DataM1.Query1.SQL.add('Set status = 30, miscint4 = 0,proofstatus=0,inkstatus=0');
          DataM1.Query1.SQL.add('Where mastercopyseparationset = ' + inttostr(tomasterset));
          DataM1.Query1.SQL.add('And colorid = ' + inttostr(copycolorids[i]));
          formmain.trysql(DataM1.Query1);
        end;
        Memo1.lines.add('Updateting database done');
      end;
    End;
  Except
    MessageDlg(formmain.InfraLanguage1.Translate('Error copying file'), mtInformation,[mbOk], 0);
  end;
end;

procedure TFormcopypastepage.BitBtn2Click(Sender: TObject);
begin
  Formcopypastepage.close;
end;

end.
