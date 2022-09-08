program AppointMate;

uses
  Forms,
  MainForm in 'MainForm.pas' {frmMain},
  Framework in 'Framework.pas',
  AboutForm in 'AboutForm.pas' {frmAbout},
  ProblemDomain in 'ProblemDomain.pas',
  DataManagementBDE in 'DataManagementBDE.pas',
  BaseDetails in 'BaseDetails.pas' {dlgBaseDetails},
  DoctorDetails in 'DoctorDetails.pas' {dlgDoctorDetails},
  IDAllocation in 'IDAllocation.pas',
  PatientDetails in 'PatientDetails.pas' {dlgPatientDetails},
  NewSlotDetails in 'NewSlotDetails.pas' {dlgNewSlots},
  AppointmentDetails in 'AppointmentDetails.pas' {dlgAppointmentDetails},
  PatientFind in 'PatientFind.pas' {dlgPatientFind};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.Run;
end.

