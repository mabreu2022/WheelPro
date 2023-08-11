unit Model.Produtos;

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
  Entity.Produtos,
  System.Generics.Collections,
  Dao.Conexao,
  Datasnap.DBClient,
  LogManager,
  FMX.Dialogs,
  System.IniFiles;

  type
  TModelProduto = class
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
      FProduto: TProduto;

      property SomenteAtivos: string read FSomenteAtivos write SetSomenteAtivos;

      //procedure LimparContatos;
      //create
      Class function SalvarProduto(aProduto: TProduto): Boolean;
      function GravarLogNoBancoDeDados(
                                        const caminhoArquivoLog: string;
                                        anomearquivo: string) : Boolean;

      //Read
      function CarregarProdutos(const AIdProdutos: Integer): TProduto;
      function CarregarTodosProdutos(aDataSet: TClientDataSet;
                                     aSomenteAtivos: string;
                                     aSemContatos: string;
                                     aNomeBotao: string = '';
                                     aIdProduto: Integer = 0)
                                     : TFDquery;
      function ObterProdutoPorId(aId: Integer): TFDQuery;

      //Update
      class function AlterarProduto(aProduto: TProduto): Boolean;

      //Delete
      function RemoverProduto(aProduto: TProduto): Boolean;

      //Regras
      class function TestaSeCamposPreenchidos(aProduto: TProduto): Boolean;
      class function ProdutoExiste(aIdProduto: Integer):Boolean;

      constructor Create;
      destructor destroy;override;

  end;

implementation

{ TModelProduto }

class function TModelProduto.AlterarProduto(aProduto: TProduto): Boolean;
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
      LogManager.AddLog('Classe Model.Produtos - Linha : 114 - Entrou no alterar produto às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Model_Produtos.txt');
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
    qry.SQL.Text:='UPDATE fulanorodas.produtos         ' +
                  'SET                                 ' +
                  'idfabricantes   = :idfabricantes,   ' +
                  'produto         = :produto,         ' +
                  'foto            = :foto,            ' +
                  'preco           = :preco,           ' +
                  'aro             = :aro,             ' +
                  'idfabricante    = :idfabricante,    ' +
                  'datainclusao    = :datainclusao,    ' +
                  'dataalteracao   = :dataalteracao,   ' +
                  'dataexclusao    = :dataexclusao,    ' +
                  'ativo           = :ativo,           ' +
                  'lancamento      = :lancamento,      ' +
                  'furacao         = :furacao,         ' +
                  'offset_et       = :offset_et,       ' +
                  'idlinha         = :idlinha,         ' +
                  'idacabamento    = :idacabamento     ' +
                  'WHERE                               ' +
                  'IDPRODUTOS      = :IDPRODUTOS       ';

    qry.ParamByName('idprodutos').DataType     := ftInteger;
    qry.ParamByName('idclientes').AsInteger    := aProduto.idprodutos;
    qry.ParamByName('produto').DataType        := ftString;
    qry.ParamByName('produto').AsString        := aProduto.produto;


//    qry.ParamByName('foto').DataType           := ftString;
//    qry.ParamByName('foto').AsString           := aProduto.foto;


    qry.ParamByName('preco').DataType          := ftCurrency;
    qry.ParamByName('preco').AsCurrency        := aProduto.preco;
    qry.ParamByName('aro').DataType            := ftInteger;
    qry.ParamByName('aro').AsInteger           := aProduto.aro;
    qry.ParamByName('idfabricante').DataType   := ftInteger;
    qry.ParamByName('idfabricante').AsInteger  := aProduto.idfabricante;
    qry.ParamByName('datainclusao').DataType   := ftDateTime;
    qry.ParamByName('datainclusao').AsDateTime := aProduto.datainclusao;
    qry.ParamByName('dataalteracao').DataType  := ftDateTime;
    qry.ParamByName('dataexclusao').AsDateTime := aProduto.dataexclusao;
    qry.ParamByName('dataexclusao').DataType   := ftDateTime;
    qry.ParamByName('ativo').DataType          := ftString;
    if Length(aProduto.ativo) > 0 then
      Ativo := Copy(aProduto.ativo, 1, 1)
    else
      Ativo := '';

    qry.ParamByName('ativo').AsString          := Ativo;

    qry.ParamByName('lancamento').DataType     := ftString;
    qry.ParamByName('lancamento').AsString     := aProduto.lancamento;
    qry.ParamByName('furacao').Datatype        := ftInteger;
    qry.ParamByName('furacao').AsInteger       := aProduto.furacao;
    qry.ParamByName('offset_et').Datatype      := ftInteger;
    qry.ParamByName('offset_et').AsInteger     := aProduto.OffsetEt;
    qry.ParamByName('idlinha').Datatype        := ftInteger;
    qry.ParamByName('idlinha').AsInteger       := aProduto.idlinha;
    qry.ParamByName('idacabamento').Datatype   := ftInteger;
    qry.ParamByName('idacabamento').AsInteger  := aProduto.idacabamento;


    qry.ParamByName('IDPRODUTOS').DataType     := ftInteger;
    qry.ParamByName('IDPRODUTOS').AsInteger    := aProduto.idprodutos;

    qry.ExecSQL;
    qry.Connection.Commit;  //Gravar no banco

    Result:=True;

  Except
     on E: Exception do
      begin
        ShowMessage('Ocorreu um erro ao alterar o produto: ' + E.Message);
        qry.Connection.Rollback;
        qry.Close;

        if FGravarLogs then
        begin
          LogManager:= TLogManager.Create;
          try
            CurrentDateTime := Now;
            DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
            LogManager.AddLog('Classe Model.Clientes - Linha : 212 - Finalizou o alterar produto finalizou qry às '+ DateTimeStr);
            LogManager.SaveLogToFile('Log_Model_Produtos.txt');
          finally
            LogManager.Free;
          end;
        end;
        qry.Free;
      end;

  end;

end;

class procedure TModelProduto.CarregarFGravarLog;
var
  IniFile : TIniFile;
  Valor   : String;
  Valor2  : string;
begin
  //ler procedure do pode gravar log
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\Config.ini');
  try
    Valor := IniFile.ReadString('Sistema', 'SalvarLogsBancoDeDados', '');
    Valor2:= IniFile.ReadString('Sistema', 'CarregarClientesSemContato', '');  //Rever se é necessário a principio parece que não.

    if Valor = 'S' then
      FGravarLogs := True
    else
      FGravarLogs := False;

    if Valor2 = 'S' then

  finally
    IniFile.Free;
  end;

end;

function TModelProduto.CarregarProdutos(const AIdProdutos: Integer): TProduto;
var
 qry        : TFDQuery;
 LogManager : TLogManager;
begin
  if FGravarLogs then
  begin
    LogManager:= TLogManager.Create;
    try
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Classe Model.Produtos: Linha 123: Entrou na Function Carregar Produtos  e criou qry às '+ DateTimeStr);
      LogManager.SaveLogToFile('Log_Model_Produtos.txt');
    finally
      LogManager.Free;
    end;
  end;

  Result:= Nil;

  qry            := TFDquery.Create(nil);
  qry.Connection := Fconn;
  try
    qry.SQL.Clear;
    qry.SQL.Text:='SELECT P.* FROM PRODUTOS P';
    qry.Open;

    if qry.RecordCount > 0 then
    begin
      FProduto.idProdutos    := qry.FieldByName('idprodutos').AsInteger;
      FProduto.produto       := qry.FieldByName('produto').AsString;

      // Carregar a foto do campo LongBlob em um array de bytes (TBytes)
      if not qry.FieldByName('foto').IsNull then
      begin
         FProduto.foto := TMemoryStream.Create;
         TBlobField(qry.FieldByName('foto')).SaveToStream(FProduto.foto);
         FProduto.foto.Position := 0; // Volte para a posição inicial
      end
      else
        FProduto.foto := nil; // Defina como nil se não houver foto

      FProduto.preco         := qry.FieldByName('preco').AsCurrency;
      FProduto.aro           := qry.FieldByName('complemento').AsInteger;
      FProduto.idfabricante  := qry.FieldByName('idfabricante').AsInteger;
      FProduto.datainclusao  := qry.FieldByName('datainclusao').AsDateTime;
      FProduto.dataalteracao := qry.FieldByName('dataalteracao').AsDateTime;
      FProduto.dataexclusao  := qry.FieldByName('dataexclusao').AsDateTime;
      FProduto.ativo         := qry.FieldByName('ativo').AsString;
      FProduto.lancamento    := qry.FieldByName('lancamento').AsString;
      FProduto.furacao       := qry.FieldByName('furacao').AsInteger;
      FProduto.OffsetEt      := qry.FieldByName('OffsetEt').AsInteger;
      FProduto.idlinha       := qry.FieldByName('idlinha').AsInteger;
      FProduto.idacabamento  := qry.FieldByName('idacabamento').AsInteger;

      Result:= FProduto;
    end;

  finally
     if FGravarLogs then
     begin
       LogManager:= TLogManager.Create;
       try
         CurrentDateTime := Now;
         DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
         LogManager.AddLog('Classe Model.Produtos: Linha 177: Entrou na Function Carregar produtos e criou qry às '+ DateTimeStr);
         LogManager.SaveLogToFile('Log_Model_Produtos.txt');
       finally
         LogManager.Free;
       end;
     end;
     qry.Close;
     qry.Free;
  end;

end;

function TModelProduto.CarregarTodosProdutos(aDataSet: TClientDataSet;
  aSomenteAtivos, aSemContatos, aNomeBotao: string;
  aIdProduto: Integer): TFDquery;
var
  LogManager: TLogManager;
begin
  if FGravarLogs then
  begin
    LogManager:= TLogManager.Create;
    try
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Classe Model.Produtos: Linha : 201 - Carregar Todos Produtos e criou qry às '+ DateTimeStr);
      LogManager.SaveLogToFile('Log_Model_Produtos.txt');
    finally
      LogManager.Free;
    end;
  end;

  //rever campos ao abrir o formulário de clientes
  qry            := TFDquery.Create(nil);
  qry.Connection := TConnection.CreateConnection;
  try
    qry.SQL.Clear;
    qry.SQL.Add('SELECT P.* FROM PRODUTOS P');

    if aSomenteAtivos = 'S' then
      qry.SQL.Add('WHERE P.ATIVO=''S''      ');

    if aNomeBotao = '' then
    begin
      qry.SQL.Add('ORDER BY P.IDPRODUTOS ASC');
      qry.Open;
      qry.First;
      Result:= qry;
    end;

    Result:= qry;

    //ShowMessage('A qtde. de todos os PRODUTOS é de: ' + IntToStr(qry.recordcount));

    if FGravarLogs then
    begin
      LogManager:= TLogManager.Create;
      try
        CurrentDateTime := Now;
        DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
        LogManager.AddLog('Classe Model.Produtos: Linha : 236 - Carregar Produtos Resultou a qry mas NÂO deu FREE às '+ DateTimeStr);
        LogManager.SaveLogToFile('Log_Model_Produtos.txt');
        Result := qry;
      finally
        LogManager.Free;
      end;
    end;

  except
    on E: Exception do
    begin
      ShowMessage('Erro ao carregar todos os produtos' + E.Message);
      Result := nil;
      qry.Free;
    end;
  end;

end;

constructor TModelProduto.Create;
begin

end;

destructor TModelProduto.destroy;
begin

  inherited;
end;

function TModelProduto.GravarLogNoBancoDeDados(const caminhoArquivoLog: string;
  anomearquivo: string): Boolean;
var
  qry           : TFDQuery;
  arquivoStream : TMemoryStream;
  blobStream    : TStream;
begin
  Result := False;

  qry            := TFDQuery.Create(nil);
  qry.Connection := TConnection.CreateConnection;
  qry.Connection.StartTransaction;
  arquivoStream  := TMemoryStream.Create;
  try
    arquivoStream.LoadFromFile(caminhoArquivoLog);

    qry.SQL.Text := 'INSERT INTO logs (arquivo, datainclusao, nomearquivo) VALUES (:arquivo, :datainclusao, :nomearquivo)';

    qry.ParamByName('arquivo').DataType := ftBlob;
    qry.ParamByName('arquivo').LoadFromFile(caminhoArquivoLog, ftBlob);

    qry.ParamByName('datainclusao').AsDateTime := Now;
    qry.ParamByName('nomearquivo').AsString    := anomearquivo;
    qry.ExecSQL;

    Result := True;

  Except
    on E: Exception do
     begin
       Result := False;
       qry.Connection.Rollback;
       ShowMessage('Houve um erro ao tentar gravar o arquivo de Log' + E.Message);
       arquivoStream.Free;
       qry.Close;
       qry.Free;
     end;
  end;


end;

function TModelProduto.ObterProdutoPorId(aId: Integer): TFDQuery;
begin
  Result := nil;

  qry:= TFDQuery.Create(nil);
  qry.Connection:= TConnection.CreateConnection;
  try

    qry.Close;
    qry.SQL.Text := 'SELECT * FROM PRODUTOS ' +
                  'WHERE IDPRODUTOS=:IDPRODUTOS';
    qry.ParamByName('IDPRODUTOS').DataType  := ftInteger;
    qry.ParamByName('IDPRODUTOS').AsInteger := aId;
    qry.Open;

    Result := qry;
  finally
    qry.Free;
  end;

end;

class function TModelProduto.ProdutoExiste(aIdProduto: Integer): Boolean;
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
       LogManager.AddLog('Classe na Model.Produtos - Linha 484 - Entrou na Produto Existe e Criou qry às ' + DateTimeStr);
       LogManager.SaveLogToFile('Log_Model_Produtos.txt');
    finally
      LogManager.Free;
    end;
  End;

  qry:= TFDquery.Create(nil);
  qry.Connection:= TConnection.CreateConnection;
  try
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM PRODUTOS');
    qry.SQL.Add('WHERE IDPRODUTOS=:IDPRODUTOS');
    qry.ParamByName('IDPRODUTOS').DataType := FTiNTEGER;
    qry.ParamByName('IDPRODUTOS').AsInteger := aIdProduto;
    qry.Open;

    if qry.RecordCount > 0 then
      Result:= True;

  finally
    qry.Free;
  end;

end;

function TModelProduto.RemoverProduto(aProduto: TProduto): Boolean;
var
  Ativo: string;
begin
  Result := False;

  qry:= TFDQuery.Create(nil);
  qry.Connection:= TConnection.CreateConnection;
  qry.Connection.StartTransaction;
  try

    qry.Close;
    qry.SQL.Text := 'UPDATE fulanorodas.produtos ' +
                    'SET                         ' +
                    'ativo       = ''N''         ' +
                    'WHERE IDPRODUTOS=:IDPRODUTOS';
    qry.ParamByName('IDPRODUTOS').DataType:= ftInteger;
    qry.ParamByName('IDPRODUTOS').AsInteger:= aProduto.idprodutos;

    qry.ExecSQL;
    qry.Connection.Commit;

    Result := True;

  Except
    on E: Exception do
    begin
      Result := False;
      qry.Connection.Rollback;
      ShowMessage('Houve um erro ao tentar Deletar o produto' + E.Message);
      qry.Close;
      qry.Free;
    end;
  end;


end;

class function TModelProduto.SalvarProduto(aProduto: TProduto): Boolean;
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
                ' fulanorodas.Produtos ' +
                '(idprodutos,          ' +   //1
                'produto,              ' +   //2
                'foto,                 ' +   //3
                'preco,                ' +   //4
                'aro,                  ' +   //5
                'idFabricante,         ' +   //6
                'datainclusao,         ' +   //7
                'dataalteracao,        ' +   //8
                'dataexclusao,         ' +   //9
                'ativo,                ' +   //10
                'lancamento,           ' +   //11
                'furacao,              ' +   //12
                'offset_et,            ' +   //13
                'idlinha,              ' +   //14
                'idacabamento          ' +   //15
                ')                     ' +
                'VALUES (              ' +
                ':idprodutos,          ' +   //1 ok
                ':produto,             ' +   //2 ok
                ':foto,                ' +   //3 ok
                ':preco,               ' +   //4 ok
                ':aro,                 ' +   //5 ok
                ':idFabricante,        ' +   //6 ok
                ':datainclusao,        ' +   //7 ok
                ':dataalteracao,       ' +   //8 ok
                ':dataexclusao,        ' +   //9 ok
                ':ativo,               ' +   //10 ok
                ':lancamento,          ' +   //11 ok
                ':furacao,             ' +   //12 ok
                ':offset_et,           ' +   //13 ok
                ':idlinha,             ' +   //14 ok
                ':idacabamento         ' +   //15 ok
                ')                     ');

     qry.ParamByName('idprodutos').DataType    := ftInteger;               //1

     qry.ParamByName('produto').DataType         := ftString;
     qry.ParamByName('produto').AsString         := aProduto.produto;      //2
     qry.ParamByName('foto').DataType            := ftStream;
     qry.ParamByName('foto').AsStream            := aProduto.foto;         //3 - Verificar
     qry.ParamByName('preco').DataType           := ftCurrency;
     qry.ParamByName('preco').AsCurrency         := aProduto.preco;        //4
     qry.ParamByName('aro').DataType             := ftInteger;
     qry.ParamByName('aro').AsInteger            := aProduto.aro;          //5
     qry.ParamByName('idfabricante').DataType    := ftInteger;
     qry.ParamByName('idfabricante').AsInteger   := aProduto.idfabricante; //6
     qry.ParamByName('datainclusao').DataType    := ftDateTime;
     qry.ParamByName('datainclusao').AsDateTime  := Now;                   //7
     qry.ParamByName('dataalteracao').DataType   := ftDateTime;
     qry.ParamByName('dataalteracao').AsDateTime := Now;                   //8
     //qry.ParamByName('dataexclusao').DataType    := ftDateTime;
     //qry.ParamByName('dataexclusao').AsDateTime  := Now;                 //9

     qry.ParamByName('ativo').DataType           := ftString;
     if Length(aProduto.ativo) > 0 then
       Ativo := Copy(aProduto.ativo, 1, 1)
     else
       Ativo := '';

     qry.ParamByName('ativo').AsString           := Ativo;                 //10

     qry.ParamByName('lancamento').DataType      := ftString;
     qry.ParamByName('lancamento').AsString      := aProduto.lancamento;   //11
     qry.ParamByName('furacao').DataType         := ftInteger;
     qry.ParamByName('furacao').AsInteger        := aProduto.furacao;      //12
     qry.ParamByName('offset_et').DataType       := ftInteger;
     qry.ParamByName('offset_et').AsInteger      := aProduto.OffsetEt;     //13
     qry.ParamByName('idlinha').DataType         := ftInteger;
     qry.ParamByName('idlinha').AsInteger        := aProduto.idlinha;      //14
     qry.ParamByName('idacabamento').DataType    := ftInteger;
     qry.ParamByName('idacabamento').AsInteger   := aProduto.idacabamento; //15

     CarregarFGravarLog;

     if FGravarLogs then
       qry.SQL.SaveToFile('C:\ProdutosSQL.txt');

     qry.ExecSQL;
     qry.Connection.Commit;

     Result := True;
  Except
     on E: Exception do
      begin
        Result := False;
        ShowMessage('Ocorreu um erro ao salvar o produto: ' + E.Message);
        qry.Connection.Rollback;
        qry.Close;

        if True then
        begin
          LogManager:= TLogManager.Create;
          try
            CurrentDateTime := Now;
            DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
            LogManager.AddLog('Classe Model.Produtos - Linha : 271 - Finalizou o salvar produto finalizou qry às ' + DateTimeStr);
            LogManager.SaveLogToFile('Log_Model_Produtos.txt');
          finally
            LogManager.Free;
          end;
        end;
        qry.Free;
      end;
  end;

end;

procedure TModelProduto.SetSomenteAtivos(const Value: string);
begin
  FSomenteAtivos := Value;
end;

class function TModelProduto.TestaSeCamposPreenchidos(
  aProduto: TProduto): Boolean;
begin

end;

end.
