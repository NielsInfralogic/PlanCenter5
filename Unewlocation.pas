unit Unewlocation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Udata,Dialogs, StdCtrls, Buttons, ExtCtrls, CheckLst;

type
  TFormnewlocation = class(TForm)
    Panel2: TPanel;
    Image1: TImage;
    Labelwizardheader1: TLabel;
    Labelwizardheader2: TLabel;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn6: TBitBtn;
    ComboBoxLocation: TComboBox;
    Label1: TLabel;
    ComboBoxpress: TComboBox;
    Label2: TLabel;
    RadioGrouprelease: TRadioGroup;
    procedure FormActivate(Sender: TObject);
    procedure ComboBoxLocationChange(Sender: TObject);
  private
    Function checkplanonnewpress:boolean;
    { Private declarations }
  public
    aktlocation : string;
    aktpress    : string;

  end;

var
  Formnewlocation: TFormnewlocation;

implementation

{$R *.dfm}

Uses
  umain,uprodplan;

procedure TFormnewlocation.FormActivate(Sender: TObject);
Var
  locid : Longint;
begin
  locid := 1;
  DataM1.Query2.sql.clear;
  DataM1.Query2.sql.add('Select locationid from pressnames');
  DataM1.Query2.sql.add('where pressname = '+''''+aktpress+'''');
  DataM1.Query2.open;
  IF not DataM1.Query2.eof then
    locid := DataM1.Query2.fields[0].AsInteger;
  DataM1.Query2.close;

  ComboBoxLocation.items := tnames1.locationnames;
  ComboBoxLocation.itemindex := ComboBoxLocation.items.indexof(tnames1.locationIDtoname(locid));

  ComboBoxpress.items.clear;
  DataM1.Query2.sql.clear;
  DataM1.Query2.sql.add('Select pressname from pressnames');
  DataM1.Query2.sql.add('where locationid = '+inttostr(tnames1.locationnametoid(ComboBoxLocation.text)));
  DataM1.Query2.sql.add('order by pressname');

  DataM1.Query2.open;
  While not DataM1.Query2.Eof do
  begin
    if DataM1.Query2.Fields[0].AsString <> aktpress then
    begin
      ComboBoxpress.Items.Add(DataM1.Query2.Fields[0].AsString);
    end;
    DataM1.Query2.next;
  end;
  DataM1.Query2.close;

  IF ComboBoxpress.items.count > 0 then
  begin
    ComboBoxpress.itemindex := 0;


    BitBtn1.enabled := true;
  End;
end;

procedure TFormnewlocation.ComboBoxLocationChange(Sender: TObject);
begin
  ComboBoxpress.items.clear;
  DataM1.Query2.sql.clear;
  DataM1.Query2.sql.add('Select pressname from pressnames');
  DataM1.Query2.sql.add('where locationid = '+inttostr(tnames1.locationnametoid(ComboBoxLocation.text)));
  DataM1.Query2.sql.add('order by pressname');

  DataM1.Query2.open;
  While not DataM1.Query2.eof do
  begin
    if DataM1.Query2.Fields[0].asstring <> aktpress then
    begin
      ComboBoxpress.items.add(DataM1.Query2.Fields[0].asstring);
    end;
    DataM1.Query2.next;
  end;
  DataM1.Query2.close;
  IF ComboBoxpress.items.count > 0 then
  begin
    ComboBoxpress.itemindex := 0;
    BitBtn1.enabled := true;
  End;
  ComboBoxpress.itemindex := 0;


end;

Function TFormnewlocation.checkplanonnewpress:boolean;
Begin

end;

end.
