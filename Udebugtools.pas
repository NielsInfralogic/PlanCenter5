unit Udebugtools;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls;

type
  TFormdebugtools = class(TForm)
    RadioGroup1: TRadioGroup;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    RadioGroup2: TRadioGroup;
    Edit1: TEdit;
    CheckBoxMisc: TCheckBox;
    CheckBoxtrans: TCheckBox;
    RadioGroup3: TRadioGroup;
    Button1: TButton;
    Editouptver: TEdit;
    CheckBoxoutputver: TCheckBox;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Formdebugtools: TFormdebugtools;

implementation

uses Umain,utypes, Udata;

{$R *.dfm}

procedure TFormdebugtools.Button2Click(Sender: TObject);
Var
  i,SEKP : Longint;
  T : String;
begin
  for i := 1 to formmain.StringGridHS.RowCount do
  begin
    IF SuperHSdata[i-1].Selected then
    begin
      datam1.Query1.SQL.clear;

      datam1.Query1.SQL.Add('Select distinct planpagename from pagetable where Separation = ' + inttostr(SuperHSdata[i-1].Separation));
      datam1.Query1.open;
      T := datam1.Query1.fields[0].AsString;
      SEKP := pos('SEK.',T);
      if SEKP > 0 then
      begin
        delete(T,SEKP,4);
        datam1.Query2.SQL.clear;
        datam1.Query2.SQL.Add('update pagetable set planpagename = '+''''+T+'''');
        datam1.Query2.SQL.Add('where Separation = ' + inttostr(SuperHSdata[i-1].Separation));
        datam1.Query2.ExecSQL;
      end;



      datam1.Query1.close;


    End;
  End;


end;

end.
