object Formtabs: TFormtabs
  Left = 668
  Top = 304
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Tabs'
  ClientHeight = 433
  ClientWidth = 670
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poMainFormCenter
  TextHeight = 13
  object GroupBox17: TGroupBox
    Left = 0
    Top = 255
    Width = 670
    Height = 138
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    Caption = 'Visible tabs'
    TabOrder = 0
    object CheckBoxplantab: TCheckBox
      Left = 232
      Top = 35
      Width = 166
      Height = 17
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Planning'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object CheckBoxprodtab: TCheckBox
      Left = 12
      Top = 78
      Width = 166
      Height = 17
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Production'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object CheckBoxplatetab: TCheckBox
      Left = 12
      Top = 59
      Width = 166
      Height = 17
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Plates'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object CheckBoxlogtab: TCheckBox
      Left = 232
      Top = 16
      Width = 166
      Height = 17
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Log'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object CheckBoxpagelist: TCheckBox
      Left = 12
      Top = 20
      Width = 166
      Height = 17
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Page list'
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
    object CheckBoxThumbnailtab: TCheckBox
      Left = 12
      Top = 39
      Width = 166
      Height = 17
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Thumbnails'
      Checked = True
      State = cbChecked
      TabOrder = 5
    end
    object CheckBoxEdtab: TCheckBox
      Left = 232
      Top = 55
      Width = 166
      Height = 17
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Editions'
      Checked = True
      State = cbChecked
      TabOrder = 6
    end
    object CheckBoxreporttab: TCheckBox
      Left = 232
      Top = 75
      Width = 166
      Height = 16
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Report'
      Checked = True
      State = cbChecked
      TabOrder = 7
    end
    object CheckBoxunkowntab: TCheckBox
      Left = 406
      Top = 16
      Width = 166
      Height = 17
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Unknown pages'
      Checked = True
      State = cbChecked
      TabOrder = 8
    end
    object CheckBoxactQtab: TCheckBox
      Left = 406
      Top = 35
      Width = 166
      Height = 17
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Active queue'
      Checked = True
      State = cbChecked
      TabOrder = 9
    end
    object CheckBoxschedule: TCheckBox
      Left = 406
      Top = 76
      Width = 166
      Height = 17
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Schedule'
      TabOrder = 10
      Visible = False
    end
    object BitBtn3: TBitBtn
      Left = 288
      Top = 95
      Width = 74
      Height = 25
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Apply'
      TabOrder = 11
      OnClick = BitBtn3Click
    end
    object CheckBoxStatus: TCheckBox
      Left = 406
      Top = 55
      Width = 95
      Height = 17
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Device view'
      Checked = True
      State = cbChecked
      TabOrder = 12
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 393
    Width = 670
    Height = 40
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 252
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
      Left = 352
      Top = 8
      Width = 74
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
  object ListViewtabs: TListView
    Left = 0
    Top = 0
    Width = 670
    Height = 255
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    Columns = <
      item
        AutoSize = True
        Caption = 'Group'
      end
      item
        AutoSize = True
        Caption = 'Separations'
      end
      item
        AutoSize = True
        Caption = 'Thumbnails'
      end
      item
        AutoSize = True
        Caption = 'Plates'
      end
      item
        AutoSize = True
        Caption = 'Production'
      end
      item
        AutoSize = True
        Caption = 'Edition'
      end
      item
        AutoSize = True
        Caption = 'Planning'
      end
      item
        AutoSize = True
        Caption = 'Log'
      end
      item
        AutoSize = True
        Caption = 'Report'
      end
      item
        AutoSize = True
        Caption = 'Unknow files'
      end
      item
        AutoSize = True
        Caption = 'Active'
      end
      item
        AutoSize = True
        Caption = 'Devices'
      end>
    GridLines = True
    ReadOnly = True
    RowSelect = True
    TabOrder = 2
    ViewStyle = vsReport
    OnSelectItem = ListViewtabsSelectItem
  end
end
