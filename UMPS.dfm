object FormMPS: TFormMPS
  Left = 632
  Top = 414
  BorderStyle = bsDialog
  Caption = 'MPS Settings'
  ClientHeight = 191
  ClientWidth = 278
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 28
    Width = 117
    Height = 13
    Caption = 'MPS Code'
  end
  object Label2: TLabel
    Left = 16
    Top = 80
    Width = 165
    Height = 13
    Caption = 'Press section'
  end
  object Edit1: TEdit
    Left = 16
    Top = 44
    Width = 65
    Height = 21
    TabOrder = 0
    Text = '0'
  end
  object UpDown1: TUpDown
    Left = 81
    Top = 44
    Width = 16
    Height = 21
    Associate = Edit1
    Min = 1
    Max = 999
    Position = 1
    TabOrder = 1
  end
  object Edit2: TEdit
    Left = 16
    Top = 96
    Width = 65
    Height = 21
    TabOrder = 2
    Text = '1'
  end
  object UpDown2: TUpDown
    Left = 81
    Top = 96
    Width = 16
    Height = 21
    Associate = Edit2
    Min = 1
    Max = 999
    Position = 1
    TabOrder = 3
  end
  object Panel1: TPanel
    Left = 0
    Top = 150
    Width = 278
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    object BitBtn1: TBitBtn
      Left = 60
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 144
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkCancel
    end
  end
end
