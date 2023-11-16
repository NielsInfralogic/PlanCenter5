object FormSelectPaginationStyle: TFormSelectPaginationStyle
  Left = 0
  Top = 0
  BorderIcons = [biMinimize, biMaximize]
  Caption = 'Combine to single pressrun'
  ClientHeight = 141
  ClientWidth = 402
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
    Left = 247
    Top = 28
    Width = 115
    Height = 13
    Caption = '1..24: A1-8,B1-8,A9-16'
  end
  object Label2: TLabel
    Left = 247
    Top = 54
    Width = 88
    Height = 13
    Caption = '1..24: A1-16,B1-8'
  end
  object Label3: TLabel
    Left = 247
    Top = 78
    Width = 125
    Height = 13
    Caption = '1..16: A1-16 + 1..8: B1-8'
  end
  object BitBtnCancel: TBitBtn
    Left = 210
    Top = 108
    Width = 75
    Height = 25
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Kind = bkCancel
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 0
  end
  object BitBtnOK: TBitBtn
    Left = 124
    Top = 108
    Width = 75
    Height = 25
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Kind = bkOK
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 1
  end
  object RadioGroupMethod: TRadioGroup
    Left = 16
    Top = 8
    Width = 225
    Height = 94
    Caption = 'Pagination atyle'
    Items.Strings = (
      'Running-through sections inserted'
      'Running-through section-by-section'
      'Per section pagination')
    TabOrder = 2
  end
end
