unit UPlateprint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, hyieutils, iexBitmaps, hyiedefs, iesettings,
  System.Contnrs;

type
  TFormPlateprint = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    NAktcolorsInrun : Longint;
    AktcolorsInrun : Array[1..32] of string;
    Colnametilte : Array[1..32] of string;
    Akttitle : String;
    Printlines : TStrings;
  public
    procedure Plateprint(pressrunid : Longint);
    procedure makeplateprinttext(pressid      : Longint;
                                 pressrunid : Longint);
  end;

var
  FormPlateprint: TFormPlateprint;

implementation

{$R *.dfm}
Uses
  printers,usettings, Umain, Udata, UUtils;

procedure TFormPlateprint.makeplateprinttext(pressid      : Longint;
                                             pressrunid : Longint);

Var
  aktflatsep : int64;
  aktpressrunid : Longint;
  T : String;
  pagepart : String;
  Lowpage : Longint;
  Lowpagename,pagenames : string;
  Sheet,platenumber,sectionname,copynumber : String;
  sheetfb : Array[0..1] of string;
  aktpage : Longint;
  Aktcolors : String;

  ColNum : Longint;

Function genplatestr:String;
Begin
  result := '';
  ColNum := 0;

  IF (Prefs.PlatePrintListPlateDefinition[0]) then
  Begin
    Inc(ColNum);
    Colnametilte[ColNum] := 'Section';
    result := '#'+inttostr(ColNum)+sectionname;

  End;
  IF Prefs.PlatePrintListPlateDefinition[2] then
  Begin
    Inc(ColNum);
    Colnametilte[ColNum] := 'Page';
    result := result +'#'+inttostr(ColNum)+Lowpagename;
  End;
  IF Prefs.PlatePrintListPlateDefinition[3] then
  Begin
    Inc(ColNum);
    IF Prefs.PlatePrintoutUseSectionPage then
      Colnametilte[ColNum] := 'Sec+Pages'
    else
      Colnametilte[ColNum] := 'Pages';
    result := result +'#'+inttostr(ColNum)+pagenames;
  End;
  IF Prefs.PlatePrintListPlateDefinition[4] then
  Begin
    Inc(ColNum);
    Colnametilte[ColNum] := 'Platenumber';
    result := result +'#'+inttostr(ColNum)+platenumber;
  End;
  IF Prefs.PlatePrintListPlateDefinition[5] then
  Begin
    Inc(ColNum);
    Colnametilte[ColNum] := 'Sheet';
    result := result +'#'+inttostr(ColNum)+Sheet;
  End;
  IF Prefs.PlatePrintListPlateDefinition[1] then
  Begin
    Inc(ColNum);
    Colnametilte[ColNum] := 'Copynumber';
    result := result +'#'+inttostr(ColNum)+copynumber;
  End;
  result := result + ';' +Aktcolors;
end;


Begin
  Printlines.Clear;

  (*
  Press
  Publication
  Pubdate
  Edition


Section
Copynumber
LowPage
All Pages
Platenumber     Miscstring1
Sheet

  *)
  aktflatsep := -1;
  Akttitle := '';
  aktpressrunid := -1;
  aktpage := -1;
  sheetfb[0] := 'Front';
  sheetfb[1] := 'Back';
  Aktcolors := '';
  DataM1.Query2.sql.clear;
  DataM1.Query2.sql.add('Select Distinct colorid from pagetable');
  DataM1.Query2.sql.add('where pressid = ' + inttostr(pressid));
  DataM1.Query2.sql.add('and pressrunid = ' + inttostr(pressrunid));
  DataM1.Query2.sql.add('and pagetype < 2');
  DataM1.Query2.sql.add('and active > 0');
  DataM1.Query2.sql.add('order by colorid');
  DataM1.Query2.open;
  NAktcolorsInrun := 0;
  While Not DataM1.Query2.eof do
  begin
    if NAktcolorsInrun < 30 then
    begin
      Inc(NAktcolorsInrun);
      AktcolorsInrun[NAktcolorsInrun] := tnames1.ColornameIDtoname(DataM1.Query2.fields[0].asinteger);
    End;
    DataM1.Query2.next;
  end;
  DataM1.Query2.close;

  DataM1.Query2.sql.clear;                // 0         1       2      3          4        5           6
  DataM1.Query2.sql.add('Select Distinct p.Pubdate,PN.name,EN.name,SN.name,M.PressName,p.pressrunid,p.presssectionnumber,');
                          // 7             8               9            10        11          12             13
  DataM1.Query2.sql.add('p.copynumber,p.pagepositions,p.Miscstring1,p.pageindex,p.pagename,p.pagination,p.sheetnumber,');
                         //14                15              16
  DataM1.Query2.sql.add('p.sheetside,p.flatseparationset,p.colorid from pagetable p (NOLOCK)');
  DataM1.Query2.SQL.add('INNER JOIN PublicationNames AS PN ON PN.publicationID=P.publicationID');
  DataM1.Query2.SQL.add('INNER JOIN EditionNames AS EN ON EN.EditionID=P.EditionID');
  DataM1.Query2.SQL.add('INNER JOIN SectionNames AS SN ON SN.SectionID=P.SectionID');
  DataM1.Query2.SQL.add('INNER JOIN PressNames AS M ON M.PressID=P.PressID');
  DataM1.Query2.sql.add('where p.pressid = ' + inttostr(pressid));
  IF pressrunid > -1 then
    DataM1.Query2.sql.add('and p.pressrunid = ' + inttostr(pressrunid));
  DataM1.Query2.sql.add('and p.pagetype < 2');
  DataM1.Query2.sql.add('and p.active > 0');
  DataM1.Query2.sql.add('order by EN.name,presssectionnumber,pressrunid,sheetnumber,sheetside,flatseparationset,copynumber,pagination,colorid');

//  order by EN.name,presssectionnumber,pressrunid,sheetnumber,sheetside,copyflatseparationset,copynumber,colorid,pagination
//  order by EN.name,presssectionnumber,pressrunid,sheetnumber,sheetside,copyflatseparationset,copynumber,colorid,pagepositions
  if Prefs.debug then DataM1.Query2.SQL.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'Plateprint1.sql');
  DataM1.Query2.open;
  While not DataM1.Query2.eof do
  begin
    IF (aktpressrunid <>  DataM1.Query2.fields[5].asinteger) or (Akttitle = '') then
    begin
      aktpressrunid :=  DataM1.Query2.fields[5].asinteger;
      IF Prefs.PlatePrintListTitleDefinition[0] then
      Begin
        if Akttitle <> '' then Akttitle := Akttitle + ', ';
        Akttitle := Akttitle + DataM1.Query2.fields[4].asstring;  //press
      End;
      IF Prefs.PlatePrintListTitleDefinition[1] then
      Begin
        if Akttitle <> '' then Akttitle := Akttitle + ', ';
        Akttitle := Akttitle + DataM1.Query2.fields[1].asstring;  //publication
      End;
      IF Prefs.PlatePrintListTitleDefinition[2] then
      Begin
        if Akttitle <> '' then Akttitle := Akttitle + ', ';
        Akttitle := Akttitle + datetostr(DataM1.Query2.fields[0].asdatetime);
      End;
      IF Prefs.PlatePrintListTitleDefinition[3] then
      Begin
        if Akttitle <> '' then Akttitle := Akttitle + ', ';
        Akttitle := Akttitle + DataM1.Query2.fields[2].asstring;
      End;
    end;


    if aktflatsep <> DataM1.Query2.fields[15].asinteger then
    begin
      IF aktflatsep <> -1 then
      begin
        delete(pagenames,length(pagenames),1);
        Printlines.add(genplatestr);
      end;
      copynumber := DataM1.Query2.fields[7].asstring;

      Lowpage := DataM1.Query2.fields[10].asinteger;
      Lowpagename := DataM1.Query2.fields[11].asstring;
      sectionname := DataM1.Query2.fields[3].asstring;
      IF Prefs.PlatePrintoutUseSectionPage then
        pagenames := DataM1.Query2.fields[3].asstring+DataM1.Query2.fields[11].asstring +','
      else
        pagenames := DataM1.Query2.fields[11].asstring +',';

      platenumber := DataM1.Query2.fields[9].asstring;
      Sheet := DataM1.Query2.fields[13].asstring + ' ' + sheetfb[DataM1.Query2.fields[14].asInteger];
      aktpage := DataM1.Query2.fields[10].asinteger;

      aktflatsep := DataM1.Query2.fields[15].asinteger;
    end
    Else
    begin
      IF Lowpage > DataM1.Query2.fields[10].asinteger then
      begin
        Lowpage := DataM1.Query2.fields[10].asinteger;
        Lowpagename := DataM1.Query2.fields[11].asstring;
      end;
      IF aktpage <> DataM1.Query2.fields[10].asinteger then
      begin
        IF (Prefs.PlatePrintoutUseSectionPage) then
          pagenames := pagenames+DataM1.Query2.fields[3].asstring+DataM1.Query2.fields[11].asstring +','
        else
          pagenames := pagenames+DataM1.Query2.fields[11].asstring +',';
        aktpage := DataM1.Query2.fields[10].asinteger;
        Aktcolors := tnames1.ColornameIDtoname(DataM1.Query2.fields[16].asinteger);
      End;
      T := tnames1.ColornameIDtoname(DataM1.Query2.fields[16].asinteger);
      IF pos(T,Aktcolors) = 0 then
        Aktcolors := Aktcolors+','+T;

    end;


    DataM1.Query2.next;
  end;
  DataM1.Query2.close;
  Printlines.add(genplatestr);


end;


procedure TFormPlateprint.Plateprint(pressrunid : Longint);

Function GetColtext(linenum : Longint;
                    colnum : Longint):String;
Var
  i,i1 : Longint;
  T : String;
Begin
//  #1jfkdfjkdjfkdjfkd #2fjkdjfkdjfkd #3jfkdjfkdjfdk;CMYK
  T := printlines[linenum];
  i := pos('#'+inttostr(colnum),T);

  if i = 1 then
  begin
    delete(t,1,2);
  end
  else
  begin
    delete(t,1,i+1);
  end;

  I := pos('#'+inttostr(colnum+1),T);
  IF i > 0 then
  begin
    delete(t,i,length(t)+100);
  end
  else
  begin
    I := pos(';',T);
    delete(t,i,length(t)+100);
  end;
  result :=T;

end;



var

  i,ic,ic2,colorW,totcolorW,colorstart,CHTitle,CHPlate : Longint;
  Aint : Longint;
  textH,RowH,Margwidth,NrowPrPage : Longint;
  coltextrec,textrow,Gridrect,titlerect,aktrow,toprow : Trect;

  colorgrids : array[1..5] of record
                                colorid : Longint;
                                name    : String;
                                R : Trect;
                              End;

  Selfontsize : Longint;

  Titletekst : String;

  PT,CT,t : String;
  NAktcolors : Longint;
  Aktcolors : Array[1..32] of string;

  PladelineI : Longint;
  PrintRowline : Longint;

  NColpos : Longint;
  Colpos : Array[1..100] of record
                              FromX : Longint;
                              Tox : Longint;
                              Width : Longint;
                            end;

  LefttextPOS,sumcol,tottextw,addtocol : Longint;
  Coltext : String;
begin
  IF formmain.PrintDialog1.Execute then
  begin
    Titletekst := Akttitle;
    Printer.Title := 'Plateprint'+inttostr(pressrunid);
    Printer.BeginDoc;
    //Printer.Canvas.Font := fsormsettings.FontDialogplateprint.Font;  // OK
    Printer.Canvas.Font.Assign(Prefs.FontDialogplateprintFont);



    Selfontsize := Printer.Canvas.Font.Size;
    Margwidth := (Printer.Pagewidth * 3) DIV 100;
    titlerect.top := Margwidth;
    titlerect.Bottom := (titlerect.top+Printer.Canvas.TextHeight('HH')+4) * 2;
    titlerect.Left := Margwidth;
    titlerect.Right := Printer.Pagewidth-Margwidth;
    Printer.Canvas.brush.Style := bsClear;
    Printer.Canvas.Pen.Style := psSolid;
    Printer.Canvas.Pen.color := clblack;

    Gridrect.Top := titlerect.Bottom+2;
    Gridrect.left := titlerect.left;
    Gridrect.right := titlerect.right;
    Gridrect.Bottom := Printer.PageHeight -Margwidth;
    RowH := Printer.Canvas.TextHeight('HgijIF(')+ (Printer.Canvas.TextHeight('HgijIF(') DIV 2 ) ;
    textH := Printer.Canvas.TextHeight('HgijIF(')+2;
    NrowPrPage := (Gridrect.Bottom - Gridrect.top) DIV RowH;

    CHPlate := (RowH-textH) div 2;

    IF NrowPrPage * RowH > Gridrect.Bottom - Gridrect.top then
      NrowPrPage := NrowPrPage -1;

    PladelineI := 0;
    PrintRowline := 0;

    LefttextPOS := Gridrect.left + CHPlate;

    aktrow := Gridrect;

    For ic := 1 to NAktcolorsInrun do
      colorgrids[ic].name := AktcolorsInrun[ic];

    colorW := 2;
    For ic := 1 to NAktcolorsInrun do
    begin
      IF colorW < Printer.Canvas.TextWidth(' '+colorgrids[IC].name+' ') then
        colorW := Printer.Canvas.TextWidth(' '+colorgrids[IC].name+' ');
    End;
    totcolorW := (NAktcolorsInrun *colorW);
    colorstart := aktrow.Right-totcolorW;

    For ic := 1 to NAktcolorsInrun do
    begin
      colorgrids[ic].r := aktrow;
      colorgrids[ic].r.Left := colorstart+((IC-1) *colorW);
      colorgrids[ic].r.right := colorgrids[ic].r.Left + colorW;
    end;

    T := Printlines[0];

    NColpos := 0;
    For i := 1 to length(T) Do
    begin
      IF T[i] = '#' then
      begin
        Inc(NColpos);
      end;
    end;

    For ic := 1 to 100 do
    begin
      Colpos[ic].FromX := 0;
      Colpos[ic].ToX := 0;
      Colpos[ic].Width := 0;

    end;
    //Step find bredeste linje
    For ic := 1 to NColpos do
    begin
      For i := 0 to Printlines.Count-1 do
      begin
        T := GetColtext(i,ic)+' ';
        IF Colpos[ic].Width < Printer.Canvas.TextWidth(T) then
          Colpos[ic].Width := Printer.Canvas.TextWidth(T);
      end;
    end;
    For ic := 1 to NColpos do
    begin
      T := Colnametilte[ic]+' ';
      IF Colpos[ic].Width < Printer.Canvas.TextWidth(T) then
        Colpos[ic].Width := Printer.Canvas.TextWidth(T);
    End;
    sumcol := 0;
    For ic := 1 to NColpos do
    begin
      sumcol := sumcol +Colpos[ic].Width;
    End;
    tottextw := ((gridrect.Right - gridrect.left) -totcolorW) - Printer.Canvas.TextWidth('    ');

    IF sumcol < tottextw then
    begin
      addtocol := (tottextw - sumcol) DIV NColpos;
      For ic := 1 to NColpos do
      begin
        Colpos[IC].Width := Colpos[IC].Width +addtocol;
      End;
    end;


    Colpos[1].FromX := LefttextPOS;
    Colpos[1].ToX   := Colpos[1].FromX + Colpos[1].Width;

    For ic := 2 to NColpos do
    begin
      Colpos[ic].FromX := Colpos[ic-1].ToX;
      Colpos[IC].ToX   := Colpos[IC].FromX + Colpos[IC].Width;
    End;

    Printer.Canvas.pen.width := 2;

    Repeat
      IF PrintRowline = 0 then
      begin
        // Tegn title; og farver
        Printer.Canvas.Brush.Color := clsilver;
        Printer.Canvas.FrameRect(titlerect);
        Printer.Canvas.FrameRect(Gridrect);
        aktrow := Gridrect;
        aktrow.Bottom := aktrow.top + RowH;
        toprow := aktrow;

        Printer.Canvas.brush.Style := bsClear;
        Printer.Canvas.font.Color := clblack;
        Printer.Canvas.Pen.Style := psSolid;
        Printer.Canvas.Pen.color := clblack;

        CHTitle := 2;

        While (Printer.Canvas.TextWidth('  '+Titletekst+'  ' ) < titlerect.right - titlerect.left) and
              (Printer.Canvas.TextHeight('  '+Titletekst+'  ' ) < titlerect.bottom - titlerect.top) do
        begin
          Printer.Canvas.Font.Size := Printer.Canvas.Font.Size +1;
        end;

        IF (Printer.Canvas.TextWidth('  '+Titletekst+'  ' ) > titlerect.right - titlerect.left) or
           (Printer.Canvas.TextHeight('  '+Titletekst+'  ' ) > titlerect.bottom - titlerect.top) then
        begin
          Printer.Canvas.Font.Size := Printer.Canvas.Font.Size -1;
        end;

        CHTitle :=  (titlerect.bottom - titlerect.top) - (Printer.Canvas.TextHeight('  '+Titletekst+'  ' ));
        CHTitle := CHTitle DIV 2;

        Printer.Canvas.TextRect(titlerect ,titlerect.left,titlerect.top+CHTitle,'  '+Titletekst+'  ' );
        Printer.Canvas.Font.Size := Selfontsize;

        Printer.Canvas.Rectangle(aktrow);

        For ic := 1 to NAktcolorsInrun do
        begin
          Printer.Canvas.Rectangle(colorgrids[ic].R);
          Aint := (((colorgrids[ic].R.right - colorgrids[ic].R.left)) - Printer.Canvas.TextWidth(colorgrids[ic].name) ) DIV 2;
          Printer.Canvas.TextRect(colorgrids[ic].R, colorgrids[ic].R.left+aint,colorgrids[ic].R.Top +CHPlate,colorgrids[ic].name);
        End;

        coltextrec.Top := aktrow.Top+CHPlate;
        coltextrec.bottom := aktrow.bottom;

        For ic := 1 to NColpos do
        begin
          Coltext := Colnametilte[ic];
          coltextrec.Left := Colpos[ic].FromX;
          coltextrec.Right := Colpos[ic].ToX;
          Printer.Canvas.TextRect(coltextrec ,coltextrec.left+CHPlate+4,coltextrec.top,Coltext);
        End;


      end; // Slut p� title

      //Skriv en plate start
      Inc(aktrow.Top,RowH);
      Inc(aktrow.Bottom,RowH);

      Printer.Canvas.Rectangle(aktrow);
      textrow := aktrow;

      textrow.Right := colorgrids[1].R.left-4;
      textrow.left := textrow.left+CHPlate;
      textrow.Top := textrow.Top +CHPlate;
      textrow.Bottom := textrow.Bottom -CHPlate;

      PT := Printlines[PladelineI];
      delete(pt,pos(';',pt),length(pt));

      CT := Printlines[PladelineI];
      delete(ct,1,pos(';',ct));

      NAktcolors := 1;
      For ic := 1 to 32 do
        Aktcolors[ic] := '';

      For ic := 1 to length(ct) do
      Begin
        IF ct[ic] = ',' then
        begin
          Inc(NAktcolors);
        end
        else
        begin
          Aktcolors[NAktcolors] := Aktcolors[NAktcolors] +ct[ic];
        end;
      end;

      coltextrec.Top := textrow.Top;
      coltextrec.bottom := textrow.bottom;

      For ic := 1 to NColpos do
      begin
        Coltext := GetColtext(PladelineI,ic);
        coltextrec.Left := Colpos[ic].FromX;
        coltextrec.Right := Colpos[ic].ToX;
        Printer.Canvas.TextRect(coltextrec ,coltextrec.left+CHPlate+4,coltextrec.top,Coltext);
      End;

//      Printer.Canvas.TextRect(textrow ,textrow.left+CHPlate+4,textrow.top,PT);


      For ic := 1 to NAktcolorsInrun do
      begin
        Printer.Canvas.brush.color := clsilver;
        colorgrids[ic].R.Top := aktrow.Top;
        colorgrids[ic].R.Bottom := aktrow.Bottom;
        For ic2 := 1 to NAktcolors do
        begin
          IF Aktcolors[ic2]  = colorgrids[ic].name then
          begin
            Printer.Canvas.brush.color :=  clwhite;
            break;
          end;
        end;

        Printer.Canvas.Rectangle(colorgrids[ic].R);
      End;

      Printer.Canvas.brush.color := clwhite;
      //Skriv en plate Slut


      Inc(PrintRowline);
      IF PrintRowline >= NrowPrPage-1 then
      begin
        Printer.NewPage;
        PrintRowline := 0;
      end;
      Inc(PladelineI);
    Until PladelineI >= Printlines.Count;

    Printer.EndDoc;
  End;
end;


procedure TFormPlateprint.FormCreate(Sender: TObject);
begin
  Printlines := tstringlist.Create;
end;

end.
