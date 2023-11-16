unit UStatusframe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, SqlExpr, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  PBExListview;

(*uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, PBExListview;
  *)
type
  TFrameStatus = class(TFrame)
    PBExListview1: TPBExListview;
    procedure FrameCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure PBExListview1CustomDrawSubItem(Sender: TCustomListView;
      Item: TListItem; SubItem: Integer; State: TCustomDrawState;
      var DefaultDraw: Boolean);
    procedure PBExListview1CustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    EditionID : Longint;
    SectionID : Longint;
  end;

implementation

{$R *.dfm}

Uses
  Udata, Umain,UPlateviewframe,utypes;



procedure TFrameStatus.FrameCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
   Resize := true;
end;

procedure TFrameStatus.PBExListview1CustomDrawSubItem(
  Sender: TCustomListView; Item: TListItem; SubItem: Integer;
  State: TCustomDrawState; var DefaultDraw: Boolean);


Function getthecolor(Status : Longint):Tcolor;
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


{Var
  SubitemShowing : Longint;}

begin



  IF (Subitem > 2) And (not TstatusframeDataType(item.data^).Itsablank) then
  Begin

    Case Subitem of
      0 : Begin
            //PBExListview1.Canvas.Font.Color := clblack;
          End;
      1 : Begin
            //PBExListview1.Canvas.brush.Color := clwhite;
            //PBExListview1.Canvas.Font.Color := clblack;
          End;
      2 : Begin
            //PBExListview1.Canvas.brush.Color := clwhite;
            //PBExListview1.Canvas.Font.Color := clblack;
          End;
      3 : Begin
           PBExListview1.Canvas.Brush.color := getthecolor(TstatusframeDataType(item.data^).FTP);
           PBExListview1.Canvas.Font.Color := clwhite;

          end;
      4 : Begin
           PBExListview1.Canvas.Brush.color := getthecolor(TstatusframeDataType(item.data^).PRE);
           PBExListview1.Font.Color := clwhite;
          end;
      5 : Begin
           PBExListview1.Canvas.Brush.color := getthecolor(TstatusframeDataType(item.data^).INK);
           PBExListview1.Font.Color := clwhite;
          end;
      6 : Begin
           PBExListview1.Canvas.Brush.color := getthecolor(TstatusframeDataType(item.data^).RIP);
           PBExListview1.Font.Color := clwhite;
          end;
      7 : Begin
           PBExListview1.Canvas.Brush.color := getthecolor(TstatusframeDataType(item.data^).Ready);
           PBExListview1.Font.Color := clwhite;
          end;
      8 : Begin
           PBExListview1.Canvas.Brush.color := getthecolor(TstatusframeDataType(item.data^).Appr);
           PBExListview1.Font.Color := clwhite;
          end;
      9 : Begin
           PBExListview1.Canvas.Brush.color := getthecolor(TstatusframeDataType(item.data^).CTP);
           PBExListview1.Font.Color := clwhite;
          end;
      10 :Begin
           PBExListview1.Canvas.Brush.color := getthecolor(TstatusframeDataType(item.data^).Bend);
           PBExListview1.Font.Color := clwhite;
          end;
      11 : Begin
           PBExListview1.Canvas.Brush.color := getthecolor(TstatusframeDataType(item.data^).Sorted);
           PBExListview1.Font.Color := clwhite;
          end;
      12 : Begin
             PBExListview1.Canvas.Brush.color := getthecolor(TstatusframeDataType(item.data^).Preset);
             PBExListview1.Font.Color := clwhite;
           End;

      13 : Begin
             PBExListview1.Canvas.Brush.color := RGB(173,216,230);
           End;

    end;
  end
  Else
  Begin
    PBExListview1.Canvas.brush.Color := clwhite;
    PBExListview1.Canvas.Font.Color := clBlack;

  End;
  DefaultDraw := true;
end;





procedure TFrameStatus.PBExListview1CustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  PBExListview1.Canvas.brush.Color := clwhite;
  PBExListview1.Canvas.Font.Color := clBlack;
  DefaultDraw := true;

end;

(*
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

    DataM1.Query3.SQL.Clear;
    DataM1.Query3.SQL.add('select distinct p.editionid,p.sectionid,e.name,s.name from pagetable p, editionnames e, sectionnames s');
    DataM1.Query3.SQL.add('where p.publicationid = '+inttostr(PublicationID));
    DataM1.Query3.SQL.add(' and ' + DataM1.makedatastr('p.',pubdate));

    IF editionid > 0 then
      DataM1.Query3.SQL.add('where p.editionid = '+inttostr(editionID));
    IF sectionid > 0 then
      DataM1.Query3.SQL.add('where p.sectionid = '+inttostr(sectionID));

    DataM1.Query3.SQL.add('and p.editionid = e.editionid and p.sectionid = s.sectionid');
    DataM1.Query3.SQL.add('Order by e.name,s.name');
    IF debug then datam1.Query3.sql.SaveToFile(extractfilepath(application.exename) + 'sqllogs\'+'makestatusview1.sql');
    DataM1.Query3.open;
    While Not DataM1.Query3.eof do
    begin
      Inc(Nstatusframes);
      DataM1.Query3.next
    end;

    DataM1.Query3.close;
    IF Nstatusframes > 0 then
    begin
      setlength(statusframes,Nstatusframes+3);
      Nstatusframes := 0;
      DataM1.Query3.open;
      While Not DataM1.Query3.eof do
      begin
        Inc(Nstatusframes);
        statusframes[Nstatusframes-1].StatusFrame := TFrameStatus.Create(FormStatusView.ScrollBoxEnhstatus);
        statusframes[Nstatusframes-1].StatusFrame.name := 'statusframes'+inttostr(Nstatusframes);
        statusframes[Nstatusframes-1].StatusFrame.parent := FormStatusView.ScrollBoxEnhstatus;
        statusframes[Nstatusframes-1].StatusFrame.editionid := DataM1.Query3.fields[0].Asinteger;
        statusframes[Nstatusframes-1].StatusFrame.sectionid := DataM1.Query3.fields[1].Asinteger;
        DataM1.Query3.next
      end;
      DataM1.Query3.close;

      IF Nstatusframes > 0 then
      begin
        l := statusframes[0].StatusFrame.PBExListview1.Items.Add;
        l.Caption := 'ABXC';
        l := statusframes[0].StatusFrame.PBExListview1.Items.Add;
        l.Caption := 'ABXC';
        singleh := statusframes[0].StatusFrame.PBExListview1.Items[1].position.y - statusframes[0].StatusFrame.PBExListview1.Items[0].position.y ;
      end;
      statusframes[0].StatusFrame.PBExListview1.Items.clear;



      For i := 0 to Nstatusframes-1 do
      Begin
        DataM1.Query3.SQL.clear;
        DataM1.Query3.SQL.add('exec spPageStatusList');
        DataM1.Query3.SQL.add('@PublicationID = '+inttostr(Publicationid)+',');
        DataM1.Query3.SQL.add('@PubDate = :pubdate ,'); //+DataM1.makedatastr('',pubdate) + ' ,'

        DataM1.Query3.SQL.add('@editionID = '+inttostr(statusframes[i].StatusFrame.editionid)+',');
        DataM1.Query3.SQL.add('@sectionid = '+inttostr(statusframes[i].StatusFrame.sectionid)+',');
        DataM1.Query3.SQL.add('@PressID  = 0,');
        DataM1.Query3.SQL.add('@HideDone  = 0,');
        DataM1.Query3.SQL.add('@EmulateBender  = 1,');
        IF Aktpressgrpid > 0 then
          DataM1.Query3.SQL.add('@PressGroupID = ' + inttostr(Aktpressgrpid)  )
        Else
          DataM1.Query3.SQL.add('@PressGroupID = 0'  );
        DataM1.Query3.ParamByName('pubdate').AsDateTime := pubdate;
        IF debug then datam1.Query3.sql.SaveToFile(extractfilepath(application.exename) + 'sqllogs\'+'makestatusview2.sql');
        DataM1.Query3.open;
        While Not DataM1.Query3.eof do
        begin
          l := statusframes[i].StatusFrame.PBExListview1.Items.Add;
          New(PstatusframeData);
          l.Data := PstatusframeData;

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


          l.Caption := DataM1.Query3.Fields[0].AsString;
          l.SubItems.Add(DataM1.Query3.Fields[1].AsString);
          l.SubItems.Add(DataM1.Query3.Fields[2].AsString);

          For iver := 12 to 20 do
            l.SubItems.Add(DataM1.Query3.Fields[iver].AsString);

          DataM1.Query3.next;
        end;
        DataM1.Query3.close;

      End;




    end;
    repositionframes;
    *)



end.
