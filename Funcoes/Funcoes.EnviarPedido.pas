unit Funcoes.EnviarPedido;

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
  FMX.Forms;


implementation

type
  EnviarPedido = class
    private
    FTotalPedido: currency;
    FStatusPedido: Integer;
    FidCliente: Integer;
    Fcnpj: string;
    Femail: string;
    Fbairro: string;
    Ftelcontato: string;
    Fim: string;
    Fuf: string;
    Fresponsavel: string;
    FCEP: string;
    Fnumero: integer;
    Fie: string;
    Fcomplemento: string;
    Fcontato: string;
    Fcidade: string;
    Fendereco: string;
    Ftelefone: string;
    Frazao: string;
    FidProduto: Integer;
    FTotaldoItem: Currency;
    FPrecoUnitario: Currency;
    FQuantidade: Integer;
    FidPedido: Integer;
    FNomeContato: String;
    FCelularContato: String;
    FTelefoneConteto: String;
    FEmailContato: String;
    FLinguagem: string;
    procedure SetidCliente(const Value: Integer);
    procedure SetStatusPedido(const Value: Integer);
    procedure SetTotalPedido(const Value: currency);
    procedure Setbairro(const Value: string);
    procedure SetCEP(const Value: string);
    procedure Setcidade(const Value: string);
    procedure Setcnpj(const Value: string);
    procedure Setcomplemento(const Value: string);
    procedure Setcontato(const Value: string);
    procedure Setemail(const Value: string);
    procedure Setendereco(const Value: string);
    procedure Setie(const Value: string);
    procedure Setim(const Value: string);
    procedure Setnumero(const Value: integer);
    procedure Setrazao(const Value: string);
    procedure Setresponsavel(const Value: string);
    procedure Settelcontato(const Value: string);
    procedure Settelefone(const Value: string);
    procedure Setuf(const Value: string);
    procedure SetidPedido(const Value: Integer);
    procedure SetidProduto(const Value: Integer);
    procedure SetPrecoUnitario(const Value: Currency);
    procedure SetQuantidade(const Value: Integer);
    procedure SetTotaldoItem(const Value: Currency);
    procedure SetCelularContato(const Value: String);
    procedure SetEmailContato(const Value: String);
    procedure SetNomeContato(const Value: String);
    procedure SetTelefoneConteto(const Value: String);
    procedure SetLinguagem(const Value: string);

    public
      //Dados do Pedido
      property IdPedido: Integer read FIdPedido write SetIdPedido;
      property idCliente: Integer read FidCliente write SetidCliente;
      property StatusPedido: Integer read FStatusPedido write SetStatusPedido;
      property TotalPedido: currency read FTotalPedido write SetTotalPedido;

      //Itens do Pedido
      property idProduto: Integer read FidProduto write SetidProduto;
      property Quantidade: Integer read FQuantidade write SetQuantidade;
      property PrecoUnitario: Currency read FPrecoUnitario write SetPrecoUnitario;
      property TotaldoItem: Currency read FTotaldoItem write SetTotaldoItem;

      //Dados do cliente
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
       property responsavel : string read Fresponsavel write Setresponsavel;
       property contato     : string read Fcontato write Setcontato;
       property telcontato  : string read Ftelcontato write Settelcontato;
       property telefone    : string read Ftelefone write Settelefone;
       property email       : string read Femail write Setemail;
       property NomeContato: String read FNomeContato write SetNomeContato;
       property TelefoneConteto: String read FTelefoneConteto write SetTelefoneConteto;
       property CelularContato: String read FCelularContato write SetCelularContato;
       property EmailContato: String read FEmailContato write SetEmailContato;
       property Linguagem   : string read FLinguagem write SetLinguagem;

      function enviarPedido(aEmail: String): Boolean;
      procedure PrencherDadosDoPedido(aidcliente: Integer;aStatusPedido:Integer;aTotalPedido: Currency);
  end;

{ EnviarPedido }

function EnviarPedido.enviarPedido(aEmail: String): Boolean;
var
  IdMessage      : TIdMessage;
  IdSMTP1        : TIdSMTP;
  IdSSLIOHandler : TIdSSLIOHandlerSocketOpenSSL;
  //aRegistro      : TMOdelRegistro;
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
//    IdMessage.Recipients.Add.Address := 'comercial@conectsolutionsti.com.br';
      IdMessage.Recipients.Add.Address:= aEmail;

      IdMessage.Subject := 'Novo registro do Wheel Pro';

      // Construir o corpo da mensagem com os campos do formulário
      IdMessage.Body.Text :=
        'Razão:       '    + razao              + #13#10 +
        'CNPJ:        '    + cnpj               + #13#10 +
        'IE:          '    + ie                 + #13#10 +
        'IM:          '    + im                 + #13#10 +
        'Endereço:    '    + endereco           + #13#10 +
        'Número:      '    + IntToStr(numero)   + #13#10 +
        'Complemento: '    + complemento        + #13#10 +
        'Bairro:      '    + bairro             + #13#10 +
        'Cidade:      '    + cidade             + #13#10 +
        'UF:          '    + uf                 + #13#10 +
        'CEP:         '    + cep                + #13#10 +
        'Responsável: '    + contato            + #13#10 +
        'Telefone:    '    + telcontato         + #13#10 +
        'Nome do Contato ' + contato            + #13#10 +
        'Telefone     '    + TelefoneConteto    + #13#10 +
        'Celular      '    + CelularContato     + #13#10 +
        'E-mail       '    + EmailContato       + #13#10 +
        'Id Pedido    '    + IntToStr(IdPedido) + #13#10 +
        'Data Pedido  '    + IntToStr(IdPedido) + #13#10 +
        'Total PEdido '    + FloatToStr(TotalPedido) + #13#10 ;
        //'id Item      '    + ;

        //Enviar o Serial do cliente para ser feita a validação na ferramenta externa

      // Envie o e-mail
      try
        IdSMTP1.Connect;
        IdSMTP1.Send(IdMessage);
        ShowMessage('Registro enviado com sucesso');
        Result:= True;

//        aRegistro:= TModelRegistro.create;
        try
//          aRegistro.razao       := razao;
//          aRegistro.cnpj        := cnpj;
//          aRegistro.ie          := ie;
//          aRegistro.im          := im;
//          aRegistro.endereco    := endereco;
//          aRegistro.numero      := numero;
//          aRegistro.complemento := complemento;
//          aRegistro.bairro      := bairro;
//          aRegistro.cidade      := cidade;
//          aRegistro.uf          := uf;
//          aRegistro.CEP         := cep;
//          aRegistro.ativo       := ativo;
//          aRegistro.contato     := contato;
//          aRegistro.telcontato  := telcontato;
//          aRegistro.email       := email;
//          aRegistro.Linguagem   := linguagem;
//          aRegistro.serial      := Serial;

         // Gravou := GravarNoBancoLicencas(aRegistro);

          if Gravou then
          begin
            if linguagem='Portugues' then
              ShowMessage('Pedido incluido com sucesso! Aguarde Retorno por E-mail/Ligação da Volcano sobre se pedido')
            else
              ShowMessage('Registration successfully added! Wait for an E-mail Return from Conect with your registration key');
          end;
        finally
          //aRegistro.Free;
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

procedure EnviarPedido.PrencherDadosDoPedido(aidcliente, aStatusPedido: Integer;
  aTotalPedido: Currency);
begin

end;

procedure EnviarPedido.Setbairro(const Value: string);
begin
  Fbairro := Value;
end;

procedure EnviarPedido.SetCelularContato(const Value: String);
begin
  FCelularContato := Value;
end;

procedure EnviarPedido.SetCEP(const Value: string);
begin
  FCEP := Value;
end;

procedure EnviarPedido.Setcidade(const Value: string);
begin
  Fcidade := Value;
end;

procedure EnviarPedido.Setcnpj(const Value: string);
begin
  Fcnpj := Value;
end;

procedure EnviarPedido.Setcomplemento(const Value: string);
begin
  Fcomplemento := Value;
end;

procedure EnviarPedido.Setcontato(const Value: string);
begin
  Fcontato := Value;
end;

procedure EnviarPedido.Setemail(const Value: string);
begin
  Femail := Value;
end;

procedure EnviarPedido.SetEmailContato(const Value: String);
begin
  FEmailContato := Value;
end;

procedure EnviarPedido.Setendereco(const Value: string);
begin
  Fendereco := Value;
end;

procedure EnviarPedido.SetidCliente(const Value: Integer);
begin
  FidCliente := Value;
end;

procedure EnviarPedido.SetidPedido(const Value: Integer);
begin
  FidPedido := Value;
end;

procedure EnviarPedido.SetidProduto(const Value: Integer);
begin
  FidProduto := Value;
end;

procedure EnviarPedido.Setie(const Value: string);
begin
  Fie := Value;
end;

procedure EnviarPedido.Setim(const Value: string);
begin
  Fim := Value;
end;

procedure EnviarPedido.SetLinguagem(const Value: string);
begin
  FLinguagem := Value;
end;

procedure EnviarPedido.SetNomeContato(const Value: String);
begin
  FNomeContato := Value;
end;

procedure EnviarPedido.Setnumero(const Value: integer);
begin
  Fnumero := Value;
end;

procedure EnviarPedido.SetPrecoUnitario(const Value: Currency);
begin
  FPrecoUnitario := Value;
end;

procedure EnviarPedido.SetQuantidade(const Value: Integer);
begin
  FQuantidade := Value;
end;

procedure EnviarPedido.Setrazao(const Value: string);
begin
  Frazao := Value;
end;

procedure EnviarPedido.Setresponsavel(const Value: string);
begin
  Fresponsavel := Value;
end;

procedure EnviarPedido.SetStatusPedido(const Value: Integer);
begin
  FStatusPedido := Value;
end;

procedure EnviarPedido.Settelcontato(const Value: string);
begin
  Ftelcontato := Value;
end;

procedure EnviarPedido.Settelefone(const Value: string);
begin
  Ftelefone := Value;
end;

procedure EnviarPedido.SetTelefoneConteto(const Value: String);
begin
  FTelefoneConteto := Value;
end;

procedure EnviarPedido.SetTotaldoItem(const Value: Currency);
begin
  FTotaldoItem := Value;
end;

procedure EnviarPedido.SetTotalPedido(const Value: currency);
begin
  FTotalPedido := Value;
end;

procedure EnviarPedido.Setuf(const Value: string);
begin
  Fuf := Value;
end;

end.
