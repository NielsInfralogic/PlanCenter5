object FramePlateframe: TFramePlateframe
  Left = 0
  Top = 0
  Width = 161
  Height = 244
  TabOrder = 0
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 161
    Height = 244
    Align = alClient
    Alignment = taLeftJustify
    AutoSize = True
    BevelInner = bvRaised
    BevelOuter = bvLowered
    BorderWidth = 3
    TabOrder = 0
    OnMouseDown = Panel1MouseDown
    object Panel3: TPanel
      Left = 5
      Top = 5
      Width = 151
      Height = 19
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 115
        Height = 19
        Align = alClient
        Alignment = taLeftJustify
        BevelInner = bvLowered
        BevelOuter = bvNone
        Caption = 'Panel2'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        OnMouseDown = Panel2MouseDown
      end
      object Panel4: TPanel
        Left = 115
        Top = 0
        Width = 36
        Height = 19
        Align = alRight
        BorderWidth = 1
        ParentBackground = False
        TabOrder = 1
        object Image1: TImage
          Left = 2
          Top = 2
          Width = 32
          Height = 15
          Align = alClient
          OnMouseDown = Panel2MouseDown
        end
      end
    end
    object ListViewPages: TListView
      Left = 5
      Top = 24
      Width = 151
      Height = 215
      Align = alClient
      Columns = <
        item
          AutoSize = True
          Caption = 'Edition'
        end
        item
          AutoSize = True
          Caption = 'Section'
        end
        item
          AutoSize = True
          Caption = 'pagename'
        end>
      GridLines = True
      ReadOnly = True
      RowSelect = True
      ShowColumnHeaders = False
      TabOrder = 1
      ViewStyle = vsReport
      OnCustomDrawItem = ListViewPagesCustomDrawItem
      OnMouseDown = ListViewPagesMouseDown
      OnSelectItem = ListViewPagesSelectItem
    end
  end
end
