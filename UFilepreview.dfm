object Formfilepreview: TFormfilepreview
  Left = 973
  Top = 156
  Caption = 'File preview'
  ClientHeight = 711
  ClientWidth = 684
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 13
  object ImageEn1: TImageEn
    Left = 0
    Top = 23
    Width = 684
    Height = 688
    OnZoomIn = ImageEn1ZoomIn
    OnZoomOut = ImageEn1ZoomOut
    BorderStyle = bsNone
    Align = alClient
    TabOrder = 0
    LegacyBitmap = True
    ZoomFilter = rfLanczos3
    MouseInteractGeneral = [miZoom, miScroll]
    ExplicitWidth = 680
    ExplicitHeight = 687
  end
  object ActionToolBarprevfile: TActionToolBar
    Left = 0
    Top = 0
    Width = 684
    Height = 23
    ActionManager = ActionManager1
    Caption = 'ActionToolBarprevfile'
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
    ExplicitWidth = 680
  end
  object XMLDocument1: TXMLDocument
    Left = 324
    Top = 152
    DOMVendorDesc = 'MSXML'
  end
  object ActionManager1: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Action = Action1
            Caption = '&Close'
          end>
      end
      item
        Items = <
          item
            Action = Action1
            Caption = '&Close'
          end
          item
            Items = <
              item
                Action = Action2
                Caption = '&90 degrees'
              end
              item
                Action = Action3
                Caption = '&180 degrees'
              end
              item
                Action = Action4
                Caption = '&270 degrees'
              end>
            Caption = '&Rotate'
          end
          item
            Action = Action7
            Caption = '&Save'
            ImageIndex = 17
          end>
      end
      item
        Items = <
          item
            Action = Action1
            Caption = '&Close'
          end
          item
            Caption = '-'
          end
          item
            Action = Action7
            Caption = '&Save'
            ImageIndex = 17
          end
          item
            Action = Action5
            Caption = '&Print'
            ImageIndex = 135
          end
          item
            Caption = '-'
          end
          item
            Action = ActionFit
            Caption = '&Fit to screen'
          end
          item
            Action = Action6
            Caption = 'S&how 1:1'
          end
          item
            Caption = '-'
          end
          item
            Action = Action2
            Caption = '&90 degrees'
          end
          item
            Action = Action3
            Caption = '&180 degrees'
          end
          item
            Action = Action4
            Caption = '&270 degrees'
          end
          item
            Caption = '-'
          end
          item
            Action = Action8
            Caption = '&Mirror'
          end>
        ActionBar = ActionToolBarprevfile
      end>
    Left = 204
    Top = 233
    StyleName = 'XP Style'
    object Action1: TAction
      Caption = 'Close'
    end
    object Action2: TAction
      Category = 'Rotate'
      Caption = '90 degrees'
      OnExecute = Action2Execute
    end
    object Action3: TAction
      Category = 'Rotate'
      Caption = '180 degrees'
      OnExecute = Action3Execute
    end
    object Action4: TAction
      Category = 'Rotate'
      Caption = '270 degrees'
      OnExecute = Action4Execute
    end
    object Action7: TAction
      Caption = 'Save'
      ImageIndex = 17
      OnExecute = Action7Execute
    end
    object Action5: TAction
      Caption = 'Print'
      ImageIndex = 135
      OnExecute = Action5Execute
    end
    object ActionFit: TAction
      Caption = 'Fit to screen'
      OnExecute = ActionFitExecute
    end
    object Action6: TAction
      Caption = 'Show 1:1'
      OnExecute = Action6Execute
    end
    object Action8: TAction
      Caption = 'Mirror'
      OnExecute = Action8Execute
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '*.jpg'
    Filter = 'Jpeg|*.jpg|Any file|*.*'
    Left = 372
    Top = 194
  end
  object PrintDialog1: TPrintDialog
    Left = 228
    Top = 162
  end
  object ImageEnProc1: TImageEnProc
    AttachedImageEn = ImageEn1
    Background = clBtnFace
    Left = 88
    Top = 150
  end
end
