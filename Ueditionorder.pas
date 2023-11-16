unit Ueditionorder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, system.UITypes;

type
  TFormeditionorder = class(TForm)
    GroupBox1: TGroupBox;
    ListBox1: TListBox;
    Panel2: TPanel;
    Image1: TImage;
    Label5: TLabel;
    Label6: TLabel;
    GroupBox2: TGroupBox;
    BitBtndown: TBitBtn;
    BitBtnup: TBitBtn;
    Panel3: TPanel;
    ComboBox1: TComboBox;
    Button1: TButton;
    Button2: TButton;
    Panel4: TPanel;
    BitBtn1: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn6: TBitBtn;
    Button3: TButton;
    ListBoxsort: TListBox;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BitBtnupClick(Sender: TObject);
    procedure BitBtndownClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Formeditionorder: TFormeditionorder;

implementation

uses Umain;

{$R *.dfm}

procedure TFormeditionorder.FormActivate(Sender: TObject);
begin
  if ListBox1.Items.Count > 0 then
  Begin
    ListBox1.Itemindex := 0;
    BitBtn1.Enabled := true;
  end
  else
  begin
    BitBtn1.Enabled := false;
  end;
end;

procedure TFormeditionorder.Button1Click(Sender: TObject);
begin
  if ListBox1.Items.IndexOf(ComboBox1.text) = -1 then
  begin
    ListBox1.Items.add(ComboBox1.text);

  end
  else
    MessageDlg(formmain.InfraLanguage1.Translate('The edition is already in the list'), mtInformation,[mbOk], 0);

  if ListBox1.Items.Count > 0 then
  Begin
    ListBox1.Itemindex := ListBox1.Items.Count-1;
    BitBtn1.Enabled := true;
  end
  else
  begin
    BitBtn1.Enabled := false;
  end;
end;

procedure TFormeditionorder.Button2Click(Sender: TObject);

begin
  if ListBox1.ItemIndex <> -1 then
  begin
    ListBox1.Items.Delete(ListBox1.ItemIndex);
  end;
  if ListBox1.Items.Count > 0 then
  Begin
    ListBox1.Itemindex := ListBox1.Items.Count-1;
    BitBtn1.Enabled := true;
  end
  else
  begin
    BitBtn1.Enabled := false;
  end;
end;

procedure TFormeditionorder.BitBtnupClick(Sender: TObject);
Var
  I : Integer;
begin
  I := ListBox1.ItemIndex;
  if ListBox1.ItemIndex > 0 then
  begin
    ListBox1.Items.Move(ListBox1.ItemIndex,ListBox1.ItemIndex-1);
    dec(i);
  end;
  ListBox1.ItemIndex := i;
end;

procedure TFormeditionorder.BitBtndownClick(Sender: TObject);
Var
  I : Integer;
begin
  I := ListBox1.ItemIndex;
  if (ListBox1.ItemIndex < ListBox1.Items.Count-1) and (ListBox1.ItemIndex > -1) then
  begin
    ListBox1.Items.Move(ListBox1.ItemIndex,ListBox1.ItemIndex+1);
    inc(i);
  end;
  ListBox1.ItemIndex := i;
end;

procedure TFormeditionorder.Button3Click(Sender: TObject);
Var
  I : Longint;

begin
  ListBoxsort.items.clear;
  ListBoxsort.items.BeginUpdate;
  for i := 0 to ListBox1.items.count-1 do
  begin
    ListBoxsort.items.add(ListBox1.items[i]);

  end;
  ListBoxsort.items.EndUpdate;

  ListBox1.items.BeginUpdate;
  ListBox1.items.Clear;
  for i := 0 to ListBoxsort.items.count-1 do
  begin
    ListBox1.items.add(ListBoxsort.items[i]);

  end;
  ListBox1.items.EndUpdate;





end;

end.
