object Formselectdefinition: TFormselectdefinition
  Left = 391
  Top = 311
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'Select'
  ClientHeight = 151
  ClientWidth = 296
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
  object BitBtn1: TBitBtn
    Left = 68
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
    TabOrder = 0
  end
  object BitBtn2: TBitBtn
    Left = 154
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
    TabOrder = 1
  end
  object ComboBox1: TComboBox
    Left = 21
    Top = 22
    Width = 253
    Height = 21
    Style = csDropDownList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object CheckBoxSelectAllPlates: TCheckBox
    Left = 22
    Top = 72
    Width = 185
    Height = 17
    Caption = 'Apply to all plates in edition'
    TabOrder = 3
  end
  object CheckBoxApplyToAllPresses: TCheckBox
    Left = 22
    Top = 50
    Width = 139
    Height = 17
    Caption = 'Apply to all presses'
    Checked = True
    State = cbChecked
    TabOrder = 4
  end
end
