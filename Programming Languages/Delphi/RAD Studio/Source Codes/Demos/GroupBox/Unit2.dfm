object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 417
  ClientWidth = 759
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 24
    Top = 24
    Width = 233
    Height = 185
    Caption = 'GroupBox1'
    TabOrder = 0
    object RadioButton1: TRadioButton
      Left = 72
      Top = 56
      Width = 113
      Height = 17
      Caption = 'RadioButton1'
      TabOrder = 0
    end
    object RadioButton2: TRadioButton
      Left = 72
      Top = 96
      Width = 113
      Height = 17
      Caption = 'RadioButton2'
      TabOrder = 1
    end
  end
  object RadioGroup1: TRadioGroup
    Left = 440
    Top = 40
    Width = 185
    Height = 145
    Caption = 'RadioGroup1'
    Items.Strings = (
      'A'
      'B'
      'C')
    TabOrder = 1
  end
end
