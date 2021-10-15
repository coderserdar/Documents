object FormClient: TFormClient
  Left = 0
  Top = 0
  Caption = 'DIRT Cleaner'
  ClientHeight = 262
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 243
    Width = 624
    Height = 19
    Constraints.MaxHeight = 19
    Constraints.MinHeight = 19
    Panels = <>
    SimplePanel = True
    SimpleText = 'Please login'
  end
  object DBGridReports: TDBGrid
    Left = 0
    Top = 27
    Width = 624
    Height = 216
    Align = alClient
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGridReportsDblClick
    OnTitleClick = DBGridReportsTitleClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 27
    Align = alTop
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 5
      Width = 54
      Height = 13
      Caption = 'Min Status:'
    end
    object Label2: TLabel
      Left = 143
      Top = 5
      Width = 58
      Height = 13
      Caption = 'Max Status:'
    end
    object SpeedButton1: TSpeedButton
      Left = 282
      Top = 2
      Width = 23
      Height = 22
      Hint = 'Select'
      Enabled = False
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333333333FFFFFFFFF333333000000000033333377777777773333330FFFFF
        FFF03333337F333333373333330FFFFFFFF03333337F3FF3FFF73333330F00F0
        00F03333F37F773777373330330FFFFFFFF03337FF7F3F3FF3F73339030F0800
        F0F033377F7F737737373339900FFFFFFFF03FF7777F3FF3FFF70999990F00F0
        00007777777F7737777709999990FFF0FF0377777777FF37F3730999999908F0
        F033777777777337F73309999990FFF0033377777777FFF77333099999000000
        3333777777777777333333399033333333333337773333333333333903333333
        3333333773333333333333303333333333333337333333333333}
      NumGlyphs = 2
      OnClick = SpeedButton1Click
    end
    object cbMinStatus: TComboBox
      Left = 68
      Top = 2
      Width = 69
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = 'Reported'
      Items.Strings = (
        'Reported'
        'Assigned'
        'Opened'
        'Solved'
        'Tested'
        'Deployed'
        'Closed')
    end
    object cbMaxStatus: TComboBox
      Left = 207
      Top = 2
      Width = 69
      Height = 21
      Style = csDropDownList
      ItemIndex = 6
      TabOrder = 1
      Text = 'Closed'
      Items.Strings = (
        'Reported'
        'Assigned'
        'Opened'
        'Solved'
        'Tested'
        'Deployed'
        'Closed')
    end
  end
  object MainMenu1: TMainMenu
    Left = 224
    Top = 72
    object Client1: TMenuItem
      Caption = 'Client'
      object Login1: TMenuItem
        Caption = 'Login...'
        OnClick = Login1Click
      end
      object Logout1: TMenuItem
        Caption = 'Logout'
        Enabled = False
        OnClick = Logout1Click
      end
      object Exit1: TMenuItem
        Caption = 'Exit'
        OnClick = Exit1Click
      end
    end
    object Issues1: TMenuItem
      Caption = 'Issues'
      Visible = False
      object ViewMyIssues1: TMenuItem
        Caption = 'View My Issues'
        OnClick = ViewMyIssues1Click
      end
      object ViewAllIssues1: TMenuItem
        Caption = 'View All Issues'
        OnClick = ViewAllIssues1Click
      end
      object ReportnewIssue1: TMenuItem
        Caption = 'Report new Issue...'
        OnClick = ReportnewIssue1Click
      end
    end
    object Help1: TMenuItem
      Caption = 'Help'
      object ServerTime1: TMenuItem
        Caption = 'Server Time'
        Visible = False
        OnClick = ServerTime1Click
      end
      object About1: TMenuItem
        Caption = 'About...'
        OnClick = About1Click
      end
      object MD51: TMenuItem
        Caption = 'MD5'
        Visible = False
        OnClick = MD51Click
      end
    end
  end
end
