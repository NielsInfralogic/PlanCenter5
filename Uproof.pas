unit Uproof;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;
type
  TFormproof = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel2: TPanel;
    Image1: TImage;
    Label5: TLabel;
    Label6: TLabel;
    Panel3: TPanel;
    ComboBoxsoftproof: TComboBox;
    Label1: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    Proofid   : array[0..200] of Integer;
    aktproofid : longint;
      INPressid : String;
    Selectedproofid : longint;
    MasterSelections : Tstrings;
    procedure init;
    procedure Getmasterlist;

  end;
var
  Formproof: TFormproof;
implementation
//uses Udata,umain,usettings, utypes;
uses Udata, Umain,UPlateviewframe,utypes, Upageformat, Usettings;
{$R *.dfm}
//HardProofConfigurationID
procedure TFormproof.init;
Var
  I : longint;
  aktProofID : Longint;
Begin
  INPressid := '';
  Formproof.ComboBoxsoftproof.items.clear;
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.add('SELECT ProofID,ProofName FROM ProofConfigurations');
  DataM1.Query1.SQL.add('ORDER BY ProofName');
  DataM1.Query1.open;
  While not DataM1.Query1.eof do
  begin
    ComboBoxsoftproof.items.add(DataM1.Query1.Fields[1].asstring);
    Proofid[ComboBoxsoftproof.items.count-1] := DataM1.Query1.Fields[0].AsInteger;
    DataM1.Query1.next;
  end;
  DataM1.Query1.close;
  Getmasterlist;
  aktProofID := 0;
  IF MasterSelections.count > 0 then
  begin
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.add('SELECT TOP 1 ProofID FROM PageTable WITH (NOLOCK)');
    DataM1.Query1.SQL.add('WHERE mastercopyseparationset = ' + MasterSelections[0]);
    DataM1.Query1.open;
    If not DataM1.Query1.eof then
    begin
      aktProofID := DataM1.Query1.fields[0].AsInteger;
    End;
    DataM1.Query1.close;
  end;
  if aktproofid > 0 then
  begin
    for i := 0 to ComboBoxsoftproof.items.count-1 do
    begin
      if aktproofid = Proofid[i] then
      begin
        ComboBoxsoftproof.itemindex := i;
        break;
      end;
    end;
  end;
  IF ComboBoxsoftproof.itemindex < 0 then
    ComboBoxsoftproof.itemindex := 0;
end;

procedure TFormproof.Getmasterlist;
Var
  i
  //,i2
   : Longint;
  T : String;
Begin
  try
    MasterSelections.clear;
    Case formmain.PageControlMain.ActivePageIndex of
      VIEW_SEPARATIONS :
          Begin
            for i := 1 to formmain.StringGridHS.RowCount do
            begin
              IF SuperHSdata[i-1].Selected then
              begin
                T := inttostr(SuperHSdata[i-1].mastercopyseparationset);
                if MasterSelections.IndexOf(T) < 0 then
                begin
                  MasterSelections.add(T);
                end;
              End;
            end;
          End;
      VIEW_THUMBNAILS :
          Begin
            For i := 0 to formmain.PBExListviewthumbnail.items.count-1 do
            begin
              IF formmain.PBExListviewthumbnail.items[i].Selected  then
              begin
                T := inttostr(Showthubms[formmain.PBExListviewthumbnail.items[i].Index].Mastercopyseparationset);
                if MasterSelections.IndexOf(T) < 0 then
                begin
                  MasterSelections.add(T);
                end;
              End;
            End;
          End;
      VIEW_PLATES :
          Begin
            IF Viewselected > -1 then
            begin
              For i := 0 to Views[Viewselected].LPV.items.count-1 do
              begin
                IF Views[Viewselected].LPV.items[i].Selected then
                begin
                  DataM1.Query3.SQL.Clear;
                  DataM1.Query3.SQL.add('select distinct mastercopyseparationset from pagetable WITH (NOLOCK)');
                  DataM1.Query3.SQL.add('where CopyFlatSeparationSet = ' + inttostr(Views[Viewselected].platesData[i].CopyFlatSeparationSet));
                  //DataM1.Query3.SQL.add('and pressid in ' + INPressid);
                  DataM1.Query3.open;
                  While not DataM1.Query3.eof do
                  begin
                    T := DataM1.Query3.Fields[0].asstring;
                    if MasterSelections.IndexOf(T) < 0 then
                    begin
                      MasterSelections.add(T);
                    end;
                    DataM1.Query3.next;
                  end;
                  DataM1.Query3.close;
                end;
              End;
            end;
          End;
      VIEW_PRODUCTIONS :
          Begin
            For i := 1 to formmain.StringGridprods.rowcount do
            begin
              if StringGridprodsdata[I].Selected then
              begin
                DataM1.Query3.SQL.Clear;
                DataM1.Query3.SQL.add('select distinct mastercopyseparationset from pagetable WITH (NOLOCK)');
                DataM1.Query3.SQL.add('where pressrunid = ' + inttostr(StringGridprodsdata[I].pressrunid));
                DataM1.Query3.open;
                While not DataM1.Query3.eof do
                begin
                  T := DataM1.Query3.Fields[0].asstring;
                  if MasterSelections.IndexOf(T) < 0 then
                  begin
                    MasterSelections.add(T);
                  end;
                  DataM1.Query3.next;
                end;
                DataM1.Query3.close;
              end;
            end;
          End;
    End;

  Except
  End;
End;


procedure TFormproof.BitBtn1Click(Sender: TObject);
begin
  Selectedproofid     := Formproof.Proofid[ComboBoxsoftproof.itemindex];

end;
procedure TFormproof.FormCreate(Sender: TObject);
begin
  MasterSelections := TStringList.Create;
end;


end.

