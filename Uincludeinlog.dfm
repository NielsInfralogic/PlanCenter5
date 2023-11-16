object Formincludetolog: TFormincludetolog
  Left = 633
  Top = 456
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Formincludetolog'
  ClientHeight = 231
  ClientWidth = 461
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panelb: TPanel
    Left = 0
    Top = 0
    Width = 461
    Height = 54
    Align = alTop
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object Image2: TImage
      Left = 1
      Top = 1
      Width = 44
      Height = 52
      Align = alLeft
      Center = True
    end
    object Label2: TLabel
      Left = 76
      Top = 4
      Width = 226
      Height = 24
      Caption = 'Configure combined log'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label9: TLabel
      Left = 84
      Top = 32
      Width = 305
      Height = 13
      AutoSize = False
      Caption = 'Select the events that are included in the combined log'
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 190
    Width = 461
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 151
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 235
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 1
      OnClick = BitBtn2Click
      Kind = bkCancel
    end
    object CheckListBox1: TCheckListBox
      Left = 12
      Top = 12
      Width = 101
      Height = 41
      ItemHeight = 13
      Items.Strings = (
        'Preflight'
        'RIP'
        'Input'
        'Proof'
        'Transmission'
        'Imaging'
        'Ink eskotimation'
        'Approval'
        'Hold/release')
      TabOrder = 2
      Visible = False
    end
  end
  object CheckListBoxalllog: TCheckListBox
    Left = 0
    Top = 54
    Width = 461
    Height = 136
    Align = alClient
    ItemHeight = 13
    Items.Strings = (
      'Preflight'
      'RIP'
      'Input'
      'Proof'
      'Transmission'
      'Imaging'
      'Ink eskotimation'
      'Approval'
      'Hold/release')
    TabOrder = 2
  end
end
