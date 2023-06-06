unit Model.Contatos;

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
  FireDAC.Comp.Client,
  Data.DB,
  Entity.Clientes,
  System.Generics.Collections,
  Dao.Conexao,
  Datasnap.DBClient,
  Entity.Contatos,
  LogManager,
  FMX.Dialogs;

type
  TModelContato = class
    private
      Fconn: TFDConnection;
      FSomenteAtivos: string;
      FGravarLog: Boolean;
      class  var  qry: TFDQuery;
    procedure SetSomenteAtivos(const Value: string);
    public
      FContatos : TContato;

      property SomenteAtivos: string read FSomenteAtivos write SetSomenteAtivos;
      //create
      Class function SalvarContato(aContato: TContato; aCliente: TClientes): Boolean;

      //Read
      function CarregarContatos(const aId: Integer): TContato;
      function CarregarTodosContatos(
               aDataSet: TClientDataSet; aSomenteAtivos: string): TFDquery; //ok

      class function ObterContatoPorId(aId: Integer): TFDQuery;

      //Update
      class function AlterarContato(aContato: TContato): Boolean;

      //Delete
      function RemoverContato(aContato: TContato): Boolean;

      //Regras
      class function TestaSeCamposPreenchidos(
  aContato: TContato): Boolean;
//      class function ContatoExiste(aCNPJ: string):Boolean;

      constructor Create;
      destructor destroy;override;
  end;

implementation

{ TModelContato }

class function TModelContato.AlterarContato(aContato: TContato): Boolean;
var
   qry             : TFDQuery;
   UF              : String;
   Ativo           : String;
   LogManager      : TLogManager;
   CurrentDateTime : TDateTime;
   DateTimeStr     : string;
begin
  Result := False;

  LogManager := TLogManager.Create;
  try
    CurrentDateTime := Now;
    DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
    LogManager.AddLog('Classe Model.Contatos - Linha : 83 - Entrou no Alterar Contato e criou a qry às ' + DateTimeStr);
    LogManager.SaveLogToFile('Log_Model_Clientes.txt');
  finally
    LogManager.Free;
  end;

  qry:=TFDQuery.Create(nil);
  qry.Connection := TConnection.CreateConnection;
  qry.Connection.StartTransaction;
  try
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Text:='UPDATE fulanorodas.contatos    ' +
                  'SET                            ' +
                  //'idcontatos    = :idcontatos  ' +
                  'idclientes    = :idclientes,   ' +
                  'telefone      = :telefone,     ' +
                  'celular       = :celular,      ' +
                  'email         = :email,        ' +
                  'cnpjrevenda   = :cnpjrevenda,  ' +
                  'ativo         = :ativo,        ' +
                  'nomecontato   = :nomecontato,  ' +
                  'datacadastro  = :datacadastro, ' +
                  'dataalteracao = :dataalteracao ' +
                  //'dataexclusao  = :dataexclusao  ' +
                  'WHERE                          ' +
                  'idcontatos = :idcontatos       ';

    qry.ParamByName('idclientes').DataType      := ftInteger;
    qry.ParamByName('idclientes').AsInteger     := aContato.idcliente;
    qry.ParamByName('telefone').DataType        := ftString;
    qry.ParamByName('telefone').AsString        := aContato.telefone;
    qry.ParamByName('celular').DataType         := ftString;
    qry.ParamByName('celular').AsString         := aContato.celular;
    qry.ParamByName('email').DataType           := ftString;
    qry.ParamByName('email').AsString           := aContato.email;
    qry.ParamByName('cnpjrevenda').DataType     := ftString;
    qry.ParamByName('cnpjrevenda').AsString     := aContato.cnpjrevenda;
    qry.ParamByName('ativo').DataType           := ftString;
    qry.ParamByName('ativo').AsString           := aContato.ativo;
    qry.ParamByName('nomecontato').DataType     := ftString;
    qry.ParamByName('nomecontato').AsString     := aContato.NomeContato;
    qry.ParamByName('datacadastro').DataType    := ftDateTime;
    qry.ParamByName('datacadastro').AsDateTime  := aContato.datacadastro;
    qry.ParamByName('dataalteracao').DataType   := ftDateTime;
    qry.ParamByName('dataalteracao').AsDateTime := aContato.dataAlteracao;
    qry.ParamByName('idcontatos').DataType      := ftInteger;
    qry.ParamByName('idcontatos').AsInteger     := aContato.idcontato;

    qry.ExecSQL;
    qry.Connection.Commit;

    Result:=True;

  Except
    on E: Exception do
    begin
      Result := False;
      qry.Connection.Rollback;
      ShowMessage('Houve um erro ao tentar alterar os dados do contato' + E.Message);

      LogManager := TLogManager.Create;
      try
        CurrentDateTime := Now;
        DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
        LogManager.AddLog('Classe Model.Contatos - Linha : 155 - Finalizou o Alterar Contato e deu FREE na qry às ' + DateTimeStr);
        LogManager.SaveLogToFile('Log_Model_Clientes.txt');
      finally
        LogManager.Free;
      end;
       qry.Free;
    end;
  end;

end;

function TModelContato.CarregarContatos(const aId: Integer): TContato;
var
   qry: TFDQuery;
begin

  Result:= nil;

  qry:=TFDQuery.Create(nil);
  qry.Connection := TConnection.CreateConnection;
  try
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Text:='SELECT * FROM fulanorodas.contatos  ' +
                   'WHERE IDCLIENTES=:IDCLIENTES';
    qry.ParamByName('idclientes').DataType    := ftInteger;
    qry.ParamByName('idclientes').AsInteger   := aId;
    qry.Open;

    if qry.RecordCount > 0 then
    begin
      FContatos.idcontato   := qry.FieldByName('IDCONTATOS').AsInteger;
      FContatos.idcliente   := qry.FieldByName('idclientes').AsInteger;
      FContatos.NomeContato := qry.FieldByName('nomecontato').AsString;
      FContatos.telefone    := qry.FieldByName('telefone').AsString;
      Fcontatos.celular     := qry.FieldByName('celular').AsString;
      FContatos.email       := qry.FieldByName('email').AsString;
      FContatos.cnpjrevenda := qry.FieldByName('cnpjrevenda').AsString;
      FContatos.ativo       := qry.FieldByName('ativo').AsString;
      FContatos.NomeContato := qry.FieldByName('nomecontato').AsString;
    end;

    Result:=FContatos;

  finally
    qry.Free;
  end;
end;

function TModelContato.CarregarTodosContatos(aDataSet: TClientDataSet;
  aSomenteAtivos: string): TFDquery;
begin
//
end;

constructor TModelContato.Create;
var
  LogManager: TLogManager;
begin
  LogManager := TLogManager.Create;
  try
    LogManager.SaveLogToFile('Log_Model_Contatos.txt');
    LogManager.AddLog('Entrou na Model.Contatos - Create: Linha 217: e Criou FContatos.');
    FContatos := TContato.Create;
  finally
    LogManager.Free;
  end;
end;

destructor TModelContato.destroy;
begin
  FContatos.Free;

  inherited;
end;

class function TModelContato.ObterContatoPorId(aId: Integer): TFDQuery;
begin
  Result := Nil;

  qry:= TFDQuery.Create(nil);
  qry.Connection:=TConnection.CreateConnection;
  try
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM CONTATOS');
    qry.SQL.Add('WHERE IDCONTATOS=:IDCONTATOS');
    qry.ParamByName('IDCONTATOS').DataType  := ftInteger;
    qry.ParamByName('IDCONTATOS').AsInteger := aId;
    qry.Open;

    //ShowMessage(qry.FieldByName('ATIVO').AsString);

    Result := qry;

  finally
    //qry.Free;
  end;
end;

function TModelContato.RemoverContato(aContato: TContato): Boolean;
begin
//
end;

class function TModelContato.SalvarContato(aContato: TContato; aCliente: TClientes): Boolean;
var
  qry        : TFDQuery;
  Ativo      : string;
  UF         : string;
  LogManager : TLogManager;
begin
  Result:= False;

  qry:=TFDQuery.Create(nil);
  qry.Connection := TConnection.CreateConnection;
  qry.Connection.StartTransaction;
  try
     qry.Close;
     qry.SQL.Clear;
     qry.SQL.Add('INSERT INTO     ' +
                  'idcontatos,     ' +
                  'idcliente,      ' +
                  'telefone,       ' +
                  'celular,        ' +
                  'email,          ' +
                  'datacadastro    ' +
                  'dataalteracao,  ' +
                  'cnpjrevenda,    ' +
                  'ativo,          ' +
                  'nomecontato)    ' +
                  'VALUES(         ' +
                  ':idcontatos,    ' +
                  ':idcliente,     ' +
                  ':telefone,      ' +
                  ':celular,       ' +
                  ':email,         ' +
                  ':datacadastro   ' +
                  ':dataalteracao, ' +
                  ':cnpjrevenda,   ' +
                  ':ativo,         ' +
                  ':nomecontato)   ');

     qry.ParamByName('idcontatos').DataType      := ftInteger;
     qry.ParamByName('idcliente').DataType       := ftInteger;
     qry.ParamByName('idcliente').AsInteger      := aCliente.idcliente;
     qry.ParamByName('telefone').DataType        := ftString;
     qry.ParamByName('telefone').AsString        := aContato.telefone;
     qry.ParamByName('celular').DataType         := ftString;
     qry.ParamByName('celular').AsString         := aContato.celular;
     qry.ParamByName('email').DataType           := ftString;
     qry.ParamByName('email').AsString           := aContato.email;
     qry.ParamByName('datacadastro').DataType    := ftDateTime;
     qry.ParamByName('datacadastro').AsDateTime  := Now;
     qry.ParamByName('dataalteracao').DataType   := ftDateTime;
     qry.ParamByName('dataalteracao').AsDateTime := Now;
     qry.ParamByName('cnpjrevenda').DataType     := ftString;
     qry.ParamByName('cnpjrevenda').AsString     := aContato.cnpjrevenda;
     qry.ParamByName('ativo').DataType           := ftString;

     qry.ParamByName('ativo').DataType           := ftString;
     if Length(aContato.ativo) > 0 then
       Ativo := Copy(aContato.ativo, 1, 1)
     else
       Ativo := '';

     qry.ParamByName('ativo').AsString           := Ativo;

     qry.ParamByName('ativo').AsString           := aContato.ativo;

     qry.ParamByName('nomecontato').DataType     := ftString;
     qry.ParamByName('nomecontato').AsString     := aContato.NomeContato;

     qry.ExecSQL;
     qry.Connection.Commit;

     Result:=True;

  Except
    on E: Exception do
    begin
      Result:= False;
      qry.Connection.Rollback;
      ShowMessage('Houve um erro ao gravar os dados do contato' + E.Message);
      qry.Close;
      qry.Free;

      if True then

      LogManager := TLogManager.Create;
      try
        LogManager.SaveLogToFile('Log_Model_Contatos.txt');
        LogManager.AddLog('Saiu na Model.Contatos - SalvarContato: Linha 320: e deu erro ao gravar o contato.');
      finally
        LogManager.Free;
      end;
    end;
  end;

end;

procedure TModelContato.SetSomenteAtivos(const Value: string);
begin
  FSomenteAtivos := Value;
end;

class function TModelContato.TestaSeCamposPreenchidos(
  aContato: TContato): Boolean;
begin
  Result:=False;

  if aContato.idcliente <= 0   then
  begin
    raise Exception.Create('O Cod. do Cliente deve ser preenchido.');
    Result:= False;
    exit;
  end;

  if Trim(aContato.NomeContato) = '' then
  begin
    raise Exception.Create('O nome do contato não pode ser vazio.');
    Result:= False;
    exit;
  end;

  if Trim(aContato.telefone) = '' then
  begin
    raise Exception.Create('É necessário prencher o Telefone.');
    Result:= False;
    exit;
  end;

  if Trim(aContato.Celular) = '' then
  begin
    raise Exception.Create('É necessário preencher o Celular.');
    Result:= False;
    exit;
  end;

  if Trim(aContato.email) = '' then
  begin
    raise Exception.Create('É necessário preencher o e-mail.');
    Result:= False;
    exit;
  end;

  Result:= True;

end;

end.
