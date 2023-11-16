object Formdebugtools: TFormdebugtools
  Left = 837
  Top = 271
  Width = 680
  Height = 408
  Caption = 'debug tools'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object RadioGroup1: TRadioGroup
    Left = 12
    Top = 72
    Width = 153
    Height = 117
    Caption = 'time to set'
    ItemIndex = 0
    Items.Strings = (
      'Input'
      'Approval'
      'Output'
      'Imaging error')
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 180
    Top = 332
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 268
    Top = 332
    Width = 75
    Height = 25
    TabOrder = 2
    Kind = bkCancel
  end
  object DateTimePicker1: TDateTimePicker
    Left = 12
    Top = 32
    Width = 186
    Height = 21
    Date = 38862.555120000000000000
    Time = 38862.555120000000000000
    TabOrder = 3
  end
  object DateTimePicker2: TDateTimePicker
    Left = 208
    Top = 32
    Width = 186
    Height = 21
    Date = 38862.555169259260000000
    Time = 38862.555169259260000000
    Kind = dtkTime
    TabOrder = 4
  end
  object RadioGroup2: TRadioGroup
    Left = 208
    Top = 68
    Width = 181
    Height = 93
    Caption = 'Spread'
    ItemIndex = 0
    Items.Strings = (
      'seconds'
      'minutes'
      'hours')
    TabOrder = 5
  end
  object Edit1: TEdit
    Left = 180
    Top = 192
    Width = 121
    Height = 21
    TabOrder = 6
    Text = '10'
  end
  object CheckBoxMisc: TCheckBox
    Left = 12
    Top = 196
    Width = 125
    Height = 17
    Caption = 'Set miscdata'
    TabOrder = 7
  end
  object CheckBoxtrans: TCheckBox
    Left = 12
    Top = 216
    Width = 129
    Height = 17
    Caption = 'Input=transmitted'
    TabOrder = 8
  end
  object RadioGroup3: TRadioGroup
    Left = 464
    Top = 8
    Width = 185
    Height = 305
    Caption = 'Prepollevent'
    Items.Strings = (
      '130 FTP OK'
      '136 FTP ERROR'
      '137 FTP Warning'
      '110 Preflight OK'
      '116 Preflight error'
      '117 Preflight warning'
      '120 Ripped OK'
      '126 Rip error'
      '127 Rip warning'
      '140 Color OK'
      '146 Color error'
      '147 Color warning'
      '210 Alvan OK'
      '216 Alvan Error'
      '217 Alvan Warning')
    TabOrder = 9
  end
  object Button1: TButton
    Left = 512
    Top = 324
    Width = 75
    Height = 25
    Caption = 'Insert pre'
    ModalResult = 6
    TabOrder = 10
  end
  object Editouptver: TEdit
    Left = 180
    Top = 236
    Width = 121
    Height = 21
    TabOrder = 11
    Text = '0'
  end
  object CheckBoxoutputver: TCheckBox
    Left = 12
    Top = 240
    Width = 125
    Height = 17
    Caption = 'Set outputver'
    TabOrder = 12
  end
  object Button2: TButton
    Left = 24
    Top = 280
    Width = 75
    Height = 25
    Caption = 'fix sek TK'
    TabOrder = 13
    OnClick = Button2Click
  end
end
