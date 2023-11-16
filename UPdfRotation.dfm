object PDFRotation: TPDFRotation
  Left = 0
  Top = 0
  BorderIcons = [biMinimize]
  BorderStyle = bsDialog
  Caption = 'Rotate PDF page(s)'
  ClientHeight = 195
  ClientWidth = 266
  Color = clBtnFace
  ParentFont = True
  Position = poMainFormCenter
  TextHeight = 15
  object Panelsys: TPanel
    Left = 0
    Top = 148
    Width = 266
    Height = 43
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 134
    ExplicitWidth = 227
    object BitBtn1: TBitBtn
      Left = 50
      Top = 10
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 133
      Top = 10
      Width = 78
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 266
    Height = 148
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 258
    object RadioGroupRotation: TRadioGroup
      Left = 8
      Top = 9
      Width = 249
      Height = 101
      Caption = 'Set rotation of pages (using FileCenter)'
      ItemIndex = 2
      Items.Strings = (
        'No rotation'
        '90 degrees clockwise'
        '180 degrees'
        '270 degrees clockwise')
      TabOrder = 0
    end
  end
  object CheckBoxDeleteExistingPage: TCheckBox
    Left = 9
    Top = 114
    Width = 186
    Height = 26
    Caption = 'Delete existing ripped page'
    TabOrder = 2
  end
end
