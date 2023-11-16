object Formdebugsql: TFormdebugsql
  Left = 726
  Top = 374
  Width = 621
  Height = 425
  Caption = 'Run A SQL'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 185
    Width = 605
    Height = 3
    Cursor = crVSplit
    Align = alTop
  end
  object Panel1: TPanel
    Left = 0
    Top = 346
    Width = 605
    Height = 41
    Align = alBottom
    TabOrder = 0
    object Label1: TLabel
      Left = 344
      Top = 14
      Width = 19
      Height = 13
      Caption = 'And'
    end
    object Label2: TLabel
      Left = 440
      Top = 14
      Width = 18
      Height = 13
      Caption = '  =  '
    end
    object BitBtn1: TBitBtn
      Left = 16
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Run'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 96
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkClose
    end
    object Button1: TButton
      Left = 200
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 2
      OnClick = Button1Click
    end
    object Edit1: TEdit
      Left = 288
      Top = 8
      Width = 49
      Height = 21
      TabOrder = 3
      Text = '256'
    end
    object Edit2: TEdit
      Left = 376
      Top = 8
      Width = 57
      Height = 21
      TabOrder = 4
      Text = '256'
    end
    object Edit3: TEdit
      Left = 456
      Top = 8
      Width = 49
      Height = 21
      TabOrder = 5
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 605
    Height = 185
    Align = alTop
    Caption = 'SQL'
    TabOrder = 1
    object Memo1: TMemo
      Left = 2
      Top = 15
      Width = 601
      Height = 168
      Align = alClient
      Lines.Strings = (
        'Select ripsetupid,pageindex,pagename,pubdate from pagetable'
        'order by pageindex')
      TabOrder = 0
    end
    object ListView2: TListView
      Left = 144
      Top = 32
      Width = 401
      Height = 121
      Columns = <
        item
        end
        item
        end
        item
        end>
      GridLines = True
      TabOrder = 1
      ViewStyle = vsReport
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 188
    Width = 605
    Height = 158
    Align = alClient
    Caption = 'Result'
    TabOrder = 2
    object ListView1: TListView
      Left = 2
      Top = 15
      Width = 601
      Height = 141
      Columns = <>
      GridLines = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
end
