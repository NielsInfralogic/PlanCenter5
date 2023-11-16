unit USelectlocationandproductions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFormselectlocalprod = class(TForm)
    Panel2: TPanel;
    Labelwizardheader1: TLabel;
    Labelwizardheader2: TLabel;
    Label2: TLabel;
    ComboBoxnewlocation: TComboBox;
    Panel1: TPanel;
    BitBtn6: TBitBtn;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    ComboBoxpress: TComboBox;
    procedure FormActivate(Sender: TObject);
    procedure ComboBoxnewlocationChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    procedure Getprodonlocation;
  public
    Defaultlocation : Longint;
    Defaultproductionid : Longint;
    Defaultpressid : Longint;

    Selectedproductionid : Longint;
    Selectedpressid : Longint;

    { Public declarations }
  end;

var
  Formselectlocalprod: TFormselectlocalprod;

implementation

uses umain,Udata;

{$R *.dfm}

Var
  Founddefaultid : Longint;
  Nprods : Longint;
  prods : array[0..300] of record
                             productionid : Longint;
                             pressid      : Longint;
                           end;



procedure TFormselectlocalprod.FormActivate(Sender: TObject);
begin
  ComboBoxnewlocation.Items := tnames1.locationnames;
  ComboBoxnewlocation.ItemIndex := 0;
  IF Defaultlocation > -1 then
    ComboBoxnewlocation.ItemIndex := ComboBoxnewlocation.Items.indexof(tnames1.locationIDtoname(Defaultlocation) );
  Getprodonlocation;
  ComboBoxpress.ItemIndex := 0;
  IF Founddefaultid > -1 then
    ComboBoxpress.ItemIndex := Founddefaultid;

  Selectedproductionid := prods[ComboBoxpress.ItemIndex].productionid;
  Selectedpressid  := prods[ComboBoxpress.ItemIndex].pressid;


end;


procedure TFormselectlocalprod.Getprodonlocation;
Var
  T : String;
Begin
  try
    Founddefaultid := -1;
    ComboBoxpress.Items.Clear;
    DataM1.Query1.sql.clear;
    DataM1.Query1.sql.add('select distinct p.pubdate,p.pressid,p.publicationid,p.productionid from pagetable p');
    DataM1.Query1.SQL.add('where p.locationid = ' +inttostr(tnames1.locationnametoid(ComboBoxnewlocation.Items[ComboBoxnewlocation.Itemindex])));
    DataM1.Query1.SQL.add('order by p.pubdate,p.publicationid,p.pressid');
    DataM1.Query1.open;
    While not DataM1.Query1.eof do
    begin
      T := '';
      T := T + datetostr(DataM1.Query1.fields[0].AsDateTime)+ ' ' + tnames1.publicationIDtoname(DataM1.Query1.fields[2].Asinteger)
        + ' ' + tnames1.pressnameIDtoname(DataM1.Query1.fields[1].Asinteger);
      ComboBoxpress.Items.add(T);
      prods[ComboBoxpress.Items.count-1].productionid := DataM1.Query1.fields[3].Asinteger;
      prods[ComboBoxpress.Items.count-1].pressid      := DataM1.Query1.fields[1].Asinteger;

      IF (Defaultproductionid = prods[ComboBoxpress.Items.count-1].productionid) and
         (Defaultpressid = prods[ComboBoxpress.Items.count-1].pressid) then
      begin
        Founddefaultid := ComboBoxpress.Items.count-1;
      end;

      DataM1.Query1.next;
    end;
    DataM1.Query1.close;

  Except

  end;
End;

procedure TFormselectlocalprod.ComboBoxnewlocationChange(Sender: TObject);
begin
  Getprodonlocation;
end;

procedure TFormselectlocalprod.BitBtn1Click(Sender: TObject);
begin
  Selectedproductionid := prods[ComboBoxpress.ItemIndex].productionid;
  Selectedpressid  := prods[ComboBoxpress.ItemIndex].pressid;
end;

end.
