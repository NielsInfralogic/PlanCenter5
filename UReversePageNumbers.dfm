object FormReversePageNumbers: TFormReversePageNumbers
  Left = 577
  Top = 371
  BorderIcons = []
  Caption = 'Reverse page numbers'
  ClientHeight = 149
  ClientWidth = 396
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poMainFormCenter
  OnActivate = FormActivate
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 16
    Width = 187
    Height = 13
    Caption = 'Selected page range will be renamed to'
  end
  object LabelPageRange: TLabel
    Left = 232
    Top = 18
    Width = 27
    Height = 13
    Caption = '.........'
  end
  object Panel1: TPanel
    Left = 0
    Top = 107
    Width = 396
    Height = 42
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 106
    ExplicitWidth = 392
    object BitBtn3: TBitBtn
      Left = 122
      Top = 8
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn4: TBitBtn
      Left = 206
      Top = 8
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object CheckBoxRotateSelectedPages: TCheckBox
    Left = 32
    Top = 42
    Width = 289
    Height = 25
    Caption = 'Set selected pages to 180 degrees rotation'
    TabOrder = 1
    OnClick = CheckBoxRotateSelectedPagesClick
  end
  object CheckBoxReprocessNow: TCheckBox
    Left = 32
    Top = 73
    Width = 289
    Height = 25
    Caption = 'Do rotation now (re-processed in FileCenter)'
    Checked = True
    State = cbChecked
    TabOrder = 2
  end
end
