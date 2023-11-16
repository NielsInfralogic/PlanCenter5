unit USendAmail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, IdMessage, IdBaseComponent, IdAttachment,  IdAttachmentFile,
  IdComponent, IdTCPConnection, IdTCPClient, IdMessageClient, IdSMTP,utypes,
  IdExplicitTLSClientServerBase, IdSMTPBase, IdText;

type
  TFormSendAMail = class(TForm)
    Panel2: TPanel;
    Image1: TImage;
    Label6: TLabel;
    Label7: TLabel;
    IdSMTP1: TIdSMTP;
    IdMessage1: TIdMessage;
  private
    function GetPriority(pri : Integer): TIdMessagePriority;
    procedure SendEMail(aMessage: TIdMessage;
                        edSMTPServer : string;
                        emulate : Boolean);

  public
    Function sendAmailmessage(edSMTPServer     : String;  // smtp.mail.dk
                                         edSenderName     : string;  // plancenter eller bruger navn
                                         edSenderEMail    : string;  // CC@mail.com
                                         edNRecipients    : Integer;
                                         edRecipients     : RecipientArrayType;  // modtager navn og adresse
                                         edSubject        : String;  // overskrift på mail
                                         edAttachment         : Tstrings;  //path og filnavn på fil som skal attatches
                                         edIncludedJpgs   : Tstrings;  //path og filnavn på fil som skal includeres
                                         edpriority       : Integer; //0 højeste 4 laveste
                                         Edtoptext        : Tstrings;  // text før billede
                                         edbottomtext     : string;  // text efter billede
                                         emulate : Boolean):Boolean;


  end;

var
  FormSendAMail: TFormSendAMail;

implementation

{$R *.dfm}
procedure TFormSendAMail.SendEMail(aMessage: TIdMessage;
                               edSMTPServer : string;
                               emulate : Boolean);
begin
  if not emulate then
  begin
    // have to connect first before send an e-mail
    IdSMTP1.Host := edSMTPServer;
    IdSMTP1.Connect;
    IdSMTP1.Send(aMessage);
    IdSMTP1.Disconnect;
  end
  Else
    AMessage.SaveToFile(ExtractFilePath(Application.EXEName) + 'testmessage.msg');
end;

function TFormSendAMail.GetPriority(pri : Integer): TIdMessagePriority;
begin
  case pri of
    0: Result := mpHighest;
    1: Result := mpHigh;
    3: Result := mpLow;
    4: Result := mpLowest;
  else
    Result := mpNormal;
  end;
end;


(*

procedure TForm1.Button1Click(Sender: TObject);
var
  html: TStrings;
  htmpart, txtpart: TIdText;
  bmppart: TIdAttachment;
  email: TIdMessage;
  filename: string;
begin
  filename := ExtractFilePath(Application.ExeName) + 'us.jpg';

  html := TStringList.Create();
  html.Add('<html>');
  html.Add('<head>');
  html.Add('</head>');
  html.Add('<body><h1>Hello</h1>');
  html.Add('<img src="cid:us.jpg" />');
  html.Add('This is a picture of us!</body>');
  html.Add('</html>');

  email := TIdMessage.Create(nil);
  email.From.Text := 'Pete@NooooSpammmm.Droopyeyes.com';
  email.Recipients.EMailAddresses := 'Pete@NoooSpammmm.droopyeyes.com';
  email.Subject := 'Hello';
  email.ContentType := 'multipart/mixed';
  email.Body.Assign(html);

  txtpart := TIdText.Create(email.MessageParts);
  txtpart.ContentType := 'text/plain';
  txtpart.Body.Text := '';

  htmpart := TIdText.Create(email.MessageParts, html);
  htmpart.ContentType := 'text/html';

  bmppart := TIdAttachment.Create(email.MessageParts, filename);
  bmppart.ContentType := 'image/jpeg';
  bmppart.FileIsTempFile := true;
  bmppart.ContentDisposition := 'inline';
  bmppart.ExtraHeaders.Values['content-id'] := 'us.jpg';
  bmppart.DisplayName := 'us.jpg';

  try
    idSMTP.Connect();
    try
      idSMTP.Send(email);
      ShowMessage('Sent');
    except
      on E: Exception do
        ShowMessage('Failed: ' + E.Message);
    end;
  finally
    idSMTP.Disconnect();
    email.Free();
    html.Free();
  end;
end;



*)

Function TFormSendAMail.sendAmailmessage(edSMTPServer     : String;  // smtp.mail.dk
                                         edSenderName     : string;  // plancenter eller bruger navn
                                         edSenderEMail    : string;  // CC@mail.com
                                         edNRecipients    : Integer;
                                         edRecipients     : RecipientArrayType;  // modtager navn og adresse
                                         edSubject        : String;  // overskrift på mail
                                         edAttachment         : Tstrings;  //path og filnavn på fil som skal attatches
                                         edIncludedJpgs   : Tstrings;  //path og filnavn på fil som skal includeres
                                         edpriority       : Integer; //0 højeste 4 laveste
                                         Edtoptext        : Tstrings;  // text før billede
                                         edbottomtext     : string;  // text efter billede
                                         emulate : Boolean):Boolean;


var
  lMessage: TIdMessage;
  lImagePart: TIdAttachment;
  bmppart: TIdAttachment;
  I : Longint;
  html: TStrings;
  N : Longint;
  T : String;
  htmpart, txtpart: TIdText;

begin
  result := false;
  try

    lMessage:= TIdMessage.Create(Self);
    try
      lMessage.ContentType := 'multipart/mixed';
      lMessage.From.Name := edSenderName;
      lMessage.From.Address := edSenderEMail;
      For I := 1 to edNRecipients do
      begin
        with lMessage.Recipients.Add do
        begin
          Name := edRecipients[i].name;
          Address := edRecipients[i].adress;
        end;

        IF edRecipients[i].CCname <> '' then
        begin
          with lMessage.cclist.Add do
          begin
            Name := edRecipients[i].CCname;
            Address := edRecipients[i].ccadress;
          end;

        end;
      End;
      lMessage.Subject := edSubject;

      txtpart := TIdText.Create(lMessage.MessageParts);
      txtpart.ContentType := 'text/plain';

      html := TStringList.Create();
      html.Add('<html>');
      html.Add('<head>');
      html.Add('<b>'+'overskrift'+'<br></b>');
      html.Add('</head>');
      html.Add('<body>');
      html.Add(' <br>');
      For i := 0 to Edtoptext.Count-1 do
      Begin
        T:= Edtoptext[i]+ '<br>';
        html.Add(T);
      end;
      html.Add(' <br>');
      IF edIncludedJpgs.Count > 0 then
      begin
        For i := 0 to edIncludedJpgs.Count-1 do
        begin
          if FileExists(edIncludedJpgs[i]) then
          Begin
            T := Extractfilename(edIncludedJpgs[i]);
            html.Add('<div style="float:left; width:30%; margin:5pt 5pt 0pt;"><p>');
            html.Add('<img src="'+T+'" height="300" width="200" alt="1.jpg" >');
            html.Add('<div>'+T+'</div>');
            html.Add('</p></div>');

          end;
        End;
      End;
      html.Add('</body>');
      html.Add('</html>');

    //  html.SaveToFile('c:\xxx.html');

      lMessage.Body.Assign(html);

      htmpart := TIdText.Create(lMessage.MessageParts, html);
      htmpart.ContentType := 'text/html';

      For i := 0 to edIncludedJpgs.Count-1 do
      begin
        bmppart := TIdAttachmentFile.Create(lMessage.MessageParts, edIncludedJpgs[i]);
        bmppart.ContentType := 'image/jpeg';
        bmppart.ContentDisposition := 'inline';
        bmppart.ExtraHeaders.Values['content-id'] := Extractfilename(edIncludedJpgs[i]);
        bmppart.DisplayName := Extractfilename(edIncludedJpgs[i]);
      End;

      For i := 0 to edAttachment.Count-1 do
      begin
        if FileExists(edAttachment[i]) then
          TIdAttachmentFile.Create(lMessage.MessageParts, edAttachment[i]);
      End;


      lMessage.Priority := GetPriority(edpriority);
      SendEMail(lMessage,edSMTPServer,emulate);
      result := true;
    finally
      lMessage.Free;
    end;
  finally

  end;
end;



end.
