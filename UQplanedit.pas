unit UQplanedit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TFormquickloaddesign = class(TForm)
    ComboBoxqplan: TComboBox;
    Label1: TLabel;
    BitBtn3: TBitBtn;
    ListBox1: TListBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure ComboBoxqplanChange(Sender: TObject);
  private
    procedure loadit;
  public
    planid : longint;
    { Public declarations }
  end;

var
  Formquickloaddesign: TFormquickloaddesign;

implementation

uses Udata, Umain;

{$R *.dfm}

procedure TFormquickloaddesign.FormActivate(Sender: TObject);
Var

  T : string;
begin
  try
    ListBox1.Items.Clear;
    T := '';
    IF ComboBoxqplan.text <> '' then
      T := ComboBoxqplan.text;
    ComboBoxqplan.Items.Clear;
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('Select Distinct runname from Planrunnames');
    formmain.tryopen(datam1.Query1);
    while not DataM1.Query1.eof do
    begin
      ComboBoxqplan.Items.add(DataM1.Query1.fields[0].asstring);
      DataM1.Query1.next;
    end;
    DataM1.Query1.close;
    ComboBoxqplan.Itemindex := ComboBoxqplan.Items.IndexOf(T);

    IF ComboBoxqplan.Itemindex > -1 then
      loadit;

  Except
  end;
end;

procedure TFormquickloaddesign.BitBtn3Click(Sender: TObject);
Var
  isnew : Boolean;
  runorder : Longint;
begin
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('Select runname,runorder from Planrunnames');
  DataM1.Query1.SQL.Add('where runname = '+''''+ComboBoxqplan.text+'''');
  DataM1.Query1.SQL.Add('order by runname desc');
  runorder := 1;
  formmain.tryopen(datam1.Query1);
  isnew := DataM1.Query1.eof;
  if not isnew then
  begin
    runorder := datam1.Query1.fields[1].AsInteger+1;
  end;
  DataM1.Query1.close;
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('insert Planrunnames');
  DataM1.Query1.SQL.Add('values('+''''+ComboBoxqplan.text+''''+','+inttostr(planid)+','+inttostr(runorder)+')');
  formmain.trysql(datam1.Query1);

end;

procedure TFormquickloaddesign.loadit;
Begin
  ListBox1.Items.Clear;
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('Select q1.runname,q1.presstemplateid,q1.runorder,p1.PresstemplateID,p1.Name from Planrunnames q1, Presstemplatenames p1');
  DataM1.Query1.SQL.Add('where q1.runname = '+''''+ComboBoxqplan.text+'''');
  DataM1.Query1.SQL.Add('and q1.PresstemplateID = p1.PresstemplateID');
  DataM1.Query1.SQL.Add('order by runname');
  DataM1.Query1.open;
  While not DataM1.Query1.eof do
  begin
    ListBox1.Items.Add(DataM1.Query1.fields[4].asstring);
    DataM1.Query1.next;
  end;
  DataM1.Query1.close;
end;

procedure TFormquickloaddesign.ComboBoxqplanChange(Sender: TObject);
begin
  loadit;
end;

end.
