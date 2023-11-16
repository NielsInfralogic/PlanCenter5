unit Uhowtomouseleave;

interface

implementation

end.



unit MyImg;
interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  ExtCtrls;
type
  TMyImage = class(TImage)
  private
    FOnMouseLeave: TNotifyEvent;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  protected
  public
  published
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TMyImage]);
end;

procedure TMyImage.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if Assigned(FOnMouseLeave) then FOnMouseLeave(Self);
end;

end.
