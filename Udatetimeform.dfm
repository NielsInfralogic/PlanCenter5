object Formdatetimetool: TFormdatetimetool
  Left = 780
  Top = 354
  AutoSize = True
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'Date time'
  ClientHeight = 257
  ClientWidth = 401
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
  object Panel2: TPanel
    Left = 0
    Top = 181
    Width = 401
    Height = 76
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 121
      Top = 43
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 205
      Top = 43
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkCancel
    end
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 401
      Height = 37
      Align = alTop
      Caption = 'Hour minut'
      TabOrder = 2
      object DateTimePicker1: TDateTimePicker
        Left = 150
        Top = 10
        Width = 101
        Height = 21
        Date = 39269.476226666670000000
        Format = 'HH:mm'
        Time = 39269.476226666670000000
        Kind = dtkTime
        TabOrder = 0
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 0
    Width = 401
    Height = 181
    Align = alTop
    Caption = 'Date'
    TabOrder = 1
    object MonthCalendar1: TMonthCalendar
      Left = 2
      Top = 15
      Width = 397
      Height = 154
      Align = alTop
      Date = 39269.564985706020000000
      TabOrder = 0
    end
  end
end
