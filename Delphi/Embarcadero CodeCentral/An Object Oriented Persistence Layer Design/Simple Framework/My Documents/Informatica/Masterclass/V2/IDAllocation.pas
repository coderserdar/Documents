unit IDAllocation;

interface

uses
  Framework;

  // A class that will be used to allocate object ID's. Strictly, objects must
  // have an ID that is unique only to the class, but this simple ID allocator
  // generates ID's that are unique system-wide. This simple allocator is not
  // multi-user aware. Being a class with a well-defined interface, implementation
  // details are easy to change for cleverer, multi-user schemes. This class is
  // a (non-enforced) singleton.

type
  TIDAllocator = class
  private
    FNextID: TObjectID;
    function GetNextID: TObjectID;
    procedure SetNextID (Value: TObjectID);
  public
    property NextID: TObjectID read GetNextID write SetNextID;
  end;

var
  IDAllocator: TIDAllocator;
  
implementation

// TIDAllocator

function TIDAllocator.GetNextID: TObjectID;
begin
  Inc (FNextID);
  Result := FNextID;
end;

procedure TIDAllocator.SetNextID (Value: TObjectID);
begin
  if Value > FNextID then FNextID := Value;
end;

initialization
  IDAllocator := TIDAllocator.Create;

finalization
  IDAllocator.Free;

end.

