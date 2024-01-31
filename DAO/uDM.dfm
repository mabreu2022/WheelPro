object DM: TDM
  Height = 750
  Width = 1000
  PixelsPerInch = 120
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=fulanorodas'
      'User_Name=root'
      'Password=19741974'
      'Server=localhost'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 72
    Top = 56
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    DriverID = 'MySQL'
    VendorLib = 'C:\Program Files (x86)\WheelPro\libmysql.dll'
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
    Active = True
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
  object CDS_Permissoes: TClientDataSet
    PersistDataPacket.Data = {
      AA0000009619E0BD010000001800000006000000000003000000AA000C696470
      65726D6973736F657304000100000000000969647573756172696F0400010000
      0000000669644D656E750400010000000000097065726D697469646F01004900
      00000100055749445448020002000100077573756172696F0100490000000100
      0557494454480200020064000B63617074696F6E6D656E750100490000000100
      0557494454480200020064000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 296
    Top = 176
    object CDS_Permissoesidpermissoes: TIntegerField
      FieldName = 'idpermissoes'
    end
    object CDS_Permissoesidusuario: TIntegerField
      FieldName = 'idusuario'
    end
    object CDS_PermissoesidMenu: TIntegerField
      FieldName = 'idMenu'
    end
    object CDS_Permissoespermitido: TStringField
      FieldName = 'permitido'
      Size = 1
    end
    object CDS_Permissoesusuario: TStringField
      FieldName = 'usuario'
      Size = 100
    end
    object CDS_Permissoescaptionmenu: TStringField
      FieldName = 'captionmenu'
      Size = 100
    end
    object CDS_Permissoestipo: TStringField
      FieldKind = fkCalculated
      FieldName = 'tipo'
      Size = 1
      Calculated = True
    end
  end
  object DS_Permissoes: TDataSource
    DataSet = CDS_Permissoes
    Left = 432
    Top = 176
  end
end
