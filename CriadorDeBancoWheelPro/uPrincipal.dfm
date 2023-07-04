object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Criador de Banco de Dados do Wheel Pro'
  ClientHeight = 467
  ClientWidth = 892
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object Label1: TLabel
    Left = 16
    Top = 32
    Width = 128
    Height = 15
    Caption = 'Nome da Base de Dados'
  end
  object Label2: TLabel
    Left = 456
    Top = 32
    Width = 34
    Height = 15
    Caption = 'e-mail'
  end
  object Edit1: TEdit
    Left = 160
    Top = 29
    Width = 289
    Height = 23
    TabOrder = 0
    TextHint = 'Insira Nome da Base de Dados sem espa'#231'o e acentos'
  end
  object Panel1: TPanel
    Left = 0
    Top = 426
    Width = 892
    Height = 41
    Align = alBottom
    Color = clMoneyGreen
    ParentBackground = False
    TabOrder = 1
    object Button1: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Criar Base'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 96
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Gerar Setup'
      TabOrder = 1
      OnClick = Button2Click
    end
    object CBRemoto: TCheckBox
      Left = 184
      Top = 13
      Width = 65
      Height = 17
      Caption = 'Remoto?'
      TabOrder = 2
    end
    object cbDemo: TCheckBox
      Left = 262
      Top = 13
      Width = 137
      Height = 17
      Caption = #201' para demostra'#231#227'o?'
      TabOrder = 3
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 64
    Width = 892
    Height = 362
    Align = alBottom
    Lines.Strings = (
      '')
    TabOrder = 2
  end
  object Edit2: TEdit
    Left = 504
    Top = 29
    Width = 369
    Height = 23
    TabOrder = 3
    TextHint = 'Insira e-mail do respons'#225'vel'
  end
  object FDConnection1: TFDConnection
    Left = 592
    Top = 128
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 592
    Top = 208
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Fontes\ProjetoRodas3\CriadorDeBancoWheelPro\dll\libmysql.dll'
    Left = 720
    Top = 128
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 712
    Top = 192
  end
  object DataSource1: TDataSource
    Left = 584
    Top = 280
  end
end
