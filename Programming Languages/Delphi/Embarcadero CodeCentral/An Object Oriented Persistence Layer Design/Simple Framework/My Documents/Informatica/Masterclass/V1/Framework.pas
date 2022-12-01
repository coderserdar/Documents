unit Framework;

interface

const
  NoID = 0;

type
  TObjectID = type Integer;

  TDMObject = class;

  TPDObject = class
  private
    FID: TObjectID;
  protected
    DMObject: TDMObject;
  public
    procedure Load (ID: TObjectID); virtual;
    procedure Save; virtual;
    procedure Delete; virtual;
    property ID: TObjectID read FID;
  end;

  TDMObject = class
  protected
    procedure LoadObject (PDObject: TPDObject); virtual; abstract;
    function SaveObject (PDObject: TPDObject): TObjectID; virtual; abstract;
    procedure DeleteObject (PDObject: TPDObject); virtual; abstract;
  end;

function IDToStr (ID: TObjectID): String;
function StrToID (IDStr: String): TObjectID;

implementation

uses
  SysUtils;
  
// TPDObject

procedure TPDObject.Load (ID: TObjectID);
begin
  FID := ID;
  DMObject.LoadObject (Self);
end;

procedure TPDObject.Save;
begin
  FID := DMObject.SaveObject (Self);
end;

procedure TPDObject.Delete;
begin
  DMObject.DeleteObject (Self);
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

