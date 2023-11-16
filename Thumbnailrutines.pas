// denne fil er inkluderet i formmain lige efter uses



procedure TFormmain.setpagetablethumbdata(SetString : String; extrawhere : String);
var
  I : Longint;
begin
  Nselectedmasters := 0;

  for i := 0 to PBExListviewthumbnail.Items.Count-1 do
  begin
    if  (PBExListviewthumbnail.Items[i].Selected) then
    begin
      //Formmain.SetMissingOnmaster(Showthubms[i].Mastercopyseparationset);
      DataM1.Query1.sql.clear;
      DataM1.Query1.sql.Add('update pagetable ' + SetString);
      DataM1.Query1.sql.Add('where mastercopyseparationset = ' + IntToStr(Showthubms[i].Mastercopyseparationset));
      DataM1.Query1.sql.Add(extrawhere);
      datam1.Query1.SQL.Add(notinproofplans);
      datam1.Query1.SQL.Add(WeditionStr);
      datam1.Query1.SQL.Add(WpublicationStr);

      trysql(DataM1.Query1);

      if pos('set status = 0',SetString) > 0 Then
      begin
        datam1.Query1.SQL.Clear;
        datam1.Query1.SQL.Add('Delete PrepollPageTable');
        datam1.Query1.SQL.Add('where (mastercopyseparationset = ' + IntToStr(Showthubms[i].Mastercopyseparationset) + ')');
        datam1.Query1.SQL.Add('and (Event not in (130,136,137))');
        trysql(datam1.Query1);
      end;
      

      addtoselectedmasters(Showthubms[i].Mastercopyseparationset);

    end;
  end;
end;


procedure TFormmain.DothumbnailCenterspreadExecute;
begin
    if PBExListviewthumbnail.Selected = nil then exit;
  changemastertocenterspread(Showthubms[PBExListviewthumbnail.Selected.Index].Mastercopyseparationset);
  loadthumbnails(true);
end;


procedure TFormmain.DothumbnailSinglespreadExecute;
begin
  if PBExListviewthumbnail.Selected = nil then exit;
  changemastertosinglespread(Showthubms[PBExListviewthumbnail.Selected.Index].Mastercopyseparationset);
  loadthumbnails(true);
end;


procedure TFormmain.DoThumbnailapproveExecute;
var
  I : Longint;
  n,c : ttreenode;
  foundone : boolean;
  Inliste : String;
  eventtime : tdatetime;
  Dotheapproval : Boolean;
begin
  Inliste := 'and separation IN (';
  for i := 0 to PBExListviewthumbnail.items.count-1 do
  begin
    if PBExListviewthumbnail.items[i].Selected  then
    begin
      Dotheapproval := true;
      datam1.Query1.SQL.Clear;
      datam1.Query1.SQL.Add('Select P1.Approved,P1.Separation From pagetable P1 (NOLOCK)');
      datam1.Query1.SQL.Add('where P1.active <> -999 AND P1.Dirty=0');

      if PDFMasterOK then
      begin
//        datam1.Query1.SQL.Add('and PDFMaster = '+IntToStr(Showthubms[PBExListviewthumbnail.items[i].Index].PDFMaster) );

        datam1.Query1.SQL.Add('and P1.MasterCopySeparationSet IN (SELECT DISTINCT P9.MasterCopySeparationSet FROM PageTable P9 WITH (NOLOCK) WHERE P9.PDFMaster =  '+IntToStr(Showthubms[PBExListviewthumbnail.items[i].Index].PDFMaster)+ ')' );
      end
      else
      begin
        datam1.Query1.SQL.Add('and P1.Mastercopyseparationset = '+IntToStr(Showthubms[PBExListviewthumbnail.items[i].Index].Mastercopyseparationset) );
      end;
      datam1.Query1.SQL.Add('and P1.Approved <> 1');
      datam1.Query1.Open;
      Dotheapproval := not datam1.Query1.eof;
      datam1.Query1.Close;

      if Dotheapproval then
      begin
        datam1.Query1.SQL.Clear;
        datam1.Query1.SQL.Add('Update pagetable');
        datam1.Query1.SQL.Add('set approved = 1,approvetime = getdate(),approveuser='+''''+formlogin.username+'''');
        datam1.Query1.SQL.Add('where active <> -999 AND Dirty=0');
        if PDFMasterOK then
        begin
          datam1.Query1.SQL.Add('and MasterCopySeparationSet IN (SELECT DISTINCT P9.MasterCopySeparationSet FROM PageTable P9 WITH (NOLOCK) WHERE P9.PDFMaster =  '+IntToStr(Showthubms[PBExListviewthumbnail.items[i].Index].PDFMaster) + ')' );
        end
        else
        begin
          datam1.Query1.SQL.Add('and mastercopyseparationset = ' + IntToStr(Showthubms[PBExListviewthumbnail.items[i].Index].Mastercopyseparationset) );
        end;

        datam1.Query1.SQL.Add(notinproofplans);
        datam1.Query1.SQL.Add(WeditionStr);
        if debug then datam1.Query1.sql.SaveToFile(extractfilepath(application.exename) + 'sqllogs\'+'approve.sql');
        trysql(datam1.Query1);


        if PDFMasterOK then
        begin
          afterapproval(-1,Showthubms[PBExListviewthumbnail.items[i].Index].pdfmaster);
        end
        Else
        begin
          afterapproval(Showthubms[PBExListviewthumbnail.items[i].Index].Mastercopyseparationset,-1);
        end;
        eventtime := -1;
        if formsettings.CheckBoxlogapprove.Checked then
        begin
          datam1.Query1.SQL.Clear;
          datam1.Query1.SQL.Add('Select filename,version,separation,productionid from pagetable (NOLOCK) where mastercopyseparationset = '+IntToStr(Showthubms[PBExListviewthumbnail.items[i].Index].Mastercopyseparationset));

          datam1.Query1.Open;
          While Not datam1.Query1.Eof do
          begin
            Formmain.SaveEventlog(70,datam1.Query1.fields[2].asinteger,0,'',datam1.Query1.fields[0].asString,datam1.Query1.fields[1].asinteger,datam1.Query1.fields[3].asinteger);
            datam1.Query1.Next;
          end;
          datam1.Query1.Close;

        end;
      end;
    end;
  end;

  ActionThumbnailrefresh.Execute;

end;

procedure TFormmain.DoThumbnaildisapproveExecute;
var
  I : longint;
  eventtime : Tdatetime;
begin
  setpagetablethumbdata('set approved = 2,approvetime = getdate(),approveuser='+''''+formlogin.username+'''','');
  ActionrefreshpagesExecute(self);
  if formsettings.CheckBoxlogdisapprove.Checked then
  begin
    for i := 0 to PBExListviewthumbnail.items.count-1 do
    begin
      if PBExListviewthumbnail.items[i].Selected then
      begin

        datam1.Query1.SQL.Clear;
        datam1.Query1.SQL.Add('Select filename,version,separation,productionid from pagetable (NOLOCK) where mastercopyseparationset = '+IntToStr(Showthubms[PBExListviewthumbnail.items[i].Index].Mastercopyseparationset));
        datam1.Query1.open;
        While Not datam1.Query1.Eof do
        begin
          Formmain.SaveEventlog(71,datam1.Query1.fields[2].asinteger,0,'',datam1.Query1.fields[0].asString,datam1.Query1.fields[1].asinteger,datam1.Query1.fields[3].asinteger);
          datam1.Query1.next;
        end;
        datam1.Query1.close;
      end;
    end;

  end;



  sendedisapprovemail(-1,'Page disapproved',0);

  ActionThumbnailrefresh.Execute;
end;

procedure TFormmain.DoThumbnailholdExecute;
var
  I : longint;
  eventtime : tdatetime;
begin
  try
    if (formsettings.CheckBoxThsingleedrelease.Checked) and (TreeViewThumbs.selected.Level = 3) then
    begin
      setpagetablethumbdata('set hold = 1','and editionid = ' + IntToStr(tnames1.editionnametoid(TreeViewThumbs.selected.Text)));
    end
    else
      setpagetablethumbdata('set hold = 1','');


    if formsettings.CheckBoxloghold.Checked then
    begin
      for i := 0 to PBExListviewthumbnail.items.count-1 do
      begin
        if PBExListviewthumbnail.items[i].Selected then
        begin

          datam1.Query1.SQL.Clear;
          datam1.Query1.SQL.Add('Select filename,version,separation,productionid from pagetable (NOLOCK) where mastercopyseparationset = '+IntToStr(Showthubms[PBExListviewthumbnail.items[i].Index].Mastercopyseparationset));
          datam1.Query1.open;
          While Not datam1.Query1.Eof do
          begin
            Formmain.SaveEventlog(81,datam1.Query1.fields[2].asinteger,0,'',datam1.Query1.fields[0].asString,datam1.Query1.fields[1].asinteger,datam1.Query1.fields[3].asinteger);
            datam1.Query1.next;
          end;
          datam1.Query1.close;
        end;
      end;

    end;


    ActionThumbnailrefresh.Execute;
  except
  end;
end;

procedure TFormmain.DothumbnailReleaseExecute(Monoonly : Boolean);
var
  I : LongInt;
  eventtime : TDateTime;
  andstr : String;

begin
  andstr := '';

  if (formsettings.CheckBoxThsingleedrelease.Checked) and (TreeViewThumbs.selected.Level = 3) then
  begin
    if Monoonly then
      andstr := ' and colorid = 4 and editionid = ' + IntToStr(tnames1.editionnametoid(TreeViewThumbs.selected.Text))
    else
      andstr := ' and editionid = ' + IntToStr(tnames1.editionnametoid(TreeViewThumbs.selected.Text));
  end
  else
  begin
    if Monoonly then
      andstr := ' and colorid = 4 '
    else
      andstr := '';
  end;

  // NAN 20160115 Ensure empty where does not select anything
  if (andstr = '') then
    andstr := '(0=1)';


  if formsettings.CheckBoxapprovetimeonrelease.checked then
  begin
    setpagetablethumbdata('set hold = 0, approvetime = getdate(),approveuser='+''''+formlogin.username+'''',andstr);           // OK
  end
  Else
  begin
    setpagetablethumbdata('set hold = 0',andstr);      // OK
  end;


  if formsettings.CheckBoxlogrelease.Checked then
  begin
    for i := 0 to PBExListviewthumbnail.items.count-1 do
    begin
      if PBExListviewthumbnail.items[i].Selected then
      begin

        datam1.Query1.SQL.Clear;
        datam1.Query1.SQL.Add('Select filename,version,separation,productionid from pagetable (NOLOCK) where mastercopyseparationset = '+IntToStr(Showthubms[PBExListviewthumbnail.items[i].Index].Mastercopyseparationset));
        datam1.Query1.open;
        While Not datam1.Query1.Eof do
        begin
          Formmain.SaveEventlog(80,datam1.Query1.fields[2].asinteger,0,'',datam1.Query1.fields[0].asString,datam1.Query1.fields[1].asinteger,datam1.Query1.fields[3].asinteger);
          datam1.Query1.next;
        end;
        datam1.Query1.close;
      end;
    end;

  end;


  ActionThumbnailrefresh.Execute;

end;


procedure TFormmain.DothumbnailReapproveExecute;
begin
  setpagetablethumbdata('set approved = 0, approvetime = 0,approveuser='+''''+''+'''','');
  ActionThumbnailrefresh.Execute;  //ActionrefreshpagesExecute(self);
end;

procedure TFormmain.DothumbnailAutoapproveExecute;
begin
  setpagetablethumbdata('set approved = -1, approvetime = 0,approveuser='+''''+''+'''','');
   ActionThumbnailrefresh.Execute;  // ActionrefreshpagesExecute(self);
end;


(*
*)



procedure TFormmain.DOActionthumbnaileditcolorsExecute;


procedure createnewcolors;
var
  I, colorID : LongInt;
  CopySeparationSet,CopyFlatSeparationSet,Copies,Hold,Approved : LongInt;
  MasterCopySeparationSet : LongInt;
  hasColor : Boolean;
begin


 for i := 0 to PBExListviewthumbnail.Items.Count-1 do
 begin
    if  (PBExListviewthumbnail.Items[i].Selected) then
    begin
      MasterCopySeparationSet := Showthubms[i].Mastercopyseparationset;
      CopySeparationSet := 0;
      CopyFlatSeparationSet := 0;
      Hold := 1;
      Approved := -1;
      Copies := 1;
      DataM1.Query1.SQL.clear;
      DataM1.Query1.SQL.Add('SELECT DISTINCT CopySeparationSet,CopyFlatSeparationSet,MAX(CopyNumber),Hold,Approved FROM PageTable (NOLOCK) ');
      DataM1.Query1.SQL.Add('WHERE MasterCopySeparationSet = ' +IntToStr(MasterCopySeparationSet));
      DataM1.Query1.SQL.Add('GROUP BY CopyFlatSeparationSet,CopySeparationSet,Hold,Approved');
      DataM1.Query1.Open;
      if not DataM1.Query1.Eof then
      begin
        CopySeparationSet :=  DataM1.Query1.fields[0].AsInteger;
        CopyFlatSeparationSet :=  DataM1.Query1.fields[1].AsInteger;
        Copies :=  DataM1.Query1.fields[2].AsInteger;
        Hold :=  DataM1.Query1.fields[3].AsInteger;
        Approved := DataM1.Query1.fields[4].AsInteger;
      end;
      Datam1.Query1.Close;

      if (CopySeparationSet=0) then
        continue;

      for colorID := 1 to 4 do
      begin
        hasColor := false;
        DataM1.Query1.SQL.clear;
        DataM1.Query1.SQL.Add('SELECT DISTINCT SeparationSet FROM PageTable (NOLOCK) ');
        DataM1.Query1.SQL.Add('WHERE MasterCopySeparationSet = ' +IntToStr(MasterCopySeparationSet));
        DataM1.Query1.SQL.Add('AND ColorID='+IntToStr(colorID));
        DataM1.Query1.Open;
        hasColor := not DataM1.Query1.Eof;
        Datam1.Query1.Close;

        if ( hasColor = false) then
        begin
          DataM1.Query1.sql.clear;

          if (Approved = -1) then
            Approved := 0
          else
            Approved := 1;
          DataM1.Query1.sql.Add('exec spInputInsertNewSeparation');

          Datam1.Query1.SQL.Add('@MasterCopySeparationSet=' + IntToStr(MasterCopySeparationSet));
          Datam1.Query1.SQL.Add(', @CopySeparationSet='+IntToStr(CopySeparationSet));
          Datam1.Query1.SQL.Add(', @CopyFlatSeparationSet='+IntToStr(CopyFlatSeparationSet));
          Datam1.Query1.SQL.Add(', @ColorID='+IntToStr(colorID));
          Datam1.Query1.SQL.Add(', @Copies='+IntToStr(Copies));
          Datam1.Query1.SQL.Add(', @InsertMode='+IntToStr(Approved));
          Datam1.Query1.SQL.Add(', @Status=0');
          Datam1.Query1.SQL.Add(', @ApprovalRequired=0');
          Datam1.Query1.SQL.Add(', @HoldIncoming='+IntToStr(Hold));
          Datam1.Query1.SQL.Add(', @CopiesOnSameDevice=1');
          Datam1.Query1.SQL.Add(', @FileName=''''');
          Datam1.Query1.SQL.Add(', @Version=0');
          trysql(Datam1.Query1);
        end;
      end;
    end;
  end;
end;


procedure enablecolors;

var
  I : Longint;
  Incopysets : String;

begin
  Nselectedmasters := 0;

  for i := 0 to PBExListviewthumbnail.Items.Count-1 do
  begin
    if  (PBExListviewthumbnail.Items[i].Selected) then
    begin
      Incopysets := 'IN (-999,';
      DataM1.Query1.sql.clear;
      DataM1.Query1.sql.Add('select distinct separationset from pagetable (NOLOCK) ');
      DataM1.Query1.sql.Add('where mastercopyseparationset = ' +IntToStr(Showthubms[i].Mastercopyseparationset));
      DataM1.Query1.sql.Add('and active = 1');
      if debug then datam1.Query1.sql.SaveToFile(extractfilepath(application.exename) + 'sqllogs\'+'findaddcolors.SQL');
      DataM1.Query1.open;
      while not DataM1.Query1.eof do
      begin
        Incopysets := Incopysets+ DataM1.Query1.fields[0].asString;
        Incopysets := Incopysets+',';
        DataM1.Query1.next;
      end;
      Incopysets := Incopysets+'-998)';

      DataM1.Query1.close;

      DataM1.Query1.sql.clear;
      DataM1.Query1.sql.Add('update pagetable set active = 1,proofstatus=0');
      DataM1.Query1.sql.Add('where separationset ' +Incopysets);
      datam1.Query1.SQL.Add(notinproofplans);
      datam1.Query1.SQL.Add(' and '+Formendiscolors.enabledcolors);
      if debug then datam1.Query1.sql.SaveToFile(extractfilepath(application.exename) + 'sqllogs\'+'Setaddcolors.SQL');
      trysql(DataM1.Query1);
      addtoselectedmasters(Showthubms[i].Mastercopyseparationset);
    end;
  end;
  //dodalim(1,-1,-1,false,-1);
end;

var
  foundany : boolean;
  I : Integer;
  MasterSet : LongInt;
begin
  if PBExListviewthumbnail.selected <> nil then
  begin
    MasterSet :=  Showthubms[PBExListviewthumbnail.selected.Index].Mastercopyseparationset;
    Formendiscolors.Mastercopyseparationset := MasterSet;
    if Formendiscolors.ShowModal = mrok then
    begin
      createnewcolors;
      enablecolors;
      setpagetablethumbdata('set active = 0,proofstatus=0',' and '+Formendiscolors.disabledcolors);

      loadthumbnails(true);
    end;
  end;
end;


procedure TFormmain.DothumbnailpreviewExecute(Modalview : Boolean; SpecificMaster: Longint);

procedure readorderview;
var
  T : String;
  res,masterL,masterR,sheetside,Lidx,Ridx,proofid,templateid : Longint;
  APPOS : pparray;
  ANPPOS : Integer;
  aktpi,I : Longint;
  readordfilename : String;

begin
  try
    if PBExListviewthumbnail.Selected <> nil then
    begin
      readordfilename := '';
      for I := 1 to Formprev2.nReadordermasters do
      begin
        if (Formprev2.Readordermasters[I].Ithumbl = PBExListviewthumbnail.Selected.Index) or
           (Formprev2.Readordermasters[I].IthumbR = PBExListviewthumbnail.Selected.Index)  then
        begin
          Formprev2.AktReadorder := i;
          break;
        end;
      end;
      if PBExListviewthumbnail.Selected.Index mod 2 = 0 then
      begin
        lidx := PBExListviewthumbnail.Selected.Index-1;
      end
      else
      begin
        lidx := PBExListviewthumbnail.Selected.Index;
      end;
      Ridx := lidx+1;

      strpcopy(MrgOutputFileName,extractfilepath(application.ExeName)+'merg1.jpg');
      strpcopy(MrgFileNameLeft,'');
      strpcopy(MrgFileNameRight,'');

      MrgPageTypeLeft      := 3;
      MrgPageTypeRight     := 3;
      MrgPagePositionLeft  := 2;
      MrgPagePositionRight := 1;
      MrgSheetSide         := 1;
      MrgProofID           := 1;
      MrgTemplateID        := 17;

      masterL:=-99;
      masterR:=-99;

      aktpi := Showthubms[1].Publication;

      readordfilename := '';


      if (lidx > -1) and (Showthubms[lidx].Anyproof>0) then
      begin
        readordfilename := getfileserverpath(4,Showthubms[lidx].Fileserver);
        Formprev2.Lowrespath := getfileserverpath(2,Showthubms[lidx].Fileserver);
        masterL := Showthubms[lidx].Mastercopyseparationset;
        readordfilename := readordfilename + IntToStr(masterL);
      end
      Else
        readordfilename := '0';

      if (Ridx < PBExListviewthumbnail.Items.Count) and (Showthubms[Ridx].Anyproof>0) then
      begin
        if readordfilename = '0' then
          readordfilename := getfileserverpath(4,Showthubms[ridx].Fileserver)+'\0';
        Formprev2.Lowrespath := getfileserverpath(2,Showthubms[ridx].Fileserver);
        masterR := Showthubms[Ridx].Mastercopyseparationset;
        readordfilename := readordfilename +'_'+ IntToStr(masterR);
      end
      Else
        readordfilename := readordfilename +'_0';

      formprev2.PrevmasterL := masterL;
      formprev2.prevmasterR := masterR;
      Formprev2.Showasreadorder := true;

      if Formprev2.showing then
      begin
        Formprev2.readpageorderspecific(masterL);
      end
      Else
      begin
        if (formsettings.CheckBoxAllowparalelview.Checked) then
          Formprev2.Show
        Else
          Formprev2.Showmodal;
      end;
    end;
  finally
    Formprev2.Showasreadorder := false;
    Formprev2.PageControl1.ActivePageIndex := 0;
  end;


end;


var
  th : PThumbdata;
  Ncolors,i : Longint;
  T,t2 : String;
  proofed : boolean;
begin
  try
    Formprev2.plateview := false;
  // Memotestdebug.Lines.Add('Start DothumbnailpreviewExecute '+IntToStr(Showthubms[PBExListviewthumbnail.Selected.Index].pdfmaster)+ ' '+IntToStr(PBExListviewthumbnail.Selected.Index));

    if (ActionCHKthumbreadorder.Checked) and (ActionCHKthumbreadorder.Enabled) then
    begin
      readorderview;
    end
    else
    begin
      if PBExListviewthumbnail.Selected <> nil then
      begin
        //th := PBExListviewthumbnail.Selected.data;

        DataM1.Query1.SQL.Clear;
        if PDFMasterOK then
        begin
          DataM1.Query1.SQL.Add('select proofstatus,status from pagetable (NOLOCK) where mastercopyseparationset = '+IntToStr(Showthubms[PBExListviewthumbnail.Selected.Index].Mastercopyseparationset));
//          DataM1.Query1.SQL.Add('select proofstatus,status from pagetable (NOLOCK) where pdfmaster = '+IntToStr(Showthubms[PBExListviewthumbnail.Selected.Index].pdfmaster));
//          DataM1.Query1.SQL.Add('and mastercopyseparationset = pdfmaster');
        end
        else
          DataM1.Query1.SQL.Add('select proofstatus,status from pagetable (NOLOCK) where mastercopyseparationset = '+IntToStr(Showthubms[PBExListviewthumbnail.Selected.Index].Mastercopyseparationset));


        if debug then datam1.Query1.sql.SaveToFile(extractfilepath(application.exename) + 'sqllogs\'+'Previewstat.sql');

        tryopen(datam1.Query1);
        proofed := false;
        While not DataM1.Query1.eof do
        begin
          if ( DataM1.Query1.fieldbyname('proofstatus').asinteger >= 10)  and (DataM1.Query1.fieldbyname('status').asinteger > 0) then
          begin
            proofed := true;
            break;
          end;
          DataM1.Query1.next;
        end;
        DataM1.Query1.close;

        if proofed then
        begin
          Formprev2.Lowrespath := getfileserverpath(2,Showthubms[PBExListviewthumbnail.Selected.Index].Fileserver);

          {// ## NAN 20150204
          if (PDFMasterOK) AND (Showthubms[PBExListviewthumbnail.Selected.Index].pdfmaster > 0) then
          begin
            Formprev2.prevmaster := Showthubms[PBExListviewthumbnail.Selected.Index].pdfmaster;
            Formprev2.UsePDFMaster := true;
          end
          Else
          begin
            Formprev2.Prevmaster := Showthubms[PBExListviewthumbnail.Selected.Index].Mastercopyseparationset;
            Formprev2.UsePDFMaster := false;
          end;}
          // ## SJO 20151104
          Formprev2.Prevmaster := Showthubms[PBExListviewthumbnail.Selected.Index].Mastercopyseparationset;
          Formprev2.pdfmaster  := Showthubms[PBExListviewthumbnail.Selected.Index].pdfmaster;
          if (PDFMasterOK) AND (Showthubms[PBExListviewthumbnail.Selected.Index].pdfmaster > 0) then
            Formprev2.UsePDFMaster := true Else
            Formprev2.UsePDFMaster := false;

          if (Formprev2.showing) and (formsettings.CheckBoxAllowparalelview.Checked) then
          begin
            Formprev2.gotospecific(Formprev2.Prevmaster);
          end
          Else
          begin
            if (formsettings.CheckBoxAllowparalelview.Checked) then
              Formprev2.Show
            else
              Formprev2.Showmodal;
          end;
           //Formprev2.BringToFront;
        end
        Else
        begin
           //MessageDlg(InfraLanguage1.Translate('Not proofed'), mtInformation,[mbOk], 0);

        end;
      end
      Else
      begin
        if (SpecificMaster > 0) then
        begin
          Formprev2.Prevmaster :=   SpecificMaster;
          if (Formprev2.showing) then
            Formprev2.gotospecific(Formprev2.Prevmaster)
          Else
            Formprev2.Showmodal;

          //Formprev2.BringToFront;
        end;
        //else
           //MessageDlg(InfraLanguage1.Translate('No thumbnail selected'), mtInformation,[mbOk], 0);
      end;
    end;

  except
  end;
end;



