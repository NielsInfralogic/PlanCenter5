unit USyncListBox;

interface

uses
  Windows, Messages, Classes, SysUtils, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TSyncListBox = class(TListBox)
  private
    FOnScroll: TNotifyEvent;
  protected
   procedure ListBoxScroll(var Message: TMessage); message WM_VSCROLL;
  public
    { Public declarations }
  published
   property OnScroll: TNotifyEvent read FOnScroll write FOnScroll;
end;

implementation

procedure Register;
begin
  RegisterComponents('Test', [TListBox]);
end;

procedure TSyncListBox.ListBoxScroll(var Message: TMessage);
begin
  inherited;
  if Assigned(FOnScroll) then
    FOnScroll(Self);
end;



end.
