unit NewIssueForm;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBCGrids, StdCtrls, DBCtrls, DB, Mask, Buttons, Grids, DBGrids, Spin;

type
  TFormNewIssue = class(TForm)
    Label1: TLabel;
    DBEditProject: TDBEdit;
    dsReports: TDataSource;
    Label2: TLabel;
    DBEditVersion: TDBEdit;
    Label3: TLabel;
    DBEditModule: TDBEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    DBEditStatus: TDBEdit;
    Label7: TLabel;
    DBEditReportDate: TDBEdit;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    DBEditSummary: TDBEdit;
    Label11: TLabel;
    DBMemoReport: TDBMemo;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    seIssueType: TSpinEdit;
    sePriority: TSpinEdit;
    cbAssignedTo: TComboBox;
    edReporter: TEdit;
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormNewIssue: TFormNewIssue;

implementation
uses
  DataMod, ClientForm;

{$R *.dfm}

type
  TUserID = class
    UserID: Integer;
    constructor Create(const NewUserID: Integer);
  end;

constructor TUserID.Create(const NewUserID: Integer);
begin
  inherited Create;
  UserID := NewUserID
end;

procedure TFormNewIssue.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: Integer;
begin
  for i:=0 to cbAssignedTo.Items.Count-1 do
    if Assigned(cbAssignedTo.Items.Objects[i]) then
      cbAssignedTo.Items.Objects[i].Free
end;

procedure TFormNewIssue.FormCreate(Sender: TObject);
var
  UserID: Integer;
begin
  UserID := (Owner as TFormClient).UserID;

  dsReports.DataSet.Open;
  dsReports.DataSet.Insert;
  dsReports.DataSet.FieldByName('ReporterID').AsInteger := UserID;
  dsReports.DataSet.FieldByName('Status').AsInteger := 1;
  dsReports.DataSet.FieldByName('ReportDate').AsDateTime := Now;

  DataModule1.cdsUserNames.Open; // in case it was closed
  DataModule1.cdsUserNames.First;
  cbAssignedTo.Items.Clear;
  cbAssignedTo.Items.Add('Nobody');
  while not DataModule1.cdsUserNames.Eof do
  begin
    if DataModule1.cdsUserNamesUserID.AsInteger = UserID then
      edReporter.Text := DataModule1.cdsUserNamesName.AsString; // current user name
    cbAssignedTo.Items.AddObject(DataModule1.cdsUserNamesName.AsString,
      TUserID.Create(DataModule1.cdsUserNamesUserID.AsInteger));
    DataModule1.cdsUserNames.Next;
  end;
end;

procedure TFormNewIssue.btnOKClick(Sender: TObject);
begin
  dsReports.DataSet.FieldByName('Priority').AsInteger := sePriority.Value;
  dsReports.DataSet.FieldByName('IssueType').AsInteger := seIssueType.Value;
  if cbAssignedTo.ItemIndex > 0 then
    dsReports.DataSet.FieldByName('AssignedTo').AsInteger :=
      (cbAssignedTo.Items.Objects[cbAssignedTo.ItemIndex] as TUserID).UserID;
  dsReports.DataSet.Post;
  Close
end;

procedure TFormNewIssue.btnCancelClick(Sender: TObject);
begin
  dsReports.DataSet.Cancel;
  Close
end;

end.
