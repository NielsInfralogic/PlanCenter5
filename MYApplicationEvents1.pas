unit MYApplicationEvents1;

interface

uses
  SysUtils, Classes, AppEvnts;

type
  TMYApplicationEvents1 = class(TApplicationEvents)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('INFRA', [TMYApplicationEvents1]);
end;

end.
