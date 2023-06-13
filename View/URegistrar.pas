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
  Model.Registro, Funcoes.CNPJCPF;

type
  TFrmRegistrar = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    LblTitulo: TLabel;
    ShadowEffect1: TShadowEffect;
    lblRazao: TLabel;
    ShadowEffect2: TShadowEffect;
    EdtRazao: TEdit;
    ShadowEffect8: TShadowEffect;
    lblCnpj_cpf: TLabel;
    lblEndereco: TLabel;
    ShadowEffect4: TShadowEffect;
    ShadowEffect3: TShadowEffect;
    EdtCnpj: TEdit;
    ShadowEffect9: TShadowEffect;
    EdtEndereco: TEdit;
    ShadowEffect10: TShadowEffect;
    lblNumero: TLabel;
    ShadowEffect5: TShadowEffect;
    LblComplemento: TLabel;
    ShadowEffect6: TShadowEffect;
    EdtNumero: TEdit;
    ShadowEffect11: TShadowEffect;
    EdtComplemento: TEdit;
    ShadowEffect12: TShadowEffect;
    LblBairro: TLabel;
    ShadowEffect7: TShadowEffect;
    EdtBairro: TEdit;
    ShadowEffect13: TShadowEffect;
    BtnRegistrar: TButton;
    ShadowEffect14: TShadowEffect;
    GroupBox1: TGroupBox;
    Grid1: TGrid;
    Column1: TColumn;
    Column2: TColumn;
    Column3: TColumn;
    LblResponnsavel: TLabel;
    EdtResponsavel: TEdit;
    ShadowEffect15: TShadowEffect;
    ShadowEffect16: TShadowEffect;
    ShadowEffect17: TShadowEffect;
    LblTelefone: TLabel;
    EdtTelefone: TEdit;
    ShadowEffect18: TShadowEffect;
    ShadowEffect19: TShadowEffect;
    LblEmail: TLabel;
    EdtEmail: TEdit;
    ShadowEffect20: TShadowEffect;
    ShadowEffect21: TShadowEffect;
    LblCidade: TLabel;
    EdtCidade: TEdit;
    ShadowEffect22: TShadowEffect;
    ShadowEffect23: TShadowEffect;
    lblUF: TLabel;
    ShadowEffect24: TShadowEffect;
    CBUF: TComboBox;
    ShadowEffect26: TShadowEffect;
    LblAtivo: TLabel;
    ShadowEffect25: TShadowEffect;
    CBAtivo: TComboBox;
    ShadowEffect27: TShadowEffect;
    IdSMTP1: TIdSMTP;
    IdMessage1: TIdMessage;
    EdtCEP: TEdit;
    lblCEP: TLabel;
    ShadowEffect28: TShadowEffect;
    ShadowEffect29: TShadowEffect;
    procedure FormCreate(Sender: TObject);
    procedure BtnRegistrarClick(Sender: TObject);
    procedure EdtCnpjExit(Sender: TObject);
  private
    { Private declarations }
    FLinguagem: string;
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
    Registro.endereco    := EdtEndereco.Text;
    if EdtNumero.Text<>'' then
      Registro.numero      := StrToInt(EdtNumero.Text);
    Registro.complemento := EdtComplemento.Text;
    Registro.bairro      := EdtBairro.Text;
    Registro.cidade      := EdtCidade.Text;
    Registro.responsavel := EdtResponsavel.Text;
    Registro.telefone    := EdtTelefone.Text;
    Registro.email       := EdtEmail.Text;
    Registro.cep         := EdtCEP.Text;

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

    Validou:= Registro.validarDados(Registro);

    if Validou then
      Registro.enviarEmail
    else
    begin
      if EdtRazao.CanFocus then
        EdtRazao.SetFocus;
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

procedure TFrmRegistrar.EdtCnpjExit(Sender: TObject);
var
  Funcoes: TCNPJCPF;
begin
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
end;

end.
