unit Model.Registro;

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
  Dao.Conexao,
  Datasnap.DBClient,
  LogManager,
  FMX.Dialogs,
  System.IniFiles,
  IdSMTP,
  IdMessage,
  IdExplicitTLSClientServerBase,
  IdSSLOpenSSL;


type
  TModelRegistro = class
    private
      Fconn: TFDConnection;
      qry: TFDQuery;
      Fcnpj: string;
      Femail: string;
      Fbairro: string;
      Fativo: string;
      Fuf: string;
      Fresponsavel: string;
      Fnumero: integer;
      Fcomplemento: string;
      Fcidade: string;
      Fendereco: string;
      Ftelefone: string;
      Frazao: string;
    Fdataregistro: TDatetime;
    FCEP: string;
      procedure Setativo(const Value: string);
      procedure Setbairro(const Value: string);
      procedure Setcidade(const Value: string);
      procedure Setcnpj(const Value: string);
      procedure Setcomplemento(const Value: string);
      procedure Setemail(const Value: string);
      procedure Setendereco(const Value: string);
      procedure Setnumero(const Value: integer);
      procedure Setrazao(const Value: string);
      procedure Setresponsavel(const Value: string);
      procedure Settelefone(const Value: string);
      procedure Setuf(const Value: string);



      procedure Setdataregistro(const Value: TDatetime);
    procedure SetCEP(const Value: string);

    public
      property razao: string read Frazao write Setrazao;
      property cnpj : string read Fcnpj write Setcnpj;
      property endereco: string read Fendereco write Setendereco;
      property numero: integer read Fnumero write Setnumero;
      property complemento: string read Fcomplemento write Setcomplemento;
      property bairro: string read Fbairro write Setbairro;
      property cidade: string read Fcidade write Setcidade;
      property uf: string read Fuf write Setuf;
      property CEP: string read FCEP write SetCEP;
      property ativo: string read Fativo write Setativo;
      property responsavel: string read Fresponsavel write Setresponsavel;
      property telefone: string read Ftelefone write Settelefone;
      property email: string read Femail write Setemail;
      property dataregistro: TDatetime read Fdataregistro write Setdataregistro;

      procedure enviarEmail;
      class function validarDados(aRegistro: TModelRegistro) : boolean;



  end;

implementation

{ TModelRegistro }

procedure TModelRegistro.enviarEmail;
var
  IdMessage: TIdMessage;
  IdSMTP1: TIdSMTP;
  IdSSLIOHandler: TIdSSLIOHandlerSocketOpenSSL;
begin
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
    IdMessage.Recipients.Add.Address := 'comercial@conectsolutionsti.com.br';
    IdMessage.Subject := 'Novo registro do Wheel Pro';

    // Construir o corpo da mensagem com os campos do formulário
    IdMessage.Body.Text :=
      'Razão: ' + razao + #13#10 +
      'CNPJ: ' + cnpj + #13#10 +
      'Endereço: ' + endereco + #13#10 +
      'Número: ' + IntToStr(numero) + #13#10 +
      'Complemento: ' + complemento + #13#10 +
      'Bairro: ' + bairro + #13#10 +
      'Cidade: ' + cidade + #13#10 +
      'UF: ' + uf + #13#10 +
      'CEP: ' + cep + #13#10 +
      'Ativo: ' + ativo + #13#10 +
      'Responsável: ' + responsavel + #13#10 +
      'Telefone: ' + telefone + #13#10 +
      'E-mail: ' + email;

    // Envie o e-mail
    try
      IdSMTP1.Connect;
      IdSMTP1.Send(IdMessage);
      ShowMessage('Registro enviado com sucesso');
    Except
      On E: Exception do
      begin
        ShowMessage('Ocorreu um erro ao enviar o registro' + e.Message);
      end;

    end;

  finally
    IdMessage.Free;
    IdSMTP1.Free;
    IdSSLIOHandler.Free;
  end;

end;

procedure TModelRegistro.Setativo(const Value: string);
begin
  Fativo := Value;
end;

procedure TModelRegistro.Setbairro(const Value: string);
begin
  Fbairro := Value;
end;

procedure TModelRegistro.SetCEP(const Value: string);
begin
  FCEP := Value;
end;

procedure TModelRegistro.Setcidade(const Value: string);
begin
  Fcidade := Value;
end;

procedure TModelRegistro.Setcnpj(const Value: string);
begin
  Fcnpj := Value;
end;

procedure TModelRegistro.Setcomplemento(const Value: string);
begin
  Fcomplemento := Value;
end;

procedure TModelRegistro.Setdataregistro(const Value: TDatetime);
begin
  Fdataregistro := Value;
end;

procedure TModelRegistro.Setemail(const Value: string);
begin
  Femail := Value;
end;

procedure TModelRegistro.Setendereco(const Value: string);
begin
  Fendereco := Value;
end;

procedure TModelRegistro.Setnumero(const Value: integer);
begin
  Fnumero := Value;
end;

procedure TModelRegistro.Setrazao(const Value: string);
begin
  Frazao := Value;
end;

procedure TModelRegistro.Setresponsavel(const Value: string);
begin
  Fresponsavel := Value;
end;

procedure TModelRegistro.Settelefone(const Value: string);
begin
  Ftelefone := Value;
end;

procedure TModelRegistro.Setuf(const Value: string);
begin
  Fuf := Value;
end;

class function TModelRegistro.validarDados(aRegistro: TModelRegistro) : boolean;
begin
   Result := False;

  if aRegistro.CEP.Length < 8  then
  begin
    raise Exception.Create('O CEP não pode ser menor que 8 caracteres.');
    Result:= False;
    exit;
  end;

  if Trim(aRegistro.Frazao) ='' then
  begin
    raise Exception.Create('a Razão Social não pode ser vazia.');
    Result:= False;
    exit;
  end;

  if Trim(aRegistro.Endereco) = '' then
  begin
    raise Exception.Create('É necessário prencher o Endereço.');
    Result:= False;
    exit;
  end;

  if Trim(aRegistro.uf) = '' then
  begin
    raise Exception.Create('É necessário preencher a UF.');
    Result:= False;
    exit;
  end;

  if Trim(aRegistro.Cidade) = '' then
  begin
    raise Exception.Create('É necessário preencher a Cidade.');
    Result:= False;
    exit;
  end;

  if Trim(aRegistro.Bairro) = '' then
  begin
    raise Exception.Create('É necessário preencher o Bairro.');
    Result:= False;
    exit;
  end;

  Result:= True;
end;

end.
