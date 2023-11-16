object Formadmintool: TFormadmintool
  Left = 660
  Top = 336
  Caption = 'Administrator maintenance tools'
  ClientHeight = 499
  ClientWidth = 688
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poMainFormCenter
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 688
    Height = 458
    ActivePage = TabSheet3
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 684
    ExplicitHeight = 457
    object TabSheet3: TTabSheet
      Caption = 'Maintenance'
      ImageIndex = 2
      object GroupBox7: TGroupBox
        Left = 8
        Top = 76
        Width = 673
        Height = 333
        Caption = 'Log'
        TabOrder = 0
        object Memoproclog: TMemo
          Left = 2
          Top = 15
          Width = 669
          Height = 316
          Align = alClient
          ScrollBars = ssBoth
          TabOrder = 0
        end
      end
      object GroupBox6: TGroupBox
        Left = 304
        Top = 8
        Width = 185
        Height = 49
        Caption = 'Plan locking'
        TabOrder = 1
        object BitBtn4: TBitBtn
          Left = 12
          Top = 16
          Width = 77
          Height = 25
          Caption = 'Lock'
          TabOrder = 0
          OnClick = BitBtn4Click
        end
        object BitBtn5: TBitBtn
          Left = 98
          Top = 16
          Width = 75
          Height = 25
          Caption = 'Release'
          TabOrder = 1
          OnClick = BitBtn5Click
        end
      end
      object GroupBox8: TGroupBox
        Left = 12
        Top = 8
        Width = 185
        Height = 53
        Caption = 'Page table index'
        TabOrder = 2
        object BitBtn2: TBitBtn
          Left = 8
          Top = 16
          Width = 75
          Height = 25
          Caption = 'Check'
          TabOrder = 0
          OnClick = BitBtn2Click
        end
        object BitBtn3: TBitBtn
          Left = 96
          Top = 16
          Width = 75
          Height = 25
          Caption = 'Repair'
          TabOrder = 1
          OnClick = BitBtn3Click
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'SQL'
      ImageIndex = 1
      object Splitter2: TSplitter
        Left = 0
        Top = 169
        Width = 680
        Height = 3
        Cursor = crVSplit
        Align = alTop
        ExplicitWidth = 688
      end
      object GroupBox4: TGroupBox
        Left = 0
        Top = 0
        Width = 680
        Height = 169
        Align = alTop
        Caption = 'SQL'
        TabOrder = 0
        object Memosql: TMemo
          Left = 2
          Top = 15
          Width = 676
          Height = 152
          Align = alClient
          Lines.Strings = (
            
              'select count(pagename) as '#39'number of pages'#39' from pagetable (NOLO' +
              'CK)')
          TabOrder = 0
        end
      end
      object GroupBox5: TGroupBox
        Left = 0
        Top = 172
        Width = 680
        Height = 258
        Align = alClient
        Caption = 'Result'
        TabOrder = 1
        object MemoSQLlog: TMemo
          Left = 2
          Top = 52
          Width = 676
          Height = 204
          Align = alClient
          ScrollBars = ssBoth
          TabOrder = 0
          WordWrap = False
        end
        object Panel2: TPanel
          Left = 2
          Top = 15
          Width = 676
          Height = 37
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object Button1: TButton
            Left = 8
            Top = 4
            Width = 75
            Height = 25
            Caption = 'Exec'
            TabOrder = 0
            OnClick = Button1Click
          end
          object Button2: TButton
            Left = 92
            Top = 4
            Width = 75
            Height = 25
            Caption = 'Open'
            TabOrder = 1
            OnClick = Button2Click
          end
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 458
    Width = 688
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 457
    ExplicitWidth = 684
    object BitBtn1: TBitBtn
      Left = 601
      Top = 9
      Width = 75
      Height = 25
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 0
    end
  end
end
