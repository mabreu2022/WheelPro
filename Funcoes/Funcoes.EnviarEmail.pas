unit Funcoes.EnviarEmail;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Util,
  FireDAC.Stan.Param,
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
  Data.DB,
  Entity.Clientes,
  Entity.Contatos,
  System.Generics.Collections,
  Dao.ConexaoLicencas,
  Datasnap.DBClient,
  LogManager,
  FMX.Dialogs,
  System.IniFiles,
  IdSMTP,
  IdMessage,
  IdExplicitTLSClientServerBase,
  IdSSLOpenSSL,
  System.Win.ComObj,
  Winapi.ActiveX,
  System.Variants,
  FMX.Forms,
  Model.Registro;


type
  TEnviarEmail = class
    private
      FContraSenha: String;
      Fdataregistro: TDatetime;
      Fcnpj: string;
      Femail: string;
      Fbairro: string;
      Ftelcontato: string;
      Fativo: string;
      Fim: string;
      Fuf: string;
      FData_exp: TDateTime;
      Fresponsavel: string;
      Fserial: string;
      FCEP: string;
      Fnumero: integer;
      Fie: string;
      Fcomplemento: string;
      Fcontato: string;
      Fserialhd: string;
      Fcidade: string;
      Fendereco: string;
      FLinguagem: string;
      Ftelefone: string;
      Frazao: string;
      Fid_chave: string;
      procedure Setativo(const Value: string);
      procedure Setbairro(const Value: string);
      procedure SetCEP(const Value: string);
      procedure Setcidade(const Value: string);
      procedure Setcnpj(const Value: string);
      procedure Setcomplemento(const Value: string);
      procedure Setcontato(const Value: string);
      procedure SetContraSenha(const Value: String);
      procedure SetData_exp(const Value: TDateTime);
      procedure Setdataregistro(const Value: TDatetime);
      procedure Setemail(const Value: string);
      procedure Setendereco(const Value: string);
      procedure Setid_chave(const Value: string);
      procedure Setie(const Value: string);
      procedure Setim(const Value: string);
      procedure SetLinguagem(const Value: string);
      procedure Setnumero(const Value: integer);
      procedure Setrazao(const Value: string);
      procedure Setresponsavel(const Value: string);
      procedure Setserial(const Value: string);
      procedure Setserialhd(const Value: string);
      procedure Settelcontato(const Value: string);
      procedure Settelefone(const Value: string);
      procedure Setuf(const Value: string);

    public
       property razao       : string read Frazao write Setrazao;
       property cnpj        : string read Fcnpj write Setcnpj;
       property ie          : string read Fie write Setie;
       property im          : string read Fim write Setim;
       property endereco    : string read Fendereco write Setendereco;
       property numero      : integer read Fnumero write Setnumero;
       property complemento : string read Fcomplemento write Setcomplemento;
       property bairro      : string read Fbairro write Setbairro;
       property cidade      : string read Fcidade write Setcidade;
       property uf          : string read Fuf write Setuf;
       property CEP         : string read FCEP write SetCEP;
       property ativo       : string read Fativo write Setativo;
       property responsavel : string read Fresponsavel write Setresponsavel;
       property contato     : string read Fcontato write Setcontato;
       property telcontato  : string read Ftelcontato write Settelcontato;
       property telefone    : string read Ftelefone write Settelefone;
       property email       : string read Femail write Setemail;
       property dataregistro: TDatetime read Fdataregistro write Setdataregistro;
       property Linguagem   : string read FLinguagem write SetLinguagem;
       property serial      : string read Fserial write Setserial;
       property serialhd    : string read Fserialhd write Setserialhd;
       property ContraSenha : String read FContraSenha write SetContraSenha;
       property Data_exp    : TDateTime read FData_exp write SetData_exp;
       property id_chave    : string read Fid_chave write Setid_chave;
       function enviarPedido(aEmail: String): Boolean;
  end;

implementation


{ TEnviarEmail }

function TEnviarEmail.enviarPedido(aEmail: String): Boolean;
var
  IdMessage      : TIdMessage;
  IdSMTP1        : TIdSMTP;
  IdSSLIOHandler : TIdSSLIOHandlerSocketOpenSSL;
  aRegistro      : TMOdelRegistro;
  Gravou         : Boolean;
  i              : integer;
  email          : string;
begin

    Result:= False;
    IdSMTP1 := TIdSMTP.Create(nil);
    IdSMTP1.ConnectTimeout  := 10000;
    IdSMTP1.ReadTimeout     := 10000;

    IdSMTP1.Host      := 'smtp.gmail.com';//'smtp.office365.com';//'smtp.live.com';
    IdSMTP1.Port      := 587;
    IdSMTP1.Username  := 'mauricio.magosoft@gmail.com';
    IdSMTP1.Password  := 'arlxynudhkdznasd';
    IdSSLIOHandler    := Nil;
    IdSSLIOHandler    := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    IdSMTP1.IOHandler := IdSSLIOHandler;
    IdSMTP1.UseTLS    := utUseExplicitTLS;
    IdSMTP1.AuthType  := satDefault;

     if Assigned(IdSSLIOHandler) then
     begin
       IdSSLIOHandler.SSLOptions.Method := sslvSSLv23;
       IdSSLIOHandler.SSLOptions.Mode   := sslmClient;
     end;

    IdMessage := TIdMessage.Create(nil);
    try
      IdMessage.From.Address := 'mauricio.magosoft@gmail.com';
//      IdMessage.Recipients.Add.Address := 'comercial@conectsolutionsti.com.br';
      IdMessage.Recipients.EMailAddresses:= aEmail1;

      IdMessage.Subject := 'Novo registro do Wheel Pro';

      // Construir o corpo da mensagem com os campos do formulário
      IdMessage.Body.Text :=
        'Razão:       '    + razao            + #13#10 +
        'CNPJ:        '    + cnpj             + #13#10 +
        'IE:          '    + ie               + #13#10 +
        'IM:          '    + im               + #13#10 +
        'Endereço:    '    + endereco         + #13#10 +
        'Número:      '    + IntToStr(numero) + #13#10 +
        'Complemento: '    + complemento      + #13#10 +
        'Bairro:      '    + bairro           + #13#10 +
        'Cidade:      '    + cidade           + #13#10 +
        'UF:          '    + uf               + #13#10 +
        'CEP:         '    + cep              + #13#10 +
        'Ativo:       '    + ativo            + #13#10 +
        'Responsável: '    + contato          + #13#10 +
        'Telefone:    '    + telcontato       + #13#10 +
        'Serial:      '    + Serial           + #13#10 +
        'E-mail:      '    + email;

        //Enviar o Serial do cliente para ser feita a validação na ferramenta externa

      // Envie o e-mail
      try
        IdSMTP1.Connect;
        IdSMTP1.Send(IdMessage);
        ShowMessage('Registro enviado com sucesso');
        Result:= True;

        aRegistro:= TModelRegistro.create;
        try
          aRegistro.razao       := razao;
          aRegistro.cnpj        := cnpj;
          aRegistro.ie          := ie;
          aRegistro.im          := im;
          aRegistro.endereco    := endereco;
          aRegistro.numero      := numero;
          aRegistro.complemento := complemento;
          aRegistro.bairro      := bairro;
          aRegistro.cidade      := cidade;
          aRegistro.uf          := uf;
          aRegistro.CEP         := cep;
          aRegistro.ativo       := ativo;
          aRegistro.contato     := contato;
          aRegistro.telcontato  := telcontato;
          aRegistro.email       := email;
          aRegistro.Linguagem   := linguagem;
          aRegistro.serial      := Serial;

         // Gravou := GravarNoBancoLicencas(aRegistro);

          if Gravou then
          begin
            if linguagem='Portugues' then
              ShowMessage('Registro incluido com sucesso! Aguarde Retorno por E-mail da Conect com a chave do seu registro')
            else
              ShowMessage('Registration successfully added! Wait for an E-mail Return from Conect with your registration key');
          end;
        finally
          aRegistro.Free;
        end;

      Except
        On E: Exception do
        begin
          Result:= False;
          if linguagem='Portugues' then
            ShowMessage('Ocorreu um erro ao enviar o registro' + e.Message)
          else
            ShowMessage('An error occurred while sending the record' + e.Message);
        end;

      end;

    finally
      IdMessage.Free;
      IdSMTP1.Free;
      IdSSLIOHandler.Free;
    end;



end;

procedure TEnviarEmail.Setativo(const Value: string);
begin
  Fativo := Value;
end;

procedure TEnviarEmail.Setbairro(const Value: string);
begin
  Fbairro := Value;
end;

procedure TEnviarEmail.SetCEP(const Value: string);
begin
  FCEP := Value;
end;

procedure TEnviarEmail.Setcidade(const Value: string);
begin
  Fcidade := Value;
end;

procedure TEnviarEmail.Setcnpj(const Value: string);
begin
  Fcnpj := Value;
end;

procedure TEnviarEmail.Setcomplemento(const Value: string);
begin
  Fcomplemento := Value;
end;

procedure TEnviarEmail.Setcontato(const Value: string);
begin
  Fcontato := Value;
end;

procedure TEnviarEmail.SetContraSenha(const Value: String);
begin
  FContraSenha := Value;
end;

procedure TEnviarEmail.Setdataregistro(const Value: TDatetime);
begin
  Fdataregistro := Value;
end;

procedure TEnviarEmail.SetData_exp(const Value: TDateTime);
begin
  FData_exp := Value;
end;

procedure TEnviarEmail.Setemail(const Value: string);
begin
  Femail := Value;
end;

procedure TEnviarEmail.Setendereco(const Value: string);
begin
  Fendereco := Value;
end;

procedure TEnviarEmail.Setid_chave(const Value: string);
begin
  Fid_chave := Value;
end;

procedure TEnviarEmail.Setie(const Value: string);
begin
  Fie := Value;
end;

procedure TEnviarEmail.Setim(const Value: string);
begin
  Fim := Value;
end;

procedure TEnviarEmail.SetLinguagem(const Value: string);
begin
  FLinguagem := Value;
end;

procedure TEnviarEmail.Setnumero(const Value: integer);
begin
  Fnumero := Value;
end;

procedure TEnviarEmail.Setrazao(const Value: string);
begin
  Frazao := Value;
end;

procedure TEnviarEmail.Setresponsavel(const Value: string);
begin
  Fresponsavel := Value;
end;

procedure TEnviarEmail.Setserial(const Value: string);
begin
  Fserial := Value;
end;

procedure TEnviarEmail.Setserialhd(const Value: string);
begin
  Fserialhd := Value;
end;

procedure TEnviarEmail.Settelcontato(const Value: string);
begin
  Ftelcontato := Value;
end;

procedure TEnviarEmail.Settelefone(const Value: string);
begin
  Ftelefone := Value;
end;

procedure TEnviarEmail.Setuf(const Value: string);
begin
  Fuf := Value;
end;

end.
