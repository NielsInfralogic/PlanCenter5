object Formeditweek: TFormeditweek
  Left = 834
  Top = 330
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Edit week number'
  ClientHeight = 108
  ClientWidth = 275
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 104
    Top = 20
    Width = 57
    Height = 21
    TabOrder = 0
    Text = '0'
  end
  object UpDown1: TUpDown
    Left = 161
    Top = 20
    Width = 18
    Height = 21
    Associate = Edit1
    Max = 10000
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 56
    Top = 64
    Width = 75
    Height = 25
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 2
  end
  object BitBtn2: TBitBtn
    Left = 144
    Top = 64
    Width = 75
    Height = 25
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 3
  end
end
