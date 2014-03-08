object frmProperties: TfrmProperties
  Left = 848
  Top = 553
  BorderStyle = bsDialog
  Caption = 'Einstellungen'
  ClientHeight = 185
  ClientWidth = 302
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    302
    185)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 216
    Top = 14
    Width = 76
    Height = 9
    Anchors = [akLeft, akTop, akRight]
    Shape = bsTopLine
  end
  object Label1: TLabel
    Left = 32
    Top = 8
    Width = 178
    Height = 13
    Caption = 'Benachrichtigung bei Status'#228'nderung'
  end
  object Bevel2: TBevel
    Left = 8
    Top = 14
    Width = 17
    Height = 9
    Shape = bsTopLine
  end
  object Bevel3: TBevel
    Left = 88
    Top = 94
    Width = 204
    Height = 9
    Anchors = [akLeft, akTop, akRight]
    Shape = bsTopLine
  end
  object Label2: TLabel
    Left = 32
    Top = 88
    Width = 46
    Height = 13
    Caption = 'Sonstiges'
  end
  object Bevel4: TBevel
    Left = 8
    Top = 94
    Width = 17
    Height = 9
    Shape = bsTopLine
  end
  object cbBalloonNotification: TCheckBox
    Left = 24
    Top = 32
    Width = 217
    Height = 17
    Caption = '&Sprech&blase anzeigen'
    TabOrder = 0
  end
  object cbSoundNotification: TCheckBox
    Left = 24
    Top = 56
    Width = 137
    Height = 17
    Caption = '&Sound abspielen'
    TabOrder = 1
    OnClick = cbSoundNotificationClick
  end
  object btnConfigureSound: TButton
    Left = 136
    Top = 53
    Width = 137
    Height = 23
    Caption = 'Sound &konfigurieren...'
    TabOrder = 2
    OnClick = btnConfigureSoundClick
  end
  object cbAutostart: TCheckBox
    Left = 24
    Top = 112
    Width = 249
    Height = 17
    Caption = '&Automatisch mit Windows starten'
    TabOrder = 3
  end
  object btnOK: TButton
    Left = 112
    Top = 144
    Width = 83
    Height = 23
    Caption = 'OK'
    Default = True
    TabOrder = 5
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 200
    Top = 144
    Width = 83
    Height = 23
    Cancel = True
    Caption = 'Abbrechen'
    TabOrder = 6
    OnClick = btnCancelClick
  end
  object cbUseTestBackend: TCheckBox
    Left = 24
    Top = 136
    Width = 81
    Height = 17
    Caption = 'Test-BE'
    TabOrder = 4
  end
end
