object FormReprocessSimple: TFormReprocessSimple
  Left = 935
  Top = 254
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Process parameters'
  ClientHeight = 194
  ClientWidth = 280
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnCanResize = FormCanResize
  PixelsPerInch = 96
  TextHeight = 13
  object Panelsys: TPanel
    Left = 0
    Top = 147
    Width = 280
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 60
      Top = 8
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 151
      Top = 8
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object GroupBoxpreflight: TGroupBox
    Left = 0
    Top = 0
    Width = 280
    Height = 49
    Align = alTop
    Caption = 'Preflight Setup'
    TabOrder = 1
    object ComboBoxPreflight: TComboBox
      Left = 16
      Top = 16
      Width = 249
      Height = 21
      Style = csDropDownList
      TabOrder = 0
    end
  end
  object GroupBoxRipsetup: TGroupBox
    Left = 0
    Top = 98
    Width = 280
    Height = 49
    Align = alTop
    Caption = 'Rip Setup'
    TabOrder = 2
    object ComboBoxRipsetup: TComboBox
      Left = 16
      Top = 16
      Width = 249
      Height = 21
      Style = csDropDownList
      TabOrder = 0
    end
  end
  object GroupBoxInksave: TGroupBox
    Left = 0
    Top = 49
    Width = 280
    Height = 49
    Align = alTop
    Caption = 'Inksave Setup'
    TabOrder = 3
    object ComboBoxInksave: TComboBox
      Left = 16
      Top = 16
      Width = 249
      Height = 21
      Style = csDropDownList
      TabOrder = 0
    end
  end
end
