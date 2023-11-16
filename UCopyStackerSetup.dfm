object FormCopyStackerSetup: TFormCopyStackerSetup
  Left = 748
  Top = 233
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'Copy stacker/press setting'
  ClientHeight = 209
  ClientWidth = 372
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
    Top = 16
    Width = 191
    Height = 13
    Caption = 'Copy stacker/press settings from edition:'
  end
  object Label2: TLabel
    Left = 16
    Top = 80
    Width = 50
    Height = 13
    Caption = 'To edition:'
  end
  object EditCopyFromName: TEdit
    Left = 16
    Top = 40
    Width = 337
    Height = 21
    ReadOnly = True
    TabOrder = 4
  end
  object ComboBoxToEdition: TComboBox
    Left = 16
    Top = 104
    Width = 177
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
  end
  object BitBtn3: TBitBtn
    Left = 115
    Top = 167
    Width = 75
    Height = 25
    TabOrder = 2
    Kind = bkOK
  end
  object BitBtn1: TBitBtn
    Left = 198
    Top = 167
    Width = 75
    Height = 25
    TabOrder = 3
    Kind = bkCancel
  end
  object CheckBoxApplyToAllPresses: TCheckBox
    Left = 16
    Top = 136
    Width = 113
    Height = 17
    Caption = 'Apply to all presses'
    TabOrder = 1
  end
end
