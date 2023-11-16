unit UChangeplatelayout;

interface

uses
  utypes,Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CheckLst, StdCtrls, ExtCtrls, Buttons;

type
  TFormchangeplatelayout = class(TForm)
    Panel2: TPanel;
    Image1: TImage;
    Label6: TLabel;
    Label12: TLabel;
    PanelYesNO: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox1: TGroupBox;
    Splitter1: TSplitter;
    ListBox1: TListBox;
    CheckListBoxmarkgrp: TCheckListBox;
    CheckBoxOnsamesheet: TCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    procedure loadmarks;
    Function compatibletemplates(newtmpl : integer;
                                 oldtmpl : integer):boolean;

  public
    { Public declarations }
    tmpli : Integer;
    Creep        : double;
    aktnup : Integer;
    akttempllistnumber : Integer;
    Aktpressname : String;
    Selectedtemplatenumber,selectedtemplateid : Integer;
    Nmarkgroups : Integer;
    markgroups  : marksarray;
  end;

var
  Formchangeplatelayout: TFormchangeplatelayout;

implementation
uses
  DateUtils,
  umain, Usettings, Uaddplan, Uproof;

{$R *.dfm}


Function TFormchangeplatelayout.compatibletemplates(newtmpl : integer;
                                                    oldtmpl : integer):boolean;
Var
  compat : boolean;
  newStanding,oldstanding : Boolean;
Begin
  compat := true;
  result := true;
  oldStanding := true;
  if ((PlatetemplateArray[oldtmpl].PageRotationList[1]) mod 2 = 0) then
  begin
    //siderne skal stå op
    IF PlatetemplateArray[oldtmpl].IncomingPageRotationEven mod 2 = 0 then
    begin
      oldStanding := true;
    End
    Else
    begin
      oldStanding := false;
    end;
  End
  else
  begin
    IF PlatetemplateArray[oldtmpl].IncomingPageRotationEven mod 2 = 0 then
    begin
      oldStanding := false;
    End
    Else
    begin
      oldStanding := true;
    end;
  end;

  newStanding := true;
  if ((PlatetemplateArray[newtmpl].PageRotationList[1]) mod 2 = 0) then
  begin
    //siderne skal stå op
    IF PlatetemplateArray[newtmpl].IncomingPageRotationEven mod 2 = 0 then
    begin
      newStanding := true;
    End
    Else
    begin
      newStanding := false;
    end;
  End
  else
  begin
    IF PlatetemplateArray[newtmpl].IncomingPageRotationEven mod 2 = 0 then
    begin
      newStanding := false;
    End
    Else
    begin
      newStanding := true;
    end;
  end;


  if newStanding <> oldStanding then
    compat := false;

  if PlatetemplateArray[newtmpl].NupOnplate <> aktnup then
    compat := false;

  result := compat;

end;
procedure TFormchangeplatelayout.FormActivate(Sender: TObject);

Var
  I : Integer;
  AktpressID   : Integer;

  deadl : Tdatetime;

  Year, Month, Day: Word;
begin
  listbox1.Items.clear;
  AktpressID := tNames1.pressnametoid(Aktpressname);
  BitBtn1.Enabled := false;
  For I := 1 to NPlatetemplateArray do
  begin
    IF (PlatetemplateArray[I].PressID = AktpressID) and (compatibletemplates(i,akttempllistnumber)) and (I <> akttempllistnumber)  then
    begin
      listbox1.Items.add(PlatetemplateArray[I].TemplateName);
    end;
  end;
  if listbox1.Items.Count > 0 then
  begin
    listbox1.ItemIndex := tmpli;
    if ListBox1.ItemIndex < 0 then
      ListBox1.ItemIndex := 0;
    Formchangeplatelayout.loadmarks;
    BitBtn1.Enabled := true;
  End;
  if listbox1.Items.Count = 0 then
  begin
    beep;
    MessageDlg(formmain.InfraLanguage1.Translate('There are no other templates that fit this press and this number of pages'), mtInformation,
      [mbOk], 0);

  end;
end;


procedure TFormchangeplatelayout.loadmarks;
Var
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
  End;



end;


procedure TFormchangeplatelayout.ListBox1Click(Sender: TObject);
begin
  Formchangeplatelayout.loadmarks;
  if ListBox1.ItemIndex > -1 then
    BitBtn1.Enabled := true;

end;

procedure TFormchangeplatelayout.BitBtn1Click(Sender: TObject);
Var
  I : Integer;
begin


  For i := 1 to NPlatetemplateArray do
  begin
    if listbox1.Items[listbox1.Itemindex] = PlatetemplateArray[I].TemplateName then
    begin
      Selectedtemplatenumber := i;
      selectedtemplateid     := PlatetemplateArray[I].TemplateID;
      break;
    end;
  End;
  tmpli := listbox1.ItemIndex;
  Nmarkgroups :=0;

  For i := 0 to CheckListBoxmarkgrp.items.count-1 do
  begin
    IF CheckListBoxmarkgrp.checked[i] then
    begin
      inc(Nmarkgroups);
      markgroups[Nmarkgroups] := inittypes.marknametoid(CheckListBoxmarkgrp.items[i]);
    end;
  end;

end;
end.
