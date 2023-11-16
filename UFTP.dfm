object FormFTP: TFormFTP
  Left = 791
  Top = 428
  Caption = 'FormFTP'
  ClientHeight = 292
  ClientWidth = 245
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object IdFTP1: TIdFTP
    OnStatus = IdFTP1Status
    OnConnected = IdFTP1Connected
    IPVersion = Id_IPv4
    ConnectTimeout = 0
    NATKeepAlive.UseKeepAlive = False
    NATKeepAlive.IdleTimeMS = 0
    NATKeepAlive.IntervalMS = 0
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 76
    Top = 64
  end
end
