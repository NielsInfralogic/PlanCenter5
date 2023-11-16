unit Ueditplan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, PBExListview, StdCtrls, Buttons, ExtCtrls;

type
  TFormeditplan = class(TForm)
    Panelb: TPanel;
    Image2: TImage;
    Label2: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel2: TPanel;
    PBExListview1: TPBExListview;
    Panel3: TPanel;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Edit1: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure PBExListview1Change(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure PBExListview1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }

    aktcheked : array[0..100] of boolean;
    initialized : boolean;
    procedure autocalcpages;
    procedure Checkpagesum;
  public
    maxpages : longint;

    { Public declarations }
  end;

var
  Formeditplan: TFormeditplan;

implementation
Uses
  utypes,
  umain;

{$R *.dfm}

procedure TFormeditplan.FormActivate(Sender: TObject);
Var
  I : longint;
  l : tlistitem;
begin
  if PBExListview1.Items.Count = 1 then
  begin
    initialized := false;
    for i := 0 to tnames1.sectionnames.Count-1 do
    begin
      if tnames1.sectionnames[i] <> PBExListview1.Items[0].SubItems[1] then
      begin
        l := PBExListview1.Items.add;
        l.Checked := false;
        l.caption := PBExListview1.Items[0].Caption;
        l.subitems.add(PBExListview1.Items[0].SubItems[0]);
        l.subitems.add(tnames1.sectionnames[i]);
        l.subitems.add('0');
      end;
    end;
  end;
  aktcheked[0] := true;
  for i := 1 to 100 do
    aktcheked[i] := false;
  initialized := true;
end;

procedure TFormeditplan.PBExListview1Change(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
  IF initialized then
  Begin
    if aktcheked[item.Index] <> item.Checked then
    begin
      aktcheked[item.Index] := item.Checked;
      autocalcpages;
    end;
  end;
end;

procedure TFormeditplan.PBExListview1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var
  l,l2 : tlistitem;
  i,cl,cr : longint;
  editrect : TRect;
  pt : tpoint;
  leaveedit : boolean;

begin
  GetCursorPos(pt);
  leaveedit := false;
  IF ((pt.X < Formeditplan.Left) or (pt.X > Formeditplan.Left + Formeditplan.width)) or
     ((pt.y < Formeditplan.top) or (pt.y > Formeditplan.top + Formeditplan.height)) then
  begin
    IF Edit1.visible then
    begin
      l2 := PBExListview1.GetItemAt(Edit1.Left+3,Edit1.top+3);
      l2.SubItems[2] := Edit1.text;
      Edit1.visible := false;
    end;
    exit;
  end;
  l := PBExListview1.GetItemAt(x,y);
  if l <> nil then
  Begin
    if not l.Checked Then
    begin
      IF Edit1.visible then
      Begin
        l2 := PBExListview1.GetItemAt(Edit1.Left+3,Edit1.top+3);
        l2.SubItems[2] := Edit1.text;
        Edit1.Visible := false;
      End;
      exit;
    end;
    editrect := l.DisplayRect(drbounds);

    cl := 0;
    for i := 0 to 2 do
    begin
      cl := cl + PBExListview1.Columns[i].Width;
    end;
    cr := cl + PBExListview1.Columns[3].Width;

    if (x >= cl) and (x <= cr) then
    Begin
      IF Edit1.visible then
      begin
        l2 := PBExListview1.GetItemAt(Edit1.Left+3,Edit1.top+3);
        l2.SubItems[2] := Edit1.text;
      end;
      Edit1.Left := cl+2;
      Edit1.Width := PBExListview1.Columns[3].Width;
      Edit1.Top := editrect.Top+2;
      Edit1.Height := editrect.Bottom - editrect.Top;
      Edit1.text := l.SubItems[2];
      Edit1.visible := true;
    end
    else
    Begin
      if Edit1.visible then
      begin
        IF Edit1.visible then
        Begin
          l2 := PBExListview1.GetItemAt(Edit1.Left+3,Edit1.top+3);
          l2.SubItems[2] := Edit1.text;
          Edit1.Visible := false;
        End;
      end;
    End;
  End
  Else
  begin
    IF Edit1.visible then
    Begin
      l2 := PBExListview1.GetItemAt(Edit1.Left+3,Edit1.top+3);
      l2.SubItems[2] := Edit1.text;
      Edit1.Visible := false;
    End;
  end;


  Checkpagesum;
end;

procedure TFormeditplan.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in tal) then key := '0';
end;


procedure TFormeditplan.autocalcpages;
Var
  nsections,i,ppersec,pset : longint;
Begin
  BitBtn1.enabled := true;
  nsections := 0;
  For i := 0 to PBExListview1.items.count-1 do
  begin
    IF PBExListview1.items[i].checked then
      inc(nsections);
  end;

  if nsections = 0 then
  begin
    BitBtn1.enabled := false;
  end
  Else
  begin
    ppersec := maxpages div nsections;
    IF ppersec mod 2 = 1 then
      inc(ppersec);
    pset := 0;
    For i := 0 to PBExListview1.items.count-1 do
    begin
      IF PBExListview1.items[i].checked then
      begin

        if pset+ppersec > maxpages then
        begin
          while pset+ppersec > maxpages do
          begin
            dec(ppersec);
          end;
        end;
        Inc(pset,ppersec);
        PBExListview1.items[i].SubItems[2] := inttostr(ppersec);
        inc(nsections);
      end;
    end;
    if pset < maxpages then
    begin
      For i := 0 to PBExListview1.items.count-1 do
      begin
        IF PBExListview1.items[i].checked then
        begin
          PBExListview1.items[i].SubItems[2] := inttostr(ppersec + (maxpages - pset));
          break;
        End;
      End;

    end;
  end;

  For i := 0 to PBExListview1.items.count-1 do
  begin
    IF not PBExListview1.items[i].checked then
    begin
      PBExListview1.items[i].SubItems[2] := '0';
    End;
  End;

end;

procedure TFormeditplan.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  initialized := false;
end;

procedure TFormeditplan.BitBtn4Click(Sender: TObject);
Var
  c : string;
  subs : array[0..10] of string;
  I : longint;
begin
  IF PBExListview1.Selected = nil then exit;
  IF PBExListview1.Selected.Index = 0 then exit;
  IF PBExListview1.items.count = 1 then exit;
  I := PBExListview1.Selected.Index;

  c := PBExListview1.items[i].Caption;
  subs[0] := PBExListview1.items[i].SubItems[0];
  subs[1] := PBExListview1.items[i].SubItems[1];
  subs[2] := PBExListview1.items[i].SubItems[2];
  PBExListview1.items[i].Caption := PBExListview1.items[i-1].Caption;
  PBExListview1.items[i].SubItems[0] := PBExListview1.items[i-1].SubItems[0];
  PBExListview1.items[i].SubItems[1] := PBExListview1.items[i-1].SubItems[1];
  PBExListview1.items[i].SubItems[2] := PBExListview1.items[i-1].SubItems[2];
  PBExListview1.items[i-1].Caption := c;
  PBExListview1.items[i-1].SubItems[0] := Subs[0];
  PBExListview1.items[i-1].SubItems[1] := Subs[1];
  PBExListview1.items[i-1].SubItems[2] := Subs[2];


end;

procedure TFormeditplan.BitBtn3Click(Sender: TObject);
Var
  c : string;
  subs : array[0..10] of string;
  I : longint;
begin
  IF PBExListview1.Selected = nil then exit;
  IF PBExListview1.Selected.Index = PBExListview1.items.count-1 then exit;
  IF PBExListview1.items.count = 1 then exit;
  I := PBExListview1.Selected.Index;

  c := PBExListview1.items[i].Caption;
  subs[0] := PBExListview1.items[i].SubItems[0];
  subs[1] := PBExListview1.items[i].SubItems[1];
  subs[2] := PBExListview1.items[i].SubItems[2];
  PBExListview1.items[i].Caption := PBExListview1.items[i+1].Caption;
  PBExListview1.items[i].SubItems[0] := PBExListview1.items[i+1].SubItems[0];
  PBExListview1.items[i].SubItems[1] := PBExListview1.items[i+1].SubItems[1];
  PBExListview1.items[i].SubItems[2] := PBExListview1.items[i+1].SubItems[2];
  PBExListview1.items[i+1].Caption := c;
  PBExListview1.items[i+1].SubItems[0] := Subs[0];
  PBExListview1.items[i+1].SubItems[1] := Subs[1];
  PBExListview1.items[i+1].SubItems[2] := Subs[2];


end;

procedure TFormeditplan.Checkpagesum;
Var
  I,tot : longint;
  T : string;
Begin
  BitBtn1.enabled := true;
  tot := 0;
  For i := 0 to PBExListview1.items.count-1 do
  begin
    T := PBExListview1.items[i].SubItems[2];
    IF length(T) = 0 then t := '0';
    IF length(T) > 1 then
    begin
      While (t[1] = '0') and (length(T) > 1) do
        delete(t,1,1);
    end;
    PBExListview1.items[i].SubItems[2] := T;
    IF PBExListview1.items[i].checked then
    begin
      tot := tot + strtoint(PBExListview1.items[i].SubItems[2]);
    End;
  End;
  BitBtn1.enabled := tot = maxpages;
End;
end.
