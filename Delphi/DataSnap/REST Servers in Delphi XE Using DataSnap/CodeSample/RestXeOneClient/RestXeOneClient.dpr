program RestXeOneClient;

uses
  Forms,
  RestXeOneClient_MainForm in 'RestXeOneClient_MainForm.pas' {RestClientForm},
  ClientClassesUnit1 in 'ClientClassesUnit1.pas',
  ClientModuleUnit1 in 'ClientModuleUnit1.pas' {ClientModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TRestClientForm, RestClientForm);
  Application.CreateForm(TClientModule1, ClientModule1);
  Application.Run;
end.
