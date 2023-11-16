unit UExportcustomplan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, xmldom, XMLIntf, msxmldom, XMLDoc, StdCtrls;

type
  TFormExportcustomplan = class(TForm)
    XMLDocument1: TXMLDocument;
    XMLDocument2: TXMLDocument;
    Button1: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Makecustomxmlexport(Destpath                : String;
                                  Customfile              : String;
                                  Frontfilename           : string;
                                  LocationId              : Longint;
                                  PressId                 : Longint;
                                  ProductionId            : Longint;
                                  Publicationid           : Longint;
                                  Pubdate                 : tdatetime);

  end;

var
  FormExportcustomplan: TFormExportcustomplan;

implementation

uses Usettings, Udata, USetschedules,DateUtils,umain,utypes, UApplyplan, UUtils;

{$R *.dfm}
procedure TFormExportcustomplan.Makecustomxmlexport(Destpath                : String;
                                                    Customfile              : String;
                                                    Frontfilename           : string;
                                                    LocationId              : Longint;
                                                    PressId                 : Longint;
                                                    ProductionId            : Longint;
                                                    Publicationid           : Longint;
                                                    Pubdate                 : tdatetime);


Var
  AFileNameList : TStrings;

  presstime : Tdatetime;
  presslength : Tdatetime;
  endpresstime : Tdatetime;
  SectionsInrun,presslengthstr : string;
  runnumber : Longint;
  Npresssytemnames : Longint;
  presssytemnames : Array[1..100] OF string;

Procedure datetimeposstr(datetime : tdatetime;
                         Var filestr  : string;
                         pross    : String);
Var
  i1,i2,pos1,pos2,i,l : Longint;
  foundAform : Boolean;
  Dformat,tidstr : String;
  akt : integer;
  achar : Char;
  T,pl : string;
  adtid,gange : Longint;
  foundaformat : Boolean;
Begin
  foundaformat := false;
  akt := -1;
  pos1 := pos(pross,filestr);

  T := filestr;

  Dformat := 'dd.mm.yy';
  tidstr := formatdatetime(Dformat,datetime);
  gange := 1;
  i1 := pos('[',T);
  IF i1 > 0 then
  begin
    While i1 > 0 do
    begin
      i2 := pos(']',T);
      pl := copy(t,i1+1,(i2-i1)-1);
      IF pl[1] = '-' then
      begin
        delete(pl,1,1);
        gange := -1;
      end;
      adtid := strtoint(pl);
      adtid := adtid * gange;
      Case filestr[i1-1] of
        'Y' : datetime := incyear(datetime,adtid);
        'M' : datetime := incmonth(datetime,adtid);
        'D' : datetime := incday(datetime,adtid);
        'H' : datetime := inchour(datetime,adtid);
        'N' : datetime := incminute(datetime,adtid);
        'S' : datetime := incSecond(datetime,adtid);
        'y' : datetime := incyear(datetime,adtid);
        'm' : datetime := incmonth(datetime,adtid);
        'd' : datetime := incday(datetime,adtid);
        'h' : datetime := inchour(datetime,adtid);
        'n' : datetime := incminute(datetime,adtid);
        's' : datetime := incSecond(datetime,adtid);
      end;
      delete(t,i1,(i2-i1)+1);

      I1 := pos('[',T);
    end;
    filestr := T;
    pos1 := pos(pross,filestr);
  End;

  IF length(filestr) > pos1+3 then
  begin
    IF filestr[pos1+2] = '(' then
    begin
      foundaformat := true;
      i := pos1+3;
      Dformat := '';
      l := 4;
      repeat

        Dformat := Dformat + filestr[I];
        Inc(I);
        Inc(l);
      until filestr[I] = ')';

      pos2 := i;

      tidstr := formatdatetime(Dformat,datetime);
      delete(filestr,pos1,l);

    end;

  end
  Else
  Begin
    tidstr := formatdatetime(Dformat,datetime);
    delete(filestr,pos1,2);

  End;
  if not foundaformat then
    delete(filestr,pos1,2);
  insert(tidstr,filestr,pos1);
end;



function MakeAnewline(lineinfile : String):String;
Var
  T,t1 : string;
  ip,apos : Longint;
  foundNopss : Boolean;
  atime : Tdatetime;
Begin
  T := lineinfile;

  repeat
    foundNopss := true;
    for ip := 1 to Nprosenttypes do
    begin
      apos := pos(prosenttypes[ip].prosst,T);
      IF apos  > 0 then
      begin
        foundNopss := false;
        Case ip of
          1 : Begin
                delete(t,apos,2);
                Insert(tnames1.publicationIDtoname(publicationid),t,apos);
              end;
          2 : Begin
                delete(t,apos,2);
                Insert(datam1.Query1.fields[2].asstring,t,apos);
              end;
          3 : Begin
                delete(t,apos,2);
                Insert(SectionsInrun,t,apos);
              end;
          4 : Begin
                delete(t,apos,2);
                Insert(datam1.Query1.fields[9].asstring,t,apos);
              end;
          5 : Begin
//                delete(t,apos,2);
                datetimeposstr(Now,T,prosenttypes[ip].prosst);
              end;
          6 : Begin
                delete(t,apos,2);
                Insert(tnames1.pressnameIDtoname(pressid),t,apos);
              end;
          7 : Begin
                delete(t,apos,2);
                Insert(datam1.Query1.fields[11].asstring,t,apos);
              end;
          8 : Begin
                delete(t,apos+2,1);
                datetimeposstr(presstime,T,'%K');
              end;
          9 : Begin
                delete(t,apos+2,1);
                datetimeposstr(Endpresstime,T,'%K');
              end;
          10: Begin
                delete(t,apos,3);
                Insert(presslengthstr,t,apos);
              end;
          11: Begin
                delete(t,apos,2);
                if DBVersion > 1 then
                  Insert(datam1.Query1.fields[13].asstring,t,apos);
              end;
          12: Begin
              //  delete(t,apos,2);
                datetimeposstr(Pubdate,T,prosenttypes[ip].prosst);
              end;
          13: Begin
                delete(t,apos,2);
                Insert(tnames1.locationIDtoname(locationid),t,apos);
              end;

          14: Begin
                delete(t,apos,2);
                Insert(datam1.Query1.fields[4].asstring,t,apos);
              end;
          15: Begin
                delete(t,apos,2);
                IF DBVersion > 1 then
                begin
                  t1 := datam1.Query1.fields[12].asstring;
                  Insert(t1,t,apos);
                end;
              end;
          16: Begin
                delete(t,apos,2);
                t1 := Inttostr(runnumber);
                Insert(t1,t,apos);
              end;
          17: Begin
                delete(t,apos,2);
                if DBVersion > 1 then
                  Insert(datam1.Query1.fields[14].asstring,t,apos);
              end;
          18 : Begin
                delete(t,apos+2,1);
                atime := datam1.Query1.fields[15].asdatetime;
                datetimeposstr(Atime,T,'%K');
              end;
          19 : Begin
                delete(t,apos+2,1);
                atime := datam1.Query1.fields[16].asdatetime;
                datetimeposstr(Atime,T,'%K');
              end;
          20: Begin
                delete(t,apos,2);
                if DBVersion > 1 then
                  Insert(datam1.Query1.fields[17].asstring,t,apos);
              end;

          else
          begin
            beep;

          end;
        end;

      end;

    end;
  Until foundNopss;
  result := t;

end;


Function makeexportfilename(Afileset : String):String;
Var
  I : Longint;
  T : String;
Begin

  AFileNameList.Clear;

  T := '';
  I := 1;


  repeat
    IF Afileset[i] = '%' then
    begin
      AFileNameList.add(Afileset[i]+Afileset[i+1]);
    end
    Else
    begin
      AFileNameList.add(Afileset[i]);
    end;
    Inc(I);
  until i = length(Afileset)+1;

  result := '';

  For i := 0 to AFileNameList.Count-1 do
  begin
    T := AFileNameList[i];
    IF T[1] = '%' then
    begin
      Case T[2] of
        'O' : begin
                result := result + datam1.Query1.fields[4].asstring;
              end;
        'V' : begin
                result := result + datam1.Query1.fields[18].asstring;
              end;
//        01_P_PRO_%O_%V.xml
      end;
    end
    else
    begin
      result := result + T;
    end;
  end;

end;

Var
  AList,blist,clist : TStrings;
  T,OT,tmppross : String;
  foundNopss : boolean;
  I,IP : Longint;
  Atr1,atr2 : Longint;


  t1,t2,t3 : string;
  AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond: Word;
  BYear, BMonth, BDay, BHour, BMinute, BSecond, BMilliSecond : word;
  i1,akteditionid,atksectionid,aktpressrunid,aktpageindex : Longint;

  Filename : String;


Begin
  IF dbversion > 1 then
  begin
    try
      Npresssytemnames := 0;
      for i := 1 to 100 do
        presssytemnames[i] := '';


      for i := 0 to FormApplyproduction.ListViewpress.items.count-1 do
      begin
        Inc(Npresssytemnames);
        presssytemnames[Npresssytemnames] := FormApplyproduction.ListViewpress.items[i].subitems[2];
      end;

      runnumber := 0;
      akteditionid := -1;
      atksectionid := -1;
      aktpressrunid  := -1;



      IF Prefs.PlanXMLExportFolder = '' then exit;
      if not fileexists(Customfile) then exit;
      AList := tstringlist.Create;
      blist := tstringlist.Create;
      clist := tstringlist.Create;
      AFileNameList := tstringlist.Create;

      datam1.Query1.SQL.Clear;                  //0         1       2       3            4             5            6            7                       8                9
      datam1.Query1.SQL.add('select distinct pa.pubdate,pn.name,en.name,en.editionid,pre.OrderNumber,pr.productionid,pr.plantype,pre.UsePressTowerInfo,pre.pressrunid,pre.SequenceNumber ');
                              //10             11
      datam1.Query1.SQL.add(',pa.presstime,pre.comment ');
      IF DBVersion > 1 then
      Begin                        //12               13             14                15           16            17            18
        datam1.Query1.SQL.add(',pre.presssystem,pre.Circulation,pre.Circulation2,pre.deadline1,pre.deadline2,pre.planname,pre.planversion');
      End;

      datam1.Query1.SQL.add('from pressrunid pre, ');
      datam1.Query1.SQL.add('pagetable pa,publicationnames pn,editionnames en,productionnames pr');
      datam1.Query1.SQL.add('where pre.pressrunid = pa.pressrunid and');
      datam1.Query1.SQL.add('pn.publicationid = pa.publicationid and');
      datam1.Query1.SQL.add('en.editionid = pa.editionid and');
      datam1.Query1.SQL.add('pr.productionid = pa.productionid');
      datam1.Query1.SQL.add('And pa.productionid = ' + inttostr(ProductionId));
      datam1.Query1.SQL.add('And pa.locationid = ' + inttostr(locationId));
      datam1.Query1.SQL.add('Order by pa.pubdate,pn.name,en.name,pre.SequenceNumber');
      IF Prefs.debug then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'makecustplan.sql');
      formmain.tryopen(datam1.Query1);

      While not datam1.Query1.Eof do
      begin
        AList.LoadFromFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory())+'CustomExport.xml');
        blist.clear;
        clist.clear;

        decodedatetime(presstime,AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond);
        decodedatetime(presslength,BYear, BMonth, BDay, BHour, BMinute, BSecond, BMilliSecond);
        endpresstime := IncHour(presstime,BHour);
        endpresstime := Incminute(endpresstime,BMinute);

        t1 := datetimetostr(presstime);
        t2 := timetostr(presslength);
        presslengthstr := '01:00';

        for i := 0 to AList.count-1 do
        begin
          if pos('<attributelist>',AList[i]) > 0  then
          begin
            Atr1 := i;
          end;
          IF pos('</attributelist>',AList[i]) > 0 then
          begin
            Atr2 := i;
          end;
        End;

        for i := Atr1 to Atr2 do
        begin
          clist.add(alist[i]);
        End;
        i := 0;

        repeat
          if (i = Atr1) then
          begin
            Inc(runnumber);
            SectionsInrun := '';
            datam1.Query2.sql.Clear;
            datam1.Query2.sql.Add('select distinct sectionid from pagetable');
            datam1.Query2.sql.Add('Where pressrunid = ' + datam1.Query1.fields[8].asstring);
            datam1.Query2.open;
            while not datam1.Query2.eof do
            begin
              SectionsInrun := SectionsInrun + tnames1.sectionIDtoname(datam1.Query2.fields[0].asinteger)+',';
              datam1.Query2.next;
            end;
            datam1.Query2.close;

            IF length(SectionsInrun) > 0 then
              delete(SectionsInrun,length(SectionsInrun),1);

            i1 := 0;
            repeat

              T := CList[i1];
              T := MakeAnewline(T);
              bList.Add(T);
              inc(i1);
            until i1 >= clist.Count;
            presstime    := endpresstime;
            endpresstime := IncHour(presstime,BHour);
            endpresstime := Incminute(endpresstime,BMinute);

            for i1 := Atr1 to Atr2 do
              alist.Delete(i);

            for i1 := 0 to blist.Count-1 do
            begin
              alist.Insert(Atr1+i1,blist[i1]);
            end;
            i := Atr1+i1;
          end;
          T := AList[i];
          T := MakeAnewline(T);
          AList[i] := T;
          Inc(I);
        until i >= AList.count;





        Filename := makeexportfilename(Prefs.PlanXMLExportFolder);



        AList.SaveToFile(includetrailingbackslash(destpath)+
                         Filename );

        datam1.Query1.next;

      End;

      datam1.Query1.close;

    finally
      AList.Free;
      blist.Free;
      AFileNameList.Free;
    end;
  End;
end;

end.






