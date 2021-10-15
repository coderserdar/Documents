unit DBXClientClasses;
interface
uses 
  DBXCommon, DBXClient, DBXJSON, DSProxy, Classes, SysUtils, DB, SqlExpr, DBXDBReaders, DBXJSONReflect;

type
  TServerMethods1Client = class(TDSAdminClient)
  private
    FServerTimeCommand: TDBXCommand;
    FGetCurrentUserIDCommand: TDBXCommand;
    FGetCurrentUserRolesCommand: TDBXCommand;
    FGetUserNamesCommand: TDBXCommand;
    FAddUserCommand: TDBXCommand;
    FReportNewIssueCommand: TDBXCommand;
    FGetIssuesCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function ServerTime: TDateTime;
    function GetCurrentUserID: Integer;
    function GetCurrentUserRoles: string;
    function GetUserNames: TDataSet;
    procedure AddUser(User: string; Password: string; Role: string; Email: string);
    function ReportNewIssue(Project: string; Version: string; Module: string; IssueType: Integer; Priority: Integer; Summary: string; Report: string; AssignedTo: Integer): Boolean;
    function GetIssues(MinStatus: Integer; MaxStatus: Integer): TDataSet;
  end;

implementation

function TServerMethods1Client.ServerTime: TDateTime;
begin
  if FServerTimeCommand = nil then
  begin
    FServerTimeCommand := FDBXConnection.CreateCommand;
    FServerTimeCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FServerTimeCommand.Text := 'TServerMethods1.ServerTime';
    FServerTimeCommand.Prepare;
  end;
  FServerTimeCommand.ExecuteUpdate;
  Result := FServerTimeCommand.Parameters[0].Value.AsDateTime;
end;

function TServerMethods1Client.GetCurrentUserID: Integer;
begin
  if FGetCurrentUserIDCommand = nil then
  begin
    FGetCurrentUserIDCommand := FDBXConnection.CreateCommand;
    FGetCurrentUserIDCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetCurrentUserIDCommand.Text := 'TServerMethods1.GetCurrentUserID';
    FGetCurrentUserIDCommand.Prepare;
  end;
  FGetCurrentUserIDCommand.ExecuteUpdate;
  Result := FGetCurrentUserIDCommand.Parameters[0].Value.GetInt32;
end;

function TServerMethods1Client.GetCurrentUserRoles: string;
begin
  if FGetCurrentUserRolesCommand = nil then
  begin
    FGetCurrentUserRolesCommand := FDBXConnection.CreateCommand;
    FGetCurrentUserRolesCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetCurrentUserRolesCommand.Text := 'TServerMethods1.GetCurrentUserRoles';
    FGetCurrentUserRolesCommand.Prepare;
  end;
  FGetCurrentUserRolesCommand.ExecuteUpdate;
  Result := FGetCurrentUserRolesCommand.Parameters[0].Value.GetWideString;
end;

function TServerMethods1Client.GetUserNames: TDataSet;
begin
  if FGetUserNamesCommand = nil then
  begin
    FGetUserNamesCommand := FDBXConnection.CreateCommand;
    FGetUserNamesCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetUserNamesCommand.Text := 'TServerMethods1.GetUserNames';
    FGetUserNamesCommand.Prepare;
  end;
  FGetUserNamesCommand.ExecuteUpdate;
  Result := TCustomSQLDataSet.Create(nil, FGetUserNamesCommand.Parameters[0].Value.GetDBXReader(False), True);
  Result.Open;
  if FInstanceOwner then
    FGetUserNamesCommand.FreeOnExecute(Result);
end;

procedure TServerMethods1Client.AddUser(User: string; Password: string; Role: string; Email: string);
begin
  if FAddUserCommand = nil then
  begin
    FAddUserCommand := FDBXConnection.CreateCommand;
    FAddUserCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FAddUserCommand.Text := 'TServerMethods1.AddUser';
    FAddUserCommand.Prepare;
  end;
  FAddUserCommand.Parameters[0].Value.SetWideString(User);
  FAddUserCommand.Parameters[1].Value.SetWideString(Password);
  FAddUserCommand.Parameters[2].Value.SetWideString(Role);
  FAddUserCommand.Parameters[3].Value.SetWideString(Email);
  FAddUserCommand.ExecuteUpdate;
end;

function TServerMethods1Client.ReportNewIssue(Project: string; Version: string; Module: string; IssueType: Integer; Priority: Integer; Summary: string; Report: string; AssignedTo: Integer): Boolean;
begin
  if FReportNewIssueCommand = nil then
  begin
    FReportNewIssueCommand := FDBXConnection.CreateCommand;
    FReportNewIssueCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FReportNewIssueCommand.Text := 'TServerMethods1.ReportNewIssue';
    FReportNewIssueCommand.Prepare;
  end;
  FReportNewIssueCommand.Parameters[0].Value.SetWideString(Project);
  FReportNewIssueCommand.Parameters[1].Value.SetWideString(Version);
  FReportNewIssueCommand.Parameters[2].Value.SetWideString(Module);
  FReportNewIssueCommand.Parameters[3].Value.SetInt32(IssueType);
  FReportNewIssueCommand.Parameters[4].Value.SetInt32(Priority);
  FReportNewIssueCommand.Parameters[5].Value.SetWideString(Summary);
  FReportNewIssueCommand.Parameters[6].Value.SetWideString(Report);
  FReportNewIssueCommand.Parameters[7].Value.SetInt32(AssignedTo);
  FReportNewIssueCommand.ExecuteUpdate;
  Result := FReportNewIssueCommand.Parameters[8].Value.GetBoolean;
end;

function TServerMethods1Client.GetIssues(MinStatus: Integer; MaxStatus: Integer): TDataSet;
begin
  if FGetIssuesCommand = nil then
  begin
    FGetIssuesCommand := FDBXConnection.CreateCommand;
    FGetIssuesCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetIssuesCommand.Text := 'TServerMethods1.GetIssues';
    FGetIssuesCommand.Prepare;
  end;
  FGetIssuesCommand.Parameters[0].Value.SetInt32(MinStatus);
  FGetIssuesCommand.Parameters[1].Value.SetInt32(MaxStatus);
  FGetIssuesCommand.ExecuteUpdate;
  Result := TCustomSQLDataSet.Create(nil, FGetIssuesCommand.Parameters[2].Value.GetDBXReader(False), True);
  Result.Open;
  if FInstanceOwner then
    FGetIssuesCommand.FreeOnExecute(Result);
end;


constructor TServerMethods1Client.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;


constructor TServerMethods1Client.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;


destructor TServerMethods1Client.Destroy;
begin
  FreeAndNil(FServerTimeCommand);
  FreeAndNil(FGetCurrentUserIDCommand);
  FreeAndNil(FGetCurrentUserRolesCommand);
  FreeAndNil(FGetUserNamesCommand);
  FreeAndNil(FAddUserCommand);
  FreeAndNil(FReportNewIssueCommand);
  FreeAndNil(FGetIssuesCommand);
  inherited;
end;

end.

