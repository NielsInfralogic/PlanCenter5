object FormSelplatecopies: TFormSelplatecopies
  Left = 609
  Top = 450
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Select Copies'
  ClientHeight = 168
  ClientWidth = 261
  Color = clBtnFace
  ParentFont = True
  Position = poMainFormCenter
  OnCreate = FormCreate
  TextHeight = 15
  object ListView1: TListView
    Left = 0
    Top = 0
    Width = 261
    Height = 128
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    Checkboxes = True
    Columns = <
      item
        AutoSize = True
        Caption = 'Copy'
      end>
    TabOrder = 0
    ViewStyle = vsReport
    ExplicitWidth = 257
    ExplicitHeight = 127
  end
  object Panel1: TPanel
    Left = 0
    Top = 128
    Width = 261
    Height = 40
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 127
    ExplicitWidth = 257
    object BitBtn1: TBitBtn
      Left = 90
      Top = 8
      Width = 75
      Height = 25
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 174
      Top = 8
      Width = 73
      Height = 25
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
    object BitBtn3: TBitBtn
      Left = 8
      Top = 8
      Width = 74
      Height = 25
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = '&All'
      Glyph.Data = {
        F2010000424DF201000000000000760000002800000024000000130000000100
        0400000000007C01000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333334433333
        3333333333388F3333333333000033334224333333333333338338F333333333
        0000333422224333333333333833338F33333333000033422222243333333333
        83333338F3333333000034222A22224333333338F33F33338F33333300003222
        A2A2224333333338F383F3338F33333300003A2A222A222433333338F8333F33
        38F33333000034A22222A22243333338833333F3338F333300004222A2222A22
        2433338F338F333F3338F3330000222A3A2224A22243338F3838F338F3338F33
        0000A2A333A2224A2224338F83338F338F3338F300003A33333A2224A2224338
        333338F338F3338F000033333333A2224A2243333333338F338F338F00003333
        33333A2224A2233333333338F338F83300003333333333A2224A333333333333
        8F338F33000033333333333A222433333333333338F338F30000333333333333
        A224333333333333338F38F300003333333333333A223333333333333338F8F3
        000033333333333333A3333333333333333383330000}
      ModalResult = 1
      NumGlyphs = 2
      TabOrder = 2
      OnClick = BitBtn3Click
    end
  end
end
