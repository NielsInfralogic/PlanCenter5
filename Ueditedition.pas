unit Ueditedition;

interface

uses
  utypes,Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, system.uitypes,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Buttons, PBExListview, CheckLst;

type
  TFormeditedition = class(TForm)
    GroupBox1: TGroupBox;
    PBExListviewSections: TPBExListview;
    Panel1: TPanel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label1: TLabel;
    editto: TEdit;
    Editpre: TEdit;
    Editpost: TEdit;
    ComboBoxSection: TComboBox;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    EditFoffset: TEdit;
    Editboffset: TEdit;
    UpDownFoffset: TUpDown;
    UpDownboffset: TUpDown;
    Editoffset: TEdit;
    UpDown1: TUpDown;
    Panelb: TPanel;
    Image2: TImage;
    Label3: TLabel;
    Label9: TLabel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label5: TLabel;
    CheckListBoxcolors: TCheckListBox;
    GroupBox2: TGroupBox;
    CheckBoxbindingstyle: TCheckBox;
    CheckBoxCombinetoonerun: TCheckBox;
    Label13: TLabel;
    ComboBoxcovername: TComboBox;
    CheckBoxbackward: TCheckBox;
    ComboBoxplatelayout: TComboBox;
    Label2: TLabel;
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure PBExListviewSectionsSelectItem(Sender: TObject;
      Item: TListItem; Selected: Boolean);
  private
    { Private declarations }

    function isaoknumberofpages(npaget : String):Boolean;
    Function checkthispages(Tpages : string):Boolean;
    Function checkpages:Boolean;
  public
    Npages : Longint;
    Nsplits : Longint;
    Nsections : LOngint;
    Oldstyleinsert : boolean;
    Commastrlist : array[1..100] of Integer;
    Aktpressid,akttemplateListid : Longint;
    procedure makesplitlist;
    Function npagestrtonpages(commastr : string;
                              Var Nsplit : Integer):Longint;


    { Public declarations }
  end;

var
  Formeditedition: TFormeditedition;

implementation
Uses
  umain, Usettings;
{$R *.dfm}

function TFormeditedition.isaoknumberofpages(npaget : String):Boolean;
Var
  I : Integer;
Begin
  result := true;
  IF npaget = '' then
  Begin
    result := false;
  End
  else
  begin
    for i := 1 to length(npaget) do
    begin
      if (not (npaget[i] IN tal)) then
      begin
         IF npaget[i]<>',' then
           result := false;
      end;
    end;
  end;
end;


procedure TFormeditedition.BitBtn3Click(Sender: TObject);
Var
  I : Integer;
  l : tlistitem;
  T : string;
  Addok : boolean;
begin

  addok := isaoknumberofpages(editto.text);
  if addok then
  begin
    addok := checkthispages(editto.text);
  end;

  For i := 0 to PBExListviewSections.Items.count-1 do
  begin
    if PBExListviewSections.Items[i].Caption = ComboBoxSection.Items[ComboBoxSection.Itemindex] then
    Begin
      addok := false;
       MessageDlg(formmain.InfraLanguage1.Translate('Section already exists in this plan'), mtError,[mbOk], 0);
    end;
  end;

  if addok then
  begin
    l := PBExListviewSections.Items.add;
    l.Caption := ComboBoxSection.Items[ComboBoxSection.Itemindex];
    l.SubItems.Add(editto.text);
    l.SubItems.Add(Editpre.text);
    l.SubItems.Add(Editpost.text);
    l.SubItems.Add(EditFoffset.text);
    l.SubItems.Add(EditBoffset.text);
    l.SubItems.Add(Editoffset.text);
    l.SubItems.Add(ComboBoxcovername.Text);
    l.SubItems.Add('');
    T := editto.text;
    PBExListviewSections.selected := l;
    BitBtn1.Enabled :=  PBExListviewSections.Items.Count > 0;
    IF BitBtn1.Enabled then
    begin
      BitBtn1.Enabled :=checkpages;
    End;
  End;
end;


Function TFormeditedition.checkthispages(Tpages : string):Boolean;
Var
  isp : Integer;
  T : string;
  Np : Integer;
Begin
  result := true;

  T := Tpages;
  IF T = '' then
  begin
    MessageDlg(formmain.InfraLanguage1.Translate('Number of pages missing'), mtInformation,[mbOk], 0);
    result := false;
  end;
  if result then
  begin
    np := npagestrtonpages(T,isp);
    if np mod 2 <> 0 then
    begin
      MessageDlg(formmain.InfraLanguage1.Translate('Number of pages do not fit template layout'), mtInformation,[mbOk], 0);
      result := false;
    end;
  End;
  if result then
  begin
    IF pos(',',t) > 0 then
    begin
    end;
  End;

end;
Function TFormeditedition.checkpages:Boolean;
Var
  I : Integer;


Begin
  result := true;
  For i := 0 to PBExListviewSections.Items.Count-1 do
  begin
    result := checkthispages(PBExListviewSections.Items[i].SubItems[0]);
    if not result then
      break;
  end;
end;

Function TFormeditedition.npagestrtonpages(commastr : string;
                                           Var Nsplit : Integer):Longint;
Var
  T : string;
  N,N2 : Integer;

Begin
  n2 := 0;
  n := 0;
  IF pos(',',commastr) > 0 then
  begin
    While pos(',',commastr) > 0 do
    begin
      Inc(n2);
      T := copy(commastr,1,pos(',',commastr)-1);
      n := n + strtoint(t);
      Commastrlist[n2] := strtoint(t);
      delete(commastr,1,pos(',',commastr));
    End;
    IF length(commastr) > 0 then
    begin
      Inc(n2);
      n := n + strtoint(commastr);
      Commastrlist[n2] := strtoint(commastr);
    end;
  end
  else
  begin
    IF commastr = '' then
      n :=  0
    else

      n := strtoint(commastr);
    Commastrlist[1] := n;
  end;
  Nsplit := n2;
  result := n;
end;


procedure TFormeditedition.BitBtn4Click(Sender: TObject);
Var
  addok : boolean;
begin
  addok := isaoknumberofpages(editto.text);
  if addok then
  begin
    addok := checkthispages(editto.text);
  end;

  if addok then
  begin

    IF PBExListviewSections.Selected <> nil then
    begin
      PBExListviewSections.Selected.Caption := ComboBoxSection.Items[ComboBoxSection.Itemindex];
      PBExListviewSections.Selected.subitems[0] := editto.text;
      PBExListviewSections.Selected.subitems[1] := Editpre.text;
      PBExListviewSections.Selected.subitems[2] := Editpost.text;
      PBExListviewSections.Selected.subitems[3] := EditFoffset.text;
      PBExListviewSections.Selected.subitems[4] := EditBoffset.text;
      PBExListviewSections.Selected.subitems[5] := Editoffset.text;
      PBExListviewSections.Selected.subitems[6] := ComboBoxcovername.Text;

    end;
    BitBtn1.Enabled :=  PBExListviewSections.Items.Count > 0;
    IF BitBtn1.Enabled then
    begin
      BitBtn1.Enabled :=checkpages;
    End;
  End;
end;

procedure TFormeditedition.BitBtn5Click(Sender: TObject);
begin
  IF PBExListviewSections.Selected <> nil then
    PBExListviewSections.Selected.Delete;
  BitBtn1.Enabled :=  PBExListviewSections.Items.Count > 0;
  IF BitBtn1.Enabled then
  begin
    BitBtn1.Enabled :=checkpages;
  End;

end;

procedure TFormeditedition.BitBtn1Click(Sender: TObject);
Var
  I,p,s : Integer;
begin
  Nsections := PBExListviewSections.Items.count;
  Npages := 0;
  Nsplits := 0;
  For i := 0 to PBExListviewSections.Items.count-1 do
  Begin
    p := npagestrtonpages(PBExListviewSections.Items[i].SubItems[0],s);
    IF s > 1 then
    begin
      Inc(Nsplits,s);
    end;
    Inc(Npages,p);
  End;

  makesplitlist;

End;

procedure TFormeditedition.makesplitlist;
Var
  T,commastr : string;
  N,N2,i : Integer;
Begin

  try

    Nsplitliste := 0;
    Oldstyleinsert := false;

    Oldstyleinsert := PBExListviewSections.Items.Count > 1;
    for i := 0 to PBExListviewSections.Items.Count-1 do
    begin
      commastr := PBExListviewSections.Items[i].subitems[0];
      IF pos(',',commastr) > 0 then
      Begin
        Oldstyleinsert := false;
      end;
    End;

    IF not Oldstyleinsert then
    begin
      for i := 0 to PBExListviewSections.Items.Count-1 do
      begin
        commastr := PBExListviewSections.Items[i].subitems[0];
        n2 := 0;
        n := 0;
        IF pos(',',commastr) > 0 then
        begin
          While pos(',',commastr) > 0 do
          begin
            Inc(n2);
            T := copy(commastr,1,pos(',',commastr)-1);
            n := n + strtoint(t);
            delete(commastr,1,pos(',',commastr));
            Inc(Nsplitliste);
            splitliste[Nsplitliste] := strtoint(t);
          End;
          IF length(commastr) > 0 then
          begin
            n := n + strtoint(commastr);
            Inc(Nsplitliste);
            splitliste[Nsplitliste] := strtoint(commastr);
          end;
        end
        else
        begin
          Inc(n2);
          IF commastr = '' then
            n :=  0
          else
          Begin
            n := strtoint(commastr);
            Inc(Nsplitliste);
            splitliste[Nsplitliste] := strtoint(commastr);
          End;
        end;
      end;
    End;
  Except
  end;
end;



procedure TFormeditedition.FormActivate(Sender: TObject);
Var
  T : string;
  I : Integer;
begin
  ComboBoxSection.Items := tNames1.sectionnames;
  ComboBoxSection.Itemindex := 0;

  CheckListBoxcolors.Items.Clear;
  For I := 0 to tNames1.Colornames.Count-1 do
  begin
    IF Uppercase(tNames1.Colornames[i]) <> 'DINKY' then
      CheckListBoxcolors.Items.add(tNames1.Colornames[i]);
  end;

  For i := 0 to CheckListBoxcolors.Items.Count-1 do
  begin
    CheckListBoxcolors.Checked[i] := false;
  End;
  ComboBoxplatelayout.Items.clear;
  For I := 1 to NPlatetemplateArray do
  begin

    IF (PlatetemplateArray[I].PressID = AktpressID) then
    begin                             
      ComboBoxplatelayout.Items.add(PlatetemplateArray[I].TemplateName);
    end;
  end;
  ComboBoxplatelayout.ItemIndex := ComboBoxplatelayout.Items.IndexOf(PlatetemplateArray[akttemplateListid].TemplateName); 

  For i := 0 to CheckListBoxcolors.Items.Count-1 do
  begin
    T := uppercase(CheckListBoxcolors.Items[i]);
    if (T = 'K') or (T = 'BLACK') then
    Begin
      CheckListBoxcolors.Checked[i] := true;
      if Prefs.PlanningDefaultToMono then
        break;
    End
    Else
    Begin
      IF ((T = 'C') OR (T = 'M') OR (T = 'Y') or (T = 'CYAN') or (T = 'MAGENTA') or (T = 'YELLOW')) and (not Prefs.PlanningDefaultToMono) then
      Begin
        CheckListBoxcolors.Checked[i] := true;
      End;
    End;
  end;

  Formeditedition.PBExListviewSections.Selected := Formeditedition.PBExListviewSections.items[0];
  Formeditedition.PBExListviewSections.setfocus;
end;

procedure TFormeditedition.PBExListviewSectionsSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
Var
  I :Integer;
begin
  IF PBExListviewSections.selected <> nil then
  begin
    ComboBoxSection.Itemindex := 0;
    for I :=0 to ComboBoxSection.Items.Count-1 do
    begin
      if PBExListviewSections.selected.caption = ComboBoxSection.Items[i] then
      begin
        ComboBoxSection.Itemindex := i;
        break;
      end;
    end;
    editto.Text := PBExListviewSections.selected.SubItems[0];
    Editpre.Text := PBExListviewSections.selected.SubItems[1];
    Editpost.Text := PBExListviewSections.selected.SubItems[2];

    EditFoffset.Text := PBExListviewSections.selected.SubItems[3];
    EditBoffset.Text := PBExListviewSections.selected.SubItems[4];
    Editoffset.Text := PBExListviewSections.selected.SubItems[5];
  End;
end;


end.

