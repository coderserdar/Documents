unit ProblemDomain;

// This is the main unit that exposes all of our problem domain objects. They
// must all be in the same unit as they have circular references. For a small
// application, keeping them in 1 unit is OK, but for larger applications you
// will benefit from splitting them into include files. e.g.
//
// interface
//
// {$I Interface\Patient.pas}
// {$I Interface\Doctor.pas}
// {$I Interface\Appointment.pas}
//
// implementation
//
// {$I Implementation\Patient.pas}
// {$I Implementation\Doctor.pas}
// {$I Implementation\Appointment.pas}
//
// end.

interface

uses
  Classes, Framework, DataManagementBDE;

type
  // Forward references
  TDoctor = class;
  TPatientList = class;
  TAppointmentList = class;

  TPatient = class (TPDObject)
  private
    FName: String;
    FAddress: TStringList;
    FPostcode: String;
    FDateOfBirth: TDateTime;
    // Relationship support
    FDoctor: TPDObject;
    DoctorID: TObjectID;
    FAppointments: TAppointmentList;
    function GetAge: Integer;
    function GetDoctor: TDoctor;
    function GetAppointments: TAppointmentList;
  public
    constructor Create; override;
    destructor Destroy; override;

    // Basic properties
    property Name: String read FName write FName;
    property Address: TStringList read FAddress write FAddress;
    property Postcode: String read FPostcode write FPostcode;
    property DateOfBirth: TDateTime read FDateOfBirth write FDateOfBirth;
    property Age: Integer read GetAge;

    // Related objects
    // Returns the registered doctor for this patient
    property Doctor: TDoctor read GetDoctor;
    // Returns the list of appointments this patient has ever had
    property Appointments: TAppointmentList read GetAppointments;
  end;

  TDoctor = class (TPDObject)
  private
    FName: String;
    FNHSNumber: String;
    // Relationship support
    FPatients: TPatientList;
    function GetPatients: TPatientList;
  public
    constructor Create; override;
    destructor Destroy; override;

    // Basic properties
    property Name: String read FName write FName;
    property NHSNumber: String read FNHSNumber write FNHSNumber;

    // Related objects
    // Returns the list of all patients registered to this doctor
    property Patients: TPatientList read GetPatients;
  end;

  TAppointment = class (TPDObject)
  private
    FScheduled: TDateTime;
    FDuration: Integer;
    FArrived: TDateTime;
    FStarted: TDateTime;
    FFinished: TDateTime;
    FComment: String;
    FIsEmergency: Boolean;
    FIsCancelled: Boolean;
    FPatient: TPDObject;
    PatientID: TObjectID;
    FDoctor: TPDObject;
    DoctorID: TObjectID;
    function GetStatus: String;
    function GetPatient: TPatient;
    function GetDoctor: TDoctor;
  public
    constructor Create; override;
    destructor Destroy; override;

    // Basic properties
    property Scheduled: TDateTime read FScheduled write FScheduled;
    property Duration: Integer read FDuration write FDuration;
    property Arrived: TDateTime read FArrived write FArrived;
    property Started: TDateTime read FStarted write FStarted;
    property Finished: TDateTime read FFinished write FFinished;
    property Comment: String read FComment write FComment;
    property IsCancelled: Boolean read FIsCancelled write FIsCancelled;
    property IsEmergency: Boolean read FIsEmergency write FIsEmergency;
    property Status: String read GetStatus;

    // Related objects
    property Patient: TPatient read GetPatient;
    property Doctor: TDoctor read GetDoctor;
  end;

  //
  // Lists of PDObjects
  //

  TPatientList = class (TPDList)
  private
    function GetPatient: TPatient;
  public
    constructor CreateByName (Name: String);
    constructor CreateByDoctor (Doctor: TDoctor);
    property Patient: TPatient read GetPatient;
  end;

  TDoctorList = class (TPDList)
  private
    function GetDoctor: TDoctor;
  public
    constructor CreateAll;
    property Doctor: TDoctor read GetDoctor;
  end;

  TAppointmentList = class (TPDList)
  private
    function GetAppointment: TAppointment;
  public
    constructor CreateByPatient (Patient: TPatient);
    constructor CreateByDoctor (Doctor: TDoctor; Date: TDateTime);
    property Appointment: TAppointment read GetAppointment;
  end;

  //
  // Data Management objects
  //

  TPatientDM = class (TBDEObject)
  public
    constructor CreateByName (Name: String);
    constructor CreateByDoctor (Doctor: TDoctor);
    procedure PopulateObject (PDObject: TPDObject); override;
    procedure PopulateFields (PDObject: TPDObject); override;
  end;

  TDoctorDM = class (TBDEObject)
  public
    constructor CreateAll;
    procedure PopulateObject (PDObject: TPDObject); override;
    procedure PopulateFields (PDObject: TPDObject); override;
  end;

  TAppointmentDM = class (TBDEObject)
  public
    constructor CreateByPatient (Patient: TPatient);
    constructor CreateByDoctor (Doctor: TDoctor; Date: TDateTime);
    procedure PopulateObject (PDObject: TPDObject); override;
    procedure PopulateFields (PDObject: TPDObject); override;
  end;

implementation

uses
  SysUtils;

// We will create a global DM object to be shared by all PD objects of the
// same class.

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
  FDoctor.Free;
  FAppointments.Free;
  inherited;
end;

function TPatient.GetAge: Integer;
var
  NYear, NMonth, NDay: Word;
  BYear, BMonth, BDay: Word;
begin
  DecodeDate (Date, NYear, NMonth, NDay);
  DecodeDate (DateOfBirth, BYear, BMonth, BDay);
  Result := NYear - BYear;
  if NMonth * 100 + NDay > BMonth * 100 + BDay then Inc (Result);
end;

function TPatient.GetDoctor: TDoctor;
begin
  Result := TDoctor (GetObject (TDoctor, FDoctor, DoctorID));
end;

function TPatient.GetAppointments: TAppointmentList;
begin
  if FAppointments = nil then FAppointments := TAppointmentList.CreateByPatient (Self);
  Result := FAppointments;
end;

// TDoctor

constructor TDoctor.Create;
begin
  inherited;
  DMObject := GlobalDoctorDM;
end;

destructor TDoctor.Destroy;
begin
  FPatients.Free;
  inherited;
end;

function TDoctor.GetPatients: TPatientList;
begin
  if FPatients = nil then FPatients := TPatientList.CreateByDoctor (Self);
  Result := FPatients;
end;

// TAppointment

constructor TAppointment.Create;
begin
  inherited;
  DMObject := GlobalAppointmentDM;
end;

destructor TAppointment.Destroy;
begin
  FPatient.Free;
  FDoctor.Free;
  inherited;
end;

function TAppointment.GetStatus: String;
begin
  if Finished <> 0 then begin
    Result := 'Seen';
  end else if Started <> 0 then begin
    Result := 'Consulting';
  end else if IsCancelled then begin
    Result := 'Cancelled';
  end else if IsEmergency then begin
    Result := 'Emergency';
  end else if Arrived <> 0 then begin
    Result := 'Waiting';
  end else if (Patient.IsAssigned) then begin
    if Scheduled < Date then begin
      Result := 'DNA';
    end else if Scheduled < Now then begin
      Result := 'Late';
    end else begin
      Result := 'Booked';
    end;
  end else begin
    Result := 'Available';
  end;
end;

function TAppointment.GetPatient: TPatient;
begin
  Result := TPatient (GetObject (TPatient, FPatient, PatientID));
end;

function TAppointment.GetDoctor: TDoctor;
begin
  Result := TDoctor (GetObject (TDoctor, FDoctor, DoctorID));
end;

// TPatientDM

constructor TPatientDM.CreateByName (Name: String);
begin
  inherited Create (Format ('SELECT * FROM %s WHERE Name LIKE ''%s%%'' ORDER BY Name', [TableName, Name]));
end;

constructor TPatientDM.CreateByDoctor (Doctor: TDoctor);
begin
  inherited Create (Format ('SELECT * FROM %s WHERE DoctorID=%s', [TableName, IDToStr (Doctor.ID)]));
end;

procedure TPatientDM.PopulateObject (PDObject: TPDObject);
begin
  with TPatient (PDObject) do begin
    Name := StringField['Name'];
    Address.CommaText := StringField['Address'];
    Postcode := StringField['Postcode'];
    DateOfBirth := DateTimeField['DateOfBirth'];
    DoctorID := IntegerField['DoctorID'];
  end;
end;

procedure TPatientDM.PopulateFields (PDObject: TPDObject);
begin
  with TPatient (PDObject) do begin
    StringField['Name'] := Name;
    StringField['Address'] := Address.CommaText;
    StringField['Postcode'] := Postcode;
    DateTimeField['DateOfBirth'] := DateOfBirth;
    // NOTE we will use the ID of any instantiated object in preference to
    // our local field, which may be out of date
    if FDoctor = nil then begin
      IntegerField['DoctorID'] := DoctorID;
    end else begin
      IntegerField['DoctorID'] := Doctor.ID;
    end;
  end;
end;

// TDoctorDM

constructor TDoctorDM.CreateAll;
begin
  inherited Create ('SELECT * FROM ' + TableName);
end;

procedure TDoctorDM.PopulateObject (PDObject: TPDObject);
begin
  with TDoctor (PDObject) do begin
    Name := StringField['Name'];
    NHSNumber := StringField['NHSNumber'];
  end;
end;

procedure TDoctorDM.PopulateFields (PDObject: TPDObject);
begin
  with TDoctor (PDObject) do begin
    StringField['Name'] := Name;
    StringField['NHSNumber'] := NHSNumber;
  end;
end;

// TAppointmentDM

constructor TAppointmentDM.CreateByPatient (Patient: TPatient);
begin
  inherited Create (Format ('SELECT * FROM %s WHERE PatientID=%s ORDER BY Scheduled', [TableName, IDToStr (Patient.ID)]));
end;

constructor TAppointmentDM.CreateByDoctor (Doctor: TDoctor; Date: TDateTime);
begin
  inherited Create (Format ('SELECT * FROM %s WHERE DoctorID=%s AND Scheduled>=%d AND Scheduled<%d ORDER BY Scheduled', [TableName, IDToStr (Doctor.ID), Trunc (Date), Trunc (Date + 1)]));
end;

procedure TAppointmentDM.PopulateObject (PDObject: TPDObject);
begin
  with TAppointment (PDObject) do begin
    Scheduled := DateTimeField['Scheduled'];
    Duration := IntegerField['Duration'];
    Arrived := DateTimeField['Arrived'];
    Started := DateTimeField['Started'];
    Finished := DateTimeField['Finished'];
    Comment := StringField['Comment'];
    IsCancelled := BooleanField['Cancelled'];
    IsEmergency := BooleanField['Emergency'];
    DoctorID := IntegerField['DoctorID'];
    PatientID := IntegerField['PatientID'];
  end;
end;

procedure TAppointmentDM.PopulateFields (PDObject: TPDObject);
begin
  with TAppointment (PDObject) do begin
    DateTimeField['Scheduled'] := Scheduled;
    IntegerField['Duration'] := Duration;
    DateTimeField['Arrived'] := Arrived;
    DateTimeField['Started'] := Started;
    DateTimeField['Finished'] := Finished;
    StringField['Comment'] := Comment;
    BooleanField['Cancelled'] := IsCancelled;
    BooleanField['Emergency'] := IsEmergency;
    if FDoctor = nil then begin
      IntegerField['DoctorID'] := DoctorID;
    end else begin
      IntegerField['DoctorID'] := Doctor.ID;
    end;
    if FPatient = nil then begin
      IntegerField['PatientID'] := PatientID;
    end else begin
      IntegerField['PatientID'] := Patient.ID;
    end;
  end;
end;

// TPatientList

constructor TPatientList.CreateByName (Name: String);
begin
  inherited Create (TPatient, TPatientDM.CreateByName (Name));
end;

constructor TPatientList.CreateByDoctor (Doctor: TDoctor);
begin
  inherited Create (TPatient, TPatientDM.CreateByDoctor (Doctor));
end;

function TPatientList.GetPatient: TPatient;
begin
  Result := TPatient (CurrentObject);
end;

// TDoctorList

constructor TDoctorList.CreateAll;
begin
  inherited Create (TDoctor, TDoctorDM.CreateAll);
end;

function TDoctorList.GetDoctor: TDoctor;
begin
  Result := TDoctor (CurrentObject);
end;

// TAppointmentList

constructor TAppointmentList.CreateByPatient (Patient: TPatient);
begin
  inherited Create (TAppointment, TAppointmentDM.CreateByPatient (Patient));
end;

constructor TAppointmentList.CreateByDoctor (Doctor: TDoctor; Date: TDateTime);
begin
  inherited Create (TAppointment, TAppointmentDM.CreateByDoctor (Doctor, Date));
end;

function TAppointmentList.GetAppointment: TAppointment;
begin
  Result := TAppointment (CurrentObject);
end;

// Unit methods

initialization
  DataManagementBDE.Initialise ('Appointmate');
  GlobalPatientDM := TPatientDM.Create;
  GlobalDoctorDM := TDoctorDM.Create;
  GlobalAppointmentDM := TAppointmentDM.Create;
  GlobalPatientDM.Initialise;
  GlobalDoctorDM.Initialise;
  GlobalAppointmentDM.Initialise;

finalization
  GlobalPatientDM.Free;
  GlobalDoctorDM.Free;
  GlobalAppointmentDM.Free;

end.

