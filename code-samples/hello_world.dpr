// Just use this line in all modern FPC sources.
{$ifdef FPC} {$mode objfpc}{$H+}{$J-} {$endif}

// Below is needed for console programs on Windows,
// otherwise (with Delphi) the default is GUI program without console.
{$ifdef MSWINDOWS} {$apptype CONSOLE} {$endif}

program MyProgram;
begin
  WriteLn('Hello world!');
end.
