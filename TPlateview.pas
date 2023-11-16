unit TPlateview;

interface

uses
  SysUtils, Classes, Controls, Forms;

type
  TPlateview = class(TScrollBox)
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
  RegisterComponents('INFRA', [TPlateview]);
end;

end.
