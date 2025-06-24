{ Anonymous functions test. }

{$ifdef FPC}
  {$ifdef VER3_2} {$message warn 'This code needs FPC >= 3.3.x'} begin end. {$endif}
  {$mode objfpc}{$H+}{$J-}
  {$modeswitch functionreferences}
  {$modeswitch anonymousfunctions}
{$endif}
{$ifdef MSWINDOWS} {$apptype CONSOLE} {$endif}

type
  TMyFunction = reference to function (const A, B: Integer): Integer;

function ProcessTheList(const F: TMyFunction): Integer;
var
  I: Integer;
begin
  Result := 1;
  for I := 2 to 10 do
    Result := F(Result, I);
end;

var
  SomeFunction: TMyFunction;
begin
  // Assign anonymous function to a variable
  SomeFunction :=
    function(const A, B: Integer): Integer
    begin
      Result := A + B;
    end;
  WriteLn('1 + 2 + 3 ... + 10 = ', ProcessTheList(SomeFunction));

  // Or, simpler, just define the anonymous function inside the parameter
  WriteLn('1 + 2 + 3 ... + 10 = ', ProcessTheList(
    function(const A, B: Integer): Integer
    begin
      Result := A + B;
    end
  ));

  // Similar test, now with multiplication
  WriteLn('1 * 2 * 3 ... * 10 = ', ProcessTheList(
    function(const A, B: Integer): Integer
    begin
      Result := A * B;
    end
  ));
end.
