program DataRestServer;
{$APPTYPE GUI}

{$R *.dres}

uses
  Forms,
  WebReq,
  IdHTTPWebBrokerBridge,
  DataRestServer_MainForm in 'DataRestServer_MainForm.pas' {Form1},
  DataRestServer_DataModule in 'DataRestServer_DataModule.pas' {WebModule2: TWebModule},
  DataRestServer_ServerClass in 'DataRestServer_ServerClass.pas' {ServerData: TDataModule};

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TServerData, ServerData);
  Application.Run;
end.
