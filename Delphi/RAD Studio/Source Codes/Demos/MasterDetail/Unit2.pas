unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DBXInterBase, Data.FMTBcd,
  Datasnap.DBClient, Datasnap.Provider, Vcl.Grids, Vcl.DBGrids, Data.DB,
  Data.SqlExpr;

type
  TForm2 = class(TForm)
    EMPLOYEE: TSQLConnection;
    EMPLOYEE1: TSQLDataSet;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    DataSetProvider1: TDataSetProvider;
    ClientDataSet1: TClientDataSet;
    EMPLOYEE_PROJECT: TSQLDataSet;
    DataSetProvider2: TDataSetProvider;
    DBGrid2: TDBGrid;
    ClientDataSet2: TClientDataSet;
    DataSource2: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

end.
