object PlanRearrangePages: TPlanRearrangePages
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'Re-organize page sequence'
  ClientHeight = 574
  ClientWidth = 284
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnMouseWheel = FormMouseWheel
  OnMouseWheelDown = FormMouseWheelDown
  OnMouseWheelUp = FormMouseWheelUp
  DesignSize = (
    284
    574)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 64
    Top = 30
    Width = 73
    Height = 13
    Caption = 'Page sequence'
  end
  object Label2: TLabel
    Left = 144
    Top = 30
    Width = 97
    Height = 13
    Caption = 'New page sequence'
  end
  object Label3: TLabel
    Left = 9
    Top = 8
    Width = 267
    Height = 13
    Caption = 'Use drag-drop to re-arrange pages in the right hand list'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBtnText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object BitBtnCancel: TBitBtn
    Left = 144
    Top = 532
    Width = 74
    Height = 25
    Anchors = [akLeft, akBottom]
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 0
  end
  object BitBtnOK: TBitBtn
    Left = 63
    Top = 532
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 1
    OnClick = BitBtnOKClick
  end
  object ListBoxOriginalPages: TSyncListBox
    Left = 64
    Top = 49
    Width = 73
    Height = 437
    Anchors = [akLeft, akTop, akBottom]
    Enabled = False
    ItemHeight = 13
    TabOrder = 2
  end
  object ListBoxNewPages: TSyncListBox
    Left = 143
    Top = 49
    Width = 74
    Height = 437
    Anchors = [akLeft, akTop, akBottom]
    DragMode = dmAutomatic
    ItemHeight = 13
    MultiSelect = True
    TabOrder = 3
    OnClick = ListBoxNewPagesClick
    OnDragDrop = ListBoxNewPagesDragDrop
    OnDragOver = ListBoxNewPagesDragOver
    OnMouseDown = ListBoxNewPagesMouseDown
    OnStartDrag = ListBoxNewPagesStartDrag
    OnScroll = ListBoxNewPagesScroll
  end
  object btnReset: TButton
    Left = 143
    Top = 492
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Reset'
    TabOrder = 4
    OnClick = btnResetClick
  end
end
