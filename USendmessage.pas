unit USendmessage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Menus;

type
  TFormsendmessage = class(TForm)
    MemoMessage: TMemo;
    Panel1: TPanel;
    Panelb: TPanel;
    Image2: TImage;
    Label2: TLabel;
    Label9: TLabel;
    BitBtnSend: TBitBtn;
    BitBtncancel: TBitBtn;
    PopupMenu1: TPopupMenu;
    Autoheader1: TMenuItem;
    GroupBox1: TGroupBox;
    Editsubject: TEdit;
    BitBtnreply: TBitBtn;
    BitBtnClose: TBitBtn;
    GroupBoxusers: TGroupBox;
    ComboBoxTo: TComboBox;
    CheckBoxSevier: TCheckBox;
    Label1: TLabel;
    ComboBoxFrom: TComboBox;
    Label3: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure BitBtnSendClick(Sender: TObject);
    procedure Autoheader1Click(Sender: TObject);
    procedure BitBtnreplyClick(Sender: TObject);
  private
    { Private declarations }
  public
    WriteAmessage : Boolean;
    Publicationid : Longint;
    Pubdate : tdatetime;
    Productionmessage : Boolean;
    Headertext : String;
    Footertext : String;
    AktmessageID : Longint;
    ReadMessagefrom : String;
    ReadMessageTo : String;
    Replyfromline : Longint;
    Function ReadAmessage:Boolean;

    Function UpdateACCmessage:Longint;
    Function SendACCmessage:Longint;
    procedure Setlogdata;
    { Public declarations }
  end;

var
  Formsendmessage: TFormsendmessage;

implementation

uses umain,Udata, Data.FmtBcd, Data.SqlExpr, Data.DB, Ulogin, Usettings, UUser;

{$R *.dfm}

Function TFormsendmessage.SendACCmessage:Longint;
Var
  receivername : string;
Begin
  try
    MemoMessage.Lines.Add('');
    MemoMessage.Lines.Add('---  ' + datetimetostr(Now)+'  ---');
    MemoMessage.Lines.Add('');


    receivername := ComboBoxTo.text;
    IF ComboBoxTo.ItemIndex = 0 then
      receivername := '';
    result := -1;
    DataM1.Query3.sql.clear;
    DataM1.Query3.sql.add('DECLARE @MinNumber int');
    DataM1.Query3.sql.add('DECLARE @NewMessageID int');

    DataM1.Query3.sql.add('SET  @MinNumber = 1');
    DataM1.Query3.sql.add('SET  @NewMessageID = @MinNumber');

    DataM1.Query3.sql.add('IF EXISTS (SELECT MessageID FROM Messages)');
    DataM1.Query3.sql.add('BEGIN');
    DataM1.Query3.sql.add('  IF NOT EXISTS (SELECT MessageID FROM Messages WHERE MessageID = @MinNumber )');
    DataM1.Query3.sql.add('    SET @NewMessageID = @MinNumber');
    DataM1.Query3.sql.add('  ELSE');
    DataM1.Query3.sql.add('    SET @NewMessageID = (Select top 1 number from allnum');
    DataM1.Query3.sql.add('    where not exists(select MessageID from Messages');
    DataM1.Query3.sql.add('    where allnum.number = Messages.MessageID)');
    DataM1.Query3.sql.add('    and allnum.number >= @MinNumber)');
    DataM1.Query3.sql.add('END');
    DataM1.Query3.sql.add('ELSE');
    DataM1.Query3.sql.add('  SET @NewMessageID = @MinNumber');

    IF productionmessage then
    begin
      DataM1.Query3.sql.Add('insert Messages (MessageID,MessageType,Severity,IsRead,pubdate,Sender,Receiver,');
      DataM1.Query3.sql.Add('Message,Eventtime,Publicationid,Title)');
      DataM1.Query3.sql.Add('values (@NewMessageID,0,'+inttostr(Integer(CheckBoxSevier.checked))+',0,:pubdate,');
      DataM1.Query3.sql.Add(''''+Prefs.username+''''+','+''''+receivername+''''+',');
      DataM1.Query3.sql.Add(':astrparm,getdate(),'+inttostr(publicationid)+','+''''+Editsubject.text+''''+' )');

      DataM1.Query3.ParamByName('pubdate').asdatetime := pubdate;
    end
    Else
    begin
      DataM1.Query3.sql.Add('insert Messages (MessageID,MessageType,Severity,IsRead,Sender,Receiver,');
      DataM1.Query3.sql.Add('Message,Eventtime,Title)');
      DataM1.Query3.sql.Add('values (@NewMessageID,0,'+inttostr(Integer(CheckBoxSevier.checked))+',0,');
      DataM1.Query3.sql.Add(''''+Prefs.username+''''+','+''''+receivername+''''+',');
      DataM1.Query3.sql.Add(':astrparm,getdate(),'+''''+Editsubject.text+''''+' )');
    end;

    DataM1.Query3.sql.add('Select @NewMessageID ');

    DataM1.Query3.ParamByName('astrparm').DataType := ftMemo;
    DataM1.Query3.ParamByName('astrparm').Asstring := MemoMessage.Text;

    DataM1.Query3.open;
    result := DataM1.Query3.fields[0].asinteger;
    DataM1.Query3.close;
  Except
    result := -1;
  end;
end;


Function TFormsendmessage.UpdateACCmessage:Longint;
Var
  I : longint;
  ttext,frtext : string;
Begin
  try
    result := 1;
(*
  DataM1.Query3.sql.Add('insert Messages (MessageID,MessageType,Severity,IsRead,ProductionID,Sender,Receiver,');
      DataM1.Query3.sql.Add('Message,Eventtime,Publicationid,Title)');
  *)

    IF MemoMessage.lines.count > Replyfromline then
    begin
      i := MemoMessage.lines.count-Replyfromline;
      Inc(i);

      MemoMessage.Lines.Insert(i,'');
      MemoMessage.Lines.Insert(i,'---  ' + datetimetostr(Now)+'  ---');
      MemoMessage.Lines.Insert(i,'');

    end;

    ttext := ComboBoxFrom.text;
    frtext := ComboBoxTo.text;
    if frtext = '' then
    Begin
      frtext := Prefs.username;
      ttext := '';
    End;
    result := -1;
    DataM1.Query3.sql.clear;
    DataM1.Query3.sql.Add('Update Messages');
    DataM1.Query3.sql.Add('Set Message = :astrparm');
    DataM1.Query3.sql.Add(', IsRead = 0');
    DataM1.Query3.sql.Add(', receiver = ' +''''+ttext+'''');
    DataM1.Query3.sql.Add(', Sender = ' +''''+Prefs.username+'''');
    DataM1.Query3.sql.add('where MessageID = ' + inttostr(AktmessageID));
    DataM1.Query3.ParamByName('astrparm').DataType := ftMemo;
    DataM1.Query3.ParamByName('astrparm').Asstring := MemoMessage.Text;

    DataM1.Query3.execsql(false);

  Except
    result := -1;
  end;
end;



procedure TFormsendmessage.Setlogdata;
Begin
End;

procedure TFormsendmessage.FormActivate(Sender: TObject);
Var
  i : Longint;
begin
  ComboBoxTo.enabled := true;
  ComboBoxFrom.enabled := true;


  IF WriteAmessage then
  begin
    ComboBoxTo.Items.Clear;
    ComboBoxFrom.Items.Clear;

    ComboBoxTo.Items := Formusers.ComboBoxusername.Items;
    ComboBoxFrom.Items := Formusers.ComboBoxusername.Items;

    ComboBoxTo.ItemIndex := 0;
    ComboBoxFrom.ItemIndex := ComboBoxFrom.Items.IndexOf(Prefs.username);

    CheckBoxSevier.Visible := true;
    BitBtnreply.Visible := FALSE;
    BitBtnSend.Visible := true;
    BitBtnClose.Visible := FALSE;
    BitBtncancel.Visible := true;

    Label2.caption := 'Send ControlCenter message';
    IF Productionmessage then
      Label9.caption := 'Write a production specifik message and click send'
    Else
      Label9.caption := 'Write a broadcast message and click send';

    ComboBoxTo.Items.Insert(0,'All');
    Editsubject.Text := '';
    memomessage.lines.Clear;
    Autoheader1Click(self);
  end
  else
  begin
    CheckBoxSevier.Visible := false;
    ComboBoxTo.enabled := false;
    ComboBoxFrom.enabled := false;

    BitBtnreply.Visible := true;
    BitBtnSend.Visible := false;
    BitBtnClose.Visible := true;
    BitBtncancel.Visible := false;
    Label2.caption := 'ControlCenter message';
    Label9.caption := 'read message and click close or edit the message and click reply';


    MemoMessage.lines.add('');
    MemoMessage.SelStart := 0;
    MemoMessage.SelLength := 0;
    MemoMessage.SetFocus;
 //   MemoMessage.SelStart := Perform(EM_LINEINDEX, 0, 0) ;
 //   MemoMessage.setfocus;
    Replyfromline := MemoMessage.lines.count;
  end;
  ComboBoxFrom.Enabled := false;



end;

procedure TFormsendmessage.BitBtnSendClick(Sender: TObject);
begin

  AktmessageID := SendACCmessage;

  IF AktmessageID > -1 then
  begin
    Setlogdata;
  end;
  Formsendmessage.close;
end;

procedure TFormsendmessage.Autoheader1Click(Sender: TObject);
Var
  I : Longint;
begin

  IF productionmessage then
  begin

    Editsubject.Text := tnames1.publicationIDtoname(publicationid) + ' ' + datetostr(pubdate);
  End
  else
    Editsubject.Text := '';
end;

procedure TFormsendmessage.BitBtnreplyClick(Sender: TObject);
begin
  UpdateACCmessage;
  Close;
end;

Function TFormsendmessage.ReadAmessage:Boolean;
Var
  astring : String;
  I,totlength,n : Longint;
  T : String;
  Alist : TStrings;
  ReadOK : Boolean;
begin
  ComboBoxTo.Items.Clear;
  ComboBoxFrom.Items.Clear;

  ComboBoxTo.Items := Formusers.ComboBoxusername.Items;
  ComboBoxFrom.Items := Formusers.ComboBoxusername.Items;
  ComboBoxTo.Items.Insert(0,'All');

  ReadOK := false;
  Alist := TStringList.Create;
  Editsubject.text := '';
  MemoMessage.lines.clear;
  try
    DataM1.Query3.sql.clear;
    DataM1.Query3.sql.Add('select * from Messages');
    DataM1.Query3.sql.Add('Where Messageid = ' + inttostr(AktmessageID));
    DataM1.Query3.open;
    IF not DataM1.Query3.eof then
    begin
      ReadOK := true;
      astring := DataM1.Query3.Fields[7].AsString;
      Editsubject.text := DataM1.Query3.Fields[10].AsString;
      ComboBoxTo.itemindex := ComboBoxTo.items.indexof(DataM1.Query3.Fields[6].AsString);
      ComboBoxFrom.itemindex := ComboBoxFrom.items.indexof(DataM1.Query3.Fields[5].AsString);
      CheckBoxSevier.Checked := DataM1.Query3.Fields[2].AsInteger = 1;
    End
    Else
      ReadOK := false;
    DataM1.Query3.close;

    IF ReadOK then
    begin
      IF astring <> '' then
      begin
        T := '';
        totlength := length(astring);

        while totlength > 1 do
        begin
          n := pos(#13+#10,astring);
          IF n < 1 then
          Begin
            T := astring;
            delete(astring,1,length(astring)+100);
          End
          Else
            T := copy(astring,1,n-1);

          Alist.add(T);
          delete(astring,1,n+1);
          totlength := length(astring);
        end;
        For i := 0 to Alist.Count-1 do
          MemoMessage.Lines.Add(Alist[i]);


        ReadOK := MemoMessage.Lines.count > 0;
      End
      Else
        ReadOK :=  true;

    End;

    IF Readok then
    begin
      DataM1.Query3.sql.clear;
      DataM1.Query3.sql.Add('update messages');
      DataM1.Query3.sql.Add('Set isread = 1 ');
      DataM1.Query3.sql.add('where messageid = ' + inttostr(AktmessageID));
      DataM1.Query3.execsql(false);
    end;

    MemoMessage.lines.Insert(0,'');
    MemoMessage.lines.Insert(0,'');



  Except
    ReadOK := false;
  end;
  Alist.free;

  result := readok;

end;

end.
