object Framepageinformation: TFramepageinformation
  Left = 0
  Top = 0
  Width = 301
  Height = 237
  TabOrder = 0
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 297
    Height = 233
    Caption = 'Pageinformation'
    Color = clBtnFace
    ParentBackground = False
    ParentColor = False
    TabOrder = 0
    object Label1: TLabel
      Left = 12
      Top = 40
      Width = 67
      Height = 13
      Caption = 'origional page'
    end
    object ListView1: TListView
      Left = 176
      Top = 188
      Width = 105
      Height = 29
      Columns = <
        item
          Caption = 'Editioral page'
        end
        item
          Caption = 'Name'
        end>
      SmallImages = FormMain.ImageList1
      TabOrder = 0
      ViewStyle = vsReport
    end
    object TreeView1: TTreeView
      Left = 12
      Top = 56
      Width = 253
      Height = 121
      Images = FormMain.ImageList1
      Indent = 19
      TabOrder = 1
    end
  end
end
