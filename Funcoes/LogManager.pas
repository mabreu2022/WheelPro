unit LogManager;

interface

uses
  Sysutils,
  System.Classes,
  System.IniFiles;

type
  TLogManager = class
  private
    FLogList: TStringList;
  public
    CurrentDateTime: TDateTime;
    DateTimeStr: string;
    FGravarLog: Boolean;
    FSomenteAtivos: string;
    FSemContatos  : string;
    FHabilitarLogsSistema: string;
    constructor Create;
    destructor Destroy; override;
    procedure AddLog(const Message: string);
    procedure SaveLogToFile(const FileName: string);
    function GravarLogsnoBanco(aIdRevenda: Integer): Boolean;
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

function TLogManager.GravarLogsnoBanco(aIdRevenda: Integer): Boolean;
begin
  //Gravar na tabelaa Logs o arquivo txt via streamig no campo arquivo Blob
end;

procedure TLogManager.SaveLogToFile(const FileName: string);
begin
  FLogList.SaveToFile(FileName);
end;

end.
