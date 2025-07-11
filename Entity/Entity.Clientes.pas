unit Entity.Clientes;

interface

uses
  System.SysUtils,
  System.Classes,
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
  Data.DB,
  FireDAC.Comp.Client,
  System.IniFiles,
  FireDAC.Phys.PGDef,
  FireDAC.Phys.PG,
  FireDAC.Comp.UI,
  FireDAC.DApt,
  Dao.Conexao,
  FireDAC.Phys.MySQLDef,
  FireDAC.Phys.MySQL,
  FMX.Dialogs,
  Datasnap.DBClient;

type
  TClientes = class
    private
      Fidcliente: Integer;
      Fcnpj: string;
      Fativo: string;
      FCEP: string;
      Fnumero: integer;
      Frazaosocial: string;
      Fcomplemento: string;
      Fendereco: string;
      FUF: string;
      FCidade: string;
      FBairro: string;
      FConn: TFDConnection;
      FdataExclusao: TDateTime;
      FdataAlteracao: TDateTime;
      FdataCadastro: TDatetime;
      Fidmodelocarro: integer;

    procedure Setativo(const Value: string);
    procedure SetCEP(const Value: string);
    procedure Setcnpj(const Value: string);
    procedure Setcomplemento(const Value: string);
    procedure Setendereco(const Value: string);
    procedure Setnumero(const Value: integer);
    procedure Setrazaosocial(const Value: string);
    procedure SetUF(const Value: string);
    procedure SetCidade(const Value: string);
    procedure SetBairro(const Value: string);
    procedure Setidcliente(const Value: Integer);
    procedure SetdataAlteracao(const Value: TDateTime);
    procedure SetdataCadastro(const Value: TDatetime);
    procedure SetdataExclusao(const Value: TDateTime);
    procedure Setidmodelocarro(const Value: integer);

    public
      property idcliente: Integer read Fidcliente write Setidcliente;
      property razaosocial: string read Frazaosocial write Setrazaosocial;
      property cnpj: string read Fcnpj write Setcnpj;
      property endereco: string read Fendereco write Setendereco;
      property numero: integer read Fnumero write Setnumero;
      property complemento: string read Fcomplemento write Setcomplemento;
      property CEP: string read FCEP write SetCEP;
      property Cidade: string read FCidade write SetCidade;
      property Bairro: string read FBairro write SetBairro;
      property UF: string read FUF write SetUF;
      property ativo: string read Fativo write Setativo;
      property dataCadastro: TDatetime read FdataCadastro write SetdataCadastro;
      property dataAlteracao: TDateTime read FdataAlteracao write SetdataAlteracao;
      property dataExclusao: TDateTime read FdataExclusao write SetdataExclusao;
      property idmodelocarro: integer read Fidmodelocarro write Setidmodelocarro;

      constructor create;
      destructor destroy;override;

  end;

implementation

{ TClientes }

constructor TClientes.create;
begin
  FConn:= TConnection.CreateConnection;
end;

destructor TClientes.destroy;
begin
  FConn.Free;
  inherited;
end;

procedure TClientes.Setativo(const Value: string);
begin
  Fativo := Value;
end;

procedure TClientes.SetBairro(const Value: string);
begin
  FBairro := Value;
end;

procedure TClientes.SetCEP(const Value: string);
begin
  FCEP := Value;
end;

procedure TClientes.SetCidade(const Value: string);
begin
  FCidade := Value;
end;

procedure TClientes.Setcnpj(const Value: string);
begin
  Fcnpj := Value;
end;

procedure TClientes.Setcomplemento(const Value: string);
begin
  Fcomplemento := Value;
end;

procedure TClientes.SetdataAlteracao(const Value: TDateTime);
begin
  FdataAlteracao := Value;
end;

procedure TClientes.SetdataCadastro(const Value: TDatetime);
begin
  FdataCadastro := Value;
end;

procedure TClientes.SetdataExclusao(const Value: TDateTime);
begin
  FdataExclusao := Value;
end;

procedure TClientes.Setendereco(const Value: string);
begin
  Fendereco := Value;
end;

procedure TClientes.Setidcliente(const Value: Integer);
begin
  Fidcliente := Value;
end;

procedure TClientes.Setidmodelocarro(const Value: integer);
begin
  Fidmodelocarro := Value;
end;

procedure TClientes.Setnumero(const Value: integer);
begin
  Fnumero := Value;
end;

procedure TClientes.Setrazaosocial(const Value: string);
begin
  Frazaosocial := Value;
end;

procedure TClientes.SetUF(const Value: string);
begin
  FUF := Value;
end;

end.
