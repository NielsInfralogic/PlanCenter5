unit Uappendruns;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls;

type
  TFormappendruns = class(TForm)
    Panel3: TPanel;
    Image2: TImage;
    Label7: TLabel;
    Label8: TLabel;
    GroupBox1: TGroupBox;
    GroupBoxincluderuns: TGroupBox;
    ListViewinplan: TListView;
    Splitter1: TSplitter;
    Panel1: TPanel;
    BitBtn2: TBitBtn;
    BitBtnappend: TBitBtn;
    ListViewappend: TListView;
    CheckBoxautoname: TCheckBox;
    BitBtnsave: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure BitBtnappendClick(Sender: TObject);
    procedure BitBtnsaveClick(Sender: TObject);
  private
    procedure dothesave;
  public
    appendtoplanid : Longint;
    newautoname : string;
    { Public declarations }
  end;

var
  Formappendruns: TFormappendruns;

implementation

{$R *.dfm}
Uses
  udata,umain, Uaddpressrun, Usettings, Usavename;
procedure TFormappendruns.FormActivate(Sender: TObject);
Var
  l : tlistitem;
  aktpressid,aktrun : Longint;
  T : string;
  i1,i2 : longint;
  lpage : Longint;
begin
  BitBtnappend.Visible := true;
  BitBtnsave.Visible := false;
  if Formsavename.BitBtn1.Caption = 'Overwrite' then
  begin
    BitBtnappend.Visible := false;
    BitBtnsave.Visible := true;
  end;

  CheckBoxautoname.Checked := Prefs.DefaultAutomatePlanname;

  lpage := 9999;
  ListViewinplan.Items.Clear;
  aktpressid := -1;
  aktrun     := -1;
  T := '';
  DataM1.Query1.Sql.Clear;
  DataM1.Query1.Sql.Add('Select distinct pressid,runnumber,editionid,pageindex from Presstemplate');
  DataM1.Query1.Sql.Add('where PresstemplateID = ' + IntToStr(appendtoplanid));
  DataM1.Query1.Sql.Add('order by pressid,runnumber,editionid,pageindex');
  DataM1.Query1.Open;
  while not DataM1.Query1.Eof do
  begin
    if (aktpressid <> DataM1.Query1.Fields[0].AsInteger) or (aktrun <> DataM1.Query1.Fields[1].AsInteger) then
    begin
      aktpressid := DataM1.Query1.Fields[0].AsInteger;
      aktrun := DataM1.Query1.Fields[1].AsInteger;
      lpage := 1;
      if ListViewinplan.Items.Count > 0 then
        ListViewinplan.Items[ListViewinplan.Items.Count-1].SubItems[3] := IntToStr(lpage);
      T := DataM1.Query1.Fields[3].Asstring+',';
      l := ListViewinplan.Items.Add;
      l.Caption := tnames1.pressnameIDtoname(aktpressid);
      l.SubItems.Add(IntToStr(aktrun));
      l.SubItems.Add( tnames1.editionIDtoname(DataM1.Query1.Fields[2].AsInteger) );
      l.SubItems.Add(t);
      l.SubItems.add(IntToStr(lpage));
    end
    Else
    begin
      T := T + DataM1.Query1.fields[3].AsString+',';
      l.SubItems[2] := t;
      Inc(lpage);
      l.SubItems[3] := IntToStr(lpage);

    end;
    DataM1.Query1.next;
  end;
  DataM1.Query1.close;

  IF BitBtnsave.visible then
  begin
    for i2 := 0 to ListViewappend.Items.Count-1 do
    begin
      ListViewappend.Items[i2].Checked := true;
    end;
  end
  else
  begin

    For i1 := 0 to ListViewinplan.Items.Count-1 do
    begin
      for i2 := 0 to ListViewappend.Items.Count-1 do
      begin
        if (ListViewinplan.Items[i1].SubItems[1] = ListViewappend.Items[i2].SubItems[1]) and
           (ListViewinplan.Items[i1].SubItems[2] = ListViewappend.Items[i2].SubItems[2]) then
        begin
          ListViewappend.Items[i2].Checked := false;
        end;
      end;
    end;
  End;
end;



procedure TFormappendruns.BitBtnappendClick(Sender: TObject);
begin
  dothesave;
end;

procedure TFormappendruns.dothesave;
Var
  I : longint;

  Npresspages : Longint;
  presspages : array[1..100] of record
                                  pressname : string;
                                  Npages : Longint;
                                  pages : array[1..100] of string;
                                End;

  ipr : Longint;
  newautoname1,newautoname2,aktpress : string;
  Found : boolean;
begin
  newautoname1 := '';
  newautoname2 := '';
  Npresspages := 0;
  aktpress := '';

  Npresspages := 0;
  for ipr := 1 to 100 do
  begin
    presspages[ipr].pressname := '';
    presspages[ipr].npages := 0;
  end;

  For i := 0 to ListViewinplan.Items.Count-1 do
  begin
    found := false;
    for ipr := 1 to Npresspages do
    begin
      if presspages[ipr].pressname = ListViewinplan.Items[i].Caption then
      begin
        found := true;
        break;
      end;

    end;
    if not found then
    begin
      Inc(Npresspages);
      presspages[Npresspages].pressname := ListViewinplan.Items[i].Caption;
    end;
  end;

  For i := 0 to ListViewappend.Items.Count-1 do
  begin
    IF ListViewappend.Items[i].Checked then
    begin
      found := false;
      for ipr := 1 to Npresspages do
      begin
        if presspages[ipr].pressname = ListViewappend.Items[i].Caption then
        begin
          found := true;
          break;
        end;

      end;
      if not found then
      begin
        Inc(Npresspages);
        presspages[Npresspages].pressname := ListViewappend.Items[i].Caption
      end;
    End;
  end;

  For i := 0 to ListViewinplan.Items.Count-1 do
  begin
    found := false;
    for ipr := 1 to Npresspages do
    begin
      if presspages[ipr].pressname = ListViewinplan.Items[i].Caption then
      Begin
        Inc(presspages[ipr].Npages);
        presspages[ipr].pages[presspages[ipr].Npages] := ListViewinplan.Items[i].subitems[3];
      end;
    End;
  End;


  For i := 0 to ListViewappend.Items.Count-1 do
  begin
    found := false;
    for ipr := 1 to Npresspages do
    begin
      if (presspages[ipr].pressname = ListViewappend.Items[i].Caption) and (ListViewappend.Items[i].Checked) then
      Begin
        Inc(presspages[ipr].Npages);
        presspages[ipr].pages[presspages[ipr].Npages] := ListViewappend.Items[i].subitems[3];
      end;
    End;
  End;

  newautoname := '';
  for ipr := 1 to Npresspages do
  begin
    newautoname := newautoname + ' ' + presspages[ipr].pressname+' (';
    for i := 1 to presspages[ipr].Npages do
    begin
      newautoname := newautoname + presspages[ipr].pages[i]+',';
    end;
    newautoname[length(newautoname)] := ')';
  End;

  if FormAddpressrun.CheckBoxbindingstyle.checked then
    newautoname := 'P '+newautoname
  else
    newautoname := 'S '+newautoname;

end;

procedure TFormappendruns.BitBtnsaveClick(Sender: TObject);
begin
  dothesave;
end;

end.




