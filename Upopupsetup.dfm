object FormPopupsetup: TFormPopupsetup
  Left = 667
  Top = 574
  BorderStyle = bsDialog
  Caption = 'Popup menues'
  ClientHeight = 285
  ClientWidth = 287
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object CheckListBoxvisible: TCheckListBox
    Left = 4
    Top = 24
    Width = 281
    Height = 217
    ItemHeight = 13
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 244
    Width = 287
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 62
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 150
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object ComboBoxmenues: TComboBox
    Left = 0
    Top = 0
    Width = 285
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 2
  end
end
