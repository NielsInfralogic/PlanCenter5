object Formfiletaginfo: TFormfiletaginfo
  Left = 840
  Top = 361
  Caption = 'File information'
  ClientHeight = 311
  ClientWidth = 456
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poMainFormCenter
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 54
    Width = 456
    Height = 216
    Align = alClient
    ScrollBars = ssBoth
    TabOrder = 0
    ExplicitWidth = 452
    ExplicitHeight = 215
  end
  object Panel1: TPanel
    Left = 0
    Top = 270
    Width = 456
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 269
    ExplicitWidth = 452
    object BitBtn1: TBitBtn
      Left = 368
      Top = 9
      Width = 75
      Height = 25
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 0
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 456
    Height = 54
    Align = alTop
    Color = clWhite
    ParentBackground = False
    TabOrder = 2
    ExplicitWidth = 452
    object Label7: TLabel
      Left = 16
      Top = 8
      Width = 309
      Height = 24
      AutoSize = False
      Caption = 'File information'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 24
      Top = 36
      Width = 337
      Height = 13
      AutoSize = False
      Caption = 'This shows the contens of the file / files'
    end
  end
end
