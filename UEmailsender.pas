unit UEmailsender;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdMessageClient, IdSMTP,IdMessage, IdIOHandler, IdIOHandlerStream, IdText, IdAttachment, IdAttachmentFile,
  ComCtrls, StdCtrls, ExtCtrls,Utypes, IdExplicitTLSClientServerBase, IdSMTPBase;

type
  TFormemail = class(TForm)
    Panelb: TPanel;
    Image2: TImage;
    Label2: TLabel;
    Label9: TLabel;
    Animate1: TAnimate;
    IdSMTP1: TIdSMTP;
    IdMessage1: TIdMessage;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    function GetPriority(pri : Integer): TIdMessagePriority;
    procedure SendEMail(aMessage: TIdMessage;
                        edSMTPServer : string;
                        emulate : Boolean);
    Function sendattachedmailmessage(edSMTPServer     : String;  // smtp.mail.dk
                                      edSenderName     : string;  // plancenter eller bruger navn
                                      edSenderEMail    : string;  // CC@mail.com
                                      edNRecipients    : Integer;
                                      edRecipients     : RecipientArrayType;  // modtager navn og adresse
                                      edSubject        : String;  // overskrift på mail
                                      edAttachment     : String;  //path og filnavn på preview fil
                                      edpriority       : Integer; //0 højeste 4 laveste
                                      Edtoptext        : string;  // text før billede
                                      edbottomtext     : string;  // text efter billede
                                      emulate : Boolean):Boolean;

    Function sendIncludedmailmessage(edSMTPServer     : String;  // smtp.mail.dk
                                     edSenderName     : string;  // plancenter eller bruger navn
                                     edSenderEMail    : string;  // CC@mail.com
                                     edNRecipients    : Integer;
                                     edRecipients     : RecipientArrayType;  // modtager navn og adresse
                                     edSubject        : String;  // overskrift på mail
                                     edAttachment     : String;  //path og filnavn på preview fil
                                     edpriority       : Integer; //0 højeste 4 laveste
                                     Edtoptext        : string;  // text før billede
                                     edbottomtext     : string;  // text efter billede
                                     emulate          : Boolean):Boolean;

  public


    Function  sendemailmessage(edSMTPServer     : String;  // smtp.mail.dk
                               edSenderName     : string;  // plancenter eller bruger navn
                               edSenderEMail    : string;  // CC@mail.com
                               edNRecipients    : Integer;
                               edRecipients     : RecipientArrayType;  // modtager navn og adresse
                               edSubject        : String;  // overskrift på mail
                               edAttachment     : String;  //path og filnavn på preview fil
                               edpriority       : Integer; //0 højeste 4 laveste
                               Edtoptext        : string;  // text før billede
                               edbottomtext     : string;  // text efter billede
                               emulate          : Boolean;
                               Emailformat      : Longint):Boolean;

    { Public declarations }
  end;

var
  Formemail: TFormemail;

implementation

uses Usettings, UUtils;

{$R *.dfm}

function TFormemail.GetPriority(pri : Integer): TIdMessagePriority;
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


Function TFormemail.sendemailmessage(edSMTPServer     : String;  // smtp.mail.dk
                                     edSenderName     : string;  // plancenter eller bruger navn
                                     edSenderEMail    : string;  // CC@mail.com
                                     edNRecipients    : Integer;
                                     edRecipients     : RecipientArrayType;  // modtager navn og adresse

                                     edSubject        : String;  // overskrift på mail
                                     edAttachment     : String;  //path og filnavn på preview fil
                                     edpriority       : Integer; //0 højeste 4 laveste
                                     Edtoptext        : string;  // text før billede
                                     edbottomtext     : string;  // text efter billede
                                     emulate : Boolean;
                                     Emailformat      : Longint):Boolean; //0 attached 1 included
Begin

  Case Emailformat  of
    0 : result := sendattachedmailmessage(edSMTPServer,edSenderName,edSenderEMail,edNRecipients,
                                          edRecipients,edSubject,edAttachment,edpriority,
                                          Edtoptext,edbottomtext,emulate);
    1 : result := sendIncludedmailmessage(edSMTPServer,edSenderName,edSenderEMail,edNRecipients,
                                          edRecipients,edSubject,edAttachment,edpriority,
                                          Edtoptext,edbottomtext,emulate);
  End;
end;

Function TFormemail.sendIncludedmailmessage(edSMTPServer     : String;  // smtp.mail.dk
                                            edSenderName     : string;  // plancenter eller bruger navn
                                            edSenderEMail    : string;  // CC@mail.com
                                            edNRecipients    : Integer;
                                            edRecipients     : RecipientArrayType;  // modtager navn og adresse
                                            edSubject        : String;  // overskrift på mail
                                            edAttachment     : String;  //path og filnavn på preview fil
                                            edpriority       : Integer; //0 højeste 4 laveste
                                            Edtoptext        : string;  // text før billede
                                            edbottomtext     : string;  // text efter billede
                                            emulate : Boolean):Boolean;
var
  I : Integer;
  lMessage: TIdMessage;
  lTextPart: TIdText;
  lImagePart: TIdAttachment;
  lGUID: TGUID;
  lCID: string;
begin


  try
    lMessage := TIdMessage.Create(Self);
    try
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
      lMessage.Body.Text := '';

      lTextPart := TIdText.Create(lMessage.MessageParts);
      lTextPart.Body.Text := 'This is a plain text message';
      lTextPart.ContentType := 'text/plain';

      CreateGUID(lGUID);
      lCID := StringReplace(GUIDToString(lGUID), '-', '', [rfReplaceAll]);
      lCID := StringReplace(lCID, '{', '', [rfReplaceAll]);
      lCID := StringReplace(lCID, '}', '', [rfReplaceAll]);
      lTextPart := TIdText.Create(lMessage.MessageParts);
      lTextPart.Body.Text := '<html><body><b>' + Edtoptext +'</b>'+
        '<br><img src="cid:' + lCID + '">' +
        '<br><i>' +edbottomtext+ '</i></body></html>';
      lTextPart.ContentType := 'text/html';
      lMessage.Priority := GetPriority(edpriority);

      lImagePart := TIdAttachmentFile.Create(lMessage.MessageParts, edAttachment);
      lImagePart.ContentType := 'image/jpg';

      lImagePart.ContentID := '<' + lCID + '>';
      SendEMail(lMessage,edSMTPServer,emulate);
    finally
      lMessage.Free;
    end;
  finally

  end;
end;

procedure TFormemail.SendEMail(aMessage: TIdMessage;
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
    AMessage.SaveToFile(IncludeTrailingBackSlash(TUtils.GetTempDirectory()) + 'testmessage.msg');
end;

Function TFormemail.sendattachedmailmessage(edSMTPServer     : String;  // smtp.mail.dk
                                            edSenderName     : string;  // plancenter eller bruger navn
                                            edSenderEMail    : string;  // CC@mail.com
                                            edNRecipients    : Integer;
                                            edRecipients     : RecipientArrayType;  // modtager navn og adresse
                                            edSubject        : String;  // overskrift på mail
                                            edAttachment     : String;  //path og filnavn på preview fil
                                            edpriority       : Integer; //0 højeste 4 laveste
                                            Edtoptext        : string;  // text før billede
                                            edbottomtext     : string;  // text efter billede
                                            emulate : Boolean):Boolean;

var
  lMessage: TIdMessage;
  I : Longint;
begin
  result := false;
  try
    lMessage:= TIdMessage.Create(Self);
    try
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
      lMessage.Body.Text := Edtoptext;

      if FileExists(edAttachment) then
        TIdAttachmentFile.Create(lMessage.MessageParts, edAttachment);
      lMessage.Priority := GetPriority(edpriority);
      SendEMail(lMessage,edSMTPServer,emulate);
      result := true;
    finally
      lMessage.Free;
    end;
  finally
  end;
end;


procedure TFormemail.FormActivate(Sender: TObject);
begin
  Animate1.Active := true;
end;

procedure TFormemail.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Animate1.Active := false;
end;

end.
