unit ServerMethodsUnit1;

interface

uses
  SysUtils, Classes, DSServer, DSAuth;
  // if you don't add DSAuth you get the warning below and roles won't work
  // W1025 Unsupported language feature: 'custom attribute'

type
{$METHODINFO ON}
  TServerMethods1 = class(TComponent)
  private
    { Private declarations }
  public
    { Public declarations }
    [TRoleAuth ('admin')]
    function EchoString(Value: string): string;
    [TRoleAuth ('standard')]
    function ReverseString(Value: string): string;
    [TRoleAuth ('standard')]
    function GetUserName: string;
    destructor Destroy; override;
  end;
{$METHODINFO OFF}

implementation


uses StrUtils, DSService;

destructor TServerMethods1.Destroy;
begin
  inherited;
end;

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods1.GetUserName: string;
var
  Session: TDSSession;
begin
  Session := TDSSessionManager.GetThreadSession;
  Result := Session.GetData ('username') + ':' + Session.Username;
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := StrUtils.ReverseString(Value);
end;

end.

