object Formplaneditpagename: TFormplaneditpagename
  Left = 515
  Top = 243
  BorderStyle = bsToolWindow
  Caption = 'Edit pagename'
  ClientHeight = 111
  ClientWidth = 188
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  TextHeight = 13
  object Label2: TLabel
    Left = 12
    Top = 39
    Width = 144
    Height = 13
    Caption = '(Enter 0 to make dummy page)'
    Visible = False
  end
  object BitBtn1: TBitBtn
    Left = 9
    Top = 68
    Width = 74
    Height = 25
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 0
  end
  object BitBtn2: TBitBtn
    Left = 93
    Top = 68
    Width = 74
    Height = 25
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 12
    Top = 12
    Width = 149
    Height = 21
    TabOrder = 2
  end
  object Edit2: TEdit
    Left = 152
    Top = 12
    Width = 85
    Height = 21
    TabOrder = 3
    Visible = False
  end
end
