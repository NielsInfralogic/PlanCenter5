object Formpressruninfo: TFormpressruninfo
  Left = 742
  Top = 344
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Press run info'
  ClientHeight = 168
  ClientWidth = 254
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 24
    Width = 157
    Height = 13
    AutoSize = False
    Caption = 'Press run comment'
  end
  object Label2: TLabel
    Left = 16
    Top = 76
    Width = 197
    Height = 13
    AutoSize = False
    Caption = 'Press config name'
  end
  object ComboBoxComment: TComboBox
    Left = 16
    Top = 40
    Width = 225
    Height = 21
    TabOrder = 0
  end
  object ComboBoxPressConfigname: TComboBox
    Left = 16
    Top = 92
    Width = 225
    Height = 21
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 44
    Top = 132
    Width = 75
    Height = 25
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 2
  end
  object BitBtn2: TBitBtn
    Left = 132
    Top = 132
    Width = 75
    Height = 25
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 3
  end
end
