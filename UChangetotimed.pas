unit UChangetotimed;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, UImages;

type
  TFormChangetotimed = class(TForm)
    Panel3: TPanel;
    Image2: TImage;
    Label7: TLabel;
    Label8: TLabel;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    Edit1: TEdit;
    BitBtn2: TBitBtn;
    GroupBox1: TGroupBox;
    TreeVieweds: TTreeView;
    procedure TreeViewedsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TreeViewedsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure BitBtn3Click(Sender: TObject);
  private
    Function getimidxfromstate(timedfrom : Longint;
                               Edstate : Longint):Longint;
    { Private declarations }
  public
    Toedi : Longint;
    productionid : Longint;
    procedure LoadData(ProductionIDtoload : Longint);
  end;

var
  FormChangetotimed: TFormChangetotimed;

implementation
uses Udata,umain,utypes;
{$R *.dfm}

Function TFormChangetotimed.getimidxfromstate(timedfrom : Longint;
                                            Edstate : Longint):Longint;
Begin
  result := 11;
  IF timedfrom > 0 then
  Begin
    Case Edstate OF
      0 : Begin
            result :=  243;
          end;
      1..2 : Begin
               result :=  227;
             end;
      10 : Begin
             result :=  229;
          end;

    End;
  end
  Else
  begin
    IF Edstate = 10 then
    begin
      result :=  229;
    end;

  end;

end;

procedure TFormChangetotimed.LoadData(ProductionIDtoload : Longint);
Var

  i,aied,itree : Longint;
  found : Boolean;
  Shortnameoffromed,Nameoffromed : String;
  anode,Tinode,gnode : ttreenode;

  T,wheremains : String;
  trdat : PTTreeViewpagestype;

begin
  TreeVieweds.Items.Clear;
  //gnode := Ltree.Items.addchildobject(curnodes[i-1],datetostr(aktpubdate),trdat);
  wheremains := '(-99';
  aied := -1;
  productionid := ProductionIDtoload;


  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.add('Select distinct p1.editionid,n.name,pr.TimedEditionFrom,pr.TimedEditionState,pr.fromzone from pagetable p1, editionnames n, pressrunid pr');
  DataM1.Query1.SQL.add('where p1.productionid = ' + inttostr(productionid));
  DataM1.Query1.SQL.add('and p1.editionid = n.editionid ');
  DataM1.Query1.SQL.add('and p1.pressrunid = pr.pressrunid ');
  DataM1.Query1.SQL.add('and pr.TimedEditionFrom < 1 ');
  DataM1.Query1.SQL.add('and not exists(select p2.uniquepage from pagetable p2');
  DataM1.Query1.SQL.add('where p1.editionid = p2.editionid and p2.uniquepage <> 1)');
  DataM1.Query1.SQL.add('Order by pr.fromzone,n.name,p1.editionid');

  DataM1.Query1.open;
  While not DataM1.Query1.eof do
  begin
    IF aied <> DataM1.Query1.Fields[0].asinteger then
    begin
      aied := DataM1.Query1.Fields[0].asinteger;
      gnode := TreeVieweds.Items.addchildobject(nil,tnames1.editionIDtoname(aied),nil);
      gnode.imageindex := getimidxfromstate(0,DataM1.Query1.Fields[3].asinteger);
      gnode.selectedindex := gnode.imageindex;
      gnode.Expand(true);
      wheremains := wheremains + ','+inttostr(aied);
    end;
    DataM1.Query1.next;
  end;
  DataM1.Query1.close;
  wheremains := wheremains + ')';

  aied := -1;
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.add('Select distinct p1.editionid,n.name,pr.TimedEditionFrom,pr.TimedEditionState,pr.fromzone from pagetable p1, editionnames n, pressrunid pr');
  DataM1.Query1.SQL.add('where p1.productionid = ' + inttostr(productionid));
  DataM1.Query1.SQL.add('and p1.editionid = n.editionid ');
  DataM1.Query1.SQL.add('and p1.pressrunid = pr.pressrunid ');
  DataM1.Query1.SQL.add('and p1.editionid not in ' + wheremains);
  DataM1.Query1.SQL.add('and pr.TimedEditionFrom < 1 ');
  DataM1.Query1.SQL.add('Order by pr.fromzone,n.name,p1.editionid');
  DataM1.Query1.open;
  While not DataM1.Query1.eof do
  begin
    IF aied <> DataM1.Query1.Fields[0].asinteger then
    begin
      aied := DataM1.Query1.Fields[0].asinteger;
      gnode := TreeVieweds.Items.addchildobject(nil,tnames1.editionIDtoname(aied),nil);
      gnode.imageindex := getimidxfromstate(0,DataM1.Query1.Fields[3].asinteger);
      gnode.selectedindex := gnode.imageindex;
      gnode.Expand(true);
    End;
    DataM1.Query1.next;
  end;
  DataM1.Query1.close;

  aied := -1;
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.add('Select distinct p1.editionid,n.name,pr.TimedEditionFrom,pr.TimedEditionState,pr.fromzone from pagetable p1, editionnames n, pressrunid pr');
  DataM1.Query1.SQL.add('where p1.productionid = ' + inttostr(productionid));
  DataM1.Query1.SQL.add('and p1.editionid = n.editionid ');
  DataM1.Query1.SQL.add('and p1.pressrunid = pr.pressrunid ');
  DataM1.Query1.SQL.add('and pr.TimedEditionFrom > 0 ');
  DataM1.Query1.SQL.add('Order by pr.fromzone,n.name,p1.editionid');
  DataM1.Query1.open;
  While not DataM1.Query1.eof do
  begin
    IF aied <> DataM1.Query1.Fields[0].asinteger then
    begin
      aied := DataM1.Query1.Fields[0].asinteger;
      For itree := 0 to TreeVieweds.Items.Count-1 do
      begin
        T := tnames1.editionIDtoname(DataM1.Query1.fields[2].AsInteger);
        IF TreeVieweds.Items[itree].Text = T then
        begin
          if TreeVieweds.Items[itree].Level = 0 then
          begin
            New(trdat);
            gnode := TreeVieweds.Items.addchildobject(TreeVieweds.Items[itree],DataM1.Query1.fields[1].asstring,trdat);
            gnode.imageindex := getimidxfromstate(1,DataM1.Query1.Fields[3].asinteger);
            gnode.selectedindex := gnode.imageindex;
            gnode.StateIndex := 1;
            gnode.Expand(true);
          end
          else
          begin
            New(trdat);
            gnode := TreeVieweds.Items.addchildobject(TreeVieweds.Items[itree].Parent,DataM1.Query1.fields[1].asstring,trdat);
            gnode.imageindex := getimidxfromstate(1,DataM1.Query1.Fields[3].asinteger);
            gnode.selectedindex := gnode.imageindex;
            gnode.StateIndex := 1;
            gnode.Expand(true);
          end;
        End;
      End;
    End;
    DataM1.Query1.next;
  End;
  DataM1.Query1.Close;




end;


procedure TFormChangetotimed.TreeViewedsDragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := (Source = TreeVieweds);
end;

procedure TFormChangetotimed.TreeViewedsDragDrop(Sender, Source: TObject;
  X, Y: Integer);
Var
  Anode,Nnode : TTreeNode;

  AnItem: TTreeNode;
  AttachMode: TNodeAttachMode;
  HT: THitTests;
  trdat : PTTreeViewpagestype;
begin
  Anode := TreeVieweds.GetNodeAt(X, Y);

  IF Source = TreeVieweds then
  begin
    if TreeVieweds.Selected = nil then Exit;
    HT := TreeVieweds.GetHitTestInfoAt(X, Y) ;
    AnItem := TreeVieweds.GetNodeAt(X, Y) ;
    if (HT -[htOnItem, htOnIcon, htNowhere, htOnIndent] <> HT) then
    begin

      if AnItem <> nil then
      Begin
        IF AnItem.Level = 0 then
        begin // addes til grund node
          TreeVieweds.Selected.MoveTo(AnItem, naAddChild);
        end
        else
        begin // flyttes blant subnoder
          TreeVieweds.Selected.MoveTo(AnItem, naInsert) ;
        end;
        Nnode := TreeVieweds.Selected;
        IF Nnode.imageindex = 11 then
        begin
          Nnode.imageindex := 245;
          Nnode.selectedindex := 245;
          Nnode.stateindex := 1;
          anode.Expand(true);
        End;
      End;
    end;
  end;
end;


procedure TFormChangetotimed.BitBtn3Click(Sender: TObject);

Var
  n,Cn : ttreenode;

  locationid : Longint;
  Pubdate : Tdatetime;
  publicationid : Longint;
  EdordN,editionidFrom,editionidTo,editionid,akteditionid : Longint;


Procedure SetEdOrder(EditionID : Longint;
                     Edorder : Longint;
                     FromEdid : Longint;
                     Toedid   : Longint);
Var
  apressrunid : Longint;
Begin
  DataM1.Query1.SQL.clear;
  DataM1.Query1.SQL.add('Select distinct pressrunid from pagetable');
  DataM1.Query1.SQL.add('where productionid = ' + inttostr(productionid));
  DataM1.Query1.SQL.add('and editionid = ' + inttostr(editionid));
  DataM1.Query1.open;
  While not DataM1.Query1.eof do
  begin
    DataM1.Query2.SQL.clear;
    DataM1.Query2.SQL.add('update pressrunid set fromzone = '+inttostr(Edorder));
    DataM1.Query2.SQL.add(', TimedEditionFrom = '+inttostr(FromEdid));
    DataM1.Query2.SQL.add(', TimedEditionTo = '+inttostr(Toedid));
    DataM1.Query2.SQL.add(', TimedEditionState = 0');
    DataM1.Query2.SQL.add('where pressrunid = ' + DataM1.Query1.fields[0].asstring);
    DataM1.Query2.ExecSQL;
    DataM1.Query1.next;
  end;
  DataM1.Query1.close;
end;


begin
  n := TreeVieweds.TopItem;

  While n <> nil do
  begin
    EdordN :=0;
    editionidFrom := 0;
    editionidTo   := 0;
    if n.HasChildren then
    begin
      EdordN := 1;
      akteditionid := tnames1.editionnametoid(n.text);
      cn := n.getFirstChild;
      editionidTo   := tnames1.editionnametoid(cn.Text);
      SetEdOrder(akteditionid,1,editionidFrom,editionidTo);
      While cn <> nil do
      begin
        Inc(EdordN);
        editionidFrom := akteditionid;
        akteditionid := tnames1.editionnametoid(cn.text);
        cn := cn.getNextSibling;
        IF cn <> nil then
          editionidTo := tnames1.editionnametoid(cn.Text)
        Else
          editionidTo := 0;

        SetEdOrder(akteditionid,EdordN,editionidFrom,editionidTo);

      End;
    end
    Else
    begin
      SetEdOrder(tnames1.editionnametoid(n.text),0,0,0);
    end;

    n := n.getNextSibling;
  end;

end;

end.
