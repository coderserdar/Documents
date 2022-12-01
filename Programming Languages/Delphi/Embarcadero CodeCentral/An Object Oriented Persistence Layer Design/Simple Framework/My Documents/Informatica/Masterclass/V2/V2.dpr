program V2;

uses
  Forms,
  MainForm in 'MainForm.pas' {Form1},
  ProblemDomain in 'ProblemDomain.pas',
  BaseDetails in 'BaseDetails.pas' {dlgBaseDetails},
  DataManagementBDE in 'DataManagementBDE.pas',
  DoctorDetails in 'DoctorDetails.pas' {dlgDoctorDetails},
  Framework in 'Framework.pas',
  IDAllocation in 'IDAllocation.pas',
  PatientDetails in 'PatientDetails.pas' {dlgPatientDetails},
  PatientFind in 'PatientFind.pas' {dlgPatientFind},
  AppointmentDetails in 'AppointmentDetails.pas' {dlgAppointmentDetails};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

