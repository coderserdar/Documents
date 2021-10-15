object FormJson: TFormJson
  Left = 0
  Top = 0
  Caption = 'JsonTests'
  ClientHeight = 345
  ClientWidth = 693
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnParseObj: TButton
    Left = 8
    Top = 135
    Width = 113
    Height = 25
    Caption = 'btnParseObj'
    TabOrder = 0
    OnClick = btnParseObjClick
  end
  object btnParseUTF8: TButton
    Left = 8
    Top = 166
    Width = 113
    Height = 25
    Caption = 'btnParseUTF8'
    TabOrder = 1
    OnClick = btnParseUTF8Click
  end
  object Memo1: TMemo
    Left = 144
    Top = 8
    Width = 541
    Height = 329
    TabOrder = 2
  end
  object btnValues: TButton
    Left = 8
    Top = 8
    Width = 113
    Height = 25
    Caption = 'btnValues'
    TabOrder = 3
    OnClick = btnValuesClick
  end
  object btnSimpleArray: TButton
    Left = 8
    Top = 40
    Width = 113
    Height = 25
    Caption = 'btnSimpleArray'
    TabOrder = 4
    OnClick = btnSimpleArrayClick
  end
  object btnSimpleObject: TButton
    Left = 8
    Top = 71
    Width = 113
    Height = 25
    Caption = 'btnSimpleObject'
    TabOrder = 5
    OnClick = btnSimpleObjectClick
  end
end
