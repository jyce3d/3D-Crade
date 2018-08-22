object frmBlockEdit: TfrmBlockEdit
  Left = 223
  Top = 149
  Width = 684
  Height = 445
  AutoSize = True
  Caption = 'Block Editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 676
    Height = 63
    Align = alTop
    AutoSize = True
    BevelInner = bvRaised
    BevelOuter = bvNone
    BorderWidth = 1
    BorderStyle = bsSingle
    TabOrder = 0
    object Label1: TLabel
      Left = 2
      Top = 4
      Width = 68
      Height = 13
      Caption = 'BLock Name :'
    end
    object Label4: TLabel
      Left = 2
      Top = 36
      Width = 67
      Height = 13
      Caption = 'Parent Block :'
    end
    object txtBlockName: TEdit
      Left = 73
      Top = 2
      Width = 201
      Height = 24
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object cboParentBlock: TComboBox
      Left = 73
      Top = 36
      Width = 225
      Height = 21
      ItemHeight = 13
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 59
    Width = 545
    Height = 352
    Anchors = [akRight, akBottom]
    AutoSize = True
    BevelInner = bvRaised
    BevelOuter = bvNone
    BorderWidth = 1
    BorderStyle = bsSingle
    TabOrder = 1
    object Label2: TLabel
      Left = 2
      Top = 2
      Width = 82
      Height = 13
      Caption = 'Available Shapes'
    end
    object Label3: TLabel
      Left = 337
      Top = 2
      Width = 66
      Height = 13
      Caption = 'Block Shapes'
    end
    object lstAvailable: TListBox
      Left = 2
      Top = 25
      Width = 208
      Height = 281
      ItemHeight = 13
      TabOrder = 0
    end
    object btnCancel: TButton
      Left = 463
      Top = 321
      Width = 75
      Height = 25
      Caption = 'C&ancel'
      TabOrder = 1
      OnClick = btnCancelClick
    end
    object btnSave: TButton
      Left = 383
      Top = 321
      Width = 75
      Height = 25
      Caption = '&Save'
      TabOrder = 2
      OnClick = btnSaveClick
    end
    object btnAdd: TButton
      Left = 231
      Top = 106
      Width = 75
      Height = 24
      Caption = '>'
      TabOrder = 3
      OnClick = btnAddClick
    end
    object lstBlock: TListBox
      Left = 330
      Top = 25
      Width = 209
      Height = 281
      ItemHeight = 13
      TabOrder = 4
    end
    object btnRemove: TButton
      Left = 231
      Top = 145
      Width = 75
      Height = 24
      Caption = '<'
      TabOrder = 5
      OnClick = btnRemoveClick
    end
  end
end
