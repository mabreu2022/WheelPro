unit URegistrar;

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
  FMX.Objects,
  FMX.Layouts,
  FMX.Effects,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Edit,
  System.Rtti,
  FMX.Grid.Style,
  FMX.Grid,
  FMX.ScrollBox,
  IniFiles,
  System.UIConsts,
  LogManager,
  FMX.ListBox,
  IdMessage,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdExplicitTLSClientServerBase,
  IdMessageClient,
  IdSMTPBase,
  IdSMTP,
  Model.Registro,
  Funcoes.CNPJCPF,
  Data.DB,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client,
  FireDAC.Phys.PGDef,
  FireDAC.Phys.PG,
  FireDAC.Comp.UI,
  DAO.ConexaoLicencas, FMX.TabControl, FMX.Memo.Types, FMX.Memo;

type
  TFrmRegistrar = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    LblTitulo: TLabel;
    ShadowEffect1: TShadowEffect;
    IdSMTP1: TIdSMTP;
    IdMessage1: TIdMessage;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    lblRazao: TLabel;
    ShadowEffect2: TShadowEffect;
    EdtRazao: TEdit;
    ShadowEffect8: TShadowEffect;
    lblCnpj_cpf: TLabel;
    ShadowEffect3: TShadowEffect;
    EdtCnpj: TEdit;
    ShadowEffect9: TShadowEffect;
    lblIe: TLabel;
    ShadowEffect32: TShadowEffect;
    EdtInscricaoEstadual: TEdit;
    ShadowEffect30: TShadowEffect;
    lblIm: TLabel;
    ShadowEffect33: TShadowEffect;
    EdtIncricaoMunicipal: TEdit;
    ShadowEffect31: TShadowEffect;
    lblEndereco: TLabel;
    ShadowEffect4: TShadowEffect;
    EdtEndereco: TEdit;
    ShadowEffect10: TShadowEffect;
    lblNumero: TLabel;
    ShadowEffect5: TShadowEffect;
    EdtNumero: TEdit;
    ShadowEffect11: TShadowEffect;
    LblComplemento: TLabel;
    ShadowEffect6: TShadowEffect;
    LblBairro: TLabel;
    ShadowEffect7: TShadowEffect;
    LblCidade: TLabel;
    ShadowEffect23: TShadowEffect;
    lblCEP: TLabel;
    ShadowEffect28: TShadowEffect;
    lblUF: TLabel;
    ShadowEffect24: TShadowEffect;
    LblAtivo: TLabel;
    ShadowEffect25: TShadowEffect;
    EdtComplemento: TEdit;
    ShadowEffect12: TShadowEffect;
    EdtBairro: TEdit;
    ShadowEffect13: TShadowEffect;
    EdtCidade: TEdit;
    ShadowEffect22: TShadowEffect;
    EdtCEP: TEdit;
    ShadowEffect29: TShadowEffect;
    CBUF: TComboBox;
    ShadowEffect26: TShadowEffect;
    CBAtivo: TComboBox;
    ShadowEffect27: TShadowEffect;
    LblResponnsavel: TLabel;
    ShadowEffect15: TShadowEffect;
    LblTelefone: TLabel;
    ShadowEffect18: TShadowEffect;
    EdtResponsavel: TEdit;
    ShadowEffect16: TShadowEffect;
    EdtTelefone: TEdit;
    ShadowEffect19: TShadowEffect;
    LblEmail: TLabel;
    ShadowEffect20: TShadowEffect;
    EdtEmail: TEdit;
    ShadowEffect21: TShadowEffect;
    GroupBox1: TGroupBox;
    Grid1: TGrid;
    Column1: TColumn;
    Column2: TColumn;
    Column3: TColumn;
    ShadowEffect17: TShadowEffect;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblSerial: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    lblSerialHD: TLabel;
    Label7: TLabel;
    Memo1: TMemo;
    BtnGravar: TButton;
    BtnRegistrar: TButton;
    ShadowEffect14: TShadowEffect;
    TabItem4: TTabItem;
    EdtContraSenha: TEdit;
    BtnEnviar: TButton;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BtnRegistrarClick(Sender: TObject);
    procedure EdtCnpjExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnEnviarClick(Sender: TObject);
    procedure EdtContraSenhaExit(Sender: TObject);
  private
    { Private declarations }
    FLinguagem: string;
    FConexao: TFDConnection;
    procedure CarregarCores;
    procedure CarregarLinguagem;
  public
    { Public declarations }
  end;

var
  FrmRegistrar: TFrmRegistrar;

implementation

{$R *.fmx}

{ TFrmRegistrar }

procedure TFrmRegistrar.BtnRegistrarClick(Sender: TObject);
var
  Registro: TModelRegistro;
  Ativo: String;
  UF: String;
  Validou: Boolean;
begin
  //enviar esses dados para o e-mail ou gravar no banco?
  //pode-se chamar o site com um formulário para o registro enviar por e-mail para conect
  Registro:= TModelRegistro.Create;
  try
    Registro.razao       := EdtRazao.Text;
    Registro.cnpj        := EdtCnpj.Text;
    Registro.ie          := EdtInscricaoEstadual.Text;
    Registro.im          := EdtIncricaoMunicipal.Text;
    Registro.endereco    := EdtEndereco.Text;
    if EdtNumero.Text<>'' then
      Registro.numero      := StrToInt(EdtNumero.Text);
    Registro.complemento := EdtComplemento.Text;
    Registro.bairro      := EdtBairro.Text;
    Registro.cidade      := EdtCidade.Text;
    Registro.responsavel := EdtResponsavel.Text;
    Registro.telcontato  := EdtTelefone.Text;
    Registro.email       := EdtEmail.Text;
    Registro.cep         := EdtCEP.Text;
    Registro.Linguagem   := FLinguagem;
    Registro.serial      := Registro.GerarSerial;

    if CBUF.ItemIndex <> -1 then
    begin
      UF := CBUF.Items[CBUF.ItemIndex];
      Registro.uf          := UF;
    end;

    if CBATivo.ItemIndex <> -1 then
    begin
      Ativo := CBATivo.Items[CBATivo.ItemIndex];
      Registro.ativo       := Ativo;
    end;

    Validou:= Registro.validarDados(Registro, Registro.Linguagem);

    if Validou then
    begin
      Registro.enviarEmail;  //dentro do Enviar Email chama a gravação no Banco de Licenças
      TabControl1.Index:=2;
    end
    else
    begin
      if EdtRazao.CanFocus then
        EdtRazao.SetFocus;
    end;

  finally
    Registro.Free;
  end;

end;

procedure TFrmRegistrar.BtnEnviarClick(Sender: TObject);
var
   Registro: TModelRegistro;
   DeuCerto: Boolean;
begin
  TabControl1.Tabs[0].Visible := False;

  Registro:=TModelRegistro.create;
  try
    Registro.ContraSenha := EdtContraSenha.Text;
    Registro.ativo       := 'S';
    Registro.Data_exp    := Now + 30;

    DeuCerto := Registro.GravarContraSenha(Registro);

    if DeuCerto then
      ShowMessage('Sistema ativado com sucesso!')
    else
    begin
      ShowMessage('Sistema não ativado, favor entrar em contato com o suporte!');
      Application.Terminate;
    end;

  finally
    Registro.Free;
  end;

end;

procedure TFrmRegistrar.BtnGravarClick(Sender: TObject);
var
  Registro: TModelRegistro;
  DeuCerto: Boolean;
begin
  TabControl1.Tabs[0].Visible := False;
  Button1.Enabled:=True; //
  Edit1.Enabled:=True;   //
  BtnRegistrar.Enabled:=True;

  Registro:=TModelRegistro.create;
  try
     Registro.razao        := EdtRazao.Text;
     Registro.cnpj         := EdtCnpj.Text;
     Registro.ie           := EdtInscricaoEstadual.Text;
     Registro.im           := EdtIncricaoMunicipal.Text;
     Registro.endereco     := EdtEndereco.Text;
     Registro.numero       := StrToInt(EdtNumero.Text);
     Registro.complemento  := EdtComplemento.Text;
     Registro.bairro       := EdtBairro.Text;
     Registro.Cidade       := EdtCidade.Text;
     Registro.uf           := CBUF.Items[CBUF.ItemIndex];
     Registro.CEP          := EdtCep.Text;
     Registro.ativo        := CBAtivo.Items[CBAtivo.ItemIndex];
     Registro.contato      := EdtResponsavel.Text;
     Registro.telcontato   := EdtTelefone.Text;
     Registro.email        := Edtemail.Text;
     Registro.dataregistro := Now;
     Registro.serialHD     := lblSerialHD.Text;
     Registro.serial       := lblSErial.Text;

     //chamar a rotina de gravar serial no Model.Registro;
     DeuCerto := Registro.GravarNoBancoLicencas(Registro); //select * from chaves  //Aqui  deve ser um Update , tendo que criar uma funcao para isso

     if DeuCerto then
     begin
       ShowMessage('Dados Salvos com sucesso!');
       TabControl1.Index:=1;
     end
     else
     begin
       ShowMessage('Erro ao gravar Registro!');
       if EdtRazao.CanFocus then
         EdtRazao.Setfocus;
     end;
  finally
     Registro.Free;
  end;

end;

procedure TFrmRegistrar.CarregarCores;
var
  IniFile: TIniFile;
  Cor: TAlphaColor;
begin
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\Config.ini');
  try
    Cor := StringToAlphaColor(IniFile.ReadString('Cores', 'Cor', ''));
  finally
    IniFile.UpdateFile;
    IniFile.Free;
  end;

  for var I := 0 to FrmRegistrar.ComponentCount - 1 do
  begin
    if FrmRegistrar.Components[I] is TRectangle then
      TRectangle(FrmRegistrar.Components[I]).Fill.Color := Cor;
  end;
end;

procedure TFrmRegistrar.CarregarLinguagem;
var
  IniFile: TIniFile;
  I: Integer;
begin
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\Config.ini');
  try
    FLinguagem :=IniFile.ReadString('Traducao', 'Linguagem', '');

   if FLinguagem = 'Portuguese' then
   begin
     lblRazao.Text        := 'Razão Social / Nome';
     lblCnpj_cpf.Text     := 'CNPJ / CPF';
     lblIe.Text           := 'Inscrição Estadual';
     lblIm.Text           := 'Inscrição Municipal';
     lblEndereco.Text     := 'Endereço';
     lblNumero.Text       := 'Número';
     LblComplemento.Text  := 'Complemento';
     LblBairro.Text       := 'Bairro';
     LblCidade.Text       := 'Cidade';
     LblResponnsavel.Text := 'Nome do responsável pelo registro';
     LblTelefone.Text     := 'Telefone/WhatsApp';
     LblEmail.Text        := 'E-mail';
     BtnRegistrar.Text    := '&Registrar';
     LblTitulo.Text       := 'Registro do Wheel Pro';
     FrmRegistrar.Caption := 'Registro do Wheel Pro';
   end
   else if FLinguagem = 'Ingles' then
   begin
     lblRazao.Text        := 'Corporate Name / Name';
     lblCnpj_cpf.Text     := 'Tax Identification Number - TIN';
     lblIe.Visible        := False;
     EdtInscricaoEstadual.Visible:= False;
     lblIe.Text           := 'Inscrição Estadual';
     lblIm.Visible        := False;
     EdtIncricaoMunicipal.Visible:= False;
     lblIm.Text           := 'Inscrição Municipal';
     lblEndereco.Text     := 'Address';
     lblNumero.Text       := 'Number';
     LblComplemento.Text  := 'Complement';
     LblBairro.Text       := 'Neighborhood';
     LblCidade.Text       := 'City';
     LblResponnsavel.Text := 'Name of person responsible for registration';
     LblTelefone.Text     := 'Phone/WhatsApp';
     LblEmail.Text        := 'E-mail';
     BtnRegistrar.Text    := '&Register';
     LblTitulo.Text       := 'Wheel Pro registration';
     FrmRegistrar.Caption := 'Wheel Pro registration';
   end;

  finally
    IniFile.Free;
  end;

end;

procedure TFrmRegistrar.EdtContraSenhaExit(Sender: TObject);
begin
 if EdtContraSenha.Text<>'' then
   BtnEnviar.Enabled:= True;
end;

procedure TFrmRegistrar.EdtCnpjExit(Sender: TObject);
var
  Funcoes: TCNPJCPF;
begin
  //se for EUA pular validação desse campo?
  if FLinguagem = 'Ingles' then
    Exit;

  Funcoes:= TCNPJCPF.Create;
  try
    if not Funcoes.ValidarCNPJ(EdtCNPJ.Text) then
    begin
      ShowMessage('CNPJ inválido');
      EdtCnpj.SetFocus;
      BtnRegistrar.Enabled:= False;
    end
    else
      BtnRegistrar.Enabled:= True;;


    if not Funcoes.ValidarCPF(EdtCnpj.Text) then
    begin
      ShowMessage('CPF inválido');
      EdtCnpj.SetFocus;
      BtnRegistrar.Enabled:= False;
    end
    else
      BtnRegistrar.Enabled:= True;;

  finally
    Funcoes.Free;
  end;
end;

procedure TFrmRegistrar.FormCreate(Sender: TObject);
begin
  CarregarCores;
  CarregarLinguagem;
  FConexao := TConexaoLicencas.CreateConnection;
end;

procedure TFrmRegistrar.FormDestroy(Sender: TObject);
begin
  FConexao.Free;
end;

end.
