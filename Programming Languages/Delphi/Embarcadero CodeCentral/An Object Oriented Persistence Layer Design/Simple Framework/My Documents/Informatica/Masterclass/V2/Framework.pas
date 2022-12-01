unit Framework;

// This is a basic framework unit that provides base classes for
// Problem Domain (PD) and Data Management (DM) objects.
// It is a simple yet functional example - much more can be done!
// In particular much better data control can be managed, and PD classes
// can be less onerous to implement.
//
// Author: Philip Brown
// Copyright Informatica Systems Ltd, 1999
//
// This code may be freely used by the companies represented and delegates of
// the UK BUG OOP Masterclass on 29th July 1999.

interface

uses
  Classes;

type
  // Something we will use to represent unique object ID's
  TObjectID = type Integer;

  // Forward references
  TPDObject = class;
  TDMObject = class;

  // Class reference type
  TPDClass = class of TPDObject;

  // The main class of Problem Domain objects, that represent real-life
  // "business objects" in the system

  TPDObject = class
  private
    // The unique ID for this object
    FID: TObjectID;
    function GetIsAssigned: Boolean;
  protected
    // This is a reference to a class which will be used to load and save us.
    // It must be initialised in the object constructor.
    DMObject: TDMObject;
    function GetObject (ObjectClass: TPDClass; var PDObject: TPDObject; ObjectID: TObjectID): TPDObject;
  public
    // Need a virtual constructor so that objects are created correctly
    constructor Create; virtual;

    // These methods are virtual to allow PD objects to override them.
    // This is rarely necessary, however.
    procedure Load (ID: TObjectID); virtual;
    procedure Save; virtual;
    procedure Delete; virtual;
    procedure Assign (OtherObject: TPDObject); virtual;
    function IsSameObject (OtherObject: TPDObject): Boolean;

    property ID: TObjectID read FID;
    property IsAssigned: Boolean read GetIsAssigned;
  end;

  // The class of Data Management objects, responsible for storing PD object
  // state information persistently. This is a database-independent definition,
  // which is abstract (ie not implemented here). It defines a "contract"
  // for descendant classes to follow. This allows us to provide database
  // representation independence. The interface to your DMObject depends entirely
  // upon the functionality your framework requires, but should remain database
  // independent. This simple framework for demonstration purposes makes few demands
  // on our DMObject, but real-world frameworks can get more complex. Note that
  // this class has no public interface, as it is conceptually a worker class
  // that is *only* used by the framework internals.

  TDMObject = class
  protected
    // As the ID property of objects is read-only to prevent abuse, this method
    // can be called by DMObject descendants to update the ID of an object when
    // loading. This avoids making the ID publicly writeable.
    procedure SetObjectID (ObjectToSet: TPDObject; ID: TObjectID);
    // This method is called to populate an object from persistent storage. The
    // ID of the object to load should already be defined.
    procedure LoadObject (ObjectToLoad: TPDObject); virtual; abstract;
    // This method is called to save an object to persistent storage. The ID may
    // be undefined, which indicates a new instance to be saved. The persistent
    // storage mechanism should allocate a unique ID to the object in this case.
    procedure SaveObject (ObjectToSave: TPDObject); virtual; abstract;
    // This method deletes an object from persistent storage.
    procedure DeleteObject (ObjectToDelete: TPDObject); virtual; abstract;
    // This method should populate the passed object as the "next" object from a
    // list. It should return True if there was a object to populate, or False if
    // list exhausted.
    function NextObject (ObjectToLoad: TPDObject): Boolean; virtual; abstract;
  end;

  // A class reponsible for presenting lists of objects.
  // This is a very simple and non-optimal version; interface and implementation
  // opportunities are endless! The interface presented here is a preferred one,
  // as it is more general and applies to many implementation options where the
  // list member count cannot be determined exactly.

  TPDList = class
  private
    List: TList;
    Index: Integer;
    function GetCurrentObject: TPDObject;
    function GetIsFirst: Boolean;
    function GetIsLast: Boolean;
  public
    // Creates the list of objects of class PDClass, using the supplied DMObject
    // The PDList "owns" the DMObject, therefore the calling class should not
    // attempt to free the DMObject at any stage
    constructor Create (PDClass: TPDClass; DMObject: TDMObject);
    destructor Destroy; override;
    procedure First;
    procedure Next;
    procedure Previous;
    procedure Last;
    property IsFirst: Boolean read GetIsFirst;
    property IsLast: Boolean read GetIsLast;
    property CurrentObject: TPDObject read GetCurrentObject;
  end;

// Some procedures to convert our ID's to string representations

function IDToStr (ID: TObjectID): String;
function StrToID (IDStr: String): TObjectID;

implementation

uses
  SysUtils, Forms, IniFiles;

const
  // This constant represents an ID which means "object not assigned".
  // It has been chosen so that we don't explicitly need to initialise it in
  // our PDObject constructors, as they will hold this value by default.
  NullID = 0;

// TPDObject

constructor TPDObject.Create;
begin
  // Introduce virtual constructor
  inherited;
end;

function TPDObject.GetObject (ObjectClass: TPDClass; var PDObject: TPDObject; ObjectID: TObjectID): TPDObject;
begin
  if PDObject = nil then begin
    // Create a new PDObject if we need one - note that this relies upon a virtual
    // constructor to work correctly
    PDObject := ObjectClass.Create;
    // If the object has an ID then initialise it from the database
    if ObjectID <> NullID then PDObject.Load (ObjectID);
  end;
  Result := PDObject;
end;

procedure TPDObject.Load (ID: TObjectID);
begin
  // Note that a PDObject has no concept of how to actually perform a load or
  // save operation; all it can do is request something else to perform those tasks.
  Assert (DMObject <> nil, Self.ClassName + '.Load: no DMObject assigned!');
  Assert (ID <> NullID, Self.ClassName + '.Load: attempt to load null object ID!');
  FID := ID;
  DMObject.LoadObject (Self);
end;

procedure TPDObject.Save;
begin
  Assert (DMObject <> nil, Self.ClassName + '.Load: no DMObject assigned!');
  DMObject.SaveObject (Self);
end;

procedure TPDObject.Delete;
begin
  if IsAssigned then DMObject.DeleteObject (Self);
end;

procedure TPDObject.Assign (OtherObject: TPDObject);
begin
  // Copy the contents of the other object into this one.
  // Easy way to is to just load the other object ID into this one.
  Assert (OtherObject.IsAssigned, Self.ClassName + '.Assign: other object has not been assigned!');
  Load (OtherObject.ID);
end;

function TPDObject.IsSameObject (OtherObject: TPDObject): Boolean;
begin
  Result := (ID = OtherObject.ID);
end;

function TPDObject.GetIsAssigned: Boolean;
begin
  Result := (ID <> NullID);
end;

// TDMObject

procedure TDMObject.SetObjectID (ObjectToSet: TPDObject; ID: TObjectID);
begin
  ObjectToSet.FID := ID;
end;

// TPDList

// This is a very simple implementation of a PDList and simply loads all
// objects into a delegated TList when the list is constructed. More optimal
// versions have the same interface, but hold a dynamic resultset open and
// scan through the database cursor. Of course, actual implementation details
// can vary greatly depending upon your database support and the design of your
// DMObjects.

constructor TPDList.Create (PDClass: TPDClass; DMObject: TDMObject);
var
  NewObject: TPDObject;
begin
  inherited Create;
  List := TList.Create;
  // Navigate through the DM object, saving all objects in our list
  repeat
    // Create a new instance of the PD class required
    NewObject := PDClass.Create;
    if DMObject.NextObject (NewObject) then begin
      // Add it to the list
      List.Add (NewObject);
    end else begin
      // Release resources and indicate list exhausted
      NewObject.Free;
      NewObject := nil;
    end;
  until NewObject = nil;
end;

destructor TPDList.Destroy;
begin
  while List.Count > 0 do begin
    TPDObject (List[0]).Free;
    List.Delete (0);
  end;
  List.Free;
  inherited;
end;

function TPDList.GetCurrentObject: TPDObject;
begin
  Assert ((Index >= 0) and (Index < List.Count), Self.ClassName + '.GetCurrentObject: invalid index value!');
  Result := List[Index];
end;

function TPDList.GetIsFirst: Boolean;
begin
  Result := (Index < 0);
end;

function TPDList.GetIsLast: Boolean;
begin
  Result := (Index >= List.Count);
end;

procedure TPDList.First;
begin
  Index := 0;
end;

procedure TPDList.Next;
begin
  Inc (Index);
end;

procedure TPDList.Previous;
begin
  Dec (Index);
end;

procedure TPDList.Last;
begin
  Index := List.Count;
end;

// Unit methods

function IDToStr (ID: TObjectID): String;
begin
  Result := IntToStr (ID);
end;

function StrToID (IDStr: String): TObjectID;
begin
  Result := StrToInt (IDStr);
end;

end.

