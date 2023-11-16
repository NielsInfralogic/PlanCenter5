object Formpageformats: TFormpageformats
  Left = 2835
  Top = 340
  BorderStyle = bsDialog
  Caption = 'Page format'
  ClientHeight = 307
  ClientWidth = 427
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  TextHeight = 13
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 427
    Height = 54
    Align = alTop
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 423
    object Label7: TLabel
      Left = 20
      Top = 4
      Width = 225
      Height = 24
      AutoSize = False
      Caption = 'Change page format'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 28
      Top = 32
      Width = 241
      Height = 13
      AutoSize = False
      Caption = 'Select an existing page format'
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 266
    Width = 427
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 265
    ExplicitWidth = 423
    object BitBtn1: TBitBtn
      Left = 143
      Top = 8
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 231
      Top = 8
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
    object BitBtn3: TBitBtn
      Left = 4
      Top = 8
      Width = 75
      Height = 25
      Caption = 'New'
      TabOrder = 2
      OnClick = BitBtn3Click
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 54
    Width = 427
    Height = 212
    Align = alClient
    Caption = 'Page formats'
    TabOrder = 2
    ExplicitWidth = 423
    ExplicitHeight = 211
    object ListView1: TListView
      Left = 2
      Top = 15
      Width = 423
      Height = 195
      Align = alClient
      Columns = <
        item
          AutoSize = True
          Caption = 'Name'
        end
        item
          Caption = 'Width'
        end
        item
          Caption = 'Height'
        end
        item
          Caption = 'Bleed'
        end>
      GridLines = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      ExplicitWidth = 419
      ExplicitHeight = 194
    end
  end
end
