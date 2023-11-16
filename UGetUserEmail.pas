unit UGetUserEmail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls;

type
  TFormGetuserEmail = class(TForm)
    Panel1: TPanel;
    Image4: TImage;
    Label2: TLabel;
    Labelaktrep: TLabel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ListView1: TListView;
    RadioGroup1: TRadioGroup;
    procedure FormActivate(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure ListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure ListView1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Productionid : Longint;     //-1 ignore
    Publicationid : Longint;    //-1 ignore

    Procedure getlist;
  end;

var
  FormGetuserEmail: TFormGetuserEmail;

implementation
Uses
  umain, Udata, UUtils;
{$R *.dfm}


Procedure TFormGetuserEmail.getlist;
Var
  custommerID : Longint;
  L : Tlistitem;

Begin
  ListView1.Items.clear;
  Case RadioGroup1.itemindex of
    0 : Begin
          IF Productionid > -1 then
          begin
            custommerID := -1;
            DataM1.Query1.SQL.Clear;
            DataM1.Query1.SQL.add('Select distinct customerid from pagetable');
            DataM1.Query1.SQL.add('where Productionid = ' +inttostr(Productionid));
            DataM1.Query1.SQL.add('and customerid > 0');

            DataM1.Query1.open;
            IF Not DataM1.Query1.eof then
            begin
              custommerID := DataM1.Query1.fields[0].asinteger;
            end;
            DataM1.Query1.close;
          end;


          DataM1.Query1.SQL.Clear;
          DataM1.Query1.SQL.add('Select CustomerName,CustomerEmail from CustomerNames cn ');
          DataM1.Query1.SQL.add('where cn.CustomerEmail <> '+''''+''+'''');
          DataM1.Query1.SQL.add('and ( ');
          DataM1.Query1.SQL.add('(customerid = '+inttostr(custommerID)+') or ');
          DataM1.Query1.SQL.add('(exists (Select pn.CustomerID from PublicationNotifications pn where pn.publicationid = '+inttostr(publicationid)+' and cn.customerid = pn.customerid)))');
          IF Prefs.debug then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'getposibleuser.sql');
          DataM1.Query1.SQL.add('order by cn.CustomerName ');
          DataM1.Query1.open;
          While Not DataM1.Query1.eof do
          begin
            l := ListView1.Items.add;
            L.caption := 'Customer';
            l.SubItems.add(DataM1.Query1.fields[0].asstring);
            l.SubItems.add(DataM1.Query1.fields[1].asstring);
            DataM1.Query1.next;
          end;
          DataM1.Query1.close;

          DataM1.Query1.SQL.Clear;
          DataM1.Query1.SQL.add('Select Username,Email from UserNames un ');
          DataM1.Query1.SQL.add('where un.Email <> '+''''+''+'''');
          DataM1.Query1.SQL.add('and ( ');
          DataM1.Query1.SQL.add('(exists (Select up.UserName from UserPublications up where up.publicationid = '+inttostr(publicationid)+' and un.username = up.username)))');
          IF Prefs.debug then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'getposibleuserpubl.sql');
          DataM1.Query1.open;
          While Not DataM1.Query1.eof do
          begin
            l := ListView1.Items.add;
            L.caption := 'User';
            l.SubItems.add(DataM1.Query1.fields[0].asstring);
            l.SubItems.add(DataM1.Query1.fields[1].asstring);
            DataM1.Query1.next;
          end;
          DataM1.Query1.SQL.add('order by un.Username');
          DataM1.Query1.close;
        End;
    1 : Begin
          DataM1.Query1.SQL.Clear;
          DataM1.Query1.SQL.add('Select Username,Email from UserNames un ');
          DataM1.Query1.SQL.add('where un.Email <> '+''''+''+'''');
          DataM1.Query1.SQL.add('order by un.Username');
          IF Prefs.debug then datam1.Query1.sql.SaveToFile(IncludeTrailingBackSlash(TUtils.GetCommonAppDirectory()) + 'sqllogs\'+'getposibleuserpubl.sql');
          DataM1.Query1.open;
          While Not DataM1.Query1.eof do
          begin
            l := ListView1.Items.add;
            L.caption := 'User';
            l.SubItems.add(DataM1.Query1.fields[0].asstring);
            l.SubItems.add(DataM1.Query1.fields[1].asstring);
            DataM1.Query1.next;
          end;
          DataM1.Query1.SQL.add('order by un.Username');
          DataM1.Query1.close;

        end;
  End;
end;

procedure TFormGetuserEmail.FormActivate(Sender: TObject);
begin
  BitBtn1.Enabled := false;
  RadioGroup1.ItemIndex := 0;
  getlist;
end;

procedure TFormGetuserEmail.RadioGroup1Click(Sender: TObject);
begin
  getlist;
end;

procedure TFormGetuserEmail.ListView1SelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  BitBtn1.Enabled := ListView1.Selected <> nil;
end;

procedure TFormGetuserEmail.ListView1DblClick(Sender: TObject);
begin
  IF ListView1.Selected <> nil then
  begin
    BitBtn1.Click;
  end;
end;

end.
