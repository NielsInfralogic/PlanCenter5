unit Uconfigemail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, PBExListview;

type
  TFormeditemail = class(TForm)
    GroupBox1: TGroupBox;
    PBExListview1: TPBExListview;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Editto: TEdit;
    EditCC: TEdit;
    CheckBoxattach: TCheckBox;
    BitBtnaddNOskin: TBitBtn;
    BitBtnApply: TBitBtn;
    BitBtnedit: TBitBtn;
    BitBtnDelete: TBitBtn;
    Panel2: TPanel;
    Image1: TImage;
    Label6: TLabel;
    Label7: TLabel;
    GroupBox2: TGroupBox;
    ComboBoxpublication: TComboBox;
    Panel3: TPanel;
    BitBtn1: TBitBtn;
    CheckBoxNotify: TCheckBox;
    Label3: TLabel;
    Editdelineto: TEdit;
    Label4: TLabel;
    Editdelinecc: TEdit;
    Label5: TLabel;
    Editdeadlinesender: TEdit;
    Label8: TLabel;
    Editdeadlinesubject: TEdit;
    Label9: TLabel;
    Editmailsserver: TEdit;
    CheckBoxdeadline: TCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure BitBtnaddNOskinClick(Sender: TObject);
    procedure BitBtnApplyClick(Sender: TObject);
    procedure BitBtnDeleteClick(Sender: TObject);
    procedure BitBtneditClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure ComboBoxpublicationChange(Sender: TObject);
    procedure PBExListview1Click(Sender: TObject);
  private
    Procedure setbuttons(editing : Boolean);
  public
    { Public declarations }
  end;

var
  Formeditemail: TFormeditemail;

implementation

uses umain,Udata;

{$R *.dfm}

procedure TFormeditemail.FormActivate(Sender: TObject);
Var
  l : tlistitem;

begin
  PBExListview1.enabled := false;
  setbuttons(false);
  ComboBoxpublication.Items.Clear;
  ComboBoxpublication.Items := tnames1.publicationnames;
  ComboBoxpublication.Itemindex := 0;

  datam1.Query2.SQL.clear;
  datam1.Query2.SQL.add('select * from PublicationNotifications');
  datam1.Query2.SQL.add('Where PublicationID = '+ inttostr(tnames1.publicationnametoid(ComboBoxpublication.text)));
  datam1.Query2.SQL.add('order by DisapproveNotificationEmailRecipient');
  datam1.Query2.open;
  PBExListview1.items.clear;
  While not datam1.Query2.eof do
  begin
    l := PBExListview1.items.add;
    IF datam1.Query2.fieldbyname('NotifyOnDisapprove').asinteger = 1 then
      l.caption := 'Yes'
    else
      l.caption := 'No';

    l.SubItems.Add(datam1.Query2.fields[2].asstring);
    l.SubItems.Add(datam1.Query2.fields[3].asstring);



    IF datam1.Query2.fields[6].asinteger = 1 then
    begin
      l.SubItems.Add('Yes');
    end
    else
    begin
      l.SubItems.Add('No');
    end;

    IF datam1.Query2.fields[7].asinteger = 1 then
    begin
      l.SubItems.Add('Yes');
    end
    else
    begin
      l.SubItems.Add('No');
    end;
    l.SubItems.Add(datam1.Query2.fields[8].asstring);
    l.SubItems.Add(datam1.Query2.fields[9].asstring);
    l.SubItems.Add(datam1.Query2.fields[10].asstring);
    l.SubItems.Add(datam1.Query2.fields[11].asstring);
    l.SubItems.Add(datam1.Query2.fields[12].asstring);

    datam1.Query2.next;
  end;
  datam1.Query2.close;

  IF PBExListview1.Items.Count > 0 then
  begin
    PBExListview1.Selected := PBExListview1.items[0];
    Editto.Text := PBExListview1.Selected.subitems[0];
    EditCC.Text := PBExListview1.Selected.subitems[1];
    CheckBoxattach.Checked  := PBExListview1.Selected.SubItems[2] = 'Yes';
    CheckBoxNotify.Checked  := PBExListview1.Selected.caption = 'Yes';
  end;



  PBExListview1.enabled := true;
end;

Procedure TFormeditemail.setbuttons(editing : Boolean);
Begin
  BitBtnaddNOskin.Enabled := not editing;
  BitBtnedit.Enabled := (not editing) And (PBExListview1.Selected <> nil);
  BitBtnedit.Visible := (not editing);
  BitBtnDelete.Enabled := PBExListview1.Selected <> nil;
End;

procedure TFormeditemail.BitBtnaddNOskinClick(Sender: TObject);
Var
  l : tlistitem;
  addok : Boolean;
begin
  PBExListview1.enabled := false;
  IF (Editto.Text <> '') then
  begin
    datam1.Query2.SQL.clear;
    datam1.Query2.SQL.add('select TOP 1 DisapproveNotificationEmailRecipient from PublicationNotifications');
    datam1.Query2.SQL.add('Where PublicationID = '+ inttostr(tnames1.publicationnametoid(ComboBoxpublication.text)));
    datam1.Query2.SQL.add('and DisapproveNotificationEmailRecipient = '+ ''''+Editto.Text+'''');

    datam1.Query2.open;
    addok := datam1.Query2.eof;
    datam1.Query2.close;

    If addok then
    begin
      datam1.Query2.SQL.clear;
      datam1.Query2.SQL.add('Insert PublicationNotifications');
      datam1.Query2.SQL.add('values(');
      datam1.Query2.SQL.add(inttostr(tnames1.publicationnametoid(ComboBoxpublication.text))+',');
      datam1.Query2.SQL.add(inttostr(integer(CheckBoxNotify.checked))+',');
      datam1.Query2.SQL.add(''''+Editto.Text+''''+',');
      datam1.Query2.SQL.add(''''+Editcc.Text+''''+',');

      datam1.Query2.SQL.add(''''+Editdeadlinesender.Text+''''+',');
      datam1.Query2.SQL.add(''''+'Disapproved'+''''+',');
      IF CheckBoxattach.Checked then
        datam1.Query2.SQL.add('1,')
      else
        datam1.Query2.SQL.add('0,');



      IF CheckBoxdeadline.Checked then
        datam1.Query2.SQL.add('1,')
      else
        datam1.Query2.SQL.add('0,');

      datam1.Query2.SQL.add(''''+Editdelineto.Text+''''+',');
      datam1.Query2.SQL.add(''''+Editdelinecc.Text+''''+',');
      datam1.Query2.SQL.add(''''+Editdeadlinesender.Text+''''+',');
      datam1.Query2.SQL.add(''''+Editdeadlinesubject.Text+''''+',');
      datam1.Query2.SQL.add(''''+Editmailsserver.Text+'''');
      datam1.Query2.SQL.add(')');
      formmain.trysql(datam1.Query2);

      l := PBExListview1.items.add;
      IF CheckBoxNotify.checked then
        l.Caption := 'Yes'
      else
        l.Caption := 'No';
      l.SubItems.Add(Editto.Text);
      l.SubItems.Add(EditCC.Text);
      IF CheckBoxattach.Checked then
      begin
        l.SubItems.Add('Yes');
      end
      else
      begin
        l.SubItems.Add('No');
      end;

      IF CheckBoxdeadline.Checked then
      begin
        l.SubItems.Add('Yes');
      end
      else
      begin
        l.SubItems.Add('No');
      end;
      l.SubItems.Add(Editdelineto.Text);
      l.SubItems.Add(Editdelinecc.Text);
      l.SubItems.Add(Editdeadlinesender.Text);
      l.SubItems.Add(Editdeadlinesubject.Text);
      l.SubItems.Add(Editmailsserver.Text);


    End
    Else
    begin
      MessageDlg(formmain.InfraLanguage1.Translate('The recipient has already been assigned to this publication'), mtInformation,[mbOk], 0);
    end;
  end;
  setbuttons(false);
  PBExListview1.enabled := true;
end;

procedure TFormeditemail.BitBtnApplyClick(Sender: TObject);
begin
  PBExListview1.enabled := false;
  IF PBExListview1.selected <> nil then
  begin
    datam1.Query2.SQL.clear;
    datam1.Query2.SQL.add('update PublicationNotifications');
    datam1.Query2.SQL.add('set DisapproveNotificationEmailRecipient = '+''''+Editto.text+'''');
    datam1.Query2.SQL.add(',DisapproveNotificationEmailCC = '+''''+EditCC.text+'''');
    datam1.Query2.SQL.add(',NotifyOnDisapprove = '+inttostr(Integer(CheckBoxNotify.checked)));
    datam1.Query2.SQL.add(',AttachPreview = '+inttostr(Integer(CheckBoxattach.checked)));
    datam1.Query2.SQL.add(',NotifyOnDeadline = '+inttostr(Integer(CheckBoxdeadline.checked)));
    datam1.Query2.SQL.add(',DisapproveNotificationEmailSender = '+''''+Editdeadlinesender.text+'''');
    datam1.Query2.SQL.add(',DisapproveNotificationEmailSubject = '+''''+'Disaapproved'+'''');
    datam1.Query2.SQL.add(',DeadlineNotificationEmailRecipient = '+''''+Editdelineto.text+'''');
    datam1.Query2.SQL.add(',DeadlineNotificationEmailCC = '+''''+Editdelinecc.text+'''');
    datam1.Query2.SQL.add(',DeadlineNotificationEmailSender = '+''''+Editdeadlinesender.text+'''');
    datam1.Query2.SQL.add(',DeadlineNotificationEmailSubject = '+''''+Editdeadlinesubject.text+'''');
    datam1.Query2.SQL.add(',MailServer = '+''''+Editmailsserver.text+'''');

    datam1.Query2.SQL.add('Where PublicationID = '+ inttostr(tnames1.publicationnametoid(ComboBoxpublication.text)));
    datam1.Query2.SQL.add('and DisapproveNotificationEmailRecipient = '+ ''''+Editto.Text+'''');
    formmain.trysql(datam1.Query2);
    IF CheckBoxNotify.checked then
      PBExListview1.selected.caption := 'Yes'
    else
      PBExListview1.selected.caption := 'No';
    PBExListview1.selected.SubItems[0] := Editto.text;
    PBExListview1.selected.SubItems[1] := Editcc.text;
    IF CheckBoxattach.Checked then
    begin
      PBExListview1.selected.SubItems[2] := 'Yes';
    end
    else
    begin
      PBExListview1.selected.SubItems[2] := 'No';
    end;

    IF CheckBoxdeadline.Checked then
    begin
      PBExListview1.selected.SubItems[3] :='Yes';
    end
    else
    begin
      PBExListview1.selected.SubItems[3] := 'No';
    end;
    PBExListview1.selected.SubItems[4] := Editdelineto.text;
    PBExListview1.selected.SubItems[5] := Editdelinecc.text;
    PBExListview1.selected.SubItems[6] := Editdeadlinesender.text;
    PBExListview1.selected.SubItems[7] := Editdeadlinesubject.text;
    PBExListview1.selected.SubItems[8] := Editmailsserver.text;
  End;
  setbuttons(false);
  PBExListview1.enabled := true;
end;

procedure TFormeditemail.BitBtnDeleteClick(Sender: TObject);
Var
  l : tlistitem;
begin
  PBExListview1.enabled := false;
  setbuttons(false);

  datam1.Query2.SQL.clear;
  datam1.Query2.SQL.add('Delete PublicationNotifications');
  datam1.Query2.SQL.add('Where PublicationID = '+ inttostr(tnames1.publicationnametoid(ComboBoxpublication.text)));
  datam1.Query2.SQL.add('and DisapproveNotificationEmailRecipient = '+ ''''+PBExListview1.selected.SubItems[0]+'''');
  formmain.trysql(datam1.Query2);

  datam1.Query2.SQL.clear;
  datam1.Query2.SQL.add('select NotifyOnDisapprove,DisapproveNotificationEmailRecipient,DisapproveNotificationEmailCC,AttachPreview from PublicationNotifications');
  datam1.Query2.SQL.add('Where PublicationID = '+ inttostr(tnames1.publicationnametoid(ComboBoxpublication.text)));
  datam1.Query2.SQL.add('order by DisapproveNotificationEmailRecipient');
  datam1.Query2.open;
  PBExListview1.items.clear;
  While not datam1.Query2.eof do
  begin
    l := PBExListview1.items.add;
    IF datam1.Query2.fields[0].AsInteger = 1 then
      l.Caption := 'Yes'
    else
      l.Caption := 'No';
    l.SubItems.Add(datam1.Query2.fields[1].AsString);
    l.SubItems.Add(datam1.Query2.fields[2].AsString);
    IF datam1.Query2.fields[3].asinteger = 1 then
    begin
      l.SubItems.Add('Yes');
    end
    else
    begin
      l.SubItems.Add('No');
    end;
    datam1.Query2.next;
  end;
  datam1.Query2.close;

  IF PBExListview1.Items.Count > 0 then
  begin
    PBExListview1.Selected := PBExListview1.items[0];
    Editto.Text := PBExListview1.Selected.subitems[0];
    EditCC.Text := PBExListview1.Selected.subitems[1];
    CheckBoxattach.Checked  := PBExListview1.Selected.SubItems[2] = 'Yes';
    CheckBoxNotify.Checked  := PBExListview1.Selected.caption = 'Yes';
    CheckBoxdeadline.Checked  := PBExListview1.Selected.SubItems[3] = 'Yes';
    Editdelineto.text := PBExListview1.selected.SubItems[4];
    Editdelinecc.text := PBExListview1.selected.SubItems[5];
    Editdeadlinesender.text := PBExListview1.selected.SubItems[6];
    Editdeadlinesubject.text := PBExListview1.selected.SubItems[7];
    Editmailsserver.text := PBExListview1.selected.SubItems[8];
  end;


  setbuttons(false);
  PBExListview1.enabled := true;
end;

procedure TFormeditemail.BitBtneditClick(Sender: TObject);
begin
  setbuttons(true);
end;

procedure TFormeditemail.BitBtn1Click(Sender: TObject);
Var
  I : Longint;
begin

end;

procedure TFormeditemail.ComboBoxpublicationChange(Sender: TObject);
Var
  l : tlistitem;
begin
  PBExListview1.enabled := false;
  datam1.Query2.SQL.clear;
  datam1.Query2.SQL.add('select * from PublicationNotifications');
  datam1.Query2.SQL.add('Where PublicationID = '+ inttostr(tnames1.publicationnametoid(ComboBoxpublication.text)));
  datam1.Query2.SQL.add('order by DisapproveNotificationEmailRecipient');
  datam1.Query2.open;
  PBExListview1.items.clear;
  While not datam1.Query2.eof do
  begin
    l := PBExListview1.items.add;
    IF datam1.Query2.Fields[1].AsInteger = 1 then
      l.Caption := 'Yes'
    else
      l.Caption := 'No';
    l.SubItems.Add(datam1.Query2.fields[2].AsString);
    l.SubItems.Add(datam1.Query2.fields[3].AsString);
    IF datam1.Query2.fields[6].asinteger = 1 then
    begin
      l.SubItems.Add('Yes');
    end
    else
    begin
      l.SubItems.Add('No');
    end;
   IF datam1.Query2.fields[7].Asinteger = 1 then
    begin
      l.SubItems.Add('Yes');
    end
    else
    begin
      l.SubItems.Add('No');
    end;
    l.SubItems.Add(datam1.Query2.fields[8].asstring);
    l.SubItems.Add(datam1.Query2.fields[9].asstring);
    l.SubItems.Add(datam1.Query2.fields[10].asstring);
    l.SubItems.Add(datam1.Query2.fields[11].asstring);
    l.SubItems.Add(datam1.Query2.fields[12].asstring);


    datam1.Query2.next;
  end;
  datam1.Query2.close;
  IF PBExListview1.Items.Count > 0 then
  begin
    PBExListview1.Selected := PBExListview1.items[0];
    Editto.Text := PBExListview1.Selected.subitems[0];
    EditCC.Text := PBExListview1.Selected.subitems[1];
    CheckBoxattach.Checked  := PBExListview1.Selected.SubItems[2] = 'Yes';
    CheckBoxNotify.Checked  := PBExListview1.Selected.caption = 'Yes';
    CheckBoxdeadline.Checked  := PBExListview1.Selected.SubItems[3] = 'Yes';
    Editdelineto.text := PBExListview1.selected.SubItems[4];
    Editdelinecc.text := PBExListview1.selected.SubItems[5];
    Editdeadlinesender.text := PBExListview1.selected.SubItems[6];
    Editdeadlinesubject.text := PBExListview1.selected.SubItems[7];
    Editmailsserver.text := PBExListview1.selected.SubItems[8];
  end;

  PBExListview1.enabled := true;
end;

procedure TFormeditemail.PBExListview1Click(Sender: TObject);
begin
  IF PBExListview1.Selected <> nil then
  begin
    Editto.Text := PBExListview1.Selected.subitems[0];
    EditCC.Text := PBExListview1.Selected.subitems[1];
    CheckBoxattach.Checked  := PBExListview1.Selected.SubItems[2] = 'Yes';
    CheckBoxNotify.Checked  := PBExListview1.Selected.caption = 'Yes';
    CheckBoxdeadline.Checked  := PBExListview1.Selected.SubItems[3] = 'Yes';
    Editdelineto.text := PBExListview1.selected.SubItems[4];
    Editdelinecc.text := PBExListview1.selected.SubItems[5];
    Editdeadlinesender.text := PBExListview1.selected.SubItems[6];
    Editdeadlinesubject.text := PBExListview1.selected.SubItems[7];
    Editmailsserver.text := PBExListview1.selected.SubItems[8];
  End;
  setbuttons(false);
  BitBtnedit.Enabled := (PBExListview1.Selected <> nil);
  BitBtnedit.Visible := true;
end;

end.
