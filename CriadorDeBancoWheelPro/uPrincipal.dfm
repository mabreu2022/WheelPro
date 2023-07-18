object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Criador de Banco de Dados do Wheel Pro'
  ClientHeight = 531
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
    Top = 490
    Width = 892
    Height = 41
    Align = alBottom
    Color = clMoneyGreen
    ParentBackground = False
    TabOrder = 2
    object Button1: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Criar Base'
      TabOrder = 3
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 96
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Gerar Setup'
      TabOrder = 0
      OnClick = Button2Click
    end
    object CBRemoto: TCheckBox
      Left = 184
      Top = 13
      Width = 65
      Height = 17
      Caption = 'Remoto?'
      TabOrder = 1
    end
    object cbDemo: TCheckBox
      Left = 262
      Top = 13
      Width = 137
      Height = 17
      Caption = #201' para demostra'#231#227'o?'
      TabOrder = 2
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 199
    Width = 892
    Height = 291
    Align = alBottom
    Lines.Strings = (
      '')
    TabOrder = 3
  end
  object Edit2: TEdit
    Left = 504
    Top = 29
    Width = 369
    Height = 23
    TabOrder = 1
    TextHint = 'Insira e-mail do respons'#225'vel'
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 56
    Width = 361
    Height = 137
    Caption = 'Dados de acesso ao Banco de dados'
    TabOrder = 4
    object Label3: TLabel
      Left = 17
      Top = 26
      Width = 31
      Height = 15
      Caption = 'Driver'
    end
    object Label5: TLabel
      Left = 225
      Top = 26
      Width = 40
      Height = 15
      Caption = 'Usu'#225'rio'
    end
    object Label4: TLabel
      Left = 16
      Top = 80
      Width = 102
      Height = 15
      Caption = 'Endere'#231'o do Banco'
    end
    object Label6: TLabel
      Left = 225
      Top = 80
      Width = 32
      Height = 15
      Caption = 'Senha'
    end
    object ComboBox1: TComboBox
      Left = 16
      Top = 46
      Width = 190
      Height = 23
      ItemIndex = 0
      TabOrder = 0
      Text = 'MySQL'
      Items.Strings = (
        'MySQL'
        'FB')
    end
    object Edit4: TEdit
      Left = 224
      Top = 49
      Width = 121
      Height = 23
      TabOrder = 1
    end
    object Edit3: TEdit
      Left = 16
      Top = 98
      Width = 190
      Height = 23
      TabOrder = 2
    end
    object Edit5: TEdit
      Left = 224
      Top = 98
      Width = 121
      Height = 23
      TabOrder = 3
    end
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
