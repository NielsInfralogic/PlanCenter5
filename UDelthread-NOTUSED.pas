unit UDelthread;

interface

uses
  Classes;

type
  Tdelfilesthread = class(TThread)
  private
    Listbox1 : TStrings;
    function checkname(Colorid : string;
                       mastercopyname : string):Boolean;

    Procedure removefilesfromserver;
    Function delafold(DirName : string):Boolean;
  protected
    procedure Execute; override;

  Public
    Constructor Create;
  end;

implementation
{$R *.dfm}
uses SysUtils,Usettings, Umain,utypes, Udata, UFTP,ShellAPI;

Constructor Tdelfilesthread.create;
Begin
  inherited create(false);
  Listbox1 := TStringList.Create;
  freeonterminate := true;
end;

{ Tdelfilesthread }

procedure Tdelfilesthread.Execute;
begin
  { Place thread code here }
end;







function Tdelfilesthread.checkname(Colorid : string;
                                     mastercopyname : string):Boolean;
Var
  I : Longint;

Begin
  try
    result := false;
    I := strtoint(mastercopyname);

    IF Colorid <> '-1' then
      result := true;
  except
  end;
end;

Procedure Tdelfilesthread.removefilesfromserver;


Var
  mastercopysettodel,colorid : string;

  I,icolor : Longint;
  T,t2,tcolor,colort : string;
  deldir : String;
  F: TSearchRec;
  Webprevpath : string;

  totcount : Longint;
procedure delwebpreviews(flashpath : string);

Var
  Aktpath : String;
  I,icolor : Longint;
begin
  try
    Aktpath := IncludeTrailingBackslash(flashpath);
    if DirectoryExists(aktpath) then
    begin
      deldir := IncludeTrailingBackslash(aktpath);
      I := FindFirst(deldir+'*.jpg',faArchive,F);
      While I = 0 do
      begin
        ListBox1.Add(f.Name);
        I := findnext(f);
      end;
      Findclose(f);
      For i := 0 to ListBox1.count-1 do
      begin
        Formmain.ProgressBardelete.Position := Formmain.ProgressBardelete.Position +1;

        T := extractfilename(ListBox1[i]);
        if t <> '' then
        begin
          try
          // NAN 20150507
            if pos('====',t) > 0 then
            begin
                t:= copy(t,pos('====',t)+4,MaxInt);
            end;

            if pos('_',t) > 0 then
            begin
              mastercopysettodel := copy(t,1,pos('_',t)-1);
            end
            else
            begin
              mastercopysettodel := copy(t,1,pos('.',t)-1);
            end;

            if checkname('1',mastercopysettodel) then
            begin
              DataM1.Query1.SQL.clear;
              DataM1.Query1.SQL.add('Select separation from pagetable (NOLOCK)');
              DataM1.Query1.SQL.add('where mastercopyseparationset = ' + mastercopysettodel);
              IF pos('_',t) > 0 then
              Begin
                colort := t;
                delete(colort,1,pos('_',t));
                colort := copy(colort,1,pos('.',colort)-1);
                colorid := inttostr(inittypes.getcolorIDfromname(colort));
                DataM1.Query1.SQL.add('and colorid = ' + colorid);
              End;
              DataM1.Query1.SQL.add('and status > 0');
              DataM1.Query1.open;
              if DataM1.Query1.eof then
              begin
                deletefile(deldir+ListBox1[i]);
              end;
              DataM1.Query1.close;

            End;
          Except

          end;
        End;
      end;
    End;
  Except
  end;
end;

procedure cleanupflashfiles(flashpath : string);
Var
  Aktpath : String;
  I,icolor : Longint;

Begin
  try
    ListBox1.clear;
    Aktpath := flashpath;
    if DirectoryExists(aktpath) then
    begin
      deldir := IncludeTrailingBackslash(aktpath);
      I := FindFirst(deldir+'*.*',faDirectory	,F);
      While I = 0 do
      begin
        IF pos('.',f.Name) = 0 then
          ListBox1.Add(f.Name);
        I := findnext(f);
      end;
      Findclose(f);
      For i := 0 to ListBox1.count-1 do
      begin
        Formmain.ProgressBardelete.Position := Formmain.ProgressBardelete.Position +1;

        T := extractfilename(ListBox1[i]);
        if t <> '' then
        begin
          try
            // NAN 20150507
            if pos('====',t) > 0 then
            begin
                t:= copy(t,pos('====',t)+4,MaxInt);
            end;
            if pos('_',t) > 0 then
            begin
              mastercopysettodel := copy(t,1,pos('_',t)-1);
            end
            else
            begin
              mastercopysettodel := T;
            end;

            if checkname('1',mastercopysettodel) then
            begin
              DataM1.Query1.SQL.clear;
              DataM1.Query1.SQL.add('Select separation from pagetable (NOLOCK)');
              DataM1.Query1.SQL.add('where mastercopyseparationset = ' + mastercopysettodel);
              IF pos('_',t) > 0 then
              Begin
                colort := t;
                delete(colort,1,pos('_',t));
                //colort := copy(colort,1,pos('.',colort)-1);
                colorid := inttostr(inittypes.getcolorIDfromname(colort));
                DataM1.Query1.SQL.add('and colorid = ' + colorid);
              End;
              DataM1.Query1.SQL.add('and status > 0');
              DataM1.Query1.open;
              if DataM1.Query1.eof then
              begin
                delafold(deldir+ListBox1[i]);
              end;
              DataM1.Query1.close;

            End;
          Except

          end;
        End;
      end;
    End;
  Except
  end;
End;



procedure delwebthumbs(flashpath : string);
Var
  Aktpath : String;
  I,icolor : Longint;

Begin
  try
    ListBox1.clear;

    Aktpath := IncludeTrailingBackslash(flashpath); //+'CCThumbnails';

    if DirectoryExists(aktpath) then
    begin
      deldir := IncludeTrailingBackslash(aktpath);
      I := FindFirst(deldir+'*.jpg',faArchive,F);
      While I = 0 do
      begin
        ListBox1.Add(f.Name);
        I := findnext(f);
      end;
      Findclose(f);
      For i := 0 to ListBox1.count-1 do
      begin
        Formmain.ProgressBardelete.Position := Formmain.ProgressBardelete.Position +1;

        T := extractfilename(ListBox1[i]);
        if t <> '' then
        begin
          try
            // NAN 20150507
            if pos('====',t) > 0 then
            begin
                t:= copy(t,pos('====',t)+4,MaxInt);
            end;
            mastercopysettodel := changefileext(t,'');
            if checkname('1',mastercopysettodel) then
            begin
              DataM1.Query1.SQL.clear;
              DataM1.Query1.SQL.add('Select separation from pagetable (NOLOCK)');
              DataM1.Query1.SQL.add('where status > 0');
              DataM1.Query1.SQL.add('and mastercopyseparationset = ' + mastercopysettodel);
              DataM1.Query1.open;
              if DataM1.Query1.eof then
              begin
                deletefile(deldir+ListBox1[i]);
              end;
              DataM1.Query1.close;
            End;
          Except

          end;
        End;
      end;
    End;
  Except
  end;
End;

procedure cleanupreadviews(flashpath : string);
Var
  Aktpath : String;
  I,icolor : Longint;

Begin
  try
    ListBox1.clear;
    Aktpath := flashpath;
    if DirectoryExists(aktpath) then
    begin
      deldir := IncludeTrailingBackslash(aktpath);
      I := FindFirst(deldir+'*.*',faDirectory	,F);
      While I = 0 do
      begin
        IF pos('.',f.Name) = 0 then
          ListBox1.Add(f.Name);
        I := findnext(f);
      end;
      Findclose(f);
      For i := 0 to ListBox1.count-1 do
      begin
        Formmain.ProgressBardelete.Position := Formmain.ProgressBardelete.Position +1;

        T := extractfilename(ListBox1[i]);
        if t <> '' then
        begin
          try
          // NAN 20150507
            if pos('====',t) > 0 then
            begin
                t:= copy(t,pos('====',t)+4,MaxInt);
            end;
            delete(t,1,pos('_',t));
            mastercopysettodel := T;

            if checkname('1',mastercopysettodel) then
            begin
              DataM1.Query1.SQL.clear;
              DataM1.Query1.SQL.add('Select separation from pagetable (NOLOCK)');
              DataM1.Query1.SQL.add('where mastercopyseparationset = ' + mastercopysettodel);
              IF pos('_',t) > 0 then
              Begin
                colort := t;
                delete(colort,1,pos('_',t));
                //colort := copy(colort,1,pos('.',colort)-1);
                colorid := inttostr(inittypes.getcolorIDfromname(colort));
                DataM1.Query1.SQL.add('and colorid = ' + colorid);
              End;
              DataM1.Query1.SQL.add('and status > 0');
              DataM1.Query1.open;
              if DataM1.Query1.eof then
              begin
                delafold(deldir+ListBox1[i]);
              end;
              DataM1.Query1.close;

            End;
          Except

          end;
        End;
      end;


      deldir := IncludeTrailingBackslash(aktpath);
      I := FindFirst(deldir+'*.jpg',faArchive,F);
      While I = 0 do
      begin
        ListBox1.Add(f.Name);
        I := findnext(f);
      end;
      Findclose(f);
      For i := 0 to ListBox1.count-1 do
      begin
        Formmain.ProgressBardelete.Position := Formmain.ProgressBardelete.Position +1;

        T := extractfilename(ListBox1[i]);
        if t <> '' then
        begin
          try
          // NAN 20150507
            if pos('====',t) > 0 then
            begin
                t:= copy(t,pos('====',t)+4,MaxInt);
            end;
            T := changefileext(t,'');
            delete(t,1,pos('_',t));
            mastercopysettodel := T;
            if checkname('1',mastercopysettodel) then
            begin
              DataM1.Query1.SQL.clear;
              DataM1.Query1.SQL.add('Select separation from pagetable (NOLOCK)');
              DataM1.Query1.SQL.add('where status > 0');
              DataM1.Query1.SQL.add('and mastercopyseparationset = ' + mastercopysettodel);
              DataM1.Query1.open;
              if DataM1.Query1.eof then
              begin
                deletefile(deldir+ListBox1[i]);
              end;
              DataM1.Query1.close;
            End;
          Except

          end;
        End;
      end;
    End;

    
  Except
  end;
End;


Begin
  try
    totcount := 10;
    if DirectoryExists(FormSettings.Edithighrespath.text) then
    begin
      deldir := IncludeTrailingBackslash(FormSettings.Edithighrespath.text);
      I := FindFirst(deldir+'*.*',faArchive,F);
      While I = 0 do
      begin
        Inc(totcount);
        I := findnext(f);
      end;
      Findclose(f);
    End;

    if DirectoryExists(FormSettings.Editlowres.text) then
    begin
      deldir := IncludeTrailingBackslash(FormSettings.Edithighrespath.text);
      I := FindFirst(deldir+'*.jpg',faArchive,F);
      While I = 0 do
      begin
        Inc(totcount);
        I := findnext(f);
      end;
      Findclose(f);
    End;

    if DirectoryExists(FormSettings.Editthumbpath.text) then
    begin
      deldir := IncludeTrailingBackslash(FormSettings.Editthumbpath.text);
      I := FindFirst(deldir+'*.jpg',faArchive,F);
      While I = 0 do
      begin
        Inc(totcount);
        I := findnext(f);
      end;
      Findclose(f);
    End;


    Formmain.ProgressBardelete.Max := totcount;
    ListBox1.clear;


    //highres
    if DirectoryExists(FormSettings.Edithighrespath.text) then
    begin
      deldir := IncludeTrailingBackslash(FormSettings.Edithighrespath.text);
      I := FindFirst(deldir+'*.*',faArchive,F);
      While I = 0 do
      begin
        ListBox1.Add(f.Name);
        I := findnext(f);
      end;
      Findclose(f);
      For i := 0 to ListBox1.count-1 do
      begin
        Formmain.ProgressBardelete.Position := Formmain.ProgressBardelete.Position +1;

        T := extractfilename(ListBox1[i]);
        if t <> '' then
        begin
          try
            t2 := ExtractFileExt(t);
            if t2[1] = '.' then
              delete(t2,1,1);

            colorid := inttostr(inittypes.getcolorIDfromname(t2));
            // NAN 20150507
            if pos('====',t) > 0 then
            begin
                t:= copy(t,pos('====',t)+4,MaxInt);
            end;

            mastercopysettodel := changefileext(t,'');
            if checkname(colorid,mastercopysettodel) then
            begin
              DataM1.Query1.SQL.clear;
              DataM1.Query1.SQL.add('Select separation from pagetable (NOLOCK)');
              DataM1.Query1.SQL.add('where mastercopyseparationset = ' + mastercopysettodel);
              DataM1.Query1.SQL.add('and colorid = '+colorid);
              DataM1.Query1.open;
              if DataM1.Query1.eof then
              begin
                deletefile(deldir+ListBox1[i]);
              end;
              DataM1.Query1.close;
            End;
          Except

          end;
        End;
      end;
    End;
    ListBox1.clear;

    if DirectoryExists(FormSettings.Editlowres.text) then
    begin
      deldir := IncludeTrailingBackslash(FormSettings.Editlowres.text);
      I := FindFirst(deldir+'*.jpg',faArchive,F);
      While I = 0 do
      begin
        ListBox1.Add(f.Name);
        I := findnext(f);
      end;
      Findclose(f);
      For i := 0 to ListBox1.count-1 do
      begin
        Formmain.ProgressBardelete.Position := Formmain.ProgressBardelete.Position +1;

        T := extractfilename(ListBox1[i]);
        if t <> '' then
        begin
          try
          // NAN 20150507
            if pos('====',t) > 0 then
            begin
                t:= copy(t,pos('====',t)+4,MaxInt);
            end;
            if pos('_',t) > 0 then
            begin
              mastercopysettodel := copy(t,1,pos('_',t)-1);
            end
            else
            begin
              mastercopysettodel := copy(t,1,pos('.',t)-1);
            end;

            if checkname('1',mastercopysettodel) then
            begin

              DataM1.Query1.SQL.clear;
              DataM1.Query1.SQL.add('Select separation from pagetable (NOLOCK)');
              DataM1.Query1.SQL.add('where mastercopyseparationset = ' + mastercopysettodel);
              IF pos('_',t) > 0 then
              Begin
                colort := t;
                delete(colort,1,pos('_',t));
                colort := copy(colort,1,pos('.',colort)-1);
                colorid := inttostr(inittypes.getcolorIDfromname(colort));
                DataM1.Query1.SQL.add('and colorid = ' + colorid);
              End;
              DataM1.Query1.SQL.add('and status > 0');
              DataM1.Query1.open;
              if DataM1.Query1.eof then
              begin
                deletefile(deldir+ListBox1[i]);
              end;
              DataM1.Query1.close;

            End;
          Except

          end;
        End;
      end;
    End;
    ListBox1.clear;

    if DirectoryExists(FormSettings.Editthumbpath.text) then
    begin
      deldir := IncludeTrailingBackslash(FormSettings.Editthumbpath.text);
      I := FindFirst(deldir+'*.jpg',faArchive,F);
      While I = 0 do
      begin
        ListBox1.Add(f.Name);
        I := findnext(f);
      end;
      Findclose(f);
      For i := 0 to ListBox1.count-1 do
      begin
        Formmain.ProgressBardelete.Position := Formmain.ProgressBardelete.Position +1;

        T := extractfilename(ListBox1[i]);
        if t <> '' then
        begin
          try
            // NAN 20150507
            if pos('====',t) > 0 then
            begin
                t:= copy(t,pos('====',t)+4,MaxInt);
            end;
            mastercopysettodel := changefileext(t,'');
            if checkname('1',mastercopysettodel) then
            begin
              DataM1.Query1.SQL.clear;
              DataM1.Query1.SQL.add('Select separation from pagetable (NOLOCK)');
              DataM1.Query1.SQL.add('where status > 0');
              DataM1.Query1.SQL.add('and mastercopyseparationset = ' + mastercopysettodel);
              DataM1.Query1.open;
              if DataM1.Query1.eof then
              begin
                deletefile(deldir+ListBox1[i]);
              end;
              DataM1.Query1.close;
            End;
          Except

          end;
        End;
      end;
    End;
  except
  end;

  try
    // Web folders
    IF (FormSettings.webisftp) then
    Begin
      FormFTP.cleanup;
    end;
  Except
  end;

  IF (FormSettings.Editwebproofpath.text <> '') and (not FormSettings.webisftp) then
  begin
    ListBox1.clear;

    Webprevpath := IncludeTrailingBackslash(FormSettings.Editwebproofpath.text)+'CCpreviews\';
    cleanupflashfiles(Webprevpath);

    Webprevpath := IncludeTrailingBackslash(FormSettings.Editwebproofpath.text)+'CCpreviews\';
    delwebpreviews(Webprevpath);

    Webprevpath := IncludeTrailingBackslash(FormSettings.Editwebproofpath.text)+'CCThumbnails\';
    delwebthumbs(Webprevpath);

    Webprevpath := IncludeTrailingBackslash(FormSettings.Editwebproofpath.text)+'CCreadviewpreviews\';
    cleanupreadviews(Webprevpath);

  End;
  try
  
    ListBox1.clear;
    Webprevpath := IncludeTrailingBackslash(FormSettings.Editlowres.text);
    IF length(Webprevpath) > 0 then
    begin
      cleanupflashfiles(Webprevpath);
      delete(Webprevpath,length(Webprevpath)-11,11);
      Webprevpath := IncludeTrailingBackslash(Webprevpath) + 'CCreadviewpreviews\';
      cleanupreadviews(Webprevpath);
    end;







  Except

  end;
End;

Function Tdelfilesthread.delafold(DirName : string):Boolean;
var
  SHFileOpStruct : TSHFileOpStruct;
  DirBuf : array [0..255] of char;
begin
  try
   Fillchar(SHFileOpStruct,Sizeof(SHFileOpStruct),0) ;
   FillChar(DirBuf, Sizeof(DirBuf), 0 ) ;
   StrPCopy(DirBuf, DirName) ;
   with SHFileOpStruct do begin
    Wnd := 0;
    pFrom := @DirBuf;
    wFunc := FO_DELETE;
    fFlags := FOF_ALLOWUNDO;
    fFlags := fFlags or FOF_NOCONFIRMATION;
    fFlags := fFlags or FOF_SILENT;
   end;
    Result := (SHFileOperation(SHFileOpStruct) = 0) ;
   except
    Result := False;
  end;
end;


end.
