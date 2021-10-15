unit IssueForm;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBCGrids, StdCtrls, DBCtrls, DB, Mask, Buttons, Grids, DBGrids;

type
  TFormIssue = class(TForm)
    Label1: TLabel;
    DBEditProject: TDBEdit;
    dsReports: TDataSource;
    Label2: TLabel;
    DBEditVersion: TDBEdit;
    Label3: TLabel;
    DBEditModule: TDBEdit;
    Label4: TLabel;
    DBEditIssueType: TDBEdit;
    Label5: TLabel;
    DBEditPriority: TDBEdit;
    Label6: TLabel;
    DBEditStatus: TDBEdit;
    Label7: TLabel;
    DBEditReportDate: TDBEdit;
    Label8: TLabel;
    DBEditReporterName: TDBEdit;
    Label9: TLabel;
    DBEditAssignedName: TDBEdit;
    Label10: TLabel;
    DBEditSummary: TDBEdit;
    Label11: TLabel;
    DBMemoReport: TDBMemo;
    dsComments: TDataSource;
    DBGrid1: TDBGrid;
    DBMemoComment: TDBMemo;
    BitBtn1: TBitBtn;
    btnNewComment: TBitBtn;
    procedure btnNewCommentClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormIssue: TFormIssue;

implementation
uses
  DataMod,
  CommentForm;

{$R *.dfm}

procedure TFormIssue.BitBtn1Click(Sender: TObject);
begin
  Close
end;

procedure TFormIssue.btnNewCommentClick(Sender: TObject);
begin
  with TFormComments.Create(Self) do
  try
    ShowModal;
  finally
    Free
  end
end;

end.
