unit Udelpubl;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;
type
  TFormdelpublication = class(TForm)
    Panel3: TPanel;
    Image2: TImage;
    Label7: TLabel;
    Label8: TLabel;
    Panelbut: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox1: TGroupBox;
    CheckBoxAhighres: TCheckBox;
    CheckBoxAlowres: TCheckBox;
    GroupBox2: TGroupBox;
    ComboBoxdellocation: TComboBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ListView1: TListView;
    Memo1: TMemo;
    Label1: TLabel;
    CheckBoxgenrep: TCheckBox;
    Panelgenrep: TPanel;
    Paneldelpubl: TPanel;
    Panel2: TPanel;
    LabelBig: TLabel;
    Labelakt: TLabel;
    ImageAkt: TImage;
    Panel1: TPanel;
    Image4: TImage;
    Label2: TLabel;
    Labelaktrep: TLabel;
    ProgressBarrep: TProgressBar;
    ProgressBardel: TProgressBar;
    ProgressBarfiles: TProgressBar;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    CheckBoxpresssep: TCheckBox;
    Label6: TLabel;
    ComboBoxSectionFilter: TComboBox;
    CheckBoxDelfiles: TCheckBox;
    ComboBoxPagefilerday: TComboBox;
    Label9: TLabel;
    Label10: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ComboBoxdellocationChange(Sender: TObject);
    procedure ListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure ComboBoxPagefilerdayDropDown(Sender: TObject);
    procedure ComboBoxPagefilerdayCloseUp(Sender: TObject);
  private
    Procedure preparefileserverpaths;
    procedure Dodelete;
    Function Deletethefiles:Boolean;
    procedure setthedays;
    procedure loadlist;
    procedure AddfilesTodel(publicationid : Longint;
                            pubdate       : Tdatetime;
                            Delpressid       : Longint);
    Procedure cleanupproductionnames;
  public
    Delfilelist : TStrings;
    DelFolders : TStrings;
    Folderproblems : TStrings;
    DelfileLogOK,DelfileLogERROR : TStrings;
    Errorfolders : string;
    procedure remotedelete(delpubllist : Tstringlist);
  end;
var
  Formdelpublication: TFormdelpublication;
implementation
uses Udata, Umain, Usettings, DateUtils, UExportcustomplan,utypes,UFormReportgenrutines, UUtils;

Var
  NFileserverpaths : Longint;
  Fileserverpaths : Array[1..100] of record
                                       Servertype                  : Longint;
                                       Fileservername              : string;
                                       CCfiles                     : string;
                                       CCpreviews                  : string;
                                       CCthumbnails                : string;
                                       CCreadviewpreviews          : string;
                                       CCVersions                  : string;
                                       CCWEBpreviews               : string;
                                       CCWEBthumbnails             : string;
                                       CCWEBreadviewpreviews       : string;
                                       CCPDFfiles                  : String;
                                       CCPdflogs                   : String;
                                       Locationid                  : Longint;
                                       CCinkoriginals               : String;
                                       CCinkzonepreviews            : String;
                                       CCinkflatpreviews            : String;
                                       CCinkflatthumbnails          : String;
                                       CCinktempflats               : String; //flatsep.tif
                                                        //FlatSeparationSet
                                       Username : string;
                                       password : String;
                                       CCroot   : String;
                                     end;
  publlist : array[0..1000] of record
                                 publid : Longint;
                                 pubdate : tdatetime;
                                 pressid : Longint;
                               end;

{$R *.dfm}
procedure TFormdelpublication.AddfilesTodel(publicationid : Longint;
                                            pubdate       : Tdatetime;
                                            Delpressid       : Longint);
Procedure LookforRview(Folder : string;
                       master : string);
Var
  I,i2 : Longint;
  F: TSearchRec;
Begin
  try
    I := FindFirst(Folder+master+'_*',faAnyFile	,F);
    While I = 0 do
    begin
      IF f.Attr = faDirectory	 then
      Begin
        if DelFolders.indexof(Folder+f.name) = -1 then
          DelFolders.Add(Folder+f.name);
      End
      Else
      Begin
        if Delfilelist.indexof(Folder+f.name) = -1 then
          Delfilelist.Add(Folder+f.name);
      End;
      I := findnext(f);
    end;
    Findclose(f);
  Except
  end;
  Try
    I := FindFirst(Folder+'*_'+master+'.*',faAnyFile	,F);
    While I = 0 do
    begin
      IF f.Attr = faDirectory	 then
      Begin
        if DelFolders.indexof(Folder+f.name) = -1 then
          DelFolders.Add(Folder+f.name);
      End
      Else
      Begin
        if Delfilelist.indexof(Folder+f.name) = -1 then
          Delfilelist.Add(Folder+f.name);
      End;
      I := findnext(f);
    end;
    Findclose(f);
  Except
  end;

end;
Procedure findnameswithstar(Folder : String;
                            Starname : string);
Var
  I : Longint;
  F: TSearchRec;
Begin
  try
    Folder := includetrailingbackslash(Folder);
    I := FindFirst(Folder+Starname,faAnyFile	,F);
    While I = 0 do
    begin
      IF f.Attr = faDirectory	 then
      Begin
        if DelFolders.indexof(Folder+f.name) = -1 then
          DelFolders.Add(Folder+f.name);
      End
      Else
      Begin
        if Delfilelist.indexof(Folder+f.name) = -1 then
          Delfilelist.Add(Folder+f.name);
      End;
      I := findnext(f);
    end;
    Findclose(f);
  except
  end;
end;

Var
  noverinname : String;
  F : TSearchRec;
  R,aktmaster,I,V : longint;
  aktfile,fltmpfilename,fltdsnfilename : String;
  T,Dnsfilname,Colorfilename,filename,Webfilename,folder,webfoldername,WebColorfilename,Colorfolder,webColorfoldername : string;
  VWebfilename,Vwebfoldername,VWebColorfilename,VwebColorfoldername : string;
   Maskfilename : String;
   thisMasterCopySeparationSet, thisVersion, thisLocationID : Longint;
   thisColor, thisFileName : string;
   thisPublicationID : Longint;
   thisPubDate : TDateTime;
   PreviewGUID : String;
Begin
  try
    DelfileLogOK.clear;
    DelfileLogERROR.clear;
    Delfilelist.clear;
    DelFolders.clear;
    aktmaster := -1;
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.add('Select distinct p1.mastercopyseparationset,p1.locationid,p1.version,C.ColorName,p1.publicationID,p1.pubdate from pagetable p1 WITH (NOLOCK), colornames c WITH (NOLOCK) ');
    DataM1.Query1.SQL.add('where (P1.publicationid = '+inttostr(publicationid));
    DataM1.Query1.SQL.add('and '+  DataM1.makedatastr('P1.',pubdate));
    DataM1.Query1.SQL.add('and p1.inputtime > :inputtime');
    DataM1.Query1.SQL.add('and p1.colorid = c.colorid');
    DataM1.Query1.SQL.add('and p1.mastercopyseparationset = p1.copyseparationset)');
    IF ComboBoxSectionFilter.text <> 'All' then
      DataM1.Query1.SQL.add('and p1.Sectionid = '+ inttostr(tnames1.sectionnametoid(ComboBoxSectionFilter.text)));
    IF ComboBoxdellocation.text <> 'All' then
    begin
      DataM1.Query1.SQL.Add('and p1.locationid = '+inttostr(tnames1.locationnametoid(ComboBoxdellocation.Text)));
      DataM1.Query1.SQL.Add('and not exists(select p2.mastercopyseparationset from pagetable p2');
      DataM1.Query1.SQL.Add('where p2.locationid <> '+inttostr(tnames1.locationnametoid(ComboBoxdellocation.Text)));
      DataM1.Query1.SQL.Add('and p1.mastercopyseparationset = p2.mastercopyseparationset)');
    end;
    IF CheckBoxpresssep.Checked then
    Begin
      DataM1.Query1.SQL.Add('and not exists(select p3.mastercopyseparationset from pagetable p3');
      DataM1.Query1.SQL.Add('where p3.pressid <> '+inttostr(delpressid));
      DataM1.Query1.SQL.Add('and p1.mastercopyseparationset = p3.mastercopyseparationset)');
    End;

    DataM1.Query1.SQL.Add('order by p1.mastercopyseparationset');
    DataM1.Query1.ParamByName('inputtime').AsDateTime := encodedatetime(1990,1,1,1,1,1,1);
    IF Prefs.debug then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'deletemasterlist.sql');
    DataM1.Query1.open;
    While not DataM1.Query1.eof Do
    begin
      aktmaster := DataM1.Query1.fields[0].Asinteger;

      thisVersion := DataM1.Query1.fields[2].Asinteger;
      thisColor := DataM1.Query1.fields[3].AsString;
      // ## NAN
      thisPublicationID := DataM1.Query1.fields[4].AsInteger;
      thisPubDate := DataM1.Query1.fields[5].AsDateTime;
      PreviewGUID := inittypes.GeneratePreviewGUID(thisPublicationID, thisPubDate);
      filename := IntToStr(aktmaster) + '.jpg';
      folder   := IntToStr(aktmaster);
      webfoldername := folder;
      Webfilename   := filename;
      Vwebfoldername := folder+'-'+IntToStr(thisVersion);
      VWebfilename := IntToStr(aktmaster) +'-'+IntToStr(thisVersion) +'.jpg';
      colorfilename := IntToStr(aktmaster)+ '_'+thisColor+'.jpg';
      WebColorfilename := Colorfilename;
      VWebColorfilename := IntToStr(aktmaster) + '_'+thisColor +'-'+IntToStr(thisVersion) +'.jpg';
      Colorfolder := folder + '_'+thisColor;
      Dnsfilname  := folder + '_dns.jpg';
      Maskfilename  := folder + '_mask.jpg';
      webColorfoldername := IntToStr(aktmaster) + '_'+thisColor;
      VwebColorfoldername := IntToStr(aktmaster) + '_'+thisColor+'-'+IntToStr(thisVersion);

      For i := 1 to NFileserverpaths do
      begin
        IF (Fileserverpaths[i].Locationid = -1 ) or (Fileserverpaths[i].Locationid = DataM1.Query1.fields[1].Asinteger) then
        begin
          IF Fileserverpaths[i].CCpreviews <> '' then
          Begin
            IF Delfilelist.IndexOf(Fileserverpaths[i].CCpreviews+filename) < 0 then
              Delfilelist.Add(Fileserverpaths[i].CCpreviews+filename);
            IF Delfilelist.IndexOf(Fileserverpaths[i].CCpreviews+PreviewGUID + '===='+filename) < 0 then
              Delfilelist.Add(Fileserverpaths[i].CCpreviews+PreviewGUID + '====' + filename);
            IF DelFolders.indexof(Fileserverpaths[i].CCpreviews+folder) < 0 then
              DelFolders.Add(Fileserverpaths[i].CCpreviews+folder);
            IF DelFolders.indexof(Fileserverpaths[i].CCpreviews+PreviewGUID + '===='+folder) < 0 then
              DelFolders.Add(Fileserverpaths[i].CCpreviews+PreviewGUID + '===='+folder);
            Delfilelist.Add(Fileserverpaths[i].CCpreviews+Colorfilename);
            Delfilelist.Add(Fileserverpaths[i].CCpreviews+PreviewGUID + '===='+Colorfilename);
            Delfilelist.Add(Fileserverpaths[i].CCpreviews+Dnsfilname);
            Delfilelist.Add(Fileserverpaths[i].CCpreviews+PreviewGUID + '===='+Dnsfilname);
            Delfilelist.Add(Fileserverpaths[i].CCpreviews+Maskfilename);
            Delfilelist.Add(Fileserverpaths[i].CCpreviews+PreviewGUID + '===='+Maskfilename);
            DelFolders.Add(Fileserverpaths[i].CCpreviews+Colorfolder);
            DelFolders.Add(Fileserverpaths[i].CCpreviews+PreviewGUID + '===='+Colorfolder);
          End;
          IF Fileserverpaths[i].CCthumbnails <> '' then
          Begin
            if Delfilelist.indexof(Fileserverpaths[i].CCthumbnails +filename) < 0 then
              Delfilelist.Add(Fileserverpaths[i].CCthumbnails +filename);
              if Delfilelist.indexof(Fileserverpaths[i].CCthumbnails +PreviewGUID + '===='+filename) < 0 then
                Delfilelist.Add(Fileserverpaths[i].CCthumbnails+PreviewGUID + '====' +filename);
          end;
          IF Fileserverpaths[i].CCreadviewpreviews <> '' then
          Begin
            LookforRview(Fileserverpaths[i].CCreadviewpreviews,
                         DataM1.Query1.fields[0].AsString);
          End;
          IF Fileserverpaths[i].CCPDFfiles <> '' then
          Begin
            findnameswithstar(Fileserverpaths[i].CCPDFfiles,'*_'+inttostr(aktmaster)+'.*');
          End;
          IF Fileserverpaths[i].CCPDFlogs <> '' then
          Begin
            findnameswithstar(Fileserverpaths[i].CCPDFlogs,'*_'+inttostr(aktmaster)+'.*');
          End;
          //WEB
          IF Fileserverpaths[i].CCWebthumbnails <> '' then
          Begin
            Delfilelist.Add(Fileserverpaths[i].CCWebthumbnails +Webfilename);
            Delfilelist.Add(Fileserverpaths[i].CCWebthumbnails+PreviewGUID + '====' +Webfilename);
            Delfilelist.Add(Fileserverpaths[i].CCWebthumbnails +VWebfilename);
            Delfilelist.Add(Fileserverpaths[i].CCWebthumbnails+PreviewGUID + '====' +VWebfilename);
          End;
          IF Fileserverpaths[i].CCWEBpreviews <> '' then
          Begin
            Delfilelist.Add(Fileserverpaths[i].CCWEBpreviews +Webfilename);
            Delfilelist.Add(Fileserverpaths[i].CCWEBpreviews +PreviewGUID + '===='+Webfilename);
            Delfilelist.Add(Fileserverpaths[i].CCWEBpreviews +VWebfilename);
            Delfilelist.Add(Fileserverpaths[i].CCWEBpreviews +PreviewGUID + '===='+VWebfilename);
            Delfilelist.Add(Fileserverpaths[i].CCWEBpreviews +Dnsfilname);
            Delfilelist.Add(Fileserverpaths[i].CCWEBpreviews +PreviewGUID + '===='+Dnsfilname);
            Delfilelist.Add(Fileserverpaths[i].CCWEBpreviews +Maskfilename);
            Delfilelist.Add(Fileserverpaths[i].CCWEBpreviews +PreviewGUID + '===='+Maskfilename);
            Delfilelist.Add(Fileserverpaths[i].CCWEBpreviews +WebColorfilename);
            Delfilelist.Add(Fileserverpaths[i].CCWEBpreviews +PreviewGUID + '===='+WebColorfilename);
            Delfilelist.Add(Fileserverpaths[i].CCWEBpreviews +VWebColorfilename);
            Delfilelist.Add(Fileserverpaths[i].CCWEBpreviews +PreviewGUID + '===='+VWebColorfilename);
            DelFolders.Add(Fileserverpaths[i].CCWebpreviews+webfoldername);
            DelFolders.Add(Fileserverpaths[i].CCWebpreviews +PreviewGUID + '===='+webfoldername);
            DelFolders.Add(Fileserverpaths[i].CCWebpreviews+Vwebfoldername);
            DelFolders.Add(Fileserverpaths[i].CCWebpreviews+PreviewGUID + '===='+Vwebfoldername);
            DelFolders.Add(Fileserverpaths[i].CCWebpreviews+webColorfoldername);
            DelFolders.Add(Fileserverpaths[i].CCWebpreviews+PreviewGUID + '===='+webColorfoldername);
            DelFolders.Add(Fileserverpaths[i].CCWebpreviews+VwebColorfoldername);
            DelFolders.Add(Fileserverpaths[i].CCWebpreviews+PreviewGUID + '===='+VwebColorfoldername);
          End;

          IF Fileserverpaths[i].CCWEBreadviewpreviews <> '' then
          Begin
            LookforRview(Fileserverpaths[i].CCWEBreadviewpreviews,
                         DataM1.Query1.fields[0].AsString);
          End;

        End;
      end;
      DataM1.Query1.next;
    end;
    DataM1.Query1.close;
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.add('Select distinct p1.mastercopyseparationset,c1.ColorName,p1.version,p1.locationid,p1.FileName from pagetable p1 (NOLOCK), ColorNames c1 (NOLOCK)');
    DataM1.Query1.SQL.add('where (P1.publicationid = '+inttostr(publicationid));
    DataM1.Query1.SQL.add('and '+  DataM1.makedatastr('P1.',pubdate));
    DataM1.Query1.SQL.add('and p1.colorid = c1.colorid');
    DataM1.Query1.SQL.add('and p1.inputtime > :inputtime');
    DataM1.Query1.SQL.add('and p1.mastercopyseparationset = p1.copyseparationset)');
    IF ComboBoxSectionFilter.text <> 'All' then
      DataM1.Query1.SQL.add('and p1.Sectionid = '+ inttostr(tnames1.sectionnametoid(ComboBoxSectionFilter.text)));
    IF ComboBoxdellocation.text <> 'All' then
    begin
      DataM1.Query1.SQL.Add('and p1.locationid = '+inttostr(tnames1.locationnametoid(ComboBoxdellocation.Text)));
      DataM1.Query1.SQL.Add('and not exists(select p2.mastercopyseparationset from pagetable p2 WITH (NOLOCK)');
      DataM1.Query1.SQL.Add('where p2.locationid <> '+inttostr(tnames1.locationnametoid(ComboBoxdellocation.Text)));
      DataM1.Query1.SQL.Add('and p1.mastercopyseparationset = p2.mastercopyseparationset)');
    end;
    IF CheckBoxpresssep.Checked then
    Begin
      DataM1.Query1.SQL.Add('and not exists(select p3.mastercopyseparationset from pagetable p3 WITH (NOLOCK)');
      DataM1.Query1.SQL.Add('where p3.pressid <> '+inttostr(delpressid));
      DataM1.Query1.SQL.Add('and p1.mastercopyseparationset = p3.mastercopyseparationset)');
    End;
    DataM1.Query1.ParamByName('inputtime').AsDateTime := encodedatetime(1990,1,1,1,1,1,1);
    DataM1.Query1.open;
    While not DataM1.Query1.eof Do
    begin
      thisMasterCopySeparationSet := DataM1.Query1.fields[0].Asinteger;
      thisColor :=  DataM1.Query1.fields[1].AsString;
      thisVersion := DataM1.Query1.fields[2].Asinteger;
      thisLocationID := DataM1.Query1.fields[3].Asinteger;
      thisFileName :=  DataM1.Query1.fields[4].AsString;
      //CCfiles p� server
      For i := 1 to NFileserverpaths do
      begin
        IF (Fileserverpaths[i].Locationid = -1 ) or (Fileserverpaths[i].Locationid = thisLocationID) then
        begin
          IF Fileserverpaths[i].CCfiles <> '' then
          Begin
            Delfilelist.Add(Fileserverpaths[i].CCfiles+ thisFileName + '====' +inttostr(thisMasterCopySeparationSet) + '.' + thisColor);
            Delfilelist.Add(Fileserverpaths[i].CCfiles+inttostr(thisMasterCopySeparationSet) + '.' + thisColor);
          End;
          IF Fileserverpaths[i].CCVersions <> '' then
          begin
            for v := 0 to thisVersion-1 do
            begin
              Delfilelist.Add(Fileserverpaths[i].CCVersions + inttostr(V) + '-'+thisFileName + '====' +inttostr(thisMasterCopySeparationSet) + '.' + thisColor);
              Delfilelist.Add(Fileserverpaths[i].CCVersions + inttostr(V) + '-'+inttostr(thisMasterCopySeparationSet) + '.' + thisColor);
            End;
          end;
        End;
      end;
      DataM1.Query1.next;
    end;
    DataM1.Query1.close;
    IF NInkFolders > 0 then
    begin
      DataM1.Query1.SQL.Clear;      //               0                  1            2         3                  4
      DataM1.Query1.SQL.add('Select distinct p1.FlatSeparationSet,p1.locationid,p1.version,C.ColorName,p1.flatseparation,p1.FileName from pagetable p1 WITH (NOLOCK), colornames c WITH (NOLOCK)');
      DataM1.Query1.SQL.add('where P1.publicationid = '+inttostr(publicationid));
      DataM1.Query1.SQL.add('and '+  DataM1.makedatastr('P1.',pubdate));
      DataM1.Query1.SQL.add('and p1.inputtime > :inputtime');
      DataM1.Query1.SQL.add('and p1.status > 30');
      DataM1.Query1.SQL.add('and p1.colorid = c.colorid');
      IF ComboBoxSectionFilter.text <> 'All' then
        DataM1.Query1.SQL.add('and p1.Sectionid = '+ inttostr(tnames1.sectionnametoid(ComboBoxSectionFilter.text)));
      IF ComboBoxdellocation.text <> 'All' then
      begin
        DataM1.Query1.SQL.Add('and p1.locationid = '+inttostr(tnames1.locationnametoid(ComboBoxdellocation.Text)));
      end;
      DataM1.Query1.SQL.Add('order by p1.FlatSeparationSet');
      IF Prefs.debug then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'deplanfilelist.sql');
      DataM1.Query1.ParamByName('inputtime').AsDateTime := encodedatetime(1990,1,1,1,1,1,1);
      DataM1.Query1.open;
      While not DataM1.Query1.eof Do
      begin
        For i := 1 to NInkFolders do
        begin
          filename := DataM1.Query1.fields[0].AsString + '.jpg';
          colorfilename := DataM1.Query1.fields[0].AsString + '_'+DataM1.Query1.fields[3].AsString+'.jpg';
          fltmpfilename := DataM1.Query1.fields[4].AsString+'.tif';
          fltdsnfilename := DataM1.Query1.fields[0].AsString + '_dsn.jpg';
          IF (InkFolders[i].Locationid = -1 ) or (InkFolders[i].Locationid = DataM1.Query1.fields[1].Asinteger) then
          begin
            IF InkFolders[i].InkShare <> '' then
            Begin
              T := includetrailingbackslash(InkFolders[i].InkShare)+'CCinkflatpreviews\' + fltdsnfilename;
              if Delfilelist.indexof(T) < 0 then
                Delfilelist.Add(T);
              T := includetrailingbackslash(InkFolders[i].InkShare)+'CCinkflatthumbnails\' + filename;
              if Delfilelist.indexof(T) < 0 then
                Delfilelist.Add(T);
              T := includetrailingbackslash(InkFolders[i].InkShare)+'CCinkflatpreviews\' + filename;
              if Delfilelist.indexof(T) < 0 then
                Delfilelist.Add(T);
              T := includetrailingbackslash(InkFolders[i].InkShare)+'CCinkflatpreviews\' + colorfilename;
              if Delfilelist.indexof(T) < 0 then
                Delfilelist.Add(T);
              T := includetrailingbackslash(InkFolders[i].InkShare)+'CCinktempflats\' + fltmpfilename;
              if Delfilelist.indexof(T) < 0 then
                Delfilelist.Add(T);
              T := includetrailingbackslash(InkFolders[i].InkShare)+'CCinkzonepreviews\' + colorfilename;
              if Delfilelist.indexof(T) < 0 then
                Delfilelist.Add(T);
              T := includetrailingbackslash(InkFolders[i].InkShare)+'CCinkoriginals\*-'+DataM1.Query1.fields[4].asstring+'.*';
              R := findfirst(T,faAnyFile,F);
              While r = 0 do
              begin
                T := includetrailingbackslash(InkFolders[i].InkShare)+'CCinkoriginals\'+f.name;
                if Delfilelist.indexof(T) < 0 then
                  Delfilelist.Add(T);
                T := T +'.txt';
                if Delfilelist.indexof(T) < 0 then
                  Delfilelist.Add(T);
                R := findnext(f);
              End;
              Findclose(F);
            end;
          End;
        End;
        DataM1.Query1.next;
      End;
      DataM1.Query1.Close;
    End;
    Delfilelist.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'Delfilelist.txt');
    DelFolders.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'DelFolders.txt');
  Except
  end;
end;
procedure TFormdelpublication.BitBtn1Click(Sender: TObject);
Begin
  if ListView1.Selected = nil then exit;
  if MessageDlg(formmain.InfraLanguage1.Translate('Are you sure you want to delete the selected production(s) ?'),
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    Dodelete;
  End;
end;
procedure TFormdelpublication.Dodelete;
Var
  T : String;
  prodname : String;
  Iitem,publid : Longint;
  pubdate : tdatetime;
  productionid : Longint;
  resulttat : integer;
  pressid,i,locationid,statid,mrres,pressSelid : Longint;
begin
  try
    ProgressBarrep.Max :=0;
    ProgressBarrep.Position := 0;
    ProgressBardel.Max :=0;
    ProgressBardel.Position := 0;
    For Iitem := 0 to ListView1.items.Count-1 do
    begin
      IF ListView1.Items[Iitem].Selected then
      Begin
        ProgressBarrep.Max :=ProgressBarrep.Max +1;
        ProgressBardel.Max :=ProgressBardel.Max +1;
      End;
    End;
    ProgressBarrep.Max :=ProgressBarrep.Max +1;
    ProgressBardel.Max :=ProgressBardel.Max +1;

    preparefileserverpaths;
    IF formmain.Setplanlock(true) then
    begin
      IF (CheckBoxgenrep.checked) then
      begin
        Panelgenrep.visible := true;
        Panelgenrep.repaint;
        For Iitem := 0 to ListView1.items.Count-1 do
        begin
          IF ListView1.Items[Iitem].Selected then
          Begin
            ProgressBarrep.Position := ProgressBarrep.Position+1;
            ProgressBarrep.repaint;
            productionid := -1;
            publid  := publlist[Iitem].publid;
            pubdate := publlist[Iitem].pubdate;
            pressSelid := publlist[Iitem].pressid;
            Labelaktrep.caption := tnames1.publicationIDtoname(publid) + '   ' + datetostr(pubdate);
            Labelaktrep.Repaint;
            Application.ProcessMessages;
            DataM1.Query1.SQL.Clear;
            DataM1.Query1.SQL.add('Select distinct productionid from pagetable WITH (NOLOCK)');
            DataM1.Query1.SQL.add('where publicationid = '+inttostr(publid));
            IF CheckBoxpresssep.checked then
              DataM1.Query1.SQL.add('and pressid = '+ inttostr(pressSelid));
            IF ComboBoxSectionFilter.text <> 'All' then
              DataM1.Query1.SQL.add('and Sectionid = '+ inttostr(tnames1.sectionnametoid(ComboBoxSectionFilter.text)));
            DataM1.Query1.SQL.add('and '+  DataM1.makedatastr('pagetable.',pubdate));
            DataM1.Query1.open;
            IF not DataM1.Query1.eof then
            begin
              productionid := DataM1.Query1.fields[0].asinteger;
            end;
            DataM1.Query1.Close;
            IF (CheckBoxgenrep.checked) then
            Begin
              resulttat := FormReportgenrutines.GenerateProductionReportONDel(productionid);
              //resulttat := DLLGenerateReport(productionid);
            End;

          End;
        end;
        While ProgressBarrep.Position < ProgressBarrep.max do
        begin
          Sleep(2000);
          ProgressBarrep.Position := ProgressBarrep.Position+1;
          ProgressBarrep.repaint;
          Application.ProcessMessages;
        end;
        ProgressBarrep.Position := ProgressBarrep.max;
        ProgressBarrep.repaint;
        Application.ProcessMessages;
        Sleep(2000);
      End;

      Panelgenrep.visible := false;
      Paneldelpubl.visible := true;
      Labelakt.caption := '';
      Paneldelpubl.Repaint;
      Formdelpublication.repaint;
      Application.ProcessMessages;
      For Iitem := 0 to ListView1.items.Count-1 do
      begin
        IF ListView1.Items[Iitem].Selected then
        Begin
          ProgressBardel.Position := ProgressBardel.Position+1;
          ProgressBardel.repaint;
          ProgressBarfiles.position := 0;
          ProgressBarfiles.repaint;
          productionid := -1;
          publid  := publlist[Iitem].publid;
          pubdate := publlist[Iitem].pubdate;
          pressSelid := publlist[Iitem].pressid;
          Labelakt.caption := tnames1.publicationIDtoname(publid) + '   ' + datetostr(pubdate);
          Labelakt.Repaint;
          Application.ProcessMessages;
          DataM1.Query1.SQL.Clear;
          DataM1.Query1.SQL.add('Select distinct productionid from pagetable WITH (NOLOCK)');
          DataM1.Query1.SQL.add('where publicationid = '+inttostr(publid));
          IF CheckBoxpresssep.checked then
            DataM1.Query1.SQL.add('and pressid = '+ inttostr(pressSelid));
          IF ComboBoxSectionFilter.text <> 'All' then
            DataM1.Query1.SQL.add('and Sectionid = '+ inttostr(tnames1.sectionnametoid(ComboBoxSectionFilter.text)));

          DataM1.Query1.SQL.add('and '+  DataM1.makedatastr('pagetable.',pubdate));
          DataM1.Query1.open;
          IF not DataM1.Query1.eof then
          begin
            productionid := DataM1.Query1.fields[0].asinteger;
          end;
          DataM1.Query1.Close;
          IF Prefs.CustomXMLReportOutputFolder <> '' then
          Begin
            DataM1.Query1.SQL.Clear;
            DataM1.Query1.SQL.add('Select distinct LocationId,PressID from pagetable WITH (NOLOCK)');
            DataM1.Query1.SQL.add('where productionid = '+inttostr(productionid));
            IF CheckBoxpresssep.checked then
              DataM1.Query1.SQL.add('and pressid = '+ inttostr(pressSelid));
            IF ComboBoxSectionFilter.text <> 'All' then
              DataM1.Query1.SQL.add('and Sectionid = '+ inttostr(tnames1.sectionnametoid(ComboBoxSectionFilter.text)));

            DataM1.Query1.open;
            IF not DataM1.Query1.eof then
            begin
              pressid := DataM1.Query1.fields[1].asinteger;
              Locationid := DataM1.Query1.fields[0].asinteger;
            end;
            DataM1.Query1.close;
            IF Prefs.CustomXMLReportOutputFolder <> '' then
              FormExportcustomplan.Makecustomxmlexport(Prefs.CustomXMLReportOutputFolder, IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'CustomDelcommandExport.xml','01_P_DEL_',
                                                       LocationId,PressId,ProductionId,publid,Pubdate);
          end;
          AddfilesTodel(publlist[Iitem].publid,publlist[Iitem].pubdate,publlist[Iitem].pressid);
          IF nodeldebug then
          begin
            Delfilelist.clear;
            DelFolders.clear;
            formmain.Setplanlock(false);
            exit;
          End;
          IF Delfilelist.Count > 0 then
          begin
            repeat
              Deletethefiles;
              IF Folderproblems.Count > 0 then
              begin
                T := 'Some files could not be deleted. Please check user rights in the :';
                For i := 0 to Folderproblems.Count-1 do
                  T := t+ #13+Folderproblems[i];
                mrres := MessageDlg(T, mtError,[mbRetry	,mbIgnore], 0);
              end;
            Until (mrres = mrIgnore) or (Folderproblems.Count=0);
          End;

          DataM1.Query1.SQL.Clear;
          DataM1.Query1.SQL.add('delete pagetable');
          DataM1.Query1.SQL.add('where pagetable.publicationid = '+inttostr(publid));
          DataM1.Query1.SQL.add('and '+  DataM1.makedatastr('pagetable.',pubdate));
          IF ComboBoxdellocation.text <> 'All' then
          begin
            DataM1.Query1.SQL.Add('and locationid = '+inttostr(tnames1.locationnametoid(ComboBoxdellocation.Text)));
          end;
          IF ComboBoxSectionFilter.text <> 'All' then
            DataM1.Query1.SQL.add('and Sectionid = '+ inttostr(tnames1.sectionnametoid(ComboBoxSectionFilter.text)));
          IF CheckBoxpresssep.checked then
            DataM1.Query1.SQL.add('and pressid = '+ inttostr(pressSelid));

          formmain.trysql(DataM1.Query1);
          prodName := tnames1.publicationIDtoname(publid) + '-' + datetostr(pubdate) + '  ' + tNames1.pressnameIDtoname(pressSelid);
          FormMain.SaveEventlog(999,0,0,'Plan deleted',prodname,1,productionid);
        End;
      End;
      Labelakt.caption := 'Deleting files';
      Labelakt.Repaint;
      Formdelpublication.repaint;
      application.ProcessMessages;
      formmain.Setplanlock(false);
      cleanupproductionnames;
      IF (Prefs.PlanningExportXMLPlan) then
      begin
        DataM1.Query1.SQL.Clear;
        DataM1.Query1.SQL.add('delete planexportjobs where not exists (select p2.productionid from ProductionNames p2 where planexportjobs.productionid = p2.productionid)');
        formmain.trysql(DataM1.Query1);
      End;
      Paneldelpubl.visible := false;
      formmain.cleanupfilesonserver;
      loadlist;
    End;
  finally
    Delfilelist.clear;
    DelFolders.clear;
    formmain.Setplanlock(false);
  end;
end;
procedure TFormdelpublication.loadlist;
Var
  l : tlistitem;
Begin
  try
    ListView1.Items.clear;
    DataM1.Query1.SQL.Clear;
    if (Prefs.TreeExtraPublicationText[0]) then
    begin
      IF ComboBoxdellocation.text <> 'All' then
        DataM1.Query1.SQL.Add('Select distinct p1.pubdate,p1.publicationid,p2.publicationid,p2.name,p1.productionid,p1.miscint2,p1.pressid from pagetable p1 (NOLOCK), PublicationNames p2 (NOLOCK)')
      else
        DataM1.Query1.SQL.Add('Select distinct p1.pubdate,p1.publicationid,p2.publicationid,p2.name,p1.miscint2,p1.pressid from pagetable p1 (NOLOCK), PublicationNames p2 (NOLOCK)');
    End
    Else
    begin
      IF ComboBoxdellocation.text <> 'All' then
        DataM1.Query1.SQL.Add('Select distinct p1.pubdate,p1.publicationid,p2.publicationid,p2.name,p1.productionid,p1.pressid from pagetable p1 (NOLOCK), PublicationNames p2 (NOLOCK)')
      else
        DataM1.Query1.SQL.Add('Select distinct p1.pubdate,p1.publicationid,p2.publicationid,p2.name,p1.pressid from pagetable p1 (NOLOCK), PublicationNames p2 (NOLOCK)');
    end;

    DataM1.Query1.SQL.Add('where p1.publicationid = p2.publicationid');
    IF ComboBoxSectionFilter.text <> 'All' then
      DataM1.Query1.SQL.add('and p1.Sectionid = '+ inttostr(tnames1.sectionnametoid(ComboBoxSectionFilter.text)));

    IF ComboBoxdellocation.text <> 'All' then
    begin
      DataM1.Query1.SQL.Add('and p1.locationid = '+inttostr(tnames1.locationnametoid(ComboBoxdellocation.Text)));
      DataM1.Query1.SQL.Add('and not exists(select p3.productionid from pagetable p3');
      DataM1.Query1.SQL.Add('where p1.mastercopyseparationset = p3.mastercopyseparationset');
      DataM1.Query1.SQL.Add('and p3.locationid <> p1.locationid)');
    end;

    if Pressvisibilylimited then
      datam1.Query1.SQL.Add('and p1.pressid IN ' + PressvisibilyIN);
    if ComboBoxPagefilerday.Itemindex > 0 then
    begin
      datam1.Query1.SQL.Add(' and ' + DataM1.makedatastr('p1.',strtodate(ComboBoxPagefilerday.text) ));
    end;

    DataM1.Query1.SQL.Add('order by p1.pubdate,p2.name');
    formmain.Tryopen(DataM1.Query1);
    While not DataM1.Query1.eof do
    begin
      l := ListView1.Items.Add;
      l.Caption := datetostr(DataM1.Query1.fields[0].asdatetime);
      if (Prefs.TreeExtraPublicationText[0]) then
      Begin
        if DataM1.Query1.fieldbyname('miscint2').asinteger > 0 then
          l.SubItems.Add(DataM1.Query1.fields[3].asstring+ '  ' + DataM1.Query1.fieldbyname('miscint2').asstring)
        else
          l.SubItems.Add(DataM1.Query1.fields[3].asstring);
      end
      else
        l.SubItems.Add(DataM1.Query1.fields[3].asstring);
      l.SubItems.Add(tnames1.pressnameIDtoname(DataM1.Query1.fieldbyname('pressid').asinteger));
      publlist[ListView1.Items.count-1].publid := DataM1.Query1.fields[1].asinteger;
      publlist[ListView1.Items.count-1].pubdate := DataM1.Query1.fields[0].asdatetime;
      publlist[ListView1.Items.count-1].pressid := DataM1.Query1.fieldbyname('pressid').asinteger;
      DataM1.Query1.Next;
    end;
    DataM1.Query1.close;
    (*
    if ListView1.Items.count > 0 then
    Begin
      ListView1.Selected := ListView1.Items[0];
      ListView1.SetFocus;
    end;
    *)
    ListView1.SetFocus;
    BitBtn1.Enabled := ListView1.Selected <> nil;
  Except
  end;
end;
procedure TFormdelpublication.FormActivate(Sender: TObject);
Var
  I : Longint;
begin
  try
    setthedays;
    ComboBoxPagefilerday.ItemIndex := 0;
    CheckBoxDelfiles.checked := true;
    if not Prefs.AllowOnlyDefaultLocationPress then
    Begin
      ComboBoxdellocation.Items.Clear;
      ComboBoxdellocation.Items := tnames1.locationnames;
      ComboBoxdellocation.Items.Insert(0,'All');
      ComboBoxdellocation.ItemIndex := 0;
    end
    else
    begin
      ComboBoxdellocation.Items.Clear;
      ComboBoxdellocation.Items.Add(Prefs.DefaultLocation);
      ComboBoxdellocation.Itemindex := 0;
    end;
    ComboBoxSectionFilter.Items.Clear;
    ComboBoxSectionFilter.Items := tnames1.Sectionnames;
    ComboBoxSectionFilter.Items.Insert(0,'All');
    ComboBoxSectionFilter.ItemIndex := 0;
    preparefileserverpaths;
    GroupBox1.visible := Prefs.ArchiveEnabled;
    GroupBox1.visible := false;
    CheckBoxAhighres.Checked := Prefs.DefaultArchiveHighres;
    CheckBoxAlowres.Checked := Prefs.DefaultArchiveLowres;
    if not Prefs.ArchiveEnabled then
    begin
      CheckBoxAhighres.Checked := false;
      CheckBoxAlowres.Checked := false;
    end;
    loadlist;
    Memo1.lines.clear;
    For i := 1 to NFileserverpaths do
    begin
      Memo1.lines.add(Fileserverpaths[i].Fileservername + ':');
      Memo1.lines.add('CCfiles:                ' +Fileserverpaths[i].CCfiles);
      Memo1.lines.add('CCpreviews:             ' +Fileserverpaths[i].CCpreviews);
      Memo1.lines.add('CCthumbnails:           ' +Fileserverpaths[i].CCthumbnails);
      Memo1.lines.add('CCreadviewpreviews:     ' +Fileserverpaths[i].CCreadviewpreviews);
      Memo1.lines.add('CCVersions:             ' +Fileserverpaths[i].CCVersions);
      Memo1.lines.add('CCWEBpreviews:          ' +Fileserverpaths[i].CCWEBpreviews);
      Memo1.lines.add('CCWEBthumbnails:        ' +Fileserverpaths[i].CCWEBthumbnails);
      Memo1.lines.add('CCWEBreadviewpreviews:  ' +Fileserverpaths[i].CCWEBreadviewpreviews);
      Memo1.lines.add('CCPDFfiles:             ' +Fileserverpaths[i].CCPDFfiles);
      Memo1.lines.add('CCPDFlogs:              ' +Fileserverpaths[i].CCPdflogs);
    End;
    PageControl1.ActivePageIndex := 0;
    CheckBoxgenrep.checked := Prefs.GenerateReportWhenDeleting;

  Except
  end;
end;
procedure TFormdelpublication.ComboBoxdellocationChange(Sender: TObject);
begin
  loadlist;
end;
procedure TFormdelpublication.ListView1SelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  BitBtn1.Enabled := ListView1.Selected <> nil;
end;
Procedure TFormdelpublication.cleanupproductionnames;
Begin
  try
    DataM1.Query1.sql.clear;
   // DataM1.Query1.sql.add('set lock_timeout 20000');
    DataM1.Query1.sql.add('delete productionnames');
    DataM1.Query1.sql.add('where not exists (');
    DataM1.Query1.sql.add('select productionid from pagetable (NOLOCK)');
    DataM1.Query1.sql.add('where productionnames.productionid = pagetable.productionid)');
    DataM1.Query1.ExecSQL;
    DataM1.Query1.sql.clear;
   // DataM1.Query1.sql.add('set lock_timeout 20000');
    DataM1.Query1.sql.add('delete log ');
    datam1.Query1.SQL.Add('Where event<800 and not exists(Select separation from pagetable (NOLOCK)');
    DataM1.Query1.sql.add('where pagetable.separation = log.separation)');
    DataM1.Query1.ExecSQL;
    DataM1.Query1.sql.clear;
   // DataM1.Query1.sql.add('set lock_timeout 20000');
    DataM1.Query1.sql.add('delete pressrunid where');
    DataM1.Query1.sql.add('not exists(Select pressrunid from pagetable (NOLOCK)');
    DataM1.Query1.sql.add('where pagetable.pressrunid = pressrunid.pressrunid)');
    DataM1.Query1.ExecSQL;
    DataM1.Query1.sql.clear;
    DataM1.Query1.sql.add('set lock_timeout 20000');
    DataM1.Query1.sql.add('delete PrepollPageTable where');
    DataM1.Query1.sql.add('not exists(Select mastercopyseparationset from pagetable (NOLOCK)');
    DataM1.Query1.sql.add('where pagetable.mastercopyseparationset = PrepollPageTable.mastercopyseparationset)');
    DataM1.Query1.ExecSQL;
    IF FlatPageTablePossible then
    begin
      DataM1.Query1.sql.clear;
     // DataM1.Query1.sql.add('set lock_timeout 20000');
      DataM1.Query1.sql.add('delete flatpagetable where');
      DataM1.Query1.sql.add('not exists(Select flatseparation from pagetable (NOLOCK)');
      DataM1.Query1.sql.add('where pagetable.flatseparation = flatpagetable.flatseparation)');
      DataM1.Query1.ExecSQL;
    End;
  Except
  end;
end;
Procedure TFormdelpublication.preparefileserverpaths;
Var
  i, ServerType : Integer;
  CCRoot,aktfileservername, IP,CCShare : string;
  PlanCenterUserIndex,LocationID : Integer;
Begin
  PlanCenterUserIndex := -1;
  NFileserverpaths := 0;
  try
    DataM1.Query1.sql.clear;
    DataM1.Query1.sql.add('Select Name,Servertype,CCdatashare,Username,password,IP,LocationID,InUse from Fileservers');
    DataM1.Query1.sql.add('order by Servertype ');
    DataM1.Query1.open;
    While not DataM1.Query1.eof do
    begin
      ServerType :=  DataM1.Query1.fields[1].AsInteger;
      aktfileservername := uppercase(DataM1.Query1.fields[0].asstring);
      IP := DataM1.Query1.fields[5].asstring;
      CCShare :=  DataM1.Query1.fields[2].asstring;
      LocationID :=  DataM1.Query1.fields[6].AsInteger;
      IF IP <> '' then
      Begin
        CCRoot := '\\'+ IP  + '\'+ IncludeTrailingBackslash(CCShare);
      End
      else
      Begin
        IF POS(':',CCShare) > 0 then
          CCRoot :=  IncludeTrailingBackslash(CCShare)
        else
          CCRoot := '\\'+aktfileservername + '\'+ IncludeTrailingBackslash(CCShare);
      End;

      // mangler _dns og CCinkflatthumbnails
      IF (ServerType = FILESERVERTYPE_INKCENTER) then
      begin
        Inc(NFileserverpaths);
        Fileserverpaths[NFileserverpaths].ccroot := ccroot;
        Fileserverpaths[NFileserverpaths].Servertype := ServerType;
        Fileserverpaths[NFileserverpaths].Fileservername := aktfileservername;
        Fileserverpaths[NFileserverpaths].Locationid := LocationID;
        Fileserverpaths[NFileserverpaths].CCinkoriginals  := CCRoot + 'CCinkoriginals\';
        Fileserverpaths[NFileserverpaths].CCinkzonepreviews  := CCRoot + 'CCinkzonepreviews\';
        Fileserverpaths[NFileserverpaths].CCinkflatpreviews  := CCRoot + 'CCinkflatpreviews\';
        Fileserverpaths[NFileserverpaths].CCinkflatthumbnails  := CCRoot + 'CCinkflatthumbnails\';
        Fileserverpaths[NFileserverpaths].CCinktempflats  := CCRoot + 'CCinktempflats\';
        Fileserverpaths[NFileserverpaths].Username := DataM1.Query1.fields[3].AsString;
        Fileserverpaths[NFileserverpaths].password := TUtils.DecodeBlowfish(DataM1.Query1.fields[4].AsString);

      End
      //IF ServerType IN [1,2,5,7,11,12,13,14,15] then
      else
      begin
        Inc(NFileserverpaths);
        Fileserverpaths[NFileserverpaths].ccroot := ccroot;
        Fileserverpaths[NFileserverpaths].Username  := DataM1.Query1.fields[3].asstring;
        Fileserverpaths[NFileserverpaths].password  := DataM1.Query1.fields[4].asstring;
        Fileserverpaths[NFileserverpaths].CCfiles := '';
        Fileserverpaths[NFileserverpaths].CCpreviews := '';
        Fileserverpaths[NFileserverpaths].CCthumbnails := '';
        Fileserverpaths[NFileserverpaths].CCreadviewpreviews := '';
        Fileserverpaths[NFileserverpaths].CCVersions := '';
        Fileserverpaths[NFileserverpaths].CCWEBpreviews := '';
        Fileserverpaths[NFileserverpaths].CCWEBthumbnails := '';
        Fileserverpaths[NFileserverpaths].CCWEBreadviewpreviews := '';
        Fileserverpaths[NFileserverpaths].CCPDFfiles := '';
        Fileserverpaths[NFileserverpaths].CCPdflogs := '';
        Fileserverpaths[NFileserverpaths].Servertype  := ServerType;
        Fileserverpaths[NFileserverpaths].Fileservername  := aktfileservername;
        Fileserverpaths[NFileserverpaths].Locationid := LocationID;
        if (ServerType = Prefs.PlanCenterFileServerType) then
          PlanCenterUserIndex := NFileserverpaths;
        IF (ServerType = FILESERVERTYPE_MAIN) or (ServerType = FILESERVERTYPE_LOCAL) or (ServerType = Prefs.PlanCenterFileServerType) then
        Begin
          Fileserverpaths[NFileserverpaths].CCfiles          := CCRoot + 'CCfiles\';
          Fileserverpaths[NFileserverpaths].ccroot := ccroot;
          IF not directoryexists(Fileserverpaths[NFileserverpaths].CCfiles) then
            Fileserverpaths[NFileserverpaths].CCfiles := '';
          Fileserverpaths[NFileserverpaths].CCpreviews       := CCRoot + 'CCpreviews\';
          IF not directoryexists(Fileserverpaths[NFileserverpaths].CCpreviews) then
            Fileserverpaths[NFileserverpaths].CCpreviews := '';
          Fileserverpaths[NFileserverpaths].CCthumbnails        := CCRoot + 'CCthumbnails\';
          IF not directoryexists(Fileserverpaths[NFileserverpaths].CCthumbnails) then
            Fileserverpaths[NFileserverpaths].CCthumbnails        := '';
          Fileserverpaths[NFileserverpaths].CCreadviewpreviews  := CCRoot + 'CCreadviewpreviews\';
          IF not directoryexists(Fileserverpaths[NFileserverpaths].CCreadviewpreviews) then
            Fileserverpaths[NFileserverpaths].CCreadviewpreviews := '';
          Fileserverpaths[NFileserverpaths].CCVersions          := CCRoot + 'CCVersions\';
          IF not directoryexists(Fileserverpaths[NFileserverpaths].CCVersions) then
            Fileserverpaths[NFileserverpaths].CCVersions := '';
        End;
        IF ServerType = FILESERVERTYPE_WEBCENTER then
        Begin
          Fileserverpaths[NFileserverpaths].CCWEBpreviews       := CCRoot + 'CCpreviews\';
          Fileserverpaths[NFileserverpaths].CCWEBthumbnails       := CCRoot + 'CCthumbnails\';
          Fileserverpaths[NFileserverpaths].CCWEBreadviewpreviews   := CCRoot + 'CCreadviewpreviews\';
          Fileserverpaths[NFileserverpaths].Locationid := -1;
        End;
        IF ServerType = FILESERVERTYPE_PDFSERVER then
        Begin
          Fileserverpaths[NFileserverpaths].CCPDFFiles := CCRoot + 'CCPDFFiles\';
          Fileserverpaths[NFileserverpaths].CCPDFlogs := CCRoot + 'CCPDFlogs\';
        End;
        IF (Fileserverpaths[NFileserverpaths].Servertype = FILESERVERTYPE_MAIN) or (Fileserverpaths[NFileserverpaths].Servertype = Prefs.PlanCenterFileServerType) then
          Fileserverpaths[NFileserverpaths].Locationid := -1;

        IF Fileserverpaths[NFileserverpaths].CCfiles + Fileserverpaths[NFileserverpaths].CCpreviews +
           Fileserverpaths[NFileserverpaths].CCthumbnails + Fileserverpaths[NFileserverpaths].CCreadviewpreviews +
           Fileserverpaths[NFileserverpaths].CCVersions + Fileserverpaths[NFileserverpaths].CCWEBpreviews  +
           Fileserverpaths[NFileserverpaths].CCWEBthumbnails + Fileserverpaths[NFileserverpaths].CCWEBreadviewpreviews +
           Fileserverpaths[NFileserverpaths].CCPDFfiles + Fileserverpaths[NFileserverpaths].CCPDFlogs = '' then
             dec(NFileserverpaths);
      End;
      DataM1.Query1.next;
    end;
    DataM1.Query1.close;
    IF NFileserverpaths = 0 then
    begin
      DataM1.Query1.sql.clear;
      DataM1.Query1.sql.add('Select ServerName,ServerFilePath,ServerPreviewPath,ServerThumbnailPath,ServerUserName,ServerPassword,WebProofPath from GeneralPreferences');
      DataM1.Query1.open;
      Inc(NFileserverpaths);
      Fileserverpaths[NFileserverpaths].CCfiles := '';
      Fileserverpaths[NFileserverpaths].CCpreviews := '';
      Fileserverpaths[NFileserverpaths].CCthumbnails := '';
      Fileserverpaths[NFileserverpaths].CCreadviewpreviews := '';
      Fileserverpaths[NFileserverpaths].CCVersions := '';
      Fileserverpaths[NFileserverpaths].CCWEBpreviews := '';
      Fileserverpaths[NFileserverpaths].CCWEBthumbnails := '';
      Fileserverpaths[NFileserverpaths].CCWEBreadviewpreviews := '';
      Fileserverpaths[NFileserverpaths].CCPDFfiles := '';
      Fileserverpaths[NFileserverpaths].CCPdflogs := '';

      Fileserverpaths[NFileserverpaths].Servertype  := FILESERVERTYPE_MAIN;
      Fileserverpaths[NFileserverpaths].Fileservername   := uppercase(DataM1.Query1.Fields[0].AsString);
      Fileserverpaths[NFileserverpaths].CCfiles          := IncludeTrailingBackslash(DataM1.Query1.Fields[1].AsString);
      CCRoot := Uppercase(Fileserverpaths[NFileserverpaths].CCfiles);
      delete(CCRoot,pos('CCFILES',CCRoot),100);
      CCRoot := includetrailingbackslash(CCRoot);
      Fileserverpaths[NFileserverpaths].Locationid       := -1;
      Fileserverpaths[NFileserverpaths].CCpreviews       := IncludeTrailingBackslash(DataM1.Query1.fields[2].AsString);
      Fileserverpaths[NFileserverpaths].CCthumbnails        := IncludeTrailingBackslash(DataM1.Query1.fields[3].AsString);
      Fileserverpaths[NFileserverpaths].CCreadviewpreviews  := CCRoot + 'CCreadviewpreviews\';
      Fileserverpaths[NFileserverpaths].CCVersions          := CCRoot + 'CCVersions\';
      Fileserverpaths[NFileserverpaths].ccroot := ccroot;
      Fileserverpaths[NFileserverpaths].Username  := DataM1.Query1.fields[4].AsString;
      Fileserverpaths[NFileserverpaths].password  := TUtils.DecodeBlowfish(DataM1.Query1.fields[5].AsString);

      IF DataM1.Query1.Fields[6].AsString <> '' then
      begin
        Inc(NFileserverpaths);
        Fileserverpaths[NFileserverpaths].Servertype  := FILESERVERTYPE_WEBCENTER;
        Fileserverpaths[NFileserverpaths].Locationid       := -1;
        Fileserverpaths[NFileserverpaths].Username  := DataM1.Query1.Fields[4].AsString;
        Fileserverpaths[NFileserverpaths].password  := TUtils.DecodeBlowfish(DataM1.Query1.Fields[5].AsString);

        Fileserverpaths[NFileserverpaths].CCfiles := '';
        Fileserverpaths[NFileserverpaths].CCpreviews := '';
        Fileserverpaths[NFileserverpaths].CCthumbnails := '';
        Fileserverpaths[NFileserverpaths].CCreadviewpreviews := '';
        Fileserverpaths[NFileserverpaths].CCVersions := '';
        Fileserverpaths[NFileserverpaths].CCWEBpreviews := '';
        Fileserverpaths[NFileserverpaths].CCWEBthumbnails := '';
        Fileserverpaths[NFileserverpaths].CCWEBreadviewpreviews := '';
        Fileserverpaths[NFileserverpaths].CCPDFfiles := '';
        Fileserverpaths[NFileserverpaths].CCPdflogs := '';
        CCRoot := Uppercase(includetrailingbackslash(DataM1.Query1.fields[6].AsString));
        Fileserverpaths[NFileserverpaths].ccroot := ccroot;
        Fileserverpaths[NFileserverpaths].CCWEBpreviews       := CCRoot+'CCpreviews\';
        Fileserverpaths[NFileserverpaths].CCWEBthumbnails       := CCRoot+'CCthumbnails\';
        Fileserverpaths[NFileserverpaths].CCWEBreadviewpreviews       := CCRoot+'CCreadviewpreviews\';
      end;
      DataM1.Query1.close;
    End;

    for i := 1 to 20 do
    begin
      DeleteFile(IncludeTrailingBackslash(TUtils.GetTempDirectory()) + IntToStr(i) + 'Netconnect.bat');
      DeleteFile(IncludeTrailingBackslash(TUtils.GetTempDirectory()) + IntToStr(i) + 'NetConResult.txt');
    end;
    ConnectUserDriveCount := 0;
    if (not Prefs.OnlyConnectPlanCenterUser) then
    begin
      for i := 1 to NFileserverpaths do
      begin
        formmain.ConnectUserDrive(Fileserverpaths[i].Username,Fileserverpaths[i].password,Fileserverpaths[i].ccroot,true);
      end;
    end;
    if (Prefs.OnlyConnectPlanCenterUser) AND (PlanCenterUserIndex > 0) then
    begin
      formmain.ConnectUserDrive(Fileserverpaths[PlanCenterUserIndex].Username,Fileserverpaths[PlanCenterUserIndex].password,Fileserverpaths[PlanCenterUserIndex].ccroot,true);
    end;
  Except
  end;
End;

procedure TFormdelpublication.FormCreate(Sender: TObject);
begin
  Delfilelist := TStringList.Create;
  DelFolders  := TStringList.Create;
  Folderproblems := TStringList.Create;
  DelfileLogOK := TStringList.Create;
  DelfileLogERROR := TStringList.Create;
end;

Function TFormdelpublication.Deletethefiles:Boolean;

procedure DeleteRecurse( src : String ) ;
var
  sts : Integer ;
  SR: TSearchRec;
begin
  src := includetrailingbackslash(src);
  sts := FindFirst( src + '*.*' , faDirectory , SR ) ;
  if sts = 0 then
  begin
    if ( SR.Name <> '.' ) and ( SR.Name <> '..' ) then
    begin
      if SR.Attr = faDirectory then
      begin
          DeleteRecurse( src + SR.Name + '\' ) ;
          {$I-}RmDir( src + SR.Name ) ;{$I+}
      end
      else
      begin
        IF DeleteFile( src + SR.Name ) then
          DelfileLogOK.add(src + SR.Name)
        else
          DelfileLogERROR.add(src + SR.Name);
      end;
    end ;
    while FindNext( SR ) = 0 do
    if ( SR.Name <> '.' ) and ( SR.Name <> '..' ) then
    begin
      if SR.Attr = faDirectory then
      begin
        DeleteRecurse( src + SR.Name + '\' ) ;
        {$I-}RmDir( src + SR.Name ) ;{$I+}
      end
      else
      Begin
        IF DeleteFile( src + SR.Name ) then
          DelfileLogOK.add(src + SR.Name)
        else
          DelfileLogERROR.add(src + SR.Name);
      end;
    end ;
    FindClose( SR ) ;
  end ;
end ;
procedure ExecFASTProcess(ProgramName      : String;
                          programparameter : string);
var
  StartInfo  : TStartupInfo;
  ProcInfo   : TProcessInformation;
  CreateOK   : Boolean;
  T : String;
begin
  FillChar(StartInfo,SizeOf(TStartupInfo),#0);
  FillChar(ProcInfo,SizeOf(TProcessInformation),#0);
  StartInfo.cb := SizeOf(TStartupInfo);
  //+programparameter+'"'
  T := '"'+ProgramName+'"' + ' "' +programparameter+'"';

  StartInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartInfo.wShowWindow := SW_HIDE;
  CreateOK := CreateProcess(nil,pchar(T), nil, nil,False,
              CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS ,
              nil, nil, StartInfo, ProcInfo);
  if CreateOK then
    WaitForSingleObject(ProcInfo.hProcess, INFINITE);

end;
Var
  I : longint;
  s : tdatetime;
  Aktpath : String;
  T,F : string;
begin
  try
    s := now;
    Folderproblems.Clear;
    Aktpath := 'dsds';
    ProgressBarfiles.position := 0;
    ProgressBarfiles.Max := (Delfilelist.Count) +  (DelFolders.Count);
    For i :=  0 to Delfilelist.Count-1 do
    begin
      IF deletefile(Delfilelist[i]) then
        DelfileLogOK.add(Delfilelist[i])
      else
        DelfileLogERROR.add(Delfilelist[i]);
      ProgressBarfiles.position := ProgressBarfiles.position+1;
      IF I mod 20 = 0 then
      Begin
        ProgressBarfiles.repaint;
        application.ProcessMessages;
      end;
    end;
    For i :=  0 to DelFolders.Count-1 do
    begin
      ProgressBarfiles.position := ProgressBarfiles.position+1;
      IF I mod 20 = 0 then
      Begin
    //    ProgressBarfiles.repaint;
        application.ProcessMessages;
      End;
      DeleteRecurse(DelFolders[i]);
      if directoryexists(DelFolders[i]) then
        {$I-}RMdir(DelFolders[i]);{$I+}
    End;
    i := 89;

    deletefile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'DelfileLogOK.txt');
    deletefile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'DelfileLogERROR.txt');
    DelfileLogOK.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'DelfileLogOK.txt');
    DelfileLogERROR.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'DelfileLogERROR.txt');
    For i :=  0 to 10 do
    begin
      application.ProcessMessages;
      Sleep(100);
    End;
    application.ProcessMessages;

  Finally
  End;
end;

procedure TFormdelpublication.RemoteDelete(delpubllist : Tstringlist);
Var
  I : Longint;
begin
  try
    IF not Prefs.AllowOnlyDefaultLocationPress then
    Begin
      ComboBoxdellocation.Items.Clear;
      ComboBoxdellocation.Items := tnames1.locationnames;
      ComboBoxdellocation.Items.Insert(0,'All');
      ComboBoxdellocation.Itemindex := 0;
    end
    else
    begin
      ComboBoxdellocation.Items.Clear;
      ComboBoxdellocation.Items.Add(Prefs.DefaultLocation);
      ComboBoxdellocation.Itemindex := 0;
    end;
    preparefileserverpaths;

    GroupBox1.visible := Prefs.ArchiveEnabled;
    GroupBox1.visible := false;
    CheckBoxAhighres.Checked := Prefs.DefaultArchiveHighres;
    CheckBoxAlowres.Checked := Prefs.DefaultArchiveLowres;
    if not Prefs.ArchiveEnabled then
    begin
      CheckBoxAhighres.Checked := false;
      CheckBoxAlowres.Checked := false;
    end;
    loadlist;
    Memo1.lines.clear;
    For i := 1 to NFileserverpaths do
    begin
      Memo1.lines.add(Fileserverpaths[i].Fileservername + ':');
      Memo1.lines.add('CCfiles:                ' +Fileserverpaths[i].CCfiles);
      Memo1.lines.add('CCpreviews:             ' +Fileserverpaths[i].CCpreviews);
      Memo1.lines.add('CCthumbnails:           ' +Fileserverpaths[i].CCthumbnails);
      Memo1.lines.add('CCreadviewpreviews:     ' +Fileserverpaths[i].CCreadviewpreviews);
      Memo1.lines.add('CCVersions:             ' +Fileserverpaths[i].CCVersions);
      Memo1.lines.add('CCWEBpreviews:          ' +Fileserverpaths[i].CCWEBpreviews);
      Memo1.lines.add('CCWEBthumbnails:        ' +Fileserverpaths[i].CCWEBthumbnails);
      Memo1.lines.add('CCWEBreadviewpreviews:  ' +Fileserverpaths[i].CCWEBreadviewpreviews);
      Memo1.lines.add('CCPDFfiles:             ' +Fileserverpaths[i].CCPDFfiles);
      Memo1.lines.add('CCPDFlogs:              ' +Fileserverpaths[i].CCPdflogs);
    End;
    PageControl1.ActivePageIndex := 0;
    CheckBoxgenrep.checked := Prefs.GenerateReportWhenDeleting;

  Except
  end;
end;

procedure TFormdelpublication.ComboBoxPagefilerdayDropDown(
  Sender: TObject);
Begin
  setthedays;
End;
procedure TFormdelpublication.setthedays;
Begin
  ComboBoxPagefilerday.Items.Clear;
  ComboBoxPagefilerday.Items.add(formmain.LabelAlldays.Caption);

  Try
    DataM1.Query1.sql.clear;
    DataM1.Query1.SQL.add('Select distinct pubdate from pagetable (NOLOCK)');
    DataM1.Query1.SQL.add('Where active > 0 and Dirty = 0');
    IF Prefs.AllowOnlyDefaultLocationPress then
    begin
      DataM1.Query1.SQL.add('and locationid = ' + IntToStr(tnames1.locationnametoid(Prefs.DefaultLocation)));
    end;
    DataM1.Query1.SQL.add('order by pubdate');
    DataM1.Query1.open;
    While not DataM1.Query1.eof do
    begin
      ComboBoxPagefilerday.Items.Add(DateToStr(DataM1.Query1.fields[0].asdatetime));
      DataM1.Query1.next;
    end;
    DataM1.Query1.close;
  Except
  end;
End;

procedure TFormdelpublication.ComboBoxPagefilerdayCloseUp(Sender: TObject);
Var
  I,found : Longint;
begin
  IF TComboBox(Sender).ItemIndex < 0 then
  Begin
    found := 0;
    TComboBox(Sender).ItemIndex := found;
  End;
  TComboBox(Sender).text := TComboBox(Sender).items[TComboBox(Sender).ItemIndex];
  loadlist;
end;

end.
