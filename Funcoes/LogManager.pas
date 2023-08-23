unit LogManager;

interface

uses
  System.Sysutils,
  System.Classes,
  System.IniFiles,
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
  Dao.Conexao,
  FMX.Dialogs;

type
  TLogManager = class
  private
    FLogList: TStringList;
  public
    CurrentDateTime        : TDateTime;
    DateTimeStr            : string;
    FGravarLog             : Boolean;
    FSomenteAtivos         : string;
    FSomenteProdutosAtivos : string;
    FSemContatos           : string;
    FHabilitarLogsSistema  : string;
    constructor Create;
    destructor Destroy; override;
    procedure AddLog(const Message: string);
    procedure SaveLogToFile(const FileName: string);
    function GravarLogNoBancoDeDados(
  const caminhoArquivoLog: string; anomearquivo: string; aTabela: string) : Boolean;
    procedure CarregarConfiguracao;

  end;

implementation

{ TLogManager }

procedure TLogManager.AddLog(const Message: string);
begin
  FLogList.Add(Message);
end;

procedure TLogManager.CarregarConfiguracao;
var
   IniFile    : TIniFile;
   LogManager : TLogManager;
begin
  if FGravarLog then
  begin
    LogManager:= TLogManager.Create;
    try
      CurrentDateTime := Now;
      DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
      LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 50 - Carregar Configuração - Criou o IniFile às ' + DateTimeStr);
      LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');
    finally
      LogManager.Free;
    end;
  end;

  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\Config.ini');
  try
    FSomenteAtivos        := IniFile.ReadString('Sistema', 'carregaclientesativosn', '');
    FSomenteProdutosAtivos:= IniFile.ReadString('Sistema', 'CarregarProdutosAtivos', '');
    FSemContatos          := IniFile.ReadString('Sistema', 'CarregarClientesSemContato', '');
    FHabilitarLogsSistema := IniFile.ReadString('HabilitarLogs', 'HabilitarLogsSistema', '');
  finally
    if FGravarLog then
    begin
      LogManager := TLogManager.Create;
      try
        CurrentDateTime := Now;
        DateTimeStr     := FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDateTime);
        LogManager.AddLog('Tela - Cadastro de Clientes: Linha : 69 - Carregar Configuração - Deu Free no IniFile às ' + DateTimeStr);
        LogManager.SaveLogToFile('Log_Cadastro_de_Clientes.txt');

      finally
        LogManager.Free;
      end;

    end;
    IniFile.Free;
  end;


end;

constructor TLogManager.Create;
begin
  FLogList := TStringList.Create;
end;

destructor TLogManager.Destroy;
begin
  FLogList.Free;
  inherited;
end;

function TLogManager.GravarLogNoBancoDeDados(
  const caminhoArquivoLog: string; anomearquivo: string; aTabela: string) : Boolean;
var
  qry: TFDQuery;
  arquivoStream: TMemoryStream;
  ArquivoParaGravar: string;
begin
  Result := False;

  qry := TFDQuery.Create(nil);
  qry.Connection := TConnection.CreateConnection;
  qry.Connection.StartTransaction;
  arquivoStream := TMemoryStream.Create;
  try
    ArquivoParaGravar := caminhoArquivoLog + aNomeArquivo;
    arquivoStream.LoadFromFile(ArquivoParaGravar);

    qry.SQL.Text := 'INSERT INTO ' + aTabela +
      ' (arquivo, datainclusao, nomearquivo) VALUES (:arquivo, :datainclusao, :nomearquivo)';

    qry.ParamByName('arquivo').LoadFromStream(arquivoStream, ftBlob); // Use LoadFromStream with ftBlob type

    qry.ParamByName('datainclusao').AsDateTime := Now;
    qry.ParamByName('nomearquivo').AsString := anomearquivo;
    qry.ExecSQL;

    qry.Connection.Commit;
    Result := True;
  except
    on E: Exception do
    begin
      Result := False;
      qry.Connection.Rollback;
      ShowMessage('Houve um erro ao tentar gravar o arquivo de Log: ' + E.Message);
    end;
  end;

  qry.Close;
  qry.Free;
  arquivoStream.Free;

end;

procedure TLogManager.SaveLogToFile(const FileName: string);
begin
  FLogList.SaveToFile(FileName);
end;

end.
