object FormAutotower: TFormAutotower
  Left = 833
  Top = 457
  BorderStyle = bsDialog
  Caption = 'Automatic tower naming'
  ClientHeight = 125
  ClientWidth = 340
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 40
    Top = 24
    Width = 29
    Height = 13
    Caption = 'Pre fix'
  end
  object Label2: TLabel
    Left = 184
    Top = 24
    Width = 34
    Height = 13
    Caption = 'Post fix'
  end
  object Editprefix: TEdit
    Left = 40
    Top = 40
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object Editppostfix: TEdit
    Left = 184
    Top = 40
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 89
    Top = 76
    Width = 75
    Height = 25
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 2
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 177
    Top = 76
    Width = 75
    Height = 25
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 3
  end
end
