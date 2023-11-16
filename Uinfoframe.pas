unit Uinfoframe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  ComCtrls, Dialogs, StdCtrls;

type
  TFrameInfo = class(TFrame)
    Memo1: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure setdata(node : ttreenode);
  end;

implementation

{$R *.dfm}
Uses
  utypes,umain;

Procedure TFrameInfo.setdata(node : ttreenode);
Begin

end;


end.
