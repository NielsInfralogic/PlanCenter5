object FormReprocesspages: TFormReprocesspages
  Left = 807
  Top = 238
  BorderStyle = bsDialog
  Caption = 'Re-process page(s)'
  ClientHeight = 316
  ClientWidth = 233
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnCanResize = FormCanResize
  OnCreate = FormCreate
  TextHeight = 13
  object Panelsys: TPanel
    Left = 0
    Top = 245
    Width = 233
    Height = 68
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 237
    object BitBtn1: TBitBtn
      Left = 44
      Top = 38
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 125
      Top = 38
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
    object CheckBoxDeleteExistingPage: TCheckBox
      Left = 8
      Top = 6
      Width = 161
      Height = 17
      Caption = 'Delete existing ripped page'
      TabOrder = 2
    end
  end
  object GroupBoxpreflight: TGroupBox
    Left = 0
    Top = 49
    Width = 233
    Height = 49
    Align = alTop
    Caption = 'Preflight Setup'
    TabOrder = 1
    ExplicitWidth = 237
    object ComboBoxPreflight: TComboBox
      Left = 8
      Top = 16
      Width = 217
      Height = 21
      Style = csDropDownList
      TabOrder = 0
    end
  end
  object GroupBoxRipsetup: TGroupBox
    Left = 0
    Top = 147
    Width = 233
    Height = 49
    Align = alTop
    Caption = 'Rip Setup'
    TabOrder = 2
    ExplicitWidth = 237
    object ComboBoxRipsetup: TComboBox
      Left = 8
      Top = 16
      Width = 217
      Height = 21
      Style = csDropDownList
      TabOrder = 0
    end
  end
  object GroupBoxInksave: TGroupBox
    Left = 0
    Top = 98
    Width = 233
    Height = 49
    Align = alTop
    Caption = 'Inksave Setup'
    TabOrder = 3
    ExplicitWidth = 237
    object ComboBoxInksave: TComboBox
      Left = 8
      Top = 16
      Width = 217
      Height = 21
      Style = csDropDownList
      TabOrder = 0
    end
  end
  object GroupBoxpress: TGroupBox
    Left = 0
    Top = 0
    Width = 233
    Height = 49
    Align = alTop
    Caption = 'Press Group'
    TabOrder = 4
    ExplicitWidth = 237
    object ComboBoxpress: TComboBox
      Left = 8
      Top = 16
      Width = 217
      Height = 21
      Style = csDropDownList
      TabOrder = 0
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 196
    Width = 233
    Height = 49
    Align = alTop
    Caption = 'Page format'
    TabOrder = 5
    ExplicitWidth = 237
    object ComboBoxPageformat: TComboBox
      Left = 8
      Top = 16
      Width = 217
      Height = 21
      Style = csDropDownList
      TabOrder = 0
    end
  end
end
