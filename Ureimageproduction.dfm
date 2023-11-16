object Formreimageproduction: TFormreimageproduction
  Left = 405
  Top = 475
  BorderStyle = bsDialog
  Caption = 'Reimage production'
  ClientHeight = 98
  ClientWidth = 237
  Color = clBtnFace
  ParentFont = True
  Position = poMainFormCenter
  TextHeight = 15
  object CheckBox1: TCheckBox
    Left = 31
    Top = 21
    Width = 135
    Height = 17
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Reset device'
    Checked = True
    State = cbChecked
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 31
    Top = 56
    Width = 75
    Height = 24
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 1
  end
  object BitBtn2: TBitBtn
    Left = 125
    Top = 56
    Width = 73
    Height = 24
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 2
  end
end
