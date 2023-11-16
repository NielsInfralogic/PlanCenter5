unit URunDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TFormRun = class(TForm)
    GroupBox1: TGroupBox;
    ComboBoxProduct: TComboBox;
    Editdato: TEdit;
    GroupBox2: TGroupBox;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBoxandreUdgaver: TGroupBox;
    GroupBox4: TGroupBox;
    Splitter1: TSplitter;
    ListBoxNotEd: TListBox;
    Panel2: TPanel;
    BitBtn3: TBitBtn;
    Panel3: TPanel;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    Edit1: TEdit;
    Memo1: TMemo;
    GroupBox3: TGroupBox;
    PanelBesked: TPanel;
    GroupBox5: TGroupBox;
    ListBoxdgaver: TListBox;
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
  private
    DrageEd : String;
  public
    { Public declarations }
    RunError : Boolean;
    RunType : Longint;
    Runningtype : Longint;
    Runerrorfile : String;
    NRunListNumbers : Longint;
    RunListNumbers : Array[1..100] of record
                                        Listnumber : Longint;
                                        Publicationnumber : Longint;

                                      End;
    procedure init;
  end;

var
  FormRun: TFormRun;

implementation

uses USettings,utypes, UMain, UConfigEd;

{$R *.dfm}

procedure TFormRun.init;
Var
  T : String;
  i,ied,ip : Longint;
  AktPublI,il : Longint;
Begin
  try
    ComboBoxProduct.Items.Clear;
    ListBoxNotEd.Items.clear;
    ListBoxdgaver.Items.Clear;
    FormConfigEditions.initnew;

    For ied := 0 to FormConfigEditions.CheckListBox1.Items.Count-1 do
    begin
      ListBoxNotEd.Items.Add(FormConfigEditions.CheckListBox1.Items[ied]);
    end;

    For ip := 1 to NRunListNumbers do
    begin
      il := RunListNumbers[ip].Listnumber;
      AktPublI := RunListNumbers[ip].Publicationnumber;

      ComboBoxProduct.Items.Add(formmain.ListViewplanner.items[il].caption);

      For ied := 1 to Tpubldefaultdata(FormSettings.ListViewPublDefault.Items[AktPublI].data^).Nudg do
      begin
        T := Tpubldefaultdata(FormSettings.ListViewPublDefault.Items[AktPublI].data^).Udgaver[ied].navn;
        IF ListBoxdgaver.Items.IndexOf(T) < 0 then
          ListBoxdgaver.Items.add(T);
      end;
    End;

    For ied := 0 to ListBoxdgaver.Items.Count-1 do
    begin
      T := ListBoxdgaver.Items[ied];
      i := ListBoxNotEd.Items.IndexOf(T);
      ListBoxNotEd.Items.Delete(i);
    end;

    Memo1.lines.clear;
    Memo1.lines.add('Kør ny plan');

    IF (Runningtype = 2) OR (Runningtype = 3) then
    begin
      Memo1.lines.clear;
      Memo1.lines.add('Kør plan Igen');
    end;

    IF runerror then
    begin
      Runerrorfile := extractfilename(Runerrorfile);
      Runerrorfile := changefileext(Runerrorfile,'.xml');
      Runerrorfile := includetrailingbackslash(FormSettings.EditImportCenterError.text) + Runerrorfile+'.txt';
      Memo1.lines.clear;
      IF Fileexists(Runerrorfile) then
        Memo1.lines.LoadFromFile(Runerrorfile)
      Else
      Begin
        Memo1.lines.clear;
        Memo1.lines.add('Unknown Error');
      End;
    end;
    PanelBesked.Caption := '';
    for i := 0 to Memo1.lines.count-1 do
    Begin
      IF i > 0 then PanelBesked.Caption := PanelBesked.Caption + #13;
      PanelBesked.Caption := PanelBesked.Caption + Memo1.lines[i];
    End;

    ComboBoxProduct.ItemIndex := 0;

    ied := 0;
    IF formsettings.ComboBoxpresssystem.Text = 'STS' then
    begin
      For i := 0 to formmain.ListViewplanner.Items.Count-1 do
      begin
        IF formmain.ListViewplanner.Items[i].Selected then
          inc(ied);
      end;
      While Ied < ListBoxdgaver.Items.Count do
      begin
        ListBoxdgaver.Items.Delete(ListBoxdgaver.Items.Count -1);
      end;
    end;
  Except
  end;
End;

procedure TFormRun.BitBtn3Click(Sender: TObject);
Var
  i,seli : Longint;
begin
  DrageEd := '';
  seli := -1;
  For i := 0 to ListBoxdgaver.Items.Count-1 do
  begin
    if ListBoxdgaver.Selected[i] then
    begin
      DrageEd := ListBoxdgaver.Items[i];
      seli := i;
      break;
    end;

  end;

  IF DrageEd <> '' then
  begin
    ListBoxdgaver.Items.Delete(seli);
  end;
  ListBoxNotEd.Items.Add(DrageEd);

end;

procedure TFormRun.BitBtn4Click(Sender: TObject);
Var
  i,seli : Longint;
begin
  DrageEd := '';
  seli := -1;
  For i := 0 to ListBoxNotEd.Items.Count-1 do
  begin
    if ListBoxNotEd.Selected[i] then
    begin
      DrageEd := ListBoxNotEd.Items[i];
      seli := i;
      break;
    end;
  end;

  IF DrageEd <> '' then
  begin
    ListBoxNotEd.Items.Delete(seli);
  end;
  ListBoxdgaver.Items.Add(DrageEd);

end;

procedure TFormRun.BitBtn1Click(Sender: TObject);
begin
  IF (Runningtype = 2) or (Runningtype = 3)  or (Runningtype = 4) then
    FormRun.runtype := 3
  Else
    FormRun.runtype := 1;
end;

procedure TFormRun.BitBtn5Click(Sender: TObject);
begin
  RunType := 2;
end;

procedure TFormRun.BitBtn6Click(Sender: TObject);
begin
  RunType := 3;
end;

procedure TFormRun.BitBtn7Click(Sender: TObject);
begin
  RunType := 4;
end;

end.
