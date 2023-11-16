object Framepage: TFramepage
  Left = 0
  Top = 0
  Width = 305
  Height = 29
  Color = clBtnFace
  ParentColor = False
  TabOrder = 0
  object Splitter1: TSplitter
    Left = 173
    Top = 0
    Height = 29
    OnCanResize = Splitter2CanResize
    OnMoved = Splitter1Moved
  end
  object Splitter3: TSplitter
    Left = 41
    Top = 0
    Height = 29
    OnCanResize = Splitter2CanResize
    OnMoved = Splitter1Moved
  end
  object Splitter4: TSplitter
    Left = 217
    Top = 0
    Height = 29
    OnCanResize = Splitter2CanResize
    OnMoved = Splitter1Moved
  end
  object Splitter5: TSplitter
    Left = 85
    Top = 0
    Height = 29
    OnCanResize = Splitter2CanResize
    OnMoved = Splitter1Moved
  end
  object Splitter6: TSplitter
    Left = 129
    Top = 0
    Height = 29
    OnCanResize = Splitter2CanResize
    OnMoved = Splitter1Moved
  end
  object PanelSection: TPanel
    Left = 132
    Top = 0
    Width = 41
    Height = 29
    Align = alLeft
    Alignment = taLeftJustify
    Caption = 'Section'
    TabOrder = 0
  end
  object Panelpagename: TPanel
    Left = 220
    Top = 0
    Width = 85
    Height = 29
    Align = alClient
    Alignment = taLeftJustify
    Caption = 'pagename'
    TabOrder = 1
  end
  object PanelUnique: TPanel
    Left = 176
    Top = 0
    Width = 41
    Height = 29
    Align = alLeft
    Alignment = taLeftJustify
    Caption = 'Unique'
    Color = clLime
    TabOrder = 2
  end
  object Panelstatus: TPanel
    Left = 88
    Top = 0
    Width = 41
    Height = 29
    Align = alLeft
    Alignment = taLeftJustify
    Caption = 'Status'
    TabOrder = 3
  end
  object Panelapprove: TPanel
    Left = 0
    Top = 0
    Width = 41
    Height = 29
    Align = alLeft
    Alignment = taLeftJustify
    Caption = 'Approved'
    Color = clRed
    TabOrder = 4
  end
  object Panelhold: TPanel
    Left = 44
    Top = 0
    Width = 41
    Height = 29
    Align = alLeft
    Alignment = taLeftJustify
    Caption = 'Hold'
    Color = clRed
    TabOrder = 5
  end
end
