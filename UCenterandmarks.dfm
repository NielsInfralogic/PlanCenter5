object FormSetCenterspread: TFormSetCenterspread
  Left = 424
  Top = 381
  BorderStyle = bsDialog
  Caption = 'Set centerspread'
  ClientHeight = 318
  ClientWidth = 405
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poMainFormCenter
  TextHeight = 13
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 405
    Height = 53
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alTop
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 401
    object Label7: TLabel
      Left = 12
      Top = 8
      Width = 160
      Height = 24
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Set centerspread'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -18
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 20
      Top = 35
      Width = 331
      Height = 13
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      AutoSize = False
      Caption = 'Select marks and click ok'
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 277
    Width = 405
    Height = 41
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 276
    ExplicitWidth = 401
    object BitBtn1: TBitBtn
      Left = 123
      Top = 7
      Width = 76
      Height = 24
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 207
      Top = 7
      Width = 74
      Height = 24
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 53
    Width = 405
    Height = 224
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    Caption = 'Marks ON / OFF'
    TabOrder = 2
    ExplicitWidth = 401
    ExplicitHeight = 223
    object CheckListBoxmarkgroups: TCheckListBox
      Left = 2
      Top = 15
      Width = 401
      Height = 207
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      ItemHeight = 17
      TabOrder = 0
      ExplicitWidth = 397
      ExplicitHeight = 206
    end
  end
end
