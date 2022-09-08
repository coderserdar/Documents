unit PatientFind;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ProblemDomain;

type
  TdlgPatientFind = class(TForm)
    lblName: TLabel;
    edtName: TEdit;
    btnSearch: TButton;
    lvwPatients: TListView;
    btnCancel: TButton;
    btnOK: TButton;
    btnDetails: TButton;
    procedure lvwPatientsChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure edtNameChange(Sender: TObject);
    procedure lvwPatientsDblClick(Sender: TObject);
    procedure btnDetailsClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure edtNameKeyPress(Sender: TObject; var Key: Char);
  private
    procedure Clear;
    procedure UpdateItem (ListItem: TListItem);
  public
    destructor Destroy; override;
    class function Find (Patient: TPatient): TModalResult;
  end;

implementation

uses
  PatientDetails;

{$R *.DFM}

class function TdlgPatientFind.Find (Patient: TPatient): TModalResult;
var
  dlg: TdlgPatientFind;
begin
  dlg := TdlgPatientFind.Create (nil);
  try
    Result := dlg.ShowModal;
    if Result = mrOK then Patient.Assign (TPatient (dlg.lvwPatients.Selected.Data));
  finally
    dlg.Free;
  end;
end;

destructor TdlgPatientFind.Destroy;
begin
  Clear;
  inherited;
end;

procedure TdlgPatientFind.Clear;
var
  Index: Integer;
begin
  for Index := 0 to lvwPatients.Items.Count - 1 do begin
    TPatient (lvwPatients.Items[Index].Data).Free;
  end;
  lvwPatients.Items.Clear;
end;

procedure TdlgPatientFind.UpdateItem (ListItem: TListItem);
begin
  with TPatient (ListItem.Data) do begin
    ListItem.Caption := Name;
    while ListItem.SubItems.Count > 0 do ListItem.SubItems.Delete (0);
    if Address.Count > 0 then ListItem.SubItems.Add (Address[0]);
  end;
end;

// Events

procedure TdlgPatientFind.lvwPatientsChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  btnDetails.Enabled := (lvwPatients.Selected <> nil);
  btnOK.Enabled := (lvwPatients.Selected <> nil);
end;

procedure TdlgPatientFind.edtNameChange(Sender: TObject);
begin
  btnSearch.Enabled := (Trim (edtName.Text) <> '');
end;

procedure TdlgPatientFind.lvwPatientsDblClick(Sender: TObject);
begin
  btnOKClick (Sender);
end;

procedure TdlgPatientFind.btnDetailsClick(Sender: TObject);
begin
  if TdlgPatientDetails.Edit (TPatient (lvwPatients.Selected.Data)) = mrOK then UpdateItem (lvwPatients.Selected);
end;

procedure TdlgPatientFind.btnSearchClick(Sender: TObject);
var
  PatientList: TPatientList;
  NewItem: TListItem;
  NewPatient: TPatient;
begin
  Screen.Cursor := crHourGlass;
  try
    Clear;
    PatientList := TPatientList.CreateByName (edtName.Text);
    try
      PatientList.First;
      while not PatientList.IsLast do begin
        NewItem := lvwPatients.Items.Add;
        NewPatient := TPatient.Create;
        NewPatient.Assign (PatientList.Patient);
        NewItem.Data := NewPatient;
        UpdateItem (NewItem);
        PatientList.Next;
      end;
    finally
      PatientList.Free;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TdlgPatientFind.btnOKClick(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TdlgPatientFind.edtNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then begin
    btnSearchClick (Sender);
    if lvwPatients.Items.Count > 0 then begin
      lvwPatients.Selected := lvwPatients.Items[0];
      lvwPatients.Selected.Focused := True;
      lvwPatients.SetFocus;
      // Stop annoying beep
      Key := #0;
    end;
  end;
end;

end.

