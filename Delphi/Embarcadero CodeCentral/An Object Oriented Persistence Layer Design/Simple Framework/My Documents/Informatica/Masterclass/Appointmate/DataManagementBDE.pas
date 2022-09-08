unit DataManagementBDE;

// This unit provides data management support for BDE databases.
// Note that this is the first (only) unit which references the BDE.
// Therefore, changing the implementation of our object allows us to completely
// change the nature of the persistent storage of our objects.

interface

uses
  Classes, DBTables, Framework;

type
  TBDEObject = class (TDMObject)
  private
    Query: TQuery;
    Fields: TStringList;
    function GetIntegerField (Name: String): Integer;
    function GetStringField (Name: String): String;
    function GetDateTimeField (Name: String): TDateTime;
    function GetBooleanField (Name: String): Boolean;
    procedure SetIntegerField (Name: String; Value: Integer);
    procedure SetStringField (Name: String; Value: String);
    procedure SetDateTimeField (Name: String; Value: TDateTime);
    procedure SetBooleanField (Name: String; Value: Boolean);
    procedure UpdateFields;
    procedure ExecuteSQL (SQL: String);
  protected
    // Override this method if you want a different table name other than the
    // default (based on the class name, less any "DM" suffix);
    function TableName: String; virtual;

    // These properties are provided for use in the methods below
    property IntegerField[Name: String]: Integer read GetIntegerField write SetIntegerField;
    property StringField[Name: String]: String read GetStringField write SetStringField;
    property DateTimeField[Name: String]: TDateTime read GetDateTimeField write SetDateTimeField;
    property BooleanField[Name: String]: Boolean read GetBooleanField write SetBooleanField;

    // All descendant classes must override these methods and use the
    // IntegerField, StringField etc properties to update the object and database
    procedure PopulateObject (PDObject: TPDObject); virtual; abstract;
    procedure PopulateFields (PDObject: TPDObject); virtual; abstract;

    // This is the standard "contract" that our DMObject must provide.
    // TBDEObject does not implement the SaveObject method. Therefore, all
    // class-specific descendants must implement this appropriately by constructing
    // the appropriate SQL text and calling ExecuteSQL. They must detect whether the
    // instance is a new one, and if so, allocate a new ID appropriately.
    procedure LoadObject (ObjectToLoad: TPDObject); override;
    procedure SaveObject (ObjectToSave: TPDObject); override;
    procedure DeleteObject (ObjectToDelete: TPDObject); override;
    function NextObject (ObjectToLoad: TPDObject): Boolean; override;

  public
    // This constructor creates the DMObject for standard load/save operations
    constructor Create; overload;
    // This constructor creates the DMObject for list operations, using the supplied query
    constructor Create (SQLQuery: String); overload;
    destructor Destroy; override;

    procedure Initialise;
  end;

procedure Initialise (DatabaseName: String);

implementation

uses
  SysUtils, IDAllocation;

var
  // The database connection we will use
  Database: TDatabase;

constructor TBDEObject.Create;
begin
  inherited;
  Fields := TStringList.Create;
  Query := TQuery.Create (nil);
  Query.DatabaseName := Database.DatabaseName;
end;

constructor TBDEObject.Create (SQLQuery: String);
begin
  Create;
  ExecuteSQL (SQLQuery);
end;

destructor TBDEObject.Destroy;
begin
  Query.Free;
  Fields.Free;
  inherited;
end;

procedure TBDEObject.Initialise;
begin
  // Initialise our ID allocator with the maximum ID on file
  ExecuteSQL ('SELECT MAX(ID) AS MAXID FROM ' + TableName);
  IDAllocator.NextID := Query.FieldByName ('MAXID').AsInteger;
  Query.Close;
end;

function TBDEObject.TableName: String;
begin
  Result := Copy (ClassName, 2, Length (ClassName) - 1);
  if Copy (Result, Length (Result) - 1, 2) = 'DM' then Result := Copy (Result, 1, Length (Result) - 2);
end;

function TBDEObject.GetIntegerField (Name: String): Integer;
begin
  Result := StrToIntDef (Fields.Values[Name], 0);
end;

function TBDEObject.GetStringField (Name: String): String;
begin
  Result := Fields.Values[Name];
end;

function TBDEObject.GetDateTimeField (Name: String): TDateTime;
begin
  try
    Result := StrToFloat (Fields.Values[Name]);
  except
    Result := 0.0;
  end;
end;

function TBDEObject.GetBooleanField (Name: String): Boolean;
begin
  Result := (Fields.Values[Name] = 'True');
end;

procedure TBDEObject.SetIntegerField (Name: String; Value: Integer);
begin
  Fields.Values[Name] := IntToStr (Value);
end;

procedure TBDEObject.SetStringField (Name: String; Value: String);
begin
  Fields.Values[Name] := '''' + Value + '''';
end;

procedure TBDEObject.SetDateTimeField (Name: String; Value: TDateTime);
begin
  Fields.Values[Name] := FloatToStr (Value);
end;

procedure TBDEObject.SetBooleanField (Name: String; Value: Boolean);
begin
  if Value then begin
    Fields.Values[Name] := 'True';
  end else begin
    Fields.Values[Name] := 'False';
  end;
end;

procedure TBDEObject.UpdateFields;
var
  Index: Integer;
begin
  Fields.Clear;
  for Index := 0 to Query.FieldCount - 1 do begin
    Fields.Values[Query.Fields[Index].FieldName] := Query.Fields[Index].AsString;
  end;
end;

procedure TBDEObject.ExecuteSQL (SQL: String);
begin
  Query.SQL.Clear;
  Query.SQL.Add (SQL);
  if UpperCase (Copy (Trim (SQL), 1, 6)) = 'SELECT' then begin
    // Hold query open
    Query.Open;
  end else begin
    // Just bang off the query to the database
    Query.ExecSQL;
  end;
end;

procedure TBDEObject.LoadObject (ObjectToLoad: TPDObject);
begin
  ExecuteSQL ('SELECT * FROM ' + TableName + ' WHERE ID=' + IDToStr (ObjectToLoad.ID));
  SetObjectID (ObjectToLoad, Query.FieldByName ('ID').AsInteger);
  UpdateFields;
  PopulateObject (ObjectToLoad);
  Query.Close;
end;

procedure TBDEObject.SaveObject (ObjectToSave: TPDObject);
var
  Query: String;
  Index: Integer;
begin
  Fields.Clear;
  PopulateFields (ObjectToSave);
  if ObjectToSave.IsAssigned then begin
    // Build up "UPDATE" SQL Text
    Query := 'UPDATE ' + TableName + ' SET ';
    for Index := 0 to Fields.Count - 1 do begin
      Query := Query + Fields[Index];
      if Index <> Fields.Count - 1 then Query := Query + ',';
    end;
    Query := Query + ' WHERE ID=' + IDToStr (ObjectToSave.ID);
  end else begin
    // Assign unique ID
    SetObjectID (ObjectToSave, IDAllocator.NextID);
    // Build up "INSERT" SQL Text
    Query := 'INSERT INTO ' + TableName + ' (ID';
    for Index := 0 to Fields.Count - 1 do begin
      Query := Query + ',' + Fields.Names[Index];
    end;
    Query := Query + ') VALUES (' + IDToStr (ObjectToSave.ID);
    for Index := 0 to Fields.Count - 1 do begin
      Query := Query + ',' + Fields.Values[Fields.Names[Index]];
    end;
    Query := Query + ')';
  end;
  ExecuteSQL (Query);
end;

procedure TBDEObject.DeleteObject (ObjectToDelete: TPDObject);
begin
  ExecuteSQL ('DELETE FROM ' + TableName + ' WHERE ID=' + IDToStr (ObjectToDelete.ID));
end;

function TBDEObject.NextObject (ObjectToLoad: TPDObject): Boolean;
begin
  if Query.EOF then begin
    Query.Close;
    Result := False;
  end else begin
    SetObjectID (ObjectToLoad, Query.FieldByName ('ID').AsInteger);
    UpdateFields;
    PopulateObject (ObjectToLoad);
    Query.Next;
    Result := True;
  end;
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

