program MarineAdventuresOP;

uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  TabbedTemplate in 'TabbedTemplate.pas' {TabbedForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TTabbedForm, TabbedForm);
  Application.Run;
end.
