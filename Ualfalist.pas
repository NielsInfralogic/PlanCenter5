unit Ualfalist;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls;

type
  TFormalfasort = class(TForm)
    ListView1: TListView;
    procedure ListView1AdvancedCustomDrawSubItem(Sender: TCustomListView;
      Item: TListItem; SubItem: Integer; State: TCustomDrawState;
      Stage: TCustomDrawStage; var DefaultDraw: Boolean);
    procedure ListView1AdvancedCustomDraw(Sender: TCustomListView;
      const ARect: TRect; Stage: TCustomDrawStage;
      var DefaultDraw: Boolean);
    procedure ListView1AdvancedCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage;
      var DefaultDraw: Boolean);
    procedure ListView1Compare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
  private
    { Private declarations }
  public
    ColumnToSort : Longint;
    Stopcompare : Longint;
    anychange : boolean;

    { Public declarations }
  end;

var
  Formalfasort: TFormalfasort;

implementation

{$R *.dfm}
uses
  umain,utypes;
procedure TFormalfasort.ListView1AdvancedCustomDrawSubItem(
  Sender: TCustomListView; Item: TListItem; SubItem: Integer;
  State: TCustomDrawState; Stage: TCustomDrawStage;
  var DefaultDraw: Boolean);
begin
  DefaultDraw := false;
end;

procedure TFormalfasort.ListView1AdvancedCustomDraw(
  Sender: TCustomListView; const ARect: TRect; Stage: TCustomDrawStage;
  var DefaultDraw: Boolean);
begin
  DefaultDraw := false;
end;

procedure TFormalfasort.ListView1AdvancedCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  Stage: TCustomDrawStage; var DefaultDraw: Boolean);
begin
  DefaultDraw := false;
end;

procedure TFormalfasort.ListView1Compare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);



Var
  I,Firstdifference : longint;
  Foundnotinorder : Boolean;
  foundonFirstsortcolnumber : boolean;
begin

  //Firstsortcolnumber
  foundonFirstsortcolnumber := false;
  Compare := 0;
  Firstdifference := 0;
  IF item1.Caption <> item2.Caption then
    Firstdifference := -1;

  IF Firstsortcolnumber > 0 then
  begin
    if item1.SubItems[Firstsortcolnumber-1] <> item2.SubItems[Firstsortcolnumber-1] then
    begin
      if not HSCols[HSOrder[Firstsortcolnumber]].Inorder then
      begin
        Compare := CompareText(item1.SubItems[Firstsortcolnumber-1],item2.SubItems[Firstsortcolnumber-1]);
        foundonFirstsortcolnumber := Compare <> 0;
      End;
    end;
  end;


  IF (Firstdifference > -1) and (Compare <=0)then
  begin
    For i := 0 to NaktHScols-1 do
    begin
      IF item1.SubItems[i]<> item2.SubItems[i] then
      begin
        Firstdifference := i;
        break;
      end;
    end;
    if Firstdifference > -1 then
    begin
      if not HSCols[HSOrder[Firstdifference+1]].InOrder then
      begin
        Compare := CompareText(item1.SubItems[Firstdifference],item2.SubItems[Firstdifference]);
      End;
    end;
  end
  Else
  begin
    if not HSCols[HSOrder[Firstdifference+1]].InOrder then
    begin
      Compare := CompareText(item1.Caption,item2.Caption);
    End;
  end;

  if Prefs.FirstColumnDescentingSort then
    Compare := Compare * -1;

  IF Compare >  0 then
  begin
    IF Not anychange then
      anychange := true;
  end;

end;


end.
