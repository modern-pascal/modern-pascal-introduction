{$ifdef FPC} {$mode objfpc}{$H+}{$J-} {$endif}
{$ifdef MSWINDOWS} {$apptype CONSOLE} {$endif}

uses
  SysUtils;

type
  TMyClass = class
  private
    InternalStuff: TObject;
  public
    constructor Create;
    destructor Destroy; override;
  end;

constructor TMyClass.Create;
begin
  inherited Create; // Call the ancestor constructor at the beginning
  InternalStuff := TObject.Create;
  Writeln('TMyClass.Create');
end;

destructor TMyClass.Destroy;
begin
  Writeln('TMyClass.Destroy');
  FreeAndNil(InternalStuff); // will call InternalStuff.Destroy
  inherited Destroy; // Call the ancestor destructor at the end
end;

var
  C: TMyClass;
begin
  C := TMyClass.Create;
  try
    // use C
  finally
    FreeAndNil(C); // will call C.Destroy
  end;
end.
