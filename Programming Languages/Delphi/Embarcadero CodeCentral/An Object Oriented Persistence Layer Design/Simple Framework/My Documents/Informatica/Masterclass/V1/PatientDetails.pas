unit PatientDetails;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BaseDetails, StdCtrls, ExtCtrls, ComCtrls, ProblemDomain3;

type
  TdlgPatientDetails = class(TdlgBaseDetails)
    lblName: TLabel;
    edtName: TEdit;
    mmoAddress: TMemo;
    lblAddress: TLabel;
    edtPostcode: TEdit;
    edtDateOfBirth: TEdit;
    lblPostcode: TLabel;
    lblDateOfBirth: TLabel;
  private
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
  end;
end;

function TdlgPatientDetails.SaveDetails: Boolean;
begin
  Result := False;
  if Trim (edtName.Text) = '' then begin
    MessageDlg ('You must enter a patient name.', mtWarning, [mbOK], 0);
  end else begin
    with TPatient (EditObject) do begin
      Name := edtName.Text;
      Address.Assign (mmoAddress.Lines);
      Postcode := edtPostcode.Text;
      try
        DateOfBirth := StrToDate (edtDateOfBirth.Text);
      except
      end;
    end;
    Result := True;
  end;
end;

end.

