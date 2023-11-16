object FormManageStackerSetups: TFormManageStackerSetups
  Left = 835
  Top = 233
  BorderStyle = bsToolWindow
  Caption = 'Manage Stacker Setups'
  ClientHeight = 309
  ClientWidth = 352
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 24
    Width = 183
    Height = 13
    Caption = 'Stacker Setups (with press information)'
  end
  object Label2: TLabel
    Left = 16
    Top = 136
    Width = 235
    Height = 13
    Caption = 'Default Stacker Setups (without press information)'
  end
  object ListBox1: TListBox
    Left = 16
    Top = 40
    Width = 225
    Height = 81
    ItemHeight = 13
    TabOrder = 0
  end
  object ListBox2: TListBox
    Left = 16
    Top = 152
    Width = 225
    Height = 81
    ItemHeight = 13
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 136
    Top = 256
    Width = 81
    Height = 25
    Caption = 'Close'
    TabOrder = 2
  end
  object BitBtn2: TBitBtn
    Left = 256
    Top = 40
    Width = 73
    Height = 25
    Caption = 'Delete'
    TabOrder = 3
  end
  object BitBtn3: TBitBtn
    Left = 256
    Top = 152
    Width = 73
    Height = 25
    Caption = 'Delete'
    TabOrder = 4
  end
  object BitBtn4: TBitBtn
    Left = 256
    Top = 72
    Width = 73
    Height = 25
    Caption = 'Edit name'
    TabOrder = 5
  end
  object BitBtn5: TBitBtn
    Left = 256
    Top = 192
    Width = 73
    Height = 25
    Caption = 'Edit name'
    TabOrder = 6
  end
end
