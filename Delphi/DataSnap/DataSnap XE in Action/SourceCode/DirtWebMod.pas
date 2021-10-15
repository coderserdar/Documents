unit DirtWebMod;
interface
uses
  SysUtils, Classes, HTTPApp, DSHTTPCommon, DSHTTPWebBroker, DSServer, DSAuth,
  DSCommonServer, DBXMSSQL, DB, SqlExpr, DbxSocketChannelNative,
  DbxCompressionFilter;

type
  TWebModule1 = class(TWebModule)
    DSServer1: TDSServer;
    DSHTTPWebDispatcher1: TDSHTTPWebDispatcher;
    DSAuthenticationManager1: TDSAuthenticationManager;
    DSServerClass1: TDSServerClass;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DSAuthenticationManager1UserAuthenticate(Sender: TObject;
      const Protocol, Context, User, Password: string; var valid: Boolean;
      UserRoles: TStrings);
    procedure WebModule2DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure DSAuthenticationManager1UserAuthorize(Sender: TObject;
      AuthorizeEventObject: TDSAuthorizeEventObject; var valid: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation
uses
  CodeSiteLogging,
  DSService,
  DBPlatform,
  DirtServerMethods, WebReq;

{$R *.dfm}

procedure TWebModule1.WebModule2DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.Content := '<html><heading/><body>DataSnap XE Server</body></html>'
end;

procedure TWebModule1.DSServerClass1GetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := DirtServerMethods.TServerMethods1
end;

procedure TWebModule1.DSAuthenticationManager1UserAuthenticate(
  Sender: TObject; const Protocol, Context, User, Password: string;
  var valid: Boolean; UserRoles: TStrings);
var
  SQLConnection: TSQLConnection;
  SQLQuery: TSQLQuery;
  Roles: String;
begin
  CodeSite.EnterMethod('DSAuthenticationManager1UserAuthenticate User=' +
    User + ' Password=' + Password + ' Protocol=' + Protocol + ' Context=' + Context);
  if IsLibrary then
    valid := LowerCase(Protocol) = 'https'
  else
    valid := True;

  if valid then
  begin // validate User and Hashed password
    SQLConnection := TSQLConnection.Create(nil);
    try
      SQLConnection.DriverName := 'MSSQL';
      SQLConnection.VendorLib := 'sqlncli10.dll'; // SQL Server 2008 client
      SQLConnection.Params.Clear;
      SQLConnection.Params.Add('HostName=www.bobswart.nl');
      SQLConnection.Params.Add('Database=DIRT');
      SQLConnection.Params.Add('User_Name=sa');
      SQLConnection.Params.Add('Password=********');

      SQLQuery := TSQLQuery.Create(nil);
      SQLQuery.SQLConnection := SQLConnection;
      SQLQuery.CommandText := 'SELECT UserID, Role FROM [User] WHERE (Name = :UserName) and (PasswordHASH = :Password)';
      SQLQuery.ParamByName('UserName').AsString := User;
      SQLQuery.ParamByName('Password').AsString := Password;
      try
        CodeSite.SendMsg('UserAuthenticate Before Connect for user ' + User);
        SQLQuery.Open;
        if not SQLQuery.Eof then
        begin
          valid := True;
          CodeSite.Send('UserID = ' + SQLQuery.Fields[0].AsString);
          TDSSessionManager.GetThreadSession.PutData('UserID',SQLQuery.Fields[0].AsString);
          CodeSite.Send('Role = ' + SQLQuery.Fields[1].AsString);
          Roles := SQLQuery.Fields[1].AsString;
          if Roles <> '' then
          begin
            while Pos(',',Roles) > 0 do
            begin
              CodeSite.Send('Role: ' + Copy(Roles,1,Pos(',',Roles)-1));
              UserRoles.Add(Copy(Roles,1,Pos(',',Roles)-1));
              Delete(Roles,1,Pos(',',Roles))
            end;
            if Roles <> '' then
            begin
              CodeSite.Send('Role: ' + Roles);
              UserRoles.Add(Roles)
            end
          end
        end
        else
          valid := False
      finally
        SQLQuery.Close;
        SQLQuery.Free
      end
    finally
      SQLConnection.Connected := False;
      SQLConnection.Free
    end
  end;
  CodeSite.ExitMethod('DSAuthenticationManager1UserAuthenticate ' + BoolToStr(valid))
end;

procedure TWebModule1.DSAuthenticationManager1UserAuthorize(Sender: TObject;
  AuthorizeEventObject: TDSAuthorizeEventObject; var valid: Boolean);
var
  UserRole: String;
begin
  CodeSite.EnterMethod('OnUserAuthorize');

  CodeSite.Send('UserName: ' + AuthorizeEventObject.UserName);
  CodeSite.Send('UserRoles: ' +  AuthorizeEventObject.UserRoles.Text);

  valid := False; // assume NOT OK, unless explicitly allowed  !!
  if Assigned(AuthorizeEventObject.DeniedRoles) then
    CodeSite.Send('DeniedRoles: ' + AuthorizeEventObject.DeniedRoles.Text);
  if Assigned(AuthorizeEventObject.AuthorizedRoles) then
    CodeSite.Send('AuthorizedRoles: ' +  AuthorizeEventObject.AuthorizedRoles.Text)
  else valid := True; // no Authorized Roles?

  if not valid then
    if Assigned(AuthorizeEventObject.AuthorizedRoles) then
      for UserRole in AuthorizeEventObject.UserRoles do
        if AuthorizeEventObject.AuthorizedRoles.IndexOf(UserRole) >= 0 then valid := True;

  if valid then
    if Assigned(AuthorizeEventObject.DeniedRoles) then
      for UserRole in AuthorizeEventObject.UserRoles do
        if AuthorizeEventObject.DeniedRoles.IndexOf(UserRole) >= 0 then valid := False;

  CodeSite.ExitMethod('OnUserAuthorize ' + BoolToStr(valid))
end;

end.

