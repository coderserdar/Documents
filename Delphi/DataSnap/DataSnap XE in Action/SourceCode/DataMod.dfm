object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 363
  Width = 496
  object SQLConnection1: TSQLConnection
    DriverName = 'Datasnap'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=DBXDataSnap'
      'HostName=www.bobswart.nl'
      'Port=443'
      'CommunicationProtocol=https'
      'DatasnapContext=datasnap/'
      
        'DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland' +
        '.Data.DbxClientDriver,Version=15.0.0.0,Culture=neutral,PublicKey' +
        'Token=91d62ebb5b0d1b1b'
      'Filters={}'
      'URLPath=/DataSnapXE/DirtServer.dll'
      'BufferKBSize=48')
    Left = 64
    Top = 32
    UniqueId = '{7C325559-4E58-497B-96B6-F6AD30E55685}'
  end
  object SqlServerMethodGetIssues: TSqlServerMethod
    Params = <
      item
        DataType = ftInteger
        Precision = 4
        Name = 'MinStatus'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Precision = 4
        Name = 'MaxStatus'
        ParamType = ptInput
      end
      item
        DataType = ftDataSet
        Name = 'ReturnParameter'
        ParamType = ptResult
        Value = 'TDataSet'
      end>
    SQLConnection = SQLConnection1
    ServerMethodName = 'TServerMethods1.GetIssues'
    Left = 64
    Top = 96
  end
  object dspIssues: TDataSetProvider
    DataSet = SqlServerMethodGetIssues
    Left = 64
    Top = 160
  end
  object cdsIssues: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspIssues'
    ReadOnly = True
    Left = 64
    Top = 224
    object cdsIssuesReportID: TIntegerField
      FieldName = 'ReportID'
      Required = True
      Visible = False
    end
    object cdsIssuesProject: TWideStringField
      FieldName = 'Project'
      Required = True
      Size = 202
    end
    object cdsIssuesVersion: TWideStringField
      FieldName = 'Version'
      Required = True
      Size = 82
    end
    object cdsIssuesModule: TWideStringField
      FieldName = 'Module'
      Required = True
      Size = 202
    end
    object cdsIssuesIssueType: TIntegerField
      FieldName = 'IssueType'
      Required = True
      OnGetText = IssueTypeGetText
    end
    object cdsIssuesPriority: TIntegerField
      FieldName = 'Priority'
      Required = True
      OnGetText = PriorityGetText
    end
    object cdsIssuesStatus: TIntegerField
      FieldName = 'Status'
      Required = True
      OnGetText = StatusGetText
    end
    object cdsIssuesReportDate: TSQLTimeStampField
      FieldName = 'ReportDate'
      Required = True
    end
    object cdsIssuesReporter: TWideStringField
      FieldName = 'Reporter'
      Required = True
      Size = 202
    end
    object cdsIssuesAssigned: TWideStringField
      FieldName = 'Assigned'
      Required = True
      Size = 202
    end
    object cdsIssuesSummary: TWideStringField
      FieldName = 'Summary'
      Required = True
      Size = 562
    end
    object cdsIssuesReport: TWideStringField
      FieldName = 'Report'
      Required = True
      Size = 16002
    end
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TServerMethods1'
    SQLConnection = SQLConnection1
    Left = 200
    Top = 32
  end
  object cdsReports: TClientDataSet
    Aggregates = <>
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
    ProviderName = 'dspReportUserWithComments'
    RemoteServer = DSProviderConnection1
    AfterInsert = cdsReportsAfterInsert
    AfterPost = cdsReportsOrCommentsAfterPostOrDelete
    AfterDelete = cdsReportsOrCommentsAfterPostOrDelete
    OnReconcileError = cdsReportsReconcileError
    Left = 336
    Top = 32
    object cdsReportsReportID: TIntegerField
      FieldName = 'ReportID'
      ProviderFlags = [pfInWhere, pfInKey]
      Required = True
      Visible = False
    end
    object cdsReportsProject: TWideStringField
      FieldName = 'Project'
      Required = True
      Size = 100
    end
    object cdsReportsVersion: TWideStringField
      FieldName = 'Version'
      Size = 40
    end
    object cdsReportsModule: TWideStringField
      FieldName = 'Module'
      Size = 100
    end
    object cdsReportsIssueType: TIntegerField
      FieldName = 'IssueType'
      Required = True
      OnGetText = IssueTypeGetText
    end
    object cdsReportsPriority: TIntegerField
      FieldName = 'Priority'
      Required = True
      OnGetText = PriorityGetText
    end
    object cdsReportsStatus: TIntegerField
      FieldName = 'Status'
      Required = True
      OnGetText = StatusGetText
    end
    object cdsReportsReportDate: TSQLTimeStampField
      FieldName = 'ReportDate'
      Required = True
    end
    object cdsReportsReporterID: TIntegerField
      FieldName = 'ReporterID'
      Required = True
      Visible = False
    end
    object cdsReportsAssignedTo: TIntegerField
      FieldName = 'AssignedTo'
      Visible = False
    end
    object cdsReportsSummary: TWideStringField
      FieldName = 'Summary'
      Required = True
      Size = 280
    end
    object cdsReportsReport: TWideStringField
      FieldName = 'Report'
      Required = True
      Size = 8000
    end
    object cdsReportssqlComments: TDataSetField
      FieldName = 'sqlComments'
      Visible = False
    end
    object cdsReportsReporterName: TStringField
      FieldKind = fkLookup
      FieldName = 'ReporterName'
      LookupDataSet = cdsUserNames
      LookupKeyFields = 'UserID'
      LookupResultField = 'Name'
      KeyFields = 'ReportID'
      Size = 50
      Lookup = True
    end
    object cdsReportsAssignedName: TStringField
      FieldKind = fkLookup
      FieldName = 'AssignedName'
      LookupDataSet = cdsUserNames
      LookupKeyFields = 'UserID'
      LookupResultField = 'Name'
      KeyFields = 'AssignedTo'
      Size = 50
      Lookup = True
    end
  end
  object cdsComments: TClientDataSet
    Aggregates = <>
    DataSetField = cdsReportssqlComments
    Params = <>
    BeforeOpen = cdsCommentsBeforeOpen
    AfterInsert = cdsCommentsAfterInsert
    AfterPost = cdsReportsOrCommentsAfterPostOrDelete
    AfterDelete = cdsReportsOrCommentsAfterPostOrDelete
    Left = 336
    Top = 96
    object cdsCommentsCommentID: TIntegerField
      FieldName = 'CommentID'
      ProviderFlags = [pfInWhere, pfInKey]
      Required = True
      Visible = False
    end
    object cdsCommentsReportID: TIntegerField
      FieldName = 'ReportID'
      Required = True
      Visible = False
    end
    object cdsCommentsUserID: TIntegerField
      FieldName = 'UserID'
      Required = True
    end
    object cdsCommentsCommentDate: TSQLTimeStampField
      DisplayWidth = 10
      FieldName = 'CommentDate'
      Required = True
    end
    object cdsCommentsComment: TWideStringField
      FieldName = 'Comment'
      Required = True
      Size = 8000
    end
    object cdsCommentsUserName: TStringField
      FieldKind = fkLookup
      FieldName = 'UserName'
      LookupDataSet = cdsUserNames
      LookupKeyFields = 'UserID'
      LookupResultField = 'Name'
      KeyFields = 'UserID'
      Size = 50
      Lookup = True
    end
  end
  object dsIssues: TDataSource
    DataSet = cdsIssues
    Left = 64
    Top = 288
  end
  object dsReports: TDataSource
    DataSet = cdsReports
    Left = 432
    Top = 32
  end
  object SqlServerMethodGetUserNames: TSqlServerMethod
    GetMetadata = False
    Params = <
      item
        DataType = ftDataSet
        Name = 'ReturnParameter'
        ParamType = ptResult
        Value = 'TDataSet'
      end>
    SQLConnection = SQLConnection1
    ServerMethodName = 'TServerMethods1.GetUserNames'
    Left = 216
    Top = 120
  end
  object dspUserNames: TDataSetProvider
    DataSet = SqlServerMethodGetUserNames
    Left = 216
    Top = 176
  end
  object cdsUserNames: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspUserNames'
    Left = 216
    Top = 240
    object cdsUserNamesUserID: TIntegerField
      FieldName = 'UserID'
      Required = True
    end
    object cdsUserNamesName: TWideStringField
      FieldName = 'Name'
      Required = True
      Size = 202
    end
  end
end
