unit Model.Fabricantes;

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
  Entity.Fabricantes,
  FireDAC.Comp.Client,
  System.Generics.Collections,
  Dao.Conexao,
  Datasnap.DBClient;

type
  TModelFabricante = class
    private
      Fconn: TFDConnection;
      qry: TFDQuery;
    public
      FFabricante: TFabricante;

      //create
      Class function SalvarFabricante(aFabricante: TFabricante): Boolean;

      //Read
      function CarregarFabricante(const ACNPJ: String): TFabricante;
      function CarregarTodosFabricantes(aDataSet: TClientDataSet): TFDquery; //ok
      function ObterFabricantePorId(aId: Integer): TFDQuery;

      //Update
      class function AlterarFabricante(aFabricante: TFabricante): Boolean;

      //Delete
      function RemoverFabricante(aFabricante: TFabricante): Boolean;

      //Regras
      class function TestaSeCamposPreenchidos(aFabricante: TFabricante): Boolean;
      class function FabricanteExiste(aCNPJ: string):Boolean;

      constructor Create;
      destructor destroy;override;

  end;


implementation

{ TModelFabricante }

{ TModelFabricante }

class function TModelFabricante.AlterarFabricante(
  aFabricante: TFabricante): Boolean;
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
    qry.SQL.Text:='UPDATE FABRICANTES              ' +
                  'SET                             ' +
                  'idfabricantes = :idfabricantes, ' +
                  'razao         = :razao,         ' +
                  'cnpj          = :cnpj,          ' +
                  'endereco      = :endereco,      ' +
                  'numero        = :numero,        ' +
                  'complemento   = :complemento,   ' +
                  'cep           = :cep,           ' +
                  'cidade        = :cidade,        ' +
                  'bairro        = :bairro,        ' +
                  'ativo         = :ativo,         ' +
                  'uf            = :uf,            ' +
                  //'datacadastro  = now,            ' +
                  'datalateracao = now,            ' +
                  'WHERE                           ' +
                  'CNPJ          = :CNPJ           ';

    qry.ParamByName('idfabricantes').DataType   := ftInteger;
    qry.ParamByName('idfabricantes').AsInteger  := aFabricante.idFabricantes;
    qry.ParamByName('razao').DataType           := ftString;
    qry.ParamByName('razao').AsString           := aFabricante.razaosocial;
    qry.ParamByName('cnpj').DataType            := ftString;
    qry.ParamByName('cnpj').AsString            := aFabricante.cnpj ;
    qry.ParamByName('endereco').DataType        := ftString;
    qry.ParamByName('endereco').AsString        := aFabricante.endereco;
    qry.ParamByName('numero').DataType          := ftInteger;
    qry.ParamByName('numero').AsInteger         := aFabricante.numero;
    qry.ParamByName('complemento').DataType     := ftString;
    qry.ParamByName('complemento').AsString     := aFabricante.complemento;
    qry.ParamByName('cep').DataType             := ftString;
    qry.ParamByName('cep').AsString             := aFabricante.CEP;
    qry.ParamByName('cidade').DataType          := ftString;
    qry.ParamByName('cidade').AsString          := aFabricante.Cidade;
    qry.ParamByName('bairro').DataType          := ftString;
    qry.ParamByName('bairro').AsString          := aFabricante.Bairro;

    qry.ParamByName('uf').DataType              := ftString;

    if Length(aFabricante.UF) > 0 then
      UF := Copy(aFabricante.UF, 1, 2)
    else
      UF := '';

    qry.ParamByName('uf').AsString              := UF;

    qry.ParamByName('ativo').DataType           := ftString;
    if Length(aFabricante.ativo) > 0 then
      Ativo := Copy(aFabricante.ativo, 1, 1)
    else
      Ativo := '';

    qry.ParamByName('ativo').AsString           := Ativo;

    qry.ParamByName('dataalteracao').DataType   := ftDatetime;
    qry.ParamByName('dataalteracao').AsDateTime := aFabricante.DataAlteracao;

    qry.ParamByName('CNPJ').DataType            := ftString;
    qry.ParamByName('CNPJ').AsString            := aFabricante.cnpj;

    qry.ExecSQL;

    Result:=True;

  finally
    qry.Free;
  end;


end;

function TModelFabricante.CarregarFabricante(const ACNPJ: String): TFabricante;
var
 qry: TFDQuery;
begin
  Result:= Nil;

  qry:= TFDquery.Create(nil);
  qry.Connection:= Fconn;
  try
    qry.SQL.Clear;
    qry.SQL.Text:='SELECT * FROM FABRICANTES ' +
                  'WHERE CNPJ=:CNPJ';
    qry.ParamByName('CNPJ').DataType:= ftString;
    qry.ParamByName('CNPJ').AsString := ACNPJ;
    qry.Open;

    if qry.RecordCount > 0 then
    begin
      FFabricante.idfabricantes := qry.FieldByName('idclientes').AsInteger;
      FFabricante.razaosocial   := qry.FieldByName('razao').AsString;
      FFabricante.cnpj          := qry.FieldByName('cnpj_cpf').AsString;
      FFabricante.endereco      := qry.FieldByName('endereco').AsString;
      FFabricante.complemento   := qry.FieldByName('complemento').AsString;
      FFabricante.numero        := qry.FieldByName('numero').AsInteger;
      FFabricante.cep           := qry.FieldByName('cep').AsString;
      FFabricante.cidade        := qry.FieldByName('cidade').AsString;
      FFabricante.bairro        := qry.FieldByName('bairro').AsString;
      FFabricante.uf            := qry.FieldByName('uf').AsString;
      FFabricante.ativo         := qry.FieldByName('ativo').AsString;
      Result:= FFabricante;
    end;

  finally
    qry.Free;
  end;

end;

function TModelFabricante.CarregarTodosFabricantes(
  aDataSet: TClientDataSet): TFDquery;
begin
  qry:= TFDquery.Create(nil);
  qry.Connection:= TConnection.CreateConnection;
  try
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM FABRICANTES ');
    qry.SQL.Add('WHERE ATIVO=''S''      ');
    qry.SQL.Add('ORDER BY IDFABRICANTES ASC');
    qry.Open;

    qry.First;

    Result := Qry;
  except
    Result := nil;
  end;
end;

constructor TModelFabricante.Create;
begin
  FFabricante := TFabricante.create;
end;

destructor TModelFabricante.destroy;
begin
  FFabricante.Free;
  inherited;
end;

class function TModelFabricante.FabricanteExiste(aCNPJ: string): Boolean;
var
  qry: TFDQuery;
begin
  Result:= False;

  qry:= TFDquery.Create(nil);
  qry.Connection:= TConnection.CreateConnection;
  try
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM FABRICANTES');
    qry.SQL.Add('WHERE CNPJ=:CNPJ');
    qry.ParamByName('CNPJ').DataType := ftString;
    qry.ParamByName('CNPJ').AsString := acNPJ;
    qry.Open;

    if qry.RecordCount > 0 then
      Result:= True;

  finally
    qry.Free;
  end;

end;

function TModelFabricante.ObterFabricantePorId(aId: Integer): TFDQuery;
begin
  qry:= TFDQuery.Create(nil);
  qry.Connection:= TConnection.CreateConnection;
  try

    qry.Close;
    qry.SQL.Text := 'SELECT * FROM FABRICANTES ' +
                  'WHERE IDFABRICANTES=:IDFABRICANTES';
    qry.ParamByName('IDFABRICANTES').DataType:= ftInteger;
    qry.ParamByName('IDFABRICANTES').AsInteger:= aId;
    qry.Open;

    Result := qry;
  finally
     qry.Free;
  end;
end;

function TModelFabricante.RemoverFabricante(aFabricante: TFabricante): Boolean;
var
  Ativo: string;
begin
  Result:= False;

  qry:= TFDQuery.Create(nil);
  qry.Connection:= TConnection.CreateConnection;
  try

    qry.Close;
    qry.SQL.Text := 'UPDATE fabricantes                ' +
                    'SET                               ' +
                    'ativo       = ''N''               ' +
                    'WHERE IDFABRICANTES=:IDFABRICANTES';
    qry.ParamByName('IDFABRICANTES').DataType:= ftInteger;
    qry.ParamByName('IDFABRICANTES').AsInteger:= aFabricante.idfabricantes;

    qry.ExecSQL;

    Result := True;
  finally
    qry.Free;
  end;

end;

class function TModelFabricante.SalvarFabricante(
  aFabricante: TFabricante): Boolean;
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
    qry.SQL.Add('INSERT INTO '     +
                ' fabricantes '    +
                '(idfabricantes, ' +
                'razao, '          +
                'cnpj, '           +
                'endereco, '       +
                'numero, '         +
                'complemento, '    +
                'cep, '            +
                'cidade, '         +
                'bairro, '         +
                'ativo, '          +
                'datacadastro, '   +
                'dataalteracao, '  +
//                'dataexclusao, '   +
                'uf) '             +
                'VALUES ('         +
                ':idclientes, '    +
                ':razao, '         +
                ':cnpj_cpf, '      +
                ':endereco, '      +
                ':numero,  '       +
                ':complemento, '   +
                ':cep, '           +
                ':cidade, '        +
                ':bairro, '        +
                ':ativo, '         +
                ':datacadastro, '  +
                ':dataalteracao, ' +
//                ':dataexclusao, '  +
                ':uf)');

     qry.ParamByName('idclientes').DataType    := ftInteger;
     qry.ParamByName('razao').DataType         := ftString;
     qry.ParamByName('razao').AsString         := aFabricante.razaosocial;
     qry.ParamByName('cnpj_cpf').DataType      := ftString;
     qry.ParamByName('cnpj_cpf').AsString      := aFabricante.cnpj ;
     qry.ParamByName('endereco').DataType      := ftString;
     qry.ParamByName('endereco').AsString      := aFabricante.endereco;
     qry.ParamByName('numero').DataType        := ftInteger;
     qry.ParamByName('numero').AsInteger       := aFabricante.numero;
     qry.ParamByName('complemento').DataType   := ftString;
     qry.ParamByName('complemento').AsString   := aFabricante.complemento;
     qry.ParamByName('cep').DataType           := ftString;
     qry.ParamByName('cep').AsString           := aFabricante.CEP;
     qry.ParamByName('cidade').DataType        := ftString;
     qry.ParamByName('cidade').AsString        := aFabricante.Cidade;
     qry.ParamByName('bairro').DataType        := ftString;
     qry.ParamByName('bairro').AsString        := aFabricante.Bairro;

     qry.ParamByName('uf').DataType            := ftString;
     if Length(aFabricante.UF) > 0 then
       UF := Copy(aFabricante.UF, 1, 2)
     else
       UF := '';

     qry.ParamByName('uf').AsString            := UF;

     qry.ParamByName('ativo').DataType         := ftString;
     if Length(aFabricante.ativo) > 0 then
       Ativo := Copy(aFabricante.ativo, 1, 1)
     else
       Ativo := '';

     qry.ParamByName('ativo').AsString         := Ativo;

     qry.ParamByName('datacadastro').DataType:= ftDateTime;
     qry.ParamByName('datacadastro').AsDateTime:= Now;

     qry.ParamByName('dataalteracao').DataType:= ftDateTime;
     qry.ParamByName('dataalteracao').AsDateTime:= Now;

     qry.ExecSQL;

     Result:=True;

  finally
    qry.Close;
    qry.Free;
  end;

end;

class function TModelFabricante.TestaSeCamposPreenchidos(
  aFabricante: TFabricante): Boolean;
begin
  Result:=False;

  if aFabricante.CEP.Length < 8  then
  begin
    raise Exception.Create('O CEP não pode ser menor que 8 caracteres.');
    Result:= False;
    exit;
  end;

  if Trim(aFabricante.CEP) ='' then
  begin
    raise Exception.Create('O CEP não pode vazio.');
    Result:= False;
    exit;
  end;

  if Trim(aFabricante.Endereco) = '' then
  begin
    raise Exception.Create('É necessário prencher o Endereço.');
    Result:= False;
    exit;
  end;

  if Trim(aFabricante.uf) = '' then
  begin
    raise Exception.Create('É necessário preencher a UF.');
    Result:= False;
    exit;
  end;

  if Trim(aFabricante.Cidade) = '' then
  begin
    raise Exception.Create('É necessário preencher a Cidade.');
    Result:= False;
    exit;
  end;

  if Trim(aFabricante.Bairro) = '' then
  begin
    raise Exception.Create('É necessário preencher o Bairro.');
    Result:= False;
    exit;
  end;

  Result:= True;

end;

end.
