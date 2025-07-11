object DM: TDM
  Height = 750
  Width = 1000
  PixelsPerInch = 120
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=fulanorodas'
      'User_Name=root'
      'Password=19741974'
      'Server=127.0.0.1'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 72
    Top = 56
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Fontes\ProjetoRodas2\Win32\Debug\libmysql.dll'
    Left = 240
    Top = 56
  end
  object FDQVeiculos: TFDQuery
    Active = True
    Connection = FDConnection1
    FormatOptions.AssignedValues = [fvDefaultParamDataType]
    SQL.Strings = (
      'SELECT * FROM VEICULOS WHERE ATIVO='#39'S'#39' ')
    Left = 64
    Top = 160
  end
  object FDQMarcas: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT IDMARCA, MARCA FROM MARCA '
      'WHERE ATIVO='#39'S'#39' '
      'ORDER BY MARCA ASC')
    Left = 64
    Top = 248
  end
  object FDQProdutos: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM PRODUTOS WHERE ATIVO='#39'S'#39)
    Left = 56
    Top = 336
  end
  object FDQFabricantes: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM FABRICANTES WHERE ATIVO='#39'S'#39)
    Left = 48
    Top = 416
  end
  object DSVeiculos: TDataSource
    DataSet = FDQVeiculos
    Left = 176
    Top = 160
  end
  object DSMarcas: TDataSource
    DataSet = FDQMarcas
    Left = 176
    Top = 248
  end
  object DSProdutos: TDataSource
    DataSet = FDQProdutos
    Left = 176
    Top = 336
  end
  object DSFabricantes: TDataSource
    DataSet = FDQFabricantes
    Left = 176
    Top = 416
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 456
    Top = 64
  end
  object DSModelos: TDataSource
    DataSet = FDQModelos
    Left = 160
    Top = 504
  end
  object FDQModelos: TFDQuery
    Connection = FDConnection1
    Left = 40
    Top = 512
  end
  object FDQCategorias: TFDQuery
    Connection = FDConnection1
    Left = 48
    Top = 600
  end
  object DSCategorias: TDataSource
    DataSet = FDQCategorias
    Left = 168
    Top = 600
  end
end
