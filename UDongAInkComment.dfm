object FormdongAink: TFormdongAink
  Left = 697
  Top = 363
  BorderStyle = bsDialog
  Caption = 'Change Ink number'
  ClientHeight = 245
  ClientWidth = 566
  Color = clBtnFace
  ParentFont = True
  Position = poScreenCenter
  TextHeight = 15
  object BitBtn1: TBitBtn
    Left = 201
    Top = 213
    Width = 73
    Height = 25
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 287
    Top = 213
    Width = 75
    Height = 25
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 1
  end
  object ListView1: TListView
    Left = 12
    Top = 20
    Width = 339
    Height = 166
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Columns = <
      item
        AutoSize = True
        Caption = 'Section'
      end
      item
        AutoSize = True
        Caption = 'Page 1 ='
      end>
    GridLines = True
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    TabOrder = 2
    ViewStyle = vsReport
  end
  object GroupBox1: TGroupBox
    Left = 366
    Top = 20
    Width = 175
    Height = 87
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Page 1='
    TabOrder = 3
    object EditsectionOffset: TEdit
      Left = 12
      Top = 20
      Width = 48
      Height = 23
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      TabOrder = 0
      Text = '1'
    end
    object UpDown1: TUpDown
      Left = 60
      Top = 20
      Width = 16
      Height = 23
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Associate = EditsectionOffset
      Min = 1
      Max = 1000
      Position = 1
      TabOrder = 1
    end
    object Button1: TButton
      Left = 82
      Top = 16
      Width = 75
      Height = 24
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Apply'
      TabOrder = 2
      OnClick = Button1Click
    end
    object Button3: TButton
      Left = 82
      Top = 55
      Width = 75
      Height = 25
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Reset'
      TabOrder = 3
      OnClick = Button3Click
    end
  end
end
