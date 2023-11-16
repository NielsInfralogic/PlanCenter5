object FormSaveStackerSetup: TFormSaveStackerSetup
  Left = 677
  Top = 310
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'Save Plate Position Setup'
  ClientHeight = 173
  ClientWidth = 323
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 188
    Height = 13
    Caption = 'Save current press plate position setup'
  end
  object Label2: TLabel
    Left = 8
    Top = 48
    Width = 86
    Height = 13
    Caption = 'Number of pages:'
  end
  object Label3: TLabel
    Left = 8
    Top = 74
    Width = 83
    Height = 13
    Caption = 'Production type: '
  end
  object LabelNumberOfPages: TLabel
    Left = 96
    Top = 48
    Width = 3
    Height = 13
  end
  object LabelProductionType: TLabel
    Left = 96
    Top = 74
    Width = 3
    Height = 13
  end
  object Label4: TLabel
    Left = 8
    Top = 99
    Width = 61
    Height = 13
    Caption = 'Setup name:'
  end
  object Label5: TLabel
    Left = 8
    Top = 24
    Width = 281
    Height = 13
    Caption = 'Saves press tower,cylinder,zone L/H of current production'
  end
  object EditSaveName: TEdit
    Left = 96
    Top = 98
    Width = 217
    Height = 21
    TabOrder = 0
  end
  object BitBtn2: TBitBtn
    Left = 173
    Top = 136
    Width = 75
    Height = 25
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 81
    Top = 136
    Width = 75
    Height = 25
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 2
  end
end
