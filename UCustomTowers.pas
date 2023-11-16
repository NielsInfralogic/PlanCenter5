unit UCustomTowers;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls;

type
  TFormCustomTower = class(TForm)
    Panel2: TPanel;
    Image1: TImage;
    Labelwizardheader1: TLabel;
    Labelwizardheader2: TLabel;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel3: TPanel;
    ListViewCyl: TListView;
    ListView1: TListView;
    ComboBoxTower: TComboBox;
    ComboBoxCyl: TComboBox;
    ComboBoxStack: TComboBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure ComboBoxTowerChange(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    procedure calcylandstack;
  public
    aktpressid : Longint;
    Procedure loadtowerdata;

  end;

var
  FormCustomTower: TFormCustomTower;

implementation
Uses
  umain, Udata;
{$R *.dfm}

procedure TFormCustomTower.FormActivate(Sender: TObject);
Var
  i : Longint;
begin

  ComboBoxCyl.Items.Clear;
  ComboBoxStack.Items.Clear;
  for i := 0 to ComboBoxTower.Items.Count-1 do
  begin
    ComboBoxCyl.Items.add('cyl'+inttostr(i));
    ComboBoxStack.Items.add('Stack'+inttostr(i));
  End;

end;

procedure TFormCustomTower.ComboBoxTowerChange(Sender: TObject);
begin
  calcylandstack;
end;

procedure TFormCustomTower.calcylandstack;
Var
  l2 : tlistitem;
  i2,i3 : Longint;

Begin

  l2 := ListViewCyl.GetItemAt(5,ComboBoxTower.top+3);

  For i3 := 0 to ListViewCyl.items.Count-1 do
  begin
    For i2 := 0 to ListView1.Items.Count-1 do
    begin
      IF (ListView1.Items[i2].SubItems[0] = ComboBoxTower.text) and
         (ListView1.Items[i2].Caption = inttostr(aktpressid)) and
         (ListView1.Items[i2].SubItems[3] = ListViewCyl.items[i3].Caption)  then
      begin
        ListViewCyl.items[i3].SubItems[0] := ComboBoxTower.text;
        ListViewCyl.items[i3].SubItems[1] := ListView1.Items[i2].SubItems[1];
        ListViewCyl.items[i3].SubItems[2] := ListView1.Items[i2].SubItems[2];
        break;
      End;
    End;

  End;

end;

Procedure TFormCustomTower.loadtowerdata;

Function splitstring(Var Astring : string;
                     Var apress : String;
                     Var atower : String;
                     Var atower2 : String;
                     Var astack : String;
                     Var acolor : string):Integer;
Var
  T,tcol,t1 : string;
Begin
  result := 0;
  IF length(Astring) > 5 then
  begin
    IF astring[1] = ',' then
      exit;
    T := astring;
    t1 := t;
    delete(t1,1,pos(',',t1));
    delete(t1,pos(',',t1),100);

    tcol := copy(T,1,pos(',',T)-1);
    delete(T,1,pos(',',T));
    IF tcol = 'CYAN' then
      acolor := 'C';
    IF tcol = 'MAGENTA' then
      acolor := 'M';
    IF tcol = 'YELLOW' then
      acolor := 'Y';
    IF tcol = 'BLACK' then
      acolor := 'K';

    apress := copy(T,1,pos('_',T)-1);
    delete(T,1,pos('_',T));
    atower := copy(T,1,pos('_',T)-1);
    atower2 := atower;
    Delete(atower2,1,2);

    Astring := apress + '_'+copy(Astring,1,pos(',',T));
    astack := T;
    delete(astack,1,pos(',',astack));
    delete(T,1,pos(',',T));

    astring := t1;
    IF (astack <> '') then
    begin
      result := 1;
    end;
  end;
end;

Var
  Alist : TStrings;
  Akttower,aktpress : String;
  Ipress,i : Longint;
  apress,atower,atower2,astack,acolor : string;
  Astring,lastcolor : String;

  Ncolor : Integer;
  T300,i2,pressid : Longint;
  L : tlistitem;
  itsamono : Boolean;

  Tottow : String;
Begin
  pressid := 0;
  Alist := TStringList.Create;
  try
    Alist.LoadFromFile(extractfilepath(application.exename)+'PRESSNAMN.csv');     // OK!
    aktpress := '';
    Akttower := '';
    Ipress := 0;
    T300 := 0;


    Ncolor := 0;
    itsamono := false;
    Tottow := 'TV';
    Tottow := 'D300 TV';
    itsamono := false;

    For i := 0 to Alist.count-1 do
    begin
      IF (POS('D300',Alist[i]) > 0) OR (POS('WEB',Alist[i]) > 0) then
      begin
        Astring := Alist[i];
        IF splitstring(Astring,apress,atower,atower2,astack,acolor) = 1 then
        begin
          Inc(Ncolor);
          IF ((itsamono) or (Ncolor = 5)) then //BLACK BLACK
          begin

            For i2 := 1 to Ncolor-1 do
            begin
              ListView1.Items[ListView1.Items.count-i2].SubItems[0] := Tottow;
            end;
            itsamono := acolor = 'K';
            Tottow := apress+' TV';
            Ncolor := 1;
          end;
          //Inc(towerdata[1].towers[towerdata[1].Ntowers].Ncolors);
          Tottow := Tottow + '-'+atower2;
          L := ListView1.Items.Add;
          L.Caption := apress;
          L.SubItems.Add('');
          L.SubItems.Add(astring);
          L.SubItems.Add(astack);
          L.SubItems.Add(acolor);
          L.SubItems.Add(inttostr(Ncolor));

          lastcolor := acolor;

        end;

      end;
    end;

    For i2 := 1 to Ncolor do
    begin
      ListView1.Items[ListView1.Items.count-i2].SubItems[0] := Tottow;
    end;
    itsamono := acolor = 'K';
    Tottow := apress+' TV';
    Ncolor := 1;
    For i2 := 0 to ListView1.Items.count-1 do
    Begin
      IF pos('WEB',ListView1.Items[i2].caption) > 0 then
      begin
        Tottow := ListView1.Items[i2].SubItems[1];
        delete(Tottow,length(tottow),1);
        ListView1.Items[i2].SubItems[1] := tottow;
        acolor := tottow[length(tottow)];
        tottow := ListView1.Items[i2].SubItems[0];
        delete(tottow,5,100);
        ListView1.Items[i2].SubItems[0] := tottow + ' ' +acolor;
        ListView1.Items[i2].Caption := 'D300';
      end;
      IF (pos('D300 TV',ListView1.Items[i2].SubItems[0]) > 0) then
      Begin
        tottow := ListView1.Items[i2].SubItems[0];
        delete(tottow,1,8);
        ListView1.Items[i2].SubItems[0] := tottow;

        IF pos('S1',ListView1.Items[i2].SubItems[1]) > 0 then
        begin
          ListView1.Items[i2].SubItems[0] := ListView1.Items[i2].SubItems[0] + ' S';
        end
        Else
          ListView1.Items[i2].SubItems[0] := ListView1.Items[i2].SubItems[0] + ' P';
      end;
    end;


    Ncolor := 0;
    itsamono := false;
    Tottow := 'TV';
    Tottow := 'D25 TV';
    itsamono := false;

    For i := 0 to Alist.count-1 do
    begin
      IF (POS('D25',Alist[i]) > 0) OR (POS('WEB',Alist[i]) > 0) then
      begin
        Astring := Alist[i];
        IF splitstring(Astring,apress,atower,atower2,astack,acolor) = 1 then
        begin
          Inc(Ncolor);
          IF ((itsamono) or (Ncolor = 5)) then //BLACK BLACK
          begin

            For i2 := 1 to Ncolor-1 do
            begin
              ListView1.Items[ListView1.Items.count-i2].SubItems[0] := Tottow;
            end;
            itsamono := acolor = 'K';
            Tottow := apress+' TV';
            Ncolor := 1;
          end;
          //Inc(towerdata[1].towers[towerdata[1].Ntowers].Ncolors);
          Tottow := Tottow + '-'+atower2;
          L := ListView1.Items.Add;
          L.Caption := apress;
          L.SubItems.Add('');
          L.SubItems.Add(astring);
          L.SubItems.Add(astack);
          L.SubItems.Add(acolor);
          L.SubItems.Add(inttostr(Ncolor));

          lastcolor := acolor;

        end;

      end;
    end;

    For i2 := 1 to Ncolor do
    begin
      ListView1.Items[ListView1.Items.count-i2].SubItems[0] := Tottow;
    end;
    itsamono := acolor = 'K';
    Tottow := apress+' TV';
    Ncolor := 1;
    For i2 := 0 to ListView1.Items.count-1 do
    Begin
      IF pos('WEB',ListView1.Items[i2].caption) > 0 then
      begin
        Tottow := ListView1.Items[i2].SubItems[1];
        delete(Tottow,length(tottow),1);
        ListView1.Items[i2].SubItems[1] := tottow;
        acolor := tottow[length(tottow)];
        tottow := ListView1.Items[i2].SubItems[0];
        delete(tottow,5,100);
        ListView1.Items[i2].SubItems[0] := tottow + ' ' +acolor;
        ListView1.Items[i2].Caption := 'D25';
      end;
      IF (pos('D25 TV',ListView1.Items[i2].SubItems[0]) > 0) then
      Begin
        tottow := ListView1.Items[i2].SubItems[0];
        delete(tottow,1,7);
        ListView1.Items[i2].SubItems[0] := tottow;

        IF pos('S1',ListView1.Items[i2].SubItems[1]) > 0 then
        begin
          ListView1.Items[i2].SubItems[0] := ListView1.Items[i2].SubItems[0] + ' S';
        end
        Else
          ListView1.Items[i2].SubItems[0] := ListView1.Items[i2].SubItems[0] + ' P';
      end;
    end;


    Ncolor := 0;
    itsamono := false;
    Tottow := 'TV';
    Tottow := '';
    itsamono := false;
    For i := 0 to Alist.count-1 do
    begin
      IF (POS('COMV',Alist[i]) > 0) then
      begin
        Astring := Alist[i];
        IF splitstring(Astring,apress,atower,atower2,astack,acolor) = 1 then
        begin
          Inc(Ncolor);
          IF ((itsamono) or (Ncolor = 5)) then //BLACK BLACK
          begin

            For i2 := 1 to Ncolor-1 do
            begin
              ListView1.Items[ListView1.Items.count-i2].SubItems[0] := Tottow;
            end;
            itsamono := acolor = 'K';
            Tottow := '';
            Ncolor := 1;
          end;
          //Inc(towerdata[1].towers[towerdata[1].Ntowers].Ncolors);
          Tottow := Tottow + '-'+atower2;
          L := ListView1.Items.Add;
          L.Caption := apress;
          L.SubItems.Add('');
          IF itsamono then
            ListView1.Items[ListView1.Items.count-1].SubItems[0] := Tottow;

          L.SubItems.Add(astring);
          L.SubItems.Add(astack);
          L.SubItems.Add(acolor);
          L.SubItems.Add(inttostr(Ncolor));

          lastcolor := acolor;

        end;

      end;
    end;


    For i2 := 0 to ListView1.Items.count-1 do
    Begin
      IF pos('COMV',ListView1.Items[i2].caption) > 0 then
      begin
        Tottow := ListView1.Items[i2].subitems[0];
        delete(Tottow,1,1);
        (*IF length(Tottow) > 5 then
        begin
          delete(Tottow,1,3);
          delete(Tottow,6,8);
        end; *)
        ListView1.Items[i2].subitems[0] := Tottow;

        Tottow := ListView1.Items[i2].subitems[1];
        delete(Tottow,length(Tottow),1);
        ListView1.Items[i2].subitems[1] := Tottow;
        ListView1.Items[i2].subitems[0] := ListView1.Items[i2].subitems[0] +' ' +Tottow[length(Tottow)];
      End;
    End;

    Ncolor := 0;
    itsamono := false;
    Tottow := 'TV';
    Tottow := '';
    itsamono := false;
    For i := 0 to Alist.count-1 do
    begin
      IF (POS('COMA',Alist[i]) > 0) then
      begin
        Astring := Alist[i];
        IF splitstring(Astring,apress,atower,atower2,astack,acolor) = 1 then
        begin
          Inc(Ncolor);
          IF ((itsamono) or (Ncolor = 5)) then //BLACK BLACK
          begin
            For i2 := 1 to Ncolor-1 do
            begin
              ListView1.Items[ListView1.Items.count-i2].SubItems[0] := Tottow;
            end;
            itsamono := acolor = 'K';
            Tottow := '';
            Ncolor := 1;
          end;
          //Inc(towerdata[1].towers[towerdata[1].Ntowers].Ncolors);
          Tottow := Tottow + '-'+atower2;
          IF tottow = '-01' then
            itsamono := true;
          L := ListView1.Items.Add;
          L.Caption := apress;
          L.SubItems.Add('');
          IF (itsamono)  then
            ListView1.Items[ListView1.Items.count-1].SubItems[0] := Tottow;

          L.SubItems.Add(astring);
          L.SubItems.Add(astack);
          L.SubItems.Add(acolor);
          L.SubItems.Add(inttostr(Ncolor));

          lastcolor := acolor;

        end;

      end;
    end;
    For i2 := 1 to Ncolor do
    begin
      ListView1.Items[ListView1.Items.count-i2].SubItems[0] := Tottow;
    end;

    For i2 := 0 to ListView1.Items.count-1 do
    Begin
      IF pos('COMA',ListView1.Items[i2].caption) > 0 then
      begin
        Tottow := ListView1.Items[i2].subitems[0];
        delete(Tottow,1,1);

        ListView1.Items[i2].subitems[0] := Tottow;

        Tottow := ListView1.Items[i2].subitems[1];
        delete(Tottow,length(Tottow),1);
        ListView1.Items[i2].subitems[1] := Tottow;
        ListView1.Items[i2].subitems[0] := ListView1.Items[i2].subitems[0] +' ' +Tottow[length(Tottow)];
      End;
    End;


    For i2 := 0 to ListView1.Items.count-1 do
    Begin
      IF ListView1.Items[i2].caption = 'D300' then
        pressid := 7;
      IF ListView1.Items[i2].caption = 'D25' then
        pressid := 6;
      IF ListView1.Items[i2].caption = 'COMV' then
        pressid := 4;
      IF ListView1.Items[i2].caption = 'COMA' then
        pressid := 8;

      IF (i2 > 0) then
      begin
        if ListView1.Items[i2].subitems[0] = ListView1.Items[i2-1].subitems[0] then
          continue;
      end;
      DataM1.Query1.SQL.Clear;
      DataM1.Query1.SQL.add('Insert PressTowerNames');
      DataM1.Query1.SQL.add('Values(');
      DataM1.Query1.SQL.add(Inttostr(pressid)+',');
      DataM1.Query1.SQL.add(''''+ListView1.Items[i2].subitems[0]+''''+',');
      DataM1.Query1.SQL.add('0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,');
      DataM1.Query1.SQL.add(''''+''+''''+','+''''+''+''''+','+''''+''+''''+','+''''+''+''''+','+''''+''+'''');
      DataM1.Query1.SQL.add(')');
      //DataM1.Query1.ExecSQL(false);
    End;

    For i2 := 0 to ListView1.Items.count-1 do
    Begin
      IF ListView1.Items[i2].caption = 'D300' then
        ListView1.Items[i2].caption := inttostr(7);
      IF ListView1.Items[i2].caption = 'D25' then
        ListView1.Items[i2].caption := inttostr(6);
      IF ListView1.Items[i2].caption = 'COMV' then
        ListView1.Items[i2].caption := inttostr(4);
      IF ListView1.Items[i2].caption = 'COMA' then
        ListView1.Items[i2].caption := inttostr(8);
    End;
  finally
    alist.free;
  end;



end;


procedure TFormCustomTower.SpeedButton1Click(Sender: TObject);
begin
  IF ListViewCyl.Selected <> nil then
  begin
    ListViewCyl.Selected.SubItems[0] := ComboBoxTower.Text;
  end;
end;

procedure TFormCustomTower.SpeedButton2Click(Sender: TObject);
begin
  IF ListViewCyl.Selected <> nil then
  begin
    ListViewCyl.Selected.SubItems[1] := ComboBoxCyl.Text;
  end;
end;

procedure TFormCustomTower.SpeedButton3Click(Sender: TObject);
begin
  IF ListViewCyl.Selected <> nil then
  begin
    ListViewCyl.Selected.SubItems[2] := ComboBoxStack.Text;
  end;
end;

end.
