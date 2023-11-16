object Formtemptree: TFormtemptree
  Left = 984
  Top = 331
  Width = 291
  Height = 405
  Caption = 'Formtemptree'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object TreeViewTemp: TTreeView
    Left = 0
    Top = 0
    Width = 217
    Height = 249
    Color = clWhite
    HideSelection = False
    HotTrack = True
    Indent = 19
    MultiSelectStyle = [msControlSelect, msShiftSelect]
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 0
  end
  object Button1: TButton
    Left = 16
    Top = 272
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 112
    Top = 272
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'Edit1'
  end
end
