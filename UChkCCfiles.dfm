object Formchkccfiles: TFormchkccfiles
  Left = 328
  Top = 146
  Caption = 'Check CCFILES'
  ClientHeight = 371
  ClientWidth = 945
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 945
    Height = 65
    Align = alTop
    TabOrder = 0
    object DateTimePicker1: TDateTimePicker
      Left = 12
      Top = 24
      Width = 121
      Height = 21
      Date = 40904.548487951390000000
      Time = 40904.548487951390000000
      TabOrder = 0
    end
    object CheckBoxnotim: TCheckBox
      Left = 196
      Top = 24
      Width = 97
      Height = 17
      Caption = 'Not Imaged'
      TabOrder = 1
    end
    object Button1: TButton
      Left = 620
      Top = 20
      Width = 75
      Height = 25
      Caption = 'GO'
      TabOrder = 2
      OnClick = Button1Click
    end
    object CheckBoxfromdate: TCheckBox
      Left = 12
      Top = 4
      Width = 97
      Height = 17
      Caption = 'From pubdate'
      TabOrder = 3
    end
    object RadioGrouppath: TRadioGroup
      Left = 328
      Top = 8
      Width = 185
      Height = 53
      Caption = 'Use path'
      TabOrder = 4
    end
  end
  object ListView1: TListView
    Left = 0
    Top = 65
    Width = 945
    Height = 256
    Align = alClient
    Columns = <
      item
        AutoSize = True
        Caption = 'Pubdate'
      end
      item
        AutoSize = True
        Caption = 'Press'
      end
      item
        AutoSize = True
        Caption = 'Publication'
      end
      item
        AutoSize = True
        Caption = 'Edition'
      end
      item
        AutoSize = True
        Caption = 'Section'
      end
      item
        AutoSize = True
        Caption = 'Page'
      end
      item
        AutoSize = True
        Caption = 'Color'
      end
      item
        Caption = 'Input time'
      end
      item
        Caption = 'Master'
      end
      item
        AutoSize = True
        Caption = 'Filename'
      end
      item
        AutoSize = True
        Caption = 'Found'
      end>
    GridLines = True
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
  end
  object Panel2: TPanel
    Left = 0
    Top = 321
    Width = 945
    Height = 50
    Align = alBottom
    TabOrder = 2
    object GroupBox2: TGroupBox
      Left = 336
      Top = 4
      Width = 317
      Height = 41
      Caption = 'File check'
      TabOrder = 0
      object ProgressBar2: TProgressBar
        Left = 8
        Top = 16
        Width = 297
        Height = 17
        Smooth = True
        TabOrder = 0
      end
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 4
      Width = 317
      Height = 41
      Caption = 'Extracting data'
      TabOrder = 1
      object ProgressBar1: TProgressBar
        Left = 8
        Top = 16
        Width = 297
        Height = 17
        Smooth = True
        TabOrder = 0
      end
    end
  end
end
