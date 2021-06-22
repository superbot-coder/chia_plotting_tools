object FrmMDIChildPlotter: TFrmMDIChildPlotter
  Left = 0
  Top = 0
  ClientHeight = 650
  ClientWidth = 1054
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  Icon.Data = {
    0000010001001010000001002000680400001600000028000000100000002000
    000001002000000000004004000000000000000000000000000000000000B0B0
    B000B6B6B6009A9A9A00AAAAAA00C9C9C900C9CAC900CDC5CD29C1C0C050CCCC
    CB13AFADAD00F5F4F500AFAEAD00C1C0BF00C5C4C30000000000000000008383
    8300B0B0B000ADADAD00BBBBBB26A0A0A072878687C05D6A5EFD8C8D8BFFB7B6
    B5F1ADABABAFB5B4B359B5B4B312C8C7C600F6F5F600A9A7A600BDBBBA009F9B
    A100C8C5C907898989C4636363FF3A3A3AFF1D1D1EFF0F3610FF8F908DFFC2BF
    BFFFADACABFFAAA9A8FFADACABF2B4B3B2A8B3B3B359ADABAA0EC2C0BF00A3B8
    9B28B6C4B05E3C3A3DFF121112FF353535FF6E6D6DFFAFA9ACFFE4E0DFFFE3E0
    DEFFD3D1CFFFC3C1C0FFB5B3B2FFABAAA9FFAAA9A8FFABAAA9E5B2B0AF1495A7
    8D08A6BE9D6B838481FBABA7A9FFEBE2E9FFFBF5F6FFF4F1EFFFE8E5E3FFE7E4
    E2FFE9E6E4FFE8E5E3FFE0DEDCFFD3D1CFFFC3C1C0FFB5B3B2FFABA9A81C0000
    0000C0D9B60089C8762EABD499B0B6D2A7FFD8DCD0FFF0E7EDFFF1E7EFFFEBE5
    E7FFE6E3E1FFE9E4E4FFF1E8EDFFF5EAF2FDF2E9EFF9ECE3EAB7D4D2D00BDFE1
    DE006CB7500088C373007BB6654176BA5E6C71B657C883BB6CFFB4CEA6FFDEDF
    D7FFF2E8F0FFE9E4E5FFC3D5B8FF9EC68CE3C5DBBA1D9FCA8D00000000000000
    00006DB4520051A6310058AB39C767B14BD38DC5787D6CB5528858AB3AD263AE
    46FA84BB6EFF71B457FF53A833FF4EA62EFD54A9356353A833004AA629000000
    00009BCA8D0056A937005FAD419857A939FF55A836FF61AE44E166B14AC36EB5
    54EA59AB3BFF52A733FF5AAB3CFF5BAB3DFF5CAB3DF870B6561A61AF43000000
    000069B34E006CB4510078B961315BAB3DFF5AAA3CFF5AAB3CFF59AA3BFF5BAB
    3DFF5DAC40FF5BAB3DFF5BAB3DFF5BAB3DFF5BAB3DFF5FAD42A660A845000000
    00000000000092C77E006FB457006CB3527E5CAC3DFF5AAB3CFF5BAB3DFF5BAB
    3DFF5BAB3DFF5CAC3EFF5CAC3EFF5BAB3DFF58A939FF5AAB3CFF70B3583C0000
    00000000000083C06D0095C9800070B359006CB154725EAC42EA5CAC3FFF5BAB
    3DFF5BAB3DFF5CAC3EFF5CAC3EFF5EAD41FF65B04AE269B050A16CAC55350000
    0000000000000000000089C2730081D2540087BE75006CAF570E6FB555506AB2
    4F7762AF46816CB4527C80BE695B7FBD682B80BE6F049EC69300068100000000
    000000000000000000000000000078BA5F0079B7620065AD4D0064AF47005CAC
    3E005BAB3D005CAC3F0062AF460069B24E0079BA640084BC70007FBD67000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    0000F03F0000C0070000C001000080010000E0010000F0070000E0030000E003
    0000F0010000F0010000F8010000FF1F0000FFFF0000FFFF0000FFFF0000}
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object sSplitterHeight: TsSplitter
    Left = 0
    Top = 154
    Width = 1054
    Height = 15
    Cursor = crVSplit
    Align = alTop
    SizingByClick = True
    ShowGrip = True
    ExplicitLeft = 8
    ExplicitTop = 106
    ExplicitWidth = 902
  end
  object sSplitterBottom: TsSplitter
    Left = 0
    Top = 465
    Width = 1054
    Height = 15
    Cursor = crVSplit
    Align = alTop
    AutoSnap = False
    MinSize = 26
    ShowGrip = True
    ExplicitTop = 251
    ExplicitWidth = 902
  end
  object sPnlStatus: TsPanel
    Left = 0
    Top = 169
    Width = 1054
    Height = 296
    Align = alTop
    Anchors = [akLeft, akBottom]
    TabOrder = 0
    DesignSize = (
      1054
      296)
    object sLblRetsrtData: TsLabel
      Left = 376
      Top = 275
      Width = 6
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = '0'
      ExplicitTop = 140
    end
    object sLblRestartedCount: TsLabel
      Left = 245
      Top = 275
      Width = 125
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = #1047#1072#1074#1080#1089#1072#1085#1080#1077' / '#1087#1077#1088#1077#1079#1072#1087#1091#1089#1082':'
      ExplicitTop = 140
    end
    object sLblTotalTime: TsLabel
      Left = 10
      Top = 275
      Width = 140
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = #1054#1073#1097#1077#1077' '#1074#1088#1077#1084#1103' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103': '
      ExplicitTop = 140
    end
    object sLblTotalTimeData: TsLabel
      Left = 156
      Top = 275
      Width = 47
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = '00:00:00 '
      ExplicitTop = 140
    end
    object mmCnsl: TsMemo
      Left = 1
      Top = 1
      Width = 1052
      Height = 270
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      OEMConvert = True
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
      BoundLabel.ParentFont = False
    end
  end
  object sLV: TsListView
    Left = 0
    Top = 480
    Width = 1054
    Height = 170
    BoundLabel.ParentFont = False
    Align = alClient
    Columns = <
      item
        Caption = #8470
        MaxWidth = 70
        MinWidth = 25
      end
      item
        Caption = 'ID: & '#1060#1072#1081#1083':'
        MaxWidth = 600
        MinWidth = 70
        Width = 400
      end
      item
        Alignment = taCenter
        Caption = #1042#1088#1077#1084#1103' '#1086#1073#1097#1077#1077
        MaxWidth = 150
        MinWidth = 70
        Width = 100
      end
      item
        Alignment = taCenter
        Caption = #1060#1072#1079#1072' 1 '#1074#1088#1077#1084#1103':'
        MaxWidth = 150
        MinWidth = 70
        Width = 90
      end
      item
        Alignment = taCenter
        Caption = #1060#1072#1079#1072' 2 '#1074#1088#1077#1084#1103':'
        MaxWidth = 150
        MinWidth = 70
        Width = 90
      end
      item
        Alignment = taCenter
        Caption = #1060#1072#1079#1072' 3 '#1074#1077#1084#1103':'
        MaxWidth = 150
        MinWidth = 70
        Width = 90
      end
      item
        Alignment = taCenter
        Caption = #1060#1072#1079#1072' 4 '#1074#1088#1077#1084#1103': '
        MaxWidth = 150
        MinWidth = 70
        Width = 90
      end
      item
        Alignment = taCenter
        Caption = #1057#1090#1072#1090#1091#1089
        MaxWidth = 200
        MinWidth = 70
        Width = 90
      end
      item
      end>
    MultiSelect = True
    ReadOnly = True
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
  end
  object sPnlPlotter: TsPanel
    Left = 0
    Top = 0
    Width = 1054
    Height = 154
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object sLblDirTemp: TsLabel
      Left = 10
      Top = 12
      Width = 159
      Height = 13
      Caption = #1042#1088#1077#1084#1077#1085#1085#1072#1103' '#1076#1080#1088#1077#1082#1090#1086#1088#1080#1103' (Temp):'
    end
    object sLblDirDest: TsLabel
      Left = 255
      Top = 12
      Width = 127
      Height = 13
      Caption = #1060#1080#1085#1072#1083#1100#1085#1072#1103' '#1076#1080#1088#1077#1082#1090#1086#1088#1080#1103': '
    end
    object sLblWallets: TsLabel
      Left = 10
      Top = 57
      Width = 88
      Height = 13
      Caption = #1050'o'#1096#1077#1083#1105#1082' (Key ID)'
    end
    object sLblThread: TsLabel
      Left = 290
      Top = 57
      Width = 41
      Height = 13
      Caption = #1055#1086#1090#1086#1082#1080':'
    end
    object sLblRam: TsLabel
      Left = 353
      Top = 57
      Width = 41
      Height = 13
      Caption = #1055#1072#1084#1103#1090#1100':'
    end
    object sLblPlotType: TsLabel
      Left = 139
      Top = 57
      Width = 55
      Height = 13
      Caption = #1058#1080#1087' '#1087#1083#1086#1090#1072':'
    end
    object sLblBackets: TsLabel
      Left = 437
      Top = 57
      Width = 48
      Height = 13
      Caption = #1050#1086#1088#1079#1080#1085#1099':'
    end
    object sLblCount: TsLabel
      Left = 213
      Top = 57
      Width = 64
      Height = 13
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086':'
    end
    object sBtnStart: TsButton
      Left = 178
      Top = 114
      Width = 85
      Height = 25
      Caption = #1057#1058#1040#1056#1058
      ImageIndex = 2
      Images = FrmMain.ImageListBtn
      TabOrder = 11
      OnClick = sBtnStartClick
    end
    object sBtnStop: TsButton
      Left = 297
      Top = 114
      Width = 85
      Height = 25
      Caption = #1057#1058#1054#1055
      ImageIndex = 4
      Images = FrmMain.ImageListBtn
      TabOrder = 12
      OnClick = sBtnStopClick
    end
    object sDirEditTemp: TsDirectoryEdit
      Left = 10
      Top = 30
      Width = 225
      Height = 21
      MaxLength = 255
      TabOrder = 0
      Text = ''
      CheckOnExit = True
      BoundLabel.ParentFont = False
      Root = 'rfDesktop'
    end
    object sDirEditFinal: TsDirectoryEdit
      Left = 255
      Top = 29
      Width = 225
      Height = 21
      MaxLength = 255
      TabOrder = 1
      Text = ''
      CheckOnExit = True
      BoundLabel.ParentFont = False
      Root = 'rfDesktop'
    end
    object sCmBoxExWalKey: TsComboBoxEx
      Left = 10
      Top = 76
      Width = 123
      Height = 22
      BoundLabel.ParentFont = False
      ItemsEx = <>
      ItemIndex = -1
      TabOrder = 2
      Images = FrmMain.ImageListBtn
    end
    object sSpEditCPUThred: TsSpinEdit
      Left = 290
      Top = 76
      Width = 49
      Height = 21
      TabOrder = 5
      Text = '2'
      BoundLabel.ParentFont = False
      MaxValue = 128
      MinValue = 2
      Value = 2
    end
    object sSpEditRam: TsSpinEdit
      Left = 353
      Top = 76
      Width = 72
      Height = 21
      TabOrder = 6
      Text = '3390'
      BoundLabel.ParentFont = False
      MaxValue = 0
      MinValue = 3390
      Value = 3390
    end
    object sChBoxBitField: TsCheckBox
      Left = 506
      Top = 55
      Width = 96
      Height = 17
      Caption = #1041#1080#1090#1086#1074#1086#1077' '#1087#1086#1083#1077
      TabOrder = 8
    end
    object sBtnCreateBatFile: TsButton
      Left = 10
      Top = 114
      Width = 123
      Height = 25
      Caption = #1057#1086#1079#1076#1072#1090#1100' .BAT '#1092#1072#1081#1083' '
      TabOrder = 10
      OnClick = sBtnCreateBatFileClick
    end
    object sCmBoxPlotsType: TsComboBox
      Left = 139
      Top = 76
      Width = 55
      Height = 21
      BoundLabel.ParentFont = False
      ItemIndex = -1
      TabOrder = 3
      OnSelect = sCmBoxPlotsTypeSelect
    end
    object sSpEditBackets: TsSpinEdit
      Left = 437
      Top = 76
      Width = 48
      Height = 21
      TabOrder = 7
      Text = '128'
      BoundLabel.ParentFont = False
      MaxValue = 128
      MinValue = 16
      Value = 128
    end
    object sBtnSave: TsButton
      Left = 566
      Top = 114
      Width = 123
      Height = 25
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Images = FrmMain.ImageListBtn
      TabOrder = 14
      OnClick = sBtnSaveClick
    end
    object sSpEditCount: TsSpinEdit
      Left = 213
      Top = 76
      Width = 64
      Height = 21
      TabOrder = 4
      Text = '1'
      BoundLabel.ParentFont = False
      MaxValue = 1000
      MinValue = 1
      Value = 1
    end
    object sChBoxSkeepAddFinalDir: TsCheckBox
      Left = 506
      Top = 78
      Width = 165
      Height = 17
      Caption = #1053#1077' '#1076#1086#1073#1072#1074#1083#1103#1090#1100' '#1076#1080#1088#1077#1082#1090#1086#1088#1080#1102
      TabOrder = 9
    end
    object sBtnLoadProfile: TsButton
      Left = 413
      Top = 114
      Width = 123
      Height = 25
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
      TabOrder = 13
      OnClick = sBtnLoadProfileClick
    end
  end
  object DosCmd: TDosCommand
    InputToOutput = False
    MaxTimeAfterBeginning = 0
    MaxTimeAfterLastOutput = 0
    OnNewLine = DosCmdNewLine
    OnTerminated = DosCmdTerminated
    Left = 732
    Top = 160
  end
  object sSaveDlg: TsSaveDialog
    FileName = 'NewPlotting'
    Filter = 'Bat file *.bat|*.bat|Cmd file *.cmd|*.cmd'
    Left = 652
    Top = 160
  end
  object sSkinProvider: TsSkinProvider
    AllowAnimation = False
    AddedTitle.Font.Charset = DEFAULT_CHARSET
    AddedTitle.Font.Color = clNone
    AddedTitle.Font.Height = -11
    AddedTitle.Font.Name = 'Tahoma'
    AddedTitle.Font.Style = []
    SkinData.SkinSection = 'FORM'
    TitleButtons = <>
    Left = 552
    Top = 160
  end
  object TimerProcess: TTimer
    Enabled = False
    OnTimer = TimerProcessTimer
    Left = 472
    Top = 160
  end
end
