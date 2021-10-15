unit ClientForm;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBXDataSnap, DBXCommon, DSHTTPLayer, DB, SqlExpr, FMTBcd, Provider,
  DBClient, DSConnect, StdCtrls, Menus, Grids, DBGrids, ComCtrls, ToolWin,
  ExtCtrls, Buttons;

type
  TFormClient = class(TForm)
    StatusBar1: TStatusBar;
    DBGridReports: TDBGrid;
    MainMenu1: TMainMenu;
    Issues1: TMenuItem;
    ReportnewIssue1: TMenuItem;
    ViewMyIssues1: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    Client1: TMenuItem;
    Login1: TMenuItem;
    Exit1: TMenuItem;
    ServerTime1: TMenuItem;
    Panel1: TPanel;
    Label1: TLabel;
    cbMinStatus: TComboBox;
    Label2: TLabel;
    cbMaxStatus: TComboBox;
    ViewAllIssues1: TMenuItem;
    MD51: TMenuItem;
    Logout1: TMenuItem;
    SpeedButton1: TSpeedButton;
    procedure Login1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure ReportnewIssue1Click(Sender: TObject);
    procedure ViewMyIssues1Click(Sender: TObject);
    procedure ServerTime1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure ViewAllIssues1Click(Sender: TObject);
    procedure DBGridReportsTitleClick(Column: TColumn);
    procedure MD51Click(Sender: TObject);
    procedure Logout1Click(Sender: TObject);
    procedure DBGridReportsDblClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
    const
      RoleAdmin     = 'Admin';
      RoleManager   = 'Manager';
      RoleTester    = 'Tester';
      RoleDeveloper = 'Developer';

    function StatusToInt(ItemIndex: Integer): Integer;
  public
    { Public declarations }
    UserID: Integer;
  end;

var
  FormClient: TFormClient;

implementation
uses
  CodeSiteLogging,
  IdHashMessageDigest, Clipbrd,
  DBXClientClasses, DataMod, CommentForm, IssueForm, LoginForm, NewIssueForm;

{$R *.dfm}

function TFormClient.StatusToInt(ItemIndex: Integer): Integer;
begin
  case Itemindex of
    0..2: Result := ItemIndex + 1; // Reported, Assigned, Opened
    3..5: Result := ItemIndex + 3; // Solved, Tested, Deployed
    6: Result := 10
    else Result := 0
  end
end;

procedure TFormClient.Login1Click(Sender: TObject);
var
  MD5: TIdHashMessageDigest5;
  Server: TServerMethods1Client;
  UserRoles: String;
begin
  Logout1.Enabled := False;
  Issues1.Visible := False;
  MD51.Visible := False;
  ServerTime1.Visible := False;
  DBGridReports.DataSource := nil;
  DataModule1.SQLConnection1.Connected := False;
  SpeedButton1.Enabled := False;
  StatusBar1.SimpleText := '';
  UserID := -1;

  with TFormLogin.Create(Self) do
  try
    if ShowModal = mrOK then
    begin
      DataModule1.SQLConnection1.Params.Values['DSAuthenticationUser'] := Username;
      MD5 := TIdHashMessageDigest5.Create;
      try
        DataModule1.SQLConnection1.Params.Values['DSAuthenticationPassword'] :=
          LowerCase(MD5.HashStringAsHex(Password, TEncoding.UTF8));

        DataModule1.SQLConnection1.Connected := True; // try to login...
        Server := TServerMethods1Client.Create(DataMod.DataModule1.SQLConnection1.DBXConnection);
        try
          UserID := Server.GetCurrentUserID;
          UserRoles := Server.GetCurrentUserRoles;
          StatusBar1.SimpleText := 'User '  + UserName + ' Roles: '  + UserRoles;
          ViewAllIssues1.Visible := Pos(RoleManager, UserRoles) > 0;
          ViewMyIssues1.Visible := (Pos(RoleDeveloper, UserRoles) > 0) or (Pos(RoleTester, UserRoles) > 0);
          ReportnewIssue1.Visible := Pos(RoleTester, UserRoles) > 0;
          Issues1.Visible := ViewAllIssues1.Visible or ViewMyIssues1.Visible; // at least one...
          MD51.Visible := Pos(RoleAdmin, UserRoles) > 0;
          SpeedButton1.Enabled := ViewAllIssues1.Visible or ViewMyIssues1.Visible;
          ServerTime1.Visible := MD51.Visible;
          Logout1.Enabled := True;
        finally
          Server.Free
        end
      finally
        MD5.Free
      end
    end
  finally
    Free
  end
end;

procedure TFormClient.Logout1Click(Sender: TObject);
begin
  Logout1.Enabled := False;
  Issues1.Visible := False;
  MD51.Visible := False;
  ServerTime1.Visible := False;
  DBGridReports.DataSource := nil;
  SpeedButton1.Enabled := False;
  StatusBar1.SimpleText := 'Please login';
  UserID := -1;
end;

procedure TFormClient.MD51Click(Sender: TObject);
var
  MD5: TIdHashMessageDigest5;
  Clipboard: TClipboard;
begin
  MD5 := TIdHashMessageDigest5.Create;
  try
    Clipboard := TClipboard.Create;
    Clipboard.AsText :=
      LowerCase(MD5.HashStringAsHex(InputBox('HASH','Password:',''), TEncoding.UTF8))
  finally
    MD5.Free
  end
end;

procedure TFormClient.ServerTime1Click(Sender: TObject);
var
  Server: TServerMethods1Client;
begin
  DataMod.DataModule1.SQLConnection1.Connected := True;
  Server := TServerMethods1Client.Create(DataMod.DataModule1.SQLConnection1.DBXConnection);
  try
    ShowMessage(DateTimeToStr(Server.ServerTime))
  finally
    Server.Free;
    DataMod.DataModule1.SQLConnection1.Connected := False
  end
end;

procedure TFormClient.SpeedButton1Click(Sender: TObject);
begin
  if ViewAllIssues1.Visible then
    ViewAllIssues1Click(nil)
  else
    if ViewMyIssues1.Visible then
      ViewMyIssues1Click(nil);
end;

procedure TFormClient.ViewAllIssues1Click(Sender: TObject);
// Manager - all reports (read-only)
var
  i: Integer;
begin
  DBGridReports.DataSource := nil;
  DataMod.DataModule1.SQLConnection1.Connected := True;
  try
    DataMod.DataModule1.cdsIssues.Close;
    DataMod.DataModule1.SqlServerMethodGetIssues.Params.ParamByName('MinStatus').AsInteger :=
      StatusToInt(cbMinStatus.ItemIndex);
    DataMod.DataModule1.SqlServerMethodGetIssues.Params.ParamByName('MaxStatus').AsInteger :=
      StatusToInt(cbMaxStatus.ItemIndex);
    DataMod.DataModule1.cdsIssues.Open;
    DBGridReports.DataSource := DataMod.DataModule1.dsIssues;
    for i:=0 to DBGridReports.Columns.Count-1 do
      DBGridReports.Columns[i].Width := (ClientWidth-36) div DBGridReports.Columns.Count-1
  finally
    DataMod.DataModule1.SQLConnection1.Connected := False
  end
end;

procedure TFormClient.ViewMyIssues1Click(Sender: TObject);
// Developer/Tester personal reports
var
  i: Integer;
begin
  DBGridReports.DataSource := nil;
  DataMod.DataModule1.SQLConnection1.Connected := True;
  try
    DataMod.DataModule1.cdsReports.Close;
    DataMod.DataModule1.cdsReports.Params.ParamByName('MinStatus').AsInteger :=
      StatusToInt(cbMinStatus.ItemIndex);
    DataMod.DataModule1.cdsReports.Params.ParamByName('MaxStatus').AsInteger :=
      StatusToInt(cbMaxStatus.ItemIndex);
    DataMod.DataModule1.cdsReports.Open;
    DBGridReports.DataSource := DataMod.DataModule1.dsReports;
    DBGridReports.Columns[DBGridReports.Columns.Count-1].Visible := False; // nested dataset
    for i:=0 to DBGridReports.Columns.Count-1 do
      DBGridReports.Columns[i].Width := (ClientWidth-42) div (DBGridReports.Columns.Count-1)
  finally
    DataMod.DataModule1.SQLConnection1.Connected := False
  end
end;

procedure TFormClient.ReportnewIssue1Click(Sender: TObject);
begin
  with TFormNewIssue.Create(Self) do
  try
    ShowModal
  finally
    Free
  end;
end;

procedure TFormClient.About1Click(Sender: TObject);
begin
  ShowMessage('Dirt Cleaner v1.0')
end;

procedure TFormClient.DBGridReportsDblClick(Sender: TObject);
begin
  with TFormIssue.Create(Self) do
  try
    ShowModal
  finally
    Free
  end;
end;

procedure TFormClient.DBGridReportsTitleClick(Column: TColumn);
begin
  (DBGridReports.DataSource.DataSet as TClientDataSet).IndexFieldNames :=
    Column.Title.Caption
end;

procedure TFormClient.FormResize(Sender: TObject);
var
  i: Integer;
begin
  if DBGridReports.Columns.Count > 1 then
    for i:=0 to DBGridReports.Columns.Count-1 do
      DBGridReports.Columns[i].Width := (ClientWidth-42) div (DBGridReports.Columns.Count-1);
end;

procedure TFormClient.Exit1Click(Sender: TObject);
begin
  Close
end;

end.

