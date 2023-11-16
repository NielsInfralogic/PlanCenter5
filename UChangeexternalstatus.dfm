object FormChangeextstatus: TFormChangeextstatus
  Left = 1050
  Top = 409
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Change external status'
  ClientHeight = 328
  ClientWidth = 303
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poMainFormCenter
  OnActivate = FormActivate
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 287
    Width = 303
    Height = 41
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 286
    ExplicitWidth = 299
    object BitBtn1: TBitBtn
      Left = 72
      Top = 8
      Width = 74
      Height = 25
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 154
      Top = 8
      Width = 75
      Height = 25
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object ListBox1: TListBox
    Left = 0
    Top = 0
    Width = 303
    Height = 287
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    ItemHeight = 13
    TabOrder = 1
    ExplicitWidth = 299
    ExplicitHeight = 286
  end
end
