object Formeditdates: TFormeditdates
  Left = 618
  Top = 590
  BorderStyle = bsDialog
  Caption = 'Edit publication date, publication or edition'
  ClientHeight = 224
  ClientWidth = 325
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 17
    Top = 20
    Width = 76
    Height = 13
    Caption = 'Publication date'
  end
  object Label2: TLabel
    Left = 130
    Top = 20
    Width = 50
    Height = 13
    Caption = 'Press date'
  end
  object Label3: TLabel
    Left = 243
    Top = 20
    Width = 67
    Height = 13
    Caption = 'Week number'
  end
  object Label4: TLabel
    Left = 17
    Top = 76
    Width = 52
    Height = 13
    Caption = 'Publication'
  end
  object Label5: TLabel
    Left = 17
    Top = 122
    Width = 32
    Height = 13
    Caption = 'Edition'
  end
  object DateTimePickerpubdate: TDateTimePicker
    Left = 16
    Top = 37
    Width = 99
    Height = 21
    Date = 39148.000000000000000000
    Time = 0.635490810200281000
    TabOrder = 0
    OnChange = DateTimePickerpubdateChange
  end
  object DateTimePickerpressdate: TDateTimePicker
    Left = 128
    Top = 37
    Width = 106
    Height = 21
    Date = 39148.000000000000000000
    Time = 0.635490810200281000
    TabOrder = 1
  end
  object Editweeknumber: TEdit
    Left = 243
    Top = 37
    Width = 29
    Height = 21
    NumbersOnly = True
    TabOrder = 2
    Text = '1'
    OnChange = EditweeknumberChange
  end
  object Panel1: TPanel
    Left = 0
    Top = 183
    Width = 325
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object BitBtn1: TBitBtn
      Left = 83
      Top = 8
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 171
      Top = 8
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object ComboBoxPublication: TComboBox
    Left = 17
    Top = 95
    Width = 145
    Height = 21
    Style = csDropDownList
    TabOrder = 4
  end
  object ComboBoxEdition: TComboBox
    Left = 17
    Top = 141
    Width = 145
    Height = 21
    Style = csDropDownList
    TabOrder = 5
  end
  object UpDownweek: TUpDown
    Left = 272
    Top = 37
    Width = 16
    Height = 21
    Associate = Editweeknumber
    Min = 1
    Max = 53
    Position = 1
    TabOrder = 6
  end
end
