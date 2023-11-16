object FormOldver: TFormOldver
  Left = 658
  Top = 345
  Caption = 'Old versions'
  ClientHeight = 438
  ClientWidth = 779
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ActionToolBarunknow: TActionToolBar
    Left = 0
    Top = 0
    Width = 779
    Height = 21
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    ActionManager = ActionManager1
    ColorMap.HighlightColor = clWhite
    ColorMap.BtnSelectedColor = clBtnFace
    ColorMap.UnusedColor = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Spacing = 0
  end
  object PBExListview1: TPBExListview
    Left = 0
    Top = 63
    Width = 779
    Height = 375
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    Columns = <
      item
        Caption = 'Pubdate'
        Width = 102
      end
      item
        Caption = 'Publication'
        Width = 95
      end
      item
        Caption = 'Edition'
        Width = 95
      end
      item
        Caption = 'Section'
        Width = 95
      end
      item
        Caption = 'Page'
        Width = 95
      end
      item
        Caption = 'Version'
        Width = 95
      end
      item
        Caption = 'Color'
        Width = 95
      end
      item
        Caption = 'Current version'
        Width = 95
      end
      item
        Caption = 'Master'
      end
      item
      end
      item
      end
      item
      end
      item
      end>
    GridLines = True
    Items.ItemData = {}
    ReadOnly = True
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
    OnAdvancedCustomDrawItem = PBExListview1AdvancedCustomDrawItem
    OnCompare = PBExListview1Compare
    OnSelectItem = PBExListview1SelectItem
    horzmove = 0
    horzpos = 0
    Vertpos = 0
  end
  object FileListBox1: TFileListBox
    Left = 492
    Top = 114
    Width = 206
    Height = 292
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    ItemHeight = 13
    TabOrder = 2
    Visible = False
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 21
    Width = 779
    Height = 42
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alTop
    Caption = 'Publication'
    TabOrder = 3
    object ComboBoxPubl: TComboBox
      Left = 8
      Top = 16
      Width = 265
      Height = 21
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Style = csDropDownList
      TabOrder = 0
      OnChange = ComboBoxPublChange
    end
  end
  object ActionManager1: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Action = Action1
            Caption = '&Exit'
          end
          item
            Action = Actionrefresh
            Caption = '&Refresh'
            ImageIndex = 39
          end
          item
            Action = ActionUse
            Caption = '&Use'
            ImageIndex = 12
          end
          item
            Caption = '-'
          end
          item
            Action = Actionpreview
            Caption = '&Preview'
            ImageIndex = 60
          end
          item
            Action = Actiondelete
            Caption = '&Delete'
            ImageIndex = 79
          end>
        ActionBar = ActionToolBarunknow
      end>
    Left = 452
    Top = 104
    StyleName = 'XP Style'
    object Actionpreview: TAction
      Caption = 'Preview'
      ImageIndex = 60
      OnExecute = ActionpreviewExecute
    end
    object Actionrefresh: TAction
      Caption = 'Refresh'
      ImageIndex = 39
      OnExecute = ActionrefreshExecute
    end
    object ActionUse: TAction
      Caption = 'Use'
      ImageIndex = 12
      OnExecute = ActionUseExecute
    end
    object Action1: TAction
      Caption = 'Exit'
      OnExecute = Action1Execute
    end
    object Actiondelete: TAction
      Caption = 'Delete'
      ImageIndex = 79
      OnExecute = ActiondeleteExecute
    end
    object Actionpageselect: TAction
      Caption = 'Page select'
      ImageIndex = 15
      OnExecute = ActionpageselectExecute
    end
  end
end
