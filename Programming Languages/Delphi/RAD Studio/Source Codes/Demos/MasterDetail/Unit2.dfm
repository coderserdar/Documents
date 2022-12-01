object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 628
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 144
    Top = 88
    Width = 464
    Height = 192
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBGrid2: TDBGrid
    Left = 144
    Top = 392
    Width = 464
    Height = 145
    DataSource = DataSource2
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object EMPLOYEE: TSQLConnection
    ConnectionName = 'EMPLOYEE'
    DriverName = 'INTERBASE'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    LibraryName = 'dbxint.dll'
    LoginPrompt = False
    Params.Strings = (
      'drivername=INTERBASE'
      'librarynameosx=libsqlib.dylib'
      'vendorlibwin64=ibclient64.dll'
      'vendorlibosx=libgds.dylib'
      'blobsize=-1'
      'commitretain=False'
      
        'Database=C:\Users\Public\Documents\RAD Studio\9.0\Samples\Data\E' +
        'mployee.gdb'
      'localecode=0000'
      'password=masterkey'
      'rolename=RoleName'
      'sqldialect=3'
      'isolationlevel=ReadCommitted'
      'user_name=sysdba'
      'waitonlocks=True'
      'trim char=False')
    VendorLib = 'GDS32.DLL'
    Connected = True
    Left = 26
    Top = 10
  end
  object EMPLOYEE1: TSQLDataSet
    CommandText = 'EMPLOYEE'
    CommandType = ctTable
    DbxCommandType = 'Dbx.Table'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = EMPLOYEE
    Left = 101
    Top = 13
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 464
    Top = 32
  end
  object DataSetProvider1: TDataSetProvider
    DataSet = EMPLOYEE1
    Left = 296
    Top = 32
  end
  object ClientDataSet1: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProvider1'
    Left = 392
    Top = 32
  end
  object EMPLOYEE_PROJECT: TSQLDataSet
    CommandText = 'EMPLOYEE_PROJECT'
    CommandType = ctTable
    DbxCommandType = 'Dbx.Table'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = EMPLOYEE
    Left = 97
    Top = 313
  end
  object DataSetProvider2: TDataSetProvider
    DataSet = EMPLOYEE_PROJECT
    Left = 304
    Top = 320
  end
  object ClientDataSet2: TClientDataSet
    Active = True
    Aggregates = <>
    IndexFieldNames = 'EMP_NO'
    MasterFields = 'EMP_NO'
    MasterSource = DataSource1
    PacketRecords = 0
    Params = <>
    ProviderName = 'DataSetProvider2'
    Left = 392
    Top = 320
  end
  object DataSource2: TDataSource
    DataSet = ClientDataSet2
    Left = 480
    Top = 320
  end
end
