unit UCurentstate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TFormcurrentstate = class(TForm)
    GroupBox1: TGroupBox;
    Editpages: TEdit;
    Label1: TLabel;
    Editripped: TEdit;
    Label2: TLabel;
    Editapproved: TEdit;
    Label3: TLabel;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label6: TLabel;
    Editplates: TEdit;
    Editimaged: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    procedure calc;
    { Private declarations }
  public
    pubdate       : tdatetime;
    publicationid : Longint;
    editionid     : Longint;
    Sectionid     : Longint;
    Locationid    : Longint;
    Pressid       : Longint;
    PressRunid    : Longint;

  end;

var
  Formcurrentstate: TFormcurrentstate;

implementation
Uses
  udata;

{$R *.dfm}

procedure TFormcurrentstate.FormActivate(Sender: TObject);
Begin
  calc;
end;

procedure TFormcurrentstate.calc;

procedure addselection;
Begin
  IF publicationid > 0 then
    DataM1.Query1.SQL.add('and publicationid = ' + inttostr(publicationid));
  IF editionid > 0 then
    DataM1.Query1.SQL.add('and editionid = ' + inttostr(editionid));
  IF Sectionid > 0 then
    DataM1.Query1.SQL.add('and Sectionid = ' + inttostr(Sectionid));
  IF Locationid > 0 then
    DataM1.Query1.SQL.add('and Locationid = ' + inttostr(Locationid));
  IF Pressid > 0 then
    DataM1.Query1.SQL.add('and Pressid = ' + inttostr(Pressid));
  IF PressRunid > 0 then
    DataM1.Query1.SQL.add('and PressRunid = ' + inttostr(PressRunid));
  IF pubdate > 0 then
    DataM1.Query1.SQL.add(' and '+  DataM1.makedatastr('',pubdate));

end;

begin
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.add('Select Count(distinct flatseparation) as antal from pagetable where active = 1');
  addselection;
  DataM1.Query1.open;
  Editplates.Text := DataM1.Query1.fields[0].asstring;
  DataM1.Query1.close;

  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.add('Select Count(distinct flatseparation) as antal from pagetable where active = 1 and status >= 50');
  addselection;
  DataM1.Query1.open;
  Editimaged.Text := DataM1.Query1.fields[0].asstring;
  DataM1.Query1.close;

  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.add('Select Count(distinct mastercopyseparationset) as antal from pagetable where active = 1');
  addselection;
  DataM1.Query1.open;
  Editpages.Text := DataM1.Query1.fields[0].asstring;
  DataM1.Query1.close;

  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.add('Select Count(distinct mastercopyseparationset) as antal from pagetable where active = 1 and status >= 10');
  addselection;
  DataM1.Query1.open;
  Editripped.Text := DataM1.Query1.fields[0].asstring;
  DataM1.Query1.close;

  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.add('Select Count(distinct mastercopyseparationset) as antal from pagetable where active = 1 and status >= 10 and (approved = 1 or approved = -1)');
  addselection;
  DataM1.Query1.open;
  Editapproved.Text := DataM1.Query1.fields[0].asstring;
  DataM1.Query1.close;

end;

procedure TFormcurrentstate.BitBtn2Click(Sender: TObject);
begin
  calc;
end;

procedure TFormcurrentstate.BitBtn1Click(Sender: TObject);
begin
  close;
end;

end.
