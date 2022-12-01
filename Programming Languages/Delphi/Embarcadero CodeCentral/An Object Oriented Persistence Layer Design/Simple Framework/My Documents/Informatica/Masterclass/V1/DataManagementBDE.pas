unit DataManagementBDE;

interface

uses
  Framework, DBTables;

type
  TBDEObject = class (TDMObject)
  protected
    Query: TQuery;
  public
    constructor Create;
    destructor Destroy; override;
  end;

procedure Initialise (DatabaseName: String);

implementation

var
  Database: TDatabase;

// TBDEObject

constructor TBDEObject.Create;
begin
  inherited;
  Query := TQuery.Create (nil);
  Query.DatabaseName := Database.DatabaseName;
end;

destructor TBDEObject.Destroy;
begin
  Query.Free;
  inherited;
end;

// Unit methods

procedure Initialise (DatabaseName: String);
begin
  Assert (Database = nil, 'TDataManagementBDE.Initialise: database already initialised!');
  Database := TDatabase.Create (nil);
  Database.DatabaseName := DatabaseName;
  Database.KeepConnection := True;
  Database.Open;
end;

initialization

finalization
  Database.Free;

end.

