unit Model.Clientes;

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
  System.IniFiles;


type
  TModelCliente = class
    private
      Fconn: TFDConnection;
      qry: TFDQuery;
      FSomenteAtivos: string;
      CurrentDateTime: TDateTime;
      DateTimeStr: string;
      class var FGravarLogs: Boolean;
    procedure SetSomenteAtivos(const Value: string);
    class procedure CarregarFGravarLog;
    public
      FCliente: TClientes;

      property SomenteAtivos: string read FSomenteAtivos write SetSomenteAtivos;

      procedure LimparContatos;
      //create
      Class function SalvarCliente(aCliente: TClientes): Boolean;
      function GravarLogNoBancoDeDados(
                                        const caminhoArquivoLog: string;
                                        anomearquivo: string) : Boolean;

      //Read
      function CarregarClientes(const ACNPJ: String): TClientes;
      function CarregarTodosClientes(
  aDataSet: TClientDataSet; aSomenteAtivos: string; aSemContatos: string; aNomeBotao: string = ''): TFDquery;
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
   qry             : TFDQuery;
   UF              : String;
   Ativo           : String;
   LogManager      : TLogManager;
   CurrentDateTime : TDateTime;
   DateTimeStr     : string;
   FGravarLogs     : Boolean;
   Valor           : String;
   IniFile         : TIniFile;
begin
  //ler procedure do pode gravar log
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\Config.ini');
  try
    Valor := IniFile.ReadString('Sistema', 'SalvarLogsBancoDeDados', '');

    if Valor='S' then
      FGravarLogs := True
    else
      FGravarLogs := False;

  finally
    IniFile.Free;
  end;

  if FGravarLogs then
  begin
    LogManager:= TLogManager.Create;
    try
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager := TLogManager.Create;
      LogManager.AddLog('Classe Model.Clientes - Linha : 114 - Entrou no Alterar Cliente às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Model_Clientes.txt');
    finally
      LogManager.Free;
    end;
  end;

  Result:=False;

  qry:=TFDQuery.Create(nil);
  qry.Connection := TConnection.CreateConnection;
  qry.Connection.StartTransaction;
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
    qry.Connection.Commit;  //Gravar no banco

    Result:=True;

  Except
     on E: Exception do
      begin
        ShowMessage('Ocorreu um erro ao salvar o cliente: ' + E.Message);
        qry.Connection.Rollback;
        qry.Close;

        if FGravarLogs then
        begin
          LogManager:= TLogManager.Create;
          try
            CurrentDateTime := Now;
            DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
            LogManager.AddLog('Classe Model.Clientes - Linha : 206 - Finalizou o Alterar Cliente finalizou qry às '+ DateTimeStr);
            LogManager.SaveLogToFile('Log_Model_Clientes.txt');
          finally
            LogManager.Free;
          end;
        end;
        qry.Free;
      end;

  end;
end;

function TModelCliente.CarregarClientes(const ACNPJ: String): TClientes;
var
 qry: TFDQuery;
 LogManager: TLogManager;
begin
  if FGravarLogs then
  begin
    LogManager:= TLogManager.Create;
    try
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Classe Model.Clientes: Linha 229: Entrou na Function Carregar Clientes e criou qry às '+ DateTimeStr);
      LogManager.SaveLogToFile('Log_Model_Clientes.txt');
    finally
      LogManager.Free;
    end;
  end;

  Result:= Nil;

  qry:= TFDquery.Create(nil);
  qry.Connection:= Fconn;
  try
    qry.SQL.Clear;
    qry.SQL.Text:='SELECT CL.*, CO.* FROM CLIENTES CL ' +
                  'JOIN CONTATOS CO ON(CO.IDCLIENTES=CL.IDCLIENTES' +
                  'WHERE CNPJ_CPF=:CNPJ';
    qry.ParamByName('CNPJ').DataType := ftString;
    qry.ParamByName('CNPJ').AsString := ACNPJ;
    qry.Open;

    if qry.RecordCount > 0 then
    begin
      FCliente.idcliente     := qry.FieldByName('idclientes').AsInteger;
      FCliente.razaosocial   := qry.FieldByName('razao').AsString;
      FCliente.cnpj          := qry.FieldByName('cnpj_cpf').AsString;
      FCliente.endereco      := qry.FieldByName('endereco').AsString;
      FCliente.complemento   := qry.FieldByName('complemento').AsString;
      FCliente.numero        := qry.FieldByName('numero').AsInteger;
      FCliente.cep           := qry.FieldByName('cep').AsString;
      FCliente.cidade        := qry.FieldByName('cidade').AsString;
      FCliente.bairro        := qry.FieldByName('bairro').AsString;
      FCliente.uf            := qry.FieldByName('uf').AsString;
      FCliente.idModeloCarro := qry.FieldByName('idmodelocarrocliente').AsInteger;
      FCliente.ativo         := qry.FieldByName('ativo').AsString;
      Result:= FCliente;
    end;

  finally
   if FGravarLogs then
   begin
     LogManager:= TLogManager.Create;
     try
       CurrentDateTime := Now;
       DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
       LogManager.AddLog('Classe Model.Clientes: Linha 273: Entrou na Function Carregar Clientes e criou qry às '+ DateTimeStr);
       LogManager.SaveLogToFile('Log_Model_Clientes.txt');
     finally
       LogManager.Free;
     end;
   end;
    qry.Close;
    qry.Free;
  end;

end;

class procedure TModelCliente.CarregarFGravarLog;
var
  IniFile : TIniFile;
  Valor   : String;
begin
  //ler procedure do pode gravar log
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\Config.ini');
  try
    Valor := IniFile.ReadString('Sistema', 'SalvarLogsBancoDeDados', '');

    if Valor='S' then
      FGravarLogs := True
    else
      FGravarLogs := False;

  finally
    IniFile.Free;
  end;
end;

function TModelCliente.CarregarTodosClientes(
  aDataSet: TClientDataSet; aSomenteAtivos: string; aSemContatos: string; aNomeBotao: string = ''): TFDquery;
var
  LogManager: TLogManager;
begin
  if FGravarLogs then
  begin
    LogManager:= TLogManager.Create;
    try
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Classe Model.Clientes: Linha : 296 - Carregar Todos Clientes e criou qry às '+ DateTimeStr);
      LogManager.SaveLogToFile('Log_Model_Clientes.txt');
    finally
      LogManager.Free;
    end;
  end;

  //rever campos ao abrir o formulário de clientes
  qry:= TFDquery.Create(nil);
  qry.Connection:= TConnection.CreateConnection;
  try
    qry.SQL.Clear;
    if aSemContatos='S' then
    begin //Se não tiver contato precisa carregar sem nada e pegar idContato novo
      qry.SQL.Add('SELECT CL.*, CO.* FROM CLIENTES CL');
      qry.SQL.Add('JOIN CONTATOS CO');
    end
    Else
      qry.SQL.Add('SELECT CL.*, CO.* FROM CLIENTES CL ');

    if aSemContatos = 'N' then
      qry.SQL.Add('JOIN CONTATOS CO ON(CO.IDCLIENTES=CL.IDCLIENTES)');

    if aSomenteAtivos = 'S' then
      qry.SQL.Add('WHERE CL.ATIVO=''S''      ');

    qry.SQL.Add('ORDER BY CL.IDCLIENTES ASC');
    qry.Open;

    ShowMessage('A qtde. de todos os clientes é de: ' + IntToStr(qry.recordcount));

    if aNomeBotao = '' then
      qry.First
    else
    begin

    end;

    LogManager:= TLogManager.Create;
    try
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Classe Model.Clientes: Linha : 333 - Carregar Clientes Resultou a qry mas NÂO deu FREE às '+ DateTimeStr);
      LogManager.SaveLogToFile('Log_Model_Clientes.txt');
      Result := qry;
    finally
      LogManager.Free;
    end;

  except
    on E: Exception do
    begin
      ShowMessage('Erro ao carregar todos os clientes' + E.Message);
      Result := nil;
      qry.Free;
    end;
  end;

end;

class function TModelCliente.ClienteExiste(aCNPJ: string): Boolean;
var
  qry: TFDQuery;
  LogManager: TLogManager;
  CurrentDateTime: TDateTime;
  DateTimeStr: string;
begin
  Result:= False;

  LogManager:= TLogManager.Create;
  try
     CurrentDateTime := Now;
     DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
     LogManager := TLogManager.Create;
     LogManager.AddLog('Classe na Model.Clientes - Linha 365 - Entrou na Cliente Existe e Criou qry às ' + DateTimeStr);
     LogManager.SaveLogToFile('Log_Model_Clientes.txt');

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

  finally
     LogManager.Free;
  end;

end;

constructor TModelCliente.Create;
var
  LogManager: TLogManager;
begin


  LogManager := TLogManager.Create;
  try
    LogManager.SaveLogToFile('Log_Model_Clientes.txt');
    CurrentDateTime := Now;
    DateTimeStr := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
    LogManager.AddLog('Entrou na Model.Clientes - Create: Linha : 401 - E Criou a FCliente às ' + DateTimeStr);
    FCliente := TClientes.Create;
  finally
    LogManager.Free;
  end;
end;

destructor TModelCliente.destroy;
var
  LogManager: TLogManager;
begin
  LogManager:= TLogManager.Create;
  try
     CurrentDateTime := Now;
     DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
     LogManager.AddLog('Entrou na Model.Clientes - Destroy: Linha : 416 - e Deu Free na Fcliente às ' + DateTimeStr);
     LogManager.SaveLogToFile('Log_Model_Clientes.txt');
     FCliente.Free;
  finally
     LogManager.Free;
  end;

  inherited;
end;

function TModelCliente.GravarLogNoBancoDeDados(
  const caminhoArquivoLog: string; anomearquivo: string) : Boolean;
var
  qry: TFDQuery;
  arquivoStream: TMemoryStream;
   blobStream: TStream;
begin
  Result := False;

  try
    qry := TFDQuery.Create(nil);
    qry.Connection := TConnection.CreateConnection;

    arquivoStream := TMemoryStream.Create;
    try
      arquivoStream.LoadFromFile(caminhoArquivoLog);

      qry.SQL.Text := 'INSERT INTO logs (arquivo, datainclusao, nomearquivo) VALUES (:arquivo, :datainclusao, :nomearquivo)';

      qry.ParamByName('arquivo').DataType := ftBlob;
      qry.ParamByName('arquivo').LoadFromFile(caminhoArquivoLog, ftBlob);

      qry.ParamByName('datainclusao').AsDateTime := Now;
      qry.ParamByName('nomearquivo').AsString    := anomearquivo;
      qry.ExecSQL;

      Result := True;
    finally
      arquivoStream.Free;
    end;
  except
    ShowMessage('Erro ao gravar log no Banco de Dados');
  end;

  qry.Free;

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
    qry.Connection.Commit;

    Result := True;
  finally
    qry.Free;
  end;

end;

class function TModelCliente.SalvarCliente(aCliente: TClientes): Boolean;
var
  qry             : TFDQuery;
  Ativo           : string;
  UF              : string;
  LogManager      : TLogManager;
  CurrentDateTime : TDateTime;
  DateTimeStr     : string;
begin
  Result:= False;

  qry:=TFDQuery.Create(nil);
  qry.Connection := TConnection.CreateConnection;
  qry.Connection.StartTransaction;
  try

    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('INSERT INTO '  +
                ' fulanorodas.Clientes ' +
                '(idclientes,          ' +   //1
                'razao,                ' +   //2
                'cnpj_cpf,             ' +   //3
                'endereco,             ' +   //4
                'numero,               ' +   //5
                'complemento,          ' +   //6
                'cep,                  ' +   //7
                'cidade,               ' +   //8
                'bairro,               ' +   //9
                'ativo,                ' +   //10
                'uf,                   ' +   //11
                'datacadastro,         ' +   //12
                'dataalteracao,        ' +   //13
               // 'dataexclusao,       ' +   //14
                'idmodelocarro         ' +   //15
                ')                     ' +
                'VALUES (              ' +
                ':idclientes,          ' +   //1 ok
                ':razao,               ' +   //2 ok
                ':cnpj_cpf,            ' +   //3 ok
                ':endereco,            ' +   //4 ok
                ':numero,              ' +   //5 ok
                ':complemento,         ' +   //6 ok
                ':cep,                 ' +   //7 ok
                ':cidade,              ' +   //8 ok
                ':bairro,              ' +   //9 ok
                ':ativo,               ' +   //10 ok
                ':uf,                  ' +   //11 ok
                ':datacadastro,        ' +   //12 ok
                ':dataalteracao,       ' +   //13 ok
              //  ':dataexclusao,        ' + //14 ok
                ':idmodelocarro        ' +   //15 ok
                ')                     ');

     qry.ParamByName('idclientes').DataType    := ftInteger;            //1

     qry.ParamByName('razao').DataType         := ftString;
     qry.ParamByName('razao').AsString         := aCliente.razaosocial; //2
     qry.ParamByName('cnpj_cpf').DataType      := ftString;
     qry.ParamByName('cnpj_cpf').AsString      := aCliente.cnpj ;       //3
     qry.ParamByName('endereco').DataType      := ftString;
     qry.ParamByName('endereco').AsString      := aCliente.endereco;    //4
     qry.ParamByName('numero').DataType        := ftInteger;
     qry.ParamByName('numero').AsInteger       := aCliente.numero;      //5
     qry.ParamByName('complemento').DataType   := ftString;
     qry.ParamByName('complemento').AsString   := aCliente.complemento; //6
     qry.ParamByName('cep').DataType           := ftString;
     qry.ParamByName('cep').AsString           := aCliente.CEP;         //7
     qry.ParamByName('cidade').DataType        := ftString;
     qry.ParamByName('cidade').AsString        := aCliente.Cidade;      //8
     qry.ParamByName('bairro').DataType        := ftString;
     qry.ParamByName('bairro').AsString        := aCliente.Bairro;      //9

     qry.ParamByName('ativo').DataType         := ftString;
     if Length(aCliente.ativo) > 0 then
       Ativo := Copy(aCliente.ativo, 1, 1)
     else
       Ativo := '';

     qry.ParamByName('ativo').AsString         := Ativo;               //10

     qry.ParamByName('uf').DataType            := ftString;
     if Length(aCliente.UF) > 0 then
       UF := Copy(aCliente.UF, 1, 2)
     else
       UF := '';

     qry.ParamByName('uf').AsString            := UF;                  //11

     qry.ParamByName('datacadastro').DataType  := ftDateTime;
     qry.ParamByName('datacadastro').AsDateTime:= Now;                 //12

     qry.ParamByName('dataalteracao').DataType  := ftDateTime;         //13
     qry.ParamByName('dataalteracao').AsDateTime:= Now;

//     qry.ParamByName('dataexclusao').DataType := ftDateTime;
//     qry.ParamByName('dataexclusao').AsDateTime:= aCliente.dataExclusao; //14

     qry.ParamByName('idmodelocarro').DataType := ftInteger;
     qry.ParamByName('idmodelocarro').AsInteger:= aCliente.Idmodelocarro; //15

     CarregarFGravarLog;

     if FGravarLogs then
       qry.SQL.SaveToFile('c:\ClientesSQL.txt');

     qry.ExecSQL;
     qry.Connection.Commit;

     Result := True;
  Except
     on E: Exception do
      begin
        Result := False;
        ShowMessage('Ocorreu um erro ao salvar o cliente: ' + E.Message);
        qry.Connection.Rollback;
        qry.Close;

        if True then
        begin
          LogManager:= TLogManager.Create;
          try
            CurrentDateTime := Now;
            DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
            LogManager.AddLog('Classe Model.Clientes - Linha : 629 - Finalizou o Alterar Cliente finalizou qry às '+ DateTimeStr);
            LogManager.SaveLogToFile('Log_Model_Clientes.txt');
          finally
            LogManager.Free;
          end;
        end;
        qry.Free;
      end;
  end;
  qry.Free;
end;

procedure TModelCliente.SetSomenteAtivos(const Value: string);
begin
  FSomenteAtivos := Value;
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
