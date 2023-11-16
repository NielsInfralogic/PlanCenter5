unit pdItem;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, ImgList, SPPlanners, SPDay,
  Buttons, Menus, UCalcReacur,CheckLst;

type

  Titemdata = Class(TObject)

                    private

                    Public
                      ScheduleID    : Longint;
                      ScheduleType    : Longint;  //0 bare visning af kommende plan, 1  fastlagt plan - sideantal - udskydning, 2fastlagt plan + sideantal + udskydning, 3 fastlagt plan + med activ plan i cc
                      Changed       : Longint;
                      locked        : Longint;
                      Username      : String;
                      LastChange    : Tdatetime;
                      Productionid    : Longint;
                      PublicationID   : Longint;
                      Pubdate       : Tdatetime;
                      Npages        : Longint;
                      NavOrderNum   : String;
                      Printtype     : String;  //0Heatset,1Coldset,2Special plan
                      ScheduleStatus : Longint;  //0 øhh ehee
                      NavisionStatus : Longint;  //0NoNavFile,1GotNavfile,
                      PressID        : Longint;
                      Reocurring    : Boolean;
                      recurrence     : TRecurenceFormel;
                      Oplag : Longint;
                      StartTime : Tdatetime;
                      Printtime : Longint;    //minutes
                      Presstemplate : String;
                      Priority : Longint;
                      GeneralComment : Tstrings;
                      PrepressComment : Tstrings;
                      PrintComment : Tstrings;
                      PackComment : Tstrings;

                      Paper : String;
                      Glue   : String;
                      Folder  : String;

                      GeneralFiles : Tstrings;

                      generalactions  : Array[0..20] OF boolean;
                      Prepressactions : Array[0..20] OF boolean;
                      Printactions    : Array[0..20] OF boolean;
                      Packactions     : Array[0..20] OF boolean;

                      constructor Create;

  //                    Destructor Free;

              end;

  TItemForm = class(TForm)
    Label6: TLabel;
    ResourceCombo: TComboBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    Paneldown: TPanel;
    OKButton: TButton;
    CancelButton: TButton;
    ComboBoxpresstemplate: TComboBox;
    Label11: TLabel;
    PopupMenu1: TPopupMenu;
    Editpri: TEdit;
    Label10: TLabel;
    UpDown1: TUpDown;
    GroupBoxprestat: TGroupBox;
    CheckListBoxprepress: TCheckListBox;
    GroupBoxprintstat: TGroupBox;
    CheckListBoxPrint: TCheckListBox;
    ComboBoxpapir: TComboBox;
    Label12: TLabel;
    ComboBoxfalse: TComboBox;
    Label13: TLabel;
    ComboBoxglu: TComboBox;
    Label14: TLabel;
    GroupBoxpackstat: TGroupBox;
    CheckListBoxpack: TCheckListBox;
    GroupBoxgenstat: TGroupBox;
    CheckListBoxgeneral: TCheckListBox;
    GroupBoxgencom: TGroupBox;
    Memogeneralcomment: TMemo;
    GroupBoxprecom: TGroupBox;
    MemoPrepressComment: TMemo;
    GroupBoxprintcom: TGroupBox;
    MemoPrintComment: TMemo;
    GroupBoxpackcom: TGroupBox;
    MemoPackComment: TMemo;
    Paneltop: TPanel;
    TitleEdit: TEdit;
    Label1: TLabel;
    Label4: TLabel;
    ComboBoxpublication: TComboBox;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label15: TLabel;
    Editordernumber: TEdit;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    StartDateEdit: TDateTimePicker;
    StartTimeEdit: TDateTimePicker;
    RadioGrouprepeat: TRadioGroup;
    Editoplag: TEdit;
    ComboBoxtryktype: TComboBox;
    DateTimePickerPubdate: TDateTimePicker;
    EditTotpages: TEdit;
    Memotmp: TMemo;
    OpenDialogAttach: TOpenDialog;
    PopupMenufiles: TPopupMenu;
    Attach1: TMenuItem;
    Remove1: TMenuItem;
    Deletefile1: TMenuItem;
    GroupBoxgenfil: TGroupBox;
    ListViewfiles: TListView;
    Label3: TLabel;
    Label16: TLabel;
    DateTimePickerprinttime: TDateTimePicker;
    procedure ComboBoxtryktypeDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure CheckListBoxgeneralDrawItem(Control: TWinControl;
      Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure ComboBoxpublicationChange(Sender: TObject);
    procedure EditoplagChange(Sender: TObject);
    procedure EditTotpagesChange(Sender: TObject);
    procedure ComboBoxpresstemplateChange(Sender: TObject);
    procedure EditoplagKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure RadioGrouprepeatClick(Sender: TObject);
    procedure Attach1Click(Sender: TObject);
    procedure Remove1Click(Sender: TObject);
    procedure Deletefile1Click(Sender: TObject);
    procedure DateTimePickerprinttimeEnter(Sender: TObject);
    procedure DateTimePickerprinttimeChange(Sender: TObject);
  private
    lastPrinttime : Tdatetime;
  public
    Aktprinttime : Longint; // I minutter
    Procedure DeleteItemfromProductionDB(Productionid : longint);
    Procedure DeleteItemfromDB(ScheduleID : Longint);
    Procedure aktprinttimetoform;
    Procedure Formtoaktprinttime;

    Function SaveRecur(Item: TSPPlanItem):Longint;
    procedure CreateRecurItems(BaseItem : TSPPlanItem;
                               justforshow : boolean;
                               SaveToDB   : Boolean);
    procedure CopyToAktitemdata;
    procedure CopyFromFormToItem(Var Item: TSPPlanItem);
    procedure FormInit;
    Function MakeATitle(Scheduleday     : Tdatetime;
                         Publicationname : string;
                         Totpages        : string;
                         oplag           : string;
                         Presstemplate   : string;
                         Reacurname      : String):string;
    procedure SaveAItem(Item: TSPPlanItem);

    Procedure Loadstat(Var aItem : TSPPlanItem);
    Procedure LoadText(Var aItem : TSPPlanItem);
    procedure LoadDBItemS;

    procedure CopyItemToForm(Var Item: TSPPlanItem);
    procedure SetIconsOnAItem(Var Item      : TSPPlanItem);

  end;

var
  ItemForm: TItemForm;


function EditItemProperties(var Title, Resource: string; var ItemColor: TColor;
  var StartTime,Endtime : TDateTime;
  var AllDay, IsPrivate: Boolean;
  var BusyStatus: TSPBusyStatus;
  Var ScheduleID : Longint;
  Resources: TSPPlannerResources): Boolean;


procedure EditPlanItem(Item: TSPPlanItem; Resources: TSPPlannerResources);
procedure EditNewItem(Planner: TSPBasePlanner);

implementation

{$R *.dfm}
Uses
  umain,Udata,utypes,DateUtils,usettings,
  Ulogin,DBXpress, FMTBcd, SqlExpr,
  CRSQLConnection, DB;

constructor Titemdata.Create;
Var
  I : Longint;
Begin

  inherited create;
  GeneralComment := tstringlist.Create;
  prepressComment := tstringlist.Create;
  PrintComment := tstringlist.Create;
  PackComment := tstringlist.Create;

  GeneralFiles := tstringlist.Create;

  GeneralComment.Add('gencom');
  prepressComment.Add('prepresscom');
  PrintComment.Add('printcom');
  PackComment.Add('packcom');

  GeneralFiles.Add('GeneralFiles');

  ScheduleID    := -1;
  ScheduleType  := -1;
  PublicationID := -1;
  Productionid  := -1;
  Pubdate       := now;
  Npages        := 0;
  Oplag := 0;

  NavOrderNum   := '';
  Printtype     := '';  //0Heatset,1Coldset,2Special plan
  Reocurring    := false;  //0Enkelt,1 repeat
  ScheduleStatus :=0;  //0 øhh ehee
  NavisionStatus :=0;  //0NoNavFile,1GotNavfile,
  PressID        :=-1;
  recurrence.RecurID   := -1;
  recurrence.Recurtype := 1;

  Changed       := 0;
  locked        := 0;
  Username      := '';
  LastChange    := Now;

  StartTime := encodedate(1900,1,1);
  Printtime := 60;
  Presstemplate := '';
  Priority := 50;
  Paper    := '';
  Glue     := '';
  Folder   := '';




  For i := 0 to 20 do
  begin
    generalactions[i] := false;
    Prepressactions[i] := false;
    Printactions[i] := false;
    Packactions[i] := false;
  end;



end;


function EditItemProperties(var Title, Resource: string; var ItemColor: TColor;
                            var StartTime,Endtime : TDateTime;
                            var AllDay, IsPrivate: Boolean;
                            var BusyStatus: TSPBusyStatus;
                            Var ScheduleID : Longint;
                            Resources: TSPPlannerResources): Boolean;

var
  i: Integer;
begin
  Result := False;


  ItemForm.TitleEdit.Text := Title;

  if Assigned(Resources) then
    for i := 0 to Resources.Count - 1 do
      ItemForm.ResourceCombo.Items.Add(Resources[i].Name);

  ItemForm.ResourceCombo.ItemIndex := ItemForm.ResourceCombo.Items.IndexOf(Resource);
  if ItemForm.ResourceCombo.ItemIndex < 0 then
    ItemForm.ResourceCombo.ItemIndex := 0;

  ItemForm.StartDateEdit.DateTime := StartTime;
  ItemForm.StartTimeEdit.DateTime := StartTime;


  if ItemForm.ShowModal = mrOK then
  begin

    Title := ItemForm.TitleEdit.Text;
    if ItemForm.ResourceCombo.ItemIndex >= 0 then
      Resource := ItemForm.ResourceCombo.Items[ItemForm.ResourceCombo.ItemIndex]
    else
      Resource := '';
    StartTime := Trunc(ItemForm.StartDateEdit.DateTime) + Frac(ItemForm.StartTimeEdit.DateTime);
    ItemForm.Aktprinttime := minutesbetween(Endtime,StartTime);

    ItemColor := Possiblecolors[ItemForm.ComboBoxtryktype.itemindex].Acolor;

    Result := True;
  end;
end;


procedure EditPlanItem(Item: TSPPlanItem; Resources: TSPPlannerResources);
var
  Title, Resource: string;
  ItemColor: TColor;
  StartTime, EndTime: TDateTime;
  AllDay, IsPrivate: Boolean;
  BusyStatus: TSPBusyStatus;
  I : Longint;
  ScheduleID : Longint;

begin
  ItemForm.FormInit;

  Title := Item.Title;
  Resource := Item.Resource;
  StartTime := Item.StartTime;
  EndTime := Item.EndTime;

  AllDay := Item.AllDayEvent;
  IsPrivate := Item.IsPrivate;
  BusyStatus := Item.BusyStatus;
  ItemColor := Item.Color;
  ItemForm.CopyItemToForm(Item);

  if EditItemProperties(Title, Resource, ItemColor, StartTime, EndTime, AllDay,
    IsPrivate, BusyStatus,ScheduleID, Resources) then
  begin
    Item.Title := Title;
    Item.Resource := Resource;
    Item.StartTime := StartTime;
    Item.EndTime := EndTime;
    Item.AllDayEvent := AllDay;
    Item.IsPrivate := IsPrivate;
    Item.BusyStatus := BusyStatus;
    Item.Color := ItemColor;
    Item.Icons.clear;

    ItemForm.CopyFromFormToItem(Item);

    Item.Save;
    ItemForm.SetIconsOnAItem(Item);



  end;
end;


procedure TItemForm.ComboBoxtryktypeDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
   if odSelected in State then
 Begin
   (Control as TComboBox).Canvas.Brush.Color := clHighlight
 End
 else
 Begin
   (Control as TComboBox).Canvas.Brush.Color := clWhite;
 End;

 (Control as TComboBox).Canvas.FillRect(Rect);

 with (Control as TComboBox).Canvas do
 begin
   TextOut(Rect.Left + 18,Rect.Top, ComboBoxtryktype.Items[index]);
   Brush.Color := FormPressplanConfig.getAcolorfromname(ComboBoxtryktype.Items[index]);
   Rectangle(Rect.Left + 1,Rect.Top + 1,Rect.Left + 16,Rect.Bottom - 1);
 end;

end;


procedure TItemForm.CheckListBoxgeneralDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
Var
  Idx : Longint;
  arect,srect : trect;
  Abitmap : Tbitmap;
begin
 Abitmap := Tbitmap.Create;
 try


   IF control = CheckListBoxgeneral then
     Idx := generalactions[index].Index;
   IF control = CheckListBoxprepress then
     Idx := Prepressactions[index].Index;
   IF control = CheckListBoxPrint then
     Idx := Printactions[index].Index;
   IF control = CheckListBoxpack then
     Idx := packactions[index].Index;

   if odSelected in State then
   Begin
     (Control as TCheckListBox).Canvas.Brush.Color := clHighlight
   End
   else
   Begin
     (Control as TCheckListBox).Canvas.Brush.Color := clWhite;
   End;

   (Control as TCheckListBox).Canvas.FillRect(Rect);

   with (Control as TCheckListBox).Canvas do
   begin
     TextOut(Rect.Left + 18,Rect.Top, (Control as TCheckListBox).items[index]);
     formmain.PlannerImages.GetBitmap(Idx,Abitmap);
     srect.Top :=0;
     srect.left :=0;
     srect.right :=Abitmap.Width;
     srect.Bottom :=Abitmap.Height;

     arect.Left := Rect.Left + 1;
     arect.top := Rect.top + 1;
     arect.Right := ARect.Left + srect.right;
     arect.Bottom := ARect.top + srect.Bottom;

     Copyrect(arect,Abitmap.Canvas,srect);
   end;
 Finally
   Abitmap.Free;
 end;
end;


procedure TItemForm.FormInit;
Var
  i : Longint;
begin
  ComboBoxpublication.Items.clear;
  ComboBoxpublication.Items := tnames1.publicationnames;
  CheckListBoxgeneral.ItemHeight := formmain.PlannerImages.Height+4;
  CheckListBoxprepress.ItemHeight := formmain.PlannerImages.Height+4;
  CheckListBoxPrint.ItemHeight := formmain.PlannerImages.Height+4;
  CheckListBoxpack.ItemHeight := formmain.PlannerImages.Height+4;

  ComboBoxpresstemplate.Items.clear;
  DataM1.Query2.SQL.Clear;
  DataM1.Query2.SQL.add('Select distinct Name from Presstemplatenames ');
  DataM1.Query2.SQL.add('Order by name');
  DataM1.Query2.open;
  While not DataM1.Query2.eof do
  begin
    ComboBoxpresstemplate.Items.add(DataM1.Query2.fields[0].asstring);
    DataM1.Query2.next;
  end;
  DataM1.Query2.close;

  ComboBoxtryktype.Items[0] := Possiblecolors[0].Aname;
  ComboBoxtryktype.Items[1] := Possiblecolors[1].Aname;
  ComboBoxtryktype.Items[2] := Possiblecolors[2].Aname;
  ComboBoxtryktype.ItemIndex := 0;

  CheckListBoxgeneral.Items.clear;
  CheckListBoxprepress.Items.clear;
  CheckListBoxPrint.Items.clear;
  CheckListBoxpack.Items.clear;

  For i := 0 to NGeneralactions-1 do
  begin
    CheckListBoxgeneral.Items.Add(Generalactions[i].name);
  end;

  For i := 0 to NPrepressactions-1 do
  begin
    CheckListBoxprepress.Items.Add(Prepressactions[i].name);
  end;

  For i := 0 to Nprintactions-1 do
  begin
    CheckListBoxPrint.Items.Add(printactions[i].name);
  end;

  For i := 0 to Npackactions-1 do
  begin
    CheckListBoxpack.Items.Add(packactions[i].name);
  end;

  ComboBoxpapir.Items.Clear;
  For i := 0 to FormPressplanConfig.MemoPapir.lines.count-1 do
  begin
    ComboBoxpapir.Items.add(FormPressplanConfig.MemoPapir.lines[i]);
  end;

  ComboBoxfalse.Items.Clear;
  For i := 0 to FormPressplanConfig.Memofalse.lines.count-1 do
  begin
    ComboBoxfalse.Items.add(FormPressplanConfig.Memofalse.lines[i]);
  end;

  ComboBoxglu.Items.Clear;
  For i := 0 to FormPressplanConfig.Memoglu.lines.count-1 do
  begin
    ComboBoxglu.Items.add(FormPressplanConfig.Memoglu.lines[i]);
  end;
  Memogeneralcomment.Lines.Clear;
  Memoprepresscomment.Lines.Clear;
  Memoprintcomment.Lines.Clear;
  Memopackcomment.Lines.Clear;
  ListViewfiles.Items.Clear;

end;


procedure EditNewItem(Planner: TSPBasePlanner);
var
  Title, Resource: string;
  ItemColor: TColor;
  StartTime, EndTime: TDateTime;
  AllDay, IsPrivate: Boolean;
  BusyStatus: TSPBusyStatus;
  ATSPPlanItem : TSPPlanItem;
  I : Longint;

  ScheduleID : Longint;


begin
  if Planner.AllowNewItem(Resource, StartTime, EndTime)  then
  begin
    ItemForm.FormInit;

    Title := 'New Item';
    AllDay := False;
    IsPrivate := False;
    BusyStatus := bsBusy;
    ItemColor := clNone;
    ItemForm.DateTimePickerPubdate.Date := dateof(StartTime);
    ItemForm.Aktprinttime := minutesbetween(Endtime,StartTime);
    ItemForm.aktprinttimetoform;

    if EditItemProperties(Title, Resource, ItemColor, StartTime, EndTime, AllDay,
      IsPrivate, BusyStatus,ScheduleID, TSPDayPlanner(Planner).Resources) then
    Begin

      ATSPPlanItem := Planner.Source.AddItem(Resource, Title, StartTime, EndTime, AllDay,
        IsPrivate, ItemColor, BusyStatus);

      ATSPPlanItem.Icons.Clear;
      ATSPPlanItem.Data := Titemdata.Create;

      ItemForm.CopyFromFormToItem(ATSPPlanItem);

      ItemForm.SaveAItem(ATSPPlanItem);
      ItemForm.SetIconsOnAItem(ATSPPlanItem);

      IF Titemdata(ATSPPlanItem.Data).Reocurring then
      begin
        ItemForm.CreateRecurItems(ATSPPlanItem,false,true);
      end;
    End;
  end;
end;

Function TItemForm.MakeATitle(Scheduleday     : Tdatetime;
                               Publicationname : string;
                               Totpages        : string;
                               oplag           : string;
                               Presstemplate   : string;
                               Reacurname      : String):string;
Var
  t : String;
Begin
  result :=  datetostr(Scheduleday) + #13+
  Publicationname +','  + Totpages + ','+ oplag + ',' +Presstemplate + ','+Reacurname;

end;

procedure TItemForm.ComboBoxpublicationChange(Sender: TObject);
begin
  TitleEdit.Text := MakeATitle(StartDateEdit.Date,ComboBoxpublication.Text,EditTotpages.Text,Editoplag.Text,ComboBoxpresstemplate.Text,' Base');
end;

procedure TItemForm.EditoplagChange(Sender: TObject);
begin
  TitleEdit.Text := MakeATitle(StartDateEdit.Date,ComboBoxpublication.Text,EditTotpages.Text,Editoplag.Text,ComboBoxpresstemplate.Text,' Base');
end;

procedure TItemForm.EditTotpagesChange(Sender: TObject);
begin
  TitleEdit.Text := MakeATitle(StartDateEdit.Date,ComboBoxpublication.Text,EditTotpages.Text,Editoplag.Text,ComboBoxpresstemplate.Text,' Base');
end;

procedure TItemForm.ComboBoxpresstemplateChange(Sender: TObject);
begin
  TitleEdit.Text := MakeATitle(StartDateEdit.Date,ComboBoxpublication.Text,EditTotpages.Text,Editoplag.Text,ComboBoxpresstemplate.Text,' Base');
end;

procedure TItemForm.EditoplagKeyPress(Sender: TObject; var Key: Char);
begin
  IF Not (key IN tal) then
  Begin
    key := char(nil);
    beep;
  end;

end;

procedure TItemForm.CopyToAktitemdata;
Begin
End;


procedure TItemForm.CopyFromFormToItem(Var Item: TSPPlanItem);
Var
  I : Longint;
Begin

  Formtoaktprinttime;

  Item.Title := TitleEdit.Text;
  Item.StartTime := Trunc(StartDateEdit.DateTime) + Frac(StartTimeEdit.DateTime);
  Item.EndTime := StartDateEdit.DateTime;
  Item.EndTime := IncMinute(Item.EndTime,aktprinttime);

  Titemdata(Item.Data).StartTime := Item.StartTime;
  Titemdata(Item.Data).Printtime := aktprinttime;

  Titemdata(Item.Data).PublicationID   := tnames1.publicationnametoid(ComboBoxpublication.Text);
  Titemdata(Item.Data).Pubdate         := DateTimePickerPubdate.Date;
  Titemdata(Item.Data).Npages          := strtoint(EditTotpages.text);
  Titemdata(Item.Data).Oplag           := strtoint(Editoplag.text);
  Titemdata(Item.Data).NavOrderNum     := Editordernumber.Text;
  Titemdata(Item.Data).Printtype       := ComboBoxtryktype.Text;  //0Heatset,1Coldset,2Special plan

  Titemdata(Item.Data).ScheduleStatus  := 0;  //0 øhh ehee
  Titemdata(Item.Data).NavisionStatus  := 0;  //0NoNavFile,1GotNavfile,
  Titemdata(Item.Data).PressID         := 1;
  Titemdata(Item.Data).recurrence.RecurID   := -1;
  Titemdata(Item.Data).Presstemplate := '';
  IF ComboBoxpresstemplate.Text <> '' then
  begin
    Titemdata(Item.Data).Presstemplate := ComboBoxpresstemplate.Text;
  end;

  Titemdata(Item.Data).Priority := strtoint(Editpri.Text);
  Titemdata(Item.Data).Paper := ComboBoxpapir.Text;
  Titemdata(Item.Data).Glue  := ComboBoxglu.Text;
  Titemdata(Item.Data).Folder  := ComboBoxfalse.Text;

  Titemdata(Item.Data).ScheduleType := 1;

  IF (Titemdata(Item.Data).Npages > 0) or (Titemdata(Item.Data).Presstemplate <> '') then
    Titemdata(Item.Data).ScheduleType := 2;

  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.add('Select Productionid from pagetable');
  DataM1.Query1.SQL.add('Where Publicationid = ' + inttostr(Titemdata(Item.Data).PublicationID));
  DataM1.Query1.SQL.add(' and  Pubdate = ' +''''+formatdatetime(sqldateformat, Titemdata(Item.Data).Pubdate)+'''');
  DataM1.Query1.open;
  IF Not DataM1.Query1.eof then
  begin
    Titemdata(Item.Data).ScheduleType := 3;
    Titemdata(Item.Data).Productionid := DataM1.Query1.fields[0].AsInteger;
  end;
  DataM1.Query1.Close;


  For i := 0 to CheckListBoxgeneral.items.Count-1 do
  Begin
    Titemdata(Item.Data).generalactions[i] := CheckListBoxgeneral.Checked[i];
  End;
  For i := 0 to CheckListBoxprepress.items.Count-1 do
  Begin
    Titemdata(Item.Data).prepressactions[i] := CheckListBoxprepress.Checked[i];
  End;
  For i := 0 to CheckListBoxprint.items.Count-1 do
  Begin
    Titemdata(Item.Data).printactions[i] := CheckListBoxprint.Checked[i];
  End;
  For i := 0 to CheckListBoxpack.items.Count-1 do
  Begin
    Titemdata(Item.Data).packactions[i] := CheckListBoxpack.Checked[i];
  End;



  Titemdata(Item.Data).GeneralComment.clear;
  For i := 0 to Memogeneralcomment.lines.Count-1 do
    Titemdata(Item.Data).GeneralComment.Add(Memogeneralcomment.Lines[i]);
  Titemdata(Item.Data).Generalfiles.clear;
  For i := 0 to ListViewfiles.items.Count-1 do
    Titemdata(Item.Data).Generalfiles.Add( ListViewfiles.items[i].caption);

  Titemdata(Item.Data).prepressComment.clear;
  For i := 0 to Memoprepresscomment.lines.Count-1 do
    Titemdata(Item.Data).prepressComment.Add(Memoprepresscomment.Lines[i]);

  Titemdata(Item.Data).PrintComment.clear;
  For i := 0 to MemoPrintcomment.lines.Count-1 do
    Titemdata(Item.Data).PrintComment.Add(MemoPrintcomment.Lines[i]);

  Titemdata(Item.Data).PackComment.clear;
  For i := 0 to MemoPackcomment.lines.Count-1 do
    Titemdata(Item.Data).PackComment.Add(MemoPackcomment.Lines[i]);

  Titemdata(Item.Data).Reocurring      := RadioGrouprepeat.ItemIndex = 1;
  IF RadioGrouprepeat.ItemIndex = 1 then
  begin
    FormGentagne.FormToFormel(Titemdata(Item.Data).recurrence);
  end;

end;

procedure TItemForm.CopyItemToForm(Var Item: TSPPlanItem);
Var
  I : Longint;
  L : Tlistitem;
Begin
  TitleEdit.Text := Item.Title;
  IF Titemdata(Item.Data).ScheduleID <> -1 then
    beep;
  StartDateEdit.DateTime := Item.StartTime;

  aktprinttime := Titemdata(Item.Data).Printtime;
  aktprinttimetoform;

  ComboBoxpublication.itemindex := ComboBoxpublication.Items.IndexOf(tnames1.publicationIDtoname(Titemdata(Item.Data).PublicationID));
  DateTimePickerPubdate.Date := Titemdata(Item.Data).Pubdate;
  EditTotpages.text := Inttostr(Titemdata(Item.Data).Npages);
  Editoplag.text := inttostr(Titemdata(Item.Data).Oplag);
  Editordernumber.Text := Titemdata(Item.Data).NavOrderNum;
  ComboBoxtryktype.Text := Titemdata(Item.Data).Printtype;  //0Heatset,1Coldset,2Special plan
  RadioGrouprepeat.ItemIndex := Integer(Titemdata(Item.Data).Reocurring);
  ComboBoxpresstemplate.Text := '';
  IF Titemdata(Item.Data).Presstemplate <> '' then
  begin
    ComboBoxpresstemplate.Text := Titemdata(Item.Data).Presstemplate;
  end;

  Editpri.Text := Inttostr(Titemdata(Item.Data).Priority);
  ComboBoxpapir.Text := Titemdata(Item.Data).Paper;
  ComboBoxglu.Text := Titemdata(Item.Data).Glue;
  ComboBoxfalse.Text := Titemdata(Item.Data).Folder;

  For i := 0 to CheckListBoxgeneral.items.Count-1 do
    CheckListBoxgeneral.Checked[i] := Titemdata(Item.Data).generalactions[i];
  For i := 0 to CheckListBoxPrepress.items.Count-1 do
    CheckListBoxPrepress.Checked[i] := Titemdata(Item.Data).Prepressactions[i];
  For i := 0 to CheckListBoxPrint.items.Count-1 do
    CheckListBoxPrint.Checked[i] := Titemdata(Item.Data).Printactions[i];
  For i := 0 to CheckListBoxPack.items.Count-1 do
    CheckListBoxPack.Checked[i] := Titemdata(Item.Data).Packactions[i];

  Memogeneralcomment.Lines.clear;
  For i := 0 to Titemdata(Item.Data).GeneralComment.Count-1 do
    Memogeneralcomment.Lines.Add(Titemdata(Item.Data).GeneralComment[i]);

  ListViewfiles.items.Clear;
  For i := 0 to Titemdata(Item.Data).Generalfiles.Count-1 do
  Begin
    L := ListViewfiles.items.Add;
    L.caption :=(Titemdata(Item.Data).Generalfiles[i]);
  End;
  Memoprepresscomment.Lines.clear;
  For i := 0 to Titemdata(Item.Data).prepressComment.Count-1 do
    Memoprepresscomment.Lines.Add(Titemdata(Item.Data).prepressComment[i]);

  Memoprintcomment.Lines.clear;
  For i := 0 to Titemdata(Item.Data).printComment.Count-1 do
    Memoprintcomment.Lines.Add(Titemdata(Item.Data).printComment[i]);

  Memopackcomment.Lines.clear;
  For i := 0 to Titemdata(Item.Data).packComment.Count-1 do
    Memopackcomment.Lines.Add(Titemdata(Item.Data).packComment[i]);

end;


procedure TItemForm.FormCreate(Sender: TObject);
begin
//  Aktitemdata := Titemdata.Create;
end;

procedure TItemForm.SetIconsOnAItem(Var Item      : TSPPlanItem);
Var
  I : Longint;
Begin
  Item.Icons.clear;

  (* For i := 14 to 20 do
    Item.Icons.Add(i);
    *)

  Case Titemdata(Item.Data).ScheduleType of
    0 : Begin
          Item.Icons.Add(14);
        end;
    1 : Begin
          Item.Icons.Add(18);
        end;
    2 : Begin
          Item.Icons.Add(17);
        end;
    3 : Begin
          Item.Icons.Add(20);
        end;
    Else
      Item.Icons.Add(10);
  end;

  For i := 0 to NGeneralactions-1 do
  Begin
    IF Titemdata(Item.Data).generalactions[i] then
      Item.Icons.Add(generalactions[i].Index);
  End;
  For i := 0 to Nprepressactions-1 do
  Begin
    IF Titemdata(Item.Data).prepressactions[i] then
      Item.Icons.Add(prepressactions[i].Index);
  End;
  For i := 0 to Nprintactions-1 do
  Begin
    IF Titemdata(Item.Data).printactions[i] then
      Item.Icons.Add(printactions[i].Index);
  End;
  For i := 0 to Npackactions-1 do
  Begin
    IF Titemdata(Item.Data).packactions[i] then
      Item.Icons.Add(packactions[i].Index);
  End;
End;


procedure TItemForm.SaveAItem(Item: TSPPlanItem);

Procedure insertAstat(StatusType : longint;
                      StatusNumber : Longint);
Begin
  DataM1.Query1.SQL.clear;
  DataM1.Query1.SQL.add('Insert ScheduleStatus ');
  DataM1.Query1.SQL.add('(ScheduleID,StatusType,StatusNumber,Username,StatusTime) ');
  DataM1.Query1.SQL.add('Values (' + inttostr(Titemdata(Item.Data).ScheduleID) +',');
  DataM1.Query1.SQL.add(inttostr(StatusType)+','+inttostr(StatusNumber)+',');
  DataM1.Query1.SQL.add(''''+formlogin.username+''''+',');
  DataM1.Query1.SQL.add('getdate())');
  DataM1.Query1.ExecSQL(false);
end;

Procedure insertAInfo(InfoType : longint;
                      Var Astrings : Tstrings);
Var
  I : longint;
Begin
  Memotmp.lines.Clear;
  For i := 0 to Astrings.Count-1 do
    Memotmp.lines.add(Astrings[i]);
  DataM1.Query1.SQL.clear;
  DataM1.Query1.SQL.add('Insert ScheduleInfo ');
  DataM1.Query1.SQL.add('(ScheduleID,InfoType,InfoText) ');
  DataM1.Query1.SQL.add('Values (' + inttostr(Titemdata(Item.Data).ScheduleID) +',');
  DataM1.Query1.SQL.add(inttostr(InfoType)+',:Infotext)');

  DataM1.Query1.ParamByName('Infotext').DataType := ftMemo;
  DataM1.Query1.ParamByName('Infotext').Asstring := Memotmp.Text;

  IF debug then datam1.Query1.sql.SaveToFile(extractfilepath(application.exename) + 'sqllogs\'+'SPCreatetext.sql');
  DataM1.Query1.ExecSQL(false);

end;


Var
  I : Longint;
Begin

  IF Titemdata(Item.Data).ScheduleID <> -1 then
  begin
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.add(' ');


  end
  Else
  begin


    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.add('exec spPlancenterCreateSchedule');

    DataM1.Query1.SQL.add('@ScheduleType = ' + Inttostr(Titemdata(Item.Data).ScheduleType) +',');
    DataM1.Query1.SQL.add('@ScheduleName = ' + ''''+Item.Title+'''' +',');
    DataM1.Query1.SQL.add('@PublicationID = ' + Inttostr(Titemdata(Item.Data).publicationid) +',');
    DataM1.Query1.SQL.add('@Pubdate = ' +''''+formatdatetime(sqldateformat, Titemdata(Item.Data).Pubdate)+''''  +',');

    DataM1.Query1.SQL.add('@Status = ' + Inttostr(Titemdata(Item.Data).ScheduleStatus) +',');
    DataM1.Query1.SQL.add('@PressID = ' + Inttostr(Titemdata(Item.Data).PressID) +',');
    DataM1.Query1.SQL.add('@Printtype = ' + ''''+Titemdata(Item.Data).Printtype+'''' +',');
    DataM1.Query1.SQL.add('@OrderNumber = ' + ''''+Titemdata(Item.Data).NavOrderNum+'''' +',');
    DataM1.Query1.SQL.add('@StartTime = '  +''''+formatdatetime(SQLdatetimeformat, Titemdata(Item.Data).StartTime)+''''  +',');
    DataM1.Query1.SQL.add('@Printtime = '  +inttostr(Titemdata(Item.Data).Printtime)  +',');
    DataM1.Query1.SQL.add('@Oplag = ' + Inttostr(Titemdata(Item.Data).Oplag) +',');
    DataM1.Query1.SQL.add('@Presstemplate = ' + ''''+Titemdata(Item.Data).Presstemplate +''''+',');
    DataM1.Query1.SQL.add('@Priority = ' + Inttostr(Titemdata(Item.Data).Priority) +',');
    DataM1.Query1.SQL.add('@Paper = ' + ''''+Titemdata(Item.Data).Paper+'''' +',');
    DataM1.Query1.SQL.add('@Glue = ' + ''''+Titemdata(Item.Data).Glue+'''' +',');
    DataM1.Query1.SQL.add('@Folder = ' + ''''+Titemdata(Item.Data).Folder+'''' +',');
    DataM1.Query1.SQL.add('@recurrenceID = ' + Inttostr(Titemdata(Item.Data).recurrence.RecurID) +',');
    DataM1.Query1.SQL.add('@ProductionID = ' + Inttostr(Titemdata(Item.Data).ProductionID) +',');
    DataM1.Query1.SQL.add('@Username = ' + ''''+formlogin.username+'''' +',');
    DataM1.Query1.SQL.add('@Locked = ' + Inttostr(Titemdata(Item.Data).locked));


    IF debug then datam1.Query1.sql.SaveToFile(extractfilepath(application.exename) + 'sqllogs\'+'SPCreateschedule.sql');
    DataM1.Query1.open;
    Titemdata(Item.Data).ScheduleID := DataM1.Query1.Fields[0].asinteger;
    DataM1.Query1.Close;

    IF Titemdata(Item.Data).ScheduleID > 0 then
    begin
      DataM1.Query1.SQL.clear;
      DataM1.Query1.SQL.add('Delete ScheduleInfo where ScheduleID = ' + inttostr(Titemdata(Item.Data).ScheduleID));
      DataM1.Query1.ExecSQL(false);

      DataM1.Query1.SQL.clear;
      DataM1.Query1.SQL.add('Delete ScheduleStatus where ScheduleID = ' + inttostr(Titemdata(Item.Data).ScheduleID));
      DataM1.Query1.ExecSQL(false);

      For i := 0 to NGeneralactions-1 do
      Begin
        IF Titemdata(Item.Data).generalactions[i] then
          insertAstat(1,i);
      End;
      For i := 0 to Nprepressactions-1 do
      Begin
        IF Titemdata(Item.Data).prepressactions[i] then
          insertAstat(2,i);
      End;
      For i := 0 to Nprintactions-1 do
      Begin
        IF Titemdata(Item.Data).printactions[i] then
          insertAstat(3,i);
      End;
      For i := 0 to Npackactions-1 do
      Begin
        IF Titemdata(Item.Data).packactions[i] then
          insertAstat(4,i);
      End;

      insertAInfo(1,Titemdata(Item.Data).GeneralComment);
      insertAInfo(2,Titemdata(Item.Data).prepressComment);
      insertAInfo(3,Titemdata(Item.Data).printComment);
      insertAInfo(4,Titemdata(Item.Data).packComment);

      insertAInfo(5,Titemdata(Item.Data).Generalfiles);


    end;
  End;


end;

Procedure TItemForm.Loadstat(Var aItem : TSPPlanItem);
Var
  StatusType : Longint;
  I : Longint;
Begin
  For i := 0 to 20 do
  begin
    Titemdata(aItem.Data).generalactions[i] := false;
    Titemdata(aItem.Data).prepressactions[i] := false;
    Titemdata(aItem.Data).printactions[i] := false;
    Titemdata(aItem.Data).packactions[i] := false;
  end;

  DataM1.Query2.SQL.clear;
  DataM1.Query2.SQL.add('Select StatusNumber,StatusType,Username,StatusTime From ScheduleStatus (NOLOCK) ');
  DataM1.Query2.SQL.add('where ScheduleID = ' + inttostr(Titemdata(aItem.Data).ScheduleID));
  DataM1.Query2.SQL.add('order by StatusType,StatusNumber');
  DataM1.Query2.open;
  While not DataM1.Query2.eof do
  begin
    StatusType := DataM1.Query2.fields[1].asinteger;
    I := DataM1.Query2.fields[0].asinteger;
    Case StatusType of
      1 : Titemdata(aItem.Data).generalactions[i] := true;
      2 : Titemdata(aItem.Data).prepressactions[i] := true;
      3 : Titemdata(aItem.Data).printactions[i] := true;
      4 : Titemdata(aItem.Data).packactions[i] := true;
    End;
    DataM1.Query2.next;
  end;
  DataM1.Query2.close;
end;

Procedure TItemForm.LoadText(Var aItem : TSPPlanItem);

Var
  astring : String;
  I,totlength,n : Longint;
  T : String;
  Alist : TStrings;
  ReadOK : Boolean;
begin
  ReadOK := false;
  Titemdata(aItem.Data).GeneralComment.clear;
  Titemdata(aItem.Data).Generalfiles.clear;
  Titemdata(aItem.Data).prepressComment.clear;
  Titemdata(aItem.Data).printComment.clear;
  Titemdata(aItem.Data).packComment.clear;

  Alist := TStringList.Create;
  Memotmp.lines.clear;
  try
    DataM1.Query3.sql.clear;
    DataM1.Query3.sql.Add('select Infotext,infotype from ScheduleInfo');
    DataM1.Query3.sql.Add('Where ScheduleID = ' + inttostr(Titemdata(aItem.Data).ScheduleID));
    DataM1.Query3.open;
    While not DataM1.Query3.eof DO
    begin
      Alist.clear;
      astring := '';
      astring := DataM1.Query3.Fields[0].AsString;

      T := '';
      totlength := length(astring);

      while totlength > 1 do
      begin
        n := pos(#13+#10,astring);
        IF n < 1 then
        Begin
          T := astring;
          delete(astring,1,length(astring)+100);
        End
        Else
          T := copy(astring,1,n-1);

        Alist.add(T);
        delete(astring,1,n+1);
        totlength := length(astring);
      end;
      Case DataM1.Query3.Fields[1].Asinteger of
        1 : Begin
              For i := 0 to Alist.count-1 do
                Titemdata(aItem.Data).generalComment.add(Alist[i]);
            End;
        2 : Begin
              For i := 0 to Alist.count-1 do
            Titemdata(aItem.Data).prepressComment.add(Alist[i]);
             End;
        3 : Begin
              For i := 0 to Alist.count-1 do
            Titemdata(aItem.Data).printComment.add(Alist[i]);
            End;
        4 : Begin
              For i := 0 to Alist.count-1 do
              Titemdata(aItem.Data).packComment.add(Alist[i]);
             End;
        5 : Begin
              For i := 0 to Alist.count-1 do
                Titemdata(aItem.Data).generalfiles.add(Alist[i]);
            End;
      end;
      DataM1.Query3.next;
      readok := true;
    End;
    DataM1.Query3.Close;

  Except
    ReadOK := false;
  end;
  Alist.free;


end;



procedure TItemForm.LoadDBItemS;
Var
  aItem : TSPPlanItem;
  ItemColor: TColor;
  StartTime, EndTime: TDateTime;
  AllDay, IsPrivate: Boolean;
  BusyStatus: TSPBusyStatus;
  ScheduleID : Longint;
  Title, Resource: string;

Begin

  formmain.SPDayPlanner1.Source.Clear;

  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.add('Select * from schedules');
  DataM1.Query1.SQL.add('Where PressID = ' + inttostr(tnames1.pressnametoid(formmain.ComboBoxSchedulepress.text)));
  DataM1.Query1.SQL.add('Order by StartTime,scheduleid');

  DataM1.Query1.open;
  While not DataM1.Query1.eof do
  begin
    StartTime := DataM1.Query1.fieldbyname('StartTime').asdatetime;
    EndTime := Incminute(StartTime, DataM1.Query1.fieldbyname('printTime').asInteger);
    if (*formmain.SPDayPlanner1.AllowNewItem(Resource, StartTime, EndTime)*) true then
    begin
      title := DataM1.Query1.fieldbyname('ScheduleName').asstring;
      ItemColor := FormPressplanConfig.getAcolorfromname(DataM1.Query1.fieldbyname('Printtype').asstring);

      Resource := 'Gug';
      aItem := formmain.SPDayPlanner1.Source.AddItem(Resource, Title, StartTime, EndTime, false,
        false, ItemColor, bsBusy);

      aItem.Icons.Clear;
      aItem.Data := Titemdata.Create;

      aItem.Title := title;
      aItem.StartTime := starttime;
      aItem.Endtime := Endtime;

      Titemdata(aItem.Data).ScheduleID := DataM1.Query1.fieldbyname('ScheduleID').asinteger;
      Titemdata(aItem.Data).ScheduleType := DataM1.Query1.fieldbyname('ScheduleType').asinteger;
      Titemdata(aItem.Data).PublicationID := DataM1.Query1.fieldbyname('PublicationID').asinteger;
      Titemdata(aItem.Data).Pubdate := DataM1.Query1.fieldbyname('Pubdate').asdatetime;
      Titemdata(aItem.Data).ScheduleStatus := DataM1.Query1.fieldbyname('Status').asinteger;
      Titemdata(aItem.Data).PressID := DataM1.Query1.fieldbyname('PressID').asinteger;
      Titemdata(aItem.Data).Printtype := DataM1.Query1.fieldbyname('Printtype').asstring;
      Titemdata(aItem.Data).NavOrderNum := DataM1.Query1.fieldbyname('OrderNumber').asstring;
      Titemdata(aItem.Data).StartTime := starttime;
      Titemdata(aItem.Data).Printtime := DataM1.Query1.fieldbyname('printtime').asinteger;
      Titemdata(aItem.Data).Oplag := DataM1.Query1.fieldbyname('Oplag').asinteger;
      Titemdata(aItem.Data).Presstemplate := DataM1.Query1.fieldbyname('Presstemplate').asstring;
      Titemdata(aItem.Data).Priority := DataM1.Query1.fieldbyname('Priority').asinteger;
      Titemdata(aItem.Data).Paper := DataM1.Query1.fieldbyname('Paper').asstring;
      Titemdata(aItem.Data).Glue := DataM1.Query1.fieldbyname('Glue').asstring;
      Titemdata(aItem.Data).Folder := DataM1.Query1.fieldbyname('Folder').asstring;
      Titemdata(aItem.Data).recurrence.RecurID := DataM1.Query1.fieldbyname('recurrenceID').asinteger;
      Titemdata(aItem.Data).ProductionID := DataM1.Query1.fieldbyname('ProductionID').asinteger;
      ItemForm.Loadstat(aItem);
      ItemForm.LoadText(aItem);
      aItem.Save;

      ItemForm.SetIconsOnAItem(aItem);


    End;
    DataM1.Query1.next;
  end;


  DataM1.Query1.Close;



end;


procedure TItemForm.RadioGrouprepeatClick(Sender: TObject);
begin

  if RadioGrouprepeat.itemindex = 1 then
  begin

    FormGentagne.DateTimePickerstartdag.DateTime := StartDateEdit.DateTime;

    IF FormGentagne.showmodal = mrok then
    begin

    end;


  end;
end;

procedure TItemForm.CreateRecurItems(BaseItem : TSPPlanItem;
                                     justforshow : boolean;
                                     SaveToDB   : Boolean);
Var
  aItem : TSPPlanItem;
  ItemColor: TColor;
  StartTime, EndTime: TDateTime;
  AllDay, IsPrivate: Boolean;
  BusyStatus: TSPBusyStatus;
  ScheduleID : Longint;
  Title, Resource: string;

  Fromthisday : Tdatetime;

  I : Longint;

  T : String;

Begin
  Fromthisday := BaseItem.StartTime;
  Fromthisday := Incday(Fromthisday,1);

  Case Titemdata(BaseItem.Data).recurrence.Recurtype of
    1 : Begin
          FormGentagne.Calcdayli(Titemdata(BaseItem.Data).recurrence.Ofevery,Titemdata(BaseItem.Data).recurrence.NumOfActiveRecur,Fromthisday,Titemdata(BaseItem.Data).Printtime);
        end;
    2 : begin
          FormGentagne.CalcWeekly(Titemdata(BaseItem.Data).recurrence.Ofevery,Titemdata(BaseItem.Data).recurrence.NumOfActiveRecur,Fromthisday,Titemdata(BaseItem.Data).recurrence.SelDaysInweek,Titemdata(BaseItem.Data).Printtime);
        End;
    3 : begin
          FormGentagne.CalcMonthly(Titemdata(BaseItem.Data).recurrence.Recurtype,
                                   Titemdata(BaseItem.Data).recurrence.Ofevery,
                                   Titemdata(BaseItem.Data).recurrence.NumOfActiveRecur,
                                   Fromthisday,
                                   Titemdata(BaseItem.Data).recurrence.DayNumber,
                                   Titemdata(BaseItem.Data).recurrence.SelDaysInweek,
                                   Titemdata(BaseItem.Data).Printtime);
        End;
    4 : begin
          FormGentagne.CalcMonthly(Titemdata(BaseItem.Data).recurrence.Recurtype,
                                   Titemdata(BaseItem.Data).recurrence.Ofevery,
                                   Titemdata(BaseItem.Data).recurrence.NumOfActiveRecur,
                                   Fromthisday,
                                   Titemdata(BaseItem.Data).recurrence.DayNumber,
                                   Titemdata(BaseItem.Data).recurrence.SelDaysInweek,
                                   Titemdata(BaseItem.Data).Printtime);
        end;
        //1 dayli,2 weekly, 3 monthly on date, 4 montly on the

  end;

  IF FormGentagne.Nresultdata > Titemdata(BaseItem.Data).recurrence.NumOfActiveRecur then
    FormGentagne.Nresultdata := Titemdata(BaseItem.Data).recurrence.NumOfActiveRecur;



  For i := 1 to FormGentagne.Nresultdata do
  begin
    StartTime := encodedatetime(yearof(FormGentagne.resultdata[i].Adate),monthof(FormGentagne.resultdata[i].Adate),dayof(FormGentagne.resultdata[i].Adate),
                                hourof(Titemdata(BaseItem.Data).StartTime),minuteof(Titemdata(BaseItem.Data).StartTime),0,0);

    EndTime := StartTime;
    EndTime := incminute(EndTime,Titemdata(BaseItem.Data).Printtime);

    title := MakeATitle(StartTime,tnames1.publicationIDtoname(Titemdata(BaseItem.Data).publicationid),
                        inttostr(Titemdata(BaseItem.Data).Npages),
                        inttostr(Titemdata(BaseItem.Data).Oplag),
                        Titemdata(BaseItem.Data).Presstemplate,' Re'+inttostr(i));


    ItemColor := FormPressplanConfig.getAcolorfromname(Titemdata(BaseItem.Data).Printtype);

    Resource := 'Gug';
    aItem := formmain.SPDayPlanner1.Source.AddItem(Resource, Title, StartTime, EndTime, false,
      false, ItemColor, bsBusy);

    aItem.Icons.Clear;
    aItem.Data := Titemdata.Create;

    aItem.Title := title;
    aItem.StartTime := starttime;
    aItem.Endtime := Endtime;

    Titemdata(aItem.Data).ScheduleID := -1;
    IF justforshow then
      Titemdata(aItem.Data).ScheduleType := 0
    else
      Titemdata(aItem.Data).ScheduleType := Titemdata(BaseItem.Data).ScheduleType;



    Titemdata(aItem.Data).Publicationid := Titemdata(BaseItem.Data).Publicationid;
    Titemdata(aItem.Data).Productionid := Titemdata(BaseItem.Data).Productionid;
    Titemdata(aItem.Data).Pubdate := dateof(starttime);
    Titemdata(aItem.Data).ScheduleStatus := Titemdata(BaseItem.Data).ScheduleStatus;
    Titemdata(aItem.Data).PressID := Titemdata(BaseItem.Data).PressID;
    Titemdata(aItem.Data).Printtype := Titemdata(BaseItem.Data).Printtype;
    Titemdata(aItem.Data).NavOrderNum := Titemdata(BaseItem.Data).NavOrderNum;
    Titemdata(aItem.Data).StartTime := starttime;
    Titemdata(aItem.Data).printtime := Titemdata(BaseItem.Data).Printtime;
    Titemdata(aItem.Data).Oplag := Titemdata(BaseItem.Data).Oplag;
    Titemdata(aItem.Data).Presstemplate := Titemdata(BaseItem.Data).Presstemplate;
    Titemdata(aItem.Data).Priority := Titemdata(BaseItem.Data).Priority;
    Titemdata(aItem.Data).Paper := Titemdata(BaseItem.Data).Paper;
    Titemdata(aItem.Data).Glue := Titemdata(BaseItem.Data).Glue;
    Titemdata(aItem.Data).Folder := Titemdata(BaseItem.Data).Folder;
    Titemdata(aItem.Data).recurrence.RecurID := Titemdata(BaseItem.Data).recurrence.RecurID;
    Titemdata(aItem.Data).ProductionID := -1;

    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.add('Select Productionid from pagetable');
    DataM1.Query1.SQL.add('Where Publicationid = ' + inttostr(Titemdata(aItem.Data).PublicationID));
    DataM1.Query1.SQL.add(' and  Pubdate = ' +''''+formatdatetime(sqldateformat, Titemdata(aItem.Data).Pubdate)+'''');
    DataM1.Query1.open;
    IF Not DataM1.Query1.eof then
    begin
      Titemdata(aItem.Data).ScheduleType := 3;
      Titemdata(aItem.Data).Productionid := DataM1.Query1.fields[0].AsInteger;
    end
    Else
    begin
      Titemdata(aItem.Data).ScheduleType := 2;
    end;
    DataM1.Query1.Close;


    aItem.Save;
    ItemForm.SetIconsOnAItem(aItem);

    IF SaveToDB then
    begin
      ItemForm.SaveAItem(aItem);
    end;

  End;
end;

procedure TItemForm.Attach1Click(Sender: TObject);
Var
  l : tlistitem;
begin
  IF OpenDialogAttach.execute then
  begin
    IF ListViewfiles.selected <> nil then
    begin
      l := ListViewfiles.items.Insert(ListViewfiles.selected.Index);
      l.Caption := OpenDialogAttach.filename;
    end
    else
    begin
      l := ListViewfiles.items.add;
      l.Caption := OpenDialogAttach.filename;
    End;
  end;
end;

procedure TItemForm.Remove1Click(Sender: TObject);
Var
  I : Longint;
begin
  For i := ListViewfiles.items.count-1 downto 0 do
  begin
    IF ListViewfiles.items[i].selected  then
    begin
      ListViewfiles.items[i].Delete;
    end
  End;
end;

procedure TItemForm.Deletefile1Click(Sender: TObject);
Var
  I : Longint;
begin
  For i := ListViewfiles.items.count-1 downto 0 do
  begin
    IF ListViewfiles.items[i].selected  then
    begin
      deletefile(ListViewfiles.items[i].caption);
      ListViewfiles.items[i].Delete;
    end
  End;
end;

Function TItemForm.SaveRecur(Item: TSPPlanItem):Longint;
Var
  I : Longint;
  T : String;
Begin
  T := '0000000';
  For i := 0 to 6 do
  begin
    if Titemdata(Item.Data).recurrence.SelDaysInweek[i] then
      T[i+1] := '1';
  end;

  DataM1.Query1.SQL.Clear;
      DataM1.Query3.sql.clear;
    DataM1.Query3.sql.add('DECLARE @MinNumber int');
    DataM1.Query3.sql.add('DECLARE @NewrecurrenceID int');

    DataM1.Query3.sql.add('SET  @MinNumber = 1');
    DataM1.Query3.sql.add('SET  @NewrecurrenceID = @MinNumber');

    DataM1.Query3.sql.add('IF EXISTS (SELECT recurrenceID FROM ScheduleRecurrence)');
    DataM1.Query3.sql.add('BEGIN');
    DataM1.Query3.sql.add('  IF NOT EXISTS (SELECT recurrenceID FROM ScheduleRecurrence WHERE recurrenceID = @MinNumber )');
    DataM1.Query3.sql.add('    SET @NewrecurrenceID = @MinNumber');
    DataM1.Query3.sql.add('  ELSE');
    DataM1.Query3.sql.add('    SET @NewrecurrenceID = (Select top 1 number from allnum');
    DataM1.Query3.sql.add('    where not exists(select recurrenceID from ScheduleRecurrence');
    DataM1.Query3.sql.add('    where allnum.number = ScheduleRecurrence.recurrenceID)');
    DataM1.Query3.sql.add('    and allnum.number >= @MinNumber)');
    DataM1.Query3.sql.add('END');
    DataM1.Query3.sql.add('ELSE');
    DataM1.Query3.sql.add('  SET @NewrecurrenceID = @MinNumber');

    DataM1.Query3.sql.Add('insert ScheduleRecurrence (recurrenceID,recurrenceType,StartDate,StartTime,Printtime,NumOfRecur,NumOfActiveRecur,Ofevery,SelDaysInweek,DayNumber)');

    DataM1.Query3.sql.Add('values (@NewrecurrenceID,'+inttostr(Titemdata(Item.Data).recurrence.Recurtype)+',:StartDate,:StartTime,');
    DataM1.Query3.sql.Add(inttostr(Titemdata(Item.Data).recurrence.Printtime)+',');
    DataM1.Query3.sql.Add(inttostr(Titemdata(Item.Data).recurrence.NumOfRecur)+',');
    DataM1.Query3.sql.Add(inttostr(Titemdata(Item.Data).recurrence.NumOfActiveRecur)+',');
    DataM1.Query3.sql.Add(inttostr(Titemdata(Item.Data).recurrence.Ofevery)+',');
    DataM1.Query3.sql.Add(''''+T+''''+',');
    DataM1.Query3.sql.Add(inttostr(Titemdata(Item.Data).recurrence.DayNumber)+')');

    DataM1.Query3.sql.add('Select @NewrecurrenceID ');

    DataM1.Query3.open;
    SaveRecur := DataM1.Query3.fields[0].asinteger;
    DataM1.Query3.close;

end;



procedure TItemForm.DateTimePickerprinttimeEnter(Sender: TObject);
begin
  lastPrinttime := DateTimePickerprinttime.time;
end;

procedure TItemForm.DateTimePickerprinttimeChange(Sender: TObject);
Var
  LastHour,LastMinute : Longint;
  AktHour,AktMinute : Longint;
begin
  if lastPrinttime <> DateTimePickerprinttime.time then
  begin

    LastHour    := hourof(lastPrinttime);
    LastMinute  := minuteof(lastPrinttime);

    AktHour    := hourof(DateTimePickerprinttime.time);
    AktMinute  := minuteof(DateTimePickerprinttime.time);

    IF AktHour = LastHour then
    begin
      IF LastMinute = 0 then
      begin

        IF (AktMinute > 31) then
        begin
          Dec(akthour);
        end;
        AktMinute := 30;
      end
      Else
      begin
        case AktMinute of
          1..29 : begin
                    AktMinute := 0;
                  end;
          31..59 : begin
                     AktMinute := 0;
                     Inc(akthour);
                   end;
        end;
      end;
    end;

    IF AktHour <= 0 then
    begin
      AktHour := 0;
      AktMinute := 30;
    end;
    IF AktHour > 23 then
    begin
      AktHour := 23;
      AktMinute := 30;
    end;

    DateTimePickerprinttime.time := encodetime(AktHour,AktMinute,0,0);
    lastPrinttime := DateTimePickerprinttime.time;
  End;
end;


Procedure TItemForm.Formtoaktprinttime;
Begin
  aktprinttime := (hourof(DateTimePickerprinttime.time) * 60) + Minuteof(DateTimePickerprinttime.time);
end;

Procedure TItemForm.aktprinttimetoform;
Begin

  DateTimePickerprinttime.time := encodetime(0,0,0,0);

  DateTimePickerprinttime.time := incminute(DateTimePickerprinttime.time,aktprinttime);
end;


Procedure TItemForm.DeleteItemfromDB(ScheduleID : Longint);
Begin
  DataM1.Query3.sql.clear;
  DataM1.Query3.sql.add('Delete Schedules where ScheduleID =  ' + inttostr(ScheduleID));
  formmain.trysql(DataM1.Query3);

  DataM1.Query3.sql.clear;
  DataM1.Query3.sql.add('Delete ScheduleInfo where ScheduleID =  ' + inttostr(ScheduleID));
  formmain.trysql(DataM1.Query3);

  DataM1.Query3.sql.clear;
  DataM1.Query3.sql.add('Delete ScheduleStatus where ScheduleID =  ' + inttostr(ScheduleID));
  formmain.trysql(DataM1.Query3);

  DataM1.Query3.sql.clear;
  DataM1.Query3.sql.add('set lock_timeout 20000');
  DataM1.Query3.sql.add('delete ScheduleRecurrence where');
  DataM1.Query3.sql.add('not exists(Select recurrenceID from schedules');
  DataM1.Query3.sql.add('where schedules.recurrenceID = ScheduleRecurrence.recurrenceID)');
  DataM1.Query3.ExecSQL;


End;

Procedure TItemForm.DeleteItemfromProductionDB(Productionid : longint);
Var
  ScheduleID : Longint;
  recurrenceID : Longint;
Begin
  IF AllowSchedules then
  begin
    DataM1.Query2.sql.clear;
    DataM1.Query2.sql.add('Select ScheduleID from Schedules ' );
    DataM1.Query2.sql.add('where Productionid =  ' + inttostr(Productionid));
    formmain.tryopen(DataM1.Query2);
    While not DataM1.Query2.eof do
    begin
      DeleteItemfromDB(DataM1.Query2.fields[0].AsInteger);
    end;
    DataM1.Query2.Close;
  End;
end;

end.

