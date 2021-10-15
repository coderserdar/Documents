object ServerMethods1: TServerMethods1
  OldCreateOrder = False
  OnCreate = AS_DSServerModuleCreate
  Height = 236
  Width = 476
  object SQLConnection1: TSQLConnection
    DriverName = 'MSSQL'
    GetDriverFunc = 'getSQLDriverMSSQL'
    LibraryName = 'dbxmss.dll'
    LoginPrompt = False
    Params.Strings = (
      'SchemaOverride=%.dbo'
      'DriverUnit=DBXMSSQL'
        'DriverPackageLoader=TDBXDynalinkDriverLoader,DBXCommonDriver150.' +
        'bpl'
        'DriverAssemblyLoader=Borland.Data.TDBXDynalinkDriverLoader,Borla' +
        'nd.Data.DbxCommonDriver,Version=15.0.0.0,Culture=neutral,PublicK' +
        'eyToken=91d62ebb5b0d1b1b'
        'MetaDataPackageLoader=TDBXMsSqlMetaDataCommandFactory,DbxMSSQLDr' +
        'iver150.bpl'
        'MetaDataAssemblyLoader=Borland.Data.TDBXMsSqlMetaDataCommandFact' +
        'ory,Borland.Data.DbxMSSQLDriver,Version=15.0.0.0,Culture=neutral' +
        ',PublicKeyToken=91d62ebb5b0d1b1b'
      'GetDriverFunc=getSQLDriverMSSQL'
      'LibraryName=dbxmss.dll'
      'VendorLib=sqlncli10.dll'
      'HostName=SEVEN'
      'Database=Dirt'
      'MaxBlobSize=-1'
      'LocaleCode=0000'
      'IsolationLevel=ReadCommitted'
      'OSAuthentication=False'
      'PrepareSQL=True'
      'User_Name=sa'
      'Password=********'
      'BlobSize=-1'
      'ErrorResourceFile='
      'OS Authentication=False'
      'Prepare SQL=False')
    VendorLib = 'sqlncli10.dll'
    Left = 40
    Top = 24
  end
  object sqlReports: TSQLDataSet
    SchemaName = 'dbo'
    CommandText = 
      'SELECT "ReportID", "Project", "Version", "Module", "IssueType", ' +
      #13#10'  "Priority", "Status", "ReportDate", '#13#10'  UReporterID.Name AS ' +
      '"Reporter", UAssignedTO.Name AS Assigned,'#13#10'  "Summary", "Report"' +
      ' '#13#10'FROM "Report"'#13#10'LEFT OUTER JOIN [User] UReporterID ON UReporte' +
      'rID.UserID = ReporterID'#13#10'LEFT OUTER JOIN [User] UAssignedTO ON U' +
      'AssignedTO.UserID = AssignedTO'#13#10'WHERE Status >= :MinStatus AND S' +
      'tatus <= :MaxStatus'#13#10'ORDER BY Status'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftWideString
        Name = 'MinStatus'
        ParamType = ptInput
        Value = '0'
      end
      item
        DataType = ftWideString
        Name = 'MaxStatus'
        ParamType = ptInput
        Value = '0'
      end>
    SQLConnection = SQLConnection1
    Left = 144
    Top = 24
  end
  object sqlReportUser: TSQLDataSet
    SchemaName = 'sa'
    AfterScroll = AS_sqlReportUserAfterScroll
    CommandText = 
      'SELECT "ReportID", "Project", "Version", "Module", "IssueType", ' +
      #13#10'  "Priority", "Status", "ReportDate", "ReporterID", "AssignedT' +
      'o", '#13#10'  "Summary", "Report" '#13#10'FROM "Report" '#13#10'WHERE (Status >= :' +
      'MinStatus) AND (Status <= :MaxStatus) AND ((AssignedTo = :Assign' +
      'edTo) OR (ReporterID = :ReporterID))'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'MinStatus'
        ParamType = ptInput
        Value = '0'
      end
      item
        DataType = ftInteger
        Name = 'MaxStatus'
        ParamType = ptInput
        Value = '10'
      end>
    SQLConnection = SQLConnection1
    Left = 160
    Top = 112
    object sqlReportUserReportID: TIntegerField
      FieldName = 'ReportID'
      ProviderFlags = [pfInWhere, pfInKey]
      Required = True
    end
    object sqlReportUserProject: TWideStringField
      FieldName = 'Project'
      Required = True
      Size = 100
    end
    object sqlReportUserVersion: TWideStringField
      FieldName = 'Version'
      Size = 40
    end
    object sqlReportUserModule: TWideStringField
      FieldName = 'Module'
      Size = 100
    end
    object sqlReportUserIssueType: TIntegerField
      FieldName = 'IssueType'
      Required = True
    end
    object sqlReportUserPriority: TIntegerField
      FieldName = 'Priority'
      Required = True
    end
    object sqlReportUserStatus: TIntegerField
      FieldName = 'Status'
      Required = True
    end
    object sqlReportUserReportDate: TSQLTimeStampField
      FieldName = 'ReportDate'
      Required = True
    end
    object sqlReportUserReporterID: TIntegerField
      FieldName = 'ReporterID'
      Required = True
    end
    object sqlReportUserAssignedTo: TIntegerField
      FieldName = 'AssignedTo'
    end
    object sqlReportUserSummary: TWideStringField
      FieldName = 'Summary'
      Required = True
      Size = 280
    end
    object sqlReportUserReport: TWideStringField
      FieldName = 'Report'
      Required = True
      Size = 8000
    end
  end
  object sqlComments: TSQLDataSet
    SchemaName = 'dbo'
    CommandText = 
      'SELECT CommentID, ReportID, UserID, CommentDate, Comment '#13#10'FROM ' +
      'Comment'#13#10'WHERE (ReportID = :ReportID)'
    DbxCommandType = 'Dbx.SQL'
    DataSource = dsReportUser
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'ReportID'
        ParamType = ptInput
        Value = '0'
      end>
    SQLConnection = SQLConnection1
    Left = 272
    Top = 112
    object sqlCommentsCommentID: TIntegerField
      FieldName = 'CommentID'
      ProviderFlags = [pfInWhere, pfInKey]
      Required = True
    end
    object sqlCommentsReportID: TIntegerField
      FieldName = 'ReportID'
      Required = True
    end
    object sqlCommentsUserID: TIntegerField
      FieldName = 'UserID'
      Required = True
    end
    object sqlCommentsCommentDate: TSQLTimeStampField
      FieldName = 'CommentDate'
      Required = True
    end
    object sqlCommentsComment: TWideStringField
      FieldName = 'Comment'
      Required = True
      Size = 8000
    end
  end
  object dsReportUser: TDataSource
    DataSet = sqlReportUser
    Left = 224
    Top = 168
  end
  object dspReportUserWithComments: TDataSetProvider
    DataSet = sqlReportUser
    UpdateMode = upWhereChanged
    BeforeGetRecords = AS_dspReportUserWithCommentsBeforeGetRecords
    Left = 368
    Top = 136
  end
  object sqlUser: TSQLDataSet
    CommandText = 'SELECT UserID,Name FROM [User]'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = SQLConnection1
    Left = 40
    Top = 96
  end
end
