object FormSwappos: TFormSwappos
  Left = 702
  Top = 268
  BorderStyle = bsDialog
  Caption = 'Swap pages'
  ClientHeight = 263
  ClientWidth = 254
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
  object GroupBox1: TGroupBox
    Left = 16
    Top = 12
    Width = 225
    Height = 201
    Caption = 'Page postions to swap'
    TabOrder = 0
    object ListView1: TListView
      Left = 2
      Top = 15
      Width = 221
      Height = 184
      Align = alClient
      Checkboxes = True
      Columns = <
        item
          AutoSize = True
          Caption = 'Pagepostion'
        end>
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
  object BitBtn1: TBitBtn
    Left = 40
    Top = 224
    Width = 75
    Height = 25
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 1
  end
  object BitBtn2: TBitBtn
    Left = 132
    Top = 224
    Width = 75
    Height = 25
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 2
  end
end
