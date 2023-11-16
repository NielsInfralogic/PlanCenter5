object Formdeletesubedition: TFormdeletesubedition
  Left = 570
  Top = 478
  BorderStyle = bsDialog
  Caption = 'Delete subedition'
  ClientHeight = 228
  ClientWidth = 234
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 187
    Width = 234
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 38
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 122
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object ListBox1: TListBox
    Left = 0
    Top = 0
    Width = 234
    Height = 187
    Align = alClient
    ItemHeight = 13
    TabOrder = 1
  end
end
