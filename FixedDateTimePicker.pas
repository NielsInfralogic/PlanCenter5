unit FixedDateTimePicker;

interface

uses
  SysUtils, Messages, Classes, Controls, ComCtrls, CommCtrl;

type
  TFixedDateTimePicker = class(TDateTimePicker)
  private
    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
  protected
    { Protected declarations }
  public
    { Public declarations }

    constructor Create(AOwner: TComponent); override;

  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('FixedDateTime', [TFixedDateTimePicker]);
end;

constructor TFixedDateTimePicker.Create(AOwner: TComponent);
Begin
  inherited;
  checked := false;

End;

procedure TFixedDateTimePicker.CNNotify(var Message: TWMNotify);
begin
  with Message, NMHdr^ do
  begin
    if ShowCheckBox then
    begin
      with PNMDateTimeChange(NMHdr)^ do
      begin
        checked := dwFlags <> GDT_NONE;
      end;
    end;
  end;
  inherited;
end;

end.
