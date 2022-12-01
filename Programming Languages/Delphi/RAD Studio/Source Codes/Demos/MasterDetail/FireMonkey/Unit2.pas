unit Unit2;

interface

uses
//** Converted to FireMonkey with Mida BASIC 252     http://www.midaconverter.com

  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.IniFiles,
  Data.DB,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.Objects,
  FMX.Menus,
  FMX.Grid,
  FMX.ExtCtrls,
  FMX.ListBox,
  FMX.TreeView,
  FMX.Memo,
  FMX.TabControl,
  FMXTee.RadioGroup,
  FMX.Layouts,
  FMX.Edit,
  FMX.Platform,
  FMX.Bind.DBEngExt,
  FMX.Bind.Editors,
  FMX.Bind.DBLinks,
  FMX.Bind.Navigator,
  Data.Bind.EngExt,
  Data.Bind.Components,
  Data.Bind.DBScope,
  Data.Bind.DBLinks,
  FMXTee.Series,
  FMXTee.Engine,
  FMXTee.Procs,
  FMXTee.Chart,
  Datasnap.DBClient;

//**   Original VCL Uses section : 


//**   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
//**   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DBXInterBase, Data.FMTBcd,
//**   Datasnap.DBClient, Datasnap.Provider, Vcl.Grids, Vcl.DBGrids, Data.DB,
//**   Data.SqlExpr;




type
  TForm2 = class(TForm)
BindingsList1: TBindingsList;
BindScopeDB_DataSource1: TBindScopeDB;
BindScopeDB_DataSource2: TBindScopeDB;

    EMPLOYEE: TSQLConnection;
    EMPLOYEE1: TSQLDataSet;
    DataSource1: TDataSource;
    DBGrid1: TGrid;
    DataSetProvider1: TDataSetProvider;
    ClientDataSet1: TClientDataSet;
    EMPLOYEE_PROJECT: TSQLDataSet;
    DataSetProvider2: TDataSetProvider;
    DBGrid2: TGrid;
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

{$R *.FMX}

end.
