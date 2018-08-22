object frmFrameBox: TfrmFrameBox
  Left = 181
  Top = 168
  Width = 764
  Height = 365
  Caption = 'Frame Box'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 13
    Top = 13
    Width = 128
    Height = 13
    Caption = 'First Quadrant, lowest point'
  end
  object Label2: TLabel
    Left = 319
    Top = 13
    Width = 87
    Height = 13
    Caption = 'Second  Quadrant'
  end
  object Label3: TLabel
    Left = 13
    Top = 195
    Width = 30
    Height = 13
    Caption = 'nLong'
  end
  object Label4: TLabel
    Left = 169
    Top = 195
    Width = 21
    Height = 13
    Caption = 'nLat'
  end
  object Label5: TLabel
    Left = 312
    Top = 195
    Width = 24
    Height = 13
    Caption = 'Color'
  end
  object Label6: TLabel
    Left = 410
    Top = 195
    Width = 44
    Height = 13
    Caption = 'Keyname'
  end
  object cbo2Point: TComboBox
    Left = 475
    Top = 13
    Width = 117
    Height = 21
    ItemHeight = 13
    TabOrder = 0
    OnChange = cbo2PointChange
  end
  object btn2XSort: TButton
    Left = 345
    Top = 52
    Width = 20
    Height = 20
    Caption = 'X>'
    TabOrder = 1
    OnClick = btn2XSortClick
  end
  object btn2YSort: TButton
    Left = 371
    Top = 52
    Width = 20
    Height = 20
    Caption = 'Y>'
    TabOrder = 2
    OnClick = btn2YSortClick
  end
  object btn2ZSort: TButton
    Left = 403
    Top = 52
    Width = 20
    Height = 20
    Caption = 'Z>'
    TabOrder = 3
    OnClick = btn2ZSortClick
  end
  object lst2Point: TListBox
    Left = 325
    Top = 78
    Width = 267
    Height = 72
    ExtendedSelect = False
    ItemHeight = 13
    TabOrder = 4
    OnClick = lst2PointClick
  end
  object cbo1Point: TComboBox
    Left = 170
    Top = 13
    Width = 117
    Height = 21
    ItemHeight = 13
    TabOrder = 5
    OnChange = cbo1PointChange
  end
  object btn1SortX: TButton
    Left = 40
    Top = 52
    Width = 19
    Height = 20
    Caption = 'X>'
    TabOrder = 6
    OnClick = btn1SortXClick
  end
  object btn1YSort: TButton
    Left = 66
    Top = 52
    Width = 19
    Height = 20
    Caption = 'Y>'
    TabOrder = 7
    OnClick = btn1YSortClick
  end
  object btn1ZSort: TButton
    Left = 98
    Top = 52
    Width = 20
    Height = 20
    Caption = 'Z>'
    TabOrder = 8
    OnClick = btn1ZSortClick
  end
  object lst1Point: TListBox
    Left = 20
    Top = 78
    Width = 267
    Height = 72
    ExtendedSelect = False
    ItemHeight = 13
    TabOrder = 9
    OnClick = lst1PointClick
  end
  object txt2PointX: TEdit
    Left = 338
    Top = 163
    Width = 72
    Height = 24
    TabOrder = 10
  end
  object txt2PointY: TEdit
    Left = 423
    Top = 163
    Width = 72
    Height = 24
    TabOrder = 11
  end
  object txt2PointZ: TEdit
    Left = 507
    Top = 163
    Width = 72
    Height = 24
    TabOrder = 12
  end
  object txt1PointX: TEdit
    Left = 33
    Top = 163
    Width = 72
    Height = 24
    TabOrder = 13
  end
  object txt1PointY: TEdit
    Left = 117
    Top = 163
    Width = 72
    Height = 24
    TabOrder = 14
  end
  object txt1PointZ: TEdit
    Left = 202
    Top = 163
    Width = 72
    Height = 24
    TabOrder = 15
  end
  object btnApply: TButton
    Left = 527
    Top = 234
    Width = 67
    Height = 27
    Caption = '&Apply'
    TabOrder = 16
    OnClick = btnApplyClick
  end
  object btnCancel: TButton
    Left = 13
    Top = 234
    Width = 67
    Height = 27
    Caption = '&Cancel'
    TabOrder = 17
    OnClick = btnCancelClick
  end
  object txtnLong: TEdit
    Left = 59
    Top = 195
    Width = 98
    Height = 24
    TabOrder = 18
  end
  object txtnLat: TEdit
    Left = 202
    Top = 195
    Width = 98
    Height = 24
    TabOrder = 19
  end
  object txtColor: TEdit
    Left = 345
    Top = 195
    Width = 59
    Height = 24
    TabOrder = 20
  end
  object txtKeyname: TEdit
    Left = 468
    Top = 195
    Width = 131
    Height = 24
    TabOrder = 21
  end
end
