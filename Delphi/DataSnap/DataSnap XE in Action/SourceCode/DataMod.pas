unit DataMod;
interface
uses
  SysUtils, Classes, DBXDataSnap, DBXCommon, DSHTTPLayer, FMTBcd, DB, DBClient,
  DSConnect, Provider, SqlExpr;

type
  TDataModule1 = class(TDataModule)
    SQLConnection1: TSQLConnection;
    SqlServerMethodGetIssues: TSqlServerMethod;
    dspIssues: TDataSetProvider;
    cdsIssues: TClientDataSet;
    DSProviderConnection1: TDSProviderConnection;
    cdsReports: TClientDataSet;
    cdsReportssqlComments: TDataSetField;
    cdsComments: TClientDataSet;
    cdsCommentsCommentID: TIntegerField;
    cdsCommentsReportID: TIntegerField;
    cdsCommentsUserID: TIntegerField;
    cdsCommentsCommentDate: TSQLTimeStampField;
    cdsCommentsComment: TWideStringField;
    dsIssues: TDataSource;
    cdsReportsReportID: TIntegerField;
    cdsReportsProject: TWideStringField;
    cdsReportsVersion: TWideStringField;
    cdsReportsModule: TWideStringField;
    cdsReportsIssueType: TIntegerField;
    cdsReportsPriority: TIntegerField;
    cdsReportsStatus: TIntegerField;
    cdsReportsReporterID: TIntegerField;
    cdsReportsAssignedTo: TIntegerField;
    cdsReportsSummary: TWideStringField;
    cdsReportsReport: TWideStringField;
    cdsIssuesReportID: TIntegerField;
    cdsIssuesProject: TWideStringField;
    cdsIssuesVersion: TWideStringField;
    cdsIssuesModule: TWideStringField;
    cdsIssuesIssueType: TIntegerField;
    cdsIssuesPriority: TIntegerField;
    cdsIssuesStatus: TIntegerField;
    cdsIssuesReporter: TWideStringField;
    cdsIssuesAssigned: TWideStringField;
    cdsIssuesSummary: TWideStringField;
    cdsIssuesReport: TWideStringField;
    cdsIssuesReportDate: TSQLTimeStampField;
    cdsReportsReportDate: TSQLTimeStampField;
    dsReports: TDataSource;
    SqlServerMethodGetUserNames: TSqlServerMethod;
    dspUserNames: TDataSetProvider;
    cdsUserNames: TClientDataSet;
    cdsUserNamesUserID: TIntegerField;
    cdsUserNamesName: TWideStringField;
    cdsReportsReporterName: TStringField;
    cdsReportsAssignedName: TStringField;
    cdsCommentsUserName: TStringField;
    procedure StatusGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure IssueTypeGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure PriorityGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure cdsCommentsBeforeOpen(DataSet: TDataSet);
    procedure cdsReportsAfterInsert(DataSet: TDataSet);
    procedure cdsReportsOrCommentsAfterPostOrDelete(DataSet: TDataSet);
    procedure cdsReportsReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure cdsCommentsAfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation
uses
  CodeSiteLogging,
  Dialogs,
  DBXCompressionFilter;

{$R *.dfm}

procedure TDataModule1.cdsCommentsAfterInsert(DataSet: TDataSet);
begin
  cdsCommentsCommentID.AsInteger := -1;
end;

procedure TDataModule1.cdsCommentsBeforeOpen(DataSet: TDataSet);
begin
  cdsUserNames.Open
end;

procedure TDataModule1.cdsReportsAfterInsert(DataSet: TDataSet);
begin
  cdsReportsReportID.AsInteger := -1;
end;

procedure TDataModule1.cdsReportsOrCommentsAfterPostOrDelete(DataSet: TDataSet);
begin
  cdsReports.ApplyUpdates(-1);
  cdsReports.Refresh
end;

procedure TDataModule1.cdsReportsReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
  ShowMessage(E.Message)
end;

procedure TDataModule1.IssueTypeGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  case Sender.AsInteger of
     1..4: Text := 'Minor ' + Sender.AsString;
     5..8: Text := 'Major ' + Sender.AsString;
    9..10: Text := 'Critical ' + Sender.AsString;
  end;
end;

procedure TDataModule1.PriorityGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  case Sender.AsInteger of
     1..3: Text := 'Low ' + Sender.AsString;
     4..7: Text := 'Medium ' + Sender.AsString;
    8..10: Text := 'High ' + Sender.AsString;
  end;
end;

procedure TDataModule1.StatusGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  case Sender.AsInteger of
    1: Text := 'Reported';
    2: Text := 'Assigned';
    3: Text := 'Opened';
    6: Text := 'Solved';
    7: Text := 'Tested';
    8: Text := 'Deployed';
   10: Text := 'Closed';
  end;
end;

end.
