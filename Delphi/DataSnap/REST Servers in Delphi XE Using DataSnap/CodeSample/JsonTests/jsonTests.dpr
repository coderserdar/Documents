program jsonTests;

uses
  Forms,
  JsonTests_MainForm in 'JsonTests_MainForm.pas' {FormJson};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormJson, FormJson);
  Application.Run;
end.
