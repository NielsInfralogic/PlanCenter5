unit ULoadcombined;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, PBExListview, ExtCtrls, StdCtrls, Buttons;

type
  TFormloadcombi = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel3: TPanel;
    Image2: TImage;
    Label7: TLabel;
    Label8: TLabel;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    DateTimePicker1: TDateTimePicker;
    ComboBoxpublication: TComboBox;
    Editplanname: TEdit;
    EditCopies: TEdit;
    UpDownCopies: TUpDown;
    CheckBoxAllowunplannedcolors: TCheckBox;
    Editcreep: TEdit;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    Splitter1: TSplitter;
    PBExListview1: TPBExListview;
    ListBoxrunnames: TListBox;
    Editpriority: TEdit;
    UpDown1: TUpDown;
    Label1: TLabel;
    GroupBox3: TGroupBox;
    DateTimePickerdeadtime: TDateTimePicker;
    DateTimePickerdeadlinedate: TDateTimePicker;
  private
    Procedure loadit;
  public
    { Public declarations }
  end;

var
  Formloadcombi: TFormloadcombi;

implementation

uses umain,utypes,Udata;

{$R *.dfm}


Procedure TFormloadcombi.loadit;

begin

  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('Select distinct p5.runname, p1.name,p1.presstemplateid,p2.presstemplateid,p2.pressid,p3.locationid,p3.PressName from planrunnames p5, presstemplatenames p1, presstemplate p2, PressNames p3');
  DataM1.Query1.SQL.Add('where p1.presstemplateid = p2.presstemplateid');
  DataM1.Query1.SQL.Add('and p1.presstemplateid = p5.presstemplateid');
  DataM1.Query1.SQL.Add('and p2.pressid = p3.pressid');
  DataM1.Query1.SQL.Add('and p5.runname = '+''''+ ListBoxrunnames.Items[ListBoxrunnames.Itemindex] +'''');
  DataM1.Query1.SQL.Add('order by p1.name,p3.locationid');

  DataM1.Query1.open;
  While not DataM1.Query1.eof do
  begin
    DataM1.Query2.SQL.Clear;
    DataM1.Query2.SQL.add('Select distinct p1.presstemplateid,p1.publicationid,p1.editionid,p1.sectionid, count(distinct p1.pagename) as antal from presstemplate p1');
    DataM1.Query2.SQL.add('where p1.presstemplateid = '+ DataM1.Query1.Fields[2].asstring);
    DataM1.Query2.SQL.add('and p1.pagetype <> 3');
    DataM1.Query2.SQL.add('GROUP BY p1.presstemplateid,p1.publicationid,p1.editionid,p1.sectionid');
    DataM1.Query2.open;
    DataM1.Query2.close;
    DataM1.Query1.next;
  end;
  DataM1.Query1.close;

(*

  Select distinct p5.runname, p1.name,p1.presstemplateid,p2.presstemplateid,p2.pressid from planrunnames p5, presstemplatenames p1, presstemplate p2');
  DataM1.Query1.SQL.Add('where p1.presstemplateid = p2.presstemplateid');
  DataM1.Query1.SQL.Add('where p1.presstemplateid = p5.presstemplateid');
  DataM1.Query1.SQL.Add('and p5.runname = '+''''+'aa'+'''');
  DataM1.Query1.SQL.Add('order by p1.name');
  if debug then DataM1.Query1.SQL.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'loadpressplannames.sql');
  DataM1.Query1.open;
  ListBoxpresstemplatename.Items.clear;
  while not DataM1.Query1.Eof do
  begin
    ListBoxpresstemplatename.Items.add(DataM1.Query1.fields[0].AsString);
    ListBoxpresstemplatename.Itemindex := 0;
    DataM1.Query1.next;
  end;
  DataM1.Query1.close;
  *)
end;


end.
