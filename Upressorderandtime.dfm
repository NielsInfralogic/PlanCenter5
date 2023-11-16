object Formpressorderandtime: TFormpressorderandtime
  Left = 694
  Top = 341
  BorderStyle = bsDialog
  Caption = 'Press order'
  ClientHeight = 165
  ClientWidth = 270
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poMainFormCenter
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 64
    Height = 13
    Caption = 'Order number'
  end
  object Editpressordernumber: TEdit
    Left = 16
    Top = 32
    Width = 229
    Height = 21
    TabOrder = 0
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 60
    Width = 229
    Height = 53
    Caption = 'Press time'
    TabOrder = 1
    object DateTimePicker1: TDateTimePicker
      Left = 12
      Top = 20
      Width = 101
      Height = 21
      Date = 39458.000000000000000000
      Time = 0.690000358787074200
      TabOrder = 0
    end
    object DateTimePicker2: TDateTimePicker
      Left = 120
      Top = 20
      Width = 101
      Height = 21
      Date = 39458.000000000000000000
      Time = 0.690000358787074200
      Kind = dtkTime
      TabOrder = 1
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 124
    Width = 270
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitTop = 123
    ExplicitWidth = 266
    object BitBtn1: TBitBtn
      Left = 60
      Top = 8
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 144
      Top = 8
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
end
