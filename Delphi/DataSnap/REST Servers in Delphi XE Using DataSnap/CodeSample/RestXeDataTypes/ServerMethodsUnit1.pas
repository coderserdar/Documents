unit ServerMethodsUnit1;

interface

uses
  SysUtils, Classes, DSServer, DateUtils, Windows, DB, DBXJSON, DBClient,
  DBXJSONReflect, MarshallingUtils;

type
  TPerson = class
  private
    FAge: Integer;
    FLastName: string;
    FFirstName: string;
    procedure SetAge(const Value: Integer);
    procedure SetFirstName(const Value: string);
    procedure SetLastName(const Value: string);
  public
    property LastName: string read FLastName write SetLastName;
    property FirstName: string read FFirstName write SetFirstName;
    property Age: Integer read FAge write SetAge;
  end;

  TPersonData = class (TPerson)
  private
    [JSONReflect(ctString, rtString, TISODateTimeInterceptor, nil,true)]
    FDateOfBirth: TDate;
    [JSONReflect(ctTypeObject, rtTypeObject, TStringListInterceptor,nil,true)]
    FMoreData: TStringList;
    procedure SetMoreData(const Value: TStringList);
    procedure SetDateofBirth(const Value: TDate);
  public
    constructor Create;
    destructor Destroy; override;
    property MoreData: TStringList read FMoreData write SetMoreData;
    property DateofBirth: TDate read FDateofBirth write SetDateofBirth;
  end;

{$METHODINFO ON}
  TServerMethods1 = class(TDataModule)
    ClientDataSet1: TClientDataSet;
  private
    { Private declarations }
  public
    // base data types
    function AddInt (a, b: Integer): Integer;
    function AddDouble (a, b: Double): Double;
    function IsOK: Boolean;
    function GetLargeString (nCount: Integer): string;
    // function Today: TDate;
    // function GetLineBreak: TTextLineBreakStyle;
    // records and classes
    // function GetArea: TRect; // record
    function GetPerson: TPerson;
    [JSONReflect(ctTypeObject, rtTypeObject, TStringListInterceptor,nil,true)]
    function GetNames: TStringList;
    function GetArrayOfNames: TListOfStrings; // ignored
    function GetPersonWithData: TPersonData;
    // datasets and streams
    function GetCustomers: TDataSet;
    function GetImage: TStream;
    function ImageAvailable (const strImageName: string; out aStream: TStream): Boolean;
    // JSON
    function GetPersonJson: TJSONObject;
    function GetNamesJson: TJSONArray;
  end;
{$METHODINFO OFF}

implementation

{$R *.dfm}

uses StrUtils;

{ TPerson }

procedure TPerson.SetAge(const Value: Integer);
begin
  FAge := Value;
end;

procedure TPerson.SetFirstName(const Value: string);
begin
  FFirstName := Value;
end;

procedure TPerson.SetLastName(const Value: string);
begin
  FLastName := Value;
end;

{ TPersonData }

constructor TPersonData.Create();
begin
  fMoreData := TStringList.Create;
end;

destructor TPersonData.Destroy;
begin
  fMoreData.Free;
  inherited;
end;

procedure TPersonData.SetDateofBirth(const Value: TDate);
begin
  FDateofBirth := Value;
end;

procedure TPersonData.SetMoreData(const Value: TStringList);
begin
  FMoreData.Assign(Value);
end;

{ TServerMethods1 }

function TServerMethods1.AddDouble(a, b: Double): Double;
begin
  Result := a + b;
end;

function TServerMethods1.AddInt(a, b: Integer): Integer;
begin
  Result := a + b;
end;

//function TServerMethods1.GetArea: TRect;
//begin
//  Result := Rect (10, 10, 100, 200);
//end;

function TServerMethods1.GetArrayOfNames: TListOfStrings;
begin
  SetLength (Result, 3);
  Result[0] := 'one';
  Result[1] := 'two';
  Result[2] := 'three';
end;

function TServerMethods1.GetCustomers: TDataSet;
begin
  ClientDataSet1.Open;
  ClientDataSet1.MergeChangeLog; // clean up, just in case
  Result := ClientDataSet1;
end;

function TServerMethods1.GetImage: TStream;
var
  fStream: TFileStream;
begin
  fStream := TFileStream.Create('images\expand.png', fmOpenRead);
  Result := fStream;
end;

function TServerMethods1.GetLargeString(nCount: Integer): string;
var
  I: Integer;
begin
  Result := StringOfChar('o', nCount);
  for I := 1 to length(Result) do
    if (i mod 10) = 0 then
      Result [I] := 'x';
end;

function TServerMethods1.GetNames: TStringList;
begin
  Result := TStringList.Create;
  Result.Add('one');
  Result.Add('two');
  Result.Add('three');
end;

function TServerMethods1.GetNamesJson: TJSONArray;
begin
  Result := TJSONArray.Create;
  Result.Add('one');
  Result.Add('two');
  Result.Add('three');
end;

function TServerMethods1.GetPerson: TPerson;
begin
  Result := TPerson.Create;
  Result.LastName := 'Smith';
  Result.FirstName := 'Joe';
  Result.Age := 44;
end;

function TServerMethods1.GetPersonJson: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair ('LastName', 'Smith');
  Result.AddPair ('FirstName', 'Joe');
  Result.AddPair ('Age', TJsonNumber.Create (44));
end;

function TServerMethods1.GetPersonWithData: TPersonData;
begin
  Result := TPersonData.Create;
  Result.LastName := 'Smith';
  Result.FirstName := 'Joe';
  Result.Age := 44;
  Result.DateOfBirth := Date - 1000;
  Result.MoreData.Add('Hello');
  Result.MoreData.Add('Joe');
end;

//function TServerMethods1.GetLineBreak: TTextLineBreakStyle;
//begin
//  Result := tlbsCRLF;
//end;

function TServerMethods1.ImageAvailable(const strImageName: string;
  out aStream: TStream): Boolean;
begin
  Result := False;
  if strImageName = 'expand.png' then
  begin
    aStream := TFileStream.Create('images\expand.png', fmOpenRead);
    Result := True;
  end;
end;

function TServerMethods1.IsOK: Boolean;
begin
  Result := True;
end;

//function TServerMethods1.Today: TDate;
//begin
//  Result := Date;
//end;

initialization
  ReportMemoryLeaksOnShutdown := True;

end.

