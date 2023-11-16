unit UEditionpageplan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, PBExListview, StdCtrls, Buttons, ExtCtrls, ImgList,
  Menus, Grids;

type
  TFormeditionpageplan = class(TForm)
    Panel2: TPanel;
    Image1: TImage;
    Label5: TLabel;
    Label6: TLabel;
    Panel1: TPanel;
    PopupMenued: TPopupMenu;
    StringGrideds: TStringGrid;
    GroupBox1: TGroupBox;
    Splitter1: TSplitter;
    ListBoxpresssequence: TListBox;
    BitBtn2: TBitBtn;
    BitBtn5: TBitBtn;
    Panelwizz: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    ComboBoxEdition: TComboBox;
    Button1: TButton;
    ComboBoxIssue: TComboBox;
    Buttondelete: TButton;
    Button2: TButton;
    EditNed: TEdit;
    Paneledit: TPanel;
    BitBtn6: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn1: TBitBtn;
    BitBtn7: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edpop1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure StringGridedsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ButtondeleteClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
  private
    { Private declarations }
  public

    NRemoteeditionnames : Longint;
    Remoteeditionnames : Array[1..400] of string;

    Dontinit : Boolean;
    NEditions : Longint;
    Npressseqord : Longint;
    pressseqord : Array[1..100] of record
                                     edid   : Longint;
                                     ednum  : Longint;
                                     ordnum : Longint;
                                   end;
//    procedure Remoteinit;
    procedure init;
    procedure setresult;
    Function getuniqueEdID(Editionname : string;
                           pagename : String;
                           Sectionname : string):Integer;
    Function ednumbertoID(number : Integer;
                          grisrow : Integer):Integer;
    { Public declarations }

  end;

var
  Formeditionpageplan: TFormeditionpageplan;

implementation



uses Ueditionplan,utypes, umain,Uaddpressrun, Uaddplan, Uprodplan,
  Ueditionorder, Udata,uplanframe, UUtils;

Var

  ms : array[1..100] of tmenuitem;

  activatedone : Boolean;
  delcol : Longint;
{$R *.dfm}

procedure TFormeditionpageplan.FormActivate(Sender: TObject);
Begin
  init;
  Buttondelete.Enabled := false;
end;







procedure TFormeditionpageplan.FormCreate(Sender: TObject);
begin
  Dontinit := false;
  activatedone := false;
end;

procedure TFormeditionpageplan.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  activatedone := false;
  CanClose := true;
end;



procedure TFormeditionpageplan.edpop1Click(Sender: TObject);
Var
  acol,arow : Integer;
  T : String;
begin
  T := tmenuitem(sender).Caption;
  IF T = StringGrideds.Cells[1,0] then
    T := '';
  For acol := StringGrideds.Selection.Left to StringGrideds.Selection.Right do
  begin
    For arow := StringGrideds.Selection.top to StringGrideds.Selection.Bottom do
    begin
      StringGrideds.Cells[ACol,ARow] := T;
    end;
  end;
  //edit1.Text := inttostr(tmenuitem(sender).tag);
end;

procedure TFormeditionpageplan.Button1Click(Sender: TObject);

Var
  I : Integer;
  foundsame : Boolean;
begin
  foundsame := false;
  For i := 1 to StringGrideds.ColCount-1 do
  begin
    if StringGrideds.Cells[i,0] = ComboBoxEdition.Text then
    begin
      foundsame := true;
    end;
  end;

  IF foundsame then
  begin
    beep;
    MessageDlg(formmain.InfraLanguage1.Translate('This edition already exist'), mtInformation,[mbOk], 0);
    exit;
  end;

  StringGrideds.ColCount := StringGrideds.ColCount + 1;
  StringGrideds.Cells[StringGrideds.ColCount-1,0] := ComboBoxEdition.Text;

  ListBoxpresssequence.Items.Add(ComboBoxEdition.Text);

  For i := 1 to StringGrideds.rowcount-1 do
  begin
    StringGrideds.Cells[StringGrideds.ColCount-1,i] := '';
  end;

  ms[StringGrideds.rowcount-1] := tmenuitem.Create(StringGrideds);
  ms[StringGrideds.rowcount-1].Caption := ComboBoxEdition.Text;

  ms[StringGrideds.rowcount-1].Tag := 100 + StringGrideds.rowcount-1;
  ms[StringGrideds.rowcount-1].OnClick := edpop1Click;
  PopupMenued.Items.Add(ms[StringGrideds.rowcount-1]);

end;

procedure TFormeditionpageplan.BitBtn3Click(Sender: TObject);
Begin
  setresult;
end;


procedure TFormeditionpageplan.setresult;

Var
  I : Longint;
begin
  NEditions := StringGrideds.colcount-1;
  For i := 0 to ListBoxpresssequence.items.count-1 do
  begin
    pressseqord[i+1].edid := tnames1.editionnametoid(ListBoxpresssequence.Items[i]);
  end;
end;

Function TFormeditionpageplan.ednumbertoID(number : Integer;
                                           grisrow : Integer):Integer;
Var
  T : String;
Begin
  T:= StringGrideds.Cells[number,grisrow];
  IF T = '' then
    result := tnames1.editionnametoid(StringGrideds.Cells[1,0])
  else
    result := tnames1.editionnametoid(T);
end;


Function TFormeditionpageplan.getuniqueEdID(Editionname : string;
                                            pagename : String;
                                            Sectionname : string):Integer;

Var
  I,edcol,pagerow : Longint;
  found : boolean;
Begin
  edcol := 1;
  found := false;
  For i := 1 to StringGrideds.colcount-1 do
  begin
    if StringGrideds.cells[i,0] = Editionname then
    begin
      edcol := i;
      break;
    end;
  end;

  pagerow := 1;
  For i := 1 to StringGrideds.rowcount-1 do
  Begin
    IF sectionname + ' ' + pagename = StringGrideds.cells[0,i] then
    begin
      pagerow := i;
      break;
    end;
  end;

  IF StringGrideds.cells[edcol,pagerow] = StringGrideds.cells[edcol,0] then
  begin
    result := tnames1.editionnametoid(StringGrideds.cells[edcol,0]);
    found := true;
    exit;
  end;

  if StringGrideds.cells[edcol,pagerow] = '' then
  begin
    result := tnames1.editionnametoid(StringGrideds.cells[1,0]);
    found := true;
    exit;
  end
  else
  begin
    result := tnames1.editionnametoid(StringGrideds.cells[edcol,pagerow]);
    found := true;
  end;

  IF Not found then
    result := tnames1.editionnametoid(Editionname);

end;



procedure TFormeditionpageplan.StringGridedsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var
  ACol, ARow : Longint;
begin
  StringGrideds.MouseToCell(X, Y,ACol, ARow);
  if acol >= 2 then
  Begin
    Buttondelete.Enabled := true;
    delcol := acol;
  End
  else
    Buttondelete.Enabled := false;

end;

procedure TFormeditionpageplan.ButtondeleteClick(Sender: TObject);

Var
  I : Longint;

  deletetinged : string;
  x,y : Longint;

begin
  IF delcol+1 = StringGrideds.colcount then
  begin
    deletetinged := StringGrideds.cells[StringGrideds.colcount-1,0];

    For I := PopupMenued.Items.Count-1 downto 0 do
    begin
      IF PopupMenued.Items[i].Caption = deletetinged then
      begin
        PopupMenued.Items.Delete(i);
      end;
    end;
    StringGrideds.cells[StringGrideds.colcount-1,0] := '';
    StringGrideds.colcount := StringGrideds.colcount -1;

  end
  else
  begin
    deletetinged := StringGrideds.cells[delcol,0];

    For x := delcol to StringGrideds.colcount-2 do
    begin
      For y := 0 to StringGrideds.rowcount-1 do
      Begin
        StringGrideds.cells[x,y] := StringGrideds.cells[x+1,y]
      end;
    end;


    For I := PopupMenued.Items.Count-1 downto 0 do
    begin
      IF PopupMenued.Items[i].Caption = deletetinged then
      begin
        PopupMenued.Items.Delete(i);
      end;
    end;

    StringGrideds.cells[StringGrideds.colcount-1,0] := '';
    StringGrideds.colcount := StringGrideds.colcount -1;

  end;

  I := ListBoxpresssequence.Items.IndexOf(deletetinged);
  ListBoxpresssequence.Items.Delete(I);

  StringGrideds.Repaint;
  Buttondelete.Enabled := false;
end;

procedure TFormeditionpageplan.BitBtn2Click(Sender: TObject);
begin
  IF ListBoxpresssequence.ItemIndex > 0 then
  begin
    ListBoxpresssequence.Items.Move(ListBoxpresssequence.ItemIndex,ListBoxpresssequence.ItemIndex-1);
  end;
end;

procedure TFormeditionpageplan.BitBtn5Click(Sender: TObject);
begin
  IF ListBoxpresssequence.ItemIndex < ListBoxpresssequence.Items.Count-2 then
  begin
    ListBoxpresssequence.Items.Move(ListBoxpresssequence.ItemIndex,ListBoxpresssequence.ItemIndex+1);
  end;

end;

procedure TFormeditionpageplan.Button2Click(Sender: TObject);
Var
  I : Longint;
  T : String;
begin
  For i := 2 to strtoint(EditNed.text) do
  begin
    T := inttostr(I);
    IF length(T) = 1 then
      T := '0'+t;
    ComboBoxEdition.ItemIndex := ComboBoxEdition.Items.IndexOf(t);
    Button1Click(self);

    StringGrideds.Cells[StringGrideds.ColCount-1,1] := T;

  end;

end;

(*
procedure TFormeditionpageplan.Remoteinit;
Var

  I,isec,ip : Longint;

  i5,irow : Longint;
  T : string;
  Fpage : String;

begin
  StringGrideds.ColCount := 2;
  StringGrideds.RowCount := 2;

  ComboBoxedition.Items := tNames1.Editionnames;
  ComboBoxedition.Itemindex := 0;

  ComboBoxIssue.Items := tNames1.issuenames;
  ComboBoxIssue.Itemindex := 0;

  StringGrideds.Cells[0,0] := 'Pages';

  PopupMenued.Items.Clear;

  StringGrideds.Cells[1,0] := Formaddplan.ComboBoxedition.text;
  ListBoxpresssequence.Items.clear;
  ListBoxpresssequence.Items.add(Formaddplan.ComboBoxedition.text);
  ms[1] := tmenuitem.Create(StringGrideds);
  ms[1].Caption := StringGrideds.Cells[1,0];
  ms[1].Tag := 100 + 1;
  ms[1].OnClick := edpop1Click;
  PopupMenued.Items.Add(ms[1]);


  For isec := 1 to Nplanpagesections do
  begin
    for ip := 1 to planpagenames[isec].Npages do
    begin
      StringGrideds.Cells[0,StringGrideds.RowCount-1] := FormAddpressrun.PBExListviewSections.Items[planpagenames[isec].pages[ip].seci].caption + ' ' + planpagenames[isec].pages[ip].name;
      StringGrideds.Cells[1,StringGrideds.RowCount-1] := Remoteeditionnames[1];
//      planpagenames[isec].pages[ip].gridrow := StringGrideds.RowCount-1;
      StringGrideds.RowCount := StringGrideds.RowCount+1;
    end;
  end;

  StringGrideds.RowCount := StringGrideds.RowCount-1;
  StringGrideds.Cells[1,0] := Remoteeditionnames[1];

  for i5 := 2 to NRemoteeditionnames do
  begin
    StringGrideds.ColCount := StringGrideds.ColCount + 1;
    StringGrideds.Cells[StringGrideds.ColCount-1,0] := Remoteeditionnames[i5];
    For i := 1 to StringGrideds.rowcount-1 do
    begin
      StringGrideds.Cells[StringGrideds.ColCount-1,i] := '';//Remoteeditionnames[i5];
    end;
  End;

  For i := 2 to StringGrideds.ColCount-1 do
  begin
    For irow := 1 to StringGrideds.RowCount-1 do
    begin
      StringGrideds.Cells[i,irow] := '';
    End;
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.add('Select distinct pagename from pagetable');
    DataM1.Query1.SQL.add('where productionid = '+inttostr(Tplantreedata(formmain.TreeViewplan.Selected.Data^).productionid));
    DataM1.Query1.SQL.add('and editionid = ' + inttostr(tnames1.editionnametoid(StringGrideds.Cells[i,0])));
    DataM1.Query1.SQL.add('and Uniquepage = 1 ');
    DataM1.Query1.open;

    While not DataM1.Query1.eof do
    begin
      Fpage := DataM1.Query1.fields[0].asstring;
      For irow := 1 to StringGrideds.RowCount-1 do
      begin
        T := StringGrideds.Cells[0,irow];
        Delete(T,1,pos(' ',T));
        IF T = Fpage then
        begin
          StringGrideds.Cells[i,irow] := StringGrideds.Cells[i,0];
          break;
        end;
      End;
      DataM1.Query1.Next;
    end;
    DataM1.Query1.close;

  End;

  activatedone := true;
end;
*)

procedure TFormeditionpageplan.init;
Var

  aktedID,I,isec,ip : Longint;

  i5,irow,frow : Longint;
//  T,akted : string;
  Fpage{,commoned} : String;

begin
  StringGrideds.ColCount := 2;
  StringGrideds.RowCount := 2;

  ComboBoxedition.Items := tNames1.Editionnames;
  ComboBoxedition.Itemindex := 0;

  ComboBoxIssue.Items := tNames1.issuenames;
  ComboBoxIssue.Itemindex := 0;

  StringGrideds.Cells[0,0] := 'Pages';

  PopupMenued.Items.Clear;

  StringGrideds.Cells[1,0] := Formaddplan.ComboBoxedition.text;
  ListBoxpresssequence.Items.clear;
  ListBoxpresssequence.Items.add(Formaddplan.ComboBoxedition.text);
  ms[1] := tmenuitem.Create(StringGrideds);
  ms[1].Caption := StringGrideds.Cells[1,0];
  ms[1].Tag := 100 + 1;
  ms[1].OnClick := edpop1Click;
  PopupMenued.Items.Add(ms[1]);


  For isec := 1 to Nplanpagesections do
  begin
    for ip := 1 to planpagenames[isec].Npages do
    begin
      StringGrideds.Cells[0,StringGrideds.RowCount-1] := FormAddpressrun.PBExListviewSections.Items[planpagenames[isec].pages[ip].seci].caption + ' ' + planpagenames[isec].pages[ip].name;
      StringGrideds.Cells[1,StringGrideds.RowCount-1] := StringGrideds.Cells[1,0];
//      planpagenames[isec].pages[ip].gridrow := StringGrideds.RowCount-1;
      StringGrideds.RowCount := StringGrideds.RowCount+1;
    end;
  end;

  StringGrideds.RowCount := StringGrideds.RowCount-1;

  IF plateframespublicationid <> -1 then
  begin
    IF Formmain.Limiteditionselection(plateframespublicationid,ComboBoxEdition.Items) then
      ComboBoxEdition.Itemindex := 0;
  end;
  IF formprodplan.Editmode = PLANADDMODE_APPLY then
  begin
    IF Formeditionorder.ListBox1.Items.Count > 1 then
    begin
      for i5 := 1 to Formeditionorder.ListBox1.Items.Count-1 do
      begin
        StringGrideds.ColCount := StringGrideds.ColCount + 1;
        StringGrideds.Cells[StringGrideds.ColCount-1,0] := Formeditionorder.ListBox1.Items[i5];

        For i := 1 to StringGrideds.rowcount-1 do
        begin
          StringGrideds.Cells[StringGrideds.ColCount-1,i] := '';
        end;

        ms[StringGrideds.rowcount-1] := tmenuitem.Create(StringGrideds);
        ms[StringGrideds.rowcount-1].Caption := Formeditionorder.ListBox1.Items[i5];

        ms[StringGrideds.rowcount-1].Tag := 100 + StringGrideds.rowcount-1;
        ms[StringGrideds.rowcount-1].OnClick := edpop1Click;
        PopupMenued.Items.Add(ms[StringGrideds.rowcount-1]);

        DataM1.Query1.SQL.Clear;
        DataM1.Query1.SQL.add('Select distinct pagename,sectionid from pagetable');
        DataM1.Query1.SQL.add('where productionid = '+inttostr(Tplantreedata(formmain.TreeViewplan.Selected.Data^).productionid));
        DataM1.Query1.SQL.add('and editionid = ' + inttostr(tnames1.editionnametoid(Formeditionorder.ListBox1.Items[i5])));
        DataM1.Query1.open;
        while not DataM1.Query1.eof do
        begin
          For i := 1 to StringGrideds.rowcount-1 do
          begin
            if StringGrideds.Cells[0,i] = tnames1.sectionIDtoname(DataM1.Query1.fieldbyname('sectionid').asinteger) + ' ' + DataM1.Query1.fieldbyname('pagename').asstring then
            begin
              StringGrideds.Cells[StringGrideds.ColCount-1,i] := Formeditionorder.ListBox1.Items[i5];
            end;
          end;
          DataM1.Query1.next;
        end;
        DataM1.Query1.close;
      end; // i5

      IF Formprodplan.editmode >= PLANADDMODE_CREATE then
      begin
        IF StringGrideds.ColCount > 2 then
        Begin
          For i := 1 to StringGrideds.ColCount-1 do
          begin
            For irow := 1 to StringGrideds.RowCount-1 do
            begin
              StringGrideds.Cells[i,irow] := '';
            End;
          end;


          DataM1.Query1.SQL.Clear;                //0         1        2     3
          DataM1.Query1.SQL.add('Select distinct p1.pagename,e.Name,s.Name,e2.Name from pagetable p1, PageTable p2, EditionNames e, SectionNames s,EditionNames e2');
          DataM1.Query1.SQL.add('where p1.productionid = '+inttostr(Tplantreedata(formmain.TreeViewplan.Selected.Data^).productionid));
          DataM1.Query1.SQL.add('and p1.Uniquepage <> 1');
          DataM1.Query1.SQL.add('and p2.MasterCopySeparationSet = p1.MasterCopySeparationSet');
          DataM1.Query1.SQL.add('and p2.UniquePage = 1');
          DataM1.Query1.SQL.add('and p1.EditionID = e.EditionID');
          DataM1.Query1.SQL.add('and p2.EditionID = e2.EditionID');
          DataM1.Query1.SQL.add('and p1.SectionID = s.SectionID');
          DataM1.Query1.SQL.add('order by e.Name,s.Name,p1.pagename');
          IF Prefs.debug then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'Getplanedpages.sql');
          DataM1.Query1.open;
          While not DataM1.Query1.eof do
          begin
//            For i := 2 to StringGrideds.ColCount-1 do
            For i := 1 to StringGrideds.ColCount-1 do
            begin
              IF StringGrideds.Cells[i,0] = DataM1.Query1.fields[1].asstring then
              begin
                Fpage := DataM1.Query1.fields[2].asstring +' '+ DataM1.Query1.fields[0].asstring;
                For irow := 1 to StringGrideds.RowCount-1 do
                begin
                  IF StringGrideds.Cells[0,irow] = Fpage then
                  begin
                    StringGrideds.Cells[i,irow] := DataM1.Query1.fields[3].asstring;
                    frow := irow;
                    break;
                  end;
                End;
              End;
            end;

            For i := 2 to StringGrideds.ColCount-1 do
            begin
              IF StringGrideds.Cells[i,0] = DataM1.Query1.fields[3].asstring then
              begin
                Fpage := DataM1.Query1.fields[2].asstring +' '+ DataM1.Query1.fields[0].asstring;
                StringGrideds.Cells[i,frow] := DataM1.Query1.fields[3].asstring;
                break;
              End;
            end;


            DataM1.Query1.Next;
          End;
          DataM1.Query1.close;

          IF (Formprodplan.ItsArepair) or (true) then
          begin
//            For i := 2 to StringGrideds.ColCount-1 do
            For i := 1 to StringGrideds.ColCount-1 do
            begin
              aktedID := tnames1.editionnametoid(StringGrideds.Cells[i,0]);

              DataM1.Query1.SQL.Clear;                //0          1
              DataM1.Query1.SQL.add('Select distinct p.pagename,s.Name from PageTable p, EditionNames e, SectionNames s ');
              DataM1.Query1.SQL.add('where p.productionid = '+inttostr(Tplantreedata(formmain.TreeViewplan.Selected.Data^).productionid));
              DataM1.Query1.SQL.add('and p.Uniquepage = 1');
              DataM1.Query1.SQL.add('and p.editionid = ' + inttostr(aktedID));
              DataM1.Query1.SQL.add('and p.SectionID = s.SectionID');
              DataM1.Query1.SQL.add('order by s.Name,p.pagename');
              IF Prefs.debug then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'repaired.sql');
              DataM1.Query1.open;
              While not DataM1.Query1.eof do
              begin
                Fpage := DataM1.Query1.fields[1].asstring +' '+ DataM1.Query1.fields[0].asstring;

                For irow := 1 to StringGrideds.RowCount-1 do
                begin
                  IF StringGrideds.Cells[0,irow] = Fpage then
                  begin
                    StringGrideds.Cells[i,irow] := StringGrideds.Cells[i,0];
                    frow := irow;
                    break;
                  end;
                End;
                DataM1.Query1.Next;
              End;
              DataM1.Query1.close;
            End;
          End;

          (*
          For i := 1 to StringGrideds.ColCount-1 do
          begin
            aktedID := tnames1.editionnametoid(StringGrideds.Cells[i,0]);
            For irow := 1 to StringGrideds.RowCount-1 do
            begin
              IF (StringGrideds.Cells[i,irow] = StringGrideds.Cells[i,0]) then
              begin
                DataM1.Query1.SQL.Clear;                //0          1
                DataM1.Query1.SQL.add('Select distinct p.pagename,s.Name from PageTable p, EditionNames e, SectionNames s ');
                DataM1.Query1.SQL.add('where p.productionid = '+inttostr(Tplantreedata(formmain.TreeViewplan.Selected.Data^).productionid));
                DataM1.Query1.SQL.add('and p.Uniquepage = 1');
                DataM1.Query1.SQL.add('and p.editionid = ' + inttostr(aktedID));
                DataM1.Query1.SQL.add('and p.SectionID = s.SectionID');
                DataM1.Query1.SQL.add('order by s.Name,p.pagename');
                IF debug then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'repaired.sql');
                DataM1.Query1.open;
                While not DataM1.Query1.eof do
                begin
                  Fpage := DataM1.Query1.fields[1].asstring +' '+ DataM1.Query1.fields[0].asstring;

                  For irow := 1 to StringGrideds.RowCount-1 do
                  begin
                    IF StringGrideds.Cells[0,irow] = Fpage then
                    begin
                      StringGrideds.Cells[i,irow] := StringGrideds.Cells[i,0];
                      frow := irow;
                      break;
                    end;
                  End;
                  DataM1.Query1.Next;
                End;
                DataM1.Query1.close;

              end;;


            End;
            DataM1.Query1.close;
          End;
          *)
        end;
      End;
    End;
  end;
  activatedone := true;
end;


procedure TFormeditionpageplan.BitBtn6Click(Sender: TObject);
begin
  setresult;
end;

end.
