object FormAddNplatecopies: TFormAddNplatecopies
  Left = 772
  Top = 371
  BorderStyle = bsDialog
  Caption = 'Add multiple plate copies'
  ClientHeight = 107
  ClientWidth = 304
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 304
    Height = 67
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    Caption = 'Number copies to add'
    TabOrder = 0
    object EditNcopies: TEdit
      Left = 106
      Top = 27
      Width = 72
      Height = 21
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      TabOrder = 0
      Text = '1'
    end
    object UpDown1: TUpDown
      Left = 178
      Top = 27
      Width = 16
      Height = 21
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Associate = EditNcopies
      Min = 1
      Max = 29
      Position = 1
      TabOrder = 1
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 67
    Width = 304
    Height = 40
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 74
      Top = 8
      Width = 74
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
      Left = 157
      Top = 8
      Width = 73
      Height = 25
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
end
