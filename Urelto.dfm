object FormreleaseTo: TFormreleaseTo
  Left = 767
  Top = 260
  BorderStyle = bsDialog
  Caption = 'Release'
  ClientHeight = 324
  ClientWidth = 375
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poMainFormCenter
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 283
    Width = 375
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 282
    ExplicitWidth = 371
    object BitBtn1: TBitBtn
      Left = 107
      Top = 8
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 191
      Top = 8
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
    object BitBtn3: TBitBtn
      Left = 12
      Top = 8
      Width = 75
      Height = 25
      Kind = bkAll
      NumGlyphs = 2
      TabOrder = 2
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 375
    Height = 129
    Align = alTop
    Caption = 'Release to : '
    TabOrder = 1
    ExplicitWidth = 371
    object CheckListBox1: TCheckListBox
      Left = 2
      Top = 15
      Width = 371
      Height = 112
      Align = alClient
      ItemHeight = 17
      TabOrder = 0
      ExplicitWidth = 367
    end
  end
  object RadioGroup1: TRadioGroup
    Left = 0
    Top = 129
    Width = 375
    Height = 154
    Align = alClient
    Caption = 'Device to use'
    TabOrder = 2
    ExplicitWidth = 371
    ExplicitHeight = 153
  end
end
