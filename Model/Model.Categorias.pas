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
    class function AlterarCategoria(aCategoria: TCategorias): Boolean;
    class function TestaSeCamposPreenchidos(aCategoria: TCategorias): Boolean;
    class function CategoriaExiste(aIDCategoria: Integer):Boolean;
    function CarregarTodasCategorias(aDataSet      : TClientDataSet;
                                     aSomenteAtivos: string;
                                     aNomeBotao    : string  = '';
                                     aIdCategorias : Integer = 0)
                                     : TFDquery;

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
      LogManager.AddLog('Classe Model.Categoria - Linha : 77 - Entrou no Alterar Categoria às ' + DateTimeStr);
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
    qry.SQL.Text:='UPDATE fulanorodas.categorias  ' +
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
        ShowMessage('Ocorreu um erro ao salvar a alteração da categoria: ' + E.Message);
        qry.Connection.Rollback;
        qry.Close;

        if FGravarLogs then
        begin
          LogManager:= TLogManager.Create;
          try
            CurrentDateTime := Now;
            DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
            LogManager.AddLog('Classe Model.Categoria - Linha : 140 - Finalizou o Alterar Categoria finalizou qry às '+ DateTimeStr);
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
      LogManager.AddLog('Classe Model.Categorias: Linha : 172 - Carregar Todas Categorias e criou qry às '+ DateTimeStr);
      LogManager.SaveLogToFile('Log_Model_Categorias.txt');
    finally
      LogManager.Free;
    end;
  end;

  //rever campos ao abrir o formulário de Categorias
  qry:= TFDquery.Create(nil);
  qry.Connection:= TConnection.CreateConnection;
  try
    qry.SQL.Clear;
    qry.SQL.Add('SELECT CA.* FROM CATEGORIAS CA ');

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
      qry.Open;
      Result:= qry;

    end;

    ShowMessage('A qtde. de todos as categorias é de: ' + IntToStr(qry.recordcount));

    if FGravarLogs then
    begin
      LogManager:= TLogManager.Create;
      try
        CurrentDateTime := Now;
        DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
        LogManager.AddLog('Classe Model.Clientes: Linha : 223 - Carregar CATEGORIAS Resultou a qry mas NÂO deu FREE às '+ DateTimeStr);
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
       LogManager.AddLog('Classe na Model.Categoria - Linha 172 - Entrou na Categoria Existe e Criou qry às ' + DateTimeStr);
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
    qry.SQL.Add('SELECT * FROM CATEGORIAS');
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
        LogManager.AddLog('Classe na Model.Categoria - Linha 200 - destruiu a qry às ' + DateTimeStr);
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

class function TModelCategorias.TestaSeCamposPreenchidos(
  aCategoria: TCategorias): Boolean;
begin
  Result := False;

  if Trim(aCategoria.categoria) ='' then
  begin
    raise Exception.Create('É necessário preencher a categoria.');
    Result:= False;
    exit;
  end;

  if Trim(aCategoria.fabricante) = '' then
  begin
    raise Exception.Create('É necessário prencher o fabricante.');
    Result:= False;
    exit;
  end;

  Result:= True;

end;

end.
