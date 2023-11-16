unit UReProcess;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, SqlExpr, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  PBExListview;

const
  NOCHANGEITEM     = 'No change';

type
  TPreprossestype = Record
                      Name    : String;
                      ID      : Longint;

                    end;

  TFormReprocesspages = class(TForm)
    Panelsys: TPanel;
    BitBtn1: TBitBtn;
    GroupBoxpreflight: TGroupBox;
    ComboBoxPreflight: TComboBox;
    GroupBoxRipsetup: TGroupBox;
    ComboBoxRipsetup: TComboBox;
    GroupBoxInksave: TGroupBox;
    ComboBoxInksave: TComboBox;
    GroupBoxpress: TGroupBox;
    ComboBoxpress: TComboBox;
    BitBtn2: TBitBtn;
    GroupBox1: TGroupBox;
    ComboBoxPageformat: TComboBox;
    CheckBoxDeleteExistingPage: TCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    ItsAtreeMenu : Boolean;
    ProductionID : Longint;
    Pressrunid   : Longint;
    PublicationID : Longint;
    SectionID     : Longint;
    Pubdate : Tdatetime;
    INPressid : String;

    RipsetupDBstr : String;
    RipsetupDBID : Longint;


    NRipSetupNames : Longint;
    NInksaveSetupNames : Longint;
    NPreflightSetupNames : Longint;

    RipSetupNames : Array of TPreprossestype;
    InksaveSetupNames : Array of TPreprossestype;
    PreflightSetupNames : Array of TPreprossestype;
    MasterSelections : Tstrings;
    procedure Setdefs;
    procedure SetCurrentSets;
    procedure GetCurrentSets;
    procedure MakepressInids;
    procedure Getmasterlist;
    Function init(fromtree : boolean):Boolean;
    Procedure findselection;
    Procedure LoadProcesssystems;

  end;

var
  FormReprocesspages: TFormReprocesspages;

implementation


{$R *.dfm}
Uses
  Udata, Umain,UPlateviewframe,utypes, Upageformat, Usettings, UUtils;

(*
I PageTable:

Felt RipSetupID (int)

DWORD n = dwRipSetupIDFraPageTable;
int nRipSetupID = n & 0x0000FF;
int nPreflightSetupID = (n & 0x00FF00) >> 8;
int nSaveinkSetupID = (n & 0xFF0000) >> 16;

Eksempel:
dwRipSetupIDFraPageTable=0x020101 (131329)
nRipSetupID = 1
nPreflightSetupID = 1
nSaveinkSetupID = 2




I PublicationTemplates..

Felt RipSetup er en string..(pis)

De tre setups er sammensat med semikolon:

"RipSetup;PreflightSetup;InksaveSetup"
Eksempel "Std;Std;Bypass"


Planning Er Det en pdf plan s� er bit 2 i seperate runs sat

*)





procedure TFormReprocesspages.FormActivate(Sender: TObject);
begin
//  FormReprocesspages.Resizing();
  ComboBoxPreflight.Align := alclient;
  ComboBoxInksave.Align := alclient;
  ComboBoxRipsetup.Align := alclient;
  ComboBoxpress.Align := alclient;
  ComboBoxPageformat.Align := alclient;
end;

procedure TFormReprocesspages.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  Resize := true;
end;


Procedure TFormReprocesspages.findselection;
Begin

end;

Function TFormReprocesspages.init(fromtree : boolean):Boolean;

Var
  T : String;
  I : Longint;

Begin
  result := false;
  INPressid := '';
  SectionID := -1;
  ItsAtreeMenu := fromtree;
  Formpageformats.load;
  ComboBoxPageformat.Items.Clear;
  IF Formpageformats.ListView1.Items.Count > 0 then
  Begin
    For i := 0 to Formpageformats.ListView1.Items.Count-1 do
    begin
      ComboBoxPageformat.Items.add(Formpageformats.ListView1.Items[i].Caption);
    end;

  end;
  ComboBoxPageformat.Items.Add(NOCHANGEITEM);
  ComboBoxPageformat.Itemindex := ComboBoxPageformat.Items.Count-1;


  try

    Case formmain.PageControlMain.ActivePageIndex of
      VIEW_SEPARATIONS :
          begin
            if formmain.TreeViewpagelist.Selected = nil then
              exit;
            if formmain.TreeViewpagelist.Selected.Level < 2 then
              exit;
            PublicationID := TTreeViewpagestype(formmain.TreeViewpagelist.Selected.data^).publicationid;
            Pubdate       := TTreeViewpagestype(formmain.TreeViewpagelist.Selected.data^).pubdate;
            if formmain.TreeViewpagelist.Selected.Level > 3 then
              SectionID := TTreeViewpagestype(formmain.TreeViewpagelist.Selected.data^).sectionid;
          end;
      VIEW_THUMBNAILS :
          begin
            if formmain.TreeViewThumbs.Selected = nil then
              exit;
            if formmain.TreeViewThumbs.Selected.Level < 2 then
              exit;
            PublicationID := TTreeViewpagestype(formmain.TreeViewThumbs.Selected.data^).publicationid;
            Pubdate       := TTreeViewpagestype(formmain.TreeViewThumbs.Selected.data^).pubdate;
            if formmain.TreeViewThumbs.Selected.Level > 3 then
              SectionID := TTreeViewpagestype(formmain.TreeViewThumbs.Selected.data^).sectionid;
          end;
      VIEW_PLATES :
          begin
            if formmain.TreeViewPlateview.Selected = nil then
              exit;
            if formmain.TreeViewPlateview.Selected.Level < 2 then
              exit;
            PublicationID := TTreeViewpagestype(formmain.TreeViewPlateview.Selected.data^).publicationid;
            Pubdate       := TTreeViewpagestype(formmain.TreeViewPlateview.Selected.data^).pubdate;
            if formmain.TreeViewPlateview.Selected.Level > 3 then
              SectionID := TTreeViewpagestype(formmain.TreeViewPlateview.Selected.data^).sectionid;
          end;
      VIEW_PRODUCTIONS :
          begin
            if formmain.TreeViewprodcontrol.Selected = nil then
              exit;
            if formmain.TreeViewprodcontrol.Selected.Level < 2 then
              exit;
            PublicationID := TTreeViewpagestype(formmain.TreeViewprodcontrol.Selected.data^).publicationid;
            Pubdate       := TTreeViewpagestype(formmain.TreeViewprodcontrol.Selected.data^).pubdate;
            if formmain.TreeViewprodcontrol.Selected.Level > 3 then
              SectionID := TTreeViewpagestype(formmain.TreeViewprodcontrol.Selected.data^).sectionid;

          end;

    end;

    ComboBoxpress.items.clear;
    IF Pressvisibilylimited then
    begin
      ComboBoxpress.items.add(formmain.ComboBoxPressGrp.Text);
      ComboBoxpress.itemindex := 0;
    end
    Else
    begin
      T := '(-99';
      DataM1.Query3.SQL.Clear;
      DataM1.Query3.SQL.add('select Distinct pressid from pagetable WITH (NOLOCK)');
      DataM1.Query3.SQL.add('where publicationid = '+inttostr(PublicationID));
      DataM1.Query3.SQL.add(' and ' + DataM1.makedatastr('',pubdate));
      DataM1.Query3.SQL.add('Order by Pressid');
      IF Prefs.debug then datam1.Query3.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'reprocesspregp1.sql');
      DataM1.Query3.Open;
      while not DataM1.Query3.Eof do
      begin
        T := T+','+DataM1.Query3.Fields[0].AsString;
        if (Prefs.LocationPressFilterMode = LOCATIONPRESSSFILTERMODE_PRESS) then
            ComboBoxpress.items.add(DataM1.Query3.Fields[0].AsString);
        DataM1.Query3.Next;
      end;
      T := T + ')';

      DataM1.Query3.Close;

      if (Prefs.LocationPressFilterMode = LOCATIONPRESSSFILTERMODE_PRESSGROUP) then
      begin
        DataM1.Query3.SQL.Clear;
        DataM1.Query3.SQL.Add('select Distinct PressGroupName from PressGroupNames');
        DataM1.Query3.SQL.Add('where pressid IN '+T);
        DataM1.Query3.SQL.Add('Order by PressGroupName');
        IF Prefs.debug then datam1.Query3.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'reprocesspregp2.sql');
        DataM1.Query3.Open;
        While not DataM1.Query3.Eof do
        begin
          ComboBoxpress.items.add(DataM1.Query3.Fields[0].AsString);
          DataM1.Query3.Next;
        end;
      end;
      DataM1.Query3.Close;

    end;
    ComboBoxpress.itemindex := 0;
    MakepressInids;
    LoadProcesssystems;
  Except
    result := false;
  end;
end;

procedure TFormReprocesspages.LoadProcesssystems;
begin
  Try
    ComboBoxPreflight.items.clear;
    ComboBoxInksave.items.clear;
    ComboBoxRipsetup.items.clear;
    MasterSelections.clear;

    NRipSetupNames := 0;
    NInksaveSetupNames  := 0;
    NPreflightSetupNames  := 0;
    Setlength(RipSetupNames,1);
    Setlength(InksaveSetupNames,1);
    Setlength(PreflightSetupNames,1);

    DataM1.Query3.SQL.Clear;
    DataM1.Query3.SQL.Add('select COUNT(DISTINCT RipSetupID) from RipSetupNames');
    DataM1.Query3.Open;
    if not DataM1.Query3.Eof then
    begin
      NRipSetupNames := DataM1.Query3.fields[0].AsInteger;
    end;
    DataM1.Query3.Close;

    Setlength(RipSetupNames,NRipSetupNames+10);
    NRipSetupNames := 0;
    DataM1.Query3.SQL.Clear;
    DataM1.Query3.SQL.Add('select RipSetupID,[Name] from RipSetupNames');
    DataM1.Query3.SQL.Add('Order by Name');
    DataM1.Query3.Open;
    while not DataM1.Query3.Eof do
    begin
      Inc(NRipSetupNames);
      RipSetupNames[NRipSetupNames].ID := DataM1.Query3.fields[0].AsInteger;
      RipSetupNames[NRipSetupNames].Name := DataM1.Query3.fields[1].AsString;
      ComboBoxRIPSetup.Items.Add(RIPSetupNames[NRIPSetupNames].Name);
      DataM1.Query3.Next;
    end;
    DataM1.Query3.Close;


    IF InkSaveSetupNamesPossible then
    begin
      DataM1.Query3.SQL.Clear;
      DataM1.Query3.SQL.Add('select COUNT(DISTINCT InksaveSetupID) from InksaveSetupNames');
      DataM1.Query3.Open;
      IF not DataM1.Query3.Eof then
      begin
        NInksaveSetupNames := DataM1.Query3.fields[0].AsInteger;
      end;
      DataM1.Query3.Close;

      Setlength(InksaveSetupNames,NInksaveSetupNames+10);

      NInksaveSetupNames := 0;
      DataM1.Query3.SQL.Clear;
      DataM1.Query3.SQL.Add('select InksaveSetupID,Name from InksaveSetupNames');
      DataM1.Query3.SQL.Add('Order by Name');
      DataM1.Query3.Open;
      While not DataM1.Query3.Eof do
      begin
        Inc(NInksaveSetupNames);
        InksaveSetupNames[NInksaveSetupNames].ID := DataM1.Query3.fields[0].AsInteger;
        InksaveSetupNames[NInksaveSetupNames].Name := DataM1.Query3.fields[1].AsString;
        ComboBoxInksave.items.add(InksaveSetupNames[NInksaveSetupNames].Name);
        DataM1.Query3.Next;
      end;
      DataM1.Query3.Close;

    end;

    IF PreflightSetupNamesPossible then
    begin
      DataM1.Query3.SQL.Clear;
      DataM1.Query3.SQL.Add('select COUNT(DISTINCT PreflightSetupID) from PreflightSetupNames');
      DataM1.Query3.Open;
      IF not DataM1.Query3.Eof then
      begin
        NPreflightSetupNames := DataM1.Query3.fields[0].AsInteger;
      end;
      DataM1.Query3.Close;

      Setlength(PreflightSetupNames,NPreflightSetupNames+10);

      NPreflightSetupNames := 0;
      DataM1.Query3.SQL.Clear;
      DataM1.Query3.SQL.Add('select PreflightSetupID,Name from PreflightSetupNames');
      DataM1.Query3.SQL.Add('Order by Name');
      DataM1.Query3.Open;
      While not DataM1.Query3.Eof do
      begin
        Inc(NPreflightSetupNames);
        PreflightSetupNames[NPreflightSetupNames].ID := DataM1.Query3.fields[0].AsInteger;
        PreflightSetupNames[NPreflightSetupNames].Name := DataM1.Query3.fields[1].AsString;
        ComboBoxPreflight.items.add(PreflightSetupNames[NPreflightSetupNames].Name);
        DataM1.Query3.Next;
      end;
      DataM1.Query3.Close;

    end;

    Getmasterlist();
    Setdefs();
    GetCurrentSets();


  Except
  end;
End;



procedure TFormReprocesspages.FormCreate(Sender: TObject);
begin
  MasterSelections := TStringList.Create;
end;

procedure TFormReprocesspages.Getmasterlist;
Var
  i : Integer;
  T : String;
Begin
  try
    MakepressInids;
    MasterSelections.clear;
    Case formmain.PageControlMain.ActivePageIndex of
      VIEW_SEPARATIONS :
          begin
            for i := 1 to formmain.StringGridHS.RowCount do
            begin
              if SuperHSdata[i-1].Selected then
              begin
                T := inttostr(SuperHSdata[i-1].mastercopyseparationset);
                if MasterSelections.IndexOf(T) < 0 then
                begin
                  MasterSelections.add(T);
                end;
              end;
            end;
          end;
      VIEW_THUMBNAILS :
          begin
            for i := 0 to formmain.PBExListviewthumbnail.items.count-1 do
            begin
              if formmain.PBExListviewthumbnail.items[i].Selected  then
              begin
                T := inttostr(Showthubms[formmain.PBExListviewthumbnail.items[i].Index].Mastercopyseparationset);
                if MasterSelections.IndexOf(T) < 0 then
                begin
                  MasterSelections.add(T);
                end;
              end;
            end;
          end;
      VIEW_PLATES :
          begin
            if Viewselected > -1 then
            begin
              for i := 0 to Views[Viewselected].LPV.Items.Count-1 do
              begin
                if Views[Viewselected].LPV.items[i].Selected then
                begin
                  DataM1.Query3.SQL.Clear;
                  DataM1.Query3.SQL.Add('select distinct mastercopyseparationset from pagetable WITH (NOLOCK)');
                  DataM1.Query3.SQL.Add('where CopyFlatSeparationSet = ' + IntToStr(Views[Viewselected].platesData[i].CopyFlatSeparationSet));
                  DataM1.Query3.SQL.Add('and pressid in ' + INPressid);

                  DataM1.Query3.Open;
                  while not DataM1.Query3.Eof do
                  begin
                    T := DataM1.Query3.Fields[0].AsString;
                    if MasterSelections.IndexOf(T) < 0 then
                    begin
                      MasterSelections.Add(T);
                    end;
                    DataM1.Query3.Next;
                  end;
                  DataM1.Query3.Close;
                end;
              end;
            end;
          end;
      VIEW_PRODUCTIONS :
          begin
            for i := 1 to formmain.StringGridprods.rowcount do
            begin
              if StringGridprodsdata[I].Selected then
              begin
                DataM1.Query3.SQL.Clear;
                DataM1.Query3.SQL.Add('select distinct mastercopyseparationset from pagetable WITH (NOLOCK)');
                DataM1.Query3.SQL.Add('where pressrunid = ' + inttostr(StringGridprodsdata[I].pressrunid));
                DataM1.Query3.Open;
                while not DataM1.Query3.Eof do
                begin
                  T := DataM1.Query3.Fields[0].AsString;
                  if MasterSelections.IndexOf(T) < 0 then
                  begin
                    MasterSelections.Add(T);
                  end;
                  DataM1.Query3.Next;
                end;
                DataM1.Query3.Close;
              end;
            end;
          end;
    end;


  except
  end;
end;


procedure TFormReprocesspages.MakepressInids;

Begin

  begin

    if (Prefs.LocationPressFilterMode = LOCATIONPRESSSFILTERMODE_PRESSGROUP) then
    begin
      INPressid := '(-99';
      DataM1.Query3.Close;
      DataM1.Query3.SQL.Clear;
         DataM1.Query3.SQL.Add('select Distinct Pressid from PressGroupNames');
         DataM1.Query3.SQL.Add('where PressGroupName = '+''''+ComboBoxpress.text+'''');
      DataM1.Query3.SQL.Add('Order by pressid');

      if Prefs.debug then datam1.Query3.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'reprocesspregp2.sql');
      DataM1.Query3.Open;
      While not DataM1.Query3.Eof do
      begin
        INPressid := INPressid +','+DataM1.Query3.fields[0].AsString;
        DataM1.Query3.Next;
      end;
      DataM1.Query3.Close;

       INPressid := INPressid +')';
    end
    else
    begin
        INPressid := '(' + IntToStr(tNames1.pressnametoid(ComboBoxpress.text)) +')';
    end;

  end
End;


procedure TFormReprocesspages.GetCurrentSets;
Var
  aktPagetableRipSetupID,i : Integer;
  aktRipSetup,aktinksave,aktpreflight : Integer;
  aktPageFormatID : Integer;

  (*
  DWORD n = dwRipSetupIDFraPageTable;
int nRipSetupID = n & 0x0000FF;
int nPreflightSetupID = (n & 0x00FF00) >> 8;
int nSaveinkSetupID = (n & 0xFF0000) >> 16;

  *)
Begin
  aktPageFormatID := 0;
  aktPagetableRipSetupID := 0;
  if MasterSelections.Count > 0 then
  begin
    DataM1.Query3.SQL.Clear;
    DataM1.Query3.SQL.Add('SELECT TOP 1 RipSetupID,PageFormatID FROM PageTable WITH (NOLOCK)');
    DataM1.Query3.SQL.Add('WHERE mastercopyseparationset = ' + MasterSelections[0]);
    DataM1.Query3.Open;
    if not DataM1.Query3.Eof then
    begin
      aktPagetableRipSetupID := DataM1.Query3.Fields[0].AsInteger;
      aktPageFormatID := DataM1.Query3.Fields[1].AsInteger;
    End;
    DataM1.Query3.Close;
  end
  else
  begin
    DataM1.Query3.SQL.Clear;
    DataM1.Query3.SQL.Add('SELECT DISTINCT RipSetupID,PageFormatID,PageIndex FROM PageTable WITH (NOLOCK)');
    DataM1.Query3.SQL.Add('WHERE publicationid = ' + IntToStr(PublicationID));
    DataM1.Query3.SQL.Add(' AND ' + DataM1.makedatastr('',pubdate));
    if (SectionID > 0) then
      DataM1.Query3.SQL.Add(' AND SectionID = ' + IntToStr(SectionID));
    DataM1.Query3.SQL.Add('Order by pageindex');
    if Prefs.debug then datam1.Query3.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'Getaktripsetp.sql');
    DataM1.Query3.Open;
    if not DataM1.Query3.Eof then
    begin
      aktPagetableRipSetupID := DataM1.Query3.Fields[0].AsInteger;
      aktPageFormatID := DataM1.Query3.Fields[1].AsInteger;
    end;
    DataM1.Query3.Close;
  end;

  aktRipSetup := aktPagetableRipSetupID and $FF;
  aktpreflight := (aktPagetableRipSetupID and $FF00) shr 8;
  aktinksave := (aktPagetableRipSetupID and $FF0000) shr 16;

  for i := 0 to NRipSetupNames do
  begin
    if RipSetupNames[i].ID = aktRipSetup then
    begin
      ComboBoxRipsetup.ItemIndex := ComboBoxRipsetup.Items.IndexOf(RipSetupnames[i].Name);
      break;
    end;
  end;

  for i := 0 to NinksaveSetupNames do
  begin
    if inksaveSetupNames[i].ID = aktinksave then
    begin
      ComboBoxinksave.ItemIndex := ComboBoxinksave.Items.IndexOf(inksavesetupnames[i].Name);
      break;
    end;
  end;

  for i := 0 to NpreflightSetupNames do
  begin
    if preflightSetupNames[i].ID = aktpreflight then
    begin
      ComboBoxpreflight.ItemIndex := ComboBoxpreflight.Items.IndexOf(preflightsetupnames[i].Name);
      break;
    end;
  end;

  // 20180921 - make sure pageformat is still 'no change' if not set in pagetable already
  if (aktPageFormatID <> 0) then
  begin
    for i := 0 to Formpageformats.ListView1.Items.Count-1 do
    begin
      if aktPageFormatID = StrToInt(Formpageformats.ListView1.Items[i].SubItems[3]) then
      begin
        ComboBoxPageformat.ItemIndex := ComboBoxPageformat.Items.IndexOf(Formpageformats.ListView1.Items[i].Caption);
        break;
      end;
    end;
  end
  else
    ComboBoxPageformat.ItemIndex := ComboBoxPageformat.Items.IndexOf(NOCHANGEITEM);

End;



procedure TFormReprocesspages.SetCurrentSets;
Var
  i,pageformatid : Integer;
  aktRipSetup,aktinksave,aktpreflight : Integer;
Begin
  try
    aktRipSetup := 0;
    aktinksave := 0;
    aktpreflight := 0;
    pageformatid := -1;

    if (ComboBoxPageformat.ItemIndex < ComboBoxPageformat.Items.Count-1)
            and (Formpageformats.ListView1.Items.Count > 0) then
    begin
      for i := 0 to Formpageformats.ListView1.Items.Count-1 do
      begin
        if ComboBoxPageformat.Text = Formpageformats.ListView1.Items[i].Caption then
        begin
          pageformatid := StrToInt(Formpageformats.ListView1.Items[i].SubItems[3]);
          break;
        end;
      end;

    end;

    for i := 0 to NRipSetupNames do
    begin
      if RipSetupNames[i].Name = ComboBoxRipsetup.Text then
      Begin
        aktRipSetup := RipSetupnames[i].Id;
        break;
      end;
    end;

    for i := 0 to NinksavesetupNames do
    begin
      if inksavesetupNames[i].Name = ComboBoxinksave.Text then
      Begin
        aktinksave := inksavesetupnames[i].Id SHL 16;
        break;
      end;
    end;

    for i := 0 to NpreflightsetupNames do
    begin
      IF preflightsetupNames[i].Name = ComboBoxpreflight.Text then
      begin
        aktpreflight := preflightsetupnames[i].Id SHL 8;
        break;
      end;
    end;
    RipsetupDBstr := '';

    RipsetupDBID := aktinksave + aktpreflight + aktRipSetup;

    if MasterSelections.Count > 0 then
    begin
      for i := 0 to MasterSelections.Count-1 do
      begin

        if Pageformatinpagetable then
        begin
          DataM1.Query3.SQL.Clear;
          DataM1.Query3.SQL.Add('update pagetable');
          DataM1.Query3.SQL.Add('set RipSetupID = ' + IntToStr(RipsetupDBID));
          if (pageformatid > 0) and (Pageformatinpagetable) then
          begin
            DataM1.Query3.SQL.Add(', pageformatid = ' + IntToStr(pageformatid));
          end;

          DataM1.Query3.SQL.Add('where mastercopyseparationset = ' + MasterSelections[i]);
          DataM1.Query3.ExecSql;
        end
        else if pageformatid > 0 then
        begin
          DataM1.Query3.SQL.Clear;
          DataM1.Query3.SQL.Add('Select distinct pressrunid from pagetable');
          DataM1.Query3.SQL.Add('where mastercopyseparationset = ' + MasterSelections[i]);
          DataM1.Query3.Open;
          while not DataM1.Query3.Eof do
          begin

            DataM1.Query2.SQL.Clear;
            DataM1.Query2.SQL.Add('update pressrunid');
            DataM1.Query2.SQL.Add('set miscint1 = ' + IntToStr(pageformatid));
            DataM1.Query2.SQL.Add('where pressrunid = ' + IntToStr(DataM1.Query3.fields[0].AsInteger));
            DataM1.Query2.ExecSQL;

            DataM1.Query3.Next;
          end;
          DataM1.Query3.Close;
        End;
      End;
    end
    else
    begin
      MakepressInids();
      DataM1.Query3.SQL.Clear;
      DataM1.Query3.SQL.Add('update pagetable');
      DataM1.Query3.SQL.Add('set RipSetupID = ' + IntToStr(RipsetupDBID));
      if (pageformatid > 0) and (Pageformatinpagetable) then
      begin
        DataM1.Query3.SQL.Add(', pageformatid = ' + IntToStr(pageformatid));
      end;
      DataM1.Query3.SQL.Add('where publicationid = '+IntToStr(PublicationID));
      DataM1.Query3.SQL.Add('and pressid in ' + INPressid);
      if SectionID > 0 then
        DataM1.Query3.SQL.Add('and SectionID = '+IntToStr(SectionID));
      DataM1.Query3.SQL.Add(' and ' + DataM1.makedatastr('',pubdate));
      DataM1.Query3.ExecSql;
    end;

    for i := 0 to MasterSelections.count-1 do
    begin
      datam1.Query1.Close;
      datam1.Query1.SQL.Clear;
      datam1.Query1.SQL.Add('Insert FileCenterRetryQueue values('+MasterSelections[i]+',GETDATE())');
      datam1.Query1.ExecSQL;

      if (Prefs.DecreaseVersion) then
      begin
        datam1.Query1.SQL.Clear;
        datam1.Query1.SQL.Add('Update pagetable set version = version -1  ');
        DataM1.Query1.SQL.Add('where mastercopyseparationset = ' + MasterSelections[i]);
        DataM1.Query1.SQL.Add('and version > 0');
        datam1.Query1.ExecSQL;
      End;

      if (CheckBoxDeleteExistingPage.Checked) then
      begin
        Datam1.Query1.SQL.Clear;
        Datam1.Query1.SQL.Add('UPDATE pagetable SET Status = 0, InkStatus=0, ProofStatus=0, Version=0');
        DataM1.Query1.SQL.Add('WHERE mastercopyseparationset = ' + MasterSelections[i]);
        DataM1.Query1.SQL.Add('AND Status > 0');
        datam1.Query1.ExecSQL;
      end;

    end;
  Except
  end;

End;

procedure TFormReprocesspages.Setdefs;
Var
  Defrip :String;
  DefInksave :String;
  T,Defpreflight,DefPageFormat :String;

Begin
  try
    Defrip :='';
    DefInksave := '';
    Defpreflight := '';
    DefPageFormat := '';

    DataM1.Query3.SQL.Clear;
    DataM1.Query3.SQL.Add('select Distinct RipSetup from PublicationTemplates');
    DataM1.Query3.SQL.Add('Where publicationid = '+ IntToStr(publicationid));

    DataM1.Query3.Open;
    IF not DataM1.Query3.Eof THEN
    begin
      T := DataM1.Query3.Fields[0].AsString;
    end;
    DataM1.Query3.Close;


    if Length(T) > 0 then
    begin
      Defrip := Copy(t,1,pos(';',t)-1);
      Delete(t,1,pos(';',t));

      Defpreflight := Copy(t,1,pos(';',t)-1);
      Delete(t,1,pos(';',t));

      DefInksave := Copy(t,1,100);

    end;
    ComboBoxRipsetup.ItemIndex := ComboBoxRipsetup.Items.IndexOf(defRip);
    ComboBoxinksave.ItemIndex := ComboBoxinksave.Items.IndexOf(definksave);
    ComboBoxPreflight.ItemIndex := ComboBoxPreflight.Items.IndexOf(defPreflight);

    IF ComboBoxRipsetup.itemindex < 0 then
      ComboBoxRipsetup.itemindex := 0;
    IF ComboBoxinksave.itemindex < 0 then
      ComboBoxinksave.itemindex := 0;
    IF ComboBoxRipsetup.itemindex < 0 then
      ComboBoxRipsetup.itemindex := 0;
    IF ComboBoxPreflight.itemindex < 0 then
      ComboBoxPreflight.itemindex := 0;

    T:= '';
    DataM1.Query3.SQL.Clear;
    DataM1.Query3.SQL.Add('SELECT TOP 1 PF.PageFormatName FROM PublicationNames PN INNER JOIN PageFormatNames PF ON PF.PageFormatID=PN.PageFormatID');
    DataM1.Query3.SQL.Add('WHERE PublicationID = '+ IntToStr(publicationid));

    DataM1.Query3.Open;
    if not DataM1.Query3.Eof then
    begin
      T := DataM1.Query3.Fields[0].AsString;
    end;
    DataM1.Query3.Close;

    if (T <> '') then
      ComboBoxPageFormat.ItemIndex := ComboBoxPageFormat.Items.IndexOf(T);

  Except
  end;
End;

procedure TFormReprocesspages.BitBtn1Click(Sender: TObject);
begin
  SetCurrentSets();
end;

end.

