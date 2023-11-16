unit UGenExcelrep;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls;
type
  TFormGenCCrep = class(TForm)
    Panel1: TPanel;
    Image4: TImage;
    Label2: TLabel;
    Labelaktrep: TLabel;
    Panelbut: TPanel;
    ListView1: TListView;
    MailCC: TEdit;
    Label87: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    MailTo: TEdit;
    Label85: TLabel;
    Label86: TLabel;
    MailSubject: TEdit;
    RadioGroupEmail: TRadioGroup;
    CheckBoxSaveExcel: TCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure ListView1SelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure BitBtn1Click(Sender: TObject);
    procedure ListView1Compare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure RadioGroupEmailClick(Sender: TObject);
  private
    procedure QueueReport();
    procedure loadlist;
  public
    { Public declarations }
  end;
var
  FormGenCCrep: TFormGenCCrep;
implementation
uses Udata, Usettings, Umain, UFormReportgenrutines,utypes;
{$R *.dfm}
Var
  publlist : array[0..1000] of record
                                 publid       : Integer;
                                 pubdate      : TDateTime;
                                 Productionid : Integer;
                                 Pressid      : Integer;
                               end;
procedure TFormGenCCrep.LoadList;
Var
  l : tlistitem;
  T : String;
  i : Integer;
  WTree : TTreenode;
  ProductionID, PressID : Integer;
  PubDate : TDateTime;
Begin
  try
    ListView1.Items.BeginUpdate;
    ListView1.Items.clear;
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('SELECT DISTINCT P1.Pubdate, p1.publicationid, P2.Name, P1.ProductionID, P1.PressID FROM PageTable P1 (NOLOCK)');
    DataM1.Query1.SQL.Add('INNER JOIN PublicationNames p2 ON  p1.publicationid = p2.publicationid');
    DataM1.Query1.SQL.Add('WHERE p1.dirty = 0 ');
    if Pressvisibilylimited then
      datam1.Query1.SQL.Add('AND P1.PressID IN ' + PressvisibilyIN);
    // Can be build out some day..
    case FormMain.PageControlMain.ActivePageIndex of
      VIEW_REPORTS : WTree := FormMain.TreeViewreportfilter.Selected;
    end;
    Datam1.Query1.SQL.Add('AND P1.Pubdate = :Pubdate');
    if (WTree.Level > 1) then
      Datam1.Query1.SQL.Add('AND P1.PublicationID = ' + IntToStr(TTreeViewpagestype(WTree.data^).publicationid));
(*
    case WTree.Level of
        0 : ;
        1 :   begin
                datam1.Query1.SQL.Add('and p1.pubdate = ''' + FormatDateTime('YYYY-MM-DD', TTreeViewpagestype(WTree.data^).pubdate) + '''');
              end;
        2..4 :begin
                Datam1.Query1.SQL.Add('AND P1.PublicationID = ' + IntToStr(TTreeViewpagestype(WTree.data^).publicationid));
                datam1.Query1.SQL.Add('and p1.pubdate = ''' + FormatDateTime('YYYY-MM-DD', TTreeViewpagestype(WTree.Parent.data^).pubdate) + '''');
              end;
    End;
  *)
    DataM1.Query1.SQL.Add('ORDER BY P1.Pubdate,P2.Name,P1.PressID');
    // NAN Tolerant for french dates...
    if (WTree.Level = 1) then
      Datam1.Query1.ParamByName('Pubdate').AsDate := TTreeViewpagestype(WTree.data^).pubdate
    else
      Datam1.Query1.ParamByName('Pubdate').AsDate := TTreeViewpagestype(WTree.Parent.data^).pubdate;
    FormMain.Tryopen(DataM1.Query1);
    While not DataM1.Query1.Eof do
    begin
      PubDate :=  DataM1.Query1.fields[0].AsDateTime;
      ProductionID :=  DataM1.Query1.Fields[3].AsInteger;
      PressID := DataM1.Query1.Fields[4].AsInteger;
      l := ListView1.Items.Add;
      l.Caption := DateToStr(PubDate);
      T := DataM1.Query1.Fields[2].AsString; // Pub
      T := Formmain.Publextratextonproduction(ProductionID, t);
      l.SubItems.Add(T);
      l.SubItems.Add(tnames1.pressnameIDtoname(PressID));
      IF Not PressGroupNamesPossible then
      Begin
        l.SubItems.Add('');
      End
      Else
      begin
        IF Pressvisibilylimited then
        begin
          l.SubItems.Add(Formmain.ComboBoxPressGrp.Text);
        End
        Else
        Begin
          DataM1.Query2.SQL.clear;
          DataM1.Query2.SQL.Add('SELECT DISTINCT P1.PressID, P2.PressGroupName FROM PageTable P1 WITH (NOLOCK)');
          DataM1.Query2.SQL.Add('INNER JOIN PressGroupNames P2 (NOLOCK) ON P2.PressID = P1.PressID');
          DataM1.Query2.SQL.Add('WHERE P1.ProductionID = ' + IntToStr(ProductionID));
          DataM1.Query2.Open;
          IF Not DataM1.Query2.eof then
            l.SubItems.Add(DataM1.Query2.fields[1].asstring)
          Else
            l.SubItems.Add('');
          DataM1.Query2.close;
        End;
      end;
      publlist[ListView1.Items.count - 1].publid := DataM1.Query1.fields[1].asinteger;
      publlist[ListView1.Items.count - 1].pubdate := PubDate;
      publlist[ListView1.Items.count - 1].Productionid := ProductionID;
      publlist[ListView1.Items.count - 1].PressID := PressID;
      DataM1.Query1.Next;
    end;
    for i := 1 to Listview1.Columns.Count - 1 do
      Listview1.Columns[i].Width := -1;
    ListView1.Items.EndUpdate;
    DataM1.Query1.close;
    ListView1.SetFocus;
    BitBtn1.Enabled := ListView1.Selected <> nil;
  Except
  end;
end;

procedure TFormGenCCrep.RadioGroupEmailClick(Sender: TObject);
begin
  MailTo.Enabled := (RadioGroupEmail.ItemIndex <> 0);
  MailCC.Enabled := (RadioGroupEmail.ItemIndex <> 0);
  MailSubject.Enabled := (RadioGroupEmail.ItemIndex <> 0);

end;

procedure TFormGenCCrep.FormActivate(Sender: TObject);
begin
  LoadList();
  CheckBoxSaveExcel.Enabled := Prefs.DefaultReportFolder <> '';
  CheckBoxSaveExcel.Checked := (Prefs.DefaultReportFolder <> '') and (Prefs.DefaultSaveToLocalFolder);
  RadioGroupEmailClick(nil);
  RadioGroupEmail.ItemIndex :=  Prefs.ExcelEmailOption;
  MailTo.Text := Prefs.DefaultExcelEmailTO;
  MailCC.Text := Prefs.DefaultExcelEmailCC;
  MailSubject.Text := Prefs.DefaultExcelEmailSUBJ;
end;
procedure TFormGenCCrep.ListView1SelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  BitBtn1.Enabled := ListView1.Selected <> nil;
end;

Procedure TFormGenCCrep.QueueReport;
Var
  T            : String;
  Iitem,
  publid       : Longint;
  pubdate      : tdatetime;
  productionid : Longint;
  resulttat    : integer;
  pressid, i,
  locationid,
  statid,
  mrres,
  Pressrunid   : Longint;
  sendemail    : Boolean;
  emaladress,
  SMailTo,
  SMailCC,
  SMailSu,
  SMailUp,
  SMailBo      : string;
  saveFolder   : string;
  hasselectedoutputfolder : boolean;
begin
  try
    hasselectedoutputfolder := false;
    SMailTo := '';
    SMailCC := '';
    SMailSu := '';
    SMailBo := '';
    SMailUp := '';
    saveFolder := '';
    For Iitem := 0 to ListView1.items.Count - 1 do
    begin
      IF ListView1.Items[Iitem].Selected then
      Begin
        productionid := -1;
        publid  := publlist[Iitem].publid;
        pubdate := publlist[Iitem].pubdate;

        Labelaktrep.caption := tnames1.publicationIDtoname(publid) + '   ' + datetostr(pubdate);
        Labelaktrep.Repaint;
        Application.ProcessMessages;
        ProductionID := publlist[Iitem].ProductionID;
        Pressrunid := 0;
    (*    DataM1.Query1.SQL.Clear;
        DataM1.Query1.SQL.add('Select distinct productionid from pagetable WITH (NOLOCK)');
        DataM1.Query1.SQL.add('where publicationid = '+IntToStr(publid));
        DataM1.Query1.SQL.add('and '+  DataM1.makedatastr('pagetable.', pubdate));
        DataM1.Query1.SQL.add('and PressID = ' + IntToStr(publlist[Iitem].pressID));
        DataM1.Query1.Open;
        IF not DataM1.Query1.eof then
          ProductionID := DataM1.Query1.fields[0].asinteger;
        DataM1.Query1.Close;
         *)
        if (RadioGroupEmail.ItemIndex = 1) then //Hvis det er std mail så finder vi mail mm
        Begin
          DataM1.Query1.SQL.Clear;
          DataM1.Query1.SQL.add('Select TOP 1 CustomerEmail, CustomerEmailCC, CustomerEmailSubject, CustomerEmailBody, UploadPath, CustomerNames.CustomerID, PublicationNames.CustomerID from PublicationNames (NOLOCK)');
          DataM1.Query1.SQL.add('Inner Join CustomerNames ON CustomerNames.CustomerID = PublicationNames.CustomerID');
          DataM1.Query1.SQL.add('where PublicationNames.PublicationID = ' + inttostr(publid));
//          DataM1.Query1.SQL.SaveToFile('SendMailTo.sql');
          DataM1.Query1.Open;
          if NOT DataM1.Query1.Eof then
          Begin
            SMailTo := DataM1.Query1.FieldByName('CustomerEmail').AsString;
            SMailCC := DataM1.Query1.FieldByName('CustomerEmailCC').AsString;
            SMailSu := DataM1.Query1.FieldByName('CustomerEmailSubject').AsString;
            SMailBo := DataM1.Query1.FieldByName('CustomerEmailBody').AsString;
            SMailUp := DataM1.Query1.FieldByName('UploadPath').AsString;
          End else
          Begin
            ShowMessage('Standard e-mail address is not set for this publication: ' + tnames1.publicationIDtoname(publid) );
//                        'Please set this in the menubar "Configuration - Configure jobnames".' + sLineBreak +
//                        'Select publication ' + tnames1.publicationIDtoname(publid) + ' and set the correct email in "Customer".' + sLineBreak + sLineBreak +
//                        'Or just uncheck "' + CheckBoxSendToStd.Caption + '" and enter an email address.');
            DataM1.Query1.Close;
            Exit;
          End;
          DataM1.Query1.Close;
        End else if (RadioGroupEmail.ItemIndex = 2) then
        Begin
          SMailTo := MailTo.text;
          SMailCC := MailCC.text;
          SMailSu := MailSubject.text;
        End;

        //if SMailTo = '' then
        //  ShowMessage('Please enter an email address');
        if (CheckBoxSaveExcel.Checked) and (not hasselectedoutputfolder) then
        begin
          with TFileOpenDialog.Create(nil) do
          try
            Options := [fdoPickFolders];
            Title := 'Select Excel save folder';
            if Execute then
            begin
              saveFolder := FileName;
              hasselectedoutputfolder := true;
            end;
          finally
            Free;
          end;
        end;
        FormReportgenrutines.GenerateProductionReport(ProductionID,
                                                      PressrunID,
                                                      saveFolder,
                                                      RadioGroupEmail.ItemIndex <> 0,
                                                      SMailTo,
                                                      SMailCC,
                                                      SMailSu,
                                                      CheckBoxSaveExcel.Checked);
        DataM1.Query1.close;
      End;
    end;
    Application.ProcessMessages;
    Sleep(2000);
  Finally
  end;
  loadlist;
end;

procedure TFormGenCCrep.BitBtn1Click(Sender: TObject);
Begin
  QueueReport();
end;
procedure TFormGenCCrep.ListView1Compare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
var
  ix: Integer;
begin
  Compare := 0;
  if (Item1 <> nil) and (Item2 <> nil) then
  begin
    IF (Item1.SubItems.Count > 1) and (Item2.SubItems.Count > 1) then
    Begin
      Compare := CompareText(Item1.SubItems[2],Item2.SubItems[2]);
      IF Compare < 0 then
      begin
        Compare := CompareText(Item1.SubItems[1],Item2.SubItems[1]);
      end;
    End;
  End;
end;

end.

