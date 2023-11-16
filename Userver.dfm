object FormServer: TFormServer
  Left = 421
  Top = 535
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Server configuration'
  ClientHeight = 320
  ClientWidth = 864
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object PBExListviewservers: TPBExListview
    Left = 0
    Top = 0
    Width = 864
    Height = 136
    Align = alClient
    Columns = <
      item
        AutoSize = True
        Caption = 'Server'
      end
      item
        AutoSize = True
        Caption = 'Network username'
      end
      item
        AutoSize = True
        Caption = 'Network password'
      end
      item
        MaxWidth = 1
        MinWidth = 1
        Width = 1
      end
      item
        AutoSize = True
        Caption = 'Instance'
      end
      item
        AutoSize = True
        Caption = 'Database'
      end
      item
        AutoSize = True
        Caption = 'DB username'
      end
      item
        AutoSize = True
        Caption = 'DB password'
      end
      item
        MaxWidth = 1
        MinWidth = 1
        Width = 1
      end>
    GridLines = True
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnClick = PBExListviewserversClick
    OnSelectItem = PBExListviewserversSelectItem
  end
  object Panel1: TPanel
    Left = 0
    Top = 136
    Width = 864
    Height = 184
    Align = alBottom
    TabOrder = 1
    object BitBtnaddNOskin: TBitBtn
      Left = 32
      Top = 144
      Width = 75
      Height = 25
      Caption = 'Add'
      TabOrder = 0
      OnClick = BitBtnaddNOskinClick
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
        A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
        69A46769A46769FFFFFFFFFFFFFFFFFFB79184FEE9C7F4DAB5F3D5AAF2D0A0EF
        CB96EFC68BEDC182EBC17FEBC180EBC180F2C782A46769FFFFFFFFFFFFFFFFFF
        B79187FCEACEBDAF9CBAA992B7A48AB29E82B09979AD9573A98F6AA58A65C4A1
        70EFC481A46769FFFFFFFFFFFFFFFFFFB7938AFEEFDAE3D0BAE0CBB1DEC6A7DC
        C19EDABC95D8B78CD7B283D1AC79DDB57AEFC481A46769FFFFFFFFFFFFFFFFFF
        BA978FFFF4E5D4C9BBD0C4B2CABBA7C4B19CC1AD93BBA589B7A081AD9573C7A5
        75EFC480A46769FFFFFFFFFFFFFFFFFFC09E95FFFBF0EBDED1E6D7C5E3D1BBE0
        CAB0DEC6A6DABF9DD7B891D3B287DEB883EFC583A46769FFFFFFFFFFFFFFFFFF
        C6A49AFFFFFCCFCAC2CCC4BACABFB1C6BAA9C5B6A1C1B099BDA990B49F82CCB0
        86F2C98CA46769FFFFFFFFFFFFFFFFFFCBA99E05650B046009035E07E9DCCCF2
        DECBF6E0C5DEC9ADF2D4B1F0D0A7EECC9EF3CE97A46769FFFFFFFFFFFFFFFFFF
        CFAC9F076F0F12A42405640AB4ADA7D3C9BCE1D1BFAB9F8FE3CCB1F3D4B0F0D0
        A6F6D3A0A46769FFFFFFFFFFFFFFFFFFD4B0A10A791418AB2D066B0DEEE7E2C2
        BBB4D0C5B7D8C9B6F6DEC4F3D9B8F4D8B1EBCFA4A46769FFFFFF0C80180D841A
        0D871B0D841A1FB438097311066C0D05650A035E08C6BBB0B2A99AD7C9B2DECE
        B4B6AA93A46769FFFFFF0F8B1D4BFF842DC6522DC45023BB411FB23818AB2D13
        A424046209E2DACFCBBAADAC8376A17B6F9C7667A46769FFFFFF139A2616A42B
        18A72D16A32A2CC5500D841A0A7914076E0F05660AC1C0BCD7BDB6AD735BE19E
        55E68F31B56D4DFFFFFFFFFFFFFFFFFFE6BFA717A72D2DC6520E861BCBCBCBE5
        E5E5F4F4F4C6C6C6D3C0BDB88265F8B55CBF7A5CFFFFFFFFFFFFFFFFFFFFFFFF
        E3BBA316A32B4BFF840D841AFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0B77F62C183
        6CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE2B69D139C260F8B1E0C8118E5BCA5E3
        BCA5E3BCA5E3BDA6CFA99CA56B5FFFFFFFFFFFFFFFFFFFFFFFFF}
    end
    object BitBtnApply: TBitBtn
      Left = 120
      Top = 144
      Width = 75
      Height = 25
      Caption = 'Apply'
      TabOrder = 1
      OnClick = BitBtnApplyClick
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
        98403F953A3A8B3435957D7DB0B8B7BDBCBBC0BCBBBBB8B7B6BBBAA487878028
        29812C2C903737FFFFFFFFFFFFAA5D56C14B4BC54D4DA64041836666AC8A89D9
        C2C0FEF7F2FFFCF8EEF3F0C59F9F7E1918811D1DB141419C3E3FFFFFFFA95D56
        BC4A4AC04C4CA54242876062862B2BA45B5AE0D5D3FCFAF7FEFFFCCEA7A67E1A
        1A811E1EAF40409A3E3FFFFFFFA95D56BC4A4AC04B4CA54242926A6981232383
        2020BFAAA9EEEBE9000000D9B2B07E1919801E1EAF40409A3E3FFFFFFFA95D56
        BC4A4AC04B4BA441419E7675882F2F7B1D1D908282C9D0CCF8FFFEDEBAB87A18
        187E1C1CAD3F3F9A3E3FFFFFFFA95D56BC4A4AC14B4BA94141B27776B17E7D9F
        6C6C957475A78B8AD8BBB8D193938C23238E2727B24242993D3EFFFFFFA95D56
        BD4A4BBC4949BC4949BC4849BD4C4CBF4C4CBD4949B84141BA4343BB4646BD4A
        4ABF4B4BC14D4D973C3DFFFFFFAA5E57A439379E413DB66C6AC58E8BC99695C9
        9593C99695C98F8EC99291C99593CA9997C68484BF4B4B973B3CFFFFFFAA5D56
        9D3533DCBFBCF8F4F4F6F0EFF7F2F0F7F2F0F7F2F0F7F3F2F7F2F0F7F2F0FAFA
        F8D4ACABB44142983C3DFFFFFFAA5D569F3735E5CBCAFBFAF8F4EBEAF4EDEBF4
        EDEBF4EDEBF4EDEBF4EDEBF3EDEBFAF7F6D4AAA9B24141983C3DFFFFFFAA5D56
        9F3735E5CBC7EBEAEACCC9C7CFCBCBCFCBCBCFCBCBCFCBCBCFCBCBCCC9C9E6E6
        E5D7ABAAB14141983C3DFFFFFFAA5D569F3735E5CBC9EFEDEDD4CFCED5D0D0D5
        D0D0D5D0D0D5D0D0D5D0D0D3CFCEE9E9E9D7ABAAB24141983C3DFFFFFFAA5D56
        9F3735E3CBC9F2F0EFDCD5D4DDD8D7DDD8D7DDD8D7DDD8D7DDD8D7DCD5D5EEED
        EBD5ABA9B24141983C3DFFFFFFAA5D569F3735E5CBCAEDEBEACEC9C9CFCCCBCF
        CCCBCFCCCBCFCCCBCFCCCBCCC9C9E7E6E5D8ACABB24141983C3DFFFFFFAA5D55
        9F3735E2CAC7FEFAFAF8EFEEF8EFEEF8EFEEF8EFEEF8EFEEF8EFEEF8EFEEFCF8
        F7D4AAA9B24141983C3DFFFFFFFFFFFF923633BAA3A1C6C9C7C4C0C0C4C0C0C4
        C0C0C4C0C0C4C0C0C4C0C0C4C0C0C6C7C7BC99988C3435FFFFFF}
    end
    object BitBtnedit: TBitBtn
      Left = 120
      Top = 144
      Width = 75
      Height = 25
      Caption = 'Edit'
      Enabled = False
      TabOrder = 2
      OnClick = BitBtneditClick
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
        A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
        69A46769A46769FFFFFFFFFFFFFFFFFFB79184FEE9C7F4DAB5F3D5AAF2D0A0EF
        CB96EFC68BEDC182EBC17FEBC180EBC180F2C782A46769FFFFFFFFFFFFFFFFFF
        B79187FCEACEF3DABCF2D5B1F0D0A7EECB9EEDC793EDC28BE9BD81E9BD7FE9BD
        7FEFC481A46769FFFFFFFFFFFFFFFFFFB7938AFEEFDAF6E0C6F2DABCF2D5B2EF
        D0A9EECB9EEDC796EBC28CE9BD82E9BD7FEFC481A46769FFFFFFFFFFFFFFFFFF
        BA978FFFF4E5F7E5CF000000000000F2D5B1F0D0A6000000000000EBC28AEABF
        81EFC480A46769FFFFFFFFFFFFFFFFFFC09E95FFFBF0F8EADCF6E3CFF4E0C600
        0000000000000000000000EDC695EBC28AEFC583A46769FFFFFFFFFFFFFFFFFF
        C6A49AFFFFFCFAF0E6F8EADA00000000DDDD000000000000F0D0A7EECB9DEBC7
        93F2C98CA46769FFFFFFFFFFFFFFFFFFCBA99EFFFFFFFEF7F200000000EEEE00
        DDDD00DDDD000000F2D4B1F0D0A7EECC9EF3CE97A46769FFFFFFFFFFFFFFFFFF
        CFAC9FFFFFFF00000000EEEE00EEEE00DDDD000000F4E0C5F3D9BBF3D4B0F0D0
        A6F6D3A0A46769FFFFFFFFFFFFFFFFFFD4B0A100000000EEEE00EEEE00EEEE00
        0000F8EAD9F7E5CEF6DEC4F3D9B8F4D8B1EBCFA4A46769FFFFFFFFFFFFFFFFFF
        00000000FFFF00EEEE00EEEE000000FCF7F0FAEFE5F8E9D9F8E7D1FBEACEDECE
        B4B6AA93A46769FFFFFFFFFFFF00000000FFFF00FFFF00EEEE000000FFFFFFFF
        FEFCFCF6EFFCF3E6EDD8C9B68A7BA17B6F9C7667A46769FFFFFF0000000000FF
        00000000FFFF000000FFFFFFFFFFFFFFFFFFFFFEFBFFFEF7DAC1BAAD735BE19E
        55E68F31B56D4DFFFFFFFFFFFF0000000000FF000000FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFDCC7C5B88265F8B55CBF7A5CFFFFFFFFFFFFFFFFFFFFFFFF
        000000FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0B77F62C183
        6CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE8C4ADEBCBB7EBCBB7EACBB7EACAB6EA
        CAB6EACAB6EACAB6E3C2B1A56B5FFFFFFFFFFFFFFFFFFFFFFFFF}
    end
    object BitBtnDelete: TBitBtn
      Left = 208
      Top = 144
      Width = 75
      Height = 25
      Caption = 'Delete'
      Enabled = False
      TabOrder = 3
      OnClick = BitBtnDeleteClick
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF000000000000FFFFFF808080000000000000FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFC0C0C0FFFFFFC0C0C0C0
        C0C0808080000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        000000C0C0C0FFFFFFFFFFFFC0C0C0C0C0C0C0C0C0C0C0C0808080000000FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFC0C0C0FFFFFFC0C0C000
        8000008000C0C0C0C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        000000C0C0C0FFFFFFFFFFFFC0C0C0008000C0C0C0008000C0C0C0000000FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF000000C0C0C0FFFFFFC0C0C0FFFFFFC0C0C080
        8080C0C0C0008000C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
        FFFFFFC0C0C0FFFFFFFFFFFFC0C0C0C0C0C0008000008000C0C0C08080800000
        00FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFC0C0C0C0C0C0C0C0C0C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFF000000
        C0C0C0FFFFFF808080808080808080808080FFFFFFFFFFFFC0C0C0C0C0C00000
        00FFFFFFFFFFFFFFFFFFFFFFFF000000C0C0C0808080FFFFFFFFFFFFFFFFFFFF
        FFFF808080808080FFFFFFC0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        000000808080FFFFFFFFFFFFFFFFFF808080FFFFFFFFFFFF808080FFFFFF0000
        00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF000000FF
        FFFFFFFFFFC0C0C0C0C0C0000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF000000000000FFFFFF000000000000000000000000FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    end
    object BitBtn1: TBitBtn
      Left = 320
      Top = 144
      Width = 75
      Height = 25
      TabOrder = 4
      OnClick = BitBtn1Click
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 400
      Top = 144
      Width = 75
      Height = 25
      TabOrder = 5
      OnClick = BitBtn2Click
      Kind = bkCancel
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 8
      Width = 601
      Height = 65
      Caption = 'Network'
      TabOrder = 6
      object Label2: TLabel
        Left = 136
        Top = 16
        Width = 48
        Height = 13
        Caption = 'Username'
      end
      object Label3: TLabel
        Left = 264
        Top = 16
        Width = 46
        Height = 13
        Caption = 'Password'
      end
      object Label4: TLabel
        Left = 392
        Top = 16
        Width = 83
        Height = 13
        Caption = 'Confirm password'
      end
      object Label1: TLabel
        Left = 8
        Top = 16
        Width = 60
        Height = 13
        Caption = 'Server name'
      end
      object Edituser: TEdit
        Left = 136
        Top = 32
        Width = 121
        Height = 21
        TabOrder = 0
      end
      object Editpassword: TEdit
        Left = 264
        Top = 32
        Width = 121
        Height = 21
        PasswordChar = '*'
        TabOrder = 1
        Text = 'Editpassword'
      end
      object Editpassw2: TEdit
        Left = 392
        Top = 32
        Width = 121
        Height = 21
        PasswordChar = '*'
        TabOrder = 2
      end
      object Buttonlogon: TButton
        Left = 520
        Top = 24
        Width = 75
        Height = 25
        Caption = 'Test'
        TabOrder = 3
        OnClick = ButtonlogonClick
      end
      object EditServer: TEdit
        Left = 8
        Top = 32
        Width = 121
        Height = 21
        TabOrder = 4
      end
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 72
      Width = 737
      Height = 65
      Caption = 'Database'
      TabOrder = 7
      object Label5: TLabel
        Left = 264
        Top = 16
        Width = 48
        Height = 13
        Caption = 'Username'
      end
      object Label6: TLabel
        Left = 392
        Top = 16
        Width = 46
        Height = 13
        Caption = 'Password'
      end
      object Label7: TLabel
        Left = 520
        Top = 16
        Width = 83
        Height = 13
        Caption = 'Confirm password'
      end
      object Label8: TLabel
        Left = 8
        Top = 16
        Width = 84
        Height = 13
        Caption = 'Instance or empty'
      end
      object Label9: TLabel
        Left = 136
        Top = 16
        Width = 46
        Height = 13
        Caption = 'Database'
      end
      object EditDBuser: TEdit
        Left = 264
        Top = 32
        Width = 121
        Height = 21
        TabOrder = 0
      end
      object EditDBpassword: TEdit
        Left = 392
        Top = 32
        Width = 121
        Height = 21
        PasswordChar = '*'
        TabOrder = 1
        Text = 'Editpassword'
      end
      object EditDBpassw2: TEdit
        Left = 520
        Top = 32
        Width = 121
        Height = 21
        PasswordChar = '*'
        TabOrder = 2
      end
      object Button1: TButton
        Left = 652
        Top = 28
        Width = 75
        Height = 25
        Caption = 'Test'
        TabOrder = 3
        OnClick = Button1Click
      end
      object EditInstance: TEdit
        Left = 8
        Top = 32
        Width = 121
        Height = 21
        TabOrder = 4
      end
      object Editdatabase: TEdit
        Left = 136
        Top = 32
        Width = 121
        Height = 21
        TabOrder = 5
        Text = 'ControlCenter'
      end
    end
  end
  object CRSQLConnectiontest: TCRSQLConnection
    ConnectionName = 'CRSQLConnectiontest'
    DriverName = 'SQLServer'
    GetDriverFunc = 'getSQLDriverSQLServer'
    LibraryName = 'dbexpsda.dll'
    LoginPrompt = False
    VendorLib = 'sqloledb.dll'
    Left = 536
    Top = 64
  end
end