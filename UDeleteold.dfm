object FormDeleteold: TFormDeleteold
  Left = 605
  Top = 368
  BorderStyle = bsDialog
  Caption = 'Delete all older than'
  ClientHeight = 219
  ClientWidth = 251
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
  object Panel1: TPanel
    Left = 0
    Top = 178
    Width = 251
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 44
      Top = 8
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 128
      Top = 8
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 251
    Height = 178
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Panel3: TPanel
      Left = 28
      Top = 10
      Width = 195
      Height = 158
      AutoSize = True
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Caption = 'Panel3'
      TabOrder = 0
      object MonthCalendar1: TMonthCalendar
        Left = 2
        Top = 2
        Width = 191
        Height = 154
        Align = alClient
        Date = 38522.000000000000000000
        TabOrder = 0
      end
    end
  end
end
