unit UStatusview;
//spPageStatusList
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, SqlExpr, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  PBExListview,UStatusframe,utypes, ActnList,
  XPStyleActnCtrls, ActnMan, ToolWin, ActnCtrls, ActnMenus, Menus,
  System.Actions;


type
  TFormStatusView = class(TForm)
    ScrollBoxEnhstatus: TScrollBox;
    ScrollBar1: TScrollBar;
    ActionManager1: TActionManager;
    ActionStatusrefresh: TAction;
    PopupMenUstatuswindow: TPopupMenu;
    Refresh1: TMenuItem;
    Actiontest: TAction;
    procedure Refresh1Click(Sender: TObject);
    procedure ActionStatusrefreshExecute(Sender: TObject);
    procedure ActiontestExecute(Sender: TObject);
  private
    { Private declarations }
    Function getthecolor(Status : Longint):Tcolor;
  public
    PublicationID : Longint;
    EditionID : Longint;
    SectionID : Longint;
    Pubdate : Tdatetime;
    Aktpressgrpid : Longint;
    singleh : Longint;
    visiblerows : Longint;
    NumberHorz : Longint;

    Procedure createvies(Var AScrollbox : TScrollBox);
    Procedure repositionframes;

  end;

var
  FormStatusView: TFormStatusView;

implementation

uses Umain, Udata, Usettings;

{$R *.dfm}
Var
  HortzFrames : Longint;


Procedure TFormStatusView.repositionframes;
Var
  i,aktH,ih,Maxheight,Curtop,Curleft,akthorz : Longint;

  H : Array[1..10] of Longint;
  lefts : Array[1..10] of Longint;

  T : String;
begin
  akthorz := 1;
  Curtop  := 0;
  Curleft := 0;
  Maxheight := 5;
  aktH := 1;



  For i := 0 to Nstatusframes-1 do
  Begin
    statusframes[i].StatusFrame.Height := (((statusframes[i].StatusFrame.PBExListview1.Items.Count+1)* singleh) + ScrollBar1.Width + 10);
  end;

  statusframes[0].StatusFrame.top := 0;
  statusframes[0].StatusFrame.left := 0;
  For i := 1 to 10 do
  Begin
    H[i] := 0;

  end;
  H[aktH] := statusframes[0].StatusFrame.width;

  For i := 2 to 10 do
  Begin
    lefts[i] := (statusframes[0].StatusFrame.width * i) + i-1;
  End;
  lefts[1] := 0;

  IF (Nstatusframes > 1) And (NumberHorz > 1) then
  begin
    For i := 1 to Nstatusframes-1 do
    Begin
      IF H[aktH] + statusframes[i].StatusFrame.Height > ScrollBoxEnhstatus.Height then
      begin
        IF aktH < NumberHorz then
        begin
          repeat
            Inc(aktH);
          until (aktH > NumberHorz) or (H[aktH] + statusframes[i].StatusFrame.Height < ScrollBoxEnhstatus.Height);
          IF aktH > NumberHorz then
            aktH := 1;
        end
        Else
        begin
          akth := 1;
        end;


        if (akth < 1) or (aktH > NumberHorz) then
          akth := 1;

      end;
      Curleft := lefts[akth];
      statusframes[i].StatusFrame.top := H[aktH];
      statusframes[i].StatusFrame.left := Curleft;
      H[akth] := H[akth] + statusframes[i].StatusFrame.Height;
    End;

  end
  Else
  Begin
    For i := 1 to Nstatusframes-1 do
    Begin
      statusframes[i].StatusFrame.top := H[1];
      statusframes[i].StatusFrame.left := 0;
      H[1] := H[1] + statusframes[i].StatusFrame.Height;
    End;

  End;




end;


Procedure TFormStatusView.createvies(Var AScrollbox : TScrollBox);

Function calcSizes:Longint;
Var
  TestStatusFrame : TFrameStatus;
  Hofframe,i : Longint;
  l : Tlistitem;

Begin
  TestStatusFrame := TFrameStatus.Create(AScrollbox);
  TestStatusFrame.Name := 'Testframe';
  //TestStatusFrame.Width := 2;
  TestStatusFrame.Height := AScrollbox.Height-5;
  TestStatusFrame.parent := FormStatusView;
//  TestStatusFrame.Align := alleft;

  l := TestStatusFrame.PBExListview1.Items.Add;
  l.Caption := 'ABXC';
  l := TestStatusFrame.PBExListview1.Items.Add;
  l.Caption := 'ABXC';
  singleh := TestStatusFrame.PBExListview1.Items[1].position.y - TestStatusFrame.PBExListview1.Items[0].position.y ;
  visiblerows := TestStatusFrame.PBExListview1.VisibleRowCount-1;
  NumberHorz := ((AScrollbox.Width-ScrollBar1.Width)-10) div TestStatusFrame.width;

  TestStatusFrame.Free;


end;


Var
  I,iver : Longint;
  l : Tlistitem;
  Itsablank : Boolean;
  PstatusframeData : PstatusframeDataType;
  NRecords,h,v,x,y,irec,akted,aktsec : Longint;
Begin
  try
    i := calcSizes;
    IF Nstatusframes > 0 then
    begin
      for i := 0 to Nstatusframes-1 do
      Begin
        try
          statusframes[i].StatusFrame.Free;
        Except
        end;
      End;
    end;

    Aktpressgrpid := -1;
    IF formmain.GroupBoxprgp.Visible Then
    begin
      IF formmain.ComboBoxPressGrp.Itemindex > 0 then
      begin
        DataM1.Query3.SQL.Clear;
        DataM1.Query3.SQL.add('select distinct PressGroupID from PressGroupNames');
        DataM1.Query3.SQL.add('where PressGroupName = ' +''''+formmain.ComboBoxPressGrp.text+'''');
        DataM1.Query3.Open;
        IF not DataM1.Query3.eof then
          Aktpressgrpid := DataM1.Query3.fields[0].AsInteger;
        DataM1.Query3.close;
      end;
    end;


    editionid := -1;
    Sectionid := -1;
    setlength(statusframes,1);
    Nstatusframes := 0;
    Case formmain.PageControlMain.ActivePageIndex of
      0 : Begin
            IF formmain.TreeViewpagelist.Selected = nil then  Exit;
            IF formmain.TreeViewpagelist.Selected.Level < 2 then exit;
            PublicationID := TTreeViewpagestype(formmain.TreeViewpagelist.Selected.data^).publicationid;
            Pubdate       := TTreeViewpagestype(formmain.TreeViewpagelist.Selected.data^).pubdate;
            IF formmain.TreeViewpagelist.Selected.Level > 2 then
              editionid := TTreeViewpagestype(formmain.TreeViewpagelist.Selected.data^).editionid;

            IF formmain.TreeViewpagelist.Selected.Level > 3 then
              SectionID := TTreeViewpagestype(formmain.TreeViewpagelist.Selected.data^).sectionid;
          End;
      1 : Begin
            IF formmain.TreeViewThumbs.Selected = nil then  Exit;
            IF formmain.TreeViewThumbs.Selected.Level < 2 then exit;
            PublicationID := TTreeViewpagestype(formmain.TreeViewThumbs.Selected.data^).publicationid;
            Pubdate       := TTreeViewpagestype(formmain.TreeViewThumbs.Selected.data^).pubdate;
            IF formmain.TreeViewThumbs.Selected.Level > 2 then
              editionid := TTreeViewpagestype(formmain.TreeViewThumbs.Selected.data^).editionid;

            IF formmain.TreeViewThumbs.Selected.Level > 3 then
              sectionid := TTreeViewpagestype(formmain.TreeViewThumbs.Selected.data^).sectionid;
          End;
      2 : Begin
            IF formmain.TreeViewPlateview.Selected = nil then exit;
            IF formmain.TreeViewPlateview.Selected.Level < 2 then exit;
            PublicationID := TTreeViewpagestype(formmain.TreeViewPlateview.Selected.data^).publicationid;
            Pubdate       := TTreeViewpagestype(formmain.TreeViewPlateview.Selected.data^).pubdate;
            IF formmain.TreeViewPlateview.Selected.Level > 2 then
              editionid := TTreeViewpagestype(formmain.TreeViewPlateview.Selected.data^).editionid;
            IF formmain.TreeViewPlateview.Selected.Level > 3 then
              sectionid := TTreeViewpagestype(formmain.TreeViewPlateview.Selected.data^).sectionid;
          end;
      3 : Begin
            IF formmain.TreeViewprodcontrol.Selected = nil then exit;
            IF formmain.TreeViewprodcontrol.Selected.Level < 2 then exit;
            PublicationID := TTreeViewpagestype(formmain.TreeViewprodcontrol.Selected.data^).publicationid;
            Pubdate       := TTreeViewpagestype(formmain.TreeViewprodcontrol.Selected.data^).pubdate;
            IF formmain.TreeViewprodcontrol.Selected.Level > 2 then
              sectionid := TTreeViewpagestype(formmain.TreeViewprodcontrol.Selected.data^).editionid;

            IF formmain.TreeViewprodcontrol.Selected.Level > 3 then
              sectionid := TTreeViewpagestype(formmain.TreeViewprodcontrol.Selected.data^).sectionid;

          end;

    end;


    NRecords := 0;
    DataM1.Query3.SQL.clear;
    DataM1.Query3.SQL.add('exec spPageStatusList');
    DataM1.Query3.SQL.add('@PublicationID = '+inttostr(Publicationid)+',');
    DataM1.Query3.SQL.add('@PubDate = :pubdate ,'); //+DataM1.makedatastr('',pubdate) + ' ,'

    DataM1.Query3.SQL.add('@editionID = '+inttostr(editionid)+',');
    DataM1.Query3.SQL.add('@sectionid = '+inttostr(sectionid)+',');
    DataM1.Query3.SQL.add('@PressID  = 0,');
    DataM1.Query3.SQL.add('@HideDone  = 0,');
    DataM1.Query3.SQL.add('@EmulateBender  = 1,');
    IF Aktpressgrpid > 0 then
      DataM1.Query3.SQL.add('@PressGroupID = ' + inttostr(Aktpressgrpid)  +',')
    Else
      DataM1.Query3.SQL.add('@PressGroupID = 0,'  );
    if formsettings.CheckListBoxstatusculmns.Checked[formsettings.CheckListBoxstatusculmns.Items.IndexOf('Sorted')] then
    begin
      DataM1.Query3.SQL.add('@IncludeSorting  = 1');
    End
    Else
    begin
      DataM1.Query3.SQL.add('@IncludeSorting  = 0');
    end;
    DataM1.Query3.ParamByName('pubdate').AsDateTime := pubdate;
    IF debug then datam1.Query3.sql.SaveToFile(extractfilepath(application.exename) + 'sqllogs\'+'makestatusview2.sql');
    DataM1.Query3.open;
    if not DataM1.Query3.eof then
    begin
      akted := datam1.Query3.fields[0].AsInteger;
      aktsec := datam1.Query3.fields[1].AsInteger;
    end;

    While Not DataM1.Query3.eof do
    begin
      Inc(NRecords);

      IF datam1.Query3.fields[2].Asstring <> '' then
      begin

        IF (akted <> datam1.Query3.fields[0].AsInteger) or (aktsec <> datam1.Query3.fields[1].AsInteger) then
        begin
          Inc(NRecords);
          akted := datam1.Query3.fields[0].AsInteger;
          aktsec := datam1.Query3.fields[1].AsInteger;

        end;
      End;


      DataM1.Query3.next;
    End;
    DataM1.Query3.close;

    h := 0;
    Nstatusframes := 1;
    for i := 1 to NRecords do
    begin
      inc(h);
      IF h > visiblerows then
      begin
        Inc(Nstatusframes);
        h := 0;
      end;
    end;

//    Nstatusframes := Round(  / visiblerows);

    setlength(statusframes,Nstatusframes+1);
    h := -1;
    v := 0;
    x := 0;
    y := 0;

    for i := 0 to Nstatusframes-1 do
    begin

      statusframes[i].StatusFrame := TFrameStatus.Create(AScrollbox);
      statusframes[i].StatusFrame.name := 'statusframes'+inttostr(i+1);
      statusframes[i].StatusFrame.parent := AScrollbox;
    //  statusframes[i].StatusFrame.editionid := DataM1.Query3.fields[0].Asinteger;
  //    statusframes[i].StatusFrame.sectionid := DataM1.Query3.fields[1].Asinteger;
      if i = 0 then
      begin
        statusframes[i].StatusFrame.align := alleft;
        statusframes[i].StatusFrame.Repaint;
        statusframes[i].StatusFrame.align := alnone;
      End
      else
        statusframes[i].StatusFrame.Height := statusframes[0].StatusFrame.Height;
      Inc(h);
      IF h >= NumberHorz then
      begin
        h := 0;
        Inc(v);
      end;


      x := h * statusframes[i].StatusFrame.Width;
      y := v * statusframes[i].StatusFrame.Height;
      statusframes[i].StatusFrame.Left := x;
      statusframes[i].StatusFrame.top := y;
    End;

    irec := 0;
    i := 0;

    if debug then DataM1.Query3.SQL.SaveToFile(extractfilepath(application.exename) + 'sqllogs\'+'Statusview.sql');
    DataM1.Query3.open;

    if not DataM1.Query3.eof then
    begin
      akted := datam1.Query3.fields[0].AsInteger;
      aktsec := datam1.Query3.fields[1].AsInteger;
    end;


    While Not DataM1.Query3.eof do
    begin
      Itsablank := false;
      IF datam1.Query3.fields[2].Asstring <> '' then
      begin

        IF (akted <> datam1.Query3.fields[0].AsInteger) or (aktsec <> datam1.Query3.fields[1].AsInteger) then
        begin
          IF irec + 1 <= visiblerows then
          begin
            Inc(irec);
            akted := datam1.Query3.fields[0].AsInteger;
            aktsec := datam1.Query3.fields[1].AsInteger;
            l := statusframes[i].StatusFrame.PBExListview1.Items.Add;
            New(PstatusframeData);
            l.Data := PstatusframeData;

            TstatusframeDataType(PstatusframeData^).EditionID := datam1.Query3.fields[0].AsInteger;
            TstatusframeDataType(PstatusframeData^).SectionId := datam1.Query3.fields[1].AsInteger;
            TstatusframeDataType(PstatusframeData^).Itsablank  := true;


            Itsablank := true;
          End;
        end;

        Inc(irec);
        If irec > visiblerows then
        begin
          Inc(i);
          irec := 0;
        end;

        l := statusframes[i].StatusFrame.PBExListview1.Items.Add;
        New(PstatusframeData);
        l.Data := PstatusframeData;


        TstatusframeDataType(PstatusframeData^).Itsablank := false;
        if formsettings.CheckListBoxstatusculmns.Checked[formsettings.CheckListBoxstatusculmns.Items.IndexOf('Sorted')] then
        begin
          TstatusframeDataType(PstatusframeData^).EditionID := datam1.Query3.fields[0].AsInteger;
          TstatusframeDataType(PstatusframeData^).SectionId := datam1.Query3.fields[1].AsInteger;
          TstatusframeDataType(PstatusframeData^).PageIndex := datam1.Query3.fields[2].AsInteger;
          TstatusframeDataType(PstatusframeData^).FTP := datam1.Query3.fields[3].AsInteger;
          TstatusframeDataType(PstatusframeData^).PRE := datam1.Query3.fields[4].AsInteger;
          TstatusframeDataType(PstatusframeData^).INK := datam1.Query3.fields[5].AsInteger;
          TstatusframeDataType(PstatusframeData^).RIP := datam1.Query3.fields[6].AsInteger;
          TstatusframeDataType(PstatusframeData^).Ready := datam1.Query3.fields[7].AsInteger;
          TstatusframeDataType(PstatusframeData^).Appr := datam1.Query3.fields[8].AsInteger;
          TstatusframeDataType(PstatusframeData^).CTP := datam1.Query3.fields[9].AsInteger;
          TstatusframeDataType(PstatusframeData^).Bend := datam1.Query3.fields[10].AsInteger;
          TstatusframeDataType(PstatusframeData^).Sorted := datam1.Query3.fields[11].AsInteger;
          TstatusframeDataType(PstatusframeData^).Preset := datam1.Query3.fields[12].AsInteger;
          TstatusframeDataType(PstatusframeData^).FTPversion := datam1.Query3.fields[13].AsInteger;
          TstatusframeDataType(PstatusframeData^).PREversion := datam1.Query3.fields[14].AsInteger;
          TstatusframeDataType(PstatusframeData^).INKversion := datam1.Query3.fields[15].AsInteger;
          TstatusframeDataType(PstatusframeData^).RIPversion := datam1.Query3.fields[16].AsInteger;
          TstatusframeDataType(PstatusframeData^).Readyversion := datam1.Query3.fields[17].AsInteger;
          TstatusframeDataType(PstatusframeData^).Apprversion := datam1.Query3.fields[18].AsInteger;
          TstatusframeDataType(PstatusframeData^).CTPversion := datam1.Query3.fields[19].AsInteger;

          TstatusframeDataType(PstatusframeData^).Bendversion := datam1.Query3.fields[20].AsInteger;
          TstatusframeDataType(PstatusframeData^).Sortedversion := datam1.Query3.fields[21].AsInteger;
          TstatusframeDataType(PstatusframeData^).Presetversion := datam1.Query3.fields[22].AsInteger;


          l.Caption := DataM1.Query3.Fields[0].AsString;
          l.SubItems.Add(DataM1.Query3.Fields[1].AsString);
          l.SubItems.Add(DataM1.Query3.Fields[2].AsString);

          For iver := 13 to 22 do
            l.SubItems.Add(DataM1.Query3.Fields[iver].AsString);

        End
        else
        begin
          TstatusframeDataType(PstatusframeData^).EditionID := datam1.Query3.fields[0].AsInteger;
          TstatusframeDataType(PstatusframeData^).SectionId := datam1.Query3.fields[1].AsInteger;
          TstatusframeDataType(PstatusframeData^).PageIndex := datam1.Query3.fields[2].AsInteger;
          TstatusframeDataType(PstatusframeData^).FTP := datam1.Query3.fields[3].AsInteger;
          TstatusframeDataType(PstatusframeData^).PRE := datam1.Query3.fields[4].AsInteger;
          TstatusframeDataType(PstatusframeData^).INK := datam1.Query3.fields[5].AsInteger;
          TstatusframeDataType(PstatusframeData^).RIP := datam1.Query3.fields[6].AsInteger;
          TstatusframeDataType(PstatusframeData^).Ready := datam1.Query3.fields[7].AsInteger;
          TstatusframeDataType(PstatusframeData^).Appr := datam1.Query3.fields[8].AsInteger;
          TstatusframeDataType(PstatusframeData^).CTP := datam1.Query3.fields[9].AsInteger;
          TstatusframeDataType(PstatusframeData^).Bend := datam1.Query3.fields[10].AsInteger;
          TstatusframeDataType(PstatusframeData^).Preset := datam1.Query3.fields[11].AsInteger;
          TstatusframeDataType(PstatusframeData^).FTPversion := datam1.Query3.fields[12].AsInteger;
          TstatusframeDataType(PstatusframeData^).PREversion := datam1.Query3.fields[13].AsInteger;
          TstatusframeDataType(PstatusframeData^).INKversion := datam1.Query3.fields[14].AsInteger;
          TstatusframeDataType(PstatusframeData^).RIPversion := datam1.Query3.fields[15].AsInteger;
          TstatusframeDataType(PstatusframeData^).Readyversion := datam1.Query3.fields[16].AsInteger;
          TstatusframeDataType(PstatusframeData^).Apprversion := datam1.Query3.fields[17].AsInteger;
          TstatusframeDataType(PstatusframeData^).CTPversion := datam1.Query3.fields[18].AsInteger;
          TstatusframeDataType(PstatusframeData^).Bendversion := datam1.Query3.fields[19].AsInteger;
          TstatusframeDataType(PstatusframeData^).Presetversion := datam1.Query3.fields[20].AsInteger;
          TstatusframeDataType(PstatusframeData^).Sorted := -1;
          l.Caption := DataM1.Query3.Fields[0].AsString;
          l.SubItems.Add(DataM1.Query3.Fields[1].AsString);
          l.SubItems.Add(DataM1.Query3.Fields[2].AsString);

          For iver := 12 to 20 do
            l.SubItems.Add(DataM1.Query3.Fields[iver].AsString);

        end;


      End;
      DataM1.Query3.next;
    end;
    DataM1.Query3.close;







  Except
  end;
End;









Function TFormStatusView.getthecolor(Status : Longint):Tcolor;
Begin
  result := clwhite;
  Case status of
    0 : result := clwhite;
    1 : result := clYellow;
    2 : result := clGreen;
    3 : result := clRed;
    4 : result := RGB(255,127,39);  //orange
    Else
      result := clwhite;
  end;
End;


procedure TFormStatusView.Refresh1Click(Sender: TObject);
begin
  createvies(ScrollBoxEnhstatus);


end;



procedure TFormStatusView.ActionStatusrefreshExecute(Sender: TObject);
begin
  createvies(ScrollBoxEnhstatus);
end;



procedure TFormStatusView.ActiontestExecute(Sender: TObject);
Var
  I : Longint;
begin
  createvies(ScrollBoxEnhstatus);
//  edit1.Text := inttostr(visiblerows) + ','+inttostr(NumberHorz);
end;

end.
