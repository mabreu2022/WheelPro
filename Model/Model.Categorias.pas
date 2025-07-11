unit Model.Categorias;

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
  System.IniFiles,
  Entity.Categorias;

type
  TModelCategorias = class
    private
      Fconn: TFDConnection;
      qry: TFDQuery;
      CurrentDateTime: TDateTime;
      DateTimeStr: string;
      class var FGravarLogs: Boolean;

    public

    Class function SalvarCategoria(aCategoria: TCategorias): Boolean;
    class function AlterarCategoria(aCategoria: TCategorias): Boolean;
    class function TestaSeCamposPreenchidos(aCategoria: TCategorias): Boolean;
    class function CategoriaExiste(aIDCategoria: Integer):Boolean;
    class function PesquisaNomeFabricante(aCodFabricante: Integer): String;

    function CarregarTodasCategorias(aDataSet      : TClientDataSet;
                                     aSomenteAtivos: string;
                                     aNomeBotao    : string  = '';
                                     aIdCategorias : Integer = 0)
                                     : TFDquery;
    //Delete
    function RemoverCategoria(aCategoria: TCategorias): Boolean;

    constructor Create;
    destructor destroy;override;
  end;

implementation

{ TModelCategorias }

class function TModelCategorias.AlterarCategoria(
  aCategoria: TCategorias): Boolean;
var
   qry             : TFDQuery;
   LogManager      : TLogManager;
   IniFile         : TIniFile;
   CurrentDateTime : TDateTime;
   DateTimeStr     : string;
   FGravarLogs     : Boolean;
   Valor           : String;
   Ativo           : String;
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
      LogManager.AddLog('Classe Model.Categoria - Linha : 77 - Entrou no Alterar Categoria �s ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Model_Categoria.txt');
    finally
      LogManager.Free;
    end;
  end;

  Result:=False;

  qry            :=TFDQuery.Create(nil);
  qry.Connection := TConnection.CreateConnection;
  qry.Connection.StartTransaction;
  try
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Text:='UPDATE fulanorodas.categoria   ' +
                  'SET                            ' +
                  'idcategorias  = :idcategorias, ' +
                  'categoria     = :categoria,    ' +
                  'ativo         = :ativo,        ' +
                  'datacadastro  = :datacadastro, ' +
                  'dataalteracao = :dataalteracao ' +
                  'WHERE                          ' +
                  'idcategorias  = :idcategorias  ';

    qry.ParamByName('idcategorias').DataType  := ftInteger;
    qry.ParamByName('idcategorias').AsInteger := aCategoria.idcategorias;
    qry.ParamByName('categoria').DataType     := ftString;
    qry.ParamByName('categoria').AsString     := aCategoria.categoria;

    qry.ParamByName('ativo').DataType         := ftString;
    if Length(aCategoria.ativo) > 0 then
      Ativo := Copy(aCategoria.ativo, 1, 1)
    else
      Ativo := '';

    qry.ParamByName('ativo').AsString         := Ativo;

    qry.ParamByName('datacadastro').DataType  := ftDateTime;
    qry.ParamByName('datacadastro').AsDateTime:= aCategoria.datacadastro;

    qry.ParamByName('dataalteracao').DataType  := ftDateTime;
    qry.ParamByName('dataalteracao').AsDateTime:= Now;

    qry.ExecSQL;
    qry.Connection.Commit;  //Gravar no banco

    Result:=True;

  Except
     on E: Exception do
      begin
        ShowMessage('Ocorreu um erro ao salvar a altera��o da categoria: ' + E.Message);
        qry.Connection.Rollback;
        qry.Close;

        if FGravarLogs then
        begin
          LogManager:= TLogManager.Create;
          try
            CurrentDateTime := Now;
            DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
            LogManager.AddLog('Classe Model.Categoria - Linha : 140 - Finalizou o Alterar Categoria finalizou qry �s '+ DateTimeStr);
            LogManager.SaveLogToFile('Log_Model_Categoria.txt');
          finally
            LogManager.Free;
          end;
        end;
        qry.Free;
      end;

  end;

end;

function TModelCategorias.CarregarTodasCategorias(aDataSet: TClientDataSet;
  aSomenteAtivos, aNomeBotao: string; aIdCategorias: Integer): TFDquery;
  var
  LogManager: TLogManager;
begin
  if FGravarLogs then
  begin
    LogManager:= TLogManager.Create;
    try
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Classe Model.Categorias: Linha : 172 - Carregar Todas Categorias e criou qry �s '+ DateTimeStr);
      LogManager.SaveLogToFile('Log_Model_Categorias.txt');
    finally
      LogManager.Free;
    end;
  end;

  //rever campos ao abrir o formul�rio de Categorias
  qry:= TFDquery.Create(nil);
  qry.Connection:= TConnection.CreateConnection;
  try
    qry.SQL.Clear;
    qry.SQL.Add('SELECT CA.* FROM CATEGORIA CA ');

    if aSomenteAtivos = 'S' then
      qry.SQL.Add('WHERE CA.ATIVO=''S''      ');

    if aNomeBotao = '' then
    begin
      qry.SQL.Add('ORDER BY CA.IDCATEGORIAS ASC');
      qry.Open;
      qry.First;
      Result:= qry;
    end
    else
    begin
      //Pesquisar pelo codigo do cliente na tabela de Contatos
      //Caso nao encontre abrir para nova categoria
      //caso encontre carregar os dados nos edits da aba de contatos.
      qry.SQL.add(' AND CA.IDCATEGORIAS=:IDCCATEGORIAS');
      qry.ParamByName('IDCCATEGORIAS').DataType  := ftInteger;
      qry.ParamByName('IDCCATEGORIAS').AsInteger := aIdCategorias;
      //ShowMessage(qry.SQL.Text);
      qry.Open;

      Result:= qry;

    end;

    //ShowMessage('A qtde. de todos as categorias � de: ' + IntToStr(qry.recordcount));

    if FGravarLogs then
    begin
      LogManager:= TLogManager.Create;
      try
        CurrentDateTime := Now;
        DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
        LogManager.AddLog('Classe Model.Clientes: Linha : 223 - Carregar CATEGORIAS Resultou a qry mas N�O deu FREE �s '+ DateTimeStr);
        LogManager.SaveLogToFile('Log_Model_Categorias.txt');
        Result := qry;
      finally
        LogManager.Free;
      end;
    end;

  except
    on E: Exception do
    begin
      ShowMessage('Erro ao carregar todas as categorias' + E.Message);
      Result := nil;
      qry.Free;
    end;
  end;


end;

class function TModelCategorias.CategoriaExiste(aIDCategoria: Integer): Boolean;
var
  qry: TFDQuery;
  LogManager: TLogManager;
  CurrentDateTime: TDateTime;
  DateTimeStr: string;
begin
  Result:= False;

  if FGravarLogs then
  begin
    LogManager:= TLogManager.Create;
    try
       CurrentDateTime := Now;
       DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
       LogManager := TLogManager.Create;
       LogManager.AddLog('Classe na Model.Categoria - Linha 172 - Entrou na Categoria Existe e Criou qry �s ' + DateTimeStr);
       LogManager.SaveLogToFile('Log_Model_Categoria.txt');
    finally
      LogManager.Free;
    end;
  End;

  qry:= TFDquery.Create(nil);
  qry.Connection:= TConnection.CreateConnection;
  try
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM CATEGORIA');
    qry.SQL.Add('WHERE IDCATEGORIAS=:IDCATEGORIAS');
    qry.ParamByName('IDCATEGORIAS').DataType := ftInteger;
    qry.ParamByName('IDCATEGORIAS').AsInteger := aIDCategoria;
    qry.Open;

    if qry.RecordCount > 0 then
      Result:= True;

  finally
    qry.Free;
    if FGravarLogs then
    begin
      LogManager:= TLogManager.Create;
      try
        CurrentDateTime := Now;
        DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
        LogManager := TLogManager.Create;
        LogManager.AddLog('Classe na Model.Categoria - Linha 200 - destruiu a qry �s ' + DateTimeStr);
        LogManager.SaveLogToFile('Log_Model_Categoria.txt');
      finally
        LogManager.Free;
      end;
    end;
  end;

end;

constructor TModelCategorias.Create;
begin

end;

destructor TModelCategorias.destroy;
begin

  inherited;
end;

class function TModelCategorias.PesquisaNomeFabricante(
  aCodFabricante: Integer): String;
var
  qry : TFDQuery;
begin

  qry:= TFDquery.Create(nil);
  qry.Connection:= TConnection.CreateConnection;
  try
    qry.SQL.Clear;
    qry.SQL.Add('select razao from fabricantes');
    qry.SQL.Add(' where idfabricantes=:idfabricantes');
    qry.ParamByName('idfabricantes').DataType   := ftInteger;
    qry.ParamByName('idfabricantes').AsInteger := aCodFabricante;
    qry.Open;
    if qry.RecordCount > 0 then
      Result:= qry.FieldByName('razao').AsString
    else
      Result:='';
  finally
    qry.Free;
  end;

end;

function TModelCategorias.RemoverCategoria(aCategoria: TCategorias): Boolean;
var
  Ativo: string;
begin
  Result := False;

  qry:= TFDQuery.Create(nil);
  qry.Connection:= TConnection.CreateConnection;
  qry.Connection.StartTransaction;
  try

    qry.Close;
    qry.SQL.Text := 'UPDATE fulanorodas.categoria ' +
                    'SET                          ' +
                    'ativo       = ''N''          ' +
                    'WHERE IDCATEGORIAS=:IDCATEGORIAS';
    qry.ParamByName('IDCATEGORIAS').DataType:= ftInteger;
    qry.ParamByName('IDCATEGORIAS').AsInteger:= aCategoria.idcategorias;

    qry.ExecSQL;
    qry.Connection.Commit;

    Result := True;

  Except
    on E: Exception do
    begin
      Result := False;
      qry.Connection.Rollback;
      ShowMessage('Houve um erro ao tentar deletar a categoria' + E.Message);
      qry.Close;
      qry.Free;
    end;
  end;

end;

class function TModelCategorias.SalvarCategoria(
  aCategoria: TCategorias): Boolean;
var
  qry             : TFDQuery;
  Ativo           : string;
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
                ' fulanorodas.categoria  ' +
                '(idcategorias,          ' +   //1
                'categoria,              ' +   //2
                'ativo,                  ' +   //3
                'datacadastro,           ' +   //4
                'dataalteracao,          ' +   //5
                'dataexclusao            ' +   //6
                ')                       ' +
                'VALUES (                ' +
                ':idcategorias,          ' +   //1 ok
                ':categoria,             ' +   //2 ok
                ':ativo,                 ' +   //3 ok
                ':datacadastro,          ' +   //4 ok
                ':dataalteracao,         ' +   //5 ok
                ':dataexclusao           ' +   //6 ok
                ')                       ');

     qry.ParamByName('idcategorias').DataType  := ftInteger;            //1

     qry.ParamByName('categoria').DataType     := ftString;
     qry.ParamByName('categoria').AsString     := aCategoria.categoria; //2


     qry.ParamByName('ativo').DataType         := ftString;
     if Length(aCategoria.ativo) > 0 then
       Ativo := Copy(aCategoria.ativo, 1, 1)
     else
       Ativo := '';

     qry.ParamByName('ativo').AsString         := Ativo;               //3

     qry.ParamByName('datacadastro').DataType  := ftDateTime;
     qry.ParamByName('datacadastro').AsDateTime:= Now;                 //4

     qry.ParamByName('dataalteracao').DataType  := ftDateTime;         //5
     qry.ParamByName('dataalteracao').AsDateTime:= Now;

     qry.ParamByName('dataexclusao').DataType := ftDateTime;
     qry.ParamByName('dataexclusao').AsDateTime:= aCategoria.dataExclusao; //6

     //CarregarFGravarLog;

     if FGravarLogs then
       qry.SQL.SaveToFile('C:\CategoriasSQL.txt');

     qry.ExecSQL;
     qry.Connection.Commit;

     Result := True;
  Except
     on E: Exception do
      begin
        Result := False;
        ShowMessage('Ocorreu um erro ao salvar a categoria: ' + E.Message);
        qry.Connection.Rollback;
        qry.Close;

        if True then
        begin
          LogManager:= TLogManager.Create;
          try
            CurrentDateTime := Now;
            DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
            LogManager.AddLog('Classe Model.Categoria - Linha : 460 - Finalizou o Alterar Categoria finalizou qry �s '+ DateTimeStr);
            LogManager.SaveLogToFile('Log_Model_Categorias.txt');
          finally
            LogManager.Free;
          end;
        end;
        qry.Free;
      end;
  end;
  qry.Free;

end;

class function TModelCategorias.TestaSeCamposPreenchidos(
  aCategoria: TCategorias): Boolean;
begin
  Result := False;

  if Trim(aCategoria.categoria) ='' then
  begin
    raise Exception.Create('� necess�rio preencher a categoria.');
    Result:= False;
    exit;
  end;

  if Trim(aCategoria.fabricante) = '' then
  begin
    raise Exception.Create('� necess�rio prencher o fabricante.');
    Result:= False;
    exit;
  end;

  Result:= True;

end;

end.
