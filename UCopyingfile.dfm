object FormCopyingfile: TFormCopyingfile
  Left = 863
  Top = 484
  AutoSize = True
  BorderStyle = bsDialog
  Caption = 'Copying page'
  ClientHeight = 60
  ClientWidth = 354
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Animate1: TAnimate
    Left = 0
    Top = 0
    Width = 354
    Height = 60
    Align = alTop
    CommonAVI = aviCopyFile
    StopFrame = 20
  end
end
