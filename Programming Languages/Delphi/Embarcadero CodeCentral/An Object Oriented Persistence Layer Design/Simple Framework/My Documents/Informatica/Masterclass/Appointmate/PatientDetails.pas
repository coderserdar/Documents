unit PatientDetails;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BaseDetails, StdCtrls, ExtCtrls, ComCtrls, ProblemDomain;

type
  TdlgPatientDetails = class(TdlgBaseDetails)
    lblName: TLabel;
    edtName: TEdit;
    tabAppointments: TTabSheet;
    mmoAddress: TMemo;
    lblAddress: TLabel;
    edtPostcode: TEdit;
    edtDateOfBirth: TEdit;
    lblPostcode: TLabel;
    lblDateOfBirth: TLabel;
    cboDoctors: TComboBox;
    lblDoctor: TLabel;
    lvwAppointments: TListView;
    lblAppointments: TLabel;
    imgAppointments: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    DoctorList: TDoctorList;
  protected
    procedure LoadDetails; override;
    function SaveDetails: Boolean; override;
  end;

implementation

{$R *.DFM}

procedure TdlgPatientDetails.LoadDetails;
begin
  with TPatient (EditObject) do begin
    edtName.Text := Name;
    mmoAddress.Lines.Assign (Address);
    edtPostcode.Text := Postcode;
    if DateOfBirth = 0 then begin
      edtDateOfBirth.Clear;
    end else begin
      edtDateOfBirth.Text := DateToStr (DateOfBirth);
    end;
    // Populate doctor combo from doctor list
    DoctorList.First;
    while not DoctorList.IsLast do begin
      cboDoctors.Items.Add (DoctorList.Doctor.Name);
      if Doctor.IsSameObject (DoctorList.Doctor) then cboDoctors.ItemIndex := cboDoctors.Items.Count - 1;
      DoctorList.Next;
    end;
    // Populate appointments list for patient
    if IsAssigned then begin
      Appointments.First;
      while not Appointments.IsLast do begin
        with lvwAppointments.Items.Add do begin
          Caption := FormatDateTime ('dd/mm/yyyy hh:mm', Appointments.Appointment.Scheduled);
          SubItems.Add (Appointments.Appointment.Status);
          SubItems.Add (Appointments.Appointment.Comment);
        end;
        Appointments.Next;
      end;
    end;
  end;
end;

function TdlgPatientDetails.SaveDetails: Boolean;
var
  Index: Integer;
begin
  Result := False;
  if Trim (edtName.Text) = '' then begin
    MessageDlg ('You must enter a patient name.', mtWarning, [mbOK], 0);
  end else if cboDoctors.ItemIndex = -1 then begin
    MessageDlg ('You must defined a doctor for this patient.', mtWarning, [mbOK], 0);
  end else begin
    with TPatient (EditObject) do begin
      Name := edtName.Text;
      Address.Assign (mmoAddress.Lines);
      Postcode := edtPostcode.Text;
      try
        DateOfBirth := StrToDate (edtDateOfBirth.Text);
      except
      end;
      DoctorList.First;
      Index := 0;
      while Index < cboDoctors.ItemIndex do begin
        DoctorList.Next;
        Inc (Index);
      end;
      Doctor.Assign (DoctorList.Doctor);
    end;
    Result := True;
  end;
end;

procedure TdlgPatientDetails.FormCreate(Sender: TObject);
begin
  inherited;
  DoctorList := TDoctorList.CreateAll;
end;

procedure TdlgPatientDetails.FormDestroy(Sender: TObject);
begin
  inherited;
  DoctorList.Free;
end;

end.

