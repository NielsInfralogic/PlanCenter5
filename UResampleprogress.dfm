object Formresampleprogress: TFormresampleprogress
  Left = 569
  Top = 485
  BorderStyle = bsDialog
  Caption = 'Resampling preview'
  ClientHeight = 74
  ClientWidth = 375
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 12
    Width = 357
    Height = 17
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 156
    Top = 36
    Width = 75
    Height = 25
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 1
    OnClick = BitBtn1Click
  end
end
