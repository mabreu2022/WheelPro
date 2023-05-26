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
  LogManager;

type
  TModelContato = class
    private
      Fconn: TFDConnection;
      qry: TFDQuery;
      FSomenteAtivos: string;
      LogManager: TLogManager;
    procedure SetSomenteAtivos(const Value: string);
    public
      FContatos: TContato;
      property SomenteAtivos: string read FSomenteAtivos write SetSomenteAtivos;
      //create
      Class function SalvarContato(aContato: TContato): Boolean;

      //Read
      function CarregarContatos(const aId: Integer): TContato;
      function CarregarTodosContatos(
               aDataSet: TClientDataSet; aSomenteAtivos: string): TFDquery; //ok
//      function ObterClientePorId(aId: Integer): TFDQuery;
//
//      //Update
      class function AlterarContato(aContato: TContato): Boolean;

//      //Delete
//      function RemoverCliente(aCliente: TClientes): Boolean;
//
//      //Regras
      class function TestaSeCamposPreenchidos(
  aContato: TContato): Boolean;
//      class function ClienteExiste(aCNPJ: string):Boolean;
//
      constructor Create;
      destructor destroy;override;
  end;

implementation

{ TModelContato }

class function TModelContato.AlterarContato(aContato: TContato): Boolean;
var
   qry: TFDQuery;
   UF: String;
   Ativo: String;

   LogManager: TLogManager;
   CurrentDateTime: TDateTime;
   DateTimeStr: string;
begin
  Result:=False;

  try
    CurrentDateTime := Now;
    DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
    LogManager := TLogManager.Create;
    LogManager.AddLog('Classe Model.Contatos - Linha : 82 - Entrou no Alterar Contato e criou a qry às ' + DateTimeStr);
    LogManager.SaveLogToFile('Log_Model_Clientes.txt');
  finally
    LogManager.Free;
  end;

  qry:=TFDQuery.Create(nil);
  qry.Connection := TConnection.CreateConnection;
  try
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Text:='UPDATE fulanorodas.contatos  ' +
                  'SET                          ' +
//                  'idcontatos  = :idcontatos    ' +
                  'idclientes  = :idclientes,   ' +
                  'telefone    = :telefone,     ' +
                  'celular     = :celular,      ' +
                  'email       = :email,        ' +
                  'cnpjrevenda = :cnpjrevenda,  ' +
                  'ativo       = :ativo,        ' +
                  'datacadastro= :datacadastro  ' +
                  'WHERE                        ' +
                  'idclientes = :idclientes     ';

    qry.ParamByName('idclientes').DataType    := ftInteger;
    qry.ParamByName('idclientes').AsInteger   := aContato.idcliente;
    qry.ParamByName('telefone').DataType      := ftString;
    qry.ParamByName('telefone').AsString      := aContato.telefone;
    qry.ParamByName('celular').DataType       := ftString;
    qry.ParamByName('celular').AsString       := aContato.celular;
    qry.ParamByName('email').DataType         := ftString;
    qry.ParamByName('email').AsString         := aContato.email;
    qry.ParamByName('cnpjrevenda').DataType   := ftString;
    qry.ParamByName('cnpjrevenda').AsString   := aContato.cnpjrevenda;


    qry.ParamByName('ativo').DataType         := ftString;
    if Length(aContato.ativo) > 0 then
      Ativo := Copy(aContato.ativo, 1, 1)
    else
      Ativo := '';

    qry.ParamByName('ativo').AsString         := Ativo;

    qry.ParamByName('datacadastro').DataType  := ftDateTime;
    qry.ParamByName('datacadastro').AsDateTime:= aContato.datacadastro;

    qry.ExecSQL;
    qry.Connection.Commit;

    Result:=True;

  finally
     CurrentDateTime := Now;
     DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
     LogManager := TLogManager.Create;
     LogManager.AddLog('Classe Model.Contatos - Linha : 139 - Finalizou o Alterar Contato e deu FREE na qry às ' + DateTimeStr);
     LogManager.SaveLogToFile('Log_Model_Clientes.txt');
     LogManager.Free;

     qry.Free;
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
      FContatos.Nome        := qry.FieldByName('nomecontato').AsString;
      FContatos.telefone    := qry.FieldByName('telefone').AsString;
      Fcontatos.celular     := qry.FieldByName('celular').AsString;
      FContatos.email       := qry.FieldByName('email').AsString;
      FContatos.cnpjrevenda := qry.FieldByName('cnpjrevenda').AsString;
      FContatos.ativo       := qry.FieldByName('ativo').AsString;
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
begin
  LogManager := TLogManager.Create;
  LogManager.SaveLogToFile('Log_Model_Contatos.txt');
  LogManager.AddLog('Entrou na Model.Contatos - Create: Linha 170: e Criou FContatos.');
  FContatos := TContato.Create;
end;

destructor TModelContato.destroy;
begin
  FContatos.Free;
  LogManager.Free;
  inherited;
end;

class function TModelContato.SalvarContato(aContato: TContato): Boolean;
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
                ' fulanorodas.contatos '    +
                '(idcontatos, ' +
                'idclientes, '  +
                'telefone, '    +
                'celular, '     +
                'email, '       +
                'cnpjrevenda, ' +
                'ativo) '       +
                'VALUES ('      +
                ':idcontatos, ' +
                ':idclientes, ' +
                ':telefone, '   +
                ':celular, '    +
                ':email, '      +
                ':cnpjrevenda, '+
                ':ativo) ');
     qry.ParamByName('idcontatos').DataType    := ftInteger;
     qry.ParamByName('idcontatos').AsInteger   := aContato.idcontato;
     qry.ParamByName('idclientes').DataType    := ftInteger;
     qry.ParamByName('idclientes').AsInteger   := aContato.idcliente;
     qry.ParamByName('telefone').DataType      := ftString;
     qry.ParamByName('telefone').AsString      := aContato.telefone;
     qry.ParamByName('celular').DataType       := ftString;
     qry.ParamByName('celular').AsString       := aContato.celular ;
     qry.ParamByName('email').DataType         := ftString;
     qry.ParamByName('email').AsString         := aContato.email;
     qry.ParamByName('cnpjrevenda').DataType   := ftString;
     qry.ParamByName('cnpjrevenda').AsString   := aContato.cnpjrevenda;

     qry.ParamByName('ativo').DataType         := ftString;
     if Length(aContato.ativo) > 0 then
       Ativo := Copy(aContato.ativo, 1, 1)
     else
       Ativo := '';

     qry.ParamByName('ativo').AsString         := Ativo;

     qry.ExecSQL;
     qry.Connection.Commit;

     Result:=True;

  finally
    qry.Close;
    qry.Free;
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

  if Trim(aContato.Nome) = '' then
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
