object Formfalsespread: TFormfalsespread
  Left = 736
  Top = 428
  BorderStyle = bsDialog
  Caption = 'Page spread'
  ClientHeight = 317
  ClientWidth = 330
  Color = clBtnFace
  ParentFont = True
  Position = poMainFormCenter
  OnActivate = FormActivate
  TextHeight = 15
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 330
    Height = 53
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alTop
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 326
    object Label7: TLabel
      Left = 12
      Top = 8
      Width = 154
      Height = 24
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Set page spread'
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
      Caption = 'Set page to false or normal spread'
    end
  end
  object RadioGrouponoff: TRadioGroup
    Left = 0
    Top = 53
    Width = 330
    Height = 46
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alTop
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'False spread'
      'Nornal spread')
    TabOrder = 1
    ExplicitTop = 57
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 99
    Width = 330
    Height = 177
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    Caption = 'Marks ON / OFF'
    TabOrder = 2
    ExplicitTop = 103
    ExplicitWidth = 326
    ExplicitHeight = 172
    object CheckListBoxmarkgroups: TCheckListBox
      Left = 2
      Top = 17
      Width = 326
      Height = 158
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      ItemHeight = 17
      TabOrder = 0
      ExplicitWidth = 322
      ExplicitHeight = 153
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 276
    Width = 330
    Height = 41
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    TabOrder = 3
    ExplicitTop = 275
    ExplicitWidth = 326
    object BitBtn1: TBitBtn
      Left = 90
      Top = 7
      Width = 75
      Height = 24
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
      Left = 174
      Top = 7
      Width = 73
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
end
