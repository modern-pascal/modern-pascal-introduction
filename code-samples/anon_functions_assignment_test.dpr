{ Working example adjusted from
  https://forum.lazarus.freepascal.org/index.php?topic=59468.0 }

{$ifdef FPC}
  {$ifdef VER3_2} {$message warn 'This code needs FPC >= 3.3.x'} begin end. {$endif}
  {$mode objfpc}{$H+}{$J-}
  {$modeswitch functionreferences}
  {$modeswitch anonymousfunctions}
{$endif}
{$ifdef MSWINDOWS} {$apptype CONSOLE} {$endif}

uses Classes;

type
  {$ifdef FPC}
  TFunc = function: LongInt;
  {$else}
  TFunc = reference to function: LongInt;
  TProcedure = reference to procedure;
  TNotifyEvent = reference to procedure(aSender: TObject);
  {$endif}

var
  p: TProcedure;
  f: TFunc;
  n: TNotifyEvent;
begin
  {$ifdef FPC} // Delphi doesn't allow to invoke like this
  procedure(const aArg: String)
  begin
    Writeln(aArg);
  end('Hello World');
  {$endif}

  p := procedure
       begin
         Writeln('Foobar');
       end;
  p();

  n := procedure(Sender: TObject)
       begin
         Writeln(Sender.ClassName);
       end;
  n(Nil);

  f := function: LongInt
       begin
         Result := 42;
       end;
  Writeln(f());
end.