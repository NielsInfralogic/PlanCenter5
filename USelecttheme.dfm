object Formselecttheme: TFormselecttheme
  Left = 306
  Top = 259
  Width = 212
  Height = 146
  Caption = 'Select theme'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 12
    Width = 71
    Height = 13
    Caption = 'Program theme'
  end
  object ComboBoxtheme: TComboBox
    Left = 8
    Top = 28
    Width = 185
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 0
    Text = 'Standard XP Theme'
    Items.Strings = (
      'Standard XP Theme'
      'XP Theme 2'
      'XP Theme 3'
      'XP Theme 4'
      'Special 1'
      'Special 2'
      'Special 3'
      'Special 4'
      'Windows')
  end
  object BitBtn1: TBitBtn
    Left = 16
    Top = 68
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 104
    Top = 68
    Width = 75
    Height = 25
    TabOrder = 2
    Kind = bkCancel
  end
end
