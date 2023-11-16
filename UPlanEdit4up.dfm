object FormEdit4upPlate: TFormEdit4upPlate
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Edit pages on plate'
  ClientHeight = 253
  ClientWidth = 230
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
    Left = 10
    Top = 179
    Width = 203
    Height = 13
    Caption = 'Use digit 0 for dummy page (halfweb filler)'
  end
  object BitBtnCancel: TBitBtn
    Left = 122
    Top = 208
    Width = 74
    Height = 25
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 0
  end
  object BitBtnOK: TBitBtn
    Left = 33
    Top = 208
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
  object GroupBox3: TGroupBox
    Left = 24
    Top = 95
    Width = 89
    Height = 73
    Caption = 'Pos3'
    TabOrder = 4
    object EditPos3: TEdit
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
  object GroupBox4: TGroupBox
    Left = 119
    Top = 95
    Width = 89
    Height = 73
    Caption = 'Pos4'
    TabOrder = 5
    object EditPos4: TEdit
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
