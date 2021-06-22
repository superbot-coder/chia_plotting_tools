object FrmSelectProfile: TFrmSelectProfile
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = #1055#1088#1086#1092#1080#1083#1080
  ClientHeight = 353
  ClientWidth = 394
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
  object sLblProfileName: TsLabel
    Left = 8
    Top = 21
    Width = 70
    Height = 13
    Caption = #1048#1084#1103' '#1087#1088#1086#1092#1080#1083#1103':'
  end
  object sBtnOk: TsButton
    Left = 88
    Top = 314
    Width = 217
    Height = 31
    Caption = #1057#1054#1061#1056#1040#1053#1048#1058#1068
    TabOrder = 0
    OnClick = sBtnOkClick
  end
  object sEdProfileName: TsEdit
    Left = 8
    Top = 40
    Width = 377
    Height = 21
    TabOrder = 1
    Text = 'New Profile'
  end
  object sLVProfile: TsListView
    Left = 8
    Top = 67
    Width = 378
    Height = 241
    Columns = <
      item
        Caption = #8470
        MaxWidth = 70
        MinWidth = 30
      end
      item
        AutoSize = True
        Caption = #1048#1084#1085#1072' '#1087#1088#1086#1092#1080#1083#1077#1081
      end>
    ReadOnly = True
    RowSelect = True
    PopupMenu = PopMenu
    SmallImages = FrmMain.ImageListBtn
    TabOrder = 2
    ViewStyle = vsReport
    OnClick = sLVProfileClick
  end
  object PopMenu: TPopupMenu
    Left = 184
    Top = 160
    object PM_DeleteProfile: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1087#1088#1086#1092#1080#1083#1100
      OnClick = PM_DeleteProfileClick
    end
  end
end
