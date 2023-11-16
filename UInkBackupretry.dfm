object FormInkbackupFile: TFormInkbackupFile
  Left = 571
  Top = 222
  BorderStyle = bsSizeToolWin
  Caption = 'Copy inkfile from backup'
  ClientHeight = 561
  ClientWidth = 408
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 520
    Width = 408
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 508
    ExplicitWidth = 400
    object BitBtn1: TBitBtn
      Left = 325
      Top = 8
      Width = 75
      Height = 25
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 156
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Copy'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F6E1CFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF816100FF9F2A8F6F1DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA8A8A8737373
        553F2A553F2A3D3D3D3D3D3DB4B4B4806100FF9F2AD9A77DFF9F2A8F6F1C7373
        737474743D3D3DA7A7A7919191A9FFFF99F8FF99F8FF55DFFF55BFD3806100D9
        A77DD9A77DD9A77DD9A77DFF9F2A8F6F1D55DFFF55C0D43D3D3D919191A9FFFF
        A9FFFFA9FFFFA9FFFF806100D9A77DFFFFC3FFFFC3D9A77DD9A77DD9A77DFF9F
        2A8F6F1D55DFFF3D3D3D919191A9FFFFA9FFFFA9FFFFE1BE788F6F1C8F6F1C8F
        6E1CFFFFC3FFFFC4D9A77D8F6F1D8F6F1C8F6F1CE1BE78737373909090A9FFFF
        A9FFFFA9FFFFA9FFFFA9FFFFA9FFFF9D7C30FFFFC3FFFFC3FFF1AB9D7C30B4B4
        B499F8FF55DFFF3D3D3D919191D8E9ECA9FFFFA9FFFFA9FFFFA9FFFFA9FFFFAB
        8A40FFFFC3FFFFC3D9A77DFBD79198F7FF55DFFFAADFD53D3D3D919191A9FFFF
        A9FFFFA9FFFFA9FFFFA9FFFFB9974FD9A77DFFF0AAFFFFC3AB8A4099F7FF99F7
        FF99F8FF55DFFF595959A8A8A8D8E9ECA9FFFFD8E9ECA9FFFFA8FEFFB9974EFF
        E49EFFF0AAE1BE77FBD790A9FFFFA9FFFFA9FFFFA9FFFF666666B4B4B4A9FFFF
        D8E9ECA9FFFFA8FEFFAB893FD9A77DFBD790E1BE78A9FFFFA9FFFFA9FFFFA9FF
        FFA9FFFFA9FFFF737373C1C1C1D8E9ECA9FFFFD8E9ECD4B16AD4B26BD4B26BD4
        B26BEECB84C6C6C6C6C6C6AADFD555BFD354BFD355BFD3818181CCCCCCB5B5B5
        B4B4B4B4B4B4CBCBCBAADFD5AADFD555DFFF55DFFF55DFFF55DFFF55DFFF55DF
        FF55DFFF54BFD3C1C1C1FFFFFFDADADA00F2FF00F2FF00F1FF00F1FF55BFD3E6
        E6E68D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8DFFFFFFFFFFFF9B9B9B
        54FFFF67F4FF67F4FF67F4FF00F1FFB4B4B4FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9B9B9B8D8D8D8D8D8D8D8D8D9B9B9BFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      TabOrder = 1
      OnClick = BitBtn2Click
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 408
    Height = 61
    Align = alTop
    Caption = 'Filter'
    TabOrder = 1
    ExplicitWidth = 400
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 45
      Height = 13
      Caption = 'File name'
    end
    object Label2: TLabel
      Left = 164
      Top = 12
      Width = 92
      Height = 13
      Caption = 'Only files older than'
    end
    object Edit1: TEdit
      Left = 8
      Top = 32
      Width = 121
      Height = 21
      TabOrder = 0
      Text = '*.*'
    end
    object DateTimePicker1: TDateTimePicker
      Left = 164
      Top = 28
      Width = 186
      Height = 21
      Date = 39102.000000000000000000
      Time = 0.557266875002824200
      ShowCheckbox = True
      Checked = False
      TabOrder = 1
    end
  end
  object ListView1: TListView
    Left = 0
    Top = 61
    Width = 408
    Height = 459
    Align = alClient
    Columns = <
      item
        AutoSize = True
        Caption = 'File name'
      end
      item
        Caption = 'Date modified'
        Width = 150
      end>
    GridLines = True
    MultiSelect = True
    ReadOnly = True
    RowSelect = True
    TabOrder = 2
    ViewStyle = vsReport
    OnColumnClick = ListView1ColumnClick
    OnCompare = ListView1Compare
    ExplicitWidth = 400
    ExplicitHeight = 447
  end
end
