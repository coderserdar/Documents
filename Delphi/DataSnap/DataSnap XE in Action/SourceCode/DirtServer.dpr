library DirtServer;
uses
  ActiveX,
  ComObj,
  WebBroker,
  ISAPIApp,
  ISAPIThreadPool,
  DBXCommon,
  DSService,
  MidasLib,
  CodeSiteLogging,
  DirtServerMethods in 'DirtServerMethods.pas' {ServerMethods1: TDSServerModule},
  DirtWebMod in 'DirtWebMod.pas' {WebModule1: TWebModule};

{$R *.res}

exports
  GetExtensionVersion,
  HttpExtensionProc,
  TerminateExtension;

procedure TerminateThreads;
begin
  TDSSessionManager.Instance.Free;
  DBXCommon.TDBXScheduler.Instance.Free;
end;

begin
  CoInitFlags := COINIT_MULTITHREADED;
  Application.Initialize;
  {$IFDEF DEBUG}
  CodeSiteManager.ConnectUsingTcp; // for local services (like IIS)...

  CodeSite.Enabled := CodeSite.Installed;
  CodeSite.Clear;
  CodeSite.Send('DirtServer loaded');
  {$ELSE}
  CodeSite.Enabled := False;
  {$ENDIF}
  Application.WebModuleClass := WebModuleClass;
  TISAPIApplication(Application).OnTerminate := TerminateThreads;
  Application.Run;
end.
