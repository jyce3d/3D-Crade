object Form3: TForm3
  Left = 246
  Top = 167
  Width = 671
  Height = 198
  Caption = '3D-Crade Commander'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefaultPosOnly
  Visible = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 142
    Width = 663
    Height = 22
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 2
      Top = 3
      Width = 7
      Height = 16
      Caption = '>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object txtCommand: TEdit
      Left = 13
      Top = 0
      Width = 649
      Height = 22
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnKeyDown = txtCommandKeyDown
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 663
    Height = 142
    Align = alClient
    TabOrder = 1
    object mmoOutput: TMemo
      Left = 1
      Top = 1
      Width = 661
      Height = 140
      Align = alClient
      Color = clBlack
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      Lines.Strings = (
        '')
      ParentFont = False
      ScrollBars = ssBoth
      TabOrder = 0
    end
  end
end
