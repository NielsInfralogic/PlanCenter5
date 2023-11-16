object FormEdit2upPlate: TFormEdit2upPlate
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'Edit pages on plate'
  ClientHeight = 179
  ClientWidth = 237
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 18
    Top = 106
    Width = 203
    Height = 13
    Caption = 'Use digit 0 for dummy page (halfweb filler)'
  end
  object BitBtnCancel: TBitBtn
    Left = 130
    Top = 133
    Width = 74
    Height = 25
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 0
  end
  object BitBtnOK: TBitBtn
    Left = 41
    Top = 133
    Width = 75
    Height = 25
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 1
    OnClick = BitBtnOKClick
  end
  object GroupBox1: TGroupBox
    Left = 24
    Top = 16
    Width = 89
    Height = 73
    Caption = 'Pos1'
    TabOrder = 2
    object EditPos1: TEdit
      Left = 29
      Top = 32
      Width = 28
      Height = 21
      Alignment = taCenter
      NumbersOnly = True
      TabOrder = 0
      Text = '1'
      OnChange = EditPosChange
    end
  end
  object GroupBox2: TGroupBox
    Left = 119
    Top = 16
    Width = 89
    Height = 73
    Caption = 'Pos2'
    TabOrder = 3
    object EditPos2: TEdit
      Left = 29
      Top = 32
      Width = 28
      Height = 21
      Alignment = taCenter
      NumbersOnly = True
      TabOrder = 0
      Text = '1'
      OnChange = EditPosChange
    end
  end
end
