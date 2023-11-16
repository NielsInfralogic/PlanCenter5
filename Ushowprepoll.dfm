object Formprepollmessages: TFormprepollmessages
  Left = 827
  Top = 455
  BorderStyle = bsDialog
  Caption = 'Prepoll messages'
  ClientHeight = 301
  ClientWidth = 449
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poMainFormCenter
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 260
    Width = 449
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 259
    ExplicitWidth = 445
    object BitBtn1: TBitBtn
      Left = 364
      Top = 9
      Width = 75
      Height = 25
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 0
    end
  end
  object RichEdit1: TRichEdit
    Left = 0
    Top = 23
    Width = 449
    Height = 237
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 1
    ExplicitWidth = 445
    ExplicitHeight = 236
  end
  object ActionToolBar1: TActionToolBar
    Left = 0
    Top = 0
    Width = 449
    Height = 23
    ActionManager = ActionManager1
    Caption = 'ActionToolBar1'
    Color = clMenuBar
    ColorMap.DisabledFontColor = 10461087
    ColorMap.HighlightColor = clWhite
    ColorMap.BtnSelectedFont = clBlack
    ColorMap.UnusedColor = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Spacing = 0
    ExplicitWidth = 445
  end
  object ActionManager1: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Action = Action2
            Caption = '&Save'
            ImageIndex = 17
          end
          item
            Action = Action1
            Caption = '&Print'
            ImageIndex = 135
          end>
        ActionBar = ActionToolBar1
      end>
    Left = 160
    Top = 44
    StyleName = 'XP Style'
    object Action1: TAction
      Caption = 'Print'
      ImageIndex = 135
      OnExecute = Action1Execute
    end
    object Action2: TAction
      Caption = 'Save'
      ImageIndex = 17
      OnExecute = Action2Execute
    end
  end
end
