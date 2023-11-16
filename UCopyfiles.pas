unit UCopyfiles;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, CheckLst, ExtCtrls, ShellCtrls, ShellAPI;

type
  TFormCopyfileclip = class(TForm)
    Panel3: TPanel;
    Image2: TImage;
    Label7: TLabel;
    Label8: TLabel;
    GroupBox1: TGroupBox;
    CheckListBox1: TCheckListBox;
    GroupBox2: TGroupBox;
    ComboBox1: TComboBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    CLBactivated : Boolean;
    Function delafold(DirName : string):Boolean;
    procedure preparecopy;
    Function makefilename(publicationid : Longint;
                          Editionid     : Longint;
                          Sectionid     : Longint;
                          Publicationdate : Tdatetime;
                          pagename      : String;
                          Inputfilename : String;
                          Colorid       : Longint):string;

  public
    Masterlist : TStrings;
    Tolist : TStrings;
    DBFilter : String;
    { Public declarations }
  end;

var
  FormCopyfileclip: TFormCopyfileclip;

implementation

{$R *.dfm}

Uses
  umain, Udata,utypes, Usettings;

Function TFormCopyfileclip.delafold(DirName : string):Boolean;
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

Function TFormCopyfileclip.makefilename(publicationid : Longint;
                                        Editionid     : Longint;
                                        Sectionid     : Longint;
                                        Publicationdate : Tdatetime;
                                        pagename      : String;
                                        Inputfilename : String;
                                        Colorid       : Longint):string;
Var
  T,t2,sep : string;
  I : Longint;

Begin

  if ComboBox1.ItemIndex < 2 then
    sep := ComboBox1.text
  else
    sep := ' ';

  T := '';
  IF CheckListBox1.Checked[0] then
  begin
    if length(T) > 0 then
      T := T + sep;
    T := T + formatdatetime('DDMMYYYY',Publicationdate);
  end;

  IF CheckListBox1.Checked[1] then
  begin
    if length(T) > 0 then
      T := T + sep;
    T := T + tnames1.publicationIDtoname(publicationid);
  end;

  IF CheckListBox1.Checked[2] then
  begin
    if length(T) > 0 then
      T := T + sep;
    T := T + tnames1.editionIDtoname(editionid);
  end;

  IF CheckListBox1.Checked[3] then
  begin
    if length(T) > 0 then
      T := T + sep;
    T := T + tnames1.sectionIDtoname(sectionid);
  end;

  IF CheckListBox1.Checked[4] then
  begin
    if length(T) > 0 then
      T := T + sep;

    IF colorid > -1 then
      T := T + extractfilename(Inputfilename)
    Else
    begin
      T2 := extractfilename(Inputfilename);
      T2 := changefileext(T2,'.jpg');
      T := T + T2;
    end;
  end
  Else
  begin
    if length(T) > 0 then
      T := T + sep;

    IF colorid > -1 then
      T := T + pagename+ sep+ tnames1.ColornameIDtoname(colorid) + '.tif'
    else
      T := T + pagename+ '.jpg'
  end;
  result := T;
end;

procedure TFormCopyfileclip.preparecopy;
Var
  I : Longint;
  Fromfile,filename : String;

  filesOK : Boolean;
  thisMasterCopySeparationSet : Longint;
  thisColor : string;
  thisColorID : Longint;
Begin
  try
    filesOK := false;
    Masterlist.Clear;
    Tolist.clear;
    Case Popupmenunumber of
      1 : begin                  // pagetree;

            FormCopyfileclip.DBFilter := 'Where active <> -999 and status >= 10 ';
            IF formmain.TreeViewpagelist.Selected = nil then exit;
            IF TTreeViewpagestype(formmain.TreeViewpagelist.Selected.data^).publicationid > -1 then
              FormCopyfileclip.DBFilter := FormCopyfileclip.DBFilter + 'and publicationid = ' + inttostr(TTreeViewpagestype(formmain.TreeViewpagelist.Selected.data^).publicationid);
            IF TTreeViewpagestype(formmain.TreeViewpagelist.Selected.data^).editionid > -1 then
              FormCopyfileclip.DBFilter := FormCopyfileclip.DBFilter + 'and editionid = ' + inttostr(TTreeViewpagestype(formmain.TreeViewpagelist.Selected.data^).editionid);
            IF TTreeViewpagestype(formmain.TreeViewpagelist.Selected.data^).sectionid > -1 then
              FormCopyfileclip.DBFilter := FormCopyfileclip.DBFilter + 'and sectionid = ' + inttostr(TTreeViewpagestype(formmain.TreeViewpagelist.Selected.data^).sectionid);
            IF TTreeViewpagestype(formmain.TreeViewpagelist.Selected.data^).pubdate > 0 then
              FormCopyfileclip.DBFilter := FormCopyfileclip.DBFilter + ' and '+  DataM1.makedatastr('',TTreeViewpagestype(formmain.TreeViewpagelist.Selected.data^).pubdate);
            IF (formmain.ComboBoxpalocationNY.enabled) AND (formmain.ComboBoxpalocationNY.Text <> 'All')  then
            Begin
              FormCopyfileclip.DBFilter := FormCopyfileclip.DBFilter + 'and locationid = ' +
                inttostr(tnames1.locationnametoid(formmain.ComboBoxpalocationNY.items[formmain.ComboBoxpalocationNY.ItemIndex]));
            End;
            DataM1.Query1.SQL.Clear;
            DataM1.Query1.SQL.add('Select distinct publicationid,Editionid,Sectionid,Pubdate,pagename,FileName,Colorid,mastercopyseparationset,fileserver from pagetable');
            DataM1.Query1.SQL.add(FormCopyfileclip.DBFilter);
            formmain.Tryopen(DataM1.Query1);
            While not DataM1.Query1.eof do
            begin

              thisMasterCopySeparationSet := DataM1.Query1.fields[7].AsInteger;
              thisColor :=  tnames1.ColornameIDtoname(DataM1.Query1.fields[6].asinteger);


              Fromfile := Formmain.GetFileServerPath(PATHTYPE_CCFILES, DataM1.Query1.fields[8].asstring) +
                                                   inttostr(thisMasterCopySeparationSet)+'.'+
                                                   thisColor;

              if (Prefs.NewPreviewNames) then
              begin
                Fromfile := Formmain.GetFileServerPath(PATHTYPE_CCFILES, DataM1.Query1.fields[8].asstring) +
                                                   DataM1.Query1.fields[5].asstring+'===='+
                                                   inttostr(thisMasterCopySeparationSet)+'.'+
                                                   thisColor;

                if ( NOT Fileexists(fromfile)) then
                  Fromfile := Formmain.GetFileServerPath(PATHTYPE_CCFILES, DataM1.Query1.fields[8].asstring) +
                                                   inttostr(thisMasterCopySeparationSet)+'.'+
                                                   thisColor;
              end;

              Masterlist.Add(Fromfile);

              filename := Tmpfolder+'\Copyfolder\'+ makefilename(DataM1.Query1.fields[0].asinteger,
                                                                 DataM1.Query1.fields[1].asinteger,
                                                                 DataM1.Query1.fields[2].asinteger,
                                                                 DataM1.Query1.fields[3].asdatetime,
                                                                 DataM1.Query1.fields[4].asstring,
                                                                 DataM1.Query1.fields[5].asstring,
                                                                 DataM1.Query1.fields[6].asinteger);
              If copyfile(pchar(Fromfile),pchar(filename),false) then
              begin
                tolist.Add(filename);
              end;
              DataM1.Query1.next;
            end;
          end;
      2 : Begin
            FormCopyfileclip.DBFilter := 'Where active <> -999 and status >= 10 ';
            IF formmain.TreeViewpagelist.Selected = nil then exit;
            IF TTreeViewpagestype(formmain.TreeViewpagelist.Selected.data^).publicationid > -1 then
              FormCopyfileclip.DBFilter := FormCopyfileclip.DBFilter + 'and publicationid = ' + inttostr(TTreeViewpagestype(formmain.TreeViewpagelist.Selected.data^).publicationid);
            IF TTreeViewpagestype(formmain.TreeViewpagelist.Selected.data^).editionid > -1 then
              FormCopyfileclip.DBFilter := FormCopyfileclip.DBFilter + 'and editionid = ' + inttostr(TTreeViewpagestype(formmain.TreeViewpagelist.Selected.data^).editionid);
            IF TTreeViewpagestype(formmain.TreeViewpagelist.Selected.data^).sectionid > -1 then
              FormCopyfileclip.DBFilter := FormCopyfileclip.DBFilter + 'and sectionid = ' + inttostr(TTreeViewpagestype(formmain.TreeViewpagelist.Selected.data^).sectionid);
            IF TTreeViewpagestype(formmain.TreeViewpagelist.Selected.data^).pubdate > 0 then
              FormCopyfileclip.DBFilter := FormCopyfileclip.DBFilter + ' and '+  DataM1.makedatastr('',TTreeViewpagestype(formmain.TreeViewpagelist.Selected.data^).pubdate);
            IF (formmain.ComboBoxpalocationNY.enabled) AND (formmain.ComboBoxpalocationNY.Text <> 'All') then
            Begin
              FormCopyfileclip.DBFilter := FormCopyfileclip.DBFilter + 'and locationid = ' +
                inttostr(tnames1.locationnametoid(formmain.ComboBoxpalocationNy.items[formmain.ComboBoxpalocationNy.ItemIndex]));
            End;
            DataM1.Query1.SQL.Clear;                      //0      1         2         3      4        5         6           7
            DataM1.Query1.SQL.add('Select distinct publicationid,Editionid,Sectionid,Pubdate,pagename,FileName,Colorid,mastercopyseparationset,fileserver from pagetable');
            DataM1.Query1.SQL.add(FormCopyfileclip.DBFilter);
            formmain.Tryopen(DataM1.Query1);
            IF not DataM1.Query1.Eof then
            begin
               thisMasterCopySeparationSet := DataM1.Query1.fields[7].AsInteger;
               thisColorID  := DataM1.Query1.fields[6].AsInteger;
              for i := 1 to formmain.StringGridHS.RowCount do
              begin
                IF SuperHSdata[i-1].Selected then
                begin
                  IF SuperHSdata[i-1].status >= 10 then
                  begin
                    DataM1.Query1.First;
                    While not DataM1.Query1.Eof do
                    begin
                      if (thisMasterCopySeparationSet = SuperHSdata[i-1].mastercopyseparationset) and (thisColorID = SuperHSdata[i-1].colorid) then
                      begin

                        Fromfile := Formmain.GetFileServerPath(PATHTYPE_CCFILES, DataM1.Query1.fields[8].asstring) +
                                                              inttostr(thisMasterCopySeparationSet) + '.'+
                                                             tnames1.ColornameIDtoname(thisColorID);
                         if (Prefs.NewPreviewNames) then
                         begin
                           Fromfile := Formmain.GetFileServerPath(PATHTYPE_CCFILES, DataM1.Query1.fields[8].asstring) +
                                                              DataM1.Query1.fields[5].asstring+'===='+
                                                              inttostr(thisMasterCopySeparationSet) + '.'+
                                                             tnames1.ColornameIDtoname(thisColorID);

                           if ( NOT Fileexists(fromfile)) then
                             Fromfile := Formmain.GetFileServerPath(PATHTYPE_CCFILES, DataM1.Query1.fields[8].asstring) +
                                                              inttostr(thisMasterCopySeparationSet) + '.'+
                                                             tnames1.ColornameIDtoname(thisColorID);
                          end;


                        Masterlist.Add(Fromfile);

                        filename := Tmpfolder+'\Copyfolder\'+ makefilename(DataM1.Query1.fields[0].asinteger,
                                                                           DataM1.Query1.fields[1].asinteger,
                                                                           DataM1.Query1.fields[2].asinteger,
                                                                           DataM1.Query1.fields[3].asdatetime,
                                                                           DataM1.Query1.fields[4].asstring,
                                                                           DataM1.Query1.fields[5].asstring,
                                                                           DataM1.Query1.fields[6].asinteger);
                        If copyfile(pchar(Fromfile),pchar(filename),false) then
                        begin
                          tolist.Add(filename);
                        end;
                        Break;
                      end;
                      DataM1.Query1.next;
                    end;
                  end;
                End;
              End;
              DataM1.Query1.next;

            end;
          end;
      3 : begin

          end;
      4 : begin
          end;
    end;

    IF tolist.Count > 0 then
    begin
      formmain.Fileclipboard1.PutFilesToClipboard(tolist);
      filesOK := true;
    end;
  Except
    filesOK := false;
  end;

  IF not filesOK then
  begin
    MessageDlg(formmain.InfraLanguage1.Translate('Unable to copy any files'), mtInformation,[mbOk], 0);
  end;

end;



procedure TFormCopyfileclip.BitBtn1Click(Sender: TObject);
begin
  delafold(Tmpfolder+'\Copyfolder');
  createdir(Tmpfolder+'\Copyfolder');
  preparecopy;
end;

procedure TFormCopyfileclip.FormCreate(Sender: TObject);
begin
  Masterlist := TStringList.Create;
  Tolist := TStringList.Create;

end;

procedure TFormCopyfileclip.FormActivate(Sender: TObject);
begin
  if not CLBactivated then
  begin
    CheckListBox1.checked[0] := true;
    CheckListBox1.checked[1] := true;
    CheckListBox1.checked[2] := true;
    CheckListBox1.checked[3] := true;
    CLBactivated := true;
  End;
  
end;

procedure TFormCopyfileclip.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  CLBactivated := false;
end;

end.
