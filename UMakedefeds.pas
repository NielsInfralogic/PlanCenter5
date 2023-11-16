unit UMakedefeds;



interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons, CheckLst, Menus,
  PBExListview;

type
  TFormmakeeddefs = class(TForm)
    Panel3: TPanel;
    Image2: TImage;
    Label7: TLabel;
    Label8: TLabel;
    Panel1: TPanel;
    BitBtn2: TBitBtn;
    PopupMenuSetmasterorsub: TPopupMenu;
    Masteredition1: TMenuItem;
    Subedition1: TMenuItem;
    Delete1: TMenuItem;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    ComboBoxpubl: TComboBox;
    GroupBox5: TGroupBox;
    ComboBoxlocation: TComboBox;
    ComboBoxpress: TComboBox;
    Button2: TButton;
    GroupBox1: TGroupBox;
    TreeVieweds: TTreeView;
    GroupBox2: TGroupBox;
    ListBoxeds: TListBox;
    Panel2: TPanel;
    RadioGroupcollection: TRadioGroup;
    GroupBox6: TGroupBox;
    CheckBoxbindingstyle: TCheckBox;
    CheckBoxbackward: TCheckBox;
    CheckBoxprepaired: TCheckBox;
    GroupBox7: TGroupBox;
    EditCopies: TEdit;
    UpDowncopies: TUpDown;
    GroupBox8: TGroupBox;
    Panel5: TPanel;
    CheckListBoxcolors: TCheckListBox;
    GroupBox9: TGroupBox;
    PBExListviewSections: TPBExListview;
    Panel6: TPanel;
    Label2: TLabel;
    ComboBoxplanname: TComboBox;
    BitBtn4: TBitBtn;
    BitBtn3: TBitBtn;
    GroupBox4: TGroupBox;
    BitBtn1: TBitBtn;
    Editnewname: TEdit;
    Panel4: TPanel;
    Label4: TLabel;
    Label6: TLabel;
    Label12: TLabel;
    editto: TEdit;
    ComboBoxSection: TComboBox;
    BitBtnaddrun: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    Editoffset: TEdit;
    UpDown1: TUpDown;
    ButtonClear: TButton;
    procedure TreeViewedsChange(Sender: TObject; Node: TTreeNode);
    procedure TreeViewedsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TreeViewedsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ListBoxedsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBoxplannameSelect(Sender: TObject);
    procedure ComboBoxlocationSelect(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Masteredition1Click(Sender: TObject);
    procedure Subedition1Click(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure BitBtnaddrunClick(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure ButtonClearClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    DragEd : String;
    activated : boolean;
    Splitonconsec : Boolean;
    seltreenodindex : Longint;
    procedure GetColorstr(colorstr : String);
    function isaoknumberofpages(npaget : String):Boolean;
    procedure Loadplanlist;
    procedure Load;

    procedure AddApressrun(InsertPos : Longint);
    Procedure addmanycons(InsertPos : Longint);
  public
    { Public declarations }
  end;

var
  Formmakeeddefs: TFormmakeeddefs;

implementation

{$R *.dfm}
Uses
  UMain,utypes, Udata, Uaddpressrun, Usettings;


procedure TFormmakeeddefs.TreeViewedsChange(Sender: TObject;
  Node: TTreeNode);
begin
  IF not TreeVieweds.Dragging then
  Begin
    seltreenodindex := TreeVieweds.Selected.Index;
  end;

end;

procedure TFormmakeeddefs.TreeViewedsDragDrop(Sender, Source: TObject; X,
  Y: Integer);
Var
  Anode,Nnode,xnode,lnode,gnode : TTreeNode;

  AnItem: TTreeNode;
  AttachMode: TNodeAttachMode;
  HT: THitTests;
  trdat : PTTreeViewpagestype;
begin
  IF TreeVieweds.Items.Count = 0 then
  begin
  end
  else
  begin

    Anode := TreeVieweds.GetNodeAt(X, Y);

    IF Source = ListBoxeds then
    begin
      IF anode <> nil then
      begin
        Case anode.Level of
          1 : begin
                xnode := TreeVieweds.Items[0];
                xnode := xnode.getFirstChild;

                xnode := xnode.getFirstChild;


                New(trdat);
                Nnode := TreeVieweds.Items.addchildobject(anode,ListBoxeds.Items[ListBoxeds.Itemindex],trdat);
                //ListBoxeds.Items.Delete(ListBoxeds.Itemindex);
                Nnode.imageindex := 11;
                Nnode.selectedindex := 11;
                Nnode.stateindex := -1;
                anode.Expand(true);

                IF xnode = nil then
                Begin
                 Nnode.StateIndex := 7;
                End
                Else
                Begin
                  Nnode.StateIndex := 2;
                End;
              end;
          2 : Begin
                New(trdat);
                Nnode := TreeVieweds.Items.addchildobject(anode,ListBoxeds.Items[ListBoxeds.Itemindex],trdat);
                //ListBoxeds.Items.Delete(ListBoxeds.Itemindex);
                Nnode.imageindex := 243;
                Nnode.selectedindex := 243;
                Nnode.stateindex := -1;
                anode.Expand(true);
              end;
          3 : begin
                anode := anode.Parent;
                New(trdat);
                Nnode := TreeVieweds.Items.addchildobject(anode,ListBoxeds.Items[ListBoxeds.Itemindex],trdat);
                //ListBoxeds.Items.Delete(ListBoxeds.Itemindex);
                Nnode.imageindex := 243;
                Nnode.selectedindex := 243;
                Nnode.stateindex := -1;
                anode.Expand(true);
              end;
        end;

      end;
    End
    Else
    begin
      (*
      if TreeVieweds.Selected = nil then Exit;
      HT := TreeVieweds.GetHitTestInfoAt(X, Y) ;
      AnItem := TreeVieweds.GetNodeAt(X, Y) ;
      if (HT -[htOnItem, htOnIcon, htNowhere, htOnIndent] <> HT) then
      begin
        if AnItem <> nil then
        Begin
          IF AnItem.Level = 0 then
          begin // addes til grund node
            TreeVieweds.Selected.MoveTo(AnItem, naAddChild);
          end
          else
          begin // flyttes blant subnoder
            TreeVieweds.Selected.MoveTo(AnItem, naInsert) ;
          end;

        End;
      end;
      *)
    end;
  End;
end;

procedure TFormmakeeddefs.TreeViewedsDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := (Source = ListBoxeds) OR (Source = TreeVieweds);
end;

procedure TFormmakeeddefs.ListBoxedsDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := sender = ListBoxeds;
end;

procedure TFormmakeeddefs.FormActivate(Sender: TObject);
Var
  T : String;
  i : Longint;
  tableexists : Boolean;
begin
  if not activated then
  begin
    DataM1.Query3.SQL.Clear;
    DataM1.Query3.SQL.add('select * from dbo.sysobjects');
    DataM1.Query3.SQL.add('where name = ' + ''''+'ProductionTemplates'+'''');
    DataM1.Query3.open;
    tableexists := not DataM1.Query3.eof;
    DataM1.Query3.close;

    IF Not tableexists then
    begin
      DataM1.Query3.SQL.Clear;
      DataM1.Query3.SQL.add('CREATE TABLE [dbo].[ProductionTemplates](	[PlanID] [int] NOT NULL,	[Name] [varchar](50) NOT NULL,	[Publicationid] [int] NOT NULL,');
      DataM1.Query3.SQL.add('	[Indx] [int] NOT NULL,	[EditionID] [int] NOT NULL,	[Edtype] [int] NOT NULL,	[FromEd] [int] NULL,	[ToEd] [int] NULL,');
      DataM1.Query3.SQL.add('	[Locationid] [int] NULL,	[Pressid] [int] NULL,[IsAmaster] [int] NULL)');
      DataM1.Query3.SQL.add('	ON [PRIMARY]');
      DataM1.Query3.execsql;
    end;

    DataM1.Query3.SQL.Clear;
    DataM1.Query3.SQL.add('select * from dbo.sysobjects');
    DataM1.Query3.SQL.add('where name = ' + ''''+'ProductionTemplatesections'+'''');
    DataM1.Query3.open;
    tableexists := not DataM1.Query3.eof;
    DataM1.Query3.close;

    IF Not tableexists then
    begin
      DataM1.Query3.SQL.Clear;
      DataM1.Query3.SQL.add('CREATE TABLE [dbo].[ProductionTemplatesections]([prodplanid] [int] NULL,	[Presssectionnumber] [int] NULL,	[SectionID] [int] NULL,');
      DataM1.Query3.SQL.add('[Sectionorder] [int] NULL,	[Pages] [varchar](50) NULL,	[Colorids] [varchar](50) NULL,	[Collectionmode] [int] NULL,	[Perfectbound] [int] NULL,	[Prepaired] [int] NULL,');
      DataM1.Query3.SQL.add('[Backwards] [int] NULL,	[Copies] [int] NULL) ON [PRIMARY]');
      DataM1.Query3.execsql;
    End;
  end;

  ListBoxeds.items.clear;
  ListBoxeds.items := tnames1.Editionnames;

  TreeVieweds.Items.Clear;

  ComboBoxpubl.items.clear;
  ComboBoxpubl.items.add('None');
  For i := 0 to tnames1.publicationnames.count-1 do
    ComboBoxpubl.items.add(tnames1.publicationnames[i]);
  ComboBoxpubl.itemindex := 0;

  ComboBoxlocation.items.clear;
  For i := 0 to tnames1.locationnames.count-1 do
    ComboBoxlocation.items.add(tnames1.locationnames[i]);
  ComboBoxlocation.itemindex := 0;


  CheckListBoxcolors.Items.Clear;
  For I := 0 to tNames1.Colornames.Count-1 do
  begin
    IF (Uppercase(tNames1.Colornames[i]) <> 'DINKY') and (Uppercase(tNames1.Colornames[i]) <> 'PDF') then
      CheckListBoxcolors.Items.add(tNames1.Colornames[i]);
  end;

  For i := 0 to CheckListBoxcolors.Items.Count-1 do
  begin
    CheckListBoxcolors.Checked[i] := false;
  End;

  For i := 0 to CheckListBoxcolors.Items.Count-1 do
  begin
    T := uppercase(CheckListBoxcolors.Items[i]);

    if (T = 'K') or (T = 'BLACK') then
    Begin
      CheckListBoxcolors.Checked[i] := true;
      IF formsettings.CheckBoxdefaultK.Checked then
        break;
    End
    Else
    Begin
      IF ((T = 'C') OR (T = 'M') OR (T = 'Y') or (T = 'CYAN') or (T = 'MAGENTA') or (T = 'YELLOW')) and (not formsettings.CheckBoxdefaultK.Checked) then
      Begin
        CheckListBoxcolors.Checked[i] := true;
      End;
    End;
  end;

  CheckListBoxcolors.visible := true;



  ComboBoxlocationSelect(self);
  ComboBoxSection.Items := tnames1.sectionnames;
  ComboBoxSection.Itemindex := 0;
  PBExListviewSections.Items.clear;
  Loadplanlist;
//  load;


end;

procedure TFormmakeeddefs.Loadplanlist;
Begin

  ComboBoxplanname.Items.Clear;

  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.add('Select distinct Name from ProductionTemplates (Nolock)');
  DataM1.Query1.SQL.add('Order by Name ');
  DataM1.Query1.open;
  While not DataM1.Query1.eof do
  begin
    ComboBoxplanname.Items.Add(DataM1.Query1.fields[0].asstring);
    DataM1.Query1.next;
  end;
  DataM1.Query1.close;
  ComboBoxplanname.Itemindex := -1;


End;
procedure TFormmakeeddefs.Load;
Var
  i,planid : Longint;
  Lnode,Nnode,prnode : TTreeNode;
  trdat : PTTreeViewpagestype;
  coloridstr,Aktlocation,aktpress,sections : String;
  L : Tlistitem;
Begin
  planid := 0;
  ListBoxeds.items.clear;
  ListBoxeds.items := tnames1.Editionnames;

  TreeVieweds.Items.clear;
  New(trdat);
  Aktlocation := '';
  aktpress    := '';
  DataM1.Query1.SQL.Clear;     // 0     1        2          3      4       5       6    7      8           9     10
  DataM1.Query1.SQL.add('Select PlanID,Name,Publicationid,Indx,EditionID,Edtype,FromEd,ToEd,Locationid,Pressid,IsAmaster from ProductionTemplates (Nolock)');
  DataM1.Query1.SQL.add('Where name = ' + ''''+ComboBoxplanname.Text+'''');
  DataM1.Query1.SQL.add('order by indx');
  DataM1.Query1.open;

  IF not DataM1.Query1.eof then
  begin
    planid := DataM1.Query1.fields[0].asinteger;
    IF DataM1.Query1.fields[2].asinteger > -1 then
      ComboBoxpubl.ItemIndex := ComboBoxpubl.Items.IndexOf( tnames1.PublicationIDtoname(DataM1.Query1.fields[2].asinteger) );
  end;


  While not DataM1.Query1.eof do
  begin
    IF Aktlocation <> tnames1.locationIDtoname(DataM1.Query1.fields[8].asinteger) then
    Begin
      Aktlocation := tnames1.locationIDtoname(DataM1.Query1.fields[8].asinteger);
      Lnode := TreeVieweds.Items.Addobject(nil,Aktlocation  ,trdat);
      Lnode.imageindex := 59;
      Lnode.selectedindex := 59;
    End;

    IF Aktpress <> tnames1.pressnameIDtoname(DataM1.Query1.fields[9].asinteger) then
    Begin
      Aktpress := tnames1.pressnameIDtoname(DataM1.Query1.fields[9].asinteger);
      prnode := TreeVieweds.Items.AddChildObject(Lnode,Aktpress  ,trdat);
      prnode.imageindex := 42;
      prnode.selectedindex := 42;
    End;

    New(trdat);
    IF DataM1.Query1.fields[5].asinteger = 1 then
    Begin
      Nnode := TreeVieweds.Items.AddChildObject(prnode,tnames1.editionIDtoname(DataM1.Query1.fields[4].asinteger),trdat);
      Nnode.imageindex := 11;
      Nnode.selectedindex := 11;
      Nnode.stateindex := -1;
      IF DataM1.Query1.fields[10].asinteger = 1 then
        Nnode.stateindex := 7
      else
        Nnode.stateindex := 2;
    End
    Else
    Begin
      if nnode.Level = 3 then
        nnode := nnode.Parent;
      Nnode := TreeVieweds.Items.AddChildObject(nnode,tnames1.editionIDtoname(DataM1.Query1.fields[4].asinteger),trdat);
      Nnode.imageindex := 243;
      Nnode.selectedindex := 243;
      Nnode.stateindex := -1;

    End;
    DataM1.Query1.next;
  end;


  DataM1.Query1.close;
  for i := 0 to TreeVieweds.Items.Count-1 do
    TreeVieweds.Items[i].Expand(true);


    PBExListviewSections.Items.clear;

    DataM1.Query1.SQL.Clear;       //0           1                 2             3        4    5
    DataM1.Query1.SQL.add('Select prodplanid,Presssectionnumber,SectionID,Sectionorder,Pages,Colorids,');
                           //6                 7          8         9       10
    DataM1.Query1.SQL.add('Collectionmode,Perfectbound,Prepaired,Backwards,Copies  from ProductionTemplatesections ' );
    DataM1.Query1.SQL.add('Where prodplanid = ' + inttostr(planid) );

    DataM1.Query1.SQL.add('order by Sectionorder' );
    DataM1.Query1.open;
    if not DataM1.Query1.eof then
    begin
      coloridstr := DataM1.Query1.fields[5].asstring;
      GetColorstr(coloridstr);
      RadioGroupcollection.ItemIndex := DataM1.Query1.fields[6].asinteger;
      CheckBoxbindingstyle.checked := DataM1.Query1.fields[7].asinteger = 1;
      CheckBoxprepaired.checked := DataM1.Query1.fields[8].asinteger = 1;
      CheckBoxbackward.checked := DataM1.Query1.fields[9].asinteger = 1;
      EditCopies.Text := DataM1.Query1.fields[10].asstring;

    end;

    While not DataM1.Query1.eof do
    begin
      L := PBExListviewSections.Items.add;
      L.Caption := tnames1.sectionIDtoname(DataM1.Query1.fields[2].asinteger);
      L.SubItems.add(DataM1.Query1.fields[4].asstring);
      L.SubItems.add('0');
      DataM1.Query1.next;
    end;

    DataM1.Query1.close;


end;


procedure TFormmakeeddefs.BitBtn1Click(Sender: TObject);
Var
  asecstr,Newplan,coloridstr,aktsec  : String;
  Nnode,lnode,Pnode,gnode : TTreeNode;
  planid,idx,fromed,toed,frz,toz,i : longint;
  Atend : Boolean;
  runnumber : Longint;
begin

  if (Editnewname.text <> '') And (TreeVieweds.Items.Count > 1)  and (PBExListviewSections.Items.count > 0) then
  begin
    lnode := TreeVieweds.Items[0];
    planid := -1;
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.add('Select distinct PlanID from ProductionTemplates');
    DataM1.Query1.SQL.add('Where name = ' + ''''+Editnewname.text+'''');
    DataM1.Query1.open;
    IF not DataM1.Query1.eof then
    begin
      planid := DataM1.Query1.fields[0].asinteger;
    end;
    DataM1.Query1.Close;

    IF planid > -1 then
    begin
      if MessageDlg('Overwrite exiting plan ' + Editnewname.text, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin

        DataM1.Query1.SQL.Clear;
        DataM1.Query1.SQL.add('delete ProductionTemplatesections where prodplanid = ' + inttostr(planid));
        DataM1.Query1.execsql;

        DataM1.Query1.SQL.Clear;
        DataM1.Query1.SQL.add('delete ProductionTemplates where PlanID = ' + inttostr(planid));
        DataM1.Query1.execsql;
      end
      else
        exit;  
    end;


    planid := -1;
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.add('Select distinct planid from ProductionTemplates');
    DataM1.Query1.SQL.add('Order by planid');
    DataM1.Query1.open;
    idx := 0;
    While not DataM1.Query1.eof do
    begin
      IF DataM1.Query1.fields[0].asinteger - 1 <> idx then
      begin
        planid := DataM1.Query1.fields[0].asinteger -1;
        break;
      end;
      idx := DataM1.Query1.fields[0].asinteger;
    end;
    DataM1.Query1.close;
    IF planid = -1 then
      planid := 1;

    idx := 0;
    frz := 0;

    Atend := false;


    While lnode <> nil do
    begin
      pnode := lnode.getFirstChild;
      while pnode <> nil do
      begin
        gnode := pnode.getFirstChild;
        while gnode <> nil do
        begin

          fromed := tnames1.editionnametoid(gnode.Text);
          toed := 0;
          Inc(idx);
          nnode := gnode.getFirstChild;
          IF nnode <> nil then
            toed   := tnames1.editionnametoid(nnode.Text);
          DataM1.Query1.SQL.Clear;
          DataM1.Query1.SQL.add('Insert ProductionTemplates (PlanID,Name,Publicationid,Indx,EditionID,Edtype,FromEd,ToEd,Locationid,pressid,IsAmaster)' );
          DataM1.Query1.SQL.add('Values (');
          DataM1.Query1.SQL.add(inttostr(PlanID)+','+''''+Editnewname.Text+''''+',');
          DataM1.Query1.SQL.add(inttostr(tnames1.publicationnametoid(ComboBoxpubl.Text) )+',');
          DataM1.Query1.SQL.add(inttostr(idx)+',');
          DataM1.Query1.SQL.add(inttostr(tnames1.editionnametoid(gnode.Text) )+',');
          DataM1.Query1.SQL.add('1,'); //1 geo 2 timed
          DataM1.Query1.SQL.add(inttostr(0)+',');

          DataM1.Query1.SQL.add(inttostr(ToEd)+',');

          DataM1.Query1.SQL.add(inttostr(tnames1.locationnametoid(lnode.text))+',');
          DataM1.Query1.SQL.add(inttostr(tnames1.pressnametoid(Pnode.text))+',');

          IF gnode.StateIndex = 7 then
            DataM1.Query1.SQL.add('1)')
          Else
            DataM1.Query1.SQL.add('0)');


          DataM1.Query1.ExecSQL;
          While nnode <> nil do
          begin
            Inc(idx);
            DataM1.Query1.SQL.Clear;
            DataM1.Query1.SQL.add('Insert ProductionTemplates (PlanID,Name,Publicationid,Indx,EditionID,Edtype,FromEd,ToEd,Locationid,pressid,IsAmaster )' );
            DataM1.Query1.SQL.add('Values (');
            DataM1.Query1.SQL.add(inttostr(PlanID)+','+''''+Editnewname.Text+''''+',');
            DataM1.Query1.SQL.add(inttostr(tnames1.publicationnametoid(ComboBoxpubl.Text) )+',');
            DataM1.Query1.SQL.add(inttostr(idx)+',');
            DataM1.Query1.SQL.add(inttostr(tnames1.editionnametoid(nnode.Text) )+',');
            DataM1.Query1.SQL.add('2,'); //1 geo 2 timed
            DataM1.Query1.SQL.add(inttostr(fromed)+',');
            DataM1.Query1.SQL.add(inttostr(ToEd)+',');
            DataM1.Query1.SQL.add(inttostr(tnames1.locationnametoid(lnode.text))+',');
            DataM1.Query1.SQL.add(inttostr(tnames1.pressnametoid(pnode.text))+',');
            DataM1.Query1.SQL.add('0)');



            DataM1.Query1.ExecSQL;
            nnode := nnode.getNextSibling;
          end;
          gnode := gnode.getNextSibling;
        End;
        pnode := pnode.getNextSibling;
      End;
      lnode := lnode.getNextSibling;
    End;
  end;
  Newplan := ComboBoxplanname.Text;

  coloridstr := '';
  For i := 0 to CheckListBoxcolors.items.count-1 do
  begin

    IF CheckListBoxcolors.Checked[i] then
      coloridstr := coloridstr + inttostr(tnames1.Colornametoid(CheckListBoxcolors.items[i]))  + ',';
  end;
  IF length(coloridstr) > 0 then
    delete(coloridstr,length(coloridstr),5);

  runnumber := 0;
  Aktsec := '';
  For i := 0 to PBExListviewSections.items.count-1 do
  begin
    IF (Aktsec <> PBExListviewSections.items[i].caption) and (RadioGroupcollection.ItemIndex = 0) then
    begin
      Inc(runnumber);
    end;
    Aktsec := PBExListviewSections.items[i].caption;

    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.add('Insert ProductionTemplatesections (prodplanid,Presssectionnumber,SectionID,Sectionorder,Pages,Colorids,');
    DataM1.Query1.SQL.add('Collectionmode,Perfectbound,Prepaired,Backwards,Copies) ' );
    DataM1.Query1.SQL.add('Values (');
    DataM1.Query1.SQL.add(inttostr(PlanID)+',');
    DataM1.Query1.SQL.add(inttostr(runnumber)+',');
    DataM1.Query1.SQL.add(inttostr(tnames1.sectionnametoid(Aktsec))+',');
    DataM1.Query1.SQL.add(inttostr(I)+',');
    DataM1.Query1.SQL.add(PBExListviewSections.items[i].subitems[0]+',');
    DataM1.Query1.SQL.add(''''+coloridstr+''''+',');

    DataM1.Query1.SQL.add(inttostr(RadioGroupcollection.ItemIndex)+',');
    DataM1.Query1.SQL.add(inttostr(integer(CheckBoxbindingstyle.checked))+',');
    DataM1.Query1.SQL.add(inttostr(integer(CheckBoxprepaired.checked))+',');
    DataM1.Query1.SQL.add(inttostr(integer(CheckBoxbackward.checked))+',');
    DataM1.Query1.SQL.add(EditCopies.text +')');
    IF Prefs.debug then datam1.Query1.sql.SaveToFile(extractfilepath(application.exename) + 'sqllogs\'+'Saveprodplan.sql');

    DataM1.Query1.ExecSQL;
  end;

  Loadplanlist;
  ComboBoxplanname.itemindex := ComboBoxplanname.items.IndexOf(newplan);

end;

procedure TFormmakeeddefs.FormCreate(Sender: TObject);
begin
  activated := false;
end;

procedure TFormmakeeddefs.ComboBoxplannameSelect(Sender: TObject);
begin
  Editnewname.Text := ComboBoxplanname.Text;
  Load;
end;

procedure TFormmakeeddefs.ComboBoxlocationSelect(Sender: TObject);
begin
  ComboBoxpress.Items.clear;
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.add('Select PressName from PressNames ' );
  DataM1.Query1.SQL.add('where locationid =  ' + inttostr(tnames1.locationnametoid(ComboBoxlocation.text) ));
  DataM1.Query1.SQL.add('Order by PressName ' );
  DataM1.Query1.open;
  While Not DataM1.Query1.eof do
  begin
    ComboBoxpress.Items.add(DataM1.Query1.fields[0].asstring);
    DataM1.Query1.next;
  end;
  DataM1.Query1.close;
  ComboBoxpress.Itemindex := 0;

end;

procedure TFormmakeeddefs.Button2Click(Sender: TObject);
Var
  i : Longint;
  pnode,Lnode : Ttreenode;
begin
  IF TreeVieweds.Items.Count = 0  then
  Begin
    Lnode := TreeVieweds.Items.Addobject(nil,ComboBoxlocation.text  ,nil);
    Lnode.imageindex := 59;
    Lnode.selectedindex := 59;
    pnode := TreeVieweds.Items.Addchildobject(lnode,ComboBoxpress.text  ,nil);
    pnode.imageindex := 42;
    pnode.selectedindex := 42;
  End
  Else
  Begin
    IF TreeVieweds.Selected = nil then
    begin
      Lnode := nil;
      for i := 0 to TreeVieweds.Items.Count-1 do
      begin
        IF (TreeVieweds.Items[i].Level = 0) and (TreeVieweds.Items[i].Text = ComboBoxlocation.text) then
        Begin
          Lnode := TreeVieweds.Items[i];
          break;
        End;
      end;
      if lnode = nil then
      begin
        Lnode := TreeVieweds.Items.Addobject(nil,ComboBoxlocation.text  ,nil);
        Lnode.imageindex := 59;
        Lnode.selectedindex := 59;
      end;

      pnode := TreeVieweds.Items.Addchildobject(lnode,ComboBoxpress.text  ,nil);
      pnode.imageindex := 42;
      pnode.selectedindex := 42;

    end
    Else
    Begin
      Lnode := TreeVieweds.Selected;
      While Lnode.level > 0 do
        lnode := Lnode.Parent;

      pnode := TreeVieweds.Items.Addchildobject(lnode,ComboBoxpress.text  ,nil);
      pnode.imageindex := 42;
      pnode.selectedindex := 42;

    end;
  End;
  for i := 0 to TreeVieweds.Items.Count-1 do
    TreeVieweds.Items[i].Expand(true);

end;



procedure TFormmakeeddefs.Masteredition1Click(Sender: TObject);
begin
  if TreeVieweds.Selected <> nil then
  begin
    if TreeVieweds.Selected.Level = 2 then
    begin
      TreeVieweds.Selected.StateIndex := 7;
    end;
  end;
end;

procedure TFormmakeeddefs.Subedition1Click(Sender: TObject);
Var
  xnode : Ttreenode;
begin
  if TreeVieweds.Selected <> nil then
  begin
    if TreeVieweds.Selected.Level = 2 then
    begin

      xnode := TreeVieweds.Selected;
      IF xnode.getPrevSibling = nil then
      Begin
        xnode := xnode.Parent;
        xnode := xnode.Parent;
        if xnode.GetPrev = nil then
        Begin
          beep;
          exit;
        End;
      End;
      TreeVieweds.Selected.StateIndex := 2;

    end;
  end;

end;



procedure TFormmakeeddefs.Delete1Click(Sender: TObject);
Var
  xnode,lnode,pnode : Ttreenode;
  I : Longint;
begin
  if TreeVieweds.Selected <> nil then
  begin
    xnode := TreeVieweds.Selected;
    xnode.Delete;
  End;

end;



procedure TFormmakeeddefs.BitBtnaddrunClick(Sender: TObject);
begin
 AddApressrun(-1);
end;

procedure TFormmakeeddefs.AddApressrun(InsertPos : Longint);


Var
  I : Integer;
  l : tlistitem;
  T : string;
  Addok : boolean;
  secexists : boolean;
  Nsplit,sumofsecpage : longint;
begin

  addok := isaoknumberofpages(editto.text);
  sumofsecpage := 0;
  secexists := false;
  For i := 0 to PBExListviewSections.Items.count-1 do
  begin
    if PBExListviewSections.Items[i].Caption = ComboBoxSection.Items[ComboBoxSection.Itemindex] then
    Begin
      secexists := true;
      sumofsecpage := sumofsecpage + FormAddpressrun.npagestrtonpages(PBExListviewSections.Items[i].SubItems[0],Nsplit);
    end;
  end;

  IF secexists then
  begin
    IF strtoint(Editoffset.text) < sumofsecpage then
    begin
      MessageDlg(formmain.InfraLanguage1.Translate('Offset is too low'), mtInformation,[mbOk], 0);
      addok := false;
    end;

  end;

  if addok then
  begin

    if (pos(',',editto.Text) > 0) and (RadioGroupcollection.ItemIndex = 0) then
    begin
      addmanycons(-1);
    end
    Else
    begin
      l := PBExListviewSections.Items.add;
      l.Caption := ComboBoxSection.Items[ComboBoxSection.Itemindex];
      l.SubItems.Add(editto.text);
      l.SubItems.Add(Editoffset.text);

      T := editto.text;
      Splitonconsec := (RadioGroupcollection.itemindex=0) and (pos(',',t) > 0);
      PBExListviewSections.selected := l;
      BitBtn1.Enabled :=  PBExListviewSections.Items.Count > 0;
    End;
  End;
end;

Procedure TFormmakeeddefs.addmanycons(InsertPos : Longint);
Var
  l : tlistitem;
  T,t2 : string;

  Npa,i,ioff : Longint;
  pa : array[1..100] of record
                          npages : Longint;
                          offset : Longint;
                        end;

begin
  Npa := 0;
  ioff := 0;
  T := editto.text;
  t2 := '';
  for i := 1 to length(t) do
  begin
    if (t[i] = ',') then
    begin
      inc(Npa);
      pa[Npa].npages := strtoint(t2);
      pa[Npa].offset := ioff;
      inc(ioff,pa[Npa].npages);
      t2 := '';
    end
    else
    begin
      if t[i] IN tal then
        t2 := t2 + t[i];
    end;
  end;
  if t2 <> '' then
  begin
    inc(Npa);
    pa[Npa].npages := strtoint(t2);
    pa[Npa].offset := ioff;
    inc(ioff,pa[Npa].npages);
    t2 := '';
  end;


  IF Editoffset.text = '' then
    Editoffset.text := '0';

  for i := 1 to npa do
  begin
    IF InsertPos > -1 then
    begin
      l := PBExListviewSections.Items.Insert(InsertPos);
      Inc(InsertPos);
    End
    else
      l := PBExListviewSections.Items.add;
    l.Caption := ComboBoxSection.Items[ComboBoxSection.Itemindex];
    l.SubItems.Add(inttostr(pa[i].npages));
    l.SubItems.Add(inttostr(strtoint(Editoffset.text) + pa[i].offset));
  end;
  Splitonconsec := false;
  PBExListviewSections.selected := l;


end;



procedure TFormmakeeddefs.BitBtn6Click(Sender: TObject);
Var
  addok : boolean;

  I : longint;
  aktsecIn : Longint;
  Insertpos : Longint;

begin
  addok := isaoknumberofpages(editto.text);

  if addok then
  begin
    if (pos(',',editto.Text) > 0) and (RadioGroupcollection.ItemIndex = 0) and (PBExListviewSections.Selected <> nil) then
    begin
      Insertpos := PBExListviewSections.Selected.Index;
      PBExListviewSections.items.Delete(Insertpos);
      addmanycons(Insertpos);
    end
    Else
    Begin
      IF PBExListviewSections.Selected <> nil then
      begin
        PBExListviewSections.Selected.Caption := ComboBoxSection.Items[ComboBoxSection.Itemindex];

        PBExListviewSections.Selected.subitems[0] := editto.text;
        PBExListviewSections.Selected.subitems[1] := Editoffset.text;

      end;
    End;

  End;
end;


function TFormmakeeddefs.isaoknumberofpages(npaget : String):Boolean;
Var
  I : Integer;
Begin
  result := true;
  IF npaget = '' then
  Begin
    result := false;
  End
  else
  begin
    for i := 1 to length(npaget) do
    begin
      if (not (npaget[i] IN tal)) then
      begin
         IF npaget[i]<>',' then
           result := false;
      end;
    end;
  end;
end;


procedure TFormmakeeddefs.BitBtn7Click(Sender: TObject);
begin
  IF PBExListviewSections.Selected <> nil then
    PBExListviewSections.Selected.Delete;

end;


procedure TFormmakeeddefs.GetColorstr(colorstr : String);
Var
  i : Longint;
  T,cl : String;
Begin
  CheckListBoxcolors.Items.clear;
  For I := 0 to tNames1.Colornames.Count-1 do
  begin
    IF (Uppercase(tNames1.Colornames[i]) <> 'DINKY') and (Uppercase(tNames1.Colornames[i]) <> 'PDF') then
      CheckListBoxcolors.Items.add(tNames1.Colornames[i]);
  end;
  For i := 0 to CheckListBoxcolors.Items.Count-1 do
  begin
    CheckListBoxcolors.Checked[i] := false;
  End;

  For i := 0 to CheckListBoxcolors.Items.Count-1 do
  begin
    T := uppercase(CheckListBoxcolors.Items[i]);

    if (T = 'K') or (T = 'BLACK') then
    Begin
      CheckListBoxcolors.Checked[i] := true;
      IF formsettings.CheckBoxdefaultK.Checked then
        break;
    End
    Else
    Begin
      IF ((T = 'C') OR (T = 'M') OR (T = 'Y') or (T = 'CYAN') or (T = 'MAGENTA') or (T = 'YELLOW')) and (not formsettings.CheckBoxdefaultK.Checked) then
      Begin
        CheckListBoxcolors.Checked[i] := true;
      End;
    End;
  end;


  CheckListBoxcolors.visible := true;


  For i := 0 to CheckListBoxcolors.items.count-1 do
  begin
    CheckListBoxcolors.checked[i] := false;
  End;
  While colorstr <> '' do
  begin
    T := '';
    IF pos(',',colorstr) > 0 then
    Begin
      cl := copy(colorstr,1,pos(',',colorstr)-1);
      T := tnames1.ColornameIDtoname(strtoint(cl));
      delete(colorstr,1,pos(',',colorstr));
    End
    else
    Begin
      cl := colorstr;
      T := tnames1.ColornameIDtoname(strtoint(cl));
      colorstr := '';
    End;
    IF T <> '' then
    begin
      For i := 0 to CheckListBoxcolors.items.count-1 do
      begin
        IF CheckListBoxcolors.items[i] = t then
        Begin
          CheckListBoxcolors.checked[i] := true;
          Break;
        End;
      End;
    end;

  end;
End;



procedure TFormmakeeddefs.BitBtn4Click(Sender: TObject);
Var
  planid : Longint;
begin
  planid := -1;

  DataM1.Query1.SQL.Clear;     // 0
  DataM1.Query1.SQL.add('Select PlanID from ProductionTemplates (Nolock)');
  DataM1.Query1.SQL.add('Where name = ' + ''''+ComboBoxplanname.Text+'''');
  DataM1.Query1.open;
  IF not DataM1.Query1.eof then
  begin
    planid := DataM1.Query1.fields[0].asinteger;
  End;

  DataM1.Query1.close;

  IF planid > -1 then
  begin
    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.add('Delete ProductionTemplatesections where prodplanid = ' + inttostr(PlanID) );
    DataM1.Query1.execsql;


    DataM1.Query1.SQL.Clear;
    DataM1.Query1.SQL.add('Delete ProductionTemplates where PlanID = ' + inttostr(PlanID) );
    DataM1.Query1.execsql;


  end;
  TreeVieweds.Items.clear;
  PBExListviewSections.Items.clear;
  Loadplanlist;
end;

procedure TFormmakeeddefs.ButtonClearClick(Sender: TObject);
begin
  PBExListviewSections.Items.Clear;
  editto.Text := '1';
  Editoffset.Text := '0';
  
end;

procedure TFormmakeeddefs.BitBtn3Click(Sender: TObject);
begin
  TreeVieweds.items.clear;
  Editnewname.Text := '';
  PBExListviewSections.items.clear;
 // ComboBoxpubl.ItemIndex := -1;
end;

end.



