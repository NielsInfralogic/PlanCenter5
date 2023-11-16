object Formtowerfilter: TFormtowerfilter
  Left = 448
  Top = 405
  BorderStyle = bsDialog
  Caption = 'Tower filter'
  ClientHeight = 320
  ClientWidth = 286
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
    Left = 12
    Top = 8
    Width = 51
    Height = 13
    Caption = 'Filter name'
  end
  object Label2: TLabel
    Left = 12
    Top = 56
    Width = 35
    Height = 13
    Caption = 'Towers'
  end
  object Editname: TEdit
    Left = 12
    Top = 24
    Width = 257
    Height = 21
    TabOrder = 0
  end
  object CheckListBoxtowers: TCheckListBox
    Left = 12
    Top = 72
    Width = 253
    Height = 193
    ItemHeight = 13
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 279
    Width = 286
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object BitBtn1: TBitBtn
      Left = 61
      Top = 8
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 149
      Top = 8
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
end
