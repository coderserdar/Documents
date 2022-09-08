unit ProblemDomain3;

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
    constructor Create;
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
    constructor Create;
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
  SysUtils, DataManagementBDE, IDAllocation;

type
  TPatientDM = class (TBDEObject)
  protected
    procedure LoadObject (PDObject: TPDObject); override;
    function SaveObject (PDObject: TPDObject): TObjectID; override;
    procedure DeleteObject (PDObject: TPDObject); override;
  end;

  TDoctorDM = class (TBDEObject)
  protected
    procedure LoadObject (PDObject: TPDObject); override;
    function SaveObject (PDObject: TPDObject): TObjectID; override;
    procedure DeleteObject (PDObject: TPDObject); override;
  end;

  TAppointmentDM = class (TBDEObject)
  protected
    procedure LoadObject (PDObject: TPDObject); override;
    function SaveObject (PDObject: TPDObject): TObjectID; override;
    procedure DeleteObject (PDObject: TPDObject); override;
  end;

var
  GlobalPatientDM: TPatientDM;
  GlobalDoctorDM: TDoctorDM;
  GlobalAppointmentDM: TAppointmentDM;

// TPatient

constructor TPatient.Create;
begin
  inherited;
  FAddress := TStringList.Create;
  DMObject := GlobalPatientDM;
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

// TDoctor

constructor TDoctor.Create;
begin
  inherited;
  DMObject := GlobalDoctorDM;
end;

// TAppointment

const
  AppointmentStatuses: array [TAppointmentStatus] of String = (
   'Seen', 'Consulting', 'Cancelled', 'Emergency', 'Waiting', 'DNA', 'Late',
   'Booked', 'Available');

constructor TAppointment.Create;
begin
  inherited;
  DMObject := GlobalAppointmentDM;
end;

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

// TPatientDM

procedure TPatientDM.LoadObject (PDObject: TPDObject);
begin
  Query.SQL.Clear;
  Query.SQL.Add ('SELECT * FROM Patient WHERE ID=' + IDToStr (PDObject.ID));
  Query.Open;
  with Query, TPatient (PDObject) do begin
    FName := FieldByName ('Name').AsString;
    FAddress.CommaText := FieldByName ('Address').AsString;
    FPostcode := FieldByName ('Postcode').AsString;
    FDateOfBirth := FieldByName ('DateOfBirth').AsDateTime;
  end;
  Query.Close;
end;

function TPatientDM.SaveObject (PDObject: TPDObject): TObjectID;
begin
  Query.SQL.Clear;
  with Query, TPatient (PDObject) do begin
    if ID = NoID then begin
      Result := IDAllocator.NextID;
      SQL.Add ('INSERT INTO Patient (ID, Name, Address, Postcode, DateOfBirth) VALUES (');
      SQL.Add (IDToStr (Result) + ',');
      SQL.Add ('''' + Name + ''',');
      SQL.Add ('''' + Address.CommaText + ''',');
      SQL.Add ('''' + Postcode + ''',');
      SQL.Add (FloatToStr (DateOfBirth));
      SQL.Add (')');
    end else begin
      Result := ID;
      SQL.Add ('UPDATE Patient SET');
      SQL.Add ('Name=''' + Name + ''',');
      SQL.Add ('Address=''' + Address.CommaText + ''',');
      SQL.Add ('Postcode=''' + Postcode + ''',');
      SQL.Add ('DateOfBirth=' + FloatToStr (DateOfBirth) + ' ');
      SQL.Add ('WHERE ID=' + IDToStr (ID));
    end;
  end;
  Query.ExecSQL;
end;

procedure TPatientDM.DeleteObject (PDObject: TPDObject);
begin
  Query.SQL.Clear;
  Query.SQL.Add ('DELETE FROM Patient WHERE ID=' + IDToStr (PDObject.ID));
  Query.ExecSQL;
end;

// TDoctorDM

procedure TDoctorDM.LoadObject (PDObject: TPDObject);
begin
  Query.SQL.Clear;
  Query.SQL.Add ('SELECT * FROM Doctor WHERE ID=' + IDToStr (PDObject.ID));
  Query.Open;
  with Query, TDoctor (PDObject) do begin
    FName := FieldByName ('Name').AsString;
    FNHSNumber := FieldByName ('NHSNumber').AsString;
  end;
  Query.Close;
end;

function TDoctorDM.SaveObject (PDObject: TPDObject): TObjectID;
begin
  Query.SQL.Clear;
  with Query, TDoctor (PDObject) do begin
    if ID = NoID then begin
      Result := IDAllocator.NextID;
      SQL.Add ('INSERT INTO Doctor (ID, Name, NHSNumber) VALUES (');
      SQL.Add (IDToStr (Result) + ',');
      SQL.Add ('''' + Name + ''',');
      SQL.Add ('''' + NHSNumber + '''');
      SQL.Add (')');
    end else begin
      Result := ID;
      SQL.Add ('UPDATE Patient SET');
      SQL.Add ('Name=''' + Name + ''',');
      SQL.Add ('NHSNumber=''' + NHSNumber + ''' ');
      SQL.Add ('WHERE ID=' + IDToStr (ID));
    end;
  end;
  Query.ExecSQL;
end;

procedure TDoctorDM.DeleteObject (PDObject: TPDObject);
begin
  Query.SQL.Clear;
  Query.SQL.Add ('DELETE FROM Doctor WHERE ID=' + IDToStr (PDObject.ID));
  Query.ExecSQL;
end;

// TAppointmentDM

procedure TAppointmentDM.LoadObject (PDObject: TPDObject);
begin
end;

function TAppointmentDM.SaveObject (PDObject: TPDObject): TObjectID;
begin
  Result := NoID;
end;

procedure TAppointmentDM.DeleteObject (PDObject: TPDObject);
begin
end;

// Unit methods

initialization
  DataManagementBDE.Initialise ('Appointmate');
  GlobalPatientDM := TPatientDM.Create;
  GlobalDoctorDM := TDoctorDM.Create;
  GlobalAppointmentDM := TAppointmentDM.Create;

finalization
  GlobalPatientDM.Free;
  GlobalDoctorDM.Free;
  GlobalAppointmentDM.Free;

end.

