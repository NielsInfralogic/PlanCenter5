object Formlocserv: TFormlocserv
  Left = 1014
  Top = 413
  BorderStyle = bsDialog
  Caption = 'Server'
  ClientHeight = 298
  ClientWidth = 332
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 12
    Width = 65
    Height = 13
    Caption = 'Server adress'
  end
  object Label2: TLabel
    Left = 12
    Top = 132
    Width = 38
    Height = 13
    Caption = 'DB user'
  end
  object Label3: TLabel
    Left = 12
    Top = 172
    Width = 86
    Height = 13
    Caption = 'DB user password'
  end
  object Label4: TLabel
    Left = 12
    Top = 92
    Width = 15
    Height = 13
    Caption = 'DB'
  end
  object Label5: TLabel
    Left = 12
    Top = 52
    Width = 87
    Height = 13
    Caption = 'Odbc system DSN'
  end
  object Panel1: TPanel
    Left = 0
    Top = 257
    Width = 332
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 80
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 176
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object Editserv: TEdit
    Left = 12
    Top = 28
    Width = 293
    Height = 21
    TabOrder = 1
  end
  object Edituser: TEdit
    Left = 12
    Top = 148
    Width = 293
    Height = 21
    TabOrder = 2
    Text = 'sa'
  end
  object Edituserpassword: TEdit
    Left = 12
    Top = 188
    Width = 293
    Height = 21
    PasswordChar = '*'
    TabOrder = 3
    Text = 'infra'
  end
  object EditDB: TEdit
    Left = 12
    Top = 108
    Width = 293
    Height = 21
    TabOrder = 4
    Text = 'controlcenter'
  end
  object EditDSN: TEdit
    Left = 12
    Top = 68
    Width = 293
    Height = 21
    TabOrder = 5
  end
end
