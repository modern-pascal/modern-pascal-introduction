{ Example of Map, ForEach methods and processing list with anonymous functions. }

{$ifdef FPC}
  {$ifdef VER3_2} {$message warn 'This code needs FPC >= 3.3.x'} begin end. {$endif}
  {$mode objfpc}{$H+}{$J-}
  {$modeswitch functionreferences}
  {$modeswitch anonymousfunctions}
{$endif}
{$ifdef MSWINDOWS} {$apptype CONSOLE} {$endif}

uses SysUtils, Generics.Collections;

type
  { Note about below TIntMapFunc and TIntMapProc definition, what to use?

    In short, use "reference to". You can assign to them anonymous functions
    reliably in both Delphi and FPC.

    With Delphi 12.1, only the "reference to" version will compile.

    With FPC 3.3.1, other variants will also compile.
    You can assign anonymous function to any of them.
    So if you only target FPC, you can decide which version to use
    based on what you want to assign to them *aside*
    from anonymous functions:

    - The 1st version (without "of object", without "reference to")
      allows to store a reference to a global function,

    - The 2nd (with "of object")
      allows to store a reference to a method of an object,

    - The 3rd (with "reference to") is the most universal,
      allows a lot of things --
      see https://forum.lazarus.freepascal.org/index.php?topic=59468.0 .
  }

  TIntMapFunc =
    //function(const Index, Item: Integer): Integer;
    //function(const Index, Item: Integer): Integer of object;
    reference to function(const Index, Item: Integer): Integer;
  TIntMapProc =
    //procedure(const Index, Item: Integer);
    //procedure(const Index, Item: Integer) of object;
    reference to procedure(const Index, Item: Integer);

  TMyInts = class({$ifdef FPC}specialize{$endif} TList<Integer>)
    { Change every item in the list using AFunc. }
    procedure Map(const AFunc: TIntMapFunc);
    { Call AProc for every item in the list. }
    procedure ForEach(const AProc: TIntMapProc);
  end;

procedure TMyInts.Map(const AFunc: TIntMapFunc);
var
  Index: Integer;
begin
  for Index := 0 to Count - 1 do
    Items[Index] := AFunc(Index, Items[Index]);
end;

procedure TMyInts.ForEach(const AProc: TIntMapProc);
var
  Index: Integer;
begin
  for Index := 0 to Count - 1 do
    AProc(Index, Items[Index]);
end;

var
  MyList: TMyInts;
  I: Integer;
  F: TIntMapFunc;
begin
  MyList := TMyInts.Create;
  try
    for I := 0 to 10 do
      MyList.Add(I);

    F := function(const Index, Item: Integer): Integer
      begin
        Result := Item + 1;
      end;
    // effectively this increases all numbers on the list by 3
    MyList.Map(F);
    MyList.Map(F);
    MyList.Map(F);

    // change all items to their squares
    MyList.Map(function(const Index, Item: Integer): Integer
      begin
        Result := Item * Item;
      end);

    // print all items
    MyList.ForEach(procedure(const Index, Item: Integer)
      begin
        WriteLn('Index: ', Index, ', Item: ', Item);
        WriteLn('  If we would process it by F: ', F(Index, Item));
      end);
  finally FreeAndNil(MyList) end;
end.
