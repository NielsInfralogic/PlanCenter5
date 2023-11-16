object FormColordetectionsetup: TFormColordetectionsetup
  Left = 605
  Top = 277
  Caption = 'Color detection system'
  ClientHeight = 270
  ClientWidth = 320
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 229
    Width = 320
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 228
    ExplicitWidth = 316
    object BitBtn1: TBitBtn
      Left = 72
      Top = 8
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 160
      Top = 8
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object ValueListEditor1: TValueListEditor
    Left = 0
    Top = 0
    Width = 320
    Height = 229
    Align = alClient
    KeyOptions = [keyEdit, keyAdd, keyDelete]
    Strings.Strings = (
      'C=.C'
      'C=cyan'
      'C=-C-'
      'K=.K'
      'K=black'
      'K=gray'
      'K=-K-'
      'M=.M'
      'M=magenta'
      'M=-M-'
      'Y=.Y'
      'Y=yellow'
      'Y=-Y-')
    TabOrder = 1
    TitleCaptions.Strings = (
      'Color'
      'Filename part')
    ExplicitWidth = 316
    ExplicitHeight = 228
    ColWidths = (
      150
      147)
    RowHeights = (
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18)
  end
end
