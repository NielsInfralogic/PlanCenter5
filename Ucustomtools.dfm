object Formcustomtools: TFormcustomtools
  Left = 910
  Top = 257
  BorderStyle = bsDialog
  Caption = 'Custom tools'
  ClientHeight = 581
  ClientWidth = 733
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 540
    Width = 733
    Height = 41
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 539
    ExplicitWidth = 729
    object BitBtn1: TBitBtn
      Left = 648
      Top = 9
      Width = 75
      Height = 25
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 0
    end
  end
  object PageControl1: TPageControl
    Left = 220
    Top = 0
    Width = 513
    Height = 540
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 509
    ExplicitHeight = 539
    object TabSheet1: TTabSheet
      Caption = 'Nice'
      object Button1: TButton
        Left = 12
        Top = 12
        Width = 75
        Height = 25
        Caption = 'Auto stack'
        TabOrder = 0
        OnClick = Button1Click
      end
      object GroupBox3: TGroupBox
        Left = 4
        Top = 60
        Width = 329
        Height = 189
        Caption = 'Check filenames'
        TabOrder = 1
        object Button2: TButton
          Left = 12
          Top = 24
          Width = 75
          Height = 25
          Caption = 'Check'
          TabOrder = 0
          OnClick = Button2Click
        end
        object GroupBox4: TGroupBox
          Left = 8
          Top = 56
          Width = 313
          Height = 125
          Caption = 'Wrong filenames'
          TabOrder = 1
          object ListBox1: TListBox
            Left = 2
            Top = 15
            Width = 309
            Height = 108
            Align = alClient
            ItemHeight = 13
            TabOrder = 0
          end
        end
      end
      object GroupBox2: TGroupBox
        Left = 4
        Top = 260
        Width = 329
        Height = 189
        Caption = 'Check master numbers'
        TabOrder = 2
        object Button3: TButton
          Left = 12
          Top = 24
          Width = 75
          Height = 25
          Caption = 'Check'
          TabOrder = 0
          OnClick = Button3Click
        end
        object GroupBox5: TGroupBox
          Left = 8
          Top = 56
          Width = 313
          Height = 125
          Caption = 'Wrong Pages'
          TabOrder = 1
          object ListBox2: TListBox
            Left = 2
            Top = 15
            Width = 309
            Height = 108
            Align = alClient
            ItemHeight = 13
            TabOrder = 0
          end
        end
      end
      object Buttonplateid: TButton
        Left = 104
        Top = 12
        Width = 75
        Height = 25
        Caption = 'Plate id exp.'
        Enabled = False
        TabOrder = 3
        OnClick = ButtonplateidClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Proof defaults'
      ImageIndex = 1
      object ListView1: TListView
        Left = 0
        Top = 65
        Width = 505
        Height = 387
        Align = alClient
        Columns = <
          item
            AutoSize = True
            Caption = 'Plate layout'
          end
          item
            AutoSize = True
            Caption = 'Default proof setup'
          end>
        GridLines = True
        HideSelection = False
        MultiSelect = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        ExplicitWidth = 501
        ExplicitHeight = 386
      end
      object Panel3: TPanel
        Left = 0
        Top = 452
        Width = 505
        Height = 60
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        ExplicitTop = 451
        ExplicitWidth = 501
        object BitBtn2: TBitBtn
          Left = 20
          Top = 16
          Width = 75
          Height = 25
          Caption = 'Apply'
          TabOrder = 0
          OnClick = BitBtn2Click
        end
        object Button4: TButton
          Left = 116
          Top = 16
          Width = 75
          Height = 25
          Caption = 'Clear'
          TabOrder = 1
          OnClick = Button4Click
        end
      end
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 505
        Height = 65
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        ExplicitWidth = 501
        object Label1: TLabel
          Left = 4
          Top = 8
          Width = 52
          Height = 13
          Caption = 'Publication'
        end
        object Label2: TLabel
          Left = 236
          Top = 8
          Width = 54
          Height = 13
          Caption = 'Proof setup'
        end
        object ComboBoxpubl: TComboBox
          Left = 4
          Top = 28
          Width = 225
          Height = 21
          Style = csDropDownList
          TabOrder = 0
          OnChange = ComboBoxpublChange
        end
        object ComboBoxproofs: TComboBox
          Left = 240
          Top = 28
          Width = 229
          Height = 21
          Style = csDropDownList
          TabOrder = 1
          OnChange = ComboBoxproofsChange
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'TabSheet3'
      ImageIndex = 2
    end
  end
  object GroupBoxtree: TGroupBox
    Left = 0
    Top = 0
    Width = 220
    Height = 540
    Align = alLeft
    Caption = 'Filter'
    TabOrder = 2
    ExplicitHeight = 539
    object GroupBoxpageslocation: TGroupBox
      Left = 2
      Top = 45
      Width = 216
      Height = 38
      Align = alTop
      Caption = 'Location'
      TabOrder = 0
      Visible = False
      object ComboBoxpalocation: TComboBox
        Left = 4
        Top = 12
        Width = 273
        Height = 21
        Style = csDropDownList
        TabOrder = 0
      end
    end
    object TreeViewThumbs: TTreeView
      Left = 2
      Top = 83
      Width = 216
      Height = 455
      Align = alClient
      HideSelection = False
      HotTrack = True
      Indent = 19
      MultiSelectStyle = [msControlSelect, msShiftSelect]
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 1
      OnChange = TreeViewThumbsChange
      ExplicitHeight = 454
    end
    object Panel2: TPanel
      Left = 2
      Top = 15
      Width = 216
      Height = 30
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      object BitBtn3: TBitBtn
        Left = 4
        Top = 0
        Width = 75
        Height = 25
        Caption = 'Refresh'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF00000000FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFF00
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF000000FFFFFF00FFFF000000FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF
          FFFF00FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF00000000000000000000FFFF000000000000000000FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFF
          FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFF000000FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF
          FFFF00FFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFF000000000000000000000000FFFFFF000000000000000000000000FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFF00
          FFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00000000FFFFFFFFFF00FFFFFFFFFF000000FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF00
          FFFFFFFFFF00FFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000
          00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        TabOrder = 0
        OnClick = BitBtn3Click
      end
      object DateTimePickerthumb: TDateTimePicker
        Left = 96
        Top = 3
        Width = 105
        Height = 21
        Date = 38525.000000000000000000
        Time = 0.200794803240569300
        ShowCheckbox = True
        Checked = False
        TabOrder = 1
      end
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '*.czd'
    Filter = 'comma|*.czd|Textfile|*.txt|All files|*.*'
    Left = 527
    Top = 152
  end
end
