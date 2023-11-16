object FrameStatus: TFrameStatus
  Left = 0
  Top = 0
  Width = 579
  Height = 314
  TabOrder = 0
  OnCanResize = FrameCanResize
  object PBExListview1: TPBExListview
    Left = 0
    Top = 0
    Width = 579
    Height = 314
    Align = alClient
    Columns = <
      item
        Caption = 'Ed'
        Width = 51
      end
      item
        Caption = 'Sec'
        Width = 42
      end
      item
        Caption = 'Page'
        Width = 42
      end
      item
        Caption = 'FTP'
        Width = 42
      end
      item
        Caption = 'PRE'
        Width = 42
      end
      item
        Caption = 'INK'
        Width = 42
      end
      item
        Caption = 'RIP'
        Width = 42
      end
      item
        Caption = 'RDY'
        Width = 42
      end
      item
        Caption = 'Appr'
        Width = 42
      end
      item
        Caption = 'CTP'
        Width = 42
      end
      item
        Caption = 'Bend'
        Width = 42
      end
      item
        Caption = 'Sorted'
        Width = 42
      end
      item
        Caption = 'Preset'
        Width = 42
      end
      item
        Width = 20
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    GridLines = True
    HideSelection = False
    ReadOnly = True
    ParentFont = False
    TabOrder = 0
    ViewStyle = vsReport
    OnCustomDrawItem = PBExListview1CustomDrawItem
    OnCustomDrawSubItem = PBExListview1CustomDrawSubItem
    horzmove = 0
    horzpos = 0
    Vertpos = 0
  end
end
