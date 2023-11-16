object FormStatusView: TFormStatusView
  Left = 569
  Top = 610
  Caption = 'Status View'
  ClientHeight = 711
  ClientWidth = 1289
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBar1: TScrollBar
    Left = 56
    Top = 344
    Width = 17
    Height = 121
    Kind = sbVertical
    PageSize = 0
    TabOrder = 1
    Visible = False
  end
  object ScrollBoxEnhstatus: TScrollBox
    Left = 0
    Top = 0
    Width = 1289
    Height = 711
    HorzScrollBar.Visible = False
    Align = alClient
    PopupMenu = PopupMenUstatuswindow
    TabOrder = 0
  end
  object ActionManager1: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Action = ActionStatusrefresh
            Caption = '&Refresh'
            ImageIndex = 39
          end>
      end
      item
      end>
    Left = 624
    Top = 256
    StyleName = 'XP Style'
    object ActionStatusrefresh: TAction
      Caption = 'Refresh'
      ImageIndex = 39
      OnExecute = ActionStatusrefreshExecute
    end
    object Actiontest: TAction
      Caption = 'test'
      OnExecute = ActiontestExecute
    end
  end
  object PopupMenUstatuswindow: TPopupMenu
    Left = 216
    Top = 240
    object Refresh1: TMenuItem
      Caption = 'Refresh'
      OnClick = Refresh1Click
    end
  end
end
