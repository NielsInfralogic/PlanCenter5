object FormEndiscolors: TFormEndiscolors
  Left = 1054
  Top = 403
  BorderStyle = bsDialog
  Caption = 'Edit colors'
  ClientHeight = 296
  ClientWidth = 241
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 255
    Width = 241
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 50
      Top = 8
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 134
      Top = 8
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object CheckListBoxColors: TCheckListBox
    Left = 0
    Top = 0
    Width = 241
    Height = 255
    Align = alClient
    ItemHeight = 13
    TabOrder = 1
    OnClick = CheckListBoxColorsClick
  end
end
