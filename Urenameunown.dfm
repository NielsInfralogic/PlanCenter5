object Formrenamenknown: TFormrenamenknown
  Left = 565
  Top = 683
  BorderStyle = bsDialog
  Caption = 'Rename unknown file'
  ClientHeight = 148
  ClientWidth = 392
  Color = clBtnFace
  ParentFont = True
  Position = poScreenCenter
  TextHeight = 15
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 58
    Height = 12
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Current name'
  end
  object Label2: TLabel
    Left = 16
    Top = 59
    Width = 46
    Height = 12
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'New name'
  end
  object BitBtn1: TBitBtn
    Left = 110
    Top = 108
    Width = 73
    Height = 25
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 2
  end
  object BitBtn2: TBitBtn
    Left = 202
    Top = 108
    Width = 74
    Height = 25
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 3
  end
  object EditCurrent: TEdit
    Left = 16
    Top = 27
    Width = 339
    Height = 23
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    TabStop = False
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 1
  end
  object EditNew: TEdit
    Left = 16
    Top = 75
    Width = 339
    Height = 23
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    TabOrder = 0
  end
end
