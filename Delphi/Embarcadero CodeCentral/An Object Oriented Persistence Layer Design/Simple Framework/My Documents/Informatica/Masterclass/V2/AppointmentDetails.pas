unit AppointmentDetails;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BaseDetails, StdCtrls, ExtCtrls, ComCtrls, ProblemDomain;

type
  TdlgAppointmentDetails = class(TdlgBaseDetails)
    edtScheduled: TEdit;
    lblScheduled: TLabel;
    lblDuration: TLabel;
    edtDuration: TEdit;
    edtArrived: TEdit;
    lblArrived: TLabel;
    lblStarted: TLabel;
    edtStarted: TEdit;
    lblFinished: TLabel;
    edtFinished: TEdit;
    lblComment: TLabel;
    edtComment: TEdit;
    edtPatient: TEdit;
    lblPatient: TLabel;
    edtDoctor: TEdit;
    lblDoctor: TLabel;
    btnViewDoctor: TButton;
    btnSelect: TButton;
    procedure btnSelectClick(Sender: TObject);
  private
    NewPatient: TPatient;
    procedure RefreshControls;
  protected
    procedure LoadDetails; override;
    function SaveDetails: Boolean; override;
  public
    destructor Destroy; override;
  end;

implementation

uses
  PatientFind;
  
{$R *.DFM}

destructor TdlgAppointmentDetails.Destroy;
begin
  NewPatient.Free;
  inherited;
end;

procedure TdlgAppointmentDetails.RefreshControls;
begin
  with TAppointment (EditObject) do begin
    edtArrived.ReadOnly := (not Patient.IsAssigned);
    edtStarted.ReadOnly := not edtArrived.Enabled or (Arrived = 0);
    edtFinished.ReadOnly := not edtStarted.Enabled or (Started = 0);
  end;
end;

procedure TdlgAppointmentDetails.LoadDetails;

  function DisplayDate (DateToDisplay: TDateTime): String;
  begin
    if DateToDisplay = 0 then begin
      Result := '';
    end else begin
      Result := FormatDateTime ('hh:mm', DateToDisplay);
    end;
  end;

begin
  with TAppointment (EditObject) do begin
    edtDoctor.Text := Doctor.Name;
    edtScheduled.Text := FormatDateTime ('dddd d mmmm yyyy hh:mm', Scheduled);
    edtDuration.Text := IntToStr (Duration);
    edtPatient.Text := Patient.Name;
    edtArrived.Text := DisplayDate (Arrived);
    edtStarted.Text := DisplayDate (Started);
    edtFinished.Text := DisplayDate (Finished);
    edtComment.Text := Comment;
    RefreshControls;
  end;
end;

function TdlgAppointmentDetails.SaveDetails: Boolean;

  function ReturnDate (Text: String): TDateTime;
  begin
    if Text = '' then begin
      Result := 0;
    end else begin
      Result := StrToTime (Text);
    end;
  end;

begin
  with TAppointment (EditObject) do begin
    if NewPatient <> nil then Patient.Assign (NewPatient);
    Arrived := ReturnDate (edtArrived.Text);
    Started := ReturnDate (edtStarted.Text);
    Finished := ReturnDate (edtFinished.Text);
    Comment := edtComment.Text;
  end;
  Result := True;
end;


procedure TdlgAppointmentDetails.btnSelectClick(Sender: TObject);
var
  FoundPatient: TPatient;
begin
  inherited;
  FoundPatient := TPatient.Create;
  try
    if TdlgPatientFind.Find (FoundPatient) = mrOK then begin
      NewPatient.Assign (FoundPatient);
      edtPatient.Text := NewPatient.Name;
    end;
  finally
    FoundPatient.Free;
  end;
end;

end.

