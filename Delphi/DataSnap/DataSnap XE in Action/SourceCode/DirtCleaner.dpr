program DirtCleaner;
uses
  Forms,
  MidasLib,
  ClientForm in 'ClientForm.pas' {FormClient},
  DBXClientClasses in 'DBXClientClasses.pas',
  DataMod in 'DataMod.pas' {DataModule1: TDataModule},
  CommentForm in 'CommentForm.pas' {FormComments},
  NewIssueForm in 'NewIssueForm.pas' {FormNewIssue},
  LoginForm in 'LoginForm.pas' {FormLogin},
  IssueForm in 'IssueForm.pas' {FormIssue};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  ReportMemoryLeaksOnShutdown := True;
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TFormClient, FormClient);
  Application.Run;
end.
