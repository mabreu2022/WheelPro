unit Login;

interface

uses
  LogManager,
  UPrincipal,
  URegistrar,
  Dao.Conexao,
  Dao.Login,
  Data.DB,
  FMX.Controls,
  FMX.Controls.Presentation,
  FMX.Dialogs,
  FMX.Edit,
  FMX.Effects,
  FMX.Forms,
  FMX.Graphics,
  FMX.Layouts,
  FMX.Objects,
  FMX.StdCtrls,
  FMX.Types,
  FireDAC.Comp.Client,
  FireDAC.Comp.UI,
  FireDAC.Phys,
  FireDAC.Phys.Intf,
  FireDAC.Phys.PG,
  FireDAC.Phys.PGDef,
  FireDAC.Stan.Async,
  FireDAC.Stan.Def,
  FireDAC.Stan.Error,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Pool,
  FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait,
  Model.Registro,
  System.Classes,
  System.IniFiles,
  System.SysUtils,
  System.Types,
  System.UIConsts,
  System.UITypes,
  System.Variants;

type
  TFrmLogin = class(TForm)
    Panel1: TPanel;
    BtnOK: TButton;
    BtnCancelar: TButton;
    Rectangle1: TRectangle;
    Image1: TImage;
    Layout1: TLayout;
    Rectangle2: TRectangle;
    lblUsuario: TLabel;
    EdtUsuario: TEdit;
    LblSenha: TLabel;
    EdtSenha: TEdit;
    ShadowEffect1: TShadowEffect;
    ShadowEffect2: TShadowEffect;
    ShadowEffect3: TShadowEffect;
    ShadowEffect4: TShadowEffect;
    ShadowEffect5: TShadowEffect;
    ShadowEffect6: TShadowEffect;
    ShadowEffect7: TShadowEffect;
    procedure BtnOKClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FConexao: TFDConnection;
    FLinguagem: string;
    CurrentDateTime: TDateTime; //Para uso com o Log
    DateTimeStr: string;        //Para uso com o Log
    FHabilitarLog: String;
    procedure CarregarLinguagem;
    procedure CarregarConfiguracao;
    procedure SetHabilitarLog(const Value: String);
  public
    { Public declarations }
    property HabilitarLog: String read FHabilitarLog write SetHabilitarLog;
    procedure CarregarCores;
    constructor create;

  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.fmx}

procedure TFrmLogin.BtnOKClick(Sender: TObject);
Var
  Login: TLogin;
  LogManager: TLogManager;
  Registro  : TModelRegistro;
  LicencaValida: Boolean;
  cnpj: string;
begin
  LogManager:= TLogManager.Create;
  Login := TLogin.Create;
  try
    if Login.Login(EdtUsuario.Text, EdtSenha.Text) then
    begin
      if FHabilitarLog='S' then
      begin
        CurrentDateTime := Now;
        DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);

        LogManager.AddLog('Tela Login - Linha : 113 - Usuário: ' + EdtUsuario.Text + ' fez login às ' + DateTimeStr);
        LogManager.SaveLogToFile('Log_Tela_de_Login.txt');

      end;

      //Testa se a Licença está válida lendo o banco Licencas Tabela registro campo data_exp
      //Chamar o Model.Registro função ValidarLicença(adata: TDateTime): Boolean;

      cnpj := Login.PesquisaCNPJ(EdtUsuario.Text, EdtSenha.Text);
      Registro:= TModelRegistro.create;
      try
        Registro.cnpj:= cnpj;
        LicencaValida := Registro.ValidarLicenca(Now, Registro.cnpj);
        if LicencaValida then
        begin
          FrmLogin.CloseModal;
          FrmPrincipal.ShowModal;
        end
        else //Licença expirada ou inexistente? chama o formuláario de registro.
        begin
          Showmessage('Sua Licença está expirada ou inexistente, entre em contato com a Conect Solutions para averiguar comercial@conectsolutionsti.com.br ou Tel/WhatsApp : 11.9424.98529.');
          Application.CreateForm(TFrmRegistrar, FrmRegistrar);
          FrmRegistrar.ShowModal;
          FrmRegistrar.TabControl1.Index:=0;
          Application.Terminate;
        end;
      finally
        Registro.Free;
      end;
    end
    else  //Usuário ou senha não encontrato. Como fazer aqui o primeiro cadastro do usuário , senha?
    begin
      if FHabilitarLog='S' then
      begin
        CurrentDateTime := Now;
        DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
        LogManager.AddLog('Tela Login - Linha : 111 - Usuário não encontrado às ' + DateTimeStr);
        LogManager.SaveLogToFile('Log_Tela_de_Login.txt');
      end;

      ShowMessage('usuario ou senha não encontrado');
      EdtUsuario.SetFocus;
    end;
  finally
    Login.Free;
    LogManager.Free;
  end;

end;

procedure TFrmLogin.BtnCancelarClick(Sender: TObject);
begin
  FrmPrincipal.Close;
end;

procedure TFrmLogin.CarregarConfiguracao;
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\Config.ini');
  try
     FHabilitarLog := IniFile.ReadString('HabilitarLogs', 'HabilitarLogsSistema', '');
  finally
    IniFile.Free;
  end;
end;

procedure TFrmLogin.CarregarCores;
var
  IniFile: TIniFile;
  Cor: TAlphaColor;
  LogManager: TLogManager;
begin
  LogManager:= TLogManager.Create;

  if FHabilitarLog='S' then
  begin
    CurrentDateTime := Now;
    DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
    LogManager.AddLog('Tela Login - Entrou no CarregarCores - Linha: 134 - e criou o IniFile às ' + DateTimeStr);
    LogManager.SaveLogToFile('Log_Tela_de_Login.txt');
  end;

  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\Config.ini');
  try
    Cor := StringToAlphaColor(IniFile.ReadString('Cores', 'cor', ''));
  finally
    if FHabilitarLog='S' then
    begin
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela Login - Finalizou a CarregarCores - Linha : 143 - e deu Free no IniFile às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Tela_de_Login.txt');
    end;

    IniFile.Free;
    LogManager.Free;
  end;

  for var I := 0 to FrmLogin.ComponentCount - 1 do
  begin
    if FrmLogin.Components[I] is TRectangle then
      TRectangle(FrmLogin.Components[I]).Fill.Color := Cor;
  end;

end;

procedure TFrmLogin.CarregarLinguagem;
var
  IniFile: TIniFile;
  I: Integer;
  LogManager: TLogManager;
begin
  LogManager:= TLogManager.Create;
  if FHabilitarLog='S' then
  begin
    CurrentDateTime := Now;
    DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
    LogManager.AddLog('Tela Login - Entrou na  CarregarLinguagem: Linha : 163 - Criou o IniFile às ' + DateTimeStr);
    LogManager.SaveLogToFile('Log_Tela_de_Login.txt');
  end;

  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\Config.ini');
  try
    FLinguagem :=IniFile.ReadString('Traducao', 'Linguagem', '');

   if FLinguagem = 'Portuguese' then
   begin
     lblUsuario.Text  := 'Usuário';
     lblSenha.Text         := 'Senha';
     BtnCancelar.Text      := 'Cancelar';
     BtnOK.Text            := 'Enviar';
     FrmLogin.Caption      := 'Conecte-se';
     EdtUsuario.TextPrompt := 'Seu usuário';
     Edtsenha.TextPrompt   := 'Sua senha';
   end
   else if FLinguagem = 'Ingles' then
   begin
     lblUsuario.Text       := 'User';
     lblSenha.Text         := 'Password';
     BtnCancelar.Text      := 'Cancel';
     BtnOK.Text            := 'Send';
     FrmLogin.Caption      := 'Login';
     EdtUsuario.TextPrompt := 'Your user';
     Edtsenha.TextPrompt   := 'Your password';
   end;

  finally
    if FHabilitarLog='S' then
    begin
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela Login - Finalizou o CarregarLinguagem: Linha 194 - e deu Free no IniFile às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Tela_de_Login.txt');
    end;

    IniFile.Free;
    LogManager.Free;

  end;

end;

constructor TFrmLogin.create;
var
  LogManager: TLogManager;
begin
  if FHabilitarLog='S' then
  begin
    CurrentDateTime := Now;
    DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
    LogManager.AddLog('Tela Login - Entrou no Create : Linha : 258 - e criou a FConexao às ' + DateTimeStr);
    LogManager.SaveLogToFile('Log_Tela_de_Login.txt');
  end;

  FConexao := TConnection.CreateConnection;
end;

procedure TFrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
var
  LogManager: TLogManager;
begin
  if FHabilitarLog='S' then
  begin
    LogManager:= TlogManager.Create;
    try
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela Login - Entrou no Destroy : Linha 275 - e deu Free na FConexao às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Tela_de_Login.txt');
      FConexao.Free;

    finally
      LogManager.AddLog('Tela Login - Entrou no Destroy : Linha 280 - e deu Free na LogManager e FConexao às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Tela_de_Login.txt');
      LogManager.Free;
    end;
  end;

end;

procedure TFrmLogin.FormCreate(Sender: TObject);
var
  LogManager: TLogManager;
begin
  if FHabilitarLog='S' then
  begin
    LogManager := TLogManager.Create;
    try
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela Login - Entrou no FormCreate : Linha 298 - e criou LogManager às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Tela_de_Login.txt');
    finally
      LogManager.Free;
    end;

  end;
  CarregarCores;
  CarregarLinguagem;
  CarregarConfiguracao;
end;

procedure TFrmLogin.FormShow(Sender: TObject);
begin
  if EdtUsuario.CanFocus then
    EdtUsuario.SetFocus;
end;

procedure TFrmLogin.SetHabilitarLog(const Value: String);
begin
  FHabilitarLog := Value;
end;

end.
