object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Encriptografar Arquivos Ini'
  ClientHeight = 323
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 418
    Height = 282
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Dados'
      object Label1: TLabel
        Left = 8
        Top = 18
        Width = 32
        Height = 15
        Caption = 'Server'
      end
      object Label2: TLabel
        Left = 8
        Top = 48
        Width = 48
        Height = 15
        Caption = 'DataBase'
      end
      object Label3: TLabel
        Left = 8
        Top = 80
        Width = 58
        Height = 15
        Caption = 'User Name'
      end
      object Label4: TLabel
        Left = 8
        Top = 117
        Width = 52
        Height = 15
        Caption = 'PassWord'
      end
      object EdtServer: TEdit
        Left = 74
        Top = 17
        Width = 121
        Height = 23
        TabOrder = 0
        TextHint = '187.75.162.220'
      end
      object EdtDataBase: TEdit
        Left = 74
        Top = 49
        Width = 121
        Height = 23
        TabOrder = 1
        TextHint = 'fulanorodas'
      end
      object EdtUserName: TEdit
        Left = 74
        Top = 81
        Width = 121
        Height = 23
        TabOrder = 2
        TextHint = 'root'
      end
      object EdtPassword: TEdit
        Left = 74
        Top = 113
        Width = 121
        Height = 23
        TabOrder = 3
        TextHint = '19741974'
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Dados Encryptados'
      ImageIndex = 1
      object Label5: TLabel
        Left = 16
        Top = 26
        Width = 32
        Height = 15
        Caption = 'Server'
      end
      object Label6: TLabel
        Left = 16
        Top = 56
        Width = 48
        Height = 15
        Caption = 'DataBase'
      end
      object Label7: TLabel
        Left = 16
        Top = 88
        Width = 58
        Height = 15
        Caption = 'User Name'
      end
      object Label8: TLabel
        Left = 16
        Top = 125
        Width = 52
        Height = 15
        Caption = 'PassWord'
      end
      object Edt1: TEdit
        Left = 82
        Top = 25
        Width = 121
        Height = 23
        TabOrder = 0
        TextHint = '187.75.162.220'
      end
      object Edt2: TEdit
        Left = 82
        Top = 57
        Width = 121
        Height = 23
        TabOrder = 1
        TextHint = 'fulanorodas'
      end
      object Edt3: TEdit
        Left = 82
        Top = 89
        Width = 121
        Height = 23
        TabOrder = 2
        TextHint = 'root'
      end
      object Edt4: TEdit
        Left = 82
        Top = 121
        Width = 121
        Height = 23
        TabOrder = 3
        TextHint = '19741974'
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 282
    Width = 418
    Height = 41
    Align = alBottom
    TabOrder = 1
    ExplicitLeft = 184
    ExplicitTop = 376
    ExplicitWidth = 185
    object BtnEncriptar: TButton
      Left = 24
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Enncriptar'
      TabOrder = 0
      OnClick = BtnEncriptarClick
    end
    object BtnDesincriptar: TButton
      Left = 112
      Top = 8
      Width = 105
      Height = 25
      Caption = 'Desencriptar'
      TabOrder = 1
      OnClick = BtnDesincriptarClick
    end
  end
end
