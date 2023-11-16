unit UaddExtrapressrun;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, system.UITypes,
  Dialogs, ImgList, StdCtrls, ComCtrls, Buttons, ExtCtrls,
  CheckLst;

type
  TFormAddExtrapressrun = class(TForm)
    GroupBox1: TGroupBox;
    PBExListviewSections: TListview;
    Panel1: TPanel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    editto: TEdit;
    Editpre: TEdit;
    Editpost: TEdit;
    ComboBoxSection: TComboBox;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    Label10: TLabel;
    Label11: TLabel;
    EditFoffset: TEdit;
    Editboffset: TEdit;
    UpDownFoffset: TUpDown;
    UpDownboffset: TUpDown;
    Label1: TLabel;
    Editoffset: TEdit;
    UpDown1: TUpDown;
    Panel2: TPanel;
    Panela: TPanel;
    Image1: TImage;
    Label5: TLabel;
    Label12: TLabel;
    Panel3: TPanel;
    RadioGroupcollection: TRadioGroup;
    GroupBox2: TGroupBox;
    CheckBoxbindingstyle: TCheckBox;
    CheckBoxCombinetoonerun: TCheckBox;
    GroupBox3: TGroupBox;
    EditCopies: TEdit;
    UpDowncopies: TUpDown;
    Panel4: TPanel;
    BitBtn1: TBitBtn;
    BitBtn6: TBitBtn;
    ComboBoxcovername: TComboBox;
    Label13: TLabel;
    GroupBox4: TGroupBox;
    RadioGroupdoctype: TRadioGroup;
    Panel5: TPanel;
    CheckListBoxextracolors: TCheckListBox;
    Panelb: TPanel;
    Image2: TImage;
    Label2: TLabel;
    Label9: TLabel;
    CheckBoxbackward: TCheckBox;
    CheckBoxprepaired: TCheckBox;
    GroupBox5: TGroupBox;
    ComboBoxedition: TComboBox;
    GroupBox6: TGroupBox;
    ComboBoxplatelayout: TComboBox;
    GroupBoxmanual: TGroupBox;
    Label3: TLabel;
    Label14: TLabel;
    CheckBoxManual: TCheckBox;
    EditManualplates: TEdit;
    UpDown2: TUpDown;
    EditManPplate: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure PBExListviewSectionsSelectItem(Sender: TObject;
      Item: TListItem; Selected: Boolean);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure RadioGroupdoctypeClick(Sender: TObject);
  private
    function isaoknumberofpages(npaget : String):Boolean;
    Function checkpages:Boolean;
    Function checkthispages(Tpages : string):Boolean;
    { Private declarations }
  public
    { Public declarations }
    Ncolors   : Integer;
    Nsections : Integer;
    Npages    : Integer;
    Nsplits   : Integer;
    colorType   : Integer; //1=bw,2=color,3=pdf
    Splitonconsec : boolean;
    Oldstyleinsert : boolean;
    Multisecplan : boolean;
    Commastrlist : array[1..100] of Integer;
    procedure makesplitlist;
    Function npagestrtonpages(commastr : string;
                              Var Nsplit : Integer):Longint;
  end;

var
  FormAddExtrapressrun: TFormAddExtrapressrun;

implementation

{$R *.dfm}
Uses
  utypes,umain, Udata, Uproof, USelecttemplate, Usettings,
  Uprodplan, Uaddpressrun,uplanframe;


Var
  Applyingpdf : boolean;


procedure TFormAddExtrapressrun.FormActivate(Sender: TObject);
Var
  i : Integer;
  T : string;
  doctype : longint;
  fed : string;
begin
  ComboBoxedition.Items := tnames1.Editionnames;
  ComboBoxedition.Itemindex := 0;

  if Nplateframes > 0 then
  begin
    fed := tnames1.editionIDtoname(plateframesdata[1].prodplates[0].EditionID);
    ComboBoxedition.Itemindex := ComboBoxedition.Items.IndexOf(fed);
  end;
  PBExListviewSections.Items.Clear;

  CheckBoxbackward.Checked := Prefs.PlanningDefaultBackwardNumbering;
  Applyingpdf := false;

  RadioGroupdoctype.Enabled := true;

  IF (formprodplan.Editmode = PLANADDMODE_APPLY) and (formprodplan.NApplymodecolors > 0) then
  Begin
    RadioGroupdoctype.Enabled := false;
  end;

  RadioGroupdoctype.ItemIndex := doctype;

  IF doctype = 1 then
  begin
    RadioGroupdoctype.ItemIndex := 1;
    CheckListBoxextracolors.Items.Clear;
    CheckListBoxextracolors.Items.add('PDF');
    CheckListBoxextracolors.Checked[0] := true;
    CheckListBoxextracolors.Visible := false;
  End
  Else
  begin
    CheckListBoxextracolors.Items.Clear;
    For I := 0 to tNames1.Colornames.Count-1 do
    begin
      IF (Uppercase(tNames1.Colornames[i]) <> 'DINKY') and (Uppercase(tNames1.Colornames[i]) <> 'PDF') then
        CheckListBoxextracolors.Items.Add(tNames1.Colornames[i]);
    end;

    For i := 0 to CheckListBoxextracolors.Items.Count-1 do
    begin
      CheckListBoxextracolors.Checked[i] := false;
    End;

    For i := 0 to CheckListBoxextracolors.Items.Count-1 do
    begin
      T := uppercase(CheckListBoxextracolors.Items[i]);

      if (T = 'K') or (T = 'BLACK') then
      Begin
        CheckListBoxextracolors.Checked[i] := true;
        if (Prefs.PlanningDefaultToMono) then
          break;
      End
      Else
      Begin
        IF ((T = 'C') OR (T = 'M') OR (T = 'Y') or (T = 'CYAN') or (T = 'MAGENTA') or (T = 'YELLOW')) and (not Prefs.PlanningDefaultToMono) then
        Begin
          CheckListBoxextracolors.Checked[i] := true;
        End;
      End;
    end;

    CheckListBoxextracolors.Visible := true;
  end;

  ComboBoxSection.Items := tNames1.sectionnames;
  ComboBoxSection.Itemindex := 0;


  if PBExListviewSections.Items.Count > 0 then
  begin
    PBExListviewSections.Selected := PBExListviewSections.Items[0];
    PBExListviewSections.Refresh;
  end;
  BitBtn1.Enabled :=  PBExListviewSections.Items.Count > 0;

  For i := 0 to PBExListviewSections.Items.Count-1 do
  begin
    while PBExListviewSections.Items[i].SubItems.Count < 6 do
      PBExListviewSections.Items[i].SubItems.Add('');
  end;

  EditFoffset.Text := '0';
  Editboffset.Text := '0';
  Editpre.Text := '';
  Editpost.Text := '';
  EditFoffset.Text := '0';
  Editboffset.Text := '0';
  Editoffset.Text := '0';
  ComboBoxcovername.Text := '';
  ComboBoxplatelayout.Items.Clear;
  ComboBoxplatelayout.Items.Add(PlatetemplateArray[plateframesdata[1].prodplates[0].templatelistid].TemplateName);
  For i := 1 to nPlatetemplateArray do
  begin
    if (PlatetemplateArray[i].PressID = plateframespressid) and
       (PlatetemplateArray[i].TemplateName <> ComboBoxplatelayout.Items[0]) then
      ComboBoxplatelayout.Items.add(PlatetemplateArray[i].TemplateName);


  end;
  ComboBoxplatelayout.itemindex := 0;
  (*
  For i := 1 to nPlatetemplateArray do
  begin
    //IF (I <> plateframesdata[1].prodplates[0].templatelistid) and (PlatetemplateArray[i].NupOnplate = 1) then
      ComboBoxplatelayout.Items.add(PlatetemplateArray[i].TemplateName);
  end;
  *)



  (*
  Formselecttemplate.Aktpressname := tnames1.pressnameIDtoname(plateframespressid);
  Formselecttemplate.PagesAcross := PlatetemplateArray[plateframesdata[1].prodplates[0].templatelistid].
  Formselecttemplate.PagesDown := -1;
  tmpli : Integer;
  Creep        : double;
  proofdeviceintemplate : boolean;
  Aktpressname : String;
  Selectedtemplatenumber,selectedtemplateid : Integer;
  Selectedcolorproofid,selectedmonoproofid,selectedPDFproofid : Integer;
  Nmarkgroups : Integer;
  markgroups  : marksarray;
  markgroupsstr : string;

  Showalltemplates : boolean;
  PagesAcross : longint;
  PagesDown   : longint;
  *)

end;

procedure TFormAddExtrapressrun.PBExListviewSectionsSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
Var
  I :Integer;
begin
  IF PBExListviewSections.selected <> nil then
  begin
    ComboBoxSection.Itemindex := 0;
    for I :=0 to ComboBoxSection.Items.Count-1 do
    begin
      if PBExListviewSections.Selected.Caption = ComboBoxSection.Items[i] then
      begin
        ComboBoxSection.Itemindex := i;
        break;
      end;
    end;
    editto.Text := PBExListviewSections.Selected.SubItems[0];
    Editpre.Text := PBExListviewSections.Selected.SubItems[1];
    Editpost.Text := PBExListviewSections.Selected.SubItems[2];

    EditFoffset.Text := PBExListviewSections.Selected.SubItems[3];
    EditBoffset.Text := PBExListviewSections.Selected.SubItems[4];
    Editoffset.Text := PBExListviewSections.Selected.SubItems[5];
    if PBExListviewSections.selected.SubItems.Count = 6 then
      PBExListviewSections.selected.SubItems.Add('');
    ComboBoxcovername.Text := PBExListviewSections.Selected.SubItems[6];

  End;
end;

procedure TFormAddExtrapressrun.BitBtn1Click(Sender: TObject);
Var
  I,p,s : Integer;
  secexists : boolean;
begin
  secexists := false;
  For i := 0 to PBExListviewSections.Items.Count-1 do
  begin
    if PBExListviewSections.Items[i].Caption = ComboBoxSection.Items[ComboBoxSection.Itemindex] then
    Begin
      secexists := true;
      break;
    end;
  end;

  Multisecplan :=  secexists;

  Nsections := PBExListviewSections.Items.Count;
  Npages := 0;
  Nsplits := 0;
  For i := 0 to PBExListviewSections.Items.Count-1 do
  Begin
    p := npagestrtonpages(PBExListviewSections.Items[i].SubItems[0],s);
    IF s > 1 then
    begin
      Inc(Nsplits,s);
    end;
    Inc(Npages,p);
  End;

  makesplitlist;
  colorType := 1;
  Ncolors := 0;
  For i := 0 to CheckListBoxextracolors.Items.count-1 do
  begin
    if CheckListBoxextracolors.checked[i] then
    Begin
      IF uppercase(CheckListBoxextracolors.Items[i]) = 'PDF' then
        colorType := 3;
      inc(Ncolors);
    End;
  end;

  IF (colortype=1) and (Ncolors > 1) then
    colortype := 2;
End;

procedure TFormAddExtrapressrun.BitBtn3Click(Sender: TObject);
Var
  I : Integer;
  l : tlistitem;
  T : string;
  Addok : boolean;
  secexists : boolean;
  Nsplit,sumofsecpage : longint;
begin

  addok := isaoknumberofpages(editto.text);
  if addok then
  begin
    addok := checkthispages(editto.text);
  end;


  sumofsecpage := 0;
  secexists := false;
  For i := 0 to PBExListviewSections.Items.count-1 do
  begin
    if PBExListviewSections.Items[i].Caption = ComboBoxSection.Items[ComboBoxSection.Itemindex] then
    Begin
      secexists := true;
      sumofsecpage := sumofsecpage + FormAddpressrun.npagestrtonpages(PBExListviewSections.Items[i].SubItems[0],Nsplit);
    end;
  end;

  IF secexists then
  begin
    IF StrToInt(Editoffset.text) < sumofsecpage then
    begin
      MessageDlg(formmain.InfraLanguage1.Translate('Offset is too low'), mtInformation,[mbOk], 0);
      addok := false;
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

    T := editto.text;
    Splitonconsec := (RadioGroupcollection.itemindex=0) and (pos(',',t) > 0);
    PBExListviewSections.selected := l;
    BitBtn1.Enabled :=  PBExListviewSections.Items.Count > 0;
    if BitBtn1.Enabled then
      BitBtn1.Enabled := checkpages;
  End;
end;

procedure TFormAddExtrapressrun.BitBtn4Click(Sender: TObject);
Var
  addok : boolean;
begin
  addok := isaoknumberofpages(editto.text);
  if addok then
    addok := checkthispages(editto.text);

  if addok then
  begin

    IF PBExListviewSections.Selected <> nil then
    begin
      PBExListviewSections.Selected.Caption := ComboBoxSection.Items[ComboBoxSection.Itemindex];

      PBExListviewSections.Selected.Subitems[0] := editto.text;
      PBExListviewSections.Selected.Subitems[1] := Editpre.text;
      PBExListviewSections.Selected.Subitems[2] := Editpost.text;
      PBExListviewSections.Selected.Subitems[3] := EditFoffset.text;
      PBExListviewSections.Selected.Subitems[4] := EditBoffset.text;
      PBExListviewSections.Selected.Subitems[5] := Editoffset.text;
      if PBExListviewSections.selected.SubItems.Count = 6 then
        PBExListviewSections.selected.SubItems.Add('');

      PBExListviewSections.Selected.Subitems[6] := ComboBoxcovername.Text;


    end;
    BitBtn1.Enabled :=  PBExListviewSections.Items.Count > 0;
    IF BitBtn1.Enabled then
    begin
      BitBtn1.Enabled := checkpages;
    End;
  End;
end;

procedure TFormAddExtrapressrun.BitBtn5Click(Sender: TObject);
begin
  IF PBExListviewSections.Selected <> nil then
    PBExListviewSections.Selected.Delete;
  BitBtn1.Enabled :=  PBExListviewSections.Items.Count > 0;
  IF BitBtn1.Enabled then
  begin
    BitBtn1.Enabled :=checkpages;
  End;
end;

Function TFormAddExtrapressrun.npagestrtonpages(commastr : string;
                                           Var Nsplit : Integer):Longint;
Var
  T : string;
  N,N2 : Integer;

Begin
  n2 := 0;
  n := 0;
  if Pos(',',commastr) > 0 then
  begin
    While Pos(',',commastr) > 0 do
    begin
      Inc(n2);
      T := Copy(commastr,1,Pos(',',commastr)-1);
      n := n + StrToInt(t);
      Commastrlist[n2] := StrToInt(t);
      Delete(commastr,1,pos(',',commastr));
    End;
    IF Length(commastr) > 0 then
    begin
      Inc(n2);
      n := n + StrToInt(commastr);
      Commastrlist[n2] := StrToInt(commastr);
    end;
  end
  else
  begin
    if commastr = '' then
      n :=  0
    else
      n := StrToInt(commastr);
    Commastrlist[1] := n;
  end;
  Nsplit := n2;
  result := n;
end;

procedure TFormAddExtrapressrun.makesplitlist;
Var
  T,commastr : string;
  N,N2,i : Integer;
Begin
  try

    Nsplitliste := 0;
    Oldstyleinsert := false;
    IF RadioGroupcollection.ItemIndex = 1 then
    begin
      Oldstyleinsert := PBExListviewSections.Items.Count > 1;
      for i := 0 to PBExListviewSections.Items.Count-1 do
      begin
        commastr := PBExListviewSections.Items[i].subitems[0];
        IF Pos(',',commastr) > 0 then
        Begin
          Oldstyleinsert := false;
        end;
      End;
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
            splitliste[Nsplitliste] := StrToInt(t);
          End;
          IF length(commastr) > 0 then
          begin
            n := n + strtoint(commastr);
            Inc(Nsplitliste);
            splitliste[Nsplitliste] := StrToInt(commastr);
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
            splitliste[Nsplitliste] := StrToInt(commastr);
          End;
        end;
      end;
    End;
  Except
  end;
end;

function TFormAddExtrapressrun.isaoknumberofpages(npaget : String):Boolean;
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

Function TFormAddExtrapressrun.checkpages:Boolean;
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

Function TFormAddExtrapressrun.checkthispages(Tpages : string):Boolean;
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
      IF (PBExListviewSections.Items.Count > 1) and (RadioGroupcollection.itemindex=1) then
      begin
        MessageDlg(formmain.InfraLanguage1.Translate('Multible inserted sections cannot be split'), mtInformation,[mbOk], 0);
        result := false;
      end;
    end;
  End;

end;



procedure TFormAddExtrapressrun.RadioGroupdoctypeClick(Sender: TObject);
Var
  I : Longint;
  T : string;
begin
  IF (Applyingpdf) or (RadioGroupdoctype.ItemIndex = 1) then
  begin
    CheckListBoxextracolors.Items.Clear;
    CheckListBoxextracolors.items.add('PDF');
    CheckListBoxextracolors.checked[0] := true;
    CheckListBoxextracolors.Visible := false;
  End
  Else
  begin
    CheckListBoxextracolors.Items.Clear;
    For I := 0 to tNames1.Colornames.Count-1 do
    begin
      IF (Uppercase(tNames1.Colornames[i]) <> 'DINKY') and (Uppercase(tNames1.Colornames[i]) <> 'PDF') then
        CheckListBoxextracolors.Items.add(tNames1.Colornames[i]);
    end;

    For i := 0 to CheckListBoxextracolors.Items.Count-1 do
    begin
      CheckListBoxextracolors.Checked[i] := false;
    End;

    For i := 0 to CheckListBoxextracolors.Items.Count-1 do
    begin
      T := uppercase(CheckListBoxextracolors.Items[i]);

      if (T = 'K') or (T = 'BLACK') then
      Begin
        CheckListBoxextracolors.Checked[i] := true;
        IF Prefs.PlanningDefaultToMono then
          break;
      End
      Else
      Begin
        IF ((T = 'C') OR (T = 'M') OR (T = 'Y') or (T = 'CYAN') or (T = 'MAGENTA') or (T = 'YELLOW')) and (not Prefs.PlanningDefaultToMono) then
        Begin
          CheckListBoxextracolors.Checked[i] := true;
        End;
      End;
    end;
    CheckListBoxextracolors.visible := true;
  end;

end;

end.





