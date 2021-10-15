unit DirtServerMethods;
interface
uses
  SysUtils, Classes, DB, DSServer, DBXMSSQL, FMTBcd, SqlExpr, Provider, DSAuth,
  DBClient;

type
  TServerMethods1 = class(TDSServerModule)
    SQLConnection1: TSQLConnection;
    sqlReports: TSQLDataSet;
    sqlReportUser: TSQLDataSet;
    sqlComments: TSQLDataSet;
    dsReportUser: TDataSource;
    dspReportUserWithComments: TDataSetProvider;
    sqlUser: TSQLDataSet;
    sqlCommentsCommentID: TIntegerField;
    sqlCommentsReportID: TIntegerField;
    sqlCommentsUserID: TIntegerField;
    sqlCommentsCommentDate: TSQLTimeStampField;
    sqlCommentsComment: TWideStringField;
    sqlReportUserReportID: TIntegerField;
    sqlReportUserProject: TWideStringField;
    sqlReportUserVersion: TWideStringField;
    sqlReportUserModule: TWideStringField;
    sqlReportUserIssueType: TIntegerField;
    sqlReportUserPriority: TIntegerField;
    sqlReportUserStatus: TIntegerField;
    sqlReportUserReportDate: TSQLTimeStampField;
    sqlReportUserReporterID: TIntegerField;
    sqlReportUserAssignedTo: TIntegerField;
    sqlReportUserSummary: TWideStringField;
    sqlReportUserReport: TWideStringField;
    procedure AS_DSServerModuleCreate(Sender: TObject);
    procedure AS_dspReportUserWithCommentsBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure AS_sqlReportUserAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    const
      RoleAdmin     = 'Admin';
      RoleManager   = 'Manager';
      RoleTester    = 'Tester';
      RoleDeveloper = 'Developer';

    function HashMD5(const Str: String): String;
  public
    { Public declarations }
    function ServerTime: TDateTime;
    function GetCurrentUserID: Integer;
    function GetCurrentUserRoles: String;

    [TRoleAuth(RoleTester + ',' + RoleDeveloper)]
    function GetUserNames: TDataSet;

    [TRoleAuth(RoleAdmin)]
    procedure AddUser(const User,Password,Role,Email: String);

    [TRoleAuth(RoleTester)]
    function ReportNewIssue(Project, Version, Module: String;
      IssueType, Priority: Integer; // Status = 1
      Summary, Report: String;
      AssignedTo: Integer = -1): Boolean;

    [TRoleAuth(RoleManager)]
    // Return all issues (read-only) between MinStatus..MaxStatus
    function GetIssues(MinStatus,MaxStatus: Integer): TDataSet;
  end;

implementation
uses
  CodeSiteLogging,
  IdHashMessageDigest,
  DSService;

{$R *.dfm}

{ TServerMethods1 }

procedure TServerMethods1.AS_DSServerModuleCreate(Sender: TObject);
begin
  CodeSite.Send('DSServerModuleCreate');
  CodeSite.Send('User: ' + TDSSessionManager.GetThreadSession.UserName + #32 +
    TDSSessionManager.GetThreadSession.GetData('UserID'));
end;

procedure TServerMethods1.AS_sqlReportUserAfterScroll(DataSet: TDataSet);
begin
  CodeSite.Send('AS_sqlReportUserAfterScroll');
  sqlComments.Close;
  sqlComments.ParamByName('ReportID').AsInteger := sqlReportUser.FieldByName('ReportID').AsInteger;
  sqlComments.Open;
end;

function TServerMethods1.ServerTime: TDateTime;
begin
  Result := Now;
  CodeSite.Send('ServerTime', Result)
end;

function TServerMethods1.GetCurrentUserID: Integer;
begin
  Result := StrToIntDef(TDSSessionManager.GetThreadSession.GetData('UserID'),-1);
  CodeSite.Send('GetCurrentUserID: ' + IntToStr(Result))
end;

function TServerMethods1.GetCurrentUserRoles: String;
begin
  Result := TDSSessionManager.GetThreadSession.UserRoles.Text;
  CodeSite.Send('GetCurrentUserRoles: ' + Result)
end;

function TServerMethods1.GetUserNames: TDataSet;
begin
  CodeSite.EnterMethod('GetUserNames');
  try
    sqlUser.Open;
    sqlUser.First;
    Result := sqlUser
  except
    on E: Exception do
    begin
      CodeSite.SendException(E);
      Result := nil;
      sqlUser.Close;
      SQLConnection1.Close
    end
  end;
  CodeSite.ExitMethod('GetUserNames')
end;

procedure TServerMethods1.AddUser(const User, Password, Role, Email: String);
var
  SQLQuery: TSQLQuery;
begin
  CodeSite.EnterMethod('AddUser');
  try
    SQLQuery := TSQLQuery.Create(nil);
    SQLQuery.SQLConnection := SQLConnection1;
    SQLQuery.CommandText := 'INSERT INTO [User] (Name, PasswordHASH, Role, Email) VALUES (:Name, :PasswordHASH, :Role, :Email)';
    SQLQuery.ParamByName('Name').AsString := User;
    SQLQuery.ParamByName('PasswordHASH').AsString := HashMD5(Password);
    SQLQuery.ParamByName('Role').AsString := Role;
    SQLQuery.ParamByName('Email').AsString := Email;
    SQLConnection1.Open;
    try
      SQLQuery.ExecSQL;
    finally
      SQLConnection1.Close;
    end;
  except
    on E: Exception do
    begin
      CodeSite.SendException(E);
      SQLConnection1.Close
    end
  end;
  CodeSite.ExitMethod('AddUser')
end;

function TServerMethods1.HashMD5(const Str: String): String;
var
  MD5: TIdHashMessageDigest5;
begin
  MD5 := TIdHashMessageDigest5.Create;
  try
    Result := LowerCase(MD5.HashStringAsHex(Str, TEncoding.UTF8))
  finally
    MD5.Free
  end
end;

function TServerMethods1.ReportNewIssue(Project, Version, Module: String;
  IssueType, Priority: Integer; // Status = 1
  Summary, Report: String;
  AssignedTo: Integer = -1): Boolean;
var
  InsertSQL: TSQLQuery;
begin
  CodeSite.EnterMethod('ReportNewIssue');
  Result := False;
  InsertSQL := TSQLQuery.Create(nil);
  try
    InsertSQL.SQLConnection := SQLConnection1;
    if AssignedTo >= 0 then
      InsertSQL.CommandText :=  'INSERT INTO [Report] ([Project],[Version], ' +
            '  [Module],[IssueType],[Priority],[Status],[ReportDate],[ReporterID],'  +
            '  [AssignedTo],[Summary],[Report]) VALUES (:Project,:Version,:Module,:IssueType,:Priority, '  +
            '  1, @Date, :ReporterID,:AssignedTo,:Summary,:Report) '
    else
      InsertSQL.CommandText :=  'INSERT INTO [Report] ([Project],[Version], ' +
            '  [Module],[IssueType],[Priority],[Status],[ReportDate],[ReporterID],'  +
            '  [Summary],[Report]) VALUES (:Project,:Version,:Module,:IssueType,:Priority, '  +
            '  1, @Date, :ReporterID,:Summary,:Report) ';
    try
      InsertSQL.ParamByName('Project').AsString := Project;
      InsertSQL.ParamByName('Version').AsString := Version;
      InsertSQL.ParamByName('Module').AsString := Module;
      InsertSQL.ParamByName('IssueType').AsInteger := issueType;
      InsertSQL.ParamByName('Priority').AsInteger := Priority;
      InsertSQL.ParamByName('ReporterID').AsInteger :=
        StrToIntDef(TDSSessionManager.GetThreadSession.GetData('UserID'),0);
      if AssignedTo >= 0 then
        InsertSQL.ParamByName('AssignedTo').AsInteger := AssignedTo;
      InsertSQL.ParamByName('Summary').AsString := Summary;
      InsertSQL.ParamByName('Report').AsString := Report;
      Result := InsertSQL.ExecSQL = 1
    except
      on E: Exception do
        CodeSite.SendException(E)
    end
  finally
    InsertSQL.Free;
    SQLConnection1.Close
  end;
  CodeSite.ExitMethod('ReportNewIssue')
end;

function TServerMethods1.GetIssues(MinStatus,MaxStatus: Integer): TDataSet;
begin
  CodeSite.EnterMethod('GetIssues');
  try
    SQLConnection1.Open;
    sqlReports.Close;
    sqlReports.ParamByName('MinStatus').Value := MinStatus;
    sqlReports.ParamByName('MaxStatus').Value := MaxStatus;
    sqlReports.Open;
    Result := sqlReports
  except
    on E: Exception do
    begin
      CodeSite.SendException(E);
      Result := nil;
      sqlReports.Close;
      SQLConnection1.Close
    end
  end;
  CodeSite.ExitMethod('GetIssues');
end;

procedure TServerMethods1.AS_dspReportUserWithCommentsBeforeGetRecords(
  Sender: TObject; var OwnerData: OleVariant);
var
  UserID: Integer;
begin
  CodeSite.EnterMethod('dspReportUserWithCommentsBeforeGetRecords');
  UserID := StrToIntDef(TDSSessionManager.GetThreadSession.GetData('UserID'),0);
  if sqlReportUser.Params.FindParam('ReporterID') = nil then
  begin
    with sqlReportUser.Params.AddParameter do
    begin
      DataType := ftInteger;
      ParamType := ptInput;
      Name := 'ReporterID';
      AsInteger := UserID
    end
  end
  else
    sqlReportUser.Params.FindParam('ReporterID').AsInteger := UserID;

  if sqlReportUser.Params.FindParam('AssignedTo') = nil then
  begin
    with sqlReportUser.Params.AddParameter do
    begin
      DataType := ftInteger;
      ParamType := ptInput;
      Name := 'AssignedTo';
      AsInteger := UserID
    end
  end
  else
    sqlReportUser.Params.FindParam('AssignedTo').AsInteger := UserID;

  CodeSite.ExitMethod('dspReportUserWithCommentsBeforeGetRecords')
end;

end.

