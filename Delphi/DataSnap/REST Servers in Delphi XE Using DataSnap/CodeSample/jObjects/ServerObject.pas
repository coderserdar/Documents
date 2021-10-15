unit ServerObject;

interface

uses
  SysUtils, Classes, DSServer, DBXJson;

type
  TMyData = class (TPersistent)
  private
    FName: String;
    FValue: Integer;
  private
    procedure SetName(const Value: String);
    procedure SetValue(const Value: Integer);
  public
    property Name: String read FName write SetName;
    property Value: Integer read FValue write SetValue;
  public
    constructor Create (const aName: string);
  end;

type
{$METHODINFO ON}
  TObjectsRest = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
    destructor Destroy; override;
    // class function NewInstance: TObject; override;

    function List: TJSONArray;

    function MyData (const aName: string): TJSONObject;
    procedure updateMyData (const aName: string; jObject: TJSONObject);
    procedure cancelMyData (const aName: string);
    procedure acceptMyData (const aName: string; jObject: TJSONObject);
  end;
{$METHODINFO OFF}

implementation

{$R *.dfm}

uses
  StrUtils, Generics.Collections, Rtti, RestPlusUtils;

var
  DataDict: TObjectDictionary <string, TMyData>;
  objCount: Integer = 0;

//function TMyDataToForm (anObj)
//{
//   $("#TMyData #Name").val(anObj.Name);
//   $("#TMyData #Value").val(anObj.Value);
//};
//
//function FormToTMyData (anObj)
//{
//   anObj.Name = $("#TMyData #Name").val();
//   anObj.Value = $("#TMyData #Value").val();
//};

procedure AddToDictionary (const aName: string; nVal: Integer = -1);
var
  md: TMyData;
begin
  md := TMyData.Create (aName);
  if nVal <> -1 then
    md.Value := nVal;
  DataDict.Add(aName, md);
end;

{ TMyData }

constructor TMyData.Create(const aName: string);
begin
  Name := aName;
  Value := Random (10000);
end;

procedure TObjectsRest.cancelMyData(const aName: string);
begin
  DataDict.Remove(aName);
end;

destructor TObjectsRest.Destroy;
begin
  dec (objCount);
  inherited;
end;

function TObjectsRest.List: TJSONArray;
var
  str: string;
begin
  Result := TJSONArray.Create;
  for str in DataDict.Keys do
  begin
    Result.Add(str);
  end;
end;

function TObjectsRest.MyData(const aName: string): TJSONObject;
var
  md: TMyData;
begin
  md := DataDict[aName];
//  Result := TJSONObject.Create;
//  Result.AddPair(
//    TJSONPair.Create ('Name', md.Name));
//  Result.AddPair(
//    TJSONPair.Create ('Value',
//      TJSONNumber.Create(md.Value)));
  Result := ObjectToJson (md);
end;

procedure TObjectsRest.updateMyData (const aName: string; jObject: TJSONObject);
var
  md: TMyData;
begin
  md := DataDict[aName];
  // md.Value := StrToIntDef (jObject.Get('Value').JsonValue.Value, 0);
  JsonToObject (md, jObject);
end;

procedure TObjectsRest.acceptMyData(const aName: string; jObject: TJSONObject);
var
  md: TMyData;
begin
  md := TMyData.Create (aName);
  md.Value := StrToIntDef (jObject.Get('Value').JsonValue.Value, 0);
  // JsonToObject (md, jObject);
  DataDict.Add(aName, md);
end;

procedure TMyData.SetName(const Value: String);
begin
  FName := Value;
end;

procedure TMyData.SetValue(const Value: Integer);
begin
  FValue := Value;
end;

initialization
  randomize;
  DataDict := TObjectDictionary <string,TMyData>.Create;
  AddToDictionary('Sample');
  AddToDictionary('Test');


end.

