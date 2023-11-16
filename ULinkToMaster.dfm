object FormLinkToMaster: TFormLinkToMaster
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'Link to masterpage (make forced/common)'
  ClientHeight = 264
  ClientWidth = 560
  Color = clBtnFace
  ParentFont = True
  Position = poMainFormCenter
  DesignSize = (
    560
    264)
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 37
    Width = 186
    Height = 15
    Caption = 'Select unique masterpage to link to'
  end
  object Label2: TLabel
    Left = 8
    Top = 12
    Width = 73
    Height = 15
    Caption = 'Selected page'
  end
  object Label3: TLabel
    Left = 24
    Top = 238
    Width = 120
    Height = 15
    Caption = '(When same RIP press)'
  end
  object BitBtnCancel: TBitBtn
    Left = 298
    Top = 226
    Width = 74
    Height = 25
    Anchors = [akLeft, akBottom]
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 0
  end
  object BitBtnOK: TBitBtn
    Left = 208
    Top = 226
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 1
    OnClick = BitBtnOKClick
    ExplicitTop = 225
  end
  object ListView1: TListView
    Left = 8
    Top = 56
    Width = 540
    Height = 153
    Anchors = [akLeft, akTop, akRight, akBottom]
    Columns = <
      item
        AutoSize = True
        Caption = 'RipPress'
      end
      item
        AutoSize = True
        Caption = 'Press'
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
        Caption = 'PDFMaster'
      end
      item
        AutoSize = True
        Caption = 'MasterCopySeparationSet'
      end
      item
      end>
    GridLines = True
    MultiSelect = True
    ReadOnly = True
    RowSelect = True
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    ViewStyle = vsReport
    ExplicitWidth = 536
    ExplicitHeight = 152
  end
  object EditSelectedPage: TEdit
    Left = 82
    Top = 9
    Width = 470
    Height = 23
    ReadOnly = True
    TabOrder = 3
    Text = 'EditSelectedPage'
  end
  object CheckBoxSetCommon: TCheckBox
    Left = 8
    Top = 215
    Width = 178
    Height = 27
    Caption = 'Set as Common page'
    TabOrder = 4
  end
end
