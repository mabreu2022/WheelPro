unit Model.Clientes;

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
  Entity.Clientes,
  FireDAC.Comp.Client,
  System.Generics.Collections,
  Dao.Conexao,
  Datasnap.DBClient;

type
  TModelCliente = class
    private
      Fconn: TFDConnection;
      qry: TFDQuery;
    public
      FCliente: TClientes;

      //create
      Class function SalvarCliente(aCliente: TClientes): Boolean;

      //Read
      function CarregarClientes(const ACNPJ: String): TClientes;
      function CarregarTodosClientes(aDataSet: TClientDataSet): TFDquery; //ok
      function ObterClientePorId(aId: Integer): TFDQuery;

      //Update
      class function AlterarCliente(Cliente: TClientes): Boolean;

      //Delete
      function Deletar(const ACnpj: string): Boolean;
      function RemoverCliente(aId: Integer): Boolean;

      //Regras
      class function TestaSeCamposPreenchidos(aCliente: TClientes): Boolean;
      class function ClienteExiste(aCNPJ: string):Boolean;

      constructor Create;

  end;


implementation

{ TModelCliente }

class function TModelCliente.AlterarCliente(Cliente: TClientes): Boolean;
var
   qry: TFDQuery;
begin
  Result:=False;

  qry:=qry.Create(nil);
  qry.Connection := TConnection.CreateConnection;
  try
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Text:='UPDATE fulanorodas.clientes  ' +
                  'SET                          ' +
                  'idclientes  = :idclientes,   ' +
                  'razao       = :razao,        ' +
                  'cnpj_cpf    = :cnpj_cpf,     ' +
                  'endereco    = :endereco,     ' +
                  'numero      = :numero,       ' +
                  'complemento = :complemento,  ' +
                  'cep         = :cep,          ' +
                  'cidade      = :cidade,       ' +
                  'bairro      = :bairro,       ' +
                  'ativo       = :ativo,        ' +
                  'uf          = :uf            ' +
                  'WHERE                        ' +
                  'CNPJ_CPF = :CNP_CPF          ';
    qry.ParamByName('CNP_CPF').DataType    := ftString;
    qry.ParamByName('CNP_CPF').AsString    := Cliente.cnpj;

    qry.ExecSQL;

    if qry.RecordCount > 0 then
      Result:=True;

  finally
    qry.Free;
  end;

end;

function TModelCliente.CarregarClientes(const ACNPJ: String): TClientes;
var
 qry: TFDQuery;
begin
  Result:= Nil;

  qry:= TFDquery.Create(nil);
  qry.Connection:= Fconn;
  try
    qry.SQL.Clear;
    qry.SQL.Text:='SELECT * FROM CLIENTES ' +
                  'WHERE CNPJ_CPF=:CNPJ';
    qry.ParamByName('CNPJ').DataType:= ftString;
    qry.ParamByName('CNPJ').AsString := ACNPJ;
    qry.Open;

    if qry.RecordCount > 0 then
    begin
      FCliente.idcliente   := qry.FieldByName('idclientes').AsInteger;
      FCliente.razaosocial := qry.FieldByName('razao').AsString;
      FCliente.cnpj        := qry.FieldByName('cnpj_cpf').AsString;
      FCliente.endereco    := qry.FieldByName('endereco').AsString;
      FCliente.complemento := qry.FieldByName('complemento').AsString;
      FCliente.numero      := qry.FieldByName('numero').AsInteger;
      FCliente.cep         := qry.FieldByName('cep').AsString;
      FCliente.cidade      := qry.FieldByName('cidade').AsString;
      FCliente.bairro      := qry.FieldByName('bairro').AsString;
      FCliente.uf          := qry.FieldByName('uf').AsString;
      FCliente.ativo       := qry.FieldByName('ativo').AsString;
      Result:= FCliente;
    end;

  finally
    qry.Free;
  end;

end;

function TModelCliente.CarregarTodosClientes(
  aDataSet: TClientDataSet): TFDquery;
begin
  qry:= TFDquery.Create(nil);
  qry.Connection:= TConnection.CreateConnection;
  try
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM CLIENTES');
    qry.SQL.Add('ORDER BY IDCLIENTES ASC');
    qry.Open;

    qry.First;

    Result := Qry;
  except
    Result := nil;
  end;
end;

class function TModelCliente.ClienteExiste(aCNPJ: string): Boolean;
var
  qry: TFDQuery;
begin
  Result:= False;

  qry:= TFDquery.Create(nil);
  qry.Connection:= TConnection.CreateConnection;
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

constructor TModelCliente.Create;
begin
  FCliente          := TClientes.Create;
end;

function TModelCliente.Deletar(const ACnpj: string): Boolean;
begin
  //
end;

function TModelCliente.ObterClientePorId(aId: Integer): TFDQuery;
begin
  qry:= TFDQuery.Create(nil);
  qry.Connection:= TConnection.CreateConnection;
  try

    qry.Close;
    qry.SQL.Text := 'SELECT * FROM CLIENTES ' +
                  'WHERE IDCLIENTES=:IDCLIENTES';
    qry.ParamByName('IDCLIENTES').DataType:= ftInteger;
    qry.ParamByName('IDCLIENTES').AsInteger:= aId;
    qry.Open;

    Result := qry;
  finally
     qry.Free;
  end;
end;

function TModelCliente.RemoverCliente(aId: Integer): Boolean;
begin

end;

class function TModelCliente.SalvarCliente(aCliente: TClientes): Boolean;
var
  qry   : TFDQuery;
  Ativo : string;
  UF    : string;
begin
  Result:= False;

  qry:=TFDQuery.Create(nil);
  qry.Connection := TConnection.CreateConnection;
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
     qry.ParamByName('razao').AsString         := aCliente.razaosocial;
     qry.ParamByName('cnpj_cpf').DataType      := ftString;
     qry.ParamByName('cnpj_cpf').AsString      := aCliente.cnpj ;
     qry.ParamByName('endereco').DataType      := ftString;
     qry.ParamByName('endereco').AsString      := aCliente.endereco;
     qry.ParamByName('numero').DataType        := ftInteger;
     qry.ParamByName('numero').AsInteger       := aCliente.numero;
     qry.ParamByName('complemento').DataType   := ftString;
     qry.ParamByName('complemento').AsString   := aCliente.complemento;
     qry.ParamByName('cep').DataType           := ftString;
     qry.ParamByName('cep').AsString           := aCliente.CEP;
     qry.ParamByName('cidade').DataType        := ftString;
     qry.ParamByName('cidade').AsString        := aCliente.Cidade;
     qry.ParamByName('bairro').DataType        := ftString;
     qry.ParamByName('bairro').AsString        := aCliente.Bairro;

     qry.ParamByName('uf').DataType            := ftString; //ver como vai ser pois � CB

     if Length(aCliente.UF) > 0 then
       UF := Copy(aCliente.UF, 1, 2)
     else
       UF := '';

     qry.ParamByName('uf').AsString            := aCliente.UF; //ver como vai ser pois � CB

     qry.ParamByName('ativo').DataType         := ftString; //ver como vai ser pois � CB

     if Length(aCliente.ativo) > 0 then
       Ativo := Copy(aCliente.ativo, 1, 1)
     else
       Ativo := '';

     qry.ParamByName('ativo').AsString         := aCliente.Ativo; //ver como vai ser pois � CB

     qry.ExecSQL;

     Result:=True;

  finally
    qry.Close;
    qry.Free;
  end;

end;

class function TModelCliente.TestaSeCamposPreenchidos(aCliente: TClientes): Boolean;
begin
  Result:=False;

  if aCliente.CEP.Length < 8  then
  begin
    raise Exception.Create('O CEP n�o pode ser menor que 8 caracteres.');
    Result:= False;
    exit;
  end;

  if Trim(aCliente.CEP) ='' then
  begin
    raise Exception.Create('O CEP n�o pode vazio.');
    Result:= False;
    exit;
  end;

  if Trim(aCliente.Endereco) = '' then
  begin
    raise Exception.Create('� necess�rio prencher o Endere�o.');
    Result:= False;
    exit;
  end;

  if Trim(aCliente.uf) = '' then
  begin
    raise Exception.Create('� necess�rio preencher a UF.');
    Result:= False;
    exit;
  end;

  if Trim(aCliente.Cidade) = '' then
  begin
    raise Exception.Create('� necess�rio preencher a Cidade.');
    Result:= False;
    exit;
  end;

  if Trim(aCliente.Bairro) = '' then
  begin
    raise Exception.Create('� necess�rio preencher o Bairro.');
    Result:= False;
    exit;
  end;

  //Testar se o cliente j� existe no Cadastro e n�o deixar incluir se sim.


  Result:= True;
end;

end.
