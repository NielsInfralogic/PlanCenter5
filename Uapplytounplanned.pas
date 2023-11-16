unit Uapplytounplanned;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls;

type
  TFormapplytounplanned = class(TForm)
    Panel3: TPanel;
    Image3: TImage;
    Label8: TLabel;
    Label10: TLabel;
    Panel1: TPanel;
    BitBtn3: TBitBtn;
    BitBtn1: TBitBtn;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Image1: TImage;
    Image2: TImage;
    RadioButtonwizard: TRadioButton;
    RadioButtonload: TRadioButton;
    GroupBox2: TGroupBox;
    ComboBoxpress: TComboBox;
    Panelautocalc: TPanel;
    CheckBoxrecalcall: TCheckBox;
    EditMaxrpessrunsize: TEdit;
    Label1: TLabel;
    UpDown1: TUpDown;
    CheckBox2: TCheckBox;
    GroupBox3: TGroupBox;
    ListBoxSecorder: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure ListBoxSecorderDragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ListBoxSecorderStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure ListBoxSecorderDragDrop(Sender, Source: TObject; X,
      Y: Integer);
  private
    { Private declarations }
    activated : boolean;
    Drkfrom : Longint;
//    procedure moveup;
//    Procedure movedown;

  public
    { Public declarations }
  end;

var
  Formapplytounplanned: TFormapplytounplanned;

implementation

uses Usettings, Umain,uprodplan,utypes,uplanframe, Udata;

{$R *.dfm}

procedure TFormapplytounplanned.FormCreate(Sender: TObject);
begin
  activated := false;
end;

procedure TFormapplytounplanned.FormActivate(Sender: TObject);
Var
  anyapplied : Boolean;
  Apressrunid,i : Longint;
 // T,N : String;
begin
  Apressrunid := 0;
  Panelautocalc.visible := formprodplan.PartialPlanning;
  Formapplytounplanned.Realign;

  if (not activated) then
  begin
    activated := true;
    RadioButtonload.Checked    := not Prefs.UnplannedApplyDefaultMethodToWizard;
    RadioButtonwizard.Checked  := Prefs.UnplannedApplyDefaultMethodToWizard;
  end;

  ComboBoxpress.items.Clear;

  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('Select distinct PressName from pressnames where locationid = '+IntToStr(plateframeslocationid));
  DataM1.Query1.SQL.Add('order by PressName');
  DataM1.Query1.Open;
  While not DataM1.Query1.Eof do
  begin
    ComboBoxpress.Items.add(DataM1.Query1.Fields[0].AsString);
    DataM1.Query1.Next;
  end;
  DataM1.Query1.Close;
  ComboBoxpress.ItemIndex := ComboBoxpress.Items.IndexOf(tnames1.pressnameIDtoname(plateframespressid));

  IF (formprodplan.PartialPlanning) then
  Begin
    anyapplied := false;
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('Select distinct pr.pressrunid,pr.plantype,pa.productionid from pressrunid pr, pagetable pa');
    DataM1.Query1.SQL.Add('where pa.productionid = ' +IntToStr(plateframesproductionid));
    DataM1.Query1.SQL.Add('and pa.pressrunid = pr.pressrunid ');
    DataM1.Query1.SQL.Add('and pr.plantype > 0');
    DataM1.Query1.open;
    IF Not DataM1.Query1.eof then
    begin
      Apressrunid := DataM1.Query1.fields[0].asinteger;
      anyapplied := true;
    end;
    DataM1.Query1.close;

    ListBoxSecorder.items.clear;
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('Select distinct Sectionid from pagetable');
    DataM1.Query1.SQL.Add('where productionid = ' +IntToStr(plateframesproductionid));
    DataM1.Query1.SQL.Add('order by Sectionid');
    DataM1.Query1.Open;
    While Not DataM1.Query1.eof do
    begin
      ListBoxSecorder.items.add( tnames1.sectionIDtoname(DataM1.Query1.fields[0].asinteger)  );
      DataM1.Query1.next;
    end;
    DataM1.Query1.close;

    if (anyapplied) and (Apressrunid > 0) then
    begin
      CheckBoxrecalcall.Checked := false;
      DataM1.Query1.SQL.Clear;
      DataM1.Query1.SQL.Add('select count(distinct separationset) from pagetable ');
      DataM1.Query1.SQL.Add('where pressrunid = '+IntToStr(Apressrunid));
      DataM1.Query1.SQL.Add('and pagetype <> 3 ');
      DataM1.Query1.Open;
      IF Not DataM1.Query1.eof then
      begin
        EditMaxrpessrunsize.Text := DataM1.Query1.fields[0].asstring;
        UpDown1.Position := DataM1.Query1.fields[0].asinteger;
      End;
      DataM1.Query1.close;
    end
    Else
    Begin
      CheckBoxrecalcall.checked := true;
      for i := 0 to Length(Prefs.MaxPagesPerPress)-1 do
      begin
        if ComboBoxpress.Text = Prefs.MaxPagesPerPress[i].Key then
        begin
          EditMaxrpessrunsize.Text := Prefs.MaxPagesPerPress[i].Value;
          UpDown1.Position := strtoint(Prefs.MaxPagesPerPress[i].Value);
          break;
        end;

      end;
    End;
  End;

end;


procedure TFormapplytounplanned.BitBtn3Click(Sender: TObject);
begin
  if ComboBoxpress.text <> tnames1.pressnameIDtoname(plateframespressid) then
    plateframespressid := tnames1.pressnametoid(ComboBoxpress.text);
end;


procedure TFormapplytounplanned.ListBoxSecorderDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := true;
end;


{procedure TFormapplytounplanned.moveup;
//Var
//  i,x : INteger;
begin
(*
  IF ListBox1.ItemIndex > 0 then
  begin
    x := HSOrder[ListBox1.ItemIndex];
    HSOrder[ListBox1.ItemIndex] := HSOrder[ListBox1.ItemIndex-1];
    HSOrder[ListBox1.ItemIndex-1] := x;

    I := ListBox1.ItemIndex;
    ListBox1.Items.Move(ListBox1.ItemIndex,ListBox1.ItemIndex-1);
    ListBox1.ItemIndex := i-1;
    ListBox1.SetFocus;
  end;
  *)
end;
}
{Procedure TFormapplytounplanned.movedown;
//Var
//  i,x : INteger;
begin
  (*
  IF ListBox1.ItemIndex < ListBox1.Items.Count-1 then
  begin
    I := ListBox1.ItemIndex;
    x := HSOrder[ListBox1.ItemIndex];
    HSOrder[ListBox1.ItemIndex] := HSOrder[ListBox1.ItemIndex+1];
    HSOrder[ListBox1.ItemIndex+1] := x;

    ListBox1.Items.Move(ListBox1.ItemIndex,ListBox1.ItemIndex+1);
    ListBox1.ItemIndex := i+1;
    ListBox1.SetFocus;
  end;
  *)
end;
}


procedure TFormapplytounplanned.ListBoxSecorderStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  Drkfrom := ListBoxSecorder.itemindex;
end;

procedure TFormapplytounplanned.ListBoxSecorderDragDrop(Sender,
  Source: TObject; X, Y: Integer);
var
  APoint: TPoint;
  Index: integer;

begin
  APoint.X := X;
  APoint.Y := Y;
  Index := ListBoxSecorder.ItemAtPos(APoint, True);
  if Index <> Drkfrom then
    ListBoxSecorder.items.Move(Drkfrom,index);

end;

end.
