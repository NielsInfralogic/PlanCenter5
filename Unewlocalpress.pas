unit Unewlocalpress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Udata,Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFormnewlocalpress = class(TForm)
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
    Editplanname: TEdit;
    Label3: TLabel;
    Panel3: TPanel;
    Image2: TImage;
    Label4: TLabel;
    Label5: TLabel;
    Panel4: TPanel;
    Image3: TImage;
    Label6: TLabel;
    Label7: TLabel;
    RadioGroupapproval: TRadioGroup;
    RadioGrouprelease: TRadioGroup;
    procedure FormActivate(Sender: TObject);
    procedure ComboBoxLocationChange(Sender: TObject);
    procedure ComboBoxpressClick(Sender: TObject);
  private
//    Function checkplanonnewpress:boolean;
    { Private declarations }
  public
    aktlocation : string;
    aktpress    : string;
    aktpublication : string;
    aktpublicationdate : Tdatetime;
  end;

var
  Formnewlocalpress: TFormnewlocalpress;

implementation

{$R *.dfm}

Uses
  umain;

procedure TFormnewlocalpress.FormActivate(Sender: TObject);
begin
  ComboBoxLocation.items := tnames1.locationnames;
  ComboBoxLocation.itemindex := ComboBoxLocation.items.indexof(aktlocation);

  ComboBoxpress.items.clear;
  DataM1.Query2.sql.clear;
  DataM1.Query2.sql.add('Select pressname from pressnames');
  DataM1.Query2.sql.add('where locationid = '+inttostr(tnames1.locationnametoid(ComboBoxLocation.text)));
  DataM1.Query2.sql.add('order by pressname');

  DataM1.Query2.Open;
  While not DataM1.Query2.Eof do
  begin
    if DataM1.Query2.Fields[0].AsString <> aktpress then
    begin
      ComboBoxpress.items.add(DataM1.Query2.Fields[0].AsString);
    end;
    DataM1.Query2.Next;
  end;
  DataM1.Query2.Close;

  IF ComboBoxpress.items.count > 0 then
  begin
    ComboBoxpress.itemindex := 0;
    Editplanname.Text := ComboBoxpress.text+ ' ' + aktpublication+' ' +datetostr(aktpublicationdate);

    BitBtn1.enabled := true;
  End;
end;

procedure TFormnewlocalpress.ComboBoxLocationChange(Sender: TObject);
begin
  ComboBoxpress.items.clear;
  DataM1.Query2.sql.clear;
  DataM1.Query2.sql.add('Select pressname from pressnames');
  DataM1.Query2.sql.add('where locationid = '+inttostr(tnames1.locationnametoid(ComboBoxLocation.text)));
  DataM1.Query2.sql.add('order by pressname');

  DataM1.Query2.open;
  While not DataM1.Query2.eof do
  begin
    if DataM1.Query2.fields[0].asstring <> aktpress then
    begin
      ComboBoxpress.items.add(DataM1.Query2.fields[0].asstring);
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

  Editplanname.Text := ComboBoxpress.text+ ' ' + aktpublication+' ' +datetostr(aktpublicationdate);
end;

procedure TFormnewlocalpress.ComboBoxpressClick(Sender: TObject);
begin
  Editplanname.Text := ComboBoxpress.text+ ' ' + aktpublication+' ' +datetostr(aktpublicationdate);
end;

{Function TFormnewlocalpress.checkplanonnewpress:boolean;
Begin
  // kommer
end;
}
end.
