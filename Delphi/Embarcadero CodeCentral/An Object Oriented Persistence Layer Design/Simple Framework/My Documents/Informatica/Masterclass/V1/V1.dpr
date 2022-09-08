program V1;

uses
  Forms,
  MainForm in 'MainForm.pas' {Form1},
  DataManagementBDE in 'DataManagementBDE.pas',
  IDAllocation in 'IDAllocation.pas',
  Framework in 'Framework.pas',
  ProblemDomain3 in 'ProblemDomain3.pas',
  BaseDetails in 'BaseDetails.pas' {dlgBaseDetails},
  PatientDetails in 'PatientDetails.pas' {dlgPatientDetails},
  DoctorDetails in 'DoctorDetails.pas' {dlgDoctorDetails};
{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

