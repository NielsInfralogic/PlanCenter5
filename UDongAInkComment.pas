unit UDongAInkComment;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons;

type
  TFormdongAink = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ListView1: TListView;
    GroupBox1: TGroupBox;
    EditsectionOffset: TEdit;
    UpDown1: TUpDown;
    Button1: TButton;
    Button3: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    PublicationID : Longint;
    Pubdate       : Tdatetime;
    ProductionID  : Longint;
    EditionID     : Longint;
    NSections     : Longint;
    Sections      : Array[1..20] of record
                                      SectionID : Longint;
                                      Sectionname : String;
                                    End;
    procedure Init;
    { Public declarations }
  end;

var
  FormdongAink: TFormdongAink;

implementation
Uses
  umain, Udata;
{$R *.dfm}


procedure TFormdongAink.Init;
Var
  I,sectionid,npages,aktsectionid : Longint;
  l : Tlistitem;
  minmiscstring1,inkcomment : String;
begin

  ListView1.Columns[0].Caption := formmain.InfraLanguage1.Translate('Section');
  ListView1.Columns[1].Caption := formmain.InfraLanguage1.Translate('Page 1=');

  ListView1.Items.clear;
  aktsectionid := -1;
  NSections := 0;
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('Select Distinct p.sectionid,1,S.name,S.Sectionid,miscstring1 from pagetable p, sectionnames S');
  DataM1.Query1.SQL.Add('where p.productionid = ' + inttostr(productionid));
  DataM1.Query1.SQL.Add('and p.editionid = ' + inttostr(editionid));
  DataM1.Query1.SQL.Add('and s.sectionid = p.sectionid');
  DataM1.Query1.SQL.Add('Order by s.name');
  DataM1.Query1.open;
  while not DataM1.Query1.eof do
  begin
    IF aktsectionid <> DataM1.Query1.fields[0].asinteger then
    begin
      aktsectionid := DataM1.Query1.fields[0].asinteger;
      Inc(NSections);
      Sections[NSections].SectionID := DataM1.Query1.fields[0].asinteger;
      Sections[NSections].Sectionname := DataM1.Query1.fields[2].asstring;
    end;
    DataM1.Query1.next;
  end;
  DataM1.Query1.close;

  For i := 1 to nsections do
  begin
    l := listview1.Items.add;
    l.Caption := Sections[i].Sectionname;
    l.subitems.add('1');
    l.Selected := true;
  end;

end;


procedure TFormdongAink.Button2Click(Sender: TObject);
Var
  i : Longint;
begin
end;

procedure TFormdongAink.Button1Click(Sender: TObject);
Var
  i : Longint;
begin

  For i := 0 to ListView1.items.Count-1 do
  begin
    if ListView1.items[i].selected  then
    begin
      ListView1.items[i].SubItems[0] := EditsectionOffset.text;
      break;
    end;

  End;

end;

procedure TFormdongAink.Button3Click(Sender: TObject);
Var
  i : longint;
begin
  For i := 0 to ListView1.items.Count-1 do
  begin
    ListView1.items[i].SubItems[0] := 'R';
  End;
end;

procedure TFormdongAink.BitBtn1Click(Sender: TObject);
Var
  i,offset : Longint;
begin


  For i := 0 to ListView1.items.Count-1 do
  begin
    IF ListView1.items[i].SubItems[0] = 'R' then
    Begin
      DataM1.Query3.SQL.Clear;
      DataM1.Query3.SQL.Add('update pagetable');
      DataM1.Query3.SQL.Add('set miscstring1 = pagename');
      DataM1.Query1.SQL.Add('where productionid = ' + inttostr(productionid));
      DataM1.Query1.SQL.Add('and sectionid = ' + inttostr(Sections[i].SectionID));
      DataM1.Query3.execsql;
    End
    Else
    Begin

      offset := strtoint(ListView1.items[i].SubItems[0])-1;

      DataM1.Query1.SQL.Clear;
      DataM1.Query1.SQL.Add('update pagetable set miscstring1  = cast(pagename as int) + ' + inttostr(offset) );
      DataM1.Query1.SQL.Add('where productionid = ' + inttostr(productionid));
      DataM1.Query1.SQL.Add('and sectionid = ' + inttostr(tnames1.sectionnametoid(ListView1.items[i].caption)));
      DataM1.Query1.sql.SaveToFile('c:\lllll.sql');
      DataM1.Query1.execsql;
    End;
  End;

end;

end.
