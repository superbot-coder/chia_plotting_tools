object FrmUpdate: TFrmUpdate
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = #1054#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
  ClientHeight = 361
  ClientWidth = 573
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object sLblInfo: TsLabel
    Left = 8
    Top = 86
    Width = 120
    Height = 13
    Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086#1073' '#1074#1077#1088#1089#1080#1080':'
  end
  object sLblAuthor: TsLabel
    Left = 16
    Top = 8
    Width = 90
    Height = 13
    Caption = #1040#1074#1090#1086#1088': SUPERBOT'
  end
  object sLblResource: TsLabel
    Left = 16
    Top = 31
    Width = 38
    Height = 13
    Caption = #1056#1077#1089#1091#1088#1089':'
  end
  object sLblResourceLink: TsLabel
    Left = 79
    Top = 31
    Width = 262
    Height = 13
    Caption = 'https://github.com/superbot-coder/chia_plotting_tools'
  end
  object sLblLoadStatus: TsLabel
    Left = 16
    Top = 54
    Width = 75
    Height = 13
    Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077':'
  end
  object sLV: TsListView
    Left = 8
    Top = 200
    Width = 558
    Height = 113
    Columns = <
      item
        Caption = #8470
        MaxWidth = 70
        MinWidth = 30
      end
      item
        AutoSize = True
        Caption = #1060#1072#1081#1083#1099
      end>
    TabOrder = 0
    ViewStyle = vsReport
  end
  object mmInfo: TsMemo
    Left = 7
    Top = 105
    Width = 558
    Height = 89
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object sBtnDownload: TsButton
    Left = 216
    Top = 326
    Width = 137
    Height = 25
    Caption = #1047#1040#1043#1056#1059#1047#1048#1058#1068
    TabOrder = 2
  end
  object sBtnDownloadTest: TsButton
    Left = 312
    Top = 74
    Width = 145
    Height = 25
    Caption = 'DownloadTest'
    TabOrder = 3
    OnClick = sBtnDownloadTestClick
  end
  object sSkinProvider: TsSkinProvider
    AddedTitle.Font.Charset = DEFAULT_CHARSET
    AddedTitle.Font.Color = clNone
    AddedTitle.Font.Height = -11
    AddedTitle.Font.Name = 'Tahoma'
    AddedTitle.Font.Style = []
    SkinData.SkinSection = 'FORM'
    TitleButtons = <>
    Left = 504
    Top = 24
  end
  object IdHTTP: TIdHTTP
    IOHandler = IdSSLIOHandlerSocketOpenSSL
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 456
    Top = 216
  end
  object IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 312
    Top = 216
  end
end
