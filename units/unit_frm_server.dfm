object frm_server: Tfrm_server
  Left = 0
  Top = 0
  Caption = 'Server Configuration'
  ClientHeight = 234
  ClientWidth = 249
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    249
    234)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 62
    Height = 13
    Caption = 'Server IP(s):'
  end
  object Label2: TLabel
    Left = 8
    Top = 146
    Width = 24
    Height = 13
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Port:'
  end
  object listBox_localIPs: TListBox
    Left = 8
    Top = 27
    Width = 161
    Height = 110
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 13
    TabOrder = 0
  end
  object Refresh: TButton
    Left = 175
    Top = 27
    Width = 65
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Refresh'
    TabOrder = 1
    OnClick = getLocalIPs
  end
  object edit_port: TEdit
    Left = 105
    Top = 143
    Width = 64
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    NumbersOnly = True
    TabOrder = 2
    Text = '57756'
  end
  object Button1: TButton
    Left = 128
    Top = 170
    Width = 112
    Height = 33
    Anchors = [akRight, akBottom]
    Caption = '&Start Server'
    Default = True
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 170
    Width = 112
    Height = 33
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'S&top Server'
    TabOrder = 4
    OnClick = Button2Click
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 216
    Width = 249
    Height = 18
    Panels = <>
  end
end
