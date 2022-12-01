object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 337
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
  object MaskEdit1: TMaskEdit
    Left = 88
    Top = 128
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 0
    Text = 'MaskEdit1'
  end
  object ComboBox1: TComboBox
    Left = 256
    Top = 176
    Width = 145
    Height = 21
    TabOrder = 1
    Text = 'ComboBox1'
    Items.Strings = (
      'Line A'
      'Line B'
      'Line C')
  end
end
