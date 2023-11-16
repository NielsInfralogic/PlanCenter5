object Formcurrentstate: TFormcurrentstate
  Left = 591
  Top = 444
  BorderStyle = bsDialog
  Caption = 'Current progress'
  ClientHeight = 236
  ClientWidth = 465
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  Position = poScreenCenter
  OnActivate = FormActivate
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 12
    Top = 12
    Width = 213
    Height = 169
    Caption = 'Pages'
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 106
      Height = 13
      Caption = 'Total number of pages'
    end
    object Label2: TLabel
      Left = 8
      Top = 64
      Width = 62
      Height = 13
      Caption = 'Pages ripped'
    end
    object Label3: TLabel
      Left = 8
      Top = 116
      Width = 78
      Height = 13
      Caption = 'Pages approved'
    end
    object Editpages: TEdit
      Left = 8
      Top = 32
      Width = 93
      Height = 21
      TabOrder = 0
    end
    object Editripped: TEdit
      Left = 8
      Top = 80
      Width = 93
      Height = 21
      TabOrder = 1
    end
    object Editapproved: TEdit
      Left = 8
      Top = 132
      Width = 93
      Height = 21
      TabOrder = 2
    end
  end
  object GroupBox2: TGroupBox
    Left = 236
    Top = 12
    Width = 213
    Height = 169
    Caption = 'Plates'
    TabOrder = 1
    object Label4: TLabel
      Left = 8
      Top = 16
      Width = 105
      Height = 13
      Caption = 'Total number of plates'
    end
    object Label6: TLabel
      Left = 8
      Top = 64
      Width = 66
      Height = 13
      Caption = 'Plates imaged'
    end
    object Editplates: TEdit
      Left = 8
      Top = 32
      Width = 93
      Height = 21
      TabOrder = 0
    end
    object Editimaged: TEdit
      Left = 8
      Top = 80
      Width = 93
      Height = 21
      TabOrder = 1
    end
  end
  object BitBtn1: TBitBtn
    Left = 374
    Top = 203
    Width = 75
    Height = 25
    Kind = bkClose
    NumGlyphs = 2
    TabOrder = 2
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 196
    Top = 203
    Width = 75
    Height = 25
    Caption = 'Refresh'
    TabOrder = 3
    OnClick = BitBtn2Click
  end
end
