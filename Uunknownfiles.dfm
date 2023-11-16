object FormUknownfiles: TFormUknownfiles
  Left = -590
  Top = 612
  Caption = 'Unknown files'
  ClientHeight = 435
  ClientWidth = 446
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ActionToolBarunknow: TActionToolBar
    Left = 0
    Top = 0
    Width = 446
    Height = 23
    ActionManager = ActionManager1
    ColorMap.HighlightColor = clWhite
    ColorMap.BtnSelectedColor = clBtnFace
    ColorMap.UnusedColor = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Spacing = 0
  end
  object ListViewunkowfiles: TListView
    Left = 0
    Top = 23
    Width = 446
    Height = 412
    Align = alClient
    Columns = <
      item
        Caption = 'File'
        Width = 238
      end
      item
        Caption = 'Color'
      end
      item
        Caption = 'Folder'
        Width = 236
      end
      item
        Caption = 'Time'
        Width = 236
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end>
    DragMode = dmAutomatic
    GridLines = True
    ReadOnly = True
    RowSelect = True
    PopupMenu = PopupActionBarEx1Unknown
    TabOrder = 1
    ViewStyle = vsReport
    OnAdvancedCustomDrawItem = ListViewunkowfilesAdvancedCustomDrawItem
    OnDblClick = ListViewunkowfilesDblClick
    OnDragOver = ListViewunkowfilesDragOver
    OnKeyDown = ListViewunkowfilesKeyDown
    OnSelectItem = ListViewunkowfilesSelectItem
  end
  object ActionManager1: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Action = ActionRefresh
            Caption = '&Refresh'
            ImageIndex = 39
          end
          item
            Action = Actionpageselect
            Caption = '&Page select'
            ImageIndex = 15
          end
          item
            Caption = '-'
          end
          item
            Action = Actionrename
            Caption = 'Re&name'
            ImageIndex = 101
          end
          item
            Action = Actionpreview
            Caption = 'Pr&eview'
            ImageIndex = 60
          end
          item
            Action = Actionretry
            Caption = 'Re&try file(s)'
            ImageIndex = 180
          end
          item
            Action = Actiondelete
            Caption = '&Delete'
            ImageIndex = 79
          end
          item
            Action = ActionFilter
            Caption = '&Filter (*.*)'
            ImageIndex = 133
          end
          item
            Action = ActionFolder
            Caption = 'F&older'
            ImageIndex = 197
          end>
        ActionBar = ActionToolBarunknow
      end>
    Left = 228
    Top = 104
    StyleName = 'XP Style'
    object ActionRefresh: TAction
      Caption = 'Refresh'
      ImageIndex = 39
      OnExecute = ActionRefreshExecute
    end
    object Actiondelete: TAction
      Caption = 'Delete'
      ImageIndex = 79
      OnExecute = ActiondeleteExecute
    end
    object Actionpreview: TAction
      Caption = 'Preview'
      ImageIndex = 60
      OnExecute = ActionpreviewExecute
    end
    object Actioncolorsystem: TAction
      Caption = 'Color system'
      ImageIndex = 194
      OnExecute = ActioncolorsystemExecute
    end
    object Actionretry: TAction
      Caption = 'Retry file(s)'
      ImageIndex = 180
      OnExecute = ActionretryExecute
    end
    object Actionrename: TAction
      Caption = 'Rename'
      ImageIndex = 101
      OnExecute = ActionrenameExecute
    end
    object ActionSetcolor: TAction
      Caption = 'Set color'
      ImageIndex = 28
    end
    object Actionpageselect: TAction
      Caption = 'Page select'
      ImageIndex = 15
      OnExecute = ActionpageselectExecute
    end
    object ActionFilter: TAction
      Caption = 'Filter (*.*)'
      ImageIndex = 133
      OnExecute = ActionFilterExecute
    end
    object ActionFolder: TAction
      Caption = 'Folder'
      ImageIndex = 197
      OnExecute = ActionFolderExecute
    end
  end
  object PopupActionBarEx1Unknown: TPopupActionBar
    Left = 56
    Top = 161
    object Preview1: TMenuItem
      Action = Actionpreview
    end
    object Rename1: TMenuItem
      Action = Actionrename
    end
    object Setcolor1: TMenuItem
      Action = ActionSetcolor
    end
    object Seachfilter1: TMenuItem
      Action = ActionFilter
    end
    object Folder1: TMenuItem
      Action = ActionFolder
    end
    object Colorsystem1: TMenuItem
      Action = Actioncolorsystem
    end
  end
end
