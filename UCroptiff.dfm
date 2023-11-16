object Formcroptif: TFormcroptif
  Left = 876
  Top = 354
  BorderStyle = bsDialog
  Caption = 'Crop tiff file / files'
  ClientHeight = 320
  ClientWidth = 397
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
  object Panel1: TPanel
    Left = 0
    Top = 279
    Width = 397
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 113
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 193
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 57
    Width = 397
    Height = 222
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 200
      Top = 156
      Width = 28
      Height = 13
      Caption = 'Width'
    end
    object Label2: TLabel
      Left = 268
      Top = 156
      Width = 31
      Height = 13
      Caption = 'Height'
    end
    object Label4: TLabel
      Left = 344
      Top = 176
      Width = 16
      Height = 13
      Caption = 'mm'
    end
    object Label5: TLabel
      Left = 32
      Top = 156
      Width = 7
      Height = 13
      Caption = 'X'
    end
    object Label6: TLabel
      Left = 100
      Top = 156
      Width = 7
      Height = 13
      Caption = 'Y'
    end
    object RadioGroup1: TRadioGroup
      Left = 36
      Top = 12
      Width = 309
      Height = 105
      Caption = 'Crop offset'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'top left'
        'center left'
        'bottom left'
        'top center'
        'Image centrum'
        'Bottom center'
        'top right'
        'center right'
        'bottom right')
      TabOrder = 0
    end
    object Editw: TEdit
      Left = 200
      Top = 172
      Width = 61
      Height = 21
      TabOrder = 1
      OnKeyPress = EditwKeyPress
    end
    object Edith: TEdit
      Left = 268
      Top = 172
      Width = 61
      Height = 21
      TabOrder = 2
      OnKeyPress = EdithKeyPress
    end
    object Editx: TEdit
      Left = 32
      Top = 172
      Width = 61
      Height = 21
      TabOrder = 3
      Text = '0'
      OnKeyPress = EditxKeyPress
    end
    object Edity: TEdit
      Left = 100
      Top = 172
      Width = 61
      Height = 21
      TabOrder = 4
      Text = '0'
      OnKeyPress = EdityKeyPress
    end
    object CheckBoxkeepW: TCheckBox
      Left = 32
      Top = 128
      Width = 97
      Height = 17
      Caption = 'Keep width'
      TabOrder = 5
    end
    object CheckBoxkeepH: TCheckBox
      Left = 148
      Top = 128
      Width = 97
      Height = 17
      Caption = 'Keep height'
      TabOrder = 6
    end
    object CheckBoxchpath: TCheckBox
      Left = 32
      Top = 204
      Width = 205
      Height = 17
      Caption = 'Change output path'
      TabOrder = 7
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 397
    Height = 57
    Align = alTop
    Color = clWhite
    ParentBackground = False
    TabOrder = 2
    object Image2: TImage
      Left = 1
      Top = 1
      Width = 72
      Height = 55
      Align = alLeft
      Center = True
      Picture.Data = {
        0A544A504547496D61676502040000FFD8FFE000104A46494600010100000100
        010000FFDB004300090607080706090807080A0A090B0D160F0D0C0C0D1B1415
        1016201D2222201D1F1F2428342C242631271F1F2D3D2D3135373A3A3A232B3F
        443F384334393A37FFDB0043010A0A0A0D0C0D1A0F0F1A37251F253737373737
        3737373737373737373737373737373737373737373737373737373737373737
        37373737373737373737373737FFC00011080030003003012200021101031101
        FFC4001800000301010000000000000000000000000006070504FFC400311000
        0103040102040307050000000000000201030400050611121331142141610715
        511735567495B2D3223262A1B1FFC40017010101010100000000000000000000
        000001000302FFC4001F11010002010403010000000000000000000100030211
        13316122324121FFDA000C03010002110311003F00B8D1452A66B96C8C6E5408
        D16DCD4C396DBA6AAE495650101413D00B7BEA7B76A415D08281AB1AEB8AF174
        8765B7B970B93AAD46694508C5B235D91208A208A2AAED4913C93D6907ED2EE9
        F87A17EA67FC359394E6574C82CAEDB7E4D0E3F51D65CEA7CC08F5C1C13D6BA4
        9DF8EBBFAD6A5166BFA4C9BEBD39949B0E4D69C84E405AA438E9C6405745C8CE
        B4A285CB8AFF0058A6F7C4BB7D2B62A1F89E4174C766CF93F2B8723C5B4CB7C7
        C71070E9AB8BBDF4977BEA7FAF7AA86159326516B39651522BAD3C6D38D239D4
        4451251F22D26F7ADF64EF4595B83D4EABB0CCEE3054D3E2C7DF762FCACBFDCC
        53F5E2E90ECB6F72E172755A8CD28A118B646BB2241144114555DA9227927AD4
        AF3AC8ED7905EED3F2B79E73A1164F53A919D675C899D6B98A6FB2F6A681DC19
        CDE9B6CE5C0F0C8D93C39D2E6CFB80184C75B116A498A2221AA27922D7666BF0
        F21D931D7E7C4B9DCFAA0F3009CA59AA68DE005F5FA12D1F0C72DB2D92DF718D
        717E403BE39E5D370DE7535CCBD40152B533ACCAC97AC6DEB7DB5E94EC976446
        510280F82685F6C8954881113482ABE6BE9579B9FDE65E061F388AF83616C5F6
        E3736265CAE3C23331CC38CA34F3357517D7FC12AB18A63513188271211BA606
        6AE11384A4AAAABB55DAFBD287C27FBEAFDF9687FBA4552A8BBDD234FA0CC7CB
        2CA590D85FB63725231B86D18BA4D7510541C13F31DA6F7C75DD3BD49F26C665
        63B7BB778AB8B333C44691C7A71559E1C499EFB32DEF7EDDAAE14BF966250328
        48C530E434EC6E68DBAC3C40A885C792792A6F7C47BFD2AAEC707A8D95999DC9
        6605874CBEC6B84A8F768F143C6BC9C1C844EAFF007AFAA383FF0029A7ECCEE7
        F8861FE965FCF4DF8A63513188271211BA6066AE11384A4AAAABB55DAFBD6DD5
        BD99C30D9C3E91570BC49FC6E55C2449B93730E5832088DC6565011B5717D4CB
        7BEA7B76A6AA28ACD55D59A001A13FFFD9}
    end
    object Label7: TLabel
      Left = 108
      Top = 4
      Width = 160
      Height = 24
      Caption = 'Crop tiff file / files'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 116
      Top = 32
      Width = 209
      Height = 13
      AutoSize = False
      Caption = 'Select crop offset and set size of crop'
    end
  end
end
