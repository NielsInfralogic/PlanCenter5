unit UCCMessages;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, PBExListview, ExtCtrls, ToolWin, ActnMan, ActnCtrls,
  StdCtrls, ActnList, XPStyleActnCtrls, ImgList, System.Actions,
  System.ImageList;

type
  TFormControlcenterMessages = class(TForm)
    ImageList1: TImageList;
    ImageList2: TImageList;
    ActionManagermes: TActionManager;
    Actiontree: TAction;
    Actionrefresh: TAction;
    Actionread: TAction;
    Actiondelete: TAction;
    Actionsave: TAction;
    Actionprint: TAction;
    Actiononreadonly: TAction;
    Panelmes: TPanel;
    ActionToolBarmes: TActionToolBar;
    Panelb: TPanel;
    Image2: TImage;
    Label2: TLabel;
    Label9: TLabel;
    GroupBox1: TGroupBox;
    TreeViewmessagelist: TTreeView;
    Splitter1: TSplitter;
    GroupBox2: TGroupBox;
    PBExListviewmes: TPBExListview;
    ActionNewmes: TAction;
    ActionNewbroadcast: TAction;
    GroupBoxpageslocation: TGroupBox;
    ComboBoxMessageLocation: TComboBox;
    procedure ActiondeletemessagesExecute(Sender: TObject);
    procedure PBExListviewmesDblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure TreeViewmessagelistChange(Sender: TObject; Node: TTreeNode);

    procedure read;
    procedure refreshtree;
    procedure refreshList;
    procedure FormCreate(Sender: TObject);
    procedure ActiontreeExecute(Sender: TObject);
    procedure ActionrefreshExecute(Sender: TObject);
    procedure ActiondeleteExecute(Sender: TObject);
    procedure ActiononreadonlyExecute(Sender: TObject);
    procedure ActionNewmesExecute(Sender: TObject);
    procedure ActionNewbroadcastExecute(Sender: TObject);
    procedure TreeViewmessagelistCollapsed(Sender: TObject;
      Node: TTreeNode);
    procedure TreeViewmessagelistExpanded(Sender: TObject;
      Node: TTreeNode);

  private
    activated : Boolean;
    procedure Setbluebar;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormControlcenterMessages: TFormControlcenterMessages;

implementation

uses Umain, Udata,utypes, USendmessage, UUser, Ulogin, Usettings;

{$R *.dfm}

procedure TFormControlcenterMessages.refreshtree;

Var
  anode,n : TTreenode;
begin
  Formmain.LoadApagetree(TreeViewmessagelist,'','',ComboBoxMessageLocation.Text,'All','');

  anode := TreeViewmessagelist.Items.GetFirstNode;
  anode.Text := 'All';

end;
procedure TFormControlcenterMessages.refreshList;
Var
  n : TTreenode;
  wherestr : String;
  L : Tlistitem;
  e : Longint;
begin

  PBExListviewmes.items.clear;
  datam1.Query2.SQL.Clear;       //0           1           2      3        4         5       6       7              8         9
  datam1.Query2.SQL.Add('Select MessageID,MessageType,Severity,IsRead,Pubdate,Sender,Receiver,EventTime,PublicationID,Title ');
  datam1.Query2.SQL.Add('From messages');
  datam1.Query2.SQL.Add('where MessageID <> -999');

  IF (not formlogin.ISadministrator) OR (Not formsettings.CheckBoxaddminseeallmes.checked) then
  begin
    datam1.Query2.SQL.Add('and (receiver = '+ ''''+formlogin.username+'''' + ' or receiver = '+ ''''+''+'''' );
    datam1.Query2.SQL.Add(' or sender = ' + ''''+formlogin.username+'''' +')');

  end;


  IF Actiononreadonly.Checked then
    datam1.Query2.SQL.Add('and isread = 0 ');

  datam1.Query2.SQL.Add(' and ( (publicationid >-99 '+ WpublicationStr+ ') or isnull(publicationid,-99) = -99 )');

  IF (TreeViewmessagelist.Selected <> nil) and (TreeViewmessagelist.Items.Count > 0) then
  Begin
    n := TreeViewmessagelist.Selected;
    wherestr := '';

    Case n.Level of
      1 : wherestr := wherestr + ' and '+datam1.makedatastr('',TTreeViewpagestype(n.data^).pubdate);
      2..10 : Begin
                wherestr := wherestr + ' and '+datam1.makedatastr('',TTreeViewpagestype(n.data^).pubdate);
                wherestr := wherestr + ' and publicationid = ' + inttostr(TTreeViewpagestype(n.data^).publicationid);
              end;



    end;
    begin
      Case TTreeViewpagestype(n.data^).Kind of
        2 : Begin

            end;
      end;
      n := n.Parent;
    end;
    datam1.Query2.SQL.Add(wherestr);
  End;

  datam1.Query2.sql.Add('order by EventTime desc');
  IF debug then datam1.Query2.sql.SaveToFile(extractfilepath(application.exename) + 'sqllogs\'+'loadmessages.sql');
  datam1.Query2.open;
  While not datam1.Query2.eof do
  begin
    L := PBExListviewmes.items.add;
    L.Caption := '';
    l.SubItems.Add(datetimetostr(datam1.Query2.fields[7].asdatetime));
    l.SubItems.Add(datam1.Query2.fields[5].asstring);
    l.SubItems.Add(datam1.Query2.fields[6].asstring);
    l.SubItems.Add(datam1.Query2.fields[9].asstring);
    l.SubItems.Add(datam1.Query2.fields[4].asstring);   //pubdate
    l.SubItems.Add(datam1.Query2.fields[8].asstring);   //publicationid
    l.SubItems.Add(datam1.Query2.fields[0].asstring);


    IF datam1.Query2.fields[3].asinteger = 0  then
      l.ImageIndex :=  0
    Else
      l.ImageIndex :=  1;

    IF datam1.Query2.fields[2].asinteger = 0  then
    begin
        l.stateIndex :=  2;
    end
    else
    begin
      l.stateIndex :=  3;
    end;

    datam1.Query2.next;
  end;
  datam1.Query2.Close;
end;

procedure TFormControlcenterMessages.ActiondeletemessagesExecute(Sender: TObject);
begin
  beep;
end;

procedure TFormControlcenterMessages.PBExListviewmesDblClick(Sender: TObject);
begin
  read;
  refreshList;
end;

procedure TFormControlcenterMessages.read;
Begin
  IF PBExListviewmes.Selected <> nil then
  begin
    Formsendmessage.WriteAmessage := false;
    Formsendmessage.ReadMessagefrom := PBExListviewmes.Selected.SubItems[1];
    Formsendmessage.ReadMessageTo   := PBExListviewmes.Selected.SubItems[2];
    Formsendmessage.AktmessageID := strtoint(PBExListviewmes.Selected.SubItems[6]);
    Formsendmessage.Productionmessage := PBExListviewmes.Selected.SubItems[4] <> '';
    IF Formsendmessage.Productionmessage then
    begin
      Formsendmessage.publicationid := strtoint(PBExListviewmes.Selected.SubItems[5]);
      Formsendmessage.pubdate := strtodate(PBExListviewmes.Selected.SubItems[4]);
    end;
    if Formsendmessage.ReadAmessage then
      Formsendmessage.showmodal
    Else
      MessageDlg(formmain.InfraLanguage1.Translate('Error reading message check the list then try again'), mtError,[mbOk], 0);
  End;
  refreshList;
End;

procedure TFormControlcenterMessages.FormActivate(Sender: TObject);
Var
  i2 : Longint;
  Temptoolbar : Tactiontoolbar;
begin
  IF Not activated then
  begin
    //Setbluebar;
    activated := true;

    ComboBoxMessageLocation.Items := formmain.ComboBoxpalocationNy.Items;
    ComboBoxMessageLocation.Itemindex := formmain.ComboBoxpalocationNy.Itemindex;
  end;

  Actiononreadonly.checked := false;
  PBExListviewmes.Items.Clear;
  refreshtree;
  IF TreeViewmessagelist.Items.Count > 0 then
  begin
    TreeViewmessagelist.Selected := TreeViewmessagelist.Items.GetFirstNode;
  end;
end;

procedure TFormControlcenterMessages.TreeViewmessagelistChange(
  Sender: TObject; Node: TTreeNode);
begin
  IF TreeViewmessagelist.Selected <> nil then
  begin
    If TreeViewmessagelist.selected.Level >=2 then
    begin
      ActionNewmes.Enabled := true;
    end
    Else
      ActionNewmes.Enabled := false;
  end
  Else
    ActionNewmes.Enabled := false;
  formmain.Savekeeptrees(ComboBoxMessageLocation.Text,TreeViewmessagelist);
  refreshList;
end;

procedure TFormControlcenterMessages.FormCreate(Sender: TObject);
begin
  Panelmes.DoubleBuffered := true;
  activated := false;
end;

procedure TFormControlcenterMessages.ActiontreeExecute(Sender: TObject);
begin
  refreshtree;
end;

procedure TFormControlcenterMessages.ActionrefreshExecute(Sender: TObject);
begin
  refreshList;
end;

procedure TFormControlcenterMessages.ActiononreadonlyExecute(
  Sender: TObject);
begin
  Actiononreadonly.checked := Not Actiononreadonly.checked;
  refreshList;
end;

procedure TFormControlcenterMessages.Setbluebar;
Var
  I : longint;
  foundit,foundsepcial : Boolean;
  Temptoolbar : Tactiontoolbar;
begin
  for I := 0 to ActionManagermes.ActionBars.Count-1 do
  begin
    ActionManagermes.ActionBars[i].Background.LoadFromFile(extractfilepath(application.ExeName)+'Horztoolbarimage.bmp');
    ActionManagermes.ActionBars[i].BackgroundLayout := blStretch;
  end;
  Temptoolbar := ActionToolBarmes;
  For i := 0 to Temptoolbar.ControlCount-1 do
  begin
   // TCustomButtonControl(Temptoolbar.Controls[i]).setacheckimage(formmain.ImageSelnewbar.Picture.Bitmap,
   //                                                               formmain.ImageSelnewbarMouse.Picture.Bitmap,
  //                                                               true);
  end;
End;

procedure TFormControlcenterMessages.ActiondeleteExecute(Sender: TObject);
Var
  I : Longint;

begin
  try
    if MessageDlg(formmain.InfraLanguage1.Translate('Delete the selected messages ?'),mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      For i := 0 to  PBExListviewmes.Items.Count-1 do
      begin
        IF PBExListviewmes.Items[i].Selected then
        begin
          datam1.Query2.SQL.Clear;
          datam1.Query2.SQL.Add('Delete Messages ');
          datam1.Query2.SQL.Add('Where messageid =  ' + PBExListviewmes.Selected.SubItems[6]);


          IF debug then datam1.Query2.sql.SaveToFile(extractfilepath(application.exename) + 'sqllogs\'+'Delmessages.sql');

          formmain.trysql(datam1.Query2);

        end;
      End;
    End;
  Except
  end;

  refreshList;
end;

procedure TFormControlcenterMessages.ActionNewmesExecute(Sender: TObject);
Var
  I : Longint;
  n : TTreenode;
begin
  Formsendmessage.pubdate := encodedate(1970,1,1);
  Formsendmessage.Productionmessage := true;
  Formsendmessage.WriteAmessage := true;
  For i := 0 to TreeViewmessagelist.items.count-1 do
  begin
    IF TreeViewmessagelist.items[i].Selected  then
    begin
      n := TreeViewmessagelist.items[i];
      Formsendmessage.publicationid := TTreeViewpagestype(n.data^).publicationid;
      Formsendmessage.pubdate := TTreeViewpagestype(n.data^).pubdate;
      Break;
    End;
  End;
  IF Formsendmessage.pubdate > encodedate(2000,1,1) then
    Formsendmessage.showmodal;

  refreshList;
end;


procedure TFormControlcenterMessages.ActionNewbroadcastExecute(
  Sender: TObject);
begin
  Formsendmessage.pubdate := encodedate(1970,1,1);
  Formsendmessage.Productionmessage := false;
  Formsendmessage.WriteAmessage := true;
  Formsendmessage.showmodal;
  refreshList;
end;

procedure TFormControlcenterMessages.TreeViewmessagelistCollapsed(
  Sender: TObject; Node: TTreeNode);
begin
  formmain.Savekeeptrees(ComboBoxMessageLocation.Text,TreeViewmessagelist);
end;

procedure TFormControlcenterMessages.TreeViewmessagelistExpanded(
  Sender: TObject; Node: TTreeNode);
begin
  formmain.Savekeeptrees(ComboBoxMessageLocation.Text,TreeViewmessagelist);
end;

end.
