unit Uchlayout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls;

type
  TFormChlayout = class(TForm)
    ListBox1: TListBox;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBoxspecifikcopy: TGroupBox;
    ComboBoxcopynumber: TComboBox;
    ListViewtmpl: TListView;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ListViewtmplSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
  private
    { Private declarations }
  public
    allowMerge : Boolean;
    akttmpl : Longint;
    Aktpressname : String;
    Curtemplate : string;
    Newtemplatelistid : Longint;
    Allowtoshowdiv2 : Longint;
    Mustbetwoup : Boolean;
    { Public declarations }
  end;

var
  FormChlayout: TFormChlayout;

implementation

{$R *.dfm}
Uses
  utypes,
  umain, Usettings;
procedure TFormChlayout.FormActivate(Sender: TObject);
Var
  I : Integer;
  AktpressID   : Integer;
  tmplOK : Boolean;
  l : Tlistitem;

begin
  ComboBoxcopynumber.itemindex := 0;
  For I := 1 to NPlatetemplateArray do
  begin
    IF PlatetemplateArray[I].TemplateName = Curtemplate then
    Begin
      akttmpl := i;
      break;
    End;
  End;

  listbox1.Items.clear;
  ListViewtmpl.items.Clear;
  ListViewtmpl.items.BeginUpdate;
  AktpressID := 0;
  AktpressID := tNames1.pressnametoid(Aktpressname);
  For I := 1 to NPlatetemplateArray do
  begin
    tmplOK := false;
    IF (PlatetemplateArray[I].PressID = AktpressID) and (PlatetemplateArray[I].ISdouble = PlatetemplateArray[akttmpl].ISdouble) then
    begin
      if ((Mustbetwoup) and (PlatetemplateArray[I].NupOnplate = 2)) then
      begin
        tmplOK := true;
      end
      else
      begin
         if (PlatetemplateArray[I].PagesAcross = PlatetemplateArray[akttmpl].PagesAcross) and
            (PlatetemplateArray[I].PagesDown = PlatetemplateArray[akttmpl].PagesDown) then
         begin
           tmplOK := true;
         end;
         if (Allowtoshowdiv2 = PlatetemplateArray[I].NupOnplate) then
         begin
           tmplOK := true;
         end;
         if (not tmplOK) and ((Prefs.AllowApplyPlateMerge) And (allowMerge)) then
         begin
           if PlatetemplateArray[I].NupOnplate = PlatetemplateArray[akttmpl].NupOnplate * 2 then
             tmplOK := true;
         End;
      end;
      if tmplOK then
      begin
        listbox1.Items.add(PlatetemplateArray[I].TemplateName);
        l := ListViewtmpl.items.add;
        l.Caption := PlatetemplateArray[I].TemplateName;

        l.SubItems.Add(inttostr(PlatetemplateArray[I].PagesAcross));
        l.SubItems.Add(inttostr(PlatetemplateArray[I].PagesDown));
      end;

    end;
  end;
  ListViewtmpl.items.endUpdate;
  BitBtn1.Enabled := false;

end;

procedure TFormChlayout.BitBtn1Click(Sender: TObject);
Var
  I : Integer;
  selI : Integer;
begin
  selI := -1;
  for i := 0 to ListViewtmpl.items.count-1 do
  begin
    if ListViewtmpl.items[i].Selected then
    begin
      selI := i;
      break;
    end;
  end;

  Newtemplatelistid := -1;

  if selI > -1 then
  begin
    For I := 1 to NPlatetemplateArray do
    begin
      IF (PlatetemplateArray[I].PressID = tNames1.pressnametoid(Aktpressname)) and
         (PlatetemplateArray[I].TemplateName = ListViewtmpl.items[selI].Caption) then
      begin
        Newtemplatelistid := i;
      end;
    End;
  end;
end;

procedure TFormChlayout.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  GroupBoxspecifikcopy.visible := false;
  Allowtoshowdiv2 := -1;
end;

procedure TFormChlayout.FormCreate(Sender: TObject);
begin
  Allowtoshowdiv2 := -1;
  Mustbetwoup := false;
end;

procedure TFormChlayout.ListViewtmplSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  BitBtn1.enabled := true;
end;

end.
