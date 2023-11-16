object FormSettings: TFormSettings
  Left = 329
  Top = 1
  Caption = 'Application settings'
  ClientHeight = 680
  ClientWidth = 755
  Color = clBtnFace
  ParentFont = True
  Position = poMainFormCenter
  StyleElements = []
  OnActivate = FormActivate
  OnCreate = FormCreate
  TextHeight = 15
  object Label4: TLabel
    Left = 408
    Top = 416
    Width = 125
    Height = 15
    Caption = 'Reimage external status'
  end
  object Label5: TLabel
    Left = 416
    Top = 408
    Width = 34
    Height = 15
    Caption = 'Label5'
  end
  object Label6: TLabel
    Left = 408
    Top = 408
    Width = 130
    Height = 15
    Caption = 'Re-image external status'
  end
  object Label22: TLabel
    Left = 622
    Top = 242
    Width = 21
    Height = 15
    Caption = 'min'
  end
  object Label45: TLabel
    Left = 472
    Top = 408
    Width = 176
    Height = 15
    Caption = 'External status to set on re-image'
  end
  object Label59: TLabel
    Left = 24
    Top = 143
    Width = 143
    Height = 15
    Caption = 'Central Excel archive folder'
  end
  object Label65: TLabel
    Left = 32
    Top = 160
    Width = 40
    Height = 15
    Caption = 'Label65'
  end
  object Label70: TLabel
    Left = 64
    Top = 584
    Width = 14
    Height = 15
    Caption = 'De'
  end
  object Panel1: TPanel
    Left = 0
    Top = 638
    Width = 755
    Height = 42
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 295
      Top = 7
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 392
      Top = 7
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
      OnClick = BitBtn2Click
    end
  end
  object Panela: TPanel
    Left = 0
    Top = 0
    Width = 755
    Height = 54
    Align = alTop
    Color = clWhite
    ParentBackground = False
    TabOrder = 2
    object Image1: TImage
      Left = -4
      Top = 55
      Width = 51
      Height = 51
      AutoSize = True
      Picture.Data = {
        07544269746D61704A1F0000424D4A1F00000000000036000000280000003300
        0000330000000100180000000000141F00000000000000000000000000000000
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBF4F4F4EEEEEEEEEEEEEEEEEEEE
        EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
        EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
        EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEF0
        F0F0F8F8F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFEEEEEEC6C5C4ABABAB9B9B9C9999999999999999999999
        9999999999999999999999999999999999999999999999999999999999999999
        9999999999999999999999999999999999999999999999999999999999999999
        9999999999999999999999999999999999999999999999999999999E9E9EB8B8
        B8E5E5E5F9F9F9FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFB
        FBFBDDDCDCBD7049CC6633CC6633CC6633CC6633CC6633CC6633CC6633CC6633
        CC6633CC6633CC6633CC6633CC6633CC6633CC6633CC6633CC6633CC6633CC66
        33CC6633CC6633CC6633CC6633CC6633CC6633CC6633CC6633CC6633CC6633CC
        6633CC6633CC6633CC6633CC6633CC6633CC6633CC6633CC6633B66841787777
        A0A0A0F1F1F1FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFCCA792CC66
        33E6A98FEAB49CEBB9A2EBB9A2EDBFA9EDBFA9EDBFA9EDBFA9EDBFA9EDBFA9ED
        BFA9EDBFA9EDBFA9EDBFA9EDBFA9EDBFA9EDBFA9EDBFA9EDBFA9EDBFA9EDBFA9
        EDBFA9EDBFA9EDBFA9EDBFA9EDBFA9EDBFA9EDBFA9EDBFA9EDBFA9EDBFA9EDBF
        A9EDBFA9EDBFA9EDBFA9EDBFA9EBB9A2EAB6A0EAB49CE6A98FCC6633886D5CA3
        A3A3FBFAF9FFFFFFFFFFFF000000FFFFFFFFFFFFFBFAF9CC6633E3A489EAB6A0
        EDBFA9EDBFA9EEC2ADF0C5AEF0C5AEF1C6B1F1C6B1F1C6B1F1C6B1F1C6B1F1C6
        B1F1C6B1F1C6B1F1C6B1F1C6B1F1C6B1F1C6B1F1C6B1F1C6B1F1C6B1F1C6B1F1
        C6B1F1C6B1F1C6B1F1C6B1F1C6B1F1C6B1F1C6B1F1C6B1F1C6B1F1C6B1F1C6B1
        F1C6B1F1C6B1F0C5AEEEC2ADEDBFA9A78D80EAB6A0E4A184CC6633787777E8E8
        E8FFFFFFFFFFFF000000FFFFFFFFFFFFDA9877E4A184E7B099716B698D8D8D8D
        8D8DF0C5AEF1C6B1F2C8B0F2C8B0F1C6B1F1C6B1F1C6B1F1C6B1F1C6B1F1C6B1
        F1C6B1F1C6B1F1C6B1F1C6B1F1C6B1F1C6B1F1C6B1F1C6B1F1C6B1F1C6B1F1C6
        B1F1C6B1F1C6B1F1C6B1F1C6B1F1C6B1F1C6B1F1C6B1F1C6B1F1C6B1F2C8B0F1
        C6B1F1C6B1F0C5AE6565659B9B9C999999E7B099E4A184AA6847C3C3C3FBFBFB
        FFFFFF000000FFFFFFFFFFFFCC6633E6A98FEAB49C868686898988969696A78D
        80F0C5AEE6BEA9CCA792CCA792D7B19AF0C5AEF3C8AEF3C8AEF3C8AEF3C8AEF3
        C8AEF3C8AEF3C8AEF3C8AEF3C8AEF2C8B0F2C8B0F2C8B0F2C8B0F3C8AEF3C8AE
        F3C8AEF3C8AEF3C8AEF3C8AEF3C8AEF3C8AEF2C8B0F0C5AED7B19AC7A38DD4AB
        93EDBFA9C0C0BFC0C0BF828282EAB49CE6A98FCC6633ADADADF5F5F5FFFFFF00
        0000FFFFFFFFFFFFCC6633E6A98FEAB49C716B69CCCCCCC6C5C4F2C5AAF4C7AC
        D7B19A9277667A6356A98975EFC2A8F3C8AEF3C8AEF3C8AEF3C8AEF3C8AEF3C8
        AEF3C8AEF3C8AEF0C5AEE6BEA9E4B99EE0B69FE6BEA9F2C5AAF3C8AEF3C8AEF3
        C8AEF3C8AEF3C8AEF3C8AEF3C8AEF3C8AEE6BEA9A6836D7A6356927766D7B19A
        716B69969696716B69EAB49CE6A98FCC6633ACACACF4F4F4FFFFFF000000FFFF
        FFFFFFFFCC6633E6A98FEAB49CEEB99CEFBDA0F1C1A5F3C3A6F2C5AAA8A7A8A0
        A0A0656565886D5CEFC2A8F5C8ABF5C8ABF5C8ABF5C8ABF5C8ABF5C8ABF5C8AB
        F5C8ABE3BAA2B6937C8D7E73927766B6937CD7B19AF5C8ABF5C8ABF5C8ABF5C8
        ABF5C8ABF5C8ABF5C8ABF4C7AC958984A0A0A0ADADAD6B574ACCA792F1C1A5EF
        BDA0EBB9A2EAB49CE6A98FCC6633ABABABF4F4F4FFFFFF000000FFFFFFFFFFFF
        CC6633E8A887E8AE95EEB99CEFBDA0F1C0A1F1C1A54A4A4AFBFAF9F9F9F98686
        863B3A3AEFBDA0F5C6A8F5C6A8F5C6A8F5C6A8F5C6A8F5C6A8F5C6A8F5C6A88D
        8D8D8D8D8D8D8D8D8D8D8D886D5CD4A587F5C6A8F5C6A8F5C6A8F5C6A8F5C6A8
        F5C6A8F5C6A85C5753C7C6C7F9F9F9FCFCFC131313D4AB93F1C0A1EFBDA0EEB9
        9CE8AE95E3A489CC6633ABABABF4F4F4FFFFFF000000FFFFFFFFFFFFCC6633E8
        A887E8AE95EEB796EEB99CEFBDA0F4C2A03B3A3ACFCFCFCCCCCC717070272626
        EFBDA0F5C5A5F5C5A5F5C5A5F5C5A5F5C5A5F5C5A5F5C5A5F5C5A5ADADADADAD
        ADADADADACACAC886D5CC7A38DF5C5A5F5C5A5F5C5A5F5C5A5F5C5A5F5C5A5F5
        C5A5515051A8A7A8CCCCCCD8D8D8131313D4A587EFBDA0EEB99CEAB49CE8AE95
        E3A489CC6633ABABABF4F4F4FFFFFF000000FFFFFFFFFFFFCC6633E4A184E6A9
        8FECB293EEB796EEB99CF3BD993B3A3AADADADA8A8A861605F272626EEB99CF4
        C09DF4C09DF4C09DF4C09DF4C09DF4C09DF4C09D4A4A4AFBFFFFFBFFFFFBFFFF
        FBFFFF272626C69E83F4C09DF4C09DF4C09DF4C09DF4C09DF4C09DF4C09D4A4A
        4A929292A8A8A8B6B6B5131313D4A587EEB99CEEB796ECB293EBAD8BE4A184CC
        6633ABABABF4F4F4FFFFFF000000FFFFFFFFFFFFCC6633E69F7CE8A887EBAD8B
        ECB293EEB796F3BA943B3A3A9999999292925C5753272626EEB796F3BD99F3BD
        99F3BD99F3BD99F3BD99F3BD99F3BD994A4A4AC7C6C7C7C6C7C7C6C7CCCCCC27
        2626C69E83F3BD99F3BD99F3BD99F3BD99F3BD99F3BD99F3BD994A4A4A828282
        9292929E9E9E131313D4A07FEEB796ECB293EBAD8BE8A887E29E80CC6633ABAB
        ABF4F4F4FFFFFF000000FFFFFFFFFFFFCC6633E09A7BE4A184EBAD8BEDB18DEC
        B293EEB7963B3A3AA9A9A9A6A6A661605F272626ECB293F3BA94F3BA94F3BA94
        F3BA94F3BA94F3BA94F3BA944A4A4AB3B3B3B3B3B3B3B3B3B8B8B8272626C596
        78F3BA94F3BA94F3BA94F3BA94F3BA94F3BA94F3BA944A4A4A8D8D8DA6A6A6B1
        B0B0131313D4A07FF2B690EDB18DEBAD8BE4A184E09A7BCC6633ABABABF4F4F4
        FFFFFF000000FFFFFFFFFFFFCC6633E19675E69F7CE9A681EBAD8BF1B085EDB1
        8D3B3A3AC7C6C7C1C1C17170703B3A3AF2B48AF2B690F2B690F2B690F2B690F2
        B690F2B690F2B6904A4A4A999999999999999999999999272626C59678F2B690
        F2B690F2B690F2B690F2B690F2B690F2B6904A4A4AA3A3A3C0C0BFCCCCCC2726
        26DDA37DEBAD8BEBAD8BE9A681E69F7CE19675CC6633ABABABF4F4F4FFFFFF00
        0000FFFFFFFFFFFFCC6633E2936CE59B76EAA37BECAA83ECAA83F1B0854A4A4A
        8686868282826565654A4A4AF2B48AF2B48AF2B48AF2B48AF2B48AF2B48AF2B4
        8AF2B48A4A4A4A9B9B9C9B9B9C9B9B9CA0A0A0272626C9936FF2B48AF2B48AF2
        B48AF2B48AF2B48AF2B48AF2B48A4A4A4A7877778282828686863B3A3AECAA83
        ECAA83ECAA83EAA37BE59B76DD8F6DCC6633ABABABF4F4F4FFFFFF000000FFFF
        FFFFFFFFCC6633DE8E69E19675E59B76EAA37BEDA87DF1AD8057524E57524E57
        524E57524E5C5753F1B085F1B085F1B085F1B085F1B085F1B085F1B085F1B085
        4A4A4AA9A9A9A9A9A9A9A9A9AFAFAF272626C9936FF1B085F1B085F1B085F1B0
        85F1B085F1B085F1B08557524E57524E57524E57524E57524EF1AD80EDA87DEA
        A37BE7A076E19675DE8E69CC6633ABABABF4F4F4FFFFFF000000FFFFFFFFFFFF
        CC6633DC8863E2936CE69A6FEFA472EAA37BEDA87DF1AD80F1AD80F1AD80F1AD
        80F1AD80F1AD80F1AD80F1AD80F1AD80F1AD80F1AD80F1AD80F1AD804A4A4AC0
        C0BFC0C0BFBEBEBEC0C0BF272626C9936FF1AD80F1AD80F1AD80F1AD80F1AD80
        F1AD80F1AD80F1AD80F1AD80F1AD80F1AD80F1AD80EDA87DEAA37BE7A076E69A
        6FE2936CDC8863CC6633ABABABF4F4F4FFFFFF000000FFFFFFFFFFFFCC6633DB
        835BE08C63E7976AE69A6FE7A076EFA676EFA676F0AA7BF0AA7BF0AA7BF0AA7B
        F0AA7BF0AA7BF0AA7BF0AA7BF0AA7BF0AA7BF0AA7BF0AA7B4A4A4AD3D3D3D1D1
        D1D3D3D3D3D3D33B3A3AE7A076F0AA7BF0AA7BF0AA7BF0AA7BF0AA7BF0AA7BF0
        AA7BF0AA7BF0AA7BF0AA7BF0AA7BEDA87DEFA676E7A076E69A6FE2936CE08C63
        DB835BCC6633ABABABF4F4F4FFFFFF000000FFFFFFFFFFFFCC6633DB835BDC88
        63E69467E69A6FE69A6FEFA472A59A939B9B9C9E9E9E9E9E9E9E9893DDA37DEF
        A676EFA676EFA676EFA676EFA676EFA676EFA6764A4A4A4A4A4A4A4A4A4A4A4A
        4A4A4A4A4A4AEFA676EFA676EFA676EFA676EFA676EFA676EFA676EFA676A59A
        939B9B9C9E9E9E9E9E9E999999DDA37DEFA16CE69A6FE69467DC8863DB835BCC
        6633ABABABF4F4F4FFFFFF000000FFFFFFFFFFFFCC6633D97C52E1885BE49064
        E69467B6937CA9A9A9ACACACA6A6A6A0A0A0A3A3A3A9A9A9ADADAD999999EFA4
        72EFA472EFA472EFA472EFA472EFA472EFA472EFA472EFA472EFA472EFA472EF
        A472EFA472EFA472EFA472EFA472EFA472EFA472B99885A9A9A9ACACACA6A6A6
        A0A0A0A3A3A3A9A9A9ADADAD999999E7976AE49064E1885BD97C52CC6633ABAB
        ABF4F4F4FFFFFF000000FFFFFFFFFFFFCC6633D67549D97C52E1885B969696AD
        ADADA0A0A0FCFCFCF6F6F6F6F6F6F6F6F6F7F7F7BCBBBAAFAFAFA6A6A6EFA16C
        EFA16CEFA16CEFA16CEFA16CEFA16CEFA16CEFA16CEFA16CEFA16CEFA16CEFA1
        6CEFA16CEFA16CEFA16CEFA16C969696ADADADA0A0A0FCFCFCF6F6F6F6F6F6F6
        F6F6F7F7F7BCBBBAAFAFAFA6A6A6E1885BD97C52D67549CC6633ABABABF4F4F4
        FFFFFF000000FFFFFFFFFFFFCC6633D67549D97C52E1885BACACACA9A9A9FAF4
        F1F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F8F8F8A0A0A0B1B0B0B6937CEE9E67EE
        9E67EE9E67EE9E67EE9E67EE9E67EE9E67EE9E67EE9E67EE9E67EE9E67EE9E67
        EE9E67EE9E67EE9E67ACACACA9A9A9FAF4F1F6F6F6F6F6F6F6F6F6F6F6F6F6F6
        F6F8F8F8A0A0A0B1B0B0A98975DB835BDB835BCC6633ABABABF4F4F4FFFFFF00
        0000FFFFFFFFFFFFCC6633DA723DDF7A439D928CB1B0B0D5CCC6F6F6F6F6F6F6
        F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6FBFAF9A3A3A3A6A6A6EE9A63EE9A63EE9A
        63EE9A63EE9A63EE9A63EE9A63EE9A63EE9A63EE9A63EE9A63EE9A63EE9A63EE
        9A639D928CB1B0B0D5CCC6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
        FBFAF9A3A3A3B1B0B0E08C63DB835BCC6633ABABABF4F4F4FFFFFF000000FFFF
        FFFFFFFFCC6633D26E41D67549A3A3A3A9A9A9F6F6F6F6F6F6F6F6F6F6F6F6F6
        F6F6F6F6F6F6F6F6F6F6F6F6F6F6CCCCCCB3B3B3ED985FED985FED985FED985F
        ED985FED985FED985FED985FED985FED985FED985FED985FED985FED985FA3A3
        A3A9A9A9F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F7F7F7D3
        D3D3C0C0BFE08C63DB835BCC6633ABABABF4F4F4FFFFFF000000FFFFFFFFFFFF
        CC6633D56937D67549A6A6A6A9A9A9F7F7F7F7F7F7F6F6F6F6F6F6F6F6F6F6F6
        F6F6F6F6F6F6F6F8F8F8E5E5E5B8B8B8ED985FED985FED985FED985FED985FED
        985FED985FED985FED985FED985FED985FED985FED985FED985FA6A6A6A9A9A9
        F7F7F7F7F7F7F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F7F7F7F9F9F9E8E8E8C3C3
        C3E08C63DB835BCC6633ABABABF4F4F4FFFFFF000000FFFFFFFFFFFFCC6633D5
        6937DA723DA8A7A8B1B0B0EFE2DBDE8E69F5F5F5131313D6D6D6F5F5F5F5F5F5
        F4F4F4DB835BD1D1D1BCBBBAED955AED955AED955AED955AED955AED955AED95
        5AED955AED955AED955AED955AED955AED955AED955AA6A6A6B1B0B0EFE2DBDE
        8E69F5F5F5F5F5F5E1E1E0515051F7F7F7F5F5F5E29E80DADADAC9C9C9E49064
        E1885BCC6633ABABABF4F4F4FFFFFF000000FFFFFFFFFFFFCC6633D56937DA72
        3DA7968AC0C0BFD5CCC6D6D6D6131313F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5FB
        FAF9ADADADB3B3B3EC9155EC9155ED955AEC9155EC9155ED955AEC9155EC9155
        ED955AEC9155EC9155ED955AEC9155EC9155A7968AC0C0BFD5CCC6F5F5F5F5F5
        F5F5F5F5F7F7F7E1E1E03B3A3AF7F7F7FBFAF9C1C1C1C6C5C4DE8E69DC8863CC
        6633ABABABF4F4F4FFFFFF000000FFFFFFFFFFFFCC6633D36331D56937D97C52
        C3C3C3B3B3B3272626F5F5F5F5F5F5F4F4F4F5F5F5F5F5F5F5F5F5C3C0BFC3C3
        C3A29F9DEC9155EC9155EC9155EC9155EC9155EC9155EC9155EC9155EC9155EC
        9155EC9155EC9155EC9155EC9155E1905BC3C3C3B3B3B3F6F6F6F5F5F5F6F6F6
        FBF7F6F8F8F8DADADA828282D1D0D0D3D3D3B7B7B7E2936CDE8E69CC6633ABAB
        ABF4F4F4FFFFFF000000FFFFFFFFFFFFCC6633D36331D56937DF7A43A6A6A6C9
        C9C9B3B3B3FBFAF9F5F5F5D97C52FBFFFFF5F5F5C3C0BFCCCCCCBEBEBEEC9155
        EC9155EC9155EC9155E1905B8D7E73868686898988898988898988828282A67E
        64EC9155EC9155EC9155EC9155A6A6A6C9C9C9B3B3B3FBFBFBF8F8F8E29E80FB
        FFFFF8F8F8DBD6D5DADBDAD1D1D1E7A076E19675DD9370CC6633ABABABF4F4F4
        FFFFFF000000FFFFFFFFFFFFCC6633D36331D56937DF7A43E5834ABE8E72C9C9
        C9CCCCCCC6C5C4BEBEBEC1C1C1C9C9C9CFCFCFA9A9A9EC9155EC9155EC9155EC
        91558282829999999B9B9C9B9B9C9999999999999B9B9C9E9E9E9B9B9C898988
        EC9155EC9155EC9155EC9155C59678DBDBDBDDDCDCD8D8D8D3D3D3D6D6D6DADB
        DADEDEDEC7C6C7ECAA83EAA37BE59B76E19675CC6633ABABABF4F4F4FFFFFF00
        0000FFFFFFFFFFFFCC6633D36331D56937DF7A43E5834AE5834AB6937CC1C1C1
        CCCCCCD1D0D0CFCFCFC7C6C7ADA8A5EC9155EC9155EC9155EC91558D7E739999
        999B9B9C929292ADADADE8E8E8F1F1F1C3C3C38D8D8D9696969E9E9E868686E1
        905BEC9155ED985FF3BA94D3BCACD6D6D6DEDEDEE1E1E0E1E1E0DBDBDBC6C5C4
        EDB18DEBAD8BE9A681E69F7CE09A7BCC6633ABABABF4F4F4FFFFFF000000FFFF
        FFFFFFFFCC6633D36331D56937DF7A43E5834AE5834AEC9155EC9155EC9155EC
        9155EC9155EC9155EC9155EC9155EC9155EC91558885829E9E9E9B9B9CD9D2CD
        F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5929292A3A3A3929292F3BA
        94F3BA94F3BA94F3BD99F3BA94F3BA94F3BD99F3BA94F3BA94F3BA94ECB293ED
        B18DEBAD8BE9A681E4A184CC6633ABABABF4F4F4FFFFFF000000FFFFFFFFFFFF
        CC6633DB835BE6A98FECB293EEB796F3BA94F3BD99F3BD99F4C09DF4C09DF4C0
        9DF4C09DF0AA7BEC9155EC9155E1905BA0A0A0A3A3A3D9D2CDF5F5F5F5F5F5F5
        F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F6F6F6C1C1C1CCCCCCBEB9B5F4C09D
        F4C09DF4C09DF4C09DF4C09DF4C09DF4C09DF4C09DF3BD99F3BA94EEB796EDB1
        8DE6A98FE3A489CC6633ABABABF4F4F4FFFFFF000000FFFFFFFFFFFFCC6633E6
        A98FE8AE95ECB293EEB796EFBDA0F4C09DF4C2A0F4C2A0F4C2A0F4C2A0F4C2A0
        F4C2A0F4C2A0F4C2A0B7ADA7A9A9A99B9B9CF5F5F5F5F5F5F5F5F5F5F5F5F5F5
        F5F5F5F5F5F5F5F5F5F5F6F6F6F9F9F9CFCFCFCFCFCFC6C5C4F4C2A0F4C2A0F4
        C2A0F4C2A0F4C2A0F4C2A0F4C2A0F4C2A0EFBDA0F3BD99EEB99CECB293E8AE95
        E6A98FCC6633ABABABF4F4F4FFFFFF000000FFFFFFFFFFFFCC6633E8AE95EAB4
        9CEEB99CEFBDA0F1C0A1F3C3A6F5C5A5F5C6A8F5C6A8F5C6A8F5C6A8F5C6A8F5
        C6A8F5C6A8CCCCCCD6D6D6D8D8D8FBFAF9FBFAF9FBFAF9FBFAF9FBFAF9FBFAF9
        FBFAF9FBFAF9FBFAF9FBFAF9FBFAF9CFCFCFD3D3D3F5C6A8F5C6A8F5C6A8F5C6
        A8F5C6A8F5C6A8F5C6A8F5C5A5F3C3A6F1C0A1EFBDA0EEB99CEAB49CE8AE95CC
        6633ABABABF4F4F4FFFFFF000000FFFFFFFFFFFFCC6633EAB49CEBB9A2EFBDA0
        EFC2A8F2C5AAF5C8ABF5C9ADF5C9ADF5C9ADF5C9ADF5C9ADF5C9ADF5C9ADF5C9
        ADD3D3D3DADADAF4F4F4FBFAF9FBFAF9FBFAF9FBFAF9FBFAF9FBFAF9FBFAF9FB
        FAF9FBFAF9FBFAF9FBFAF9D3D3D3DADADAF5C9ADF5C9ADF5C9ADF5C9ADF5C9AD
        F5C9ADF5C9ADF5C9ADF5C8ABF2C5AAF3C3A6EDBFA9EEB99CEAB49CCC6633ABAB
        ABF4F4F4FFFFFF000000FFFFFFFFFFFFCC6633EBB9A2EFBDA0F1C1A5F2C5AAF4
        C7ACF5C9ADF6CCAFF6CCAFF6CDB2F6CDB2F6CDB2F6CDB2F6CDB2F6CDB2D6D6D6
        DDDCDCF9F9F9FBFAF9FBFAF9FBFAF9FBFAF9FBFAF9F4F4F4FBFAF9FBFAF9FBFA
        F9FBFAF9FBFAF9D6D6D6DDDCDCF6CDB2F6CDB2F6CDB2F6CDB2F6CDB2F6CDB2F6
        CCAFF6CCAFF5C9ADF4C7ACF2C5AAF1C1A5EFBDA0EBB9A2CC6633ABABABF4F4F4
        FFFFFF000000FFFFFFFFFFFFCC6633EDBFA9EDBFA9F0C5AEF4CAB1F4CAB1F5CE
        B5F7D0B6F7D0B6F7D0B6F7D0B6F7D0B6F7D0B6F7D0B6F7D0B6DADADAE1E1E0EA
        EAEAF0CBBCFBFBFBFBFBFBFBFBFB929292F9F9F9FBFBFBFBFBFBFBFBFBF0CBBC
        FBFBFBDBDBDBE1E1E0F7D0B6F7D0B6F7D0B6F7D0B6F7D0B6F7D0B6F7D0B6F7D0
        B6F5CEB5F4CAB1F4CAB1F0C5AEEDBFA9EDBFA9CC6633ABABABF4F4F4FFFFFF00
        0000FFFFFFFFFFFFCC6633EEC2ADF1C6B1F1C9B5F3CDB9F7D0B6F6D2BAF6D2BA
        F7D4BDF7D4BDF7D4BDF7D4BDF7D4BDF7D4BDF7D4BDD8D8D8E8E8E8DEDEDEFBFB
        FBFBFBFBFBFBFBEEEEEEECECECFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF3EAE6E5
        E5E5E1E1E0F7D4BDF7D4BDF7D4BDF7D4BDF7D4BDF7D4BDF7D4BDF6D2BAF6D2BA
        F3CDB9F3CDB9F1C9B5F1C6B1EEC2ADCC6633ABABABF4F4F4FFFFFF000000FFFF
        FFFFFFFFCC6633F1C6B1F1C9B5F3CDB9F3CDB9F6D2BAF7D4BDF7D6C1F7D6C1F7
        D6C1F7D6C1F7D6C1F7D6C1F7D6C1F7D6C1E6D5CEE8E8E8E5E5E5FBFBFBFBFBFB
        FBFBFBA3A3A3FBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBE1E1E0E8E8E8DEDE
        DEF7D6C1F7D6C1F7D6C1F7D6C1F7D6C1F7D6C1F7D6C1F7D6C1F7D4BDF6D2BAF3
        CDB9F3CDB9EEC7B6EEC7B6CC6633ABABABF4F4F4FFFFFF000000FFFFFFFFFFFF
        CC6633EEC7B6F1C9B5F1CFC0F7D4BDF5D4C2F7D6C1F7D6C1F7D8C5F7D8C5F7D8
        C5F7D8C5F7D8C5F7D8C5F7D8C5F7D8C5E5E5E5ECECECE5E5E5FCFCFCFBFAF9DD
        DCDCF3D8CDF3D8CDFCFCFCFCFCFCFCFCFCE8E8E8ECECECEAEAEAF7D8C5F7D8C5
        F7D8C5F7D8C5F7D8C5F7D8C5F7D8C5F7D6C1F7D6C1F5D4C2F5D4C2F1CFC0F1CF
        C0F0CBBCEEC7B6CC6633ADADADF5F5F5FFFFFF000000FFFFFFFFFFFFCC6633F0
        CBBCF0CBBCF1CFC0D3D3D3D1D1D1F7D8C5F7D8C5F7D8C5F7D9C9F7D8C5F7D8C5
        F7D9C9F7D8C5F7D8C5F7D9C9F7D9C9E5E5E5EEEEEEECECECEAEAEAFCFCFCFCFC
        FCFCFCFCFCFCFCF5F0EDE8E8E8EEEEEEEAEAEAE5DCD6F7D8C5F7D9C9F7D9C9F7
        D8C5F7D9C9F7D9C9F7D8C5F7D8C5F7D8C5F5D4C2CFCFCFD1D1D1CCCCCCF0CBBC
        F0CBBCCC6633BEBEBEFBFAF9FFFFFF000000FFFFFFFFFFFFCC6633F1CFC0F1CF
        C0D6D6D6E1E1E0D6D6D6E6D5CEF7D9C9F7D9C9F7D9C9F7D9C9F7D9C9F7D9C9F7
        D9C9F7D9C9F7D9C9F7D9C9F6DBCDECECECF1F1F1F0F0F0ECECECECECECECECEC
        ECECECEEEEEEF0F0F0EEEEEEE1E1E0F7D9C9F7D9C9F7D9C9F7D9C9F7D9C9F7D9
        C9F7D9C9F7D9C9F7D9C9F7D9C9F7D8C5E1E1E0DADADAE1E1E0F1CFC0F0CBBCCC
        6633D6D6D6FFFFFFFFFFFF000000FFFFFFFFFFFFF5D4C2EAB49CF2D4C9DDDBDA
        E8E8E8EEEEEEE6D5CEF3D8CDF7D9C9F6DBCDF6DBCDF6DBCDF6DBCDF6DBCDF6DB
        CDF6DBCDF6DBCDF6DBCDF6DBCDE5E5E5ECECECF1F1F1F1F1F1F1F1F1F1F1F1EE
        EEEEEAEAEAF6DBCDF6DBCDF6DBCDF6DBCDF6DBCDF6DBCDF6DBCDF6DBCDF6DBCD
        F6DBCDF6DBCDF7D9C9F7D9C9EEEEEEE5E5E5EEEEEEF1CFC0EAB6A0A78D80F8F8
        F8FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFCC6633E3A489F2D4C9E6D5CEE6
        D5CEF3D8CDF6DBCDF6DBCDF6DBCDF6DBCDF6DBCDF6DBCDF6DBCDF6DBCDF6DBCD
        F6DBCDF6DBCDF6DBCDF6DBCDF6DBCDF6DBCDF6DBCDF6DBCDF6DBCDF6DBCDF6DB
        CDF6DBCDF6DBCDF6DBCDF6DBCDF6DBCDF6DBCDF6DBCDF6DBCDF6DBCDF6DBCDF6
        DBCDF6DBCDF3D8CDF3D8CDE6D5CEF2D4C9E3A489CC6633EAEAEAFFFFFFFFFFFF
        FFFFFF000000FFFFFFFFFFFFFFFFFFFDFBFACC6633E3A489F3D8CDF3D8CDF3D8
        CDF5DBD0F5DBD0F5DBD0F5DBD0F5DBD0F5DBD0F5DBD0F5DBD0F5DBD0F5DBD0F5
        DBD0F5DBD0F5DBD0F5DBD0F5DBD0F5DBD0F5DBD0F5DBD0F5DBD0F5DBD0F5DBD0
        F5DBD0F5DBD0F5DBD0F5DBD0F5DBD0F5DBD0F5DBD0F5DBD0F5DBD0F5DBD0F5DB
        D0F3D8CDF3D8CDF3D8CDE3A489CC6633DDDBDAFFFFFFFFFFFFFFFFFFFFFFFF00
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3EAE6CC6633CC6633CC6633CC6633
        CC6633CC6633CC6633CC6633CC6633CC6633CC6633CC6633CC6633CC6633CC66
        33CC6633CC6633CC6633CC6633CC6633CC6633CC6633CC6633CC6633CC6633CC
        6633CC6633CC6633CC6633CC6633CC6633CC6633CC6633CC6633CC6633CC6633
        CC6633CC6633EFE2DBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000}
    end
    object Labeldialogcaption1: TLabel
      Left = 76
      Top = 4
      Width = 152
      Height = 24
      Caption = 'General settings'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Labeldialogcaption2: TLabel
      Left = 84
      Top = 32
      Width = 456
      Height = 15
      Caption = 
        'Application settings for default behavior and appearance in diff' +
        'erent PlanCenter views '
    end
  end
  object PageControl2: TPageControl
    Tag = 50
    Left = 10
    Top = 60
    Width = 737
    Height = 544
    ActivePage = TabSheet15
    MultiLine = True
    TabOrder = 3
    Visible = False
    StyleElements = []
    object TabSheet26: TTabSheet
      Caption = 'System setup'
      ImageIndex = 3
      object Panel43: TPanel
        Left = 291
        Top = 0
        Width = 438
        Height = 494
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 1
      end
      object Panel41: TPanel
        Left = 0
        Top = 0
        Width = 291
        Height = 494
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 0
        object GroupBox88: TGroupBox
          Left = 5
          Top = 5
          Width = 281
          Height = 279
          Align = alTop
          Caption = 'Device control'
          TabOrder = 0
          object Label100: TLabel
            Left = 8
            Top = 91
            Width = 72
            Height = 15
            Caption = 'Update every '
          end
          object Label101: TLabel
            Left = 135
            Top = 90
            Width = 93
            Height = 15
            Caption = 'Seconds (0 never)'
          end
          object CheckBoxshowdevcontrol: TCheckBox
            Left = 8
            Top = 20
            Width = 150
            Height = 17
            Caption = 'Show device control'
            TabOrder = 0
          end
          object CheckBoxpressindevcontrol: TCheckBox
            Left = 8
            Top = 43
            Width = 131
            Height = 17
            Caption = 'Use press devices'
            TabOrder = 1
          end
          object CheckBoxcontroldev: TCheckBox
            Left = 8
            Top = 67
            Width = 101
            Height = 17
            Caption = 'Control devices'
            TabOrder = 2
          end
          object CheckBoxDeviceControlOnlyAdmins: TCheckBox
            Left = 8
            Top = 112
            Width = 203
            Height = 17
            Caption = 'Only allow for administrators'
            TabOrder = 3
          end
          object Editdevconttime: TEdit
            Left = 84
            Top = 88
            Width = 29
            Height = 23
            ReadOnly = True
            TabOrder = 4
            Text = '0'
          end
          object UpDownupddevcontrol: TUpDown
            Left = 113
            Top = 88
            Width = 16
            Height = 23
            Associate = Editdevconttime
            Max = 60
            TabOrder = 5
          end
          object CheckBoxShowSpecificDevicesOnly: TCheckBox
            Left = 8
            Top = 135
            Width = 199
            Height = 17
            Caption = 'Only show specific devices'
            TabOrder = 6
          end
          object CheckListBoxSpecificDevices: TCheckListBox
            Left = 9
            Top = 158
            Width = 256
            Height = 83
            ItemHeight = 15
            TabOrder = 7
          end
          object CheckBoxOnlyShowDefaultDevices: TCheckBox
            Left = 11
            Top = 247
            Width = 199
            Height = 17
            Caption = 'Only show default devices'
            TabOrder = 8
          end
        end
        object GroupBox131: TGroupBox
          Left = 5
          Top = 284
          Width = 281
          Height = 141
          Align = alTop
          Caption = 'Other'
          TabOrder = 1
          object CheckBoxpreparetrans: TCheckBox
            Left = 8
            Top = 14
            Width = 180
            Height = 17
            Caption = 'Plate transmission system'
            TabOrder = 0
          end
          object CheckBoxautoflatproof: TCheckBox
            Left = 8
            Top = 34
            Width = 150
            Height = 17
            Caption = 'Auto flat proof'
            TabOrder = 1
          end
          object CheckBoxpressspecifik: TCheckBox
            Left = 8
            Top = 55
            Width = 174
            Height = 17
            Caption = 'Press specific page mode'
            TabOrder = 2
          end
          object CheckBoxpressgrpXXX: TCheckBox
            Left = 8
            Top = 75
            Width = 150
            Height = 17
            Caption = 'Use Press Groups'
            TabOrder = 3
            Visible = False
          end
          object CheckBoxDecreasever: TCheckBox
            Left = 8
            Top = 95
            Width = 203
            Height = 17
            Caption = 'Decrease version when re-processing'
            TabOrder = 4
          end
          object CheckBoxnewplatedata: TCheckBox
            Left = 8
            Top = 115
            Width = 167
            Height = 17
            Caption = 'New plate data system'
            Checked = True
            State = cbChecked
            TabOrder = 5
          end
        end
        object GroupBox40: TGroupBox
          Left = 5
          Top = 425
          Width = 281
          Height = 53
          Align = alTop
          Caption = 'Autorefresh'
          TabOrder = 2
          object Label11: TLabel
            Left = 14
            Top = 20
            Width = 95
            Height = 13
            AutoSize = False
            Caption = 'Auto refresh time'
          end
          object Label34: TLabel
            Left = 169
            Top = 21
            Width = 42
            Height = 17
            AutoSize = False
            Caption = 'sec'
          end
          object EditAutorefresh: TEdit
            Left = 111
            Top = 18
            Width = 38
            Height = 23
            ReadOnly = True
            TabOrder = 0
            Text = '30'
          end
          object UpDownautorefresh: TUpDown
            Left = 149
            Top = 18
            Width = 16
            Height = 23
            Associate = EditAutorefresh
            Min = 30
            Position = 30
            TabOrder = 1
          end
        end
      end
    end
    object TabSheet23: TTabSheet
      Caption = 'Tree'
      object Panel44: TPanel
        Left = 0
        Top = 0
        Width = 265
        Height = 494
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 0
        object Label49: TLabel
          Left = 13
          Top = 16
          Width = 140
          Height = 13
          AutoSize = False
          Caption = 'Auto filter expansion'
        end
        object CheckBoxKeeptreeexpantion: TCheckBox
          Left = 13
          Top = 35
          Width = 157
          Height = 17
          Caption = 'Keep filter expansion level'
          TabOrder = 0
        end
        object EditNewautoexpand: TEdit
          Left = 176
          Top = 33
          Width = 32
          Height = 23
          TabOrder = 1
          Text = '2'
        end
        object UpDownnewautoexp: TUpDown
          Left = 208
          Top = 33
          Width = 17
          Height = 23
          Associate = EditNewautoexpand
          Max = 4
          Position = 2
          TabOrder = 2
        end
        object GroupBox8: TGroupBox
          Left = 4
          Top = 60
          Width = 255
          Height = 152
          Caption = 'Extra publication text'
          TabOrder = 3
          object CheckListBoxextrafiltertext: TCheckListBox
            Left = 9
            Top = 16
            Width = 232
            Height = 135
            ItemHeight = 15
            Items.Strings = (
              'Week number'
              'Pressrun ordernumber'
              'Pressrun comment'
              'Customer name'
              'Input alias'
              'Ink comment'
              'Inkalias'
              'OutputAlias'
              'Presstime'
              'Production ordernumber')
            TabOrder = 0
          end
        end
        object GroupBox72: TGroupBox
          Left = 4
          Top = 213
          Width = 255
          Height = 81
          Caption = 'Extra edition text'
          TabOrder = 4
          object CheckListBoxEditionText: TCheckListBox
            Left = 9
            Top = 15
            Width = 231
            Height = 64
            ItemHeight = 15
            Items.Strings = (
              'Ink Comment'
              'Comment'
              'Order number'
              'Press time')
            TabOrder = 0
          end
        end
        object GroupBox75: TGroupBox
          Left = 4
          Top = 294
          Width = 255
          Height = 94
          Caption = 'Extra section text'
          TabOrder = 5
          object CheckListBoxSectionText: TCheckListBox
            Left = 9
            Top = 15
            Width = 231
            Height = 77
            ItemHeight = 15
            Items.Strings = (
              'Pressrun comment'
              'Press sequense number'
              'PressrunID'
              'Only pressrun comment'
              'Pagetable comment'
              'InkComment')
            TabOrder = 0
          end
        end
        object CheckBoxSeparateNodesPerPressrun: TCheckBox
          Left = 13
          Top = 394
          Width = 255
          Height = 17
          Caption = 'Separate nodes for pressruns in plateview'
          TabOrder = 6
        end
        object CheckBoxDefaultHidePagePlans: TCheckBox
          Left = 13
          Top = 417
          Width = 255
          Height = 31
          Caption = 'Default hide page plans in plate tree (show only applied plans)'
          TabOrder = 7
          WordWrap = True
        end
        object CheckBoxDefaultThumbnailOnlyPagePlans: TCheckBox
          Left = 13
          Top = 451
          Width = 255
          Height = 30
          Caption = 
            'Default show only page plans in thumbnail tree (show only unappl' +
            'ied plans)'
          TabOrder = 8
          WordWrap = True
        end
      end
      object Panel45: TPanel
        Left = 265
        Top = 0
        Width = 288
        Height = 494
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 1
        object Label23: TLabel
          Left = 11
          Top = 230
          Width = 108
          Height = 20
          AutoSize = False
          Caption = 'Tree update interval'
        end
        object Label24: TLabel
          Left = 172
          Top = 230
          Width = 67
          Height = 22
          AutoSize = False
          Caption = 'seconds'
        end
        object CheckBoxtreedayname: TCheckBox
          Left = 5
          Top = 15
          Width = 248
          Height = 17
          Caption = 'Show dayname with pubdate'
          TabOrder = 0
        end
        object CheckBoxtreebyedid: TCheckBox
          Left = 5
          Top = 50
          Width = 248
          Height = 17
          Caption = 'Order by editionid (internal index)'
          TabOrder = 1
        end
        object CheckBoxnewprodsign: TCheckBox
          Left = 5
          Top = 84
          Width = 248
          Height = 17
          Caption = 'Show '#39'new-product'#39' sign'
          TabOrder = 2
        end
        object CheckBoxtreeonceimaged: TCheckBox
          Left = 5
          Top = 101
          Width = 248
          Height = 17
          Caption = 'Show green on all once imaged'
          TabOrder = 3
        end
        object CheckBoxnotreelamps: TCheckBox
          Left = 5
          Top = 118
          Width = 248
          Height = 17
          Caption = 'Hide tree lamps'
          TabOrder = 4
        end
        object CheckboxTreeShowPrepollEvents: TCheckBox
          Left = 5
          Top = 67
          Width = 248
          Height = 17
          Caption = 'Show preflight/inkseave/rip status in tree'
          TabOrder = 5
        end
        object CheckBoxIncludeImageOnceState: TCheckBox
          Left = 5
          Top = 135
          Width = 248
          Height = 17
          Caption = 'Include '#39'Imaged once'#39' state (cyan)'
          TabOrder = 6
        end
        object CheckBoxTreeShowPagesReadyFlag: TCheckBox
          Left = 5
          Top = 152
          Width = 277
          Height = 17
          Caption = 'Show '#39'Pages Ready'#39' message from WebCenter'
          TabOrder = 7
        end
        object RadioGroupTreeorder: TRadioGroup
          Left = 6
          Top = 251
          Width = 248
          Height = 95
          Caption = 'Outp. Filter edition order'
          ItemIndex = 0
          Items.Strings = (
            'Press section'
            'Edition name'
            'Press section in all trees')
          TabOrder = 8
        end
        object RadioGroupdefdatesel: TRadioGroup
          Left = 6
          Top = 349
          Width = 247
          Height = 49
          Caption = 'Default date selection'
          Columns = 2
          ItemIndex = 0
          Items.Strings = (
            'All days'
            'From today')
          TabOrder = 9
        end
        object GroupBox117: TGroupBox
          Left = 6
          Top = 401
          Width = 248
          Height = 46
          Caption = 'Week number'
          TabOrder = 11
          object CheckBoxShowWeekNr: TCheckBox
            Left = 9
            Top = 21
            Width = 215
            Height = 15
            Caption = 'Show only week number in tree'
            TabOrder = 0
          end
        end
        object CheckBoxAlwaysfullTreeExpand: TCheckBox
          Left = 5
          Top = 185
          Width = 277
          Height = 17
          Caption = 'Always full tree expand on selected publication'
          TabOrder = 10
        end
        object UpDownnewtreeupdate: TUpDown
          Left = 154
          Top = 227
          Width = 16
          Height = 23
          Associate = Editnewtreeupdate
          Min = 10
          Max = 1000
          Position = 30
          TabOrder = 12
          Thousands = False
        end
        object Editnewtreeupdate: TEdit
          Left = 124
          Top = 227
          Width = 30
          Height = 23
          ReadOnly = True
          TabOrder = 13
          Text = '30'
        end
        object CheckBoxShowPagesOutOfRange: TCheckBox
          Left = 5
          Top = 168
          Width = 255
          Height = 17
          Caption = 'Show '#39'Pages out of range'#39'  (red background)'
          TabOrder = 14
        end
        object CheckboxTreeShowAliasFirst: TCheckBox
          Left = 5
          Top = 204
          Width = 247
          Height = 17
          HelpType = htKeyword
          Caption = 'Show alias before longname in tree'
          TabOrder = 15
        end
        object CheckBoxTreeShowWeeknumberAlso: TCheckBox
          Left = 5
          Top = 32
          Width = 248
          Height = 17
          Caption = 'Show weeknumber with pubdate'
          TabOrder = 16
        end
      end
      object Panel47: TPanel
        Left = 553
        Top = 0
        Width = 176
        Height = 494
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 2
        object GroupBox114: TGroupBox
          Left = 7
          Top = 11
          Width = 162
          Height = 140
          Caption = 'Visible towers'
          TabOrder = 0
          object CheckListBoxvisibletowers: TCheckListBox
            Left = 7
            Top = 39
            Width = 150
            Height = 88
            ItemHeight = 15
            TabOrder = 0
          end
          object CheckBoxLimitTowers: TCheckBox
            Left = 5
            Top = 16
            Width = 147
            Height = 17
            Caption = 'Limit visible towers'
            TabOrder = 1
          end
        end
      end
    end
    object TabSheet25: TTabSheet
      Caption = 'Release rules'
      ImageIndex = 2
      object Panel49: TPanel
        Left = 0
        Top = 0
        Width = 729
        Height = 494
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 0
        object GroupBox78: TGroupBox
          Left = 5
          Top = 5
          Width = 260
          Height = 484
          Align = alLeft
          Caption = 'Release rules'
          TabOrder = 0
          object CheckBoxmustsetdev: TCheckBox
            Left = 10
            Top = 20
            Width = 223
            Height = 17
            Caption = 'use release rules'
            TabOrder = 0
          end
          object RadioGroupreleaserulebase: TRadioGroup
            Left = 2
            Top = 43
            Width = 256
            Height = 47
            Caption = 'Based on'
            Columns = 3
            ItemIndex = 0
            Items.Strings = (
              'Production'
              'PressRun'
              'Plate')
            TabOrder = 1
          end
          object GroupBox79: TGroupBox
            Left = 2
            Top = 95
            Width = 256
            Height = 121
            Caption = 'Must be applied before release'
            TabOrder = 2
            object CheckListBoxreleaserules: TCheckListBox
              Left = 2
              Top = 17
              Width = 252
              Height = 102
              Align = alClient
              Ctl3D = True
              ItemHeight = 15
              Items.Strings = (
                'Device'
                'Tower'
                'Cylinder'
                'Zone'
                'High/low'
                'Sorting position'
                'Comment')
              ParentCtl3D = False
              TabOrder = 0
            end
          end
        end
      end
    end
    object TabSheet27: TTabSheet
      Caption = 'Separations'
      ImageIndex = 4
      object Panel50: TPanel
        Left = 0
        Top = 0
        Width = 401
        Height = 494
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 0
        object GroupBox68: TGroupBox
          Left = 5
          Top = 5
          Width = 391
          Height = 42
          Align = alTop
          Caption = 'Default save file folder'
          TabOrder = 0
          object Editdefaultsavepagelistfile: TEdit
            Left = 2
            Top = 17
            Width = 305
            Height = 23
            Align = alLeft
            TabOrder = 0
          end
          object BitBtn3: TBitBtn
            Left = 313
            Top = 15
            Width = 75
            Height = 25
            Caption = 'Browse'
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF6F6F6DFDFDFD6D6D6D6D6D6D6D6D6D6D6D6D6
              D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6DFDFDFF6F6F6F6F6F6C8C8C8
              8383836D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D
              6D6D6D6D838383C8C8C8DFDFDF1D82B51B81B3187EB0167CAE1379AB1076A80D
              73A50B71A3086EA0066C9E046A9C02689A0167994C4C4C8383832287BA67CCFF
              2085B899FFFF6FD4FF6FD4FF6FD4FF6FD4FF6FD4FF6FD4FF6FD4FF6FD4FF3BA0
              D399FFFF0167996E6E6E258ABD67CCFF278CBF99FFFF7BE0FF7BE0FF7BE0FF7B
              E0FF7BE0FF7BE0FF7BE0FF7BE0FF44A9DC99FFFF02689A6D6D6D288DC067CCFF
              2D92C599FFFF85EBFF85EBFF85EBFF85EBFF85EBFF85EBFF85EBFF85EBFF4EB3
              E699FFFF046A9C6D6D6D2A8FC267CCFF3398CB99FFFF91F7FF91F7FF91F7FF91
              F7FF91F7FF91F7FF91F7FF91F7FF57BCEF99FFFF066C9E6D6D6D2D92C56FD4FF
              3499CC99FFFF99FFFF99FFFF99FFFF99FFFF99FFFF99FFFF99FFFF99FFFF60C5
              F899FFFF086EA06E6E6E2F94C77BE0FF2D92C5FFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFF81E6FFFFFFFF0B71A38C8C8C3196C985EBFF
              81E6FF2D92C52D92C52D92C52D92C52D92C52D92C5288DC02489BC2085B81C81
              B41B81B31B81B3DFDFDF3398CB91F7FF8EF4FF8EF4FF8EF4FF8EF4FF8EF4FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFF167CAE8C8C8CDEDEDEFFFFFF3499CCFFFFFF
              99FFFF99FFFF99FFFF99FFFFFFFFFF258ABD2287BA1F84B71D82B51B81B3187E
              B0DFDFDFF7F7F7FFFFFFFFFFFF3499CCFFFFFFFFFFFFFFFFFFFFFFFF2A8FC2C8
              C8C8F6F6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              3499CC3398CB3196C92F94C7DFDFDFF6F6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
            TabOrder = 1
            OnClick = BitBtn3Click
          end
        end
        object CheckBoxpagename: TCheckBox
          Left = 9
          Top = 49
          Width = 363
          Height = 17
          Caption = 'Sort pagename with pageindex'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object CheckBoxpageicons: TCheckBox
          Left = 9
          Top = 85
          Width = 363
          Height = 17
          Caption = 'Use icons'
          TabOrder = 2
          Visible = False
        end
        object CheckBoxreselectpages: TCheckBox
          Left = 9
          Top = 103
          Width = 363
          Height = 17
          Caption = 'Re-select data after action'
          TabOrder = 3
        end
        object CheckBoxpagefullautorefresh: TCheckBox
          Left = 9
          Top = 121
          Width = 363
          Height = 19
          Caption = 'Full autorefresh'
          TabOrder = 5
        end
        object CheckBoxpagesshowall: TCheckBox
          Left = 9
          Top = 141
          Width = 323
          Height = 17
          Caption = 'Show all is allowed'
          TabOrder = 4
        end
        object CheckBoxdefaultsetcomed: TCheckBox
          Left = 9
          Top = 67
          Width = 362
          Height = 17
          Caption = 'Default set comments on all sub-edition '
          TabOrder = 6
        end
      end
      object Panel106: TPanel
        Left = 401
        Top = 0
        Width = 328
        Height = 494
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 1
      end
    end
    object TabSheet28: TTabSheet
      Caption = 'Plates'
      ImageIndex = 5
      object Panel51: TPanel
        Left = 0
        Top = 0
        Width = 435
        Height = 494
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 0
        object GroupBox81: TGroupBox
          Left = 5
          Top = 5
          Width = 425
          Height = 484
          Align = alClient
          Caption = 'View'
          TabOrder = 0
          object Panel53: TPanel
            Left = 2
            Top = 17
            Width = 223
            Height = 465
            Align = alLeft
            BevelOuter = bvNone
            BorderWidth = 5
            ParentBackground = False
            TabOrder = 0
            object Label50: TLabel
              Left = 5
              Top = 5
              Width = 213
              Height = 13
              Align = alTop
              AutoSize = False
              Caption = 'Plate caption'
              ExplicitLeft = 28
              ExplicitTop = 32
              ExplicitWidth = 149
            end
            object Label46: TLabel
              Left = 5
              Top = 227
              Width = 213
              Height = 15
              Align = alTop
              Caption = 'Alternative pagename field'
              ExplicitWidth = 142
            end
            object Label47: TLabel
              Left = 5
              Top = 265
              Width = 213
              Height = 15
              Align = alTop
              Caption = 'Alternative sheet field'
              ExplicitWidth = 114
            end
            object CheckListBoxplatecaption: TCheckListBox
              Left = 5
              Top = 18
              Width = 213
              Height = 209
              Align = alTop
              DragMode = dmAutomatic
              ItemHeight = 15
              Items.Strings = (
                'Sheet'
                'Side'
                'pagina'
                'pageindex'
                'Copy'
                'Tower'
                'Platenumber'
                'Pagename'
                'Low pageindex'
                'Low pagina'
                'Device'
                'Edition'
                'Section'
                'Layout'
                'Planedpagename'
                'Altpagename'
                'Alt Low pageindex'
                'Alt Low pagina'
                'Alt sheet'
                'Layout Alias'
                'Zone'
                'InkAlias'
                'DeviceAlias'
                'Master edition'
                'Low/High'
                'SortingPosition'
                'Ink name (MiscString3)')
              TabOrder = 0
              OnDragDrop = CheckListBoxplatecaptionDragDrop
              OnDragOver = CheckListBoxplatecaptionDragOver
              OnStartDrag = CheckListBoxplatecaptionStartDrag
            end
            object Editaltpagenamefield: TEdit
              Left = 5
              Top = 242
              Width = 213
              Height = 23
              Align = alTop
              TabOrder = 1
              Text = 'Comment'
            end
            object EditAltSheet: TEdit
              Left = 5
              Top = 280
              Width = 213
              Height = 23
              Align = alTop
              TabOrder = 2
              Text = 'Comment'
            end
            object CheckBoxplatefont: TCheckBox
              Left = 6
              Top = 308
              Width = 197
              Height = 17
              Caption = 'Plate font Bold'
              TabOrder = 3
            end
            object CheckBoxShowtemplateincaption: TCheckBox
              Left = 6
              Top = 325
              Width = 197
              Height = 17
              Caption = 'Show layout in caption'
              TabOrder = 4
            end
            object CheckBoxorderintopcap: TCheckBox
              Left = 6
              Top = 359
              Width = 211
              Height = 17
              Caption = 'Show ordernumber in top caption'
              TabOrder = 5
            end
            object CheckBoxplateshowextstat: TCheckBox
              Left = 6
              Top = 393
              Width = 197
              Height = 17
              Caption = 'Show external status'
              TabOrder = 6
            end
            object CheckBoxplatehidecopy: TCheckBox
              Left = 6
              Top = 342
              Width = 197
              Height = 17
              Caption = 'Hide Copybar'
              TabOrder = 8
            end
            object CheckBoxplatethumb: TCheckBox
              Left = 6
              Top = 376
              Width = 211
              Height = 17
              Caption = 'Use plate thumbnails (ProofCenter)'
              TabOrder = 7
            end
          end
          object Panel54: TPanel
            Left = 225
            Top = 17
            Width = 198
            Height = 465
            Align = alClient
            BevelOuter = bvNone
            BorderWidth = 5
            ParentBackground = False
            TabOrder = 1
            object Label25: TLabel
              Left = 5
              Top = 5
              Width = 188
              Height = 13
              Align = alTop
              AutoSize = False
              Caption = 'Platetext'
              ExplicitLeft = 172
              ExplicitTop = 16
              ExplicitWidth = 149
            end
            object Label110: TLabel
              Left = 5
              Top = 107
              Width = 188
              Height = 13
              Align = alTop
              AutoSize = False
              Caption = 'Pressrun text'
              ExplicitLeft = 172
              ExplicitTop = 124
              ExplicitWidth = 149
            end
            object CheckListBoxPlatetext: TCheckListBox
              Left = 5
              Top = 18
              Width = 188
              Height = 89
              Align = alTop
              DragMode = dmAutomatic
              ItemHeight = 15
              Items.Strings = (
                'Common edition'
                'Section'
                'Alt pagename'
                'InkPlatenumber'
                'Zone')
              TabOrder = 0
              OnDragDrop = CheckListBoxPlatetextDragDrop
              OnDragOver = CheckListBoxPlatetextDragOver
              OnStartDrag = CheckListBoxPlatetextStartDrag
            end
            object CheckListBoxpressruntexts: TCheckListBox
              Left = 5
              Top = 120
              Width = 188
              Height = 112
              Align = alTop
              DragMode = dmAutomatic
              ItemHeight = 15
              Items.Strings = (
                'Press'
                'Pubdate'
                'Publication'
                'Edition'
                'Section'
                'Layout Alias'
                'Runs'
                'InkComment')
              TabOrder = 1
              OnDragDrop = CheckListBoxPlatetextDragDrop
              OnDragOver = CheckListBoxPlatetextDragOver
              OnStartDrag = CheckListBoxPlatetextStartDrag
            end
            object CheckBoxplatespecialstanding: TCheckBox
              Left = 5
              Top = 232
              Width = 188
              Height = 19
              Align = alTop
              Caption = 'Show pages standing'
              TabOrder = 2
            end
            object CheckBoxdataonplate: TCheckBox
              Left = 5
              Top = 251
              Width = 188
              Height = 19
              Align = alTop
              Caption = 'Show data on plate thumbnails'
              TabOrder = 3
            end
            object CheckBoxhideprogthumb: TCheckBox
              Left = 5
              Top = 270
              Width = 188
              Height = 19
              Align = alTop
              Caption = 'Hide names on thumbnails'
              TabOrder = 4
            end
            object CheckBoxPlatenothumbrot: TCheckBox
              Left = 5
              Top = 289
              Width = 188
              Height = 19
              Align = alTop
              Caption = 'No thumbnail rotation'
              TabOrder = 5
            end
            object CheckBoxplatepagepreview: TCheckBox
              Left = 5
              Top = 308
              Width = 188
              Height = 19
              Align = alTop
              Caption = 'Show single page previews'
              TabOrder = 6
            end
          end
        end
      end
      object Panel52: TPanel
        Left = 438
        Top = 0
        Width = 291
        Height = 503
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 1
        object GroupBox83: TGroupBox
          Left = 5
          Top = 5
          Width = 281
          Height = 328
          Align = alTop
          Caption = 'Extra options'
          TabOrder = 0
          object Label38: TLabel
            Left = 12
            Top = 301
            Width = 144
            Height = 15
            Caption = 'External status on re-image'
          end
          object CheckBoxlayoutanaki: TCheckBox
            Left = 8
            Top = 19
            Width = 250
            Height = 17
            Caption = 'Allow selection of any plate layout'
            TabOrder = 0
          end
          object CheckBoxplateshowripsystem: TCheckBox
            Left = 8
            Top = 73
            Width = 250
            Height = 17
            Caption = 'Show rip system'
            TabOrder = 1
          end
          object CheckBoxreimhighpri: TCheckBox
            Left = 8
            Top = 91
            Width = 250
            Height = 17
            Caption = 'Reimage with high priority'
            TabOrder = 2
          end
          object CheckBoxreimage: TCheckBox
            Left = 8
            Top = 37
            Width = 200
            Height = 18
            Caption = 'Show reimage dialog'
            TabOrder = 3
          end
          object CheckBoxApplyPlateMerge: TCheckBox
            Left = 8
            Top = 55
            Width = 250
            Height = 17
            Caption = 'Use Apply platemerge'
            TabOrder = 4
          end
          object Editreimextstat: TEdit
            Left = 160
            Top = 298
            Width = 40
            Height = 21
            AutoSize = False
            TabOrder = 5
            Text = '-1'
          end
          object UpDownreimext: TUpDown
            Left = 200
            Top = 298
            Width = 17
            Height = 21
            Associate = Editreimextstat
            Min = -1
            Position = -1
            TabOrder = 6
          end
          object CheckBoxaddcopydialog: TCheckBox
            Left = 8
            Top = 237
            Width = 250
            Height = 17
            Caption = 'Show dialog when adding copies'
            TabOrder = 7
          end
          object CheckBoxplateReimondevch: TCheckBox
            Left = 8
            Top = 110
            Width = 250
            Height = 17
            Caption = 'Auto reimage on device change'
            TabOrder = 8
          end
          object CheckBoxnewinkregen: TCheckBox
            Left = 8
            Top = 128
            Width = 270
            Height = 17
            Caption = 'Use re-generate inkfile via database queue'
            TabOrder = 9
          end
          object CheckBoxnewinkresend: TCheckBox
            Left = 8
            Top = 146
            Width = 250
            Height = 17
            Caption = 'Allow Re-send inkfile'
            TabOrder = 10
          end
          object CheckboxClearDeviceOnLayoutChange: TCheckBox
            Left = 8
            Top = 164
            Width = 250
            Height = 17
            Caption = 'Reset device on layout change'
            TabOrder = 11
          end
          object CheckBoxKeepOutputVersionOnReimage: TCheckBox
            Left = 8
            Top = 201
            Width = 250
            Height = 19
            Caption = 'Keep output version on re-image'
            TabOrder = 12
          end
          object CheckBoxUseFileCenterTiffArchive: TCheckBox
            Left = 8
            Top = 219
            Width = 250
            Height = 17
            Caption = 'Use FileCenter for re-send inkfile'
            TabOrder = 14
          end
          object CheckBoxAllowInkfileRegenerate: TCheckBox
            Left = 8
            Top = 182
            Width = 250
            Height = 17
            Caption = 'Allow Re-generate inkfile'
            TabOrder = 13
          end
          object CheckBoxsmootplateautorefresh: TCheckBox
            Left = 8
            Top = 255
            Width = 207
            Height = 17
            Caption = 'Smooth autorefresh'
            Checked = True
            State = cbChecked
            TabOrder = 15
          end
          object CheckBoxUseNiceManualStacker: TCheckBox
            Left = 8
            Top = 274
            Width = 205
            Height = 17
            Caption = 'Custom manual stacker change'
            Checked = True
            State = cbChecked
            TabOrder = 16
          end
        end
        object RadioGroupplatedonestat: TRadioGroup
          Left = 6
          Top = 339
          Width = 284
          Height = 54
          Caption = 'External status dependency for plate '#39'Imaged'#39' (green)'
          Columns = 3
          ItemIndex = 0
          Items.Strings = (
            'None'
            'Bending OK'
            'Sorting OK')
          TabOrder = 1
        end
      end
    end
    object TabSheet29: TTabSheet
      Caption = 'Editions'
      ImageIndex = 6
      object Panel55: TPanel
        Left = 0
        Top = 0
        Width = 121
        Height = 494
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 0
        object RadioGroupdefaultpagetypeaddedition: TRadioGroup
          Left = 5
          Top = 5
          Width = 111
          Height = 61
          Align = alTop
          Caption = 'Default page type'
          ItemIndex = 1
          Items.Strings = (
            'Unique'
            'Common')
          TabOrder = 0
        end
        object RadioGroupdefaultDeviceaddedition: TRadioGroup
          Left = 5
          Top = 66
          Width = 111
          Height = 61
          Align = alTop
          Caption = 'Device'
          ItemIndex = 0
          Items.Strings = (
            'Reset device'
            'Keep device')
          TabOrder = 1
        end
        object RadioGroupdefaultHoldaddedition: TRadioGroup
          Left = 5
          Top = 127
          Width = 111
          Height = 61
          Align = alTop
          Caption = 'Plate output'
          ItemIndex = 0
          Items.Strings = (
            'Hold'
            'Release')
          TabOrder = 2
        end
      end
      object Panel56: TPanel
        Left = 121
        Top = 0
        Width = 256
        Height = 494
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 1
        object GroupBox43: TGroupBox
          Left = 5
          Top = 5
          Width = 246
          Height = 109
          Align = alTop
          Caption = 'Approval'
          TabOrder = 0
          object RadioGroupdefaultUniqePaddedition: TRadioGroup
            Left = 2
            Top = 17
            Width = 133
            Height = 90
            Align = alLeft
            Caption = 'Unique pages'
            ItemIndex = 0
            Items.Strings = (
              'Approval needed'
              'No approval')
            TabOrder = 0
          end
          object RadioGroupdefaultCommonPaddedition: TRadioGroup
            Left = 135
            Top = 17
            Width = 109
            Height = 90
            Align = alClient
            Caption = 'Common pages'
            ItemIndex = 0
            Items.Strings = (
              'No change'
              'Re-approve'
              'No approval')
            TabOrder = 1
          end
        end
        object GroupBox77: TGroupBox
          Left = 5
          Top = 114
          Width = 246
          Height = 161
          Align = alTop
          Caption = 'Timed editions'
          TabOrder = 1
          object CheckBoxtimedEd: TCheckBox
            Left = 9
            Top = 18
            Width = 229
            Height = 17
            Caption = 'Allow Timed editions'
            TabOrder = 0
          end
          object RadioGrouptimedrules: TRadioGroup
            Left = 2
            Top = 40
            Width = 242
            Height = 109
            Caption = 'An edition can be locked when'
            ItemIndex = 0
            Items.Strings = (
              'All plates are imaged'
              'All pages are received and approved'
              'All pages are received'
              'no rule (not recommended)')
            TabOrder = 1
          end
        end
        object GroupBox91: TGroupBox
          Left = 5
          Top = 275
          Width = 246
          Height = 126
          Align = alTop
          Caption = 'Special'
          TabOrder = 2
          object CheckBoxuniqloconly: TCheckBox
            Left = 10
            Top = 15
            Width = 229
            Height = 17
            Caption = 'Assign unique to local only'
            TabOrder = 0
          end
          object CheckBoxOnlySecined: TCheckBox
            Left = 10
            Top = 34
            Width = 224
            Height = 17
            Caption = 'Section sections filter'
            TabOrder = 1
          end
          object CheckBoxforcewhencommon: TCheckBox
            Left = 10
            Top = 53
            Width = 224
            Height = 17
            Caption = 'Force when changing to common'
            TabOrder = 2
          end
          object CheckBoxusealted: TCheckBox
            Left = 10
            Top = 72
            Width = 224
            Height = 17
            Caption = 'Use alternative edition file'
            TabOrder = 3
          end
          object CheckBoxeditionignorepress: TCheckBox
            Left = 10
            Top = 91
            Width = 224
            Height = 17
            Caption = 'Ignore pressname'
            Checked = True
            State = cbChecked
            TabOrder = 4
          end
        end
      end
      object Panel57: TPanel
        Left = 377
        Top = 0
        Width = 352
        Height = 494
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 2
      end
    end
    object TabSheet16: TTabSheet
      Caption = 'Log'
      ImageIndex = 7
      object Panel58: TPanel
        Left = 0
        Top = 0
        Width = 217
        Height = 494
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 0
        object GroupBox25: TGroupBox
          Left = 5
          Top = 5
          Width = 207
          Height = 132
          Caption = 'Log these events in the database'
          TabOrder = 0
          object CheckBoxlogapprove: TCheckBox
            Left = 5
            Top = 16
            Width = 184
            Height = 17
            Caption = 'Approve'
            TabOrder = 0
          end
          object CheckBoxlogdisapprove: TCheckBox
            Left = 5
            Top = 34
            Width = 191
            Height = 17
            Caption = 'Disapprove'
            TabOrder = 1
          end
          object CheckBoxloghold: TCheckBox
            Left = 5
            Top = 52
            Width = 184
            Height = 17
            Caption = 'Hold'
            TabOrder = 2
          end
          object CheckBoxlogrelease: TCheckBox
            Left = 5
            Top = 70
            Width = 184
            Height = 17
            Caption = 'Release'
            TabOrder = 3
          end
          object CheckBoxlogplanning: TCheckBox
            Left = 5
            Top = 88
            Width = 184
            Height = 17
            Caption = 'Planning'
            TabOrder = 4
          end
          object CheckBoxlogdelete: TCheckBox
            Left = 5
            Top = 106
            Width = 184
            Height = 17
            Caption = 'Delete'
            TabOrder = 5
          end
        end
        object CheckBoxapprovetimeonrelease: TCheckBox
          Left = 9
          Top = 140
          Width = 196
          Height = 17
          Caption = 'Set approval time on release'
          TabOrder = 1
        end
      end
      object Panel59: TPanel
        Left = 217
        Top = 0
        Width = 293
        Height = 494
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 1
        object Label92: TLabel
          Left = 6
          Top = 18
          Width = 221
          Height = 13
          AutoSize = False
          Caption = 'Min. page tree level'
        end
        object Editminlogtree: TEdit
          Left = 110
          Top = 15
          Width = 51
          Height = 23
          TabOrder = 0
          Text = '2'
        end
        object GroupBox85: TGroupBox
          Left = 4
          Top = 47
          Width = 283
          Height = 233
          Caption = 'Log events'
          TabOrder = 1
          object ListVieweventlogs: TListView
            Left = 7
            Top = 15
            Width = 263
            Height = 215
            Checkboxes = True
            Columns = <
              item
                AutoSize = True
                Caption = 'Name'
              end
              item
                Caption = 'index'
              end>
            GridLines = True
            RowSelect = True
            PopupMenu = PopupMenulogsys
            TabOrder = 0
            ViewStyle = vsReport
          end
        end
        object UpDown16: TUpDown
          Left = 161
          Top = 15
          Width = 17
          Height = 23
          Associate = Editminlogtree
          Min = 1
          Max = 5
          Position = 2
          TabOrder = 2
        end
      end
      object Panel60: TPanel
        Left = 510
        Top = 0
        Width = 219
        Height = 494
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 2
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Reporting'
      ImageIndex = 8
      object Panel61: TPanel
        Left = 0
        Top = 0
        Width = 358
        Height = 494
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 0
        object GroupBox39: TGroupBox
          Left = 5
          Top = 5
          Width = 348
          Height = 256
          Align = alTop
          Caption = 'Excel report generation'
          TabOrder = 0
          object Label66: TLabel
            Left = 8
            Top = 17
            Width = 143
            Height = 15
            Caption = 'Central Excel archive folder'
          end
          object Label67: TLabel
            Left = 12
            Top = 197
            Width = 61
            Height = 16
            AutoSize = False
            Caption = 'Email CC'
          end
          object Label68: TLabel
            Left = 12
            Top = 170
            Width = 50
            Height = 12
            AutoSize = False
            Caption = 'Email to'
          end
          object Label69: TLabel
            Left = 12
            Top = 224
            Width = 68
            Height = 16
            AutoSize = False
            Caption = 'Email Subject'
          end
          object EditDeafaultreportfolder: TEdit
            Left = 8
            Top = 34
            Width = 289
            Height = 23
            TabOrder = 0
          end
          object BitBtn6: TBitBtn
            Left = 312
            Top = 32
            Width = 25
            Height = 25
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF6F6F6DFDFDFD6D6D6D6D6D6D6D6D6D6D6D6D6
              D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6DFDFDFF6F6F6F6F6F6C8C8C8
              8383836D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D
              6D6D6D6D838383C8C8C8DFDFDF1D82B51B81B3187EB0167CAE1379AB1076A80D
              73A50B71A3086EA0066C9E046A9C02689A0167994C4C4C8383832287BA67CCFF
              2085B899FFFF6FD4FF6FD4FF6FD4FF6FD4FF6FD4FF6FD4FF6FD4FF6FD4FF3BA0
              D399FFFF0167996E6E6E258ABD67CCFF278CBF99FFFF7BE0FF7BE0FF7BE0FF7B
              E0FF7BE0FF7BE0FF7BE0FF7BE0FF44A9DC99FFFF02689A6D6D6D288DC067CCFF
              2D92C599FFFF85EBFF85EBFF85EBFF85EBFF85EBFF85EBFF85EBFF85EBFF4EB3
              E699FFFF046A9C6D6D6D2A8FC267CCFF3398CB99FFFF91F7FF91F7FF91F7FF91
              F7FF91F7FF91F7FF91F7FF91F7FF57BCEF99FFFF066C9E6D6D6D2D92C56FD4FF
              3499CC99FFFF99FFFF99FFFF99FFFF99FFFF99FFFF99FFFF99FFFF99FFFF60C5
              F899FFFF086EA06E6E6E2F94C77BE0FF2D92C5FFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFF81E6FFFFFFFF0B71A38C8C8C3196C985EBFF
              81E6FF2D92C52D92C52D92C52D92C52D92C52D92C5288DC02489BC2085B81C81
              B41B81B31B81B3DFDFDF3398CB91F7FF8EF4FF8EF4FF8EF4FF8EF4FF8EF4FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFF167CAE8C8C8CDEDEDEFFFFFF3499CCFFFFFF
              99FFFF99FFFF99FFFF99FFFFFFFFFF258ABD2287BA1F84B71D82B51B81B3187E
              B0DFDFDFF7F7F7FFFFFFFFFFFF3499CCFFFFFFFFFFFFFFFFFFFFFFFF2A8FC2C8
              C8C8F6F6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              3499CC3398CB3196C92F94C7DFDFDFF6F6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
            TabOrder = 1
            OnClick = BitBtn6Click
          end
          object CheckBoxExcelSaveToFolder: TCheckBox
            Left = 8
            Top = 61
            Width = 289
            Height = 17
            Caption = 'Default save to local folder (specified with prompt)'
            TabOrder = 2
          end
          object RadioGroupExcelEmailOption: TRadioGroup
            Left = 2
            Top = 84
            Width = 286
            Height = 77
            Caption = 'Default email option'
            Ctl3D = True
            Items.Strings = (
              'No email'
              'Use publication-specific email recipient'
              'Send to specific email')
            ParentCtl3D = False
            TabOrder = 3
          end
          object EditDefaultExcelEmailTO: TEdit
            Left = 86
            Top = 167
            Width = 200
            Height = 23
            TabOrder = 4
          end
          object EditDefaultExcelEmailCC: TEdit
            Left = 86
            Top = 194
            Width = 200
            Height = 23
            TabOrder = 5
          end
          object EditDefaultExcelEmailSUBJ: TEdit
            Left = 86
            Top = 223
            Width = 246
            Height = 23
            TabOrder = 6
          end
        end
        object GroupBox38: TGroupBox
          Left = 5
          Top = 261
          Width = 348
          Height = 244
          Align = alTop
          Caption = 'Comma-separated report details'
          TabOrder = 1
          object Label32: TLabel
            Left = 14
            Top = 19
            Width = 84
            Height = 13
            AutoSize = False
            Caption = 'Include columns'
          end
          object Label52: TLabel
            Left = 9
            Top = 123
            Width = 77
            Height = 13
            AutoSize = False
            Caption = 'Item separator'
          end
          object Label79: TLabel
            Left = 9
            Top = 154
            Width = 81
            Height = 14
            AutoSize = False
            Caption = 'Date time format'
          end
          object Label72: TLabel
            Left = 10
            Top = 197
            Width = 100
            Height = 13
            AutoSize = False
            Caption = 'Default save folder'
          end
          object CheckListBoxdetailsavecols: TCheckListBox
            Left = 101
            Top = 20
            Width = 110
            Height = 93
            ItemHeight = 15
            Items.Strings = (
              'Publ.Date'
              'Publication'
              'Edition'
              'Section'
              'Location'
              'Press'
              'Page'
              'UniquePage'
              'CopyNumber'
              'Color'
              'Status'
              'Approved'
              'Released'
              'Inputtime'
              'Approvetime'
              'Outputtime'
              'Device'
              'Deadline'
              'Comment'
              'Pageindex')
            TabOrder = 0
          end
          object CheckBoxsavereportdetailcolumns: TCheckBox
            Left = 9
            Top = 175
            Width = 179
            Height = 19
            Caption = 'Include column names as headers'
            TabOrder = 1
          end
          object ComboBoxreportdetailsave: TComboBox
            Left = 101
            Top = 122
            Width = 39
            Height = 23
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 2
            Text = ','
            Items.Strings = (
              ','
              ';'
              'TAB')
          end
          object Editreportdateform: TEdit
            Left = 101
            Top = 149
            Width = 110
            Height = 23
            TabOrder = 3
            Text = 'DD.MM.YY-HH:NN:SS'
          end
          object BitBtn11: TBitBtn
            Left = 312
            Top = 209
            Width = 25
            Height = 25
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF6F6F6DFDFDFD6D6D6D6D6D6D6D6D6D6D6D6D6
              D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6DFDFDFF6F6F6F6F6F6C8C8C8
              8383836D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D
              6D6D6D6D838383C8C8C8DFDFDF1D82B51B81B3187EB0167CAE1379AB1076A80D
              73A50B71A3086EA0066C9E046A9C02689A0167994C4C4C8383832287BA67CCFF
              2085B899FFFF6FD4FF6FD4FF6FD4FF6FD4FF6FD4FF6FD4FF6FD4FF6FD4FF3BA0
              D399FFFF0167996E6E6E258ABD67CCFF278CBF99FFFF7BE0FF7BE0FF7BE0FF7B
              E0FF7BE0FF7BE0FF7BE0FF7BE0FF44A9DC99FFFF02689A6D6D6D288DC067CCFF
              2D92C599FFFF85EBFF85EBFF85EBFF85EBFF85EBFF85EBFF85EBFF85EBFF4EB3
              E699FFFF046A9C6D6D6D2A8FC267CCFF3398CB99FFFF91F7FF91F7FF91F7FF91
              F7FF91F7FF91F7FF91F7FF91F7FF57BCEF99FFFF066C9E6D6D6D2D92C56FD4FF
              3499CC99FFFF99FFFF99FFFF99FFFF99FFFF99FFFF99FFFF99FFFF99FFFF60C5
              F899FFFF086EA06E6E6E2F94C77BE0FF2D92C5FFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFF81E6FFFFFFFF0B71A38C8C8C3196C985EBFF
              81E6FF2D92C52D92C52D92C52D92C52D92C52D92C5288DC02489BC2085B81C81
              B41B81B31B81B3DFDFDF3398CB91F7FF8EF4FF8EF4FF8EF4FF8EF4FF8EF4FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFF167CAE8C8C8CDEDEDEFFFFFF3499CCFFFFFF
              99FFFF99FFFF99FFFF99FFFFFFFFFF258ABD2287BA1F84B71D82B51B81B3187E
              B0DFDFDFF7F7F7FFFFFFFFFFFF3499CCFFFFFFFFFFFFFFFFFFFFFFFF2A8FC2C8
              C8C8F6F6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              3499CC3398CB3196C92F94C7DFDFDFF6F6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
            TabOrder = 4
            OnClick = BitBtn11Click
          end
          object EditDefaultCSVReportfolder: TEdit
            Left = 8
            Top = 212
            Width = 290
            Height = 23
            TabOrder = 5
          end
        end
        object CheckBoxtextongrp: TCheckBox
          Left = 199
          Top = 437
          Width = 153
          Height = 20
          Caption = 'Show text info on graph tab'
          TabOrder = 2
        end
      end
      object Panel62: TPanel
        Left = 358
        Top = 0
        Width = 371
        Height = 494
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 1
        object GroupBox107: TGroupBox
          Left = 6
          Top = 5
          Width = 252
          Height = 276
          Caption = 'Error warning system'
          TabOrder = 0
          object GroupBox108: TGroupBox
            Left = 1
            Top = 132
            Width = 240
            Height = 107
            Caption = 'Warn if any page have this status'
            TabOrder = 0
            object CheckListBoxwarnstatus: TCheckListBox
              Left = 11
              Top = 17
              Width = 212
              Height = 82
              ItemHeight = 15
              TabOrder = 0
            end
          end
          object GroupBox109: TGroupBox
            Left = 3
            Top = 18
            Width = 238
            Height = 111
            Caption = 'Warn if any page have this Extstatus'
            TabOrder = 1
            object CheckListBoxwarnext: TCheckListBox
              Left = 9
              Top = 21
              Width = 212
              Height = 81
              ItemHeight = 15
              TabOrder = 0
            end
          end
          object CheckBoxwarnifanydisapproved: TCheckBox
            Left = 7
            Top = 245
            Width = 217
            Height = 17
            Caption = 'Warning if any page is disapproved'
            TabOrder = 2
          end
        end
      end
    end
    object TabSheet15: TTabSheet
      Caption = 'Planning'
      ImageIndex = 9
      object Panel64: TPanel
        Left = 0
        Top = 0
        Width = 273
        Height = 494
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 0
        object GroupBox110: TGroupBox
          Left = 5
          Top = 5
          Width = 263
          Height = 255
          Align = alTop
          Caption = 'Plan running'
          TabOrder = 0
          object Label26: TLabel
            Left = 12
            Top = 111
            Width = 62
            Height = 15
            Caption = 'First edition'
          end
          object Label33: TLabel
            Left = 136
            Top = 111
            Width = 79
            Height = 15
            Caption = 'Default section'
          end
          object Label88: TLabel
            Left = 28
            Top = 228
            Width = 117
            Height = 15
            Caption = 'Min platename length'
          end
          object CheckBoxAllowunplannedcolors: TCheckBox
            Left = 12
            Top = 20
            Width = 205
            Height = 17
            Caption = 'Allow unplanned colors'
            Checked = True
            State = cbChecked
            TabOrder = 0
          end
          object CheckBoxractivateonlyblack: TCheckBox
            Left = 12
            Top = 40
            Width = 205
            Height = 17
            Caption = 'Activate only the black separation'
            TabOrder = 1
          end
          object CheckBoxplatenames: TCheckBox
            Left = 12
            Top = 180
            Width = 229
            Height = 17
            Caption = 'Make platenames'
            Checked = True
            State = cbChecked
            TabOrder = 2
          end
          object CheckBoxplatenamerecount: TCheckBox
            Left = 29
            Top = 205
            Width = 229
            Height = 17
            Caption = 'Platename re-count pr. run'
            TabOrder = 3
          end
          object CheckBoxApplyonlyplannedcolors: TCheckBox
            Left = 12
            Top = 62
            Width = 193
            Height = 17
            Caption = 'Default Apply only planned colors'
            TabOrder = 4
          end
          object Editdefaultfirsted: TEdit
            Left = 12
            Top = 127
            Width = 121
            Height = 23
            TabOrder = 5
          end
          object EditDefsection: TEdit
            Left = 136
            Top = 127
            Width = 121
            Height = 23
            TabOrder = 6
          end
          object Editminplatenamelength: TEdit
            Left = 148
            Top = 224
            Width = 61
            Height = 23
            TabOrder = 7
            Text = '2'
          end
          object UpDown14: TUpDown
            Left = 209
            Top = 224
            Width = 16
            Height = 23
            Associate = Editminplatenamelength
            Min = 1
            Max = 10
            Position = 2
            TabOrder = 8
          end
          object CheckBoxsecInpressruncom: TCheckBox
            Left = 12
            Top = 159
            Width = 245
            Height = 17
            Caption = 'Set section names in pressrun comment'
            TabOrder = 9
          end
          object CheckBoxAutomultipress: TCheckBox
            Left = 12
            Top = 85
            Width = 125
            Height = 17
            Caption = 'Auto multi press copy'
            TabOrder = 10
          end
        end
        object GroupBox41: TGroupBox
          Left = 5
          Top = 260
          Width = 263
          Height = 99
          Align = alTop
          Caption = 'Partial apply'
          TabOrder = 1
          object CheckBoxrecombatunapply: TCheckBox
            Left = 12
            Top = 20
            Width = 153
            Height = 17
            Caption = 'Recombine when unapply'
            TabOrder = 0
          end
          object CheckBoxPartialNoEdChange: TCheckBox
            Left = 12
            Top = 43
            Width = 169
            Height = 17
            Caption = 'No change to editions'
            Checked = True
            State = cbChecked
            TabOrder = 2
          end
          object CheckBoxPartialNoSecChange: TCheckBox
            Left = 12
            Top = 66
            Width = 169
            Height = 17
            Caption = 'No change to sections'
            Checked = True
            State = cbChecked
            TabOrder = 1
          end
        end
        object GroupBox98: TGroupBox
          Left = 7
          Top = 365
          Width = 260
          Height = 53
          Caption = 'Default pagination mode'
          TabOrder = 2
          object ComboBoxdefpagina: TComboBox
            Left = 7
            Top = 22
            Width = 232
            Height = 23
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 0
            Text = 'Simple 0'
            Items.Strings = (
              'Simple 0'
              'Inserted 1'
              'Consecutive 2')
          end
        end
      end
      object Panel65: TPanel
        Left = 273
        Top = 0
        Width = 456
        Height = 494
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 1
        object GroupBox37: TGroupBox
          Left = 5
          Top = 5
          Width = 446
          Height = 217
          Align = alTop
          Caption = 'Misc.'
          TabOrder = 0
          object CheckBoxplannameintree: TCheckBox
            Left = 7
            Top = 161
            Width = 194
            Height = 17
            Caption = 'Planname in filter tree'
            TabOrder = 0
            Visible = False
          end
          object CheckBoxExclusive: TCheckBox
            Left = 7
            Top = 15
            Width = 194
            Height = 18
            Caption = 'Use plan-lock '
            Checked = True
            State = cbChecked
            TabOrder = 1
          end
          object CheckBoxruntrhoughpagina: TCheckBox
            Left = 7
            Top = 34
            Width = 194
            Height = 16
            Caption = 'Pagina runs through '
            TabOrder = 2
          end
          object CheckBoxAutoplannumbergen: TCheckBox
            Left = 7
            Top = 51
            Width = 194
            Height = 17
            Caption = 'Auto ordernumber'
            TabOrder = 3
          end
          object CheckBoxinsertsheetnumbersfor1up: TCheckBox
            Left = 7
            Top = 69
            Width = 399
            Height = 17
            Caption = 'Insert sheet for 1up'
            TabOrder = 4
          end
          object CheckBoxnocommonplates: TCheckBox
            Left = 7
            Top = 87
            Width = 407
            Height = 17
            Caption = 'No common plates'
            TabOrder = 5
          end
          object CheckBoxsplit1upruns: TCheckBox
            Left = 7
            Top = 105
            Width = 391
            Height = 17
            Caption = 'Split press runs'
            TabOrder = 7
          end
          object CheckBoxAlwaysUseOffset0OnApply: TCheckBox
            Left = 7
            Top = 123
            Width = 194
            Height = 18
            Caption = 'Always set offset 0 for plan apply'
            Checked = True
            State = cbChecked
            TabOrder = 6
          end
          object CheckBoxclearpublonload: TCheckBox
            Left = 7
            Top = 142
            Width = 258
            Height = 17
            Caption = 'Clear publication on load'
            TabOrder = 8
          end
          object CheckBoxmanualplanning: TCheckBox
            Left = 194
            Top = 34
            Width = 138
            Height = 20
            Caption = 'Allow manual planning'
            TabOrder = 9
          end
          object CheckBoxmanhw: TCheckBox
            Left = 194
            Top = 15
            Width = 202
            Height = 17
            Caption = 'Manual halfweb selection'
            TabOrder = 10
          end
          object CheckBoxAllowPageMove: TCheckBox
            Left = 194
            Top = 55
            Width = 249
            Height = 18
            Caption = 'Allow page drag-and-drop (Move Pages)'
            TabOrder = 11
          end
        end
        object GroupBox36: TGroupBox
          Left = 5
          Top = 222
          Width = 446
          Height = 121
          Align = alTop
          Caption = 'Defaults for plan creation'
          TabOrder = 1
          object Panel66: TPanel
            Left = 2
            Top = 17
            Width = 214
            Height = 102
            Align = alLeft
            BevelOuter = bvNone
            BorderWidth = 5
            ParentBackground = False
            TabOrder = 0
            object CheckBoxallmarkgroups: TCheckBox
              Left = 5
              Top = 5
              Width = 204
              Height = 17
              Align = alTop
              Caption = 'Select all markgroups by default'
              TabOrder = 0
            end
            object CheckBoxdefaultK: TCheckBox
              Left = 5
              Top = 22
              Width = 204
              Height = 17
              Align = alTop
              Caption = 'Default colors mono'
              TabOrder = 1
            end
            object CheckBoxdefaultPDF: TCheckBox
              Left = 5
              Top = 39
              Width = 204
              Height = 17
              Align = alTop
              Caption = 'Default document type PDF'
              TabOrder = 2
            end
            object CheckBoxdefaultautomateplanname: TCheckBox
              Left = 5
              Top = 56
              Width = 204
              Height = 17
              Align = alTop
              Caption = 'Use auto-generates plannames'
              TabOrder = 3
            end
            object CheckBoxusepresstowerinfo: TCheckBox
              Left = 5
              Top = 73
              Width = 204
              Height = 17
              Align = alTop
              Caption = 'Default use tower specific fanout'
              TabOrder = 4
            end
          end
          object Panel67: TPanel
            Left = 216
            Top = 17
            Width = 228
            Height = 102
            Align = alClient
            BevelOuter = bvNone
            BorderWidth = 5
            ParentBackground = False
            TabOrder = 1
            object CheckBoxDefplaninserted: TCheckBox
              Left = 5
              Top = 5
              Width = 218
              Height = 17
              Align = alTop
              Caption = 'Default Inserted'
              TabOrder = 0
            end
            object CheckBoxPlanpri: TCheckBox
              Left = 5
              Top = 22
              Width = 218
              Height = 17
              Align = alTop
              Caption = 'Use priority from Publication Defaults'
              TabOrder = 1
            end
            object CheckBoxplanexport: TCheckBox
              Left = 5
              Top = 39
              Width = 218
              Height = 17
              Align = alTop
              Caption = 'Enable planexport'
              TabOrder = 2
            end
            object CheckBoxautosetedonload: TCheckBox
              Left = 5
              Top = 56
              Width = 218
              Height = 17
              Align = alTop
              Caption = 'Autoset editions on load'
              TabOrder = 3
            end
            object CheckBoxbackwards: TCheckBox
              Left = 5
              Top = 73
              Width = 218
              Height = 17
              Align = alTop
              Caption = 'Default to backward numbering'
              TabOrder = 4
            end
          end
        end
        object GroupBox106: TGroupBox
          Left = 5
          Top = 343
          Width = 446
          Height = 83
          Align = alTop
          Caption = 'Special'
          TabOrder = 2
          object CheckBoxenablespecifiksel: TCheckBox
            Left = 7
            Top = 15
            Width = 374
            Height = 21
            Caption = 'Allow both press specific ripped pages and commonly ripped pages'
            TabOrder = 0
          end
          object CheckBoxplanclearsections: TCheckBox
            Left = 7
            Top = 36
            Width = 359
            Height = 20
            Caption = 'Clear pressruns'
            TabOrder = 1
          end
          object CheckBoxdefnochangetmpl: TCheckBox
            Left = 7
            Top = 56
            Width = 434
            Height = 20
            Caption = 
              'Keep template from saved press template (ignores default templat' +
              'e for publication)'
            TabOrder = 2
          end
        end
        object GroupBox53: TGroupBox
          Left = 5
          Top = 426
          Width = 446
          Height = 66
          Align = alTop
          Caption = 'Custom plan load module'
          TabOrder = 3
          object Label74: TLabel
            Left = 12
            Top = 40
            Width = 91
            Height = 15
            Caption = 'Plan load exe-file'
          end
          object CheckBoxUseExternalPlanLoad: TCheckBox
            Left = 12
            Top = 17
            Width = 153
            Height = 17
            Caption = 'Use external plan loader'
            TabOrder = 0
          end
          object EditExternalPlanLoadExe: TEdit
            Left = 109
            Top = 37
            Width = 314
            Height = 23
            TabOrder = 1
          end
        end
      end
    end
    object TabSheet30: TTabSheet
      Caption = 'Preview'
      ImageIndex = 10
      object Panel68: TPanel
        Left = 0
        Top = 0
        Width = 217
        Height = 494
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 0
        object GroupBoxconsole: TGroupBox
          Left = 5
          Top = 5
          Width = 207
          Height = 112
          Align = alTop
          Caption = 'Automatic console view'
          TabOrder = 0
          object Label103: TLabel
            Left = 2
            Top = 34
            Width = 203
            Height = 15
            Align = alTop
            Caption = 'Console name'
            ExplicitWidth = 76
          end
          object Label104: TLabel
            Left = 2
            Top = 72
            Width = 203
            Height = 13
            Align = alTop
            AutoSize = False
            Caption = 'Max age sec. (0 no max)'
            ExplicitLeft = 8
            ExplicitTop = 80
            ExplicitWidth = 157
          end
          object CheckBoxautoconsole: TCheckBox
            Left = 2
            Top = 17
            Width = 203
            Height = 17
            Align = alTop
            Caption = 'Use automatic console view'
            TabOrder = 0
          end
          object Editconsolename: TEdit
            Left = 2
            Top = 49
            Width = 203
            Height = 23
            Align = alTop
            TabOrder = 1
          end
          object Editmaxconsoleage: TEdit
            Left = 2
            Top = 85
            Width = 203
            Height = 23
            Align = alTop
            TabOrder = 2
            Text = '60'
            ExplicitWidth = 187
          end
          object UpDowncosoletime: TUpDown
            Left = 189
            Top = 85
            Width = 17
            Height = 23
            Associate = Editmaxconsoleage
            Max = 300
            Increment = 10
            Position = 60
            TabOrder = 3
          end
        end
        object CheckBoxgraydns: TCheckBox
          Left = 5
          Top = 117
          Width = 207
          Height = 17
          Align = alTop
          Caption = 'Gray-style density map'
          TabOrder = 1
        end
        object CheckBoxAllowparalelview: TCheckBox
          Left = 5
          Top = 134
          Width = 207
          Height = 17
          Align = alTop
          Caption = 'Allow parallel Window'
          TabOrder = 2
        end
      end
      object Panel69: TPanel
        Left = 217
        Top = 0
        Width = 266
        Height = 494
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 1
        object GroupBox70: TGroupBox
          Left = 5
          Top = 5
          Width = 256
          Height = 180
          Align = alTop
          Caption = 'Invisible'
          TabOrder = 0
          object Label29: TLabel
            Left = 2
            Top = 17
            Width = 252
            Height = 13
            Align = alTop
            AutoSize = False
            Caption = 'Sidebar width'
            ExplicitLeft = 12
            ExplicitTop = 16
            ExplicitWidth = 181
          end
          object Label31: TLabel
            Left = 2
            Top = 53
            Width = 252
            Height = 13
            Align = alTop
            AutoSize = False
            Caption = 'Sidebar Height'
            ExplicitLeft = 12
            ExplicitTop = 52
            ExplicitWidth = 181
          end
          object LabelInklimit: TLabel
            Left = 2
            Top = 89
            Width = 252
            Height = 15
            Align = alTop
            Caption = 'Ink limit'
            ExplicitWidth = 43
          end
          object Editsidebarwidth: TEdit
            Left = 2
            Top = 30
            Width = 252
            Height = 23
            Align = alTop
            TabOrder = 0
            Text = '160'
          end
          object EditsidebarHeight: TEdit
            Left = 2
            Top = 66
            Width = 252
            Height = 23
            Align = alTop
            TabOrder = 1
            Text = '100'
          end
          object UpDown17: TUpDown
            Left = 238
            Top = 96
            Width = 17
            Height = 21
            Min = 70
            Max = 256
            Increment = 10
            Position = 104
            TabOrder = 2
          end
          object Editinklimit: TEdit
            Left = 2
            Top = 104
            Width = 252
            Height = 23
            Align = alTop
            TabOrder = 3
            Text = '200'
            ExplicitWidth = 236
          end
          object UpDowninklimit: TUpDown
            Left = 238
            Top = 104
            Width = 17
            Height = 23
            Associate = Editinklimit
            Min = 10
            Max = 380
            Position = 200
            TabOrder = 4
          end
          object CheckBoxseponreadview: TCheckBox
            Left = 2
            Top = 127
            Width = 252
            Height = 16
            Align = alTop
            Caption = 'Show separations on readview'
            Checked = True
            State = cbChecked
            TabOrder = 5
          end
        end
      end
      object Panel70: TPanel
        Left = 483
        Top = 0
        Width = 246
        Height = 494
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 2
      end
    end
    object TabSheet31: TTabSheet
      Caption = 'Press naming'
      ImageIndex = 11
      object Panel71: TPanel
        Left = 0
        Top = 0
        Width = 244
        Height = 494
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 0
        object GroupBox5: TGroupBox
          Left = 5
          Top = 5
          Width = 234
          Height = 129
          Align = alTop
          Caption = 'Tower names'
          TabOrder = 0
          object StringGridTowers: TStringGrid
            Left = 2
            Top = 17
            Width = 230
            Height = 110
            Align = alClient
            ColCount = 4
            DefaultRowHeight = 16
            FixedCols = 0
            RowCount = 9
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
            PopupMenu = PopupMenuTower
            TabOrder = 0
            ColWidths = (
              64
              64
              64
              64)
            RowHeights = (
              16
              16
              16
              16
              16
              16
              16
              16
              16)
          end
        end
        object GroupBox7: TGroupBox
          Left = 5
          Top = 134
          Width = 234
          Height = 105
          Align = alTop
          Caption = 'Tower filters'
          TabOrder = 1
          object ValueListEditortowerfilters: TValueListEditor
            Left = 2
            Top = 17
            Width = 230
            Height = 86
            Align = alClient
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect, goThumbTracking]
            PopupMenu = PopupMenutowfilt
            TabOrder = 0
            TitleCaptions.Strings = (
              'Filter name'
              'Towers')
            ColWidths = (
              150
              74)
            RowHeights = (
              18
              18)
          end
        end
        object GroupBox2: TGroupBox
          Left = 5
          Top = 239
          Width = 234
          Height = 129
          Align = alTop
          Caption = 'Stack names'
          TabOrder = 2
          object ListViewStacknames: TListView
            Left = 2
            Top = 17
            Width = 230
            Height = 86
            Align = alTop
            Columns = <
              item
                AutoSize = True
                Caption = 'Name'
              end>
            RowSelect = True
            PopupMenu = PopupMenuStack
            TabOrder = 0
            ViewStyle = vsReport
          end
          object CheckBoxOrstacks: TCheckBox
            Left = 8
            Top = 104
            Width = 133
            Height = 17
            Caption = 'Or stackpostions'
            TabOrder = 1
          end
        end
        object CheckBoxCustomtowerrnames: TCheckBox
          Left = 5
          Top = 368
          Width = 234
          Height = 17
          Align = alTop
          Caption = 'Use custom Tower naming'
          TabOrder = 3
        end
        object CheckBoxUseDBtowernames: TCheckBox
          Left = 5
          Top = 408
          Width = 234
          Height = 21
          Align = alTop
          Caption = 'Use DB tower names'
          Checked = True
          State = cbChecked
          TabOrder = 4
        end
        object CheckBoxtowerorderauto: TCheckBox
          Left = 5
          Top = 385
          Width = 234
          Height = 23
          Align = alTop
          Caption = 'Use order of towers when planning'
          TabOrder = 5
        end
        object CheckBoxusetruesheetside: TCheckBox
          Left = 5
          Top = 429
          Width = 234
          Height = 20
          Align = alTop
          Caption = 'Use true sheet side'
          TabOrder = 6
        end
      end
      object Panel72: TPanel
        Left = 244
        Top = 0
        Width = 223
        Height = 494
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 1
        object Label81: TLabel
          Left = 5
          Top = 134
          Width = 213
          Height = 15
          Align = alTop
          Caption = 'High plate'
          ExplicitWidth = 55
        end
        object Label82: TLabel
          Left = 5
          Top = 172
          Width = 213
          Height = 15
          Align = alTop
          Caption = 'Low plate'
          ExplicitWidth = 51
        end
        object GroupBox3: TGroupBox
          Left = 5
          Top = 5
          Width = 213
          Height = 129
          Align = alTop
          Caption = 'Cylinder names'
          TabOrder = 0
          object ValueListEditorCyl: TValueListEditor
            Left = 2
            Top = 17
            Width = 209
            Height = 110
            Align = alClient
            TabOrder = 0
            TitleCaptions.Strings = (
              'Color'
              'Cylinder')
            ColWidths = (
              150
              53)
            RowHeights = (
              18
              18)
          end
        end
        object EditHighplate: TEdit
          Left = 5
          Top = 149
          Width = 213
          Height = 23
          Align = alTop
          TabOrder = 1
          Text = 'High'
        end
        object EditLowplate: TEdit
          Left = 5
          Top = 187
          Width = 213
          Height = 23
          Align = alTop
          TabOrder = 2
          Text = 'Low'
        end
        object GroupBox4: TGroupBox
          Left = 5
          Top = 210
          Width = 213
          Height = 127
          Align = alTop
          Caption = 'Zone names'
          TabOrder = 3
          object ListViewZonenames: TListView
            Left = 2
            Top = 17
            Width = 209
            Height = 108
            Align = alClient
            Columns = <
              item
                AutoSize = True
                Caption = 'Name'
              end>
            RowSelect = True
            PopupMenu = PopupMenuZone
            TabOrder = 0
            ViewStyle = vsReport
          end
        end
      end
      object Panel73: TPanel
        Left = 467
        Top = 0
        Width = 262
        Height = 494
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 2
        object GroupBox16: TGroupBox
          Left = 5
          Top = 5
          Width = 252
          Height = 129
          Align = alTop
          Caption = 'Enabled markgroups'
          TabOrder = 0
          object ListViewdefmarks: TListView
            Left = 2
            Top = 17
            Width = 248
            Height = 110
            Align = alClient
            Columns = <
              item
                AutoSize = True
                Caption = 'Name'
              end>
            RowSelect = True
            PopupMenu = PopupMenudefmarks
            TabOrder = 0
            ViewStyle = vsReport
          end
        end
        object GroupBox105: TGroupBox
          Left = 5
          Top = 134
          Width = 252
          Height = 163
          Align = alTop
          Caption = 'Old style ink regeneration'
          TabOrder = 1
          object ValueListEditorOldInk: TValueListEditor
            Left = 2
            Top = 34
            Width = 248
            Height = 127
            Align = alClient
            TabOrder = 0
            TitleCaptions.Strings = (
              'Press'
              'Path')
            ColWidths = (
              150
              92)
            RowHeights = (
              18
              18)
          end
          object CheckBoxinkpresspath: TCheckBox
            Left = 2
            Top = 17
            Width = 248
            Height = 17
            Align = alTop
            Caption = 'Use press path'
            TabOrder = 1
          end
        end
        object GroupBox89: TGroupBox
          Left = 5
          Top = 297
          Width = 252
          Height = 135
          Align = alTop
          Caption = 'Cylinder names'
          TabOrder = 2
          object ValueListEditormaxpagepress: TValueListEditor
            Left = 2
            Top = 17
            Width = 248
            Height = 116
            Align = alClient
            TabOrder = 0
            TitleCaptions.Strings = (
              'Press'
              'Max pages')
            ColWidths = (
              150
              92)
            RowHeights = (
              18
              18)
          end
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Export'
      ImageIndex = 12
      object Panel74: TPanel
        Left = 0
        Top = 0
        Width = 289
        Height = 494
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 0
        object GroupBox71: TGroupBox
          Left = 5
          Top = 5
          Width = 279
          Height = 232
          Align = alTop
          Caption = 'ControlCenter report'
          TabOrder = 0
          object Label62: TLabel
            Left = 2
            Top = 34
            Width = 275
            Height = 13
            Align = alTop
            AutoSize = False
            Caption = 'Store report in'
            ExplicitLeft = 8
            ExplicitTop = 36
            ExplicitWidth = 185
          end
          object Label63: TLabel
            Left = 2
            Top = 79
            Width = 275
            Height = 13
            Align = alTop
            AutoSize = False
            Caption = 'Report timeout'
            ExplicitLeft = 8
            ExplicitTop = 80
            ExplicitWidth = 185
          end
          object CheckBoxgenrepwhendel: TCheckBox
            Left = 2
            Top = 17
            Width = 275
            Height = 17
            Align = alTop
            Caption = 'Generate report when deleting'
            TabOrder = 0
          end
          object ReportTimeOut: TEdit
            Left = 2
            Top = 92
            Width = 275
            Height = 23
            Align = alTop
            TabOrder = 1
            Text = '60'
            ExplicitWidth = 259
          end
          object UpDown13: TUpDown
            Left = 261
            Top = 92
            Width = 17
            Height = 23
            Associate = ReportTimeOut
            Min = 30
            Max = 1000
            Position = 60
            TabOrder = 2
          end
          object ReportOnProductionDeleteEmail: TCheckBox
            Left = 2
            Top = 115
            Width = 275
            Height = 17
            Align = alTop
            Caption = 'Email report when deleting'
            TabOrder = 3
          end
          object EmailUsePublicationSpecificMail: TCheckBox
            Left = 2
            Top = 132
            Width = 275
            Height = 17
            Align = alTop
            Caption = 'Use publication specific Email'
            TabOrder = 4
          end
          object Panel75: TPanel
            Left = 2
            Top = 47
            Width = 275
            Height = 32
            Align = alTop
            BevelOuter = bvNone
            BorderWidth = 5
            ParentBackground = False
            TabOrder = 5
            object ReportSaveFolder: TEdit
              Left = 5
              Top = 5
              Width = 190
              Height = 22
              Align = alClient
              TabOrder = 0
              ExplicitHeight = 23
            end
            object BitBtn4: TBitBtn
              Left = 195
              Top = 5
              Width = 75
              Height = 22
              Align = alRight
              Caption = 'Browse'
              Glyph.Data = {
                36030000424D3603000000000000360000002800000010000000100000000100
                1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFF6F6F6DFDFDFD6D6D6D6D6D6D6D6D6D6D6D6D6
                D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6DFDFDFF6F6F6F6F6F6C8C8C8
                8383836D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D
                6D6D6D6D838383C8C8C8DFDFDF1D82B51B81B3187EB0167CAE1379AB1076A80D
                73A50B71A3086EA0066C9E046A9C02689A0167994C4C4C8383832287BA67CCFF
                2085B899FFFF6FD4FF6FD4FF6FD4FF6FD4FF6FD4FF6FD4FF6FD4FF6FD4FF3BA0
                D399FFFF0167996E6E6E258ABD67CCFF278CBF99FFFF7BE0FF7BE0FF7BE0FF7B
                E0FF7BE0FF7BE0FF7BE0FF7BE0FF44A9DC99FFFF02689A6D6D6D288DC067CCFF
                2D92C599FFFF85EBFF85EBFF85EBFF85EBFF85EBFF85EBFF85EBFF85EBFF4EB3
                E699FFFF046A9C6D6D6D2A8FC267CCFF3398CB99FFFF91F7FF91F7FF91F7FF91
                F7FF91F7FF91F7FF91F7FF91F7FF57BCEF99FFFF066C9E6D6D6D2D92C56FD4FF
                3499CC99FFFF99FFFF99FFFF99FFFF99FFFF99FFFF99FFFF99FFFF99FFFF60C5
                F899FFFF086EA06E6E6E2F94C77BE0FF2D92C5FFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFF81E6FFFFFFFF0B71A38C8C8C3196C985EBFF
                81E6FF2D92C52D92C52D92C52D92C52D92C52D92C5288DC02489BC2085B81C81
                B41B81B31B81B3DFDFDF3398CB91F7FF8EF4FF8EF4FF8EF4FF8EF4FF8EF4FFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFF167CAE8C8C8CDEDEDEFFFFFF3499CCFFFFFF
                99FFFF99FFFF99FFFF99FFFFFFFFFF258ABD2287BA1F84B71D82B51B81B3187E
                B0DFDFDFF7F7F7FFFFFFFFFFFF3499CCFFFFFFFFFFFFFFFFFFFFFFFF2A8FC2C8
                C8C8F6F6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                3499CC3398CB3196C92F94C7DFDFDFF6F6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
              TabOrder = 1
              OnClick = BitBtn4Click
            end
          end
          object Panel76: TPanel
            Left = 2
            Top = 149
            Width = 133
            Height = 81
            Align = alLeft
            BevelOuter = bvNone
            BorderWidth = 5
            ParentBackground = False
            TabOrder = 6
            object Label64: TLabel
              Left = 5
              Top = 5
              Width = 123
              Height = 13
              Align = alTop
              AutoSize = False
              Caption = 'Email from'
              ExplicitLeft = 8
              ExplicitTop = 156
              ExplicitWidth = 141
            end
            object Label86: TLabel
              Left = 5
              Top = 41
              Width = 123
              Height = 13
              Align = alTop
              AutoSize = False
              Caption = 'Email CC'
              ExplicitLeft = 8
              ExplicitTop = 196
              ExplicitWidth = 141
            end
            object MailFrom: TEdit
              Left = 5
              Top = 18
              Width = 123
              Height = 23
              Align = alTop
              TabOrder = 0
              Text = 'plancenter@controlcenter.net'
            end
            object MailCC: TEdit
              Left = 5
              Top = 54
              Width = 123
              Height = 23
              Align = alTop
              TabOrder = 1
            end
          end
          object Panel77: TPanel
            Left = 135
            Top = 149
            Width = 142
            Height = 81
            Align = alClient
            BevelOuter = bvNone
            BorderWidth = 5
            ParentBackground = False
            TabOrder = 7
            object Label85: TLabel
              Left = 5
              Top = 5
              Width = 132
              Height = 13
              Align = alTop
              AutoSize = False
              Caption = 'Email to'
              ExplicitLeft = 10
              ExplicitTop = 13
              ExplicitWidth = 450
            end
            object Label87: TLabel
              Left = 5
              Top = 41
              Width = 132
              Height = 13
              Align = alTop
              AutoSize = False
              Caption = 'Email Subject'
              ExplicitLeft = 10
              ExplicitTop = 47
              ExplicitWidth = 450
            end
            object MailTo: TEdit
              Left = 5
              Top = 18
              Width = 132
              Height = 23
              Align = alTop
              TabOrder = 0
              Text = 'admin@controlcenter.net'
            end
            object MailSubject: TEdit
              Left = 5
              Top = 54
              Width = 132
              Height = 23
              Align = alTop
              TabOrder = 1
              Text = 'ControlCenter report'
            end
          end
        end
        object GroupBox64: TGroupBox
          Left = 5
          Top = 237
          Width = 279
          Height = 172
          Align = alTop
          Caption = 'Custom export'
          TabOrder = 1
          object Label80: TLabel
            Left = 2
            Top = 17
            Width = 275
            Height = 13
            Align = alTop
            AutoSize = False
            Caption = 'Custom plan export destination'
            ExplicitLeft = 12
            ExplicitTop = 20
            ExplicitWidth = 185
          end
          object Label1: TLabel
            Left = 2
            Top = 89
            Width = 275
            Height = 15
            Align = alTop
            Caption = 'Custom delete command file destination'
            ExplicitWidth = 216
          end
          object Label2: TLabel
            Left = 2
            Top = 53
            Width = 275
            Height = 13
            Align = alTop
            AutoSize = False
            Caption = 'Custom plan export filename'
            ExplicitLeft = 12
            ExplicitTop = 60
            ExplicitWidth = 185
          end
          object Label12: TLabel
            Left = 2
            Top = 127
            Width = 275
            Height = 15
            Align = alTop
            Caption = 'Custom delete command filename'
            ExplicitWidth = 184
          end
          object EditCustomplanexportdest: TEdit
            Left = 2
            Top = 30
            Width = 275
            Height = 23
            Align = alTop
            TabOrder = 0
          end
          object Editcustomdelcomdest: TEdit
            Left = 2
            Top = 104
            Width = 275
            Height = 23
            Align = alTop
            TabOrder = 1
          end
          object EditCustomplanexportfilename: TEdit
            Left = 2
            Top = 66
            Width = 275
            Height = 23
            Align = alTop
            TabOrder = 2
            Text = '01_P_PRO_%O_%V.xml'
          end
        end
      end
      object Panel78: TPanel
        Left = 289
        Top = 0
        Width = 232
        Height = 494
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 1
        object GroupBox56: TGroupBox
          Left = 5
          Top = 5
          Width = 222
          Height = 254
          Align = alClient
          Caption = 'Excel'
          Enabled = False
          TabOrder = 0
          object Label10: TLabel
            Left = 2
            Top = 17
            Width = 218
            Height = 13
            Align = alTop
            AutoSize = False
            Caption = 'Data'
            ExplicitLeft = 12
            ExplicitTop = 16
            ExplicitWidth = 221
          end
          object CheckListBoxexport: TCheckListBox
            Left = 2
            Top = 30
            Width = 218
            Height = 205
            Align = alClient
            ItemHeight = 15
            TabOrder = 0
          end
          object CheckBoxOnlyselection: TCheckBox
            Left = 2
            Top = 235
            Width = 218
            Height = 17
            Align = alBottom
            Caption = 'Only selected data'
            TabOrder = 1
          end
        end
        object GroupBox73: TGroupBox
          Left = 5
          Top = 259
          Width = 222
          Height = 230
          Align = alBottom
          Caption = 'Plate list print'
          TabOrder = 1
          object Label89: TLabel
            Left = 2
            Top = 17
            Width = 218
            Height = 15
            Align = alTop
            Caption = 'Title'
            ExplicitWidth = 22
          end
          object Splitter1: TSplitter
            Left = 2
            Top = 93
            Width = 218
            Height = 3
            Cursor = crVSplit
            Align = alTop
            ExplicitTop = 89
            ExplicitWidth = 249
          end
          object CheckListBoxPLtPrntplate: TCheckListBox
            Left = 2
            Top = 96
            Width = 218
            Height = 86
            Align = alTop
            ItemHeight = 15
            Items.Strings = (
              'Section'
              'Copynumber'
              'LowPage'
              'All Pages'
              'Platenumber'
              'Sheet')
            TabOrder = 0
          end
          object CheckListBoxPLtPrnttitle: TCheckListBox
            Left = 2
            Top = 32
            Width = 218
            Height = 61
            Align = alTop
            ItemHeight = 15
            Items.Strings = (
              'Press'
              'Publication'
              'Pubdate'
              'Edition')
            TabOrder = 1
          end
          object Panel4: TPanel
            Left = 2
            Top = 187
            Width = 218
            Height = 41
            Align = alBottom
            BevelOuter = bvNone
            TabOrder = 2
            object Button9: TButton
              Left = 12
              Top = 8
              Width = 75
              Height = 25
              Caption = 'Font'
              TabOrder = 0
              OnClick = Button9Click
            end
            object CheckBoxplateprtsecpage: TCheckBox
              Left = 100
              Top = 12
              Width = 137
              Height = 17
              Caption = 'Section + page'
              TabOrder = 1
            end
          end
        end
      end
      object Panel79: TPanel
        Left = 521
        Top = 0
        Width = 208
        Height = 494
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 2
      end
    end
    object TabSheet32: TTabSheet
      Caption = 'Email'
      ImageIndex = 13
      object Panel80: TPanel
        Left = 0
        Top = 0
        Width = 193
        Height = 494
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 0
        object GroupBox17: TGroupBox
          Left = 5
          Top = 5
          Width = 183
          Height = 100
          Align = alTop
          Caption = 'Email sender'
          TabOrder = 0
          object Label39: TLabel
            Left = 2
            Top = 17
            Width = 179
            Height = 13
            Align = alTop
            AutoSize = False
            Caption = 'Email address '
            ExplicitLeft = 12
            ExplicitTop = 76
            ExplicitWidth = 141
          end
          object Label37: TLabel
            Left = 2
            Top = 53
            Width = 179
            Height = 13
            Align = alTop
            AutoSize = False
            Caption = 'Email server'
            ExplicitLeft = 12
            ExplicitTop = 24
            ExplicitWidth = 141
          end
          object Editemailadress: TEdit
            Left = 2
            Top = 30
            Width = 179
            Height = 23
            Align = alTop
            TabOrder = 0
          end
          object Editemailserver: TEdit
            Left = 2
            Top = 66
            Width = 179
            Height = 23
            Align = alTop
            TabOrder = 1
          end
        end
        object RadioGroupemailimageformat: TRadioGroup
          Left = 5
          Top = 105
          Width = 183
          Height = 53
          Align = alTop
          Caption = 'Email image format'
          Columns = 2
          ItemIndex = 0
          Items.Strings = (
            'Attach'
            'Include')
          TabOrder = 1
        end
        object GroupBox19: TGroupBox
          Left = 5
          Top = 158
          Width = 183
          Height = 83
          Align = alTop
          Caption = 'Sender name'
          TabOrder = 2
          object Label40: TLabel
            Left = 2
            Top = 34
            Width = 179
            Height = 13
            Align = alTop
            AutoSize = False
            Caption = 'Fixed name'
            ExplicitLeft = 8
            ExplicitTop = 48
            ExplicitWidth = 141
          end
          object Editsendername: TEdit
            Left = 2
            Top = 47
            Width = 179
            Height = 23
            Align = alTop
            TabOrder = 0
            Text = 'Plancenter'
          end
          object CheckBoxemailasuser: TCheckBox
            Left = 2
            Top = 17
            Width = 179
            Height = 17
            Align = alTop
            Caption = 'Use username'
            TabOrder = 1
          end
        end
      end
      object Panel81: TPanel
        Left = 193
        Top = 0
        Width = 264
        Height = 494
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 1
        object RadioGroupSendemail: TRadioGroup
          Left = 5
          Top = 5
          Width = 254
          Height = 62
          Align = alTop
          Caption = 'Send email after disapproving'
          Columns = 3
          ItemIndex = 0
          Items.Strings = (
            'Never'
            'Ask'
            'Automatic')
          TabOrder = 0
        end
        object GroupBox20: TGroupBox
          Left = 5
          Top = 67
          Width = 254
          Height = 223
          Align = alTop
          Caption = 'Email information'
          TabOrder = 1
          object Label41: TLabel
            Left = 2
            Top = 17
            Width = 250
            Height = 13
            Align = alTop
            AutoSize = False
            Caption = 'Titel (N) for pagename (U) for user'
            ExplicitLeft = 8
            ExplicitTop = 16
            ExplicitWidth = 257
          end
          object Editemailtitle: TEdit
            Left = 2
            Top = 30
            Width = 250
            Height = 23
            Align = alTop
            MaxLength = 50
            TabOrder = 0
            Text = 'Page (N) has been disapproved by (U)'
          end
          object GroupBox21: TGroupBox
            Left = 2
            Top = 53
            Width = 250
            Height = 168
            Align = alClient
            Caption = 'Pagename'
            TabOrder = 1
            object Editemailpagename: TEdit
              Left = 2
              Top = 17
              Width = 246
              Height = 23
              Align = alTop
              TabOrder = 0
              Text = '%P %S %N %C'
            end
            object ListBox1: TListBox
              Left = 2
              Top = 40
              Width = 246
              Height = 126
              Align = alClient
              ItemHeight = 15
              Items.Strings = (
                '%P Publication'
                '%D Publication date'
                '%E Edition'
                '%S Section'
                '%N Pagenumber')
              TabOrder = 1
            end
          end
        end
      end
      object Panel82: TPanel
        Left = 457
        Top = 0
        Width = 272
        Height = 494
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 2
      end
    end
    object TabSheet8: TTabSheet
      Caption = 'Advanced autorelease'
      ImageIndex = 14
      TabVisible = False
      object StringGrid1: TStringGrid
        Left = -40
        Top = 8
        Width = 777
        Height = 233
        DefaultColWidth = 100
        DefaultRowHeight = 16
        TabOrder = 0
        ColWidths = (
          100
          100
          100
          100
          100)
        RowHeights = (
          16
          16
          16
          16
          16)
      end
      object Button6: TButton
        Left = 40
        Top = 260
        Width = 75
        Height = 25
        Caption = 'Button6'
        TabOrder = 1
        OnClick = Button6Click
      end
      object Button7: TButton
        Left = 132
        Top = 260
        Width = 75
        Height = 25
        Caption = 'Button7'
        TabOrder = 2
      end
    end
    object TabSheet13: TTabSheet
      Caption = 'Integration'
      ImageIndex = 15
      object Panel83: TPanel
        Left = 0
        Top = 0
        Width = 205
        Height = 494
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 0
        object GroupBox101: TGroupBox
          Left = 5
          Top = 5
          Width = 195
          Height = 103
          Align = alTop
          Caption = 'Press data request system'
          TabOrder = 0
          object Label27: TLabel
            Left = 2
            Top = 17
            Width = 191
            Height = 15
            Align = alTop
            Caption = 'Level'
            ExplicitWidth = 27
          end
          object ComboBoxpressreqlevel: TComboBox
            Left = 2
            Top = 32
            Width = 191
            Height = 23
            Align = alTop
            Style = csDropDownList
            TabOrder = 0
            Items.Strings = (
              'No press import'
              'Publication'
              'Edition'
              'Section')
          end
          object CheckBoxpressspecreq: TCheckBox
            Left = 2
            Top = 55
            Width = 191
            Height = 17
            Align = alTop
            Caption = 'Press specific'
            Checked = True
            State = cbChecked
            TabOrder = 1
          end
        end
        object GroupBox99: TGroupBox
          Left = 5
          Top = 108
          Width = 195
          Height = 49
          Align = alTop
          Caption = 'Direct pecom data import'
          TabOrder = 1
          object CheckBoxpecomImport: TCheckBox
            Left = 2
            Top = 17
            Width = 191
            Height = 17
            Align = alTop
            Caption = 'Use Pecom Import'
            TabOrder = 0
          end
        end
      end
      object Panel84: TPanel
        Left = 205
        Top = 0
        Width = 332
        Height = 494
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 1
        object GroupBox76: TGroupBox
          Left = 5
          Top = 5
          Width = 322
          Height = 153
          Align = alTop
          Caption = 'Ink Preset'
          TabOrder = 0
          object ValueListEditorInkGen: TValueListEditor
            Left = 2
            Top = 17
            Width = 318
            Height = 134
            Align = alClient
            TabOrder = 0
            TitleCaptions.Strings = (
              'Press'
              'Preset System')
            ColWidths = (
              150
              162)
            RowHeights = (
              18
              18)
          end
          object ListBoxInpresettypes: TListBox
            Left = 52
            Top = 48
            Width = 109
            Height = 85
            ItemHeight = 15
            Items.Strings = (
              'None'
              'ABB'
              'EAE'
              'PERRETTA'
              'Honeywell'
              'Honeywell 0..99'
              'Monigraf')
            TabOrder = 1
            Visible = False
          end
        end
        object GroupBox103: TGroupBox
          Left = 5
          Top = 158
          Width = 322
          Height = 260
          Align = alTop
          Caption = 'Honeywell plate select'
          TabOrder = 1
          object Label109: TLabel
            Left = 2
            Top = 34
            Width = 318
            Height = 15
            Align = alTop
            Caption = 'Path:'
            ExplicitWidth = 27
          end
          object EditPathtohoneywell: TEdit
            Left = 2
            Top = 49
            Width = 318
            Height = 23
            Align = alTop
            TabOrder = 0
          end
          object BitBtn10: TBitBtn
            Left = 2
            Top = 72
            Width = 318
            Height = 25
            Align = alTop
            Caption = 'Browse'
            TabOrder = 1
            OnClick = BitBtn1Click
          end
          object CheckBoxUsehoneywell: TCheckBox
            Left = 2
            Top = 17
            Width = 318
            Height = 17
            Align = alTop
            Caption = 'Use honeywell preview files'
            TabOrder = 2
          end
          object Panel87: TPanel
            Left = 2
            Top = 97
            Width = 318
            Height = 62
            Align = alTop
            BevelOuter = bvNone
            BorderWidth = 5
            ParentBackground = False
            TabOrder = 3
            object Panel85: TPanel
              Left = 5
              Top = 5
              Width = 140
              Height = 52
              Align = alLeft
              BevelOuter = bvNone
              BorderWidth = 5
              ParentBackground = False
              TabOrder = 0
              object Label105: TLabel
                Left = 5
                Top = 5
                Width = 130
                Height = 15
                Align = alTop
                Caption = 'Username'
                ExplicitWidth = 53
              end
              object EditHoneywellusername: TEdit
                Left = 5
                Top = 20
                Width = 130
                Height = 23
                Align = alTop
                TabOrder = 0
              end
            end
            object Panel86: TPanel
              Left = 145
              Top = 5
              Width = 168
              Height = 52
              Align = alClient
              BevelOuter = bvNone
              BorderWidth = 5
              ParentBackground = False
              TabOrder = 1
              object Label106: TLabel
                Left = 5
                Top = 5
                Width = 158
                Height = 15
                Align = alTop
                Caption = 'Password'
                ExplicitWidth = 50
              end
              object EditHoneywellpassword: TEdit
                Left = 5
                Top = 20
                Width = 158
                Height = 23
                Align = alTop
                TabOrder = 0
              end
            end
          end
        end
      end
      object Panel88: TPanel
        Left = 537
        Top = 0
        Width = 192
        Height = 494
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 2
      end
    end
    object TabSheet14: TTabSheet
      Caption = 'Planned name'
      ImageIndex = 16
      object Panel89: TPanel
        Left = 0
        Top = 0
        Width = 729
        Height = 169
        Align = alTop
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 0
        object GroupBox42: TGroupBox
          Left = 5
          Top = 5
          Width = 719
          Height = 153
          Align = alTop
          Caption = 'Naming styles'
          TabOrder = 0
          object ListViewplannamedstyles: TListView
            Left = 2
            Top = 17
            Width = 715
            Height = 134
            Align = alClient
            Checkboxes = True
            Columns = <
              item
                Caption = 'Name'
                Width = 103
              end
              item
                Caption = 'Format'
                Width = 103
              end
              item
                Caption = 'Date format'
                Width = 103
              end>
            GridLines = True
            HideSelection = False
            Items.ItemData = {
              056C0000000100000000000000FFFFFFFFFFFFFFFF02000000FFFFFFFF000000
              000542006C0061006E006B0019740068006500200070006C0061006E006E0065
              00640020006E0061006D006500200069007300200065006D0070007400790000
              000000046E006F006E00650000000000FFFFFFFF}
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
            ExplicitTop = 15
            ExplicitWidth = 275
            ExplicitHeight = 136
          end
        end
      end
      object Panel90: TPanel
        Left = 0
        Top = 169
        Width = 729
        Height = 169
        Align = alTop
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 1
        object GroupBox24: TGroupBox
          Left = 5
          Top = 5
          Width = 719
          Height = 153
          Align = alTop
          Caption = 'Name types'
          TabOrder = 0
          object ListBox3: TListBox
            Left = 2
            Top = 17
            Width = 715
            Height = 134
            Align = alClient
            ItemHeight = 15
            Items.Strings = (
              '%P Publication'
              '%E Edition'
              '%S Section'
              '%N Pagename'
              '%D Date'
              '%W Week'
              '%L Location')
            TabOrder = 0
          end
        end
      end
      object Panel91: TPanel
        Left = 0
        Top = 338
        Width = 729
        Height = 156
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 2
        object Label43: TLabel
          Left = 5
          Top = 5
          Width = 719
          Height = 15
          Align = alTop
          Caption = 'Name'
          ExplicitWidth = 32
        end
        object Label44: TLabel
          Left = 5
          Top = 43
          Width = 719
          Height = 15
          Align = alTop
          Caption = 'Format'
          ExplicitWidth = 38
        end
        object Label55: TLabel
          Left = 5
          Top = 81
          Width = 719
          Height = 15
          Align = alTop
          Caption = 'Date format'
          ExplicitWidth = 63
        end
        object Editstylename: TEdit
          Left = 5
          Top = 20
          Width = 719
          Height = 23
          Align = alTop
          TabOrder = 0
        end
        object Editnameformat: TEdit
          Left = 5
          Top = 58
          Width = 719
          Height = 23
          Align = alTop
          TabOrder = 1
        end
        object Editnamedateformat: TEdit
          Left = 5
          Top = 96
          Width = 719
          Height = 23
          Align = alTop
          TabOrder = 2
          Text = 'DDMM'
        end
        object Panel92: TPanel
          Left = 5
          Top = 119
          Width = 719
          Height = 50
          Align = alTop
          BevelOuter = bvNone
          BorderWidth = 5
          ParentBackground = False
          TabOrder = 3
          object BitBtn7: TBitBtn
            Left = 1
            Top = 6
            Width = 75
            Height = 25
            Caption = 'Add'
            TabOrder = 0
            OnClick = BitBtn7Click
          end
          object BitBtn9: TBitBtn
            Left = 82
            Top = 6
            Width = 75
            Height = 25
            Caption = 'Delete'
            TabOrder = 1
            OnClick = BitBtn9Click
          end
          object BitBtn8: TBitBtn
            Left = 163
            Top = 6
            Width = 75
            Height = 25
            Caption = 'Apply'
            TabOrder = 2
            OnClick = BitBtn8Click
          end
        end
      end
    end
    object TabSheet17: TTabSheet
      Caption = 'Archive'
      ImageIndex = 17
      object Panel93: TPanel
        Left = 0
        Top = 0
        Width = 729
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 0
        object CheckBoxarchiveenabled: TCheckBox
          Left = 5
          Top = 5
          Width = 169
          Height = 31
          Align = alLeft
          Caption = 'Archive enabled'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object CheckBoxdefarchivehighress: TCheckBox
          Left = 174
          Top = 5
          Width = 105
          Height = 31
          Align = alLeft
          Caption = 'Default highres'
          TabOrder = 1
        end
        object CheckBoxdefarchivelowres: TCheckBox
          Left = 279
          Top = 5
          Width = 105
          Height = 31
          Align = alLeft
          Caption = 'Default lowres'
          TabOrder = 2
        end
      end
      object Panel94: TPanel
        Left = 0
        Top = 41
        Width = 729
        Height = 115
        Align = alTop
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 1
        object GroupBox30: TGroupBox
          Left = 5
          Top = 5
          Width = 719
          Height = 45
          Align = alTop
          Caption = 'Main highres archive folder'
          TabOrder = 0
          object Editmainarchivefolderhighres: TEdit
            Left = 2
            Top = 17
            Width = 608
            Height = 26
            Align = alLeft
            TabOrder = 0
            ExplicitHeight = 23
          end
          object BitBtn5: TBitBtn
            Left = 620
            Top = 16
            Width = 75
            Height = 25
            Caption = 'Browse'
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF6F6F6DFDFDFD6D6D6D6D6D6D6D6D6D6D6D6D6
              D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6DFDFDFF6F6F6F6F6F6C8C8C8
              8383836D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D
              6D6D6D6D838383C8C8C8DFDFDF1D82B51B81B3187EB0167CAE1379AB1076A80D
              73A50B71A3086EA0066C9E046A9C02689A0167994C4C4C8383832287BA67CCFF
              2085B899FFFF6FD4FF6FD4FF6FD4FF6FD4FF6FD4FF6FD4FF6FD4FF6FD4FF3BA0
              D399FFFF0167996E6E6E258ABD67CCFF278CBF99FFFF7BE0FF7BE0FF7BE0FF7B
              E0FF7BE0FF7BE0FF7BE0FF7BE0FF44A9DC99FFFF02689A6D6D6D288DC067CCFF
              2D92C599FFFF85EBFF85EBFF85EBFF85EBFF85EBFF85EBFF85EBFF85EBFF4EB3
              E699FFFF046A9C6D6D6D2A8FC267CCFF3398CB99FFFF91F7FF91F7FF91F7FF91
              F7FF91F7FF91F7FF91F7FF91F7FF57BCEF99FFFF066C9E6D6D6D2D92C56FD4FF
              3499CC99FFFF99FFFF99FFFF99FFFF99FFFF99FFFF99FFFF99FFFF99FFFF60C5
              F899FFFF086EA06E6E6E2F94C77BE0FF2D92C5FFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFF81E6FFFFFFFF0B71A38C8C8C3196C985EBFF
              81E6FF2D92C52D92C52D92C52D92C52D92C52D92C5288DC02489BC2085B81C81
              B41B81B31B81B3DFDFDF3398CB91F7FF8EF4FF8EF4FF8EF4FF8EF4FF8EF4FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFF167CAE8C8C8CDEDEDEFFFFFF3499CCFFFFFF
              99FFFF99FFFF99FFFF99FFFFFFFFFF258ABD2287BA1F84B71D82B51B81B3187E
              B0DFDFDFF7F7F7FFFFFFFFFFFF3499CCFFFFFFFFFFFFFFFFFFFFFFFF2A8FC2C8
              C8C8F6F6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              3499CC3398CB3196C92F94C7DFDFDFF6F6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
            TabOrder = 1
            OnClick = BitBtn5Click
          end
        end
        object GroupBox33: TGroupBox
          Left = 5
          Top = 50
          Width = 719
          Height = 45
          Align = alTop
          Caption = 'Main lowres archive folder'
          TabOrder = 1
          object Editmainarchivefolderlowres: TEdit
            Left = 2
            Top = 17
            Width = 608
            Height = 26
            Align = alLeft
            TabOrder = 0
            ExplicitHeight = 23
          end
          object BitBtnlresarc: TBitBtn
            Left = 620
            Top = 16
            Width = 75
            Height = 25
            Caption = 'Browse'
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFF6F6F6DFDFDFD6D6D6D6D6D6D6D6D6D6D6D6D6
              D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6DFDFDFF6F6F6F6F6F6C8C8C8
              8383836D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D
              6D6D6D6D838383C8C8C8DFDFDF1D82B51B81B3187EB0167CAE1379AB1076A80D
              73A50B71A3086EA0066C9E046A9C02689A0167994C4C4C8383832287BA67CCFF
              2085B899FFFF6FD4FF6FD4FF6FD4FF6FD4FF6FD4FF6FD4FF6FD4FF6FD4FF3BA0
              D399FFFF0167996E6E6E258ABD67CCFF278CBF99FFFF7BE0FF7BE0FF7BE0FF7B
              E0FF7BE0FF7BE0FF7BE0FF7BE0FF44A9DC99FFFF02689A6D6D6D288DC067CCFF
              2D92C599FFFF85EBFF85EBFF85EBFF85EBFF85EBFF85EBFF85EBFF85EBFF4EB3
              E699FFFF046A9C6D6D6D2A8FC267CCFF3398CB99FFFF91F7FF91F7FF91F7FF91
              F7FF91F7FF91F7FF91F7FF91F7FF57BCEF99FFFF066C9E6D6D6D2D92C56FD4FF
              3499CC99FFFF99FFFF99FFFF99FFFF99FFFF99FFFF99FFFF99FFFF99FFFF60C5
              F899FFFF086EA06E6E6E2F94C77BE0FF2D92C5FFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFF81E6FFFFFFFF0B71A38C8C8C3196C985EBFF
              81E6FF2D92C52D92C52D92C52D92C52D92C52D92C5288DC02489BC2085B81C81
              B41B81B31B81B3DFDFDF3398CB91F7FF8EF4FF8EF4FF8EF4FF8EF4FF8EF4FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFF167CAE8C8C8CDEDEDEFFFFFF3499CCFFFFFF
              99FFFF99FFFF99FFFF99FFFFFFFFFF258ABD2287BA1F84B71D82B51B81B3187E
              B0DFDFDFF7F7F7FFFFFFFFFFFF3499CCFFFFFFFFFFFFFFFFFFFFFFFF2A8FC2C8
              C8C8F6F6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              3499CC3398CB3196C92F94C7DFDFDFF6F6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
            TabOrder = 1
            OnClick = BitBtnlresarcClick
          end
        end
      end
      object Panel95: TPanel
        Left = 0
        Top = 156
        Width = 174
        Height = 338
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 2
        object GroupBox31: TGroupBox
          Left = 5
          Top = 5
          Width = 164
          Height = 328
          Align = alClient
          Caption = 'Sub folder name'
          TabOrder = 0
          object CheckListBoxAFoldername: TCheckListBox
            Left = 2
            Top = 17
            Width = 160
            Height = 309
            Align = alClient
            ItemHeight = 15
            Items.Strings = (
              'Location'
              'Pub. date'
              'Publication'
              'Edtion'
              'Section')
            TabOrder = 0
          end
        end
      end
      object Panel96: TPanel
        Left = 174
        Top = 156
        Width = 259
        Height = 338
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 3
        object Label58: TLabel
          Left = 5
          Top = 111
          Width = 249
          Height = 15
          Align = alTop
          Caption = 'Date format'
          ExplicitWidth = 63
        end
        object GroupBox32: TGroupBox
          Left = 5
          Top = 5
          Width = 249
          Height = 53
          Align = alTop
          Caption = 'Highres filename'
          TabOrder = 0
          object Edithighresarch: TEdit
            Left = 2
            Top = 17
            Width = 245
            Height = 23
            Align = alTop
            TabOrder = 0
            Text = '%F'
          end
        end
        object GroupBox34: TGroupBox
          Left = 5
          Top = 58
          Width = 249
          Height = 53
          Align = alTop
          Caption = 'Lowres filename'
          TabOrder = 1
          object Editlowarch: TEdit
            Left = 2
            Top = 17
            Width = 245
            Height = 23
            Align = alTop
            TabOrder = 0
            Text = '%P-%D-%E-%S-%N'
          end
        end
        object Editarchdate: TEdit
          Left = 5
          Top = 126
          Width = 249
          Height = 23
          Align = alTop
          TabOrder = 2
          Text = 'DDMMYY'
        end
      end
      object Panel97: TPanel
        Left = 433
        Top = 156
        Width = 296
        Height = 338
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 4
        object GroupBox46: TGroupBox
          Left = 5
          Top = 5
          Width = 286
          Height = 201
          Align = alTop
          Caption = 'File naming'
          TabOrder = 0
          object Memo1: TMemo
            Left = 2
            Top = 17
            Width = 282
            Height = 182
            Align = alClient
            BevelInner = bvNone
            BorderStyle = bsNone
            Color = clBtnFace
            Enabled = False
            Lines.Strings = (
              '%F Org. filename (only highres files)'
              '%P Publication'
              '%D Date'
              '%E Edition'
              '%N Pagename'
              '%S Section'
              '%C Color (only highres files)')
            TabOrder = 0
          end
        end
      end
    end
    object TabSheet9: TTabSheet
      Caption = 'Custom planning'
      ImageIndex = 18
      object Panel98: TPanel
        Left = 0
        Top = 0
        Width = 281
        Height = 494
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 0
        object GroupBox104: TGroupBox
          Left = 5
          Top = 5
          Width = 271
          Height = 131
          Align = alTop
          Caption = 'Custom planning'
          TabOrder = 0
          object Label107: TLabel
            Left = 2
            Top = 69
            Width = 267
            Height = 15
            Align = alTop
            Caption = 'Custom check system name'
            ExplicitWidth = 149
          end
          object CheckBoxcustforcetoaplied: TCheckBox
            Left = 2
            Top = 17
            Width = 267
            Height = 28
            Align = alTop
            Caption = 'Force new plan to applied'
            TabOrder = 0
          end
          object CheckBoxcustomplancheck: TCheckBox
            Left = 2
            Top = 45
            Width = 267
            Height = 24
            Align = alTop
            Caption = 'Show custom plan check'
            TabOrder = 1
          end
          object EditCustomchecksystemname: TEdit
            Left = 2
            Top = 84
            Width = 267
            Height = 23
            Align = alTop
            TabOrder = 2
          end
        end
      end
      object Panel99: TPanel
        Left = 281
        Top = 0
        Width = 448
        Height = 494
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 1
      end
    end
    object TabSheet18: TTabSheet
      Caption = 'Special'
      ImageIndex = 19
      object Panel100: TPanel
        Left = 0
        Top = 0
        Width = 238
        Height = 494
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 0
        object Label20: TLabel
          Left = 12
          Top = 12
          Width = 142
          Height = 13
          AutoSize = False
          Caption = 'Deadlock delay milliseconds'
        end
        object Editdeadlockdealay: TEdit
          Left = 150
          Top = 12
          Width = 53
          Height = 23
          TabOrder = 0
          Text = '30000'
        end
        object UpDown4: TUpDown
          Left = 203
          Top = 12
          Width = 17
          Height = 23
          Associate = Editdeadlockdealay
          Max = 32000
          Position = 30000
          TabOrder = 1
          Thousands = False
        end
        object GroupBox13: TGroupBox
          Left = 5
          Top = 39
          Width = 228
          Height = 49
          Caption = 'Approval options'
          TabOrder = 2
          object CheckBoxremovemissingcolorsonaprove: TCheckBox
            Left = 2
            Top = 17
            Width = 224
            Height = 31
            Align = alTop
            Caption = 'Automatic remove missing colors on approval'
            TabOrder = 0
            WordWrap = True
          end
        end
        object GroupBox14: TGroupBox
          Left = 5
          Top = 88
          Width = 228
          Height = 141
          Caption = 'Relase on approval'
          TabOrder = 3
          object Panel3: TPanel
            Left = 2
            Top = 17
            Width = 224
            Height = 34
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            object CheckBoxreleaseonapproval: TCheckBox
              Left = 0
              Top = 0
              Width = 224
              Height = 17
              Align = alTop
              Caption = 'Release on approval'
              TabOrder = 0
            end
            object CheckBoxCustomrel: TCheckBox
              Left = 0
              Top = 17
              Width = 224
              Height = 17
              Align = alTop
              Caption = 'Use custom script'
              TabOrder = 1
            end
          end
          object GroupBox15: TGroupBox
            Left = 2
            Top = 68
            Width = 224
            Height = 53
            Align = alTop
            Caption = 'Custum release script'
            TabOrder = 1
            object MemoCustomrel: TMemo
              Left = 2
              Top = 17
              Width = 220
              Height = 34
              Align = alClient
              TabOrder = 0
            end
          end
          object CheckBoxThsingleedrelease: TCheckBox
            Left = 2
            Top = 51
            Width = 224
            Height = 17
            Align = alTop
            Caption = 'Release single edition if selected'
            TabOrder = 2
          end
        end
        object CheckBoxCommenttime: TCheckBox
          Left = 5
          Top = 229
          Width = 228
          Height = 17
          Caption = 'Apply time to comment'
          TabOrder = 4
        end
        object GroupBox67: TGroupBox
          Left = 5
          Top = 246
          Width = 228
          Height = 109
          Caption = 'External datafiles'
          TabOrder = 5
          object Label84: TLabel
            Left = 2
            Top = 17
            Width = 224
            Height = 15
            Align = alTop
            Caption = 'Planned pagename data'
            ExplicitWidth = 128
          end
          object Editplannedpagenamedata: TEdit
            Left = 2
            Top = 32
            Width = 224
            Height = 23
            Align = alTop
            TabOrder = 0
          end
        end
        object CheckBoxnewtreeload: TCheckBox
          Left = 5
          Top = 355
          Width = 228
          Height = 17
          Caption = 'New Tree update'
          Enabled = False
          TabOrder = 7
          Visible = False
        end
        object CheckBoxFastTree: TCheckBox
          Left = 5
          Top = 372
          Width = 228
          Height = 17
          Caption = 'Synchronized tree update'
          TabOrder = 6
        end
      end
      object Panel101: TPanel
        Left = 238
        Top = 0
        Width = 299
        Height = 494
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 1
        object Label42: TLabel
          Left = 5
          Top = 144
          Width = 289
          Height = 15
          Align = alTop
          Caption = 'Load for day of week'
          ExplicitWidth = 110
        end
        object GroupBox12: TGroupBox
          Left = 5
          Top = 5
          Width = 289
          Height = 74
          Align = alTop
          Caption = 'Graphic report data'
          TabOrder = 0
          object Label14: TLabel
            Left = 12
            Top = 41
            Width = 72
            Height = 17
            AutoSize = False
            Caption = 'Time format'
          end
          object CheckBoxshowallgraphtime: TCheckBox
            Left = 12
            Top = 18
            Width = 167
            Height = 17
            Caption = 'Show all times'
            TabOrder = 0
          end
          object ComboBoxgraphtimeformat: TComboBox
            Left = 90
            Top = 38
            Width = 103
            Height = 23
            TabOrder = 1
            Text = 'hh:nn'
            Items.Strings = (
              'hh'
              'hh:nn'
              'dd.mm.yyyy hh:nn')
          end
        end
        object GroupBox22: TGroupBox
          Left = 5
          Top = 79
          Width = 289
          Height = 65
          Align = alTop
          Caption = 'Default device'
          TabOrder = 1
          object CheckBoxusedefaultdevice: TCheckBox
            Left = 10
            Top = 18
            Width = 226
            Height = 17
            Caption = 'Use default device'
            TabOrder = 0
          end
          object Editdefaultdevice: TEdit
            Left = 10
            Top = 38
            Width = 228
            Height = 23
            TabOrder = 1
          end
        end
        object ComboBoxdayofweek: TComboBox
          Left = 5
          Top = 159
          Width = 289
          Height = 23
          Align = alTop
          Style = csDropDownList
          ItemIndex = 6
          TabOrder = 2
          Text = 'Sunday'
          Items.Strings = (
            'Monday'
            'Tuesday'
            'Wednesday'
            'Thursday'
            'Friday'
            'Saturday'
            'Sunday')
        end
        object CheckBoxSPPressrunexec: TCheckBox
          Left = 5
          Top = 232
          Width = 289
          Height = 25
          Align = alTop
          Caption = 'Use spImportCenterPressRunCustom on Create'
          TabOrder = 3
          WordWrap = True
        end
        object CheckBoxpresssectionCalcX: TCheckBox
          Left = 5
          Top = 207
          Width = 289
          Height = 25
          Align = alTop
          Caption = 'Calc. presssection by running numbers'
          TabOrder = 4
        end
        object CheckBoxAutorefreshon: TCheckBox
          Left = 5
          Top = 182
          Width = 289
          Height = 25
          Align = alTop
          Caption = 'Autorefresh on'
          TabOrder = 5
        end
        object CheckBoxPlanrepair: TCheckBox
          Left = 5
          Top = 382
          Width = 289
          Height = 25
          Align = alTop
          Caption = 'Auto Plan check'
          TabOrder = 6
        end
        object CheckBoxprodshoworder: TCheckBox
          Left = 5
          Top = 357
          Width = 289
          Height = 25
          Align = alTop
          Caption = 'Show order in productionview'
          TabOrder = 7
        end
        object CheckBoxprodshowRipsetup: TCheckBox
          Left = 5
          Top = 407
          Width = 289
          Height = 25
          Align = alTop
          Caption = 'Show RIP setup in productionview'
          TabOrder = 8
        end
        object CheckBoxOverruleretransmit: TCheckBox
          Left = 5
          Top = 432
          Width = 289
          Height = 25
          Align = alTop
          Caption = 'No Re-transmission allowed'
          TabOrder = 9
        end
        object CheckBoxpaginarecalc: TCheckBox
          Left = 5
          Top = 457
          Width = 289
          Height = 25
          Align = alTop
          Caption = 'Allow pagina recalculation'
          TabOrder = 10
        end
        object CheckBoxSPPressrunexec2: TCheckBox
          Left = 5
          Top = 257
          Width = 289
          Height = 25
          Align = alTop
          Caption = 'Use spImportCenterPressRunCustom2 on Create'
          TabOrder = 11
          WordWrap = True
        end
        object CheckBoxSPProductionexec: TCheckBox
          Left = 5
          Top = 282
          Width = 289
          Height = 25
          Align = alTop
          Caption = 'Use spImportCenterProductionCustom on Create'
          TabOrder = 13
          WordWrap = True
        end
        object CheckBoxApplyDoPostPressRunProcedure: TCheckBox
          Left = 5
          Top = 307
          Width = 289
          Height = 25
          Align = alTop
          Caption = 'Use spImportCenterPressRunCustom on Apply'
          TabOrder = 12
          WordWrap = True
        end
        object CheckBoxApplyDoPostProductionProcedure: TCheckBox
          Left = 5
          Top = 332
          Width = 289
          Height = 25
          Align = alTop
          Caption = 'Use spImportCenterProductionCustom on Apply'
          TabOrder = 14
          WordWrap = True
        end
      end
      object Panel102: TPanel
        Left = 527
        Top = 0
        Width = 210
        Height = 498
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 2
        object GroupBox102: TGroupBox
          Left = 8
          Top = 4
          Width = 209
          Height = 116
          Caption = 'Enable edit of MiscString/MiscInt'
          TabOrder = 0
          object CheckListBoxMiscedit: TCheckListBox
            Left = 16
            Top = 19
            Width = 177
            Height = 71
            ItemHeight = 15
            Items.Strings = (
              'MiscString2'
              'MiscString3'
              'MiscInt2'
              'MiscInt3')
            TabOrder = 0
          end
        end
        object GroupBox1: TGroupBox
          Left = 8
          Top = 126
          Width = 209
          Height = 72
          Caption = 'DongA'
          TabOrder = 1
          object CheckBoxDongA: TCheckBox
            Left = 18
            Top = 20
            Width = 179
            Height = 17
            Caption = 'Enable Ink Ansan'
            TabOrder = 0
          end
          object CheckBoxswapplatemerger: TCheckBox
            Left = 18
            Top = 37
            Width = 179
            Height = 17
            Caption = 'Ansan merger'
            TabOrder = 1
          end
        end
        object GroupBox87: TGroupBox
          Left = 8
          Top = 204
          Width = 209
          Height = 157
          Caption = 'Default Hottime priority'
          TabOrder = 2
          object Label94: TLabel
            Left = 161
            Top = 26
            Width = 32
            Height = 15
            Caption = 'Hours'
          end
          object Label95: TLabel
            Left = 12
            Top = 77
            Width = 34
            Height = 15
            Caption = 'Before'
          end
          object Label96: TLabel
            Left = 12
            Top = 101
            Width = 36
            Height = 15
            Caption = 'During'
          end
          object Label97: TLabel
            Left = 12
            Top = 125
            Width = 26
            Height = 15
            Caption = 'After'
          end
          object Label98: TLabel
            Left = 68
            Top = 49
            Width = 37
            Height = 15
            Caption = 'Length'
          end
          object Label99: TLabel
            Left = 160
            Top = 45
            Width = 32
            Height = 15
            Caption = 'Hours'
          end
          object CheckBoxhttimedeadline: TCheckBox
            Left = 14
            Top = 22
            Width = 96
            Height = 17
            Caption = 'Equal deadline '#177
            TabOrder = 0
          end
          object Edithottimehours: TEdit
            Left = 116
            Top = 18
            Width = 25
            Height = 23
            TabOrder = 1
            Text = '0'
          end
          object UpDownhothours: TUpDown
            Left = 141
            Top = 18
            Width = 17
            Height = 23
            Associate = Edithottimehours
            Min = -1000
            Max = 1000
            TabOrder = 2
          end
          object Edithotbefore: TEdit
            Left = 60
            Top = 73
            Width = 25
            Height = 23
            TabOrder = 3
            Text = '50'
          end
          object UpDownhotbefore: TUpDown
            Left = 85
            Top = 73
            Width = 16
            Height = 23
            Associate = Edithotbefore
            Position = 50
            TabOrder = 4
          end
          object Edithotunder: TEdit
            Left = 60
            Top = 97
            Width = 25
            Height = 23
            TabOrder = 5
            Text = '50'
          end
          object UpDownhotunder: TUpDown
            Left = 85
            Top = 97
            Width = 16
            Height = 23
            Associate = Edithotunder
            Position = 50
            TabOrder = 6
          end
          object Edithotafter: TEdit
            Left = 60
            Top = 121
            Width = 25
            Height = 23
            TabOrder = 7
            Text = '50'
          end
          object UpDownhotafter: TUpDown
            Left = 85
            Top = 121
            Width = 16
            Height = 23
            Associate = Edithotafter
            Position = 50
            TabOrder = 8
          end
          object Editlength: TEdit
            Left = 116
            Top = 45
            Width = 25
            Height = 23
            TabOrder = 9
            Text = '1'
          end
          object UpDownhotlength: TUpDown
            Left = 141
            Top = 45
            Width = 16
            Height = 23
            Associate = Editlength
            Min = 1
            Max = 1000
            Position = 1
            TabOrder = 10
          end
        end
      end
    end
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 60
    Width = 748
    Height = 579
    ActivePage = TabSheet3
    MultiLine = True
    TabOrder = 0
    StyleElements = []
    object TabSheet4: TTabSheet
      Caption = 'General settings'
      ImageIndex = 3
      object Label71: TLabel
        Left = 264
        Top = 440
        Width = 40
        Height = 15
        Caption = 'Label71'
      end
      object Panel5: TPanel
        Left = 0
        Top = 0
        Width = 212
        Height = 549
        Align = alLeft
        AutoSize = True
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 0
        object GroupBox124: TGroupBox
          Left = 8
          Top = 5
          Width = 198
          Height = 48
          Caption = 'Language'
          TabOrder = 0
          object ComboBoxlanguage: TComboBox
            Left = 11
            Top = 17
            Width = 174
            Height = 23
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 0
            Text = 'Default'
            Items.Strings = (
              'Default')
          end
        end
        object RadioGroupstartupsize: TRadioGroup
          Left = 8
          Top = 53
          Width = 198
          Height = 103
          Caption = 'Startup size'
          ItemIndex = 0
          Items.Strings = (
            'Nomal'
            'Maximized'
            'Upper half'
            'Lower half')
          TabOrder = 1
        end
        object GroupBox116: TGroupBox
          Left = 7
          Top = 158
          Width = 199
          Height = 55
          Caption = 'Start-up tab'
          TabOrder = 2
          object ComboBoxStartupTab: TComboBox
            Left = 10
            Top = 19
            Width = 175
            Height = 23
            Style = csDropDownList
            TabOrder = 0
            Items.Strings = (
              'Separations'
              'Thumbnails'
              'Plates'
              'Production'
              'Editions'
              'Planning')
          end
        end
        object GroupBox132: TGroupBox
          Left = 5
          Top = 219
          Width = 202
          Height = 114
          Caption = 'Pages not fitting plans'
          TabOrder = 3
          object Label9: TLabel
            Left = 9
            Top = 47
            Width = 137
            Height = 15
            Caption = 'Update interval (minutes):'
          end
          object Label73: TLabel
            Left = 9
            Top = 72
            Width = 106
            Height = 15
            Caption = 'Panel width (pixels):'
          end
          object CheckBoxShowPanelUnknown: TCheckBox
            Left = 8
            Top = 22
            Width = 191
            Height = 18
            Caption = 'Show '#39'pages-outside-plan'#39' panel'
            TabOrder = 0
          end
          object EditCheckTimeUnknown: TEdit
            Left = 147
            Top = 44
            Width = 30
            Height = 23
            NumbersOnly = True
            TabOrder = 1
            Text = '1'
          end
          object EditUnknownFilesPanelWidth: TEdit
            Left = 147
            Top = 69
            Width = 30
            Height = 23
            NumbersOnly = True
            TabOrder = 2
            Text = '125'
          end
        end
      end
      object Panel6: TPanel
        Left = 212
        Top = 0
        Width = 262
        Height = 549
        Align = alLeft
        AutoSize = True
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 1
        object GroupBox57: TGroupBox
          Left = 5
          Top = 5
          Width = 252
          Height = 223
          Align = alTop
          Caption = 'Users'
          TabOrder = 0
          DesignSize = (
            252
            223)
          object Username: TLabel
            Left = 11
            Top = 60
            Width = 53
            Height = 15
            Caption = 'Username'
          end
          object Label116: TLabel
            Left = 9
            Top = 87
            Width = 50
            Height = 15
            Caption = 'Password'
          end
          object CheckBoxautologin: TCheckBox
            Left = 8
            Top = 15
            Width = 213
            Height = 17
            Caption = 'Auto login (if only one user)'
            TabOrder = 0
          end
          object CheckBoxNologin: TCheckBox
            Left = 8
            Top = 36
            Width = 103
            Height = 17
            Caption = 'No login dialog'
            TabOrder = 1
          end
          object CheckBoxsuperall: TCheckBox
            Left = 8
            Top = 110
            Width = 213
            Height = 17
            Caption = 'Super user may see all'
            Checked = True
            State = cbChecked
            TabOrder = 2
          end
          object CheckBoxadmintab: TCheckBox
            Left = 8
            Top = 131
            Width = 175
            Height = 17
            Caption = 'Admin overrules tab settings'
            Checked = True
            State = cbChecked
            TabOrder = 3
          end
          object EditAutoLoginUser: TEdit
            Left = 93
            Top = 56
            Width = 98
            Height = 23
            Anchors = []
            TabOrder = 4
          end
          object EditAutoLoginPassword: TEdit
            Left = 92
            Top = 83
            Width = 98
            Height = 23
            PasswordChar = '*'
            TabOrder = 5
          end
          object CheckBoxUseAdministrativeGroups: TCheckBox
            Left = 8
            Top = 152
            Width = 175
            Height = 17
            Caption = 'Use Administrative groups'
            TabOrder = 6
          end
          object CheckBoxUseADGroups: TCheckBox
            Left = 8
            Top = 193
            Width = 233
            Height = 17
            Caption = 'Use AD groups = Administrative groups'
            TabOrder = 7
          end
          object CheckBoxUseWindowsUser: TCheckBox
            Left = 8
            Top = 172
            Width = 206
            Height = 17
            Caption = 'Use current Windows user'
            TabOrder = 8
          end
        end
        object GroupBox125: TGroupBox
          Left = 5
          Top = 229
          Width = 249
          Height = 148
          Caption = 'Colors and look'
          TabOrder = 1
          object Label122: TLabel
            Left = 13
            Top = 73
            Width = 79
            Height = 15
            Caption = 'Seleted toolbar'
          end
          object Label8: TLabel
            Left = 13
            Top = 45
            Width = 106
            Height = 15
            Caption = 'Toolbar background'
          end
          object Label35: TLabel
            Left = 13
            Top = 19
            Width = 98
            Height = 15
            Caption = 'Menu background'
          end
          object ColorBoxToolBarSel: TColorBox
            Left = 125
            Top = 70
            Width = 95
            Height = 22
            Style = [cbStandardColors, cbSystemColors, cbIncludeNone, cbPrettyNames]
            TabOrder = 0
          end
          object ColorBoxToolbar: TColorBox
            Left = 125
            Top = 42
            Width = 95
            Height = 22
            Style = [cbStandardColors, cbSystemColors, cbIncludeNone, cbPrettyNames]
            TabOrder = 1
          end
          object ColorBoxMenuToolBar: TColorBox
            Left = 125
            Top = 14
            Width = 95
            Height = 22
            Style = [cbStandardColors, cbSystemColors, cbIncludeNone, cbPrettyNames]
            TabOrder = 2
          end
          object CheckBoxFlatlook: TCheckBox
            Left = 15
            Top = 103
            Width = 206
            Height = 17
            Caption = 'Flat look thumbnails and plates'
            TabOrder = 3
          end
        end
      end
      object Panel9: TPanel
        Left = 474
        Top = 0
        Width = 263
        Height = 549
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 2
        object GroupBoxLocationPressFilterMode: TGroupBox
          Left = 6
          Top = 5
          Width = 217
          Height = 264
          Caption = 'Location/press filter'
          TabOrder = 0
          object Label57: TLabel
            Left = 16
            Top = 144
            Width = 173
            Height = 13
            AutoSize = False
            Caption = 'Default location'
          end
          object Label54: TLabel
            Left = 17
            Top = 196
            Width = 173
            Height = 13
            AutoSize = False
            Caption = 'Default press (group)'
          end
          object RadioGroupLocationPressFilterMode: TRadioGroup
            Left = 11
            Top = 18
            Width = 160
            Height = 94
            Caption = 'Filter type'
            Ctl3D = True
            Items.Strings = (
              'None'
              'Press'
              'Press group'
              'Location')
            ParentCtl3D = False
            TabOrder = 0
          end
          object CheckBoxAllowLocationPressAllSelection: TCheckBox
            Left = 16
            Top = 118
            Width = 153
            Height = 17
            Caption = 'Allow '#39'all'#39' selection'
            Checked = True
            State = cbChecked
            TabOrder = 1
          end
          object CheckBoxAllowOnlyDefaultLocationPress: TCheckBox
            Left = 32
            Top = 235
            Width = 152
            Height = 22
            Caption = 'Allow only default location'
            Checked = True
            Enabled = False
            State = cbChecked
            TabOrder = 2
            Visible = False
          end
          object ComboBoxlocations: TComboBox
            Left = 16
            Top = 161
            Width = 139
            Height = 23
            TabOrder = 3
            Text = 'ComboBoxlocations'
          end
          object ComboBoxDefaultPress: TComboBox
            Left = 16
            Top = 214
            Width = 139
            Height = 23
            TabOrder = 4
            Text = 'ComboBoxlocations'
          end
        end
        object GroupBox113: TGroupBox
          Left = 6
          Top = 275
          Width = 219
          Height = 190
          Caption = 'Visible presses'
          TabOrder = 1
          object CheckListBoxvisiblepressesConfig: TCheckListBox
            Left = 14
            Top = 23
            Width = 193
            Height = 150
            ItemHeight = 15
            TabOrder = 0
          end
        end
      end
    end
    object TabSheetmonoshit: TTabSheet
      Caption = 'Application paths'
      ImageIndex = 1
      TabVisible = False
      object CheckBox1: TCheckBox
        Left = 8
        Top = 376
        Width = 269
        Height = 17
        Caption = 'Use editorial management'
        TabOrder = 0
      end
    end
    object TabSheet7: TTabSheet
      Caption = 'Separations'
      ImageIndex = 2
      object Panel11: TPanel
        Left = 0
        Top = 0
        Width = 237
        Height = 549
        Align = alLeft
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 0
        object GroupBox122: TGroupBox
          Left = 0
          Top = 0
          Width = 237
          Height = 96
          Align = alTop
          Caption = 'General'
          TabOrder = 0
          object CheckBoxlistredevatreim: TCheckBox
            Left = 8
            Top = 15
            Width = 223
            Height = 17
            Caption = 'Auto reset device when re-imaging'
            TabOrder = 0
          end
          object Checkboxreleaseonseprationset: TCheckBox
            Left = 8
            Top = 34
            Width = 190
            Height = 17
            Caption = 'Always release all colors'
            Checked = True
            State = cbChecked
            TabOrder = 1
          end
          object CheckBoxshowreimgediaglog: TCheckBox
            Left = 8
            Top = 53
            Width = 190
            Height = 17
            Caption = 'Show re-image dialog'
            Checked = True
            State = cbChecked
            TabOrder = 2
          end
          object CheckBoxautoreimondevch: TCheckBox
            Left = 8
            Top = 72
            Width = 223
            Height = 17
            Caption = 'Auto re-image on device change'
            TabOrder = 3
          end
        end
        object GroupBox123: TGroupBox
          Left = 0
          Top = 96
          Width = 237
          Height = 46
          Align = alTop
          Caption = 'Min. page tree level'
          TabOrder = 1
          object UpDown7: TUpDown
            Left = 50
            Top = 15
            Width = 17
            Height = 23
            Associate = Editminpagetreelevel
            Min = 1
            Max = 5
            Position = 2
            TabOrder = 0
          end
          object Editminpagetreelevel: TEdit
            Left = 8
            Top = 15
            Width = 42
            Height = 23
            TabOrder = 1
            Text = '2'
          end
        end
        object GroupBox128: TGroupBox
          Left = 0
          Top = 142
          Width = 237
          Height = 47
          Align = alTop
          Caption = 'Visible coloumns'
          TabOrder = 2
          object Editvisiblecols: TEdit
            Left = 8
            Top = 14
            Width = 42
            Height = 23
            TabOrder = 0
            Text = '16'
            Visible = False
          end
          object UpDownVisiblecols: TUpDown
            Left = 50
            Top = 14
            Width = 17
            Height = 23
            Associate = Editvisiblecols
            Max = 25
            Position = 16
            TabOrder = 1
            Visible = False
          end
        end
        object GroupBox129: TGroupBox
          Left = 0
          Top = 189
          Width = 237
          Height = 46
          Align = alTop
          Caption = 'Number of coloumns in grid'
          TabOrder = 3
          object EditNcols: TEdit
            Left = 8
            Top = 15
            Width = 47
            Height = 23
            TabOrder = 0
            Text = '30'
          end
          object UpDown12: TUpDown
            Left = 55
            Top = 15
            Width = 17
            Height = 23
            Associate = EditNcols
            Min = 10
            Max = 45
            Position = 30
            TabOrder = 1
          end
        end
        object GroupBox130: TGroupBox
          Left = 0
          Top = 235
          Width = 237
          Height = 47
          Align = alTop
          Caption = 'Auto scroll speed'
          TabOrder = 4
          object EditAutoscroolspeed: TEdit
            Left = 7
            Top = 15
            Width = 43
            Height = 23
            TabOrder = 0
            Text = '5'
            Visible = False
          end
          object UpDownAutoscroolspeed: TUpDown
            Left = 50
            Top = 15
            Width = 20
            Height = 23
            Associate = EditAutoscroolspeed
            Min = 1
            Max = 20
            Position = 5
            TabOrder = 1
            Visible = False
          end
        end
        object GroupBox35: TGroupBox
          Left = 0
          Top = 282
          Width = 237
          Height = 87
          Align = alTop
          Caption = 'Time settings'
          TabOrder = 5
          object Label51: TLabel
            Left = 9
            Top = 37
            Width = 176
            Height = 13
            AutoSize = False
            Caption = 'Alternative format'
          end
          object CheckBoxlocaltimeset: TCheckBox
            Left = 8
            Top = 15
            Width = 190
            Height = 17
            Caption = 'Use local settings'
            Checked = True
            State = cbChecked
            TabOrder = 0
          end
          object Editlistime: TEdit
            Left = 7
            Top = 55
            Width = 103
            Height = 23
            TabOrder = 1
            Text = 'DDMMYYYY-HHNN'
            OnKeyPress = EditlistimeKeyPress
          end
        end
      end
      object Panel12: TPanel
        Left = 237
        Top = 0
        Width = 503
        Height = 549
        Align = alClient
        ParentBackground = False
        TabOrder = 1
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Thumbnails'
      ImageIndex = 2
      object GroupBox6: TGroupBox
        Left = 584
        Top = 191
        Width = 73
        Height = 129
        Caption = 'Thumbnails'
        TabOrder = 0
        Visible = False
        object Label3: TLabel
          Left = 96
          Top = 216
          Width = 32
          Height = 15
          HelpContext = 90
          Caption = 'Width'
        end
        object Label7: TLabel
          Left = 180
          Top = 216
          Width = 36
          Height = 15
          HelpContext = 90
          Caption = 'Height'
        end
        object ScrollBox1: TScrollBox
          Left = 8
          Top = 24
          Width = 361
          Height = 185
          HelpContext = 90
          BevelInner = bvNone
          BevelOuter = bvNone
          TabOrder = 0
          object Panel2: TPanel
            Left = 8
            Top = 8
            Width = 120
            Height = 120
            BevelInner = bvRaised
            BevelOuter = bvLowered
            Caption = 'Thumbnail size'
            TabOrder = 0
          end
        end
        object Edit1: TEdit
          Left = 96
          Top = 232
          Width = 57
          Height = 23
          HelpContext = 90
          TabOrder = 1
          Text = '120'
        end
        object UpDown1: TUpDown
          Left = 153
          Top = 232
          Width = 16
          Height = 23
          HelpContext = 90
          Associate = Edit1
          Min = 100
          Max = 1000
          Position = 120
          TabOrder = 2
        end
        object Edit2: TEdit
          Tag = 120
          Left = 180
          Top = 232
          Width = 57
          Height = 23
          HelpContext = 90
          TabOrder = 3
          Text = '120'
        end
        object UpDown2: TUpDown
          Left = 237
          Top = 232
          Width = 16
          Height = 23
          HelpContext = 90
          Associate = Edit2
          Min = 100
          Max = 1000
          Position = 120
          TabOrder = 4
        end
      end
      object Panel13: TPanel
        Left = 0
        Top = 0
        Width = 311
        Height = 549
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 1
        object RadioGroupthumbnailsize: TRadioGroup
          Left = 5
          Top = 5
          Width = 301
          Height = 42
          Align = alTop
          Caption = 'Thumbnail size'
          Columns = 3
          ItemIndex = 2
          Items.Strings = (
            'Small'
            'Medium'
            'Big')
          TabOrder = 0
        end
        object Panel14: TPanel
          Left = 5
          Top = 47
          Width = 301
          Height = 193
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object GroupBox92: TGroupBox
            Left = 0
            Top = 0
            Width = 165
            Height = 193
            Align = alLeft
            Caption = 'Thumbnail caption'
            TabOrder = 0
            object CheckListBoxthumbtext: TCheckListBox
              Left = 2
              Top = 17
              Width = 161
              Height = 174
              Align = alClient
              DragMode = dmAutomatic
              ItemHeight = 15
              Items.Strings = (
                'Pagename'
                'Edition'
                'Section'
                'Location'
                'version'
                'Publication'
                'PageIndex'
                'Plannedname'
                'Comment'
                'Press'
                'Pagina'
                '#'
                'Master edition'
                'Page format'
                'Short planpagename')
              PopupMenu = PopupMenuthumbcapnewline
              TabOrder = 0
              OnDragDrop = CheckListBoxthumbtextDragDrop
              OnDragOver = CheckListBoxthumbtextDragOver
              OnStartDrag = CheckListBoxthumbtextStartDrag
            end
          end
          object GroupBox93: TGroupBox
            Left = 165
            Top = 0
            Width = 136
            Height = 193
            Align = alClient
            Caption = 'Thumbnail sorting'
            TabOrder = 1
            object ListBoxthumborder: TListBox
              Left = 2
              Top = 17
              Width = 132
              Height = 174
              Align = alClient
              DragMode = dmAutomatic
              ItemHeight = 15
              Items.Strings = (
                'publication'
                'edition'
                'section'
                'pageindex'
                'location'
                'PresssectionNumber'
                'Press'
                'Pagination'
                'PageName')
              TabOrder = 0
              OnDragDrop = ListBoxthumborderDragDrop
              OnDragOver = ListBoxthumborderDragOver
              OnStartDrag = ListBoxthumborderStartDrag
            end
          end
        end
        object Panel15: TPanel
          Left = 5
          Top = 337
          Width = 301
          Height = 182
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 2
          object GroupBox90: TGroupBox
            Left = -1
            Top = 4
            Width = 153
            Height = 93
            Caption = 'Thumbnail groups'
            TabOrder = 0
            object CheckListBoxthgroupecap: TCheckListBox
              Left = 3
              Top = 19
              Width = 147
              Height = 60
              DragMode = dmAutomatic
              ItemHeight = 15
              Items.Strings = (
                'Location'
                'Edition'
                'Section')
              TabOrder = 0
              OnDragDrop = CheckListBoxthumbtextDragDrop
              OnDragOver = CheckListBoxthumbtextDragOver
              OnStartDrag = CheckListBoxthumbtextStartDrag
            end
          end
          object GroupBox95: TGroupBox
            Left = 155
            Top = 4
            Width = 145
            Height = 90
            Caption = 'Status bar'
            TabOrder = 1
            object CheckListBoxthumbstatbar: TCheckListBox
              Left = 3
              Top = 17
              Width = 134
              Height = 60
              ItemHeight = 15
              Items.Strings = (
                'Proof'
                'Pageformat'
                'Page arrival'
                'Page approval')
              TabOrder = 0
            end
          end
        end
        object GroupBox66: TGroupBox
          Left = 5
          Top = 240
          Width = 301
          Height = 97
          Align = alTop
          Caption = 'Show prepoll events (max 4)'
          TabOrder = 3
          object CheckListBoxThumbevents: TCheckListBox
            Left = 2
            Top = 17
            Width = 147
            Height = 78
            Align = alLeft
            ItemHeight = 15
            Items.Strings = (
              'FTP'
              'Preflight'
              'Rip'
              'Color level'
              'Ink save')
            TabOrder = 0
            OnClickCheck = CheckListBoxThumbeventsClickCheck
          end
          object MemoShortevent: TMemo
            Left = 149
            Top = 17
            Width = 150
            Height = 78
            Align = alClient
            Lines.Strings = (
              'FTP'
              'PRE'
              'RIP'
              'COL'
              'INK')
            TabOrder = 1
            WordWrap = False
            OnExit = MemoShorteventExit
          end
        end
      end
      object Panel16: TPanel
        Left = 311
        Top = 0
        Width = 401
        Height = 549
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 2
        object Label48: TLabel
          Left = 6
          Top = 19
          Width = 108
          Height = 25
          AutoSize = False
          Caption = 'Min. page tree level'
        end
        object CheckBoxthumbshowhold: TCheckBox
          Left = 5
          Top = 60
          Width = 237
          Height = 17
          Caption = 'Show hold / release'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object CheckBoxthumbpagechangesonsubeditions: TCheckBox
          Left = 5
          Top = 253
          Width = 237
          Height = 17
          Caption = 'Page changes apply to all sub-editions'
          TabOrder = 1
        end
        object CheckBoxthumbshowextstat: TCheckBox
          Left = 5
          Top = 79
          Width = 237
          Height = 17
          Caption = 'Show external status'
          TabOrder = 2
        end
        object CheckBoxCheckJpgTag: TCheckBox
          Left = 5
          Top = 273
          Width = 237
          Height = 18
          Caption = 'Check Jpeg Tag'
          TabOrder = 3
        end
        object CheckBoxthumbshowmono: TCheckBox
          Left = 5
          Top = 98
          Width = 237
          Height = 17
          Caption = 'Show mono PDF indicator'
          TabOrder = 4
        end
        object CheckBoxpagedelete: TCheckBox
          Left = 5
          Top = 137
          Width = 237
          Height = 17
          Caption = 'Allow page delete'
          TabOrder = 5
        end
        object CheckBoxforcereadorder: TCheckBox
          Left = 5
          Top = 118
          Width = 237
          Height = 17
          Caption = 'Default show readorder'
          TabOrder = 6
        end
        object CheckBoxAllowfalsespret: TCheckBox
          Left = 5
          Top = 156
          Width = 237
          Height = 17
          Caption = 'Allow setting false spreads'
          TabOrder = 7
        end
        object CheckBoxsetcommentonfalsespreads: TCheckBox
          Left = 5
          Top = 195
          Width = 270
          Height = 19
          Caption = 'Set Comment SPREAD on false spread pages'
          TabOrder = 8
          WordWrap = True
        end
        object CheckBoxstatresetonpagetypechange: TCheckBox
          Left = 5
          Top = 214
          Width = 237
          Height = 17
          Caption = 'Set missing on pagetype change'
          TabOrder = 9
        end
        object UpDown8: TUpDown
          Left = 155
          Top = 16
          Width = 16
          Height = 23
          Associate = Editminthumblevel
          Min = 2
          Max = 4
          Position = 2
          TabOrder = 10
        end
        object Editminthumblevel: TEdit
          Left = 114
          Top = 16
          Width = 41
          Height = 23
          TabOrder = 11
          Text = '2'
        end
        object CheckBoxreselectthumb: TCheckBox
          Left = 5
          Top = 234
          Width = 213
          Height = 17
          Caption = 'Re-select pages after action'
          TabOrder = 12
        end
        object CheckBoxAllowPdfRotation: TCheckBox
          Left = 5
          Top = 176
          Width = 237
          Height = 17
          Caption = 'Allow PDF rotation (re-processing)'
          TabOrder = 13
        end
        object CheckBoxThumbnailsShowAlsoForcedPages: TCheckBox
          Left = 5
          Top = 293
          Width = 380
          Height = 18
          Caption = 'Show also forced pages when selecting '#39'Show only unique pages'#39
          TabOrder = 14
        end
      end
      object Panel18: TPanel
        Left = 712
        Top = 0
        Width = 28
        Height = 549
        Align = alClient
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 3
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'Plates'
      ImageIndex = 5
      object Panel19: TPanel
        Left = 0
        Top = 0
        Width = 740
        Height = 549
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 0
        object GroupBox100: TGroupBox
          Left = 7
          Top = 4
          Width = 290
          Height = 95
          Caption = 'Plate tree'
          TabOrder = 0
          object CheckBoxpresstimeinplatetree: TCheckBox
            Left = 13
            Top = 16
            Width = 183
            Height = 17
            Caption = 'Presstime in platetree'
            TabOrder = 0
          end
          object RadioGroupplatetreeexp: TRadioGroup
            Left = 13
            Top = 39
            Width = 263
            Height = 43
            Caption = 'Tree item expansion'
            Columns = 2
            ItemIndex = 0
            Items.Strings = (
              'All'
              'Selected')
            TabOrder = 1
          end
        end
        object GroupBox80: TGroupBox
          Left = 5
          Top = 101
          Width = 292
          Height = 56
          Caption = 'Filter settings'
          TabOrder = 1
          object Label53: TLabel
            Left = 16
            Top = 23
            Width = 103
            Height = 15
            Caption = 'Min. plate tree level'
          end
          object EditPlateminlevel: TEdit
            Left = 117
            Top = 20
            Width = 39
            Height = 23
            TabOrder = 0
            Text = '2'
          end
          object UpDown11: TUpDown
            Left = 156
            Top = 20
            Width = 17
            Height = 23
            Associate = EditPlateminlevel
            Min = 2
            Max = 4
            Position = 2
            TabOrder = 1
          end
        end
        object GroupBox82: TGroupBox
          Left = 7
          Top = 163
          Width = 292
          Height = 206
          Caption = 'Defaults'
          TabOrder = 2
          object CheckBoxreimdevicereset: TCheckBox
            Left = 14
            Top = 24
            Width = 201
            Height = 17
            Caption = 'Default reset device on re-image'
            TabOrder = 0
          end
          object CheckBoxplatedetailof: TCheckBox
            Left = 14
            Top = 66
            Width = 201
            Height = 20
            Caption = 'Hide detail on/off button'
            TabOrder = 1
          end
          object CheckBoxdefaultshowplatedetails: TCheckBox
            Left = 14
            Top = 88
            Width = 201
            Height = 17
            Caption = 'Details window on'
            TabOrder = 2
          end
          object CheckBoxreimcolors: TCheckBox
            Left = 14
            Top = 150
            Width = 201
            Height = 17
            Caption = 'Select all colors on re-image'
            TabOrder = 3
          end
          object CheckBox2nounplanned: TCheckBox
            Left = 14
            Top = 172
            Width = 249
            Height = 17
            Caption = 'Default show no unplanned products'
            TabOrder = 4
          end
          object CheckBoxreimcopies: TCheckBox
            Left = 14
            Top = 109
            Width = 201
            Height = 17
            Caption = 'Select all copies on re-image'
            TabOrder = 5
          end
          object CheckBoxSelectAllCopiesOnRelease: TCheckBox
            Left = 14
            Top = 129
            Width = 201
            Height = 17
            Caption = 'Select all copies on release'
            TabOrder = 6
          end
          object CheckBoxSetReleaseNowOnReimage: TCheckBox
            Left = 14
            Top = 41
            Width = 249
            Height = 27
            Caption = 'Default select '#39'release now'#39' on re-image'
            TabOrder = 7
          end
        end
        object GroupBox26: TGroupBox
          Left = 7
          Top = 375
          Width = 292
          Height = 107
          Caption = 'Other settings'
          TabOrder = 3
          object CheckBoxForcesamedev: TCheckBox
            Left = 13
            Top = 27
            Width = 277
            Height = 17
            Caption = 'Always force all plate copies to the same device'
            TabOrder = 0
          end
          object CheckBoxreselectplates: TCheckBox
            Left = 12
            Top = 50
            Width = 205
            Height = 17
            Caption = 'Re-select plates after action'
            TabOrder = 1
          end
          object CheckBoxplatedeluxe: TCheckBox
            Left = 12
            Top = 73
            Width = 205
            Height = 17
            Caption = #39'Plate deluxe'#39' (internal setting)'
            TabOrder = 2
          end
        end
      end
    end
    object TabSheet19: TTabSheet
      Caption = 'Production'
      ImageIndex = 21
      object Image4: TImage
        Left = 352
        Top = 492
        Width = 81
        Height = 33
        Visible = False
      end
      object Panel22: TPanel
        Left = 0
        Top = 56
        Width = 740
        Height = 153
        Align = alTop
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 0
        object GroupBox74: TGroupBox
          Left = 5
          Top = 5
          Width = 730
          Height = 141
          Align = alTop
          Caption = 'Production grid fonts'
          TabOrder = 0
          object StringGridprods: TStringGrid
            Left = 2
            Top = 17
            Width = 726
            Height = 122
            Align = alClient
            ColCount = 28
            DefaultRowHeight = 16
            FixedCols = 0
            RowCount = 2
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing]
            TabOrder = 0
            OnDblClick = StringGridprodsDblClick
            OnDrawCell = StringGridprodsDrawCell
            OnSelectCell = StringGridprodsSelectCell
            ColWidths = (
              64
              64
              64
              64
              64
              64
              64
              64
              64
              64
              64
              64
              64
              64
              64
              64
              64
              64
              64
              64
              64
              64
              64
              64
              64
              64
              64
              64)
            RowHeights = (
              16
              16)
          end
        end
      end
      object Panel23: TPanel
        Left = 0
        Top = 0
        Width = 740
        Height = 56
        Align = alTop
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 1
        object GroupBox118: TGroupBox
          Left = 5
          Top = 5
          Width = 730
          Height = 41
          Align = alTop
          Caption = 'Min. production tree level'
          TabOrder = 0
          object Editminprodtreelevel: TEdit
            Left = 2
            Top = 17
            Width = 45
            Height = 22
            Align = alLeft
            TabOrder = 0
            Text = '1'
          end
          object UpDown15: TUpDown
            Left = 47
            Top = 17
            Width = 17
            Height = 22
            Associate = Editminprodtreelevel
            Max = 5
            Position = 1
            TabOrder = 1
          end
        end
      end
      object Panel24: TPanel
        Left = 0
        Top = 209
        Width = 241
        Height = 340
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 2
        object GroupBox120: TGroupBox
          Left = 5
          Top = 5
          Width = 231
          Height = 330
          Align = alClient
          Caption = 'Show columns'
          TabOrder = 0
          object CheckListBox1: TCheckListBox
            Left = 2
            Top = 17
            Width = 227
            Height = 311
            Align = alClient
            Columns = 1
            ItemHeight = 15
            Items.Strings = (
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              '')
            TabOrder = 0
            OnClick = CheckListBox1Click
            OnClickCheck = CheckListBox1ClickCheck
          end
        end
      end
      object Panel25: TPanel
        Left = 477
        Top = 209
        Width = 263
        Height = 340
        Align = alRight
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 3
        object GroupBox119: TGroupBox
          Left = 5
          Top = 5
          Width = 253
          Height = 330
          Align = alClient
          TabOrder = 0
          object CheckBoxpublfilreonproddate: TCheckBox
            Left = 10
            Top = 8
            Width = 249
            Height = 16
            Caption = 'Show press time filter list'
            TabOrder = 0
          end
          object CheckBoxprodreleaseholdallcopy: TCheckBox
            Left = 10
            Top = 56
            Width = 249
            Height = 17
            Caption = 'Release and hold all copies'
            TabOrder = 1
          end
          object CheckBoxSellallcopiesprod: TCheckBox
            Left = 10
            Top = 31
            Width = 249
            Height = 17
            Caption = 'Select all copies as default'
            TabOrder = 2
          end
          object CheckBoxShowPressTime: TCheckBox
            Left = 10
            Top = 75
            Width = 249
            Height = 27
            Caption = 'Show presstime (instead of priority)'
            TabOrder = 3
          end
        end
      end
      object Panel26: TPanel
        Left = 241
        Top = 209
        Width = 236
        Height = 340
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 4
        object GroupBox121: TGroupBox
          Left = 5
          Top = 5
          Width = 226
          Height = 92
          Align = alTop
          Caption = 'Edit selected column'
          TabOrder = 0
          object Label91: TLabel
            Left = 2
            Top = 17
            Width = 222
            Height = 15
            Align = alTop
            Caption = 'Name:'
            ExplicitWidth = 35
          end
          object Label121: TLabel
            Left = 2
            Top = 55
            Width = 222
            Height = 15
            Align = alTop
            Caption = 'Width:'
            ExplicitWidth = 35
          end
          object Edit6: TEdit
            Left = 2
            Top = 32
            Width = 222
            Height = 23
            Align = alTop
            TabOrder = 0
            OnChange = Edit6Change
            OnEnter = Edit6Enter
          end
          object Edit7: TEdit
            Left = 2
            Top = 70
            Width = 222
            Height = 23
            Align = alTop
            TabOrder = 1
            Text = '0'
            OnChange = Edit7Change
            OnEnter = Edit6Enter
          end
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Planning'
      ImageIndex = 4
      object Panel29: TPanel
        Left = 645
        Top = 0
        Width = 95
        Height = 549
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 1
      end
      object Panel27: TPanel
        Left = 0
        Top = 0
        Width = 339
        Height = 549
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 0
        object GroupBox28: TGroupBox
          Left = 5
          Top = 5
          Width = 329
          Height = 217
          Align = alTop
          Caption = 'Run defaults'
          TabOrder = 0
          object CheckBoxusepublicationdefaults: TCheckBox
            Left = 8
            Top = 15
            Width = 288
            Height = 17
            Caption = 'Use publication defaults (recommended)'
            Checked = True
            State = cbChecked
            TabOrder = 0
          end
          object CheckBoxerrorfileretry: TCheckBox
            Left = 8
            Top = 33
            Width = 288
            Height = 17
            Caption = 'Automatic errorfile retry'
            TabOrder = 1
          end
          object CheckBoxplanhold: TCheckBox
            Left = 8
            Top = 51
            Width = 303
            Height = 17
            Caption = 'Default to Hold plates (overrules publication default)'
            Checked = True
            State = cbChecked
            TabOrder = 2
          end
          object CheckBoxplanapproval: TCheckBox
            Left = 8
            Top = 70
            Width = 303
            Height = 17
            Caption = 'Default to Approval required (overrules publ. default)'
            Checked = True
            State = cbChecked
            TabOrder = 3
          end
          object CheckBoxCheckPlanningPageFormat: TCheckBox
            Left = 8
            Top = 87
            Width = 279
            Height = 24
            Caption = 'Warn if no valid Page Format set'
            TabOrder = 4
          end
          object CheckBoxSimplePlanLoad: TCheckBox
            Left = 8
            Top = 110
            Width = 308
            Height = 18
            Caption = 'Show simple plan loading dialog'
            Checked = True
            State = cbChecked
            TabOrder = 5
          end
          object CheckBoxCheckPlanningRipSetup: TCheckBox
            Left = 8
            Top = 132
            Width = 268
            Height = 15
            Caption = 'Warn if no Rip Setup parameters set'
            TabOrder = 6
          end
          object CheckBoxPlanLoadPromptForSectionEdition: TCheckBox
            Left = 8
            Top = 151
            Width = 268
            Height = 20
            Caption = 'Prompt for sections/editions in plan load'
            Checked = True
            State = cbChecked
            TabOrder = 7
          end
          object CheckBoxOnlyShowDefaultPressPublications: TCheckBox
            Left = 7
            Top = 172
            Width = 307
            Height = 19
            Caption = 'Default to only show publications default for sel. press'
            Checked = True
            State = cbChecked
            TabOrder = 8
          end
          object CheckBoxGeneratePlanPageNames: TCheckBox
            Left = 7
            Top = 193
            Width = 307
            Height = 16
            Caption = 'Generate PlanPageNames'
            TabOrder = 9
          end
        end
        object GroupBox10: TGroupBox
          Left = 5
          Top = 222
          Width = 329
          Height = 111
          Align = alTop
          Caption = 'Automatic proof selection (if no publication defaults used)'
          TabOrder = 1
          object Label17: TLabel
            Left = 5
            Top = 22
            Width = 132
            Height = 15
            Caption = 'Default color proof setup'
          end
          object Label18: TLabel
            Left = 5
            Top = 51
            Width = 137
            Height = 15
            Caption = 'Default Mono proof setup'
          end
          object Label19: TLabel
            Left = 5
            Top = 80
            Width = 126
            Height = 15
            Caption = 'Default PDF proof setup'
          end
          object ComboBoxcolorproof: TComboBox
            Left = 146
            Top = 19
            Width = 159
            Height = 23
            TabOrder = 0
          end
          object ComboBoxBWproof: TComboBox
            Left = 146
            Top = 49
            Width = 159
            Height = 23
            TabOrder = 1
          end
          object ComboBoxpdfproof: TComboBox
            Left = 146
            Top = 78
            Width = 160
            Height = 23
            TabOrder = 2
          end
        end
        object GroupBox111: TGroupBox
          Left = 5
          Top = 333
          Width = 329
          Height = 130
          Align = alTop
          Caption = 'Default hard/flatproof settings'
          TabOrder = 2
          object Label56: TLabel
            Left = 5
            Top = 24
            Width = 113
            Height = 15
            Caption = 'Default flatproof type'
          end
          object Label61: TLabel
            Left = 5
            Top = 77
            Width = 123
            Height = 15
            Caption = 'Default page hardproof'
          end
          object ComboBoxdefSoftprtype: TComboBox
            Left = 145
            Top = 21
            Width = 160
            Height = 23
            Style = csDropDownList
            TabOrder = 0
            Items.Strings = (
              'Manual'
              'Automatic'
              'No flatproof')
          end
          object ComboBoxdefHardprtype: TComboBox
            Left = 145
            Top = 74
            Width = 160
            Height = 23
            Style = csDropDownList
            ItemIndex = 2
            TabOrder = 1
            Text = 'No flatproof'
            Items.Strings = (
              'Manual'
              'Automatic'
              'No flatproof')
          end
          object CheckBoxdefsoftvait: TCheckBox
            Left = 5
            Top = 49
            Width = 234
            Height = 17
            Caption = 'Wait for approval before doing flatproof'
            Checked = True
            State = cbChecked
            TabOrder = 2
          end
          object CheckBoxhardvait: TCheckBox
            Left = 5
            Top = 102
            Width = 228
            Height = 17
            Caption = 'Wait for approval before doing hardproof'
            Checked = True
            State = cbChecked
            TabOrder = 3
          end
        end
      end
      object Panel28: TPanel
        Left = 339
        Top = 0
        Width = 306
        Height = 549
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 2
        object GroupBox27: TGroupBox
          Left = 5
          Top = 5
          Width = 296
          Height = 131
          Align = alTop
          Caption = 'Defaults when working on unplanned pages'
          TabOrder = 0
          object GroupBox29: TGroupBox
            Left = 2
            Top = 17
            Width = 292
            Height = 77
            Align = alTop
            Caption = 'Planning method'
            TabOrder = 0
            object Bevel2: TBevel
              Left = 2
              Top = 42
              Width = 288
              Height = 25
              Align = alTop
              ExplicitLeft = 12
              ExplicitTop = 52
              ExplicitWidth = 221
            end
            object Bevel3: TBevel
              Left = 2
              Top = 17
              Width = 288
              Height = 25
              Align = alTop
              ExplicitLeft = 12
              ExplicitTop = 16
              ExplicitWidth = 221
            end
            object Image2: TImage
              Left = 16
              Top = 46
              Width = 16
              Height = 16
              AutoSize = True
              Picture.Data = {
                07544269746D617036030000424D360300000000000036000000280000001000
                0000100000000100180000000000000300000000000000000000000000000000
                0000868686252525FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC3C3C38A8A8A292929FFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFAFAFAF7C7C7C343434F9F9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFCC8C8C87D7D7D3535
                35F7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFC1C1C18383832E2E2EFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEEEEEED4D4
                D4878787AFAFAFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F9F9EFEFEFEFEFEFC3C3C3F1EFEFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFF4F4F4E0E0E0D5D3D3F2F2F2FAFFFFF2FDFBECF7F5F9FFFEFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDBEAECFFFAFF
                ECFEFF01FFF1FFF7FFFFFAFFC4FFFAF1FFFCFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFAFF0AF7DC00CAB800F4DF18BDB600FFEAD7F9F9FF
                F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFFFFE5F7FF00D6C4
                D8F9FFCAF4FFDDFCFF47B8BAEFEBF7FFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFF6FFFF04FFF400FFECC6F0FFEAF8FFAEE7FC00FFF40AFFF8B0
                F0F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6FFFFFFF7FF05AAA3
                DDFCFFC6FFFFA5FFFF00ACA0FFF8FFFFFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFAFFFFFFFAFF01FFEE47B6B800F7E500B4A815FFFFFFF1FFEC
                FBFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFFEF5E1FFFF
                FFFBFF03FFF1FFF8FFFFF2FFE6FCFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFF3FFFEFFF2F9FFF9FFB9F9FAFFFBFFEAF9FBECFFFCFF
                FFFF}
              Transparent = True
            end
            object Image3: TImage
              Left = 16
              Top = 20
              Width = 16
              Height = 16
              AutoSize = True
              Picture.Data = {
                07544269746D617036030000424D360300000000000036000000280000001000
                0000100000000100180000000000000300000000000000000000000000000000
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F6E1C
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFF816100FF9F2A8F6F1DFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFA8A8A8737373553F2A553F2A3D3D3D3D3D3DB4B4B4806100FF9F2AD9A77D
                FF9F2A8F6F1C7373737474743D3D3DA8A8A8919191A9FFFF99F8FF99F8FF55DF
                FF55BFD3806100D9A77DD9A77DD9A77DD9A77DFF9F2A8F6F1D55DFFF55C0D491
                9191919191A9FFFFA9FFFFA9FFFFA9FFFF806100D9A77DFFFFC3FFFFC3D9A77D
                D9A77DD9A77DFF9F2A8F6F1D55DFFF919191919191A9FFFFA9FFFFA9FFFFE1BE
                788F6F1C8F6F1C8F6E1CFFFFC3FFFFC4D9A77D8F6F1D8F6F1C8F6F1CE1BE7891
                9191909090A9FFFFA9FFFFA9FFFFA9FFFFA9FFFFA9FFFF9D7C30FFFFC3FFFFC3
                FFF1AB9D7C30B4B4B499F8FF55DFFF909090919191D8E9ECA9FFFFA9FFFFA9FF
                FFA9FFFFA9FFFFAB8A40FFFFC3FFFFC3D9A77DFBD79198F7FF55DFFFAADFD591
                9191919191A9FFFFA9FFFFA9FFFFA9FFFFA9FFFFB9974FD9A77DFFF0AAFFFFC3
                AB8A4099F7FF99F7FF99F8FF55DFFF919191A8A8A8D8E9ECA9FFFFD8E9ECA9FF
                FFA8FEFFB9974EFFE49EFFF0AAE1BE77FBD790A9FFFFA9FFFFA9FFFFA9FFFFA8
                A8A8B4B4B4A9FFFFD8E9ECA9FFFFA8FEFFAB893FD9A77DFBD790E1BE78A9FFFF
                A9FFFFA9FFFFA9FFFFA9FFFFA9FFFFB4B4B4C1C1C1D8E9ECA9FFFFD8E9ECD4B1
                6AD4B26BD4B26BD4B26BEECB84C6C6C6C6C6C6AADFD555BFD354BFD355BFD3C1
                C1C1CCCCCCB5B5B5B4B4B4B4B4B4CBCBCBAADFD5AADFD555DFFF55DFFF55DFFF
                55DFFF55DFFF55DFFF55DFFF54BFD3CCCCCCFFFFFFDADADA00F2FF00F2FF00F1
                FF00F1FF55BFD3E6E6E68D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8DFF
                FFFFFFFFFF9B9B9B54FFFF67F4FF67F4FF67F4FF00F1FFB4B4B4FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9B9B9B8D8D8D8D8D
                8D8D8D8D9B9B9BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF}
              Transparent = True
            end
            object RadioButtonwizard: TRadioButton
              Left = 45
              Top = 43
              Width = 177
              Height = 17
              Caption = 'Use the plan wizard'
              TabOrder = 0
            end
            object RadioButtonload: TRadioButton
              Left = 44
              Top = 20
              Width = 185
              Height = 17
              Caption = 'Load a plan'
              Checked = True
              TabOrder = 1
              TabStop = True
            end
          end
          object CheckBoxonlyaplyonunapplied: TCheckBox
            Left = 2
            Top = 111
            Width = 292
            Height = 17
            Align = alTop
            Caption = 'Only apply on unapplied plans'
            Checked = True
            State = cbChecked
            TabOrder = 1
          end
          object CheckBoxMultiPressTemplateLoad: TCheckBox
            Left = 2
            Top = 94
            Width = 292
            Height = 17
            Align = alTop
            Caption = 'Use multi-presstemplate load'
            TabOrder = 2
          end
        end
        object GroupBox112: TGroupBox
          Left = 5
          Top = 136
          Width = 296
          Height = 150
          Align = alTop
          Caption = 'ImportCenter integration'
          TabOrder = 1
          object Label113: TLabel
            Left = 2
            Top = 34
            Width = 292
            Height = 15
            Align = alTop
            Caption = 'ImportcCenter input path'
            ExplicitWidth = 135
          end
          object Label114: TLabel
            Left = 2
            Top = 72
            Width = 292
            Height = 15
            Align = alTop
            Caption = 'ImportCenter done path'
            ExplicitWidth = 128
          end
          object Label115: TLabel
            Left = 2
            Top = 110
            Width = 292
            Height = 15
            Align = alTop
            Caption = 'ImportCenter error path'
            ExplicitWidth = 126
          end
          object CheckBoxuseimportcenter: TCheckBox
            Left = 2
            Top = 17
            Width = 292
            Height = 17
            Align = alTop
            Caption = 'Use ImportCenter XML import'
            TabOrder = 0
          end
          object Editimportcenterinputpath: TEdit
            Left = 2
            Top = 49
            Width = 292
            Height = 23
            Align = alTop
            TabOrder = 1
          end
          object Editimportcenterdonepath: TEdit
            Left = 2
            Top = 87
            Width = 292
            Height = 23
            Align = alTop
            TabOrder = 2
          end
          object Editimportcentererrorpath: TEdit
            Left = 2
            Top = 125
            Width = 292
            Height = 23
            Align = alTop
            TabOrder = 3
          end
        end
        object CheckBoxplaninkaliasload: TCheckBox
          Left = 5
          Top = 303
          Width = 296
          Height = 17
          Align = alTop
          Caption = 'Inkalias on load'
          TabOrder = 2
        end
        object GroupBox115: TGroupBox
          Left = 5
          Top = 320
          Width = 296
          Height = 146
          Align = alTop
          Caption = 'HalfWeb'
          TabOrder = 3
          object RadioGroupHalfWeb: TRadioGroup
            Left = 2
            Top = 17
            Width = 292
            Height = 77
            Align = alTop
            Caption = 'Set halfweb position:'
            Items.Strings = (
              'Last plate'
              'last page - 1'
              'At specific number')
            TabOrder = 0
            OnClick = RadioGroupHalfWebClick
          end
          object Panel108: TPanel
            Left = 2
            Top = 94
            Width = 292
            Height = 41
            Align = alTop
            AutoSize = True
            BevelOuter = bvNone
            TabOrder = 1
            object Label118: TLabel
              Left = 0
              Top = 0
              Width = 292
              Height = 15
              Align = alTop
              Caption = 'Set halfweb on pos.:   At min page'
              ExplicitWidth = 180
            end
            object Label119: TLabel
              Left = 215
              Top = 21
              Width = 47
              Height = 15
              Caption = '0 = none'
            end
            object Edit5: TEdit
              Left = 8
              Top = 18
              Width = 89
              Height = 23
              TabOrder = 0
              Text = 'Edit5'
            end
            object Edit3: TEdit
              Left = 111
              Top = 18
              Width = 90
              Height = 23
              TabOrder = 1
              Text = 'Edit3'
            end
          end
        end
        object RadioGroupPlanningPageNameIn: TRadioGroup
          Left = 5
          Top = 466
          Width = 296
          Height = 76
          Align = alTop
          Caption = 'Store plate name in:'
          Items.Strings = (
            'Plate (MiscString1)'
            'Ink (MiscString3)'
            'Both')
          TabOrder = 4
        end
        object CheckBoxXMLPlanAddTimestamp: TCheckBox
          Left = 5
          Top = 286
          Width = 296
          Height = 17
          Align = alTop
          Caption = 'Add timestamp to xml filename'
          TabOrder = 5
        end
      end
    end
    object TabSheet11: TTabSheet
      Caption = 'Preview'
      ImageIndex = 5
      object Panel30: TPanel
        Left = 0
        Top = 0
        Width = 258
        Height = 549
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 0
        object GroupBox96: TGroupBox
          Left = 5
          Top = 5
          Width = 248
          Height = 276
          Align = alTop
          Caption = 'General'
          TabOrder = 0
          object CheckBoxpregendns: TCheckBox
            Left = 7
            Top = 15
            Width = 223
            Height = 17
            Caption = 'Use prev. generated dns'
            TabOrder = 0
          end
          object CheckBoxpregenreadview: TCheckBox
            Left = 7
            Top = 53
            Width = 210
            Height = 17
            Caption = 'Use pre-generated readviews'
            Checked = True
            State = cbChecked
            TabOrder = 1
          end
          object CheckBoxPrevcomment: TCheckBox
            Left = 7
            Top = 72
            Width = 209
            Height = 17
            Caption = 'Comment as window caption'
            TabOrder = 2
          end
          object CheckBoxgtoneedapr: TCheckBox
            Left = 7
            Top = 91
            Width = 209
            Height = 16
            Caption = 'Go to need approve by default'
            TabOrder = 3
          end
          object CheckBoxautomasked: TCheckBox
            Left = 7
            Top = 110
            Width = 231
            Height = 17
            Caption = 'Show as masked if possible'
            TabOrder = 4
          end
          object CheckBoxShowsidebar: TCheckBox
            Left = 7
            Top = 129
            Width = 223
            Height = 17
            Caption = 'Show Color separation sidebar'
            TabOrder = 5
          end
          object CheckBoxUseadobereader: TCheckBox
            Left = 7
            Top = 149
            Width = 223
            Height = 17
            Caption = 'Load original PDF if possible'
            TabOrder = 6
          end
          object CheckBoxLeanAndMeanPreview: TCheckBox
            Left = 7
            Top = 31
            Width = 209
            Height = 23
            Caption = 'Lean and mean preview window'
            TabOrder = 7
          end
          object CheckBoxShowSizeInformation: TCheckBox
            Left = 7
            Top = 167
            Width = 209
            Height = 21
            Caption = 'Show Size information box'
            TabOrder = 8
          end
          object CheckBoxShowInkDensityInformation: TCheckBox
            Left = 7
            Top = 188
            Width = 209
            Height = 20
            Caption = 'Show ink coverage information box'
            TabOrder = 9
          end
          object CheckBoxEnsurePreviewFormInFront: TCheckBox
            Left = 7
            Top = 207
            Width = 223
            Height = 24
            Caption = 'Ensure preview form in front'
            TabOrder = 10
          end
          object CheckBoxShowPageNote: TCheckBox
            Left = 7
            Top = 231
            Width = 223
            Height = 20
            Caption = 'Show page note indicator'
            TabOrder = 11
          end
          object CheckBoxForceGrayBackground: TCheckBox
            Left = 7
            Top = 253
            Width = 223
            Height = 15
            Caption = 'Force gray backgroud around image'
            Checked = True
            State = cbChecked
            TabOrder = 12
          end
        end
      end
      object Panel31: TPanel
        Left = 258
        Top = 0
        Width = 202
        Height = 549
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 1
        object GroupBox97: TGroupBox
          Left = 5
          Top = 5
          Width = 192
          Height = 84
          Align = alTop
          Caption = 'Page view initialization'
          TabOrder = 0
          object CheckBoxpageprevseps: TCheckBox
            Left = 10
            Top = 17
            Width = 167
            Height = 17
            Margins.Left = 8
            Caption = 'Separations'
            TabOrder = 0
          end
          object CheckBoxpageprevLevel: TCheckBox
            Left = 10
            Top = 36
            Width = 159
            Height = 17
            Margins.Left = 8
            Caption = 'Density image'
            TabOrder = 1
          end
          object CheckBoxShowInkZones: TCheckBox
            Left = 10
            Top = 55
            Width = 167
            Height = 17
            Margins.Left = 8
            Caption = 'Ink zones (Console mode)'
            TabOrder = 2
          end
        end
        object GroupBoxPlateviewoptions: TGroupBox
          Left = 5
          Top = 89
          Width = 192
          Height = 85
          Align = alTop
          Caption = 'Plate preview initialization'
          TabOrder = 1
          object CheckBoxplateprevseps: TCheckBox
            Left = 10
            Top = 18
            Width = 167
            Height = 17
            Margins.Left = 8
            Caption = 'Separations'
            TabOrder = 0
          end
          object CheckBoxplateprevLevel: TCheckBox
            Left = 9
            Top = 39
            Width = 159
            Height = 17
            Margins.Left = 8
            Caption = 'Density image'
            TabOrder = 1
          end
          object CheckBoxplateprevZones: TCheckBox
            Left = 9
            Top = 59
            Width = 135
            Height = 17
            Margins.Left = 8
            Caption = 'Ink zones'
            TabOrder = 2
          end
        end
        object RadioGroup1: TRadioGroup
          Left = 5
          Top = 174
          Width = 192
          Height = 104
          Align = alTop
          Caption = 'Special rotate plates front'
          Items.Strings = (
            'No rotation'
            '90 degrees'
            '180 degrees'
            '270 degrees')
          TabOrder = 2
        end
      end
      object Panel32: TPanel
        Left = 460
        Top = 0
        Width = 280
        Height = 549
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 2
        object GroupBox11: TGroupBox
          Left = 5
          Top = 5
          Width = 270
          Height = 175
          Align = alTop
          Caption = 'Preview zoom'
          TabOrder = 0
          object Label28: TLabel
            Left = 12
            Top = 91
            Width = 71
            Height = 13
            AutoSize = False
            Caption = 'Zoomstep %'
          end
          object Label102: TLabel
            Left = 12
            Top = 118
            Width = 59
            Height = 15
            Caption = 'Zoom filter'
          end
          object Label13: TLabel
            Left = 12
            Top = 145
            Width = 64
            Height = 15
            Caption = 'Zoom levels'
          end
          object Label21: TLabel
            Left = 77
            Top = 145
            Width = 21
            Height = 15
            Caption = 'min'
          end
          object Label30: TLabel
            Left = 165
            Top = 147
            Width = 23
            Height = 15
            Caption = 'max'
          end
          object RadioButtonBestfit: TRadioButton
            Left = 12
            Top = 19
            Width = 92
            Height = 17
            Caption = 'Best fit'
            Checked = True
            TabOrder = 0
            TabStop = True
          end
          object RadioButton1to1: TRadioButton
            Left = 12
            Top = 40
            Width = 62
            Height = 17
            Caption = '1 : 1'
            TabOrder = 1
          end
          object UpDown6: TUpDown
            Left = 137
            Top = 60
            Width = 17
            Height = 21
            Min = 10
            Max = 200
            Increment = 10
            Position = 100
            TabOrder = 2
          end
          object EditInitzoom: TEdit
            Left = 98
            Top = 59
            Width = 41
            Height = 23
            TabOrder = 3
            Text = '100'
          end
          object RadioButtonzoomby: TRadioButton
            Left = 12
            Top = 58
            Width = 86
            Height = 23
            Caption = 'Zoomed by:'
            TabOrder = 4
          end
          object EditZoomstep: TEdit
            Left = 98
            Top = 88
            Width = 41
            Height = 23
            TabOrder = 5
            Text = '20'
          end
          object UpDown5: TUpDown
            Left = 139
            Top = 88
            Width = 16
            Height = 23
            Associate = EditZoomstep
            Min = 10
            Increment = 10
            Position = 20
            TabOrder = 6
          end
          object ComboBoxZoomfilter: TComboBox
            Left = 98
            Top = 115
            Width = 97
            Height = 23
            Style = csDropDownList
            ItemIndex = 5
            TabOrder = 7
            Text = 'Lanczos3'
            Items.Strings = (
              'None'
              'Triangle'
              'Hermite'
              'Bell'
              'BSpline'
              'Lanczos3'
              'Mitchell'
              'Nearest'
              'Linear'
              'FastLinear')
          end
          object EditMinzoom: TEdit
            Left = 98
            Top = 142
            Width = 41
            Height = 23
            TabOrder = 8
            Text = '20'
          end
          object UpDown3: TUpDown
            Left = 139
            Top = 142
            Width = 16
            Height = 23
            Associate = EditMinzoom
            Min = 10
            Increment = 10
            Position = 20
            TabOrder = 9
          end
          object UpDown9: TUpDown
            Left = 235
            Top = 142
            Width = 16
            Height = 21
            Min = 10
            Increment = 10
            Position = 20
            TabOrder = 10
          end
          object EditMaxzoom: TEdit
            Left = 195
            Top = 143
            Width = 41
            Height = 23
            TabOrder = 11
            Text = '1000'
          end
        end
      end
    end
    object TabSheet10: TTabSheet
      Caption = 'Files'
      ImageIndex = 9
      object Panel34: TPanel
        Left = 0
        Top = 0
        Width = 323
        Height = 549
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 0
        StyleElements = []
        object Label120: TLabel
          Left = 9
          Top = 428
          Width = 73
          Height = 15
          Caption = 'Source folder:'
        end
        object GroupBox50: TGroupBox
          Left = 5
          Top = 5
          Width = 313
          Height = 270
          Align = alTop
          Caption = 'Unknown files system'
          TabOrder = 0
          object Label36: TLabel
            Left = 13
            Top = 38
            Width = 108
            Height = 13
            AutoSize = False
            Caption = 'Check interval (min)'
          end
          object GroupBoxdefunknowfolder: TGroupBox
            Left = 3
            Top = 174
            Width = 302
            Height = 93
            Caption = 'Default unknownfiles folders'
            TabOrder = 0
            object CheckListBoxdefunknown: TCheckListBox
              Left = 10
              Top = 17
              Width = 279
              Height = 66
              ItemHeight = 15
              TabOrder = 0
              OnClick = CheckListBoxdefunknownClick
            end
          end
          object CheckBoxuknownsendlog: TCheckBox
            Left = 8
            Top = 62
            Width = 205
            Height = 17
            Caption = 'Send input time log information'
            TabOrder = 1
          end
          object CheckBoxunknowncheck: TCheckBox
            Left = 8
            Top = 15
            Width = 249
            Height = 17
            Caption = 'Automatic check unknown files folders'
            TabOrder = 2
          end
          object Editunknowndropdownfilter: TEdit
            Left = 122
            Top = 35
            Width = 36
            Height = 23
            TabOrder = 3
            Text = '5'
          end
          object GroupBox51: TGroupBox
            Left = 3
            Top = 84
            Width = 183
            Height = 86
            Caption = 'Standard file filters'
            TabOrder = 4
            object ListViewFilter: TListView
              Left = 16
              Top = 19
              Width = 156
              Height = 56
              Columns = <
                item
                  AutoSize = True
                  Caption = 'Filter'
                end>
              Items.ItemData = {
                05200000000100000000000000FFFFFFFFFFFFFFFF00000000FFFFFFFF000000
                00032A002E002A00}
              RowSelect = True
              PopupMenu = PopupMenufilters
              TabOrder = 0
              ViewStyle = vsReport
            end
          end
          object UpDowndropdownfilter: TUpDown
            Left = 158
            Top = 35
            Width = 17
            Height = 23
            Associate = Editunknowndropdownfilter
            Position = 5
            TabOrder = 5
          end
        end
        object CheckBoxignorenetuse: TCheckBox
          Left = 9
          Top = 281
          Width = 348
          Height = 17
          Caption = 'Ignore net logon (Net use)'
          TabOrder = 1
        end
        object CheckBoxnewdelsys: TCheckBox
          Left = 9
          Top = 321
          Width = 348
          Height = 17
          Caption = 'Use ProductDeleteService for purging'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
        object CheckBoxdelonlyselon: TCheckBox
          Left = 9
          Top = 341
          Width = 348
          Height = 17
          Caption = 'Delete only on selected press'
          Checked = True
          State = cbChecked
          TabOrder = 3
        end
        object CheckboxNewCCFilesNames: TCheckBox
          Left = 9
          Top = 360
          Width = 348
          Height = 19
          Caption = 'Use new CCFiles names (FileName####MasterSet.Color)'
          TabOrder = 4
        end
        object CheckBoxAllowDropFiles: TCheckBox
          Left = 9
          Top = 403
          Width = 348
          Height = 17
          Caption = 'Allow drag-and-drop of files into Thumbnails'
          TabOrder = 5
          OnClick = CheckBoxAllowDropFilesClick
        end
        object CheckBoxNewPreviewNames: TCheckBox
          Left = 9
          Top = 382
          Width = 348
          Height = 17
          Caption = 'Use new thumbnail/preview names (with GUID)'
          TabOrder = 6
        end
        object EditDropFilesDestination: TEdit
          Left = 83
          Top = 425
          Width = 256
          Height = 23
          TabOrder = 7
        end
        object CheckBoxAllowDropFilesDialog: TCheckBox
          Left = 9
          Top = 452
          Width = 348
          Height = 17
          Caption = 'Show confirmation dialog on drop files'
          TabOrder = 8
        end
        object CheckBoxAllowDropFilesDeleteAfterCopy: TCheckBox
          Left = 9
          Top = 473
          Width = 348
          Height = 17
          Caption = 'Delete source file after drop'
          TabOrder = 9
        end
        object CheckBoxOnlyConnectPlanCenterUser: TCheckBox
          Left = 9
          Top = 301
          Width = 348
          Height = 17
          Caption = 'Only connect PlanCenter user (if defined)'
          Checked = True
          State = cbChecked
          TabOrder = 10
        end
        object CheckboxRestrictUniqueDelete: TCheckBox
          Left = 9
          Top = 496
          Width = 182
          Height = 17
          Caption = 'Restrict Uniquepage  delete'
          Enabled = False
          TabOrder = 11
        end
      end
      object Panel37: TPanel
        Left = 323
        Top = 0
        Width = 408
        Height = 549
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 1
        object GroupBox9: TGroupBox
          Left = 6
          Top = 219
          Width = 396
          Height = 53
          Caption = 'Editors'
          TabOrder = 0
          object Label15: TLabel
            Left = 10
            Top = 20
            Width = 51
            Height = 15
            Caption = 'Tiff editor'
          end
          object Editexternedittif: TEdit
            Left = 63
            Top = 16
            Width = 322
            Height = 23
            TabOrder = 0
          end
        end
        object GroupBox54: TGroupBox
          Left = 6
          Top = 79
          Width = 396
          Height = 51
          Caption = 'Export csv settings'
          TabOrder = 1
          object Label60: TLabel
            Left = 165
            Top = 21
            Width = 65
            Height = 13
            AutoSize = False
            Caption = 'Separator'
          end
          object ComboBoxSepSEP: TComboBox
            Left = 234
            Top = 17
            Width = 47
            Height = 23
            TabOrder = 0
            Text = 'TAB'
            Items.Strings = (
              'TAB'
              ','
              '.'
              '/'
              '-')
          end
          object CheckBoxSEPHEader: TCheckBox
            Left = 10
            Top = 20
            Width = 147
            Height = 17
            Caption = 'Include column headers'
            TabOrder = 1
          end
        end
        object GroupBox47: TGroupBox
          Left = 6
          Top = 133
          Width = 397
          Height = 84
          Caption = 'Pitstop'
          TabOrder = 2
          object Label16: TLabel
            Left = 10
            Top = 44
            Width = 55
            Height = 15
            Caption = 'Pdf viewer'
          end
          object Label75: TLabel
            Left = 8
            Top = 63
            Width = 101
            Height = 15
            Caption = ' (blank use default)'
          end
          object CheckBoxShowpitstoplog: TCheckBox
            Left = 10
            Top = 19
            Width = 189
            Height = 17
            Caption = 'Pitstop logs available'
            TabOrder = 0
          end
          object EditexterneditPDF: TEdit
            Left = 67
            Top = 38
            Width = 317
            Height = 23
            TabOrder = 1
          end
        end
        object CheckBoxwebver: TCheckBox
          Left = 16
          Top = 278
          Width = 260
          Height = 17
          Caption = 'Webfiles with version'
          TabOrder = 3
        end
        object RadioGroupShowpdfbook: TRadioGroup
          Left = 6
          Top = 304
          Width = 213
          Height = 41
          Caption = 'Show pdf books'
          Columns = 3
          ItemIndex = 0
          Items.Strings = (
            'Never'
            'Ask'
            'Allways')
          TabOrder = 4
        end
        object GroupBox18: TGroupBox
          Left = 6
          Top = 351
          Width = 396
          Height = 168
          Caption = 'Unknown/Archive files'
          TabOrder = 5
          object Label117: TLabel
            Left = 14
            Top = 113
            Width = 189
            Height = 15
            Caption = 'Regular expression file exclude filter'
          end
          object Label76: TLabel
            Left = 14
            Top = 42
            Width = 33
            Height = 15
            Caption = 'Folder'
          end
          object Label77: TLabel
            Left = 14
            Top = 88
            Width = 33
            Height = 15
            Caption = 'Folder'
          end
          object EditExcludeArchiveFilter: TEdit
            Left = 14
            Top = 132
            Width = 369
            Height = 23
            TabOrder = 0
          end
          object Editarchivepath: TEdit
            Left = 72
            Top = 86
            Width = 313
            Height = 23
            TabOrder = 1
          end
          object CheckBoxArkenabled: TCheckBox
            Left = 14
            Top = 65
            Width = 193
            Height = 17
            Caption = 'Show archive'
            Checked = True
            State = cbChecked
            TabOrder = 2
          end
          object Editunknownpdf: TEdit
            Left = 69
            Top = 39
            Width = 316
            Height = 23
            TabOrder = 3
          end
          object CheckBoxPdfunknown: TCheckBox
            Left = 13
            Top = 16
            Width = 180
            Height = 17
            Caption = 'Show PDF unknown files'
            Checked = True
            State = cbChecked
            TabOrder = 4
          end
        end
        object GroupBox23: TGroupBox
          Left = 6
          Top = 4
          Width = 397
          Height = 74
          Caption = 'Thumbnail/preview cache'
          TabOrder = 6
          object Label78: TLabel
            Left = 10
            Top = 44
            Width = 64
            Height = 15
            Caption = 'Cache share'
          end
          object CheckBoxUsePreviewCache: TCheckBox
            Left = 10
            Top = 20
            Width = 335
            Height = 17
            Caption = 'Use cache folder for loading previews and thumbnails'
            TabOrder = 0
          end
          object EditPreviewCacheShare: TEdit
            Left = 76
            Top = 41
            Width = 307
            Height = 23
            TabOrder = 1
          end
        end
      end
      object Panel38: TPanel
        Left = 731
        Top = 0
        Width = 9
        Height = 549
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 5
        ParentBackground = False
        TabOrder = 2
      end
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.sql'
    Filter = 'Query file|*.sql|All files|*.*'
    Left = 760
    Top = 688
  end
  object PopupMenuStack: TPopupMenu
    Left = 536
    Top = 640
    object Add1: TMenuItem
      Caption = 'Add'
      OnClick = Add1Click
    end
    object Delete1: TMenuItem
      Caption = 'Delete'
      OnClick = Delete1Click
    end
  end
  object PopupMenuCyl: TPopupMenu
    Left = 596
    Top = 640
    object MenuItem1: TMenuItem
      Caption = 'Add'
    end
    object MenuItem2: TMenuItem
      Caption = 'Delete'
    end
  end
  object PopupMenuZone: TPopupMenu
    Left = 488
    Top = 636
    object MenuItem3: TMenuItem
      Caption = 'Add'
      OnClick = MenuItem3Click
    end
    object MenuItem4: TMenuItem
      Caption = 'Delete'
      OnClick = MenuItem4Click
    end
  end
  object PopupMenuTower: TPopupMenu
    Left = 652
    Top = 640
    object MenuItem5: TMenuItem
      Caption = 'Add'
      OnClick = MenuItem5Click
    end
    object MenuItem6: TMenuItem
      Caption = 'Delete'
      OnClick = MenuItem6Click
    end
  end
  object PopupMenufileserver: TPopupMenu
    Left = 196
    Top = 632
    object Add2: TMenuItem
      Caption = 'Add'
      OnClick = Add2Click
    end
  end
  object PopupMenudefmarks: TPopupMenu
    Left = 576
    Top = 604
    object Add3: TMenuItem
      Caption = 'Add'
      OnClick = Add3Click
    end
    object Delete2: TMenuItem
      Caption = 'Delete'
      OnClick = Delete2Click
    end
    object Loadall1: TMenuItem
      Caption = 'Load all'
      OnClick = Loadall1Click
    end
  end
  object PopupMenufilters: TPopupMenu
    Left = 248
    Top = 632
    object MenuItem7: TMenuItem
      Caption = 'Add'
      OnClick = MenuItem7Click
    end
    object MenuItem8: TMenuItem
      Caption = 'Delete'
      OnClick = MenuItem8Click
    end
  end
  object OpenDialogsoundX: TOpenDialog
    DefaultExt = '*.wav'
    Filter = 'Sound files|*.wav'
    Left = 152
    Top = 620
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = []
    Left = 88
    Top = 624
  end
  object PopupMenulocserv: TPopupMenu
    Left = 724
    Top = 612
    object Add4: TMenuItem
      Caption = 'Add'
    end
    object Edit4: TMenuItem
      Caption = 'Edit'
    end
    object Delete3: TMenuItem
      Caption = 'Delete'
    end
  end
  object PopupMenulogsys: TPopupMenu
    Left = 36
    Top = 632
    object Clearall1: TMenuItem
      Caption = 'Clear all'
      OnClick = Clearall1Click
    end
    object Setall1: TMenuItem
      Caption = 'Set all'
      OnClick = Setall1Click
    end
  end
  object PopupMenuthumbcapnewline: TPopupMenu
    Left = 520
    Top = 604
    object NewlineInthumb1: TMenuItem
      Caption = '# New line'
      OnClick = NewlineInthumb1Click
    end
    object Spacethumbcapline: TMenuItem
      Caption = 'Space'
      OnClick = SpacethumbcaplineClick
    end
  end
  object PopupMenutowfilt: TPopupMenu
    Left = 692
    Top = 638
    object Add5: TMenuItem
      Caption = 'Add'
      OnClick = Add5Click
    end
    object Delete4: TMenuItem
      Caption = 'Delete'
      OnClick = Delete4Click
    end
  end
  object FontDialogplateprint: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 446
    Top = 612
  end
end
