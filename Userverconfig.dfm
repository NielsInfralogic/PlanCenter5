object Formserverconfig: TFormserverconfig
  Left = 568
  Top = 329
  BorderStyle = bsDialog
  Caption = 'Server configuration'
  ClientHeight = 381
  ClientWidth = 568
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 568
    Height = 169
    Align = alTop
    Caption = 'Main server'
    TabOrder = 0
    object Label1: TLabel
      Left = 12
      Top = 72
      Width = 229
      Height = 13
      AutoSize = False
      Caption = 'Server name'
    end
    object Label2: TLabel
      Left = 12
      Top = 116
      Width = 229
      Height = 13
      AutoSize = False
      Caption = 'Database name'
    end
    object Label7: TLabel
      Left = 292
      Top = 68
      Width = 229
      Height = 13
      AutoSize = False
      Caption = 'Server instance'
    end
    object Label5: TLabel
      Left = 292
      Top = 20
      Width = 46
      Height = 13
      Caption = 'Password'
    end
    object Label6: TLabel
      Left = 12
      Top = 20
      Width = 69
      Height = 13
      Caption = 'Database user'
    end
    object Label8: TLabel
      Left = 292
      Top = 116
      Width = 229
      Height = 13
      AutoSize = False
      Caption = 'DSN Name'
    end
    object Editservername: TEdit
      Left = 12
      Top = 85
      Width = 229
      Height = 21
      TabOrder = 0
    end
    object Editdbname: TEdit
      Left = 12
      Top = 132
      Width = 229
      Height = 21
      TabOrder = 1
    end
    object Editinstance: TEdit
      Left = 292
      Top = 84
      Width = 229
      Height = 21
      TabOrder = 2
      Text = 'infralogic'
    end
    object Editsaname: TEdit
      Left = 12
      Top = 36
      Width = 233
      Height = 21
      TabOrder = 3
      Text = 'infra'
    end
    object Editsapassword: TEdit
      Left = 292
      Top = 36
      Width = 229
      Height = 21
      PasswordChar = '*'
      TabOrder = 4
      Text = 'sasa'
    end
    object EditDSN: TEdit
      Left = 292
      Top = 132
      Width = 229
      Height = 21
      TabOrder = 5
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 169
    Width = 568
    Height = 171
    Align = alClient
    Caption = 'Backup server (optional)'
    TabOrder = 1
    ExplicitTop = 163
    object Label3: TLabel
      Left = 12
      Top = 72
      Width = 229
      Height = 13
      AutoSize = False
      Caption = 'Server name'
    end
    object Label9: TLabel
      Left = 12
      Top = 120
      Width = 229
      Height = 13
      AutoSize = False
      Caption = 'Database name'
    end
    object Label10: TLabel
      Left = 292
      Top = 68
      Width = 229
      Height = 13
      AutoSize = False
      Caption = 'Server instance'
    end
    object Label11: TLabel
      Left = 292
      Top = 20
      Width = 46
      Height = 13
      Caption = 'Password'
    end
    object Label12: TLabel
      Left = 12
      Top = 20
      Width = 69
      Height = 13
      Caption = 'Database user'
    end
    object Label4: TLabel
      Left = 292
      Top = 120
      Width = 229
      Height = 13
      AutoSize = False
      Caption = 'DSN Name'
    end
    object Editbackupservername: TEdit
      Left = 12
      Top = 85
      Width = 229
      Height = 21
      TabOrder = 0
    end
    object Editbackupdbname: TEdit
      Left = 12
      Top = 136
      Width = 229
      Height = 21
      TabOrder = 1
    end
    object Editbackupinstance: TEdit
      Left = 292
      Top = 84
      Width = 229
      Height = 21
      TabOrder = 2
      Text = 'infralogic'
    end
    object EditBackupsaname: TEdit
      Left = 12
      Top = 36
      Width = 233
      Height = 21
      TabOrder = 3
      Text = 'infra'
    end
    object Editbackupsapassword: TEdit
      Left = 292
      Top = 36
      Width = 229
      Height = 21
      PasswordChar = '*'
      TabOrder = 4
      Text = 'sasa'
    end
    object EditBackupDSN: TEdit
      Left = 292
      Top = 136
      Width = 229
      Height = 21
      TabOrder = 5
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 340
    Width = 568
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object BitBtn7: TBitBtn
      Left = 248
      Top = 8
      Width = 75
      Height = 25
      Enabled = False
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn8: TBitBtn
      Left = 332
      Top = 8
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
    object Button1: TButton
      Left = 160
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Test'
      TabOrder = 2
      OnClick = Button1Click
    end
  end
end
