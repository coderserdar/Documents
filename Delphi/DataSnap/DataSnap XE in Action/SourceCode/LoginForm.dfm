object FormLogin: TFormLogin
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Login'
  ClientHeight = 120
  ClientWidth = 235
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 16
    Width = 52
    Height = 13
    Caption = 'Username:'
  end
  object Label2: TLabel
    Left = 24
    Top = 48
    Width = 50
    Height = 13
    Caption = 'Password:'
  end
  object edUsername: TEdit
    Left = 88
    Top = 13
    Width = 121
    Height = 21
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    TextHint = 'Username'
  end
  object edPassword: TEdit
    Left = 88
    Top = 45
    Width = 121
    Height = 21
    ParentShowHint = False
    PasswordChar = '#'
    ShowHint = True
    TabOrder = 1
    TextHint = 'Password'
  end
  object BitBtn1: TBitBtn
    Left = 24
    Top = 80
    Width = 75
    Height = 25
    DoubleBuffered = True
    Kind = bkOK
    NumGlyphs = 2
    ParentDoubleBuffered = False
    TabOrder = 2
  end
  object BitBtn2: TBitBtn
    Left = 134
    Top = 80
    Width = 75
    Height = 25
    DoubleBuffered = True
    Kind = bkCancel
    NumGlyphs = 2
    ParentDoubleBuffered = False
    TabOrder = 3
  end
end
