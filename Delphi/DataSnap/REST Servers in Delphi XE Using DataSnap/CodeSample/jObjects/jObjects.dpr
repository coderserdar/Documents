program jObjects;
{$APPTYPE GUI}

{$R *.dres}

uses
  Forms,
  WebReq,
  IdHTTPWebBrokerBridge,
  MainForm in 'MainForm.pas' {Form1},
  ServerObject in 'ServerObject.pas' {ServerMethods1: TDataModule},
  WebModule in 'WebModule.pas' {WebModule2: TWebModule},
  CompanyData in 'CompanyData.pas',
  RestPlusUtils in 'RestPlusUtils.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
