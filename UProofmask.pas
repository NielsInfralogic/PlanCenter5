unit UProofmask;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ComCtrls, ExtCtrls;

type
  TFormproofmask = class(TForm)
    Panel3: TPanel;
    Image2: TImage;
    Label7: TLabel;
    Label8: TLabel;
    Panelgo: TPanel;
    GroupBoxlist: TGroupBox;
    ListView1: TListView;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBoxedit: TGroupBox;
    Button3: TButton;
    ComboBoxproofs: TComboBox;
    Label6: TLabel;
    Button2: TButton;
    procedure FormActivate(Sender: TObject);
    procedure EditwidthKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure dopageformatsetup;
    procedure Button2Click(Sender: TObject);
    procedure ListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
  private
    procedure load;
  public
    SelectedMaster : Longint;
    Usethispageformat : Longint;
    Usethisproofid : Longint;
    { Public declarations }
  end;

var
  Formproofmask: TFormproofmask;

implementation



{$R *.dfm}
Uses
  UData, UTypes, UMain, ULoadDlls;

procedure TFormproofmask.FormActivate(Sender: TObject);
Begin
  load;
End;

procedure TFormproofmask.load;
Var
  l : Tlistitem;
begin
  ListView1.items.clear;
  ComboBoxproofs.items.clear;

  DataM1.Query2.SQL.Clear;
  DataM1.Query2.SQL.add('Select distinct proofname from ProofConfigurations');
  DataM1.Query2.SQL.add('where proofname <> ' + ''''+''+'''');
  DataM1.Query2.open;
  while not DataM1.Query2.eof do
  begin
    ComboBoxproofs.items.add(DataM1.Query2.fields[0].asstring);
    DataM1.Query2.next;
  end;
  DataM1.Query2.close;
  ComboBoxproofs.itemindex := 0;


  DataM1.Query2.SQL.Clear;
  DataM1.Query2.SQL.add('Select distinct PageFormatID,PageFormatName,Width,Height from PageFormatNames');
  DataM1.Query2.SQL.add('WHERE Width <> 0 and Height <> 0 ');
  DataM1.Query2.SQL.add('order by PageFormatName');
  DataM1.Query2.open;
  While not DataM1.Query2.eof do
  begin
    l := ListView1.items.add;
    l.caption := DataM1.Query2.fields[1].AsString;
    l.subitems.add(DataM1.Query2.fields[2].AsString);
    l.subitems.add(DataM1.Query2.fields[3].AsString);
    l.subitems.add(DataM1.Query2.fields[0].AsString);

    DataM1.Query2.next;
  end;


  DataM1.Query2.close;
  BitBtn1.enabled := listview1.Selected <> nil;
end;

procedure TFormproofmask.EditwidthKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
Const
  EditDecimaltal : set of char=['0'..'9','.'];
begin
  IF Not (Char(Key) IN decimaltal) then
    key := 0;
end;

procedure TFormproofmask.BitBtn1Click(Sender: TObject);
Var
  publid,proofid : Longint;
  Pubdate : Tdatetime;
begin
  publid := -1;
  IF listview1.Selected = nil then
  begin
    MessageDlg('No mask selected ', mtError,[mbOk], 0);

  end
  else
  begin
    DataM1.Query2.SQL.Clear;
    DataM1.Query2.SQL.add('Select distinct proofid from ProofConfigurations');
    DataM1.Query2.SQL.add('where proofname = ' +''''+ComboBoxproofs.Text+'''');

    DataM1.Query2.open;
    proofid := 1;
    IF Not DataM1.Query2.eof then
    begin
      proofid := DataM1.Query2.fields[0].asinteger;

    end;
    DataM1.Query2.Close;

    DataM1.Query2.SQL.Clear;
    DataM1.Query2.SQL.add('Select distinct publicationid,pubdate from pagetable Where mastercopyseparationset =  ' + inttostr(SelectedMaster));
    DataM1.Query2.open;
    IF not DataM1.Query2.eof then
    begin
      publid := DataM1.Query2.fields[0].asinteger;
      Pubdate := DataM1.Query2.fields[1].asdatetime;
    end;
    DataM1.Query2.close;
    IF publid > 0 then
    begin
      DataM1.Query2.SQL.Clear;
      DataM1.Query2.SQL.add('Select distinct pressrunid from pagetable Where publicationid =  ' + inttostr(publid));
      DataM1.Query2.SQL.add(' and ' + DataM1.makedatastr('',pubdate));
      DataM1.Query2.open;
      While not DataM1.Query2.eof do
      begin
        DataM1.Query1.SQL.Clear;
        DataM1.Query1.SQL.add('Update pressrunid set miscint1 = '+ListView1.Selected.SubItems[2] +'  Where pressrunid =  ' +DataM1.Query2.fields[0].asstring );
        DataM1.Query1.ExecSQL;

        DataM1.Query1.SQL.Clear;
        DataM1.Query1.SQL.add('Update pagetable set proofstatus = 0, proofid = '+inttostr(proofid)+' Where pressrunid =  ' +DataM1.Query2.fields[0].asstring );
        DataM1.Query1.ExecSQL;
        DataM1.Query2.next;
      end;
      DataM1.Query2.close;

    end;
  End;
end;

procedure TFormproofmask.Button3Click(Sender: TObject);
Var
  I : Longint;
begin
  For i := 0 to listview1.items.count-1 do
  begin
    IF listview1.items[i].selected then
    begin

      DataM1.Query1.SQL.Clear;
      DataM1.Query1.SQL.add('Select distinct pressrunid from pressrunid nolock Where miscint1 = '+ListView1.items[i].SubItems[2]);
      DataM1.Query1.SQL.add('');
      DataM1.Query1.open;
      IF Not DataM1.Query1.eof then
      begin
        MessageDlg('Cannot delete ' + ListView1.items[i].caption + ' it is in use' , mtInformation,[mbOk], 0);
        DataM1.Query1.close;
      end
      Else
      begin
        DataM1.Query1.close;
        DataM1.Query1.SQL.Clear;
        DataM1.Query1.SQL.add('Delete PageFormatNames');
        DataM1.Query1.SQL.add('WHERE PageFormatID = ' +ListView1.items[i].SubItems[2]);
        DataM1.Query1.execsql;
      end;
    end;

  end;
  load;
end;



procedure TFormproofmask.dopageformatsetup;
Var
  skaldeklarerespgadll : Longint;
  resulttat : Integer;
begin

  skaldeklarerespgadll := random(10);
  Runningdll := true;

 resulttat := ReConnectDB(DLLErrormessage);
  if resulttat = 1 then
    resulttat := PageFormatSetup(DLLErrormessage);

  Runningdll := false;
  IF skaldeklarerespgadll > 20 then
    sleep(10);


end;


procedure TFormproofmask.Button2Click(Sender: TObject);
Var
  alist : Tstrings;
  I,i2,Found : Longint;
begin
  alist := TStringList.Create;
  For i := 0 to ListView1.items.count-1 do
  Begin
    alist.add(ListView1.items[i].SubItems[2]);
  End;
  dopageformatsetup;

  Load;
  ListView1.SetFocus;
  ListView1.Items.BeginUpdate;

  Found := -1;
  For i := 0 to ListView1.items.count-1 do
  Begin
    Found := -1;
    IF alist.IndexOf(ListView1.items[i].SubItems[2]) < 0 then
      found := i;
    IF Found > -1 then
      break;
  End;

  IF Found > -1 then
  Begin
    ListView1.items[Found].Selected := true;
    ListView1.items[Found].MakeVisible(false);
    ListView1.items[Found].Focused := true;
  End;

  ListView1.Items.EndUpdate;
  alist.free;
end;

procedure TFormproofmask.ListView1SelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  BitBtn1.enabled := listview1.Selected <> nil;
end;

end.
