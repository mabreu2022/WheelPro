object FRMGERARSERIAL: TFRMGERARSERIAL
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Gerar e enviar Serial'
  ClientHeight = 377
  ClientWidth = 575
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 575
    Height = 377
    ActivePage = TabSheet3
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 569
    ExplicitHeight = 368
    object TabSheet1: TTabSheet
      Caption = 'Cadastro de novo cliente'
      object Label8: TLabel
        Left = 16
        Top = 16
        Width = 63
        Height = 13
        Caption = 'Raz'#227'o social:'
      end
      object Label9: TLabel
        Left = 16
        Top = 41
        Width = 29
        Height = 13
        Caption = 'CNPJ:'
      end
      object Label10: TLabel
        Left = 16
        Top = 64
        Width = 91
        Height = 13
        Caption = 'Inscri'#231#227'o Estadual:'
      end
      object Label11: TLabel
        Left = 16
        Top = 88
        Width = 86
        Height = 13
        Caption = 'Inscri'#231#227'o Munipal:'
      end
      object Label12: TLabel
        Left = 16
        Top = 113
        Width = 49
        Height = 13
        Caption = 'Endere'#231'o:'
      end
      object Label13: TLabel
        Left = 16
        Top = 137
        Width = 29
        Height = 13
        Caption = 'Num.:'
      end
      object Label14: TLabel
        Left = 16
        Top = 161
        Width = 69
        Height = 13
        Caption = 'Complemento:'
      end
      object Label15: TLabel
        Left = 16
        Top = 185
        Width = 23
        Height = 13
        Caption = 'CEP:'
      end
      object Label16: TLabel
        Left = 246
        Top = 188
        Width = 46
        Height = 13
        Caption = 'Telefone:'
      end
      object Label17: TLabel
        Left = 16
        Top = 212
        Width = 43
        Height = 13
        Caption = 'Contato:'
      end
      object Label18: TLabel
        Left = 16
        Top = 234
        Width = 88
        Height = 13
        Caption = 'Telefone Contato:'
      end
      object Label19: TLabel
        Left = 16
        Top = 257
        Width = 43
        Height = 13
        Caption = 'Website:'
      end
      object Label20: TLabel
        Left = 16
        Top = 286
        Width = 32
        Height = 13
        Caption = 'E-mail:'
      end
      object Edit2: TEdit
        Left = 112
        Top = 13
        Width = 433
        Height = 21
        TabOrder = 0
      end
      object Edit3: TEdit
        Left = 112
        Top = 38
        Width = 433
        Height = 21
        TabOrder = 1
      end
      object Edit4: TEdit
        Left = 112
        Top = 63
        Width = 217
        Height = 21
        TabOrder = 2
      end
      object Edit5: TEdit
        Left = 112
        Top = 88
        Width = 217
        Height = 21
        TabOrder = 3
      end
      object Edit6: TEdit
        Left = 112
        Top = 113
        Width = 433
        Height = 21
        TabOrder = 4
      end
      object Edit7: TEdit
        Left = 112
        Top = 137
        Width = 73
        Height = 21
        TabOrder = 5
      end
      object Edit8: TEdit
        Left = 112
        Top = 161
        Width = 433
        Height = 21
        TabOrder = 6
      end
      object Edit9: TEdit
        Left = 112
        Top = 185
        Width = 121
        Height = 21
        TabOrder = 7
      end
      object Edit10: TEdit
        Left = 296
        Top = 185
        Width = 121
        Height = 21
        TabOrder = 8
      end
      object Edit11: TEdit
        Left = 112
        Top = 210
        Width = 433
        Height = 21
        TabOrder = 9
      end
      object Edit12: TEdit
        Left = 112
        Top = 234
        Width = 121
        Height = 21
        TabOrder = 10
      end
      object Edit13: TEdit
        Left = 112
        Top = 258
        Width = 433
        Height = 21
        TabOrder = 11
      end
      object Button2: TButton
        Left = 470
        Top = 310
        Width = 75
        Height = 25
        Caption = 'Gravar'
        TabOrder = 12
        OnClick = Button2Click
      end
      object Edit14: TEdit
        Left = 112
        Top = 283
        Width = 433
        Height = 21
        TabOrder = 13
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Gerar senha'
      ImageIndex = 1
      object Label1: TLabel
        Left = 16
        Top = 120
        Width = 120
        Height = 13
        Caption = 'O n'#250'mero serial do HD '#233':'
        Visible = False
      end
      object Label2: TLabel
        Left = 153
        Top = 120
        Width = 31
        Height = 13
        Caption = 'Label2'
        Visible = False
      end
      object Label3: TLabel
        Left = 16
        Top = 152
        Width = 97
        Height = 13
        Caption = 'E o da Bios do HD '#233':'
        Visible = False
      end
      object Label4: TLabel
        Left = 153
        Top = 152
        Width = 31
        Height = 13
        Caption = 'Label4'
        Visible = False
      end
      object Label5: TLabel
        Left = 153
        Top = 88
        Width = 26
        Height = 13
        Caption = 'Serial'
      end
      object Label6: TLabel
        Left = 16
        Top = 48
        Width = 74
        Height = 13
        Caption = 'Entre seu CNPJ'
      end
      object Label7: TLabel
        Left = 16
        Top = 88
        Width = 60
        Height = 13
        Caption = 'Seu Serial '#233':'
      end
      object Gerarserial: TButton
        Left = 380
        Top = 321
        Width = 184
        Height = 25
        Caption = 'Gerar Serial'
        Enabled = False
        TabOrder = 0
        OnClick = GerarserialClick
      end
      object Edit1: TEdit
        Left = 153
        Top = 45
        Width = 281
        Height = 21
        Enabled = False
        TabOrder = 1
        OnEnter = Edit1Enter
      end
      object Button1: TButton
        Left = 456
        Top = 43
        Width = 75
        Height = 25
        Caption = 'Pesquisar'
        Enabled = False
        TabOrder = 2
        OnClick = Button1Click
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Enviar serial'
      ImageIndex = 2
      object Memo1: TMemo
        Left = 24
        Top = 56
        Width = 417
        Height = 129
        Lines.Strings = (
          '')
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object cbtipo: TComboBox
        Left = 24
        Top = 16
        Width = 145
        Height = 21
        ItemIndex = 0
        TabOrder = 1
        Text = 'Gmail'
        Visible = False
        Items.Strings = (
          'Gmail')
      end
      object Button4: TButton
        Left = 24
        Top = 207
        Width = 75
        Height = 25
        Caption = 'Enviar Serial'
        TabOrder = 2
        OnClick = Button4Click
      end
    end
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=licencas'
      'User_Name=root'
      'Password=19741974'
      'Server=192.168.15.178'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 32
    Top = 224
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from registro')
    Left = 32
    Top = 288
    object FDQuery1id: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQuery1id_chave: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'id_chave'
      Origin = 'id_chave'
    end
    object FDQuery1chave: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'chave'
      Origin = 'chave'
      Size = 200
    end
    object FDQuery1data_inc: TDateField
      AutoGenerateValue = arDefault
      FieldName = 'data_inc'
      Origin = 'data_inc'
    end
    object FDQuery1data_exp: TDateField
      AutoGenerateValue = arDefault
      FieldName = 'data_exp'
      Origin = 'data_exp'
    end
    object FDQuery1contrasenha: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'contrasenha'
      Origin = 'contrasenha'
      Size = 200
    end
    object FDQuery1ativado: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'ativado'
      Origin = 'ativado'
      Size = 1
    end
    object FDQuery1serialhd: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'serialhd'
      Origin = 'serialhd'
      Size = 200
    end
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 128
    Top = 216
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 440
    Top = 296
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Program Files (x86)\WheelPro\libmysql.dll'
    Left = 440
    Top = 104
  end
  object FDQuery2: TFDQuery
    Connection = FDConnection2
    SQL.Strings = (
      'select * from chaves')
    Left = 424
    Top = 216
    object FDQuery2id_chave: TFDAutoIncField
      FieldName = 'id_chave'
      Origin = 'id_chave'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQuery2razao: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'razao'
      Origin = 'razao'
      Size = 200
    end
    object FDQuery2cnpj: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'cnpj'
      Origin = 'cnpj'
      Size = 18
    end
    object FDQuery2IE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'IE'
      Origin = 'IE'
      Size = 200
    end
    object FDQuery2IM: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'IM'
      Origin = 'IM'
      Size = 200
    end
    object FDQuery2ENDERECO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'ENDERECO'
      Origin = 'ENDERECO'
      Size = 255
    end
    object FDQuery2NUMERO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NUMERO'
      Origin = 'NUMERO'
      Size = 10
    end
    object FDQuery2COMPLEMENTO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'COMPLEMENTO'
      Origin = 'COMPLEMENTO'
      Size = 100
    end
    object FDQuery2CEP: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CEP'
      Origin = 'CEP'
      Size = 25
    end
    object FDQuery2TELEFONE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'TELEFONE'
      Origin = 'TELEFONE'
      Size = 25
    end
    object FDQuery2CONTATO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CONTATO'
      Origin = 'CONTATO'
      Size = 100
    end
    object FDQuery2TELCONTATO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'TELCONTATO'
      Origin = 'TELCONTATO'
      Size = 25
    end
    object FDQuery2EMAIL: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'EMAIL'
      Origin = 'EMAIL'
      Size = 100
    end
    object FDQuery2WEBSITE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'WEBSITE'
      Origin = 'WEBSITE'
      Size = 255
    end
  end
  object DataSource2: TDataSource
    DataSet = FDQuery2
    Left = 488
    Top = 216
  end
  object FDQuery3: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM CHAVES')
    Left = 244
    Top = 200
    object FDQuery3id_chave: TFDAutoIncField
      FieldName = 'id_chave'
      Origin = 'id_chave'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQuery3razao: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'razao'
      Origin = 'razao'
      Size = 200
    end
    object FDQuery3cnpj: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'cnpj'
      Origin = 'cnpj'
      Size = 18
    end
    object FDQuery3IE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'IE'
      Origin = 'IE'
      Size = 200
    end
    object FDQuery3IM: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'IM'
      Origin = 'IM'
      Size = 200
    end
    object FDQuery3ENDERECO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'ENDERECO'
      Origin = 'ENDERECO'
      Size = 255
    end
    object FDQuery3NUMERO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NUMERO'
      Origin = 'NUMERO'
      Size = 10
    end
    object FDQuery3COMPLEMENTO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'COMPLEMENTO'
      Origin = 'COMPLEMENTO'
      Size = 100
    end
    object FDQuery3CEP: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CEP'
      Origin = 'CEP'
      Size = 25
    end
    object FDQuery3TELEFONE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'TELEFONE'
      Origin = 'TELEFONE'
      Size = 25
    end
    object FDQuery3CONTATO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CONTATO'
      Origin = 'CONTATO'
      Size = 100
    end
    object FDQuery3TELCONTATO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'TELCONTATO'
      Origin = 'TELCONTATO'
      Size = 25
    end
    object FDQuery3EMAIL: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'EMAIL'
      Origin = 'EMAIL'
      Size = 100
    end
    object FDQuery3WEBSITE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'WEBSITE'
      Origin = 'WEBSITE'
      Size = 255
    end
  end
  object DataSource3: TDataSource
    DataSet = FDQuery3
    Left = 316
    Top = 200
  end
  object IdMessage1: TIdMessage
    AttachmentEncoding = 'UUE'
    BccList = <>
    CCList = <>
    Encoding = meDefault
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 368
    Top = 304
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 168
    Top = 304
  end
  object IdSMTP1: TIdSMTP
    SASLMechanisms = <>
    Left = 288
    Top = 304
  end
  object FDConnection2: TFDConnection
    Params.Strings = (
      'Database=licencas'
      'User_Name=root'
      'Password=19741974'
      'Server=192.168.15.178'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 444
    Top = 160
  end
end
