unit Uaddeditions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons;

type
  TFormAddeditionview = class(TForm)
    Panel1: TPanel;
    ListBox1: TListBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    RadioGrouptype: TRadioGroup;
    GroupBox1: TGroupBox;
    RadioGroupunique: TRadioGroup;
    RadioGroupcommon: TRadioGroup;
    RadioGroupdevice: TRadioGroup;
    RadioGrouphold: TRadioGroup;
    GroupBoxedtimming: TGroupBox;
    CheckBoxtimmed: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    firstrun : Boolean;
  public
    wherestr : string;
    { Public declarations }
  end;

var
  FormAddeditionview: TFormAddeditionview;

implementation
Uses
  usettings, Udata,umain;

{$R *.dfm}

procedure TFormAddeditionview.FormCreate(Sender: TObject);
begin
  firstrun := true;
end;

procedure TFormAddeditionview.FormActivate(Sender: TObject);
Var
  I : longint;
  LocationID : Integer;
begin

  CheckBoxtimmed.checked := false;
  GroupBoxedtimming.Visible := dbversion > 1;
  if firstrun then
  begin
    RadioGrouptype.ItemIndex := Prefs.AddEditionDefaultUniqueType;
   // RadioGroupunique.ItemIndex := Prefs.AddEditionDefaultApprovalUniquePage;
    RadioGroupcommon.ItemIndex := Prefs.AddEditionDefaultApprovalCommonPage;
    RadioGroupdevice.ItemIndex := Prefs.AddEditionDefaultKeepDevice;
   // RadioGrouphold.ItemIndex := Prefs.AddEditionDefaultHold;
    firstrun := false;
  end;

  if wherestr <> '' then
  begin
    if (FormMain.ComboBoxpalocationNY.Enabled) then
      LocationID := tnames1.locationnametoid(formmain.ComboBoxpalocationNY.Text)
    else
      LocationID := -1;
    DataM1.Query1.SQL.Clear;
    datam1.Query1.SQL.Add('Select distinct EditionID from pagetable WITH (NOLOCK) ');
    datam1.Query1.SQL.Add(wherestr);
    if (LocationID > 0) then
      datam1.Query1.SQL.Add('and locationid = ' + IntToStr(LocationID));

    datam1.Query1.Open;
    while not datam1.Query1.Eof do
    begin
      for i := 0 to ListBox1.Items.Count-1 do
      begin
        if (tnames1.editionIDtoname(datam1.Query1.Fields[0].AsInteger) = ListBox1.Items[i]) then
        begin
          ListBox1.Items.Delete(i);
          break;
        end;
      end;
      datam1.Query1.next;
    end;
    datam1.Query1.close;
  end;
end;

end.
