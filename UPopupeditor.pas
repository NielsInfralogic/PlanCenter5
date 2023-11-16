
{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{                                                       }
{  Copyright (c) 2000,2001 Borland Software Corporation }
{                                                       }
{*******************************************************}

unit UPopupeditor;

interface




uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ActnList, CheckLst, ComCtrls, Menus, ExtCtrls, ImgList,
  ActnMan, ActnCtrls, ActnMenus, Buttons, ActnPopup;

type
  TInfraPopupeditorform = class(TForm)
    TreeView1: TTreeView;
    PopupActionBarEx1: TPopupActionBar;
    PopupMenu1: TPopupMenu;
    Createsubmenu1: TMenuItem;
    Delete1: TMenuItem;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TreeView1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Createsubmenu1Click(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure TreeView1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);

  private

   // FScratchBar: TActionBarItem;

  //  FActiveActionList: TCustomActionList;

  protected
  public
  end;

  TInfraEditpopupDlg = class(TComponent)
  private
  //  Pisopen          : Boolean;
   // Pposiblecategories : Tstringlist;
    PPopupActionBarEx  : TPopupActionBar;

    FEditpopupFrm: TInfraPopupeditorform;
   // FStayOnTop: Boolean;
    FOnClose: TNotifyEvent;
  //  FOnShow: TNotifyEvent;

    procedure SetPopupActionBarEx(const Value: TPopupActionBar);

  protected
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure SetupDlg; virtual;
  public
    procedure initializetree;
    procedure fromtreetomenu;
    constructor Create(AOwner: TComponent); override;
    procedure Show;
    property InfraPopupeditorform: TInfraPopupeditorform read FEditpopupFrm;

  published
    property PopupActionBarEx: TPopupActionBar read PPopupActionBarEx write SetPopupActionBarEx;
//    property OnClose: TNotifyEvent read FOnClose write FOnClose;
//    property OnShow: TNotifyEvent read FOnShow write FOnShow;
  end;

procedure Register;

implementation

{$R *.DFM}
uses Consts, TypInfo, Commctrl;
Type
  Tactiontreedata = record
                      issub : Boolean;
                      Action : tbasicaction;
                    end;

  TactiontreedataPtr = ^Tactiontreedata;
procedure Register;
begin
  RegisterComponents('INFRA', [TInfraEditpopupDlg]);
end;

var
  Popupeditorform: TInfraPopupeditorform;


constructor TInfraEditpopupDlg.Create(AOwner: TComponent);
Begin
  inherited;
end;


procedure TInfraPopupeditorform.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  TInfraEditpopupDlg(self.Owner).fromtreetomenu;


  Action := caFree;
  Popupeditorform := nil;
end;


{ TCustomizeDlg }

procedure TInfraEditpopupDlg.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin

    if AComponent = FEditpopupFrm then
    begin
      FEditpopupFrm := nil;
      if Assigned(FOnClose) then
        FOnClose(Self);
    end;
  end;
end;

procedure TInfraEditpopupDlg.SetupDlg;
begin

  (* hvis der er noget der bør være assigned
  if FActionManager = nil then
    raise Exception.Create(SErrorActionManagerNotAssigned);
  *)

end;

procedure TInfraEditpopupDlg.Show;
begin
  IF PPopupActionBarEx = nil then exit;
  if FEditpopupFrm = nil then
    FEditpopupFrm := TInfraPopupeditorform.Create(Self);


  initializetree;
  FEditpopupFrm.Show;
end;


procedure TInfraEditpopupDlg.SetPopupActionBarEx(const Value: TPopupActionBar);
begin
  if PPopupActionBarEx <> Value then
  begin
    PPopupActionBarEx := value;
  end;
end;

procedure TInfraEditpopupDlg.initializetree;

Var
  TN : ttreenode;

  Procedure doitem(aitem : Tmenuitem);
  Var
    I : Integer;
    actiontreedata : TactiontreedataPtr;
  Begin
    new(actiontreedata);
    tn := FEditpopupFrm.TreeView1.Items.AddChildObject(tn,aitem.Caption,actiontreedata);
    TactiontreedataPtr(tn.Data).issub := false;
    IF aitem.Action <> nil then
    begin
      TactiontreedataPtr(tn.Data).Action := aitem.Action;
      tn.ImageIndex := aitem.ImageIndex;
      tn.selectedIndex := aitem.ImageIndex;
    end;
    IF aitem.Count > 0 then
    begin
      TactiontreedataPtr(tn.Data).issub := true;
      for i := 0 to aitem.Count-1 do
      begin
        doitem(aitem.items[i]);
      end;

    End;
    tn := tn.Parent;
  end;
Var
  I : Integer;

begin
  IF assigned(PPopupActionBarEx.images) then
  begin
    FEditpopupFrm.TreeView1.Images := PPopupActionBarEx.Images;
  end;

  FEditpopupFrm.TreeView1.Items.Clear;
  tn := FEditpopupFrm.TreeView1.Items.AddChildFirst(nil,'Popup menu');
  tn.ImageIndex := -1;
  tn.SelectedIndex := -1;
  for i := 0 to PPopupActionBarEx.Items.Count-1 do
  begin
    doitem(PPopupActionBarEx.Items[i]);
  end;

  FEditpopupFrm.TreeView1.FullExpand;

end;




procedure TInfraPopupeditorform.TreeView1DragDrop(Sender, Source: TObject;
  X, Y: Integer);

function newaction(actionname : string):boolean;
Var
  I : Integer;
Begin
  result := true;
  for i := 0 to TreeView1.Items.Count-1 do
  begin
    if TreeView1.Items[i].Text = actionname then
    begin
      result := false;
      beep;
      break;
    end;
  end;
end;

var
  cannotmoveit : boolean;
  dnode,n : ttreenode;
  actiontreedata : TactiontreedataPtr;
begin
  IF source = sender then
  begin
    IF TreeView1.Selected <> nil Then
    begin
      dnode := TreeView1.GetNodeAt(x,y);
      if dnode <> nil then
      begin
        if dnode.Level = 0 then
        begin
          TreeView1.Selected.MoveTo(dnode,naAddChildFirst		);
        end
        else
        begin
          cannotmoveit := false;
          if TreeView1.Selected.Level < dnode.Level then
          begin
            n := dnode;
            while n.Level > 0 do
            begin
              if n = TreeView1.Selected then
              begin
                cannotmoveit := true;
                break;
              end;
              n := n.Parent;
            end;
          end;
          IF not cannotmoveit then
          begin
            if Tactiontreedata(dnode.Data^).issub then
              TreeView1.Selected.MoveTo(dnode,naAddChildFirst		)
            else
              TreeView1.Selected.MoveTo(dnode,naInsert	);
          end;
        end;

      end;
    end;
  end
  else
  begin
    if source.ClassType = tactiondragobject then
    begin
      IF newaction(Taction(tactiondragobject(source).Actions[0]).caption) then
      begin
        dnode := TreeView1.GetNodeAt(x,y);
        new(actiontreedata);
        Tactiontreedata(actiontreedata^).issub := false;
        Tactiontreedata(actiontreedata^).Action := tactiondragobject(source).Actions[0];
        if dnode.Level = 0 then
        begin
          n := TreeView1.Items.AddChildObject(dnode,Taction(tactiondragobject(source).Actions[0]).caption,actiontreedata);
        end
        else
        begin
          if Tactiontreedata(dnode.Data^).issub then
          begin
            n := TreeView1.Items.AddChildObject(dnode,Taction(tactiondragobject(source).Actions[0]).caption,actiontreedata);
          end
          else
          begin
            n := TreeView1.Items.AddObject(dnode,Taction(tactiondragobject(source).Actions[0]).caption,actiontreedata);
          end;
        end;
        if n <> nil then
        begin
        end;
      End;
    end;


  end;
end;

procedure TInfraPopupeditorform.Createsubmenu1Click(Sender: TObject);
Var
  N,ni : ttreenode;
  actiontreedata : TactiontreedataPtr;
begin
  if TreeView1.Selected <> nil then
  begin
    new(actiontreedata);
    Tactiontreedata(actiontreedata^).issub :=true;

    ni := TreeView1.Selected.getNextSibling;

    if ni <> nil then
      n := TreeView1.Items.InsertObject(ni,'new submenu',actiontreedata)
    else
    begin
      if TreeView1.Selected.Level = 0 then
        n := TreeView1.Items.AddChildObject(TreeView1.Selected,'new submenu',actiontreedata)
      else
        n := TreeView1.Items.InsertObject(TreeView1.Selected,'new submenu',actiontreedata);
      n.ImageIndex := -1;
      n.selectedIndex := -1;
    end;
    IF n <> nil then
    begin
    end;
  end;
end;

procedure TInfraPopupeditorform.Delete1Click(Sender: TObject);
Begin
  if TreeView1.Selected <> nil then
  begin
    TreeView1.Selected.DeleteChildren;
    TreeView1.Selected.Delete;
  End;
End;

procedure TInfraPopupeditorform.BitBtn1Click(Sender: TObject);
begin
  TInfraEditpopupDlg(self.Owner).initializetree;
end;



procedure TInfraEditpopupDlg.fromtreetomenu;

Var
  nameid : Integer;
  Currentsubitem : tmenuitem;
  Itemlevel : Integer;
procedure donodes(anode : ttreenode);
Var
  newitem : tmenuitem;
  N : ttreenode;
Begin
  Inc(nameid);

  newitem := tmenuitem.Create(PPopupActionBarEx);
  newitem.Name := PPopupActionBarEx.Name + 'Menu' + inttostr(nameid);
  newitem.Caption := anode.Text;

  IF Itemlevel > 0 then
    Currentsubitem.Add(newitem)
  else
    PPopupActionBarEx.Items.Add(newitem);

  IF not TactiontreedataPtr(anode.Data).issub then
  Begin
    if TactiontreedataPtr(anode.Data).Action <> nil then
      newitem.Action := TactiontreedataPtr(anode.Data).Action;
  end
  else
  begin
  end;

  if anode.HasChildren then
  begin
    Inc(Itemlevel);
    Currentsubitem := newitem;

    n := anode.getFirstChild;
    while n <> nil do
    begin
      donodes(n);
      n := n.getNextSibling;
    end;
    IF Itemlevel > 0 then
    Begin
      Dec(Itemlevel);
      IF Itemlevel < 0 then Itemlevel := 0;
      Currentsubitem := newitem.Parent;
    end;

  End;


end;


Var
  N : ttreenode;
begin

  PPopupActionBarEx.Items.Clear;
  nameid := 0;
  Itemlevel := 0;
  n := FEditpopupFrm.TreeView1.Items.GetFirstNode;

  if n.HasChildren then
  begin
    n := n.getFirstChild;
    while n <> nil do
    begin
      donodes(n);
      n := n.getNextSibling;
    end;
  end;

end;



procedure TInfraPopupeditorform.TreeView1DragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept :=  (source = sender) or (source.ClassType = tactiondragobject);
end;

initialization
  GroupDescendentsWith(TInfraEditpopupDlg, Controls.TControl);

end.
