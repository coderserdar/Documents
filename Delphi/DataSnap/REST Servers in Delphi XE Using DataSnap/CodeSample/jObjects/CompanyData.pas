unit CompanyData;

interface

uses
  SysUtils, Classes, DSServer, DBXJson;

{$METHODINFO ON}  
type
  TCompanyServer = class (TPersistent)
  public
    function Company: TJSONObject;
    procedure updateCompany (jObject: TJSONObject);
    procedure cancelCompany;
    procedure acceptCompany (jObject: TJSONObject);
  end;
{$METHODINFO OFF}  

type
  TCompanyData = class
  private
    FContactEmail: string;
    FContactPhone: string;
    FState: string;
    FCompanyName: string;
    FContactFullName: string;
    FZipCode: string;
    FCountry: string;
    FCity: string;
    FAddress: string;
    procedure SetAddress(const Value: string);
    procedure SetCity(const Value: string);
    procedure SetCompanyName(const Value: string);
    procedure SetContactEmail(const Value: string);
    procedure SetContactFullName(const Value: string);
    procedure SetContactPhone(const Value: string);
    procedure SetCountry(const Value: string);
    procedure SetState(const Value: string);
    procedure SetZipCode(const Value: string);
  public
    property CompanyName: string read FCompanyName write SetCompanyName;
    property Address: string read FAddress write SetAddress;
    property City: string read FCity write SetCity;
    property ZipCode: string read FZipCode write SetZipCode;
    property State: string read FState write SetState;
    property Country: string read FCountry write SetCountry;
    property ContactFullName: string read FContactFullName write SetContactFullName;
    property ContactEmail: string read FContactEmail write SetContactEmail;
    property ContactPhone: string read FContactPhone write SetContactPhone;
  end;

  var
    TheCompany: TCompanyData = nil;

implementation

uses
  ServerObject, RestPlusUtils;

{ TCompanyData }

procedure TCompanyData.SetAddress(const Value: string);
begin
  FAddress := Value;
end;

procedure TCompanyData.SetCity(const Value: string);
begin
  FCity := Value;
end;

procedure TCompanyData.SetCompanyName(const Value: string);
begin
  FCompanyName := Value;
end;

procedure TCompanyData.SetContactEmail(const Value: string);
begin
  FContactEmail := Value;
end;

procedure TCompanyData.SetContactFullName(const Value: string);
begin
  FContactFullName := Value;
end;

procedure TCompanyData.SetContactPhone(const Value: string);
begin
  FContactPhone := Value;
end;

procedure TCompanyData.SetCountry(const Value: string);
begin
  FCountry := Value;
end;

procedure TCompanyData.SetState(const Value: string);
begin
  FState := Value;
end;

procedure TCompanyData.SetZipCode(const Value: string);
begin
  FZipCode := Value;
end;

{ TCompanyServer }

procedure TCompanyServer.acceptCompany(jObject: TJSONObject);
begin
  // re-create if already exists
  if Assigned (TheCompany) then
    TheCompany.Free;
  TheCompany := TCompanyData.Create;
  JsonToObject (TheCompany, jObject);
end;

procedure TCompanyServer.cancelCompany;
begin
  if Assigned (TheCompany) then
    FreeAndNil (TheCompany);
  // ignroe if not there  
end;

function TCompanyServer.Company: TJSONObject;
begin
  if Assigned (TheCompany) then
    Result := ObjectToJson(TheCompany)
  else
    raise Exception.Create('Company doens''t exist');    
end;

procedure TCompanyServer.updateCompany(jObject: TJSONObject);
begin
  if Assigned (TheCompany) then
    JsonToObject (TheCompany, jObject)
  else
    raise Exception.Create('Company doens''t exist');
end;

end.
