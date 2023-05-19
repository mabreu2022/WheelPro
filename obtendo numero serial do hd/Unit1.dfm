object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Gerar Serial'
  ClientHeight = 214
  ClientWidth = 544
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
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
    Left = 347
    Top = 181
    Width = 184
    Height = 25
    Caption = 'Gerar Serial'
    TabOrder = 0
    OnClick = GerarserialClick
  end
  object Edit1: TEdit
    Left = 153
    Top = 45
    Width = 281
    Height = 21
    TabOrder = 1
    OnEnter = Edit1Enter
  end
  object Button1: TButton
    Left = 456
    Top = 43
    Width = 75
    Height = 25
    Caption = 'Pesquisar'
    TabOrder = 2
    OnClick = Button1Click
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=fred'
      'User_Name=fred'
      'Password=2015'
      'Server=192.168.25.213'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 232
    Top = 72
  end
  object FDQuery1: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      'select * from registro')
    Left = 288
    Top = 72
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
    Left = 352
    Top = 72
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 352
    Top = 120
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Program Files (x86)\MySQL\MySQL Server 5.6\lib\libmysql.dll'
    Left = 232
    Top = 120
  end
  object FDQuery2: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from chaves')
    Left = 424
    Top = 80
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
  end
  object DataSource2: TDataSource
    DataSet = FDQuery2
    Left = 480
    Top = 80
  end
end
