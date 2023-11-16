object Framesingleprev: TFramesingleprev
  Left = 0
  Top = 0
  Width = 320
  Height = 240
  TabOrder = 0
  Visible = False
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 320
    Height = 240
    Align = alClient
    Caption = 'GroupBox1'
    TabOrder = 0
    object ImageEnView1: TImageEnView
      Left = 2
      Top = 15
      Width = 316
      Height = 223
      ParentCtl3D = False
      ScrollBars = ssBoth
      OnViewChange = ImageEnView1ViewChange
      MouseInteract = [miZoom, miScroll]
      OnZoomIn = ImageEnView1ZoomIn
      OnZoomOut = ImageEnView1ZoomOut
      Align = alClient
      TabOrder = 0
    end
  end
  object ImageEnIO1: TImageEnIO
    AttachedImageEn = ImageEnView1
    Background = clBtnFace
    PreviewFont.Charset = DEFAULT_CHARSET
    PreviewFont.Color = clWindowText
    PreviewFont.Height = -11
    PreviewFont.Name = 'MS Sans Serif'
    PreviewFont.Style = []
    Left = 88
    Top = 52
  end
  object ImageEnProc1: TImageEnProc
    AttachedImageEn = ImageEnView1
    AutoUndo = False
    Background = clBtnFace
    PreviewFont.Charset = DEFAULT_CHARSET
    PreviewFont.Color = clWindowText
    PreviewFont.Height = -11
    PreviewFont.Name = 'MS Sans Serif'
    PreviewFont.Style = []
    Left = 64
    Top = 96
  end
end
