object Formchednameload: TFormchednameload
  Left = 657
  Top = 192
  BorderStyle = bsDialog
  Caption = 'Change edition name'
  ClientHeight = 367
  ClientWidth = 355
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 326
    Width = 355
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 325
    ExplicitWidth = 351
    object BitBtn1: TBitBtn
      Left = 98
      Top = 10
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 182
      Top = 10
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object ListBox1: TListBox
    Left = 0
    Top = 0
    Width = 355
    Height = 326
    Align = alClient
    ItemHeight = 13
    TabOrder = 1
    ExplicitWidth = 351
    ExplicitHeight = 325
  end
end
