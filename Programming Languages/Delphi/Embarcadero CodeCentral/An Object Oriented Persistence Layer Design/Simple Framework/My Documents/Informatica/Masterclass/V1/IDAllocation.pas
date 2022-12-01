unit IDAllocation;

interface

uses
  Framework;

type
  TIDAllocator = class
  private
    function GetNextID: TObjectID;
  public
    property NextID: TObjectID read GetNextID;
  end;

var
  IDAllocator: TIDAllocator;

implementation

function TIDAllocator.GetNextID: TObjectID;
begin
  Randomize;
  Result := Random (MaxInt);
end;

initialization
  IDAllocator := TIDAllocator.Create;

finalization
  IDAllocator.Free;

end.
 
