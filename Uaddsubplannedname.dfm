object Formapplyedplanname: TFormapplyedplanname
  Left = 727
  Top = 359
  BorderStyle = bsDialog
  Caption = 'Pagename on subedition'
  ClientHeight = 120
  ClientWidth = 378
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox6: TGroupBox
    Left = 8
    Top = 21
    Width = 357
    Height = 48
    Caption = 'Planned name'
    TabOrder = 0
    object Label9: TLabel
      Left = 252
      Top = 16
      Width = 29
      Height = 13
      Caption = 'Week'
    end
    object ComboBoxplannedname: TComboBox
      Left = 8
      Top = 16
      Width = 193
      Height = 21
      Style = csDropDownList
      TabOrder = 0
    end
    object Editweek: TEdit
      Left = 288
      Top = 12
      Width = 41
      Height = 21
      TabOrder = 1
      Text = '50'
    end
    object UpDownweek: TUpDown
      Left = 329
      Top = 12
      Width = 16
      Height = 21
      Associate = Editweek
      Min = 1
      Max = 52
      Position = 50
      TabOrder = 2
    end
  end
  object BitBtn1: TBitBtn
    Left = 148
    Top = 84
    Width = 75
    Height = 25
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 1
  end
end
