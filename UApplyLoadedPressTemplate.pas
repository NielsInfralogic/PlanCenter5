unit UApplyLoadedPressTemplate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Buttons;

type
  TFormApplyLoadedPressTemplate = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel3: TPanel;
    Image2: TImage;
    Label7: TLabel;
    Label8: TLabel;
    Label5: TLabel;
    ComboBoxPressTemplate1: TComboBox;
    Label10: TLabel;
    ComboBoxPressTemplate2: TComboBox;
    Label15: TLabel;
    ComboBoxPressTemplate3: TComboBox;
    Label16: TLabel;
    ComboBoxpublication: TComboBox;
    Label2: TLabel;
    DateTimePicker1loadplan: TDateTimePicker;
    Label14: TLabel;
    UpDownweek: TUpDown;
    Editweek: TEdit;
    Label1: TLabel;
    EditNumerOfPages: TEdit;
    Label4: TLabel;
    Label6: TLabel;
    PanelInserted1: TPanel;
    RadioButtonInserted1a: TRadioButton;
    RadioButtonInserted1b: TRadioButton;
    PanelInserted2: TPanel;
    RadioButtonInserted2a: TRadioButton;
    RadioButtonInserted2b: TRadioButton;
    Label9: TLabel;
    EditSections: TEdit;
    Label11: TLabel;
    EditEditions: TEdit;
    Label3: TLabel;
    EditPressName: TEdit;
    btnDivideBySection: TButton;
    Label12: TLabel;
    PanelPageformat: TPanel;
    RadioButtonPageFormat1: TRadioButton;
    RadioButtonPageFormat2: TRadioButton;
    RadioButtonPageFormat3: TRadioButton;
    Label13: TLabel;
    ComboBoxPressTemplate4: TComboBox;
    Label17: TLabel;
    PanelInserted3: TPanel;
    RadioButtonInserted3a: TRadioButton;
    RadioButtonInserted3b: TRadioButton;
    Label18: TLabel;
    ComboBoxPressTemplate5: TComboBox;
    Label19: TLabel;
    PanelInserted4: TPanel;
    RadioButtonInserted4a: TRadioButton;
    RadioButtonInserted4b: TRadioButton;
    EditPagesSelected: TEdit;
    Label20: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure ComboBoxPressTemplate2Change(Sender: TObject);
    procedure ComboBoxPressTemplate3Change(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure ComboBoxPressTemplate1Change(Sender: TObject);
    procedure btnDivideBySectionClick(Sender: TObject);
    procedure RadioButtonPageFormat1Click(Sender: TObject);
    procedure RadioButtonPageFormat2Click(Sender: TObject);
    procedure RadioButtonPageFormat3Click(Sender: TObject);
    procedure ComboBoxPressTemplate4Change(Sender: TObject);
    procedure ComboBoxPressTemplate5Change(Sender: TObject);


  private
    procedure FillPublicationCombo();
    procedure FillPPressTemplateCombos();
    procedure SetPageFormatRadiobuttons();
    function  GetSelectedNumberOfPages() : Integer;
    function  LeadingZeroes(const aNumber, Length : integer) : string;
    function  GetPressTemplateID(Name : string) : Integer;
    function  GetSectionNameList() : String;
    function  GetEditionNameList() : String;
    function  GetPageFormat() : Integer;
  public
    { Public declarations }
    selectedProductionID : Integer;
    selectedPressID : Integer;
    selectedPublicationID : Integer;
    selectedPubDate : TDateTime;
    numberOfPages : Integer;
    NumberOfEditionsInProd : Integer;

    selectedPressTemplateID1 : Integer;
    selectedPressTemplateID2 : Integer;
    selectedPressTemplateID3 : Integer;
    selectedPressTemplateID4 : Integer;
    selectedPressTemplateID5 : Integer;
    selectedInsertMode : Boolean;
    selectedInsertMode2 : Boolean;
    selectedInsertMode3 : Boolean;
    selectedInsertMode4 : Boolean;
    SectionInfo : Array[0..15] of Integer;
    NumberOfSections : Integer;
    PageFormat : Integer;
  end;

var
  FormApplyLoadedPressTemplate: TFormApplyLoadedPressTemplate;

implementation

{$R *.dfm}
Uses
  Utypes,DateUtils,udata,umain, Usettings,UPlanframe, UApplyplan,
  Uprodplan, Unewpubl, Ulogin, Ueditplan, USecbyload, Uhangeednamebyload,
  Ueditplannames, Ueditionorder, Ueditatextcombo, UUtils;

procedure TFormApplyLoadedPressTemplate.FormActivate(Sender: TObject);
begin
  FillPublicationCombo();
  ComboBoxpublication.Itemindex := ComboBoxpublication.Items.IndexOf(tnames1.publicationIDtoname(selectedPublicationID));
  if ComboBoxpublication.Itemindex < 0 then
    ComboBoxpublication.Itemindex := 0;
  DateTimePicker1loadplan.Datetime := selectedPubDate;
  PageFormat := GetPageFormat();
  EditSections.Text := GetSectionNameList();
   EditNumerOfPages.Text :=  IntToStr(numberOfPages);
   EditEditions.Text := GetEditionNameList();

  if (Prefs.ShowWeekNumberInTree) then
    Editweek.text := LeadingZeroes(WeekOf(DateTimePicker1loadplan.DateTime), 2)
  else
    Editweek.text := '0';

  EditPressName.Text := tnames1.pressnameIDtoname(selectedPressID);
  EditPagesSelected.Text := '';
  FillPPressTemplateCombos();
  PanelInserted1.Enabled := true;
  PanelInserted1.Enabled := true;

  selectedPressTemplateID1 := 0;
  selectedPressTemplateID2 := 0;
  selectedPressTemplateID3 := 0;
  selectedPressTemplateID4 := 0;
  selectedPressTemplateID5 := 0;
  selectedInsertMode := true;
  selectedInsertMode2 := true;
  selectedInsertMode3 := true;
  selectedInsertMode4 := true;



end;

procedure  TFormApplyLoadedPressTemplate.FillPublicationCombo();
begin
  ComboBoxpublication.Items.Clear;
  ComboBoxpublication.Items := tNames1.publicationnames;
end;


procedure TFormApplyLoadedPressTemplate.SetPageFormatRadiobuttons();
begin
  RadioButtonPageFormat1.Checked := (PageFormat = 0);
  RadioButtonPageFormat2.Checked := (PageFormat = 1);
  RadioButtonPageFormat3.Checked := (PageFormat = 2);
end;


procedure TFormApplyLoadedPressTemplate.ComboBoxPressTemplate1Change(
  Sender: TObject);
var
  n1, i : Integer;
begin
  n1 := Integer(ComboBoxPressTemplate1.Items.Objects[ComboBoxPressTemplate1.ItemIndex]);
  if (ComboBoxPressTemplate2.Text = 'Not used') and (n1 < numberOfPages) then
  begin
    for i := 1 to ComboBoxPressTemplate2.Items.Count do
    begin
      if (Integer(ComboBoxPressTemplate2.Items.Objects[i]) = numberOfPages - n1)
      and (((PageFormat=0) and (Pos('TAB',ComboBoxPressTemplate2.Items[i])>0)) OR ((PageFormat=1) and (Pos('BRO',ComboBoxPressTemplate2.Items[i])>0)) OR (PageFormat=2) )then
      begin
        ComboBoxPressTemplate2.Itemindex := i;
        break;
      end;
    end;
  end;
  GetSelectedNumberOfPages();
end;

procedure TFormApplyLoadedPressTemplate.ComboBoxPressTemplate2Change(
  Sender: TObject);
var
  n1,n2, i : Integer;
begin
   PanelInserted1.Enabled := ComboBoxPressTemplate2.Text <> 'Not used';
   i :=  ComboBoxPressTemplate3.ItemIndex;

   if (i < 0) then
    i := 0;

   n1 := Integer(ComboBoxPressTemplate1.Items.Objects[ComboBoxPressTemplate1.ItemIndex]);
   n2 := Integer(ComboBoxPressTemplate2.Items.Objects[ComboBoxPressTemplate2.ItemIndex]);

  if (ComboBoxPressTemplate2.Text <> 'Not used') and (ComboBoxPressTemplate3.Text = 'Not used') and (n1 + n2 < numberOfPages)
  and (((PageFormat=0) and (Pos('TAB',ComboBoxPressTemplate3.Items[i])>0)) OR ((PageFormat=1) and (Pos('BRO',ComboBoxPressTemplate3.Items[i])>0)) OR (PageFormat=2) ) then
  begin
    for i := 1 to ComboBoxPressTemplate3.Items.Count do
    begin
      if (Integer(ComboBoxPressTemplate3.Items.Objects[i]) = numberOfPages - n1 - n2 ) then
      begin
        ComboBoxPressTemplate3.Itemindex := i;
        break;
      end;
    end;
  end;
  GetSelectedNumberOfPages();
end;

procedure TFormApplyLoadedPressTemplate.ComboBoxPressTemplate3Change(
  Sender: TObject);
var
  n1,n2,n3, i : Integer;
begin

   PanelInserted2.Enabled := ComboBoxPressTemplate3.Text <> 'Not used';
   i :=  ComboBoxPressTemplate4.ItemIndex;
   if (i < 0) then
    i := 0;

   n1 := Integer(ComboBoxPressTemplate1.Items.Objects[ComboBoxPressTemplate1.ItemIndex]);
   n2 := Integer(ComboBoxPressTemplate2.Items.Objects[ComboBoxPressTemplate2.ItemIndex]);
   n3 := Integer(ComboBoxPressTemplate3.Items.Objects[ComboBoxPressTemplate3.ItemIndex]);

  if (ComboBoxPressTemplate2.Text <> 'Not used') and (ComboBoxPressTemplate3.Text = 'Not used') and (ComboBoxPressTemplate4.Text = 'Not used') and (n1 + n2 + n3 < numberOfPages)
     and (((PageFormat=0) and (Pos('TAB',ComboBoxPressTemplate4.Items[i])>0)) OR ((PageFormat=1) and (Pos('BRO',ComboBoxPressTemplate4.Items[i])>0)) OR (PageFormat=2) ) then
  begin
    for i := 1 to ComboBoxPressTemplate4.Items.Count do
    begin
      if (Integer(ComboBoxPressTemplate4.Items.Objects[i]) = numberOfPages - n1 - n2 - n3 ) then
      begin
        ComboBoxPressTemplate4.Itemindex := i;
        break;
      end;
    end;
  end;
  GetSelectedNumberOfPages();
end;

procedure TFormApplyLoadedPressTemplate.ComboBoxPressTemplate4Change(Sender: TObject);
var
  n1,n2,n3, n4, i : Integer;
begin
   PanelInserted3.Enabled := ComboBoxPressTemplate4.Text <> 'Not used';
   i :=  ComboBoxPressTemplate5.ItemIndex;
   if (i < 0) then
    i := 0;
   n1 := Integer(ComboBoxPressTemplate1.Items.Objects[ComboBoxPressTemplate1.ItemIndex]);
   n2 := Integer(ComboBoxPressTemplate2.Items.Objects[ComboBoxPressTemplate2.ItemIndex]);
   n3 := Integer(ComboBoxPressTemplate3.Items.Objects[ComboBoxPressTemplate3.ItemIndex]);
   n4 := Integer(ComboBoxPressTemplate4.Items.Objects[ComboBoxPressTemplate4.ItemIndex]);
  if (ComboBoxPressTemplate2.Text <> 'Not used') and (ComboBoxPressTemplate3.Text = 'Not used') and (ComboBoxPressTemplate4.Text = 'Not used') and (ComboBoxPressTemplate5.Text = 'Not used') and (n1 + n2 + n3 + n4 < numberOfPages)
  and (((PageFormat=0) and (Pos('TAB',ComboBoxPressTemplate5.Items[i])>0)) OR ((PageFormat=1) and (Pos('BRO',ComboBoxPressTemplate5.Items[i])>0)) OR (PageFormat=2) ) then
  begin
    for i := 1 to ComboBoxPressTemplate5.Items.Count do
    begin
      if (Integer(ComboBoxPressTemplate5.Items.Objects[i]) = numberOfPages - n1 - n2 - n3 - n4) then
      begin
        ComboBoxPressTemplate5.Itemindex := i;
        break;
      end;
    end;
  end;
  GetSelectedNumberOfPages();
end;

procedure TFormApplyLoadedPressTemplate.ComboBoxPressTemplate5Change(Sender: TObject);
begin
  PanelInserted4.Enabled := ComboBoxPressTemplate5.Text <> 'Not used';
  GetSelectedNumberOfPages();
end;

procedure  TFormApplyLoadedPressTemplate.FillPPressTemplateCombos();
var
  n,n2 : Integer;
  s,s2, defaultTemplate : String;
  tabTemplate : boolean;
   broTemplate : boolean;
begin

  defaultTemplate := '';
  ComboBoxPressTemplate1.Items.Clear;
  ComboBoxPressTemplate2.Items.Clear;
  ComboBoxPressTemplate3.Items.Clear;
  ComboBoxPressTemplate4.Items.Clear;
  ComboBoxPressTemplate5.Items.Clear;

  ComboBoxPressTemplate2.AddItem('Not used',TObject(0));
  ComboBoxPressTemplate3.AddItem('Not used',TObject(0));
  ComboBoxPressTemplate4.AddItem('Not used',TObject(0));
  ComboBoxPressTemplate5.AddItem('Not used',TObject(0));
  try
    DataM1.Query1.SQL.Clear;
    if (IsDefaultPressTemplateNamesPossible) then
      DataM1.Query1.SQL.Add('SELECT DISTINCT P1.Name,P2.PressTemplateId,COUNT(DISTINCT(PageName)),ISNULL(P1.IsDefault,0) ')
    else
      DataM1.Query1.SQL.Add('SELECT DISTINCT P1.Name,P2.PressTemplateId,COUNT(DISTINCT(PageName)) ');
    DataM1.Query1.SQL.Add('FROM PressTemplateNames P1 ');
    DataM1.Query1.SQL.Add('INNER JOIN Presstemplate P2 ON P1.PressTemplateId = P2.PressTemplateId');
    DataM1.Query1.SQL.Add('WHERE P2.Pagetype<2 AND P2.PressId = '+IntToStr(selectedpressID));
    if (IsDefaultPressTemplateNamesPossible) then
       DataM1.Query1.SQL.Add('GROUP BY P1.Name,P2.PressTemplateId, P1.IsDefault')
    else
       DataM1.Query1.SQL.Add('GROUP BY P1.Name,P2.PressTemplateId');
    DataM1.Query1.SQL.Add('ORDER BY P1.Name');
    DataM1.Query1.open;
    while not DataM1.Query1.Eof do
    begin
      s := DataM1.Query1.Fields[0].AsString;
      s2 := UpperCase(s);
      n := DataM1.Query1.Fields[2].AsInteger;
      n2 := 1;
      tabTemplate := Pos('TAB',s2)>0;
      broTemplate := Pos('BRO',s2)>0;
      if (IsDefaultPressTemplateNamesPossible) then
         n2 :=  DataM1.Query1.Fields[3].AsInteger;
      if (defaultTemplate = '') and (n = numberOfPages) and ((PageFormat=0) and (tabTemplate) OR ((PageFormat=1) and (broTemplate)) OR (PageFormat=2)) then
      begin
        defaultTemplate := s;
      end;
      if (n <= numberOfPages) AND ((PageFormat=0) and (tabTemplate) OR ((PageFormat=1) and (broTemplate)) OR (PageFormat=2)) then
      begin
        ComboBoxPressTemplate1.AddItem(s, TObject(n));
        ComboBoxPressTemplate2.AddItem(s,TObject(n));
        ComboBoxPressTemplate3.AddItem(s,TObject(n));
        ComboBoxPressTemplate4.AddItem(s,TObject(n));
        ComboBoxPressTemplate5.AddItem(s,TObject(n));
      end;
      DataM1.Query1.Next;
    end;
    DataM1.Query1.Close;
  Except
  end;
  if (s <> '') then
    ComboBoxPressTemplate1.Itemindex := ComboBoxPressTemplate1.Items.IndexOf(defaultTemplate)
  else
    ComboBoxPressTemplate1.Itemindex := 0;

  ComboBoxPressTemplate2.Itemindex := 0;
  ComboBoxPressTemplate3.Itemindex := 0;
  ComboBoxPressTemplate4.Itemindex := 0;
  ComboBoxPressTemplate5.Itemindex := 0;
  GetSelectedNumberOfPages();
end;


function TFormApplyLoadedPressTemplate.LeadingZeroes(const aNumber, Length : integer) : string;
begin
  result := System.SysUtils.Format('%.*d', [Length, aNumber]) ;
end;



procedure TFormApplyLoadedPressTemplate.RadioButtonPageFormat1Click(
  Sender: TObject);
var
  n :  Integer;
begin
  n := PageFormat;
  if (RadioButtonPageFormat2.Checked) then
    PageFormat := 1
  else if (RadioButtonPageFormat3.Checked) then
    PageFormat := 2
  else
    PageFormat := 0;

  if (n <> PageFormat) then
    FillPPressTemplateCombos();

end;

procedure TFormApplyLoadedPressTemplate.RadioButtonPageFormat2Click(
  Sender: TObject);
begin
    RadioButtonPageFormat1Click(Sender);
end;

procedure TFormApplyLoadedPressTemplate.RadioButtonPageFormat3Click(
  Sender: TObject);
begin
   RadioButtonPageFormat1Click(Sender);
end;

procedure TFormApplyLoadedPressTemplate.BitBtn1Click(Sender: TObject);
var
  pagesAllRuns : Integer;
  n : Integer;
begin
   pagesAllRuns := 0;
   n  := GetSelectedNumberOfPages();
   if (n <> numberOfPages) then
   begin
     MessageDlg(formmain.InfraLanguage1.Translate('Page count does not add up'), mtWarning,[mbOk], 0);
     ModalResult := mrNone;
     Exit;
   end;

   selectedPressTemplateID1 := GetPressTemplateID(ComboBoxPressTemplate1.Text);
   selectedPressTemplateID2 := GetPressTemplateID(ComboBoxPressTemplate2.Text);
   selectedPressTemplateID3 := GetPressTemplateID(ComboBoxPressTemplate3.Text);
   selectedPressTemplateID4 := GetPressTemplateID(ComboBoxPressTemplate4.Text);
   selectedPressTemplateID5 := GetPressTemplateID(ComboBoxPressTemplate5.Text);
   selectedInsertMode := RadioButtonInserted1a.Checked;
   selectedInsertMode2 := RadioButtonInserted2a.Checked;
   selectedInsertMode3 := RadioButtonInserted3a.Checked;
   selectedInsertMode4 := RadioButtonInserted4a.Checked;
   ModalResult:= mrOK;
end;

function  TFormApplyLoadedPressTemplate.GetSelectedNumberOfPages() : Integer;
var
   n1, n2, n3, n4 , n5: Integer;
begin
   n1 := Integer(ComboBoxPressTemplate1.Items.Objects[ComboBoxPressTemplate1.ItemIndex]);
   n2 := Integer(ComboBoxPressTemplate2.Items.Objects[ComboBoxPressTemplate2.ItemIndex]);
   n3 := Integer(ComboBoxPressTemplate3.Items.Objects[ComboBoxPressTemplate3.ItemIndex]);
   n4 := Integer(ComboBoxPressTemplate4.Items.Objects[ComboBoxPressTemplate4.ItemIndex]);
   n5 := Integer(ComboBoxPressTemplate5.Items.Objects[ComboBoxPressTemplate5.ItemIndex]);
   result := n1 + n2 + n3 + n4 + n5;
   if (result > 0) then
      EditPagesSelected.Text := IntToStr( result)
   else
      EditPagesSelected.Text := '';

   if (result <> numberOfPages) then
      EditPagesSelected.Color := clRed
   else
      EditPagesSelected.Color := clWindow;

   EditPagesSelected.Update;
end;

function  TFormApplyLoadedPressTemplate.GetPressTemplateID(Name : string) : Integer;
var
  pressTemplateID : Integer;
begin

  if (Name = 'Not used') then
  begin
    result := 0;
    exit;
  end;

  pressTemplateID := 0;
    try
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('Select TOP 1 p1.presstemplateid from presstemplatenames p1, presstemplate p2');
    DataM1.Query1.SQL.Add('where p1.presstemplateid = p2.presstemplateid');
    DataM1.Query1.SQL.Add('and p1.name = ' + ''''+Name+'''');
    DataM1.Query1.SQL.Add('and p2.pressid = '+IntToStr(selectedpressID));
    XMLPressID  :=  selectedpressID;
    DataM1.Query1.Open;
    if not DataM1.Query1.Eof then
    begin
      pressTemplateID := DataM1.Query1.Fields[0].AsInteger;
    end;
    DataM1.Query1.Close;
  Except
  end;
  result :=   pressTemplateID;
end;

function TFormApplyLoadedPressTemplate.GetPageFormat() : Integer;
var
  t : string;
begin
  result := 0;
try
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('SELECT ISNULL(OrderNumber,'''') FROM ProductionNames ');
    DataM1.Query1.SQL.Add('WHERE ProductionID=' +IntToStr( selectedProductionID));
    DataM1.Query1.Open;
    if not DataM1.Query1.Eof then
    begin
      t := DataM1.Query1.Fields[0].AsString;
      t := UpperCase(t);
      if (t = 'BRO') OR (t = 'BROADSHEET') then
          result := 1;
    end;
    DataM1.Query1.Close;
  Except
  end;
  result := result;
end;


function  TFormApplyLoadedPressTemplate.GetSectionNameList() : String;
var
   sectionList : string;
   editionID : Integer;
   i,npages : Integer;
begin
   sectionList := '';
   editionID := 0;
   numberOfPages := 0;
   NumberOfSections := 0;
  try
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('SELECT DISTINCT P.EditionID,SEC.Name,COUNT(DISTINCT P.CopySeparationSet) FROM PageTable P WITH (NOLOCK) ');
    DataM1.Query1.SQL.Add('INNER JOIN SectionNames SEC ON SEC.SectionID=P.SectionID ');
    DataM1.Query1.SQL.Add('WHERE P.PageType<2 AND P.Active=1 AND P.Dirty=0 AND P.ProductionID=' +IntToStr( selectedProductionID));
    DataM1.Query1.SQL.Add('GROUP BY P.EditionID,SEC.Name');
    DataM1.Query1.SQL.Add('ORDER BY P.EditionID,SEC.Name');
    DataM1.Query1.Open;
    while not DataM1.Query1.Eof do
    begin
      i := DataM1.Query1.Fields[0].AsInteger;
      npages := DataM1.Query1.Fields[2].AsInteger;
      if ((editionID <> 0) AND (editionID <> i)) then  // ONlye inspect first edition
        break;
      if (sectionList <> '') then
        sectionList := sectionList + ', ';
      sectionList := sectionList + DataM1.Query1.Fields[1].AsString + ':' + IntToStr(npages);
      SectionInfo[NumberOfSections]  := npages;
      Inc(NumberOfSections);
      editionID := i;
      numberOfPages := numberOfPages + npages;
      Datam1.Query1.Next;
    end;
    DataM1.Query1.Close;
  Except
  end;
  result :=   sectionList;
end;

function  TFormApplyLoadedPressTemplate.GetEditionNameList() : String;
var
   editionList : string;
   s : string;
begin
   editionList := '';
   NumberOfEditionsInProd := 0;
   Formeditionorder.listbox1.Items.Clear; // ULGY!!!!!!!!!! used by UProdPlan..
  try
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.Add('SELECT DISTINCT(ED.Name) FROM PageTable P WITH (NOLOCK) ');
    DataM1.Query1.SQL.Add('INNER JOIN EditionNames ED ON Ed.EditionID=P.EditionID ');
    DataM1.Query1.SQL.Add('WHERE P.ProductionID=' +IntToStr( selectedProductionID));
    DataM1.Query1.SQL.Add('ORDER BY ED.Name');
    DataM1.Query1.Open;
    while not DataM1.Query1.Eof do
    begin
      s := DataM1.Query1.Fields[0].AsString;
      Inc(NumberOfEditionsInProd);
      if (editionList <> '') then
        editionList := editionList + ',';
      editionList := editionList + s;
      Formeditionorder.listbox1.Items.Add(s);
      Datam1.Query1.Next;
    end;
    DataM1.Query1.Close;
  Except
  end;
  result :=   editionList;
end;

procedure TFormApplyLoadedPressTemplate.btnDivideBySectionClick(
  Sender: TObject);
var
   OutPutList: TStrings;
   i,j, n : Integer;
   s : string;
begin
 OutPutList := TStringList.Create;
 try
   ExtractStrings([','],[],PChar(EditSections.Text),OutPutList);
   ComboBoxPressTemplate1.Itemindex := 0;
   ComboBoxPressTemplate2.Itemindex := 0;
   ComboBoxPressTemplate3.Itemindex := 0;
   ComboBoxPressTemplate4.Itemindex := 0;
   ComboBoxPressTemplate5.Itemindex := 0;
   for i := 0 to  NumberOfSections-1 do
   begin
      if ( SectionInfo[i] = 0) then
        continue;
        if (i = 0) then
        begin
          for j := 1 to ComboBoxPressTemplate1.Items.Count do
          begin
            if (Integer(ComboBoxPressTemplate1.Items.Objects[j]) = SectionInfo[i]) then
            begin
              ComboBoxPressTemplate1.Itemindex := j;
              break;
            end;
          end;
        end;

        if (i = 1) then
        begin
          for j := 1 to ComboBoxPressTemplate2.Items.Count do
          begin
            if (Integer(ComboBoxPressTemplate2.Items.Objects[j]) = SectionInfo[i]) then
            begin
              ComboBoxPressTemplate2.Itemindex := j;
              RadioButtonInserted1b.Checked := true;
              break;
            end;
          end;
        end;

        if (i = 2) then
        begin
          for j := 1 to ComboBoxPressTemplate3.Items.Count do
          begin
            if (Integer(ComboBoxPressTemplate3.Items.Objects[j]) = SectionInfo[i]) then
            begin
              ComboBoxPressTemplate3.Itemindex := j;
               RadioButtonInserted2b.Checked := true;
              break;
            end;
          end;
        end;

        if (i = 3) then
        begin
          for j := 1 to ComboBoxPressTemplate4.Items.Count do
          begin
            if (Integer(ComboBoxPressTemplate4.Items.Objects[j]) = SectionInfo[i]) then
            begin
              ComboBoxPressTemplate4.Itemindex := j;
               RadioButtonInserted3b.Checked := true;
              break;
            end;
          end;
        end;

        if (i = 4) then
        begin
          for j := 1 to ComboBoxPressTemplate5.Items.Count do
          begin
            if (Integer(ComboBoxPressTemplate5.Items.Objects[j]) = SectionInfo[i]) then
            begin
              ComboBoxPressTemplate5.Itemindex := j;
               RadioButtonInserted4b.Checked := true;
              break;
            end;
          end;
        end;
      end;

 finally
     OutPutList.Free;
 end;

 end;

end.
