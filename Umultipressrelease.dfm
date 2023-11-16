object Formmultipressrelease: TFormmultipressrelease
  Left = 703
  Top = 213
  BorderStyle = bsDialog
  Caption = 'Multi press release'
  ClientHeight = 394
  ClientWidth = 644
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 54
    Width = 644
    Height = 299
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 640
    ExplicitHeight = 298
    object Splitter1: TSplitter
      Left = 317
      Top = 0
      Height = 299
    end
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 317
      Height = 299
      Align = alLeft
      Caption = 'Editions'
      TabOrder = 0
      ExplicitHeight = 298
      object CheckListBoxeditions: TCheckListBox
        Left = 2
        Top = 15
        Width = 313
        Height = 282
        Align = alClient
        ItemHeight = 17
        TabOrder = 0
        ExplicitHeight = 281
      end
    end
    object GroupBox2: TGroupBox
      Left = 320
      Top = 0
      Width = 324
      Height = 299
      Align = alClient
      Caption = 'Presses'
      TabOrder = 1
      ExplicitWidth = 320
      ExplicitHeight = 298
      object CheckListBoxpresses: TCheckListBox
        Left = 2
        Top = 15
        Width = 320
        Height = 282
        Align = alClient
        ItemHeight = 17
        TabOrder = 0
        ExplicitWidth = 316
        ExplicitHeight = 281
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 644
    Height = 54
    Align = alTop
    Color = clWhite
    ParentBackground = False
    TabOrder = 1
    ExplicitWidth = 640
    object Label7: TLabel
      Left = 16
      Top = 4
      Width = 465
      Height = 24
      AutoSize = False
      Caption = 'Release production on multiple presses'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 24
      Top = 32
      Width = 277
      Height = 13
      AutoSize = False
      Caption = 'Select editions and presses to release on'
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 353
    Width = 644
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitTop = 352
    ExplicitWidth = 640
    object BitBtn1: TBitBtn
      Left = 557
      Top = 8
      Width = 75
      Height = 25
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn3: TBitBtn
      Left = 281
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Release'
      Glyph.Data = {
        26040000424D2604000000000000360000002800000012000000120000000100
        180000000000F003000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFF3A3A3A2D2D2D2424241C1C1C18
        18181616161515151616161818181D1D1D252525FFFFFFFFFFFFFFFFFFFFFFFF
        0000FFFFFFFFFFFF44444435D43529D4291DD21D15D11510D2100ED00E0DCF0D
        0ECA0E10C51015BD151EB61E292929FFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
        42424233DC3325DF2519DE1910DF100CE00C0A0A0A09DC090AD90A0CD20C11C8
        1119BD19242424FFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF42424232E63224E8
        2419EA1910EB100CEC0C0B0B0B0AE90A0BE40B0DDD0D11D21118C618242424FF
        FFFFFFFFFFFFFFFF0000FFFFFFFFFFFF44444434ED3427EF271DF11D16F31612
        121211111111111112EC1213E31317D8171ECC1E272727FFFFFFFFFFFFFFFFFF
        0000FFFFFFFFFFFF47474739EE392CF12C24F2241FF31F1EF41E1E1E1E1EF21E
        1EEE1E1FE61F22DD2226CE26303030FFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
        4B4B4B3FEC3F34ED342DEE2D2BF02B2BEF2B2DEE2D2DEE2D2EEB2E2EE42E2FDB
        2F32D032393939FFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF5050504545453C3C
        3C3737373636363838383B3B3B3D3D3D3D3D3D3C3C3C3C3C3C3E3E3E444444FF
        FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFF4B4B4B919191FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        0000FFFFFFFFFFFFFFFFFF515151909090FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
        FFFFFF575757909090FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8B8B
        8B525252FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFF5B5B5B9191
        91FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8B8B8B545454FFFFFFFF
        FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFF5A5A5A9090908B8B8BFF
        FFFFFFFFFFFFFFFF8A8A8A8A8A8A535353FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5B5B5B5454548D8D8D8B8B8B8A8A8A
        4F4F4F525252FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF565656535353525252FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF0000}
      TabOrder = 1
    end
  end
end
