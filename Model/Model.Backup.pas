unit Model.Backup;

interface

uses
  System.SysUtils,
  System.IOUtils,
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
  Winapi.ShellAPI,
  Winapi.Windows,
  FireDAC.Phys.MySQLDef,
  FireDAC.Phys.MySQLWrapper;

type
  TBackup = class
    private
    FBackupPath: string;
    Fdatabase: string;
    Fpassword: string;
    Fuser: string;
    procedure SetBackupPath(const Value: string);
    procedure Setdatabase(const Value: string);
    procedure Setpassword(const Value: string);
    procedure Setuser(const Value: string);

    public
      FConn: TFDConnection;
      property user       : string read Fuser write Setuser;
      property password   : string read Fpassword write Setpassword;
      property database   : string read Fdatabase write Setdatabase;
      property BackupPath : string read FBackupPath write SetBackupPath;
      function  BackupMySQLDatabase(const host, user, password, database, backupPath, dumpFileName: string): Boolean;
      function RestoreMySQLBackup(const host, user, password, database,
  backupFilePath: string; DumpFileName: string): Boolean;
  end;

implementation

{ TBackup }

function TBackup.BackupMySQLDatabase(const host, user, password, database, backupPath, dumpFileName: string): Boolean;
var
  DumpFilePath : string;
  Command      : string;
  LogManager  : TLogManager;
begin
  Result := False;

  try
    // Verifica se o diretório de backup existe, caso contrário, cria-o
    if not DirectoryExists(backupPath) then
      ForceDirectories(backupPath);

    // Define o caminho completo do arquivo de dump
    DumpFilePath := TPath.Combine(backupPath, dumpFileName);
    DumpFilePath := StringReplace(DumpFilePath, '/', '_', [rfReplaceAll]);

    // Constrói o comando mysqldump
    Command := Format('mysqldump.exe -h%s -u%s -p%s %s --result-file="%s"', [host, user, password, database, DumpFilePath]);

    // Executa o comando
    if ShellExecute(0, 'open', 'cmd.exe', PChar('/C ' + Command), nil, SW_HIDE) > 32 then
    begin
      Result := True;
      // inserir rotina de gravar em uma tabela no banco o arquivo físico.
      LogManager:= TLogManager.Create;
      try
        LogManager.GravarLogNoBancoDeDados(backupPath, StringReplace(dumpFileName, '/', '_', [rfReplaceAll]), 'logs');
      finally
        LogManager.Free;
      end;
    end;
  except
    on E: Exception do
      ShowMessage('Erro durante o backup do banco de dados: ' + E.Message);
  end;
end;

function TBackup.RestoreMySQLBackup(const host, user, password, database,
  backupFilePath: string; DumpFileName: string): Boolean;
var
  command: string;
begin
  try
    // Constrói o comando para restaurar o backup
    command := Format('mysql -h%s -u%s -p%s %s < "%s"', [host, user, password, database, backupFilePath+DumpFileName]);

    // Executa o comando
    if ShellExecute(0, 'open', 'cmd.exe', PChar('/C ' + command), nil, SW_HIDE) > 32 then
    begin
      Result := True; // Restauração iniciada com sucesso
      ShowMessage('Backup Restaurado com sucesso!');
    end
    else
    begin
      Result := False; // Falha ao iniciar a restauração
      ShowMessage('Falha ao iniciar a restauração');
    end;
  except
    on E: Exception do
    begin
      ShowMessage('Erro durante a restauração do banco de dados: ' + E.Message);
      Result := False;
    end;
  end;

end;

procedure TBackup.SetBackupPath(const Value: string);
begin
  FBackupPath := Value;
end;

procedure TBackup.Setdatabase(const Value: string);
begin
  Fdatabase := Value;
end;

procedure TBackup.Setpassword(const Value: string);
begin
  Fpassword := Value;
end;

procedure TBackup.Setuser(const Value: string);
begin
  Fuser := Value;
end;

end.
