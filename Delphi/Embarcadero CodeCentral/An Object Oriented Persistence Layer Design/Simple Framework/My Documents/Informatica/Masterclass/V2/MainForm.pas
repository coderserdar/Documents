unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    ListBox1: TListBox;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  ProblemDomain;

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var
  PL: TPatientList;
begin
  PL := TPatientList.CreateByName ('SMITH');
  try
    ListBox1.Items.Clear;
    PL.First;
    while not PL.IsLast do begin
      ListBox1.Items.Add (PL.Patient.Name + ' GP: ' + PL.Patient.Doctor.Name);
      PL.Next;
    end;
  finally
    PL.Free;
  end;
end;

end.

