unit Ueditorialrutines;

interface
  procedure TFormmain.loadpages(Var editorialtree : ttreeview);
implementation


procedure TFormmain.loadpages(Var editorialtree : ttreeview);


const treimdx: array[0..9] of integer = (40,20,16,23,11,0,41,28,8,9);
Var
  Firstchange : Integer;
  x,i : Integer;

  aktfields : array[0..30] of string;
  Mynodes : array[0..30] of TTreeNode;
  nep : Peditorialproductiondatatype;

  gtl : Integer;


Procedure inserteddata(node : Ttreenode);
Begin
  editorialproductiondatatype(node.Data^).Inuse := 0;
  editorialproductiondatatype(node.Data^).numberofpages  := 0;
  editorialproductiondatatype(node.Data^).NumberofColors :=0;
  editorialproductiondatatype(node.Data^).productionID   := productionnametoid(DataM1.Query1.fields[1].asstring);
  editorialproductiondatatype(node.Data^).publicationID  := tNames1.publicationnametoid(DataM1.Query1.fields[2].asstring);
  editorialproductiondatatype(node.Data^).IssueID        := tNames1.issuenametoid(DataM1.Query1.fields[3].asstring);
  editorialproductiondatatype(node.Data^).EditionID      := tNames1.editionnametoid(DataM1.Query1.fields[4].asstring);
  editorialproductiondatatype(node.Data^).SectionID      := tNames1.sectionnametoid(DataM1.Query1.fields[5].asstring);

  editorialproductiondatatype(node.Data^).pagination     := DataM1.Query1.fields[8].asInteger;

   editorialproductiondatatype(node.Data^).OrgproductionID   :=
     editorialproductiondatatype(node.Data^).productionID;
  editorialproductiondatatype(node.Data^).OrgIssueID    :=
    editorialproductiondatatype(node.Data^).IssueID;

  editorialproductiondatatype(node.Data^).OrgpublicationID :=
    editorialproductiondatatype(node.Data^).publicationID;
  editorialproductiondatatype(node.Data^).OrgSectionID :=
    editorialproductiondatatype(node.Data^).SectionID;

  editorialproductiondatatype(node.Data^).OrgEditionID :=
    editorialproductiondatatype(node.Data^).EditionID;

  editorialproductiondatatype(node.Data^).editorialnodeNumber := node.Index;
  editorialproductiondatatype(node.Data^).allpagesstat :=0;
End;


begin
  gtl := 7;

  editorialtree.Items.clear;

  datam1.Query1.sql.Clear;
  datam1.Query1.sql.add('Select p1.pubdate,p2.name as production,p3.name as publication,p6.name as issue,p4.name as edition,p5.name as section,p1.pagename,p1.color,p1.pagination,p1.copyseparationset');
  datam1.Query1.sql.add('from pagetable p1,productionnames p2,publicationnames p3,editionnames p4,sectionnames p5,issuenames p6 (NOLOCK)');
  datam1.Query1.sql.add('where p1.productionid = p2.productionid and p1.publicationid = p3.publicationid and p1.editionid = p4.editionid');
  datam1.Query1.sql.add('and p1.sectionid = p5.sectionid and p1.issueid = p6.issueid');
  datam1.Query1.sql.add('order by p1.pubdate,p2.name,p3.name,p6.name,p4.name,p1.pagination,p5.name,p1.separationset,p1.color');
  datam1.Querylog1.setqueryname(datam1.Query1,'getcurprodnames');
  datam1.Query1.open;
  IF datam1.Query1.recordcount > 0 then
  begin
    For x := 0 to gtl do
    Begin
      aktfields[x] := DataM1.Query1.fields[X].asstring;
      if x = 0 then
      begin
        aktfields[x] := DataM1.Query1.fields[X].asstring;
        new(nep);

        Mynodes[x] := editorialtree.Items.Addobject(nil,DataM1.Query1.fields[X].asstring,nep);
        inserteddata(Mynodes[x]);
        Mynodes[x].ImageIndex := treimdx[x];
        Mynodes[x].SelectedIndex := treimdx[x];
        Mynodes[x].StateIndex := 0;
      end
      Else
      Begin
        aktfields[x] := DataM1.Query1.fields[X].asstring;
        new(nep);
        Mynodes[x] := editorialtree.Items.Addchildobject(Mynodes[x-1],DataM1.Query1.fields[X].asstring,nep);
        inserteddata(Mynodes[x]);
        Mynodes[x].ImageIndex := treimdx[x];
        Mynodes[x].SelectedIndex := treimdx[x];
        Mynodes[x].StateIndex := 0;
        

        IF x = 6 then
        Begin
          editorialproductiondatatype(Mynodes[x].data^).pagination := datam1.Query1.fieldbyname('pagination').asinteger;
          editorialproductiondatatype(Mynodes[x].data^).copyseparationset := datam1.Query1.fieldbyname('copyseparationset').asinteger;
        End;
      End;

    End;
    Firstchange := 0;

    DataM1.Query1.next;
    While not DataM1.Query1.eof do
    begin
      For x := 0 to gtl  do
      Begin
        IF aktfields[x] <> DataM1.Query1.fields[X].asstring then
        begin
          Firstchange := x;
          break;
        end;
      End;
      For x := Firstchange to gtl  do
      Begin
        aktfields[x] := DataM1.Query1.fields[X].asstring;
        IF x = Firstchange then
        begin
          new(nep);
          Mynodes[x] := editorialtree.Items.Addobject(Mynodes[x],DataM1.Query1.fields[X].asstring,nep);
          inserteddata(Mynodes[x]);
          Mynodes[x].ImageIndex := treimdx[x];
          Mynodes[x].SelectedIndex := treimdx[x];
          Mynodes[x].StateIndex := 0;

          IF x = 6 then
            editorialproductiondatatype(Mynodes[x].data^).pagination := datam1.Query1.fieldbyname('pagination').asinteger;

        end
        Else
        begin
          new(nep);
          Mynodes[x] := editorialtree.Items.Addchildobject(Mynodes[x-1],DataM1.Query1.fields[X].asstring,nep);
          inserteddata(Mynodes[x]);
          Mynodes[x].ImageIndex := treimdx[x];
          Mynodes[x].SelectedIndex := treimdx[x];
          Mynodes[x].StateIndex := 0;
          IF x = 6 then
            editorialproductiondatatype(Mynodes[x].data^).pagination := datam1.Query1.fieldbyname('pagination').asinteger;
        end;
      End;
      DataM1.Query1.next;
    End;


    For x := 0 to editorialtree.Items.Count-1 do
    begin
      IF editorialtree.Items[x].Level < 4 then
        editorialtree.Items[x].Expand(false);

      editorialtree.Items[x].DropTarget := (editorialtree.Items[x].Level >= 4) And (editorialtree.Items[x].Level < 6);

      Case editorialtree.Items[x].Level OF
        1 : Begin
              datam1.Query1.sql.Clear;
              datam1.Query1.sql.add('select count(distinct pagename) as npages from pagetable');
              datam1.Query1.sql.add('where productionID = '+inttostr(productionnametoid(editorialtree.Items[x].text)));
              datam1.Query1.sql.add('and pubdate = :pubdate');
              datam1.Query1.parambyname('pubdate').AsDateTime := strtodatetime(editorialtree.Items[x].parent.text);
              datam1.Querylog1.setqueryname(datam1.Query1,'getcurprodnpages');
              datam1.Query1.open;
              editorialproductiondatatype(editorialtree.Items[x].data^).numberofpages := datam1.Query1.fieldbyname('npages').asinteger;



  //            Editorialproductiondata[editorialtree.Items[x].absoluteindex].numberofpages :=
  //              datam1.Query1.fieldbyname('npages').asinteger;
              editorialproductiondatatype(editorialtree.Items[x].data^).productionID := productionnametoid(editorialtree.Items[x].text);

              editorialproductiondatatype(editorialtree.Items[x].data^).OrgproductionID :=
                editorialproductiondatatype(editorialtree.Items[x].data^).productionID;
              datam1.Query1.close;
            End;
        2 : begin
            end;
        3 : begin
            end;
        4 : begin
            end;
        5 : begin
            end;
        6 : begin
              editorialproductiondatatype(editorialtree.Items[x].data^).NumberofColors :=
                editorialtree.Items[x].Count;
              IF editorialtree.Items[x].Count > 1 then
              Begin
                editorialtree.Items[x].ImageIndex := 50;
                editorialtree.Items[x].selectedindex := 50;

              End
              else
              Begin
                editorialtree.Items[x].ImageIndex := 49;
                editorialtree.Items[x].selectedindex := 49;

              End;

            end;
        7 : begin
              editorialproductiondatatype(editorialtree.Items[x].data^) :=
              editorialproductiondatatype(editorialtree.Items[x].parent.data^);
            end;
      End;

    end;
  End;
  DataM1.Query1.close;
end;
end.
 