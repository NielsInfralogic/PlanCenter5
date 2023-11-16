object FormSelectfolderandname: TFormSelectfolderandname
  Left = 753
  Top = 339
  Width = 407
  Height = 432
  BorderIcons = []
  Caption = 'Save file'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object ShellTreeView1: TShellTreeView
    Left = 0
    Top = 0
    Width = 399
    Height = 276
    ObjectTypes = [otFolders]
    Root = 'rfDesktop'
    UseShellImages = True
    Align = alClient
    AutoRefresh = False
    DragMode = dmAutomatic
    Indent = 19
    ParentColor = False
    PopupMenu = PopupMenu1
    RightClickSelect = True
    ShowRoot = False
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 276
    Width = 399
    Height = 122
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 20
      Top = 48
      Width = 97
      Height = 13
      AutoSize = False
      Caption = 'Filename'
    end
    object BitBtn1: TBitBtn
      Left = 120
      Top = 92
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 204
      Top = 92
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkCancel
    end
    object Edit1: TEdit
      Left = 20
      Top = 64
      Width = 353
      Height = 21
      TabOrder = 2
      Text = 'Filename'
      OnChange = Edit1Change
      OnKeyPress = Edit1KeyPress
    end
    object GroupBox1: TGroupBox
      Left = 20
      Top = 12
      Width = 353
      Height = 37
      Caption = 'File type'
      TabOrder = 3
      object CheckBox1: TCheckBox
        Left = 12
        Top = 16
        Width = 97
        Height = 17
        Caption = 'Highres (tif)'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object CheckBox2: TCheckBox
        Left = 152
        Top = 16
        Width = 97
        Height = 17
        Caption = 'Lowres (jpg)'
        TabOrder = 1
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 148
    Top = 92
    object Newfolder1: TMenuItem
      Action = ActionNewfolder
    end
    object Refresh1: TMenuItem
      Action = Actionrefresh
    end
  end
  object ActionManager1: TActionManager
    Left = 360
    Top = 188
    StyleName = 'XP Style'
    object ActionNewfolder: TAction
      Caption = 'New folder'
      ImageIndex = 2
      OnExecute = ActionNewfolderExecute
    end
    object Actionrefresh: TAction
      Caption = 'Refresh'
      ShortCut = 116
      OnExecute = ActionrefreshExecute
    end
  end
end
