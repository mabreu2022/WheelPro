object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Encriptografar Arquivos Ini '
  ClientHeight = 253
  ClientWidth = 479
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 479
    Height = 212
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 418
    ExplicitHeight = 282
    object TabSheet1: TTabSheet
      Caption = 'Dados'
      object GroupBox3: TGroupBox
        Left = 8
        Top = 0
        Width = 225
        Height = 173
        Caption = 'Banco'
        TabOrder = 0
        object Label1: TLabel
          Left = 14
          Top = 26
          Width = 32
          Height = 15
          Caption = 'Server'
        end
        object Label2: TLabel
          Left = 14
          Top = 56
          Width = 48
          Height = 15
          Caption = 'DataBase'
        end
        object Label3: TLabel
          Left = 14
          Top = 90
          Width = 58
          Height = 15
          Caption = 'User Name'
        end
        object Label4: TLabel
          Left = 14
          Top = 125
          Width = 52
          Height = 15
          Caption = 'PassWord'
        end
        object EdtDadosBancoServer: TEdit
          Left = 82
          Top = 25
          Width = 121
          Height = 23
          TabOrder = 0
          TextHint = '187.75.162.220'
        end
        object EdtDadosBancoDataBase: TEdit
          Left = 82
          Top = 54
          Width = 121
          Height = 23
          TabOrder = 1
          TextHint = 'fulanorodas'
        end
        object EdtDadosBancoUserName: TEdit
          Left = 82
          Top = 86
          Width = 121
          Height = 23
          TabOrder = 2
          TextHint = 'root'
        end
        object EdtDadosBancoPassword: TEdit
          Left = 82
          Top = 121
          Width = 121
          Height = 23
          TabOrder = 3
          TextHint = '19741974'
        end
      end
      object GroupBox4: TGroupBox
        Left = 239
        Top = 1
        Width = 225
        Height = 173
        Caption = 'Banco Licen'#231'as'
        TabOrder = 1
        object Label12: TLabel
          Left = 14
          Top = 27
          Width = 32
          Height = 15
          Caption = 'Server'
        end
        object Label13: TLabel
          Left = 14
          Top = 56
          Width = 48
          Height = 15
          Caption = 'DataBase'
        end
        object Label14: TLabel
          Left = 14
          Top = 90
          Width = 58
          Height = 15
          Caption = 'User Name'
        end
        object Label16: TLabel
          Left = 14
          Top = 125
          Width = 52
          Height = 15
          Caption = 'PassWord'
        end
        object EdtDadosLicenasServer: TEdit
          Left = 82
          Top = 25
          Width = 121
          Height = 23
          TabOrder = 0
          TextHint = '187.75.162.220'
        end
        object EdtDadosLicenasDataBase: TEdit
          Left = 82
          Top = 54
          Width = 121
          Height = 23
          TabOrder = 1
          TextHint = 'licencas'
        end
        object EdtDadosLicencasUserName: TEdit
          Left = 82
          Top = 86
          Width = 121
          Height = 23
          TabOrder = 2
          TextHint = 'root'
        end
        object EdtDadosLicencasPassword: TEdit
          Left = 82
          Top = 121
          Width = 121
          Height = 23
          TabOrder = 3
          TextHint = '19741974'
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Dados Encryptados'
      ImageIndex = 1
      object GroupBox1: TGroupBox
        Left = 9
        Top = 0
        Width = 225
        Height = 173
        Caption = 'Banco'
        TabOrder = 0
        object Label5: TLabel
          Left = 14
          Top = 26
          Width = 32
          Height = 15
          Caption = 'Server'
        end
        object Label6: TLabel
          Left = 14
          Top = 56
          Width = 48
          Height = 15
          Caption = 'DataBase'
        end
        object Label7: TLabel
          Left = 14
          Top = 90
          Width = 58
          Height = 15
          Caption = 'User Name'
        end
        object Label8: TLabel
          Left = 14
          Top = 125
          Width = 52
          Height = 15
          Caption = 'PassWord'
        end
        object EdtEncryptadosBancoServer: TEdit
          Left = 82
          Top = 25
          Width = 121
          Height = 23
          TabOrder = 0
          TextHint = '187.75.162.220'
        end
        object EdtEncryptadosBancoDataBase: TEdit
          Left = 82
          Top = 54
          Width = 121
          Height = 23
          TabOrder = 1
          TextHint = 'fulanorodas'
        end
        object EdtEncryptadosBancoUserName: TEdit
          Left = 82
          Top = 86
          Width = 121
          Height = 23
          TabOrder = 2
          TextHint = 'root'
        end
        object EdtEncryptadosBancoPassword: TEdit
          Left = 82
          Top = 121
          Width = 121
          Height = 23
          TabOrder = 3
          TextHint = '19741974'
        end
      end
      object GroupBox2: TGroupBox
        Left = 240
        Top = 0
        Width = 225
        Height = 173
        Caption = 'Banco Licen'#231'as'
        TabOrder = 1
        object Label9: TLabel
          Left = 14
          Top = 27
          Width = 32
          Height = 15
          Caption = 'Server'
        end
        object Label10: TLabel
          Left = 14
          Top = 56
          Width = 48
          Height = 15
          Caption = 'DataBase'
        end
        object Label11: TLabel
          Left = 14
          Top = 90
          Width = 58
          Height = 15
          Caption = 'User Name'
        end
        object Label15: TLabel
          Left = 14
          Top = 125
          Width = 52
          Height = 15
          Caption = 'PassWord'
        end
        object EdtEncryptadosBancoLicencasServer: TEdit
          Left = 82
          Top = 25
          Width = 121
          Height = 23
          TabOrder = 0
          TextHint = '187.75.162.220'
        end
        object EdtEncryptadosBancoLicencasDataBase: TEdit
          Left = 82
          Top = 54
          Width = 121
          Height = 23
          TabOrder = 1
          TextHint = 'licencas'
        end
        object EdtEncryptadosBancoLicencasUserName: TEdit
          Left = 82
          Top = 86
          Width = 121
          Height = 23
          TabOrder = 2
          TextHint = 'root'
        end
        object EdtEncryptadosBancoLicencasPassword: TEdit
          Left = 82
          Top = 121
          Width = 121
          Height = 23
          TabOrder = 3
          TextHint = '19741974'
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 212
    Width = 479
    Height = 41
    Align = alBottom
    Color = clMoneyGreen
    ParentBackground = False
    TabOrder = 1
    ExplicitTop = 282
    ExplicitWidth = 418
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
