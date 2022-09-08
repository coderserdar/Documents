unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  ProblemDomain3, PatientDetails, DoctorDetails;

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var
  P: TPatient;
begin
  P := TPatient.Create;
  try
    TdlgPatientDetails.Edit (P);
  finally
    P.Free;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  D: TDoctor;
begin
  D := TDoctor.Create;
  try
    TdlgDoctorDetails.Edit (D);
  finally
    D.Free;
  end;
end;

end.

