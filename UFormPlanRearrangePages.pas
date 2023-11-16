unit UFormPlanRearrangePages;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, USyncListBox ;

type
  TPlanRearrangePages = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    BitBtnCancel: TBitBtn;
    BitBtnOK: TBitBtn;
    ListBoxNewPages: TSyncListBox;
    ListBoxOriginalPages : TSyncListBox;
    btnReset: TButton;

 //   procedure FormCreate(Sender: TObject);
    procedure BitBtnOKClick(Sender: TObject);
    procedure ListBoxNewPagesDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ListBoxNewPagesStartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure ListBoxNewPagesDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ListBoxNewPagesMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);


    procedure ListBoxNewPagesClick(Sender: TObject);
    procedure ListBoxNewPagesScroll(Sender: TObject);
    //procedure ListBoxNewPagesMouseWheel(Sender: TObject);
                                 procedure  SyncListBoxes(Sender: TObject; var Done: Boolean) ;
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure btnResetClick(Sender: TObject);
  private
    { Private declarations }
    IdragOrder : Integer;

  public
    { Public declarations }
    Pages : Array[0..255] of String;
    NumberOfPages : Integer;

    procedure InitListBoxes();

  end;

var
  PlanRearrangePages: TPlanRearrangePages;

implementation

{$R *.dfm}



procedure TPlanRearrangePages.btnResetClick(Sender: TObject);
begin
     InitListBoxes();
end;

procedure TPlanRearrangePages.FormMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
begin
     ListBoxOriginalPages.TopIndex := ListBoxNewPages.TopIndex;
end;

procedure TPlanRearrangePages.FormMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
      ListBoxOriginalPages.TopIndex := ListBoxNewPages.TopIndex;
end;

procedure TPlanRearrangePages.FormMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
   ListBoxOriginalPages.TopIndex := ListBoxNewPages.TopIndex;
end;




procedure TPlanRearrangePages.SyncListBoxes(Sender: TObject; var Done: Boolean) ;
var lb: TListBox;
begin
  if ListBoxNewPages.Focused then
   ListBoxOriginalPages.TopIndex:= ListBoxNewPages.TopIndex
  else if ListBoxOriginalPages.Focused
   then ListBoxNewPages.TopIndex:= ListBoxOriginalPages.TopIndex;
end;


procedure TPlanRearrangePages.ListBoxNewPagesScroll(Sender: TObject);
begin
    ListBoxOriginalPages.TopIndex := ListBoxNewPages.TopIndex;
end;

procedure TPlanRearrangePages.ListBoxNewPagesClick(Sender: TObject);
begin
      ListBoxOriginalPages.TopIndex := ListBoxNewPages.TopIndex;
end;

procedure TPlanRearrangePages.BitBtnOKClick(Sender: TObject);
var
  i : Integer;
begin
  for i := 0 to  NumberOfPages-1 do
  begin
    Pages[i] := ListBoxNewPages.Items[i];
  end;

end;

procedure TPlanRearrangePages.InitListBoxes();
var
  i : Integer;
begin
  ListBoxOriginalPages.Items.Clear();
  ListBoxNewPages.Items.Clear();
  for i := 0 to NumberOfPages-1 do
  begin
       ListBoxOriginalPages.Items.Add(Pages[i]);
       ListBoxNewPages.Items.Add(Pages[i]);
  end;

end;





procedure TPlanRearrangePages.ListBoxNewPagesDragDrop(Sender, Source: TObject;
        X, Y: Integer);
var
 i : Integer;
  Apoint : Tpoint;
  Movestr : string;
  movecheck : boolean;
  ListBox: TListBox;
  SelectedItems: TStringList;
  TargetIndex: Integer;
begin
  if (Source <> ListBoxNewPages) OR (Sender <> ListBoxNewPages) then
    exit;
  ListBox := Sender as TListBox;


  TargetIndex := ListBox.ItemAtPos(Point(X, Y),true);
  if (TargetIndex <> -1) then
  begin
    SelectedItems := TStringList.Create;
    try
      ListBox.Items.BeginUpdate;

      try
        for i := ListBox.Items.Count-1 downto 0 do
        begin
          if ListBox.Selected[i] then
          begin
            SelectedItems.AddObject(ListBox.Items[i], ListBox.Items.Objects[i]);
            ListBox.Items.Delete(i);
            if i<TargetIndex then
              Dec(TargetIndex);
          end;
        end;

        for i := SelectedItems.Count-1 downto 0 do
        begin
          ListBox.Items.InsertObject(TargetIndex, SelectedItems[i], SelectedItems.Objects[i]);
          ListBox.Selected[TargetIndex] := True;
          Inc(TargetIndex);
        end;
      finally
        ListBox.Items.EndUpdate;
      end;


    finally
      SelectedItems.Free;
    end;
  end;


end;

procedure TPlanRearrangePages.ListBoxNewPagesDragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
     Accept := Source = ListBoxNewPages;
end;

procedure TPlanRearrangePages.ListBoxNewPagesMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    //StartingPoint.X := X;
   // StartingPoint.Y := Y;
end;



procedure TPlanRearrangePages.ListBoxNewPagesStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  //IdragOrder := ListBoxNewPages.ItemIndex;
end;



end.
