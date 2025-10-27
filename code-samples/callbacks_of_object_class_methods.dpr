{$ifdef FPC} {$mode objfpc}{$H+}{$J-} {$endif}
{$ifdef MSWINDOWS} {$apptype CONSOLE} {$endif}

type
  TMyMethod = function (const A, B: Integer): Integer of object;

  TMyClass = class
    class function Add(const A, B: Integer): Integer;
    class function Multiply(const A, B: Integer): Integer;
  end;

class function TMyClass.Add(const A, B: Integer): Integer;
begin
  Result := A + B;
end;

class function TMyClass.Multiply(const A, B: Integer): Integer;
begin
  Result := A * B;
end;

var
  M: TMyMethod;
begin
  {$ifdef FPC}
  // Unfortunately, this requires a bit of hack to work in FPC ObjFpc mode.
  M := @TMyClass(nil).Add;
  M := @TMyClass(nil).Multiply;
  {$else}
  M := TMyClass.Add;
  M := TMyClass.Multiply;
  {$endif}
end.
