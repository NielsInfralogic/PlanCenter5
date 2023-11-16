object Formretryfiles: TFormretryfiles
  Left = 503
  Top = 330
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Retry files'
  ClientHeight = 153
  ClientWidth = 307
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Animate1: TAnimate
    Left = 24
    Top = 16
    Width = 272
    Height = 60
    CommonAVI = aviCopyFiles
    StopFrame = 34
  end
  object ProgressBar1: TProgressBar
    Left = 24
    Top = 88
    Width = 273
    Height = 17
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 120
    Top = 116
    Width = 75
    Height = 25
    Kind = bkAbort
    NumGlyphs = 2
    TabOrder = 2
    OnClick = BitBtn1Click
  end
end
