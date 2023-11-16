object FormChangesectionnamebyload: TFormChangesectionnamebyload
  Left = 836
  Top = 284
  BorderStyle = bsDialog
  Caption = 'Change section name'
  ClientHeight = 287
  ClientWidth = 321
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 246
    Width = 321
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 81
      Top = 8
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 165
      Top = 8
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object ListBox1: TListBox
    Left = 0
    Top = 0
    Width = 321
    Height = 246
    Align = alClient
    ItemHeight = 13
    TabOrder = 1
  end
end
