object FrameDevicecontrol: TFrameDevicecontrol
  Left = 0
  Top = 0
  Width = 148
  Height = 137
  AutoSize = True
  TabOrder = 0
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 148
    Height = 8
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
  end
  object Panel3: TPanel
    Left = 0
    Top = 8
    Width = 148
    Height = 129
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = clWhite
    TabOrder = 1
    object LabelDevame: TLabel
      Left = 2
      Top = 2
      Width = 144
      Height = 13
      Align = alTop
      Caption = 'Device name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 75
    end
    object Panel1: TPanel
      Left = 2
      Top = 15
      Width = 144
      Height = 48
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 0
      OnDblClick = Image1DblClick
      object Image1: TImage
        Left = 20
        Top = 0
        Width = 50
        Height = 48
        Align = alLeft
        Center = True
        Transparent = True
        OnDblClick = Image1DblClick
      end
      object Image2: TImage
        Left = 0
        Top = 0
        Width = 20
        Height = 48
        Align = alLeft
        Center = True
        Transparent = True
        OnDblClick = Image1DblClick
      end
    end
    object ListBox1: TListBox
      Left = 2
      Top = 63
      Width = 144
      Height = 20
      Align = alTop
      Color = clGradientInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      PopupMenu = PopupMenupress
      Sorted = True
      TabOrder = 1
      OnExit = ListBox1Exit
    end
    object GroupBox1: TGroupBox
      Left = 2
      Top = 83
      Width = 144
      Height = 38
      Align = alTop
      Caption = 'Jobs in queue'
      TabOrder = 2
      object Paneljobingueue: TPanel
        Left = 2
        Top = 15
        Width = 140
        Height = 21
        Align = alClient
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 0
      end
    end
  end
  object PopupMenupress: TPopupMenu
    Left = 100
    Top = 28
    object Addpress1: TMenuItem
      Caption = 'Add press'
      OnClick = Addpress1Click
    end
    object Removepress1: TMenuItem
      Caption = 'Remove press'
      OnClick = Removepress1Click
    end
  end
end
