object FormSelectHalfwebPage: TFormSelectHalfwebPage
  Left = 0
  Top = 0
  AutoSize = True
  BorderIcons = []
  Caption = 'Select halfweb page'
  ClientHeight = 176
  ClientWidth = 281
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
  object RadioGroupPages: TRadioGroup
    Left = 0
    Top = 17
    Width = 281
    Height = 118
    Margins.Left = 10
    Margins.Top = 20
    Align = alClient
    Caption = 'Select page for halfweb'
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 135
    Width = 281
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object BitBtnOK: TBitBtn
      Left = 58
      Top = 8
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtnCancel: TBitBtn
      Left = 146
      Top = 8
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 281
    Height = 17
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
  end
end
