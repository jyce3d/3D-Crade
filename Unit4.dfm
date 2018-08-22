object frmViewer: TfrmViewer
  Left = 145
  Top = 177
  Width = 696
  Height = 480
  Cursor = crCross
  BorderIcons = []
  Caption = '3D-Crade Viewer'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnKeyDown = FormKeyDown
  OnMouseMove = FormMouseMove
  OnPaint = FormPaint
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object sbBar: TStatusBar
    Left = 0
    Top = 434
    Width = 688
    Height = 19
    Panels = <>
    SimplePanel = True
    SimpleText = '(0,0)'
  end
end
