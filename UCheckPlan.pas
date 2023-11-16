unit UCheckPlan;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls,
  Vcl.ExtCtrls;

type
  TFormCheckPlan = class(TForm)
    Panel3: TPanel;
    Label7: TLabel;
    GroupBox1: TGroupBox;
    ListView1: TListView;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    ProductionID : Integer;
  end;

var
  FormCheckPlan: TFormCheckPlan;

implementation

{$R *.dfm}
Uses
  UMain,UData,UTypes;

procedure TFormCheckPlan.BitBtn1Click(Sender: TObject);
begin
  FormCheckPlan.Close;
end;

procedure TFormCheckPlan.FormActivate(Sender: TObject);
var
  PublicationID : Integer;
  PressID, EditionID, SectionID,PressRunID : Integer;
  PubDate : TDateTime;
  li : TListItem;
  i : Integer;
begin
  ListView1.Items.Clear;

  PublicationID := 0;

  if (ProductionID = 0) then
    exit;

  DataM1.Query2.SQL.Clear;
  DataM1.Query2.SQL.Add('SELECT TOP 1 PublicationID,PubDate FROM Pagetable WITH (NOLOCK) WHERE ProductionID='+IntToStr(ProductionID));
  DataM1.Query2.Open();
  if not DataM1.Query2.Eof then
  begin
   PublicationID:= DataM1.Query2.Fields[0].AsInteger;
   PubDate := DataM1.Query2.Fields[1].AsDateTime;
  end;
  DataM1.Query2.Close();

  DataM1.Query2.SQL.Clear;
  DataM1.Query2.SQL.Add('SELECT DISTINCT PressID,EditionID,SectionID,COUNT(DISTINCT(PageName)),PressRunID FROM Pagetable WITH (NOLOCK) ');
  DataM1.Query2.SQL.Add('WHERE PublicationID='+IntToStr(PublicationID));
  DataM1.Query2.SQL.Add('AND PubDate=:pubd ');
  DataM1.Query2.SQL.Add('GROUP BY PressID,EditionID,SectionID,PressRunID');
  DataM1.Query2.SQL.Add('ORDER BY PressID,EditionID,SectionID');

  DataM1.Query2.ParamByName('pubd').AsDate := PubDate;
  DataM1.Query2.Open();
  while not DataM1.Query2.Eof do
  begin
   PressID := DataM1.Query2.Fields[0].AsInteger;
   EditionID := DataM1.Query2.Fields[1].AsInteger;
   SectionID := DataM1.Query2.Fields[2].AsInteger;


   li := ListView1.Items.Add;
   li.Caption := tNames1.PressnameIDtoName(PressID);
   li.SubItems.Add(tNames1.EditionIDtoName(EditionID));
   li.SubItems.Add(tNames1.SectionIDtoName(SectionID));
   li.SubItems.Add(IntToStr(DataM1.Query2.Fields[3].AsInteger));
   li.SubItems.Add('Checking..');
   li.SubItems.Add(IntToStr(DataM1.Query2.Fields[4].AsInteger));
   DataM1.Query2.Next;
  end;
  DataM1.Query2.Close();

  For i := 0 to ListView1.Items.count-1 do
  Begin
    try
      PressRunID := StrToInt(ListView1.Items[i].SubItems[4]);
      DataM1.Query2.SQL.Clear;
      DataM1.Query2.SQL.add('exec spCheckPlans');
      //DataM1.Query2.SQL.add('@ProductionID = ' + IntToStr(ProductionID));
      DataM1.Query2.SQL.add('@PressRunID = ' + IntToStr(PressRunID));
      DataM1.Query2.Open();
      if not DataM1.Query2.Eof  then
      begin
          ListView1.Items[i].SubItems[3] :=  DataM1.Query2.Fields[0].AsString;
      end;
      DataM1.Query2.Close();
    Except

    end;
  end;



 end;

end.
