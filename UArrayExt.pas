unit UArrayExt;

interface
uses
  System.Generics.Collections;

type
  TArrayExt = class(TArray)
    class procedure Delete<T>(var A: TArray<T>; const Index: Cardinal; Count: Cardinal = 1);
  end;

implementation

class procedure TArrayExt.Delete<T>(var A: TArray<T>; const Index: Cardinal;
    Count: Cardinal = 1);
var
  ALength: Cardinal;
  i: Cardinal;
begin
  ALength := Length(A);
  Assert(ALength > 0);
  Assert(Count > 0);
  Assert(Count <= ALength - Index);
  Assert(Index < ALength);

  for i := Index + Count to ALength - 1 do
    A[i - Count] := A[i];

  SetLength(A, ALength - Count);
end;

end.
