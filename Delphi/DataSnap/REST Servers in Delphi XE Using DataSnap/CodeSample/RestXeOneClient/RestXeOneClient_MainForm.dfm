object RestClientForm: TRestClientForm
  Left = 0
  Top = 0
  Caption = 'RestXeOneClient'
  ClientHeight = 290
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnManual: TButton
    Left = 32
    Top = 32
    Width = 75
    Height = 25
    Caption = 'Manual'
    TabOrder = 0
    OnClick = btnManualClick
  end
  object edInput: TEdit
    Left = 128
    Top = 34
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'Hello World'
  end
  object btnProxy: TButton
    Left = 32
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Proxy'
    TabOrder = 2
    OnClick = btnProxyClick
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 96
    Top = 128
  end
end
