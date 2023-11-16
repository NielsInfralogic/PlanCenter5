object Formsetdeadline: TFormsetdeadline
  Left = 961
  Top = 364
  BorderStyle = bsDialog
  Caption = 'Set dealline'
  ClientHeight = 101
  ClientWidth = 278
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
  object DateTimePicker1: TDateTimePicker
    Left = 40
    Top = 20
    Width = 96
    Height = 21
    Date = 36516.000000000000000000
    Time = 0.414068460646376500
    TabOrder = 0
  end
  object DateTimePicker2: TDateTimePicker
    Left = 152
    Top = 20
    Width = 81
    Height = 21
    Date = 38708.000000000000000000
    Time = 0.414103344897739600
    Kind = dtkTime
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 60
    Width = 278
    Height = 41
    Align = alBottom
    TabOrder = 2
    object BitBtn1: TBitBtn
      Left = 64
      Top = 8
      Width = 77
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 152
      Top = 8
      Width = 77
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
end
