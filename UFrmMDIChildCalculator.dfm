object FrmMDIChildCalculator: TFrmMDIChildCalculator
  Left = 0
  Top = 0
  Caption = #1050#1072#1083#1100#1082#1091#1083#1103#1090#1086#1088
  ClientHeight = 448
  ClientWidth = 748
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  Icon.Data = {
    0000010001001010000001002000680400001600000028000000100000002000
    000001002000000000004004000000000000000000000000000000000000EAF4
    E623EDF5E900C8E3BD00D3E8CA19BBA8679DB49C56F3B59A58FFB69358FFAF83
    49FFAA7E47FFA57945FFA17543FF9E7242FF9E7242FF9E7242F0B497729DD8EB
    D1D9D3E8CB53C1DFB653A7D297B884BE6CFF74B75AFF7EBD64FFA3C682FFD2C8
    95FFE4C99DFFE5C798FFE5C89CFFE6CDA5FFF4E1C2FFF5E7D0FFC9C2A5FAD6E9
    CE97B9DBACFF8CC477FF57A939FF54A735FF58A939FF56A836FF56A836FF73B7
    5AFFCAE1C1FFDFC18CFFEBEBEDFFE4C89EFF0192F0FFF6E8D1FFA07647FFD8EA
    D00CCBE4C18DA6D196FF7EBD66FF5DAC41FF59AA3AFF5CAB3EFF5DAC3FFF56A8
    36FF72B759FFC6C188FFE1C191FFE6CDA9FF0092F1FFF6E9D5FF9E7242FF7CBC
    63007CBC635081BE6AFF98CA84FF94C880FF74B75AFF5FAD42FF5BAB3DFF5CAC
    3FFF57A938FF81B860FFD6E3D3FFE4CCA6FF0192F0FFF5E8D2FF9E7242FF90C6
    7C0095C9825570B656FF55A836FF6AB24EFF76B85CFF6FB555FF60AE42FF5BAB
    3DFF5CAB3EFF5AAA3AFFABCF96FFE5D0ADFFF0DDBCFFF2E3CBFF9E7242FFC3E0
    B800B8DBAB3791C67CD45BAB3DFF59AA3AFF59AA3BFF5CAC3EFF5DAC40FF5CAB
    3EFF5DAC40FF59AA3BFF6DB350FFB6B370FFEFDBB9FFF1E1C9FFA07443FFC5E1
    BA0091C77D009CCD8A3884C06ECE5FAD42FF55A836FF56A836FF55A936FF55A8
    36FF54A836FF59AA3AFF63AF46FFB1D59FFFEDD9B6FFF1E2CAFFA27644FF0000
    000094C98000A1CF9100CEE5C52FBFD09FFF96C982FF83C06AFF7DBD65FF83C0
    6BFF96C781FFB2D6A2FFD4CFA5FFDDCCA3FFDEC090FFE1C89EFFA57945FF0000
    000000000000A1CF9000EAF4E600D3B177FFE1D3AEFFECF1E2FFECF2E1FFEDF3
    E3FFF3F5EAFFFAF9F2FFFCF9F3FFFCF8F2FFFCF7F1FFE1C99FFFA77C46FF0000
    0000000000000000000000000000D1A96AFFE6D0ACFFFDFAF5FFFDF6EFFFFBF0
    E3FFFAEAD7FFF8E3CAFFF6DDBDFFF5D7B2FFFCF8F2FFE1CAA0FFAB7F47FF0000
    0000000000000000000000000000D2AB6CFFE6D1ADFFFDFAF6FFFEFAF5FFFCF4
    EBFFFBEEDFFFF9E7D2FFF7E1C5FFF6DBB9FFFCF8F3FFE2CAA1FFAE8248FF0000
    0000000000000000000000000000D2AC6EFFE6D1AEFFFDFAF5FFFEFDFBFFFDF8
    F2FFFCF2E7FFFAECDBFFF8E5CEFFF7DFC1FFFCF9F4FFE2CAA3FFB1864AFF0000
    0000000000000000000000000000D3AD70FFE5D1AFFF49B2FCFF3BADFDFF3BAD
    FDFF3BADFDFF3BADFDFF3BADFDFF3BADFDFF40AFFDFFE3CCA5FFB5894BFF0000
    0000000000000000000000000000D4AE72F0F5EEE2FFF3EAD9FFF3EADBFFF7ED
    E0FFF8F0E3FFF8EFE2FFF7EDDFFFF5EBDAFFF2E8D5FFF2E8D6FFB88D4DE10000
    0000000000000000000000000000D4AF7387D3AD71F0D2AC6EFFD1AA6AFFD0A7
    66FFCEA562FFCCA25EFFCA9F5BFFC89C57FFC49954FFC09551E1BC904E786000
    0000000000000000000000000000800000008000000080000000C0000000E000
    0000F0000000F0000000F0000000F0000000F0000000F0000000F0000000}
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object sPnlCalculator: TsPanel
    Left = 0
    Top = 0
    Width = 748
    Height = 73
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object sLabel1: TsLabel
      Left = 10
      Top = 17
      Width = 96
      Height = 13
      Caption = #1056#1072#1079#1084#1077#1088' '#1076#1080#1089#1082#1072' (Gb):'
    end
    object LblSelectDisk: TsLabel
      Left = 121
      Top = 18
      Width = 75
      Height = 13
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1076#1080#1089#1082':'
    end
    object sLblЕemplate: TsLabel
      Left = 243
      Top = 17
      Width = 77
      Height = 13
      Caption = #1064#1072#1073#1083#1086#1085' '#1076#1080#1089#1082#1072':'
    end
    object sBtnCalculate: TsButton
      Left = 573
      Top = 32
      Width = 121
      Height = 25
      Caption = #1056' '#1040' '#1057' C '#1063' '#1048' '#1058' '#1040' '#1058' '#1068
      TabOrder = 4
      OnClick = sBtnCalculateClick
    end
    object sGrBox: TsGroupBox
      Left = 342
      Top = 15
      Width = 209
      Height = 48
      Caption = #1044#1086#1087#1091#1089#1090#1080#1084#1086#1077' '#1089#1074#1086#1073#1086#1076#1085#1086#1077' '#1084#1077#1089#1090#1086' '#1076#1080#1089#1082#1072
      TabOrder = 5
      object sLblLow: TsLabel
        Left = 109
        Top = 24
        Width = 18
        Height = 13
        Caption = #1044#1086':'
      end
      object sLblHigh: TsLabel
        Left = 13
        Top = 24
        Width = 18
        Height = 13
        Caption = #1054#1090':'
      end
      object sLblGb1: TsLabel
        Left = 84
        Top = 24
        Width = 13
        Height = 13
        Caption = 'Gb'
      end
      object sLblGb2: TsLabel
        Left = 180
        Top = 24
        Width = 13
        Height = 13
        Caption = 'Gb'
      end
      object sSpEdLow: TsSpinEdit
        Left = 133
        Top = 21
        Width = 43
        Height = 21
        TabOrder = 1
        Text = '1'
        OnChange = sSpEdLowChange
        BoundLabel.ParentFont = False
        MaxValue = 7
        MinValue = 0
        Value = 1
      end
      object sSpEdHigh: TsSpinEdit
        Left = 35
        Top = 21
        Width = 43
        Height = 21
        TabOrder = 0
        Text = '5'
        OnChange = sSpEdHighChange
        BoundLabel.ParentFont = False
        MaxValue = 110
        MinValue = 1
        Value = 5
      end
    end
    object sCmBoxExSelDisk: TsComboBoxEx
      Left = 121
      Top = 37
      Width = 75
      Height = 22
      BoundLabel.ParentFont = False
      ItemsEx = <>
      Style = csExDropDownList
      ItemIndex = -1
      TabOrder = 1
      OnSelect = sCmBoxExSelDiskSelect
      Images = ImageListDrive
    end
    object sBtnUdateDriveList: TsButton
      Left = 202
      Top = 35
      Width = 25
      Height = 25
      ImageIndex = 0
      Images = FrmMain.ImageListBtn
      TabOrder = 2
      OnClick = sBtnUdateDriveListClick
    end
    object SpEdDiskSpace: TSpinEdit
      Left = 10
      Top = 36
      Width = 96
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 1863
    end
    object sCmBoxExTemplateDrive: TsComboBoxEx
      Left = 243
      Top = 36
      Width = 77
      Height = 22
      BoundLabel.ParentFont = False
      ItemsEx = <
        item
          Caption = '1 TB'
          ImageIndex = 0
          SelectedImageIndex = 0
        end
        item
          Caption = '2 TB'
          ImageIndex = 0
          SelectedImageIndex = 0
        end
        item
          Caption = '3 TB'
          ImageIndex = 0
          SelectedImageIndex = 0
        end
        item
          Caption = '4 TB'
          ImageIndex = 0
          SelectedImageIndex = 0
        end
        item
          Caption = '5 TB'
          ImageIndex = 0
          SelectedImageIndex = 0
        end
        item
          Caption = '6 TB'
          ImageIndex = 0
          SelectedImageIndex = 0
        end
        item
          Caption = '8 TB'
          ImageIndex = 0
          SelectedImageIndex = 0
        end
        item
          Caption = '10 TB'
          ImageIndex = 0
          SelectedImageIndex = 0
        end
        item
          Caption = '12 TB'
          ImageIndex = 0
          SelectedImageIndex = 0
        end
        item
          Caption = '14 TB'
          ImageIndex = 0
          SelectedImageIndex = 0
        end
        item
          Caption = '16 TB'
          ImageIndex = 0
          SelectedImageIndex = 0
        end
        item
          Caption = '18 TB'
          ImageIndex = 0
          SelectedImageIndex = 0
        end>
      ItemIndex = -1
      TabOrder = 3
      OnSelect = sCmBoxExTemplateDriveSelect
      Images = ImageListDrive
    end
  end
  object mm: TsMemo
    Left = 0
    Top = 73
    Width = 748
    Height = 375
    Align = alClient
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
    BoundLabel.Font.Charset = RUSSIAN_CHARSET
    BoundLabel.Font.Color = clBlack
    BoundLabel.Font.Height = -13
    BoundLabel.Font.Name = 'Courier New'
    BoundLabel.Font.Style = [fsBold]
  end
  object sSkinProvider: TsSkinProvider
    AddedTitle.Font.Charset = DEFAULT_CHARSET
    AddedTitle.Font.Color = clNone
    AddedTitle.Font.Height = -11
    AddedTitle.Font.Name = 'Tahoma'
    AddedTitle.Font.Style = []
    SkinData.SkinSection = 'FORM'
    TitleButtons = <>
    Left = 588
    Top = 160
  end
  object ImageListDrive: TImageList
    ColorDepth = cd32Bit
    BlendColor = clWindow
    Left = 504
    Top = 160
  end
end
