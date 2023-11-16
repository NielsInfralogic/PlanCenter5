object FormRun: TFormRun
  Left = 1078
  Top = 381
  BorderStyle = bsDialog
  Caption = 'K'#248'r'
  ClientHeight = 244
  ClientWidth = 547
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 547
    Height = 49
    Align = alTop
    Caption = 'Produkt og dato'
    TabOrder = 0
    object ComboBoxProduct: TComboBox
      Left = 8
      Top = 16
      Width = 257
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
    end
    object Editdato: TEdit
      Left = 280
      Top = 16
      Width = 129
      Height = 21
      ReadOnly = True
      TabOrder = 1
    end
  end
  object GroupBox2: TGroupBox
    Left = 320
    Top = 146
    Width = 553
    Height = 245
    Caption = 'Ugaver'
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 275
      Top = 15
      Height = 228
    end
    object GroupBoxandreUdgaver: TGroupBox
      Left = 278
      Top = 15
      Width = 273
      Height = 228
      Align = alClient
      Caption = 'Ikke valget Udgaver'
      TabOrder = 0
      object ListBoxNotEd: TListBox
        Left = 2
        Top = 15
        Width = 269
        Height = 170
        Align = alClient
        ItemHeight = 13
        Sorted = True
        TabOrder = 0
      end
      object Panel3: TPanel
        Left = 2
        Top = 185
        Width = 269
        Height = 41
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object BitBtn4: TBitBtn
          Left = 96
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Add'
          TabOrder = 0
          OnClick = BitBtn4Click
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF15
            9128FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFF159128159128FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF159128A5DEB615
            9128FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF15912884DCAB77D49B159128FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1591284EC7804EC77D6FD59A15
            9128159128159128159128159128159128159128159128FFFFFFFFFFFFFFFFFF
            1591281FB14829B0513ABA6548C27551C88056CB8655CB854FC77E44C07136B8
            6024AD4C159128FFFFFFFFFFFF15912800991805992614A43A23AD4B2FB45938
            B9633DBC683CBB6737B8612DB25620AA4710A135159128FFFFFFFFFFFF159128
            1DA23428A64135AE5042B65F4CBB6A52BF7155C07455C07351BE6F4ABA673FB4
            5B31AC4C159128FFFFFFFFFFFFFFFFFF15912856B96864C1776AC47D71C88475
            CA8977CB8B77CB8B74C9886FC68268C37B62C075159128FFFFFFFFFFFFFFFFFF
            FFFFFF1591288DD199A0DBAC9EDAAA1591281591281591281591281591281591
            28159128159128FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF159128A2DBAC97D4A015
            9128FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFF15912885CA8F159128FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF15912815
            9128FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF159128FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        end
      end
    end
    object GroupBox4: TGroupBox
      Left = 2
      Top = 15
      Width = 273
      Height = 228
      Align = alLeft
      Caption = 'Valget Udgaver'
      TabOrder = 1
      object Panel2: TPanel
        Left = 2
        Top = 185
        Width = 269
        Height = 41
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 0
        object BitBtn3: TBitBtn
          Left = 96
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Remove'
          TabOrder = 0
          OnClick = BitBtn3Click
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF159128FFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFF159128159128FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF15912884DCAB159128FFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFF15912815912815912815912815912815912815
            91281591281591284EC77D4EC780159128FFFFFFFFFFFFFFFFFFFFFFFF159128
            24AD4C36B86044C0714FC77E55CB8556CB8651C88048C2753ABA6529B0511FB1
            48159128FFFFFFFFFFFFFFFFFF15912810A13520AA472DB25637B8613CBB673D
            BC6838B9632FB45923AD4B14A43A059926009918159128FFFFFFFFFFFF159128
            31AC4C3FB45B4ABA6751BE6F55C07355C07452BF714CBB6A42B65F35AE5028A6
            411DA234159128FFFFFFFFFFFF15912862C07568C37B6FC68274C98877CB8B77
            CB8B75CA8971C8846AC47D64C17756B968159128FFFFFFFFFFFFFFFFFF159128
            159128159128159128159128159128159128159128159128A0DBAC8DD1991591
            28FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFF159128A2DBAC159128FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF159128159128FFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFF159128FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
          Layout = blGlyphRight
        end
      end
      object Memo1: TMemo
        Left = 24
        Top = 48
        Width = 185
        Height = 89
        Lines.Strings = (
          'Memo1')
        TabOrder = 1
        Visible = False
        WordWrap = False
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 203
    Width = 547
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object BitBtn1: TBitBtn
      Left = 194
      Top = 8
      Width = 75
      Height = 25
      Caption = 'K'#248'r'
      TabOrder = 0
      OnClick = BitBtn1Click
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 282
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkCancel
    end
    object BitBtn5: TBitBtn
      Left = 16
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Updater'
      ModalResult = 1
      TabOrder = 2
      Visible = False
      OnClick = BitBtn5Click
    end
    object BitBtn6: TBitBtn
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Force'
      ModalResult = 1
      TabOrder = 3
      Visible = False
      OnClick = BitBtn6Click
    end
    object BitBtn7: TBitBtn
      Left = 16
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Append'
      ModalResult = 1
      TabOrder = 4
      Visible = False
      OnClick = BitBtn7Click
    end
    object Edit1: TEdit
      Left = 392
      Top = 8
      Width = 121
      Height = 21
      TabOrder = 5
      Text = 'Edit1'
      Visible = False
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 49
    Width = 547
    Height = 57
    Align = alTop
    Caption = 'Besked'
    TabOrder = 3
    object PanelBesked: TPanel
      Left = 2
      Top = 15
      Width = 543
      Height = 40
      Align = alClient
      BevelOuter = bvNone
      Caption = 'K'#248'r ny plan'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
  end
  object GroupBox5: TGroupBox
    Left = 0
    Top = 106
    Width = 547
    Height = 97
    Align = alClient
    Caption = 'Udgaver'
    TabOrder = 4
    object ListBoxdgaver: TListBox
      Left = 2
      Top = 15
      Width = 543
      Height = 80
      Align = alClient
      ItemHeight = 13
      Sorted = True
      TabOrder = 0
    end
  end
end
