unit UWorkerThreadUnknownPages;

interface

uses
  System.Classes, Vcl.ComCtrls,System.SysUtils, WinApi.ActiveX;

type
  TWorkerThreadUnknownPages = class(TThread)

    private
      unknownPagesList : TStringList;

    protected
      procedure Execute; override;
      procedure UpdateUnknownPagesListView;

    public
      terminateThread : Boolean;
      constructor Create;
  end;

implementation

uses
  UMain, Udata, Uprefs, UTypes;

{ TWorkerThreadUnknownPages }
constructor TWorkerThreadUnknownPages.Create;
begin
  inherited create(false);
  terminateThread := false;
  unknownPagesList := TStringList.Create;
 // CoInitialize(Nil);
end;

//
procedure TWorkerThreadUnknownPages.Execute;
var
  w : Integer;
  s1 : string;
  s2 : string;
  t : string;
  List: TStringList;
begin

  while (not terminateThread) do
  begin

    if (not Prefs.ShowPanelUnknownFiles) then
    begin
      Sleep(1000);
      continue;
    end;

    try
      List := TStringList.Create;
      unknownPagesList.Clear;

      if (Datam1.ConnectToServerErrorFileThread())  then
      begin

        try

          Datam1.QueryWorkerThreadUnknownPages.SQL.Clear;
          Datam1.QueryWorkerThreadUnknownPages.SQL.Add('exec spGetAllUnplannedPages');
          if (Prefs.GetAllUnplannedPagesMode>0) then
            Datam1.QueryWorkerThreadUnknownPages.SQL.Add('@Mode='+IntToStr(Prefs.GetAllUnplannedPagesMode));

          Datam1.QueryWorkerThreadUnknownPages.Open;
          while not Datam1.QueryWorkerThreadUnknownPages.Eof do
          begin
             s1 := Datam1.QueryWorkerThreadUnknownPages.Fields[0].AsString;
             s2 := Datam1.QueryWorkerThreadUnknownPages.Fields[1].AsString;
             // @OPB-300322-1-A-068-1.pdf
             if (s2 = '') then
             begin
               List.Clear;
               s2 := IncludeTrailingBackslash(Prefs.PDFArchivefolder);
               ExtractStrings(['-'], [], PChar(s1), List);
               if (List.count > 1) then
               begin
                  t := List[1];
                  if (t.Length = 6) then
                  begin
                    s2 := IncludeTrailingBackslash(s2);
                    s2 := s2 + '20' + Copy(t,5,2) + '-' + Copy(t,3,2) + '-' + Copy(t,1,2)
                  end;
               end;
              if ( List.count > 0) then
              begin
                s2 := IncludeTrailingBackslash(s2);
                s2 := s2 + List[0];
              end;
             end;


            unknownPagesList.Add(s1 + ';' + s2);
            Datam1.QueryWorkerThreadUnknownPages.Next;
          end;
          Datam1.QueryWorkerThreadUnknownPages.Close;

        except
          on E: Exception do
          begin
            FormMain.writeinitlog('Unable to connect to server (SQLConnectionTreestate) - ' + e.Message);
          end;
        end;


        Synchronize(UpdateUnknownPagesListView);
      end;
    finally
      if (Datam1.QueryWorkerThreadUnknownPages.Active) then   // ?
        Datam1.QueryWorkerThreadUnknownPages.Close;
      List.Free;
      Datam1.DisConnectFromServerErrorFileThread();
    end;

    for w:= 1 to Prefs.ShowPanelUnknownFilesRefreshTime * 60 do
    begin
      Sleep(1000);
      if (terminateThread) then
        break;
    end;

  end;
  unknownPagesList.Free;
  //CoUninitialize();
end;

procedure TWorkerThreadUnknownPages.UpdateUnknownPagesListView;
var
  t : string;
  listItem : TListItem;
  List: TStringList;
begin
    if (not FormMain.GroupBox3.Visible) then
      exit;

    List := TStringList.Create;

    try
      FormMain.ListViewUnknownPage.Items.BeginUpdate;
      FormMain.ListViewUnknownPage.Items.Clear;
      for t in unknownPagesList do
      begin
        List.Clear;
        ExtractStrings([';'], [], PChar(t), List);
        listItem := FormMain.ListViewUnknownPage.Items.Add;
        listItem.Caption := List[0];
        if (List.Count>1) then
          listItem.SubItems.Add(List[1])
        else
          listItem.SubItems.Add('');
      end;
    finally
      FormMain.ListViewUnknownPage.Items.EndUpdate;
      List.Free;
    end;
end;

end.
