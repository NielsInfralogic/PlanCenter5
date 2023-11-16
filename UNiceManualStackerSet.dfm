object FormNiceManualStackerSet: TFormNiceManualStackerSet
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'Manual stacker definition'
  ClientHeight = 176
  ClientWidth = 210
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 24
    Width = 81
    Height = 13
    Caption = 'Set stacker for C'
  end
  object Label2: TLabel
    Left = 8
    Top = 51
    Width = 82
    Height = 13
    Caption = 'Set stacker for M'
  end
  object Label3: TLabel
    Left = 8
    Top = 78
    Width = 80
    Height = 13
    Caption = 'Set stacker for Y'
  end
  object Label4: TLabel
    Left = 8
    Top = 105
    Width = 80
    Height = 13
    Caption = 'Set stacker for K'
  end
  object ComboBoxC: TComboBox
    Left = 105
    Top = 21
    Width = 80
    Height = 21
    Style = csDropDownList
    TabOrder = 0
    OnChange = ComboBoxCChange
  end
  object ComboBoxM: TComboBox
    Left = 105
    Top = 48
    Width = 80
    Height = 21
    Style = csDropDownList
    TabOrder = 1
  end
  object ComboBoxY: TComboBox
    Left = 105
    Top = 75
    Width = 80
    Height = 21
    Style = csDropDownList
    TabOrder = 2
  end
  object ComboBoxK: TComboBox
    Left = 105
    Top = 102
    Width = 80
    Height = 21
    Style = csDropDownList
    TabOrder = 3
  end
  object BitBtnOK: TBitBtn
    Left = 24
    Top = 143
    Width = 75
    Height = 25
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 4
  end
  object BitBtnCancel: TBitBtn
    Left = 105
    Top = 143
    Width = 75
    Height = 25
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 5
  end
end
