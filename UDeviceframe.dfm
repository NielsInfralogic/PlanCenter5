object FrameDevice: TFrameDevice
  Left = 0
  Top = 0
  Width = 747
  Height = 207
  TabOrder = 0
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 747
    Height = 207
    Align = alClient
    TabOrder = 0
    object GroupBox2: TGroupBox
      Left = 2
      Top = 15
      Width = 151
      Height = 190
      Align = alLeft
      Caption = 'Device'
      TabOrder = 0
      object Label1: TLabel
        Left = 8
        Top = 48
        Width = 45
        Height = 13
        Caption = 'Workload'
        Visible = False
      end
      object Label2: TLabel
        Left = 8
        Top = 92
        Width = 31
        Height = 13
        Caption = 'Status'
        Visible = False
      end
      object Label3: TLabel
        Left = 8
        Top = 136
        Width = 38
        Height = 13
        Caption = 'Enabled'
        Visible = False
      end
      object EditDevname: TEdit
        Left = 8
        Top = 20
        Width = 121
        Height = 21
        TabOrder = 0
      end
      object Editworkload: TEdit
        Left = 8
        Top = 64
        Width = 121
        Height = 21
        TabOrder = 1
        Visible = False
      end
      object Editstatus: TEdit
        Left = 8
        Top = 108
        Width = 121
        Height = 21
        TabOrder = 2
        Visible = False
      end
      object EditEnabled: TEdit
        Left = 8
        Top = 152
        Width = 121
        Height = 21
        TabOrder = 3
        Visible = False
      end
    end
    object ListView1: TListView
      Left = 153
      Top = 15
      Width = 592
      Height = 190
      Align = alClient
      Columns = <
        item
          Caption = 'Status'
        end
        item
          Caption = 'Type'
          Width = 100
        end
        item
          AutoSize = True
          Caption = 'Plate'
        end
        item
          Caption = 'Color'
        end
        item
          Caption = 'Prioriy'
        end>
      GridLines = True
      HideSelection = False
      MultiSelect = True
      RowSelect = True
      TabOrder = 1
      ViewStyle = vsReport
      OnSelectItem = ListView1SelectItem
    end
  end
  object PopupActionBarExedtions: TPopupActionBar
    Left = 184
    Top = 61
    object Priority1: TMenuItem
    end
    object Hold1: TMenuItem
    end
  end
end
