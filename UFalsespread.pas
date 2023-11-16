unit UFalsespread;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, CheckLst,utypes;

type
  TFormfalsespread = class(TForm)
    Panel3: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    RadioGrouponoff: TRadioGroup;
    GroupBox1: TGroupBox;
    CheckListBoxmarkgroups: TCheckListBox;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    Procedure initmarks;
  public
    templatelistid : Integer;
    ANmarks : Integer;
    Amarks  : marksarray;
    procedure setcreeptofalsespread(mastercopyseparationset : Longint);
    procedure settofalsespread(masternumber : Longint);

  end;

var
  Formfalsespread: TFormfalsespread;

implementation

uses Udata, Umain;

{$R *.dfm}

procedure TFormfalsespread.settofalsespread(masternumber : Longint);
Begin
End;

Procedure TFormfalsespread.initmarks;
Var
  i,i2,i3 : Integer;
Begin
  CheckListBoxmarkgroups.Items.clear;

  For i3 := 1 to NPlatetemplateArray do
  begin
    for i := 1 to  PlatetemplateArray[i3].Nmarkgroups do
    begin
      for i2 := 1 to nmarks do
      begin
        if marks[i2].markid = PlatetemplateArray[i3].markgroups[i] then
        begin
          IF CheckListBoxmarkgroups.Items.IndexOf(marks[i2].markname) < 0 then
            CheckListBoxmarkgroups.Items.add(marks[i2].markname);
          break;
        end;
      end;
    end;

    For i := 0 to CheckListBoxmarkgroups.Items.count-1 do
    begin
      CheckListBoxmarkgroups.Checked[i] := true;
    end;
  End;
end;


procedure TFormfalsespread.FormActivate(Sender: TObject);
begin
  initmarks;
  RadioGrouponoff.ItemIndex := 0;
end;

procedure TFormfalsespread.BitBtn1Click(Sender: TObject);
Var
  i : Integer;
begin
  ANmarks := 0;
  For i := 0 to CheckListBoxmarkgroups.Items.count-1 do
  begin
    if CheckListBoxmarkgroups.Checked[i] then
    begin
      Inc(ANmarks);
      Amarks[ANmarks] := inittypes.marknametoid(CheckListBoxmarkgroups.Items[i]);
    end;
  End;
end;

procedure TFormfalsespread.setcreeptofalsespread(mastercopyseparationset : Longint);
Var
  TrimOffsetXEven,TrimOffsetXodd : real;
  templid{,i }: Longint;
  trimto : Real;
  itsodd : Boolean;
Begin
  try
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('Select distinct templateid,pageindex from pagetable');
    datam1.Query1.SQL.Add('Where uniquepage=1 AND mastercopyseparationset = ' + inttostr(Mastercopyseparationset) );
    datam1.Query1.open;
    IF Not datam1.Query1.eof then
    begin
      templid := datam1.Query1.fields[0].AsInteger;
    end
    else
      exit;

    IF datam1.Query1.fields[1].AsInteger mod 2 = 0 then
    begin
      itsodd := false;
    end
    Else
    begin
      itsodd := true;
    end;


    datam1.Query1.close;

    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('Select distinct TrimOffsetXEven,TrimOffsetXOdd from TemplateConfigurations');
    datam1.Query1.SQL.Add('Where templateid = ' + inttostr(templid));
    datam1.Query1.open;

    TrimOffsetXEven := datam1.Query1.fields[0].asfloat ;
    TrimOffsetXOdd  := datam1.Query1.fields[1].asfloat ;

    datam1.Query1.close;


    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('Select distinct flatseparation from pagetable');
    datam1.Query1.SQL.Add('Where mastercopyseparationset = ' + inttostr(Mastercopyseparationset));
    datam1.Query1.open;
    While Not datam1.Query1.eof do
    begin
      DataM1.Query2.SQL.Clear;
      DataM1.Query2.SQL.add('update pagetable');
      DataM1.Query2.SQL.add('set markgroups = '+''''+inittypes.marksIDstr(Formfalsespread.ANmarks,Formfalsespread.Amarks)+'''');
      DataM1.Query2.SQL.add('where flatseparation = ' + datam1.Query1.fields[0].Asstring);
      DataM1.Query2.execsql;

      datam1.Query1.next
    end;
    datam1.Query1.close;

    if Formfalsespread.RadioGrouponoff.ItemIndex = 0 then
    begin
      DataM1.Query1.SQL.Clear;
      DataM1.Query1.SQL.Add('update pagetable');
      datam1.Query1.SQL.Add('set flatproofstatus=0, creep = :creep');
      if (Prefs.ThumbnailResetStatusOnPageTypeChange) then
        datam1.Query1.SQL.Add(', status = 0');
      if (Prefs.SetCommentOnFalseSpreads) then
        datam1.Query1.SQL.Add(', Comment = ''SPREAD'' ');
      datam1.Query1.SQL.Add('Where mastercopyseparationset = ' + inttostr(Mastercopyseparationset));

      if itsodd then
        trimto := TrimOffsetXOdd * TrimOdd
      else
        trimto := TrimOffsetXeven * Trimeven;

      datam1.Query1.ParamByName('creep').AsFloat := trimto;
      datam1.Query1.ExecSQL;
    End
    Else
    Begin
      DataM1.Query1.SQL.Clear;
      DataM1.Query1.SQL.Add('update pagetable');
      datam1.Query1.SQL.Add('set flatproofstatus=0, creep = :creep');
      if (Prefs.ThumbnailResetStatusOnPageTypeChange) then
        datam1.Query1.SQL.Add(', status = 0');
      if (Prefs.SetCommentOnFalseSpreads) then
        datam1.Query1.SQL.Add(', Comment = '''' ');
      datam1.Query1.SQL.Add('Where mastercopyseparationset = ' + inttostr(Mastercopyseparationset));
      datam1.Query1.ParamByName('creep').AsFloat := 0;
      datam1.Query1.ExecSQL;
    End;
  Except
  End;
End;

end.
