object FormIssue: TFormIssue
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Reported Issue'
  ClientHeight = 450
  ClientWidth = 576
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
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
    FocusControl = DBEditIssueType
  end
  object Label5: TLabel
    Left = 5
    Top = 92
    Width = 34
    Height = 13
    Caption = 'Priority'
    FocusControl = DBEditPriority
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
    FocusControl = DBEditReporterName
  end
  object Label9: TLabel
    Left = 302
    Top = 119
    Width = 58
    Height = 13
    Caption = 'Assigned To'
    FocusControl = DBEditAssignedName
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
  object DBEditProject: TDBEdit
    Left = 69
    Top = 8
    Width = 200
    Height = 21
    DataField = 'Project'
    DataSource = dsReports
    ReadOnly = True
    TabOrder = 0
  end
  object DBEditVersion: TDBEdit
    Left = 369
    Top = 8
    Width = 200
    Height = 21
    DataField = 'Version'
    DataSource = dsReports
    ReadOnly = True
    TabOrder = 1
  end
  object DBEditModule: TDBEdit
    Left = 69
    Top = 35
    Width = 500
    Height = 21
    DataField = 'Module'
    DataSource = dsReports
    ReadOnly = True
    TabOrder = 2
  end
  object DBEditIssueType: TDBEdit
    Left = 69
    Top = 62
    Width = 100
    Height = 21
    DataField = 'IssueType'
    DataSource = dsReports
    ReadOnly = True
    TabOrder = 3
  end
  object DBEditPriority: TDBEdit
    Left = 69
    Top = 89
    Width = 100
    Height = 21
    DataField = 'Priority'
    DataSource = dsReports
    ReadOnly = True
    TabOrder = 4
  end
  object DBEditStatus: TDBEdit
    Left = 366
    Top = 62
    Width = 100
    Height = 21
    DataField = 'Status'
    DataSource = dsReports
    ReadOnly = True
    TabOrder = 5
  end
  object DBEditReportDate: TDBEdit
    Left = 366
    Top = 89
    Width = 100
    Height = 21
    DataField = 'ReportDate'
    DataSource = dsReports
    ReadOnly = True
    TabOrder = 6
  end
  object DBEditReporterName: TDBEdit
    Left = 69
    Top = 116
    Width = 100
    Height = 21
    DataField = 'ReporterName'
    DataSource = dsReports
    ReadOnly = True
    TabOrder = 7
  end
  object DBEditAssignedName: TDBEdit
    Left = 366
    Top = 116
    Width = 100
    Height = 21
    DataField = 'AssignedName'
    DataSource = dsReports
    ReadOnly = True
    TabOrder = 8
  end
  object DBEditSummary: TDBEdit
    Left = 69
    Top = 143
    Width = 500
    Height = 21
    DataField = 'Summary'
    DataSource = dsReports
    ReadOnly = True
    TabOrder = 9
  end
  object DBMemoReport: TDBMemo
    Left = 69
    Top = 170
    Width = 500
    Height = 116
    DataField = 'Report'
    DataSource = dsReports
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 10
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 292
    Width = 161
    Height = 120
    DataSource = dsComments
    FixedColor = 13434879
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 11
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Color = clWindow
        Expanded = False
        FieldName = 'CommentDate'
        Title.Caption = 'Date'
        Visible = True
      end
      item
        Color = clWindow
        Expanded = False
        FieldName = 'UserName'
        Visible = True
      end>
  end
  object DBMemoComment: TDBMemo
    Left = 175
    Top = 292
    Width = 394
    Height = 120
    DataField = 'Comment'
    DataSource = dsComments
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 12
  end
  object BitBtn1: TBitBtn
    Left = 494
    Top = 418
    Width = 75
    Height = 25
    Caption = '&Close'
    Default = True
    DoubleBuffered = True
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00388888888877
      F7F787F8888888888333333F00004444400888FFF444448888888888F333FF8F
      000033334D5007FFF4333388888888883338888F0000333345D50FFFF4333333
      338F888F3338F33F000033334D5D0FFFF43333333388788F3338F33F00003333
      45D50FEFE4333333338F878F3338F33F000033334D5D0FFFF43333333388788F
      3338F33F0000333345D50FEFE4333333338F878F3338F33F000033334D5D0FFF
      F43333333388788F3338F33F0000333345D50FEFE4333333338F878F3338F33F
      000033334D5D0EFEF43333333388788F3338F33F0000333345D50FEFE4333333
      338F878F3338F33F000033334D5D0EFEF43333333388788F3338F33F00003333
      4444444444333333338F8F8FFFF8F33F00003333333333333333333333888888
      8888333F00003333330000003333333333333FFFFFF3333F00003333330AAAA0
      333333333333888888F3333F00003333330000003333333333338FFFF8F3333F
      0000}
    NumGlyphs = 2
    ParentDoubleBuffered = False
    TabOrder = 13
    OnClick = BitBtn1Click
  end
  object btnNewComment: TBitBtn
    Left = 8
    Top = 418
    Width = 161
    Height = 25
    Caption = '&New Comment'
    DoubleBuffered = True
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
    ParentDoubleBuffered = False
    TabOrder = 14
    OnClick = btnNewCommentClick
  end
  object dsReports: TDataSource
    DataSet = DataModule1.cdsReports
    Left = 504
    Top = 88
  end
  object dsComments: TDataSource
    DataSet = DataModule1.cdsComments
    Left = 216
    Top = 72
  end
end
