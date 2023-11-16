unit UReProcessSimple;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, SqlExpr, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  PBExListview;

type
  TPreprossestype = Record
                      Name    : String;
                      ID      : Longint;
                    end;

  TFormReprocessSimple = class(TForm)
    Panelsys: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBoxpreflight: TGroupBox;
    ComboBoxPreflight: TComboBox;
    GroupBoxRipsetup: TGroupBox;
    ComboBoxRipsetup: TComboBox;
    GroupBoxInksave: TGroupBox;
    ComboBoxInksave: TComboBox;

    procedure FormActivate(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer; var Resize: Boolean);
    procedure BitBtn1Click(Sender: TObject);

  private
    { Private declarations }

  public
    { Public declarations }

    RipsetupDBID : Longint;

    NRipSetupNames : Longint;
    NInksaveSetupNames : Longint;
    NPreflightSetupNames : Longint;

    RipSetupNames : Array of TPreprossestype;
    InksaveSetupNames : Array of TPreprossestype;
    PreflightSetupNames : Array of TPreprossestype;

    Procedure Init(RipSetupIDFromPageTable : Longint; PublicationID : LongInt; PressID : LongInt);
    Procedure LoadProcesssystems;
    procedure SetCombos(aktPagetableRipSetupID : LongInt; PublicationID : LongInt; PressID : LongInt);
    procedure  GetCurrentSelection;

  end;

var
  FormReprocessSimple: TFormReprocessSimple;

implementation


{$R *.dfm}
Uses
  Udata, Umain,UPlateviewframe,utypes, Upageformat, Usettings;


procedure TFormReprocessSimple.FormActivate(Sender: TObject);
begin
//  FormReprocesspages.Resizing();
  ComboBoxPreflight.Align := alclient;
  ComboBoxInksave.Align := alclient;
  ComboBoxRipsetup.Align := alclient;

end;

procedure TFormReprocessSimple.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  (*beep;
  NewHeight := GroupBoxpress.Height + GroupBoxpreflight.Height + GroupBoxInksave.Height + GroupBoxRipsetup.Height +   Panelsys.Height +
               FormReprocesspages.
  NewWidth := width;
  *)
  Resize := true;

end;



Procedure TFormReprocessSimple.Init(RipSetupIDFromPageTable : Longint; PublicationID : LongInt; PressID : LongInt);

//Var
//  T : String;
//  I : Longint;

Begin
  RipsetupDBID := RipSetupIDFromPageTable;
  LoadProcesssystems;
  SetCombos(RipSetupIDFromPageTable, PublicationID, PressID);
End;

Procedure TFormReprocessSimple.LoadProcesssystems;
Var
  PreflightSetupPossible,InksaveSetupPossible : Boolean;
//  T : string;
//  I,i2 : Longint;
Begin
  Try
    ComboBoxPreflight.items.clear;
    ComboBoxInksave.items.clear;
    ComboBoxRipsetup.items.clear;


    DataM1.Query3.SQL.Clear;
    DataM1.Query3.SQL.Add('SELECT * FROM dbo.sysobjects');
    DataM1.Query3.SQL.Add('WHERE name = ' + ''''+'PreflightSetupNames'+'''');
    DataM1.Query3.Open;
    PreflightSetupPossible := not DataM1.Query3.eof;
    DataM1.Query3.Close;

    DataM1.Query3.SQL.Clear;
    DataM1.Query3.SQL.Add('SELECT * FROM dbo.sysobjects');
    DataM1.Query3.SQL.Add('WHERE Name = ' + ''''+'InksaveSetupNames'+'''');
    DataM1.Query3.Open;
    InksaveSetupPossible := not DataM1.Query3.eof;
    DataM1.Query3.Close;

    NRipSetupNames := 0;
    NInksaveSetupNames  := 0;
    NPreflightSetupNames  := 0;

    Setlength(RipSetupNames,100);
    Setlength(InksaveSetupNames,100);
    Setlength(PreflightSetupNames,100);

    DataM1.Query3.SQL.Clear;
    DataM1.Query3.SQL.Add('SELECT RipSetupID,Name FROM RipSetupNames ORDER BY RipSetupID');
    DataM1.Query3.Open;
    While not DataM1.Query3.Eof do
    begin
      Inc(NRipSetupNames);
      RipSetupNames[NRipSetupNames].ID := DataM1.Query3.fields[0].AsInteger;
      RipSetupNames[NRipSetupNames].Name := DataM1.Query3.fields[1].AsString;
      ComboBoxRIPSetup.items.add(RIPSetupNames[NRIPSetupNames].Name);
      DataM1.Query3.Next;
    end;
    DataM1.Query3.Close;

    if (InksaveSetupPossible) then
    begin
      DataM1.Query3.SQL.Clear;
      DataM1.Query3.SQL.Add('SELECT InksaveSetupID,Name FROM InksaveSetupNames ORDER BY InksaveSetupID');
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

    IF PreflightSetupPossible then
    begin
      DataM1.Query3.SQL.Clear;
      DataM1.Query3.SQL.add('SELECT PreflightSetupID,Name from PreflightSetupNames ORDER BY PreflightSetupID');
      DataM1.Query3.Open;
      While not DataM1.Query3.eof do
      begin
        Inc(NPreflightSetupNames);
        PreflightSetupNames[NPreflightSetupNames].Name := DataM1.Query3.fields[1].AsString;
        PreflightSetupNames[NPreflightSetupNames].ID := DataM1.Query3.fields[0].AsInteger;
        ComboBoxPreflight.items.add(PreflightSetupNames[NPreflightSetupNames].Name);
        DataM1.Query3.Next;
      end;
      DataM1.Query3.Close;
    end;


  Except
  end;
End;



procedure TFormReprocessSimple.SetCombos(aktPagetableRipSetupID : LongInt; PublicationID : LongInt; PressID : LongInt);
Var
  aktRipSetup,aktinksave,aktpreflight,i : Longint;
  T, defRip, Defpreflight, DefInksave : String;
Begin

  if (aktPagetableRipSetupID > 0) then
  begin
    aktRipSetup := aktPagetableRipSetupID and $FF;
    aktpreflight := (aktPagetableRipSetupID and $FF00) shr 8;
    aktinksave := (aktPagetableRipSetupID and $FF0000) shr 16;

    For i := 0 to NRipSetupNames do
    begin
      IF RipSetupNames[i].ID = aktRipSetup then
      Begin
        ComboBoxRipsetup.itemindex := ComboBoxRipsetup.items.IndexOf(RipSetupnames[i].Name);
        break;
      end;
    end;

    For i := 0 to NinksaveSetupNames do
    begin
      IF inksaveSetupNames[i].ID = aktinksave then
      Begin
        ComboBoxinksave.itemindex := ComboBoxinksave.items.IndexOf(inksavesetupnames[i].Name);
        break;
      end;
    end;

    For i := 0 to NpreflightSetupNames do
    begin
      IF preflightSetupNames[i].ID = aktpreflight then
      Begin
        ComboBoxpreflight.itemindex := ComboBoxpreflight.items.IndexOf(preflightsetupnames[i].Name);
        break;
      end;
    end;

  end
  else
  begin
    DataM1.Query3.SQL.Clear;
    DataM1.Query3.SQL.Add('SELECT TOP 1 RipSetup FROM PublicationTemplates');
    DataM1.Query3.SQL.Add('WHERE Publicationid = '+ inttostr(PublicationID));
    DataM1.Query3.SQL.Add('AND PressID = '+ inttostr(PressID));

    DataM1.Query3.Open;
    IF not DataM1.Query3.eof THEN
    begin
      T := DataM1.Query3.fields[0].AsString;
    end;
    DataM1.Query3.Close;

    IF Length(T) > 0 then
    begin
      Defrip := Copy(t,1,pos(';',t)-1);
      Delete(t,1,pos(';',t));

      Defpreflight := Copy(t,1,pos(';',t)-1);
      Delete(t,1,pos(';',t));

      DefInksave := Copy(t,1,100);
    end;
    ComboBoxRipsetup.itemindex := ComboBoxRipsetup.items.IndexOf(defRip);
    ComboBoxinksave.itemindex := ComboBoxinksave.items.IndexOf(definksave);
    ComboBoxPreflight.itemindex := ComboBoxPreflight.items.IndexOf(defPreflight);

  end;

    IF ComboBoxRipsetup.itemindex < 0 then
      ComboBoxRipsetup.itemindex := 0;
    IF ComboBoxinksave.itemindex < 0 then
      ComboBoxinksave.itemindex := 0;
    IF ComboBoxRipsetup.itemindex < 0 then
      ComboBoxRipsetup.itemindex := 0;
    IF ComboBoxPreflight.itemindex < 0 then
      ComboBoxPreflight.itemindex := 0;


End;



procedure TFormReprocessSimple.GetCurrentSelection;
Var
  aktRipSetup,aktinksave,aktpreflight,i,RipsetupDBID : Longint;
Begin

  RipsetupDBID := 0;
  aktRipSetup := 0;
  aktinksave := 0;
  aktpreflight := 0;
  try
    For i := 0 to NRipSetupNames do
    begin
      IF RipSetupNames[i].name = ComboBoxRipsetup.text then
      Begin
        aktRipSetup := RipSetupnames[i].id;
        break;
      end;
    end;
    For i := 0 to NinksavesetupNames do
    begin
      IF inksavesetupNames[i].name = ComboBoxinksave.text then
      Begin
        aktinksave := inksavesetupnames[i].id;
        break;
      end;
    end;
    For i := 0 to NpreflightsetupNames do
    begin
      IF preflightsetupNames[i].name = ComboBoxpreflight.text then
      Begin
        aktpreflight := preflightsetupnames[i].id;
        break;
      end;
    end;

    RipsetupDBID := aktRipSetup + (aktpreflight * 256) + (aktinksave * 256 * 256);

  Except
  end;
End;


procedure TFormReprocessSimple.BitBtn1Click(Sender: TObject);
begin
  GetCurrentSelection;
end;

end.
