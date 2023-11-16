object Formdeletepressplan: TFormdeletepressplan
  Left = 807
  Top = 243
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Delete press plan'
  ClientHeight = 505
  ClientWidth = 399
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
  object ListBox1: TListBox
    Left = 0
    Top = 0
    Width = 399
    Height = 464
    Align = alClient
    ItemHeight = 13
    MultiSelect = True
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 464
    Width = 399
    Height = 41
    Align = alBottom
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 120
      Top = 8
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 204
      Top = 8
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object ListBox2: TListBox
    Left = 232
    Top = 32
    Width = 119
    Height = 428
    ItemHeight = 13
    TabOrder = 2
    Visible = False
  end
end
