unit UOldversions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, XPStyleActnCtrls, ActnMan, ToolWin, ActnCtrls,
  ComCtrls, PBExListview, StdCtrls, FileCtrl, System.Actions;

type
  TFormOldver = class(TForm)
    ActionToolBarunknow: TActionToolBar;
    ActionManager1: TActionManager;
    Actionpreview: TAction;
    Actionrefresh: TAction;
    ActionUse: TAction;
    Action1: TAction;
    PBExListview1: TPBExListview;
    Actiondelete: TAction;
    Actionpageselect: TAction;
    FileListBox1: TFileListBox;
    GroupBox1: TGroupBox;
    ComboBoxPubl: TComboBox;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActionpreviewExecute(Sender: TObject);
    procedure ActionrefreshExecute(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure ActiondeleteExecute(Sender: TObject);
    procedure ActionUseExecute(Sender: TObject);
    procedure PBExListview1Compare(Sender: TObject; Item1,
      Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure PBExListview1AdvancedCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage;
      var DefaultDraw: Boolean);
    procedure PBExListview1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure ActionpageselectExecute(Sender: TObject);
    procedure ComboBoxPublChange(Sender: TObject);
  private
    activated : Boolean;
    OldversionsPath : string;

    Function extractfilename(Afilename : String;
                             Var mastercopyseparationset : String;
                             Var Color : String;
                             Var version : string):Boolean;

//    procedure SetUbluebar;
    Procedure setgray;
  public
    FPubdate       : tdatetime;
    FPublicationid : Longint;
    FEditionid     : Longint;
    FSectionid     : Longint;
    FPagename      : String;
    FMasternumber  : Longint;
    procedure Setfilter(APubdate       : tdatetime;
                        APublicationid : Longint;
                        AEditionid     : Longint;
                        ASectionid     : Longint;
                        APagename      : String;
                        Amasternumber  : Longint);

    { Public declarations }
  end;

var
  FormOldver: TFormOldver;

implementation
Uses
  umain,Udata,DateUtils, UFilepreview, UResampleprogress, Usettings;

{$R *.dfm}

procedure TFormOldver.FormActivate(Sender: TObject);
begin
  IF Not activated then
  begin
    OldversionsPath := formmain.getfileserverpath(5,'');
    Actionpageselect.Checked := true;
    Actionrefresh.Enabled := true;
    if not directoryexists(OldversionsPath) then
    begin
      MessageDlg(formmain.InfraLanguage1.Translate('Cannot connect to oldversion folder') , mtError,[mbOk], 0);
      Actionrefresh.Enabled := false;
    end;
    Actionpreview.Enabled := FileResampleposible;
//    SetUbluebar;
   // ActionRefresh.Execute;
    activated := true;
  End;
  ComboBoxPubl.items := tnames1.publicationnames;
  ComboBoxPubl.itemindex := 0;
end;

{procedure TFormOldver.SetUbluebar;


Var
  I,i2 : longint;
  foundit,foundsepcial : Boolean;
  Temptoolbar : Tactiontoolbar;
begin

  foundit := false;

  for I := 0 to actionmanager1.ActionBars.Count-1 do
  begin
    actionmanager1.ActionBars[i].Background.LoadFromFile(extractfilepath(application.ExeName)+'toolbarimage.bmp');
    actionmanager1.ActionBars[i].BackgroundLayout := blStretch;
  end;

  Temptoolbar := ActionToolBarunknow;
  For i2 := 0 to Temptoolbar.ControlCount-1 do
  begin
  //  TCustomButtonControl(Temptoolbar.Controls[i2]).setacheckimage(formmain.ImageSelnewbar.Picture.Bitmap,
   //                                                               formmain.ImageSelnewbarMouse.Picture.Bitmap,
    //                                                              true);
  end;
end;
}
procedure TFormOldver.FormCreate(Sender: TObject);
begin
  activated := false;
  PBExListview1.DoubleBuffered := true;
end;

procedure TFormOldver.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  activated := false;
end;



procedure TFormOldver.ActionrefreshExecute(Sender: TObject);
Var
  R,I : Longint;
  mastercopyseparationset,Color,version : string;
  F : TSearchRec;
  L : Tlistitem;
  showgray : Boolean;
  Filterstring,t : string;

  Alist : TStrings;
begin

  Alist := TStringList.Create;
  try
    IF Actionrefresh.Enabled then
    begin
      screen.Cursor := crhourglass;

      PBExListview1.items.beginupdate;
      PBExListview1.items.clear;

      FileListBox1.mask :=  '*.XYZ';
      Filterstring := '*.*';
      IF FMasternumber > 0 then
      begin
        Filterstring := '*-'+inttostr(FMasternumber)+'.*';
      end;

      DataM1.Query3.SQL.Clear;           //   0        1             2        3           4       5      6              7                    8
      DataM1.Query3.SQL.add('Select distinct mastercopyseparationset from pagetable (NOLOCK) ');
      DataM1.Query3.SQL.add('where active > 0 and dirty <> 1 and uniquepage = 1');
      DataM1.Query3.SQL.add('and Publicationid = ' + inttostr(tnames1.publicationnametoid(ComboBoxPubl.Text)));
      DataM1.Query3.open;
      While not DataM1.Query3.eof do
      begin
        alist.add(DataM1.Query3.fields[0].asstring);
        DataM1.Query3.next;
      End;
      DataM1.Query3.close;

      FileListBox1.Directory  := ExcludeTrailingBackslash(OldversionsPath);
      FileListBox1.mask := Filterstring;
      For i := 0 to FileListBox1.Items.Count-1 do
      begin
        IF extractfilename(FileListBox1.Items[i],mastercopyseparationset,Color,version) then
        begin
          IF alist.IndexOf(mastercopyseparationset) > -1 then
          begin
            t := FileListBox1.Items[i];
            L:= PBExListview1.items.add;
            L.Caption := '';
            L.subitems.add('');
            L.subitems.add('');
            L.subitems.add('');
            L.subitems.add('');
            L.subitems.add(version);
            L.subitems.add(color);
            L.subitems.add('');
            L.subitems.add(mastercopyseparationset);
            L.subitems.add('');
            L.subitems.add('');
            L.subitems.add('');
            L.subitems.add('');
            L.subitems.add(t);
            L.subitems.add('');
            L.subitems.add('');
            L.subitems.add('');
          End;
        End;
      end;


      if PBExListview1.items.count > 0 then
      begin
        DataM1.Query3.SQL.Clear;           //   0        1             2        3           4       5      6              7                    8
        DataM1.Query3.SQL.add('Select distinct pubdate,publicationid,editionid,sectionid,pagename,version,colorid,mastercopyseparationset,pageindex from pagetable (NOLOCK) ');
        DataM1.Query3.SQL.add('where active > 0 and dirty <> 1 and uniquepage = 1');
        DataM1.Query3.SQL.add('and Publicationid = ' + inttostr(tnames1.publicationnametoid(ComboBoxPubl.Text)));
        DataM1.Query3.open;
        While not DataM1.Query3.eof do
        begin
          Color := tnames1.ColornameIDtoname(DataM1.Query3.fields[6].asinteger);
          For i := 0 to PBExListview1.items.count-1 do
          begin
            IF PBExListview1.items[i].SubItems[3] = '' then
            begin
              IF (PBExListview1.items[i].SubItems[5] = Color) and
                 (PBExListview1.items[i].SubItems[7] = DataM1.Query3.fields[7].asstring) then
              begin
                PBExListview1.items[i].caption := datetostr(DataM1.Query3.fields[0].asdatetime);
                PBExListview1.items[i].subitems[0] := tnames1.publicationIDtoname(DataM1.Query3.fields[1].asinteger);
                PBExListview1.items[i].subitems[1] := tnames1.editionIDtoname(DataM1.Query3.fields[2].asinteger);
                PBExListview1.items[i].subitems[2] := tnames1.sectionIDtoname(DataM1.Query3.fields[3].asinteger);
                PBExListview1.items[i].subitems[3] := DataM1.Query3.fields[4].asstring;
                PBExListview1.items[i].subitems[6] := DataM1.Query3.fields[5].asstring;
                PBExListview1.items[i].subitems[8] := DataM1.Query3.fields[8].asstring;
              end;
            End;

          end;
          DataM1.Query3.next;
        end;

        DataM1.Query3.close;


        For i := PBExListview1.items.count-1 downto 0 do
        begin
          IF PBExListview1.items[i].SubItems[3] = '' then
            PBExListview1.items.Delete(i);
        End;




        PBExListview1.AlphaSort;
        setgray;


      end;


      PBExListview1.items.Endupdate;
    End;  
  finally
    alist.free;
    screen.Cursor := crdefault;
  end;

end;

procedure TFormOldver.Action1Execute(Sender: TObject);
begin
  close;
end;

Function TFormOldver.extractfilename(Afilename : String;
                                     Var mastercopyseparationset : String;
                                     Var Color : String;
                                     Var version : string):Boolean;
Var
  i,dotpos,minpos : Longint;
Begin
  result := false;
  Afilename := uppercase(Afilename);
  version := '';
  mastercopyseparationset := '';
  Color := '';
  try
    dotpos := pos('.',afilename);
    minpos := pos('-',afilename);
    IF (dotpos > 0) and (minpos > 0) then
    begin
      Color := ExtractFileExt(Afilename);
      delete(Color,1,1);
      Afilename := changefileext(Afilename,'');
      for I := length(Afilename) downto 1 do
      begin
        if Afilename[i] = '-' then
        begin
          mastercopyseparationset := Afilename;
          delete(mastercopyseparationset,1,i);
          delete(Afilename,i,100);
          break;
        end;
      end;

      IF pos('-',Afilename) > 0 then
      begin
        for I := length(Afilename) downto 1 do
        begin
          if Afilename[i] = '-' then
          begin
            delete(Afilename,1,i);
            break;
          end;
        end;
      End;
      version := Afilename;
    end;
    if mastercopyseparationset <> '' then
    begin
      try
        I := strtoint(mastercopyseparationset);
      except
        mastercopyseparationset := '';
      end;
    end;
    if version <> '' then
    begin
      try
        I := strtoint(version);
      except
        version := '';
      end;
    end;

    result := (mastercopyseparationset <> '') and (color <> '') and (version <> '');

  except
  end;

end;

procedure TFormOldver.Setfilter(APubdate       : tdatetime;
                                APublicationid : Longint;
                                AEditionid     : Longint;
                                ASectionid     : Longint;
                                APagename      : String;
                                Amasternumber  : Longint);

Begin
  FPubdate       := 0;
  FPublicationid := -1;
  FEditionid     := -1;
  FSectionid     := -1;
  FPagename      := '';
  FMasternumber  := -1;

  IF Yearof(APubdate) > 2000 then
    FPubdate := APubdate;
  IF APublicationid > 0 then
    FPublicationid := APublicationid;
  IF Aeditionid > 0 then
    Feditionid := Aeditionid;
  IF Asectionid > 0 then
    Fsectionid := Asectionid;
  IF APagename <> '' then
    FPagename := APagename;
  IF AMasternumber > 0 then
    FMasternumber := AMasternumber;

end;


procedure TFormOldver.PBExListview1Compare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
var
  ix: Integer;
  ColumnToSort : Longint;
begin
  for ColumnToSort := 0 to 8 do
  begin
    if ColumnToSort = 0 then
    Begin
      Compare := CompareText(Item1.Caption,Item2.Caption);
    End
    else
    begin
     ix := ColumnToSort - 1;
     Compare := 0;
     Case ix of
       0..2 : Compare := CompareText(Item1.SubItems[ix],Item2.SubItems[ix]);
       3    : Begin
                IF strtoint(Item1.SubItems[8]) > strtoint(Item2.SubItems[8]) then
                begin
                  compare := 1;
                end
                else
                begin
                  IF strtoint(Item1.SubItems[8]) < strtoint(Item2.SubItems[8]) then
                    compare := -1;
                end;
              end;
       4    : Begin
                IF strtoint(Item1.SubItems[4]) > strtoint(Item2.SubItems[4]) then
                begin
                  compare := 1;
                end
                else
                begin
                  IF strtoint(Item1.SubItems[4]) < strtoint(Item2.SubItems[4]) then
                    compare := -1;
                end;
              end;
      End;
    end;
    if Compare <> 0 then
      break;
  End;
end;

Procedure TFormOldver.setgray;
Var
  mastercopyseparationset,version : string;
  isgray : Boolean;
  I : Longint;
Begin
  isgray := false;
  IF PBExListview1.items.count > 0 then
  begin
    mastercopyseparationset := PBExListview1.items[0].SubItems[7];
    version                 := PBExListview1.items[0].SubItems[4];
    For i := 0 to PBExListview1.items.count-1 do
    begin
      IF (mastercopyseparationset <> PBExListview1.items[i].SubItems[7]) or
         (version <> PBExListview1.items[i].SubItems[4]) then
      begin
        mastercopyseparationset := PBExListview1.items[i].SubItems[7];
        version := PBExListview1.items[i].SubItems[4];
        isgray := not isgray;
      end;

      IF isgray then
        PBExListview1.items[i].SubItems[9] := '1'
      else
        PBExListview1.items[i].SubItems[9] := '0';

      PBExListview1.items[i].SubItems[10] := '0';

    End;
  End;
  PBExListview1.Repaint;
End;


procedure TFormOldver.PBExListview1AdvancedCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  Stage: TCustomDrawStage; var DefaultDraw: Boolean);
begin
  DefaultDraw := true;
  if item.subitems[10] <> '1' then
  begin
    if item.subitems[9] = '1' then
      PBExListview1.canvas.Brush.Color := clCream
    else
      PBExListview1.canvas.Brush.Color := clwhite;
  End
  else
  Begin
    PBExListview1.canvas.font.Color := clwhite;
    PBExListview1.canvas.Brush.Color := clHighlight;
  end;
end;

procedure TFormOldver.PBExListview1SelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
Var
  I : Longint;
begin
  for i := 0 to PBExListview1.Items.Count-1 do
  begin
    PBExListview1.Items[i].SubItems[10] := '0';
  end;

  item.SubItems[10] := '1';
  if (selected) and (Actionpageselect.Checked) then
  begin

    for i := item.Index-1 Downto item.Index-4 do
    begin
      if (i > 0) then
      begin
        if (PBExListview1.Items[i].SubItems[7] = item.SubItems[7]) and
           (PBExListview1.Items[i].SubItems[4] = item.SubItems[4]) then
          PBExListview1.Items[i].SubItems[10] := '1'
        Else
          break;
      end;
    end;
    for i := item.Index+1 to item.Index+4 do
    begin
      if (i < PBExListview1.Items.Count) then
      begin
        if (PBExListview1.Items[i].SubItems[7] = item.SubItems[7]) and
           (PBExListview1.Items[i].SubItems[4] = item.SubItems[4]) then
          PBExListview1.Items[i].SubItems[10] := '1'
        Else
          break;
      end;
    end;
  end;
  PBExListview1.repaint;
end;


procedure TFormOldver.ActionpageselectExecute(Sender: TObject);
Var
  I : Longint;
begin
  Actionpageselect.Checked := not Actionpageselect.Checked;
  for i := 0 to PBExListview1.Items.Count-1 do
  begin
    PBExListview1.Items[i].SubItems[10] := '0';
  end;
  PBExListview1.repaint;
end;

procedure TFormOldver.ActionUseExecute(Sender: TObject);
Var
  I : Longint;
  f,t : String;
  ccpath : String;
  Anyerror : boolean;
begin
  Anyerror := false;
  for i := 0 to PBExListview1.Items.Count-1 do
  begin
    PBExListview1.Items[i].Subitems[11] := '';
  End;

  for i := 0 to PBExListview1.Items.Count-1 do
  begin
    IF PBExListview1.Items[i].Subitems[10] = '1' then
    begin
      try
        IF formsettings.CheckBoxSwapoldver.Checked then
        begin
          ccpath := formmain.getfileserverFrommaster(1,strtoint(PBExListview1.Items[i].subitems[7]));
          f := includetrailingbackslash(ccpath) + PBExListview1.Items[i].subitems[7]+
                 '.' + PBExListview1.Items[i].subitems[5];


          t := OldversionsPath + '-'+PBExListview1.Items[i].subitems[6]+'-'+ PBExListview1.Items[i].subitems[7]+
            '.' + PBExListview1.Items[i].subitems[5];
          if copyfile(pchar(f),pchar(t),false) then
          begin

          end
          else
          begin

          end;
        End;
      Except
      end;

      try
        f := OldversionsPath + PBExListview1.Items[i].subitems[12];
        ccpath := formmain.getfileserverFrommaster(1,strtoint(PBExListview1.Items[i].subitems[7]));
        t := includetrailingbackslash(ccpath) + PBExListview1.Items[i].subitems[7]+
               '.' + PBExListview1.Items[i].subitems[5];
        if copyfile(pchar(f),pchar(t),false) then
        begin
          PBExListview1.Items[i].subitems[11] := '1';
        end
        else
        begin

        end;
      Except
      end;
    end;
  End;
  for i := 0 to PBExListview1.Items.Count-1 do
  begin
    IF (PBExListview1.Items[i].Subitems[10] = '1') And (PBExListview1.Items[i].Subitems[11] = '1') then
    begin
      DataM1.Query3.SQL.Clear;
      DataM1.Query3.SQL.add('update pagetable ');
      DataM1.Query3.SQL.add('Set status = 30,proofstatus = 0, version= ' + PBExListview1.Items[i].Subitems[4]);
      DataM1.Query3.SQL.add('where mastercopyseparationset = '+ PBExListview1.Items[i].subitems[7]);
      DataM1.Query3.SQL.add('and colorid = ' +inttostr(tnames1.Colornametoid(PBExListview1.Items[i].subitems[5]) ));
      formmain.trysql(DataM1.Query3);
    End;
  End;

end;


procedure TFormOldver.ActiondeleteExecute(Sender: TObject);
Var
  f : String;
  I : Longint;
begin
  for i := 0 to PBExListview1.Items.Count-1 do
  begin
    IF PBExListview1.Items[i].Subitems[10] = '1' then
    begin
      f := OldversionsPath + PBExListview1.Items[i].subitems[12];
      deletefile(f);
    End;
  End;
  Actionrefresh.Execute;


end;


procedure TFormOldver.ComboBoxPublChange(Sender: TObject);
begin
  IF activated then
    Actionrefresh.Execute;
end;

procedure TFormOldver.ActionpreviewExecute(Sender: TObject);
Var
  I : Longint;
begin
  try
    Formfilepreview.Nfiles := 0;
    For i := 0 to PBExListview1.Items.count-1 do
    begin
      IF (PBExListview1.Items[i].Subitems[10] = '1') and (Formfilepreview.Nfiles < 4) then
      begin
        Inc(Formfilepreview.Nfiles);
        Formfilepreview.files[Formfilepreview.Nfiles].name := includetrailingbackslash(OldversionsPath)+PBExListview1.Items[i].subitems[12];
        Formfilepreview.files[Formfilepreview.Nfiles].color := PBExListview1.Items[i].subitems[5];
      End;
    End;
    Formresampleprogress.ProgressBar1.Position := 0;
    Formresampleprogress.show;
    Formresampleprogress.Repaint;
    if Formfilepreview.Genprevfiles then
    begin
      Formresampleprogress.Close;
      Formfilepreview.ImageEn1.IO.LoadFromFileJpeg(extractfilepath(application.exename)+'Prevtemp\aprev.jpg');
      Formfilepreview.showmodal;
    End
    Else
      Formresampleprogress.Close;
  Finally
    if Formresampleprogress.Active then
      Formresampleprogress.Close;
    FormOldver.SetFocus;
  end;
end;

end.
