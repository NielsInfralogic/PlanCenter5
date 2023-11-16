object FormGentagne: TFormGentagne
  Left = 728
  Top = 484
  BorderIcons = [biMinimize, biMaximize]
  Caption = 'Recurring schedule'
  ClientHeight = 246
  ClientWidth = 619
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 205
    Width = 619
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 212
      Top = 8
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 296
      Top = 8
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 61
    Width = 619
    Height = 144
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object GroupBoxweekly: TGroupBox
      Left = 128
      Top = 4
      Width = 401
      Height = 141
      Caption = 'Weekly'
      TabOrder = 2
      Visible = False
      object Label1: TLabel
        Left = 144
        Top = 68
        Width = 27
        Height = 13
        Caption = 'Every'
      end
      object Label2: TLabel
        Left = 240
        Top = 68
        Width = 29
        Height = 13
        Caption = 'Week'
      end
      object Label3: TLabel
        Left = 8
        Top = 16
        Width = 41
        Height = 13
        Caption = 'On each'
      end
      object EdithverNuge: TEdit
        Left = 176
        Top = 64
        Width = 37
        Height = 21
        TabOrder = 0
        Text = '1'
      end
      object CheckListBoxonday: TCheckListBox
        Left = 8
        Top = 28
        Width = 121
        Height = 105
        ItemHeight = 13
        TabOrder = 1
        OnClick = CheckListBoxondayClick
      end
      object UpDown1: TUpDown
        Left = 213
        Top = 64
        Width = 16
        Height = 21
        Associate = EdithverNuge
        Min = 1
        Max = 52
        Position = 1
        TabOrder = 2
      end
    end
    object RadioGroupRecurtype: TRadioGroup
      Left = 0
      Top = 0
      Width = 125
      Height = 144
      Align = alLeft
      ItemIndex = 0
      Items.Strings = (
        'Daily'
        'Weekly'
        'Monthly')
      TabOrder = 0
      OnClick = RadioGroupRecurtypeClick
    end
    object GroupBoxdayli: TGroupBox
      Left = 128
      Top = 44
      Width = 417
      Height = 57
      Caption = 'Dayli'
      TabOrder = 3
      object Label7: TLabel
        Left = 12
        Top = 24
        Width = 27
        Height = 13
        Caption = 'Every'
      end
      object Label8: TLabel
        Left = 108
        Top = 24
        Width = 91
        Height = 13
        Caption = 'Days  (1=everyday)'
      end
      object EditNdage: TEdit
        Left = 48
        Top = 20
        Width = 33
        Height = 21
        TabOrder = 0
        Text = '1'
      end
      object UpDown2: TUpDown
        Left = 81
        Top = 20
        Width = 16
        Height = 21
        Associate = EditNdage
        Min = 1
        Position = 1
        TabOrder = 1
      end
    end
    object GroupBoxMonthly: TGroupBox
      Left = 128
      Top = 12
      Width = 493
      Height = 129
      Caption = 'Monthly'
      TabOrder = 1
      Visible = False
      object Panel3: TPanel
        Left = 2
        Top = 15
        Width = 304
        Height = 112
        Align = alClient
        BevelOuter = bvNone
        Caption = 'Panel3'
        TabOrder = 1
        object GroupBox7: TGroupBox
          Left = 0
          Top = 0
          Width = 304
          Height = 54
          Align = alTop
          Caption = 'On a day'
          TabOrder = 0
          object EditdatoiMonth: TEdit
            Left = 72
            Top = 16
            Width = 37
            Height = 21
            TabOrder = 0
            Text = '1'
            OnChange = EditdatoiMonthChange
          end
          object UpDown6: TUpDown
            Left = 109
            Top = 16
            Width = 16
            Height = 21
            Associate = EditdatoiMonth
            Min = 1
            Max = 52
            Position = 1
            TabOrder = 1
          end
          object RadioButtonMonthOnDay: TRadioButton
            Left = 8
            Top = 20
            Width = 57
            Height = 17
            Caption = 'Day'
            Checked = True
            TabOrder = 2
            TabStop = True
            OnClick = RadioButtonMonthOnDayClick
          end
        end
        object GroupBox6: TGroupBox
          Left = 0
          Top = 54
          Width = 304
          Height = 58
          Align = alClient
          Caption = 'On the'
          TabOrder = 1
          object ComboBoxFSTW: TComboBox
            Left = 68
            Top = 20
            Width = 97
            Height = 21
            Style = csDropDownList
            TabOrder = 0
            OnChange = ComboBoxFSTWChange
            Items.Strings = (
              'F'#248'rste'
              'Anden'
              'Tredige'
              'Fjerde'
              'Sidste')
          end
          object ComboBoxmonthday: TComboBox
            Left = 164
            Top = 20
            Width = 121
            Height = 21
            Style = csDropDownList
            TabOrder = 1
            OnChange = ComboBoxmonthdayChange
          end
          object RadioButtonMonthOnThe: TRadioButton
            Left = 8
            Top = 20
            Width = 53
            Height = 17
            Caption = 'The'
            TabOrder = 2
            OnClick = RadioButtonMonthOnTheClick
          end
        end
      end
      object GroupBox3: TGroupBox
        Left = 306
        Top = 15
        Width = 185
        Height = 112
        Align = alRight
        TabOrder = 0
        object Label16: TLabel
          Left = 13
          Top = 52
          Width = 40
          Height = 13
          Caption = 'Of every'
        end
        object Label17: TLabel
          Left = 127
          Top = 52
          Width = 30
          Height = 13
          Caption = 'Month'
        end
        object Editeverynmonths: TEdit
          Left = 60
          Top = 48
          Width = 37
          Height = 21
          TabOrder = 0
          Text = '1'
        end
        object UpDown8: TUpDown
          Left = 97
          Top = 48
          Width = 16
          Height = 21
          Associate = Editeverynmonths
          Min = 1
          Max = 12
          Position = 1
          TabOrder = 1
        end
      end
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 619
    Height = 61
    Align = alTop
    TabOrder = 2
    object Label10: TLabel
      Left = 16
      Top = 8
      Width = 46
      Height = 13
      Caption = 'Start date'
    end
    object Label9: TLabel
      Left = 144
      Top = 8
      Width = 168
      Height = 13
      Caption = 'Number of recurrences  (0=Forever)'
    end
    object Label4: TLabel
      Left = 320
      Top = 8
      Width = 140
      Height = 13
      Caption = 'Number of active recurrences'
    end
    object DateTimePickerstartdag: TDateTimePicker
      Left = 16
      Top = 24
      Width = 113
      Height = 21
      Date = 39696.000000000000000000
      Time = 0.393768078713037500
      TabOrder = 0
      OnChange = DateTimePickerstartdagChange
    end
    object EditnSchedules: TEdit
      Left = 144
      Top = 24
      Width = 33
      Height = 21
      TabOrder = 1
      Text = '1'
    end
    object UpDownantalgange: TUpDown
      Left = 177
      Top = 24
      Width = 16
      Height = 21
      Associate = EditnSchedules
      Max = 1000
      Position = 1
      TabOrder = 2
    end
    object EditnActiveSchedules: TEdit
      Left = 320
      Top = 20
      Width = 33
      Height = 21
      TabOrder = 3
      Text = '1'
    end
    object UpDownantalplannerafg: TUpDown
      Left = 353
      Top = 20
      Width = 16
      Height = 21
      Associate = EditnActiveSchedules
      Position = 1
      TabOrder = 4
    end
  end
end
