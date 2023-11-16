unit Usepsearch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

type
  TFormsepsearch = class(TForm)
    Edit1: TEdit;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    RadioGroup1: TRadioGroup;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
  private
    Function compAB(Astring : String;
                               Bstring : string):Boolean;

  public
    { Public declarations }
    FoundY : Longint;
  end;

var
  Formsepsearch: TFormsepsearch;

implementation

uses Umain, Udata;

{$R *.dfm}

procedure TFormsepsearch.FormActivate(Sender: TObject);
Var
  I : Longint;
begin
  ComboBox1.Items.Clear;
  For i := 0 to formmain.StringGridHS.colcount-1 do
  begin
    ComboBox1.Items.add(formmain.StringGridHS.cells[i,0]);
  end;
  ComboBox1.itemindex := 0;
  FoundY := -1;
end;

procedure TFormsepsearch.BitBtn2Click(Sender: TObject);
Var
  T : String;
  x,y : Longint;
  foundone : boolean;
begin
  try
    foundone := false;
    T := uppercase(Edit1.text);
    foundy := 1;
    For y := 1 to formmain.StringGridHS.rowcount do
      SuperHSdata[y-1].Selected := false;
    IF foundy = 0 then
      foundy := 1;
    For y := foundy to formmain.StringGridHS.rowcount do
    begin
      for x := 0 to formmain.StringGridHS.colcount -1 do
      begin
        IF compab(t,uppercase(formmain.StringGridHS.cells[x ,y])) then
        begin
          foundy := y;
          SuperHSdata[y-1].Selected := true;
          IF y > formmain.StringGridHS.TopRow + formmain.StringGridHS.VisibleRowCount -1 then
            formmain.StringGridHS.TopRow := y;
          IF x > formmain.StringGridHS.leftcol + formmain.StringGridHS.VisiblecolCount -1 then
            formmain.StringGridHS.leftcol := x;
          formmain.StringGridHS.repaint;
          foundone := true;
          break;
        end;
      End;
      IF foundone then
        break
    end;
  Except
  end;
end;

procedure TFormsepsearch.BitBtn3Click(Sender: TObject);
Var
  T : String;
  x,y : Longint;
  foundone : Boolean;
begin
  try
    T := uppercase(Edit1.text);

    foundone := false;
    For y := 1 to formmain.StringGridHS.rowcount do
      SuperHSdata[y-1].Selected := false;
    IF foundy = 0 then
      foundy := 1;
    For y := foundy+1 to formmain.StringGridHS.rowcount do
    begin
      for x := 0 to formmain.StringGridHS.colcount -1 do
      begin
        IF compab(t,uppercase(formmain.StringGridHS.cells[x ,y])) then
        begin
          foundy := y;
          SuperHSdata[y-1].Selected := true;
          IF y > formmain.StringGridHS.TopRow + formmain.StringGridHS.VisibleRowCount -1 then
            formmain.StringGridHS.TopRow := y;
          IF x > formmain.StringGridHS.leftcol + formmain.StringGridHS.VisiblecolCount -1 then
            formmain.StringGridHS.leftcol := x;  
          formmain.StringGridHS.repaint;
          foundone := true;
          break;
        end;

      End;
      IF foundone then
        break
    end;
  Except
  end;
end;

procedure TFormsepsearch.BitBtn4Click(Sender: TObject);
Var
  N,Dnode,Pnode,enode,snode : ttreenode;   //  3359726   3353599 3355147
  I : Longint;
  pubdate : String;
  publication,edition,section : String;

begin
  try
    datam1.Query1.SQL.Clear;
    datam1.Query1.SQL.Add('Select distinct locationid,pubdate,publicationid,editionid,sectionid from pagetable');
    datam1.Query1.SQL.Add('where separation = ' + inttostr(SuperHSdata[foundy-1].separation));
    formmain.Tryopen(datam1.Query1);
    IF not datam1.Query1.eof then
    begin
      Dnode := nil;
      Pnode := nil;
      enode := nil;
      snode := nil;
      pubdate := datetostr(datam1.Query1.fields[1].asdatetime);
      publication := tnames1.publicationIDtoname(datam1.Query1.fields[2].asInteger);
      edition := tnames1.editionIDtoname(datam1.Query1.fields[3].asInteger);
      section := tnames1.SectionIDtoname(datam1.Query1.fields[4].asInteger);
      IF pubdate <> '' then
      begin
        For i := 0 to formmain.TreeViewpagelist.Items.Count-1 do
        begin
          IF formmain.TreeViewpagelist.Items[i].Level = 1 then
          begin
            IF pubdate = formmain.TreeViewpagelist.Items[i].Text then
            begin
              Dnode := formmain.TreeViewpagelist.Items[i];
              break;
            end;
          end;
        end;

        IF (dnode <> nil) And (publication <> '') then
        begin
          n := dnode.getFirstChild;
          While (n <> nil) and (pnode = nil) do
          begin
            IF n.Text = publication then
            begin
              pnode := n;
              break;
            end;
            n := n.getNextSibling;
          end;

        end;

        IF (pnode <> nil) And (edition <> '') then
        begin
          n := pnode.getFirstChild;
          While (n <> nil) and (enode = nil) do
          begin
            IF n.Text = edition then
            begin
              enode := n;
              break;
            end;
            n := n.getNextSibling;
          end;
        end;

        IF (enode <> nil) And (section <> '') then
        begin
          n := enode.getFirstChild;
          While (n <> nil) and (snode = nil) do
          begin
            IF n.Text = section then
            begin
              snode := n;
              break;
            end;
            n := n.getNextSibling;
          end;
        end;
        n := nil;

        IF Dnode <> nil then
          n := Dnode;
        IF pnode <> nil then
          n := pnode;
        IF enode <> nil then
          n := enode;
        IF snode <> nil then
          n := snode;
        IF n <> nil then
        Begin
          formmain.TreeViewpagelist.Selected := n;
          formmain.TreeViewpagelist.Selected.Expand(false);
          formmain.TreeViewpagelist.SetFocus;
          application.ProcessMessages;
          BitBtn2Click(self);
        End;
      End;
    End;
  Except

  end;
end;


Function TFormsepsearch.compAB(Astring : String;
                               Bstring : string):Boolean;
Begin
  result := false;
  Case RadioGroup1.ItemIndex of
    0 : Begin
          result := astring = bstring;
        end;
    1 : Begin
          result := pos(astring,bstring) > 0;
        end;


  end;

end;
end.
