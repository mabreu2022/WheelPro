unit uConfig;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Layouts,
  FMX.Objects,
  FMX.TabControl,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Effects,
  FMX.ListBox,
  FMX.Colors,
  IniFiles,
  System.UIConsts,
  FMX.Edit,
  ShellAPI,
  Winapi.Windows,
  Vcl.Dialogs,
  LogManager,
  System.IOUtils;

type
  TFrmConfig = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    TabControl1: TTabControl;
    TabItemSistema: TTabItem;
    LblTitulo: TLabel;
    ShadowEffect1: TShadowEffect;
    ShadowEffect2: TShadowEffect;
    BtnSalvar: TButton;
    ShadowEffect3: TShadowEffect;
    TabItemBancoDeDados: TTabItem;
    lblIPdoBanco: TLabel;
    Edit1: TEdit;
    lblLogin: TLabel;
    Edit2: TEdit;
    lblSenha: TLabel;
    Edit3: TEdit;
    ShadowEffect7: TShadowEffect;
    ShadowEffect8: TShadowEffect;
    ShadowEffect9: TShadowEffect;
    ShadowEffect10: TShadowEffect;
    ShadowEffect11: TShadowEffect;
    ShadowEffect12: TShadowEffect;
    GroupBoxTelaPRincipalWhatsApp: TGroupBox;
    CBWhatsApp: TCheckBox;
    GroupBoxCores: TGroupBox;
    CCBCoresDoSistema: TColorComboBox;
    ShadowEffect5: TShadowEffect;
    GroupBoxCadastroClientes: TGroupBox;
    CheckBox_CarregarTambemClientesAtivoIgualN: TCheckBox;
    ShadowEffect6: TShadowEffect;
    GroupBoxLinguagem: TGroupBox;
    CBLinguagem: TComboBox;
    ShadowEffect4: TShadowEffect;
    ShadowEffect13: TShadowEffect;
    ShadowEffect14: TShadowEffect;
    ShadowEffect15: TShadowEffect;
    ShadowEffect16: TShadowEffect;
    GBHaBilitarLogs: TGroupBox;
    CBHabilitarLogs: TCheckBox;
    ShadowEffect17: TShadowEffect;
    ShadowEffect18: TShadowEffect;
    GBCarregarClientesSemContato: TGroupBox;
    CBCarregarClientesSemContato: TCheckBox;
    ShadowEffect19: TShadowEffect;
    ShadowEffect20: TShadowEffect;
    ShadowEffect21: TShadowEffect;
    CBGravarLogsBanco: TCheckBox;
    ShadowEffect22: TShadowEffect;
    GroupBox1: TGroupBox;
    Button1: TButton;
    procedure BtnSalvarClick(Sender: TObject);
    procedure CCBCoresDoSistemaChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FCorMudou: Boolean;
    FLinguagem: string;
    procedure SetLinguagem(const Value: string);
  public
    { Public declarations }
    property Linguagem: string read FLinguagem write SetLinguagem;
    procedure SalvarLinguagem;
    procedure CarregarLinguagem;
    procedure SalvarCores;
    procedure CarregarCores;
    procedure SalvarConfiguracao;
    procedure CarregarConfiguracao;
    procedure HabilitarLogs;
    function ColorToHexString(Color: TAlphaColor): string;
  end;

var
  FrmConfig: TFrmConfig;

implementation

{$R *.fmx}

procedure TFrmConfig.BtnSalvarClick(Sender: TObject);
var
  AppPath: string;
  Confirmation: Integer;
begin

  // Salve o caminho completo do aplicativo atual
  AppPath := ParamStr(0);

  // Exiba uma caixa de diálogo de confirmação
  Confirmation := MessageDlg('Deseja aplicar as novs configurações (O aplicativo será finalizado e reiniciado)?', mtConfirmation, [mbYes, mbNo], 0);

  // Verifique a resposta do usuário
  if Confirmation = mrYes then
  begin
    //SalvarConfiguracao
    SalvarConfiguracao;

    //Salvar a Linguagem
    SalvarLinguagem;

    //Chamar a procedure de gravação
    SalvarCores;

    //Habilitar Logs
    HabilitarLogs;

    // Encerre a aplicação atual
    Application.Terminate;

    // Execute o aplicativo novamente
    ShellExecute(0, 'open', PChar(AppPath), nil, nil, SW_SHOW);
  end;
end;

procedure TFrmConfig.Button1Click(Sender: TObject);
var
  IniFile: TIniFile;
  OpenDialog: TOpenDialog;
  ArquivoDaLogo: String;
  NovoNomeArquivo: String;
  DiretorioDestino: String;
begin
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\Config.ini');
  OpenDialog := TOpenDialog.Create(Self);
  try
    if OpenDialog.Execute then
    begin
      ArquivoDaLogo := OpenDialog.FileName;
      NovoNomeArquivo := ExtractFilePath(ParamStr(0)) + 'Logo.png';
      DiretorioDestino := ExtractFilePath(NovoNomeArquivo);

      // Verifica se o diretório de destino existe, se não, cria-o
      if not DirectoryExists(DiretorioDestino) then
        ForceDirectories(DiretorioDestino);

      // Verifica se o arquivo "Logo.png" já existe, se sim, exclui-o
      if FileExists(NovoNomeArquivo) then
        DeleteFile(Pchar(NovoNomeArquivo));

      // Copia o arquivo para o diretório da aplicação
      CopyFile(PChar(ArquivoDaLogo), PChar(NovoNomeArquivo), False);

      // Atualiza o valor no arquivo de configuração
      IniFile.WriteString('Sistema', 'ArquivoLogo', NovoNomeArquivo);
      IniFile.UpdateFile;

      ShowMessage('Arquivo copiado com sucesso!');
    end;
  finally
    IniFile.Free;
    OpenDialog.Free;
  end;

end;

procedure TFrmConfig.CarregarConfiguracao;
var
  IniFile: TIniFile;
  Valor, Valor2, Valor3, Valor4, Valor5: string;
begin
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\Config.ini');
  try
    Valor  := IniFile.ReadString('Sistema', 'carregaclientesativosn', '');
    Valor2 := IniFile.ReadString('WhatsApp', 'EnviaParaContatoEspecifico', '');
    Valor3 := IniFile.ReadString('HabilitarLogs', 'HabilitarLogsSistema', '');
    Valor4 := IniFile.ReadString('Sistema', 'CarregarClientesSemContato', '');
    Valor5 := IniFile.ReadString('Sistema', 'SalvarLogsBancoDeDados', '');
    // Carregar valor do Config.ini para o CheckBox
    CheckBox_CarregarTambemClientesAtivoIgualN.IsChecked := (Valor = 'S');
    CBWhatsApp.IsChecked         := (Valor2 = 'S');
    CBHabilitarLogs.IsChecked    := (Valor3 = 'S');
    CBCarregarClientesSemContato.IsChecked := (Valor4 = 'S');
    CBGravarLogsBanco.IsChecked  := (Valor5 = 'S');
    // Use a instância FModel de TModelCliente conforme necessário...
  finally
    IniFile.Free;
  end;

end;

procedure TFrmConfig.CarregarCores;
var
  IniFile: TIniFile;
  Cor: TAlphaColor;

begin
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\Config.ini');
  try
    Cor := StringToAlphaColor(IniFile.ReadString('Cores', 'Cor', ''));
    CCBCoresDoSistema.Color:=cor;
  finally
    IniFile.UpdateFile;
    IniFile.Free;
  end;

  for var I := 0 to FrmConfig.ComponentCount - 1 do
  begin
    if FrmConfig.Components[I] is TRectangle then
      TRectangle(FrmConfig.Components[I]).Fill.Color := Cor;
  end;

end;

procedure TFrmConfig.CarregarLinguagem;
var
  IniFile: TIniFile;
  I: Integer;
begin
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\Config.ini');
  try
    FLinguagem :=IniFile.ReadString('Traducao', 'Linguagem', '');

     // Percorre os itens do combobox e define o índice correspondente
    for I := 0 to CBLinguagem.Items.Count - 1 do
    begin
      if CBLinguagem.Items[I] = FLinguagem then
      begin
        CBLinguagem.ItemIndex := I;
        Break;
      end;
    end;

   if FLinguagem = 'Portuguese' then
   begin
     GroupBoxCadastroClientes.Text                   := 'Cadastro de Clientes';
     CheckBox_CarregarTambemClientesAtivoIgualN.Text := 'Carregar também Clientes Aitvos = N';
     GroupBoxTelaPRincipalWhatsApp.Text              := 'Tela  Principal WhatsApp';
     CBWhatsApp.Text                                 := 'Enviar para contato único';
     GroupBoxLinguagem.Text                          := 'Linguagem';
     GroupBoxCores.Text                              := 'Cores';
     BtnSalvar.Text                                  := '&Salvar';
     TabItemSistema.Text                             := 'Sistema';
     TabItemBancoDeDados.Text                        := 'Banco de Dados';
     LblTitulo.Text                                  := 'Configurações do Sistema';
     FrmConfig.Caption                               := 'Configurações do Sistema';
     GBHaBilitarLogs.Text                            := 'Habilitar Logs';
     CBGravarLogsBanco.Text                          := 'Gravar logs no banco de dados';
     CBHabilitarLogs.Text                            := 'Sim (Salvar no HD)';
   end
   else if FLinguagem = 'Ingles' then
   begin
     GroupBoxCadastroClientes.Text                   := 'Customer Registration';
     CheckBox_CarregarTambemClientesAtivoIgualN.Text := 'Also Load Active Clients = N';
     GroupBoxTelaPRincipalWhatsApp.Text              := 'WhatsApp Main Screen';
     CBWhatsApp.Text                                 := 'Send to single contact';
     GroupBoxLinguagem.Text                          := 'Language';
     GroupBoxCores.Text                              := 'Colors';
     BtnSalvar.Text                                  := '&Save';
     TabItemSistema.Text                             := 'System';
     TabItemBancoDeDados.Text                        := 'DataBase';
     LblTitulo.Text                                  := 'System Settings';
     FrmConfig.Caption                               := 'System Settings';
     GBHaBilitarLogs.Text                            := 'Enable Logss';
     CBGravarLogsBanco.Text                          := 'Write logs to the database';
     CBHabilitarLogs.Text                            := 'Yes (Save to HD)';
   end;

  finally
    IniFile.Free;
  end;

end;

procedure TFrmConfig.CCBCoresDoSistemaChange(Sender: TObject);
begin
  FCorMudou:= True;
end;

function TFrmConfig.ColorToHexString(Color: TAlphaColor): string;
begin
  Result := '$' + IntToHex(Color, 8);
end;

procedure TFrmConfig.FormCreate(Sender: TObject);
begin
  CarregarCores;
  CarregarLinguagem;
  CarregarConfiguracao;
end;

procedure TFrmConfig.FormShow(Sender: TObject);
begin
  TabControl1.TabIndex:=0;
end;

procedure TFrmConfig.HabilitarLogs;
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\Config.ini');
  try
     if CBHabilitarLogs.IsChecked  then
       IniFile.WriteString('HabilitarLogs', 'HabilitarLogsSistema', 'S')
     else
       IniFile.WriteString('HabilitarLogs', 'HabilitarLogsSistema', 'N');
  finally
     IniFile.Free;
  end;

end;

procedure TFrmConfig.SalvarConfiguracao;
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\Config.ini');
  try
     if CBWhatsApp.IsChecked  then
       IniFile.WriteString('WhatsApp', 'EnviaParaContatoEspecifico', 'S')
     else
       IniFile.WriteString('WhatsApp', 'EnviaParaContatoEspecifico', 'N');

     if CBCarregarClientesSemContato.IsChecked then
       IniFile.WriteString('Sistema','CarregarClientesSemContato' , 'S')
     else
       IniFile.WriteString('Sistema','CarregarClientesSemContato' , 'N');

     if CBGravarLogsBanco.IsChecked then
       IniFile.WriteString('Sistema','SalvarLogsBancoDeDados' , 'S')
     else
       IniFile.WriteString('Sistema','SalvarLogsBancoDeDados' , 'N');


  finally
    IniFile.Free;
  end;
end;

procedure TFrmConfig.SalvarCores;
var
  IniFile: TIniFile;
  CorEscolhida: TAlphaColor;
  ColorString: string;
begin
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\Config.ini');
  try
    if FCorMudou then
    begin
      CorEscolhida := CCBCoresDoSistema.Color;
      ColorString  := ColorToHexString(CorEscolhida);
      IniFile.WriteString('Cores', 'Cor', ColorString);
    end;

    if CBWhatsApp.IsChecked  then
      IniFile.WriteString('WhatsApp', 'EnviaParaContatoEspecifico', 'S')
    else
      IniFile.WriteString('WhatsApp', 'EnviaParaContatoEspecifico', 'N');

    if CheckBox_CarregarTambemClientesAtivoIgualN.IsChecked then
      IniFile.WriteString('Sistema', 'carregaclientesativosn', 'S')
    else
      IniFile.WriteString('Sistema', 'carregaclientesativosn', 'N');

  finally
    IniFile.Free;
  end;

end;

procedure TFrmConfig.SalvarLinguagem;
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\Config.ini');
  try
  if CBLinguagem.ItemIndex <> -1 then
     Linguagem := CBLinguagem.Items[CBLinguagem.ItemIndex];

    IniFile.WriteString('Traducao', 'Linguagem', Linguagem);
  finally
    IniFile.Free;
  end;
end;

procedure TFrmConfig.SetLinguagem(const Value: string);
begin
  FLinguagem := Value;
end;

end.

