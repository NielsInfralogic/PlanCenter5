object Formfuskdeletebar: TFormfuskdeletebar
  Left = 828
  Top = 421
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Deleting files'
  ClientHeight = 110
  ClientWidth = 312
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 312
    Height = 110
    Align = alClient
    TabOrder = 0
    object ProgressBar1: TProgressBar
      Left = 8
      Top = 76
      Width = 289
      Height = 17
      TabOrder = 0
    end
    object GroupBox2: TGroupBox
      Left = 43
      Top = 12
      Width = 105
      Height = 45
      Caption = 'Files'
      TabOrder = 1
      object Panel1: TPanel
        Left = 2
        Top = 15
        Width = 101
        Height = 28
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
      end
    end
    object GroupBox3: TGroupBox
      Left = 163
      Top = 12
      Width = 105
      Height = 45
      Caption = 'File folders'
      TabOrder = 2
      object Panel2: TPanel
        Left = 2
        Top = 15
        Width = 101
        Height = 28
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
      end
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 5
    OnTimer = Timer1Timer
    Left = 212
    Top = 36
  end
end
