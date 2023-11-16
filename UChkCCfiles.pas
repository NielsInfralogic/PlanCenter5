unit UChkCCfiles;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls;

type
  TFormchkccfiles = class(TForm)
    Panel1: TPanel;
    DateTimePicker1: TDateTimePicker;
    CheckBoxnotim: TCheckBox;
    Button1: TButton;
    ListView1: TListView;
    CheckBoxfromdate: TCheckBox;
    RadioGrouppath: TRadioGroup;
    Panel2: TPanel;
    GroupBox2: TGroupBox;
    ProgressBar2: TProgressBar;
    GroupBox1: TGroupBox;
    ProgressBar1: TProgressBar;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Formchkccfiles: TFormchkccfiles;

implementation

uses UTypes,Udata,umain, UUtils, Usettings;

{$R *.dfm}

procedure TFormchkccfiles.Button1Click(Sender: TObject);
Var
  i,n : Longint;
  L : Tlistitem;
  Found : Boolean;
  fname,path,color : String;
  thisMasterCopySeparationSet : Longint;
  thisFileName : String;
begin
  ListView1.Items.Clear;
  ListView1.Repaint;

  ListView1.Items.BeginUpdate;
  ListView1.Visible :=false;

  path := RadioGrouppath.Items[RadioGrouppath.itemindex];
  path := includetrailingbackslash(path);


  (*
  DataM1.Query1.SQL.Clear;
                                         //0           1           2     3      4      5          6             7             8
  DataM1.Query1.SQL.Add('Select distinct p.pubdate,p.pressid,l.Name,e.Name,s.Name,p.PageName,c.ColorName,p.InputTime, p.mastercopyseparationset');
  DataM1.Query1.SQL.Add('from pagetable p, PublicationNames l, EditionNames e, SectionNames s, ColorNames c');
  DataM1.Query1.SQL.Add('where p.PublicationID = l.PublicationID');
  DataM1.Query1.SQL.Add('and p.SectionID = s.SectionID and p.ColorID = c.ColorID and p.UniquePage = 1');
  DataM1.Query1.SQL.Add('and p.Status >= 10');
  IF CheckBoxnotim.Checked then
    DataM1.Query1.SQL.Add('and p.Status < 50');
  IF CheckBoxfromdate.Checked then
    DataM1.Query1.SQL.Add('and p.pubdate >= :pubd');
  DataM1.Query1.SQL.Add('order by p.pubdate,l.Name,e.Name,s.Name,p.PageName,c.ColorName,p.InputTime,pr.PressName, p.mastercopyseparationset');

  IF CheckBoxfromdate.Checked then
    DataM1.Query1.ParamByName('pubd').AsDate := DateTimePicker1.Date;
*)
  DataM1.Query1.SQL.Clear;
                                             //0           1           2           3      4            5          6             7             8                      9
  DataM1.Query1.SQL.Add('Select distinct p.pubdate,p.pressid,p.PublicationID,p.EditionID,p.SectionID,p.PageName,p.ColorID,p.InputTime, p.mastercopyseparationset, P.FileName');
  DataM1.Query1.SQL.Add('from PageTable p WITH (NOLOCK)');
  DataM1.Query1.SQL.Add('where p.Status >= 10');
  IF CheckBoxnotim.Checked then
    DataM1.Query1.SQL.Add('and p.Status < 50');
  IF CheckBoxfromdate.Checked then
    DataM1.Query1.SQL.Add('and p.pubdate >= :pubd');
  DataM1.Query1.SQL.Add('order by p.pubdate,p.pressid,p.PublicationID,p.EditionID,p.SectionID,p.PageName,p.ColorID, p.mastercopyseparationset');

  IF CheckBoxfromdate.Checked then
    DataM1.Query1.ParamByName('pubd').AsDate := DateTimePicker1.Date;




  n := 0;
  IF Prefs.debug then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'chkccfiles.sql');
  DataM1.Query1.open;
  While not DataM1.Query1.eof do
  begin
    Inc(n);
    DataM1.Query1.next;
  End;
  DataM1.Query1.close;
  ProgressBar1.max := n;
  i := 0;

  DataM1.Query1.open;
  ProgressBar1.Position := 0;
  ProgressBar2.Position := 0;
  While not DataM1.Query1.eof do
  begin
    color := tnames1.ColornameIDtoname(DataM1.Query1.fields[6].asinteger);
    thisMasterCopySeparationSet :=  DataM1.Query1.fields[8].AsInteger;
    thisFileName  :=  DataM1.Query1.fields[9].AsString;

    fname := path + inttostr(thisMasterCopySeparationSet)+'.'+color ;

    if (Prefs.NewPreviewNames) then
    begin
      fname := path + thisFileName + '====' + inttostr(thisMasterCopySeparationSet)+'.'+color ;
      if ( NOT Fileexists(fname)) then
        fname := path + inttostr(thisMasterCopySeparationSet)+'.'+color ;
    end;

    found := false;
(*
    For i := 0 to ListView1.Items.count-1 do
    Begin
      if ListView1.Items[i].SubItems[8] = fname then
      begin
        found := true;
        break;
      end;
    end;
  *)

    if not found then
    begin
      l := ListView1.Items.add;
      l.Caption := datetostr(DataM1.Query1.fields[0].AsDateTime);
      l.SubItems.Add(tnames1.pressnameIDtoname(DataM1.Query1.fields[1].asinteger));
      l.SubItems.Add(tnames1.publicationIDtoname(DataM1.Query1.fields[2].asinteger));
      l.SubItems.Add(tnames1.editionIDtoname(DataM1.Query1.fields[3].asinteger));
      l.SubItems.Add(tnames1.sectionIDtoname(DataM1.Query1.fields[4].asinteger));
      l.SubItems.Add(DataM1.Query1.fields[5].asstring);
      l.SubItems.Add(color);
      l.SubItems.Add(datetimetostr(DataM1.Query1.fields[7].AsDateTime));
      l.SubItems.Add(inttostr(thisMasterCopySeparationSet));
      l.SubItems.Add(fname);
      l.SubItems.Add('0');

    end;
    if ListView1.Items.Count mod 100 = 0 then
      ProgressBar1.Position := ListView1.Items.Count;
    DataM1.Query1.next;
  end;
  DataM1.Query1.close;
  ProgressBar1.Position := ListView1.Items.Count;
  ProgressBar2.max := ListView1.Items.count;
  For i := 0 to ListView1.Items.count-1 do
  Begin
    IF fileexists(ListView1.Items[i].SubItems[8]) then
      ListView1.Items[i].SubItems[9] := '1';
    if i mod 100 = 0 then
      ProgressBar2.Position := i;

(*    if ProgressBar2.Position mod 10 = 0 then
      application.ProcessMessages;*)
  End;



  For i := ListView1.Items.count-1 downto 0 do
  Begin
    IF ListView1.Items[i].SubItems[9] = '1' then
      ListView1.Items.Delete(i);

  End;

  ListView1.Items.endUpdate;
  ListView1.Visible :=true;





end;

procedure TFormchkccfiles.FormActivate(Sender: TObject);
Var
  path,pathIP,fname : String;
begin
  ListView1.Items.Clear;
  ListView1.Repaint;

  RadioGrouppath.items.clear;
  DataM1.Query1.SQL.Clear;
  DataM1.Query1.SQL.Add('Select name,CCdatashare,IP from fileservers where Servertype = 1');
  DataM1.Query1.open;
  pathIP := '';
  IF not DataM1.Query1.eof then
  begin
    path := '\\'+DataM1.Query1.fields[0].AsString+'\'+DataM1.Query1.fields[1].AsString+'\CCfiles';
    if DataM1.Query1.fields[2].AsString <> '' then
      pathIP := '\\'+DataM1.Query1.fields[2].AsString+'\'+DataM1.Query1.fields[1].AsString+'\CCfiles';

  end;
  DataM1.Query1.close;
  RadioGrouppath.items.add(path);
  If pathIP <> '' then
    RadioGrouppath.items.add(pathip);
  RadioGrouppath.ItemIndex := 0;

end;

end.
