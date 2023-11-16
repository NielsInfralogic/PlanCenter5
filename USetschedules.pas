unit USetschedules;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms,Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Buttons,
  PBExListview;

type
  TFormSetschedules = class(TForm)
    PBExListview1: TPBExListview;
    Panel2: TPanel;
    Image1: TImage;
    Label6: TLabel;
    Label12: TLabel;
    Panel1: TPanel;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    CheckBoxoonlyunf: TCheckBox;
    Label16: TLabel;
    DateTimePickerpressdate1: TDateTimePicker;
    BitBtn1: TBitBtn;
    DateTimePickerproductiontime: TDateTimePicker;
    procedure PBExListview1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure PBExListview1AdvancedCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage;
      var DefaultDraw: Boolean);
    procedure BitBtn1Click(Sender: TObject);
    procedure PBExListview1Exit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    Pubdate       : Tdatetime;
    PressID       : Longint;
    Publicationid : Longint;
    Editionid     : Longint;
    Sectionid     : Longint;


    Function initselection:Boolean;
  end;

var
  FormSetschedules: TFormSetschedules;

implementation
Uses
  udata,umain,DateUtils, Usettings, UUtils;

{$R *.dfm}



Function TFormSetschedules.initselection:Boolean;
Var
  L : tlistitem;

  Aktpressrunid : Longint;

  Sections : string;
Begin
  result := false;
  try
    PBExListview1.Items.Clear;
    DataM1.Query1.SQL.Clear;                   //0               1            2             3                    4              5                    6            7                8
    DataM1.Query1.SQL.add('Select Distinct p1.publicationid,p1.editionid,p1.sectionid,p1.presssectionnumber,p1.pressrunid,max(p1.deadline),max(p1.presstime),p1.presstime,min(p1.pageindex),p1.pubdate from pagetable p1 WITH (NOLOCK)');
    DataM1.Query1.SQL.add('where p1.active > 0');

    IF Publicationid > 0 then
    begin
      DataM1.Query1.SQL.add('And p1.publicationid = ' + inttostr(Publicationid));
      CheckBoxoonlyunf.checked :=false;
    end;

    IF CheckBoxoonlyunf.checked then
    begin
      DataM1.Query1.SQL.add('And exists(select p2.productionid from pagetable p2 where p2.status < 50 and p1.productionid = p2.productionid)');
    end;
    DataM1.Query1.SQL.add('And '+DataM1.makedatastr('p1.',pubdate));


(*
    Pubdate       : Tdatetime;
    PressID       : Longint;
     : Longint;
    Editionid     : Longint;
    Sectionid     : Longint;
  *)

    DataM1.Query1.SQL.add('group by p1.pubdate,p1.publicationid,p1.editionid,p1.sectionid,p1.presssectionnumber,p1.pressrunid,p1.presstime');
    DataM1.Query1.SQL.add('order by p1.pubdate,p1.publicationid,p1.editionid,p1.sectionid,p1.presssectionnumber,p1.presstime');
    IF Prefs.debug then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'getschedule.sql');
    DataM1.Query1.open;
    Aktpressrunid := -1;
    Sections := '';
    While not DataM1.Query1.eof do
    begin
      IF Aktpressrunid <> DataM1.Query1.fields[4].asinteger then
      begin
        Aktpressrunid := DataM1.Query1.fields[4].asinteger;
        L := PBExListview1.Items.add;
        L.Checked := false;
        L.Caption := tnames1.publicationIDtoname(DataM1.Query1.fields[0].asinteger);
        L.Subitems.add(tnames1.editionIDtoname(DataM1.Query1.fields[1].asinteger));//0
        Sections := tnames1.sectionIDtoname(DataM1.Query1.fields[2].asinteger) + DataM1.Query1.fields[8].asstring;
        L.Subitems.add(Sections);
        L.Subitems.add(inttostr(DataM1.Query1.fields[3].asinteger));               //2
        L.Subitems.add(datetimetostr(DataM1.Query1.fields[6].asdatetime));
        L.Subitems.add(inttostr(DataM1.Query1.fields[4].asinteger));         //8   pressrunid
        L.SubItems.Add('0');//9
      End
      Else
      begin
        Sections := Sections + ','+tnames1.sectionIDtoname(DataM1.Query1.fields[2].asinteger) + DataM1.Query1.fields[8].asstring;
        L.Subitems[1] := Sections;
      end;
      DataM1.Query1.next;
    end;
    DataM1.Query1.close;



    result := PBExListview1.Items.count > 0;
  Except
    result := false;
  end;
end;



procedure TFormSetschedules.PBExListview1SelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);

begin

  try
    IF PBExListview1.selected <> nil then
    Begin
      DateTimePickerpressdate1.date := strtodatetime(PBExListview1.selected.subitems[3]);
      DateTimePickerproductiontime.time := strtodatetime(PBExListview1.selected.subitems[3]);
    End;
    PBExListview1.repaint;

  except

  end;
end;

procedure TFormSetschedules.PBExListview1AdvancedCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  Stage: TCustomDrawStage; var DefaultDraw: Boolean);
begin
  DefaultDraw := true;
end;

procedure TFormSetschedules.BitBtn1Click(Sender: TObject);
Var

  aktpressrun : string;


begin
  if PBExListview1.selected = nil then exit;
  aktpressrun := PBExListview1.selected.subitems[4];
  PBExListview1.selected.Subitems[3] := formmain.dateandtimetostr(DateTimePickerpressdate1.date,
                                                                  DateTimePickerproductiontime.time);

  PBExListview1.selected.Checked := true;

  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.add('update pagetable');
  DataM1.Query1.SQL.add('Set presstime = :presstime');
  DataM1.Query1.SQL.add('Where pressrunid = ' + PBExListview1.selected.subitems[4]);
  DataM1.Query1.ParamByName('presstime').AsDateTime := dateof(DateTimePickerpressdate1.date) + timeof(DateTimePickerproductiontime.time);
  formmain.trysql(DataM1.Query1);


end;

procedure TFormSetschedules.PBExListview1Exit(Sender: TObject);
begin
  PBExListview1.repaint;
end;

procedure TFormSetschedules.FormActivate(Sender: TObject);
begin
  initselection;
end;

procedure TFormSetschedules.BitBtn4Click(Sender: TObject);
begin
  initselection;
end;

end.
