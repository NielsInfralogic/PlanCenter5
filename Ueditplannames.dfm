object FormEditplannames: TFormEditplannames
  Left = 723
  Top = 231
  BorderStyle = bsDialog
  Caption = 'Edit plan names'
  ClientHeight = 229
  ClientWidth = 283
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poMainFormCenter
  OnActivate = FormActivate
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 60
    Width = 253
    Height = 13
    AutoSize = False
    Caption = 'New planname'
  end
  object Label2: TLabel
    Left = 16
    Top = 112
    Width = 253
    Height = 13
    AutoSize = False
    Caption = 'New press system name'
  end
  object Panel1: TPanel
    Left = 0
    Top = 188
    Width = 283
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 187
    ExplicitWidth = 279
    object BitBtn1: TBitBtn
      Left = 194
      Top = 8
      Width = 75
      Height = 25
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 0
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 283
    Height = 45
    Align = alTop
    Caption = 'Plans'
    TabOrder = 1
    ExplicitWidth = 279
    object ComboBox1: TComboBox
      Left = 8
      Top = 16
      Width = 261
      Height = 21
      Style = csDropDownList
      TabOrder = 0
      OnChange = ComboBox1Change
    end
  end
  object Edit1: TEdit
    Left = 16
    Top = 76
    Width = 253
    Height = 21
    TabOrder = 2
  end
  object Edit2: TEdit
    Left = 16
    Top = 128
    Width = 253
    Height = 21
    TabOrder = 3
  end
  object BitBtn2: TBitBtn
    Left = 108
    Top = 156
    Width = 75
    Height = 25
    Caption = 'Apply'
    TabOrder = 4
    OnClick = BitBtn2Click
  end
  object ListBox1: TListBox
    Left = 208
    Top = 48
    Width = 57
    Height = 97
    ItemHeight = 13
    TabOrder = 5
    Visible = False
  end
end
