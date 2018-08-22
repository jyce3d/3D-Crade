object frmTranslate: TfrmTranslate
  Left = 192
  Top = 124
  Width = 791
  Height = 404
  Caption = 'Operatic'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 25
    Top = 32
    Width = 93
    Height = 16
    Caption = 'From Object 3D'
  end
  object Label2: TLabel
    Left = 401
    Top = 32
    Width = 79
    Height = 16
    Caption = 'To Object 3D'
  end
  object cboFrom: TComboBox
    Left = 137
    Top = 32
    Width = 144
    Height = 24
    ItemHeight = 16
    TabOrder = 0
    OnChange = cboFromChange
  end
  object lstFrom: TListBox
    Left = 32
    Top = 112
    Width = 329
    Height = 193
    ExtendedSelect = False
    ItemHeight = 16
    TabOrder = 1
  end
  object cboTo: TComboBox
    Left = 497
    Top = 32
    Width = 144
    Height = 24
    ItemHeight = 16
    TabOrder = 2
    OnChange = cboToChange
  end
  object lstTo: TListBox
    Left = 393
    Top = 112
    Width = 312
    Height = 193
    ExtendedSelect = False
    ItemHeight = 16
    TabOrder = 3
  end
  object cmdApply: TButton
    Left = 633
    Top = 325
    Width = 77
    Height = 31
    Caption = '&Translate'
    TabOrder = 4
    OnClick = cmdApplyClick
  end
  object cmdCancel: TButton
    Left = 30
    Top = 325
    Width = 76
    Height = 31
    Caption = '&Cancel'
    TabOrder = 5
    OnClick = cmdCancelClick
  end
  object cmdXFromSort: TButton
    Left = 57
    Top = 80
    Width = 24
    Height = 25
    Caption = 'X>'
    TabOrder = 6
    OnClick = cmdXFromSortClick
  end
  object cmdYFromSort: TButton
    Left = 89
    Top = 80
    Width = 24
    Height = 25
    Caption = 'Y>'
    TabOrder = 7
    OnClick = cmdYFromSortClick
  end
  object cmdZFromSort: TButton
    Left = 128
    Top = 80
    Width = 25
    Height = 25
    Caption = 'Z>'
    TabOrder = 8
    OnClick = cmdZFromSortClick
  end
  object cmdYToSort: TButton
    Left = 448
    Top = 80
    Width = 25
    Height = 25
    Caption = 'Y>'
    TabOrder = 9
    OnClick = cmdYToSortClick
  end
  object cmdXToSort: TButton
    Left = 416
    Top = 80
    Width = 25
    Height = 25
    Caption = 'X>'
    TabOrder = 10
    OnClick = cmdXToSortClick
  end
  object cmdZToSort: TButton
    Left = 489
    Top = 80
    Width = 24
    Height = 25
    Caption = 'Z>'
    TabOrder = 11
    OnClick = cmdZToSortClick
  end
  object cmdCopyL: TButton
    Left = 295
    Top = 80
    Width = 61
    Height = 25
    Caption = 'Copy'
    TabOrder = 12
    OnClick = cmdCopyLClick
  end
  object cmdCopyR: TButton
    Left = 640
    Top = 80
    Width = 60
    Height = 25
    Caption = 'Copy'
    TabOrder = 13
    OnClick = cmdCopyRClick
  end
end
