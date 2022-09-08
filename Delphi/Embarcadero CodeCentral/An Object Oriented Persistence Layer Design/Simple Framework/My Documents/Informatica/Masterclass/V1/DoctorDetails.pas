unit DoctorDetails;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BaseDetails, StdCtrls, ExtCtrls, ComCtrls;

type
  TdlgDoctorDetails = class(TdlgBaseDetails)
    lblName: TLabel;
    edtName: TEdit;
    lblNHSNumber: TLabel;
    edtNHSNumber: TEdit;
  private
  protected
    procedure LoadDetails; override;
    function SaveDetails: Boolean; override;
  public
  end;

implementation

uses
  ProblemDomain3;
  
{$R *.DFM}

procedure TdlgDoctorDetails.LoadDetails;
begin
  with TDoctor (EditObject) do begin
    edtName.Text := Name;
    edtNHSNumber.Text := NHSNumber;
  end;
end;

function TdlgDoctorDetails.SaveDetails: Boolean;
begin
  with TDoctor (EditObject) do begin
    Name := Trim (edtName.Text);
    NHSNumber := Trim (edtNHSNumber.Text);
  end;
  Result := (Name <> '');
end;

end.

