object Formhardproofselect: TFormhardproofselect
  Left = 974
  Top = 367
  BorderStyle = bsDialog
  Caption = 'Hardproof'
  ClientHeight = 246
  ClientWidth = 354
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
  object Label1: TLabel
    Left = 48
    Top = 156
    Width = 114
    Height = 13
    Caption = 'Hard proof configuration'
  end
  object RadioGroupflatprooftype: TRadioGroup
    Left = 274
    Top = 69
    Width = 63
    Height = 81
    Caption = 'Hardproof type'
    ItemIndex = 0
    Items.Strings = (
      'Manual'
      'Automatic'
      'No hardproof')
    TabOrder = 2
    Visible = False
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 354
    Height = 57
    Align = alTop
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object Image2: TImage
      Left = 1
      Top = 1
      Width = 64
      Height = 55
      Align = alLeft
      Center = True
      Picture.Data = {
        07544269746D6170A61A0000424DA61A00000000000036000000280000002F00
        00002F0000000100180000000000701A00000000000000000000000000000000
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF04090E224F7E2953816B585C553C3C0B0808000000FFFFFF00
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFD9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
        D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
        D9D9D7D7D7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF04090E2253833A8ABE5292BE
        4A76A3AA9B9F614C4C000000FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFCFB4B4B4B4
        B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
        B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4CFCFCFFFFFFFFFFFFFFFFFFFFFFF
        FF040A0F2257883A8DC296E7FFC1F2FD4F90BF4472A1807377000000FFFFFF00
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFC2C2C2B4B4B4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB4
        B4B4C2C2C2FFFFFFFFFFFFFFFFFF040A10225B8E3A90C697E7FFC1F2FD90D9F7
        59BDF1267EBE2E6596000000FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB4B4B4B4B4B4FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB4B4B4B4B4B4FFFFFFFFFFFF040A10235F
        933B93C998E7FFC1F2FD90D8F759BDF122A1EC1C7CC2235F92000000FFFFFF00
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFA7A7A7BDBDBDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA7
        A7A7A7A7A7FFFFFF040B112363983C96CD99E8FFC0F2FD8FD8F758BDF122A1EB
        1C7FC6236397040A10000000FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9A9A9AB3B3B3FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9A9A9A9A9A9A040B1123679D3C9AD199E8
        FFC0F2FD8FD8F758BCF122A1EB1C82C923679C040B11000000FFFFFFFFFFFF00
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF404040666666AAAAAAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF41
        41410F1519246BA33C9DD59AE8FFC0F2FD8FD8F758BCF121A1EB1C85CE236BA2
        040B11000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF444444434343434343434343656565A0A0A0FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE9E9E9D3D3D3D3D3D3D3D3D3D3D3D3
        F4F4F4FFFFFFFFFFFFFFFFFFFFFFFF1B2125266DA23DA0D99AE8FFC0F2FD8ED8
        F757BCF121A0EB1C88D1246FA7040C12000000FFFFFFFFFFFFFFFFFFFFFFFF00
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF474747474747
        4F4F4F737373636363676767979797FFFFFFFFFFFFFFFFFFE9E9E99B9B9B6363
        63534F4F595151595050585050585050504E4E6E6E6EBCBCBCFFFFFF6060601F
        2B33297FBE70C4EBC0F1FD8ED8F757BCF121A0EB1C8BD52473AC040C12000000
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFF4C4C4C4B4B4B4F4F4F6C6C6C8F8F8F8F8F8F7373736868688D8D8DF4
        F4F4F4F4F49B9B9B504E4E6858587B5E5E805F5F7F5E5E8768688261617C5A5A
        7B59597156565E51515858581F1F1F2020205E6A76348DCC68BBE857BCF120A0
        EB1C8ED821608B060E14000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5050504F4F4F6363638787878F8F8F
        8F8F8F8F8F8F7F7F7F7A7A7A6A6A6A7878786E6E6E6358588366668D6E6ABDA3
        8BE3D2AAFEF8C5FFFECDFFFFD3FCFBD5D6CCB4AD988D7C5A5A785B5B9F86867B
        6767C6B8B8ABB2BF3492D2249BE31C91DC2A68931E1E1E444444515151FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFF5454
        545454547979799696969696969696969696969696968C8C8C8989896868682F
        2F2F7462628A6C6CC1A285F4E0ACFEF4BFFFFCC8FFFDCBFFFFD0FFFFD5FFFFDB
        FFFFE0FFFFE5EFEBD79E85808465658F7272AE9999B1A1A15B6A772B8ECF2C6D
        993434347E7E7E696969545454545454FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
        0000FFFFFFFFFFFFFFFFFF5858585C5C5C8D8D8D9F9F9F9F9F9F9F9F9F9F9F9F
        9F9F9F9F9F9F9A9A9A9999993B3B3B5A4A4A8F7272D0AF8AFCE8B1FDF3BEFDF3
        BEFEF5C0FFFDCBFFFFD2FFFFD8FFFFDEFFFFE4FFFFEAFFFFEEFFFFF0AF9B967F
        5E5E987D7D6A58583737373030303737378A8A8A9F9F9F9F9F9F7C7C7C585858
        585858FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF5C5C5C6060609999
        99A7A7A7A7A7A7A7A7A7A7A7A7A7A7A7A7A7A7A7A7A7A9A9A97575754B444493
        7777D1AC86FBE4ACFDEEB8FCEBB4FDEEB8FEF7C2FFFECCFFFFD3FFFFDAFFFFE1
        FFFFE7FFFFEDFFFFF3FFFFF7FFFFF6B19C98866666695A5A575757999999A0A0
        A0A7A7A7A7A7A7A7A7A7A7A7A78B8B8B5C5C5C5C5C5CFFFFFFFFFFFFFFFFFF00
        0000FFFFFF616161656565A1A1A1B0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B0
        B0B0B0B0B0B0B1B1B13D3D3D8B7373B4917EFADCA3FCE9B2FCE9B2FBE5ADFDEF
        B8FEF8C3FFFFCDFFFFD4FFFFDBFFFFE2FFFFE8FFFFEFFFFFF6FFFFFCFFFFFAF7
        F5EB8C6E6D5C4C4C6B6B6BB0B0B0B0B0B08FA78F629B629AAA9AB0B0B0B0B0B0
        939393606060616161FFFFFFFFFFFF000000FFFFFF656565A9A9A9B9B9B9B9B9
        B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B98A8A8A5951519A8080EC
        C38EFBE3AAFCE9B2FADEA5FBE5ADFDEEB8FEF7C3FFFECDFFFFD4FFFFDAFFFFE1
        FFFFE7FFFFEEFFFFF4FFFFF8FFFFF7FFFFF2D0C4B9816464454343B9B9B982AF
        830D8B0E0081000081008AAB8AB9B9B9B9B9B9848484656565FFFFFFFFFFFF00
        0000FFFFFF696969C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C5C5C5
        D4D4D4E4E4E48585857E6E6EB89787F9D59AFBE2AAFBE2A9FADBA1FBE4ACFCED
        B6FEF6C1FFFECBFFFFD2FFFFD9FFFFDFFFFFE5FFFFEAFFFFEFFFFFF2FFFFF1FF
        FFEEF8F6E1896B6B554B4B9B9B9B5FB5622AA02D239B251B951D499949C2C2C2
        C2C2C2959595696969FFFFFFFFFFFF000000FFFFFF6D6D6DCBCBCBCBCBCBCBCB
        CBCBCBCBCBCBCBCDCDCDDDDDDDEDEDEDEFEFEFEEEEEE5C5C5C968181CFA787FA
        DBA1FBE1A9FADCA2FBE5ADFEF7C3FEFBCBFFFCD2FFFEDAFFFFDEFFFFD6FFFFDC
        FFFFE1FFFFE6FFFFE9FFFFEBFFFFEBFFFFE8FFFFE4A7908B66575789898978C8
        7C57C25D57C25D57C25D64AA65CBCBCBCBCBCB9C9C9C6D6D6DFFFFFFFFFFFF00
        0000FFFFFF727272D4D4D4D4D4D4D4D4D4D4D4D4DBDBDBEFEFEFF2F2F2F1F1F1
        F0F0F0EFEFEF484848A58D8DE0B58AF9DAA0FAE0A7FCE8B1FDEFB9FBE4ACFBE7
        B0FDF0BAFEF8C3FFFED4FFFFE7FFFFD7FFFFDCFFFFE0FFFFE3FFFFE4FFFFE4FF
        FFE2FFFFE0BCAAA17B65656E6E6EC0D3C182D8887ED68476C87BC7CFC7D4D4D4
        D4D4D4A3A3A3727272FFFFFFFFFFFF000000FFFFFF767676DDDDDDDDDDDDDDDD
        DDE6E6E6F6F6F6F5F5F5F3F3F3F2F2F2F1F1F1F0F0F0473E3BA89191E2B282F9
        D89EFADFA5FCE9B2FADDA3FBE5ADFCEBB8FCEDB8FDF3BEFEFAC7FFFFD8FFFFE4
        FFFFD7FFFFDAFFFFDCFFFFDEFFFFDDFFFFDCFFFFDAC9BBA77D6868656565D4D4
        D4D3D3D3D2D2D2D3D3D3DADADADDDDDDDDDDDDA9A9A9767676FFFFFFFFFFFF00
        0000FFFFFF7A7A7AE6E6E6E6E6E6ECECECF8F8F8F7F7F7F6F6F6F5F5F5F3F3F3
        EED2C5E0703C421702AB9595E2B488F9D69BFADDA4FBE6AEFEF5C1FFFFD1FFFF
        E0FFFEEAFEF5D0FDF4BFFEFBC7FFFFE4FFFFD1FFFFD4FFFFD6FFFFD7FFFFD7FF
        FFD6FFFFD5C0B0A48069676F6D6BD5D5D5D4D4D4D3D3D3D2D2D2D3D3D3E3E3E3
        E6E6E6B0B0B07A7A7AFFFFFFFFFFFF000000FFFFFF7E7E7EEEEEEEEEEEEEF7F7
        F7F9F9F9F8F8F8F7F7F7F6F6F6F0D5C7DE540FDE681E6037169A847FD0A483F9
        D398FADBA1FBE7B0FEF7C2FFFFD4FFFFE3FFFFF2FFFFF7FDF1BFFDF4BFFFFDDB
        FFFECDFFFFCDFFFFCFFFFFD0FFFFD0FFFFD0FFFECEB19D936D4B408E4A28D6D6
        D6D5D5D5D4D4D4D3D3D3D2D2D2E0E0E0EEEEEEB6B6B67E7E7EFFFFFFFFFFFF00
        0000FFFFFF828282F7F7F7F7F7F7FAFAFAFAFAFAF9F9F9F8F8F8F7F7F7E4793D
        E17027E48A43804E2688726AC1A497F7CA8CF9D79CFBE5ADFDF4BFFFFECFFFFF
        DDFFFFE8FFFFEBFDF4CBFCECB6FFFCD4FEF6C3FEF8C4FEFAC6FFFBC7FFFBC8FF
        FFCDF7F0C29C8383604536AF4509DB936BD6D6D6D5D5D5D4D4D4D3D3D3E5E5E5
        F7F7F7BCBCBC828282FFFFFFFFFFFF000000FFFFFF868686FFFFFFFFFFFFFDFD
        FDFBFBFBFAFAFAF9F9F9F4D9CAE15706E99553E99553B67541624A3BB4A0A0EC
        B67EF8D397FADFA7FCEDB7FEFAC6FFFFD2FFFFDAFFFFDBFDF0C0FCEBB5FFFDCE
        FCECB6FDEFB9FDF1BBFDF2BCFEF8C4FEF7C2CFBCA19A818050341DE6813ADF64
        1BD7D7D7D6D6D6D5D5D5D4D4D4E9E9E9FFFFFFC2C2C2868686FFFFFFFFFFFF00
        0000FFFFFF8A8A8AFFFFFFFFFFFFFEFEFEFDFDFDFBFBFBFAFAFAF4D1BBE56A19
        EDA064EDA064EDA0645D3F279B8782C5A493F7C78AF9D89DFBE4ACFDEFB9FEF8
        C3FFFCCAFFFDCBFCEAB3FEF8C3FDEFB9FBE4ACFBE6AFFCE8B1FDF1BCFEF5C0F6
        E3AFA9928E755E54865B39EDA064E35800D8D8D8D7D7D7D6D6D6D5D5D5E9E9E9
        FFFFFFC4C4C48A8A8AFFFFFFFFFFFF000000FFFFFF8E8E8EFFFFFFFFFFFFFFFF
        FFFEFEFEFDFDFDFBFBFBF5D3BCE8701DF3AB74F3AB74F3AB74BE865B5E493CB9
        A6A6D9A983F8CD90F9D99FFBE2AAFCEAB3FCEEB8FDEFB8FDEFB8FCEAB4F9DA9F
        FADBA1FBE4ACFDEEB8FDF0BAFBE3ABBDA5979B84825A412FE8A46FF3AB74E55C
        00D9D9D9D8D8D8D7D7D7D6D6D6EAEAEAFFFFFFC6C6C68E8E8EFFFFFFFFFFFF00
        0000FFFFFF939393FFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFDFDFDF6D5BDEB7621
        F8B684F8B684F9C39AF9C8A1826B58756761BBA9A9DEAD83F7C98BF9D59BFADB
        A2FADFA6FBE2AAFBE4ABFBE0A7FAE1A8FCE8B1FCE9B2FCE8B1F5D6A0C9AF99A5
        90905D4E45B89980F8B784F8B784E76100DBDBDBD9D9D9D8D8D8D7D7D7EBEBEB
        FFFFFFC9C9C9939393FFFFFFFFFFFF000000FFFFFF979797FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFEFEFEF8D7BEEE7C25FCC195FCC195FEF0E4FFFFFFF4F4F46E
        6E6E777171BDABABCDAA95EEB981F8CF92F9D69CF9D99FFADCA2FADEA5FAE0A8
        FAE0A7F9D79CE6C396BEA59AA995955F5B5B9B9B9BFFFFFFFCC195FCC195E966
        00DCDCDCDBDBDBD9D9D9D8D8D8EBEBEBFFFFFFCBCBCB979797FFFFFFFFFFFF00
        0000FFFFFF9B9B9BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9D9BEF08127
        FFC79DFFC79DC47B61A25E518B5858855454422A2A4F4040AC9B9BBEADADD2AC
        93E3B88FF2C491F5BF80F6C68CEBC395DFBA97C6AB9BB5A1A1917E7E33232362
        3E3DAB614EB0624DFFC79DFFC79DEB6A00DDDDDDDCDCDCDBDBDBD9D9D9ECECEC
        FFFFFFCDCDCD9B9B9BFFFFFFFFFFFF000000FFFFFF9F9F9FFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFADBBFF28527FFC79DFFC79DD38E70AD7669A07979BB
        9494BB94948B75754338386F63639A8E8EBFAEAEBEADADBDABABBCAAAABBA9A9
        B3A2A28D7F7F5B4F4F564949A18383977070B87865C47B61FFC79DFFC79DED6F
        00DEDEDEDDDDDDDCDCDCDBDBDBECECECFFFFFFCFCFCF9F9F9FFFFFFFFFFFFF00
        0000FFFFFFA4A4A4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBDCBFF38827
        FFC79DFFC79DFFC79D575A6BA9ABADE5E5E2DEDAD6E7E7E2F4F4F4B1B1B17A7A
        7A4D4D4D635F5F6A65656965655B5959585858909090C7C7C7EDEDE8E3E0DCE3
        E0DCEDEDE9FFC79DFFC79DFFC79DEF7300DFDFDFDEDEDEDDDDDDDCDCDCEDEDED
        FFFFFFD1D1D1A4A4A4FFFFFFFFFFFF000000FFFFFFA8A8A8F4F4F4FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFCDDBFF58B27FFC79DFFC79DFFC79D6E707299A1A6E7
        E7E7DEDEDEDFDFDEDEDEDEDFDFDFDCDCDCE2E2E2DEDEDED3D3D3D3D3D3F4F4F4
        DFDEDEE1DEDEDEDEDEEBEBEBE0E0E0DEDEDEE4E4E4FFC79DFFC79DFFC79DF178
        00E0E0E0DFDFDFDEDEDEDDDDDDEDEDEDFFFFFFCECECEA8A8A8FFFFFFFFFFFF00
        0000FFFFFFABABABB6B6B6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6DDBFA0F68F27
        FFC79DFFC79DFFC79D8B95A0B1B9BDE8E8E6DEDEDAE1E0DDDEDADAE1E0E0DAD7
        D6E2E2DEE7E7E5DEDEDEDEDEDEDEDEDEDEDEDDE0DEDCDFDEDEEEEEECE4E4E0DE
        DEDDE0DDDCFFC79DFFC79DFFC79DF37D00C7C7C7C6C6C6C6C6C6C5C5C5CDCDCD
        D1D1D1ACACACABABABFFFFFFFFFFFF000000FFFFFFAEAEAEAFAFAFAFAFAFAFAF
        AFAFAFAFAFAFAFAFAFAFC5A179F6860AF89327F89327F893274D4D4D697073C3
        D1DACADAE7C9D8E9BECCDFC5D3DFD6E2EBDEDEDEC9C9C9A3A3A3BCBCBCC8C8C8
        DFDFDFC4C4C4CDCDCEC1C1C1C6C6C6C4C4C4CECECEF89327F89327F89327F581
        00AFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAEAEAEFFFFFFFFFFFFFFFFFF00
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF78400F78400
        F78400F78400F784007979793A3F4192A2BEAFC3E8B7C7EFC4D8F0E3F3FBE5ED
        F3BDBCBB999794AAAEACA2A1A096969DD3D3D3949392A7AAA79996949D9B999F
        9D9BA9AAAAF78400F78400F78400F78400FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA2A1A24848487B
        8185CFDADFDFEBEFE2EFEFE5F2EFE5EFEEE8E8E4F1F1EDF7F7F3F7F7F3EAEAE6
        EFEFEBEEEEEAF7F7F3F1F1ECEEEDEAFBFBFBF2F5F5FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFCBCBCB7271704B4947829167A8C086A5BE83A7BF85A7BF
        85A7BE83AAC086A9BE82A1B8749EB771A4BD80A4BD80A4BD80A7BE82D3DDC0DF
        DFDBC9C5C6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5F5F5ABA9A94D
        504C1B2B064875035686075485035A8B0E5C8B105384025A8A0D58890A548504
        5485035E8C135D8B10568708ACC58B9A98996B7590FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFDCDCDC9493963D403B3347116E8E396D962898B8
        697DA344628F1994B4607FA446679323719B3098B56B99B46A64911CACC58B9A
        9CA5757FA9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8F8C7
        C7C77E7C7B302F25475036869F5BB8CA9787A94E759C329FBD738AAA5578A039
        97B3659FBA74A1B97486A84EACC58B9595985A648AFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2F2F2BCBCBC63635F393A345E713BACC2
        86A3BE7694B25FA6C27E93B25E97B86D8EAB589EBA749CB872789E39ACC58798
        958F667089FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFE8E8E99495943C3E3927390980A44A7A9E3B85A84EABC482799E3B80A546
        70992D81A74881A7485F901AACC587B9B39EB2AAA4FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDCACACA7474751E2214304E
        034C711060901D71992F5E90185E90185E90185E90185E9018679626A3B883AB
        A9A5A6A1A4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFF5F5F5C3C5C38B8C8B4E4E4E5454547472728A88879796959B9997
        9F9D9BBBBBBBEEEEE9FFFFF8FFFFFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000}
    end
    object Label7: TLabel
      Left = 88
      Top = 4
      Width = 171
      Height = 24
      Caption = 'Hardproof settings'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 96
      Top = 32
      Width = 249
      Height = 13
      AutoSize = False
      Caption = 'Select hardproof format and necessary approval'
    end
  end
  object RadioGroupapproval: TRadioGroup
    Left = 48
    Top = 69
    Width = 251
    Height = 81
    Caption = 'Page approval'
    ItemIndex = 0
    Items.Strings = (
      'Wait for approval of pages'
      'Ignore approval')
    TabOrder = 1
  end
  object ComboBoxconf: TComboBox
    Left = 48
    Top = 172
    Width = 251
    Height = 21
    Style = csDropDownList
    TabOrder = 3
  end
  object Panel1: TPanel
    Left = 0
    Top = 205
    Width = 354
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    object BitBtn1: TBitBtn
      Left = 97
      Top = 8
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 181
      Top = 8
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
end
