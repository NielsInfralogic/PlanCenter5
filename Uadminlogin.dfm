object FormAdminlogin: TFormAdminlogin
  Left = 771
  Top = 497
  BorderStyle = bsDialog
  Caption = 'Admin login'
  ClientHeight = 166
  ClientWidth = 196
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
    Left = 24
    Top = 24
    Width = 48
    Height = 13
    Caption = 'Username'
  end
  object Label2: TLabel
    Left = 24
    Top = 68
    Width = 48
    Height = 13
    Caption = 'Username'
  end
  object Edit1: TEdit
    Left = 24
    Top = 40
    Width = 141
    Height = 21
    TabOrder = 0
    Text = 'admin'
  end
  object Edit2: TEdit
    Left = 24
    Top = 84
    Width = 141
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
    Text = 'saioq'
  end
  object BitBtn1: TBitBtn
    Left = 16
    Top = 124
    Width = 75
    Height = 25
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 2
  end
  object BitBtn2: TBitBtn
    Left = 100
    Top = 124
    Width = 75
    Height = 25
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 3
  end
end
