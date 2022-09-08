unit NewSlotDetails;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BaseDetails, StdCtrls, ComCtrls, ExtCtrls;

type
  TdlgNewSlots = class(TdlgBaseDetails)
    lblDate: TLabel;
    edtDate: TDateTimePicker;
    lblDuration: TLabel;
    edtDuration: TEdit;
    lblStartTime: TLabel;
    edtStartTime: TEdit;
    lblNumber: TLabel;
    edtNumber: TEdit;
    lblDoctor: TLabel;
    edtDoctor: TEdit;
    procedure edtDurationKeyPress(Sender: TObject; var Key: Char);
    procedure edtStartTimeKeyPress(Sender: TObject; var Key: Char);
  private
  protected
    procedure LoadDetails; override;
    function SaveDetails: Boolean; override;
  public
  end;

implementation

uses
  ProblemDomain;

{$R *.DFM}

procedure TdlgNewSlots.LoadDetails;
begin
  edtDoctor.Text := TDoctor (EditObject).Name;
  edtDate.Date := Date;
  edtStartTime.Text := '10:00';
  edtNumber.Text := '12';
  edtDuration.Text := '10';
end;

function TdlgNewSlots.SaveDetails: Boolean;
const
  OneDelphiMinute = 1 / (24 * 60);
var
  StartTime: TDateTime;
  NewSlot: TAppointment;
  NumberOfSlots: Integer;
  SlotDuration: Integer;
begin
  Result := False;
  SlotDuration := StrToIntDef (edtDuration.Text, 0);
  NumberOfSlots := StrToIntDef (edtNumber.Text, 0);
  if SlotDuration <= 0 then begin
    MessageDlg ('You must enter the duration between 1 and 99.', mtWarning, [mbOK], 0);
  end else if NumberOfSlots <= 0 then begin
    MessageDlg ('You must enter the number of slots between 1 and 99.', mtWarning, [mbOK], 0);
  end else begin
    try
      StartTime := Trunc (edtDate.Date) + StrToTime (edtStartTime.Text);
      // Create the new slots
      while NumberOfSlots > 0 do begin
        NewSlot := TAppointment.Create;
        try
          NewSlot.Doctor.Assign (TDoctor (EditObject));
          NewSlot.Scheduled := StartTime;
          NewSlot.Duration := SlotDuration;
          StartTime := StartTime + OneDelphiMinute * SlotDuration;
          NewSlot.Save;
        finally
          NewSlot.Free;
        end;
        Dec (NumberOfSlots);
      end;
      Result := True;
    except on EConvertError do
      MessageDlg ('You must enter a start time.', mtWarning, [mbOK], 0);
    end;
  end;
end;

// Events

procedure TdlgNewSlots.edtDurationKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (Ord (Key) > 32) and ((Key < '0') or (Key > '9')) then Key := #0;
end;

procedure TdlgNewSlots.edtStartTimeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if (Ord (Key) > 32) and (Key <> ':') and ((Key < '0') or (Key > '9')) then Key := #0;
end;

end.

