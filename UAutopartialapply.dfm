object Form1: TForm1
  Left = 753
  Top = 336
  Width = 477
  Height = 383
  Caption = 'Auto Partial'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 461
    Height = 113
    Align = alTop
    Caption = 'Apply plans to the following sections'
    TabOrder = 0
    object ListView2: TListView
      Left = 2
      Top = 15
      Width = 457
      Height = 96
      Align = alClient
      Checkboxes = True
      Columns = <
        item
          Caption = 'Section'
        end
        item
          Caption = 'Number of pages'
        end>
      GridLines = True
      Items.Data = {
        620000000300000000000000FFFFFFFFFFFFFFFF0100000000000000044D6169
        6E02363400000000FFFFFFFFFFFFFFFF01000000000000000553706F72740233
        3200000000FFFFFFFFFFFFFFFF01000000000000000342696C023438FFFFFFFF
        FFFF}
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 113
    Width = 461
    Height = 168
    Align = alTop
    Caption = 'Number of pages pr. pressrun'
    TabOrder = 1
    object ListView1: TListView
      Left = 2
      Top = 56
      Width = 457
      Height = 73
      Align = alTop
      Columns = <
        item
          Caption = 'Number of pages'
        end
        item
          Caption = 'Press run number'
        end>
      GridLines = True
      Items.Data = {
        3E0000000200000000000000FFFFFFFFFFFFFFFF010000000000000002343801
        3100000000FFFFFFFFFFFFFFFF01000000000000000234380132FFFFFFFF}
      TabOrder = 0
      ViewStyle = vsReport
    end
    object Panel1: TPanel
      Left = 2
      Top = 15
      Width = 457
      Height = 41
      Align = alTop
      Caption = 'Panel1'
      TabOrder = 1
      object Label1: TLabel
        Left = 16
        Top = 8
        Width = 112
        Height = 13
        Caption = 'Total number of pages :'
      end
      object Edit1: TEdit
        Left = 132
        Top = 4
        Width = 65
        Height = 21
        ReadOnly = True
        TabOrder = 0
        Text = '96'
      end
    end
  end
end
