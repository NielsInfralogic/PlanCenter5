object FormReimageReason: TFormReimageReason
  Left = 670
  Top = 428
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Re-image reason'
  ClientHeight = 181
  ClientWidth = 212
  Color = clBtnFace
  ParentFont = True
  Position = poMainFormCenter
  OnActivate = FormActivate
  TextHeight = 15
  object BitBtn1: TBitBtn
    Left = 14
    Top = 149
    Width = 83
    Height = 25
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 0
  end
  object BitBtn2: TBitBtn
    Left = 109
    Top = 149
    Width = 83
    Height = 25
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 1
  end
  object RadioGroup1: TRadioGroup
    Left = 14
    Top = 6
    Width = 179
    Height = 129
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Reason for re-image'
    TabOrder = 2
  end
  object RadioButtonReimageReason2: TRadioButton
    Left = 26
    Top = 42
    Width = 154
    Height = 16
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Page version change'
    TabOrder = 3
    OnClick = RadioButtonReimageReason2Click
  end
  object RadioButtonReimageReason1: TRadioButton
    Left = 26
    Top = 23
    Width = 143
    Height = 15
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Damaged plate'
    Checked = True
    TabOrder = 4
    TabStop = True
    OnClick = RadioButtonReimageReason1Click
  end
  object RadioButtonReimageReason3: TRadioButton
    Left = 26
    Top = 62
    Width = 64
    Height = 17
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Other'
    TabOrder = 5
    OnClick = RadioButtonReimageReason3Click
  end
  object EditReimageReason: TEdit
    Left = 26
    Top = 83
    Width = 154
    Height = 23
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    TabOrder = 6
  end
  object CheckBoxReleaseNow: TCheckBox
    Left = 26
    Top = 109
    Width = 116
    Height = 20
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Release now'
    TabOrder = 7
  end
end
