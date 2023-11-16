object FormChlayout: TFormChlayout
  Left = 437
  Top = 288
  Caption = 'Change layout'
  ClientHeight = 303
  ClientWidth = 427
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ListBox1: TListBox
    Left = 0
    Top = 0
    Width = 69
    Height = 216
    ItemHeight = 13
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 262
    Width = 427
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 134
      Top = 8
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 218
      Top = 8
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object GroupBoxspecifikcopy: TGroupBox
    Left = 0
    Top = 213
    Width = 427
    Height = 49
    Align = alBottom
    Caption = 'Copy number'
    TabOrder = 2
    Visible = False
    object ComboBoxcopynumber: TComboBox
      Left = 8
      Top = 16
      Width = 145
      Height = 21
      Style = csDropDownList
      TabOrder = 0
      Items.Strings = (
        'All'
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8')
    end
  end
  object ListViewtmpl: TListView
    Left = 0
    Top = 0
    Width = 427
    Height = 213
    Align = alClient
    Columns = <
      item
        Caption = 'Name'
        MaxWidth = 400
        MinWidth = 300
        Width = 300
      end
      item
        Caption = 'Across'
        MaxWidth = 50
        MinWidth = 50
      end
      item
        Caption = 'Down'
        MaxWidth = 50
        MinWidth = 50
      end>
    GridLines = True
    RowSelect = True
    TabOrder = 3
    ViewStyle = vsReport
    OnSelectItem = ListViewtmplSelectItem
  end
end
