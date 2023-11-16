unit USelecttemplate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  utypes,Dialogs, ComCtrls, ExtCtrls, StdCtrls, Buttons, CheckLst, Menus;

type
  TFormselecttemplate = class(TForm)
    GroupBox1: TGroupBox;
    ListBox1: TListBox;
    Panelproof: TPanel;
    Panelwizard: TPanel;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    Label4: TLabel;
    ComboBoxstackpos: TComboBox;
    Splitter1: TSplitter;
    Panel2: TPanel;
    Image1: TImage;
    Label6: TLabel;
    Label12: TLabel;
    Label9: TLabel;
    ComboBoxproof: TComboBox;
    Panelmovepress: TPanel;
    Image2: TImage;
    Label5: TLabel;
    Label7: TLabel;
    Panel3: TPanel;
    Image3: TImage;
    Label8: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    ComboBoxproofcolor: TComboBox;
    Panel4: TPanel;
    Image4: TImage;
    Label15: TLabel;
    Label16: TLabel;
    Panel1: TPanel;
    CheckListBoxmarkgrp: TCheckListBox;
    Label2: TLabel;
    ComboBoxHWtempl: TComboBox;
    PopupMenumark: TPopupMenu;
    Setall1: TMenuItem;
    Clearall1: TMenuItem;
    ComboBoxproofPDF: TComboBox;
    Label13: TLabel;
    Label3: TLabel;
    EditCreep: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EditCreepExit(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Setall1Click(Sender: TObject);
    procedure Clearall1Click(Sender: TObject);
  private

    { Private declarations }
  public
    tmpli : Integer;
    Creep        : double;
    proofdeviceintemplate : boolean;
    Aktpressname : String;
    Aktpressid,aktpublicationid : Longint;
    Selectedtemplatenumber,selectedtemplateid : Integer;
    Selectedcolorproofid,selectedmonoproofid,selectedPDFproofid : Integer;
    Nmarkgroups : Integer;
    markgroups  : marksarray;
    markgroupsstr : string;
    applydeftemplatename : string;
    applydefproofname : string;
    Showalltemplates : boolean;
    PagesAcross : longint;
    PagesDown   : longint;
    procedure Setresultdata;
    procedure loadmarks;
    procedure init;
    procedure Setpublicationdefaults;
  end;

var
  Formselecttemplate: TFormselecttemplate;

implementation
uses
  DateUtils,
  umain, Usettings, Uaddplan, Uproof, UApplyplan, Uaddpressrun, Udata, UUtils;
{$R *.dfm}

procedure TFormselecttemplate.FormActivate(Sender: TObject);
Begin
  init;

end;
procedure TFormselecttemplate.init;
Var
  I : Integer;
  AktpressID,usedefindex   : Integer;

  deadl : Tdatetime;

  Year, Month, Day: Word;

begin
  BitBtn4.enabled := true;
  deadl := Formaddplan.DateTimePicker1.DateTime;
  DecodeDate(deadl,Year, Month, Day);
  deadl := EncodeDateTime(Year, Month, Day,0,0,0,0);
  deadl := IncHour(deadl,1);

  ComboBoxproof.Items.clear;
  ComboBoxproof.Items := Formproof.ComboBoxsoftproof.Items;

  ComboBoxproofcolor.Items.clear;
  ComboBoxproofcolor.Items := Formproof.ComboBoxsoftproof.Items;

  ComboBoxproofpdf.Items.clear;
  ComboBoxproofpdf.Items := Formproof.ComboBoxsoftproof.Items;

  if (Prefs.PlanningDefaultColorProofer <> '') then
  begin
    ComboBoxproofcolor.Itemindex := ComboBoxproofcolor.Items.IndexOf(Prefs.PlanningDefaultColorProofer);
  end;

  if (Prefs.PlanningDefaultPDFProofer <> '') then
  begin
    ComboBoxproofpdf.Itemindex := ComboBoxproofpdf.Items.IndexOf(Prefs.PlanningDefaultPDFProofer);
  end;

  if (Prefs.PlanningDefatulMonoProofer <> '') then
  begin
    ComboBoxproof.Itemindex := ComboBoxproof.Items.IndexOf(Prefs.PlanningDefatulMonoProofer);
  end;

  IF ComboBoxproofcolor.Itemindex = -1 then
    ComboBoxproofcolor.Itemindex := 0;
  IF ComboBoxproof.Itemindex = -1 then
    ComboBoxproof.Itemindex := 0;



  IF applydefproofname <> '' then
  begin
    ComboBoxproofcolor.Itemindex := ComboBoxproofcolor.Items.IndexOf(applydefproofname);
    ComboBoxproof.Itemindex := ComboBoxproof.Items.IndexOf(applydefproofname);
    ComboBoxproofPDF.Itemindex := ComboBoxproofPDF.Items.IndexOf(applydefproofname);
  end;



  listbox1.Items.clear;
  AktpressID := tNames1.pressnametoid(Aktpressname);


  For I := 1 to NPlatetemplateArray do
  begin
    IF PlatetemplateArray[I].PressID = AktpressID then
    begin
      IF PagesAcross <> -1 then
      begin
        IF ((PagesAcross = PlatetemplateArray[I].PagesAcross) and (PagesDown = PlatetemplateArray[I].PagesDown)) OR (Showalltemplates) then
        begin
          listbox1.Items.add(PlatetemplateArray[I].TemplateName);
        end;
      end
      else
      Begin
        listbox1.Items.add(PlatetemplateArray[I].TemplateName);
      end;
    end;
  end;

  usedefindex := 0;
  usedefindex := tmpli;
  listbox1.ItemIndex := tmpli;
  if ListBox1.Items.count > 0 then
  Begin
    if Formselecttemplate.applydeftemplatename <> '' then
    begin
      usedefindex := listbox1.Items.IndexOf(Formselecttemplate.applydeftemplatename);
    end;
    ListBox1.ItemIndex := usedefindex;
  end;

  ComboBoxHWtempl.Items.Clear;
  ComboBoxHWtempl.Items := listbox1.Items;
  ComboBoxHWtempl.ItemIndex := ListBox1.ItemIndex;


  Formselecttemplate.loadmarks;


  IF listbox1.Items.Count = 0 then
  begin
    MessageDlg(formmain.InfraLanguage1.Translate('There are no templates for this imposition use planning to make a new plan for the production on the press'), mtInformation,[mbOk], 0);
    BitBtn4.enabled := false;
  end
  Else
  begin
    Setpublicationdefaults;
  end;


  IF Globalsystemtype = 3 then
  begin
    Formselecttemplate.Caption := 'Proof setup';
    Panel2.Visible := false;
    Panelmovepress.Visible := false;
    Panel3.Visible := false;
    Panel4.Visible := false;
    GroupBox1.Visible := false;
    Panelproof.Visible := false;
    Panelwizard.Align := altop;
    Formselecttemplate.AutoSize := true;

  end;

    Label3.Visible := not Prefs.SimplePlanLoad;
  EditCreep.Visible := not Prefs.SimplePlanLoad;

end;

procedure TFormselecttemplate.BitBtn1Click(Sender: TObject);
Var
  I : Integer;
begin
  Creep := 0;
  try
    Creep := strtofloat(editcreep.text);
    FormApplyproduction.Editcreep.Text := editcreep.text;
    FormApplyproduction.Creep := Creep;
  except
  end;
  For i := 1 to NPlatetemplateArray do
  begin
    if (listbox1.Items[listbox1.Itemindex] = PlatetemplateArray[I].TemplateName) and
       (tnames1.pressnametoid(Aktpressname) = PlatetemplateArray[I].pressid)  then
    begin
      Selectedtemplatenumber := i;
      break;
    end;
  End;
  tmpli := listbox1.ItemIndex;
  Showalltemplates := false;
end;

procedure TFormselecttemplate.BitBtn4Click(Sender: TObject);
Begin
  Setresultdata;

end;


procedure TFormselecttemplate.Setresultdata;
Var
  I : Integer;
begin
  Creep := 0;
  Creep := strtofloat(editcreep.text);
  try
    Creep := strtofloat(editcreep.text);
    FormApplyproduction.Editcreep.Text := editcreep.text;
    FormApplyproduction.Creep := Creep;
  except
  end;
  For i := 1 to NPlatetemplateArray do
  begin
    if (listbox1.Items[listbox1.Itemindex] = PlatetemplateArray[I].TemplateName) and
       (tnames1.pressnametoid(Aktpressname) = PlatetemplateArray[I].pressid) then
    begin
      Selectedtemplatenumber := i;
      selectedtemplateid     := PlatetemplateArray[I].TemplateID;
      FormAddpressrun.nup := PlatetemplateArray[I].NupOnplate;
      FormAddpressrun.CheckBoxprepaired.Checked := PlatetemplateArray[I].Platecut and 8 = 8;
      break;
    end;
  End;
  tmpli := listbox1.ItemIndex;
  Nmarkgroups :=0;
  proofdeviceintemplate := PlatetemplateArray[Selectedtemplatenumber].proofdeviceintemplate;
  For i := 0 to CheckListBoxmarkgrp.items.count-1 do
  begin
    IF CheckListBoxmarkgrp.checked[i] then
    begin
      inc(Nmarkgroups);
      markgroups[Nmarkgroups] := inittypes.marknametoid(CheckListBoxmarkgrp.items[i]);
    end;
  end;

  markgroupsstr := inittypes.marksIDstr(Nmarkgroups,markgroups);

  selectedmonoproofid  := tnames1.proofnametoid(ComboBoxproof.Text);
  Selectedcolorproofid := tnames1.proofnametoid(ComboBoxproofcolor.Text);
  selectedPDFproofid  := tnames1.proofnametoid(ComboBoxproofPDF.Text);
end;

procedure TFormselecttemplate.FormCreate(Sender: TObject);
begin
  tmpli := 0;
  Showalltemplates := false;

  Label3.Visible := not Prefs.SimplePlanLoad;
  EditCreep.Visible := not Prefs.SimplePlanLoad;

end;

procedure TFormselecttemplate.EditCreepExit(Sender: TObject);
Var
  code : Integer;
  f : single;
  T : string;
begin
  code := -1;
  try
    t := EditCreep.Text;
    val(T,f,code);
  Except
  end;
  if code <> 0 then
  begin
    beep;
    MessageDlg(formmain.InfraLanguage1.Translate('the value') +' ' + t +' ' +formmain.InfraLanguage1.Translate('is not a valid decimal value'), mterror,[mbOk], 0);
    EditCreep.Text := '0';
  end;
end;

procedure TFormselecttemplate.ListBox1Click(Sender: TObject);
Begin
  Formselecttemplate.loadmarks;
  ComboBoxHWtempl.ItemIndex := ListBox1.ItemIndex;
end;

procedure TFormselecttemplate.loadmarks;
Var
  T : string;
  I,itmp : Integer;
begin

  CheckListBoxmarkgrp.Items.Clear;
  IF ListBox1.Itemindex > -1 then
  begin
    for i := 1 to NPlatetemplateArray do
    begin
      IF PlatetemplateArray[I].TemplateName = ListBox1.Items[ListBox1.Itemindex] then
      begin
        itmp := i;
        break;
      end;
    End;



    For i := 1 to PlatetemplateArray[itmp].Nmarkgroups do
    begin
      CheckListBoxmarkgrp.Items.add(inittypes.markIDtoname(PlatetemplateArray[itmp].markgroups[i]));
    end;
    For i := 0 to CheckListBoxmarkgrp.Items.Count-1 do
    begin
      CheckListBoxmarkgrp.Checked[i] := Prefs.PlanningDefaultUseAllMarkGroups;
    end;

    IF Length(Prefs.DefMarksList) > 0 then
    begin
      For i := 0 to CheckListBoxmarkgrp.Items.Count-1 do
      begin
        CheckListBoxmarkgrp.Checked[i] := false;
      end;
      For i := 0 to Length(Prefs.DefMarksList)-1 do
      begin
        itmp := CheckListBoxmarkgrp.Items.IndexOf(Prefs.DefMarksList[i]);
        if itmp >= 0 then
          CheckListBoxmarkgrp.checked[itmp] := true;
      End;
    end;
  End;
end;


procedure TFormselecttemplate.Setpublicationdefaults;
Var
  I,im,ip,AmrkID : Longint;
  T,TM : String;
  Found,namedmarkgroup : Boolean;

  Alist : TStrings;
Begin
  Alist := TStringList.Create;
  try
    IF (Aktpressid > -1) AND (aktpublicationid > -1) and (PublicationTemplatesPossible) then
    begin
      DataM1.Query1.sql.clear;

      DataM1.Query1.sql.add('Select pl.TemplateID,pl.Markgroups,tc.TemplateName from PublicationTemplates pl, TemplateConfigurations tc');
      DataM1.Query1.sql.add('where pl.pressid = '+ inttostr(Aktpressid));
      DataM1.Query1.sql.add('and pl.publicationid = '+ inttostr(aktpublicationid));
      DataM1.Query1.sql.add('and pl.templateid = tc.templateid');

      try
        found := false;
        if Prefs.debug then DataM1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'Getpubldefaults.sql');
        DataM1.Query1.open;
        IF Not DataM1.Query1.eof then
        begin
          For i := 0 to ListBox1.items.Count-1 do
          begin
            IF ListBox1.items[i] = DataM1.Query1.fields[2].asstring then
            begin
              ListBox1.ItemIndex := i;
              T := DataM1.Query1.fields[1].asstring;
              found := true;
              Break;
            end;
          end;
         end;
         DataM1.Query1.close;

         IF found then
         begin
           loadmarks;

           for i := 0 to CheckListBoxmarkgrp.Items.Count-1 do
             CheckListBoxmarkgrp.Checked[i] := false;

           namedmarkgroup := false;
           For i := 1 to length(T) do
           begin
             if Not ((T[i] in tal) or (T[i] = ',')) then
             begin
               namedmarkgroup := true;
             end;
           end;

           IF (T <> '') and (CheckListBoxmarkgrp.Items.Count > 0) then
           begin
             I := 0;
             while (T <> '') And (i < 1000) do
             begin
               if pos(',',T) > 0 then
               begin
                 TM := copy(T,1,pos(',',T)-1);
                 delete(T,1,pos(',',T));
               end
               else
               begin
                 TM := T;
                 T := '';
               end;
               alist.Add(tm);
               inc(i);
             end;
           End;
           IF  Not namedmarkgroup then
           begin
             For i := 0 to alist.count-1 do
             begin
               AmrkID := strtoint(alist[i]);
               alist[i] := inittypes.markIDtoname(AmrkID);
             end;
           end;
           for i := 0 to CheckListBoxmarkgrp.Items.Count-1 do
           Begin
             for im := 0 to alist.count-1 do
             begin
               IF alist[im] = CheckListBoxmarkgrp.Items[i] then
               begin
                 CheckListBoxmarkgrp.Checked[i] := true;
                 break;
               end;
             end;
           end;

         end;



       Except
       end;
    End;
  finally
    alist.free;
  end;
end;

procedure TFormselecttemplate.Setall1Click(Sender: TObject);
Var
  I : Longint;
begin
  For i := 0 to CheckListBoxmarkgrp.Items.Count-1 do
    CheckListBoxmarkgrp.Checked[i] := true;
end;

procedure TFormselecttemplate.Clearall1Click(Sender: TObject);
Var
  I : Longint;
begin
  For i := 0 to CheckListBoxmarkgrp.Items.Count-1 do
    CheckListBoxmarkgrp.Checked[i] := false;
end;

end.

