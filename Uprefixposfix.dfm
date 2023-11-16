object FormPrepostfix: TFormPrepostfix
  Left = 667
  Top = 403
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'Pagenames'
  ClientHeight = 79
  ClientWidth = 355
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 12
    Width = 26
    Height = 13
    Caption = 'Prefix'
  end
  object Label2: TLabel
    Left = 176
    Top = 12
    Width = 31
    Height = 13
    Caption = 'Postfix'
  end
  object Panel1: TPanel
    Left = 0
    Top = 38
    Width = 355
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitTop = 26
    ExplicitWidth = 347
    object BitBtn1: TBitBtn
      Left = 101
      Top = 8
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 185
      Top = 8
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object Editprefix: TEdit
    Left = 44
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object editpostfix: TEdit
    Left = 212
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 1
  end
end
