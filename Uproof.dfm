object Formproof: TFormproof
  Left = 547
  Top = 448
  AutoSize = True
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Select proofconfiguration'
  ClientHeight = 156
  ClientWidth = 361
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poMainFormCenter
  OnCreate = FormCreate
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 108
    Width = 361
    Height = 47
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 99
      Top = 12
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 187
      Top = 12
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 361
    Height = 54
    Align = alTop
    Color = clWhite
    ParentBackground = False
    TabOrder = 1
    object Image1: TImage
      Left = 0
      Top = 1
      Width = 49
      Height = 50
      AutoSize = True
      Picture.Data = {
        07544269746D61701E1D0000424D1E1D00000000000036000000280000003100
        0000320000000100180000000000E81C00000000000000000000000000000000
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8F8D4
        E3E3D5E3E3D7E8ECE3F2F4C1CDD19CA4A4C9D2CCB6C6939FB97996AF6797B168
        82A54E93AF608DAB599BB67498B3699FBA769AB46D90AE5F9BB46D84A55097B4
        6BA3BB7C9CB66F7DA1476D952F759C3B759C37AEC487FAFBF6FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8F8CEE0E0D1E6EAB0C1DCDAEAEBA3
        ABAE474546B2BABFCFD9B7BCCB9CACBD87AEC088A7BF7EAEC58AACC188B4C596
        B0C48BB3C591AEBF8AB1C388B7C695ABBF83B5C896B3C58FB0C78DA8BF7D9CB9
        729CB9729CB871C5D4ACC9D3E7C1C5D1C9CBCFC2CBE1FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFF8F8F8CFE0E5D2E3E891A1CBD7E7ECA2AAAE575A6BA9ABADE5E5E2DE
        DAD6E7E7E2E7E7E2E1DDD9E7E6E2E7E3E0E7E7E4E0E0DCE0E0DCE0E0DCE0E0DC
        E3E3DDE1DDD7EDEDE8E3E0DCE3E0DCEDEDE9E9EBE7EDEFEAE7E8E2EEEEE97482
        A0282A30434446656974C7CCD9FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8F8D3E3E3D6E7
        EA9AAFCDD6E7EF9CA5AD6E707299A1A6E7E7E7DEDEDEDFDFDEDEDEDEDFDFDFDC
        DCDCE2E2E2EBEBEBDEDEDEDEDEDEDEDEDEDFDEDEE1DEDEDEDEDEEBEBEBE0E0E0
        DEDEDEE4E4E4E4E4E3E9E4E3B4B1B3595A5B02040A051026091636080D19888E
        9CBCC9E6FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFF8F8F8CFE0E0D2E2E88597C2BFD0E4A8B5C28B95
        A0B1B9BDE8E8E6DEDEDAE1E0DDDEDADAE1E0E0DAD7D6E2E2DEE7E7E5DEDEDEDE
        DEDEDEDEDEDEDEDDE0DEDCDFDEDEEEEEECE4E4E0DEDEDDE0DDDCDCDCD98A8A87
        060E18010B1E09163A10255C1029600C224C656B7ABCC9E6FFFFFFFFFFFFFFFF
        FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        EFF4F4CFE0E0CBDBE0869DCA8C9098888C8F515458656868A5A5A4D7D7D6E4E4
        DFE1DFDFE3E2E2E9E7E2E8E8E6E3E3E2D7D7D7DEDEDEE4E4E4E4E4E4E5E4E3E5
        E4E4EFEFEADCDCDAD7D7D758607336393C0D132307173A0D235D0F2664102A5C
        102F62273E69808AA7BCC9E6FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFECEEEE9FB2CB505C7E1F2127
        2525253030302E2E2E1F1F1F15151514141422262B515151676C7AB3B3B5E9EA
        EEDFDEDEBFBFC1BFBFC1BFBFC1BCBBBCBDBBBDD0D4DFB2BBD44E5B7E161A2502
        0C1F06153A0E225E102C741031761031691D3966405074A7A9AFB4C2E3FFFFFF
        FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFABAEAE27304C202020393939818181A0A0A09D9D9D787878
        5C5C5C5C5C5C4E4E4E3737371F1F1F36373A7F8189A9B0BDE2E2E7E2E2EAE2E2
        EADFE2EAC5CBE06D7A981F2A490A12220613340C2256102A6810327410337610
        327925448A747E94BDBFC1EFF0F1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F9F9F2828283F
        3F3F414141545454888888ADADADADADADA5A5A5ADADADAFAFAFA0A0A07A7A7A
        4B4B4B323232212121393A3F7A83A1B7C1D9DADADCC1C0C8414B5F121820070F
        280D22550F2C64102F6D10337810387F1A408D51669B7183A7E7E9EEFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFA4A4A42E2E2E2D2D2D6D6D6D7676765252525E5E5E71
        7272949596B2B3B4BFC0C1C1C3C3C2C3C4BBBDBDA0A2A27C7D7D6060602D2D2D
        2A2B3091949D585C6F09121F02102308183C10245B102C6B10327312387B2243
        7C5F6B8AADB2BDE7E7EFFBFBFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE0E2E49FA0A14949
        496A6A6A5A5A5A4E4E4E73737357575777797AAAB0B2D3DDE1DCE6EADEE8ECDB
        E6EADDE8EDDBE6EBD7E2E6C0C3C49B9C9D494A4B3333331C1C1C12182A081941
        0D2054102463102967102E6E103779395391707987ACACACD4D5D7EAECF4FBFB
        FDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFE6EAF5838EA43E3E3FA2A2A2BABABA7F7F7F5050505151
        517A7D7DADB8BDCBDADFCFDFE5C7D5DBC7D6DCCFDEE4D5E5ECDAEBF2E9F8FEDF
        E5E7E9ECED838D9348484849494971799030478C102469102970102A691F3A68
        596E938195C5BCBEC1B3B3B3C5C7C9EAEFF7FBFBFDFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD7D7D7
        5555559B9B9BDCDCDCD6D6D6ACACAC626262828586C5D1D6C5D3DBCBD9E0CCDB
        E0C3D1D9C3D1DAC8D7DFCCDBE2DCEDF4E9F8FEE0E6E9FAFEFFCED1D841414198
        9BA4D6D8DC9FA9CA2D4689102C60122A583745656A79A0AEAEB0B7B7B8AEACAB
        AEAEAFDADDE5FBFBFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA0A0A0707070C6C6C6DEDEDED8D8D8
        A0A0A07B7D7FA1ABB1899AA68494A68B9BAE8B9DB18D9FB595A7C0AABBD2C6D3
        E3D5E4EDE9F7FEE1E6E9FAFDFFD6D9E0606060898989D2D2D2AAB1CD2B3D7124
        335E2B374C64747F5F626564676D6B74754641414C4541C3C1C7FBFBFDFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF535353A2A2A2D6D6D6DBDBDBB4B4B4888A8BBFC8CCA2B0BC4F6177
        50628256698B5E72965C7097546A936F82AAA5B1C9CAD7E4E9F7FEE2E6E9FBFD
        FFD9DCE37D7D7D787878848484A6ADC55469A34043523E3831727D78707B7B67
        6C6A76888448453F49443FC0C2C5FBFBFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFF7A88B16C6C6CC7C7C7D5
        D5D5CACACAA1A4A5B8C1C4DFE6ECAAB8C96278997C91BC9EB0DDAEBEEB9CAFD9
        8095BF6C81A8909EB9B3C1D1EAF7FEE2E6E7F3F5F5C0C1C48888886D6D6D4242
        42818FB07288BA4342424A46386E71656B6A656D716C5E61643E39384E4847C3
        C1C7FBFBFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
        FFFFFFFFFFFFFFFFFFFF616161929292CCCCCCD1D1D1B3B4B4BEC7CBCFDCE3D5
        DEE88A9AB25B729B687DB28B9DD5A4B4E99DB1E296ABDA8A9EC78694B0AEBDCC
        E9F7FEE3E7E8ECEEEEAFAFAF7D7D7D6060604D4D4D8191B274829E46443D4F4E
        4275836968726E7E93896A7979454551524D57C2C4CDFBFBFDFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFD0D3DD5B5C
        61A8A8A8C3C3C3CCCCCC949696C9D5D8D1DEE5C6D3E27889A8667CAB4D609B72
        83C08192CD869BD392A7DB9BAED99AA8C4C6D5E3E9F7FEE0E4E7E3E4E5B5B5B5
        7979795454544343438F9CBC778EB3949EA47D807F676A646770777A8B7F646F
        7A505469606376C4C9D5FBFBFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF00FFFFFFFFFFFFFFFFFFBDC0C6646568AFAFAFBABABAAAAAAA989E
        A0D7E4E9D0DEE7BCCBE07486AC788CC14E60966B7CB39CAFE7889CD990A3DCA3
        B3E4ABB7D9CBD9EBE9F7FEDBDFE2CACBCBB0B0B07878785252527475778798BD
        657BA58D98AE525453575D6769737A7D86848392977E89906E7277C9C9D0FBFB
        FDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFC3C3C36C6C6CAAAAAAAEAEAE8E8E8EA8B1B5D2DFE5CFDEE6B3C0D98494
        BB8699C997A7D6A0B0E08D9ED293A3DCA0B0E7A4B2E4A7B2DAC5D1E6E9F7FEDC
        E0E3CFD0D0B1B1B16666664E4E4E797F8E6776907182916F757B5B5F675D6C7D
        5E6A7C5F67788198A299BCCA91AFC0CDD3E0FBFBFDFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFC0C0C0737373A0A0A0
        A3A3A3767676C9D2D7E2F0F6CFDDE7A1AFC77181A4687AA38B99C4A5B3E18798
        C99EACDEA6B3E6A6B4E6A8B3E0C0CEE4E9F7FED4D8DAC2C3C39999995656565B
        5B5B8A90A459596057575A4E4C4A5F5F6560646D53556A53586B60707E7A9BAE
        88A5B8CAD2DEFBFBFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF00FFFFFFFFFFFFFFFFFFFFFFFF8A8A8A9494949292926C6C6CB1BABED0DEE5
        BDCCD8667692607195485A836072A1687AA94D608D6879A5798AB991A2D27D8D
        B7B2C2D9E7F5FCBBBEBEA0A0A08A8A8A828282898B8E676A735E65725250585A
        65785C6E8B5B6B885F748C5B68886C8498749CB57791AACBD1DEFBFBFDFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
        FFFF8383838686868585855F5F5FCAD2D6DBE7EDB7C6D25869878C9FC98A9ECD
        889ACF8495C7798AB97387B76A7EAD6777A244516E9FACBCD6E0E5B0B1B1A0A0
        A08585856B6B6B707B8F697D945863734B4A5C617DA2658BB76381A65E759A63
        7D9B738EA0738FA3738190C7CBD6FBFBFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFF8E8E8E7474747F7F7F55
        5555BFC7CACBD8DDB5C2CE4554738DA0CD99ADE3A5B5EEACBBF0A7B7EA6C7FB2
        5C6E9C4451742D36468C949BC7CACBBDBDBDB9B9B9AAAAAA818288727D92728E
        A25766804A4E73617B9E6179975566935D82B0658FB26B849862798B6A7079C8
        CCD2FBFBFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
        FFFFFFFFFFFFFFFFFFFFB1B8CB6363636363635D5D5DBCC5C7DDE9EEB5C2CD31
        3D557D8EB599ACE0A5B5EC99A9E07F91C63E4E7C3A486B2E3A515B616CA2A3A5
        B8B8B8BEBEBEC7C7C7A3A3A3878E99879CB0729CB7545B674D516262768A5A6A
        86798CB08CB2D06888A86174805156645E5B55C9C8CDFBFBFDFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFD3D6
        E36B6B6B474747434343ACB3B6D4E1E6B6C3CB212A394A566F7888AC95A3CD83
        91BD55659037456A404B685B6373A9ABAEAAAAAAA1A1A18888888F8F8F818181
        7E95B87B98AA7095B06C869B5F72886882976980956B869B718FA36475855258
        65423F4B585051C5C3C9FBFBFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC2C2C25050503636368588
        8AD9E6EAB7C6CC283138333D472F3A4C39445F3A466436435E59647B858C9CD0
        D2D7EDEDEDDCDCDCBABABA8484849696968391B27B9AB57B97A8748CA1677F94
        60758962798B6983967090A8657E90595B654743503D354456565AC1C5D0FBFB
        FDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFE6EAF57988B251545E606162B0B6B9CED7DC7882896E78
        7F6F788082868D868B92989EA5D3D6DAFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDB7
        B9BCA0A6BACBCDE1D5D7E6D5D7E6D2D3E5D1D1E1D1D0DDD1D1DDD8DDE3D6D9E7
        D5D7E6D6D6E2D6D6E2D6D6E2D6D6E3E3E7EEFBFDFDFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        DEE4F2989EAE5C5C5C6F6F6FB7B9BACDD1D3C7CACDBCBFC0ACACACBDBDBDF0F0
        F0FFFFFFFFFFFFFFFFFFFFFFFFFBFBFBE1E1E1B5BBCAD5DCE6F1F1F0DCDCDCE0
        E0E0DEDEDEDEDEDAE2E0E0E6E5E5F1F1EDE0E0DEDEDEDEE6E6E6E6E4E4E6E5E5
        E9E9E8F0F0EEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7E9EE6C7A9B4A4A4A
        676767999999A7A7A7A3A3A39E9E9EA7A7A7CECECEF5F5F5FFFFFFFFFFFFE0E0
        E0B6B9C2A7AEC0DDDBDFECECEAE9E9E8E2E2DDE2E2E2DFDFDFE3E3DEE0E0E0E7
        E7E7EDEDEDE1E1DDDEDEDCDFDFDEE4E3DDDFDFDDE2E2E1F3F3F2FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFE6EAF5A2ABC15C5C5C3F3F3F5B5B5B525252
        4747473D3D3D707070CDCDCDE3E3E3C6C7CCB2B4BA9FABCDD9D9E4F0F0E8EFEF
        EBF2EDEDE2E2E2E2E2E2E7E7E2E2E2E2E2E2E2E7E2E2F4EFEFE9E9E6E3E3E2E7
        E7E2E3E3E2E2E2E2E2E2E2F1F1F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF6D6D6D5E6064818989777C7F71767A666A6A777A83CDD1DA
        D6D6D6B9BCC5E3E3E3E8E8E8E4E4E4E9E9E6E6E6E4ECECE8E5E5E5E2E2E2E5E5
        E5E5E5E5E2E2E2E8E8E8EAEAE7E6E6E6E5E5E5E3E3E2E6E6E2E6E6E5F7F7F6FC
        FCFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4D4D4D69
        7073C3D1DACADAE7C9D8E9BECCDFC5D3DFD6E2EBDEDEDEC9C9C9A3A3A3BCBCBC
        C8C8C8DFDFDFC4C4C4CDCDCEC1C1C1C6C6C6C4C4C4CECECED6D6D6D4D4D4CECE
        CDC7C7C7E2E2E2D6D6D6D4D4D3D1CFCCD7D6D5EFEEECFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7979793A3F4192A2BEAFC3E8B7C7EFC4
        D8F0E3F3FBE5EDF3BDBCBB999794AAAEACA2A1A096969DD3D3D3949392A7AAA7
        9996949D9B999F9D9BA9AAAAAFADAF9C9CA4ACA9AB959493D7D7D7959390B1B1
        B1A8A8A8A9A9A9D6D4D6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFA2A1A24848487B8185CFDADFDFEBEFE2EFEFE5F2EFE5EFEEE8E8E4F1
        F1EDF7F7F3F7F7F3EAEAE6EFEFEBEEEEEAF7F7F3F1F1ECEEEDEAFBFBFBF2F5F5
        E6E6E6ECECECF1F1F1F4F4F4FBFBFBD7D6D6EEEEEEFBFBFBF5F5F5F2F2F2FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCBCBCB7271704B49
        47829167A8C086A5BE83A7BF85A7BF85A7BE83AAC086A9BE82A1B8749EB771A4
        BD80A4BD80A4BD80A7BE82D3DDC0DFDFDBC9C5C6C5C5CBC9C9D5EAEAEADBDBDB
        DEDBD9E1DFDCF0F0F0F7F7F7ECECECF4F4F4FDFDFDFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFF5F5F5ABA9A94D504C1B2B064875035686075485
        035A8B0E5C8B105384025A8A0D58890A5485045485035E8C135D8B10568708AC
        C58B9A98996B75906C7C9C5F6369DADADDD2D2D4D8D6D4D1D1D4D1D1D1DBD7D7
        F0F0EFFAFAF7FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFDCDCDC9493963D403B3347116E8E396D962898B8697DA344628F1994B4
        607FA446679323719B3098B56B99B46A64911CACC58B9A9CA5757FA9717BA45F
        667ADCDCDFDCDCDAD8D8D8D3D3D3D6D6D6D9D9D9F4F4F4F8F8F8FDFDFDFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8F8C7C7C77E7C7B
        302F25475036869F5BB8CA9787A94E759C329FBD738AAA5578A03997B3659FBA
        74A1B97486A84EACC58B9595985A648A616C8E4E5768E9E9E9E7E7E6DBDBDCDE
        DEDEEAEAEAEDEDEDFFFFFFFBFBFBFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFF2F2F2BCBCBC63635F393A345E713BACC286
        A3BE7694B25FA6C27E93B25E97B86D8EAB589EBA749CB872789E39ACC5879895
        8F6670896F84965E5E5DDCDCDCCDCDCDD3D2D2CFCECFE6E4E3F6F6F6F8F8F8FB
        FBFBFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFE8E8E99495943C3E3927390980A44A7A9E3B85A84EABC482799E3B
        80A54670992D81A74881A7485F901AACC587B9B39EB2AAA4ADA69E90856FE3E3
        E3DEDBDBDCD9D7DEDBDBDCDCDCDDDDDDECECECFBFBFBFDFDFDFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDCACACA74
        74751E2214304E034C711060901D71992F5E90185E90185E90185E90185E9018
        679626A3B883ABA9A5A6A1A49C9B9992938B95939094918F94918F95918F9391
        8F93908E989694C3C2C1FAFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5F5F5C3C5C38B8C8B4E4E4E54545474
        72728A88879796959B99979F9D9BBBBBBBEEEEE9FFFFF8FFFFFBFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF00}
    end
    object Label5: TLabel
      Left = 76
      Top = 4
      Width = 218
      Height = 24
      Caption = 'Select soft proof setting'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 84
      Top = 32
      Width = 189
      Height = 13
      Caption = 'Select setting for generation of previews'
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 54
    Width = 361
    Height = 54
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object Label1: TLabel
      Left = 60
      Top = 8
      Width = 129
      Height = 13
      AutoSize = False
      Caption = 'Proof format'
    end
    object ComboBoxsoftproof: TComboBox
      Left = 60
      Top = 20
      Width = 245
      Height = 21
      Style = csDropDownList
      TabOrder = 0
    end
  end
end
