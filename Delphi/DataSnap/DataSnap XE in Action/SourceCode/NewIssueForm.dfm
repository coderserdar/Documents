object FormNewIssue: TFormNewIssue
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Report New Issue'
  ClientHeight = 323
  ClientWidth = 576
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 11
    Width = 34
    Height = 13
    Caption = 'Project'
    FocusControl = DBEditProject
  end
  object Label2: TLabel
    Left = 305
    Top = 11
    Width = 35
    Height = 13
    Caption = 'Version'
    FocusControl = DBEditVersion
  end
  object Label3: TLabel
    Left = 5
    Top = 38
    Width = 34
    Height = 13
    Caption = 'Module'
    FocusControl = DBEditModule
  end
  object Label4: TLabel
    Left = 5
    Top = 65
    Width = 50
    Height = 13
    Caption = 'IssueType'
  end
  object Label5: TLabel
    Left = 5
    Top = 92
    Width = 34
    Height = 13
    Caption = 'Priority'
  end
  object Label6: TLabel
    Left = 302
    Top = 65
    Width = 31
    Height = 13
    Caption = 'Status'
    FocusControl = DBEditStatus
  end
  object Label7: TLabel
    Left = 302
    Top = 92
    Width = 56
    Height = 13
    Caption = 'ReportDate'
    FocusControl = DBEditReportDate
  end
  object Label8: TLabel
    Left = 5
    Top = 119
    Width = 43
    Height = 13
    Caption = 'Reporter'
  end
  object Label9: TLabel
    Left = 302
    Top = 119
    Width = 58
    Height = 13
    Caption = 'Assigned To'
  end
  object Label10: TLabel
    Left = 5
    Top = 146
    Width = 44
    Height = 13
    Caption = 'Summary'
    FocusControl = DBEditSummary
  end
  object Label11: TLabel
    Left = 5
    Top = 173
    Width = 33
    Height = 13
    Caption = 'Report'
  end
  object sePriority: TSpinEdit
    Left = 69
    Top = 88
    Width = 48
    Height = 22
    MaxValue = 10
    MinValue = 1
    TabOrder = 10
    Value = 1
  end
  object seIssueType: TSpinEdit
    Left = 69
    Top = 61
    Width = 48
    Height = 22
    MaxValue = 10
    MinValue = 1
    TabOrder = 9
    Value = 1
  end
  object DBEditProject: TDBEdit
    Left = 69
    Top = 8
    Width = 200
    Height = 21
    DataField = 'Project'
    DataSource = dsReports
    TabOrder = 0
  end
  object DBEditVersion: TDBEdit
    Left = 369
    Top = 8
    Width = 200
    Height = 21
    DataField = 'Version'
    DataSource = dsReports
    TabOrder = 1
  end
  object DBEditModule: TDBEdit
    Left = 69
    Top = 35
    Width = 500
    Height = 21
    DataField = 'Module'
    DataSource = dsReports
    TabOrder = 2
  end
  object DBEditStatus: TDBEdit
    Left = 366
    Top = 62
    Width = 120
    Height = 21
    TabStop = False
    DataField = 'Status'
    DataSource = dsReports
    ReadOnly = True
    TabOrder = 3
  end
  object DBEditReportDate: TDBEdit
    Left = 366
    Top = 89
    Width = 120
    Height = 21
    TabStop = False
    DataField = 'ReportDate'
    DataSource = dsReports
    ReadOnly = True
    TabOrder = 4
  end
  object DBEditSummary: TDBEdit
    Left = 69
    Top = 143
    Width = 500
    Height = 21
    DataField = 'Summary'
    DataSource = dsReports
    TabOrder = 5
  end
  object DBMemoReport: TDBMemo
    Left = 69
    Top = 170
    Width = 500
    Height = 116
    DataField = 'Report'
    DataSource = dsReports
    ScrollBars = ssVertical
    TabOrder = 6
  end
  object btnOK: TBitBtn
    Left = 412
    Top = 292
    Width = 75
    Height = 25
    DoubleBuffered = True
    Kind = bkOK
    NumGlyphs = 2
    ParentDoubleBuffered = False
    TabOrder = 7
    OnClick = btnOKClick
  end
  object btnCancel: TBitBtn
    Left = 493
    Top = 292
    Width = 75
    Height = 25
    DoubleBuffered = True
    Kind = bkCancel
    NumGlyphs = 2
    ParentDoubleBuffered = False
    TabOrder = 8
    OnClick = btnCancelClick
  end
  object cbAssignedTo: TComboBox
    Left = 366
    Top = 116
    Width = 171
    Height = 21
    Style = csDropDownList
    TabOrder = 11
  end
  object edReporter: TEdit
    Left = 69
    Top = 116
    Width = 121
    Height = 21
    TabOrder = 12
    Text = 'edReporter'
  end
  object dsReports: TDataSource
    DataSet = DataModule1.cdsReports
    Left = 216
    Top = 72
  end
end
