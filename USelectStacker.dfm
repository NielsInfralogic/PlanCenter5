object Formselectstacker: TFormselectstacker
  Left = 391
  Top = 311
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'Select'
  ClientHeight = 123
  ClientWidth = 296
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object BitBtn1: TBitBtn
    Left = 68
    Top = 84
    Width = 75
    Height = 25
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 154
    Top = 84
    Width = 75
    Height = 25
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Kind = bkCancel
  end
  object ComboBox1: TComboBox
    Left = 20
    Top = 24
    Width = 253
    Height = 21
    Style = csDropDownList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    TabOrder = 2
  end
  object CheckBoxSelectAllPlates: TCheckBox
    Left = 22
    Top = 56
    Width = 185
    Height = 17
    Caption = 'Apply to all plates in edition'
    TabOrder = 3
  end
end
