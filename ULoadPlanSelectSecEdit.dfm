object FormSelectSecEd: TFormSelectSecEd
  Left = 0
  Top = 0
  Caption = 'Select section and edition'
  ClientHeight = 309
  ClientWidth = 373
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poMainFormCenter
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 373
    Height = 268
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 369
    ExplicitHeight = 267
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 371
      Height = 41
      Align = alTop
      Caption = 'Select section and edition'
      TabOrder = 0
      ExplicitWidth = 367
    end
    object Panel3: TPanel
      Left = 1
      Top = 42
      Width = 185
      Height = 225
      Align = alLeft
      TabOrder = 1
      ExplicitHeight = 224
      object Label1: TLabel
        Left = 1
        Top = 1
        Width = 183
        Height = 13
        Align = alTop
        Alignment = taCenter
        Caption = 'Section'
        ExplicitWidth = 35
      end
      object ListBoxSec: TListBox
        Left = 1
        Top = 14
        Width = 183
        Height = 210
        Align = alClient
        ItemHeight = 13
        TabOrder = 0
        ExplicitHeight = 209
      end
    end
    object Panel4: TPanel
      Left = 186
      Top = 42
      Width = 186
      Height = 225
      Align = alClient
      TabOrder = 2
      ExplicitWidth = 182
      ExplicitHeight = 224
      object Label2: TLabel
        Left = 1
        Top = 1
        Width = 184
        Height = 13
        Align = alTop
        Alignment = taCenter
        Caption = 'Edition'
        ExplicitWidth = 32
      end
      object ListBoxEdition: TListBox
        Left = 1
        Top = 14
        Width = 184
        Height = 210
        Align = alClient
        ItemHeight = 13
        TabOrder = 0
        ExplicitWidth = 180
        ExplicitHeight = 209
      end
    end
  end
  object Panel5: TPanel
    Left = 0
    Top = 268
    Width = 373
    Height = 41
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 267
    ExplicitWidth = 369
    object BitBtn1: TBitBtn
      Left = 291
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Close'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 0
      OnClick = BitBtn1Click
    end
  end
end
