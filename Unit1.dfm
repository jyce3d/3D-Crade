object frmMain: TfrmMain
  Left = 185
  Top = 209
  Width = 610
  Height = 340
  Caption = '3D-Crade'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = SMM
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 120
  TextHeight = 16
  object SMM: TMainMenu
    Left = 152
    Top = 64
    object File1: TMenuItem
      Caption = 'File'
      object New1: TMenuItem
        Caption = 'New'
      end
      object Open1: TMenuItem
        Caption = '&Open'
        ShortCut = 16463
        OnClick = Open1Click
      end
      object Save1: TMenuItem
        Caption = 'Save'
        ShortCut = 16467
        OnClick = Save1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Run1: TMenuItem
        Caption = 'Run Script'
        ShortCut = 120
        OnClick = Run1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = 'Exit'
        OnClick = Exit1Click
      end
    end
    object Edit1: TMenuItem
      Caption = 'Edit'
    end
    object View2: TMenuItem
      Caption = 'View'
      object Face1: TMenuItem
        Caption = 'Face'
        ShortCut = 112
        OnClick = Face1Click
      end
      object Left1: TMenuItem
        Caption = 'Left'
        ShortCut = 113
        OnClick = Left1Click
      end
      object Up1: TMenuItem
        Caption = 'Up'
        ShortCut = 114
        OnClick = Up1Click
      end
      object Isometric1: TMenuItem
        Caption = 'Isometric'
        ShortCut = 115
        OnClick = Isometric1Click
      end
    end
    object mmuBloc: TMenuItem
      Caption = 'Block'
      object mmNew: TMenuItem
        Caption = 'New'
        ShortCut = 49218
        OnClick = mmNewClick
      end
      object mmuModify: TMenuItem
        Caption = 'Modify'
        ShortCut = 49229
        OnClick = mmuModifyClick
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object mmuBkImport: TMenuItem
        Caption = 'Import'
        OnClick = mmuBkImportClick
      end
    end
    object Operation1: TMenuItem
      Caption = 'Operation'
      ShortCut = 49236
      object Translate1: TMenuItem
        Caption = 'Translate'
        ShortCut = 49236
        OnClick = Translate1Click
      end
    end
    object Mesh1: TMenuItem
      Caption = 'Mesh'
      object mnuLine: TMenuItem
        Caption = 'Line'
      end
      object mnuEllipse: TMenuItem
        Caption = 'Ellipse'
      end
      object mnuArc: TMenuItem
        Caption = 'Arc'
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object mnuFrameBox: TMenuItem
        Caption = 'FrameBox'
        OnClick = mnuFrameBoxClick
      end
      object mnuSphere: TMenuItem
        Caption = 'Sphere'
      end
      object mnuEllipsoid: TMenuItem
        Caption = 'Ellipsoid'
      end
      object mnuArcoid: TMenuItem
        Caption = 'Arcoid'
      end
    end
    object View1: TMenuItem
      Caption = 'Windows'
      object Cascade1: TMenuItem
        Caption = 'Cascade'
        OnClick = Cascade1Click
      end
      object Tile1: TMenuItem
        Caption = 'Tile'
        OnClick = Tile1Click
      end
    end
    object Help1: TMenuItem
      Caption = 'Help'
      object About1: TMenuItem
        Caption = 'About'
        OnClick = About1Click
      end
    end
  end
  object SaveDialog: TSaveDialog
    Left = 240
    Top = 40
  end
  object OpenDialog: TOpenDialog
    Left = 240
    Top = 88
  end
end
