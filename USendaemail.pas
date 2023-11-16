unit USendaemail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, PBExListview, ExtCtrls, Buttons;

type
  TFormsendemail = class(TForm)
    Panel2: TPanel;
    Image1: TImage;
    Label6: TLabel;
    Label7: TLabel;
    GroupBox1: TGroupBox;
    PBExListview1: TPBExListview;
    Label1: TLabel;
    Edittitle: TEdit;
    Label2: TLabel;
    Editextrainfo: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
  private
    { Private declarations }
  public
    Publicationid : Longint;
    procedure initialize;
  end;

var
  Formsendemail: TFormsendemail;

implementation

uses Udata;

{$R *.dfm}

procedure TFormsendemail.initialize;
Var
  l : tlistitem;
begin
  datam1.Query2.SQL.clear;
  datam1.Query2.SQL.add('SELECT NotifyOnDisapprove,DisapproveNotificationEmailRecipient,DisapproveNotificationEmailCC,AttachPreview from PublicationNotifications');
  datam1.Query2.SQL.add('WHERE PublicationID = '+ inttostr(Publicationid));
  datam1.Query2.SQL.add('ORDER by DisapproveNotificationEmailRecipient');
  datam1.Query2.open;
  PBExListview1.items.clear;
  While not datam1.Query2.eof do
  begin
    l := PBExListview1.items.add;
    l.checked := datam1.Query2.Fields[0].AsInteger = 1;
    l.SubItems.Add(datam1.Query2.Fields[1].AsString);
    l.SubItems.Add(datam1.Query2.Fields[2].AsString);
    IF datam1.Query2.Fields[3].AsInteger = 1 then
    begin
      l.SubItems.Add('Yes');
    end
    else
    begin
      l.SubItems.Add('No');
    end;
    datam1.Query2.Next;
  end;
  datam1.Query2.Close;
end;


end.
