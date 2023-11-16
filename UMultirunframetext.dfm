object FrameMultiruntext: TFrameMultiruntext
  Left = 0
  Top = 0
  Width = 157
  Height = 305
  TabOrder = 0
  object Panelactive: TPanel
    Left = 0
    Top = 0
    Width = 157
    Height = 305
    Align = alClient
    AutoSize = True
    BevelOuter = bvNone
    BorderWidth = 3
    Color = clActiveCaption
    TabOrder = 0
    object GroupBox2: TGroupBox
      Left = 3
      Top = 3
      Width = 151
      Height = 69
      Align = alTop
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBackground = False
      ParentColor = False
      ParentFont = False
      TabOrder = 0
      OnMouseDown = GroupBox2MouseDown
      object Panel3: TPanel
        Left = 2
        Top = 15
        Width = 99
        Height = 52
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
        OnMouseDown = GroupBox2MouseDown
        object Label6: TLabel
          Left = 0
          Top = 13
          Width = 99
          Height = 13
          Align = alTop
          Caption = 'Plates ready'
          OnMouseDown = GroupBox2MouseDown
        end
        object Label8: TLabel
          Left = 0
          Top = 0
          Width = 99
          Height = 13
          Align = alTop
          Caption = 'Necessary plates'
          OnMouseDown = GroupBox2MouseDown
        end
        object Label1: TLabel
          Left = 0
          Top = 26
          Width = 99
          Height = 13
          Align = alTop
          Caption = 'Plates imaged'
          OnMouseDown = GroupBox2MouseDown
        end
        object Label2: TLabel
          Left = 0
          Top = 39
          Width = 99
          Height = 13
          Align = alTop
          Caption = 'Plates missing'
          OnMouseDown = GroupBox2MouseDown
        end
      end
      object Panel2: TPanel
        Left = 101
        Top = 15
        Width = 48
        Height = 52
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        OnMouseDown = GroupBox2MouseDown
        object LabelPlatesready: TLabel
          Left = 0
          Top = 13
          Width = 48
          Height = 13
          Align = alTop
          Caption = 'Plates ready'
          OnMouseDown = GroupBox2MouseDown
        end
        object LabelNness: TLabel
          Left = 0
          Top = 0
          Width = 48
          Height = 13
          Align = alTop
          Caption = 'Necessary plates'
          OnMouseDown = GroupBox2MouseDown
        end
        object Labelplatesimaged: TLabel
          Left = 0
          Top = 26
          Width = 48
          Height = 13
          Align = alTop
          Caption = 'Plates imaged'
          OnMouseDown = GroupBox2MouseDown
        end
        object Labelplatesmissing: TLabel
          Left = 0
          Top = 39
          Width = 48
          Height = 13
          Align = alTop
          Caption = 'Labelplatesmissing'
          OnMouseDown = GroupBox2MouseDown
        end
      end
    end
  end
  object ImageListplates: TImageList
    Height = 120
    Width = 100
    Left = 356
    Top = 80
  end
  object Timer1: TTimer
    Enabled = False
    Left = 424
    Top = 36
  end
end
