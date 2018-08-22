object frmBody: TfrmBody
  Left = 100
  Top = 105
  Width = 865
  Height = 627
  Caption = 'Body Sculptor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object btnHead: TSpeedButton
    Left = 556
    Top = 2
    Width = 33
    Height = 49
    OnClick = btnHeadClick
  end
  object btnThorax: TSpeedButton
    Left = 531
    Top = 65
    Width = 81
    Height = 73
    OnClick = btnThoraxClick
  end
  object btnPelvis: TSpeedButton
    Left = 531
    Top = 162
    Width = 90
    Height = 40
    OnClick = btnPelvisClick
  end
  object btnLeg1: TSpeedButton
    Left = 524
    Top = 210
    Width = 23
    Height = 73
    OnClick = btnLeg1Click
  end
  object btnLeg2: TSpeedButton
    Left = 604
    Top = 210
    Width = 22
    Height = 73
    OnClick = btnLeg2Click
  end
  object btnLowerLeg1: TSpeedButton
    Left = 516
    Top = 289
    Width = 23
    Height = 82
    OnClick = btnLowerLeg1Click
  end
  object btnLowerLeg2: TSpeedButton
    Left = 612
    Top = 289
    Width = 22
    Height = 82
    OnClick = btnLowerLeg2Click
  end
  object btnFoot1: TSpeedButton
    Left = 516
    Top = 377
    Width = 23
    Height = 23
    OnClick = btnFoot1Click
  end
  object btnFoot2: TSpeedButton
    Left = 612
    Top = 377
    Width = 22
    Height = 23
    OnClick = btnFoot2Click
  end
  object btnArm1: TSpeedButton
    Left = 491
    Top = 73
    Width = 23
    Height = 57
    OnClick = btnArm1Click
  end
  object btnArm2: TSpeedButton
    Left = 635
    Top = 73
    Width = 24
    Height = 57
    OnClick = btnArm2Click
  end
  object btnForeArm1: TSpeedButton
    Left = 491
    Top = 137
    Width = 23
    Height = 57
    OnClick = btnForeArm1Click
  end
  object btnForeArm2: TSpeedButton
    Left = 635
    Top = 137
    Width = 24
    Height = 57
    OnClick = btnForeArm2Click
  end
  object btnHand1: TSpeedButton
    Left = 491
    Top = 202
    Width = 23
    Height = 22
    OnClick = btnHand1Click
  end
  object btnHand2: TSpeedButton
    Left = 635
    Top = 202
    Width = 24
    Height = 22
    OnClick = btnHand2Click
  end
  object Inc: TLabel
    Left = 699
    Top = 2
    Width = 15
    Height = 13
    Caption = 'Inc'
  end
  object Label1: TLabel
    Left = 699
    Top = 58
    Width = 64
    Height = 13
    Caption = 'Selected Part'
  end
  object Label2: TLabel
    Left = 699
    Top = 106
    Width = 27
    Height = 13
    Caption = 'Rot X'
  end
  object Label3: TLabel
    Left = 699
    Top = 154
    Width = 27
    Height = 13
    Caption = 'Rot Y'
  end
  object Label4: TLabel
    Left = 696
    Top = 200
    Width = 27
    Height = 13
    Caption = 'Rot Z'
  end
  object txtInc: TEdit
    Left = 699
    Top = 24
    Width = 121
    Height = 24
    Enabled = False
    TabOrder = 0
    Text = 'pi/100'
  end
  object txtPart: TEdit
    Left = 699
    Top = 73
    Width = 121
    Height = 24
    Enabled = False
    TabOrder = 1
  end
  object txtRotX: TEdit
    Left = 699
    Top = 121
    Width = 121
    Height = 24
    TabOrder = 2
    Text = '0'
  end
  object txtRotY: TEdit
    Left = 699
    Top = 169
    Width = 121
    Height = 24
    TabOrder = 3
    Text = '0'
  end
  object udRotX: TUpDown
    Left = 820
    Top = 121
    Width = 16
    Height = 25
    Min = -100
    Position = 0
    TabOrder = 4
    Wrap = False
    OnClick = udRotXClick
  end
  object udRotY: TUpDown
    Left = 820
    Top = 169
    Width = 16
    Height = 25
    Min = -100
    Position = 0
    TabOrder = 5
    Wrap = False
    OnClick = udRotYClick
  end
  object txtRotZ: TEdit
    Left = 696
    Top = 216
    Width = 121
    Height = 24
    TabOrder = 6
    Text = '0'
  end
  object udRotz: TUpDown
    Left = 816
    Top = 216
    Width = 16
    Height = 24
    Min = -100
    Position = 0
    TabOrder = 7
    Wrap = False
    OnClick = udRotzClick
  end
  object Button1: TButton
    Left = 728
    Top = 273
    Width = 61
    Height = 20
    Caption = 'Origin'
    TabOrder = 8
    OnClick = Button1Click
  end
  object MainMenu1: TMainMenu
    Left = 800
    Top = 312
    object mmuFile: TMenuItem
      Caption = 'File'
      object New1: TMenuItem
        Caption = '&New'
        object mmuMan: TMenuItem
          Caption = 'Man'
          OnClick = mmuManClick
        end
        object mmuWoman: TMenuItem
          Caption = 'Woman'
          OnClick = mmuWomanClick
        end
      end
      object mmuOpen: TMenuItem
        Caption = 'Open'
        OnClick = mmuOpenClick
      end
      object mmuSave: TMenuItem
        Caption = 'Save'
        OnClick = mmuSaveClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object mmuExport: TMenuItem
        Caption = 'Export'
        OnClick = mmuExportClick
      end
    end
    object mmuEdit: TMenuItem
      Caption = 'Edit'
    end
    object mmuView: TMenuItem
      Caption = 'View'
      object mmuFace: TMenuItem
        Caption = 'Face'
        ShortCut = 112
        OnClick = mmuFaceClick
      end
      object mmuLeft: TMenuItem
        Caption = 'Left'
        ShortCut = 113
        OnClick = mmuLeftClick
      end
      object mmuUp: TMenuItem
        Caption = 'Up'
        ShortCut = 114
        OnClick = mmuUpClick
      end
      object mmuIsometric: TMenuItem
        Caption = 'Isometric'
        ShortCut = 115
        OnClick = mmuIsometricClick
      end
    end
    object mmuHelp: TMenuItem
      Caption = 'Help'
      object mmuAbout: TMenuItem
        Caption = 'About'
        OnClick = mmuAboutClick
      end
    end
  end
  object OpenDialog: TOpenDialog
    Left = 304
    Top = 232
  end
  object SaveDialog: TSaveDialog
    Left = 272
    Top = 144
  end
end
