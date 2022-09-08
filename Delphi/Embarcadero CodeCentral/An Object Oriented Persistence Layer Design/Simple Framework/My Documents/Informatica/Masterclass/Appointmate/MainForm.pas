unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, ToolWin, Menus, Buttons, ProblemDomain;

type
  TfrmMain = class(TForm)
    stbMain: TStatusBar;
    mnuMain: TMainMenu;
    mniFile: TMenuItem;
    mniExit: TMenuItem;
    mniTools: TMenuItem;
    mniHelp: TMenuItem;
    mniAbout: TMenuItem;
    cbarMain: TCoolBar;
    tbarMain: TToolBar;
    pnlDetails: TPanel;
    lblDoctor: TLabel;
    cboDoctor: TComboBox;
    lblDate: TLabel;
    lvwAppts: TListView;
    sepFile: TMenuItem;
    mniNewSlots: TMenuItem;
    bvlTools: TMenuItem;
    mniBook: TMenuItem;
    mniCancel: TMenuItem;
    mniArrived: TMenuItem;
    mniStartConsultation: TMenuItem;
    mniEndConsultation: TMenuItem;
    mniDetails: TMenuItem;
    sbtnBook: TSpeedButton;
    sbtnDetails: TSpeedButton;
    sbtnEndConsultation: TSpeedButton;
    sbtnStartConsultation: TSpeedButton;
    sbtnArrived: TSpeedButton;
    sbtnCancel: TSpeedButton;
    mniNewDoctor: TMenuItem;
    mniViewDoctor: TMenuItem;
    mniNewPatient: TMenuItem;
    mniNew: TMenuItem;
    edtDate: TDateTimePicker;
    mniPatientDetails: TMenuItem;
    sbtnPatientDetails: TSpeedButton;
    procedure mniAboutClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mniViewDoctorClick(Sender: TObject);
    procedure lvwApptsChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure cboDoctorChange(Sender: TObject);
    procedure mniNewDoctorClick(Sender: TObject);
    procedure mniNewPatientClick(Sender: TObject);
    procedure mniNewSlotsClick(Sender: TObject);
    procedure edtDateChange(Sender: TObject);
    procedure sbtnCancelClick(Sender: TObject);
    procedure sbtnArrivedClick(Sender: TObject);
    procedure sbtnStartConsultationClick(Sender: TObject);
    procedure sbtnEndConsultationClick(Sender: TObject);
    procedure sbtnPatientDetailsClick(Sender: TObject);
    procedure sbtnDetailsClick(Sender: TObject);
    procedure lvwApptsDblClick(Sender: TObject);
    procedure sbtnBookClick(Sender: TObject);
    procedure lvwApptsKeyPress(Sender: TObject; var Key: Char);
  private
    procedure Clear;
    procedure LoadAppointments;
    function CurrentDoctor: TDoctor;
    function CurrentAppointment: TAppointment;
    procedure UpdateItem (ThisItem: TListItem);
    procedure RefreshButtons;
  public
    destructor Destroy; override;
  end;

var
  frmMain: TfrmMain;

implementation

uses
  AboutForm, DoctorDetails, PatientDetails, AppointmentDetails, NewSlotDetails,
  PatientFind, Streams;

{$R *.DFM}

destructor TfrmMain.Destroy;
begin
  Clear;
  inherited;
end;

procedure TfrmMain.Clear;
var
  Index: Integer;
begin
  for Index := 0 to lvwAppts.Items.Count - 1 do begin
    TAppointment (lvwAppts.Items[Index].Data).Free;
  end;
  lvwAppts.Items.Clear;
end;

function TfrmMain.CurrentDoctor: TDoctor;
begin
  if cboDoctor.ItemIndex = -1 then begin
    Result := nil;
  end else begin
    Result := TDoctor (cboDoctor.Items.Objects[cboDoctor.ItemIndex]);
  end;
end;

function TfrmMain.CurrentAppointment: TAppointment;
begin
  if lvwAppts.Selected = nil then begin
    Result := nil;
  end else begin
    Result := TAppointment (lvwAppts.Selected.Data);
  end;
end;

procedure TfrmMain.UpdateItem (ThisItem: TListItem);
begin
  with ThisItem, TAppointment (ThisItem.Data) do begin
    Caption := FormatDateTime ('hh:mm', Scheduled);
    while SubItems.Count > 0 do begin
      SubItems.Delete (0);
    end;
    SubItems.Add (IntToStr (Duration));
    SubItems.Add (Status);
    if Patient.IsAssigned then begin
      SubItems.Add (Patient.Name + ' (Age ' + IntToStr (Patient.Age) + ')');
      SubItems.Add (Comment);
    end else begin
      SubItems.Add ('');
      SubItems.Add (Comment);
    end;
  end;
end;

procedure TfrmMain.RefreshButtons;
begin
  with CurrentAppointment do begin
    mniBook.Enabled := (lvwAppts.Selected <> nil) and (not IsCancelled) and (not Patient.IsAssigned);
    mniCancel.Enabled := (lvwAppts.Selected <> nil) and (not IsCancelled);
    mniArrived.Enabled := (lvwAppts.Selected <> nil) and (not IsCancelled) and (Patient.IsAssigned) and (Arrived = 0);
    mniStartConsultation.Enabled := (lvwAppts.Selected <> nil) and (not IsCancelled) and (Arrived <> 0) and (Started = 0);
    mniEndConsultation.Enabled := (lvwAppts.Selected <> nil) and (not IsCancelled) and (Started <> 0) and (Finished = 0);
    mniDetails.Enabled := (lvwAppts.Selected <> nil);
    mniPatientDetails.Enabled := (lvwAppts.Selected <> nil) and (Patient.IsAssigned);
    sbtnBook.Enabled := mniBook.Enabled;
    sbtnCancel.Enabled := mniCancel.Enabled;
    sbtnArrived.Enabled := mniArrived.Enabled;
    sbtnStartConsultation.Enabled := mniStartConsultation.Enabled;
    sbtnEndConsultation.Enabled := mniEndConsultation.Enabled;
    sbtnDetails.Enabled := mniDetails.Enabled;
    sbtnPatientDetails.Enabled := mniPatientDetails.Enabled;
  end;
end;

procedure TfrmMain.LoadAppointments;
var
  Appts: TAppointmentList;
  ThisAppt: TAppointment;
  ThisItem: TListItem;
begin
  // Clear out existing list
  lvwAppts.Items.BeginUpdate;
  try
    Clear;
    // Load new list
    Appts := TAppointmentList.CreateByDoctor (CurrentDoctor, edtDate.Date);
    try
      Appts.First;
      while not Appts.IsLast do begin
        ThisItem := lvwAppts.Items.Add;
        // Make a copy of the appointment and store it behind the list view item
        ThisAppt := TAppointment.Create;
        ThisAppt.Assign (Appts.Appointment);
        ThisItem.Data := ThisAppt;
        UpdateItem (ThisItem);
        Appts.Next;
      end;
    finally
      Appts.Free;
    end;
  finally
    lvwAppts.Items.EndUpdate;
  end;
end;

// Events

procedure TfrmMain.mniAboutClick(Sender: TObject);
begin
  frmAbout.ShowModal;
end;

procedure TfrmMain.FormShow(Sender: TObject);
var
  ThisCtrl: Integer;
  DoctorList: TDoctorList;
  ThisDoctor: TDoctor;
  NewMenuItem: TMenuItem;
begin
  // Use a neat feature of Borland's Speedbuttons that allows them to understand
  // line feed characters. Shame there's no property editor provided to edit them
  // nicely!
  for ThisCtrl := 0 to ComponentCount - 1 do begin
    if Components[ThisCtrl] is TSpeedButton then begin
      with TSpeedButton (Components[ThisCtrl]) do begin
        Caption := StringReplace (Caption, '|', #10, [rfReplaceAll]);
      end;
    end;
  end;

  // Load the list of all doctors into our combo box
  DoctorList := TDoctorList.CreateAll;
  try
    DoctorList.First;
    while not DoctorList.IsLast do begin
      // Create a copy of the doctor to store behind the list
      ThisDoctor := TDoctor.Create;
      ThisDoctor.Assign (DoctorList.Doctor);
      cboDoctor.Items.AddObject (DoctorList.Doctor.Name, ThisDoctor);
      // Add to File menu
      NewMenuItem := TMenuItem.Create (nil);
      NewMenuItem.Tag := cboDoctor.Items.Count - 1;
      NewMenuItem.Caption := '&' + IntToStr (cboDoctor.Items.Count) + ' ' + ThisDoctor.Name;
      mniFile.Insert (mniFile.Count - 2, NewMenuItem);
      DoctorList.Next;
    end;
  finally
    DoctorList.Free;
  end;

  // Display by default the appointments for the first doctor in the list
  if cboDoctor.Items.Count > 0 then cboDoctor.ItemIndex := 0;
  edtDate.Date := Date;
  cboDoctorChange (nil); 

  // Call this to update menu items state
  lvwApptsChange (nil, nil, ctText);
end;

procedure TfrmMain.mniViewDoctorClick(Sender: TObject);
begin
  if CurrentDoctor = nil then Exit;
  if TdlgDoctorDetails.Edit (CurrentDoctor) = mrOK then begin
    cboDoctor.Items[cboDoctor.ItemIndex] := CurrentDoctor.Name;
  end;
end;

procedure TfrmMain.lvwApptsChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  RefreshButtons;
end;

procedure TfrmMain.cboDoctorChange(Sender: TObject);
begin
  mniViewDoctor.Enabled := (CurrentDoctor <> nil);
  LoadAppointments;
end;

procedure TfrmMain.mniNewDoctorClick(Sender: TObject);
var
  NewDoctor: TDoctor;
begin
  NewDoctor := TDoctor.Create;
  if TdlgDoctorDetails.Edit (NewDoctor) = mrOK then begin
    cboDoctor.ItemIndex := cboDoctor.Items.AddObject (NewDoctor.Name, NewDoctor);
  end else begin
    NewDoctor.Free;
  end;
end;

procedure TfrmMain.mniNewPatientClick(Sender: TObject);
var
  NewPatient: TPatient;
begin
  NewPatient := TPatient.Create;
  try
    TdlgPatientDetails.Edit (NewPatient);
  finally
    NewPatient.Free;
  end;
end;

procedure TfrmMain.mniNewSlotsClick(Sender: TObject);
begin
  if TdlgNewSlots.Edit (CurrentDoctor) = mrOK then LoadAppointments;
end;

procedure TfrmMain.edtDateChange(Sender: TObject);
begin
  // We seem to get 2 Change events for the bastard TDateTimePicker if you
  // go into the calendar. Reminds me why I don't use such things!
  LoadAppointments;
end;

procedure TfrmMain.sbtnCancelClick(Sender: TObject);
var
  NewAppointment: TAppointment;
begin
  with CurrentAppointment do begin
    if Patient.IsAssigned then begin
      // Create a new blank appointment at the same time
      NewAppointment := TAppointment.Create;
      try
        NewAppointment.Scheduled := Scheduled;
        NewAppointment.Duration := Duration;
        NewAppointment.Doctor.Assign (Doctor);
        NewAppointment.Save;
      finally
        NewAppointment.Free;
      end;
    end;
    IsCancelled := True;
    Save;
    LoadAppointments;
  end;
  RefreshButtons;
end;

procedure TfrmMain.sbtnArrivedClick(Sender: TObject);
begin
  with CurrentAppointment do begin
    Arrived := Now;
    Save;
  end;
  UpdateItem (lvwAppts.Selected);
  RefreshButtons;
end;

procedure TfrmMain.sbtnStartConsultationClick(Sender: TObject);
begin
  with CurrentAppointment do begin
    Started := Now;
    Save;
  end;
  UpdateItem (lvwAppts.Selected);
  RefreshButtons;
end;

procedure TfrmMain.sbtnEndConsultationClick(Sender: TObject);
begin
  with CurrentAppointment do begin
    Finished := Now;
    Save;
  end;
  UpdateItem (lvwAppts.Selected);
  RefreshButtons;
end;

procedure TfrmMain.sbtnPatientDetailsClick(Sender: TObject);
begin
  if TdlgPatientDetails.Edit (CurrentAppointment.Patient) = mrOK then UpdateItem (lvwAppts.Selected);
end;

procedure TfrmMain.sbtnDetailsClick(Sender: TObject);
begin
  if TdlgAppointmentDetails.Edit (CurrentAppointment) = mrOK then UpdateItem (lvwAppts.Selected);
end;

procedure TfrmMain.lvwApptsDblClick(Sender: TObject);
begin
  if CurrentAppointment.Patient.IsAssigned then begin
    sbtnDetailsClick (Sender);
  end else begin
    sbtnBookClick (Sender);
  end;
end;

procedure TfrmMain.sbtnBookClick(Sender: TObject);
var
  Patient: TPatient;
begin
  Patient := TPatient.Create;
  try
    if TdlgPatientFind.Find (Patient) = mrOK then begin
      CurrentAppointment.Patient.Assign (Patient);
      CurrentAppointment.Save;
      UpdateItem (lvwAppts.Selected);
      RefreshButtons;
    end;
  finally
    Patient.Free;
  end;
end;

procedure TfrmMain.lvwApptsKeyPress(Sender: TObject; var Key: Char);
begin
  if (lvwAppts.Selected <> nil) and (Key = #13) then lvwApptsDblClick (Sender);
end;

end.

