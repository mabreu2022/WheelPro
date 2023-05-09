unit DAO.Clientes;

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
  FireDAC.Phys.MySQL;

type
  TClientes = class
    private
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
    FCliente : TClientes;
    FConn: TFDConnection;
    qry: TFDQuery;

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

    public

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

      function ObterClientePorId(Id: Integer): TClientes;
      function CarregarTodosClientes: TClientes;
      procedure SalvarCliente(Cliente: TClientes);
      procedure RemoverCliente(Cliente: TClientes);

      constructor create;
      destructor destroy;override;

  end;

implementation

{ TCadastroClientes }

function TClientes.CarregarTodosClientes: TClientes;
begin
  try
     qry.close;
     qry.sql.text:='SELECT * FROM CLIENTES WHERE IDCLIENTES=:IDCLIENTES';
     qry.open;

     //Carregar Classe  de clientes
     razaosocial := qry.FieldByName('RAZAO').AsString;
     cnpj        := qry.FieldByName('CNPJ').AsString;
     endereco    := qry.FieldByName('ENDERECO').AsString;
     numero      := qry.FieldByName('NUMERO').AsInteger;
     complemento := qry.FieldByName('COMPLEMENTO').AsString;
     cep         := qry.FieldByName('CEP').AsString;
     cidade      := qry.FieldByName('CIDADE').AsString;
     bairro      := qry.FieldByName('BAIRRO').AsString;
     ativo       := qry.FieldByName('ATIVO').AsString;

     //Associar os valores aos campos na tela ?


  finally
     qry.Free;
  end;
end;

constructor TClientes.create;
begin
  FConn             := TConnection.CreateConnection;
  FCliente          := TClientes.Create;
  Qry               := TFDQuery.Create(nil);
  Qry.Connection    := FConn;
end;

destructor TClientes.destroy;
begin
  FConn.Free;
  FCliente.Free;
  Qry.Free;
  inherited;
end;

function TClientes.ObterClientePorId(Id: Integer): TClientes;
var
  Clientes: TArray<TClientes>;
  i: Integer;
begin
  qry.Close;
  qry.SQL.Text := 'SELECT * FROM CLIENTES';
  qry.Open;

  qry.First;
  SetLength(Clientes, qry.RecordCount);

  i := 0;
  while not qry.Eof do
  begin
    Clientes[i]             := TClientes.Create;
    Clientes[i].RazaoSocial := qry.FieldByName('RAZAO').AsString;
    Clientes[i].Cnpj        := qry.FieldByName('CNPJ').AsString;
    Clientes[i].Endereco    := qry.FieldByName('ENDERECO').AsString;
    Clientes[i].Numero      := qry.FieldByName('NUMERO').AsInteger;
    Clientes[i].Complemento := qry.FieldByName('COMPLEMENTO').AsString;
    Clientes[i].Cep         := qry.FieldByName('CEP').AsString;
    Clientes[i].Cidade      := qry.FieldByName('CIDADE').AsString;
    Clientes[i].Bairro      := qry.FieldByName('BAIRRO').AsString;
    Clientes[i].Ativo       := qry.FieldByName('ATIVO').AsString;

    qry.Next;
    Inc(i);
  end;

  qry.Close;

  Result := Clientes[i];

end;

procedure TClientes.RemoverCliente(Cliente: TClientes);
begin
  try

  finally

  end;
end;

procedure TClientes.SalvarCliente(Cliente: TClientes);
begin
  try

  finally

  end;
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

procedure TClientes.Setendereco(const Value: string);
begin
  Fendereco := Value;
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
