unit ULinkToMaster;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ComCtrls, Vcl.StdCtrls, PBExListview;

type
  TFormLinkToMaster = class(TForm)
    BitBtnCancel: TBitBtn;
    BitBtnOK: TBitBtn;
    ListView1: TListView;
    Label1: TLabel;
    Label2: TLabel;
    EditSelectedPage: TEdit;
    CheckBoxSetCommon: TCheckBox;
    Label3: TLabel;
    procedure BitBtnOKClick(Sender: TObject);
  private
    { Private declarations }
  public

    CopySeparationSet : Integer;
    PressIDSlave : Integer;
    PressGroupIDSlave : Integer;
    RipPressIDSlave : Integer;

    procedure InitFormData(CopySeparationSetIn : Integer);
  end;

  TDataCopy = array[1..4] of Record
        ColorID : Integer;
        Status : Integer;
        ProofStatus : Integer;
        Approved : Integer;
        InputTime : TDateTime;
        Version : Integer;
        InputID : Integer;
        FileServer : string;
        Filename : string;
        InputProcessID : Integer;
        EmailStatus : Integer;
        Active : Integer;
        PageType : Integer;
        UniquePage : Integer;
        RipSetupID : Integer;
        PageFormatID : Integer;
  end;

var
  FormLinkToMaster: TFormLinkToMaster;

implementation

uses Udata,umain,utypes,dateutils, Usettings, Ulogin, UUtils;

{$R *.dfm}

procedure TFormLinkToMaster.BitBtnOKClick(Sender: TObject);
var
  i : Integer;
  PDFMaster, MasterCopySeparationSet,PressGroupID, PressID : Integer;
  RipPress : string;
  Press, s : string;
  CopyData : TDataCopy;
  ColorID : Integer;
  UniquePage : Integer;
begin
  RipPress := '';
  PDFMaster := 0;
  MasterCopySeparationSet := 0;
  PressGroupID := 0;

  for ColorID:= 1 to 4 do
  begin
    CopyData[ColorID].ColorID := 0;
  end;


  for i := 0 to ListView1.Items.Count-1 do
  begin
    if ListView1.Items[i].Selected then
    begin
      RipPress := ListView1.Items[i].Caption;
      PressID := tnames1.pressnametoid(ListView1.Items[i].SubItems[0]);
      PDFMaster := StrToInt(ListView1.Items[i].SubItems[4]);
      MasterCopySeparationSet := StrToInt(ListView1.Items[i].SubItems[5]);
      break;
    end;
  end;
  try
    if (PDFMaster > 0) and (MasterCopySeparationSet > 0)  then
    begin
      // Lookup
      DataM1.Query1.SQL.Clear();
      if (RipPress <> '') then
        DataM1.Query1.SQL.Add('SELECT TOP 1 PressGroupID FROM PressGroupNames WHERE PressGroupName='''+RipPress+'''')
      else
        DataM1.Query1.SQL.Add('SELECT TOP 1 PressGroupID FROM PressGroupNames WHERE PressID=' + IntToStr(PressID));

      DataM1.Query1.Open();
      if not DataM1.Query1.Eof then
        PressGroupID := DataM1.Query1.Fields[0].AsInteger;
      DataM1.Query1.Close();
      // Get page data from master
      DataM1.Query1.SQL.Clear();
      DataM1.Query1.SQL.Add('SELECT DISTINCT P1.ColorID, P1.Status, P1.ProofStatus,P1.Approved');
      DataM1.Query1.SQL.Add(',P1.InputTime, P1.Version,P1.InputID,P1.FileServer,P1.FileName');
      DataM1.Query1.SQL.Add(',P1.InputProcessID,P1.EmailStatus,P1.Active,P1.PageType');
      DataM1.Query1.SQL.Add(',P1.UniquePage,ISNULL(P1.RipSetupID,0),ISNULL(P1.PageFormatID,0)');
      DataM1.Query1.SQL.Add('FROM PageTable P1 WITH (NOLOCK)');
      DataM1.Query1.SQL.Add('WHERE P1.PDFMaster='+IntToStr(PDFMaster));
      DataM1.Query1.SQL.Add('AND P1.MasterCopySeparationSet='+IntToStr(MasterCopySeparationSet));
      DataM1.Query1.SQL.Add('AND P1.PressID='+IntToStr(PressID));
      DataM1.Query1.SQL.Add('AND P1.Dirty=0');
      DataM1.Query1.Open();
      while not DataM1.Query1.Eof do
      begin
        ColorID := DataM1.Query1.Fields[0].AsInteger;
        CopyData[ColorID].ColorID := ColorID;
        CopyData[ColorID].Status := DataM1.Query1.Fields[1].AsInteger;
        CopyData[ColorID].ProofStatus := DataM1.Query1.Fields[2].AsInteger;
        CopyData[ColorID].Approved := DataM1.Query1.Fields[3].AsInteger;
        CopyData[ColorID].InputTime := DataM1.Query1.Fields[4].AsDateTime;
        CopyData[ColorID].Version := DataM1.Query1.Fields[5].AsInteger;
        CopyData[ColorID].InputID := DataM1.Query1.Fields[6].AsInteger;
        CopyData[ColorID].FileServer := DataM1.Query1.Fields[7].AsString;
        CopyData[ColorID].FileName := DataM1.Query1.Fields[8].AsString;
        CopyData[ColorID].InputProcessID := DataM1.Query1.Fields[9].AsInteger;
        CopyData[ColorID].EmailStatus := DataM1.Query1.Fields[10].AsInteger;
        CopyData[ColorID].Active := DataM1.Query1.Fields[11].AsInteger;
        CopyData[ColorID].PageType := DataM1.Query1.Fields[12].AsInteger;
        CopyData[ColorID].UniquePage := DataM1.Query1.Fields[13].AsInteger;
        CopyData[ColorID].RipSetupID := DataM1.Query1.Fields[14].AsInteger;
        CopyData[ColorID].PageFormatID := DataM1.Query1.Fields[15].AsInteger;
        DataM1.Query1.Next();
      end;
      DataM1.Query1.Close();
      for ColorID := 1 to 4 do
      begin
        if (CopyData[ColorID].ColorID = 0) then
          continue;
        DataM1.Query1.SQL.Clear();
        if (PressGroupID = PressGroupIDSlave) then
        begin
           if (CopyData[ColorID].UniquePage = 1) then
           begin
             if (CheckboxSetCommon.Checked) then
                CopyData[ColorID].UniquePage := 0
             else
                CopyData[ColorID].UniquePage := 2;
           end;

           if (CopyData[ColorID].Status > 30) then
             CopyData[ColorID].Status := 30;

           DataM1.Query1.SQL.Add('UPDATE PageTable SET MasterCopySeparationSet='+IntToStr(MasterCopySeparationSet));
           DataM1.Query1.SQL.Add(',PDFMaster='+IntToStr(PDFMaster));
           DataM1.Query1.SQL.Add(',Status='+ IntToStr(CopyData[ColorID].Status));
           DataM1.Query1.SQL.Add(',ProofStatus='+ IntToStr(CopyData[ColorID].ProofStatus));
           DataM1.Query1.SQL.Add(',Approved='+ IntToStr(CopyData[ColorID].Approved));
           DataM1.Query1.SQL.Add(',Version='+ IntToStr(CopyData[ColorID].Version));
            DataM1.Query1.SQL.Add(',InputTime= :InputTime');
           DataM1.Query1.SQL.Add(',InputID='+ IntToStr(CopyData[ColorID].InputID));
           DataM1.Query1.SQL.Add(',InputProcessID='+ IntToStr(CopyData[ColorID].InputProcessID));
           DataM1.Query1.SQL.Add(',EmailStatus='+ IntToStr(CopyData[ColorID].EmailStatus));
           DataM1.Query1.SQL.Add(',Active='+ IntToStr(CopyData[ColorID].Active));
           DataM1.Query1.SQL.Add(',PageType='+ IntToStr(CopyData[ColorID].PageType));
           DataM1.Query1.SQL.Add(',UniquePage='+ IntToStr(CopyData[ColorID].UniquePage));
           DataM1.Query1.SQL.Add(',RipSetupID='+ IntToStr(CopyData[ColorID].RipSetupID));

           DataM1.Query1.SQL.Add(',PageFormatID='+ IntToStr(CopyData[ColorID].PageFormatID));
           DataM1.Query1.SQL.Add(',FileServer='''+ CopyData[ColorID].FileServer + '''');
           DataM1.Query1.SQL.Add(',FileName='''+ CopyData[ColorID].FileName + '''');
           DataM1.Query1.SQL.Add('WHERE CopySeparationSet=' + IntToStr(CopySeparationSet));
           DataM1.Query1.SQL.Add('AND ColorID=' + IntToStr(ColorID));
            DataM1.Query1.ParamByName('InputTime').AsDateTime := CopyData[ColorID].InputTime;
         //  Datam1.Query1.SQL.SaveToFile(ExtractFilePath(application.exename) + 'sqllogs\'+'LinkToMaster');
        end
        else
        begin

          DataM1.Query1.SQL.Add('UPDATE PageTable SET PDFMaster='+IntToStr(PDFMaster));

          DataM1.Query1.SQL.Add(',Approved='+ IntToStr(CopyData[ColorID].Approved));

          DataM1.Query1.SQL.Add(',RipSetupID='+ IntToStr(CopyData[ColorID].RipSetupID));

          DataM1.Query1.SQL.Add(',PageFormatID='+ IntToStr(CopyData[ColorID].PageFormatID));

          DataM1.Query1.SQL.Add(',Status=0, Version=0,ProofStatus=0');

          DataM1.Query1.SQL.Add('WHERE CopySeparationSet= ' +IntToStr(CopySeparationSet));

          DataM1.Query1.SQL.Add('AND ColorID=' + IntToStr(ColorID));

        end;

        //FormMain.TrySql(Datam1.Query1);

        Datam1.Query1.ExecSql;

        Datam1.Query1.Close;


      end;
    end;
  except
          on E: Exception do
          begin
             s := e.Message;
             MessageDlg(s, mtError,[mbOk], 0);

          end;
   // FormMain.WriteLog('Exception in LinkToMaster');
  end;

end;

procedure TFormLinkToMaster.InitFormData(CopySeparationSetIn : Integer);
var
    ListItem : TListItem;
    s,s2      : string;
    PubDate  : TDateTime;
    PublicationID : Integer;
    EditionID : Integer;
    SectionID : Integer;
    PageName : string;
    PressGroupSlave : string;
begin
    CopySeparationSet :=  CopySeparationSetIn;
    ListView1.Items.Clear();
    s := '';
    PressGroupIDSlave := 0;
    PressIDSlave := 0;
    RipPressIDSlave := 0;
    PressGroupSlave := '';
    PublicationID := 0;
    SectionID := 0;

    // Determine 'slave page' data

    DataM1.Query1.SQL.Clear();
    DataM1.Query1.SQL.Add('SELECT TOP 1 PR.PressName,P.PubDate,PUB.Name,ED.Name,SEC.Name,P.PageName,P.PublicationID, P.EditionID, P.SectionID, P.PressID, P.PlateStatus');
    if (PressGroupNamesPossible) then
    begin
      DataM1.Query1.SQL.Add(', ISNULL(PG.PressGroupID,0)');           // derived from pressID
      DataM1.Query1.SQL.Add(', ISNULL(PG2.PressGroupID,0)');          // derived from platestatus
      DataM1.Query1.SQL.Add(', ISNULL(PG.PressGroupName,'''')');
      DataM1.Query1.SQL.Add(', ISNULL(PG2.PressGroupName,'''')');
    end;
    DataM1.Query1.SQL.Add('FROM PageTable P WITH (NOLOCK)');
    DataM1.Query1.SQL.Add('INNER JOIN PublicationNames PUB ON PUB.PublicationID=P.PublicationID');
    DataM1.Query1.SQL.Add('INNER JOIN EditionNames ED ON ED.EditionID=P.EditionID');
    DataM1.Query1.SQL.Add('INNER JOIN SectionNames SEC ON SEC.SectionID=P.SectionID');
    DataM1.Query1.SQL.Add('INNER JOIN PressNames PR ON PR.PressID=P.PressID');
    if (PressGroupNamesPossible) then
    begin
      DataM1.Query1.SQL.Add('LEFT OUTER JOIN PressGroupNames PG ON PG.PressID=P.PressID');
      DataM1.Query1.SQL.Add('LEFT OUTER JOIN PressGroupNames PG2 ON PG2.PressGroupID=P.PlateStatus');
    end;
    DataM1.Query1.SQL.Add('WHERE P.CopySeparationSet=' + IntToStr(CopySeparationSet));
    DataM1.Query1.SQL.Add('AND P.Dirty=0');
    DataM1.Query1.Open();
    if not DataM1.Query1.Eof then
    begin
      s := 'Press: ' + DataM1.Query1.Fields[0].AsString;
      PubDate := DataM1.Query1.Fields[1].AsDateTime;
      s := s + ' ' + DateToStr(PubDate);
      s := s + ' ' + DataM1.Query1.Fields[2].AsString;
      s := s + ' Ed:' + DataM1.Query1.Fields[3].AsString;
      s := s + ' Sec:' + DataM1.Query1.Fields[4].AsString;
      PageName :=  DataM1.Query1.Fields[5].AsString;
      s := s + ' Pg:' + PageName;
      PublicationID :=  DataM1.Query1.Fields[6].AsInteger;
      EditionID :=  DataM1.Query1.Fields[7].AsInteger;
      SectionID :=  DataM1.Query1.Fields[8].AsInteger;
      PressIDSlave :=  DataM1.Query1.Fields[9].AsInteger;
      RipPressIDSlave :=  DataM1.Query1.Fields[10].AsInteger;
      if (PressGroupNamesPossible) then
      begin
        PressGroupIDSlave := DataM1.Query1.Fields[12].AsInteger;
        PressGroupSlave := DataM1.Query1.Fields[14].AsString;
        if (PressGroupIDSlave = 0) then
        begin
          PressGroupIDSlave :=  DataM1.Query1.Fields[11].AsInteger;
          PressGroupSlave := DataM1.Query1.Fields[13].AsString;
        end;
      end;
      s := ' PressGroup: ' + PressGroupSlave + ' ' + s;
    end;
    DataM1.Query1.Close();
    EditSelectedPage.Text := s;
    // Look for potential masters
    DataM1.Query1.SQL.Clear();
    DataM1.Query1.SQL.Add('SELECT DISTINCT PR.PressName,ED.Name,SEC.Name,P.PageName,P.PDFMaster, P.MasterCopySeparationSet');
    if (PressGroupNamesPossible) then
      DataM1.Query1.SQL.Add(', ISNULL(PG.PressGroupName,''''), ISNULL(PG2.PressGroupName,'''')');
    DataM1.Query1.SQL.Add('FROM PageTable P WITH (NOLOCK)');
    DataM1.Query1.SQL.Add('INNER JOIN EditionNames ED ON ED.EditionID=P.EditionID');
    DataM1.Query1.SQL.Add('INNER JOIN SectionNames SEC ON SEC.SectionID=P.SectionID');
    DataM1.Query1.SQL.Add('INNER JOIN PressNames PR ON PR.PressID=P.PressID');
    if (PressGroupNamesPossible) then
    begin
      DataM1.Query1.SQL.Add('LEFT OUTER JOIN PressGroupNames PG ON PG.PressID=P.PressID');
      DataM1.Query1.SQL.Add('LEFT OUTER JOIN PressGroupNames PG2 ON PG2.PressGroupID=P.PlateStatus');
    end;
    DataM1.Query1.SQL.Add('WHERE P.PublicationID=' + IntToStr(PublicationID));
    DataM1.Query1.SQL.add('AND '+ DataM1.makedatastr('P.',PubDate));
    DataM1.Query1.SQL.Add('AND P.SectionID=' + IntToStr(SectionID));
    DataM1.Query1.SQL.Add('AND P.PageName=''' + PageName + '''');
    DataM1.Query1.SQL.Add('AND P.UniquePage<>0');
    DataM1.Query1.SQL.Add('AND P.Dirty=0');
    DataM1.Query1.SQL.Add('ORDER BY PR.PressName, ED.Name' );
    DataM1.Query1.Open();
    while not DataM1.Query1.Eof do
    begin
      s := '';
      if (PressGroupNamesPossible) then
      begin
        s := DataM1.Query1.fields[6].AsString;
        s2 := DataM1.Query1.fields[7].AsString;
        if (s2 <> '') then
          s := s2;
      end;
      ListItem := ListView1.Items.Add();
      ListItem.Caption := s;
      ListItem.SubItems.Add(DataM1.Query1.Fields[0].AsString);
      ListItem.SubItems.Add(DataM1.Query1.Fields[1].AsString);
      ListItem.SubItems.Add(DataM1.Query1.Fields[2].AsString);
      ListItem.SubItems.Add(DataM1.Query1.Fields[3].AsString);
      ListItem.SubItems.Add(IntToStr(DataM1.Query1.Fields[4].AsInteger));
      ListItem.SubItems.Add(IntToStr(DataM1.Query1.Fields[5].AsInteger));
      DataM1.Query1.Next();
    end;
end;

end.
