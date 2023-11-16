object FormMarkgroups: TFormMarkgroups
  Left = 910
  Top = 380
  BorderStyle = bsDialog
  Caption = 'Markgroups'
  ClientHeight = 268
  ClientWidth = 316
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object CheckListBoxmarkgroups: TCheckListBox
    Left = 0
    Top = 0
    Width = 316
    Height = 227
    Align = alClient
    ItemHeight = 13
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 227
    Width = 316
    Height = 41
    Align = alBottom
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 81
      Top = 8
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 161
      Top = 8
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
end
