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
      class function AlterarCliente(aCliente: TClientes): Boolean;

      //Delete
      function RemoverCliente(aCliente: TClientes): Boolean;

      //Regras
      class function TestaSeCamposPreenchidos(aCliente: TClientes): Boolean;
      class function ClienteExiste(aCNPJ: string):Boolean;

      constructor Create;
      destructor destroy;override;

  end;


implementation

{ TModelCliente }

class function TModelCliente.AlterarCliente(aCliente: TClientes): Boolean;
var
   qry: TFDQuery;
   UF: String;
   Ativo: String;
begin
  Result:=False;

  qry:=TFDQuery.Create(nil);
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
                  'uf          = :uf,           ' +
                  'datacadastro= :datacadastro  ' +
                  'WHERE                        ' +
                  'CNPJ_CPF = :CNPJ_CPF         ';

    qry.ParamByName('idclientes').DataType    := ftInteger;
    qry.ParamByName('idclientes').AsInteger   := aCliente.idcliente;
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

    qry.ParamByName('uf').DataType            := ftString;

    if Length(aCliente.UF) > 0 then
      UF := Copy(aCliente.UF, 1, 2)
    else
      UF := '';

    qry.ParamByName('uf').AsString            := UF;

    qry.ParamByName('ativo').DataType         := ftString;
    if Length(aCliente.ativo) > 0 then
      Ativo := Copy(aCliente.ativo, 1, 1)
    else
      Ativo := '';

    qry.ParamByName('ativo').AsString         := Ativo;

    qry.ParamByName('datacadastro').DataType  := ftDateTime;
    qry.ParamByName('datacadastro').AsDateTime:= aCliente.datacadastro;

    qry.ParamByName('CNPJ_CPF').DataType       := ftString;
    qry.ParamByName('CNPJ_CPF').AsString       := aCliente.cnpj;

    qry.ExecSQL;

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
    qry.SQL.Add('SELECT * FROM CLIENTES ');
    qry.SQL.Add('WHERE ATIVO=''S''      ');
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

destructor TModelCliente.destroy;
begin
  FCliente.Free;
  inherited;
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

function TModelCliente.RemoverCliente(aCliente: TClientes): Boolean;
var
  Ativo: string;
begin
  Result:= False;

  qry:= TFDQuery.Create(nil);
  qry.Connection:= TConnection.CreateConnection;
  try

    qry.Close;
    qry.SQL.Text := 'UPDATE fulanorodas.clientes ' +
                  'SET                           ' +
                  'ativo       = ''N''           ' +
                  'WHERE IDCLIENTES=:IDCLIENTES';
    qry.ParamByName('IDCLIENTES').DataType:= ftInteger;
    qry.ParamByName('IDCLIENTES').AsInteger:= aCliente.idcliente;

    qry.ExecSQL;

    Result := True;
  finally
    qry.Free;
  end;

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

     qry.ParamByName('uf').DataType            := ftString;
     if Length(aCliente.UF) > 0 then
       UF := Copy(aCliente.UF, 1, 2)
     else
       UF := '';

     qry.ParamByName('uf').AsString            := UF;

     qry.ParamByName('ativo').DataType         := ftString;
     if Length(aCliente.ativo) > 0 then
       Ativo := Copy(aCliente.ativo, 1, 1)
     else
       Ativo := '';

     qry.ParamByName('ativo').AsString         := Ativo;

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
    raise Exception.Create('O CEP não pode ser menor que 8 caracteres.');
    Result:= False;
    exit;
  end;

  if Trim(aCliente.CEP) ='' then
  begin
    raise Exception.Create('O CEP não pode vazio.');
    Result:= False;
    exit;
  end;

  if Trim(aCliente.Endereco) = '' then
  begin
    raise Exception.Create('É necessário prencher o Endereço.');
    Result:= False;
    exit;
  end;

  if Trim(aCliente.uf) = '' then
  begin
    raise Exception.Create('É necessário preencher a UF.');
    Result:= False;
    exit;
  end;

  if Trim(aCliente.Cidade) = '' then
  begin
    raise Exception.Create('É necessário preencher a Cidade.');
    Result:= False;
    exit;
  end;

  if Trim(aCliente.Bairro) = '' then
  begin
    raise Exception.Create('É necessário preencher o Bairro.');
    Result:= False;
    exit;
  end;

  Result:= True;

end;

end.
