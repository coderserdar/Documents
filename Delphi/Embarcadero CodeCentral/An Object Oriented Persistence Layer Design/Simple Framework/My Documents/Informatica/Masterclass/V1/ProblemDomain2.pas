unit ProblemDomain2;

interface

uses
  Classes, Framework;

type
  TPatient = class (TPDObject)
  private
    FPostcode: String;
    FName: String;
    FDateOfBirth: TDateTime;
    FAddress: TStringList;
    function GetAge: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    property Name: String read FName write FName;
    property Address: TStringList read FAddress;
    property Postcode: String read FPostcode write FPostcode;
    property DateOfBirth: TDateTime read FDateOfBirth write FDateOfBirth;
    property Age: Integer read GetAge;
  end;

  TDoctor = class (TPDObject)
  private
    FNHSNumber: String;
    FName: String;
  public
    property Name: String read FName write FName;
    property NHSNumber: String read FNHSNumber write FNHSNumber;
  end;

  TAppointmentStatus = (asSeen, asConsulting, asCancelled, asEmergency, asWaiting,
    asDidNotAttend, asLate, asBooked, asAvailable);

  TAppointment = class (TPDObject)
  private
    FIsEmergency: Boolean;
    FIsCancelled: Boolean;
    FDuration: Integer;
    FComment: String;
    FScheduled: TDateTime;
    FArrived: TDateTime;
    FFinished: TDateTime;
    FStarted: TDateTime;
    function GetStatus: TAppointmentStatus;
    function GetStatusDescription: String;
  public
    // Basic properties
    property Scheduled: TDateTime read FScheduled write FScheduled;
    property Duration: Integer read FDuration write FDuration;
    property Arrived: TDateTime read FArrived write FArrived;
    property Started: TDateTime read FStarted write FStarted;
    property Finished: TDateTime read FFinished write FFinished;
    property Comment: String read FComment write FComment;
    property IsCancelled: Boolean read FIsCancelled write FIsCancelled;
    property IsEmergency: Boolean read FIsEmergency write FIsEmergency;
    property Status: TAppointmentStatus read GetStatus;
    property StatusDescription: String read GetStatusDescription;
  end;

implementation

uses
  SysUtils;

// TPatient

constructor TPatient.Create;
begin
  inherited;
  FAddress := TStringList.Create;
end;

destructor TPatient.Destroy;
begin
  FAddress.Free;
  inherited;
end;

function TPatient.GetAge: Integer;
begin
  Result := Trunc ((Date - DateOfBirth)) div 365;
end;

// TAppointment

const
  AppointmentStatuses: array [TAppointmentStatus] of String = (
   'Seen', 'Consulting', 'Cancelled', 'Emergency', 'Waiting', 'DNA', 'Late',
   'Booked', 'Available');

function TAppointment.GetStatusDescription: String;
begin
  Result := AppointmentStatuses[Status];
end;

function TAppointment.GetStatus: TAppointmentStatus;
begin
  if Finished <> 0 then begin
    Result := asSeen;
  end else if Started <> 0 then begin
    Result := asConsulting;
  end else if IsCancelled then begin
    Result := asCancelled;
  end else if IsEmergency then begin
    Result := asEmergency;
  end else if Arrived <> 0 then begin
    Result := asWaiting;
  end else begin
    Result := asAvailable;
  end;
end;

end.

