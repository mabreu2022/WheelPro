object FRMGerarContraSenha: TFRMGerarContraSenha
  Left = 0
  Top = 0
  Caption = 'Gerar Contra-Senha'
  ClientHeight = 372
  ClientWidth = 609
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 19
    Width = 89
    Height = 13
    Caption = 'Entre com a chave'
  end
  object Label2: TLabel
    Left = 16
    Top = 67
    Width = 70
    Height = 13
    Caption = 'Contra-senha:'
  end
  object Label3: TLabel
    Left = 120
    Top = 67
    Width = 64
    Height = 13
    Caption = 'contra-senha'
  end
  object Label4: TLabel
    Left = 16
    Top = 290
    Width = 116
    Height = 13
    Caption = 'Contra-Senha do cliente'
  end
  object Label5: TLabel
    Left = 16
    Top = 48
    Width = 37
    Height = 13
    Caption = 'Cliente:'
  end
  object Label6: TLabel
    Left = 120
    Top = 48
    Width = 31
    Height = 13
    Caption = 'Label6'
  end
  object Label7: TLabel
    Left = 16
    Top = 95
    Width = 152
    Height = 13
    Caption = 'Selecione a data de vencimento'
  end
  object Edit1: TEdit
    Left = 120
    Top = 16
    Width = 289
    Height = 21
    TabOrder = 0
  end
  object Button1: TButton
    Left = 424
    Top = 8
    Width = 177
    Height = 25
    Caption = 'Pesquisar/Gerar Contra-Senha'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 16
    Top = 309
    Width = 585
    Height = 55
    Lines.Strings = (
      '')
    TabOrder = 2
  end
  object EdtData: TEdit
    Left = 247
    Top = 253
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object MonthCalendar1: TMonthCalendar
    Left = 16
    Top = 114
    Width = 225
    Height = 160
    Date = 42151.000000000000000000
    TabOrder = 4
    OnClick = MonthCalendar1Click
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=licencas'
      'User_Name=root'
      'Password=19741974'
      'Server=127.0.0.1'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 280
    Top = 56
  end
  object FDQuery1: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      'select * from registro')
    Left = 352
    Top = 56
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
    Left = 408
    Top = 56
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Program Files (x86)\MySQL\MySQL Server 5.7\lib\libmysql.dll'
    Left = 552
    Top = 112
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 408
    Top = 112
  end
  object FDQuery2: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      
        'select razao from chaves,registro where chaves.id_chave= registr' +
        'o.id_chave')
    Left = 488
    Top = 56
    object FDQuery2razao: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'razao'
      Origin = 'razao'
      Size = 200
    end
  end
  object DataSource2: TDataSource
    DataSet = FDQuery2
    Left = 560
    Top = 56
  end
end
