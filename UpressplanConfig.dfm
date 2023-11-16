object FormPressplanConfig: TFormPressplanConfig
  Left = 687
  Top = 164
  BorderStyle = bsDialog
  Caption = 'Press plan config'
  ClientHeight = 559
  ClientWidth = 747
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
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 747
    Height = 518
    ActivePage = TabSheet3
    Align = alClient
    TabOrder = 0
    OnChange = PageControl1Change
    object TabSheet3: TTabSheet
      Caption = 'General'
      ImageIndex = 2
      object Button2: TButton
        Left = 16
        Top = 240
        Width = 75
        Height = 25
        Caption = 'Add'
        TabOrder = 0
      end
      object Button3: TButton
        Left = 104
        Top = 240
        Width = 75
        Height = 25
        Caption = 'delete'
        TabOrder = 1
      end
      object GroupBox9: TGroupBox
        Left = 4
        Top = 8
        Width = 225
        Height = 221
        Caption = 'Status'
        TabOrder = 2
        object ListBoxgeneral: TListBox
          Left = 2
          Top = 15
          Width = 221
          Height = 204
          Style = lbOwnerDrawFixed
          Align = alClient
          ItemHeight = 16
          TabOrder = 0
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Prepress'
      ImageIndex = 3
      object GroupBox8: TGroupBox
        Left = 4
        Top = 8
        Width = 225
        Height = 221
        Caption = 'Status'
        TabOrder = 0
        object ListBoxprepress: TListBox
          Left = 2
          Top = 15
          Width = 221
          Height = 204
          Style = lbOwnerDrawFixed
          Align = alClient
          ItemHeight = 16
          TabOrder = 0
        end
      end
      object Button5: TButton
        Left = 16
        Top = 240
        Width = 75
        Height = 25
        Caption = 'Add'
        TabOrder = 1
      end
      object Button6: TButton
        Left = 104
        Top = 240
        Width = 75
        Height = 25
        Caption = 'delete'
        TabOrder = 2
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Press'
      ImageIndex = 4
      object GroupBox3: TGroupBox
        Left = 392
        Top = 8
        Width = 153
        Height = 173
        Caption = 'Paper'
        TabOrder = 0
        object MemoPapir: TMemo
          Left = 2
          Top = 15
          Width = 149
          Height = 156
          Align = alClient
          Lines.Strings = (
            '45g'
            '50g'
            '60g')
          TabOrder = 0
        end
      end
      object GroupBox4: TGroupBox
        Left = 236
        Top = 8
        Width = 153
        Height = 173
        Caption = 'Folders'
        TabOrder = 1
        object Memofalse: TMemo
          Left = 2
          Top = 15
          Width = 149
          Height = 156
          Align = alClient
          Lines.Strings = (
            'Folder 1'
            'Folder 2')
          TabOrder = 0
        end
      end
      object GroupBox5: TGroupBox
        Left = 392
        Top = 192
        Width = 153
        Height = 173
        Caption = 'Glue'
        TabOrder = 2
        object Memoglu: TMemo
          Left = 2
          Top = 15
          Width = 149
          Height = 156
          Align = alClient
          Lines.Strings = (
            'No glue'
            'Glue')
          TabOrder = 0
        end
      end
      object GroupBox6: TGroupBox
        Left = 4
        Top = 8
        Width = 225
        Height = 221
        Caption = 'Status'
        TabOrder = 3
        object ListBoxprint: TListBox
          Left = 2
          Top = 15
          Width = 221
          Height = 204
          Style = lbOwnerDrawFixed
          Align = alClient
          ItemHeight = 16
          TabOrder = 0
        end
      end
      object Button7: TButton
        Left = 16
        Top = 240
        Width = 75
        Height = 25
        Caption = 'Add'
        TabOrder = 4
      end
      object Button8: TButton
        Left = 104
        Top = 240
        Width = 75
        Height = 25
        Caption = 'delete'
        TabOrder = 5
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'Packing'
      ImageIndex = 5
      object GroupBox7: TGroupBox
        Left = 4
        Top = 4
        Width = 225
        Height = 221
        Caption = 'Status'
        TabOrder = 0
        object ListBoxpack: TListBox
          Left = 2
          Top = 15
          Width = 221
          Height = 204
          Style = lbOwnerDrawFixed
          Align = alClient
          ItemHeight = 16
          TabOrder = 0
        end
      end
      object Button9: TButton
        Left = 16
        Top = 240
        Width = 75
        Height = 25
        Caption = 'Add'
        TabOrder = 1
      end
      object Button10: TButton
        Left = 104
        Top = 240
        Width = 75
        Height = 25
        Caption = 'delete'
        TabOrder = 2
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'System colors'
      ImageIndex = 1
      object BitBtn1: TBitBtn
        Left = 8
        Top = 156
        Width = 75
        Height = 25
        Caption = 'Add'
        TabOrder = 0
        OnClick = BitBtn1Click
      end
      object BitBtn2: TBitBtn
        Left = 92
        Top = 156
        Width = 75
        Height = 25
        Caption = 'Delete'
        TabOrder = 1
      end
      object GroupBox1: TGroupBox
        Left = 4
        Top = 184
        Width = 345
        Height = 145
        Caption = 'Color edit'
        TabOrder = 2
        object ColorPaint: TPaintBox
          Left = 12
          Top = 32
          Width = 73
          Height = 25
          Color = clGradientInactiveCaption
          ParentColor = False
          OnDblClick = ColorPaintDblClick
          OnPaint = ColorPaintPaint
        end
        object Label1: TLabel
          Left = 12
          Top = 16
          Width = 48
          Height = 13
          Caption = 'New color'
        end
        object Label2: TLabel
          Left = 112
          Top = 16
          Width = 53
          Height = 13
          Caption = 'Color name'
        end
        object Button1: TButton
          Left = 12
          Top = 80
          Width = 75
          Height = 25
          Caption = 'Edit'
          TabOrder = 0
          OnClick = Button1Click
        end
        object ColorBox1: TColorBox
          Left = 172
          Top = 107
          Width = 145
          Height = 22
          ItemHeight = 16
          TabOrder = 1
          Visible = False
        end
        object Editcolorname: TEdit
          Left = 112
          Top = 32
          Width = 201
          Height = 21
          TabOrder = 2
        end
        object BitBtn3: TBitBtn
          Left = 100
          Top = 80
          Width = 75
          Height = 25
          Caption = 'Apply'
          TabOrder = 3
          OnClick = BitBtn3Click
        end
      end
      object ListBoxcolors: TListBox
        Left = 8
        Top = 4
        Width = 333
        Height = 145
        Style = lbOwnerDrawFixed
        ItemHeight = 16
        TabOrder = 3
        OnClick = ListBoxcolorsClick
        OnDrawItem = ListBoxcolorsDrawItem
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 518
    Width = 747
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object BitBtn4: TBitBtn
      Left = 32
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Save'
      TabOrder = 0
    end
  end
  object GroupBoxediticon: TGroupBox
    Left = 8
    Top = 296
    Width = 257
    Height = 113
    Caption = 'Edit'
    TabOrder = 2
    object Label4: TLabel
      Left = 68
      Top = 12
      Width = 28
      Height = 13
      Caption = 'Name'
    end
    object Label5: TLabel
      Left = 12
      Top = 12
      Width = 21
      Height = 13
      Caption = 'Icon'
    end
    object Label6: TLabel
      Left = 96
      Top = 60
      Width = 75
      Height = 13
      Caption = 'Icon mask color'
    end
    object Editgenactionname: TEdit
      Left = 68
      Top = 28
      Width = 149
      Height = 21
      TabOrder = 0
    end
    object ComboBoxgenicon: TComboBox
      Left = 16
      Top = 28
      Width = 49
      Height = 24
      Style = csOwnerDrawFixed
      ItemHeight = 18
      TabOrder = 1
    end
    object Button4: TButton
      Left = 8
      Top = 72
      Width = 75
      Height = 25
      Caption = 'New icon'
      TabOrder = 2
      OnClick = Button4Click
    end
    object ColorBoxmaskcolor: TColorBox
      Left = 96
      Top = 76
      Width = 145
      Height = 22
      DefaultColorColor = clWhite
      Style = [cbStandardColors, cbExtendedColors]
      ItemHeight = 16
      TabOrder = 3
    end
  end
  object ColorDialog: TColorDialog
    Options = [cdFullOpen, cdAnyColor]
    Left = 536
    Top = 60
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Filter = 'Bitmaps (*.bmp)|*.bmp'
    Left = 420
    Top = 116
  end
  object ColorDialogmaskcolor: TColorDialog
    Options = [cdPreventFullOpen, cdSolidColor]
    Left = 456
    Top = 116
  end
end
