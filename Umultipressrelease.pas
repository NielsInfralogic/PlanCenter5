unit Umultipressrelease;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, CheckLst, Buttons;

type
  TFormmultipressrelease = class(TForm)
    Panel1: TPanel;
    Splitter1: TSplitter;
    Panel3: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    GroupBox1: TGroupBox;
    CheckListBoxeditions: TCheckListBox;
    GroupBox2: TGroupBox;
    CheckListBoxpresses: TCheckListBox;
    BitBtn3: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }

    Publicationid : Longint;
    Specifikeditionid : Longint;
    locationid : Longint;
    Pubdate : Tdatetime;

    Function Initialize:Boolean;
  end;

var
  Formmultipressrelease: TFormmultipressrelease;

implementation

uses Udata, Usettings, Umain;

{$R *.dfm}

Function TFormmultipressrelease.Initialize:Boolean;
Var
  i : Longint;
Begin
  try
    result := false;
    CheckListBoxpresses.Items.Clear;
    CheckListBoxeditions.Items.Clear;
    datam1.Query1.SQL.Clear;
    datam1.Query1.SQL.Add('Select Distinct Pressid from pagetable where publicationid = ' + inttostr(publicationid));
    DataM1.Query1.SQL.add(' and '+  DataM1.makedatastr('',pubdate));
    DataM1.Query1.SQL.add('and active = 1');
    DataM1.Query1.SQL.add('and locationid = ' + inttostr(locationid));
    DataM1.Query1.open;
    While not DataM1.Query1.eof do
    begin
      CheckListBoxpresses.Items.add(tnames1.pressnameIDtoname(DataM1.Query1.fields[0].asinteger));
      DataM1.Query1.next;
    end;
    DataM1.Query1.close;

    IF Specifikeditionid < 1 then
    begin

      datam1.Query1.SQL.Clear;
      datam1.Query1.SQL.Add('Select Distinct editionid from pagetable where publicationid = ' + inttostr(publicationid));
      DataM1.Query1.SQL.add(' and '+  DataM1.makedatastr('',pubdate));
      DataM1.Query1.SQL.add('and active = 1');
      DataM1.Query1.SQL.add('and locationid = ' + inttostr(locationid));
      DataM1.Query1.open;
      While not DataM1.Query1.eof do
      begin
        CheckListBoxeditions.Items.add(tnames1.editionIDtoname(DataM1.Query1.fields[0].asinteger));
        DataM1.Query1.next;
      end;
      DataM1.Query1.close;
    End;

    result := true;
  Except


  end;
End;

end.
