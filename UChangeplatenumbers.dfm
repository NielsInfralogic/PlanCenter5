object FormChplatenum: TFormChplatenum
  Left = 707
  Top = 446
  Width = 575
  Height = 380
  Caption = 'Change plate numbering'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ListView1: TListView
    Left = 0
    Top = 0
    Width = 559
    Height = 303
    Align = alClient
    Columns = <
      item
        AutoSize = True
        Caption = 'Edition'
      end
      item
        AutoSize = True
        Caption = 'Sections'
      end>
    GridLines = True
    MultiSelect = True
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
  end
  object Panel1: TPanel
    Left = 0
    Top = 303
    Width = 559
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
  end
end
