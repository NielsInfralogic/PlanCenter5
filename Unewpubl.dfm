object FormnewpublA: TFormnewpublA
  Left = 626
  Top = 386
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'New publication name'
  ClientHeight = 227
  ClientWidth = 347
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
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 137
    Height = 13
    AutoSize = False
    Caption = 'Publication name'
  end
  object Editnewname: TEdit
    Left = 16
    Top = 32
    Width = 301
    Height = 21
    TabOrder = 0
    OnChange = EditnewnameChange
  end
  object BitBtn1: TBitBtn
    Left = 84
    Top = 192
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 176
    Top = 192
    Width = 75
    Height = 25
    TabOrder = 2
    Kind = bkCancel
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 72
    Width = 301
    Height = 109
    Caption = 'Optional alias'
    TabOrder = 3
    object Label2: TLabel
      Left = 8
      Top = 20
      Width = 269
      Height = 13
      AutoSize = False
      Caption = 'Input alias (if more than one then separate with comma)'
    end
    object Label3: TLabel
      Left = 8
      Top = 64
      Width = 137
      Height = 13
      AutoSize = False
      Caption = 'Output alias'
    end
    object Editinput: TEdit
      Left = 8
      Top = 36
      Width = 265
      Height = 21
      TabOrder = 0
      OnChange = EditnewnameChange
    end
    object Editoutput: TEdit
      Left = 8
      Top = 76
      Width = 265
      Height = 21
      TabOrder = 1
      OnChange = EditnewnameChange
    end
  end
end
