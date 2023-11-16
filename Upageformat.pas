unit Upageformat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, system.UITypes,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls;

type
  TFormpageformats = class(TForm)
    Panel3: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    ListView1: TListView;
    procedure BitBtn3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }

    ApplyOnPublication : Longint;
    ApplyOnPubdate : Tdatetime;
    Specifikruns : Boolean;
    Wherestr : String;
    procedure load;
  end;

var
  Formpageformats: TFormpageformats;

implementation

{$R *.dfm}
Uses
  umain,udata,utypes;

procedure TFormpageformats.BitBtn3Click(Sender: TObject);
begin
  formmain.dopageformatsetup;
  load;
end;

procedure TFormpageformats.FormCreate(Sender: TObject);
begin
  ApplyOnPublication := -1;
  ApplyOnPubdate := now;
  Wherestr :='';

end;
procedure TFormpageformats.load;
Var
  l : Tlistitem;
Begin
  ListView1.items.clear;
  DataM1.Query2.SQL.Clear;
  DataM1.Query2.SQL.add('Select distinct PageFormatID,PageFormatName,Width,Height,Bleed from PageFormatNames');
  DataM1.Query2.SQL.add('order by PageFormatName');
  DataM1.Query2.open;
  While not DataM1.Query2.eof do
  begin
    l := ListView1.items.add;
    l.caption := DataM1.Query2.fields[1].AsString;
    l.subitems.add(DataM1.Query2.fields[2].AsString);
    l.subitems.add(DataM1.Query2.fields[3].AsString);
    l.subitems.add(DataM1.Query2.fields[4].AsString);
    l.subitems.add(DataM1.Query2.fields[0].AsString);
    DataM1.Query2.next;
  end;

End;
procedure TFormpageformats.FormActivate(Sender: TObject);
begin
  load;
end;

procedure TFormpageformats.BitBtn1Click(Sender: TObject);
begin
  IF listview1.Selected = nil then
  begin
    MessageDlg('No pageformat selected ', mtError,[mbOk], 0);
  end
  else
  begin
    IF Specifikruns then
    begin

      DataM1.Query1.SQL.Clear;
      if (Pageformatinpagetable) then
        DataM1.Query1.SQL.add('Update PageTable set PageFormatID = '+ListView1.Selected.SubItems[3] +'  WHERE PressRunID IN ' + Wherestr )
      else
        DataM1.Query1.SQL.add('Update pressrunid set miscint1 = '+ListView1.Selected.SubItems[3] +'  Where pressrunid IN ' +Wherestr );
      DataM1.Query1.ExecSQL;

    end
    Else
    begin
      DataM1.Query2.SQL.Clear;
      DataM1.Query2.SQL.add('Select distinct pressrunid from Pagetable WITH (NOLOCK) Where publicationid =  ' + inttostr(ApplyOnPublication));
      DataM1.Query2.SQL.add(' and ' + DataM1.makedatastr('',ApplyOnPubdate));
      DataM1.Query2.open;
      While not DataM1.Query2.eof do
      begin

        DataM1.Query1.SQL.Clear;
        if (Pageformatinpagetable) then
          DataM1.Query1.SQL.add('Update PageTable set PageFormatID = '+ListView1.Selected.SubItems[3] +'  Where pressrunid =  ' +DataM1.Query2.fields[0].asstring )
        else
          DataM1.Query1.SQL.add('Update pressrunid set miscint1 = '+ListView1.Selected.SubItems[3] +'  Where pressrunid =  ' +DataM1.Query2.fields[0].asstring );
        DataM1.Query1.ExecSQL;

        DataM1.Query2.next;
      end;
      DataM1.Query2.close;
    end;
  End;
end;

end.
