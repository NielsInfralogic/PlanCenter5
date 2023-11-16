object FrameMultirun: TFrameMultirun
  Left = 0
  Top = 0
  Width = 245
  Height = 245
  AutoSize = True
  TabOrder = 0
  object Panelactive: TPanel
    Left = 0
    Top = 0
    Width = 245
    Height = 245
    Align = alLeft
    BevelOuter = bvNone
    BorderWidth = 3
    Color = clActiveCaption
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 3
      Top = 3
      Width = 239
      Height = 239
      Align = alClient
      Caption = 'GroupBox1'
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
      object GroupBox2: TGroupBox
        Left = 2
        Top = 15
        Width = 235
        Height = 90
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
        object Panel3: TPanel
          Left = 2
          Top = 15
          Width = 99
          Height = 73
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 0
          object Label5: TLabel
            Left = 0
            Top = 0
            Width = 29
            Height = 13
            Align = alTop
            Caption = 'Plates'
          end
          object Label6: TLabel
            Left = 0
            Top = 26
            Width = 58
            Height = 13
            Align = alTop
            Caption = 'Plates ready'
          end
          object Label8: TLabel
            Left = 0
            Top = 13
            Width = 81
            Height = 13
            Align = alTop
            Caption = 'Necessary plates'
          end
          object Label1: TLabel
            Left = 0
            Top = 39
            Width = 66
            Height = 13
            Align = alTop
            Caption = 'Plates imaged'
          end
          object Label2: TLabel
            Left = 0
            Top = 52
            Width = 66
            Height = 13
            Align = alTop
            Caption = 'Plates missing'
          end
        end
        object Panel2: TPanel
          Left = 101
          Top = 15
          Width = 132
          Height = 73
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object LabelNplates: TLabel
            Left = 0
            Top = 0
            Width = 29
            Height = 13
            Align = alTop
            Caption = 'Plates'
          end
          object LabelPlatesready: TLabel
            Left = 0
            Top = 26
            Width = 58
            Height = 13
            Align = alTop
            Caption = 'Plates ready'
          end
          object LabelNness: TLabel
            Left = 0
            Top = 13
            Width = 81
            Height = 13
            Align = alTop
            Caption = 'Necessary plates'
          end
          object Labelplatesimaged: TLabel
            Left = 0
            Top = 39
            Width = 66
            Height = 13
            Align = alTop
            Caption = 'Plates imaged'
          end
          object Labelplatesmissing: TLabel
            Left = 0
            Top = 52
            Width = 88
            Height = 13
            Align = alTop
            Caption = 'Labelplatesmissing'
          end
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
