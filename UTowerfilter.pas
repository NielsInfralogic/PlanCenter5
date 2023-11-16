unit UTowerfilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, CheckLst;

type
  TFormtowerfilter = class(TForm)
    Editname: TEdit;
    Label1: TLabel;
    CheckListBoxtowers: TCheckListBox;
    Label2: TLabel;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    towstring : String;
    procedure Init(add : Boolean);
    procedure maketowstring;
    function gettowINstring(towfilt : String):string;
    { Public declarations }
  end;

var
  Formtowerfilter: TFormtowerfilter;

implementation

uses Udata, Umain,usettings;

{$R *.dfm}

procedure TFormtowerfilter.Init(add : Boolean);
begin
  CheckListBoxtowers.Items.Clear;
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.add('select distinct t.towername  from PressTowerNames t');
  DataM1.Query1.SQL.add('order by t.towername');
  DataM1.Query1.Open;
  while not DataM1.Query1.eof do
  begin
    CheckListBoxtowers.Items.add(DataM1.Query1.fields[0].asstring);
    DataM1.Query1.next;
  end;
  DataM1.Query1.close;



end;



procedure TFormtowerfilter.maketowstring;
Var
  I : Longint;
Begin
  towstring := '';
  For i := 0 to CheckListBoxtowers.Items.Count-1 do
  begin
    if CheckListBoxtowers.Checked[i] then
    begin
      IF towstring <> '' then
        towstring := towstring +',';

      towstring := towstring +CheckListBoxtowers.Items[i];
    end;
  end;
end;

procedure TFormtowerfilter.BitBtn1Click(Sender: TObject);

begin
  maketowstring;
end;


function TFormtowerfilter.gettowINstring(towfilt : String):string;
Var
  i,n : Longint;
  t,
  {t1,}t2 : String;
Begin
  result := '';
  try
    if (Formmain.GroupBoxtowerfilter.visible) and (Formmain.ComboBoxplatetowersfilter.itemindex > 0 ) then
    begin
      for i := 0 to Length(Prefs.TowerNameTranslation)-1 do
      begin
        if (Prefs.TowerNameTranslation[i].Key = towfilt) then
        begin
          t := Prefs.TowerNameTranslation[i].Value;
          n := pos(',',t);

          if n > 0 then
          begin
            while n > 0 do
            begin
              t2 := copy(t,1,n-1);
              result := result+''''+ t2 +''''+',';
              delete(t,1,n);
              n := pos(',',t);
            end;
            if length(t) > 0 then
            begin
              result := result+''''+ t +'''';
            end;
          end
          else
          begin
            result := ''''+ t+'''';
          end;
          break;
        end;
      end;
    end;
  except
  end;
end;

end.

