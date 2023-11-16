object Formselectfromlist: TFormselectfromlist
  Left = 1011
  Top = 324
  BorderStyle = bsDialog
  Caption = 'Select'
  ClientHeight = 378
  ClientWidth = 305
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  TextHeight = 13
  object ListBox1: TListBox
    Left = 0
    Top = 0
    Width = 305
    Height = 304
    Align = alClient
    ItemHeight = 13
    TabOrder = 0
    ExplicitWidth = 301
    ExplicitHeight = 303
  end
  object Panel1: TPanel
    Left = 0
    Top = 344
    Width = 305
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 343
    ExplicitWidth = 301
    object BitBtn1: TBitBtn
      Left = 73
      Top = 4
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 157
      Top = 4
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object PanelAllcopies: TPanel
    Left = 0
    Top = 304
    Width = 305
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    Visible = False
    ExplicitTop = 303
    ExplicitWidth = 301
    object CheckBox1: TCheckBox
      Left = 4
      Top = 14
      Width = 293
      Height = 17
      Caption = 'Lock all copies to same device i settings'
      TabOrder = 0
    end
  end
end
