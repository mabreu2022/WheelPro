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
  FireDAC.Phys.MySQL,
  FMX.Dialogs,
  Datasnap.DBClient;

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

      function ObterClientePorId(aId: Integer): TFDQuery;
      function CarregarTodosClientes(aDataSet: TClientDataSet): TFDquery;
      procedure SalvarCliente(Cliente: TClientes);
      function RemoverCliente(aId: Integer): Boolean;
      function ClienteExiste(aCNPJ: string):Boolean;

      constructor create;
      destructor destroy;override;

  end;

implementation

{ TCadastroClientes }

function TClientes.CarregarTodosClientes(aDataSet: TClientDataSet):TFDquery;
begin
  try
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM CLIENTES');
    qry.Open;

    Result := Qry;
  except
    Result := nil;
  end;
end;

function TClientes.ClienteExiste(aCNPJ: string): Boolean;
begin
  Result:= False;
  qry:= TFDquery.Create(nil);
  try
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM CLIENTES');
    qry.SQL.Add('WHERE CNPJ_CPF=:CNPJ_CPF');
    qry.ParamByName('cnpj_cpf').DataType := ftString;
    qry.ParamByName('cnpj_cpf').AsString := acNPJ;
    qry.Open;

    if qry.RecordCount > 0 then
      Result:= True;

  finally
    qry.Free;
  end;
end;

constructor TClientes.create;
begin
  FConn             := TConnection.CreateConnection;
  //FCliente          := TClientes.Create;
  Qry               := TFDQuery.Create(nil);
  Qry.Connection    := FConn;
end;

destructor TClientes.destroy;
begin
  FConn.Free;
  Qry.Free;
  inherited;
end;

function TClientes.ObterClientePorId(aId: Integer): TFDQuery;
begin
  qry.Close;
  qry.SQL.Text := 'SELECT * FROM CLIENTES ' +
                  'WHERE IDCLIENTES=:IDCLIENTES';
  qry.ParamByName('IDCLIENTES').DataType:= ftInteger;
  qry.ParamByName('IDCLIENTES').AsInteger:= aId;
  qry.Open;

  Result := qry;

end;

function TClientes.RemoverCliente(aId: Integer):Boolean;
begin
  try

  finally

  end;
end;

procedure TClientes.SalvarCliente(Cliente: TClientes);
var
  Ativo : string;
  UF    : string;
begin
  try
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('INSERT INTO '  +
                ' Clientes '    +
                '(idclientes, ' +
                'razao, '       +
                'cnpj_cpf, '    +
                'endereco, '    +
                'numero, '      +
                'complemento, ' +
                'cep, '         +
                'cidade, '      +
                'bairro, '      +
                'ativo, '       +
                'uf) '          +
                'VALUES ('      +
                ':idclientes, ' +
                ':razao, '      +
                ':cnpj_cpf, '   +
                ':endereco, '   +
                ':numero,  '    +
                ':complemento, '+
                ':cep, '        +
                ':cidade, '     +
                ':bairro, '     +
                ':ativo, '      +
                ':uf)');

     qry.ParamByName('idclientes').DataType    := ftInteger;
     qry.ParamByName('razao').DataType         := ftString;
     qry.ParamByName('razao').AsString         := Cliente.razaosocial;
     qry.ParamByName('cnpj_cpf').DataType      := ftString;
     qry.ParamByName('cnpj_cpf').AsString      := Cliente.cnpj ;
     qry.ParamByName('endereco').DataType      := ftString;
     qry.ParamByName('endereco').AsString      := Cliente.endereco;
     qry.ParamByName('numero').DataType        := ftInteger;
     qry.ParamByName('numero').AsInteger       := Cliente.numero;
     qry.ParamByName('complemento').DataType   := ftString;
     qry.ParamByName('complemento').AsString   := Cliente.complemento;
     qry.ParamByName('cep').DataType           := ftString;
     qry.ParamByName('cep').AsString           := Cliente.CEP;
     qry.ParamByName('cidade').DataType        := ftString;
     qry.ParamByName('cidade').AsString        := Cliente.Cidade;
     qry.ParamByName('bairro').DataType        := ftString;
     qry.ParamByName('bairro').AsString        := Cliente.Bairro;

     qry.ParamByName('uf').DataType            := ftString; //ver como vai ser pois é CB

     if Length(Cliente.UF) > 0 then
       UF := Copy(Cliente.UF, 1, 2)
     else
       UF := '';

     qry.ParamByName('uf').AsString            := UF; //ver como vai ser pois é CB

     qry.ParamByName('ativo').DataType         := ftString; //ver como vai ser pois é CB

     if Length(Cliente.ativo) > 0 then
       Ativo := Copy(Cliente.ativo, 1, 1)
     else
       Ativo := '';

     qry.ParamByName('ativo').AsString         := Ativo; //ver como vai ser pois é CB

     qry.ExecSQL;

  finally
    qry.Close;
    qry.Free;
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
