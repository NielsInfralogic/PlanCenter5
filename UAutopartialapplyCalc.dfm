object FormCalcAutopart: TFormCalcAutopart
  Left = 814
  Top = 392
  BorderIcons = [biMinimize, biMaximize]
  Caption = 'Auto Partial'
  ClientHeight = 316
  ClientWidth = 432
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 53
    Width = 432
    Height = 141
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alTop
    Caption = 'Apply plans to the following sections'
    TabOrder = 0
    ExplicitWidth = 428
    object ListViewSections: TListView
      Left = 50
      Top = 15
      Width = 380
      Height = 124
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      Checkboxes = True
      Columns = <
        item
          Caption = 'Section'
          Width = 59
        end
        item
          Caption = 'Number of pages'
          Width = 98
        end>
      GridLines = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnChange = ListViewSectionsChange
      OnChanging = ListViewSectionsChanging
      ExplicitWidth = 376
    end
    object Panel4: TPanel
      Left = 2
      Top = 15
      Width = 48
      Height = 124
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
      object BitBtn3: TBitBtn
        Left = 4
        Top = 34
        Width = 40
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000000000000000000000000000000000000D8E9ECD8E9EC
          D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9
          ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC52AF5B52A85A509F575097544E8F524D
          87504D824F4D814F4D814F4D824F4D814F4D774ED8E9ECD8E9ECD8E9EC54B865
          5DC57B5BC27757BD6D55BB6652B75F50B3584EB2544EB1534EB1534EB1534EB5
          534D9D514D774ED8E9ECD8E9EC59BF6E62CD8A60CB835CC87A59C77155C46752
          C26050C1594EBF544EC0544EBF544EC4554EB5544D814FD8E9ECD8E9EC59BD6F
          62CB8860C9855EC77E5BC57557C26C54C06552BD5E4FBB574EBA544EB9544EBF
          544EB0534D814FD8E9ECD8E9EC59BF6E65CC8A5BC5755BC5755BC5755BC5755B
          C5755BC5755BC5755BC5755BC5755BC5754EB1534D814FD8E9ECD8E9EC5EC074
          71D29562CB86FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6BCE
          8D4EB1534D814FD8E9ECD8E9EC63C37983D9A46BCE8DFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF6BCE8D4EB0534D814FD8E9ECD8E9EC69C77F
          98E0B478D39881D7A0FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6ACD8C6BCE
          8D4EB0534D814FD8E9ECD8E9EC70C984A8E5C081D7A081D7A081D7A0FEFEFEFF
          FFFFFFFFFFFFFFFF60C98265CB8862CB864EB1544D814FD8E9ECD8E9EC73CB87
          B3E7C88DDAAA78D39878D39878D398FFFFFFFFFFFF59C4735DC77C60C98452C4
          6050B2574D834FD8E9ECD8E9EC74CB88BAEACDA0E1B87BD49A77D2976DCF8F69
          CD8C65CC8962CB835DC57758C26D54C46551B55B4E8850D8E9ECD8E9EC73CB88
          B7EACBB1E7C593DDAE87D9A580D69F7AD49A73D0946CCE8F62C9815BC57457C7
          6C52B8604E8F52D8E9ECD8E9EC64C279A1E3BBB7EACBB3E7C8AAE5C0A4E3BB9A
          E0B68CDBAB77D49A68CD8C60CA7F59CB7554B9654F9152D8E9ECD8E9ECD8E9EC
          58BD6D58BD6E58BD6D58BD6D58BD6D58BD6D58BD6D58BD6D58BD6D57BC6C55B6
          6651A75BD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
          E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC}
        Layout = blGlyphTop
        TabOrder = 0
        OnClick = BitBtn3Click
      end
      object BitBtn4: TBitBtn
        Left = 4
        Top = 69
        Width = 40
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFD8E9EC52AF5B52A85A509F575097544E8F524D
          87504D824F4D814F4D814F4D824F4D814F4D774ED8E9ECFFFFFFFFFFFF54B865
          5DC57B5BC27757BD6D55BB6652B75F50B3584EB2544EB1534EB1534EB1534EB5
          534D9D514D774EFFFFFFFFFFFF59BF6E62CD8A60CB835CC87A59C77155C46752
          C26050C1594EBF544EC0544EBF544EC4554EB5544D814FFFFFFFFFFFFF59BD6F
          62CB8860C9855EC77E5BC57557C26C54C06552BD5E4FBB574EBA544EB9544EBF
          544EB0534D814FFFFFFFFFFFFF59BF6E65CC8A62CB8660C9845DC77C59C473FF
          FFFFFFFFFF50BC5B4EBB554EBA544EC0544EB1534D814FFFFFFFFFFFFF5EC074
          71D2956BCE8D65CB8860C982FFFFFFFFFFFFFFFFFFFEFEFE50BC594EBB544EC0
          544EB1534D814FFFFFFFFFFFFF63C37983D9A478D3986ACD8CFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFEFEFE50BB574EC0544EB0534D814FFFFFFFFFFFFF69C77F
          98E0B481D7A0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4FC0
          564EB0534D814FFFFFFFFFFFFF70C984A8E5C08DDAAAFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF50C15B4EB1544D814FFFFFFFFFFFFF73CB87
          B3E7C898DEB278D39871D09365CC8963CB8662CA845DC57A59C37155C16752C4
          6050B2574D834FFFFFFFFFFFFF74CB88BAEACDA0E1B87BD49A77D2976DCF8F69
          CD8C65CC8962CB835DC57758C26D54C46551B55B4E8850FFFFFFFFFFFF73CB88
          B7EACBB1E7C593DDAE87D9A580D69F7AD49A73D0946CCE8F62C9815BC57457C7
          6C52B8604E8F52FFFFFFFFFFFF64C279A1E3BBB7EACBB3E7C8AAE5C0A4E3BB9A
          E0B68CDBAB77D49A68CD8C60CA7F59CB7554B9654F9152FFFFFFFFFFFFD8E9EC
          58BD6D58BD6E58BD6D58BD6D58BD6D58BD6D58BD6D58BD6D58BD6D57BC6C55B6
          6651A75BD8E9ECFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        Layout = blGlyphBottom
        TabOrder = 1
        OnClick = BitBtn4Click
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 194
    Width = 432
    Height = 81
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    Caption = 'Number of pages pr. pressrun'
    TabOrder = 1
    ExplicitWidth = 428
    ExplicitHeight = 80
    object ListViewruns: TListView
      Left = 2
      Top = 49
      Width = 428
      Height = 30
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      Columns = <
        item
          Caption = 'Number of pages'
          Width = 98
        end
        item
          Caption = 'Press run number'
          Width = 98
        end>
      GridLines = True
      RowSelect = True
      PopupMenu = PopupMenuRuns
      TabOrder = 0
      ViewStyle = vsReport
      ExplicitWidth = 424
      ExplicitHeight = 29
    end
    object Panel1: TPanel
      Left = 2
      Top = 15
      Width = 428
      Height = 34
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitWidth = 424
      object Label1: TLabel
        Left = 16
        Top = 8
        Width = 112
        Height = 13
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Total number of pages :'
      end
      object EditNtotpages: TEdit
        Left = 130
        Top = 4
        Width = 44
        Height = 21
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 0
        Text = '96'
      end
      object Edit1: TEdit
        Left = 280
        Top = 0
        Width = 118
        Height = 21
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        TabOrder = 1
        Text = 'Edit1'
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 432
    Height = 53
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alTop
    Color = clWhite
    ParentBackground = False
    TabOrder = 2
    ExplicitWidth = 428
    object Image3: TImage
      Left = 1
      Top = 1
      Width = 61
      Height = 51
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alLeft
      Center = True
      Picture.Data = {
        07544269746D61700E1F0000424D0E1F00000000000036000000280000003E00
        00002A0000000100180000000000D81E0000120B0000120B0000000000000000
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF622E2155271C55271C
        55271CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF562E1841342B3B38363B3836463D39552D184A
        201455281CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF3C39374A49485A58586767676867685957574A4948453C395527
        1C4A2014622D20FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF622E2155271C55271C55
        271C6767676868685957575A58585957585957575A58574948484A4948553829
        4C23174F2219723525FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF562E1841342B3B38363B3836463D39552D184A20
        1455281C6868686767676767675856575A58584A494877777767676649484758
        321A4A201455271CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF3C39374A49485A58586767676867685957574A4948453C3955271C
        4A2014622D205957585A58576767674A49489898988586867777775A58574C43
        3D562E18491E14622E21FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF622E2155271C55271C5527
        1C6767676868685957575A58585957585957575A58574948484A49485538294C
        23174F22197235255A5858777777A3A3A39697968687877777776767674A4948
        553F334B22164F2218723525FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFF562E1841342B3B38363B3836463D39552D184A2014
        55281C6868686767676767675856575A58584A49487777776767664948475832
        1A4A201455271CACACACACACACA1A1A29797978687877777777777775A57574A
        4847553828491F1455281CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFF3C39374A49485A58586767676867685957574A4948453C3955271C4A
        2014622D205957585A58576767674A49489898988586867777775A58574C433D
        562E18491E14622E21ACACAD9797978687878687877676767777776767675957
        57544B48562E18491F14622D21FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5538284A4948
        6767676868685957575A58585957585957575A58574948484A49485538294C23
        174F22197235255A5858777777A3A3A39697968687877777776767674A494855
        3F334B22164F2218723525979798969696878787868787777777777777676766
        5A585857463B54271B4A2014FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF68361F4948476767677777776867675A
        58586868686767676767675856575A58584A494877777767676649484758321A
        4A201455271CACACACACACACA1A1A29797978687877777777777775A57574A48
        47553828491F1455281C97979696969786878786888778777777777767676768
        6868595757553828491F1455271CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF63412D5A58577676767776775957586867677676767777
        777676765957585A58576767674A49489898988586867777775A58574C433D56
        2E18491E14622E21ACACAD979797868787868787767676777777676767595757
        544B48562E18491F14622D219696969797968687868586867676767777767777
        765A585858514E57311A4A2014FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF58463C6868678687877777775A5858777777868787767676767676595757
        5A58586868675A5858777777A3A3A39697968687877777776767674A4948553F
        334B22164F22187235259797989696968787878687877777777777776767665A
        585857463B54271B4A2014969697989898858686858687868787868787767676
        544B49595758544B4955271B491F13FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF58514E7675
        758687877676766868688687878687878586867777775A585968686776767767
        67675A5857ACACACACACACA1A1A29797978687877777777777775A57574A4847
        553828491F1455281C9797969696978687878688877877777777776767676868
        68595757553828491F1455271C969697979797979797979796877575544B4A55
        4C4A5957575A58576747354B221654271BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF73442A595757868787878787767676
        686868969697969696868787767677595757777777767677767676595758B5B6
        B6C6C7C8B6B5B5ACACAD97979786878786878776767677777767676759575754
        4B48562E18491F14622D21969696979796868786858686767676777776777776
        5A585858514E57311A4A2014A1A1A1ACACACA6A8A8786767685A5B5A5858544B
        49544B495957575A585858311A491F14FFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
        FFFFFFFFFFFFFFFFFFFF66473467686897979786878767676678777797979796
        9696868787686867686868868787868787767676686868B6B5B5D3D3D3C5C6C6
        C5C7C7ACACAC9797969797989696968787878687877777777777776767665A58
        5857463B54271B4A201496969798989885868685868786878786878776767654
        4B49595758544B4955271B491F139B8484776767675959685A5B67595A544B49
        554C49595758686867664735491F14723525FFFFFFFFFFFF0000FFFFFFFFFFFF
        FFFFFF6A584F767575979797868787676767868787A2A2A3A2A2A38687876868
        68777777969696868786777676676768C5C6C6DADBDBD4D4D4D2D3D3C6C7C8B6
        B6B5ACACACA2A2A2979796969697868787868887787777777777676767686868
        595757553828491F1455271C969697979797979797979796877575544B4A554C
        4A5957575A58576747354B221654271B776767776666675959685A5A5A585854
        4B495A585867686764412C4F2218FFFFFFFFFFFF0000FFFFFFFFFFFF67686886
        8787A1A1A2868787767675979797ACACAD979797767676767676969696979797
        969796777777787777DADBDBDADADBDBDBDBDADBDBD2D2D2B6B7B7B6B6B6B6B6
        B6ACACACA1A1A29898989696969797968687868586867676767777767777765A
        585858514E57311A4A2014A1A1A1ACACACA6A8A8786767685A5B5A5858544B49
        544B495957575A585858311A491F147766667766667767676759596759595A58
        587F808067676755271B723525FFFFFF0000FFFFFF78706B969696A1A1A27777
        77858686ABACABACACAC979797676767858686A2A2A2A3A3A396969777777697
        9796EBEBEBE3E3E2E3E4E4E3E3E4C6C7C8DADADBDBDBDCC5C6C6B5B5B5B6B6B6
        B5B5B5ABABABA3A3A3969697989898858686858687868787868787767676544B
        49595758544B4955271B491F139B8484776767675959685A5B67595A544B4955
        4C49595758686867664735491F1472352577676778676867595A786767979797
        77777763402C713524FFFFFF0000FFFFFF7A6255767676787777969796ABABAB
        ACACAC868787767676979AA79A9FB5979AA7828595707481BCC0C3F2F2F3EBEB
        EBEAEAEAE3E4E4B5B5B5979797A3A3A3C5C7C7DADADAD2D3D3C5C7C7B6B6B6B5
        B6B6B5B6B6ABABACA2A2A3969697979797979797979796877575544B4A554C4A
        5957575A58576747354B221654271B776767776666675959685A5A5A5858544B
        495A585867686764412C4F2218877575776767786767A2A2A296979686878666
        4735FFFFFFFFFFFF0000FFFFFF8A695A868887A2A2A3ACACAD9797977777777D
        83939BA0B6939CC18992B66A749F747DAABBC6F4C8E5FAD3D9F4D2D8F3EBEBEC
        C6C7C7969696979797979797979797A2A2A2C6C7C8D9D9DAD3D3D3C5C7C7B5B5
        B5B5B5B5ABABABA1A1A1A1A1A1ACACACA6A8A8786767685A5B5A5858544B4954
        4B495957575A585858311A491F147766667766667767676759596759595A5858
        7F808067676755271B723525877576B5B5B5B6B6B6ABACAB777777753E1EFFFF
        FFFFFFFF0000FFFFFFFFFFFF8687869696969797977175828992B59AA5C98D9B
        CA7584C25A68A6798BD2A5B4F9ADD9FFADCDFCBBC6F4BAC6F3D2D8F3E2E4F3EB
        EBEBC6C7C8A1A1A2979797979797979797A1A0A1C5C6C6DADADAD3D3D3C6C7C8
        B5B5B5B6B5B5B5B5B5B6B6B69B8484776767675959685A5B67595A544B49554C
        49595758686867664735491F1472352577676778676867595A78676797979777
        777763402C713524C6C7C8C5C6C6B6B6B59696967A6255FFFFFFFFFFFFFFFFFF
        0000FFFFFFFFFFFFFFFFFF8775757D83939AA4C995A0D38594D46377C64F65C5
        6982F46A83F56882F49BF4FA869FF892A4F37583C18C9ACABAC3E6E1E4F3F2F2
        F2EBEBEBC6C7C8A2A2A2979797969696969697A3A3A3C5C7C7D3D4D4C6C7C7C5
        C6C6CED1D7A69998846F6F836F6F776767776666675959685A5A5A5858544B49
        5A585867686764412C4F2218877575776767786767A2A2A29697968687866647
        35D3D4D3D2D3D2D3D3D3ABACAB79706CFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
        FFFFFFFFFFFFFF818494A9ABD3A6DAEA7F97DB5065CA3F5EE44867F23A65F13A
        65F23B65F2A6F5FC4867F25774F3889EF88FA0E7818EC4939CC1CDD1D6F1F1F2
        EBEBECEAEBEBC6C7C7ABABAB969697969696969796C5C7C7DADBDCD3D3D3A79A
        9993797A937A7A8876768675757766667766667767676759596759595A58587F
        808067676755271B723525877576B5B5B5B6B6B6ABACAB777777753E1ED9DADA
        D3D3D3A1A1A179706CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
        FFFFFF7B6C7D626DA06377C596EEF14A7EF53B66F23B66F265B6FC2B67F264B5
        FC77E7FA3A65F23B66F24766F17A93F6A6B5F9A5B2E49AA4C9A9AAB7D4D4D4F2
        F2F4EAEAEAEBEBECD2D2D2ACACADD4D4D4E3E3E4D7C7C7B69594A68888A78989
        9A8584937A7A937979887676836E6E77676778676867595A7867679797977777
        7763402C713524C6C7C8C5C6C6B6B6B59696967A6255E3E3E3C5C6C69898988B
        6B5AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
        FFFF6B567C5369D15080F59CF3FA5BA7F92A68F29CF3FA3983F565E7FA64D7FD
        2A67F23A84F53B66F24867F26060C6826FB2A9AAD3CFD4E9BDC0C4ABABABC6C7
        C7EAEAEAEBEBEBEBECECE2E3E2D1B7B7C19C9CB69594B69595A88A8AA8898AA7
        898A998483937A7A877576877575776767786767A2A2A2969796868786664735
        D3D4D3D2D3D2D3D3D3ABACAB79706CE3E4E4B5B5B58B837E975638FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFF805C726477
        C64867F23B60F15BA6F963F0FB66CAFC63D6FD77E6F93AE2FF65C9FC66C9FB73
        D0FF295AF1264DE43F4CD87061B7836AA394749ACDB2B5E3E3E3C6C7C8A6A8A8
        C5C7C7EBEBECEBEBEBE3E3E3D7C7C7C6A5A6C29C9CB69594B79595A78989A789
        89998483937A7A937979877576B5B5B5B6B6B6ABACAB777777753E1ED9DADAD3
        D3D3A1A1A179706CC6C7C7979797956F5BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFF784B585759AE2851E6
        295BF12A67F264D7FD12D4FE65E8FA24D9FF13D5FE75F2FE6AF1FC2A77F42A68
        F22C63EB4A7BEA7FAADC8C9AC994749AA57988AB7777C5A4A5E4DBDBC6C7C7A7
        A9A8BDC0C4E3E3E3EBEBEBE3E3E3D6C6C6C5A5A5B69594B69594B59593A58888
        A68887A78989C6C7C8C5C6C6B6B6B59696967A6255E3E3E3C5C6C69898988B6B
        5AA2A2A3977766FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFF4735852638B54F9ADE66
        CAFC65C8FB66E8FB06CCFF06CCFF07CBFF0FD2FF8CF2FB5ADEFC6AF0FC9BF3FA
        76C7F95870D97962AD8C6E9EA57988B07D7DAA7676AB7776B69594D7C7C7D3D3
        D3ACACACB6B5B5DADADBEBEBECE2E3E3D7C7C7C19B9BB69594B59594C6A5A5D3
        D4D3D2D3D2D3D3D3ABACAB79706CE3E4E4B5B5B58B837E9756389B8584A05931
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFF3932992639B62746BB4798DC57E5
        FB06CBFF06CCFF06CCFF07CCFF06CBFF13D6FF56E5FC57B8FB2B68F3295BF157
        74F39297E39480B09E7288AB7777AB7777AB7776AB7776A26C6CAB7776D1B7B7
        D3D3D2ABABACB6B7B6D4D4D3EBEBEBE3E3E3D7C7C7D6C6C6DADBDBD9DADAD3D3
        D3A1A1A179706CC6C7C7979797956F5BA89B9AFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        0000FFFFFFFFFFFFFFFFFFFFFFFF3932982638B52856C457ACE256E4FB12D4FE
        07CBFF06CBFF06CCFF05CCFF39E0FE64D6FD2A80F52A76F43A65F24667EA788B
        D2A7B4E4D0CFE4D3B8B8AB7777AC7777AB7676A16C6CAB7777D7C7C7F2F2F2F2
        F1F2DADADBABABABC5C6C7E7E8E8E3E4E4E3E3E4E3E3E3C5C6C69898988B6B5A
        A2A2A3977766B6B5B5A78A79FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
        FFFFFFFFFFFFFFFFFFFF5967A57CC9E68CF2FB62F0FB57E4FC57E4FB06CCFF06
        CCFF06CBFF0ED1FD66E8FB64D7FE80E0FA3A83F53A65F26982F4A6B5F9A5B2E3
        A9ABB7C6C7C8E3E4E4D7C7C7B68989C6A5A5F2F2F2F2F2F2FFFEFDF2F2F3F2F2
        F2F3F3F4F2F2F3EAEAEAECECECE3E4E4B5B5B58B837E9756389B8584A05931FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
        FFFFFF8C92907994AD4B71C8335CC62855C44696DA46E5FD56E4FC25D9FF0ED1
        FE57E5FC47E6FE2874D1274DC52751D6264DE55872DB97A9E8CCD5FCF0F3FFEB
        EBEBC5C7C7B6B7B6D7DAD9F2F2F2F2F2F2FFFEFDFFFEFDFFFEFDFFFEFDF1F2F3
        F2F2F2F2F2F3C6C7C7979797956F5BA89B9AFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFF85
        3D436536623732A22638B5284EC69BF3FA4796DA56E4FB67E9FC58E5FC6BC2E8
        66E8FB77E6F92746BB2639B63831975E46787E739A9196B8C6C7C8EBEBEBFFFE
        FDFFFEFDDADBDBB5B5B5C6C7C8E2E3E3FFFEFDF2F2F2F2F2F2F2F2F2DBDBDBA2
        A2A3977766B6B5B5A78A79FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFF723A
        545437772638B6335DC62855C32854C46AF0FC509ADF6BC3E94797DA2754C47D
        DEED72BADF2929A34C2F6B683449FFFFFFFFFFFFFFFFFFB59493B6B6B5D4D4D4
        F2F2F2F2F2F2ECECECF2F2F2FFFEFDF2F2F2F2F2F3B5B5B59B8584A05931FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF723A55
        4735852638B52638B63462C99AF3FA2857C52857C44F8DD22638B62638B579BE
        DC64779E5D2E48FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFA7A3C5
        C7C7E3E4E3F2F2F2F2F2F2D4D4D4A89B9AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF723A5354
        37773831974B71C87CCAE72639B62638B52639B62538B53932984B2D69868787
        794C58FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB79A
        88B2B0B0B6B5B5A78A79FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF763A4A6C37
        557993AD5A68A63F308D4134914735855336766B3654FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF843D4292A29B
        6835496B3755FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000}
    end
    object Label8: TLabel
      Left = 67
      Top = 4
      Width = 379
      Height = 23
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      AutoSize = False
      Caption = 'Apply multiple pressrun to production'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -18
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label10: TLabel
      Left = 67
      Top = 31
      Width = 284
      Height = 13
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      AutoSize = False
      Caption = 'Select sections and define size of pressruns'
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 275
    Width = 432
    Height = 41
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitTop = 274
    ExplicitWidth = 428
    object BitBtn1: TBitBtn
      Left = 149
      Top = 8
      Width = 73
      Height = 25
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 231
      Top = 8
      Width = 75
      Height = 25
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object PopupMenuRuns: TPopupMenu
    Left = 228
    Top = 273
    object Add1: TMenuItem
      Caption = 'Add'
      OnClick = Add1Click
    end
    object Delete1: TMenuItem
      Caption = 'Delete'
      OnClick = Delete1Click
    end
  end
end