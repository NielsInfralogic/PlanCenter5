object FormSelectfolder: TFormSelectfolder
  Left = 823
  Top = 300
  BorderIcons = []
  Caption = 'Select folder'
  ClientHeight = 390
  ClientWidth = 391
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 345
    Width = 391
    Height = 45
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object BitBtn2: TBitBtn
      Left = 200
      Top = 10
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 0
      TabStop = False
    end
    object BitBtn1: TBitBtn
      Left = 116
      Top = 10
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 260
    Top = 28
    object Newfolder1: TMenuItem
      Action = ActionNewfolder
    end
    object Refresh1: TMenuItem
      Action = Actionrefresh
    end
  end
  object ActionManager1: TActionManager
    Left = 156
    Top = 64
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
